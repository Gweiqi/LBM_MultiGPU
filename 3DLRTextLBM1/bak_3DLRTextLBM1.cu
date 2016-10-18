#include <cuda.h>
//#include <cutil.h>
#include <iostream>
#include <ostream>
#include <fstream>
//#include "/home/yusuke/NVIDIA_GPU_Computing_SDK/C/common/inc/cutil.h"
using namespace std;
	
#define BLOCKSIZEX 64
#define BLOCKSIZEY 1
#define BLOCKSIZEZ 1
#define BLOCKSIZELRX 64
#define BLOCKSIZELRY 1
#define BLOCKSIZELRZ 1
#define XDIM 128
#define YDIM 128
#define ZDIM 128
#define TMAX 10000

#define LRFACTOR 0.5f
#define LRX0 31.75f	//minimum x coord of LR
#define XLRDIM 128	//number of nodes in x
#define LRY0 31.75f
#define YLRDIM 128
#define LRZ0 31.75f
#define ZLRDIM 128

#define RE 100.f
#define UMAX 0.08f
#define METHOD "HYB" //SINGLE,HYB,TEXT,SHARED
#define REFINEMENT "YES" //YES,NO
#define MODEL "MRT" //BGK,MRT,STREAM
//#define CHARLENGTH = XDIM-2.f;
//#define BLOCKSIZE 16;
//int const XDIM = 32;
//int const YDIM = 32;

#include <sys/time.h>
#include <time.h>

inline __device__ int ImageFcn(float x, float y, float z){
	if(y < 0.1f || z < 0.1f || (XDIM-x) < 0.1f || (YDIM-y) < 0.1f || (ZDIM-z) < 0.1f)
		return 1;
	else if(x < 0.1f)
		return 3;
	else
		return 0;
}

inline __device__ int ImageFcn(int x, int y, int z){
	if(y == 0 || z == 0 || x == XDIM-1 || y == YDIM-1 || z == ZDIM-1)
		return 1;
	else if(x == 0)
		return 3;
	else
		return 0;
}

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


texture<float,2,cudaReadModeElementType> texRef_f0C;
texture<float,2,cudaReadModeElementType> texRef_f1C;
texture<float,2,cudaReadModeElementType> texRef_f2C;
texture<float,2,cudaReadModeElementType> texRef_f3C;
texture<float,2,cudaReadModeElementType> texRef_f4C;
texture<float,2,cudaReadModeElementType> texRef_f5C;
texture<float,2,cudaReadModeElementType> texRef_f6C;
texture<float,2,cudaReadModeElementType> texRef_f7C;
texture<float,2,cudaReadModeElementType> texRef_f8C;
texture<float,2,cudaReadModeElementType> texRef_f9C;
texture<float,2,cudaReadModeElementType> texRef_f10C;
texture<float,2,cudaReadModeElementType> texRef_f11C;
texture<float,2,cudaReadModeElementType> texRef_f12C;
texture<float,2,cudaReadModeElementType> texRef_f13C;
texture<float,2,cudaReadModeElementType> texRef_f14C;
texture<float,2,cudaReadModeElementType> texRef_f15C;
texture<float,2,cudaReadModeElementType> texRef_f16C;
texture<float,2,cudaReadModeElementType> texRef_f17C;
texture<float,2,cudaReadModeElementType> texRef_f18C;

texture<float,2,cudaReadModeElementType> texRef_f0D;
texture<float,2,cudaReadModeElementType> texRef_f1D;
texture<float,2,cudaReadModeElementType> texRef_f2D;
texture<float,2,cudaReadModeElementType> texRef_f3D;
texture<float,2,cudaReadModeElementType> texRef_f4D;
texture<float,2,cudaReadModeElementType> texRef_f5D;
texture<float,2,cudaReadModeElementType> texRef_f6D;
texture<float,2,cudaReadModeElementType> texRef_f7D;
texture<float,2,cudaReadModeElementType> texRef_f8D;
texture<float,2,cudaReadModeElementType> texRef_f9D;
texture<float,2,cudaReadModeElementType> texRef_f10D;
texture<float,2,cudaReadModeElementType> texRef_f11D;
texture<float,2,cudaReadModeElementType> texRef_f12D;
texture<float,2,cudaReadModeElementType> texRef_f13D;
texture<float,2,cudaReadModeElementType> texRef_f14D;
texture<float,2,cudaReadModeElementType> texRef_f15D;
texture<float,2,cudaReadModeElementType> texRef_f16D;
texture<float,2,cudaReadModeElementType> texRef_f17D;
texture<float,2,cudaReadModeElementType> texRef_f18D;


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

inline __device__ void bgk_collide(float& f0, float& f1, float& f2,
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
	float usqr = u*u+v*v+w*w;

	f0 = f0 -omega*(f0 -0.3333333333f*(rho-1.5f*usqr));
	f1 = f1 -omega*(f1 -0.0555555556f*(rho+3.0f*u+4.5f*u*u-1.5f*usqr));                
	f2 = f2 -omega*(f2 -0.0555555556f*(rho+3.0f*v+4.5f*v*v-1.5f*usqr));
	f3 = f3 -omega*(f3 -0.0555555556f*(rho-3.0f*u+4.5f*u*u-1.5f*usqr));
	f4 = f4 -omega*(f4 -0.0555555556f*(rho-3.0f*v+4.5f*v*v-1.5f*usqr));
	f5 = f5 -omega*(f5 -0.0277777778f*(rho+3.0f*(u+v)+4.5f*(u+v)*(u+v)-1.5f*usqr));
	f6 = f6 -omega*(f6 -0.0277777778f*(rho+3.0f*(-u+v)+4.5f*(-u+v)*(-u+v)-1.5f*usqr));
	f7 = f7 -omega*(f7 -0.0277777778f*(rho+3.0f*(-u-v)+4.5f*(-u-v)*(-u-v)-1.5f*usqr));
	f8 = f8 -omega*(f8 -0.0277777778f*(rho+3.0f*(u-v)+4.5f*(u-v)*(u-v)-1.5f*usqr));
	f9 = f9 -omega*(f9 -0.0555555556f*(rho+3.0f*w+4.5f*w*w-1.5f*usqr));
	f10= f10-omega*(f10-0.0277777778f*(rho+3.0f*(u+w)+4.5f*(u+w)*(u+w)-1.5f*usqr));
	f11= f11-omega*(f11-0.0277777778f*(rho+3.0f*(v+w)+4.5f*(v+w)*(u+w)-1.5f*usqr));
	f12= f12-omega*(f12-0.0277777778f*(rho+3.0f*(-u+w)+4.5f*(-u+w)*(-u+w)-1.5f*usqr));
	f13= f13-omega*(f13-0.0277777778f*(rho+3.0f*(-v+w)+4.5f*(-v+w)*(u+w)-1.5f*usqr));
	f14= f14-omega*(f14-0.0555555556f*(rho-3.0f*w+4.5f*w*w-1.5f*usqr));
	f15= f15-omega*(f15-0.0277777778f*(rho+3.0f*(u-w)+4.5f*(u-w)*(u-w)-1.5f*usqr));
	f16= f16-omega*(f16-0.0277777778f*(rho+3.0f*(v-w)+4.5f*(v-w)*(v-w)-1.5f*usqr));
	f17= f17-omega*(f17-0.0277777778f*(rho+3.0f*(-u-w)+4.5f*(-u-w)*(-u-w)-1.5f*usqr));
	f18= f18-omega*(f18-0.0277777778f*(rho+3.0f*(-v-w)+4.5f*(-v-w)*(-v-w)-1.5f*usqr));


}


inline __device__ void mrt_collide(float& f0, float& f1, float& f2,
					float& f3 , float& f4 , float& f5 ,
					float& f6 , float& f7 , float& f8 , float& f9,
					float& f10, float& f11, float& f12,
					float& f13, float& f14, float& f15,
					float& f16, float& f17, float& f18, float omega)
//{
//	float rho,u,v,w;	
//	rho = f0+f1+f2+f3+f4+f5+f6+f7+f8+f9+
//	      f10+f11+f12+f13+f14+f15+f16+f17+f18;
//	u = f1-f3+f5-f6-f7+f8+f10-f12+f15-f17;
//	v = f2-f4+f5+f6-f7-f8+f11-f13+f16-f18;
//	w = f9+f10+f11+f12+f13-f14-f15-f16-f17-f18;
//	u = u*rho;
//	v = v*rho;
//	w = w*rho;
//
//	float m1,m2,m4,m6,m8,m9,m10,m11,m12,m13,m14,m15,m16,m17,m18;
//
//	m1  = -30.f*f0+-11.f*f1+-11.f*f2+-11.f*f3+-11.f*f4+  8.f*f5+  8.f*f6+  8.f*f7+  8.f*f8+-11.f*f9+  8.f*f10+  8.f*f11+  8.f*f12+  8.f*f13+-11.f*f14+  8.f*f15+  8.f*f16+  8.f*f17+  8.f*f18;
//	m2  =  12.f*f0+ -4.f*f1+ -4.f*f2+ -4.f*f3+ -4.f*f4+    f5+    f6+    f7+  1.f*f8+ -4.f*f9+    f10+  1.f*f11+    f12+    f13+ -4.f*f14+    f15+    f16+    f17+    f18;
//	m4  =           -4.f*f1         +  4.f*f3         +    f5+ -  f6+ -  f7+    f8         +    f10          + -  f12                    +    f15          + -  f17          ;
//	m6  =                    -4.f*f2         +  4.f*f4+    f5+    f6+ -  f7+ -  f8                   +    f11          + -  f13                    +    f16          + -  f18;
//	m8  =                                                                                 + -4.f*f9+    f10+    f11+    f12+    f13+  4.f*f14+ -  f15+ -  f16+ -  f17+ -  f18;
//	m9  =            2.f*f1+ -  f2+  2.f*f3+ -  f4+    f5+    f6+    f7+    f8+ -  f9+    f10+ -2.f*f11+    f12+ -2.f*f13+ -  f14+    f15+ -2.f*f16+    f17+ -2.f*f18;
//	m10 =           -4.f*f1+  2.f*f2+ -4.f*f3+  2.f*f4+    f5+    f6+    f7+    f8+  2.f*f9+    f10+ -2.f*f11+    f12+ -2.f*f13+  2.f*f14+    f15+ -2.f*f16+    f17+ -2.f*f18;
//	m11 =                       f2         +    f4+    f5+    f6+    f7+    f8+ -  f9+ -  f10          + -  f12          + -  f14+ -  f15          + -  f17          ;
//	m12 =                    -2.f*f2           -2.f*f4+    f5+    f6+    f7+    f8+  2.f*f9+ -  f10          + -  f12          +  2.f*f14+ -  f15          + -  f17          ;
//	m13 =                                                  f5+ -  f6+    f7+ -  f8                                                                                                   ;
//	m14 =                                                                                                         f11          + -  f13                    + -  f16          +    f18;
//	m15 =                                                                                               f10          + -  f12                    + -  f15          +    f17          ;  
//	m16 =                                                  f5+ -  f6+ -  f7+    f8           -  f10          +    f12                    + -  f15          +    f17          ;  
//	m17 =                                               -  f5+ -  f6+    f7+    f8                   +    f11          + -  f13                    +    f16          + -  f18;  
//	m18 =                                                                                               f10+ -  f11+    f12+ -  f13          + -  f15+    f16+ -  f17+    f18;
//
//	m1 -= -11.f*rho+19.f*(u*u+v*v+w*w);
//	m2 -= -7.53968254f*(u*u+v*v+w*w);
//	m4 -= -0.66666667f*u;//qx_eq
//	m6 -= -0.66666667f*v;//qx_eq
//	m8 -= -0.66666667f*w;//qx_eq
//	m9 -= (2.f*u*u-(v*v+w*w));//(2.f*.f*.f-(u1*u1+u2*u2));///3.f;//pxx_eq
//	m11-= (v*v-w*w);//pww_eq
//	m13-= u*v;//pxy_eq
//	m14-= v*w;//pyz_eq
//	m15-= u*w;//pxz_eq
//
//
//f0  -= - 0.012531328f*(m1)+  0.047619048f*(m2);
//f1  -= -0.0045948204f*(m1)+ -0.015873016f*(m2)+   -0.1f*(m4)                                                      +  0.055555556f*(m9)*omega + -0.055555556f*(m10);
//f2  -= -0.0045948204f*(m1)+ -0.015873016f*(m2)                           +   -0.1f*(m6)                           + -0.027777778f*(m9)*omega +  0.027777778f*(m10);
//f3  -= -0.0045948204f*(m1)+ -0.015873016f*(m2)+    0.1f*(m4)                                                      +  0.055555556f*(m9)*omega + -0.055555556f*(m10);
//f4  -= -0.0045948204f*(m1)+ -0.015873016f*(m2)                           +    0.1f*(m6)                           + -0.027777778f*(m9)*omega +  0.027777778f*(m10);
//f5  -=  0.0033416876f*(m1)+  0.003968254f*(m2)+  0.025f*(m4)+  0.025f*(m6)                           +  0.027777778f*(m9)*omega +  0.013888889f*(m10);
//f6  -=  0.0033416876f*(m1)+  0.003968254f*(m2)+ -0.025f*(m4)+  0.025f*(m6)                           +  0.027777778f*(m9)*omega +  0.013888889f*(m10);
//f7  -=  0.0033416876f*(m1)+  0.003968254f*(m2)+ -0.025f*(m4)+ -0.025f*(m6)                           +  0.027777778f*(m9)*omega +  0.013888889f*(m10);
//f8  -=  0.0033416876f*(m1)+  0.003968254f*(m2)+  0.025f*(m4)+ -0.025f*(m6)                           +  0.027777778f*(m9)*omega +  0.013888889f*(m10);
//f9  -= -0.0045948204f*(m1)+ -0.015873016f*(m2)                                                      +   -0.1f*(m8)+ -0.027777778f*(m9)*omega +  0.027777778f*(m10);
//f10 -=  0.0033416876f*(m1)+  0.003968254f*(m2)+  0.025f*(m4)                           +  0.025f*(m8)+  0.027777778f*(m9)*omega +  0.013888889f*(m10);
//f11 -=  0.0033416876f*(m1)+  0.003968254f*(m2)                           +  0.025f*(m6)+  0.025f*(m8)+ -0.055555556f*(m9)*omega + -0.027777778f*(m10);
//f12 -=  0.0033416876f*(m1)+  0.003968254f*(m2)+ -0.025f*(m4)                           +  0.025f*(m8)+  0.027777778f*(m9)*omega +  0.013888889f*(m10);
//f13 -=  0.0033416876f*(m1)+  0.003968254f*(m2)                           + -0.025f*(m6)+  0.025f*(m8)+ -0.055555556f*(m9)*omega + -0.027777778f*(m10);
//f14 -= -0.0045948204f*(m1)+ -0.015873016f*(m2)                                                      +    0.1f*(m8)+ -0.027777778f*(m9)*omega +  0.027777778f*(m10);
//f15 -=  0.0033416876f*(m1)+  0.003968254f*(m2)+  0.025f*(m4)                           + -0.025f*(m8)+  0.027777778f*(m9)*omega +  0.013888889f*(m10);
//f16 -=  0.0033416876f*(m1)+  0.003968254f*(m2)                           +  0.025f*(m6)+ -0.025f*(m8)+ -0.055555556f*(m9)*omega + -0.027777778f*(m10);
//f17 -=  0.0033416876f*(m1)+  0.003968254f*(m2)+ -0.025f*(m4)                           + -0.025f*(m8)+  0.027777778f*(m9)*omega +  0.013888889f*(m10);
//f18 -=  0.0033416876f*(m1)+  0.003968254f*(m2)                           + -0.025f*(m6)+ -0.025f*(m8)+ -0.055555556f*(m9)*omega + -0.027777778f*(m10);
//
//f2  -=  0.083333333f*(m11)*omega + -0.083333333f*(m12);
//f4  -=  0.083333333f*(m11)*omega + -0.083333333f*(m12);
//f5  -=  0.083333333f*(m11)*omega +  0.041666667f*(m12)+ ( 0.25f*(m13)                                                )*omega; 
//f6  -=  0.083333333f*(m11)*omega +  0.041666667f*(m12)+ (-0.25f*(m13)                                                )*omega; 
//f7  -=  0.083333333f*(m11)*omega +  0.041666667f*(m12)+ ( 0.25f*(m13)                                                )*omega; 
//f8  -=  0.083333333f*(m11)*omega +  0.041666667f*(m12)+ (-0.25f*(m13)                                                )*omega; 
//f9  -= -0.083333333f*(m11)*omega +  0.083333333f*(m12);
//f10 -= -0.083333333f*(m11)*omega + -0.041666667f*(m12) +(                                              +  0.25f*(m15))*omega ;
//f11 -=                                                                         +(                         0.25f*(m14)                        )*omega ;
//f12 -= -0.083333333f*(m11)*omega + -0.041666667f*(m12) +(                                              + -0.25f*(m15))*omega ;
//f13 -=                                                                         +(                        -0.25f*(m14)                        )*omega ;
//f14 -= -0.083333333f*(m11)*omega +  0.083333333f*(m12);
//f15 -= -0.083333333f*(m11)*omega + -0.041666667f*(m12) +(                                              + -0.25f*(m15))*omega ;
//f16 -=                                                                         +(                        -0.25f*(m14)                        )*omega ;
//f17 -= -0.083333333f*(m11)*omega + -0.041666667f*(m12) +(                                              +  0.25f*(m15))*omega ;
//f18 -=                                                                         +(                         0.25f*(m14)                        )*omega ;
//
//f5  -=  0.125f*(m16)+ -0.125f*(m17);                        
//f6  -= -0.125f*(m16)+ -0.125f*(m17);                        
//f7  -= -0.125f*(m16)+  0.125f*(m17);                        
//f8  -=  0.125f*(m16)+  0.125f*(m17);                        
//f10 -= -0.125f*(m16)                              +  0.125f*(m18);
//f11 -=                             +  0.125f*(m17)+ -0.125f*(m18);
//f12 -=  0.125f*(m16)                              +  0.125f*(m18);
//f13 -=                             + -0.125f*(m17)+ -0.125f*(m18);
//f15 -= -0.125f*(m16)                              + -0.125f*(m18);
//f16 -=                             +  0.125f*(m17)+  0.125f*(m18);
//f17 -=  0.125f*(m16)                              + -0.125f*(m18);
//f18 -=                             + -0.125f*(m17)+  0.125f*(m18);
//}


{
	float u,v,w;	
//	float rho = f1+f2+f4+f6+f8+f9+f10+f11+f12+f13+f14+f15+f16+f17+f18;
	u = f1-f3+f5-f6-f7+f8+f10-f12+f15-f17;
	v = f2-f4+f5+f6-f7-f8+f11-f13+f16-f18;
	w = f9+f10+f11+f12+f13-f14-f15-f16-f17-f18;
//	u = u*rho;
//	v = v*rho;
//	w = w*rho;

	float m1,m2,m4,m6,m8,m9,m10,m11,m12,m13,m14,m15,m16,m17,m18;


	//COMPUTE M-MEQ
	m1  = -19.f*f0+ 19.f*f5+19.f*f6+19.f*f7+19.f*f8+19.f*f10+19.f*f11+19.f*f12+19.f*f13+19.f*f15+19.f*f16+19.f*f17+19.f*f18   -19.f*(u*u+v*v+w*w);//+8.f*(f5+f6+f7+f8+f10+f11+f12+f13+f15+f16+f17+f18);
	m2  =  12.f*f0+ -4.f*f1+ -4.f*f2+ -4.f*f3+ -4.f*f4+      f5+      f6+      f7+      f8+ -4.f*f9+    f10+        f11+      f12+      f13+ -4.f*f14+      f15+      f16+      f17+      f18 +7.53968254f*(u*u+v*v+w*w);
	m4  = -3.33333333f*f1+3.33333333f*f3+1.66666667f*f5-1.66666667f*f6-1.66666667f*f7+1.66666667f*f8+1.66666667f*f10-1.66666667f*f12+1.66666667f*f15-1.66666667f*f17;
	m6  = -3.33333333f*f2+3.33333333f*f4+1.66666667f*f5+1.66666667f*f6-1.66666667f*f7-1.66666667f*f8+1.66666667f*f11-1.66666667f*f13+1.66666667f*f16-1.66666667f*f18;
	m8  = -3.33333333f*f9+1.66666667f*f10+1.66666667f*f11+1.66666667f*f12+1.66666667f*f13+3.33333333f*f14-1.66666667f*f15-1.66666667f*f16-1.66666667f*f17-1.66666667f*f18;
	m9  =            2.f*f1+   -  f2+  2.f*f3+   -  f4+      f5+      f6+      f7+      f8+ -    f9+    f10+   -2.f*f11+      f12+ -2.f*f13+ -    f14+      f15+ -2.f*f16+      f17+ -2.f*f18  -(2.f*u*u-(v*v+w*w));
	m10 =           -4.f*f1+  2.f*f2+ -4.f*f3+  2.f*f4+      f5+      f6+      f7+      f8+  2.f*f9+    f10+   -2.f*f11+      f12+ -2.f*f13+  2.f*f14+      f15+ -2.f*f16+      f17+ -2.f*f18;
	m11 =                         f2         +      f4+      f5+      f6+      f7+      f8+ -    f9+ -  f10            + -    f12          + -    f14+ -    f15          + -    f17          -(v*v-w*w);
	m12 =                    -2.f*f2           -2.f*f4+      f5+      f6+      f7+      f8+  2.f*f9+ -  f10            + -    f12          +  2.f*f14+ -    f15          + -    f17          ;
	m13 =                                                    f5+   -  f6+      f7+ -    f8                                                                                                     -u*v;
	m14 =                                                                                                           f11          + -    f13                    + -    f16          +      f18  -v*w;
	m15 =                                                                                               f10          + -      f12                    + -    f15          +      f17            -u*w;  
	m16 =                                                    f5+   -  f6+ -    f7+      f8           -  f10          +        f12                    + -    f15          +      f17          ;  
	m17 =                                                 -  f5+   -  f6+      f7+      f8                   +      f11          + -    f13                    +      f16          + -    f18;  
	m18 =                                                                                               f10+ -      f11+      f12+ -    f13          + -    f15+      f16+ -    f17+      f18;


f0 -=- 0.012531328f*(m1)+ 0.047619048f*(m2);
f1 -=-0.0045948204f*(m1)+-0.015873016f*(m2)+  -0.1f*(m4)                 + 0.055555556f*((m9)*omega-m10);
f2 -=-0.0045948204f*(m1)+-0.015873016f*(m2)             +   -0.1f*(m6)   +-0.027777778f*((m9)*omega-m10)+ 0.083333333f*((m11)*omega-m12);
f3 -=-0.0045948204f*(m1)+-0.015873016f*(m2)+   0.1f*(m4)                 + 0.055555556f*((m9)*omega-m10);                                                                                         
f4 -=-0.0045948204f*(m1)+-0.015873016f*(m2)             +    0.1f*(m6)   +-0.027777778f*((m9)*omega-m10)+ 0.083333333f*((m11)*omega-m12);
f5 -= 0.0033416876f*(m1)+ 0.003968254f*(m2)+ 0.025f*(m4+m6)              +0.013888889f*(m10)+0.041666667f*(m12)+0.125f*( m16-m17)+ omega*(0.027777778f*(m9) +0.083333333f*(m11)+( 0.25f*(m13)));
f6 -= 0.0033416876f*(m1)+ 0.003968254f*(m2)+-0.025f*(m4-m6)              +0.013888889f*(m10)+0.041666667f*(m12)+0.125f*(-m16-m17)+ omega*(0.027777778f*(m9) +0.083333333f*(m11)+(-0.25f*(m13)));
f7 -= 0.0033416876f*(m1)+ 0.003968254f*(m2)+-0.025f*(m4+m6)              +0.013888889f*(m10)+0.041666667f*(m12)+0.125f*(-m16+m17)+ omega*(0.027777778f*(m9) +0.083333333f*(m11)+( 0.25f*(m13)));
f8 -= 0.0033416876f*(m1)+ 0.003968254f*(m2)+ 0.025f*(m4-m6)              +0.013888889f*(m10)+0.041666667f*(m12)+0.125f*( m16+m17)+ omega*(0.027777778f*(m9) +0.083333333f*(m11)+(-0.25f*(m13)));
f9 -=-0.0045948204f*(m1)+-0.015873016f*(m2)                +   -0.1f*(m8)+-0.027777778f*((m9)*omega-m10)+-0.083333333f*((m11)*omega-m12);                                       
f10-= 0.0033416876f*(m1)+ 0.003968254f*(m2)+ 0.025f*(m4+m8)              +0.013888889f*(m10)-0.041666667f*(m12)+0.125f*(-m16+m18)+ omega*(0.027777778f*(m9) -0.083333333f*(m11)+( 0.25f*(m15)));
f11-= 0.0033416876f*(m1)+ 0.003968254f*(m2)             +  0.025f*(m6+m8)+0.125f*( m17-m18)-0.027777778f*(m10)+omega*(-0.055555556f*(m9) +( 0.25f*(m14)));
f12-= 0.0033416876f*(m1)+ 0.003968254f*(m2)+-0.025f*(m4-m8)              +0.013888889f*(m10)-0.041666667f*(m12)+0.125f*( m16+m18)+ omega*(0.027777778f*(m9) -0.083333333f*(m11)+(-0.25f*(m15)));
f13-= 0.0033416876f*(m1)+ 0.003968254f*(m2)             + -0.025f*(m6-m8)+0.125f*(-m17-m18)-0.027777778f*(m10)+omega*(-0.055555556f*(m9) +(-0.25f*(m14)));
f14-=-0.0045948204f*(m1)+-0.015873016f*(m2)                +    0.1f*(m8)+-0.027777778f*((m9)*omega-m10)+-0.083333333f*((m11)*omega-m12);                                      
f15-= 0.0033416876f*(m1)+ 0.003968254f*(m2)+ 0.025f*(m4-m8)              +0.013888889f*(m10)-0.041666667f*(m12)+0.125f*(-m16-m18)+ omega*(0.027777778f*(m9) -0.083333333f*(m11)+(-0.25f*(m15)));
f16-= 0.0033416876f*(m1)+ 0.003968254f*(m2)             +  0.025f*(m6-m8)+0.125f*( m17+m18)-0.027777778f*(m10)+omega*(-0.055555556f*(m9) +(-0.25f*(m14)));
f17-= 0.0033416876f*(m1)+ 0.003968254f*(m2)+-0.025f*(m4+m8)              +0.013888889f*(m10)-0.041666667f*(m12)+0.125f*( m16-m18)+ omega*(0.027777778f*(m9) -0.083333333f*(m11)+( 0.25f*(m15)));
f18-= 0.0033416876f*(m1)+ 0.003968254f*(m2)             + -0.025f*(m6+m8)+0.125f*(-m17+m18)-0.027777778f*(m10)+omega*(-0.055555556f*(m9) +( 0.25f*(m14)));
}

inline __device__ int f_mem(int f_num, int x, int y, int z, size_t pitch)
{

	return (x+y*pitch+z*YDIM*pitch)+f_num*pitch*YDIM*ZDIM;
}

inline __device__ int f_memLR(int f_num, int x, int y, int z, size_t pitch)
{

	return (x+y*pitch+z*YLRDIM*pitch)+f_num*pitch*YLRDIM*ZLRDIM;
}

__device__ int dmin(int a, int b)
{
	if (a<b) return a;
	else return b-1;
}
__device__ int dmax(int a)
{
	if (a>-1) return a;
	else return 0;
}

__global__ void simple_copy(float* fA, float* fB,
							int *image, float omega, size_t pitch)//pitch in elements
{
	int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
	int y = threadIdx.y+blockIdx.y*blockDim.y;
	int z = threadIdx.z+blockIdx.z*blockDim.z;
	int j = x+y*pitch+z*YDIM*pitch;//index on padded mem (pitch in elements)

	fB[j] = fA[j];//+0.01f;
}


__global__ void ExtractFromC_d(float* fout,
							size_t pitch, float SF)//pitch in elements
{
	int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
	int y = threadIdx.y+blockIdx.y*blockDim.y;
	int z = threadIdx.z+blockIdx.z*blockDim.z;
	float f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18;
//	if(x < LRX0+1 || x > LRX0+XLRDIM-2 || y < LRY0+1 || y > LRY0+YLRDIM-2 || z < LRZ0+1 || z > LRZ0+ZLRDIM-2)
//	//if(x < LRX0+2 || x > LRX0+XLRDIM-3 || y < LRY0+2 || y > LRY0+YLRDIM-3 || z < LRZ0+2 || z > LRZ0+ZLRDIM-3)
//	{
//	//do nothing
//	}
//	else{
	if( (x > LRX0+1 && x < LRX0+XLRDIM*LRFACTOR-1 && y > LRY0+1 && y < LRY0+YLRDIM*LRFACTOR-1 && z > LRZ0+1 && z < LRZ0+ZLRDIM*LRFACTOR-1) && 
	(x == int(LRX0+2) || x == int(LRX0+XLRDIM*LRFACTOR-1) || y == int(LRY0+2) || y == int(LRY0+YLRDIM*LRFACTOR-1) || z == int(LRZ0+2) || z == int(LRY0+ZLRDIM*LRFACTOR-1)) )
	{
//	if(x > 10 && y > 10 && z > 10 && x < 20 && y < 20 && z < 20)
//	{
	float xcoord = 2.0f*(x-LRX0)+0.5f;
	float ycoord = 2.0f*(y-LRY0)+0.5f;
	float zcoord = 2.0f*(z-LRZ0);
	int zminus = int(zcoord);
	int zplus = zminus+1;
	f0 = (zplus-zcoord)*tex2D(texRef_f0C ,xcoord,ycoord+YLRDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f0C ,xcoord,ycoord+YLRDIM*(zplus));
	f2 = (zplus-zcoord)*tex2D(texRef_f2C ,xcoord,ycoord+YLRDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f2C ,xcoord,ycoord+YLRDIM*(zplus));
	f4 = (zplus-zcoord)*tex2D(texRef_f4C ,xcoord,ycoord+YLRDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f4C ,xcoord,ycoord+YLRDIM*(zplus));
	f9 = (zplus-zcoord)*tex2D(texRef_f9C ,xcoord,ycoord+YLRDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f9C ,xcoord,ycoord+YLRDIM*(zplus));
	f11= (zplus-zcoord)*tex2D(texRef_f11C,xcoord,ycoord+YLRDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f11C,xcoord,ycoord+YLRDIM*(zplus));
	f13= (zplus-zcoord)*tex2D(texRef_f13C,xcoord,ycoord+YLRDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f13C,xcoord,ycoord+YLRDIM*(zplus));
	f14= (zplus-zcoord)*tex2D(texRef_f14C,xcoord,ycoord+YLRDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f14C,xcoord,ycoord+YLRDIM*(zplus));
	f16= (zplus-zcoord)*tex2D(texRef_f16C,xcoord,ycoord+YLRDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f16C,xcoord,ycoord+YLRDIM*(zplus));
	f18= (zplus-zcoord)*tex2D(texRef_f18C,xcoord,ycoord+YLRDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f18C,xcoord,ycoord+YLRDIM*(zplus));
	f1 = (zplus-zcoord)*tex2D(texRef_f1C ,xcoord,ycoord+YLRDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f1C ,xcoord,ycoord+YLRDIM*(zplus));
	f3 = (zplus-zcoord)*tex2D(texRef_f3C ,xcoord,ycoord+YLRDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f3C ,xcoord,ycoord+YLRDIM*(zplus));
	f5 = (zplus-zcoord)*tex2D(texRef_f5C ,xcoord,ycoord+YLRDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f5C ,xcoord,ycoord+YLRDIM*(zplus));
	f6 = (zplus-zcoord)*tex2D(texRef_f6C ,xcoord,ycoord+YLRDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f6C ,xcoord,ycoord+YLRDIM*(zplus));
	f7 = (zplus-zcoord)*tex2D(texRef_f7C ,xcoord,ycoord+YLRDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f7C ,xcoord,ycoord+YLRDIM*(zplus));
	f8 = (zplus-zcoord)*tex2D(texRef_f8C ,xcoord,ycoord+YLRDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f8C ,xcoord,ycoord+YLRDIM*(zplus));
	f15= (zplus-zcoord)*tex2D(texRef_f15C,xcoord,ycoord+YLRDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f15C,xcoord,ycoord+YLRDIM*(zplus));
	f17= (zplus-zcoord)*tex2D(texRef_f17C,xcoord,ycoord+YLRDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f17C,xcoord,ycoord+YLRDIM*(zplus));
	f10= (zplus-zcoord)*tex2D(texRef_f10C,xcoord,ycoord+YLRDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f10C,xcoord,ycoord+YLRDIM*(zplus));
	f12= (zplus-zcoord)*tex2D(texRef_f12C,xcoord,ycoord+YLRDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f12C,xcoord,ycoord+YLRDIM*(zplus));

	float rho,u,v,w;	
	rho = f0+f1+f2+f3+f4+f5+f6+f7+f8+f9+
	      f10+f11+f12+f13+f14+f15+f16+f17+f18;
	u = f1-f3+f5-f6-f7+f8+f10-f12+f15-f17;
	v = f2-f4+f5+f6-f7-f8+f11-f13+f16-f18;
	w = f9+f10+f11+f12+f13-f14-f15-f16-f17-f18;
	float usqr = fma(u,u,fma(v,v,w*w));

//	float m1 -= -11.f*rho+19.f*(u*u+v*v+w*w);
//	float m4 = -0.66666667f*u;//qx_eq
//	float m6 = -0.66666667f*v;//qx_eq
//	float m8 = -0.66666667f*w;//qx_eq
//	float m9 -= (2.f*u*u-(v*v+w*w));//(2.f*.f*.f-(u1*u1+u2*u2));///3.f;//pxx_eq
//	float m11-= (v*v-w*w);//pww_eq
//	float m13-= u*v;//pxy_eq
//	float m14-= v*w;//pyz_eq
//	float m15-= u*w;//pxz_eq

	if(MODEL == "MRT")
	{
	float meq0 = rho;
	float meq1 = -11.f*rho+19.f*(u*u+v*v+w*w);
	float meq2 = -7.53968254f*(u*u+v*v+w*w);
	float meq3 = u;
	float meq4 = -0.66666667f*u;//qx_eq
	float meq5 = v;
	float meq6 = -0.66666667f*v;//qx_eq
	float meq7 = w;
	float meq8 = -0.66666667f*w;//qx_eq
	float meq9 = (2.f*u*u-(v*v+w*w));//(2.f*.f*.f-(u1*u1+u2*u2));///3.f;//pxx_eq
	float meq11= (v*v-w*w);//pww_eq
	float meq13= u*v;//pxy_eq
	float meq14= v*w;//pyz_eq
	float meq15= u*w;//pxz_eq

float feq0 = 0.052631579f*meq0+  -0.012531328f*meq1+  0.047619048f*meq2                                                                                    ;
float feq1 = 0.052631579f*meq0+ -0.0045948204f*meq1+ -0.015873016f*meq2+  0.1f*meq3+   -0.1f*meq4                                                        ;
float feq2 = 0.052631579f*meq0+ -0.0045948204f*meq1+ -0.015873016f*meq2                            +  0.1f*meq5+   -0.1f*meq6                            ;
float feq3 = 0.052631579f*meq0+ -0.0045948204f*meq1+ -0.015873016f*meq2+ -0.1f*meq3+    0.1f*meq4                                                        ;
float feq4 = 0.052631579f*meq0+ -0.0045948204f*meq1+ -0.015873016f*meq2                            + -0.1f*meq5+    0.1f*meq6                            ;
float feq5 = 0.052631579f*meq0+  0.0033416876f*meq1+  0.003968254f*meq2+  0.1f*meq3+  0.025f*meq4+  0.1f*meq5+  0.025f*meq6                            ;
float feq6 = 0.052631579f*meq0+  0.0033416876f*meq1+  0.003968254f*meq2+ -0.1f*meq3+ -0.025f*meq4+  0.1f*meq5+  0.025f*meq6                            ;
float feq7 = 0.052631579f*meq0+  0.0033416876f*meq1+  0.003968254f*meq2+ -0.1f*meq3+ -0.025f*meq4+ -0.1f*meq5+ -0.025f*meq6                            ;
float feq8 = 0.052631579f*meq0+  0.0033416876f*meq1+  0.003968254f*meq2+  0.1f*meq3+  0.025f*meq4+ -0.1f*meq5+ -0.025f*meq6                            ;
float feq9 = 0.052631579f*meq0+ -0.0045948204f*meq1+ -0.015873016f*meq2                                                        +  0.1f*meq7+   -0.1f*meq8;
float feq10= 0.052631579f*meq0+  0.0033416876f*meq1+  0.003968254f*meq2+  0.1f*meq3+  0.025f*meq4                            +  0.1f*meq7+  0.025f*meq8;
float feq11= 0.052631579f*meq0+  0.0033416876f*meq1+  0.003968254f*meq2                            +  0.1f*meq5+  0.025f*meq6+  0.1f*meq7+  0.025f*meq8;
float feq12= 0.052631579f*meq0+  0.0033416876f*meq1+  0.003968254f*meq2+ -0.1f*meq3+ -0.025f*meq4                            +  0.1f*meq7+  0.025f*meq8;
float feq13= 0.052631579f*meq0+  0.0033416876f*meq1+  0.003968254f*meq2                            + -0.1f*meq5+ -0.025f*meq6+  0.1f*meq7+  0.025f*meq8;
float feq14= 0.052631579f*meq0+ -0.0045948204f*meq1+ -0.015873016f*meq2                                                        + -0.1f*meq7+    0.1f*meq8;
float feq15= 0.052631579f*meq0+  0.0033416876f*meq1+  0.003968254f*meq2+  0.1f*meq3+  0.025f*meq4                            + -0.1f*meq7+ -0.025f*meq8;
float feq16= 0.052631579f*meq0+  0.0033416876f*meq1+  0.003968254f*meq2                            +  0.1f*meq5+  0.025f*meq6+ -0.1f*meq7+ -0.025f*meq8;
float feq17= 0.052631579f*meq0+  0.0033416876f*meq1+  0.003968254f*meq2+ -0.1f*meq3+ -0.025f*meq4                            + -0.1f*meq7+ -0.025f*meq8;
float feq18= 0.052631579f*meq0+  0.0033416876f*meq1+  0.003968254f*meq2+                           + -0.1f*meq5+ -0.025f*meq6+ -0.1f*meq7+ -0.025f*meq8;

feq1 +=  0.055555556f*meq9;
feq2 += -0.027777778f*meq9+  0.083333333f*meq11;
feq3 +=  0.055555556f*meq9;
feq4 += -0.027777778f*meq9+  0.083333333f*meq11;
feq5 +=  0.027777778f*meq9+  0.083333333f*meq11+  0.25f*meq13                              ;
feq6 +=  0.027777778f*meq9+  0.083333333f*meq11+ -0.25f*meq13                              ;
feq7 +=  0.027777778f*meq9+  0.083333333f*meq11+  0.25f*meq13                              ;
feq8 +=  0.027777778f*meq9+  0.083333333f*meq11+ -0.25f*meq13                              ;
feq9 += -0.027777778f*meq9+ -0.083333333f*meq11                                            ;
feq10+=  0.027777778f*meq9+ -0.083333333f*meq11                              +  0.25f*meq15;
feq11+= -0.055555556f*meq9                                      +  0.25f*meq14             ;
feq12+=  0.027777778f*meq9+ -0.083333333f*meq11                              + -0.25f*meq15;
feq13+= -0.055555556f*meq9                                        -0.25f*meq14             ;
feq14+= -0.027777778f*meq9+ -0.083333333f*meq11                                            ;
feq15+=  0.027777778f*meq9+ -0.083333333f*meq11                              + -0.25f*meq15;
feq16+= -0.055555556f*meq9                                      + -0.25f*meq14             ;
feq17+=  0.027777778f*meq9+ -0.083333333f*meq11                              +  0.25f*meq15;
feq18+= -0.055555556f*meq9                                                           +  0.25f*meq14             ;


f0 =SF*f0 +(1.0f-SF)*feq0 ;
f1 =SF*f1 +(1.0f-SF)*feq1 ;
f2 =SF*f2 +(1.0f-SF)*feq2 ;
f3 =SF*f3 +(1.0f-SF)*feq3 ;
f4 =SF*f4 +(1.0f-SF)*feq4 ;
f5 =SF*f5 +(1.0f-SF)*feq5 ;
f6 =SF*f6 +(1.0f-SF)*feq6 ;
f7 =SF*f7 +(1.0f-SF)*feq7 ;
f8 =SF*f8 +(1.0f-SF)*feq8 ;
f9 =SF*f9 +(1.0f-SF)*feq9 ;
f10=SF*f10+(1.0f-SF)*feq10;
f11=SF*f11+(1.0f-SF)*feq11;
f12=SF*f12+(1.0f-SF)*feq12;
f13=SF*f13+(1.0f-SF)*feq13;
f14=SF*f14+(1.0f-SF)*feq14;
f15=SF*f15+(1.0f-SF)*feq15;
f16=SF*f16+(1.0f-SF)*feq16;
f17=SF*f17+(1.0f-SF)*feq17;
f18=SF*f18+(1.0f-SF)*feq18;






//	float m2 = -7.53968254f*(u*u+v*v+w*w);
//	//scale
//	f0 =SF*f0 +(1.0f-SF)*(0.052631579f*rho+ -0.012531328f*(-11.f*rho+19.f*usqr)+ 0.047619048f*m2);
//	f1 =SF*f1 +(1.0f-SF)*(0.052631579f*rho+-0.0045948204f*(-11.f*rho+19.f*usqr)+-0.015873016f*m2 +( 0.1666666667f*u)                +0.055555556f*(2.f*u*u-(v*v+w*w))                          );
//	f2 =SF*f2 +(1.0f-SF)*(0.052631579f*rho+-0.0045948204f*(-11.f*rho+19.f*usqr)+-0.015873016f*m2 +( 0.1666666667f*v)                -0.027777778f*(2.f*u*u-(v*v+w*w))  +0.0833333333f*(v*v-w*w)            );
//	f3 =SF*f3 +(1.0f-SF)*(0.052631579f*rho+-0.0045948204f*(-11.f*rho+19.f*usqr)+-0.015873016f*m2 +(-0.1666666667f*u)                +0.055555556f*(2.f*u*u-(v*v+w*w))                          );
//	f4 =SF*f4 +(1.0f-SF)*(0.052631579f*rho+-0.0045948204f*(-11.f*rho+19.f*usqr)+-0.015873016f*m2 +(-0.1666666667f*v)                -0.027777778f*(2.f*u*u-(v*v+w*w))  +0.0833333333f*(v*v-w*w)            );
//	f5 =SF*f5 +(1.0f-SF)*(0.052631579f*rho+ 0.0033416876f*(-11.f*rho+19.f*usqr)+ 0.003968254f*m2 +0.1f*( u+v)+0.01666666667f*(-u-v) +0.027777778f*(2.f*u*u-(v*v+w*w))  +0.0833333333f*(v*v-w*w)+0.25f*(u*v)    );
//	f6 =SF*f6 +(1.0f-SF)*(0.052631579f*rho+ 0.0033416876f*(-11.f*rho+19.f*usqr)+ 0.003968254f*m2 +0.1f*(-u+v)+0.01666666667f*( u-v) +0.027777778f*(2.f*u*u-(v*v+w*w))  +0.0833333333f*(v*v-w*w)-0.25f*(u*v)    );
//	f7 =SF*f7 +(1.0f-SF)*(0.052631579f*rho+ 0.0033416876f*(-11.f*rho+19.f*usqr)+ 0.003968254f*m2 +0.1f*(-u-v)+0.01666666667f*( u+v) +0.027777778f*(2.f*u*u-(v*v+w*w))  +0.0833333333f*(v*v-w*w)+0.25f*(u*v)    );
//	f8 =SF*f8 +(1.0f-SF)*(0.052631579f*rho+ 0.0033416876f*(-11.f*rho+19.f*usqr)+ 0.003968254f*m2 +0.1f*( u-v)+0.01666666667f*(-u+v) +0.027777778f*(2.f*u*u-(v*v+w*w))  +0.0833333333f*(v*v-w*w)-0.25f*(u*v)    );
//	f9 =SF*f9 +(1.0f-SF)*(0.052631579f*rho+-0.0045948204f*(-11.f*rho+19.f*usqr)+-0.015873016f*m2 +( 0.1666666667f*w)                -0.027777778f*(2.f*u*u-(v*v+w*w))  -0.0833333333f*(v*v-w*w)            );
//	f10=SF*f10+(1.0f-SF)*(0.052631579f*rho+ 0.0033416876f*(-11.f*rho+19.f*usqr)+ 0.003968254f*m2 +0.1f*( u+w)+0.01666666667f*(-u-w) +0.027777778f*(2.f*u*u-(v*v+w*w))  -0.0833333333f*(v*v-w*w)      +0.25f*u*v);
//	f11=SF*f11+(1.0f-SF)*(0.052631579f*rho+ 0.0033416876f*(-11.f*rho+19.f*usqr)+ 0.003968254f*m2 +0.1f*( v+w)+0.01666666667f*(-v-w) -0.055555556f*(2.f*u*u-(v*v+w*w))                         +0.25f*v*w      );
//	f12=SF*f12+(1.0f-SF)*(0.052631579f*rho+ 0.0033416876f*(-11.f*rho+19.f*usqr)+ 0.003968254f*m2 +0.1f*(-u+w)+0.01666666667f*( u-w) +0.027777778f*(2.f*u*u-(v*v+w*w))  -0.0833333333f*(v*v-w*w)      -0.25f*u*v);
//	f13=SF*f13+(1.0f-SF)*(0.052631579f*rho+ 0.0033416876f*(-11.f*rho+19.f*usqr)+ 0.003968254f*m2 +0.1f*(-v+w)+0.01666666667f*(-v-w) -0.055555556f*(2.f*u*u-(v*v+w*w))                         -0.25f*v*w      );
//	f14=SF*f14+(1.0f-SF)*(0.052631579f*rho+-0.0045948204f*(-11.f*rho+19.f*usqr)+-0.015873016f*m2 +(-0.1666666667f*w)                +0.027777778f*(2.f*u*u-(v*v+w*w))  -0.0833333333f*(v*v-w*w)            );
//	f15=SF*f15+(1.0f-SF)*(0.052631579f*rho+ 0.0033416876f*(-11.f*rho+19.f*usqr)+ 0.003968254f*m2 +0.1f*( u-w)+0.01666666667f*(-u+w) +0.027777778f*(2.f*u*u-(v*v+w*w))  -0.0833333333f*(v*v-w*w)      +0.25f*u*v);
//	f16=SF*f16+(1.0f-SF)*(0.052631579f*rho+ 0.0033416876f*(-11.f*rho+19.f*usqr)+ 0.003968254f*m2 +0.1f*( v-w)+0.01666666667f*(-v+w) -0.055555556f*(2.f*u*u-(v*v+w*w))                         +0.25f*v*w      );
//	f17=SF*f17+(1.0f-SF)*(0.052631579f*rho+ 0.0033416876f*(-11.f*rho+19.f*usqr)+ 0.003968254f*m2 +0.1f*(-u-w)+0.01666666667f*( u+w) +0.027777778f*(2.f*u*u-(v*v+w*w))  -0.0833333333f*(v*v-w*w)      +0.25f*u*v);
//	f18=SF*f18+(1.0f-SF)*(0.052631579f*rho+ 0.0033416876f*(-11.f*rho+19.f*usqr)+ 0.003968254f*m2 +0.1f*(-v-w)+0.01666666667f*(-v+w) -0.055555556f*(2.f*u*u-(v*v+w*w))                         +0.25f*v*w      );
	}
	else
	{
//	//scale
//f0 =SF*f0 +(1.0f-SF)*(0.052631579f*rho+ -0.012531328f*(-11.f*rho+19.f*usqr)+ 0.047619048f*m2);
//f1 =SF*f1 +(1.0f-SF)*(0.052631579f*rho+-0.0045948204f*(-11.f*rho+19.f*usqr)+-0.015873016f*m2 +0.1f*(u+0.666666667f*u)                  +0.055555556f*(2.f*u*u-(v*v+w*w))                          );
//f2 =SF*f2 +(1.0f-SF)*(0.052631579f*rho+-0.0045948204f*(-11.f*rho+19.f*usqr)+-0.015873016f*m2 +0.1f*(v+0.666666667f*v)                  -0.027777778f*(2.f*u*u-(v*v+w*w))  +0.0833333333f*(v*v-w*w)            );
//f3 =SF*f3 +(1.0f-SF)*(0.052631579f*rho+-0.0045948204f*(-11.f*rho+19.f*usqr)+-0.015873016f*m2 +0.1f*(-0.666666667f*u-u)                  +0.055555556f*(2.f*u*u-(v*v+w*w))                          );
//f4 =SF*f4 +(1.0f-SF)*(0.052631579f*rho+-0.0045948204f*(-11.f*rho+19.f*usqr)+-0.015873016f*m2 +0.1f*(-0.666666667f*v-v)                  -0.027777778f*(2.f*u*u-(v*v+w*w))  +0.0833333333f*(v*v-w*w)            );
//f5 =SF*f5 +(1.0f-SF)*(0.052631579f*rho+ 0.0033416876f*(-11.f*rho+19.f*usqr)+ 0.003968254f*m2 +0.1f*( u+v)+0.025f*( -0.666666667f*u+-0.666666667f*v)  +0.027777778f*(2.f*u*u-(v*v+w*w))  +0.0833333333f*(v*v-w*w)+0.25f*(u*v)    );
//f6 =SF*f6 +(1.0f-SF)*(0.052631579f*rho+ 0.0033416876f*(-11.f*rho+19.f*usqr)+ 0.003968254f*m2 +0.1f*(-u+v)+0.025f*(+0.666666667f*u+-0.666666667f*v)  +0.027777778f*(2.f*u*u-(v*v+w*w))  +0.0833333333f*(v*v-w*w)-0.25f*(u*v)    );
//f7 =SF*f7 +(1.0f-SF)*(0.052631579f*rho+ 0.0033416876f*(-11.f*rho+19.f*usqr)+ 0.003968254f*m2 +0.1f*(-u-v)+0.025f*(+0.666666667f*u+0.666666667f*v)  +0.027777778f*(2.f*u*u-(v*v+w*w))  +0.0833333333f*(v*v-w*w)+0.25f*(u*v)    );
//f8 =SF*f8 +(1.0f-SF)*(0.052631579f*rho+ 0.0033416876f*(-11.f*rho+19.f*usqr)+ 0.003968254f*m2 +0.1f*( u-v)+0.025f*( -0.666666667f*u+0.666666667f*v)  +0.027777778f*(2.f*u*u-(v*v+w*w))  +0.0833333333f*(v*v-w*w)-0.25f*(u*v)    );
//f9 =SF*f9 +(1.0f-SF)*(0.052631579f*rho+-0.0045948204f*(-11.f*rho+19.f*usqr)+-0.015873016f*m2 +0.1f*(w+0.666666667f*w)                  -0.027777778f*(2.f*u*u-(v*v+w*w))  -0.0833333333f*(v*v-w*w)            );
//f10=SF*f10+(1.0f-SF)*(0.052631579f*rho+ 0.0033416876f*(-11.f*rho+19.f*usqr)+ 0.003968254f*m2 +0.1f*( u+w)+0.025f*( -0.666666667f*u+-0.666666667f*w)  +0.027777778f*(2.f*u*u-(v*v+w*w))  -0.0833333333f*(v*v-w*w)      +0.25f*u*v);
//f11=SF*f11+(1.0f-SF)*(0.052631579f*rho+ 0.0033416876f*(-11.f*rho+19.f*usqr)+ 0.003968254f*m2 +0.1f*( v+w)+0.025f*( -0.666666667f*v+-0.666666667f*w)  -0.055555556f*(2.f*u*u-(v*v+w*w))                         +0.25f*v*w      );
//f12=SF*f12+(1.0f-SF)*(0.052631579f*rho+ 0.0033416876f*(-11.f*rho+19.f*usqr)+ 0.003968254f*m2 +0.1f*(-u+w)+0.025f*(+0.666666667f*u+-0.666666667f*w)  +0.027777778f*(2.f*u*u-(v*v+w*w))  -0.0833333333f*(v*v-w*w)      -0.25f*u*v);
//f13=SF*f13+(1.0f-SF)*(0.052631579f*rho+ 0.0033416876f*(-11.f*rho+19.f*usqr)+ 0.003968254f*m2 +0.1f*(-v+w)+0.025f*( -0.666666667f*v+-0.666666667f*w)  -0.055555556f*(2.f*u*u-(v*v+w*w))                         -0.25f*v*w      );
//f14=SF*f14+(1.0f-SF)*(0.052631579f*rho+-0.0045948204f*(-11.f*rho+19.f*usqr)+-0.015873016f*m2 +0.1f*(-0.666666667f*w-w)                  +0.027777778f*(2.f*u*u-(v*v+w*w))  +0.0833333333f*(v*v-w*w)            );
//f15=SF*f15+(1.0f-SF)*(0.052631579f*rho+ 0.0033416876f*(-11.f*rho+19.f*usqr)+ 0.003968254f*m2 +0.1f*( u-w)+0.025f*( -0.666666667f*u+0.666666667f*w)  +0.027777778f*(2.f*u*u-(v*v+w*w))  -0.0833333333f*(v*v-w*w)      +0.25f*u*v);
//f16=SF*f16+(1.0f-SF)*(0.052631579f*rho+ 0.0033416876f*(-11.f*rho+19.f*usqr)+ 0.003968254f*m2 +0.1f*( v-w)+0.025f*( -0.666666667f*v+0.666666667f*w)  -0.055555556f*(2.f*u*u-(v*v+w*w))                         +0.25f*v*w      );
//f17=SF*f17+(1.0f-SF)*(0.052631579f*rho+ 0.0033416876f*(-11.f*rho+19.f*usqr)+ 0.003968254f*m2 +0.1f*(-u-w)+0.025f*(+0.666666667f*u+0.666666667f*w)  +0.027777778f*(2.f*u*u-(v*v+w*w))  -0.0833333333f*(v*v-w*w)      +0.25f*u*v);
//f18=SF*f18+(1.0f-SF)*(0.052631579f*rho+ 0.0033416876f*(-11.f*rho+19.f*usqr)+ 0.003968254f*m2 +0.1f*(-v-w)+0.025f*( -0.666666667f*v+0.666666667f*w)  -0.055555556f*(2.f*u*u-(v*v+w*w))                         +0.25f*v*w      );
	//scale
	f0 =SF*f0 +(1.0f-SF)*(0.3333333333f*(rho-1.5f*usqr));
	f1 =SF*f1 +(1.0f-SF)*(0.0555555556f*(rho+3.0f*u+4.5f*u*u-1.5f*usqr));                
	f2 =SF*f2 +(1.0f-SF)*(0.0555555556f*(rho+3.0f*v+4.5f*v*v-1.5f*usqr));
	f3 =SF*f3 +(1.0f-SF)*(0.0555555556f*(rho-3.0f*u+4.5f*u*u-1.5f*usqr));
	f4 =SF*f4 +(1.0f-SF)*(0.0555555556f*(rho-3.0f*v+4.5f*v*v-1.5f*usqr));
	f5 =SF*f5 +(1.0f-SF)*(0.0277777778f*(rho+3.0f*(u+v)+4.5f*(u+v)*(u+v)-1.5f*usqr));
	f6 =SF*f6 +(1.0f-SF)*(0.0277777778f*(rho+3.0f*(-u+v)+4.5f*(-u+v)*(-u+v)-1.5f*usqr));
	f7 =SF*f7 +(1.0f-SF)*(0.0277777778f*(rho+3.0f*(-u-v)+4.5f*(-u-v)*(-u-v)-1.5f*usqr));
	f8 =SF*f8 +(1.0f-SF)*(0.0277777778f*(rho+3.0f*(u-v)+4.5f*(u-v)*(u-v)-1.5f*usqr));
	f9 =SF*f9 +(1.0f-SF)*(0.0555555556f*(rho+3.0f*w+4.5f*w*w-1.5f*usqr));
	f10=SF*f10+(1.0f-SF)*(0.0277777778f*(rho+3.0f*(u+w)+4.5f*(u+w)*(u+w)-1.5f*usqr));
	f11=SF*f11+(1.0f-SF)*(0.0277777778f*(rho+3.0f*(v+w)+4.5f*(v+w)*(u+w)-1.5f*usqr));
	f12=SF*f12+(1.0f-SF)*(0.0277777778f*(rho+3.0f*(-u+w)+4.5f*(-u+w)*(-u+w)-1.5f*usqr));
	f13=SF*f13+(1.0f-SF)*(0.0277777778f*(rho+3.0f*(-v+w)+4.5f*(-v+w)*(u+w)-1.5f*usqr));
	f14=SF*f14+(1.0f-SF)*(0.0555555556f*(rho-3.0f*w+4.5f*w*w-1.5f*usqr));
	f15=SF*f15+(1.0f-SF)*(0.0277777778f*(rho+3.0f*(u-w)+4.5f*(u-w)*(u-w)-1.5f*usqr));
	f16=SF*f16+(1.0f-SF)*(0.0277777778f*(rho+3.0f*(v-w)+4.5f*(v-w)*(v-w)-1.5f*usqr));
	f17=SF*f17+(1.0f-SF)*(0.0277777778f*(rho+3.0f*(-u-w)+4.5f*(-u-w)*(-u-w)-1.5f*usqr));
	f18=SF*f18+(1.0f-SF)*(0.0277777778f*(rho+3.0f*(-v-w)+4.5f*(-v-w)*(-v-w)-1.5f*usqr));
	}

	fout[f_mem(0 ,x,y,z,pitch)] = f0 ;
	fout[f_mem(1 ,x,y,z,pitch)] = f1 ;
	fout[f_mem(2 ,x,y,z,pitch)] = f2 ;
	fout[f_mem(3 ,x,y,z,pitch)] = f3 ;
	fout[f_mem(4 ,x,y,z,pitch)] = f4 ;
	fout[f_mem(5 ,x,y,z,pitch)] = f5 ;
	fout[f_mem(6 ,x,y,z,pitch)] = f6 ;
	fout[f_mem(7 ,x,y,z,pitch)] = f7 ;
	fout[f_mem(8 ,x,y,z,pitch)] = f8 ;
	fout[f_mem(9 ,x,y,z,pitch)] = f9 ;
	fout[f_mem(10,x,y,z,pitch)] = f10;
	fout[f_mem(11,x,y,z,pitch)] = f11;
	fout[f_mem(12,x,y,z,pitch)] = f12;
	fout[f_mem(13,x,y,z,pitch)] = f13;
	fout[f_mem(14,x,y,z,pitch)] = f14;
	fout[f_mem(15,x,y,z,pitch)] = f15;
	fout[f_mem(16,x,y,z,pitch)] = f16;
	fout[f_mem(17,x,y,z,pitch)] = f17;
	fout[f_mem(18,x,y,z,pitch)] = f18;

	}
}

__global__ void LR_d_hybABCD(float* fin, float* fout,
							float omega, size_t pitch)//pitch in elements
{
	int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
	int y = threadIdx.y+blockIdx.y*blockDim.y;
	int z = threadIdx.z+blockIdx.z*blockDim.z;
	float xcoord = LRX0+x*LRFACTOR;
	float ycoord = LRY0+y*LRFACTOR;
	float zcoord = LRZ0+z*LRFACTOR;
	int j = x+y*pitch+z*YLRDIM*pitch;//index on padded mem (pitch in elements)
	float f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18;
	int im = ImageFcn(xcoord,ycoord,zcoord);
	if(x < 1 || x > XLRDIM-2 || y < 1 || y > YLRDIM-2 || z < 1 || z > ZLRDIM-2)
	{
	//dont do anything
	}
	else{
	f0 = fin[j];
	f2 = fin[f_memLR(2 ,x  ,y-1,z  ,pitch)];
	f4 = fin[f_memLR(4 ,x  ,y+1,z  ,pitch)];
	f9 = fin[f_memLR(9 ,x  ,y  ,z-1,pitch)];
	f11= fin[f_memLR(11,x  ,y-1,z-1,pitch)];
	f13= fin[f_memLR(13,x  ,y+1,z-1,pitch)];
	f14= fin[f_memLR(14,x  ,y  ,z+1,pitch)];
	f16= fin[f_memLR(16,x  ,y-1,z+1,pitch)];
	if(z != ZDIM-1){
	f18= fin[f_memLR(18,x  ,y+1,z+1,pitch)];
	}
	f1 = tex2D(texRef_f1C ,x-1+0.5f,y  +0.5f+YDIM*(z));
	f3 = tex2D(texRef_f3C ,x+1+0.5f,y  +0.5f+YDIM*(z));
	f5 = tex2D(texRef_f5C ,x-1+0.5f,y-1+0.5f+YDIM*(z));
	f6 = tex2D(texRef_f6C ,x+1+0.5f,y-1+0.5f+YDIM*(z));
	f7 = tex2D(texRef_f7C ,x+1+0.5f,y+1+0.5f+YDIM*(z));
	f8 = tex2D(texRef_f8C ,x-1+0.5f,y+1+0.5f+YDIM*(z));
	f15= tex2D(texRef_f15C,x-1+0.5f,y  +0.5f+YDIM*(z+1));
	f17= tex2D(texRef_f17C,x+1+0.5f,y  +0.5f+YDIM*(z+1));
	f10= tex2D(texRef_f10C,x-1+0.5f,y  +0.5f+YDIM*(z-1));
	f12= tex2D(texRef_f12C,x+1+0.5f,y  +0.5f+YDIM*(z-1));

	if(im == 1){//BB
		fout[f_memLR(1 ,x,y,z,pitch)] = f3 ;
		fout[f_memLR(2 ,x,y,z,pitch)] = f4 ;
		fout[f_memLR(3 ,x,y,z,pitch)] = f1 ;
		fout[f_memLR(4 ,x,y,z,pitch)] = f2 ;
		fout[f_memLR(5 ,x,y,z,pitch)] = f7 ;
		fout[f_memLR(6 ,x,y,z,pitch)] = f8 ;
		fout[f_memLR(7 ,x,y,z,pitch)] = f5 ;
		fout[f_memLR(8 ,x,y,z,pitch)] = f6 ;
		fout[f_memLR(9 ,x,y,z,pitch)] = f14;
		fout[f_memLR(10,x,y,z,pitch)] = f17;
		fout[f_memLR(11,x,y,z,pitch)] = f18;
		fout[f_memLR(12,x,y,z,pitch)] = f15;
		fout[f_memLR(13,x,y,z,pitch)] = f16;
		fout[f_memLR(14,x,y,z,pitch)] = f9 ;
		fout[f_memLR(15,x,y,z,pitch)] = f12;
		fout[f_memLR(16,x,y,z,pitch)] = f13;
		fout[f_memLR(17,x,y,z,pitch)] = f10;
		fout[f_memLR(18,x,y,z,pitch)] = f11;
	}
	else{
		if(MODEL == "MRT")
		mrt_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,omega);
		else if(MODEL == "BGK")
		bgk_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,omega);

		fout[f_memLR(0 ,x,y,z,pitch)] = f0 ;
		fout[f_memLR(1 ,x,y,z,pitch)] = f1 ;
		fout[f_memLR(2 ,x,y,z,pitch)] = f2 ;
		fout[f_memLR(3 ,x,y,z,pitch)] = f3 ;
		fout[f_memLR(4 ,x,y,z,pitch)] = f4 ;
		fout[f_memLR(5 ,x,y,z,pitch)] = f5 ;
		fout[f_memLR(6 ,x,y,z,pitch)] = f6 ;
		fout[f_memLR(7 ,x,y,z,pitch)] = f7 ;
		fout[f_memLR(8 ,x,y,z,pitch)] = f8 ;
		fout[f_memLR(9 ,x,y,z,pitch)] = f9 ;
		fout[f_memLR(10,x,y,z,pitch)] = f10;
		fout[f_memLR(11,x,y,z,pitch)] = f11;
		fout[f_memLR(12,x,y,z,pitch)] = f12;
		fout[f_memLR(13,x,y,z,pitch)] = f13;
		fout[f_memLR(14,x,y,z,pitch)] = f14;
		fout[f_memLR(15,x,y,z,pitch)] = f15;
		fout[f_memLR(16,x,y,z,pitch)] = f16;
		fout[f_memLR(17,x,y,z,pitch)] = f17;
		fout[f_memLR(18,x,y,z,pitch)] = f18;
	}
	}//end else (not at edge of LR)
}

__global__ void LR_d_hybABDC(float* fin, float* fout,
							float omega, size_t pitch, float SF)//pitch in elements
{
	int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
	int y = threadIdx.y+blockIdx.y*blockDim.y;
	int z = threadIdx.z+blockIdx.z*blockDim.z;
	float xcoord = LRX0+x*LRFACTOR;//+0.5f is because textures are stored in a voxel centered fashion. we need to change this to vertex centered.
	float ycoord = LRY0+y*LRFACTOR;
	float zcoord = LRZ0+z*LRFACTOR;//dont need to +0.5f because z is not using texture interpolation
	int zminus = int(zcoord);
	int zplus = zminus+1;
	int j = x+y*pitch+z*YLRDIM*pitch;//index on padded mem (pitch in elements)
	float f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18;
	int im = ImageFcn(xcoord,ycoord,zcoord);
	if(x < 2 || x > XLRDIM-3 || y < 2 || y > YLRDIM-3 || z < 2 || z > ZLRDIM-3)
	{
	//interpolate for next time step. from B //YDIM and not YLRDIM
	f0 = (zplus-zcoord)*tex2D(texRef_f0B ,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f0B ,xcoord+0.5f,ycoord+0.5f+YDIM*(zplus));
	f2 = (zplus-zcoord)*tex2D(texRef_f2B ,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f2B ,xcoord+0.5f,ycoord+0.5f+YDIM*(zplus));
	f4 = (zplus-zcoord)*tex2D(texRef_f4B ,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f4B ,xcoord+0.5f,ycoord+0.5f+YDIM*(zplus));
	f9 = (zplus-zcoord)*tex2D(texRef_f9B ,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f9B ,xcoord+0.5f,ycoord+0.5f+YDIM*(zplus));
	f11= (zplus-zcoord)*tex2D(texRef_f11B,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f11B,xcoord+0.5f,ycoord+0.5f+YDIM*(zplus));
	f13= (zplus-zcoord)*tex2D(texRef_f13B,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f13B,xcoord+0.5f,ycoord+0.5f+YDIM*(zplus));
	f14= (zplus-zcoord)*tex2D(texRef_f14B,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f14B,xcoord+0.5f,ycoord+0.5f+YDIM*(zplus));
	f16= (zplus-zcoord)*tex2D(texRef_f16B,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f16B,xcoord+0.5f,ycoord+0.5f+YDIM*(zplus));
	f18= (zplus-zcoord)*tex2D(texRef_f18B,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f18B,xcoord+0.5f,ycoord+0.5f+YDIM*(zplus));
	f1 = (zplus-zcoord)*tex2D(texRef_f1B ,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f1B ,xcoord+0.5f,ycoord+0.5f+YDIM*(zplus));
	f3 = (zplus-zcoord)*tex2D(texRef_f3B ,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f3B ,xcoord+0.5f,ycoord+0.5f+YDIM*(zplus));
	f5 = (zplus-zcoord)*tex2D(texRef_f5B ,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f5B ,xcoord+0.5f,ycoord+0.5f+YDIM*(zplus));
	f6 = (zplus-zcoord)*tex2D(texRef_f6B ,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f6B ,xcoord+0.5f,ycoord+0.5f+YDIM*(zplus));
	f7 = (zplus-zcoord)*tex2D(texRef_f7B ,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f7B ,xcoord+0.5f,ycoord+0.5f+YDIM*(zplus));
	f8 = (zplus-zcoord)*tex2D(texRef_f8B ,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f8B ,xcoord+0.5f,ycoord+0.5f+YDIM*(zplus));
	f15= (zplus-zcoord)*tex2D(texRef_f15B,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f15B,xcoord+0.5f,ycoord+0.5f+YDIM*(zplus));
	f17= (zplus-zcoord)*tex2D(texRef_f17B,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f17B,xcoord+0.5f,ycoord+0.5f+YDIM*(zplus));
	f10= (zplus-zcoord)*tex2D(texRef_f10B,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f10B,xcoord+0.5f,ycoord+0.5f+YDIM*(zplus));
	f12= (zplus-zcoord)*tex2D(texRef_f12B,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f12B,xcoord+0.5f,ycoord+0.5f+YDIM*(zplus));

	float rho,u,v,w;	
	rho = f0+f1+f2+f3+f4+f5+f6+f7+f8+f9+
	      f10+f11+f12+f13+f14+f15+f16+f17+f18;
	u = f1-f3+f5-f6-f7+f8+f10-f12+f15-f17;
	v = f2-f4+f5+f6-f7-f8+f11-f13+f16-f18;
	w = f9+f10+f11+f12+f13-f14-f15-f16-f17-f18;
	u = rho*u;
	v = rho*v;
	w = rho*w;
	float usqr = fma(u,u,fma(v,v,w*w));

	if(MODEL == "MRT")
	{
	float meq0 = rho;
	float meq1 = -11.f*rho+19.f*(u*u+v*v+w*w);
	float meq2 = -7.53968254f*(u*u+v*v+w*w);
	float meq3 = u;
	float meq4 = -0.66666667f*u;//qx_eq
	float meq5 = v;
	float meq6 = -0.66666667f*v;//qx_eq
	float meq7 = w;
	float meq8 = -0.66666667f*w;//qx_eq
	float meq9 = (2.f*u*u-(v*v+w*w));//(2.f*.f*.f-(u1*u1+u2*u2));///3.f;//pxx_eq
	float meq11= (v*v-w*w);//pww_eq
	float meq13= u*v;//pxy_eq
	float meq14= v*w;//pyz_eq
	float meq15= u*w;//pxz_eq

//float feq0 = 0.052631579f*meq0+  -0.012531328f*meq1+  0.047619048f*meq2                                                                      ;
//float feq1 = 0.052631579f*meq0+ -0.0045948204f*meq1+ -0.015873016f*meq2+  (0.166666667f*u)                                                   ;
//float feq2 = 0.052631579f*meq0+ -0.0045948204f*meq1+ -0.015873016f*meq2                       +  (0.166666667f*v)                       ;
//float feq3 = 0.052631579f*meq0+ -0.0045948204f*meq1+ -0.015873016f*meq2+ -(0.166666667f*u)                                                   ;
//float feq4 = 0.052631579f*meq0+ -0.0045948204f*meq1+ -0.015873016f*meq2                            + -(0.166666667f*v)                       ;
//float feq5 = 0.052631579f*meq0+  0.0033416876f*meq1+  0.003968254f*meq2+  0.1f*(meq3+meq5)+  0.025f*(meq4+meq6)                            ;
//float feq6 = 0.052631579f*meq0+  0.0033416876f*meq1+  0.003968254f*meq2+ -0.1f*(meq3-meq5)+ -0.025f*(meq4-meq6)                            ;
//float feq7 = 0.052631579f*meq0+  0.0033416876f*meq1+  0.003968254f*meq2+ -0.1f*(meq3+meq5)+ -0.025f*(meq4+meq6)                            ;
//float feq8 = 0.052631579f*meq0+  0.0033416876f*meq1+  0.003968254f*meq2+  0.1f*(meq3-meq5)+  0.025f*(meq4-meq6)                            ;
//float feq9 = 0.052631579f*meq0+ -0.0045948204f*meq1+ -0.015873016f*meq2                                                      +  (0.166666667f*w);
//float feq10= 0.052631579f*meq0+  0.0033416876f*meq1+  0.003968254f*meq2+  0.1f*(meq3+meq7)+  0.025f*(meq4+meq8)                                 ;
//float feq11= 0.052631579f*meq0+  0.0033416876f*meq1+  0.003968254f*meq2                            +  0.1f*(meq5+meq7)+  0.025f*(meq6+meq8);
//float feq12= 0.052631579f*meq0+  0.0033416876f*meq1+  0.003968254f*meq2+ -0.1f*(meq3-meq7)+ -0.025f*(meq4-meq8)                            ;
//float feq13= 0.052631579f*meq0+  0.0033416876f*meq1+  0.003968254f*meq2                            + -0.1f*(meq5-meq7)+ -0.025f*(meq6-meq8);
//float feq14= 0.052631579f*meq0+ -0.0045948204f*meq1+ -0.015873016f*meq2                                                      + -(0.166666667f*w);
//float feq15= 0.052631579f*meq0+  0.0033416876f*meq1+  0.003968254f*meq2+  0.1f*(meq3-meq7)+  0.025f*(meq4-meq8)                            ;
//float feq16= 0.052631579f*meq0+  0.0033416876f*meq1+  0.003968254f*meq2                            +  0.1f*(meq5-meq7)+  0.025f*(meq6-meq8);
//float feq17= 0.052631579f*meq0+  0.0033416876f*meq1+  0.003968254f*meq2+ -0.1f*(meq3+meq7)+ -0.025f*(meq4+meq8)                            ;
//float feq18= 0.052631579f*meq0+  0.0033416876f*meq1+  0.003968254f*meq2+                           + -0.1f*(meq5+meq7)+ -0.025f*(meq6+meq8);

float feq0 = 0.052631579f*meq0+  -0.012531328f*meq1+  0.047619048f*meq2                                                                      ;
float feq1 = 0.052631579f*meq0+ -0.0045948204f*meq1+ -0.015873016f*meq2+  0.1f*(meq3-meq4)                                                   ;
float feq2 = 0.052631579f*meq0+ -0.0045948204f*meq1+ -0.015873016f*meq2                            +  0.1f*(meq5-meq6)                       ;
float feq3 = 0.052631579f*meq0+ -0.0045948204f*meq1+ -0.015873016f*meq2+ -0.1f*(meq3-meq4)                                                   ;
float feq4 = 0.052631579f*meq0+ -0.0045948204f*meq1+ -0.015873016f*meq2                            + -0.1f*(meq5-meq6)                       ;
float feq5 = 0.052631579f*meq0+  0.0033416876f*meq1+  0.003968254f*meq2+  0.1f*(meq3+meq5)+  0.025f*(meq4+meq6)                            ;
float feq6 = 0.052631579f*meq0+  0.0033416876f*meq1+  0.003968254f*meq2+ -0.1f*(meq3-meq5)+ -0.025f*(meq4-meq6)                            ;
float feq7 = 0.052631579f*meq0+  0.0033416876f*meq1+  0.003968254f*meq2+ -0.1f*(meq3+meq5)+ -0.025f*(meq4+meq6)                            ;
float feq8 = 0.052631579f*meq0+  0.0033416876f*meq1+  0.003968254f*meq2+  0.1f*(meq3-meq5)+  0.025f*(meq4-meq6)                            ;
float feq9 = 0.052631579f*meq0+ -0.0045948204f*meq1+ -0.015873016f*meq2                                                      +  0.1f*(meq7-meq8);
float feq10= 0.052631579f*meq0+  0.0033416876f*meq1+  0.003968254f*meq2+  0.1f*(meq3+meq7)+  0.025f*(meq4+meq8)                                 ;
float feq11= 0.052631579f*meq0+  0.0033416876f*meq1+  0.003968254f*meq2                            +  0.1f*(meq5+meq7)+  0.025f*(meq6+meq8);
float feq12= 0.052631579f*meq0+  0.0033416876f*meq1+  0.003968254f*meq2+ -0.1f*(meq3-meq7)+ -0.025f*(meq4-meq8)                            ;
float feq13= 0.052631579f*meq0+  0.0033416876f*meq1+  0.003968254f*meq2                            + -0.1f*(meq5-meq7)+ -0.025f*(meq6-meq8);
float feq14= 0.052631579f*meq0+ -0.0045948204f*meq1+ -0.015873016f*meq2                                                      + -0.1f*(meq7-meq8);
float feq15= 0.052631579f*meq0+  0.0033416876f*meq1+  0.003968254f*meq2+  0.1f*(meq3-meq7)+  0.025f*(meq4-meq8)                            ;
float feq16= 0.052631579f*meq0+  0.0033416876f*meq1+  0.003968254f*meq2                            +  0.1f*(meq5-meq7)+  0.025f*(meq6-meq8);
float feq17= 0.052631579f*meq0+  0.0033416876f*meq1+  0.003968254f*meq2+ -0.1f*(meq3+meq7)+ -0.025f*(meq4+meq8)                            ;
float feq18= 0.052631579f*meq0+  0.0033416876f*meq1+  0.003968254f*meq2+                           + -0.1f*(meq5+meq7)+ -0.025f*(meq6+meq8);

feq1 +=  0.055555556f*meq9;
feq2 += -0.027777778f*meq9+  0.083333333f*meq11;
feq3 +=  0.055555556f*meq9;
feq4 += -0.027777778f*meq9+  0.083333333f*meq11;
feq5 +=  0.027777778f*meq9+  0.083333333f*meq11+  0.25f*meq13                              ;
feq6 +=  0.027777778f*meq9+  0.083333333f*meq11+ -0.25f*meq13                              ;
feq7 +=  0.027777778f*meq9+  0.083333333f*meq11+  0.25f*meq13                              ;
feq8 +=  0.027777778f*meq9+  0.083333333f*meq11+ -0.25f*meq13                              ;
feq9 += -0.027777778f*meq9+ -0.083333333f*meq11                                            ;
feq10+=  0.027777778f*meq9+ -0.083333333f*meq11                              +  0.25f*meq15;
feq11+= -0.055555556f*meq9                                      +  0.25f*meq14             ;
feq12+=  0.027777778f*meq9+ -0.083333333f*meq11                              + -0.25f*meq15;
feq13+= -0.055555556f*meq9                                        -0.25f*meq14             ;
feq14+= -0.027777778f*meq9+ -0.083333333f*meq11                                            ;
feq15+=  0.027777778f*meq9+ -0.083333333f*meq11                              + -0.25f*meq15;
feq16+= -0.055555556f*meq9                                      + -0.25f*meq14             ;
feq17+=  0.027777778f*meq9+ -0.083333333f*meq11                              +  0.25f*meq15;
feq18+= -0.055555556f*meq9                                      +  0.25f*meq14             ;


f0 =SF*f0 +(1.0f-SF)*feq0 ;
f1 =SF*f1 +(1.0f-SF)*feq1 ;
f2 =SF*f2 +(1.0f-SF)*feq2 ;
f3 =SF*f3 +(1.0f-SF)*feq3 ;
f4 =SF*f4 +(1.0f-SF)*feq4 ;
f5 =SF*f5 +(1.0f-SF)*feq5 ;
f6 =SF*f6 +(1.0f-SF)*feq6 ;
f7 =SF*f7 +(1.0f-SF)*feq7 ;
f8 =SF*f8 +(1.0f-SF)*feq8 ;
f9 =SF*f9 +(1.0f-SF)*feq9 ;
f10=SF*f10+(1.0f-SF)*feq10;
f11=SF*f11+(1.0f-SF)*feq11;
f12=SF*f12+(1.0f-SF)*feq12;
f13=SF*f13+(1.0f-SF)*feq13;
f14=SF*f14+(1.0f-SF)*feq14;
f15=SF*f15+(1.0f-SF)*feq15;
f16=SF*f16+(1.0f-SF)*feq16;
f17=SF*f17+(1.0f-SF)*feq17;
f18=SF*f18+(1.0f-SF)*feq18;






//	float m2 = -7.53968254f*(u*u+v*v+w*w);
//	//scale
//	f0 =SF*f0 +(1.0f-SF)*(0.052631579f*rho+ -0.012531328f*(-11.f*rho+19.f*usqr)+ 0.047619048f*m2);
//	f1 =SF*f1 +(1.0f-SF)*(0.052631579f*rho+-0.0045948204f*(-11.f*rho+19.f*usqr)+-0.015873016f*m2 +( 0.1666666667f*u)                +0.055555556f*(2.f*u*u-(v*v+w*w))                          );
//	f2 =SF*f2 +(1.0f-SF)*(0.052631579f*rho+-0.0045948204f*(-11.f*rho+19.f*usqr)+-0.015873016f*m2 +( 0.1666666667f*v)                -0.027777778f*(2.f*u*u-(v*v+w*w))  +0.0833333333f*(v*v-w*w)            );
//	f3 =SF*f3 +(1.0f-SF)*(0.052631579f*rho+-0.0045948204f*(-11.f*rho+19.f*usqr)+-0.015873016f*m2 +(-0.1666666667f*u)                +0.055555556f*(2.f*u*u-(v*v+w*w))                          );
//	f4 =SF*f4 +(1.0f-SF)*(0.052631579f*rho+-0.0045948204f*(-11.f*rho+19.f*usqr)+-0.015873016f*m2 +(-0.1666666667f*v)                -0.027777778f*(2.f*u*u-(v*v+w*w))  +0.0833333333f*(v*v-w*w)            );
//	f5 =SF*f5 +(1.0f-SF)*(0.052631579f*rho+ 0.0033416876f*(-11.f*rho+19.f*usqr)+ 0.003968254f*m2 +0.1f*( u+v)+0.01666666667f*(-u-v) +0.027777778f*(2.f*u*u-(v*v+w*w))  +0.0833333333f*(v*v-w*w)+0.25f*(u*v)    );
//	f6 =SF*f6 +(1.0f-SF)*(0.052631579f*rho+ 0.0033416876f*(-11.f*rho+19.f*usqr)+ 0.003968254f*m2 +0.1f*(-u+v)+0.01666666667f*( u-v) +0.027777778f*(2.f*u*u-(v*v+w*w))  +0.0833333333f*(v*v-w*w)-0.25f*(u*v)    );
//	f7 =SF*f7 +(1.0f-SF)*(0.052631579f*rho+ 0.0033416876f*(-11.f*rho+19.f*usqr)+ 0.003968254f*m2 +0.1f*(-u-v)+0.01666666667f*( u+v) +0.027777778f*(2.f*u*u-(v*v+w*w))  +0.0833333333f*(v*v-w*w)+0.25f*(u*v)    );
//	f8 =SF*f8 +(1.0f-SF)*(0.052631579f*rho+ 0.0033416876f*(-11.f*rho+19.f*usqr)+ 0.003968254f*m2 +0.1f*( u-v)+0.01666666667f*(-u+v) +0.027777778f*(2.f*u*u-(v*v+w*w))  +0.0833333333f*(v*v-w*w)-0.25f*(u*v)    );
//	f9 =SF*f9 +(1.0f-SF)*(0.052631579f*rho+-0.0045948204f*(-11.f*rho+19.f*usqr)+-0.015873016f*m2 +( 0.1666666667f*w)                -0.027777778f*(2.f*u*u-(v*v+w*w))  -0.0833333333f*(v*v-w*w)            );
//	f10=SF*f10+(1.0f-SF)*(0.052631579f*rho+ 0.0033416876f*(-11.f*rho+19.f*usqr)+ 0.003968254f*m2 +0.1f*( u+w)+0.01666666667f*(-u-w) +0.027777778f*(2.f*u*u-(v*v+w*w))  -0.0833333333f*(v*v-w*w)      +0.25f*u*v);
//	f11=SF*f11+(1.0f-SF)*(0.052631579f*rho+ 0.0033416876f*(-11.f*rho+19.f*usqr)+ 0.003968254f*m2 +0.1f*( v+w)+0.01666666667f*(-v-w) -0.055555556f*(2.f*u*u-(v*v+w*w))                         +0.25f*v*w      );
//	f12=SF*f12+(1.0f-SF)*(0.052631579f*rho+ 0.0033416876f*(-11.f*rho+19.f*usqr)+ 0.003968254f*m2 +0.1f*(-u+w)+0.01666666667f*( u-w) +0.027777778f*(2.f*u*u-(v*v+w*w))  -0.0833333333f*(v*v-w*w)      -0.25f*u*v);
//	f13=SF*f13+(1.0f-SF)*(0.052631579f*rho+ 0.0033416876f*(-11.f*rho+19.f*usqr)+ 0.003968254f*m2 +0.1f*(-v+w)+0.01666666667f*(-v-w) -0.055555556f*(2.f*u*u-(v*v+w*w))                         -0.25f*v*w      );
//	f14=SF*f14+(1.0f-SF)*(0.052631579f*rho+-0.0045948204f*(-11.f*rho+19.f*usqr)+-0.015873016f*m2 +(-0.1666666667f*w)                +0.027777778f*(2.f*u*u-(v*v+w*w))  -0.0833333333f*(v*v-w*w)            );
//	f15=SF*f15+(1.0f-SF)*(0.052631579f*rho+ 0.0033416876f*(-11.f*rho+19.f*usqr)+ 0.003968254f*m2 +0.1f*( u-w)+0.01666666667f*(-u+w) +0.027777778f*(2.f*u*u-(v*v+w*w))  -0.0833333333f*(v*v-w*w)      +0.25f*u*v);
//	f16=SF*f16+(1.0f-SF)*(0.052631579f*rho+ 0.0033416876f*(-11.f*rho+19.f*usqr)+ 0.003968254f*m2 +0.1f*( v-w)+0.01666666667f*(-v+w) -0.055555556f*(2.f*u*u-(v*v+w*w))                         +0.25f*v*w      );
//	f17=SF*f17+(1.0f-SF)*(0.052631579f*rho+ 0.0033416876f*(-11.f*rho+19.f*usqr)+ 0.003968254f*m2 +0.1f*(-u-w)+0.01666666667f*( u+w) +0.027777778f*(2.f*u*u-(v*v+w*w))  -0.0833333333f*(v*v-w*w)      +0.25f*u*v);
//	f18=SF*f18+(1.0f-SF)*(0.052631579f*rho+ 0.0033416876f*(-11.f*rho+19.f*usqr)+ 0.003968254f*m2 +0.1f*(-v-w)+0.01666666667f*(-v+w) -0.055555556f*(2.f*u*u-(v*v+w*w))                         +0.25f*v*w      );
	}
	else
	{
	//scale
	f0 =SF*f0 +(1.0f-SF)*(0.3333333333f*(rho-1.5f*usqr));
	f1 =SF*f1 +(1.0f-SF)*(0.0555555556f*(rho+3.0f*u+4.5f*u*u-1.5f*usqr));                
	f2 =SF*f2 +(1.0f-SF)*(0.0555555556f*(rho+3.0f*v+4.5f*v*v-1.5f*usqr));
	f3 =SF*f3 +(1.0f-SF)*(0.0555555556f*(rho-3.0f*u+4.5f*u*u-1.5f*usqr));
	f4 =SF*f4 +(1.0f-SF)*(0.0555555556f*(rho-3.0f*v+4.5f*v*v-1.5f*usqr));
	f5 =SF*f5 +(1.0f-SF)*(0.0277777778f*(rho+3.0f*(u+v)+4.5f*(u+v)*(u+v)-1.5f*usqr));
	f6 =SF*f6 +(1.0f-SF)*(0.0277777778f*(rho+3.0f*(-u+v)+4.5f*(-u+v)*(-u+v)-1.5f*usqr));
	f7 =SF*f7 +(1.0f-SF)*(0.0277777778f*(rho+3.0f*(-u-v)+4.5f*(-u-v)*(-u-v)-1.5f*usqr));
	f8 =SF*f8 +(1.0f-SF)*(0.0277777778f*(rho+3.0f*(u-v)+4.5f*(u-v)*(u-v)-1.5f*usqr));
	f9 =SF*f9 +(1.0f-SF)*(0.0555555556f*(rho+3.0f*w+4.5f*w*w-1.5f*usqr));
	f10=SF*f10+(1.0f-SF)*(0.0277777778f*(rho+3.0f*(u+w)+4.5f*(u+w)*(u+w)-1.5f*usqr));
	f11=SF*f11+(1.0f-SF)*(0.0277777778f*(rho+3.0f*(v+w)+4.5f*(v+w)*(u+w)-1.5f*usqr));
	f12=SF*f12+(1.0f-SF)*(0.0277777778f*(rho+3.0f*(-u+w)+4.5f*(-u+w)*(-u+w)-1.5f*usqr));
	f13=SF*f13+(1.0f-SF)*(0.0277777778f*(rho+3.0f*(-v+w)+4.5f*(-v+w)*(u+w)-1.5f*usqr));
	f14=SF*f14+(1.0f-SF)*(0.0555555556f*(rho-3.0f*w+4.5f*w*w-1.5f*usqr));
	f15=SF*f15+(1.0f-SF)*(0.0277777778f*(rho+3.0f*(u-w)+4.5f*(u-w)*(u-w)-1.5f*usqr));
	f16=SF*f16+(1.0f-SF)*(0.0277777778f*(rho+3.0f*(v-w)+4.5f*(v-w)*(v-w)-1.5f*usqr));
	f17=SF*f17+(1.0f-SF)*(0.0277777778f*(rho+3.0f*(-u-w)+4.5f*(-u-w)*(-u-w)-1.5f*usqr));
	f18=SF*f18+(1.0f-SF)*(0.0277777778f*(rho+3.0f*(-v-w)+4.5f*(-v-w)*(-v-w)-1.5f*usqr));
	}

	fout[f_memLR(0 ,x,y,z,pitch)] = f0 ;
	fout[f_memLR(1 ,x,y,z,pitch)] = f1 ;
	fout[f_memLR(2 ,x,y,z,pitch)] = f2 ;
	fout[f_memLR(3 ,x,y,z,pitch)] = f3 ;
	fout[f_memLR(4 ,x,y,z,pitch)] = f4 ;
	fout[f_memLR(5 ,x,y,z,pitch)] = f5 ;
	fout[f_memLR(6 ,x,y,z,pitch)] = f6 ;
	fout[f_memLR(7 ,x,y,z,pitch)] = f7 ;
	fout[f_memLR(8 ,x,y,z,pitch)] = f8 ;
	fout[f_memLR(9 ,x,y,z,pitch)] = f9 ;
	fout[f_memLR(10,x,y,z,pitch)] = f10;
	fout[f_memLR(11,x,y,z,pitch)] = f11;
	fout[f_memLR(12,x,y,z,pitch)] = f12;
	fout[f_memLR(13,x,y,z,pitch)] = f13;
	fout[f_memLR(14,x,y,z,pitch)] = f14;
	fout[f_memLR(15,x,y,z,pitch)] = f15;
	fout[f_memLR(16,x,y,z,pitch)] = f16;
	fout[f_memLR(17,x,y,z,pitch)] = f17;
	fout[f_memLR(18,x,y,z,pitch)] = f18;
	}
	else{
	f0 = fin[j];
	f2 = fin[f_memLR(2 ,x  ,y-1,z  ,pitch)];
	f4 = fin[f_memLR(4 ,x  ,y+1,z  ,pitch)];
	f9 = fin[f_memLR(9 ,x  ,y  ,z-1,pitch)];
	f11= fin[f_memLR(11,x  ,y-1,z-1,pitch)];
	f13= fin[f_memLR(13,x  ,y+1,z-1,pitch)];
	f14= fin[f_memLR(14,x  ,y  ,z+1,pitch)];
	f16= fin[f_memLR(16,x  ,y-1,z+1,pitch)];
	if(z != ZDIM-1){
	f18= fin[f_memLR(18,x  ,y+1,z+1,pitch)];
	}
	f1 = tex2D(texRef_f1D ,x-1+0.5f,y  +0.5f+YDIM*(z));
	f3 = tex2D(texRef_f3D ,x+1+0.5f,y  +0.5f+YDIM*(z));
	f5 = tex2D(texRef_f5D ,x-1+0.5f,y-1+0.5f+YDIM*(z));
	f6 = tex2D(texRef_f6D ,x+1+0.5f,y-1+0.5f+YDIM*(z));
	f7 = tex2D(texRef_f7D ,x+1+0.5f,y+1+0.5f+YDIM*(z));
	f8 = tex2D(texRef_f8D ,x-1+0.5f,y+1+0.5f+YDIM*(z));
	f15= tex2D(texRef_f15D,x-1+0.5f,y  +0.5f+YDIM*(z+1));
	f17= tex2D(texRef_f17D,x+1+0.5f,y  +0.5f+YDIM*(z+1));
	f10= tex2D(texRef_f10D,x-1+0.5f,y  +0.5f+YDIM*(z-1));
	f12= tex2D(texRef_f12D,x+1+0.5f,y  +0.5f+YDIM*(z-1));

	//else f18 = 0.1f;
	if(im == 1){//BB
		fout[f_memLR(1 ,x,y,z,pitch)] = f3 ;
		fout[f_memLR(2 ,x,y,z,pitch)] = f4 ;
		fout[f_memLR(3 ,x,y,z,pitch)] = f1 ;
		fout[f_memLR(4 ,x,y,z,pitch)] = f2 ;
		fout[f_memLR(5 ,x,y,z,pitch)] = f7 ;
		fout[f_memLR(6 ,x,y,z,pitch)] = f8 ;
		fout[f_memLR(7 ,x,y,z,pitch)] = f5 ;
		fout[f_memLR(8 ,x,y,z,pitch)] = f6 ;
		fout[f_memLR(9 ,x,y,z,pitch)] = f14;
		fout[f_memLR(10,x,y,z,pitch)] = f17;
		fout[f_memLR(11,x,y,z,pitch)] = f18;
		fout[f_memLR(12,x,y,z,pitch)] = f15;
		fout[f_memLR(13,x,y,z,pitch)] = f16;
		fout[f_memLR(14,x,y,z,pitch)] = f9 ;
		fout[f_memLR(15,x,y,z,pitch)] = f12;
		fout[f_memLR(16,x,y,z,pitch)] = f13;
		fout[f_memLR(17,x,y,z,pitch)] = f10;
		fout[f_memLR(18,x,y,z,pitch)] = f11;
	}
	else{
		if(MODEL == "MRT")
		mrt_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,omega);
		else if(MODEL == "BGK")
		bgk_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,omega);

		fout[f_memLR(0 ,x,y,z,pitch)] = f0 ;
		fout[f_memLR(1 ,x,y,z,pitch)] = f1 ;
		fout[f_memLR(2 ,x,y,z,pitch)] = f2 ;
		fout[f_memLR(3 ,x,y,z,pitch)] = f3 ;
		fout[f_memLR(4 ,x,y,z,pitch)] = f4 ;
		fout[f_memLR(5 ,x,y,z,pitch)] = f5 ;
		fout[f_memLR(6 ,x,y,z,pitch)] = f6 ;
		fout[f_memLR(7 ,x,y,z,pitch)] = f7 ;
		fout[f_memLR(8 ,x,y,z,pitch)] = f8 ;
		fout[f_memLR(9 ,x,y,z,pitch)] = f9 ;
		fout[f_memLR(10,x,y,z,pitch)] = f10;
		fout[f_memLR(11,x,y,z,pitch)] = f11;
		fout[f_memLR(12,x,y,z,pitch)] = f12;
		fout[f_memLR(13,x,y,z,pitch)] = f13;
		fout[f_memLR(14,x,y,z,pitch)] = f14;
		fout[f_memLR(15,x,y,z,pitch)] = f15;
		fout[f_memLR(16,x,y,z,pitch)] = f16;
		fout[f_memLR(17,x,y,z,pitch)] = f17;
		fout[f_memLR(18,x,y,z,pitch)] = f18;
	}
	}//end else (not at edge of LR)
}
__global__ void LR_d_hybBADC(float* fin, float* fout,
							float omega, size_t pitch, float SF)//pitch in elements
{
	int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
	int y = threadIdx.y+blockIdx.y*blockDim.y;
	int z = threadIdx.z+blockIdx.z*blockDim.z;
	float xcoord = LRX0+x*LRFACTOR;//+0.5f is because textures are stored in a voxel centered fashion. we need to change this to vertex centered.
	float ycoord = LRY0+y*LRFACTOR;
	float zcoord = LRZ0+z*LRFACTOR;//dont need to +0.5f because z is not using texture interpolation
	int zminus = int(zcoord);
	int zplus = zminus+1;
	int j = x+y*pitch+z*YLRDIM*pitch;//index on padded mem (pitch in elements)
	float f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18;
	int im = ImageFcn(xcoord,ycoord,zcoord);
	if(x < 2 || x > XLRDIM-3 || y < 2 || y > YLRDIM-3 || z < 2 || z > ZLRDIM-3)
	{
	//interpolate for next time step. from B
	f0 = (zplus-zcoord)*tex2D(texRef_f0A ,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f0A ,xcoord+0.5f,ycoord+0.5f+YDIM*(zplus));
	f2 = (zplus-zcoord)*tex2D(texRef_f2A ,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f2A ,xcoord+0.5f,ycoord+0.5f+YDIM*(zplus));
	f4 = (zplus-zcoord)*tex2D(texRef_f4A ,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f4A ,xcoord+0.5f,ycoord+0.5f+YDIM*(zplus));
	f9 = (zplus-zcoord)*tex2D(texRef_f9A ,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f9A ,xcoord+0.5f,ycoord+0.5f+YDIM*(zplus));
	f11= (zplus-zcoord)*tex2D(texRef_f11A,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f11A,xcoord+0.5f,ycoord+0.5f+YDIM*(zplus));
	f13= (zplus-zcoord)*tex2D(texRef_f13A,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f13A,xcoord+0.5f,ycoord+0.5f+YDIM*(zplus));
	f14= (zplus-zcoord)*tex2D(texRef_f14A,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f14A,xcoord+0.5f,ycoord+0.5f+YDIM*(zplus));
	f16= (zplus-zcoord)*tex2D(texRef_f16A,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f16A,xcoord+0.5f,ycoord+0.5f+YDIM*(zplus));
	f18= (zplus-zcoord)*tex2D(texRef_f18A,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f18A,xcoord+0.5f,ycoord+0.5f+YDIM*(zplus));
	f1 = (zplus-zcoord)*tex2D(texRef_f1A ,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f1A ,xcoord+0.5f,ycoord+0.5f+YDIM*(zplus));
	f3 = (zplus-zcoord)*tex2D(texRef_f3A ,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f3A ,xcoord+0.5f,ycoord+0.5f+YDIM*(zplus));
	f5 = (zplus-zcoord)*tex2D(texRef_f5A ,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f5A ,xcoord+0.5f,ycoord+0.5f+YDIM*(zplus));
	f6 = (zplus-zcoord)*tex2D(texRef_f6A ,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f6A ,xcoord+0.5f,ycoord+0.5f+YDIM*(zplus));
	f7 = (zplus-zcoord)*tex2D(texRef_f7A ,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f7A ,xcoord+0.5f,ycoord+0.5f+YDIM*(zplus));
	f8 = (zplus-zcoord)*tex2D(texRef_f8A ,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f8A ,xcoord+0.5f,ycoord+0.5f+YDIM*(zplus));
	f15= (zplus-zcoord)*tex2D(texRef_f15A,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f15A,xcoord+0.5f,ycoord+0.5f+YDIM*(zplus));
	f17= (zplus-zcoord)*tex2D(texRef_f17A,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f17A,xcoord+0.5f,ycoord+0.5f+YDIM*(zplus));
	f10= (zplus-zcoord)*tex2D(texRef_f10A,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f10A,xcoord+0.5f,ycoord+0.5f+YDIM*(zplus));
	f12= (zplus-zcoord)*tex2D(texRef_f12A,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f12A,xcoord+0.5f,ycoord+0.5f+YDIM*(zplus));

	float rho,u,v,w;	
	rho = f0+f1+f2+f3+f4+f5+f6+f7+f8+f9+
	      f10+f11+f12+f13+f14+f15+f16+f17+f18;
	u = f1-f3+f5-f6-f7+f8+f10-f12+f15-f17;
	v = f2-f4+f5+f6-f7-f8+f11-f13+f16-f18;
	w = f9+f10+f11+f12+f13-f14-f15-f16-f17-f18;
	u = rho*u;
	v = rho*v;
	w = rho*w;
	float usqr = fma(u,u,fma(v,v,w*w));

	if(MODEL == "MRT")
	{
	float meq0 = rho;
	float meq1 = -11.f*rho+19.f*(u*u+v*v+w*w);
	float meq2 = -7.53968254f*(u*u+v*v+w*w);
	float meq3 = u;
	float meq4 = -0.66666667f*u;//qx_eq
	float meq5 = v;
	float meq6 = -0.66666667f*v;//qx_eq
	float meq7 = w;
	float meq8 = -0.66666667f*w;//qx_eq
	float meq9 = (2.f*u*u-(v*v+w*w));//(2.f*.f*.f-(u1*u1+u2*u2));///3.f;//pxx_eq
	float meq11= (v*v-w*w);//pww_eq
	float meq13= u*v;//pxy_eq
	float meq14= v*w;//pyz_eq
	float meq15= u*w;//pxz_eq

//float feq0 = 0.052631579f*meq0+  -0.012531328f*meq1+  0.047619048f*meq2                                                                      ;
//float feq1 = 0.052631579f*meq0+ -0.0045948204f*meq1+ -0.015873016f*meq2+  (0.166666667f*u)                                                   ;
//float feq2 = 0.052631579f*meq0+ -0.0045948204f*meq1+ -0.015873016f*meq2                       +  (0.166666667f*v)                       ;
//float feq3 = 0.052631579f*meq0+ -0.0045948204f*meq1+ -0.015873016f*meq2+ -(0.166666667f*u)                                                   ;
//float feq4 = 0.052631579f*meq0+ -0.0045948204f*meq1+ -0.015873016f*meq2                            + -(0.166666667f*v)                       ;
//float feq5 = 0.052631579f*meq0+  0.0033416876f*meq1+  0.003968254f*meq2+  0.1f*(meq3+meq5)+  0.025f*(meq4+meq6)                            ;
//float feq6 = 0.052631579f*meq0+  0.0033416876f*meq1+  0.003968254f*meq2+ -0.1f*(meq3-meq5)+ -0.025f*(meq4-meq6)                            ;
//float feq7 = 0.052631579f*meq0+  0.0033416876f*meq1+  0.003968254f*meq2+ -0.1f*(meq3+meq5)+ -0.025f*(meq4+meq6)                            ;
//float feq8 = 0.052631579f*meq0+  0.0033416876f*meq1+  0.003968254f*meq2+  0.1f*(meq3-meq5)+  0.025f*(meq4-meq6)                            ;
//float feq9 = 0.052631579f*meq0+ -0.0045948204f*meq1+ -0.015873016f*meq2                                                      +  (0.166666667f*w);
//float feq10= 0.052631579f*meq0+  0.0033416876f*meq1+  0.003968254f*meq2+  0.1f*(meq3+meq7)+  0.025f*(meq4+meq8)                                 ;
//float feq11= 0.052631579f*meq0+  0.0033416876f*meq1+  0.003968254f*meq2                            +  0.1f*(meq5+meq7)+  0.025f*(meq6+meq8);
//float feq12= 0.052631579f*meq0+  0.0033416876f*meq1+  0.003968254f*meq2+ -0.1f*(meq3-meq7)+ -0.025f*(meq4-meq8)                            ;
//float feq13= 0.052631579f*meq0+  0.0033416876f*meq1+  0.003968254f*meq2                            + -0.1f*(meq5-meq7)+ -0.025f*(meq6-meq8);
//float feq14= 0.052631579f*meq0+ -0.0045948204f*meq1+ -0.015873016f*meq2                                                      + -(0.166666667f*w);
//float feq15= 0.052631579f*meq0+  0.0033416876f*meq1+  0.003968254f*meq2+  0.1f*(meq3-meq7)+  0.025f*(meq4-meq8)                            ;
//float feq16= 0.052631579f*meq0+  0.0033416876f*meq1+  0.003968254f*meq2                            +  0.1f*(meq5-meq7)+  0.025f*(meq6-meq8);
//float feq17= 0.052631579f*meq0+  0.0033416876f*meq1+  0.003968254f*meq2+ -0.1f*(meq3+meq7)+ -0.025f*(meq4+meq8)                            ;
//float feq18= 0.052631579f*meq0+  0.0033416876f*meq1+  0.003968254f*meq2+                           + -0.1f*(meq5+meq7)+ -0.025f*(meq6+meq8);

float feq0 = 0.052631579f*meq0+  -0.012531328f*meq1+  0.047619048f*meq2                                                                                    ;
float feq1 = 0.052631579f*meq0+ -0.0045948204f*meq1+ -0.015873016f*meq2+  0.1f*(meq3-meq4)                                                           ;
float feq2 = 0.052631579f*meq0+ -0.0045948204f*meq1+ -0.015873016f*meq2                            +  0.1f*(meq5-meq6)                            ;
float feq3 = 0.052631579f*meq0+ -0.0045948204f*meq1+ -0.015873016f*meq2+ -0.1f*(meq3-meq4)                                                        ;
float feq4 = 0.052631579f*meq0+ -0.0045948204f*meq1+ -0.015873016f*meq2                            + -0.1f*(meq5-meq6)                            ;
float feq5 = 0.052631579f*meq0+  0.0033416876f*meq1+  0.003968254f*meq2+  0.1f*(meq3+meq5)+  0.025f*(meq4+meq6)                            ;
float feq6 = 0.052631579f*meq0+  0.0033416876f*meq1+  0.003968254f*meq2+ -0.1f*(meq3-meq5)+ -0.025f*(meq4-meq6)                            ;
float feq7 = 0.052631579f*meq0+  0.0033416876f*meq1+  0.003968254f*meq2+ -0.1f*(meq3+meq5)+ -0.025f*(meq4+meq6)                            ;
float feq8 = 0.052631579f*meq0+  0.0033416876f*meq1+  0.003968254f*meq2+  0.1f*(meq3-meq5)+  0.025f*(meq4-meq6)                            ;
float feq9 = 0.052631579f*meq0+ -0.0045948204f*meq1+ -0.015873016f*meq2                                                      +  0.1f*meq7+   -0.1f*meq8;
float feq10= 0.052631579f*meq0+  0.0033416876f*meq1+  0.003968254f*meq2+  0.1f*meq3+  0.025f*meq4                            +  0.1f*meq7+  0.025f*meq8;
float feq11= 0.052631579f*meq0+  0.0033416876f*meq1+  0.003968254f*meq2                            +  0.1f*meq5+  0.025f*meq6+  0.1f*meq7+  0.025f*meq8;
float feq12= 0.052631579f*meq0+  0.0033416876f*meq1+  0.003968254f*meq2+ -0.1f*meq3+ -0.025f*meq4                            +  0.1f*meq7+  0.025f*meq8;
float feq13= 0.052631579f*meq0+  0.0033416876f*meq1+  0.003968254f*meq2                            + -0.1f*meq5+ -0.025f*meq6+  0.1f*meq7+  0.025f*meq8;
float feq14= 0.052631579f*meq0+ -0.0045948204f*meq1+ -0.015873016f*meq2                                                      + -0.1f*meq7+    0.1f*meq8;
float feq15= 0.052631579f*meq0+  0.0033416876f*meq1+  0.003968254f*meq2+  0.1f*meq3+  0.025f*meq4                            + -0.1f*meq7+ -0.025f*meq8;
float feq16= 0.052631579f*meq0+  0.0033416876f*meq1+  0.003968254f*meq2                            +  0.1f*meq5+  0.025f*meq6+ -0.1f*meq7+ -0.025f*meq8;
float feq17= 0.052631579f*meq0+  0.0033416876f*meq1+  0.003968254f*meq2+ -0.1f*meq3+ -0.025f*meq4                            + -0.1f*meq7+ -0.025f*meq8;
float feq18= 0.052631579f*meq0+  0.0033416876f*meq1+  0.003968254f*meq2+                           + -0.1f*meq5+ -0.025f*meq6+ -0.1f*meq7+ -0.025f*meq8;

feq1 +=  0.055555556f*meq9;
feq2 += -0.027777778f*meq9+  0.083333333f*meq11;
feq3 +=  0.055555556f*meq9;
feq4 += -0.027777778f*meq9+  0.083333333f*meq11;
feq5 +=  0.027777778f*meq9+  0.083333333f*meq11+  0.25f*meq13                              ;
feq6 +=  0.027777778f*meq9+  0.083333333f*meq11+ -0.25f*meq13                              ;
feq7 +=  0.027777778f*meq9+  0.083333333f*meq11+  0.25f*meq13                              ;
feq8 +=  0.027777778f*meq9+  0.083333333f*meq11+ -0.25f*meq13                              ;
feq9 += -0.027777778f*meq9+ -0.083333333f*meq11                                            ;
feq10+=  0.027777778f*meq9+ -0.083333333f*meq11                              +  0.25f*meq15;
feq11+= -0.055555556f*meq9                                      +  0.25f*meq14             ;
feq12+=  0.027777778f*meq9+ -0.083333333f*meq11                              + -0.25f*meq15;
feq13+= -0.055555556f*meq9                                        -0.25f*meq14             ;
feq14+= -0.027777778f*meq9+ -0.083333333f*meq11                                            ;
feq15+=  0.027777778f*meq9+ -0.083333333f*meq11                              + -0.25f*meq15;
feq16+= -0.055555556f*meq9                                      + -0.25f*meq14             ;
feq17+=  0.027777778f*meq9+ -0.083333333f*meq11                              +  0.25f*meq15;
feq18+= -0.055555556f*meq9                                      +  0.25f*meq14             ;


f0 =SF*f0 +(1.0f-SF)*feq0 ;
f1 =SF*f1 +(1.0f-SF)*feq1 ;
f2 =SF*f2 +(1.0f-SF)*feq2 ;
f3 =SF*f3 +(1.0f-SF)*feq3 ;
f4 =SF*f4 +(1.0f-SF)*feq4 ;
f5 =SF*f5 +(1.0f-SF)*feq5 ;
f6 =SF*f6 +(1.0f-SF)*feq6 ;
f7 =SF*f7 +(1.0f-SF)*feq7 ;
f8 =SF*f8 +(1.0f-SF)*feq8 ;
f9 =SF*f9 +(1.0f-SF)*feq9 ;
f10=SF*f10+(1.0f-SF)*feq10;
f11=SF*f11+(1.0f-SF)*feq11;
f12=SF*f12+(1.0f-SF)*feq12;
f13=SF*f13+(1.0f-SF)*feq13;
f14=SF*f14+(1.0f-SF)*feq14;
f15=SF*f15+(1.0f-SF)*feq15;
f16=SF*f16+(1.0f-SF)*feq16;
f17=SF*f17+(1.0f-SF)*feq17;
f18=SF*f18+(1.0f-SF)*feq18;






//	float m2 = -7.53968254f*(u*u+v*v+w*w);
//	//scale
//	f0 =SF*f0 +(1.0f-SF)*(0.052631579f*rho+ -0.012531328f*(-11.f*rho+19.f*usqr)+ 0.047619048f*m2);
//	f1 =SF*f1 +(1.0f-SF)*(0.052631579f*rho+-0.0045948204f*(-11.f*rho+19.f*usqr)+-0.015873016f*m2 +( 0.1666666667f*u)                +0.055555556f*(2.f*u*u-(v*v+w*w))                          );
//	f2 =SF*f2 +(1.0f-SF)*(0.052631579f*rho+-0.0045948204f*(-11.f*rho+19.f*usqr)+-0.015873016f*m2 +( 0.1666666667f*v)                -0.027777778f*(2.f*u*u-(v*v+w*w))  +0.0833333333f*(v*v-w*w)            );
//	f3 =SF*f3 +(1.0f-SF)*(0.052631579f*rho+-0.0045948204f*(-11.f*rho+19.f*usqr)+-0.015873016f*m2 +(-0.1666666667f*u)                +0.055555556f*(2.f*u*u-(v*v+w*w))                          );
//	f4 =SF*f4 +(1.0f-SF)*(0.052631579f*rho+-0.0045948204f*(-11.f*rho+19.f*usqr)+-0.015873016f*m2 +(-0.1666666667f*v)                -0.027777778f*(2.f*u*u-(v*v+w*w))  +0.0833333333f*(v*v-w*w)            );
//	f5 =SF*f5 +(1.0f-SF)*(0.052631579f*rho+ 0.0033416876f*(-11.f*rho+19.f*usqr)+ 0.003968254f*m2 +0.1f*( u+v)+0.01666666667f*(-u-v) +0.027777778f*(2.f*u*u-(v*v+w*w))  +0.0833333333f*(v*v-w*w)+0.25f*(u*v)    );
//	f6 =SF*f6 +(1.0f-SF)*(0.052631579f*rho+ 0.0033416876f*(-11.f*rho+19.f*usqr)+ 0.003968254f*m2 +0.1f*(-u+v)+0.01666666667f*( u-v) +0.027777778f*(2.f*u*u-(v*v+w*w))  +0.0833333333f*(v*v-w*w)-0.25f*(u*v)    );
//	f7 =SF*f7 +(1.0f-SF)*(0.052631579f*rho+ 0.0033416876f*(-11.f*rho+19.f*usqr)+ 0.003968254f*m2 +0.1f*(-u-v)+0.01666666667f*( u+v) +0.027777778f*(2.f*u*u-(v*v+w*w))  +0.0833333333f*(v*v-w*w)+0.25f*(u*v)    );
//	f8 =SF*f8 +(1.0f-SF)*(0.052631579f*rho+ 0.0033416876f*(-11.f*rho+19.f*usqr)+ 0.003968254f*m2 +0.1f*( u-v)+0.01666666667f*(-u+v) +0.027777778f*(2.f*u*u-(v*v+w*w))  +0.0833333333f*(v*v-w*w)-0.25f*(u*v)    );
//	f9 =SF*f9 +(1.0f-SF)*(0.052631579f*rho+-0.0045948204f*(-11.f*rho+19.f*usqr)+-0.015873016f*m2 +( 0.1666666667f*w)                -0.027777778f*(2.f*u*u-(v*v+w*w))  -0.0833333333f*(v*v-w*w)            );
//	f10=SF*f10+(1.0f-SF)*(0.052631579f*rho+ 0.0033416876f*(-11.f*rho+19.f*usqr)+ 0.003968254f*m2 +0.1f*( u+w)+0.01666666667f*(-u-w) +0.027777778f*(2.f*u*u-(v*v+w*w))  -0.0833333333f*(v*v-w*w)      +0.25f*u*v);
//	f11=SF*f11+(1.0f-SF)*(0.052631579f*rho+ 0.0033416876f*(-11.f*rho+19.f*usqr)+ 0.003968254f*m2 +0.1f*( v+w)+0.01666666667f*(-v-w) -0.055555556f*(2.f*u*u-(v*v+w*w))                         +0.25f*v*w      );
//	f12=SF*f12+(1.0f-SF)*(0.052631579f*rho+ 0.0033416876f*(-11.f*rho+19.f*usqr)+ 0.003968254f*m2 +0.1f*(-u+w)+0.01666666667f*( u-w) +0.027777778f*(2.f*u*u-(v*v+w*w))  -0.0833333333f*(v*v-w*w)      -0.25f*u*v);
//	f13=SF*f13+(1.0f-SF)*(0.052631579f*rho+ 0.0033416876f*(-11.f*rho+19.f*usqr)+ 0.003968254f*m2 +0.1f*(-v+w)+0.01666666667f*(-v-w) -0.055555556f*(2.f*u*u-(v*v+w*w))                         -0.25f*v*w      );
//	f14=SF*f14+(1.0f-SF)*(0.052631579f*rho+-0.0045948204f*(-11.f*rho+19.f*usqr)+-0.015873016f*m2 +(-0.1666666667f*w)                +0.027777778f*(2.f*u*u-(v*v+w*w))  -0.0833333333f*(v*v-w*w)            );
//	f15=SF*f15+(1.0f-SF)*(0.052631579f*rho+ 0.0033416876f*(-11.f*rho+19.f*usqr)+ 0.003968254f*m2 +0.1f*( u-w)+0.01666666667f*(-u+w) +0.027777778f*(2.f*u*u-(v*v+w*w))  -0.0833333333f*(v*v-w*w)      +0.25f*u*v);
//	f16=SF*f16+(1.0f-SF)*(0.052631579f*rho+ 0.0033416876f*(-11.f*rho+19.f*usqr)+ 0.003968254f*m2 +0.1f*( v-w)+0.01666666667f*(-v+w) -0.055555556f*(2.f*u*u-(v*v+w*w))                         +0.25f*v*w      );
//	f17=SF*f17+(1.0f-SF)*(0.052631579f*rho+ 0.0033416876f*(-11.f*rho+19.f*usqr)+ 0.003968254f*m2 +0.1f*(-u-w)+0.01666666667f*( u+w) +0.027777778f*(2.f*u*u-(v*v+w*w))  -0.0833333333f*(v*v-w*w)      +0.25f*u*v);
//	f18=SF*f18+(1.0f-SF)*(0.052631579f*rho+ 0.0033416876f*(-11.f*rho+19.f*usqr)+ 0.003968254f*m2 +0.1f*(-v-w)+0.01666666667f*(-v+w) -0.055555556f*(2.f*u*u-(v*v+w*w))                         +0.25f*v*w      );
	}
	else
	{
	//scale
	f0 =SF*f0 +(1.0f-SF)*(0.3333333333f*(rho-1.5f*usqr));
	f1 =SF*f1 +(1.0f-SF)*(0.0555555556f*(rho+3.0f*u+4.5f*u*u-1.5f*usqr));                
	f2 =SF*f2 +(1.0f-SF)*(0.0555555556f*(rho+3.0f*v+4.5f*v*v-1.5f*usqr));
	f3 =SF*f3 +(1.0f-SF)*(0.0555555556f*(rho-3.0f*u+4.5f*u*u-1.5f*usqr));
	f4 =SF*f4 +(1.0f-SF)*(0.0555555556f*(rho-3.0f*v+4.5f*v*v-1.5f*usqr));
	f5 =SF*f5 +(1.0f-SF)*(0.0277777778f*(rho+3.0f*(u+v)+4.5f*(u+v)*(u+v)-1.5f*usqr));
	f6 =SF*f6 +(1.0f-SF)*(0.0277777778f*(rho+3.0f*(-u+v)+4.5f*(-u+v)*(-u+v)-1.5f*usqr));
	f7 =SF*f7 +(1.0f-SF)*(0.0277777778f*(rho+3.0f*(-u-v)+4.5f*(-u-v)*(-u-v)-1.5f*usqr));
	f8 =SF*f8 +(1.0f-SF)*(0.0277777778f*(rho+3.0f*(u-v)+4.5f*(u-v)*(u-v)-1.5f*usqr));
	f9 =SF*f9 +(1.0f-SF)*(0.0555555556f*(rho+3.0f*w+4.5f*w*w-1.5f*usqr));
	f10=SF*f10+(1.0f-SF)*(0.0277777778f*(rho+3.0f*(u+w)+4.5f*(u+w)*(u+w)-1.5f*usqr));
	f11=SF*f11+(1.0f-SF)*(0.0277777778f*(rho+3.0f*(v+w)+4.5f*(v+w)*(u+w)-1.5f*usqr));
	f12=SF*f12+(1.0f-SF)*(0.0277777778f*(rho+3.0f*(-u+w)+4.5f*(-u+w)*(-u+w)-1.5f*usqr));
	f13=SF*f13+(1.0f-SF)*(0.0277777778f*(rho+3.0f*(-v+w)+4.5f*(-v+w)*(u+w)-1.5f*usqr));
	f14=SF*f14+(1.0f-SF)*(0.0555555556f*(rho-3.0f*w+4.5f*w*w-1.5f*usqr));
	f15=SF*f15+(1.0f-SF)*(0.0277777778f*(rho+3.0f*(u-w)+4.5f*(u-w)*(u-w)-1.5f*usqr));
	f16=SF*f16+(1.0f-SF)*(0.0277777778f*(rho+3.0f*(v-w)+4.5f*(v-w)*(v-w)-1.5f*usqr));
	f17=SF*f17+(1.0f-SF)*(0.0277777778f*(rho+3.0f*(-u-w)+4.5f*(-u-w)*(-u-w)-1.5f*usqr));
	f18=SF*f18+(1.0f-SF)*(0.0277777778f*(rho+3.0f*(-v-w)+4.5f*(-v-w)*(-v-w)-1.5f*usqr));
	}

	fout[f_memLR(0 ,x,y,z,pitch)] = f0 ;
	fout[f_memLR(1 ,x,y,z,pitch)] = f1 ;
	fout[f_memLR(2 ,x,y,z,pitch)] = f2 ;
	fout[f_memLR(3 ,x,y,z,pitch)] = f3 ;
	fout[f_memLR(4 ,x,y,z,pitch)] = f4 ;
	fout[f_memLR(5 ,x,y,z,pitch)] = f5 ;
	fout[f_memLR(6 ,x,y,z,pitch)] = f6 ;
	fout[f_memLR(7 ,x,y,z,pitch)] = f7 ;
	fout[f_memLR(8 ,x,y,z,pitch)] = f8 ;
	fout[f_memLR(9 ,x,y,z,pitch)] = f9 ;
	fout[f_memLR(10,x,y,z,pitch)] = f10;
	fout[f_memLR(11,x,y,z,pitch)] = f11;
	fout[f_memLR(12,x,y,z,pitch)] = f12;
	fout[f_memLR(13,x,y,z,pitch)] = f13;
	fout[f_memLR(14,x,y,z,pitch)] = f14;
	fout[f_memLR(15,x,y,z,pitch)] = f15;
	fout[f_memLR(16,x,y,z,pitch)] = f16;
	fout[f_memLR(17,x,y,z,pitch)] = f17;
	fout[f_memLR(18,x,y,z,pitch)] = f18;
	}
	else{
	f0 = fin[j];
	f2 = fin[f_memLR(2 ,x  ,y-1,z  ,pitch)];
	f4 = fin[f_memLR(4 ,x  ,y+1,z  ,pitch)];
	f9 = fin[f_memLR(9 ,x  ,y  ,z-1,pitch)];
	f11= fin[f_memLR(11,x  ,y-1,z-1,pitch)];
	f13= fin[f_memLR(13,x  ,y+1,z-1,pitch)];
	f14= fin[f_memLR(14,x  ,y  ,z+1,pitch)];
	f16= fin[f_memLR(16,x  ,y-1,z+1,pitch)];
	if(z != ZDIM-1){
	f18= fin[f_memLR(18,x  ,y+1,z+1,pitch)];
	}
	f1 = tex2D(texRef_f1D ,x-1+0.5f,y  +0.5f+YDIM*(z));
	f3 = tex2D(texRef_f3D ,x+1+0.5f,y  +0.5f+YDIM*(z));
	f5 = tex2D(texRef_f5D ,x-1+0.5f,y-1+0.5f+YDIM*(z));
	f6 = tex2D(texRef_f6D ,x+1+0.5f,y-1+0.5f+YDIM*(z));
	f7 = tex2D(texRef_f7D ,x+1+0.5f,y+1+0.5f+YDIM*(z));
	f8 = tex2D(texRef_f8D ,x-1+0.5f,y+1+0.5f+YDIM*(z));
	f15= tex2D(texRef_f15D,x-1+0.5f,y  +0.5f+YDIM*(z+1));
	f17= tex2D(texRef_f17D,x+1+0.5f,y  +0.5f+YDIM*(z+1));
	f10= tex2D(texRef_f10D,x-1+0.5f,y  +0.5f+YDIM*(z-1));
	f12= tex2D(texRef_f12D,x+1+0.5f,y  +0.5f+YDIM*(z-1));

	//else f18 = 0.1f;
	if(im == 1){//BB
		fout[f_memLR(1 ,x,y,z,pitch)] = f3 ;
		fout[f_memLR(2 ,x,y,z,pitch)] = f4 ;
		fout[f_memLR(3 ,x,y,z,pitch)] = f1 ;
		fout[f_memLR(4 ,x,y,z,pitch)] = f2 ;
		fout[f_memLR(5 ,x,y,z,pitch)] = f7 ;
		fout[f_memLR(6 ,x,y,z,pitch)] = f8 ;
		fout[f_memLR(7 ,x,y,z,pitch)] = f5 ;
		fout[f_memLR(8 ,x,y,z,pitch)] = f6 ;
		fout[f_memLR(9 ,x,y,z,pitch)] = f14;
		fout[f_memLR(10,x,y,z,pitch)] = f17;
		fout[f_memLR(11,x,y,z,pitch)] = f18;
		fout[f_memLR(12,x,y,z,pitch)] = f15;
		fout[f_memLR(13,x,y,z,pitch)] = f16;
		fout[f_memLR(14,x,y,z,pitch)] = f9 ;
		fout[f_memLR(15,x,y,z,pitch)] = f12;
		fout[f_memLR(16,x,y,z,pitch)] = f13;
		fout[f_memLR(17,x,y,z,pitch)] = f10;
		fout[f_memLR(18,x,y,z,pitch)] = f11;
	}
	else{
		if(MODEL == "MRT")
		mrt_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,omega);
		else if(MODEL == "BGK")
		bgk_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,omega);

		fout[f_memLR(0 ,x,y,z,pitch)] = f0 ;
		fout[f_memLR(1 ,x,y,z,pitch)] = f1 ;
		fout[f_memLR(2 ,x,y,z,pitch)] = f2 ;
		fout[f_memLR(3 ,x,y,z,pitch)] = f3 ;
		fout[f_memLR(4 ,x,y,z,pitch)] = f4 ;
		fout[f_memLR(5 ,x,y,z,pitch)] = f5 ;
		fout[f_memLR(6 ,x,y,z,pitch)] = f6 ;
		fout[f_memLR(7 ,x,y,z,pitch)] = f7 ;
		fout[f_memLR(8 ,x,y,z,pitch)] = f8 ;
		fout[f_memLR(9 ,x,y,z,pitch)] = f9 ;
		fout[f_memLR(10,x,y,z,pitch)] = f10;
		fout[f_memLR(11,x,y,z,pitch)] = f11;
		fout[f_memLR(12,x,y,z,pitch)] = f12;
		fout[f_memLR(13,x,y,z,pitch)] = f13;
		fout[f_memLR(14,x,y,z,pitch)] = f14;
		fout[f_memLR(15,x,y,z,pitch)] = f15;
		fout[f_memLR(16,x,y,z,pitch)] = f16;
		fout[f_memLR(17,x,y,z,pitch)] = f17;
		fout[f_memLR(18,x,y,z,pitch)] = f18;
	}
	}//end else (not at edge of LR)
}

__global__ void LR_d_ABCD(float* fin, float* fout,
							float omega, size_t pitch)//pitch in elements
{
	int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
	int y = threadIdx.y+blockIdx.y*blockDim.y;
	int z = threadIdx.z+blockIdx.z*blockDim.z;
	float xcoord = LRX0+x*LRFACTOR;
	float ycoord = LRY0+y*LRFACTOR;
	float zcoord = LRZ0+z*LRFACTOR;
	int j = x+y*pitch+z*YLRDIM*pitch;//index on padded mem (pitch in elements)
	float f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18;
	int im = ImageFcn(xcoord,ycoord,zcoord);
//	if(x < 2 || x > LRX0+XLRDIM-3 || y < 2 || y > LRY0+YLRDIM-3 || z < 2 || z > LRZ0+ZLRDIM-3)
//	im = -1;//not valid for extraction
//	if(x < 1 || x > LRX0+XLRDIM-2 || y < 1 || y > LRY0+YLRDIM-2 || z < 1 || z > LRZ0+ZLRDIM-2)
//	{
//	im = -2;//not valid for second TS
//	}

	if(x < 1 || x > XLRDIM-2 || y < 1 || y > YLRDIM-2 || z < 1 || z > ZLRDIM-2)
	{
	//dont do anything
	}
	else{
	f0 = fin[j];
	f1 = fin[f_memLR(1 ,x-1,y  ,z  ,pitch)];
	f3 = fin[f_memLR(3 ,x+1,y  ,z  ,pitch)];
	f2 = fin[f_memLR(2 ,x  ,y-1,z  ,pitch)];
	f5 = fin[f_memLR(5 ,x-1,y-1,z  ,pitch)];
	f6 = fin[f_memLR(6 ,x+1,y-1,z  ,pitch)];
	f4 = fin[f_memLR(4 ,x  ,y+1,z  ,pitch)];
	f7 = fin[f_memLR(7 ,x+1,y+1,z  ,pitch)];
	f8 = fin[f_memLR(8 ,x-1,y+1,z  ,pitch)];
	f9 = fin[f_memLR(9 ,x  ,y  ,z-1,pitch)];
	f10= fin[f_memLR(10,x-1,y  ,z-1,pitch)];
	f11= fin[f_memLR(11,x  ,y-1,z-1,pitch)];
	f12= fin[f_memLR(12,x+1,y  ,z-1,pitch)];
	f13= fin[f_memLR(13,x  ,y+1,z-1,pitch)];
	f14= fin[f_memLR(14,x  ,y  ,z+1,pitch)];
	f15= fin[f_memLR(15,x-1,y  ,z+1,pitch)];
	f16= fin[f_memLR(16,x  ,y-1,z+1,pitch)];
	f17= fin[f_memLR(17,x+1,y  ,z+1,pitch)];
	f18= fin[f_memLR(18,x  ,dmin(y+1,YLRDIM),dmin(z+1,ZLRDIM),pitch)];
	if(im == 1){//BB
		fout[f_memLR(1 ,x,y,z,pitch)] = f3 ;
		fout[f_memLR(2 ,x,y,z,pitch)] = f4 ;
		fout[f_memLR(3 ,x,y,z,pitch)] = f1 ;
		fout[f_memLR(4 ,x,y,z,pitch)] = f2 ;
		fout[f_memLR(5 ,x,y,z,pitch)] = f7 ;
		fout[f_memLR(6 ,x,y,z,pitch)] = f8 ;
		fout[f_memLR(7 ,x,y,z,pitch)] = f5 ;
		fout[f_memLR(8 ,x,y,z,pitch)] = f6 ;
		fout[f_memLR(9 ,x,y,z,pitch)] = f14;
		fout[f_memLR(10,x,y,z,pitch)] = f17;
		fout[f_memLR(11,x,y,z,pitch)] = f18;
		fout[f_memLR(12,x,y,z,pitch)] = f15;
		fout[f_memLR(13,x,y,z,pitch)] = f16;
		fout[f_memLR(14,x,y,z,pitch)] = f9 ;
		fout[f_memLR(15,x,y,z,pitch)] = f12;
		fout[f_memLR(16,x,y,z,pitch)] = f13;
		fout[f_memLR(17,x,y,z,pitch)] = f10;
		fout[f_memLR(18,x,y,z,pitch)] = f11;
	}
	else{
		if(MODEL == "MRT")
		mrt_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,omega);
		else if(MODEL == "BGK")
		bgk_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,omega);

		fout[f_memLR(0 ,x,y,z,pitch)] = f0 ;
		fout[f_memLR(1 ,x,y,z,pitch)] = f1 ;
		fout[f_memLR(2 ,x,y,z,pitch)] = f2 ;
		fout[f_memLR(3 ,x,y,z,pitch)] = f3 ;
		fout[f_memLR(4 ,x,y,z,pitch)] = f4 ;
		fout[f_memLR(5 ,x,y,z,pitch)] = f5 ;
		fout[f_memLR(6 ,x,y,z,pitch)] = f6 ;
		fout[f_memLR(7 ,x,y,z,pitch)] = f7 ;
		fout[f_memLR(8 ,x,y,z,pitch)] = f8 ;
		fout[f_memLR(9 ,x,y,z,pitch)] = f9 ;
		fout[f_memLR(10,x,y,z,pitch)] = f10;
		fout[f_memLR(11,x,y,z,pitch)] = f11;
		fout[f_memLR(12,x,y,z,pitch)] = f12;
		fout[f_memLR(13,x,y,z,pitch)] = f13;
		fout[f_memLR(14,x,y,z,pitch)] = f14;
		fout[f_memLR(15,x,y,z,pitch)] = f15;
		fout[f_memLR(16,x,y,z,pitch)] = f16;
		fout[f_memLR(17,x,y,z,pitch)] = f17;
		fout[f_memLR(18,x,y,z,pitch)] = f18;
	}
	}//end else (not at edge of LR)
}

__global__ void LR_d_ABDC(float* fin, float* fout,
							float omega, size_t pitch, float SF)//pitch in elements
{
	int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
	int y = threadIdx.y+blockIdx.y*blockDim.y;
	int z = threadIdx.z+blockIdx.z*blockDim.z;
	float xcoord = LRX0+x*LRFACTOR;//+0.5f is because textures are stored in a voxel centered fashion. we need to change this to vertex centered.
	float ycoord = LRY0+y*LRFACTOR;
	float zcoord = LRZ0+z*LRFACTOR;//dont need to +0.5f because z is not using texture interpolation
	int zminus = int(zcoord);
	int zplus = zminus+1;
	int j = x+y*pitch+z*YLRDIM*pitch;//index on padded mem (pitch in elements)
	float f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18;
	int im = ImageFcn(xcoord,ycoord,zcoord);
//	if(x < 2 || x > LRX0+XLRDIM-3 || y < 2 || y > LRY0+YLRDIM-3 || z < 2 || z > LRZ0+ZLRDIM-3)
//	im = -1;//not valid for extraction
//	if(x < 1 || x > LRX0+XLRDIM-2 || y < 1 || y > LRY0+YLRDIM-2 || z < 1 || z > LRZ0+ZLRDIM-2)
//	{
//	im = -2;//not valid for second TS
//	}

	if(x < 2 || x > XLRDIM-3 || y < 2 || y > YLRDIM-3 || z < 2 || z > ZLRDIM-3)
	{
	//interpolate for next time step. from B
	f0 = (zplus-zcoord)*tex2D(texRef_f0B ,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f0B ,xcoord+0.5f,ycoord+0.5f+YDIM*(zplus));
	f2 = (zplus-zcoord)*tex2D(texRef_f2B ,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f2B ,xcoord+0.5f,ycoord+0.5f+YDIM*(zplus));
	f4 = (zplus-zcoord)*tex2D(texRef_f4B ,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f4B ,xcoord+0.5f,ycoord+0.5f+YDIM*(zplus));
	f9 = (zplus-zcoord)*tex2D(texRef_f9B ,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f9B ,xcoord+0.5f,ycoord+0.5f+YDIM*(zplus));
	f11= (zplus-zcoord)*tex2D(texRef_f11B,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f11B,xcoord+0.5f,ycoord+0.5f+YDIM*(zplus));
	f13= (zplus-zcoord)*tex2D(texRef_f13B,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f13B,xcoord+0.5f,ycoord+0.5f+YDIM*(zplus));
	f14= (zplus-zcoord)*tex2D(texRef_f14B,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f14B,xcoord+0.5f,ycoord+0.5f+YDIM*(zplus));
	f16= (zplus-zcoord)*tex2D(texRef_f16B,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f16B,xcoord+0.5f,ycoord+0.5f+YDIM*(zplus));
	f18= (zplus-zcoord)*tex2D(texRef_f18B,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f18B,xcoord+0.5f,ycoord+0.5f+YDIM*(zplus));
	f1 = (zplus-zcoord)*tex2D(texRef_f1B ,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f1B ,xcoord+0.5f,ycoord+0.5f+YDIM*(zplus));
	f3 = (zplus-zcoord)*tex2D(texRef_f3B ,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f3B ,xcoord+0.5f,ycoord+0.5f+YDIM*(zplus));
	f5 = (zplus-zcoord)*tex2D(texRef_f5B ,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f5B ,xcoord+0.5f,ycoord+0.5f+YDIM*(zplus));
	f6 = (zplus-zcoord)*tex2D(texRef_f6B ,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f6B ,xcoord+0.5f,ycoord+0.5f+YDIM*(zplus));
	f7 = (zplus-zcoord)*tex2D(texRef_f7B ,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f7B ,xcoord+0.5f,ycoord+0.5f+YDIM*(zplus));
	f8 = (zplus-zcoord)*tex2D(texRef_f8B ,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f8B ,xcoord+0.5f,ycoord+0.5f+YDIM*(zplus));
	f15= (zplus-zcoord)*tex2D(texRef_f15B,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f15B,xcoord+0.5f,ycoord+0.5f+YDIM*(zplus));
	f17= (zplus-zcoord)*tex2D(texRef_f17B,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f17B,xcoord+0.5f,ycoord+0.5f+YDIM*(zplus));
	f10= (zplus-zcoord)*tex2D(texRef_f10B,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f10B,xcoord+0.5f,ycoord+0.5f+YDIM*(zplus));
	f12= (zplus-zcoord)*tex2D(texRef_f12B,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f12B,xcoord+0.5f,ycoord+0.5f+YDIM*(zplus));

	float rho,u,v,w;	
	rho = f0+f1+f2+f3+f4+f5+f6+f7+f8+f9+
	      f10+f11+f12+f13+f14+f15+f16+f17+f18;
	u = f1-f3+f5-f6-f7+f8+f10-f12+f15-f17;
	v = f2-f4+f5+f6-f7-f8+f11-f13+f16-f18;
	w = f9+f10+f11+f12+f13-f14-f15-f16-f17-f18;
	float usqr = fma(u,u,fma(v,v,w*w));

	if(MODEL == "MRT")
	{
	float m2 = -7.53968254f*(u*u+v*v+w*w);
	//scale
	f0 =SF*f0 +(1.0f-SF)*(0.052631579f*rho+ -0.012531328f*(-11.f*rho+19.f*usqr)+ 0.047619048f*m2);
	f1 =SF*f1 +(1.0f-SF)*(0.052631579f*rho+-0.0045948204f*(-11.f*rho+19.f*usqr)+-0.015873016f*m2 +( 0.1666666667f*u)                +0.055555556f*(2.f*u*u-(v*v+w*w))                          );
	f2 =SF*f2 +(1.0f-SF)*(0.052631579f*rho+-0.0045948204f*(-11.f*rho+19.f*usqr)+-0.015873016f*m2 +( 0.1666666667f*v)                -0.027777778f*(2.f*u*u-(v*v+w*w))  +0.0833333333f*(v*v-w*w)            );
	f3 =SF*f3 +(1.0f-SF)*(0.052631579f*rho+-0.0045948204f*(-11.f*rho+19.f*usqr)+-0.015873016f*m2 +(-0.1666666667f*u)                +0.055555556f*(2.f*u*u-(v*v+w*w))                          );
	f4 =SF*f4 +(1.0f-SF)*(0.052631579f*rho+-0.0045948204f*(-11.f*rho+19.f*usqr)+-0.015873016f*m2 +(-0.1666666667f*v)                -0.027777778f*(2.f*u*u-(v*v+w*w))  +0.0833333333f*(v*v-w*w)            );
	f5 =SF*f5 +(1.0f-SF)*(0.052631579f*rho+ 0.0033416876f*(-11.f*rho+19.f*usqr)+ 0.003968254f*m2 +0.1f*( u+v)+0.01666666667f*(-u-v) +0.027777778f*(2.f*u*u-(v*v+w*w))  +0.0833333333f*(v*v-w*w)+0.25f*(u*v)    );
	f6 =SF*f6 +(1.0f-SF)*(0.052631579f*rho+ 0.0033416876f*(-11.f*rho+19.f*usqr)+ 0.003968254f*m2 +0.1f*(-u+v)+0.01666666667f*( u-v) +0.027777778f*(2.f*u*u-(v*v+w*w))  +0.0833333333f*(v*v-w*w)-0.25f*(u*v)    );
	f7 =SF*f7 +(1.0f-SF)*(0.052631579f*rho+ 0.0033416876f*(-11.f*rho+19.f*usqr)+ 0.003968254f*m2 +0.1f*(-u-v)+0.01666666667f*( u+v) +0.027777778f*(2.f*u*u-(v*v+w*w))  +0.0833333333f*(v*v-w*w)+0.25f*(u*v)    );
	f8 =SF*f8 +(1.0f-SF)*(0.052631579f*rho+ 0.0033416876f*(-11.f*rho+19.f*usqr)+ 0.003968254f*m2 +0.1f*( u-v)+0.01666666667f*(-u+v) +0.027777778f*(2.f*u*u-(v*v+w*w))  +0.0833333333f*(v*v-w*w)-0.25f*(u*v)    );
	f9 =SF*f9 +(1.0f-SF)*(0.052631579f*rho+-0.0045948204f*(-11.f*rho+19.f*usqr)+-0.015873016f*m2 +( 0.1666666667f*w)                -0.027777778f*(2.f*u*u-(v*v+w*w))  -0.0833333333f*(v*v-w*w)            );
	f10=SF*f10+(1.0f-SF)*(0.052631579f*rho+ 0.0033416876f*(-11.f*rho+19.f*usqr)+ 0.003968254f*m2 +0.1f*( u+w)+0.01666666667f*(-u-w) +0.027777778f*(2.f*u*u-(v*v+w*w))  -0.0833333333f*(v*v-w*w)      +0.25f*u*v);
	f11=SF*f11+(1.0f-SF)*(0.052631579f*rho+ 0.0033416876f*(-11.f*rho+19.f*usqr)+ 0.003968254f*m2 +0.1f*( v+w)+0.01666666667f*(-v-w) -0.055555556f*(2.f*u*u-(v*v+w*w))                         +0.25f*v*w      );
	f12=SF*f12+(1.0f-SF)*(0.052631579f*rho+ 0.0033416876f*(-11.f*rho+19.f*usqr)+ 0.003968254f*m2 +0.1f*(-u+w)+0.01666666667f*( u-w) +0.027777778f*(2.f*u*u-(v*v+w*w))  -0.0833333333f*(v*v-w*w)      -0.25f*u*v);
	f13=SF*f13+(1.0f-SF)*(0.052631579f*rho+ 0.0033416876f*(-11.f*rho+19.f*usqr)+ 0.003968254f*m2 +0.1f*(-v+w)+0.01666666667f*(-v-w) -0.055555556f*(2.f*u*u-(v*v+w*w))                         -0.25f*v*w      );
	f14=SF*f14+(1.0f-SF)*(0.052631579f*rho+-0.0045948204f*(-11.f*rho+19.f*usqr)+-0.015873016f*m2 +(-0.1666666667f*w)                +0.027777778f*(2.f*u*u-(v*v+w*w))  +0.0833333333f*(v*v-w*w)            );
	f15=SF*f15+(1.0f-SF)*(0.052631579f*rho+ 0.0033416876f*(-11.f*rho+19.f*usqr)+ 0.003968254f*m2 +0.1f*( u-w)+0.01666666667f*(-u+w) +0.027777778f*(2.f*u*u-(v*v+w*w))  -0.0833333333f*(v*v-w*w)      +0.25f*u*v);
	f16=SF*f16+(1.0f-SF)*(0.052631579f*rho+ 0.0033416876f*(-11.f*rho+19.f*usqr)+ 0.003968254f*m2 +0.1f*( v-w)+0.01666666667f*(-v+w) -0.055555556f*(2.f*u*u-(v*v+w*w))                         +0.25f*v*w      );
	f17=SF*f17+(1.0f-SF)*(0.052631579f*rho+ 0.0033416876f*(-11.f*rho+19.f*usqr)+ 0.003968254f*m2 +0.1f*(-u-w)+0.01666666667f*( u+w) +0.027777778f*(2.f*u*u-(v*v+w*w))  -0.0833333333f*(v*v-w*w)      +0.25f*u*v);
	f18=SF*f18+(1.0f-SF)*(0.052631579f*rho+ 0.0033416876f*(-11.f*rho+19.f*usqr)+ 0.003968254f*m2 +0.1f*(-v-w)+0.01666666667f*(-v+w) -0.055555556f*(2.f*u*u-(v*v+w*w))                         +0.25f*v*w      );
	}
	else
	{

	//scale
	f0 =SF*f0 +(1.0f-SF)*(0.3333333333f*(rho-1.5f*usqr));
	f1 =SF*f1 +(1.0f-SF)*(0.0555555556f*(rho+3.0f*u+4.5f*u*u-1.5f*usqr));                
	f2 =SF*f2 +(1.0f-SF)*(0.0555555556f*(rho+3.0f*v+4.5f*v*v-1.5f*usqr));
	f3 =SF*f3 +(1.0f-SF)*(0.0555555556f*(rho-3.0f*u+4.5f*u*u-1.5f*usqr));
	f4 =SF*f4 +(1.0f-SF)*(0.0555555556f*(rho-3.0f*v+4.5f*v*v-1.5f*usqr));
	f5 =SF*f5 +(1.0f-SF)*(0.0277777778f*(rho+3.0f*(u+v)+4.5f*(u+v)*(u+v)-1.5f*usqr));
	f6 =SF*f6 +(1.0f-SF)*(0.0277777778f*(rho+3.0f*(-u+v)+4.5f*(-u+v)*(-u+v)-1.5f*usqr));
	f7 =SF*f7 +(1.0f-SF)*(0.0277777778f*(rho+3.0f*(-u-v)+4.5f*(-u-v)*(-u-v)-1.5f*usqr));
	f8 =SF*f8 +(1.0f-SF)*(0.0277777778f*(rho+3.0f*(u-v)+4.5f*(u-v)*(u-v)-1.5f*usqr));
	f9 =SF*f9 +(1.0f-SF)*(0.0555555556f*(rho+3.0f*w+4.5f*w*w-1.5f*usqr));
	f10=SF*f10+(1.0f-SF)*(0.0277777778f*(rho+3.0f*(u+w)+4.5f*(u+w)*(u+w)-1.5f*usqr));
	f11=SF*f11+(1.0f-SF)*(0.0277777778f*(rho+3.0f*(v+w)+4.5f*(v+w)*(u+w)-1.5f*usqr));
	f12=SF*f12+(1.0f-SF)*(0.0277777778f*(rho+3.0f*(-u+w)+4.5f*(-u+w)*(-u+w)-1.5f*usqr));
	f13=SF*f13+(1.0f-SF)*(0.0277777778f*(rho+3.0f*(-v+w)+4.5f*(-v+w)*(u+w)-1.5f*usqr));
	f14=SF*f14+(1.0f-SF)*(0.0555555556f*(rho-3.0f*w+4.5f*w*w-1.5f*usqr));
	f15=SF*f15+(1.0f-SF)*(0.0277777778f*(rho+3.0f*(u-w)+4.5f*(u-w)*(u-w)-1.5f*usqr));
	f16=SF*f16+(1.0f-SF)*(0.0277777778f*(rho+3.0f*(v-w)+4.5f*(v-w)*(v-w)-1.5f*usqr));
	f17=SF*f17+(1.0f-SF)*(0.0277777778f*(rho+3.0f*(-u-w)+4.5f*(-u-w)*(-u-w)-1.5f*usqr));
	f18=SF*f18+(1.0f-SF)*(0.0277777778f*(rho+3.0f*(-v-w)+4.5f*(-v-w)*(-v-w)-1.5f*usqr));
	}

	fout[f_memLR(0 ,x,y,z,pitch)] = f0 ;
	fout[f_memLR(1 ,x,y,z,pitch)] = f1 ;
	fout[f_memLR(2 ,x,y,z,pitch)] = f2 ;
	fout[f_memLR(3 ,x,y,z,pitch)] = f3 ;
	fout[f_memLR(4 ,x,y,z,pitch)] = f4 ;
	fout[f_memLR(5 ,x,y,z,pitch)] = f5 ;
	fout[f_memLR(6 ,x,y,z,pitch)] = f6 ;
	fout[f_memLR(7 ,x,y,z,pitch)] = f7 ;
	fout[f_memLR(8 ,x,y,z,pitch)] = f8 ;
	fout[f_memLR(9 ,x,y,z,pitch)] = f9 ;
	fout[f_memLR(10,x,y,z,pitch)] = f10;
	fout[f_memLR(11,x,y,z,pitch)] = f11;
	fout[f_memLR(12,x,y,z,pitch)] = f12;
	fout[f_memLR(13,x,y,z,pitch)] = f13;
	fout[f_memLR(14,x,y,z,pitch)] = f14;
	fout[f_memLR(15,x,y,z,pitch)] = f15;
	fout[f_memLR(16,x,y,z,pitch)] = f16;
	fout[f_memLR(17,x,y,z,pitch)] = f17;
	fout[f_memLR(18,x,y,z,pitch)] = f18;
	}
	else{
	f0 = fin[j];
	f1 = fin[f_memLR(1 ,x-1,y  ,z  ,pitch)];
	f3 = fin[f_memLR(3 ,x+1,y  ,z  ,pitch)];
	f2 = fin[f_memLR(2 ,x  ,y-1,z  ,pitch)];
	f5 = fin[f_memLR(5 ,x-1,y-1,z  ,pitch)];
	f6 = fin[f_memLR(6 ,x+1,y-1,z  ,pitch)];
	f4 = fin[f_memLR(4 ,x  ,y+1,z  ,pitch)];
	f7 = fin[f_memLR(7 ,x+1,y+1,z  ,pitch)];
	f8 = fin[f_memLR(8 ,x-1,y+1,z  ,pitch)];
	f9 = fin[f_memLR(9 ,x  ,y  ,z-1,pitch)];
	f10= fin[f_memLR(10,x-1,y  ,z-1,pitch)];
	f11= fin[f_memLR(11,x  ,y-1,z-1,pitch)];
	f12= fin[f_memLR(12,x+1,y  ,z-1,pitch)];
	f13= fin[f_memLR(13,x  ,y+1,z-1,pitch)];
	f14= fin[f_memLR(14,x  ,y  ,z+1,pitch)];
	f15= fin[f_memLR(15,x-1,y  ,z+1,pitch)];
	f16= fin[f_memLR(16,x  ,y-1,z+1,pitch)];
	f17= fin[f_memLR(17,x+1,y  ,z+1,pitch)];
	//if(z != ZLRDIM-1){
	f18= fin[f_memLR(18,x  ,dmin(y+1,YLRDIM),dmin(z+1,ZLRDIM),pitch)];
	//}
	//else f18 = 0.1f;
	if(im == 1){//BB
		fout[f_memLR(1 ,x,y,z,pitch)] = f3 ;
		fout[f_memLR(2 ,x,y,z,pitch)] = f4 ;
		fout[f_memLR(3 ,x,y,z,pitch)] = f1 ;
		fout[f_memLR(4 ,x,y,z,pitch)] = f2 ;
		fout[f_memLR(5 ,x,y,z,pitch)] = f7 ;
		fout[f_memLR(6 ,x,y,z,pitch)] = f8 ;
		fout[f_memLR(7 ,x,y,z,pitch)] = f5 ;
		fout[f_memLR(8 ,x,y,z,pitch)] = f6 ;
		fout[f_memLR(9 ,x,y,z,pitch)] = f14;
		fout[f_memLR(10,x,y,z,pitch)] = f17;
		fout[f_memLR(11,x,y,z,pitch)] = f18;
		fout[f_memLR(12,x,y,z,pitch)] = f15;
		fout[f_memLR(13,x,y,z,pitch)] = f16;
		fout[f_memLR(14,x,y,z,pitch)] = f9 ;
		fout[f_memLR(15,x,y,z,pitch)] = f12;
		fout[f_memLR(16,x,y,z,pitch)] = f13;
		fout[f_memLR(17,x,y,z,pitch)] = f10;
		fout[f_memLR(18,x,y,z,pitch)] = f11;
	}
	else{
		if(MODEL == "MRT")
		mrt_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,omega);
		else if(MODEL == "BGK")
		bgk_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,omega);

		fout[f_memLR(0 ,x,y,z,pitch)] = f0 ;
		fout[f_memLR(1 ,x,y,z,pitch)] = f1 ;
		fout[f_memLR(2 ,x,y,z,pitch)] = f2 ;
		fout[f_memLR(3 ,x,y,z,pitch)] = f3 ;
		fout[f_memLR(4 ,x,y,z,pitch)] = f4 ;
		fout[f_memLR(5 ,x,y,z,pitch)] = f5 ;
		fout[f_memLR(6 ,x,y,z,pitch)] = f6 ;
		fout[f_memLR(7 ,x,y,z,pitch)] = f7 ;
		fout[f_memLR(8 ,x,y,z,pitch)] = f8 ;
		fout[f_memLR(9 ,x,y,z,pitch)] = f9 ;
		fout[f_memLR(10,x,y,z,pitch)] = f10;
		fout[f_memLR(11,x,y,z,pitch)] = f11;
		fout[f_memLR(12,x,y,z,pitch)] = f12;
		fout[f_memLR(13,x,y,z,pitch)] = f13;
		fout[f_memLR(14,x,y,z,pitch)] = f14;
		fout[f_memLR(15,x,y,z,pitch)] = f15;
		fout[f_memLR(16,x,y,z,pitch)] = f16;
		fout[f_memLR(17,x,y,z,pitch)] = f17;
		fout[f_memLR(18,x,y,z,pitch)] = f18;
	}
	}//end else (not at edge of LR)
}

__global__ void LR_d_BACD(float* fin, float* fout,
							float omega, size_t pitch)//pitch in elements
{
	int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
	int y = threadIdx.y+blockIdx.y*blockDim.y;
	int z = threadIdx.z+blockIdx.z*blockDim.z;
	float xcoord = LRX0+x*LRFACTOR;
	float ycoord = LRY0+y*LRFACTOR;
	float zcoord = LRZ0+z*LRFACTOR;
	int j = x+y*pitch+z*YLRDIM*pitch;//index on padded mem (pitch in elements)
	float f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18;
	int im = ImageFcn(xcoord,ycoord,zcoord);
//	if(x < 2 || x > LRX0+XLRDIM-3 || y < 2 || y > LRY0+YLRDIM-3 || z < 2 || z > LRZ0+ZLRDIM-3)
//	im = -1;//not valid for extraction
//	if(x < 1 || x > LRX0+XLRDIM-2 || y < 1 || y > LRY0+YLRDIM-2 || z < 1 || z > LRZ0+ZLRDIM-2)
//	{
//	im = -2;//not valid for second TS
//	}

	if(x < 1 || x > XLRDIM-2 || y < 1 || y > YLRDIM-2 || z < 1 || z > ZLRDIM-2)
	{
	//dont do anything
	}
	else{
	f0 = fin[j];
	f1 = fin[f_memLR(1 ,x-1,y  ,z  ,pitch)];
	f3 = fin[f_memLR(3 ,x+1,y  ,z  ,pitch)];
	f2 = fin[f_memLR(2 ,x  ,y-1,z  ,pitch)];
	f5 = fin[f_memLR(5 ,x-1,y-1,z  ,pitch)];
	f6 = fin[f_memLR(6 ,x+1,y-1,z  ,pitch)];
	f4 = fin[f_memLR(4 ,x  ,y+1,z  ,pitch)];
	f7 = fin[f_memLR(7 ,x+1,y+1,z  ,pitch)];
	f8 = fin[f_memLR(8 ,x-1,y+1,z  ,pitch)];
	f9 = fin[f_memLR(9 ,x  ,y  ,z-1,pitch)];
	f10= fin[f_memLR(10,x-1,y  ,z-1,pitch)];
	f11= fin[f_memLR(11,x  ,y-1,z-1,pitch)];
	f12= fin[f_memLR(12,x+1,y  ,z-1,pitch)];
	f13= fin[f_memLR(13,x  ,y+1,z-1,pitch)];
	f14= fin[f_memLR(14,x  ,y  ,z+1,pitch)];
	f15= fin[f_memLR(15,x-1,y  ,z+1,pitch)];
	f16= fin[f_memLR(16,x  ,y-1,z+1,pitch)];
	f17= fin[f_memLR(17,x+1,y  ,z+1,pitch)];
	f18= fin[f_memLR(18,x  ,dmin(y+1,YLRDIM),dmin(z+1,ZLRDIM),pitch)];
	if(im == 1){//BB
		fout[f_memLR(1 ,x,y,z,pitch)] = f3 ;
		fout[f_memLR(2 ,x,y,z,pitch)] = f4 ;
		fout[f_memLR(3 ,x,y,z,pitch)] = f1 ;
		fout[f_memLR(4 ,x,y,z,pitch)] = f2 ;
		fout[f_memLR(5 ,x,y,z,pitch)] = f7 ;
		fout[f_memLR(6 ,x,y,z,pitch)] = f8 ;
		fout[f_memLR(7 ,x,y,z,pitch)] = f5 ;
		fout[f_memLR(8 ,x,y,z,pitch)] = f6 ;
		fout[f_memLR(9 ,x,y,z,pitch)] = f14;
		fout[f_memLR(10,x,y,z,pitch)] = f17;
		fout[f_memLR(11,x,y,z,pitch)] = f18;
		fout[f_memLR(12,x,y,z,pitch)] = f15;
		fout[f_memLR(13,x,y,z,pitch)] = f16;
		fout[f_memLR(14,x,y,z,pitch)] = f9 ;
		fout[f_memLR(15,x,y,z,pitch)] = f12;
		fout[f_memLR(16,x,y,z,pitch)] = f13;
		fout[f_memLR(17,x,y,z,pitch)] = f10;
		fout[f_memLR(18,x,y,z,pitch)] = f11;
	}
	else{
		if(MODEL == "MRT")
		mrt_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,omega);
		else if(MODEL == "BGK")
		bgk_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,omega);

		fout[f_memLR(0 ,x,y,z,pitch)] = f0 ;
		fout[f_memLR(1 ,x,y,z,pitch)] = f1 ;
		fout[f_memLR(2 ,x,y,z,pitch)] = f2 ;
		fout[f_memLR(3 ,x,y,z,pitch)] = f3 ;
		fout[f_memLR(4 ,x,y,z,pitch)] = f4 ;
		fout[f_memLR(5 ,x,y,z,pitch)] = f5 ;
		fout[f_memLR(6 ,x,y,z,pitch)] = f6 ;
		fout[f_memLR(7 ,x,y,z,pitch)] = f7 ;
		fout[f_memLR(8 ,x,y,z,pitch)] = f8 ;
		fout[f_memLR(9 ,x,y,z,pitch)] = f9 ;
		fout[f_memLR(10,x,y,z,pitch)] = f10;
		fout[f_memLR(11,x,y,z,pitch)] = f11;
		fout[f_memLR(12,x,y,z,pitch)] = f12;
		fout[f_memLR(13,x,y,z,pitch)] = f13;
		fout[f_memLR(14,x,y,z,pitch)] = f14;
		fout[f_memLR(15,x,y,z,pitch)] = f15;
		fout[f_memLR(16,x,y,z,pitch)] = f16;
		fout[f_memLR(17,x,y,z,pitch)] = f17;
		fout[f_memLR(18,x,y,z,pitch)] = f18;
	}
	}//end else (not at edge of LR)
}

__global__ void LR_d_BADC(float* fin, float* fout,
							float omega, size_t pitch, float SF)//pitch in elements
{
	int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
	int y = threadIdx.y+blockIdx.y*blockDim.y;
	int z = threadIdx.z+blockIdx.z*blockDim.z;
	float xcoord = LRX0+x*LRFACTOR;
	float ycoord = LRY0+y*LRFACTOR;
	float zcoord = LRZ0+z*LRFACTOR;
	int zminus = int(zcoord);
	int zplus = zminus+1;
	int j = x+y*pitch+z*YLRDIM*pitch;//index on padded mem (pitch in elements)
	float f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18;
	int im = ImageFcn(xcoord,ycoord,zcoord);
//	if(x < 2 || x > LRX0+XLRDIM-3 || y < 2 || y > LRY0+YLRDIM-3 || z < 2 || z > LRZ0+ZLRDIM-3)
//	im = -1;//not valid for extraction
//	if(x < 1 || x > LRX0+XLRDIM-2 || y < 1 || y > LRY0+YLRDIM-2 || z < 1 || z > LRZ0+ZLRDIM-2)
//	{
//	im = -2;//not valid for second TS
//	}

	if(x < 2 || x > XLRDIM-3 || y < 2 || y > YLRDIM-3 || z < 2 || z > ZLRDIM-3)
	{
	//interpolate for next time step. from A
	f0 = (zplus-zcoord)*tex2D(texRef_f0A ,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f0A ,xcoord+0.5f,ycoord+0.5f+YDIM*(zplus));
	f2 = (zplus-zcoord)*tex2D(texRef_f2A ,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f2A ,xcoord+0.5f,ycoord+0.5f+YDIM*(zplus));
	f4 = (zplus-zcoord)*tex2D(texRef_f4A ,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f4A ,xcoord+0.5f,ycoord+0.5f+YDIM*(zplus));
	f9 = (zplus-zcoord)*tex2D(texRef_f9A ,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f9A ,xcoord+0.5f,ycoord+0.5f+YDIM*(zplus));
	f11= (zplus-zcoord)*tex2D(texRef_f11A,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f11A,xcoord+0.5f,ycoord+0.5f+YDIM*(zplus));
	f13= (zplus-zcoord)*tex2D(texRef_f13A,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f13A,xcoord+0.5f,ycoord+0.5f+YDIM*(zplus));
	f14= (zplus-zcoord)*tex2D(texRef_f14A,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f14A,xcoord+0.5f,ycoord+0.5f+YDIM*(zplus));
	f16= (zplus-zcoord)*tex2D(texRef_f16A,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f16A,xcoord+0.5f,ycoord+0.5f+YDIM*(zplus));
	f18= (zplus-zcoord)*tex2D(texRef_f18A,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f18A,xcoord+0.5f,ycoord+0.5f+YDIM*(zplus));
	f1 = (zplus-zcoord)*tex2D(texRef_f1A ,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f1A ,xcoord+0.5f,ycoord+0.5f+YDIM*(zplus));
	f3 = (zplus-zcoord)*tex2D(texRef_f3A ,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f3A ,xcoord+0.5f,ycoord+0.5f+YDIM*(zplus));
	f5 = (zplus-zcoord)*tex2D(texRef_f5A ,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f5A ,xcoord+0.5f,ycoord+0.5f+YDIM*(zplus));
	f6 = (zplus-zcoord)*tex2D(texRef_f6A ,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f6A ,xcoord+0.5f,ycoord+0.5f+YDIM*(zplus));
	f7 = (zplus-zcoord)*tex2D(texRef_f7A ,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f7A ,xcoord+0.5f,ycoord+0.5f+YDIM*(zplus));
	f8 = (zplus-zcoord)*tex2D(texRef_f8A ,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f8A ,xcoord+0.5f,ycoord+0.5f+YDIM*(zplus));
	f15= (zplus-zcoord)*tex2D(texRef_f15A,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f15A,xcoord+0.5f,ycoord+0.5f+YDIM*(zplus));
	f17= (zplus-zcoord)*tex2D(texRef_f17A,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f17A,xcoord+0.5f,ycoord+0.5f+YDIM*(zplus));
	f10= (zplus-zcoord)*tex2D(texRef_f10A,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f10A,xcoord+0.5f,ycoord+0.5f+YDIM*(zplus));
	f12= (zplus-zcoord)*tex2D(texRef_f12A,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f12A,xcoord+0.5f,ycoord+0.5f+YDIM*(zplus));

	float rho,u,v,w;	
	rho = f0+f1+f2+f3+f4+f5+f6+f7+f8+f9+
	      f10+f11+f12+f13+f14+f15+f16+f17+f18;
	u = f1-f3+f5-f6-f7+f8+f10-f12+f15-f17;
	v = f2-f4+f5+f6-f7-f8+f11-f13+f16-f18;
	w = f9+f10+f11+f12+f13-f14-f15-f16-f17-f18;
	float usqr = fma(u,u,fma(v,v,w*w));

	if(MODEL == "MRT")
	{
	float m2 = -7.53968254f*(u*u+v*v+w*w);
	//scale
	f0 =SF*f0 +(1.0f-SF)*(0.052631579f*rho+ -0.012531328f*(-11.f*rho+19.f*usqr)+ 0.047619048f*m2);
	f1 =SF*f1 +(1.0f-SF)*(0.052631579f*rho+-0.0045948204f*(-11.f*rho+19.f*usqr)+-0.015873016f*m2 +( 0.1666666667f*u)                +0.055555556f*(2.f*u*u-(v*v+w*w))                          );
	f2 =SF*f2 +(1.0f-SF)*(0.052631579f*rho+-0.0045948204f*(-11.f*rho+19.f*usqr)+-0.015873016f*m2 +( 0.1666666667f*v)                -0.027777778f*(2.f*u*u-(v*v+w*w))  +0.0833333333f*(v*v-w*w)            );
	f3 =SF*f3 +(1.0f-SF)*(0.052631579f*rho+-0.0045948204f*(-11.f*rho+19.f*usqr)+-0.015873016f*m2 +(-0.1666666667f*u)                +0.055555556f*(2.f*u*u-(v*v+w*w))                          );
	f4 =SF*f4 +(1.0f-SF)*(0.052631579f*rho+-0.0045948204f*(-11.f*rho+19.f*usqr)+-0.015873016f*m2 +(-0.1666666667f*v)                -0.027777778f*(2.f*u*u-(v*v+w*w))  +0.0833333333f*(v*v-w*w)            );
	f5 =SF*f5 +(1.0f-SF)*(0.052631579f*rho+ 0.0033416876f*(-11.f*rho+19.f*usqr)+ 0.003968254f*m2 +0.1f*( u+v)+0.01666666667f*(-u-v) +0.027777778f*(2.f*u*u-(v*v+w*w))  +0.0833333333f*(v*v-w*w)+0.25f*(u*v)    );
	f6 =SF*f6 +(1.0f-SF)*(0.052631579f*rho+ 0.0033416876f*(-11.f*rho+19.f*usqr)+ 0.003968254f*m2 +0.1f*(-u+v)+0.01666666667f*( u-v) +0.027777778f*(2.f*u*u-(v*v+w*w))  +0.0833333333f*(v*v-w*w)-0.25f*(u*v)    );
	f7 =SF*f7 +(1.0f-SF)*(0.052631579f*rho+ 0.0033416876f*(-11.f*rho+19.f*usqr)+ 0.003968254f*m2 +0.1f*(-u-v)+0.01666666667f*( u+v) +0.027777778f*(2.f*u*u-(v*v+w*w))  +0.0833333333f*(v*v-w*w)+0.25f*(u*v)    );
	f8 =SF*f8 +(1.0f-SF)*(0.052631579f*rho+ 0.0033416876f*(-11.f*rho+19.f*usqr)+ 0.003968254f*m2 +0.1f*( u-v)+0.01666666667f*(-u+v) +0.027777778f*(2.f*u*u-(v*v+w*w))  +0.0833333333f*(v*v-w*w)-0.25f*(u*v)    );
	f9 =SF*f9 +(1.0f-SF)*(0.052631579f*rho+-0.0045948204f*(-11.f*rho+19.f*usqr)+-0.015873016f*m2 +( 0.1666666667f*w)                -0.027777778f*(2.f*u*u-(v*v+w*w))  -0.0833333333f*(v*v-w*w)            );
	f10=SF*f10+(1.0f-SF)*(0.052631579f*rho+ 0.0033416876f*(-11.f*rho+19.f*usqr)+ 0.003968254f*m2 +0.1f*( u+w)+0.01666666667f*(-u-w) +0.027777778f*(2.f*u*u-(v*v+w*w))  -0.0833333333f*(v*v-w*w)      +0.25f*u*v);
	f11=SF*f11+(1.0f-SF)*(0.052631579f*rho+ 0.0033416876f*(-11.f*rho+19.f*usqr)+ 0.003968254f*m2 +0.1f*( v+w)+0.01666666667f*(-v-w) -0.055555556f*(2.f*u*u-(v*v+w*w))                         +0.25f*v*w      );
	f12=SF*f12+(1.0f-SF)*(0.052631579f*rho+ 0.0033416876f*(-11.f*rho+19.f*usqr)+ 0.003968254f*m2 +0.1f*(-u+w)+0.01666666667f*( u-w) +0.027777778f*(2.f*u*u-(v*v+w*w))  -0.0833333333f*(v*v-w*w)      -0.25f*u*v);
	f13=SF*f13+(1.0f-SF)*(0.052631579f*rho+ 0.0033416876f*(-11.f*rho+19.f*usqr)+ 0.003968254f*m2 +0.1f*(-v+w)+0.01666666667f*(-v-w) -0.055555556f*(2.f*u*u-(v*v+w*w))                         -0.25f*v*w      );
	f14=SF*f14+(1.0f-SF)*(0.052631579f*rho+-0.0045948204f*(-11.f*rho+19.f*usqr)+-0.015873016f*m2 +(-0.1666666667f*w)                +0.027777778f*(2.f*u*u-(v*v+w*w))  +0.0833333333f*(v*v-w*w)            );
	f15=SF*f15+(1.0f-SF)*(0.052631579f*rho+ 0.0033416876f*(-11.f*rho+19.f*usqr)+ 0.003968254f*m2 +0.1f*( u-w)+0.01666666667f*(-u+w) +0.027777778f*(2.f*u*u-(v*v+w*w))  -0.0833333333f*(v*v-w*w)      +0.25f*u*v);
	f16=SF*f16+(1.0f-SF)*(0.052631579f*rho+ 0.0033416876f*(-11.f*rho+19.f*usqr)+ 0.003968254f*m2 +0.1f*( v-w)+0.01666666667f*(-v+w) -0.055555556f*(2.f*u*u-(v*v+w*w))                         +0.25f*v*w      );
	f17=SF*f17+(1.0f-SF)*(0.052631579f*rho+ 0.0033416876f*(-11.f*rho+19.f*usqr)+ 0.003968254f*m2 +0.1f*(-u-w)+0.01666666667f*( u+w) +0.027777778f*(2.f*u*u-(v*v+w*w))  -0.0833333333f*(v*v-w*w)      +0.25f*u*v);
	f18=SF*f18+(1.0f-SF)*(0.052631579f*rho+ 0.0033416876f*(-11.f*rho+19.f*usqr)+ 0.003968254f*m2 +0.1f*(-v-w)+0.01666666667f*(-v+w) -0.055555556f*(2.f*u*u-(v*v+w*w))                         +0.25f*v*w      );
	}
	else
	{

	//scale
	f0 =SF*f0 +(1.0f-SF)*(0.3333333333f*(rho-1.5f*usqr));
	f1 =SF*f1 +(1.0f-SF)*(0.0555555556f*(rho+3.0f*u+4.5f*u*u-1.5f*usqr));                
	f2 =SF*f2 +(1.0f-SF)*(0.0555555556f*(rho+3.0f*v+4.5f*v*v-1.5f*usqr));
	f3 =SF*f3 +(1.0f-SF)*(0.0555555556f*(rho-3.0f*u+4.5f*u*u-1.5f*usqr));
	f4 =SF*f4 +(1.0f-SF)*(0.0555555556f*(rho-3.0f*v+4.5f*v*v-1.5f*usqr));
	f5 =SF*f5 +(1.0f-SF)*(0.0277777778f*(rho+3.0f*(u+v)+4.5f*(u+v)*(u+v)-1.5f*usqr));
	f6 =SF*f6 +(1.0f-SF)*(0.0277777778f*(rho+3.0f*(-u+v)+4.5f*(-u+v)*(-u+v)-1.5f*usqr));
	f7 =SF*f7 +(1.0f-SF)*(0.0277777778f*(rho+3.0f*(-u-v)+4.5f*(-u-v)*(-u-v)-1.5f*usqr));
	f8 =SF*f8 +(1.0f-SF)*(0.0277777778f*(rho+3.0f*(u-v)+4.5f*(u-v)*(u-v)-1.5f*usqr));
	f9 =SF*f9 +(1.0f-SF)*(0.0555555556f*(rho+3.0f*w+4.5f*w*w-1.5f*usqr));
	f10=SF*f10+(1.0f-SF)*(0.0277777778f*(rho+3.0f*(u+w)+4.5f*(u+w)*(u+w)-1.5f*usqr));
	f11=SF*f11+(1.0f-SF)*(0.0277777778f*(rho+3.0f*(v+w)+4.5f*(v+w)*(u+w)-1.5f*usqr));
	f12=SF*f12+(1.0f-SF)*(0.0277777778f*(rho+3.0f*(-u+w)+4.5f*(-u+w)*(-u+w)-1.5f*usqr));
	f13=SF*f13+(1.0f-SF)*(0.0277777778f*(rho+3.0f*(-v+w)+4.5f*(-v+w)*(u+w)-1.5f*usqr));
	f14=SF*f14+(1.0f-SF)*(0.0555555556f*(rho-3.0f*w+4.5f*w*w-1.5f*usqr));
	f15=SF*f15+(1.0f-SF)*(0.0277777778f*(rho+3.0f*(u-w)+4.5f*(u-w)*(u-w)-1.5f*usqr));
	f16=SF*f16+(1.0f-SF)*(0.0277777778f*(rho+3.0f*(v-w)+4.5f*(v-w)*(v-w)-1.5f*usqr));
	f17=SF*f17+(1.0f-SF)*(0.0277777778f*(rho+3.0f*(-u-w)+4.5f*(-u-w)*(-u-w)-1.5f*usqr));
	f18=SF*f18+(1.0f-SF)*(0.0277777778f*(rho+3.0f*(-v-w)+4.5f*(-v-w)*(-v-w)-1.5f*usqr));
	}

	fout[f_memLR(0 ,x,y,z,pitch)] = f0 ;
	fout[f_memLR(1 ,x,y,z,pitch)] = f1 ;
	fout[f_memLR(2 ,x,y,z,pitch)] = f2 ;
	fout[f_memLR(3 ,x,y,z,pitch)] = f3 ;
	fout[f_memLR(4 ,x,y,z,pitch)] = f4 ;
	fout[f_memLR(5 ,x,y,z,pitch)] = f5 ;
	fout[f_memLR(6 ,x,y,z,pitch)] = f6 ;
	fout[f_memLR(7 ,x,y,z,pitch)] = f7 ;
	fout[f_memLR(8 ,x,y,z,pitch)] = f8 ;
	fout[f_memLR(9 ,x,y,z,pitch)] = f9 ;
	fout[f_memLR(10,x,y,z,pitch)] = f10;
	fout[f_memLR(11,x,y,z,pitch)] = f11;
	fout[f_memLR(12,x,y,z,pitch)] = f12;
	fout[f_memLR(13,x,y,z,pitch)] = f13;
	fout[f_memLR(14,x,y,z,pitch)] = f14;
	fout[f_memLR(15,x,y,z,pitch)] = f15;
	fout[f_memLR(16,x,y,z,pitch)] = f16;
	fout[f_memLR(17,x,y,z,pitch)] = f17;
	fout[f_memLR(18,x,y,z,pitch)] = f18;
	}
	else{
	f0 = fin[j];
	f1 = fin[f_memLR(1 ,x-1,y  ,z  ,pitch)];
	f3 = fin[f_memLR(3 ,x+1,y  ,z  ,pitch)];
	f2 = fin[f_memLR(2 ,x  ,y-1,z  ,pitch)];
	f5 = fin[f_memLR(5 ,x-1,y-1,z  ,pitch)];
	f6 = fin[f_memLR(6 ,x+1,y-1,z  ,pitch)];
	f4 = fin[f_memLR(4 ,x  ,y+1,z  ,pitch)];
	f7 = fin[f_memLR(7 ,x+1,y+1,z  ,pitch)];
	f8 = fin[f_memLR(8 ,x-1,y+1,z  ,pitch)];
	f9 = fin[f_memLR(9 ,x  ,y  ,z-1,pitch)];
	f10= fin[f_memLR(10,x-1,y  ,z-1,pitch)];
	f11= fin[f_memLR(11,x  ,y-1,z-1,pitch)];
	f12= fin[f_memLR(12,x+1,y  ,z-1,pitch)];
	f13= fin[f_memLR(13,x  ,y+1,z-1,pitch)];
	f14= fin[f_memLR(14,x  ,y  ,z+1,pitch)];
	f15= fin[f_memLR(15,x-1,y  ,z+1,pitch)];
	f16= fin[f_memLR(16,x  ,y-1,z+1,pitch)];
	f17= fin[f_memLR(17,x+1,y  ,z+1,pitch)];
	//if(z != ZLRDIM-1){
	f18= fin[f_memLR(18,x  ,dmin(y+1,YLRDIM),dmin(z+1,ZLRDIM),pitch)];
	//}
	//else f18 = 0.1f;
	if(im == 1){//BB
		fout[f_memLR(1 ,x,y,z,pitch)] = f3 ;
		fout[f_memLR(2 ,x,y,z,pitch)] = f4 ;
		fout[f_memLR(3 ,x,y,z,pitch)] = f1 ;
		fout[f_memLR(4 ,x,y,z,pitch)] = f2 ;
		fout[f_memLR(5 ,x,y,z,pitch)] = f7 ;
		fout[f_memLR(6 ,x,y,z,pitch)] = f8 ;
		fout[f_memLR(7 ,x,y,z,pitch)] = f5 ;
		fout[f_memLR(8 ,x,y,z,pitch)] = f6 ;
		fout[f_memLR(9 ,x,y,z,pitch)] = f14;
		fout[f_memLR(10,x,y,z,pitch)] = f17;
		fout[f_memLR(11,x,y,z,pitch)] = f18;
		fout[f_memLR(12,x,y,z,pitch)] = f15;
		fout[f_memLR(13,x,y,z,pitch)] = f16;
		fout[f_memLR(14,x,y,z,pitch)] = f9 ;
		fout[f_memLR(15,x,y,z,pitch)] = f12;
		fout[f_memLR(16,x,y,z,pitch)] = f13;
		fout[f_memLR(17,x,y,z,pitch)] = f10;
		fout[f_memLR(18,x,y,z,pitch)] = f11;
	}
	else{
		if(MODEL == "MRT")
		mrt_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,omega);
		else if(MODEL == "BGK")
		bgk_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,omega);

		fout[f_memLR(0 ,x,y,z,pitch)] = f0 ;
		fout[f_memLR(1 ,x,y,z,pitch)] = f1 ;
		fout[f_memLR(2 ,x,y,z,pitch)] = f2 ;
		fout[f_memLR(3 ,x,y,z,pitch)] = f3 ;
		fout[f_memLR(4 ,x,y,z,pitch)] = f4 ;
		fout[f_memLR(5 ,x,y,z,pitch)] = f5 ;
		fout[f_memLR(6 ,x,y,z,pitch)] = f6 ;
		fout[f_memLR(7 ,x,y,z,pitch)] = f7 ;
		fout[f_memLR(8 ,x,y,z,pitch)] = f8 ;
		fout[f_memLR(9 ,x,y,z,pitch)] = f9 ;
		fout[f_memLR(10,x,y,z,pitch)] = f10;
		fout[f_memLR(11,x,y,z,pitch)] = f11;
		fout[f_memLR(12,x,y,z,pitch)] = f12;
		fout[f_memLR(13,x,y,z,pitch)] = f13;
		fout[f_memLR(14,x,y,z,pitch)] = f14;
		fout[f_memLR(15,x,y,z,pitch)] = f15;
		fout[f_memLR(16,x,y,z,pitch)] = f16;
		fout[f_memLR(17,x,y,z,pitch)] = f17;
		fout[f_memLR(18,x,y,z,pitch)] = f18;
	}
	}//end else (not at edge of LR)
}


__global__ void mrt_d_hybAB(float* fin, float* fout,
							float omega, size_t pitch)//pitch in elements
{
	int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
	int y = threadIdx.y+blockIdx.y*blockDim.y;//;
	int z = threadIdx.z+blockIdx.z*blockDim.z;
	int j = x+y*pitch+z*YDIM*pitch;//index on padded mem (pitch in elements)
	float f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18;
	f0 = fin[j];
	f2 = fin[f_mem(2 ,x  ,y-1,z  ,pitch)];
	f4 = fin[f_mem(4 ,x  ,y+1,z  ,pitch)];
	f9 = fin[f_mem(9 ,x  ,y  ,z-1,pitch)];
	f11= fin[f_mem(11,x  ,y-1,z-1,pitch)];
	f13= fin[f_mem(13,x  ,y+1,z-1,pitch)];
	f14= fin[f_mem(14,x  ,y  ,z+1,pitch)];
	f16= fin[f_mem(16,x  ,y-1,z+1,pitch)];
	if(z != ZDIM-1){
	f18= fin[f_mem(18,x  ,y+1,z+1,pitch)];
	}
	f1 = tex2D(texRef_f1A ,x-1+0.5f,y  +0.5f+YDIM*(z));
	f3 = tex2D(texRef_f3A ,x+1+0.5f,y  +0.5f+YDIM*(z));
	f5 = tex2D(texRef_f5A ,x-1+0.5f,y-1+0.5f+YDIM*(z));
	f6 = tex2D(texRef_f6A ,x+1+0.5f,y-1+0.5f+YDIM*(z));
	f7 = tex2D(texRef_f7A ,x+1+0.5f,y+1+0.5f+YDIM*(z));
	f8 = tex2D(texRef_f8A ,x-1+0.5f,y+1+0.5f+YDIM*(z));
	f15= tex2D(texRef_f15A,x-1+0.5f,y  +0.5f+YDIM*(z+1));
	f17= tex2D(texRef_f17A,x+1+0.5f,y  +0.5f+YDIM*(z+1));
	f10= tex2D(texRef_f10A,x-1+0.5f,y  +0.5f+YDIM*(z-1));
	f12= tex2D(texRef_f12A,x+1+0.5f,y  +0.5f+YDIM*(z-1));


	int im = ImageFcn(x,y,z);
	if(im == 1){//BB
		fout[j+pitch*YDIM*ZDIM*1 ] = f3 ;
		fout[j+pitch*YDIM*ZDIM*2 ] = f4 ;
		fout[j+pitch*YDIM*ZDIM*3 ] = f1 ;
		fout[j+pitch*YDIM*ZDIM*4 ] = f2 ;
		fout[j+pitch*YDIM*ZDIM*5 ] = f7 ;
		fout[j+pitch*YDIM*ZDIM*6 ] = f8 ;
		fout[j+pitch*YDIM*ZDIM*7 ] = f5 ;
		fout[j+pitch*YDIM*ZDIM*8 ] = f6 ;
		fout[j+pitch*YDIM*ZDIM*9 ] = f14;
		fout[j+pitch*YDIM*ZDIM*10] = f17;
		fout[j+pitch*YDIM*ZDIM*11] = f18;
		fout[j+pitch*YDIM*ZDIM*12] = f15;
		fout[j+pitch*YDIM*ZDIM*13] = f16;
		fout[j+pitch*YDIM*ZDIM*14] = f9 ;
		fout[j+pitch*YDIM*ZDIM*15] = f12;
		fout[j+pitch*YDIM*ZDIM*16] = f13;
		fout[j+pitch*YDIM*ZDIM*17] = f10;
		fout[j+pitch*YDIM*ZDIM*18] = f11;
	}
	else{
		if(im == 3)//DirichletWest
		{
			if(y == 0){
				f2 = f4;
				f6 = f7;
				f11 = f13;
				f16 = f18;
			}
			else if(y == YDIM-1){
				f4 = f2;
				f7 = f6;
				f13 = f11;
				f18 = f16;
			}
			if(z == 0){
				f9  = f14;
				f10 = f15;
				f11 = f16;
				f12 = f17;
				f13 = f18;			
			}    
			else if(z == ZDIM-1){
				f14 = f9;
				f15 = f10;
				f16 = f11;
				f17 = f12;
				f18 = f13;
			}
			float u,v,w;//,rho;
	        u = 0.0f;//*PoisProf(zcoord)*1.5;
	        v = UMAX;//0.0;
			w = 0.0f;
	        
        	//rho = u+(f0+f2+f4+f9+f11+f13+f14+f16+f18+2.0f*(f3+f6+f7+f12+f17)); //D2Q9i

			f1 = fma(0.0555555556f,6.0f*u,f3);//0.0555555556f*(6.0f*u)+f3;//-0.0555555556f*(rho-3.0f*u+4.5f*u*u-1.5f*usqr);;
			f5 = fma(0.0277777778f,6.0f*(u+v),f7 );// -0.0277777778f*(rho+3.0f*(-u-v)+4.5f*(-u-v)*(-u-v)-1.5f*usqr);
			f8 = fma(0.0277777778f,6.0f*(u-v),f6 );// -0.0277777778f*(rho+3.0f*(-u+v)+4.5f*(-u+v)*(-u+v)-1.5f*usqr);
			f10= fma(0.0277777778f,6.0f*(u+w),f17);//-0.0277777778f*(rho+3.0f*(-u-w)+4.5f*(-u-w)*(-u-w)-1.5f*usqr);
			f15= fma(0.0277777778f,6.0f*(u-w),f12);//-0.0277777778f*(rho+3.0f*(-u+w)+4.5f*(-u+w)*(-u+w)-1.5f*usqr);

		}

		if(MODEL == "MRT")
		mrt_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,omega);
		else if(MODEL == "BGK")
		bgk_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,omega);


		fout[f_mem(0 ,x,y,z,pitch)] = f0 ;
		fout[f_mem(1 ,x,y,z,pitch)] = f1 ;
		fout[f_mem(2 ,x,y,z,pitch)] = f2 ;
		fout[f_mem(3 ,x,y,z,pitch)] = f3 ;
		fout[f_mem(4 ,x,y,z,pitch)] = f4 ;
		fout[f_mem(5 ,x,y,z,pitch)] = f5 ;
		fout[f_mem(6 ,x,y,z,pitch)] = f6 ;
		fout[f_mem(7 ,x,y,z,pitch)] = f7 ;
		fout[f_mem(8 ,x,y,z,pitch)] = f8 ;
		fout[f_mem(9 ,x,y,z,pitch)] = f9 ;
		fout[f_mem(10,x,y,z,pitch)] = f10;
		fout[f_mem(11,x,y,z,pitch)] = f11;
		fout[f_mem(12,x,y,z,pitch)] = f12;
		fout[f_mem(13,x,y,z,pitch)] = f13;
		fout[f_mem(14,x,y,z,pitch)] = f14;
		fout[f_mem(15,x,y,z,pitch)] = f15;
		fout[f_mem(16,x,y,z,pitch)] = f16;
		fout[f_mem(17,x,y,z,pitch)] = f17;
		fout[f_mem(18,x,y,z,pitch)] = f18;
	}
}
__global__ void mrt_d_hybBA(float* fin, float* fout,
							float omega, size_t pitch)//pitch in elements
{
	int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
	int y = threadIdx.y+blockIdx.y*blockDim.y;
	int z = threadIdx.z+blockIdx.z*blockDim.z;
	int j = x+y*pitch+z*YDIM*pitch;//index on padded mem (pitch in elements)
	float f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18;
	f0 = fin[j];
	f2 = fin[f_mem(2 ,x  ,y-1,z  ,pitch)];
	f4 = fin[f_mem(4 ,x  ,y+1,z  ,pitch)];
	f9 = fin[f_mem(9 ,x  ,y  ,z-1,pitch)];
	f11= fin[f_mem(11,x  ,y-1,z-1,pitch)];
	f13= fin[f_mem(13,x  ,y+1,z-1,pitch)];
	f14= fin[f_mem(14,x  ,y  ,z+1,pitch)];
	f16= fin[f_mem(16,x  ,y-1,z+1,pitch)];
	if(z != ZDIM-1){
	f18= fin[f_mem(18,x  ,y+1,z+1,pitch)];
	}
	f1 = tex2D(texRef_f1B ,x-1+0.5f,y  +0.5f+YDIM*(z));
	f3 = tex2D(texRef_f3B ,x+1+0.5f,y  +0.5f+YDIM*(z));
	f5 = tex2D(texRef_f5B ,x-1+0.5f,y-1+0.5f+YDIM*(z));
	f6 = tex2D(texRef_f6B ,x+1+0.5f,y-1+0.5f+YDIM*(z));
	f7 = tex2D(texRef_f7B ,x+1+0.5f,y+1+0.5f+YDIM*(z));
	f8 = tex2D(texRef_f8B ,x-1+0.5f,y+1+0.5f+YDIM*(z));
	f15= tex2D(texRef_f15B,x-1+0.5f,y  +0.5f+YDIM*(z+1));
	f17= tex2D(texRef_f17B,x+1+0.5f,y  +0.5f+YDIM*(z+1));
	f10= tex2D(texRef_f10B,x-1+0.5f,y  +0.5f+YDIM*(z-1));
	f12= tex2D(texRef_f12B,x+1+0.5f,y  +0.5f+YDIM*(z-1));


	int im = ImageFcn(x,y,z);
	if(im == 1){//BB
		fout[j+pitch*YDIM*ZDIM*1 ] = f3 ;
		fout[j+pitch*YDIM*ZDIM*2 ] = f4 ;
		fout[j+pitch*YDIM*ZDIM*3 ] = f1 ;
		fout[j+pitch*YDIM*ZDIM*4 ] = f2 ;
		fout[j+pitch*YDIM*ZDIM*5 ] = f7 ;
		fout[j+pitch*YDIM*ZDIM*6 ] = f8 ;
		fout[j+pitch*YDIM*ZDIM*7 ] = f5 ;
		fout[j+pitch*YDIM*ZDIM*8 ] = f6 ;
		fout[j+pitch*YDIM*ZDIM*9 ] = f14;
		fout[j+pitch*YDIM*ZDIM*10] = f17;
		fout[j+pitch*YDIM*ZDIM*11] = f18;
		fout[j+pitch*YDIM*ZDIM*12] = f15;
		fout[j+pitch*YDIM*ZDIM*13] = f16;
		fout[j+pitch*YDIM*ZDIM*14] = f9 ;
		fout[j+pitch*YDIM*ZDIM*15] = f12;
		fout[j+pitch*YDIM*ZDIM*16] = f13;
		fout[j+pitch*YDIM*ZDIM*17] = f10;
		fout[j+pitch*YDIM*ZDIM*18] = f11;
	}
	else{
		if(im == 3)//DirichletWest
		{
			if(y == 0){
				f2 = f4;
				f6 = f7;
				f11 = f13;
				f16 = f18;
			}
			else if(y == YDIM-1){
				f4 = f2;
				f7 = f6;
				f13 = f11;
				f18 = f16;
			}
			if(z == 0){
				f9  = f14;
				f10 = f15;
				f11 = f16;
				f12 = f17;
				f13 = f18;			
			}    
			else if(z == ZDIM-1){
				f14 = f9;
				f15 = f10;
				f16 = f11;
				f17 = f12;
				f18 = f13;
			}
			float u,v,w;//,rho;
	        u = 0.0f;//*PoisProf(zcoord)*1.5;
	        v = UMAX;//0.0;
			w = 0.0f;
	        
        	//rho = u+(f0+f2+f4+f9+f11+f13+f14+f16+f18+2.0f*(f3+f6+f7+f12+f17)); //D2Q9i

			f1 = fma(0.0555555556f,6.0f*u,f3);//0.0555555556f*(6.0f*u)+f3;//-0.0555555556f*(rho-3.0f*u+4.5f*u*u-1.5f*usqr);;
			f5 = fma(0.0277777778f,6.0f*(u+v),f7 );// -0.0277777778f*(rho+3.0f*(-u-v)+4.5f*(-u-v)*(-u-v)-1.5f*usqr);
			f8 = fma(0.0277777778f,6.0f*(u-v),f6 );// -0.0277777778f*(rho+3.0f*(-u+v)+4.5f*(-u+v)*(-u+v)-1.5f*usqr);
			f10= fma(0.0277777778f,6.0f*(u+w),f17);//-0.0277777778f*(rho+3.0f*(-u-w)+4.5f*(-u-w)*(-u-w)-1.5f*usqr);
			f15= fma(0.0277777778f,6.0f*(u-w),f12);//-0.0277777778f*(rho+3.0f*(-u+w)+4.5f*(-u+w)*(-u+w)-1.5f*usqr);
		}

		if(MODEL == "MRT")
		mrt_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,omega);
		else if(MODEL == "BGK")
		bgk_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,omega);

		fout[f_mem(0 ,x,y,z,pitch)] = f0 ;
		fout[f_mem(1 ,x,y,z,pitch)] = f1 ;
		fout[f_mem(2 ,x,y,z,pitch)] = f2 ;
		fout[f_mem(3 ,x,y,z,pitch)] = f3 ;
		fout[f_mem(4 ,x,y,z,pitch)] = f4 ;
		fout[f_mem(5 ,x,y,z,pitch)] = f5 ;
		fout[f_mem(6 ,x,y,z,pitch)] = f6 ;
		fout[f_mem(7 ,x,y,z,pitch)] = f7 ;
		fout[f_mem(8 ,x,y,z,pitch)] = f8 ;
		fout[f_mem(9 ,x,y,z,pitch)] = f9 ;
		fout[f_mem(10,x,y,z,pitch)] = f10;
		fout[f_mem(11,x,y,z,pitch)] = f11;
		fout[f_mem(12,x,y,z,pitch)] = f12;
		fout[f_mem(13,x,y,z,pitch)] = f13;
		fout[f_mem(14,x,y,z,pitch)] = f14;
		fout[f_mem(15,x,y,z,pitch)] = f15;
		fout[f_mem(16,x,y,z,pitch)] = f16;
		fout[f_mem(17,x,y,z,pitch)] = f17;
		fout[f_mem(18,x,y,z,pitch)] = f18;
	}
}


__global__ void mrt_d_textAB(float* fin, float* fout,
							float omega, size_t pitch)//pitch in elements
{
	int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
	int y = threadIdx.y+blockIdx.y*blockDim.y;
	int z = threadIdx.z+blockIdx.z*blockDim.z;
	int j = x+y*pitch+z*YDIM*pitch;//index on padded mem (pitch in elements)
	float f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18;
	f0 = fin[j];
	f2 = tex2D(texRef_f2A ,x  ,y-1+YDIM*(z));
	f4 = tex2D(texRef_f4A ,x  ,y+1+YDIM*(z));
	f9 = tex2D(texRef_f9A ,x  ,y+1+YDIM*(z-1));
	f11= tex2D(texRef_f11A,x  ,y-1+YDIM*(z-1));
	f13= tex2D(texRef_f13A,x  ,y+1+YDIM*(z-1));
	f14= tex2D(texRef_f14A,x  ,y  +YDIM*(z+1));
	f16= tex2D(texRef_f16A,x  ,y-1+YDIM*(z+1));
	f18= tex2D(texRef_f18A,x  ,y+1+YDIM*(z+1));

	f1 = tex2D(texRef_f1A ,x-1,y  +YDIM*(z));
	f3 = tex2D(texRef_f3A ,x+1,y  +YDIM*(z));
	f5 = tex2D(texRef_f5A ,x-1,y-1+YDIM*(z));
	f6 = tex2D(texRef_f6A ,x+1,y-1+YDIM*(z));
	f7 = tex2D(texRef_f7A ,x+1,y+1+YDIM*(z));
	f8 = tex2D(texRef_f8A ,x-1,y+1+YDIM*(z));
	f15= tex2D(texRef_f15A,x-1,y  +YDIM*(z+1));
	f17= tex2D(texRef_f17A,x+1,y  +YDIM*(z+1));
	f10= tex2D(texRef_f10A,x-1,y  +YDIM*(z-1));
	f12= tex2D(texRef_f12A,x+1,y  +YDIM*(z-1));


	int im = ImageFcn(x,y,z);
	if(im == 1){//BB
		fout[j+pitch*YDIM*ZDIM*1 ] = f3 ;
		fout[j+pitch*YDIM*ZDIM*2 ] = f4 ;
		fout[j+pitch*YDIM*ZDIM*3 ] = f1 ;
		fout[j+pitch*YDIM*ZDIM*4 ] = f2 ;
		fout[j+pitch*YDIM*ZDIM*5 ] = f7 ;
		fout[j+pitch*YDIM*ZDIM*6 ] = f8 ;
		fout[j+pitch*YDIM*ZDIM*7 ] = f5 ;
		fout[j+pitch*YDIM*ZDIM*8 ] = f6 ;
		fout[j+pitch*YDIM*ZDIM*9 ] = f14;
		fout[j+pitch*YDIM*ZDIM*10] = f17;
		fout[j+pitch*YDIM*ZDIM*11] = f18;
		fout[j+pitch*YDIM*ZDIM*12] = f15;
		fout[j+pitch*YDIM*ZDIM*13] = f16;
		fout[j+pitch*YDIM*ZDIM*14] = f9 ;
		fout[j+pitch*YDIM*ZDIM*15] = f12;
		fout[j+pitch*YDIM*ZDIM*16] = f13;
		fout[j+pitch*YDIM*ZDIM*17] = f10;
		fout[j+pitch*YDIM*ZDIM*18] = f11;
	}
	else{
		if(im == 3)//DirichletWest
		{
			if(y == 0){
				f2 = f4;
				f6 = f7;
				f11 = f13;
				f16 = f18;
			}
			else if(y == YDIM-1){
				f4 = f2;
				f7 = f6;
				f13 = f11;
				f18 = f16;
			}
			if(z == 0){
				f9  = f14;
				f10 = f15;
				f11 = f16;
				f12 = f17;
				f13 = f18;			
			}    
			else if(z == ZDIM-1){
				f14 = f9;
				f15 = f10;
				f16 = f11;
				f17 = f12;
				f18 = f13;
			}
			float u,v,w;//,rho;
	        u = 0.0f;//*PoisProf(zcoord)*1.5;
	        v = UMAX;//0.0;
			w = 0.0f;
	        
        	//rho = u+(f0+f2+f4+f9+f11+f13+f14+f16+f18+2.0f*(f3+f6+f7+f12+f17)); //D2Q9i

			f1 = fma(0.0555555556f,6.0f*u,f3);//0.0555555556f*(6.0f*u)+f3;//-0.0555555556f*(rho-3.0f*u+4.5f*u*u-1.5f*usqr);;
			f5 = fma(0.0277777778f,6.0f*(u+v),f7 );// -0.0277777778f*(rho+3.0f*(-u-v)+4.5f*(-u-v)*(-u-v)-1.5f*usqr);
			f8 = fma(0.0277777778f,6.0f*(u-v),f6 );// -0.0277777778f*(rho+3.0f*(-u+v)+4.5f*(-u+v)*(-u+v)-1.5f*usqr);
			f10= fma(0.0277777778f,6.0f*(u+w),f17);//-0.0277777778f*(rho+3.0f*(-u-w)+4.5f*(-u-w)*(-u-w)-1.5f*usqr);
			f15= fma(0.0277777778f,6.0f*(u-w),f12);//-0.0277777778f*(rho+3.0f*(-u+w)+4.5f*(-u+w)*(-u+w)-1.5f*usqr);
		}

		if(MODEL == "MRT")
		mrt_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,omega);
		else if(MODEL == "BGK")
		bgk_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,omega);

		fout[f_mem(0 ,x,y,z,pitch)] = f0 ;
		fout[f_mem(1 ,x,y,z,pitch)] = f1 ;
		fout[f_mem(2 ,x,y,z,pitch)] = f2 ;
		fout[f_mem(3 ,x,y,z,pitch)] = f3 ;
		fout[f_mem(4 ,x,y,z,pitch)] = f4 ;
		fout[f_mem(5 ,x,y,z,pitch)] = f5 ;
		fout[f_mem(6 ,x,y,z,pitch)] = f6 ;
		fout[f_mem(7 ,x,y,z,pitch)] = f7 ;
		fout[f_mem(8 ,x,y,z,pitch)] = f8 ;
		fout[f_mem(9 ,x,y,z,pitch)] = f9 ;
		fout[f_mem(10,x,y,z,pitch)] = f10;
		fout[f_mem(11,x,y,z,pitch)] = f11;
		fout[f_mem(12,x,y,z,pitch)] = f12;
		fout[f_mem(13,x,y,z,pitch)] = f13;
		fout[f_mem(14,x,y,z,pitch)] = f14;
		fout[f_mem(15,x,y,z,pitch)] = f15;
		fout[f_mem(16,x,y,z,pitch)] = f16;
		fout[f_mem(17,x,y,z,pitch)] = f17;
		fout[f_mem(18,x,y,z,pitch)] = f18;
	}
}

__global__ void mrt_d_textBA(float* fin, float* fout,
							float omega, size_t pitch)//pitch in elements
{
	int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
	int y = threadIdx.y+blockIdx.y*blockDim.y;
	int z = threadIdx.z+blockIdx.z*blockDim.z;
	int j = x+y*pitch+z*YDIM*pitch;//index on padded mem (pitch in elements)
	float f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18;
	f0 = fin[j];
	f2 = tex2D(texRef_f2B ,x  ,y-1+YDIM*(z));
	f4 = tex2D(texRef_f4B ,x  ,y+1+YDIM*(z));
	f9 = tex2D(texRef_f9B ,x  ,y+1+YDIM*(z-1));
	f11= tex2D(texRef_f11B,x  ,y-1+YDIM*(z-1));
	f13= tex2D(texRef_f13B,x  ,y+1+YDIM*(z-1));
	f14= tex2D(texRef_f14B,x  ,y  +YDIM*(z+1));
	f16= tex2D(texRef_f16B,x  ,y-1+YDIM*(z+1));
	f18= tex2D(texRef_f18B,x  ,y+1+YDIM*(z+1));

	f1 = tex2D(texRef_f1B ,x-1,y  +YDIM*(z));
	f3 = tex2D(texRef_f3B ,x+1,y  +YDIM*(z));
	f5 = tex2D(texRef_f5B ,x-1,y-1+YDIM*(z));
	f6 = tex2D(texRef_f6B ,x+1,y-1+YDIM*(z));
	f7 = tex2D(texRef_f7B ,x+1,y+1+YDIM*(z));
	f8 = tex2D(texRef_f8B ,x-1,y+1+YDIM*(z));
	f15= tex2D(texRef_f15B,x-1,y  +YDIM*(z+1));
	f17= tex2D(texRef_f17B,x+1,y  +YDIM*(z+1));
	f10= tex2D(texRef_f10B,x-1,y  +YDIM*(z-1));
	f12= tex2D(texRef_f12B,x+1,y  +YDIM*(z-1));


	int im = ImageFcn(x,y,z);
	if(im == 1){//BB
		fout[j+pitch*YDIM*ZDIM*1 ] = f3 ;
		fout[j+pitch*YDIM*ZDIM*2 ] = f4 ;
		fout[j+pitch*YDIM*ZDIM*3 ] = f1 ;
		fout[j+pitch*YDIM*ZDIM*4 ] = f2 ;
		fout[j+pitch*YDIM*ZDIM*5 ] = f7 ;
		fout[j+pitch*YDIM*ZDIM*6 ] = f8 ;
		fout[j+pitch*YDIM*ZDIM*7 ] = f5 ;
		fout[j+pitch*YDIM*ZDIM*8 ] = f6 ;
		fout[j+pitch*YDIM*ZDIM*9 ] = f14;
		fout[j+pitch*YDIM*ZDIM*10] = f17;
		fout[j+pitch*YDIM*ZDIM*11] = f18;
		fout[j+pitch*YDIM*ZDIM*12] = f15;
		fout[j+pitch*YDIM*ZDIM*13] = f16;
		fout[j+pitch*YDIM*ZDIM*14] = f9 ;
		fout[j+pitch*YDIM*ZDIM*15] = f12;
		fout[j+pitch*YDIM*ZDIM*16] = f13;
		fout[j+pitch*YDIM*ZDIM*17] = f10;
		fout[j+pitch*YDIM*ZDIM*18] = f11;
	}
	else{
		if(im == 3)//DirichletWest
		{
			if(y == 0){
				f2 = f4;
				f6 = f7;
				f11 = f13;
				f16 = f18;
			}
			else if(y == YDIM-1){
				f4 = f2;
				f7 = f6;
				f13 = f11;
				f18 = f16;
			}
			if(z == 0){
				f9  = f14;
				f10 = f15;
				f11 = f16;
				f12 = f17;
				f13 = f18;			
			}    
			else if(z == ZDIM-1){
				f14 = f9;
				f15 = f10;
				f16 = f11;
				f17 = f12;
				f18 = f13;
			}
			float u,v,w;//,rho;
	        u = 0.0f;//*PoisProf(zcoord)*1.5;
	        v = UMAX;//0.0;
			w = 0.0f;
	        
        	//rho = u+(f0+f2+f4+f9+f11+f13+f14+f16+f18+2.0f*(f3+f6+f7+f12+f17)); //D2Q9i

			f1 = fma(0.0555555556f,6.0f*u,f3);//0.0555555556f*(6.0f*u)+f3;//-0.0555555556f*(rho-3.0f*u+4.5f*u*u-1.5f*usqr);;
			f5 = fma(0.0277777778f,6.0f*(u+v),f7 );// -0.0277777778f*(rho+3.0f*(-u-v)+4.5f*(-u-v)*(-u-v)-1.5f*usqr);
			f8 = fma(0.0277777778f,6.0f*(u-v),f6 );// -0.0277777778f*(rho+3.0f*(-u+v)+4.5f*(-u+v)*(-u+v)-1.5f*usqr);
			f10= fma(0.0277777778f,6.0f*(u+w),f17);//-0.0277777778f*(rho+3.0f*(-u-w)+4.5f*(-u-w)*(-u-w)-1.5f*usqr);
			f15= fma(0.0277777778f,6.0f*(u-w),f12);//-0.0277777778f*(rho+3.0f*(-u+w)+4.5f*(-u+w)*(-u+w)-1.5f*usqr);
		}

		if(MODEL == "MRT")
		mrt_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,omega);
		else if(MODEL == "BGK")
		bgk_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,omega);

		fout[f_mem(0 ,x,y,z,pitch)] = f0 ;
		fout[f_mem(1 ,x,y,z,pitch)] = f1 ;
		fout[f_mem(2 ,x,y,z,pitch)] = f2 ;
		fout[f_mem(3 ,x,y,z,pitch)] = f3 ;
		fout[f_mem(4 ,x,y,z,pitch)] = f4 ;
		fout[f_mem(5 ,x,y,z,pitch)] = f5 ;
		fout[f_mem(6 ,x,y,z,pitch)] = f6 ;
		fout[f_mem(7 ,x,y,z,pitch)] = f7 ;
		fout[f_mem(8 ,x,y,z,pitch)] = f8 ;
		fout[f_mem(9 ,x,y,z,pitch)] = f9 ;
		fout[f_mem(10,x,y,z,pitch)] = f10;
		fout[f_mem(11,x,y,z,pitch)] = f11;
		fout[f_mem(12,x,y,z,pitch)] = f12;
		fout[f_mem(13,x,y,z,pitch)] = f13;
		fout[f_mem(14,x,y,z,pitch)] = f14;
		fout[f_mem(15,x,y,z,pitch)] = f15;
		fout[f_mem(16,x,y,z,pitch)] = f16;
		fout[f_mem(17,x,y,z,pitch)] = f17;
		fout[f_mem(18,x,y,z,pitch)] = f18;
	}
}



__global__ void mrt_d_shared(float* fA, float* fB,
							float omega, size_t pitch)//pitch in elements
{
	int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
	int y = blockIdx.y;//threadIdx.y+blockIdx.y*blockDim.y;
	int z = blockIdx.z;//threadIdx.z+blockIdx.z*blockDim.z;
	int j = x+y*pitch+z*YDIM*pitch;//index on padded mem (pitch in elements)
	int im = ImageFcn(x,y,z);

	__shared__ float  f1_s[BLOCKSIZEX];
	__shared__ float  f3_s[BLOCKSIZEX];
	__shared__ float  f5_s[BLOCKSIZEX];
	__shared__ float  f7_s[BLOCKSIZEX];
	__shared__ float  f6_s[BLOCKSIZEX];
	__shared__ float  f8_s[BLOCKSIZEX];
	__shared__ float f10_s[BLOCKSIZEX];
	__shared__ float f12_s[BLOCKSIZEX];
	__shared__ float f15_s[BLOCKSIZEX];
	__shared__ float f17_s[BLOCKSIZEX];

	 f1_s[threadIdx.x] = fA[f_mem(1 ,x ,y  ,z               ,pitch)];//dmax(x-1)      
	 f3_s[threadIdx.x] = fA[f_mem(3 ,x ,y  ,z               ,pitch)];//dmin(x+1,XDIM)
//	if(y != 0){//takin these out was good
	 f5_s[threadIdx.x] = fA[f_mem(5 ,x ,y-1,z               ,pitch)];//dmax(x-1)      
	 f6_s[threadIdx.x] = fA[f_mem(6 ,x ,y-1,z               ,pitch)];//dmin(x+1,XDIM)
//	}
//	else{
//	f5_s[threadIdx.x] = 0.f;
//	f6_s[threadIdx.x] = 0.f;
//	}
//	if(y != YDIM-1){
	 f7_s[threadIdx.x] = fA[f_mem(7 ,x ,y+1,z               ,pitch)];//dmin(x+1,XDIM)
	 f8_s[threadIdx.x] = fA[f_mem(8 ,x ,y+1,z               ,pitch)];//dmax(x-1)      
//	}
//	else{
//	f7_s[threadIdx.x] = 0.f;
//	f8_s[threadIdx.x] = 0.f;
//	}
//	if(z != 0){
	f10_s[threadIdx.x] = fA[f_mem(10,x ,y  ,z-1,pitch)];//dmax(x-1)      
	f12_s[threadIdx.x] = fA[f_mem(12,x ,y  ,z-1,pitch)];//dmin(x+1,XDIM)
//	}
//	else{
//	f10_s[threadIdx.x] = 0.f;
//	f12_s[threadIdx.x] = 0.f;
//	}
//	if(z != ZDIM-1){
	f15_s[threadIdx.x] = fA[f_mem(15,x ,y  ,z+1,pitch)];//dmax(x-1)      
	f17_s[threadIdx.x] = fA[f_mem(17,x ,y  ,z+1,pitch)];//dmin(x+1,XDIM)
//	}
//	else{
//	f15_s[threadIdx.x] = 0.f;
//	f17_s[threadIdx.x] = 0.f;
//	}

	float f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18;

	//f0  = 0.f;
	f1  = 0.f;
	f2  = 0.f;
	f3  = 0.f;
	f4  = 0.f;
	f5  = 0.f;
	f6  = 0.f;
	f7  = 0.f;
	f8  = 0.f;
	f9  = 0.f;
	f10 = 0.f;
	f11 = 0.f;
	f12 = 0.f;
	f13 = 0.f;
	f14 = 0.f;
	f15 = 0.f;
	f16 = 0.f;
	f17 = 0.f;
	f18 = 0.f;

//	if(y != 0){
	f2 = fA[f_mem(2 ,x  ,y-1,z  ,pitch)];
//	}
//	if(y != YDIM-1){
	f4 = fA[f_mem(4 ,x  ,y+1,z  ,pitch)];
//	}
	f14= fA[f_mem(14,x  ,y  ,z+1,pitch)];
	f16= fA[f_mem(16,x  ,y-1,z+1,pitch)];
	if(z != ZDIM-1){
	f18= fA[f_mem(18,x  ,y+1,z+1,pitch)];
	}
//	else{
//	f18 = 0.0f;
//	}
	
//		if(z != 0){
	f9 = fA[f_mem(9 ,x  ,y  ,z-1,pitch)];
	f11= fA[f_mem(11,x  ,y-1,z-1,pitch)];
	f13= fA[f_mem(13,x  ,y+1,z-1,pitch)];
//		}

	__syncthreads();

	if(threadIdx.x != XDIM-1){
	f3 = f3_s[threadIdx.x+1];//fA[f_mem(3 ,x+1,y  ,z  ,pitch,YDIM,ZDIM)];
	f6 = f6_s[threadIdx.x+1];//fA[f_mem(6 ,x+1,y-1,z  ,pitch,YDIM,ZDIM)];
	f7 = f7_s[threadIdx.x+1];//fA[f_mem(7 ,x+1,y+1,z  ,pitch,YDIM,ZDIM)];
	f12=f12_s[threadIdx.x+1];//fA[f_mem(12,x+1,y  ,z-1,pitch,YDIM,ZDIM)];
	f17=f17_s[threadIdx.x+1];//fA[f_mem(17,x+1,y  ,z+1,pitch,YDIM,ZDIM)];
	}
//	else{
//	f3 =0.f;
//	f6 =0.f;
//	f7 =0.f;
//	f12=0.f;
//	f17=0.f;
//	}
	if(threadIdx.x != 0){
	f1 = f1_s[threadIdx.x-1];//fA[f_mem(1 ,x-1,y  ,z  ,pitch,YDIM,ZDIM)];
	f5 = f5_s[threadIdx.x-1];//fA[f_mem(5 ,x-1,y-1,z  ,pitch,YDIM,ZDIM)];
	f8 = f8_s[threadIdx.x-1];//fA[f_mem(8 ,x-1,y+1,z  ,pitch,YDIM,ZDIM)];
	f10=f10_s[threadIdx.x-1];//fA[f_mem(10,x-1,y  ,z-1,pitch,YDIM,ZDIM)];
	f15=f15_s[threadIdx.x-1];//fA[f_mem(15,x-1,y  ,z+1,pitch,YDIM,ZDIM)];
	}
//	else{
//	f1 =0.f;
//	f5 =0.f;
//	f8 =0.f;
//	f10=0.f;
//	f15=0.f;
//	}




	if(im == 1){//BB

//	float f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18;
//
//	f4 = fA[f_mem(2 ,x  ,y-1,z  ,pitch)];
//	f2 = fA[f_mem(4 ,x  ,y+1,z  ,pitch)];
//	f9 = fA[f_mem(14,x  ,y  ,z+1,pitch)];
//	f13= fA[f_mem(16,x  ,y-1,z+1,pitch)];
//	if(z != ZDIM-1){
//	f11= fA[f_mem(18,x  ,y+1,z+1,pitch)];
//	}
//	f14= fA[f_mem(9 ,x  ,y  ,z-1,pitch)];
//	f18= fA[f_mem(11,x  ,y-1,z-1,pitch)];
//	f16= fA[f_mem(13,x  ,y+1,z-1,pitch)];
//
//	if(threadIdx.x != XDIM-1){
//	f1 = f3_s[threadIdx.x+1];//fA[f_mem(3 ,x+1,y  ,z  ,pitch,YDIM,ZDIM)];
//	f5 = f7_s[threadIdx.x+1];//fA[f_mem(6 ,x+1,y-1,z  ,pitch,YDIM,ZDIM)];
//	f8 = f6_s[threadIdx.x+1];//fA[f_mem(7 ,x+1,y+1,z  ,pitch,YDIM,ZDIM)];
//	f10=f17_s[threadIdx.x+1];//fA[f_mem(12,x+1,y  ,z-1,pitch,YDIM,ZDIM)];
//	f15=f12_s[threadIdx.x+1];//fA[f_mem(17,x+1,y  ,z+1,pitch,YDIM,ZDIM)];
//	}
//	if(threadIdx.x != 0){
//	f3 = f1_s[threadIdx.x-1];//fA[f_mem(1 ,x-1,y  ,z  ,pitch,YDIM,ZDIM)];
//	f7 = f5_s[threadIdx.x-1];//fA[f_mem(5 ,x-1,y-1,z  ,pitch,YDIM,ZDIM)];
//	f6 = f8_s[threadIdx.x-1];//fA[f_mem(8 ,x-1,y+1,z  ,pitch,YDIM,ZDIM)];
//	f17=f10_s[threadIdx.x-1];//fA[f_mem(10,x-1,y  ,z-1,pitch,YDIM,ZDIM)];
//	f12=f15_s[threadIdx.x-1];//fA[f_mem(15,x-1,y  ,z+1,pitch,YDIM,ZDIM)];
//	}

	//	fB[j] = f0 ;
		fB[f_mem(1 ,x,y,z,pitch)] = f3 ;
		fB[f_mem(2 ,x,y,z,pitch)] = f4 ;
		fB[f_mem(3 ,x,y,z,pitch)] = f1 ;
		fB[f_mem(4 ,x,y,z,pitch)] = f2 ;
		fB[f_mem(5 ,x,y,z,pitch)] = f7 ;
		fB[f_mem(6 ,x,y,z,pitch)] = f8 ;
		fB[f_mem(7 ,x,y,z,pitch)] = f5 ;
		fB[f_mem(8 ,x,y,z,pitch)] = f6 ;
		fB[f_mem(9 ,x,y,z,pitch)] = f14;
		fB[f_mem(10,x,y,z,pitch)] = f17;
		fB[f_mem(11,x,y,z,pitch)] = f18;
		fB[f_mem(12,x,y,z,pitch)] = f15;
		fB[f_mem(13,x,y,z,pitch)] = f16;
		fB[f_mem(14,x,y,z,pitch)] = f9 ;
		fB[f_mem(15,x,y,z,pitch)] = f12;
		fB[f_mem(16,x,y,z,pitch)] = f13;
		fB[f_mem(17,x,y,z,pitch)] = f10;
		fB[f_mem(18,x,y,z,pitch)] = f11;

//		fB[f_mem(1 ,x,y,z,pitch)] = f1 ;
//		fB[f_mem(2 ,x,y,z,pitch)] = f2 ;
//		fB[f_mem(3 ,x,y,z,pitch)] = f3 ;
//		fB[f_mem(4 ,x,y,z,pitch)] = f4 ;
//		fB[f_mem(5 ,x,y,z,pitch)] = f5 ;
//		fB[f_mem(6 ,x,y,z,pitch)] = f6 ;
//		fB[f_mem(7 ,x,y,z,pitch)] = f7 ;
//		fB[f_mem(8 ,x,y,z,pitch)] = f8 ;
//		fB[f_mem(9 ,x,y,z,pitch)] = f9 ;
//		fB[f_mem(10,x,y,z,pitch)] = f10;
//		fB[f_mem(11,x,y,z,pitch)] = f11;
//		fB[f_mem(12,x,y,z,pitch)] = f12;
//		fB[f_mem(13,x,y,z,pitch)] = f13;
//		fB[f_mem(14,x,y,z,pitch)] = f14;
//		fB[f_mem(15,x,y,z,pitch)] = f15;
//		fB[f_mem(16,x,y,z,pitch)] = f16;
//		fB[f_mem(17,x,y,z,pitch)] = f17;
//		fB[f_mem(18,x,y,z,pitch)] = f18;
	}
	else{


	float f0 = fA[j];


		if(im == 3)//DirichletWest
		{
			if(y == 0){
				f2 = f4;
				f6 = f7;
				f11 = f13;
				f16 = f18;
			}
			else if(y == YDIM-1){
				f4 = f2;
				f7 = f6;
				f13 = f11;
				f18 = f16;
			}
			if(z == 0){
				f9  = f14;
				f10 = f15;
				f11 = f16;
				f12 = f17;
				f13 = f18;			
			}    
			else if(z == ZDIM-1){
				f14 = f9;
				f15 = f10;
				f16 = f11;
				f17 = f12;
				f18 = f13;
			}
			float u,v,w;//,rho;
	        u = 0.0f;//*PoisProf(zcoord)*1.5;
	        v = UMAX;//0.0;
			w = 0.0f;
	        
			f1 = fma(0.0555555556f,6.0f*u,f3);//0.0555555556f*(6.0f*u)+f3;//-0.0555555556f*(rho-3.0f*u+4.5f*u*u-1.5f*usqr);;
			f5 = fma(0.0277777778f,6.0f*(u+v),f7 );// -0.0277777778f*(rho+3.0f*(-u-v)+4.5f*(-u-v)*(-u-v)-1.5f*usqr);
			f8 = fma(0.0277777778f,6.0f*(u-v),f6 );// -0.0277777778f*(rho+3.0f*(-u+v)+4.5f*(-u+v)*(-u+v)-1.5f*usqr);
			f10= fma(0.0277777778f,6.0f*(u+w),f17);//-0.0277777778f*(rho+3.0f*(-u-w)+4.5f*(-u-w)*(-u-w)-1.5f*usqr);
			f15= fma(0.0277777778f,6.0f*(u-w),f12);//-0.0277777778f*(rho+3.0f*(-u+w)+4.5f*(-u+w)*(-u+w)-1.5f*usqr);

		}
		if(MODEL == "MRT")
		mrt_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,omega);
		else if(MODEL == "BGK")
		bgk_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,omega);


		fB[f_mem(0 ,x,y,z,pitch)] = f0 ;
		fB[f_mem(1 ,x,y,z,pitch)] = f1 ;
		fB[f_mem(2 ,x,y,z,pitch)] = f2 ;
		fB[f_mem(3 ,x,y,z,pitch)] = f3 ;
		fB[f_mem(4 ,x,y,z,pitch)] = f4 ;
		fB[f_mem(5 ,x,y,z,pitch)] = f5 ;
		fB[f_mem(6 ,x,y,z,pitch)] = f6 ;
		fB[f_mem(7 ,x,y,z,pitch)] = f7 ;
		fB[f_mem(8 ,x,y,z,pitch)] = f8 ;
		fB[f_mem(9 ,x,y,z,pitch)] = f9 ;
		fB[f_mem(10,x,y,z,pitch)] = f10;
		fB[f_mem(11,x,y,z,pitch)] = f11;
		fB[f_mem(12,x,y,z,pitch)] = f12;
		fB[f_mem(13,x,y,z,pitch)] = f13;
		fB[f_mem(14,x,y,z,pitch)] = f14;
		fB[f_mem(15,x,y,z,pitch)] = f15;
		fB[f_mem(16,x,y,z,pitch)] = f16;
		fB[f_mem(17,x,y,z,pitch)] = f17;
		fB[f_mem(18,x,y,z,pitch)] = f18;
	}
}

__global__ void mrt_d_single(float* fA, float* fB,
							float omega, size_t pitch)//pitch in elements
{
	int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
	int y = threadIdx.y+blockIdx.y*blockDim.y;
	int z = threadIdx.z+blockIdx.z*blockDim.z;
	int j = x+y*pitch+z*YDIM*pitch;//index on padded mem (pitch in elements)
	int im = ImageFcn(x,y,z);
	float f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18;

	if(REFINEMENT == "YES" && x > LRX0+1 && x < LRX0+(XLRDIM-1)*LRFACTOR-1 
		&& y > LRY0+1 && y < LRY0+(YLRDIM-1)*LRFACTOR-1 && z > LRZ0+1 && z < LRZ0+(ZLRDIM-1)*LRFACTOR-1){
	}
	else{

	f0 = fA[j];
	f1 = fA[f_mem(1 ,dmax(x-1)     ,y  ,z  ,pitch)];
	f3 = fA[f_mem(3 ,dmin(x+1,XDIM),y  ,z  ,pitch)];
	f2 = fA[f_mem(2 ,x             ,y-1,z  ,pitch)];
	f5 = fA[f_mem(5 ,dmax(x-1)     ,y-1,z  ,pitch)];
	f6 = fA[f_mem(6 ,dmin(x+1,XDIM),y-1,z  ,pitch)];
	f4 = fA[f_mem(4 ,x             ,y+1,z  ,pitch)];
	f7 = fA[f_mem(7 ,dmin(x+1,XDIM),y+1,z  ,pitch)];
	f8 = fA[f_mem(8 ,dmax(x-1)     ,y+1,z  ,pitch)];
	f9 = fA[f_mem(9 ,x             ,y  ,z-1,pitch)];
	f10= fA[f_mem(10,dmax(x-1)     ,y  ,z-1,pitch)];
	f11= fA[f_mem(11,x             ,y-1,z-1,pitch)];
	f12= fA[f_mem(12,dmin(x+1,XDIM),y  ,z-1,pitch)];
	f13= fA[f_mem(13,x             ,y+1,z-1,pitch)];
	f14= fA[f_mem(14,x             ,y  ,z+1,pitch)];
	f15= fA[f_mem(15,dmax(x-1)     ,y  ,z+1,pitch)];
	f16= fA[f_mem(16,x             ,y-1,z+1,pitch)];
	f17= fA[f_mem(17,dmin(x+1,XDIM),y  ,z+1,pitch)];
	//f18= fA[f_mem(18,x  ,dmin(y+1,YDIM),dmin(z+1,ZDIM),pitch)];
	f18= fA[f_mem(18,x             ,dmin(y+1,YDIM),dmin(z+1,ZDIM),pitch)];
	if(im == 1){//BB
		fB[f_mem(1 ,x,y,z,pitch)] = f3 ;
		fB[f_mem(2 ,x,y,z,pitch)] = f4 ;
		fB[f_mem(3 ,x,y,z,pitch)] = f1 ;
		fB[f_mem(4 ,x,y,z,pitch)] = f2 ;
		fB[f_mem(5 ,x,y,z,pitch)] = f7 ;
		fB[f_mem(6 ,x,y,z,pitch)] = f8 ;
		fB[f_mem(7 ,x,y,z,pitch)] = f5 ;
		fB[f_mem(8 ,x,y,z,pitch)] = f6 ;
		fB[f_mem(9 ,x,y,z,pitch)] = f14;
		fB[f_mem(10,x,y,z,pitch)] = f17;
		fB[f_mem(11,x,y,z,pitch)] = f18;
		fB[f_mem(12,x,y,z,pitch)] = f15;
		fB[f_mem(13,x,y,z,pitch)] = f16;
		fB[f_mem(14,x,y,z,pitch)] = f9 ;
		fB[f_mem(15,x,y,z,pitch)] = f12;
		fB[f_mem(16,x,y,z,pitch)] = f13;
		fB[f_mem(17,x,y,z,pitch)] = f10;
		fB[f_mem(18,x,y,z,pitch)] = f11;
	}
	else{
		if(im == 3)//DirichletWest
		{
			if(y == 0){
				f2 = f4;
				f6 = f7;
				f11 = f13;
				f16 = f18;
			}
			else if(y == YDIM-1){
				f4 = f2;
				f7 = f6;
				f13 = f11;
				f18 = f16;
			}
			if(z == 0){
				f9  = f14;
				f10 = f15;
				f11 = f16;
				f12 = f17;
				f13 = f18;			
			}    
			else if(z == ZDIM-1){
				f14 = f9;
				f15 = f10;
				f16 = f11;
				f17 = f12;
				f18 = f13;
			}
			float u,v,w;//,rho;
	        u = 0.0f;//*PoisProf(zcoord)*1.5;
	        v = UMAX;//0.0;
			w = 0.0f;
	        
			f1 = fma(0.0555555556f,6.0f*u,f3);//0.0555555556f*(6.0f*u)+f3;//-0.0555555556f*(rho-3.0f*u+4.5f*u*u-1.5f*usqr);;
			f5 = fma(0.0277777778f,6.0f*(u+v),f7 );// -0.0277777778f*(rho+3.0f*(-u-v)+4.5f*(-u-v)*(-u-v)-1.5f*usqr);
			f8 = fma(0.0277777778f,6.0f*(u-v),f6 );// -0.0277777778f*(rho+3.0f*(-u+v)+4.5f*(-u+v)*(-u+v)-1.5f*usqr);
			f10= fma(0.0277777778f,6.0f*(u+w),f17);//-0.0277777778f*(rho+3.0f*(-u-w)+4.5f*(-u-w)*(-u-w)-1.5f*usqr);
			f15= fma(0.0277777778f,6.0f*(u-w),f12);//-0.0277777778f*(rho+3.0f*(-u+w)+4.5f*(-u+w)*(-u+w)-1.5f*usqr);

		}

		if(MODEL == "MRT")
		mrt_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,omega);
		else if(MODEL == "BGK")
		bgk_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,omega);


		fB[f_mem(0 ,x,y,z,pitch)] = f0 ;
		fB[f_mem(1 ,x,y,z,pitch)] = f1 ;
		fB[f_mem(2 ,x,y,z,pitch)] = f2 ;
		fB[f_mem(3 ,x,y,z,pitch)] = f3 ;
		fB[f_mem(4 ,x,y,z,pitch)] = f4 ;
		fB[f_mem(5 ,x,y,z,pitch)] = f5 ;
		fB[f_mem(6 ,x,y,z,pitch)] = f6 ;
		fB[f_mem(7 ,x,y,z,pitch)] = f7 ;
		fB[f_mem(8 ,x,y,z,pitch)] = f8 ;
		fB[f_mem(9 ,x,y,z,pitch)] = f9 ;
		fB[f_mem(10,x,y,z,pitch)] = f10;
		fB[f_mem(11,x,y,z,pitch)] = f11;
		fB[f_mem(12,x,y,z,pitch)] = f12;
		fB[f_mem(13,x,y,z,pitch)] = f13;
		fB[f_mem(14,x,y,z,pitch)] = f14;
		fB[f_mem(15,x,y,z,pitch)] = f15;
		fB[f_mem(16,x,y,z,pitch)] = f16;
		fB[f_mem(17,x,y,z,pitch)] = f17;
		fB[f_mem(18,x,y,z,pitch)] = f18;
	}
	}
}




__global__ void initialize_single(float *f, size_t pitch)//pitch in elements
{
	int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
	int y = threadIdx.y+blockIdx.y*blockDim.y;
	int z = threadIdx.z+blockIdx.z*blockDim.z;
	int j = x+y*pitch+z*YDIM*pitch;//index on padded mem (pitch in elements)
	
	float u,v,w,rho,usqr;
	rho = 1.f;
	u = 0.0f;
	v = 0.0f;
	w = 0.0f;
	//if(x == 3 ) u = 0.1f;
	usqr = u*u+v*v+w*w;

	f[j+0 *pitch*YDIM*ZDIM]= 1.0f/3.0f*(rho-1.5f*usqr);
	f[j+1 *pitch*YDIM*ZDIM]= 1.0f/18.0f*(rho+3.0f*u+4.5f*u*u-1.5f*usqr);
	f[j+2 *pitch*YDIM*ZDIM]= 1.0f/18.0f*(rho+3.0f*v+4.5f*v*v-1.5f*usqr);
	f[j+3 *pitch*YDIM*ZDIM]= 1.0f/18.0f*(rho-3.0f*u+4.5f*u*u-1.5f*usqr);
	f[j+4 *pitch*YDIM*ZDIM]= 1.0f/18.0f*(rho-3.0f*v+4.5f*v*v-1.5f*usqr);
	f[j+5 *pitch*YDIM*ZDIM]= 1.0f/36.0f*(rho+3.0f*(u+v)+4.5f*(u+v)*(u+v)-1.5f*usqr);
	f[j+6 *pitch*YDIM*ZDIM]= 1.0f/36.0f*(rho+3.0f*(-u+v)+4.5f*(-u+v)*(-u+v)-1.5f*usqr);
	f[j+7 *pitch*YDIM*ZDIM]= 1.0f/36.0f*(rho+3.0f*(-u-v)+4.5f*(-u-v)*(-u-v)-1.5f*usqr);
	f[j+8 *pitch*YDIM*ZDIM]= 1.0f/36.0f*(rho+3.0f*(u-v)+4.5f*(u-v)*(u-v)-1.5f*usqr);
	f[j+9 *pitch*YDIM*ZDIM]= 1.0f/18.0f*(rho+3.0f*w+4.5f*w*w-1.5f*usqr);
	f[j+10*pitch*YDIM*ZDIM]= 1.0f/36.0f*(rho+3.0f*(u+w)+4.5f*(u+w)*(u+w)-1.5f*usqr);
	f[j+11*pitch*YDIM*ZDIM]= 1.0f/36.0f*(rho+3.0f*(v+w)+4.5f*(v+w)*(u+w)-1.5f*usqr);
	f[j+12*pitch*YDIM*ZDIM]= 1.0f/36.0f*(rho+3.0f*(-u+w)+4.5f*(-u+w)*(-u+w)-1.5f*usqr);
	f[j+13*pitch*YDIM*ZDIM]= 1.0f/36.0f*(rho+3.0f*(-v+w)+4.5f*(-v+w)*(u+w)-1.5f*usqr);
	f[j+14*pitch*YDIM*ZDIM]= 1.0f/18.0f*(rho-3.0f*w+4.5f*w*w-1.5f*usqr);
	f[j+15*pitch*YDIM*ZDIM]= 1.0f/36.0f*(rho+3.0f*(u-w)+4.5f*(u-w)*(u-w)-1.5f*usqr);
	f[j+16*pitch*YDIM*ZDIM]= 1.0f/36.0f*(rho+3.0f*(v-w)+4.5f*(v-w)*(v-w)-1.5f*usqr);
	f[j+17*pitch*YDIM*ZDIM]= 1.0f/36.0f*(rho+3.0f*(-u-w)+4.5f*(-u-w)*(-u-w)-1.5f*usqr);
	f[j+18*pitch*YDIM*ZDIM]= 1.0f/36.0f*(rho+3.0f*(-v-w)+4.5f*(-v-w)*(-v-w)-1.5f*usqr);
}
__global__ void initialize_LR(float *f, size_t pitch)//pitch in elements
{
	int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
	int y = threadIdx.y+blockIdx.y*blockDim.y;
	int z = threadIdx.z+blockIdx.z*blockDim.z;
	int j = x+y*pitch+z*YLRDIM*pitch;//index on padded mem (pitch in elements)
	
	float u,v,w,rho,usqr;
	rho = 1.f;
	u = 0.0f;
	v = 0.0f;
	w = 0.0f;
	//if(x == 3 ) u = 0.1f;
	usqr = u*u+v*v+w*w;

	f[j+0 *pitch*YLRDIM*ZLRDIM]= 1.0f/3.0f*(rho-1.5f*usqr);
	f[j+1 *pitch*YLRDIM*ZLRDIM]= 1.0f/18.0f*(rho+3.0f*u+4.5f*u*u-1.5f*usqr);
	f[j+2 *pitch*YLRDIM*ZLRDIM]= 1.0f/18.0f*(rho+3.0f*v+4.5f*v*v-1.5f*usqr);
	f[j+3 *pitch*YLRDIM*ZLRDIM]= 1.0f/18.0f*(rho-3.0f*u+4.5f*u*u-1.5f*usqr);
	f[j+4 *pitch*YLRDIM*ZLRDIM]= 1.0f/18.0f*(rho-3.0f*v+4.5f*v*v-1.5f*usqr);
	f[j+5 *pitch*YLRDIM*ZLRDIM]= 1.0f/36.0f*(rho+3.0f*(u+v)+4.5f*(u+v)*(u+v)-1.5f*usqr);
	f[j+6 *pitch*YLRDIM*ZLRDIM]= 1.0f/36.0f*(rho+3.0f*(-u+v)+4.5f*(-u+v)*(-u+v)-1.5f*usqr);
	f[j+7 *pitch*YLRDIM*ZLRDIM]= 1.0f/36.0f*(rho+3.0f*(-u-v)+4.5f*(-u-v)*(-u-v)-1.5f*usqr);
	f[j+8 *pitch*YLRDIM*ZLRDIM]= 1.0f/36.0f*(rho+3.0f*(u-v)+4.5f*(u-v)*(u-v)-1.5f*usqr);
	f[j+9 *pitch*YLRDIM*ZLRDIM]= 1.0f/18.0f*(rho+3.0f*w+4.5f*w*w-1.5f*usqr);
	f[j+10*pitch*YLRDIM*ZLRDIM]= 1.0f/36.0f*(rho+3.0f*(u+w)+4.5f*(u+w)*(u+w)-1.5f*usqr);
	f[j+11*pitch*YLRDIM*ZLRDIM]= 1.0f/36.0f*(rho+3.0f*(v+w)+4.5f*(v+w)*(u+w)-1.5f*usqr);
	f[j+12*pitch*YLRDIM*ZLRDIM]= 1.0f/36.0f*(rho+3.0f*(-u+w)+4.5f*(-u+w)*(-u+w)-1.5f*usqr);
	f[j+13*pitch*YLRDIM*ZLRDIM]= 1.0f/36.0f*(rho+3.0f*(-v+w)+4.5f*(-v+w)*(u+w)-1.5f*usqr);
	f[j+14*pitch*YLRDIM*ZLRDIM]= 1.0f/18.0f*(rho-3.0f*w+4.5f*w*w-1.5f*usqr);
	f[j+15*pitch*YLRDIM*ZLRDIM]= 1.0f/36.0f*(rho+3.0f*(u-w)+4.5f*(u-w)*(u-w)-1.5f*usqr);
	f[j+16*pitch*YLRDIM*ZLRDIM]= 1.0f/36.0f*(rho+3.0f*(v-w)+4.5f*(v-w)*(v-w)-1.5f*usqr);
	f[j+17*pitch*YLRDIM*ZLRDIM]= 1.0f/36.0f*(rho+3.0f*(-u-w)+4.5f*(-u-w)*(-u-w)-1.5f*usqr);
	f[j+18*pitch*YLRDIM*ZLRDIM]= 1.0f/36.0f*(rho+3.0f*(-v-w)+4.5f*(-v-w)*(-v-w)-1.5f*usqr);
}
__global__ void initialize(float* f0, float* f1, float* f2,
							float* f3, float* f4, float* f5,
							float* f6, float* f7, float* f8, float* f9,
							float* f10, float* f11, float* f12,
							float* f13, float* f14, float* f15,
							float* f16, float* f17, float* f18,
							size_t pitch)//pitch in elements
//__global__ void initialize(void** f0in, void** f1in, 
//							int w, int h, int pitch)//pitch in elements
{
	int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
	int y = threadIdx.y+blockIdx.y*blockDim.y;
	int z = threadIdx.z+blockIdx.z*blockDim.z;
//	int i = x+y*XDIM+z*XDIM*YDIM;//index on linear mem
	int j = x+y*pitch+z*YDIM*pitch;//index on padded mem (pitch in elements)
//	f1out[j] = tex2D(texRef_f2A,x,y+h*z);
	
	float u,v,w,rho,feq,usqr;
	rho = 1.0f;
	u = 0.0f;
	v = 0.1f;
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



int main(int argc, char *argv[])
{

	//int *image_d, *image_h;

	ofstream output;
	output.open ("LBM1_out.dat");

	size_t memsize, memsize2;
	size_t pitch = 0;
	size_t pitch2 = 0;
	int i, n, nBlocks, nBlocks2, n2;
	float omega, CharLength, omega2;

	CharLength = XDIM-2.f;

	omega = 1.0f/(3.0f*(UMAX*CharLength/RE)+0.5f);
	omega2 = 2.0f/(1.0f+2.0f*(2.0f/omega-1.0f));
	float SF_cf = omega*(1.0f-omega2)/((1.0f-omega)*omega2/LRFACTOR);
	float SF_fc = 1.f/SF_cf;

	cout<<"omega: "<<omega<<endl;
	cout<<"blocksize: "<<BLOCKSIZEX<<"x"<<BLOCKSIZEY<<"x"<<BLOCKSIZEZ<<endl;
	cout<<"grid: "<<XDIM<<"x"<<YDIM<<"x"<<ZDIM<<endl;
	cout<<"LRblocksize: "<<BLOCKSIZELRX<<"x"<<BLOCKSIZELRY<<"x"<<BLOCKSIZELRZ<<endl;
	cout<<"LRgrid: "<<XLRDIM<<"x"<<YLRDIM<<"x"<<ZLRDIM<<endl;
	cout<<"TMAX: "<<TMAX<<endl;
	cout<<"Method: "<<METHOD<<endl;
	cout<<"Model: "<<MODEL<<endl;

	nBlocks = (XDIM/BLOCKSIZEX+XDIM%BLOCKSIZEX)*(YDIM/BLOCKSIZEY+YDIM%BLOCKSIZEY)
				*(ZDIM/BLOCKSIZEZ+ZDIM%BLOCKSIZEZ);
	nBlocks2 = (XLRDIM/BLOCKSIZELRX+XLRDIM%BLOCKSIZELRX)*(YLRDIM/BLOCKSIZELRY+YLRDIM%BLOCKSIZELRY)
				*(ZLRDIM/BLOCKSIZELRZ+ZLRDIM%BLOCKSIZELRZ);
	int B = BLOCKSIZEX*BLOCKSIZELRY*BLOCKSIZELRZ;
	int B2 = BLOCKSIZELRX*BLOCKSIZELRY*BLOCKSIZELRZ;
	n = nBlocks*B;
	n2 = nBlocks2*B2;
	cout<<"nBlocks:"<<nBlocks<<endl;

    dim3 threads(BLOCKSIZEX, BLOCKSIZEY, BLOCKSIZEZ);
    dim3 grid(XDIM/BLOCKSIZEX,YDIM/BLOCKSIZEY,ZDIM/BLOCKSIZEZ);

    dim3 threads2(BLOCKSIZELRX, BLOCKSIZELRY, BLOCKSIZELRZ);
    dim3 grid2(XLRDIM/BLOCKSIZELRX,YLRDIM/BLOCKSIZELRY,ZLRDIM/BLOCKSIZELRZ);

	memsize = n*sizeof(float);
	//memsize_int = n*sizeof(int);
	memsize2 = n2*sizeof(float);

	//cudaExtent extent = make_cudaExtent(XDIM*sizeof(float),YDIM,ZDIM);

	//image_h = (int *)malloc(memsize_int);

	float *fA_h,*fA_d,*fB_d,*fC_h,*fC_d,*fD_d;
	fA_h = (float *)malloc(memsize*19);
	fC_h = (float *)malloc(memsize2*19);
	cudaMallocPitch((void **) &fA_d, &pitch, XDIM*sizeof(float), YDIM*ZDIM*19);
	cudaMallocPitch((void **) &fB_d, &pitch, XDIM*sizeof(float), YDIM*ZDIM*19);

//	if(REFINEMENT == "YES"){
	cudaMallocPitch((void **) &fC_d, &pitch2, XLRDIM*sizeof(float), YLRDIM*ZLRDIM*19);
	cudaMallocPitch((void **) &fD_d, &pitch2, XLRDIM*sizeof(float), YLRDIM*ZLRDIM*19);
//	}

	//cudaMalloc((void **) &image_d, memsize_int);

	cout<<pitch<<", "<<pitch2<<endl;
	
	size_t pitch_elements = pitch/sizeof(float);
	size_t pitch_elements2 = pitch2/sizeof(float);

	cudaChannelFormatDesc desc = cudaCreateChannelDesc<float>();
	for (i = 0; i < n*19; i++)
	{
		fA_h[i] = i;
		fC_h[i] = 0;
	}
//	for (i = 0; i < n; i++)
//	{
//		int x = i%XDIM;
//		int y = (i/XDIM)%YDIM;
//		int z = (i/XDIM)/YDIM;
////		image_h[i] = 0;
////		if(x < 1) image_h[i] = 1;//DirichletWest
////		if(x > XDIM-2) image_h[i] = 1;//BB
////		if(y < 1) image_h[i] = 1;//BB
////		if(y > YDIM-2) image_h[i] = 1;//BB
////		if(z < 1) image_h[i] = 1;//DirichletWest
////		if(z > ZDIM-2) image_h[i] = 1;//BB
//	}
	//cudaMemcpy(image_d, image_h, memsize_int, cudaMemcpyHostToDevice);
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
	texRef_f0B.filterMode = cudaFilterModeLinear;
	texRef_f1B.filterMode = cudaFilterModeLinear;
	texRef_f2B.filterMode = cudaFilterModeLinear;
	texRef_f3B.filterMode = cudaFilterModeLinear;
	texRef_f4B.filterMode = cudaFilterModeLinear;
	texRef_f5B.filterMode = cudaFilterModeLinear;
	texRef_f6B.filterMode = cudaFilterModeLinear;
	texRef_f7B.filterMode = cudaFilterModeLinear;
	texRef_f8B.filterMode = cudaFilterModeLinear;
	texRef_f9B.filterMode = cudaFilterModeLinear;
	texRef_f10B.filterMode = cudaFilterModeLinear;
	texRef_f11B.filterMode = cudaFilterModeLinear;
	texRef_f12B.filterMode = cudaFilterModeLinear;
	texRef_f13B.filterMode = cudaFilterModeLinear;
	texRef_f14B.filterMode = cudaFilterModeLinear;
	texRef_f15B.filterMode = cudaFilterModeLinear;
	texRef_f16B.filterMode = cudaFilterModeLinear;
	texRef_f17B.filterMode = cudaFilterModeLinear;
	texRef_f18B.filterMode = cudaFilterModeLinear;
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
	texRef_f0A.filterMode = cudaFilterModeLinear;
	texRef_f1A.filterMode = cudaFilterModeLinear;
	texRef_f2A.filterMode = cudaFilterModeLinear;
	texRef_f3A.filterMode = cudaFilterModeLinear;
	texRef_f4A.filterMode = cudaFilterModeLinear;
	texRef_f5A.filterMode = cudaFilterModeLinear;
	texRef_f6A.filterMode = cudaFilterModeLinear;
	texRef_f7A.filterMode = cudaFilterModeLinear;
	texRef_f8A.filterMode = cudaFilterModeLinear;
	texRef_f9A.filterMode = cudaFilterModeLinear;
	texRef_f10A.filterMode = cudaFilterModeLinear;
	texRef_f11A.filterMode = cudaFilterModeLinear;
	texRef_f12A.filterMode = cudaFilterModeLinear;
	texRef_f13A.filterMode = cudaFilterModeLinear;
	texRef_f14A.filterMode = cudaFilterModeLinear;
	texRef_f15A.filterMode = cudaFilterModeLinear;
	texRef_f16A.filterMode = cudaFilterModeLinear;
	texRef_f17A.filterMode = cudaFilterModeLinear;
	texRef_f18A.filterMode = cudaFilterModeLinear;

//	if(REFINEMENT == "YES"){
	texRef_f0C.normalized = false;
	texRef_f1C.normalized = false;
	texRef_f2C.normalized = false;
	texRef_f3C.normalized = false;
	texRef_f4C.normalized = false;
	texRef_f5C.normalized = false;
	texRef_f6C.normalized = false;
	texRef_f7C.normalized = false;
	texRef_f8C.normalized = false;
	texRef_f9C.normalized = false;
	texRef_f10C.normalized = false;
	texRef_f11C.normalized = false;
	texRef_f12C.normalized = false;
	texRef_f13C.normalized = false;
	texRef_f14C.normalized = false;
	texRef_f15C.normalized = false;
	texRef_f16C.normalized = false;
	texRef_f17C.normalized = false;
	texRef_f18C.normalized = false;
	texRef_f0C.filterMode = cudaFilterModeLinear;
	texRef_f1C.filterMode = cudaFilterModeLinear;
	texRef_f2C.filterMode = cudaFilterModeLinear;
	texRef_f3C.filterMode = cudaFilterModeLinear;
	texRef_f4C.filterMode = cudaFilterModeLinear;
	texRef_f5C.filterMode = cudaFilterModeLinear;
	texRef_f6C.filterMode = cudaFilterModeLinear;
	texRef_f7C.filterMode = cudaFilterModeLinear;
	texRef_f8C.filterMode = cudaFilterModeLinear;
	texRef_f9C.filterMode = cudaFilterModeLinear;
	texRef_f10C.filterMode = cudaFilterModeLinear;
	texRef_f11C.filterMode = cudaFilterModeLinear;
	texRef_f12C.filterMode = cudaFilterModeLinear;
	texRef_f13C.filterMode = cudaFilterModeLinear;
	texRef_f14C.filterMode = cudaFilterModeLinear;
	texRef_f15C.filterMode = cudaFilterModeLinear;
	texRef_f16C.filterMode = cudaFilterModeLinear;
	texRef_f17C.filterMode = cudaFilterModeLinear;
	texRef_f18C.filterMode = cudaFilterModeLinear;
	texRef_f0D.normalized = false;
	texRef_f1D.normalized = false;
	texRef_f2D.normalized = false;
	texRef_f3D.normalized = false;
	texRef_f4D.normalized = false;
	texRef_f5D.normalized = false;
	texRef_f6D.normalized = false;
	texRef_f7D.normalized = false;
	texRef_f8D.normalized = false;
	texRef_f9D.normalized = false;
	texRef_f10D.normalized = false;
	texRef_f11D.normalized = false;
	texRef_f12D.normalized = false;
	texRef_f13D.normalized = false;
	texRef_f14D.normalized = false;
	texRef_f15D.normalized = false;
	texRef_f16D.normalized = false;
	texRef_f17D.normalized = false;
	texRef_f18D.normalized = false;
	texRef_f0D.filterMode = cudaFilterModeLinear;
	texRef_f1D.filterMode = cudaFilterModeLinear;
	texRef_f2D.filterMode = cudaFilterModeLinear;
	texRef_f3D.filterMode = cudaFilterModeLinear;
	texRef_f4D.filterMode = cudaFilterModeLinear;
	texRef_f5D.filterMode = cudaFilterModeLinear;
	texRef_f6D.filterMode = cudaFilterModeLinear;
	texRef_f7D.filterMode = cudaFilterModeLinear;
	texRef_f8D.filterMode = cudaFilterModeLinear;
	texRef_f9D.filterMode = cudaFilterModeLinear;
	texRef_f10D.filterMode = cudaFilterModeLinear;
	texRef_f11D.filterMode = cudaFilterModeLinear;
	texRef_f12D.filterMode = cudaFilterModeLinear;
	texRef_f13D.filterMode = cudaFilterModeLinear;
	texRef_f14D.filterMode = cudaFilterModeLinear;
	texRef_f15D.filterMode = cudaFilterModeLinear;
	texRef_f16D.filterMode = cudaFilterModeLinear;
	texRef_f17D.filterMode = cudaFilterModeLinear;
	texRef_f18D.filterMode = cudaFilterModeLinear;
//	}
	}
	
	cudaMemcpy2D(fA_d,pitch ,fA_h,XDIM*sizeof(float),XDIM*sizeof(float),YDIM*ZDIM*19,cudaMemcpyHostToDevice);
	cudaMemcpy2D(fB_d,pitch ,fA_h,XDIM*sizeof(float),XDIM*sizeof(float),YDIM*ZDIM*19,cudaMemcpyHostToDevice);
	if(REFINEMENT == "YES"){
	cudaMemcpy2D(fC_d,pitch2,fC_h,XLRDIM*sizeof(float),XLRDIM*sizeof(float),YLRDIM*ZLRDIM*19,cudaMemcpyHostToDevice);
	cudaMemcpy2D(fD_d,pitch2,fC_h,XLRDIM*sizeof(float),XLRDIM*sizeof(float),YLRDIM*ZLRDIM*19,cudaMemcpyHostToDevice);
	}
	for (i = 0; i < n*19; i++)
	{
		fA_h[i] = 0;
		fC_h[i] = 1;
	}


	if(true)//bind texture
	{
	cudaBindTexture2D(0,&texRef_f0A, fA_d                            ,&desc,XDIM,YDIM*ZDIM,pitch);
	cudaBindTexture2D(0,&texRef_f1A, fA_d+pitch_elements*YDIM*ZDIM   ,&desc,XDIM,YDIM*ZDIM,pitch);
	cudaBindTexture2D(0,&texRef_f2A, fA_d+pitch_elements*YDIM*ZDIM*2 ,&desc,XDIM,YDIM*ZDIM,pitch);
	cudaBindTexture2D(0,&texRef_f3A, fA_d+pitch_elements*YDIM*ZDIM*3 ,&desc,XDIM,YDIM*ZDIM,pitch);
	cudaBindTexture2D(0,&texRef_f4A, fA_d+pitch_elements*YDIM*ZDIM*4 ,&desc,XDIM,YDIM*ZDIM,pitch);
	cudaBindTexture2D(0,&texRef_f5A, fA_d+pitch_elements*YDIM*ZDIM*5 ,&desc,XDIM,YDIM*ZDIM,pitch);
	cudaBindTexture2D(0,&texRef_f6A, fA_d+pitch_elements*YDIM*ZDIM*6 ,&desc,XDIM,YDIM*ZDIM,pitch);
	cudaBindTexture2D(0,&texRef_f7A, fA_d+pitch_elements*YDIM*ZDIM*7 ,&desc,XDIM,YDIM*ZDIM,pitch);
	cudaBindTexture2D(0,&texRef_f8A, fA_d+pitch_elements*YDIM*ZDIM*8 ,&desc,XDIM,YDIM*ZDIM,pitch);
	cudaBindTexture2D(0,&texRef_f9A, fA_d+pitch_elements*YDIM*ZDIM*9 ,&desc,XDIM,YDIM*ZDIM,pitch);
	cudaBindTexture2D(0,&texRef_f10A,fA_d+pitch_elements*YDIM*ZDIM*10,&desc,XDIM,YDIM*ZDIM,pitch);
	cudaBindTexture2D(0,&texRef_f11A,fA_d+pitch_elements*YDIM*ZDIM*11,&desc,XDIM,YDIM*ZDIM,pitch);
	cudaBindTexture2D(0,&texRef_f12A,fA_d+pitch_elements*YDIM*ZDIM*12,&desc,XDIM,YDIM*ZDIM,pitch);
	cudaBindTexture2D(0,&texRef_f13A,fA_d+pitch_elements*YDIM*ZDIM*13,&desc,XDIM,YDIM*ZDIM,pitch);
	cudaBindTexture2D(0,&texRef_f14A,fA_d+pitch_elements*YDIM*ZDIM*14,&desc,XDIM,YDIM*ZDIM,pitch);
	cudaBindTexture2D(0,&texRef_f15A,fA_d+pitch_elements*YDIM*ZDIM*15,&desc,XDIM,YDIM*ZDIM,pitch);
	cudaBindTexture2D(0,&texRef_f16A,fA_d+pitch_elements*YDIM*ZDIM*16,&desc,XDIM,YDIM*ZDIM,pitch);
	cudaBindTexture2D(0,&texRef_f17A,fA_d+pitch_elements*YDIM*ZDIM*17,&desc,XDIM,YDIM*ZDIM,pitch);
	cudaBindTexture2D(0,&texRef_f18A,fA_d+pitch_elements*YDIM*ZDIM*18,&desc,XDIM,YDIM*ZDIM,pitch);
	cudaBindTexture2D(0,&texRef_f0B, fB_d                            ,&desc,XDIM,YDIM*ZDIM,pitch);
	cudaBindTexture2D(0,&texRef_f1B, fB_d+pitch_elements*YDIM*ZDIM   ,&desc,XDIM,YDIM*ZDIM,pitch);
	cudaBindTexture2D(0,&texRef_f2B, fB_d+pitch_elements*YDIM*ZDIM*2 ,&desc,XDIM,YDIM*ZDIM,pitch);
	cudaBindTexture2D(0,&texRef_f3B, fB_d+pitch_elements*YDIM*ZDIM*3 ,&desc,XDIM,YDIM*ZDIM,pitch);
	cudaBindTexture2D(0,&texRef_f4B, fB_d+pitch_elements*YDIM*ZDIM*4 ,&desc,XDIM,YDIM*ZDIM,pitch);
	cudaBindTexture2D(0,&texRef_f5B, fB_d+pitch_elements*YDIM*ZDIM*5 ,&desc,XDIM,YDIM*ZDIM,pitch);
	cudaBindTexture2D(0,&texRef_f6B, fB_d+pitch_elements*YDIM*ZDIM*6 ,&desc,XDIM,YDIM*ZDIM,pitch);
	cudaBindTexture2D(0,&texRef_f7B, fB_d+pitch_elements*YDIM*ZDIM*7 ,&desc,XDIM,YDIM*ZDIM,pitch);
	cudaBindTexture2D(0,&texRef_f8B, fB_d+pitch_elements*YDIM*ZDIM*8 ,&desc,XDIM,YDIM*ZDIM,pitch);
	cudaBindTexture2D(0,&texRef_f9B, fB_d+pitch_elements*YDIM*ZDIM*9 ,&desc,XDIM,YDIM*ZDIM,pitch);
	cudaBindTexture2D(0,&texRef_f10B,fB_d+pitch_elements*YDIM*ZDIM*10,&desc,XDIM,YDIM*ZDIM,pitch);
	cudaBindTexture2D(0,&texRef_f11B,fB_d+pitch_elements*YDIM*ZDIM*11,&desc,XDIM,YDIM*ZDIM,pitch);
	cudaBindTexture2D(0,&texRef_f12B,fB_d+pitch_elements*YDIM*ZDIM*12,&desc,XDIM,YDIM*ZDIM,pitch);
	cudaBindTexture2D(0,&texRef_f13B,fB_d+pitch_elements*YDIM*ZDIM*13,&desc,XDIM,YDIM*ZDIM,pitch);
	cudaBindTexture2D(0,&texRef_f14B,fB_d+pitch_elements*YDIM*ZDIM*14,&desc,XDIM,YDIM*ZDIM,pitch);
	cudaBindTexture2D(0,&texRef_f15B,fB_d+pitch_elements*YDIM*ZDIM*15,&desc,XDIM,YDIM*ZDIM,pitch);
	cudaBindTexture2D(0,&texRef_f16B,fB_d+pitch_elements*YDIM*ZDIM*16,&desc,XDIM,YDIM*ZDIM,pitch);
	cudaBindTexture2D(0,&texRef_f17B,fB_d+pitch_elements*YDIM*ZDIM*17,&desc,XDIM,YDIM*ZDIM,pitch);
	cudaBindTexture2D(0,&texRef_f18B,fB_d+pitch_elements*YDIM*ZDIM*18,&desc,XDIM,YDIM*ZDIM,pitch);

//	if(REFINEMENT == "YES"){
	cudaBindTexture2D(0,&texRef_f0C, fC_d                                 ,&desc,XLRDIM,YLRDIM*ZLRDIM,pitch2);
	cudaBindTexture2D(0,&texRef_f1C, fC_d+pitch_elements2*YLRDIM*ZLRDIM   ,&desc,XLRDIM,YLRDIM*ZLRDIM,pitch2);
	cudaBindTexture2D(0,&texRef_f2C, fC_d+pitch_elements2*YLRDIM*ZLRDIM*2 ,&desc,XLRDIM,YLRDIM*ZLRDIM,pitch2);
	cudaBindTexture2D(0,&texRef_f3C, fC_d+pitch_elements2*YLRDIM*ZLRDIM*3 ,&desc,XLRDIM,YLRDIM*ZLRDIM,pitch2);
	cudaBindTexture2D(0,&texRef_f4C, fC_d+pitch_elements2*YLRDIM*ZLRDIM*4 ,&desc,XLRDIM,YLRDIM*ZLRDIM,pitch2);
	cudaBindTexture2D(0,&texRef_f5C, fC_d+pitch_elements2*YLRDIM*ZLRDIM*5 ,&desc,XLRDIM,YLRDIM*ZLRDIM,pitch2);
	cudaBindTexture2D(0,&texRef_f6C, fC_d+pitch_elements2*YLRDIM*ZLRDIM*6 ,&desc,XLRDIM,YLRDIM*ZLRDIM,pitch2);
	cudaBindTexture2D(0,&texRef_f7C, fC_d+pitch_elements2*YLRDIM*ZLRDIM*7 ,&desc,XLRDIM,YLRDIM*ZLRDIM,pitch2);
	cudaBindTexture2D(0,&texRef_f8C, fC_d+pitch_elements2*YLRDIM*ZLRDIM*8 ,&desc,XLRDIM,YLRDIM*ZLRDIM,pitch2);
	cudaBindTexture2D(0,&texRef_f9C, fC_d+pitch_elements2*YLRDIM*ZLRDIM*9 ,&desc,XLRDIM,YLRDIM*ZLRDIM,pitch2);
	cudaBindTexture2D(0,&texRef_f10C,fC_d+pitch_elements2*YLRDIM*ZLRDIM*10,&desc,XLRDIM,YLRDIM*ZLRDIM,pitch2);
	cudaBindTexture2D(0,&texRef_f11C,fC_d+pitch_elements2*YLRDIM*ZLRDIM*11,&desc,XLRDIM,YLRDIM*ZLRDIM,pitch2);
	cudaBindTexture2D(0,&texRef_f12C,fC_d+pitch_elements2*YLRDIM*ZLRDIM*12,&desc,XLRDIM,YLRDIM*ZLRDIM,pitch2);
	cudaBindTexture2D(0,&texRef_f13C,fC_d+pitch_elements2*YLRDIM*ZLRDIM*13,&desc,XLRDIM,YLRDIM*ZLRDIM,pitch2);
	cudaBindTexture2D(0,&texRef_f14C,fC_d+pitch_elements2*YLRDIM*ZLRDIM*14,&desc,XLRDIM,YLRDIM*ZLRDIM,pitch2);
	cudaBindTexture2D(0,&texRef_f15C,fC_d+pitch_elements2*YLRDIM*ZLRDIM*15,&desc,XLRDIM,YLRDIM*ZLRDIM,pitch2);
	cudaBindTexture2D(0,&texRef_f16C,fC_d+pitch_elements2*YLRDIM*ZLRDIM*16,&desc,XLRDIM,YLRDIM*ZLRDIM,pitch2);
	cudaBindTexture2D(0,&texRef_f17C,fC_d+pitch_elements2*YLRDIM*ZLRDIM*17,&desc,XLRDIM,YLRDIM*ZLRDIM,pitch2);
	cudaBindTexture2D(0,&texRef_f18C,fC_d+pitch_elements2*YLRDIM*ZLRDIM*18,&desc,XLRDIM,YLRDIM*ZLRDIM,pitch2);
	cudaBindTexture2D(0,&texRef_f0D, fD_d                                 ,&desc,XLRDIM,YLRDIM*ZLRDIM,pitch2);
	cudaBindTexture2D(0,&texRef_f1D, fD_d+pitch_elements2*YLRDIM*ZLRDIM   ,&desc,XLRDIM,YLRDIM*ZLRDIM,pitch2);
	cudaBindTexture2D(0,&texRef_f2D, fD_d+pitch_elements2*YLRDIM*ZLRDIM*2 ,&desc,XLRDIM,YLRDIM*ZLRDIM,pitch2);
	cudaBindTexture2D(0,&texRef_f3D, fD_d+pitch_elements2*YLRDIM*ZLRDIM*3 ,&desc,XLRDIM,YLRDIM*ZLRDIM,pitch2);
	cudaBindTexture2D(0,&texRef_f4D, fD_d+pitch_elements2*YLRDIM*ZLRDIM*4 ,&desc,XLRDIM,YLRDIM*ZLRDIM,pitch2);
	cudaBindTexture2D(0,&texRef_f5D, fD_d+pitch_elements2*YLRDIM*ZLRDIM*5 ,&desc,XLRDIM,YLRDIM*ZLRDIM,pitch2);
	cudaBindTexture2D(0,&texRef_f6D, fD_d+pitch_elements2*YLRDIM*ZLRDIM*6 ,&desc,XLRDIM,YLRDIM*ZLRDIM,pitch2);
	cudaBindTexture2D(0,&texRef_f7D, fD_d+pitch_elements2*YLRDIM*ZLRDIM*7 ,&desc,XLRDIM,YLRDIM*ZLRDIM,pitch2);
	cudaBindTexture2D(0,&texRef_f8D, fD_d+pitch_elements2*YLRDIM*ZLRDIM*8 ,&desc,XLRDIM,YLRDIM*ZLRDIM,pitch2);
	cudaBindTexture2D(0,&texRef_f9D, fD_d+pitch_elements2*YLRDIM*ZLRDIM*9 ,&desc,XLRDIM,YLRDIM*ZLRDIM,pitch2);
	cudaBindTexture2D(0,&texRef_f10D,fD_d+pitch_elements2*YLRDIM*ZLRDIM*10,&desc,XLRDIM,YLRDIM*ZLRDIM,pitch2);
	cudaBindTexture2D(0,&texRef_f11D,fD_d+pitch_elements2*YLRDIM*ZLRDIM*11,&desc,XLRDIM,YLRDIM*ZLRDIM,pitch2);
	cudaBindTexture2D(0,&texRef_f12D,fD_d+pitch_elements2*YLRDIM*ZLRDIM*12,&desc,XLRDIM,YLRDIM*ZLRDIM,pitch2);
	cudaBindTexture2D(0,&texRef_f13D,fD_d+pitch_elements2*YLRDIM*ZLRDIM*13,&desc,XLRDIM,YLRDIM*ZLRDIM,pitch2);
	cudaBindTexture2D(0,&texRef_f14D,fD_d+pitch_elements2*YLRDIM*ZLRDIM*14,&desc,XLRDIM,YLRDIM*ZLRDIM,pitch2);
	cudaBindTexture2D(0,&texRef_f15D,fD_d+pitch_elements2*YLRDIM*ZLRDIM*15,&desc,XLRDIM,YLRDIM*ZLRDIM,pitch2);
	cudaBindTexture2D(0,&texRef_f16D,fD_d+pitch_elements2*YLRDIM*ZLRDIM*16,&desc,XLRDIM,YLRDIM*ZLRDIM,pitch2);
	cudaBindTexture2D(0,&texRef_f17D,fD_d+pitch_elements2*YLRDIM*ZLRDIM*17,&desc,XLRDIM,YLRDIM*ZLRDIM,pitch2);
	cudaBindTexture2D(0,&texRef_f18D,fD_d+pitch_elements2*YLRDIM*ZLRDIM*18,&desc,XLRDIM,YLRDIM*ZLRDIM,pitch2);
//	}
	}


	initialize_single<<<grid, threads>>>(fA_d,pitch_elements);
	initialize_single<<<grid, threads>>>(fB_d,pitch_elements);
	if(REFINEMENT == "YES"){
	initialize_LR<<<grid2, threads2>>>(fC_d,pitch_elements2);
	}

//	cudaFuncSetCacheConfig(mrt_d_single,cudaFuncCachePreferL1);

	struct timeval tdr0,tdr1;
	double restime;
	cudaDeviceSynchronize();
	gettimeofday (&tdr0,NULL);
	for(int t = 0; t<TMAX; t=t+2){
		if(METHOD == "SINGLE"){
		mrt_d_single<<<grid, threads>>>(fA_d,fB_d,omega,pitch_elements);
		
		if(REFINEMENT == "YES"){
			LR_d_ABCD<<<grid2, threads2>>>(fC_d,fD_d,omega2,pitch_elements2);
			LR_d_ABDC<<<grid2, threads2>>>(fD_d,fC_d,omega2,pitch_elements2,SF_cf);
			
			//ExtractFromC_d<<<grid, threads>>>(fB_d,pitch_elements,SF_fc);
		}
		mrt_d_single<<<grid, threads>>>(fB_d,fA_d,omega,pitch_elements);

		if(REFINEMENT == "YES"){
			LR_d_BACD<<<grid2, threads2>>>(fC_d,fD_d,omega2,pitch_elements2);
			LR_d_BADC<<<grid2, threads2>>>(fD_d,fC_d,omega2,pitch_elements2,SF_cf);
	
			//ExtractFromC_d<<<grid, threads>>>(fA_d,pitch_elements,SF_fc);
		}
		}

		else if(METHOD == "HYB"){
		mrt_d_hybAB<<<grid, threads>>>(fA_d,fB_d,omega,pitch_elements);

		if(REFINEMENT == "YES"){
		LR_d_hybABCD<<<grid2, threads2>>>(fC_d,fD_d,omega2,pitch_elements2);
		LR_d_hybABDC<<<grid2, threads2>>>(fD_d,fC_d,omega2,pitch_elements2,SF_cf);
		
		ExtractFromC_d<<<grid, threads>>>(fB_d,pitch_elements,SF_fc);
		}


		mrt_d_hybBA<<<grid, threads>>>(fB_d,fA_d,omega,pitch_elements);

		if(REFINEMENT == "YES"){
		LR_d_hybABCD<<<grid2, threads2>>>(fC_d,fD_d,omega2,pitch_elements2);
		LR_d_hybBADC<<<grid2, threads2>>>(fD_d,fC_d,omega2,pitch_elements2,SF_cf);
		
		ExtractFromC_d<<<grid, threads>>>(fA_d,pitch_elements,SF_fc);
		}
		}

		else if(METHOD == "TEXT"){
		mrt_d_textAB<<<grid, threads>>>(fA_d,fB_d,omega,pitch_elements);
		mrt_d_textBA<<<grid, threads>>>(fB_d,fA_d,omega,pitch_elements);
		}

		else if(METHOD == "SHARED"){
		mrt_d_shared<<<grid, threads>>>(fA_d,fB_d,omega,pitch_elements);
		mrt_d_shared<<<grid, threads>>>(fB_d,fA_d,omega,pitch_elements);
		}

//		simple_copy<<<grid, threads>>>(fA_d,fB_d,image_d,omega,UMAX,XDIM,YDIM,ZDIM,pitch_elements);
//		simple_copy<<<grid, threads>>>(fB_d,fA_d,image_d,omega,UMAX,XDIM,YDIM,ZDIM,pitch_elements);

		if(t%1000 == 0 && t>0) cout<<"finished "<<t<<" timesteps\n";
	}
	cudaDeviceSynchronize();

	gettimeofday (&tdr1,NULL);
	timeval_subtract (&restime, &tdr1, &tdr0);
	int Nodes;
	if(REFINEMENT == "YES"){
		Nodes = (XDIM*YDIM*ZDIM+XLRDIM*YLRDIM*ZLRDIM*2);
	}
	else{
		Nodes = XDIM*YDIM*ZDIM;
	}
	cout<<"Time taken for main kernel: "<<restime<<" ("
			<<double(Nodes*double(TMAX/1000000.f))/restime<<"MLUPS)"<<endl;
//			<<double((XDIM*YDIM*ZDIM)*double(TMAX/1000000.f))/restime<<"MLUPS)"<<endl;
	cout<<XDIM<<","<<YDIM<<","<<ZDIM<<","<<TMAX<<","<<restime<<endl;

	if(true){
	cudaUnbindTexture(texRef_f0A);
	cudaUnbindTexture(texRef_f1A);
	cudaUnbindTexture(texRef_f2A);
	cudaUnbindTexture(texRef_f3A);
	cudaUnbindTexture(texRef_f4A);
	cudaUnbindTexture(texRef_f5A);
	cudaUnbindTexture(texRef_f6A);
	cudaUnbindTexture(texRef_f7A);
	cudaUnbindTexture(texRef_f8A);
	cudaUnbindTexture(texRef_f9A);
	cudaUnbindTexture(texRef_f10A);
	cudaUnbindTexture(texRef_f11A);
	cudaUnbindTexture(texRef_f12A);
	cudaUnbindTexture(texRef_f13A);
	cudaUnbindTexture(texRef_f14A);
	cudaUnbindTexture(texRef_f15A);
	cudaUnbindTexture(texRef_f16A);
	cudaUnbindTexture(texRef_f17A);
	cudaUnbindTexture(texRef_f18A);
	cudaUnbindTexture(texRef_f0B);
	cudaUnbindTexture(texRef_f1B);
	cudaUnbindTexture(texRef_f2B);
	cudaUnbindTexture(texRef_f3B);
	cudaUnbindTexture(texRef_f4B);
	cudaUnbindTexture(texRef_f5B);
	cudaUnbindTexture(texRef_f6B);
	cudaUnbindTexture(texRef_f7B);
	cudaUnbindTexture(texRef_f8B);
	cudaUnbindTexture(texRef_f9B);
	cudaUnbindTexture(texRef_f10B);
	cudaUnbindTexture(texRef_f11B);
	cudaUnbindTexture(texRef_f12B);
	cudaUnbindTexture(texRef_f13B);
	cudaUnbindTexture(texRef_f14B);
	cudaUnbindTexture(texRef_f15B);
	cudaUnbindTexture(texRef_f16B);
	cudaUnbindTexture(texRef_f17B);
	cudaUnbindTexture(texRef_f18B);

	cudaUnbindTexture(texRef_f0C);
	cudaUnbindTexture(texRef_f1C);
	cudaUnbindTexture(texRef_f2C);
	cudaUnbindTexture(texRef_f3C);
	cudaUnbindTexture(texRef_f4C);
	cudaUnbindTexture(texRef_f5C);
	cudaUnbindTexture(texRef_f6C);
	cudaUnbindTexture(texRef_f7C);
	cudaUnbindTexture(texRef_f8C);
	cudaUnbindTexture(texRef_f9C);
	cudaUnbindTexture(texRef_f10C);
	cudaUnbindTexture(texRef_f11C);
	cudaUnbindTexture(texRef_f12C);
	cudaUnbindTexture(texRef_f13C);
	cudaUnbindTexture(texRef_f14C);
	cudaUnbindTexture(texRef_f15C);
	cudaUnbindTexture(texRef_f16C);
	cudaUnbindTexture(texRef_f17C);
	cudaUnbindTexture(texRef_f18C);
	cudaUnbindTexture(texRef_f0D);
	cudaUnbindTexture(texRef_f1D);
	cudaUnbindTexture(texRef_f2D);
	cudaUnbindTexture(texRef_f3D);
	cudaUnbindTexture(texRef_f4D);
	cudaUnbindTexture(texRef_f5D);
	cudaUnbindTexture(texRef_f6D);
	cudaUnbindTexture(texRef_f7D);
	cudaUnbindTexture(texRef_f8D);
	cudaUnbindTexture(texRef_f9D);
	cudaUnbindTexture(texRef_f10D);
	cudaUnbindTexture(texRef_f11D);
	cudaUnbindTexture(texRef_f12D);
	cudaUnbindTexture(texRef_f13D);
	cudaUnbindTexture(texRef_f14D);
	cudaUnbindTexture(texRef_f15D);
	cudaUnbindTexture(texRef_f16D);
	cudaUnbindTexture(texRef_f17D);
	cudaUnbindTexture(texRef_f18D);
	}

	cudaMemcpy2D(fA_h,XDIM*sizeof(float),fA_d,pitch,XDIM*sizeof(float),YDIM*ZDIM*19,cudaMemcpyDeviceToHost);
	if(REFINEMENT == "YES"){
	cudaMemcpy2D(fC_h,XLRDIM*sizeof(float),fC_d,pitch2,XLRDIM*sizeof(float),YLRDIM*ZLRDIM*19,cudaMemcpyDeviceToHost);
	}

	//cudaMemcpy(image_h, image_d, memsize_int, cudaMemcpyDeviceToHost);

	output<<"VARIABLES = \"X\",\"Y\",\"Z\",\"u\",\"v\",\"w\",\"rho\"\n";
	output<<"ZONE F=POINT, I="<<XDIM<<", J="<<YDIM<<", K="<<ZDIM<<"\n";
	
	int row = 0;
	int col = 0;
	int dep = 0;
	i = 0;
	float rho, u, v, w;
	int j;

	for(dep = 0; dep<ZDIM; dep++){
	for(row = 0; row<YDIM; row++){
		for(col = 0; col<XDIM; col++){
			i = dep*XDIM*YDIM+row*XDIM+col;
//			rho = 0;
			rho = fA_h[i];
			for(j = 1; j<19; j++)
				rho+=fA_h[i+XDIM*YDIM*ZDIM*j];
//			rho = f0_h[i]+f1_h[i]+f2_h[i]+f3_h[i]+f4_h[i]+f5_h[i]+f6_h[i]+f7_h[i]+f8_h[i]+f9_h[i]+
//			      f10_h[i]+f11_h[i]+f12_h[i]+f13_h[i]+f14_h[i]+f15_h[i]+f16_h[i]+f17_h[i]+f18_h[i];
			u = fA_h[i+XDIM*YDIM*ZDIM*1]-fA_h[i+XDIM*YDIM*ZDIM*3]+fA_h[i+XDIM*YDIM*ZDIM*5]-fA_h[i+XDIM*YDIM*ZDIM*6]-
				fA_h[i+XDIM*YDIM*ZDIM*7]+fA_h[i+XDIM*YDIM*ZDIM*8]+fA_h[i+XDIM*YDIM*ZDIM*10]-fA_h[i+XDIM*YDIM*ZDIM*12]
				+fA_h[i+XDIM*YDIM*ZDIM*15]-fA_h[i+XDIM*YDIM*ZDIM*17];
			v = fA_h[i+XDIM*YDIM*ZDIM*2]-fA_h[i+XDIM*YDIM*ZDIM*4]+fA_h[i+XDIM*YDIM*ZDIM*5]+fA_h[i+XDIM*YDIM*ZDIM*6]-fA_h[i+XDIM*YDIM*ZDIM*7]-fA_h[i+XDIM*YDIM*ZDIM*8]+fA_h[i+XDIM*YDIM*ZDIM*11]-fA_h[i+XDIM*YDIM*ZDIM*13]+fA_h[i+XDIM*YDIM*ZDIM*16]-fA_h[i+XDIM*YDIM*ZDIM*18];
			w = fA_h[i+XDIM*YDIM*ZDIM*9]+fA_h[i+XDIM*YDIM*ZDIM*10]+fA_h[i+XDIM*YDIM*ZDIM*11]+fA_h[i+XDIM*YDIM*ZDIM*12]+fA_h[i+XDIM*YDIM*ZDIM*13]-fA_h[i+XDIM*YDIM*ZDIM*14]-fA_h[i+XDIM*YDIM*ZDIM*15]-fA_h[i+XDIM*YDIM*ZDIM*16]-fA_h[i+XDIM*YDIM*ZDIM*17]-fA_h[i+XDIM*YDIM*ZDIM*18];
			output<<col<<", "<<row<<", "<<dep<<", "<<u<<","<<v<<","<<w<<","<<rho<<endl;
//			output<<col<<", "<<row<<", "<<dep<<", "<<u<<","<<v<<","<<fA_h[i+XDIM*YDIM*ZDIM*1]<<","<<rho<<endl;
		}
	}
	}

	if(REFINEMENT == "YES"){
	output<<endl<<"VARIABLES = \"X\",\"Y\",\"Z\",\"u\",\"v\",\"w\",\"rho\"\n";
	output<<"ZONE F=POINT, I="<<XLRDIM-0<<", J="<<YLRDIM-0<<", K="<<ZLRDIM-0<<"\n";
	
	for(dep = 0; dep<ZLRDIM-0; dep++){
	for(row = 0; row<YLRDIM-0; row++){
		for(col = 0; col<XLRDIM-0; col++){
			i = dep*XLRDIM*YLRDIM+row*XLRDIM+col;
			rho = fC_h[i];
			for(j = 1; j<19; j++)
			
				rho+=fC_h[i+XLRDIM*YLRDIM*ZLRDIM*j];
				u = fC_h[i+XLRDIM*YLRDIM*ZLRDIM*1]-fC_h[i+XLRDIM*YLRDIM*ZLRDIM*3]+fC_h[i+XLRDIM*YLRDIM*ZLRDIM*5]-fC_h[i+XLRDIM*YLRDIM*ZLRDIM*6]-
				fC_h[i+XLRDIM*YLRDIM*ZLRDIM*7]+fC_h[i+XLRDIM*YLRDIM*ZLRDIM*8]+fC_h[i+XLRDIM*YLRDIM*ZLRDIM*10]-fC_h[i+XLRDIM*YLRDIM*ZLRDIM*12]
				+fC_h[i+XLRDIM*YLRDIM*ZLRDIM*15]-fC_h[i+XLRDIM*YLRDIM*ZLRDIM*17];
				v = fC_h[i+XLRDIM*YLRDIM*ZLRDIM*2]-fC_h[i+XLRDIM*YLRDIM*ZLRDIM*4]+fC_h[i+XLRDIM*YLRDIM*ZLRDIM*5]+fC_h[i+XLRDIM*YLRDIM*ZLRDIM*6]-fC_h[i+XLRDIM*YLRDIM*ZLRDIM*7]-fC_h[i+XLRDIM*YLRDIM*ZLRDIM*8]+fC_h[i+XLRDIM*YLRDIM*ZLRDIM*11]-fC_h[i+XLRDIM*YLRDIM*ZLRDIM*13]+fC_h[i+XLRDIM*YLRDIM*ZLRDIM*16]-fC_h[i+XLRDIM*YLRDIM*ZLRDIM*18];
				w = fC_h[i+XLRDIM*YLRDIM*ZLRDIM*9]+fC_h[i+XLRDIM*YLRDIM*ZLRDIM*10]+fC_h[i+XLRDIM*YLRDIM*ZLRDIM*11]+fC_h[i+XLRDIM*YLRDIM*ZLRDIM*12]+fC_h[i+XLRDIM*YLRDIM*ZLRDIM*13]-fC_h[i+XLRDIM*YLRDIM*ZLRDIM*14]-fC_h[i+XLRDIM*YLRDIM*ZLRDIM*15]-fC_h[i+XLRDIM*YLRDIM*ZLRDIM*16]-fC_h[i+XLRDIM*YLRDIM*ZLRDIM*17]-fC_h[i+XLRDIM*YLRDIM*ZLRDIM*18];
			output<<LRX0+col*LRFACTOR<<", "<<LRY0+row*LRFACTOR<<", "<<LRZ0+dep*LRFACTOR<<", "<<u<<","<<v<<","<<w<<","<<rho<<endl;


		}
	}
	}
	}

	output.close();


	//cudaFree(image_d);


	cudaFree(fA_d);
	cudaFree(fB_d);
	cudaFree(fC_d);
	cudaFree(fD_d);
	return(0);

}
