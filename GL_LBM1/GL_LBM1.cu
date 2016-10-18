// OpenGL Graphics includes
#include <GL/glew.h>
#if defined(__APPLE__) || defined(MACOSX)
#include <GLUT/glut.h>
#else
#include <GL/freeglut.h>
#endif

// Includes
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

// CUDA standard includes
#include <cuda_runtime_api.h>
#include <cuda_gl_interop.h>

// CUDA FFT Libraries
#include <cufft.h>

// CUDA helper functions
#include <sdkHelper.h>
#include <rendercheck_gl.h>
#include <cudaHelper.h>
#include <cudaGLHelper.h>

// Shared Library Test Functions
#include <shrQATest.h>

#ifdef WIN32
     bool IsOpenGLAvailable(const char *appName) { return true; }
#else
  #if (defined(__APPLE__) || defined(MACOSX))
     bool IsOpenGLAvailable(const char *appName) { return true; }
  #else
     // check if this is a linux machine
     #include <X11/Xlib.h>

     bool IsOpenGLAvailable(const char *appName)
     {
        Display *Xdisplay = XOpenDisplay(NULL);
        if (Xdisplay == NULL) {
           return false;
        } else {
           XCloseDisplay(Xdisplay);
           return true;
        }
     }
  #endif
#endif

#if defined(__APPLE__) || defined(MACOSX)
#include <GLUT/glut.h>
#else
#include <GL/freeglut.h>
#endif

//#include "defines.h"
//#include "fluidsGL_kernels.h"

#define MAX_EPSILON_ERROR 1.0f

const char *sSDKname = "GL_LBM1";

// Define the files that are to be save and the reference images for validation
const char *sOriginal[] =
{
    "GL_LBM1.ppm",
    NULL
};

const char *sReference[] =
{
    "ref_GL_LBM1.ppm",
    NULL
};

#define getmin(a,b) (a < b ? a : b)
#define getmax(a,b) (a > b ? a : b)






#include <cuda.h>
#include <iostream>
#include <ostream>
#include <fstream>
#include "/home/yusuke/NVIDIA_GPU_Computing_SDK/C/common/inc/cutil.h"
using namespace std;






//#define BLOCKSIZE 16;
int const BLOCKSIZE = 16;
//int const XDIM = 32;
//int const YDIM = 32;

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

__global__ void stream1_d(float *f0, float *f1, float *f2,
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

	
	float u,v,rho,feq,usqr;
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
	feq = 4.0f/9.0f*(rho-1.5f*usqr);
	f0_s[j] = f0_s[j]-omega*(f0_s[j]-feq);
	feq = 1.0f/9.0f*(rho+3.0f*u+4.5f*u*u-1.5f*usqr);
	f1_s[j] = f1_s[j]-omega*(f1_s[j]-feq);
	feq = 1.0f/9.0f*(rho+3.0f*v+4.5f*v*v-1.5f*usqr);
	f2_s[j] = f2_s[j]-omega*(f2_s[j]-feq);
	feq = 1.0f/9.0f*(rho-3.0f*u+4.5f*u*u-1.5f*usqr);
	f3_s[j] = f3_s[j]-omega*(f3_s[j]-feq);
	feq = 1.0f/9.0f*(rho-3.0f*v+4.5f*v*v-1.5f*usqr);
	f4_s[j] = f4_s[j]-omega*(f4_s[j]-feq);
	feq = 1.0f/36.0f*(rho+3.0f*(u+v)+4.5f*(u+v)*(u+v)-1.5f*usqr);
	f5_s[j] = f5_s[j]-omega*(f5_s[j]-feq);
	feq = 1.0f/36.0f*(rho+3.0f*(-u+v)+4.5f*(-u+v)*(-u+v)-1.5f*usqr);
	f6_s[j] = f6_s[j]-omega*(f6_s[j]-feq);
	feq = 1.0f/36.0f*(rho+3.0f*(-u-v)+4.5f*(-u-v)*(-u-v)-1.5f*usqr);
	f7_s[j] = f7_s[j]-omega*(f7_s[j]-feq);
	feq = 1.0f/36.0f*(rho+3.0f*(u-v)+4.5f*(u-v)*(u-v)-1.5f*usqr);
	f8_s[j] = f8_s[j]-omega*(f8_s[j]-feq);
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

__global__ void stream1_d_orig(float *f0, float *f1, float *f2,
							float *f3, float *f4, float *f5,
							float *f6, float *f7, float *f8,
							int n, int *image, float omega, float uMax)
{
	int i,m,j;
	j = threadIdx.y*blockDim.x+threadIdx.x;
	i = j+blockDim.x*blockDim.y*gridDim.x*blockIdx.y;
	i += blockDim.x*blockDim.y*blockIdx.x;
	m = blockDim.x*blockDim.y;
	
//	__shared__ float f0_s[BLOCKSIZE*BLOCKSIZE];
//	__shared__ float f1_s[BLOCKSIZE*BLOCKSIZE];
//	__shared__ float f2_s[BLOCKSIZE*BLOCKSIZE];
//	__shared__ float f3_s[BLOCKSIZE*BLOCKSIZE];
//	__shared__ float f4_s[BLOCKSIZE*BLOCKSIZE];
//	__shared__ float f5_s[BLOCKSIZE*BLOCKSIZE];
//	__shared__ float f6_s[BLOCKSIZE*BLOCKSIZE];
//	__shared__ float f7_s[BLOCKSIZE*BLOCKSIZE];
//	__shared__ float f8_s[BLOCKSIZE*BLOCKSIZE];
//
//	f0_s[j] = f0[i];

	//STREAM
	//j = (i+1) & (m-1);//equiv to (i+1)%(m), if m is pow of 2;
	//j = (i+1)-blockDim.x*(threadIdx.x==blockDim.x-1);//equiv to (i+1)%(m), if m is pow of 2;
	if((i+1)%(blockDim.x)==0) j=i-blockDim.x+1;
	else j=i+1;
	float temp = f3[j];
	f3[j]=f1[i];
	f1[i]=temp;
	j = (i+blockDim.x) & (m-1);//equiv to (i+1)%(m), if m is pow of 2;
	temp = f4[j];
	f4[j]=f2[i];
	f2[i]=temp;
	if((i+1)%(blockDim.x)==0) j=i+1;
	else j = (i+blockDim.x+1) & (m-1);//equiv to (i+1)%(m), if m is pow of 2;
	temp = f7[j];
	f7[j]=f5[i];
	f5[i]=temp;
	if((i)%(blockDim.x)==0) j=i+2*blockDim.x-1;
	else j = (i+blockDim.x-1) & (m-1);//equiv to (i+1)%(m), if m is pow of 2;
	temp = f8[j];
	f8[j]=f6[i];
	f6[i]=temp;

	__syncthreads();

	if(image[i] != 1){
	temp = f3[i];
	f3[i]=f1[i];
	f1[i]=temp;
	temp = f4[i];
	f4[i]=f2[i];
	f2[i]=temp;
	temp = f7[i];
	f7[i]=f5[i];
	f5[i]=temp;
	temp = f8[i];
	f8[i]=f6[i];
	f6[i]=temp;

	
	float u,v,rho,feq,usqr;
	rho = f0[i]+f1[i]+f2[i]+f3[i]+f4[i]+f5[i]+f6[i]+f7[i]+f8[i];
	u = f1[i]-f3[i]+f5[i]-f6[i]-f7[i]+f8[i];
	v = f2[i]-f4[i]+f5[i]+f6[i]-f7[i]-f8[i];
	if(image[i] == 2){
		u = 0.0f;
		v = uMax;
		rho = u+(f0[i]+f2[i]+f4[i]+2.0f*f3[i]+2.0f*f6[i]+2.0f*f7[i]);
		f1[i] = f3[i]+4.0f*u/6.0f;
        f5[i] = f7[i]-0.5f*(f2[i]-f4[i])+v*0.5f+u/6.0f;
        f8[i] = f6[i]+0.5f*(f2[i]-f4[i])-v*0.5f+u/6.0f;	
	}
	usqr = u*u+v*v;
	feq = 4.0f/9.0f*(rho-1.5f*usqr);
	f0[i] = f0[i]-omega*(f0[i]-feq);
	feq = 1.0f/9.0f*(rho+3.0f*u+4.5f*u*u-1.5f*usqr);
	f1[i] = f1[i]-omega*(f1[i]-feq);
	feq = 1.0f/9.0f*(rho+3.0f*v+4.5f*v*v-1.5f*usqr);
	f2[i] = f2[i]-omega*(f2[i]-feq);
	feq = 1.0f/9.0f*(rho-3.0f*u+4.5f*u*u-1.5f*usqr);
	f3[i] = f3[i]-omega*(f3[i]-feq);
	feq = 1.0f/9.0f*(rho-3.0f*v+4.5f*v*v-1.5f*usqr);
	f4[i] = f4[i]-omega*(f4[i]-feq);
	feq = 1.0f/36.0f*(rho+3.0f*(u+v)+4.5f*(u+v)*(u+v)-1.5f*usqr);
	f5[i] = f5[i]-omega*(f5[i]-feq);
	feq = 1.0f/36.0f*(rho+3.0f*(-u+v)+4.5f*(-u+v)*(-u+v)-1.5f*usqr);
	f6[i] = f6[i]-omega*(f6[i]-feq);
	feq = 1.0f/36.0f*(rho+3.0f*(-u-v)+4.5f*(-u-v)*(-u-v)-1.5f*usqr);
	f7[i] = f7[i]-omega*(f7[i]-feq);
	feq = 1.0f/36.0f*(rho+3.0f*(u-v)+4.5f*(u-v)*(u-v)-1.5f*usqr);
	f8[i] = f8[i]-omega*(f8[i]-feq);

	}

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


int main(int argc, char *argv[])
{

	float *f0_h, *f1_h, *f2_h, *f3_h, *f4_h, *f5_h, *f6_h, *f7_h, *f8_h;
	float *f0_d, *f1_d, *f2_d, *f3_d, *f4_d, *f5_d, *f6_d, *f7_d, *f8_d;
	int *image_d, *image_h;

	ofstream output;
	output.open ("LBM1_out.dat");


	size_t memsize, memsize_int;
	int i, tMax, n, nBlocks, xDim, yDim;
	float Re, omega, uMax, CharLength;
	
	xDim = 256;//512;//128;//32;
	yDim = 256;//512;//128;//32;
	tMax = 100000;
	Re = 10000.f;//100.f;
	uMax = 0.1f;
	CharLength = xDim-2.f;
	omega = 1.0f/(3.0f*(uMax*CharLength/Re)+0.5f);

	cout<<"omega: "<<omega<<endl;



	nBlocks = (xDim/BLOCKSIZE+xDim%BLOCKSIZE)*(yDim/BLOCKSIZE+yDim%BLOCKSIZE);
	int B = BLOCKSIZE*BLOCKSIZE;
	n = nBlocks*B;//block*dimx*dimy



	CUT_DEVICE_INIT(argc,argv);

	memsize = n*sizeof(float);
	memsize_int = n*sizeof(int);

	f0_h = (float *)malloc(memsize);
	f1_h = (float *)malloc(memsize);
	f2_h = (float *)malloc(memsize);
	f3_h = (float *)malloc(memsize);
	f4_h = (float *)malloc(memsize);
	f5_h = (float *)malloc(memsize);
	f6_h = (float *)malloc(memsize);
	f7_h = (float *)malloc(memsize);
	f8_h = (float *)malloc(memsize);
	image_h = (int *)malloc(memsize_int);

	CUDA_SAFE_CALL(cudaMalloc((void **) &f0_d, memsize));
	CUDA_SAFE_CALL(cudaMalloc((void **) &f1_d, memsize));
	CUDA_SAFE_CALL(cudaMalloc((void **) &f2_d, memsize));
	CUDA_SAFE_CALL(cudaMalloc((void **) &f3_d, memsize));
	CUDA_SAFE_CALL(cudaMalloc((void **) &f4_d, memsize));
	CUDA_SAFE_CALL(cudaMalloc((void **) &f5_d, memsize));
	CUDA_SAFE_CALL(cudaMalloc((void **) &f6_d, memsize));
	CUDA_SAFE_CALL(cudaMalloc((void **) &f7_d, memsize));
	CUDA_SAFE_CALL(cudaMalloc((void **) &f8_d, memsize));
	CUDA_SAFE_CALL(cudaMalloc((void **) &image_d, memsize_int));

	for (i = 0; i < n; i++)
	{
		f0_h[i] = i;
		f1_h[i] = n-i;
		f2_h[i] = i;
		f3_h[i] = i;
		f4_h[i] = i;
		f5_h[i] = i;
		f6_h[i] = i;
		f7_h[i] = i;
		f8_h[i] = i;
		image_h[i] = 0;
		if(Xcoord(i,xDim) < 1) image_h[i] = 1;//DirichletWest
		if(Xcoord(i,xDim) > xDim-2) image_h[i] = 1;//BB
		if(Ycoord(i,xDim) < 1) image_h[i] = 1;//BB
		if(Ycoord(i,xDim) > yDim-2) image_h[i] = 3;//BB

	}
	CUDA_SAFE_CALL(cudaMemcpy(f0_d, f0_h, memsize, cudaMemcpyHostToDevice));
	CUDA_SAFE_CALL(cudaMemcpy(f1_d, f1_h, memsize, cudaMemcpyHostToDevice));
	CUDA_SAFE_CALL(cudaMemcpy(f2_d, f2_h, memsize, cudaMemcpyHostToDevice));
	CUDA_SAFE_CALL(cudaMemcpy(f3_d, f3_h, memsize, cudaMemcpyHostToDevice));
	CUDA_SAFE_CALL(cudaMemcpy(f4_d, f4_h, memsize, cudaMemcpyHostToDevice));
	CUDA_SAFE_CALL(cudaMemcpy(f5_d, f5_h, memsize, cudaMemcpyHostToDevice));
	CUDA_SAFE_CALL(cudaMemcpy(f6_d, f6_h, memsize, cudaMemcpyHostToDevice));
	CUDA_SAFE_CALL(cudaMemcpy(f7_d, f7_h, memsize, cudaMemcpyHostToDevice));
	CUDA_SAFE_CALL(cudaMemcpy(f8_d, f8_h, memsize, cudaMemcpyHostToDevice));
	CUDA_SAFE_CALL(cudaMemcpy(image_d, image_h, memsize_int, cudaMemcpyHostToDevice));


    dim3 threads(BLOCKSIZE, BLOCKSIZE);
    dim3 grid(xDim/BLOCKSIZE,yDim/BLOCKSIZE);
	cout<<"nBlocks:"<<nBlocks<<endl;


	initialize<<<grid, threads>>>(f0_d, f1_d, f2_d, f3_d, f4_d, f5_d, f6_d, f7_d, f8_d,n);
	for(int t = 0; t<tMax; t++){
		//stream1_d_orig<<<grid, threads>>>(f0_d,f1_d,f2_d,f3_d,f4_d,f5_d,f6_d,f7_d,f8_d,n,image_d,omega,uMax);
		//stream1_d<<<grid, threads>>>(f0_d,f1_d,f2_d,f3_d,f4_d,f5_d,f6_d,f7_d,f8_d,n,image_d,omega,uMax);
		mrt_d<<<grid, threads>>>(f0_d,f1_d,f2_d,f3_d,f4_d,f5_d,f6_d,f7_d,f8_d,n,image_d,omega,uMax);
		if(t%10000 == 0 && t>0) cout<<"finished "<<t<<" timesteps\n";
	}
	CUT_CHECK_ERROR("Kernel execution failed");

		CUDA_SAFE_CALL(cudaMemcpy(f0_h, f0_d, memsize, cudaMemcpyDeviceToHost));
		CUDA_SAFE_CALL(cudaMemcpy(f1_h, f1_d, memsize, cudaMemcpyDeviceToHost));
		CUDA_SAFE_CALL(cudaMemcpy(f2_h, f2_d, memsize, cudaMemcpyDeviceToHost));
		CUDA_SAFE_CALL(cudaMemcpy(f3_h, f3_d, memsize, cudaMemcpyDeviceToHost));
		CUDA_SAFE_CALL(cudaMemcpy(f4_h, f4_d, memsize, cudaMemcpyDeviceToHost));
		CUDA_SAFE_CALL(cudaMemcpy(f5_h, f5_d, memsize, cudaMemcpyDeviceToHost));
		CUDA_SAFE_CALL(cudaMemcpy(f6_h, f6_d, memsize, cudaMemcpyDeviceToHost));
		CUDA_SAFE_CALL(cudaMemcpy(f7_h, f7_d, memsize, cudaMemcpyDeviceToHost));
		CUDA_SAFE_CALL(cudaMemcpy(f8_h, f8_d, memsize, cudaMemcpyDeviceToHost));
		output<<"VARIABLES = \"X\",\"Y\",\"u\",\"v\",\"rho\"\n";
		output<<"ZONE F=POINT, I="<<xDim<<", J="<<yDim<<"\n";
		
//		for(i = 0; i<n; i++)
//		{
		int row = 0;
		int col = 0;
		i = 0;
		int rowB, colB;
		float xcoord, ycoord;
		float rho, u, v;
		rho = 0;
		u = 0;
		v = 0;

		for(rowB = 0; rowB<(yDim/BLOCKSIZE); rowB++){
			//i = rowB+B*(xDim/BLOCKSIZE);
			for(row = 0; row<BLOCKSIZE; row++){
				i = row*BLOCKSIZE+rowB*B*(xDim/BLOCKSIZE);
				//ycoord = row+rowB*BLOCKSIZE;//(i%B)/BLOCKSIZE+(i/B)/(xDim/BLOCKSIZE)*BLOCKSIZE;
				ycoord = Ycoord(i,xDim);
				for(colB = 0; colB<(xDim/BLOCKSIZE); colB++){
					for(col = 0; col<BLOCKSIZE; col++){
						rho = f0_h[i]+f1_h[i]+f2_h[i]+f3_h[i]+f4_h[i]+f5_h[i]+f6_h[i]+f7_h[i]+f8_h[i];
						u = f1_h[i]-f3_h[i]+f5_h[i]-f6_h[i]-f7_h[i]+f8_h[i];
						v = f2_h[i]-f4_h[i]+f5_h[i]+f6_h[i]-f7_h[i]-f8_h[i];
						//xcoord = (i%B)%BLOCKSIZE+((i/B)%(xDim/BLOCKSIZE))*BLOCKSIZE;
						xcoord = Xcoord(i,xDim);
						//output<<xcoord<<", "<<ycoord<<", "<<"0"<<","<<"0"<<","<<"0"<<endl;
						output<<xcoord<<", "<<ycoord<<", "<<u<<","<<v<<","<<rho<<endl;
						i++;
					}
					i += (BLOCKSIZE-1)*BLOCKSIZE;
				}
			}
			//i += B*(xDim/BLOCKSIZE-1)+BLOCKSIZE;
		}





//		for(row = 0; row<yDim; row++){
//			i = row*xDim;
//			for(col = 0; col<xDim; col++){
//				float rho = f0_h[i]+f1_h[i]+f2_h[i]+f3_h[i]+f4_h[i]+f5_h[i]+f6_h[i]+f7_h[i]+f8_h[i];
//				float u = f1_h[i]-f3_h[i]+f5_h[i]-f6_h[i]-f7_h[i]+f8_h[i];
//				float v = f2_h[i]-f4_h[i]+f5_h[i]+f6_h[i]-f7_h[i]-f8_h[i];
////				output<<i%16<<", "<<i/16<<", "<<f5_h[i]<<","<<f6_h[i]<<","<<f7_h[i]<<endl;
////				output<<i%xDim<<", "<<i/xDim<<", "<<u<<","<<v<<","<<rho<<endl;
//				float xcoord = (i%B)%BLOCKSIZE+(i/B)%(xDim/BLOCKSIZE);
//				float ycoord = (i%B)/BLOCKSIZE+(i/B)/(xDim/BLOCKSIZE);
//				output<<xcoord<<", "<<ycoord<<", "<<u<<","<<v<<","<<rho<<endl;
//				i += 2*BLOCKSIZE+1;
//			}
//		}

	free(f0_h);
	free(f1_h);
	free(f2_h);
	free(f3_h);
	free(f4_h);
	free(f5_h);
	free(f6_h);
	free(f7_h);
	free(f8_h);

	output.close();

	CUDA_SAFE_CALL(cudaFree(f0_d));
	CUDA_SAFE_CALL(cudaFree(f1_d));
	CUDA_SAFE_CALL(cudaFree(f2_d));
	CUDA_SAFE_CALL(cudaFree(f3_d));
	CUDA_SAFE_CALL(cudaFree(f4_d));
	CUDA_SAFE_CALL(cudaFree(f5_d));
	CUDA_SAFE_CALL(cudaFree(f6_d));
	CUDA_SAFE_CALL(cudaFree(f7_d));
	CUDA_SAFE_CALL(cudaFree(f8_d));

	return(0);

}
