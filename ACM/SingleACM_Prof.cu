#include <cuda.h>
#include <iostream>
#include <ostream>
#include <fstream>
#include <sys/time.h>
#include <time.h>
using namespace std;
	
#define CASENAME "speed3"

#define BLOCKSIZEX 192
#define BLOCKSIZEY 1
#define UBLOCKSIZEX 32
#define UBLOCKSIZEY 10
#define HALO 2
#define XDIM 576
#define YDIM 165
#define OBSTD 20 //.f
#define OBSTX 122 //.f
#define OBSTY 72 //.f

#define TMAX 200
#define MAXIT 5000
#define MAXRES 0.0001
#define RE 100
#define UMAX 20.f
#define BETA 0.000025f //beta = 1/c^2
#define DTAU 0.002f
#define DT 1.f

#define CONV 2  //1:UDS 2:Hybrid
#define TIMEMARCH 2  //1:Explicit Euler 2:RK2

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

inline __device__ float PoisProf (float x){
	float radius = (YDIM-1-2*HALO)*0.5f;
	float result = -1.0f*(((1.0f-(x-HALO)/radius))*((1.0f-(x-HALO)/radius))-1.0f);
	return (result);
//	return 1.f;
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

__global__ void ACM_U_Shared_Single2(float* uA, float* vA, float* Res, float* uB, float* vB, float* pB, float* uC, float* vC, float nu, float dtau, int it, int t, size_t pitch)
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
    float dx = 1.f;///OBSTD;
    float dy = 1.f;///OBSTD;
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
                           //-( 3.f*u[tx  ][ty  ]-4.f*uC[x  +(y  )*pitch]+uD[x  +(y  )*pitch])*0.5f/DT
                           //-( u[tx  ][ty  ]-uC[x  +(y  )*pitch])*0.5f/DT
                           )*dtau
                           + uC[x+y*pitch];
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
                           //-( 3.f*v[tx  ][ty  ]-4.f*vC[x  +(y  )*pitch]+vD[x  +(y  )*pitch])*0.5f/DT
                           //-( v[tx  ][ty  ]-vC[x  +(y  )*pitch])*0.5f/DT
                           )*dtau
                           + vC[x+y*pitch];

//    if(y < HALO)
//    {
//    vA[ x  + y   *pitch] = 0.f;
//    uA[ x  + y   *pitch] = -u[tx  ][ty+1];
//    }
//    if(y > YDIM-HALO-2)
//    {
//    vA[ x  + y   *pitch] = 0.f;
//    uA[ x  + y   *pitch] = -u[tx  ][ty-1];
//    }
//    if(y > YDIM-HALO-3)
//    vA[ x  + y   *pitch] = 0.f;
//    if(x < HALO)
//    {
//    uA[ x  + y   *pitch] = UMAX*PoisProf(y);
//    vA[ x  + y   *pitch] = 0.f;
//    }
//    if(x > XDIM-HALO-2)
//    {
//    uA[ x  + y   *pitch] = u[tx-1][ty  ];
//    vA[ x  + y   *pitch] = v[tx-1][ty  ];
//    }
//    if(x > XDIM-HALO-3)
//    uA[ x  + y   *pitch] = u[tx-1][ty  ];
//
//    if(x == OBSTX-1 && y>=OBSTY & y<OBSTY+OBSTD)
//    uA[ x  + y   *pitch] = 0.f;
//    if(x == OBSTX+OBSTD-1 && y>=OBSTY && y<OBSTY+OBSTD)
//    uA[ x  + y   *pitch] = 0.f;
//    if(y == OBSTY-1 && x>=OBSTX & x<OBSTX+OBSTD)
//    vA[ x  + y   *pitch] = 0.f;
//    if(y == OBSTY+OBSTD-1 && x>=OBSTX && x<OBSTX+OBSTD)
//    vA[ x  + y   *pitch] = 0.f;   
//
//    if(x == OBSTX && y>=OBSTY & y<OBSTY+OBSTD-1)
//    vA[ x  + y   *pitch] = -v[tx-1][ty  ];
//    if(x == OBSTX+OBSTD-1 && y>=OBSTY && y<OBSTY+OBSTD-1)
//    vA[ x  + y   *pitch] = -v[tx+1][ty  ];
//    if(y == OBSTY && x>=OBSTX & x<OBSTX+OBSTD-1){
//    if(t < 500) uA[ x  + y   *pitch] = u[tx][ty-1];
//    else 
//    uA[ x  + y   *pitch] = -u[tx  ][ty-1];
//    }
//    if(y == OBSTY+OBSTD-1 && x>=OBSTX && x<OBSTX+OBSTD-1)
//    uA[ x  + y   *pitch] = -u[tx  ][ty+1];

    }
    if(x == 0 && y == 0) Res[t] = 0.f;
}

__global__ void ACM_BC(float* u, float* v, int t, size_t pitch)
{
    int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
    int y = threadIdx.y+blockIdx.y*blockDim.y;
    if(y < HALO)
    {
    v[ x  + y   *pitch] = 0.f;
    u[ x  + y   *pitch] = -u[x +(y+1)*pitch];
    }
    if(y > YDIM-HALO-2)
    {
    v[ x  + y   *pitch] = 0.f;
    u[ x  + y   *pitch] = -u[x +(y-1)*pitch];
    }
    if(y > YDIM-HALO-3)
    v[ x  + y   *pitch] = 0.f;
    if(x < HALO)
    {
    u[ x  + y   *pitch] = UMAX*PoisProf(y);
    v[ x  + y   *pitch] = 0.f;
    }
    if(x > XDIM-HALO-2)
    {
    u[ x  + y   *pitch] = u[XDIM-HALO-2+y*pitch];
    v[ x  + y   *pitch] = v[XDIM-HALO-2+y*pitch];
    }
//    if(x > XDIM-HALO-3)
//    u[ x  + y   *pitch] = u[x-1+y*pitch];

    if(x == OBSTX-1 && y>=OBSTY & y<OBSTY+OBSTD)
    u[ x  + y   *pitch] = 0.f;
    if(x == OBSTX+OBSTD-1 && y>=OBSTY && y<OBSTY+OBSTD)
    u[ x  + y   *pitch] = 0.f;
    if(y == OBSTY-1 && x>=OBSTX & x<OBSTX+OBSTD)
    v[ x  + y   *pitch] = 0.f;
    if(y == OBSTY+OBSTD-1 && x>=OBSTX && x<OBSTX+OBSTD)
    v[ x  + y   *pitch] = 0.f;   

    if(x == OBSTX && y>=OBSTY & y<OBSTY+OBSTD-1)
    v[ x  + y   *pitch] = -v[x-1+y*pitch];
    if(x == OBSTX+OBSTD-1 && y>=OBSTY && y<OBSTY+OBSTD-1)
    v[ x  + y   *pitch] = -v[x+1+y*pitch];
    if(y == OBSTY && x>=OBSTX & x<OBSTX+OBSTD-1){
    if(t < 500) u[ x  + y   *pitch] = u[x+(y-1)*pitch];
    else 
    u[ x  + y   *pitch] = -u[x+(y-1)*pitch];
    }
    if(y == OBSTY+OBSTD-1 && x>=OBSTX && x<OBSTX+OBSTD-1)
    u[ x  + y   *pitch] = -u[x+(y+1)*pitch];

}

__global__ void ACM_P(float* pA, float* Res, float* uA, float* vA, float* pB, float dtau, int it, int t, size_t pitch)
{
    int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
    int y = threadIdx.y+blockIdx.y*blockDim.y;
    __shared__ float sumRes[BLOCKSIZEX];
    __shared__ int check[1];
    check[0] = 0;
    syncthreads();
    float dx = 1.f;///OBSTD;
    float dy = 1.f;///OBSTD;

    if(x > HALO-1 && x < XDIM-HALO && y > HALO-1 && y < YDIM-HALO){
    float res = (dy*(uA[ x  + y   *pitch]-uA[ x-1+ y   *pitch])
                                 +dx*(vA[ x  + y   *pitch]-vA[ x  +(y-1)*pitch]))/(dx*dy);
    pA[ x  + y   *pitch] = -res*dtau/BETA+pB[ x  + y   *pitch];
    if(x > HALO && x < XDIM-HALO-2 && y > HALO && y < YDIM-HALO-2 
        && abs(res)>MAXRES && !(x>= OBSTX && y>=OBSTY && x<OBSTX+OBSTD && y<OBSTY+OBSTD)){
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

__global__ void ACM_Forces1(float *FX_intm, float *FY_intm, float* uD, float* vD, float* pA, float nu, int t, size_t pitch, float *test)
{
    int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
    int y = threadIdx.y+blockIdx.y*blockDim.y;
    int xcoord = x+OBSTX;
    int ycoord = y+OBSTY;
    __shared__ float sumFX[OBSTD],sumFY[OBSTD];
    sumFX[threadIdx.x] = 0.f;
    sumFY[threadIdx.x] = 0.f;
    syncthreads();
    float dx = 1.f;///OBSTD;
    float dy = 1.f;///OBSTD;

    //forces on bottom wall
    if(y == 0){
    sumFY[threadIdx.x] += dx*pA[ xcoord  +(ycoord-1)*pitch];
    sumFX[threadIdx.x] -= dx*nu*2.f*uD[ xcoord  +(ycoord  )*pitch]/dy;
    }
    //forces on top wall
    if(y == OBSTD-1){
    sumFY[threadIdx.x] -= dx*pA[ xcoord  +(ycoord+1)*pitch];
    sumFX[threadIdx.x] -= dx*nu*2.f*uD[ xcoord  +(ycoord  )*pitch]/dy;
    }
    //forces on left wall
    if(x == 0){
    sumFX[threadIdx.x] += dy*pA[ xcoord-1+(ycoord  )*pitch];
    sumFY[threadIdx.x] -= dy*nu*2.f*vD[ xcoord  +(ycoord  )*pitch]/dy;
    }
    //forces on right wall
    if(x == OBSTD-1){
    sumFX[threadIdx.x] -= dy*pA[ xcoord+1+(ycoord  )*pitch];
    sumFY[threadIdx.x] -= dy*nu*2.f*vD[ xcoord  +(ycoord  )*pitch]/dx;
    }

    syncthreads();

    //reduction for force
//    int nTotalThreads = blockDim.x;
//    while(nTotalThreads > 1){
//        int halfPoint = (nTotalThreads >> 1);
//        if(threadIdx.x < halfPoint){
//            sumFX[threadIdx.x] += sumFX[threadIdx.x+halfPoint];
//            sumFY[threadIdx.x] += sumFY[threadIdx.x+halfPoint];
//        }
//        syncthreads();
//        nTotalThreads = halfPoint;
//    }
    float sum = 0;
    if(threadIdx.x == 0){
    for(int i = 0; i<blockDim.x; i++)
        sum += sumFX[i];
    }
    sumFX[0] = sum;
    sum = 0;
    if(threadIdx.x == 0){
    for(int i = 0; i<blockDim.x; i++)
        sum += sumFY[i];
    }
    sumFY[0] = sum;
    if(threadIdx.x == 0){
        FX_intm[y] = sumFX[0];
        FY_intm[y] = sumFY[0];
    }


}

__global__ void ACM_Forces2(float *FX, float *FY, float *FX_intm, float *FY_intm, int t, size_t pitch, float *test)
{
    int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
    int y = threadIdx.y+blockIdx.y*blockDim.y;
    int xcoord = x+OBSTX;
    int ycoord = y+OBSTY;
    __shared__ float sumFX[OBSTD],sumFY[OBSTD];
    sumFX[threadIdx.y] = 0.f;
    sumFY[threadIdx.y] = 0.f;
    syncthreads();
    
    sumFX[threadIdx.y] = FX_intm[threadIdx.y];
    sumFY[threadIdx.y] = FY_intm[threadIdx.y];
    //test[xcoord+ycoord*pitch] = 1.f;
    
    syncthreads();

    float sum = 0;
    if(threadIdx.y == 0){
    for(int i = 0; i<blockDim.y; i++)
        sum += sumFX[i];
    }
        sumFX[0] = sum;
    sum = 0;
    if(threadIdx.y == 0){
    for(int i = 0; i<blockDim.y; i++)
        sum += sumFY[i];
    }
        sumFY[0] = sum;
    if(threadIdx.y == 0){
        FX[t] = sumFX[0];
        FY[t] = sumFY[0];
    }


}

int main()
{
    
    ofstream output_log,output_results,output_residual,output_vel,output_force;
    float nu = UMAX*OBSTD/RE;
    float Ma = UMAX*sqrt(BETA);
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
    for(int i = 0; i<4; i++){
        u[i] = (float *)malloc(XDIM*YDIM*sizeof(float));
        v[i] = (float *)malloc(XDIM*YDIM*sizeof(float));
        p[i] = (float *)malloc(XDIM*YDIM*sizeof(float));
    }
    Res = (float *)malloc(TMAX*sizeof(float));
    FX = (float *)malloc(TMAX*sizeof(float));
    FY = (float *)malloc(TMAX*sizeof(float));
    //initialize host memory
    for(int i = 0; i<4; i++){
    for(int j = 0; j<XDIM*YDIM; j++){
        u[i][j] = UMAX;
        v[i][j] = 0.f;
        p[i][j] = 0.f;
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

    dim3 u_threads(UBLOCKSIZEX, UBLOCKSIZEY,1);
    dim3 u_grid  (((XDIM+UBLOCKSIZEX-1)/UBLOCKSIZEX),((YDIM+UBLOCKSIZEY-1)/UBLOCKSIZEY),1);
    dim3 threads(BLOCKSIZEX, BLOCKSIZEY,1);
    dim3 grid  (((XDIM+BLOCKSIZEX-1)/BLOCKSIZEX),((YDIM+BLOCKSIZEY-1)/BLOCKSIZEY),1);
    dim3 f1_threads (OBSTD,1,1);
    dim3 f1_grid    (1,OBSTD,1);
    dim3 f2_threads (1,OBSTD,1);
    dim3 f2_grid    (1,1,1);

    cudaStream_t compute;
    cudaStream_t transfer;
    cudaStreamCreate(&compute);
    cudaStreamCreate(&transfer);

    float *u_d[4],*v_d[4],*p_d[4], *Res_d, *FX_d, *FY_d;
    float *FX_intm, *FY_intm;
    float *test;
    for(int i = 0; i<4; i++){
        cudaMalloc((void **) &u_d[i], pitch_e*YDIM*sizeof(float));
        cudaMalloc((void **) &v_d[i], pitch_e*YDIM*sizeof(float));
        cudaMalloc((void **) &p_d[i], pitch_e*YDIM*sizeof(float));
    }
    cudaMalloc((void **) &test, pitch_e*YDIM*sizeof(float));
    cudaMalloc((void **) &FX_intm, int(OBSTD)*sizeof(float));
    cudaMalloc((void **) &FY_intm, int(OBSTD)*sizeof(float));
    cudaMalloc((void **) &Res_d,TMAX*sizeof(float));
    cudaMalloc((void **) &FX_d, TMAX*sizeof(float));
    cudaMalloc((void **) &FY_d, TMAX*sizeof(float));
    for(int i = 0; i<4; i++){
        cudaMemcpy2D(u_d[i],pitch,u[i],XDIM*sizeof(float),XDIM*sizeof(float),YDIM,cudaMemcpyHostToDevice);
        cudaMemcpy2D(v_d[i],pitch,v[i],XDIM*sizeof(float),XDIM*sizeof(float),YDIM,cudaMemcpyHostToDevice);
        cudaMemcpy2D(p_d[i],pitch,p[i],XDIM*sizeof(float),XDIM*sizeof(float),YDIM,cudaMemcpyHostToDevice);
    }
    cudaMemcpy(Res_d,Res,TMAX*sizeof(float),cudaMemcpyHostToDevice);
    cudaMemcpy(FX_d,FX,TMAX*sizeof(float),cudaMemcpyHostToDevice);
    cudaMemcpy(FY_d,FY,TMAX*sizeof(float),cudaMemcpyHostToDevice);

	cudaFuncSetCacheConfig(ACM_U_Shared_Single2,cudaFuncCachePreferShared);

    int A,B,C,D;
    int its;
    A = 0; B = 1; C = 2; D = 3;
    struct timeval tdr0,tdr1;
    double restime;
    cudaDeviceSynchronize();
    gettimeofday (&tdr0,NULL);

    //time loop
    for(int t = 0; t<TMAX; t++){
    //for(int it = 0; it<MAXIT; it++){
        swap(A,B);
        int it = 10;
        //if(it > 0)
        if(TIMEMARCH == 1){
        //ACM_U_Shared_Single<<<u_grid,u_threads,0,compute>>>(u_d[B],v_d[B],Res_d,u_d[A],v_d[A],p_d[A],nu,it,t,pitch_e);
        ACM_U_Shared_Single2<<<u_grid,u_threads,0,compute>>>(u_d[B],v_d[B],Res_d,u_d[A],v_d[A],p_d[A],u_d[A],v_d[A],nu,DTAU,it,t,pitch_e);
        ACM_BC<<<grid,threads,0,compute>>>(u_d[B],v_d[B],t,pitch_e);
        ACM_P<<<grid,threads,0,compute>>>(p_d[B],Res_d,u_d[B],v_d[B],p_d[A],DTAU,it,t,pitch_e);
        }
        else if(TIMEMARCH == 2){
        ACM_U_Shared_Single2<<<u_grid,u_threads,0,compute>>>(u_d[C],v_d[C],Res_d,u_d[A],v_d[A],p_d[A],u_d[A],v_d[A],nu,DTAU*0.5f,it,t,pitch_e);
        ACM_BC<<<grid,threads,0,compute>>>(u_d[C],v_d[C],t,pitch_e);
        ACM_P<<<grid,threads,0,compute>>>(p_d[C],Res_d,u_d[C],v_d[C],p_d[A],DTAU*0.5f,it,t,pitch_e);
        ACM_U_Shared_Single2<<<u_grid,u_threads,0,compute>>>(u_d[B],v_d[B],Res_d,u_d[C],v_d[C],p_d[C],u_d[A],v_d[A],nu,DTAU,it,t,pitch_e);
        ACM_BC<<<grid,threads,0,compute>>>(u_d[B],v_d[B],t,pitch_e);
        ACM_P<<<grid,threads,0,compute>>>(p_d[B],Res_d,u_d[B],v_d[B],p_d[A],DTAU,it,t,pitch_e);
        }
        cudaDeviceSynchronize();
        cudaMemcpyAsync(&Res[t],&Res_d[t],sizeof(float),cudaMemcpyDeviceToHost,compute);
    //    if(it > 0){
    //    //if(sqrt(Res[t])/float((XDIM-2*HALO)*(YDIM-2*HALO)) < MAXRES || it == MAXIT-1){
    //    if(Res[t]<1 || it == MAXIT-1){
    //        its = it; it = MAXIT;
    //    }
    //    }
    //}//end iteration 

    ACM_Forces1<<<f1_grid,f1_threads,0,compute>>>(FX_intm,FY_intm,u_d[B],v_d[B],p_d[B],nu,t,pitch_e,test);
    ACM_Forces2<<<f2_grid,f2_threads,0,compute>>>(FX_d,FY_d,FX_intm,FY_intm,t,pitch_e,test);


    cudaMemcpyAsync(&FX[t],&FX_d[t],sizeof(float),cudaMemcpyDeviceToHost,compute);
    cudaMemcpyAsync(&FY[t],&FY_d[t],sizeof(float),cudaMemcpyDeviceToHost,compute);
    if(t%1000==0 && t>0) cout<<"finished time step "<<t<<endl;
    cudaDeviceSynchronize();
    //output_residual<<t<<", "<<its<<", "<<sqrt(Res[t])/((XDIM-2*HALO)*(YDIM-2*HALO))<<endl;
    output_residual<<t<<", "<<its<<", "<<Res[t]<<endl;
    output_force<<t<<", "<<FX[t]/0.5f<<", "<<FY[t]/0.5f<<endl;
    //swap(C,D);
    //swap(C,A);
    //cout<<A<<", "<<B<<" "<<C<<", "<<D<<endl;
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
    }
    //cudaMemcpy2D(p[0],XDIM*sizeof(float),test,pitch,XDIM*sizeof(float),YDIM,cudaMemcpyDeviceToHost);
    cudaMemcpy(Res,Res_d,TMAX*sizeof(float),cudaMemcpyDeviceToHost);
    cudaMemcpy(FX,FX_d,TMAX*sizeof(float),cudaMemcpyDeviceToHost);
    cudaMemcpy(FY,FY_d,TMAX*sizeof(float),cudaMemcpyDeviceToHost);


    WriteResults(output_results,u[0],v[0],p[0]);
//    WriteResults(output_results,u[3],v[3],p[3]);
    //WriteForces(output_force,FX,FY);


    output_log.close();
    output_results.close();
    output_residual.close();
    output_vel.close();

    return 0;

}
