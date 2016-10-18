#include <cuda.h>
//#include <cutil.h>
#include <iostream>
#include <ostream>
#include <fstream>
//#include "/home/yusuke/NVIDIA_GPU_Computing_SDK/C/common/inc/cutil.h"
using namespace std;
	
#define CASENAME "test"

#define BLOCKSIZEX 64
#define BLOCKSIZEY 1
#define BLOCKSIZELRX 64
#define BLOCKSIZELRY 1
#define XDIM 256
#define YDIM 128
#define TMAX 1000
#define OBSTR 8.f
#define OBSTX 128.f
#define OBSTY 64.f

#define STARTF 10

#define LRFACTOR 0.5f
#define LRLEVEL  2 //inverse of LRFACTOR as an integer
#define LRX0 111.75	//minimum x coord of LR
#define XLRDIM 128	//number of nodes in x
#define LRY0 111.75
#define YLRDIM 128

#define RE 20.f
#define UMAX 0.06f
#define METHOD "HYB" //LR,SINGLE,HYB,TEXT,SHARED,SINGLEF,TEST
#define REFINEMENT "NO" //YES,NO
#define MODEL "MRT" //BGK,MRT,STREAM
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
2  Neumann East
3  Dirichlet West
10 BB(force)
11 xsymmetry(y=max)
12 xsymmetry(y=min)

*/
inline __device__ int ImageFcn(float x, float y){
	//if(y < 0.1f || (XDIM-x) < 1.1f || (YDIM-y) < 1.1f)
//	if(y < 0.1f || (YDIM-y) < 1.1f)
//		return 1;
//	else if(x < 0.1f)
//		return 3;//west
//	else if((XDIM-x) < 1.1f)
//		return 2;//east
//	else if((x-OBSTX)*(x-OBSTX)+(y-OBSTY)*(y-OBSTY)<OBSTR*OBSTR)
	//if((x-OBSTX)*(x-OBSTX)+(y-OBSTY)*(y-OBSTY)<OBSTR*OBSTR)
	if(abs(x-OBSTX)<OBSTR && abs(y-OBSTY)<OBSTR)
		return 10;
	else
		return 0;
}

inline __device__ int ImageFcn(int x, int y){
	//if(y == 0 || x == XDIM-1 || y == YDIM-1)
	if(x < 0.1f)
		return 1;//3;//west
	else if((XDIM-x) < 1.1f)
		return 1;//2;//east
	else if((YDIM-y) < 1.1f)
		return 1;//11;//xsymmetry top
	else if(y < 0.1f)
		return 1;//12;//xsymmetry bottom
	//else if((x-OBSTX)*(x-OBSTX)+(y-OBSTY)*(y-OBSTY)<OBSTR*OBSTR)
	if(abs(x-OBSTX)<OBSTR && abs(y-OBSTY)<OBSTR)
		return 1;//10;
	else
		return 0;
}

inline __device__ float PoisProf (float x){
	float radius = (YDIM-1-1)*0.5f;
	float result = -1.0f*(((1.0f-(x-0.5f)/radius))*((1.0f-(x-0.5f)/radius))-1.0f);
	return (result);
//	return 1.f;
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

texture<float,2,cudaReadModeElementType> texRef_f0B;
texture<float,2,cudaReadModeElementType> texRef_f1B;
texture<float,2,cudaReadModeElementType> texRef_f2B;
texture<float,2,cudaReadModeElementType> texRef_f3B;
texture<float,2,cudaReadModeElementType> texRef_f4B;
texture<float,2,cudaReadModeElementType> texRef_f5B;
texture<float,2,cudaReadModeElementType> texRef_f6B;
texture<float,2,cudaReadModeElementType> texRef_f7B;
texture<float,2,cudaReadModeElementType> texRef_f8B;

texture<float,2,cudaReadModeElementType> texRef_f0C;
texture<float,2,cudaReadModeElementType> texRef_f1C;
texture<float,2,cudaReadModeElementType> texRef_f2C;
texture<float,2,cudaReadModeElementType> texRef_f3C;
texture<float,2,cudaReadModeElementType> texRef_f4C;
texture<float,2,cudaReadModeElementType> texRef_f5C;
texture<float,2,cudaReadModeElementType> texRef_f6C;
texture<float,2,cudaReadModeElementType> texRef_f7C;
texture<float,2,cudaReadModeElementType> texRef_f8C;

texture<float,2,cudaReadModeElementType> texRef_f0D;
texture<float,2,cudaReadModeElementType> texRef_f1D;
texture<float,2,cudaReadModeElementType> texRef_f2D;
texture<float,2,cudaReadModeElementType> texRef_f3D;
texture<float,2,cudaReadModeElementType> texRef_f4D;
texture<float,2,cudaReadModeElementType> texRef_f5D;
texture<float,2,cudaReadModeElementType> texRef_f6D;
texture<float,2,cudaReadModeElementType> texRef_f7D;
texture<float,2,cudaReadModeElementType> texRef_f8D;


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
					float& f6 , float& f7 , float& f8 ,  float omega)
{
	float rho,u,v;	
	rho = f0+f1+f2+f3+f4+f5+f6+f7+f8;
	u = f1-f3+f5-f6-f7+f8;
	v = f2-f4+f5+f6-f7-f8;
	float usqr = u*u+v*v;
	f0 = f0 -omega*(f0 -0.4444444444f*(rho-1.5f*usqr));
	f1 = f1 -omega*(f1 -0.1111111111f*(rho+3.0f*u+4.5f*u*u-1.5f*usqr));                
	f2 = f2 -omega*(f2 -0.1111111111f*(rho+3.0f*v+4.5f*v*v-1.5f*usqr));
	f3 = f3 -omega*(f3 -0.1111111111f*(rho-3.0f*u+4.5f*u*u-1.5f*usqr));
	f4 = f4 -omega*(f4 -0.1111111111f*(rho-3.0f*v+4.5f*v*v-1.5f*usqr));
	f5 = f5 -omega*(f5 -0.02777777778*(rho+3.0f*( u+v)+4.5f*( u+v)*( u+v)-1.5f*usqr));
	f6 = f6 -omega*(f6 -0.02777777778*(rho+3.0f*(-u+v)+4.5f*(-u+v)*(-u+v)-1.5f*usqr));
	f7 = f7 -omega*(f7 -0.02777777778*(rho+3.0f*(-u-v)+4.5f*(-u-v)*(-u-v)-1.5f*usqr));
	f8 = f8 -omega*(f8 -0.02777777778*(rho+3.0f*( u-v)+4.5f*( u-v)*( u-v)-1.5f*usqr));
}

__device__ void mrt_collide(float &f0, float &f1, float &f2,
						   float &f3, float &f4, float &f5,
						   float &f6, float &f7, float &f8, float omega)
{
	//float rho,u,v;	
	float u,v;	
	//rho = f0+f1+f2+f3+f4+f5+f6+f7+f8;
	u = f1-f3+f5-f6-f7+f8;
	v = f2-f4+f5+f6-f7-f8;
	float m1,m2,m4,m6,m7,m8;

//	m1 =-4.f*f0 -    f1 -    f2 -    f3 -    f4+ 2.f*f5+ 2.f*f6+ 2.f*f7+ 2.f*f8-(-2.0f*rho+3.0f*(u*u+v*v));
	m1 =-2.f*f0 +    f1 +    f2 +    f3 +    f4+ 4.f*f5+ 4.f*f6+ 4.f*f7+ 4.f*f8-3.0f*(u*u+v*v);
	//m2 = 4.f*f0 -2.f*f1 -2.f*f2 -2.f*f3 -2.f*f4+     f5+     f6+     f7+     f8-(rho-3.0f*(u*u+v*v)); //ep
	m2 = 3.f*f0 -3.f*f1 -3.f*f2 -3.f*f3 -3.f*f4                                +3.0f*(u*u+v*v); //ep
	//m4 =        -2.f*f1        + 2.f*f3        +     f5 -    f6 -    f7+     f8-(-u);//qx_eq
	m4 =        -    f1        +     f3        + 2.f*f5 -2.f*f6 -2.f*f7+ 2.f*f8;//-(-u);//qx_eq
	m6 =                -    f2        +     f4+ 2.f*f5+ 2.f*f6 -2.f*f7 -2.f*f8;//-(-v);//qy_eq
	m7 =             f1 -    f2+     f3 -    f4                                -(u*u-v*v);//pxx_eq
	m8 =                                             f5 -    f6+     f7 -    f8-(u*v);//pxy_eq

//	m1 =-4.f*f0 -    f1 -    f2 -    f3 -    f4+ 2.f*f5+ 2.f*f6+ 2.f*f7+ 2.f*f8-(-2.0f*rho+3.0f*(u*u+v*v));
//	m2 = 4.f*f0 -2.f*f1 -2.f*f2 -2.f*f3 -2.f*f4+     f5+     f6+     f7+     f8-(rho-3.0f*(u*u+v*v)); //ep
//	m4 =        -2.f*f1        + 2.f*f3        +     f5 -    f6 -    f7+     f8-(-u);//qx_eq
//	m6 =                -2.f*f2        + 2.f*f4+     f5+     f6 -    f7 -    f8-(-v);//qy_eq
//	m7 =             f1 -    f2+     f3 -    f4                                -(u*u-v*v);//pxx_eq
//	m8 =                                             f5 -    f6+     f7 -    f8-(u*v);//pxy_eq

	f0=f0-(-m1+m2)*0.11111111f;//(-4.f*(m1)/36.0f+4.f *(m2)/36.0f);
	//f1=f1-(-m1-2.0f*(m2+m4)+m7*omega*9.0f)*0.027777777f;
	f1=f1-(-m1*0.027777777f-0.05555555556f*m2-0.16666666667f*m4+m7*omega*0.25f);
	f2=f2-(-m1*0.027777777f-0.05555555556f*m2-0.16666666667f*m6-m7*omega*0.25f);
	f3=f3-(-m1*0.027777777f-0.05555555556f*m2+0.16666666667f*m4+m7*omega*0.25f);
	f4=f4-(-m1*0.027777777f-0.05555555556f*m2+0.16666666667f*m6-m7*omega*0.25f);
	f5=f5-(0.05555555556f*m1+m2*0.027777777f+0.08333333333f*m4+0.08333333333f*m6+m8*omega*0.25f);
	f6=f6-(0.05555555556f*m1+m2*0.027777777f-0.08333333333f*m4+0.08333333333f*m6-m8*omega*0.25f);
	f7=f7-(0.05555555556f*m1+m2*0.027777777f-0.08333333333f*m4-0.08333333333f*m6+m8*omega*0.25f);
	f8=f8-(0.05555555556f*m1+m2*0.027777777f+0.08333333333f*m4-0.08333333333f*m6-m8*omega*0.25f);
//	f1=f1-(-m1-2.f*m2-6.f*m4+m7*omega*9.0f)*0.027777777f;
//	f2=f2-(-m1-2.f*m2-6.f*m6-m7*omega*9.0f)*0.027777777f;
//	f3=f3-(-m1-2.f*m2+6.f*m4+m7*omega*9.0f)*0.027777777f;
//	f4=f4-(-m1-2.f*m2+6.f*m6-m7*omega*9.0f)*0.027777777f;
//	f5=f5-(2.f*m1+m2+3.f*m4+3.f*m6+m8*omega*9.0f)*0.027777777f;
//	f6=f6-(2.f*m1+m2-3.f*m4+3.f*m6-m8*omega*9.0f)*0.027777777f;
//	f7=f7-(2.f*m1+m2-3.f*m4-3.f*m6+m8*omega*9.0f)*0.027777777f;
//	f8=f8-(2.f*m1+m2+3.f*m4-3.f*m6-m8*omega*9.0f)*0.027777777f;
}

__device__ void NeumannEast(float &f0, float &f1, float &f2,
						   float &f3, float &f4, float &f5,
						   float &f6, float &f7, float &f8, int y)
{
	if(y == 0){
		f2 = f4;
		f5 = f8;
	}
	else if(y == YDIM-1){
		f4 = f2;
		f8 = f5;
	}
	float u,v,rho;
    v = 0.0;
    rho = 1.0;
	u = -rho+((f0+f2+f4)+2.0f*f1+2.0f*f5+2.0f*f8);

    f3 = f1-u*0.66666667f;
    f7 = f5+0.5f*(f2-f4)-0.5f*v-u*0.16666667f;
    f6 = f8-0.5f*(f2-f4)+0.5f*v-u*0.16666667f;
}
__device__ void DirichletWest(float &f0, float &f1, float &f2,
						   float &f3, float &f4, float &f5,
						   float &f6, float &f7, float &f8, int y)
{
	if(y == 0){
		f2 = f4;
		f6 = f7;
	}
	else if(y == YDIM-1){
		f4 = f2;
		f7 = f6;
	}
	float u,v;//,rho;
	u = UMAX;//*PoisProf(float(y));
	v = 0.0f;//0.0;
	f1 = f3+u*0.66666667f;
	f5 = f7-0.5f*(f2-f4)+v*0.5f+u*0.166666667f;
	f8 = f6+0.5f*(f2-f4)-v*0.5f+u*0.166666667f;	
}




__device__ void boundaries(float& f0, float& f1, float& f2,
					float& f3 , float& f4 , float& f5 ,
					float& f6 , float& f7 , float& f8 ,
					int y, int im)
{
	if(im == 2)//NeumannEast
	{
		NeumannEast(f0,f1,f2,f3,f4,f5,f6,f7,f8,y);
	}
	else if(im == 3)//DirichletWest
	{
		DirichletWest(f0,f1,f2,f3,f4,f5,f6,f7,f8,y);
	}
	else if(im == 11)//xsymmetry
	{
		f4 = f2;
		f7 = f6;
		f8 = f5;
	}
	else if(im == 12)//xsymmetry
	{
		f2 = f4;
		f6 = f7;
		f5 = f8;
	}
}


__device__ void boundaries_force(float& f0, float& f1, float& f2,
					float& f3 , float& f4 , float& f5 ,
					float& f6 , float& f7 , float& f8 ,
					int y, int im)
{
	if(im == 2)//NeumannEast
	{
		NeumannEast(f0,f1,f2,f3,f4,f5,f6,f7,f8,y);
	}
	else if(im == 3)//DirichletWest
	{
		DirichletWest(f0,f1,f2,f3,f4,f5,f6,f7,f8,y);
	}
	if(im == 11)//xsymmetry
	{
		f4 = f2;
		f7 = f6;
		f8 = f5;
	}
	else if(im == 12)//xsymmetry
	{
		f2 = f4;
		f6 = f7;
		f5 = f8;
	}
}


inline __device__ int f_mem(int f_num, int x, int y, size_t pitch)
{

	return (x+y*pitch)+f_num*pitch*YDIM;
}

inline __device__ int f_memLR(int f_num, int x, int y, size_t pitch)
{

	return (x+y*pitch)+f_num*pitch*YLRDIM;
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
	float f0,f1,f2,f3,f4,f5,f6,f7,f8;
//	if(x < LRX0+1 || x > LRX0+XLRDIM*LRFACTOR-1 || y < LRY0+1 || y > LRY0+YLRDIM*LRFACTOR-1)
////	if(x < LRX0+2 || x > LRX0+XLRDIM-3 || y < LRY0+2 || y > LRY0+YLRDIM-3)
//	{
//	//do nothing
//	}
//	else
	//if(x > LRX0+1 && x < LRX0+XLRDIM*LRFACTOR-1 && y > LRY0+1 && y < LRY0+YLRDIM*LRFACTOR-1)
	if( (x > LRX0+1 && x < LRX0+XLRDIM*LRFACTOR-1 && y > LRY0+1 && y < LRY0+YLRDIM*LRFACTOR-1) && 
	(x == int(LRX0+2) || x == int(LRX0+XLRDIM*LRFACTOR-1) || y == int(LRY0+2) || y == int(LRY0+YLRDIM*LRFACTOR-1)) )
	{
//	float xcoord = 2.0f*x-2.0f*LRX0+0.5f;
//	float ycoord = 2.0f*y-2.0f*LRY0+0.5f;
	float xcoord = (x-LRX0)/LRFACTOR+0.5f;
	float ycoord = (y-LRY0)/LRFACTOR+0.5f;
	f0 = tex2D(texRef_f0C ,xcoord,ycoord);
	f1 = tex2D(texRef_f1C ,xcoord,ycoord);
	f2 = tex2D(texRef_f2C ,xcoord,ycoord);
	f3 = tex2D(texRef_f3C ,xcoord,ycoord);
	f4 = tex2D(texRef_f4C ,xcoord,ycoord);
	f5 = tex2D(texRef_f5C ,xcoord,ycoord);
	f6 = tex2D(texRef_f6C ,xcoord,ycoord);
	f7 = tex2D(texRef_f7C ,xcoord,ycoord);
	f8 = tex2D(texRef_f8C ,xcoord,ycoord);

	float rho,u,v;	
	rho = f0+f1+f2+f3+f4+f5+f6+f7+f8;
	u = f1-f3+f5-f6-f7+f8;
	v = f2-f4+f5+f6-f7-f8;
	float usqr = u*u+v*v;
	//scale
//	f0 =SF*f0 +(1.0f-SF)*(0.4444444444f*rho-0.6666666667f*usqr);
//	f1 =SF*f1 +(1.0f-SF)*(0.1111111111f*rho+0.3333333333f*u+0.5f*u*u-0.1666666667f*usqr);                 
//	f2 =SF*f2 +(1.0f-SF)*(0.1111111111f*rho+0.3333333333f*v+0.5f*v*v-0.1666666667f*usqr);
//	f3 =SF*f3 +(1.0f-SF)*(0.1111111111f*rho-0.3333333333f*u+0.5f*u*u-0.1666666667f*usqr);
//	f4 =SF*f4 +(1.0f-SF)*(0.1111111111f*rho-0.3333333333f*v+0.5f*v*v-0.1666666667f*usqr);
//	f5 =SF*f5 +(1.0f-SF)*(0.02777777778*rho+0.08333333333f*( u+v)+0.125f*( u+v)*( u+v)-0.04166666667f*usqr);
//	f6 =SF*f6 +(1.0f-SF)*(0.02777777778*rho+0.08333333333f*(-u+v)+0.125f*(-u+v)*(-u+v)-0.04166666667f*usqr);
//	f7 =SF*f7 +(1.0f-SF)*(0.02777777778*rho+0.08333333333f*(-u-v)+0.125f*(-u-v)*(-u-v)-0.04166666667f*usqr);
//	f8 =SF*f8 +(1.0f-SF)*(0.02777777778*rho+0.08333333333f*( u-v)+0.125f*( u-v)*( u-v)-0.04166666667f*usqr);

	fout[f_mem(0 ,x,y,pitch)] =SF*f0 +(1.0f-SF)*(0.4444444444f*(rho-1.5f*usqr));
	fout[f_mem(1 ,x,y,pitch)] =SF*f1 +(1.0f-SF)*(0.1111111111f*(rho+3.0f*u+4.5f*u*u-1.5f*usqr));                 
	fout[f_mem(2 ,x,y,pitch)] =SF*f2 +(1.0f-SF)*(0.1111111111f*(rho+3.0f*v+4.5f*v*v-1.5f*usqr));
	fout[f_mem(3 ,x,y,pitch)] =SF*f3 +(1.0f-SF)*(0.1111111111f*(rho-3.0f*u+4.5f*u*u-1.5f*usqr));
	fout[f_mem(4 ,x,y,pitch)] =SF*f4 +(1.0f-SF)*(0.1111111111f*(rho-3.0f*v+4.5f*v*v-1.5f*usqr));
	fout[f_mem(5 ,x,y,pitch)] =SF*f5 +(1.0f-SF)*(0.02777777778*(rho+3.0f*( u+v)+4.5f*( u+v)*( u+v)-1.5f*usqr));
	fout[f_mem(6 ,x,y,pitch)] =SF*f6 +(1.0f-SF)*(0.02777777778*(rho+3.0f*(-u+v)+4.5f*(-u+v)*(-u+v)-1.5f*usqr));
	fout[f_mem(7 ,x,y,pitch)] =SF*f7 +(1.0f-SF)*(0.02777777778*(rho+3.0f*(-u-v)+4.5f*(-u-v)*(-u-v)-1.5f*usqr));
	fout[f_mem(8 ,x,y,pitch)] =SF*f8 +(1.0f-SF)*(0.02777777778*(rho+3.0f*( u-v)+4.5f*( u-v)*( u-v)-1.5f*usqr));
	
//	fout[f_mem(0 ,x,y,pitch)] = f0 ;
//	fout[f_mem(1 ,x,y,pitch)] = f1 ;
//	fout[f_mem(2 ,x,y,pitch)] = f2 ;
//	fout[f_mem(3 ,x,y,pitch)] = f3 ;
//	fout[f_mem(4 ,x,y,pitch)] = f4 ;
//	fout[f_mem(5 ,x,y,pitch)] = f5 ;
//	fout[f_mem(6 ,x,y,pitch)] = f6 ;
//	fout[f_mem(7 ,x,y,pitch)] = f7 ;
//	fout[f_mem(8 ,x,y,pitch)] = f8 ;
	}
}

__global__ void LR_d_hybABCD_force(float* fin, float* fout,
							float omega, size_t pitch, float *FX, float *FY, int t)//pitch in elements
{
	int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
	int y = threadIdx.y+blockIdx.y*blockDim.y;
	float xcoord = LRX0+x*LRFACTOR;
	float ycoord = LRY0+y*LRFACTOR;
	int j = x+y*pitch;//index on padded mem (pitch in elements)
	int im = ImageFcn(xcoord,ycoord);
	float f0,f1,f2,f3,f4,f5,f6,f7,f8;
	__shared__ float sumX[BLOCKSIZEX], sumY[BLOCKSIZEX];
	__shared__ int check[1];
	check[0] = 0;
	syncthreads();

	if(x < 1 || x > XLRDIM-2 || y < 1 || y > YLRDIM-2)
	{
	sumX[threadIdx.x]=0.f;
	sumY[threadIdx.x]=0.f;
	//dont do anything
	}
	else{
//	if(x != 0 && x != XLRDIM-1 && y != 0 && y != YLRDIM-1){
	f0 = fin[j];
	f2 = fin[f_memLR(2 ,x  ,y-1,pitch)];
	f4 = fin[f_memLR(4 ,x  ,y+1,pitch)];
	f1 = tex2D(texRef_f1C ,x-1+0.5f,y  +0.5f);
	f3 = tex2D(texRef_f3C ,x+1+0.5f,y  +0.5f);
	f5 = tex2D(texRef_f5C ,x-1+0.5f,y-1+0.5f);
	f6 = tex2D(texRef_f6C ,x+1+0.5f,y-1+0.5f);
	f7 = tex2D(texRef_f7C ,x+1+0.5f,y+1+0.5f);
	f8 = tex2D(texRef_f8C ,x-1+0.5f,y+1+0.5f);

	if(im == 1 || im == 10){//BB
		if(im == 10){
		check[0] = 1;
		sumX[threadIdx.x]=2.f*f1-2.f*f3+2.f*f5+2.f*f8-2.f*f6-2.f*f7;
		sumY[threadIdx.x]=2.f*f2-2.f*f4+2.f*f5-2.f*f8+2.f*f6-2.f*f7;
		}
		else{
		sumX[threadIdx.x]=0.f;
		sumY[threadIdx.x]=0.f;
		}

		fout[f_memLR(1 ,x,y,pitch)] = f3 ;
		fout[f_memLR(2 ,x,y,pitch)] = f4 ;
		fout[f_memLR(3 ,x,y,pitch)] = f1 ;
		fout[f_memLR(4 ,x,y,pitch)] = f2 ;
		fout[f_memLR(5 ,x,y,pitch)] = f7 ;
		fout[f_memLR(6 ,x,y,pitch)] = f8 ;
		fout[f_memLR(7 ,x,y,pitch)] = f5 ;
		fout[f_memLR(8 ,x,y,pitch)] = f6 ;
	}
	else{
		sumX[threadIdx.x]=0.f;
		sumY[threadIdx.x]=0.f;
		if(MODEL == "MRT")
		mrt_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,omega);
		else if(MODEL == "BGK")
		bgk_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,omega);
		fout[f_memLR(0 ,x,y,pitch)] = f0 ;
		fout[f_memLR(1 ,x,y,pitch)] = f1 ;
		fout[f_memLR(2 ,x,y,pitch)] = f2 ;
		fout[f_memLR(3 ,x,y,pitch)] = f3 ;
		fout[f_memLR(4 ,x,y,pitch)] = f4 ;
		fout[f_memLR(5 ,x,y,pitch)] = f5 ;
		fout[f_memLR(6 ,x,y,pitch)] = f6 ;
		fout[f_memLR(7 ,x,y,pitch)] = f7 ;
		fout[f_memLR(8 ,x,y,pitch)] = f8 ;
	}

	}//end else (not at edge of LR)

	syncthreads();
	if(check[0] == 1 && t>STARTF){
	//reduction for force
	int nTotalThreads = blockDim.x;
	while(nTotalThreads > 1){
		int halfPoint = (nTotalThreads >> 1);
		if(threadIdx.x < halfPoint){
			sumX[threadIdx.x] += sumX[threadIdx.x+halfPoint];
			sumY[threadIdx.x] += sumY[threadIdx.x+halfPoint];
		}
		syncthreads();
		nTotalThreads = halfPoint;
	}
	if(threadIdx.x == 0){
		atomicAdd(&FX[t],sumX[0]);
		atomicAdd(&FY[t],sumY[0]);
	}
	}

}

__global__ void LR_d_hybBACD_force(float* fin, float* fout,
							float omega, size_t pitch, float *FX, float *FY, int t)//pitch in elements
{
	int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
	int y = threadIdx.y+blockIdx.y*blockDim.y;
	float xcoord = LRX0+x*LRFACTOR;
	float ycoord = LRY0+y*LRFACTOR;
	int j = x+y*pitch;//index on padded mem (pitch in elements)
	int im = ImageFcn(xcoord,ycoord);
	float f0,f1,f2,f3,f4,f5,f6,f7,f8;
	__shared__ float sumX[BLOCKSIZEX], sumY[BLOCKSIZEX];
	__shared__ int check[1];
	check[0] = 0;
	syncthreads();

	if(x < 1 || x > XLRDIM-2 || y < 1 || y > YLRDIM-2)
	{
	sumX[threadIdx.x]=0.f;
	sumY[threadIdx.x]=0.f;
	//dont do anything
	}
	else{
//	if(x != 0 && x != XLRDIM-1 && y != 0 && y != YLRDIM-1){
	f0 = fin[j];
	f2 = fin[f_memLR(2 ,x  ,y-1,pitch)];
	f4 = fin[f_memLR(4 ,x  ,y+1,pitch)];
	f1 = tex2D(texRef_f1C ,x-1+0.5f,y  +0.5f);
	f3 = tex2D(texRef_f3C ,x+1+0.5f,y  +0.5f);
	f5 = tex2D(texRef_f5C ,x-1+0.5f,y-1+0.5f);
	f6 = tex2D(texRef_f6C ,x+1+0.5f,y-1+0.5f);
	f7 = tex2D(texRef_f7C ,x+1+0.5f,y+1+0.5f);
	f8 = tex2D(texRef_f8C ,x-1+0.5f,y+1+0.5f);

	if(im == 1 || im == 10){//BB
		if(im == 10){
		check[0] = 1;
		sumX[threadIdx.x]=2.f*f1-2.f*f3+2.f*f5+2.f*f8-2.f*f6-2.f*f7;
		sumY[threadIdx.x]=2.f*f2-2.f*f4+2.f*f5-2.f*f8+2.f*f6-2.f*f7;
		}
		else{
		sumX[threadIdx.x]=0.f;
		sumY[threadIdx.x]=0.f;
		}

		fout[f_memLR(1 ,x,y,pitch)] = f3 ;
		fout[f_memLR(2 ,x,y,pitch)] = f4 ;
		fout[f_memLR(3 ,x,y,pitch)] = f1 ;
		fout[f_memLR(4 ,x,y,pitch)] = f2 ;
		fout[f_memLR(5 ,x,y,pitch)] = f7 ;
		fout[f_memLR(6 ,x,y,pitch)] = f8 ;
		fout[f_memLR(7 ,x,y,pitch)] = f5 ;
		fout[f_memLR(8 ,x,y,pitch)] = f6 ;
	}
	else{
		sumX[threadIdx.x]=0.f;
		sumY[threadIdx.x]=0.f;
		if(MODEL == "MRT")
		mrt_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,omega);
		else if(MODEL == "BGK")
		bgk_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,omega);
		fout[f_memLR(0 ,x,y,pitch)] = f0 ;
		fout[f_memLR(1 ,x,y,pitch)] = f1 ;
		fout[f_memLR(2 ,x,y,pitch)] = f2 ;
		fout[f_memLR(3 ,x,y,pitch)] = f3 ;
		fout[f_memLR(4 ,x,y,pitch)] = f4 ;
		fout[f_memLR(5 ,x,y,pitch)] = f5 ;
		fout[f_memLR(6 ,x,y,pitch)] = f6 ;
		fout[f_memLR(7 ,x,y,pitch)] = f7 ;
		fout[f_memLR(8 ,x,y,pitch)] = f8 ;
	}
	}//end else (not at edge of LR)

	syncthreads();
	if(check[0] == 1 && t>=STARTF){
	//reduction for force
	int nTotalThreads = blockDim.x;
	while(nTotalThreads > 1){
		int halfPoint = (nTotalThreads >> 1);
		if(threadIdx.x < halfPoint){
			sumX[threadIdx.x] += sumX[threadIdx.x+halfPoint];
			sumY[threadIdx.x] += sumY[threadIdx.x+halfPoint];
		}
		syncthreads();
		nTotalThreads = halfPoint;
	}
	if(threadIdx.x == 0){
		atomicAdd(&FX[t],sumX[0]);
		atomicAdd(&FY[t],sumY[0]);
	}
	}

}



__global__ void LR_d_hybABCD(float* fin, float* fout,
							float omega, size_t pitch)//pitch in elements
{
	int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
	int y = threadIdx.y+blockIdx.y*blockDim.y;
	float xcoord = LRX0+x*LRFACTOR;
	float ycoord = LRY0+y*LRFACTOR;
	int j = x+y*pitch;//index on padded mem (pitch in elements)
	int im = ImageFcn(xcoord,ycoord);
	float f0,f1,f2,f3,f4,f5,f6,f7,f8;

	if(x < 1 || x > XLRDIM-2 || y < 1 || y > YLRDIM-2)
	{
	//dont do anything
	}
	else{
	f0 = fin[j];
	f2 = fin[f_memLR(2 ,x  ,y-1,pitch)];
	f4 = fin[f_memLR(4 ,x  ,y+1,pitch)];
	f1 = tex2D(texRef_f1C ,x-1+0.5f,y  +0.5f);
	f3 = tex2D(texRef_f3C ,x+1+0.5f,y  +0.5f);
	f5 = tex2D(texRef_f5C ,x-1+0.5f,y-1+0.5f);
	f6 = tex2D(texRef_f6C ,x+1+0.5f,y-1+0.5f);
	f7 = tex2D(texRef_f7C ,x+1+0.5f,y+1+0.5f);
	f8 = tex2D(texRef_f8C ,x-1+0.5f,y+1+0.5f);

	if(im == 1 || im == 10){//BB
		fout[f_memLR(1 ,x,y,pitch)] = f3 ;
		fout[f_memLR(2 ,x,y,pitch)] = f4 ;
		fout[f_memLR(3 ,x,y,pitch)] = f1 ;
		fout[f_memLR(4 ,x,y,pitch)] = f2 ;
		fout[f_memLR(5 ,x,y,pitch)] = f7 ;
		fout[f_memLR(6 ,x,y,pitch)] = f8 ;
		fout[f_memLR(7 ,x,y,pitch)] = f5 ;
		fout[f_memLR(8 ,x,y,pitch)] = f6 ;
	}
	else{
		if(MODEL == "MRT")
		mrt_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,omega);
		else if(MODEL == "BGK")
		bgk_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,omega);
		fout[f_memLR(0 ,x,y,pitch)] = f0 ;
		fout[f_memLR(1 ,x,y,pitch)] = f1 ;
		fout[f_memLR(2 ,x,y,pitch)] = f2 ;
		fout[f_memLR(3 ,x,y,pitch)] = f3 ;
		fout[f_memLR(4 ,x,y,pitch)] = f4 ;
		fout[f_memLR(5 ,x,y,pitch)] = f5 ;
		fout[f_memLR(6 ,x,y,pitch)] = f6 ;
		fout[f_memLR(7 ,x,y,pitch)] = f7 ;
		fout[f_memLR(8 ,x,y,pitch)] = f8 ;
	}

	}//end else (not at edge of LR)
}

__global__ void LR_d_hybABCD2(float* fin, float* fout,
							float omega, size_t pitch, int n)//pitch in elements
//second time through in inner loop. don't need to calculate for the 3 outer most cells
//n=number of outer elements to ignore
{
	int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
	int y = threadIdx.y+blockIdx.y*blockDim.y;
	float xcoord = LRX0+x*LRFACTOR;
	float ycoord = LRY0+y*LRFACTOR;
	int j = x+y*pitch;//index on padded mem (pitch in elements)
	int im = ImageFcn(xcoord,ycoord);
	float f0,f1,f2,f3,f4,f5,f6,f7,f8;

	//if(x < 3 || x > XLRDIM-4 || y < 3 || y > YLRDIM-4)
	if(x < n || x > XLRDIM-1-n || y < n || y > YLRDIM-1-n)
	{
	//dont do anything
	}
	else{
	f0 = fin[j];
	f2 = fin[f_memLR(2 ,x  ,y-1,pitch)];
	f4 = fin[f_memLR(4 ,x  ,y+1,pitch)];
	f1 = tex2D(texRef_f1C ,x-1+0.5f,y  +0.5f);
	f3 = tex2D(texRef_f3C ,x+1+0.5f,y  +0.5f);
	f5 = tex2D(texRef_f5C ,x-1+0.5f,y-1+0.5f);
	f6 = tex2D(texRef_f6C ,x+1+0.5f,y-1+0.5f);
	f7 = tex2D(texRef_f7C ,x+1+0.5f,y+1+0.5f);
	f8 = tex2D(texRef_f8C ,x-1+0.5f,y+1+0.5f);

	if(im == 1 || im == 10){//BB
		fout[f_memLR(1 ,x,y,pitch)] = f3 ;
		fout[f_memLR(2 ,x,y,pitch)] = f4 ;
		fout[f_memLR(3 ,x,y,pitch)] = f1 ;
		fout[f_memLR(4 ,x,y,pitch)] = f2 ;
		fout[f_memLR(5 ,x,y,pitch)] = f7 ;
		fout[f_memLR(6 ,x,y,pitch)] = f8 ;
		fout[f_memLR(7 ,x,y,pitch)] = f5 ;
		fout[f_memLR(8 ,x,y,pitch)] = f6 ;
	}
	else{
		if(MODEL == "MRT")
		mrt_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,omega);
		else if(MODEL == "BGK")
		bgk_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,omega);
		fout[f_memLR(0 ,x,y,pitch)] = f0 ;
		fout[f_memLR(1 ,x,y,pitch)] = f1 ;
		fout[f_memLR(2 ,x,y,pitch)] = f2 ;
		fout[f_memLR(3 ,x,y,pitch)] = f3 ;
		fout[f_memLR(4 ,x,y,pitch)] = f4 ;
		fout[f_memLR(5 ,x,y,pitch)] = f5 ;
		fout[f_memLR(6 ,x,y,pitch)] = f6 ;
		fout[f_memLR(7 ,x,y,pitch)] = f7 ;
		fout[f_memLR(8 ,x,y,pitch)] = f8 ;
	}

	}//end else (not at edge of LR)
}

__global__ void LR_d_hybABDC2(float* fin, float* fout,
							float omega, size_t pitch, float SF, int n)//pitch in elements
{
	int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
	int y = threadIdx.y+blockIdx.y*blockDim.y;
	float xcoord = LRX0+x*LRFACTOR;//+0.5f is because textures are stored in a voxel centered fashion. we need to change this to vertex centered.
	float ycoord = LRY0+y*LRFACTOR;
	int im = ImageFcn(xcoord,ycoord);
	int j = x+y*pitch;//index on padded mem (pitch in elements)
	float f0,f1,f2,f3,f4,f5,f6,f7,f8;

	if(x < n || x > XLRDIM-1-n || y < n || y > YLRDIM-1-n)
	{
	//no interp
	}
	else{
	f0 = fin[j];
	f2 = fin[f_memLR(2 ,x  ,y-1,pitch)];
	f4 = fin[f_memLR(4 ,x  ,y+1,pitch)];
	f1 = tex2D(texRef_f1D ,x-1+0.5f,y  +0.5f);
	f3 = tex2D(texRef_f3D ,x+1+0.5f,y  +0.5f);
	f5 = tex2D(texRef_f5D ,x-1+0.5f,y-1+0.5f);
	f6 = tex2D(texRef_f6D ,x+1+0.5f,y-1+0.5f);
	f7 = tex2D(texRef_f7D ,x+1+0.5f,y+1+0.5f);
	f8 = tex2D(texRef_f8D ,x-1+0.5f,y+1+0.5f);

	if(im == 1 || im == 10){//BB
		fout[f_memLR(1 ,x,y,pitch)] = f3 ;
		fout[f_memLR(2 ,x,y,pitch)] = f4 ;
		fout[f_memLR(3 ,x,y,pitch)] = f1 ;
		fout[f_memLR(4 ,x,y,pitch)] = f2 ;
		fout[f_memLR(5 ,x,y,pitch)] = f7 ;
		fout[f_memLR(6 ,x,y,pitch)] = f8 ;
		fout[f_memLR(7 ,x,y,pitch)] = f5 ;
		fout[f_memLR(8 ,x,y,pitch)] = f6 ;
	}
	else{
		if(MODEL == "MRT")
		mrt_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,omega);
		else if(MODEL == "BGK")
		bgk_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,omega);

		fout[f_memLR(0 ,x,y,pitch)] = f0 ;
		fout[f_memLR(1 ,x,y,pitch)] = f1 ;
		fout[f_memLR(2 ,x,y,pitch)] = f2 ;
		fout[f_memLR(3 ,x,y,pitch)] = f3 ;
		fout[f_memLR(4 ,x,y,pitch)] = f4 ;
		fout[f_memLR(5 ,x,y,pitch)] = f5 ;
		fout[f_memLR(6 ,x,y,pitch)] = f6 ;
		fout[f_memLR(7 ,x,y,pitch)] = f7 ;
		fout[f_memLR(8 ,x,y,pitch)] = f8 ;
	}
	}//end else (not at edge of LR)
}

__global__ void LR_d_hybABDC_Interp(float* fin, float* fout,
							float omega, size_t pitch, float SF)//pitch in elements
{
	int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
	int y = threadIdx.y+blockIdx.y*blockDim.y;
	float xcoord = LRX0+x*LRFACTOR;//+0.5f is because textures are stored in a voxel centered fashion. we need to change this to vertex centered.
	float ycoord = LRY0+y*LRFACTOR;
	int im = ImageFcn(xcoord,ycoord);
	int j = x+y*pitch;//index on padded mem (pitch in elements)
	float f0,f1,f2,f3,f4,f5,f6,f7,f8;

	if(x < LRLEVEL || x > XLRDIM-1-LRLEVEL || y < LRLEVEL || y > YLRDIM-1-LRLEVEL)
	//if(x < 2 || x > XLRDIM-1-2 || y < 2 || y > YLRDIM-1-2)
	{
	//interpolate for next time step. from B
	f0 = tex2D(texRef_f0B,xcoord+0.5f,ycoord+0.5f);//YDIM and not YLRDIM
	f1 = tex2D(texRef_f1B,xcoord+0.5f,ycoord+0.5f);
	f2 = tex2D(texRef_f2B,xcoord+0.5f,ycoord+0.5f);
	f3 = tex2D(texRef_f3B,xcoord+0.5f,ycoord+0.5f);
	f4 = tex2D(texRef_f4B,xcoord+0.5f,ycoord+0.5f);
	f5 = tex2D(texRef_f5B,xcoord+0.5f,ycoord+0.5f);
	f6 = tex2D(texRef_f6B,xcoord+0.5f,ycoord+0.5f);
	f7 = tex2D(texRef_f7B,xcoord+0.5f,ycoord+0.5f);
	f8 = tex2D(texRef_f8B,xcoord+0.5f,ycoord+0.5f);

	float rho,u,v;	
	rho = f0+f1+f2+f3+f4+f5+f6+f7+f8;
	u = f1-f3+f5-f6-f7+f8;
	v = f2-f4+f5+f6-f7-f8;
	float usqr = u*u+v*v;
	//scale
	fout[f_memLR(0,x,y,pitch)] =SF*f0+(1.0f-SF)*(0.4444444444f*(rho-1.5f*usqr));
	fout[f_memLR(1,x,y,pitch)] =SF*f1+(1.0f-SF)*(0.1111111111f*(rho+3.0f*u+4.5f*u*u-1.5f*usqr));                 
	fout[f_memLR(2,x,y,pitch)] =SF*f2+(1.0f-SF)*(0.1111111111f*(rho+3.0f*v+4.5f*v*v-1.5f*usqr));
	fout[f_memLR(3,x,y,pitch)] =SF*f3+(1.0f-SF)*(0.1111111111f*(rho-3.0f*u+4.5f*u*u-1.5f*usqr));
	fout[f_memLR(4,x,y,pitch)] =SF*f4+(1.0f-SF)*(0.1111111111f*(rho-3.0f*v+4.5f*v*v-1.5f*usqr));
	fout[f_memLR(5,x,y,pitch)] =SF*f5+(1.0f-SF)*(0.02777777778*(rho+3.0f*( u+v)+4.5f*( u+v)*( u+v)-1.5f*usqr));
	fout[f_memLR(6,x,y,pitch)] =SF*f6+(1.0f-SF)*(0.02777777778*(rho+3.0f*(-u+v)+4.5f*(-u+v)*(-u+v)-1.5f*usqr));
	fout[f_memLR(7,x,y,pitch)] =SF*f7+(1.0f-SF)*(0.02777777778*(rho+3.0f*(-u-v)+4.5f*(-u-v)*(-u-v)-1.5f*usqr));
	fout[f_memLR(8,x,y,pitch)] =SF*f8+(1.0f-SF)*(0.02777777778*(rho+3.0f*( u-v)+4.5f*( u-v)*( u-v)-1.5f*usqr));

	}
	else{
	f0 = fin[j];
	f2 = fin[f_memLR(2 ,x  ,y-1,pitch)];
	f4 = fin[f_memLR(4 ,x  ,y+1,pitch)];
	f1 = tex2D(texRef_f1D ,x-1+0.5f,y  +0.5f);
	f3 = tex2D(texRef_f3D ,x+1+0.5f,y  +0.5f);
	f5 = tex2D(texRef_f5D ,x-1+0.5f,y-1+0.5f);
	f6 = tex2D(texRef_f6D ,x+1+0.5f,y-1+0.5f);
	f7 = tex2D(texRef_f7D ,x+1+0.5f,y+1+0.5f);
	f8 = tex2D(texRef_f8D ,x-1+0.5f,y+1+0.5f);

	if(im == 1 || im == 10){//BB
		fout[f_memLR(1 ,x,y,pitch)] = f3 ;
		fout[f_memLR(2 ,x,y,pitch)] = f4 ;
		fout[f_memLR(3 ,x,y,pitch)] = f1 ;
		fout[f_memLR(4 ,x,y,pitch)] = f2 ;
		fout[f_memLR(5 ,x,y,pitch)] = f7 ;
		fout[f_memLR(6 ,x,y,pitch)] = f8 ;
		fout[f_memLR(7 ,x,y,pitch)] = f5 ;
		fout[f_memLR(8 ,x,y,pitch)] = f6 ;
	}
	else{
		if(MODEL == "MRT")
		mrt_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,omega);
		else if(MODEL == "BGK")
		bgk_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,omega);

		fout[f_memLR(0 ,x,y,pitch)] = f0 ;
		fout[f_memLR(1 ,x,y,pitch)] = f1 ;
		fout[f_memLR(2 ,x,y,pitch)] = f2 ;
		fout[f_memLR(3 ,x,y,pitch)] = f3 ;
		fout[f_memLR(4 ,x,y,pitch)] = f4 ;
		fout[f_memLR(5 ,x,y,pitch)] = f5 ;
		fout[f_memLR(6 ,x,y,pitch)] = f6 ;
		fout[f_memLR(7 ,x,y,pitch)] = f7 ;
		fout[f_memLR(8 ,x,y,pitch)] = f8 ;
	}
	}//end else (not at edge of LR)
}

__global__ void LR_d_hybBACD(float* fin, float* fout,
							float omega, size_t pitch)//pitch in elements
{
	int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
	int y = threadIdx.y+blockIdx.y*blockDim.y;
	float xcoord = LRX0+x*LRFACTOR;
	float ycoord = LRY0+y*LRFACTOR;
	int j = x+y*pitch;//index on padded mem (pitch in elements)
	int im = ImageFcn(xcoord,ycoord);
	float f0,f1,f2,f3,f4,f5,f6,f7,f8;
	if(x < 1 || x > XLRDIM-2 || y < 1 || y > YLRDIM-2)
	{
	//dont do anything
	}
	else{
	f0 = fin[j];
	f2 = fin[f_memLR(2 ,x  ,y-1,pitch)];
	f4 = fin[f_memLR(4 ,x  ,y+1,pitch)];
	f1 = tex2D(texRef_f1C ,x-1+0.5f,y  +0.5f);
	f3 = tex2D(texRef_f3C ,x+1+0.5f,y  +0.5f);
	f5 = tex2D(texRef_f5C ,x-1+0.5f,y-1+0.5f);
	f6 = tex2D(texRef_f6C ,x+1+0.5f,y-1+0.5f);
	f7 = tex2D(texRef_f7C ,x+1+0.5f,y+1+0.5f);
	f8 = tex2D(texRef_f8C ,x-1+0.5f,y+1+0.5f);
	if(im == 1 || im == 10){//BB
		fout[f_memLR(1 ,x,y,pitch)] = f3 ;
		fout[f_memLR(2 ,x,y,pitch)] = f4 ;
		fout[f_memLR(3 ,x,y,pitch)] = f1 ;
		fout[f_memLR(4 ,x,y,pitch)] = f2 ;
		fout[f_memLR(5 ,x,y,pitch)] = f7 ;
		fout[f_memLR(6 ,x,y,pitch)] = f8 ;
		fout[f_memLR(7 ,x,y,pitch)] = f5 ;
		fout[f_memLR(8 ,x,y,pitch)] = f6 ;
	}
	else{
		if(MODEL == "MRT")
		mrt_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,omega);
		else if(MODEL == "BGK")
		bgk_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,omega);
		fout[f_memLR(0 ,x,y,pitch)] = f0 ;
		fout[f_memLR(1 ,x,y,pitch)] = f1 ;
		fout[f_memLR(2 ,x,y,pitch)] = f2 ;
		fout[f_memLR(3 ,x,y,pitch)] = f3 ;
		fout[f_memLR(4 ,x,y,pitch)] = f4 ;
		fout[f_memLR(5 ,x,y,pitch)] = f5 ;
		fout[f_memLR(6 ,x,y,pitch)] = f6 ;
		fout[f_memLR(7 ,x,y,pitch)] = f7 ;
		fout[f_memLR(8 ,x,y,pitch)] = f8 ;
	}
	}//end else (not at edge of LR)
}

__global__ void LR_d_hybBACD2(float* fin, float* fout,
							float omega, size_t pitch, int n)//pitch in elements
//second time through in inner loop. don't need to calculate for the 3 outer most cells
{
	int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
	int y = threadIdx.y+blockIdx.y*blockDim.y;
	float xcoord = LRX0+x*LRFACTOR;
	float ycoord = LRY0+y*LRFACTOR;
	int j = x+y*pitch;//index on padded mem (pitch in elements)
	int im = ImageFcn(xcoord,ycoord);
	float f0,f1,f2,f3,f4,f5,f6,f7,f8;
	if(x < n || x > XLRDIM-1-n || y < n || y > YLRDIM-1-n)
	{
	//dont do anything
	}
	else{
	f0 = fin[j];
	f2 = fin[f_memLR(2 ,x  ,y-1,pitch)];
	f4 = fin[f_memLR(4 ,x  ,y+1,pitch)];
	f1 = tex2D(texRef_f1C ,x-1+0.5f,y  +0.5f);
	f3 = tex2D(texRef_f3C ,x+1+0.5f,y  +0.5f);
	f5 = tex2D(texRef_f5C ,x-1+0.5f,y-1+0.5f);
	f6 = tex2D(texRef_f6C ,x+1+0.5f,y-1+0.5f);
	f7 = tex2D(texRef_f7C ,x+1+0.5f,y+1+0.5f);
	f8 = tex2D(texRef_f8C ,x-1+0.5f,y+1+0.5f);
	if(im == 1 || im == 10){//BB
		fout[f_memLR(1 ,x,y,pitch)] = f3 ;
		fout[f_memLR(2 ,x,y,pitch)] = f4 ;
		fout[f_memLR(3 ,x,y,pitch)] = f1 ;
		fout[f_memLR(4 ,x,y,pitch)] = f2 ;
		fout[f_memLR(5 ,x,y,pitch)] = f7 ;
		fout[f_memLR(6 ,x,y,pitch)] = f8 ;
		fout[f_memLR(7 ,x,y,pitch)] = f5 ;
		fout[f_memLR(8 ,x,y,pitch)] = f6 ;
	}
	else{
		if(MODEL == "MRT")
		mrt_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,omega);
		else if(MODEL == "BGK")
		bgk_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,omega);
		fout[f_memLR(0 ,x,y,pitch)] = f0 ;
		fout[f_memLR(1 ,x,y,pitch)] = f1 ;
		fout[f_memLR(2 ,x,y,pitch)] = f2 ;
		fout[f_memLR(3 ,x,y,pitch)] = f3 ;
		fout[f_memLR(4 ,x,y,pitch)] = f4 ;
		fout[f_memLR(5 ,x,y,pitch)] = f5 ;
		fout[f_memLR(6 ,x,y,pitch)] = f6 ;
		fout[f_memLR(7 ,x,y,pitch)] = f7 ;
		fout[f_memLR(8 ,x,y,pitch)] = f8 ;
	}
	}//end else (not at edge of LR)
}

__global__ void LR_d_hybBADC(float* fin, float* fout,
							float omega, size_t pitch, float SF)//pitch in elements
{
	int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
	int y = threadIdx.y+blockIdx.y*blockDim.y;
	float xcoord = LRX0+x*LRFACTOR;//+0.5f is because textures are stored in a voxel centered fashion. we need to change this to vertex centered.
	float ycoord = LRY0+y*LRFACTOR;
	int j = x+y*pitch;//index on padded mem (pitch in elements)
	float f0,f1,f2,f3,f4,f5,f6,f7,f8;
	int im = ImageFcn(xcoord,ycoord);

	if(x < 2 || x > XLRDIM-3 || y < 2 || y > YLRDIM-3)
	{
	//no interp
	}
	else{
	f0 = fin[j];
	f2 = fin[f_memLR(2 ,x  ,y-1,pitch)];
	f4 = fin[f_memLR(4 ,x  ,y+1,pitch)];
	f1 = tex2D(texRef_f1D ,x-1+0.5f,y  +0.5f);
	f3 = tex2D(texRef_f3D ,x+1+0.5f,y  +0.5f);
	f5 = tex2D(texRef_f5D ,x-1+0.5f,y-1+0.5f);
	f6 = tex2D(texRef_f6D ,x+1+0.5f,y-1+0.5f);
	f7 = tex2D(texRef_f7D ,x+1+0.5f,y+1+0.5f);
	f8 = tex2D(texRef_f8D ,x-1+0.5f,y+1+0.5f);
	if(im == 1 || im == 10){//BB
		fout[f_memLR(1 ,x,y,pitch)] = f3 ;
		fout[f_memLR(2 ,x,y,pitch)] = f4 ;
		fout[f_memLR(3 ,x,y,pitch)] = f1 ;
		fout[f_memLR(4 ,x,y,pitch)] = f2 ;
		fout[f_memLR(5 ,x,y,pitch)] = f7 ;
		fout[f_memLR(6 ,x,y,pitch)] = f8 ;
		fout[f_memLR(7 ,x,y,pitch)] = f5 ;
		fout[f_memLR(8 ,x,y,pitch)] = f6 ;
	}
	else{
		if(MODEL == "MRT")
		mrt_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,omega);
		else if(MODEL == "BGK")
		bgk_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,omega);

		fout[f_memLR(0 ,x,y,pitch)] = f0 ;
		fout[f_memLR(1 ,x,y,pitch)] = f1 ;
		fout[f_memLR(2 ,x,y,pitch)] = f2 ;
		fout[f_memLR(3 ,x,y,pitch)] = f3 ;
		fout[f_memLR(4 ,x,y,pitch)] = f4 ;
		fout[f_memLR(5 ,x,y,pitch)] = f5 ;
		fout[f_memLR(6 ,x,y,pitch)] = f6 ;
		fout[f_memLR(7 ,x,y,pitch)] = f7 ;
		fout[f_memLR(8 ,x,y,pitch)] = f8 ;
	}
	}//end else (not at edge of LR)
}
__global__ void LR_d_hybBADC2(float* fin, float* fout,
							float omega, size_t pitch, float SF, int n)//pitch in elements
{
	int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
	int y = threadIdx.y+blockIdx.y*blockDim.y;
	float xcoord = LRX0+x*LRFACTOR;//+0.5f is because textures are stored in a voxel centered fashion. we need to change this to vertex centered.
	float ycoord = LRY0+y*LRFACTOR;
	int j = x+y*pitch;//index on padded mem (pitch in elements)
	float f0,f1,f2,f3,f4,f5,f6,f7,f8;
	int im = ImageFcn(xcoord,ycoord);

	if(x < n || x > XLRDIM-1-n || y < n || y > YLRDIM-1-n)
	{
	//no interp
	}
	else{
	f0 = fin[j];
	f2 = fin[f_memLR(2 ,x  ,y-1,pitch)];
	f4 = fin[f_memLR(4 ,x  ,y+1,pitch)];
	f1 = tex2D(texRef_f1D ,x-1+0.5f,y  +0.5f);
	f3 = tex2D(texRef_f3D ,x+1+0.5f,y  +0.5f);
	f5 = tex2D(texRef_f5D ,x-1+0.5f,y-1+0.5f);
	f6 = tex2D(texRef_f6D ,x+1+0.5f,y-1+0.5f);
	f7 = tex2D(texRef_f7D ,x+1+0.5f,y+1+0.5f);
	f8 = tex2D(texRef_f8D ,x-1+0.5f,y+1+0.5f);
	if(im == 1 || im == 10){//BB
		fout[f_memLR(1 ,x,y,pitch)] = f3 ;
		fout[f_memLR(2 ,x,y,pitch)] = f4 ;
		fout[f_memLR(3 ,x,y,pitch)] = f1 ;
		fout[f_memLR(4 ,x,y,pitch)] = f2 ;
		fout[f_memLR(5 ,x,y,pitch)] = f7 ;
		fout[f_memLR(6 ,x,y,pitch)] = f8 ;
		fout[f_memLR(7 ,x,y,pitch)] = f5 ;
		fout[f_memLR(8 ,x,y,pitch)] = f6 ;
	}
	else{
		if(MODEL == "MRT")
		mrt_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,omega);
		else if(MODEL == "BGK")
		bgk_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,omega);

		fout[f_memLR(0 ,x,y,pitch)] = f0 ;
		fout[f_memLR(1 ,x,y,pitch)] = f1 ;
		fout[f_memLR(2 ,x,y,pitch)] = f2 ;
		fout[f_memLR(3 ,x,y,pitch)] = f3 ;
		fout[f_memLR(4 ,x,y,pitch)] = f4 ;
		fout[f_memLR(5 ,x,y,pitch)] = f5 ;
		fout[f_memLR(6 ,x,y,pitch)] = f6 ;
		fout[f_memLR(7 ,x,y,pitch)] = f7 ;
		fout[f_memLR(8 ,x,y,pitch)] = f8 ;
	}
	}//end else (not at edge of LR)
}

__global__ void LR_d_hybBADC_Interp(float* fin, float* fout,
							float omega, size_t pitch, float SF)//pitch in elements
{
	int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
	int y = threadIdx.y+blockIdx.y*blockDim.y;
	float xcoord = LRX0+x*LRFACTOR;//+0.5f is because textures are stored in a voxel centered fashion. we need to change this to vertex centered.
	float ycoord = LRY0+y*LRFACTOR;
	int j = x+y*pitch;//index on padded mem (pitch in elements)
	float f0,f1,f2,f3,f4,f5,f6,f7,f8;
	int im = ImageFcn(xcoord,ycoord);

	if(x < LRLEVEL || x > XLRDIM-1-LRLEVEL || y < LRLEVEL || y > YLRDIM-1-LRLEVEL)
	//if(x < 2 || x > XLRDIM-3 || y < 2 || y > YLRDIM-3)
	{
	//interpolate for next time step. from A
	f0 = tex2D(texRef_f0A,xcoord+0.5f,ycoord+0.5f);//YDIM and not YLRDIM
	f1 = tex2D(texRef_f1A,xcoord+0.5f,ycoord+0.5f);
	f2 = tex2D(texRef_f2A,xcoord+0.5f,ycoord+0.5f);
	f3 = tex2D(texRef_f3A,xcoord+0.5f,ycoord+0.5f);
	f4 = tex2D(texRef_f4A,xcoord+0.5f,ycoord+0.5f);
	f5 = tex2D(texRef_f5A,xcoord+0.5f,ycoord+0.5f);
	f6 = tex2D(texRef_f6A,xcoord+0.5f,ycoord+0.5f);
	f7 = tex2D(texRef_f7A,xcoord+0.5f,ycoord+0.5f);
	f8 = tex2D(texRef_f8A,xcoord+0.5f,ycoord+0.5f);

	float rho,u,v;	
	rho = f0+f1+f2+f3+f4+f5+f6+f7+f8;
	u = f1-f3+f5-f6-f7+f8;
	v = f2-f4+f5+f6-f7-f8;
	float usqr = u*u+v*v;
	//scale
	fout[f_memLR(0,x,y,pitch)] =SF*f0+(1.0f-SF)*(0.4444444444f*(rho-1.5f*usqr));
	fout[f_memLR(1,x,y,pitch)] =SF*f1+(1.0f-SF)*(0.1111111111f*(rho+3.0f*u+4.5f*u*u-1.5f*usqr));                 
	fout[f_memLR(2,x,y,pitch)] =SF*f2+(1.0f-SF)*(0.1111111111f*(rho+3.0f*v+4.5f*v*v-1.5f*usqr));
	fout[f_memLR(3,x,y,pitch)] =SF*f3+(1.0f-SF)*(0.1111111111f*(rho-3.0f*u+4.5f*u*u-1.5f*usqr));
	fout[f_memLR(4,x,y,pitch)] =SF*f4+(1.0f-SF)*(0.1111111111f*(rho-3.0f*v+4.5f*v*v-1.5f*usqr));
	fout[f_memLR(5,x,y,pitch)] =SF*f5+(1.0f-SF)*(0.02777777778*(rho+3.0f*( u+v)+4.5f*( u+v)*( u+v)-1.5f*usqr));
	fout[f_memLR(6,x,y,pitch)] =SF*f6+(1.0f-SF)*(0.02777777778*(rho+3.0f*(-u+v)+4.5f*(-u+v)*(-u+v)-1.5f*usqr));
	fout[f_memLR(7,x,y,pitch)] =SF*f7+(1.0f-SF)*(0.02777777778*(rho+3.0f*(-u-v)+4.5f*(-u-v)*(-u-v)-1.5f*usqr));
	fout[f_memLR(8,x,y,pitch)] =SF*f8+(1.0f-SF)*(0.02777777778*(rho+3.0f*( u-v)+4.5f*( u-v)*( u-v)-1.5f*usqr));

	}
	else{
	f0 = fin[j];
	f2 = fin[f_memLR(2 ,x  ,y-1,pitch)];
	f4 = fin[f_memLR(4 ,x  ,y+1,pitch)];
	f1 = tex2D(texRef_f1D ,x-1+0.5f,y  +0.5f);
	f3 = tex2D(texRef_f3D ,x+1+0.5f,y  +0.5f);
	f5 = tex2D(texRef_f5D ,x-1+0.5f,y-1+0.5f);
	f6 = tex2D(texRef_f6D ,x+1+0.5f,y-1+0.5f);
	f7 = tex2D(texRef_f7D ,x+1+0.5f,y+1+0.5f);
	f8 = tex2D(texRef_f8D ,x-1+0.5f,y+1+0.5f);
	if(im == 1 || im == 10){//BB
		fout[f_memLR(1 ,x,y,pitch)] = f3 ;
		fout[f_memLR(2 ,x,y,pitch)] = f4 ;
		fout[f_memLR(3 ,x,y,pitch)] = f1 ;
		fout[f_memLR(4 ,x,y,pitch)] = f2 ;
		fout[f_memLR(5 ,x,y,pitch)] = f7 ;
		fout[f_memLR(6 ,x,y,pitch)] = f8 ;
		fout[f_memLR(7 ,x,y,pitch)] = f5 ;
		fout[f_memLR(8 ,x,y,pitch)] = f6 ;
	}
	else{
		if(MODEL == "MRT")
		mrt_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,omega);
		else if(MODEL == "BGK")
		bgk_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,omega);

		fout[f_memLR(0 ,x,y,pitch)] = f0 ;
		fout[f_memLR(1 ,x,y,pitch)] = f1 ;
		fout[f_memLR(2 ,x,y,pitch)] = f2 ;
		fout[f_memLR(3 ,x,y,pitch)] = f3 ;
		fout[f_memLR(4 ,x,y,pitch)] = f4 ;
		fout[f_memLR(5 ,x,y,pitch)] = f5 ;
		fout[f_memLR(6 ,x,y,pitch)] = f6 ;
		fout[f_memLR(7 ,x,y,pitch)] = f7 ;
		fout[f_memLR(8 ,x,y,pitch)] = f8 ;
	}
	}//end else (not at edge of LR)
}

__global__ void LR_d_ABCD(float* fin, float* fout,
							float omega, size_t pitch)//pitch in elements
{
	int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
	int y = threadIdx.y+blockIdx.y*blockDim.y;
	float xcoord = LRX0+x*LRFACTOR;
	float ycoord = LRY0+y*LRFACTOR;
	int j = x+y*pitch;//index on padded mem (pitch in elements)
	int im = ImageFcn(xcoord,ycoord);
	float f0,f1,f2,f3,f4,f5,f6,f7,f8;
	if(x < 1 || x > XLRDIM-2 || y < 1 || y > YLRDIM-2)
	{
	//dont do anything
	}
	else{
	f0 = fin[j];
	f1 = fin[f_memLR(1 ,x-1,y  ,pitch)];
	f2 = fin[f_memLR(2 ,x  ,y-1,pitch)];
	f3 = fin[f_memLR(3 ,x+1,y  ,pitch)];
	f4 = fin[f_memLR(4 ,x  ,y+1,pitch)];
	f5 = fin[f_memLR(5 ,x-1,y-1,pitch)];
	f6 = fin[f_memLR(6 ,x+1,y-1,pitch)];
	f7 = fin[f_memLR(7 ,x+1,y+1,pitch)];
	f8 = fin[f_memLR(8 ,x-1,y+1,pitch)];
	if(im == 1 || im == 10){//BB
		fout[f_memLR(1 ,x,y,pitch)] = f3 ;
		fout[f_memLR(2 ,x,y,pitch)] = f4 ;
		fout[f_memLR(3 ,x,y,pitch)] = f1 ;
		fout[f_memLR(4 ,x,y,pitch)] = f2 ;
		fout[f_memLR(5 ,x,y,pitch)] = f7 ;
		fout[f_memLR(6 ,x,y,pitch)] = f8 ;
		fout[f_memLR(7 ,x,y,pitch)] = f5 ;
		fout[f_memLR(8 ,x,y,pitch)] = f6 ;
	}
	else{
		if(MODEL == "MRT")
		mrt_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,omega);
		else if(MODEL == "BGK")
		bgk_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,omega);
		fout[f_memLR(0 ,x,y,pitch)] = f0 ;
		fout[f_memLR(1 ,x,y,pitch)] = f1 ;
		fout[f_memLR(2 ,x,y,pitch)] = f2 ;
		fout[f_memLR(3 ,x,y,pitch)] = f3 ;
		fout[f_memLR(4 ,x,y,pitch)] = f4 ;
		fout[f_memLR(5 ,x,y,pitch)] = f5 ;
		fout[f_memLR(6 ,x,y,pitch)] = f6 ;
		fout[f_memLR(7 ,x,y,pitch)] = f7 ;
		fout[f_memLR(8 ,x,y,pitch)] = f8 ;
	}
	}//end else (not at edge of LR)
}
__global__ void LR_d_ABCD2(float* fin, float* fout,
							float omega, size_t pitch)//pitch in elements
{
	int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
	int y = threadIdx.y+blockIdx.y*blockDim.y;
	float xcoord = LRX0+x*LRFACTOR;
	float ycoord = LRY0+y*LRFACTOR;
	int j = x+y*pitch;//index on padded mem (pitch in elements)
	int im = ImageFcn(xcoord,ycoord);
	float f0,f1,f2,f3,f4,f5,f6,f7,f8;
	if(x < 3 || x > XLRDIM-4 || y < 3 || y > YLRDIM-4)
	{
	//dont do anything
	}
	else{
	f0 = fin[j];
	f1 = fin[f_memLR(1 ,x-1,y  ,pitch)];
	f2 = fin[f_memLR(2 ,x  ,y-1,pitch)];
	f3 = fin[f_memLR(3 ,x+1,y  ,pitch)];
	f4 = fin[f_memLR(4 ,x  ,y+1,pitch)];
	f5 = fin[f_memLR(5 ,x-1,y-1,pitch)];
	f6 = fin[f_memLR(6 ,x+1,y-1,pitch)];
	f7 = fin[f_memLR(7 ,x+1,y+1,pitch)];
	f8 = fin[f_memLR(8 ,x-1,y+1,pitch)];
	if(im == 1 || im == 10){//BB
		fout[f_memLR(1 ,x,y,pitch)] = f3 ;
		fout[f_memLR(2 ,x,y,pitch)] = f4 ;
		fout[f_memLR(3 ,x,y,pitch)] = f1 ;
		fout[f_memLR(4 ,x,y,pitch)] = f2 ;
		fout[f_memLR(5 ,x,y,pitch)] = f7 ;
		fout[f_memLR(6 ,x,y,pitch)] = f8 ;
		fout[f_memLR(7 ,x,y,pitch)] = f5 ;
		fout[f_memLR(8 ,x,y,pitch)] = f6 ;
	}
	else{
		if(MODEL == "MRT")
		mrt_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,omega);
		else if(MODEL == "BGK")
		bgk_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,omega);
		fout[f_memLR(0 ,x,y,pitch)] = f0 ;
		fout[f_memLR(1 ,x,y,pitch)] = f1 ;
		fout[f_memLR(2 ,x,y,pitch)] = f2 ;
		fout[f_memLR(3 ,x,y,pitch)] = f3 ;
		fout[f_memLR(4 ,x,y,pitch)] = f4 ;
		fout[f_memLR(5 ,x,y,pitch)] = f5 ;
		fout[f_memLR(6 ,x,y,pitch)] = f6 ;
		fout[f_memLR(7 ,x,y,pitch)] = f7 ;
		fout[f_memLR(8 ,x,y,pitch)] = f8 ;
	}
	}//end else (not at edge of LR)
}

__global__ void LR_d_ABDC(float* fin, float* fout,
							float omega, size_t pitch, float SF)//pitch in elements
{
	int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
	int y = threadIdx.y+blockIdx.y*blockDim.y;
	float xcoord = LRX0+x*LRFACTOR;//+0.5f is because textures are stored in a voxel centered fashion. we need to change this to vertex centered.
	float ycoord = LRY0+y*LRFACTOR;
	int im = ImageFcn(xcoord,ycoord);
	int j = x+y*pitch;//index on padded mem (pitch in elements)
	float f0,f1,f2,f3,f4,f5,f6,f7,f8;

	if(x < 2 || x > XLRDIM-3 || y < 2 || y > YLRDIM-3)
	{
	//interpolate for next time step. from B
	f0 = tex2D(texRef_f0B,xcoord+0.5f,ycoord+0.5f);//YDIM and not YLRDIM
	f1 = tex2D(texRef_f1B,xcoord+0.5f,ycoord+0.5f);
	f2 = tex2D(texRef_f2B,xcoord+0.5f,ycoord+0.5f);
	f3 = tex2D(texRef_f3B,xcoord+0.5f,ycoord+0.5f);
	f4 = tex2D(texRef_f4B,xcoord+0.5f,ycoord+0.5f);
	f5 = tex2D(texRef_f5B,xcoord+0.5f,ycoord+0.5f);
	f6 = tex2D(texRef_f6B,xcoord+0.5f,ycoord+0.5f);
	f7 = tex2D(texRef_f7B,xcoord+0.5f,ycoord+0.5f);
	f8 = tex2D(texRef_f8B,xcoord+0.5f,ycoord+0.5f);

	float rho,u,v;	
	rho = f0+f1+f2+f3+f4+f5+f6+f7+f8;
	u = f1-f3+f5-f6-f7+f8;
	v = f2-f4+f5+f6-f7-f8;
	float usqr = u*u+v*v;
	//scale
	fout[f_memLR(0,x,y,pitch)] =SF*f0+(1.0f-SF)*(0.4444444444f*(rho-1.5f*usqr));
	fout[f_memLR(1,x,y,pitch)] =SF*f1+(1.0f-SF)*(0.1111111111f*(rho+3.0f*u+4.5f*u*u-1.5f*usqr));                 
	fout[f_memLR(2,x,y,pitch)] =SF*f2+(1.0f-SF)*(0.1111111111f*(rho+3.0f*v+4.5f*v*v-1.5f*usqr));
	fout[f_memLR(3,x,y,pitch)] =SF*f3+(1.0f-SF)*(0.1111111111f*(rho-3.0f*u+4.5f*u*u-1.5f*usqr));
	fout[f_memLR(4,x,y,pitch)] =SF*f4+(1.0f-SF)*(0.1111111111f*(rho-3.0f*v+4.5f*v*v-1.5f*usqr));
	fout[f_memLR(5,x,y,pitch)] =SF*f5+(1.0f-SF)*(0.02777777778*(rho+3.0f*( u+v)+4.5f*( u+v)*( u+v)-1.5f*usqr));
	fout[f_memLR(6,x,y,pitch)] =SF*f6+(1.0f-SF)*(0.02777777778*(rho+3.0f*(-u+v)+4.5f*(-u+v)*(-u+v)-1.5f*usqr));
	fout[f_memLR(7,x,y,pitch)] =SF*f7+(1.0f-SF)*(0.02777777778*(rho+3.0f*(-u-v)+4.5f*(-u-v)*(-u-v)-1.5f*usqr));
	fout[f_memLR(8,x,y,pitch)] =SF*f8+(1.0f-SF)*(0.02777777778*(rho+3.0f*( u-v)+4.5f*( u-v)*( u-v)-1.5f*usqr));

//	f0 =SF*f0+(1.0f-SF)*(0.4444444444f*(rho-1.5f*usqr));
//	f1 =SF*f1+(1.0f-SF)*(0.1111111111f*(rho+3.0f*u+4.5f*u*u-1.5f*usqr));                 
//	f2 =SF*f2+(1.0f-SF)*(0.1111111111f*(rho+3.0f*v+4.5f*v*v-1.5f*usqr));
//	f3 =SF*f3+(1.0f-SF)*(0.1111111111f*(rho-3.0f*u+4.5f*u*u-1.5f*usqr));
//	f4 =SF*f4+(1.0f-SF)*(0.1111111111f*(rho-3.0f*v+4.5f*v*v-1.5f*usqr));
//	f5 =SF*f5+(1.0f-SF)*(0.02777777778*(rho+3.0f*( u+v)+4.5f*( u+v)*( u+v)-1.5f*usqr));
//	f6 =SF*f6+(1.0f-SF)*(0.02777777778*(rho+3.0f*(-u+v)+4.5f*(-u+v)*(-u+v)-1.5f*usqr));
//	f7 =SF*f7+(1.0f-SF)*(0.02777777778*(rho+3.0f*(-u-v)+4.5f*(-u-v)*(-u-v)-1.5f*usqr));
//	f8 =SF*f8+(1.0f-SF)*(0.02777777778*(rho+3.0f*( u-v)+4.5f*( u-v)*( u-v)-1.5f*usqr));
//	fout[f_memLR(0,x,y,pitch)] = f0 ;
//	fout[f_memLR(1,x,y,pitch)] = f1 ;
//	fout[f_memLR(2,x,y,pitch)] = f2 ;
//	fout[f_memLR(3,x,y,pitch)] = f3 ;
//	fout[f_memLR(4,x,y,pitch)] = f4 ;
//	fout[f_memLR(5,x,y,pitch)] = f5 ;
//	fout[f_memLR(6,x,y,pitch)] = f6 ;
//	fout[f_memLR(7,x,y,pitch)] = f7 ;
//	fout[f_memLR(8,x,y,pitch)] = f8 ;
	}
	else{
	f0 = fin[j];
	f1 = fin[f_memLR(1 ,dmax(x-1)     ,y             ,pitch)];
	f3 = fin[f_memLR(3 ,dmin(x+1,XDIM),y             ,pitch)];
	f2 = fin[f_memLR(2 ,x             ,y-1           ,pitch)];
	f5 = fin[f_memLR(5 ,dmax(x-1)     ,y-1           ,pitch)];
	f6 = fin[f_memLR(6 ,dmin(x+1,XDIM),y-1           ,pitch)];
	f4 = fin[f_memLR(4 ,x             ,y+1           ,pitch)];
	f7 = fin[f_memLR(7 ,dmin(x+1,XDIM),y+1           ,pitch)];
	f8 = fin[f_memLR(8 ,dmax(x-1)     ,dmin(y+1,YDIM),pitch)];
	if(im == 1 || im == 10){//BB
		fout[f_memLR(1 ,x,y,pitch)] = f3 ;
		fout[f_memLR(2 ,x,y,pitch)] = f4 ;
		fout[f_memLR(3 ,x,y,pitch)] = f1 ;
		fout[f_memLR(4 ,x,y,pitch)] = f2 ;
		fout[f_memLR(5 ,x,y,pitch)] = f7 ;
		fout[f_memLR(6 ,x,y,pitch)] = f8 ;
		fout[f_memLR(7 ,x,y,pitch)] = f5 ;
		fout[f_memLR(8 ,x,y,pitch)] = f6 ;
	}
	else{
		if(MODEL == "MRT")
		mrt_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,omega);
		else if(MODEL == "BGK")
		bgk_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,omega);

		fout[f_memLR(0 ,x,y,pitch)] = f0 ;
		fout[f_memLR(1 ,x,y,pitch)] = f1 ;
		fout[f_memLR(2 ,x,y,pitch)] = f2 ;
		fout[f_memLR(3 ,x,y,pitch)] = f3 ;
		fout[f_memLR(4 ,x,y,pitch)] = f4 ;
		fout[f_memLR(5 ,x,y,pitch)] = f5 ;
		fout[f_memLR(6 ,x,y,pitch)] = f6 ;
		fout[f_memLR(7 ,x,y,pitch)] = f7 ;
		fout[f_memLR(8 ,x,y,pitch)] = f8 ;
	}
	}//end else (not at edge of LR)
}

__global__ void LR_d_ABDC2(float* fin, float* fout,
							float omega, size_t pitch, float SF)//pitch in elements
{
	int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
	int y = threadIdx.y+blockIdx.y*blockDim.y;
	float xcoord = LRX0+x*LRFACTOR;//+0.5f is because textures are stored in a voxel centered fashion. we need to change this to vertex centered.
	float ycoord = LRY0+y*LRFACTOR;
	int im = ImageFcn(xcoord,ycoord);
	int j = x+y*pitch;//index on padded mem (pitch in elements)
	float f0,f1,f2,f3,f4,f5,f6,f7,f8;

	if(x < 2 || x > XLRDIM-3 || y < 2 || y > YLRDIM-3)
	{
	//interpolate for next time step. from B
	f0 = tex2D(texRef_f0B,xcoord+0.5f,ycoord+0.5f);//YDIM and not YLRDIM
	f1 = tex2D(texRef_f1B,xcoord+0.5f,ycoord+0.5f);
	f2 = tex2D(texRef_f2B,xcoord+0.5f,ycoord+0.5f);
	f3 = tex2D(texRef_f3B,xcoord+0.5f,ycoord+0.5f);
	f4 = tex2D(texRef_f4B,xcoord+0.5f,ycoord+0.5f);
	f5 = tex2D(texRef_f5B,xcoord+0.5f,ycoord+0.5f);
	f6 = tex2D(texRef_f6B,xcoord+0.5f,ycoord+0.5f);
	f7 = tex2D(texRef_f7B,xcoord+0.5f,ycoord+0.5f);
	f8 = tex2D(texRef_f8B,xcoord+0.5f,ycoord+0.5f);

	float rho,u,v;	
	rho = f0+f1+f2+f3+f4+f5+f6+f7+f8;
	u = f1-f3+f5-f6-f7+f8;
	v = f2-f4+f5+f6-f7-f8;
	float usqr = u*u+v*v;
	//scale
	fout[f_memLR(0,x,y,pitch)] =SF*f0+(1.0f-SF)*(0.4444444444f*(rho-1.5f*usqr));
	fout[f_memLR(1,x,y,pitch)] =SF*f1+(1.0f-SF)*(0.1111111111f*(rho+3.0f*u+4.5f*u*u-1.5f*usqr));                 
	fout[f_memLR(2,x,y,pitch)] =SF*f2+(1.0f-SF)*(0.1111111111f*(rho+3.0f*v+4.5f*v*v-1.5f*usqr));
	fout[f_memLR(3,x,y,pitch)] =SF*f3+(1.0f-SF)*(0.1111111111f*(rho-3.0f*u+4.5f*u*u-1.5f*usqr));
	fout[f_memLR(4,x,y,pitch)] =SF*f4+(1.0f-SF)*(0.1111111111f*(rho-3.0f*v+4.5f*v*v-1.5f*usqr));
	fout[f_memLR(5,x,y,pitch)] =SF*f5+(1.0f-SF)*(0.02777777778*(rho+3.0f*( u+v)+4.5f*( u+v)*( u+v)-1.5f*usqr));
	fout[f_memLR(6,x,y,pitch)] =SF*f6+(1.0f-SF)*(0.02777777778*(rho+3.0f*(-u+v)+4.5f*(-u+v)*(-u+v)-1.5f*usqr));
	fout[f_memLR(7,x,y,pitch)] =SF*f7+(1.0f-SF)*(0.02777777778*(rho+3.0f*(-u-v)+4.5f*(-u-v)*(-u-v)-1.5f*usqr));
	fout[f_memLR(8,x,y,pitch)] =SF*f8+(1.0f-SF)*(0.02777777778*(rho+3.0f*( u-v)+4.5f*( u-v)*( u-v)-1.5f*usqr));

//	f0 =SF*f0+(1.0f-SF)*(0.4444444444f*(rho-1.5f*usqr));
//	f1 =SF*f1+(1.0f-SF)*(0.1111111111f*(rho+3.0f*u+4.5f*u*u-1.5f*usqr));                 
//	f2 =SF*f2+(1.0f-SF)*(0.1111111111f*(rho+3.0f*v+4.5f*v*v-1.5f*usqr));
//	f3 =SF*f3+(1.0f-SF)*(0.1111111111f*(rho-3.0f*u+4.5f*u*u-1.5f*usqr));
//	f4 =SF*f4+(1.0f-SF)*(0.1111111111f*(rho-3.0f*v+4.5f*v*v-1.5f*usqr));
//	f5 =SF*f5+(1.0f-SF)*(0.02777777778*(rho+3.0f*( u+v)+4.5f*( u+v)*( u+v)-1.5f*usqr));
//	f6 =SF*f6+(1.0f-SF)*(0.02777777778*(rho+3.0f*(-u+v)+4.5f*(-u+v)*(-u+v)-1.5f*usqr));
//	f7 =SF*f7+(1.0f-SF)*(0.02777777778*(rho+3.0f*(-u-v)+4.5f*(-u-v)*(-u-v)-1.5f*usqr));
//	f8 =SF*f8+(1.0f-SF)*(0.02777777778*(rho+3.0f*( u-v)+4.5f*( u-v)*( u-v)-1.5f*usqr));
//	fout[f_memLR(0,x,y,pitch)] = f0 ;
//	fout[f_memLR(1,x,y,pitch)] = f1 ;
//	fout[f_memLR(2,x,y,pitch)] = f2 ;
//	fout[f_memLR(3,x,y,pitch)] = f3 ;
//	fout[f_memLR(4,x,y,pitch)] = f4 ;
//	fout[f_memLR(5,x,y,pitch)] = f5 ;
//	fout[f_memLR(6,x,y,pitch)] = f6 ;
//	fout[f_memLR(7,x,y,pitch)] = f7 ;
//	fout[f_memLR(8,x,y,pitch)] = f8 ;
	}
	else{
	f0 = fin[j];
	f1 = fin[f_memLR(1 ,dmax(x-1)     ,y             ,pitch)];
	f3 = fin[f_memLR(3 ,dmin(x+1,XDIM),y             ,pitch)];
	f2 = fin[f_memLR(2 ,x             ,y-1           ,pitch)];
	f5 = fin[f_memLR(5 ,dmax(x-1)     ,y-1           ,pitch)];
	f6 = fin[f_memLR(6 ,dmin(x+1,XDIM),y-1           ,pitch)];
	f4 = fin[f_memLR(4 ,x             ,y+1           ,pitch)];
	f7 = fin[f_memLR(7 ,dmin(x+1,XDIM),y+1           ,pitch)];
	f8 = fin[f_memLR(8 ,dmax(x-1)     ,dmin(y+1,YDIM),pitch)];
	if(im == 1 || im == 10){//BB
		fout[f_memLR(1 ,x,y,pitch)] = f3 ;
		fout[f_memLR(2 ,x,y,pitch)] = f4 ;
		fout[f_memLR(3 ,x,y,pitch)] = f1 ;
		fout[f_memLR(4 ,x,y,pitch)] = f2 ;
		fout[f_memLR(5 ,x,y,pitch)] = f7 ;
		fout[f_memLR(6 ,x,y,pitch)] = f8 ;
		fout[f_memLR(7 ,x,y,pitch)] = f5 ;
		fout[f_memLR(8 ,x,y,pitch)] = f6 ;
	}
	else{
		if(MODEL == "MRT")
		mrt_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,omega);
		else if(MODEL == "BGK")
		bgk_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,omega);

		fout[f_memLR(0 ,x,y,pitch)] = f0 ;
		fout[f_memLR(1 ,x,y,pitch)] = f1 ;
		fout[f_memLR(2 ,x,y,pitch)] = f2 ;
		fout[f_memLR(3 ,x,y,pitch)] = f3 ;
		fout[f_memLR(4 ,x,y,pitch)] = f4 ;
		fout[f_memLR(5 ,x,y,pitch)] = f5 ;
		fout[f_memLR(6 ,x,y,pitch)] = f6 ;
		fout[f_memLR(7 ,x,y,pitch)] = f7 ;
		fout[f_memLR(8 ,x,y,pitch)] = f8 ;
	}
	}//end else (not at edge of LR)
}
__global__ void LR_d_BACD(float* fin, float* fout,
							float omega, size_t pitch)//pitch in elements
{
	int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
	int y = threadIdx.y+blockIdx.y*blockDim.y;
	float xcoord = LRX0+x*LRFACTOR;
	float ycoord = LRY0+y*LRFACTOR;
	int j = x+y*pitch;//index on padded mem (pitch in elements)
	int im = ImageFcn(xcoord,ycoord);
	float f0,f1,f2,f3,f4,f5,f6,f7,f8;
	if(x < 1 || x > XLRDIM-2 || y < 1 || y > YLRDIM-2)
	{
	//dont do anything
	}
	else{
	f0 = fin[j];
	f1 = fin[f_memLR(1 ,x-1,y  ,pitch)];
	f3 = fin[f_memLR(3 ,x+1,y  ,pitch)];
	f2 = fin[f_memLR(2 ,x  ,y-1,pitch)];
	f5 = fin[f_memLR(5 ,x-1,y-1,pitch)];
	f6 = fin[f_memLR(6 ,x+1,y-1,pitch)];
	f4 = fin[f_memLR(4 ,x  ,y+1,pitch)];
	f7 = fin[f_memLR(7 ,x+1,y+1,pitch)];
	f8 = fin[f_memLR(8 ,x-1,y+1,pitch)];
	if(im == 1 || im == 10){//BB
		fout[f_memLR(1 ,x,y,pitch)] = f3 ;
		fout[f_memLR(2 ,x,y,pitch)] = f4 ;
		fout[f_memLR(3 ,x,y,pitch)] = f1 ;
		fout[f_memLR(4 ,x,y,pitch)] = f2 ;
		fout[f_memLR(5 ,x,y,pitch)] = f7 ;
		fout[f_memLR(6 ,x,y,pitch)] = f8 ;
		fout[f_memLR(7 ,x,y,pitch)] = f5 ;
		fout[f_memLR(8 ,x,y,pitch)] = f6 ;
	}
	else{
		if(MODEL == "MRT")
		mrt_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,omega);
		else if(MODEL == "BGK")
		bgk_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,omega);
		fout[f_memLR(0 ,x,y,pitch)] = f0 ;
		fout[f_memLR(1 ,x,y,pitch)] = f1 ;
		fout[f_memLR(2 ,x,y,pitch)] = f2 ;
		fout[f_memLR(3 ,x,y,pitch)] = f3 ;
		fout[f_memLR(4 ,x,y,pitch)] = f4 ;
		fout[f_memLR(5 ,x,y,pitch)] = f5 ;
		fout[f_memLR(6 ,x,y,pitch)] = f6 ;
		fout[f_memLR(7 ,x,y,pitch)] = f7 ;
		fout[f_memLR(8 ,x,y,pitch)] = f8 ;
	}
	}//end else (not at edge of LR)
}

__global__ void LR_d_BADC(float* fin, float* fout,
							float omega, size_t pitch, float SF)//pitch in elements
{
	int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
	int y = threadIdx.y+blockIdx.y*blockDim.y;
	float xcoord = LRX0+x*LRFACTOR;//+0.5f is because textures are stored in a voxel centered fashion. we need to change this to vertex centered.
	float ycoord = LRY0+y*LRFACTOR;
	int j = x+y*pitch;//index on padded mem (pitch in elements)
	float f0,f1,f2,f3,f4,f5,f6,f7,f8;
	int im = ImageFcn(xcoord,ycoord);

	if(x < 2 || x > XLRDIM-3 || y < 2 || y > YLRDIM-3)
	{
	//interpolate for next time step. from A
	f0 = tex2D(texRef_f0A,xcoord+0.5f,ycoord+0.5f);//YDIM and not YLRDIM
	f1 = tex2D(texRef_f1A,xcoord+0.5f,ycoord+0.5f);
	f2 = tex2D(texRef_f2A,xcoord+0.5f,ycoord+0.5f);
	f3 = tex2D(texRef_f3A,xcoord+0.5f,ycoord+0.5f);
	f4 = tex2D(texRef_f4A,xcoord+0.5f,ycoord+0.5f);
	f5 = tex2D(texRef_f5A,xcoord+0.5f,ycoord+0.5f);
	f6 = tex2D(texRef_f6A,xcoord+0.5f,ycoord+0.5f);
	f7 = tex2D(texRef_f7A,xcoord+0.5f,ycoord+0.5f);
	f8 = tex2D(texRef_f8A,xcoord+0.5f,ycoord+0.5f);

	float rho,u,v;	
	rho = f0+f1+f2+f3+f4+f5+f6+f7+f8;
	u = f1-f3+f5-f6-f7+f8;
	v = f2-f4+f5+f6-f7-f8;
	float usqr = u*u+v*v;
	//scale
	fout[f_memLR(0,x,y,pitch)] =SF*f0+(1.0f-SF)*(0.4444444444f*(rho-1.5f*usqr));
	fout[f_memLR(1,x,y,pitch)] =SF*f1+(1.0f-SF)*(0.1111111111f*(rho+3.0f*u+4.5f*u*u-1.5f*usqr));                 
	fout[f_memLR(2,x,y,pitch)] =SF*f2+(1.0f-SF)*(0.1111111111f*(rho+3.0f*v+4.5f*v*v-1.5f*usqr));
	fout[f_memLR(3,x,y,pitch)] =SF*f3+(1.0f-SF)*(0.1111111111f*(rho-3.0f*u+4.5f*u*u-1.5f*usqr));
	fout[f_memLR(4,x,y,pitch)] =SF*f4+(1.0f-SF)*(0.1111111111f*(rho-3.0f*v+4.5f*v*v-1.5f*usqr));
	fout[f_memLR(5,x,y,pitch)] =SF*f5+(1.0f-SF)*(0.02777777778*(rho+3.0f*( u+v)+4.5f*( u+v)*( u+v)-1.5f*usqr));
	fout[f_memLR(6,x,y,pitch)] =SF*f6+(1.0f-SF)*(0.02777777778*(rho+3.0f*(-u+v)+4.5f*(-u+v)*(-u+v)-1.5f*usqr));
	fout[f_memLR(7,x,y,pitch)] =SF*f7+(1.0f-SF)*(0.02777777778*(rho+3.0f*(-u-v)+4.5f*(-u-v)*(-u-v)-1.5f*usqr));
	fout[f_memLR(8,x,y,pitch)] =SF*f8+(1.0f-SF)*(0.02777777778*(rho+3.0f*( u-v)+4.5f*( u-v)*( u-v)-1.5f*usqr));

//	f0 =SF*f0+(1.0f-SF)*(0.4444444444f*(rho-1.5f*usqr));
//	f1 =SF*f1+(1.0f-SF)*(0.1111111111f*(rho+3.0f*u+4.5f*u*u-1.5f*usqr));                 
//	f2 =SF*f2+(1.0f-SF)*(0.1111111111f*(rho+3.0f*v+4.5f*v*v-1.5f*usqr));
//	f3 =SF*f3+(1.0f-SF)*(0.1111111111f*(rho-3.0f*u+4.5f*u*u-1.5f*usqr));
//	f4 =SF*f4+(1.0f-SF)*(0.1111111111f*(rho-3.0f*v+4.5f*v*v-1.5f*usqr));
//	f5 =SF*f5+(1.0f-SF)*(0.02777777778*(rho+3.0f*( u+v)+4.5f*( u+v)*( u+v)-1.5f*usqr));
//	f6 =SF*f6+(1.0f-SF)*(0.02777777778*(rho+3.0f*(-u+v)+4.5f*(-u+v)*(-u+v)-1.5f*usqr));
//	f7 =SF*f7+(1.0f-SF)*(0.02777777778*(rho+3.0f*(-u-v)+4.5f*(-u-v)*(-u-v)-1.5f*usqr));
//	f8 =SF*f8+(1.0f-SF)*(0.02777777778*(rho+3.0f*( u-v)+4.5f*( u-v)*( u-v)-1.5f*usqr));
//	fout[f_memLR(0,x,y,pitch)] = f0 ;
//	fout[f_memLR(1,x,y,pitch)] = f1 ;
//	fout[f_memLR(2,x,y,pitch)] = f2 ;
//	fout[f_memLR(3,x,y,pitch)] = f3 ;
//	fout[f_memLR(4,x,y,pitch)] = f4 ;
//	fout[f_memLR(5,x,y,pitch)] = f5 ;
//	fout[f_memLR(6,x,y,pitch)] = f6 ;
//	fout[f_memLR(7,x,y,pitch)] = f7 ;
//	fout[f_memLR(8,x,y,pitch)] = f8 ;
	}
	else{
	f0 = fin[j];
	f1 = fin[f_memLR(1 ,dmax(x-1)     ,y             ,pitch)];
	f3 = fin[f_memLR(3 ,dmin(x+1,XDIM),y             ,pitch)];
	f2 = fin[f_memLR(2 ,x             ,y-1           ,pitch)];
	f5 = fin[f_memLR(5 ,dmax(x-1)     ,y-1           ,pitch)];
	f6 = fin[f_memLR(6 ,dmin(x+1,XDIM),y-1           ,pitch)];
	f4 = fin[f_memLR(4 ,x             ,y+1           ,pitch)];
	f7 = fin[f_memLR(7 ,dmin(x+1,XDIM),y+1           ,pitch)];
	f8 = fin[f_memLR(8 ,dmax(x-1)     ,dmin(y+1,YDIM),pitch)];
	if(im == 1 || im == 10){//BB
		fout[f_memLR(1 ,x,y,pitch)] = f3 ;
		fout[f_memLR(2 ,x,y,pitch)] = f4 ;
		fout[f_memLR(3 ,x,y,pitch)] = f1 ;
		fout[f_memLR(4 ,x,y,pitch)] = f2 ;
		fout[f_memLR(5 ,x,y,pitch)] = f7 ;
		fout[f_memLR(6 ,x,y,pitch)] = f8 ;
		fout[f_memLR(7 ,x,y,pitch)] = f5 ;
		fout[f_memLR(8 ,x,y,pitch)] = f6 ;
	}
	else{
		if(MODEL == "MRT")
		mrt_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,omega);
		else if(MODEL == "BGK")
		bgk_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,omega);

		fout[f_memLR(0 ,x,y,pitch)] = f0 ;
		fout[f_memLR(1 ,x,y,pitch)] = f1 ;
		fout[f_memLR(2 ,x,y,pitch)] = f2 ;
		fout[f_memLR(3 ,x,y,pitch)] = f3 ;
		fout[f_memLR(4 ,x,y,pitch)] = f4 ;
		fout[f_memLR(5 ,x,y,pitch)] = f5 ;
		fout[f_memLR(6 ,x,y,pitch)] = f6 ;
		fout[f_memLR(7 ,x,y,pitch)] = f7 ;
		fout[f_memLR(8 ,x,y,pitch)] = f8 ;
	}
	}//end else (not at edge of LR)
}
__global__ void mrt_d_single(float* fA, float* fB,
							float omega, size_t pitch)//pitch in elements
{
	int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
	int y = threadIdx.y+blockIdx.y*blockDim.y;
	int j = x+y*pitch;//index on padded mem (pitch in elements)
	int im = ImageFcn(x,y);
	float f0,f1,f2,f3,f4,f5,f6,f7,f8;
	//if(REFINEMENT == "YES" && x > LRX0+1 && x < LRX0+(XLRDIM-1)*LRFACTOR-1 && y > LRY0+1 && y < LRY0+(YLRDIM-1)*LRFACTOR-1){
	if((REFINEMENT == "YES" && x > LRX0+1 && x < LRX0+(XLRDIM-1)*LRFACTOR-1 && y > LRY0+1 && y < LRY0+(YLRDIM-1)*LRFACTOR-1) || (x>XDIM-1)){
	}
	else{
	f0 = fA[j];
	f1 = fA[f_mem(1 ,dmax(x-1)     ,y             ,pitch)];
	f3 = fA[f_mem(3 ,dmin(x+1,XDIM),y             ,pitch)];
	f2 = fA[f_mem(2 ,x             ,y-1           ,pitch)];
	f5 = fA[f_mem(5 ,dmax(x-1)     ,y-1           ,pitch)];
	f6 = fA[f_mem(6 ,dmin(x+1,XDIM),y-1           ,pitch)];
	f4 = fA[f_mem(4 ,x             ,y+1           ,pitch)];
	f7 = fA[f_mem(7 ,dmin(x+1,XDIM),y+1           ,pitch)];
	f8 = fA[f_mem(8 ,dmax(x-1)     ,dmin(y+1,YDIM),pitch)];
	if(im == 1 || im == 10){//BB
		//atomicAdd();
		fB[f_mem(1 ,x,y,pitch)] = f3 ;
		fB[f_mem(2 ,x,y,pitch)] = f4 ;
		fB[f_mem(3 ,x,y,pitch)] = f1 ;
		fB[f_mem(4 ,x,y,pitch)] = f2 ;
		fB[f_mem(5 ,x,y,pitch)] = f7 ;
		fB[f_mem(6 ,x,y,pitch)] = f8 ;
		fB[f_mem(7 ,x,y,pitch)] = f5 ;
		fB[f_mem(8 ,x,y,pitch)] = f6 ;
	}
	else{
//		if(im == 2)//NeumannEast
//		{
//			NeumannEast(f0,f1,f2,f3,f4,f5,f6,f7,f8,y);
//		}
//		else if(im == 3)//DirichletWest
//		{
//			DirichletWest(f0,f1,f2,f3,f4,f5,f6,f7,f8,y);
//		}

		boundaries(f0,f1,f2,f3,f4,f5,f6,f7,f8,y,im);

		if(MODEL == "MRT")
		mrt_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,omega);
		else if(MODEL == "BGK")
		bgk_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,omega);

		fB[f_mem(0 ,x,y,pitch)] = f0 ;
		fB[f_mem(1 ,x,y,pitch)] = f1 ;
		fB[f_mem(2 ,x,y,pitch)] = f2 ;
		fB[f_mem(3 ,x,y,pitch)] = f3 ;
		fB[f_mem(4 ,x,y,pitch)] = f4 ;
		fB[f_mem(5 ,x,y,pitch)] = f5 ;
		fB[f_mem(6 ,x,y,pitch)] = f6 ;
		fB[f_mem(7 ,x,y,pitch)] = f7 ;
		fB[f_mem(8 ,x,y,pitch)] = f8 ;
	}
	}

}

__global__ void mrt_d_single_force(float* fA, float* fB,
							float omega, size_t pitch, float *FX, float *FY, int t)//pitch in elements
{
	int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
	int y = threadIdx.y+blockIdx.y*blockDim.y;
	int j = x+y*pitch;//index on padded mem (pitch in elements)
	int im = ImageFcn(x,y);
	//int check = 0; //check if block contains force calculation nodes
	float f0,f1,f2,f3,f4,f5,f6,f7,f8;
	__shared__ float sumX[BLOCKSIZEX], sumY[BLOCKSIZEX];
	__shared__ int check[1];
	check[0] = 0;
	syncthreads();

	if((REFINEMENT == "YES" && x > LRX0+1 && x < LRX0+(XLRDIM-1)*LRFACTOR-1 && y > LRY0+1 && y < LRY0+(YLRDIM-1)*LRFACTOR-1) || (x>XDIM-1)){
	}
	else{
	f0 = fA[j];
	f1 = fA[f_mem(1 ,dmax(x-1)     ,y             ,pitch)];
	f3 = fA[f_mem(3 ,dmin(x+1,XDIM),y             ,pitch)];
	f2 = fA[f_mem(2 ,x             ,y-1           ,pitch)];
	f5 = fA[f_mem(5 ,dmax(x-1)     ,y-1           ,pitch)];
	f6 = fA[f_mem(6 ,dmin(x+1,XDIM),y-1           ,pitch)];
	f4 = fA[f_mem(4 ,x             ,y+1           ,pitch)];
	f7 = fA[f_mem(7 ,dmin(x+1,XDIM),y+1           ,pitch)];
	f8 = fA[f_mem(8 ,dmax(x-1)     ,dmin(y+1,YDIM),pitch)];
	if(im == 1 || im == 10){//BB
		if(im == 10){
		check[0] = 1;
		//check = 1;
		sumX[threadIdx.x]=2.f*f1-2.f*f3+2.f*f5+2.f*f8-2.f*f6-2.f*f7;
		sumY[threadIdx.x]=2.f*f2-2.f*f4+2.f*f5-2.f*f8+2.f*f6-2.f*f7;
		}
		else{
		sumX[threadIdx.x]=0.f;
		sumY[threadIdx.x]=0.f;
		}
		//atomicAdd();
		fB[f_mem(1 ,x,y,pitch)] = f3 ;
		fB[f_mem(2 ,x,y,pitch)] = f4 ;
		fB[f_mem(3 ,x,y,pitch)] = f1 ;
		fB[f_mem(4 ,x,y,pitch)] = f2 ;
		fB[f_mem(5 ,x,y,pitch)] = f7 ;
		fB[f_mem(6 ,x,y,pitch)] = f8 ;
		fB[f_mem(7 ,x,y,pitch)] = f5 ;
		fB[f_mem(8 ,x,y,pitch)] = f6 ;
	}
	else{
		sumX[threadIdx.x]=0.f;
		sumY[threadIdx.x]=0.f;
//		if(im == 2)//NeumannEast
//		{
//			NeumannEast(f0,f1,f2,f3,f4,f5,f6,f7,f8,y);
//		}
//		else if(im == 3)//DirichletWest
//		{
//			DirichletWest(f0,f1,f2,f3,f4,f5,f6,f7,f8,y);
//		}

		boundaries_force(f0,f1,f2,f3,f4,f5,f6,f7,f8,y,im);

		if(MODEL == "MRT")
		mrt_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,omega);
		else if(MODEL == "BGK")
		bgk_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,omega);

		fB[f_mem(0 ,x,y,pitch)] = f0 ;
		fB[f_mem(1 ,x,y,pitch)] = f1 ;
		fB[f_mem(2 ,x,y,pitch)] = f2 ;
		fB[f_mem(3 ,x,y,pitch)] = f3 ;
		fB[f_mem(4 ,x,y,pitch)] = f4 ;
		fB[f_mem(5 ,x,y,pitch)] = f5 ;
		fB[f_mem(6 ,x,y,pitch)] = f6 ;
		fB[f_mem(7 ,x,y,pitch)] = f7 ;
		fB[f_mem(8 ,x,y,pitch)] = f8 ;
	}

	syncthreads();
	if(check[0] == 1 && t>=STARTF){
	//reduction for force
	int nTotalThreads = blockDim.x;
	while(nTotalThreads > 1){
		int halfPoint = (nTotalThreads >> 1);
		if(threadIdx.x < halfPoint){
			sumX[threadIdx.x] += sumX[threadIdx.x+halfPoint];
			sumY[threadIdx.x] += sumY[threadIdx.x+halfPoint];
		}
		syncthreads();
		nTotalThreads = halfPoint;
	}
	if(threadIdx.x == 0){
		atomicAdd(&FX[t],sumX[0]);
		atomicAdd(&FY[t],sumY[0]);
	}
	}
	}
}
__global__ void mrt_d_hybAB_force(float* fin, float* fout,
							float omega, size_t pitch, float *FX, float *FY, int t)//pitch in elements
{
	int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
	int y = threadIdx.y+blockIdx.y*blockDim.y;//;
	int j = x+y*pitch;//index on padded mem (pitch in elements)
	float f0,f1,f2,f3,f4,f5,f6,f7,f8;
	__shared__ float sumX[BLOCKSIZEX], sumY[BLOCKSIZEX];
	__shared__ int check[1];
	check[0] = 0;
	syncthreads();

	if((REFINEMENT == "YES" && x > LRX0+1 && x < LRX0+(XLRDIM-1)*LRFACTOR-1 && y > LRY0+1 && y < LRY0+(YLRDIM-1)*LRFACTOR-1) || (x>XDIM-1)){
	}
	else{

	f0 = fin[j];
	f2 = fin[f_mem(2 ,x  ,y-1,pitch)];
	f4 = fin[f_mem(4 ,x  ,y+1,pitch)];
//	f1 = tex2D(texRef_f1A ,xcoord-1,ycoord  );
//	f3 = tex2D(texRef_f3A ,xcoord+1,ycoord  );
//	f5 = tex2D(texRef_f5A ,xcoord-1,ycoord-1);
//	f6 = tex2D(texRef_f6A ,xcoord+1,ycoord-1);
//	f7 = tex2D(texRef_f7A ,xcoord+1,ycoord+1);
//	f8 = tex2D(texRef_f8A ,xcoord-1,ycoord+1);

	f1 = tex2D(texRef_f1A ,x-1+0.5f,y  +0.5f);
	f3 = tex2D(texRef_f3A ,x+1+0.5f,y  +0.5f);
	f5 = tex2D(texRef_f5A ,x-1+0.5f,y-1+0.5f);
	f6 = tex2D(texRef_f6A ,x+1+0.5f,y-1+0.5f);
	f7 = tex2D(texRef_f7A ,x+1+0.5f,y+1+0.5f);
	f8 = tex2D(texRef_f8A ,x-1+0.5f,y+1+0.5f);

	int im = ImageFcn(x,y);
	if(im == 1 || im == 10){//BB
		if(im == 10){
		check[0] = 1;
		sumX[threadIdx.x]=2.f*f1-2.f*f3+2.f*f5+2.f*f8-2.f*f6-2.f*f7;
		sumY[threadIdx.x]=2.f*f2-2.f*f4+2.f*f5-2.f*f8+2.f*f6-2.f*f7;
		}
		else{
		sumX[threadIdx.x]=0.f;
		sumY[threadIdx.x]=0.f;
		}
		fout[f_mem(1 ,x,y,pitch)] = f3 ;
		fout[f_mem(2 ,x,y,pitch)] = f4 ;
		fout[f_mem(3 ,x,y,pitch)] = f1 ;
		fout[f_mem(4 ,x,y,pitch)] = f2 ;
		fout[f_mem(5 ,x,y,pitch)] = f7 ;
		fout[f_mem(6 ,x,y,pitch)] = f8 ;
		fout[f_mem(7 ,x,y,pitch)] = f5 ;
		fout[f_mem(8 ,x,y,pitch)] = f6 ;
	}
	else{
		sumX[threadIdx.x]=0.f;
		sumY[threadIdx.x]=0.f;
//		if(im == 2)//NeumannEast
//		{
//			NeumannEast(f0,f1,f2,f3,f4,f5,f6,f7,f8,y);
//		}
//		else if(im == 3)//DirichletWest
//		{
//			DirichletWest(f0,f1,f2,f3,f4,f5,f6,f7,f8,y);
//		}
//		else if(im == 11)//xsymmetry
//		{
//			f4 = f2;
//			f7 = f6;
//			f8 = f5;
//		}
//		else if(im == 12)//xsymmetry
//		{
//			f2 = f4;
//			f6 = f7;
//			f5 = f8;
//		}

		boundaries_force(f0,f1,f2,f3,f4,f5,f6,f7,f8,y,im);

		if(MODEL == "MRT")
		mrt_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,omega);
		else if(MODEL == "BGK")
		bgk_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,omega);

		fout[f_mem(0 ,x,y,pitch)] = f0 ;
		fout[f_mem(1 ,x,y,pitch)] = f1 ;
		fout[f_mem(2 ,x,y,pitch)] = f2 ;
		fout[f_mem(3 ,x,y,pitch)] = f3 ;
		fout[f_mem(4 ,x,y,pitch)] = f4 ;
		fout[f_mem(5 ,x,y,pitch)] = f5 ;
		fout[f_mem(6 ,x,y,pitch)] = f6 ;
		fout[f_mem(7 ,x,y,pitch)] = f7 ;
		fout[f_mem(8 ,x,y,pitch)] = f8 ;

	}

	syncthreads();
	if(check[0] == 1 && t>=STARTF){
	//reduction for force
	int nTotalThreads = blockDim.x;
	while(nTotalThreads > 1){
		int halfPoint = (nTotalThreads >> 1);
		if(threadIdx.x < halfPoint){
			sumX[threadIdx.x] += sumX[threadIdx.x+halfPoint];
			sumY[threadIdx.x] += sumY[threadIdx.x+halfPoint];
		}
		syncthreads();
		nTotalThreads = halfPoint;
	}
	if(threadIdx.x == 0){
		atomicAdd(&FX[t],sumX[0]);
		atomicAdd(&FY[t],sumY[0]);
	}
	}

	}//outside the refinement area
}

__global__ void mrt_d_hybBA_force(float* fin, float* fout,
							float omega, size_t pitch, float *FX, float *FY, int t)//pitch in elements
{
	int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
	int y = threadIdx.y+blockIdx.y*blockDim.y;//;
	int j = x+y*pitch;//index on padded mem (pitch in elements)
	float f0,f1,f2,f3,f4,f5,f6,f7,f8;
	__shared__ float sumX[BLOCKSIZEX], sumY[BLOCKSIZEX];
	__shared__ int check[1];
	check[0] = 0;
	syncthreads();

	if((REFINEMENT == "YES" && x > LRX0+1 && x < LRX0+(XLRDIM-1)*LRFACTOR-1 && y > LRY0+1 && y < LRY0+(YLRDIM-1)*LRFACTOR-1) || (x>XDIM-1)){
	}
	else{

	f0 = fin[j];
	f2 = fin[f_mem(2 ,x  ,y-1,pitch)];
	f4 = fin[f_mem(4 ,x  ,y+1,pitch)];
//	f1 = tex2D(texRef_f1A ,xcoord-1,ycoord  );
//	f3 = tex2D(texRef_f3A ,xcoord+1,ycoord  );
//	f5 = tex2D(texRef_f5A ,xcoord-1,ycoord-1);
//	f6 = tex2D(texRef_f6A ,xcoord+1,ycoord-1);
//	f7 = tex2D(texRef_f7A ,xcoord+1,ycoord+1);
//	f8 = tex2D(texRef_f8A ,xcoord-1,ycoord+1);

	f1 = tex2D(texRef_f1B ,x-1+0.5f,y  +0.5f);
	f3 = tex2D(texRef_f3B ,x+1+0.5f,y  +0.5f);
	f5 = tex2D(texRef_f5B ,x-1+0.5f,y-1+0.5f);
	f6 = tex2D(texRef_f6B ,x+1+0.5f,y-1+0.5f);
	f7 = tex2D(texRef_f7B ,x+1+0.5f,y+1+0.5f);
	f8 = tex2D(texRef_f8B ,x-1+0.5f,y+1+0.5f);

	int im = ImageFcn(x,y);
	if(im == 1 || im == 10){//BB
		if(im == 10){
		check[0] = 1;
		sumX[threadIdx.x]=2.f*f1-2.f*f3+2.f*f5+2.f*f8-2.f*f6-2.f*f7;
		sumY[threadIdx.x]=2.f*f2-2.f*f4+2.f*f5-2.f*f8+2.f*f6-2.f*f7;
		}
		else{
		sumX[threadIdx.x]=0.f;
		sumY[threadIdx.x]=0.f;
		}
		fout[f_mem(1 ,x,y,pitch)] = f3 ;
		fout[f_mem(2 ,x,y,pitch)] = f4 ;
		fout[f_mem(3 ,x,y,pitch)] = f1 ;
		fout[f_mem(4 ,x,y,pitch)] = f2 ;
		fout[f_mem(5 ,x,y,pitch)] = f7 ;
		fout[f_mem(6 ,x,y,pitch)] = f8 ;
		fout[f_mem(7 ,x,y,pitch)] = f5 ;
		fout[f_mem(8 ,x,y,pitch)] = f6 ;
	}
	else{
		sumX[threadIdx.x]=0.f;
		sumY[threadIdx.x]=0.f;
//		if(im == 2)//NeumannEast
//		{
//			NeumannEast(f0,f1,f2,f3,f4,f5,f6,f7,f8,y);
//		}
//		else if(im == 3)//DirichletWest
//		{
//			DirichletWest(f0,f1,f2,f3,f4,f5,f6,f7,f8,y);
//		}
//		else if(im == 11)//xsymmetry
//		{
//			f4 = f2;
//			f7 = f6;
//			f8 = f5;
//		}
//		else if(im == 12)//xsymmetry
//		{
//			f2 = f4;
//			f6 = f7;
//			f5 = f8;
//		}

		boundaries_force(f0,f1,f2,f3,f4,f5,f6,f7,f8,y,im);

		if(MODEL == "MRT")
		mrt_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,omega);
		else if(MODEL == "BGK")
		bgk_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,omega);

		fout[f_mem(0 ,x,y,pitch)] = f0 ;
		fout[f_mem(1 ,x,y,pitch)] = f1 ;
		fout[f_mem(2 ,x,y,pitch)] = f2 ;
		fout[f_mem(3 ,x,y,pitch)] = f3 ;
		fout[f_mem(4 ,x,y,pitch)] = f4 ;
		fout[f_mem(5 ,x,y,pitch)] = f5 ;
		fout[f_mem(6 ,x,y,pitch)] = f6 ;
		fout[f_mem(7 ,x,y,pitch)] = f7 ;
		fout[f_mem(8 ,x,y,pitch)] = f8 ;

	}

	syncthreads();
	if(check[0] == 1 && t>=STARTF){
	//reduction for force
	int nTotalThreads = blockDim.x;
	while(nTotalThreads > 1){
		int halfPoint = (nTotalThreads >> 1);
		if(threadIdx.x < halfPoint){
			sumX[threadIdx.x] += sumX[threadIdx.x+halfPoint];
			sumY[threadIdx.x] += sumY[threadIdx.x+halfPoint];
		}
		syncthreads();
		nTotalThreads = halfPoint;
	}
	if(threadIdx.x == 0){
		atomicAdd(&FX[t],sumX[0]);
		atomicAdd(&FY[t],sumY[0]);
	}
	}

	}//outside the refinement area
}

__global__ void mrt_d_hybAB(float* fin, float* fout,
							float omega, size_t pitch)//pitch in elements
{
	int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
	int y = threadIdx.y+blockIdx.y*blockDim.y;//;
	int j = x+y*pitch;//index on padded mem (pitch in elements)
	float f0,f1,f2,f3,f4,f5,f6,f7,f8;

	if((REFINEMENT == "YES" && x > LRX0+1 && x < LRX0+(XLRDIM-1)*LRFACTOR-1 && y > LRY0+1 && y < LRY0+(YLRDIM-1)*LRFACTOR-1) || (x>XDIM-1)){
	}
	else{

	f0 = fin[j];
	f2 = fin[f_mem(2 ,x  ,y-1,pitch)];
	f4 = fin[f_mem(4 ,x  ,y+1,pitch)];
	f1 = tex2D(texRef_f1A ,x-1+0.5f,y  +0.5f);
	f3 = tex2D(texRef_f3A ,x+1+0.5f,y  +0.5f);
	f5 = tex2D(texRef_f5A ,x-1+0.5f,y-1+0.5f);
	f6 = tex2D(texRef_f6A ,x+1+0.5f,y-1+0.5f);
	f7 = tex2D(texRef_f7A ,x+1+0.5f,y+1+0.5f);
	f8 = tex2D(texRef_f8A ,x-1+0.5f,y+1+0.5f);

	int im = ImageFcn(x,y);
	if(im == 1 || im == 10){//BB
		fout[f_mem(1 ,x,y,pitch)] = f3 ;
		fout[f_mem(2 ,x,y,pitch)] = f4 ;
		fout[f_mem(3 ,x,y,pitch)] = f1 ;
		fout[f_mem(4 ,x,y,pitch)] = f2 ;
		fout[f_mem(5 ,x,y,pitch)] = f7 ;
		fout[f_mem(6 ,x,y,pitch)] = f8 ;
		fout[f_mem(7 ,x,y,pitch)] = f5 ;
		fout[f_mem(8 ,x,y,pitch)] = f6 ;
	}
	else{
//		if(im == 2)//NeumannEast
//		{
//			NeumannEast(f0,f1,f2,f3,f4,f5,f6,f7,f8,y);
//		}
//		else if(im == 3)//DirichletWest
//		{
//			DirichletWest(f0,f1,f2,f3,f4,f5,f6,f7,f8,y);
//		}
//		else if(im == 11)//xsymmetry
//		{
//			f4 = f2;
//			f7 = f6;
//			f8 = f5;
//		}
//		else if(im == 12)//xsymmetry
//		{
//			f2 = f4;
//			f6 = f7;
//			f5 = f8;
//		}
	
		boundaries(f0,f1,f2,f3,f4,f5,f6,f7,f8,y,im);

		if(MODEL == "MRT")
		mrt_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,omega);
		else if(MODEL == "BGK")
		bgk_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,omega);
		fout[f_mem(0 ,x,y,pitch)] = f0 ;
		fout[f_mem(1 ,x,y,pitch)] = f1 ;
		fout[f_mem(2 ,x,y,pitch)] = f2 ;
		fout[f_mem(3 ,x,y,pitch)] = f3 ;
		fout[f_mem(4 ,x,y,pitch)] = f4 ;
		fout[f_mem(5 ,x,y,pitch)] = f5 ;
		fout[f_mem(6 ,x,y,pitch)] = f6 ;
		fout[f_mem(7 ,x,y,pitch)] = f7 ;
		fout[f_mem(8 ,x,y,pitch)] = f8 ;
	}
	}
}
__global__ void mrt_d_hybBA(float* fin, float* fout,
							float omega, size_t pitch)//pitch in elements
{
	int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
	int y = threadIdx.y+blockIdx.y*blockDim.y;//;
	int j = x+y*pitch;//index on padded mem (pitch in elements)
	float f0,f1,f2,f3,f4,f5,f6,f7,f8;
//	if((REFINEMENT == "YES" && x > LRX0+1 && x < LRX0+(XLRDIM-1)*LRFACTOR-1 && y > LRY0+1 && y < LRY0+(YLRDIM-1)*LRFACTOR-1) || (x>XDIM-1)){
//	}
//	else{
	f0 = fin[j];
	f2 = fin[f_mem(2 ,x  ,y-1,pitch)];
	f4 = fin[f_mem(4 ,x  ,y+1,pitch)];
	f1 = tex2D(texRef_f1B ,x-1+0.5f,y  +0.5f);
	f3 = tex2D(texRef_f3B ,x+1+0.5f,y  +0.5f);
	f5 = tex2D(texRef_f5B ,x-1+0.5f,y-1+0.5f);
	f6 = tex2D(texRef_f6B ,x+1+0.5f,y-1+0.5f);
	f7 = tex2D(texRef_f7B ,x+1+0.5f,y+1+0.5f);
	f8 = tex2D(texRef_f8B ,x-1+0.5f,y+1+0.5f);

	int im = ImageFcn(x,y);
	if(im == 1 || im == 10){//BB
		fout[f_mem(1 ,x,y,pitch)] = f3 ;
		fout[f_mem(2 ,x,y,pitch)] = f4 ;
		fout[f_mem(3 ,x,y,pitch)] = f1 ;
		fout[f_mem(4 ,x,y,pitch)] = f2 ;
		fout[f_mem(5 ,x,y,pitch)] = f7 ;
		fout[f_mem(6 ,x,y,pitch)] = f8 ;
		fout[f_mem(7 ,x,y,pitch)] = f5 ;
		fout[f_mem(8 ,x,y,pitch)] = f6 ;
	}
	else{
//		if(im == 2)//NeumannEast
//		{
//			NeumannEast(f0,f1,f2,f3,f4,f5,f6,f7,f8,y);
//		}
//		else if(im == 3)//DirichletWest
//		{
//			DirichletWest(f0,f1,f2,f3,f4,f5,f6,f7,f8,y);
//		}
//		else if(im == 11)//xsymmetry
//		{
//			f4 = f2;
//			f7 = f6;
//			f8 = f5;
//		}
//		else if(im == 12)//xsymmetry
//		{
//			f2 = f4;
//			f6 = f7;
//			f5 = f8;
//		}

		boundaries(f1,f1,f2,f3,f4,f5,f6,f7,f8,y,im);

		if(MODEL == "MRT")
		mrt_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,omega);
		else if(MODEL == "BGK")
		bgk_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,omega);
		fout[f_mem(0 ,x,y,pitch)] = f0 ;
		fout[f_mem(1 ,x,y,pitch)] = f1 ;
		fout[f_mem(2 ,x,y,pitch)] = f2 ;
		fout[f_mem(3 ,x,y,pitch)] = f3 ;
		fout[f_mem(4 ,x,y,pitch)] = f4 ;
		fout[f_mem(5 ,x,y,pitch)] = f5 ;
		fout[f_mem(6 ,x,y,pitch)] = f6 ;
		fout[f_mem(7 ,x,y,pitch)] = f7 ;
		fout[f_mem(8 ,x,y,pitch)] = f8 ;
	}
//	}
}
__global__ void mrt_d_textAB(float* fin, float* fout,
							float omega, size_t pitch)//pitch in elements
{
	int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
	int y = threadIdx.y+blockIdx.y*blockDim.y;//;
	int j = x+y*pitch;//index on padded mem (pitch in elements)
	float f0,f1,f2,f3,f4,f5,f6,f7,f8;
	f0 = fin[j];
	f2 = tex2D(texRef_f2A ,x  +0.5f,y-1+0.5f);
	f4 = tex2D(texRef_f4A ,x  +0.5f,y+1+0.5f);
	f1 = tex2D(texRef_f1A ,x-1+0.5f,y  +0.5f);
	f3 = tex2D(texRef_f3A ,x+1+0.5f,y  +0.5f);
	f5 = tex2D(texRef_f5A ,x-1+0.5f,y-1+0.5f);
	f6 = tex2D(texRef_f6A ,x+1+0.5f,y-1+0.5f);
	f7 = tex2D(texRef_f7A ,x+1+0.5f,y+1+0.5f);
	f8 = tex2D(texRef_f8A ,x-1+0.5f,y+1+0.5f);

	int im = ImageFcn(x,y);
	if(im == 1 || im == 10){//BB
		fout[f_mem(1 ,x,y,pitch)] = f3 ;
		fout[f_mem(2 ,x,y,pitch)] = f4 ;
		fout[f_mem(3 ,x,y,pitch)] = f1 ;
		fout[f_mem(4 ,x,y,pitch)] = f2 ;
		fout[f_mem(5 ,x,y,pitch)] = f7 ;
		fout[f_mem(6 ,x,y,pitch)] = f8 ;
		fout[f_mem(7 ,x,y,pitch)] = f5 ;
		fout[f_mem(8 ,x,y,pitch)] = f6 ;
	}
	else{
		if(im == 2)//NeumannEast
		{
			NeumannEast(f0,f1,f2,f3,f4,f5,f6,f7,f8,y);
		}
		else if(im == 3)//DirichletWest
		{
			DirichletWest(f0,f1,f2,f3,f4,f5,f6,f7,f8,y);
		}

		if(MODEL == "MRT")
		mrt_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,omega);
		else if(MODEL == "BGK")
		bgk_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,omega);

		fout[f_mem(0 ,x,y,pitch)] = f0 ;
		fout[f_mem(1 ,x,y,pitch)] = f1 ;
		fout[f_mem(2 ,x,y,pitch)] = f2 ;
		fout[f_mem(3 ,x,y,pitch)] = f3 ;
		fout[f_mem(4 ,x,y,pitch)] = f4 ;
		fout[f_mem(5 ,x,y,pitch)] = f5 ;
		fout[f_mem(6 ,x,y,pitch)] = f6 ;
		fout[f_mem(7 ,x,y,pitch)] = f7 ;
		fout[f_mem(8 ,x,y,pitch)] = f8 ;

	}
}
__global__ void mrt_d_textBA(float* fin, float* fout,
							float omega, size_t pitch)//pitch in elements
{
	int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
	int y = threadIdx.y+blockIdx.y*blockDim.y;//;
	int j = x+y*pitch;//index on padded mem (pitch in elements)
	float f0,f1,f2,f3,f4,f5,f6,f7,f8;
	f0 = fin[j];
	f2 = tex2D(texRef_f2B ,x  +0.5f,y-1+0.5f);
	f4 = tex2D(texRef_f4B ,x  +0.5f,y+1+0.5f);
	f1 = tex2D(texRef_f1B ,x-1+0.5f,y  +0.5f);
	f3 = tex2D(texRef_f3B ,x+1+0.5f,y  +0.5f);
	f5 = tex2D(texRef_f5B ,x-1+0.5f,y-1+0.5f);
	f6 = tex2D(texRef_f6B ,x+1+0.5f,y-1+0.5f);
	f7 = tex2D(texRef_f7B ,x+1+0.5f,y+1+0.5f);
	f8 = tex2D(texRef_f8B ,x-1+0.5f,y+1+0.5f);

	int im = ImageFcn(x,y);
	if(im == 1 || im == 10){//BB
		fout[f_mem(1 ,x,y,pitch)] = f3 ;
		fout[f_mem(2 ,x,y,pitch)] = f4 ;
		fout[f_mem(3 ,x,y,pitch)] = f1 ;
		fout[f_mem(4 ,x,y,pitch)] = f2 ;
		fout[f_mem(5 ,x,y,pitch)] = f7 ;
		fout[f_mem(6 ,x,y,pitch)] = f8 ;
		fout[f_mem(7 ,x,y,pitch)] = f5 ;
		fout[f_mem(8 ,x,y,pitch)] = f6 ;
	}
	else{
		if(im == 2)//NeumannEast
		{
			NeumannEast(f0,f1,f2,f3,f4,f5,f6,f7,f8,y);
		}
		else if(im == 3)//DirichletWest
		{
			DirichletWest(f0,f1,f2,f3,f4,f5,f6,f7,f8,y);
		}

		if(MODEL == "MRT")
		mrt_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,omega);
		else if(MODEL == "BGK")
		bgk_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,omega);

		fout[f_mem(0 ,x,y,pitch)] = f0 ;
		fout[f_mem(1 ,x,y,pitch)] = f1 ;
		fout[f_mem(2 ,x,y,pitch)] = f2 ;
		fout[f_mem(3 ,x,y,pitch)] = f3 ;
		fout[f_mem(4 ,x,y,pitch)] = f4 ;
		fout[f_mem(5 ,x,y,pitch)] = f5 ;
		fout[f_mem(6 ,x,y,pitch)] = f6 ;
		fout[f_mem(7 ,x,y,pitch)] = f7 ;
		fout[f_mem(8 ,x,y,pitch)] = f8 ;

	}
}


__global__ void mrt_d_LR(float* fA, float* fB,
							float omega, size_t pitch, float SF)//pitch in elements
{
	int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
	int y = threadIdx.y+blockIdx.y*blockDim.y;
	int j = x+y*pitch;//index on padded mem (pitch in elements)
	int im = ImageFcn(x,y);
	float f0,f1,f2,f3,f4,f5,f6,f7,f8;

	f0 = fA[j];
	f1 = fA[f_mem(1 ,dmax(x-1)     ,y             ,pitch)];
	f3 = fA[f_mem(3 ,dmin(x+1,XDIM),y             ,pitch)];
	f2 = fA[f_mem(2 ,x             ,y-1           ,pitch)];
	f5 = fA[f_mem(5 ,dmax(x-1)     ,y-1           ,pitch)];
	f6 = fA[f_mem(6 ,dmin(x+1,XDIM),y-1           ,pitch)];
	f4 = fA[f_mem(4 ,x             ,y+1           ,pitch)];
	f7 = fA[f_mem(7 ,dmin(x+1,XDIM),y+1           ,pitch)];
	f8 = fA[f_mem(8 ,dmax(x-1)     ,dmin(y+1,YDIM),pitch)];
	if(im == 1 || im == 10){//BB
		fB[f_mem(1 ,x,y,pitch)] = f3 ;
		fB[f_mem(2 ,x,y,pitch)] = f4 ;
		fB[f_mem(3 ,x,y,pitch)] = f1 ;
		fB[f_mem(4 ,x,y,pitch)] = f2 ;
		fB[f_mem(5 ,x,y,pitch)] = f7 ;
		fB[f_mem(6 ,x,y,pitch)] = f8 ;
		fB[f_mem(7 ,x,y,pitch)] = f5 ;
		fB[f_mem(8 ,x,y,pitch)] = f6 ;
	}
	else{
		if(im == 3)//DirichletWest
		{
			if(y == 0){
				f2 = f4;
				f6 = f7;
			}
			else if(y == YDIM-1){
				f4 = f2;
				f7 = f6;
			}
			float u,v;//,rho;
			u = 0.0f;
	        v = UMAX;//0.0;
			f1 = f3+u*0.66666667f;
	        f5 = f7-0.5f*(f2-f4)+v*0.5f+u*0.166666667f;
	        f8 = f6+0.5f*(f2-f4)-v*0.5f+u*0.166666667f;			
		}

		if(MODEL == "MRT")
		mrt_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,omega);
		else if(MODEL == "BGK")
		bgk_collide(f0,f1,f2,f3,f4,f5,f6,f7,f8,omega);

		fB[f_mem(0 ,x,y,pitch)] = f0 ;
		fB[f_mem(1 ,x,y,pitch)] = f1 ;
		fB[f_mem(2 ,x,y,pitch)] = f2 ;
		fB[f_mem(3 ,x,y,pitch)] = f3 ;
		fB[f_mem(4 ,x,y,pitch)] = f4 ;
		fB[f_mem(5 ,x,y,pitch)] = f5 ;
		fB[f_mem(6 ,x,y,pitch)] = f6 ;
		fB[f_mem(7 ,x,y,pitch)] = f7 ;
		fB[f_mem(8 ,x,y,pitch)] = f8 ;
	}
}


__global__ void initialize_single(float *f, size_t pitch)//pitch in elements
{
	int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
	int y = threadIdx.y+blockIdx.y*blockDim.y;
	int j = x+y*pitch;//index on padded mem (pitch in elements)
	if(x<XDIM && y<YDIM){
	float u,v,rho,usqr;
	rho = 1.f;
	u = 0.0f;
	v = 0.0f;
	usqr = u*u+v*v;

	f[j+0 *pitch*YDIM]= 0.4444444444f*(rho-1.5f*usqr);
	f[j+1 *pitch*YDIM]= 0.1111111111f*(rho+3.0f*u+4.5f*u*u-1.5f*usqr);               
	f[j+2 *pitch*YDIM]= 0.1111111111f*(rho+3.0f*v+4.5f*v*v-1.5f*usqr);
	f[j+3 *pitch*YDIM]= 0.1111111111f*(rho-3.0f*u+4.5f*u*u-1.5f*usqr);
	f[j+4 *pitch*YDIM]= 0.1111111111f*(rho-3.0f*v+4.5f*v*v-1.5f*usqr);
	f[j+5 *pitch*YDIM]= 0.02777777778*(rho+3.0f*( u+v)+4.5f*( u+v)*( u+v)-1.5f*usqr);
	f[j+6 *pitch*YDIM]= 0.02777777778*(rho+3.0f*(-u+v)+4.5f*(-u+v)*(-u+v)-1.5f*usqr);
	f[j+7 *pitch*YDIM]= 0.02777777778*(rho+3.0f*(-u-v)+4.5f*(-u-v)*(-u-v)-1.5f*usqr);
	f[j+8 *pitch*YDIM]= 0.02777777778*(rho+3.0f*( u-v)+4.5f*( u-v)*( u-v)-1.5f*usqr);
	}
}


__global__ void initialize_LR(float *f, size_t pitch)//pitch in elements
{
	int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
	int y = threadIdx.y+blockIdx.y*blockDim.y;
	int j = x+y*pitch;//index on padded mem (pitch in elements)
	if(x<XLRDIM && y<YLRDIM){
	float u,v,rho,usqr;
	rho = 1.f;
	u = 0.0f;
	v = 0.0f;
	usqr = u*u+v*v;

	f[j+0 *pitch*YLRDIM]= 0.4444444444f*(rho-1.5f*usqr);
	f[j+1 *pitch*YLRDIM]= 0.1111111111f*(rho+3.0f*u+4.5f*u*u-1.5f*usqr);               
	f[j+2 *pitch*YLRDIM]= 0.1111111111f*(rho+3.0f*v+4.5f*v*v-1.5f*usqr);
	f[j+3 *pitch*YLRDIM]= 0.1111111111f*(rho-3.0f*u+4.5f*u*u-1.5f*usqr);
	f[j+4 *pitch*YLRDIM]= 0.1111111111f*(rho-3.0f*v+4.5f*v*v-1.5f*usqr);
	f[j+5 *pitch*YLRDIM]= 0.02777777778*(rho+3.0f*( u+v)+4.5f*( u+v)*( u+v)-1.5f*usqr);
	f[j+6 *pitch*YLRDIM]= 0.02777777778*(rho+3.0f*(-u+v)+4.5f*(-u+v)*(-u+v)-1.5f*usqr);
	f[j+7 *pitch*YLRDIM]= 0.02777777778*(rho+3.0f*(-u-v)+4.5f*(-u-v)*(-u-v)-1.5f*usqr);
	f[j+8 *pitch*YLRDIM]= 0.02777777778*(rho+3.0f*( u-v)+4.5f*( u-v)*( u-v)-1.5f*usqr);
	}
}

int main(int argc, char *argv[])
{

	//int *image_d, *image_h;

	ofstream output;
	ofstream output2;
	string FileName = CASENAME;
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

	CharLength = OBSTR*2.f;

	omega = 1.0f/(3.0f*(UMAX*CharLength/RE)+0.5f);
	omega2 = 2.0f/(1.0f+2.0f*(2.0f/omega-1.0f));
	if(LRFACTOR == 0.25f){
	omega2 = 2.0f/(1.0f+2.0f*(2.0f/omega2-1.0f));
	}
	else if(LRFACTOR == 0.125f){
	omega2 = 2.0f/(1.0f+2.0f*(2.0f/omega2-1.0f));
	omega2 = 2.0f/(1.0f+2.0f*(2.0f/omega2-1.0f));
	}
	else if(LRFACTOR == 0.0625){
	omega2 = 2.0f/(1.0f+2.0f*(2.0f/omega2-1.0f));
	omega2 = 2.0f/(1.0f+2.0f*(2.0f/omega2-1.0f));
	omega2 = 2.0f/(1.0f+2.0f*(2.0f/omega2-1.0f));
	}
	float SF_cf = omega*(1.0f-omega2)/((1.0f-omega)*omega2/LRFACTOR);
	float SF_fc = 1.f/SF_cf;

//	float SF_cf3 = omega*(1.0f-omega3)/((1.0f-omega)*omega3/LRFACTOR);
//	float SF_fc3 = 1.f/SF_cf3;

	cout<<"omega:  "<<omega<<endl;
	cout<<"omega2: "<<omega2<<endl;
	cout<<"blocksize: "<<BLOCKSIZEX<<"x"<<BLOCKSIZEY<<endl;
	cout<<"grid: "<<XDIM<<"x"<<YDIM<<endl;
	cout<<"LRblocksize: "<<BLOCKSIZELRX<<"x"<<BLOCKSIZELRY<<endl;
	cout<<"LRgrid: "<<XLRDIM<<"x"<<YLRDIM<<endl;
	cout<<"TMAX: "<<TMAX<<endl;
	cout<<"Method: "<<METHOD<<endl;
	cout<<"Model: "<<MODEL<<endl;

	nBlocks = ((XDIM+BLOCKSIZEX-1)/BLOCKSIZEX)*(YDIM/BLOCKSIZEY+YDIM%BLOCKSIZEY);
	nBlocks2 = (XLRDIM/BLOCKSIZELRX+XLRDIM%BLOCKSIZELRX)*(YLRDIM/BLOCKSIZELRY+YLRDIM%BLOCKSIZELRY);
	int B = BLOCKSIZEX*BLOCKSIZELRY;
	int B2 = BLOCKSIZELRX*BLOCKSIZELRY;
	n = nBlocks*B;
	n2 = nBlocks2*B2;
	cout<<"nBlocks:"<<nBlocks<<endl;

    dim3 threads(BLOCKSIZEX, BLOCKSIZEY);
    //dim3 grid(XDIM/BLOCKSIZEX,YDIM/BLOCKSIZEY);
    dim3 grid(((XDIM+BLOCKSIZEX-1)/BLOCKSIZEX),YDIM/BLOCKSIZEY+YDIM%BLOCKSIZEY);

    dim3 threads2(BLOCKSIZELRX, BLOCKSIZELRY);
    //dim3 grid2(XLRDIM/BLOCKSIZELRX,YLRDIM/BLOCKSIZELRY);
    dim3 grid2(XLRDIM/BLOCKSIZELRX+XLRDIM%BLOCKSIZELRX,YLRDIM/BLOCKSIZELRY+YLRDIM%BLOCKSIZELRY);

	memsize = n*sizeof(float);
	//memsize_int = n*sizeof(int);
	memsize2 = n2*sizeof(float);

	//cudaExtent extent = make_cudaExtent(XDIM*sizeof(float),YDIM,ZDIM);

	//image_h = (int *)malloc(memsize_int);

	float *fA_h,*fA_d,*fB_d,*fC_h,*fC_d,*fD_d;
	float *FX_h,*FY_h,*FX_d,*FY_d;
	fA_h = (float *)malloc(memsize*9);
	fC_h = (float *)malloc(memsize2*9);
	FX_h = (float *)malloc(TMAX*sizeof(float));
	FY_h = (float *)malloc(TMAX*sizeof(float));
	cudaMallocPitch((void **) &fA_d, &pitch, XDIM*sizeof(float), YDIM*9);
	cudaMallocPitch((void **) &fB_d, &pitch, XDIM*sizeof(float), YDIM*9);
//	cudaMalloc((void **) &fA_d, XDIM*sizeof(float)*YDIM*9);
//	cudaMalloc((void **) &fB_d, XDIM*sizeof(float)*YDIM*9);
//	pitch = 16384;

	if(REFINEMENT == "YES"){
	cudaMallocPitch((void **) &fC_d, &pitch2, XLRDIM*sizeof(float), YLRDIM*9);
	cudaMallocPitch((void **) &fD_d, &pitch2, XLRDIM*sizeof(float), YLRDIM*9);
	}

	cudaMalloc((void **) &FX_d, TMAX*sizeof(float));
	cudaMalloc((void **) &FY_d, TMAX*sizeof(float));

	//cudaMalloc((void **) &image_d, memsize_int);

	cout<<pitch<<", "<<pitch2<<endl;
	
	size_t pitch_elements = pitch/sizeof(float);
	size_t pitch_elements2 = pitch2/sizeof(float);

	cudaChannelFormatDesc desc = cudaCreateChannelDesc<float>();
	for (i = 0; i < n*9; i++)
		fA_h[i] = i;
	for (i = 0; i < n2*9; i++)
		fC_h[i] = 0;
	for (i = 0; i < TMAX; i++){
		FX_h[i] = 0.0f;
		FY_h[i] = 0.0f;
	}
	cudaMemcpy(FX_d, FX_h, TMAX*sizeof(float), cudaMemcpyHostToDevice);
	cudaMemcpy(FY_d, FY_h, TMAX*sizeof(float), cudaMemcpyHostToDevice);

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

	texRef_f0B.filterMode = cudaFilterModeLinear;
	texRef_f1B.filterMode = cudaFilterModeLinear;
	texRef_f2B.filterMode = cudaFilterModeLinear;
	texRef_f3B.filterMode = cudaFilterModeLinear;
	texRef_f4B.filterMode = cudaFilterModeLinear;
	texRef_f5B.filterMode = cudaFilterModeLinear;
	texRef_f6B.filterMode = cudaFilterModeLinear;
	texRef_f7B.filterMode = cudaFilterModeLinear;
	texRef_f8B.filterMode = cudaFilterModeLinear;
	texRef_f0A.normalized = false;
	texRef_f1A.normalized = false;
	texRef_f2A.normalized = false;
	texRef_f3A.normalized = false;
	texRef_f4A.normalized = false;
	texRef_f5A.normalized = false;
	texRef_f6A.normalized = false;
	texRef_f7A.normalized = false;
	texRef_f8A.normalized = false;
	texRef_f0A.filterMode = cudaFilterModeLinear;
	texRef_f1A.filterMode = cudaFilterModeLinear;
	texRef_f2A.filterMode = cudaFilterModeLinear;
	texRef_f3A.filterMode = cudaFilterModeLinear;
	texRef_f4A.filterMode = cudaFilterModeLinear;
	texRef_f5A.filterMode = cudaFilterModeLinear;
	texRef_f6A.filterMode = cudaFilterModeLinear;
	texRef_f7A.filterMode = cudaFilterModeLinear;
	texRef_f8A.filterMode = cudaFilterModeLinear;
	
	texRef_f0C.normalized = false;
	texRef_f1C.normalized = false;
	texRef_f2C.normalized = false;
	texRef_f3C.normalized = false;
	texRef_f4C.normalized = false;
	texRef_f5C.normalized = false;
	texRef_f6C.normalized = false;
	texRef_f7C.normalized = false;
	texRef_f8C.normalized = false;

	texRef_f0C.filterMode = cudaFilterModeLinear;
	texRef_f1C.filterMode = cudaFilterModeLinear;
	texRef_f2C.filterMode = cudaFilterModeLinear;
	texRef_f3C.filterMode = cudaFilterModeLinear;
	texRef_f4C.filterMode = cudaFilterModeLinear;
	texRef_f5C.filterMode = cudaFilterModeLinear;
	texRef_f6C.filterMode = cudaFilterModeLinear;
	texRef_f7C.filterMode = cudaFilterModeLinear;
	texRef_f8C.filterMode = cudaFilterModeLinear;

	texRef_f0D.normalized = false;
	texRef_f1D.normalized = false;
	texRef_f2D.normalized = false;
	texRef_f3D.normalized = false;
	texRef_f4D.normalized = false;
	texRef_f5D.normalized = false;
	texRef_f6D.normalized = false;
	texRef_f7D.normalized = false;
	texRef_f8D.normalized = false;

	texRef_f0D.filterMode = cudaFilterModeLinear;
	texRef_f1D.filterMode = cudaFilterModeLinear;
	texRef_f2D.filterMode = cudaFilterModeLinear;
	texRef_f3D.filterMode = cudaFilterModeLinear;
	texRef_f4D.filterMode = cudaFilterModeLinear;
	texRef_f5D.filterMode = cudaFilterModeLinear;
	texRef_f6D.filterMode = cudaFilterModeLinear;
	texRef_f7D.filterMode = cudaFilterModeLinear;
	texRef_f8D.filterMode = cudaFilterModeLinear;

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

	texRef_f0B.addressMode[i]  = cudaAddressModeClamp;
	texRef_f1B.addressMode[i]  = cudaAddressModeClamp;
	texRef_f2B.addressMode[i]  = cudaAddressModeClamp;
	texRef_f3B.addressMode[i]  = cudaAddressModeClamp;
	texRef_f4B.addressMode[i]  = cudaAddressModeClamp;
	texRef_f5B.addressMode[i]  = cudaAddressModeClamp;
	texRef_f6B.addressMode[i]  = cudaAddressModeClamp;
	texRef_f7B.addressMode[i]  = cudaAddressModeClamp;
	texRef_f8B.addressMode[i]  = cudaAddressModeClamp;
	}
	}
	
	cudaMemcpy2D(fA_d,pitch ,fA_h,XDIM*sizeof(float),XDIM*sizeof(float),YDIM*9,cudaMemcpyHostToDevice);
	cudaMemcpy2D(fB_d,pitch ,fA_h,XDIM*sizeof(float),XDIM*sizeof(float),YDIM*9,cudaMemcpyHostToDevice);
	if(REFINEMENT == "YES"){
	cudaMemcpy2D(fC_d,pitch2,fC_h,XLRDIM*sizeof(float),XLRDIM*sizeof(float),YLRDIM*9,cudaMemcpyHostToDevice);
	cudaMemcpy2D(fD_d,pitch2,fC_h,XLRDIM*sizeof(float),XLRDIM*sizeof(float),YLRDIM*9,cudaMemcpyHostToDevice);
	}
	for (i = 0; i < n*9; i++)
		fA_h[i] = 0;
	for (i = 0; i < n2*9; i++)
		fC_h[i] = 0;


	if(true)//bind texture
	{
	cudaBindTexture2D(0,&texRef_f0A, fA_d                       ,&desc,XDIM,YDIM,pitch);
	cudaBindTexture2D(0,&texRef_f1A, fA_d+pitch_elements*YDIM   ,&desc,XDIM,YDIM,pitch);
	cudaBindTexture2D(0,&texRef_f2A, fA_d+pitch_elements*YDIM*2 ,&desc,XDIM,YDIM,pitch);
	cudaBindTexture2D(0,&texRef_f3A, fA_d+pitch_elements*YDIM*3 ,&desc,XDIM,YDIM,pitch);
	cudaBindTexture2D(0,&texRef_f4A, fA_d+pitch_elements*YDIM*4 ,&desc,XDIM,YDIM,pitch);
	cudaBindTexture2D(0,&texRef_f5A, fA_d+pitch_elements*YDIM*5 ,&desc,XDIM,YDIM,pitch);
	cudaBindTexture2D(0,&texRef_f6A, fA_d+pitch_elements*YDIM*6 ,&desc,XDIM,YDIM,pitch);
	cudaBindTexture2D(0,&texRef_f7A, fA_d+pitch_elements*YDIM*7 ,&desc,XDIM,YDIM,pitch);
	cudaBindTexture2D(0,&texRef_f8A, fA_d+pitch_elements*YDIM*8 ,&desc,XDIM,YDIM,pitch);

	cudaBindTexture2D(0,&texRef_f0B, fB_d                       ,&desc,XDIM,YDIM,pitch);
	cudaBindTexture2D(0,&texRef_f1B, fB_d+pitch_elements*YDIM   ,&desc,XDIM,YDIM,pitch);
	cudaBindTexture2D(0,&texRef_f2B, fB_d+pitch_elements*YDIM*2 ,&desc,XDIM,YDIM,pitch);
	cudaBindTexture2D(0,&texRef_f3B, fB_d+pitch_elements*YDIM*3 ,&desc,XDIM,YDIM,pitch);
	cudaBindTexture2D(0,&texRef_f4B, fB_d+pitch_elements*YDIM*4 ,&desc,XDIM,YDIM,pitch);
	cudaBindTexture2D(0,&texRef_f5B, fB_d+pitch_elements*YDIM*5 ,&desc,XDIM,YDIM,pitch);
	cudaBindTexture2D(0,&texRef_f6B, fB_d+pitch_elements*YDIM*6 ,&desc,XDIM,YDIM,pitch);
	cudaBindTexture2D(0,&texRef_f7B, fB_d+pitch_elements*YDIM*7 ,&desc,XDIM,YDIM,pitch);
	cudaBindTexture2D(0,&texRef_f8B, fB_d+pitch_elements*YDIM*8 ,&desc,XDIM,YDIM,pitch);

	cudaBindTexture2D(0,&texRef_f0C, fC_d                          ,&desc,XLRDIM,YLRDIM,pitch2);
	cudaBindTexture2D(0,&texRef_f1C, fC_d+pitch_elements2*YLRDIM   ,&desc,XLRDIM,YLRDIM,pitch2);
	cudaBindTexture2D(0,&texRef_f2C, fC_d+pitch_elements2*YLRDIM*2 ,&desc,XLRDIM,YLRDIM,pitch2);
	cudaBindTexture2D(0,&texRef_f3C, fC_d+pitch_elements2*YLRDIM*3 ,&desc,XLRDIM,YLRDIM,pitch2);
	cudaBindTexture2D(0,&texRef_f4C, fC_d+pitch_elements2*YLRDIM*4 ,&desc,XLRDIM,YLRDIM,pitch2);
	cudaBindTexture2D(0,&texRef_f5C, fC_d+pitch_elements2*YLRDIM*5 ,&desc,XLRDIM,YLRDIM,pitch2);
	cudaBindTexture2D(0,&texRef_f6C, fC_d+pitch_elements2*YLRDIM*6 ,&desc,XLRDIM,YLRDIM,pitch2);
	cudaBindTexture2D(0,&texRef_f7C, fC_d+pitch_elements2*YLRDIM*7 ,&desc,XLRDIM,YLRDIM,pitch2);
	cudaBindTexture2D(0,&texRef_f8C, fC_d+pitch_elements2*YLRDIM*8 ,&desc,XLRDIM,YLRDIM,pitch2);

	cudaBindTexture2D(0,&texRef_f0D, fD_d                          ,&desc,XLRDIM,YLRDIM,pitch2);
	cudaBindTexture2D(0,&texRef_f1D, fD_d+pitch_elements2*YLRDIM   ,&desc,XLRDIM,YLRDIM,pitch2);
	cudaBindTexture2D(0,&texRef_f2D, fD_d+pitch_elements2*YLRDIM*2 ,&desc,XLRDIM,YLRDIM,pitch2);
	cudaBindTexture2D(0,&texRef_f3D, fD_d+pitch_elements2*YLRDIM*3 ,&desc,XLRDIM,YLRDIM,pitch2);
	cudaBindTexture2D(0,&texRef_f4D, fD_d+pitch_elements2*YLRDIM*4 ,&desc,XLRDIM,YLRDIM,pitch2);
	cudaBindTexture2D(0,&texRef_f5D, fD_d+pitch_elements2*YLRDIM*5 ,&desc,XLRDIM,YLRDIM,pitch2);
	cudaBindTexture2D(0,&texRef_f6D, fD_d+pitch_elements2*YLRDIM*6 ,&desc,XLRDIM,YLRDIM,pitch2);
	cudaBindTexture2D(0,&texRef_f7D, fD_d+pitch_elements2*YLRDIM*7 ,&desc,XLRDIM,YLRDIM,pitch2);
	cudaBindTexture2D(0,&texRef_f8D, fD_d+pitch_elements2*YLRDIM*8 ,&desc,XLRDIM,YLRDIM,pitch2);
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
		if(REFINEMENT == "YES"){
			if(METHOD == "SINGLE")
			mrt_d_single<<<grid, threads>>>(fA_d,fB_d,omega,pitch_elements);
			else if(METHOD == "HYB")
			mrt_d_hybAB<<<grid, threads>>>(fA_d,fB_d,omega,pitch_elements);
			else if(METHOD == "TEXT")
			mrt_d_textAB<<<grid, threads>>>(fA_d,fB_d,omega,pitch_elements);
			

			if(METHOD == "SINGLE"){
				LR_d_ABCD<<<grid2, threads2>>>(fC_d,fD_d,omega2,pitch_elements2);
				LR_d_ABDC<<<grid2, threads2>>>(fD_d,fC_d,omega2,pitch_elements2,SF_cf);
			}
			else if(METHOD == "HYB"){
				if(LRFACTOR == 0.5f){
					if(t >= STARTF)
					LR_d_hybABCD_force<<<grid2, threads2>>>(fC_d,fD_d,omega2,pitch_elements2,FX_d,FY_d,t);
					else
					LR_d_hybABCD<<<grid2, threads2>>>(fC_d,fD_d,omega2,pitch_elements2);
					LR_d_hybABDC_Interp<<<grid2, threads2>>>(fD_d,fC_d,omega2,pitch_elements2,SF_cf);
				}
				else if(LRFACTOR == 0.25f){
					if(t >= STARTF)
					LR_d_hybABCD_force<<<grid2, threads2>>>(fC_d,fD_d,omega2,pitch_elements2,FX_d,FY_d,t);
					else
					LR_d_hybABCD<<<grid2, threads2>>>(fC_d,fD_d,omega2,pitch_elements2);
					LR_d_hybABDC2<<<grid2, threads2>>>(fD_d,fC_d,omega2,pitch_elements2,SF_cf,2);

					LR_d_hybABCD2<<<grid2, threads2>>>(fC_d,fD_d,omega2,pitch_elements2,3);
					LR_d_hybABDC_Interp<<<grid2, threads2>>>(fD_d,fC_d,omega2,pitch_elements2,SF_cf);
				}
				else if(LRFACTOR == 0.125f){
					if(t >= STARTF)
					LR_d_hybABCD_force<<<grid2, threads2>>>(fC_d,fD_d,omega2,pitch_elements2,FX_d,FY_d,t);
					else
					LR_d_hybABCD<<<grid2, threads2>>>(fC_d,fD_d,omega2,pitch_elements2);
					LR_d_hybABDC2<<<grid2, threads2>>>(fD_d,fC_d,omega2,pitch_elements2,SF_cf,2);

					for(int k = 0; k<2;k++){
					LR_d_hybABCD2<<<grid2, threads2>>>(fC_d,fD_d,omega2,pitch_elements2,3+k);
					LR_d_hybABDC2<<<grid2, threads2>>>(fD_d,fC_d,omega2,pitch_elements2,SF_cf,4+k);
					}

					LR_d_hybABCD2<<<grid2, threads2>>>(fC_d,fD_d,omega2,pitch_elements2,7);
					LR_d_hybABDC_Interp<<<grid2, threads2>>>(fD_d,fC_d,omega2,pitch_elements2,SF_cf);
				}
				else if(LRFACTOR == 0.0625f){
					if(t >= STARTF)
					LR_d_hybABCD_force<<<grid2, threads2>>>(fC_d,fD_d,omega2,pitch_elements2,FX_d,FY_d,t);
					else
					LR_d_hybABCD<<<grid2, threads2>>>(fC_d,fD_d,omega2,pitch_elements2);
					LR_d_hybABDC2<<<grid2, threads2>>>(fD_d,fC_d,omega2,pitch_elements2,SF_cf,2);

					for(int k = 0; k<6;k++){
					LR_d_hybABCD2<<<grid2, threads2>>>(fC_d,fD_d,omega2,pitch_elements2,3+k);
					LR_d_hybABDC2<<<grid2, threads2>>>(fD_d,fC_d,omega2,pitch_elements2,SF_cf,4+k);
					}

					LR_d_hybABCD2<<<grid2, threads2>>>(fC_d,fD_d,omega2,pitch_elements2,15);
					LR_d_hybABDC_Interp<<<grid2, threads2>>>(fD_d,fC_d,omega2,pitch_elements2,SF_cf);
				}
			}
			
			ExtractFromC_d<<<grid, threads>>>(fB_d,pitch_elements,SF_fc);

	
			if(METHOD == "SINGLE")
			mrt_d_single<<<grid, threads>>>(fB_d,fA_d,omega,pitch_elements);
			else if(METHOD == "HYB")
			mrt_d_hybBA<<<grid, threads>>>(fB_d,fA_d,omega,pitch_elements);
			else if(METHOD == "TEXT")
			mrt_d_textBA<<<grid, threads>>>(fB_d,fA_d,omega,pitch_elements);
	

			if(METHOD == "SINGLE"){
			LR_d_BACD<<<grid2, threads2>>>(fC_d,fD_d,omega2,pitch_elements2);
			LR_d_BADC<<<grid2, threads2>>>(fD_d,fC_d,omega2,pitch_elements2,SF_cf);
			}
			else if(METHOD == "HYB"){
				if(LRFACTOR == 0.5f){
				if(t >= STARTF)
				LR_d_hybBACD_force<<<grid2, threads2>>>(fC_d,fD_d,omega2,pitch_elements2,FX_d,FY_d,t+1);
				else
				LR_d_hybBACD<<<grid2, threads2>>>(fC_d,fD_d,omega2,pitch_elements2);
				LR_d_hybBADC_Interp<<<grid2, threads2>>>(fD_d,fC_d,omega2,pitch_elements2,SF_cf);
				}
				else if(LRFACTOR == 0.25f){
				if(t >= STARTF)
				LR_d_hybBACD_force<<<grid2, threads2>>>(fC_d,fD_d,omega2,pitch_elements2,FX_d,FY_d,t+1);
				else
				LR_d_hybBACD<<<grid2, threads2>>>(fC_d,fD_d,omega2,pitch_elements2);
				LR_d_hybBADC2<<<grid2, threads2>>>(fD_d,fC_d,omega2,pitch_elements2,SF_cf,2);

				LR_d_hybBACD2<<<grid2, threads2>>>(fC_d,fD_d,omega2,pitch_elements2,3);
				LR_d_hybBADC_Interp<<<grid2, threads2>>>(fD_d,fC_d,omega2,pitch_elements2,SF_cf);
				}
				else if(LRFACTOR == 0.125f){
					if(t >= STARTF)
					LR_d_hybBACD_force<<<grid2, threads2>>>(fC_d,fD_d,omega2,pitch_elements2,FX_d,FY_d,t+1);
					else
					LR_d_hybBACD<<<grid2, threads2>>>(fC_d,fD_d,omega2,pitch_elements2);
					LR_d_hybBADC2<<<grid2, threads2>>>(fD_d,fC_d,omega2,pitch_elements2,SF_cf,2);

					for(int k = 0; k<2;k++){
					LR_d_hybBACD2<<<grid2, threads2>>>(fC_d,fD_d,omega2,pitch_elements2,3+k);
					LR_d_hybBADC2<<<grid2, threads2>>>(fD_d,fC_d,omega2,pitch_elements2,SF_cf,4+k);
					}

					LR_d_hybBACD2<<<grid2, threads2>>>(fC_d,fD_d,omega2,pitch_elements2,7);
					LR_d_hybBADC_Interp<<<grid2, threads2>>>(fD_d,fC_d,omega2,pitch_elements2,SF_cf);
				}
				else if(LRFACTOR == 0.0625f){
					if(t >= STARTF)
					LR_d_hybBACD_force<<<grid2, threads2>>>(fC_d,fD_d,omega2,pitch_elements2,FX_d,FY_d,t+1);
					else
					LR_d_hybBACD<<<grid2, threads2>>>(fC_d,fD_d,omega2,pitch_elements2);
					LR_d_hybBADC2<<<grid2, threads2>>>(fD_d,fC_d,omega2,pitch_elements2,SF_cf,2);

					for(int k = 0; k<6;k++){
					LR_d_hybBACD2<<<grid2, threads2>>>(fC_d,fD_d,omega2,pitch_elements2,3+k);
					LR_d_hybBADC2<<<grid2, threads2>>>(fD_d,fC_d,omega2,pitch_elements2,SF_cf,4+k);
					}

					LR_d_hybBACD2<<<grid2, threads2>>>(fC_d,fD_d,omega2,pitch_elements2,15);
					LR_d_hybBADC_Interp<<<grid2, threads2>>>(fD_d,fC_d,omega2,pitch_elements2,SF_cf);
				}
			}
			
			ExtractFromC_d<<<grid, threads>>>(fA_d,pitch_elements,SF_fc);
		}
		else{
			if(METHOD == "SINGLE"){
			mrt_d_single<<<grid, threads>>>(fA_d,fB_d,omega,pitch_elements);
			mrt_d_single<<<grid, threads>>>(fB_d,fA_d,omega,pitch_elements);
			}
	
			else if(METHOD == "SINGLEF"){
			mrt_d_single_force<<<grid, threads>>>(fA_d,fB_d,omega,pitch_elements,FX_d,FY_d,t);
			mrt_d_single_force<<<grid, threads>>>(fB_d,fA_d,omega,pitch_elements,FX_d,FY_d,t+1);
			}
	
			else if(METHOD == "HYB"){
			if(t >= STARTF){
			mrt_d_hybAB_force<<<grid, threads>>>(fA_d,fB_d,omega,pitch_elements,FX_d,FY_d,t);
			mrt_d_hybBA_force<<<grid, threads>>>(fB_d,fA_d,omega,pitch_elements,FX_d,FY_d,t+1);
			}
			else{
			mrt_d_hybAB<<<grid, threads>>>(fA_d,fB_d,omega,pitch_elements);
			mrt_d_hybBA<<<grid, threads>>>(fB_d,fA_d,omega,pitch_elements);
			}
			}
	
			else if(METHOD == "TEXT"){
			mrt_d_textAB<<<grid, threads>>>(fA_d,fB_d,omega,pitch_elements);
			mrt_d_textBA<<<grid, threads>>>(fB_d,fA_d,omega,pitch_elements);
			}
		}

//		else if(METHOD == "SHARED"){
//		mrt_d_shared<<<grid, threads>>>(fA_d,fB_d,omega,pitch_elements);
//		mrt_d_shared<<<grid, threads>>>(fB_d,fA_d,omega,pitch_elements);
//		}

//		simple_copy<<<grid, threads>>>(fA_d,fB_d,image_d,omega,UMAX,XDIM,YDIM,ZDIM,pitch_elements);
//		simple_copy<<<grid, threads>>>(fB_d,fA_d,image_d,omega,UMAX,XDIM,YDIM,ZDIM,pitch_elements);

		if(t%1000 == 0 && t>0) cout<<"finished "<<t<<" timesteps\n";
	}
	cudaDeviceSynchronize();

	gettimeofday (&tdr1,NULL);
	timeval_subtract (&restime, &tdr1, &tdr0);
	int Nodes;
	if(REFINEMENT == "YES"){
		Nodes = (XDIM*YDIM+XLRDIM*YLRDIM/LRFACTOR);
	}
	else{
		Nodes = XDIM*YDIM;
	}
	cout<<"Time taken for main kernel: "<<restime<<" ("
			<<double(Nodes*double(TMAX/1000000.f))/restime<<"MLUPS)"<<endl;
//			<<double((XDIM*YDIM*ZDIM)*double(TMAX/1000000.f))/restime<<"MLUPS)"<<endl;
	cout<<XDIM<<","<<YDIM<<","<<TMAX<<","<<restime<<endl;

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

	cudaUnbindTexture(texRef_f0B);
	cudaUnbindTexture(texRef_f1B);
	cudaUnbindTexture(texRef_f2B);
	cudaUnbindTexture(texRef_f3B);
	cudaUnbindTexture(texRef_f4B);
	cudaUnbindTexture(texRef_f5B);
	cudaUnbindTexture(texRef_f6B);
	cudaUnbindTexture(texRef_f7B);
	cudaUnbindTexture(texRef_f8B);

	cudaUnbindTexture(texRef_f0C);
	cudaUnbindTexture(texRef_f1C);
	cudaUnbindTexture(texRef_f2C);
	cudaUnbindTexture(texRef_f3C);
	cudaUnbindTexture(texRef_f4C);
	cudaUnbindTexture(texRef_f5C);
	cudaUnbindTexture(texRef_f6C);
	cudaUnbindTexture(texRef_f7C);
	cudaUnbindTexture(texRef_f8C);

	cudaUnbindTexture(texRef_f0D);
	cudaUnbindTexture(texRef_f1D);
	cudaUnbindTexture(texRef_f2D);
	cudaUnbindTexture(texRef_f3D);
	cudaUnbindTexture(texRef_f4D);
	cudaUnbindTexture(texRef_f5D);
	cudaUnbindTexture(texRef_f6D);
	cudaUnbindTexture(texRef_f7D);
	cudaUnbindTexture(texRef_f8D);
	}

	cudaMemcpy2D(fA_h,XDIM*sizeof(float),fA_d,pitch,XDIM*sizeof(float),YDIM*9,cudaMemcpyDeviceToHost);
	if(REFINEMENT == "YES"){
	cudaMemcpy2D(fC_h,XLRDIM*sizeof(float),fC_d,pitch2,XLRDIM*sizeof(float),YLRDIM*9,cudaMemcpyDeviceToHost);
	}	
	cudaMemcpy(FX_h, FX_d, TMAX*sizeof(float), cudaMemcpyDeviceToHost);
	cudaMemcpy(FY_h, FY_d, TMAX*sizeof(float), cudaMemcpyDeviceToHost);

	output<<"VARIABLES = \"X\",\"Y\",\"u\",\"v\",\"rho\"\n";
	output<<"ZONE F=POINT, I="<<XDIM<<", J="<<YDIM<<"\n";
	
	int row = 0;
	int col = 0;
	i = 0;
	float rho, u, v;
	int j;

	for(row = 0; row<YDIM; row++){
		for(col = 0; col<XDIM; col++){
			i = row*XDIM+col;
			rho = fA_h[i];
			for(j = 1; j<9; j++)
				rho+=fA_h[i+XDIM*YDIM*j];
			u = fA_h[i+XDIM*YDIM*1]-fA_h[i+XDIM*YDIM*3]+fA_h[i+XDIM*YDIM*5]-fA_h[i+XDIM*YDIM*6]-
				fA_h[i+XDIM*YDIM*7]+fA_h[i+XDIM*YDIM*8];
			v = fA_h[i+XDIM*YDIM*2]-fA_h[i+XDIM*YDIM*4]+fA_h[i+XDIM*YDIM*5]+fA_h[i+XDIM*YDIM*6]-fA_h[i+XDIM*YDIM*7]-fA_h[i+XDIM*YDIM*8];
			output<<col<<", "<<row<<", "<<u<<","<<v<<","<<rho<<endl;
		}
	}

	if(REFINEMENT == "YES"){
	output<<endl<<"VARIABLES = \"X\",\"Y\",\"u\",\"v\",\"rho\"\n";
	//output<<"ZONE F=POINT, I="<<XLRDIM-LRLEVEL*2<<", J="<<YLRDIM-LRLEVEL*2<<"\n";
	output<<"ZONE F=POINT, I="<<XLRDIM<<", J="<<YLRDIM<<"\n";
	
//	for(row = LRLEVEL; row<YLRDIM-LRLEVEL; row++){
//		for(col = LRLEVEL; col<XLRDIM-LRLEVEL; col++){
	for(row = 0; row<YLRDIM-0; row++){
		for(col = 0; col<XLRDIM-0; col++){
			i = row*XLRDIM+col;
			rho = fC_h[i];
			for(j = 1; j<9; j++)
				rho+=fC_h[i+XLRDIM*YLRDIM*j];
			u = fC_h[i+XLRDIM*YLRDIM*1]-fC_h[i+XLRDIM*YLRDIM*3]+fC_h[i+XLRDIM*YLRDIM*5]-fC_h[i+XLRDIM*YLRDIM*6]-
				fC_h[i+XLRDIM*YLRDIM*7]+fC_h[i+XLRDIM*YLRDIM*8];
			v = fC_h[i+XLRDIM*YLRDIM*2]-fC_h[i+XLRDIM*YLRDIM*4]+fC_h[i+XLRDIM*YLRDIM*5]+fC_h[i+XLRDIM*YLRDIM*6]-fC_h[i+XLRDIM*YLRDIM*7]-fC_h[i+XLRDIM*YLRDIM*8];
			output<<LRX0+LRFACTOR*col<<", "<<LRY0+LRFACTOR*row<<", "<<u<<","<<v<<","<<rho<<endl;
		}
	}
	}

	output.close();

	//for(int t = STARTF-1; t<TMAX; t++){
	for(int t = 0; t<TMAX; t++){
		output2<<t<<", "<<FX_h[t]/(0.5f*UMAX*UMAX*OBSTR*2.0f)<<", "<<FY_h[t]/(0.5f*UMAX*UMAX*OBSTR*2.0f)<<endl;
	}
	output2.close();


	//cudaFree(image_d);


	cudaFree(fA_d);
	cudaFree(fB_d);
	cudaFree(fC_d);
	cudaFree(fD_d);
	cudaFree(FX_d);
	cudaFree(FY_d);
	return(0);

}
