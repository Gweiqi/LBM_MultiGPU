#include <cuda.h>
//#include <cutil.h>
#include <iostream>
#include <ostream>
#include <fstream>
//#include "/home/yusuke/NVIDIA_GPU_Computing_SDK/C/common/inc/cutil.h"
using namespace std;
	
#define CASENAME "test_new"

#define BLOCKSIZEX 48
#define BLOCKSIZEY 1
#define BLOCKSIZEZ 1
#define BLOCKSIZELRX 48
#define BLOCKSIZELRY 1
#define BLOCKSIZELRZ 1
#define XDIM 48
#define YDIM 64
#define ZDIM 4
#define TMAX  10000
#define STARTF 0

#define OBSTR1 1.5f
#define OBSTX1 23.5f
#define OBSTY1 23.5f
#define OBSTZ1 32.5f

#define OBSTR2 32.f
#define OBSTX2 319.5f
#define OBSTY2 511.5f
#define OBSTZ2 31.5f

#define LRFACTOR 0.5f
#define LRLEVEL 2
#define LRX0 11.75f	//minimum x coord of LR
#define XLRDIM 48	//number of nodes in x
#define LRY0 11.75f
#define YLRDIM 64
#define LRZ0 -0.25f
#define ZLRDIM 8

#define RE 20.f//2000.f//100.f;
#define UMAX 0.08f
#define SmagLES "NO" //YES,NO
#define MODEL "MRT" //BGK,MRT,STREAM
#define REFINEMENT 0 //1,0
#define CS 0.1f

#define VELAV 1
#define START_VELAV   400000
#define START_VELFLUC 700000
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
    int value = 0;
//	if(((x-OBSTX1)*(x-OBSTX1)+(y-OBSTY1)*(y-OBSTY1))<OBSTR1*OBSTR1)
//		value = 10;
//	else if(((x-OBSTX2)*(x-OBSTX2)+(y-OBSTY2)*(y-OBSTY2))<OBSTR2*OBSTR2)
//		value = 10;
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
//    else
//	if(x < 3)//== 0)
//		value = 1;
//	else if(x > XDIM-4)//== XDIM-1)
//		value = 1;
//    if(z<3)
//        value = 1;
//    if(z>ZDIM-4)
//        value = 1;
//	if(abs(x-OBSTX1) < OBSTR1 && abs(y-OBSTY1) < OBSTR1)
//        value = 10;
//	if(y == 0)
//		value = 200;//22;
//	else if(y == YDIM-1)
//		value = 100;
    return value;
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
//	if(y == 0 || y == YDIM-1 || z == 0 || z == ZDIM-1)
//		value = 1;
//	else if(x == XDIM-2 || y == 1 || y == YDIM-2 || z == 1 || z == ZDIM-2)
//		return 1;
//	else if(x == 0)
//		return 1;
    
//	if(abs(x-OBSTX1) < OBSTR1 && abs(y-OBSTY1) < OBSTR1)
//        value = 10;
//    if(z == 1)
//		value = 1;
//    if(z == ZDIM-2)
//		value = 1;

	else if(y == 0)
		value = 200;//22;
	else if(y == YDIM-1)
		value = 100;
	if(x == 0)
		value = 26;
	else if(x == XDIM-1)
		value = 25;
//	else if(x < 3)//== 0)
//		value = 1;
//	else if(x > XDIM-4)//== XDIM-1)
//		value = 1;

	return value;
}

inline __device__ float PoisProf (float x){
	float radius = (YDIM-1-1)*0.5f;
	float result = -1.0f*(((1.0f-(x-0.5f)/radius))*((1.0f-(x-0.5f)/radius))-1.0f);
	return (result);
//	return 1.f;
}

inline __device__ float trilinear_interp (float v000, float v001, float v010, float v011,
                                          float v100, float v101, float v110, float v111, float x, float y, float z){
    return v000*(1.f-x)*(1.f-y)*(1.f-z)+
           v001*(    x)*(1.f-y)*(1.f-z)+
           v010*(1.f-x)*(    y)*(1.f-z)+
           v011*(    x)*(    y)*(1.f-z)+
           v100*(1.f-x)*(1.f-y)*(    z)+
           v101*(    x)*(1.f-y)*(    z)+
           v110*(1.f-x)*(    y)*(    z)+
           v111*(    x)*(    y)*(    z);
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
//	if(im == 53)//DirichletWest
//	{
//		//DirichletWest_Reg(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,y,z);
//		DirichletWest_Regularized(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,y,z);
//	}
//	else if(im == 54)//DirichletWest
//	{
//		//NeumannEast(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,y,z);
//		NeumannEast_Regularized(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,y,z);
//	}
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
	else if(im == 25)//xsymm top
	{
		xsymmetry_top(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,y,z);
	}
	else if(im == 26)//xsymm bot
	{
		xsymmetry_bot(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,y,z);
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

inline __device__ void North_Extrap(float& f0, float& f1, float& f2,
					float& f3 , float& f4 , float& f5 ,
					float& f6 , float& f7 , float& f8 , float& f9,
					float& f10, float& f11, float& f12,
					float& f13, float& f14, float& f15,
					float& f16, float& f17, float& f18, float rho)
{
	rho = 1.0f;
	float u = f1-f3+f5-f6-f7+f8+f10-f12+f15-f17;
	float v = f2-f4+f5+f6-f7-f8+f11-f13+f16-f18;
	float w = f9+f10+f11+f12+f13-f14-f15-f16-f17-f18;

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

inline __device__ void South_Extrap(float& f0, float& f1, float& f2,
					float& f3 , float& f4 , float& f5 ,
					float& f6 , float& f7 , float& f8 , float& f9,
					float& f10, float& f11, float& f12,
					float& f13, float& f14, float& f15,
					float& f16, float& f17, float& f18, float v)
{
	float rho,u,w;	
	rho = f0+f1+f2+f3+f4+f5+f6+f7+f8+f9+f10+f11+f12+f13+f14+f15+f16+f17+f18;
	u = 0.f;//f1-f3+f5-f6-f7+f8+f10-f12+f15-f17;
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

inline __device__ void StrainRate(float& u_x, float& v_y, float& w_z, float& Sxy, float& Syz, float& Sxz, 
                                  float omega, float* m)
{
    float m1 = m[1]+11.f*m[0]-19.f*(m[3]*m[3]+m[5]*m[5]+m[7]*m[7]);
    float m9 = (m[9]-(2.f*m[3]*m[3]-(m[5]*m[5]+m[7]*m[7])));
    float m11 = m[11]-(m[5]*m[5]-m[7]*m[7]);
    float m13 = m[13]-m[3]*m[5];
    float m14 = m[14]-m[5]*m[7];
    float m15 = m[15]-m[3]*m[7];
    
    u_x = -1.f/38.f*(    m1+19.f*omega*m9);
    v_y = -1.f/76.f*(2.f*m1-19.f*omega*(m9-3.f*m11));
    w_z = -1.f/76.f*(2.f*m1-19.f*omega*(m9+3.f*m11));
    Sxy = -1.5f*omega*m13;
    Syz = -1.5f*omega*m14;
    Sxz = -1.5f*omega*m15;
}

inline __device__ void Moments(float* f, float* m)
{
    m[0 ] = f[0]+f[1]+f[2]+f[3]+f[4]+f[5]+f[6]+f[7]+f[8]+f[9]+f[10]+f[11]+f[12]+f[13]+f[14]+f[15]+f[16]+f[17]+f[18];
	m[1 ] = -30.f*f[0]+-11.f*f[1]+-11.f*f[2]+-11.f*f[3]+-11.f*f[4]+  8.f*f[5]+  8.f*f[6]+  8.f*f[7]+  8.f*f[8]+-11.f*f[9]+  8.f*f[10]+  8.f*f[11]+  8.f*f[12]+  8.f*f[13]+-11.f*f[14]+  8.f*f[15]+  8.f*f[16]+  8.f*f[17]+  8.f*f[18];
	m[2 ] =  12.f*f[0]+ -4.f*f[1]+ -4.f*f[2]+ -4.f*f[3]+ -4.f*f[4]+    f[5]+    f[6]+    f[7]+    f[8]+ -4.f*f[9]+    f[10]+      f[11]+    f[12]+    f[13]+ -4.f*f[14]+    f[15]+    f[16]+    f[17]+    f[18];
   	m[3 ] = f[1]-f[3]+f[5]-f[6]-f[7]+f[8]+f[10]-f[12]+f[15]-f[17];
	m[4 ] =           -4.f*f[1]         +  4.f*f[3]         +    f[5]+ -  f[6]+ -  f[7]+    f[8]         +    f[10]          + -  f[12]                    +    f[15]          + -  f[17]          ;
    m[5 ] = f[2]-f[4 ]+f[5 ]+f[6 ]-f[7 ]-f[8 ]+f[11]-f[13]+f[16]-f[18];
	m[6 ] =                    -4.f*f[2]         +  4.f*f[4]+    f[5]+    f[6]+ -  f[7]+ -  f[8]                   +    f[11]          + -  f[13]                    +    f[16]          + -  f[18];
    m[7 ] = f[9]+f[10]+f[11]+f[12]+f[13]-f[14]-f[15]-f[16]-f[17]-f[18];
	m[8 ] =                                                                                 + -4.f*f[9]+    f[10]+    f[11]+    f[12]+    f[13]+  4.f*f[14]+ -  f[15]+ -  f[16]+ -  f[17]+ -  f[18];
	m[9 ] =            2.f*f[1]+ -  f[2]+  2.f*f[3]+ -  f[4]+    f[5]+    f[6]+    f[7]+    f[8]+ -  f[9]+    f[10]+ -2.f*f[11]+    f[12]+ -2.f*f[13]+ -  f[14]+    f[15]+ -2.f*f[16]+    f[17]+ -2.f*f[18];
	m[10] =           -4.f*f[1]+  2.f*f[2]+ -4.f*f[3]+  2.f*f[4]+    f[5]+    f[6]+    f[7]+    f[8]+  2.f*f[9]+    f[10]+ -2.f*f[11]+    f[12]+ -2.f*f[13]+  2.f*f[14]+    f[15]+ -2.f*f[16]+    f[17]+ -2.f*f[18];
	m[11] =                       f[2]         +    f[4]+    f[5]+    f[6]+    f[7]+    f[8]+ -  f[9]+ -  f[10]          + -  f[12]          + -  f[14]+ -  f[15]          + -  f[17]          ;
	m[12] =                    -2.f*f[2]           -2.f*f[4]+    f[5]+    f[6]+    f[7]+    f[8]+  2.f*f[9]+ -  f[10]          + -  f[12]          +  2.f*f[14]+ -  f[15]          + -  f[17]          ;
	m[13] =                                                  f[5]+ -  f[6]+    f[7]+ -  f[8]                                                                                                   ;
	m[14] =                                                                                                         f[11]          + -  f[13]                    + -  f[16]          +    f[18];
	m[15] =                                                                                               f[10]          + -  f[12]                    + -  f[15]          +    f[17]          ;  
	m[16] =                                                  f[5]+ -  f[6]+ -  f[7]+    f[8]           -  f[10]          +    f[12]                    + -  f[15]          +    f[17]          ;  
	m[17] =                                               -  f[5]+ -  f[6]+    f[7]+    f[8]                   +    f[11]          + -  f[13]                    +    f[16]          + -  f[18];  
	m[18] =                                                                                               f[10]+ -  f[11]+    f[12]+ -  f[13]          + -  f[15]+    f[16]+ -  f[17]+    f[18];
}

inline __device__ void InvertMoments(float* f, float* m)
{
float u = m[3];
float v = m[5];
float w = m[7];
f[0 ]=(0.052631579f*m[0]                           +- 0.012531328f*(m[1])+ 0.047619048f*(m[2]));
f[1 ]=(0.052631579f*m[0]+  0.1f*u                  +-0.0045948204f*(m[1])+-0.015873016f*(m[2])+  -0.1f*(m[4])                 + 0.055555556f*((m[9])-m[10]));
f[2 ]=(0.052631579f*m[0]         +  0.1f*v         +-0.0045948204f*(m[1])+-0.015873016f*(m[2])             +   -0.1f*(m[6])   +-0.027777778f*((m[9])-m[10])+ 0.083333333f*((m[11])-m[12]));
f[3 ]=(0.052631579f*m[0]+ -0.1f*u                  +-0.0045948204f*(m[1])+-0.015873016f*(m[2])+   0.1f*(m[4])                 + 0.055555556f*((m[9])-m[10]));                                                      
f[4 ]=(0.052631579f*m[0]         + -0.1f*v         +-0.0045948204f*(m[1])+-0.015873016f*(m[2])             +    0.1f*(m[6])   +-0.027777778f*((m[9])-m[10])+ 0.083333333f*((m[11])-m[12]));
f[5 ]=(0.052631579f*m[0]+  0.1f*u+  0.1f*v         + 0.0033416876f*(m[1])+ 0.003968254f*(m[2])+ 0.025f*(m[4]+m[6])              +0.013888889f*(m[10])+0.041666667f*(m[12])+0.125f*( m[16]-m[17])+ (0.027777778f*(m[9]) +0.083333333f*(m[11])+( 0.25f*(m[13]))));
f[6 ]=(0.052631579f*m[0]+ -0.1f*u+  0.1f*v         + 0.0033416876f*(m[1])+ 0.003968254f*(m[2])+-0.025f*(m[4]-m[6])              +0.013888889f*(m[10])+0.041666667f*(m[12])+0.125f*(-m[16]-m[17])+ (0.027777778f*(m[9]) +0.083333333f*(m[11])+(-0.25f*(m[13]))));
f[7 ]=(0.052631579f*m[0]+ -0.1f*u+ -0.1f*v         + 0.0033416876f*(m[1])+ 0.003968254f*(m[2])+-0.025f*(m[4]+m[6])              +0.013888889f*(m[10])+0.041666667f*(m[12])+0.125f*(-m[16]+m[17])+ (0.027777778f*(m[9]) +0.083333333f*(m[11])+( 0.25f*(m[13]))));
f[8 ]=(0.052631579f*m[0]+  0.1f*u+ -0.1f*v         + 0.0033416876f*(m[1])+ 0.003968254f*(m[2])+ 0.025f*(m[4]-m[6])              +0.013888889f*(m[10])+0.041666667f*(m[12])+0.125f*( m[16]+m[17])+ (0.027777778f*(m[9]) +0.083333333f*(m[11])+(-0.25f*(m[13]))));
f[9 ]=(0.052631579f*m[0]                  +  0.1f*w+-0.0045948204f*(m[1])+-0.015873016f*(m[2])                +   -0.1f*(m[8])+-0.027777778f*((m[9])-m[10])+-0.083333333f*((m[11])-m[12]));                                       
f[10]=(0.052631579f*m[0]+  0.1f*u         +  0.1f*w+ 0.0033416876f*(m[1])+ 0.003968254f*(m[2])+ 0.025f*(m[4]+m[8])              +0.013888889f*(m[10])-0.041666667f*(m[12])+0.125f*(-m[16]+m[18])+ (0.027777778f*(m[9]) -0.083333333f*(m[11])+( 0.25f*(m[15]))));
f[11]=(0.052631579f*m[0]         +  0.1f*v+  0.1f*w+ 0.0033416876f*(m[1])+ 0.003968254f*(m[2])             +  0.025f*(m[6]+m[8])+0.125f*( m[17]-m[18])-0.027777778f*(m[10])+(-0.055555556f*(m[9]) +( 0.25f*(m[14]))));
f[12]=(0.052631579f*m[0]+ -0.1f*u         +  0.1f*w+ 0.0033416876f*(m[1])+ 0.003968254f*(m[2])+-0.025f*(m[4]-m[8])              +0.013888889f*(m[10])-0.041666667f*(m[12])+0.125f*( m[16]+m[18])+ (0.027777778f*(m[9]) -0.083333333f*(m[11])+(-0.25f*(m[15]))));
f[13]=(0.052631579f*m[0]         + -0.1f*v+  0.1f*w+ 0.0033416876f*(m[1])+ 0.003968254f*(m[2])             + -0.025f*(m[6]-m[8])+0.125f*(-m[17]-m[18])-0.027777778f*(m[10])+(-0.055555556f*(m[9]) +(-0.25f*(m[14]))));
f[14]=(0.052631579f*m[0]                  + -0.1f*w+-0.0045948204f*(m[1])+-0.015873016f*(m[2])                +    0.1f*(m[8])+-0.027777778f*((m[9])-m[10])+-0.083333333f*((m[11])-m[12]));                                      
f[15]=(0.052631579f*m[0]+  0.1f*u         + -0.1f*w+ 0.0033416876f*(m[1])+ 0.003968254f*(m[2])+ 0.025f*(m[4]-m[8])              +0.013888889f*(m[10])-0.041666667f*(m[12])+0.125f*(-m[16]-m[18])+ (0.027777778f*(m[9]) -0.083333333f*(m[11])+(-0.25f*(m[15]))));
f[16]=(0.052631579f*m[0]         +  0.1f*v+ -0.1f*w+ 0.0033416876f*(m[1])+ 0.003968254f*(m[2])             +  0.025f*(m[6]-m[8])+0.125f*( m[17]+m[18])-0.027777778f*(m[10])+(-0.055555556f*(m[9]) +(-0.25f*(m[14]))));
f[17]=(0.052631579f*m[0]+ -0.1f*u         + -0.1f*w+ 0.0033416876f*(m[1])+ 0.003968254f*(m[2])+-0.025f*(m[4]+m[8])              +0.013888889f*(m[10])-0.041666667f*(m[12])+0.125f*( m[16]-m[18])+ (0.027777778f*(m[9]) -0.083333333f*(m[11])+( 0.25f*(m[15]))));
f[18]=(0.052631579f*m[0]         + -0.1f*v+ -0.1f*w+ 0.0033416876f*(m[1])+ 0.003968254f*(m[2])             + -0.025f*(m[6]+m[8])+0.125f*(-m[17]+m[18])-0.027777778f*(m[10])+(-0.055555556f*(m[9]) +( 0.25f*(m[14]))));


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


inline __device__ int f_mem(int f_num, int x, int y, int z, size_t pitch, int zInner)
{
	int index = (x+y*pitch+z*YDIM*pitch)+f_num*pitch*YDIM*(zInner);
	index = dmax(index);
	index = dmin(index,19*pitch*YDIM*(zInner));
//	if(index<0) index = 0;
//	else if(index>19*pitch*YDIM*ZDIM/GPU_N-2) index = 19*pitch*(YDIM*ZDIM/GPU_N-2);
	return index;
}

inline __device__ int f_memLR(int f_num, int x, int y, int z, size_t pitch, int zInner)
{
	int index = (x+y*pitch+z*YLRDIM*pitch)+f_num*pitch*YLRDIM*(zInner);
	index = dmax(index);
	index = dmin(index,19*pitch*YLRDIM*(zInner));
	return index;
}

inline __device__ int buff_mem(int f_num, int x, int y, size_t pitch)
{
	int index = (x+y*pitch)+f_num*pitch*YDIM;
	index = dmax(index);
	index = dmin(index,19*pitch*YDIM);
//	if(index<0) index = 0;
//	else if(index>19*pitch*YDIM) index = 19*pitch*YDIM;
	return index;
}

inline __device__ int buff_memLR(int f_num, int x, int y, size_t pitch)
{
	int index = (x+y*pitch)+f_num*pitch*YLRDIM;
	index = dmax(index);
	index = dmin(index,19*pitch*YLRDIM);
	return index;
}

inline __device__ void bgk_feq(float rho, float u, float v, float w, float& f0, float& f1, float& f2,
					float& f3 , float& f4 , float& f5 ,
					float& f6 , float& f7 , float& f8 , float& f9,
					float& f10, float& f11, float& f12,
					float& f13, float& f14, float& f15,
					float& f16, float& f17, float& f18)
{
	float usqr = u*u+v*v+w*w;
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
	f11= 1.0f/36.0f*(rho+3.0f*(v+w)+4.5f*(v+w)*(v+w)-1.5f*usqr);
	f12= 1.0f/36.0f*(rho+3.0f*(-u+w)+4.5f*(-u+w)*(-u+w)-1.5f*usqr);
	f13= 1.0f/36.0f*(rho+3.0f*(-v+w)+4.5f*(-v+w)*(-v+w)-1.5f*usqr);
	f14= 1.0f/18.0f*(rho-3.0f*w+4.5f*w*w-1.5f*usqr);
	f15= 1.0f/36.0f*(rho+3.0f*(u-w)+4.5f*(u-w)*(u-w)-1.5f*usqr);
	f16= 1.0f/36.0f*(rho+3.0f*(v-w)+4.5f*(v-w)*(v-w)-1.5f*usqr);
	f17= 1.0f/36.0f*(rho+3.0f*(-u-w)+4.5f*(-u-w)*(-u-w)-1.5f*usqr);
	f18= 1.0f/36.0f*(rho+3.0f*(-v-w)+4.5f*(-v-w)*(-v-w)-1.5f*usqr);   

}

inline __device__ void mrt_feq(float rho, float u, float v, float w, float& f0, float& f1, float& f2,
					float& f3 , float& f4 , float& f5 ,
					float& f6 , float& f7 , float& f8 , float& f9,
					float& f10, float& f11, float& f12,
					float& f13, float& f14, float& f15,
					float& f16, float& f17, float& f18)
{
    float usqr = u*u+v*v+w*w;
    f0 = 0.1904761791f*rho+-0.597127747f*usqr                      ;
    f1 = 0.1031746045f*rho+ 0.032375918f*usqr+  0.1666666667f*u    ;
    f2 = 0.1031746045f*rho+ 0.032375918f*usqr+  0.1666666667f*v    ;
    f3 = 0.1031746045f*rho+ 0.032375918f*usqr+ -0.1666666667f*u    ;
    f4 = 0.1031746045f*rho+ 0.032375918f*usqr+ -0.1666666667f*v    ;
    f5 = 0.0158730149f*rho+ 0.033572690f*usqr+  0.083333333f*( u+v);
    f6 = 0.0158730149f*rho+ 0.033572690f*usqr+ -0.083333333f*( u-v);
    f7 = 0.0158730149f*rho+ 0.033572690f*usqr+ -0.083333333f*( u+v);
    f8 = 0.0158730149f*rho+ 0.033572690f*usqr+  0.083333333f*( u-v);
    f9 = 0.1031746045f*rho+ 0.032375918f*usqr+  0.1666666667f*w    ;
    f10= 0.0158730149f*rho+ 0.033572690f*usqr+  0.083333333f*( u+w);
    f11= 0.0158730149f*rho+ 0.033572690f*usqr+  0.083333333f*( v+w);
    f12= 0.0158730149f*rho+ 0.033572690f*usqr+ -0.083333333f*( u-w);
    f13= 0.0158730149f*rho+ 0.033572690f*usqr+ -0.083333333f*( v-w);
    f14= 0.1031746045f*rho+ 0.032375918f*usqr+ -0.1666666667f*w    ;
    f15= 0.0158730149f*rho+ 0.033572690f*usqr+  0.083333333f*( u-w);
    f16= 0.0158730149f*rho+ 0.033572690f*usqr+  0.083333333f*( v-w);
    f17= 0.0158730149f*rho+ 0.033572690f*usqr+ -0.083333333f*( u+w);
    f18= 0.0158730149f*rho+ 0.033572690f*usqr+ -0.083333333f*( v+w);
    
    f1 +=  0.055555556f*(2.f*u*u-(v*v+w*w));
    f2 += -0.027777778f*(2.f*u*u-(v*v+w*w))+  0.083333333f*(v*v-w*w);
    f3 +=  0.055555556f*(2.f*u*u-(v*v+w*w));
    f4 += -0.027777778f*(2.f*u*u-(v*v+w*w))+  0.083333333f*(v*v-w*w);
    f5 +=  0.027777778f*(2.f*u*u-(v*v+w*w))+  0.083333333f*(v*v-w*w)+  0.25f*u*v                              ;
    f6 +=  0.027777778f*(2.f*u*u-(v*v+w*w))+  0.083333333f*(v*v-w*w)+ -0.25f*u*v                              ;
    f7 +=  0.027777778f*(2.f*u*u-(v*v+w*w))+  0.083333333f*(v*v-w*w)+  0.25f*u*v                              ;
    f8 +=  0.027777778f*(2.f*u*u-(v*v+w*w))+  0.083333333f*(v*v-w*w)+ -0.25f*u*v                              ;
    f9 += -0.027777778f*(2.f*u*u-(v*v+w*w))+ -0.083333333f*(v*v-w*w)                                          ;
    f10+=  0.027777778f*(2.f*u*u-(v*v+w*w))+ -0.083333333f*(v*v-w*w)                              +  0.25f*u*w;
    f11+= -0.055555556f*(2.f*u*u-(v*v+w*w))                                      +  0.25f*v*w                 ;
    f12+=  0.027777778f*(2.f*u*u-(v*v+w*w))+ -0.083333333f*(v*v-w*w)                              + -0.25f*u*w;
    f13+= -0.055555556f*(2.f*u*u-(v*v+w*w))                                        -0.25f*v*w                 ;
    f14+= -0.027777778f*(2.f*u*u-(v*v+w*w))+ -0.083333333f*(v*v-w*w)                                          ;
    f15+=  0.027777778f*(2.f*u*u-(v*v+w*w))+ -0.083333333f*(v*v-w*w)                              + -0.25f*u*w;
    f16+= -0.055555556f*(2.f*u*u-(v*v+w*w))                                      + -0.25f*v*w                 ;
    f17+=  0.027777778f*(2.f*u*u-(v*v+w*w))+ -0.083333333f*(v*v-w*w)                              +  0.25f*u*w;
    f18+= -0.055555556f*(2.f*u*u-(v*v+w*w))                                      +  0.25f*v*w                 ;

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
//	//m1  = -19.f*f0+ 19.f*f5+19.f*f6+19.f*f7+19.f*f8+19.f*f10+19.f*f11+19.f*f12+19.f*f13+19.f*f15+19.f*f16+19.f*f17+19.f*f18   -19.f*(u*u+v*v+w*w);//+8.f*(f5+f6+f7+f8+f10+f11+f12+f13+f15+f16+f17+f18);
//	//m4  = -3.33333333f*f1+3.33333333f*f3+1.66666667f*f5-1.66666667f*f6-1.66666667f*f7+1.66666667f*f8+1.66666667f*f10-1.66666667f*f12+1.66666667f*f15-1.66666667f*f17;
//	//m6  = -3.33333333f*f2+3.33333333f*f4+1.66666667f*f5+1.66666667f*f6-1.66666667f*f7-1.66666667f*f8+1.66666667f*f11-1.66666667f*f13+1.66666667f*f16-1.66666667f*f18;
//	//m8  = -3.33333333f*f9+1.66666667f*f10+1.66666667f*f11+1.66666667f*f12+1.66666667f*f13+3.33333333f*f14-1.66666667f*f15-1.66666667f*f16-1.66666667f*f17-1.66666667f*f18;
//	m1  = 19.f*(-f0+ f5+f6+f7+f8+f10+f11+f12+f13+f15+f16+f17+f18   -(u*u+v*v+w*w));//+8.f*(f5+f6+f7+f8+f10+f11+f12+f13+f15+f16+f17+f18);
//	m2  =  12.f*f0+ -4.f*f1+ -4.f*f2+ -4.f*f3+ -4.f*f4+      f5+      f6+      f7+      f8+ -4.f*f9+    f10+        f11+      f12+      f13+ -4.f*f14+      f15+      f16+      f17+      f18 +7.53968254f*(u*u+v*v+w*w);
////	m4  = 1.666666667f*(-2.f*f1+2.f*f3+f5-f6-f7+f8+f10-f12+f15-f17);
////	m6  = 1.666666667f*(-2.f*f2+2.f*f4+f5+f6-f7-f8+f11-f13+f16-f18);
////	m8  = 1.666666667f*(-2.f*f9+f10+f11+f12+f13+2.f*f14-f15-f16-f17-f18);
//	m4  = 1.666666667f*(-3.f*f1+3.f*f3+u);
//	m6  = 1.666666667f*(-3.f*f2+3.f*f4+v);
//	m8  = 1.666666667f*(-3.f*f9+3.f*f14+w);
//	m9  = 2.f*f1+  -  f2+  2.f*f3+  -  f4+ f5+ f6+ f7+ f8+-    f9+ f10+ -2.f*f11+ f12+-2.f*f13+-    f14+ f15+ -2.f*f16+ f17+-2.f*f18  -(2.f*u*u-(v*v+w*w));
//	m10 =-4.f*f1+ 2.f*f2+ -4.f*f3+ 2.f*f4+ f5+ f6+ f7+ f8+ 2.f*f9+ f10+ -2.f*f11+ f12+-2.f*f13+ 2.f*f14+ f15+ -2.f*f16+ f17+-2.f*f18;
//	m11 =             f2         +     f4+ f5+ f6+ f7+ f8+-    f9+-f10          +-f12         +-    f14+-f15          +-f17         -(v*v-w*w);
//	m12 =        -2.f*f2          -2.f*f4+ f5+ f6+ f7+ f8+ 2.f*f9+-f10          +-f12         + 2.f*f14+-f15          +-f17         ;
//	m13 =                                  f5+-f6+ f7+-f8                                                                             -u*v;
//	m14 =                                                                    f11     +-    f13              + -    f16     +     f18  -v*w;
//	m15 =                                                          f10        + - f12                  +-f15          + f17           -u*w;  
//	m16 =                                  f5+-f6+-f7+ f8         -f10        +   f12                  +-f15          + f17         ;  
//	m17 =                                 -f5+-f6+ f7+ f8              +     f11     +-    f13              +      f16     +-    f18;  
//	m18 =                                                          f10+-     f11+ f12+-    f13         +-f15+      f16+-f17+     f18;

	m1  = 19.f*(-f0+ f5+f6+f7+f8+f10+f11+f12+f13+f15+f16+f17+f18   -(u*u+v*v+w*w));//+8.f*(f5+f6+f7+f8+f10+f11+f12+f13+f15+f16+f17+f18);
	m2  = 7.53968254f*(u*u+v*v+w*w);
	m4  = -0.666666667f*u;//1.666666667f*(-3.f*f1+3.f*f3+u);
	m6  = -0.666666667f*v;
	m8  = -0.666666667f*w;
	m9  = 2.f*f1+  -  f2+  2.f*f3+  -  f4+ f5+ f6+ f7+ f8+-    f9+ f10+ -2.f*f11+ f12+-2.f*f13+-    f14+ f15+ -2.f*f16+ f17+-2.f*f18  -(2.f*u*u-(v*v+w*w));
	m10 = 0.f;
	m11 =             f2         +     f4+ f5+ f6+ f7+ f8+-    f9+-f10          +-f12         +-    f14+-f15          +-f17         -(v*v-w*w);
	m12 = 0.f;//       -2.f*f2          -2.f*f4+ f5+ f6+ f7+ f8+ 2.f*f9+-f10          +-f12         + 2.f*f14+-f15          +-f17         ;
	m13 = 0.f;//                                 f5+-f6+ f7+-f8                                                                             -u*v;
	m14 = 0.f;//                                                                   f11     +-    f13              + -    f16     +     f18  -v*w;
	m15 = 0.f;//                                                         f10        + - f12                  +-f15          + f17           -u*w;  
	m16 = 0.f;//                                 f5+-f6+-f7+ f8         -f10        +   f12                  +-f15          + f17         ;  
	m17 = 0.f;//                                -f5+-f6+ f7+ f8              +     f11     +-    f13              +      f16     +-    f18;  
	m18 = 0.f;//                                                         f10+-     f11+ f12+-    f13         +-f15+      f16+-f17+     f18;


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
//float omega2 = 2.0f/(1.0f+2.0f*(2.0f/omega-1.0f));

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

//SF = (omega*(1.0f-omega2))/((1.0f-omega)*omega2);//for post-collision 
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

__global__ void f_Extract(float* fout, float* fin, float* gin, float* hin,
							size_t pitch_c, size_t pitch_f, int zInner_c, int zInner_f, float omega_f, float SF, int GPU)//pitch in elements
{
	int x = threadIdx.x+blockIdx.x*blockDim.x;//local index on f of coarse mesh
	int y = threadIdx.y+blockIdx.y*blockDim.y;
	int z = threadIdx.z+blockIdx.z*blockDim.z;
    float xcoord = x;//xcoord in gpu
    float ycoord = y;//ycoord in gpu
    float zcoord = z+1;//zcoord in gpu
    float f[19];
	if( (x > LRX0+1 && x < LRX0+XLRDIM*LRFACTOR-1 && y > LRY0+1 && y < LRY0+YLRDIM*LRFACTOR-1) && 
	(x == int(LRX0+2) || x == int(LRX0+XLRDIM*LRFACTOR-1) || y == int(LRY0+2) || y == int(LRY0+YLRDIM*LRFACTOR-1)) )
	{
	float xcoord_LR = LRLEVEL*(xcoord-LRX0);//coord in refined region coordinates
	float ycoord_LR = LRLEVEL*(ycoord-LRY0);
	float zcoord_LR = LRLEVEL*(zcoord-LRZ0)-1.f;//-1.f to account for g layer
    
    int xm = int(xcoord_LR);
    int ym = int(ycoord_LR);
    int zm = int(zcoord_LR);
    int xp = xm+1;
    int yp = ym+1;
    int zp = zm+1;
    float xf = xcoord_LR-xm;
    float yf = ycoord_LR-ym;
    float zf = zcoord_LR-zm;
//    for(int i=0;i<19;i++){
//        float v000 = fin[f_memLR(i ,xm,ym,zm,pitch_f,zInner_f)];
//        float v001 = fin[f_memLR(i ,xp,ym,zm,pitch_f,zInner_f)];
//        float v010 = fin[f_memLR(i ,xm,yp,zm,pitch_f,zInner_f)];
//        float v011 = fin[f_memLR(i ,xp,yp,zm,pitch_f,zInner_f)];
//        float v100 = fin[f_memLR(i ,xm,ym,zp,pitch_f,zInner_f)];
//        float v101 = fin[f_memLR(i ,xp,ym,zp,pitch_f,zInner_f)];
//        float v110 = fin[f_memLR(i ,xm,yp,zp,pitch_f,zInner_f)];
//        float v111 = fin[f_memLR(i ,xp,yp,zp,pitch_f,zInner_f)];
//        f[i] = trilinear_interp(v000, v001, v010, v011, v100, v101, v110, v111, xf, yf, zf);
//    }

    float u_x1,u_x2,u_x3,u_x4,u_x5,u_x6,u_x7,u_x8;
    float v_y1,v_y2,v_y3,v_y4,v_y5,v_y6,v_y7,v_y8;
    float w_z1,w_z2,w_z3,w_z4,w_z5,w_z6,w_z7,w_z8;
    float Sxy1,Sxy2,Sxy3,Sxy4,Sxy5,Sxy6,Sxy7,Sxy8;
    float Syz1,Syz2,Syz3,Syz4,Syz5,Syz6,Syz7,Syz8;
    float Sxz1,Sxz2,Sxz3,Sxz4,Sxz5,Sxz6,Sxz7,Sxz8;
    float m[8][19];
    for(int i=0;i<19;i++)
        f[i] = fin[f_memLR(i ,xm,ym,zm,pitch_f,zInner_f)];
    Moments(f,m[0]);
    StrainRate(u_x1,v_y1,w_z1,Sxy1,Syz1,Sxz1,omega_f,m[0]);
    for(int i=0;i<19;i++)
        f[i] = fin[f_memLR(i ,xp,ym,zm,pitch_f,zInner_f)];
    Moments(f,m[1]);
    StrainRate(u_x2,v_y2,w_z2,Sxy2,Syz2,Sxz2,omega_f,m[1]);
    for(int i=0;i<19;i++)
        f[i] = fin[f_memLR(i ,xm,yp,zm,pitch_f,zInner_f)];
    Moments(f,m[2]);
    StrainRate(u_x3,v_y3,w_z3,Sxy3,Syz3,Sxz3,omega_f,m[2]);
    for(int i=0;i<19;i++)
        f[i] = fin[f_memLR(i ,xp,yp,zm,pitch_f,zInner_f)];
    Moments(f,m[3]);
    StrainRate(u_x4,v_y4,w_z4,Sxy4,Syz4,Sxz4,omega_f,m[3]);
    for(int i=0;i<19;i++)
        f[i] = fin[f_memLR(i ,xm,ym,zp,pitch_f,zInner_f)];
    Moments(f,m[4]);
    StrainRate(u_x5,v_y5,w_z5,Sxy5,Syz5,Sxz5,omega_f,m[4]);
    for(int i=0;i<19;i++)
        f[i] = fin[f_memLR(i ,xp,ym,zp,pitch_f,zInner_f)];
    Moments(f,m[5]);
    StrainRate(u_x6,v_y6,w_z6,Sxy6,Syz6,Sxz6,omega_f,m[5]);
    for(int i=0;i<19;i++)
        f[i] = fin[f_memLR(i ,xm,yp,zp,pitch_f,zInner_f)];
    Moments(f,m[6]);
    StrainRate(u_x7,v_y7,w_z7,Sxy7,Syz7,Sxz7,omega_f,m[6]);
    for(int i=0;i<19;i++)
        f[i] = fin[f_memLR(i ,xp,yp,zp,pitch_f,zInner_f)];
    Moments(f,m[7]);
    StrainRate(u_x8,v_y8,w_z8,Sxy8,Syz8,Sxz8,omega_f,m[7]);

    float cx = -((u_x8-u_x7+u_x6-u_x5+u_x4-u_x3+u_x2-u_x1))*0.03125f;
    float cy = -((Sxy8+Sxy7-Sxy6-Sxy5+Sxy4+Sxy3-Sxy2-Sxy1)-m[7][5]+m[6][5]+m[5][5]-m[4][5]-m[3][5]+m[2][5]+m[1][5]-m[0][5])*0.0625f;
    float cz = -((Sxz8+Sxz7+Sxz6+Sxz5-Sxz4-Sxz3-Sxz2-Sxz1)-m[7][7]+m[6][7]-m[5][7]+m[4][7]+m[3][7]-m[2][7]+m[1][7]-m[0][7])*0.0625f;
    float dx = -((Sxy8-Sxy7+Sxy6-Sxy5+Sxy4-Sxy3+Sxy2-Sxy1)-m[7][3]+m[6][3]+m[5][3]-m[4][3]-m[3][3]+m[2][3]+m[1][3]-m[0][3])*0.0625f;
    float dy = -((v_y8+v_y7-v_y6-v_y5+v_y4+v_y3-v_y2-v_y1))*0.03125f;
    float dz = -((Syz8+Syz7+Syz6+Syz5-Syz4-Syz3-Syz2-Syz1)-m[7][7]-m[6][7]+m[5][7]+m[4][7]+m[3][7]+m[2][7]-m[1][7]-m[0][7])*0.0625f;
    float ex = -((Sxz8-Sxz7+Sxz6-Sxz5+Sxz4-Sxz3+Sxz2-Sxz1)-m[7][3]+m[6][3]-m[5][3]+m[4][3]+m[3][3]-m[2][3]+m[1][3]-m[0][3])*0.0625f;
    float ey = -((Syz8+Syz7-Syz6-Syz5+Syz4+Syz3-Syz2-Syz1)-m[7][5]-m[6][5]+m[5][5]+m[4][5]+m[3][5]+m[2][5]-m[1][5]-m[0][5])*0.0625f;
    float ez = -((w_z8+w_z7+w_z6+w_z5-w_z4-w_z3-w_z2-w_z1))*0.03125f;

    for(int i = 0; i<19; i++)
        m[0][i] = trilinear_interp(m[0][i],m[1][i],m[2][i],m[3][i],m[4][i],m[5][i],m[6][i],m[7][i], xf, yf, zf);
    float xpr = 4.f*xf*xf-4.f*xf+1.f;
    float ypr = 4.f*yf*yf-4.f*yf+1.f;
    float zpr = 4.f*zf*zf-4.f*zf+1.f;
    m[0][3] += cx*(1.f-xpr)+cy*(1.f-ypr)+cz*(1.f-zpr);
    m[0][5] += dx*(1.f-xpr)+dy*(1.f-ypr)+dz*(1.f-zpr);
    m[0][7] += ex*(1.f-xpr)+ey*(1.f-ypr)+ez*(1.f-zpr);
    InvertMoments(f,m[0]);







	if(MODEL == "MRT")
	mrt_scale_cf(f[0],f[1],f[2],f[3],f[4],f[5],f[6],f[7],f[8],f[9],f[10],f[11],f[12],f[13],f[14],f[15],f[16],f[17],f[18],SF);
    else if(MODEL == "BGK")
	bgk_scale_cf(f[0],f[1],f[2],f[3],f[4],f[5],f[6],f[7],f[8],f[9],f[10],f[11],f[12],f[13],f[14],f[15],f[16],f[17],f[18],SF);

	fout[f_mem(0 ,x,y,z,pitch_c,zInner_c)] = f[0 ];
	fout[f_mem(1 ,x,y,z,pitch_c,zInner_c)] = f[1 ];
	fout[f_mem(2 ,x,y,z,pitch_c,zInner_c)] = f[2 ];
	fout[f_mem(3 ,x,y,z,pitch_c,zInner_c)] = f[3 ];
	fout[f_mem(4 ,x,y,z,pitch_c,zInner_c)] = f[4 ];
	fout[f_mem(5 ,x,y,z,pitch_c,zInner_c)] = f[5 ];
	fout[f_mem(6 ,x,y,z,pitch_c,zInner_c)] = f[6 ];
	fout[f_mem(7 ,x,y,z,pitch_c,zInner_c)] = f[7 ];
	fout[f_mem(8 ,x,y,z,pitch_c,zInner_c)] = f[8 ];
	fout[f_mem(9 ,x,y,z,pitch_c,zInner_c)] = f[9 ];
	fout[f_mem(10,x,y,z,pitch_c,zInner_c)] = f[10];
	fout[f_mem(11,x,y,z,pitch_c,zInner_c)] = f[11];
	fout[f_mem(12,x,y,z,pitch_c,zInner_c)] = f[12];
	fout[f_mem(13,x,y,z,pitch_c,zInner_c)] = f[13];
	fout[f_mem(14,x,y,z,pitch_c,zInner_c)] = f[14];
	fout[f_mem(15,x,y,z,pitch_c,zInner_c)] = f[15];
	fout[f_mem(16,x,y,z,pitch_c,zInner_c)] = f[16];
	fout[f_mem(17,x,y,z,pitch_c,zInner_c)] = f[17];
	fout[f_mem(18,x,y,z,pitch_c,zInner_c)] = f[18];

	}
}

__global__ void g_Extract(float* gout, float* fin, float* gin,
							size_t pitch_c, size_t pitch_f, int zInner_c, int zInner_f, float omega_f, float SF, int GPU)//pitch in elements
{
	int x = threadIdx.x+blockIdx.x*blockDim.x;//local index on f of coarse mesh
	int y = threadIdx.y+blockIdx.y*blockDim.y;
    float xcoord = x;//xcoord in gpu
    float ycoord = y;//ycoord in gpu
    //float zcoord = 0;//zcoord in gpu
    float f[19];
	if( (x > LRX0+1 && x < LRX0+XLRDIM*LRFACTOR-1 && y > LRY0+1 && y < LRY0+YLRDIM*LRFACTOR-1) && 
	(x == int(LRX0+2) || x == int(LRX0+XLRDIM*LRFACTOR-1) || y == int(LRY0+2) || y == int(LRY0+YLRDIM*LRFACTOR-1)) )
	{
	float xcoord_LR = LRLEVEL*(xcoord-LRX0);//coord in refined region coordinates
	float ycoord_LR = LRLEVEL*(ycoord-LRY0);
	//float zcoord_LR = LRLEVEL*(zcoord-LRZ0);
    
    int xm = int(xcoord_LR);
    int ym = int(ycoord_LR);
    int xp = xm+1;
    int yp = ym+1;
    float xf = xcoord_LR-xm;
    float yf = ycoord_LR-ym;
    float zf = 0.5f;
//    for(int i=0;i<19;i++){
//        float v000 = gin[buff_memLR(i ,xm,ym,pitch_f)];
//        float v001 = gin[buff_memLR(i ,xp,ym,pitch_f)];
//        float v010 = gin[buff_memLR(i ,xm,yp,pitch_f)];
//        float v011 = gin[buff_memLR(i ,xp,yp,pitch_f)];
//        float v100 = fin[f_memLR(i ,xm,ym,0,pitch_f,zInner_f)];
//        float v101 = fin[f_memLR(i ,xp,ym,0,pitch_f,zInner_f)];
//        float v110 = fin[f_memLR(i ,xm,yp,0,pitch_f,zInner_f)];
//        float v111 = fin[f_memLR(i ,xp,yp,0,pitch_f,zInner_f)];
//        f[i] = trilinear_interp(v000, v001, v010, v011, v100, v101, v110, v111, xf, yf, zf);
//    }

    float u_x1,u_x2,u_x3,u_x4,u_x5,u_x6,u_x7,u_x8;
    float v_y1,v_y2,v_y3,v_y4,v_y5,v_y6,v_y7,v_y8;
    float w_z1,w_z2,w_z3,w_z4,w_z5,w_z6,w_z7,w_z8;
    float Sxy1,Sxy2,Sxy3,Sxy4,Sxy5,Sxy6,Sxy7,Sxy8;
    float Syz1,Syz2,Syz3,Syz4,Syz5,Syz6,Syz7,Syz8;
    float Sxz1,Sxz2,Sxz3,Sxz4,Sxz5,Sxz6,Sxz7,Sxz8;
    float m[8][19];
    for(int i=0;i<19;i++)
        f[i] = gin[buff_memLR(i ,xm,ym,pitch_f)];
    Moments(f,m[0]);
    StrainRate(u_x1,v_y1,w_z1,Sxy1,Syz1,Sxz1,omega_f,m[0]);
    for(int i=0;i<19;i++)
        f[i] = gin[buff_memLR(i ,xp,ym,pitch_f)];
    Moments(f,m[1]);
    StrainRate(u_x2,v_y2,w_z2,Sxy2,Syz2,Sxz2,omega_f,m[1]);
    for(int i=0;i<19;i++)
        f[i] = gin[buff_memLR(i ,xm,yp,pitch_f)];
    Moments(f,m[2]);
    StrainRate(u_x3,v_y3,w_z3,Sxy3,Syz3,Sxz3,omega_f,m[2]);
    for(int i=0;i<19;i++)
        f[i] = gin[buff_memLR(i ,xp,yp,pitch_f)];
    Moments(f,m[3]);
    StrainRate(u_x4,v_y4,w_z4,Sxy4,Syz4,Sxz4,omega_f,m[3]);
    for(int i=0;i<19;i++)
        f[i] = fin[f_memLR(i ,xm,ym,0,pitch_f,zInner_f)];
    Moments(f,m[4]);
    StrainRate(u_x5,v_y5,w_z5,Sxy5,Syz5,Sxz5,omega_f,m[4]);
    for(int i=0;i<19;i++)
        f[i] = fin[f_memLR(i ,xp,ym,0,pitch_f,zInner_f)];
    Moments(f,m[5]);
    StrainRate(u_x6,v_y6,w_z6,Sxy6,Syz6,Sxz6,omega_f,m[5]);
    for(int i=0;i<19;i++)
        f[i] = fin[f_memLR(i ,xm,yp,0,pitch_f,zInner_f)];
    Moments(f,m[6]);
    StrainRate(u_x7,v_y7,w_z7,Sxy7,Syz7,Sxz7,omega_f,m[6]);
    for(int i=0;i<19;i++)
        f[i] = fin[f_memLR(i ,xp,yp,0,pitch_f,zInner_f)];
    Moments(f,m[7]);
    StrainRate(u_x8,v_y8,w_z8,Sxy8,Syz8,Sxz8,omega_f,m[7]);

    float cx = -((u_x8-u_x7+u_x6-u_x5+u_x4-u_x3+u_x2-u_x1))*0.03125f;
    float cy = -((Sxy8+Sxy7-Sxy6-Sxy5+Sxy4+Sxy3-Sxy2-Sxy1)-m[7][5]+m[6][5]+m[5][5]-m[4][5]-m[3][5]+m[2][5]+m[1][5]-m[0][5])*0.0625f;
    float cz = -((Sxz8+Sxz7+Sxz6+Sxz5-Sxz4-Sxz3-Sxz2-Sxz1)-m[7][7]+m[6][7]-m[5][7]+m[4][7]+m[3][7]-m[2][7]+m[1][7]-m[0][7])*0.0625f;
    float dx = -((Sxy8-Sxy7+Sxy6-Sxy5+Sxy4-Sxy3+Sxy2-Sxy1)-m[7][3]+m[6][3]+m[5][3]-m[4][3]-m[3][3]+m[2][3]+m[1][3]-m[0][3])*0.0625f;
    float dy = -((v_y8+v_y7-v_y6-v_y5+v_y4+v_y3-v_y2-v_y1))*0.03125f;
    float dz = -((Syz8+Syz7+Syz6+Syz5-Syz4-Syz3-Syz2-Syz1)-m[7][7]-m[6][7]+m[5][7]+m[4][7]+m[3][7]+m[2][7]-m[1][7]-m[0][7])*0.0625f;
    float ex = -((Sxz8-Sxz7+Sxz6-Sxz5+Sxz4-Sxz3+Sxz2-Sxz1)-m[7][3]+m[6][3]-m[5][3]+m[4][3]+m[3][3]-m[2][3]+m[1][3]-m[0][3])*0.0625f;
    float ey = -((Syz8+Syz7-Syz6-Syz5+Syz4+Syz3-Syz2-Syz1)-m[7][5]-m[6][5]+m[5][5]+m[4][5]+m[3][5]+m[2][5]-m[1][5]-m[0][5])*0.0625f;
    float ez = -((w_z8+w_z7+w_z6+w_z5-w_z4-w_z3-w_z2-w_z1))*0.03125f;

    for(int i = 0; i<19; i++)
        m[0][i] = trilinear_interp(m[0][i],m[1][i],m[2][i],m[3][i],m[4][i],m[5][i],m[6][i],m[7][i], xf, yf, zf);
    float xpr = 4.f*xf*xf-4.f*xf+1.f;
    float ypr = 4.f*yf*yf-4.f*yf+1.f;
    float zpr = 4.f*zf*zf-4.f*zf+1.f;
    m[0][3] += cx*(1.f-xpr)+cy*(1.f-ypr)+cz*(1.f-zpr);
    m[0][5] += dx*(1.f-xpr)+dy*(1.f-ypr)+dz*(1.f-zpr);
    m[0][7] += ex*(1.f-xpr)+ey*(1.f-ypr)+ez*(1.f-zpr);
    InvertMoments(f,m[0]);






	if(MODEL == "MRT")
	mrt_scale_cf(f[0],f[1],f[2],f[3],f[4],f[5],f[6],f[7],f[8],f[9],f[10],f[11],f[12],f[13],f[14],f[15],f[16],f[17],f[18],SF);
    else if(MODEL == "BGK")
	bgk_scale_cf(f[0],f[1],f[2],f[3],f[4],f[5],f[6],f[7],f[8],f[9],f[10],f[11],f[12],f[13],f[14],f[15],f[16],f[17],f[18],SF);

	gout[buff_mem(0 ,x,y,pitch_c)] = f[0 ];
	gout[buff_mem(1 ,x,y,pitch_c)] = f[1 ];
	gout[buff_mem(2 ,x,y,pitch_c)] = f[2 ];
	gout[buff_mem(3 ,x,y,pitch_c)] = f[3 ];
	gout[buff_mem(4 ,x,y,pitch_c)] = f[4 ];
	gout[buff_mem(5 ,x,y,pitch_c)] = f[5 ];
	gout[buff_mem(6 ,x,y,pitch_c)] = f[6 ];
	gout[buff_mem(7 ,x,y,pitch_c)] = f[7 ];
	gout[buff_mem(8 ,x,y,pitch_c)] = f[8 ];
	gout[buff_mem(9 ,x,y,pitch_c)] = f[9 ];
	gout[buff_mem(10,x,y,pitch_c)] = f[10];
	gout[buff_mem(11,x,y,pitch_c)] = f[11];
	gout[buff_mem(12,x,y,pitch_c)] = f[12];
	gout[buff_mem(13,x,y,pitch_c)] = f[13];
	gout[buff_mem(14,x,y,pitch_c)] = f[14];
	gout[buff_mem(15,x,y,pitch_c)] = f[15];
	gout[buff_mem(16,x,y,pitch_c)] = f[16];
	gout[buff_mem(17,x,y,pitch_c)] = f[17];
	gout[buff_mem(18,x,y,pitch_c)] = f[18];

	}
}

__global__ void h_Extract(float* hout, float* fin, float* hin,
							size_t pitch_c, size_t pitch_f, int zInner_c, int zInner_f, float omega_f, float SF, int GPU)//pitch in elements
{
	int x = threadIdx.x+blockIdx.x*blockDim.x;//local index on f of coarse mesh
	int y = threadIdx.y+blockIdx.y*blockDim.y;
    float xcoord = x;//xcoord in gpu
    float ycoord = y;//ycoord in gpu
    //float zcoord = zInner_c+2-1;//zcoord in gpu
    float f[19];
	if( (x > LRX0+1 && x < LRX0+XLRDIM*LRFACTOR-1 && y > LRY0+1 && y < LRY0+YLRDIM*LRFACTOR-1) && 
	(x == int(LRX0+2) || x == int(LRX0+XLRDIM*LRFACTOR-1) || y == int(LRY0+2) || y == int(LRY0+YLRDIM*LRFACTOR-1)) )
	{
	float xcoord_LR = LRLEVEL*(xcoord-LRX0);//coord in refined region coordinates
	float ycoord_LR = LRLEVEL*(ycoord-LRY0);
	//float zcoord_LR = LRLEVEL*(zcoord-LRZ0);
    
    int xm = int(xcoord_LR);
    int ym = int(ycoord_LR);
    int xp = xm+1;
    int yp = ym+1;
    float xf = xcoord_LR-xm;
    float yf = ycoord_LR-ym;
    float zf = 0.5f;
//    for(int i=0;i<19;i++){
//        float v000 = fin[f_memLR(i ,xm,ym,zInner_f-1,pitch_f,zInner_f)];
//        float v001 = fin[f_memLR(i ,xp,ym,zInner_f-1,pitch_f,zInner_f)];
//        float v010 = fin[f_memLR(i ,xm,yp,zInner_f-1,pitch_f,zInner_f)];
//        float v011 = fin[f_memLR(i ,xp,yp,zInner_f-1,pitch_f,zInner_f)];
//        float v100 = hin[buff_memLR(i ,xm,ym,pitch_f)];
//        float v101 = hin[buff_memLR(i ,xp,ym,pitch_f)];
//        float v110 = hin[buff_memLR(i ,xm,yp,pitch_f)];
//        float v111 = hin[buff_memLR(i ,xp,yp,pitch_f)];
//        f[i] = trilinear_interp(v000, v001, v010, v011, v100, v101, v110, v111, xf, yf, zf);
//    }
    float u_x1,u_x2,u_x3,u_x4,u_x5,u_x6,u_x7,u_x8;
    float v_y1,v_y2,v_y3,v_y4,v_y5,v_y6,v_y7,v_y8;
    float w_z1,w_z2,w_z3,w_z4,w_z5,w_z6,w_z7,w_z8;
    float Sxy1,Sxy2,Sxy3,Sxy4,Sxy5,Sxy6,Sxy7,Sxy8;
    float Syz1,Syz2,Syz3,Syz4,Syz5,Syz6,Syz7,Syz8;
    float Sxz1,Sxz2,Sxz3,Sxz4,Sxz5,Sxz6,Sxz7,Sxz8;
    float m[8][19];
    for(int i=0;i<19;i++)
        f[i] = fin[f_memLR(i ,xm,ym,zInner_f-1,pitch_f,zInner_f)];
    Moments(f,m[0]);
    StrainRate(u_x1,v_y1,w_z1,Sxy1,Syz1,Sxz1,omega_f,m[0]);
    for(int i=0;i<19;i++)
        f[i] = fin[f_memLR(i ,xp,ym,zInner_f-1,pitch_f,zInner_f)];
    Moments(f,m[1]);
    StrainRate(u_x2,v_y2,w_z2,Sxy2,Syz2,Sxz2,omega_f,m[1]);
    for(int i=0;i<19;i++)
        f[i] = fin[f_memLR(i ,xm,yp,zInner_f-1,pitch_f,zInner_f)];
    Moments(f,m[2]);
    StrainRate(u_x3,v_y3,w_z3,Sxy3,Syz3,Sxz3,omega_f,m[2]);
    for(int i=0;i<19;i++)
        f[i] = fin[f_memLR(i ,xp,yp,zInner_f-1,pitch_f,zInner_f)];
    Moments(f,m[3]);
    StrainRate(u_x4,v_y4,w_z4,Sxy4,Syz4,Sxz4,omega_f,m[3]);
    for(int i=0;i<19;i++)
        f[i] = hin[buff_memLR(i ,xm,ym,pitch_f)];
    Moments(f,m[4]);
    StrainRate(u_x5,v_y5,w_z5,Sxy5,Syz5,Sxz5,omega_f,m[4]);
    for(int i=0;i<19;i++)
        f[i] = hin[buff_memLR(i ,xp,ym,pitch_f)];
    Moments(f,m[5]);
    StrainRate(u_x6,v_y6,w_z6,Sxy6,Syz6,Sxz6,omega_f,m[5]);
    for(int i=0;i<19;i++)
        f[i] = hin[buff_memLR(i ,xm,yp,pitch_f)];
    Moments(f,m[6]);
    StrainRate(u_x7,v_y7,w_z7,Sxy7,Syz7,Sxz7,omega_f,m[6]);
    for(int i=0;i<19;i++)
        f[i] = hin[buff_memLR(i ,xp,yp,pitch_f)];
    Moments(f,m[7]);
    StrainRate(u_x8,v_y8,w_z8,Sxy8,Syz8,Sxz8,omega_f,m[7]);

    float cx = -((u_x8-u_x7+u_x6-u_x5+u_x4-u_x3+u_x2-u_x1))*0.03125f;
    float cy = -((Sxy8+Sxy7-Sxy6-Sxy5+Sxy4+Sxy3-Sxy2-Sxy1)-m[7][5]+m[6][5]+m[5][5]-m[4][5]-m[3][5]+m[2][5]+m[1][5]-m[0][5])*0.0625f;
    float cz = -((Sxz8+Sxz7+Sxz6+Sxz5-Sxz4-Sxz3-Sxz2-Sxz1)-m[7][7]+m[6][7]-m[5][7]+m[4][7]+m[3][7]-m[2][7]+m[1][7]-m[0][7])*0.0625f;
    float dx = -((Sxy8-Sxy7+Sxy6-Sxy5+Sxy4-Sxy3+Sxy2-Sxy1)-m[7][3]+m[6][3]+m[5][3]-m[4][3]-m[3][3]+m[2][3]+m[1][3]-m[0][3])*0.0625f;
    float dy = -((v_y8+v_y7-v_y6-v_y5+v_y4+v_y3-v_y2-v_y1))*0.03125f;
    float dz = -((Syz8+Syz7+Syz6+Syz5-Syz4-Syz3-Syz2-Syz1)-m[7][7]-m[6][7]+m[5][7]+m[4][7]+m[3][7]+m[2][7]-m[1][7]-m[0][7])*0.0625f;
    float ex = -((Sxz8-Sxz7+Sxz6-Sxz5+Sxz4-Sxz3+Sxz2-Sxz1)-m[7][3]+m[6][3]-m[5][3]+m[4][3]+m[3][3]-m[2][3]+m[1][3]-m[0][3])*0.0625f;
    float ey = -((Syz8+Syz7-Syz6-Syz5+Syz4+Syz3-Syz2-Syz1)-m[7][5]-m[6][5]+m[5][5]+m[4][5]+m[3][5]+m[2][5]-m[1][5]-m[0][5])*0.0625f;
    float ez = -((w_z8+w_z7+w_z6+w_z5-w_z4-w_z3-w_z2-w_z1))*0.03125f;

    for(int i = 0; i<19; i++)
        m[0][i] = trilinear_interp(m[0][i],m[1][i],m[2][i],m[3][i],m[4][i],m[5][i],m[6][i],m[7][i], xf, yf, zf);
    float xpr = 4.f*xf*xf-4.f*xf+1.f;
    float ypr = 4.f*yf*yf-4.f*yf+1.f;
    float zpr = 4.f*zf*zf-4.f*zf+1.f;
    m[0][3] += cx*(1.f-xpr)+cy*(1.f-ypr)+cz*(1.f-zpr);
    m[0][5] += dx*(1.f-xpr)+dy*(1.f-ypr)+dz*(1.f-zpr);
    m[0][7] += ex*(1.f-xpr)+ey*(1.f-ypr)+ez*(1.f-zpr);
    InvertMoments(f,m[0]);






	if(MODEL == "MRT")
	mrt_scale_cf(f[0],f[1],f[2],f[3],f[4],f[5],f[6],f[7],f[8],f[9],f[10],f[11],f[12],f[13],f[14],f[15],f[16],f[17],f[18],SF);
    else if(MODEL == "BGK")
	bgk_scale_cf(f[0],f[1],f[2],f[3],f[4],f[5],f[6],f[7],f[8],f[9],f[10],f[11],f[12],f[13],f[14],f[15],f[16],f[17],f[18],SF);

	hout[buff_mem(0 ,x,y,pitch_c)] = f[0 ];
	hout[buff_mem(1 ,x,y,pitch_c)] = f[1 ];
	hout[buff_mem(2 ,x,y,pitch_c)] = f[2 ];
	hout[buff_mem(3 ,x,y,pitch_c)] = f[3 ];
	hout[buff_mem(4 ,x,y,pitch_c)] = f[4 ];
	hout[buff_mem(5 ,x,y,pitch_c)] = f[5 ];
	hout[buff_mem(6 ,x,y,pitch_c)] = f[6 ];
	hout[buff_mem(7 ,x,y,pitch_c)] = f[7 ];
	hout[buff_mem(8 ,x,y,pitch_c)] = f[8 ];
	hout[buff_mem(9 ,x,y,pitch_c)] = f[9 ];
	hout[buff_mem(10,x,y,pitch_c)] = f[10];
	hout[buff_mem(11,x,y,pitch_c)] = f[11];
	hout[buff_mem(12,x,y,pitch_c)] = f[12];
	hout[buff_mem(13,x,y,pitch_c)] = f[13];
	hout[buff_mem(14,x,y,pitch_c)] = f[14];
	hout[buff_mem(15,x,y,pitch_c)] = f[15];
	hout[buff_mem(16,x,y,pitch_c)] = f[16];
	hout[buff_mem(17,x,y,pitch_c)] = f[17];
	hout[buff_mem(18,x,y,pitch_c)] = f[18];

	}
}

__global__ void update_inner(float* fA, float* fB, float* g, float* h,
							float omega, size_t pitch, int GPU, int zInner, //pitch in elements
                            float *uAv, float *vAv, float *ufluc, float *vfluc, int t)//pitch in elements
                            
{
	int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
	int y = threadIdx.y+blockIdx.y*blockDim.y;
	int z = threadIdx.z+blockIdx.z*blockDim.z;
	int j = x+y*pitch+z*YDIM*pitch;//index on padded mem (pitch in elements)
	int im = ImageFcn(x,y,GPU*(zInner+2)+1+z);
	float f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18;

//	if(REFINEMENT == "YES" && x > LRX0+1 && x < LRX0+(XLRDIM-1)*LRFACTOR-1 
//		&& y > LRY0+1 && y < LRY0+(YLRDIM-1)*LRFACTOR-1 && z > LRZ0+1 && z < LRZ0+(ZLRDIM-1)*LRFACTOR-1 ||
//		(x>XDIM-1)){
//	}
//	else{
    f0 = fA[j];
	f1 = fA[f_mem   (1 ,x-1,y  ,z  ,pitch, zInner)];
	f3 = fA[f_mem   (3 ,x+1,y  ,z  ,pitch, zInner)];
	f2 = fA[f_mem   (2 ,x  ,y-1,z  ,pitch, zInner)];
	f5 = fA[f_mem   (5 ,x-1,y-1,z  ,pitch, zInner)];
	f6 = fA[f_mem   (6 ,x+1,y-1,z  ,pitch, zInner)];
	f4 = fA[f_mem   (4 ,x  ,y+1,z  ,pitch, zInner)];
	f7 = fA[f_mem   (7 ,x+1,y+1,z  ,pitch, zInner)];
	f8 = fA[f_mem   (8 ,x-1,y+1,z  ,pitch, zInner)];

    if(z==zInner-1){//top nodes need info from h
	f9 = fA[f_mem   (9 ,x  ,y  ,z-1,pitch, zInner)];
	f10= fA[f_mem   (10,x-1,y  ,z-1,pitch, zInner)];
	f11= fA[f_mem   (11,x  ,y-1,z-1,pitch, zInner)];
	f12= fA[f_mem   (12,x+1,y  ,z-1,pitch, zInner)];
	f13= fA[f_mem   (13,x  ,y+1,z-1,pitch, zInner)];
	f14= h [buff_mem(14,x  ,y  ,pitch)];
	f15= h [buff_mem(15,x-1,y  ,pitch)];
	f16= h [buff_mem(16,x  ,y-1,pitch)];
	f17= h [buff_mem(17,x+1,y  ,pitch)];
	f18= h [buff_mem(18,x  ,y+1,pitch)];
    }
    else if(z==0){//bottom nodes need info from g
	f9 = g [buff_mem(9 ,x  ,y  ,pitch)];
	f10= g [buff_mem(10,x-1,y  ,pitch)];
	f11= g [buff_mem(11,x  ,y-1,pitch)];
	f12= g [buff_mem(12,x+1,y  ,pitch)];
	f13= g [buff_mem(13,x  ,y+1,pitch)];
	f14= fA[f_mem   (14,x  ,y  ,z+1,pitch, zInner)];
	f15= fA[f_mem   (15,x-1,y  ,z+1,pitch, zInner)];
	f16= fA[f_mem   (16,x  ,y-1,z+1,pitch, zInner)];
	f17= fA[f_mem   (17,x+1,y  ,z+1,pitch, zInner)];
	f18= fA[f_mem   (18,x  ,y+1,z+1,pitch, zInner)];
    }
    else{//normal nodes
	f9 = fA[f_mem(9 ,x  ,y  ,z-1,pitch,zInner)];
	f10= fA[f_mem(10,x-1,y  ,z-1,pitch,zInner)];
	f11= fA[f_mem(11,x  ,y-1,z-1,pitch,zInner)];
	f12= fA[f_mem(12,x+1,y  ,z-1,pitch,zInner)];
	f13= fA[f_mem(13,x  ,y+1,z-1,pitch,zInner)];
	f14= fA[f_mem(14,x  ,y  ,z+1,pitch,zInner)];
	f15= fA[f_mem(15,x-1,y  ,z+1,pitch,zInner)];
	f16= fA[f_mem(16,x  ,y-1,z+1,pitch,zInner)];
	f17= fA[f_mem(17,x+1,y  ,z+1,pitch,zInner)];
	f18= fA[f_mem(18,x  ,y+1,z+1,pitch,zInner)];

    }//end normal nodes

	if(im == 1 || im ==10){//BB
		fB[f_mem(1 ,x,y,z,pitch,zInner)] = f3 ;
		fB[f_mem(2 ,x,y,z,pitch,zInner)] = f4 ;
		fB[f_mem(3 ,x,y,z,pitch,zInner)] = f1 ;
		fB[f_mem(4 ,x,y,z,pitch,zInner)] = f2 ;
		fB[f_mem(5 ,x,y,z,pitch,zInner)] = f7 ;
		fB[f_mem(6 ,x,y,z,pitch,zInner)] = f8 ;
		fB[f_mem(7 ,x,y,z,pitch,zInner)] = f5 ;
		fB[f_mem(8 ,x,y,z,pitch,zInner)] = f6 ;
		fB[f_mem(9 ,x,y,z,pitch,zInner)] = f14;
		fB[f_mem(10,x,y,z,pitch,zInner)] = f17;
		fB[f_mem(11,x,y,z,pitch,zInner)] = f18;
		fB[f_mem(12,x,y,z,pitch,zInner)] = f15;
		fB[f_mem(13,x,y,z,pitch,zInner)] = f16;
		fB[f_mem(14,x,y,z,pitch,zInner)] = f9 ;
		fB[f_mem(15,x,y,z,pitch,zInner)] = f12;
		fB[f_mem(16,x,y,z,pitch,zInner)] = f13;
		fB[f_mem(17,x,y,z,pitch,zInner)] = f10;
		fB[f_mem(18,x,y,z,pitch,zInner)] = f11;
	}
	else{

        if(im == 100)//north outlet
        {
           	f0 = fA[f_mem(0 ,x,y-1,z,pitch,zInner)];
        	f1 = fA[f_mem(1 ,x,y-1,z,pitch,zInner)];
        	f3 = fA[f_mem(3 ,x,y-1,z,pitch,zInner)];
        	f2 = fA[f_mem(2 ,x,y-1,z,pitch,zInner)];
        	f5 = fA[f_mem(5 ,x,y-1,z,pitch,zInner)];
        	f6 = fA[f_mem(6 ,x,y-1,z,pitch,zInner)];
        	f4 = fA[f_mem(4 ,x,y-1,z,pitch,zInner)];
        	f7 = fA[f_mem(7 ,x,y-1,z,pitch,zInner)];
        	f8 = fA[f_mem(8 ,x,y-1,z,pitch,zInner)];
        	f9 = fA[f_mem(9 ,x,y-1,z,pitch,zInner)];
        	f10= fA[f_mem(10,x,y-1,z,pitch,zInner)];
        	f11= fA[f_mem(11,x,y-1,z,pitch,zInner)];
        	f12= fA[f_mem(12,x,y-1,z,pitch,zInner)];
        	f13= fA[f_mem(13,x,y-1,z,pitch,zInner)];
        	f14= fA[f_mem(14,x,y-1,z,pitch,zInner)];
        	f15= fA[f_mem(15,x,y-1,z,pitch,zInner)];
        	f16= fA[f_mem(16,x,y-1,z,pitch,zInner)];
        	f17= fA[f_mem(17,x,y-1,z,pitch,zInner)];
        	f18= fA[f_mem(18,x,y-1,z,pitch,zInner)];

			North_Extrap(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,1.0f);
        }
        if(im == 200)//south inlet
        {
           	f0 = fA[f_mem(0 ,x,y+1,z,pitch,zInner)];
        	f1 = fA[f_mem(1 ,x,y+1,z,pitch,zInner)];
        	f3 = fA[f_mem(3 ,x,y+1,z,pitch,zInner)];
        	f2 = fA[f_mem(2 ,x,y+1,z,pitch,zInner)];
        	f5 = fA[f_mem(5 ,x,y+1,z,pitch,zInner)];
        	f6 = fA[f_mem(6 ,x,y+1,z,pitch,zInner)];
        	f4 = fA[f_mem(4 ,x,y+1,z,pitch,zInner)];
        	f7 = fA[f_mem(7 ,x,y+1,z,pitch,zInner)];
        	f8 = fA[f_mem(8 ,x,y+1,z,pitch,zInner)];
        	f9 = fA[f_mem(9 ,x,y+1,z,pitch,zInner)];
        	f10= fA[f_mem(10,x,y+1,z,pitch,zInner)];
        	f11= fA[f_mem(11,x,y+1,z,pitch,zInner)];
        	f12= fA[f_mem(12,x,y+1,z,pitch,zInner)];
        	f13= fA[f_mem(13,x,y+1,z,pitch,zInner)];
        	f14= fA[f_mem(14,x,y+1,z,pitch,zInner)];
        	f15= fA[f_mem(15,x,y+1,z,pitch,zInner)];
        	f16= fA[f_mem(16,x,y+1,z,pitch,zInner)];
        	f17= fA[f_mem(17,x,y+1,z,pitch,zInner)];
        	f18= fA[f_mem(18,x,y+1,z,pitch,zInner)];

			South_Extrap(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,UMAX);
        }

		boundaries(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,y,GPU*(zInner+2)+1+z,im);

		if(MODEL == "MRT")
		mrt_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,omega);
		else if(MODEL == "BGK")
		bgk_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,omega);

        if(VELAV == 1){
            if(t>=START_VELAV && t<START_VELFLUC){
                float u_Av = uAv[x+y*pitch+(z+1)*pitch*YDIM];
                float v_Av = vAv[x+y*pitch+(z+1)*pitch*YDIM];
        		vel_av(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,u_Av,v_Av,t);
                uAv[x+y*pitch+(z+1)*pitch*YDIM] = u_Av;
                vAv[x+y*pitch+(z+1)*pitch*YDIM] = v_Av;
            }
            else if(t>=START_VELFLUC){
                float u_Av = uAv[x+y*pitch+(z+1)*pitch*YDIM];
                float v_Av = vAv[x+y*pitch+(z+1)*pitch*YDIM];
                float u_fluc = ufluc[x+y*pitch+(z+1)*pitch*YDIM];
                float v_fluc = vfluc[x+y*pitch+(z+1)*pitch*YDIM];
        		vel_fluc(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,u_Av,v_Av,u_fluc,v_fluc,t);
                ufluc[x+y*pitch+(z+1)*pitch*YDIM] = u_fluc;
                vfluc[x+y*pitch+(z+1)*pitch*YDIM] = v_fluc;
            }
        }

		fB[f_mem(0 ,x,y,z,pitch,zInner)] = f0 ;
		fB[f_mem(1 ,x,y,z,pitch,zInner)] = f1 ;
		fB[f_mem(2 ,x,y,z,pitch,zInner)] = f2 ;
		fB[f_mem(3 ,x,y,z,pitch,zInner)] = f3 ;
		fB[f_mem(4 ,x,y,z,pitch,zInner)] = f4 ;
		fB[f_mem(5 ,x,y,z,pitch,zInner)] = f5 ;
		fB[f_mem(6 ,x,y,z,pitch,zInner)] = f6 ;
		fB[f_mem(7 ,x,y,z,pitch,zInner)] = f7 ;
		fB[f_mem(8 ,x,y,z,pitch,zInner)] = f8 ;
		fB[f_mem(9 ,x,y,z,pitch,zInner)] = f9 ;
		fB[f_mem(10,x,y,z,pitch,zInner)] = f10;
		fB[f_mem(11,x,y,z,pitch,zInner)] = f11;
		fB[f_mem(12,x,y,z,pitch,zInner)] = f12;
		fB[f_mem(13,x,y,z,pitch,zInner)] = f13;
		fB[f_mem(14,x,y,z,pitch,zInner)] = f14;
		fB[f_mem(15,x,y,z,pitch,zInner)] = f15;
		fB[f_mem(16,x,y,z,pitch,zInner)] = f16;
		fB[f_mem(17,x,y,z,pitch,zInner)] = f17;
		fB[f_mem(18,x,y,z,pitch,zInner)] = f18;
	}
}

__global__ void update_bottom(float* gA, float* gB, float* f, float* temp,
							float omega, size_t pitch, int GPU, int zInner)//pitch in elements
{
	int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
	int y = threadIdx.y+blockIdx.y*blockDim.y;
	int j = x+y*pitch;//index on padded mem (pitch in elements)
	int im = ImageFcn(x,y,GPU*(zInner+2));
	float f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18;

	f0 = gA  [j];
	f1 = gA  [buff_mem(1 ,x-1,y  ,pitch)];
	f3 = gA  [buff_mem(3 ,x+1,y  ,pitch)];
	f2 = gA  [buff_mem(2 ,x  ,y-1,pitch)];
	f5 = gA  [buff_mem(5 ,x-1,y-1,pitch)];
	f6 = gA  [buff_mem(6 ,x+1,y-1,pitch)];
	f4 = gA  [buff_mem(4 ,x  ,y+1,pitch)];
	f7 = gA  [buff_mem(7 ,x+1,y+1,pitch)];
	f8 = gA  [buff_mem(8 ,x-1,y+1,pitch)];
	f9 = temp[buff_mem(9 ,x  ,y  ,pitch)];
	f10= temp[buff_mem(10,x-1,y  ,pitch)];
	f11= temp[buff_mem(11,x  ,y-1,pitch)];
	f12= temp[buff_mem(12,x+1,y  ,pitch)];
	f13= temp[buff_mem(13,x  ,y+1,pitch)];
	f14= f   [f_mem   (14,x  ,y  ,0,pitch, zInner)];
	f15= f   [f_mem   (15,x-1,y  ,0,pitch, zInner)];
	f16= f   [f_mem   (16,x  ,y-1,0,pitch, zInner)];
	f17= f   [f_mem   (17,x+1,y  ,0,pitch, zInner)];
	f18= f   [f_mem   (18,x  ,y+1,0,pitch, zInner)];

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
        if(im == 100)//north outlet
        {
           	f0 = gA[buff_mem(0 ,x,y-1,pitch)];
        	f1 = gA[buff_mem(1 ,x,y-1,pitch)];
        	f3 = gA[buff_mem(3 ,x,y-1,pitch)];
        	f2 = gA[buff_mem(2 ,x,y-1,pitch)];
        	f5 = gA[buff_mem(5 ,x,y-1,pitch)];
        	f6 = gA[buff_mem(6 ,x,y-1,pitch)];
        	f4 = gA[buff_mem(4 ,x,y-1,pitch)];
        	f7 = gA[buff_mem(7 ,x,y-1,pitch)];
        	f8 = gA[buff_mem(8 ,x,y-1,pitch)];
        	f9 = gA[buff_mem(9 ,x,y-1,pitch)];
        	f10= gA[buff_mem(10,x,y-1,pitch)];
        	f11= gA[buff_mem(11,x,y-1,pitch)];
        	f12= gA[buff_mem(12,x,y-1,pitch)];
        	f13= gA[buff_mem(13,x,y-1,pitch)];
        	f14= gA[buff_mem(14,x,y-1,pitch)];
        	f15= gA[buff_mem(15,x,y-1,pitch)];
        	f16= gA[buff_mem(16,x,y-1,pitch)];
        	f17= gA[buff_mem(17,x,y-1,pitch)];
        	f18= gA[buff_mem(18,x,y-1,pitch)];

			North_Extrap(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,1.0f);
        }
        if(im == 200)//south inlet
        {
           	f0 = gA[buff_mem(0 ,x,y+1,pitch)];
        	f1 = gA[buff_mem(1 ,x,y+1,pitch)];
        	f3 = gA[buff_mem(3 ,x,y+1,pitch)];
        	f2 = gA[buff_mem(2 ,x,y+1,pitch)];
        	f5 = gA[buff_mem(5 ,x,y+1,pitch)];
        	f6 = gA[buff_mem(6 ,x,y+1,pitch)];
        	f4 = gA[buff_mem(4 ,x,y+1,pitch)];
        	f7 = gA[buff_mem(7 ,x,y+1,pitch)];
        	f8 = gA[buff_mem(8 ,x,y+1,pitch)];
        	f9 = gA[buff_mem(9 ,x,y+1,pitch)];
        	f10= gA[buff_mem(10,x,y+1,pitch)];
        	f11= gA[buff_mem(11,x,y+1,pitch)];
        	f12= gA[buff_mem(12,x,y+1,pitch)];
        	f13= gA[buff_mem(13,x,y+1,pitch)];
        	f14= gA[buff_mem(14,x,y+1,pitch)];
        	f15= gA[buff_mem(15,x,y+1,pitch)];
        	f16= gA[buff_mem(16,x,y+1,pitch)];
        	f17= gA[buff_mem(17,x,y+1,pitch)];
        	f18= gA[buff_mem(18,x,y+1,pitch)];

			South_Extrap(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,UMAX);
        }

		boundaries(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,y,GPU*(zInner+2),im);

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
							float omega, size_t pitch, int GPU, int zInner)//pitch in elements
{
	int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
	int y = threadIdx.y+blockIdx.y*blockDim.y;
    //int z = (zInner+2)-1;//coord in GPU
	int j = x+y*pitch;//index on padded mem (pitch in elements)
	int im = ImageFcn(x,y,(GPU+1)*(zInner+2)-1);
	float f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18;

	f0 = hA[j];
	f1 = hA  [buff_mem(1 ,x-1,y  ,pitch)];
	f3 = hA  [buff_mem(3 ,x+1,y  ,pitch)];
	f2 = hA  [buff_mem(2 ,x  ,y-1,pitch)];
	f5 = hA  [buff_mem(5 ,x-1,y-1,pitch)];
	f6 = hA  [buff_mem(6 ,x+1,y-1,pitch)];
	f4 = hA  [buff_mem(4 ,x  ,y+1,pitch)];
	f7 = hA  [buff_mem(7 ,x+1,y+1,pitch)];
	f8 = hA  [buff_mem(8 ,x-1,y+1,pitch)];
	f9 = f   [f_mem   (9 ,x  ,y  ,zInner-1,pitch, zInner)];
	f10= f   [f_mem   (10,x-1,y  ,zInner-1,pitch, zInner)];
	f11= f   [f_mem   (11,x  ,y-1,zInner-1,pitch, zInner)];
	f12= f   [f_mem   (12,x+1,y  ,zInner-1,pitch, zInner)];
	f13= f   [f_mem   (13,x  ,y+1,zInner-1,pitch, zInner)];
	f14= temp[buff_mem(14,x  ,y  ,pitch)];
	f15= temp[buff_mem(15,x-1,y  ,pitch)];
	f16= temp[buff_mem(16,x  ,y-1,pitch)];
	f17= temp[buff_mem(17,x+1,y  ,pitch)];
	f18= temp[buff_mem(18,x  ,y+1,pitch)];

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
        if(im == 100)//north outlet
        {
           	f0 = hA[buff_mem(0 ,x,y-1,pitch)];
        	f1 = hA[buff_mem(1 ,x,y-1,pitch)];
        	f3 = hA[buff_mem(3 ,x,y-1,pitch)];
        	f2 = hA[buff_mem(2 ,x,y-1,pitch)];
        	f5 = hA[buff_mem(5 ,x,y-1,pitch)];
        	f6 = hA[buff_mem(6 ,x,y-1,pitch)];
        	f4 = hA[buff_mem(4 ,x,y-1,pitch)];
        	f7 = hA[buff_mem(7 ,x,y-1,pitch)];
        	f8 = hA[buff_mem(8 ,x,y-1,pitch)];
        	f9 = hA[buff_mem(9 ,x,y-1,pitch)];
        	f10= hA[buff_mem(10,x,y-1,pitch)];
        	f11= hA[buff_mem(11,x,y-1,pitch)];
        	f12= hA[buff_mem(12,x,y-1,pitch)];
        	f13= hA[buff_mem(13,x,y-1,pitch)];
        	f14= hA[buff_mem(14,x,y-1,pitch)];
        	f15= hA[buff_mem(15,x,y-1,pitch)];
        	f16= hA[buff_mem(16,x,y-1,pitch)];
        	f17= hA[buff_mem(17,x,y-1,pitch)];
        	f18= hA[buff_mem(18,x,y-1,pitch)];

			North_Extrap(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,1.0f);
        }
        if(im == 200)//south inlet
        {
           	f0 = hA[buff_mem(0 ,x,y+1,pitch)];
        	f1 = hA[buff_mem(1 ,x,y+1,pitch)];
        	f3 = hA[buff_mem(3 ,x,y+1,pitch)];
        	f2 = hA[buff_mem(2 ,x,y+1,pitch)];
        	f5 = hA[buff_mem(5 ,x,y+1,pitch)];
        	f6 = hA[buff_mem(6 ,x,y+1,pitch)];
        	f4 = hA[buff_mem(4 ,x,y+1,pitch)];
        	f7 = hA[buff_mem(7 ,x,y+1,pitch)];
        	f8 = hA[buff_mem(8 ,x,y+1,pitch)];
        	f9 = hA[buff_mem(9 ,x,y+1,pitch)];
        	f10= hA[buff_mem(10,x,y+1,pitch)];
        	f11= hA[buff_mem(11,x,y+1,pitch)];
        	f12= hA[buff_mem(12,x,y+1,pitch)];
        	f13= hA[buff_mem(13,x,y+1,pitch)];
        	f14= hA[buff_mem(14,x,y+1,pitch)];
        	f15= hA[buff_mem(15,x,y+1,pitch)];
        	f16= hA[buff_mem(16,x,y+1,pitch)];
        	f17= hA[buff_mem(17,x,y+1,pitch)];
        	f18= hA[buff_mem(18,x,y+1,pitch)];

			South_Extrap(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,UMAX);
        }



		boundaries(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,y,(GPU+1)*(zInner+2)-1,im);

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

__global__ void update_inner_force(float* fA, float* fB, float* g, float* h,
							float omega, size_t pitch, int GPU, int zInner, 
                            float *FX, float *FY, float *FZ, int Force_t,//pitch in elements
                            float *uAv, float *vAv, float *ufluc, float *vfluc, int t)//pitch in elements
{
	int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
	int y = threadIdx.y+blockIdx.y*blockDim.y;
	int z = threadIdx.z+blockIdx.z*blockDim.z;
	int j = x+y*pitch+z*YDIM*pitch;//index on padded mem (pitch in elements)
	int im = ImageFcn(x,y,GPU*(zInner+2)+1+z);
	float f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18;
	__shared__ float sumX[BLOCKSIZEX], sumY[BLOCKSIZEX], sumZ[BLOCKSIZEX];
	__shared__ int check[1];
	check[0] = 0;
	syncthreads();

    f0 = fA[j];
	f1 = fA[f_mem   (1 ,x-1,y  ,z  ,pitch, zInner)];
	f3 = fA[f_mem   (3 ,x+1,y  ,z  ,pitch, zInner)];
	f2 = fA[f_mem   (2 ,x  ,y-1,z  ,pitch, zInner)];
	f5 = fA[f_mem   (5 ,x-1,y-1,z  ,pitch, zInner)];
	f6 = fA[f_mem   (6 ,x+1,y-1,z  ,pitch, zInner)];
	f4 = fA[f_mem   (4 ,x  ,y+1,z  ,pitch, zInner)];
	f7 = fA[f_mem   (7 ,x+1,y+1,z  ,pitch, zInner)];
	f8 = fA[f_mem   (8 ,x-1,y+1,z  ,pitch, zInner)];

    if(z==zInner-1){//top nodes need info from h
	f9 = fA[f_mem   (9 ,x  ,y  ,z-1,pitch, zInner)];
	f10= fA[f_mem   (10,x-1,y  ,z-1,pitch, zInner)];
	f11= fA[f_mem   (11,x  ,y-1,z-1,pitch, zInner)];
	f12= fA[f_mem   (12,x+1,y  ,z-1,pitch, zInner)];
	f13= fA[f_mem   (13,x  ,y+1,z-1,pitch, zInner)];
	f14= h [buff_mem(14,x  ,y  ,pitch)];
	f15= h [buff_mem(15,x-1,y  ,pitch)];
	f16= h [buff_mem(16,x  ,y-1,pitch)];
	f17= h [buff_mem(17,x+1,y  ,pitch)];
	f18= h [buff_mem(18,x  ,y+1,pitch)];
    }
    else if(z==0){//bottom nodes need info from g
	f9 = g [buff_mem(9 ,x  ,y  ,pitch)];
	f10= g [buff_mem(10,x-1,y  ,pitch)];
	f11= g [buff_mem(11,x  ,y-1,pitch)];
	f12= g [buff_mem(12,x+1,y  ,pitch)];
	f13= g [buff_mem(13,x  ,y+1,pitch)];
	f14= fA[f_mem   (14,x  ,y  ,z+1,pitch, zInner)];
	f15= fA[f_mem   (15,x-1,y  ,z+1,pitch, zInner)];
	f16= fA[f_mem   (16,x  ,y-1,z+1,pitch, zInner)];
	f17= fA[f_mem   (17,x+1,y  ,z+1,pitch, zInner)];
	f18= fA[f_mem   (18,x  ,y+1,z+1,pitch, zInner)];
    }
    else{//normal nodes
	f9 = fA[f_mem(9 ,x  ,y  ,z-1,pitch,zInner)];
	f10= fA[f_mem(10,x-1,y  ,z-1,pitch,zInner)];
	f11= fA[f_mem(11,x  ,y-1,z-1,pitch,zInner)];
	f12= fA[f_mem(12,x+1,y  ,z-1,pitch,zInner)];
	f13= fA[f_mem(13,x  ,y+1,z-1,pitch,zInner)];
	f14= fA[f_mem(14,x  ,y  ,z+1,pitch,zInner)];
	f15= fA[f_mem(15,x-1,y  ,z+1,pitch,zInner)];
	f16= fA[f_mem(16,x  ,y-1,z+1,pitch,zInner)];
	f17= fA[f_mem(17,x+1,y  ,z+1,pitch,zInner)];
	f18= fA[f_mem(18,x  ,y+1,z+1,pitch,zInner)];

    }//end normal nodes

	if(im == 1 || im ==10){//BB
		if(im == 10){
		check[0] = 1;
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
		fB[f_mem(1 ,x,y,z,pitch,zInner)] = f3 ;
		fB[f_mem(2 ,x,y,z,pitch,zInner)] = f4 ;
		fB[f_mem(3 ,x,y,z,pitch,zInner)] = f1 ;
		fB[f_mem(4 ,x,y,z,pitch,zInner)] = f2 ;
		fB[f_mem(5 ,x,y,z,pitch,zInner)] = f7 ;
		fB[f_mem(6 ,x,y,z,pitch,zInner)] = f8 ;
		fB[f_mem(7 ,x,y,z,pitch,zInner)] = f5 ;
		fB[f_mem(8 ,x,y,z,pitch,zInner)] = f6 ;
		fB[f_mem(9 ,x,y,z,pitch,zInner)] = f14;
		fB[f_mem(10,x,y,z,pitch,zInner)] = f17;
		fB[f_mem(11,x,y,z,pitch,zInner)] = f18;
		fB[f_mem(12,x,y,z,pitch,zInner)] = f15;
		fB[f_mem(13,x,y,z,pitch,zInner)] = f16;
		fB[f_mem(14,x,y,z,pitch,zInner)] = f9 ;
		fB[f_mem(15,x,y,z,pitch,zInner)] = f12;
		fB[f_mem(16,x,y,z,pitch,zInner)] = f13;
		fB[f_mem(17,x,y,z,pitch,zInner)] = f10;
		fB[f_mem(18,x,y,z,pitch,zInner)] = f11;
	}
	else{
		sumX[threadIdx.x]=0.f;
		sumY[threadIdx.x]=0.f;
		sumZ[threadIdx.x]=0.f;

        if(im == 100)//north outlet
        {
           	f0 = fA[f_mem(0 ,x,y-1,z,pitch,zInner)];
        	f1 = fA[f_mem(1 ,x,y-1,z,pitch,zInner)];
        	f3 = fA[f_mem(3 ,x,y-1,z,pitch,zInner)];
        	f2 = fA[f_mem(2 ,x,y-1,z,pitch,zInner)];
        	f5 = fA[f_mem(5 ,x,y-1,z,pitch,zInner)];
        	f6 = fA[f_mem(6 ,x,y-1,z,pitch,zInner)];
        	f4 = fA[f_mem(4 ,x,y-1,z,pitch,zInner)];
        	f7 = fA[f_mem(7 ,x,y-1,z,pitch,zInner)];
        	f8 = fA[f_mem(8 ,x,y-1,z,pitch,zInner)];
        	f9 = fA[f_mem(9 ,x,y-1,z,pitch,zInner)];
        	f10= fA[f_mem(10,x,y-1,z,pitch,zInner)];
        	f11= fA[f_mem(11,x,y-1,z,pitch,zInner)];
        	f12= fA[f_mem(12,x,y-1,z,pitch,zInner)];
        	f13= fA[f_mem(13,x,y-1,z,pitch,zInner)];
        	f14= fA[f_mem(14,x,y-1,z,pitch,zInner)];
        	f15= fA[f_mem(15,x,y-1,z,pitch,zInner)];
        	f16= fA[f_mem(16,x,y-1,z,pitch,zInner)];
        	f17= fA[f_mem(17,x,y-1,z,pitch,zInner)];
        	f18= fA[f_mem(18,x,y-1,z,pitch,zInner)];

			North_Extrap(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,1.0f);
        }
        if(im == 200)//south inlet
        {
           	f0 = fA[f_mem(0 ,x,y+1,z,pitch,zInner)];
        	f1 = fA[f_mem(1 ,x,y+1,z,pitch,zInner)];
        	f3 = fA[f_mem(3 ,x,y+1,z,pitch,zInner)];
        	f2 = fA[f_mem(2 ,x,y+1,z,pitch,zInner)];
        	f5 = fA[f_mem(5 ,x,y+1,z,pitch,zInner)];
        	f6 = fA[f_mem(6 ,x,y+1,z,pitch,zInner)];
        	f4 = fA[f_mem(4 ,x,y+1,z,pitch,zInner)];
        	f7 = fA[f_mem(7 ,x,y+1,z,pitch,zInner)];
        	f8 = fA[f_mem(8 ,x,y+1,z,pitch,zInner)];
        	f9 = fA[f_mem(9 ,x,y+1,z,pitch,zInner)];
        	f10= fA[f_mem(10,x,y+1,z,pitch,zInner)];
        	f11= fA[f_mem(11,x,y+1,z,pitch,zInner)];
        	f12= fA[f_mem(12,x,y+1,z,pitch,zInner)];
        	f13= fA[f_mem(13,x,y+1,z,pitch,zInner)];
        	f14= fA[f_mem(14,x,y+1,z,pitch,zInner)];
        	f15= fA[f_mem(15,x,y+1,z,pitch,zInner)];
        	f16= fA[f_mem(16,x,y+1,z,pitch,zInner)];
        	f17= fA[f_mem(17,x,y+1,z,pitch,zInner)];
        	f18= fA[f_mem(18,x,y+1,z,pitch,zInner)];

			South_Extrap(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,UMAX);
        }

		boundaries(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,y,GPU*(zInner+2)+1+z,im);

		if(MODEL == "MRT")
		mrt_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,omega);
		else if(MODEL == "BGK")
		bgk_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,omega);

        if(VELAV == 1){
            if(t>=START_VELAV && t<START_VELFLUC){
                float u_Av = uAv[x+y*pitch+(z+1)*pitch*YDIM];
                float v_Av = vAv[x+y*pitch+(z+1)*pitch*YDIM];
        		vel_av(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,u_Av,v_Av,t);
                uAv[x+y*pitch+(z+1)*pitch*YDIM] = u_Av;
                vAv[x+y*pitch+(z+1)*pitch*YDIM] = v_Av;
            }
            else if(t>=START_VELFLUC){
                float u_Av = uAv[x+y*pitch+(z+1)*pitch*YDIM];
                float v_Av = vAv[x+y*pitch+(z+1)*pitch*YDIM];
                float u_fluc = ufluc[x+y*pitch+(z+1)*pitch*YDIM];
                float v_fluc = vfluc[x+y*pitch+(z+1)*pitch*YDIM];
        		vel_fluc(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,u_Av,v_Av,u_fluc,v_fluc,t);
                ufluc[x+y*pitch+(z+1)*pitch*YDIM] = u_fluc;
                vfluc[x+y*pitch+(z+1)*pitch*YDIM] = v_fluc;
            }
        }


		fB[f_mem(0 ,x,y,z,pitch,zInner)] = f0 ;
		fB[f_mem(1 ,x,y,z,pitch,zInner)] = f1 ;
		fB[f_mem(2 ,x,y,z,pitch,zInner)] = f2 ;
		fB[f_mem(3 ,x,y,z,pitch,zInner)] = f3 ;
		fB[f_mem(4 ,x,y,z,pitch,zInner)] = f4 ;
		fB[f_mem(5 ,x,y,z,pitch,zInner)] = f5 ;
		fB[f_mem(6 ,x,y,z,pitch,zInner)] = f6 ;
		fB[f_mem(7 ,x,y,z,pitch,zInner)] = f7 ;
		fB[f_mem(8 ,x,y,z,pitch,zInner)] = f8 ;
		fB[f_mem(9 ,x,y,z,pitch,zInner)] = f9 ;
		fB[f_mem(10,x,y,z,pitch,zInner)] = f10;
		fB[f_mem(11,x,y,z,pitch,zInner)] = f11;
		fB[f_mem(12,x,y,z,pitch,zInner)] = f12;
		fB[f_mem(13,x,y,z,pitch,zInner)] = f13;
		fB[f_mem(14,x,y,z,pitch,zInner)] = f14;
		fB[f_mem(15,x,y,z,pitch,zInner)] = f15;
		fB[f_mem(16,x,y,z,pitch,zInner)] = f16;
		fB[f_mem(17,x,y,z,pitch,zInner)] = f17;
		fB[f_mem(18,x,y,z,pitch,zInner)] = f18;
	}

    syncthreads();
	if(check[0] == 1){
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
		atomicAdd(&FX[Force_t],sumX[0]);
		atomicAdd(&FY[Force_t],sumY[0]);
		atomicAdd(&FZ[Force_t],sumZ[0]);
	}
	}

}

__global__ void update_bottom_force(float* gA, float* gB, float* f, float* temp,
							float omega, size_t pitch, int GPU, int zInner,
                            float *FX, float *FY, float *FZ, int Force_t)//pitch in elements
{
	int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
	int y = threadIdx.y+blockIdx.y*blockDim.y;
	int j = x+y*pitch;//index on padded mem (pitch in elements)
	int im = ImageFcn(x,y,GPU*(zInner+2));
	float f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18;
	__shared__ float sumX[BLOCKSIZEX], sumY[BLOCKSIZEX], sumZ[BLOCKSIZEX];
	__shared__ int check[1];
	check[0] = 0;
	syncthreads();

	f0 = gA  [j];
	f1 = gA  [buff_mem(1 ,x-1,y  ,pitch)];
	f3 = gA  [buff_mem(3 ,x+1,y  ,pitch)];
	f2 = gA  [buff_mem(2 ,x  ,y-1,pitch)];
	f5 = gA  [buff_mem(5 ,x-1,y-1,pitch)];
	f6 = gA  [buff_mem(6 ,x+1,y-1,pitch)];
	f4 = gA  [buff_mem(4 ,x  ,y+1,pitch)];
	f7 = gA  [buff_mem(7 ,x+1,y+1,pitch)];
	f8 = gA  [buff_mem(8 ,x-1,y+1,pitch)];
	f9 = temp[buff_mem(9 ,x  ,y  ,pitch)];
	f10= temp[buff_mem(10,x-1,y  ,pitch)];
	f11= temp[buff_mem(11,x  ,y-1,pitch)];
	f12= temp[buff_mem(12,x+1,y  ,pitch)];
	f13= temp[buff_mem(13,x  ,y+1,pitch)];
	f14= f   [f_mem   (14,x  ,y  ,0,pitch, zInner)];
	f15= f   [f_mem   (15,x-1,y  ,0,pitch, zInner)];
	f16= f   [f_mem   (16,x  ,y-1,0,pitch, zInner)];
	f17= f   [f_mem   (17,x+1,y  ,0,pitch, zInner)];
	f18= f   [f_mem   (18,x  ,y+1,0,pitch, zInner)];

	if(im == 1 || im ==10){//BB
		if(im == 10){
		check[0] = 1;
		sumX[threadIdx.x] =2.f*f1-2.f*f3+2.f*f5+2.f*f8-2.f*f6;//-2.f*f7+2.f*f10-2.f*f12+2.f*f15-2.f*f17;
		sumX[threadIdx.x]+=-2.f*f7+2.f*f10-2.f*f12+2.f*f15-2.f*f17;
		sumY[threadIdx.x] =2.f*f2-2.f*f4+2.f*f5-2.f*f8+2.f*f6;//-2.f*f7+2.f*f11-2.f*f13+2.f*f16-2.f*f18;
		sumY[threadIdx.x]+=-2.f*f7+2.f*f11-2.f*f13+2.f*f16-2.f*f18;
		sumZ[threadIdx.x] =2.f*f9+2.f*f10+2.f*f11+2.f*f12+2.f*f13;//-2.f*f14-2.f*f15-2.f*f16-2.f*f17-2.f*f18;
		sumZ[threadIdx.x]+=-2.f*f14-2.f*f15-2.f*f16-2.f*f17-2.f*f18;
		}
		else{
		sumX[threadIdx.x]=0.f;
		sumY[threadIdx.x]=0.f;
		sumZ[threadIdx.x]=0.f;
		}
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
		sumX[threadIdx.x]=0.f;
		sumY[threadIdx.x]=0.f;
		sumZ[threadIdx.x]=0.f;

        if(im == 100)//north outlet
        {
           	f0 = gA[buff_mem(0 ,x,y-1,pitch)];
        	f1 = gA[buff_mem(1 ,x,y-1,pitch)];
        	f3 = gA[buff_mem(3 ,x,y-1,pitch)];
        	f2 = gA[buff_mem(2 ,x,y-1,pitch)];
        	f5 = gA[buff_mem(5 ,x,y-1,pitch)];
        	f6 = gA[buff_mem(6 ,x,y-1,pitch)];
        	f4 = gA[buff_mem(4 ,x,y-1,pitch)];
        	f7 = gA[buff_mem(7 ,x,y-1,pitch)];
        	f8 = gA[buff_mem(8 ,x,y-1,pitch)];
        	f9 = gA[buff_mem(9 ,x,y-1,pitch)];
        	f10= gA[buff_mem(10,x,y-1,pitch)];
        	f11= gA[buff_mem(11,x,y-1,pitch)];
        	f12= gA[buff_mem(12,x,y-1,pitch)];
        	f13= gA[buff_mem(13,x,y-1,pitch)];
        	f14= gA[buff_mem(14,x,y-1,pitch)];
        	f15= gA[buff_mem(15,x,y-1,pitch)];
        	f16= gA[buff_mem(16,x,y-1,pitch)];
        	f17= gA[buff_mem(17,x,y-1,pitch)];
        	f18= gA[buff_mem(18,x,y-1,pitch)];

			North_Extrap(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,1.0f);
        }
        if(im == 200)//south inlet
        {
           	f0 = gA[buff_mem(0 ,x,y+1,pitch)];
        	f1 = gA[buff_mem(1 ,x,y+1,pitch)];
        	f3 = gA[buff_mem(3 ,x,y+1,pitch)];
        	f2 = gA[buff_mem(2 ,x,y+1,pitch)];
        	f5 = gA[buff_mem(5 ,x,y+1,pitch)];
        	f6 = gA[buff_mem(6 ,x,y+1,pitch)];
        	f4 = gA[buff_mem(4 ,x,y+1,pitch)];
        	f7 = gA[buff_mem(7 ,x,y+1,pitch)];
        	f8 = gA[buff_mem(8 ,x,y+1,pitch)];
        	f9 = gA[buff_mem(9 ,x,y+1,pitch)];
        	f10= gA[buff_mem(10,x,y+1,pitch)];
        	f11= gA[buff_mem(11,x,y+1,pitch)];
        	f12= gA[buff_mem(12,x,y+1,pitch)];
        	f13= gA[buff_mem(13,x,y+1,pitch)];
        	f14= gA[buff_mem(14,x,y+1,pitch)];
        	f15= gA[buff_mem(15,x,y+1,pitch)];
        	f16= gA[buff_mem(16,x,y+1,pitch)];
        	f17= gA[buff_mem(17,x,y+1,pitch)];
        	f18= gA[buff_mem(18,x,y+1,pitch)];

			South_Extrap(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,UMAX);
        }

		boundaries(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,y,GPU*(zInner+2),im);

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

    syncthreads();
	if(check[0] == 1){
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
		atomicAdd(&FX[Force_t],sumX[0]);
		atomicAdd(&FY[Force_t],sumY[0]);
		atomicAdd(&FZ[Force_t],sumZ[0]);
	}
	}

}

__global__ void update_top_force(float* hA, float* hB, float* f, float* temp,
							float omega, size_t pitch, int GPU, int zInner,//pitch in elements
                            float *FX, float *FY, float *FZ, int Force_t)//pitch in elements
{
	int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
	int y = threadIdx.y+blockIdx.y*blockDim.y;
    //int z = (zInner+2)-1;//coord in GPU
	int j = x+y*pitch;//index on padded mem (pitch in elements)
	int im = ImageFcn(x,y,(GPU+1)*(zInner+2)-1);
	float f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18;
	__shared__ float sumX[BLOCKSIZEX], sumY[BLOCKSIZEX], sumZ[BLOCKSIZEX];
	__shared__ int check[1];
	check[0] = 0;
	syncthreads();

	f0 = hA[j];
	f1 = hA  [buff_mem(1 ,x-1,y  ,pitch)];
	f3 = hA  [buff_mem(3 ,x+1,y  ,pitch)];
	f2 = hA  [buff_mem(2 ,x  ,y-1,pitch)];
	f5 = hA  [buff_mem(5 ,x-1,y-1,pitch)];
	f6 = hA  [buff_mem(6 ,x+1,y-1,pitch)];
	f4 = hA  [buff_mem(4 ,x  ,y+1,pitch)];
	f7 = hA  [buff_mem(7 ,x+1,y+1,pitch)];
	f8 = hA  [buff_mem(8 ,x-1,y+1,pitch)];
	f9 = f   [f_mem   (9 ,x  ,y  ,zInner-1,pitch, zInner)];
	f10= f   [f_mem   (10,x-1,y  ,zInner-1,pitch, zInner)];
	f11= f   [f_mem   (11,x  ,y-1,zInner-1,pitch, zInner)];
	f12= f   [f_mem   (12,x+1,y  ,zInner-1,pitch, zInner)];
	f13= f   [f_mem   (13,x  ,y+1,zInner-1,pitch, zInner)];
	f14= temp[buff_mem(14,x  ,y  ,pitch)];
	f15= temp[buff_mem(15,x-1,y  ,pitch)];
	f16= temp[buff_mem(16,x  ,y-1,pitch)];
	f17= temp[buff_mem(17,x+1,y  ,pitch)];
	f18= temp[buff_mem(18,x  ,y+1,pitch)];

	if(im == 1 || im ==10){//BB
		if(im == 10){
		check[0] = 1;
		sumX[threadIdx.x] =2.f*f1-2.f*f3+2.f*f5+2.f*f8-2.f*f6;//-2.f*f7+2.f*f10-2.f*f12+2.f*f15-2.f*f17;
		sumX[threadIdx.x]+=-2.f*f7+2.f*f10-2.f*f12+2.f*f15-2.f*f17;
		sumY[threadIdx.x] =2.f*f2-2.f*f4+2.f*f5-2.f*f8+2.f*f6;//-2.f*f7+2.f*f11-2.f*f13+2.f*f16-2.f*f18;
		sumY[threadIdx.x]+=-2.f*f7+2.f*f11-2.f*f13+2.f*f16-2.f*f18;
		sumZ[threadIdx.x] =2.f*f9+2.f*f10+2.f*f11+2.f*f12+2.f*f13;//-2.f*f14-2.f*f15-2.f*f16-2.f*f17-2.f*f18;
		sumZ[threadIdx.x]+=-2.f*f14-2.f*f15-2.f*f16-2.f*f17-2.f*f18;
		}
		else{
		sumX[threadIdx.x]=0.f;
		sumY[threadIdx.x]=0.f;
		sumZ[threadIdx.x]=0.f;
		}
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
		sumX[threadIdx.x]=0.f;
		sumY[threadIdx.x]=0.f;
		sumZ[threadIdx.x]=0.f;
        if(im == 100)//north outlet
        {
           	f0 = hA[buff_mem(0 ,x,y-1,pitch)];
        	f1 = hA[buff_mem(1 ,x,y-1,pitch)];
        	f3 = hA[buff_mem(3 ,x,y-1,pitch)];
        	f2 = hA[buff_mem(2 ,x,y-1,pitch)];
        	f5 = hA[buff_mem(5 ,x,y-1,pitch)];
        	f6 = hA[buff_mem(6 ,x,y-1,pitch)];
        	f4 = hA[buff_mem(4 ,x,y-1,pitch)];
        	f7 = hA[buff_mem(7 ,x,y-1,pitch)];
        	f8 = hA[buff_mem(8 ,x,y-1,pitch)];
        	f9 = hA[buff_mem(9 ,x,y-1,pitch)];
        	f10= hA[buff_mem(10,x,y-1,pitch)];
        	f11= hA[buff_mem(11,x,y-1,pitch)];
        	f12= hA[buff_mem(12,x,y-1,pitch)];
        	f13= hA[buff_mem(13,x,y-1,pitch)];
        	f14= hA[buff_mem(14,x,y-1,pitch)];
        	f15= hA[buff_mem(15,x,y-1,pitch)];
        	f16= hA[buff_mem(16,x,y-1,pitch)];
        	f17= hA[buff_mem(17,x,y-1,pitch)];
        	f18= hA[buff_mem(18,x,y-1,pitch)];

			North_Extrap(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,1.0f);
        }
        if(im == 200)//south inlet
        {
           	f0 = hA[buff_mem(0 ,x,y+1,pitch)];
        	f1 = hA[buff_mem(1 ,x,y+1,pitch)];
        	f3 = hA[buff_mem(3 ,x,y+1,pitch)];
        	f2 = hA[buff_mem(2 ,x,y+1,pitch)];
        	f5 = hA[buff_mem(5 ,x,y+1,pitch)];
        	f6 = hA[buff_mem(6 ,x,y+1,pitch)];
        	f4 = hA[buff_mem(4 ,x,y+1,pitch)];
        	f7 = hA[buff_mem(7 ,x,y+1,pitch)];
        	f8 = hA[buff_mem(8 ,x,y+1,pitch)];
        	f9 = hA[buff_mem(9 ,x,y+1,pitch)];
        	f10= hA[buff_mem(10,x,y+1,pitch)];
        	f11= hA[buff_mem(11,x,y+1,pitch)];
        	f12= hA[buff_mem(12,x,y+1,pitch)];
        	f13= hA[buff_mem(13,x,y+1,pitch)];
        	f14= hA[buff_mem(14,x,y+1,pitch)];
        	f15= hA[buff_mem(15,x,y+1,pitch)];
        	f16= hA[buff_mem(16,x,y+1,pitch)];
        	f17= hA[buff_mem(17,x,y+1,pitch)];
        	f18= hA[buff_mem(18,x,y+1,pitch)];

			South_Extrap(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,UMAX);
        }

		boundaries(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,y,(GPU+1)*(zInner+2)-1,im);

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

    syncthreads();
	if(check[0] == 1){
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
		atomicAdd(&FX[Force_t],sumX[0]);
		atomicAdd(&FY[Force_t],sumY[0]);
		atomicAdd(&FZ[Force_t],sumZ[0]);
	}
	}


}

__global__ void update_inner_LR(float* fA, float* fB, float* g, float* h,
							float omega, size_t pitch, int GPU, int zInner,//pitch in elements
                            float *uAv, float *vAv, float *ufluc, float *vfluc, float t)
{
	int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
	int y = threadIdx.y+blockIdx.y*blockDim.y;
	int z = threadIdx.z+blockIdx.z*blockDim.z;
	int j = x+y*pitch+z*YLRDIM*pitch;//index on padded mem (pitch in elements)
	int im = ImageFcn(LRX0+LRFACTOR*x,LRY0+LRFACTOR*y,LRZ0+LRFACTOR*(GPU*(zInner+2)+1+z));
	float f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18;

    f0 = fA[j];
	f1 = fA[f_memLR   (1 ,x-1,y  ,z  ,pitch, zInner)];
	f3 = fA[f_memLR   (3 ,x+1,y  ,z  ,pitch, zInner)];
	f2 = fA[f_memLR   (2 ,x  ,y-1,z  ,pitch, zInner)];
	f5 = fA[f_memLR   (5 ,x-1,y-1,z  ,pitch, zInner)];
	f6 = fA[f_memLR   (6 ,x+1,y-1,z  ,pitch, zInner)];
	f4 = fA[f_memLR   (4 ,x  ,y+1,z  ,pitch, zInner)];
	f7 = fA[f_memLR   (7 ,x+1,y+1,z  ,pitch, zInner)];
	f8 = fA[f_memLR   (8 ,x-1,y+1,z  ,pitch, zInner)];

    if(z==zInner-1){//top nodes need info from h
	f9 = fA[f_memLR   (9 ,x  ,y  ,z-1,pitch, zInner)];
	f10= fA[f_memLR   (10,x-1,y  ,z-1,pitch, zInner)];
	f11= fA[f_memLR   (11,x  ,y-1,z-1,pitch, zInner)];
	f12= fA[f_memLR   (12,x+1,y  ,z-1,pitch, zInner)];
	f13= fA[f_memLR   (13,x  ,y+1,z-1,pitch, zInner)];
	f14= h [buff_memLR(14,x  ,y  ,pitch)];
	f15= h [buff_memLR(15,x-1,y  ,pitch)];
	f16= h [buff_memLR(16,x  ,y-1,pitch)];
	f17= h [buff_memLR(17,x+1,y  ,pitch)];
	f18= h [buff_memLR(18,x  ,y+1,pitch)];
    }
    else if(z==0){//bottom nodes need info from g
	f9 = g [buff_memLR(9 ,x  ,y  ,pitch)];
	f10= g [buff_memLR(10,x-1,y  ,pitch)];
	f11= g [buff_memLR(11,x  ,y-1,pitch)];
	f12= g [buff_memLR(12,x+1,y  ,pitch)];
	f13= g [buff_memLR(13,x  ,y+1,pitch)];
	f14= fA[f_memLR   (14,x  ,y  ,z+1,pitch, zInner)];
	f15= fA[f_memLR   (15,x-1,y  ,z+1,pitch, zInner)];
	f16= fA[f_memLR   (16,x  ,y-1,z+1,pitch, zInner)];
	f17= fA[f_memLR   (17,x+1,y  ,z+1,pitch, zInner)];
	f18= fA[f_memLR   (18,x  ,y+1,z+1,pitch, zInner)];
    }
    else{//normal nodes
	f9 = fA[f_memLR(9 ,x  ,y  ,z-1,pitch,zInner)];//
	f10= fA[f_memLR(10,x-1,y  ,z-1,pitch,zInner)];//
	f11= fA[f_memLR(11,x  ,y-1,z-1,pitch,zInner)];//
	f12= fA[f_memLR(12,x+1,y  ,z-1,pitch,zInner)];//
	f13= fA[f_memLR(13,x  ,y+1,z-1,pitch,zInner)];//
	f14= fA[f_memLR(14,x  ,y  ,z+1,pitch,zInner)];//
	f15= fA[f_memLR(15,x-1,y  ,z+1,pitch,zInner)];//
	f16= fA[f_memLR(16,x  ,y-1,z+1,pitch,zInner)];//
	f17= fA[f_memLR(17,x+1,y  ,z+1,pitch,zInner)];//
	f18= fA[f_memLR(18,x  ,y+1,z+1,pitch,zInner)];//

    }//end normal nodes

	if(im == 1 || im ==10){//BB
		fB[f_memLR(1 ,x,y,z,pitch,zInner)] = f3 ;
		fB[f_memLR(2 ,x,y,z,pitch,zInner)] = f4 ;
		fB[f_memLR(3 ,x,y,z,pitch,zInner)] = f1 ;
		fB[f_memLR(4 ,x,y,z,pitch,zInner)] = f2 ;
		fB[f_memLR(5 ,x,y,z,pitch,zInner)] = f7 ;
		fB[f_memLR(6 ,x,y,z,pitch,zInner)] = f8 ;
		fB[f_memLR(7 ,x,y,z,pitch,zInner)] = f5 ;
		fB[f_memLR(8 ,x,y,z,pitch,zInner)] = f6 ;
		fB[f_memLR(9 ,x,y,z,pitch,zInner)] = f14;
		fB[f_memLR(10,x,y,z,pitch,zInner)] = f17;
		fB[f_memLR(11,x,y,z,pitch,zInner)] = f18;
		fB[f_memLR(12,x,y,z,pitch,zInner)] = f15;
		fB[f_memLR(13,x,y,z,pitch,zInner)] = f16;
		fB[f_memLR(14,x,y,z,pitch,zInner)] = f9 ;
		fB[f_memLR(15,x,y,z,pitch,zInner)] = f12;
		fB[f_memLR(16,x,y,z,pitch,zInner)] = f13;
		fB[f_memLR(17,x,y,z,pitch,zInner)] = f10;
		fB[f_memLR(18,x,y,z,pitch,zInner)] = f11;
	}
	else{
		if(MODEL == "MRT")
		mrt_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,omega);
		else if(MODEL == "BGK")
		bgk_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,omega);

        if(VELAV == 1){
            if(t>=START_VELAV && t<START_VELFLUC){
                float u_Av = uAv[x+y*pitch+(z+1)*pitch*YLRDIM];
                float v_Av = vAv[x+y*pitch+(z+1)*pitch*YLRDIM];
        		vel_avLR(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,u_Av,v_Av,t);
                uAv[x+y*pitch+(z+1)*pitch*YLRDIM] = u_Av;
                vAv[x+y*pitch+(z+1)*pitch*YLRDIM] = v_Av;
            }
            else if(t>=START_VELFLUC){
                float u_Av = uAv[x+y*pitch+(z+1)*pitch*YLRDIM];
                float v_Av = vAv[x+y*pitch+(z+1)*pitch*YLRDIM];
                float u_fluc = ufluc[x+y*pitch+(z+1)*pitch*YLRDIM];
                float v_fluc = vfluc[x+y*pitch+(z+1)*pitch*YLRDIM];
        		vel_flucLR(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,u_Av,v_Av,u_fluc,v_fluc,t);
                ufluc[x+y*pitch+(z+1)*pitch*YLRDIM] = u_fluc;
                vfluc[x+y*pitch+(z+1)*pitch*YLRDIM] = v_fluc;
            }
        }

		fB[f_memLR(0 ,x,y,z,pitch,zInner)] = f0 ;
		fB[f_memLR(1 ,x,y,z,pitch,zInner)] = f1 ;
		fB[f_memLR(2 ,x,y,z,pitch,zInner)] = f2 ;
		fB[f_memLR(3 ,x,y,z,pitch,zInner)] = f3 ;
		fB[f_memLR(4 ,x,y,z,pitch,zInner)] = f4 ;
		fB[f_memLR(5 ,x,y,z,pitch,zInner)] = f5 ;
		fB[f_memLR(6 ,x,y,z,pitch,zInner)] = f6 ;
		fB[f_memLR(7 ,x,y,z,pitch,zInner)] = f7 ;
		fB[f_memLR(8 ,x,y,z,pitch,zInner)] = f8 ;
		fB[f_memLR(9 ,x,y,z,pitch,zInner)] = f9 ;
		fB[f_memLR(10,x,y,z,pitch,zInner)] = f10;
		fB[f_memLR(11,x,y,z,pitch,zInner)] = f11;
		fB[f_memLR(12,x,y,z,pitch,zInner)] = f12;
		fB[f_memLR(13,x,y,z,pitch,zInner)] = f13;
		fB[f_memLR(14,x,y,z,pitch,zInner)] = f14;
		fB[f_memLR(15,x,y,z,pitch,zInner)] = f15;
		fB[f_memLR(16,x,y,z,pitch,zInner)] = f16;
		fB[f_memLR(17,x,y,z,pitch,zInner)] = f17;
		fB[f_memLR(18,x,y,z,pitch,zInner)] = f18;
	}
}

__global__ void update_bottom_LR(float* gA, float* gB, float* f, float* temp,
							float omega, size_t pitch, int GPU, int zInner)//pitch in elements
{
	int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
	int y = threadIdx.y+blockIdx.y*blockDim.y;
    int z = (zInner+2)-1;
	int j = x+y*pitch;//index on padded mem (pitch in elements)
	//int im = ImageFcn(LRX0+LRFACTOR*x,LRY0+LRFACTOR*y,LRZ0+GPU*z*LRFACTOR);
	float f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18;
    float xcoord = LRX0+x*LRFACTOR;
	float ycoord = LRY0+y*LRFACTOR;
	float zcoord = LRZ0+GPU*LRFACTOR*z;
	int im = ImageFcn(xcoord,ycoord,zcoord);

	f0 = gA  [j];
	f1 = gA  [buff_memLR(1 ,x-1,y  ,pitch)];
	f3 = gA  [buff_memLR(3 ,x+1,y  ,pitch)];
	f2 = gA  [buff_memLR(2 ,x  ,y-1,pitch)];
	f5 = gA  [buff_memLR(5 ,x-1,y-1,pitch)];
	f6 = gA  [buff_memLR(6 ,x+1,y-1,pitch)];
	f4 = gA  [buff_memLR(4 ,x  ,y+1,pitch)];
	f7 = gA  [buff_memLR(7 ,x+1,y+1,pitch)];
	f8 = gA  [buff_memLR(8 ,x-1,y+1,pitch)];
	f9 = temp[buff_memLR(9 ,x  ,y  ,pitch)];
	f10= temp[buff_memLR(10,x-1,y  ,pitch)];
	f11= temp[buff_memLR(11,x  ,y-1,pitch)];
	f12= temp[buff_memLR(12,x+1,y  ,pitch)];
	f13= temp[buff_memLR(13,x  ,y+1,pitch)];
	f14= f   [f_memLR   (14,x  ,y  ,0,pitch, zInner)];
	f15= f   [f_memLR   (15,x-1,y  ,0,pitch, zInner)];
	f16= f   [f_memLR   (16,x  ,y-1,0,pitch, zInner)];
	f17= f   [f_memLR   (17,x+1,y  ,0,pitch, zInner)];
	f18= f   [f_memLR   (18,x  ,y+1,0,pitch, zInner)];

	if(im == 1 || im ==10){//BB
		gB[buff_memLR(0 ,x,y,pitch)] = f0 ;
		gB[buff_memLR(1 ,x,y,pitch)] = f3 ;
		gB[buff_memLR(2 ,x,y,pitch)] = f4 ;
		gB[buff_memLR(3 ,x,y,pitch)] = f1 ;
		gB[buff_memLR(4 ,x,y,pitch)] = f2 ;
		gB[buff_memLR(5 ,x,y,pitch)] = f7 ;
		gB[buff_memLR(6 ,x,y,pitch)] = f8 ;
		gB[buff_memLR(7 ,x,y,pitch)] = f5 ;
		gB[buff_memLR(8 ,x,y,pitch)] = f6 ;
		gB[buff_memLR(9 ,x,y,pitch)] = f14;
		gB[buff_memLR(10,x,y,pitch)] = f17;
		gB[buff_memLR(11,x,y,pitch)] = f18;
		gB[buff_memLR(12,x,y,pitch)] = f15;
		gB[buff_memLR(13,x,y,pitch)] = f16;
		gB[buff_memLR(14,x,y,pitch)] = f9 ;
		gB[buff_memLR(15,x,y,pitch)] = f12;
		gB[buff_memLR(16,x,y,pitch)] = f13;
		gB[buff_memLR(17,x,y,pitch)] = f10;
		gB[buff_memLR(18,x,y,pitch)] = f11;
	}
	else{
		if(MODEL == "MRT")
		mrt_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,omega);
		else if(MODEL == "BGK")
		bgk_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,omega);

		gB[buff_memLR(0 ,x,y,pitch)] = f0 ;
		gB[buff_memLR(1 ,x,y,pitch)] = f1 ;
		gB[buff_memLR(2 ,x,y,pitch)] = f2 ;
		gB[buff_memLR(3 ,x,y,pitch)] = f3 ;
		gB[buff_memLR(4 ,x,y,pitch)] = f4 ;
		gB[buff_memLR(5 ,x,y,pitch)] = f5 ;
		gB[buff_memLR(6 ,x,y,pitch)] = f6 ;
		gB[buff_memLR(7 ,x,y,pitch)] = f7 ;
		gB[buff_memLR(8 ,x,y,pitch)] = f8 ;
		gB[buff_memLR(9 ,x,y,pitch)] = f9 ;
		gB[buff_memLR(10,x,y,pitch)] = f10;
		gB[buff_memLR(11,x,y,pitch)] = f11;
		gB[buff_memLR(12,x,y,pitch)] = f12;
		gB[buff_memLR(13,x,y,pitch)] = f13;
		gB[buff_memLR(14,x,y,pitch)] = f14;
		gB[buff_memLR(15,x,y,pitch)] = f15;
		gB[buff_memLR(16,x,y,pitch)] = f16;
		gB[buff_memLR(17,x,y,pitch)] = f17;
		gB[buff_memLR(18,x,y,pitch)] = f18;
	}
}

__global__ void update_top_LR(float* hA, float* hB, float* f, float* temp,
							float omega, size_t pitch, int GPU, int zInner)//pitch in elements
{
	int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
	int y = threadIdx.y+blockIdx.y*blockDim.y;
    int z = (GPU+1)*(zInner+2)-1;//physical coord in LR region
	int j = x+y*pitch;//index on padded mem (pitch in elements)
    float xcoord = LRX0+x*LRFACTOR;
	float ycoord = LRY0+y*LRFACTOR;
	float zcoord = LRZ0+LRFACTOR*z;
	int im = ImageFcn(xcoord,ycoord,zcoord);
	float f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18;

	f0 = hA[j];
	f1 = hA  [buff_memLR(1 ,x-1,y  ,pitch)];
	f3 = hA  [buff_memLR(3 ,x+1,y  ,pitch)];
	f2 = hA  [buff_memLR(2 ,x  ,y-1,pitch)];
	f5 = hA  [buff_memLR(5 ,x-1,y-1,pitch)];
	f6 = hA  [buff_memLR(6 ,x+1,y-1,pitch)];
	f4 = hA  [buff_memLR(4 ,x  ,y+1,pitch)];
	f7 = hA  [buff_memLR(7 ,x+1,y+1,pitch)];
	f8 = hA  [buff_memLR(8 ,x-1,y+1,pitch)];
//	f9 = hA  [buff_memLR(9 ,x  ,y  ,pitch)];
//	f10= hA  [buff_memLR(10,x-1,y  ,pitch)];
//	f11= hA  [buff_memLR(11,x  ,y-1,pitch)];
//	f12= hA  [buff_memLR(12,x+1,y  ,pitch)];
//	f13= hA  [buff_memLR(13,x  ,y+1,pitch)];
//	f14= hA  [buff_memLR(9 ,x  ,y  ,pitch)];
//	f15= hA  [buff_memLR(10,x-1,y  ,pitch)];
//	f16= hA  [buff_memLR(11,x  ,y-1,pitch)];
//	f17= hA  [buff_memLR(12,x+1,y  ,pitch)];
//	f18= hA  [buff_memLR(13,x  ,y+1,pitch)];
	f9 = f   [f_memLR   (9 ,x  ,y  ,zInner-1,pitch, zInner)];
	f10= f   [f_memLR   (10,x-1,y  ,zInner-1,pitch, zInner)];
	f11= f   [f_memLR   (11,x  ,y-1,zInner-1,pitch, zInner)];
	f12= f   [f_memLR   (12,x+1,y  ,zInner-1,pitch, zInner)];
	f13= f   [f_memLR   (13,x  ,y+1,zInner-1,pitch, zInner)];
	f14= temp[buff_memLR(14,x  ,y  ,pitch)];
	f15= temp[buff_memLR(15,x-1,y  ,pitch)];
	f16= temp[buff_memLR(16,x  ,y-1,pitch)];
	f17= temp[buff_memLR(17,x+1,y  ,pitch)];
	f18= temp[buff_memLR(18,x  ,y+1,pitch)];

	if(im == 1 || im ==10){//BB
		hB[buff_memLR(0 ,x,y,pitch)] = f0 ;
		hB[buff_memLR(1 ,x,y,pitch)] = f3 ;
		hB[buff_memLR(2 ,x,y,pitch)] = f4 ;
		hB[buff_memLR(3 ,x,y,pitch)] = f1 ;
		hB[buff_memLR(4 ,x,y,pitch)] = f2 ;
		hB[buff_memLR(5 ,x,y,pitch)] = f7 ;
		hB[buff_memLR(6 ,x,y,pitch)] = f8 ;
		hB[buff_memLR(7 ,x,y,pitch)] = f5 ;
		hB[buff_memLR(8 ,x,y,pitch)] = f6 ;
		hB[buff_memLR(9 ,x,y,pitch)] = f14;
		hB[buff_memLR(10,x,y,pitch)] = f17;
		hB[buff_memLR(11,x,y,pitch)] = f18;
		hB[buff_memLR(12,x,y,pitch)] = f15;
		hB[buff_memLR(13,x,y,pitch)] = f16;
		hB[buff_memLR(14,x,y,pitch)] = f9 ;
		hB[buff_memLR(15,x,y,pitch)] = f12;
		hB[buff_memLR(16,x,y,pitch)] = f13;
		hB[buff_memLR(17,x,y,pitch)] = f10;
		hB[buff_memLR(18,x,y,pitch)] = f11;
	}
	else{
		if(MODEL == "MRT")
		mrt_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,omega);
		else if(MODEL == "BGK")
		bgk_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,omega);

		hB[buff_memLR(0 ,x,y,pitch)] = f0 ;
		hB[buff_memLR(1 ,x,y,pitch)] = f1 ;
		hB[buff_memLR(2 ,x,y,pitch)] = f2 ;
		hB[buff_memLR(3 ,x,y,pitch)] = f3 ;
		hB[buff_memLR(4 ,x,y,pitch)] = f4 ;
		hB[buff_memLR(5 ,x,y,pitch)] = f5 ;
		hB[buff_memLR(6 ,x,y,pitch)] = f6 ;
		hB[buff_memLR(7 ,x,y,pitch)] = f7 ;
		hB[buff_memLR(8 ,x,y,pitch)] = f8 ;
		hB[buff_memLR(9 ,x,y,pitch)] = f9 ;
		hB[buff_memLR(10,x,y,pitch)] = f10;
		hB[buff_memLR(11,x,y,pitch)] = f11;
		hB[buff_memLR(12,x,y,pitch)] = f12;
		hB[buff_memLR(13,x,y,pitch)] = f13;
		hB[buff_memLR(14,x,y,pitch)] = f14;
		hB[buff_memLR(15,x,y,pitch)] = f15;
		hB[buff_memLR(16,x,y,pitch)] = f16;
		hB[buff_memLR(17,x,y,pitch)] = f17;
		hB[buff_memLR(18,x,y,pitch)] = f18;
	}
}

__global__ void update_inner_LR_force(float* fA, float* fB, float* g, float* h,
							float omega, size_t pitch, int GPU, int zInner,
                            float *FX, float *FY, float *FZ, int Force_t,//pitch in elements
                            float *uAv, float *vAv, float *ufluc, float *vfluc, float t)
{
	int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
	int y = threadIdx.y+blockIdx.y*blockDim.y;
	int z = threadIdx.z+blockIdx.z*blockDim.z;
	int j = x+y*pitch+z*YLRDIM*pitch;//index on padded mem (pitch in elements)
	int im = ImageFcn(LRX0+LRFACTOR*x,LRY0+LRFACTOR*y,LRZ0+LRFACTOR*(GPU*(zInner+2)+1+z));
	float f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18;
	__shared__ float sumX[BLOCKSIZEX], sumY[BLOCKSIZEX], sumZ[BLOCKSIZEX];
	__shared__ int check[1];
	check[0] = 0;
	syncthreads();

    f0 = fA[j];
	f1 = fA[f_memLR   (1 ,x-1,y  ,z  ,pitch, zInner)];
	f3 = fA[f_memLR   (3 ,x+1,y  ,z  ,pitch, zInner)];
	f2 = fA[f_memLR   (2 ,x  ,y-1,z  ,pitch, zInner)];
	f5 = fA[f_memLR   (5 ,x-1,y-1,z  ,pitch, zInner)];
	f6 = fA[f_memLR   (6 ,x+1,y-1,z  ,pitch, zInner)];
	f4 = fA[f_memLR   (4 ,x  ,y+1,z  ,pitch, zInner)];
	f7 = fA[f_memLR   (7 ,x+1,y+1,z  ,pitch, zInner)];
	f8 = fA[f_memLR   (8 ,x-1,y+1,z  ,pitch, zInner)];

    if(z==zInner-1){//top nodes need info from h
	f9 = fA[f_memLR   (9 ,x  ,y  ,z-1,pitch, zInner)];
	f10= fA[f_memLR   (10,x-1,y  ,z-1,pitch, zInner)];
	f11= fA[f_memLR   (11,x  ,y-1,z-1,pitch, zInner)];
	f12= fA[f_memLR   (12,x+1,y  ,z-1,pitch, zInner)];
	f13= fA[f_memLR   (13,x  ,y+1,z-1,pitch, zInner)];
	f14= h [buff_memLR(14,x  ,y  ,pitch)];
	f15= h [buff_memLR(15,x-1,y  ,pitch)];
	f16= h [buff_memLR(16,x  ,y-1,pitch)];
	f17= h [buff_memLR(17,x+1,y  ,pitch)];
	f18= h [buff_memLR(18,x  ,y+1,pitch)];
    }
    else if(z==0){//bottom nodes need info from g
	f9 = g [buff_memLR(9 ,x  ,y  ,pitch)];
	f10= g [buff_memLR(10,x-1,y  ,pitch)];
	f11= g [buff_memLR(11,x  ,y-1,pitch)];
	f12= g [buff_memLR(12,x+1,y  ,pitch)];
	f13= g [buff_memLR(13,x  ,y+1,pitch)];
	f14= fA[f_memLR   (14,x  ,y  ,z+1,pitch, zInner)];
	f15= fA[f_memLR   (15,x-1,y  ,z+1,pitch, zInner)];
	f16= fA[f_memLR   (16,x  ,y-1,z+1,pitch, zInner)];
	f17= fA[f_memLR   (17,x+1,y  ,z+1,pitch, zInner)];
	f18= fA[f_memLR   (18,x  ,y+1,z+1,pitch, zInner)];
    }
    else{//normal nodes
	f9 = fA[f_memLR(9 ,x  ,y  ,z-1,pitch,zInner)];//
	f10= fA[f_memLR(10,x-1,y  ,z-1,pitch,zInner)];//
	f11= fA[f_memLR(11,x  ,y-1,z-1,pitch,zInner)];//
	f12= fA[f_memLR(12,x+1,y  ,z-1,pitch,zInner)];//
	f13= fA[f_memLR(13,x  ,y+1,z-1,pitch,zInner)];//
	f14= fA[f_memLR(14,x  ,y  ,z+1,pitch,zInner)];//
	f15= fA[f_memLR(15,x-1,y  ,z+1,pitch,zInner)];//
	f16= fA[f_memLR(16,x  ,y-1,z+1,pitch,zInner)];//
	f17= fA[f_memLR(17,x+1,y  ,z+1,pitch,zInner)];//
	f18= fA[f_memLR(18,x  ,y+1,z+1,pitch,zInner)];//

    }//end normal nodes

	if(im == 1 || im ==10){//BB
		if(im == 10){
		check[0] = 1;
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
		fB[f_memLR(1 ,x,y,z,pitch,zInner)] = f3 ;
		fB[f_memLR(2 ,x,y,z,pitch,zInner)] = f4 ;
		fB[f_memLR(3 ,x,y,z,pitch,zInner)] = f1 ;
		fB[f_memLR(4 ,x,y,z,pitch,zInner)] = f2 ;
		fB[f_memLR(5 ,x,y,z,pitch,zInner)] = f7 ;
		fB[f_memLR(6 ,x,y,z,pitch,zInner)] = f8 ;
		fB[f_memLR(7 ,x,y,z,pitch,zInner)] = f5 ;
		fB[f_memLR(8 ,x,y,z,pitch,zInner)] = f6 ;
		fB[f_memLR(9 ,x,y,z,pitch,zInner)] = f14;
		fB[f_memLR(10,x,y,z,pitch,zInner)] = f17;
		fB[f_memLR(11,x,y,z,pitch,zInner)] = f18;
		fB[f_memLR(12,x,y,z,pitch,zInner)] = f15;
		fB[f_memLR(13,x,y,z,pitch,zInner)] = f16;
		fB[f_memLR(14,x,y,z,pitch,zInner)] = f9 ;
		fB[f_memLR(15,x,y,z,pitch,zInner)] = f12;
		fB[f_memLR(16,x,y,z,pitch,zInner)] = f13;
		fB[f_memLR(17,x,y,z,pitch,zInner)] = f10;
		fB[f_memLR(18,x,y,z,pitch,zInner)] = f11;
	}
	else{
		sumX[threadIdx.x]=0.f;
		sumY[threadIdx.x]=0.f;
		sumZ[threadIdx.x]=0.f;

		if(MODEL == "MRT")
		mrt_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,omega);
		else if(MODEL == "BGK")
		bgk_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,omega);

        if(VELAV == 1){
            if(t>=START_VELAV && t<START_VELFLUC){
                float u_Av = uAv[x+y*pitch+(z+1)*pitch*YLRDIM];
                float v_Av = vAv[x+y*pitch+(z+1)*pitch*YLRDIM];
        		vel_avLR(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,u_Av,v_Av,t);
                uAv[x+y*pitch+(z+1)*pitch*YLRDIM] = u_Av;
                vAv[x+y*pitch+(z+1)*pitch*YLRDIM] = v_Av;
            }
            else if(t>=START_VELFLUC){
                float u_Av = uAv[x+y*pitch+(z+1)*pitch*YLRDIM];
                float v_Av = vAv[x+y*pitch+(z+1)*pitch*YLRDIM];
                float u_fluc = ufluc[x+y*pitch+(z+1)*pitch*YLRDIM];
                float v_fluc = vfluc[x+y*pitch+(z+1)*pitch*YLRDIM];
        		vel_flucLR(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,u_Av,v_Av,u_fluc,v_fluc,t);
                ufluc[x+y*pitch+(z+1)*pitch*YLRDIM] = u_fluc;
                vfluc[x+y*pitch+(z+1)*pitch*YLRDIM] = v_fluc;
            }
        }

		fB[f_memLR(0 ,x,y,z,pitch,zInner)] = f0 ;
		fB[f_memLR(1 ,x,y,z,pitch,zInner)] = f1 ;
		fB[f_memLR(2 ,x,y,z,pitch,zInner)] = f2 ;
		fB[f_memLR(3 ,x,y,z,pitch,zInner)] = f3 ;
		fB[f_memLR(4 ,x,y,z,pitch,zInner)] = f4 ;
		fB[f_memLR(5 ,x,y,z,pitch,zInner)] = f5 ;
		fB[f_memLR(6 ,x,y,z,pitch,zInner)] = f6 ;
		fB[f_memLR(7 ,x,y,z,pitch,zInner)] = f7 ;
		fB[f_memLR(8 ,x,y,z,pitch,zInner)] = f8 ;
		fB[f_memLR(9 ,x,y,z,pitch,zInner)] = f9 ;
		fB[f_memLR(10,x,y,z,pitch,zInner)] = f10;
		fB[f_memLR(11,x,y,z,pitch,zInner)] = f11;
		fB[f_memLR(12,x,y,z,pitch,zInner)] = f12;
		fB[f_memLR(13,x,y,z,pitch,zInner)] = f13;
		fB[f_memLR(14,x,y,z,pitch,zInner)] = f14;
		fB[f_memLR(15,x,y,z,pitch,zInner)] = f15;
		fB[f_memLR(16,x,y,z,pitch,zInner)] = f16;
		fB[f_memLR(17,x,y,z,pitch,zInner)] = f17;
		fB[f_memLR(18,x,y,z,pitch,zInner)] = f18;
	}

    syncthreads();
	if(check[0] == 1){
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
		atomicAdd(&FX[Force_t],sumX[0]);
		atomicAdd(&FY[Force_t],sumY[0]);
		atomicAdd(&FZ[Force_t],sumZ[0]);
	}
	}
}

__global__ void update_bottom_LR_force(float* gA, float* gB, float* f, float* temp,
							float omega, size_t pitch, int GPU, int zInner,
                            float *FX, float *FY, float *FZ, int Force_t)//pitch in elements
{
	int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
	int y = threadIdx.y+blockIdx.y*blockDim.y;
    int z = (zInner+2)-1;
	int j = x+y*pitch;//index on padded mem (pitch in elements)
	//int im = ImageFcn(LRX0+LRFACTOR*x,LRY0+LRFACTOR*y,LRZ0+GPU*z*LRFACTOR);
	float f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18;
    float xcoord = LRX0+x*LRFACTOR;
	float ycoord = LRY0+y*LRFACTOR;
	float zcoord = LRZ0+GPU*LRFACTOR*z;
	int im = ImageFcn(xcoord,ycoord,zcoord);
	__shared__ float sumX[BLOCKSIZEX], sumY[BLOCKSIZEX], sumZ[BLOCKSIZEX];
	__shared__ int check[1];
	check[0] = 0;
	syncthreads();

	f0 = gA  [j];
	f1 = gA  [buff_memLR(1 ,x-1,y  ,pitch)];
	f3 = gA  [buff_memLR(3 ,x+1,y  ,pitch)];
	f2 = gA  [buff_memLR(2 ,x  ,y-1,pitch)];
	f5 = gA  [buff_memLR(5 ,x-1,y-1,pitch)];
	f6 = gA  [buff_memLR(6 ,x+1,y-1,pitch)];
	f4 = gA  [buff_memLR(4 ,x  ,y+1,pitch)];
	f7 = gA  [buff_memLR(7 ,x+1,y+1,pitch)];
	f8 = gA  [buff_memLR(8 ,x-1,y+1,pitch)];
	f9 = temp[buff_memLR(9 ,x  ,y  ,pitch)];
	f10= temp[buff_memLR(10,x-1,y  ,pitch)];
	f11= temp[buff_memLR(11,x  ,y-1,pitch)];
	f12= temp[buff_memLR(12,x+1,y  ,pitch)];
	f13= temp[buff_memLR(13,x  ,y+1,pitch)];
	f14= f   [f_memLR   (14,x  ,y  ,0,pitch, zInner)];
	f15= f   [f_memLR   (15,x-1,y  ,0,pitch, zInner)];
	f16= f   [f_memLR   (16,x  ,y-1,0,pitch, zInner)];
	f17= f   [f_memLR   (17,x+1,y  ,0,pitch, zInner)];
	f18= f   [f_memLR   (18,x  ,y+1,0,pitch, zInner)];

	if(im == 1 || im ==10){//BB
		if(im == 10){
		check[0] = 1;
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
		gB[buff_memLR(0 ,x,y,pitch)] = f0 ;
		gB[buff_memLR(1 ,x,y,pitch)] = f3 ;
		gB[buff_memLR(2 ,x,y,pitch)] = f4 ;
		gB[buff_memLR(3 ,x,y,pitch)] = f1 ;
		gB[buff_memLR(4 ,x,y,pitch)] = f2 ;
		gB[buff_memLR(5 ,x,y,pitch)] = f7 ;
		gB[buff_memLR(6 ,x,y,pitch)] = f8 ;
		gB[buff_memLR(7 ,x,y,pitch)] = f5 ;
		gB[buff_memLR(8 ,x,y,pitch)] = f6 ;
		gB[buff_memLR(9 ,x,y,pitch)] = f14;
		gB[buff_memLR(10,x,y,pitch)] = f17;
		gB[buff_memLR(11,x,y,pitch)] = f18;
		gB[buff_memLR(12,x,y,pitch)] = f15;
		gB[buff_memLR(13,x,y,pitch)] = f16;
		gB[buff_memLR(14,x,y,pitch)] = f9 ;
		gB[buff_memLR(15,x,y,pitch)] = f12;
		gB[buff_memLR(16,x,y,pitch)] = f13;
		gB[buff_memLR(17,x,y,pitch)] = f10;
		gB[buff_memLR(18,x,y,pitch)] = f11;
	}
	else{
		sumX[threadIdx.x]=0.f;
		sumY[threadIdx.x]=0.f;
		sumZ[threadIdx.x]=0.f;

		if(MODEL == "MRT")
		mrt_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,omega);
		else if(MODEL == "BGK")
		bgk_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,omega);

		gB[buff_memLR(0 ,x,y,pitch)] = f0 ;
		gB[buff_memLR(1 ,x,y,pitch)] = f1 ;
		gB[buff_memLR(2 ,x,y,pitch)] = f2 ;
		gB[buff_memLR(3 ,x,y,pitch)] = f3 ;
		gB[buff_memLR(4 ,x,y,pitch)] = f4 ;
		gB[buff_memLR(5 ,x,y,pitch)] = f5 ;
		gB[buff_memLR(6 ,x,y,pitch)] = f6 ;
		gB[buff_memLR(7 ,x,y,pitch)] = f7 ;
		gB[buff_memLR(8 ,x,y,pitch)] = f8 ;
		gB[buff_memLR(9 ,x,y,pitch)] = f9 ;
		gB[buff_memLR(10,x,y,pitch)] = f10;
		gB[buff_memLR(11,x,y,pitch)] = f11;
		gB[buff_memLR(12,x,y,pitch)] = f12;
		gB[buff_memLR(13,x,y,pitch)] = f13;
		gB[buff_memLR(14,x,y,pitch)] = f14;
		gB[buff_memLR(15,x,y,pitch)] = f15;
		gB[buff_memLR(16,x,y,pitch)] = f16;
		gB[buff_memLR(17,x,y,pitch)] = f17;
		gB[buff_memLR(18,x,y,pitch)] = f18;
	}

    syncthreads();
	if(check[0] == 1){
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
		atomicAdd(&FX[Force_t],sumX[0]);
		atomicAdd(&FY[Force_t],sumY[0]);
		atomicAdd(&FZ[Force_t],sumZ[0]);
	}
	}
}

__global__ void update_top_LR_force(float* hA, float* hB, float* f, float* temp,
							float omega, size_t pitch, int GPU, int zInner,
                            float *FX, float *FY, float *FZ, int Force_t)//pitch in elements
{
	int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
	int y = threadIdx.y+blockIdx.y*blockDim.y;
    int z = (GPU+1)*(zInner+2)-1;//physical coord in LR region
	int j = x+y*pitch;//index on padded mem (pitch in elements)
    float xcoord = LRX0+x*LRFACTOR;
	float ycoord = LRY0+y*LRFACTOR;
	float zcoord = LRZ0+LRFACTOR*z;
	int im = ImageFcn(xcoord,ycoord,zcoord);
	float f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18;
	__shared__ float sumX[BLOCKSIZEX], sumY[BLOCKSIZEX], sumZ[BLOCKSIZEX];
	__shared__ int check[1];
	check[0] = 0;
	syncthreads();

	f0 = hA[j];
	f1 = hA  [buff_memLR(1 ,x-1,y  ,pitch)];
	f3 = hA  [buff_memLR(3 ,x+1,y  ,pitch)];
	f2 = hA  [buff_memLR(2 ,x  ,y-1,pitch)];
	f5 = hA  [buff_memLR(5 ,x-1,y-1,pitch)];
	f6 = hA  [buff_memLR(6 ,x+1,y-1,pitch)];
	f4 = hA  [buff_memLR(4 ,x  ,y+1,pitch)];
	f7 = hA  [buff_memLR(7 ,x+1,y+1,pitch)];
	f8 = hA  [buff_memLR(8 ,x-1,y+1,pitch)];
	f9 = f   [f_memLR   (9 ,x  ,y  ,zInner-1,pitch, zInner)];
	f10= f   [f_memLR   (10,x-1,y  ,zInner-1,pitch, zInner)];
	f11= f   [f_memLR   (11,x  ,y-1,zInner-1,pitch, zInner)];
	f12= f   [f_memLR   (12,x+1,y  ,zInner-1,pitch, zInner)];
	f13= f   [f_memLR   (13,x  ,y+1,zInner-1,pitch, zInner)];
	f14= temp[buff_memLR(14,x  ,y  ,pitch)];
	f15= temp[buff_memLR(15,x-1,y  ,pitch)];
	f16= temp[buff_memLR(16,x  ,y-1,pitch)];
	f17= temp[buff_memLR(17,x+1,y  ,pitch)];
	f18= temp[buff_memLR(18,x  ,y+1,pitch)];

	if(im == 1 || im ==10){//BB
		if(im == 10){
		check[0] = 1;
		sumX[threadIdx.x] =2.f*f1-2.f*f3+2.f*f5+2.f*f8-2.f*f6;//-2.f*f7+2.f*f10-2.f*f12+2.f*f15-2.f*f17;
		sumX[threadIdx.x]+=-2.f*f7+2.f*f10-2.f*f12+2.f*f15-2.f*f17;
		sumY[threadIdx.x] =2.f*f2-2.f*f4+2.f*f5-2.f*f8+2.f*f6;//-2.f*f7+2.f*f11-2.f*f13+2.f*f16-2.f*f18;
		sumY[threadIdx.x]+=-2.f*f7+2.f*f11-2.f*f13+2.f*f16-2.f*f18;
		sumZ[threadIdx.x] =2.f*f9+2.f*f10+2.f*f11+2.f*f12+2.f*f13;//-2.f*f14-2.f*f15-2.f*f16-2.f*f17-2.f*f18;
		sumZ[threadIdx.x]+=-2.f*f14-2.f*f15-2.f*f16-2.f*f17-2.f*f18;
		}
		else{
		sumX[threadIdx.x]=0.f;
		sumY[threadIdx.x]=0.f;
		sumZ[threadIdx.x]=0.f;
		}
		hB[buff_memLR(0 ,x,y,pitch)] = f0 ;
		hB[buff_memLR(1 ,x,y,pitch)] = f3 ;
		hB[buff_memLR(2 ,x,y,pitch)] = f4 ;
		hB[buff_memLR(3 ,x,y,pitch)] = f1 ;
		hB[buff_memLR(4 ,x,y,pitch)] = f2 ;
		hB[buff_memLR(5 ,x,y,pitch)] = f7 ;
		hB[buff_memLR(6 ,x,y,pitch)] = f8 ;
		hB[buff_memLR(7 ,x,y,pitch)] = f5 ;
		hB[buff_memLR(8 ,x,y,pitch)] = f6 ;
		hB[buff_memLR(9 ,x,y,pitch)] = f14;
		hB[buff_memLR(10,x,y,pitch)] = f17;
		hB[buff_memLR(11,x,y,pitch)] = f18;
		hB[buff_memLR(12,x,y,pitch)] = f15;
		hB[buff_memLR(13,x,y,pitch)] = f16;
		hB[buff_memLR(14,x,y,pitch)] = f9 ;
		hB[buff_memLR(15,x,y,pitch)] = f12;
		hB[buff_memLR(16,x,y,pitch)] = f13;
		hB[buff_memLR(17,x,y,pitch)] = f10;
		hB[buff_memLR(18,x,y,pitch)] = f11;
	}
	else{
		sumX[threadIdx.x]=0.f;
		sumY[threadIdx.x]=0.f;
		sumZ[threadIdx.x]=0.f;

		if(MODEL == "MRT")
		mrt_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,omega);
		else if(MODEL == "BGK")
		bgk_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,omega);

		hB[buff_memLR(0 ,x,y,pitch)] = f0 ;
		hB[buff_memLR(1 ,x,y,pitch)] = f1 ;
		hB[buff_memLR(2 ,x,y,pitch)] = f2 ;
		hB[buff_memLR(3 ,x,y,pitch)] = f3 ;
		hB[buff_memLR(4 ,x,y,pitch)] = f4 ;
		hB[buff_memLR(5 ,x,y,pitch)] = f5 ;
		hB[buff_memLR(6 ,x,y,pitch)] = f6 ;
		hB[buff_memLR(7 ,x,y,pitch)] = f7 ;
		hB[buff_memLR(8 ,x,y,pitch)] = f8 ;
		hB[buff_memLR(9 ,x,y,pitch)] = f9 ;
		hB[buff_memLR(10,x,y,pitch)] = f10;
		hB[buff_memLR(11,x,y,pitch)] = f11;
		hB[buff_memLR(12,x,y,pitch)] = f12;
		hB[buff_memLR(13,x,y,pitch)] = f13;
		hB[buff_memLR(14,x,y,pitch)] = f14;
		hB[buff_memLR(15,x,y,pitch)] = f15;
		hB[buff_memLR(16,x,y,pitch)] = f16;
		hB[buff_memLR(17,x,y,pitch)] = f17;
		hB[buff_memLR(18,x,y,pitch)] = f18;
	}

    syncthreads();
	if(check[0] == 1){
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
		atomicAdd(&FX[Force_t],sumX[0]);
		atomicAdd(&FY[Force_t],sumY[0]);
		atomicAdd(&FZ[Force_t],sumZ[0]);
	}
	}


}

__global__ void update_inner_LR_interp(float* fA, float* fB, float* g, float* h, float* f_c, float* g_c, float* h_c,
							float omega, float omega_c, size_t pitch, int zInner, size_t pitch_c, int zInner_c, float SF, int GPU,
                            float *uAv, float *vAv, float *ufluc, float *vfluc, float t)
{
	int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
	int y = threadIdx.y+blockIdx.y*blockDim.y;
	int z = threadIdx.z+blockIdx.z*blockDim.z;
	int j = x+y*pitch+z*YLRDIM*pitch;//index on padded mem (pitch in elements)
	float xcoord = LRX0+x*LRFACTOR;
	float ycoord = LRY0+y*LRFACTOR;
	float zcoord = LRZ0+(1+z)*LRFACTOR;//local zcoord within GPU
	int im = ImageFcn(xcoord,ycoord,GPU*(zInner_c+2)+zcoord);

	if(x < LRLEVEL || x > XLRDIM-1-LRLEVEL || y < LRLEVEL || y > YLRDIM-1-LRLEVEL)
    {
    float f[19];

    if(zcoord<1)
    {
    int xm = int(xcoord);
    int ym = int(ycoord);
    int zm = int(zcoord);//for zcoord<0
    int xp = xm+1;
    int yp = ym+1;
    //int zp = zm+1;
    float xf = xcoord-xm;
    float yf = ycoord-ym;
    float zf = zcoord-zm;
//    for(int i=0;i<19;i++){
//        float v000 = g_c[buff_mem(i ,xm,ym   ,pitch_c)];
//        float v001 = g_c[buff_mem(i ,xp,ym   ,pitch_c)];
//        float v010 = g_c[buff_mem(i ,xm,yp   ,pitch_c)];
//        float v011 = g_c[buff_mem(i ,xp,yp   ,pitch_c)];
//        float v100 = f_c[   f_mem(i ,xm,ym,0 ,pitch_c,zInner_c)];
//        float v101 = f_c[   f_mem(i ,xp,ym,0 ,pitch_c,zInner_c)];
//        float v110 = f_c[   f_mem(i ,xm,yp,0 ,pitch_c,zInner_c)];
//        float v111 = f_c[   f_mem(i ,xp,yp,0 ,pitch_c,zInner_c)];
//        f[i] = trilinear_interp(v000, v001, v010, v011, v100, v101, v110, v111, xf, yf, zf);
//    }
    float u_x1,u_x2,u_x3,u_x4,u_x5,u_x6,u_x7,u_x8;
    float v_y1,v_y2,v_y3,v_y4,v_y5,v_y6,v_y7,v_y8;
    float w_z1,w_z2,w_z3,w_z4,w_z5,w_z6,w_z7,w_z8;
    float Sxy1,Sxy2,Sxy3,Sxy4,Sxy5,Sxy6,Sxy7,Sxy8;
    float Syz1,Syz2,Syz3,Syz4,Syz5,Syz6,Syz7,Syz8;
    float Sxz1,Sxz2,Sxz3,Sxz4,Sxz5,Sxz6,Sxz7,Sxz8;
    float m[8][19];
    for(int i=0;i<19;i++)
        f[i] = g_c[buff_mem(i ,xm,ym   ,pitch_c)];
    Moments(f,m[0]);
    StrainRate(u_x1,v_y1,w_z1,Sxy1,Syz1,Sxz1,omega_c,m[0]);
    for(int i=0;i<19;i++)
        f[i] = g_c[buff_mem(i ,xp,ym   ,pitch_c)];
    Moments(f,m[1]);
    StrainRate(u_x2,v_y2,w_z2,Sxy2,Syz2,Sxz2,omega_c,m[1]);
    for(int i=0;i<19;i++)
        f[i] = g_c[buff_mem(i ,xm,yp   ,pitch_c)];
    Moments(f,m[2]);
    StrainRate(u_x3,v_y3,w_z3,Sxy3,Syz3,Sxz3,omega_c,m[2]);
    for(int i=0;i<19;i++)
        f[i] = g_c[buff_mem(i ,xp,yp   ,pitch_c)];
    Moments(f,m[3]);
    StrainRate(u_x4,v_y4,w_z4,Sxy4,Syz4,Sxz4,omega_c,m[3]);
    for(int i=0;i<19;i++)
        f[i] = f_c[   f_mem(i ,xm,ym,0 ,pitch_c,zInner_c)];
    Moments(f,m[4]);
    StrainRate(u_x5,v_y5,w_z5,Sxy5,Syz5,Sxz5,omega_c,m[4]);
    for(int i=0;i<19;i++)
        f[i] = f_c[   f_mem(i ,xp,ym,0 ,pitch_c,zInner_c)];
    Moments(f,m[5]);
    StrainRate(u_x6,v_y6,w_z6,Sxy6,Syz6,Sxz6,omega_c,m[5]);
    for(int i=0;i<19;i++)
        f[i] = f_c[   f_mem(i ,xm,yp,0 ,pitch_c,zInner_c)];
    Moments(f,m[6]);
    StrainRate(u_x7,v_y7,w_z7,Sxy7,Syz7,Sxz7,omega_c,m[6]);
    for(int i=0;i<19;i++)
        f[i] = f_c[   f_mem(i ,xp,yp,0 ,pitch_c,zInner_c)];
    Moments(f,m[7]);
    StrainRate(u_x8,v_y8,w_z8,Sxy8,Syz8,Sxz8,omega_c,m[7]);

    float cx = -((u_x8-u_x7+u_x6-u_x5+u_x4-u_x3+u_x2-u_x1))*0.03125f;
    float cy = -((Sxy8+Sxy7-Sxy6-Sxy5+Sxy4+Sxy3-Sxy2-Sxy1)-m[7][5]+m[6][5]+m[5][5]-m[4][5]-m[3][5]+m[2][5]+m[1][5]-m[0][5])*0.0625f;
    float cz = -((Sxz8+Sxz7+Sxz6+Sxz5-Sxz4-Sxz3-Sxz2-Sxz1)-m[7][7]+m[6][7]-m[5][7]+m[4][7]+m[3][7]-m[2][7]+m[1][7]-m[0][7])*0.0625f;
    float dx = -((Sxy8-Sxy7+Sxy6-Sxy5+Sxy4-Sxy3+Sxy2-Sxy1)-m[7][3]+m[6][3]+m[5][3]-m[4][3]-m[3][3]+m[2][3]+m[1][3]-m[0][3])*0.0625f;
    float dy = -((v_y8+v_y7-v_y6-v_y5+v_y4+v_y3-v_y2-v_y1))*0.03125f;
    float dz = -((Syz8+Syz7+Syz6+Syz5-Syz4-Syz3-Syz2-Syz1)-m[7][7]-m[6][7]+m[5][7]+m[4][7]+m[3][7]+m[2][7]-m[1][7]-m[0][7])*0.0625f;
    float ex = -((Sxz8-Sxz7+Sxz6-Sxz5+Sxz4-Sxz3+Sxz2-Sxz1)-m[7][3]+m[6][3]-m[5][3]+m[4][3]+m[3][3]-m[2][3]+m[1][3]-m[0][3])*0.0625f;
    float ey = -((Syz8+Syz7-Syz6-Syz5+Syz4+Syz3-Syz2-Syz1)-m[7][5]-m[6][5]+m[5][5]+m[4][5]+m[3][5]+m[2][5]-m[1][5]-m[0][5])*0.0625f;
    float ez = -((w_z8+w_z7+w_z6+w_z5-w_z4-w_z3-w_z2-w_z1))*0.03125f;

    for(int i = 0; i<19; i++)
        m[0][i] = trilinear_interp(m[0][i],m[1][i],m[2][i],m[3][i],m[4][i],m[5][i],m[6][i],m[7][i], xf, yf, zf);
    float xpr = 4.f*xf*xf-4.f*xf+1.f;
    float ypr = 4.f*yf*yf-4.f*yf+1.f;
    float zpr = 4.f*zf*zf-4.f*zf+1.f;
    m[0][3] += cx*(1.f-xpr)+cy*(1.f-ypr)+cz*(1.f-zpr);
    m[0][5] += dx*(1.f-xpr)+dy*(1.f-ypr)+dz*(1.f-zpr);
    m[0][7] += ex*(1.f-xpr)+ey*(1.f-ypr)+ez*(1.f-zpr);
    InvertMoments(f,m[0]);
    }//end zcoord<0
    else if(zcoord>(zInner_c+2)-2)
    {
    int xm = int(xcoord);
    int ym = int(ycoord);
    int zm = int(zcoord);
    int xp = xm+1;
    int yp = ym+1;
    float xf = xcoord-xm;
    float yf = ycoord-ym;
    float zf = zcoord-zm;
//    for(int i=0;i<19;i++){
//        float v000 = f_c[   f_mem(i ,xm,ym,zInner_c-1,pitch_c,zInner_c)];
//        float v001 = f_c[   f_mem(i ,xp,ym,zInner_c-1,pitch_c,zInner_c)];
//        float v010 = f_c[   f_mem(i ,xm,yp,zInner_c-1,pitch_c,zInner_c)];
//        float v011 = f_c[   f_mem(i ,xp,yp,zInner_c-1,pitch_c,zInner_c)];
//        float v100 = h_c[buff_mem(i ,xm,ym   ,pitch_c)];
//        float v101 = h_c[buff_mem(i ,xp,ym   ,pitch_c)];
//        float v110 = h_c[buff_mem(i ,xm,yp   ,pitch_c)];
//        float v111 = h_c[buff_mem(i ,xp,yp   ,pitch_c)];
//        f[i] = trilinear_interp(v000, v001, v010, v011, v100, v101, v110, v111, xf, yf, zf);
//    }

    float u_x1,u_x2,u_x3,u_x4,u_x5,u_x6,u_x7,u_x8;
    float v_y1,v_y2,v_y3,v_y4,v_y5,v_y6,v_y7,v_y8;
    float w_z1,w_z2,w_z3,w_z4,w_z5,w_z6,w_z7,w_z8;
    float Sxy1,Sxy2,Sxy3,Sxy4,Sxy5,Sxy6,Sxy7,Sxy8;
    float Syz1,Syz2,Syz3,Syz4,Syz5,Syz6,Syz7,Syz8;
    float Sxz1,Sxz2,Sxz3,Sxz4,Sxz5,Sxz6,Sxz7,Sxz8;
    float m[8][19];
    for(int i=0;i<19;i++)
        f[i] = f_c[   f_mem(i ,xm,ym,zInner_c-1,pitch_c,zInner_c)];
    Moments(f,m[0]);
    StrainRate(u_x1,v_y1,w_z1,Sxy1,Syz1,Sxz1,omega_c,m[0]);
    for(int i=0;i<19;i++)
        f[i] = f_c[   f_mem(i ,xp,ym,zInner_c-1,pitch_c,zInner_c)];
    Moments(f,m[1]);
    StrainRate(u_x2,v_y2,w_z2,Sxy2,Syz2,Sxz2,omega_c,m[1]);
    for(int i=0;i<19;i++)
        f[i] = f_c[   f_mem(i ,xm,yp,zInner_c-1,pitch_c,zInner_c)];
    Moments(f,m[2]);
    StrainRate(u_x3,v_y3,w_z3,Sxy3,Syz3,Sxz3,omega_c,m[2]);
    for(int i=0;i<19;i++)
        f[i] = f_c[   f_mem(i ,xp,yp,zInner_c-1,pitch_c,zInner_c)];
    Moments(f,m[3]);
    StrainRate(u_x4,v_y4,w_z4,Sxy4,Syz4,Sxz4,omega_c,m[3]);
    for(int i=0;i<19;i++)
        f[i] = h_c[buff_mem(i ,xm,ym   ,pitch_c)];
    Moments(f,m[4]);
    StrainRate(u_x5,v_y5,w_z5,Sxy5,Syz5,Sxz5,omega_c,m[4]);
    for(int i=0;i<19;i++)
        f[i] = h_c[buff_mem(i ,xp,ym   ,pitch_c)];
    Moments(f,m[5]);
    StrainRate(u_x6,v_y6,w_z6,Sxy6,Syz6,Sxz6,omega_c,m[5]);
    for(int i=0;i<19;i++)
        f[i] = h_c[buff_mem(i ,xm,yp   ,pitch_c)];
    Moments(f,m[6]);
    StrainRate(u_x7,v_y7,w_z7,Sxy7,Syz7,Sxz7,omega_c,m[6]);
    for(int i=0;i<19;i++)
        f[i] = h_c[buff_mem(i ,xp,yp   ,pitch_c)];
    Moments(f,m[7]);
    StrainRate(u_x8,v_y8,w_z8,Sxy8,Syz8,Sxz8,omega_c,m[7]);

    float cx = -((u_x8-u_x7+u_x6-u_x5+u_x4-u_x3+u_x2-u_x1))*0.03125f;
    float cy = -((Sxy8+Sxy7-Sxy6-Sxy5+Sxy4+Sxy3-Sxy2-Sxy1)-m[7][5]+m[6][5]+m[5][5]-m[4][5]-m[3][5]+m[2][5]+m[1][5]-m[0][5])*0.0625f;
    float cz = -((Sxz8+Sxz7+Sxz6+Sxz5-Sxz4-Sxz3-Sxz2-Sxz1)-m[7][7]+m[6][7]-m[5][7]+m[4][7]+m[3][7]-m[2][7]+m[1][7]-m[0][7])*0.0625f;
    float dx = -((Sxy8-Sxy7+Sxy6-Sxy5+Sxy4-Sxy3+Sxy2-Sxy1)-m[7][3]+m[6][3]+m[5][3]-m[4][3]-m[3][3]+m[2][3]+m[1][3]-m[0][3])*0.0625f;
    float dy = -((v_y8+v_y7-v_y6-v_y5+v_y4+v_y3-v_y2-v_y1))*0.03125f;
    float dz = -((Syz8+Syz7+Syz6+Syz5-Syz4-Syz3-Syz2-Syz1)-m[7][7]-m[6][7]+m[5][7]+m[4][7]+m[3][7]+m[2][7]-m[1][7]-m[0][7])*0.0625f;
    float ex = -((Sxz8-Sxz7+Sxz6-Sxz5+Sxz4-Sxz3+Sxz2-Sxz1)-m[7][3]+m[6][3]-m[5][3]+m[4][3]+m[3][3]-m[2][3]+m[1][3]-m[0][3])*0.0625f;
    float ey = -((Syz8+Syz7-Syz6-Syz5+Syz4+Syz3-Syz2-Syz1)-m[7][5]-m[6][5]+m[5][5]+m[4][5]+m[3][5]+m[2][5]-m[1][5]-m[0][5])*0.0625f;
    float ez = -((w_z8+w_z7+w_z6+w_z5-w_z4-w_z3-w_z2-w_z1))*0.03125f;

    for(int i = 0; i<19; i++)
        m[0][i] = trilinear_interp(m[0][i],m[1][i],m[2][i],m[3][i],m[4][i],m[5][i],m[6][i],m[7][i], xf, yf, zf);
    float xpr = 4.f*xf*xf-4.f*xf+1.f;
    float ypr = 4.f*yf*yf-4.f*yf+1.f;
    float zpr = 4.f*zf*zf-4.f*zf+1.f;
    m[0][3] += cx*(1.f-xpr)+cy*(1.f-ypr)+cz*(1.f-zpr);
    m[0][5] += dx*(1.f-xpr)+dy*(1.f-ypr)+dz*(1.f-zpr);
    m[0][7] += ex*(1.f-xpr)+ey*(1.f-ypr)+ez*(1.f-zpr);
    InvertMoments(f,m[0]);




    }//end zcoord>ZDIM
    else{
    int xm = int(xcoord);
    int ym = int(ycoord);
    int zm = int(zcoord);
    int xp = xm+1;
    int yp = ym+1;
    int zp = zm+1;
    float xf = xcoord-xm;
    float yf = ycoord-ym;
    float zf = zcoord-zm;
//    for(int i=0;i<19;i++){
//        float v000 = f_c[f_mem(i ,xm,ym,zm-1,pitch_c,zInner_c)];//-1 to correct for index in f
//        float v001 = f_c[f_mem(i ,xp,ym,zm-1,pitch_c,zInner_c)];
//        float v010 = f_c[f_mem(i ,xm,yp,zm-1,pitch_c,zInner_c)];
//        float v011 = f_c[f_mem(i ,xp,yp,zm-1,pitch_c,zInner_c)];
//        float v100 = f_c[f_mem(i ,xm,ym,zp-1,pitch_c,zInner_c)];
//        float v101 = f_c[f_mem(i ,xp,ym,zp-1,pitch_c,zInner_c)];
//        float v110 = f_c[f_mem(i ,xm,yp,zp-1,pitch_c,zInner_c)];
//        float v111 = f_c[f_mem(i ,xp,yp,zp-1,pitch_c,zInner_c)];
//        f[i] = trilinear_interp(v000, v001, v010, v011, v100, v101, v110, v111, xf, yf, zf);
//    }

    float u_x1,u_x2,u_x3,u_x4,u_x5,u_x6,u_x7,u_x8;
    float v_y1,v_y2,v_y3,v_y4,v_y5,v_y6,v_y7,v_y8;
    float w_z1,w_z2,w_z3,w_z4,w_z5,w_z6,w_z7,w_z8;
    float Sxy1,Sxy2,Sxy3,Sxy4,Sxy5,Sxy6,Sxy7,Sxy8;
    float Syz1,Syz2,Syz3,Syz4,Syz5,Syz6,Syz7,Syz8;
    float Sxz1,Sxz2,Sxz3,Sxz4,Sxz5,Sxz6,Sxz7,Sxz8;
    float m[8][19];
    for(int i=0;i<19;i++)
        f[i] = f_c[f_mem(i ,xm,ym,zm-1,pitch_c,zInner_c)];
    Moments(f,m[0]);
    StrainRate(u_x1,v_y1,w_z1,Sxy1,Syz1,Sxz1,omega_c,m[0]);
    for(int i=0;i<19;i++)
        f[i] = f_c[f_mem(i ,xp,ym,zm-1,pitch_c,zInner_c)];
    Moments(f,m[1]);
    StrainRate(u_x2,v_y2,w_z2,Sxy2,Syz2,Sxz2,omega_c,m[1]);
    for(int i=0;i<19;i++)
        f[i] = f_c[f_mem(i ,xm,yp,zm-1,pitch_c,zInner_c)];
    Moments(f,m[2]);
    StrainRate(u_x3,v_y3,w_z3,Sxy3,Syz3,Sxz3,omega_c,m[2]);
    for(int i=0;i<19;i++)
        f[i] = f_c[f_mem(i ,xp,yp,zm-1,pitch_c,zInner_c)];
    Moments(f,m[3]);
    StrainRate(u_x4,v_y4,w_z4,Sxy4,Syz4,Sxz4,omega_c,m[3]);
    for(int i=0;i<19;i++)
        f[i] = f_c[f_mem(i ,xm,ym,zp-1,pitch_c,zInner_c)];
    Moments(f,m[4]);
    StrainRate(u_x5,v_y5,w_z5,Sxy5,Syz5,Sxz5,omega_c,m[4]);
    for(int i=0;i<19;i++)
        f[i] = f_c[f_mem(i ,xp,ym,zp-1,pitch_c,zInner_c)];
    Moments(f,m[5]);
    StrainRate(u_x6,v_y6,w_z6,Sxy6,Syz6,Sxz6,omega_c,m[5]);
    for(int i=0;i<19;i++)
        f[i] = f_c[f_mem(i ,xm,yp,zp-1,pitch_c,zInner_c)];
    Moments(f,m[6]);
    StrainRate(u_x7,v_y7,w_z7,Sxy7,Syz7,Sxz7,omega_c,m[6]);
    for(int i=0;i<19;i++)
        f[i] = f_c[f_mem(i ,xp,yp,zp-1,pitch_c,zInner_c)];
    Moments(f,m[7]);
    StrainRate(u_x8,v_y8,w_z8,Sxy8,Syz8,Sxz8,omega_c,m[7]);

    float cx = -((u_x8-u_x7+u_x6-u_x5+u_x4-u_x3+u_x2-u_x1))*0.03125f;
    float cy = -((Sxy8+Sxy7-Sxy6-Sxy5+Sxy4+Sxy3-Sxy2-Sxy1)-m[7][5]+m[6][5]+m[5][5]-m[4][5]-m[3][5]+m[2][5]+m[1][5]-m[0][5])*0.0625f;
    float cz = -((Sxz8+Sxz7+Sxz6+Sxz5-Sxz4-Sxz3-Sxz2-Sxz1)-m[7][7]+m[6][7]-m[5][7]+m[4][7]+m[3][7]-m[2][7]+m[1][7]-m[0][7])*0.0625f;
    float dx = -((Sxy8-Sxy7+Sxy6-Sxy5+Sxy4-Sxy3+Sxy2-Sxy1)-m[7][3]+m[6][3]+m[5][3]-m[4][3]-m[3][3]+m[2][3]+m[1][3]-m[0][3])*0.0625f;
    float dy = -((v_y8+v_y7-v_y6-v_y5+v_y4+v_y3-v_y2-v_y1))*0.03125f;
    float dz = -((Syz8+Syz7+Syz6+Syz5-Syz4-Syz3-Syz2-Syz1)-m[7][7]-m[6][7]+m[5][7]+m[4][7]+m[3][7]+m[2][7]-m[1][7]-m[0][7])*0.0625f;
    float ex = -((Sxz8-Sxz7+Sxz6-Sxz5+Sxz4-Sxz3+Sxz2-Sxz1)-m[7][3]+m[6][3]-m[5][3]+m[4][3]+m[3][3]-m[2][3]+m[1][3]-m[0][3])*0.0625f;
    float ey = -((Syz8+Syz7-Syz6-Syz5+Syz4+Syz3-Syz2-Syz1)-m[7][5]-m[6][5]+m[5][5]+m[4][5]+m[3][5]+m[2][5]-m[1][5]-m[0][5])*0.0625f;
    float ez = -((w_z8+w_z7+w_z6+w_z5-w_z4-w_z3-w_z2-w_z1))*0.03125f;

    for(int i = 0; i<19; i++)
        m[0][i] = trilinear_interp(m[0][i],m[1][i],m[2][i],m[3][i],m[4][i],m[5][i],m[6][i],m[7][i], xf, yf, zf);
    float xpr = 4.f*xf*xf-4.f*xf+1.f;
    float ypr = 4.f*yf*yf-4.f*yf+1.f;
    float zpr = 4.f*zf*zf-4.f*zf+1.f;
    m[0][3] += cx*(1.f-xpr)+cy*(1.f-ypr)+cz*(1.f-zpr);
    m[0][5] += dx*(1.f-xpr)+dy*(1.f-ypr)+dz*(1.f-zpr);
    m[0][7] += ex*(1.f-xpr)+ey*(1.f-ypr)+ez*(1.f-zpr);
    InvertMoments(f,m[0]);



    }
	if(MODEL == "MRT")
	mrt_scale_cf(f[0],f[1],f[2],f[3],f[4],f[5],f[6],f[7],f[8],f[9],f[10],f[11],f[12],f[13],f[14],f[15],f[16],f[17],f[18],SF);
    else if(MODEL == "BGK")
	bgk_scale_cf(f[0],f[1],f[2],f[3],f[4],f[5],f[6],f[7],f[8],f[9],f[10],f[11],f[12],f[13],f[14],f[15],f[16],f[17],f[18],SF);

	fB[f_memLR(0 ,x,y,z,pitch,zInner)] = f[0 ];
	fB[f_memLR(1 ,x,y,z,pitch,zInner)] = f[1 ];
	fB[f_memLR(2 ,x,y,z,pitch,zInner)] = f[2 ];
	fB[f_memLR(3 ,x,y,z,pitch,zInner)] = f[3 ];
	fB[f_memLR(4 ,x,y,z,pitch,zInner)] = f[4 ];
	fB[f_memLR(5 ,x,y,z,pitch,zInner)] = f[5 ];
	fB[f_memLR(6 ,x,y,z,pitch,zInner)] = f[6 ];
	fB[f_memLR(7 ,x,y,z,pitch,zInner)] = f[7 ];
	fB[f_memLR(8 ,x,y,z,pitch,zInner)] = f[8 ];
	fB[f_memLR(9 ,x,y,z,pitch,zInner)] = f[9 ];
	fB[f_memLR(10,x,y,z,pitch,zInner)] = f[10];
	fB[f_memLR(11,x,y,z,pitch,zInner)] = f[11];
	fB[f_memLR(12,x,y,z,pitch,zInner)] = f[12];
	fB[f_memLR(13,x,y,z,pitch,zInner)] = f[13];
	fB[f_memLR(14,x,y,z,pitch,zInner)] = f[14];
	fB[f_memLR(15,x,y,z,pitch,zInner)] = f[15];
	fB[f_memLR(16,x,y,z,pitch,zInner)] = f[16];
	fB[f_memLR(17,x,y,z,pitch,zInner)] = f[17];
	fB[f_memLR(18,x,y,z,pitch,zInner)] = f[18];

    }
    else
    {
	float f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18;

    f0 = fA[j];
	f1 = fA[f_memLR   (1 ,x-1,y  ,z  ,pitch, zInner)];
	f3 = fA[f_memLR   (3 ,x+1,y  ,z  ,pitch, zInner)];
	f2 = fA[f_memLR   (2 ,x  ,y-1,z  ,pitch, zInner)];
	f5 = fA[f_memLR   (5 ,x-1,y-1,z  ,pitch, zInner)];
	f6 = fA[f_memLR   (6 ,x+1,y-1,z  ,pitch, zInner)];
	f4 = fA[f_memLR   (4 ,x  ,y+1,z  ,pitch, zInner)];
	f7 = fA[f_memLR   (7 ,x+1,y+1,z  ,pitch, zInner)];
	f8 = fA[f_memLR   (8 ,x-1,y+1,z  ,pitch, zInner)];

    if(z==zInner-1){//top nodes need info from h
	f9 = fA[f_memLR   (9 ,x  ,y  ,z-1,pitch, zInner)];
	f10= fA[f_memLR   (10,x-1,y  ,z-1,pitch, zInner)];
	f11= fA[f_memLR   (11,x  ,y-1,z-1,pitch, zInner)];
	f12= fA[f_memLR   (12,x+1,y  ,z-1,pitch, zInner)];
	f13= fA[f_memLR   (13,x  ,y+1,z-1,pitch, zInner)];
	f14= h [buff_memLR(14,x  ,y  ,pitch)];
	f15= h [buff_memLR(15,x-1,y  ,pitch)];
	f16= h [buff_memLR(16,x  ,y-1,pitch)];
	f17= h [buff_memLR(17,x+1,y  ,pitch)];
	f18= h [buff_memLR(18,x  ,y+1,pitch)];
    }
    else if(z==0){//bottom nodes need info from g
	f9 = g [buff_memLR(9 ,x  ,y  ,pitch)];
	f10= g [buff_memLR(10,x-1,y  ,pitch)];
	f11= g [buff_memLR(11,x  ,y-1,pitch)];
	f12= g [buff_memLR(12,x+1,y  ,pitch)];
	f13= g [buff_memLR(13,x  ,y+1,pitch)];
	f14= fA[f_memLR   (14,x  ,y  ,z+1,pitch, zInner)];
	f15= fA[f_memLR   (15,x-1,y  ,z+1,pitch, zInner)];
	f16= fA[f_memLR   (16,x  ,y-1,z+1,pitch, zInner)];
	f17= fA[f_memLR   (17,x+1,y  ,z+1,pitch, zInner)];
	f18= fA[f_memLR   (18,x  ,y+1,z+1,pitch, zInner)];
    }
    else{//normal nodes
	f9 = fA[f_memLR(9 ,x  ,y  ,z-1,pitch,zInner)];//
	f10= fA[f_memLR(10,x-1,y  ,z-1,pitch,zInner)];//
	f11= fA[f_memLR(11,x  ,y-1,z-1,pitch,zInner)];//
	f12= fA[f_memLR(12,x+1,y  ,z-1,pitch,zInner)];//
	f13= fA[f_memLR(13,x  ,y+1,z-1,pitch,zInner)];//
	f14= fA[f_memLR(14,x  ,y  ,z+1,pitch,zInner)];//
	f15= fA[f_memLR(15,x-1,y  ,z+1,pitch,zInner)];//
	f16= fA[f_memLR(16,x  ,y-1,z+1,pitch,zInner)];//
	f17= fA[f_memLR(17,x+1,y  ,z+1,pitch,zInner)];//
	f18= fA[f_memLR(18,x  ,y+1,z+1,pitch,zInner)];//

    }//end normal nodes

	if(im == 1 || im ==10){//BB
		fB[f_memLR(1 ,x,y,z,pitch,zInner)] = f3 ;
		fB[f_memLR(2 ,x,y,z,pitch,zInner)] = f4 ;
		fB[f_memLR(3 ,x,y,z,pitch,zInner)] = f1 ;
		fB[f_memLR(4 ,x,y,z,pitch,zInner)] = f2 ;
		fB[f_memLR(5 ,x,y,z,pitch,zInner)] = f7 ;
		fB[f_memLR(6 ,x,y,z,pitch,zInner)] = f8 ;
		fB[f_memLR(7 ,x,y,z,pitch,zInner)] = f5 ;
		fB[f_memLR(8 ,x,y,z,pitch,zInner)] = f6 ;
		fB[f_memLR(9 ,x,y,z,pitch,zInner)] = f14;
		fB[f_memLR(10,x,y,z,pitch,zInner)] = f17;
		fB[f_memLR(11,x,y,z,pitch,zInner)] = f18;
		fB[f_memLR(12,x,y,z,pitch,zInner)] = f15;
		fB[f_memLR(13,x,y,z,pitch,zInner)] = f16;
		fB[f_memLR(14,x,y,z,pitch,zInner)] = f9 ;
		fB[f_memLR(15,x,y,z,pitch,zInner)] = f12;
		fB[f_memLR(16,x,y,z,pitch,zInner)] = f13;
		fB[f_memLR(17,x,y,z,pitch,zInner)] = f10;
		fB[f_memLR(18,x,y,z,pitch,zInner)] = f11;
	}
	else{
		if(MODEL == "MRT")
		mrt_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,omega);
		else if(MODEL == "BGK")
		bgk_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,omega);

        if(VELAV == 1){
            if(t>=START_VELAV && t<START_VELFLUC){
                float u_Av = uAv[x+y*pitch+(z+1)*pitch*YLRDIM];
                float v_Av = vAv[x+y*pitch+(z+1)*pitch*YLRDIM];
        		vel_avLR(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,u_Av,v_Av,t);
                uAv[x+y*pitch+(z+1)*pitch*YLRDIM] = u_Av;
                vAv[x+y*pitch+(z+1)*pitch*YLRDIM] = v_Av;
            }
            else if(t>=START_VELFLUC){
                float u_Av = uAv[x+y*pitch+(z+1)*pitch*YLRDIM];
                float v_Av = vAv[x+y*pitch+(z+1)*pitch*YLRDIM];
                float u_fluc = ufluc[x+y*pitch+(z+1)*pitch*YLRDIM];
                float v_fluc = vfluc[x+y*pitch+(z+1)*pitch*YLRDIM];
        		vel_flucLR(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,u_Av,v_Av,u_fluc,v_fluc,t);
                ufluc[x+y*pitch+(z+1)*pitch*YLRDIM] = u_fluc;
                vfluc[x+y*pitch+(z+1)*pitch*YLRDIM] = v_fluc;
            }
        }

		fB[f_memLR(0 ,x,y,z,pitch,zInner)] = f0 ;
		fB[f_memLR(1 ,x,y,z,pitch,zInner)] = f1 ;
		fB[f_memLR(2 ,x,y,z,pitch,zInner)] = f2 ;
		fB[f_memLR(3 ,x,y,z,pitch,zInner)] = f3 ;
		fB[f_memLR(4 ,x,y,z,pitch,zInner)] = f4 ;
		fB[f_memLR(5 ,x,y,z,pitch,zInner)] = f5 ;
		fB[f_memLR(6 ,x,y,z,pitch,zInner)] = f6 ;
		fB[f_memLR(7 ,x,y,z,pitch,zInner)] = f7 ;
		fB[f_memLR(8 ,x,y,z,pitch,zInner)] = f8 ;
		fB[f_memLR(9 ,x,y,z,pitch,zInner)] = f9 ;
		fB[f_memLR(10,x,y,z,pitch,zInner)] = f10;
		fB[f_memLR(11,x,y,z,pitch,zInner)] = f11;
		fB[f_memLR(12,x,y,z,pitch,zInner)] = f12;
		fB[f_memLR(13,x,y,z,pitch,zInner)] = f13;
		fB[f_memLR(14,x,y,z,pitch,zInner)] = f14;
		fB[f_memLR(15,x,y,z,pitch,zInner)] = f15;
		fB[f_memLR(16,x,y,z,pitch,zInner)] = f16;
		fB[f_memLR(17,x,y,z,pitch,zInner)] = f17;
		fB[f_memLR(18,x,y,z,pitch,zInner)] = f18;
	}
	}//end else (no interp)
}

__global__ void update_bottom_LR_interp(float* gA, float* gB, float* f, float* temp, float* g_c, float* temp_c,
							float omega, float omega_c,size_t pitch, int zInner, size_t pitch_c, int zInner_c, float SF, int GPU)//pitch in elements
{
	int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
	int y = threadIdx.y+blockIdx.y*blockDim.y;
    //int z = (zInner+2)-1;
	int j = x+y*pitch;//index on padded mem (pitch in elements)
	float f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18;
    float xcoord = LRX0+x*LRFACTOR;
	float ycoord = LRY0+y*LRFACTOR;
	float zcoord = LRZ0;
	int im = ImageFcn(xcoord,ycoord,zcoord+GPU*LRFACTOR*ZLRDIM);

	if(x < LRLEVEL || x > XLRDIM-1-LRLEVEL || y < LRLEVEL || y > YLRDIM-1-LRLEVEL)
    {
    float f[19];

    if(zcoord<0)
    {
    int xm = int(xcoord);
    int ym = int(ycoord);
    int zm = int(zcoord)-1;//for zcoord<0
    int xp = xm+1;
    int yp = ym+1;
    //int zp = zm+1;
    float xf = xcoord-xm;
    float yf = ycoord-ym;
    float zf = zcoord-zm;
//    for(int i=0;i<19;i++){
//        float v000 = temp_c[buff_mem(i ,xm,ym   ,pitch_c)];
//        float v001 = temp_c[buff_mem(i ,xp,ym   ,pitch_c)];
//        float v010 = temp_c[buff_mem(i ,xm,yp   ,pitch_c)];
//        float v011 = temp_c[buff_mem(i ,xp,yp   ,pitch_c)];
//        float v100 = g_c[buff_mem(i ,xm,ym,pitch_c)];
//        float v101 = g_c[buff_mem(i ,xp,ym,pitch_c)];
//        float v110 = g_c[buff_mem(i ,xm,yp,pitch_c)];
//        float v111 = g_c[buff_mem(i ,xp,yp,pitch_c)];
//        f[i] = trilinear_interp(v000, v001, v010, v011, v100, v101, v110, v111, xf, yf, zf);
//    }

    float u_x1,u_x2,u_x3,u_x4,u_x5,u_x6,u_x7,u_x8;
    float v_y1,v_y2,v_y3,v_y4,v_y5,v_y6,v_y7,v_y8;
    float w_z1,w_z2,w_z3,w_z4,w_z5,w_z6,w_z7,w_z8;
    float Sxy1,Sxy2,Sxy3,Sxy4,Sxy5,Sxy6,Sxy7,Sxy8;
    float Syz1,Syz2,Syz3,Syz4,Syz5,Syz6,Syz7,Syz8;
    float Sxz1,Sxz2,Sxz3,Sxz4,Sxz5,Sxz6,Sxz7,Sxz8;
    float m[8][19];
    for(int i=0;i<19;i++)
        f[i] = temp_c[buff_mem(i ,xm,ym   ,pitch_c)];
    Moments(f,m[0]);
    StrainRate(u_x1,v_y1,w_z1,Sxy1,Syz1,Sxz1,omega_c,m[0]);
    for(int i=0;i<19;i++)
        f[i] = temp_c[buff_mem(i ,xp,ym   ,pitch_c)];
    Moments(f,m[1]);
    StrainRate(u_x2,v_y2,w_z2,Sxy2,Syz2,Sxz2,omega_c,m[1]);
    for(int i=0;i<19;i++)
        f[i] = temp_c[buff_mem(i ,xm,yp   ,pitch_c)];
    Moments(f,m[2]);
    StrainRate(u_x3,v_y3,w_z3,Sxy3,Syz3,Sxz3,omega_c,m[2]);
    for(int i=0;i<19;i++)
        f[i] = temp_c[buff_mem(i ,xp,yp   ,pitch_c)];
    Moments(f,m[3]);
    StrainRate(u_x4,v_y4,w_z4,Sxy4,Syz4,Sxz4,omega_c,m[3]);
    for(int i=0;i<19;i++)
        f[i] = g_c[buff_mem(i ,xm,ym,pitch_c)];
    Moments(f,m[4]);
    StrainRate(u_x5,v_y5,w_z5,Sxy5,Syz5,Sxz5,omega_c,m[4]);
    for(int i=0;i<19;i++)
        f[i] = g_c[buff_mem(i ,xp,ym,pitch_c)];
    Moments(f,m[5]);
    StrainRate(u_x6,v_y6,w_z6,Sxy6,Syz6,Sxz6,omega_c,m[5]);
    for(int i=0;i<19;i++)
        f[i] = g_c[buff_mem(i ,xm,yp,pitch_c)];
    Moments(f,m[6]);
    StrainRate(u_x7,v_y7,w_z7,Sxy7,Syz7,Sxz7,omega_c,m[6]);
    for(int i=0;i<19;i++)
        f[i] = g_c[buff_mem(i ,xp,yp,pitch_c)];
    Moments(f,m[7]);
    StrainRate(u_x8,v_y8,w_z8,Sxy8,Syz8,Sxz8,omega_c,m[7]);

    float cx = -((u_x8-u_x7+u_x6-u_x5+u_x4-u_x3+u_x2-u_x1))*0.03125f;
    float cy = -((Sxy8+Sxy7-Sxy6-Sxy5+Sxy4+Sxy3-Sxy2-Sxy1)-m[7][5]+m[6][5]+m[5][5]-m[4][5]-m[3][5]+m[2][5]+m[1][5]-m[0][5])*0.0625f;
    float cz = -((Sxz8+Sxz7+Sxz6+Sxz5-Sxz4-Sxz3-Sxz2-Sxz1)-m[7][7]+m[6][7]-m[5][7]+m[4][7]+m[3][7]-m[2][7]+m[1][7]-m[0][7])*0.0625f;
    float dx = -((Sxy8-Sxy7+Sxy6-Sxy5+Sxy4-Sxy3+Sxy2-Sxy1)-m[7][3]+m[6][3]+m[5][3]-m[4][3]-m[3][3]+m[2][3]+m[1][3]-m[0][3])*0.0625f;
    float dy = -((v_y8+v_y7-v_y6-v_y5+v_y4+v_y3-v_y2-v_y1))*0.03125f;
    float dz = -((Syz8+Syz7+Syz6+Syz5-Syz4-Syz3-Syz2-Syz1)-m[7][7]-m[6][7]+m[5][7]+m[4][7]+m[3][7]+m[2][7]-m[1][7]-m[0][7])*0.0625f;
    float ex = -((Sxz8-Sxz7+Sxz6-Sxz5+Sxz4-Sxz3+Sxz2-Sxz1)-m[7][3]+m[6][3]-m[5][3]+m[4][3]+m[3][3]-m[2][3]+m[1][3]-m[0][3])*0.0625f;
    float ey = -((Syz8+Syz7-Syz6-Syz5+Syz4+Syz3-Syz2-Syz1)-m[7][5]-m[6][5]+m[5][5]+m[4][5]+m[3][5]+m[2][5]-m[1][5]-m[0][5])*0.0625f;
    float ez = -((w_z8+w_z7+w_z6+w_z5-w_z4-w_z3-w_z2-w_z1))*0.03125f;

    for(int i = 0; i<19; i++)
        m[0][i] = trilinear_interp(m[0][i],m[1][i],m[2][i],m[3][i],m[4][i],m[5][i],m[6][i],m[7][i], xf, yf, zf);
    float xpr = 4.f*xf*xf-4.f*xf+1.f;
    float ypr = 4.f*yf*yf-4.f*yf+1.f;
    float zpr = 4.f*zf*zf-4.f*zf+1.f;
    m[0][3] += cx*(1.f-xpr)+cy*(1.f-ypr)+cz*(1.f-zpr);
    m[0][5] += dx*(1.f-xpr)+dy*(1.f-ypr)+dz*(1.f-zpr);
    m[0][7] += ex*(1.f-xpr)+ey*(1.f-ypr)+ez*(1.f-zpr);
    InvertMoments(f,m[0]);





    }//end zcoord<0

	if(MODEL == "MRT")
	mrt_scale_cf(f[0],f[1],f[2],f[3],f[4],f[5],f[6],f[7],f[8],f[9],f[10],f[11],f[12],f[13],f[14],f[15],f[16],f[17],f[18],SF);
    else if(MODEL == "BGK")
	bgk_scale_cf(f[0],f[1],f[2],f[3],f[4],f[5],f[6],f[7],f[8],f[9],f[10],f[11],f[12],f[13],f[14],f[15],f[16],f[17],f[18],SF);

	gB[buff_memLR(0 ,x,y,pitch)] = f[0 ];
	gB[buff_memLR(1 ,x,y,pitch)] = f[1 ];
	gB[buff_memLR(2 ,x,y,pitch)] = f[2 ];
	gB[buff_memLR(3 ,x,y,pitch)] = f[3 ];
	gB[buff_memLR(4 ,x,y,pitch)] = f[4 ];
	gB[buff_memLR(5 ,x,y,pitch)] = f[5 ];
	gB[buff_memLR(6 ,x,y,pitch)] = f[6 ];
	gB[buff_memLR(7 ,x,y,pitch)] = f[7 ];
	gB[buff_memLR(8 ,x,y,pitch)] = f[8 ];
	gB[buff_memLR(9 ,x,y,pitch)] = f[9 ];
	gB[buff_memLR(10,x,y,pitch)] = f[10];
	gB[buff_memLR(11,x,y,pitch)] = f[11];
	gB[buff_memLR(12,x,y,pitch)] = f[12];
	gB[buff_memLR(13,x,y,pitch)] = f[13];
	gB[buff_memLR(14,x,y,pitch)] = f[14];
	gB[buff_memLR(15,x,y,pitch)] = f[15];
	gB[buff_memLR(16,x,y,pitch)] = f[16];
	gB[buff_memLR(17,x,y,pitch)] = f[17];
	gB[buff_memLR(18,x,y,pitch)] = f[18];

    }
    else
    {
	f0 = gA  [j];
	f1 = gA  [buff_memLR(1 ,x-1,y  ,pitch)];
	f3 = gA  [buff_memLR(3 ,x+1,y  ,pitch)];
	f2 = gA  [buff_memLR(2 ,x  ,y-1,pitch)];
	f5 = gA  [buff_memLR(5 ,x-1,y-1,pitch)];
	f6 = gA  [buff_memLR(6 ,x+1,y-1,pitch)];
	f4 = gA  [buff_memLR(4 ,x  ,y+1,pitch)];
	f7 = gA  [buff_memLR(7 ,x+1,y+1,pitch)];
	f8 = gA  [buff_memLR(8 ,x-1,y+1,pitch)];
	f9 = temp[buff_memLR(9 ,x  ,y  ,pitch)];
	f10= temp[buff_memLR(10,x-1,y  ,pitch)];
	f11= temp[buff_memLR(11,x  ,y-1,pitch)];
	f12= temp[buff_memLR(12,x+1,y  ,pitch)];
	f13= temp[buff_memLR(13,x  ,y+1,pitch)];
	f14= f   [f_memLR(14,x  ,y  ,0,pitch, zInner)];
	f15= f   [f_memLR(15,x-1,y  ,0,pitch, zInner)];
	f16= f   [f_memLR(16,x  ,y-1,0,pitch, zInner)];
	f17= f   [f_memLR(17,x+1,y  ,0,pitch, zInner)];
	f18= f   [f_memLR(18,x  ,y+1,0,pitch, zInner)];

	if(im == 1 || im ==10){//BB
		gB[buff_memLR(0 ,x,y,pitch)] = f0 ;
		gB[buff_memLR(1 ,x,y,pitch)] = f3 ;
		gB[buff_memLR(2 ,x,y,pitch)] = f4 ;
		gB[buff_memLR(3 ,x,y,pitch)] = f1 ;
		gB[buff_memLR(4 ,x,y,pitch)] = f2 ;
		gB[buff_memLR(5 ,x,y,pitch)] = f7 ;
		gB[buff_memLR(6 ,x,y,pitch)] = f8 ;
		gB[buff_memLR(7 ,x,y,pitch)] = f5 ;
		gB[buff_memLR(8 ,x,y,pitch)] = f6 ;
		gB[buff_memLR(9 ,x,y,pitch)] = f14;
		gB[buff_memLR(10,x,y,pitch)] = f17;
		gB[buff_memLR(11,x,y,pitch)] = f18;
		gB[buff_memLR(12,x,y,pitch)] = f15;
		gB[buff_memLR(13,x,y,pitch)] = f16;
		gB[buff_memLR(14,x,y,pitch)] = f9 ;
		gB[buff_memLR(15,x,y,pitch)] = f12;
		gB[buff_memLR(16,x,y,pitch)] = f13;
		gB[buff_memLR(17,x,y,pitch)] = f10;
		gB[buff_memLR(18,x,y,pitch)] = f11;
	}
	else{
		if(MODEL == "MRT")
		mrt_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,omega);
		else if(MODEL == "BGK")
		bgk_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,omega);

		gB[buff_memLR(0 ,x,y,pitch)] = f0 ;
		gB[buff_memLR(1 ,x,y,pitch)] = f1 ;
		gB[buff_memLR(2 ,x,y,pitch)] = f2 ;
		gB[buff_memLR(3 ,x,y,pitch)] = f3 ;
		gB[buff_memLR(4 ,x,y,pitch)] = f4 ;
		gB[buff_memLR(5 ,x,y,pitch)] = f5 ;
		gB[buff_memLR(6 ,x,y,pitch)] = f6 ;
		gB[buff_memLR(7 ,x,y,pitch)] = f7 ;
		gB[buff_memLR(8 ,x,y,pitch)] = f8 ;
		gB[buff_memLR(9 ,x,y,pitch)] = f9 ;
		gB[buff_memLR(10,x,y,pitch)] = f10;
		gB[buff_memLR(11,x,y,pitch)] = f11;
		gB[buff_memLR(12,x,y,pitch)] = f12;
		gB[buff_memLR(13,x,y,pitch)] = f13;
		gB[buff_memLR(14,x,y,pitch)] = f14;
		gB[buff_memLR(15,x,y,pitch)] = f15;
		gB[buff_memLR(16,x,y,pitch)] = f16;
		gB[buff_memLR(17,x,y,pitch)] = f17;
		gB[buff_memLR(18,x,y,pitch)] = f18;
	}
	}
}

__global__ void update_top_LR_interp(float* hA, float* hB, float* f, float* temp, float* h_c, float* temp_c,
							float omega, float omega_c, size_t pitch, int zInner, size_t pitch_c, int zInner_c, float SF, int GPU)//pitch in elements
{
	int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
	int y = threadIdx.y+blockIdx.y*blockDim.y;
    int z = (zInner+2)-1;//physical coord
	int j = x+y*pitch;//index on padded mem (pitch in elements)
	//int im = ImageFcn(x,y,(GPU+1)*(zInner+2)-1);
    float xcoord = LRX0+x*LRFACTOR;
	float ycoord = LRY0+y*LRFACTOR;
	float zcoord = LRZ0+z*LRFACTOR;
	int im = ImageFcn(xcoord,ycoord,GPU*LRFACTOR*(zInner+2)+zcoord);

	if(x < LRLEVEL || x > XLRDIM-1-LRLEVEL || y < LRLEVEL || y > YLRDIM-1-LRLEVEL)
    {
    float f[19];
    int xm = int(xcoord);
    int ym = int(ycoord);
    int zm = int(zcoord);
    int xp = xm+1;
    int yp = ym+1;
    float xf = xcoord-xm;
    float yf = ycoord-ym;
    float zf = zcoord-zm;
//    for(int i=0;i<19;i++){
//        float v000 = h_c[buff_mem(i ,xm,ym,pitch_c)];
//        float v001 = h_c[buff_mem(i ,xp,ym,pitch_c)];
//        float v010 = h_c[buff_mem(i ,xm,yp,pitch_c)];
//        float v011 = h_c[buff_mem(i ,xp,yp,pitch_c)];
//        float v100 = temp_c[buff_mem(i ,xm,ym   ,pitch_c)];
//        float v101 = temp_c[buff_mem(i ,xp,ym   ,pitch_c)];
//        float v110 = temp_c[buff_mem(i ,xm,yp   ,pitch_c)];
//        float v111 = temp_c[buff_mem(i ,xp,yp   ,pitch_c)];
//        f[i] = trilinear_interp(v000, v001, v010, v011, v100, v101, v110, v111, xf, yf, zf);
//    }

    float u_x1,u_x2,u_x3,u_x4,u_x5,u_x6,u_x7,u_x8;
    float v_y1,v_y2,v_y3,v_y4,v_y5,v_y6,v_y7,v_y8;
    float w_z1,w_z2,w_z3,w_z4,w_z5,w_z6,w_z7,w_z8;
    float Sxy1,Sxy2,Sxy3,Sxy4,Sxy5,Sxy6,Sxy7,Sxy8;
    float Syz1,Syz2,Syz3,Syz4,Syz5,Syz6,Syz7,Syz8;
    float Sxz1,Sxz2,Sxz3,Sxz4,Sxz5,Sxz6,Sxz7,Sxz8;
    float m[8][19];
    for(int i=0;i<19;i++)
        f[i] = h_c[buff_mem(i ,xm,ym,pitch_c)];
    Moments(f,m[0]);
    StrainRate(u_x1,v_y1,w_z1,Sxy1,Syz1,Sxz1,omega_c,m[0]);
    for(int i=0;i<19;i++)
        f[i] = h_c[buff_mem(i ,xp,ym,pitch_c)];
    Moments(f,m[1]);
    StrainRate(u_x2,v_y2,w_z2,Sxy2,Syz2,Sxz2,omega_c,m[1]);
    for(int i=0;i<19;i++)
        f[i] = h_c[buff_mem(i ,xm,yp,pitch_c)];
    Moments(f,m[2]);
    StrainRate(u_x3,v_y3,w_z3,Sxy3,Syz3,Sxz3,omega_c,m[2]);
    for(int i=0;i<19;i++)
        f[i] = h_c[buff_mem(i ,xp,yp,pitch_c)];
    Moments(f,m[3]);
    StrainRate(u_x4,v_y4,w_z4,Sxy4,Syz4,Sxz4,omega_c,m[3]);
    for(int i=0;i<19;i++)
        f[i] = temp_c[buff_mem(i ,xm,ym   ,pitch_c)];
    Moments(f,m[4]);
    StrainRate(u_x5,v_y5,w_z5,Sxy5,Syz5,Sxz5,omega_c,m[4]);
    for(int i=0;i<19;i++)
        f[i] = temp_c[buff_mem(i ,xp,ym   ,pitch_c)];
    Moments(f,m[5]);
    StrainRate(u_x6,v_y6,w_z6,Sxy6,Syz6,Sxz6,omega_c,m[5]);
    for(int i=0;i<19;i++)
        f[i] = temp_c[buff_mem(i ,xm,yp   ,pitch_c)];
    Moments(f,m[6]);
    StrainRate(u_x7,v_y7,w_z7,Sxy7,Syz7,Sxz7,omega_c,m[6]);
    for(int i=0;i<19;i++)
        f[i] = temp_c[buff_mem(i ,xp,yp   ,pitch_c)];
    Moments(f,m[7]);
    StrainRate(u_x8,v_y8,w_z8,Sxy8,Syz8,Sxz8,omega_c,m[7]);

    float cx = -((u_x8-u_x7+u_x6-u_x5+u_x4-u_x3+u_x2-u_x1))*0.03125f;
    float cy = -((Sxy8+Sxy7-Sxy6-Sxy5+Sxy4+Sxy3-Sxy2-Sxy1)-m[7][5]+m[6][5]+m[5][5]-m[4][5]-m[3][5]+m[2][5]+m[1][5]-m[0][5])*0.0625f;
    float cz = -((Sxz8+Sxz7+Sxz6+Sxz5-Sxz4-Sxz3-Sxz2-Sxz1)-m[7][7]+m[6][7]-m[5][7]+m[4][7]+m[3][7]-m[2][7]+m[1][7]-m[0][7])*0.0625f;
    float dx = -((Sxy8-Sxy7+Sxy6-Sxy5+Sxy4-Sxy3+Sxy2-Sxy1)-m[7][3]+m[6][3]+m[5][3]-m[4][3]-m[3][3]+m[2][3]+m[1][3]-m[0][3])*0.0625f;
    float dy = -((v_y8+v_y7-v_y6-v_y5+v_y4+v_y3-v_y2-v_y1))*0.03125f;
    float dz = -((Syz8+Syz7+Syz6+Syz5-Syz4-Syz3-Syz2-Syz1)-m[7][7]-m[6][7]+m[5][7]+m[4][7]+m[3][7]+m[2][7]-m[1][7]-m[0][7])*0.0625f;
    float ex = -((Sxz8-Sxz7+Sxz6-Sxz5+Sxz4-Sxz3+Sxz2-Sxz1)-m[7][3]+m[6][3]-m[5][3]+m[4][3]+m[3][3]-m[2][3]+m[1][3]-m[0][3])*0.0625f;
    float ey = -((Syz8+Syz7-Syz6-Syz5+Syz4+Syz3-Syz2-Syz1)-m[7][5]-m[6][5]+m[5][5]+m[4][5]+m[3][5]+m[2][5]-m[1][5]-m[0][5])*0.0625f;
    float ez = -((w_z8+w_z7+w_z6+w_z5-w_z4-w_z3-w_z2-w_z1))*0.03125f;

    for(int i = 0; i<19; i++)
        m[0][i] = trilinear_interp(m[0][i],m[1][i],m[2][i],m[3][i],m[4][i],m[5][i],m[6][i],m[7][i], xf, yf, zf);
    float xpr = 4.f*xf*xf-4.f*xf+1.f;
    float ypr = 4.f*yf*yf-4.f*yf+1.f;
    float zpr = 4.f*zf*zf-4.f*zf+1.f;
    m[0][3] += cx*(1.f-xpr)+cy*(1.f-ypr)+cz*(1.f-zpr);
    m[0][5] += dx*(1.f-xpr)+dy*(1.f-ypr)+dz*(1.f-zpr);
    m[0][7] += ex*(1.f-xpr)+ey*(1.f-ypr)+ez*(1.f-zpr);
    InvertMoments(f,m[0]);








//    }//end zcoord>ZDIM

	if(MODEL == "MRT")
	mrt_scale_cf(f[0],f[1],f[2],f[3],f[4],f[5],f[6],f[7],f[8],f[9],f[10],f[11],f[12],f[13],f[14],f[15],f[16],f[17],f[18],SF);
    else if(MODEL == "BGK")
	bgk_scale_cf(f[0],f[1],f[2],f[3],f[4],f[5],f[6],f[7],f[8],f[9],f[10],f[11],f[12],f[13],f[14],f[15],f[16],f[17],f[18],SF);

	hB[buff_memLR(0 ,x,y,pitch)] = f[0 ];
	hB[buff_memLR(1 ,x,y,pitch)] = f[1 ];
	hB[buff_memLR(2 ,x,y,pitch)] = f[2 ];
	hB[buff_memLR(3 ,x,y,pitch)] = f[3 ];
	hB[buff_memLR(4 ,x,y,pitch)] = f[4 ];
	hB[buff_memLR(5 ,x,y,pitch)] = f[5 ];
	hB[buff_memLR(6 ,x,y,pitch)] = f[6 ];
	hB[buff_memLR(7 ,x,y,pitch)] = f[7 ];
	hB[buff_memLR(8 ,x,y,pitch)] = f[8 ];
	hB[buff_memLR(9 ,x,y,pitch)] = f[9 ];
	hB[buff_memLR(10,x,y,pitch)] = f[10];
	hB[buff_memLR(11,x,y,pitch)] = f[11];
	hB[buff_memLR(12,x,y,pitch)] = f[12];
	hB[buff_memLR(13,x,y,pitch)] = f[13];
	hB[buff_memLR(14,x,y,pitch)] = f[14];
	hB[buff_memLR(15,x,y,pitch)] = f[15];
	hB[buff_memLR(16,x,y,pitch)] = f[16];
	hB[buff_memLR(17,x,y,pitch)] = f[17];
	hB[buff_memLR(18,x,y,pitch)] = f[18];

    }
    else{//not LR interp region
	float f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18;
	f0 = hA[j];
	f1 = hA  [buff_memLR(1 ,x-1,y  ,pitch)];
	f3 = hA  [buff_memLR(3 ,x+1,y  ,pitch)];
	f2 = hA  [buff_memLR(2 ,x  ,y-1,pitch)];
	f5 = hA  [buff_memLR(5 ,x-1,y-1,pitch)];
	f6 = hA  [buff_memLR(6 ,x+1,y-1,pitch)];
	f4 = hA  [buff_memLR(4 ,x  ,y+1,pitch)];
	f7 = hA  [buff_memLR(7 ,x+1,y+1,pitch)];
	f8 = hA  [buff_memLR(8 ,x-1,y+1,pitch)];
	f9 = f   [f_memLR(9 ,x  ,y  ,zInner-1,pitch, zInner)];
	f10= f   [f_memLR(10,x-1,y  ,zInner-1,pitch, zInner)];
	f11= f   [f_memLR(11,x  ,y-1,zInner-1,pitch, zInner)];
	f12= f   [f_memLR(12,x+1,y  ,zInner-1,pitch, zInner)];
	f13= f   [f_memLR(13,x  ,y+1,zInner-1,pitch, zInner)];
	f14= temp[buff_memLR(14,x  ,y  ,pitch)];
	f15= temp[buff_memLR(15,x-1,y  ,pitch)];
	f16= temp[buff_memLR(16,x  ,y-1,pitch)];
	f17= temp[buff_memLR(17,x+1,y  ,pitch)];
	f18= temp[buff_memLR(18,x  ,y+1,pitch)];

	if(im == 1 || im ==10){//BB
		hB[buff_memLR(0 ,x,y,pitch)] = f0 ;
		hB[buff_memLR(1 ,x,y,pitch)] = f3 ;
		hB[buff_memLR(2 ,x,y,pitch)] = f4 ;
		hB[buff_memLR(3 ,x,y,pitch)] = f1 ;
		hB[buff_memLR(4 ,x,y,pitch)] = f2 ;
		hB[buff_memLR(5 ,x,y,pitch)] = f7 ;
		hB[buff_memLR(6 ,x,y,pitch)] = f8 ;
		hB[buff_memLR(7 ,x,y,pitch)] = f5 ;
		hB[buff_memLR(8 ,x,y,pitch)] = f6 ;
		hB[buff_memLR(9 ,x,y,pitch)] = f14;
		hB[buff_memLR(10,x,y,pitch)] = f17;
		hB[buff_memLR(11,x,y,pitch)] = f18;
		hB[buff_memLR(12,x,y,pitch)] = f15;
		hB[buff_memLR(13,x,y,pitch)] = f16;
		hB[buff_memLR(14,x,y,pitch)] = f9 ;
		hB[buff_memLR(15,x,y,pitch)] = f12;
		hB[buff_memLR(16,x,y,pitch)] = f13;
		hB[buff_memLR(17,x,y,pitch)] = f10;
		hB[buff_memLR(18,x,y,pitch)] = f11;
	}
	else{
   		if(MODEL == "MRT")
		mrt_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,omega);
		else if(MODEL == "BGK")
		bgk_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,omega);

		hB[buff_memLR(0 ,x,y,pitch)] = f0 ;
		hB[buff_memLR(1 ,x,y,pitch)] = f1 ;
		hB[buff_memLR(2 ,x,y,pitch)] = f2 ;
		hB[buff_memLR(3 ,x,y,pitch)] = f3 ;
		hB[buff_memLR(4 ,x,y,pitch)] = f4 ;
		hB[buff_memLR(5 ,x,y,pitch)] = f5 ;
		hB[buff_memLR(6 ,x,y,pitch)] = f6 ;
		hB[buff_memLR(7 ,x,y,pitch)] = f7 ;
		hB[buff_memLR(8 ,x,y,pitch)] = f8 ;
		hB[buff_memLR(9 ,x,y,pitch)] = f9 ;
		hB[buff_memLR(10,x,y,pitch)] = f10;
		hB[buff_memLR(11,x,y,pitch)] = f11;
		hB[buff_memLR(12,x,y,pitch)] = f12;
		hB[buff_memLR(13,x,y,pitch)] = f13;
		hB[buff_memLR(14,x,y,pitch)] = f14;
		hB[buff_memLR(15,x,y,pitch)] = f15;
		hB[buff_memLR(16,x,y,pitch)] = f16;
		hB[buff_memLR(17,x,y,pitch)] = f17;
		hB[buff_memLR(18,x,y,pitch)] = f18;
	}
	}
}


__device__ __inline__ float ld_gb1_cg(const float *addr)
{
    float return_value;
    asm("ld.global.cg.f32 %0, [%1];" : "=f"(return_value) : "l"(addr));
    return return_value;
}

__global__ void initialize_single(float *f, size_t pitch, int yDim, int zDim, int GPU_N, int level)//pitch in elements
{
	int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
	int y = threadIdx.y+blockIdx.y*blockDim.y;
	int z = threadIdx.z+blockIdx.z*blockDim.z;
    float xcoord = x;
    float ycoord = y;
    float zcoord = z+1+GPU_N*ZDIM;
    if(level > 0){
        xcoord = LRX0+x*LRFACTOR;
        ycoord = LRY0+y*LRFACTOR;
        zcoord = LRZ0+z*LRFACTOR;
    }
	int j = x+y*pitch+z*yDim*pitch;//index on padded mem (pitch in elements)
	float f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18;
	
	int im = ImageFcn(xcoord,ycoord,zcoord);
	float u,v,w,rho,usqr;
	rho = 1.f;
	u = 0.01f;
	v = UMAX;
	w = 0.0;

    if(im == 10 || im == 1){
    u = 0.0f;
    v = 0.0f;
    w = 0.0f;
    }
	usqr = u*u+v*v+w*w;

    if(MODEL == "BGK"){ 
	f[j+0 *pitch*yDim*(zDim/GPU_N-2)]= 1.0f/3.0f*(rho-1.5f*usqr);
	f[j+1 *pitch*yDim*(zDim/GPU_N-2)]= 1.0f/18.0f*(rho+3.0f*u+4.5f*u*u-1.5f*usqr);
	f[j+2 *pitch*yDim*(zDim/GPU_N-2)]= 1.0f/18.0f*(rho+3.0f*v+4.5f*v*v-1.5f*usqr);
	f[j+3 *pitch*yDim*(zDim/GPU_N-2)]= 1.0f/18.0f*(rho-3.0f*u+4.5f*u*u-1.5f*usqr);
	f[j+4 *pitch*yDim*(zDim/GPU_N-2)]= 1.0f/18.0f*(rho-3.0f*v+4.5f*v*v-1.5f*usqr);
	f[j+5 *pitch*yDim*(zDim/GPU_N-2)]= 1.0f/36.0f*(rho+3.0f*(u+v)+4.5f*(u+v)*(u+v)-1.5f*usqr);
	f[j+6 *pitch*yDim*(zDim/GPU_N-2)]= 1.0f/36.0f*(rho+3.0f*(-u+v)+4.5f*(-u+v)*(-u+v)-1.5f*usqr);
	f[j+7 *pitch*yDim*(zDim/GPU_N-2)]= 1.0f/36.0f*(rho+3.0f*(-u-v)+4.5f*(-u-v)*(-u-v)-1.5f*usqr);
	f[j+8 *pitch*yDim*(zDim/GPU_N-2)]= 1.0f/36.0f*(rho+3.0f*(u-v)+4.5f*(u-v)*(u-v)-1.5f*usqr);
	f[j+9 *pitch*yDim*(zDim/GPU_N-2)]= 1.0f/18.0f*(rho+3.0f*w+4.5f*w*w-1.5f*usqr);
	f[j+10*pitch*yDim*(zDim/GPU_N-2)]= 1.0f/36.0f*(rho+3.0f*(u+w)+4.5f*(u+w)*(u+w)-1.5f*usqr);
	f[j+11*pitch*yDim*(zDim/GPU_N-2)]= 1.0f/36.0f*(rho+3.0f*(v+w)+4.5f*(v+w)*(v+w)-1.5f*usqr);
	f[j+12*pitch*yDim*(zDim/GPU_N-2)]= 1.0f/36.0f*(rho+3.0f*(-u+w)+4.5f*(-u+w)*(-u+w)-1.5f*usqr);
	f[j+13*pitch*yDim*(zDim/GPU_N-2)]= 1.0f/36.0f*(rho+3.0f*(-v+w)+4.5f*(-v+w)*(-v+w)-1.5f*usqr);
	f[j+14*pitch*yDim*(zDim/GPU_N-2)]= 1.0f/18.0f*(rho-3.0f*w+4.5f*w*w-1.5f*usqr);
	f[j+15*pitch*yDim*(zDim/GPU_N-2)]= 1.0f/36.0f*(rho+3.0f*(u-w)+4.5f*(u-w)*(u-w)-1.5f*usqr);
	f[j+16*pitch*yDim*(zDim/GPU_N-2)]= 1.0f/36.0f*(rho+3.0f*(v-w)+4.5f*(v-w)*(v-w)-1.5f*usqr);
	f[j+17*pitch*yDim*(zDim/GPU_N-2)]= 1.0f/36.0f*(rho+3.0f*(-u-w)+4.5f*(-u-w)*(-u-w)-1.5f*usqr);
	f[j+18*pitch*yDim*(zDim/GPU_N-2)]= 1.0f/36.0f*(rho+3.0f*(-v-w)+4.5f*(-v-w)*(-v-w)-1.5f*usqr);   
    }
    else{
    mrt_feq(rho,u,v,w,f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18);
                                                                                                                
    f[j+0 *pitch*yDim*(zDim/GPU_N-2)]=f0 ;
    f[j+1 *pitch*yDim*(zDim/GPU_N-2)]=f1 ;
    f[j+2 *pitch*yDim*(zDim/GPU_N-2)]=f2 ;
    f[j+3 *pitch*yDim*(zDim/GPU_N-2)]=f3 ;
    f[j+4 *pitch*yDim*(zDim/GPU_N-2)]=f4 ;
    f[j+5 *pitch*yDim*(zDim/GPU_N-2)]=f5 ;
    f[j+6 *pitch*yDim*(zDim/GPU_N-2)]=f6 ;
    f[j+7 *pitch*yDim*(zDim/GPU_N-2)]=f7 ;
    f[j+8 *pitch*yDim*(zDim/GPU_N-2)]=f8 ;
    f[j+9 *pitch*yDim*(zDim/GPU_N-2)]=f9 ;
    f[j+10*pitch*yDim*(zDim/GPU_N-2)]=f10;
    f[j+11*pitch*yDim*(zDim/GPU_N-2)]=f11;
    f[j+12*pitch*yDim*(zDim/GPU_N-2)]=f12;
    f[j+13*pitch*yDim*(zDim/GPU_N-2)]=f13;
    f[j+14*pitch*yDim*(zDim/GPU_N-2)]=f14;
    f[j+15*pitch*yDim*(zDim/GPU_N-2)]=f15;
    f[j+16*pitch*yDim*(zDim/GPU_N-2)]=f16;
    f[j+17*pitch*yDim*(zDim/GPU_N-2)]=f17;
    f[j+18*pitch*yDim*(zDim/GPU_N-2)]=f18;
    }
}

__global__ void initialize_buffer(float *g, size_t pitch, int yDim, int GPU_N, int level)//pitch in elements
{
	int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
	int y = threadIdx.y+blockIdx.y*blockDim.y;
	int j = x+y*pitch;//index on padded mem (pitch in elements)
	float f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18;
	
    float xcoord = x;
    float ycoord = y;
    float zcoord = 0+1+GPU_N*ZDIM;
    if(level > 0){
        xcoord = LRX0+x*LRFACTOR;
        ycoord = LRY0+y*LRFACTOR;
        zcoord = LRZ0;
    }

	int im = ImageFcn(xcoord,ycoord,zcoord);
	float u,v,w,rho,usqr;
	rho = 1.f;
	u = 0.01f;
	v = UMAX;
	w = 0.0f;

    if(im == 10 || im == 1){
    u = 0.0f;
    v = 0.0f;
    w = 0.0f;
    }

	usqr = u*u+v*v+w*w;

    if(MODEL == "BGK"){ 
	g[j+0 *pitch*yDim]= 1.0f/3.0f*(rho-1.5f*usqr);
	g[j+1 *pitch*yDim]= 1.0f/18.0f*(rho+3.0f*u+4.5f*u*u-1.5f*usqr);
	g[j+2 *pitch*yDim]= 1.0f/18.0f*(rho+3.0f*v+4.5f*v*v-1.5f*usqr);
	g[j+3 *pitch*yDim]= 1.0f/18.0f*(rho-3.0f*u+4.5f*u*u-1.5f*usqr);
	g[j+4 *pitch*yDim]= 1.0f/18.0f*(rho-3.0f*v+4.5f*v*v-1.5f*usqr);
	g[j+5 *pitch*yDim]= 1.0f/36.0f*(rho+3.0f*(u+v)+4.5f*(u+v)*(u+v)-1.5f*usqr);
	g[j+6 *pitch*yDim]= 1.0f/36.0f*(rho+3.0f*(-u+v)+4.5f*(-u+v)*(-u+v)-1.5f*usqr);
	g[j+7 *pitch*yDim]= 1.0f/36.0f*(rho+3.0f*(-u-v)+4.5f*(-u-v)*(-u-v)-1.5f*usqr);
	g[j+8 *pitch*yDim]= 1.0f/36.0f*(rho+3.0f*(u-v)+4.5f*(u-v)*(u-v)-1.5f*usqr);
	g[j+9 *pitch*yDim]= 1.0f/18.0f*(rho+3.0f*w+4.5f*w*w-1.5f*usqr);
	g[j+10*pitch*yDim]= 1.0f/36.0f*(rho+3.0f*(u+w)+4.5f*(u+w)*(u+w)-1.5f*usqr);
	g[j+11*pitch*yDim]= 1.0f/36.0f*(rho+3.0f*(v+w)+4.5f*(v+w)*(v+w)-1.5f*usqr);
	g[j+12*pitch*yDim]= 1.0f/36.0f*(rho+3.0f*(-u+w)+4.5f*(-u+w)*(-u+w)-1.5f*usqr);
	g[j+13*pitch*yDim]= 1.0f/36.0f*(rho+3.0f*(-v+w)+4.5f*(-v+w)*(-v+w)-1.5f*usqr);
	g[j+14*pitch*yDim]= 1.0f/18.0f*(rho-3.0f*w+4.5f*w*w-1.5f*usqr);
	g[j+15*pitch*yDim]= 1.0f/36.0f*(rho+3.0f*(u-w)+4.5f*(u-w)*(u-w)-1.5f*usqr);
	g[j+16*pitch*yDim]= 1.0f/36.0f*(rho+3.0f*(v-w)+4.5f*(v-w)*(v-w)-1.5f*usqr);
	g[j+17*pitch*yDim]= 1.0f/36.0f*(rho+3.0f*(-u-w)+4.5f*(-u-w)*(-u-w)-1.5f*usqr);
	g[j+18*pitch*yDim]= 1.0f/36.0f*(rho+3.0f*(-v-w)+4.5f*(-v-w)*(-v-w)-1.5f*usqr);   
    }
    else{

    mrt_feq(rho,u,v,w,f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18);

    g[j+0 *pitch*yDim]=f0 ;
    g[j+1 *pitch*yDim]=f1 ;
    g[j+2 *pitch*yDim]=f2 ;
    g[j+3 *pitch*yDim]=f3 ;
    g[j+4 *pitch*yDim]=f4 ;
    g[j+5 *pitch*yDim]=f5 ;
    g[j+6 *pitch*yDim]=f6 ;
    g[j+7 *pitch*yDim]=f7 ;
    g[j+8 *pitch*yDim]=f8 ;
    g[j+9 *pitch*yDim]=f9 ;
    g[j+10*pitch*yDim]=f10;
    g[j+11*pitch*yDim]=f11;
    g[j+12*pitch*yDim]=f12;
    g[j+13*pitch*yDim]=f13;
    g[j+14*pitch*yDim]=f14;
    g[j+15*pitch*yDim]=f15;
    g[j+16*pitch*yDim]=f16;
    g[j+17*pitch*yDim]=f17;
    g[j+18*pitch*yDim]=f18;

    }
}


//zMin = minimum zcoord, zNum = number of nodes in z
//void WriteResults(float *f, ofstream &output, float omega, int xDim, int yDim, int zMin, int zNum, float x0, float y0, float z0, float scale)
void WriteResults(ofstream &output, float *fin, float *gin, float *hin, float *uAv, float *vAv, float *wAv, 
                  float *uFluc, float *vFluc, float *wFluc, float omega, int GPU_N, int GPU)
{
    float f[19];

    for(int j = 0; j<YDIM; j++){
    for(int i = 0; i<XDIM; i++){
        float rho = 0;
        for(int l = 0; l<19; l++){
            f[l] = gin[(i+j*XDIM)+l *XDIM*YDIM];
            rho += f[l];
        }
        float u = f[1]-f[3 ]+f[5 ]-f[6 ]-f[7 ]+f[8 ]+f[10]-f[12]+f[15]-f[17];
        float v = f[2]-f[4 ]+f[5 ]+f[6 ]-f[7 ]-f[8 ]+f[11]-f[13]+f[16]-f[18];
        float w = f[9]+f[10]+f[11]+f[12]+f[13]-f[14]-f[15]-f[16]-f[17]-f[18];
        output<<i<<", "<<j<<", "<<(ZDIM/GPU_N*GPU)<<", "<<u<<","<<v<<","<<w<<","<<rho<<","
              <<uAv[i+j*XDIM]<<","<<vAv[i+j*XDIM]<<", "<<uFluc[i+j*XDIM]<<","<<vFluc[i+j*XDIM]<<endl;
    }}

    for(int k = 1; k<ZDIM/GPU_N-1; k++){
    for(int j = 0; j<YDIM; j++){
    for(int i = 0; i<XDIM; i++){
        float rho = 0;
        for(int l = 0; l<19; l++){
            f[l] = fin[(i+j*XDIM)+(k-1)*XDIM*YDIM+l*XDIM*YDIM*(ZDIM/GPU_N-2)];
            rho += f[l];
        }
        float u = f[1]-f[3 ]+f[5 ]-f[6 ]-f[7 ]+f[8 ]+f[10]-f[12]+f[15]-f[17];
        float v = f[2]-f[4 ]+f[5 ]+f[6 ]-f[7 ]-f[8 ]+f[11]-f[13]+f[16]-f[18];
        float w = f[9]+f[10]+f[11]+f[12]+f[13]-f[14]-f[15]-f[16]-f[17]-f[18];
        int z = (ZDIM/GPU_N*GPU+k);
        output<<i<<", "<<j<<", "<<z<<", "<<u<<","<<v<<","<<w<<","<<rho<<","
              <<uAv[i+j*XDIM+k*XDIM*YDIM]<<","<<vAv[i+j*XDIM+k*XDIM*YDIM]<<", "
              <<uFluc[i+j*XDIM+k*XDIM*YDIM]<<","<<vFluc[i+j*XDIM+k*XDIM*YDIM]<<endl;
    }}}

    for(int j = 0; j<YDIM; j++){
    for(int i = 0; i<XDIM; i++){
        float rho = 0;
        for(int l = 0; l<19; l++){
            f[l] = hin[(i+j*XDIM)+l *XDIM*YDIM];
            rho += f[l];
        }
        float u = f[1]-f[3 ]+f[5 ]-f[6 ]-f[7 ]+f[8 ]+f[10]-f[12]+f[15]-f[17];
        float v = f[2]-f[4 ]+f[5 ]+f[6 ]-f[7 ]-f[8 ]+f[11]-f[13]+f[16]-f[18];
        float w = f[9]+f[10]+f[11]+f[12]+f[13]-f[14]-f[15]-f[16]-f[17]-f[18];
        output<<i<<", "<<j<<", "<<(ZDIM/GPU_N*(GPU+1)-1)<<", "<<u<<","<<v<<","<<w<<","<<rho<<","
              <<uAv[i+j*XDIM+(ZDIM-1)*XDIM*YDIM]<<","<<vAv[i+j*XDIM+(ZDIM/GPU_N-1)*XDIM*YDIM]<<", "
              <<uFluc[i+j*XDIM+(ZDIM-1)*XDIM*YDIM]<<","<<vFluc[i+j*XDIM+(ZDIM/GPU_N-1)*XDIM*YDIM]<<endl;
    }}
}

void WriteResultsLR(ofstream &output, float *fin, float *gin, float *hin, float *uAv, float *vAv, float *wAv, 
                  float *uFluc, float *vFluc, float *wFluc, float omega, int GPU_N, int GPU)
{
    float f[19];

    for(int j = 0; j<YLRDIM; j++){
    for(int i = 0; i<XLRDIM; i++){
        float rho = 0;
        for(int l = 0; l<19; l++){
            f[l] = gin[(i+j*XLRDIM)+l *XLRDIM*YLRDIM];
            rho += f[l];
        }
        float u = f[1]-f[3 ]+f[5 ]-f[6 ]-f[7 ]+f[8 ]+f[10]-f[12]+f[15]-f[17];
        float v = f[2]-f[4 ]+f[5 ]+f[6 ]-f[7 ]-f[8 ]+f[11]-f[13]+f[16]-f[18];
        float w = f[9]+f[10]+f[11]+f[12]+f[13]-f[14]-f[15]-f[16]-f[17]-f[18];
        float x = LRX0+LRFACTOR*i;
        float y = LRY0+LRFACTOR*j;
        float z = LRZ0+LRFACTOR*(ZLRDIM/GPU_N*GPU);
        output<<x<<", "<<y<<", "<<z<<", "<<u<<","<<v<<","<<w<<","<<rho<<","
              <<uAv[i+j*XLRDIM]<<","<<vAv[i+j*XLRDIM]<<", "<<uFluc[i+j*XLRDIM]<<","<<vFluc[i+j*XLRDIM]<<endl;
    }}

    for(int k = 1; k<ZLRDIM/GPU_N-1; k++){
    for(int j = 0; j<YLRDIM; j++){
    for(int i = 0; i<XLRDIM; i++){
        float rho = 0;
        for(int l = 0; l<19; l++){
            f[l] = fin[(i+j*XLRDIM)+(k-1)*XLRDIM*YLRDIM+l*XLRDIM*YLRDIM*(ZLRDIM/GPU_N-2)];
            rho += f[l];
        }
        float u = f[1]-f[3 ]+f[5 ]-f[6 ]-f[7 ]+f[8 ]+f[10]-f[12]+f[15]-f[17];
        float v = f[2]-f[4 ]+f[5 ]+f[6 ]-f[7 ]-f[8 ]+f[11]-f[13]+f[16]-f[18];
        float w = f[9]+f[10]+f[11]+f[12]+f[13]-f[14]-f[15]-f[16]-f[17]-f[18];
        float x = LRX0+LRFACTOR*i;
        float y = LRY0+LRFACTOR*j;
        float z = LRZ0+LRFACTOR*(ZLRDIM/GPU_N*GPU+k);
        output<<x<<", "<<y<<", "<<z<<", "<<u<<","<<v<<","<<w<<","<<rho<<","
              <<uAv[i+j*XLRDIM+k*XLRDIM*YLRDIM]<<","<<vAv[i+j*XLRDIM+k*XLRDIM*YLRDIM]<<", "
              <<uFluc[i+j*XLRDIM+k*XLRDIM*YLRDIM]<<","<<vFluc[i+j*XLRDIM+k*XLRDIM*YLRDIM]<<endl;
    }}}

    for(int j = 0; j<YLRDIM; j++){
    for(int i = 0; i<XLRDIM; i++){
        float rho = 0;
        for(int l = 0; l<19; l++){
            f[l] = hin[(i+j*XLRDIM)+l *XLRDIM*YLRDIM];
            rho += f[l];
        }
        float u = f[1]-f[3 ]+f[5 ]-f[6 ]-f[7 ]+f[8 ]+f[10]-f[12]+f[15]-f[17];
        float v = f[2]-f[4 ]+f[5 ]+f[6 ]-f[7 ]-f[8 ]+f[11]-f[13]+f[16]-f[18];
        float w = f[9]+f[10]+f[11]+f[12]+f[13]-f[14]-f[15]-f[16]-f[17]-f[18];
        float x = LRX0+LRFACTOR*i;
        float y = LRY0+LRFACTOR*j;
        float z = LRZ0+LRFACTOR*(ZLRDIM/GPU_N*(GPU+1)-1);
        output<<x<<", "<<y<<", "<<z<<", "<<u<<","<<v<<","<<w<<","<<rho<<","
              <<uAv[i+j*XLRDIM+(ZLRDIM/GPU_N-1)*XLRDIM*YLRDIM]<<","<<vAv[i+j*XLRDIM+(ZLRDIM/GPU_N-1)*XLRDIM*YLRDIM]<<", "
              <<uFluc[i+j*XLRDIM+(ZLRDIM/GPU_N-1)*XLRDIM*YLRDIM]<<","<<vFluc[i+j*XLRDIM+(ZLRDIM/GPU_N-1)*XLRDIM*YLRDIM]<<endl;
    }}
}


void WriteForces(float *FX, float *FY, float *FZ, ofstream &output, int ForceTime, int level)
{
    float ref = UMAX*UMAX*ZDIM*OBSTR1;
    if(level > 0)
    ref *= LRLEVEL*LRLEVEL;
    for(int i = 0; i<ForceTime; i++){
        output<<i+ForceTime<<", "<<FX[i]/ref<<", "<<FY[i]/ref<<", "<<FZ[i]/ref<<endl;
    }
}

void WriteInputs(ofstream &output, float omega, float omegaLR, int GPU_per_node)
{
    output<<"Base domain size \t"<<XDIM<<"x"<<YDIM<<"x"<<ZDIM<<endl;
	output<<"Base blocksize: \t"<<BLOCKSIZEX<<"x"<<BLOCKSIZEY<<"x"<<BLOCKSIZEZ<<endl;
	output<<"Obst1 location: \t("<<OBSTX1<<","<<OBSTY1<<","<<OBSTZ1<<")"<<endl;
	output<<"Obst1 radius: \t"<<OBSTR1<<endl;
	output<<"Obst2 location: \t("<<OBSTX2<<","<<OBSTY2<<","<<OBSTZ2<<")"<<endl;
	output<<"Obst2 radius: \t"<<OBSTR2<<endl;
	output<<"RE: \t"<<RE<<endl;
	output<<"UMAX: \t"<<UMAX<<endl;
    output<<"omega \t: "<<omega<<endl;
	output<<"TMAX: \t"<<TMAX<<endl;
	output<<"STARTF: \t"<<STARTF<<endl;
	output<<"START_VELAV: \t"<<START_VELAV<<endl;
	output<<"START_VELFLUC: \t"<<START_VELFLUC<<endl;
	output<<"REFINEMENT: \t"<<REFINEMENT<<endl;
	output<<"MODEL: \t"<<MODEL<<endl;
	output<<"Smagorinski LES: \t"<<SmagLES<<endl;
	output<<"CS: \t"<<CS<<endl;
    output<<"LR domain size \t"<<XLRDIM<<"x"<<YLRDIM<<"x"<<ZLRDIM<<endl;
    output<<"LR factor \t"<<LRFACTOR<<endl;
    output<<"LR location \t"<<LRX0<<"x"<<LRY0<<"x"<<LRZ0<<endl;
	output<<"LR blocksize: \t"<<BLOCKSIZELRX<<"x"<<BLOCKSIZELRY<<"x"<<BLOCKSIZELRZ<<endl;   
	output<<"omega in LR \t: "<<omegaLR<<endl;
	output<<"GPUs per node \t: "<<GPU_per_node<<endl;
    output.close();
}



int main(int argc, char *argv[])
{
	int GPU_N;
	cudaGetDeviceCount(&GPU_N);
    //GPU_N = 1;
	cout<<"number of GPUs: "<<GPU_N<<endl;
    int outputflag = 1;
    if(argc>1){
        if(strcmp(argv[1],"-no")==0){
            outputflag = 0;
            cout<<"no outputs option\n";
        }
    }

	ofstream output;
	ofstream outputForce;
	ofstream outputInputs;
	string FileName = CASENAME;
	//output.open ("LBM1_out.dat");
	output.open ((FileName+".dat").c_str());
	outputForce.open ((FileName+".force").c_str());
	outputInputs.open ((FileName+".inputs").c_str());

	//size_t memsize, memsize2;
	size_t pitch = 2;
	while(pitch<XDIM)
		pitch=pitch*2;
	pitch = XDIM*sizeof(float);//pitch*sizeof(float);
	size_t pitch_elements = XDIM;//pitch/sizeof(float);

	cout<<"Pitch (in elements): "<<pitch/sizeof(float)<<endl;
	int i, nBlocks;
	float omega, CharLength;

	CharLength = OBSTR1*2.f;

	omega = 1.0f/(3.0f*(UMAX*CharLength/RE)+0.5f);
	float omegaLR = 2.0f/(1.0f+2.0f*(2.0f/omega-1.0f));
	if(LRFACTOR == 0.25f){
	omegaLR = 2.0f/(1.0f+2.0f*(2.0f/omegaLR-1.0f));
	}
	float SF_cf = omega*(1.0f-omegaLR)/((1.0f-omega)*omegaLR/LRFACTOR);
	float SF_fc = 1.f/SF_cf;

    WriteInputs(outputInputs,omega,omegaLR,GPU_N);

	cout<<"omega : "<<omega<<endl;
	cout<<"omegaLR : "<<omegaLR<<endl;
	cout<<"blocksize: "<<BLOCKSIZEX<<"x"<<BLOCKSIZEY<<"x"<<BLOCKSIZEZ<<endl;
	cout<<"grid: "<<XDIM<<"x"<<YDIM<<"x"<<ZDIM<<endl;
	cout<<"gridLR: "<<XLRDIM<<"x"<<YLRDIM<<"x"<<ZLRDIM<<endl;
	cout<<"TMAX: "<<TMAX<<endl;
	cout<<"Model: "<<MODEL<<endl;
	cout<<"Refinement: "<<LRLEVEL<<endl;

	if(abs(LRFACTOR-1.f/LRLEVEL)>0.001f){
		cout<<"LRLEVEL and LRFACTOR don't match! Exiting..."<<endl;
		return 0;
	}

    int zInner = ZDIM/GPU_N-2; //excluding halo
    //int zGPU = ZDIM/GPU_N;//z nodes per GPU (including halo)

	//nBlocks does not include the halo layers
	nBlocks = ((XDIM+BLOCKSIZEX-1)/BLOCKSIZEX)*((YDIM+BLOCKSIZEY-1)/BLOCKSIZEY)
				*((zInner+BLOCKSIZEZ-1)/BLOCKSIZEZ);
	cout<<"nBlocks:"<<nBlocks<<endl;
    int ForceTime = max(0,TMAX-STARTF);

    dim3 threads(BLOCKSIZEX, BLOCKSIZEY, BLOCKSIZEZ);
	//2 halo layers per GPU (for 2 GPUs)
    dim3 grid(((XDIM+BLOCKSIZEX-1)/BLOCKSIZEX),((YDIM+BLOCKSIZEY-1)/BLOCKSIZEY),(zInner)/BLOCKSIZEZ);
    dim3 g_grid(((XDIM+BLOCKSIZEX-1)/BLOCKSIZEX),((YDIM+BLOCKSIZEY-1)/BLOCKSIZEY),1);
    dim3 h_grid(((XDIM+BLOCKSIZEX-1)/BLOCKSIZEX),((YDIM+BLOCKSIZEY-1)/BLOCKSIZEY),1);

    cudaStream_t stream_halo[GPU_N];
    cudaStream_t stream_inner[GPU_N];

    //data pointers as 3D array (GPUxCoord)
    float   *f_inner_h[GPU_N],   *g_h[GPU_N],   *h_h[GPU_N];
    float *f_inner_A_d[GPU_N], *g_A_d[GPU_N], *h_A_d[GPU_N];
    float *f_inner_B_d[GPU_N], *g_B_d[GPU_N], *h_B_d[GPU_N];
    float *g_temp[GPU_N], *h_temp[GPU_N];
    float *FX_h[GPU_N],*FY_h[GPU_N],*FZ_h[GPU_N];
    float *FX_d[GPU_N],*FY_d[GPU_N],*FZ_d[GPU_N];
    float *FX_total,*FY_total,*FZ_total;
    float *uAv_h[GPU_N], *vAv_h[GPU_N], *wAv_h[GPU_N], *uAv_d[GPU_N], *vAv_d[GPU_N], *wAv_d[GPU_N];
    float *uFluc_h[GPU_N], *vFluc_h[GPU_N], *wFluc_h[GPU_N], *uFluc_d[GPU_N], *vFluc_d[GPU_N], *wFluc_d[GPU_N];

	FX_total     = (float *)malloc(ForceTime*sizeof(float));
	FY_total     = (float *)malloc(ForceTime*sizeof(float));
	FZ_total     = (float *)malloc(ForceTime*sizeof(float));
	
    for(i=0;i<(ForceTime);i++){
        FX_total[i] = 0;
        FY_total[i] = 0;
        FZ_total[i] = 0;
    }

    //Malloc and Initialize for each GPU
    for(int n = 0; n<GPU_N; n++){
	f_inner_h[n] = (float *)malloc(XDIM*YDIM*zInner*19*sizeof(float));
	g_h      [n] = (float *)malloc(XDIM*YDIM*       19*sizeof(float));
	h_h      [n] = (float *)malloc(XDIM*YDIM*       19*sizeof(float));
	FX_h     [n] = (float *)malloc(ForceTime*sizeof(float));
	FY_h     [n] = (float *)malloc(ForceTime*sizeof(float));
	FZ_h     [n] = (float *)malloc(ForceTime*sizeof(float));

	uAv_h    [n]= (float *)malloc(XDIM*YDIM*ZDIM/GPU_N*sizeof(float));
	vAv_h    [n]= (float *)malloc(XDIM*YDIM*ZDIM/GPU_N*sizeof(float));
	wAv_h    [n]= (float *)malloc(XDIM*YDIM*ZDIM/GPU_N*sizeof(float));
	uFluc_h  [n]= (float *)malloc(XDIM*YDIM*ZDIM/GPU_N*sizeof(float));
	vFluc_h  [n]= (float *)malloc(XDIM*YDIM*ZDIM/GPU_N*sizeof(float));
	wFluc_h  [n]= (float *)malloc(XDIM*YDIM*ZDIM/GPU_N*sizeof(float));

    cudaSetDevice(n);

	cudaStreamCreate(&stream_halo[n]);
	cudaStreamCreate(&stream_inner[n]);

    for(int m = 0; m<GPU_N; m++){
        if(m != n)
	        cudaDeviceEnablePeerAccess(m,0);
    }

	cudaMalloc((void **) &f_inner_A_d[n], pitch_elements*YDIM*zInner*19*sizeof(float));
	cudaMalloc((void **) &f_inner_B_d[n], pitch_elements*YDIM*zInner*19*sizeof(float));
	cudaMalloc((void **) &      g_A_d[n], pitch_elements*YDIM*       19*sizeof(float));
	cudaMalloc((void **) &      g_B_d[n], pitch_elements*YDIM*       19*sizeof(float));
	cudaMalloc((void **) &      h_A_d[n], pitch_elements*YDIM*       19*sizeof(float));
	cudaMalloc((void **) &      h_B_d[n], pitch_elements*YDIM*       19*sizeof(float));
	cudaMalloc((void **) &     g_temp[n], pitch_elements*YDIM*       19*sizeof(float));
	cudaMalloc((void **) &     h_temp[n], pitch_elements*YDIM*       19*sizeof(float));
	cudaMalloc((void **) &     FX_d[n], (ForceTime)*sizeof(float));
	cudaMalloc((void **) &     FY_d[n], (ForceTime)*sizeof(float));
	cudaMalloc((void **) &     FZ_d[n], (ForceTime)*sizeof(float));

	cudaMalloc((void **) &   uAv_d[n], pitch_elements*YDIM*ZDIM/GPU_N*sizeof(float));
	cudaMalloc((void **) &   vAv_d[n], pitch_elements*YDIM*ZDIM/GPU_N*sizeof(float));
	cudaMalloc((void **) &   wAv_d[n], pitch_elements*YDIM*ZDIM/GPU_N*sizeof(float));
	cudaMalloc((void **) & uFluc_d[n], pitch_elements*YDIM*ZDIM/GPU_N*sizeof(float));
	cudaMalloc((void **) & vFluc_d[n], pitch_elements*YDIM*ZDIM/GPU_N*sizeof(float));
	cudaMalloc((void **) & wFluc_d[n], pitch_elements*YDIM*ZDIM/GPU_N*sizeof(float));

	//initialize host f_inner
	for (i = 0; i < XDIM*YDIM*zInner*19; i++)
		f_inner_h[n][i] = 0;
	//initialize host g,h
	for (i = 0; i < XDIM*YDIM*19; i++){
		g_h[n][i] = 0;
		h_h[n][i] = 0;
	}
    for(i=0;i<(ForceTime);i++){
        FX_h[n][i] = 0;
        FY_h[n][i] = 0;
        FZ_h[n][i] = 0;
    }
	for (i = 0; i < XDIM*YDIM*ZDIM/GPU_N; i++){
		uAv_h[n][i] = 0;
		vAv_h[n][i] = 0;
		wAv_h[n][i] = 0;
		uFluc_h[n][i] = 0;
		vFluc_h[n][i] = 0;
		wFluc_h[n][i] = 0;
	}

	cudaMemcpy2D(f_inner_A_d[n],pitch,f_inner_h[n],XDIM*sizeof(float),XDIM*sizeof(float),YDIM*zInner*19,cudaMemcpyHostToDevice);
	cudaMemcpy2D(f_inner_B_d[n],pitch,f_inner_h[n],XDIM*sizeof(float),XDIM*sizeof(float),YDIM*zInner*19,cudaMemcpyHostToDevice);
	cudaMemcpy2D(      g_A_d[n],pitch,      g_h[n],XDIM*sizeof(float),XDIM*sizeof(float),YDIM*       19,cudaMemcpyHostToDevice);
	cudaMemcpy2D(      g_B_d[n],pitch,      g_h[n],XDIM*sizeof(float),XDIM*sizeof(float),YDIM*       19,cudaMemcpyHostToDevice);
	cudaMemcpy2D(      h_A_d[n],pitch,      h_h[n],XDIM*sizeof(float),XDIM*sizeof(float),YDIM*       19,cudaMemcpyHostToDevice);
	cudaMemcpy2D(      h_B_d[n],pitch,      h_h[n],XDIM*sizeof(float),XDIM*sizeof(float),YDIM*       19,cudaMemcpyHostToDevice);

	cudaMemcpy2D(      uAv_d[n],pitch,    uAv_h[n],XDIM*sizeof(float),XDIM*sizeof(float),YDIM*ZDIM/GPU_N,cudaMemcpyHostToDevice);
	cudaMemcpy2D(      vAv_d[n],pitch,    vAv_h[n],XDIM*sizeof(float),XDIM*sizeof(float),YDIM*ZDIM/GPU_N,cudaMemcpyHostToDevice);
	cudaMemcpy2D(      wAv_d[n],pitch,    wAv_h[n],XDIM*sizeof(float),XDIM*sizeof(float),YDIM*ZDIM/GPU_N,cudaMemcpyHostToDevice);
	cudaMemcpy2D(    uFluc_d[n],pitch,  uFluc_h[n],XDIM*sizeof(float),XDIM*sizeof(float),YDIM*ZDIM/GPU_N,cudaMemcpyHostToDevice);
	cudaMemcpy2D(    vFluc_d[n],pitch,  vFluc_h[n],XDIM*sizeof(float),XDIM*sizeof(float),YDIM*ZDIM/GPU_N,cudaMemcpyHostToDevice);
	cudaMemcpy2D(    wFluc_d[n],pitch,  wFluc_h[n],XDIM*sizeof(float),XDIM*sizeof(float),YDIM*ZDIM/GPU_N,cudaMemcpyHostToDevice);

	cudaMemcpy(      FX_d[n],      FX_h[n],sizeof(float)*(ForceTime),cudaMemcpyHostToDevice);
	cudaMemcpy(      FY_d[n],      FY_h[n],sizeof(float)*(ForceTime),cudaMemcpyHostToDevice);
	cudaMemcpy(      FZ_d[n],      FZ_h[n],sizeof(float)*(ForceTime),cudaMemcpyHostToDevice);

	initialize_single<<<grid  , threads>>>(f_inner_A_d[n],pitch_elements,YDIM,ZDIM,GPU_N,0);
	initialize_single<<<grid  , threads>>>(f_inner_B_d[n],pitch_elements,YDIM,ZDIM,GPU_N,0);
	initialize_buffer<<<g_grid, threads>>>(      g_A_d[n],pitch_elements,YDIM,GPU_N,0);
	initialize_buffer<<<g_grid, threads>>>(      g_B_d[n],pitch_elements,YDIM,GPU_N,0);
	initialize_buffer<<<g_grid, threads>>>(      h_A_d[n],pitch_elements,YDIM,GPU_N,0);
	initialize_buffer<<<g_grid, threads>>>(      h_B_d[n],pitch_elements,YDIM,GPU_N,0);
	initialize_buffer<<<g_grid, threads>>>(     g_temp[n],pitch_elements,YDIM,GPU_N,0);
	initialize_buffer<<<g_grid, threads>>>(     h_temp[n],pitch_elements,YDIM,GPU_N,0);

    }//end Malloc and Initialize

    //data pointers for LR
    float   *f_inner_LR_h[GPU_N],   *g_LR_h[GPU_N],   *h_LR_h[GPU_N];
    float *f_inner_LR_A_d[GPU_N], *g_LR_A_d[GPU_N], *h_LR_A_d[GPU_N];
    float *f_inner_LR_B_d[GPU_N], *g_LR_B_d[GPU_N], *h_LR_B_d[GPU_N];
    float *g_LR_temp[GPU_N], *h_LR_temp[GPU_N];
    float *uAvLR_h[GPU_N], *vAvLR_h[GPU_N], *wAvLR_h[GPU_N], *uAvLR_d[GPU_N], *vAvLR_d[GPU_N], *wAvLR_d[GPU_N];
    float *uFlucLR_h[GPU_N], *vFlucLR_h[GPU_N], *wFlucLR_h[GPU_N], *uFlucLR_d[GPU_N], *vFlucLR_d[GPU_N], *wFlucLR_d[GPU_N];

	size_t LRpitch = 2;
	while(LRpitch<XLRDIM)
		LRpitch=LRpitch*2;
	LRpitch = XLRDIM*sizeof(float);//LRpitch*sizeof(float);
	size_t LRpitch_elements = XLRDIM;//LRpitch/sizeof(float);
	cout<<"LR Pitch (in elements): "<<LRpitch/sizeof(float)<<endl;

    int zLRInner = ZLRDIM/GPU_N-2;
    dim3 LRthreads(BLOCKSIZELRX, BLOCKSIZELRY, BLOCKSIZELRZ);
    dim3 LRgrid(((XLRDIM+BLOCKSIZELRX-1)/BLOCKSIZELRX),((YLRDIM+BLOCKSIZELRY-1)/BLOCKSIZELRY),(zLRInner)/BLOCKSIZELRZ);
    dim3 g_LR_grid(((XLRDIM+BLOCKSIZELRX-1)/BLOCKSIZELRX),((YLRDIM+BLOCKSIZELRY-1)/BLOCKSIZELRY),1);

    //LR setup
    if(REFINEMENT == 1){
    for(int n = 0; n<GPU_N; n++){
	f_inner_LR_h[n] = (float *)malloc(XLRDIM*YLRDIM*zLRInner*19*sizeof(float));
	g_LR_h      [n] = (float *)malloc(XLRDIM*YLRDIM*         19*sizeof(float));
	h_LR_h      [n] = (float *)malloc(XLRDIM*YLRDIM*         19*sizeof(float));
	
	uAvLR_h    [n]= (float *)malloc(XLRDIM*YLRDIM*ZLRDIM/GPU_N*sizeof(float));
	vAvLR_h    [n]= (float *)malloc(XLRDIM*YLRDIM*ZLRDIM/GPU_N*sizeof(float));
	wAvLR_h    [n]= (float *)malloc(XLRDIM*YLRDIM*ZLRDIM/GPU_N*sizeof(float));
	uFlucLR_h  [n]= (float *)malloc(XLRDIM*YLRDIM*ZLRDIM/GPU_N*sizeof(float));
	vFlucLR_h  [n]= (float *)malloc(XLRDIM*YLRDIM*ZLRDIM/GPU_N*sizeof(float));
	wFlucLR_h  [n]= (float *)malloc(XLRDIM*YLRDIM*ZLRDIM/GPU_N*sizeof(float));

    cudaSetDevice(n);

	cudaMalloc((void **) &f_inner_LR_A_d[n], LRpitch_elements*YLRDIM*zLRInner*19*sizeof(float));
	cudaMalloc((void **) &f_inner_LR_B_d[n], LRpitch_elements*YLRDIM*zLRInner*19*sizeof(float));
	cudaMalloc((void **) &      g_LR_A_d[n], LRpitch_elements*YLRDIM*         19*sizeof(float));
	cudaMalloc((void **) &      g_LR_B_d[n], LRpitch_elements*YLRDIM*         19*sizeof(float));
	cudaMalloc((void **) &      h_LR_A_d[n], LRpitch_elements*YLRDIM*         19*sizeof(float));
	cudaMalloc((void **) &      h_LR_B_d[n], LRpitch_elements*YLRDIM*         19*sizeof(float));
	cudaMalloc((void **) &     g_LR_temp[n], LRpitch_elements*YLRDIM*         19*sizeof(float));
	cudaMalloc((void **) &     h_LR_temp[n], LRpitch_elements*YLRDIM*         19*sizeof(float));
	
    cudaMalloc((void **) &   uAvLR_d[n], LRpitch_elements*YLRDIM*ZLRDIM/GPU_N*sizeof(float));
	cudaMalloc((void **) &   vAvLR_d[n], LRpitch_elements*YLRDIM*ZLRDIM/GPU_N*sizeof(float));
	cudaMalloc((void **) &   wAvLR_d[n], LRpitch_elements*YLRDIM*ZLRDIM/GPU_N*sizeof(float));
	cudaMalloc((void **) & uFlucLR_d[n], LRpitch_elements*YLRDIM*ZLRDIM/GPU_N*sizeof(float));
	cudaMalloc((void **) & vFlucLR_d[n], LRpitch_elements*YLRDIM*ZLRDIM/GPU_N*sizeof(float));
	cudaMalloc((void **) & wFlucLR_d[n], LRpitch_elements*YLRDIM*ZLRDIM/GPU_N*sizeof(float));

	//initialize host f_inner
	for (i = 0; i < XLRDIM*YLRDIM*zLRInner*19; i++)
		f_inner_LR_h[n][i] = 0;
	//initialize host g,h
	for (i = 0; i < XLRDIM*YLRDIM*19; i++){
		g_LR_h[n][i] = 0;
		h_LR_h[n][i] = 0;
	}
	for (i = 0; i < XLRDIM*YLRDIM*ZLRDIM/GPU_N; i++){
		uAvLR_h[n][i] = 0;
		vAvLR_h[n][i] = 0;
		wAvLR_h[n][i] = 0;
		uFlucLR_h[n][i] = 0;
		vFlucLR_h[n][i] = 0;
		wFlucLR_h[n][i] = 0;
	}

	cudaMemcpy2D(f_inner_LR_A_d[n],LRpitch,f_inner_LR_h[n],XLRDIM*sizeof(float),XLRDIM*sizeof(float),YLRDIM*zLRInner*19,cudaMemcpyHostToDevice);
	cudaMemcpy2D(f_inner_LR_B_d[n],LRpitch,f_inner_LR_h[n],XLRDIM*sizeof(float),XLRDIM*sizeof(float),YLRDIM*zLRInner*19,cudaMemcpyHostToDevice);
	cudaMemcpy2D(      g_LR_A_d[n],LRpitch,      g_LR_h[n],XLRDIM*sizeof(float),XLRDIM*sizeof(float),YLRDIM*         19,cudaMemcpyHostToDevice);
	cudaMemcpy2D(      g_LR_B_d[n],LRpitch,      g_LR_h[n],XLRDIM*sizeof(float),XLRDIM*sizeof(float),YLRDIM*         19,cudaMemcpyHostToDevice);
	cudaMemcpy2D(      h_LR_A_d[n],LRpitch,      h_LR_h[n],XLRDIM*sizeof(float),XLRDIM*sizeof(float),YLRDIM*         19,cudaMemcpyHostToDevice);
	cudaMemcpy2D(      h_LR_B_d[n],LRpitch,      h_LR_h[n],XLRDIM*sizeof(float),XLRDIM*sizeof(float),YLRDIM*         19,cudaMemcpyHostToDevice);

	cudaMemcpy2D(      uAvLR_d[n],LRpitch,    uAvLR_h[n],XLRDIM*sizeof(float),XLRDIM*sizeof(float),YLRDIM*ZLRDIM/GPU_N,cudaMemcpyHostToDevice);
	cudaMemcpy2D(      vAvLR_d[n],LRpitch,    vAvLR_h[n],XLRDIM*sizeof(float),XLRDIM*sizeof(float),YLRDIM*ZLRDIM/GPU_N,cudaMemcpyHostToDevice);
	cudaMemcpy2D(      wAvLR_d[n],LRpitch,    wAvLR_h[n],XLRDIM*sizeof(float),XLRDIM*sizeof(float),YLRDIM*ZLRDIM/GPU_N,cudaMemcpyHostToDevice);
	cudaMemcpy2D(    uFlucLR_d[n],LRpitch,  uFlucLR_h[n],XLRDIM*sizeof(float),XLRDIM*sizeof(float),YLRDIM*ZLRDIM/GPU_N,cudaMemcpyHostToDevice);
	cudaMemcpy2D(    vFlucLR_d[n],LRpitch,  vFlucLR_h[n],XLRDIM*sizeof(float),XLRDIM*sizeof(float),YLRDIM*ZLRDIM/GPU_N,cudaMemcpyHostToDevice);
	cudaMemcpy2D(    wFlucLR_d[n],LRpitch,  wFlucLR_h[n],XLRDIM*sizeof(float),XLRDIM*sizeof(float),YLRDIM*ZLRDIM/GPU_N,cudaMemcpyHostToDevice);

	initialize_single<<<LRgrid   , LRthreads>>>(f_inner_LR_A_d[n],LRpitch_elements,YLRDIM,ZLRDIM,GPU_N,LRLEVEL);
	initialize_single<<<LRgrid   , LRthreads>>>(f_inner_LR_B_d[n],LRpitch_elements,YLRDIM,ZLRDIM,GPU_N,LRLEVEL);
	initialize_buffer<<<g_LR_grid, LRthreads>>>(      g_LR_A_d[n],LRpitch_elements,YLRDIM,GPU_N,LRLEVEL);
	initialize_buffer<<<g_LR_grid, LRthreads>>>(      g_LR_B_d[n],LRpitch_elements,YLRDIM,GPU_N,LRLEVEL);
	initialize_buffer<<<g_LR_grid, LRthreads>>>(      h_LR_A_d[n],LRpitch_elements,YLRDIM,GPU_N,LRLEVEL);
	initialize_buffer<<<g_LR_grid, LRthreads>>>(      h_LR_B_d[n],LRpitch_elements,YLRDIM,GPU_N,LRLEVEL);
	initialize_buffer<<<g_LR_grid, LRthreads>>>(     g_LR_temp[n],LRpitch_elements,YLRDIM,GPU_N,LRLEVEL);
	initialize_buffer<<<g_LR_grid, LRthreads>>>(     h_LR_temp[n],LRpitch_elements,YLRDIM,GPU_N,LRLEVEL);
    }//end of GPU loop for malloc and initialize for LR
    }//end of LR malloc and initialize


	struct timeval tdr0,tdr1;
	double restime;
	cudaDeviceSynchronize();
	gettimeofday (&tdr0,NULL);

    for(int n = 0; n<GPU_N; n++){
	cudaSetDevice(n);
    size_t mem_avail, mem_total;
    cudaMemGetInfo(&mem_avail,&mem_total);
    cout<<"Device memory used for dev"<<n<<" : "<<mem_total-mem_avail<<endl;
    cout<<"Device memory available for dev"<<n<<" : "<<mem_avail<<endl;
    }
       //Time loop 
    for(int t = 0; t<TMAX; t+=2){

		//A->B
        for(int n = 0; n<GPU_N; n++){
    		cudaSetDevice(n);
            if(t>=STARTF && REFINEMENT == 0){
    		update_top_force   <<<h_grid, threads, 0, stream_halo [n]>>>(h_A_d[n],h_B_d[n],f_inner_A_d[n],h_temp[n],omega,pitch_elements,n,zInner,FX_d[n],FY_d[n],FZ_d[n],t-STARTF);
    		update_bottom_force<<<h_grid, threads, 0, stream_halo [n]>>>(g_A_d[n],g_B_d[n],f_inner_A_d[n],g_temp[n],omega,pitch_elements,n,zInner,FX_d[n],FY_d[n],FZ_d[n],t-STARTF);
            }
            else{
    		update_top   <<<h_grid, threads, 0, stream_halo [n]>>>(h_A_d[n],h_B_d[n],f_inner_A_d[n],h_temp[n],omega,pitch_elements,n,zInner);
    		update_bottom<<<h_grid, threads, 0, stream_halo [n]>>>(g_A_d[n],g_B_d[n],f_inner_A_d[n],g_temp[n],omega,pitch_elements,n,zInner);
            }
        }
        for(int n = 0; n<GPU_N; n++)
		cudaStreamSynchronize(stream_halo[n]);
        for(int n = 0; n<GPU_N; n++){
		    cudaSetDevice(n);
            if(t>=STARTF && REFINEMENT == 0){
		    update_inner_force <<<  grid, threads, 0, stream_inner[n]>>>(f_inner_A_d[n],f_inner_B_d[n],g_A_d[n],h_A_d[n],omega,pitch_elements,n,zInner,FX_d[n],FY_d[n],FZ_d[n],t-STARTF,uAv_d[n],vAv_d[n],uFluc_d[n],vFluc_d[n],t);
            }
            else{
		    update_inner <<<  grid, threads, 0, stream_inner[n]>>>(f_inner_A_d[n],f_inner_B_d[n],      g_A_d[n], h_A_d[n],omega,pitch_elements,n,zInner,uAv_d[n],vAv_d[n],uFluc_d[n],vFluc_d[n],t);
            }
        }

        for(int n = 0; n<GPU_N; n++)
		cudaMemcpyPeerAsync(&h_temp[n][0],n,&g_B_d[   (n+1)%GPU_N][0],   (n+1)%GPU_N,pitch_elements*YDIM*sizeof(float)*19,stream_halo[n]);
        for(int n = 0; n<GPU_N; n++)
		cudaMemcpyPeerAsync(&g_temp[n][0],n,&h_B_d[abs(n-1)%GPU_N][0],abs(n-1)%GPU_N,pitch_elements*YDIM*sizeof(float)*19,stream_halo[n]);

        if(REFINEMENT == 1){
            for(int n = 0; n<GPU_N; n++){
    		cudaSetDevice(n);
            if(t>=STARTF){
    		update_top_LR_force   <<<g_LR_grid, LRthreads, 0, stream_halo [n]>>>(      h_LR_A_d[n],      h_LR_B_d[n],f_inner_LR_A_d[n],h_LR_temp[n],omegaLR,LRpitch_elements,n,zLRInner,FX_d[n],FY_d[n],FZ_d[n],t-STARTF);
    		update_bottom_LR_force<<<g_LR_grid, LRthreads, 0, stream_halo [n]>>>(      g_LR_A_d[n],      g_LR_B_d[n],f_inner_LR_A_d[n],g_LR_temp[n],omegaLR,LRpitch_elements,n,zLRInner,FX_d[n],FY_d[n],FZ_d[n],t-STARTF);
            }
            else{
    		update_top_LR   <<<g_LR_grid, LRthreads, 0, stream_halo [n]>>>(      h_LR_A_d[n],      h_LR_B_d[n],f_inner_LR_A_d[n],h_LR_temp[n],omegaLR,LRpitch_elements,n,zLRInner);
    		update_bottom_LR<<<g_LR_grid, LRthreads, 0, stream_halo [n]>>>(      g_LR_A_d[n],      g_LR_B_d[n],f_inner_LR_A_d[n],g_LR_temp[n],omegaLR,LRpitch_elements,n,zLRInner);
            }
            }
            for(int n = 0; n<GPU_N; n++)
    		cudaStreamSynchronize(stream_halo[n]);
            
            for(int n = 0; n<GPU_N; n++){
    		cudaSetDevice(n);
            if(t>=STARTF){
    		update_inner_LR_force <<<  LRgrid,  LRthreads, 0, stream_inner[n]>>>(f_inner_LR_A_d[n],f_inner_LR_B_d[n],      g_LR_A_d[n], h_LR_A_d[n],omegaLR,LRpitch_elements,n,zLRInner,FX_d[n],FY_d[n],FZ_d[n],t-STARTF,uAvLR_d[n],vAvLR_d[n],uFlucLR_d[n],vFlucLR_d[n],t+0.5f);
            }
            else{
    		update_inner_LR <<<  LRgrid,  LRthreads, 0, stream_inner[n]>>>(f_inner_LR_A_d[n],f_inner_LR_B_d[n],g_LR_A_d[n],h_LR_A_d[n],omegaLR,LRpitch_elements,n,zLRInner,uAvLR_d[n],vAvLR_d[n],uFlucLR_d[n],vFlucLR_d[n],t);
            }
            }

            for(int n = 0; n<GPU_N; n++){
    		cudaMemcpyPeerAsync(&h_LR_temp[n][LRpitch_elements*YLRDIM*14],n,&g_LR_B_d[   (n+1)%GPU_N][LRpitch_elements*YLRDIM*14],   (n+1)%GPU_N,LRpitch_elements*YLRDIM*sizeof(float)*5,stream_halo[n]);
    		cudaMemcpyPeerAsync(&g_LR_temp[n][LRpitch_elements*YLRDIM*9 ],n,&h_LR_B_d[abs(n-1)%GPU_N][LRpitch_elements*YLRDIM*9 ],abs(n-1)%GPU_N,LRpitch_elements*YLRDIM*sizeof(float)*5,stream_halo[n]);
            }
   
            for(int n = 0; n<GPU_N; n++){
    		cudaSetDevice(n);
    		cudaDeviceSynchronize();
            }

            for(int n = 0; n<GPU_N; n++){
    		cudaSetDevice(n);
    		update_top_LR_interp   <<<g_LR_grid, LRthreads, 0, stream_halo [n]>>>(h_LR_B_d[n],h_LR_A_d[n],f_inner_LR_B_d[n],h_LR_temp[n],h_B_d[n],h_temp[n],omegaLR,omega,LRpitch_elements,zLRInner,pitch_elements,zInner,SF_cf,n);
    		update_bottom_LR_interp<<<g_LR_grid, LRthreads, 0, stream_halo [n]>>>(g_LR_B_d[n],g_LR_A_d[n],f_inner_LR_B_d[n],g_LR_temp[n],g_B_d[n],g_temp[n],omegaLR,omega,LRpitch_elements,zLRInner,pitch_elements,zInner,SF_cf,n);
            }
            for(int n = 0; n<GPU_N; n++)
    		cudaStreamSynchronize(stream_halo[n]);
            for(int n = 0; n<GPU_N; n++){
    		cudaSetDevice(n);
    		update_inner_LR_interp<<<LRgrid,LRthreads,0,stream_inner[n]>>>(f_inner_LR_B_d[n],f_inner_LR_A_d[n],g_LR_B_d[n],h_LR_B_d[n],f_inner_B_d[n],g_B_d[n],h_B_d[n],omegaLR,omega,LRpitch_elements,zLRInner,pitch_elements,zInner,SF_cf,n,uAvLR_d[n],vAvLR_d[n],uFlucLR_d[n],vFlucLR_d[n],t+0.5f);
            }
            for(int n = 0; n<GPU_N; n++){
    		cudaMemcpyPeerAsync(&h_LR_temp[n][LRpitch_elements*YLRDIM*14],n,&g_LR_A_d[   (n+1)%GPU_N][LRpitch_elements*YLRDIM*14],   (n+1)%GPU_N,LRpitch_elements*YLRDIM*sizeof(float)*5,stream_halo[n]);
    		cudaMemcpyPeerAsync(&g_LR_temp[n][LRpitch_elements*YLRDIM*9 ],n,&h_LR_A_d[abs(n-1)%GPU_N][LRpitch_elements*YLRDIM*9 ],abs(n-1)%GPU_N,LRpitch_elements*YLRDIM*sizeof(float)*5,stream_halo[n]);
            }
    
            for(int n = 0; n<GPU_N; n++){
    		cudaSetDevice(n);
            f_Extract<<<grid,threads,0,stream_inner[n]>>>(f_inner_B_d[n],f_inner_LR_A_d[n],g_LR_A_d[n],h_LR_A_d[n],pitch_elements,LRpitch_elements,zInner,zLRInner,omegaLR,SF_fc,n);
            g_Extract<<<grid,threads,0,stream_inner[n]>>>(g_B_d[n],f_inner_LR_A_d[n],g_LR_A_d[n],pitch_elements,LRpitch_elements,zInner,zLRInner,omegaLR,SF_fc,n);
            h_Extract<<<grid,threads,0,stream_inner[n]>>>(h_B_d[n],f_inner_LR_A_d[n],h_LR_A_d[n],pitch_elements,LRpitch_elements,zInner,zLRInner,omegaLR,SF_fc,n);
            }
        }//end refinement
        
        for(int n = 0; n<GPU_N; n++){
		cudaSetDevice(n);
		cudaDeviceSynchronize();
        }




		//B->A

        for(int n = 0; n<GPU_N; n++){
    		cudaSetDevice(n);
            if(t+1>=STARTF && REFINEMENT == 0){
    		update_top_force   <<<h_grid, threads, 0, stream_halo [n]>>>(h_B_d[n],h_A_d[n],f_inner_B_d[n],h_temp[n],omega,pitch_elements,n,zInner,FX_d[n],FY_d[n],FZ_d[n],t-STARTF+1);
    		update_bottom_force<<<h_grid, threads, 0, stream_halo [n]>>>(g_B_d[n],g_A_d[n],f_inner_B_d[n],g_temp[n],omega,pitch_elements,n,zInner,FX_d[n],FY_d[n],FZ_d[n],t-STARTF+1);
            }
            else{
    		update_top   <<<h_grid, threads, 0, stream_halo [n]>>>(      h_B_d[n],      h_A_d[n],f_inner_B_d[n],h_temp[n],omega,pitch_elements,n,zInner);
    		update_bottom<<<h_grid, threads, 0, stream_halo [n]>>>(      g_B_d[n],      g_A_d[n],f_inner_B_d[n],g_temp[n],omega,pitch_elements,n,zInner);
            }
        }
        for(int n = 0; n<GPU_N; n++)
		cudaStreamSynchronize(stream_halo[n]);
        for(int n = 0; n<GPU_N; n++){
		cudaSetDevice(n);
            if(t+1>=STARTF && REFINEMENT == 0){
		    update_inner_force <<<  grid, threads, 0, stream_inner[n]>>>(f_inner_B_d[n],f_inner_A_d[n],g_B_d[n],h_B_d[n],omega,pitch_elements,n,zInner,FX_d[n],FY_d[n],FZ_d[n],t-STARTF+1,uAv_d[n],vAv_d[n],uFluc_d[n],vFluc_d[n],t+1);
            }
            else{
		    update_inner <<<  grid, threads, 0, stream_inner[n]>>>(f_inner_B_d[n],f_inner_A_d[n],      g_B_d[n], h_B_d[n],omega,pitch_elements,n,zInner,uAv_d[n],vAv_d[n],uFluc_d[n],vFluc_d[n],t+1);
            }
        }

        for(int n = 0; n<GPU_N; n++)
		cudaMemcpyPeerAsync(&h_temp[n][0],n,&g_A_d[   (n+1)%GPU_N][0],   (n+1)%GPU_N,pitch_elements*YDIM*sizeof(float)*19,stream_halo[n]);
        for(int n = 0; n<GPU_N; n++)
		cudaMemcpyPeerAsync(&g_temp[n][0],n,&h_A_d[abs(n-1)%GPU_N][0],abs(n-1)%GPU_N,pitch_elements*YDIM*sizeof(float)*19,stream_halo[n]);

        if(REFINEMENT == 1){
            for(int n = 0; n<GPU_N; n++){
    		cudaSetDevice(n);
            if(t+1>=STARTF){
    		update_top_LR_force   <<<g_LR_grid, LRthreads, 0, stream_halo [n]>>>(      h_LR_A_d[n],      h_LR_B_d[n],f_inner_LR_A_d[n],h_LR_temp[n],omegaLR,LRpitch_elements,n,zLRInner,FX_d[n],FY_d[n],FZ_d[n],t+1-STARTF);
    		update_bottom_LR_force<<<g_LR_grid, LRthreads, 0, stream_halo [n]>>>(      g_LR_A_d[n],      g_LR_B_d[n],f_inner_LR_A_d[n],g_LR_temp[n],omegaLR,LRpitch_elements,n,zLRInner,FX_d[n],FY_d[n],FZ_d[n],t+1-STARTF);
            }
            else{
    		update_top_LR   <<<g_LR_grid, LRthreads, 0, stream_halo [n]>>>(      h_LR_A_d[n],      h_LR_B_d[n],f_inner_LR_A_d[n],h_LR_temp[n],omegaLR,LRpitch_elements,n,zLRInner);
    		update_bottom_LR<<<g_LR_grid, LRthreads, 0, stream_halo [n]>>>(      g_LR_A_d[n],      g_LR_B_d[n],f_inner_LR_A_d[n],g_LR_temp[n],omegaLR,LRpitch_elements,n,zLRInner);
            }
            }
            for(int n = 0; n<GPU_N; n++)
    		cudaStreamSynchronize(stream_halo[n]);
            for(int n = 0; n<GPU_N; n++){
    		cudaSetDevice(n);
            if(t+1>=STARTF){
    		update_inner_LR_force <<<  LRgrid,  LRthreads, 0, stream_inner[n]>>>(f_inner_LR_A_d[n],f_inner_LR_B_d[n],      g_LR_A_d[n], h_LR_A_d[n],omegaLR,LRpitch_elements,n,zLRInner,FX_d[n],FY_d[n],FZ_d[n],t+1-STARTF,uAvLR_d[n],vAvLR_d[n],uFlucLR_d[n],vFlucLR_d[n],t+1);
            }
            else{
    		update_inner_LR <<<  LRgrid,  LRthreads, 0, stream_inner[n]>>>(f_inner_LR_A_d[n],f_inner_LR_B_d[n],      g_LR_A_d[n], h_LR_A_d[n],omegaLR,LRpitch_elements,n,zLRInner,uAvLR_d[n],vAvLR_d[n],uFlucLR_d[n],vFlucLR_d[n],t+1);
            }
            }
            for(int n = 0; n<GPU_N; n++){
    		cudaMemcpyPeerAsync(&h_LR_temp[n][LRpitch_elements*YLRDIM*14],n,&g_LR_B_d[   (n+1)%GPU_N][LRpitch_elements*YLRDIM*14],   (n+1)%GPU_N,LRpitch_elements*YLRDIM*sizeof(float)*5,stream_halo[n]);
    		cudaMemcpyPeerAsync(&g_LR_temp[n][LRpitch_elements*YLRDIM*9 ],n,&h_LR_B_d[abs(n-1)%GPU_N][LRpitch_elements*YLRDIM*9 ],abs(n-1)%GPU_N,LRpitch_elements*YLRDIM*sizeof(float)*5,stream_halo[n]);
            }
 
            for(int n = 0; n<GPU_N; n++){
    		cudaSetDevice(n);
    		cudaDeviceSynchronize();
            }
            
            for(int n = 0; n<GPU_N; n++){
    		cudaSetDevice(n);
    		update_top_LR_interp   <<<g_LR_grid, LRthreads, 0, stream_halo [n]>>>(h_LR_B_d[n],h_LR_A_d[n],f_inner_LR_B_d[n],h_LR_temp[n],h_A_d[n],h_temp[n],omegaLR,omega,LRpitch_elements,zLRInner,pitch_elements,zInner,SF_cf,n);
    		update_bottom_LR_interp<<<g_LR_grid, LRthreads, 0, stream_halo [n]>>>(g_LR_B_d[n],g_LR_A_d[n],f_inner_LR_B_d[n],g_LR_temp[n],g_A_d[n],g_temp[n],omegaLR,omega,LRpitch_elements,zLRInner,pitch_elements,zInner,SF_cf,n);
            }
            for(int n = 0; n<GPU_N; n++)
    		cudaStreamSynchronize(stream_halo[n]);
            for(int n = 0; n<GPU_N; n++){
    		cudaSetDevice(n);
    		update_inner_LR_interp <<<LRgrid,LRthreads,0,stream_inner[n]>>>(f_inner_LR_B_d[n],f_inner_LR_A_d[n],g_LR_B_d[n],h_LR_B_d[n],f_inner_A_d[n],g_A_d[n],h_A_d[n],omegaLR,omega,LRpitch_elements,zLRInner,pitch_elements,zInner,SF_cf,n,uAvLR_d[n],vAvLR_d[n],uFlucLR_d[n],vFlucLR_d[n],t+1.5f);
            }
            for(int n = 0; n<GPU_N; n++){
    		cudaMemcpyPeerAsync(&h_LR_temp[n][LRpitch_elements*YLRDIM*14],n,&g_LR_A_d[   (n+1)%GPU_N][LRpitch_elements*YLRDIM*14],   (n+1)%GPU_N,LRpitch_elements*YLRDIM*sizeof(float)*5,stream_halo[n]);
    		cudaMemcpyPeerAsync(&g_LR_temp[n][LRpitch_elements*YLRDIM*9 ],n,&h_LR_A_d[abs(n-1)%GPU_N][LRpitch_elements*YLRDIM*9 ],abs(n-1)%GPU_N,LRpitch_elements*YLRDIM*sizeof(float)*5,stream_halo[n]);
            }
    
            for(int n = 0; n<GPU_N; n++){
    		cudaSetDevice(n);
            f_Extract<<<grid,threads,0,stream_inner[n]>>>(f_inner_A_d[n],f_inner_LR_A_d[n],g_LR_A_d[n],h_LR_A_d[n],pitch_elements,LRpitch_elements,zInner,zLRInner,omegaLR,SF_fc,n);
            g_Extract<<<grid,threads,0,stream_inner[n]>>>(g_A_d[n],f_inner_LR_A_d[n],g_LR_A_d[n],pitch_elements,LRpitch_elements,zInner,zLRInner,omegaLR,SF_fc,n);
            h_Extract<<<grid,threads,0,stream_inner[n]>>>(h_A_d[n],f_inner_LR_A_d[n],h_LR_A_d[n],pitch_elements,LRpitch_elements,zInner,zLRInner,omegaLR,SF_fc,n);
            }
        }
        for(int n = 0; n<GPU_N; n++){
		cudaSetDevice(n);
		cudaDeviceSynchronize();
        }

    }//end Time loop

	cudaDeviceSynchronize();
	gettimeofday (&tdr1,NULL);
	timeval_subtract (&restime, &tdr1, &tdr0);
	int Nodes;
	Nodes = XDIM*YDIM*ZDIM;
    if (REFINEMENT == 1)
        Nodes += XLRDIM*YLRDIM*ZLRDIM*LRLEVEL;
	cout<<"Time taken for main kernel: "<<restime<<" ("
			<<double(Nodes*double(TMAX/1000000.f))/restime<<"MLUPS)\n";


    //D2H Memcpy and write results
    for(int n = 0; n<GPU_N; n++){
    cudaSetDevice(n);
    if(outputflag == 1){
	output<<"VARIABLES = \"X\",\"Y\",\"Z\",\"u\",\"v\",\"w\",\"rho\",\"uAv\",\"vAv\",\"ufluc\",\"vfluc\"\n";
	output<<"ZONE F=POINT, I="<<XDIM<<", J="<<YDIM<<", K="<<ZDIM/GPU_N<<"\n";

	cudaMemcpy2D(f_inner_h[n],XDIM*sizeof(float),f_inner_A_d[n],pitch,XDIM*sizeof(float),YDIM*zInner*19,cudaMemcpyDeviceToHost);
	cudaMemcpy2D(      g_h[n],XDIM*sizeof(float),      g_A_d[n],pitch,XDIM*sizeof(float),YDIM*       19,cudaMemcpyDeviceToHost);
	cudaMemcpy2D(      h_h[n],XDIM*sizeof(float),      h_A_d[n],pitch,XDIM*sizeof(float),YDIM*       19,cudaMemcpyDeviceToHost);

	cudaMemcpy2D(uAv_h[n],XDIM*sizeof(float),uAv_d[n],pitch,XDIM*sizeof(float),YDIM*ZDIM/GPU_N,cudaMemcpyDeviceToHost);
	cudaMemcpy2D(vAv_h[n],XDIM*sizeof(float),vAv_d[n],pitch,XDIM*sizeof(float),YDIM*ZDIM/GPU_N,cudaMemcpyDeviceToHost);
	cudaMemcpy2D(wAv_h[n],XDIM*sizeof(float),wAv_d[n],pitch,XDIM*sizeof(float),YDIM*ZDIM/GPU_N,cudaMemcpyDeviceToHost);
	cudaMemcpy2D(uFluc_h[n],XDIM*sizeof(float),uFluc_d[n],pitch,XDIM*sizeof(float),YDIM*ZDIM/GPU_N,cudaMemcpyDeviceToHost);
	cudaMemcpy2D(vFluc_h[n],XDIM*sizeof(float),vFluc_d[n],pitch,XDIM*sizeof(float),YDIM*ZDIM/GPU_N,cudaMemcpyDeviceToHost);
	cudaMemcpy2D(wFluc_h[n],XDIM*sizeof(float),wFluc_d[n],pitch,XDIM*sizeof(float),YDIM*ZDIM/GPU_N,cudaMemcpyDeviceToHost);

	cudaMemcpy(     FX_h[n],FX_d[n],sizeof(float)*ForceTime,cudaMemcpyDeviceToHost);
	cudaMemcpy(     FY_h[n],FY_d[n],sizeof(float)*ForceTime,cudaMemcpyDeviceToHost);
	cudaMemcpy(     FZ_h[n],FZ_d[n],sizeof(float)*ForceTime,cudaMemcpyDeviceToHost);

    WriteResults(output,f_inner_h[n],g_h[n],h_h[n],uAv_h[n],vAv_h[n],wAv_h[n],uFluc_h[n],vFluc_h[n],wFluc_h[n],omega,GPU_N,n);
    output<<endl;

    //Write results
//    WriteResults(      g_h[n],output,omega,XDIM,YDIM,ZDIM/GPU_N*n      ,1     ,0,0,0,1);
//    WriteResults(f_inner_h[n],output,omega,XDIM,YDIM,ZDIM/GPU_N*n+1    ,zInner,0,0,0,1);
//    WriteResults(      h_h[n],output,omega,XDIM,YDIM,ZDIM/GPU_N*(n+1)-1,1     ,0,0,0,1);
    }
    for(int i=0;i<ForceTime;i++){
        FX_total[i] += FX_h[n][i];
        FY_total[i] += FY_h[n][i];
        FZ_total[i] += FZ_h[n][i];
    }

	cudaFree(f_inner_A_d[n]);
	cudaFree(f_inner_B_d[n]);
	cudaFree(      g_A_d[n]);
	cudaFree(      g_B_d[n]);
	cudaFree(      h_A_d[n]);
	cudaFree(      h_B_d[n]);
	cudaFree(     g_temp[n]);
	cudaFree(     h_temp[n]);
	cudaFree(      uAv_d[n]);
	cudaFree(      vAv_d[n]);
	cudaFree(      wAv_d[n]);
	cudaFree(    uFluc_d[n]);
	cudaFree(    vFluc_d[n]);
	cudaFree(    wFluc_d[n]);
    }//end write results
    WriteForces(FX_total,FY_total,FZ_total,outputForce,ForceTime,REFINEMENT*LRLEVEL);


    if(REFINEMENT == 1){
	output<<"VARIABLES = \"X\",\"Y\",\"Z\",\"u\",\"v\",\"w\",\"rho\",\"uAv\",\"vAv\",\"ufluc\",\"vfluc\"\n";
	output<<"ZONE F=POINT, I="<<XLRDIM<<", J="<<YLRDIM<<", K="<<ZLRDIM<<"\n";

    for(int n = 0; n<GPU_N; n++){
    cudaSetDevice(n);

    if(outputflag == 1){
	cudaMemcpy2D(f_inner_LR_h[n],XLRDIM*sizeof(float),f_inner_LR_A_d[n],LRpitch,XLRDIM*sizeof(float),YLRDIM*zLRInner*19,cudaMemcpyDeviceToHost);
	cudaMemcpy2D(      g_LR_h[n],XLRDIM*sizeof(float),      g_LR_A_d[n],LRpitch,XLRDIM*sizeof(float),YLRDIM*         19,cudaMemcpyDeviceToHost);
	cudaMemcpy2D(      h_LR_h[n],XLRDIM*sizeof(float),      h_LR_A_d[n],LRpitch,XLRDIM*sizeof(float),YLRDIM*         19,cudaMemcpyDeviceToHost);
	
    cudaMemcpy2D(  uAvLR_h[n],XLRDIM*sizeof(float),  uAvLR_d[n],LRpitch,XLRDIM*sizeof(float),YLRDIM*ZLRDIM/GPU_N,cudaMemcpyDeviceToHost);
	cudaMemcpy2D(  vAvLR_h[n],XLRDIM*sizeof(float),  vAvLR_d[n],LRpitch,XLRDIM*sizeof(float),YLRDIM*ZLRDIM/GPU_N,cudaMemcpyDeviceToHost);
	cudaMemcpy2D(  wAvLR_h[n],XLRDIM*sizeof(float),  wAvLR_d[n],LRpitch,XLRDIM*sizeof(float),YLRDIM*ZLRDIM/GPU_N,cudaMemcpyDeviceToHost);
	cudaMemcpy2D(uFlucLR_h[n],XLRDIM*sizeof(float),uFlucLR_d[n],LRpitch,XLRDIM*sizeof(float),YLRDIM*ZLRDIM/GPU_N,cudaMemcpyDeviceToHost);
	cudaMemcpy2D(vFlucLR_h[n],XLRDIM*sizeof(float),vFlucLR_d[n],LRpitch,XLRDIM*sizeof(float),YLRDIM*ZLRDIM/GPU_N,cudaMemcpyDeviceToHost);
	cudaMemcpy2D(wFlucLR_h[n],XLRDIM*sizeof(float),wFlucLR_d[n],LRpitch,XLRDIM*sizeof(float),YLRDIM*ZLRDIM/GPU_N,cudaMemcpyDeviceToHost);

    WriteResultsLR(output,f_inner_LR_h[n],g_LR_h[n],h_LR_h[n],uAvLR_h[n],vAvLR_h[n],wAvLR_h[n],uFlucLR_h[n],vFlucLR_h[n],wFlucLR_h[n],omegaLR,GPU_N,n);
    //Write results
//    WriteResults(      g_LR_h[n],output,omega,XLRDIM,YLRDIM,ZLRDIM/GPU_N*n      ,1       ,LRX0,LRY0,LRZ0,LRFACTOR);
//    WriteResults(f_inner_LR_h[n],output,omega,XLRDIM,YLRDIM,ZLRDIM/GPU_N*n+1    ,zLRInner,LRX0,LRY0,LRZ0,LRFACTOR);
//    WriteResults(      h_LR_h[n],output,omega,XLRDIM,YLRDIM,ZLRDIM/GPU_N*(n+1)-1,1       ,LRX0,LRY0,LRZ0,LRFACTOR);
    }

	cudaFree(f_inner_LR_A_d[n]);
	cudaFree(f_inner_LR_B_d[n]);
	cudaFree(      g_LR_A_d[n]);
	cudaFree(      g_LR_B_d[n]);
	cudaFree(      h_LR_A_d[n]);
	cudaFree(      h_LR_B_d[n]);
	cudaFree(     g_LR_temp[n]);
	cudaFree(     h_LR_temp[n]);
    }//end GPU loop for LR
    }//end write results of LR

	return(0);

}
