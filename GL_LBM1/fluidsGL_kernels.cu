/*
 * Copyright 1993-2010 NVIDIA Corporation.  All rights reserved.
 *
 * Please refer to the NVIDIA end user license agreement (EULA) associated
 * with this source code for terms and conditions that govern your use of
 * this software. Any use, reproduction, disclosure, or distribution of
 * this software and related documentation outside the terms of the EULA
 * is strictly prohibited.
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include "cutil_inline.h"

// CUDA FFT Libraries
#include <cufft.h>

// OpenGL Graphics includes
#include <GL/glew.h>
#if defined(__APPLE__) || defined(MACOSX)
#include <GLUT/glut.h>
#else
#include <GL/freeglut.h>
#endif

// FluidsGL CUDA kernel definitions
#include "fluidsGL_kernels.cuh"

// Texture reference for reading velocity field
texture<float2, 2> texref;
static cudaArray *array = NULL;

// Particle data
extern GLuint vbo;                 // OpenGL vertex buffer object
extern struct cudaGraphicsResource *cuda_vbo_resource; // handles OpenGL-CUDA exchange

// Texture pitch
extern size_t tPitch;
extern cufftHandle planr2c;
extern cufftHandle planc2r;
extern cData *vxfield = NULL;
extern cData *vyfield = NULL;

void setupTexture(int x, int y) {
    // Wrap mode appears to be the new default
    texref.filterMode = cudaFilterModeLinear;
    cudaChannelFormatDesc desc = cudaCreateChannelDesc<float2>();

    cudaMallocArray(&array, &desc, y, x);
    cutilCheckMsg("cudaMalloc failed");
}

void bindTexture(void) {
    cudaBindTextureToArray(texref, array);
    cutilCheckMsg("cudaBindTexture failed");
}

void unbindTexture(void) {
    cudaUnbindTexture(texref);
}
    
void updateTexture(cData *data, size_t wib, size_t h, size_t pitch) {
    cudaMemcpy2DToArray(array, 0, 0, data, pitch, wib, h, cudaMemcpyDeviceToDevice);
    cutilCheckMsg("cudaMemcpy failed"); 
}

void deleteTexture(void) {
    cudaFreeArray(array);
}

// Note that these kernels are designed to work with arbitrary 
// domain sizes, not just domains that are multiples of the tile
// size. Therefore, we have extra code that checks to make sure
// a given thread location falls within the domain boundaries in
// both X and Y. Also, the domain is covered by looping over
// multiple elements in the Y direction, while there is a one-to-one
// mapping between threads in X and the tile size in X.
// Nolan Goodnight 9/22/06

// This method adds constant force vectors to the velocity field 
// stored in 'v' according to v(x,t+1) = v(x,t) + dt * f.
__global__ void 
addForces_k(cData *v, int dx, int dy, int spx, int spy, float fx, float fy, int r, size_t pitch) {

    int tx = threadIdx.x;
    int ty = threadIdx.y;
    cData *fj = (cData*)((char*)v + (ty + spy) * pitch) + tx + spx;

    cData vterm = *fj;
    tx -= r; ty -= r;
    float s = 1.f / (1.f + tx*tx*tx*tx + ty*ty*ty*ty);
    vterm.x += s * fx;
    vterm.y += s * fy;
    *fj = vterm;
}

// This method performs the velocity advection step, where we
// trace velocity vectors back in time to update each grid cell.
// That is, v(x,t+1) = v(p(x,-dt),t). Here we perform bilinear
// interpolation in the velocity space.
__global__ void 
advectVelocity_k(cData *v, float *vx, float *vy,
                 int dx, int pdx, int dy, float dt, int lb) {

    int gtidx = blockIdx.x * blockDim.x + threadIdx.x;
    int gtidy = blockIdx.y * (lb * blockDim.y) + threadIdx.y * lb;
    int p;

    cData vterm, ploc;
    float vxterm, vyterm;
    // gtidx is the domain location in x for this thread
    if (gtidx < dx) {
        for (p = 0; p < lb; p++) {
            // fi is the domain location in y for this thread
            int fi = gtidy + p;
            if (fi < dy) {
                int fj = fi * pdx + gtidx;
                vterm = tex2D(texref, (float)gtidx, (float)fi);
                ploc.x = (gtidx + 0.5f) - (dt * vterm.x * dx);
                ploc.y = (fi + 0.5f) - (dt * vterm.y * dy);
                vterm = tex2D(texref, ploc.x, ploc.y);
                vxterm = vterm.x; vyterm = vterm.y; 
                vx[fj] = vxterm;
                vy[fj] = vyterm; 
            }
        }
    }
}

// This method performs velocity diffusion and forces mass conservation 
// in the frequency domain. The inputs 'vx' and 'vy' are complex-valued 
// arrays holding the Fourier coefficients of the velocity field in
// X and Y. Diffusion in this space takes a simple form described as:
// v(k,t) = v(k,t) / (1 + visc * dt * k^2), where visc is the viscosity,
// and k is the wavenumber. The projection step forces the Fourier
// velocity vectors to be orthogonal to the vectors for each
// wavenumber: v(k,t) = v(k,t) - ((k dot v(k,t) * k) / k^2.
__global__ void 
diffuseProject_k(cData *vx, cData *vy, int dx, int dy, float dt, 
                 float visc, int lb) {

    int gtidx = blockIdx.x * blockDim.x + threadIdx.x;
    int gtidy = blockIdx.y * (lb * blockDim.y) + threadIdx.y * lb;
    int p;

    cData xterm, yterm;
    // gtidx is the domain location in x for this thread
    if (gtidx < dx) {
        for (p = 0; p < lb; p++) {
            // fi is the domain location in y for this thread
            int fi = gtidy + p;
            if (fi < dy) {
                int fj = fi * dx + gtidx;
                xterm = vx[fj];
                yterm = vy[fj];

                // Compute the index of the wavenumber based on the
                // data order produced by a standard NN FFT.
                int iix = gtidx;
                int iiy = (fi>dy/2)?(fi-(dy)):fi;

                // Velocity diffusion
                float kk = (float)(iix * iix + iiy * iiy); // k^2 
                float diff = 1.f / (1.f + visc * dt * kk);
                xterm.x *= diff; xterm.y *= diff;
                yterm.x *= diff; yterm.y *= diff;

                // Velocity projection
                if (kk > 0.f) {
                    float rkk = 1.f / kk;
                    // Real portion of velocity projection
                    float rkp = (iix * xterm.x + iiy * yterm.x);
                    // Imaginary portion of velocity projection
                    float ikp = (iix * xterm.y + iiy * yterm.y);
                    xterm.x -= rkk * rkp * iix;
                    xterm.y -= rkk * ikp * iix;
                    yterm.x -= rkk * rkp * iiy;
                    yterm.y -= rkk * ikp * iiy;
                }
                
                vx[fj] = xterm;
                vy[fj] = yterm;
            }
        }
    }
}

// This method updates the velocity field 'v' using the two complex 
// arrays from the previous step: 'vx' and 'vy'. Here we scale the 
// real components by 1/(dx*dy) to account for an unnormalized FFT. 
__global__ void 
updateVelocity_k(cData *v, float *vx, float *vy, 
                 int dx, int pdx, int dy, int lb, size_t pitch) {

    int gtidx = blockIdx.x * blockDim.x + threadIdx.x;
    int gtidy = blockIdx.y * (lb * blockDim.y) + threadIdx.y * lb;
    int p;

    float vxterm, vyterm;
    cData nvterm;
    // gtidx is the domain location in x for this thread
    if (gtidx < dx) {
        for (p = 0; p < lb; p++) {
            // fi is the domain location in y for this thread
            int fi = gtidy + p;
            if (fi < dy) {
                int fjr = fi * pdx + gtidx; 
                vxterm = vx[fjr];
                vyterm = vy[fjr];

                // Normalize the result of the inverse FFT
                float scale = 1.f / (dx * dy);
                nvterm.x = vxterm * scale;
                nvterm.y = vyterm * scale;
               
                cData *fj = (cData*)((char*)v + fi * pitch) + gtidx;
                *fj = nvterm;
            }
        } // If this thread is inside the domain in Y
    } // If this thread is inside the domain in X
}

// This method updates the particles by moving particle positions
// according to the velocity field and time step. That is, for each
// particle: p(t+1) = p(t) + dt * v(p(t)).  
__global__ void 
advectParticles_k(cData *part, cData *v, int dx, int dy, 
                  float dt, int lb, size_t pitch) {

    int gtidx = blockIdx.x * blockDim.x + threadIdx.x;
    int gtidy = blockIdx.y * (lb * blockDim.y) + threadIdx.y * lb;
    int p;

    // gtidx is the domain location in x for this thread
    cData pterm, vterm;
    if (gtidx < dx) {
        for (p = 0; p < lb; p++) {
            // fi is the domain location in y for this thread
            int fi = gtidy + p;
            if (fi < dy) {
                int fj = fi * dx + gtidx;
                pterm = part[fj];
                
                int xvi = ((int)(pterm.x * dx));
                int yvi = ((int)(pterm.y * dy));
                vterm = *((cData*)((char*)v + yvi * pitch) + xvi);   
 
                pterm.x += dt * vterm.x;
                pterm.x = pterm.x - (int)pterm.x;            
                pterm.x += 1.f; 
                pterm.x = pterm.x - (int)pterm.x;              
                pterm.y += dt * vterm.y;
                pterm.y = pterm.y - (int)pterm.y;            
                pterm.y += 1.f; 
                pterm.y = pterm.y - (int)pterm.y;                  

                part[fj] = pterm;
            }
        } // If this thread is inside the domain in Y
    } // If this thread is inside the domain in X
}


// These are the external function calls necessary for launching fluid simuation
extern "C"
void addForces(cData *v, int dx, int dy, int spx, int spy, float fx, float fy, int r) { 

    dim3 tids(2*r+1, 2*r+1);
    
    addForces_k<<<1, tids>>>(v, dx, dy, spx, spy, fx, fy, r, tPitch);
    cutilCheckMsg("addForces_k failed.");
}

extern "C"
void advectVelocity(cData *v, float *vx, float *vy, int dx, int pdx, int dy, float dt) 
{ 
    dim3 grid((dx/TILEX)+(!(dx%TILEX)?0:1), (dy/TILEY)+(!(dy%TILEY)?0:1));

    dim3 tids(TIDSX, TIDSY);

    updateTexture(v, DIM*sizeof(cData), DIM, tPitch);
    advectVelocity_k<<<grid, tids>>>(v, vx, vy, dx, pdx, dy, dt, TILEY/TIDSY);

    cutilCheckMsg("advectVelocity_k failed.");
}

extern "C"
void diffuseProject(cData *vx, cData *vy, int dx, int dy, float dt, float visc) 
{ 
    // Forward FFT
    cufftExecR2C(planr2c, (cufftReal*)vx, (cufftComplex*)vx); 
    cufftExecR2C(planr2c, (cufftReal*)vy, (cufftComplex*)vy);

    uint3 grid = make_uint3((dx/TILEX)+(!(dx%TILEX)?0:1), 
                            (dy/TILEY)+(!(dy%TILEY)?0:1), 1);
    uint3 tids = make_uint3(TIDSX, TIDSY, 1);
    
    diffuseProject_k<<<grid, tids>>>(vx, vy, dx, dy, dt, visc, TILEY/TIDSY);
    cutilCheckMsg("diffuseProject_k failed.");

    // Inverse FFT
    cufftExecC2R(planc2r, (cufftComplex*)vx, (cufftReal*)vx); 
    cufftExecC2R(planc2r, (cufftComplex*)vy, (cufftReal*)vy);
}

extern "C"
void updateVelocity(cData *v, float *vx, float *vy, int dx, int pdx, int dy) 
{ 
    dim3 grid((dx/TILEX)+(!(dx%TILEX)?0:1), (dy/TILEY)+(!(dy%TILEY)?0:1));
    dim3 tids(TIDSX, TIDSY);

    updateVelocity_k<<<grid, tids>>>(v, vx, vy, dx, pdx, dy, TILEY/TIDSY, tPitch);
    cutilCheckMsg("updateVelocity_k failed.");
}

extern "C"
void advectParticles(GLuint vbo, cData *v, int dx, int dy, float dt) 
{
    dim3 grid((dx/TILEX)+(!(dx%TILEX)?0:1), (dy/TILEY)+(!(dy%TILEY)?0:1));
    dim3 tids(TIDSX, TIDSY);

    cData *p;
    cutilSafeCall(cudaGraphicsMapResources(1, &cuda_vbo_resource, 0));
    size_t num_bytes; 
    cutilSafeCall(cudaGraphicsResourceGetMappedPointer((void **)&p, &num_bytes,  
						       cuda_vbo_resource));
    cutilCheckMsg("cudaGraphicsResourceGetMappedPointer failed");
   
    advectParticles_k<<<grid, tids>>>(p, v, dx, dy, dt, TILEY/TIDSY, tPitch);
    cutilCheckMsg("advectParticles_k failed.");
    
    cutilSafeCall(cudaGraphicsUnmapResources(1, &cuda_vbo_resource, 0));

    cutilCheckMsg("cudaGraphicsUnmapResources failed");
}





////////

int Xcoord(int i, int XDim){
	int B = BLOCKSIZE*BLOCKSIZE;
	return (i%B)%BLOCKSIZE+((i/B)%(XDim/BLOCKSIZE))*BLOCKSIZE;
}
int Ycoord(int i, int XDim){
	int B = BLOCKSIZE*BLOCKSIZE;
	return (i%B)/BLOCKSIZE+((i/B)/(XDim/BLOCKSIZE))*BLOCKSIZE;
}

__global__ void mrt_d(float *f0, float *f1, float *f2,
							float *f3, float *f4, float *f5,
							float *f6, float *f7, float *f8,
							int n, int *image, float omega, float uMax)
{
	int i,m,j,k;
	j = threadIdx.y*blockDim.x+threadIdx.x;//local block index (for shared mem)
	i = j+blockDim.x*blockDim.y*gridDim.x*blockIdx.y;
	i += blockDim.x*blockDim.y*blockIdx.x;//global memory index
	m = blockDim.x*blockDim.y;
	//m = BLOCKSIZE*BLOCKSIZE;
	
	__shared__ float f0_s[(BLOCKSIZE)*(BLOCKSIZE)+1];
	__shared__ float f1_s[(BLOCKSIZE)*(BLOCKSIZE)+1];
	__shared__ float f2_s[(BLOCKSIZE)*(BLOCKSIZE)+1];
	__shared__ float f3_s[(BLOCKSIZE)*(BLOCKSIZE)+1];
	__shared__ float f4_s[(BLOCKSIZE)*(BLOCKSIZE)+1];
	__shared__ float f5_s[(BLOCKSIZE)*(BLOCKSIZE)+1];
	__shared__ float f6_s[(BLOCKSIZE)*(BLOCKSIZE)+1];
	__shared__ float f7_s[(BLOCKSIZE)*(BLOCKSIZE)+1];
	__shared__ float f8_s[(BLOCKSIZE)*(BLOCKSIZE)+1];
	__shared__ int image_s[(BLOCKSIZE)*(BLOCKSIZE)+1];

	f0_s[j] = f0[i];
	f1_s[j] = f1[i];
	f2_s[j] = f2[i];
	f3_s[j] = f3[i];
	f4_s[j] = f4[i];
	f5_s[j] = f5[i];
	f6_s[j] = f6[i];
	f7_s[j] = f7[i];
	f8_s[j] = f8[i];
	image_s[j] = image[i];
	
	//1
	if(threadIdx.x == blockDim.x-1 && blockIdx.x != 0){
		f1_s[j] = f1[i-m];
		f5_s[j] = f5[i-m];
		f8_s[j] = f8[i-m];
	}
	//3
	if(threadIdx.x == 0 && blockIdx.x != gridDim.x-1){
		f3_s[j] = f3[i+m];
		f7_s[j] = f7[i+m];
		f6_s[j] = f6[i+m];
	}
	//2
	if(threadIdx.y == blockDim.y-1 && blockIdx.y != 0){
		f2_s[j] = f2[i-m*gridDim.x];
		f5_s[j] = f5[i-m*gridDim.x];
		f6_s[j] = f6[i-m*gridDim.x];
	}
	//4
	if(threadIdx.y == 0 && blockIdx.y != gridDim.y-1){
		f4_s[j] = f4[i+m*gridDim.x];
		f7_s[j] = f7[i+m*gridDim.x];
		f8_s[j] = f8[i+m*gridDim.x];
	}
	//5
	if(threadIdx.y == blockDim.y-1 && threadIdx.x == blockDim.x-1 &&
		blockIdx.x != 0 && blockIdx.y != 0)//upper corner
		f5_s[j] = f5[i-m*(1+gridDim.x)];
	//7
	if(threadIdx.y == 0 && threadIdx.x == 0 &&
		blockIdx.x != gridDim.x-1 && blockIdx.y != gridDim.y-1)
		f7_s[j] = f7[i+m*(1+gridDim.x)];
	//6
	if(threadIdx.y == blockDim.y-1 && threadIdx.x == 0 &&
		blockIdx.x != gridDim.x-1 && blockIdx.y != 0)
		f6_s[j] = f6[i-m*(gridDim.x-1)];
	//8
	if(threadIdx.y == 0 && threadIdx.x == blockDim.x-1 &&
		blockIdx.x != 0 && blockIdx.y != gridDim.y-1)
		f8_s[j] = f8[i+m*(gridDim.x-1)];


	__syncthreads();

	//STREAM
	//j = (i+1) & (m-1);//equiv to (i+1)%(m), if m is pow of 2;
	//j = (i+1)-blockDim.x*(threadIdx.x==blockDim.x-1);//equiv to (i+1)%(m), if m is pow of 2;
	if((j+1)%(blockDim.x)==0) k=j-blockDim.x+1;
	else k=j+1;
	float temp = f3_s[k];
	f3_s[k]=f1_s[j];
	f1_s[j]=temp;
	k = (j+blockDim.x) & (m-1);//equiv to (i+1)%(m), if m is pow of 2;
	temp = f4_s[k];
	f4_s[k]=f2_s[j];
	f2_s[j]=temp;
	if((j+1)%(blockDim.x)==0) k=(j+1) & (m-1);
	else k = (j+blockDim.x+1) & (m-1);//equiv to (i+1)%(m), if m is pow of 2;
	temp = f7_s[k];
	f7_s[k]=f5_s[j];
	f5_s[j]=temp;
	if((j)%(blockDim.x)==0) k=(j+2*blockDim.x-1) & (m-1);
	else k = (j+blockDim.x-1) & (m-1);//equiv to (i+1)%(m), if m is pow of 2;
	temp = f8_s[k];
	f8_s[k]=f6_s[j];
	f6_s[j]=temp;

	__syncthreads();

	if(image_s[j] != 1){
	temp = f3_s[j];
	f3_s[j]=f1_s[j];
	f1_s[j]=temp;
	temp = f4_s[j];
	f4_s[j]=f2_s[j];
	f2_s[j]=temp;
	temp = f7_s[j];
	f7_s[j]=f5_s[j];
	f5_s[j]=temp;
	temp = f8_s[j];
	f8_s[j]=f6_s[j];
	f6_s[j]=temp;

	
	//float u,v,rho,feq,usqr;
	float u,v,rho,usqr;
	float m1,m2,m4,m6,m7,m8;
	float meq1,meq2,meq4,meq6,meq7,meq8;
	rho = f0_s[j]+f1_s[j]+f2_s[j]+f3_s[j]+f4_s[j]+f5_s[j]+f6_s[j]+f7_s[j]+f8_s[j];
	u = f1_s[j]-f3_s[j]+f5_s[j]-f6_s[j]-f7_s[j]+f8_s[j];
	v = f2_s[j]-f4_s[j]+f5_s[j]+f6_s[j]-f7_s[j]-f8_s[j];
	if(image_s[j] == 2){
		u = 0.0f;
		v = uMax;
		rho = u+(f0_s[j]+f2_s[j]+f4_s[j]+2.0f*f3_s[j]+2.0f*f6_s[j]+2.0f*f7_s[j]);
		f1_s[j] = f3_s[j]+4.0f*u/6.0f;
        f5_s[j] = f7_s[j]-0.5f*(f2_s[j]-f4_s[j])+v*0.5f+u/6.0f;
        f8_s[j] = f6_s[j]+0.5f*(f2_s[j]-f4_s[j])-v*0.5f+u/6.0f;	
	}
	else if(image_s[j] == 3){//north
		u = uMax;
		v = 0.0f;
		rho = -v+(f0_s[j]+f1_s[j]+f3_s[j]+2.0f*f6_s[j]+2.0f*f2_s[j]+2.0f*f5_s[j]);
		f4_s[j] = f2_s[j]-4.0f*v/6.0f;
        f7_s[j] = f5_s[j]+0.5f*(f1_s[j]-f3_s[j])-u*0.5f+v/6.0f;
        f8_s[j] = f6_s[j]-0.5f*(f1_s[j]-f3_s[j])+u*0.5f+v/6.0f;	
	}
	usqr = u*u+v*v;

		meq1 = -2.0f*rho+3.0f*usqr;//e_eq (uses rho, Yu)
		meq2 = rho-3.0f*usqr; //epsilon_eq (uses rho, Yu)
		meq4 = -u;//qx_eq
		meq6 = -v;//qy_eq
		meq7 = u*u-v*v;//pxx_eq
		meq8 = u*v;//pxy_eq

		m1 =-4.f*f0_s[j]+-1.f*f1_s[j]+-1.f*f2_s[j]+-1.f*f3_s[j]+-1.f*f4_s[j]+ 2.f*f5_s[j]+ 2.f*f6_s[j]+ 2.f*f7_s[j]+ 2.f*f8_s[j];
		m2 = 4.f*f0_s[j]+-2.f*f1_s[j]+-2.f*f2_s[j]+-2.f*f3_s[j]+-2.f*f4_s[j]+ 1.f*f5_s[j]+ 1.f*f6_s[j]+ 1.f*f7_s[j]+ 1.f*f8_s[j];
		m4 =             -2.f*f1_s[j]             + 2.f*f3_s[j]             + 1.f*f5_s[j]+-1.f*f6_s[j]+-1.f*f7_s[j]+ 1.f*f8_s[j];
		m6 =                          -2.f*f2_s[j]             + 2.f*f4_s[j]+ 1.f*f5_s[j]+ 1.f*f6_s[j]+-1.f*f7_s[j]+-1.f*f8_s[j];
		m7 =              1.f*f1_s[j]+-1.f*f2_s[j]+ 1.f*f3_s[j]+-1.f*f4_s[j]                                                    ;
		m8 =                                                                  1.f*f5_s[j]+-1.f*f6_s[j]+ 1.f*f7_s[j]+-1.f*f8_s[j];

		float Q11 = (m7-meq7)*0.5f;
		float Q22 = -Q11;
		float Q12 = m8-meq8;
		float Q21 = Q12;
		float Q = Q11*Q11+Q12*Q12+Q21*Q21+Q22*Q22;
	
		float Cs = 0.01f;
		float nu0 = ((1.0f/omega)-0.5f)/3.0f;
		float Smag = (sqrt((2.0f*rho/(3.0f*omega))*(2.0f*rho/(3.0f*omega))
				+4.0f*2.0f*rho*Cs*sqrt(Q))-2.0f*rho/(3.0f*omega))/(4.0f*rho*Cs);
		float OmegaStar = 1.0f/(3.0f*(nu0+Cs*Smag)+0.5f);

f0_s[j]-=-4.f*(m1-meq1)/36.0f+4.f *(m2-meq2)/36.0f;//+0   *(m4-meq4)/12.0f+0   *(m6-meq6)/12.0f;
f1_s[j]-=-    (m1-meq1)/36.0f+-2.f*(m2-meq2)/36.0f+-2.f*(m4-meq4)/12.0f                     +   (m7-meq7)*OmegaStar/4.0f;
f2_s[j]-=-    (m1-meq1)/36.0f+-2.f*(m2-meq2)/36.0f                     +-2.f*(m6-meq6)/12.0f+-  (m7-meq7)*OmegaStar/4.0f;
f3_s[j]-=-    (m1-meq1)/36.0f+-2.f*(m2-meq2)/36.0f+2.f *(m4-meq4)/12.0f                     +   (m7-meq7)*OmegaStar/4.0f;
f4_s[j]-=-    (m1-meq1)/36.0f+-2.f*(m2-meq2)/36.0f                     +2.f *(m6-meq6)/12.0f+-  (m7-meq7)*OmegaStar/4.0f;
f5_s[j]-=2.f *(m1-meq1)/36.0f+     (m2-meq2)/36.0f+     (m4-meq4)/12.0f+     (m6-meq6)/12.0f+   (m8-meq8)*OmegaStar/4.0f;
f6_s[j]-=2.f *(m1-meq1)/36.0f+     (m2-meq2)/36.0f+-    (m4-meq4)/12.0f+     (m6-meq6)/12.0f+-  (m8-meq8)*OmegaStar/4.0f;
f7_s[j]-=2.f *(m1-meq1)/36.0f+     (m2-meq2)/36.0f+-    (m4-meq4)/12.0f+-    (m6-meq6)/12.0f+   (m8-meq8)*OmegaStar/4.0f;
f8_s[j]-=2.f *(m1-meq1)/36.0f+     (m2-meq2)/36.0f+     (m4-meq4)/12.0f+-    (m6-meq6)/12.0f+-  (m8-meq8)*OmegaStar/4.0f;	

//f0_s[j]-=-4.f*(m1-meq1)/36.0f+4.f *(m2-meq2)/36.0f;//+0   *(m4-meq4)/12.0f+0   *(m6-meq6)/12.0f;
//f1_s[j]-=-    (m1-meq1)/36.0f+-2.f*(m2-meq2)/36.0f+-2.f*(m4-meq4)/12.0f                     +   (m7-meq7)*omega/4.0f;
//f2_s[j]-=-    (m1-meq1)/36.0f+-2.f*(m2-meq2)/36.0f                     +-2.f*(m6-meq6)/12.0f+-  (m7-meq7)*omega/4.0f;
//f3_s[j]-=-    (m1-meq1)/36.0f+-2.f*(m2-meq2)/36.0f+2.f *(m4-meq4)/12.0f                     +   (m7-meq7)*omega/4.0f;
//f4_s[j]-=-    (m1-meq1)/36.0f+-2.f*(m2-meq2)/36.0f                     +2.f *(m6-meq6)/12.0f+-  (m7-meq7)*omega/4.0f;
//f5_s[j]-=2.f *(m1-meq1)/36.0f+     (m2-meq2)/36.0f+     (m4-meq4)/12.0f+     (m6-meq6)/12.0f+   (m8-meq8)*omega/4.0f;
//f6_s[j]-=2.f *(m1-meq1)/36.0f+     (m2-meq2)/36.0f+-    (m4-meq4)/12.0f+     (m6-meq6)/12.0f+-  (m8-meq8)*omega/4.0f;
//f7_s[j]-=2.f *(m1-meq1)/36.0f+     (m2-meq2)/36.0f+-    (m4-meq4)/12.0f+-    (m6-meq6)/12.0f+   (m8-meq8)*omega/4.0f;
//f8_s[j]-=2.f *(m1-meq1)/36.0f+     (m2-meq2)/36.0f+     (m4-meq4)/12.0f+-    (m6-meq6)/12.0f+-  (m8-meq8)*omega/4.0f;	

	}

	__syncthreads();
	f0[i] = f0_s[j];
	f1[i] = f1_s[j];
	f2[i] = f2_s[j];
	f3[i] = f3_s[j];
	f4[i] = f4_s[j];
	f5[i] = f5_s[j];
	f6[i] = f6_s[j];
	f7[i] = f7_s[j];
	f8[i] = f8_s[j];


}

__global__ void initialize(float *f0, float *f1, float *f2,
							float *f3, float *f4, float *f5,
							float *f6, float *f7, float *f8,
							int n)
{
	int i;
	//x = blockIdx.x*blockDim.x+threadIdx.x;
	//y = blockIdx.y*blockDim.y+threadIdx.y;
	i = threadIdx.y*blockDim.x+threadIdx.x;
	i += blockDim.x*blockDim.y*gridDim.x*blockIdx.y;
	i += blockDim.x*blockDim.y*blockIdx.x;
	//i = y*blockDim.x+x;
	float u,v,rho,feq,usqr;
	rho = 1.0f;
	u = 0.0f;
	v = 0.0f;
	usqr = u*u+v*v;
	feq = 4.0f/9.0f*(rho-1.5f*usqr);
	f0[i] = feq;
	feq = 1.0f/9.0f*(rho+3.0f*u+4.5f*u*u-1.5f*usqr);
	f1[i] = feq;
	feq = 1.0f/9.0f*(rho+3.0f*v+4.5f*v*v-1.5f*usqr);
	f2[i] = feq;
	feq = 1.0f/9.0f*(rho-3.0f*u+4.5f*u*u-1.5f*usqr);
	f3[i] = feq;
	feq = 1.0f/9.0f*(rho-3.0f*v+4.5f*v*v-1.5f*usqr);
	f4[i] = feq;
	feq = 1.0f/36.0f*(rho+3.0f*(u+v)+4.5f*(u+v)*(u+v)-1.5f*usqr);
	f5[i] = feq;
	feq = 1.0f/36.0f*(rho+3.0f*(-u+v)+4.5f*(-u+v)*(-u+v)-1.5f*usqr);
	f6[i] = feq;
	feq = 1.0f/36.0f*(rho+3.0f*(-u-v)+4.5f*(-u-v)*(-u-v)-1.5f*usqr);
	f7[i] = feq;
	feq = 1.0f/36.0f*(rho+3.0f*(u-v)+4.5f*(u-v)*(u-v)-1.5f*usqr);
	f8[i] = feq;
}
