#include <cuda.h>
#include <iostream>
#include <ostream>
#include <fstream>
#include <sys/time.h>
#include <time.h>
using namespace std;
	
#define CASENAME "test5"

#define BLOCKSIZEX 128
#define BLOCKSIZEY 1
#define XDIM 256
#define YDIM 200
#define HALO 3
#define TMAX 50000
#define MAXIT 500
#define MAXRES 0.0001
#define RE 20000
#define UMAX 1.f
#define BETA 0.05f
#define DTAU 0.05f
#define DT 0.1f

#define OBSTD 20.f
#define OBSTX 90.f
#define OBSTY 90.f

#define CONV 1  //1:UDS

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
    output<<"Maximum iterations: \t"<<MAXIT<<endl;
    output<<"Re: \t"<<RE<<endl;
    output<<"uMax: \t"<<UMAX<<endl;
    string scheme;
    if(CONV == 0) scheme = "CDS   ";
    if(CONV == 1) scheme = "UDS   ";
    if(CONV == 2) scheme = "Hybrid";
    if(CONV == 3) scheme = "QUICK ";
    output<<"Convective discretization: \t"<<scheme<<endl;
}


__global__ void ACM_U(float* uA, float* vA, float* Res, float* uB, float* vB, float* pB, float* uC, float* vC, float* uD, float* vD, float nu, int it, int t, size_t pitch)
{
    int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
    int y = threadIdx.y+blockIdx.y*blockDim.y;

    if(x > HALO-2 && x < XDIM-HALO && y > HALO-2 && y < YDIM-HALO){
    float AP_Ue,AE_Ue,AW_Ue,AN_Ue,AS_Ue; //A coeff for East node on u of east face
    float AP_Vn,AE_Vn,AW_Vn,AN_Vn,AS_Vn;
    //float Ae,Aw,An,As;
    float Fe,Fw,Fn,Fs;
    float De,Dw,Dn,Ds;
    float B_Ue,B_Vn;
    Fe = 0.5f*(uB[ x  + y   *pitch]+uB[ x+1+ y   *pitch]);
    Fw = 0.5f*(uB[ x-1+ y   *pitch]+uB[ x  + y   *pitch]);
    Fn = 0.5f*(vB[ x  + y   *pitch]+vB[ x+1+ y   *pitch]);
    Fs = 0.5f*(vB[ x  +(y-1)*pitch]+vB[ x+1+(y-1)*pitch]);
    De = nu; Dw = nu; Dn = nu; Ds = nu;
    AE_Ue = max(-Fe,0.f)+De;
    AW_Ue = max( Fw,0.f)+Dw;
    AN_Ue = max(-Fn,0.f)+Dn;
    AS_Ue = max( Fs,0.f)+Ds;
    AP_Ue = max( Fe,0.f)+max(-Fw,0.f)+max( Fn,0.f)+max(-Fs,0.f)+Dw+De+Dn+Ds;
     B_Ue = (pB[x  +(y  )*pitch]-pB[x+1+(y  )*pitch]);
    uA[ x  + y   *pitch] =( AE_Ue*uB[x+1+(y  )*pitch]+AW_Ue*uB[x-1+(y  )*pitch]
                           +AN_Ue*uB[x  +(y+1)*pitch]+AS_Ue*uB[x  +(y-1)*pitch]
                           -AP_Ue*uB[x  +(y  )*pitch]+ B_Ue
                           -(3.f*uB[x  +(y  )*pitch]-4.f*uC[x  +(y  )*pitch]+uD[x  +(y  )*pitch])*0.5f/DT)*DTAU
                           + uB[x  +(y  )*pitch];
    Fe = 0.5f*(uB[ x  + y   *pitch]+uB[ x  +(y+1)*pitch]);
    Fw = 0.5f*(uB[ x-1+ y   *pitch]+uB[ x-1+(y+1)*pitch]);
    Fn = 0.5f*(vB[ x  + y   *pitch]+vB[ x  +(y+1)*pitch]);
    Fs = 0.5f*(vB[ x  +(y  )*pitch]+vB[ x  +(y-1)*pitch]);
    De = nu; Dw = nu; Dn = nu; Ds = nu;
    AE_Vn = max(-Fe,0.f)+De;
    AW_Vn = max( Fw,0.f)+Dw;
    AN_Vn = max(-Fn,0.f)+Dn;
    AS_Vn = max( Fs,0.f)+Ds;
    AP_Vn = max( Fe,0.f)+max(-Fw,0.f)+max( Fn,0.f)+max(-Fs,0.f)+Dw+De+Dn+Ds;
     B_Vn = (pB[x  +(y  )*pitch]-pB[x  +(y+1)*pitch]);
    vA[ x  + y   *pitch] =( AE_Vn*vB[x+1+(y  )*pitch]+AW_Vn*vB[x-1+(y  )*pitch]
                           +AN_Vn*vB[x  +(y+1)*pitch]+AS_Vn*vB[x  +(y-1)*pitch]
                           -AP_Vn*vB[x  +(y  )*pitch]+ B_Vn
                           -(3.f*vB[x  +(y  )*pitch]-4.f*vC[x  +(y  )*pitch]+vD[x  +(y  )*pitch])*0.5f/DT)*DTAU
                           + vB[x  +(y  )*pitch];
    if(y < HALO)
    {
    vA[ x  + y   *pitch] = 0.f;
    uA[ x  + y   *pitch] = uB[ x  + (y+1)*pitch];
    }
    //if(j == yDim+halo-1)
    if(y > YDIM-HALO-2)
    {
    vA[ x  + y   *pitch] = 0.f;
    uA[ x  + (y  )*pitch] = uB[ x  + (y-1)*pitch];
    }
    if(x < HALO)
    {
    uA[ x  + y   *pitch] = UMAX;
    vA[ x  + y   *pitch] = 0.f;
    }
    if(x > XDIM-HALO-2)
    {
    uA[ x  + y   *pitch] = uB[ x-1+ y   *pitch];
    vA[ x  + y   *pitch] = vB[ x-1+ y   *pitch];//x+1?? probly not
    }


    //if(x == 20 && y == 20)
    //uA[ x  + y   *pitch] = x;
    //vA[ x  + y   *pitch] = y;

    if(x == OBSTX-1 && y>=OBSTY & y<OBSTY+OBSTD)
    uA[ x  + y   *pitch] = 0.f;
    if(x == OBSTX+OBSTD-1 && y>=OBSTY && y<OBSTY+OBSTD)
    uA[ x  + y   *pitch] = 0.f;
    if(y == OBSTY-1 && x>=OBSTX & x<OBSTX+OBSTD)
    vA[ x  + y   *pitch] = 0.f;
    if(y == OBSTY+OBSTD-1 && x>=OBSTX && x<OBSTX+OBSTD)
    vA[ x  + y   *pitch] = 0.f;   

    if(x == OBSTX && y>=OBSTY & y<OBSTY+OBSTD-1)
    vA[ x  + y   *pitch] = -vB[ x-1+ y   *pitch];
    if(x == OBSTX+OBSTD-1 && y>=OBSTY && y<OBSTY+OBSTD-1)
    vA[ x  + y   *pitch] = -vB[ x+1+ y   *pitch];
    if(y == OBSTY && x>=OBSTX & x<OBSTX+OBSTD-1){
    if(t < 200) uA[ x  + y   *pitch] = uB[ x  +(y-1)*pitch];
    else 
    uA[ x  + y   *pitch] = -uB[ x  +(y-1)*pitch];
    }
    if(y == OBSTY+OBSTD-1 && x>=OBSTX && x<OBSTX+OBSTD-1)
    uA[ x  + y   *pitch] = -uB[ x  +(y+1)*pitch];






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

    if(x > HALO-2 && x < XDIM-HALO && y > HALO-2 && y < YDIM-HALO){
    float res = ((uA[ x  + y   *pitch]-uA[ x-1+ y   *pitch])
                                 +(vA[ x  + y   *pitch]-vA[ x  +(y-1)*pitch]));
    pA[ x  + y   *pitch] = -DTAU*res/BETA+pB[ x  + y   *pitch];
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

__global__ void ACM_VelTransfer(float* uD, float* vD, float* uA, float* vA, size_t pitch)
{
    int x = threadIdx.x+blockIdx.x*blockDim.x;//coord in linear mem
    int y = threadIdx.y+blockIdx.y*blockDim.y;
    uD[ x  + y   *pitch] = uA[ x  + y   *pitch];
    vD[ x  + y   *pitch] = vA[ x  + y   *pitch];
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

    if(x >= OBSTX && x<OBSTX+OBSTD && y == OBSTY){
    check[0] = 1;
    sumFY[threadIdx.x] += pA[ x  +(y-1)*pitch];
    if(x<OBSTX+OBSTD-1)
        sumFX[threadIdx.x] -= nu*2.f*uD[ x  +(y  )*pitch];
    }
    if(x >= OBSTX && x<OBSTX+OBSTD && y == OBSTY+OBSTD-1){
    check[0] = 1;
    sumFY[threadIdx.x] -= pA[ x  +(y+1)*pitch];
    if(x<OBSTX+OBSTD-1)
        sumFX[threadIdx.x] -= nu*2.f*uD[ x  +(y  )*pitch];
    }

    if(y >= OBSTY && y<OBSTY+OBSTD && x == OBSTX){
    check[0] = 1;
    sumFX[threadIdx.x] += pA[ x-1+(y  )*pitch];
    if(y<OBSTY+OBSTD-1)
        sumFY[threadIdx.x] -= nu*2.f*vD[ x  +(y  )*pitch];
    }
    if(y >= OBSTY && y<OBSTY+OBSTD && x == OBSTX+OBSTD-1){
    check[0] = 1;
    sumFX[threadIdx.x] -= pA[ x+1+(y  )*pitch];
    if(y<OBSTX+OBSTD-1)
        sumFY[threadIdx.x] -= nu*2.f*vD[ x  +(y  )*pitch];
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
    float nu = UMAX*OBSTD/RE;
    float Ma = UMAX*BETA*BETA;
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
        u[i][j] = 0.f;
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

    dim3 threads(BLOCKSIZEX, BLOCKSIZEY,1);
    dim3 grid  (((XDIM+BLOCKSIZEX-1)/BLOCKSIZEX),((YDIM+BLOCKSIZEY-1)/BLOCKSIZEY),1);
    cudaStream_t compute;
    cudaStream_t transfer;
    cudaStreamCreate(&compute);
    cudaStreamCreate(&transfer);

    float *u_d[4],*v_d[4],*p_d[4], *Res_d, *FX_d, *FY_d;
    for(int i = 0; i<4; i++){
        cudaMalloc((void **) &u_d[i], pitch_e*YDIM*sizeof(float));
        cudaMalloc((void **) &v_d[i], pitch_e*YDIM*sizeof(float));
        cudaMalloc((void **) &p_d[i], pitch_e*YDIM*sizeof(float));
    }
    cudaMalloc((void **) &Res_d, TMAX*sizeof(float));
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

    int A,B,C,D;
    int its;
    A = 0; B = 1; C = 2; D = 3;
    struct timeval tdr0,tdr1;
    double restime;
    cudaDeviceSynchronize();
    gettimeofday (&tdr0,NULL);

    //time loop
    for(int t = 0; t<TMAX; t++){
    for(int it = 0; it<MAXIT; it++){
        if(it > 0)
        cudaMemcpyAsync(&Res[t],&Res_d[t],sizeof(float),cudaMemcpyDeviceToHost,compute);
        ACM_U<<<grid,threads,0,compute>>>(u_d[A],v_d[A],Res_d,u_d[B],v_d[B],p_d[B],u_d[C],v_d[C],u_d[D],v_d[D],nu,it,t,pitch_e);
        cudaStreamSynchronize(compute);
        ACM_P<<<grid,threads,0,compute>>>(p_d[A],Res_d,u_d[A],v_d[A],p_d[B],it,t,pitch_e,u_d[D]);
        cudaDeviceSynchronize();
        if(it > 0){
        //if(sqrt(Res[t])/float((XDIM-2*HALO)*(YDIM-2*HALO)) < MAXRES || it == MAXIT-1){
        if(Res[t]<1 || it == MAXIT-1){
            its = it; it = MAXIT;
        }
        }
        swap(A,B);
    }//end iteration 
    //ACM_VelTransfer<<<grid,threads,0,compute>>>(u_d[C],v_d[C],u_d[A],v_d[A],pitch_e);
    swap(C,D);
    swap(C,A);
    ACM_Forces<<<grid,threads,0,compute>>>(FX_d,FY_d,u_d[C],v_d[C],p_d[A],nu,t,pitch_e);
    cudaMemcpyAsync(&FX[t],&FX_d[t],sizeof(float),cudaMemcpyDeviceToHost,compute);
    cudaMemcpyAsync(&FY[t],&FY_d[t],sizeof(float),cudaMemcpyDeviceToHost,compute);
    if(t%1000==0 && t>0) cout<<"finished time step "<<t<<endl;
    cudaDeviceSynchronize();
    //output_residual<<t<<", "<<its<<", "<<sqrt(Res[t])/((XDIM-2*HALO)*(YDIM-2*HALO))<<endl;
    output_residual<<t<<", "<<its<<", "<<Res[t]<<endl;
    output_force<<t<<", "<<FX[t]<<", "<<FY[t]<<endl;
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
    cudaMemcpy(Res,Res_d,TMAX*sizeof(float),cudaMemcpyDeviceToHost);
    cudaMemcpy(FX,FX_d,TMAX*sizeof(float),cudaMemcpyDeviceToHost);
    cudaMemcpy(FY,FY_d,TMAX*sizeof(float),cudaMemcpyDeviceToHost);


    WriteResults(output_results,u[0],v[0],p[0]);
    WriteResults(output_results,u[3],v[3],p[3]);
    //WriteForces(output_force,FX,FY);


    output_log.close();
    output_results.close();
    output_residual.close();
    output_vel.close();

    return 0;

}
