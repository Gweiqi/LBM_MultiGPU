#include <cuda.h>
#include <iostream>
#include <ostream>
#include <fstream>
#include <sys/time.h>
#include <time.h>
using namespace std;
	
#define CASENAME "stest2"

#define BLOCKSIZEX 128
#define BLOCKSIZEY 1
#define UBLOCKSIZEX 32
#define UBLOCKSIZEY 10
#define L1BLOCKSIZEX 64
#define L1BLOCKSIZEY 1
#define L1UBLOCKSIZEX 32
#define L1UBLOCKSIZEY 10
#define XDIM 128
#define YDIM 100
#define HALO 3
#define TMAX 1500
#define MAXIT 2000//20000
#define MAXRES 0.0001
#define RE 20
#define UMAX 1.f
#define BETA 0.05f
#define DTAU 0.01f
#define DT 1000000000.f

#define OBSTD 8.f
#define OBSTX 45.f
#define OBSTY 45.f

#define CONV 1  //1:UDS

int L1XDIM;
int L1YDIM;
texture<float,2,cudaReadModeElementType> uA0,uB0,vA0,vB0,pA0,pB0,uA1,uB1,vA1,vB1,pA1,pB1;

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


void AllocateArray(float ****f,int x,int y)
{
    float ***array = new float **[4];
    for(int i = 0;i<4;i++)
    {
        array[i] = new float *[x];
        for(int j = 0;j<x;j++)
        {
            array[i][j] = new float [y];
            for(int k = 0;k<y;k++)
                array[i][j][k] = 0.f;
        }
    }
    *f = array;
}

void DeallocateArray(float ***f,int x)
{
    for(int i = 0;i<4;i++)
    {
    for(int j = 0;j<x;j++)
        delete [] f[i][j];
    delete [] f[i];
    }
    delete [] f;
}

void WriteResults(ostream &output, float *u, float *v, float *p)
{
    output<<"VARIABLES = \"X\",\"Y\",\"u\",\"v\",\"p\"\n";
    output<<"ZONE F=POINT, I="<<XDIM-HALO*2<<", J="<<YDIM-HALO*2<<endl;
    float dx = 1;
    float dy = 1;
    float uval,vval,pval;
    for(int j = HALO; j<YDIM-HALO; j++){
    for(int i = HALO; i<XDIM-HALO; i++)
    {
        float xc = 0.5f*dx+(i)*dx;
        float yc = 0.5f*dy+(j)*dy;
        uval = 0.5f*(u[i+j*XDIM]+u[i-1  +j*XDIM]);
        vval = 0.5f*(v[i+j*XDIM]+v[i+(j-1)*XDIM]);
        pval = p[i+j*XDIM];
        if(xc>OBSTX && xc<OBSTX+OBSTD && yc>OBSTY && yc<OBSTY+OBSTD)
        {
        uval = 0.f; vval = 0.f; pval = 0.f;
        }
        output<<xc<<", "<<yc<<", "<<uval<<", "<<vval<<", "<<pval<<endl;
    }
    }
}

void WriteResultsL1(ostream &output, float *u, float *v, float *p)
{
    output<<"VARIABLES = \"X\",\"Y\",\"u\",\"v\",\"p\"\n";
    output<<"ZONE F=POINT, I="<<L1XDIM-HALO*2<<", J="<<L1YDIM-HALO*2<<endl;
    float dx = 2;
    float dy = 2;
    float uval,vval,pval;
    for(int j = HALO; j<L1YDIM-HALO; j++){
    for(int i = HALO; i<L1XDIM-HALO; i++)
    {
        float xc = 0.5f*dx+0.5f+(i-HALO)*dx+HALO;
        float yc = 0.5f*dy+0.5f+(j-HALO)*dy+HALO;
        uval = 0.5f*(u[i+j*L1XDIM]+u[i-1  +j*L1XDIM]);
        vval = 0.5f*(v[i+j*L1XDIM]+v[i+(j-1)*L1XDIM]);
        pval = p[i+j*L1XDIM];
        int xcoord = (i-HALO)*2.f+HALO;
        int ycoord = (j-HALO)*2.f+HALO;
        if(xc>OBSTX+0.5f*dx && xc<OBSTX+OBSTD+0.5f*dx && yc>OBSTY+0.5f*dx && yc<OBSTY+OBSTD+0.5f*dx)
        {
        uval = 0.f; vval = 0.f; pval = 0.f;
        }
        output<<xc<<", "<<yc<<", "<<uval<<", "<<vval<<", "<<pval<<endl;
    }
    }
}


void WriteResiduals(ostream &output, float *Res)
{
    for(int i = 0; i<TMAX; i++)
        output<<i<<", "<<sqrt(Res[i])/((XDIM-2*HALO)*(YDIM-2*HALO))<<endl;
}

void WriteInputs(ostream &output)
{
    output<<"Domain size: \t"<<XDIM<<"x"<<YDIM<<endl;
    output<<"Halo size: \t"<<HALO<<endl;
    output<<"Target residual: \t"<<MAXRES<<endl;
    output<<"Pseudo time step size: \t"<<DTAU<<endl;
    output<<"Maximum iterations: \t"<<MAXIT<<endl;
    output<<"Real time step size: \t"<<DT<<endl;
    output<<"Maximum time steps: \t"<<TMAX<<endl;
    output<<"Re: \t"<<RE<<endl;
    output<<"uMax: \t"<<UMAX<<endl;
    string scheme;
    if(CONV == 0) scheme = "CDS   ";
    if(CONV == 1) scheme = "UDS   ";
    if(CONV == 2) scheme = "Hybrid";
    if(CONV == 3) scheme = "QUICK ";
    output<<"Convective discretization: \t"<<scheme<<endl;
}

__global__ void ACM_U_Shared(float* uA, float* vA, float* Res, float* uB, float* vB, float* pB, float* uC, float* vC, float* uD, float* vD, float nu, int it, int t, size_t pitch)
{
    int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
    int y = threadIdx.y+blockIdx.y*blockDim.y;
    int tx = threadIdx.x+1;
    int ty = threadIdx.y+1;
    __shared__ float u[UBLOCKSIZEX+2][UBLOCKSIZEY+2];
    __shared__ float v[UBLOCKSIZEX+2][UBLOCKSIZEY+2];


    //if(x > HALO-2 && x < XDIM-HALO && y > HALO-2 && y < YDIM-HALO){
    if(x > 0 && x < XDIM-1 && y > 0 && y < YDIM-1){

    if(threadIdx.x == 0){
    u[0][ty] = uB[ x-1+ y   *pitch];
    v[0][ty] = vB[ x-1+ y   *pitch];
    if(threadIdx.y == blockDim.y-1){
    u[0][ty+1] = uB[ x-1+ (y+1)*pitch];
    }
    }
    if(threadIdx.x == blockDim.x-1){
    u[UBLOCKSIZEX+1][ty] = uB[ x+1+ y   *pitch];
    v[UBLOCKSIZEX+1][ty] = vB[ x+1+ y   *pitch];
    }
    if(threadIdx.y == 0){
    u[tx][0] = uB[ x+  (y-1)*pitch];
    v[tx][0] = vB[ x+  (y-1)*pitch];
    if(threadIdx.x == blockDim.x-1){
    v[tx+1][0] = vB[ x+1+(y-1)*pitch];
    }
    }
    if(threadIdx.y == blockDim.y-1){
    u[tx][UBLOCKSIZEY+1] = uB[ x+ (y+1)*pitch];
    v[tx][UBLOCKSIZEY+1] = vB[ x+ (y+1)*pitch];
    }

    u[tx][ty] = uB[ x+ (y  )*pitch];
    v[tx][ty] = vB[ x+ (y  )*pitch];
    }
    syncthreads();
    //if(x > HALO-2 && x < XDIM-HALO && y > HALO-2 && y < YDIM-HALO){
    if(x > 0 && x < XDIM-1 && y > 0 && y < YDIM-1){
    float Ae,Aw,An,As;
    float AP_Ue,AE_Ue,AW_Ue,AN_Ue,AS_Ue; //A coeff for East node on u of east face
    float AP_Vn,AE_Vn,AW_Vn,AN_Vn,AS_Vn;
    float Fe,Fw,Fn,Fs;
    float De,Dw,Dn,Ds;
    float B_Ue,B_Vn;
    float dx = 1.f/OBSTD;
    float dy = 1.f/OBSTD;
    Ae = dy; Aw = dy; An = dx; As = dx;
    Fe = 0.5f*(u[tx  ][ty  ]+u[tx+1][ty  ])*Ae;
    Fw = 0.5f*(u[tx-1][ty  ]+u[tx  ][ty  ])*Aw;
    Fn = 0.5f*(v[tx  ][ty  ]+v[tx+1][ty  ])*An;
    Fs = 0.5f*(v[tx  ][ty-1]+v[tx+1][ty-1])*As;
    De = nu*Ae/dx; Dw = nu*Aw/dx; Dn = nu*An/dy; Ds = nu*As/dy;
    if(CONV == 1){
    AE_Ue = max(-Fe,0.f)+De;
    AW_Ue = max( Fw,0.f)+Dw;
    AN_Ue = max(-Fn,0.f)+Dn;
    AS_Ue = max( Fs,0.f)+Ds;
    AP_Ue = max( Fe,0.f)+max(-Fw,0.f)+max( Fn,0.f)+max(-Fs,0.f)+Dw+De+Dn+Ds;
    }
    else if(CONV == 2){
    AE_Ue = max(-Fe*0.5f+De,max(-Fe,0.f));
    AW_Ue = max( Fw*0.5f+Dw,max( Fw,0.f));
    AN_Ue = max(-Fn*0.5f+Dn,max(-Fn,0.f));
    AS_Ue = max( Fs*0.5f+Ds,max( Fs,0.f));
    AP_Ue = AE_Ue+AW_Ue+AN_Ue+AS_Ue;
    }
     B_Ue = Ae*(pB[x  +(y  )*pitch]-pB[x+1+(y  )*pitch]);
     //B_Ue-=( 3.f*u[tx  ][ty  ]-4.f*uC[x  +(y  )*pitch]+uD[x  +(y  )*pitch])*0.5f/DT;
    uA[ x  + y   *pitch] =((AE_Ue*u[tx+1][ty  ]+AW_Ue*u[tx-1][ty  ]
                           +AN_Ue*u[tx  ][ty+1]+AS_Ue*u[tx  ][ty-1]
                           -AP_Ue*u[tx  ][ty  ]+ B_Ue)/(dx*dy)
                           -( 3.f*u[tx  ][ty  ]-4.f*uC[x  +(y  )*pitch]+uD[x  +(y  )*pitch])*0.5f/DT
                           //-( u[tx  ][ty  ]-uC[x  +(y  )*pitch])*0.5f/DT
                           )*DTAU
                           + u[tx  ][ty  ];
    Fe = 0.5f*(u[tx  ][ty  ]+u[tx  ][ty+1])*Ae;
    Fw = 0.5f*(u[tx-1][ty  ]+u[tx-1][ty+1])*Aw;
    Fn = 0.5f*(v[tx  ][ty  ]+v[tx  ][ty+1])*An;
    Fs = 0.5f*(v[tx  ][ty  ]+v[tx  ][ty-1])*As;
    De = nu*Ae/dx; Dw = nu*Aw/dx; Dn = nu*An/dy; Ds = nu*As/dy;
    if(CONV == 1){
    AE_Vn = max(-Fe,0.f)+De;
    AW_Vn = max( Fw,0.f)+Dw;
    AN_Vn = max(-Fn,0.f)+Dn;
    AS_Vn = max( Fs,0.f)+Ds;
    AP_Vn = max( Fe,0.f)+max(-Fw,0.f)+max( Fn,0.f)+max(-Fs,0.f)+Dw+De+Dn+Ds;
    }
    else if(CONV == 2){
    AE_Vn = max(-Fe*0.5f+De,max(-Fe,0.f));
    AW_Vn = max( Fw*0.5f+Dw,max( Fw,0.f));
    AN_Vn = max(-Fn*0.5f+Dn,max(-Fn,0.f));
    AS_Vn = max( Fs*0.5f+Ds,max( Fs,0.f));
    AP_Vn = AE_Vn+AW_Vn+AN_Vn+AS_Vn;
    }
     B_Vn = An*(pB[x  +(y  )*pitch]-pB[x  +(y+1)*pitch]);
     //B_Vn-=( 3.f*v[tx  ][ty  ]-4.f*vC[x  +(y  )*pitch]+vD[x  +(y  )*pitch])*0.5f/DT;
    vA[ x  + y   *pitch] =((AE_Vn*v[tx+1][ty  ]+AW_Vn*v[tx-1][ty  ]
                           +AN_Vn*v[tx  ][ty+1]+AS_Vn*v[tx  ][ty-1]
                           -AP_Vn*v[tx  ][ty  ]+ B_Vn)/(dx*dy)
                           -( 3.f*v[tx  ][ty  ]-4.f*vC[x  +(y  )*pitch]+vD[x  +(y  )*pitch])*0.5f/DT
                           //-( v[tx  ][ty  ]-vC[x  +(y  )*pitch])*0.5f/DT
                           )*DTAU
                           + v[tx  ][ty  ];

    if(y < HALO)
    {
    vA[ x  + y   *pitch] = 0.f;
    uA[ x  + y   *pitch] = u[tx  ][ty+1];
    }
    if(y > YDIM-HALO-2)
    {
    vA[ x  + y   *pitch] = 0.f;
    uA[ x  + y   *pitch] = u[tx  ][ty-1];
    }
    if(x < HALO)
    {
    uA[ x  + y   *pitch] = UMAX;
    vA[ x  + y   *pitch] = 0.f;
    }
    if(x > XDIM-HALO-2)
    {
    uA[ x  + y   *pitch] = u[tx-1][ty  ];
    vA[ x  + y   *pitch] = v[tx-1][ty  ];
    }

    if(x == OBSTX-1 && y>=OBSTY & y<OBSTY+OBSTD)
    uA[ x  + y   *pitch] = 0.f;
    if(x == OBSTX+OBSTD-1 && y>=OBSTY && y<OBSTY+OBSTD)
    uA[ x  + y   *pitch] = 0.f;
    if(y == OBSTY-1 && x>=OBSTX & x<OBSTX+OBSTD)
    vA[ x  + y   *pitch] = 0.f;
    if(y == OBSTY+OBSTD-1 && x>=OBSTX && x<OBSTX+OBSTD)
    vA[ x  + y   *pitch] = 0.f;   

    if(x == OBSTX && y>=OBSTY & y<OBSTY+OBSTD-1)
    vA[ x  + y   *pitch] = -v[tx-1][ty  ];
    if(x == OBSTX+OBSTD-1 && y>=OBSTY && y<OBSTY+OBSTD-1)
    vA[ x  + y   *pitch] = -v[tx+1][ty  ];
    if(y == OBSTY && x>=OBSTX & x<OBSTX+OBSTD-1){
//    if(t < 200) uA[ x  + y   *pitch] = u[tx][ty-1];
//    else 
    uA[ x  + y   *pitch] = -u[tx  ][ty-1];
    }
    if(y == OBSTY+OBSTD-1 && x>=OBSTX && x<OBSTX+OBSTD-1)
    uA[ x  + y   *pitch] = -u[tx  ][ty+1];

    }
    if(x == 0 && y == 0) Res[t] = 0.f;
}

__global__ void ACM_P(float* pA, float* Res, float* uA, float* vA, float* pB, int it, int t, size_t pitch, float *uD)
{
    int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
    int y = threadIdx.y+blockIdx.y*blockDim.y;
    __shared__ float sumRes[BLOCKSIZEX];
    __shared__ int check[1];
    check[0] = 0;
    syncthreads();
    float dx = 1.f/OBSTD;
    float dy = 1.f/OBSTD;

    if(x > HALO-1 && x < XDIM-HALO && y > HALO-1 && y < YDIM-HALO){
    float res = (dy*(uA[ x  + y   *pitch]-uA[ x-1+ y   *pitch])
                                 +dx*(vA[ x  + y   *pitch]-vA[ x  +(y-1)*pitch]))/(dx*dy);
    pA[ x  + y   *pitch] = -res*DTAU/BETA+pB[ x  + y   *pitch];
    if(x > HALO && x < XDIM-HALO-2 && y > HALO && y < YDIM-HALO-2 
        && abs(res/UMAX)>MAXRES && !(x>= OBSTX && y>=OBSTY && x<OBSTX+OBSTD && y<OBSTY+OBSTD)){
    check[0] = 1;
    sumRes[threadIdx.x]=1.f;
    }
    else
    sumRes[threadIdx.x]=0.f;

    }
    else{
    sumRes[threadIdx.x]=0.f;
    }
    syncthreads();

    if(check[0] == 1){
    //reduction for residual
    int nTotalThreads = blockDim.x;
    while(nTotalThreads > 1){
        int halfPoint = (nTotalThreads >> 1);
        if(threadIdx.x < halfPoint){
            sumRes[threadIdx.x] += sumRes[threadIdx.x+halfPoint];
        }
        syncthreads();
        nTotalThreads = halfPoint;
    }
    if(threadIdx.x == 0){
        atomicAdd(&Res[t],sumRes[0]);
    }
    }
}

__global__ void L1ACM_CF(float* uA, float* vA, float* pA, int it, size_t pitch)
{
    int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
    int y = threadIdx.y+blockIdx.y*blockDim.y;
    float xc = 0.5f+(x-HALO)*2.f+HALO+0.5f;
    float yc = 0.5f+(y-HALO)*2.f+HALO+0.5f;
    uA[ x  + y   *pitch] = tex2D(uA0,xc,yc);
    vA[ x  + y   *pitch] = tex2D(vA0,xc,yc);
    pA[ x  + y   *pitch] = tex2D(pA0,xc,yc);
}

__global__ void L1ACM_FC(float* uA, float* vA, float* pA, int it, size_t pitch)
{
    int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
    int y = threadIdx.y+blockIdx.y*blockDim.y;
    float xc = -0.25f+(x-HALO)*0.5f+HALO+0.5f;
    float yc = -0.25f+(y-HALO)*0.5f+HALO+0.5f;
    uA[ x  + y   *pitch] = tex2D(uA1,xc,yc);
    vA[ x  + y   *pitch] = tex2D(vA1,xc,yc);
    pA[ x  + y   *pitch] = tex2D(pA1,xc,yc);
}

//__global__ void L1ACM_U(float* uA, float* vA, float* uB, float* vB, float* pB, float nu, int it, int t, size_t pitch)
__global__ void L1ACM_U(float* uA, float* vA, float* Res, float* uB, float* vB, float* pB, float* uC, float* vC, float* uD, float* vD, float nu, int it, int t, size_t pitch)
{
    int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
    int y = threadIdx.y+blockIdx.y*blockDim.y;
    int tx = threadIdx.x+1;
    int ty = threadIdx.y+1;
    __shared__ float u[L1UBLOCKSIZEX+2][L1UBLOCKSIZEY+2];
    __shared__ float v[L1UBLOCKSIZEX+2][L1UBLOCKSIZEY+2];
    int L1xDim = (XDIM-2*HALO)/2+2*HALO;
    int L1yDim = (YDIM-2*HALO)/2+2*HALO;
    int xc = (x-HALO)*2.f+HALO;
    int yc = (y-HALO)*2.f+HALO;


    if(x > 0 && x < L1xDim-1 && y > 0 && y < L1yDim-1){
    if(threadIdx.x == 0){
    u[0][ty] = uB[ x-1+ y   *pitch];
    v[0][ty] = vB[ x-1+ y   *pitch];
    if(threadIdx.y == blockDim.y-1){
    u[0][ty+1] = uB[ x-1+ (y+1)*pitch];
    }
    }
    if(threadIdx.x == blockDim.x-1){
    u[L1UBLOCKSIZEX+1][ty] = uB[ x+1+ y   *pitch];
    v[L1UBLOCKSIZEX+1][ty] = vB[ x+1+ y   *pitch];
    }
    if(threadIdx.y == 0){
    u[tx][0] = uB[ x+  (y-1)*pitch];
    v[tx][0] = vB[ x+  (y-1)*pitch];
    if(threadIdx.x == blockDim.x-1){
    v[tx+1][0] = vB[ x+1+(y-1)*pitch];
    }
    }
    if(threadIdx.y == blockDim.y-1){
    u[tx][L1UBLOCKSIZEY+1] = uB[ x+ (y+1)*pitch];
    v[tx][L1UBLOCKSIZEY+1] = vB[ x+ (y+1)*pitch];
    }
    u[tx][ty] = uB[ x+ (y  )*pitch];
    v[tx][ty] = vB[ x+ (y  )*pitch];
    }
    syncthreads();

    if(x > 0 && x < L1xDim-1 && y > 0 && y < L1yDim-1){
    float Ae,Aw,An,As;
    float AP_Ue,AE_Ue,AW_Ue,AN_Ue,AS_Ue; //A coeff for East node on u of east face
    float AP_Vn,AE_Vn,AW_Vn,AN_Vn,AS_Vn;
    float Fe,Fw,Fn,Fs;
    float De,Dw,Dn,Ds;
    float B_Ue,B_Vn;
    float dx = 2.f*1.f/OBSTD;
    float dy = 2.f*1.f/OBSTD;
    Ae = dy; Aw = dy; An = dx; As = dx;
    Fe = 0.5f*(u[tx  ][ty  ]+u[tx+1][ty  ])*Ae;
    Fw = 0.5f*(u[tx-1][ty  ]+u[tx  ][ty  ])*Aw;
    Fn = 0.5f*(v[tx  ][ty  ]+v[tx+1][ty  ])*An;
    Fs = 0.5f*(v[tx  ][ty-1]+v[tx+1][ty-1])*As;
    De = nu*Ae/dx; Dw = nu*Aw/dx; Dn = nu*An/dy; Ds = nu*As/dy;
    if(CONV == 1){
    AE_Ue = max(-Fe,0.f)+De;
    AW_Ue = max( Fw,0.f)+Dw;
    AN_Ue = max(-Fn,0.f)+Dn;
    AS_Ue = max( Fs,0.f)+Ds;
    AP_Ue = max( Fe,0.f)+max(-Fw,0.f)+max( Fn,0.f)+max(-Fs,0.f)+Dw+De+Dn+Ds;
    }
    else if(CONV == 2){
    AE_Ue = max(-Fe*0.5f+De,max(-Fe,0.f));
    AW_Ue = max( Fw*0.5f+Dw,max( Fw,0.f));
    AN_Ue = max(-Fn*0.5f+Dn,max(-Fn,0.f));
    AS_Ue = max( Fs*0.5f+Ds,max( Fs,0.f));
    AP_Ue = AE_Ue+AW_Ue+AN_Ue+AS_Ue;
    }
     B_Ue = Ae*(pB[x  +(y  )*pitch]-pB[x+1+(y  )*pitch]);
    uA[ x  + y   *pitch] =((AE_Ue*u[tx+1][ty  ]+AW_Ue*u[tx-1][ty  ]
                           +AN_Ue*u[tx  ][ty+1]+AS_Ue*u[tx  ][ty-1]
                           -AP_Ue*u[tx  ][ty  ]+ B_Ue)/(dx*dy)
                           )*DTAU
                           + u[tx  ][ty  ];
    Fe = 0.5f*(u[tx  ][ty  ]+u[tx  ][ty+1])*Ae;
    Fw = 0.5f*(u[tx-1][ty  ]+u[tx-1][ty+1])*Aw;
    Fn = 0.5f*(v[tx  ][ty  ]+v[tx  ][ty+1])*An;
    Fs = 0.5f*(v[tx  ][ty  ]+v[tx  ][ty-1])*As;
    De = nu*Ae/dx; Dw = nu*Aw/dx; Dn = nu*An/dy; Ds = nu*As/dy;
    if(CONV == 1){
    AE_Vn = max(-Fe,0.f)+De;
    AW_Vn = max( Fw,0.f)+Dw;
    AN_Vn = max(-Fn,0.f)+Dn;
    AS_Vn = max( Fs,0.f)+Ds;
    AP_Vn = max( Fe,0.f)+max(-Fw,0.f)+max( Fn,0.f)+max(-Fs,0.f)+Dw+De+Dn+Ds;
    }
    else if(CONV == 2){
    AE_Vn = max(-Fe*0.5f+De,max(-Fe,0.f));
    AW_Vn = max( Fw*0.5f+Dw,max( Fw,0.f));
    AN_Vn = max(-Fn*0.5f+Dn,max(-Fn,0.f));
    AS_Vn = max( Fs*0.5f+Ds,max( Fs,0.f));
    AP_Vn = AE_Vn+AW_Vn+AN_Vn+AS_Vn;
    }
     B_Vn = An*(pB[x  +(y  )*pitch]-pB[x  +(y+1)*pitch]);
    vA[ x  + y   *pitch] =((AE_Vn*v[tx+1][ty  ]+AW_Vn*v[tx-1][ty  ]
                           +AN_Vn*v[tx  ][ty+1]+AS_Vn*v[tx  ][ty-1]
                           -AP_Vn*v[tx  ][ty  ]+ B_Vn)/(dx*dy)
                           )*DTAU
                           + v[tx  ][ty  ];

    if(y < HALO)
    {
    vA[ x  + y   *pitch] = 0.f;
    uA[ x  + y   *pitch] = u[tx  ][ty+1];
    }
    if(y > L1yDim-HALO-2)
    {
    vA[ x  + y   *pitch] = 0.f;
    uA[ x  + y   *pitch] = u[tx  ][ty-1];
    }
    if(x < HALO)
    {
    uA[ x  + y   *pitch] = UMAX;
    vA[ x  + y   *pitch] = 0.f;
    }
    if(x > L1xDim-HALO-2)
    {
    uA[ x  + y   *pitch] = u[tx-1][ty  ];
    vA[ x  + y   *pitch] = v[tx-1][ty  ];
    }

    if(xc == OBSTX-dx && yc>=OBSTY & yc<OBSTY+OBSTD)
    uA[ x  + y   *pitch] = 0.f;
    if(xc == OBSTX+OBSTD-dx && yc>=OBSTY && yc<OBSTY+OBSTD)
    uA[ x  + y   *pitch] = 0.f;
    if(yc == OBSTY-dy && xc>=OBSTX & xc<OBSTX+OBSTD)
    vA[ x  + y   *pitch] = 0.f;
    if(yc == OBSTY+OBSTD-dy && xc>=OBSTX && xc<OBSTX+OBSTD)
    vA[ x  + y   *pitch] = 0.f;   

    if(xc == OBSTX && yc>=OBSTY & yc<OBSTY+OBSTD-dy)
    vA[ x  + y   *pitch] = -v[tx-1][ty  ];
    if(xc == OBSTX+OBSTD-dx && yc>=OBSTY && yc<OBSTY+OBSTD-dy)
    vA[ x  + y   *pitch] = -v[tx+1][ty  ];
    if(yc == OBSTY && xc>=OBSTX & xc<OBSTX+OBSTD-dy){
//    if(t < 200) uA[ x  + y   *pitch] = u[tx][ty-1];
//    else 
    uA[ x  + y   *pitch] = -u[tx  ][ty-1];
    }
    if(yc == OBSTY+OBSTD-dy && xc>=OBSTX && xc<OBSTX+OBSTD-dy)
    uA[ x  + y   *pitch] = -u[tx  ][ty+1];

    }




}

__global__ void L1ACM_P(float* pA, float* Res, float* uA, float* vA, float* pB, int it, int t, size_t pitch, float *uD)
{
    int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
    int y = threadIdx.y+blockIdx.y*blockDim.y;
    __shared__ float sumRes[L1BLOCKSIZEX];
    __shared__ int check[1];
    check[0] = 0;
    syncthreads();
    float dx = 2.f*1.f/OBSTD;
    float dy = 2.f*1.f/OBSTD;
    int L1xDim = (XDIM-2*HALO)/2+2*HALO;
    int L1yDim = (YDIM-2*HALO)/2+2*HALO;

    if(x > HALO-1 && x < L1xDim-HALO && y > HALO-1 && y < L1yDim-HALO){
    float res = (dy*(uA[ x  + y   *pitch]-uA[ x-1+ y   *pitch])
                                 +dx*(vA[ x  + y   *pitch]-vA[ x  +(y-1)*pitch]))/(dx*dy);
    pA[ x  + y   *pitch] = -res*DTAU/BETA+pB[ x  + y   *pitch];
//    if(x > HALO && x < L1XDIM-HALO-2 && y > HALO && y < L1YDIM-HALO-2 
//        && abs(res/UMAX)>MAXRES && !(2*x>= OBSTX && 2*y>=OBSTY && 2*x<OBSTX+OBSTD && 2*y<OBSTY+OBSTD)){
//    check[0] = 1;
//    sumRes[threadIdx.x]=1.f;
//    }
//    else
//    sumRes[threadIdx.x]=0.f;

    }
    else{
    sumRes[threadIdx.x]=0.f;
    }
    syncthreads();

    if(check[0] == 1){
    //reduction for residual
    int nTotalThreads = blockDim.x;
    while(nTotalThreads > 1){
        int halfPoint = (nTotalThreads >> 1);
        if(threadIdx.x < halfPoint){
            sumRes[threadIdx.x] += sumRes[threadIdx.x+halfPoint];
        }
        syncthreads();
        nTotalThreads = halfPoint;
    }
    if(threadIdx.x == 0){
        atomicAdd(&Res[t],sumRes[0]);
    }
    }
}


__global__ void ACM_Forces(float *FX, float *FY, float* uD, float* vD, float* pA, float nu, int t, size_t pitch)
{
    int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
    int y = threadIdx.y+blockIdx.y*blockDim.y;
    __shared__ float sumFX[BLOCKSIZEX],sumFY[BLOCKSIZEX];
    __shared__ int check[1];
    check[0] = 0;
    sumFX[threadIdx.x] = 0.f;
    sumFY[threadIdx.x] = 0.f;
    syncthreads();
    float dx = 1.f/OBSTD;
    float dy = 1.f/OBSTD;

    //forces on bottom wall
    if(x >= OBSTX && x<OBSTX+OBSTD && y == OBSTY){
    check[0] = 1;
    sumFY[threadIdx.x] += dx*pA[ x  +(y-1)*pitch];
    if(x<OBSTX+OBSTD-1)
        sumFX[threadIdx.x] -= dx*nu*2.f*uD[ x  +(y  )*pitch]/dy;
    }
    //forces on top wall
    if(x >= OBSTX && x<OBSTX+OBSTD && y == OBSTY+OBSTD-1){
    check[0] = 1;
    sumFY[threadIdx.x] -= dx*pA[ x  +(y+1)*pitch];
    if(x<OBSTX+OBSTD-1)
        sumFX[threadIdx.x] -= dx*nu*2.f*uD[ x  +(y  )*pitch]/dy;
    }

    //forces on left wall
    if(y >= OBSTY && y<OBSTY+OBSTD && x == OBSTX){
    check[0] = 1;
    sumFX[threadIdx.x] += dy*pA[ x-1+(y  )*pitch];
    if(y<OBSTY+OBSTD-1)
        sumFY[threadIdx.x] -= dy*nu*2.f*vD[ x  +(y  )*pitch]/dx;
    }
    //forces on right wall
    if(y >= OBSTY && y<OBSTY+OBSTD && x == OBSTX+OBSTD-1){
    check[0] = 1;
    sumFX[threadIdx.x] -= dy*pA[ x+1+(y  )*pitch];
    if(y<OBSTY+OBSTD-1)
        sumFY[threadIdx.x] -= dy*nu*2.f*vD[ x  +(y  )*pitch]/dx;
    }

    syncthreads();

    if(check[0] == 1){
    //reduction for force
    int nTotalThreads = blockDim.x;
    while(nTotalThreads > 1){
        int halfPoint = (nTotalThreads >> 1);
        if(threadIdx.x < halfPoint){
            sumFX[threadIdx.x] += sumFX[threadIdx.x+halfPoint];
            sumFY[threadIdx.x] += sumFY[threadIdx.x+halfPoint];
        }
        syncthreads();
        nTotalThreads = halfPoint;
    }
    if(threadIdx.x == 0){
        atomicAdd(&FX[t],sumFX[0]);
        atomicAdd(&FY[t],sumFY[0]);
    }
    }


}

int main()
{
    
    ofstream output_log,output_results,output_residual,output_vel,output_force;
    float nu = UMAX/RE;
    float Ma = UMAX*sqrt(BETA);
    L1XDIM = (XDIM-2*HALO)/2+2*HALO;
    L1YDIM = (YDIM-2*HALO)/2+2*HALO;
    cout<<"Ma = "<<Ma<<endl;
    string FileName = CASENAME;
    output_log.open ((FileName+".log").c_str());
    output_results.open ((FileName+".dat").c_str());
    output_residual.open ((FileName+".res").c_str());
    output_vel.open ((FileName+".vel").c_str());
    output_force.open ((FileName+".frc").c_str());
    //write input parameters to console and log file
    WriteInputs(cout);
    WriteInputs(output_log);

    //allocate and initialize arrays
    float *u[4],*v[4],*p[4],*Res,*FX,*FY;
    float *L1u[4],*L1v[4],*L1p[4];
    for(int i = 0; i<4; i++){
        u[i] = (float *)malloc(XDIM*YDIM*sizeof(float));
        v[i] = (float *)malloc(XDIM*YDIM*sizeof(float));
        p[i] = (float *)malloc(XDIM*YDIM*sizeof(float));
        L1u[i] = (float *)malloc(L1XDIM*L1YDIM*sizeof(float));
        L1v[i] = (float *)malloc(L1XDIM*L1YDIM*sizeof(float));
        L1p[i] = (float *)malloc(L1XDIM*L1YDIM*sizeof(float));
    }
    Res= (float *)malloc(TMAX*sizeof(float));
    FX = (float *)malloc(TMAX*sizeof(float));
    FY = (float *)malloc(TMAX*sizeof(float));
    //initialize host memory
    for(int i = 0; i<4; i++){
    for(int j = 0; j<XDIM*YDIM; j++){
        u[i][j] = UMAX;
        v[i][j] = 0.f;
        p[i][j] = 0.f;
    }
    for(int j = 0; j<L1XDIM*L1YDIM; j++){
        L1u[i][j] = 0.f;
        L1v[i][j] = 0.f;
        L1p[i][j] = 0.f;
    }
    }
    for(int j = 0; j<TMAX; j++){
        Res[j] = 0.f;
        FX[j] = 0.f;
        FY[j] = 0.f;
    }

    //size_t memsize, memsize2;
    size_t pitch = 2;
    while(pitch<XDIM)
        pitch=pitch*2;
    pitch *= sizeof(float);//pitch*sizeof(float);
    size_t pitch_e = pitch/sizeof(float);
    cout<<"Pitch (in elements): "<<pitch/sizeof(float)<<endl;

    size_t L1pitch = 2;
    while(L1pitch<L1XDIM)
        L1pitch=L1pitch*2;
    L1pitch *= sizeof(float);//pitch*sizeof(float);
    size_t L1pitch_e = L1pitch/sizeof(float);

    L1pitch_e = pitch_e;
    L1pitch = pitch;
    cout<<"L1Pitch (in elements): "<<L1pitch/sizeof(float)<<endl;


    dim3 u_threads(UBLOCKSIZEX, UBLOCKSIZEY,1);
    dim3 u_grid  (((XDIM+UBLOCKSIZEX-1)/UBLOCKSIZEX),((YDIM+UBLOCKSIZEY-1)/UBLOCKSIZEY),1);
    dim3 threads(BLOCKSIZEX, BLOCKSIZEY,1);
    dim3 grid  (((XDIM+BLOCKSIZEX-1)/BLOCKSIZEX),((YDIM+BLOCKSIZEY-1)/BLOCKSIZEY),1);

    dim3 L1u_threads(L1UBLOCKSIZEX, L1UBLOCKSIZEY,1);
    dim3 L1u_grid  (((L1XDIM+L1UBLOCKSIZEX-1)/L1UBLOCKSIZEX),((L1YDIM+L1UBLOCKSIZEY-1)/L1UBLOCKSIZEY),1);
    dim3 L1threads(L1BLOCKSIZEX, L1BLOCKSIZEY,1);
    dim3 L1grid  (((L1XDIM+L1BLOCKSIZEX-1)/L1BLOCKSIZEX),((L1YDIM+L1BLOCKSIZEY-1)/L1BLOCKSIZEY),1);

    cudaStream_t compute;
    cudaStream_t transfer;
    cudaStreamCreate(&compute);
    cudaStreamCreate(&transfer);

    float *u_d[4],*v_d[4],*p_d[4], *Res_d, *FX_d, *FY_d;
    float *L1u_d[4],*L1v_d[4],*L1p_d[4];
    for(int i = 0; i<4; i++){
        cudaMalloc((void **) &u_d[i], pitch_e*YDIM*sizeof(float));
        cudaMalloc((void **) &v_d[i], pitch_e*YDIM*sizeof(float));
        cudaMalloc((void **) &p_d[i], pitch_e*YDIM*sizeof(float));
        cudaMalloc((void **) &L1u_d[i], L1pitch_e*L1YDIM*sizeof(float));
        cudaMalloc((void **) &L1v_d[i], L1pitch_e*L1YDIM*sizeof(float));
        cudaMalloc((void **) &L1p_d[i], L1pitch_e*L1YDIM*sizeof(float));
    }
    cudaMalloc((void **) &Res_d, TMAX*sizeof(float));
    cudaMalloc((void **) &FX_d, TMAX*sizeof(float));
    cudaMalloc((void **) &FY_d, TMAX*sizeof(float));
    for(int i = 0; i<4; i++){
        cudaMemcpy2D(u_d[i],pitch,u[i],XDIM*sizeof(float),XDIM*sizeof(float),YDIM,cudaMemcpyHostToDevice);
        cudaMemcpy2D(v_d[i],pitch,v[i],XDIM*sizeof(float),XDIM*sizeof(float),YDIM,cudaMemcpyHostToDevice);
        cudaMemcpy2D(p_d[i],pitch,p[i],XDIM*sizeof(float),XDIM*sizeof(float),YDIM,cudaMemcpyHostToDevice);
        cudaMemcpy2D(L1u_d[i],L1pitch,L1u[i],L1XDIM*sizeof(float),L1XDIM*sizeof(float),L1YDIM,cudaMemcpyHostToDevice);
        cudaMemcpy2D(L1v_d[i],L1pitch,L1v[i],L1XDIM*sizeof(float),L1XDIM*sizeof(float),L1YDIM,cudaMemcpyHostToDevice);
        cudaMemcpy2D(L1p_d[i],L1pitch,L1p[i],L1XDIM*sizeof(float),L1XDIM*sizeof(float),L1YDIM,cudaMemcpyHostToDevice);
    }
    cudaMemcpy(Res_d,Res,TMAX*sizeof(float),cudaMemcpyHostToDevice);
    cudaMemcpy(FX_d,FX,TMAX*sizeof(float),cudaMemcpyHostToDevice);
    cudaMemcpy(FY_d,FY,TMAX*sizeof(float),cudaMemcpyHostToDevice);

	cudaChannelFormatDesc desc = cudaCreateChannelDesc<float>();

	uA0.normalized = false; uA0.filterMode = cudaFilterModeLinear;
	uB0.normalized = false; uB0.filterMode = cudaFilterModeLinear;
	vA0.normalized = false; vA0.filterMode = cudaFilterModeLinear;
	vB0.normalized = false; vB0.filterMode = cudaFilterModeLinear;
	pA0.normalized = false; pA0.filterMode = cudaFilterModeLinear;
	pB0.normalized = false; pB0.filterMode = cudaFilterModeLinear;
	uA1.normalized = false; uA1.filterMode = cudaFilterModeLinear;
	uB1.normalized = false; uB1.filterMode = cudaFilterModeLinear;
	vA1.normalized = false; vA1.filterMode = cudaFilterModeLinear;
	vB1.normalized = false; vB1.filterMode = cudaFilterModeLinear;
	pA1.normalized = false; pA1.filterMode = cudaFilterModeLinear;
	pB1.normalized = false; pB1.filterMode = cudaFilterModeLinear;
	for(int i = 0; i<2; i++){
	uA0.addressMode[i]  = cudaAddressModeClamp;
	uB0.addressMode[i]  = cudaAddressModeClamp;
	vA0.addressMode[i]  = cudaAddressModeClamp;
	vB0.addressMode[i]  = cudaAddressModeClamp;
	pA0.addressMode[i]  = cudaAddressModeClamp;
	pB0.addressMode[i]  = cudaAddressModeClamp;
	uA1.addressMode[i]  = cudaAddressModeClamp;
	uB1.addressMode[i]  = cudaAddressModeClamp;
	vA1.addressMode[i]  = cudaAddressModeClamp;
	vB1.addressMode[i]  = cudaAddressModeClamp;
	pA1.addressMode[i]  = cudaAddressModeClamp;
	pB1.addressMode[i]  = cudaAddressModeClamp;
    }

	cudaBindTexture2D(0,&uA0,   u_d[0],&desc,  XDIM,  YDIM,  pitch);
	cudaBindTexture2D(0,&uB0,   u_d[1],&desc,  XDIM,  YDIM,  pitch);
	cudaBindTexture2D(0,&vA0,   v_d[0],&desc,  XDIM,  YDIM,  pitch);
	cudaBindTexture2D(0,&vB0,   v_d[1],&desc,  XDIM,  YDIM,  pitch);
	cudaBindTexture2D(0,&pA0,   p_d[0],&desc,  XDIM,  YDIM,  pitch);
	cudaBindTexture2D(0,&pB0,   p_d[1],&desc,  XDIM,  YDIM,  pitch);
	cudaBindTexture2D(0,&uA1, L1u_d[0],&desc,L1XDIM,L1YDIM,L1pitch);
	cudaBindTexture2D(0,&uB1, L1u_d[1],&desc,L1XDIM,L1YDIM,L1pitch);
	cudaBindTexture2D(0,&vA1, L1v_d[0],&desc,L1XDIM,L1YDIM,L1pitch);
	cudaBindTexture2D(0,&vB1, L1v_d[1],&desc,L1XDIM,L1YDIM,L1pitch);
	cudaBindTexture2D(0,&pA1, L1p_d[0],&desc,L1XDIM,L1YDIM,L1pitch);
	cudaBindTexture2D(0,&pB1, L1p_d[1],&desc,L1XDIM,L1YDIM,L1pitch);

	cudaFuncSetCacheConfig(ACM_U_Shared,cudaFuncCachePreferShared);

    int A,B,C,D,A1,B1;
    int its;
    A = 0; B = 1; C = 2; D = 3;
    A1= 0; B1= 1;
    struct timeval tdr0,tdr1;
    double restime;
    cudaDeviceSynchronize();
    gettimeofday (&tdr0,NULL);

    //time loop
    for(int t = 0; t<1; t++){
    for(int it = 0; it<MAXIT; it++){

        L1ACM_CF<<<L1grid,L1threads,0,compute>>>(L1u_d[B1],L1v_d[B1],L1p_d[B1],0,L1pitch_e);
        for(int i = 0; i<20; i++)
        {
        L1ACM_U<<<L1u_grid,L1u_threads,0,compute>>>(L1u_d[A1],L1v_d[A1],Res_d,L1u_d[B1],L1v_d[B1],L1p_d[B1],L1u_d[C],L1v_d[C],L1u_d[D],L1v_d[D],nu,0,t,L1pitch_e);
        L1ACM_P<<<L1grid,L1threads,0,compute>>>(L1p_d[A1],Res_d,L1u_d[A1],L1v_d[A1],L1p_d[B1],0,t,L1pitch_e,L1u_d[D]);
      swap(A1,B1);
        }
        L1ACM_FC<<<grid,threads,0,compute>>>(u_d[A],v_d[A],p_d[A],0,pitch_e);
        cudaDeviceSynchronize();

        for(int i = 0; i<20; i++)
        {
        swap(A,B);
        ACM_U_Shared<<<u_grid,u_threads,0,compute>>>(u_d[A],v_d[A],Res_d,u_d[B],v_d[B],p_d[B],u_d[C],v_d[C],u_d[D],v_d[D],nu,it,t,pitch_e);
        ACM_P<<<grid,threads,0,compute>>>(p_d[A],Res_d,u_d[A],v_d[A],p_d[B],it,t,pitch_e,u_d[D]);
        cudaDeviceSynchronize();
        cudaMemcpyAsync(&Res[t],&Res_d[t],sizeof(float),cudaMemcpyDeviceToHost,compute);
        output_residual<<it<<", "<<Res[t]<<endl;
        if(it > 0){
        if(Res[t]<1 || it == MAXIT-1){
            its = it; it = MAXIT;
        }
        }
        }

    }//end iteration 
    ACM_Forces<<<grid,threads,0,compute>>>(FX_d,FY_d,u_d[A],v_d[A],p_d[A],nu,t,pitch_e);


    cudaMemcpyAsync(&FX[t],&FX_d[t],sizeof(float),cudaMemcpyDeviceToHost,compute);
    cudaMemcpyAsync(&FY[t],&FY_d[t],sizeof(float),cudaMemcpyDeviceToHost,compute);
    if(t%1000==0 && t>0) cout<<"finished time step "<<t<<endl;
    cudaDeviceSynchronize();
    output_force<<t<<", "<<FX[t]<<", "<<FY[t]<<endl;
    swap(C,D);
    swap(C,A);
    }//end time loop


    cudaDeviceSynchronize();
    gettimeofday (&tdr1,NULL);
    timeval_subtract (&restime, &tdr1, &tdr0);
    int Nodes;
    Nodes = XDIM*YDIM;
    cout<<"Time taken for main kernel: "<<restime<<" ("
            <<double(Nodes*double(TMAX/1000000.f))/restime<<"MNUPS)\n";

    for(int i = 0; i<4; i++){
    for(int j = 0; j<XDIM*YDIM; j++){
        u[i][j] = 1000.f;
        v[i][j] = 1000.f;
        p[i][j] = 1000.f;
    }
    }

    //Copy results from device to host
    for(int i = 0; i<4; i++){
        cudaMemcpy2D(u[i],XDIM*sizeof(float),u_d[i],pitch,XDIM*sizeof(float),YDIM,cudaMemcpyDeviceToHost);
        cudaMemcpy2D(v[i],XDIM*sizeof(float),v_d[i],pitch,XDIM*sizeof(float),YDIM,cudaMemcpyDeviceToHost);
        cudaMemcpy2D(p[i],XDIM*sizeof(float),p_d[i],pitch,XDIM*sizeof(float),YDIM,cudaMemcpyDeviceToHost);
        cudaMemcpy2D(L1u[i],L1XDIM*sizeof(float),L1u_d[i],L1pitch,L1XDIM*sizeof(float),L1YDIM,cudaMemcpyDeviceToHost);
        cudaMemcpy2D(L1v[i],L1XDIM*sizeof(float),L1v_d[i],L1pitch,L1XDIM*sizeof(float),L1YDIM,cudaMemcpyDeviceToHost);
        cudaMemcpy2D(L1p[i],L1XDIM*sizeof(float),L1p_d[i],L1pitch,L1XDIM*sizeof(float),L1YDIM,cudaMemcpyDeviceToHost);
    }
    cudaMemcpy(Res,Res_d,TMAX*sizeof(float),cudaMemcpyDeviceToHost);
    cudaMemcpy(FX,FX_d,TMAX*sizeof(float),cudaMemcpyDeviceToHost);
    cudaMemcpy(FY,FY_d,TMAX*sizeof(float),cudaMemcpyDeviceToHost);


    WriteResults(output_results,u[0],v[0],p[0]);
    WriteResultsL1(output_results,L1u[0],L1v[0],L1p[0]);
//    WriteResults(output_results,u[3],v[3],p[3]);
    //WriteForces(output_force,FX,FY);


    output_log.close();
    output_results.close();
    output_residual.close();
    output_vel.close();

    return 0;

}
