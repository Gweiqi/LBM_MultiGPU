#include <cuda.h>
//#include <cutil.h>
#include <iostream>
#include <ostream>
#include <fstream>
//#include "/home/yusuke/NVIDIA_GPU_Computing_SDK/C/common/inc/cutil.h"
using namespace std;
	
#define CASENAME "Test31"

#define BLOCKSIZEX 4
#define BLOCKSIZEY 1
#define BLOCKSIZEZ 1
#define BLOCKSIZELRX 64
#define BLOCKSIZELRY 1
#define BLOCKSIZELRZ 1
#define XDIM 4
#define YDIM 4
#define ZDIM 10
#define TMAX 10
#define STARTF 0

#define OBSTR1 8.f
#define OBSTX1 127.5f
#define OBSTY1 95.5f
#define OBSTZ1 15.5f

#define OBSTR2 4.f
#define OBSTX2 63.5f
#define OBSTY2 31.5f
#define OBSTZ2 31.5f

#define RE 100.f//2000.f//100.f;
#define UMAX 0.04f
#define METHOD "SINGLE" //SINGLE,HYB,TEXT,SHARED,CACHE
#define SmagLES "YES" //YES,NO
#define MODEL "MRT" //BGK,MRT,STREAM
#define ZPERIODIC "NO"
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
//    int value = 0;
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

//    if(abs(x-OBSTX1) < OBSTR1 && abs(y-OBSTY1) < OBSTR1)
//        value = 10;
//	else if(y == 0)
//		value = 200;//22;
//	else if(y == YDIM-1)
//		value = 100;
//	else if(x == 0)
//		value = 26;
//	else if(x == XDIM-1)
//		value = 25;
//	else if(z == 0)
//		value = 0;
//	else if(z == ZDIM-1)
//		value = 0;

    //return value;

//Lid Driven Cavity
	if(x == 0 || x == XDIM-1 || y == 0 || y == YDIM-1 || z == 0 || z == ZDIM-1)
		return 1;
//	else if(x == XDIM-2 || y == 1 || y == YDIM-2 || z == 1 || z == ZDIM-2)
//		return 1;
//	else if(x == 0)
//		return 1;
//	else if(x == 1)
//		return 53;
	else
		return 0;
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

SF = (omega*(1.0f-omega2))/((1.0f-omega)*omega2);//for post-collision 
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

float SF = (omega*(1.0f-omega2))/((1.0f-omega)*omega2);
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

	return (x+y*pitch+z*YDIM*pitch)+f_num*pitch*YDIM*(ZDIM/2-2);
}

inline __device__ int buff_mem(int f_num, int x, int y, size_t pitch)
{

	return (x+y*pitch)+f_num*pitch*YDIM;
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

//__global__ void mrt_d_single_force(float* fin, float* fout,
//							float omega, size_t pitch, float *FX, float *FY, float *FZ, 
//                            int t,float *uAv, float *vAv, float *ufluc, float *vfluc, int GPU)
//{
//	int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
//	int y = threadIdx.y+blockIdx.y*blockDim.y;//;
//	int z = threadIdx.z+blockIdx.z*blockDim.z+ZDIM/2*GPU;
//	int j = x+y*pitch+z*YDIM*pitch;//index on padded mem (pitch in elements)
//	float f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18;
//	__shared__ float sumX[BLOCKSIZEX], sumY[BLOCKSIZEX], sumZ[BLOCKSIZEX];
//	__shared__ int check[1];
//	check[0] = 0;
//	syncthreads();
//    float u_Av, v_Av, u_fluc, v_fluc;
//
//
////	if((REFINEMENT == "YES" && x > LRX0+1 && x < LRX0+(XLRDIM-1)*LRFACTOR-1 && 
////						y > LRY0+1 && y < LRY0+(YLRDIM-1)*LRFACTOR-1 &&
////						z > LRZ0+1 && z < LRZ0+(ZLRDIM-1)*LRFACTOR-1 ||
////						(x>XDIM-1)))
////	{
////	}
////	else{
//	int im = ImageFcn(x,y,z);
//
//	f0 = fin[j];
//	f1 = fin[f_mem(1 ,x-1,y  ,z  ,pitch)];
//	f3 = fin[f_mem(3 ,x+1,y  ,z  ,pitch)];
//	f2 = fin[f_mem(2 ,x  ,y-1,z  ,pitch)];
//	f5 = fin[f_mem(5 ,x-1,y-1,z  ,pitch)];
//	f6 = fin[f_mem(6 ,x+1,y-1,z  ,pitch)];
//	f4 = fin[f_mem(4 ,x  ,y+1,z  ,pitch)];
//	f7 = fin[f_mem(7 ,x+1,y+1,z  ,pitch)];
//	f8 = fin[f_mem(8 ,x-1,y+1,z  ,pitch)];
//    if(z != 0){
//	f9 = fin[f_mem(9 ,x  ,y  ,z-1,pitch)];
//	f10= fin[f_mem(10,x-1,y  ,z-1,pitch)];
//	f11= fin[f_mem(11,x  ,y-1,z-1,pitch)];
//	f12= fin[f_mem(12,x+1,y  ,z-1,pitch)];
//	f13= fin[f_mem(13,x  ,y+1,z-1,pitch)];
//    }
//    else{
//	f9 = fin[f_mem(9 ,x  ,y  ,ZDIM-1,pitch)];
//	f10= fin[f_mem(10,dmax_p(x-1,XDIM),y  ,ZDIM-1,pitch)];
//	f11= fin[f_mem(11,x  ,dmax_p(y-1,YDIM),ZDIM-1,pitch)];
//	f12= fin[f_mem(12,dmin_p(x+1,XDIM),y  ,ZDIM-1,pitch)];
//	f13= fin[f_mem(13,x  ,dmin_p(y+1,YDIM),ZDIM-1,pitch)];
//    }
//    if(z != ZDIM-1){
//	f14= fin[f_mem(14,x  ,y  ,z+1,pitch)];
//	f15= fin[f_mem(15,x-1,y  ,z+1,pitch)];
//	f16= fin[f_mem(16,x  ,y-1,z+1,pitch)];
//	f17= fin[f_mem(17,x+1,y  ,z+1,pitch)];
//	f18= fin[f_mem(18,x  ,y+1,z+1,pitch)];
//    }
//    else{
//	f14= fin[f_mem(14,x  ,y  ,0  ,pitch)];
//	f15= fin[f_mem(15,dmax_p(x-1,XDIM),y  ,0  ,pitch)];
//	f16= fin[f_mem(16,x  ,dmax_p(y-1,YDIM),0  ,pitch)];
//	f17= fin[f_mem(17,dmin_p(x+1,XDIM),y  ,0  ,pitch)];
//	f18= fin[f_mem(18,x  ,dmin_p(y+1,YDIM),0  ,pitch)];    
//    }
//
//	if(im == 1 || im == 10){//BB
//		if(im == 10){
//		check[0] = 1;
//		sumX[threadIdx.x]=2.f*f1-2.f*f3+2.f*f5+2.f*f8-2.f*f6-2.f*f7+2.f*f10-2.f*f12+2.f*f15-2.f*f17;
//		sumY[threadIdx.x]=2.f*f2-2.f*f4+2.f*f5-2.f*f8+2.f*f6-2.f*f7+2.f*f11-2.f*f13+2.f*f16-2.f*f18;
//		sumZ[threadIdx.x]=2.f*f9+2.f*f10+2.f*f11+2.f*f12+2.f*f13-2.f*f14-2.f*f15-2.f*f16-2.f*f17-2.f*f18;
//		}
//		else{
//		sumX[threadIdx.x]=0.f;
//		sumY[threadIdx.x]=0.f;
//		sumZ[threadIdx.x]=0.f;
//		}
//		fout[j+pitch*YDIM*ZDIM*1 ] = f3 ;
//		fout[j+pitch*YDIM*ZDIM*2 ] = f4 ;
//		fout[j+pitch*YDIM*ZDIM*3 ] = f1 ;
//		fout[j+pitch*YDIM*ZDIM*4 ] = f2 ;
//		fout[j+pitch*YDIM*ZDIM*5 ] = f7 ;
//		fout[j+pitch*YDIM*ZDIM*6 ] = f8 ;
//		fout[j+pitch*YDIM*ZDIM*7 ] = f5 ;
//		fout[j+pitch*YDIM*ZDIM*8 ] = f6 ;
//		fout[j+pitch*YDIM*ZDIM*9 ] = f14;
//		fout[j+pitch*YDIM*ZDIM*10] = f17;
//		fout[j+pitch*YDIM*ZDIM*11] = f18;
//		fout[j+pitch*YDIM*ZDIM*12] = f15;
//		fout[j+pitch*YDIM*ZDIM*13] = f16;
//		fout[j+pitch*YDIM*ZDIM*14] = f9 ;
//		fout[j+pitch*YDIM*ZDIM*15] = f12;
//		fout[j+pitch*YDIM*ZDIM*16] = f13;
//		fout[j+pitch*YDIM*ZDIM*17] = f10;
//		fout[j+pitch*YDIM*ZDIM*18] = f11;
//	}
//	else{
//		sumX[threadIdx.x]=0.f;
//		sumY[threadIdx.x]=0.f;
//		sumZ[threadIdx.x]=0.f;
//		boundaries_force(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,y,z,im);
//
//        if(im == 100)//north outlet
//        {
//           	f0 = fin[f_mem(0 ,x,y-1,z,pitch)];
//        	f1 = fin[f_mem(1 ,x,y-1,z,pitch)];
//        	f3 = fin[f_mem(3 ,x,y-1,z,pitch)];
//        	f2 = fin[f_mem(2 ,x,y-1,z,pitch)];
//        	f5 = fin[f_mem(5 ,x,y-1,z,pitch)];
//        	f6 = fin[f_mem(6 ,x,y-1,z,pitch)];
//        	f4 = fin[f_mem(4 ,x,y-1,z,pitch)];
//        	f7 = fin[f_mem(7 ,x,y-1,z,pitch)];
//        	f8 = fin[f_mem(8 ,x,y-1,z,pitch)];
//        	f9 = fin[f_mem(9 ,x,y-1,z,pitch)];
//        	f10= fin[f_mem(10,x,y-1,z,pitch)];
//        	f11= fin[f_mem(11,x,y-1,z,pitch)];
//        	f12= fin[f_mem(12,x,y-1,z,pitch)];
//        	f13= fin[f_mem(13,x,y-1,z,pitch)];
//        	f14= fin[f_mem(14,x,y-1,z,pitch)];
//        	f15= fin[f_mem(15,x,y-1,z,pitch)];
//        	f16= fin[f_mem(16,x,y-1,z,pitch)];
//        	f17= fin[f_mem(17,x,y-1,z,pitch)];
//        	f18= fin[f_mem(18,x,y-1,z,pitch)];
//
//	float rho,u,v,w;	
//	rho = 1.0f;
//	u = f1-f3+f5-f6-f7+f8+f10-f12+f15-f17;
//	v = f2-f4+f5+f6-f7-f8+f11-f13+f16-f18;
//	w = f9+f10+f11+f12+f13-f14-f15-f16-f17-f18;
//
//	float m1,m2,m4,m6,m8,m9,m10,m11,m12,m13,m14,m15,m16,m17,m18;
//
//	m1  = -30.f*f0+-11.f*f1+-11.f*f2+-11.f*f3+-11.f*f4+  8.f*f5+  8.f*f6+  8.f*f7+  8.f*f8+-11.f*f9+  8.f*f10+  8.f*f11+  8.f*f12+  8.f*f13+-11.f*f14+  8.f*f15+  8.f*f16+  8.f*f17+  8.f*f18;
//	m2  =  12.f*f0+ -4.f*f1+ -4.f*f2+ -4.f*f3+ -4.f*f4+    f5+    f6+    f7+    f8+ -4.f*f9+    f10+      f11+    f12+    f13+ -4.f*f14+    f15+    f16+    f17+    f18;
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
//f0 =(0.052631579f*rho                           +- 0.012531328f*(m1)+ 0.047619048f*(m2));
//f1 =(0.052631579f*rho+  0.1f*u                  +-0.0045948204f*(m1)+-0.015873016f*(m2)+  -0.1f*(m4)                 + 0.055555556f*((m9)-m10));
//f2 =(0.052631579f*rho         +  0.1f*v         +-0.0045948204f*(m1)+-0.015873016f*(m2)             +   -0.1f*(m6)   +-0.027777778f*((m9)-m10)+ 0.083333333f*((m11)-m12));
//f3 =(0.052631579f*rho+ -0.1f*u                  +-0.0045948204f*(m1)+-0.015873016f*(m2)+   0.1f*(m4)                 + 0.055555556f*((m9)-m10));                                                                                         
//f4 =(0.052631579f*rho         + -0.1f*v         +-0.0045948204f*(m1)+-0.015873016f*(m2)             +    0.1f*(m6)   +-0.027777778f*((m9)-m10)+ 0.083333333f*((m11)-m12));
//f5 =(0.052631579f*rho+  0.1f*u+  0.1f*v         + 0.0033416876f*(m1)+ 0.003968254f*(m2)+ 0.025f*(m4+m6)              +0.013888889f*(m10)+0.041666667f*(m12)+0.125f*( m16-m17)+ (0.027777778f*(m9) +0.083333333f*(m11)+( 0.25f*(m13))));
//f6 =(0.052631579f*rho+ -0.1f*u+  0.1f*v         + 0.0033416876f*(m1)+ 0.003968254f*(m2)+-0.025f*(m4-m6)              +0.013888889f*(m10)+0.041666667f*(m12)+0.125f*(-m16-m17)+ (0.027777778f*(m9) +0.083333333f*(m11)+(-0.25f*(m13))));
//f7 =(0.052631579f*rho+ -0.1f*u+ -0.1f*v         + 0.0033416876f*(m1)+ 0.003968254f*(m2)+-0.025f*(m4+m6)              +0.013888889f*(m10)+0.041666667f*(m12)+0.125f*(-m16+m17)+ (0.027777778f*(m9) +0.083333333f*(m11)+( 0.25f*(m13))));
//f8 =(0.052631579f*rho+  0.1f*u+ -0.1f*v         + 0.0033416876f*(m1)+ 0.003968254f*(m2)+ 0.025f*(m4-m6)              +0.013888889f*(m10)+0.041666667f*(m12)+0.125f*( m16+m17)+ (0.027777778f*(m9) +0.083333333f*(m11)+(-0.25f*(m13))));
//f9 =(0.052631579f*rho                  +  0.1f*w+-0.0045948204f*(m1)+-0.015873016f*(m2)                +   -0.1f*(m8)+-0.027777778f*((m9)-m10)+-0.083333333f*((m11)-m12));                                       
//f10=(0.052631579f*rho+  0.1f*u         +  0.1f*w+ 0.0033416876f*(m1)+ 0.003968254f*(m2)+ 0.025f*(m4+m8)              +0.013888889f*(m10)-0.041666667f*(m12)+0.125f*(-m16+m18)+ (0.027777778f*(m9) -0.083333333f*(m11)+( 0.25f*(m15))));
//f11=(0.052631579f*rho         +  0.1f*v+  0.1f*w+ 0.0033416876f*(m1)+ 0.003968254f*(m2)             +  0.025f*(m6+m8)+0.125f*( m17-m18)-0.027777778f*(m10)+(-0.055555556f*(m9) +( 0.25f*(m14))));
//f12=(0.052631579f*rho+ -0.1f*u         +  0.1f*w+ 0.0033416876f*(m1)+ 0.003968254f*(m2)+-0.025f*(m4-m8)              +0.013888889f*(m10)-0.041666667f*(m12)+0.125f*( m16+m18)+ (0.027777778f*(m9) -0.083333333f*(m11)+(-0.25f*(m15))));
//f13=(0.052631579f*rho         + -0.1f*v+  0.1f*w+ 0.0033416876f*(m1)+ 0.003968254f*(m2)             + -0.025f*(m6-m8)+0.125f*(-m17-m18)-0.027777778f*(m10)+(-0.055555556f*(m9) +(-0.25f*(m14))));
//f14=(0.052631579f*rho                  + -0.1f*w+-0.0045948204f*(m1)+-0.015873016f*(m2)                +    0.1f*(m8)+-0.027777778f*((m9)-m10)+-0.083333333f*((m11)-m12));                                      
//f15=(0.052631579f*rho+  0.1f*u         + -0.1f*w+ 0.0033416876f*(m1)+ 0.003968254f*(m2)+ 0.025f*(m4-m8)              +0.013888889f*(m10)-0.041666667f*(m12)+0.125f*(-m16-m18)+ (0.027777778f*(m9) -0.083333333f*(m11)+(-0.25f*(m15))));
//f16=(0.052631579f*rho         +  0.1f*v+ -0.1f*w+ 0.0033416876f*(m1)+ 0.003968254f*(m2)             +  0.025f*(m6-m8)+0.125f*( m17+m18)-0.027777778f*(m10)+(-0.055555556f*(m9) +(-0.25f*(m14))));
//f17=(0.052631579f*rho+ -0.1f*u         + -0.1f*w+ 0.0033416876f*(m1)+ 0.003968254f*(m2)+-0.025f*(m4+m8)              +0.013888889f*(m10)-0.041666667f*(m12)+0.125f*( m16-m18)+ (0.027777778f*(m9) -0.083333333f*(m11)+( 0.25f*(m15))));
//f18=(0.052631579f*rho         + -0.1f*v+ -0.1f*w+ 0.0033416876f*(m1)+ 0.003968254f*(m2)             + -0.025f*(m6+m8)+0.125f*(-m17+m18)-0.027777778f*(m10)+(-0.055555556f*(m9) +( 0.25f*(m14))));
//
//        }
//        if(im == 200)//south inlet
//        {
//           	f0 = fin[f_mem(0 ,x,y+1,z,pitch)];
//        	f1 = fin[f_mem(1 ,x,y+1,z,pitch)];
//        	f3 = fin[f_mem(3 ,x,y+1,z,pitch)];
//        	f2 = fin[f_mem(2 ,x,y+1,z,pitch)];
//        	f5 = fin[f_mem(5 ,x,y+1,z,pitch)];
//        	f6 = fin[f_mem(6 ,x,y+1,z,pitch)];
//        	f4 = fin[f_mem(4 ,x,y+1,z,pitch)];
//        	f7 = fin[f_mem(7 ,x,y+1,z,pitch)];
//        	f8 = fin[f_mem(8 ,x,y+1,z,pitch)];
//        	f9 = fin[f_mem(9 ,x,y+1,z,pitch)];
//        	f10= fin[f_mem(10,x,y+1,z,pitch)];
//        	f11= fin[f_mem(11,x,y+1,z,pitch)];
//        	f12= fin[f_mem(12,x,y+1,z,pitch)];
//        	f13= fin[f_mem(13,x,y+1,z,pitch)];
//        	f14= fin[f_mem(14,x,y+1,z,pitch)];
//        	f15= fin[f_mem(15,x,y+1,z,pitch)];
//        	f16= fin[f_mem(16,x,y+1,z,pitch)];
//        	f17= fin[f_mem(17,x,y+1,z,pitch)];
//        	f18= fin[f_mem(18,x,y+1,z,pitch)];
//
//	float rho,u,v,w;	
//	rho = f0+f1+f2+f3+f4+f5+f6+f7+f8+f9+f10+f11+f12+f13+f14+f15+f16+f17+f18;
//	u = 0.f;//f1-f3+f5-f6-f7+f8+f10-f12+f15-f17;
//	v = UMAX;//f2-f4+f5+f6-f7-f8+f11-f13+f16-f18;
//	w = 0.f;//f9+f10+f11+f12+f13-f14-f15-f16-f17-f18;
//
//	float m1,m2,m4,m6,m8,m9,m10,m11,m12,m13,m14,m15,m16,m17,m18;
//
//	m1  = -30.f*f0+-11.f*f1+-11.f*f2+-11.f*f3+-11.f*f4+  8.f*f5+  8.f*f6+  8.f*f7+  8.f*f8+-11.f*f9+  8.f*f10+  8.f*f11+  8.f*f12+  8.f*f13+-11.f*f14+  8.f*f15+  8.f*f16+  8.f*f17+  8.f*f18;
//	m2  =  12.f*f0+ -4.f*f1+ -4.f*f2+ -4.f*f3+ -4.f*f4+    f5+    f6+    f7+    f8+ -4.f*f9+    f10+      f11+    f12+    f13+ -4.f*f14+    f15+    f16+    f17+    f18;
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
//f0 =(0.052631579f*rho                           +- 0.012531328f*(m1)+ 0.047619048f*(m2));
//f1 =(0.052631579f*rho+  0.1f*u                  +-0.0045948204f*(m1)+-0.015873016f*(m2)+  -0.1f*(m4)                 + 0.055555556f*((m9)-m10));
//f2 =(0.052631579f*rho         +  0.1f*v         +-0.0045948204f*(m1)+-0.015873016f*(m2)             +   -0.1f*(m6)   +-0.027777778f*((m9)-m10)+ 0.083333333f*((m11)-m12));
//f3 =(0.052631579f*rho+ -0.1f*u                  +-0.0045948204f*(m1)+-0.015873016f*(m2)+   0.1f*(m4)                 + 0.055555556f*((m9)-m10));                                                                                         
//f4 =(0.052631579f*rho         + -0.1f*v         +-0.0045948204f*(m1)+-0.015873016f*(m2)             +    0.1f*(m6)   +-0.027777778f*((m9)-m10)+ 0.083333333f*((m11)-m12));
//f5 =(0.052631579f*rho+  0.1f*u+  0.1f*v         + 0.0033416876f*(m1)+ 0.003968254f*(m2)+ 0.025f*(m4+m6)              +0.013888889f*(m10)+0.041666667f*(m12)+0.125f*( m16-m17)+ (0.027777778f*(m9) +0.083333333f*(m11)+( 0.25f*(m13))));
//f6 =(0.052631579f*rho+ -0.1f*u+  0.1f*v         + 0.0033416876f*(m1)+ 0.003968254f*(m2)+-0.025f*(m4-m6)              +0.013888889f*(m10)+0.041666667f*(m12)+0.125f*(-m16-m17)+ (0.027777778f*(m9) +0.083333333f*(m11)+(-0.25f*(m13))));
//f7 =(0.052631579f*rho+ -0.1f*u+ -0.1f*v         + 0.0033416876f*(m1)+ 0.003968254f*(m2)+-0.025f*(m4+m6)              +0.013888889f*(m10)+0.041666667f*(m12)+0.125f*(-m16+m17)+ (0.027777778f*(m9) +0.083333333f*(m11)+( 0.25f*(m13))));
//f8 =(0.052631579f*rho+  0.1f*u+ -0.1f*v         + 0.0033416876f*(m1)+ 0.003968254f*(m2)+ 0.025f*(m4-m6)              +0.013888889f*(m10)+0.041666667f*(m12)+0.125f*( m16+m17)+ (0.027777778f*(m9) +0.083333333f*(m11)+(-0.25f*(m13))));
//f9 =(0.052631579f*rho                  +  0.1f*w+-0.0045948204f*(m1)+-0.015873016f*(m2)                +   -0.1f*(m8)+-0.027777778f*((m9)-m10)+-0.083333333f*((m11)-m12));                                       
//f10=(0.052631579f*rho+  0.1f*u         +  0.1f*w+ 0.0033416876f*(m1)+ 0.003968254f*(m2)+ 0.025f*(m4+m8)              +0.013888889f*(m10)-0.041666667f*(m12)+0.125f*(-m16+m18)+ (0.027777778f*(m9) -0.083333333f*(m11)+( 0.25f*(m15))));
//f11=(0.052631579f*rho         +  0.1f*v+  0.1f*w+ 0.0033416876f*(m1)+ 0.003968254f*(m2)             +  0.025f*(m6+m8)+0.125f*( m17-m18)-0.027777778f*(m10)+(-0.055555556f*(m9) +( 0.25f*(m14))));
//f12=(0.052631579f*rho+ -0.1f*u         +  0.1f*w+ 0.0033416876f*(m1)+ 0.003968254f*(m2)+-0.025f*(m4-m8)              +0.013888889f*(m10)-0.041666667f*(m12)+0.125f*( m16+m18)+ (0.027777778f*(m9) -0.083333333f*(m11)+(-0.25f*(m15))));
//f13=(0.052631579f*rho         + -0.1f*v+  0.1f*w+ 0.0033416876f*(m1)+ 0.003968254f*(m2)             + -0.025f*(m6-m8)+0.125f*(-m17-m18)-0.027777778f*(m10)+(-0.055555556f*(m9) +(-0.25f*(m14))));
//f14=(0.052631579f*rho                  + -0.1f*w+-0.0045948204f*(m1)+-0.015873016f*(m2)                +    0.1f*(m8)+-0.027777778f*((m9)-m10)+-0.083333333f*((m11)-m12));                                      
//f15=(0.052631579f*rho+  0.1f*u         + -0.1f*w+ 0.0033416876f*(m1)+ 0.003968254f*(m2)+ 0.025f*(m4-m8)              +0.013888889f*(m10)-0.041666667f*(m12)+0.125f*(-m16-m18)+ (0.027777778f*(m9) -0.083333333f*(m11)+(-0.25f*(m15))));
//f16=(0.052631579f*rho         +  0.1f*v+ -0.1f*w+ 0.0033416876f*(m1)+ 0.003968254f*(m2)             +  0.025f*(m6-m8)+0.125f*( m17+m18)-0.027777778f*(m10)+(-0.055555556f*(m9) +(-0.25f*(m14))));
//f17=(0.052631579f*rho+ -0.1f*u         + -0.1f*w+ 0.0033416876f*(m1)+ 0.003968254f*(m2)+-0.025f*(m4+m8)              +0.013888889f*(m10)-0.041666667f*(m12)+0.125f*( m16-m18)+ (0.027777778f*(m9) -0.083333333f*(m11)+( 0.25f*(m15))));
//f18=(0.052631579f*rho         + -0.1f*v+ -0.1f*w+ 0.0033416876f*(m1)+ 0.003968254f*(m2)             + -0.025f*(m6+m8)+0.125f*(-m17+m18)-0.027777778f*(m10)+(-0.055555556f*(m9) +( 0.25f*(m14))));
//
//        }
//
//
//        //float Cs = 0.01f;
//        //if(XDIM-x < 64.f)
//        ////Cs = 0.01f+(x-64.f)/64.f*(x-64.f)/64.f*0.1f;
//        //Cs = 0.01f*pow(2.f,((x-448.f)/16.f));
//
//		if(MODEL == "MRT")
//		mrt_collide_LES(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,omega,CS);
//		else if(MODEL == "BGK")
//		bgk_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,omega);
//
//        if(VELAV == "YES"){
//            if(t>=START_VELAV && t<START_VELFLUC){
//                u_Av = uAv[j];
//                v_Av = vAv[j];
//        		vel_av(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,u_Av,v_Av,t);
//                uAv[j] = u_Av;
//                vAv[j] = v_Av;
//            }
//            else if(t>=START_VELFLUC){
//                u_Av = uAv[j];
//                v_Av = vAv[j];
//                u_fluc = ufluc[j];
//                v_fluc = vfluc[j];
//        		vel_fluc(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,u_Av,v_Av,u_fluc,v_fluc,t);
//                ufluc[j] = u_fluc;
//                vfluc[j] = v_fluc;
//                
//            }
//        }
//
//
//
//		fout[f_mem(0 ,x,y,z,pitch)] = f0 ;
//		fout[f_mem(1 ,x,y,z,pitch)] = f1 ;
//		fout[f_mem(2 ,x,y,z,pitch)] = f2 ;
//		fout[f_mem(3 ,x,y,z,pitch)] = f3 ;
//		fout[f_mem(4 ,x,y,z,pitch)] = f4 ;
//		fout[f_mem(5 ,x,y,z,pitch)] = f5 ;
//		fout[f_mem(6 ,x,y,z,pitch)] = f6 ;
//		fout[f_mem(7 ,x,y,z,pitch)] = f7 ;
//		fout[f_mem(8 ,x,y,z,pitch)] = f8 ;
//		fout[f_mem(9 ,x,y,z,pitch)] = f9 ;
//		fout[f_mem(10,x,y,z,pitch)] = f10;
//		fout[f_mem(11,x,y,z,pitch)] = f11;
//		fout[f_mem(12,x,y,z,pitch)] = f12;
//		fout[f_mem(13,x,y,z,pitch)] = f13;
//		fout[f_mem(14,x,y,z,pitch)] = f14;
//		fout[f_mem(15,x,y,z,pitch)] = f15;
//		fout[f_mem(16,x,y,z,pitch)] = f16;
//		fout[f_mem(17,x,y,z,pitch)] = f17;
//		fout[f_mem(18,x,y,z,pitch)] = f18;
//	}
//
//	syncthreads();
//	if(check[0] == 1 && t>=STARTF && REFINEMENT == "NO"){
//	//reduction for force
//	int nTotalThreads = blockDim.x;
//	while(nTotalThreads > 1){
//		int halfPoint = (nTotalThreads >> 1);
//		if(threadIdx.x < halfPoint){
//			sumX[threadIdx.x] += sumX[threadIdx.x+halfPoint];
//			sumY[threadIdx.x] += sumY[threadIdx.x+halfPoint];
//			sumZ[threadIdx.x] += sumZ[threadIdx.x+halfPoint];
//		}
//		syncthreads();
//		nTotalThreads = halfPoint;
//	}
//	if(threadIdx.x == 0){
//		atomicAdd(&FX[t],sumX[0]);
//		atomicAdd(&FY[t],sumY[0]);
//		atomicAdd(&FZ[t],sumZ[0]);
//	}
//	}
//
//
////	}
//}

__global__ void mrt_d_single(float* fA, float* fB,
							float omega, size_t pitch, int GPU)//pitch in elements
{
	int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
	int y = threadIdx.y+blockIdx.y*blockDim.y;
	int z = threadIdx.z+blockIdx.z*blockDim.z+ZDIM/2*GPU;
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

__global__ void update_inner(float* fA, float* fB, float* g, float* h,
							float omega, size_t pitch, int GPU)//pitch in elements
{
	int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
	int y = threadIdx.y+blockIdx.y*blockDim.y;
	int z = threadIdx.z+blockIdx.z*blockDim.z;
	int j = x+y*pitch+z*YDIM*pitch;//index on padded mem (pitch in elements)
	int im = ImageFcn(x,y,GPU*ZDIM/2+1+z);
	float f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18;

//	if(REFINEMENT == "YES" && x > LRX0+1 && x < LRX0+(XLRDIM-1)*LRFACTOR-1 
//		&& y > LRY0+1 && y < LRY0+(YLRDIM-1)*LRFACTOR-1 && z > LRZ0+1 && z < LRZ0+(ZLRDIM-1)*LRFACTOR-1 ||
//		(x>XDIM-1)){
//	}
//	else{
    if(z==ZDIM/2-1-1){//top nodes need info from h
    f0 = fA[j];
	f1 = fA[f_mem   (1 ,dmax(x-1)     ,y             ,z  ,pitch)];
	f3 = fA[f_mem   (3 ,dmin(x+1,XDIM),y             ,z  ,pitch)];
	f2 = fA[f_mem   (2 ,x             ,dmax(y-1)     ,z  ,pitch)];
	f5 = fA[f_mem   (5 ,dmax(x-1)     ,dmax(y-1)     ,z  ,pitch)];
	f6 = fA[f_mem   (6 ,dmin(x+1,XDIM),dmax(y-1)     ,z  ,pitch)];
	f4 = fA[f_mem   (4 ,x             ,dmin(y+1,YDIM),z  ,pitch)];
	f7 = fA[f_mem   (7 ,dmin(x+1,XDIM),dmin(y+1,YDIM),z  ,pitch)];
	f8 = fA[f_mem   (8 ,dmax(x-1)     ,dmin(y+1,YDIM),z  ,pitch)];
	f9 = fA[f_mem   (9 ,x             ,y             ,z-1,pitch)];
	f10= fA[f_mem   (10,dmax(x-1)     ,y             ,z-1,pitch)];
	f11= fA[f_mem   (11,x             ,dmax(y-1)     ,z-1,pitch)];
	f12= fA[f_mem   (12,dmin(x+1,XDIM),y             ,z-1,pitch)];
	f13= fA[f_mem   (13,x             ,dmin(y+1,YDIM),z-1,pitch)];
	f14= h [buff_mem(14,x             ,y             ,pitch)];
	f15= h [buff_mem(15,dmax(x-1)     ,y             ,pitch)];
	f16= h [buff_mem(16,x             ,dmax(y-1)     ,pitch)];
	f17= h [buff_mem(17,dmin(x+1,XDIM),y             ,pitch)];
	f18= h [buff_mem(18,x             ,dmin(y+1,YDIM),pitch)];
    }
    else if(z==0){//bottom nodes need info from g
	f0 = fA[j];
	f1 = fA[f_mem   (1 ,dmax(x-1)     ,y             ,z  ,pitch)];
	f3 = fA[f_mem   (3 ,dmin(x+1,XDIM),y             ,z  ,pitch)];
	f2 = fA[f_mem   (2 ,x             ,dmax(y-1)     ,z  ,pitch)];
	f5 = fA[f_mem   (5 ,dmax(x-1)     ,dmax(y-1)     ,z  ,pitch)];
	f6 = fA[f_mem   (6 ,dmin(x+1,XDIM),dmax(y-1)     ,z  ,pitch)];
	f4 = fA[f_mem   (4 ,x             ,dmin(y+1,YDIM),z  ,pitch)];
	f7 = fA[f_mem   (7 ,dmin(x+1,XDIM),dmin(y+1,YDIM),z  ,pitch)];
	f8 = fA[f_mem   (8 ,dmax(x-1)     ,dmin(y+1,YDIM),z  ,pitch)];
	f9 = h [buff_mem(9 ,x             ,y             ,pitch)];
	f10= h [buff_mem(10,dmax(x-1)     ,y             ,pitch)];
	f11= h [buff_mem(11,x             ,dmax(y-1)     ,pitch)];
	f12= h [buff_mem(12,dmin(x+1,XDIM),y             ,pitch)];
	f13= h [buff_mem(13,x             ,dmin(y+1,YDIM),pitch)];
	f14= fA[f_mem   (14,x             ,y             ,z+1,pitch)];
	f15= fA[f_mem   (15,dmax(x-1)     ,y             ,z+1,pitch)];
	f16= fA[f_mem   (16,x             ,dmax(y-1)     ,z+1,pitch)];
	f17= fA[f_mem   (17,dmin(x+1,XDIM),y             ,z+1,pitch)];
	f18= fA[f_mem   (18,x             ,dmin(y+1,YDIM),z+1,pitch)];
    }
    else{//normal nodes
	f0 = fA[j];
	f1 = fA[f_mem(1 ,dmax(x-1)     ,y             ,z,pitch)];
	f3 = fA[f_mem(3 ,dmin(x+1,XDIM),y             ,z,pitch)];
	f2 = fA[f_mem(2 ,x             ,dmax(y-1)     ,z,pitch)];
	f5 = fA[f_mem(5 ,dmax(x-1)     ,dmax(y-1)     ,z,pitch)];
	f6 = fA[f_mem(6 ,dmin(x+1,XDIM),dmax(y-1)     ,z,pitch)];
	f4 = fA[f_mem(4 ,x             ,dmin(y+1,YDIM),z,pitch)];
	f7 = fA[f_mem(7 ,dmin(x+1,XDIM),dmin(y+1,YDIM),z,pitch)];
	f8 = fA[f_mem(8 ,dmax(x-1)     ,dmin(y+1,YDIM),z,pitch)];
	f9 = fA[f_mem(9 ,x             ,y             ,z,pitch)];
	f10= fA[f_mem(10,dmax(x-1)     ,y             ,z,pitch)];
	f11= fA[f_mem(11,x             ,dmax(y-1)     ,z,pitch)];
	f12= fA[f_mem(12,dmin(x+1,XDIM),y             ,z,pitch)];
	f13= fA[f_mem(13,x             ,dmin(y+1,YDIM),z,pitch)];
	f14= fA[f_mem(14,x             ,y             ,z,pitch)];
	f15= fA[f_mem(15,dmax(x-1)     ,y             ,z,pitch)];
	f16= fA[f_mem(16,x             ,dmax(y-1)     ,z,pitch)];
	f17= fA[f_mem(17,dmin(x+1,XDIM),y             ,z,pitch)];
	f18= fA[f_mem(18,x             ,dmin(y+1,YDIM),z,pitch)];

    }//end normal nodes

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

__global__ void update_bottom(float* gA, float* gB, float* f, float* temp,
							float omega, size_t pitch, int GPU)//pitch in elements
{
	int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
	int y = threadIdx.y+blockIdx.y*blockDim.y;
	int j = x+y*pitch;//index on padded mem (pitch in elements)
	int im = ImageFcn(x,y,GPU*ZDIM/2);
	float f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18;

	f0 = gA  [j];
	f1 = gA  [buff_mem(1 ,dmax(x-1)     ,y             ,pitch)];
	f3 = gA  [buff_mem(3 ,dmin(x+1,XDIM),y             ,pitch)];
	f2 = gA  [buff_mem(2 ,x             ,dmax(y-1)     ,pitch)];
	f5 = gA  [buff_mem(5 ,dmax(x-1)     ,dmax(y-1)     ,pitch)];
	f6 = gA  [buff_mem(6 ,dmin(x+1,XDIM),dmax(y-1)     ,pitch)];
	f4 = gA  [buff_mem(4 ,x             ,dmin(y+1,YDIM),pitch)];
	f7 = gA  [buff_mem(7 ,dmin(x+1,XDIM),dmin(y+1,YDIM),pitch)];
	f8 = gA  [buff_mem(8 ,dmax(x-1)     ,dmin(y+1,YDIM),pitch)];
	f9 = temp[buff_mem(9 ,x             ,y             ,pitch)];
	f10= temp[buff_mem(10,dmax(x-1)     ,y             ,pitch)];
	f11= temp[buff_mem(11,x             ,dmax(y-1)     ,pitch)];
	f12= temp[buff_mem(12,dmin(x+1,XDIM),y             ,pitch)];
	f13= temp[buff_mem(13,x             ,dmin(y+1,YDIM),pitch)];
	f14= f   [f_mem   (14,x             ,y             ,0,pitch)];
	f15= f   [f_mem   (15,dmax(x-1)     ,y             ,0,pitch)];
	f16= f   [f_mem   (16,x             ,dmax(y-1)     ,0,pitch)];
	f17= f   [f_mem   (17,dmin(x+1,XDIM),y             ,0,pitch)];
	f18= f   [f_mem   (18,x             ,dmin(y+1,YDIM),0,pitch)];

	if(im == 1 || im ==10){//BB
		gB[buff_mem(0 ,x,y,pitch)] = f0 ;
		gB[buff_mem(1 ,x,y,pitch)] = f3 ;
		gB[buff_mem(2 ,x,y,pitch)] = f4 ;
		gB[buff_mem(3 ,x,y,pitch)] = f1 ;
		gB[buff_mem(4 ,x,y,pitch)] = f2 ;
		gB[buff_mem(5 ,x,y,pitch)] = f7 ;
		gB[buff_mem(6 ,x,y,pitch)] = f8 ;
		gB[buff_mem(7 ,x,y,pitch)] = f5 ;
		gB[buff_mem(8 ,x,y,pitch)] = f6 ;
		gB[buff_mem(9 ,x,y,pitch)] = f14;
		gB[buff_mem(10,x,y,pitch)] = f17;
		gB[buff_mem(11,x,y,pitch)] = f18;
		gB[buff_mem(12,x,y,pitch)] = f15;
		gB[buff_mem(13,x,y,pitch)] = f16;
		gB[buff_mem(14,x,y,pitch)] = f9 ;
		gB[buff_mem(15,x,y,pitch)] = f12;
		gB[buff_mem(16,x,y,pitch)] = f13;
		gB[buff_mem(17,x,y,pitch)] = f10;
		gB[buff_mem(18,x,y,pitch)] = f11;
	}
	else{

		boundaries(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,y,GPU*ZDIM/2,im);

		if(MODEL == "MRT")
		mrt_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,omega);
		else if(MODEL == "BGK")
		bgk_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,omega);

		gB[buff_mem(0 ,x,y,pitch)] = f0 ;
		gB[buff_mem(1 ,x,y,pitch)] = f1 ;
		gB[buff_mem(2 ,x,y,pitch)] = f2 ;
		gB[buff_mem(3 ,x,y,pitch)] = f3 ;
		gB[buff_mem(4 ,x,y,pitch)] = f4 ;
		gB[buff_mem(5 ,x,y,pitch)] = f5 ;
		gB[buff_mem(6 ,x,y,pitch)] = f6 ;
		gB[buff_mem(7 ,x,y,pitch)] = f7 ;
		gB[buff_mem(8 ,x,y,pitch)] = f8 ;
		gB[buff_mem(9 ,x,y,pitch)] = f9 ;
		gB[buff_mem(10,x,y,pitch)] = f10;
		gB[buff_mem(11,x,y,pitch)] = f11;
		gB[buff_mem(12,x,y,pitch)] = f12;
		gB[buff_mem(13,x,y,pitch)] = f13;
		gB[buff_mem(14,x,y,pitch)] = f14;
		gB[buff_mem(15,x,y,pitch)] = f15;
		gB[buff_mem(16,x,y,pitch)] = f16;
		gB[buff_mem(17,x,y,pitch)] = f17;
		gB[buff_mem(18,x,y,pitch)] = f18;
	}
//	}
}

__global__ void update_top(float* hA, float* hB, float* f, float* temp,
							float omega, size_t pitch, int GPU)//pitch in elements
{
	int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
	int y = threadIdx.y+blockIdx.y*blockDim.y;
	int j = x+y*pitch;//index on padded mem (pitch in elements)
	int im = ImageFcn(x,y,(GPU+1)*ZDIM/2-1);
	float f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18;

	f0 = hA[j];
	f1 = hA  [buff_mem(1 ,dmax(x-1)     ,y             ,pitch)];
	f3 = hA  [buff_mem(3 ,dmin(x+1,XDIM),y             ,pitch)];
	f2 = hA  [buff_mem(2 ,x             ,dmax(y-1)     ,pitch)];
	f5 = hA  [buff_mem(5 ,dmax(x-1)     ,dmax(y-1)     ,pitch)];
	f6 = hA  [buff_mem(6 ,dmin(x+1,XDIM),dmax(y-1)     ,pitch)];
	f4 = hA  [buff_mem(4 ,x             ,dmin(y+1,YDIM),pitch)];
	f7 = hA  [buff_mem(7 ,dmin(x+1,XDIM),dmin(y+1,YDIM),pitch)];
	f8 = hA  [buff_mem(8 ,dmax(x-1)     ,dmin(y+1,YDIM),pitch)];
	f9 = f   [f_mem   (9 ,x             ,y             ,ZDIM/2-2-1,pitch)];
	f10= f   [f_mem   (10,dmax(x-1)     ,y             ,ZDIM/2-2-1,pitch)];
	f11= f   [f_mem   (11,x             ,dmax(y-1)     ,ZDIM/2-2-1,pitch)];
	f12= f   [f_mem   (12,dmin(x+1,XDIM),y             ,ZDIM/2-2-1,pitch)];
	f13= f   [f_mem   (13,x             ,dmin(y+1,YDIM),ZDIM/2-2-1,pitch)];
	f14= temp[buff_mem(14,x             ,y             ,pitch)];
	f15= temp[buff_mem(15,dmax(x-1)     ,y             ,pitch)];
	f16= temp[buff_mem(16,x             ,dmax(y-1)     ,pitch)];
	f17= temp[buff_mem(17,dmin(x+1,XDIM),y             ,pitch)];
	f18= temp[buff_mem(18,x             ,dmin(y+1,YDIM),pitch)];

	if(im == 1 || im ==10){//BB
		hB[buff_mem(0 ,x,y,pitch)] = f0 ;
		hB[buff_mem(1 ,x,y,pitch)] = f3 ;
		hB[buff_mem(2 ,x,y,pitch)] = f4 ;
		hB[buff_mem(3 ,x,y,pitch)] = f1 ;
		hB[buff_mem(4 ,x,y,pitch)] = f2 ;
		hB[buff_mem(5 ,x,y,pitch)] = f7 ;
		hB[buff_mem(6 ,x,y,pitch)] = f8 ;
		hB[buff_mem(7 ,x,y,pitch)] = f5 ;
		hB[buff_mem(8 ,x,y,pitch)] = f6 ;
		hB[buff_mem(9 ,x,y,pitch)] = f14;
		hB[buff_mem(10,x,y,pitch)] = f17;
		hB[buff_mem(11,x,y,pitch)] = f18;
		hB[buff_mem(12,x,y,pitch)] = f15;
		hB[buff_mem(13,x,y,pitch)] = f16;
		hB[buff_mem(14,x,y,pitch)] = f9 ;
		hB[buff_mem(15,x,y,pitch)] = f12;
		hB[buff_mem(16,x,y,pitch)] = f13;
		hB[buff_mem(17,x,y,pitch)] = f10;
		hB[buff_mem(18,x,y,pitch)] = f11;
	}
	else{

		boundaries(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,y,GPU*ZDIM/2,im);

		if(MODEL == "MRT")
		mrt_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,omega);
		else if(MODEL == "BGK")
		bgk_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,omega);

		hB[buff_mem(0 ,x,y,pitch)] = f0 ;
		hB[buff_mem(1 ,x,y,pitch)] = f1 ;
		hB[buff_mem(2 ,x,y,pitch)] = f2 ;
		hB[buff_mem(3 ,x,y,pitch)] = f3 ;
		hB[buff_mem(4 ,x,y,pitch)] = f4 ;
		hB[buff_mem(5 ,x,y,pitch)] = f5 ;
		hB[buff_mem(6 ,x,y,pitch)] = f6 ;
		hB[buff_mem(7 ,x,y,pitch)] = f7 ;
		hB[buff_mem(8 ,x,y,pitch)] = f8 ;
		hB[buff_mem(9 ,x,y,pitch)] = f9 ;
		hB[buff_mem(10,x,y,pitch)] = f10;
		hB[buff_mem(11,x,y,pitch)] = f11;
		hB[buff_mem(12,x,y,pitch)] = f12;
		hB[buff_mem(13,x,y,pitch)] = f13;
		hB[buff_mem(14,x,y,pitch)] = f14;
		hB[buff_mem(15,x,y,pitch)] = f15;
		hB[buff_mem(16,x,y,pitch)] = f16;
		hB[buff_mem(17,x,y,pitch)] = f17;
		hB[buff_mem(18,x,y,pitch)] = f18;
	}
//	}
}




__device__ __inline__ float ld_gb1_cg(const float *addr)
{
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

f[j+0 *pitch*YDIM*(ZDIM/2-2)]=f0 ;
f[j+1 *pitch*YDIM*(ZDIM/2-2)]=f1 ;
f[j+2 *pitch*YDIM*(ZDIM/2-2)]=f2 ;
f[j+3 *pitch*YDIM*(ZDIM/2-2)]=f3 ;
f[j+4 *pitch*YDIM*(ZDIM/2-2)]=f4 ;
f[j+5 *pitch*YDIM*(ZDIM/2-2)]=f5 ;
f[j+6 *pitch*YDIM*(ZDIM/2-2)]=f6 ;
f[j+7 *pitch*YDIM*(ZDIM/2-2)]=f7 ;
f[j+8 *pitch*YDIM*(ZDIM/2-2)]=f8 ;
f[j+9 *pitch*YDIM*(ZDIM/2-2)]=f9 ;
f[j+10*pitch*YDIM*(ZDIM/2-2)]=f10;
f[j+11*pitch*YDIM*(ZDIM/2-2)]=f11;
f[j+12*pitch*YDIM*(ZDIM/2-2)]=f12;
f[j+13*pitch*YDIM*(ZDIM/2-2)]=f13;
f[j+14*pitch*YDIM*(ZDIM/2-2)]=f14;
f[j+15*pitch*YDIM*(ZDIM/2-2)]=f15;
f[j+16*pitch*YDIM*(ZDIM/2-2)]=f16;
f[j+17*pitch*YDIM*(ZDIM/2-2)]=f17;
f[j+18*pitch*YDIM*(ZDIM/2-2)]=f18;

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

__global__ void initialize_buffer(float *g, size_t pitch)//pitch in elements
{
	int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
	int y = threadIdx.y+blockIdx.y*blockDim.y;
	int j = x+y*pitch;//index on padded mem (pitch in elements)
	
	float u,v,w,rho,usqr;
	rho = 1.f;
	u = 0.0f;
	v = UMAX;
	w = 0.0f;

	usqr = u*u+v*v+w*w;

    if(MODEL == "BGK"){ 
	g[j+0 *pitch*YDIM]= 1.0f/3.0f*(rho-1.5f*usqr);
	g[j+1 *pitch*YDIM]= 1.0f/18.0f*(rho+3.0f*u+4.5f*u*u-1.5f*usqr);
	g[j+2 *pitch*YDIM]= 1.0f/18.0f*(rho+3.0f*v+4.5f*v*v-1.5f*usqr);
	g[j+3 *pitch*YDIM]= 1.0f/18.0f*(rho-3.0f*u+4.5f*u*u-1.5f*usqr);
	g[j+4 *pitch*YDIM]= 1.0f/18.0f*(rho-3.0f*v+4.5f*v*v-1.5f*usqr);
	g[j+5 *pitch*YDIM]= 1.0f/36.0f*(rho+3.0f*(u+v)+4.5f*(u+v)*(u+v)-1.5f*usqr);
	g[j+6 *pitch*YDIM]= 1.0f/36.0f*(rho+3.0f*(-u+v)+4.5f*(-u+v)*(-u+v)-1.5f*usqr);
	g[j+7 *pitch*YDIM]= 1.0f/36.0f*(rho+3.0f*(-u-v)+4.5f*(-u-v)*(-u-v)-1.5f*usqr);
	g[j+8 *pitch*YDIM]= 1.0f/36.0f*(rho+3.0f*(u-v)+4.5f*(u-v)*(u-v)-1.5f*usqr);
	g[j+9 *pitch*YDIM]= 1.0f/18.0f*(rho+3.0f*w+4.5f*w*w-1.5f*usqr);
	g[j+10*pitch*YDIM]= 1.0f/36.0f*(rho+3.0f*(u+w)+4.5f*(u+w)*(u+w)-1.5f*usqr);
	g[j+11*pitch*YDIM]= 1.0f/36.0f*(rho+3.0f*(v+w)+4.5f*(v+w)*(v+w)-1.5f*usqr);
	g[j+12*pitch*YDIM]= 1.0f/36.0f*(rho+3.0f*(-u+w)+4.5f*(-u+w)*(-u+w)-1.5f*usqr);
	g[j+13*pitch*YDIM]= 1.0f/36.0f*(rho+3.0f*(-v+w)+4.5f*(-v+w)*(-v+w)-1.5f*usqr);
	g[j+14*pitch*YDIM]= 1.0f/18.0f*(rho-3.0f*w+4.5f*w*w-1.5f*usqr);
	g[j+15*pitch*YDIM]= 1.0f/36.0f*(rho+3.0f*(u-w)+4.5f*(u-w)*(u-w)-1.5f*usqr);
	g[j+16*pitch*YDIM]= 1.0f/36.0f*(rho+3.0f*(v-w)+4.5f*(v-w)*(v-w)-1.5f*usqr);
	g[j+17*pitch*YDIM]= 1.0f/36.0f*(rho+3.0f*(-u-w)+4.5f*(-u-w)*(-u-w)-1.5f*usqr);
	g[j+18*pitch*YDIM]= 1.0f/36.0f*(rho+3.0f*(-v-w)+4.5f*(-v-w)*(-v-w)-1.5f*usqr);   
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

g[j+0 *pitch*YDIM]=f0 ;
g[j+1 *pitch*YDIM]=f1 ;
g[j+2 *pitch*YDIM]=f2 ;
g[j+3 *pitch*YDIM]=f3 ;
g[j+4 *pitch*YDIM]=f4 ;
g[j+5 *pitch*YDIM]=f5 ;
g[j+6 *pitch*YDIM]=f6 ;
g[j+7 *pitch*YDIM]=f7 ;
g[j+8 *pitch*YDIM]=f8 ;
g[j+9 *pitch*YDIM]=f9 ;
g[j+10*pitch*YDIM]=f10;
g[j+11*pitch*YDIM]=f11;
g[j+12*pitch*YDIM]=f12;
g[j+13*pitch*YDIM]=f13;
g[j+14*pitch*YDIM]=f14;
g[j+15*pitch*YDIM]=f15;
g[j+16*pitch*YDIM]=f16;
g[j+17*pitch*YDIM]=f17;
g[j+18*pitch*YDIM]=f18;

    }
}


int main(int argc, char *argv[])
{
	int GPU_N;
	cudaGetDeviceCount(&GPU_N);
    GPU_N = 2;
	cout<<"number of GPUs: "<<GPU_N<<endl;


	//int *image_d, *image_h;

	ofstream output;
	ofstream output2;
	string FileName = CASENAME;
	//output.open ("LBM1_out.dat");
	output.open ((FileName+".dat").c_str());
	output2.open ((FileName+".force").c_str());

	//size_t memsize, memsize2;
	size_t pitch = 0;
	int i, n, nBlocks;
	float omega, CharLength;

	CharLength = OBSTR1*2.f;

	omega = 1.0f/(3.0f*(UMAX*CharLength/RE)+0.5f);

	cout<<"omega : "<<omega<<endl;
	cout<<"blocksize: "<<BLOCKSIZEX<<"x"<<BLOCKSIZEY<<"x"<<BLOCKSIZEZ<<endl;
	cout<<"grid: "<<XDIM<<"x"<<YDIM<<"x"<<ZDIM<<endl;
	cout<<"TMAX: "<<TMAX<<endl;
	cout<<"Method: "<<METHOD<<endl;
	cout<<"Model: "<<MODEL<<endl;

    int zInner = ZDIM/GPU_N-2;

	//nBlocks does not include the halo layers
	nBlocks = ((XDIM+BLOCKSIZEX-1)/BLOCKSIZEX)*((YDIM+BLOCKSIZEY-1)/BLOCKSIZEY)
				*((zInner+BLOCKSIZEZ-1)/BLOCKSIZEZ);
	int B = BLOCKSIZEX*BLOCKSIZEY*BLOCKSIZEZ;
	n = nBlocks*B;
	cout<<"nBlocks:"<<nBlocks<<endl;

    dim3 threads(BLOCKSIZEX, BLOCKSIZEY, BLOCKSIZEZ);
	//2 halo layers per GPU (for 2 GPUs)
    dim3 grid(((XDIM+BLOCKSIZEX-1)/BLOCKSIZEX),((YDIM+BLOCKSIZEY-1)/BLOCKSIZEY),(zInner)/BLOCKSIZEZ);
    dim3 g_grid(((XDIM+BLOCKSIZEX-1)/BLOCKSIZEX),((YDIM+BLOCKSIZEY-1)/BLOCKSIZEY),1);
    dim3 h_grid(((XDIM+BLOCKSIZEX-1)/BLOCKSIZEX),((YDIM+BLOCKSIZEY-1)/BLOCKSIZEY),1);

	cudaStream_t stream[2];

	cudaSetDevice(0);
	
    //buffers g,h
	float *gA_h;
	float *gA_d ,*gB_d;
	float *gA_temp_d;
	float *hA_h;
	float *hA_d ,*hB_d;
	float *hA_temp_d;

	cudaStreamCreate(&stream[0]);
	cudaStreamCreate(&stream[1]);
	//image_h = (int *)malloc(memsize_int);
	float *fA_h,*fA_d,*fB_d;
	float *FX_h,*FY_h,*FZ_h,*FX_d,*FY_d,*FZ_d;
	gA_h = (float *)malloc(XDIM*YDIM*19*sizeof(float));
	hA_h = (float *)malloc(XDIM*YDIM*19*sizeof(float));
	fA_h = (float *)malloc(XDIM*YDIM*zInner*sizeof(float)*19);//(float *)malloc(memsize *19);
	FX_h = (float *)malloc(TMAX*sizeof(float));
	FY_h = (float *)malloc(TMAX*sizeof(float));
	FZ_h = (float *)malloc(TMAX*sizeof(float));
	cudaMallocPitch((void **) &fA_d, &pitch, XDIM*sizeof(float), YDIM*zInner*19);
	cudaMallocPitch((void **) &fB_d, &pitch, XDIM*sizeof(float), YDIM*zInner*19);
	cudaMallocPitch((void **) &gA_d, &pitch, XDIM*sizeof(float), YDIM*19);
	cudaMallocPitch((void **) &gB_d, &pitch, XDIM*sizeof(float), YDIM*19);
	cudaMallocPitch((void **) &hA_d, &pitch, XDIM*sizeof(float), YDIM*19);
	cudaMallocPitch((void **) &hB_d, &pitch, XDIM*sizeof(float), YDIM*19);
	cudaMallocPitch((void **) &gA_temp_d, &pitch, XDIM*sizeof(float), YDIM*19);
	cudaMallocPitch((void **) &hA_temp_d, &pitch, XDIM*sizeof(float), YDIM*19);

	cudaMalloc((void **) &FX_d, TMAX*sizeof(float));
	cudaMalloc((void **) &FY_d, TMAX*sizeof(float));
	cudaMalloc((void **) &FZ_d, TMAX*sizeof(float));

	size_t pitch_elements = pitch/sizeof(float);

	cudaChannelFormatDesc desc = cudaCreateChannelDesc<float>();
	
	//initialize host f
	for (i = 0; i < n*19; i++)
	{
		fA_h[i] = 0;
	}
	//initialize host g,h
	for (i = 0; i < XDIM*YDIM*19; i++)
	{
		gA_h[i] = 0;
		hA_h[i] = 0;
	}
	//initialize host FX
	for (i = 0; i < TMAX; i++){
		FX_h[i] = 0.f;
		FY_h[i] = 0.f;
		FZ_h[i] = 0.f;
	}

	//memcpy FX
	cudaMemcpy(FX_d, FX_h, TMAX*sizeof(float), cudaMemcpyHostToDevice);
	cudaMemcpy(FY_d, FY_h, TMAX*sizeof(float), cudaMemcpyHostToDevice);
	cudaMemcpy(FZ_d, FZ_h, TMAX*sizeof(float), cudaMemcpyHostToDevice);


	cudaMemcpy2D(fA_d,pitch ,fA_h,XDIM*sizeof(float),XDIM*sizeof(float),YDIM*zInner*19,cudaMemcpyHostToDevice);
	cudaMemcpy2D(fB_d,pitch ,fA_h,XDIM*sizeof(float),XDIM*sizeof(float),YDIM*zInner*19,cudaMemcpyHostToDevice);
	cudaMemcpy2D(gA_d,pitch ,gA_h,XDIM*sizeof(float),XDIM*sizeof(float),YDIM*19,cudaMemcpyHostToDevice);
	cudaMemcpy2D(gB_d,pitch ,gA_h,XDIM*sizeof(float),XDIM*sizeof(float),YDIM*19,cudaMemcpyHostToDevice);
	cudaMemcpy2D(hA_d,pitch ,hA_h,XDIM*sizeof(float),XDIM*sizeof(float),YDIM*19,cudaMemcpyHostToDevice);
	cudaMemcpy2D(hB_d,pitch ,hA_h,XDIM*sizeof(float),XDIM*sizeof(float),YDIM*19,cudaMemcpyHostToDevice);


	cudaSetDevice(1);
	cudaStreamCreate(&stream[0]);
	cudaStreamCreate(&stream[1]);
	
    float *gA_d2,*gB_d2;
	float *gA_h2;
	float *gA_temp_d2;
	float *hA_d2,*hB_d2;
	float *hA_h2;
	float *hA_temp_d2;

	float *fA_h2,*fA_d2,*fB_d2;
	float *FX_h2,*FY_h2,*FZ_h2,*FX_d2,*FY_d2,*FZ_d2;
	gA_h2 = (float *)malloc(XDIM*YDIM*19*sizeof(float));
	hA_h2 = (float *)malloc(XDIM*YDIM*19*sizeof(float));
	fA_h2 = (float *)malloc(XDIM*YDIM*zInner*sizeof(float)*19);//(float *)malloc(memsize*19);
	FX_h2 = (float *)malloc(TMAX*sizeof(float));
	FY_h2 = (float *)malloc(TMAX*sizeof(float));
	FZ_h2 = (float *)malloc(TMAX*sizeof(float));
	cudaMallocPitch((void **) &fA_d2, &pitch, XDIM*sizeof(float), YDIM*zInner*19);
	cudaMallocPitch((void **) &fB_d2, &pitch, XDIM*sizeof(float), YDIM*zInner*19);
	cudaMallocPitch((void **) &gA_d2, &pitch, XDIM*sizeof(float), YDIM*19);
	cudaMallocPitch((void **) &gB_d2, &pitch, XDIM*sizeof(float), YDIM*19);
	cudaMallocPitch((void **) &hA_d2, &pitch, XDIM*sizeof(float), YDIM*19);
	cudaMallocPitch((void **) &hB_d2, &pitch, XDIM*sizeof(float), YDIM*19);
	cudaMallocPitch((void **) &gA_temp_d2, &pitch, XDIM*sizeof(float), YDIM*19);
	cudaMallocPitch((void **) &hA_temp_d2, &pitch, XDIM*sizeof(float), YDIM*19);

	cudaMalloc((void **) &FX_d2, TMAX*sizeof(float));
	cudaMalloc((void **) &FY_d2, TMAX*sizeof(float));
	cudaMalloc((void **) &FZ_d2, TMAX*sizeof(float));

	for (i = 0; i < n*19; i++)
	{
		fA_h2[i] = 0;
	}
	//initialize host g,h
	for (i = 0; i < XDIM*YDIM*19; i++)
	{
		gA_h2[i] = 0;
		hA_h2[i] = 0;
	}

	for (i = 0; i < TMAX; i++){
		FX_h2[i] = 0.f;
		FY_h2[i] = 0.f;
		FZ_h2[i] = 0.f;
	}

	cudaMemcpy(FX_d2, FX_h2, TMAX*sizeof(float), cudaMemcpyHostToDevice);
	cudaMemcpy(FY_d2, FY_h2, TMAX*sizeof(float), cudaMemcpyHostToDevice);
	cudaMemcpy(FZ_d2, FZ_h2, TMAX*sizeof(float), cudaMemcpyHostToDevice);

	cudaMemcpy2D(fA_d2,pitch ,fA_h2,XDIM*sizeof(float),XDIM*sizeof(float),YDIM*zInner*19,cudaMemcpyHostToDevice);
	cudaMemcpy2D(fB_d2,pitch ,fA_h2,XDIM*sizeof(float),XDIM*sizeof(float),YDIM*zInner*19,cudaMemcpyHostToDevice);
	cudaMemcpy2D(gA_d2,pitch ,gA_h2,XDIM*sizeof(float),XDIM*sizeof(float),YDIM*19,cudaMemcpyHostToDevice);
	cudaMemcpy2D(gB_d2,pitch ,gA_h2,XDIM*sizeof(float),XDIM*sizeof(float),YDIM*19,cudaMemcpyHostToDevice);
	cudaMemcpy2D(hA_d2,pitch ,hA_h2,XDIM*sizeof(float),XDIM*sizeof(float),YDIM*19,cudaMemcpyHostToDevice);
	cudaMemcpy2D(hB_d2,pitch ,hA_h2,XDIM*sizeof(float),XDIM*sizeof(float),YDIM*19,cudaMemcpyHostToDevice);

	cudaSetDevice(0);
	initialize_single<<<grid, threads>>>(fA_d,pitch_elements);
	initialize_single<<<grid, threads>>>(fB_d,pitch_elements);
	initialize_buffer<<<g_grid, threads>>>(gA_d,pitch_elements);
	initialize_buffer<<<h_grid, threads>>>(hA_d,pitch_elements);
	initialize_buffer<<<g_grid, threads>>>(gB_d,pitch_elements);
	initialize_buffer<<<h_grid, threads>>>(hB_d,pitch_elements);
	cudaSetDevice(1);
	initialize_single<<<grid, threads>>>(fA_d2,pitch_elements);
	initialize_single<<<grid, threads>>>(fB_d2,pitch_elements);
	initialize_buffer<<<g_grid, threads>>>(gA_d2,pitch_elements);
	initialize_buffer<<<h_grid, threads>>>(hA_d2,pitch_elements);
	initialize_buffer<<<g_grid, threads>>>(gB_d2,pitch_elements);
	initialize_buffer<<<h_grid, threads>>>(hB_d2,pitch_elements);
	cudaSetDevice(0);


	struct timeval tdr0,tdr1;
	double restime;
	cudaDeviceSynchronize();
	gettimeofday (&tdr0,NULL);
    //time loop
	for(int t = 0; t<1; t=t++){

		//memcpy from dev0 to dev1
		//cudaMemcpyPeerAsync(*dst,dstdev#,*src,srcdev#,size_t(bytes),cudastream#);

        //send g from dev1 to h of dev0
		cudaMemcpyPeerAsync(&hA_temp_d[pitch_elements*YDIM*14],0,&gA_d2[pitch_elements*YDIM*14],1,pitch_elements*YDIM*sizeof(float)*5,stream[0]);
        //send g from dev0 to h of dev1
		cudaMemcpyPeerAsync(&hA_temp_d2[pitch_elements*YDIM*14],1,&gA_d[pitch_elements*YDIM*14],0,pitch_elements*YDIM*sizeof(float)*5,stream[0]);

        //send h from dev1 to g of dev0
		cudaMemcpyPeerAsync(&gA_temp_d[pitch_elements*YDIM*9],0,&hA_d2[pitch_elements*YDIM*9],1,pitch_elements*YDIM*sizeof(float)*5,stream[0]);
        //send h from dev0 to g of dev1
		cudaMemcpyPeerAsync(&gA_temp_d2[pitch_elements*YDIM*9],1,&hA_d[pitch_elements*YDIM*9],0,pitch_elements*YDIM*sizeof(float)*5,stream[0]);
	
    cudaDeviceSynchronize();

		cudaSetDevice(0);
		update_inner <<<grid, threads>>>(fA_d,fB_d,gA_d,hA_d,omega,pitch_elements,0);
		update_top   <<<h_grid, threads>>>(hA_d,hB_d,fA_d,hA_temp_d,omega,pitch_elements,0);
		update_bottom<<<h_grid, threads>>>(gA_d,gB_d,fA_d,gA_temp_d,omega,pitch_elements,0);

        cudaSetDevice(1);
		update_inner <<<grid, threads>>>(fA_d2,fB_d2,gA_d2,hA_d2,omega,pitch_elements,1);
		update_top   <<<h_grid, threads>>>(hA_d2,hB_d2,fA_d2,hA_temp_d2,omega,pitch_elements,1);
		update_bottom<<<h_grid, threads>>>(gA_d2,gB_d2,fA_d2,gA_temp_d2,omega,pitch_elements,1);


//		if(METHOD == "SINGLE"){
//		if(t >= STARTF)
//		mrt_d_single_force<<<grid, threads>>>(fA_d,fB_d,omega,pitch_elements,FX_d,FY_d,FZ_d,t,uAv_d,vAv_d,ufluc_d,vfluc_d,0);
//		else
//		mrt_d_single<<<grid, threads>>>(fA_d,fB_d,omega,pitch_elements,0);
//		
//
//		if(t >= STARTF)
//		mrt_d_single_force<<<grid, threads>>>(fB_d,fA_d,omega,pitch_elements,FX_d,FY_d,FZ_d,t+1,uAv_d,vAv_d,ufluc_d,vfluc_d,0);
//		else
//		mrt_d_single<<<grid, threads>>>(fB_d,fA_d,omega,pitch_elements,0);
//		}
//
//		cudaSetDevice(1);
//
//		if(METHOD == "SINGLE"){
//		if(t >= STARTF)
//		mrt_d_single_force<<<grid, threads>>>(fA_d2,fB_d2,omega,pitch_elements,FX_d2,FY_d2,FZ_d2,t,uAv_d2,vAv_d2,ufluc_d2,vfluc_d2,1);
//		else
//		mrt_d_single<<<grid, threads>>>(fA_d2,fB_d2,omega,pitch_elements,1);
//		
//
//		if(t >= STARTF)
//		mrt_d_single_force<<<grid, threads>>>(fB_d2,fA_d2,omega,pitch_elements,FX_d2,FY_d2,FZ_d2,t+1,uAv_d2,vAv_d2,ufluc_d2,vfluc_d2,1);
//		else
//		mrt_d_single<<<grid, threads>>>(fB_d2,fA_d2,omega,pitch_elements,1);
//		}
//		if(t%1000 == 0 && t>0) cout<<"finished "<<t<<" timesteps\n";
	}
	cudaDeviceSynchronize();
	cudaSetDevice(0);
	cudaDeviceSynchronize();

	gettimeofday (&tdr1,NULL);
	timeval_subtract (&restime, &tdr1, &tdr0);
	int Nodes;
	Nodes = XDIM*YDIM*ZDIM;
	cout<<"Time taken for main kernel: "<<restime<<" ("
			<<double(Nodes*double(TMAX/1000000.f))/restime<<"MLUPS)";
	cout<<endl;
	cout<<XDIM<<","<<YDIM<<","<<ZDIM<<","<<TMAX<<","<<restime<<endl;
	

	cudaMemcpy2D(fA_h,XDIM*sizeof(float),fB_d,pitch,XDIM*sizeof(float),YDIM*zInner*19,cudaMemcpyDeviceToHost);
	cudaMemcpy2D(gA_h,XDIM*sizeof(float),gB_d,pitch,XDIM*sizeof(float),YDIM*19,cudaMemcpyDeviceToHost);
	cudaMemcpy2D(hA_h,XDIM*sizeof(float),hB_d,pitch,XDIM*sizeof(float),YDIM*19,cudaMemcpyDeviceToHost);

	cudaMemcpy(FX_h, FX_d, TMAX*sizeof(float), cudaMemcpyDeviceToHost);
	cudaMemcpy(FY_h, FY_d, TMAX*sizeof(float), cudaMemcpyDeviceToHost);
	cudaMemcpy(FZ_h, FZ_d, TMAX*sizeof(float), cudaMemcpyDeviceToHost);

	cudaSetDevice(1);

	cudaMemcpy2D(fA_h2,XDIM*sizeof(float),fB_d2,pitch,XDIM*sizeof(float),YDIM*zInner*19,cudaMemcpyDeviceToHost);
	cudaMemcpy2D(gA_h2,XDIM*sizeof(float),gB_d2,pitch,XDIM*sizeof(float),YDIM*19,cudaMemcpyDeviceToHost);
	cudaMemcpy2D(hA_h2,XDIM*sizeof(float),hB_d2,pitch,XDIM*sizeof(float),YDIM*19,cudaMemcpyDeviceToHost);


	cudaMemcpy(FX_h2, FX_d2, TMAX*sizeof(float), cudaMemcpyDeviceToHost);
	cudaMemcpy(FY_h2, FY_d2, TMAX*sizeof(float), cudaMemcpyDeviceToHost);
	cudaMemcpy(FZ_h2, FZ_d2, TMAX*sizeof(float), cudaMemcpyDeviceToHost);

	cudaSetDevice(0);

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

	for(row = 0; row<YDIM; row++){
		for(col = 0; col<XDIM; col++){
 			i = row*XDIM+col;
            f0 = gA_h[i+XDIM*YDIM*0 ];
            f1 = gA_h[i+XDIM*YDIM*1 ];
            f2 = gA_h[i+XDIM*YDIM*2 ];
            f3 = gA_h[i+XDIM*YDIM*3 ];
            f4 = gA_h[i+XDIM*YDIM*4 ];
            f5 = gA_h[i+XDIM*YDIM*5 ];
            f6 = gA_h[i+XDIM*YDIM*6 ];
            f7 = gA_h[i+XDIM*YDIM*7 ];
            f8 = gA_h[i+XDIM*YDIM*8 ];
            f9 = gA_h[i+XDIM*YDIM*9 ];
            f10= gA_h[i+XDIM*YDIM*10];
            f11= gA_h[i+XDIM*YDIM*11];
            f12= gA_h[i+XDIM*YDIM*12];
            f13= gA_h[i+XDIM*YDIM*13];
            f14= gA_h[i+XDIM*YDIM*14];
            f15= gA_h[i+XDIM*YDIM*15];
            f16= gA_h[i+XDIM*YDIM*16];
            f17= gA_h[i+XDIM*YDIM*17];
            f18= gA_h[i+XDIM*YDIM*18];

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
			output<<col<<", "<<row<<", "<<0<<", "<<u<<","<<v<<","<<w<<","<<rho<<","
                  //<<uAv_h[i]<<","<<vAv_h[i]<<", "<<ufluc_h[i]<<","<<vfluc_h[i]<<endl;
                  <<f0<<","<<f1<<", "<<f9<<","<<f18<<endl;
        }
    }


	for(dep = 0; dep<zInner; dep++){
	for(row = 0; row<YDIM; row++){
		for(col = 0; col<XDIM; col++){
			i = dep*XDIM*YDIM+row*XDIM+col;
            f0 = fA_h[i+XDIM*YDIM*zInner*0 ];
            f1 = fA_h[i+XDIM*YDIM*zInner*1 ];
            f2 = fA_h[i+XDIM*YDIM*zInner*2 ];
            f3 = fA_h[i+XDIM*YDIM*zInner*3 ];
            f4 = fA_h[i+XDIM*YDIM*zInner*4 ];
            f5 = fA_h[i+XDIM*YDIM*zInner*5 ];
            f6 = fA_h[i+XDIM*YDIM*zInner*6 ];
            f7 = fA_h[i+XDIM*YDIM*zInner*7 ];
            f8 = fA_h[i+XDIM*YDIM*zInner*8 ];
            f9 = fA_h[i+XDIM*YDIM*zInner*9 ];
            f10= fA_h[i+XDIM*YDIM*zInner*10];
            f11= fA_h[i+XDIM*YDIM*zInner*11];
            f12= fA_h[i+XDIM*YDIM*zInner*12];
            f13= fA_h[i+XDIM*YDIM*zInner*13];
            f14= fA_h[i+XDIM*YDIM*zInner*14];
            f15= fA_h[i+XDIM*YDIM*zInner*15];
            f16= fA_h[i+XDIM*YDIM*zInner*16];
            f17= fA_h[i+XDIM*YDIM*zInner*17];
            f18= fA_h[i+XDIM*YDIM*zInner*18];

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

			output<<col<<", "<<row<<", "<<dep+1<<", "<<u<<","<<v<<","<<w<<","<<rho<<","
                  //<<uAv_h[i]<<","<<vAv_h[i]<<", "<<ufluc_h[i]<<","<<vfluc_h[i]<<endl;
                  <<f0<<","<<f1<<", "<<f9<<","<<f18<<endl;
            if(rho>-0.001f && rho<2.f){
            }
            else{
                check = 1;
            }
		}
	}
	}
    //top of GPU1
	for(row = 0; row<YDIM; row++){
		for(col = 0; col<XDIM; col++){
 			i = row*XDIM+col;
            f0 = hA_h[i+XDIM*YDIM*0 ];
            f1 = hA_h[i+XDIM*YDIM*1 ];
            f2 = hA_h[i+XDIM*YDIM*2 ];
            f3 = hA_h[i+XDIM*YDIM*3 ];
            f4 = hA_h[i+XDIM*YDIM*4 ];
            f5 = hA_h[i+XDIM*YDIM*5 ];
            f6 = hA_h[i+XDIM*YDIM*6 ];
            f7 = hA_h[i+XDIM*YDIM*7 ];
            f8 = hA_h[i+XDIM*YDIM*8 ];
            f9 = hA_h[i+XDIM*YDIM*9 ];
            f10= hA_h[i+XDIM*YDIM*10];
            f11= hA_h[i+XDIM*YDIM*11];
            f12= hA_h[i+XDIM*YDIM*12];
            f13= hA_h[i+XDIM*YDIM*13];
            f14= hA_h[i+XDIM*YDIM*14];
            f15= hA_h[i+XDIM*YDIM*15];
            f16= hA_h[i+XDIM*YDIM*16];
            f17= hA_h[i+XDIM*YDIM*17];
            f18= hA_h[i+XDIM*YDIM*18];

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
			output<<col<<", "<<row<<", "<<ZDIM/2-1<<", "<<u<<","<<v<<","<<w<<","<<rho<<","
                  //<<uAv_h[i]<<","<<vAv_h[i]<<", "<<ufluc_h[i]<<","<<vfluc_h[i]<<endl;
                  <<f0<<","<<f1<<", "<<f9<<","<<f18<<endl;
        }
    }


    //bottom of GPU2
	for(row = 0; row<YDIM; row++){
		for(col = 0; col<XDIM; col++){
 			i = row*XDIM+col;
            f0 = gA_h2[i+XDIM*YDIM*0 ];
            f1 = gA_h2[i+XDIM*YDIM*1 ];
            f2 = gA_h2[i+XDIM*YDIM*2 ];
            f3 = gA_h2[i+XDIM*YDIM*3 ];
            f4 = gA_h2[i+XDIM*YDIM*4 ];
            f5 = gA_h2[i+XDIM*YDIM*5 ];
            f6 = gA_h2[i+XDIM*YDIM*6 ];
            f7 = gA_h2[i+XDIM*YDIM*7 ];
            f8 = gA_h2[i+XDIM*YDIM*8 ];
            f9 = gA_h2[i+XDIM*YDIM*9 ];
            f10= gA_h2[i+XDIM*YDIM*10];
            f11= gA_h2[i+XDIM*YDIM*11];
            f12= gA_h2[i+XDIM*YDIM*12];
            f13= gA_h2[i+XDIM*YDIM*13];
            f14= gA_h2[i+XDIM*YDIM*14];
            f15= gA_h2[i+XDIM*YDIM*15];
            f16= gA_h2[i+XDIM*YDIM*16];
            f17= gA_h2[i+XDIM*YDIM*17];
            f18= gA_h2[i+XDIM*YDIM*18];

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
			output<<col<<", "<<row<<", "<<ZDIM/2<<", "<<u<<","<<v<<","<<w<<","<<rho<<","
                  //<<uAv_h[i]<<","<<vAv_h[i]<<", "<<ufluc_h[i]<<","<<vfluc_h[i]<<endl;
                  <<f0<<","<<f1<<", "<<f9<<","<<f18<<endl;
        }
    }

	for(dep = 0; dep<zInner; dep++){
	for(row = 0; row<YDIM; row++){
		for(col = 0; col<XDIM; col++){
			i = dep*XDIM*YDIM+row*XDIM+col;
            f0 = fA_h2[i+XDIM*YDIM*zInner*0 ];
            f1 = fA_h2[i+XDIM*YDIM*zInner*1 ];
            f2 = fA_h2[i+XDIM*YDIM*zInner*2 ];
            f3 = fA_h2[i+XDIM*YDIM*zInner*3 ];
            f4 = fA_h2[i+XDIM*YDIM*zInner*4 ];
            f5 = fA_h2[i+XDIM*YDIM*zInner*5 ];
            f6 = fA_h2[i+XDIM*YDIM*zInner*6 ];
            f7 = fA_h2[i+XDIM*YDIM*zInner*7 ];
            f8 = fA_h2[i+XDIM*YDIM*zInner*8 ];
            f9 = fA_h2[i+XDIM*YDIM*zInner*9 ];
            f10= fA_h2[i+XDIM*YDIM*zInner*10];
            f11= fA_h2[i+XDIM*YDIM*zInner*11];
            f12= fA_h2[i+XDIM*YDIM*zInner*12];
            f13= fA_h2[i+XDIM*YDIM*zInner*13];
            f14= fA_h2[i+XDIM*YDIM*zInner*14];
            f15= fA_h2[i+XDIM*YDIM*zInner*15];
            f16= fA_h2[i+XDIM*YDIM*zInner*16];
            f17= fA_h2[i+XDIM*YDIM*zInner*17];
            f18= fA_h2[i+XDIM*YDIM*zInner*18];

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

			output<<col<<", "<<row<<", "<<ZDIM/2+dep+1<<", "<<u<<","<<v<<","<<w<<","<<rho<<","
                  //<<uAv_h2[i]<<","<<vAv_h2[i]<<", "<<ufluc_h2[i]<<","<<vfluc_h2[i]<<endl;
                  <<f0<<","<<f1<<", "<<f9<<","<<f18<<endl;
            if(rho>0.f && rho<2.f){
            }
            else{
                check = 1;
            }
		}
	}
	}
    //top of GPU2
	for(row = 0; row<YDIM; row++){
		for(col = 0; col<XDIM; col++){
 			i = row*XDIM+col;
            f0 = hA_h2[i+XDIM*YDIM*0 ];
            f1 = hA_h2[i+XDIM*YDIM*1 ];
            f2 = hA_h2[i+XDIM*YDIM*2 ];
            f3 = hA_h2[i+XDIM*YDIM*3 ];
            f4 = hA_h2[i+XDIM*YDIM*4 ];
            f5 = hA_h2[i+XDIM*YDIM*5 ];
            f6 = hA_h2[i+XDIM*YDIM*6 ];
            f7 = hA_h2[i+XDIM*YDIM*7 ];
            f8 = hA_h2[i+XDIM*YDIM*8 ];
            f9 = hA_h2[i+XDIM*YDIM*9 ];
            f10= hA_h2[i+XDIM*YDIM*10];
            f11= hA_h2[i+XDIM*YDIM*11];
            f12= hA_h2[i+XDIM*YDIM*12];
            f13= hA_h2[i+XDIM*YDIM*13];
            f14= hA_h2[i+XDIM*YDIM*14];
            f15= hA_h2[i+XDIM*YDIM*15];
            f16= hA_h2[i+XDIM*YDIM*16];
            f17= hA_h2[i+XDIM*YDIM*17];
            f18= hA_h2[i+XDIM*YDIM*18];

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
			output<<col<<", "<<row<<", "<<ZDIM-1<<", "<<u<<","<<v<<","<<w<<","<<rho<<","
                  //<<uAv_h[i]<<","<<vAv_h[i]<<", "<<ufluc_h[i]<<","<<vfluc_h[i]<<endl;
                  <<f0<<","<<f1<<", "<<f9<<","<<f18<<endl;
        }
    }

    if(check == 1) cout<<"error!"<<endl;

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
	return(0);

}
