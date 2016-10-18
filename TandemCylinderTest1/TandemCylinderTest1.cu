#include <cuda.h>
//#include <cutil.h>
#include <iostream>
#include <ostream>
#include <fstream>
//#include "/home/yusuke/NVIDIA_GPU_Computing_SDK/C/common/inc/cutil.h"
using namespace std;
	
#define CASENAME "test"

#define BLOCKSIZEX 128
#define BLOCKSIZEY 1
#define BLOCKSIZEZ 1
#define BLOCKSIZELRX 64
#define BLOCKSIZELRY 1
#define BLOCKSIZELRZ 1
#define XDIM 256
#define YDIM 320
#define ZDIM 1
#define TMAX 2000
#define STARTF 0

#define OBSTR1 8.f
#define OBSTX1 127.5f
#define OBSTY1 95.5f
#define OBSTZ1 15.5f

#define OBSTR2 4.f
#define OBSTX2 63.5f
#define OBSTY2 31.5f
#define OBSTZ2 31.5f

#define LRFACTOR 0.5f
#define LRLEVEL 2
#define LRX0 63.75f	//minimum x coord of LR
#define XLRDIM 256	//number of nodes in x
#define LRY0 47.75f
#define YLRDIM 256
#define LRZ0 -0.25f
#define ZLRDIM 128

//#define LRFACTOR 0.25f
//#define LRLEVEL 4
//#define LRX0 63.625f	//minimum x coord of LR
//#define XLRDIM 512	//number of nodes in x
//#define LRY0 47.625f
//#define YLRDIM 512
//#define LRZ0 -0.375f
//#define ZLRDIM 64

#define RE 22000.f//2000.f//100.f;
#define UMAX 0.04f
#define METHOD "SINGLE" //SINGLE,HYB,TEXT,SHARED,CACHE
#define REFINEMENT "NO" //YES,NO
#define SmagLES "YES" //YES,NO
#define MODEL "MRT" //BGK,MRT,STREAM
#define ZPERIODIC "YES"
#define VELAV "YES"
#define START_VELAV 40000
#define START_VELFLUC 400000
#define CS 0.04f
//#define CHARLENGTH = XDIM-2.f;
//#define BLOCKSIZE 16;
//int const XDIM = 32;
//int const YDIM = 32;

#include <sys/time.h>
#include <time.h>

/*
Image List:
0  fluid
1  BB
2
3  DirichletWest(simple)
10 BB(force)
13 DirichletWest_Reg
14 NeumannEast_Reg
15 DirichletNorth_Reg
16 DirichletSouth_Reg
21 ysymmetry_top
22 ysymmetry_bot
23 zsymmetry_top
24 zsymmetry_bot
25 xsymmetry_top
26 xsymmetry_bot
*/
inline __device__ int ImageFcn(float x, float y, float z){
//	if(((x-OBSTX1)*(x-OBSTX1)+(y-OBSTY1)*(y-OBSTY1))<OBSTR1*OBSTR1)
//		return 10;
//	else if(((x-OBSTX2)*(x-OBSTX2)+(y-OBSTY2)*(y-OBSTY2))<OBSTR2*OBSTR2)
//		return 10;
	//if(((x-OBSTX)*(x-OBSTX)+(y-OBSTY1)*(y-OBSTY1))<OBSTR1*OBSTR1)
//	if(((x-OBSTX1)*(x-OBSTX1)+(y-OBSTY1)*(y-OBSTY1)+(z-OBSTZ1)*(z-OBSTZ1))<OBSTR1*OBSTR1)
//	{
//		return 10;
//	}
//	else
//	//if(y < 0.1f || z < 0.1f || (XDIM-x) < 0.1f || (YDIM-y) < 0.1f || (ZDIM-z) < 0.1f)
//	if(y < 17.5f || z < 17.5f || y > 46.5f || z > 46.5f)
//		return 1;
//	else if(x < 17.5f)
//		return 13;
//	else if(x > 78.5f)
//		return 14;
//	else
    
    if(abs(x-OBSTX1) < OBSTR1 && abs(y-OBSTY1) < OBSTR1)
        return 10;
    else
		return 0;
}

inline __device__ int ImageFcn(int x, int y, int z){
    int value = 0;
//Cylinder
//	if(((x-OBSTX1)*(x-OBSTX1)+(y-OBSTY1)*(y-OBSTY1))<OBSTR1*OBSTR1)
//		value = 10;
//	else if(((x-OBSTX2)*(x-OBSTX2)+(y-OBSTY2)*(y-OBSTY2))<OBSTR2*OBSTR2)
//		value = 10;
//Sphere
//	if(((x-OBSTX1)*(x-OBSTX1)+(y-OBSTY1)*(y-OBSTY1)+(z-OBSTZ1)*(z-OBSTZ1))<OBSTR1*OBSTR1)
//	{
////		if(z == 0 || z == ZDIM-1)
////		return 1;
////		else
//		return 10;
//	}
//	if(z == 0)
//		value = 0;
//	else if(z == ZDIM-1)
//		value = 0;
    if(abs(x-OBSTX1) < OBSTR1 && abs(y-OBSTY1) < OBSTR1)
        value = 10;
	else if(y == 0)
		value = 200;//22;
	else if(y == YDIM-1)
		value = 100;
	else if(x == 0)
		value = 26;
	else if(x == XDIM-1)
		value = 25;
	else if(z == 0)
		value = 0;
	else if(z == ZDIM-1)
		value = 0;


    return value;

//Lid Driven Cavity
//	if(x == XDIM-1 || y == 0 || y == YDIM-1 || z == 0 || z == ZDIM-1)
//		return 1;
//	else if(x == XDIM-2 || y == 1 || y == YDIM-2 || z == 1 || z == ZDIM-2)
//		return 1;
//	else if(x == 0)
//		return 1;
//	else if(x == 1)
//		return 53;
//	else
//		return 0;
}

inline __device__ float PoisProf (float x){
	float radius = (YDIM-1-1)*0.5f;
	float result = -1.0f*(((1.0f-(x-0.5f)/radius))*((1.0f-(x-0.5f)/radius))-1.0f);
	return (result);
//	return 1.f;
}

__device__ void DirichletWest(float& f0, float& f1, float& f2,
					float& f3 , float& f4 , float& f5 ,
					float& f6 , float& f7 , float& f8 , float& f9,
					float& f10, float& f11, float& f12,
					float& f13, float& f14, float& f15,
					float& f16, float& f17, float& f18, int y, int z)
{
//	if(y == 0){
//		f2 = f4;
//		f6 = f7;
//		f11 = f13;
//		f16 = f18;
//	}
//	else if(y == YDIM-1){
//		f4 = f2;
//		f7 = f6;
//		f13 = f11;
//		f18 = f16;
//	}
//	if(z == 0){
//		f9  = f14;
//		f10 = f15;
//		f11 = f16;
//		f12 = f17;
//		f13 = f18;			
//	}    
//	else if(z == ZDIM-1){
//		f14 = f9;
//		f15 = f10;
//		f16 = f11;
//		f17 = f12;
//		f18 = f13;
//	}
	if(y == 0 && z == 0){
		f2 = f4;
        f13=f18;
        f11=f18;
        f16=f18;
		f6 =f7;
        f9 =f14;
        f12=f17;
	}
	else if(y == 0 && z == ZDIM-1){
		f4 = f2;
        f11=f13;
        f18=f13;
        f16=f13;
		f6 =f7;
        f14=f9;
        f17=f12;
	}
	else if(y == YDIM-1 && z == 0){
		f4 = f2;
        f11=f16;
        f18=f16;
        f13=f16;
		f7 =f6;
        f9 =f14;
        f12=f17;
	}
	else if(y == YDIM-1 && z == ZDIM-1){
		f4 = f2;
        f16=f11;
        f18=f11;
        f13=f11;
		f7 =f6;
        f14=f9;
        f17=f12;
	}
    else{
	if(y == 0){
        f2 = f4;
        f11=f13;
        f16=f18;
        f8 = f5;
    }
	else if(y == YDIM-1){
         f4=f2 ;
        f13=f11;
        f18=f16;
         f5=f8 ;
    }
	if(z == 0){
		f9  = f14;
		f10 = f15;
		f11 = f16;
		f13 = f18;			
	}    
	else if(z == ZDIM-1){
		f14 = f9;
		f15 = f10;
		f16 = f11;
		f18 = f13;
	}
    }
	float u,v,w;//,rho;
    u = UMAX;//*PoisProf(zcoord)*1.5;
    v = 0.0f;
	w = 0.0f;
    
//	float rho = u+(f0+f2+f4+f9+f11+f13+f14+f16+f18+2.0f*(f3+f6+f7+f12+f17)); //D2Q9i
//    float usqr = u*u+v*v+w*w;

	f1 = fma(0.0555555556f,6.0f*u,f3);//0.0555555556f*(6.0f*u)+f3;//-0.0555555556f*(rho-3.0f*u+4.5f*u*u-1.5f*usqr);;
	f5 = fma(0.0277777778f,6.0f*(u+v),f7 );// -0.0277777778f*(rho+3.0f*(-u-v)+4.5f*(-u-v)*(-u-v)-1.5f*usqr);
	f8 = fma(0.0277777778f,6.0f*(u-v),f6 );// -0.0277777778f*(rho+3.0f*(-u+v)+4.5f*(-u+v)*(-u+v)-1.5f*usqr);
	f10= fma(0.0277777778f,6.0f*(u+w),f17);//-0.0277777778f*(rho+3.0f*(-u-w)+4.5f*(-u-w)*(-u-w)-1.5f*usqr);
	f15= fma(0.0277777778f,6.0f*(u-w),f12);//-0.0277777778f*(rho+3.0f*(-u+w)+4.5f*(-u+w)*(-u+w)-1.5f*usqr);
////	f0 = 1.0f/3.0f*(rho-1.5f*usqr);
//	f1 = 1.0f/18.0f*(rho+3.0f*u+4.5f*u*u-1.5f*usqr);
////	f2 = 1.0f/18.0f*(rho+3.0f*v+4.5f*v*v-1.5f*usqr);
////	f3 = 1.0f/18.0f*(rho-3.0f*u+4.5f*u*u-1.5f*usqr);
////	f4 = 1.0f/18.0f*(rho-3.0f*v+4.5f*v*v-1.5f*usqr);
//	f5 = 1.0f/36.0f*(rho+3.0f*(u+v)+4.5f*(u+v)*(u+v)-1.5f*usqr);
////	f6 = 1.0f/36.0f*(rho+3.0f*(-u+v)+4.5f*(-u+v)*(-u+v)-1.5f*usqr);
////	f7 = 1.0f/36.0f*(rho+3.0f*(-u-v)+4.5f*(-u-v)*(-u-v)-1.5f*usqr);
//	f8 = 1.0f/36.0f*(rho+3.0f*(u-v)+4.5f*(u-v)*(u-v)-1.5f*usqr);
////	f9 = 1.0f/18.0f*(rho+3.0f*w+4.5f*w*w-1.5f*usqr);
//	f10= 1.0f/36.0f*(rho+3.0f*(u+w)+4.5f*(u+w)*(u+w)-1.5f*usqr);
////	f11= 1.0f/36.0f*(rho+3.0f*(v+w)+4.5f*(v+w)*(u+w)-1.5f*usqr);
////	f12= 1.0f/36.0f*(rho+3.0f*(-u+w)+4.5f*(-u+w)*(-u+w)-1.5f*usqr);
////	f13= 1.0f/36.0f*(rho+3.0f*(-v+w)+4.5f*(-v+w)*(u+w)-1.5f*usqr);
////	f14= 1.0f/18.0f*(rho-3.0f*w+4.5f*w*w-1.5f*usqr);
//	f15= 1.0f/36.0f*(rho+3.0f*(u-w)+4.5f*(u-w)*(u-w)-1.5f*usqr);
////	f16= 1.0f/36.0f*(rho+3.0f*(v-w)+4.5f*(v-w)*(v-w)-1.5f*usqr);
////	f17= 1.0f/36.0f*(rho+3.0f*(-u-w)+4.5f*(-u-w)*(-u-w)-1.5f*usqr);
////	f18= 1.0f/36.0f*(rho+3.0f*(-v-w)+4.5f*(-v-w)*(-v-w)-1.5f*usqr);
}

__device__ void DirichletWest_Reg(float& f0, float& f1, float& f2,
					float& f3 , float& f4 , float& f5 ,
					float& f6 , float& f7 , float& f8 , float& f9,
					float& f10, float& f11, float& f12,
					float& f13, float& f14, float& f15,
					float& f16, float& f17, float& f18, int y, int z)
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
    u = UMAX;//*PoisProf(y)*1.5;
    v = 0.0f;//0.0;
	w = 0.0f;
//	float rho = u+(f0+f2+f4+f9+f11+f13+f14+f16+f18+2.0f*(f3+f6+f7+f12+f17)); //D2Q9i
//	float u2 = u*u;
//	float v2 = v*v;
//	float w2 = w*w;
//	float usqr = u2+v2+w2;

//	f1 =(0.166666667f*u)+
//		(f3-(-(0.166666667f*u)));
	f1 = f3+0.33333333f*u;
//	f5 =(0.0833333333f*( u+v))+
//		(f7-(0.0833333333f*(-u-v)));
	f5 = f7+0.166666667f*(u+v);
//	f8 =(0.0833333333f*( u-v  ))+
//		(f6-(0.0833333333f*(-u+v  )));
	f8 = f6+0.166666667f*(u-v);
//	f10=(0.0833333333f*( u+w))+
//		(f17-(0.0833333333f*(-u-w)));
	f10= f17+0.166666667f*(u+w);
//	f15=(0.0833333333f*( u-w))+
//		(f12-(0.0833333333f*(-u+w)));
	f15= f12+0.166666667f*(u-w);
		
//	f1 =(0.1031746045f*rho+  -0.0231796391f*usqr+ (0.166666667f*u)   + 0.16666667f*u2)+
//		(f3-(0.1031746045f*rho+  -0.0231796391f*usqr+-(0.166666667f*u)   + 0.16666667f*u2));
//	f5 =(0.0158730149f*rho+  0.00579491071f*usqr+ 0.0833333333f*( u+v  +u2+(v2-w2))+  0.25f*u*v)+
//		(f7-(0.0158730149f*rho+  0.00579491071f*usqr+ 0.0833333333f*(-u-v  +u2+(v2-w2))+  0.25f*u*v));
//	f8 =(0.0158730149f*rho+  0.00579491071f*usqr+ 0.0833333333f*( u-v  +u2+(v2-w2))+ -0.25f*u*v)+
//		(f6-(0.0158730149f*rho+  0.00579491071f*usqr+ 0.0833333333f*(-u+v  +u2+(v2-w2))+ -0.25f*u*v));
//	f10=(0.0158730149f*rho+  0.00579491071f*usqr+ 0.0833333333f*( u+w  +u2+(v2-w2))+  0.25f*u*w)+
//		(f17-(0.0158730149f*rho+  0.00579491071f*usqr+ 0.0833333333f*(-u-w  +u2+(v2-w2))+  0.25f*u*w));
//	f15=(0.0158730149f*rho+  0.00579491071f*usqr+ 0.0833333333f*( u-w  +u2+(v2-w2))+ -0.25f*u*w)+
//		(f12-(0.0158730149f*rho+  0.00579491071f*usqr+ 0.0833333333f*(-u+w  +u2+(v2-w2))+ -0.25f*u*w));

//	float PI11 = f1 +f3 +f5 +f6 +f7 +f8 +f10+f12+f15+f17;
//	float PI22 = f2 +f4 +f5 +f6 +f7 +f8 +f11+f13+f16+f18;
//	float PI33 = f9 +f10+f11+f12+f13+f14+f15+f16+f17+f18;

}


void __device__ DirichletWest_Regularized(float& f0, float& f1, float& f2,
					float& f3 , float& f4 , float& f5 ,
					float& f6 , float& f7 , float& f8 , float& f9,
					float& f10, float& f11, float& f12,
					float& f13, float& f14, float& f15,
					float& f16, float& f17, float& f18, int y, int z)
{
	if(y == 0 && z == 0){
		f2 = f4;
        f13=f18;
        f11=f18;
        f16=f18;
		f6 =f7;
        f9 =f14;
        f12=f17;
	}
	else if(y == 0 && z == ZDIM-1){
		f4 = f2;
        f11=f13;
        f18=f13;
        f16=f13;
		f6 =f7;
        f14=f9;
        f17=f12;
	}
	else if(y == YDIM-1 && z == 0){
		f4 = f2;
        f11=f16;
        f18=f16;
        f13=f16;
		f7 =f6;
        f9 =f14;
        f12=f17;
	}
	else if(y == YDIM-1 && z == ZDIM-1){
		f4 = f2;
        f16=f11;
        f18=f11;
        f13=f11;
		f7 =f6;
        f14=f9;
        f17=f12;
	}
    else{
	if(y == 0){
        f2 = f4;
        f11=f13;
        f16=f18;
        f8 = f5;
    }
	else if(y == YDIM-1){
         f4=f2 ;
        f13=f11;
        f18=f16;
         f5=f8 ;
    }
	if(z == 0){
		f9  = f14;
		f10 = f15;
		f11 = f16;
		f13 = f18;			
	}    
	else if(z == ZDIM-1){
		f14 = f9;
		f15 = f10;
		f16 = f11;
		f18 = f13;
	}
    }

	float PI11 = 0;
	float PI12 = 0;
	float PI22 = 0;
	float PI33 = 0;
	float PI13 = 0;
	float PI23 = 0;
	float u;//,v;//,w;//,rho;
    u = UMAX;//*PoisProf(z)*1.5;
    //v = 0.0f;
	//w = 0.0f;
    float usqr = u*u;//+v*v+w*w;
	float rho = u+(f0+f2+f4+f9+f11+f13+f14+f16+f18+2.0f*(f3+f6+f7+f12+f17)); //D2Q9i
    
    float feq0  = 0.3333333333f*(rho-1.5f*usqr);
    float feq1  = 0.0555555556f*(rho+3.0f*u+4.5f*u*u-1.5f*usqr);
    float feq2  = 0.0555555556f*(rho                -1.5f*usqr);
    float feq3  = 0.0555555556f*(rho-3.0f*u+4.5f*u*u-1.5f*usqr);
    float feq4  = 0.0555555556f*(rho                -1.5f*usqr);
    float feq9  = 0.0555555556f*(rho                -1.5f*usqr);
    float feq14 = 0.0555555556f*(rho                -1.5f*usqr);
    float feq5  = 0.0277777778f*(rho+3.0f*( u)+4.5f*( u)*( u)-1.5f*usqr);
    float feq6  = 0.0277777778f*(rho+3.0f*(-u)+4.5f*(-u)*(-u)-1.5f*usqr);
    float feq7  = 0.0277777778f*(rho+3.0f*(-u)+4.5f*(-u)*(-u)-1.5f*usqr);
    float feq8  = 0.0277777778f*(rho+3.0f*( u)+4.5f*( u)*( u)-1.5f*usqr);
    float feq10 = 0.0277777778f*(rho+3.0f*( u)+4.5f*( u)*( u)-1.5f*usqr);
    float feq11 = 0.0277777778f*(rho                         -1.5f*usqr);
    float feq12 = 0.0277777778f*(rho+3.0f*(-u)+4.5f*(-u)*(-u)-1.5f*usqr);
    float feq13 = 0.0277777778f*(rho                         -1.5f*usqr);
    float feq15 = 0.0277777778f*(rho+3.0f*( u)+4.5f*( u)*( u)-1.5f*usqr);
    float feq16 = 0.0277777778f*(rho                         -1.5f*usqr);
    float feq17 = 0.0277777778f*(rho+3.0f*(-u)+4.5f*(-u)*(-u)-1.5f*usqr);
    float feq18 = 0.0277777778f*(rho                         -1.5f*usqr);

//    float feq0  = 0.3333333333f*(rho-1.5f*usqr);
//    float feq1  = 0.0555555556f*(rho+3.0f*u+4.5f*u*u-1.5f*usqr);
//    float feq2  = 0.0555555556f*(rho+3.0f*v+4.5f*v*v-1.5f*usqr);
//    float feq3  = 0.0555555556f*(rho-3.0f*u+4.5f*u*u-1.5f*usqr);
//    float feq4  = 0.0555555556f*(rho-3.0f*v+4.5f*v*v-1.5f*usqr);
//    float feq5  = 0.0277777778f*(rho+3.0f*(u+v)+4.5f*(u+v)*(u+v)-1.5f*usqr);
//    float feq6  = 0.0277777778f*(rho+3.0f*(-u+v)+4.5f*(-u+v)*(-u+v)-1.5f*usqr);
//    float feq7  = 0.0277777778f*(rho+3.0f*(-u-v)+4.5f*(-u-v)*(-u-v)-1.5f*usqr);
//    float feq8  = 0.0277777778f*(rho+3.0f*(u-v)+4.5f*(u-v)*(u-v)-1.5f*usqr);
//    float feq9  = 0.0555555556f*(rho+3.0f*w+4.5f*w*w-1.5f*usqr);
//    float feq10 = 0.0277777778f*(rho+3.0f*(u+w)+4.5f*(u+w)*(u+w)-1.5f*usqr);
//    float feq11 = 0.0277777778f*(rho+3.0f*(v+w)+4.5f*(v+w)*(v+w)-1.5f*usqr);
//    float feq12 = 0.0277777778f*(rho+3.0f*(-u+w)+4.5f*(-u+w)*(-u+w)-1.5f*usqr);
//    float feq13 = 0.0277777778f*(rho+3.0f*(-v+w)+4.5f*(-v+w)*(-v+w)-1.5f*usqr);
//    float feq14 = 0.0555555556f*(rho-3.0f*w+4.5f*w*w-1.5f*usqr);
//    float feq15 = 0.0277777778f*(rho+3.0f*(u-w)+4.5f*(u-w)*(u-w)-1.5f*usqr);
//    float feq16 = 0.0277777778f*(rho+3.0f*(v-w)+4.5f*(v-w)*(v-w)-1.5f*usqr);
//    float feq17 = 0.0277777778f*(rho+3.0f*(-u-w)+4.5f*(-u-w)*(-u-w)-1.5f*usqr);
//    float feq18 = 0.0277777778f*(rho+3.0f*(-v-w)+4.5f*(-v-w)*(-v-w)-1.5f*usqr);

	f1 = feq1 +f3 -feq3 ;
	f5 = feq5 +f7 -feq7 ;
	f8 = feq8 +f6 -feq6 ;
	f10= feq10+f17-feq17;
	f15= feq15+f12-feq12;

    PI11 = (f1-feq1)+(f3-feq3)+(f5-feq5)+(f6-feq6)+(f7-feq7)+(f8-feq8)+(f10-feq10)+(f12-feq12)+(f15-feq15)+(f17-feq17);
    PI22 = (f2-feq2)+(f4-feq4)+(f5-feq5)+(f6-feq6)+(f7-feq7)+(f8-feq8)+(f11-feq11)+(f13-feq13)+(f16-feq16)+(f18-feq18);
    PI33 = (f9-feq9)+(f14-feq14)+(f10-feq10)+(f12-feq12)+(f15-feq15)+(f17-feq17)+(f11-feq11)+(f13-feq13)+(f16-feq16)+(f18-feq18);
    PI12 = (f5-feq5)+(f7-feq7)-(f6-feq6)-(f8-feq8);
    PI13 = (f10-feq10)+(f17-feq17)-(f12-feq12)-(f15-feq15);
    PI23 = (f11-feq11)+(f18-feq18)-(f13-feq13)-(f16-feq16);

    f0  = feq0 +1.5f  *((     -0.333333333f)*PI11                         +(     -0.333333333f)*PI22+(     -0.333333333f)*PI33)  ;
    f1  = feq1 +0.25f *((      0.666666667f)*PI11                         +(     -0.333333333f)*PI22+(     -0.333333333f)*PI33)  ;
    f2  = feq2 +0.25f *((     -0.333333333f)*PI11                         +(      0.666666667f)*PI22+(     -0.333333333f)*PI33)  ;
    f3  = feq3 +0.25f *((      0.666666667f)*PI11                         +(     -0.333333333f)*PI22+(     -0.333333333f)*PI33)  ;
    f4  = feq4 +0.25f *((     -0.333333333f)*PI11                         +(      0.666666667f)*PI22+(     -0.333333333f)*PI33)  ;
    f5  = feq5 +0.125f*((      0.666666667f)*PI11+2.0f*( PI12            )+(      0.666666667f)*PI22+(     -0.333333333f)*PI33)  ;
    f6  = feq6 +0.125f*((      0.666666667f)*PI11+2.0f*(-PI12            )+(      0.666666667f)*PI22+(     -0.333333333f)*PI33)  ;
    f7  = feq7 +0.125f*((      0.666666667f)*PI11+2.0f*( PI12            )+(      0.666666667f)*PI22+(     -0.333333333f)*PI33)  ;
    f8  = feq8 +0.125f*((      0.666666667f)*PI11+2.0f*(-PI12            )+(      0.666666667f)*PI22+(     -0.333333333f)*PI33)  ;
    f9  = feq9 +0.25f *((     -0.333333333f)*PI11                         +(     -0.333333333f)*PI22+(      0.666666667f)*PI33)  ;
    f10 = feq10+0.125f*((      0.666666667f)*PI11+2.0f*(     + PI13      )+(     -0.333333333f)*PI22+(      0.666666667f)*PI33)  ;
    f11 = feq11+0.125f*((     -0.333333333f)*PI11+2.0f*(           + PI23)+(      0.666666667f)*PI22+(      0.666666667f)*PI33)  ;
    f12 = feq12+0.125f*((      0.666666667f)*PI11+2.0f*(     +-PI13      )+(     -0.333333333f)*PI22+(      0.666666667f)*PI33)  ;
    f13 = feq13+0.125f*((     -0.333333333f)*PI11+2.0f*(           +-PI23)+(      0.666666667f)*PI22+(      0.666666667f)*PI33)  ;
    f14 = feq14+0.25f *((     -0.333333333f)*PI11                         +(     -0.333333333f)*PI22+(      0.666666667f)*PI33)  ;
    f15 = feq15+0.125f*((      0.666666667f)*PI11+2.0f*(     +-PI13      )+(     -0.333333333f)*PI22+(      0.666666667f)*PI33)  ;
    f16 = feq16+0.125f*((     -0.333333333f)*PI11+2.0f*(           +-PI23)+(      0.666666667f)*PI22+(      0.666666667f)*PI33)  ;
    f17 = feq17+0.125f*((      0.666666667f)*PI11+2.0f*(     + PI13      )+(     -0.333333333f)*PI22+(      0.666666667f)*PI33)  ;
    f18 = feq18+0.125f*((     -0.333333333f)*PI11+2.0f*(           + PI23)+(      0.666666667f)*PI22+(      0.666666667f)*PI33)  ;
		
}



void __device__ NeumannEast_Regularized(float& f0, float& f1, float& f2,
					float& f3 , float& f4 , float& f5 ,
					float& f6 , float& f7 , float& f8 , float& f9,
					float& f10, float& f11, float& f12,
					float& f13, float& f14, float& f15,
					float& f16, float& f17, float& f18, int y, int z)
{
	if(y == 0 && z == 0){
		f2  = f4;
		f13 = f18;			
		f11 = f18;
		f16 = f18;
		f5  = f8;
		f9  = f14;
		f10 = f15;
	}
	else if(y == 0 && z == ZDIM-1){
		f2  = f4;
		f11 = f13;
		f18 = f13;
		f16 = f13;
		f5  = f8;
		f14 = f9;
		f15 = f10;
	}
	else if(y == YDIM-1 && z == 0){
		f4  = f2;
		f18 = f16;
		f11 = f16;
		f13 = f16;	
		f8  = f5;
		f9  = f14;
		f10 = f15;
	}
	else if(y == YDIM-1 && z == ZDIM-1){
		f4  = f2;
		f13 = f11;
		f16 = f11;
		f18 = f11;
		f8  = f5;
		f14 = f9;
		f15 = f10;
	}

	else{
	if(y == 0){
		f2 = f4;
		f11 = f13;
		f16 = f18;
		f5 = f8;
	}
	else if(y == YDIM-1){
		f4 = f2;
		f13 = f11;
		f18 = f16;
		f8 = f5;
	}
	else if(z == 0){
		f9  = f14;
		f10 = f15;
		f11 = f16;
		f13 = f18;			
	}    
	else if(z == ZDIM-1){
		f14 = f9;
		f15 = f10;
		f16 = f11;
		f18 = f13;
	}
	}

	float PI11 = 0;
	float PI12 = 0;
	float PI22 = 0;
	float PI33 = 0;
	float PI13 = 0;
	float PI23 = 0;

	float u;//,v;//,w;//,rho;
	float rho = 1.0f;
    //v = 0.0f;
	//w = 0.0f;
	u = -rho+(f0+f2+f4+f9+f11+f13+f14+f16+f18+2.0f*(f1+f8+f5+f10+f15)); //D2Q9i
    float usqr = u*u;//+v*v+w*w;
    
    float feq0  = 0.3333333333f*(rho-1.5f*usqr);
    float feq1  = 0.0555555556f*(rho+3.0f*u+4.5f*u*u-1.5f*usqr);
    float feq2  = 0.0555555556f*(rho                -1.5f*usqr);
    float feq3  = 0.0555555556f*(rho-3.0f*u+4.5f*u*u-1.5f*usqr);
    float feq4  = 0.0555555556f*(rho                -1.5f*usqr);
    float feq9  = 0.0555555556f*(rho                -1.5f*usqr);
    float feq14 = 0.0555555556f*(rho                -1.5f*usqr);
    float feq5  = 0.0277777778f*(rho+3.0f*( u)+4.5f*( u)*( u)-1.5f*usqr);
    float feq6  = 0.0277777778f*(rho+3.0f*(-u)+4.5f*(-u)*(-u)-1.5f*usqr);
    float feq7  = 0.0277777778f*(rho+3.0f*(-u)+4.5f*(-u)*(-u)-1.5f*usqr);
    float feq8  = 0.0277777778f*(rho+3.0f*( u)+4.5f*( u)*( u)-1.5f*usqr);
    float feq10 = 0.0277777778f*(rho+3.0f*( u)+4.5f*( u)*( u)-1.5f*usqr);
    float feq11 = 0.0277777778f*(rho                         -1.5f*usqr);
    float feq12 = 0.0277777778f*(rho+3.0f*(-u)+4.5f*(-u)*(-u)-1.5f*usqr);
    float feq13 = 0.0277777778f*(rho                         -1.5f*usqr);
    float feq15 = 0.0277777778f*(rho+3.0f*( u)+4.5f*( u)*( u)-1.5f*usqr);
    float feq16 = 0.0277777778f*(rho                         -1.5f*usqr);
    float feq17 = 0.0277777778f*(rho+3.0f*(-u)+4.5f*(-u)*(-u)-1.5f*usqr);
    float feq18 = 0.0277777778f*(rho                         -1.5f*usqr);
    
//    float feq0  = 0.3333333333f*(rho-1.5f*usqr);
//    float feq1  = 0.0555555556f*(rho+3.0f*u+4.5f*u*u-1.5f*usqr);
//    float feq2  = 0.0555555556f*(rho+3.0f*v+4.5f*v*v-1.5f*usqr);
//    float feq3  = 0.0555555556f*(rho-3.0f*u+4.5f*u*u-1.5f*usqr);
//    float feq4  = 0.0555555556f*(rho-3.0f*v+4.5f*v*v-1.5f*usqr);
//    float feq9  = 0.0555555556f*(rho+3.0f*w+4.5f*w*w-1.5f*usqr);
//    float feq14 = 0.0555555556f*(rho-3.0f*w+4.5f*w*w-1.5f*usqr);
//    float feq5  = 0.0277777778f*(rho+3.0f*( u+v)+4.5f*( u+v)*( u+v)-1.5f*usqr);
//    float feq6  = 0.0277777778f*(rho+3.0f*(-u+v)+4.5f*(-u+v)*(-u+v)-1.5f*usqr);
//    float feq7  = 0.0277777778f*(rho+3.0f*(-u-v)+4.5f*(-u-v)*(-u-v)-1.5f*usqr);
//    float feq8  = 0.0277777778f*(rho+3.0f*( u-v)+4.5f*( u-v)*( u-v)-1.5f*usqr);
//    float feq10 = 0.0277777778f*(rho+3.0f*( u+w)+4.5f*( u+w)*( u+w)-1.5f*usqr);
//    float feq11 = 0.0277777778f*(rho+3.0f*( v+w)+4.5f*( v+w)*( v+w)-1.5f*usqr);
//    float feq12 = 0.0277777778f*(rho+3.0f*(-u+w)+4.5f*(-u+w)*(-u+w)-1.5f*usqr);
//    float feq13 = 0.0277777778f*(rho+3.0f*(-v+w)+4.5f*(-v+w)*(-v+w)-1.5f*usqr);
//    float feq15 = 0.0277777778f*(rho+3.0f*( u-w)+4.5f*( u-w)*( u-w)-1.5f*usqr);
//    float feq16 = 0.0277777778f*(rho+3.0f*( v-w)+4.5f*( v-w)*( v-w)-1.5f*usqr);
//    float feq17 = 0.0277777778f*(rho+3.0f*(-u-w)+4.5f*(-u-w)*(-u-w)-1.5f*usqr);
//    float feq18 = 0.0277777778f*(rho+3.0f*(-v-w)+4.5f*(-v-w)*(-v-w)-1.5f*usqr);

	f3 = feq3 +f1 -feq1 ;
	f7 = feq7 +f5 -feq5 ;
	f6 = feq6 +f8 -feq8 ;
	f17= feq17+f10-feq10;
	f12= feq12+f15-feq15;

    PI11 = (f1-feq1)+(f3-feq3)+(f5-feq5)+(f6-feq6)+(f7-feq7)+(f8-feq8)+(f10-feq10)+(f12-feq12)+(f15-feq15)+(f17-feq17);
    PI22 = (f2-feq2)+(f4-feq4)+(f5-feq5)+(f6-feq6)+(f7-feq7)+(f8-feq8)+(f11-feq11)+(f13-feq13)+(f16-feq16)+(f18-feq18);
    PI33 = (f9-feq9)+(f14-feq14)+(f10-feq10)+(f12-feq12)+(f15-feq15)+(f17-feq17)+(f11-feq11)+(f13-feq13)+(f16-feq16)+(f18-feq18);
    PI12 = (f5-feq5)+(f7-feq7)-(f6-feq6)-(f8-feq8);
    PI13 = (f10-feq10)+(f17-feq17)-(f12-feq12)-(f15-feq15);
    PI23 = (f11-feq11)+(f18-feq18)-(f13-feq13)-(f16-feq16);

    f0  = feq0 +1.5f  *((     -0.333333333f)*PI11                         +(     -0.333333333f)*PI22+(     -0.333333333f)*PI33)  ;
    f1  = feq1 +0.25f *((      0.666666667f)*PI11                         +(     -0.333333333f)*PI22+(     -0.333333333f)*PI33)  ;
    f2  = feq2 +0.25f *((     -0.333333333f)*PI11                         +(      0.666666667f)*PI22+(     -0.333333333f)*PI33)  ;
    f3  = feq3 +0.25f *((      0.666666667f)*PI11                         +(     -0.333333333f)*PI22+(     -0.333333333f)*PI33)  ;
    f4  = feq4 +0.25f *((     -0.333333333f)*PI11                         +(      0.666666667f)*PI22+(     -0.333333333f)*PI33)  ;
    f5  = feq5 +0.125f*((      0.666666667f)*PI11+2.0f*( PI12            )+(      0.666666667f)*PI22+(     -0.333333333f)*PI33)  ;
    f6  = feq6 +0.125f*((      0.666666667f)*PI11+2.0f*(-PI12            )+(      0.666666667f)*PI22+(     -0.333333333f)*PI33)  ;
    f7  = feq7 +0.125f*((      0.666666667f)*PI11+2.0f*( PI12            )+(      0.666666667f)*PI22+(     -0.333333333f)*PI33)  ;
    f8  = feq8 +0.125f*((      0.666666667f)*PI11+2.0f*(-PI12            )+(      0.666666667f)*PI22+(     -0.333333333f)*PI33)  ;
    f9  = feq9 +0.25f *((     -0.333333333f)*PI11                         +(     -0.333333333f)*PI22+(      0.666666667f)*PI33)  ;
    f10 = feq10+0.125f*((      0.666666667f)*PI11+2.0f*(     + PI13      )+(     -0.333333333f)*PI22+(      0.666666667f)*PI33)  ;
    f11 = feq11+0.125f*((     -0.333333333f)*PI11+2.0f*(           + PI23)+(      0.666666667f)*PI22+(      0.666666667f)*PI33)  ;
    f12 = feq12+0.125f*((      0.666666667f)*PI11+2.0f*(     +-PI13      )+(     -0.333333333f)*PI22+(      0.666666667f)*PI33)  ;
    f13 = feq13+0.125f*((     -0.333333333f)*PI11+2.0f*(           +-PI23)+(      0.666666667f)*PI22+(      0.666666667f)*PI33)  ;
    f14 = feq14+0.25f *((     -0.333333333f)*PI11                         +(     -0.333333333f)*PI22+(      0.666666667f)*PI33)  ;
    f15 = feq15+0.125f*((      0.666666667f)*PI11+2.0f*(     +-PI13      )+(     -0.333333333f)*PI22+(      0.666666667f)*PI33)  ;
    f16 = feq16+0.125f*((     -0.333333333f)*PI11+2.0f*(           +-PI23)+(      0.666666667f)*PI22+(      0.666666667f)*PI33)  ;
    f17 = feq17+0.125f*((      0.666666667f)*PI11+2.0f*(     + PI13      )+(     -0.333333333f)*PI22+(      0.666666667f)*PI33)  ;
    f18 = feq18+0.125f*((     -0.333333333f)*PI11+2.0f*(           + PI23)+(      0.666666667f)*PI22+(      0.666666667f)*PI33)  ;
			
}


__device__ void NeumannEast(float& f0, float& f1, float& f2,
					float& f3 , float& f4 , float& f5 ,
					float& f6 , float& f7 , float& f8 , float& f9,
					float& f10, float& f11, float& f12,
					float& f13, float& f14, float& f15,
					float& f16, float& f17, float& f18, int y, int z)
{
	if(y == 0 && z == 0){
		f2  = f4;
		f13 = f18;			
		f11 = f18;
		f16 = f18;
		f5  = f8;
		f9  = f14;
		f10 = f15;
	}
	else if(y == 0 && z == ZDIM-1){
		f2  = f4;
		f11 = f13;
		f18 = f13;
		f16 = f13;
		f5  = f8;
		f14 = f9;
		f15 = f10;
	}
	else if(y == YDIM-1 && z == 0){
		f4  = f2;
		f18 = f16;
		f11 = f16;
		f13 = f16;	
		f8  = f5;
		f9  = f14;
		f10 = f15;
	}
	else if(y == YDIM-1 && z == ZDIM-1){
		f4  = f2;
		f13 = f11;
		f16 = f11;
		f18 = f11;
		f8  = f5;
		f14 = f9;
		f15 = f10;
	}

	else{
	if(y == 0){
		f2 = f4;
//		f6 = f7;
		f11 = f13;
		f16 = f18;

		f5 = f8;
	}
	else if(y == YDIM-1){
		f4 = f2;
//		f7 = f6;
		f13 = f11;
		f18 = f16;

		f8 = f5;
	}
	if(z == 0){
		f9  = f14;
		f10 = f15;
		f11 = f16;
//		f12 = f17;
		f13 = f18;			
	}    
	else if(z == ZDIM-1){
		f14 = f9;
		f15 = f10;
		f16 = f11;
//		f17 = f12;
		f18 = f13;
	}
	}

	float u,v,w;//,rho;
	float rho = 1.0f;
    v = 0.0f;
	w = 0.0f;
	u = -rho+(f0+f2+f4+f9+f11+f13+f14+f16+f18+2.0f*(f1+f8+f5+f10+f15)); //D2Q9i
	float u2 = u*u;
	float v2 = v*v;
	float w2 = w*w;
	float usqr = u2+v2+w2;

//	f3 = f1 -0.333333333f*u;
//	f7 = f5 -0.166666667f*(u+v);
//	f6 = f8 -0.166666667f*(u-v);
//	f17= f10-0.166666667f*(u+w);
//	f12= f15-0.166666667f*(u-w);
	f0 = 1.0f/3.0f*(rho-1.5f*usqr);
	f1 = 1.0f/18.0f*(rho+3.0f*u+4.5f*u*u-1.5f*usqr);
	f2 = 1.0f/18.0f*(rho+3.0f*v+4.5f*v*v-1.5f*usqr);
	f3 = 1.0f/18.0f*(rho-3.0f*u+4.5f*u*u-1.5f*usqr);
	f4 = 1.0f/18.0f*(rho-3.0f*v+4.5f*v*v-1.5f*usqr);
	f5 = 1.0f/36.0f*(rho+3.0f*(u+v)+4.5f*(u+v)*(u+v)-1.5f*usqr);
	f6 = 1.0f/36.0f*(rho+3.0f*(-u+v)+4.5f*(-u+v)*(-u+v)-1.5f*usqr);
	f7 = 1.0f/36.0f*(rho+3.0f*(-u-v)+4.5f*(-u-v)*(-u-v)-1.5f*usqr);
	f8 = 1.0f/36.0f*(rho+3.0f*(u-v)+4.5f*(u-v)*(u-v)-1.5f*usqr);
	f9 = 1.0f/18.0f*(rho+3.0f*w+4.5f*w*w-1.5f*usqr);
	f10= 1.0f/36.0f*(rho+3.0f*(u+w)+4.5f*(u+w)*(u+w)-1.5f*usqr);
	f11= 1.0f/36.0f*(rho+3.0f*(v+w)+4.5f*(v+w)*(u+w)-1.5f*usqr);
	f12= 1.0f/36.0f*(rho+3.0f*(-u+w)+4.5f*(-u+w)*(-u+w)-1.5f*usqr);
	f13= 1.0f/36.0f*(rho+3.0f*(-v+w)+4.5f*(-v+w)*(u+w)-1.5f*usqr);
	f14= 1.0f/18.0f*(rho-3.0f*w+4.5f*w*w-1.5f*usqr);
	f15= 1.0f/36.0f*(rho+3.0f*(u-w)+4.5f*(u-w)*(u-w)-1.5f*usqr);
	f16= 1.0f/36.0f*(rho+3.0f*(v-w)+4.5f*(v-w)*(v-w)-1.5f*usqr);
	f17= 1.0f/36.0f*(rho+3.0f*(-u-w)+4.5f*(-u-w)*(-u-w)-1.5f*usqr);
	f18= 1.0f/36.0f*(rho+3.0f*(-v-w)+4.5f*(-v-w)*(-v-w)-1.5f*usqr);


}


__device__ void NeumannEast_Reg(float& f0, float& f1, float& f2,
					float& f3 , float& f4 , float& f5 ,
					float& f6 , float& f7 , float& f8 , float& f9,
					float& f10, float& f11, float& f12,
					float& f13, float& f14, float& f15,
					float& f16, float& f17, float& f18, int y, int z)
{
	if(y == 0 && z == 0){
		f2  = f4;
		f13 = f18;			
		f11 = f18;
		f16 = f18;
		f5  = f8;
		f9  = f14;
		f10 = f15;
	}
	else if(y == 0 && z == ZDIM-1){
		f2  = f4;
		f11 = f13;
		f18 = f13;
		f16 = f13;
		f5  = f8;
		f14 = f9;
		f15 = f10;
	}
	else if(y == YDIM-1 && z == 0){
		f4  = f2;
		f18 = f16;
		f11 = f16;
		f13 = f16;	
		f8  = f5;
		f9  = f14;
		f10 = f15;
	}
	else if(y == YDIM-1 && z == ZDIM-1){
		f4  = f2;
		f13 = f11;
		f16 = f11;
		f18 = f11;
		f8  = f5;
		f14 = f9;
		f15 = f10;
	}

	else{
	if(y == 0){
		f2 = f4;
//		f6 = f7;
		f11 = f13;
		f16 = f18;

		f5 = f8;
	}
	else if(y == YDIM-1){
		f4 = f2;
//		f7 = f6;
		f13 = f11;
		f18 = f16;

		f8 = f5;
	}
	if(z == 0){
		f9  = f14;
		f10 = f15;
		f11 = f16;
//		f12 = f17;
		f13 = f18;			
	}    
	else if(z == ZDIM-1){
		f14 = f9;
		f15 = f10;
		f16 = f11;
//		f17 = f12;
		f18 = f13;
	}
	}

	float u,v,w;//,rho;
	float rho = 1.0f;
    v = 0.0f;
	w = 0.0f;
	u = -rho+(f0+f2+f4+f9+f11+f13+f14+f16+f18+2.0f*(f1+f8+f5+f10+f15)); //D2Q9i
//	float u2 = u*u;
//	float v2 = v*v;
//	float w2 = w*w;
//	float usqr = u2+v2+w2;

	f3 = f1 -0.333333333f*u;
	f7 = f5 -0.166666667f*(u+v);
	f6 = f8 -0.166666667f*(u-v);
	f17= f10-0.166666667f*(u+w);
	f12= f15-0.166666667f*(u-w);


//	f3 =(0.1031746045f*rho+  -0.0231796391f*usqr+-(0.166666667f*u)   + 0.16666667f*u2)+
//		(f1-(0.1031746045f*rho+  -0.0231796391f*usqr+ (0.166666667f*u)   + 0.16666667f*u2));
//	f7 =(0.0158730149f*rho+  0.00579491071f*usqr+ 0.0833333333f*(-u-v  +u2+(v2-w2))+  0.25f*u*v)+
//		(f5-(0.0158730149f*rho+  0.00579491071f*usqr+ 0.0833333333f*( u+v  +u2+(v2-w2))+  0.25f*u*v));
//	f6 =(0.0158730149f*rho+  0.00579491071f*usqr+ 0.0833333333f*(-u+v  +u2+(v2-w2))+ -0.25f*u*v)+
//		(f8-(0.0158730149f*rho+  0.00579491071f*usqr+ 0.0833333333f*( u-v  +u2+(v2-w2))+ -0.25f*u*v));
//	f17=(0.0158730149f*rho+  0.00579491071f*usqr+ 0.0833333333f*(-u-w  +u2+(v2-w2))+  0.25f*u*w)+
//		(f10-(0.0158730149f*rho+  0.00579491071f*usqr+ 0.0833333333f*( u+w  +u2+(v2-w2))+  0.25f*u*w));
//	f12=(0.0158730149f*rho+  0.00579491071f*usqr+ 0.0833333333f*(-u+w  +u2+(v2-w2))+ -0.25f*u*w)+
//		(f15-(0.0158730149f*rho+  0.00579491071f*usqr+ 0.0833333333f*( u-w  +u2+(v2-w2))+ -0.25f*u*w));


//	f1 =(0.1031746045f*rho+  -0.0231796391f*usqr+ (0.166666667f*u)   + 0.16666667f*u2)+
//		(f3-(0.1031746045f*rho+  -0.0231796391f*usqr+-(0.166666667f*u)   + 0.16666667f*u2));
//	f5 =(0.0158730149f*rho+  0.00579491071f*usqr+ 0.0833333333f*( u+v  +u2+(v2-w2))+  0.25f*u*v)+
//		(f7-(0.0158730149f*rho+  0.00579491071f*usqr+ 0.0833333333f*(-u-v  +u2+(v2-w2))+  0.25f*u*v));
//	f8 =(0.0158730149f*rho+  0.00579491071f*usqr+ 0.0833333333f*( u-v  +u2+(v2-w2))+ -0.25f*u*v)+
//		(f6-(0.0158730149f*rho+  0.00579491071f*usqr+ 0.0833333333f*(-u+v  +u2+(v2-w2))+ -0.25f*u*v));
//	f10=(0.0158730149f*rho+  0.00579491071f*usqr+ 0.0833333333f*( u+w  +u2+(v2-w2))+  0.25f*u*w)+
//		(f17-(0.0158730149f*rho+  0.00579491071f*usqr+ 0.0833333333f*(-u-w  +u2+(v2-w2))+  0.25f*u*w));
//	f15=(0.0158730149f*rho+  0.00579491071f*usqr+ 0.0833333333f*( u-w  +u2+(v2-w2))+ -0.25f*u*w)+
//		(f12-(0.0158730149f*rho+  0.00579491071f*usqr+ 0.0833333333f*(-u+w  +u2+(v2-w2))+ -0.25f*u*w));

//	float PI11 = f1 +f3 +f5 +f6 +f7 +f8 +f10+f12+f15+f17;
//	float PI22 = f2 +f4 +f5 +f6 +f7 +f8 +f11+f13+f16+f18;
//	float PI33 = f9 +f10+f11+f12+f13+f14+f15+f16+f17+f18;

}

__device__ void DirichletNorth_Reg(float& f0, float& f1, float& f2,
					float& f3 , float& f4 , float& f5 ,
					float& f6 , float& f7 , float& f8 , float& f9,
					float& f10, float& f11, float& f12,
					float& f13, float& f14, float& f15,
					float& f16, float& f17, float& f18, int y, int z)
{
//	if(x == 0){
//		f2 = f4;
//		f6 = f7;
//		f11 = f13;
//		f16 = f18;
//	}
//	else if(x == XDIM-1){
//		f4 = f2;
//		f7 = f6;
//		f13 = f11;
//		f18 = f16;
//	}
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
    u = UMAX;
    v = 0.0f;//0.0;
	w = 0.0f;
//	float rho = u+(f0+f2+f4+f9+f11+f13+f14+f16+f18+2.0f*(f3+f6+f7+f12+f17)); //D2Q9i
//	float u2 = u*u;
//	float v2 = v*v;
//	float w2 = w*w;
//	float usqr = u2+v2+w2;

//	f1 =(0.166666667f*u)+
//		(f3-(-(0.166666667f*u)));
	f4 = f2-0.33333333f*v;
//	f5 =(0.0833333333f*( u+v))+
//		(f7-(0.0833333333f*(-u-v)));
	f7 = f5-0.166666667f*(u+v);
//	f8 =(0.0833333333f*( u-v  ))+
//		(f6-(0.0833333333f*(-u+v  )));
	f8 = f6+0.166666667f*(u-v);
//	f10=(0.0833333333f*( u+w))+
//		(f17-(0.0833333333f*(-u-w)));
	f13= f16-0.166666667f*(v-w);
//	f15=(0.0833333333f*( u-w))+
//		(f12-(0.0833333333f*(-u+w)));
	f18= f11-0.166666667f*(v+w);
	
//
//float feq0 = 0.1904761791f*rho+-0.597127747f*usqr                     
//float feq1 = 0.1031746045f*rho+ 0.032375918f*usqr+  0.1666666667f*u    + 0.055555556f*(2.f*u*u-(v*v+w*w));
//float feq2 = 0.1031746045f*rho+ 0.032375918f*usqr+  0.1666666667f*v    +-0.027777778f*(2.f*u*u-(v*v+w*w))+  0.083333333f*(v*v-w*w);
//float feq3 = 0.1031746045f*rho+ 0.032375918f*usqr+ -0.1666666667f*u    + 0.055555556f*(2.f*u*u-(v*v+w*w));
//float feq4 = 0.1031746045f*rho+ 0.032375918f*usqr+ -0.1666666667f*v    +-0.027777778f*(2.f*u*u-(v*v+w*w))+  0.083333333f*(v*v-w*w);
//float feq5 = 0.0158730149f*rho+ 0.033572690f*usqr+  0.083333333f*( u+v)+ 0.027777778f*(2.f*u*u-(v*v+w*w))+  0.083333333f*(v*v-w*w)+  0.25f*u*v                              ;
//float feq6 = 0.0158730149f*rho+ 0.033572690f*usqr+ -0.083333333f*( u-v)+ 0.027777778f*(2.f*u*u-(v*v+w*w))+  0.083333333f*(v*v-w*w)+ -0.25f*u*v                              ;
//float feq7 = 0.0158730149f*rho+ 0.033572690f*usqr+ -0.083333333f*( u+v)+ 0.027777778f*(2.f*u*u-(v*v+w*w))+  0.083333333f*(v*v-w*w)+  0.25f*u*v                              ;
//float feq8 = 0.0158730149f*rho+ 0.033572690f*usqr+  0.083333333f*( u-v)+ 0.027777778f*(2.f*u*u-(v*v+w*w))+  0.083333333f*(v*v-w*w)+ -0.25f*u*v                              ;
//float feq9 = 0.1031746045f*rho+ 0.032375918f*usqr+  0.1666666667f*w;   +-0.027777778f*(2.f*u*u-(v*v+w*w))+ -0.083333333f*(v*v-w*w)                                           
//float feq10= 0.0158730149f*rho+ 0.033572690f*usqr+  0.083333333f*( u+w)+ 0.027777778f*(2.f*u*u-(v*v+w*w))+ -0.083333333f*(v*v-w*w)                              +  0.25f*u*w;
//float feq11= 0.0158730149f*rho+ 0.033572690f*usqr+  0.083333333f*( v+w)+-0.055555556f*(2.f*u*u-(v*v+w*w))                                      +  0.25f*v*w             ;
//float feq12= 0.0158730149f*rho+ 0.033572690f*usqr+ -0.083333333f*( u-w)+ 0.027777778f*(2.f*u*u-(v*v+w*w))+ -0.083333333f*(v*v-w*w)                              + -0.25f*u*w;
//float feq13= 0.0158730149f*rho+ 0.033572690f*usqr+ -0.083333333f*( v-w)+-0.055555556f*(2.f*u*u-(v*v+w*w))                                        -0.25f*v*w             ;
//float feq14= 0.1031746045f*rho+ 0.032375918f*usqr+ -0.1666666667f*w    +-0.027777778f*(2.f*u*u-(v*v+w*w))+ -0.083333333f*(v*v-w*w)                                           
//float feq15= 0.0158730149f*rho+ 0.033572690f*usqr+  0.083333333f*(u-w) + 0.027777778f*(2.f*u*u-(v*v+w*w))+ -0.083333333f*(v*v-w*w)                              + -0.25f*u*w;
//float feq16= 0.0158730149f*rho+ 0.033572690f*usqr+  0.083333333f*(v-w) +-0.055555556f*(2.f*u*u-(v*v+w*w))                                      + -0.25f*v*w             ;
//float feq17= 0.0158730149f*rho+ 0.033572690f*usqr+ -0.083333333f*(u+w) + 0.027777778f*(2.f*u*u-(v*v+w*w))+ -0.083333333f*(v*v-w*w)                              +  0.25f*u*w;
//float feq18= 0.0158730149f*rho+ 0.033572690f*usqr+ -0.083333333f*(v+w) +-0.055555556f*(2.f*u*u-(v*v+w*w))                                      +  0.25f*v*w                 ;
//



//	float PI11 = f1 +f3 +f5 +f6 +f7 +f8 +f10+f12+f15+f17;
//	float PI22 = f2 +f4 +f5 +f6 +f7 +f8 +f11+f13+f16+f18;
//	float PI33 = f9 +f10+f11+f12+f13+f14+f15+f16+f17+f18;

}
__device__ void DirichletSouth_Reg(float& f0, float& f1, float& f2,
					float& f3 , float& f4 , float& f5 ,
					float& f6 , float& f7 , float& f8 , float& f9,
					float& f10, float& f11, float& f12,
					float& f13, float& f14, float& f15,
					float& f16, float& f17, float& f18, int y, int z)
{
//	if(x == 0){
//		f2 = f4;
//		f6 = f7;
//		f11 = f13;
//		f16 = f18;
//	}
//	else if(x == XDIM-1){
//		f4 = f2;
//		f7 = f6;
//		f13 = f11;
//		f18 = f16;
//	}
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
    u = UMAX;
    v = 0.0f;//0.0;
	w = 0.0f;
//	float rho = u+(f0+f2+f4+f9+f11+f13+f14+f16+f18+2.0f*(f3+f6+f7+f12+f17)); //D2Q9i
//	float u2 = u*u;
//	float v2 = v*v;
//	float w2 = w*w;
//	float usqr = u2+v2+w2;

	f2 = f4 +0.33333333f*v;
	f5 = f7 +0.166666667f*(u+v);
	f6 = f8 -0.166666667f*(u-v);
	f16= f13+0.166666667f*(v-w);
	f11= f18+0.166666667f*(v+w);
	
//
//float feq0 = 0.1904761791f*rho+-0.597127747f*usqr                     
//float feq1 = 0.1031746045f*rho+ 0.032375918f*usqr+  0.1666666667f*u    + 0.055555556f*(2.f*u*u-(v*v+w*w));
//float feq2 = 0.1031746045f*rho+ 0.032375918f*usqr+  0.1666666667f*v    +-0.027777778f*(2.f*u*u-(v*v+w*w))+  0.083333333f*(v*v-w*w);
//float feq3 = 0.1031746045f*rho+ 0.032375918f*usqr+ -0.1666666667f*u    + 0.055555556f*(2.f*u*u-(v*v+w*w));
//float feq4 = 0.1031746045f*rho+ 0.032375918f*usqr+ -0.1666666667f*v    +-0.027777778f*(2.f*u*u-(v*v+w*w))+  0.083333333f*(v*v-w*w);
//float feq5 = 0.0158730149f*rho+ 0.033572690f*usqr+  0.083333333f*( u+v)+ 0.027777778f*(2.f*u*u-(v*v+w*w))+  0.083333333f*(v*v-w*w)+  0.25f*u*v                              ;
//float feq6 = 0.0158730149f*rho+ 0.033572690f*usqr+ -0.083333333f*( u-v)+ 0.027777778f*(2.f*u*u-(v*v+w*w))+  0.083333333f*(v*v-w*w)+ -0.25f*u*v                              ;
//float feq7 = 0.0158730149f*rho+ 0.033572690f*usqr+ -0.083333333f*( u+v)+ 0.027777778f*(2.f*u*u-(v*v+w*w))+  0.083333333f*(v*v-w*w)+  0.25f*u*v                              ;
//float feq8 = 0.0158730149f*rho+ 0.033572690f*usqr+  0.083333333f*( u-v)+ 0.027777778f*(2.f*u*u-(v*v+w*w))+  0.083333333f*(v*v-w*w)+ -0.25f*u*v                              ;
//float feq9 = 0.1031746045f*rho+ 0.032375918f*usqr+  0.1666666667f*w;   +-0.027777778f*(2.f*u*u-(v*v+w*w))+ -0.083333333f*(v*v-w*w)                                           
//float feq10= 0.0158730149f*rho+ 0.033572690f*usqr+  0.083333333f*( u+w)+ 0.027777778f*(2.f*u*u-(v*v+w*w))+ -0.083333333f*(v*v-w*w)                              +  0.25f*u*w;
//float feq11= 0.0158730149f*rho+ 0.033572690f*usqr+  0.083333333f*( v+w)+-0.055555556f*(2.f*u*u-(v*v+w*w))                                      +  0.25f*v*w             ;
//float feq12= 0.0158730149f*rho+ 0.033572690f*usqr+ -0.083333333f*( u-w)+ 0.027777778f*(2.f*u*u-(v*v+w*w))+ -0.083333333f*(v*v-w*w)                              + -0.25f*u*w;
//float feq13= 0.0158730149f*rho+ 0.033572690f*usqr+ -0.083333333f*( v-w)+-0.055555556f*(2.f*u*u-(v*v+w*w))                                        -0.25f*v*w             ;
//float feq14= 0.1031746045f*rho+ 0.032375918f*usqr+ -0.1666666667f*w    +-0.027777778f*(2.f*u*u-(v*v+w*w))+ -0.083333333f*(v*v-w*w)                                           
//float feq15= 0.0158730149f*rho+ 0.033572690f*usqr+  0.083333333f*(u-w) + 0.027777778f*(2.f*u*u-(v*v+w*w))+ -0.083333333f*(v*v-w*w)                              + -0.25f*u*w;
//float feq16= 0.0158730149f*rho+ 0.033572690f*usqr+  0.083333333f*(v-w) +-0.055555556f*(2.f*u*u-(v*v+w*w))                                      + -0.25f*v*w             ;
//float feq17= 0.0158730149f*rho+ 0.033572690f*usqr+ -0.083333333f*(u+w) + 0.027777778f*(2.f*u*u-(v*v+w*w))+ -0.083333333f*(v*v-w*w)                              +  0.25f*u*w;
//float feq18= 0.0158730149f*rho+ 0.033572690f*usqr+ -0.083333333f*(v+w) +-0.055555556f*(2.f*u*u-(v*v+w*w))                                      +  0.25f*v*w                 ;
//



//	float PI11 = f1 +f3 +f5 +f6 +f7 +f8 +f10+f12+f15+f17;
//	float PI22 = f2 +f4 +f5 +f6 +f7 +f8 +f11+f13+f16+f18;
//	float PI33 = f9 +f10+f11+f12+f13+f14+f15+f16+f17+f18;

}

__device__ void xsymmetry_bot(float& f0, float& f1, float& f2,
					float& f3 , float& f4 , float& f5 ,
					float& f6 , float& f7 , float& f8 , float& f9,
					float& f10, float& f11, float& f12,
					float& f13, float& f14, float& f15,
					float& f16, float& f17, float& f18, int y, int z)
{
	if(y == 0 && z == 0){
		f2 = f4;
        f13=f18;
        f11=f18;
        f16=f18;
		f6 =f7;
        f9 =f14;
        f12=f17;
	}
	else if(y == 0 && z == ZDIM-1){
		f4 = f2;
        f11=f13;
        f18=f13;
        f16=f13;
		f6 =f7;
        f14=f9;
        f17=f12;
	}
	else if(y == YDIM-1 && z == 0){
		f4 = f2;
        f11=f16;
        f18=f16;
        f13=f16;
		f7 =f6;
        f9 =f14;
        f12=f17;
	}
	else if(y == YDIM-1 && z == ZDIM-1){
		f4 = f2;
        f16=f11;
        f18=f11;
        f13=f11;
		f7 =f6;
        f14=f9;
        f17=f12;
	}
    else{
	if(y == 0){
        f2 = f4;
        f11=f13;
        f16=f18;
        f8 = f5;
    }
	else if(y == YDIM-1){
         f4=f2 ;
        f13=f11;
        f18=f16;
         f5=f8 ;
    }
//	if(z == 0){
//		f9  = f14;
//		f10 = f15;
//		f11 = f16;
//		f12 = f17;
//		f13 = f18;			
//	}    
//	else if(z == ZDIM-1){
//		f14 = f9;
//		f15 = f10;
//		f16 = f11;
//		f17 = f12;
//		f18 = f13;
//	}
    }
	f1 = f3 ;
	f5 = f6 ;
	f8 = f7 ;
	f10= f12;
	f15= f17;
}
__device__ void xsymmetry_top(float& f0, float& f1, float& f2,
					float& f3 , float& f4 , float& f5 ,
					float& f6 , float& f7 , float& f8 , float& f9,
					float& f10, float& f11, float& f12,
					float& f13, float& f14, float& f15,
					float& f16, float& f17, float& f18, int y, int z)
{
	if(y == 0 && z == 0){
		f2  = f4;
		f13 = f18;			
		f11 = f18;
		f16 = f18;
		f5  = f8;
		f9  = f14;
		f10 = f15;
	}
	else if(y == 0 && z == ZDIM-1){
		f2  = f4;
		f11 = f13;
		f18 = f13;
		f16 = f13;
		f5  = f8;
		f14 = f9;
		f15 = f10;
	}
	else if(y == YDIM-1 && z == 0){
		f4  = f2;
		f18 = f16;
		f11 = f16;
		f13 = f16;	
		f8  = f5;
		f9  = f14;
		f10 = f15;
	}
	else if(y == YDIM-1 && z == ZDIM-1){
		f4  = f2;
		f13 = f11;
		f16 = f11;
		f18 = f11;
		f8  = f5;
		f14 = f9;
		f15 = f10;
	}

	else{
	if(y == 0){
		f2 = f4;
		f11 = f13;
		f16 = f18;
		f5 = f8;
	}
	else if(y == YDIM-1){
		f4 = f2;
		f13 = f11;
		f18 = f16;
		f8 = f5;
	}
//	else if(z == 0){
//		f9  = f14;
//		f10 = f15;
//		f11 = f16;
//		f12 = f17;
//		f13 = f18;			
//	}    
//	else if(z == ZDIM-1){
//		f14 = f9;
//		f15 = f10;
//		f16 = f11;
//		f17 = f12;
//		f18 = f13;
//	}
	}
	f3 = f1 ;
	f6 = f5 ;
	f7 = f8 ;
	f12= f10;
	f17= f15;
}

__device__ void ysymmetry_top(float& f0, float& f1, float& f2,
					float& f3 , float& f4 , float& f5 ,
					float& f6 , float& f7 , float& f8 , float& f9,
					float& f10, float& f11, float& f12,
					float& f13, float& f14, float& f15,
					float& f16, float& f17, float& f18, int z)
{
	if(z == 0){
	f9 = f14;
	f10= f15;
	f11= f16;
	f12= f17;
	f13= f18;
	}
	if(z == ZDIM-1){
	f14= f9 ;
	f15= f10;
	f16= f11;
	f17= f12;
	f18= f13;
	}
	f4 = f2 ;
	f7 = f6 ;
	f8 = f5 ;
	f13= f11;
	f18= f16;
}

__device__ void ysymmetry_bot(float& f0, float& f1, float& f2,
					float& f3 , float& f4 , float& f5 ,
					float& f6 , float& f7 , float& f8 , float& f9,
					float& f10, float& f11, float& f12,
					float& f13, float& f14, float& f15,
					float& f16, float& f17, float& f18, int z)
{
	if(z == 0){
	f9 = f14;
	f10= f15;
	f11= f16;
	f12= f17;
	f13= f18;
	}
	if(z == ZDIM-1){
	f14= f9 ;
	f15= f10;
	f16= f11;
	f17= f12;
	f18= f13;
	}
	f2 = f4 ;
	f6 = f7 ;
	f5 = f8 ;
	f11= f13;
	f16= f18;
}

__device__ void zsymmetry_top(float& f0, float& f1, float& f2,
					float& f3 , float& f4 , float& f5 ,
					float& f6 , float& f7 , float& f8 , float& f9,
					float& f10, float& f11, float& f12,
					float& f13, float& f14, float& f15,
					float& f16, float& f17, float& f18, int y)
{
	if(y == 0){
	f2 = f4 ;
	f6 = f7 ;
	f5 = f8 ;
	f11= f13;
	f16= f18;
	}
	if(y == YDIM-1){
	f4 = f2 ;
	f7 = f6 ;
	f8 = f5 ;
	f13= f11;
	f18= f16;
	}
	f14= f9 ;
	f15= f10;
	f16= f11;
	f17= f12;
	f18= f13;
}

__device__ void zsymmetry_bot(float& f0, float& f1, float& f2,
					float& f3 , float& f4 , float& f5 ,
					float& f6 , float& f7 , float& f8 , float& f9,
					float& f10, float& f11, float& f12,
					float& f13, float& f14, float& f15,
					float& f16, float& f17, float& f18, int y)
{
	if(y == 0){
	f2 = f4 ;
	f6 = f7 ;
	f5 = f8 ;
	f11= f13;
	f16= f18;
	}
	if(y == YDIM-1){
	f4 = f2 ;
	f7 = f6 ;
	f8 = f5 ;
	f13= f11;
	f18= f16;
	}
	f9 = f14;
	f10= f15;
	f11= f16;
	f12= f17;
	f13= f18;
}

inline __device__ void boundaries(float& f0, float& f1, float& f2,
					float& f3 , float& f4 , float& f5 ,
					float& f6 , float& f7 , float& f8 , float& f9,
					float& f10, float& f11, float& f12,
					float& f13, float& f14, float& f15,
					float& f16, float& f17, float& f18, int y, int z, int im)
{
//	if(im == 3)//DirichletWest
//	{
//		DirichletWest(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,y,z);
//	}
	if(im == 53)//DirichletWest
	{
		//DirichletWest_Reg(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,y,z);
		DirichletWest_Regularized(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,y,z);
	}
	else if(im == 54)//DirichletWest
	{
		//NeumannEast(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,y,z);
		NeumannEast_Regularized(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,y,z);
	}
//	if(im == 4)//DirichletWest
//	{
//		NeumannEast(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,y,z);
//	}
//	if(im == 13)//DirichletWest
//	{
//		DirichletWest_Reg(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,y,z);
//	}
//	else if(im == 14)//DirichletWest
//	{
//		NeumannEast_Reg(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,y,z);
//	}
//	else if(im == 15)//DirichletNorth
//	{
//		DirichletNorth_Reg(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,y,z);
//	}
//	if(im == 16)//DirichletSouth
//	{
//		DirichletSouth_Reg(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,y,z);
//	}
	if(im == 21)//ysymm top
	{
		ysymmetry_top(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,z);
	}
	else if(im == 22)//ysymm bot
	{
		ysymmetry_bot(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,z);
	}
	else if(im == 23)//zsymm top
	{
		zsymmetry_top(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,y);
	}
	else if(im == 24)//zsymm bot
	{
		zsymmetry_bot(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,y);
	}
}
inline __device__ void boundaries_force(float& f0, float& f1, float& f2,
					float& f3 , float& f4 , float& f5 ,
					float& f6 , float& f7 , float& f8 , float& f9,
					float& f10, float& f11, float& f12,
					float& f13, float& f14, float& f15,
					float& f16, float& f17, float& f18, int y, int z, int im)
{
//	if(im == 3)//DirichletWest
//	{
//		DirichletWest(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,y,z);
//	}
	if(im == 53)//DirichletWest
	{
		DirichletWest_Reg(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,y,z);
		//DirichletWest_Regularized(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,y,z);
	}
	else if(im == 54)//DirichletWest
	{
		NeumannEast(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,y,z);
		//NeumannEast_Regularized(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,y,z);
	}
//	else if(im == 15)//DirichletNorth
//	{
//		DirichletNorth_Reg(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,y,z);
//	}
//	else if(im == 16)//DirichletSouth
//	{
//		DirichletSouth_Reg(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,y,z);
//	}
	else if(im == 21)//ysymm top
	{
		ysymmetry_top(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,z);
	}
	else if(im == 22)//ysymm bot
	{
		ysymmetry_bot(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,z);
	}
	else if(im == 23)//zsymm top
	{
		zsymmetry_top(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,y);
	}
	else if(im == 24)//zsymm bot
	{
		zsymmetry_bot(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,y);
	}
	else if(im == 25)//zsymm top
	{
		xsymmetry_top(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,y,z);
	}
	else if(im == 26)//zsymm bot
	{
		xsymmetry_bot(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,y,z);
	}
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
	rho = f0+f1+f2+f3+f4+f5+f6+f7+f8+f9;
	rho +=f10+f11+f12+f13+f14+f15+f16+f17+f18;
	u = f1-f3+f5-f6-f7+f8+f10-f12+f15-f17;
	v = f2-f4+f5+f6-f7-f8+f11-f13+f16-f18;
	w = f9+f10+f11+f12+f13-f14-f15-f16-f17-f18;
	float usqr = u*u+v*v+w*w;

//	f0 =(1.f-omega)*f0 +omega*(0.3333333333f*(rho-1.5f*usqr));
//	f1 =(1.f-omega)*f1 +omega*(0.0555555556f*(rho+3.0f*u+4.5f*u*u-1.5f*usqr));                
//	f2 =(1.f-omega)*f2 +omega*(0.0555555556f*(rho+3.0f*v+4.5f*v*v-1.5f*usqr));
//	f3 =(1.f-omega)*f3 +omega*(0.0555555556f*(rho-3.0f*u+4.5f*u*u-1.5f*usqr));
//	f4 =(1.f-omega)*f4 +omega*(0.0555555556f*(rho-3.0f*v+4.5f*v*v-1.5f*usqr));
//	f5 =(1.f-omega)*f5 +omega*(0.0277777778f*(rho+3.0f*(u+v)+4.5f*(u+v)*(u+v)-1.5f*usqr));
//	f6 =(1.f-omega)*f6 +omega*(0.0277777778f*(rho+3.0f*(-u+v)+4.5f*(-u+v)*(-u+v)-1.5f*usqr));
//	f7 =(1.f-omega)*f7 +omega*(0.0277777778f*(rho+3.0f*(-u-v)+4.5f*(-u-v)*(-u-v)-1.5f*usqr));
//	f8 =(1.f-omega)*f8 +omega*(0.0277777778f*(rho+3.0f*(u-v)+4.5f*(u-v)*(u-v)-1.5f*usqr));
//	f9 =(1.f-omega)*f9 +omega*(0.0555555556f*(rho+3.0f*w+4.5f*w*w-1.5f*usqr));
//	f10=(1.f-omega)*f10+omega*(0.0277777778f*(rho+3.0f*(u+w)+4.5f*(u+w)*(u+w)-1.5f*usqr));
//	f11=(1.f-omega)*f11+omega*(0.0277777778f*(rho+3.0f*(v+w)+4.5f*(v+w)*(u+w)-1.5f*usqr));
//	f12=(1.f-omega)*f12+omega*(0.0277777778f*(rho+3.0f*(-u+w)+4.5f*(-u+w)*(-u+w)-1.5f*usqr));
//	f13=(1.f-omega)*f13+omega*(0.0277777778f*(rho+3.0f*(-v+w)+4.5f*(-v+w)*(u+w)-1.5f*usqr));
//	f14=(1.f-omega)*f14+omega*(0.0555555556f*(rho-3.0f*w+4.5f*w*w-1.5f*usqr));
//	f15=(1.f-omega)*f15+omega*(0.0277777778f*(rho+3.0f*(u-w)+4.5f*(u-w)*(u-w)-1.5f*usqr));
//	f16=(1.f-omega)*f16+omega*(0.0277777778f*(rho+3.0f*(v-w)+4.5f*(v-w)*(v-w)-1.5f*usqr));
//	f17=(1.f-omega)*f17+omega*(0.0277777778f*(rho+3.0f*(-u-w)+4.5f*(-u-w)*(-u-w)-1.5f*usqr));
//	f18=(1.f-omega)*f18+omega*(0.0277777778f*(rho+3.0f*(-v-w)+4.5f*(-v-w)*(-v-w)-1.5f*usqr));

	f0 -=omega*(f0 -0.3333333333f*(rho-1.5f*usqr));
	f1 -=omega*(f1 -0.0555555556f*(rho+3.0f*u+4.5f*u*u-1.5f*usqr));                
	f2 -=omega*(f2 -0.0555555556f*(rho+3.0f*v+4.5f*v*v-1.5f*usqr));
	f3 -=omega*(f3 -0.0555555556f*(rho-3.0f*u+4.5f*u*u-1.5f*usqr));
	f4 -=omega*(f4 -0.0555555556f*(rho-3.0f*v+4.5f*v*v-1.5f*usqr));
	f5 -=omega*(f5 -0.0277777778f*(rho+3.0f*(u+v)+4.5f*(u+v)*(u+v)-1.5f*usqr));
	f6 -=omega*(f6 -0.0277777778f*(rho+3.0f*(-u+v)+4.5f*(-u+v)*(-u+v)-1.5f*usqr));
	f7 -=omega*(f7 -0.0277777778f*(rho+3.0f*(-u-v)+4.5f*(-u-v)*(-u-v)-1.5f*usqr));
	f8 -=omega*(f8 -0.0277777778f*(rho+3.0f*(u-v)+4.5f*(u-v)*(u-v)-1.5f*usqr));
	f9 -=omega*(f9 -0.0555555556f*(rho+3.0f*w+4.5f*w*w-1.5f*usqr));
	f10-=omega*(f10-0.0277777778f*(rho+3.0f*(u+w)+4.5f*(u+w)*(u+w)-1.5f*usqr));
	f11-=omega*(f11-0.0277777778f*(rho+3.0f*(v+w)+4.5f*(v+w)*(v+w)-1.5f*usqr));
	f12-=omega*(f12-0.0277777778f*(rho+3.0f*(-u+w)+4.5f*(-u+w)*(-u+w)-1.5f*usqr));
	f13-=omega*(f13-0.0277777778f*(rho+3.0f*(-v+w)+4.5f*(-v+w)*(-v+w)-1.5f*usqr));
	f14-=omega*(f14-0.0555555556f*(rho-3.0f*w+4.5f*w*w-1.5f*usqr));
	f15-=omega*(f15-0.0277777778f*(rho+3.0f*(u-w)+4.5f*(u-w)*(u-w)-1.5f*usqr));
	f16-=omega*(f16-0.0277777778f*(rho+3.0f*(v-w)+4.5f*(v-w)*(v-w)-1.5f*usqr));
	f17-=omega*(f17-0.0277777778f*(rho+3.0f*(-u-w)+4.5f*(-u-w)*(-u-w)-1.5f*usqr));
	f18-=omega*(f18-0.0277777778f*(rho+3.0f*(-v-w)+4.5f*(-v-w)*(-v-w)-1.5f*usqr));

}

inline __device__ void mrt_collide(float& f0, float& f1, float& f2,
					float& f3 , float& f4 , float& f5 ,
					float& f6 , float& f7 , float& f8 , float& f9,
					float& f10, float& f11, float& f12,
					float& f13, float& f14, float& f15,
					float& f16, float& f17, float& f18, float omega)
{
	float u,v,w;	
	u = f1-f3+f5-f6-f7+f8+f10-f12+f15-f17;
	v = f2-f4+f5+f6-f7-f8+f11-f13+f16-f18;
	w = f9+f10+f11+f12+f13-f14-f15-f16-f17-f18;
	float rho = f0+f1+f2+f3+f4+f5+f6+f7+f8+f9+
	      f10+f11+f12+f13+f14+f15+f16+f17+f18;
    float usqr = u*u+v*v+w*w;
//	u = rho*u;
//	v = rho*v;
//	w = rho*w;


	float m1,m2,m4,m6,m8,m9,m10,m11,m12,m13,m14,m15,m16,m17,m18;

	//COMPUTE M-MEQ
	//m1  = -19.f*f0+ 19.f*f5+19.f*f6+19.f*f7+19.f*f8+19.f*f10+19.f*f11+19.f*f12+19.f*f13+19.f*f15+19.f*f16+19.f*f17+19.f*f18   -19.f*(u*u+v*v+w*w);//+8.f*(f5+f6+f7+f8+f10+f11+f12+f13+f15+f16+f17+f18);
	//m4  = -3.33333333f*f1+3.33333333f*f3+1.66666667f*f5-1.66666667f*f6-1.66666667f*f7+1.66666667f*f8+1.66666667f*f10-1.66666667f*f12+1.66666667f*f15-1.66666667f*f17;
	//m6  = -3.33333333f*f2+3.33333333f*f4+1.66666667f*f5+1.66666667f*f6-1.66666667f*f7-1.66666667f*f8+1.66666667f*f11-1.66666667f*f13+1.66666667f*f16-1.66666667f*f18;
	//m8  = -3.33333333f*f9+1.66666667f*f10+1.66666667f*f11+1.66666667f*f12+1.66666667f*f13+3.33333333f*f14-1.66666667f*f15-1.66666667f*f16-1.66666667f*f17-1.66666667f*f18;
	m1  = 19.f*(-f0+ f5+f6+f7+f8+f10+f11+f12+f13+f15+f16+f17+f18   -(u*u+v*v+w*w));//+8.f*(f5+f6+f7+f8+f10+f11+f12+f13+f15+f16+f17+f18);
	m2  =  12.f*f0+ -4.f*f1+ -4.f*f2+ -4.f*f3+ -4.f*f4+      f5+      f6+      f7+      f8+ -4.f*f9+    f10+        f11+      f12+      f13+ -4.f*f14+      f15+      f16+      f17+      f18 +7.53968254f*(u*u+v*v+w*w);
//	m4  = 1.666666667f*(-2.f*f1+2.f*f3+f5-f6-f7+f8+f10-f12+f15-f17);
//	m6  = 1.666666667f*(-2.f*f2+2.f*f4+f5+f6-f7-f8+f11-f13+f16-f18);
//	m8  = 1.666666667f*(-2.f*f9+f10+f11+f12+f13+2.f*f14-f15-f16-f17-f18);
	m4  = 1.666666667f*(-3.f*f1+3.f*f3+u);
	m6  = 1.666666667f*(-3.f*f2+3.f*f4+v);
	m8  = 1.666666667f*(-3.f*f9+3.f*f14+w);
	m9  = 2.f*f1+  -  f2+  2.f*f3+  -  f4+ f5+ f6+ f7+ f8+-    f9+ f10+ -2.f*f11+ f12+-2.f*f13+-    f14+ f15+ -2.f*f16+ f17+-2.f*f18  -(2.f*u*u-(v*v+w*w));
	m10 =-4.f*f1+ 2.f*f2+ -4.f*f3+ 2.f*f4+ f5+ f6+ f7+ f8+ 2.f*f9+ f10+ -2.f*f11+ f12+-2.f*f13+ 2.f*f14+ f15+ -2.f*f16+ f17+-2.f*f18;
	m11 =             f2         +     f4+ f5+ f6+ f7+ f8+-    f9+-f10          +-f12         +-    f14+-f15          +-f17         -(v*v-w*w);
	m12 =        -2.f*f2          -2.f*f4+ f5+ f6+ f7+ f8+ 2.f*f9+-f10          +-f12         + 2.f*f14+-f15          +-f17         ;
	m13 =                                  f5+-f6+ f7+-f8                                                                             -u*v;
	m14 =                                                                    f11     +-    f13              + -    f16     +     f18  -v*w;
	m15 =                                                          f10        + - f12                  +-f15          + f17           -u*w;  
	m16 =                                  f5+-f6+-f7+ f8         -f10        +   f12                  +-f15          + f17         ;  
	m17 =                                 -f5+-f6+ f7+ f8              +     f11     +-    f13              +      f16     +-    f18;  
	m18 =                                                          f10+-     f11+ f12+-    f13         +-f15+      f16+-f17+     f18;

	if(SmagLES == "YES"){
////		float PI11 = -1.0f/38.0f*(     (m1)+19.0f*omega* (m9));
////		float PI22 = -1.0f/76.0f*(2.0f*(m1)-19.0f*(omega*(m9)-3.0f*omega*(m11)));
////		float PI33 = -1.0f/76.0f*(2.0f*(m1)-19.0f*(omega*(m9)+3.0f*omega*(m11)));
//		float PI11 = LRLEVEL*-0.026315789f*m1-0.5f *omega*m9;
//		float PI22 = LRLEVEL*-0.026315789f*m1+0.25f*omega*(m9-3.0f*m11);
//		float PI33 = LRLEVEL*-0.026315789f*m1+0.25f*omega*(m9+3.0f*m11);
//		float PI12 = LRLEVEL*-1.5f*omega*m13;
//		float PI23 = LRLEVEL*-1.5f*omega*m14;
//		float PI13 = LRLEVEL*-1.5f*omega*m15;
//		float nu0 = ((1.0f/omega)-0.5f)*LRFACTOR/3.0f;
//		float Smag = sqrt(2.f*(PI11*PI11+PI22*PI22+PI33*PI33+2.f*PI12*PI12+2.f*PI23*PI23+2.f*PI13*PI13));
//		//float Cs = 0.01f;
//		omega = 1.0f/(3.0f*(nu0+CS*Smag*LRFACTOR*LRFACTOR)*LRLEVEL+0.5f);
//		//omega = 1.0f/(1.0f/omega+3.f*CS*Smag*LRFACTOR*LRFACTOR);
//        //omega = 1.0f/(1.0f*LRLEVEL/1.99983f-1.f+0.5f+3.f*CS*Smag*LRFACTOR);

//float feq0 = 0.1904761791f*rho+-0.597127747f*usqr                                                 ;
float feq1 = 0.1031746045f*rho+ 0.032375918f*usqr+  0.1666666667f*u                                                   ;
float feq2 = 0.1031746045f*rho+ 0.032375918f*usqr+  0.1666666667f*v                       ;
float feq3 = 0.1031746045f*rho+ 0.032375918f*usqr+ -0.1666666667f*u                                                   ;
float feq4 = 0.1031746045f*rho+ 0.032375918f*usqr+ -0.1666666667f*v                       ;
float feq5 = 0.0158730149f*rho+ 0.033572690f*usqr+  0.083333333f*( u+v)                            ;
float feq6 = 0.0158730149f*rho+ 0.033572690f*usqr+ -0.083333333f*( u-v)                            ;
float feq7 = 0.0158730149f*rho+ 0.033572690f*usqr+ -0.083333333f*( u+v)                            ;
float feq8 = 0.0158730149f*rho+ 0.033572690f*usqr+  0.083333333f*( u-v)                            ;
float feq9 = 0.1031746045f*rho+ 0.032375918f*usqr+  0.1666666667f*w;
float feq10= 0.0158730149f*rho+ 0.033572690f*usqr+  0.083333333f*( u+w)                                 ;
float feq11= 0.0158730149f*rho+ 0.033572690f*usqr+  0.083333333f*( v+w);
float feq12= 0.0158730149f*rho+ 0.033572690f*usqr+ -0.083333333f*( u-w)                            ;
float feq13= 0.0158730149f*rho+ 0.033572690f*usqr+ -0.083333333f*( v-w);
float feq14= 0.1031746045f*rho+ 0.032375918f*usqr+ -0.1666666667f*w;
float feq15= 0.0158730149f*rho+ 0.033572690f*usqr+  0.083333333f*(u-w)                            ;
float feq16= 0.0158730149f*rho+ 0.033572690f*usqr+  0.083333333f*(v-w);
float feq17= 0.0158730149f*rho+ 0.033572690f*usqr+ -0.083333333f*(u+w)                            ;
float feq18= 0.0158730149f*rho+ 0.033572690f*usqr+ -0.083333333f*(v+w);

feq1 +=  0.055555556f*(2.f*u*u-(v*v+w*w));
feq2 += -0.027777778f*(2.f*u*u-(v*v+w*w))+  0.083333333f*(v*v-w*w);
feq3 +=  0.055555556f*(2.f*u*u-(v*v+w*w));
feq4 += -0.027777778f*(2.f*u*u-(v*v+w*w))+  0.083333333f*(v*v-w*w);
feq5 +=  0.027777778f*(2.f*u*u-(v*v+w*w))+  0.083333333f*(v*v-w*w)+  0.25f*u*v                              ;
feq6 +=  0.027777778f*(2.f*u*u-(v*v+w*w))+  0.083333333f*(v*v-w*w)+ -0.25f*u*v                              ;
feq7 +=  0.027777778f*(2.f*u*u-(v*v+w*w))+  0.083333333f*(v*v-w*w)+  0.25f*u*v                              ;
feq8 +=  0.027777778f*(2.f*u*u-(v*v+w*w))+  0.083333333f*(v*v-w*w)+ -0.25f*u*v                              ;
feq9 += -0.027777778f*(2.f*u*u-(v*v+w*w))+ -0.083333333f*(v*v-w*w)                                            ;
feq10+=  0.027777778f*(2.f*u*u-(v*v+w*w))+ -0.083333333f*(v*v-w*w)                              +  0.25f*u*w;
feq11+= -0.055555556f*(2.f*u*u-(v*v+w*w))                                      +  0.25f*v*w             ;
feq12+=  0.027777778f*(2.f*u*u-(v*v+w*w))+ -0.083333333f*(v*v-w*w)                              + -0.25f*u*w;
feq13+= -0.055555556f*(2.f*u*u-(v*v+w*w))                                        -0.25f*v*w             ;
feq14+= -0.027777778f*(2.f*u*u-(v*v+w*w))+ -0.083333333f*(v*v-w*w)                                            ;
feq15+=  0.027777778f*(2.f*u*u-(v*v+w*w))+ -0.083333333f*(v*v-w*w)                              + -0.25f*u*w;
feq16+= -0.055555556f*(2.f*u*u-(v*v+w*w))                                      + -0.25f*v*w             ;
feq17+=  0.027777778f*(2.f*u*u-(v*v+w*w))+ -0.083333333f*(v*v-w*w)                              +  0.25f*u*w;
feq18+= -0.055555556f*(2.f*u*u-(v*v+w*w))                                      +  0.25f*v*w                 ;

float PI11 = (f1-feq1)+(f3-feq3)+(f5-feq5)+(f6-feq6)+(f7-feq7)+(f8-feq8)+(f10-feq10)+(f12-feq12)+(f15-feq15)+(f17-feq17);
float PI22 = (f2-feq2)+(f4-feq4)+(f5-feq5)+(f6-feq6)+(f7-feq7)+(f8-feq8)+(f11-feq11)+(f13-feq13)+(f16-feq16)+(f18-feq18);
float PI33 = (f9-feq9)+(f14-feq14)+(f10-feq10)+(f12-feq12)+(f15-feq15)+(f17-feq17)+(f11-feq11)+(f13-feq13)+(f16-feq16)+(f18-feq18);
float PI12 = (f5-feq5)+(f7-feq7)-(f6-feq6)-(f8-feq8);
float PI13 = (f10-feq10)+(f17-feq17)-(f12-feq12)-(f15-feq15);
float PI23 = (f11-feq11)+(f18-feq18)-(f13-feq13)-(f16-feq16);

float Q = sqrt(PI11*PI11+PI22*PI22+PI33*PI33+2.f*PI12*PI12+2.f*PI23*PI23+2.f*PI13*PI13);
//float nu0 = ((1.0f/omega)-0.5f)*LRFACTOR/3.0f;
float tau0 = 1.f/omega;

//float Smag = (sqrt(nu0*nu0+18.f*CS*LRFACTOR*LRFACTOR*Q)-nu0)/(6.f*CS*LRFACTOR*LRFACTOR);
//float Smag = LRFACTOR*(sqrt(4.f/9.f*tau0*tau0+8.f*CS*LRFACTOR*Q)-2.f/3.f*tau0)/(4.f*CS*LRFACTOR*LRFACTOR);

//omega = 1.0f/(3.0f*(nu0+CS*Smag*LRFACTOR*LRFACTOR)*LRLEVEL+0.5f);

//float tau = tau0+0.5*(-tau0+sqrt(tau0*tau0+18.f*CS*LRFACTOR*Q));
float tau = tau0+0.5f*(-tau0+sqrt(tau0*tau0+18.f*CS*sqrt(2.f)*Q));
omega = 1.f/tau;

//float tau = 3.f*nu0*LRFACTOR+0.5f+(sqrt(tau0*tau0+18.f*CS*CS*LRFACTOR*LRFACTOR*Q)-tau0)*0.5f;
//omega = 1.f/tau;



	}


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

inline __device__ void mrt_collide_LES(float& f0, float& f1, float& f2,
					float& f3 , float& f4 , float& f5 ,
					float& f6 , float& f7 , float& f8 , float& f9,
					float& f10, float& f11, float& f12,
					float& f13, float& f14, float& f15,
					float& f16, float& f17, float& f18, float omega, float Cs)
{
	float u,v,w;	
	u = f1-f3+f5-f6-f7+f8+f10-f12+f15-f17;
	v = f2-f4+f5+f6-f7-f8+f11-f13+f16-f18;
	w = f9+f10+f11+f12+f13-f14-f15-f16-f17-f18;
	float rho = f0+f1+f2+f3+f4+f5+f6+f7+f8+f9+
	      f10+f11+f12+f13+f14+f15+f16+f17+f18;
    float usqr = u*u+v*v+w*w;
//	u = rho*u;
//	v = rho*v;
//	w = rho*w;


	float m1,m2,m4,m6,m8,m9,m10,m11,m12,m13,m14,m15,m16,m17,m18;

	//COMPUTE M-MEQ
	//m1  = -19.f*f0+ 19.f*f5+19.f*f6+19.f*f7+19.f*f8+19.f*f10+19.f*f11+19.f*f12+19.f*f13+19.f*f15+19.f*f16+19.f*f17+19.f*f18   -19.f*(u*u+v*v+w*w);//+8.f*(f5+f6+f7+f8+f10+f11+f12+f13+f15+f16+f17+f18);
	//m4  = -3.33333333f*f1+3.33333333f*f3+1.66666667f*f5-1.66666667f*f6-1.66666667f*f7+1.66666667f*f8+1.66666667f*f10-1.66666667f*f12+1.66666667f*f15-1.66666667f*f17;
	//m6  = -3.33333333f*f2+3.33333333f*f4+1.66666667f*f5+1.66666667f*f6-1.66666667f*f7-1.66666667f*f8+1.66666667f*f11-1.66666667f*f13+1.66666667f*f16-1.66666667f*f18;
	//m8  = -3.33333333f*f9+1.66666667f*f10+1.66666667f*f11+1.66666667f*f12+1.66666667f*f13+3.33333333f*f14-1.66666667f*f15-1.66666667f*f16-1.66666667f*f17-1.66666667f*f18;
	m1  = 19.f*(-f0+ f5+f6+f7+f8+f10+f11+f12+f13+f15+f16+f17+f18   -(u*u+v*v+w*w));//+8.f*(f5+f6+f7+f8+f10+f11+f12+f13+f15+f16+f17+f18);
	m2  =  12.f*f0+ -4.f*f1+ -4.f*f2+ -4.f*f3+ -4.f*f4+      f5+      f6+      f7+      f8+ -4.f*f9+    f10+        f11+      f12+      f13+ -4.f*f14+      f15+      f16+      f17+      f18 +7.53968254f*(u*u+v*v+w*w);
//	m4  = 1.666666667f*(-2.f*f1+2.f*f3+f5-f6-f7+f8+f10-f12+f15-f17);
//	m6  = 1.666666667f*(-2.f*f2+2.f*f4+f5+f6-f7-f8+f11-f13+f16-f18);
//	m8  = 1.666666667f*(-2.f*f9+f10+f11+f12+f13+2.f*f14-f15-f16-f17-f18);
	m4  = 1.666666667f*(-3.f*f1+3.f*f3+u);
	m6  = 1.666666667f*(-3.f*f2+3.f*f4+v);
	m8  = 1.666666667f*(-3.f*f9+3.f*f14+w);
	m9  = 2.f*f1+  -  f2+  2.f*f3+  -  f4+ f5+ f6+ f7+ f8+-    f9+ f10+ -2.f*f11+ f12+-2.f*f13+-    f14+ f15+ -2.f*f16+ f17+-2.f*f18  -(2.f*u*u-(v*v+w*w));
	m10 =-4.f*f1+ 2.f*f2+ -4.f*f3+ 2.f*f4+ f5+ f6+ f7+ f8+ 2.f*f9+ f10+ -2.f*f11+ f12+-2.f*f13+ 2.f*f14+ f15+ -2.f*f16+ f17+-2.f*f18;
	m11 =             f2         +     f4+ f5+ f6+ f7+ f8+-    f9+-f10          +-f12         +-    f14+-f15          +-f17         -(v*v-w*w);
	m12 =        -2.f*f2          -2.f*f4+ f5+ f6+ f7+ f8+ 2.f*f9+-f10          +-f12         + 2.f*f14+-f15          +-f17         ;
	m13 =                                  f5+-f6+ f7+-f8                                                                             -u*v;
	m14 =                                                                    f11     +-    f13              + -    f16     +     f18  -v*w;
	m15 =                                                          f10        + - f12                  +-f15          + f17           -u*w;  
	m16 =                                  f5+-f6+-f7+ f8         -f10        +   f12                  +-f15          + f17         ;  
	m17 =                                 -f5+-f6+ f7+ f8              +     f11     +-    f13              +      f16     +-    f18;  
	m18 =                                                          f10+-     f11+ f12+-    f13         +-f15+      f16+-f17+     f18;

	if(SmagLES == "YES"){
//		float PI11 = -0.026315789f*m1-0.5f *omega*m9;
//		float PI22 = -0.026315789f*m1+0.25f*omega*(m9-3.0f*m11);
//		float PI33 = -0.026315789f*m1+0.25f*omega*(m9+3.0f*m11);
//
//		float PI12 = -1.5f*omega*m13;
//		float PI23 = -1.5f*omega*m14;
//		float PI13 = -1.5f*omega*m15;
//		float Smag = sqrt(2.f*(PI11*PI11+PI22*PI22+PI33*PI33+2.f*PI12*PI12+2.f*PI23*PI23+2.f*PI13*PI13));
//		omega = 1.0f/(1.0f/omega+3.f*CS*Smag);

//		float PI11 = LRLEVEL*-1.0f/38.0f*(     (m1)+19.0f*omega* (m9));
//		float PI22 = LRLEVEL*-1.0f/76.0f*(2.0f*(m1)-19.0f*(omega*(m9)-3.0f*omega*(m11)));
//		float PI33 = LRLEVEL*-1.0f/76.0f*(2.0f*(m1)-19.0f*(omega*(m9)+3.0f*omega*(m11)));
//		float PI12 = LRLEVEL*-1.5f*omega*m13;
//		float PI23 = LRLEVEL*-1.5f*omega*m14;
//		float PI13 = LRLEVEL*-1.5f*omega*m15;
//		float nu0 = ((1.0f/omega)-0.5f)/3.0f;
//		float Smag = sqrt(PI11*PI11+PI22*PI22+PI33*PI33+PI12*PI12+PI23*PI23+PI13*PI13);
//		omega = 1.0f/(3.0f*(nu0+Cs*Smag*LRLEVEL*LRLEVEL)+0.5f);


//float feq0 = 0.1904761791f*rho+-0.597127747f*usqr                                                 ;
float feq1 = 0.1031746045f*rho+ 0.032375918f*usqr+  0.1666666667f*u                                                   ;
float feq2 = 0.1031746045f*rho+ 0.032375918f*usqr+  0.1666666667f*v                       ;
float feq3 = 0.1031746045f*rho+ 0.032375918f*usqr+ -0.1666666667f*u                                                   ;
float feq4 = 0.1031746045f*rho+ 0.032375918f*usqr+ -0.1666666667f*v                       ;
float feq5 = 0.0158730149f*rho+ 0.033572690f*usqr+  0.083333333f*( u+v)                            ;
float feq6 = 0.0158730149f*rho+ 0.033572690f*usqr+ -0.083333333f*( u-v)                            ;
float feq7 = 0.0158730149f*rho+ 0.033572690f*usqr+ -0.083333333f*( u+v)                            ;
float feq8 = 0.0158730149f*rho+ 0.033572690f*usqr+  0.083333333f*( u-v)                            ;
float feq9 = 0.1031746045f*rho+ 0.032375918f*usqr+  0.1666666667f*w;
float feq10= 0.0158730149f*rho+ 0.033572690f*usqr+  0.083333333f*( u+w)                                 ;
float feq11= 0.0158730149f*rho+ 0.033572690f*usqr+  0.083333333f*( v+w);
float feq12= 0.0158730149f*rho+ 0.033572690f*usqr+ -0.083333333f*( u-w)                            ;
float feq13= 0.0158730149f*rho+ 0.033572690f*usqr+ -0.083333333f*( v-w);
float feq14= 0.1031746045f*rho+ 0.032375918f*usqr+ -0.1666666667f*w;
float feq15= 0.0158730149f*rho+ 0.033572690f*usqr+  0.083333333f*(u-w)                            ;
float feq16= 0.0158730149f*rho+ 0.033572690f*usqr+  0.083333333f*(v-w);
float feq17= 0.0158730149f*rho+ 0.033572690f*usqr+ -0.083333333f*(u+w)                            ;
float feq18= 0.0158730149f*rho+ 0.033572690f*usqr+ -0.083333333f*(v+w);

feq1 +=  0.055555556f*(2.f*u*u-(v*v+w*w));
feq2 += -0.027777778f*(2.f*u*u-(v*v+w*w))+  0.083333333f*(v*v-w*w);
feq3 +=  0.055555556f*(2.f*u*u-(v*v+w*w));
feq4 += -0.027777778f*(2.f*u*u-(v*v+w*w))+  0.083333333f*(v*v-w*w);
feq5 +=  0.027777778f*(2.f*u*u-(v*v+w*w))+  0.083333333f*(v*v-w*w)+  0.25f*u*v                              ;
feq6 +=  0.027777778f*(2.f*u*u-(v*v+w*w))+  0.083333333f*(v*v-w*w)+ -0.25f*u*v                              ;
feq7 +=  0.027777778f*(2.f*u*u-(v*v+w*w))+  0.083333333f*(v*v-w*w)+  0.25f*u*v                              ;
feq8 +=  0.027777778f*(2.f*u*u-(v*v+w*w))+  0.083333333f*(v*v-w*w)+ -0.25f*u*v                              ;
feq9 += -0.027777778f*(2.f*u*u-(v*v+w*w))+ -0.083333333f*(v*v-w*w)                                            ;
feq10+=  0.027777778f*(2.f*u*u-(v*v+w*w))+ -0.083333333f*(v*v-w*w)                              +  0.25f*u*w;
feq11+= -0.055555556f*(2.f*u*u-(v*v+w*w))                                      +  0.25f*v*w             ;
feq12+=  0.027777778f*(2.f*u*u-(v*v+w*w))+ -0.083333333f*(v*v-w*w)                              + -0.25f*u*w;
feq13+= -0.055555556f*(2.f*u*u-(v*v+w*w))                                        -0.25f*v*w             ;
feq14+= -0.027777778f*(2.f*u*u-(v*v+w*w))+ -0.083333333f*(v*v-w*w)                                            ;
feq15+=  0.027777778f*(2.f*u*u-(v*v+w*w))+ -0.083333333f*(v*v-w*w)                              + -0.25f*u*w;
feq16+= -0.055555556f*(2.f*u*u-(v*v+w*w))                                      + -0.25f*v*w             ;
feq17+=  0.027777778f*(2.f*u*u-(v*v+w*w))+ -0.083333333f*(v*v-w*w)                              +  0.25f*u*w;
feq18+= -0.055555556f*(2.f*u*u-(v*v+w*w))                                      +  0.25f*v*w                 ;

float PI11 = (f1-feq1)+(f3-feq3)+(f5-feq5)+(f6-feq6)+(f7-feq7)+(f8-feq8)+(f10-feq10)+(f12-feq12)+(f15-feq15)+(f17-feq17);
float PI22 = (f2-feq2)+(f4-feq4)+(f5-feq5)+(f6-feq6)+(f7-feq7)+(f8-feq8)+(f11-feq11)+(f13-feq13)+(f16-feq16)+(f18-feq18);
float PI33 = (f9-feq9)+(f14-feq14)+(f10-feq10)+(f12-feq12)+(f15-feq15)+(f17-feq17)+(f11-feq11)+(f13-feq13)+(f16-feq16)+(f18-feq18);
float PI12 = (f5-feq5)+(f7-feq7)-(f6-feq6)-(f8-feq8);
float PI13 = (f10-feq10)+(f17-feq17)-(f12-feq12)-(f15-feq15);
float PI23 = (f11-feq11)+(f18-feq18)-(f13-feq13)-(f16-feq16);

//float Q = sqrt(PI11*PI11+PI22*PI22+PI33*PI33+2.f*PI12*PI12+2.f*PI23*PI23+2.f*PI13*PI13);
//float nu0 = ((1.0f/omega)-0.5f)/3.0f;
//
//float Smag = (sqrt(nu0*nu0+18.f*CS*Q)-nu0)/(6.f*CS);
//
////omega = 1.0f/(1.0f/omega+3.f*CS*Smag);
//
//float tau0 = 1.f/omega;
//float tau = 3.f*nu0+0.5f+(sqrt(tau0*tau0+18.f*CS*CS*Q)-tau0)*0.5f;
//omega = 1.f/tau;

float Q = sqrt(PI11*PI11+PI22*PI22+PI33*PI33+2.f*PI12*PI12+2.f*PI23*PI23+2.f*PI13*PI13);
//float nu0 = ((1.0f/omega)-0.5f)/3.0f;
float tau0 = 1.f/omega;

//float Smag = (sqrt(nu0*nu0+18.f*CS*LRFACTOR*LRFACTOR*Q)-nu0)/(6.f*CS*LRFACTOR*LRFACTOR);
//float Smag = (sqrt(4.f/9.f*tau0*tau0+8.f*CS*Q)-2.f/3.f*tau0)/(4.f*CS);

//omega = 1.0f/(3.0f*(nu0+CS*Smag)+0.5f);

float tau = tau0+0.5f*(-tau0+sqrt(tau0*tau0+18.f*sqrt(2.f)*CS*Q));
omega = 1.f/tau;




	}


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

inline __device__ void vel_av(float& f0, float& f1, float& f2,
					float& f3 , float& f4 , float& f5 ,
					float& f6 , float& f7 , float& f8 , float& f9,
					float& f10, float& f11, float& f12,
					float& f13, float& f14, float& f15,
					float& f16, float& f17, float& f18, float& uAv, float& vAv, int t)
{
	float u,v;//,w;	
	u = f1-f3+f5-f6-f7+f8+f10-f12+f15-f17;
	v = f2-f4+f5+f6-f7-f8+f11-f13+f16-f18;
    uAv = (uAv*(t-START_VELAV)+u)/((t-START_VELAV)+1);
    vAv = (vAv*(t-START_VELAV)+v)/((t-START_VELAV)+1);
}
inline __device__ void vel_avLR(float& f0, float& f1, float& f2,
					float& f3 , float& f4 , float& f5 ,
					float& f6 , float& f7 , float& f8 , float& f9,
					float& f10, float& f11, float& f12,
					float& f13, float& f14, float& f15,
					float& f16, float& f17, float& f18, float& uAv, float& vAv, float t)
{
	float u,v;//,w;	
	u = f1-f3+f5-f6-f7+f8+f10-f12+f15-f17;
	v = f2-f4+f5+f6-f7-f8+f11-f13+f16-f18;
    uAv = (uAv*(t-START_VELAV)+u*LRFACTOR)/((t-START_VELAV)+LRFACTOR);
    vAv = (vAv*(t-START_VELAV)+v*LRFACTOR)/((t-START_VELAV)+LRFACTOR);
}

inline __device__ void vel_fluc(float& f0, float& f1, float& f2,
					float& f3 , float& f4 , float& f5 ,
					float& f6 , float& f7 , float& f8 , float& f9,
					float& f10, float& f11, float& f12,
					float& f13, float& f14, float& f15,
					float& f16, float& f17, float& f18, float& uAv, 
                    float& vAv, float& ufluc, float& vfluc, int t)
{
	float u,v;//,w;	
	u = f1-f3+f5-f6-f7+f8+f10-f12+f15-f17;
	v = f2-f4+f5+f6-f7-f8+f11-f13+f16-f18;
    u = (u-uAv)*(u-uAv);
    v = (v-vAv)*(v-vAv);
    ufluc = (ufluc*(t-START_VELFLUC)+u)/((t-START_VELFLUC)+1);
    vfluc = (vfluc*(t-START_VELFLUC)+v)/((t-START_VELFLUC)+1);
}
inline __device__ void vel_flucLR(float& f0, float& f1, float& f2,
					float& f3 , float& f4 , float& f5 ,
					float& f6 , float& f7 , float& f8 , float& f9,
					float& f10, float& f11, float& f12,
					float& f13, float& f14, float& f15,
					float& f16, float& f17, float& f18, float& uAv, 
                    float& vAv, float& ufluc, float& vfluc, float t)
{
	float u,v;//,w;	
	u = f1-f3+f5-f6-f7+f8+f10-f12+f15-f17;
	v = f2-f4+f5+f6-f7-f8+f11-f13+f16-f18;
    u = (u-uAv)*(u-uAv);
    v = (v-vAv)*(v-vAv);
    ufluc = (ufluc*(t-START_VELFLUC)+u*LRFACTOR)/((t-START_VELFLUC)+LRFACTOR);
    vfluc = (vfluc*(t-START_VELFLUC)+v*LRFACTOR)/((t-START_VELFLUC)+LRFACTOR);
}

inline __device__ void bgk_scale_cf(float& f0, float& f1, float& f2,
					float& f3 , float& f4 , float& f5 ,
					float& f6 , float& f7 , float& f8 , float& f9,
					float& f10, float& f11, float& f12,
					float& f13, float& f14, float& f15,
					float& f16, float& f17, float& f18, float SF)
{
	float rho,u,v,w;	
	rho = f0+f1+f2+f3+f4+f5+f6+f7+f8+f9+
	      f10+f11+f12+f13+f14+f15+f16+f17+f18;
	u = f1-f3+f5-f6-f7+f8+f10-f12+f15-f17;
	v = f2-f4+f5+f6-f7-f8+f11-f13+f16-f18;
	w = f9+f10+f11+f12+f13-f14-f15-f16-f17-f18;
	float usqr = u*u+v*v+w*w;

    float feq0  = 0.3333333333f*(rho-1.5f*usqr);
    float feq1  = 0.0555555556f*(rho+3.0f*u+4.5f*u*u-1.5f*usqr);
    float feq2  = 0.0555555556f*(rho+3.0f*v+4.5f*v*v-1.5f*usqr);
    float feq3  = 0.0555555556f*(rho-3.0f*u+4.5f*u*u-1.5f*usqr);
    float feq4  = 0.0555555556f*(rho-3.0f*v+4.5f*v*v-1.5f*usqr);
    float feq5  = 0.0277777778f*(rho+3.0f*(u+v)+4.5f*(u+v)*(u+v)-1.5f*usqr);
    float feq6  = 0.0277777778f*(rho+3.0f*(-u+v)+4.5f*(-u+v)*(-u+v)-1.5f*usqr);
    float feq7  = 0.0277777778f*(rho+3.0f*(-u-v)+4.5f*(-u-v)*(-u-v)-1.5f*usqr);
    float feq8  = 0.0277777778f*(rho+3.0f*(u-v)+4.5f*(u-v)*(u-v)-1.5f*usqr);
    float feq9  = 0.0555555556f*(rho+3.0f*w+4.5f*w*w-1.5f*usqr);
    float feq10 = 0.0277777778f*(rho+3.0f*(u+w)+4.5f*(u+w)*(u+w)-1.5f*usqr);
    float feq11 = 0.0277777778f*(rho+3.0f*(v+w)+4.5f*(v+w)*(v+w)-1.5f*usqr);
    float feq12 = 0.0277777778f*(rho+3.0f*(-u+w)+4.5f*(-u+w)*(-u+w)-1.5f*usqr);
    float feq13 = 0.0277777778f*(rho+3.0f*(-v+w)+4.5f*(-v+w)*(-v+w)-1.5f*usqr);
    float feq14 = 0.0555555556f*(rho-3.0f*w+4.5f*w*w-1.5f*usqr);
    float feq15 = 0.0277777778f*(rho+3.0f*(u-w)+4.5f*(u-w)*(u-w)-1.5f*usqr);
    float feq16 = 0.0277777778f*(rho+3.0f*(v-w)+4.5f*(v-w)*(v-w)-1.5f*usqr);
    float feq17 = 0.0277777778f*(rho+3.0f*(-u-w)+4.5f*(-u-w)*(-u-w)-1.5f*usqr);
    float feq18 = 0.0277777778f*(rho+3.0f*(-v-w)+4.5f*(-v-w)*(-v-w)-1.5f*usqr);

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

}

inline __device__ void mrt_scale_cf(float& f0, float& f1, float& f2,
					float& f3 , float& f4 , float& f5 ,
					float& f6 , float& f7 , float& f8 , float& f9,
					float& f10, float& f11, float& f12,
					float& f13, float& f14, float& f15,
					float& f16, float& f17, float& f18, float SF)
{
	float rho,u,v,w;	
	rho = f0+f1+f2+f3+f4+f5+f6+f7+f8+f9+
	      f10+f11+f12+f13+f14+f15+f16+f17+f18;
	u = f1-f3+f5-f6-f7+f8+f10-f12+f15-f17;
	v = f2-f4+f5+f6-f7-f8+f11-f13+f16-f18;
	w = f9+f10+f11+f12+f13-f14-f15-f16-f17-f18;
	float usqr = u*u+v*v+w*w;
                                                                                                                
float feq0 = 0.1904761791f*rho+-0.597127747f*usqr                                                 ;
float feq1 = 0.1031746045f*rho+ 0.032375918f*usqr+  0.1666666667f*u                                                   ;
float feq2 = 0.1031746045f*rho+ 0.032375918f*usqr+  0.1666666667f*v                       ;
float feq3 = 0.1031746045f*rho+ 0.032375918f*usqr+ -0.1666666667f*u                                                   ;
float feq4 = 0.1031746045f*rho+ 0.032375918f*usqr+ -0.1666666667f*v                       ;
float feq5 = 0.0158730149f*rho+ 0.033572690f*usqr+  0.083333333f*( u+v)                            ;
float feq6 = 0.0158730149f*rho+ 0.033572690f*usqr+ -0.083333333f*( u-v)                            ;
float feq7 = 0.0158730149f*rho+ 0.033572690f*usqr+ -0.083333333f*( u+v)                            ;
float feq8 = 0.0158730149f*rho+ 0.033572690f*usqr+  0.083333333f*( u-v)                            ;
float feq9 = 0.1031746045f*rho+ 0.032375918f*usqr+  0.1666666667f*w;
float feq10= 0.0158730149f*rho+ 0.033572690f*usqr+  0.083333333f*( u+w)                                 ;
float feq11= 0.0158730149f*rho+ 0.033572690f*usqr+  0.083333333f*( v+w);
float feq12= 0.0158730149f*rho+ 0.033572690f*usqr+ -0.083333333f*( u-w)                            ;
float feq13= 0.0158730149f*rho+ 0.033572690f*usqr+ -0.083333333f*( v-w);
float feq14= 0.1031746045f*rho+ 0.032375918f*usqr+ -0.1666666667f*w;
float feq15= 0.0158730149f*rho+ 0.033572690f*usqr+  0.083333333f*(u-w)                            ;
float feq16= 0.0158730149f*rho+ 0.033572690f*usqr+  0.083333333f*(v-w);
float feq17= 0.0158730149f*rho+ 0.033572690f*usqr+ -0.083333333f*(u+w)                            ;
float feq18= 0.0158730149f*rho+ 0.033572690f*usqr+ -0.083333333f*(v+w);

feq1 +=  0.055555556f*(2.f*u*u-(v*v+w*w));
feq2 += -0.027777778f*(2.f*u*u-(v*v+w*w))+  0.083333333f*(v*v-w*w);
feq3 +=  0.055555556f*(2.f*u*u-(v*v+w*w));
feq4 += -0.027777778f*(2.f*u*u-(v*v+w*w))+  0.083333333f*(v*v-w*w);
feq5 +=  0.027777778f*(2.f*u*u-(v*v+w*w))+  0.083333333f*(v*v-w*w)+  0.25f*u*v                              ;
feq6 +=  0.027777778f*(2.f*u*u-(v*v+w*w))+  0.083333333f*(v*v-w*w)+ -0.25f*u*v                              ;
feq7 +=  0.027777778f*(2.f*u*u-(v*v+w*w))+  0.083333333f*(v*v-w*w)+  0.25f*u*v                              ;
feq8 +=  0.027777778f*(2.f*u*u-(v*v+w*w))+  0.083333333f*(v*v-w*w)+ -0.25f*u*v                              ;
feq9 += -0.027777778f*(2.f*u*u-(v*v+w*w))+ -0.083333333f*(v*v-w*w)                                            ;
feq10+=  0.027777778f*(2.f*u*u-(v*v+w*w))+ -0.083333333f*(v*v-w*w)                              +  0.25f*u*w;
feq11+= -0.055555556f*(2.f*u*u-(v*v+w*w))                                      +  0.25f*v*w             ;
feq12+=  0.027777778f*(2.f*u*u-(v*v+w*w))+ -0.083333333f*(v*v-w*w)                              + -0.25f*u*w;
feq13+= -0.055555556f*(2.f*u*u-(v*v+w*w))                                        -0.25f*v*w             ;
feq14+= -0.027777778f*(2.f*u*u-(v*v+w*w))+ -0.083333333f*(v*v-w*w)                                            ;
feq15+=  0.027777778f*(2.f*u*u-(v*v+w*w))+ -0.083333333f*(v*v-w*w)                              + -0.25f*u*w;
feq16+= -0.055555556f*(2.f*u*u-(v*v+w*w))                                      + -0.25f*v*w             ;
feq17+=  0.027777778f*(2.f*u*u-(v*v+w*w))+ -0.083333333f*(v*v-w*w)                              +  0.25f*u*w;
feq18+= -0.055555556f*(2.f*u*u-(v*v+w*w))                                      +  0.25f*v*w                 ;

//float m1  = 19.f*(-f0+ f5+f6+f7+f8+f10+f11+f12+f13+f15+f16+f17+f18)   -19.f*(u*u+v*v+w*w);
//float m2  = 12.f*f0+-4.f*f1+-4.f*f2+-4.f*f3+-4.f*f4+f5+f6+f7+f8+-4.f*f9+f10+f11+f12+f13+-4.f*f14+f15+f16+f17+f18 +7.53968254f*(u*u+v*v+w*w);
//float m4  = 1.666666667f*(-2.f*f1+2.f*f3+f5-f6-f7+f8+f10-f12+f15-f17);
//float m6  = 1.666666667f*(-2.f*f2+2.f*f4+f5+f6-f7-f8+f11-f13+f16-f18);
//float m8  = 1.666666667f*(-2.f*f9+f10+f11+f12+f13+2.f*f14-f15-f16-f17-f18);
//float m4  = 1.666666667f*(-3.f*f1+3.f*f3+u);
//float m6  = 1.666666667f*(-3.f*f2+3.f*f4+v);
//float m8  = 1.666666667f*(-3.f*f9+3.f*f14+w);
//float m9  = 2.f*f1+  -  f2+  2.f*f3+  -  f4+ f5+ f6+ f7+ f8+-    f9+ f10+ -2.f*f11+ f12+-2.f*f13+-    f14+ f15+ -2.f*f16+ f17+-2.f*f18  -(2.f*u*u-(v*v+w*w));
//float m10 =-4.f*f1+ 2.f*f2+ -4.f*f3+ 2.f*f4+ f5+ f6+ f7+ f8+ 2.f*f9+ f10+ -2.f*f11+ f12+-2.f*f13+ 2.f*f14+ f15+ -2.f*f16+ f17+-2.f*f18;
//float m11 =             f2         +     f4+ f5+ f6+ f7+ f8+-    f9+-f10          +-f12         +-    f14+-f15          +-f17         -(v*v-w*w);
//float m12 =        -2.f*f2          -2.f*f4+ f5+ f6+ f7+ f8+ 2.f*f9+-f10          +-f12         + 2.f*f14+-f15          +-f17         ;
//float m13 =                                  f5+-f6+ f7+-f8                                                                             -u*v;
//float m14 =                                                                    f11     +-    f13              + -    f16     +     f18  -v*w;
//float m15 =                                                          f10        + - f12                  +-f15          + f17           -u*w;  
//float m16 =                                  f5+-f6+-f7+ f8         -f10        +   f12                  +-f15          + f17         ;  
//float m17 =                                 -f5+-f6+ f7+ f8              +     f11     +-    f13              +      f16     +-    f18;  
//float m18 =                                                          f10+-     f11+ f12+-    f13         +-f15+      f16+-f17+     f18;





float m1  = 19.f*(-f0+ f5+f6+f7+f8+f10+f11+f12+f13+f15+f16+f17+f18   -(u*u+v*v+w*w));
float m9  = 2.f*f1+  -  f2+  2.f*f3+  -  f4+ f5+ f6+ f7+ f8+-    f9+ f10+ -2.f*f11+ f12+-2.f*f13+-    f14+ f15+ -2.f*f16+ f17+-2.f*f18  -(2.f*u*u-(v*v+w*w));
float m11 =             f2         +     f4+ f5+ f6+ f7+ f8+-    f9+-f10          +-f12         +-    f14+-f15          +-f17         -(v*v-w*w);
float m13 =                                  f5+-f6+ f7+-f8                                                                             -u*v;
float m14 =                                                                    f11     +-    f13              + -    f16     +     f18  -v*w;
float m15 =                                                          f10        + - f12                  +-f15          + f17           -u*w;

float omega = 1.0f/(3.0f*(UMAX*OBSTR1*2.f/RE)+0.5f);
float omega2 = 2.0f/(1.0f+2.0f*(2.0f/omega-1.0f));

float PI11 = -0.026315789f*m1-0.5f *omega*m9;
float PI22 = -0.026315789f*m1+0.25f*omega*(m9-3.0f*m11);
float PI33 = -0.026315789f*m1+0.25f*omega*(m9+3.0f*m11);
float PI12 = -1.5f*omega*m13;
float PI23 = -1.5f*omega*m14;
float PI13 = -1.5f*omega*m15;
//we know Smag on coarse mesh
float Smag = sqrt(2.f*(PI11*PI11+PI22*PI22+PI33*PI33+2.f*PI12*PI12+2.f*PI23*PI23+2.f*PI13*PI13));
//omega = 1.0f/(3.0f*(nu0+Cs*Smag*sqrt(2.f))+0.5f);
//omega  = 1.0f/(1.0f/omega+3.f*CS*Smag);
//omega2 = 1.0f/(1.0f/omega2+3.f*CS*Smag*sqrt(2.f)*LRFACTOR*LRFACTOR);
//omega  = 1.0f/(1.0f/omega +3.f*CS*Smag);
//omega2 = 1.0f/(1.0f/omega2+3.f*CS*Smag*sqrt(2.f)*LRFACTOR*LRFACTOR);
//omega  = 1.0f/(1.0f/omega +3.f*CS*Smag);
//omega2 = 1.0f/(1.0f*LRLEVEL/omega2-1.f+0.5f+3.f*CS*Smag*sqrt(2.f)*LRFACTOR);

//float PI11 = (f1-feq1)+(f3-feq3)+(f5-feq5)+(f6-feq6)+(f7-feq7)+(f8-feq8)+(f10-feq10)+(f12-feq12)+(f15-feq15)+(f17-feq17);
//float PI22 = (f2-feq2)+(f4-feq4)+(f5-feq5)+(f6-feq6)+(f7-feq7)+(f8-feq8)+(f11-feq11)+(f13-feq13)+(f16-feq16)+(f18-feq18);
//float PI33 = (f9-feq9)+(f14-feq14)+(f10-feq10)+(f12-feq12)+(f15-feq15)+(f17-feq17)+(f11-feq11)+(f13-feq13)+(f16-feq16)+(f18-feq18);
//float PI12 = (f5-feq5)+(f7-feq7)-(f6-feq6)-(f8-feq8);
//float PI13 = (f10-feq10)+(f17-feq17)-(f12-feq12)-(f15-feq15);
//float PI23 = (f11-feq11)+(f18-feq18)-(f13-feq13)-(f16-feq16);
//
//float Q = sqrt(PI11*PI11+PI22*PI22+PI33*PI33+2.f*PI12*PI12+2.f*PI23*PI23+2.f*PI13*PI13);
//float nu0 = ((1.0f/omega)-0.5f)/3.0f;
//float tau0c = 1.f/omega;
//float tau = tau0c+0.5*(-tau0c+sqrt(tau0c*tau0c+18.f*CS*Q));//tau_total of coarse mesh
//omega = 1.f/tau;//total omega on coarse mesh
//tau = tau0+0.5*(-tau0+sqrt(tau0*tau0+18.f*CS*LRFACTOR*Q));
//omega2= 1.f/tau;

SF = (omega*(1.0f-omega2))/((1.0f-omega)*omega2/LRFACTOR);//for post-collision 
//SF = omega*0.5f/omega2;//for post-streaming, pre-collision?





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

}
inline __device__ void mrt_scale_fc_LES(float& f0, float& f1, float& f2,
					float& f3 , float& f4 , float& f5 ,
					float& f6 , float& f7 , float& f8 , float& f9,
					float& f10, float& f11, float& f12,
					float& f13, float& f14, float& f15,
					float& f16, float& f17, float& f18, float omega, float omega2)
{
	float rho,u,v,w;	
	rho = f0+f1+f2+f3+f4+f5+f6+f7+f8+f9+
	      f10+f11+f12+f13+f14+f15+f16+f17+f18;
	u = f1-f3+f5-f6-f7+f8+f10-f12+f15-f17;
	v = f2-f4+f5+f6-f7-f8+f11-f13+f16-f18;
	w = f9+f10+f11+f12+f13-f14-f15-f16-f17-f18;
	float usqr = u*u+v*v+w*w;
                                                                                                                
float feq0 = 0.1904761791f*rho+-0.597127747f*usqr                                                 ;
float feq1 = 0.1031746045f*rho+ 0.032375918f*usqr+  0.1666666667f*u                                                   ;
float feq2 = 0.1031746045f*rho+ 0.032375918f*usqr+  0.1666666667f*v                       ;
float feq3 = 0.1031746045f*rho+ 0.032375918f*usqr+ -0.1666666667f*u                                                   ;
float feq4 = 0.1031746045f*rho+ 0.032375918f*usqr+ -0.1666666667f*v                       ;
float feq5 = 0.0158730149f*rho+ 0.033572690f*usqr+  0.083333333f*( u+v)                            ;
float feq6 = 0.0158730149f*rho+ 0.033572690f*usqr+ -0.083333333f*( u-v)                            ;
float feq7 = 0.0158730149f*rho+ 0.033572690f*usqr+ -0.083333333f*( u+v)                            ;
float feq8 = 0.0158730149f*rho+ 0.033572690f*usqr+  0.083333333f*( u-v)                            ;
float feq9 = 0.1031746045f*rho+ 0.032375918f*usqr+  0.1666666667f*w;
float feq10= 0.0158730149f*rho+ 0.033572690f*usqr+  0.083333333f*( u+w)                                 ;
float feq11= 0.0158730149f*rho+ 0.033572690f*usqr+  0.083333333f*( v+w);
float feq12= 0.0158730149f*rho+ 0.033572690f*usqr+ -0.083333333f*( u-w)                            ;
float feq13= 0.0158730149f*rho+ 0.033572690f*usqr+ -0.083333333f*( v-w);
float feq14= 0.1031746045f*rho+ 0.032375918f*usqr+ -0.1666666667f*w;
float feq15= 0.0158730149f*rho+ 0.033572690f*usqr+  0.083333333f*(u-w)                            ;
float feq16= 0.0158730149f*rho+ 0.033572690f*usqr+  0.083333333f*(v-w);
float feq17= 0.0158730149f*rho+ 0.033572690f*usqr+ -0.083333333f*(u+w)                            ;
float feq18= 0.0158730149f*rho+ 0.033572690f*usqr+ -0.083333333f*(v+w);

feq1 +=  0.055555556f*(2.f*u*u-(v*v+w*w));
feq2 += -0.027777778f*(2.f*u*u-(v*v+w*w))+  0.083333333f*(v*v-w*w);
feq3 +=  0.055555556f*(2.f*u*u-(v*v+w*w));
feq4 += -0.027777778f*(2.f*u*u-(v*v+w*w))+  0.083333333f*(v*v-w*w);
feq5 +=  0.027777778f*(2.f*u*u-(v*v+w*w))+  0.083333333f*(v*v-w*w)+  0.25f*u*v                              ;
feq6 +=  0.027777778f*(2.f*u*u-(v*v+w*w))+  0.083333333f*(v*v-w*w)+ -0.25f*u*v                              ;
feq7 +=  0.027777778f*(2.f*u*u-(v*v+w*w))+  0.083333333f*(v*v-w*w)+  0.25f*u*v                              ;
feq8 +=  0.027777778f*(2.f*u*u-(v*v+w*w))+  0.083333333f*(v*v-w*w)+ -0.25f*u*v                              ;
feq9 += -0.027777778f*(2.f*u*u-(v*v+w*w))+ -0.083333333f*(v*v-w*w)                                            ;
feq10+=  0.027777778f*(2.f*u*u-(v*v+w*w))+ -0.083333333f*(v*v-w*w)                              +  0.25f*u*w;
feq11+= -0.055555556f*(2.f*u*u-(v*v+w*w))                                      +  0.25f*v*w             ;
feq12+=  0.027777778f*(2.f*u*u-(v*v+w*w))+ -0.083333333f*(v*v-w*w)                              + -0.25f*u*w;
feq13+= -0.055555556f*(2.f*u*u-(v*v+w*w))                                        -0.25f*v*w             ;
feq14+= -0.027777778f*(2.f*u*u-(v*v+w*w))+ -0.083333333f*(v*v-w*w)                                            ;
feq15+=  0.027777778f*(2.f*u*u-(v*v+w*w))+ -0.083333333f*(v*v-w*w)                              + -0.25f*u*w;
feq16+= -0.055555556f*(2.f*u*u-(v*v+w*w))                                      + -0.25f*v*w             ;
feq17+=  0.027777778f*(2.f*u*u-(v*v+w*w))+ -0.083333333f*(v*v-w*w)                              +  0.25f*u*w;
feq18+= -0.055555556f*(2.f*u*u-(v*v+w*w))                                      +  0.25f*v*w                 ;

//float m1  = 19.f*(-f0+ f5+f6+f7+f8+f10+f11+f12+f13+f15+f16+f17+f18   -(u*u+v*v+w*w));
//float m9  = 2.f*f1+  -  f2+  2.f*f3+  -  f4+ f5+ f6+ f7+ f8+-    f9+ f10+ -2.f*f11+ f12+-2.f*f13+-    f14+ f15+ -2.f*f16+ f17+-2.f*f18  -(2.f*u*u-(v*v+w*w));
//float m11 =             f2         +     f4+ f5+ f6+ f7+ f8+-    f9+-f10          +-f12         +-    f14+-f15          +-f17         -(v*v-w*w);
//float m13 =                                  f5+-f6+ f7+-f8                                                                             -u*v;
//float m14 =                                                                    f11     +-    f13              + -    f16     +     f18  -v*w;
//float m15 =                                                          f10        + - f12                  +-f15          + f17           -u*w;

//float PI11 = -0.026315789f*m1-0.5f *omega*m9;
//float PI22 = -0.026315789f*m1+0.25f*omega*(m9-3.0f*m11);
//float PI33 = -0.026315789f*m1+0.25f*omega*(m9+3.0f*m11);
//float PI12 = -1.5f*omega*m13;
//float PI23 = -1.5f*omega*m14;
//float PI13 = -1.5f*omega*m15;
////we know Smag on fine mesh. Smag_c=Smag_f*sqrt(2)
//float Smag = sqrt(2.f*(PI11*PI11+PI22*PI22+PI33*PI33+2.f*PI12*PI12+2.f*PI23*PI23+2.f*PI13*PI13));
//float nu0 = ((1.0f/omega)-0.5f)/3.0f;
////omega = 1.0f/(3.0f*(nu0+CS*Smag*sqrt(2.f))+0.5f);
////omega2 = 1.0f/(1.0f/omega2+3.f*CS*Smag*LRFACTOR);
////omega  = 1.0f/(1.0f/omega+3.f*CS*Smag/sqrt(2.f));
////omega2 = 1.0f/(1.0f*LRLEVEL/omega2-1.f+0.5f+3.f*CS*Smag*LRFACTOR);
////omega  = 1.0f/(1.0f/omega+3.f*CS*Smag/sqrt(2.f));

//float PI11 = (f1-feq1)+(f3-feq3)+(f5-feq5)+(f6-feq6)+(f7-feq7)+(f8-feq8)+(f10-feq10)+(f12-feq12)+(f15-feq15)+(f17-feq17);
//float PI22 = (f2-feq2)+(f4-feq4)+(f5-feq5)+(f6-feq6)+(f7-feq7)+(f8-feq8)+(f11-feq11)+(f13-feq13)+(f16-feq16)+(f18-feq18);
//float PI33 = (f9-feq9)+(f14-feq14)+(f10-feq10)+(f12-feq12)+(f15-feq15)+(f17-feq17)+(f11-feq11)+(f13-feq13)+(f16-feq16)+(f18-feq18);
//float PI12 = (f5-feq5)+(f7-feq7)-(f6-feq6)-(f8-feq8);
//float PI13 = (f10-feq10)+(f17-feq17)-(f12-feq12)-(f15-feq15);
//float PI23 = (f11-feq11)+(f18-feq18)-(f13-feq13)-(f16-feq16);
//
//float Q = sqrt(PI11*PI11+PI22*PI22+PI33*PI33+2.f*PI12*PI12+2.f*PI23*PI23+2.f*PI13*PI13);
//float nu0 = ((1.0f/omega)-0.5f)/3.0f;
//float tau0f = 1.f/omega2;
//float tau0c = 1.f/omega;
//float tau = tau0f+0.5*(-tau0f+sqrt(tau0f*tau0f+18.f*CS*sqrt(2.f)*Q));//tau_total of fine
//omega2 = 1.f/tau;//total omega on fine mesh
//tau = LRLEVEL*(tau-tau0f)+tau0c;
//omega= 1.f/tau;

//tau = tau0+0.5*(-tau0+sqrt(tau0*tau0+18.f*CS*Q));

float SF = (omega*(1.0f-omega2))/((1.0f-omega)*omega2/LRFACTOR);
//float SF = omega2*2.f/omega;



//float SF = ((1.0f-omega)*omega2/LRFACTOR)/(omega*(1.0f-omega2));
//SF = omega*2.f/omega2;

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
__device__ int dmin_p(int a, int b)
{
	if (a<b) return a;
	else return 0;
}
__device__ int dmax_p(int a, int b)
{
	if (a>-1) return a;
	else return b-1;
}

__global__ void simple_copy(float* fA, float* fB,
							size_t pitch)//pitch in elements
{
	int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
	int y = threadIdx.y+blockIdx.y*blockDim.y;
	int z = threadIdx.z+blockIdx.z*blockDim.z;
	int j = x+y*pitch+z*YDIM*pitch;//index on padded mem (pitch in elements)
	int k = dmin(x+1,XDIM)+y*pitch+z*YDIM*pitch;//index on padded mem (pitch in elements)

	fB[j] = fA[k];//+0.01f;
}
__global__ void simple_text(float* fA, float* fB,
							size_t pitch)//pitch in elements
{
	int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
	int y = threadIdx.y+blockIdx.y*blockDim.y;
	int z = threadIdx.z+blockIdx.z*blockDim.z;
	int j = x+y*pitch+z*YDIM*pitch;//index on padded mem (pitch in elements)
	fB[j] = tex2D(texRef_f0A,x+1,y);//+0.01f;
}

__global__ void ExtractFromC_d(float* fout,
							size_t pitch, float omega, float omega2)//pitch in elements
							//size_t pitch, float SF)//pitch in elements
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
//	if( (x > LRX0+1 && x < LRX0+XLRDIM*LRFACTOR-1 && y > LRY0+1 && y < LRY0+YLRDIM*LRFACTOR-1 && z > LRZ0+1 && z < LRZ0+ZLRDIM*LRFACTOR-1) && 
//	(x == int(LRX0+2) || x == int(LRX0+XLRDIM*LRFACTOR-1) || y == int(LRY0+2) || y == int(LRY0+YLRDIM*LRFACTOR-1) || z == int(LRZ0+2) || z == int(LRY0+ZLRDIM*LRFACTOR-1)) )
	//if( (x > LRX0+3 && x < LRX0+XLRDIM*LRFACTOR-3 && y > LRY0+3 && y < LRY0+YLRDIM*LRFACTOR-3))// && 
	if( (x > LRX0+1 && x < LRX0+XLRDIM*LRFACTOR-1 && y > LRY0+1 && y < LRY0+YLRDIM*LRFACTOR-1))// && 
	//(x == int(LRX0+2) || x == int(LRX0+XLRDIM*LRFACTOR-1) || y == int(LRY0+2) || y == int(LRY0+YLRDIM*LRFACTOR-1)) )
	{
//	if(x > 10 && y > 10 && z > 10 && x < 20 && y < 20 && z < 20)
//	{
	float xcoord = LRLEVEL*(x-LRX0)+0.5f;
	float ycoord = LRLEVEL*(y-LRY0)+0.5f;
	float zcoord = LRLEVEL*(z-LRZ0);
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

	if(MODEL == "MRT")
	mrt_scale_fc_LES(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,omega,omega2);
	//mrt_scale_cf(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,SF);
//    else
//	bgk_scale_cf(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,SF);

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

__global__ void LR_d_ABCD_force(float* fin, float* fout,
							float omega, size_t pitch, float *FX, float *FY, float *FZ, int t,
                            float *uAv, float *vAv, float *ufluc, float *vfluc)//pitch in elements
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
    float u_Av, v_Av, u_fluc, v_fluc;
	__shared__ float sumX[BLOCKSIZEX], sumY[BLOCKSIZEX], sumZ[BLOCKSIZEX];
	__shared__ int check[1];
	check[0] = 0;
	syncthreads();
//	if(x < 1 || x > XLRDIM-2 || y < 1 || y > YLRDIM-2 || z < 1 || z > ZLRDIM-2)
//	{
//	//dont do anything
//		sumX[threadIdx.x]=0.f;
//		sumY[threadIdx.x]=0.f;
//		sumZ[threadIdx.x]=0.f;
//	}
//	else{
	f0 = fin[j];
	f1 = fin[f_memLR(1 ,x-1,y       ,z             ,pitch)];
	f3 = fin[f_memLR(3 ,x+1,y       ,z             ,pitch)];
	f2 = fin[f_memLR(2 ,x  ,y-1,z             ,pitch)];
	f5 = fin[f_memLR(5 ,x-1,y-1,z             ,pitch)];
	f6 = fin[f_memLR(6 ,x+1,y-1,z             ,pitch)];
	f4 = fin[f_memLR(4 ,x  ,y+1,z             ,pitch)];
	f7 = fin[f_memLR(7 ,x+1,y+1,z             ,pitch)];
	f8 = fin[f_memLR(8 ,x-1,y+1,z             ,pitch)];
    if(z != 0){
	f9 = fin[f_memLR(9 ,x  ,y  ,z-1,pitch)];
	f10= fin[f_memLR(10,x-1,y  ,z-1,pitch)];
	f11= fin[f_memLR(11,x  ,y-1,z-1,pitch)];
	f12= fin[f_memLR(12,x+1,y  ,z-1,pitch)];
	f13= fin[f_memLR(13,x  ,y+1,z-1,pitch)];
    }
    else{
	f9 = fin[f_memLR(9 ,x                 ,y                 ,ZLRDIM-1,pitch)];
	f10= fin[f_memLR(10,dmax_p(x-1,XLRDIM),y                 ,ZLRDIM-1,pitch)];
	f11= fin[f_memLR(11,x                 ,dmax_p(y-1,YLRDIM),ZLRDIM-1,pitch)];
	f12= fin[f_memLR(12,dmin_p(x+1,XLRDIM),y                 ,ZLRDIM-1,pitch)];
	f13= fin[f_memLR(13,x                 ,dmin_p(y+1,YLRDIM),ZLRDIM-1,pitch)];
    }
    if(z != ZLRDIM-1){
	f14= fin[f_memLR(14,x  ,y  ,z+1,pitch)];
	f15= fin[f_memLR(15,x-1,y  ,z+1,pitch)];
	f16= fin[f_memLR(16,x  ,y-1,z+1,pitch)];
	f17= fin[f_memLR(17,x+1,y  ,z+1,pitch)];
	f18= fin[f_memLR(18,x  ,y+1,z+1,pitch)];
    }
    else{
	f14= fin[f_memLR(14,x                 ,y                 ,0  ,pitch)];
	f15= fin[f_memLR(15,dmax_p(x-1,XLRDIM),y                 ,0  ,pitch)];
	f16= fin[f_memLR(16,x                 ,dmax_p(y-1,YLRDIM),0  ,pitch)];
	f17= fin[f_memLR(17,dmin_p(x+1,XLRDIM),y                 ,0  ,pitch)];
	f18= fin[f_memLR(18,x                 ,dmin_p(y+1,YLRDIM),0  ,pitch)];    
    }

    if(im == 1 || im ==10){//BB
		if(im == 10){
		check[0] = 1;
		//sumX[threadIdx.x]=2.f*f1-2.f*f3+2.f*f5+2.f*f8-2.f*f6-2.f*f7+2.f*f10-2.f*f12+2.f*f15-2.f*f17;
		//sumY[threadIdx.x]=2.f*f2-2.f*f4+2.f*f5-2.f*f8+2.f*f6-2.f*f7+2.f*f11-2.f*f13+2.f*f16-2.f*f18;
		//sumZ[threadIdx.x]=2.f*f9+2.f*f10+2.f*f11+2.f*f12+2.f*f13-2.f*f14-2.f*f15-2.f*f16-2.f*f17-2.f*f18;
		sumX[threadIdx.x]=2.f*f1-2.f*f3+2.f*f5+2.f*f8-2.f*f6;//-2.f*f7+2.f*f10-2.f*f12+2.f*f15-2.f*f17;
		sumX[threadIdx.x]+=-2.f*f7+2.f*f10-2.f*f12+2.f*f15-2.f*f17;
		sumY[threadIdx.x]=2.f*f2-2.f*f4+2.f*f5-2.f*f8+2.f*f6;//-2.f*f7+2.f*f11-2.f*f13+2.f*f16-2.f*f18;
		sumY[threadIdx.x]+=-2.f*f7+2.f*f11-2.f*f13+2.f*f16-2.f*f18;
		sumZ[threadIdx.x]=2.f*f9+2.f*f10+2.f*f11+2.f*f12+2.f*f13;//-2.f*f14-2.f*f15-2.f*f16-2.f*f17-2.f*f18;
		sumZ[threadIdx.x]+=-2.f*f14-2.f*f15-2.f*f16-2.f*f17-2.f*f18;
		}
		else{
		sumX[threadIdx.x]=0.f;
		sumY[threadIdx.x]=0.f;
		sumZ[threadIdx.x]=0.f;
		}
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
		sumX[threadIdx.x]=0.f;
		sumY[threadIdx.x]=0.f;
		sumZ[threadIdx.x]=0.f;

		boundaries(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,y,z,im);


		if(MODEL == "MRT")
		mrt_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,omega);
		else if(MODEL == "BGK")
		bgk_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,omega);

        if(VELAV == "YES"){
            if(t>=START_VELAV && t<START_VELFLUC){
                u_Av = uAv[j];
                v_Av = vAv[j];
        		vel_avLR(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,u_Av,v_Av,t);
                uAv[j] = u_Av;
                vAv[j] = v_Av;
            }
            else if(t>=START_VELFLUC){
                u_Av = uAv[j];
                v_Av = vAv[j];
                u_fluc = ufluc[j];
                v_fluc = vfluc[j];
        		vel_flucLR(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,u_Av,v_Av,u_fluc,v_fluc,t);
                ufluc[j] = u_fluc;
                vfluc[j] = v_fluc;
            }
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

//	}//end else (not at edge of LR)
	syncthreads();
	if(check[0] == 1 && t>=STARTF){
	//reduction for force
	int nTotalThreads = blockDim.x;
	while(nTotalThreads > 1){
		int halfPoint = (nTotalThreads >> 1);
		if(threadIdx.x < halfPoint){
			sumX[threadIdx.x] += sumX[threadIdx.x+halfPoint];
			sumY[threadIdx.x] += sumY[threadIdx.x+halfPoint];
			sumZ[threadIdx.x] += sumZ[threadIdx.x+halfPoint];
		}
		syncthreads();
		nTotalThreads = halfPoint;
	}
	if(threadIdx.x == 0){
		atomicAdd(&FX[t],sumX[0]);
		atomicAdd(&FY[t],sumY[0]);
		atomicAdd(&FZ[t],sumZ[0]);
	}
	}

}
__global__ void LR_d_BACD_force(float* fin, float* fout,
							float omega, size_t pitch, float *FX, float *FY, float *FZ,
                            int t,float *uAv, float *vAv, float *ufluc, float *vfluc)
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
	__shared__ float sumX[BLOCKSIZEX], sumY[BLOCKSIZEX], sumZ[BLOCKSIZEX];
	__shared__ int check[1];
	check[0] = 0;
	syncthreads();
//	if(x < 1 || x > XLRDIM-2 || y < 1 || y > YLRDIM-2 || z < 1 || z > ZLRDIM-2)
//	{
//	//dont do anything
//		sumX[threadIdx.x]=0.f;
//		sumY[threadIdx.x]=0.f;
//		sumZ[threadIdx.x]=0.f;
//	}
//	else{
	f0 = fin[j];
	f1 = fin[f_memLR(1 ,x-1,y       ,z             ,pitch)];
	f3 = fin[f_memLR(3 ,x+1,y       ,z             ,pitch)];
	f2 = fin[f_memLR(2 ,x  ,y-1,z             ,pitch)];
	f5 = fin[f_memLR(5 ,x-1,y-1,z             ,pitch)];
	f6 = fin[f_memLR(6 ,x+1,y-1,z             ,pitch)];
	f4 = fin[f_memLR(4 ,x  ,y+1,z             ,pitch)];
	f7 = fin[f_memLR(7 ,x+1,y+1,z             ,pitch)];
	f8 = fin[f_memLR(8 ,x-1,y+1,z             ,pitch)];
    if(z != 0){
	f9 = fin[f_memLR(9 ,x  ,y  ,z-1,pitch)];
	f10= fin[f_memLR(10,x-1,y  ,z-1,pitch)];
	f11= fin[f_memLR(11,x  ,y-1,z-1,pitch)];
	f12= fin[f_memLR(12,x+1,y  ,z-1,pitch)];
	f13= fin[f_memLR(13,x  ,y+1,z-1,pitch)];
    }
    else{
	f9 = fin[f_memLR(9 ,x                 ,y                 ,ZLRDIM-1,pitch)];
	f10= fin[f_memLR(10,dmax_p(x-1,XLRDIM),y                 ,ZLRDIM-1,pitch)];
	f11= fin[f_memLR(11,x                 ,dmax_p(y-1,YLRDIM),ZLRDIM-1,pitch)];
	f12= fin[f_memLR(12,dmin_p(x+1,XLRDIM),y                 ,ZLRDIM-1,pitch)];
	f13= fin[f_memLR(13,x                 ,dmin_p(y+1,YLRDIM),ZLRDIM-1,pitch)];
    }
    if(z != ZLRDIM-1){
	f14= fin[f_memLR(14,x  ,y  ,z+1,pitch)];
	f15= fin[f_memLR(15,x-1,y  ,z+1,pitch)];
	f16= fin[f_memLR(16,x  ,y-1,z+1,pitch)];
	f17= fin[f_memLR(17,x+1,y  ,z+1,pitch)];
	f18= fin[f_memLR(18,x  ,y+1,z+1,pitch)];
    }
    else{
	f14= fin[f_memLR(14,x                 ,y                 ,0  ,pitch)];
	f15= fin[f_memLR(15,dmax_p(x-1,XLRDIM),y                 ,0  ,pitch)];
	f16= fin[f_memLR(16,x                 ,dmax_p(y-1,YLRDIM),0  ,pitch)];
	f17= fin[f_memLR(17,dmin_p(x+1,XLRDIM),y                 ,0  ,pitch)];
	f18= fin[f_memLR(18,x                 ,dmin_p(y+1,YLRDIM),0  ,pitch)];    
    }

    if(im == 1 || im ==10){//BB
		if(im == 10){
		check[0] = 1;
		//sumX[threadIdx.x]=2.f*f1-2.f*f3+2.f*f5+2.f*f8-2.f*f6-2.f*f7+2.f*f10-2.f*f12+2.f*f15-2.f*f17;
		//sumY[threadIdx.x]=2.f*f2-2.f*f4+2.f*f5-2.f*f8+2.f*f6-2.f*f7+2.f*f11-2.f*f13+2.f*f16-2.f*f18;
		//sumZ[threadIdx.x]=2.f*f9+2.f*f10+2.f*f11+2.f*f12+2.f*f13-2.f*f14-2.f*f15-2.f*f16-2.f*f17-2.f*f18;
		sumX[threadIdx.x]=2.f*f1-2.f*f3+2.f*f5+2.f*f8-2.f*f6;//-2.f*f7+2.f*f10-2.f*f12+2.f*f15-2.f*f17;
		sumX[threadIdx.x]+=-2.f*f7+2.f*f10-2.f*f12+2.f*f15-2.f*f17;
		sumY[threadIdx.x]=2.f*f2-2.f*f4+2.f*f5-2.f*f8+2.f*f6;//-2.f*f7+2.f*f11-2.f*f13+2.f*f16-2.f*f18;
		sumY[threadIdx.x]+=-2.f*f7+2.f*f11-2.f*f13+2.f*f16-2.f*f18;
		sumZ[threadIdx.x]=2.f*f9+2.f*f10+2.f*f11+2.f*f12+2.f*f13;//-2.f*f14-2.f*f15-2.f*f16-2.f*f17-2.f*f18;
		sumZ[threadIdx.x]+=-2.f*f14-2.f*f15-2.f*f16-2.f*f17-2.f*f18;
		}
		else{
		sumX[threadIdx.x]=0.f;
		sumY[threadIdx.x]=0.f;
		sumZ[threadIdx.x]=0.f;
		}
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
		sumX[threadIdx.x]=0.f;
		sumY[threadIdx.x]=0.f;
		sumZ[threadIdx.x]=0.f;

		boundaries(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,y,z,im);


		if(MODEL == "MRT")
		mrt_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,omega);
		else if(MODEL == "BGK")
		bgk_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,omega);

        if(VELAV == "YES"){
        float u_Av, v_Av, u_fluc, v_fluc;
            if(t>=START_VELAV && t<START_VELFLUC){
                u_Av = uAv[j];
                v_Av = vAv[j];
        		vel_avLR(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,u_Av,v_Av,t);
                uAv[j] = u_Av;
                vAv[j] = v_Av;
            }
            else if(t>=START_VELFLUC){
                u_Av = uAv[j];
                v_Av = vAv[j];
                u_fluc = ufluc[j];
                v_fluc = vfluc[j];
        		vel_flucLR(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,u_Av,v_Av,u_fluc,v_fluc,t);
                ufluc[j] = u_fluc;
                vfluc[j] = v_fluc;
            }
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

//	}//end else (not at edge of LR)
	syncthreads();
	if(check[0] == 1 && t>=STARTF){
	//reduction for force
	int nTotalThreads = blockDim.x;
	while(nTotalThreads > 1){
		int halfPoint = (nTotalThreads >> 1);
		if(threadIdx.x < halfPoint){
			sumX[threadIdx.x] += sumX[threadIdx.x+halfPoint];
			sumY[threadIdx.x] += sumY[threadIdx.x+halfPoint];
			sumZ[threadIdx.x] += sumZ[threadIdx.x+halfPoint];
		}
		syncthreads();
		nTotalThreads = halfPoint;
	}
	if(threadIdx.x == 0){
		atomicAdd(&FX[t],sumX[0]);
		atomicAdd(&FY[t],sumY[0]);
		atomicAdd(&FZ[t],sumZ[0]);
	}
	}

}


__global__ void LR_d_ABCD2(float* fin, float* fout,
							float omega, size_t pitch, int n, int t,//pitch in elements
                            float *uAv, float *vAv, float *ufluc, float *vfluc)//pitch in elements
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
    float u_Av, v_Av, u_fluc, v_fluc;
//	if(x < n || x > XLRDIM-1-n || y < n || y > YLRDIM-1-n || z < n || z > ZLRDIM-1-n)
//	{
//	//dont do anything
//	}
//	else{
	f0 = fin[j];
	f1 = fin[f_memLR(1 ,x-1,y       ,z             ,pitch)];
	f3 = fin[f_memLR(3 ,x+1,y       ,z             ,pitch)];
	f2 = fin[f_memLR(2 ,x  ,y-1,z             ,pitch)];
	f5 = fin[f_memLR(5 ,x-1,y-1,z             ,pitch)];
	f6 = fin[f_memLR(6 ,x+1,y-1,z             ,pitch)];
	f4 = fin[f_memLR(4 ,x  ,y+1,z             ,pitch)];
	f7 = fin[f_memLR(7 ,x+1,y+1,z             ,pitch)];
	f8 = fin[f_memLR(8 ,x-1,y+1,z             ,pitch)];
    if(z != 0){
	f9 = fin[f_memLR(9 ,x  ,y  ,z-1,pitch)];
	f10= fin[f_memLR(10,x-1,y  ,z-1,pitch)];
	f11= fin[f_memLR(11,x  ,y-1,z-1,pitch)];
	f12= fin[f_memLR(12,x+1,y  ,z-1,pitch)];
	f13= fin[f_memLR(13,x  ,y+1,z-1,pitch)];
    }
    else{
	f9 = fin[f_memLR(9 ,x                 ,y                 ,ZLRDIM-1,pitch)];
	f10= fin[f_memLR(10,dmax_p(x-1,XLRDIM),y                 ,ZLRDIM-1,pitch)];
	f11= fin[f_memLR(11,x                 ,dmax_p(y-1,YLRDIM),ZLRDIM-1,pitch)];
	f12= fin[f_memLR(12,dmin_p(x+1,XLRDIM),y                 ,ZLRDIM-1,pitch)];
	f13= fin[f_memLR(13,x                 ,dmin_p(y+1,YLRDIM),ZLRDIM-1,pitch)];
    }
    if(z != ZLRDIM-1){
	f14= fin[f_memLR(14,x  ,y  ,z+1,pitch)];
	f15= fin[f_memLR(15,x-1,y  ,z+1,pitch)];
	f16= fin[f_memLR(16,x  ,y-1,z+1,pitch)];
	f17= fin[f_memLR(17,x+1,y  ,z+1,pitch)];
	f18= fin[f_memLR(18,x  ,y+1,z+1,pitch)];
    }
    else{
	f14= fin[f_memLR(14,x                 ,y                 ,0  ,pitch)];
	f15= fin[f_memLR(15,dmax_p(x-1,XLRDIM),y                 ,0  ,pitch)];
	f16= fin[f_memLR(16,x                 ,dmax_p(y-1,YLRDIM),0  ,pitch)];
	f17= fin[f_memLR(17,dmin_p(x+1,XLRDIM),y                 ,0  ,pitch)];
	f18= fin[f_memLR(18,x                 ,dmin_p(y+1,YLRDIM),0  ,pitch)];    
    }

	if(im == 1 || im ==10){//BB
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

        if(VELAV == "YES"){
            if(t>=START_VELAV && t<START_VELFLUC){
                u_Av = uAv[j];
                v_Av = vAv[j];
        		vel_avLR(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,u_Av,v_Av,t+LRFACTOR*n);
                uAv[j] = u_Av;
                vAv[j] = v_Av;
            }
            else if(t>=START_VELFLUC){
                u_Av = uAv[j];
                v_Av = vAv[j];
                u_fluc = ufluc[j];
                v_fluc = vfluc[j];
        		vel_flucLR(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,u_Av,v_Av,u_fluc,v_fluc,t+LRFACTOR*n);
                ufluc[j] = u_fluc;
                vfluc[j] = v_fluc;
            }
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
//	}//end else (not at edge of LR)
}

__global__ void LR_d_ABDC2(float* fin, float* fout,
							float omega, size_t pitch, float SF, int n,
                            int t,float *uAv, float *vAv, float *ufluc, float *vfluc)
{
	int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
	int y = threadIdx.y+blockIdx.y*blockDim.y;
	int z = threadIdx.z+blockIdx.z*blockDim.z;
	float xcoord = LRX0+x*LRFACTOR;//+0.5f is because textures are stored in a voxel centered fashion. we need to change this to vertex centered.
	float ycoord = LRY0+y*LRFACTOR;
	float zcoord = LRZ0+z*LRFACTOR;//dont need to +0.5f because z is not using texture interpolation
//	int zminus = int(zcoord);
//	int zplus = zminus+1;
	int j = x+y*pitch+z*YLRDIM*pitch;//index on padded mem (pitch in elements)
	float f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18;
	int im = ImageFcn(xcoord,ycoord,zcoord);
    float u_Av, v_Av, u_fluc, v_fluc;
//	if(x < n || x > XLRDIM-1-n || y < n || y > YLRDIM-1-n || z < n || z > ZLRDIM-1-n)
//	{
//	//no interp
//	}
//	else{
	f0 = fin[j];
	f1 = fin[f_memLR(1 ,x-1,y       ,z             ,pitch)];
	f3 = fin[f_memLR(3 ,x+1,y       ,z             ,pitch)];
	f2 = fin[f_memLR(2 ,x  ,y-1,z             ,pitch)];
	f5 = fin[f_memLR(5 ,x-1,y-1,z             ,pitch)];
	f6 = fin[f_memLR(6 ,x+1,y-1,z             ,pitch)];
	f4 = fin[f_memLR(4 ,x  ,y+1,z             ,pitch)];
	f7 = fin[f_memLR(7 ,x+1,y+1,z             ,pitch)];
	f8 = fin[f_memLR(8 ,x-1,y+1,z             ,pitch)];
    if(z != 0){
	f9 = fin[f_memLR(9 ,x  ,y  ,z-1,pitch)];
	f10= fin[f_memLR(10,x-1,y  ,z-1,pitch)];
	f11= fin[f_memLR(11,x  ,y-1,z-1,pitch)];
	f12= fin[f_memLR(12,x+1,y  ,z-1,pitch)];
	f13= fin[f_memLR(13,x  ,y+1,z-1,pitch)];
    }
    else{
	f9 = fin[f_memLR(9 ,x                 ,y                 ,ZLRDIM-1,pitch)];
	f10= fin[f_memLR(10,dmax_p(x-1,XLRDIM),y                 ,ZLRDIM-1,pitch)];
	f11= fin[f_memLR(11,x                 ,dmax_p(y-1,YLRDIM),ZLRDIM-1,pitch)];
	f12= fin[f_memLR(12,dmin_p(x+1,XLRDIM),y                 ,ZLRDIM-1,pitch)];
	f13= fin[f_memLR(13,x                 ,dmin_p(y+1,YLRDIM),ZLRDIM-1,pitch)];
    }
    if(z != ZLRDIM-1){
	f14= fin[f_memLR(14,x  ,y  ,z+1,pitch)];
	f15= fin[f_memLR(15,x-1,y  ,z+1,pitch)];
	f16= fin[f_memLR(16,x  ,y-1,z+1,pitch)];
	f17= fin[f_memLR(17,x+1,y  ,z+1,pitch)];
	f18= fin[f_memLR(18,x  ,y+1,z+1,pitch)];
    }
    else{
	f14= fin[f_memLR(14,x                 ,y                 ,0  ,pitch)];
	f15= fin[f_memLR(15,dmax_p(x-1,XLRDIM),y                 ,0  ,pitch)];
	f16= fin[f_memLR(16,x                 ,dmax_p(y-1,YLRDIM),0  ,pitch)];
	f17= fin[f_memLR(17,dmin_p(x+1,XLRDIM),y                 ,0  ,pitch)];
	f18= fin[f_memLR(18,x                 ,dmin_p(y+1,YLRDIM),0  ,pitch)];    
    }

	//else f18 = 0.1f;
	if(im == 1 || im ==10){//BB
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

        if(VELAV == "YES"){
            if(t>=START_VELAV && t<START_VELFLUC){
                u_Av = uAv[j];
                v_Av = vAv[j];
        		vel_avLR(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,u_Av,v_Av,t+LRFACTOR*n);
                uAv[j] = u_Av;
                vAv[j] = v_Av;
            }
            else if(t>=START_VELFLUC){
                u_Av = uAv[j];
                v_Av = vAv[j];
                u_fluc = ufluc[j];
                v_fluc = vfluc[j];
        		vel_flucLR(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,u_Av,v_Av,u_fluc,v_fluc,t+LRFACTOR*n);
                ufluc[j] = u_fluc;
                vfluc[j] = v_fluc;
            }
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
//	}//end else (not at edge of LR)
}

__global__ void LR_d_ABDC_Interp(float* fin, float* fout,
							float omega, size_t pitch, float SF,
                            int t, float *uAv, float *vAv, float *ufluc, float *vfluc)//pitch in elements
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
    float u_Av, v_Av, u_fluc, v_fluc;

    if(((x < LRLEVEL || x > XLRDIM-1-LRLEVEL || y < LRLEVEL || y > YLRDIM-1-LRLEVEL || z < LRLEVEL || z > ZLRDIM-1-LRLEVEL) && ZPERIODIC == "NO")
        ||((x < LRLEVEL || x > XLRDIM-1-LRLEVEL || y < LRLEVEL || y > YLRDIM-1-LRLEVEL) && ZPERIODIC == "YES"))
	{
    if(ZPERIODIC == "YES"){
    if(zcoord < 0){ //if zcoord=-0.25f, 1+zcoord=0.75f
	f0 = (1.f+zcoord)*tex2D(texRef_f0B ,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(-zcoord)*tex2D(texRef_f0B ,xcoord+0.5f,ycoord+0.5f+YDIM*(ZDIM-1));
	f2 = (1.f+zcoord)*tex2D(texRef_f2B ,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(-zcoord)*tex2D(texRef_f2B ,xcoord+0.5f,ycoord+0.5f+YDIM*(ZDIM-1));
	f4 = (1.f+zcoord)*tex2D(texRef_f4B ,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(-zcoord)*tex2D(texRef_f4B ,xcoord+0.5f,ycoord+0.5f+YDIM*(ZDIM-1));
	f9 = (1.f+zcoord)*tex2D(texRef_f9B ,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(-zcoord)*tex2D(texRef_f9B ,xcoord+0.5f,ycoord+0.5f+YDIM*(ZDIM-1));
	f11= (1.f+zcoord)*tex2D(texRef_f11B,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(-zcoord)*tex2D(texRef_f11B,xcoord+0.5f,ycoord+0.5f+YDIM*(ZDIM-1));
	f13= (1.f+zcoord)*tex2D(texRef_f13B,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(-zcoord)*tex2D(texRef_f13B,xcoord+0.5f,ycoord+0.5f+YDIM*(ZDIM-1));
	f14= (1.f+zcoord)*tex2D(texRef_f14B,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(-zcoord)*tex2D(texRef_f14B,xcoord+0.5f,ycoord+0.5f+YDIM*(ZDIM-1));
	f16= (1.f+zcoord)*tex2D(texRef_f16B,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(-zcoord)*tex2D(texRef_f16B,xcoord+0.5f,ycoord+0.5f+YDIM*(ZDIM-1));
	f18= (1.f+zcoord)*tex2D(texRef_f18B,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(-zcoord)*tex2D(texRef_f18B,xcoord+0.5f,ycoord+0.5f+YDIM*(ZDIM-1));
	f1 = (1.f+zcoord)*tex2D(texRef_f1B ,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(-zcoord)*tex2D(texRef_f1B ,xcoord+0.5f,ycoord+0.5f+YDIM*(ZDIM-1));
	f3 = (1.f+zcoord)*tex2D(texRef_f3B ,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(-zcoord)*tex2D(texRef_f3B ,xcoord+0.5f,ycoord+0.5f+YDIM*(ZDIM-1));
	f5 = (1.f+zcoord)*tex2D(texRef_f5B ,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(-zcoord)*tex2D(texRef_f5B ,xcoord+0.5f,ycoord+0.5f+YDIM*(ZDIM-1));
	f6 = (1.f+zcoord)*tex2D(texRef_f6B ,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(-zcoord)*tex2D(texRef_f6B ,xcoord+0.5f,ycoord+0.5f+YDIM*(ZDIM-1));
	f7 = (1.f+zcoord)*tex2D(texRef_f7B ,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(-zcoord)*tex2D(texRef_f7B ,xcoord+0.5f,ycoord+0.5f+YDIM*(ZDIM-1));
	f8 = (1.f+zcoord)*tex2D(texRef_f8B ,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(-zcoord)*tex2D(texRef_f8B ,xcoord+0.5f,ycoord+0.5f+YDIM*(ZDIM-1));
	f15= (1.f+zcoord)*tex2D(texRef_f15B,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(-zcoord)*tex2D(texRef_f15B,xcoord+0.5f,ycoord+0.5f+YDIM*(ZDIM-1));
	f17= (1.f+zcoord)*tex2D(texRef_f17B,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(-zcoord)*tex2D(texRef_f17B,xcoord+0.5f,ycoord+0.5f+YDIM*(ZDIM-1));
	f10= (1.f+zcoord)*tex2D(texRef_f10B,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(-zcoord)*tex2D(texRef_f10B,xcoord+0.5f,ycoord+0.5f+YDIM*(ZDIM-1));
	f12= (1.f+zcoord)*tex2D(texRef_f12B,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(-zcoord)*tex2D(texRef_f12B,xcoord+0.5f,ycoord+0.5f+YDIM*(ZDIM-1));
    }
    else if(zcoord > ZDIM-1){
	f0 = (zplus-zcoord)*tex2D(texRef_f0B ,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f0B ,xcoord+0.5f,ycoord+0.5f+YDIM*(0));
	f2 = (zplus-zcoord)*tex2D(texRef_f2B ,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f2B ,xcoord+0.5f,ycoord+0.5f+YDIM*(0));
	f4 = (zplus-zcoord)*tex2D(texRef_f4B ,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f4B ,xcoord+0.5f,ycoord+0.5f+YDIM*(0));
	f9 = (zplus-zcoord)*tex2D(texRef_f9B ,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f9B ,xcoord+0.5f,ycoord+0.5f+YDIM*(0));
	f11= (zplus-zcoord)*tex2D(texRef_f11B,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f11B,xcoord+0.5f,ycoord+0.5f+YDIM*(0));
	f13= (zplus-zcoord)*tex2D(texRef_f13B,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f13B,xcoord+0.5f,ycoord+0.5f+YDIM*(0));
	f14= (zplus-zcoord)*tex2D(texRef_f14B,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f14B,xcoord+0.5f,ycoord+0.5f+YDIM*(0));
	f16= (zplus-zcoord)*tex2D(texRef_f16B,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f16B,xcoord+0.5f,ycoord+0.5f+YDIM*(0));
	f18= (zplus-zcoord)*tex2D(texRef_f18B,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f18B,xcoord+0.5f,ycoord+0.5f+YDIM*(0));
	f1 = (zplus-zcoord)*tex2D(texRef_f1B ,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f1B ,xcoord+0.5f,ycoord+0.5f+YDIM*(0));
	f3 = (zplus-zcoord)*tex2D(texRef_f3B ,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f3B ,xcoord+0.5f,ycoord+0.5f+YDIM*(0));
	f5 = (zplus-zcoord)*tex2D(texRef_f5B ,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f5B ,xcoord+0.5f,ycoord+0.5f+YDIM*(0));
	f6 = (zplus-zcoord)*tex2D(texRef_f6B ,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f6B ,xcoord+0.5f,ycoord+0.5f+YDIM*(0));
	f7 = (zplus-zcoord)*tex2D(texRef_f7B ,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f7B ,xcoord+0.5f,ycoord+0.5f+YDIM*(0));
	f8 = (zplus-zcoord)*tex2D(texRef_f8B ,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f8B ,xcoord+0.5f,ycoord+0.5f+YDIM*(0));
	f15= (zplus-zcoord)*tex2D(texRef_f15B,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f15B,xcoord+0.5f,ycoord+0.5f+YDIM*(0));
	f17= (zplus-zcoord)*tex2D(texRef_f17B,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f17B,xcoord+0.5f,ycoord+0.5f+YDIM*(0));
	f10= (zplus-zcoord)*tex2D(texRef_f10B,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f10B,xcoord+0.5f,ycoord+0.5f+YDIM*(0));
	f12= (zplus-zcoord)*tex2D(texRef_f12B,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f12B,xcoord+0.5f,ycoord+0.5f+YDIM*(0));
    }
    else{
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
    }
    }
    else{
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
    }


	if(MODEL == "MRT")
	mrt_scale_cf(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,SF);
    else
	bgk_scale_cf(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,SF);

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
	f1 = fin[f_memLR(1 ,x-1,y       ,z             ,pitch)];
	f3 = fin[f_memLR(3 ,x+1,y       ,z             ,pitch)];
	f2 = fin[f_memLR(2 ,x  ,y-1,z             ,pitch)];
	f5 = fin[f_memLR(5 ,x-1,y-1,z             ,pitch)];
	f6 = fin[f_memLR(6 ,x+1,y-1,z             ,pitch)];
	f4 = fin[f_memLR(4 ,x  ,y+1,z             ,pitch)];
	f7 = fin[f_memLR(7 ,x+1,y+1,z             ,pitch)];
	f8 = fin[f_memLR(8 ,x-1,y+1,z             ,pitch)];
    if(z != 0){
	f9 = fin[f_memLR(9 ,x  ,y  ,z-1,pitch)];
	f10= fin[f_memLR(10,x-1,y  ,z-1,pitch)];
	f11= fin[f_memLR(11,x  ,y-1,z-1,pitch)];
	f12= fin[f_memLR(12,x+1,y  ,z-1,pitch)];
	f13= fin[f_memLR(13,x  ,y+1,z-1,pitch)];
    }
    else{
	f9 = fin[f_memLR(9 ,x                 ,y                 ,ZLRDIM-1,pitch)];
	f10= fin[f_memLR(10,dmax_p(x-1,XLRDIM),y                 ,ZLRDIM-1,pitch)];
	f11= fin[f_memLR(11,x                 ,dmax_p(y-1,YLRDIM),ZLRDIM-1,pitch)];
	f12= fin[f_memLR(12,dmin_p(x+1,XLRDIM),y                 ,ZLRDIM-1,pitch)];
	f13= fin[f_memLR(13,x                 ,dmin_p(y+1,YLRDIM),ZLRDIM-1,pitch)];
    }
    if(z != ZLRDIM-1){
	f14= fin[f_memLR(14,x  ,y  ,z+1,pitch)];
	f15= fin[f_memLR(15,x-1,y  ,z+1,pitch)];
	f16= fin[f_memLR(16,x  ,y-1,z+1,pitch)];
	f17= fin[f_memLR(17,x+1,y  ,z+1,pitch)];
	f18= fin[f_memLR(18,x  ,y+1,z+1,pitch)];
    }
    else{
	f14= fin[f_memLR(14,x                 ,y                 ,0  ,pitch)];
	f15= fin[f_memLR(15,dmax_p(x-1,XLRDIM),y                 ,0  ,pitch)];
	f16= fin[f_memLR(16,x                 ,dmax_p(y-1,YLRDIM),0  ,pitch)];
	f17= fin[f_memLR(17,dmin_p(x+1,XLRDIM),y                 ,0  ,pitch)];
	f18= fin[f_memLR(18,x                 ,dmin_p(y+1,YLRDIM),0  ,pitch)];    
    }

	//else f18 = 0.1f;
	if(im == 1 || im ==10){//BB
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

        if(VELAV == "YES"){
            if(t>=START_VELAV && t<START_VELFLUC){
                u_Av = uAv[j];
                v_Av = vAv[j];
        		vel_avLR(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,u_Av,v_Av,t+1-LRFACTOR);
                uAv[j] = u_Av;
                vAv[j] = v_Av;
            }
            else if(t>=START_VELFLUC){
                u_Av = uAv[j];
                v_Av = vAv[j];
                u_fluc = ufluc[j];
                v_fluc = vfluc[j];
        		vel_flucLR(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,u_Av,v_Av,u_fluc,v_fluc,t+1-LRFACTOR);
                ufluc[j] = u_fluc;
                vfluc[j] = v_fluc;
            }
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
	}//end else (not at edge of LR)
}

__global__ void LR_d_BADC2(float* fin, float* fout,
							float omega, size_t pitch, float SF, int n,
                            int t,float *uAv, float *vAv, float *ufluc, float *vfluc)
{
	int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
	int y = threadIdx.y+blockIdx.y*blockDim.y;
	int z = threadIdx.z+blockIdx.z*blockDim.z;
	float xcoord = LRX0+x*LRFACTOR;//+0.5f is because textures are stored in a voxel centered fashion. we need to change this to vertex centered.
	float ycoord = LRY0+y*LRFACTOR;
	float zcoord = LRZ0+z*LRFACTOR;//dont need to +0.5f because z is not using texture interpolation
//	int zminus = int(zcoord);
//	int zplus = zminus+1;
	int j = x+y*pitch+z*YLRDIM*pitch;//index on padded mem (pitch in elements)
	float f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18;
	int im = ImageFcn(xcoord,ycoord,zcoord);
//	if(x < n || x > XLRDIM-1-n || y < n || y > YLRDIM-1-n || z < n || z > ZLRDIM-1-n)
//	{
//	//no interp
//	}
//	else{
	f0 = fin[j];
	f1 = fin[f_memLR(1 ,x-1,y       ,z             ,pitch)];
	f3 = fin[f_memLR(3 ,x+1,y       ,z             ,pitch)];
	f2 = fin[f_memLR(2 ,x  ,y-1,z             ,pitch)];
	f5 = fin[f_memLR(5 ,x-1,y-1,z             ,pitch)];
	f6 = fin[f_memLR(6 ,x+1,y-1,z             ,pitch)];
	f4 = fin[f_memLR(4 ,x  ,y+1,z             ,pitch)];
	f7 = fin[f_memLR(7 ,x+1,y+1,z             ,pitch)];
	f8 = fin[f_memLR(8 ,x-1,y+1,z             ,pitch)];
    if(z != 0){
	f9 = fin[f_memLR(9 ,x  ,y  ,z-1,pitch)];
	f10= fin[f_memLR(10,x-1,y  ,z-1,pitch)];
	f11= fin[f_memLR(11,x  ,y-1,z-1,pitch)];
	f12= fin[f_memLR(12,x+1,y  ,z-1,pitch)];
	f13= fin[f_memLR(13,x  ,y+1,z-1,pitch)];
    }
    else{
	f9 = fin[f_memLR(9 ,x                 ,y                 ,ZLRDIM-1,pitch)];
	f10= fin[f_memLR(10,dmax_p(x-1,XLRDIM),y                 ,ZLRDIM-1,pitch)];
	f11= fin[f_memLR(11,x                 ,dmax_p(y-1,YLRDIM),ZLRDIM-1,pitch)];
	f12= fin[f_memLR(12,dmin_p(x+1,XLRDIM),y                 ,ZLRDIM-1,pitch)];
	f13= fin[f_memLR(13,x                 ,dmin_p(y+1,YLRDIM),ZLRDIM-1,pitch)];
    }
    if(z != ZLRDIM-1){
	f14= fin[f_memLR(14,x  ,y  ,z+1,pitch)];
	f15= fin[f_memLR(15,x-1,y  ,z+1,pitch)];
	f16= fin[f_memLR(16,x  ,y-1,z+1,pitch)];
	f17= fin[f_memLR(17,x+1,y  ,z+1,pitch)];
	f18= fin[f_memLR(18,x  ,y+1,z+1,pitch)];
    }
    else{
	f14= fin[f_memLR(14,x                 ,y                 ,0  ,pitch)];
	f15= fin[f_memLR(15,dmax_p(x-1,XLRDIM),y                 ,0  ,pitch)];
	f16= fin[f_memLR(16,x                 ,dmax_p(y-1,YLRDIM),0  ,pitch)];
	f17= fin[f_memLR(17,dmin_p(x+1,XLRDIM),y                 ,0  ,pitch)];
	f18= fin[f_memLR(18,x                 ,dmin_p(y+1,YLRDIM),0  ,pitch)];    
    }
	if(im == 1 || im ==10){//BB
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

        if(VELAV == "YES"){
        float u_Av, v_Av, u_fluc, v_fluc;
            if(t>=START_VELAV && t<START_VELFLUC){
                u_Av = uAv[j];
                v_Av = vAv[j];
        		vel_avLR(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,u_Av,v_Av,t+LRFACTOR*n);
                uAv[j] = u_Av;
                vAv[j] = v_Av;
            }
            else if(t>=START_VELFLUC){
                u_Av = uAv[j];
                v_Av = vAv[j];
                u_fluc = ufluc[j];
                v_fluc = vfluc[j];
        		vel_flucLR(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,u_Av,v_Av,u_fluc,v_fluc,t+LRFACTOR*n);
                ufluc[j] = u_fluc;
                vfluc[j] = v_fluc;
            }
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
//	}//end else (not at edge of LR)
}

__global__ void LR_d_BADC_Interp(float* fin, float* fout,
							float omega, size_t pitch, float SF,
                            int t,float *uAv, float *vAv, float *ufluc, float *vfluc)
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
    if(((x < LRLEVEL || x > XLRDIM-1-LRLEVEL || y < LRLEVEL || y > YLRDIM-1-LRLEVEL || z < LRLEVEL || z > ZLRDIM-1-LRLEVEL) && ZPERIODIC == "NO")
        ||((x < LRLEVEL || x > XLRDIM-1-LRLEVEL || y < LRLEVEL || y > YLRDIM-1-LRLEVEL) && ZPERIODIC == "YES"))
	{
    if(ZPERIODIC == "YES"){
    if(zcoord < 0){ //if zcoord=-0.25f, 1+zcoord=0.75f
	f0 = (1.f+zcoord)*tex2D(texRef_f0A ,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(-zcoord)*tex2D(texRef_f0A ,xcoord+0.5f,ycoord+0.5f+YDIM*(ZDIM-1));
	f2 = (1.f+zcoord)*tex2D(texRef_f2A ,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(-zcoord)*tex2D(texRef_f2A ,xcoord+0.5f,ycoord+0.5f+YDIM*(ZDIM-1));
	f4 = (1.f+zcoord)*tex2D(texRef_f4A ,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(-zcoord)*tex2D(texRef_f4A ,xcoord+0.5f,ycoord+0.5f+YDIM*(ZDIM-1));
	f9 = (1.f+zcoord)*tex2D(texRef_f9A ,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(-zcoord)*tex2D(texRef_f9A ,xcoord+0.5f,ycoord+0.5f+YDIM*(ZDIM-1));
	f11= (1.f+zcoord)*tex2D(texRef_f11A,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(-zcoord)*tex2D(texRef_f11A,xcoord+0.5f,ycoord+0.5f+YDIM*(ZDIM-1));
	f13= (1.f+zcoord)*tex2D(texRef_f13A,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(-zcoord)*tex2D(texRef_f13A,xcoord+0.5f,ycoord+0.5f+YDIM*(ZDIM-1));
	f14= (1.f+zcoord)*tex2D(texRef_f14A,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(-zcoord)*tex2D(texRef_f14A,xcoord+0.5f,ycoord+0.5f+YDIM*(ZDIM-1));
	f16= (1.f+zcoord)*tex2D(texRef_f16A,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(-zcoord)*tex2D(texRef_f16A,xcoord+0.5f,ycoord+0.5f+YDIM*(ZDIM-1));
	f18= (1.f+zcoord)*tex2D(texRef_f18A,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(-zcoord)*tex2D(texRef_f18A,xcoord+0.5f,ycoord+0.5f+YDIM*(ZDIM-1));
	f1 = (1.f+zcoord)*tex2D(texRef_f1A ,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(-zcoord)*tex2D(texRef_f1A ,xcoord+0.5f,ycoord+0.5f+YDIM*(ZDIM-1));
	f3 = (1.f+zcoord)*tex2D(texRef_f3A ,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(-zcoord)*tex2D(texRef_f3A ,xcoord+0.5f,ycoord+0.5f+YDIM*(ZDIM-1));
	f5 = (1.f+zcoord)*tex2D(texRef_f5A ,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(-zcoord)*tex2D(texRef_f5A ,xcoord+0.5f,ycoord+0.5f+YDIM*(ZDIM-1));
	f6 = (1.f+zcoord)*tex2D(texRef_f6A ,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(-zcoord)*tex2D(texRef_f6A ,xcoord+0.5f,ycoord+0.5f+YDIM*(ZDIM-1));
	f7 = (1.f+zcoord)*tex2D(texRef_f7A ,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(-zcoord)*tex2D(texRef_f7A ,xcoord+0.5f,ycoord+0.5f+YDIM*(ZDIM-1));
	f8 = (1.f+zcoord)*tex2D(texRef_f8A ,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(-zcoord)*tex2D(texRef_f8A ,xcoord+0.5f,ycoord+0.5f+YDIM*(ZDIM-1));
	f15= (1.f+zcoord)*tex2D(texRef_f15A,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(-zcoord)*tex2D(texRef_f15A,xcoord+0.5f,ycoord+0.5f+YDIM*(ZDIM-1));
	f17= (1.f+zcoord)*tex2D(texRef_f17A,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(-zcoord)*tex2D(texRef_f17A,xcoord+0.5f,ycoord+0.5f+YDIM*(ZDIM-1));
	f10= (1.f+zcoord)*tex2D(texRef_f10A,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(-zcoord)*tex2D(texRef_f10A,xcoord+0.5f,ycoord+0.5f+YDIM*(ZDIM-1));
	f12= (1.f+zcoord)*tex2D(texRef_f12A,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(-zcoord)*tex2D(texRef_f12A,xcoord+0.5f,ycoord+0.5f+YDIM*(ZDIM-1));
    }
    else if(zcoord > ZDIM-1){
	f0 = (zplus-zcoord)*tex2D(texRef_f0A ,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f0A ,xcoord+0.5f,ycoord+0.5f+YDIM*(0));
	f2 = (zplus-zcoord)*tex2D(texRef_f2A ,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f2A ,xcoord+0.5f,ycoord+0.5f+YDIM*(0));
	f4 = (zplus-zcoord)*tex2D(texRef_f4A ,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f4A ,xcoord+0.5f,ycoord+0.5f+YDIM*(0));
	f9 = (zplus-zcoord)*tex2D(texRef_f9A ,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f9A ,xcoord+0.5f,ycoord+0.5f+YDIM*(0));
	f11= (zplus-zcoord)*tex2D(texRef_f11A,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f11A,xcoord+0.5f,ycoord+0.5f+YDIM*(0));
	f13= (zplus-zcoord)*tex2D(texRef_f13A,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f13A,xcoord+0.5f,ycoord+0.5f+YDIM*(0));
	f14= (zplus-zcoord)*tex2D(texRef_f14A,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f14A,xcoord+0.5f,ycoord+0.5f+YDIM*(0));
	f16= (zplus-zcoord)*tex2D(texRef_f16A,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f16A,xcoord+0.5f,ycoord+0.5f+YDIM*(0));
	f18= (zplus-zcoord)*tex2D(texRef_f18A,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f18A,xcoord+0.5f,ycoord+0.5f+YDIM*(0));
	f1 = (zplus-zcoord)*tex2D(texRef_f1A ,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f1A ,xcoord+0.5f,ycoord+0.5f+YDIM*(0));
	f3 = (zplus-zcoord)*tex2D(texRef_f3A ,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f3A ,xcoord+0.5f,ycoord+0.5f+YDIM*(0));
	f5 = (zplus-zcoord)*tex2D(texRef_f5A ,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f5A ,xcoord+0.5f,ycoord+0.5f+YDIM*(0));
	f6 = (zplus-zcoord)*tex2D(texRef_f6A ,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f6A ,xcoord+0.5f,ycoord+0.5f+YDIM*(0));
	f7 = (zplus-zcoord)*tex2D(texRef_f7A ,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f7A ,xcoord+0.5f,ycoord+0.5f+YDIM*(0));
	f8 = (zplus-zcoord)*tex2D(texRef_f8A ,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f8A ,xcoord+0.5f,ycoord+0.5f+YDIM*(0));
	f15= (zplus-zcoord)*tex2D(texRef_f15A,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f15A,xcoord+0.5f,ycoord+0.5f+YDIM*(0));
	f17= (zplus-zcoord)*tex2D(texRef_f17A,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f17A,xcoord+0.5f,ycoord+0.5f+YDIM*(0));
	f10= (zplus-zcoord)*tex2D(texRef_f10A,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f10A,xcoord+0.5f,ycoord+0.5f+YDIM*(0));
	f12= (zplus-zcoord)*tex2D(texRef_f12A,xcoord+0.5f,ycoord+0.5f+YDIM*(zminus))+(zcoord-zminus)*tex2D(texRef_f12A,xcoord+0.5f,ycoord+0.5f+YDIM*(0));
    }
    else{
	//interpolate for next time step. from A //YDIM and not YLRDIM
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
    }
    }
    else{
	//interpolate for next time step. from A //YDIM and not YLRDIM
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
    }


	
	if(MODEL == "MRT")
	mrt_scale_cf(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,SF);
    else
	bgk_scale_cf(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,SF);

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
	f1 = fin[f_memLR(1 ,x-1,y       ,z             ,pitch)];
	f3 = fin[f_memLR(3 ,x+1,y       ,z             ,pitch)];
	f2 = fin[f_memLR(2 ,x  ,y-1,z             ,pitch)];
	f5 = fin[f_memLR(5 ,x-1,y-1,z             ,pitch)];
	f6 = fin[f_memLR(6 ,x+1,y-1,z             ,pitch)];
	f4 = fin[f_memLR(4 ,x  ,y+1,z             ,pitch)];
	f7 = fin[f_memLR(7 ,x+1,y+1,z             ,pitch)];
	f8 = fin[f_memLR(8 ,x-1,y+1,z             ,pitch)];
    if(z != 0){
	f9 = fin[f_memLR(9 ,x  ,y  ,z-1,pitch)];
	f10= fin[f_memLR(10,x-1,y  ,z-1,pitch)];
	f11= fin[f_memLR(11,x  ,y-1,z-1,pitch)];
	f12= fin[f_memLR(12,x+1,y  ,z-1,pitch)];
	f13= fin[f_memLR(13,x  ,y+1,z-1,pitch)];
    }
    else{
	f9 = fin[f_memLR(9 ,x                 ,y                 ,ZLRDIM-1,pitch)];
	f10= fin[f_memLR(10,dmax_p(x-1,XLRDIM),y                 ,ZLRDIM-1,pitch)];
	f11= fin[f_memLR(11,x                 ,dmax_p(y-1,YLRDIM),ZLRDIM-1,pitch)];
	f12= fin[f_memLR(12,dmin_p(x+1,XLRDIM),y                 ,ZLRDIM-1,pitch)];
	f13= fin[f_memLR(13,x                 ,dmin_p(y+1,YLRDIM),ZLRDIM-1,pitch)];
    }
    if(z != ZLRDIM-1){
	f14= fin[f_memLR(14,x  ,y  ,z+1,pitch)];
	f15= fin[f_memLR(15,x-1,y  ,z+1,pitch)];
	f16= fin[f_memLR(16,x  ,y-1,z+1,pitch)];
	f17= fin[f_memLR(17,x+1,y  ,z+1,pitch)];
	f18= fin[f_memLR(18,x  ,y+1,z+1,pitch)];
    }
    else{
	f14= fin[f_memLR(14,x                 ,y                 ,0  ,pitch)];
	f15= fin[f_memLR(15,dmax_p(x-1,XLRDIM),y                 ,0  ,pitch)];
	f16= fin[f_memLR(16,x                 ,dmax_p(y-1,YLRDIM),0  ,pitch)];
	f17= fin[f_memLR(17,dmin_p(x+1,XLRDIM),y                 ,0  ,pitch)];
	f18= fin[f_memLR(18,x                 ,dmin_p(y+1,YLRDIM),0  ,pitch)];    
    }

	if(im == 1 || im ==10){//BB
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

        if(VELAV == "YES"){
        float u_Av, v_Av, u_fluc, v_fluc;
            if(t>=START_VELAV && t<START_VELFLUC){
                u_Av = uAv[j];
                v_Av = vAv[j];
        		vel_avLR(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,u_Av,v_Av,t+1-LRFACTOR);
                uAv[j] = u_Av;
                vAv[j] = v_Av;
            }
            else if(t>=START_VELFLUC){
                u_Av = uAv[j];
                v_Av = vAv[j];
                u_fluc = ufluc[j];
                v_fluc = vfluc[j];
        		vel_flucLR(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,u_Av,v_Av,u_fluc,v_fluc,t+1-LRFACTOR);
                ufluc[j] = u_fluc;
                vfluc[j] = v_fluc;
            }
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
	}//end else (not at edge of LR)
}

__global__ void LR_d_ABCD(float* fin, float* fout,
							float omega, size_t pitch,//pitch in elements
                            int t,float *uAv, float *vAv, float *ufluc, float *vfluc)
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
    float u_Av, v_Av, u_fluc, v_fluc;
//	if(x < 2 || x > LRX0+XLRDIM-3 || y < 2 || y > LRY0+YLRDIM-3 || z < 2 || z > LRZ0+ZLRDIM-3)
//	im = -1;//not valid for extraction
//	if(x < 1 || x > LRX0+XLRDIM-2 || y < 1 || y > LRY0+YLRDIM-2 || z < 1 || z > LRZ0+ZLRDIM-2)
//	{
//	im = -2;//not valid for second TS
//	}

//	if(x < 1 || x > XLRDIM-2 || y < 1 || y > YLRDIM-2 || z < 1 || z > ZLRDIM-2)
//	{
//	//dont do anything
//	}
//	else{
	f0 = fin[j];
	f1 = fin[f_memLR(1 ,x-1,y  ,z  ,pitch)];
	f3 = fin[f_memLR(3 ,x+1,y  ,z  ,pitch)];
	f2 = fin[f_memLR(2 ,x  ,y-1,z  ,pitch)];
	f5 = fin[f_memLR(5 ,x-1,y-1,z  ,pitch)];
	f6 = fin[f_memLR(6 ,x+1,y-1,z  ,pitch)];
	f4 = fin[f_memLR(4 ,x  ,y+1,z  ,pitch)];
	f7 = fin[f_memLR(7 ,x+1,y+1,z  ,pitch)];
	f8 = fin[f_memLR(8 ,x-1,y+1,z  ,pitch)];
    if(z != 0){
	f9 = fin[f_memLR(9 ,x  ,y  ,z-1,pitch)];
	f10= fin[f_memLR(10,x-1,y  ,z-1,pitch)];
	f11= fin[f_memLR(11,x  ,y-1,z-1,pitch)];
	f12= fin[f_memLR(12,x+1,y  ,z-1,pitch)];
	f13= fin[f_memLR(13,x  ,y+1,z-1,pitch)];
    }
    else{
	f9 = fin[f_memLR(9 ,x                 ,y                 ,ZLRDIM-1,pitch)];
	f10= fin[f_memLR(10,dmax_p(x-1,XLRDIM),y                 ,ZLRDIM-1,pitch)];
	f11= fin[f_memLR(11,x                 ,dmax_p(y-1,YLRDIM),ZLRDIM-1,pitch)];
	f12= fin[f_memLR(12,dmin_p(x+1,XLRDIM),y                 ,ZLRDIM-1,pitch)];
	f13= fin[f_memLR(13,x                 ,dmin_p(y+1,YLRDIM),ZLRDIM-1,pitch)];
    }
    if(z != ZLRDIM-1){
	f14= fin[f_memLR(14,x  ,y  ,z+1,pitch)];
	f15= fin[f_memLR(15,x-1,y  ,z+1,pitch)];
	f16= fin[f_memLR(16,x  ,y-1,z+1,pitch)];
	f17= fin[f_memLR(17,x+1,y  ,z+1,pitch)];
	f18= fin[f_memLR(18,x  ,y+1,z+1,pitch)];
    }
    else{
	f14= fin[f_memLR(14,x                 ,y                 ,0  ,pitch)];
	f15= fin[f_memLR(15,dmax_p(x-1,XLRDIM),y                 ,0  ,pitch)];
	f16= fin[f_memLR(16,x                 ,dmax_p(y-1,YLRDIM),0  ,pitch)];
	f17= fin[f_memLR(17,dmin_p(x+1,XLRDIM),y                 ,0  ,pitch)];
	f18= fin[f_memLR(18,x                 ,dmin_p(y+1,YLRDIM),0  ,pitch)];    
    }
	if(im == 1 || im ==10){//BB
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

        if(VELAV == "YES"){
            if(t>=START_VELAV && t<START_VELFLUC){
                u_Av = uAv[j];
                v_Av = vAv[j];
        		vel_avLR(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,u_Av,v_Av,t+LRFACTOR);
                uAv[j] = u_Av;
                vAv[j] = v_Av;
            }
            else if(t>=START_VELFLUC){
                u_Av = uAv[j];
                v_Av = vAv[j];
                u_fluc = ufluc[j];
                v_fluc = vfluc[j];
        		vel_flucLR(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,u_Av,v_Av,u_fluc,v_fluc,t+LRFACTOR);
                ufluc[j] = u_fluc;
                vfluc[j] = v_fluc;
            }
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
//	}//end else (not at edge of LR)
}



__global__ void LR_d_BACD(float* fin, float* fout,
							float omega, size_t pitch,
                            int t,float *uAv, float *vAv, float *ufluc, float *vfluc)
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

//	if(x < 1 || x > XLRDIM-2 || y < 1 || y > YLRDIM-2 || z < 1 || z > ZLRDIM-2)
//	{
//	//dont do anything
//	}
//	else{
	f0 = fin[j];
	f1 = fin[f_memLR(1 ,x-1,y  ,z  ,pitch)];
	f3 = fin[f_memLR(3 ,x+1,y  ,z  ,pitch)];
	f2 = fin[f_memLR(2 ,x  ,y-1,z  ,pitch)];
	f5 = fin[f_memLR(5 ,x-1,y-1,z  ,pitch)];
	f6 = fin[f_memLR(6 ,x+1,y-1,z  ,pitch)];
	f4 = fin[f_memLR(4 ,x  ,y+1,z  ,pitch)];
	f7 = fin[f_memLR(7 ,x+1,y+1,z  ,pitch)];
	f8 = fin[f_memLR(8 ,x-1,y+1,z  ,pitch)];
    if(z != 0){
	f9 = fin[f_memLR(9 ,x  ,y  ,z-1,pitch)];
	f10= fin[f_memLR(10,x-1,y  ,z-1,pitch)];
	f11= fin[f_memLR(11,x  ,y-1,z-1,pitch)];
	f12= fin[f_memLR(12,x+1,y  ,z-1,pitch)];
	f13= fin[f_memLR(13,x  ,y+1,z-1,pitch)];
    }
    else{
	f9 = fin[f_memLR(9 ,x                 ,y                 ,ZLRDIM-1,pitch)];
	f10= fin[f_memLR(10,dmax_p(x-1,XLRDIM),y                 ,ZLRDIM-1,pitch)];
	f11= fin[f_memLR(11,x                 ,dmax_p(y-1,YLRDIM),ZLRDIM-1,pitch)];
	f12= fin[f_memLR(12,dmin_p(x+1,XLRDIM),y                 ,ZLRDIM-1,pitch)];
	f13= fin[f_memLR(13,x                 ,dmin_p(y+1,YLRDIM),ZLRDIM-1,pitch)];
    }
    if(z != ZLRDIM-1){
	f14= fin[f_memLR(14,x  ,y  ,z+1,pitch)];
	f15= fin[f_memLR(15,x-1,y  ,z+1,pitch)];
	f16= fin[f_memLR(16,x  ,y-1,z+1,pitch)];
	f17= fin[f_memLR(17,x+1,y  ,z+1,pitch)];
	f18= fin[f_memLR(18,x  ,y+1,z+1,pitch)];
    }
    else{
	f14= fin[f_memLR(14,x                 ,y                 ,0  ,pitch)];
	f15= fin[f_memLR(15,dmax_p(x-1,XLRDIM),y                 ,0  ,pitch)];
	f16= fin[f_memLR(16,x                 ,dmax_p(y-1,YLRDIM),0  ,pitch)];
	f17= fin[f_memLR(17,dmin_p(x+1,XLRDIM),y                 ,0  ,pitch)];
	f18= fin[f_memLR(18,x                 ,dmin_p(y+1,YLRDIM),0  ,pitch)];    
    }
	if(im == 1 || im ==10){//BB
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
        if(VELAV == "YES"){
        float u_Av, v_Av, u_fluc, v_fluc;
            if(t>=START_VELAV && t<START_VELFLUC){
                u_Av = uAv[j];
                v_Av = vAv[j];
        		vel_avLR(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,u_Av,v_Av,t+LRFACTOR);
                uAv[j] = u_Av;
                vAv[j] = v_Av;
            }
            else if(t>=START_VELFLUC){
                u_Av = uAv[j];
                v_Av = vAv[j];
                u_fluc = ufluc[j];
                v_fluc = vfluc[j];
        		vel_flucLR(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,u_Av,v_Av,u_fluc,v_fluc,t+LRFACTOR);
                ufluc[j] = u_fluc;
                vfluc[j] = v_fluc;
            }
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
//	}//end else (not at edge of LR)
}

__global__ void mrt_d_single_force(float* fin, float* fout,
							float omega, size_t pitch, float *FX, float *FY, float *FZ, 
                            int t,float *uAv, float *vAv, float *ufluc, float *vfluc)
{
	int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
	int y = threadIdx.y+blockIdx.y*blockDim.y;//;
	int z = threadIdx.z+blockIdx.z*blockDim.z;
	int j = x+y*pitch+z*YDIM*pitch;//index on padded mem (pitch in elements)
	float f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18;
	__shared__ float sumX[BLOCKSIZEX], sumY[BLOCKSIZEX], sumZ[BLOCKSIZEX];
	__shared__ int check[1];
	check[0] = 0;
	syncthreads();
    float u_Av, v_Av, u_fluc, v_fluc;


//	if((REFINEMENT == "YES" && x > LRX0+1 && x < LRX0+(XLRDIM-1)*LRFACTOR-1 && 
//						y > LRY0+1 && y < LRY0+(YLRDIM-1)*LRFACTOR-1 &&
//						z > LRZ0+1 && z < LRZ0+(ZLRDIM-1)*LRFACTOR-1 ||
//						(x>XDIM-1)))
//	{
//	}
//	else{
	int im = ImageFcn(x,y,z);

	f0 = fin[j];
	f1 = fin[f_mem(1 ,x-1,y  ,z  ,pitch)];
	f3 = fin[f_mem(3 ,x+1,y  ,z  ,pitch)];
	f2 = fin[f_mem(2 ,x  ,y-1,z  ,pitch)];
	f5 = fin[f_mem(5 ,x-1,y-1,z  ,pitch)];
	f6 = fin[f_mem(6 ,x+1,y-1,z  ,pitch)];
	f4 = fin[f_mem(4 ,x  ,y+1,z  ,pitch)];
	f7 = fin[f_mem(7 ,x+1,y+1,z  ,pitch)];
	f8 = fin[f_mem(8 ,x-1,y+1,z  ,pitch)];
    if(z != 0){
	f9 = fin[f_mem(9 ,x  ,y  ,z-1,pitch)];
	f10= fin[f_mem(10,x-1,y  ,z-1,pitch)];
	f11= fin[f_mem(11,x  ,y-1,z-1,pitch)];
	f12= fin[f_mem(12,x+1,y  ,z-1,pitch)];
	f13= fin[f_mem(13,x  ,y+1,z-1,pitch)];
    }
    else{
	f9 = fin[f_mem(9 ,x  ,y  ,ZDIM-1,pitch)];
	f10= fin[f_mem(10,dmax_p(x-1,XDIM),y  ,ZDIM-1,pitch)];
	f11= fin[f_mem(11,x  ,dmax_p(y-1,YDIM),ZDIM-1,pitch)];
	f12= fin[f_mem(12,dmin_p(x+1,XDIM),y  ,ZDIM-1,pitch)];
	f13= fin[f_mem(13,x  ,dmin_p(y+1,YDIM),ZDIM-1,pitch)];
    }
    if(z != ZDIM-1){
	f14= fin[f_mem(14,x  ,y  ,z+1,pitch)];
	f15= fin[f_mem(15,x-1,y  ,z+1,pitch)];
	f16= fin[f_mem(16,x  ,y-1,z+1,pitch)];
	f17= fin[f_mem(17,x+1,y  ,z+1,pitch)];
	f18= fin[f_mem(18,x  ,y+1,z+1,pitch)];
    }
    else{
	f14= fin[f_mem(14,x  ,y  ,0  ,pitch)];
	f15= fin[f_mem(15,dmax_p(x-1,XDIM),y  ,0  ,pitch)];
	f16= fin[f_mem(16,x  ,dmax_p(y-1,YDIM),0  ,pitch)];
	f17= fin[f_mem(17,dmin_p(x+1,XDIM),y  ,0  ,pitch)];
	f18= fin[f_mem(18,x  ,dmin_p(y+1,YDIM),0  ,pitch)];    
    }

	if(im == 1 || im == 10){//BB
		if(im == 10){
		check[0] = 1;
		sumX[threadIdx.x]=2.f*f1-2.f*f3+2.f*f5+2.f*f8-2.f*f6-2.f*f7+2.f*f10-2.f*f12+2.f*f15-2.f*f17;
		sumY[threadIdx.x]=2.f*f2-2.f*f4+2.f*f5-2.f*f8+2.f*f6-2.f*f7+2.f*f11-2.f*f13+2.f*f16-2.f*f18;
		sumZ[threadIdx.x]=2.f*f9+2.f*f10+2.f*f11+2.f*f12+2.f*f13-2.f*f14-2.f*f15-2.f*f16-2.f*f17-2.f*f18;
		}
		else{
		sumX[threadIdx.x]=0.f;
		sumY[threadIdx.x]=0.f;
		sumZ[threadIdx.x]=0.f;
		}
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
		sumX[threadIdx.x]=0.f;
		sumY[threadIdx.x]=0.f;
		sumZ[threadIdx.x]=0.f;
		boundaries_force(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,y,z,im);

        if(im == 100)//north outlet
        {
           	f0 = fin[f_mem(0 ,x,y-1,z,pitch)];
        	f1 = fin[f_mem(1 ,x,y-1,z,pitch)];
        	f3 = fin[f_mem(3 ,x,y-1,z,pitch)];
        	f2 = fin[f_mem(2 ,x,y-1,z,pitch)];
        	f5 = fin[f_mem(5 ,x,y-1,z,pitch)];
        	f6 = fin[f_mem(6 ,x,y-1,z,pitch)];
        	f4 = fin[f_mem(4 ,x,y-1,z,pitch)];
        	f7 = fin[f_mem(7 ,x,y-1,z,pitch)];
        	f8 = fin[f_mem(8 ,x,y-1,z,pitch)];
        	f9 = fin[f_mem(9 ,x,y-1,z,pitch)];
        	f10= fin[f_mem(10,x,y-1,z,pitch)];
        	f11= fin[f_mem(11,x,y-1,z,pitch)];
        	f12= fin[f_mem(12,x,y-1,z,pitch)];
        	f13= fin[f_mem(13,x,y-1,z,pitch)];
        	f14= fin[f_mem(14,x,y-1,z,pitch)];
        	f15= fin[f_mem(15,x,y-1,z,pitch)];
        	f16= fin[f_mem(16,x,y-1,z,pitch)];
        	f17= fin[f_mem(17,x,y-1,z,pitch)];
        	f18= fin[f_mem(18,x,y-1,z,pitch)];

	float rho,u,v,w;	
	rho = 1.0f;
	u = f1-f3+f5-f6-f7+f8+f10-f12+f15-f17;
	v = f2-f4+f5+f6-f7-f8+f11-f13+f16-f18;
	w = f9+f10+f11+f12+f13-f14-f15-f16-f17-f18;

	float m1,m2,m4,m6,m8,m9,m10,m11,m12,m13,m14,m15,m16,m17,m18;

	m1  = -30.f*f0+-11.f*f1+-11.f*f2+-11.f*f3+-11.f*f4+  8.f*f5+  8.f*f6+  8.f*f7+  8.f*f8+-11.f*f9+  8.f*f10+  8.f*f11+  8.f*f12+  8.f*f13+-11.f*f14+  8.f*f15+  8.f*f16+  8.f*f17+  8.f*f18;
	m2  =  12.f*f0+ -4.f*f1+ -4.f*f2+ -4.f*f3+ -4.f*f4+    f5+    f6+    f7+    f8+ -4.f*f9+    f10+      f11+    f12+    f13+ -4.f*f14+    f15+    f16+    f17+    f18;
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

f0 =(0.052631579f*rho                           +- 0.012531328f*(m1)+ 0.047619048f*(m2));
f1 =(0.052631579f*rho+  0.1f*u                  +-0.0045948204f*(m1)+-0.015873016f*(m2)+  -0.1f*(m4)                 + 0.055555556f*((m9)-m10));
f2 =(0.052631579f*rho         +  0.1f*v         +-0.0045948204f*(m1)+-0.015873016f*(m2)             +   -0.1f*(m6)   +-0.027777778f*((m9)-m10)+ 0.083333333f*((m11)-m12));
f3 =(0.052631579f*rho+ -0.1f*u                  +-0.0045948204f*(m1)+-0.015873016f*(m2)+   0.1f*(m4)                 + 0.055555556f*((m9)-m10));                                                                                         
f4 =(0.052631579f*rho         + -0.1f*v         +-0.0045948204f*(m1)+-0.015873016f*(m2)             +    0.1f*(m6)   +-0.027777778f*((m9)-m10)+ 0.083333333f*((m11)-m12));
f5 =(0.052631579f*rho+  0.1f*u+  0.1f*v         + 0.0033416876f*(m1)+ 0.003968254f*(m2)+ 0.025f*(m4+m6)              +0.013888889f*(m10)+0.041666667f*(m12)+0.125f*( m16-m17)+ (0.027777778f*(m9) +0.083333333f*(m11)+( 0.25f*(m13))));
f6 =(0.052631579f*rho+ -0.1f*u+  0.1f*v         + 0.0033416876f*(m1)+ 0.003968254f*(m2)+-0.025f*(m4-m6)              +0.013888889f*(m10)+0.041666667f*(m12)+0.125f*(-m16-m17)+ (0.027777778f*(m9) +0.083333333f*(m11)+(-0.25f*(m13))));
f7 =(0.052631579f*rho+ -0.1f*u+ -0.1f*v         + 0.0033416876f*(m1)+ 0.003968254f*(m2)+-0.025f*(m4+m6)              +0.013888889f*(m10)+0.041666667f*(m12)+0.125f*(-m16+m17)+ (0.027777778f*(m9) +0.083333333f*(m11)+( 0.25f*(m13))));
f8 =(0.052631579f*rho+  0.1f*u+ -0.1f*v         + 0.0033416876f*(m1)+ 0.003968254f*(m2)+ 0.025f*(m4-m6)              +0.013888889f*(m10)+0.041666667f*(m12)+0.125f*( m16+m17)+ (0.027777778f*(m9) +0.083333333f*(m11)+(-0.25f*(m13))));
f9 =(0.052631579f*rho                  +  0.1f*w+-0.0045948204f*(m1)+-0.015873016f*(m2)                +   -0.1f*(m8)+-0.027777778f*((m9)-m10)+-0.083333333f*((m11)-m12));                                       
f10=(0.052631579f*rho+  0.1f*u         +  0.1f*w+ 0.0033416876f*(m1)+ 0.003968254f*(m2)+ 0.025f*(m4+m8)              +0.013888889f*(m10)-0.041666667f*(m12)+0.125f*(-m16+m18)+ (0.027777778f*(m9) -0.083333333f*(m11)+( 0.25f*(m15))));
f11=(0.052631579f*rho         +  0.1f*v+  0.1f*w+ 0.0033416876f*(m1)+ 0.003968254f*(m2)             +  0.025f*(m6+m8)+0.125f*( m17-m18)-0.027777778f*(m10)+(-0.055555556f*(m9) +( 0.25f*(m14))));
f12=(0.052631579f*rho+ -0.1f*u         +  0.1f*w+ 0.0033416876f*(m1)+ 0.003968254f*(m2)+-0.025f*(m4-m8)              +0.013888889f*(m10)-0.041666667f*(m12)+0.125f*( m16+m18)+ (0.027777778f*(m9) -0.083333333f*(m11)+(-0.25f*(m15))));
f13=(0.052631579f*rho         + -0.1f*v+  0.1f*w+ 0.0033416876f*(m1)+ 0.003968254f*(m2)             + -0.025f*(m6-m8)+0.125f*(-m17-m18)-0.027777778f*(m10)+(-0.055555556f*(m9) +(-0.25f*(m14))));
f14=(0.052631579f*rho                  + -0.1f*w+-0.0045948204f*(m1)+-0.015873016f*(m2)                +    0.1f*(m8)+-0.027777778f*((m9)-m10)+-0.083333333f*((m11)-m12));                                      
f15=(0.052631579f*rho+  0.1f*u         + -0.1f*w+ 0.0033416876f*(m1)+ 0.003968254f*(m2)+ 0.025f*(m4-m8)              +0.013888889f*(m10)-0.041666667f*(m12)+0.125f*(-m16-m18)+ (0.027777778f*(m9) -0.083333333f*(m11)+(-0.25f*(m15))));
f16=(0.052631579f*rho         +  0.1f*v+ -0.1f*w+ 0.0033416876f*(m1)+ 0.003968254f*(m2)             +  0.025f*(m6-m8)+0.125f*( m17+m18)-0.027777778f*(m10)+(-0.055555556f*(m9) +(-0.25f*(m14))));
f17=(0.052631579f*rho+ -0.1f*u         + -0.1f*w+ 0.0033416876f*(m1)+ 0.003968254f*(m2)+-0.025f*(m4+m8)              +0.013888889f*(m10)-0.041666667f*(m12)+0.125f*( m16-m18)+ (0.027777778f*(m9) -0.083333333f*(m11)+( 0.25f*(m15))));
f18=(0.052631579f*rho         + -0.1f*v+ -0.1f*w+ 0.0033416876f*(m1)+ 0.003968254f*(m2)             + -0.025f*(m6+m8)+0.125f*(-m17+m18)-0.027777778f*(m10)+(-0.055555556f*(m9) +( 0.25f*(m14))));

        }
        if(im == 200)//south inlet
        {
           	f0 = fin[f_mem(0 ,x,y+1,z,pitch)];
        	f1 = fin[f_mem(1 ,x,y+1,z,pitch)];
        	f3 = fin[f_mem(3 ,x,y+1,z,pitch)];
        	f2 = fin[f_mem(2 ,x,y+1,z,pitch)];
        	f5 = fin[f_mem(5 ,x,y+1,z,pitch)];
        	f6 = fin[f_mem(6 ,x,y+1,z,pitch)];
        	f4 = fin[f_mem(4 ,x,y+1,z,pitch)];
        	f7 = fin[f_mem(7 ,x,y+1,z,pitch)];
        	f8 = fin[f_mem(8 ,x,y+1,z,pitch)];
        	f9 = fin[f_mem(9 ,x,y+1,z,pitch)];
        	f10= fin[f_mem(10,x,y+1,z,pitch)];
        	f11= fin[f_mem(11,x,y+1,z,pitch)];
        	f12= fin[f_mem(12,x,y+1,z,pitch)];
        	f13= fin[f_mem(13,x,y+1,z,pitch)];
        	f14= fin[f_mem(14,x,y+1,z,pitch)];
        	f15= fin[f_mem(15,x,y+1,z,pitch)];
        	f16= fin[f_mem(16,x,y+1,z,pitch)];
        	f17= fin[f_mem(17,x,y+1,z,pitch)];
        	f18= fin[f_mem(18,x,y+1,z,pitch)];

	float rho,u,v,w;	
	rho = f0+f1+f2+f3+f4+f5+f6+f7+f8+f9+f10+f11+f12+f13+f14+f15+f16+f17+f18;
	u = 0.f;//f1-f3+f5-f6-f7+f8+f10-f12+f15-f17;
	v = UMAX;//f2-f4+f5+f6-f7-f8+f11-f13+f16-f18;
	w = 0.f;//f9+f10+f11+f12+f13-f14-f15-f16-f17-f18;

	float m1,m2,m4,m6,m8,m9,m10,m11,m12,m13,m14,m15,m16,m17,m18;

	m1  = -30.f*f0+-11.f*f1+-11.f*f2+-11.f*f3+-11.f*f4+  8.f*f5+  8.f*f6+  8.f*f7+  8.f*f8+-11.f*f9+  8.f*f10+  8.f*f11+  8.f*f12+  8.f*f13+-11.f*f14+  8.f*f15+  8.f*f16+  8.f*f17+  8.f*f18;
	m2  =  12.f*f0+ -4.f*f1+ -4.f*f2+ -4.f*f3+ -4.f*f4+    f5+    f6+    f7+    f8+ -4.f*f9+    f10+      f11+    f12+    f13+ -4.f*f14+    f15+    f16+    f17+    f18;
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

f0 =(0.052631579f*rho                           +- 0.012531328f*(m1)+ 0.047619048f*(m2));
f1 =(0.052631579f*rho+  0.1f*u                  +-0.0045948204f*(m1)+-0.015873016f*(m2)+  -0.1f*(m4)                 + 0.055555556f*((m9)-m10));
f2 =(0.052631579f*rho         +  0.1f*v         +-0.0045948204f*(m1)+-0.015873016f*(m2)             +   -0.1f*(m6)   +-0.027777778f*((m9)-m10)+ 0.083333333f*((m11)-m12));
f3 =(0.052631579f*rho+ -0.1f*u                  +-0.0045948204f*(m1)+-0.015873016f*(m2)+   0.1f*(m4)                 + 0.055555556f*((m9)-m10));                                                                                         
f4 =(0.052631579f*rho         + -0.1f*v         +-0.0045948204f*(m1)+-0.015873016f*(m2)             +    0.1f*(m6)   +-0.027777778f*((m9)-m10)+ 0.083333333f*((m11)-m12));
f5 =(0.052631579f*rho+  0.1f*u+  0.1f*v         + 0.0033416876f*(m1)+ 0.003968254f*(m2)+ 0.025f*(m4+m6)              +0.013888889f*(m10)+0.041666667f*(m12)+0.125f*( m16-m17)+ (0.027777778f*(m9) +0.083333333f*(m11)+( 0.25f*(m13))));
f6 =(0.052631579f*rho+ -0.1f*u+  0.1f*v         + 0.0033416876f*(m1)+ 0.003968254f*(m2)+-0.025f*(m4-m6)              +0.013888889f*(m10)+0.041666667f*(m12)+0.125f*(-m16-m17)+ (0.027777778f*(m9) +0.083333333f*(m11)+(-0.25f*(m13))));
f7 =(0.052631579f*rho+ -0.1f*u+ -0.1f*v         + 0.0033416876f*(m1)+ 0.003968254f*(m2)+-0.025f*(m4+m6)              +0.013888889f*(m10)+0.041666667f*(m12)+0.125f*(-m16+m17)+ (0.027777778f*(m9) +0.083333333f*(m11)+( 0.25f*(m13))));
f8 =(0.052631579f*rho+  0.1f*u+ -0.1f*v         + 0.0033416876f*(m1)+ 0.003968254f*(m2)+ 0.025f*(m4-m6)              +0.013888889f*(m10)+0.041666667f*(m12)+0.125f*( m16+m17)+ (0.027777778f*(m9) +0.083333333f*(m11)+(-0.25f*(m13))));
f9 =(0.052631579f*rho                  +  0.1f*w+-0.0045948204f*(m1)+-0.015873016f*(m2)                +   -0.1f*(m8)+-0.027777778f*((m9)-m10)+-0.083333333f*((m11)-m12));                                       
f10=(0.052631579f*rho+  0.1f*u         +  0.1f*w+ 0.0033416876f*(m1)+ 0.003968254f*(m2)+ 0.025f*(m4+m8)              +0.013888889f*(m10)-0.041666667f*(m12)+0.125f*(-m16+m18)+ (0.027777778f*(m9) -0.083333333f*(m11)+( 0.25f*(m15))));
f11=(0.052631579f*rho         +  0.1f*v+  0.1f*w+ 0.0033416876f*(m1)+ 0.003968254f*(m2)             +  0.025f*(m6+m8)+0.125f*( m17-m18)-0.027777778f*(m10)+(-0.055555556f*(m9) +( 0.25f*(m14))));
f12=(0.052631579f*rho+ -0.1f*u         +  0.1f*w+ 0.0033416876f*(m1)+ 0.003968254f*(m2)+-0.025f*(m4-m8)              +0.013888889f*(m10)-0.041666667f*(m12)+0.125f*( m16+m18)+ (0.027777778f*(m9) -0.083333333f*(m11)+(-0.25f*(m15))));
f13=(0.052631579f*rho         + -0.1f*v+  0.1f*w+ 0.0033416876f*(m1)+ 0.003968254f*(m2)             + -0.025f*(m6-m8)+0.125f*(-m17-m18)-0.027777778f*(m10)+(-0.055555556f*(m9) +(-0.25f*(m14))));
f14=(0.052631579f*rho                  + -0.1f*w+-0.0045948204f*(m1)+-0.015873016f*(m2)                +    0.1f*(m8)+-0.027777778f*((m9)-m10)+-0.083333333f*((m11)-m12));                                      
f15=(0.052631579f*rho+  0.1f*u         + -0.1f*w+ 0.0033416876f*(m1)+ 0.003968254f*(m2)+ 0.025f*(m4-m8)              +0.013888889f*(m10)-0.041666667f*(m12)+0.125f*(-m16-m18)+ (0.027777778f*(m9) -0.083333333f*(m11)+(-0.25f*(m15))));
f16=(0.052631579f*rho         +  0.1f*v+ -0.1f*w+ 0.0033416876f*(m1)+ 0.003968254f*(m2)             +  0.025f*(m6-m8)+0.125f*( m17+m18)-0.027777778f*(m10)+(-0.055555556f*(m9) +(-0.25f*(m14))));
f17=(0.052631579f*rho+ -0.1f*u         + -0.1f*w+ 0.0033416876f*(m1)+ 0.003968254f*(m2)+-0.025f*(m4+m8)              +0.013888889f*(m10)-0.041666667f*(m12)+0.125f*( m16-m18)+ (0.027777778f*(m9) -0.083333333f*(m11)+( 0.25f*(m15))));
f18=(0.052631579f*rho         + -0.1f*v+ -0.1f*w+ 0.0033416876f*(m1)+ 0.003968254f*(m2)             + -0.025f*(m6+m8)+0.125f*(-m17+m18)-0.027777778f*(m10)+(-0.055555556f*(m9) +( 0.25f*(m14))));

        }


        //float Cs = 0.01f;
        //if(XDIM-x < 64.f)
        ////Cs = 0.01f+(x-64.f)/64.f*(x-64.f)/64.f*0.1f;
        //Cs = 0.01f*pow(2.f,((x-448.f)/16.f));

		if(MODEL == "MRT")
		mrt_collide_LES(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,omega,CS);
		else if(MODEL == "BGK")
		bgk_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,omega);

        if(VELAV == "YES"){
            if(t>=START_VELAV && t<START_VELFLUC){
                u_Av = uAv[j];
                v_Av = vAv[j];
        		vel_av(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,u_Av,v_Av,t);
                uAv[j] = u_Av;
                vAv[j] = v_Av;
            }
            else if(t>=START_VELFLUC){
                u_Av = uAv[j];
                v_Av = vAv[j];
                u_fluc = ufluc[j];
                v_fluc = vfluc[j];
        		vel_fluc(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,u_Av,v_Av,u_fluc,v_fluc,t);
                ufluc[j] = u_fluc;
                vfluc[j] = v_fluc;
                
            }
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

	syncthreads();
	if(check[0] == 1 && t>=STARTF && REFINEMENT == "NO"){
	//reduction for force
	int nTotalThreads = blockDim.x;
	while(nTotalThreads > 1){
		int halfPoint = (nTotalThreads >> 1);
		if(threadIdx.x < halfPoint){
			sumX[threadIdx.x] += sumX[threadIdx.x+halfPoint];
			sumY[threadIdx.x] += sumY[threadIdx.x+halfPoint];
			sumZ[threadIdx.x] += sumZ[threadIdx.x+halfPoint];
		}
		syncthreads();
		nTotalThreads = halfPoint;
	}
	if(threadIdx.x == 0){
		atomicAdd(&FX[t],sumX[0]);
		atomicAdd(&FY[t],sumY[0]);
		atomicAdd(&FZ[t],sumZ[0]);
	}
	}


//	}
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

//	if(REFINEMENT == "YES" && x > LRX0+1 && x < LRX0+(XLRDIM-1)*LRFACTOR-1 
//		&& y > LRY0+1 && y < LRY0+(YLRDIM-1)*LRFACTOR-1 && z > LRZ0+1 && z < LRZ0+(ZLRDIM-1)*LRFACTOR-1 ||
//		(x>XDIM-1)){
//	}
//	else{

	f0 = fA[j];
	f1 = fA[f_mem(1 ,x-1,y       ,z             ,pitch)];
	f3 = fA[f_mem(3 ,x+1,y       ,z             ,pitch)];
	f2 = fA[f_mem(2 ,x  ,y-1,z             ,pitch)];
	f5 = fA[f_mem(5 ,x-1,y-1,z             ,pitch)];
	f6 = fA[f_mem(6 ,x+1,y-1,z             ,pitch)];
	f4 = fA[f_mem(4 ,x  ,y+1,z             ,pitch)];
	f7 = fA[f_mem(7 ,x+1,y+1,z             ,pitch)];
	f8 = fA[f_mem(8 ,x-1,y+1,z             ,pitch)];
	f9 = fA[f_mem(9 ,x  ,y       ,z-1,pitch)];
	f10= fA[f_mem(10,x-1,y       ,z-1,pitch)];
	f11= fA[f_mem(11,x  ,y-1,z-1,pitch)];
	f12= fA[f_mem(12,x+1,y       ,z-1,pitch)];
	f13= fA[f_mem(13,x  ,y+1,z-1,pitch)];
	f14= fA[f_mem(14,x  ,y       ,z+1,pitch)];
	f15= fA[f_mem(15,x-1,y       ,z+1,pitch)];
	f16= fA[f_mem(16,x  ,y-1,z+1,pitch)];
	f17= fA[f_mem(17,x+1,y       ,z+1,pitch)];
	//f18= fA[f_mem(18,x  ,y+1,dmin(z+1,ZDIM),pitch)];
    if(z != ZDIM-1)
	f18= fA[f_mem(18,x  ,y+1,z+1,pitch)];

	if(im == 1 || im ==10){//BB
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

		boundaries(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,y,z,im);

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
//	}
}

__device__ __inline__ float ld_gb1_cg(const float *addr){
    float return_value;
    asm("ld.global.cg.f32 %0, [%1];" : "=f"(return_value) : "l"(addr));
    return return_value;
}




__global__ void initialize_single(float *f, size_t pitch)//pitch in elements
{
	int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
	int y = threadIdx.y+blockIdx.y*blockDim.y;
	int z = threadIdx.z+blockIdx.z*blockDim.z;
	int j = x+y*pitch+z*YDIM*pitch;//index on padded mem (pitch in elements)
	
	int im = ImageFcn(x,y,z);
	float u,v,w,rho,usqr;
	rho = 1.f;
	u = 0.0f;
	v = UMAX;
	w = 0.0f;

    if(im == 10 || im == 1){
    u = 0.0f;
    v = 0.0f;
    w = 0.0f;
    }
	//if(x == 3 ) u = 0.1f;
	usqr = u*u+v*v+w*w;

    if(MODEL == "BGK"){ 
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
	f[j+11*pitch*YDIM*ZDIM]= 1.0f/36.0f*(rho+3.0f*(v+w)+4.5f*(v+w)*(v+w)-1.5f*usqr);
	f[j+12*pitch*YDIM*ZDIM]= 1.0f/36.0f*(rho+3.0f*(-u+w)+4.5f*(-u+w)*(-u+w)-1.5f*usqr);
	f[j+13*pitch*YDIM*ZDIM]= 1.0f/36.0f*(rho+3.0f*(-v+w)+4.5f*(-v+w)*(-v+w)-1.5f*usqr);
	f[j+14*pitch*YDIM*ZDIM]= 1.0f/18.0f*(rho-3.0f*w+4.5f*w*w-1.5f*usqr);
	f[j+15*pitch*YDIM*ZDIM]= 1.0f/36.0f*(rho+3.0f*(u-w)+4.5f*(u-w)*(u-w)-1.5f*usqr);
	f[j+16*pitch*YDIM*ZDIM]= 1.0f/36.0f*(rho+3.0f*(v-w)+4.5f*(v-w)*(v-w)-1.5f*usqr);
	f[j+17*pitch*YDIM*ZDIM]= 1.0f/36.0f*(rho+3.0f*(-u-w)+4.5f*(-u-w)*(-u-w)-1.5f*usqr);
	f[j+18*pitch*YDIM*ZDIM]= 1.0f/36.0f*(rho+3.0f*(-v-w)+4.5f*(-v-w)*(-v-w)-1.5f*usqr);   
    }
    else{
                                                                                                                
float f0 = 0.1904761791f*rho+-0.597127747f*usqr                                                 ;
float f1 = 0.1031746045f*rho+ 0.032375918f*usqr+  0.1666666667f*u                                                   ;
float f2 = 0.1031746045f*rho+ 0.032375918f*usqr+  0.1666666667f*v                       ;
float f3 = 0.1031746045f*rho+ 0.032375918f*usqr+ -0.1666666667f*u                                                   ;
float f4 = 0.1031746045f*rho+ 0.032375918f*usqr+ -0.1666666667f*v                       ;
float f5 = 0.0158730149f*rho+ 0.033572690f*usqr+  0.083333333f*( u+v)                            ;
float f6 = 0.0158730149f*rho+ 0.033572690f*usqr+ -0.083333333f*( u-v)                            ;
float f7 = 0.0158730149f*rho+ 0.033572690f*usqr+ -0.083333333f*( u+v)                            ;
float f8 = 0.0158730149f*rho+ 0.033572690f*usqr+  0.083333333f*( u-v)                            ;
float f9 = 0.1031746045f*rho+ 0.032375918f*usqr+  0.1666666667f*w;
float f10= 0.0158730149f*rho+ 0.033572690f*usqr+  0.083333333f*( u+w)                                 ;
float f11= 0.0158730149f*rho+ 0.033572690f*usqr+  0.083333333f*( v+w);
float f12= 0.0158730149f*rho+ 0.033572690f*usqr+ -0.083333333f*( u-w)                            ;
float f13= 0.0158730149f*rho+ 0.033572690f*usqr+ -0.083333333f*( v-w);
float f14= 0.1031746045f*rho+ 0.032375918f*usqr+ -0.1666666667f*w;
float f15= 0.0158730149f*rho+ 0.033572690f*usqr+  0.083333333f*(u-w)                            ;
float f16= 0.0158730149f*rho+ 0.033572690f*usqr+  0.083333333f*(v-w);
float f17= 0.0158730149f*rho+ 0.033572690f*usqr+ -0.083333333f*(u+w)                            ;
float f18= 0.0158730149f*rho+ 0.033572690f*usqr+ -0.083333333f*(v+w);

f1 +=  0.055555556f*(2.f*u*u-(v*v+w*w));
f2 += -0.027777778f*(2.f*u*u-(v*v+w*w))+  0.083333333f*(v*v-w*w);
f3 +=  0.055555556f*(2.f*u*u-(v*v+w*w));
f4 += -0.027777778f*(2.f*u*u-(v*v+w*w))+  0.083333333f*(v*v-w*w);
f5 +=  0.027777778f*(2.f*u*u-(v*v+w*w))+  0.083333333f*(v*v-w*w)+  0.25f*u*v                              ;
f6 +=  0.027777778f*(2.f*u*u-(v*v+w*w))+  0.083333333f*(v*v-w*w)+ -0.25f*u*v                              ;
f7 +=  0.027777778f*(2.f*u*u-(v*v+w*w))+  0.083333333f*(v*v-w*w)+  0.25f*u*v                              ;
f8 +=  0.027777778f*(2.f*u*u-(v*v+w*w))+  0.083333333f*(v*v-w*w)+ -0.25f*u*v                              ;
f9 += -0.027777778f*(2.f*u*u-(v*v+w*w))+ -0.083333333f*(v*v-w*w)                                            ;
f10+=  0.027777778f*(2.f*u*u-(v*v+w*w))+ -0.083333333f*(v*v-w*w)                              +  0.25f*u*w;
f11+= -0.055555556f*(2.f*u*u-(v*v+w*w))                                      +  0.25f*v*w             ;
f12+=  0.027777778f*(2.f*u*u-(v*v+w*w))+ -0.083333333f*(v*v-w*w)                              + -0.25f*u*w;
f13+= -0.055555556f*(2.f*u*u-(v*v+w*w))                                        -0.25f*v*w             ;
f14+= -0.027777778f*(2.f*u*u-(v*v+w*w))+ -0.083333333f*(v*v-w*w)                                            ;
f15+=  0.027777778f*(2.f*u*u-(v*v+w*w))+ -0.083333333f*(v*v-w*w)                              + -0.25f*u*w;
f16+= -0.055555556f*(2.f*u*u-(v*v+w*w))                                      + -0.25f*v*w             ;
f17+=  0.027777778f*(2.f*u*u-(v*v+w*w))+ -0.083333333f*(v*v-w*w)                              +  0.25f*u*w;
f18+= -0.055555556f*(2.f*u*u-(v*v+w*w))                                      +  0.25f*v*w                 ;

f[j+0 *pitch*YDIM*ZDIM]=f0 ;
f[j+1 *pitch*YDIM*ZDIM]=f1 ;
f[j+2 *pitch*YDIM*ZDIM]=f2 ;
f[j+3 *pitch*YDIM*ZDIM]=f3 ;
f[j+4 *pitch*YDIM*ZDIM]=f4 ;
f[j+5 *pitch*YDIM*ZDIM]=f5 ;
f[j+6 *pitch*YDIM*ZDIM]=f6 ;
f[j+7 *pitch*YDIM*ZDIM]=f7 ;
f[j+8 *pitch*YDIM*ZDIM]=f8 ;
f[j+9 *pitch*YDIM*ZDIM]=f9 ;
f[j+10*pitch*YDIM*ZDIM]=f10;
f[j+11*pitch*YDIM*ZDIM]=f11;
f[j+12*pitch*YDIM*ZDIM]=f12;
f[j+13*pitch*YDIM*ZDIM]=f13;
f[j+14*pitch*YDIM*ZDIM]=f14;
f[j+15*pitch*YDIM*ZDIM]=f15;
f[j+16*pitch*YDIM*ZDIM]=f16;
f[j+17*pitch*YDIM*ZDIM]=f17;
f[j+18*pitch*YDIM*ZDIM]=f18;

    }


	if(x == XDIM-1){
	for(int i = XDIM; i<pitch; i++){
		j = i+y*pitch+z*YDIM*pitch;//index on padded mem (pitch in elements)
		f[j+0 *pitch*YDIM*ZDIM]=0.f;
		f[j+1 *pitch*YDIM*ZDIM]=0.f;
		f[j+2 *pitch*YDIM*ZDIM]=0.f;
		f[j+3 *pitch*YDIM*ZDIM]=0.f;
		f[j+4 *pitch*YDIM*ZDIM]=0.f;
		f[j+5 *pitch*YDIM*ZDIM]=0.f;
		f[j+6 *pitch*YDIM*ZDIM]=0.f;
		f[j+7 *pitch*YDIM*ZDIM]=0.f;
		f[j+8 *pitch*YDIM*ZDIM]=0.f;
		f[j+9 *pitch*YDIM*ZDIM]=0.f;
		f[j+10*pitch*YDIM*ZDIM]=0.f;
		f[j+11*pitch*YDIM*ZDIM]=0.f;
		f[j+12*pitch*YDIM*ZDIM]=0.f;
		f[j+13*pitch*YDIM*ZDIM]=0.f;
		f[j+14*pitch*YDIM*ZDIM]=0.f;
		f[j+15*pitch*YDIM*ZDIM]=0.f;
		f[j+16*pitch*YDIM*ZDIM]=0.f;
		f[j+17*pitch*YDIM*ZDIM]=0.f;
		f[j+18*pitch*YDIM*ZDIM]=0.f;
	}
	}
}
__global__ void initialize_LR(float *f, size_t pitch)//pitch in elements
{
	int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
	int y = threadIdx.y+blockIdx.y*blockDim.y;
	int z = threadIdx.z+blockIdx.z*blockDim.z;
	int j = x+y*pitch+z*YLRDIM*pitch;//index on padded mem (pitch in elements)
	float xcoord = LRX0+x*LRFACTOR;
	float ycoord = LRY0+y*LRFACTOR;
	float zcoord = LRZ0+z*LRFACTOR;
	int im = ImageFcn(xcoord,ycoord,zcoord);
	
	float u,v,w,rho,usqr;
	rho = 1.f;
	u = 0.0f;
	v = UMAX;//0.0f;
	w = 0.0f;
    if(im == 10 || im == 1){
    u = 0.0f;
    v = 0.0f;
    w = 0.0f;
    }
	//if(x == 3 ) u = 0.1f;
	usqr = u*u+v*v+w*w;

    if(MODEL == "BGK"){ 
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
	f[j+11*pitch*YLRDIM*ZLRDIM]= 1.0f/36.0f*(rho+3.0f*(v+w)+4.5f*(v+w)*(v+w)-1.5f*usqr);
	f[j+12*pitch*YLRDIM*ZLRDIM]= 1.0f/36.0f*(rho+3.0f*(-u+w)+4.5f*(-u+w)*(-u+w)-1.5f*usqr);
	f[j+13*pitch*YLRDIM*ZLRDIM]= 1.0f/36.0f*(rho+3.0f*(-v+w)+4.5f*(-v+w)*(-v+w)-1.5f*usqr);
	f[j+14*pitch*YLRDIM*ZLRDIM]= 1.0f/18.0f*(rho-3.0f*w+4.5f*w*w-1.5f*usqr);
	f[j+15*pitch*YLRDIM*ZLRDIM]= 1.0f/36.0f*(rho+3.0f*(u-w)+4.5f*(u-w)*(u-w)-1.5f*usqr);
	f[j+16*pitch*YLRDIM*ZLRDIM]= 1.0f/36.0f*(rho+3.0f*(v-w)+4.5f*(v-w)*(v-w)-1.5f*usqr);
	f[j+17*pitch*YLRDIM*ZLRDIM]= 1.0f/36.0f*(rho+3.0f*(-u-w)+4.5f*(-u-w)*(-u-w)-1.5f*usqr);
	f[j+18*pitch*YLRDIM*ZLRDIM]= 1.0f/36.0f*(rho+3.0f*(-v-w)+4.5f*(-v-w)*(-v-w)-1.5f*usqr);   
    }
    else{
                                                                                                                
float f0 = 0.1904761791f*rho+-0.597127747f*usqr                                                 ;
float f1 = 0.1031746045f*rho+ 0.032375918f*usqr+  0.1666666667f*u                                                   ;
float f2 = 0.1031746045f*rho+ 0.032375918f*usqr+  0.1666666667f*v                       ;
float f3 = 0.1031746045f*rho+ 0.032375918f*usqr+ -0.1666666667f*u                                                   ;
float f4 = 0.1031746045f*rho+ 0.032375918f*usqr+ -0.1666666667f*v                       ;
float f5 = 0.0158730149f*rho+ 0.033572690f*usqr+  0.083333333f*( u+v)                            ;
float f6 = 0.0158730149f*rho+ 0.033572690f*usqr+ -0.083333333f*( u-v)                            ;
float f7 = 0.0158730149f*rho+ 0.033572690f*usqr+ -0.083333333f*( u+v)                            ;
float f8 = 0.0158730149f*rho+ 0.033572690f*usqr+  0.083333333f*( u-v)                            ;
float f9 = 0.1031746045f*rho+ 0.032375918f*usqr+  0.1666666667f*w;
float f10= 0.0158730149f*rho+ 0.033572690f*usqr+  0.083333333f*( u+w)                                 ;
float f11= 0.0158730149f*rho+ 0.033572690f*usqr+  0.083333333f*( v+w);
float f12= 0.0158730149f*rho+ 0.033572690f*usqr+ -0.083333333f*( u-w)                            ;
float f13= 0.0158730149f*rho+ 0.033572690f*usqr+ -0.083333333f*( v-w);
float f14= 0.1031746045f*rho+ 0.032375918f*usqr+ -0.1666666667f*w;
float f15= 0.0158730149f*rho+ 0.033572690f*usqr+  0.083333333f*(u-w)                            ;
float f16= 0.0158730149f*rho+ 0.033572690f*usqr+  0.083333333f*(v-w);
float f17= 0.0158730149f*rho+ 0.033572690f*usqr+ -0.083333333f*(u+w)                            ;
float f18= 0.0158730149f*rho+ 0.033572690f*usqr+ -0.083333333f*(v+w);

f1 +=  0.055555556f*(2.f*u*u-(v*v+w*w));
f2 += -0.027777778f*(2.f*u*u-(v*v+w*w))+  0.083333333f*(v*v-w*w);
f3 +=  0.055555556f*(2.f*u*u-(v*v+w*w));
f4 += -0.027777778f*(2.f*u*u-(v*v+w*w))+  0.083333333f*(v*v-w*w);
f5 +=  0.027777778f*(2.f*u*u-(v*v+w*w))+  0.083333333f*(v*v-w*w)+  0.25f*u*v                              ;
f6 +=  0.027777778f*(2.f*u*u-(v*v+w*w))+  0.083333333f*(v*v-w*w)+ -0.25f*u*v                              ;
f7 +=  0.027777778f*(2.f*u*u-(v*v+w*w))+  0.083333333f*(v*v-w*w)+  0.25f*u*v                              ;
f8 +=  0.027777778f*(2.f*u*u-(v*v+w*w))+  0.083333333f*(v*v-w*w)+ -0.25f*u*v                              ;
f9 += -0.027777778f*(2.f*u*u-(v*v+w*w))+ -0.083333333f*(v*v-w*w)                                            ;
f10+=  0.027777778f*(2.f*u*u-(v*v+w*w))+ -0.083333333f*(v*v-w*w)                              +  0.25f*u*w;
f11+= -0.055555556f*(2.f*u*u-(v*v+w*w))                                      +  0.25f*v*w             ;
f12+=  0.027777778f*(2.f*u*u-(v*v+w*w))+ -0.083333333f*(v*v-w*w)                              + -0.25f*u*w;
f13+= -0.055555556f*(2.f*u*u-(v*v+w*w))                                        -0.25f*v*w             ;
f14+= -0.027777778f*(2.f*u*u-(v*v+w*w))+ -0.083333333f*(v*v-w*w)                                            ;
f15+=  0.027777778f*(2.f*u*u-(v*v+w*w))+ -0.083333333f*(v*v-w*w)                              + -0.25f*u*w;
f16+= -0.055555556f*(2.f*u*u-(v*v+w*w))                                      + -0.25f*v*w             ;
f17+=  0.027777778f*(2.f*u*u-(v*v+w*w))+ -0.083333333f*(v*v-w*w)                              +  0.25f*u*w;
f18+= -0.055555556f*(2.f*u*u-(v*v+w*w))                                      +  0.25f*v*w                 ;

f[j+0 *pitch*YLRDIM*ZLRDIM]=f0 ;
f[j+1 *pitch*YLRDIM*ZLRDIM]=f1 ;
f[j+2 *pitch*YLRDIM*ZLRDIM]=f2 ;
f[j+3 *pitch*YLRDIM*ZLRDIM]=f3 ;
f[j+4 *pitch*YLRDIM*ZLRDIM]=f4 ;
f[j+5 *pitch*YLRDIM*ZLRDIM]=f5 ;
f[j+6 *pitch*YLRDIM*ZLRDIM]=f6 ;
f[j+7 *pitch*YLRDIM*ZLRDIM]=f7 ;
f[j+8 *pitch*YLRDIM*ZLRDIM]=f8 ;
f[j+9 *pitch*YLRDIM*ZLRDIM]=f9 ;
f[j+10*pitch*YLRDIM*ZLRDIM]=f10;
f[j+11*pitch*YLRDIM*ZLRDIM]=f11;
f[j+12*pitch*YLRDIM*ZLRDIM]=f12;
f[j+13*pitch*YLRDIM*ZLRDIM]=f13;
f[j+14*pitch*YLRDIM*ZLRDIM]=f14;
f[j+15*pitch*YLRDIM*ZLRDIM]=f15;
f[j+16*pitch*YLRDIM*ZLRDIM]=f16;
f[j+17*pitch*YLRDIM*ZLRDIM]=f17;
f[j+18*pitch*YLRDIM*ZLRDIM]=f18;

    }



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

	//int *image_d, *image_h;

	ofstream output;
	ofstream output2;
	string FileName = CASENAME;
	//output.open ("LBM1_out.dat");
	output.open ((FileName+".dat").c_str());
	output2.open ((FileName+".force").c_str());

	size_t memsize, memsize2;
	size_t pitch = 0;
	size_t pitch2 = 0;
	int i, n, nBlocks, nBlocks2, n2;
	float omega, CharLength, omega2;

	if(abs(LRFACTOR-1.f/LRLEVEL)>0.001f){
		cout<<"LRLEVEL and LRFACTOR don't match! Exiting..."<<endl;
		return 0;
	}

	CharLength = OBSTR1*2.f;

	omega = 1.0f/(3.0f*(UMAX*CharLength/RE)+0.5f);
	omega2 = 2.0f/(1.0f+2.0f*(2.0f/omega-1.0f));
	if(LRFACTOR == 0.25f){
	omega2 = 2.0f/(1.0f+2.0f*(2.0f/omega2-1.0f));
	}
	float SF_cf = omega*(1.0f-omega2)/((1.0f-omega)*omega2/LRFACTOR);
	//float SF_fc = 1.f/SF_cf;

	cout<<"omega : "<<omega<<endl;
	cout<<"omega2: "<<omega2<<endl;
	cout<<"blocksize: "<<BLOCKSIZEX<<"x"<<BLOCKSIZEY<<"x"<<BLOCKSIZEZ<<endl;
	cout<<"grid: "<<XDIM<<"x"<<YDIM<<"x"<<ZDIM<<endl;
	cout<<"LRblocksize: "<<BLOCKSIZELRX<<"x"<<BLOCKSIZELRY<<"x"<<BLOCKSIZELRZ<<endl;
	cout<<"LRgrid: "<<XLRDIM<<"x"<<YLRDIM<<"x"<<ZLRDIM<<endl;
	cout<<"TMAX: "<<TMAX<<endl;
	cout<<"Method: "<<METHOD<<endl;
	cout<<"Model: "<<MODEL<<endl;

	nBlocks = ((XDIM+BLOCKSIZEX-1)/BLOCKSIZEX)*(YDIM/BLOCKSIZEY+YDIM%BLOCKSIZEY)
				*(ZDIM/BLOCKSIZEZ+ZDIM%BLOCKSIZEZ);
	nBlocks2 = (XLRDIM/BLOCKSIZELRX+XLRDIM%BLOCKSIZELRX)*(YLRDIM/BLOCKSIZELRY+YLRDIM%BLOCKSIZELRY)
				*(ZLRDIM/BLOCKSIZELRZ+ZLRDIM%BLOCKSIZELRZ);
	int B = BLOCKSIZEX*BLOCKSIZEY*BLOCKSIZEZ;
	int B2 = BLOCKSIZELRX*BLOCKSIZELRY*BLOCKSIZELRZ;
	n = nBlocks*B;
	n2 = nBlocks2*B2;
	cout<<"nBlocks:"<<nBlocks<<endl;

    dim3 threads(BLOCKSIZEX, BLOCKSIZEY, BLOCKSIZEZ);
    dim3 grid(((XDIM+BLOCKSIZEX-1)/BLOCKSIZEX),YDIM/BLOCKSIZEY,ZDIM/BLOCKSIZEZ);

    dim3 threads2(BLOCKSIZELRX, BLOCKSIZELRY, BLOCKSIZELRZ);
    dim3 grid2(XLRDIM/BLOCKSIZELRX,YLRDIM/BLOCKSIZELRY,ZLRDIM/BLOCKSIZELRZ);

	memsize = n*sizeof(float);
	//memsize_int = n*sizeof(int);
	memsize2 = n2*sizeof(float);

	//cudaExtent extent = make_cudaExtent(XDIM*sizeof(float),YDIM,ZDIM);

	//image_h = (int *)malloc(memsize_int);

	float *fA_h,*fA_d,*fB_d,*fC_h,*fC_d,*fD_d;
	float *FX_h,*FY_h,*FZ_h,*FX_d,*FY_d,*FZ_d;
	float *uAv_h,*vAv_h,*wAv_h,*uAv_d,*vAv_d,*wAv_d;
	float *uAvLR_h,*vAvLR_h,*wAvLR_h,*uAvLR_d,*vAvLR_d,*wAvLR_d;
	float *ufluc_h,*vfluc_h,*wfluc_h,*ufluc_d,*vfluc_d,*wfluc_d;
	float *uflucLR_h,*vflucLR_h,*wflucLR_h,*uflucLR_d,*vflucLR_d,*wflucLR_d;
	fA_h = (float *)malloc(memsize*19);
	fC_h = (float *)malloc(memsize2*19);
	FX_h = (float *)malloc(TMAX*sizeof(float));
	FY_h = (float *)malloc(TMAX*sizeof(float));
	FZ_h = (float *)malloc(TMAX*sizeof(float));
	uAv_h = (float *)malloc(XDIM*YDIM*ZDIM*sizeof(float));
	vAv_h = (float *)malloc(XDIM*YDIM*ZDIM*sizeof(float));
	wAv_h = (float *)malloc(XDIM*YDIM*ZDIM*sizeof(float));
	uAvLR_h = (float *)malloc(XLRDIM*YLRDIM*ZLRDIM*sizeof(float));
	vAvLR_h = (float *)malloc(XLRDIM*YLRDIM*ZLRDIM*sizeof(float));
	wAvLR_h = (float *)malloc(XLRDIM*YLRDIM*ZLRDIM*sizeof(float));
	ufluc_h = (float *)malloc(XDIM*YDIM*ZDIM*sizeof(float));
	vfluc_h = (float *)malloc(XDIM*YDIM*ZDIM*sizeof(float));
	wfluc_h = (float *)malloc(XDIM*YDIM*ZDIM*sizeof(float));
	uflucLR_h = (float *)malloc(XLRDIM*YLRDIM*ZLRDIM*sizeof(float));
	vflucLR_h = (float *)malloc(XLRDIM*YLRDIM*ZLRDIM*sizeof(float));
	wflucLR_h = (float *)malloc(XLRDIM*YLRDIM*ZLRDIM*sizeof(float));
	cudaMallocPitch((void **) &fA_d, &pitch, XDIM*sizeof(float), YDIM*ZDIM*19);
	cudaMallocPitch((void **) &fB_d, &pitch, XDIM*sizeof(float), YDIM*ZDIM*19);
	cudaMallocPitch((void **) &uAv_d,&pitch, XDIM*sizeof(float), YDIM*ZDIM);
	cudaMallocPitch((void **) &vAv_d,&pitch, XDIM*sizeof(float), YDIM*ZDIM);
	cudaMallocPitch((void **) &wAv_d,&pitch, XDIM*sizeof(float), YDIM*ZDIM);
	cudaMallocPitch((void **) &ufluc_d,&pitch, XDIM*sizeof(float), YDIM*ZDIM);
	cudaMallocPitch((void **) &vfluc_d,&pitch, XDIM*sizeof(float), YDIM*ZDIM);
	cudaMallocPitch((void **) &wfluc_d,&pitch, XDIM*sizeof(float), YDIM*ZDIM);

	if(REFINEMENT == "YES"){
	cudaMallocPitch((void **) &fC_d, &pitch2, XLRDIM*sizeof(float), YLRDIM*ZLRDIM*19);
	cudaMallocPitch((void **) &fD_d, &pitch2, XLRDIM*sizeof(float), YLRDIM*ZLRDIM*19);
    if(VELAV == "YES"){
	cudaMallocPitch((void **) &uAvLR_d,&pitch2, XLRDIM*sizeof(float), YLRDIM*ZLRDIM);
	cudaMallocPitch((void **) &vAvLR_d,&pitch2, XLRDIM*sizeof(float), YLRDIM*ZLRDIM);
	cudaMallocPitch((void **) &wAvLR_d,&pitch2, XLRDIM*sizeof(float), YLRDIM*ZLRDIM);
	cudaMallocPitch((void **) &uflucLR_d,&pitch2, XLRDIM*sizeof(float), YLRDIM*ZLRDIM);
	cudaMallocPitch((void **) &vflucLR_d,&pitch2, XLRDIM*sizeof(float), YLRDIM*ZLRDIM);
	cudaMallocPitch((void **) &wflucLR_d,&pitch2, XLRDIM*sizeof(float), YLRDIM*ZLRDIM);
	}
	}

	cudaMalloc((void **) &FX_d, TMAX*sizeof(float));
	cudaMalloc((void **) &FY_d, TMAX*sizeof(float));
	cudaMalloc((void **) &FZ_d, TMAX*sizeof(float));

	cout<<pitch<<", "<<pitch2<<endl;
	
	size_t pitch_elements = pitch/sizeof(float);
	size_t pitch_elements2 = pitch2/sizeof(float);

	cudaChannelFormatDesc desc = cudaCreateChannelDesc<float>();
	for (i = 0; i < n*19; i++)
	{
		fA_h[i] = i;
	}
	for (i = 0; i < n2*19; i++)
	{
		fC_h[i] = 0;
	}
	for (i = 0; i < TMAX; i++){
		FX_h[i] = 0.f;
		FY_h[i] = 0.f;
		FZ_h[i] = 0.f;
	}
	for (i = 0; i < n; i++)
	{
		uAv_h[i] = 0;
		vAv_h[i] = 0;
		wAv_h[i] = 0;
		ufluc_h[i] = 0;
		vfluc_h[i] = 0;
		wfluc_h[i] = 0;
	}
	for (i = 0; i < n2; i++)
	{
		uAvLR_h[i] = 0;
		vAvLR_h[i] = 0;
		wAvLR_h[i] = 0;
		uflucLR_h[i] = 0;
		vflucLR_h[i] = 0;
		wflucLR_h[i] = 0;
	}

	cudaMemcpy(FX_d, FX_h, TMAX*sizeof(float), cudaMemcpyHostToDevice);
	cudaMemcpy(FY_d, FY_h, TMAX*sizeof(float), cudaMemcpyHostToDevice);
	cudaMemcpy(FZ_d, FZ_h, TMAX*sizeof(float), cudaMemcpyHostToDevice);
    if(VELAV == "YES"){
	cudaMemcpy2D(uAv_d,   pitch, uAv_h, XDIM*sizeof(float), XDIM*sizeof(float), YDIM*ZDIM, cudaMemcpyHostToDevice);
	cudaMemcpy2D(vAv_d,   pitch, vAv_h, XDIM*sizeof(float), XDIM*sizeof(float), YDIM*ZDIM, cudaMemcpyHostToDevice);
	cudaMemcpy2D(wAv_d,   pitch, wAv_h, XDIM*sizeof(float), XDIM*sizeof(float), YDIM*ZDIM, cudaMemcpyHostToDevice);
	cudaMemcpy2D(ufluc_d, pitch, uAv_h, XDIM*sizeof(float), XDIM*sizeof(float), YDIM*ZDIM, cudaMemcpyHostToDevice);
	cudaMemcpy2D(vfluc_d, pitch, vAv_h, XDIM*sizeof(float), XDIM*sizeof(float), YDIM*ZDIM, cudaMemcpyHostToDevice);
	cudaMemcpy2D(wfluc_d, pitch, wAv_h, XDIM*sizeof(float), XDIM*sizeof(float), YDIM*ZDIM, cudaMemcpyHostToDevice);
    if(REFINEMENT == "YES"){
	cudaMemcpy2D(uAvLR_d,  pitch2, uAvLR_h, XLRDIM*sizeof(float), XLRDIM*sizeof(float), YLRDIM*ZLRDIM, cudaMemcpyHostToDevice);
	cudaMemcpy2D(vAvLR_d,  pitch2, vAvLR_h, XLRDIM*sizeof(float), XLRDIM*sizeof(float), YLRDIM*ZLRDIM, cudaMemcpyHostToDevice);
	cudaMemcpy2D(wAvLR_d,  pitch2, wAvLR_h, XLRDIM*sizeof(float), XLRDIM*sizeof(float), YLRDIM*ZLRDIM, cudaMemcpyHostToDevice);
	cudaMemcpy2D(uflucLR_d,pitch2, uAvLR_h, XLRDIM*sizeof(float), XLRDIM*sizeof(float), YLRDIM*ZLRDIM, cudaMemcpyHostToDevice);
	cudaMemcpy2D(vflucLR_d,pitch2, vAvLR_h, XLRDIM*sizeof(float), XLRDIM*sizeof(float), YLRDIM*ZLRDIM, cudaMemcpyHostToDevice);
	cudaMemcpy2D(wflucLR_d,pitch2, wAvLR_h, XLRDIM*sizeof(float), XLRDIM*sizeof(float), YLRDIM*ZLRDIM, cudaMemcpyHostToDevice);
    }
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

	for(int i = 0; i<2; i++){
	texRef_f0A.addressMode[i]  = cudaAddressModeClamp;
	texRef_f1A.addressMode[i]  = cudaAddressModeClamp;
	texRef_f2A.addressMode[i]  = cudaAddressModeClamp;
	texRef_f3A.addressMode[i]  = cudaAddressModeClamp;
	texRef_f4A.addressMode[i]  = cudaAddressModeClamp;
	texRef_f5A.addressMode[i]  = cudaAddressModeClamp;
	texRef_f6A.addressMode[i]  = cudaAddressModeClamp;
	texRef_f7A.addressMode[i]  = cudaAddressModeClamp;
	texRef_f8A.addressMode[i]  = cudaAddressModeClamp;
	texRef_f9A.addressMode[i]  = cudaAddressModeClamp;
	texRef_f10A.addressMode[i] = cudaAddressModeClamp;
	texRef_f11A.addressMode[i] = cudaAddressModeClamp;
	texRef_f12A.addressMode[i] = cudaAddressModeClamp;
	texRef_f13A.addressMode[i] = cudaAddressModeClamp;
	texRef_f14A.addressMode[i] = cudaAddressModeClamp;
	texRef_f15A.addressMode[i] = cudaAddressModeClamp;
	texRef_f16A.addressMode[i] = cudaAddressModeClamp;
	texRef_f17A.addressMode[i] = cudaAddressModeClamp;
	texRef_f18A.addressMode[i] = cudaAddressModeClamp;
	texRef_f0B.addressMode[i]  = cudaAddressModeClamp;
	texRef_f1B.addressMode[i]  = cudaAddressModeClamp;
	texRef_f2B.addressMode[i]  = cudaAddressModeClamp;
	texRef_f3B.addressMode[i]  = cudaAddressModeClamp;
	texRef_f4B.addressMode[i]  = cudaAddressModeClamp;
	texRef_f5B.addressMode[i]  = cudaAddressModeClamp;
	texRef_f6B.addressMode[i]  = cudaAddressModeClamp;
	texRef_f7B.addressMode[i]  = cudaAddressModeClamp;
	texRef_f8B.addressMode[i]  = cudaAddressModeClamp;
	texRef_f9B.addressMode[i]  = cudaAddressModeClamp;
	texRef_f10B.addressMode[i] = cudaAddressModeClamp;
	texRef_f11B.addressMode[i] = cudaAddressModeClamp;
	texRef_f12B.addressMode[i] = cudaAddressModeClamp;
	texRef_f13B.addressMode[i] = cudaAddressModeClamp;
	texRef_f14B.addressMode[i] = cudaAddressModeClamp;
	texRef_f15B.addressMode[i] = cudaAddressModeClamp;
	texRef_f16B.addressMode[i] = cudaAddressModeClamp;
	texRef_f17B.addressMode[i] = cudaAddressModeClamp;
	texRef_f18B.addressMode[i] = cudaAddressModeClamp;
	}

	}
	
	cudaMemcpy2D(fA_d,pitch ,fA_h,XDIM*sizeof(float),XDIM*sizeof(float),YDIM*ZDIM*19,cudaMemcpyHostToDevice);
	cudaMemcpy2D(fB_d,pitch ,fA_h,XDIM*sizeof(float),XDIM*sizeof(float),YDIM*ZDIM*19,cudaMemcpyHostToDevice);
	if(REFINEMENT == "YES"){
	cudaMemcpy2D(fC_d,pitch2,fC_h,XLRDIM*sizeof(float),XLRDIM*sizeof(float),YLRDIM*ZLRDIM*19,cudaMemcpyHostToDevice);
	cudaMemcpy2D(fD_d,pitch2,fC_h,XLRDIM*sizeof(float),XLRDIM*sizeof(float),YLRDIM*ZLRDIM*19,cudaMemcpyHostToDevice);
	}
//	for (i = 0; i < n*19; i++)
//	{
//		fA_h[i] = 0;
//		fC_h[i] = 1;
//	}


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
	initialize_LR<<<grid2, threads2>>>(fD_d,pitch_elements2);
	}

	cudaFuncSetCacheConfig(mrt_d_single,cudaFuncCachePreferL1);
	cudaFuncSetCacheConfig(LR_d_ABCD_force,cudaFuncCachePreferL1);
	cudaFuncSetCacheConfig(LR_d_ABCD,cudaFuncCachePreferL1);
	cudaFuncSetCacheConfig(LR_d_ABCD2,cudaFuncCachePreferL1);
	cudaFuncSetCacheConfig(LR_d_ABDC2,cudaFuncCachePreferL1);
	cudaFuncSetCacheConfig(LR_d_ABDC_Interp,cudaFuncCachePreferL1);
	cudaFuncSetCacheConfig(LR_d_BACD_force,cudaFuncCachePreferL1);
	cudaFuncSetCacheConfig(LR_d_BACD,cudaFuncCachePreferL1);
	cudaFuncSetCacheConfig(LR_d_BADC2,cudaFuncCachePreferL1);
	cudaFuncSetCacheConfig(LR_d_BADC_Interp,cudaFuncCachePreferL1);

	cudaFuncSetCacheConfig(ExtractFromC_d,cudaFuncCachePreferL1);

	cudaFuncSetCacheConfig(simple_copy,cudaFuncCachePreferL1);

	struct timeval tdr0,tdr1;
	double restime;
	cudaDeviceSynchronize();
	gettimeofday (&tdr0,NULL);
	for(int t = 0; t<TMAX; t=t+2){
		if(METHOD == "SINGLE"){
		if(t >= STARTF)
		mrt_d_single_force<<<grid, threads>>>(fA_d,fB_d,omega,pitch_elements,FX_d,FY_d,FZ_d,t,uAv_d,vAv_d,ufluc_d,vfluc_d);
		else
		mrt_d_single<<<grid, threads>>>(fA_d,fB_d,omega,pitch_elements);
		
		if(REFINEMENT == "YES"){
			if(LRFACTOR == 0.5f)
			{
			if(t >= STARTF)
			LR_d_ABCD_force<<<grid2, threads2>>>(fC_d,fD_d,omega2,pitch_elements2,FX_d,FY_d,FZ_d,t,uAvLR_d,vAvLR_d,uflucLR_d,vflucLR_d);
			else
			LR_d_ABCD<<<grid2, threads2>>>(fC_d,fD_d,omega2,pitch_elements2,t,uAvLR_d,vAvLR_d,uflucLR_d,vflucLR_d);
			//LR_d_ABDC<<<grid2, threads2>>>(fD_d,fC_d,omega2,pitch_elements2,SF_cf);
			LR_d_ABDC_Interp<<<grid2, threads2>>>(fD_d,fC_d,omega2,pitch_elements2,SF_cf,t,uAvLR_d,vAvLR_d,uflucLR_d,vflucLR_d);
			}
			else if(LRFACTOR == 0.25f)
			{
			if(t >= STARTF)
			LR_d_ABCD_force<<<grid2, threads2>>>(fC_d,fD_d,omega2,pitch_elements2,FX_d,FY_d,FZ_d,t,uAvLR_d,vAvLR_d,uflucLR_d,vflucLR_d);
			else
			LR_d_ABCD<<<grid2, threads2>>>(fC_d,fD_d,omega2,pitch_elements2,t,uAvLR_d,vAvLR_d,uflucLR_d,vflucLR_d);
			LR_d_ABDC2<<<grid2, threads2>>>(fD_d,fC_d,omega2,pitch_elements2,SF_cf,2,t,uAvLR_d,vAvLR_d,uflucLR_d,vflucLR_d);
			LR_d_ABCD2<<<grid2, threads2>>>(fC_d,fD_d,omega2,pitch_elements2,3,t,uAvLR_d,vAvLR_d,uflucLR_d,vflucLR_d);
			LR_d_ABDC_Interp<<<grid2, threads2>>>(fD_d,fC_d,omega2,pitch_elements2,SF_cf,t,uAvLR_d,vAvLR_d,uflucLR_d,vflucLR_d);
			}
			
			//ExtractFromC_d<<<grid, threads>>>(fB_d,pitch_elements,SF_fc);
			ExtractFromC_d<<<grid, threads>>>(fB_d,pitch_elements,omega,omega2);
		}
		if(t >= STARTF)
		mrt_d_single_force<<<grid, threads>>>(fB_d,fA_d,omega,pitch_elements,FX_d,FY_d,FZ_d,t+1,uAv_d,vAv_d,ufluc_d,vfluc_d);
		else
		mrt_d_single<<<grid, threads>>>(fB_d,fA_d,omega,pitch_elements);

		if(REFINEMENT == "YES"){
			if(LRFACTOR == 0.5f)
			{
			if(t >= STARTF)
			LR_d_BACD_force<<<grid2, threads2>>>(fC_d,fD_d,omega2,pitch_elements2,FX_d,FY_d,FZ_d,t+1,uAvLR_d,vAvLR_d,uflucLR_d,vflucLR_d);
			else
			LR_d_BACD<<<grid2, threads2>>>(fC_d,fD_d,omega2,pitch_elements2,t+1,uAvLR_d,vAvLR_d,uflucLR_d,vflucLR_d);
			LR_d_BADC_Interp<<<grid2, threads2>>>(fD_d,fC_d,omega2,pitch_elements2,SF_cf,t+1,uAvLR_d,vAvLR_d,uflucLR_d,vflucLR_d);
			}
			else if(LRFACTOR == 0.25f)
			{
			if(t >= STARTF)
			LR_d_BACD_force<<<grid2, threads2>>>(fC_d,fD_d,omega2,pitch_elements2,FX_d,FY_d,FZ_d,t+1,uAvLR_d,vAvLR_d,uflucLR_d,vflucLR_d);
			else
			LR_d_BACD<<<grid2, threads2>>>(fC_d,fD_d,omega2,pitch_elements2,t+1,uAvLR_d,vAvLR_d,uflucLR_d,vflucLR_d);
			LR_d_BADC2<<<grid2, threads2>>>(fD_d,fC_d,omega2,pitch_elements2,SF_cf,2,t+1,uAvLR_d,vAvLR_d,uflucLR_d,vflucLR_d);
			LR_d_ABCD2<<<grid2, threads2>>>(fC_d,fD_d,omega2,pitch_elements2,3,t+1,uAvLR_d,vAvLR_d,uflucLR_d,vflucLR_d);
			LR_d_BADC_Interp<<<grid2, threads2>>>(fD_d,fC_d,omega2,pitch_elements2,SF_cf,t+1,uAvLR_d,vAvLR_d,uflucLR_d,vflucLR_d);
			}
	
			//ExtractFromC_d<<<grid, threads>>>(fA_d,pitch_elements,SF_fc);
			ExtractFromC_d<<<grid, threads>>>(fA_d,pitch_elements,omega,omega2);
		}


		}
//        else if(METHOD == "CACHE"){
//		    mrt_d_cache<<<grid, threads>>>(fA_d,fB_d,omega,pitch_elements);
//		    mrt_d_cache<<<grid, threads>>>(fB_d,fA_d,omega,pitch_elements);
//        }
//
//		else if(METHOD == "HYB"){
//			if(t >= STARTF && REFINEMENT == "NO")
//			mrt_d_hybAB_force<<<grid, threads>>>(fA_d,fB_d,omega,pitch_elements,FX_d,FY_d,FZ_d,t);
//			else
//			mrt_d_hybAB<<<grid, threads>>>(fA_d,fB_d,omega,pitch_elements);
//	
//			if(REFINEMENT == "YES"){
//			if(LRFACTOR == 0.5f)
//			{
//				if(t >= STARTF)
//				LR_d_hybABCD_force<<<grid2, threads2>>>(fC_d,fD_d,omega2,pitch_elements2,FX_d,FY_d,FZ_d,t);
//				else
//				LR_d_hybABCD<<<grid2, threads2>>>(fC_d,fD_d,omega2,pitch_elements2);
//	
//				LR_d_hybABDC_Interp<<<grid2, threads2>>>(fD_d,fC_d,omega2,pitch_elements2,SF_cf);
//			}
//			else if(LRFACTOR == 0.25f)
//			{
//				if(t >= STARTF)
//				LR_d_hybABCD_force<<<grid2, threads2>>>(fC_d,fD_d,omega2,pitch_elements2,FX_d,FY_d,FZ_d,t);
//				else
//				LR_d_hybABCD<<<grid2, threads2>>>(fC_d,fD_d,omega2,pitch_elements2);
//	
//				LR_d_hybABDC2<<<grid2, threads2>>>(fD_d,fC_d,omega2,pitch_elements2,SF_cf,2);
//
//				LR_d_hybABCD2<<<grid2, threads2>>>(fC_d,fD_d,omega2,pitch_elements2,3);
//				LR_d_hybABDC_Interp<<<grid2, threads2>>>(fD_d,fC_d,omega2,pitch_elements2,SF_cf);
//			}
//			
//			ExtractFromC_d<<<grid, threads>>>(fB_d,pitch_elements,SF_fc);
//			}
//	
//			if(t >= STARTF && REFINEMENT == "NO")
//			mrt_d_hybBA_force<<<grid, threads>>>(fB_d,fA_d,omega,pitch_elements,FX_d,FY_d,FZ_d,t+1);
//			else
//			mrt_d_hybBA<<<grid, threads>>>(fB_d,fA_d,omega,pitch_elements);
//	
//			if(REFINEMENT == "YES"){
//			if(LRFACTOR == 0.5f)
//			{
//				if(t >= STARTF)
//				LR_d_hybABCD_force<<<grid2, threads2>>>(fC_d,fD_d,omega2,pitch_elements2,FX_d,FY_d,FZ_d,t+1);
//				else
//				LR_d_hybABCD<<<grid2, threads2>>>(fC_d,fD_d,omega2,pitch_elements2);
//	
//				LR_d_hybBADC_Interp<<<grid2, threads2>>>(fD_d,fC_d,omega2,pitch_elements2,SF_cf);
//			}
//			else if(LRFACTOR == 0.25f)
//			{
//				if(t >= STARTF)
//				LR_d_hybABCD_force<<<grid2, threads2>>>(fC_d,fD_d,omega2,pitch_elements2,FX_d,FY_d,FZ_d,t+1);
//				else
//				LR_d_hybABCD<<<grid2, threads2>>>(fC_d,fD_d,omega2,pitch_elements2);
//	
//				LR_d_hybBADC2<<<grid2, threads2>>>(fD_d,fC_d,omega2,pitch_elements2,SF_cf,2);
//
//				LR_d_hybABCD2<<<grid2, threads2>>>(fC_d,fD_d,omega2,pitch_elements2,3);
//				LR_d_hybBADC_Interp<<<grid2, threads2>>>(fD_d,fC_d,omega2,pitch_elements2,SF_cf);
//			}
//			
//			ExtractFromC_d<<<grid, threads>>>(fA_d,pitch_elements,SF_fc);
//			}
//		}

//		else if(METHOD == "TEXT"){
//		mrt_d_textAB<<<grid, threads>>>(fA_d,fB_d,omega,pitch_elements);
//		mrt_d_textBA<<<grid, threads>>>(fB_d,fA_d,omega,pitch_elements);
//		}
//
//		else if(METHOD == "SHARED"){
//		mrt_d_shared<<<grid, threads>>>(fA_d,fB_d,omega,pitch_elements);
//		mrt_d_shared<<<grid, threads>>>(fB_d,fA_d,omega,pitch_elements);
//		}

//		simple_copy<<<grid, threads>>>(fA_d,fB_d,pitch_elements);
//		simple_copy<<<grid, threads>>>(fB_d,fA_d,pitch_elements);
//
//		simple_text<<<grid, threads>>>(fA_d,fB_d,pitch_elements);
//		simple_text<<<grid, threads>>>(fB_d,fA_d,pitch_elements);



		if(t%1000 == 0 && t>0) cout<<"finished "<<t<<" timesteps\n";
	}
	cudaDeviceSynchronize();

	gettimeofday (&tdr1,NULL);
	timeval_subtract (&restime, &tdr1, &tdr0);
	int Nodes;
	if(REFINEMENT == "YES"){
		Nodes = (XDIM*YDIM*ZDIM+XLRDIM*YLRDIM*ZLRDIM*LRLEVEL);
	}
	else{
		Nodes = XDIM*YDIM*ZDIM;
	}
	cout<<"Time taken for main kernel: "<<restime<<" ("
			<<double(Nodes*double(TMAX/1000000.f))/restime<<"MLUPS)";
	if(REFINEMENT == "YES"){
	int effNodes = (XDIM*YDIM*ZDIM+XLRDIM*YLRDIM*ZLRDIM*LRLEVEL
					-(XLRDIM/LRLEVEL)*(YLRDIM/LRLEVEL)*(YLRDIM/LRLEVEL));
	cout<<" (eff: "<<double(effNodes*double(TMAX/1000000.f))/restime<<"MLUPS)";
	}
	cout<<endl;
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
    if(VELAV == "YES"){
	cudaMemcpy2D(uAv_h,XDIM*sizeof(float),uAv_d,pitch,XDIM*sizeof(float),YDIM*ZDIM,cudaMemcpyDeviceToHost);
	cudaMemcpy2D(vAv_h,XDIM*sizeof(float),vAv_d,pitch,XDIM*sizeof(float),YDIM*ZDIM,cudaMemcpyDeviceToHost);
	cudaMemcpy2D(wAv_h,XDIM*sizeof(float),wAv_d,pitch,XDIM*sizeof(float),YDIM*ZDIM,cudaMemcpyDeviceToHost);
	cudaMemcpy2D(ufluc_h,XDIM*sizeof(float),ufluc_d,pitch,XDIM*sizeof(float),YDIM*ZDIM,cudaMemcpyDeviceToHost);
	cudaMemcpy2D(vfluc_h,XDIM*sizeof(float),vfluc_d,pitch,XDIM*sizeof(float),YDIM*ZDIM,cudaMemcpyDeviceToHost);
	cudaMemcpy2D(wfluc_h,XDIM*sizeof(float),wfluc_d,pitch,XDIM*sizeof(float),YDIM*ZDIM,cudaMemcpyDeviceToHost);
	if(REFINEMENT == "YES"){
	cudaMemcpy2D(uAvLR_h,XLRDIM*sizeof(float),uAvLR_d,pitch2,XLRDIM*sizeof(float),YLRDIM*ZLRDIM,cudaMemcpyDeviceToHost);
	cudaMemcpy2D(vAvLR_h,XLRDIM*sizeof(float),vAvLR_d,pitch2,XLRDIM*sizeof(float),YLRDIM*ZLRDIM,cudaMemcpyDeviceToHost);
	cudaMemcpy2D(wAvLR_h,XLRDIM*sizeof(float),wAvLR_d,pitch2,XLRDIM*sizeof(float),YLRDIM*ZLRDIM,cudaMemcpyDeviceToHost);
	cudaMemcpy2D(uflucLR_h,XLRDIM*sizeof(float),uflucLR_d,pitch2,XLRDIM*sizeof(float),YLRDIM*ZLRDIM,cudaMemcpyDeviceToHost);
	cudaMemcpy2D(vflucLR_h,XLRDIM*sizeof(float),vflucLR_d,pitch2,XLRDIM*sizeof(float),YLRDIM*ZLRDIM,cudaMemcpyDeviceToHost);
	cudaMemcpy2D(wflucLR_h,XLRDIM*sizeof(float),wflucLR_d,pitch2,XLRDIM*sizeof(float),YLRDIM*ZLRDIM,cudaMemcpyDeviceToHost);
    }
    }
	cudaMemcpy(FX_h, FX_d, TMAX*sizeof(float), cudaMemcpyDeviceToHost);
	cudaMemcpy(FY_h, FY_d, TMAX*sizeof(float), cudaMemcpyDeviceToHost);
	cudaMemcpy(FZ_h, FZ_d, TMAX*sizeof(float), cudaMemcpyDeviceToHost);


	//cudaMemcpy(image_h, image_d, memsize_int, cudaMemcpyDeviceToHost);

	output<<"VARIABLES = \"X\",\"Y\",\"Z\",\"u\",\"v\",\"w\",\"rho\",\"uAv\",\"vAv\",\"ufluc\",\"vfluc\"\n";
	output<<"ZONE F=POINT, I="<<XDIM<<", J="<<YDIM<<", K="<<ZDIM<<"\n";
	
	int row = 0;
	int col = 0;
	int dep = 0;
	i = 0;
	float rho, u, v, w;//, usqr;
	//int j;
    int check = 0;
	float f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18;

	for(dep = 0; dep<ZDIM; dep++){
	for(row = 0; row<YDIM; row++){
		for(col = 0; col<XDIM; col++){
			i = dep*XDIM*YDIM+row*XDIM+col;
            f0 = fA_h[i+XDIM*YDIM*ZDIM*0 ];
            f1 = fA_h[i+XDIM*YDIM*ZDIM*1 ];
            f2 = fA_h[i+XDIM*YDIM*ZDIM*2 ];
            f3 = fA_h[i+XDIM*YDIM*ZDIM*3 ];
            f4 = fA_h[i+XDIM*YDIM*ZDIM*4 ];
            f5 = fA_h[i+XDIM*YDIM*ZDIM*5 ];
            f6 = fA_h[i+XDIM*YDIM*ZDIM*6 ];
            f7 = fA_h[i+XDIM*YDIM*ZDIM*7 ];
            f8 = fA_h[i+XDIM*YDIM*ZDIM*8 ];
            f9 = fA_h[i+XDIM*YDIM*ZDIM*9 ];
            f10= fA_h[i+XDIM*YDIM*ZDIM*10];
            f11= fA_h[i+XDIM*YDIM*ZDIM*11];
            f12= fA_h[i+XDIM*YDIM*ZDIM*12];
            f13= fA_h[i+XDIM*YDIM*ZDIM*13];
            f14= fA_h[i+XDIM*YDIM*ZDIM*14];
            f15= fA_h[i+XDIM*YDIM*ZDIM*15];
            f16= fA_h[i+XDIM*YDIM*ZDIM*16];
            f17= fA_h[i+XDIM*YDIM*ZDIM*17];
            f18= fA_h[i+XDIM*YDIM*ZDIM*18];

        	rho = f0+f1+f2+f3+f4+f5+f6+f7+f8+f9;
        	rho +=f10+f11+f12+f13+f14+f15+f16+f17+f18;
        	u = f1-f3+f5-f6-f7+f8+f10-f12+f15-f17;
        	v = f2-f4+f5+f6-f7-f8+f11-f13+f16-f18;
        	w = f9+f10+f11+f12+f13-f14-f15-f16-f17-f18;
	        float m1  = 19.f*(-f0+ f5+f6+f7+f8+f10+f11+f12+f13+f15+f16+f17+f18   -(u*u+v*v+w*w));
	        float m9  = 2.f*f1+  -  f2+  2.f*f3+  -  f4+ f5+ f6+ f7+ f8+-    f9+ f10+ -2.f*f11+ f12+-2.f*f13+-    f14+ f15+ -2.f*f16+ f17+-2.f*f18  -(2.f*u*u-(v*v+w*w));
	        float m11 =             f2         +     f4+ f5+ f6+ f7+ f8+-    f9+-f10          +-f12         +-    f14+-f15          +-f17         -(v*v-w*w);
	        float m13 =                                  f5+-f6+ f7+-f8                                                                             -u*v;
	        float m14 =                                                                    f11     +-    f13              + -    f16     +     f18  -v*w;
	        float m15 =                                                          f10        + - f12                  +-f15          + f17           -u*w;  
    		float PI11 = -0.026315789f*m1-0.5f *omega*m9;
    		float PI22 = -0.026315789f*m1+0.25f*omega*(m9-3.0f*m11);
    		float PI33 = -0.026315789f*m1+0.25f*omega*(m9+3.0f*m11);
    
    		float PI12 = -1.5f*omega*m13;
    		float PI23 = -1.5f*omega*m14;
    		float PI13 = -1.5f*omega*m15;
    		//float nu0 = ((1.0f/omega)-0.5f)/3.0f;
    		float Smag = sqrt(2.f*(PI11*PI11+PI22*PI22+PI33*PI33+2.f*PI12*PI12+2.f*PI23*PI23+2.f*PI13*PI13));

			output<<col<<", "<<row<<", "<<dep<<", "<<u<<","<<v<<","<<w<<","<<Smag<<","
                  <<uAv_h[i]<<","<<vAv_h[i]<<", "<<ufluc_h[i]<<","<<vfluc_h[i]<<endl;
            if(rho>0.f && rho<2.f){
            }
            else{
                check = 1;
            }
		}
	}
	}
    if(check == 1) cout<<"error!"<<endl;

	if(REFINEMENT == "YES"){
	output<<endl;//<<"VARIABLES = \"X\",\"Y\",\"Z\",\"u\",\"v\",\"w\",\"rho\",\"uAv\"\n";
	output<<"VARIABLES = \"X\",\"Y\",\"Z\",\"u\",\"v\",\"w\",\"rho\",\"uAv\",\"vAv\",\"ufluc\",\"vfluc\"\n";
	output<<"ZONE F=POINT, I="<<XLRDIM-0<<", J="<<YLRDIM-0<<", K="<<ZLRDIM-0<<"\n";
    	
	for(dep = 0; dep<ZLRDIM-0; dep++){
	for(row = 0; row<YLRDIM-0; row++){
		for(col = 0; col<XLRDIM-0; col++){
			i = dep*XLRDIM*YLRDIM+row*XLRDIM+col;

            f0 = fC_h[i+XLRDIM*YLRDIM*ZLRDIM*0 ];
            f1 = fC_h[i+XLRDIM*YLRDIM*ZLRDIM*1 ];
            f2 = fC_h[i+XLRDIM*YLRDIM*ZLRDIM*2 ];
            f3 = fC_h[i+XLRDIM*YLRDIM*ZLRDIM*3 ];
            f4 = fC_h[i+XLRDIM*YLRDIM*ZLRDIM*4 ];
            f5 = fC_h[i+XLRDIM*YLRDIM*ZLRDIM*5 ];
            f6 = fC_h[i+XLRDIM*YLRDIM*ZLRDIM*6 ];
            f7 = fC_h[i+XLRDIM*YLRDIM*ZLRDIM*7 ];
            f8 = fC_h[i+XLRDIM*YLRDIM*ZLRDIM*8 ];
            f9 = fC_h[i+XLRDIM*YLRDIM*ZLRDIM*9 ];
            f10= fC_h[i+XLRDIM*YLRDIM*ZLRDIM*10];
            f11= fC_h[i+XLRDIM*YLRDIM*ZLRDIM*11];
            f12= fC_h[i+XLRDIM*YLRDIM*ZLRDIM*12];
            f13= fC_h[i+XLRDIM*YLRDIM*ZLRDIM*13];
            f14= fC_h[i+XLRDIM*YLRDIM*ZLRDIM*14];
            f15= fC_h[i+XLRDIM*YLRDIM*ZLRDIM*15];
            f16= fC_h[i+XLRDIM*YLRDIM*ZLRDIM*16];
            f17= fC_h[i+XLRDIM*YLRDIM*ZLRDIM*17];
            f18= fC_h[i+XLRDIM*YLRDIM*ZLRDIM*18];

        	rho = f0+f1+f2+f3+f4+f5+f6+f7+f8+f9;
        	rho +=f10+f11+f12+f13+f14+f15+f16+f17+f18;
        	u = f1-f3+f5-f6-f7+f8+f10-f12+f15-f17;
        	v = f2-f4+f5+f6-f7-f8+f11-f13+f16-f18;
        	w = f9+f10+f11+f12+f13-f14-f15-f16-f17-f18;
            float m1  = 19.f*(-f0+ f5+f6+f7+f8+f10+f11+f12+f13+f15+f16+f17+f18   -(u*u+v*v+w*w));
	        float m9  = 2.f*f1+  -  f2+  2.f*f3+  -  f4+ f5+ f6+ f7+ f8+-    f9+ f10+ -2.f*f11+ f12+-2.f*f13+-    f14+ f15+ -2.f*f16+ f17+-2.f*f18  -(2.f*u*u-(v*v+w*w));
	        float m11 =             f2         +     f4+ f5+ f6+ f7+ f8+-    f9+-f10          +-f12         +-    f14+-f15          +-f17         -(v*v-w*w);
	        float m13 =                                  f5+-f6+ f7+-f8                                                                             -u*v;
	        float m14 =                                                                    f11     +-    f13              + -    f16     +     f18  -v*w;
	        float m15 =                                                          f10        + - f12                  +-f15          + f17           -u*w;

    		float PI11 = LRLEVEL*-0.026315789f*m1-0.5f *omega*m9;
    		float PI22 = LRLEVEL*-0.026315789f*m1+0.25f*omega*(m9-3.0f*m11);
    		float PI33 = LRLEVEL*-0.026315789f*m1+0.25f*omega*(m9+3.0f*m11);
    		float PI12 = LRLEVEL*-1.5f*omega*m13;
    		float PI23 = LRLEVEL*-1.5f*omega*m14;
    		float PI13 = LRLEVEL*-1.5f*omega*m15;
    		//float nu0 = ((1.0f/omega)-0.5f)/3.0f;
    		float Smag = sqrt(2.f*(PI11*PI11+PI22*PI22+PI33*PI33+2.f*PI12*PI12+2.f*PI23*PI23+2.f*PI13*PI13));

			output<<LRX0+col*LRFACTOR<<", "<<LRY0+row*LRFACTOR<<", "
                  <<LRZ0+dep*LRFACTOR<<", "<<u<<","<<v<<","<<w<<","<<Smag<<","
                  <<uAvLR_h[i]<<","<<vAvLR_h[i]<<", "<<uflucLR_h[i]<<","<<vflucLR_h[i]<<endl;
			//output<<LRX0+col*LRFACTOR<<", "<<LRY0+row*LRFACTOR<<", "<<LRZ0+dep*LRFACTOR<<", "<<u<<","<<v<<","<<w<<","<<rho<<endl;
        


		}
	}
	}
	}

	output.close();

	//for(int t = STARTF-1; t<TMAX; t++){
	for(int t = 0; t<TMAX; t++){
		output2<<t<<", "<<FX_h[t]/(0.5f*UMAX*UMAX*2.f*OBSTR1*ZDIM)<<", "
						<<FY_h[t]/(0.5f*UMAX*UMAX*2.f*OBSTR1*ZDIM)<<", "
						<<FZ_h[t]/(0.5f*UMAX*UMAX*2.f*OBSTR1*ZDIM)<<endl;
//		output2<<t<<", "<<FX_h[t]/(0.5f*UMAX*UMAX*OBSTR1*OBSTR1*3.14158f)<<", "
//						<<FY_h[t]/(0.5f*UMAX*UMAX*OBSTR1*OBSTR1*3.14158f)<<", "
//						<<FZ_h[t]/(0.5f*UMAX*UMAX*OBSTR1*OBSTR1*3.14158f)<<endl;
	}
	output2.close();



	//cudaFree(image_d);


	cudaFree(fA_d);
	cudaFree(fB_d);
	cudaFree(fC_d);
	cudaFree(fD_d);
	return(0);

}
