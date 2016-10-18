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
texture<float,3,cudaReadModeElementType> texRef_f1A;
texture<float,3,cudaReadModeElementType> texRef_f2A;
texture<float,3,cudaReadModeElementType> texRef_f3A;
texture<float,3,cudaReadModeElementType> texRef_f4A;
texture<float,3,cudaReadModeElementType> texRef_f5A;
texture<float,3,cudaReadModeElementType> texRef_f6A;
texture<float,3,cudaReadModeElementType> texRef_f7A;
texture<float,3,cudaReadModeElementType> texRef_f8A;
texture<float,3,cudaReadModeElementType> texRef_f9A;
texture<float,3,cudaReadModeElementType> texRef_f10A;
texture<float,3,cudaReadModeElementType> texRef_f11A;
texture<float,3,cudaReadModeElementType> texRef_f12A;
texture<float,3,cudaReadModeElementType> texRef_f13A;
texture<float,3,cudaReadModeElementType> texRef_f14A;
texture<float,3,cudaReadModeElementType> texRef_f15A;
texture<float,3,cudaReadModeElementType> texRef_f16A;
texture<float,3,cudaReadModeElementType> texRef_f17A;
texture<float,3,cudaReadModeElementType> texRef_f18A;


surface<void, 3> surfRef;

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


//__global__ void test(float *f0A, float *f1A, float *f2A,
//						   float *f3A, float *f4A, float *f5A,
//						   float *f6A, float *f7A, float *f8A,
//						               float *f1B, float *f2B,
//						   float *f3B, float *f4B, float *f5B,
//						   float *f6B, float *f7B, float *f8B, //int pitch)
//						   int n, int *image, float omega, float uMax, int pitch)
//{
//	int x = blockIdx.x*blockDim.x+threadIdx.x;
//	int y = blockIdx.y*blockDim.y+threadIdx.y;
////	int i = x+y*blockDim.x*gridDim.x;
////	j = threadIdx.y*blockDim.x+threadIdx.x;//local block index (for shared mem)
////	i = j+blockDim.x*blockDim.y*gridDim.x*blockIdx.y;
////	i += blockDim.x*blockDim.y*blockIdx.x;//global memory index
//
//		//f0A[i] = f;
//		float f1,f2,f3,f4,f5,f6,f7,f8;
////		f1=tex2D(texRef_f1,x+1,y  );
////		f2=tex2D(texRef_f2,x-1,y  );
////		f3=tex2D(texRef_f3,x  ,y+1);
////		f4=tex2D(texRef_f4,x  ,y-1);
////		f5=tex2D(texRef_f5,x+1,y+1);
////		f7=tex2D(texRef_f7,x-1,y-1);
////		f6=tex2D(texRef_f6,x-1,y+1);
////		f8=tex2D(texRef_f8,x+1,y-1);
//		//if(image[i] == 0){
//
////		f1 = tex2D(texRef_f1,x-1,y  );
////		f2 = tex2D(texRef_f2,x  ,y-1);
////		f3 = tex2D(texRef_f3,x+1,y  );
////		f4 = tex2D(texRef_f4,x  ,y+1);
////		f5 = tex2D(texRef_f5,x-1,y-1);
////		f6 = tex2D(texRef_f6,x+1,y-1);
////		f7 = tex2D(texRef_f7,x+1,y+1);
////		f8 = tex2D(texRef_f8,x-1,y+1);
//
////		f1 = f1A[x-1+y*pitch];
////		f2 = f2A[x  +(y-1)*pitch];
////		f3 = f3A[x+1+y*pitch];
////		f4 = f4A[x  +(y+1)*pitch];
////		f5 = f5A[x-1+(y-1)*pitch];
////		f6 = f6A[x+1+(y-1)*pitch];
////		f7 = f7A[x+1+(y+1)*pitch];
////		f8 = f8A[x-1+(y+1)*pitch];
//
////		f1=f1A[x+1+(y  )*pitch];
////		f2=f2A[x-1+(y  )*pitch];
////		f3=f3A[x  +(y+1)*pitch];
////		f4=f4A[x  +(y-1)*pitch];
////		f5=f5A[x+1+(y+1)*pitch];
////		f7=f7A[x-1+(y-1)*pitch];
////		f6=f6A[x-1+(y+1)*pitch];
////		f8=f8A[x+1+(y-1)*pitch];
//		f1=f1A[x+y*pitch];
//		f2=f2A[x+y*pitch];
//		f3=f3A[x+y*pitch];
//		f4=f4A[x+y*pitch];
//		f5=f5A[x+y*pitch];
//		f6=f6A[x+y*pitch];
//		f7=f7A[x+y*pitch];
//		f8=f8A[x+y*pitch];
////		f1B[x+y*pitch]=f1+1;
////		f3B[x+y*pitch]=f3+1;
////		f2B[x+y*pitch]=f2+1;
////		f4B[x+y*pitch]=f4+1;
////		f5B[x+y*pitch]=f5+1;
////		f6B[x+y*pitch]=f6+1;
////		f7B[x+y*pitch]=f7+1;
////		f8B[x+y*pitch]=f8+1;
//		//}
////		f1=f1A[x+y*pitch];
////		f3=f3A[x+y*pitch];
////		f2=f2A[x+y*pitch];
////		f4=f4A[x+y*pitch];
////		f5=f5A[x+y*pitch];
////		f7=f7A[x+y*pitch];
////		f6=f6A[x+y*pitch];
////		f8=f8A[x+y*pitch];
//		f1B[x+y*pitch]=f1;
//		f2B[x+y*pitch]=f2;
//		f3B[x+y*pitch]=f3;
//		f4B[x+y*pitch]=f4;
//		f5B[x+y*pitch]=f5;
//		f6B[x+y*pitch]=f6;
//		f7B[x+y*pitch]=f7;
//		f8B[x+y*pitch]=f8;
//
//
//}
//__global__ void mrt_d_textAB(float *f0A, float *f1A, float *f2A,
//						   float *f3A, float *f4A, float *f5A,
//						   float *f6A, float *f7A, float *f8A,
//						               float *f1B, float *f2B,
//						   float *f3B, float *f4B, float *f5B,
//						   float *f6B, float *f7B, float *f8B,
//						   int n, int *image, float omega, float uMax, int pitch)
//{
//	int x = blockIdx.x*blockDim.x+threadIdx.x;
//	int y = blockIdx.y*blockDim.y+threadIdx.y;
//	int i = x+y*blockDim.x*gridDim.x;
//	float u,v,rho;//,usqr;
//	int im = image[i];
//	if(im == 1){//BB
//		//f0A[i] = f0A[i];
//		f0A[x+y*pitch]=f0A[x+y*pitch];
//		f1B[x+y*pitch]=tex2D(texRef_f3A,x+1,y  );
//		f3B[x+y*pitch]=tex2D(texRef_f1A,x-1,y  );
//		f2B[x+y*pitch]=tex2D(texRef_f4A,x  ,y+1);
//		f4B[x+y*pitch]=tex2D(texRef_f2A,x  ,y-1);
//		f5B[x+y*pitch]=tex2D(texRef_f7A,x+1,y+1);
//		f7B[x+y*pitch]=tex2D(texRef_f5A,x-1,y-1);
//		f6B[x+y*pitch]=tex2D(texRef_f8A,x-1,y+1);
//		f8B[x+y*pitch]=tex2D(texRef_f6A,x+1,y-1);
//
////		f0A[x+y*pitch] = f0A[x+y*pitch];
////		f1B[x+y*pitch] = f1A[x+1+(y  )*pitch];
////		f3B[x+y*pitch] = f2A[x-1+(y  )*pitch];
////		f2B[x+y*pitch] = f3A[x  +(y+1)*pitch];
////		f4B[x+y*pitch] = f4A[x  +(y-1)*pitch];
////		f5B[x+y*pitch] = f5A[x+1+(y+1)*pitch];
////		f7B[x+y*pitch] = f6A[x-1+(y-1)*pitch];
////		f6B[x+y*pitch] = f7A[x-1+(y+1)*pitch];
////		f8B[x+y*pitch] = f8A[x+1+(y-1)*pitch];
//
////		f0A[x+y*pitch] = f0A[x+y*pitch];
////		f1B[x+y*pitch] = f1A[x+(y)*pitch];
////		f3B[x+y*pitch] = f2A[x+(y)*pitch];
////		f2B[x+y*pitch] = f3A[x+(y)*pitch];
////		f4B[x+y*pitch] = f4A[x+(y)*pitch];
////		f5B[x+y*pitch] = f5A[x+(y)*pitch];
////		f7B[x+y*pitch] = f6A[x+(y)*pitch];
////		f6B[x+y*pitch] = f7A[x+(y)*pitch];
////		f8B[x+y*pitch] = f8A[x+(y)*pitch];
//
//
//	}
//	else{
//		float f0,f1,f2,f3,f4,f5,f6,f7,f8;
//		//float u,v,rho,feq,usqr;
////		float meq1,meq2,meq4,meq6,meq7,meq8;
////		f0 = f0A[i];
//
//		f1 = tex2D(texRef_f1A,x-1,y  );
//		f2 = tex2D(texRef_f2A,x  ,y-1);
//		f3 = tex2D(texRef_f3A,x+1,y  );
//		f4 = tex2D(texRef_f4A,x  ,y+1);
//		f5 = tex2D(texRef_f5A,x-1,y-1);
//		f6 = tex2D(texRef_f6A,x+1,y-1);
//		f7 = tex2D(texRef_f7A,x+1,y+1);
//		f8 = tex2D(texRef_f8A,x-1,y+1);
//		f0 = f0A[x  +y*pitch];
//
////		f0 = f0A[x  +y*pitch];
////		f1 = f1A[x+y*pitch];
////		f2 = f2A[x+y*pitch];
////		f3 = f3A[x+y*pitch];
////		f4 = f4A[x+y*pitch];
////		f5 = f5A[x+y*pitch];
////		f6 = f6A[x+y*pitch];
////		f7 = f7A[x+y*pitch];
////		f8 = f8A[x+y*pitch];
//	
////		f0 = f0A[x  +y*pitch];
////		f1 = f1A[x-1+y*pitch];
////		f2 = f2A[x  +(y-1)*pitch];
////		f3 = f3A[x+1+y*pitch];
////		f4 = f4A[x  +(y+1)*pitch];
////		f5 = f5A[x-1+(y-1)*pitch];
////		f6 = f6A[x+1+(y-1)*pitch];
////		f7 = f7A[x+1+(y+1)*pitch];
////		f8 = f8A[x-1+(y+1)*pitch];
//	
//		rho = f0+f1+f2+f3+f4+f5+f6+f7+f8;
//		u = f1-f3+f5-f6-f7+f8;
//		v = f2-f4+f5+f6-f7-f8;
//		if(im == 2){
//			u = 0.0f;
//			v = uMax;
//			rho = u+(f0+f2+f4+2.0f*f3+2.0f*f6+2.0f*f7);
//			//f1 = f3+4.0f*u/6.0f;
//			f1 = f3+u/1.5f;
//	        f5 = f7-0.5f*(f2-f4)+v*0.5f+u/6.0f;
//	        f8 = f6+0.5f*(f2-f4)-v*0.5f+u/6.0f;	
//		}
//		else if(im == 3){//north
//			u = uMax;
//			v = 0.0f;
//			rho = -v+(f0+f1+f3+2.0f*f6+2.0f*f2+2.0f*f5);
//			//f4 = f2-4.0f*v/6.0f;
//			f4 = f2-v/1.5f;
//	        f7 = f5+0.5f*(f1-f3)-u*0.5f+v/6.0f;
//	        f8 = f6-0.5f*(f1-f3)+u*0.5f+v/6.0f;	
//		}
////		usqr = u*u+v*v;
//		float m1,m2,m4,m6,m7,m8;
//		m1 =-4.f*f0 -    f1 -    f2 -    f3 -    f4+ 2.f*f5+ 2.f*f6+ 2.f*f7+ 2.f*f8-(-2.0f*rho+3.0f*(u*u+v*v));
//		m2 = 4.f*f0 -2.f*f1 -2.f*f2 -2.f*f3 -2.f*f4+     f5+     f6+     f7+     f8-(rho-3.0f*(u*u+v*v)); //ep
//		m4 =        -2.f*f1        + 2.f*f3        +     f5 -    f6 -    f7+     f8-(-u);//qx_eq
//		m6 =                -2.f*f2        + 2.f*f4+     f5+     f6 -    f7 -    f8-(-v);//qy_eq
//		m7 =             f1 -    f2+     f3 -    f4                                -(u*u-v*v);//pxx_eq
//		m8 =                                             f5 -    f6+     f7 -    f8-(u*v);//pxy_eq
//
////		float Q11 = (m7-meq7)*0.5f;
////		float Q22 = -Q11;
////		float Q12 = m8-meq8;
////		float Q21 = Q12;
////		float Q = Q11*Q11+Q12*Q12+Q21*Q21+Q22*Q22;
////	
////		float Cs = 0.01f;
////		float nu0 = ((1.0f/omega)-0.5f)/3.0f;
////		float Smag = (sqrt((2.0f*rho/(3.0f*omega))*(2.0f*rho/(3.0f*omega))
////				+4.0f*2.0f*rho*Cs*sqrt(Q))-2.0f*rho/(3.0f*omega))/(4.0f*rho*Cs);
////		float OmegaStar = omega;//1.0f/(3.0f*(nu0+Cs*Smag)+0.5f);
//
//f0A[y*pitch+x]=f0-(-m1+m2)/9.0f;//(-4.f*(m1)/36.0f+4.f *(m2)/36.0f);
//f1B[y*pitch+x]=f1-(-m1-2.0f*(m2+m4)+m7*omega*9.0f)/36.0f;
//f2B[y*pitch+x]=f2-(-m1-2.f*m2-6.f*m6-m7*omega*9.0f)/36.0f;
//f3B[y*pitch+x]=f3-(-m1-2.f*m2+6.f*m4+m7*omega*9.0f)/36.0f;
//f4B[y*pitch+x]=f4-(-m1-2.f*m2+6.f*m6-m7*omega*9.0f)/36.0f;
//f5B[y*pitch+x]=f5-(2.f*m1+m2+3.f*m4+3.f*m6+m8*omega*9.0f)/36.0f;
//f6B[y*pitch+x]=f6-(2.f*m1+m2-3.f*m4+3.f*m6-m8*omega*9.0f)/36.0f;
//f7B[y*pitch+x]=f7-(2.f*m1+m2-3.f*m4-3.f*m6+m8*omega*9.0f)/36.0f;
//f8B[y*pitch+x]=f8-(2.f*m1+m2+3.f*m4-3.f*m6-m8*omega*9.0f)/36.0f;
////f0A[y*pitch+x]=f0;
////f1B[y*pitch+x]=f1;
////f2B[y*pitch+x]=f2;
////f3B[y*pitch+x]=f3;
////f4B[y*pitch+x]=f4;
////f5B[y*pitch+x]=f5;
////f6B[y*pitch+x]=f6;
////f7B[y*pitch+x]=f7;
////f8B[y*pitch+x]=f8;
//	}
//}
//
//__global__ void mrt_d_textBA(float *f0A, float *f1A, float *f2A,
//						   float *f3A, float *f4A, float *f5A,
//						   float *f6A, float *f7A, float *f8A,
//						               float *f1B, float *f2B,
//						   float *f3B, float *f4B, float *f5B,
//						   float *f6B, float *f7B, float *f8B,
//						   int n, int *image, float omega, float uMax, int pitch)
//{
//	int x = blockIdx.x*blockDim.x+threadIdx.x;
//	int y = blockIdx.y*blockDim.y+threadIdx.y;
//	int i = x+y*blockDim.x*gridDim.x;
//	float u,v,rho;//,usqr;
//	int im = image[i];
//	if(im == 1){//BB
//		//f0A[i] = f0A[i];
//		f0A[x+y*pitch]=f0A[x+y*pitch];
//		f1B[x+y*pitch]=tex2D(texRef_f3B,x+1,y  );
//		f3B[x+y*pitch]=tex2D(texRef_f1B,x-1,y  );
//		f2B[x+y*pitch]=tex2D(texRef_f4B,x  ,y+1);
//		f4B[x+y*pitch]=tex2D(texRef_f2B,x  ,y-1);
//		f5B[x+y*pitch]=tex2D(texRef_f7B,x+1,y+1);
//		f7B[x+y*pitch]=tex2D(texRef_f5B,x-1,y-1);
//		f6B[x+y*pitch]=tex2D(texRef_f8B,x-1,y+1);
//		f8B[x+y*pitch]=tex2D(texRef_f6B,x+1,y-1);
//
////		f0A[x+y*pitch] = f0A[x+y*pitch];
////		f1B[x+y*pitch] = f1A[x+1+(y  )*pitch];
////		f3B[x+y*pitch] = f2A[x-1+(y  )*pitch];
////		f2B[x+y*pitch] = f3A[x  +(y+1)*pitch];
////		f4B[x+y*pitch] = f4A[x  +(y-1)*pitch];
////		f5B[x+y*pitch] = f5A[x+1+(y+1)*pitch];
////		f7B[x+y*pitch] = f6A[x-1+(y-1)*pitch];
////		f6B[x+y*pitch] = f7A[x-1+(y+1)*pitch];
////		f8B[x+y*pitch] = f8A[x+1+(y-1)*pitch];
//
////		f0A[x+y*pitch] = f0A[x+y*pitch];
////		f1B[x+y*pitch] = f1A[x+(y)*pitch];
////		f3B[x+y*pitch] = f2A[x+(y)*pitch];
////		f2B[x+y*pitch] = f3A[x+(y)*pitch];
////		f4B[x+y*pitch] = f4A[x+(y)*pitch];
////		f5B[x+y*pitch] = f5A[x+(y)*pitch];
////		f7B[x+y*pitch] = f6A[x+(y)*pitch];
////		f6B[x+y*pitch] = f7A[x+(y)*pitch];
////		f8B[x+y*pitch] = f8A[x+(y)*pitch];
//
//
//	}
//	else{
//		float f0,f1,f2,f3,f4,f5,f6,f7,f8;
//		//float u,v,rho,feq,usqr;
////		float meq1,meq2,meq4,meq6,meq7,meq8;
////		f0 = f0A[i];
//
//		f1 = tex2D(texRef_f1B,x-1,y  );
//		f2 = tex2D(texRef_f2B,x  ,y-1);
//		f3 = tex2D(texRef_f3B,x+1,y  );
//		f4 = tex2D(texRef_f4B,x  ,y+1);
//		f5 = tex2D(texRef_f5B,x-1,y-1);
//		f6 = tex2D(texRef_f6B,x+1,y-1);
//		f7 = tex2D(texRef_f7B,x+1,y+1);
//		f8 = tex2D(texRef_f8B,x-1,y+1);
//		f0 = f0A[x  +y*pitch];
//
////		f0 = f0A[x  +y*pitch];
////		f1 = f1A[x+y*pitch];
////		f2 = f2A[x+y*pitch];
////		f3 = f3A[x+y*pitch];
////		f4 = f4A[x+y*pitch];
////		f5 = f5A[x+y*pitch];
////		f6 = f6A[x+y*pitch];
////		f7 = f7A[x+y*pitch];
////		f8 = f8A[x+y*pitch];
//	
////		f0 = f0A[x  +y*pitch];
////		f1 = f1A[x-1+y*pitch];
////		f2 = f2A[x  +(y-1)*pitch];
////		f3 = f3A[x+1+y*pitch];
////		f4 = f4A[x  +(y+1)*pitch];
////		f5 = f5A[x-1+(y-1)*pitch];
////		f6 = f6A[x+1+(y-1)*pitch];
////		f7 = f7A[x+1+(y+1)*pitch];
////		f8 = f8A[x-1+(y+1)*pitch];
//	
//		rho = f0+f1+f2+f3+f4+f5+f6+f7+f8;
//		u = f1-f3+f5-f6-f7+f8;
//		v = f2-f4+f5+f6-f7-f8;
//		if(im == 2){
//			u = 0.0f;
//			v = uMax;
//			rho = u+(f0+f2+f4+2.0f*f3+2.0f*f6+2.0f*f7);
//			//f1 = f3+4.0f*u/6.0f;
//			f1 = f3+u/1.5f;
//	        f5 = f7-0.5f*(f2-f4)+v*0.5f+u/6.0f;
//	        f8 = f6+0.5f*(f2-f4)-v*0.5f+u/6.0f;	
//		}
//		else if(im == 3){//north
//			u = uMax;
//			v = 0.0f;
//			rho = -v+(f0+f1+f3+2.0f*f6+2.0f*f2+2.0f*f5);
//			//f4 = f2-4.0f*v/6.0f;
//			f4 = f2-v/1.5f;
//	        f7 = f5+0.5f*(f1-f3)-u*0.5f+v/6.0f;
//	        f8 = f6-0.5f*(f1-f3)+u*0.5f+v/6.0f;	
//		}
////		usqr = u*u+v*v;
//		float m1,m2,m4,m6,m7,m8;
//		m1 =-4.f*f0 -    f1 -    f2 -    f3 -    f4+ 2.f*f5+ 2.f*f6+ 2.f*f7+ 2.f*f8-(-2.0f*rho+3.0f*(u*u+v*v));
//		m2 = 4.f*f0 -2.f*f1 -2.f*f2 -2.f*f3 -2.f*f4+     f5+     f6+     f7+     f8-(rho-3.0f*(u*u+v*v)); //ep
//		m4 =        -2.f*f1        + 2.f*f3        +     f5 -    f6 -    f7+     f8-(-u);//qx_eq
//		m6 =                -2.f*f2        + 2.f*f4+     f5+     f6 -    f7 -    f8-(-v);//qy_eq
//		m7 =             f1 -    f2+     f3 -    f4                                -(u*u-v*v);//pxx_eq
//		m8 =                                             f5 -    f6+     f7 -    f8-(u*v);//pxy_eq
//
////		float Q11 = (m7-meq7)*0.5f;
////		float Q22 = -Q11;
////		float Q12 = m8-meq8;
////		float Q21 = Q12;
////		float Q = Q11*Q11+Q12*Q12+Q21*Q21+Q22*Q22;
////	
////		float Cs = 0.01f;
////		float nu0 = ((1.0f/omega)-0.5f)/3.0f;
////		float Smag = (sqrt((2.0f*rho/(3.0f*omega))*(2.0f*rho/(3.0f*omega))
////				+4.0f*2.0f*rho*Cs*sqrt(Q))-2.0f*rho/(3.0f*omega))/(4.0f*rho*Cs);
////		float OmegaStar = omega;//1.0f/(3.0f*(nu0+Cs*Smag)+0.5f);
//
//f0A[y*pitch+x]=f0-(-m1+m2)/9.0f;//(-4.f*(m1)/36.0f+4.f *(m2)/36.0f);
//f1B[y*pitch+x]=f1-(-m1-2.0f*(m2+m4)+m7*omega*9.0f)/36.0f;
//f2B[y*pitch+x]=f2-(-m1-2.f*m2-6.f*m6-m7*omega*9.0f)/36.0f;
//f3B[y*pitch+x]=f3-(-m1-2.f*m2+6.f*m4+m7*omega*9.0f)/36.0f;
//f4B[y*pitch+x]=f4-(-m1-2.f*m2+6.f*m6-m7*omega*9.0f)/36.0f;
//f5B[y*pitch+x]=f5-(2.f*m1+m2+3.f*m4+3.f*m6+m8*omega*9.0f)/36.0f;
//f6B[y*pitch+x]=f6-(2.f*m1+m2-3.f*m4+3.f*m6-m8*omega*9.0f)/36.0f;
//f7B[y*pitch+x]=f7-(2.f*m1+m2-3.f*m4-3.f*m6+m8*omega*9.0f)/36.0f;
//f8B[y*pitch+x]=f8-(2.f*m1+m2+3.f*m4-3.f*m6-m8*omega*9.0f)/36.0f;
////f0A[y*pitch+x]=f0;
////f1B[y*pitch+x]=f1;
////f2B[y*pitch+x]=f2;
////f3B[y*pitch+x]=f3;
////f4B[y*pitch+x]=f4;
////f5B[y*pitch+x]=f5;
////f6B[y*pitch+x]=f6;
////f7B[y*pitch+x]=f7;
////f8B[y*pitch+x]=f8;
//	}
//}
//

__global__ void initialize(void* f0in, void* f1out, void* f2out,
							void* f3out, void* f4out, void* f5out,
							void* f6out, void* f7out, void* f8out, void* f9out,
							void* f10out, void* f11out, void* f12out,
							void* f13out, void* f14out, void* f15out,
							void* f16out, void* f17out, void* f18out,
							int w, int h, int pitch)//pitch in elements
//__global__ void initialize(void** f0in, void** f1in, 
//							int w, int h, int pitch)//pitch in elements
{
	int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
	int y = threadIdx.y+blockIdx.y*blockDim.y;
	int z = threadIdx.z+blockIdx.z*blockDim.z;
//	i = threadIdx.y*blockDim.x+threadIdx.x;
//	i += blockDim.x*blockDim.y*gridDim.x*blockIdx.y;
//	i += blockDim.x*blockDim.y*blockIdx.x;
	float* f0 = (float *)(f0in);
	float* f1 = (float *)(f1out);
	int i = x+y*w+z*w*h;//index on linear mem
	int j = x+y*pitch+z*h*pitch;//index on padded mem (pitch in elements)
	float data = 0;
	surf3Dread(&data,surfRef,x,y,z);
	if(data == 10) data = 1;
	f1[j] = data;
	
	//i = y*blockDim.x+x;
	//f1[y*pitch+x] = tex2D(texRef_f1,x,y);
//	float u,v,rho,feq,usqr;
//	rho = 1.0f;
//	u = 0.0f;
//	v = 0.0f;
//	usqr = u*u+v*v;
//	feq = 4.0f/9.0f*(rho-1.5f*usqr);
//	f0[i] = feq;
//	feq = 1.0f/9.0f*(rho+3.0f*u+4.5f*u*u-1.5f*usqr);
//	f1[y*pitch+x] = feq;
//	feq = 1.0f/9.0f*(rho+3.0f*v+4.5f*v*v-1.5f*usqr);
//	f2[y*pitch+x] = feq;
//	feq = 1.0f/9.0f*(rho-3.0f*u+4.5f*u*u-1.5f*usqr);
//	f3[y*pitch+x] = feq;
//	feq = 1.0f/9.0f*(rho-3.0f*v+4.5f*v*v-1.5f*usqr);
//	f4[y*pitch+x] = feq;
//	feq = 1.0f/36.0f*(rho+3.0f*(u+v)+4.5f*(u+v)*(u+v)-1.5f*usqr);
//	f5[y*pitch+x] = feq;
//	feq = 1.0f/36.0f*(rho+3.0f*(-u+v)+4.5f*(-u+v)*(-u+v)-1.5f*usqr);
//	f6[y*pitch+x] = feq;
//	feq = 1.0f/36.0f*(rho+3.0f*(-u-v)+4.5f*(-u-v)*(-u-v)-1.5f*usqr);
//	f7[y*pitch+x] = feq;
//	feq = 1.0f/36.0f*(rho+3.0f*(u-v)+4.5f*(u-v)*(u-v)-1.5f*usqr);
//	f8[y*pitch+x] = feq;
}
__global__ void copytest(cudaPitchedPtr devPitchedPtr, float * test_d, int w, int h, int d)
//__global__ void copytest(float *test)//, int w, int h, int d)
//__global__ void copytest(int * image)
{
	int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
	int y = threadIdx.y+blockIdx.y*blockDim.y;
	int z = threadIdx.z+blockIdx.z*blockDim.z;
	char* devPtr = (char*)devPitchedPtr.ptr;
	int pitch = devPitchedPtr.pitch;
//	int slicepitch = pitch*height;
////	int pitch = devPitchedPtr.pitch;
//	char *slice = devPtr + blockIdx.x*slicepitch;
	float* test = (float *)(devPtr);
//	//int slicePitch = pitch*extent.height;
	//int i = threadIdx.x+threadIdx.y*blockDim.x+threadIdx.z*blockDim.x*blockDim.y;
	int i = x+y*w+z*w*h;//index on linear mem
	//int j = threadIdx.x+threadIdx.y*pitch+threadIdx.z*blockDim.y;
	int j = x+y*pitch/sizeof(float)+z*h*pitch/sizeof(float);//index on padded mem
	//if(test[i] == 2)
	//test[0] = 2.f;//test[i];
	test_d[i] = test[j];
	test[j] += 100;

}



int main(int argc, char *argv[])
{

	float *f0_h, *f1_h, *f2_h, *f3_h, *f4_h, *f5_h, *f6_h, *f7_h, *f8_h, *f9_h;
	float *f10_h, *f11_h, *f12_h, *f13_h, *f14_h, *f15_h, *f16_h, *f17_h, *f18_h;
	cudaPitchedPtr f0_dA, f1_dA, f2_dA, f3_dA, f4_dA, f5_dA, f6_dA, f7_dA, f8_dA, f9_dA;
	cudaPitchedPtr f10_dA, f11_dA, f12_dA, f13_dA, f14_dA, f15_dA, f16_dA, f17_dA, f18_dA;
	int *image_d, *image_h;

	//cudaPitchedPtr f0_d;

	float *test_h,*test_d;

	ofstream output;
	output.open ("LBM1_out.dat");

	size_t memsize, memsize_int;
	//size_t pitch;
	int i, n, nBlocks, xDim, yDim, zDim;
//	float Re, omega, uMax, CharLength;
	
	int BLOCKSIZEx = 8;
	int BLOCKSIZEy = 1;
	int BLOCKSIZEz = 1;
	xDim = 16;
	yDim = 8;
	zDim = 8;
//	tMax = 1;
//	Re = 10.f;//100.f;
//	uMax = 0.08f;
//	CharLength = xDim-2.f;
//	omega = 1.0f/(3.0f*(uMax*CharLength/Re)+0.5f);
//
//	cout<<"omega: "<<omega<<endl;

	nBlocks = (xDim/BLOCKSIZEx+xDim%BLOCKSIZEx)*(yDim/BLOCKSIZEy+yDim%BLOCKSIZEy)
				*(zDim/BLOCKSIZEz+zDim%BLOCKSIZEz);
	int B = BLOCKSIZEx*BLOCKSIZEy*BLOCKSIZEz;
	n = nBlocks*B;//block*dimx*dimy
	cout<<"nBlocks:"<<nBlocks<<endl;

    dim3 threads(BLOCKSIZEx, BLOCKSIZEy, BLOCKSIZEz);
    dim3 grid(xDim/BLOCKSIZEx,yDim/BLOCKSIZEy,zDim/BLOCKSIZEz);

	memsize = n*sizeof(float);
	memsize_int = n*sizeof(int);

	cudaExtent extent = make_cudaExtent(xDim*sizeof(float),yDim,zDim);

	f0_h   = (float *)malloc(memsize);
	f1_h   = (float *)malloc(memsize);
	f2_h   = (float *)malloc(memsize);
	f3_h   = (float *)malloc(memsize);
	f4_h   = (float *)malloc(memsize);
	f5_h   = (float *)malloc(memsize);
	f6_h   = (float *)malloc(memsize);
	f7_h   = (float *)malloc(memsize);
	f8_h   = (float *)malloc(memsize);
	f9_h   = (float *)malloc(memsize);
	f10_h  = (float *)malloc(memsize);
	f11_h  = (float *)malloc(memsize);
	f12_h  = (float *)malloc(memsize);
	f13_h  = (float *)malloc(memsize);
	f14_h  = (float *)malloc(memsize);
	f15_h  = (float *)malloc(memsize);
	f16_h  = (float *)malloc(memsize);
	f17_h  = (float *)malloc(memsize);
	f18_h  = (float *)malloc(memsize);

	image_h = (int *)malloc(memsize_int);
	test_h = (float *)malloc(memsize);

	cudaMalloc((void **) &test_d, memsize);
	cudaMalloc((void **) &image_d, memsize_int);

	cudaMalloc3D(&f0_dA ,  extent);
	cudaMalloc3D(&f1_dA ,  extent);
	cudaMalloc3D(&f2_dA ,  extent);
	cudaMalloc3D(&f3_dA ,  extent);
	cudaMalloc3D(&f4_dA ,  extent);
	cudaMalloc3D(&f5_dA ,  extent);
	cudaMalloc3D(&f6_dA ,  extent);
	cudaMalloc3D(&f7_dA ,  extent);
	cudaMalloc3D(&f8_dA ,  extent);
	cudaMalloc3D(&f9_dA ,  extent);
	cudaMalloc3D(&f10_dA ,  extent);
	cudaMalloc3D(&f11_dA ,  extent);
	cudaMalloc3D(&f12_dA ,  extent);
	cudaMalloc3D(&f13_dA ,  extent);
	cudaMalloc3D(&f14_dA ,  extent);
	cudaMalloc3D(&f15_dA ,  extent);
	cudaMalloc3D(&f16_dA ,  extent);
	cudaMalloc3D(&f17_dA ,  extent);
	cudaMalloc3D(&f18_dA ,  extent);
	int pitch = f0_dA.pitch/sizeof(float);//pitch in elementsa

	cudaChannelFormatDesc desc = cudaCreateChannelDesc<float>();

	cudaArray * testarray;
	cudaMalloc3DArray(&testarray, &desc, extent, cudaArraySurfaceLoadStore);
	



	for (i = 0; i < n; i++)
	{
//		int x = i%xDim;
//		int y = (i/xDim)%zDim;
//		int z = (i/xDim)/yDim;
		f0_h[i]  = 5;
		f1_h[i]  = 0;
		f2_h[i]  = 2;
		f3_h[i]  = i;
		f4_h[i]  = i;
		f5_h[i]  = i;
		f6_h[i]  = i;
		f7_h[i]  = i;
		f8_h[i]  = i;
		f9_h[i]  = i;
		f10_h[i] = i;
		f11_h[i] = i;
		f12_h[i] = i;
		f13_h[i] = i;
		f14_h[i] = i;
		f15_h[i] = i;
		f16_h[i] = i;
		f17_h[i] = i;
		f18_h[i] = i;
		image_h[i] = 0;
		test_h[i] = 0;
//		if(x < 1) image_h[i] = 1;//DirichletWest
//		if(x > xDim-2) image_h[i] = 1;//BB
//		if(y < 1) image_h[i] = 1;//BB
//		if(y > yDim-2) image_h[i] = 3;//BB
	}

	cudaMemcpy3DParms pfB = {0};
	pfB.srcPtr.ptr = f0_h;
	pfB.srcPtr.pitch = xDim*sizeof(float);
	pfB.srcPtr.xsize = xDim;
	pfB.srcPtr.ysize = yDim;
	pfB.dstArray = testarray;
	pfB.extent = extent;
	pfB.kind = cudaMemcpyHostToDevice;
	cudaMemcpy3D(&pfB);
	surfRef.channelDesc = desc;
	cudaBindSurfaceToArray(surfRef, testarray);



	cudaMemcpy3DParms pfA = {0};
	pfA.srcPtr.pitch = xDim*sizeof(float);
	pfA.srcPtr.xsize = xDim;
	pfA.srcPtr.ysize = yDim;
	pfA.dstPtr.pitch = f0_dA.pitch;
	cout<<"pitch on dev is "<<f0_dA.pitch;
	pfA.dstPtr.xsize = xDim;
	pfA.dstPtr.ysize = yDim;
	pfA.extent.width = xDim*sizeof(float);
	pfA.extent.height = yDim;
	pfA.extent.depth = zDim;
	pfA.kind = cudaMemcpyHostToDevice;
	
	if(true)//host to dev memcpy
	{
	pfA.srcPtr.ptr = f0_h;
	pfA.dstPtr.ptr = f0_dA.ptr;
	cudaMemcpy3D(&pfA);
	pfA.srcPtr.ptr = f1_h;
	pfA.dstPtr.ptr = f1_dA.ptr;
	cudaMemcpy3D(&pfA);
	pfA.srcPtr.ptr = f2_h;
	pfA.dstPtr.ptr = f2_dA.ptr;
	cudaMemcpy3D(&pfA);
	pfA.srcPtr.ptr = f3_h;
	pfA.dstPtr.ptr = f3_dA.ptr;
	cudaMemcpy3D(&pfA);
	pfA.srcPtr.ptr = f4_h;
	pfA.dstPtr.ptr = f4_dA.ptr;
	cudaMemcpy3D(&pfA);
	pfA.srcPtr.ptr = f5_h;
	pfA.dstPtr.ptr = f5_dA.ptr;
	cudaMemcpy3D(&pfA);
	pfA.srcPtr.ptr = f6_h;
	pfA.dstPtr.ptr = f6_dA.ptr;
	cudaMemcpy3D(&pfA);
	pfA.srcPtr.ptr = f7_h;
	pfA.dstPtr.ptr = f7_dA.ptr;
	cudaMemcpy3D(&pfA);
	pfA.srcPtr.ptr = f8_h;
	pfA.dstPtr.ptr = f8_dA.ptr;
	cudaMemcpy3D(&pfA);
	pfA.srcPtr.ptr = f9_h;
	pfA.dstPtr.ptr = f9_dA.ptr;
	cudaMemcpy3D(&pfA);
	pfA.srcPtr.ptr = f10_h;
	pfA.dstPtr.ptr = f10_dA.ptr;
	cudaMemcpy3D(&pfA);
	pfA.srcPtr.ptr = f11_h;
	pfA.dstPtr.ptr = f11_dA.ptr;
	cudaMemcpy3D(&pfA);
	pfA.srcPtr.ptr = f12_h;
	pfA.dstPtr.ptr = f12_dA.ptr;
	cudaMemcpy3D(&pfA);
	pfA.srcPtr.ptr = f13_h;
	pfA.dstPtr.ptr = f13_dA.ptr;
	cudaMemcpy3D(&pfA);
	pfA.srcPtr.ptr = f14_h;
	pfA.dstPtr.ptr = f14_dA.ptr;
	cudaMemcpy3D(&pfA);
	pfA.srcPtr.ptr = f15_h;
	pfA.dstPtr.ptr = f15_dA.ptr;
	cudaMemcpy3D(&pfA);
	pfA.srcPtr.ptr = f16_h;
	pfA.dstPtr.ptr = f16_dA.ptr;
	cudaMemcpy3D(&pfA);
	pfA.srcPtr.ptr = f17_h;
	pfA.dstPtr.ptr = f17_dA.ptr;
	cudaMemcpy3D(&pfA);
	pfA.srcPtr.ptr = f18_h;
	pfA.dstPtr.ptr = f18_dA.ptr;
	cudaMemcpy3D(&pfA);
	}


	if(true)//texture settings
	{
	texRef_f1A.normalized = false;
	texRef_f2A.normalized = false;
	texRef_f3A.normalized = false;
	texRef_f4A.normalized = false;
	texRef_f5A.normalized = false;
	texRef_f6A.normalized = false;
	texRef_f7A.normalized = false;
	texRef_f8A.normalized = false;
	texRef_f9A.normalized = false;
	texRef_f10A.normalized = false;
	texRef_f11A.normalized = false;
	texRef_f12A.normalized = false;
	texRef_f13A.normalized = false;
	texRef_f14A.normalized = false;
	texRef_f15A.normalized = false;
	texRef_f16A.normalized = false;
	texRef_f17A.normalized = false;
	texRef_f18A.normalized = false;
	texRef_f1A.filterMode = cudaFilterModePoint;
	texRef_f2A.filterMode = cudaFilterModePoint;
	texRef_f3A.filterMode = cudaFilterModePoint;
	texRef_f4A.filterMode = cudaFilterModePoint;
	texRef_f5A.filterMode = cudaFilterModePoint;
	texRef_f6A.filterMode = cudaFilterModePoint;
	texRef_f7A.filterMode = cudaFilterModePoint;
	texRef_f8A.filterMode = cudaFilterModePoint;
	texRef_f9A.filterMode = cudaFilterModePoint;
	texRef_f10A.filterMode = cudaFilterModePoint;
	texRef_f11A.filterMode = cudaFilterModePoint;
	texRef_f12A.filterMode = cudaFilterModePoint;
	texRef_f13A.filterMode = cudaFilterModePoint;
	texRef_f14A.filterMode = cudaFilterModePoint;
	texRef_f15A.filterMode = cudaFilterModePoint;
	texRef_f16A.filterMode = cudaFilterModePoint;
	texRef_f17A.filterMode = cudaFilterModePoint;
	texRef_f18A.filterMode = cudaFilterModePoint;
	}

//	cudaBindTexture3D(0,&texRef_f1A, f1_dA,&desc,xDim,yDim,pitch);
//	cudaBindTexture3D(0,&texRef_f2A, f2_dA,&desc,xDim,yDim,pitch);
//	cudaBindTexture3D(0,&texRef_f3A, f3_dA,&desc,xDim,yDim,pitch);
//	cudaBindTexture3D(0,&texRef_f4A, f4_dA,&desc,xDim,yDim,pitch);
//	cudaBindTexture3D(0,&texRef_f5A, f5_dA,&desc,xDim,yDim,pitch);
//	cudaBindTexture3D(0,&texRef_f6A, f6_dA,&desc,xDim,yDim,pitch);
//	cudaBindTexture3D(0,&texRef_f7A, f7_dA,&desc,xDim,yDim,pitch);
//	cudaBindTexture3D(0,&texRef_f8A, f8_dA,&desc,xDim,yDim,pitch);



	initialize<<<grid, threads>>>(f0_dA.ptr, f1_dA.ptr, f2_dA.ptr, f3_dA.ptr, f4_dA.ptr, f5_dA.ptr, f6_dA.ptr, f7_dA.ptr, f8_dA.ptr, f9_dA.ptr,
									f10_dA.ptr, f11_dA.ptr, f12_dA.ptr, f13_dA.ptr, f14_dA.ptr, f15_dA.ptr, f16_dA.ptr, f17_dA.ptr, f18_dA.ptr,
									xDim,yDim,pitch);
//	initialize<<<grid, threads>>>(f0_dA, f1_dA, f2_dA, f3_dA, f4_dA, f5_dA, f6_dA, f7_dA, f8_dA, f9_dA,
//									f10_dA, f11_dA, f12_dA, f13_dA, f14_dA, f15_dA, f16_dA, f17_dA, f18_dA,
//									xDim,yDim,pitch);

//	cudaMemcpy(image_d, image_h, memsize_int, cudaMemcpyHostToDevice);
	cudaMemcpy(test_d, test_h, memsize, cudaMemcpyHostToDevice);
	f1_h[0] = 10;
	image_h[0] = 10;
	test_h[0] = 10;


//	copytest<<<grid, threads>>>(f10_dA,test_d,xDim,yDim,zDim);
	//copytest<<<grid, threads>>>(test_d);
	//copytest<<<grid, threads>>>(image_d);





	//COPY FROM DEV TO HOST
	pfA.srcPtr.pitch = f0_dA.pitch;
	pfA.srcPtr.xsize = f0_dA.xsize;//xDim;
	pfA.srcPtr.ysize = f0_dA.ysize;//yDim;
	pfA.dstPtr.pitch = xDim*sizeof(float);
	pfA.dstPtr.xsize = xDim;
	pfA.dstPtr.ysize = yDim;
	pfA.extent.width = xDim*sizeof(float);
	pfA.extent.height = yDim;
	pfA.extent.depth = zDim;
	pfA.kind = cudaMemcpyDeviceToHost;

	if(true)//dev to host memcpy
	{
	pfA.dstPtr.ptr = f0_h;
	pfA.srcPtr.ptr = f0_dA.ptr;
	cudaMemcpy3D(&pfA);
	pfA.dstPtr.ptr = f1_h;
	pfA.srcPtr.ptr = f1_dA.ptr;
	cudaMemcpy3D(&pfA);
	pfA.dstPtr.ptr = f2_h;
	pfA.srcPtr.ptr = f2_dA.ptr;
	cudaMemcpy3D(&pfA);
	pfA.dstPtr.ptr = f3_h;
	pfA.srcPtr.ptr = f3_dA.ptr;
	cudaMemcpy3D(&pfA);
	pfA.dstPtr.ptr = f4_h;
	pfA.srcPtr.ptr = f4_dA.ptr;
	cudaMemcpy3D(&pfA);
	pfA.dstPtr.ptr = f5_h;
	pfA.srcPtr.ptr = f5_dA.ptr;
	cudaMemcpy3D(&pfA);
	pfA.dstPtr.ptr = f6_h;
	pfA.srcPtr.ptr = f6_dA.ptr;
	cudaMemcpy3D(&pfA);
	pfA.dstPtr.ptr = f7_h;
	pfA.srcPtr.ptr = f7_dA.ptr;
	cudaMemcpy3D(&pfA);
	pfA.dstPtr.ptr = f8_h;
	pfA.srcPtr.ptr = f8_dA.ptr;
	cudaMemcpy3D(&pfA);
	pfA.dstPtr.ptr = f9_h;
	pfA.srcPtr.ptr = f9_dA.ptr;
	cudaMemcpy3D(&pfA);
	pfA.dstPtr.ptr = f10_h;
	pfA.srcPtr.ptr = f10_dA.ptr;
	cudaMemcpy3D(&pfA);
	pfA.dstPtr.ptr = f11_h;
	pfA.srcPtr.ptr = f11_dA.ptr;
	cudaMemcpy3D(&pfA);
	pfA.dstPtr.ptr = f12_h;
	pfA.srcPtr.ptr = f12_dA.ptr;
	cudaMemcpy3D(&pfA);
	pfA.dstPtr.ptr = f13_h;
	pfA.srcPtr.ptr = f13_dA.ptr;
	cudaMemcpy3D(&pfA);
	pfA.dstPtr.ptr = f14_h;
	pfA.srcPtr.ptr = f14_dA.ptr;
	cudaMemcpy3D(&pfA);
	pfA.dstPtr.ptr = f15_h;
	pfA.srcPtr.ptr = f15_dA.ptr;
	cudaMemcpy3D(&pfA);
	pfA.dstPtr.ptr = f16_h;
	pfA.srcPtr.ptr = f16_dA.ptr;
	cudaMemcpy3D(&pfA);
	pfA.dstPtr.ptr = f17_h;
	pfA.srcPtr.ptr = f17_dA.ptr;
	cudaMemcpy3D(&pfA);
	pfA.dstPtr.ptr = f18_h;
	pfA.srcPtr.ptr = f18_dA.ptr;
	cudaMemcpy3D(&pfA);
	}

	cout<<"f1_h is "<<f1_h[0]<<endl;
	//cudaMemcpy(f0_h, f0_d.ptr, memsize, cudaMemcpyDeviceToHost);

	cudaMemcpy(image_h, image_d, memsize_int, cudaMemcpyDeviceToHost);
	cudaMemcpy(test_h, test_d, memsize, cudaMemcpyDeviceToHost);

//	cout<<image_h[0]<<endl;
//	cout<<"test_d: "<<test_h[0]<<endl;
//	for(i = 0; i<n; i++){
//	cout<<f0_h[i]<<",";
//	}


	cudaFree(image_d);
	cudaFree(test_d);
	cudaFree(testarray);
	cudaFree(f0_dA.ptr);
	cudaFree(f1_dA.ptr);
	cudaFree(f2_dA.ptr);
	cudaFree(f3_dA.ptr);
	cudaFree(f4_dA.ptr);
	cudaFree(f5_dA.ptr);
	cudaFree(f6_dA.ptr);
	cudaFree(f7_dA.ptr);
	cudaFree(f8_dA.ptr);
	cudaFree(f9_dA.ptr);
	cudaFree(f10_dA.ptr);
	cudaFree(f11_dA.ptr);
	cudaFree(f12_dA.ptr);
	cudaFree(f13_dA.ptr);
	cudaFree(f14_dA.ptr);
	cudaFree(f15_dA.ptr);
	cudaFree(f16_dA.ptr);
	cudaFree(f17_dA.ptr);
	cudaFree(f18_dA.ptr);
	return(0);

}
