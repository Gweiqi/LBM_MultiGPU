#include <cuda.h>
//#include <cutil.h>
#include <iostream>
#include <ostream>
#include <fstream>
//#include "/home/yusuke/NVIDIA_GPU_Computing_SDK/C/common/inc/cutil.h"
using namespace std;

//#define BLOCKSIZE 16;
//int const XDIM = 32;
//int const YDIM = 32;

//int Xcoord(int i, int XDim){
//	int B = BLOCKSIZE*BLOCKSIZE;
//	return (i%B)%BLOCKSIZE+((i/B)%(XDim/BLOCKSIZE))*BLOCKSIZE;
//}
//int Ycoord(int i, int XDim){
//	int B = BLOCKSIZE*BLOCKSIZE;
//	return (i%B)/BLOCKSIZE+((i/B)/(XDim/BLOCKSIZE))*BLOCKSIZE;
//}

//texture
//texture<float,1,cudaReadModeElementType> texRef_f1;
texture<float,2,cudaReadModeElementType> texRef_f1A;
texture<float,2,cudaReadModeElementType> texRef_f2A;
texture<float,2,cudaReadModeElementType> texRef_f3A;
texture<float,2,cudaReadModeElementType> texRef_f4A;
texture<float,2,cudaReadModeElementType> texRef_f5A;
texture<float,2,cudaReadModeElementType> texRef_f6A;
texture<float,2,cudaReadModeElementType> texRef_f7A;
texture<float,2,cudaReadModeElementType> texRef_f8A;
texture<float,2,cudaReadModeElementType> texRef_f1B;
texture<float,2,cudaReadModeElementType> texRef_f2B;
texture<float,2,cudaReadModeElementType> texRef_f3B;
texture<float,2,cudaReadModeElementType> texRef_f4B;
texture<float,2,cudaReadModeElementType> texRef_f5B;
texture<float,2,cudaReadModeElementType> texRef_f6B;
texture<float,2,cudaReadModeElementType> texRef_f7B;
texture<float,2,cudaReadModeElementType> texRef_f8B;

#include <sys/time.h>
#include <time.h>

int
timeval_subtract (double *result, struct timeval *x, struct timeval *y)
{
  struct timeval result0;

  /* Perform the carry for the later subtraction by updating y. */
  if (x->tv_usec < y->tv_usec) {
    int nsec = (y->tv_usec - x->tv_usec) / 1000000 + 1;
    y->tv_usec -= 1000000 * nsec;
    y->tv_sec += nsec;
  }
  if (x->tv_usec - y->tv_usec > 1000000) {
    int nsec = (y->tv_usec - x->tv_usec) / 1000000;
    y->tv_usec += 1000000 * nsec;
    y->tv_sec -= nsec;
  }

  /* Compute the time remaining to wait.
     tv_usec is certainly positive. */
  result0.tv_sec = x->tv_sec - y->tv_sec;
  result0.tv_usec = x->tv_usec - y->tv_usec;
  *result = ((double)result0.tv_usec)/1e6 + (double)result0.tv_sec;

  /* Return 1 if result is negative. */
  return x->tv_sec < y->tv_sec;
}


__global__ void test(float *f0A, float *f1A, float *f2A,
						   float *f3A, float *f4A, float *f5A,
						   float *f6A, float *f7A, float *f8A,
						               float *f1B, float *f2B,
						   float *f3B, float *f4B, float *f5B,
						   float *f6B, float *f7B, float *f8B, //int pitch)
						   int n, int *image, float omega, float uMax, int pitch)
{
	int x = blockIdx.x*blockDim.x+threadIdx.x;
	int y = blockIdx.y*blockDim.y+threadIdx.y;
//	int i = x+y*blockDim.x*gridDim.x;
//	j = threadIdx.y*blockDim.x+threadIdx.x;//local block index (for shared mem)
//	i = j+blockDim.x*blockDim.y*gridDim.x*blockIdx.y;
//	i += blockDim.x*blockDim.y*blockIdx.x;//global memory index

		//f0A[i] = f;
		float f1,f2,f3,f4,f5,f6,f7,f8;
//		f1=tex2D(texRef_f1,x+1,y  );
//		f2=tex2D(texRef_f2,x-1,y  );
//		f3=tex2D(texRef_f3,x  ,y+1);
//		f4=tex2D(texRef_f4,x  ,y-1);
//		f5=tex2D(texRef_f5,x+1,y+1);
//		f7=tex2D(texRef_f7,x-1,y-1);
//		f6=tex2D(texRef_f6,x-1,y+1);
//		f8=tex2D(texRef_f8,x+1,y-1);
		//if(image[i] == 0){

//		f1 = tex2D(texRef_f1,x-1,y  );
//		f2 = tex2D(texRef_f2,x  ,y-1);
//		f3 = tex2D(texRef_f3,x+1,y  );
//		f4 = tex2D(texRef_f4,x  ,y+1);
//		f5 = tex2D(texRef_f5,x-1,y-1);
//		f6 = tex2D(texRef_f6,x+1,y-1);
//		f7 = tex2D(texRef_f7,x+1,y+1);
//		f8 = tex2D(texRef_f8,x-1,y+1);

//		f1 = f1A[x-1+y*pitch];
//		f2 = f2A[x  +(y-1)*pitch];
//		f3 = f3A[x+1+y*pitch];
//		f4 = f4A[x  +(y+1)*pitch];
//		f5 = f5A[x-1+(y-1)*pitch];
//		f6 = f6A[x+1+(y-1)*pitch];
//		f7 = f7A[x+1+(y+1)*pitch];
//		f8 = f8A[x-1+(y+1)*pitch];

//		f1=f1A[x+1+(y  )*pitch];
//		f2=f2A[x-1+(y  )*pitch];
//		f3=f3A[x  +(y+1)*pitch];
//		f4=f4A[x  +(y-1)*pitch];
//		f5=f5A[x+1+(y+1)*pitch];
//		f7=f7A[x-1+(y-1)*pitch];
//		f6=f6A[x-1+(y+1)*pitch];
//		f8=f8A[x+1+(y-1)*pitch];
		f1=f1A[x+y*pitch];
		f2=f2A[x+y*pitch];
		f3=f3A[x+y*pitch];
		f4=f4A[x+y*pitch];
		f5=f5A[x+y*pitch];
		f6=f6A[x+y*pitch];
		f7=f7A[x+y*pitch];
		f8=f8A[x+y*pitch];
//		f1B[x+y*pitch]=f1+1;
//		f3B[x+y*pitch]=f3+1;
//		f2B[x+y*pitch]=f2+1;
//		f4B[x+y*pitch]=f4+1;
//		f5B[x+y*pitch]=f5+1;
//		f6B[x+y*pitch]=f6+1;
//		f7B[x+y*pitch]=f7+1;
//		f8B[x+y*pitch]=f8+1;
		//}
//		f1=f1A[x+y*pitch];
//		f3=f3A[x+y*pitch];
//		f2=f2A[x+y*pitch];
//		f4=f4A[x+y*pitch];
//		f5=f5A[x+y*pitch];
//		f7=f7A[x+y*pitch];
//		f6=f6A[x+y*pitch];
//		f8=f8A[x+y*pitch];
		f1B[x+y*pitch]=f1;
		f2B[x+y*pitch]=f2;
		f3B[x+y*pitch]=f3;
		f4B[x+y*pitch]=f4;
		f5B[x+y*pitch]=f5;
		f6B[x+y*pitch]=f6;
		f7B[x+y*pitch]=f7;
		f8B[x+y*pitch]=f8;


}

__device__ void collide(float &f0, float &f1, float &f2,
						   float &f3, float &f4, float &f5,
						   float &f6, float &f7, float &f8, float rho, float u, float v, float omega)
{
	float m1,m2,m4,m6,m7,m8;
	m1 =-4.f*f0 -    f1 -    f2 -    f3 -    f4+ 2.f*f5+ 2.f*f6+ 2.f*f7+ 2.f*f8-(-2.0f*rho+3.0f*(u*u+v*v));
	m2 = 4.f*f0 -2.f*f1 -2.f*f2 -2.f*f3 -2.f*f4+     f5+     f6+     f7+     f8-(rho-3.0f*(u*u+v*v)); //ep
	m4 =        -2.f*f1        + 2.f*f3        +     f5 -    f6 -    f7+     f8-(-u);//qx_eq
	m6 =                -2.f*f2        + 2.f*f4+     f5+     f6 -    f7 -    f8-(-v);//qy_eq
	m7 =             f1 -    f2+     f3 -    f4                                -(u*u-v*v);//pxx_eq
	m8 =                                             f5 -    f6+     f7 -    f8-(u*v);//pxy_eq

	f0=f0-(-m1+m2)*0.11111111f;//(-4.f*(m1)/36.0f+4.f *(m2)/36.0f);
	f1=f1-(-m1-2.0f*(m2+m4)+m7*omega*9.0f)*0.027777777f;
	f2=f2-(-m1-2.f*m2-6.f*m6-m7*omega*9.0f)*0.027777777f;
	f3=f3-(-m1-2.f*m2+6.f*m4+m7*omega*9.0f)*0.027777777f;
	f4=f4-(-m1-2.f*m2+6.f*m6-m7*omega*9.0f)*0.027777777f;
	f5=f5-(2.f*m1+m2+3.f*m4+3.f*m6+m8*omega*9.0f)*0.027777777f;
	f6=f6-(2.f*m1+m2-3.f*m4+3.f*m6-m8*omega*9.0f)*0.027777777f;
	f7=f7-(2.f*m1+m2-3.f*m4-3.f*m6+m8*omega*9.0f)*0.027777777f;
	f8=f8-(2.f*m1+m2+3.f*m4-3.f*m6-m8*omega*9.0f)*0.027777777f;


//	f0=f0-(-m1+m2)/9.0f;//(-4.f*(m1)/36.0f+4.f *(m2)/36.0f);
//	f1=f1-(-m1-2.0f*(m2+m4)+m7*omega*9.0f)/36.0f;
//	f2=f2-(-m1-2.f*m2-6.f*m6-m7*omega*9.0f)/36.0f;
//	f3=f3-(-m1-2.f*m2+6.f*m4+m7*omega*9.0f)/36.0f;
//	f4=f4-(-m1-2.f*m2+6.f*m6-m7*omega*9.0f)/36.0f;
//	f5=f5-(2.f*m1+m2+3.f*m4+3.f*m6+m8*omega*9.0f)/36.0f;
//	f6=f6-(2.f*m1+m2-3.f*m4+3.f*m6-m8*omega*9.0f)/36.0f;
//	f7=f7-(2.f*m1+m2-3.f*m4-3.f*m6+m8*omega*9.0f)/36.0f;
//	f8=f8-(2.f*m1+m2+3.f*m4-3.f*m6-m8*omega*9.0f)/36.0f;

//	float feq;
//	float usqr = u*u+v*v;
//	feq = 4.0f/9.0f*(rho-1.5f*usqr);
//	f0 = f0-omega*(f0-feq);
//	feq = 1.0f/9.0f*(rho+3.0f*u+4.5f*u*u-1.5f*usqr);
//	f1 = f1-omega*(f1-feq);
//	feq = 1.0f/9.0f*(rho+3.0f*v+4.5f*v*v-1.5f*usqr);
//	f2 = f2-omega*(f2-feq);
//	feq = 1.0f/9.0f*(rho-3.0f*u+4.5f*u*u-1.5f*usqr);
//	f3 = f3-omega*(f3-feq);
//	feq = 1.0f/9.0f*(rho-3.0f*v+4.5f*v*v-1.5f*usqr);
//	f4 = f4-omega*(f4-feq);
//	feq = 1.0f/36.0f*(rho+3.0f*(u+v)+4.5f*(u+v)*(u+v)-1.5f*usqr);
//	f5 = f5-omega*(f5-feq);
//	feq = 1.0f/36.0f*(rho+3.0f*(-u+v)+4.5f*(-u+v)*(-u+v)-1.5f*usqr);
//	f6 = f6-omega*(f6-feq);
//	feq = 1.0f/36.0f*(rho+3.0f*(-u-v)+4.5f*(-u-v)*(-u-v)-1.5f*usqr);
//	f7 = f7-omega*(f7-feq);
//	feq = 1.0f/36.0f*(rho+3.0f*(u-v)+4.5f*(u-v)*(u-v)-1.5f*usqr);
//	f8 = f8-omega*(f8-feq);


}


__global__ void mrt_d_textAB(float *f0A, float *f1A, float *f2A,
						   float *f3A, float *f4A, float *f5A,
						   float *f6A, float *f7A, float *f8A,
						               float *f1B, float *f2B,
						   float *f3B, float *f4B, float *f5B,
						   float *f6B, float *f7B, float *f8B,
						   int n, int *image, float omega, float uMax, int pitch)
{
	int x = blockIdx.x*blockDim.x+threadIdx.x;
	int y = blockIdx.y*blockDim.y+threadIdx.y;
	int i = x+y*blockDim.x*gridDim.x;
	int im = image[i];
	if(im == 1){//BB
		float f0,f1,f2,f3,f4,f5,f6,f7,f8;

//		//f0 = f0A[x+y*pitch];
//		f2 = f4A[x  +(y+1)*pitch];
//		f4 = f2A[x  +(y-1)*pitch];
//		f1 = tex2D(texRef_f3A,x+1,y  );
//		f3 = tex2D(texRef_f1A,x-1,y  );
//		f5 = tex2D(texRef_f7A,x+1,y+1);
//		f7 = tex2D(texRef_f5A,x-1,y-1);
//		f6 = tex2D(texRef_f8A,x-1,y+1);
//		f8 = tex2D(texRef_f6A,x+1,y-1);
//
//		//f0A[x+y*pitch] = f0;
//		f2B[x+y*pitch] = f2;
//		f4B[x+y*pitch] = f4;
//		f1B[x+y*pitch] = f1;
//		f3B[x+y*pitch] = f3;
//		f5B[x+y*pitch] = f5;
//		f7B[x+y*pitch] = f7;
//		f6B[x+y*pitch] = f6;
//		f8B[x+y*pitch] = f8;


		f0A[x+y*pitch]=f0A[x+y*pitch];
		f1B[x+y*pitch]=tex2D(texRef_f3A,x+1,y  );
		f3B[x+y*pitch]=tex2D(texRef_f1A,x-1,y  );
		f2B[x+y*pitch]=tex2D(texRef_f4A,x  ,y+1);
		f4B[x+y*pitch]=tex2D(texRef_f2A,x  ,y-1);
		f5B[x+y*pitch]=tex2D(texRef_f7A,x+1,y+1);
		f7B[x+y*pitch]=tex2D(texRef_f5A,x-1,y-1);
		f6B[x+y*pitch]=tex2D(texRef_f8A,x-1,y+1);
		f8B[x+y*pitch]=tex2D(texRef_f6A,x+1,y-1);

//		f0A[x+y*pitch] = f0A[x+y*pitch];
//		f1B[x+y*pitch] = f3A[x+1+(y  )*pitch];
//		f3B[x+y*pitch] = f1A[x-1+(y  )*pitch];
//		f2B[x+y*pitch] = f4A[x  +(y+1)*pitch];
//		f4B[x+y*pitch] = f2A[x  +(y-1)*pitch];
//		f5B[x+y*pitch] = f7A[x+1+(y+1)*pitch];
//		f7B[x+y*pitch] = f5A[x-1+(y-1)*pitch];
//		f6B[x+y*pitch] = f8A[x-1+(y+1)*pitch];
//		f8B[x+y*pitch] = f6A[x+1+(y-1)*pitch];

//		f0A[x+y*pitch] = f0A[x+y*pitch];
//		f1B[x+y*pitch] = f1A[x+(y)*pitch];
//		f3B[x+y*pitch] = f2A[x+(y)*pitch];
//		f2B[x+y*pitch] = f3A[x+(y)*pitch];
//		f4B[x+y*pitch] = f4A[x+(y)*pitch];
//		f5B[x+y*pitch] = f5A[x+(y)*pitch];
//		f7B[x+y*pitch] = f6A[x+(y)*pitch];
//		f6B[x+y*pitch] = f7A[x+(y)*pitch];
//		f8B[x+y*pitch] = f8A[x+(y)*pitch];


	}
	else{
		float f0,f1,f2,f3,f4,f5,f6,f7,f8;
		float u,v,rho;//,feq,usqr;
		
//		f0 = f0A[x  +y*pitch];
//		f2 = f2A[x  +(y-1)*pitch];
//		f4 = f4A[x  +(y+1)*pitch];
//		f1 = tex2D(texRef_f1A,x-1,y  );
//		f3 = tex2D(texRef_f3A,x+1,y  );
//		f5 = tex2D(texRef_f5A,x-1,y-1);
//		f6 = tex2D(texRef_f6A,x+1,y-1);
//		f7 = tex2D(texRef_f7A,x+1,y+1);
//		f8 = tex2D(texRef_f8A,x-1,y+1);


		f1 = tex2D(texRef_f1A,x-1,y  );
		f2 = tex2D(texRef_f2A,x  ,y-1);
		f3 = tex2D(texRef_f3A,x+1,y  );
		f4 = tex2D(texRef_f4A,x  ,y+1);
		f5 = tex2D(texRef_f5A,x-1,y-1);
		f6 = tex2D(texRef_f6A,x+1,y-1);
		f7 = tex2D(texRef_f7A,x+1,y+1);
		f8 = tex2D(texRef_f8A,x-1,y+1);
		f0 = f0A[x  +y*pitch];

//		f0 = f0A[x  +y*pitch];
//		f1 = f1A[x-1+y*pitch];
//		f2 = f2A[x  +(y-1)*pitch];
//		f3 = f3A[x+1+y*pitch];
//		f4 = f4A[x  +(y+1)*pitch];
//		f5 = f5A[x-1+(y-1)*pitch];
//		f6 = f6A[x+1+(y-1)*pitch];
//		f7 = f7A[x+1+(y+1)*pitch];
//		f8 = f8A[x-1+(y+1)*pitch];
	
//		f0 = f0A[x  +y*pitch];
//		f1 = f1A[x+y*pitch];
//		f2 = f2A[x+y*pitch];
//		f3 = f3A[x+y*pitch];
//		f4 = f4A[x+y*pitch];
//		f5 = f5A[x+y*pitch];
//		f6 = f6A[x+y*pitch];
//		f7 = f7A[x+y*pitch];
//		f8 = f8A[x+y*pitch];
		
		rho = f0+f1+f2+f3+f4+f5+f6+f7+f8;
		u = f1-f3+f5-f6-f7+f8;
		v = f2-f4+f5+f6-f7-f8;

		if(im == 2){
			u = 0.0f;
			v = uMax;
			rho = u+(f0+f2+f4+2.0f*f3+2.0f*f6+2.0f*f7);
			//f1 = f3+4.0f*u/6.0f;
			f1 = f3+u*0.66666667f;
	        f5 = f7-0.5f*(f2-f4)+v*0.5f+u*0.166666667f;
	        f8 = f6+0.5f*(f2-f4)-v*0.5f+u*0.166666667f;	
		}
		else if(im == 3){//north
			u = uMax;
			v = 0.0f;
			rho = -v+(f0+f1+f3+2.0f*f6+2.0f*f2+2.0f*f5);
			//f4 = f2-4.0f*v/6.0f;
			f4 = f2-v*0.66666667f;
	        f7 = f5+0.5f*(f1-f3)-u*0.5f+v*0.166666667f;
	        f8 = f6-0.5f*(f1-f3)+u*0.5f+v*0.166666667f;	
		}
		collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,rho,u,v,omega);

	f0A[y*pitch+x]=f0;
	f1B[y*pitch+x]=f1;
	f2B[y*pitch+x]=f2;
	f3B[y*pitch+x]=f3;
	f4B[y*pitch+x]=f4;
	f5B[y*pitch+x]=f5;
	f6B[y*pitch+x]=f6;
	f7B[y*pitch+x]=f7;
	f8B[y*pitch+x]=f8;

	}
}

__global__ void mrt_d_textBA(float *f0A, float *f1A, float *f2A,
						   float *f3A, float *f4A, float *f5A,
						   float *f6A, float *f7A, float *f8A,
						               float *f1B, float *f2B,
						   float *f3B, float *f4B, float *f5B,
						   float *f6B, float *f7B, float *f8B,
						   int n, int *image, float omega, float uMax, int pitch)
{
	int x = blockIdx.x*blockDim.x+threadIdx.x;
	int y = blockIdx.y*blockDim.y+threadIdx.y;
	int i = x+y*blockDim.x*gridDim.x;
	float u,v,rho;//,usqr;
	int im = image[i];
	if(im == 1){//BB
		float f1,f2,f3,f4,f5,f6,f7,f8;

//		//f0 = f0A[x+y*pitch];
//		f2 = f4A[x  +(y+1)*pitch];
//		f4 = f2A[x  +(y-1)*pitch];
//		f1 = tex2D(texRef_f3B,x+1,y  );
//		f3 = tex2D(texRef_f1B,x-1,y  );
//		f5 = tex2D(texRef_f7B,x+1,y+1);
//		f7 = tex2D(texRef_f5B,x-1,y-1);
//		f6 = tex2D(texRef_f8B,x-1,y+1);
//		f8 = tex2D(texRef_f6B,x+1,y-1);
//
//		//f0A[x+y*pitch] = f0;
//		f2B[x+y*pitch] = f2;
//		f4B[x+y*pitch] = f4;
//		f1B[x+y*pitch] = f1;
//		f3B[x+y*pitch] = f3;
//		f5B[x+y*pitch] = f5;
//		f7B[x+y*pitch] = f7;
//		f6B[x+y*pitch] = f6;
//		f8B[x+y*pitch] = f8;


		//f0A[i] = f0A[i];
//		f0A[x+y*pitch]=f0A[x+y*pitch];
		f1B[x+y*pitch]=tex2D(texRef_f3B,x+1,y  );
		f3B[x+y*pitch]=tex2D(texRef_f1B,x-1,y  );
		f2B[x+y*pitch]=tex2D(texRef_f4B,x  ,y+1);
		f4B[x+y*pitch]=tex2D(texRef_f2B,x  ,y-1);
		f5B[x+y*pitch]=tex2D(texRef_f7B,x+1,y+1);
		f7B[x+y*pitch]=tex2D(texRef_f5B,x-1,y-1);
		f6B[x+y*pitch]=tex2D(texRef_f8B,x-1,y+1);
		f8B[x+y*pitch]=tex2D(texRef_f6B,x+1,y-1);
//
//		f0A[x+y*pitch] = f0A[x+y*pitch];
//		f1B[x+y*pitch] = f3A[x+1+(y  )*pitch];
//		f3B[x+y*pitch] = f1A[x-1+(y  )*pitch];
//		f2B[x+y*pitch] = f4A[x  +(y+1)*pitch];
//		f4B[x+y*pitch] = f2A[x  +(y-1)*pitch];
//		f5B[x+y*pitch] = f7A[x+1+(y+1)*pitch];
//		f7B[x+y*pitch] = f5A[x-1+(y-1)*pitch];
//		f6B[x+y*pitch] = f8A[x-1+(y+1)*pitch];
//		f8B[x+y*pitch] = f6A[x+1+(y-1)*pitch];
//
//		f0A[x+y*pitch] = f0A[x+y*pitch];
//		f1B[x+y*pitch] = f1A[x+(y)*pitch];
//		f3B[x+y*pitch] = f2A[x+(y)*pitch];
//		f2B[x+y*pitch] = f3A[x+(y)*pitch];
//		f4B[x+y*pitch] = f4A[x+(y)*pitch];
//		f5B[x+y*pitch] = f5A[x+(y)*pitch];
//		f7B[x+y*pitch] = f6A[x+(y)*pitch];
//		f6B[x+y*pitch] = f7A[x+(y)*pitch];
//		f8B[x+y*pitch] = f8A[x+(y)*pitch];


	}
	else{
		float f0,f1,f2,f3,f4,f5,f6,f7,f8;
//		f0 = f0A[x  +y*pitch];
//		f2 = f2B[x  +(y-1)*pitch];
//		f4 = f4B[x  +(y+1)*pitch];
//		f1 = tex2D(texRef_f1B,x-1,y  );
//		f3 = tex2D(texRef_f3B,x+1,y  );
//		f5 = tex2D(texRef_f5B,x-1,y-1);
//		f6 = tex2D(texRef_f6B,x+1,y-1);
//		f7 = tex2D(texRef_f7B,x+1,y+1);
//		f8 = tex2D(texRef_f8B,x-1,y+1);


		f1 = tex2D(texRef_f1B,x-1,y  );
		f2 = tex2D(texRef_f2B,x  ,y-1);
		f3 = tex2D(texRef_f3B,x+1,y  );
		f4 = tex2D(texRef_f4B,x  ,y+1);
		f5 = tex2D(texRef_f5B,x-1,y-1);
		f6 = tex2D(texRef_f6B,x+1,y-1);
		f7 = tex2D(texRef_f7B,x+1,y+1);
		f8 = tex2D(texRef_f8B,x-1,y+1);
		f0 = f0A[x  +y*pitch];

//		f0 = f0A[x  +y*pitch];
//		f1 = f1A[x-1+y*pitch];
//		f2 = f2A[x  +(y-1)*pitch];
//		f3 = f3A[x+1+y*pitch];
//		f4 = f4A[x  +(y+1)*pitch];
//		f5 = f5A[x-1+(y-1)*pitch];
//		f6 = f6A[x+1+(y-1)*pitch];
//		f7 = f7A[x+1+(y+1)*pitch];
//		f8 = f8A[x-1+(y+1)*pitch];

//		f0 = f0A[x  +y*pitch];
//		f1 = f1A[x+y*pitch];
//		f2 = f2A[x+y*pitch];
//		f3 = f3A[x+y*pitch];
//		f4 = f4A[x+y*pitch];
//		f5 = f5A[x+y*pitch];
//		f6 = f6A[x+y*pitch];
//		f7 = f7A[x+y*pitch];
//		f8 = f8A[x+y*pitch];
	
	
		rho = f0+f1+f2+f3+f4+f5+f6+f7+f8;
		u = f1-f3+f5-f6-f7+f8;
		v = f2-f4+f5+f6-f7-f8;

		if(im == 2){
			u = 0.0f;
			v = uMax;
			rho = u+(f0+f2+f4+2.0f*f3+2.0f*f6+2.0f*f7);
			//f1 = f3+4.0f*u/6.0f;
			f1 = f3+u*0.66666667f;
	        f5 = f7-0.5f*(f2-f4)+v*0.5f+u*0.166666667f;
	        f8 = f6+0.5f*(f2-f4)-v*0.5f+u*0.166666667f;	
		}
		else if(im == 3){//north
			u = uMax;
			v = 0.0f;
			rho = -v+(f0+f1+f3+2.0f*f6+2.0f*f2+2.0f*f5);
			//f4 = f2-4.0f*v/6.0f;
			f4 = f2-v*0.66666667f;
	        f7 = f5+0.5f*(f1-f3)-u*0.5f+v*0.166666667f;
	        f8 = f6-0.5f*(f1-f3)+u*0.5f+v*0.166666667f;	
		}
		collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,rho,u,v,omega);

	f0A[y*pitch+x]=f0;
	f1B[y*pitch+x]=f1;
	f2B[y*pitch+x]=f2;
	f3B[y*pitch+x]=f3;
	f4B[y*pitch+x]=f4;
	f5B[y*pitch+x]=f5;
	f6B[y*pitch+x]=f6;
	f7B[y*pitch+x]=f7;
	f8B[y*pitch+x]=f8;


	}
}

__global__ void initialize(float *f0, float *f1, float *f2,
							float *f3, float *f4, float *f5,
							float *f6, float *f7, float *f8,
							int n, int pitch)
{
	int i;
	int x = blockIdx.x*blockDim.x+threadIdx.x;
	int y = blockIdx.y*blockDim.y+threadIdx.y;
	i = threadIdx.y*blockDim.x+threadIdx.x;
	i += blockDim.x*blockDim.y*gridDim.x*blockIdx.y;
	i += blockDim.x*blockDim.y*blockIdx.x;
	//i = y*blockDim.x+x;
	//f1[y*pitch+x] = tex2D(texRef_f1,x,y);
	float u,v,rho,feq,usqr;
	rho = 1.0f;
	u = 0.0f;
	v = 0.0f;
	usqr = u*u+v*v;
	feq = 4.0f/9.0f*(rho-1.5f*usqr);
	f0[i] = feq;
	feq = 1.0f/9.0f*(rho+3.0f*u+4.5f*u*u-1.5f*usqr);
	f1[y*pitch+x] = feq;
	feq = 1.0f/9.0f*(rho+3.0f*v+4.5f*v*v-1.5f*usqr);
	f2[y*pitch+x] = feq;
	feq = 1.0f/9.0f*(rho-3.0f*u+4.5f*u*u-1.5f*usqr);
	f3[y*pitch+x] = feq;
	feq = 1.0f/9.0f*(rho-3.0f*v+4.5f*v*v-1.5f*usqr);
	f4[y*pitch+x] = feq;
	feq = 1.0f/36.0f*(rho+3.0f*(u+v)+4.5f*(u+v)*(u+v)-1.5f*usqr);
	f5[y*pitch+x] = feq;
	feq = 1.0f/36.0f*(rho+3.0f*(-u+v)+4.5f*(-u+v)*(-u+v)-1.5f*usqr);
	f6[y*pitch+x] = feq;
	feq = 1.0f/36.0f*(rho+3.0f*(-u-v)+4.5f*(-u-v)*(-u-v)-1.5f*usqr);
	f7[y*pitch+x] = feq;
	feq = 1.0f/36.0f*(rho+3.0f*(u-v)+4.5f*(u-v)*(u-v)-1.5f*usqr);
	f8[y*pitch+x] = feq;
}




int main(int argc, char *argv[])
{

	float *f0_h, *f1_h, *f2_h, *f3_h, *f4_h, *f5_h, *f6_h, *f7_h, *f8_h;
	float *f0_d, *f1_dA, *f2_dA, *f3_dA, *f4_dA, *f5_dA, *f6_dA, *f7_dA, *f8_dA;
	float        *f1_dB, *f2_dB, *f3_dB, *f4_dB, *f5_dB, *f6_dB, *f7_dB, *f8_dB;
	int *image_d, *image_h;

	ofstream output;
	output.open ("LBM1_out.dat");


	size_t memsize, memsize_int;
	size_t pitch;
	int i, tMax, n, nBlocks, xDim, yDim;
	float Re, omega, uMax, CharLength;
	
	int BLOCKSIZEx = 16;
	int BLOCKSIZEy = 16;
	xDim = 1024;//32;
	yDim = 1024;//32;
	tMax = 500;
	Re = 500.f;//100.f;
	uMax = 0.08f;
	CharLength = xDim-2.f;
	omega = 1.0f/(3.0f*(uMax*CharLength/Re)+0.5f);

	cout<<"omega: "<<omega<<endl;

	nBlocks = (xDim/BLOCKSIZEx+xDim%BLOCKSIZEx)*(yDim/BLOCKSIZEy+yDim%BLOCKSIZEy);
	int B = BLOCKSIZEx*BLOCKSIZEy;
	n = nBlocks*B;//block*dimx*dimy

	//CUT_DEVICE_INIT(argc,argv);

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

	//cudaMalloc((void **) &f0_d, memsize);
	//CUDA_SAFE_CALL(cudaMalloc((void **) &f1_d, memsize));
//	CUDA_SAFE_CALL(cudaMalloc((void **) &f1_dA, memsize));
//	CUDA_SAFE_CALL(cudaMalloc((void **) &f2_dA, memsize));
//	CUDA_SAFE_CALL(cudaMalloc((void **) &f3_dA, memsize));
//	CUDA_SAFE_CALL(cudaMalloc((void **) &f4_dA, memsize));
//	CUDA_SAFE_CALL(cudaMalloc((void **) &f5_dA, memsize));
//	CUDA_SAFE_CALL(cudaMalloc((void **) &f6_dA, memsize));
//	CUDA_SAFE_CALL(cudaMalloc((void **) &f7_dA, memsize));
//	CUDA_SAFE_CALL(cudaMalloc((void **) &f8_dA, memsize));
//	CUDA_SAFE_CALL(cudaMalloc((void **) &f1_dB, memsize));
//	CUDA_SAFE_CALL(cudaMalloc((void **) &f2_dB, memsize));
//	CUDA_SAFE_CALL(cudaMalloc((void **) &f3_dB, memsize));
//	CUDA_SAFE_CALL(cudaMalloc((void **) &f4_dB, memsize));
//	CUDA_SAFE_CALL(cudaMalloc((void **) &f5_dB, memsize));
//	CUDA_SAFE_CALL(cudaMalloc((void **) &f6_dB, memsize));
//	CUDA_SAFE_CALL(cudaMalloc((void **) &f7_dB, memsize));
//	CUDA_SAFE_CALL(cudaMalloc((void **) &f8_dB, memsize));
//	pitch = xDim*sizeof(float);
	cudaMallocPitch((void **) &f0_d , &pitch, xDim*sizeof(float), yDim);
	cudaMallocPitch((void **) &f1_dA, &pitch, xDim*sizeof(float), yDim);
	cudaMallocPitch((void **) &f2_dA, &pitch, xDim*sizeof(float), yDim);
	cudaMallocPitch((void **) &f3_dA, &pitch, xDim*sizeof(float), yDim);
	cudaMallocPitch((void **) &f4_dA, &pitch, xDim*sizeof(float), yDim);
	cudaMallocPitch((void **) &f5_dA, &pitch, xDim*sizeof(float), yDim);
	cudaMallocPitch((void **) &f6_dA, &pitch, xDim*sizeof(float), yDim);
	cudaMallocPitch((void **) &f7_dA, &pitch, xDim*sizeof(float), yDim);
	cudaMallocPitch((void **) &f8_dA, &pitch, xDim*sizeof(float), yDim);
	cudaMallocPitch((void **) &f1_dB, &pitch, xDim*sizeof(float), yDim);
	cudaMallocPitch((void **) &f2_dB, &pitch, xDim*sizeof(float), yDim);
	cudaMallocPitch((void **) &f3_dB, &pitch, xDim*sizeof(float), yDim);
	cudaMallocPitch((void **) &f4_dB, &pitch, xDim*sizeof(float), yDim);
	cudaMallocPitch((void **) &f5_dB, &pitch, xDim*sizeof(float), yDim);
	cudaMallocPitch((void **) &f6_dB, &pitch, xDim*sizeof(float), yDim);
	cudaMallocPitch((void **) &f7_dB, &pitch, xDim*sizeof(float), yDim);
	cudaMallocPitch((void **) &f8_dB, &pitch, xDim*sizeof(float), yDim);
	
	//CUDA_SAFE_CALL(cudaMalloc((void **) &f2_d, memsize));
	//CUDA_SAFE_CALL(cudaMalloc((void **) &f3_d, memsize));
	//CUDA_SAFE_CALL(cudaMalloc((void **) &f4_d, memsize));
	//CUDA_SAFE_CALL(cudaMalloc((void **) &f5_d, memsize));
	//CUDA_SAFE_CALL(cudaMalloc((void **) &f6_d, memsize));
	//CUDA_SAFE_CALL(cudaMalloc((void **) &f7_d, memsize));
	//CUDA_SAFE_CALL(cudaMalloc((void **) &f8_d, memsize));
	cudaMalloc((void **) &image_d, memsize_int);

	for (i = 0; i < n; i++)
	{
		int x = i%xDim;
		int y = i/xDim;
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
		if(x < 1) image_h[i] = 1;//DirichletWest
		if(x > xDim-2) image_h[i] = 1;//BB
		if(y < 1) image_h[i] = 1;//BB
		if(y > yDim-2) image_h[i] = 3;//BB

	}

	
	//cudaMemcpy(f0_d, f0_h, memsize, cudaMemcpyHostToDevice);
	//CUDA_SAFE_CALL(cudaMemcpy(f1_d, f1_h, memsize, cudaMemcpyHostToDevice));
//	CUDA_SAFE_CALL(cudaMemcpy(f1_dA,f1_h,memsize,cudaMemcpyHostToDevice));
//	CUDA_SAFE_CALL(cudaMemcpy(f2_dA,f2_h,memsize,cudaMemcpyHostToDevice));
//	CUDA_SAFE_CALL(cudaMemcpy(f3_dA,f3_h,memsize,cudaMemcpyHostToDevice));
//	CUDA_SAFE_CALL(cudaMemcpy(f4_dA,f4_h,memsize,cudaMemcpyHostToDevice));
//	CUDA_SAFE_CALL(cudaMemcpy(f5_dA,f5_h,memsize,cudaMemcpyHostToDevice));
//	CUDA_SAFE_CALL(cudaMemcpy(f6_dA,f6_h,memsize,cudaMemcpyHostToDevice));
//	CUDA_SAFE_CALL(cudaMemcpy(f7_dA,f7_h,memsize,cudaMemcpyHostToDevice));
//	CUDA_SAFE_CALL(cudaMemcpy(f8_dA,f8_h,memsize,cudaMemcpyHostToDevice));
//	CUDA_SAFE_CALL(cudaMemcpy(f1_dB,f1_h,memsize,cudaMemcpyHostToDevice));
//	CUDA_SAFE_CALL(cudaMemcpy(f2_dB,f2_h,memsize,cudaMemcpyHostToDevice));
//	CUDA_SAFE_CALL(cudaMemcpy(f3_dB,f3_h,memsize,cudaMemcpyHostToDevice));
//	CUDA_SAFE_CALL(cudaMemcpy(f4_dB,f4_h,memsize,cudaMemcpyHostToDevice));
//	CUDA_SAFE_CALL(cudaMemcpy(f5_dB,f5_h,memsize,cudaMemcpyHostToDevice));
//	CUDA_SAFE_CALL(cudaMemcpy(f6_dB,f6_h,memsize,cudaMemcpyHostToDevice));
//	CUDA_SAFE_CALL(cudaMemcpy(f7_dB,f7_h,memsize,cudaMemcpyHostToDevice));
//	CUDA_SAFE_CALL(cudaMemcpy(f8_dB,f8_h,memsize,cudaMemcpyHostToDevice));
	cudaMemcpy2D(f0_d ,pitch,f1_h,xDim*sizeof(float),xDim*sizeof(float),yDim,cudaMemcpyHostToDevice);
	cudaMemcpy2D(f1_dA,pitch,f1_h,xDim*sizeof(float),xDim*sizeof(float),yDim,cudaMemcpyHostToDevice);
	cudaMemcpy2D(f2_dA,pitch,f2_h,xDim*sizeof(float),xDim*sizeof(float),yDim,cudaMemcpyHostToDevice);
	cudaMemcpy2D(f3_dA,pitch,f3_h,xDim*sizeof(float),xDim*sizeof(float),yDim,cudaMemcpyHostToDevice);
	cudaMemcpy2D(f4_dA,pitch,f4_h,xDim*sizeof(float),xDim*sizeof(float),yDim,cudaMemcpyHostToDevice);
	cudaMemcpy2D(f5_dA,pitch,f5_h,xDim*sizeof(float),xDim*sizeof(float),yDim,cudaMemcpyHostToDevice);
	cudaMemcpy2D(f6_dA,pitch,f6_h,xDim*sizeof(float),xDim*sizeof(float),yDim,cudaMemcpyHostToDevice);
	cudaMemcpy2D(f7_dA,pitch,f7_h,xDim*sizeof(float),xDim*sizeof(float),yDim,cudaMemcpyHostToDevice);
	cudaMemcpy2D(f8_dA,pitch,f8_h,xDim*sizeof(float),xDim*sizeof(float),yDim,cudaMemcpyHostToDevice);
	cudaMemcpy2D(f1_dB,pitch,f1_h,xDim*sizeof(float),xDim*sizeof(float),yDim,cudaMemcpyHostToDevice);
	cudaMemcpy2D(f2_dB,pitch,f2_h,xDim*sizeof(float),xDim*sizeof(float),yDim,cudaMemcpyHostToDevice);
	cudaMemcpy2D(f3_dB,pitch,f3_h,xDim*sizeof(float),xDim*sizeof(float),yDim,cudaMemcpyHostToDevice);
	cudaMemcpy2D(f4_dB,pitch,f4_h,xDim*sizeof(float),xDim*sizeof(float),yDim,cudaMemcpyHostToDevice);
	cudaMemcpy2D(f5_dB,pitch,f5_h,xDim*sizeof(float),xDim*sizeof(float),yDim,cudaMemcpyHostToDevice);
	cudaMemcpy2D(f6_dB,pitch,f6_h,xDim*sizeof(float),xDim*sizeof(float),yDim,cudaMemcpyHostToDevice);
	cudaMemcpy2D(f7_dB,pitch,f7_h,xDim*sizeof(float),xDim*sizeof(float),yDim,cudaMemcpyHostToDevice);
	cudaMemcpy2D(f8_dB,pitch,f8_h,xDim*sizeof(float),xDim*sizeof(float),yDim,cudaMemcpyHostToDevice);
	
	//CUDA_SAFE_CALL(cudaMemcpy(f2_d, f2_h, memsize, cudaMemcpyHostToDevice));
	//CUDA_SAFE_CALL(cudaMemcpy(f3_d, f3_h, memsize, cudaMemcpyHostToDevice));
	//CUDA_SAFE_CALL(cudaMemcpy(f4_d, f4_h, memsize, cudaMemcpyHostToDevice));
	//CUDA_SAFE_CALL(cudaMemcpy(f5_d, f5_h, memsize, cudaMemcpyHostToDevice));
	//CUDA_SAFE_CALL(cudaMemcpy(f6_d, f6_h, memsize, cudaMemcpyHostToDevice));
	//CUDA_SAFE_CALL(cudaMemcpy(f7_d, f7_h, memsize, cudaMemcpyHostToDevice));
	//CUDA_SAFE_CALL(cudaMemcpy(f8_d, f8_h, memsize, cudaMemcpyHostToDevice));
	cudaMemcpy(image_d, image_h, memsize_int, cudaMemcpyHostToDevice);

	cudaChannelFormatDesc desc = cudaCreateChannelDesc<float>();

	//cout<<(int)(pitch/sizeof(float))<<endl;


    dim3 threads(BLOCKSIZEx, BLOCKSIZEy);
    dim3 grid(xDim/BLOCKSIZEx,yDim/BLOCKSIZEy);

	cout<<"nBlocks:"<<nBlocks<<endl;
	
	texRef_f1A.normalized = false;
	texRef_f2A.normalized = false;
	texRef_f3A.normalized = false;
	texRef_f4A.normalized = false;
	texRef_f5A.normalized = false;
	texRef_f6A.normalized = false;
	texRef_f7A.normalized = false;
	texRef_f8A.normalized = false;
	texRef_f1A.filterMode = cudaFilterModePoint;
	texRef_f2A.filterMode = cudaFilterModePoint;
	texRef_f3A.filterMode = cudaFilterModePoint;
	texRef_f4A.filterMode = cudaFilterModePoint;
	texRef_f5A.filterMode = cudaFilterModePoint;
	texRef_f6A.filterMode = cudaFilterModePoint;
	texRef_f7A.filterMode = cudaFilterModePoint;
	texRef_f8A.filterMode = cudaFilterModePoint;
	texRef_f1B.normalized = false;
	texRef_f2B.normalized = false;
	texRef_f3B.normalized = false;
	texRef_f4B.normalized = false;
	texRef_f5B.normalized = false;
	texRef_f6B.normalized = false;
	texRef_f7B.normalized = false;
	texRef_f8B.normalized = false;
	texRef_f1B.filterMode = cudaFilterModePoint;
	texRef_f2B.filterMode = cudaFilterModePoint;
	texRef_f3B.filterMode = cudaFilterModePoint;
	texRef_f4B.filterMode = cudaFilterModePoint;
	texRef_f5B.filterMode = cudaFilterModePoint;
	texRef_f6B.filterMode = cudaFilterModePoint;
	texRef_f7B.filterMode = cudaFilterModePoint;
	texRef_f8B.filterMode = cudaFilterModePoint;
	
	initialize<<<grid, threads>>>(f0_d, f1_dA, f2_dA, f3_dA, f4_dA, f5_dA, f6_dA, f7_dA, f8_dA,
									n,(int)(pitch/sizeof(float)));

	cudaBindTexture2D(0,&texRef_f1A, f1_dA,&desc,xDim,yDim,pitch);
	cudaBindTexture2D(0,&texRef_f2A, f2_dA,&desc,xDim,yDim,pitch);
	cudaBindTexture2D(0,&texRef_f3A, f3_dA,&desc,xDim,yDim,pitch);
	cudaBindTexture2D(0,&texRef_f4A, f4_dA,&desc,xDim,yDim,pitch);
	cudaBindTexture2D(0,&texRef_f5A, f5_dA,&desc,xDim,yDim,pitch);
	cudaBindTexture2D(0,&texRef_f6A, f6_dA,&desc,xDim,yDim,pitch);
	cudaBindTexture2D(0,&texRef_f7A, f7_dA,&desc,xDim,yDim,pitch);
	cudaBindTexture2D(0,&texRef_f8A, f8_dA,&desc,xDim,yDim,pitch);

	cudaBindTexture2D(0,&texRef_f1B, f1_dB,&desc,xDim,yDim,pitch);
	cudaBindTexture2D(0,&texRef_f2B, f2_dB,&desc,xDim,yDim,pitch);
	cudaBindTexture2D(0,&texRef_f3B, f3_dB,&desc,xDim,yDim,pitch);
	cudaBindTexture2D(0,&texRef_f4B, f4_dB,&desc,xDim,yDim,pitch);
	cudaBindTexture2D(0,&texRef_f5B, f5_dB,&desc,xDim,yDim,pitch);
	cudaBindTexture2D(0,&texRef_f6B, f6_dB,&desc,xDim,yDim,pitch);
	cudaBindTexture2D(0,&texRef_f7B, f7_dB,&desc,xDim,yDim,pitch);
	cudaBindTexture2D(0,&texRef_f8B, f8_dB,&desc,xDim,yDim,pitch);

	struct timeval tdr0,tdr1;
	double restime;
	cudaDeviceSynchronize();
	gettimeofday (&tdr0,NULL);
	for(int t = 0; t<tMax; t=t+2){
	//for(int t = 0; t<tMax; t=t+1){
		//mrt_d<<<grid, threads>>>(f0_d,f1_d,f2_d,f3_d,f4_d,f5_d,f6_d,f7_d,f8_d,n,image_d,omega,uMax);
		//test<<<grid, threads>>>(f0_d,f1_dA,f2_dA,f3_dA,f4_dA,f5_dA,f6_dA,f7_dA,f8_dA,
		mrt_d_textAB<<<grid, threads>>>(f0_d,f1_dA,f2_dA,f3_dA,f4_dA,f5_dA,f6_dA,f7_dA,f8_dA,
									        f1_dB,f2_dB,f3_dB,f4_dB,f5_dB,f6_dB,f7_dB,f8_dB,
										    n,image_d,omega,uMax,(int)(pitch/sizeof(float)));


		//test<<<grid, threads>>>(f0_d,f1_dB,f2_dB,f3_dB,f4_dB,f5_dB,f6_dB,f7_dB,f8_dB,
		mrt_d_textBA<<<grid, threads>>>(f0_d,f1_dB,f2_dB,f3_dB,f4_dB,f5_dB,f6_dB,f7_dB,f8_dB,
										   f1_dA,f2_dA,f3_dA,f4_dA,f5_dA,f6_dA,f7_dA,f8_dA,
										   n,image_d,omega,uMax,(int)(pitch/sizeof(float)));

		if(t%1000 == 0 && t>0) cout<<"finished "<<t<<" timesteps\n";
	}
	cudaDeviceSynchronize();
	gettimeofday (&tdr1,NULL);
	timeval_subtract (&restime, &tdr1, &tdr0);
	cout<<"Time taken for main kernel: "<<restime<<" ("<<double(xDim*yDim*double(tMax/1000000.f))/restime<<"MLUPS)"<<endl;
	cout<<xDim<<","<<yDim<<","<<tMax<<","<<restime<<endl;


		cudaUnbindTexture(texRef_f1A);
		cudaUnbindTexture(texRef_f2A);
		cudaUnbindTexture(texRef_f3A);
		cudaUnbindTexture(texRef_f4A);
		cudaUnbindTexture(texRef_f5A);
		cudaUnbindTexture(texRef_f6A);
		cudaUnbindTexture(texRef_f7A);
		cudaUnbindTexture(texRef_f8A);
		cudaUnbindTexture(texRef_f1B);
		cudaUnbindTexture(texRef_f2B);
		cudaUnbindTexture(texRef_f3B);
		cudaUnbindTexture(texRef_f4B);
		cudaUnbindTexture(texRef_f5B);
		cudaUnbindTexture(texRef_f6B);
		cudaUnbindTexture(texRef_f7B);
		cudaUnbindTexture(texRef_f8B);


	//CUT_CHECK_ERROR("Kernel execution failed");

		//cudaMemcpy(f0_h, f0_d, memsize, cudaMemcpyDeviceToHost);
		//CUDA_SAFE_CALL(cudaMemcpy(f1_h, f1_d, memsize, cudaMemcpyDeviceToHost));
//		CUDA_SAFE_CALL(cudaMemcpy(f1_h,f1_dB,memsize,cudaMemcpyDeviceToHost));
//		CUDA_SAFE_CALL(cudaMemcpy(f2_h,f2_dB,memsize,cudaMemcpyDeviceToHost));
//		CUDA_SAFE_CALL(cudaMemcpy(f3_h,f3_dB,memsize,cudaMemcpyDeviceToHost));
//		CUDA_SAFE_CALL(cudaMemcpy(f4_h,f4_dB,memsize,cudaMemcpyDeviceToHost));
//		CUDA_SAFE_CALL(cudaMemcpy(f5_h,f5_dB,memsize,cudaMemcpyDeviceToHost));
//		CUDA_SAFE_CALL(cudaMemcpy(f6_h,f6_dB,memsize,cudaMemcpyDeviceToHost));
//		CUDA_SAFE_CALL(cudaMemcpy(f7_h,f7_dB,memsize,cudaMemcpyDeviceToHost));
//		CUDA_SAFE_CALL(cudaMemcpy(f8_h,f8_dB,memsize,cudaMemcpyDeviceToHost));
		cudaMemcpy2D(f0_h,xDim*sizeof(float),f0_d ,pitch,xDim*sizeof(float),yDim,cudaMemcpyDeviceToHost);
		cudaMemcpy2D(f1_h,xDim*sizeof(float),f1_dB,pitch,xDim*sizeof(float),yDim,cudaMemcpyDeviceToHost);
		cudaMemcpy2D(f2_h,xDim*sizeof(float),f2_dB,pitch,xDim*sizeof(float),yDim,cudaMemcpyDeviceToHost);
		cudaMemcpy2D(f3_h,xDim*sizeof(float),f3_dB,pitch,xDim*sizeof(float),yDim,cudaMemcpyDeviceToHost);
		cudaMemcpy2D(f4_h,xDim*sizeof(float),f4_dB,pitch,xDim*sizeof(float),yDim,cudaMemcpyDeviceToHost);
		cudaMemcpy2D(f5_h,xDim*sizeof(float),f5_dB,pitch,xDim*sizeof(float),yDim,cudaMemcpyDeviceToHost);
		cudaMemcpy2D(f6_h,xDim*sizeof(float),f6_dB,pitch,xDim*sizeof(float),yDim,cudaMemcpyDeviceToHost);
		cudaMemcpy2D(f7_h,xDim*sizeof(float),f7_dB,pitch,xDim*sizeof(float),yDim,cudaMemcpyDeviceToHost);
		cudaMemcpy2D(f8_h,xDim*sizeof(float),f8_dB,pitch,xDim*sizeof(float),yDim,cudaMemcpyDeviceToHost);
		//CUDA_SAFE_CALL(cudaMemcpy(f2_h, f2_d, memsize, cudaMemcpyDeviceToHost));
		//CUDA_SAFE_CALL(cudaMemcpy(f3_h, f3_d, memsize, cudaMemcpyDeviceToHost));
		//CUDA_SAFE_CALL(cudaMemcpy(f4_h, f4_d, memsize, cudaMemcpyDeviceToHost));
		//CUDA_SAFE_CALL(cudaMemcpy(f5_h, f5_d, memsize, cudaMemcpyDeviceToHost));
		//CUDA_SAFE_CALL(cudaMemcpy(f6_h, f6_d, memsize, cudaMemcpyDeviceToHost));
		//CUDA_SAFE_CALL(cudaMemcpy(f7_h, f7_d, memsize, cudaMemcpyDeviceToHost));
		//CUDA_SAFE_CALL(cudaMemcpy(f8_h, f8_d, memsize, cudaMemcpyDeviceToHost));
		output<<"VARIABLES = \"X\",\"Y\",\"u\",\"v\",\"rho\"\n";
		output<<"ZONE F=POINT, I="<<xDim<<", J="<<yDim<<"\n";
		
//		for(i = 0; i<n; i++)
//		{
		int row = 0;
		int col = 0;
		i = 0;
		//int rowB, colB;
		//float xcoord, ycoord;
		float rho, u, v;
		rho = 0;
		u = 0;
		v = 0;

			for(row = 0; row<yDim; row++){
				for(col = 0; col<xDim; col++){
					i = row*xDim+col;
					rho = f0_h[i]+f1_h[i]+f2_h[i]+f3_h[i]+f4_h[i]+f5_h[i]+f6_h[i]+f7_h[i]+f8_h[i];
					u = f1_h[i]-f3_h[i]+f5_h[i]-f6_h[i]-f7_h[i]+f8_h[i];
					v = f2_h[i]-f4_h[i]+f5_h[i]+f6_h[i]-f7_h[i]-f8_h[i];
					output<<col<<", "<<row<<", "<<u<<","<<v<<","<<rho<<endl;
				}
			}


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

	cudaFree(f0_d);
	cudaFree(f1_dA);
	cudaFree(f2_dA);
	cudaFree(f3_dA);
	cudaFree(f4_dA);
	cudaFree(f5_dA);
	cudaFree(f6_dA);
	cudaFree(f7_dA);
	cudaFree(f8_dA);
	cudaFree(f1_dB);
	cudaFree(f2_dB);
	cudaFree(f3_dB);
	cudaFree(f4_dB);
	cudaFree(f5_dB);
	cudaFree(f6_dB);
	cudaFree(f7_dB);
	cudaFree(f8_dB);
	cudaFree(image_d);

	return(0);

}
