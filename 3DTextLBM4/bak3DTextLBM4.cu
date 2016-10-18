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

#include <sys/time.h>
#include <time.h>

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
//	float usqr = u*u+v*v+w*w;
	float usqr = fma(u,u,fma(v,v,w*w));

	f0 -= omega*fma(-0.3333333333f,(fma(-1.5f,usqr,rho)),f0);//(f0 -0.3333333333f*(fma(-1.5f,usqr,rho)));//rho-1.5f*usqr));
	f1 -= omega*fma(-0.0555555556f,fma(3.0f,    u ,rho)+fma(4.5f,u*u,-1.5f*usqr),f1);//(f1 -0.0555555556f*(rho+3.0f*u+4.5f*u*u-1.5f*usqr));                
	f2 -= omega*fma(-0.0555555556f,fma(3.0f,    v ,rho)+fma(4.5f,v*v,-1.5f*usqr),f2);//(f1 -0.0555555556f*(rho+3.0f*u+4.5f*u*u-1.5f*usqr));                
	f3 -= omega*fma(-0.0555555556f,fma(3.0f,    u ,rho)+fma(4.5f,u*u,-1.5f*usqr),f3);//(f1 -0.0555555556f*(rho+3.0f*u+4.5f*u*u-1.5f*usqr));                
	f4 -= omega*fma(-0.0555555556f,fma(3.0f,    v ,rho)+fma(4.5f,v*v,-1.5f*usqr),f4);//(f1 -0.0555555556f*(rho+3.0f*u+4.5f*u*u-1.5f*usqr));                
	f5 -= omega*fma(-0.0555555556f,fma(3.0f,( u+v),rho)+fma(4.5f,( u+v)*( u+v),-1.5f*usqr),f5 );//(f1 -0.0555555556f*(rho+3.0f*u+4.5f*u*u-1.5f*usqr));                
	f6 -= omega*fma(-0.0555555556f,fma(3.0f,(-u+v),rho)+fma(4.5f,(-u+v)*(-u+v),-1.5f*usqr),f6 );//(f1 -0.0555555556f*(rho+3.0f*u+4.5f*u*u-1.5f*usqr));                
	f7 -= omega*fma(-0.0555555556f,fma(3.0f,(-u-v),rho)+fma(4.5f,(-u-v)*(-u-v),-1.5f*usqr),f7 );//(f1 -0.0555555556f*(rho+3.0f*u+4.5f*u*u-1.5f*usqr));                
	f8 -= omega*fma(-0.0555555556f,fma(3.0f,( u-v),rho)+fma(4.5f,( u-v)*( u-v),-1.5f*usqr),f8 );//(f1 -0.0555555556f*(rho+3.0f*u+4.5f*u*u-1.5f*usqr));                
	f9 -= omega*fma(-0.0555555556f,fma(3.0f,(   w),rho)+fma(4.5f,(   w)*(   w),-1.5f*usqr),f9 );//(f1 -0.0555555556f*(rho+3.0f*u+4.5f*u*u-1.5f*usqr));                
	f10-= omega*fma(-0.0277777778f,fma(3.0f,( u+w),rho)+fma(4.5f,( u+w)*( u+w),-1.5f*usqr),f10);//(f1 -0.0555555556f*(rho+3.0f*u+4.5f*u*u-1.5f*usqr));                
	f11-= omega*fma(-0.0277777778f,fma(3.0f,( v+w),rho)+fma(4.5f,( v+w)*( v+w),-1.5f*usqr),f11);//(f1 -0.0555555556f*(rho+3.0f*u+4.5f*u*u-1.5f*usqr));                
	f12-= omega*fma(-0.0277777778f,fma(3.0f,(-u+w),rho)+fma(4.5f,(-u+w)*(-u+w),-1.5f*usqr),f12);//(f1 -0.0555555556f*(rho+3.0f*u+4.5f*u*u-1.5f*usqr));                
	f13-= omega*fma(-0.0277777778f,fma(3.0f,(-v+w),rho)+fma(4.5f,(-v+w)*(-v+w),-1.5f*usqr),f13);//(f1 -0.0555555556f*(rho+3.0f*u+4.5f*u*u-1.5f*usqr));                
	f14-= omega*fma(-0.0555555556f,fma(3.0f,(  -w),rho)+fma(4.5f,(  -w)*(  -w),-1.5f*usqr),f14);//(f1 -0.0555555556f*(rho+3.0f*u+4.5f*u*u-1.5f*usqr));                
	f15-= omega*fma(-0.0277777778f,fma(3.0f,( u-w),rho)+fma(4.5f,( u-w)*( u-w),-1.5f*usqr),f15);//(f1 -0.0555555556f*(rho+3.0f*u+4.5f*u*u-1.5f*usqr));                
	f16-= omega*fma(-0.0277777778f,fma(3.0f,( v-w),rho)+fma(4.5f,( v-w)*( v-w),-1.5f*usqr),f16);//(f1 -0.0555555556f*(rho+3.0f*u+4.5f*u*u-1.5f*usqr));                
	f17-= omega*fma(-0.0277777778f,fma(3.0f,(-u-w),rho)+fma(4.5f,(-u-w)*(-u-w),-1.5f*usqr),f17);//(f1 -0.0555555556f*(rho+3.0f*u+4.5f*u*u-1.5f*usqr));                
	f18-= omega*fma(-0.0277777778f,fma(3.0f,(-v-w),rho)+fma(4.5f,(-v-w)*(-v-w),-1.5f*usqr),f18);//(f1 -0.0555555556f*(rho+3.0f*u+4.5f*u*u-1.5f*usqr));                
	
//	f0 = f0 -omega*(f0 -0.3333333333f*(rho-1.5f*usqr));
//	f1 = f1 -omega*(f1 -0.0555555556f*(rho+3.0f*u+4.5f*u*u-1.5f*usqr));                
//	f2 = f2 -omega*(f2 -0.0555555556f*(rho+3.0f*v+4.5f*v*v-1.5f*usqr));
//	f3 = f3 -omega*(f3 -0.0555555556f*(rho-3.0f*u+4.5f*u*u-1.5f*usqr));
//	f4 = f4 -omega*(f4 -0.0555555556f*(rho-3.0f*v+4.5f*v*v-1.5f*usqr));
//	f5 = f5 -omega*(f5 -0.0277777778f*(rho+3.0f*(u+v)+4.5f*(u+v)*(u+v)-1.5f*usqr));
//	f6 = f6 -omega*(f6 -0.0277777778f*(rho+3.0f*(-u+v)+4.5f*(-u+v)*(-u+v)-1.5f*usqr));
//	f7 = f7 -omega*(f7 -0.0277777778f*(rho+3.0f*(-u-v)+4.5f*(-u-v)*(-u-v)-1.5f*usqr));
//	f8 = f8 -omega*(f8 -0.0277777778f*(rho+3.0f*(u-v)+4.5f*(u-v)*(u-v)-1.5f*usqr));
//	f9 = f9 -omega*(f9 -0.0555555556f*(rho+3.0f*w+4.5f*w*w-1.5f*usqr));
//	f10= f10-omega*(f10-0.0277777778f*(rho+3.0f*(u+w)+4.5f*(u+w)*(u+w)-1.5f*usqr));
//	f11= f11-omega*(f11-0.0277777778f*(rho+3.0f*(v+w)+4.5f*(v+w)*(u+w)-1.5f*usqr));
//	f12= f12-omega*(f12-0.0277777778f*(rho+3.0f*(-u+w)+4.5f*(-u+w)*(-u+w)-1.5f*usqr));
//	f13= f13-omega*(f13-0.0277777778f*(rho+3.0f*(-v+w)+4.5f*(-v+w)*(u+w)-1.5f*usqr));
//	f14= f14-omega*(f14-0.0555555556f*(rho-3.0f*w+4.5f*w*w-1.5f*usqr));
//	f15= f15-omega*(f15-0.0277777778f*(rho+3.0f*(u-w)+4.5f*(u-w)*(u-w)-1.5f*usqr));
//	f16= f16-omega*(f16-0.0277777778f*(rho+3.0f*(v-w)+4.5f*(v-w)*(v-w)-1.5f*usqr));
//	f17= f17-omega*(f17-0.0277777778f*(rho+3.0f*(-u-w)+4.5f*(-u-w)*(-u-w)-1.5f*usqr));
//	f18= f18-omega*(f18-0.0277777778f*(rho+3.0f*(-v-w)+4.5f*(-v-w)*(-v-w)-1.5f*usqr));


}


__device__ void mrt_collide(float& f0, float& f1, float& f2,
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
	m2 -= -7.53968254f*(u*u+v*v+w*w);
	m4 -= -0.66666667f*u;//qx_eq
	m6 -= -0.66666667f*v;//qx_eq
	m8 -= -0.66666667f*w;//qx_eq
	m9 -= (2.f*u*u-(v*v+w*w));//(2.f*.f*.f-(u1*u1+u2*u2));///3.f;//pxx_eq
	m11-= (v*v-w*w);//pww_eq
	m13-= u*v;//pxy_eq
	m14-= v*w;//pyz_eq
	m15-= u*w;//pxz_eq

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


__device__ int f_mem(int f_num, int x, int y, int z, size_t pitch, int height, int depth)
{
//	if (x<0 || x>pitch || y<0 || y>height || z<0 || z>depth) return 0;
//	else
		return (x+y*pitch+z*height*pitch)+f_num*pitch*height*depth;
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
							int *image, float omega, float uMax,
							int width, int height, int depth, size_t pitch)//pitch in elements
{
	int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
	int y = threadIdx.y+blockIdx.y*blockDim.y;
	int z = threadIdx.z+blockIdx.z*blockDim.z;
	int j = x+y*pitch+z*height*pitch;//index on padded mem (pitch in elements)

//	fB[f_mem(1 ,x,y,z,pitch,height,depth)] = fA[f_mem(1 ,x,y,z,pitch,height,depth)];
//	fB[f_mem(2 ,x,y,z,pitch,height,depth)] = fA[f_mem(2 ,x,y,z,pitch,height,depth)];
//	fB[f_mem(3 ,x,y,z,pitch,height,depth)] = fA[f_mem(3 ,x,y,z,pitch,height,depth)];
//	fB[f_mem(4 ,x,y,z,pitch,height,depth)] = fA[f_mem(4 ,x,y,z,pitch,height,depth)];
//	fB[f_mem(5 ,x,y,z,pitch,height,depth)] = fA[f_mem(5 ,x,y,z,pitch,height,depth)];
//	fB[f_mem(6 ,x,y,z,pitch,height,depth)] = fA[f_mem(6 ,x,y,z,pitch,height,depth)];
//	fB[f_mem(7 ,x,y,z,pitch,height,depth)] = fA[f_mem(7 ,x,y,z,pitch,height,depth)];
//	fB[f_mem(8 ,x,y,z,pitch,height,depth)] = fA[f_mem(8 ,x,y,z,pitch,height,depth)];
//	fB[f_mem(9 ,x,y,z,pitch,height,depth)] = fA[f_mem(9 ,x,y,z,pitch,height,depth)];
//	fB[f_mem(10,x,y,z,pitch,height,depth)] = fA[f_mem(10,x,y,z,pitch,height,depth)];
//	fB[f_mem(11,x,y,z,pitch,height,depth)] = fA[f_mem(11,x,y,z,pitch,height,depth)];
//	fB[f_mem(12,x,y,z,pitch,height,depth)] = fA[f_mem(12,x,y,z,pitch,height,depth)];
//	fB[f_mem(13,x,y,z,pitch,height,depth)] = fA[f_mem(13,x,y,z,pitch,height,depth)];
//	fB[f_mem(14,x,y,z,pitch,height,depth)] = fA[f_mem(14,x,y,z,pitch,height,depth)];
//	fB[f_mem(15,x,y,z,pitch,height,depth)] = fA[f_mem(15,x,y,z,pitch,height,depth)];
//	fB[f_mem(16,x,y,z,pitch,height,depth)] = fA[f_mem(16,x,y,z,pitch,height,depth)];
//	fB[f_mem(17,x,y,z,pitch,height,depth)] = fA[f_mem(17,x,y,z,pitch,height,depth)];
//	fB[f_mem(18,x,y,z,pitch,height,depth)] = fA[f_mem(18,x,y,z,pitch,height,depth)];
	
//	float f0;//,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18;
//	float f0  = fA[j+pitch*height*depth];
//	float f0  = fA[f_mem(0 ,x,y,z,pitch,height,depth)];
//	f0  = tex2D(texRef_f0A ,x,y+height*z);
//	f1  = tex2D(texRef_f1A ,x,y+height*z);
//	f2  = tex2D(texRef_f2A ,x,y+height*z);
//	f3  = tex2D(texRef_f3A ,x,y+height*z);
//	f4  = tex2D(texRef_f4A ,x,y+height*z);
//	f5  = tex2D(texRef_f5A ,x,y+height*z);
//	f6  = tex2D(texRef_f6A ,x,y+height*z);
//	f7  = tex2D(texRef_f7A ,x,y+height*z);
//	f8  = tex2D(texRef_f8A ,x,y+height*z);
//	f9  = tex2D(texRef_f9A ,x,y+height*z);
//	f10 = tex2D(texRef_f10A,x,y+height*z);
//	f11 = tex2D(texRef_f11A,x,y+height*z);
//	f12 = tex2D(texRef_f12A,x,y+height*z);
//	f13 = tex2D(texRef_f13A,x,y+height*z);
//	f14 = tex2D(texRef_f14A,x,y+height*z);
//	f15 = tex2D(texRef_f15A,x,y+height*z);
//	f16 = tex2D(texRef_f16A,x,y+height*z);
//	f17 = tex2D(texRef_f17A,x,y+height*z);
//	f18 = tex2D(texRef_f18A,x,y+height*z);
//	float f1  = fA[f_mem(1 ,x,y,z,pitch,height,depth)];
//	f1  = fA[f_mem(1 ,x,y,z,pitch,height,depth)];
//	f2  = fA[f_mem(2 ,x,y,z,pitch,height,depth)];
//	f3  = fA[f_mem(3 ,x,y,z,pitch,height,depth)];
//	f4  = fA[f_mem(4 ,x,y,z,pitch,height,depth)];
//	f5  = fA[f_mem(5 ,x,y,z,pitch,height,depth)];
//	f6  = fA[f_mem(6 ,x,y,z,pitch,height,depth)];
//	f7  = fA[f_mem(7 ,x,y,z,pitch,height,depth)];
//	f8  = fA[f_mem(8 ,x,y,z,pitch,height,depth)];
//	f9  = fA[f_mem(9 ,x,y,z,pitch,height,depth)];
//	f10 = fA[f_mem(10,x,y,z,pitch,height,depth)];
//	f11 = fA[f_mem(11,x,y,z,pitch,height,depth)];
//	f12 = fA[f_mem(12,x,y,z,pitch,height,depth)];
//	f13 = fA[f_mem(13,x,y,z,pitch,height,depth)];
//	f14 = fA[f_mem(14,x,y,z,pitch,height,depth)];
//	f15 = fA[f_mem(15,x,y,z,pitch,height,depth)];
//	f16 = fA[f_mem(16,x,y,z,pitch,height,depth)];
//	f17 = fA[f_mem(17,x,y,z,pitch,height,depth)];
//	f18 = fA[f_mem(18,x,y,z,pitch,height,depth)];

//	fB[f_mem(0 ,x,y,z,pitch,height,depth)] = fA[f_mem(0 ,x,y,z,pitch,height,depth)];//+0.01f;
	fB[j] = fA[j];//+0.01f;
//	fB[j+pitch*height*depth+pitch*height*depth] = f2;
//	fB[(x+y*pitch+z*height*pitch)+pitch*height*depth] = f1 ;//+0.01f;
//	fB[f_mem(0 ,x,y,z,pitch,height,depth)] = f0 ;
//	fB[f_mem(1 ,x,y,z,pitch,height,depth)] = f1;//fA[f_mem(1 ,x,y,z,pitch,height,depth)];
//	fB[f_mem(2 ,x,y,z,pitch,height,depth)] = f2 ;//+0.01f;
//	fB[f_mem(3 ,x,y,z,pitch,height,depth)] = f3 ;//+0.01f;
//	fB[f_mem(4 ,x,y,z,pitch,height,depth)] = f4 ;//+0.01f;
//	fB[f_mem(5 ,x,y,z,pitch,height,depth)] = f5 ;//+0.01f;
//	fB[f_mem(6 ,x,y,z,pitch,height,depth)] = f6 ;//+0.01f;
//	fB[f_mem(7 ,x,y,z,pitch,height,depth)] = f7 ;//+0.01f;
//	fB[f_mem(8 ,x,y,z,pitch,height,depth)] = f8 ;//+0.01f;
//	fB[f_mem(9 ,x,y,z,pitch,height,depth)] = f9 ;//+0.01f;
//	fB[f_mem(10,x,y,z,pitch,height,depth)] = f10;//+0.01f;
//	fB[f_mem(11,x,y,z,pitch,height,depth)] = f11;//+0.01f;
//	fB[f_mem(12,x,y,z,pitch,height,depth)] = f12;//+0.01f;
//	fB[f_mem(13,x,y,z,pitch,height,depth)] = f13;//+0.01f;
//	fB[f_mem(14,x,y,z,pitch,height,depth)] = f14;//+0.01f;
//	fB[f_mem(15,x,y,z,pitch,height,depth)] = f15;//+0.01f;
//	fB[f_mem(16,x,y,z,pitch,height,depth)] = f16;//+0.01f;
//	fB[f_mem(17,x,y,z,pitch,height,depth)] = f17;//+0.01f;
//	fB[f_mem(18,x,y,z,pitch,height,depth)] = f18;//+0.01f;

}

//int const blockx = 192;
//int const blocky = 1;

__global__ void mrt_d_hybAB(float* fin, float* fout,
							int *image, float omega, float uMax,
							int width, int height, int depth, size_t pitch)//pitch in elements
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
		float f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18;
//		f1 = fin[f_mem(3 ,dmin(x+1,width),y               ,z               ,pitch,height,depth)];
//		f3 = fin[f_mem(1 ,dmax(x-1)      ,y               ,z               ,pitch,height,depth)];
//		f5 = fin[f_mem(7 ,dmin(x+1,width),dmin(y+1,height),z               ,pitch,height,depth)];
//		f7 = fin[f_mem(5 ,dmax(x-1)      ,dmax(y-1)       ,z               ,pitch,height,depth)];
//		f6 = fin[f_mem(8 ,dmax(x-1)      ,dmin(y+1,height),z               ,pitch,height,depth)];
//		f8 = fin[f_mem(6 ,dmin(x+1,width),dmax(y-1)       ,z               ,pitch,height,depth)];
//		f10= fin[f_mem(17,dmin(x+1,width),y               ,dmin(z+1,depth) ,pitch,height,depth)];
//		f12= fin[f_mem(15,dmax(x-1)      ,y               ,dmin(z+1,depth) ,pitch,height,depth)];
//		f15= fin[f_mem(12,dmin(x+1,width),y               ,dmax(z-1)       ,pitch,height,depth)];
//		f17= fin[f_mem(10,dmax(x-1)      ,y               ,dmax(z-1)       ,pitch,height,depth)];
		f2 = fin[f_mem(4 ,x              ,dmin(y+1,height),z               ,pitch,height,depth)];
		f4 = fin[f_mem(2 ,x              ,dmax(y-1)       ,z               ,pitch,height,depth)];
		f9 = fin[f_mem(14,x              ,y               ,dmin(z+1,depth) ,pitch,height,depth)];
		f11= fin[f_mem(18,x              ,dmin(y+1,height),dmin(z+1,depth) ,pitch,height,depth)];
		f13= fin[f_mem(16,x              ,dmax(y-1)       ,dmin(z+1,depth) ,pitch,height,depth)];
		f14= fin[f_mem(9 ,x              ,y               ,dmax(z-1)       ,pitch,height,depth)];
		f16= fin[f_mem(13,x              ,dmin(y+1,height),dmax(z-1)       ,pitch,height,depth)];
		f18= fin[f_mem(11,x              ,dmax(y-1)       ,dmax(z-1)       ,pitch,height,depth)];
		f3 = tex2D(texRef_f1A ,x-1,(y  )+height*(z));
		f1 = tex2D(texRef_f3A ,x+1,(y  )+height*(z));
		f5 = tex2D(texRef_f7A ,x+1,(y+1)+height*(z));
		f6 = tex2D(texRef_f8A ,x-1,(y+1)+height*(z));
		f7 = tex2D(texRef_f5A ,x-1,(y-1)+height*(z));
		f8 = tex2D(texRef_f6A ,x+1,(y-1)+height*(z));
		f10= tex2D(texRef_f17A,x+1,(y  )+height*(z+1));
		f12= tex2D(texRef_f15A,x-1,(y  )+height*(z+1));
		f17= tex2D(texRef_f10A,x-1,(y  )+height*(z-1));
		f15= tex2D(texRef_f12A,x+1,(y  )+height*(z-1));
		fout[j+pitch*height*depth*1 ] = f1 ;
		fout[j+pitch*height*depth*2 ] = f2 ;
		fout[j+pitch*height*depth*3 ] = f3 ;
		fout[j+pitch*height*depth*4 ] = f4 ;
		fout[j+pitch*height*depth*5 ] = f5 ;
		fout[j+pitch*height*depth*6 ] = f6 ;
		fout[j+pitch*height*depth*7 ] = f7 ;
		fout[j+pitch*height*depth*8 ] = f8 ;
		fout[j+pitch*height*depth*9 ] = f9 ;
		fout[j+pitch*height*depth*10] = f10;
		fout[j+pitch*height*depth*11] = f11;
		fout[j+pitch*height*depth*12] = f12;
		fout[j+pitch*height*depth*13] = f13;
		fout[j+pitch*height*depth*14] = f14;
		fout[j+pitch*height*depth*15] = f15;
		fout[j+pitch*height*depth*16] = f16;
		fout[j+pitch*height*depth*17] = f17;
		fout[j+pitch*height*depth*18] = f18;
	}
	else{
		float f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18;
//		f1 = fin[f_mem(1 ,x-1,y  ,z  ,pitch,height,depth)];
//		f3 = fin[f_mem(3 ,x+1,y  ,z  ,pitch,height,depth)];
//		f5 = fin[f_mem(5 ,x-1,y-1,z  ,pitch,height,depth)];
//		f6 = fin[f_mem(6 ,x+1,y-1,z  ,pitch,height,depth)];
//		f7 = fin[f_mem(7 ,x+1,y+1,z  ,pitch,height,depth)];
//		f8 = fin[f_mem(8 ,x-1,y+1,z  ,pitch,height,depth)];
//		f10= fin[f_mem(10,x-1,y  ,z-1,pitch,height,depth)];
//		f12= fin[f_mem(12,x+1,y  ,z-1,pitch,height,depth)];
//		f15= fin[f_mem(15,x-1,y  ,z+1,pitch,height,depth)];
//		f17= fin[f_mem(17,x+1,y  ,z+1,pitch,height,depth)];

		f0 = fin[j];
		f2 = fin[f_mem(2 ,x  ,y-1,z  ,pitch,height,depth)];
		f4 = fin[f_mem(4 ,x  ,y+1,z  ,pitch,height,depth)];
		f9 = fin[f_mem(9 ,x  ,y  ,z-1,pitch,height,depth)];
		f11= fin[f_mem(11,x  ,y-1,z-1,pitch,height,depth)];
		f13= fin[f_mem(13,x  ,y+1,z-1,pitch,height,depth)];
		f14= fin[f_mem(14,x  ,y  ,z+1,pitch,height,depth)];
		f16= fin[f_mem(16,x  ,y-1,z+1,pitch,height,depth)];
		f18= fin[f_mem(18,x  ,y+1,z+1,pitch,height,depth)];
		f1 = tex2D(texRef_f1A ,x-1,y  +height*(z));
		f3 = tex2D(texRef_f3A ,x+1,y  +height*(z));
		f5 = tex2D(texRef_f5A ,x-1,y-1+height*(z));
		f6 = tex2D(texRef_f6A ,x+1,y-1+height*(z));
		f7 = tex2D(texRef_f7A ,x+1,y+1+height*(z));
		f8 = tex2D(texRef_f8A ,x-1,y+1+height*(z));
		f15= tex2D(texRef_f15A,x-1,y  +height*(z+1));
		f17= tex2D(texRef_f17A,x+1,y  +height*(z+1));
		f10= tex2D(texRef_f10A,x-1,y  +height*(z-1));
		f12= tex2D(texRef_f12A,x+1,y  +height*(z-1));

		if(im == 3)//DirichletWest
		{
			if(y == 0){
				f2 = f4;
				f6 = f7;
				f11 = f13;
				f16 = f18;
			}
			else if(y == height-1){
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
			if(z == depth-1){
				f14 = f9;
				f15 = f10;
				f16 = f11;
				f17 = f12;
				f18 = f13;
			}
//			float fInt1,fInt2;//,fDiff;
			float u,v,w,rho;
	        u = 0.0f;//*PoisProf(zcoord)*1.5;
	        v = uMax;//0.0;
			w = 0.0f;
	        
//			fInt1 = f0+f2+f4+f9+f11+f13+f14+f16+f18;
//	        fInt2 = f3+f6+f7+f12+f17;
//        	rho = u+(fInt1+2.0f*fInt2); //D2Q9i
			
        	rho = u+(f0+f2+f4+f9+f11+f13+f14+f16+f18+2.0f*(f3+f6+f7+f12+f17)); //D2Q9i

			float usqr = u*u+v*v+w*w;
			f1 = 0.0555555556f*(rho+3.0f*u+4.5f*u*u-1.5f*usqr)+f3-0.0555555556f*(rho-3.0f*u+4.5f*u*u-1.5f*usqr);;
			f5 = 0.0277777778f*(rho+3.0f*(u+v)+4.5f*(u+v)*(u+v)-1.5f*usqr)+f7 -0.0277777778f*(rho+3.0f*(-u-v)+4.5f*(-u-v)*(-u-v)-1.5f*usqr);
			f8 = 0.0277777778f*(rho+3.0f*(u-v)+4.5f*(u-v)*(u-v)-1.5f*usqr)+f6 -0.0277777778f*(rho+3.0f*(-u+v)+4.5f*(-u+v)*(-u+v)-1.5f*usqr);
			f10= 0.0277777778f*(rho+3.0f*(u+w)+4.5f*(u+w)*(u+w)-1.5f*usqr)+f17-0.0277777778f*(rho+3.0f*(-u-w)+4.5f*(-u-w)*(-u-w)-1.5f*usqr);
			f15= 0.0277777778f*(rho+3.0f*(u-w)+4.5f*(u-w)*(u-w)-1.5f*usqr)+f12-0.0277777778f*(rho+3.0f*(-u+w)+4.5f*(-u+w)*(-u+w)-1.5f*usqr);
		}

		//mrt_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,omega);
		bgk_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,omega);


		fout[f_mem(0 ,x,y,z,pitch,height,depth)] = f0 ;
		fout[f_mem(1 ,x,y,z,pitch,height,depth)] = f1 ;
		fout[f_mem(2 ,x,y,z,pitch,height,depth)] = f2 ;
		fout[f_mem(3 ,x,y,z,pitch,height,depth)] = f3 ;
		fout[f_mem(4 ,x,y,z,pitch,height,depth)] = f4 ;
		fout[f_mem(5 ,x,y,z,pitch,height,depth)] = f5 ;
		fout[f_mem(6 ,x,y,z,pitch,height,depth)] = f6 ;
		fout[f_mem(7 ,x,y,z,pitch,height,depth)] = f7 ;
		fout[f_mem(8 ,x,y,z,pitch,height,depth)] = f8 ;
		fout[f_mem(9 ,x,y,z,pitch,height,depth)] = f9 ;
		fout[f_mem(10,x,y,z,pitch,height,depth)] = f10;
		fout[f_mem(11,x,y,z,pitch,height,depth)] = f11;
		fout[f_mem(12,x,y,z,pitch,height,depth)] = f12;
		fout[f_mem(13,x,y,z,pitch,height,depth)] = f13;
		fout[f_mem(14,x,y,z,pitch,height,depth)] = f14;
		fout[f_mem(15,x,y,z,pitch,height,depth)] = f15;
		fout[f_mem(16,x,y,z,pitch,height,depth)] = f16;
		fout[f_mem(17,x,y,z,pitch,height,depth)] = f17;
		fout[f_mem(18,x,y,z,pitch,height,depth)] = f18;
	}
}
__global__ void mrt_d_hybBA(float* fin, float* fout,
							int *image, float omega, float uMax,
							int width, int height, int depth, size_t pitch)//pitch in elements
{
	int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
	int y = threadIdx.y+blockIdx.y*blockDim.y;
	int z = threadIdx.z+blockIdx.z*blockDim.z;
	int i = x+y*width+z*width*height;//index on linear mem
	int j = x+y*pitch+z*height*pitch;//index on padded mem (pitch in elements)
	int im = image[i];
	if(im == 1){//BB
		float f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18;
		f2 = fin[f_mem(4 ,x              ,dmin(y+1,height),z               ,pitch,height,depth)];
		f4 = fin[f_mem(2 ,x              ,dmax(y-1)       ,z               ,pitch,height,depth)];
		f9 = fin[f_mem(14,x              ,y               ,dmin(z+1,depth) ,pitch,height,depth)];
		f11= fin[f_mem(18,x              ,dmin(y+1,height),dmin(z+1,depth) ,pitch,height,depth)];
		f13= fin[f_mem(16,x              ,dmax(y-1)       ,dmin(z+1,depth) ,pitch,height,depth)];
		f14= fin[f_mem(9 ,x              ,y               ,dmax(z-1)       ,pitch,height,depth)];
		f16= fin[f_mem(13,x              ,dmin(y+1,height),dmax(z-1)       ,pitch,height,depth)];
		f18= fin[f_mem(11,x              ,dmax(y-1)       ,dmax(z-1)       ,pitch,height,depth)];
		f3 = tex2D(texRef_f1B ,x-1,(y  )+height*(z));
		f1 = tex2D(texRef_f3B ,x+1,(y  )+height*(z));
		f5 = tex2D(texRef_f7B ,x+1,(y+1)+height*(z));
		f6 = tex2D(texRef_f8B ,x-1,(y+1)+height*(z));
		f7 = tex2D(texRef_f5B ,x-1,(y-1)+height*(z));
		f8 = tex2D(texRef_f6B ,x+1,(y-1)+height*(z));
		f10= tex2D(texRef_f17B,x+1,(y  )+height*(z+1));
		f12= tex2D(texRef_f15B,x-1,(y  )+height*(z+1));
		f17= tex2D(texRef_f10B,x-1,(y  )+height*(z-1));
		f15= tex2D(texRef_f12B,x+1,(y  )+height*(z-1));
		fout[j+pitch*height*depth*1 ] = f1 ;
		fout[j+pitch*height*depth*2 ] = f2 ;
		fout[j+pitch*height*depth*3 ] = f3 ;
		fout[j+pitch*height*depth*4 ] = f4 ;
		fout[j+pitch*height*depth*5 ] = f5 ;
		fout[j+pitch*height*depth*6 ] = f6 ;
		fout[j+pitch*height*depth*7 ] = f7 ;
		fout[j+pitch*height*depth*8 ] = f8 ;
		fout[j+pitch*height*depth*9 ] = f9 ;
		fout[j+pitch*height*depth*10] = f10;
		fout[j+pitch*height*depth*11] = f11;
		fout[j+pitch*height*depth*12] = f12;
		fout[j+pitch*height*depth*13] = f13;
		fout[j+pitch*height*depth*14] = f14;
		fout[j+pitch*height*depth*15] = f15;
		fout[j+pitch*height*depth*16] = f16;
		fout[j+pitch*height*depth*17] = f17;
		fout[j+pitch*height*depth*18] = f18;
	}
	else{
		float f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18;
		f0 = fin[j];
		f2 = fin[f_mem(2 ,x  ,y-1,z  ,pitch,height,depth)];
		f4 = fin[f_mem(4 ,x  ,y+1,z  ,pitch,height,depth)];
		f9 = fin[f_mem(9 ,x  ,y  ,z-1,pitch,height,depth)];
		f11= fin[f_mem(11,x  ,y-1,z-1,pitch,height,depth)];
		f13= fin[f_mem(13,x  ,y+1,z-1,pitch,height,depth)];
		f14= fin[f_mem(14,x  ,y  ,z+1,pitch,height,depth)];
		f16= fin[f_mem(16,x  ,y-1,z+1,pitch,height,depth)];
		f18= fin[f_mem(18,x  ,y+1,z+1,pitch,height,depth)];
		f1 = tex2D(texRef_f1B ,x-1,y  +height*(z));
		f3 = tex2D(texRef_f3B ,x+1,y  +height*(z));
		f5 = tex2D(texRef_f5B ,x-1,y-1+height*(z));
		f6 = tex2D(texRef_f6B ,x+1,y-1+height*(z));
		f7 = tex2D(texRef_f7B ,x+1,y+1+height*(z));
		f8 = tex2D(texRef_f8B ,x-1,y+1+height*(z));
		f15= tex2D(texRef_f15B,x-1,y  +height*(z+1));
		f17= tex2D(texRef_f17B,x+1,y  +height*(z+1));
		f10= tex2D(texRef_f10B,x-1,y  +height*(z-1));
		f12= tex2D(texRef_f12B,x+1,y  +height*(z-1));

		if(im == 3)//DirichletWest
		{
			if(y == 0){
				f2 = f4;
				f6 = f7;
				f11 = f13;
				f16 = f18;
			}
			else if(y == height-1){
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
			if(z == depth-1){
				f14 = f9;
				f15 = f10;
				f16 = f11;
				f17 = f12;
				f18 = f13;
			}
//			float fInt1,fInt2;//,fDiff;
			float u,v,w,rho;
	        u = 0.0f;//*PoisProf(zcoord)*1.5;
	        v = uMax;//0.0;
			w = 0.0f;
	        
//			fInt1 = f0+f2+f4+f9+f11+f13+f14+f16+f18;
//	        fInt2 = f3+f6+f7+f12+f17;
//        	rho = u+(fInt1+2.0f*fInt2); //D2Q9i
			
        	rho = u+(f0+f2+f4+f9+f11+f13+f14+f16+f18+2.0f*(f3+f6+f7+f12+f17)); //D2Q9i

			float usqr = u*u+v*v+w*w;
			f1 = 0.0555555556f*(rho+3.0f*u+4.5f*u*u-1.5f*usqr)+f3-0.0555555556f*(rho-3.0f*u+4.5f*u*u-1.5f*usqr);;
			f5 = 0.0277777778f*(rho+3.0f*(u+v)+4.5f*(u+v)*(u+v)-1.5f*usqr)+f7 -0.0277777778f*(rho+3.0f*(-u-v)+4.5f*(-u-v)*(-u-v)-1.5f*usqr);
			f8 = 0.0277777778f*(rho+3.0f*(u-v)+4.5f*(u-v)*(u-v)-1.5f*usqr)+f6 -0.0277777778f*(rho+3.0f*(-u+v)+4.5f*(-u+v)*(-u+v)-1.5f*usqr);
			f10= 0.0277777778f*(rho+3.0f*(u+w)+4.5f*(u+w)*(u+w)-1.5f*usqr)+f17-0.0277777778f*(rho+3.0f*(-u-w)+4.5f*(-u-w)*(-u-w)-1.5f*usqr);
			f15= 0.0277777778f*(rho+3.0f*(u-w)+4.5f*(u-w)*(u-w)-1.5f*usqr)+f12-0.0277777778f*(rho+3.0f*(-u+w)+4.5f*(-u+w)*(-u+w)-1.5f*usqr);
		}

		//mrt_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,omega);
		bgk_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,omega);


		fout[f_mem(0 ,x,y,z,pitch,height,depth)] = f0 ;
		fout[f_mem(1 ,x,y,z,pitch,height,depth)] = f1 ;
		fout[f_mem(2 ,x,y,z,pitch,height,depth)] = f2 ;
		fout[f_mem(3 ,x,y,z,pitch,height,depth)] = f3 ;
		fout[f_mem(4 ,x,y,z,pitch,height,depth)] = f4 ;
		fout[f_mem(5 ,x,y,z,pitch,height,depth)] = f5 ;
		fout[f_mem(6 ,x,y,z,pitch,height,depth)] = f6 ;
		fout[f_mem(7 ,x,y,z,pitch,height,depth)] = f7 ;
		fout[f_mem(8 ,x,y,z,pitch,height,depth)] = f8 ;
		fout[f_mem(9 ,x,y,z,pitch,height,depth)] = f9 ;
		fout[f_mem(10,x,y,z,pitch,height,depth)] = f10;
		fout[f_mem(11,x,y,z,pitch,height,depth)] = f11;
		fout[f_mem(12,x,y,z,pitch,height,depth)] = f12;
		fout[f_mem(13,x,y,z,pitch,height,depth)] = f13;
		fout[f_mem(14,x,y,z,pitch,height,depth)] = f14;
		fout[f_mem(15,x,y,z,pitch,height,depth)] = f15;
		fout[f_mem(16,x,y,z,pitch,height,depth)] = f16;
		fout[f_mem(17,x,y,z,pitch,height,depth)] = f17;
		fout[f_mem(18,x,y,z,pitch,height,depth)] = f18;
	}
}

__global__ void mrt_d_textAB(float* fin, float* fout,
							int *image, float omega, float uMax,
							int width, int height, int depth, size_t pitch)//pitch in elements
{
	int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
	int y = threadIdx.y+blockIdx.y*blockDim.y;
	int z = threadIdx.z+blockIdx.z*blockDim.z;
	int i = x+y*width+z*width*height;//index on linear mem
	int j = x+y*pitch+z*height*pitch;//index on padded mem (pitch in elements)
	int im = image[i];
	if(im == 1){//BB
		float f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18;
		f2 = tex2D(texRef_f4A ,x  ,(y+1)+height*(z  ));
		f4 = tex2D(texRef_f2A ,x  ,(y-1)+height*(z  ));
		f9 = tex2D(texRef_f14A,x  ,(y  )+height*(z+1));
		f14= tex2D(texRef_f9A ,x  ,(y  )+height*(z-1));
		f11= tex2D(texRef_f18A,x  ,(y+1)+height*(z+1));
		f18= tex2D(texRef_f11A,x  ,(y-1)+height*(z-1));
		f16= tex2D(texRef_f13A,x  ,(y+1)+height*(z-1));
		f13= tex2D(texRef_f16A,x  ,(y-1)+height*(z+1));

//		f2 = fin[f_mem(4 ,x              ,dmin(y+1,height),z               ,pitch,height,depth)];
//		f4 = fin[f_mem(2 ,x              ,dmax(y-1)       ,z               ,pitch,height,depth)];
//		f9 = fin[f_mem(14,x              ,y               ,dmin(z+1,depth) ,pitch,height,depth)];
//		f11= fin[f_mem(18,x              ,dmin(y+1,height),dmin(z+1,depth) ,pitch,height,depth)];
//		f13= fin[f_mem(16,x              ,dmax(y-1)       ,dmin(z+1,depth) ,pitch,height,depth)];
//		f14= fin[f_mem(9 ,x              ,y               ,dmax(z-1)       ,pitch,height,depth)];
//		f16= fin[f_mem(13,x              ,dmin(y+1,height),dmax(z-1)       ,pitch,height,depth)];
//		f18= fin[f_mem(11,x              ,dmax(y-1)       ,dmax(z-1)       ,pitch,height,depth)];
		f3 = tex2D(texRef_f1A ,x-1,(y  )+height*(z));
		f1 = tex2D(texRef_f3A ,x+1,(y  )+height*(z));
		f5 = tex2D(texRef_f7A ,x+1,(y+1)+height*(z));
		f6 = tex2D(texRef_f8A ,x-1,(y+1)+height*(z));
		f7 = tex2D(texRef_f5A ,x-1,(y-1)+height*(z));
		f8 = tex2D(texRef_f6A ,x+1,(y-1)+height*(z));
		f10= tex2D(texRef_f17A,x+1,(y  )+height*(z+1));
		f12= tex2D(texRef_f15A,x-1,(y  )+height*(z+1));
		f17= tex2D(texRef_f10A,x-1,(y  )+height*(z-1));
		f15= tex2D(texRef_f12A,x+1,(y  )+height*(z-1));
		fout[j+pitch*height*depth*1 ] = f1 ;
		fout[j+pitch*height*depth*2 ] = f2 ;
		fout[j+pitch*height*depth*3 ] = f3 ;
		fout[j+pitch*height*depth*4 ] = f4 ;
		fout[j+pitch*height*depth*5 ] = f5 ;
		fout[j+pitch*height*depth*6 ] = f6 ;
		fout[j+pitch*height*depth*7 ] = f7 ;
		fout[j+pitch*height*depth*8 ] = f8 ;
		fout[j+pitch*height*depth*9 ] = f9 ;
		fout[j+pitch*height*depth*10] = f10;
		fout[j+pitch*height*depth*11] = f11;
		fout[j+pitch*height*depth*12] = f12;
		fout[j+pitch*height*depth*13] = f13;
		fout[j+pitch*height*depth*14] = f14;
		fout[j+pitch*height*depth*15] = f15;
		fout[j+pitch*height*depth*16] = f16;
		fout[j+pitch*height*depth*17] = f17;
		fout[j+pitch*height*depth*18] = f18;
	}
	else{
		float f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18;
		f0 = fin[j];
		f2 = tex2D(texRef_f2A ,x  ,y-1+height*(z));
		f4 = tex2D(texRef_f4A ,x  ,y+1+height*(z));
		f9 = tex2D(texRef_f9A ,x  ,y+1+height*(z-1));
		f11= tex2D(texRef_f11A,x  ,y-1+height*(z-1));
		f13= tex2D(texRef_f13A,x  ,y+1+height*(z-1));
		f14= tex2D(texRef_f14A,x  ,y  +height*(z+1));
		f16= tex2D(texRef_f16A,x  ,y-1+height*(z+1));
		f18= tex2D(texRef_f18A,x  ,y+1+height*(z+1));
//		f2 = fin[f_mem(2 ,x  ,y-1,z  ,pitch,height,depth)];
//		f4 = fin[f_mem(4 ,x  ,y+1,z  ,pitch,height,depth)];
//		f9 = fin[f_mem(9 ,x  ,y  ,z-1,pitch,height,depth)];
//		f11= fin[f_mem(11,x  ,y-1,z-1,pitch,height,depth)];
//		f13= fin[f_mem(13,x  ,y+1,z-1,pitch,height,depth)];
//		f14= fin[f_mem(14,x  ,y  ,z+1,pitch,height,depth)];
//		f16= fin[f_mem(16,x  ,y-1,z+1,pitch,height,depth)];
//		f18= fin[f_mem(18,x  ,y+1,z+1,pitch,height,depth)];
		f1 = tex2D(texRef_f1A ,x-1,y  +height*(z));
		f3 = tex2D(texRef_f3A ,x+1,y  +height*(z));
		f5 = tex2D(texRef_f5A ,x-1,y-1+height*(z));
		f6 = tex2D(texRef_f6A ,x+1,y-1+height*(z));
		f7 = tex2D(texRef_f7A ,x+1,y+1+height*(z));
		f8 = tex2D(texRef_f8A ,x-1,y+1+height*(z));
		f15= tex2D(texRef_f15A,x-1,y  +height*(z+1));
		f17= tex2D(texRef_f17A,x+1,y  +height*(z+1));
		f10= tex2D(texRef_f10A,x-1,y  +height*(z-1));
		f12= tex2D(texRef_f12A,x+1,y  +height*(z-1));

		if(im == 3)//DirichletWest
		{
			if(y == 0){
				f2 = f4;
				f6 = f7;
				f11 = f13;
				f16 = f18;
			}
			else if(y == height-1){
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
			if(z == depth-1){
				f14 = f9;
				f15 = f10;
				f16 = f11;
				f17 = f12;
				f18 = f13;
			}
//			float fInt1,fInt2;//,fDiff;
			float u,v,w,rho;
	        u = 0.0f;//*PoisProf(zcoord)*1.5;
	        v = uMax;//0.0;
			w = 0.0f;
	        
//			fInt1 = f0+f2+f4+f9+f11+f13+f14+f16+f18;
//	        fInt2 = f3+f6+f7+f12+f17;
//        	rho = u+(fInt1+2.0f*fInt2); //D2Q9i
			
        	rho = u+(f0+f2+f4+f9+f11+f13+f14+f16+f18+2.0f*(f3+f6+f7+f12+f17)); //D2Q9i

			float usqr = u*u+v*v+w*w;
			f1 = 0.0555555556f*(rho+3.0f*u+4.5f*u*u-1.5f*usqr)+f3-0.0555555556f*(rho-3.0f*u+4.5f*u*u-1.5f*usqr);;
			f5 = 0.0277777778f*(rho+3.0f*(u+v)+4.5f*(u+v)*(u+v)-1.5f*usqr)+f7 -0.0277777778f*(rho+3.0f*(-u-v)+4.5f*(-u-v)*(-u-v)-1.5f*usqr);
			f8 = 0.0277777778f*(rho+3.0f*(u-v)+4.5f*(u-v)*(u-v)-1.5f*usqr)+f6 -0.0277777778f*(rho+3.0f*(-u+v)+4.5f*(-u+v)*(-u+v)-1.5f*usqr);
			f10= 0.0277777778f*(rho+3.0f*(u+w)+4.5f*(u+w)*(u+w)-1.5f*usqr)+f17-0.0277777778f*(rho+3.0f*(-u-w)+4.5f*(-u-w)*(-u-w)-1.5f*usqr);
			f15= 0.0277777778f*(rho+3.0f*(u-w)+4.5f*(u-w)*(u-w)-1.5f*usqr)+f12-0.0277777778f*(rho+3.0f*(-u+w)+4.5f*(-u+w)*(-u+w)-1.5f*usqr);
		}

		//mrt_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,omega);
		bgk_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,omega);


		fout[f_mem(0 ,x,y,z,pitch,height,depth)] = f0 ;
		fout[f_mem(1 ,x,y,z,pitch,height,depth)] = f1 ;
		fout[f_mem(2 ,x,y,z,pitch,height,depth)] = f2 ;
		fout[f_mem(3 ,x,y,z,pitch,height,depth)] = f3 ;
		fout[f_mem(4 ,x,y,z,pitch,height,depth)] = f4 ;
		fout[f_mem(5 ,x,y,z,pitch,height,depth)] = f5 ;
		fout[f_mem(6 ,x,y,z,pitch,height,depth)] = f6 ;
		fout[f_mem(7 ,x,y,z,pitch,height,depth)] = f7 ;
		fout[f_mem(8 ,x,y,z,pitch,height,depth)] = f8 ;
		fout[f_mem(9 ,x,y,z,pitch,height,depth)] = f9 ;
		fout[f_mem(10,x,y,z,pitch,height,depth)] = f10;
		fout[f_mem(11,x,y,z,pitch,height,depth)] = f11;
		fout[f_mem(12,x,y,z,pitch,height,depth)] = f12;
		fout[f_mem(13,x,y,z,pitch,height,depth)] = f13;
		fout[f_mem(14,x,y,z,pitch,height,depth)] = f14;
		fout[f_mem(15,x,y,z,pitch,height,depth)] = f15;
		fout[f_mem(16,x,y,z,pitch,height,depth)] = f16;
		fout[f_mem(17,x,y,z,pitch,height,depth)] = f17;
		fout[f_mem(18,x,y,z,pitch,height,depth)] = f18;
	}
}

__global__ void mrt_d_textBA(float* fin, float* fout,
							int *image, float omega, float uMax,
							int width, int height, int depth, size_t pitch)//pitch in elements
{
	int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
	int y = threadIdx.y+blockIdx.y*blockDim.y;
	int z = threadIdx.z+blockIdx.z*blockDim.z;
	int i = x+y*width+z*width*height;//index on linear mem
	int j = x+y*pitch+z*height*pitch;//index on padded mem (pitch in elements)
	int im = image[i];
	if(im == 1){//BB
		float f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18;
		f2 = tex2D(texRef_f4B ,x  ,(y+1)+height*(z  ));
		f4 = tex2D(texRef_f2B ,x  ,(y-1)+height*(z  ));
		f9 = tex2D(texRef_f14B,x  ,(y  )+height*(z+1));
		f14= tex2D(texRef_f9B ,x  ,(y  )+height*(z-1));
		f11= tex2D(texRef_f18B,x  ,(y+1)+height*(z+1));
		f18= tex2D(texRef_f11B,x  ,(y-1)+height*(z-1));
		f16= tex2D(texRef_f13B,x  ,(y+1)+height*(z-1));
		f13= tex2D(texRef_f16B,x  ,(y-1)+height*(z+1));

//		f2 = fin[f_mem(4 ,x              ,dmin(y+1,height),z               ,pitch,height,depth)];
//		f4 = fin[f_mem(2 ,x              ,dmax(y-1)       ,z               ,pitch,height,depth)];
//		f9 = fin[f_mem(14,x              ,y               ,dmin(z+1,depth) ,pitch,height,depth)];
//		f11= fin[f_mem(18,x              ,dmin(y+1,height),dmin(z+1,depth) ,pitch,height,depth)];
//		f13= fin[f_mem(16,x              ,dmax(y-1)       ,dmin(z+1,depth) ,pitch,height,depth)];
//		f14= fin[f_mem(9 ,x              ,y               ,dmax(z-1)       ,pitch,height,depth)];
//		f16= fin[f_mem(13,x              ,dmin(y+1,height),dmax(z-1)       ,pitch,height,depth)];
//		f18= fin[f_mem(11,x              ,dmax(y-1)       ,dmax(z-1)       ,pitch,height,depth)];
		f3 = tex2D(texRef_f1B ,x-1,(y  )+height*(z));
		f1 = tex2D(texRef_f3B ,x+1,(y  )+height*(z));
		f5 = tex2D(texRef_f7B ,x+1,(y+1)+height*(z));
		f6 = tex2D(texRef_f8B ,x-1,(y+1)+height*(z));
		f7 = tex2D(texRef_f5B ,x-1,(y-1)+height*(z));
		f8 = tex2D(texRef_f6B ,x+1,(y-1)+height*(z));
		f10= tex2D(texRef_f17B,x+1,(y  )+height*(z+1));
		f12= tex2D(texRef_f15B,x-1,(y  )+height*(z+1));
		f17= tex2D(texRef_f10B,x-1,(y  )+height*(z-1));
		f15= tex2D(texRef_f12B,x+1,(y  )+height*(z-1));
		fout[j+pitch*height*depth*1 ] = f1 ;
		fout[j+pitch*height*depth*2 ] = f2 ;
		fout[j+pitch*height*depth*3 ] = f3 ;
		fout[j+pitch*height*depth*4 ] = f4 ;
		fout[j+pitch*height*depth*5 ] = f5 ;
		fout[j+pitch*height*depth*6 ] = f6 ;
		fout[j+pitch*height*depth*7 ] = f7 ;
		fout[j+pitch*height*depth*8 ] = f8 ;
		fout[j+pitch*height*depth*9 ] = f9 ;
		fout[j+pitch*height*depth*10] = f10;
		fout[j+pitch*height*depth*11] = f11;
		fout[j+pitch*height*depth*12] = f12;
		fout[j+pitch*height*depth*13] = f13;
		fout[j+pitch*height*depth*14] = f14;
		fout[j+pitch*height*depth*15] = f15;
		fout[j+pitch*height*depth*16] = f16;
		fout[j+pitch*height*depth*17] = f17;
		fout[j+pitch*height*depth*18] = f18;
	}
	else{
		float f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18;
		f0 = fin[j];
		f2 = tex2D(texRef_f2B ,x  ,y-1+height*(z));
		f4 = tex2D(texRef_f4B ,x  ,y+1+height*(z));
		f9 = tex2D(texRef_f9B ,x  ,y+1+height*(z-1));
		f11= tex2D(texRef_f11B,x  ,y-1+height*(z-1));
		f13= tex2D(texRef_f13B,x  ,y+1+height*(z-1));
		f14= tex2D(texRef_f14B,x  ,y  +height*(z+1));
		f16= tex2D(texRef_f16B,x  ,y-1+height*(z+1));
		f18= tex2D(texRef_f18B,x  ,y+1+height*(z+1));
//		f2 = fin[f_mem(2 ,x  ,y-1,z  ,pitch,height,depth)];
//		f4 = fin[f_mem(4 ,x  ,y+1,z  ,pitch,height,depth)];
//		f9 = fin[f_mem(9 ,x  ,y  ,z-1,pitch,height,depth)];
//		f11= fin[f_mem(11,x  ,y-1,z-1,pitch,height,depth)];
//		f13= fin[f_mem(13,x  ,y+1,z-1,pitch,height,depth)];
//		f14= fin[f_mem(14,x  ,y  ,z+1,pitch,height,depth)];
//		f16= fin[f_mem(16,x  ,y-1,z+1,pitch,height,depth)];
//		f18= fin[f_mem(18,x  ,y+1,z+1,pitch,height,depth)];
		f1 = tex2D(texRef_f1B ,x-1,y  +height*(z));
		f3 = tex2D(texRef_f3B ,x+1,y  +height*(z));
		f5 = tex2D(texRef_f5B ,x-1,y-1+height*(z));
		f6 = tex2D(texRef_f6B ,x+1,y-1+height*(z));
		f7 = tex2D(texRef_f7B ,x+1,y+1+height*(z));
		f8 = tex2D(texRef_f8B ,x-1,y+1+height*(z));
		f15= tex2D(texRef_f15B,x-1,y  +height*(z+1));
		f17= tex2D(texRef_f17B,x+1,y  +height*(z+1));
		f10= tex2D(texRef_f10B,x-1,y  +height*(z-1));
		f12= tex2D(texRef_f12B,x+1,y  +height*(z-1));

		if(im == 3)//DirichletWest
		{
			if(y == 0){
				f2 = f4;
				f6 = f7;
				f11 = f13;
				f16 = f18;
			}
			else if(y == height-1){
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
			if(z == depth-1){
				f14 = f9;
				f15 = f10;
				f16 = f11;
				f17 = f12;
				f18 = f13;
			}
//			float fInt1,fInt2;//,fDiff;
			float u,v,w,rho;
	        u = 0.0f;//*PoisProf(zcoord)*1.5;
	        v = uMax;//0.0;
			w = 0.0f;
	        
//			fInt1 = f0+f2+f4+f9+f11+f13+f14+f16+f18;
//	        fInt2 = f3+f6+f7+f12+f17;
//        	rho = u+(fInt1+2.0f*fInt2); //D2Q9i
			
        	rho = u+(f0+f2+f4+f9+f11+f13+f14+f16+f18+2.0f*(f3+f6+f7+f12+f17)); //D2Q9i

			float usqr = u*u+v*v+w*w;
			f1 = 0.0555555556f*(rho+3.0f*u+4.5f*u*u-1.5f*usqr)+f3-0.0555555556f*(rho-3.0f*u+4.5f*u*u-1.5f*usqr);;
			f5 = 0.0277777778f*(rho+3.0f*(u+v)+4.5f*(u+v)*(u+v)-1.5f*usqr)+f7 -0.0277777778f*(rho+3.0f*(-u-v)+4.5f*(-u-v)*(-u-v)-1.5f*usqr);
			f8 = 0.0277777778f*(rho+3.0f*(u-v)+4.5f*(u-v)*(u-v)-1.5f*usqr)+f6 -0.0277777778f*(rho+3.0f*(-u+v)+4.5f*(-u+v)*(-u+v)-1.5f*usqr);
			f10= 0.0277777778f*(rho+3.0f*(u+w)+4.5f*(u+w)*(u+w)-1.5f*usqr)+f17-0.0277777778f*(rho+3.0f*(-u-w)+4.5f*(-u-w)*(-u-w)-1.5f*usqr);
			f15= 0.0277777778f*(rho+3.0f*(u-w)+4.5f*(u-w)*(u-w)-1.5f*usqr)+f12-0.0277777778f*(rho+3.0f*(-u+w)+4.5f*(-u+w)*(-u+w)-1.5f*usqr);
		}

		//mrt_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,omega);
		bgk_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,omega);


		fout[f_mem(0 ,x,y,z,pitch,height,depth)] = f0 ;
		fout[f_mem(1 ,x,y,z,pitch,height,depth)] = f1 ;
		fout[f_mem(2 ,x,y,z,pitch,height,depth)] = f2 ;
		fout[f_mem(3 ,x,y,z,pitch,height,depth)] = f3 ;
		fout[f_mem(4 ,x,y,z,pitch,height,depth)] = f4 ;
		fout[f_mem(5 ,x,y,z,pitch,height,depth)] = f5 ;
		fout[f_mem(6 ,x,y,z,pitch,height,depth)] = f6 ;
		fout[f_mem(7 ,x,y,z,pitch,height,depth)] = f7 ;
		fout[f_mem(8 ,x,y,z,pitch,height,depth)] = f8 ;
		fout[f_mem(9 ,x,y,z,pitch,height,depth)] = f9 ;
		fout[f_mem(10,x,y,z,pitch,height,depth)] = f10;
		fout[f_mem(11,x,y,z,pitch,height,depth)] = f11;
		fout[f_mem(12,x,y,z,pitch,height,depth)] = f12;
		fout[f_mem(13,x,y,z,pitch,height,depth)] = f13;
		fout[f_mem(14,x,y,z,pitch,height,depth)] = f14;
		fout[f_mem(15,x,y,z,pitch,height,depth)] = f15;
		fout[f_mem(16,x,y,z,pitch,height,depth)] = f16;
		fout[f_mem(17,x,y,z,pitch,height,depth)] = f17;
		fout[f_mem(18,x,y,z,pitch,height,depth)] = f18;
	}
}


__global__ void mrt_d_shared(float* fA, float* fB,
							int *image, float omega, float uMax,
							int width, int height, int depth, size_t pitch)//pitch in elements
{
	int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
	int y = threadIdx.y+blockIdx.y*blockDim.y;
	int z = threadIdx.z+blockIdx.z*blockDim.z;
//	int i = x+y*width+z*width*height;//index on linear mem
	int j = x+y*pitch+z*height*pitch;//index on padded mem (pitch in elements)
//	f1out[j] = tex2D(texRef_f2A,x,y+h*z);
	
//	int i = x+y*blockDim.x*gridDim.x;
	//float u,v,w,rho;//,usqr;
//	int im = image[i];
	int im = 0;
	if(y == 0 || z == 0 || x == width-1 || y == height-1 || z == depth-1) im = 1;
	else if (x == 0) im = 3;

	__shared__ float  f1_s[256];
	__shared__ float  f3_s[256];
	__shared__ float  f5_s[256];
	__shared__ float  f7_s[256];
	__shared__ float  f6_s[256];
	__shared__ float  f8_s[256];
	__shared__ float f10_s[256];
	__shared__ float f12_s[256];
	__shared__ float f15_s[256];
	__shared__ float f17_s[256];

	 f1_s[threadIdx.x] = fA[f_mem(1 ,x ,y  ,z               ,pitch,height,depth)];//dmax(x-1)      
	 f3_s[threadIdx.x] = fA[f_mem(3 ,x ,y  ,z               ,pitch,height,depth)];//dmin(x+1,width)
	if(y != 0){
	 f5_s[threadIdx.x] = fA[f_mem(5 ,x ,y-1,z               ,pitch,height,depth)];//dmax(x-1)      
	 f8_s[threadIdx.x] = fA[f_mem(8 ,x ,y-1,z               ,pitch,height,depth)];//dmax(x-1)      
	}
	else if(y != height){
	 f7_s[threadIdx.x] = fA[f_mem(7 ,x ,y+1,z               ,pitch,height,depth)];//dmin(x+1,width)
	 f6_s[threadIdx.x] = fA[f_mem(6 ,x ,y+1,z               ,pitch,height,depth)];//dmin(x+1,width)
	}
	if(z != 0){
	f10_s[threadIdx.x] = fA[f_mem(10,x ,y  ,z-1,pitch,height,depth)];//dmax(x-1)      
	f12_s[threadIdx.x] = fA[f_mem(12,x ,y  ,z-1,pitch,height,depth)];//dmin(x+1,width)
	}
	else if(z != depth-1){
	f15_s[threadIdx.x] = fA[f_mem(15,x ,y  ,z+1,pitch,height,depth)];//dmax(x-1)      
	f17_s[threadIdx.x] = fA[f_mem(17,x ,y  ,z+1,pitch,height,depth)];//dmin(x+1,width)
	}

//	 f1_s[threadIdx.x] = fA[f_mem(1 ,x ,y               ,z               ,pitch,height,depth)];//dmax(x-1)      
//	 f3_s[threadIdx.x] = fA[f_mem(3 ,x ,y               ,z               ,pitch,height,depth)];//dmin(x+1,width)
//	 f5_s[threadIdx.x] = fA[f_mem(5 ,x ,dmax(y-1)       ,z               ,pitch,height,depth)];//dmax(x-1)      
//	 f7_s[threadIdx.x] = fA[f_mem(7 ,x ,dmin(y+1,height),z               ,pitch,height,depth)];//dmin(x+1,width)
//	 f6_s[threadIdx.x] = fA[f_mem(6 ,x ,dmin(y+1,height),z               ,pitch,height,depth)];//dmin(x+1,width)
//	 f8_s[threadIdx.x] = fA[f_mem(8 ,x ,dmax(y-1)       ,z               ,pitch,height,depth)];//dmax(x-1)      
//	f10_s[threadIdx.x] = fA[f_mem(10,x ,y               ,dmax(z-1)       ,pitch,height,depth)];//dmax(x-1)      
//	f12_s[threadIdx.x] = fA[f_mem(12,x ,y               ,dmax(z-1)       ,pitch,height,depth)];//dmin(x+1,width)
//	f15_s[threadIdx.x] = fA[f_mem(15,x ,y               ,dmin(z+1,depth) ,pitch,height,depth)];//dmax(x-1)      
//	f17_s[threadIdx.x] = fA[f_mem(17,x ,y               ,dmin(z+1,depth) ,pitch,height,depth)];//dmin(x+1,width)
//
	__syncthreads();

	if(im == 1){//BB
		float f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18;
		if(y != 0){
		f4 = fA[f_mem(2 ,x  ,y-1  ,z  ,pitch,height,depth)];//fA[f_mem(4 ,x,y,z,pitch,height,depth)];
		}
		else if(y != height){
		f2 = fA[f_mem(4 ,x  ,y+1  ,z  ,pitch,height,depth)];//fA[f_mem(2 ,x,y,z,pitch,height,depth)];
		}
		if(z != depth-1){
		f9 = fA[f_mem(14,x  ,y    ,z+1,pitch,height,depth)];//fA[f_mem(9 ,x,y,z,pitch,height,depth)];
		f11= fA[f_mem(18,x  ,y+1  ,z+1,pitch,height,depth)];//fA[f_mem(11,x,y,z,pitch,height,depth)];
		f13= fA[f_mem(16,x  ,y-1  ,z+1,pitch,height,depth)];//fA[f_mem(13,x,y,z,pitch,height,depth)];
		}
		else if(z != 0){
		f14= fA[f_mem(9 ,x  ,y    ,z-1,pitch,height,depth)];//fA[f_mem(14,x,y,z,pitch,height,depth)];
		f16= fA[f_mem(13,x  ,y+1  ,z-1,pitch,height,depth)];//fA[f_mem(16,x,y,z,pitch,height,depth)];
		f18= fA[f_mem(11,x  ,y-1  ,z-1,pitch,height,depth)];//fA[f_mem(18,x,y,z,pitch,height,depth)];
		}

//		f2 = fA[f_mem(4 ,x              ,dmin(y+1,height),z               ,pitch,height,depth)];//fA[f_mem(2 ,x,y,z,pitch,height,depth)];
//		f4 = fA[f_mem(2 ,x              ,dmax(y-1)       ,z               ,pitch,height,depth)];//fA[f_mem(4 ,x,y,z,pitch,height,depth)];
//		f9 = fA[f_mem(14,x              ,y               ,dmin(z+1,depth) ,pitch,height,depth)];//fA[f_mem(9 ,x,y,z,pitch,height,depth)];
//		f11= fA[f_mem(18,x              ,dmin(y+1,height),dmin(z+1,depth) ,pitch,height,depth)];//fA[f_mem(11,x,y,z,pitch,height,depth)];
//		f13= fA[f_mem(16,x              ,dmax(y-1)       ,dmin(z+1,depth) ,pitch,height,depth)];//fA[f_mem(13,x,y,z,pitch,height,depth)];
//		f14= fA[f_mem(9 ,x              ,y               ,dmax(z-1)       ,pitch,height,depth)];//fA[f_mem(14,x,y,z,pitch,height,depth)];
//		f16= fA[f_mem(13,x              ,dmin(y+1,height),dmax(z-1)       ,pitch,height,depth)];//fA[f_mem(16,x,y,z,pitch,height,depth)];
//		f18= fA[f_mem(11,x              ,dmax(y-1)       ,dmax(z-1)       ,pitch,height,depth)];//fA[f_mem(18,x,y,z,pitch,height,depth)];

//		f1 = fA[f_mem(3 ,dmin(x+1,width),y               ,z               ,pitch,height,depth)];//fA[f_mem(1 ,x,y,z,pitch,height,depth)];
//		f3 = fA[f_mem(1 ,dmax(x-1)      ,y               ,z               ,pitch,height,depth)];//fA[f_mem(3 ,x,y,z,pitch,height,depth)];
//		f5 = fA[f_mem(7 ,dmin(x+1,width),dmin(y+1,height),z               ,pitch,height,depth)];//fA[f_mem(5 ,x,y,z,pitch,height,depth)];
//		f7 = fA[f_mem(5 ,dmax(x-1)      ,dmax(y-1)       ,z               ,pitch,height,depth)];//fA[f_mem(7 ,x,y,z,pitch,height,depth)];
//		f6 = fA[f_mem(8 ,dmax(x-1)      ,dmin(y+1,height),z               ,pitch,height,depth)];//fA[f_mem(6 ,x,y,z,pitch,height,depth)];
//		f8 = fA[f_mem(6 ,dmin(x+1,width),dmax(y-1)       ,z               ,pitch,height,depth)];//fA[f_mem(8 ,x,y,z,pitch,height,depth)];
//		f10= fA[f_mem(17,dmin(x+1,width),y               ,dmin(z+1,depth) ,pitch,height,depth)];//fA[f_mem(10,x,y,z,pitch,height,depth)];
//		f12= fA[f_mem(15,dmax(x-1)      ,y               ,dmin(z+1,depth) ,pitch,height,depth)];//fA[f_mem(12,x,y,z,pitch,height,depth)];
//		f15= fA[f_mem(12,dmin(x+1,width),y               ,dmax(z-1)       ,pitch,height,depth)];//fA[f_mem(15,x,y,z,pitch,height,depth)];
//		f17= fA[f_mem(10,dmax(x-1)      ,y               ,dmax(z-1)       ,pitch,height,depth)];//fA[f_mem(17,x,y,z,pitch,height,depth)];

		if(threadIdx.x != width-1){
		f1 = f3_s[threadIdx.x+1];//fA[f_mem(3 ,dmin(x+1,width),y               ,z               ,pitch,height,depth)];//fA[f_mem(1 ,x,y,z,pitch,height,depth)];
		f5 = f7_s[threadIdx.x+1];//fA[f_mem(3 ,dmin(x+1,width),y               ,z               ,pitch,height,depth)];//fA[f_mem(1 ,x,y,z,pitch,height,depth)];
		f8 = f6_s[threadIdx.x+1];//fA[f_mem(3 ,dmin(x+1,width),y               ,z               ,pitch,height,depth)];//fA[f_mem(1 ,x,y,z,pitch,height,depth)];
		f10=f17_s[threadIdx.x+1];//fA[f_mem(3 ,dmin(x+1,width),y               ,z               ,pitch,height,depth)];//fA[f_mem(1 ,x,y,z,pitch,height,depth)];
		f15=f12_s[threadIdx.x+1];//fA[f_mem(3 ,dmin(x+1,width),y               ,z               ,pitch,height,depth)];//fA[f_mem(1 ,x,y,z,pitch,height,depth)];
		}
		else if(threadIdx.x != 0){
		f3 = f1_s[threadIdx.x-1];//fA[f_mem(3 ,dmin(x+1,width),y               ,z               ,pitch,height,depth)];//fA[f_mem(1 ,x,y,z,pitch,height,depth)];
		f7 = f5_s[threadIdx.x-1];//fA[f_mem(3 ,dmin(x+1,width),y               ,z               ,pitch,height,depth)];//fA[f_mem(1 ,x,y,z,pitch,height,depth)];
		f6 = f8_s[threadIdx.x-1];//fA[f_mem(3 ,dmin(x+1,width),y               ,z               ,pitch,height,depth)];//fA[f_mem(1 ,x,y,z,pitch,height,depth)];
		f17=f10_s[threadIdx.x-1];//fA[f_mem(3 ,dmin(x+1,width),y               ,z               ,pitch,height,depth)];//fA[f_mem(1 ,x,y,z,pitch,height,depth)];
		f12=f15_s[threadIdx.x-1];//fA[f_mem(3 ,dmin(x+1,width),y               ,z               ,pitch,height,depth)];//fA[f_mem(1 ,x,y,z,pitch,height,depth)];
		}


//		f1 = f3_s[dmin(threadIdx.x+1,width)];//fA[f_mem(3 ,dmin(x+1,width),y               ,z               ,pitch,height,depth)];//fA[f_mem(1 ,x,y,z,pitch,height,depth)];
//		f3 = f1_s[dmax(threadIdx.x-1      )];//fA[f_mem(3 ,dmin(x+1,width),y               ,z               ,pitch,height,depth)];//fA[f_mem(1 ,x,y,z,pitch,height,depth)];
//		f5 = f7_s[dmin(threadIdx.x+1,width)];//fA[f_mem(3 ,dmin(x+1,width),y               ,z               ,pitch,height,depth)];//fA[f_mem(1 ,x,y,z,pitch,height,depth)];
//		f7 = f5_s[dmax(threadIdx.x-1      )];//fA[f_mem(3 ,dmin(x+1,width),y               ,z               ,pitch,height,depth)];//fA[f_mem(1 ,x,y,z,pitch,height,depth)];
//		f6 = f8_s[dmax(threadIdx.x-1      )];//fA[f_mem(3 ,dmin(x+1,width),y               ,z               ,pitch,height,depth)];//fA[f_mem(1 ,x,y,z,pitch,height,depth)];
//		f8 = f6_s[dmin(threadIdx.x+1,width)];//fA[f_mem(3 ,dmin(x+1,width),y               ,z               ,pitch,height,depth)];//fA[f_mem(1 ,x,y,z,pitch,height,depth)];
//		f10=f17_s[dmin(threadIdx.x+1,width)];//fA[f_mem(3 ,dmin(x+1,width),y               ,z               ,pitch,height,depth)];//fA[f_mem(1 ,x,y,z,pitch,height,depth)];
//		f17=f10_s[dmax(threadIdx.x-1      )];//fA[f_mem(3 ,dmin(x+1,width),y               ,z               ,pitch,height,depth)];//fA[f_mem(1 ,x,y,z,pitch,height,depth)];
//		f12=f15_s[dmax(threadIdx.x-1      )];//fA[f_mem(3 ,dmin(x+1,width),y               ,z               ,pitch,height,depth)];//fA[f_mem(1 ,x,y,z,pitch,height,depth)];
//		f15=f12_s[dmin(threadIdx.x+1,width)];//fA[f_mem(3 ,dmin(x+1,width),y               ,z               ,pitch,height,depth)];//fA[f_mem(1 ,x,y,z,pitch,height,depth)];

		fB[f_mem(1 ,x,y,z,pitch,height,depth)] = f1 ;
		fB[f_mem(2 ,x,y,z,pitch,height,depth)] = f2 ;
		fB[f_mem(3 ,x,y,z,pitch,height,depth)] = f3 ;
		fB[f_mem(4 ,x,y,z,pitch,height,depth)] = f4 ;
		fB[f_mem(5 ,x,y,z,pitch,height,depth)] = f5 ;
		fB[f_mem(6 ,x,y,z,pitch,height,depth)] = f6 ;
		fB[f_mem(7 ,x,y,z,pitch,height,depth)] = f7 ;
		fB[f_mem(8 ,x,y,z,pitch,height,depth)] = f8 ;
		fB[f_mem(9 ,x,y,z,pitch,height,depth)] = f9 ;
		fB[f_mem(10,x,y,z,pitch,height,depth)] = f10;
		fB[f_mem(11,x,y,z,pitch,height,depth)] = f11;
		fB[f_mem(12,x,y,z,pitch,height,depth)] = f12;
		fB[f_mem(13,x,y,z,pitch,height,depth)] = f13;
		fB[f_mem(14,x,y,z,pitch,height,depth)] = f14;
		fB[f_mem(15,x,y,z,pitch,height,depth)] = f15;
		fB[f_mem(16,x,y,z,pitch,height,depth)] = f16;
		fB[f_mem(17,x,y,z,pitch,height,depth)] = f17;
		fB[f_mem(18,x,y,z,pitch,height,depth)] = f18;

//		fB[j+pitch*height*depth*1 ] = f1 ;
//		fB[j+pitch*height*depth*2 ] = f2 ;
//		fB[j+pitch*height*depth*3 ] = f3 ;
//		fB[j+pitch*height*depth*4 ] = f4 ;
//		fB[j+pitch*height*depth*5 ] = f5 ;
//		fB[j+pitch*height*depth*6 ] = f6 ;
//		fB[j+pitch*height*depth*7 ] = f7 ;
//		fB[j+pitch*height*depth*8 ] = f8 ;
//		fB[j+pitch*height*depth*9 ] = f9 ;
//		fB[j+pitch*height*depth*10] = f10;
//		fB[j+pitch*height*depth*11] = f11;
//		fB[j+pitch*height*depth*12] = f12;
//		fB[j+pitch*height*depth*13] = f13;
//		fB[j+pitch*height*depth*14] = f14;
//		fB[j+pitch*height*depth*15] = f15;
//		fB[j+pitch*height*depth*16] = f16;
//		fB[j+pitch*height*depth*17] = f17;
//		fB[j+pitch*height*depth*18] = f18;

	}
	else{


		float f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18;

		f0 = fA[j];
		if(y != 0){
		f2 = fA[f_mem(2 ,x  ,y-1,z  ,pitch,height,depth)];
		}
		else if(y != height-1){
		f4 = fA[f_mem(4 ,x  ,y+1,z  ,pitch,height,depth)];
		}
		if(z != depth-1){
		f14= fA[f_mem(14,x  ,y  ,z+1,pitch,height,depth)];
		f16= fA[f_mem(16,x  ,y-1,z+1,pitch,height,depth)];
		f18= fA[f_mem(18,x  ,y+1,z+1,pitch,height,depth)];
		}
		else if(z != 0){
		f9 = fA[f_mem(9 ,x  ,y  ,z-1,pitch,height,depth)];
		f11= fA[f_mem(11,x  ,y-1,z-1,pitch,height,depth)];
		f13= fA[f_mem(13,x  ,y+1,z-1,pitch,height,depth)];
		}

		if(threadIdx.x != width-1){
		f3 = f3_s[threadIdx.x+1];//fA[f_mem(3 ,x+1,y  ,z  ,pitch,height,depth)];
		f6 = f6_s[threadIdx.x+1];//fA[f_mem(6 ,x+1,y-1,z  ,pitch,height,depth)];
		f7 = f7_s[threadIdx.x+1];//fA[f_mem(7 ,x+1,y+1,z  ,pitch,height,depth)];
		f12=f12_s[threadIdx.x+1];//fA[f_mem(12,x+1,y  ,z-1,pitch,height,depth)];
		f17=f17_s[threadIdx.x+1];//fA[f_mem(17,x+1,y  ,z+1,pitch,height,depth)];
		}
		else if(threadIdx.x != 0){
		f1 = f1_s[threadIdx.x-1];//fA[f_mem(1 ,x-1,y  ,z  ,pitch,height,depth)];
		f5 = f5_s[threadIdx.x-1];//fA[f_mem(5 ,x-1,y-1,z  ,pitch,height,depth)];
		f8 = f8_s[threadIdx.x-1];//fA[f_mem(8 ,x-1,y+1,z  ,pitch,height,depth)];
		f10=f10_s[threadIdx.x-1];//fA[f_mem(10,x-1,y  ,z-1,pitch,height,depth)];
		f15=f15_s[threadIdx.x-1];//fA[f_mem(15,x-1,y  ,z+1,pitch,height,depth)];
		}


//		f0 = fA[j];
//		f2 = fA[f_mem(2 ,x  ,y-1,z  ,pitch,height,depth)];
//		f4 = fA[f_mem(4 ,x  ,y+1,z  ,pitch,height,depth)];
//		f9 = fA[f_mem(9 ,x  ,y  ,z-1,pitch,height,depth)];
//		f11= fA[f_mem(11,x  ,y-1,z-1,pitch,height,depth)];
//		f13= fA[f_mem(13,x  ,y+1,z-1,pitch,height,depth)];
//		f14= fA[f_mem(14,x  ,y  ,z+1,pitch,height,depth)];
//		f16= fA[f_mem(16,x  ,y-1,z+1,pitch,height,depth)];
//		f18= fA[f_mem(18,x  ,y+1,z+1,pitch,height,depth)];
//
//		f1 = f1_s[dmax(threadIdx.x-1      )];//fA[f_mem(1 ,x-1,y  ,z  ,pitch,height,depth)];
//		f3 = f3_s[dmin(threadIdx.x+1,width)];//fA[f_mem(3 ,x+1,y  ,z  ,pitch,height,depth)];
//		f5 = f5_s[dmax(threadIdx.x-1      )];//fA[f_mem(5 ,x-1,y-1,z  ,pitch,height,depth)];
//		f6 = f6_s[dmin(threadIdx.x+1,width)];//fA[f_mem(6 ,x+1,y-1,z  ,pitch,height,depth)];
//		f7 = f7_s[dmin(threadIdx.x+1,width)];//fA[f_mem(7 ,x+1,y+1,z  ,pitch,height,depth)];
//		f8 = f8_s[dmax(threadIdx.x-1      )];//fA[f_mem(8 ,x-1,y+1,z  ,pitch,height,depth)];
//		f10=f10_s[dmax(threadIdx.x-1      )];//fA[f_mem(10,x-1,y  ,z-1,pitch,height,depth)];
//		f12=f12_s[dmin(threadIdx.x+1,width)];//fA[f_mem(12,x+1,y  ,z-1,pitch,height,depth)];
//		f15=f15_s[dmax(threadIdx.x-1      )];//fA[f_mem(15,x-1,y  ,z+1,pitch,height,depth)];
//		f17=f17_s[dmin(threadIdx.x+1,width)];//fA[f_mem(17,x+1,y  ,z+1,pitch,height,depth)];

		if(im == 3)//DirichletWest
		{
			if(y == 0){
				f2 = f4;
				f6 = f7;
				f11 = f13;
				f16 = f18;
			}
			else if(y == height-1){
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
			if(z == depth-1){
				f14 = f9;
				f15 = f10;
				f16 = f11;
				f17 = f12;
				f18 = f13;
			}
//			float fInt1,fInt2;//,fDiff;
			float u,v,w,rho;
	        u = 0.0f;//*PoisProf(zcoord)*1.5;
	        v = uMax;//0.0;
			w = 0.0f;
	        
//			fInt1 = f0+f2+f4+f9+f11+f13+f14+f16+f18;
//	        fInt2 = f3+f6+f7+f12+f17;
//        	rho = u+(fInt1+2.0f*fInt2); //D2Q9i
			
        	rho = u+(f0+f2+f4+f9+f11+f13+f14+f16+f18+2.0f*(f3+f6+f7+f12+f17)); //D2Q9i

			float usqr = u*u+v*v+w*w;
			f1 = 0.0555555556f*(rho+3.0f*u+4.5f*u*u-1.5f*usqr)+f3-0.0555555556f*(rho-3.0f*u+4.5f*u*u-1.5f*usqr);;
			f5 = 0.0277777778f*(rho+3.0f*(u+v)+4.5f*(u+v)*(u+v)-1.5f*usqr)+f7 -0.0277777778f*(rho+3.0f*(-u-v)+4.5f*(-u-v)*(-u-v)-1.5f*usqr);
			f8 = 0.0277777778f*(rho+3.0f*(u-v)+4.5f*(u-v)*(u-v)-1.5f*usqr)+f6 -0.0277777778f*(rho+3.0f*(-u+v)+4.5f*(-u+v)*(-u+v)-1.5f*usqr);
			f10= 0.0277777778f*(rho+3.0f*(u+w)+4.5f*(u+w)*(u+w)-1.5f*usqr)+f17-0.0277777778f*(rho+3.0f*(-u-w)+4.5f*(-u-w)*(-u-w)-1.5f*usqr);
			f15= 0.0277777778f*(rho+3.0f*(u-w)+4.5f*(u-w)*(u-w)-1.5f*usqr)+f12-0.0277777778f*(rho+3.0f*(-u+w)+4.5f*(-u+w)*(-u+w)-1.5f*usqr);
		}

		//mrt_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,omega);
		bgk_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,omega);


		fB[f_mem(0 ,x,y,z,pitch,height,depth)] = f0 ;
		fB[f_mem(1 ,x,y,z,pitch,height,depth)] = f1 ;
		fB[f_mem(2 ,x,y,z,pitch,height,depth)] = f2 ;
		fB[f_mem(3 ,x,y,z,pitch,height,depth)] = f3 ;
		fB[f_mem(4 ,x,y,z,pitch,height,depth)] = f4 ;
		fB[f_mem(5 ,x,y,z,pitch,height,depth)] = f5 ;
		fB[f_mem(6 ,x,y,z,pitch,height,depth)] = f6 ;
		fB[f_mem(7 ,x,y,z,pitch,height,depth)] = f7 ;
		fB[f_mem(8 ,x,y,z,pitch,height,depth)] = f8 ;
		fB[f_mem(9 ,x,y,z,pitch,height,depth)] = f9 ;
		fB[f_mem(10,x,y,z,pitch,height,depth)] = f10;
		fB[f_mem(11,x,y,z,pitch,height,depth)] = f11;
		fB[f_mem(12,x,y,z,pitch,height,depth)] = f12;
		fB[f_mem(13,x,y,z,pitch,height,depth)] = f13;
		fB[f_mem(14,x,y,z,pitch,height,depth)] = f14;
		fB[f_mem(15,x,y,z,pitch,height,depth)] = f15;
		fB[f_mem(16,x,y,z,pitch,height,depth)] = f16;
		fB[f_mem(17,x,y,z,pitch,height,depth)] = f17;
		fB[f_mem(18,x,y,z,pitch,height,depth)] = f18;
	}
}




__global__ void mrt_d_single(float* fA, float* fB,
							int *image, float omega, float uMax,
							int width, int height, int depth, size_t pitch)//pitch in elements
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
		float f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18;
		f1 = fA[f_mem(3 ,dmin(x+1,width),y               ,z               ,pitch,height,depth)];//fA[f_mem(1 ,x,y,z,pitch,height,depth)];
		f2 = fA[f_mem(4 ,x              ,dmin(y+1,height),z               ,pitch,height,depth)];//fA[f_mem(2 ,x,y,z,pitch,height,depth)];
		f3 = fA[f_mem(1 ,dmax(x-1)      ,y               ,z               ,pitch,height,depth)];//fA[f_mem(3 ,x,y,z,pitch,height,depth)];
		f4 = fA[f_mem(2 ,x              ,dmax(y-1)       ,z               ,pitch,height,depth)];//fA[f_mem(4 ,x,y,z,pitch,height,depth)];
		f5 = fA[f_mem(7 ,dmin(x+1,width),dmin(y+1,height),z               ,pitch,height,depth)];//fA[f_mem(5 ,x,y,z,pitch,height,depth)];
		f7 = fA[f_mem(5 ,dmax(x-1)      ,dmax(y-1)       ,z               ,pitch,height,depth)];//fA[f_mem(7 ,x,y,z,pitch,height,depth)];
		f6 = fA[f_mem(8 ,dmax(x-1)      ,dmin(y+1,height),z               ,pitch,height,depth)];//fA[f_mem(6 ,x,y,z,pitch,height,depth)];
		f8 = fA[f_mem(6 ,dmin(x+1,width),dmax(y-1)       ,z               ,pitch,height,depth)];//fA[f_mem(8 ,x,y,z,pitch,height,depth)];
		f9 = fA[f_mem(14,x              ,y               ,dmin(z+1,depth) ,pitch,height,depth)];//fA[f_mem(9 ,x,y,z,pitch,height,depth)];
		f10= fA[f_mem(17,dmin(x+1,width),y               ,dmin(z+1,depth) ,pitch,height,depth)];//fA[f_mem(10,x,y,z,pitch,height,depth)];
		f11= fA[f_mem(18,x              ,dmin(y+1,height),dmin(z+1,depth) ,pitch,height,depth)];//fA[f_mem(11,x,y,z,pitch,height,depth)];
		f12= fA[f_mem(15,dmax(x-1)      ,y               ,dmin(z+1,depth) ,pitch,height,depth)];//fA[f_mem(12,x,y,z,pitch,height,depth)];
		f13= fA[f_mem(16,x              ,dmax(y-1)       ,dmin(z+1,depth) ,pitch,height,depth)];//fA[f_mem(13,x,y,z,pitch,height,depth)];
		f14= fA[f_mem(9 ,x              ,y               ,dmax(z-1)       ,pitch,height,depth)];//fA[f_mem(14,x,y,z,pitch,height,depth)];
		f15= fA[f_mem(12,dmin(x+1,width),y               ,dmax(z-1)       ,pitch,height,depth)];//fA[f_mem(15,x,y,z,pitch,height,depth)];
		f16= fA[f_mem(13,x              ,dmin(y+1,height),dmax(z-1)       ,pitch,height,depth)];//fA[f_mem(16,x,y,z,pitch,height,depth)];
		f17= fA[f_mem(10,dmax(x-1)      ,y               ,dmax(z-1)       ,pitch,height,depth)];//fA[f_mem(17,x,y,z,pitch,height,depth)];
		f18= fA[f_mem(11,x              ,dmax(y-1)       ,dmax(z-1)       ,pitch,height,depth)];//fA[f_mem(18,x,y,z,pitch,height,depth)];


		fB[f_mem(1 ,x,y,z,pitch,height,depth)] = f1 ;
		fB[f_mem(2 ,x,y,z,pitch,height,depth)] = f2 ;
		fB[f_mem(3 ,x,y,z,pitch,height,depth)] = f3 ;
		fB[f_mem(4 ,x,y,z,pitch,height,depth)] = f4 ;
		fB[f_mem(5 ,x,y,z,pitch,height,depth)] = f5 ;
		fB[f_mem(6 ,x,y,z,pitch,height,depth)] = f6 ;
		fB[f_mem(7 ,x,y,z,pitch,height,depth)] = f7 ;
		fB[f_mem(8 ,x,y,z,pitch,height,depth)] = f8 ;
		fB[f_mem(9 ,x,y,z,pitch,height,depth)] = f9 ;
		fB[f_mem(10,x,y,z,pitch,height,depth)] = f10;
		fB[f_mem(11,x,y,z,pitch,height,depth)] = f11;
		fB[f_mem(12,x,y,z,pitch,height,depth)] = f12;
		fB[f_mem(13,x,y,z,pitch,height,depth)] = f13;
		fB[f_mem(14,x,y,z,pitch,height,depth)] = f14;
		fB[f_mem(15,x,y,z,pitch,height,depth)] = f15;
		fB[f_mem(16,x,y,z,pitch,height,depth)] = f16;
		fB[f_mem(17,x,y,z,pitch,height,depth)] = f17;
		fB[f_mem(18,x,y,z,pitch,height,depth)] = f18;

//		fB[j+pitch*height*depth*1 ] = f1 ;
//		fB[j+pitch*height*depth*2 ] = f2 ;
//		fB[j+pitch*height*depth*3 ] = f3 ;
//		fB[j+pitch*height*depth*4 ] = f4 ;
//		fB[j+pitch*height*depth*5 ] = f5 ;
//		fB[j+pitch*height*depth*6 ] = f6 ;
//		fB[j+pitch*height*depth*7 ] = f7 ;
//		fB[j+pitch*height*depth*8 ] = f8 ;
//		fB[j+pitch*height*depth*9 ] = f9 ;
//		fB[j+pitch*height*depth*10] = f10;
//		fB[j+pitch*height*depth*11] = f11;
//		fB[j+pitch*height*depth*12] = f12;
//		fB[j+pitch*height*depth*13] = f13;
//		fB[j+pitch*height*depth*14] = f14;
//		fB[j+pitch*height*depth*15] = f15;
//		fB[j+pitch*height*depth*16] = f16;
//		fB[j+pitch*height*depth*17] = f17;
//		fB[j+pitch*height*depth*18] = f18;

	}
	else{


		float f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18;

		f0 = fA[j];
		f1 = fA[f_mem(1 ,x-1,y  ,z  ,pitch,height,depth)];
		f2 = fA[f_mem(2 ,x  ,y-1,z  ,pitch,height,depth)];
		f3 = fA[f_mem(3 ,x+1,y  ,z  ,pitch,height,depth)];
		f4 = fA[f_mem(4 ,x  ,y+1,z  ,pitch,height,depth)];
		f5 = fA[f_mem(5 ,x-1,y-1,z  ,pitch,height,depth)];
		f6 = fA[f_mem(6 ,x+1,y-1,z  ,pitch,height,depth)];
		f7 = fA[f_mem(7 ,x+1,y+1,z  ,pitch,height,depth)];
		f8 = fA[f_mem(8 ,x-1,y+1,z  ,pitch,height,depth)];
		f9 = fA[f_mem(9 ,x  ,y  ,z-1,pitch,height,depth)];
		f10= fA[f_mem(10,x-1,y  ,z-1,pitch,height,depth)];
		f11= fA[f_mem(11,x  ,y-1,z-1,pitch,height,depth)];
		f12= fA[f_mem(12,x+1,y  ,z-1,pitch,height,depth)];
		f13= fA[f_mem(13,x  ,y+1,z-1,pitch,height,depth)];
		f14= fA[f_mem(14,x  ,y  ,z+1,pitch,height,depth)];
		f15= fA[f_mem(15,x-1,y  ,z+1,pitch,height,depth)];
		f16= fA[f_mem(16,x  ,y-1,z+1,pitch,height,depth)];
		f17= fA[f_mem(17,x+1,y  ,z+1,pitch,height,depth)];
		f18= fA[f_mem(18,x  ,y+1,z+1,pitch,height,depth)];

		if(im == 3)//DirichletWest
		{
			if(y == 0){
				f2 = f4;
				f6 = f7;
				f11 = f13;
				f16 = f18;
			}
			else if(y == height-1){
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
			if(z == depth-1){
				f14 = f9;
				f15 = f10;
				f16 = f11;
				f17 = f12;
				f18 = f13;
			}
//			float fInt1,fInt2;//,fDiff;
			float u,v,w,rho;
	        u = 0.0f;//*PoisProf(zcoord)*1.5;
	        v = uMax;//0.0;
			w = 0.0f;
	        
//			fInt1 = f0+f2+f4+f9+f11+f13+f14+f16+f18;
//	        fInt2 = f3+f6+f7+f12+f17;
//        	rho = u+(fInt1+2.0f*fInt2); //D2Q9i
			
        	rho = u+(f0+f2+f4+f9+f11+f13+f14+f16+f18+2.0f*(f3+f6+f7+f12+f17)); //D2Q9i

			float usqr = u*u+v*v+w*w;
			f1 = 0.0555555556f*(rho+3.0f*u+4.5f*u*u-1.5f*usqr)+f3-0.0555555556f*(rho-3.0f*u+4.5f*u*u-1.5f*usqr);;
			f5 = 0.0277777778f*(rho+3.0f*(u+v)+4.5f*(u+v)*(u+v)-1.5f*usqr)+f7 -0.0277777778f*(rho+3.0f*(-u-v)+4.5f*(-u-v)*(-u-v)-1.5f*usqr);
			f8 = 0.0277777778f*(rho+3.0f*(u-v)+4.5f*(u-v)*(u-v)-1.5f*usqr)+f6 -0.0277777778f*(rho+3.0f*(-u+v)+4.5f*(-u+v)*(-u+v)-1.5f*usqr);
			f10= 0.0277777778f*(rho+3.0f*(u+w)+4.5f*(u+w)*(u+w)-1.5f*usqr)+f17-0.0277777778f*(rho+3.0f*(-u-w)+4.5f*(-u-w)*(-u-w)-1.5f*usqr);
			f15= 0.0277777778f*(rho+3.0f*(u-w)+4.5f*(u-w)*(u-w)-1.5f*usqr)+f12-0.0277777778f*(rho+3.0f*(-u+w)+4.5f*(-u+w)*(-u+w)-1.5f*usqr);
		}

		//mrt_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,omega);
		bgk_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,omega);


		fB[f_mem(0 ,x,y,z,pitch,height,depth)] = f0 ;
		fB[f_mem(1 ,x,y,z,pitch,height,depth)] = f1 ;
		fB[f_mem(2 ,x,y,z,pitch,height,depth)] = f2 ;
		fB[f_mem(3 ,x,y,z,pitch,height,depth)] = f3 ;
		fB[f_mem(4 ,x,y,z,pitch,height,depth)] = f4 ;
		fB[f_mem(5 ,x,y,z,pitch,height,depth)] = f5 ;
		fB[f_mem(6 ,x,y,z,pitch,height,depth)] = f6 ;
		fB[f_mem(7 ,x,y,z,pitch,height,depth)] = f7 ;
		fB[f_mem(8 ,x,y,z,pitch,height,depth)] = f8 ;
		fB[f_mem(9 ,x,y,z,pitch,height,depth)] = f9 ;
		fB[f_mem(10,x,y,z,pitch,height,depth)] = f10;
		fB[f_mem(11,x,y,z,pitch,height,depth)] = f11;
		fB[f_mem(12,x,y,z,pitch,height,depth)] = f12;
		fB[f_mem(13,x,y,z,pitch,height,depth)] = f13;
		fB[f_mem(14,x,y,z,pitch,height,depth)] = f14;
		fB[f_mem(15,x,y,z,pitch,height,depth)] = f15;
		fB[f_mem(16,x,y,z,pitch,height,depth)] = f16;
		fB[f_mem(17,x,y,z,pitch,height,depth)] = f17;
		fB[f_mem(18,x,y,z,pitch,height,depth)] = f18;
	}
}


__global__ void initialize_single(float *f, 
							int width, int height, int depth, size_t pitch)//pitch in elements
{
	int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
	int y = threadIdx.y+blockIdx.y*blockDim.y;
	int z = threadIdx.z+blockIdx.z*blockDim.z;
	int j = x+y*pitch+z*height*pitch;//index on padded mem (pitch in elements)
	
	float u,v,w,rho,usqr;
	rho = 1.f;
	u = 0.0f;
	v = 0.0f;
	w = 0.0f;
	//if(x == 3 ) u = 0.1f;
	usqr = u*u+v*v+w*w;

	f[j+0 *pitch*height*depth]= 1.0f/3.0f*(rho-1.5f*usqr);
	f[j+1 *pitch*height*depth]= 1.0f/18.0f*(rho+3.0f*u+4.5f*u*u-1.5f*usqr);
	f[j+2 *pitch*height*depth]= 1.0f/18.0f*(rho+3.0f*v+4.5f*v*v-1.5f*usqr);
	f[j+3 *pitch*height*depth]= 1.0f/18.0f*(rho-3.0f*u+4.5f*u*u-1.5f*usqr);
	f[j+4 *pitch*height*depth]= 1.0f/18.0f*(rho-3.0f*v+4.5f*v*v-1.5f*usqr);
	f[j+5 *pitch*height*depth]= 1.0f/36.0f*(rho+3.0f*(u+v)+4.5f*(u+v)*(u+v)-1.5f*usqr);
	f[j+6 *pitch*height*depth]= 1.0f/36.0f*(rho+3.0f*(-u+v)+4.5f*(-u+v)*(-u+v)-1.5f*usqr);
	f[j+7 *pitch*height*depth]= 1.0f/36.0f*(rho+3.0f*(-u-v)+4.5f*(-u-v)*(-u-v)-1.5f*usqr);
	f[j+8 *pitch*height*depth]= 1.0f/36.0f*(rho+3.0f*(u-v)+4.5f*(u-v)*(u-v)-1.5f*usqr);
	f[j+9 *pitch*height*depth]= 1.0f/18.0f*(rho+3.0f*w+4.5f*w*w-1.5f*usqr);
	f[j+10*pitch*height*depth]= 1.0f/36.0f*(rho+3.0f*(u+w)+4.5f*(u+w)*(u+w)-1.5f*usqr);
	f[j+11*pitch*height*depth]= 1.0f/36.0f*(rho+3.0f*(v+w)+4.5f*(v+w)*(u+w)-1.5f*usqr);
	f[j+12*pitch*height*depth]= 1.0f/36.0f*(rho+3.0f*(-u+w)+4.5f*(-u+w)*(-u+w)-1.5f*usqr);
	f[j+13*pitch*height*depth]= 1.0f/36.0f*(rho+3.0f*(-v+w)+4.5f*(-v+w)*(u+w)-1.5f*usqr);
	f[j+14*pitch*height*depth]= 1.0f/18.0f*(rho-3.0f*w+4.5f*w*w-1.5f*usqr);
	f[j+15*pitch*height*depth]= 1.0f/36.0f*(rho+3.0f*(u-w)+4.5f*(u-w)*(u-w)-1.5f*usqr);
	f[j+16*pitch*height*depth]= 1.0f/36.0f*(rho+3.0f*(v-w)+4.5f*(v-w)*(v-w)-1.5f*usqr);
	f[j+17*pitch*height*depth]= 1.0f/36.0f*(rho+3.0f*(-u-w)+4.5f*(-u-w)*(-u-w)-1.5f*usqr);
	f[j+18*pitch*height*depth]= 1.0f/36.0f*(rho+3.0f*(-v-w)+4.5f*(-v-w)*(-v-w)-1.5f*usqr);
}

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



int main(int argc, char *argv[])
{

//	float *f0_h, *f1_h, *f2_h, *f3_h, *f4_h, *f5_h, *f6_h, *f7_h, *f8_h, *f9_h;
//	float *f10_h, *f11_h, *f12_h, *f13_h, *f14_h, *f15_h, *f16_h, *f17_h, *f18_h;
//	float *f0_dA, *f1_dA, *f2_dA, *f3_dA, *f4_dA, *f5_dA, *f6_dA, *f7_dA, *f8_dA, *f9_dA;
//	float *f10_dA, *f11_dA, *f12_dA, *f13_dA, *f14_dA, *f15_dA, *f16_dA, *f17_dA, *f18_dA;
//	float *f0_dB, *f1_dB, *f2_dB, *f3_dB, *f4_dB, *f5_dB, *f6_dB, *f7_dB, *f8_dB, *f9_dB;
//	float *f10_dB, *f11_dB, *f12_dB, *f13_dB, *f14_dB, *f15_dB, *f16_dB, *f17_dB, *f18_dB;
	int *image_d, *image_h;



	//cudaPitchedPtr f0_d;


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
	yDim = 128;
	zDim = 32;
	tMax = 100;
	Re = 100.f;//100.f;
	uMax = 0.08f;
	CharLength = xDim-2.f;
	omega = 1.0f/(3.0f*(uMax*CharLength/Re)+0.5f);

	cout<<"omega: "<<omega<<endl;
	cout<<"blocksize: "<<BLOCKSIZEx<<"x"<<BLOCKSIZEy<<"x"<<BLOCKSIZEz<<endl;
	cout<<"grid: "<<xDim<<"x"<<yDim<<"x"<<zDim<<endl;
	cout<<"tMax: "<<tMax<<endl;

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

	image_h = (int *)malloc(memsize_int);

	float *fA_h,*fA_d,*fB_d;
	fA_h = (float *)malloc(memsize*19);
	cudaMallocPitch((void **) &fA_d, &pitch, xDim*sizeof(float), yDim*zDim*19);
	cudaMallocPitch((void **) &fB_d, &pitch, xDim*sizeof(float), yDim*zDim*19);

	cudaMalloc((void **) &image_d, memsize_int);

	cout<<pitch<<endl;
	
	size_t pitch_elements = pitch/sizeof(float);

	cudaChannelFormatDesc desc = cudaCreateChannelDesc<float>();
	for (i = 0; i < n*19; i++)
	{
		fA_h[i] = i;
	}
	for (i = 0; i < n; i++)
	{
		int x = i%xDim;
		int y = (i/xDim)%yDim;
		int z = (i/xDim)/yDim;
		fA_h[i] = 0;
		image_h[i] = 0;
		if(x < 1) image_h[i] = 3;//DirichletWest
		if(x > xDim-2) image_h[i] = 1;//BB
		if(y < 1) image_h[i] = 1;//BB
		if(y > yDim-2) image_h[i] = 1;//BB
		if(z < 1) image_h[i] = 1;//DirichletWest
		if(z > zDim-2) image_h[i] = 1;//BB
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
	
	cudaMemcpy2D(fA_d ,pitch,fA_h ,xDim*sizeof(float),xDim*sizeof(float),yDim*zDim*19,cudaMemcpyHostToDevice);
	cudaMemcpy2D(fB_d ,pitch,fA_h ,xDim*sizeof(float),xDim*sizeof(float),yDim*zDim*19,cudaMemcpyHostToDevice);

	for (i = 0; i < n*19; i++)
	{
		fA_h[i] = 0;
	}


	if(true)//bind texture
	{
	cudaBindTexture2D(0,&texRef_f0A, fA_d                            ,&desc,xDim,yDim*zDim,pitch);
	cudaBindTexture2D(0,&texRef_f1A, fA_d+pitch_elements*yDim*zDim   ,&desc,xDim,yDim*zDim,pitch);
	cudaBindTexture2D(0,&texRef_f2A, fA_d+pitch_elements*yDim*zDim*2 ,&desc,xDim,yDim*zDim,pitch);
	cudaBindTexture2D(0,&texRef_f3A, fA_d+pitch_elements*yDim*zDim*3 ,&desc,xDim,yDim*zDim,pitch);
	cudaBindTexture2D(0,&texRef_f4A, fA_d+pitch_elements*yDim*zDim*4 ,&desc,xDim,yDim*zDim,pitch);
	cudaBindTexture2D(0,&texRef_f5A, fA_d+pitch_elements*yDim*zDim*5 ,&desc,xDim,yDim*zDim,pitch);
	cudaBindTexture2D(0,&texRef_f6A, fA_d+pitch_elements*yDim*zDim*6 ,&desc,xDim,yDim*zDim,pitch);
	cudaBindTexture2D(0,&texRef_f7A, fA_d+pitch_elements*yDim*zDim*7 ,&desc,xDim,yDim*zDim,pitch);
	cudaBindTexture2D(0,&texRef_f8A, fA_d+pitch_elements*yDim*zDim*8 ,&desc,xDim,yDim*zDim,pitch);
	cudaBindTexture2D(0,&texRef_f9A, fA_d+pitch_elements*yDim*zDim*9 ,&desc,xDim,yDim*zDim,pitch);
	cudaBindTexture2D(0,&texRef_f10A,fA_d+pitch_elements*yDim*zDim*10,&desc,xDim,yDim*zDim,pitch);
	cudaBindTexture2D(0,&texRef_f11A,fA_d+pitch_elements*yDim*zDim*11,&desc,xDim,yDim*zDim,pitch);
	cudaBindTexture2D(0,&texRef_f12A,fA_d+pitch_elements*yDim*zDim*12,&desc,xDim,yDim*zDim,pitch);
	cudaBindTexture2D(0,&texRef_f13A,fA_d+pitch_elements*yDim*zDim*13,&desc,xDim,yDim*zDim,pitch);
	cudaBindTexture2D(0,&texRef_f14A,fA_d+pitch_elements*yDim*zDim*14,&desc,xDim,yDim*zDim,pitch);
	cudaBindTexture2D(0,&texRef_f15A,fA_d+pitch_elements*yDim*zDim*15,&desc,xDim,yDim*zDim,pitch);
	cudaBindTexture2D(0,&texRef_f16A,fA_d+pitch_elements*yDim*zDim*16,&desc,xDim,yDim*zDim,pitch);
	cudaBindTexture2D(0,&texRef_f17A,fA_d+pitch_elements*yDim*zDim*17,&desc,xDim,yDim*zDim,pitch);
	cudaBindTexture2D(0,&texRef_f18A,fA_d+pitch_elements*yDim*zDim*18,&desc,xDim,yDim*zDim,pitch);
	cudaBindTexture2D(0,&texRef_f0B, fB_d                            ,&desc,xDim,yDim*zDim,pitch);
	cudaBindTexture2D(0,&texRef_f1B, fB_d+pitch_elements*yDim*zDim   ,&desc,xDim,yDim*zDim,pitch);
	cudaBindTexture2D(0,&texRef_f2B, fB_d+pitch_elements*yDim*zDim*2 ,&desc,xDim,yDim*zDim,pitch);
	cudaBindTexture2D(0,&texRef_f3B, fB_d+pitch_elements*yDim*zDim*3 ,&desc,xDim,yDim*zDim,pitch);
	cudaBindTexture2D(0,&texRef_f4B, fB_d+pitch_elements*yDim*zDim*4 ,&desc,xDim,yDim*zDim,pitch);
	cudaBindTexture2D(0,&texRef_f5B, fB_d+pitch_elements*yDim*zDim*5 ,&desc,xDim,yDim*zDim,pitch);
	cudaBindTexture2D(0,&texRef_f6B, fB_d+pitch_elements*yDim*zDim*6 ,&desc,xDim,yDim*zDim,pitch);
	cudaBindTexture2D(0,&texRef_f7B, fB_d+pitch_elements*yDim*zDim*7 ,&desc,xDim,yDim*zDim,pitch);
	cudaBindTexture2D(0,&texRef_f8B, fB_d+pitch_elements*yDim*zDim*8 ,&desc,xDim,yDim*zDim,pitch);
	cudaBindTexture2D(0,&texRef_f9B, fB_d+pitch_elements*yDim*zDim*9 ,&desc,xDim,yDim*zDim,pitch);
	cudaBindTexture2D(0,&texRef_f10B,fB_d+pitch_elements*yDim*zDim*10,&desc,xDim,yDim*zDim,pitch);
	cudaBindTexture2D(0,&texRef_f11B,fB_d+pitch_elements*yDim*zDim*11,&desc,xDim,yDim*zDim,pitch);
	cudaBindTexture2D(0,&texRef_f12B,fB_d+pitch_elements*yDim*zDim*12,&desc,xDim,yDim*zDim,pitch);
	cudaBindTexture2D(0,&texRef_f13B,fB_d+pitch_elements*yDim*zDim*13,&desc,xDim,yDim*zDim,pitch);
	cudaBindTexture2D(0,&texRef_f14B,fB_d+pitch_elements*yDim*zDim*14,&desc,xDim,yDim*zDim,pitch);
	cudaBindTexture2D(0,&texRef_f15B,fB_d+pitch_elements*yDim*zDim*15,&desc,xDim,yDim*zDim,pitch);
	cudaBindTexture2D(0,&texRef_f16B,fB_d+pitch_elements*yDim*zDim*16,&desc,xDim,yDim*zDim,pitch);
	cudaBindTexture2D(0,&texRef_f17B,fB_d+pitch_elements*yDim*zDim*17,&desc,xDim,yDim*zDim,pitch);
	cudaBindTexture2D(0,&texRef_f18B,fB_d+pitch_elements*yDim*zDim*18,&desc,xDim,yDim*zDim,pitch);
	}


//	initialize<<<grid, threads>>>(f0_dA.ptr, f1_dA.ptr, f2_dA.ptr, f3_dA.ptr, f4_dA.ptr, f5_dA.ptr, f6_dA.ptr, f7_dA.ptr, f8_dA.ptr, f9_dA.ptr,
//									f10_dA.ptr, f11_dA.ptr, f12_dA.ptr, f13_dA.ptr, f14_dA.ptr, f15_dA.ptr, f16_dA.ptr, f17_dA.ptr, f18_dA.ptr,
//									xDim,yDim,pitch);
//	initialize<<<grid, threads>>>(f0_dA, f1_dA, f2_dA, f3_dA, f4_dA, f5_dA, f6_dA, f7_dA, f8_dA, f9_dA,
//									f10_dA, f11_dA, f12_dA, f13_dA, f14_dA, f15_dA, f16_dA, f17_dA, f18_dA,
//									xDim,yDim,pitch_elements);

	initialize_single<<<grid, threads>>>(fA_d,xDim,yDim,zDim,pitch_elements);

//	cudaFuncSetCacheConfig(mrt_d_single,cudaFuncCachePreferL1);

	struct timeval tdr0,tdr1;
	double restime;
	cudaDeviceSynchronize();
	gettimeofday (&tdr0,NULL);
	for(int t = 0; t<tMax; t=t+2){
	//for(int t = 0; t<tMax; t=t+1){

//		mrt_d_single<<<grid, threads>>>(fA_d,fB_d,image_d,omega,uMax,xDim,yDim,zDim,pitch_elements);
//		mrt_d_single<<<grid, threads>>>(fB_d,fA_d,image_d,omega,uMax,xDim,yDim,zDim,pitch_elements);

//		mrt_d_hybAB<<<grid, threads>>>(fA_d,fB_d,image_d,omega,uMax,xDim,yDim,zDim,pitch_elements);
//		mrt_d_hybBA<<<grid, threads>>>(fB_d,fA_d,image_d,omega,uMax,xDim,yDim,zDim,pitch_elements);

//		mrt_d_textAB<<<grid, threads>>>(fA_d,fB_d,image_d,omega,uMax,xDim,yDim,zDim,pitch_elements);
//		mrt_d_textBA<<<grid, threads>>>(fB_d,fA_d,image_d,omega,uMax,xDim,yDim,zDim,pitch_elements);

		mrt_d_shared<<<grid, threads>>>(fA_d,fB_d,image_d,omega,uMax,xDim,yDim,zDim,pitch_elements);
		mrt_d_shared<<<grid, threads>>>(fB_d,fA_d,image_d,omega,uMax,xDim,yDim,zDim,pitch_elements);

//		simple_copy<<<grid, threads>>>(fA_d,fB_d,image_d,omega,uMax,xDim,yDim,zDim,pitch_elements);
//		simple_copy<<<grid, threads>>>(fB_d,fA_d,image_d,omega,uMax,xDim,yDim,zDim,pitch_elements);

		if(t%1000 == 0 && t>0) cout<<"finished "<<t<<" timesteps\n";
	}
	cudaDeviceSynchronize();

	gettimeofday (&tdr1,NULL);
	timeval_subtract (&restime, &tdr1, &tdr0);
	cout<<"Time taken for main kernel: "<<restime<<" ("
			<<double(xDim*yDim*zDim*double(tMax/1000000.f))/restime<<"MLUPS)"<<endl;
	cout<<xDim<<","<<yDim<<","<<zDim<<","<<tMax<<","<<restime<<endl;




//	copytest<<<grid, threads>>>(f10_dA,test_d,xDim,yDim,zDim);
	//copytest<<<grid, threads>>>(test_d);
	//copytest<<<grid, threads>>>(image_d);
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

//	cudaMemcpy2D(f0_h,xDim*sizeof(float) , f0_dA,pitch,xDim*sizeof(float),yDim*zDim,cudaMemcpyDeviceToHost);
//	cudaMemcpy2D(f1_h,xDim*sizeof(float) , f1_dA,pitch,xDim*sizeof(float),yDim*zDim,cudaMemcpyDeviceToHost);
//	cudaMemcpy2D(f2_h,xDim*sizeof(float) , f2_dA,pitch,xDim*sizeof(float),yDim*zDim,cudaMemcpyDeviceToHost);
//	cudaMemcpy2D(f3_h,xDim*sizeof(float) , f3_dA,pitch,xDim*sizeof(float),yDim*zDim,cudaMemcpyDeviceToHost);
//	cudaMemcpy2D(f4_h,xDim*sizeof(float) , f4_dA,pitch,xDim*sizeof(float),yDim*zDim,cudaMemcpyDeviceToHost);
//	cudaMemcpy2D(f5_h,xDim*sizeof(float) , f5_dA,pitch,xDim*sizeof(float),yDim*zDim,cudaMemcpyDeviceToHost);
//	cudaMemcpy2D(f6_h,xDim*sizeof(float) , f6_dA,pitch,xDim*sizeof(float),yDim*zDim,cudaMemcpyDeviceToHost);
//	cudaMemcpy2D(f7_h,xDim*sizeof(float) , f7_dA,pitch,xDim*sizeof(float),yDim*zDim,cudaMemcpyDeviceToHost);
//	cudaMemcpy2D(f8_h,xDim*sizeof(float) , f8_dA,pitch,xDim*sizeof(float),yDim*zDim,cudaMemcpyDeviceToHost);
//	cudaMemcpy2D(f9_h,xDim*sizeof(float) , f9_dA,pitch,xDim*sizeof(float),yDim*zDim,cudaMemcpyDeviceToHost);
//	cudaMemcpy2D(f10_h,xDim*sizeof(float),f10_dA,pitch,xDim*sizeof(float),yDim*zDim,cudaMemcpyDeviceToHost);
//	cudaMemcpy2D(f11_h,xDim*sizeof(float),f11_dA,pitch,xDim*sizeof(float),yDim*zDim,cudaMemcpyDeviceToHost);
//	cudaMemcpy2D(f12_h,xDim*sizeof(float),f12_dA,pitch,xDim*sizeof(float),yDim*zDim,cudaMemcpyDeviceToHost);
//	cudaMemcpy2D(f13_h,xDim*sizeof(float),f13_dA,pitch,xDim*sizeof(float),yDim*zDim,cudaMemcpyDeviceToHost);
//	cudaMemcpy2D(f14_h,xDim*sizeof(float),f14_dA,pitch,xDim*sizeof(float),yDim*zDim,cudaMemcpyDeviceToHost);
//	cudaMemcpy2D(f15_h,xDim*sizeof(float),f15_dA,pitch,xDim*sizeof(float),yDim*zDim,cudaMemcpyDeviceToHost);
//	cudaMemcpy2D(f16_h,xDim*sizeof(float),f16_dA,pitch,xDim*sizeof(float),yDim*zDim,cudaMemcpyDeviceToHost);
//	cudaMemcpy2D(f17_h,xDim*sizeof(float),f17_dA,pitch,xDim*sizeof(float),yDim*zDim,cudaMemcpyDeviceToHost);
//	cudaMemcpy2D(f18_h,xDim*sizeof(float),f18_dA,pitch,xDim*sizeof(float),yDim*zDim,cudaMemcpyDeviceToHost);

	cudaMemcpy2D(fA_h,xDim*sizeof(float),fA_d,pitch,xDim*sizeof(float),yDim*zDim*19,cudaMemcpyDeviceToHost);

//	cout<<"f1_h is "<<f1_h[0]<<endl;
	//cudaMemcpy(f0_h, f0_d.ptr, memsize, cudaMemcpyDeviceToHost);

	cudaMemcpy(image_h, image_d, memsize_int, cudaMemcpyDeviceToHost);

//	cout<<image_h[0]<<endl;
//	cout<<"test_d: "<<test_h[0]<<endl;
//	for(i = 0; i<n; i++){
//	cout<<f0_h[i]<<",";
//	}


	output<<"VARIABLES = \"X\",\"Y\",\"Z\",\"u\",\"v\",\"w\",\"rho\"\n";
	output<<"ZONE F=POINT, I="<<xDim<<", J="<<yDim<<", K="<<zDim<<"\n";
	
	int row = 0;
	int col = 0;
	int dep = 0;
	i = 0;
	float rho, u, v, w;
	int j;

	for(dep = 0; dep<zDim; dep++){
	for(row = 0; row<yDim; row++){
		for(col = 0; col<xDim; col++){
			i = dep*xDim*yDim+row*xDim+col;
//			rho = 0;
			rho = fA_h[i];
			for(j = 1; j<19; j++)
				rho+=fA_h[i+xDim*yDim*zDim*j];
//			rho = f0_h[i]+f1_h[i]+f2_h[i]+f3_h[i]+f4_h[i]+f5_h[i]+f6_h[i]+f7_h[i]+f8_h[i]+f9_h[i]+
//			      f10_h[i]+f11_h[i]+f12_h[i]+f13_h[i]+f14_h[i]+f15_h[i]+f16_h[i]+f17_h[i]+f18_h[i];
			u = fA_h[i+xDim*yDim*zDim*1]-fA_h[i+xDim*yDim*zDim*3]+fA_h[i+xDim*yDim*zDim*5]-fA_h[i+xDim*yDim*zDim*6]-
				fA_h[i+xDim*yDim*zDim*7]+fA_h[i+xDim*yDim*zDim*8]+fA_h[i+xDim*yDim*zDim*10]-fA_h[i+xDim*yDim*zDim*12]
				+fA_h[i+xDim*yDim*zDim*15]-fA_h[i+xDim*yDim*zDim*17];
			v = fA_h[i+xDim*yDim*zDim*2]-fA_h[i+xDim*yDim*zDim*4]+fA_h[i+xDim*yDim*zDim*5]+fA_h[i+xDim*yDim*zDim*6]-fA_h[i+xDim*yDim*zDim*7]-fA_h[i+xDim*yDim*zDim*8]+fA_h[i+xDim*yDim*zDim*11]-fA_h[i+xDim*yDim*zDim*13]+fA_h[i+xDim*yDim*zDim*16]-fA_h[i+xDim*yDim*zDim*18];
			w = fA_h[i+xDim*yDim*zDim*9]+fA_h[i+xDim*yDim*zDim*10]+fA_h[i+xDim*yDim*zDim*11]+fA_h[i+xDim*yDim*zDim*12]+fA_h[i+xDim*yDim*zDim*13]-fA_h[i+xDim*yDim*zDim*14]-fA_h[i+xDim*yDim*zDim*15]-fA_h[i+xDim*yDim*zDim*16]-fA_h[i+xDim*yDim*zDim*17]-fA_h[i+xDim*yDim*zDim*18];
			output<<col<<", "<<row<<", "<<dep<<", "<<u<<","<<v<<","<<w<<","<<rho<<endl;
//			output<<col<<", "<<row<<", "<<dep<<", "<<u<<","<<v<<","<<fA_h[i+xDim*yDim*zDim*1]<<","<<rho<<endl;
		}
	}
	}
	output.close();




	cudaFree(image_d);
//	cudaFree(f0_dA);
//	cudaFree(f1_dA);
//	cudaFree(f2_dA);
//	cudaFree(f3_dA);
//	cudaFree(f4_dA);
//	cudaFree(f5_dA);
//	cudaFree(f6_dA);
//	cudaFree(f7_dA);
//	cudaFree(f8_dA);
//	cudaFree(f9_dA);
//	cudaFree(f10_dA);
//	cudaFree(f11_dA);
//	cudaFree(f12_dA);
//	cudaFree(f13_dA);
//	cudaFree(f14_dA);
//	cudaFree(f15_dA);
//	cudaFree(f16_dA);
//	cudaFree(f17_dA);
//	cudaFree(f18_dA);
//	cudaFree(f0_dB);
//	cudaFree(f1_dB);
//	cudaFree(f2_dB);
//	cudaFree(f3_dB);
//	cudaFree(f4_dB);
//	cudaFree(f5_dB);
//	cudaFree(f6_dB);
//	cudaFree(f7_dB);
//	cudaFree(f8_dB);
//	cudaFree(f9_dB);
//	cudaFree(f10_dB);
//	cudaFree(f11_dB);
//	cudaFree(f12_dB);
//	cudaFree(f13_dB);
//	cudaFree(f14_dB);
//	cudaFree(f15_dB);
//	cudaFree(f16_dB);
//	cudaFree(f17_dB);
//	cudaFree(f18_dB);

	cudaFree(fA_d);
	cudaFree(fB_d);
	return(0);

}
