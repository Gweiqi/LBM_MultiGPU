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
texture<float,2,cudaReadModeElementType> texRef_f0A;
texture<float,2,cudaReadModeElementType> texRef_f1A;
texture<float,2,cudaReadModeElementType> texRef_f2A;
texture<float,2,cudaReadModeElementType> texRef_f3A;
texture<float,2,cudaReadModeElementType> texRef_f4A;
texture<float,2,cudaReadModeElementType> texRef_f5A;
texture<float,2,cudaReadModeElementType> texRef_f6A;
texture<float,2,cudaReadModeElementType> texRef_f7A;
texture<float,2,cudaReadModeElementType> texRef_f8A;
texture<float,2,cudaReadModeElementType> texRef_f9A;
texture<float,2,cudaReadModeElementType> texRef_f10A;
texture<float,2,cudaReadModeElementType> texRef_f11A;
texture<float,2,cudaReadModeElementType> texRef_f12A;
texture<float,2,cudaReadModeElementType> texRef_f13A;
texture<float,2,cudaReadModeElementType> texRef_f14A;
texture<float,2,cudaReadModeElementType> texRef_f15A;
texture<float,2,cudaReadModeElementType> texRef_f16A;
texture<float,2,cudaReadModeElementType> texRef_f17A;
texture<float,2,cudaReadModeElementType> texRef_f18A;

texture<float,2,cudaReadModeElementType> texRef_f0B;
texture<float,2,cudaReadModeElementType> texRef_f1B;
texture<float,2,cudaReadModeElementType> texRef_f2B;
texture<float,2,cudaReadModeElementType> texRef_f3B;
texture<float,2,cudaReadModeElementType> texRef_f4B;
texture<float,2,cudaReadModeElementType> texRef_f5B;
texture<float,2,cudaReadModeElementType> texRef_f6B;
texture<float,2,cudaReadModeElementType> texRef_f7B;
texture<float,2,cudaReadModeElementType> texRef_f8B;
texture<float,2,cudaReadModeElementType> texRef_f9B;
texture<float,2,cudaReadModeElementType> texRef_f10B;
texture<float,2,cudaReadModeElementType> texRef_f11B;
texture<float,2,cudaReadModeElementType> texRef_f12B;
texture<float,2,cudaReadModeElementType> texRef_f13B;
texture<float,2,cudaReadModeElementType> texRef_f14B;
texture<float,2,cudaReadModeElementType> texRef_f15B;
texture<float,2,cudaReadModeElementType> texRef_f16B;
texture<float,2,cudaReadModeElementType> texRef_f17B;
texture<float,2,cudaReadModeElementType> texRef_f18B;

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

__device__ void collide(float& f0, float& f1, float& f2,
					float& f3 , float& f4 , float& f5 ,
					float& f6 , float& f7 , float& f8 , float& f9,
					float& f10, float& f11, float& f12,
					float& f13, float& f14, float& f15,
					float& f16, float& f17, float& f18, float omega)
{
	float rho,u,v,w;	
		rho = f0+f1+f2+f3+f4+f5+f6+f7+f8+f9+
		      f10+f11+f12+f13+f14+f15+f16+f17+f18;
		u = f1-f3+f5-f6-f7+f8+f10-f12+f15-f17;
		v = f2-f4+f5+f6-f7-f8+f11-f13+f16-f18;
		w = f9+f10+f11+f12+f13-f14-f15-f16-f17-f18;

		float m1,m2,m4,m6,m8,m9,m10,m11,m12,m13,m14,m15,m16,m17,m18;

		m1  = -30.f*f0+-11.f*f1+-11.f*f2+-11.f*f3+-11.f*f4+  8.f*f5+  8.f*f6+  8.f*f7+  8.f*f8+-11.f*f9+  8.f*f10+  8.f*f11+  8.f*f12+  8.f*f13+-11.f*f14+  8.f*f15+  8.f*f16+  8.f*f17+  8.f*f18;
		m2  =  12.f*f0+ -4.f*f1+ -4.f*f2+ -4.f*f3+ -4.f*f4+    f5+    f6+    f7+  1.f*f8+ -4.f*f9+    f10+  1.f*f11+    f12+    f13+ -4.f*f14+    f15+    f16+    f17+    f18;
		m4  =           -4.f*f1         +  4.f*f3         +    f5+ -  f6+ -  f7+    f8         +    f10          + -  f12                    +    f15          + -  f17          ;
		m6  =                    -4.f*f2         +  4.f*f4+    f5+    f6+ -  f7+ -  f8                   +    f11          + -  f13                    +    f16          + -  f18;
		m8  =                                                                                 + -4.f*f9+    f10+    f11+    f12+    f13+  4.f*f14+ -  f15+ -  f16+ -  f17+ -  f18;
		m9  =            2.f*f1+ -  f2+  2.f*f3+ -  f4+    f5+    f6+    f7+    f8+ -  f9+    f10+ -2.f*f11+    f12+ -2.f*f13+ -  f14+    f15+ -2.f*f16+    f17+ -2.f*f18;
		m10 =           -4.f*f1+  2.f*f2+ -4.f*f3+  2.f*f4+    f5+    f6+    f7+    f8+  2.f*f9+    f10+ -2.f*f11+    f12+ -2.f*f13+  2.f*f14+    f15+ -2.f*f16+    f17+ -2.f*f18;
		m11 =                       f2         +    f4+    f5+    f6+    f7+    f8+ -  f9+ -  f10          + -  f12          + -  f14+ -  f15          + -  f17          ;
		m12 =                    -2.f*f2           -2.f*f4+    f5+    f6+    f7+    f8+  2.f*f9+ -  f10          + -  f12          +  2.f*f14+ -  f15          + -  f17          ;
		m13 =                                                  f5+ -  f6+    f7+ -  f8                                                                                                   ;
		m14 =                                                                                                         f11          + -  f13                    + -  f16          +    f18;
		m15 =                                                                                               f10          + -  f12                    + -  f15          +    f17          ;  
		m16 =                                                  f5+ -  f6+ -  f7+    f8           -  f10          +    f12                    + -  f15          +    f17          ;  
		m17 =                                               -  f5+ -  f6+    f7+    f8                   +    f11          + -  f13                    +    f16          + -  f18;  
		m18 =                                                                                               f10+ -  f11+    f12+ -  f13          + -  f15+    f16+ -  f17+    f18;

		m1 -= -11.f*rho+19.f*(u*u+v*v+w*w);
		m2 -= -475.f/63.f*(u*u+v*v+w*w);
		m4 -= -2.f/3.f*u;//qx_eq
		m6 -= -2.f/3.f*v;//qx_eq
		m8 -= -2.f/3.f*w;//qx_eq
		m9 -= (2.f*u*u-(v*v+w*w));//(2.f*.f*.f-(u1*u1+u2*u2));///3.f;//pxx_eq
		m10-= 0.f;//.f.f;//.f.5*meq[9];/.f.f;//.f.5*meq[9];/.f.f;//pixx
		m11-= (v*v-w*w);//pww_eq
		m12-= 0.f;//.f.f;//.f.5*meq[11];/.f.f;//.f.5*meq[9];/.f.f;//piww
		m13-= u*v;//pxy_eq
		m14-= v*w;//pyz_eq
		m15-= u*w;//pxz_eq
		m16-= 0.0;//mx_eq
		m17-= 0.0;//my_eq
		m18-= 0.0;//mz_eq


f0  -= - 0.012531328f*(m1)+  0.047619048f*(m2);
f1  -= -0.0045948204f*(m1)+ -0.015873016f*(m2)+   -0.1f*(m4)                                                      +  0.055555556f*(m9)*omega + -0.055555556f*(m10);
f2  -= -0.0045948204f*(m1)+ -0.015873016f*(m2)                           +   -0.1f*(m6)                           + -0.027777778f*(m9)*omega +  0.027777778f*(m10);
f3  -= -0.0045948204f*(m1)+ -0.015873016f*(m2)+    0.1f*(m4)                                                      +  0.055555556f*(m9)*omega + -0.055555556f*(m10);
f4  -= -0.0045948204f*(m1)+ -0.015873016f*(m2)                           +    0.1f*(m6)                           + -0.027777778f*(m9)*omega +  0.027777778f*(m10);
f5  -=  0.0033416876f*(m1)+  0.003968254f*(m2)+  0.025f*(m4)+  0.025f*(m6)                           +  0.027777778f*(m9)*omega +  0.013888889f*(m10);
f6  -=  0.0033416876f*(m1)+  0.003968254f*(m2)+ -0.025f*(m4)+  0.025f*(m6)                           +  0.027777778f*(m9)*omega +  0.013888889f*(m10);
f7  -=  0.0033416876f*(m1)+  0.003968254f*(m2)+ -0.025f*(m4)+ -0.025f*(m6)                           +  0.027777778f*(m9)*omega +  0.013888889f*(m10);
f8  -=  0.0033416876f*(m1)+  0.003968254f*(m2)+  0.025f*(m4)+ -0.025f*(m6)                           +  0.027777778f*(m9)*omega +  0.013888889f*(m10);
f9  -= -0.0045948204f*(m1)+ -0.015873016f*(m2)                                                      +   -0.1f*(m8)+ -0.027777778f*(m9)*omega +  0.027777778f*(m10);
f10 -=  0.0033416876f*(m1)+  0.003968254f*(m2)+  0.025f*(m4)                           +  0.025f*(m8)+  0.027777778f*(m9)*omega +  0.013888889f*(m10);
f11 -=  0.0033416876f*(m1)+  0.003968254f*(m2)                           +  0.025f*(m6)+  0.025f*(m8)+ -0.055555556f*(m9)*omega + -0.027777778f*(m10);
f12 -=  0.0033416876f*(m1)+  0.003968254f*(m2)+ -0.025f*(m4)                           +  0.025f*(m8)+  0.027777778f*(m9)*omega +  0.013888889f*(m10);
f13 -=  0.0033416876f*(m1)+  0.003968254f*(m2)                           + -0.025f*(m6)+  0.025f*(m8)+ -0.055555556f*(m9)*omega + -0.027777778f*(m10);
f14 -= -0.0045948204f*(m1)+ -0.015873016f*(m2)                                                      +    0.1f*(m8)+ -0.027777778f*(m9)*omega +  0.027777778f*(m10);
f15 -=  0.0033416876f*(m1)+  0.003968254f*(m2)+  0.025f*(m4)                           + -0.025f*(m8)+  0.027777778f*(m9)*omega +  0.013888889f*(m10);
f16 -=  0.0033416876f*(m1)+  0.003968254f*(m2)                           +  0.025f*(m6)+ -0.025f*(m8)+ -0.055555556f*(m9)*omega + -0.027777778f*(m10);
f17 -=  0.0033416876f*(m1)+  0.003968254f*(m2)+ -0.025f*(m4)                           + -0.025f*(m8)+  0.027777778f*(m9)*omega +  0.013888889f*(m10);
f18 -=  0.0033416876f*(m1)+  0.003968254f*(m2)                           + -0.025f*(m6)+ -0.025f*(m8)+ -0.055555556f*(m9)*omega + -0.027777778f*(m10);

f2  -=  0.083333333f*(m11)*omega + -0.083333333f*(m12);
f4  -=  0.083333333f*(m11)*omega + -0.083333333f*(m12);
f5  -=  0.083333333f*(m11)*omega +  0.041666667f*(m12)+ ( 0.25f*(m13)                                                )*omega; 
f6  -=  0.083333333f*(m11)*omega +  0.041666667f*(m12)+ (-0.25f*(m13)                                                )*omega; 
f7  -=  0.083333333f*(m11)*omega +  0.041666667f*(m12)+ ( 0.25f*(m13)                                                )*omega; 
f8  -=  0.083333333f*(m11)*omega +  0.041666667f*(m12)+ (-0.25f*(m13)                                                )*omega; 
f9  -= -0.083333333f*(m11)*omega +  0.083333333f*(m12);
f10 -= -0.083333333f*(m11)*omega + -0.041666667f*(m12) +(                                              +  0.25f*(m15))*omega ;
f11 -=                                                                         +(                         0.25f*(m14)                        )*omega ;
f12 -= -0.083333333f*(m11)*omega + -0.041666667f*(m12) +(                                              + -0.25f*(m15))*omega ;
f13 -=                                                                         +(                        -0.25f*(m14)                        )*omega ;
f14 -= -0.083333333f*(m11)*omega +  0.083333333f*(m12);
f15 -= -0.083333333f*(m11)*omega + -0.041666667f*(m12) +(                                              + -0.25f*(m15))*omega ;
f16 -=                                                                         +(                        -0.25f*(m14)                        )*omega ;
f17 -= -0.083333333f*(m11)*omega + -0.041666667f*(m12) +(                                              +  0.25f*(m15))*omega ;
f18 -=                                                                         +(                         0.25f*(m14)                        )*omega ;

f5  -=  0.125f*(m16)+ -0.125f*(m17);                        
f6  -= -0.125f*(m16)+ -0.125f*(m17);                        
f7  -= -0.125f*(m16)+  0.125f*(m17);                        
f8  -=  0.125f*(m16)+  0.125f*(m17);                        
f10 -= -0.125f*(m16)                              +  0.125f*(m18);
f11 -=                             +  0.125f*(m17)+ -0.125f*(m18);
f12 -=  0.125f*(m16)                              +  0.125f*(m18);
f13 -=                             + -0.125f*(m17)+ -0.125f*(m18);
f15 -= -0.125f*(m16)                              + -0.125f*(m18);
f16 -=                             +  0.125f*(m17)+  0.125f*(m18);
f17 -=  0.125f*(m16)                              + -0.125f*(m18);
f18 -=                             + -0.125f*(m17)+  0.125f*(m18);






}



__global__ void mrt_d_textAB(float* f0out, float* f1out, float* f2out,
							float* f3out, float* f4out, float* f5out,
							float* f6out, float* f7out, float* f8out, float* f9out,
							float* f10out, float* f11out, float* f12out,
							float* f13out, float* f14out, float* f15out,
							float* f16out, float* f17out, float* f18out,
							int *image, float omega, float uMax,
							int width, int height, size_t pitch)//pitch in elements
{
	int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
	int y = threadIdx.y+blockIdx.y*blockDim.y;
	int z = threadIdx.z+blockIdx.z*blockDim.z;
	int i = x+y*width+z*width*height;//index on linear mem
	int j = x+y*pitch+z*height*pitch;//index on padded mem (pitch in elements)
//	f1out[j] = tex2D(texRef_f2A,x,y+h*z);
	
//	int i = x+y*blockDim.x*gridDim.x;
	//float u,v,w,rho;//,usqr;
	int im = image[i];
	if(im == 1){//BB
		//f0A[i] = f0A[i];
		f0out[j] = tex2D(texRef_f0A,x  ,(y  )+height*(z));
		f1out[j] = tex2D(texRef_f3A,x+1,(y  )+height*(z));
		f3out[j] = tex2D(texRef_f1A,x-1,(y  )+height*(z));
		f2out[j] = tex2D(texRef_f4A,x  ,(y+1)+height*(z));
		f4out[j] = tex2D(texRef_f2A,x  ,(y-1)+height*(z));
		f5out[j] = tex2D(texRef_f7A,x+1,(y+1)+height*(z));
		f7out[j] = tex2D(texRef_f5A,x-1,(y-1)+height*(z));
		f6out[j] = tex2D(texRef_f8A,x-1,(y+1)+height*(z));
		f8out[j] = tex2D(texRef_f6A,x+1,(y-1)+height*(z));
		f9out[j] = tex2D(texRef_f14A,x  ,(y  )+height*(z+1));
		f14out[j]= tex2D(texRef_f9A ,x  ,(y  )+height*(z-1));
		f10out[j]= tex2D(texRef_f17A,x+1,(y  )+height*(z+1));
		f17out[j]= tex2D(texRef_f10A,x-1,(y  )+height*(z-1));
		f11out[j]= tex2D(texRef_f18A,x  ,(y+1)+height*(z+1));
		f18out[j]= tex2D(texRef_f11A,x  ,(y-1)+height*(z-1));
		f12out[j]= tex2D(texRef_f15A,x-1,(y  )+height*(z+1));
		f15out[j]= tex2D(texRef_f12A,x+1,(y  )+height*(z-1));
		f13out[j]= tex2D(texRef_f16A,x  ,(y-1)+height*(z+1));
		f16out[j]= tex2D(texRef_f13A,x  ,(y+1)+height*(z-1));

	}
	else{
		float f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18;
		//float u,v,w,rho;
//		float meq1,meq2,meq4,meq6,meq7,meq8;
//		f0 = f0A[i];

		f0 = tex2D(texRef_f0A ,x  ,y  +height*(z));
		f1 = tex2D(texRef_f1A ,x-1,y  +height*(z));
		f2 = tex2D(texRef_f2A ,x  ,y-1+height*(z));
		f3 = tex2D(texRef_f3A ,x+1,y  +height*(z));
		f4 = tex2D(texRef_f4A ,x  ,y+1+height*(z));
		f5 = tex2D(texRef_f5A ,x-1,y-1+height*(z));
		f6 = tex2D(texRef_f6A ,x+1,y-1+height*(z));
		f7 = tex2D(texRef_f7A ,x+1,y+1+height*(z));
		f8 = tex2D(texRef_f8A ,x-1,y+1+height*(z));
		f9 = tex2D(texRef_f9A ,x  ,y  +height*(z-1));
		f10= tex2D(texRef_f10A,x-1,y  +height*(z-1));
		f11= tex2D(texRef_f11A,x  ,y-1+height*(z-1));
		f12= tex2D(texRef_f12A,x+1,y  +height*(z-1));
		f13= tex2D(texRef_f13A,x  ,y+1+height*(z-1));
		f14= tex2D(texRef_f14A,x  ,y  +height*(z+1));
		f15= tex2D(texRef_f15A,x-1,y  +height*(z+1));
		f16= tex2D(texRef_f16A,x  ,y-1+height*(z+1));
		f17= tex2D(texRef_f17A,x+1,y  +height*(z+1));
		f18= tex2D(texRef_f18A,x  ,y+1+height*(z+1));

		collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,omega);

		f0out[j] =  f0 ;
		f1out[j] = f1 ;
		f2out[j] = f2 ;
		f3out[j] = f3 ;
		f4out[j] = f4 ;
		f5out[j] = f5 ;
		f6out[j] = f6 ;
		f7out[j] = f7 ;
		f8out[j] = f8 ;
		f9out[j] = f9 ;
		f10out[j]= f10;
		f11out[j]= f11;
		f12out[j]= f12;
		f13out[j]= f13;
		f14out[j]= f14;
		f15out[j]= f15;
		f16out[j]= f16;
		f17out[j]= f17;
		f18out[j]= f18;


	}
}

__global__ void mrt_d_textBA(float* f0out, float* f1out, float* f2out,
							float* f3out, float* f4out, float* f5out,
							float* f6out, float* f7out, float* f8out, float* f9out,
							float* f10out, float* f11out, float* f12out,
							float* f13out, float* f14out, float* f15out,
							float* f16out, float* f17out, float* f18out,
							int *image, float omega, float uMax,
							int width, int height, size_t pitch)//pitch in elements
{
	int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
	int y = threadIdx.y+blockIdx.y*blockDim.y;
	int z = threadIdx.z+blockIdx.z*blockDim.z;
	int i = x+y*width+z*width*height;//index on linear mem
	int j = x+y*pitch+z*height*pitch;//index on padded mem (pitch in elements)
//	f1out[j] = tex2D(texRef_f2A,x,y+h*z);
	
//	int i = x+y*blockDim.x*gridDim.x;
	//float u,v,w,rho;//,usqr;
	int im = image[i];
	if(im == 1){//BB
		//f0A[i] = f0A[i];
		f0out[j] = tex2D(texRef_f0B,x  ,(y  )+height*(z));
		f1out[j] = tex2D(texRef_f3B,x+1,(y  )+height*(z));
		f3out[j] = tex2D(texRef_f1B,x-1,(y  )+height*(z));
		f2out[j] = tex2D(texRef_f4B,x  ,(y+1)+height*(z));
		f4out[j] = tex2D(texRef_f2B,x  ,(y-1)+height*(z));
		f5out[j] = tex2D(texRef_f7B,x+1,(y+1)+height*(z));
		f7out[j] = tex2D(texRef_f5B,x-1,(y-1)+height*(z));
		f6out[j] = tex2D(texRef_f8B,x-1,(y+1)+height*(z));
		f8out[j] = tex2D(texRef_f6B,x+1,(y-1)+height*(z));
		f9out[j] = tex2D(texRef_f14B,x  ,(y  )+height*(z+1));
		f14out[j]= tex2D(texRef_f9B ,x  ,(y  )+height*(z-1));
		f10out[j]= tex2D(texRef_f17B,x+1,(y  )+height*(z+1));
		f17out[j]= tex2D(texRef_f10B,x-1,(y  )+height*(z-1));
		f11out[j]= tex2D(texRef_f18B,x  ,(y+1)+height*(z+1));
		f18out[j]= tex2D(texRef_f11B,x  ,(y-1)+height*(z-1));
		f12out[j]= tex2D(texRef_f15B,x-1,(y  )+height*(z+1));
		f15out[j]= tex2D(texRef_f12B,x+1,(y  )+height*(z-1));
		f13out[j]= tex2D(texRef_f16B,x  ,(y-1)+height*(z+1));
		f16out[j]= tex2D(texRef_f13B,x  ,(y+1)+height*(z-1));


	}
	else{
		float f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18;
		//float u,v,w,rho;
//		float meq1,meq2,meq4,meq6,meq7,meq8;
//		f0 = f0A[i];

		f0 = tex2D(texRef_f0B ,x  ,y  +height*(z));
		f1 = tex2D(texRef_f1B ,x-1,y  +height*(z));
		f2 = tex2D(texRef_f2B ,x  ,y-1+height*(z));
		f3 = tex2D(texRef_f3B ,x+1,y  +height*(z));
		f4 = tex2D(texRef_f4B ,x  ,y+1+height*(z));
		f5 = tex2D(texRef_f5B ,x-1,y-1+height*(z));
		f6 = tex2D(texRef_f6B ,x+1,y-1+height*(z));
		f7 = tex2D(texRef_f7B ,x+1,y+1+height*(z));
		f8 = tex2D(texRef_f8B ,x-1,y+1+height*(z));
		f9 = tex2D(texRef_f9B ,x  ,y  +height*(z-1));
		f10= tex2D(texRef_f10B,x-1,y  +height*(z-1));
		f11= tex2D(texRef_f11B,x  ,y-1+height*(z-1));
		f12= tex2D(texRef_f12B,x+1,y  +height*(z-1));
		f13= tex2D(texRef_f13B,x  ,y+1+height*(z-1));
		f14= tex2D(texRef_f14B,x  ,y  +height*(z+1));
		f15= tex2D(texRef_f15B,x-1,y  +height*(z+1));
		f16= tex2D(texRef_f16B,x  ,y-1+height*(z+1));
		f17= tex2D(texRef_f17B,x+1,y  +height*(z+1));
		f18= tex2D(texRef_f18B,x  ,y+1+height*(z+1));

		collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,omega);
	
		f0out[j] = f0 ;
		f1out[j] = f1 ;
		f2out[j] = f2 ;
		f3out[j] = f3 ;
		f4out[j] = f4 ;
		f5out[j] = f5 ;
		f6out[j] = f6 ;
		f7out[j] = f7 ;
		f8out[j] = f8 ;
		f9out[j] = f9 ;
		f10out[j]= f10;
		f11out[j]= f11;
		f12out[j]= f12;
		f13out[j]= f13;
		f14out[j]= f14;
		f15out[j]= f15;
		f16out[j]= f16;
		f17out[j]= f17;
		f18out[j]= f18;


	}
}
//

__global__ void initialize(float* f0, float* f1, float* f2,
							float* f3, float* f4, float* f5,
							float* f6, float* f7, float* f8, float* f9,
							float* f10, float* f11, float* f12,
							float* f13, float* f14, float* f15,
							float* f16, float* f17, float* f18,
							int width, int height, size_t pitch)//pitch in elements
//__global__ void initialize(void** f0in, void** f1in, 
//							int w, int h, int pitch)//pitch in elements
{
	int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
	int y = threadIdx.y+blockIdx.y*blockDim.y;
	int z = threadIdx.z+blockIdx.z*blockDim.z;
//	int i = x+y*width+z*width*height;//index on linear mem
	int j = x+y*pitch+z*height*pitch;//index on padded mem (pitch in elements)
//	f1out[j] = tex2D(texRef_f2A,x,y+h*z);
	
	float u,v,w,rho,feq,usqr;
	rho = 1.0f;
	u = 0.0f;
	v = 0.0f;
	w = 0.0f;
	//if(x == 3 ) u = 0.1f;
	usqr = u*u+v*v+w*w;

	feq = 1.0f/3.0f*(rho-1.5f*usqr);
	f0[j] = feq;
	feq = 1.0f/18.0f*(rho+3.0f*u+4.5f*u*u-1.5f*usqr);
	f1[j] = feq;
	feq = 1.0f/18.0f*(rho+3.0f*v+4.5f*v*v-1.5f*usqr);
	f2[j] = feq;
	feq = 1.0f/18.0f*(rho-3.0f*u+4.5f*u*u-1.5f*usqr);
	f3[j] = feq;
	feq = 1.0f/18.0f*(rho-3.0f*v+4.5f*v*v-1.5f*usqr);
	f4[j] = feq;
	feq = 1.0f/36.0f*(rho+3.0f*(u+v)+4.5f*(u+v)*(u+v)-1.5f*usqr);
	f5[j] = feq;
	feq = 1.0f/36.0f*(rho+3.0f*(-u+v)+4.5f*(-u+v)*(-u+v)-1.5f*usqr);
	f6[j] = feq;
	feq = 1.0f/36.0f*(rho+3.0f*(-u-v)+4.5f*(-u-v)*(-u-v)-1.5f*usqr);
	f7[j] = feq;
	feq = 1.0f/36.0f*(rho+3.0f*(u-v)+4.5f*(u-v)*(u-v)-1.5f*usqr);
	f8[j] = feq;

	feq = 1.0f/18.0f*(rho+3.0f*w+4.5f*w*w-1.5f*usqr);
	f9[j] = feq;
	feq = 1.0f/36.0f*(rho+3.0f*(u+w)+4.5f*(u+w)*(u+w)-1.5f*usqr);
	f10[j] = feq;
	feq = 1.0f/36.0f*(rho+3.0f*(v+w)+4.5f*(v+w)*(u+w)-1.5f*usqr);
	f11[j] = feq;
	feq = 1.0f/36.0f*(rho+3.0f*(-u+w)+4.5f*(-u+w)*(-u+w)-1.5f*usqr);
	f12[j] = feq;
	feq = 1.0f/36.0f*(rho+3.0f*(-v+w)+4.5f*(-v+w)*(u+w)-1.5f*usqr);
	f13[j] = feq;
	feq = 1.0f/18.0f*(rho-3.0f*w+4.5f*w*w-1.5f*usqr);
	f14[j] = feq;
	feq = 1.0f/36.0f*(rho+3.0f*(u-w)+4.5f*(u-w)*(u-w)-1.5f*usqr);
	f15[j] = feq;
	feq = 1.0f/36.0f*(rho+3.0f*(v-w)+4.5f*(v-w)*(v-w)-1.5f*usqr);
	f16[j] = feq;
	feq = 1.0f/36.0f*(rho+3.0f*(-u-w)+4.5f*(-u-w)*(-u-w)-1.5f*usqr);
	f17[j] = feq;
	feq = 1.0f/36.0f*(rho+3.0f*(-v-w)+4.5f*(-v-w)*(-v-w)-1.5f*usqr);
	f18[j] = feq;
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
	float *f0_dA, *f1_dA, *f2_dA, *f3_dA, *f4_dA, *f5_dA, *f6_dA, *f7_dA, *f8_dA, *f9_dA;
	float *f10_dA, *f11_dA, *f12_dA, *f13_dA, *f14_dA, *f15_dA, *f16_dA, *f17_dA, *f18_dA;
	float *f0_dB, *f1_dB, *f2_dB, *f3_dB, *f4_dB, *f5_dB, *f6_dB, *f7_dB, *f8_dB, *f9_dB;
	float *f10_dB, *f11_dB, *f12_dB, *f13_dB, *f14_dB, *f15_dB, *f16_dB, *f17_dB, *f18_dB;
	int *image_d, *image_h;

	//cudaPitchedPtr f0_d;

	float *test_h,*test_d;

	ofstream output;
	output.open ("LBM1_out.dat");

	size_t memsize, memsize_int;
	size_t pitch;
	int i, n, nBlocks, xDim, yDim, zDim,tMax;
	float Re, omega, uMax, CharLength;
	
	int BLOCKSIZEx = 256;
	int BLOCKSIZEy = 1;
	int BLOCKSIZEz = 1;
	xDim = 256;
	yDim = 256;
	zDim = 4;
	tMax = 100;
	Re = 500.f;//100.f;
	uMax = 0.08f;
	CharLength = xDim-2.f;
	omega = 1.0f/(3.0f*(uMax*CharLength/Re)+0.5f);

	cout<<"omega: "<<omega<<endl;

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
	cudaMallocPitch((void **) &f0_dA , &pitch, xDim*sizeof(float), yDim*zDim);
	cudaMallocPitch((void **) &f1_dA , &pitch, xDim*sizeof(float), yDim*zDim);
	cudaMallocPitch((void **) &f2_dA , &pitch, xDim*sizeof(float), yDim*zDim);
	cudaMallocPitch((void **) &f3_dA , &pitch, xDim*sizeof(float), yDim*zDim);
	cudaMallocPitch((void **) &f4_dA , &pitch, xDim*sizeof(float), yDim*zDim);
	cudaMallocPitch((void **) &f5_dA , &pitch, xDim*sizeof(float), yDim*zDim);
	cudaMallocPitch((void **) &f6_dA , &pitch, xDim*sizeof(float), yDim*zDim);
	cudaMallocPitch((void **) &f7_dA , &pitch, xDim*sizeof(float), yDim*zDim);
	cudaMallocPitch((void **) &f8_dA , &pitch, xDim*sizeof(float), yDim*zDim);
	cudaMallocPitch((void **) &f9_dA , &pitch, xDim*sizeof(float), yDim*zDim);
	cudaMallocPitch((void **) &f10_dA, &pitch, xDim*sizeof(float), yDim*zDim);
	cudaMallocPitch((void **) &f11_dA, &pitch, xDim*sizeof(float), yDim*zDim);
	cudaMallocPitch((void **) &f12_dA, &pitch, xDim*sizeof(float), yDim*zDim);
	cudaMallocPitch((void **) &f13_dA, &pitch, xDim*sizeof(float), yDim*zDim);
	cudaMallocPitch((void **) &f14_dA, &pitch, xDim*sizeof(float), yDim*zDim);
	cudaMallocPitch((void **) &f15_dA, &pitch, xDim*sizeof(float), yDim*zDim);
	cudaMallocPitch((void **) &f16_dA, &pitch, xDim*sizeof(float), yDim*zDim);
	cudaMallocPitch((void **) &f17_dA, &pitch, xDim*sizeof(float), yDim*zDim);
	cudaMallocPitch((void **) &f18_dA, &pitch, xDim*sizeof(float), yDim*zDim);
	cout<<pitch<<endl;
	cudaMallocPitch((void **) &f0_dB , &pitch, xDim*sizeof(float), yDim*zDim);
	cudaMallocPitch((void **) &f1_dB , &pitch, xDim*sizeof(float), yDim*zDim);
	cudaMallocPitch((void **) &f2_dB , &pitch, xDim*sizeof(float), yDim*zDim);
	cudaMallocPitch((void **) &f3_dB , &pitch, xDim*sizeof(float), yDim*zDim);
	cudaMallocPitch((void **) &f4_dB , &pitch, xDim*sizeof(float), yDim*zDim);
	cudaMallocPitch((void **) &f5_dB , &pitch, xDim*sizeof(float), yDim*zDim);
	cudaMallocPitch((void **) &f6_dB , &pitch, xDim*sizeof(float), yDim*zDim);
	cudaMallocPitch((void **) &f7_dB , &pitch, xDim*sizeof(float), yDim*zDim);
	cudaMallocPitch((void **) &f8_dB , &pitch, xDim*sizeof(float), yDim*zDim);
	cudaMallocPitch((void **) &f9_dB , &pitch, xDim*sizeof(float), yDim*zDim);
	cudaMallocPitch((void **) &f10_dB, &pitch, xDim*sizeof(float), yDim*zDim);
	cudaMallocPitch((void **) &f11_dB, &pitch, xDim*sizeof(float), yDim*zDim);
	cudaMallocPitch((void **) &f12_dB, &pitch, xDim*sizeof(float), yDim*zDim);
	cudaMallocPitch((void **) &f13_dB, &pitch, xDim*sizeof(float), yDim*zDim);
	cudaMallocPitch((void **) &f14_dB, &pitch, xDim*sizeof(float), yDim*zDim);
	cudaMallocPitch((void **) &f15_dB, &pitch, xDim*sizeof(float), yDim*zDim);
	cudaMallocPitch((void **) &f16_dB, &pitch, xDim*sizeof(float), yDim*zDim);
	cudaMallocPitch((void **) &f17_dB, &pitch, xDim*sizeof(float), yDim*zDim);
	cudaMallocPitch((void **) &f18_dB, &pitch, xDim*sizeof(float), yDim*zDim);
	cout<<pitch<<endl;
	
	size_t pitch_elements = pitch/sizeof(float);

	cudaChannelFormatDesc desc = cudaCreateChannelDesc<float>();

	for (i = 0; i < n; i++)
	{
		int x = i%xDim;
		int y = (i/xDim)%yDim;
		int z = (i/xDim)/yDim;
		f0_h[i]  = i;
		f1_h[i]  = i;
		f2_h[i]  = i;
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
		if(x < 1) image_h[i] = 1;//DirichletWest
		if(x > xDim-2) image_h[i] = 1;//BB
		if(y < 1) image_h[i] = 1;//BB
		if(y > yDim-2) image_h[i] = 1;//BB
//		if(z < 1) image_h[i] = 1;//DirichletWest
//		if(z > zDim-2) image_h[i] = 1;//BB
	}
	cudaMemcpy(image_d, image_h, memsize_int, cudaMemcpyHostToDevice);

	if(true)//texture settings
	{
	texRef_f0B.normalized = false;
	texRef_f1B.normalized = false;
	texRef_f2B.normalized = false;
	texRef_f3B.normalized = false;
	texRef_f4B.normalized = false;
	texRef_f5B.normalized = false;
	texRef_f6B.normalized = false;
	texRef_f7B.normalized = false;
	texRef_f8B.normalized = false;
	texRef_f9B.normalized = false;
	texRef_f10B.normalized = false;
	texRef_f11B.normalized = false;
	texRef_f12B.normalized = false;
	texRef_f13B.normalized = false;
	texRef_f14B.normalized = false;
	texRef_f15B.normalized = false;
	texRef_f16B.normalized = false;
	texRef_f17B.normalized = false;
	texRef_f18B.normalized = false;
	texRef_f0B.filterMode = cudaFilterModePoint;
	texRef_f1B.filterMode = cudaFilterModePoint;
	texRef_f2B.filterMode = cudaFilterModePoint;
	texRef_f3B.filterMode = cudaFilterModePoint;
	texRef_f4B.filterMode = cudaFilterModePoint;
	texRef_f5B.filterMode = cudaFilterModePoint;
	texRef_f6B.filterMode = cudaFilterModePoint;
	texRef_f7B.filterMode = cudaFilterModePoint;
	texRef_f8B.filterMode = cudaFilterModePoint;
	texRef_f9B.filterMode = cudaFilterModePoint;
	texRef_f10B.filterMode = cudaFilterModePoint;
	texRef_f11B.filterMode = cudaFilterModePoint;
	texRef_f12B.filterMode = cudaFilterModePoint;
	texRef_f13B.filterMode = cudaFilterModePoint;
	texRef_f14B.filterMode = cudaFilterModePoint;
	texRef_f15B.filterMode = cudaFilterModePoint;
	texRef_f16B.filterMode = cudaFilterModePoint;
	texRef_f17B.filterMode = cudaFilterModePoint;
	texRef_f18B.filterMode = cudaFilterModePoint;
	texRef_f0A.normalized = false;
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
	texRef_f0A.filterMode = cudaFilterModePoint;
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
	
	if(true)//mem copy host to dev
	{
	cudaMemcpy2D(f0_dA ,pitch,f0_h ,xDim*sizeof(float),xDim*sizeof(float),yDim*zDim,cudaMemcpyHostToDevice);
	cudaMemcpy2D(f1_dA ,pitch,f1_h ,xDim*sizeof(float),xDim*sizeof(float),yDim*zDim,cudaMemcpyHostToDevice);
	cudaMemcpy2D(f2_dA ,pitch,f2_h ,xDim*sizeof(float),xDim*sizeof(float),yDim*zDim,cudaMemcpyHostToDevice);
	cudaMemcpy2D(f3_dA ,pitch,f3_h ,xDim*sizeof(float),xDim*sizeof(float),yDim*zDim,cudaMemcpyHostToDevice);
	cudaMemcpy2D(f4_dA ,pitch,f4_h ,xDim*sizeof(float),xDim*sizeof(float),yDim*zDim,cudaMemcpyHostToDevice);
	cudaMemcpy2D(f5_dA ,pitch,f5_h ,xDim*sizeof(float),xDim*sizeof(float),yDim*zDim,cudaMemcpyHostToDevice);
	cudaMemcpy2D(f6_dA ,pitch,f6_h ,xDim*sizeof(float),xDim*sizeof(float),yDim*zDim,cudaMemcpyHostToDevice);
	cudaMemcpy2D(f7_dA ,pitch,f7_h ,xDim*sizeof(float),xDim*sizeof(float),yDim*zDim,cudaMemcpyHostToDevice);
	cudaMemcpy2D(f8_dA ,pitch,f8_h ,xDim*sizeof(float),xDim*sizeof(float),yDim*zDim,cudaMemcpyHostToDevice);
	cudaMemcpy2D(f9_dA ,pitch,f9_h ,xDim*sizeof(float),xDim*sizeof(float),yDim*zDim,cudaMemcpyHostToDevice);
	cudaMemcpy2D(f10_dA,pitch,f11_h,xDim*sizeof(float),xDim*sizeof(float),yDim*zDim,cudaMemcpyHostToDevice);
	cudaMemcpy2D(f11_dA,pitch,f11_h,xDim*sizeof(float),xDim*sizeof(float),yDim*zDim,cudaMemcpyHostToDevice);
	cudaMemcpy2D(f12_dA,pitch,f12_h,xDim*sizeof(float),xDim*sizeof(float),yDim*zDim,cudaMemcpyHostToDevice);
	cudaMemcpy2D(f13_dA,pitch,f13_h,xDim*sizeof(float),xDim*sizeof(float),yDim*zDim,cudaMemcpyHostToDevice);
	cudaMemcpy2D(f14_dA,pitch,f14_h,xDim*sizeof(float),xDim*sizeof(float),yDim*zDim,cudaMemcpyHostToDevice);
	cudaMemcpy2D(f15_dA,pitch,f15_h,xDim*sizeof(float),xDim*sizeof(float),yDim*zDim,cudaMemcpyHostToDevice);
	cudaMemcpy2D(f16_dA,pitch,f16_h,xDim*sizeof(float),xDim*sizeof(float),yDim*zDim,cudaMemcpyHostToDevice);
	cudaMemcpy2D(f17_dA,pitch,f17_h,xDim*sizeof(float),xDim*sizeof(float),yDim*zDim,cudaMemcpyHostToDevice);
	cudaMemcpy2D(f18_dA,pitch,f18_h,xDim*sizeof(float),xDim*sizeof(float),yDim*zDim,cudaMemcpyHostToDevice);
	cudaMemcpy2D(f0_dB ,pitch,f0_h ,xDim*sizeof(float),xDim*sizeof(float),yDim*zDim,cudaMemcpyHostToDevice);
	cudaMemcpy2D(f1_dB ,pitch,f1_h ,xDim*sizeof(float),xDim*sizeof(float),yDim*zDim,cudaMemcpyHostToDevice);
	cudaMemcpy2D(f2_dB ,pitch,f2_h ,xDim*sizeof(float),xDim*sizeof(float),yDim*zDim,cudaMemcpyHostToDevice);
	cudaMemcpy2D(f3_dB ,pitch,f3_h ,xDim*sizeof(float),xDim*sizeof(float),yDim*zDim,cudaMemcpyHostToDevice);
	cudaMemcpy2D(f4_dB ,pitch,f4_h ,xDim*sizeof(float),xDim*sizeof(float),yDim*zDim,cudaMemcpyHostToDevice);
	cudaMemcpy2D(f5_dB ,pitch,f5_h ,xDim*sizeof(float),xDim*sizeof(float),yDim*zDim,cudaMemcpyHostToDevice);
	cudaMemcpy2D(f6_dB ,pitch,f6_h ,xDim*sizeof(float),xDim*sizeof(float),yDim*zDim,cudaMemcpyHostToDevice);
	cudaMemcpy2D(f7_dB ,pitch,f7_h ,xDim*sizeof(float),xDim*sizeof(float),yDim*zDim,cudaMemcpyHostToDevice);
	cudaMemcpy2D(f8_dB ,pitch,f8_h ,xDim*sizeof(float),xDim*sizeof(float),yDim*zDim,cudaMemcpyHostToDevice);
	cudaMemcpy2D(f9_dB ,pitch,f9_h ,xDim*sizeof(float),xDim*sizeof(float),yDim*zDim,cudaMemcpyHostToDevice);
	cudaMemcpy2D(f10_dB,pitch,f11_h,xDim*sizeof(float),xDim*sizeof(float),yDim*zDim,cudaMemcpyHostToDevice);
	cudaMemcpy2D(f11_dB,pitch,f11_h,xDim*sizeof(float),xDim*sizeof(float),yDim*zDim,cudaMemcpyHostToDevice);
	cudaMemcpy2D(f12_dB,pitch,f12_h,xDim*sizeof(float),xDim*sizeof(float),yDim*zDim,cudaMemcpyHostToDevice);
	cudaMemcpy2D(f13_dB,pitch,f13_h,xDim*sizeof(float),xDim*sizeof(float),yDim*zDim,cudaMemcpyHostToDevice);
	cudaMemcpy2D(f14_dB,pitch,f14_h,xDim*sizeof(float),xDim*sizeof(float),yDim*zDim,cudaMemcpyHostToDevice);
	cudaMemcpy2D(f15_dB,pitch,f15_h,xDim*sizeof(float),xDim*sizeof(float),yDim*zDim,cudaMemcpyHostToDevice);
	cudaMemcpy2D(f16_dB,pitch,f16_h,xDim*sizeof(float),xDim*sizeof(float),yDim*zDim,cudaMemcpyHostToDevice);
	cudaMemcpy2D(f17_dB,pitch,f17_h,xDim*sizeof(float),xDim*sizeof(float),yDim*zDim,cudaMemcpyHostToDevice);
	cudaMemcpy2D(f18_dB,pitch,f18_h,xDim*sizeof(float),xDim*sizeof(float),yDim*zDim,cudaMemcpyHostToDevice);
	}
//	if(true)//bind texture
//	{
//	cudaBindTexture2D(0,&texRef_f0A, f0_dA ,&desc,xDim,yDim*zDim,pitch);
//	cudaBindTexture2D(0,&texRef_f1A, f1_dA ,&desc,xDim,yDim*zDim,pitch);
//	cudaBindTexture2D(0,&texRef_f2A, f2_dA ,&desc,xDim,yDim*zDim,pitch);
//	cudaBindTexture2D(0,&texRef_f3A, f3_dA ,&desc,xDim,yDim*zDim,pitch);
//	cudaBindTexture2D(0,&texRef_f4A, f4_dA ,&desc,xDim,yDim*zDim,pitch);
//	cudaBindTexture2D(0,&texRef_f5A, f5_dA ,&desc,xDim,yDim*zDim,pitch);
//	cudaBindTexture2D(0,&texRef_f6A, f6_dA ,&desc,xDim,yDim*zDim,pitch);
//	cudaBindTexture2D(0,&texRef_f7A, f7_dA ,&desc,xDim,yDim*zDim,pitch);
//	cudaBindTexture2D(0,&texRef_f8A, f8_dA ,&desc,xDim,yDim*zDim,pitch);
//	cudaBindTexture2D(0,&texRef_f9A, f9_dA ,&desc,xDim,yDim*zDim,pitch);
//	cudaBindTexture2D(0,&texRef_f10A,f10_dA,&desc,xDim,yDim*zDim,pitch);
//	cudaBindTexture2D(0,&texRef_f11A,f11_dA,&desc,xDim,yDim*zDim,pitch);
//	cudaBindTexture2D(0,&texRef_f12A,f12_dA,&desc,xDim,yDim*zDim,pitch);
//	cudaBindTexture2D(0,&texRef_f13A,f13_dA,&desc,xDim,yDim*zDim,pitch);
//	cudaBindTexture2D(0,&texRef_f14A,f14_dA,&desc,xDim,yDim*zDim,pitch);
//	cudaBindTexture2D(0,&texRef_f15A,f15_dA,&desc,xDim,yDim*zDim,pitch);
//	cudaBindTexture2D(0,&texRef_f16A,f16_dA,&desc,xDim,yDim*zDim,pitch);
//	cudaBindTexture2D(0,&texRef_f17A,f17_dA,&desc,xDim,yDim*zDim,pitch);
//	cudaBindTexture2D(0,&texRef_f18A,f18_dA,&desc,xDim,yDim*zDim,pitch);
//	cudaBindTexture2D(0,&texRef_f0B, f0_dB ,&desc,xDim,yDim*zDim,pitch);
//	cudaBindTexture2D(0,&texRef_f1B, f1_dB ,&desc,xDim,yDim*zDim,pitch);
//	cudaBindTexture2D(0,&texRef_f2B, f2_dB ,&desc,xDim,yDim*zDim,pitch);
//	cudaBindTexture2D(0,&texRef_f3B, f3_dB ,&desc,xDim,yDim*zDim,pitch);
//	cudaBindTexture2D(0,&texRef_f4B, f4_dB ,&desc,xDim,yDim*zDim,pitch);
//	cudaBindTexture2D(0,&texRef_f5B, f5_dB ,&desc,xDim,yDim*zDim,pitch);
//	cudaBindTexture2D(0,&texRef_f6B, f6_dB ,&desc,xDim,yDim*zDim,pitch);
//	cudaBindTexture2D(0,&texRef_f7B, f7_dB ,&desc,xDim,yDim*zDim,pitch);
//	cudaBindTexture2D(0,&texRef_f8B, f8_dB ,&desc,xDim,yDim*zDim,pitch);
//	cudaBindTexture2D(0,&texRef_f9B, f9_dB ,&desc,xDim,yDim*zDim,pitch);
//	cudaBindTexture2D(0,&texRef_f10B,f10_dB,&desc,xDim,yDim*zDim,pitch);
//	cudaBindTexture2D(0,&texRef_f11B,f11_dB,&desc,xDim,yDim*zDim,pitch);
//	cudaBindTexture2D(0,&texRef_f12B,f12_dB,&desc,xDim,yDim*zDim,pitch);
//	cudaBindTexture2D(0,&texRef_f13B,f13_dB,&desc,xDim,yDim*zDim,pitch);
//	cudaBindTexture2D(0,&texRef_f14B,f14_dB,&desc,xDim,yDim*zDim,pitch);
//	cudaBindTexture2D(0,&texRef_f15B,f15_dB,&desc,xDim,yDim*zDim,pitch);
//	cudaBindTexture2D(0,&texRef_f16B,f16_dB,&desc,xDim,yDim*zDim,pitch);
//	cudaBindTexture2D(0,&texRef_f17B,f17_dB,&desc,xDim,yDim*zDim,pitch);
//	cudaBindTexture2D(0,&texRef_f18B,f18_dB,&desc,xDim,yDim*zDim,pitch);
//	}


//	initialize<<<grid, threads>>>(f0_dA.ptr, f1_dA.ptr, f2_dA.ptr, f3_dA.ptr, f4_dA.ptr, f5_dA.ptr, f6_dA.ptr, f7_dA.ptr, f8_dA.ptr, f9_dA.ptr,
//									f10_dA.ptr, f11_dA.ptr, f12_dA.ptr, f13_dA.ptr, f14_dA.ptr, f15_dA.ptr, f16_dA.ptr, f17_dA.ptr, f18_dA.ptr,
//									xDim,yDim,pitch);
	initialize<<<grid, threads>>>(f0_dA, f1_dA, f2_dA, f3_dA, f4_dA, f5_dA, f6_dA, f7_dA, f8_dA, f9_dA,
									f10_dA, f11_dA, f12_dA, f13_dA, f14_dA, f15_dA, f16_dA, f17_dA, f18_dA,
									xDim,yDim,pitch_elements);


	struct timeval tdr0,tdr1;
	double restime;
	gettimeofday (&tdr0,NULL);
	for(int t = 0; t<tMax; t=t+2){
	//for(int t = 0; t<tMax; t=t+1){
		//mrt_d<<<grid, threads>>>(f0_d,f1_d,f2_d,f3_d,f4_d,f5_d,f6_d,f7_d,f8_d,n,image_d,omega,uMax);
		//test<<<grid, threads>>>(f0_d,f1_dA,f2_dA,f3_dA,f4_dA,f5_dA,f6_dA,f7_dA,f8_dA,
//		mrt_d_textAB<<<grid, threads>>>(f0_dB,f1_dB,f2_dB,f3_dB,f4_dB,f5_dB,f6_dB,f7_dB,f8_dB,f9_dB,
//										f10_dB, f11_dB, f12_dB, f13_dB, f14_dB, f15_dB, f16_dB, f17_dB, f18_dB,
//										image_d,omega,uMax,xDim,yDim,pitch_elements);
//
//		mrt_d_textBA<<<grid, threads>>>(f0_dA,f1_dA,f2_dA,f3_dA,f4_dA,f5_dA,f6_dA,f7_dA,f8_dA,f9_dA,
//										f10_dA, f11_dA, f12_dA, f13_dA, f14_dA, f15_dA, f16_dA, f17_dA, f18_dA,
//										image_d,omega,uMax,xDim,yDim,pitch_elements);
//		mrt_d_AB<<<grid, threads>>>(f0_dB,f1_dB,f2_dB,f3_dB,f4_dB,f5_dB,f6_dB,f7_dB,f8_dB,f9_dB,
//										f10_dB, f11_dB, f12_dB, f13_dB, f14_dB, f15_dB, f16_dB, f17_dB, f18_dB,
//										image_d,omega,uMax,xDim,yDim,pitch_elements);
//
//		mrt_d_BA<<<grid, threads>>>(f0_dA,f1_dA,f2_dA,f3_dA,f4_dA,f5_dA,f6_dA,f7_dA,f8_dA,f9_dA,
//										f10_dA, f11_dA, f12_dA, f13_dA, f14_dA, f15_dA, f16_dA, f17_dA, f18_dA,
//										image_d,omega,uMax,xDim,yDim,pitch_elements);





		if(t%1000 == 0 && t>0) cout<<"finished "<<t<<" timesteps\n";
	}
	cudaDeviceSynchronize();

	gettimeofday (&tdr1,NULL);
	timeval_subtract (&restime, &tdr1, &tdr0);
	cout<<"Time taken for main kernel: "<<restime<<" ("
			<<double(xDim*yDim*zDim*double(tMax/1000000.f))/restime<<"MLUPS)"<<endl;
	cout<<xDim<<","<<yDim<<","<<xDim<<","<<tMax<<","<<restime<<endl;




//	copytest<<<grid, threads>>>(f10_dA,test_d,xDim,yDim,zDim);
//	//copytest<<<grid, threads>>>(test_d);
//	//copytest<<<grid, threads>>>(image_d);
//	cudaUnbindTexture(texRef_f0A);
//	cudaUnbindTexture(texRef_f1A);
//	cudaUnbindTexture(texRef_f2A);
//	cudaUnbindTexture(texRef_f3A);
//	cudaUnbindTexture(texRef_f4A);
//	cudaUnbindTexture(texRef_f5A);
//	cudaUnbindTexture(texRef_f6A);
//	cudaUnbindTexture(texRef_f7A);
//	cudaUnbindTexture(texRef_f8A);
//	cudaUnbindTexture(texRef_f9A);
//	cudaUnbindTexture(texRef_f10A);
//	cudaUnbindTexture(texRef_f11A);
//	cudaUnbindTexture(texRef_f12A);
//	cudaUnbindTexture(texRef_f13A);
//	cudaUnbindTexture(texRef_f14A);
//	cudaUnbindTexture(texRef_f15A);
//	cudaUnbindTexture(texRef_f16A);
//	cudaUnbindTexture(texRef_f17A);
//	cudaUnbindTexture(texRef_f18A);
//	cudaUnbindTexture(texRef_f0B);
//	cudaUnbindTexture(texRef_f1B);
//	cudaUnbindTexture(texRef_f2B);
//	cudaUnbindTexture(texRef_f3B);
//	cudaUnbindTexture(texRef_f4B);
//	cudaUnbindTexture(texRef_f5B);
//	cudaUnbindTexture(texRef_f6B);
//	cudaUnbindTexture(texRef_f7B);
//	cudaUnbindTexture(texRef_f8B);
//	cudaUnbindTexture(texRef_f9B);
//	cudaUnbindTexture(texRef_f10B);
//	cudaUnbindTexture(texRef_f11B);
//	cudaUnbindTexture(texRef_f12B);
//	cudaUnbindTexture(texRef_f13B);
//	cudaUnbindTexture(texRef_f14B);
//	cudaUnbindTexture(texRef_f15B);
//	cudaUnbindTexture(texRef_f16B);
//	cudaUnbindTexture(texRef_f17B);
//	cudaUnbindTexture(texRef_f18B);
//
	cudaMemcpy2D(f0_h,xDim*sizeof(float) , f0_dA,pitch,xDim*sizeof(float),yDim*zDim,cudaMemcpyDeviceToHost);
	cudaMemcpy2D(f1_h,xDim*sizeof(float) , f1_dA,pitch,xDim*sizeof(float),yDim*zDim,cudaMemcpyDeviceToHost);
	cudaMemcpy2D(f2_h,xDim*sizeof(float) , f2_dA,pitch,xDim*sizeof(float),yDim*zDim,cudaMemcpyDeviceToHost);
	cudaMemcpy2D(f3_h,xDim*sizeof(float) , f3_dA,pitch,xDim*sizeof(float),yDim*zDim,cudaMemcpyDeviceToHost);
	cudaMemcpy2D(f4_h,xDim*sizeof(float) , f4_dA,pitch,xDim*sizeof(float),yDim*zDim,cudaMemcpyDeviceToHost);
	cudaMemcpy2D(f5_h,xDim*sizeof(float) , f5_dA,pitch,xDim*sizeof(float),yDim*zDim,cudaMemcpyDeviceToHost);
	cudaMemcpy2D(f6_h,xDim*sizeof(float) , f6_dA,pitch,xDim*sizeof(float),yDim*zDim,cudaMemcpyDeviceToHost);
	cudaMemcpy2D(f7_h,xDim*sizeof(float) , f7_dA,pitch,xDim*sizeof(float),yDim*zDim,cudaMemcpyDeviceToHost);
	cudaMemcpy2D(f8_h,xDim*sizeof(float) , f8_dA,pitch,xDim*sizeof(float),yDim*zDim,cudaMemcpyDeviceToHost);
	cudaMemcpy2D(f9_h,xDim*sizeof(float) , f9_dA,pitch,xDim*sizeof(float),yDim*zDim,cudaMemcpyDeviceToHost);
	cudaMemcpy2D(f10_h,xDim*sizeof(float),f10_dA,pitch,xDim*sizeof(float),yDim*zDim,cudaMemcpyDeviceToHost);
	cudaMemcpy2D(f11_h,xDim*sizeof(float),f11_dA,pitch,xDim*sizeof(float),yDim*zDim,cudaMemcpyDeviceToHost);
	cudaMemcpy2D(f12_h,xDim*sizeof(float),f12_dA,pitch,xDim*sizeof(float),yDim*zDim,cudaMemcpyDeviceToHost);
	cudaMemcpy2D(f13_h,xDim*sizeof(float),f13_dA,pitch,xDim*sizeof(float),yDim*zDim,cudaMemcpyDeviceToHost);
	cudaMemcpy2D(f14_h,xDim*sizeof(float),f14_dA,pitch,xDim*sizeof(float),yDim*zDim,cudaMemcpyDeviceToHost);
	cudaMemcpy2D(f15_h,xDim*sizeof(float),f15_dA,pitch,xDim*sizeof(float),yDim*zDim,cudaMemcpyDeviceToHost);
	cudaMemcpy2D(f16_h,xDim*sizeof(float),f16_dA,pitch,xDim*sizeof(float),yDim*zDim,cudaMemcpyDeviceToHost);
	cudaMemcpy2D(f17_h,xDim*sizeof(float),f17_dA,pitch,xDim*sizeof(float),yDim*zDim,cudaMemcpyDeviceToHost);
	cudaMemcpy2D(f18_h,xDim*sizeof(float),f18_dA,pitch,xDim*sizeof(float),yDim*zDim,cudaMemcpyDeviceToHost);

	cout<<"f1_h is "<<f1_h[0]<<endl;
	//cudaMemcpy(f0_h, f0_d.ptr, memsize, cudaMemcpyDeviceToHost);

	cudaMemcpy(image_h, image_d, memsize_int, cudaMemcpyDeviceToHost);
	cudaMemcpy(test_h, test_d, memsize, cudaMemcpyDeviceToHost);

//	cout<<image_h[0]<<endl;
//	cout<<"test_d: "<<test_h[0]<<endl;
//	for(i = 0; i<n; i++){
//	cout<<f0_h[i]<<",";
//	}


	output<<"VARIABLES = \"X\",\"Y\",\"u\",\"v\",\"w\",\"rho\"\n";
	output<<"ZONE F=POINT, I="<<xDim<<", J="<<yDim*zDim<<"\n";
	
	int row = 0;
	int col = 0;
	i = 0;
	float rho, u, v, w;

	for(row = 0; row<yDim*zDim; row++){
		for(col = 0; col<xDim; col++){
			i = row*xDim+col;
			rho = f0_h[i]+f1_h[i]+f2_h[i]+f3_h[i]+f4_h[i]+f5_h[i]+f6_h[i]+f7_h[i]+f8_h[i]+f9_h[i]+
			      f10_h[i]+f11_h[i]+f12_h[i]+f13_h[i]+f14_h[i]+f15_h[i]+f16_h[i]+f17_h[i]+f18_h[i];
			u = f1_h[i]-f3_h[i]+f5_h[i]-f6_h[i]-f7_h[i]+f8_h[i]+f10_h[i]-f12_h[i]+f15_h[i]-f17_h[i];
			v = f2_h[i]-f4_h[i]+f5_h[i]+f6_h[i]-f7_h[i]-f8_h[i]+f11_h[i]-f13_h[i]+f16_h[i]-f18_h[i];
			w = f9_h[i]+f10_h[i]+f11_h[i]+f12_h[i]+f13_h[i]-f14_h[i]-f15_h[i]-f16_h[i]-f17_h[i]-f18_h[i];
			output<<col<<", "<<row<<", "<<u<<","<<v<<","<<w<<","<<rho<<endl;
		}
	}
	output.close();




	cudaFree(image_d);
	cudaFree(test_d);
	cudaFree(f0_dA);
	cudaFree(f1_dA);
	cudaFree(f2_dA);
	cudaFree(f3_dA);
	cudaFree(f4_dA);
	cudaFree(f5_dA);
	cudaFree(f6_dA);
	cudaFree(f7_dA);
	cudaFree(f8_dA);
	cudaFree(f9_dA);
	cudaFree(f10_dA);
	cudaFree(f11_dA);
	cudaFree(f12_dA);
	cudaFree(f13_dA);
	cudaFree(f14_dA);
	cudaFree(f15_dA);
	cudaFree(f16_dA);
	cudaFree(f17_dA);
	cudaFree(f18_dA);
	cudaFree(f0_dB);
	cudaFree(f1_dB);
	cudaFree(f2_dB);
	cudaFree(f3_dB);
	cudaFree(f4_dB);
	cudaFree(f5_dB);
	cudaFree(f6_dB);
	cudaFree(f7_dB);
	cudaFree(f8_dB);
	cudaFree(f9_dB);
	cudaFree(f10_dB);
	cudaFree(f11_dB);
	cudaFree(f12_dB);
	cudaFree(f13_dB);
	cudaFree(f14_dB);
	cudaFree(f15_dB);
	cudaFree(f16_dB);
	cudaFree(f17_dB);
	cudaFree(f18_dB);
	return(0);

}
