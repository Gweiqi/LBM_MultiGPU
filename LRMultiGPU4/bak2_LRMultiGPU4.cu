#include <cuda.h>
#include <iostream>
#include <ostream>
#include <fstream>
#include <sys/time.h>
#include <time.h>

using namespace std;

#define CASENAME "test_new"

#define BLOCKSIZEX 64
#define BLOCKSIZEY 1
#define BLOCKSIZEZ 1
#define BLOCKSIZELRX 64
#define BLOCKSIZELRY 1
#define BLOCKSIZELRZ 1
#define XDIM 64
#define YDIM 64
#define ZDIM 8
#define TMAX  1
#define STARTF 0

#define OBSTR1 4.f
#define OBSTX1 23.5f
#define OBSTY1 23.5f
#define OBSTZ1 32.5f

#define OBSTR2 32.f
#define OBSTX2 319.5f
#define OBSTY2 511.5f
#define OBSTZ2 31.5f

#define LRFACTOR 0.5f
#define LRLEVEL 2
#define LRX0 11.75f    //minimum x coord of LR
#define XLRDIM 64    //number of nodes in x
#define LRY0 11.75f
#define YLRDIM 92
#define LRZ0 -0.25f
#define ZLRDIM 16

#define RE 20.f//2000.f//100.f;
#define UMAX 0.08f
#define SmagLES 0 //YES,NO
#define MODEL "MRT" //BGK,MRT,STREAM
#define REFINEMENT 1 //1,0
#define CS 0.1f

#define VELAV 0
#define START_VELAV   400000
#define START_VELFLUC 700000

inline __device__ int ImageFcn(float x, float y, float z){
    int value = 0;
//    if(((x-OBSTX1)*(x-OBSTX1)+(y-OBSTY1)*(y-OBSTY1))<OBSTR1*OBSTR1)
//        value = 10;
//    else if(((x-OBSTX2)*(x-OBSTX2)+(y-OBSTY2)*(y-OBSTY2))<OBSTR2*OBSTR2)
//        value = 10;
    
    if(abs(x-OBSTX1) < OBSTR1 && abs(y-OBSTY1) < OBSTR1)
        value = 10;

    return value;
}

inline __device__ int ImageFcn(int x, int y, int z){
    int value = 0;
//Cylinder
//    if(((x-OBSTX1)*(x-OBSTX1)+(y-OBSTY1)*(y-OBSTY1))<OBSTR1*OBSTR1)
//        value = 10;
//    else if(((x-OBSTX2)*(x-OBSTX2)+(y-OBSTY2)*(y-OBSTY2))<OBSTR2*OBSTR2)
//        value = 10;
    if(abs(x-OBSTX1) < OBSTR1 && abs(y-OBSTY1) < OBSTR1)
        value = 10;
//Lid Driven Cavity
//    if(y == 0 || y == YDIM-1 || z == 0 || z == ZDIM-1)
//        value = 1;
//    else if(x == XDIM-2 || y == 1 || y == YDIM-2 || z == 1 || z == ZDIM-2)
//        return 1;
//    else if(x == 0)
//        return 1;
    
//    if(abs(x-OBSTX1) < OBSTR1 && abs(y-OBSTY1) < OBSTR1)
//        value = 10;
//    if(z == 1)
//        value = 1;
//    if(z == ZDIM-2)
//        value = 1;
    else if(y == 0)
        value = 200;//22;
    else if(y == YDIM-1)
        value = 100;
    else if(x == 0)
        value = 26;
    else if(x == XDIM-1)
        value = 25;
    return value;
}

inline __device__ float PoisProf (float x){
    float radius = (YDIM-1-1)*0.5f;
    float result = -1.0f*(((1.0f-(x-0.5f)/radius))*((1.0f-(x-0.5f)/radius))-1.0f);
    return (result);
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

inline __device__ int f_mem(int f_num, int x, int y, int z, size_t pitch, int zInner)
{
    int index = (x+y*pitch+z*YDIM*pitch)+f_num*pitch*YDIM*(zInner);
    index = dmax(index);
    index = dmin(index,19*pitch*YDIM*(zInner));
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
    return index;
}

inline __device__ int buff_memLR(int f_num, int x, int y, size_t pitch)
{
    int index = (x+y*pitch)+f_num*pitch*YLRDIM;
    index = dmax(index);
    index = dmin(index,19*pitch*YLRDIM);
    return index;
}

inline __device__ void mrt_meq(float* meq, float rho, float u, float v, float w)
{
    meq[ 0] = rho;
    meq[ 1] = -11.f*rho+19.f*(u*u+v*v+w*w);
    meq[ 2] = 7.53968254f*(u*u+v*v+w*w);;
    meq[ 3] = u;
    meq[ 4] = -0.666666667f*u;
    meq[ 5] = v;
    meq[ 6] = -0.666666667f*v;
    meq[ 7] = w;
    meq[ 8] = -0.666666667f*w;
    meq[ 9] = 2.f*u*u-(v*v+w*w);
    meq[11] = v*v-w*w;
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

inline __device__ void mrt_collide(float* f, float omega)
{
    float m[19];
    float u,v,w;    
    u = f[ 1]-f[ 3]+f[ 5]-f[ 6]-f[ 7]+f[ 8]+f[10]-f[12]+f[15]-f[17];
    v = f[ 2]-f[ 4]+f[ 5]+f[ 6]-f[ 7]-f[ 8]+f[11]-f[13]+f[16]-f[18];
    w = f[ 9]+f[10]+f[11]+f[12]+f[13]-f[14]-f[15]-f[16]-f[17]-f[18];
    float rho = f[ 0]+f[ 1]+f[ 2]+f[ 3]+f[ 4]+f[ 5]+f[ 6]+f[ 7]+f[ 8]+f[ 9]+
          f[10]+f[11]+f[12]+f[13]+f[14]+f[15]+f[16]+f[17]+f[18];

    m[ 1]  = 19.f*(-f[ 0]+ f[ 5]+f[ 6]+f[ 7]+f[ 8]+f[10]+f[11]+f[12]+f[13]+f[15]+f[16]+f[17]+f[18]   -(u*u+v*v+w*w));//+8.f*(f[ 5]+f[ 6]+f[ 7]+f[ 8]+f[10]+f[11]+f[12]+f[13]+f[15]+f[16]+f[17]+f[18]);
    m[ 2]  =  12.f*f[ 0]+ -4.f*f[ 1]+ -4.f*f[ 2]+ -4.f*f[ 3]+ -4.f*f[ 4]+      f[ 5]+      f[ 6]+      f[ 7]+      f[ 8]+ -4.f*f[ 9]+    f[10]+        f[11]+      f[12]+      f[13]+ -4.f*f[14]+      f[15]+      f[16]+      f[17]+      f[18] +7.53968254f*(u*u+v*v+w*w);
    m[ 4]  = 1.666666667f*(-3.f*f[1]+3.f*f[ 3]+u);
    m[ 6]  = 1.666666667f*(-3.f*f[2]+3.f*f[ 4]+v);
    m[ 8]  = 1.666666667f*(-3.f*f[9]+3.f*f[14]+w);
    m[ 9]  = 2.f*f[ 1]+  -  f[ 2]+  2.f*f[ 3]+  -  f[ 4]+ f[ 5]+ f[ 6]+ f[ 7]+ f[ 8]+-    f[ 9]+ f[10]+ -2.f*f[11]+ f[12]+-2.f*f[13]+-    f[14]+ f[15]+ -2.f*f[16]+ f[17]+-2.f*f[18]  -(2.f*u*u-(v*v+w*w));
    m[10] =-4.f*f[ 1]+ 2.f*f[ 2]+ -4.f*f[ 3]+ 2.f*f[ 4]+ f[ 5]+ f[ 6]+ f[ 7]+ f[ 8]+ 2.f*f[ 9]+ f[10]+ -2.f*f[11]+ f[12]+-2.f*f[13]+ 2.f*f[14]+ f[15]+ -2.f*f[16]+ f[17]+-2.f*f[18];
    m[11] =             f[ 2]         +     f[ 4]+ f[ 5]+ f[ 6]+ f[ 7]+ f[ 8]+-    f[ 9]+-f[10]          +-f[12]         +-    f[14]+-f[15]          +-f[17]         -(v*v-w*w);
    m[12] =        -2.f*f[ 2]          -2.f*f[ 4]+ f[ 5]+ f[ 6]+ f[ 7]+ f[ 8]+ 2.f*f[ 9]+-f[10]          +-f[12]         + 2.f*f[14]+-f[15]          +-f[17]         ;
    m[13] =                                  f[ 5]+-f[ 6]+ f[ 7]+-f[ 8]                                                                             -u*v;
    m[14] =                                                                    f[11]     +-    f[13]              + -    f[16]     +     f[18]  -v*w;
    m[15] =                                                          f[10]        + - f[12]                  +-f[15]          + f[17]           -u*w;  
    m[16] =                                  f[ 5]+-f[ 6]+-f[ 7]+ f[ 8]         -f[10]        +   f[12]                  +-f[15]          + f[17]         ;  
    m[17] =                                 -f[ 5]+-f[ 6]+ f[ 7]+ f[ 8]              +     f[11]     +-    f[13]              +      f[16]     +-    f[18];  
    m[18] =                                                          f[10]+-     f[11]+ f[12]+-    f[13]         +-f[15]+      f[16]+-f[17]+     f[18];

f[ 0] -=- 0.012531328f*(m[ 1])+ 0.047619048f*(m[ 2]);
f[ 1] -=-0.0045948204f*(m[ 1])+-0.015873016f*(m[ 2])+  -0.1f*(m[ 4])                 + 0.055555556f*((m[ 9])*omega-m[10]);
f[ 2] -=-0.0045948204f*(m[ 1])+-0.015873016f*(m[ 2])             +   -0.1f*(m[ 6])   +-0.027777778f*((m[ 9])*omega-m[10])+ 0.083333333f*((m[11])*omega-m[12]);
f[ 3] -=-0.0045948204f*(m[ 1])+-0.015873016f*(m[ 2])+   0.1f*(m[ 4])                 + 0.055555556f*((m[ 9])*omega-m[10]);                                                                                         
f[ 4] -=-0.0045948204f*(m[ 1])+-0.015873016f*(m[ 2])             +    0.1f*(m[ 6])   +-0.027777778f*((m[ 9])*omega-m[10])+ 0.083333333f*((m[11])*omega-m[12]);
f[ 5] -= 0.0033416876f*(m[ 1])+ 0.003968254f*(m[ 2])+ 0.025f*(m[ 4]+m[ 6])              +0.013888889f*(m[10])+0.041666667f*(m[12])+0.125f*( m[16]-m[17])+ omega*(0.027777778f*(m[ 9]) +0.083333333f*(m[11])+( 0.25f*(m[13])));
f[ 6] -= 0.0033416876f*(m[ 1])+ 0.003968254f*(m[ 2])+-0.025f*(m[ 4]-m[ 6])              +0.013888889f*(m[10])+0.041666667f*(m[12])+0.125f*(-m[16]-m[17])+ omega*(0.027777778f*(m[ 9]) +0.083333333f*(m[11])+(-0.25f*(m[13])));
f[ 7] -= 0.0033416876f*(m[ 1])+ 0.003968254f*(m[ 2])+-0.025f*(m[ 4]+m[ 6])              +0.013888889f*(m[10])+0.041666667f*(m[12])+0.125f*(-m[16]+m[17])+ omega*(0.027777778f*(m[ 9]) +0.083333333f*(m[11])+( 0.25f*(m[13])));
f[ 8] -= 0.0033416876f*(m[ 1])+ 0.003968254f*(m[ 2])+ 0.025f*(m[ 4]-m[ 6])              +0.013888889f*(m[10])+0.041666667f*(m[12])+0.125f*( m[16]+m[17])+ omega*(0.027777778f*(m[ 9]) +0.083333333f*(m[11])+(-0.25f*(m[13])));
f[ 9] -=-0.0045948204f*(m[ 1])+-0.015873016f*(m[ 2])                +   -0.1f*(m[ 8])+-0.027777778f*((m[ 9])*omega-m[10])+-0.083333333f*((m[11])*omega-m[12]);                                       
f[10] -= 0.0033416876f*(m[ 1])+ 0.003968254f*(m[ 2])+ 0.025f*(m[ 4]+m[ 8])              +0.013888889f*(m[10])-0.041666667f*(m[12])+0.125f*(-m[16]+m[18])+ omega*(0.027777778f*(m[ 9]) -0.083333333f*(m[11])+( 0.25f*(m[15])));
f[11] -= 0.0033416876f*(m[ 1])+ 0.003968254f*(m[ 2])             +  0.025f*(m[ 6]+m[ 8])+0.125f*( m[17]-m[18])-0.027777778f*(m[10])+omega*(-0.055555556f*(m[ 9]) +( 0.25f*(m[14])));
f[12] -= 0.0033416876f*(m[ 1])+ 0.003968254f*(m[ 2])+-0.025f*(m[ 4]-m[ 8])              +0.013888889f*(m[10])-0.041666667f*(m[12])+0.125f*( m[16]+m[18])+ omega*(0.027777778f*(m[ 9]) -0.083333333f*(m[11])+(-0.25f*(m[15])));
f[13] -= 0.0033416876f*(m[ 1])+ 0.003968254f*(m[ 2])             + -0.025f*(m[ 6]-m[ 8])+0.125f*(-m[17]-m[18])-0.027777778f*(m[10])+omega*(-0.055555556f*(m[ 9]) +(-0.25f*(m[14])));
f[14] -=-0.0045948204f*(m[ 1])+-0.015873016f*(m[ 2])                +    0.1f*(m[ 8])+-0.027777778f*((m[ 9])*omega-m[10])+-0.083333333f*((m[11])*omega-m[12]);                                      
f[15] -= 0.0033416876f*(m[ 1])+ 0.003968254f*(m[ 2])+ 0.025f*(m[ 4]-m[ 8])              +0.013888889f*(m[10])-0.041666667f*(m[12])+0.125f*(-m[16]-m[18])+ omega*(0.027777778f*(m[ 9]) -0.083333333f*(m[11])+(-0.25f*(m[15])));
f[16] -= 0.0033416876f*(m[ 1])+ 0.003968254f*(m[ 2])             +  0.025f*(m[ 6]-m[ 8])+0.125f*( m[17]+m[18])-0.027777778f*(m[10])+omega*(-0.055555556f*(m[ 9]) +(-0.25f*(m[14])));
f[17] -= 0.0033416876f*(m[ 1])+ 0.003968254f*(m[ 2])+-0.025f*(m[ 4]+m[ 8])              +0.013888889f*(m[10])-0.041666667f*(m[12])+0.125f*( m[16]-m[18])+ omega*(0.027777778f*(m[ 9]) -0.083333333f*(m[11])+( 0.25f*(m[15])));
f[18] -= 0.0033416876f*(m[ 1])+ 0.003968254f*(m[ 2])             + -0.025f*(m[ 6]+m[ 8])+0.125f*(-m[17]+m[18])-0.027777778f*(m[10])+omega*(-0.055555556f*(m[ 9]) +( 0.25f*(m[14])));

}

inline __device__ void North_Extrap(float* f, float rho)
{
    float m[19];
    rho = 1.0f;
    float u = f[ 1]-f[ 3]+f[ 5]-f[ 6]-f[ 7]+f[ 8]+f[10]-f[12]+f[15]-f[17];
    float v = f[ 2]-f[ 4]+f[ 5]+f[ 6]-f[ 7]-f[ 8]+f[11]-f[13]+f[16]-f[18];
    float w = f[ 9]+f[10]+f[11]+f[12]+f[13]-f[14]-f[15]-f[16]-f[17]-f[18];


    m[ 1]  = -30.f*f[ 0]+-11.f*f[ 1]+-11.f*f[ 2]+-11.f*f[ 3]+-11.f*f[ 4]+  8.f*f[ 5]+  8.f*f[ 6]+  8.f*f[ 7]+  8.f*f[ 8]+-11.f*f[ 9]+  8.f*f[10]+  8.f*f[11]+  8.f*f[12]+  8.f*f[13]+-11.f*f[14]+  8.f*f[15]+  8.f*f[16]+  8.f*f[17]+  8.f*f[18];
    m[ 2]  =  12.f*f[ 0]+ -4.f*f[ 1]+ -4.f*f[ 2]+ -4.f*f[ 3]+ -4.f*f[ 4]+    f[ 5]+    f[ 6]+    f[ 7]+    f[ 8]+ -4.f*f[ 9]+    f[10]+      f[11]+    f[12]+    f[13]+ -4.f*f[14]+    f[15]+    f[16]+    f[17]+    f[18];
    m[ 4]  =           -4.f*f[ 1]         +  4.f*f[ 3]         +    f[ 5]+ -  f[ 6]+ -  f[ 7]+    f[ 8]         +    f[10]          + -  f[12]                    +    f[15]          + -  f[17]          ;
    m[ 6]  =                    -4.f*f[ 2]         +  4.f*f[ 4]+    f[ 5]+    f[ 6]+ -  f[ 7]+ -  f[ 8]                   +    f[11]          + -  f[13]                    +    f[16]          + -  f[18];
    m[ 8]  =                                                                                 + -4.f*f[ 9]+    f[10]+    f[11]+    f[12]+    f[13]+  4.f*f[14]+ -  f[15]+ -  f[16]+ -  f[17]+ -  f[18];
    m[ 9]  =            2.f*f[ 1]+ -  f[ 2]+  2.f*f[ 3]+ -  f[ 4]+    f[ 5]+    f[ 6]+    f[ 7]+    f[ 8]+ -  f[ 9]+    f[10]+ -2.f*f[11]+    f[12]+ -2.f*f[13]+ -  f[14]+    f[15]+ -2.f*f[16]+    f[17]+ -2.f*f[18];
    m[10] =           -4.f*f[ 1]+  2.f*f[ 2]+ -4.f*f[ 3]+  2.f*f[ 4]+    f[ 5]+    f[ 6]+    f[ 7]+    f[ 8]+  2.f*f[ 9]+    f[10]+ -2.f*f[11]+    f[12]+ -2.f*f[13]+  2.f*f[14]+    f[15]+ -2.f*f[16]+    f[17]+ -2.f*f[18];
    m[11] =                       f[ 2]         +    f[ 4]+    f[ 5]+    f[ 6]+    f[ 7]+    f[ 8]+ -  f[ 9]+ -  f[10]          + -  f[12]          + -  f[14]+ -  f[15]          + -  f[17]          ;
    m[12] =                    -2.f*f[ 2]           -2.f*f[ 4]+    f[ 5]+    f[ 6]+    f[ 7]+    f[ 8]+  2.f*f[ 9]+ -  f[10]          + -  f[12]          +  2.f*f[14]+ -  f[15]          + -  f[17]          ;
    m[13] =                                                  f[ 5]+ -  f[ 6]+    f[ 7]+ -  f[ 8]                                                                                                   ;
    m[14] =                                                                                                         f[11]          + -  f[13]                    + -  f[16]          +    f[18];
    m[15] =                                                                                               f[10]          + -  f[12]                    + -  f[15]          +    f[17]          ;  
    m[16] =                                                  f[ 5]+ -  f[ 6]+ -  f[ 7]+    f[ 8]           -  f[10]          +    f[12]                    + -  f[15]          +    f[17]          ;  
    m[17] =                                               -  f[ 5]+ -  f[ 6]+    f[ 7]+    f[ 8]                   +    f[11]          + -  f[13]                    +    f[16]          + -  f[18];  
    m[18] =                                                                                               f[10]+ -  f[11]+    f[12]+ -  f[13]          + -  f[15]+    f[16]+ -  f[17]+    f[18];

f[ 0] =(0.052631579f*rho                           +- 0.012531328f*(m[ 1])+ 0.047619048f*(m[ 2]));
f[ 1] =(0.052631579f*rho+  0.1f*u                  +-0.0045948204f*(m[ 1])+-0.015873016f*(m[ 2])+  -0.1f*(m[ 4])                 + 0.055555556f*((m[ 9])-m[10]));
f[ 2] =(0.052631579f*rho         +  0.1f*v         +-0.0045948204f*(m[ 1])+-0.015873016f*(m[ 2])             +   -0.1f*(m[ 6])   +-0.027777778f*((m[ 9])-m[10])+ 0.083333333f*((m[11])-m[12]));
f[ 3] =(0.052631579f*rho+ -0.1f*u                  +-0.0045948204f*(m[ 1])+-0.015873016f*(m[ 2])+   0.1f*(m[ 4])                 + 0.055555556f*((m[ 9])-m[10]));        
f[ 4] =(0.052631579f*rho         + -0.1f*v         +-0.0045948204f*(m[ 1])+-0.015873016f*(m[ 2])             +    0.1f*(m[ 6])   +-0.027777778f*((m[ 9])-m[10])+ 0.083333333f*((m[11])-m[12]));
f[ 5] =(0.052631579f*rho+  0.1f*u+  0.1f*v         + 0.0033416876f*(m[ 1])+ 0.003968254f*(m[ 2])+ 0.025f*(m[ 4]+m[ 6])              +0.013888889f*(m[10])+0.041666667f*(m[12])+0.125f*( m[16]-m[17])+ (0.027777778f*(m[ 9]) +0.083333333f*(m[11])+( 0.25f*(m[13]))));
f[ 6] =(0.052631579f*rho+ -0.1f*u+  0.1f*v         + 0.0033416876f*(m[ 1])+ 0.003968254f*(m[ 2])+-0.025f*(m[ 4]-m[ 6])              +0.013888889f*(m[10])+0.041666667f*(m[12])+0.125f*(-m[16]-m[17])+ (0.027777778f*(m[ 9]) +0.083333333f*(m[11])+(-0.25f*(m[13]))));
f[ 7] =(0.052631579f*rho+ -0.1f*u+ -0.1f*v         + 0.0033416876f*(m[ 1])+ 0.003968254f*(m[ 2])+-0.025f*(m[ 4]+m[ 6])              +0.013888889f*(m[10])+0.041666667f*(m[12])+0.125f*(-m[16]+m[17])+ (0.027777778f*(m[ 9]) +0.083333333f*(m[11])+( 0.25f*(m[13]))));
f[ 8] =(0.052631579f*rho+  0.1f*u+ -0.1f*v         + 0.0033416876f*(m[ 1])+ 0.003968254f*(m[ 2])+ 0.025f*(m[ 4]-m[ 6])              +0.013888889f*(m[10])+0.041666667f*(m[12])+0.125f*( m[16]+m[17])+ (0.027777778f*(m[ 9]) +0.083333333f*(m[11])+(-0.25f*(m[13]))));
f[ 9] =(0.052631579f*rho                  +  0.1f*w+-0.0045948204f*(m[ 1])+-0.015873016f*(m[ 2])                +   -0.1f*(m[ 8])+-0.027777778f*((m[ 9])-m[10])+-0.083333333f*((m[11])-m[12]));                                       
f[10]=(0.052631579f*rho+  0.1f*u         +  0.1f*w+ 0.0033416876f*(m[ 1])+ 0.003968254f*(m[ 2])+ 0.025f*(m[ 4]+m[ 8])              +0.013888889f*(m[10])-0.041666667f*(m[12])+0.125f*(-m[16]+m[18])+ (0.027777778f*(m[ 9]) -0.083333333f*(m[11])+( 0.25f*(m[15]))));
f[11]=(0.052631579f*rho         +  0.1f*v+  0.1f*w+ 0.0033416876f*(m[ 1])+ 0.003968254f*(m[ 2])             +  0.025f*(m[ 6]+m[ 8])+0.125f*( m[17]-m[18])-0.027777778f*(m[10])+(-0.055555556f*(m[ 9]) +( 0.25f*(m[14]))));
f[12]=(0.052631579f*rho+ -0.1f*u         +  0.1f*w+ 0.0033416876f*(m[ 1])+ 0.003968254f*(m[ 2])+-0.025f*(m[ 4]-m[ 8])              +0.013888889f*(m[10])-0.041666667f*(m[12])+0.125f*( m[16]+m[18])+ (0.027777778f*(m[ 9]) -0.083333333f*(m[11])+(-0.25f*(m[15]))));
f[13]=(0.052631579f*rho         + -0.1f*v+  0.1f*w+ 0.0033416876f*(m[ 1])+ 0.003968254f*(m[ 2])             + -0.025f*(m[ 6]-m[ 8])+0.125f*(-m[17]-m[18])-0.027777778f*(m[10])+(-0.055555556f*(m[ 9]) +(-0.25f*(m[14]))));
f[14]=(0.052631579f*rho                  + -0.1f*w+-0.0045948204f*(m[ 1])+-0.015873016f*(m[ 2])                +    0.1f*(m[ 8])+-0.027777778f*((m[ 9])-m[10])+-0.083333333f*((m[11])-m[12]));                                      
f[15]=(0.052631579f*rho+  0.1f*u         + -0.1f*w+ 0.0033416876f*(m[ 1])+ 0.003968254f*(m[ 2])+ 0.025f*(m[ 4]-m[ 8])              +0.013888889f*(m[10])-0.041666667f*(m[12])+0.125f*(-m[16]-m[18])+ (0.027777778f*(m[ 9]) -0.083333333f*(m[11])+(-0.25f*(m[15]))));
f[16]=(0.052631579f*rho         +  0.1f*v+ -0.1f*w+ 0.0033416876f*(m[ 1])+ 0.003968254f*(m[ 2])             +  0.025f*(m[ 6]-m[ 8])+0.125f*( m[17]+m[18])-0.027777778f*(m[10])+(-0.055555556f*(m[ 9]) +(-0.25f*(m[14]))));
f[17]=(0.052631579f*rho+ -0.1f*u         + -0.1f*w+ 0.0033416876f*(m[ 1])+ 0.003968254f*(m[ 2])+-0.025f*(m[ 4]+m[ 8])              +0.013888889f*(m[10])-0.041666667f*(m[12])+0.125f*( m[16]-m[18])+ (0.027777778f*(m[ 9]) -0.083333333f*(m[11])+( 0.25f*(m[15]))));
f[18]=(0.052631579f*rho         + -0.1f*v+ -0.1f*w+ 0.0033416876f*(m[ 1])+ 0.003968254f*(m[ 2])             + -0.025f*(m[ 6]+m[ 8])+0.125f*(-m[17]+m[18])-0.027777778f*(m[10])+(-0.055555556f*(m[ 9]) +( 0.25f*(m[14]))));

}

inline __device__ void South_Extrap(float* f, float v)
{
    float m[19];
    float u = 0.f;//f[ 1]-f[ 3]+f[ 5]-f[ 6]-f[ 7]+f[ 8]+f[10]-f[12]+f[15]-f[17];
    float w = 0.f;//f[ 9]+f[10]+f[11]+f[12]+f[13]-f[14]-f[15]-f[16]-f[17]-f[18];
    float rho = f[0]+f[1]+f[2]+f[3]+f[4]+f[5]+f[6]+f[7]+f[8]+f[9]+f[10]+f[11]+f[12]+f[13]+f[14]+f[15]+f[16]+f[17]+f[18];

    m[ 1]  = -30.f*f[ 0]+-11.f*f[ 1]+-11.f*f[ 2]+-11.f*f[ 3]+-11.f*f[ 4]+  8.f*f[ 5]+  8.f*f[ 6]+  8.f*f[ 7]+  8.f*f[ 8]+-11.f*f[ 9]+  8.f*f[10]+  8.f*f[11]+  8.f*f[12]+  8.f*f[13]+-11.f*f[14]+  8.f*f[15]+  8.f*f[16]+  8.f*f[17]+  8.f*f[18];
    m[ 2]  =  12.f*f[ 0]+ -4.f*f[ 1]+ -4.f*f[ 2]+ -4.f*f[ 3]+ -4.f*f[ 4]+    f[ 5]+    f[ 6]+    f[ 7]+    f[ 8]+ -4.f*f[ 9]+    f[10]+      f[11]+    f[12]+    f[13]+ -4.f*f[14]+    f[15]+    f[16]+    f[17]+    f[18];
    m[ 4]  =           -4.f*f[ 1]         +  4.f*f[ 3]         +    f[ 5]+ -  f[ 6]+ -  f[ 7]+    f[ 8]         +    f[10]          + -  f[12]                    +    f[15]          + -  f[17]          ;
    m[ 6]  =                    -4.f*f[ 2]         +  4.f*f[ 4]+    f[ 5]+    f[ 6]+ -  f[ 7]+ -  f[ 8]                   +    f[11]          + -  f[13]                    +    f[16]          + -  f[18];
    m[ 8]  =                                                                                 + -4.f*f[ 9]+    f[10]+    f[11]+    f[12]+    f[13]+  4.f*f[14]+ -  f[15]+ -  f[16]+ -  f[17]+ -  f[18];
    m[ 9]  =            2.f*f[ 1]+ -  f[ 2]+  2.f*f[ 3]+ -  f[ 4]+    f[ 5]+    f[ 6]+    f[ 7]+    f[ 8]+ -  f[ 9]+    f[10]+ -2.f*f[11]+    f[12]+ -2.f*f[13]+ -  f[14]+    f[15]+ -2.f*f[16]+    f[17]+ -2.f*f[18];
    m[10] =           -4.f*f[ 1]+  2.f*f[ 2]+ -4.f*f[ 3]+  2.f*f[ 4]+    f[ 5]+    f[ 6]+    f[ 7]+    f[ 8]+  2.f*f[ 9]+    f[10]+ -2.f*f[11]+    f[12]+ -2.f*f[13]+  2.f*f[14]+    f[15]+ -2.f*f[16]+    f[17]+ -2.f*f[18];
    m[11] =                       f[ 2]         +    f[ 4]+    f[ 5]+    f[ 6]+    f[ 7]+    f[ 8]+ -  f[ 9]+ -  f[10]          + -  f[12]          + -  f[14]+ -  f[15]          + -  f[17]          ;
    m[12] =                    -2.f*f[ 2]           -2.f*f[ 4]+    f[ 5]+    f[ 6]+    f[ 7]+    f[ 8]+  2.f*f[ 9]+ -  f[10]          + -  f[12]          +  2.f*f[14]+ -  f[15]          + -  f[17]          ;
    m[13] =                                                  f[ 5]+ -  f[ 6]+    f[ 7]+ -  f[ 8]                                                                                                   ;
    m[14] =                                                                                                         f[11]          + -  f[13]                    + -  f[16]          +    f[18];
    m[15] =                                                                                               f[10]          + -  f[12]                    + -  f[15]          +    f[17]          ;  
    m[16] =                                                  f[ 5]+ -  f[ 6]+ -  f[ 7]+    f[ 8]           -  f[10]          +    f[12]                    + -  f[15]          +    f[17]          ;  
    m[17] =                                               -  f[ 5]+ -  f[ 6]+    f[ 7]+    f[ 8]                   +    f[11]          + -  f[13]                    +    f[16]          + -  f[18];  
    m[18] =                                                                                               f[10]+ -  f[11]+    f[12]+ -  f[13]          + -  f[15]+    f[16]+ -  f[17]+    f[18];

f[ 0] =(0.052631579f*rho                           +- 0.012531328f*(m[ 1])+ 0.047619048f*(m[ 2]));
f[ 1] =(0.052631579f*rho+  0.1f*u                  +-0.0045948204f*(m[ 1])+-0.015873016f*(m[ 2])+  -0.1f*(m[ 4])                 + 0.055555556f*((m[ 9])-m[10]));
f[ 2] =(0.052631579f*rho         +  0.1f*v         +-0.0045948204f*(m[ 1])+-0.015873016f*(m[ 2])             +   -0.1f*(m[ 6])   +-0.027777778f*((m[ 9])-m[10])+ 0.083333333f*((m[11])-m[12]));
f[ 3] =(0.052631579f*rho+ -0.1f*u                  +-0.0045948204f*(m[ 1])+-0.015873016f*(m[ 2])+   0.1f*(m[ 4])                 + 0.055555556f*((m[ 9])-m[10]));        
f[ 4] =(0.052631579f*rho         + -0.1f*v         +-0.0045948204f*(m[ 1])+-0.015873016f*(m[ 2])             +    0.1f*(m[ 6])   +-0.027777778f*((m[ 9])-m[10])+ 0.083333333f*((m[11])-m[12]));
f[ 5] =(0.052631579f*rho+  0.1f*u+  0.1f*v         + 0.0033416876f*(m[ 1])+ 0.003968254f*(m[ 2])+ 0.025f*(m[ 4]+m[ 6])              +0.013888889f*(m[10])+0.041666667f*(m[12])+0.125f*( m[16]-m[17])+ (0.027777778f*(m[ 9]) +0.083333333f*(m[11])+( 0.25f*(m[13]))));
f[ 6] =(0.052631579f*rho+ -0.1f*u+  0.1f*v         + 0.0033416876f*(m[ 1])+ 0.003968254f*(m[ 2])+-0.025f*(m[ 4]-m[ 6])              +0.013888889f*(m[10])+0.041666667f*(m[12])+0.125f*(-m[16]-m[17])+ (0.027777778f*(m[ 9]) +0.083333333f*(m[11])+(-0.25f*(m[13]))));
f[ 7] =(0.052631579f*rho+ -0.1f*u+ -0.1f*v         + 0.0033416876f*(m[ 1])+ 0.003968254f*(m[ 2])+-0.025f*(m[ 4]+m[ 6])              +0.013888889f*(m[10])+0.041666667f*(m[12])+0.125f*(-m[16]+m[17])+ (0.027777778f*(m[ 9]) +0.083333333f*(m[11])+( 0.25f*(m[13]))));
f[ 8] =(0.052631579f*rho+  0.1f*u+ -0.1f*v         + 0.0033416876f*(m[ 1])+ 0.003968254f*(m[ 2])+ 0.025f*(m[ 4]-m[ 6])              +0.013888889f*(m[10])+0.041666667f*(m[12])+0.125f*( m[16]+m[17])+ (0.027777778f*(m[ 9]) +0.083333333f*(m[11])+(-0.25f*(m[13]))));
f[ 9] =(0.052631579f*rho                  +  0.1f*w+-0.0045948204f*(m[ 1])+-0.015873016f*(m[ 2])                +   -0.1f*(m[ 8])+-0.027777778f*((m[ 9])-m[10])+-0.083333333f*((m[11])-m[12]));                                       
f[10]=(0.052631579f*rho+  0.1f*u         +  0.1f*w+ 0.0033416876f*(m[ 1])+ 0.003968254f*(m[ 2])+ 0.025f*(m[ 4]+m[ 8])              +0.013888889f*(m[10])-0.041666667f*(m[12])+0.125f*(-m[16]+m[18])+ (0.027777778f*(m[ 9]) -0.083333333f*(m[11])+( 0.25f*(m[15]))));
f[11]=(0.052631579f*rho         +  0.1f*v+  0.1f*w+ 0.0033416876f*(m[ 1])+ 0.003968254f*(m[ 2])             +  0.025f*(m[ 6]+m[ 8])+0.125f*( m[17]-m[18])-0.027777778f*(m[10])+(-0.055555556f*(m[ 9]) +( 0.25f*(m[14]))));
f[12]=(0.052631579f*rho+ -0.1f*u         +  0.1f*w+ 0.0033416876f*(m[ 1])+ 0.003968254f*(m[ 2])+-0.025f*(m[ 4]-m[ 8])              +0.013888889f*(m[10])-0.041666667f*(m[12])+0.125f*( m[16]+m[18])+ (0.027777778f*(m[ 9]) -0.083333333f*(m[11])+(-0.25f*(m[15]))));
f[13]=(0.052631579f*rho         + -0.1f*v+  0.1f*w+ 0.0033416876f*(m[ 1])+ 0.003968254f*(m[ 2])             + -0.025f*(m[ 6]-m[ 8])+0.125f*(-m[17]-m[18])-0.027777778f*(m[10])+(-0.055555556f*(m[ 9]) +(-0.25f*(m[14]))));
f[14]=(0.052631579f*rho                  + -0.1f*w+-0.0045948204f*(m[ 1])+-0.015873016f*(m[ 2])                +    0.1f*(m[ 8])+-0.027777778f*((m[ 9])-m[10])+-0.083333333f*((m[11])-m[12]));                                      
f[15]=(0.052631579f*rho+  0.1f*u         + -0.1f*w+ 0.0033416876f*(m[ 1])+ 0.003968254f*(m[ 2])+ 0.025f*(m[ 4]-m[ 8])              +0.013888889f*(m[10])-0.041666667f*(m[12])+0.125f*(-m[16]-m[18])+ (0.027777778f*(m[ 9]) -0.083333333f*(m[11])+(-0.25f*(m[15]))));
f[16]=(0.052631579f*rho         +  0.1f*v+ -0.1f*w+ 0.0033416876f*(m[ 1])+ 0.003968254f*(m[ 2])             +  0.025f*(m[ 6]-m[ 8])+0.125f*( m[17]+m[18])-0.027777778f*(m[10])+(-0.055555556f*(m[ 9]) +(-0.25f*(m[14]))));
f[17]=(0.052631579f*rho+ -0.1f*u         + -0.1f*w+ 0.0033416876f*(m[ 1])+ 0.003968254f*(m[ 2])+-0.025f*(m[ 4]+m[ 8])              +0.013888889f*(m[10])-0.041666667f*(m[12])+0.125f*( m[16]-m[18])+ (0.027777778f*(m[ 9]) -0.083333333f*(m[11])+( 0.25f*(m[15]))));
f[18]=(0.052631579f*rho         + -0.1f*v+ -0.1f*w+ 0.0033416876f*(m[ 1])+ 0.003968254f*(m[ 2])             + -0.025f*(m[ 6]+m[ 8])+0.125f*(-m[17]+m[18])-0.027777778f*(m[10])+(-0.055555556f*(m[ 9]) +( 0.25f*(m[14]))));

}

__device__ void xsymmetry_bot(float* f, int y, int z)
{
    if(y == 0 && z == 0){
        f[ 2] = f[ 4];
        f[13]=f[18];
        f[11]=f[18];
        f[16]=f[18];
        f[ 6] =f[ 7];
        f[ 9] =f[14];
        f[12]=f[17];
    }
    else if(y == 0 && z == ZDIM-1){
        f[ 4] = f[ 2];
        f[11]=f[13];
        f[18]=f[13];
        f[16]=f[13];
        f[ 6] =f[ 7];
        f[14]=f[ 9];
        f[17]=f[12];
    }
    else if(y == YDIM-1 && z == 0){
        f[ 4] = f[ 2];
        f[11]=f[16];
        f[18]=f[16];
        f[13]=f[16];
        f[ 7] =f[ 6];
        f[ 9] =f[14];
        f[12]=f[17];
    }
    else if(y == YDIM-1 && z == ZDIM-1){
        f[ 4] = f[ 2];
        f[16]=f[11];
        f[18]=f[11];
        f[13]=f[11];
        f[ 7] =f[ 6];
        f[14]=f[ 9];
        f[17]=f[12];
    }
    else{
    if(y == 0){
        f[ 2] = f[ 4];
        f[11]=f[13];
        f[16]=f[18];
        f[ 8] = f[ 5];
    }
    else if(y == YDIM-1){
         f[ 4]=f[ 2] ;
        f[13]=f[11];
        f[18]=f[16];
         f[ 5]=f[ 8] ;
    }
    }
    f[ 1] = f[ 3] ;
    f[ 5] = f[ 6] ;
    f[ 8] = f[ 7] ;
    f[10]= f[12];
    f[15]= f[17];
}

__device__ void xsymmetry_top(float* f, int y, int z)
{
    if(y == 0 && z == 0){
        f[ 2]  = f[ 4];
        f[13] = f[18];            
        f[11] = f[18];
        f[16] = f[18];
        f[ 5]  = f[ 8];
        f[ 9]  = f[14];
        f[10] = f[15];
    }
    else if(y == 0 && z == ZDIM-1){
        f[ 2]  = f[ 4];
        f[11] = f[13];
        f[18] = f[13];
        f[16] = f[13];
        f[ 5]  = f[ 8];
        f[14] = f[ 9];
        f[15] = f[10];
    }
    else if(y == YDIM-1 && z == 0){
        f[ 4]  = f[ 2];
        f[18] = f[16];
        f[11] = f[16];
        f[13] = f[16];    
        f[ 8]  = f[ 5];
        f[ 9]  = f[14];
        f[10] = f[15];
    }
    else if(y == YDIM-1 && z == ZDIM-1){
        f[ 4]  = f[ 2];
        f[13] = f[11];
        f[16] = f[11];
        f[18] = f[11];
        f[ 8]  = f[ 5];
        f[14] = f[ 9];
        f[15] = f[10];
    }

    else{
    if(y == 0){
        f[ 2] = f[ 4];
        f[11] = f[13];
        f[16] = f[18];
        f[ 5] = f[ 8];
    }
    else if(y == YDIM-1){
        f[ 4] = f[ 2];
        f[13] = f[11];
        f[18] = f[16];
        f[ 8] = f[ 5];
    }
    }
    f[ 3] = f[ 1] ;
    f[ 6] = f[ 5] ;
    f[ 7] = f[ 8] ;
    f[12]= f[10];
    f[17]= f[15];
}

inline __device__ void vel_av(float* f, float& uAv, float& vAv, int t)
{
    float u,v;//,w;    
    u = f[ 1]-f[ 3]+f[ 5]-f[ 6]-f[ 7]+f[ 8]+f[10]-f[12]+f[15]-f[17];
    v = f[ 2]-f[ 4]+f[ 5]+f[ 6]-f[ 7]-f[ 8]+f[11]-f[13]+f[16]-f[18];
    uAv = (uAv*(t-START_VELAV)+u)/((t-START_VELAV)+1);
    vAv = (vAv*(t-START_VELAV)+v)/((t-START_VELAV)+1);
}
inline __device__ void vel_avLR(float* f, float& uAv, float& vAv, float t)
{
    float u,v;//,w;    
    u = f[ 1]-f[ 3]+f[ 5]-f[ 6]-f[ 7]+f[ 8]+f[10]-f[12]+f[15]-f[17];
    v = f[ 2]-f[ 4]+f[ 5]+f[ 6]-f[ 7]-f[ 8]+f[11]-f[13]+f[16]-f[18];
    uAv = (uAv*(t-START_VELAV)+u*LRFACTOR)/((t-START_VELAV)+LRFACTOR);
    vAv = (vAv*(t-START_VELAV)+v*LRFACTOR)/((t-START_VELAV)+LRFACTOR);
}

inline __device__ void vel_fluc(float* f, float& uAv, 
                    float& vAv, float& ufluc, float& vfluc, int t)
{
    float u,v;//,w;    
    u = f[ 1]-f[ 3]+f[ 5]-f[ 6]-f[ 7]+f[ 8]+f[10]-f[12]+f[15]-f[17];
    v = f[ 2]-f[ 4]+f[ 5]+f[ 6]-f[ 7]-f[ 8]+f[11]-f[13]+f[16]-f[18];
    u = (u-uAv)*(u-uAv);
    v = (v-vAv)*(v-vAv);
    ufluc = (ufluc*(t-START_VELFLUC)+u)/((t-START_VELFLUC)+1);
    vfluc = (vfluc*(t-START_VELFLUC)+v)/((t-START_VELFLUC)+1);
}
inline __device__ void vel_flucLR(float* f, float& uAv, 
                    float& vAv, float& ufluc, float& vfluc, float t)
{
    float u,v;//,w;    
    u = f[ 1]-f[ 3]+f[ 5]-f[ 6]-f[ 7]+f[ 8]+f[10]-f[12]+f[15]-f[17];
    v = f[ 2]-f[ 4]+f[ 5]+f[ 6]-f[ 7]-f[ 8]+f[11]-f[13]+f[16]-f[18];
    u = (u-uAv)*(u-uAv);
    v = (v-vAv)*(v-vAv);
    ufluc = (ufluc*(t-START_VELFLUC)+u*LRFACTOR)/((t-START_VELFLUC)+LRFACTOR);
    vfluc = (vfluc*(t-START_VELFLUC)+v*LRFACTOR)/((t-START_VELFLUC)+LRFACTOR);
}

__global__ void initialize(float *fout, size_t pitch, int zInner, int GPU_N)
{
    int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
    int y = threadIdx.y+blockIdx.y*blockDim.y;
    int z = threadIdx.z+blockIdx.z*blockDim.z;
    float xcoord = x;
    float ycoord = y;
    float zcoord = z+1+GPU_N*ZDIM;
    int j = x+y*pitch+z*YDIM*pitch;//index on padded mem (pitch in elements)
    float f[19] = {0};
    float m[19] = {0};
    
    int im = ImageFcn(xcoord,ycoord,zcoord);
    float u,v,w,rho;
    rho = 1.f;
    u = 0.01f;
    v = UMAX;
    w = 0.0;

    if(im == 10 || im == 1){
    u = 0.0f;
    v = 0.0f;
    w = 0.0f;
    }
    
    mrt_meq(m,rho,u,v,w);
    InvertMoments(f,m);
    
    for(int i = 0; i<19; i++)
    fout[j+i *pitch*YDIM*zInner]=f[ i];
}

__global__ void initializeLR(float *fout, size_t pitch, int zInner, int GPU_N)
{
    int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
    int y = threadIdx.y+blockIdx.y*blockDim.y;
    int z = threadIdx.z+blockIdx.z*blockDim.z;
    float xcoord = x;
    float ycoord = y;
    float zcoord = z+1+GPU_N*(zInner+2);
    xcoord = LRX0+x*LRFACTOR;
    ycoord = LRY0+y*LRFACTOR;
    zcoord = LRZ0+z*LRFACTOR;
    int j = x+y*pitch+z*YLRDIM*pitch;//index on padded mem (pitch in elements)
    float f[19] = {0};
    float m[19] = {0};
    
    int im = ImageFcn(xcoord,ycoord,zcoord);
    float u,v,w,rho;
    rho = 1.f;
    u = 0.01f;
    v = UMAX;
    w = 0.0f;

    if(im == 10 || im == 1){
    u = 0.0f;
    v = 0.0f;
    w = 0.0f;
    }
    
    mrt_meq(m,rho,u,v,w);
    InvertMoments(f,m);
    
    for(int i = 0; i<19; i++)
    fout[j+i *pitch*YLRDIM*zInner]=f[ i];
}

__global__ void update_top(float* hB, float* hA, float* fA, float* temp,
                            float omega, size_t pitch, int GPU, int zInner, float* FX, float* FY, float* FZ, int t, int flag_F)
{
    int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
    int y = threadIdx.y+blockIdx.y*blockDim.y;
    int j = x+y*pitch;//index on padded mem (pitch in elements)
    int im = ImageFcn(x,y,(GPU+1)*(zInner+2)-1);
    float f[19];
    __shared__ float sumX[BLOCKSIZEX], sumY[BLOCKSIZEX], sumZ[BLOCKSIZEX];
    __shared__ int check[1];
    check[0] = 0;
    syncthreads();

    f[0 ]= hA  [j];
    f[1 ]= hA  [buff_mem(1 ,x-1,y  ,pitch)];
    f[3 ]= hA  [buff_mem(3 ,x+1,y  ,pitch)];
    f[2 ]= hA  [buff_mem(2 ,x  ,y-1,pitch)];
    f[5 ]= hA  [buff_mem(5 ,x-1,y-1,pitch)];
    f[6 ]= hA  [buff_mem(6 ,x+1,y-1,pitch)];
    f[4 ]= hA  [buff_mem(4 ,x  ,y+1,pitch)];
    f[7 ]= hA  [buff_mem(7 ,x+1,y+1,pitch)];
    f[8 ]= hA  [buff_mem(8 ,x-1,y+1,pitch)];
    f[9 ]= fA  [f_mem   (9 ,x  ,y  ,zInner-1,pitch, zInner)];
    f[10]= fA  [f_mem   (10,x-1,y  ,zInner-1,pitch, zInner)];
    f[11]= fA  [f_mem   (11,x  ,y-1,zInner-1,pitch, zInner)];
    f[12]= fA  [f_mem   (12,x+1,y  ,zInner-1,pitch, zInner)];
    f[13]= fA  [f_mem   (13,x  ,y+1,zInner-1,pitch, zInner)];
    f[14]= temp[buff_mem(14,x  ,y  ,pitch)];
    f[15]= temp[buff_mem(15,x-1,y  ,pitch)];
    f[16]= temp[buff_mem(16,x  ,y-1,pitch)];
    f[17]= temp[buff_mem(17,x+1,y  ,pitch)];
    f[18]= temp[buff_mem(18,x  ,y+1,pitch)];

    if(im == 1 || im ==10){//BB
        if(im == 10 && flag_F == 1){
        check[0] = 1;
        sumX[threadIdx.x]=2.f*f[ 1]-2.f*f[ 3]+2.f*f[ 5]+2.f*f[ 8]-2.f*f[ 6];
        sumX[threadIdx.x]+=-2.f*f[ 7]+2.f*f[10]-2.f*f[12]+2.f*f[15]-2.f*f[17];
        sumY[threadIdx.x]=2.f*f[ 2]-2.f*f[ 4]+2.f*f[ 5]-2.f*f[ 8]+2.f*f[ 6];
        sumY[threadIdx.x]+=-2.f*f[ 7]+2.f*f[11]-2.f*f[13]+2.f*f[16]-2.f*f[18];
        sumZ[threadIdx.x]=2.f*f[ 9]+2.f*f[10]+2.f*f[11]+2.f*f[12]+2.f*f[13];
        sumZ[threadIdx.x]+=-2.f*f[14]-2.f*f[15]-2.f*f[16]-2.f*f[17]-2.f*f[18];
        }
        else{
        sumX[threadIdx.x]=0.f;
        sumY[threadIdx.x]=0.f;
        sumZ[threadIdx.x]=0.f;
        }
        hB[buff_mem(0 ,x,y,pitch)] = f[0 ];
        hB[buff_mem(1 ,x,y,pitch)] = f[3 ];
        hB[buff_mem(2 ,x,y,pitch)] = f[4 ];
        hB[buff_mem(3 ,x,y,pitch)] = f[1 ];
        hB[buff_mem(4 ,x,y,pitch)] = f[2 ];
        hB[buff_mem(5 ,x,y,pitch)] = f[7 ];
        hB[buff_mem(6 ,x,y,pitch)] = f[8 ];
        hB[buff_mem(7 ,x,y,pitch)] = f[5 ];
        hB[buff_mem(8 ,x,y,pitch)] = f[6 ];
        hB[buff_mem(9 ,x,y,pitch)] = f[14];
        hB[buff_mem(10,x,y,pitch)] = f[17];
        hB[buff_mem(11,x,y,pitch)] = f[18];
        hB[buff_mem(12,x,y,pitch)] = f[15];
        hB[buff_mem(13,x,y,pitch)] = f[16];
        hB[buff_mem(14,x,y,pitch)] = f[9 ];
        hB[buff_mem(15,x,y,pitch)] = f[12];
        hB[buff_mem(16,x,y,pitch)] = f[13];
        hB[buff_mem(17,x,y,pitch)] = f[10];
        hB[buff_mem(18,x,y,pitch)] = f[11];
    }
    else{
        sumX[threadIdx.x]=0.f;
        sumY[threadIdx.x]=0.f;
        sumZ[threadIdx.x]=0.f;
        if(im == 100)//north outlet
        {
            for(int i = 0; i<19; i++)
                   f[i ]= hA[buff_mem(i ,x,y-1,pitch)];
            North_Extrap(f,1.0f);
        }
        if(im == 200)//south inlet
        {
            for(int i = 0; i<19; i++)
                   f[i ]= hA[buff_mem(i ,x,y+1,pitch)];
            South_Extrap(f,UMAX);
        }
        if(im == 25)
            xsymmetry_top(f,y,(GPU+1)*(zInner+2)-1);
        if(im == 26)
            xsymmetry_bot(f,y,(GPU+1)*(zInner+2)-1);

        mrt_collide(f,omega);

        for(int i = 0; i<19; i++)
            hB[buff_mem(i ,x,y,pitch)] = f[i ];
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
        atomicAdd(&FX[t-STARTF],sumX[0]);
        atomicAdd(&FY[t-STARTF],sumY[0]);
        atomicAdd(&FZ[t-STARTF],sumZ[0]);
    }
    }

}

__global__ void update_bot(float* gB, float* gA, float* fA, float* temp,
                            float omega, size_t pitch, int GPU, int zInner, float* FX, float* FY, float* FZ, int t, int flag_F)
{
    int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
    int y = threadIdx.y+blockIdx.y*blockDim.y;
    int j = x+y*pitch;//index on padded mem (pitch in elements)
    int im = ImageFcn(x,y,(GPU+1)*(zInner+2)-1);
    float f[19];
    __shared__ float sumX[BLOCKSIZEX], sumY[BLOCKSIZEX], sumZ[BLOCKSIZEX];
    __shared__ int check[1];
    check[0] = 0;
    syncthreads();

    f[0 ]= gA  [j];
    f[1 ]= gA  [buff_mem(1 ,x-1,y  ,pitch)];
    f[3 ]= gA  [buff_mem(3 ,x+1,y  ,pitch)];
    f[2 ]= gA  [buff_mem(2 ,x  ,y-1,pitch)];
    f[5 ]= gA  [buff_mem(5 ,x-1,y-1,pitch)];
    f[6 ]= gA  [buff_mem(6 ,x+1,y-1,pitch)];
    f[4 ]= gA  [buff_mem(4 ,x  ,y+1,pitch)];
    f[7 ]= gA  [buff_mem(7 ,x+1,y+1,pitch)];
    f[8 ]= gA  [buff_mem(8 ,x-1,y+1,pitch)];
    f[9 ]= temp[buff_mem(9 ,x  ,y  ,pitch)];
    f[10]= temp[buff_mem(10,x-1,y  ,pitch)];
    f[11]= temp[buff_mem(11,x  ,y-1,pitch)];
    f[12]= temp[buff_mem(12,x+1,y  ,pitch)];
    f[13]= temp[buff_mem(13,x  ,y+1,pitch)];
    f[14]= fA  [f_mem   (14,x  ,y  ,0,pitch, zInner)];
    f[15]= fA  [f_mem   (15,x-1,y  ,0,pitch, zInner)];
    f[16]= fA  [f_mem   (16,x  ,y-1,0,pitch, zInner)];
    f[17]= fA  [f_mem   (17,x+1,y  ,0,pitch, zInner)];
    f[18]= fA  [f_mem   (18,x  ,y+1,0,pitch, zInner)];

    if(im == 1 || im ==10){//BB
        if(im == 10 && flag_F == 1){
        check[0] = 1;
        sumX[threadIdx.x]=2.f*f[ 1]-2.f*f[ 3]+2.f*f[ 5]+2.f*f[ 8]-2.f*f[ 6];
        sumX[threadIdx.x]+=-2.f*f[ 7]+2.f*f[10]-2.f*f[12]+2.f*f[15]-2.f*f[17];
        sumY[threadIdx.x]=2.f*f[ 2]-2.f*f[ 4]+2.f*f[ 5]-2.f*f[ 8]+2.f*f[ 6];
        sumY[threadIdx.x]+=-2.f*f[ 7]+2.f*f[11]-2.f*f[13]+2.f*f[16]-2.f*f[18];
        sumZ[threadIdx.x]=2.f*f[ 9]+2.f*f[10]+2.f*f[11]+2.f*f[12]+2.f*f[13];
        sumZ[threadIdx.x]+=-2.f*f[14]-2.f*f[15]-2.f*f[16]-2.f*f[17]-2.f*f[18];
        }
        else{
        sumX[threadIdx.x]=0.f;
        sumY[threadIdx.x]=0.f;
        sumZ[threadIdx.x]=0.f;
        }
        gB[buff_mem(0 ,x,y,pitch)] = f[0 ];
        gB[buff_mem(1 ,x,y,pitch)] = f[3 ];
        gB[buff_mem(2 ,x,y,pitch)] = f[4 ];
        gB[buff_mem(3 ,x,y,pitch)] = f[1 ];
        gB[buff_mem(4 ,x,y,pitch)] = f[2 ];
        gB[buff_mem(5 ,x,y,pitch)] = f[7 ];
        gB[buff_mem(6 ,x,y,pitch)] = f[8 ];
        gB[buff_mem(7 ,x,y,pitch)] = f[5 ];
        gB[buff_mem(8 ,x,y,pitch)] = f[6 ];
        gB[buff_mem(9 ,x,y,pitch)] = f[14];
        gB[buff_mem(10,x,y,pitch)] = f[17];
        gB[buff_mem(11,x,y,pitch)] = f[18];
        gB[buff_mem(12,x,y,pitch)] = f[15];
        gB[buff_mem(13,x,y,pitch)] = f[16];
        gB[buff_mem(14,x,y,pitch)] = f[9 ];
        gB[buff_mem(15,x,y,pitch)] = f[12];
        gB[buff_mem(16,x,y,pitch)] = f[13];
        gB[buff_mem(17,x,y,pitch)] = f[10];
        gB[buff_mem(18,x,y,pitch)] = f[11];
    }
    else{
        sumX[threadIdx.x]=0.f;
        sumY[threadIdx.x]=0.f;
        sumZ[threadIdx.x]=0.f;
        if(im == 100)//north outlet
        {
            for(int i = 0; i<19; i++)
                   f[i ]= gA[buff_mem(i ,x,y-1,pitch)];
            North_Extrap(f,1.0f);
        }
        if(im == 200)//south inlet
        {
            for(int i = 0; i<19; i++)
                   f[i ]= gA[buff_mem(i ,x,y+1,pitch)];
            South_Extrap(f,UMAX);
        }
        if(im == 25)
            xsymmetry_top(f,y,GPU*(zInner+2));
        if(im == 26)
            xsymmetry_bot(f,y,GPU*(zInner+2));

        mrt_collide(f,omega);

        for(int i = 0; i<19; i++)
            gB[buff_mem(i ,x,y,pitch)] = f[i ];
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
        atomicAdd(&FX[t-STARTF],sumX[0]);
        atomicAdd(&FY[t-STARTF],sumY[0]);
        atomicAdd(&FZ[t-STARTF],sumZ[0]);
    }
    }
}

__global__ void update_inn(float* fB, float* fA, float* g, float* h, float omega, size_t pitch, int GPU, int zInner, float** velAv, float** velFluc, float* FX, float* FY, float* FZ, int t, int flag_F)
{
    int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
    int y = threadIdx.y+blockIdx.y*blockDim.y;
    int z = threadIdx.z+blockIdx.z*blockDim.z;
    int j = x+y*pitch+z*YDIM*pitch;//index on padded mem (pitch in elements)
    int im = ImageFcn(x,y,GPU*(zInner+2)+1+z);
    float f[19];
    __shared__ float sumX[BLOCKSIZEX], sumY[BLOCKSIZEX], sumZ[BLOCKSIZEX];
    __shared__ int check[1];
    check[0] = 0;
    syncthreads();

    f[ 0] = fA[j];
    f[ 1] = fA[f_mem   (1 ,x-1,y  ,z  ,pitch, zInner)];
    f[ 3] = fA[f_mem   (3 ,x+1,y  ,z  ,pitch, zInner)];
    f[ 2] = fA[f_mem   (2 ,x  ,y-1,z  ,pitch, zInner)];
    f[ 5] = fA[f_mem   (5 ,x-1,y-1,z  ,pitch, zInner)];
    f[ 6] = fA[f_mem   (6 ,x+1,y-1,z  ,pitch, zInner)];
    f[ 4] = fA[f_mem   (4 ,x  ,y+1,z  ,pitch, zInner)];
    f[ 7] = fA[f_mem   (7 ,x+1,y+1,z  ,pitch, zInner)];
    f[ 8] = fA[f_mem   (8 ,x-1,y+1,z  ,pitch, zInner)];

    if(z==zInner-1){//top nodes need info from h
    f[ 9] = fA[f_mem   (9 ,x  ,y  ,z-1,pitch, zInner)];
    f[10]= fA[f_mem   (10,x-1,y  ,z-1,pitch, zInner)];
    f[11]= fA[f_mem   (11,x  ,y-1,z-1,pitch, zInner)];
    f[12]= fA[f_mem   (12,x+1,y  ,z-1,pitch, zInner)];
    f[13]= fA[f_mem   (13,x  ,y+1,z-1,pitch, zInner)];
    f[14]= h [buff_mem(14,x  ,y  ,pitch)];
    f[15]= h [buff_mem(15,x-1,y  ,pitch)];
    f[16]= h [buff_mem(16,x  ,y-1,pitch)];
    f[17]= h [buff_mem(17,x+1,y  ,pitch)];
    f[18]= h [buff_mem(18,x  ,y+1,pitch)];
    }
    else if(z==0){//bottom nodes need info from g
    f[ 9] =g [buff_mem(9 ,x  ,y  ,pitch)];
    f[10]= g [buff_mem(10,x-1,y  ,pitch)];
    f[11]= g [buff_mem(11,x  ,y-1,pitch)];
    f[12]= g [buff_mem(12,x+1,y  ,pitch)];
    f[13]= g [buff_mem(13,x  ,y+1,pitch)];
    f[14]= fA[f_mem   (14,x  ,y  ,z+1,pitch, zInner)];
    f[15]= fA[f_mem   (15,x-1,y  ,z+1,pitch, zInner)];
    f[16]= fA[f_mem   (16,x  ,y-1,z+1,pitch, zInner)];
    f[17]= fA[f_mem   (17,x+1,y  ,z+1,pitch, zInner)];
    f[18]= fA[f_mem   (18,x  ,y+1,z+1,pitch, zInner)];
    }
    else{//normal nodes
    f[ 9] = fA[f_mem(9 ,x  ,y  ,z-1,pitch,zInner)];
    f[10]= fA[f_mem(10,x-1,y  ,z-1,pitch,zInner)];
    f[11]= fA[f_mem(11,x  ,y-1,z-1,pitch,zInner)];
    f[12]= fA[f_mem(12,x+1,y  ,z-1,pitch,zInner)];
    f[13]= fA[f_mem(13,x  ,y+1,z-1,pitch,zInner)];
    f[14]= fA[f_mem(14,x  ,y  ,z+1,pitch,zInner)];
    f[15]= fA[f_mem(15,x-1,y  ,z+1,pitch,zInner)];
    f[16]= fA[f_mem(16,x  ,y-1,z+1,pitch,zInner)];
    f[17]= fA[f_mem(17,x+1,y  ,z+1,pitch,zInner)];
    f[18]= fA[f_mem(18,x  ,y+1,z+1,pitch,zInner)];

    }//end normal nodes

    if(im == 1 || im ==10){//BB
        if(im == 10 && flag_F == 1){
        check[0] = 1;
        sumX[threadIdx.x]=2.f*f[ 1]-2.f*f[ 3]+2.f*f[ 5]+2.f*f[ 8]-2.f*f[ 6];
        sumX[threadIdx.x]+=-2.f*f[ 7]+2.f*f[10]-2.f*f[12]+2.f*f[15]-2.f*f[17];
        sumY[threadIdx.x]=2.f*f[ 2]-2.f*f[ 4]+2.f*f[ 5]-2.f*f[ 8]+2.f*f[ 6];
        sumY[threadIdx.x]+=-2.f*f[ 7]+2.f*f[11]-2.f*f[13]+2.f*f[16]-2.f*f[18];
        sumZ[threadIdx.x]=2.f*f[ 9]+2.f*f[10]+2.f*f[11]+2.f*f[12]+2.f*f[13];
        sumZ[threadIdx.x]+=-2.f*f[14]-2.f*f[15]-2.f*f[16]-2.f*f[17]-2.f*f[18];
        }
        else{
        sumX[threadIdx.x]=0.f;
        sumY[threadIdx.x]=0.f;
        sumZ[threadIdx.x]=0.f;
        }
        fB[f_mem(1 ,x,y,z,pitch,zInner)] = f[ 3] ;
        fB[f_mem(2 ,x,y,z,pitch,zInner)] = f[ 4] ;
        fB[f_mem(3 ,x,y,z,pitch,zInner)] = f[ 1] ;
        fB[f_mem(4 ,x,y,z,pitch,zInner)] = f[ 2] ;
        fB[f_mem(5 ,x,y,z,pitch,zInner)] = f[ 7] ;
        fB[f_mem(6 ,x,y,z,pitch,zInner)] = f[ 8] ;
        fB[f_mem(7 ,x,y,z,pitch,zInner)] = f[ 5] ;
        fB[f_mem(8 ,x,y,z,pitch,zInner)] = f[ 6] ;
        fB[f_mem(9 ,x,y,z,pitch,zInner)] = f[14];
        fB[f_mem(10,x,y,z,pitch,zInner)] = f[17];
        fB[f_mem(11,x,y,z,pitch,zInner)] = f[18];
        fB[f_mem(12,x,y,z,pitch,zInner)] = f[15];
        fB[f_mem(13,x,y,z,pitch,zInner)] = f[16];
        fB[f_mem(14,x,y,z,pitch,zInner)] = f[ 9] ;
        fB[f_mem(15,x,y,z,pitch,zInner)] = f[12];
        fB[f_mem(16,x,y,z,pitch,zInner)] = f[13];
        fB[f_mem(17,x,y,z,pitch,zInner)] = f[10];
        fB[f_mem(18,x,y,z,pitch,zInner)] = f[11];
    }
    else{
        sumX[threadIdx.x]=0.f;
        sumY[threadIdx.x]=0.f;
        sumZ[threadIdx.x]=0.f;
        if(im == 100)//north outlet
        {
            for(int i = 0; i<19; i++)
                   f[i ]= fA[f_mem(i ,x,y-1,z,pitch,zInner)];
            North_Extrap(f,1.0f);
        }
        if(im == 200)//south inlet
        {
            for(int i = 0; i<19; i++)
                   f[i ]= fA[f_mem(i ,x,y+1,z,pitch,zInner)];
            South_Extrap(f,UMAX);
        }
        if(im == 25)
            xsymmetry_top(f,y,GPU*(zInner+2)+1+z);
        if(im == 26)
            xsymmetry_bot(f,y,GPU*(zInner+2)+1+z);

        mrt_collide(f,omega);

        if(VELAV == 1){
            if(t>=START_VELAV && t<START_VELFLUC){
                float u_Av = velAv[0][x+y*pitch+(z+1)*pitch*YDIM];
                float v_Av = velAv[1][x+y*pitch+(z+1)*pitch*YDIM];
                vel_av(f,u_Av,v_Av,t);
                velAv[0][x+y*pitch+(z+1)*pitch*YDIM] = u_Av;
                velAv[1][x+y*pitch+(z+1)*pitch*YDIM] = v_Av;
            }
            else if(t>=START_VELFLUC){
                float u_Av = velAv[0][x+y*pitch+(z+1)*pitch*YDIM];
                float v_Av = velAv[1][x+y*pitch+(z+1)*pitch*YDIM];
                float u_fluc = velFluc[0][x+y*pitch+(z+1)*pitch*YDIM];
                float v_fluc = velFluc[1][x+y*pitch+(z+1)*pitch*YDIM];
                vel_fluc(f,u_Av,v_Av,u_fluc,v_fluc,t);
                velFluc[0][x+y*pitch+(z+1)*pitch*YDIM] = u_fluc;
                velFluc[1][x+y*pitch+(z+1)*pitch*YDIM] = v_fluc;
            }
        }

        for(int i = 0; i<19; i++)
            fB[f_mem(i ,x,y,z,pitch,zInner)] = f[ i] ;
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
        atomicAdd(&FX[t-STARTF],sumX[0]);
        atomicAdd(&FY[t-STARTF],sumY[0]);
        atomicAdd(&FZ[t-STARTF],sumZ[0]);
    }
    }

}

__global__ void update_top_LR(float* hB, float* hA, float* fA, float* temp,
                            float omega, size_t pitch, int GPU, int zInner, float* FX, float* FY, float* FZ, int t, int flag_F)
{
    int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
    int y = threadIdx.y+blockIdx.y*blockDim.y;
    int z = (GPU+1)*(zInner+2)-1;//physical coord in LR region
    int j = x+y*pitch;//index on padded mem (pitch in elements)
    float xcoord = LRX0+x*LRFACTOR;
	float ycoord = LRY0+y*LRFACTOR;
	float zcoord = LRZ0+LRFACTOR*z;
	int im = ImageFcn(xcoord,ycoord,zcoord);
    float f[19];
    __shared__ float sumX[BLOCKSIZEX], sumY[BLOCKSIZEX], sumZ[BLOCKSIZEX];
    __shared__ int check[1];
    check[0] = 0;
    syncthreads();

    f[0 ]= hA  [j];
    f[1 ]= hA  [buff_memLR(1 ,x-1,y  ,pitch)];
    f[3 ]= hA  [buff_memLR(3 ,x+1,y  ,pitch)];
    f[2 ]= hA  [buff_memLR(2 ,x  ,y-1,pitch)];
    f[5 ]= hA  [buff_memLR(5 ,x-1,y-1,pitch)];
    f[6 ]= hA  [buff_memLR(6 ,x+1,y-1,pitch)];
    f[4 ]= hA  [buff_memLR(4 ,x  ,y+1,pitch)];
    f[7 ]= hA  [buff_memLR(7 ,x+1,y+1,pitch)];
    f[8 ]= hA  [buff_memLR(8 ,x-1,y+1,pitch)];
    f[9 ]= fA  [   f_memLR(9 ,x  ,y  ,zInner-1,pitch, zInner)];
    f[10]= fA  [   f_memLR(10,x-1,y  ,zInner-1,pitch, zInner)];
    f[11]= fA  [   f_memLR(11,x  ,y-1,zInner-1,pitch, zInner)];
    f[12]= fA  [   f_memLR(12,x+1,y  ,zInner-1,pitch, zInner)];
    f[13]= fA  [   f_memLR(13,x  ,y+1,zInner-1,pitch, zInner)];
    f[14]= temp[buff_memLR(14,x  ,y  ,pitch)];
    f[15]= temp[buff_memLR(15,x-1,y  ,pitch)];
    f[16]= temp[buff_memLR(16,x  ,y-1,pitch)];
    f[17]= temp[buff_memLR(17,x+1,y  ,pitch)];
    f[18]= temp[buff_memLR(18,x  ,y+1,pitch)];

    if(im == 1 || im ==10){//BB
        if(im == 10 && flag_F == 1){
        check[0] = 1;
        sumX[threadIdx.x]=2.f*f[ 1]-2.f*f[ 3]+2.f*f[ 5]+2.f*f[ 8]-2.f*f[ 6];
        sumX[threadIdx.x]+=-2.f*f[ 7]+2.f*f[10]-2.f*f[12]+2.f*f[15]-2.f*f[17];
        sumY[threadIdx.x]=2.f*f[ 2]-2.f*f[ 4]+2.f*f[ 5]-2.f*f[ 8]+2.f*f[ 6];
        sumY[threadIdx.x]+=-2.f*f[ 7]+2.f*f[11]-2.f*f[13]+2.f*f[16]-2.f*f[18];
        sumZ[threadIdx.x]=2.f*f[ 9]+2.f*f[10]+2.f*f[11]+2.f*f[12]+2.f*f[13];
        sumZ[threadIdx.x]+=-2.f*f[14]-2.f*f[15]-2.f*f[16]-2.f*f[17]-2.f*f[18];
        }
        else{
        sumX[threadIdx.x]=0.f;
        sumY[threadIdx.x]=0.f;
        sumZ[threadIdx.x]=0.f;
        }
        hB[buff_memLR(0 ,x,y,pitch)] = f[0 ];
        hB[buff_memLR(1 ,x,y,pitch)] = f[3 ];
        hB[buff_memLR(2 ,x,y,pitch)] = f[4 ];
        hB[buff_memLR(3 ,x,y,pitch)] = f[1 ];
        hB[buff_memLR(4 ,x,y,pitch)] = f[2 ];
        hB[buff_memLR(5 ,x,y,pitch)] = f[7 ];
        hB[buff_memLR(6 ,x,y,pitch)] = f[8 ];
        hB[buff_memLR(7 ,x,y,pitch)] = f[5 ];
        hB[buff_memLR(8 ,x,y,pitch)] = f[6 ];
        hB[buff_memLR(9 ,x,y,pitch)] = f[14];
        hB[buff_memLR(10,x,y,pitch)] = f[17];
        hB[buff_memLR(11,x,y,pitch)] = f[18];
        hB[buff_memLR(12,x,y,pitch)] = f[15];
        hB[buff_memLR(13,x,y,pitch)] = f[16];
        hB[buff_memLR(14,x,y,pitch)] = f[9 ];
        hB[buff_memLR(15,x,y,pitch)] = f[12];
        hB[buff_memLR(16,x,y,pitch)] = f[13];
        hB[buff_memLR(17,x,y,pitch)] = f[10];
        hB[buff_memLR(18,x,y,pitch)] = f[11];
    }
    else{
        sumX[threadIdx.x]=0.f;
        sumY[threadIdx.x]=0.f;
        sumZ[threadIdx.x]=0.f;

        mrt_collide(f,omega);

        for(int i = 0; i<19; i++)
            hB[buff_memLR(i ,x,y,pitch)] = f[i ];
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
        atomicAdd(&FX[t-STARTF],sumX[0]);
        atomicAdd(&FY[t-STARTF],sumY[0]);
        atomicAdd(&FZ[t-STARTF],sumZ[0]);
    }
    }

}

__global__ void update_bot_LR(float* gB, float* gA, float* fA, float* temp,
                            float omega, size_t pitch, int GPU, int zInner, float* FX, float* FY, float* FZ, int t, int flag_F)
{
    int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
    int y = threadIdx.y+blockIdx.y*blockDim.y;
    int z = (zInner+2)-1;
    int j = x+y*pitch;//index on padded mem (pitch in elements)
    float xcoord = LRX0+x*LRFACTOR;
	float ycoord = LRY0+y*LRFACTOR;
	float zcoord = LRZ0+GPU*LRFACTOR*z;
	int im = ImageFcn(xcoord,ycoord,zcoord);
    float f[19];
    __shared__ float sumX[BLOCKSIZEX], sumY[BLOCKSIZEX], sumZ[BLOCKSIZEX];
    __shared__ int check[1];
    check[0] = 0;
    syncthreads();

    f[0 ]= gA  [j];
    f[1 ]= gA  [buff_memLR(1 ,x-1,y  ,pitch)];
    f[3 ]= gA  [buff_memLR(3 ,x+1,y  ,pitch)];
    f[2 ]= gA  [buff_memLR(2 ,x  ,y-1,pitch)];
    f[5 ]= gA  [buff_memLR(5 ,x-1,y-1,pitch)];
    f[6 ]= gA  [buff_memLR(6 ,x+1,y-1,pitch)];
    f[4 ]= gA  [buff_memLR(4 ,x  ,y+1,pitch)];
    f[7 ]= gA  [buff_memLR(7 ,x+1,y+1,pitch)];
    f[8 ]= gA  [buff_memLR(8 ,x-1,y+1,pitch)];
    f[9 ]= temp[buff_memLR(9 ,x  ,y  ,pitch)];
    f[10]= temp[buff_memLR(10,x-1,y  ,pitch)];
    f[11]= temp[buff_memLR(11,x  ,y-1,pitch)];
    f[12]= temp[buff_memLR(12,x+1,y  ,pitch)];
    f[13]= temp[buff_memLR(13,x  ,y+1,pitch)];
    f[14]= fA  [   f_memLR(14,x  ,y  ,0,pitch, zInner)];
    f[15]= fA  [   f_memLR(15,x-1,y  ,0,pitch, zInner)];
    f[16]= fA  [   f_memLR(16,x  ,y-1,0,pitch, zInner)];
    f[17]= fA  [   f_memLR(17,x+1,y  ,0,pitch, zInner)];
    f[18]= fA  [   f_memLR(18,x  ,y+1,0,pitch, zInner)];

    if(im == 1 || im ==10){//BB
        if(im == 10 && flag_F == 1){
        check[0] = 1;
        sumX[threadIdx.x]=2.f*f[ 1]-2.f*f[ 3]+2.f*f[ 5]+2.f*f[ 8]-2.f*f[ 6];
        sumX[threadIdx.x]+=-2.f*f[ 7]+2.f*f[10]-2.f*f[12]+2.f*f[15]-2.f*f[17];
        sumY[threadIdx.x]=2.f*f[ 2]-2.f*f[ 4]+2.f*f[ 5]-2.f*f[ 8]+2.f*f[ 6];
        sumY[threadIdx.x]+=-2.f*f[ 7]+2.f*f[11]-2.f*f[13]+2.f*f[16]-2.f*f[18];
        sumZ[threadIdx.x]=2.f*f[ 9]+2.f*f[10]+2.f*f[11]+2.f*f[12]+2.f*f[13];
        sumZ[threadIdx.x]+=-2.f*f[14]-2.f*f[15]-2.f*f[16]-2.f*f[17]-2.f*f[18];
        }
        else{
        sumX[threadIdx.x]=0.f;
        sumY[threadIdx.x]=0.f;
        sumZ[threadIdx.x]=0.f;
        }
        gB[buff_memLR(0 ,x,y,pitch)] = f[0 ];
        gB[buff_memLR(1 ,x,y,pitch)] = f[3 ];
        gB[buff_memLR(2 ,x,y,pitch)] = f[4 ];
        gB[buff_memLR(3 ,x,y,pitch)] = f[1 ];
        gB[buff_memLR(4 ,x,y,pitch)] = f[2 ];
        gB[buff_memLR(5 ,x,y,pitch)] = f[7 ];
        gB[buff_memLR(6 ,x,y,pitch)] = f[8 ];
        gB[buff_memLR(7 ,x,y,pitch)] = f[5 ];
        gB[buff_memLR(8 ,x,y,pitch)] = f[6 ];
        gB[buff_memLR(9 ,x,y,pitch)] = f[14];
        gB[buff_memLR(10,x,y,pitch)] = f[17];
        gB[buff_memLR(11,x,y,pitch)] = f[18];
        gB[buff_memLR(12,x,y,pitch)] = f[15];
        gB[buff_memLR(13,x,y,pitch)] = f[16];
        gB[buff_memLR(14,x,y,pitch)] = f[9 ];
        gB[buff_memLR(15,x,y,pitch)] = f[12];
        gB[buff_memLR(16,x,y,pitch)] = f[13];
        gB[buff_memLR(17,x,y,pitch)] = f[10];
        gB[buff_memLR(18,x,y,pitch)] = f[11];
    }
    else{
        sumX[threadIdx.x]=0.f;
        sumY[threadIdx.x]=0.f;
        sumZ[threadIdx.x]=0.f;

        mrt_collide(f,omega);

        for(int i = 0; i<19; i++)
            gB[buff_memLR(i ,x,y,pitch)] = f[i ];
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
        atomicAdd(&FX[t-STARTF],sumX[0]);
        atomicAdd(&FY[t-STARTF],sumY[0]);
        atomicAdd(&FZ[t-STARTF],sumZ[0]);
    }
    }
}

__global__ void update_inn_LR(float* fB, float* fA, float* g, float* h, float omega, size_t pitch, int GPU, int zInner, float** velAv, float** velFluc, float* FX, float* FY, float* FZ, int t, int flag_F)
{
    int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
    int y = threadIdx.y+blockIdx.y*blockDim.y;
    int z = threadIdx.z+blockIdx.z*blockDim.z;
	int j = x+y*pitch+z*YLRDIM*pitch;//index on padded mem (pitch in elements)
	int im = ImageFcn(LRX0+LRFACTOR*x,LRY0+LRFACTOR*y,LRZ0+LRFACTOR*(GPU*(zInner+2)+1+z));
    float f[19];
    __shared__ float sumX[BLOCKSIZEX], sumY[BLOCKSIZEX], sumZ[BLOCKSIZEX];
    __shared__ int check[1];
    check[0] = 0;
    syncthreads();

    f[ 0] = fA[j];
    f[ 1] = fA[f_memLR   (1 ,x-1,y  ,z  ,pitch, zInner)];
    f[ 3] = fA[f_memLR   (3 ,x+1,y  ,z  ,pitch, zInner)];
    f[ 2] = fA[f_memLR   (2 ,x  ,y-1,z  ,pitch, zInner)];
    f[ 5] = fA[f_memLR   (5 ,x-1,y-1,z  ,pitch, zInner)];
    f[ 6] = fA[f_memLR   (6 ,x+1,y-1,z  ,pitch, zInner)];
    f[ 4] = fA[f_memLR   (4 ,x  ,y+1,z  ,pitch, zInner)];
    f[ 7] = fA[f_memLR   (7 ,x+1,y+1,z  ,pitch, zInner)];
    f[ 8] = fA[f_memLR   (8 ,x-1,y+1,z  ,pitch, zInner)];

    if(z==zInner-1){//top nodes need info from h
    f[ 9] =fA[   f_memLR(9 ,x  ,y  ,z-1,pitch, zInner)];
    f[10]= fA[   f_memLR(10,x-1,y  ,z-1,pitch, zInner)];
    f[11]= fA[   f_memLR(11,x  ,y-1,z-1,pitch, zInner)];
    f[12]= fA[   f_memLR(12,x+1,y  ,z-1,pitch, zInner)];
    f[13]= fA[   f_memLR(13,x  ,y+1,z-1,pitch, zInner)];
    f[14]= h [buff_memLR(14,x  ,y  ,pitch)];
    f[15]= h [buff_memLR(15,x-1,y  ,pitch)];
    f[16]= h [buff_memLR(16,x  ,y-1,pitch)];
    f[17]= h [buff_memLR(17,x+1,y  ,pitch)];
    f[18]= h [buff_memLR(18,x  ,y+1,pitch)];
    }
    else if(z==0){//bottom nodes need info from g
    f[ 9] =g [buff_memLR(9 ,x  ,y  ,pitch)];
    f[10]= g [buff_memLR(10,x-1,y  ,pitch)];
    f[11]= g [buff_memLR(11,x  ,y-1,pitch)];
    f[12]= g [buff_memLR(12,x+1,y  ,pitch)];
    f[13]= g [buff_memLR(13,x  ,y+1,pitch)];
    f[14]= fA[   f_memLR(14,x  ,y  ,z+1,pitch, zInner)];
    f[15]= fA[   f_memLR(15,x-1,y  ,z+1,pitch, zInner)];
    f[16]= fA[   f_memLR(16,x  ,y-1,z+1,pitch, zInner)];
    f[17]= fA[   f_memLR(17,x+1,y  ,z+1,pitch, zInner)];
    f[18]= fA[   f_memLR(18,x  ,y+1,z+1,pitch, zInner)];
    }
    else{//normal nodes
    f[ 9] =fA[f_memLR(9 ,x  ,y  ,z-1,pitch,zInner)];
    f[10]= fA[f_memLR(10,x-1,y  ,z-1,pitch,zInner)];
    f[11]= fA[f_memLR(11,x  ,y-1,z-1,pitch,zInner)];
    f[12]= fA[f_memLR(12,x+1,y  ,z-1,pitch,zInner)];
    f[13]= fA[f_memLR(13,x  ,y+1,z-1,pitch,zInner)];
    f[14]= fA[f_memLR(14,x  ,y  ,z+1,pitch,zInner)];
    f[15]= fA[f_memLR(15,x-1,y  ,z+1,pitch,zInner)];
    f[16]= fA[f_memLR(16,x  ,y-1,z+1,pitch,zInner)];
    f[17]= fA[f_memLR(17,x+1,y  ,z+1,pitch,zInner)];
    f[18]= fA[f_memLR(18,x  ,y+1,z+1,pitch,zInner)];

    }//end normal nodes

    if(im == 1 || im ==10){//BB
        if(im == 10 && flag_F == 1){
        check[0] = 1;
        sumX[threadIdx.x]=2.f*f[ 1]-2.f*f[ 3]+2.f*f[ 5]+2.f*f[ 8]-2.f*f[ 6];
        sumX[threadIdx.x]+=-2.f*f[ 7]+2.f*f[10]-2.f*f[12]+2.f*f[15]-2.f*f[17];
        sumY[threadIdx.x]=2.f*f[ 2]-2.f*f[ 4]+2.f*f[ 5]-2.f*f[ 8]+2.f*f[ 6];
        sumY[threadIdx.x]+=-2.f*f[ 7]+2.f*f[11]-2.f*f[13]+2.f*f[16]-2.f*f[18];
        sumZ[threadIdx.x]=2.f*f[ 9]+2.f*f[10]+2.f*f[11]+2.f*f[12]+2.f*f[13];
        sumZ[threadIdx.x]+=-2.f*f[14]-2.f*f[15]-2.f*f[16]-2.f*f[17]-2.f*f[18];
        }
        else{
        sumX[threadIdx.x]=0.f;
        sumY[threadIdx.x]=0.f;
        sumZ[threadIdx.x]=0.f;
        }
        fB[f_memLR(1 ,x,y,z,pitch,zInner)] = f[ 3] ;
        fB[f_memLR(2 ,x,y,z,pitch,zInner)] = f[ 4] ;
        fB[f_memLR(3 ,x,y,z,pitch,zInner)] = f[ 1] ;
        fB[f_memLR(4 ,x,y,z,pitch,zInner)] = f[ 2] ;
        fB[f_memLR(5 ,x,y,z,pitch,zInner)] = f[ 7] ;
        fB[f_memLR(6 ,x,y,z,pitch,zInner)] = f[ 8] ;
        fB[f_memLR(7 ,x,y,z,pitch,zInner)] = f[ 5] ;
        fB[f_memLR(8 ,x,y,z,pitch,zInner)] = f[ 6] ;
        fB[f_memLR(9 ,x,y,z,pitch,zInner)] = f[14];
        fB[f_memLR(10,x,y,z,pitch,zInner)] = f[17];
        fB[f_memLR(11,x,y,z,pitch,zInner)] = f[18];
        fB[f_memLR(12,x,y,z,pitch,zInner)] = f[15];
        fB[f_memLR(13,x,y,z,pitch,zInner)] = f[16];
        fB[f_memLR(14,x,y,z,pitch,zInner)] = f[ 9] ;
        fB[f_memLR(15,x,y,z,pitch,zInner)] = f[12];
        fB[f_memLR(16,x,y,z,pitch,zInner)] = f[13];
        fB[f_memLR(17,x,y,z,pitch,zInner)] = f[10];
        fB[f_memLR(18,x,y,z,pitch,zInner)] = f[11];
    }
    else{
        sumX[threadIdx.x]=0.f;
        sumY[threadIdx.x]=0.f;
        sumZ[threadIdx.x]=0.f;

        mrt_collide(f,omega);

        if(VELAV == 1){
            if(t>=START_VELAV && t<START_VELFLUC){
                float u_Av = velAv[0][x+y*pitch+(z+1)*pitch*YLRDIM];
                float v_Av = velAv[1][x+y*pitch+(z+1)*pitch*YLRDIM];
                vel_avLR(f,u_Av,v_Av,t);
                velAv[0][x+y*pitch+(z+1)*pitch*YLRDIM] = u_Av;
                velAv[1][x+y*pitch+(z+1)*pitch*YLRDIM] = v_Av;
            }
            else if(t>=START_VELFLUC){
                float u_Av = velAv[0][x+y*pitch+(z+1)*pitch*YLRDIM];
                float v_Av = velAv[1][x+y*pitch+(z+1)*pitch*YLRDIM];
                float u_fluc = velFluc[0][x+y*pitch+(z+1)*pitch*YLRDIM];
                float v_fluc = velFluc[1][x+y*pitch+(z+1)*pitch*YLRDIM];
                vel_flucLR(f,u_Av,v_Av,u_fluc,v_fluc,t);
                velFluc[0][x+y*pitch+(z+1)*pitch*YLRDIM] = u_fluc;
                velFluc[1][x+y*pitch+(z+1)*pitch*YLRDIM] = v_fluc;
            }
        }

        for(int i = 0; i<19; i++)
            fB[f_memLR(i ,x,y,z,pitch,zInner)] = f[ i] ;
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
        atomicAdd(&FX[t-STARTF],sumX[0]);
        atomicAdd(&FY[t-STARTF],sumY[0]);
        atomicAdd(&FZ[t-STARTF],sumZ[0]);
    }
    }

}



void WriteResults(ostream &output, float *fin, float *gin, float *hin, float **velAv,  
                  float **velFluc, float omega, int GPU_N, int GPU)
{
    float f[19];
    output<<"VARIABLES = \"X\",\"Y\",\"Z\",\"u\",\"v\",\"w\",\"rho\",\"velAv[0]\",\"velAv[1]\",\"ufluc\",\"vfluc\"\n";
    output<<"ZONE F=POINT, I="<<XDIM<<", J="<<YDIM<<", K="<<ZDIM/GPU_N<<"\n";

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
              <<velAv[0][i+j*XDIM]<<","<<velAv[1][i+j*XDIM]<<", "<<velFluc[0][i+j*XDIM]<<","<<velFluc[1][i+j*XDIM]<<endl;
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
              <<velAv[0][i+j*XDIM+k*XDIM*YDIM]<<","<<velAv[1][i+j*XDIM+k*XDIM*YDIM]<<", "
              <<velFluc[0][i+j*XDIM+k*XDIM*YDIM]<<","<<velFluc[1][i+j*XDIM+k*XDIM*YDIM]<<endl;
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
              <<velAv[0][i+j*XDIM+(ZDIM-1)*XDIM*YDIM]<<","<<velAv[1][i+j*XDIM+(ZDIM/GPU_N-1)*XDIM*YDIM]<<", "
              <<velFluc[0][i+j*XDIM+(ZDIM-1)*XDIM*YDIM]<<","<<velFluc[1][i+j*XDIM+(ZDIM/GPU_N-1)*XDIM*YDIM]<<endl;
    }}
}

void WriteResultsLR(ofstream &output, float *fin, float *gin, float *hin, float **velAv,  
                  float **velFluc, float omega, int GPU_N, int GPU)
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
              <<velAv[0][i+j*XLRDIM]<<","<<velAv[1][i+j*XLRDIM]<<", "<<velFluc[0][i+j*XLRDIM]<<","<<velFluc[1][i+j*XLRDIM]<<endl;
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
              <<velAv  [0][i+j*XLRDIM+k*XLRDIM*YLRDIM]<<","<<velAv  [1][i+j*XLRDIM+k*XLRDIM*YLRDIM]<<", "
              <<velFluc[0][i+j*XLRDIM+k*XLRDIM*YLRDIM]<<","<<velFluc[1][i+j*XLRDIM+k*XLRDIM*YLRDIM]<<endl;
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
              <<velAv[0][i+j*XLRDIM+(ZLRDIM/GPU_N-1)*XLRDIM*YLRDIM]<<","<<velAv[1][i+j*XLRDIM+(ZLRDIM/GPU_N-1)*XLRDIM*YLRDIM]<<", "
              <<velFluc[0][i+j*XLRDIM+(ZLRDIM/GPU_N-1)*XLRDIM*YLRDIM]<<","<<velFluc[1][i+j*XLRDIM+(ZLRDIM/GPU_N-1)*XLRDIM*YLRDIM]<<endl;
    }}
}



void WriteForces(float **F, ofstream &output, int ForceTime, int level)
{
    float ref = UMAX*UMAX*ZDIM*OBSTR1;
    if(level > 0)
    ref *= LRLEVEL*LRLEVEL;
    for(int i = 0; i<ForceTime; i++){
        output<<i+STARTF<<", "<<F[0][i]/ref<<", "<<F[1][i]/ref<<", "<<F[2][i]/ref<<endl;
    }
}




void WriteInputs(ostream &output, float omega, float omegaLR, int GPU_per_node)
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
}





int main(int argc, char *argv[])
{
    
    int GPU_N; cudaGetDeviceCount(&GPU_N);
    cout<<"number of GPUs: "<<GPU_N<<endl;

    ofstream output; ofstream outputForce; ofstream outputInputs;
    string FileName = CASENAME;
    output.open ((FileName+".dat").c_str());
    outputForce.open ((FileName+".force").c_str());
    outputInputs.open ((FileName+".inputs").c_str());

    //size_t memsize, memsize2;
    size_t pitch = 2;
    while(pitch<XDIM)
        pitch=pitch*2;
    pitch *= sizeof(float);//pitch*sizeof(float);
    size_t pitch_e = pitch/sizeof(float);
    cout<<"Pitch (in elements): "<<pitch/sizeof(float)<<endl;

    float CharLength = OBSTR1*2.f;

    float omega = 1.0f/(3.0f*(UMAX*CharLength/RE)+0.5f);
    float omegaLR = 2.0f/(1.0f+2.0f*(2.0f/omega-1.0f));
    if(LRFACTOR == 0.25f){
    omegaLR = 2.0f/(1.0f+2.0f*(2.0f/omegaLR-1.0f));
    }
    float SF_cf = omega*(1.0f-omegaLR)/((1.0f-omega)*omegaLR/LRFACTOR);
    float SF_fc = 1.f/SF_cf;

    WriteInputs(outputInputs,omega,omegaLR,GPU_N);
    WriteInputs(cout,omega,omegaLR,GPU_N);

    if(abs(LRFACTOR-1.f/LRLEVEL)>0.001f && REFINEMENT == 1){
        cout<<"LRLEVEL and LRFACTOR don't match! Exiting..."<<endl;
        return 0;
    }

    int zInner = ZDIM/GPU_N-2; //excluding halo
    int ForceTime = max(0,TMAX-STARTF);

    dim3 threads(BLOCKSIZEX, BLOCKSIZEY, BLOCKSIZEZ);
    //2 halo layers per GPU (for 2 GPUs)
    dim3 grid  (((XDIM+BLOCKSIZEX-1)/BLOCKSIZEX),((YDIM+BLOCKSIZEY-1)/BLOCKSIZEY),(zInner)/BLOCKSIZEZ);
    dim3 g_grid(((XDIM+BLOCKSIZEX-1)/BLOCKSIZEX),((YDIM+BLOCKSIZEY-1)/BLOCKSIZEY),1);

    cudaStream_t stream_halo[GPU_N];
    cudaStream_t stream_inner[GPU_N];

    //data pointers as 3D array (GPUxCoord)
    float   *f_h[GPU_N],   *g_h[GPU_N],   *h_h[GPU_N];
    float *f_d[GPU_N][2], *g_d[GPU_N][2], *h_d[GPU_N][2];
    float *g_temp[GPU_N], *h_temp[GPU_N];
    float *F_h[GPU_N][3];
    float *F_d[GPU_N][3];
    float *F_total[3];
    float *velAv_h[GPU_N][3],*velFluc_h[GPU_N][3];
    float *velAv_d[GPU_N][3],*velFluc_d[GPU_N][3];

    for(int i = 0; i<3; i++)
    F_total[i] = (float *)malloc(ForceTime*sizeof(float));
    
    for(int i=0;i<3;i++)
    for(int j=0;j<(ForceTime);j++)
        F_total[i][j] = 0;

    //Malloc and Initialize for each GPU
    for(int n = 0; n<GPU_N; n++){
        f_h    [n] = (float *)malloc(XDIM*YDIM*zInner*19*sizeof(float));
        g_h    [n] = (float *)malloc(XDIM*YDIM*       19*sizeof(float));
        h_h    [n] = (float *)malloc(XDIM*YDIM*       19*sizeof(float));
        for(int i = 0; i<3; i++){
        F_h      [n][i] = (float *)malloc(ForceTime*sizeof(float));
        velAv_h  [n][i] = (float *)malloc(XDIM*YDIM*ZDIM/GPU_N*sizeof(float));
        velFluc_h[n][i] = (float *)malloc(XDIM*YDIM*ZDIM/GPU_N*sizeof(float));
        }
        cudaSetDevice(n);
        cudaStreamCreate(&stream_halo[n]);
        cudaStreamCreate(&stream_inner[n]);
        for(int m = 0; m<GPU_N; m++)
            if(m != n) cudaDeviceEnablePeerAccess(m,0);

        for(int i = 0; i<2; i++){
           cudaMalloc((void **) &f_d[n][i], pitch_e*YDIM*zInner*19*sizeof(float));
        cudaMalloc((void **) &g_d[n][i], pitch_e*YDIM*       19*sizeof(float));
        cudaMalloc((void **) &h_d[n][i], pitch_e*YDIM*       19*sizeof(float));
        }
        cudaMalloc((void **) & g_temp[n], pitch_e*YDIM*       19*sizeof(float));
        cudaMalloc((void **) & h_temp[n], pitch_e*YDIM*       19*sizeof(float));
        for(int i = 0; i<3; i++){
        cudaMalloc((void **) & F_d      [n][i], (ForceTime)*sizeof(float));
        cudaMalloc((void **) & velAv_d  [n][i], pitch_e*YDIM*ZDIM/GPU_N*sizeof(float));
        cudaMalloc((void **) & velFluc_d[n][i], pitch_e*YDIM*ZDIM/GPU_N*sizeof(float));
        }

        //initialize host f_inner
        for (int i = 0; i < XDIM*YDIM*zInner*19; i++)
            f_h[n][i] = 0;
        //initialize host g,h
        for (int i = 0; i < XDIM*YDIM*19; i++){
            g_h[n][i] = 0;
            h_h[n][i] = 0;
        }
        for(int i=0;i<3;i++){
            for(int j=0;j<(ForceTime);j++)
                F_h[n][i][j] = 0;
            for (int j = 0; j < XDIM*YDIM*ZDIM/GPU_N; j++){
            velAv_h  [n][i][j] = 0;
            velFluc_h[n][i][j] = 0;
            }
        }
        for(int i = 0; i<2; i++){
        cudaMemcpy2D(f_d[n][i],pitch,f_h[n],XDIM*sizeof(float),XDIM*sizeof(float),YDIM*zInner*19,cudaMemcpyHostToDevice);
        cudaMemcpy2D(g_d[n][i],pitch,g_h[n],XDIM*sizeof(float),XDIM*sizeof(float),YDIM       *19,cudaMemcpyHostToDevice);
        cudaMemcpy2D(h_d[n][i],pitch,h_h[n],XDIM*sizeof(float),XDIM*sizeof(float),YDIM       *19,cudaMemcpyHostToDevice);
        }

        for(int i = 0; i<3; i++){
        cudaMemcpy2D(velAv_d  [n][i],pitch,velAv_h  [n][i],XDIM*sizeof(float),XDIM*sizeof(float),YDIM*ZDIM/GPU_N,cudaMemcpyHostToDevice);
        cudaMemcpy2D(velFluc_d[n][i],pitch,velFluc_h[n][i],XDIM*sizeof(float),XDIM*sizeof(float),YDIM*ZDIM/GPU_N,cudaMemcpyHostToDevice);
        cudaMemcpy(F_d[n][i],F_h[n][i],sizeof(float)*(ForceTime),cudaMemcpyHostToDevice);
        }

        //initialization kernels
        for(int i = 0; i<2; i++){
        initialize<<<  grid,threads>>>(f_d[n][i],pitch_e,zInner,GPU_N);
        initialize<<<g_grid,threads>>>(g_d[n][i],pitch_e,     1,GPU_N);
        initialize<<<g_grid,threads>>>(h_d[n][i],pitch_e,     1,GPU_N);
        }
        initialize<<<g_grid,threads>>>(g_temp[n],pitch_e,     1,GPU_N);
        initialize<<<g_grid,threads>>>(h_temp[n],pitch_e,     1,GPU_N);

    }//end Malloc and Initialize
    

    //data pointers as 3D array (GPUxCoord)
    float   *f_LR_h[GPU_N],   *g_LR_h[GPU_N],   *h_LR_h[GPU_N];
    float *f_LR_d[GPU_N][2], *g_LR_d[GPU_N][2], *h_LR_d[GPU_N][2];
    float *g_LR_temp[GPU_N], *h_LR_temp[GPU_N];
    float *velAv_LR_h[GPU_N][3],*velFluc_LR_h[GPU_N][3];
    float *velAv_LR_d[GPU_N][3],*velFluc_LR_d[GPU_N][3];

    size_t pitchLR = 2;
    while(pitchLR<XLRDIM)
        pitchLR=pitchLR*2;
    pitchLR = pitchLR*sizeof(float);
    size_t pitchLR_e = pitchLR/sizeof(float);
    cout<<"LR Pitch (in elements): "<<pitchLR_e<<endl;

    int zLRInner = ZLRDIM/GPU_N-2;
    dim3 LR_threads(BLOCKSIZELRX, BLOCKSIZELRY, BLOCKSIZELRZ);
    dim3 LR_grid(((XLRDIM+BLOCKSIZELRX-1)/BLOCKSIZELRX),((YLRDIM+BLOCKSIZELRY-1)/BLOCKSIZELRY),(zLRInner)/BLOCKSIZELRZ);
    dim3 g_LR_grid(((XLRDIM+BLOCKSIZELRX-1)/BLOCKSIZELRX),((YLRDIM+BLOCKSIZELRY-1)/BLOCKSIZELRY),1);    
    
    //setup LR
    if(REFINEMENT == 1){

    for(int n = 0; n<GPU_N; n++){
        f_LR_h    [n] = (float *)malloc(XLRDIM*YLRDIM*zLRInner*19*sizeof(float));
        g_LR_h    [n] = (float *)malloc(XLRDIM*YLRDIM*         19*sizeof(float));
        h_LR_h    [n] = (float *)malloc(XLRDIM*YLRDIM*         19*sizeof(float));
        for(int i = 0; i<3; i++){
        velAv_LR_h  [n][i] = (float *)malloc(XLRDIM*YLRDIM*ZLRDIM/GPU_N*sizeof(float));
        velFluc_LR_h[n][i] = (float *)malloc(XLRDIM*YLRDIM*ZLRDIM/GPU_N*sizeof(float));
        }
        cudaSetDevice(n);
        for(int i = 0; i<2; i++){
        cudaMalloc((void **) &f_LR_d[n][i], pitchLR_e*YLRDIM*zLRInner*19*sizeof(float));
        cudaMalloc((void **) &g_LR_d[n][i], pitchLR_e*YLRDIM*         19*sizeof(float));
        cudaMalloc((void **) &h_LR_d[n][i], pitchLR_e*YLRDIM*         19*sizeof(float));
        }
        cudaMalloc((void **) & g_LR_temp[n], pitchLR_e*YLRDIM*       19*sizeof(float));
        cudaMalloc((void **) & h_LR_temp[n], pitchLR_e*YLRDIM*       19*sizeof(float));
        for(int i = 0; i<3; i++){
        cudaMalloc((void **) & velAv_LR_d  [n][i], pitchLR_e*YLRDIM*ZLRDIM/GPU_N*sizeof(float));
        cudaMalloc((void **) & velFluc_LR_d[n][i], pitchLR_e*YLRDIM*ZLRDIM/GPU_N*sizeof(float));
        }
        for (int i = 0; i < XLRDIM*YLRDIM*zLRInner*19; i++)
            f_LR_h[n][i] = 0;
        //initialize host g,h
        for (int i = 0; i < XLRDIM*YLRDIM*19; i++){
            g_LR_h[n][i] = 0;
            h_LR_h[n][i] = 0;
        }
        for(int i=0;i<3;i++){
            for (int j = 0; j < XLRDIM*YLRDIM*ZLRDIM/GPU_N; j++){
            velAv_LR_h  [n][i][j] = 0;
            velFluc_LR_h[n][i][j] = 0;
            }
        }
        for(int i = 0; i<2; i++){
        cudaMemcpy2D(f_LR_d[n][i],pitchLR,f_LR_h[n],XLRDIM*sizeof(float),XLRDIM*sizeof(float),YLRDIM*zLRInner*19,cudaMemcpyHostToDevice);
        cudaMemcpy2D(g_LR_d[n][i],pitchLR,g_LR_h[n],XLRDIM*sizeof(float),XLRDIM*sizeof(float),YLRDIM         *19,cudaMemcpyHostToDevice);
        cudaMemcpy2D(h_LR_d[n][i],pitchLR,h_LR_h[n],XLRDIM*sizeof(float),XLRDIM*sizeof(float),YLRDIM         *19,cudaMemcpyHostToDevice);
        }
        for(int i = 0; i<3; i++){
        cudaMemcpy2D(velAv_LR_d  [n][i],pitchLR,velAv_LR_h  [n][i],XLRDIM*sizeof(float),XLRDIM*sizeof(float),YLRDIM*ZLRDIM/GPU_N,cudaMemcpyHostToDevice);
        cudaMemcpy2D(velFluc_LR_d[n][i],pitchLR,velFluc_LR_h[n][i],XLRDIM*sizeof(float),XLRDIM*sizeof(float),YLRDIM*ZLRDIM/GPU_N,cudaMemcpyHostToDevice);
        }
        //initialization kernels
        for(int i = 0; i<2; i++){
        initializeLR<<<  LR_grid,LR_threads>>>(f_LR_d[n][i],pitchLR_e,zLRInner,GPU_N);
        initializeLR<<<g_LR_grid,LR_threads>>>(g_LR_d[n][i],pitchLR_e,       1,GPU_N);
        initializeLR<<<g_LR_grid,LR_threads>>>(h_LR_d[n][i],pitchLR_e,       1,GPU_N);
        }
        initializeLR<<<g_LR_grid,LR_threads>>>(g_LR_temp[n],pitchLR_e,       1,GPU_N);
        initializeLR<<<g_LR_grid,LR_threads>>>(h_LR_temp[n],pitchLR_e,       1,GPU_N);



    }//end of GPU loop for malloc and initialize for LR
    }//end of LR malloc and initialize


    int A = 0; int B = 1; int C = 0; int D = 1;
    
    struct timeval tdr0,tdr1;
    double restime;
    cudaDeviceSynchronize();
    gettimeofday (&tdr0,NULL);

    for(int n = 0; n<GPU_N; n++){
    cudaSetDevice(n);
    size_t mem_avail, mem_total;
    cudaMemGetInfo(&mem_avail,&mem_total);
    cout<<"Device memory used for dev"<<n<<" : "<<(mem_total-mem_avail)*pow(10,-9)<<" GB\n";
    cout<<"Device memory available for dev"<<n<<" : "<<(mem_avail)*pow(10,-9)<<" GB\n";
    }
    
    //time loop
    for(int t = 0; t<TMAX; t++)
    {
        for(int n = 0; n<GPU_N; n++)
        {
              cudaSetDevice(n);
            update_top<<<g_grid, threads, 0, stream_halo [n]>>>(h_d[n][B],h_d[n][A],f_d[n][A],h_temp[n],omega,pitch_e,n,zInner,F_d[n][0],F_d[n][1],F_d[n][2],t,!REFINEMENT);
            update_bot<<<g_grid, threads, 0, stream_halo [n]>>>(g_d[n][B],g_d[n][A],f_d[n][A],g_temp[n],omega,pitch_e,n,zInner,F_d[n][0],F_d[n][1],F_d[n][2],t,!REFINEMENT);
        }
        for(int n = 0; n<GPU_N; n++)
        cudaStreamSynchronize(stream_halo[n]);
        for(int n = 0; n<GPU_N; n++){
            cudaSetDevice(n);
            update_inn<<<grid,threads,0,stream_inner[n]>>>(f_d[n][B],f_d[n][A],g_d[n][A], h_d[n][A],omega,pitch_e,n,zInner,velAv_d[n],velFluc_d[n],F_d[n][0],F_d[n][1],F_d[n][2],t,!REFINEMENT);
        }

        for(int n = 0; n<GPU_N; n++)
            cudaMemcpyPeerAsync(&h_temp[n][0],n,&g_d[   (n+1)%GPU_N][B][0],   (n+1)%GPU_N,pitch_e*YDIM*sizeof(float)*19,stream_halo[n]);
        for(int n = 0; n<GPU_N; n++)
            cudaMemcpyPeerAsync(&g_temp[n][0],n,&h_d[abs(n-1)%GPU_N][B][0],abs(n-1)%GPU_N,pitch_e*YDIM*sizeof(float)*19,stream_halo[n]);

        cudaDeviceSynchronize();
        swap(A,B);



        if(REFINEMENT == 1){
        int flag_F = 0;
        if(t>STARTF) flag_F = 1;
        for(int i = 0; i<LRLEVEL; i++){
            for(int n = 0; n<GPU_N; n++){
            cudaSetDevice(n);
            update_top_LR<<<g_LR_grid,LR_threads,0,stream_halo[n]>>>(h_LR_d[n][D],h_LR_d[n][C],f_LR_d[n][C],h_LR_temp[n],omegaLR,pitchLR_e,n,zLRInner,F_d[n][0],F_d[n][1],F_d[n][2],t,flag_F);
            update_bot_LR<<<g_LR_grid,LR_threads,0,stream_halo[n]>>>(g_LR_d[n][D],g_LR_d[n][C],f_LR_d[n][C],g_LR_temp[n],omegaLR,pitchLR_e,n,zLRInner,F_d[n][0],F_d[n][1],F_d[n][2],t,flag_F);
            }
            for(int n = 0; n<GPU_N; n++)
    		cudaStreamSynchronize(stream_halo[n]);
        
            for(int n = 0; n<GPU_N; n++){
    		cudaSetDevice(n);
            update_inn_LR<<<LR_grid,LR_threads,0,stream_inner[n]>>>(f_LR_d[n][D],f_LR_d[n][C],g_LR_d[n][C], h_LR_d[n][C],omegaLR,pitchLR_e,n,zLRInner,velAv_LR_d[n],velFluc_LR_d[n],F_d[n][0],F_d[n][1],F_d[n][2],t,flag_F);
            }

            for(int n = 0; n<GPU_N; n++){
            cudaMemcpyPeerAsync(&h_LR_temp[n][pitchLR_e*YLRDIM*14],n,&g_LR_d[   (n+1)%GPU_N][D][pitchLR_e*YLRDIM*14],   (n+1)%GPU_N,pitchLR_e*YLRDIM*sizeof(float)*5,stream_halo[n]);
            cudaMemcpyPeerAsync(&g_LR_temp[n][pitchLR_e*YLRDIM*9 ],n,&h_LR_d[abs(n-1)%GPU_N][D][pitchLR_e*YLRDIM*9 ],abs(n-1)%GPU_N,pitchLR_e*YLRDIM*sizeof(float)*5,stream_halo[n]);
            }
   
            for(int n = 0; n<GPU_N; n++){
    		cudaSetDevice(n);
    		cudaDeviceSynchronize();
            }
            flag_F = 0;
            swap(C,D);
        }
        }








    }


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
        cudaMemcpy2D(f_h[n],XDIM*sizeof(float),f_d[n][A],pitch,XDIM*sizeof(float),YDIM*zInner*19,cudaMemcpyDeviceToHost);
        cudaMemcpy2D(g_h[n],XDIM*sizeof(float),g_d[n][A],pitch,XDIM*sizeof(float),YDIM       *19,cudaMemcpyDeviceToHost);
        cudaMemcpy2D(h_h[n],XDIM*sizeof(float),h_d[n][A],pitch,XDIM*sizeof(float),YDIM       *19,cudaMemcpyDeviceToHost);
        for(int i = 0; i<3; i++){
        cudaMemcpy2D(  velAv_h[n][i],XDIM*sizeof(float),velAv_d[n][i],pitch,XDIM*sizeof(float),YDIM*ZDIM/GPU_N,cudaMemcpyDeviceToHost);
        cudaMemcpy2D(velFluc_h[n][i],XDIM*sizeof(float),velAv_d[n][i],pitch,XDIM*sizeof(float),YDIM*ZDIM/GPU_N,cudaMemcpyDeviceToHost);
        cudaMemcpy(F_h[n][i],F_d[n][i],sizeof(float)*ForceTime,cudaMemcpyDeviceToHost);
        }
        WriteResults(output,f_h[n],g_h[n],h_h[n],velAv_h[n],velFluc_h[n],omega,GPU_N,n);
        output<<endl;

        for(int i=0;i<3;i++)
        for(int j=0;j<ForceTime;j++)
            F_total[i][j] += F_h[n][i][j];
        
        for(int i = 0; i<2; i++){
            cudaFree(f_d[n][i]);
            cudaFree(g_d[n][i]);
            cudaFree(h_d[n][i]);
        }
        cudaFree(f_d[n]);
        cudaFree(g_d[n]);
        cudaFree(h_d[n]);
        cudaFree(g_temp[n]);
        cudaFree(h_temp[n]);
        for(int i=0;i<3;i++)
            cudaFree(F_d[n][i]);
        cudaFree(F_d[n]);
    }//end Memcpy and write results
    WriteForces(F_total,outputForce,ForceTime,REFINEMENT*LRLEVEL);


    if(REFINEMENT == 1){
    output<<"VARIABLES = \"X\",\"Y\",\"Z\",\"u\",\"v\",\"w\",\"rho\",\"uAv\",\"vAv\",\"ufluc\",\"vfluc\"\n";
    output<<"ZONE F=POINT, I="<<XLRDIM<<", J="<<YLRDIM<<", K="<<ZLRDIM<<"\n";
    for(int n = 0; n<GPU_N; n++){
        cudaSetDevice(n);
        cudaMemcpy2D(f_LR_h[n],XLRDIM*sizeof(float),f_LR_d[n][C],pitchLR,XLRDIM*sizeof(float),YLRDIM*zLRInner*19,cudaMemcpyDeviceToHost);
        cudaMemcpy2D(g_LR_h[n],XLRDIM*sizeof(float),g_LR_d[n][C],pitchLR,XLRDIM*sizeof(float),YLRDIM         *19,cudaMemcpyDeviceToHost);
        cudaMemcpy2D(h_LR_h[n],XLRDIM*sizeof(float),h_LR_d[n][C],pitchLR,XLRDIM*sizeof(float),YLRDIM         *19,cudaMemcpyDeviceToHost);
        for(int i = 0; i<3; i++){
        cudaMemcpy2D(  velAv_LR_h[n][i],XLRDIM*sizeof(float),velAv_LR_d[n][i],pitchLR,XLRDIM*sizeof(float),YLRDIM*ZLRDIM/GPU_N,cudaMemcpyDeviceToHost);
        cudaMemcpy2D(velFluc_LR_h[n][i],XLRDIM*sizeof(float),velAv_LR_d[n][i],pitchLR,XLRDIM*sizeof(float),YLRDIM*ZLRDIM/GPU_N,cudaMemcpyDeviceToHost);
        }
        WriteResultsLR(output,f_LR_h[n],g_LR_h[n],h_LR_h[n],velAv_LR_h[n],velFluc_LR_h[n],omegaLR,GPU_N,n);
        output<<endl;

        for(int i = 0; i<2; i++){
            cudaFree(f_LR_d[n][i]);
            cudaFree(g_LR_d[n][i]);
            cudaFree(h_LR_d[n][i]);
        }
        cudaFree(f_LR_d[n]);
        cudaFree(g_LR_d[n]);
        cudaFree(h_LR_d[n]);
        cudaFree(g_LR_temp[n]);
        cudaFree(h_LR_temp[n]);
    }
    }


    return 0;
}
