#include <stdlib.h>
#include <iostream>
#include <fstream>
#include <cmath>
#include <sys/time.h>
#include <time.h>

using namespace std;

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

int xDim,yDim,halo,maxIt,maxrt,method,ObX,ObY,ObD;
float Re,maxRes,uMax,beta,dt,dtr,URF_u,URF_v,URF_p,nu,Ma;

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

//initialize u,v,p arrays
void Initialize(float **u, float **v, float **p, int xDim, int yDim, int halo)
{
    for(int i = 0; i<xDim+2*halo; i++){
    for(int j = 0; j<xDim+2*halo; j++){
        u[i][j] = 0.0f;
        v[i][j] = 0.0f;
        p[i][j] = 0.0f;
    }}
}


void WriteResults(ostream &output, float **u, float **v, float **p, int xDim, int yDim, int halo)
{
    output<<"VARIABLES = \"X\",\"Y\",\"u\",\"v\",\"p\"\n";
    output<<"ZONE F=POINT, I="<<xDim<<", J="<<yDim<<endl;
    float dx = 1;
    float dy = 1;
    float uval,vval,pval;
    for(int j = halo; j<yDim+halo; j++){
    for(int i = halo; i<xDim+halo; i++)
    {
        float xc = 0.5f*dx+(i)*dx;
        float yc = 0.5f*dy+(j)*dy;
        uval = 0.5f*(u[i][j]+u[i-1][j]);
        vval = 0.5f*(v[i][j]+v[i][j-1]);
        pval = p[i][j];
        if(xc>ObX+halo && xc<ObX+ObD+halo && yc>ObY+halo && yc<ObY+ObD+halo)
        {
        uval = 0.f; vval = 0.f; pval = 0.f;
        }
        output<<xc<<", "<<yc<<", "<<uval<<", "<<vval<<", "<<pval<<endl;
    }
    }
}

void WriteResults_collocated(ostream &output, float **u, float **v, float **p, int xDim, int yDim, int halo)
{
    output<<"VARIABLES = \"X\",\"Y\",\"u\",\"v\",\"p\"\n";
    output<<"ZONE F=POINT, I="<<xDim<<", J="<<yDim<<endl;
    float dx = 1;
    float dy = 1;
    for(int i = halo; i<xDim+halo; i++)
    {
    for(int j = halo; j<yDim+halo; j++){
        output<<i<<", "<<j<<", "<<u[i][j]<<", "<<v[i][j]<<", "<<p[i][j]<<endl;
    }
    }
}

void WriteInputs(ostream &output)
{
    output<<"Domain size: \t"<<xDim<<"x"<<yDim<<endl;
    output<<"Halo size: \t"<<halo<<endl;
    output<<"Target residual: \t"<<maxRes<<endl;
    output<<"Maximum iterations: \t"<<maxIt<<endl;
    output<<"Re: \t"<<Re<<endl;
    output<<"uMax: \t"<<uMax<<endl;
    output<<"URF_u: \t"<<URF_u<<endl;
    output<<"URF_v: \t"<<URF_v<<endl;
    string scheme;
    if(method == 0) scheme = "CDS   ";
    if(method == 1) scheme = "UDS   ";
    if(method == 2) scheme = "Hybrid";
    if(method == 3) scheme = "QUICK ";
    output<<"Convective discretization: \t"<<scheme<<endl;
}

void WriteVelocityProfile(ostream &output, float **u, float **v, float **p, int xDim, int yDim, int halo, float uMax)
{
    output<<"v at y=0.5L\n";
    float dx = 1;
    float dy = 1;
    int ym = yDim/2-1; //p-node below half way line. v[i][ym] will be exactly at the half way line.
    float maxval = -10000.f;
    float minval =  10000.f;
    for(int i = halo; i<xDim+halo; i++)
    {
        float xcoord = ((i-halo)*dx+0.5f*dx)/xDim; //normalized xcoord
        output<<xcoord<<", "<<v[i][ym]/uMax<<endl;
        if(v[i][ym]>maxval) maxval = v[i][ym];
        if(v[i][ym]<minval) minval = v[i][ym];
    }
    output<<"\nmax v: "<<maxval<<endl;
    output<<  "min v: "<<minval<<endl<<endl;
    output<<"u at x=0.5L\n";
    int xm = xDim/2-1; //p-node left of half way line. u[xm][i] will be exactly at the half way line.
    maxval = -10000.f;
    minval =  10000.f;
    for(int i = halo; i<yDim+halo; i++)
    {
        float ycoord = ((i-halo)*dy+0.5f*dy)/yDim; //normalized ycoord
        output<<ycoord<<", "<<u[xm][i]/uMax<<endl;
        if(u[xm][i]>maxval) maxval = u[xm][i];
        if(u[xm][i]<minval) minval = u[xm][i];
    }
    output<<"\nmax u: "<<maxval<<endl;
    output<<  "min u: "<<minval<<endl<<endl;
}



/*
ACM by Chorin (1967) on collocated grids using leap-frog based finite difference scheme. cm~0.0001f, dt~0.00001f for 40x40 Re=100
*/
void ACM1(float ***u, float ***v, float ***p, int xDim, int yDim, int halo, int tMax, float Re, float cm, float maxRes, float dt, ofstream &output_res)
{
    int A,B,C; A=0,B=1,C=2;
    //float cm = 0.001f;

    //float dt = .0005f;
    float dx = 1.f/xDim;
    float dy = 1.f/yDim;
    float maxdp = -10000.f;
    
    for(int t = 0; t<tMax; t++){
    maxdp = -10000.f;
    for(int i = halo; i<xDim+halo; i++){
    for(int j = halo; j<yDim+halo; j++){
        u[A][i][j] = -Re*dt/dx*(u[B][i+1][j  ]*u[B][i+1][j  ]-u[B][i-1][j  ]*u[B][i-1][j  ])
                     -Re*dt/dy*(u[B][i  ][j+1]*v[B][i  ][j+1]-u[B][i  ][j-1]*v[B][i  ][j-1])
                     +2.f*dt/dx/dx*(u[B][i+1][j  ]+u[B][i-1][j  ]-u[C][i  ][j  ])
                     +2.f*dt/dy/dy*(u[B][i  ][j+1]+u[B][i  ][j-1]-u[C][i  ][j  ])
                     -dt/dx   *(p[B][i+1][j  ]-p[B][i-1][j  ])
                     +u[C][i  ][j  ];
        u[A][i][j]/= (1.f+2.f*dt/dx/dx+2.f*dt/dy/dy);
        v[A][i][j] = -Re*dt/dy*(v[B][i  ][j+1]*v[B][i  ][j+1]-v[B][i  ][j-1]*v[B][i  ][j-1])
                     -Re*dt/dx*(v[B][i+1][j  ]*u[B][i+1][j  ]-v[B][i-1][j  ]*u[B][i-1][j  ])
                     +2.f*dt/dx/dx*(v[B][i+1][j  ]+v[B][i-1][j  ]-v[C][i  ][j  ])
                     +2.f*dt/dy/dy*(v[B][i  ][j+1]+v[B][i  ][j-1]-v[C][i  ][j  ])
                     -dt/dy   *(p[B][i  ][j+1]-p[B][i  ][j-1])
                     +v[C][i  ][j  ];
        v[A][i][j]/= (1.f+2.f*dt/dx/dx+2.f*dt/dy/dy);
        float dudx, dvdy;

        dudx = dt/dx*(u[B][i+1][j]-u[B][i-1][j]);
        dvdy = dt/dy*(v[B][i][j+1]-v[B][i][j-1]);
        if(j == halo)
        {
        dvdy = 2.f*dt/dy*(v[B][i][j+1]-v[B][i][j]);
        u[A][i][j] = 0.f;
        v[A][i][j] = 0.f;
        }
        if(j == yDim+halo-1)
        {
        dvdy = 2.f*dt/dy*(v[B][i][j]-v[B][i][j-1]);
        u[A][i][j] = 1.f;
        v[A][i][j] = 0.f;
        }
        if(i == halo)
        {
        dudx = 2.f*dt/dx*(u[B][i+1][j]-u[B][i][j]);
        u[A][i][j] = 0.f;
        v[A][i][j] = 0.f;
        }
        if(i == xDim+halo-1)
        {
        dudx = 2.f*dt/dx*(u[B][i][j]-u[B][i-1][j]);
        u[A][i][j] = 0.f;
        v[A][i][j] = 0.f;
        }

        p[A][i][j] = -dudx-dvdy
                     +p[C][i  ][j  ]*cm;
        p[A][i][j]/= cm;

        if(abs(dudx+dvdy)>maxdp && (i > halo && j > halo && i < xDim+halo-1 && j < yDim+halo-1))
        {
        maxdp = abs(dudx+dvdy);
        }

        if(u[A][i][j] > 10000){
        cout<<"exploded at "<<t<<endl;
        t = tMax;
        }


    }
    }

    output_res<<t<<", "<<maxdp/dt<<endl;

    swap(A,C);
    swap(B,A);
    
    if(maxdp/dt < maxRes && t>6){
    cout<<"converged to: "<<maxdp<<"at t = "<<t<<endl;
    t = tMax;
    }
    //cout<<t<<","<<v[0][41][4]<<","<<v[0][40][4]<<","<<v[0][41][5]<<","<<v[0][40][5]<<","<<v[0][41][3]<<endl;

    }

    cout<<"final res: "<<maxdp/dt<<endl;




}


/*
ACM on staggered grids, using explcit euler
*/
void ACM2(float ***u, float ***v, float ***p, int xDim, int yDim, int halo, int tMax, float Re, float cm, float maxRes, float dt, ofstream &output_res, ofstream &output_results)
{
    int A,B,C; A=0,B=1,C=2;
    //float cm = 0.001f;

    //float dt = .0005f;
    float dx = 1.f/xDim;
    float dy = 1.f/yDim;
    float maxdp = -10000.f;
    float AP_Ue,AE_Ue,AW_Ue,AN_Ue,AS_Ue; //A coeff for East node on u of east face
    float AP_Vn,AE_Vn,AW_Vn,AN_Vn,AS_Vn;
    float Ae,Aw,An,As;
    float Fe,Fw,Fn,Fs;
    float De,Dw,Dn,Ds;
    float B_Ue,B_Vn;
    float nu = 1.f/Re;
    
    for(int t = 0; t<tMax; t++){
    maxdp = -10000.f;
    for(int i = halo-1; i<xDim+halo; i++){
    for(int j = halo-1; j<yDim+halo; j++){
        Ae = 1.f; Aw = 1.f; An = 1.f; As = 1.f;
        Fe = 0.5f*(u[B][i  ][j  ]+u[B][i+1][j  ])*Ae;
        Fw = 0.5f*(u[B][i-1][j  ]+u[B][i  ][j  ])*Aw;
        Fn = 0.5f*(v[B][i  ][j  ]+v[B][i+1][j  ])*An;
        Fs = 0.5f*(v[B][i  ][j-1]+v[B][i+1][j-1])*As;
        De = nu*Ae/dx; Dw = nu*Aw/dx; Dn = nu*An/dy; Ds = nu*As/dy;
        AE_Ue = max(-Fe,0.f)+De;
        AW_Ue = max( Fw,0.f)+Dw;
        AN_Ue = max(-Fn,0.f)+Dn;
        AS_Ue = max( Fs,0.f)+Ds;
        AP_Ue = max( Fe,0.f)+max(-Fw,0.f)+max( Fn,0.f)+max(-Fs,0.f)+Dw+De+Dn+Ds;       
         B_Ue = Ae*(p[B][i][j]-p[B][i+1][j]);
        u[A][i][j] =( AE_Ue*u[B][i+1][j  ]+AW_Ue*u[B][i-1][j  ]
                     +AN_Ue*u[B][i  ][j+1]+AS_Ue*u[B][i  ][j-1]
                     -AP_Ue*u[B][i  ][j  ]+ B_Ue)*dt
                     +u[B][i  ][j  ];

        Fe = 0.5f*(u[B][i  ][j  ]+u[B][i  ][j+1])*Ae;
        Fw = 0.5f*(u[B][i-1][j  ]+u[B][i-1][j+1])*Aw;
        Fn = 0.5f*(v[B][i  ][j  ]+v[B][i  ][j+1])*An;
        Fs = 0.5f*(v[B][i  ][j  ]+v[B][i  ][j-1])*As;
        De = nu*Ae/dx; Dw = nu*Aw/dx; Dn = nu*An/dy; Ds = nu*As/dy;
        AE_Vn = max(-Fe,0.f)+De;
        AW_Vn = max( Fw,0.f)+Dw;
        AN_Vn = max(-Fn,0.f)+Dn;
        AS_Vn = max( Fs,0.f)+Ds;
        AP_Vn = max( Fe,0.f)+max(-Fw,0.f)+max( Fn,0.f)+max(-Fs,0.f)+Dw+De+Dn+Ds;       
         B_Vn = An*(p[B][i][j]-p[B][i][j+1]);
        v[A][i][j] = (AE_Vn*v[B][i+1][j  ]+AW_Vn*v[B][i-1][j  ]
                     +AN_Vn*v[B][i  ][j+1]+AS_Vn*v[B][i  ][j-1]
                     -AP_Vn*v[B][i  ][j  ]+ B_Vn)*dt
                     +v[B][i  ][j  ];

        p[A][i][j] = -dt*((u[A][i][j]-u[A][i-1][j])/dx+(v[A][i][j]-v[A][i][j-1])/dy)/cm+p[B][i][j];

        if(j == halo)
        {
        v[A][i][j] = 0.f;
        }
        if(j == yDim+halo-1)
        {
        v[A][i][j] = 0.f;
        }
        if(i == halo)
        {
        u[A][i][j] = 0.f;
        }
        if(i == xDim+halo-1)
        {
        u[A][i][j] = 0.f;
        }


        if(abs(p[A][i][j]-p[B][i][j])>maxdp && (i > halo && j > halo && i < xDim+halo-1 && j < yDim+halo-1))
        {
        maxdp = abs(p[A][i][j]-p[B][i][j]);
        }

        if(u[A][i][j] > 10000){
        cout<<"exploded at "<<t<<endl;
        t = tMax;
        }


    }
    }

    //set tangential velocities on horizontal boundaries
    for(int i = halo; i<xDim+halo; i++) 
    {
    for(int j = 0; j<halo; j++)
    {
    u[A][i][yDim+halo+j] = 2.f-u[A][i][yDim+halo-1];
    u[A][i][j] = -u[A][i][halo];
    }
    }
    //set tangential velocities on vertical boundaries
    for(int i = halo; i<yDim+halo; i++) 
    {
    for(int j = 0; j<halo; j++)
    {
    v[A][xDim+halo+j][i] = -v[A][xDim+halo-1][i];
    v[A][j][i] = -v[A][halo][i];
    }
    }   

    output_res<<t<<", "<<maxdp/dt<<endl;

    swap(B,A);
    
    if(maxdp/dt < maxRes && t>6){
    cout<<"converged to: "<<maxdp/dt<<"at t = "<<t<<endl;
    t = tMax;
    }
    //cout<<t<<","<<v[0][41][4]<<","<<v[0][40][4]<<","<<v[0][41][5]<<","<<v[0][40][5]<<","<<v[0][41][3]<<endl;

    if (t%1000 == 0)
    WriteResults(output_results,u[A],v[A],p[A],xDim,yDim,halo);
    
    }//end iteration

    cout<<"final res: "<<maxdp/dt<<endl;






}

/*
ACM on staggered grids, explicit euler for flow over cylinder
*/
void ACM3(float ***u, float ***v, float ***p, ofstream &output_res, ofstream &output_results)
{
    int A,B,C; A=0,B=1,C=2;
    //float cm = 0.001f;

    //float dt = .0005f;
    float dx = 1.f;///ObD;
    float dy = 1.f;///ObD;
    float maxdp = -10000.f;
    float AP_Ue,AE_Ue,AW_Ue,AN_Ue,AS_Ue; //A coeff for East node on u of east face
    float AP_Vn,AE_Vn,AW_Vn,AN_Vn,AS_Vn;
    float Ae,Aw,An,As;
    float Fe,Fw,Fn,Fs;
    float De,Dw,Dn,Ds;
    float B_Ue,B_Vn;

    //v[B][10][20] = 0.5f;
    
    for(int t = 0; t<maxIt; t++){
    maxdp = -10000.f;
    for(int i = halo-1; i<xDim+halo; i++){
    for(int j = halo-1; j<yDim+halo; j++){
        if(j == halo-1)
        {
        v[A][i][j] = 0.f;
        }
        if(j == yDim+halo-1)
        {
        v[A][i][j] = 0.f;
        }
        if(i == halo-1)
        {
        u[A][i][j] = uMax;
        }
        if(i == xDim+halo-1)
        {
        u[A][i][j] = u[A][i-1][j];
        }
        
        if(i == halo+ObX-1 && j>=halo+ObY && j<halo+ObY+ObD)
        u[A][i][j] = 0.f;
        if(i == halo+ObX+ObD-1 && j>=halo+ObY && j<halo+ObY+ObD)
        u[A][i][j] = 0.f;
        if(j == halo+ObY-1 && i>=halo+ObX && i<halo+ObX+ObD)
        v[A][i][j] = 0.f;
        if(j == halo+ObY+ObD-1 && i>=halo+ObX && i<halo+ObX+ObD)
        v[A][i][j] = 0.f;

        //Ae = 1.f; Aw = 1.f; An = 1.f; As = 1.f;
        Ae = dy; Aw = dy; An = dx; As = dx;
        Fe = 0.5f*(u[B][i  ][j  ]+u[B][i+1][j  ])*Ae;
        Fw = 0.5f*(u[B][i-1][j  ]+u[B][i  ][j  ])*Aw;
        Fn = 0.5f*(v[B][i  ][j  ]+v[B][i+1][j  ])*An;
        Fs = 0.5f*(v[B][i  ][j-1]+v[B][i+1][j-1])*As;
        De = nu*Ae/dx; Dw = nu*Aw/dx; Dn = nu*An/dy; Ds = nu*As/dy;
        AE_Ue = max(-Fe,0.f)+De;
        AW_Ue = max( Fw,0.f)+Dw;
        AN_Ue = max(-Fn,0.f)+Dn;
        AS_Ue = max( Fs,0.f)+Ds;
        AP_Ue = max( Fe,0.f)+max(-Fw,0.f)+max( Fn,0.f)+max(-Fs,0.f)+Dw+De+Dn+Ds;       
         B_Ue = Ae*(p[B][i][j]-p[B][i+1][j]);
        u[A][i][j] =( AE_Ue*u[B][i+1][j  ]+AW_Ue*u[B][i-1][j  ]
                     +AN_Ue*u[B][i  ][j+1]+AS_Ue*u[B][i  ][j-1]
                     -AP_Ue*u[B][i  ][j  ]+ B_Ue)*dt
                     +u[B][i  ][j  ];

        Fe = 0.5f*(u[B][i  ][j  ]+u[B][i  ][j+1])*Ae;
        Fw = 0.5f*(u[B][i-1][j  ]+u[B][i-1][j+1])*Aw;
        Fn = 0.5f*(v[B][i  ][j  ]+v[B][i  ][j+1])*An;
        Fs = 0.5f*(v[B][i  ][j  ]+v[B][i  ][j-1])*As;
        De = nu*Ae/dx; Dw = nu*Aw/dx; Dn = nu*An/dy; Ds = nu*As/dy;
        AE_Vn = max(-Fe,0.f)+De;
        AW_Vn = max( Fw,0.f)+Dw;
        AN_Vn = max(-Fn,0.f)+Dn;
        AS_Vn = max( Fs,0.f)+Ds;
        AP_Vn = max( Fe,0.f)+max(-Fw,0.f)+max( Fn,0.f)+max(-Fs,0.f)+Dw+De+Dn+Ds;       
         B_Vn = An*(p[B][i][j]-p[B][i][j+1]);
        v[A][i][j] = (AE_Vn*v[B][i+1][j  ]+AW_Vn*v[B][i-1][j  ]
                     +AN_Vn*v[B][i  ][j+1]+AS_Vn*v[B][i  ][j-1]
                     -AP_Vn*v[B][i  ][j  ]+ B_Vn)*dt
                     +v[B][i  ][j  ];



        if(j == halo-1)
        {
        v[A][i][j] = 0.f;
        }
        if(j == yDim+halo-1)
        {
        v[A][i][j] = 0.f;
        }
        if(i == halo-1)
        {
        u[A][i][j] = uMax;
        }
        if(i == xDim+halo-1)
        {
        u[A][i][j] = u[A][i-1][j];
        }
        
        if(i == halo+ObX-1 && j>=halo+ObY && j<halo+ObY+ObD)
        u[A][i][j] = 0.f;
        if(i == halo+ObX+ObD-1 && j>=halo+ObY && j<halo+ObY+ObD)
        u[A][i][j] = 0.f;
        if(j == halo+ObY-1 && i>=halo+ObX && i<halo+ObX+ObD)
        v[A][i][j] = 0.f;
        if(j == halo+ObY+ObD-1 && i>=halo+ObX && i<halo+ObX+ObD)
        v[A][i][j] = 0.f;



        p[A][i][j] = -dt*(dy*(u[A][i][j]-u[A][i-1][j])/dx+dx*(v[A][i][j]-v[A][i][j-1])/dy)/beta+p[B][i][j];

        if(abs(p[A][i][j]-p[B][i][j])>maxdp && (i > halo && j > halo && i < xDim+halo-1 && j < yDim+halo-1))
        {
        maxdp = abs(p[A][i][j]-p[B][i][j]);
        }

        if(u[A][i][j] > 10000){
        cout<<"exploded at "<<t<<endl;
        t = maxIt;
        }


    }
    }

    //set tangential velocities on horizontal boundaries
    for(int i = halo; i<xDim+halo; i++) 
    {
    for(int j = 0; j<halo; j++)
    {
    u[A][i][yDim+halo+j] = u[A][i][yDim+halo-1];
    u[A][i][j] = u[A][i][halo];
    v[A][i][yDim+halo+j] = 0.f;
    v[A][i][j] = 0.f;
    }
    }
    //set tangential velocities on vertical boundaries
    for(int i = halo; i<yDim+halo; i++) 
    {
    for(int j = 0; j<halo; j++)
    {
    v[A][xDim+halo+j][i] = v[A][xDim+halo-1][i];
    v[A][j][i] = 0.f;
    u[A][xDim+halo+j][i] = u[A][xDim+halo-1][i];
    u[A][j][i] = uMax;
    }
    }
    //set tangential velocities on square cylinder
    for(int i = halo+ObX; i<halo+ObX+ObD-1; i++){
    u[A][i][halo+ObY      ] = -u[A][i][halo+ObY    -1];
    u[A][i][halo+ObY+ObD-1] = -u[A][i][halo+ObY+ObD  ];
    //v[A][i][halo+ObY      ] = 0.f;
    //v[A][i][halo+ObY+ObD-1] = 0.f;
    }
    for(int i = halo+ObY; i<halo+ObY+ObD-1; i++){
    v[A][halo+ObX      ][i] = -v[A][halo+ObX    -1][i];
    v[A][halo+ObX+ObD-1][i] = -v[A][halo+ObX+ObD  ][i];
    //u[A][halo+ObX      ][i] = 0.f;
    //u[A][halo+ObX+ObD-1][i] = 0.f;
    }

    output_res<<t<<", "<<maxdp/dt<<endl;

    swap(B,A);
    
    if(maxdp/dt < maxRes && t>6){
    cout<<"converged to: "<<maxdp/dt<<"at t = "<<t<<endl;
    t = maxIt;
    }
    //cout<<t<<","<<v[0][41][4]<<","<<v[0][40][4]<<","<<v[0][41][5]<<","<<v[0][40][5]<<","<<v[0][41][3]<<endl;

    if (t%1000 == 0)
    WriteResults(output_results,u[A],v[A],p[A],xDim,yDim,halo);
    
    }//end iteration

    cout<<"final res: "<<maxdp/dt<<endl;

    float FX = 0;
    float FY = 0;
    //calculate pressure forces
    for(int i = halo+ObX; i<halo+ObX+ObD; i++){
    FY += dx*p[A][i][ObY+halo-1];
    FY -= dx*p[A][i][ObY+halo+ObD];
    }
    for(int j = halo+ObY; j<halo+ObY+ObD; j++){
    FX += dy*p[A][ObX+halo-1]  [j];
    FX -= dy*p[A][ObX+halo+ObD][j];
    }
    cout<<FX*2.f<<", "<<FY*2.f<<endl;
    //calculate shear forces
    for(int i = halo+ObX; i<halo+ObX+ObD-1; i++){
    FX -= dx*nu*2.f*u[A][i][ObY+halo]    /dy;
    FX -= dx*nu*2.f*u[A][i][ObY+halo+ObD-1]/dy;
    }
    for(int j = halo+ObY; j<halo+ObY+ObD-1; j++){
    FY -= dy*nu*2.f*v[A][ObX+halo]    [j]/dx;
    FY -= dy*nu*2.f*v[A][ObX+halo+ObD-1][j]/dx;
    }

    cout<<FX*2.f<<", "<<FY*2.f<<endl;




}


/*
ACM on staggered grids, RK2 for flow over cylinder
*/
void ACM4(float ***u, float ***v, float ***p, ofstream &output_res, ofstream &output_results)
{
    int A,B,C; A=0,B=1,C=2;
    //float cm = 0.001f;

    //float dt = .0005f;
    float dx = 1.f/ObD;
    float dy = 1.f/ObD;
    float maxdp = -10000.f;
    float AP_Ue,AE_Ue,AW_Ue,AN_Ue,AS_Ue; //A coeff for East node on u of east face
    float AP_Vn,AE_Vn,AW_Vn,AN_Vn,AS_Vn;
    float Ae,Aw,An,As;
    float Fe,Fw,Fn,Fs;
    float De,Dw,Dn,Ds;
    float B_Ue,B_Vn;
    float nu = 1.f/Re;

    //v[B][10][20] = 0.5f;
    
    for(int t = 0; t<maxIt; t++){
    maxdp = -10000.f;
    for(int i = halo-1; i<xDim+halo; i++){
    for(int j = halo-1; j<yDim+halo; j++){
        //Ae = 1.f; Aw = 1.f; An = 1.f; As = 1.f;
        Ae = dy; Aw = dy; An = dx; As = dx;
        Fe = 0.5f*(u[B][i  ][j  ]+u[B][i+1][j  ])*Ae;
        Fw = 0.5f*(u[B][i-1][j  ]+u[B][i  ][j  ])*Aw;
        Fn = 0.5f*(v[B][i  ][j  ]+v[B][i+1][j  ])*An;
        Fs = 0.5f*(v[B][i  ][j-1]+v[B][i+1][j-1])*As;
        De = nu*Ae/dx; Dw = nu*Aw/dx; Dn = nu*An/dy; Ds = nu*As/dy;
        AE_Ue = max(-Fe,0.f)+De;
        AW_Ue = max( Fw,0.f)+Dw;
        AN_Ue = max(-Fn,0.f)+Dn;
        AS_Ue = max( Fs,0.f)+Ds;
        AP_Ue = max( Fe,0.f)+max(-Fw,0.f)+max( Fn,0.f)+max(-Fs,0.f)+Dw+De+Dn+Ds;       
         B_Ue = Ae*(p[B][i][j]-p[B][i+1][j]);
        u[A][i][j] =( AE_Ue*u[B][i+1][j  ]+AW_Ue*u[B][i-1][j  ]
                     +AN_Ue*u[B][i  ][j+1]+AS_Ue*u[B][i  ][j-1]
                     -AP_Ue*u[B][i  ][j  ]+ B_Ue)*dt*0.5f
                     +u[B][i  ][j  ];

        Fe = 0.5f*(u[B][i  ][j  ]+u[B][i  ][j+1])*Ae;
        Fw = 0.5f*(u[B][i-1][j  ]+u[B][i-1][j+1])*Aw;
        Fn = 0.5f*(v[B][i  ][j  ]+v[B][i  ][j+1])*An;
        Fs = 0.5f*(v[B][i  ][j  ]+v[B][i  ][j-1])*As;
        De = nu*Ae/dx; Dw = nu*Aw/dx; Dn = nu*An/dy; Ds = nu*As/dy;
        AE_Vn = max(-Fe,0.f)+De;
        AW_Vn = max( Fw,0.f)+Dw;
        AN_Vn = max(-Fn,0.f)+Dn;
        AS_Vn = max( Fs,0.f)+Ds;
        AP_Vn = max( Fe,0.f)+max(-Fw,0.f)+max( Fn,0.f)+max(-Fs,0.f)+Dw+De+Dn+Ds;       
         B_Vn = An*(p[B][i][j]-p[B][i][j+1]);
        v[A][i][j] = (AE_Vn*v[B][i+1][j  ]+AW_Vn*v[B][i-1][j  ]
                     +AN_Vn*v[B][i  ][j+1]+AS_Vn*v[B][i  ][j-1]
                     -AP_Vn*v[B][i  ][j  ]+ B_Vn)*dt*0.5f
                     +v[B][i  ][j  ];


        if(j == halo-1)
        {
        v[A][i][j] = 0.f;
        }
        if(j == yDim+halo-1)
        {
        v[A][i][j] = 0.f;
        }
        if(i == halo-1)
        {
        u[A][i][j] = uMax;
        }
        if(i == xDim+halo-1)
        {
        u[A][i][j] = u[A][i-1][j];
        }
        
        if(i == halo+ObX && j>=halo+ObY && j<halo+ObY+ObD)
        v[A][i][j] = 0.f;
        if(i == halo+ObX+ObD-1 && j>=halo+ObY && j<halo+ObY+ObD)
        v[A][i][j] = 0.f;
        if(j == halo+ObY && i>=halo+ObX && j<halo+ObX+ObD)
        u[A][i][j] = 0.f;
        if(j == halo+ObY+ObD-1 && i>=halo+ObX && j<halo+ObX+ObD)
        u[A][i][j] = 0.f;



        p[A][i][j] = -dt*0.5f*((u[A][i][j]-u[A][i-1][j])/dx+(v[A][i][j]-v[A][i][j-1])/dy)/beta+p[B][i][j];

//        if(abs(p[A][i][j]-p[B][i][j])>maxdp && (i > halo && j > halo && i < xDim+halo-1 && j < yDim+halo-1))
//        {
//        maxdp = abs(p[A][i][j]-p[B][i][j]);
//        }

        if(u[A][i][j] > 10000){
        cout<<"exploded at "<<t<<endl;
        t = maxIt;
        }


    }
    }


    //set tangential velocities on horizontal boundaries
    for(int i = halo; i<xDim+halo; i++) 
    {
    for(int j = 0; j<halo; j++)
    {
    u[A][i][yDim+halo+j] = u[A][i][yDim+halo-1];
    u[A][i][j] = u[A][i][halo];
    v[A][i][yDim+halo+j] = 0.f;
    v[A][i][j] = 0.f;
    }
    }
    //set tangential velocities on vertical boundaries
    for(int i = halo; i<yDim+halo; i++) 
    {
    for(int j = 0; j<halo; j++)
    {
    v[A][xDim+halo+j][i] = v[A][xDim+halo-1][i];
    v[A][j][i] = 0.f;
    u[A][xDim+halo+j][i] = u[A][xDim+halo-1][i];
    u[A][j][i] = uMax;
    }
    }
    //set tangential velocities on square cylinder
    for(int i = halo+ObX; i<halo+ObX+ObD-1; i++){
    u[A][i][halo+ObY      ] = -u[A][i][halo+ObY    -1];
    u[A][i][halo+ObY+ObD-1] = -u[A][i][halo+ObY+ObD  ];
    //v[A][i][halo+ObY      ] = 0.f;
    //v[A][i][halo+ObY+ObD-1] = 0.f;
    }
    for(int i = halo+ObY; i<halo+ObY+ObD-1; i++){
    v[A][halo+ObX      ][i] = -v[A][halo+ObX    -1][i];
    v[A][halo+ObX+ObD-1][i] = -v[A][halo+ObX+ObD  ][i];
    //u[A][halo+ObX      ][i] = 0.f;
    //u[A][halo+ObX+ObD-1][i] = 0.f;
    }



    for(int i = halo-1; i<xDim+halo; i++){
    for(int j = halo-1; j<yDim+halo; j++){
        //Ae = 1.f; Aw = 1.f; An = 1.f; As = 1.f;
        Ae = dy; Aw = dy; An = dx; As = dx;
        Fe = 0.5f*(u[A][i  ][j  ]+u[A][i+1][j  ])*Ae;
        Fw = 0.5f*(u[A][i-1][j  ]+u[A][i  ][j  ])*Aw;
        Fn = 0.5f*(v[A][i  ][j  ]+v[A][i+1][j  ])*An;
        Fs = 0.5f*(v[A][i  ][j-1]+v[A][i+1][j-1])*As;
        De = nu*Ae/dx; Dw = nu*Aw/dx; Dn = nu*An/dy; Ds = nu*As/dy;
        AE_Ue = max(-Fe,0.f)+De;
        AW_Ue = max( Fw,0.f)+Dw;
        AN_Ue = max(-Fn,0.f)+Dn;
        AS_Ue = max( Fs,0.f)+Ds;
        AP_Ue = max( Fe,0.f)+max(-Fw,0.f)+max( Fn,0.f)+max(-Fs,0.f)+Dw+De+Dn+Ds;       
         B_Ue = Ae*(p[A][i][j]-p[A][i+1][j]);
        u[B][i][j] =( AE_Ue*u[A][i+1][j  ]+AW_Ue*u[A][i-1][j  ]
                     +AN_Ue*u[A][i  ][j+1]+AS_Ue*u[A][i  ][j-1]
                     -AP_Ue*u[A][i  ][j  ]+ B_Ue)*dt
                     +u[B][i  ][j  ];

        Fe = 0.5f*(u[A][i  ][j  ]+u[A][i  ][j+1])*Ae;
        Fw = 0.5f*(u[A][i-1][j  ]+u[A][i-1][j+1])*Aw;
        Fn = 0.5f*(v[A][i  ][j  ]+v[A][i  ][j+1])*An;
        Fs = 0.5f*(v[A][i  ][j  ]+v[A][i  ][j-1])*As;
        De = nu*Ae/dx; Dw = nu*Aw/dx; Dn = nu*An/dy; Ds = nu*As/dy;
        AE_Vn = max(-Fe,0.f)+De;
        AW_Vn = max( Fw,0.f)+Dw;
        AN_Vn = max(-Fn,0.f)+Dn;
        AS_Vn = max( Fs,0.f)+Ds;
        AP_Vn = max( Fe,0.f)+max(-Fw,0.f)+max( Fn,0.f)+max(-Fs,0.f)+Dw+De+Dn+Ds;       
         B_Vn = An*(p[A][i][j]-p[A][i][j+1]);
        v[B][i][j] = (AE_Vn*v[A][i+1][j  ]+AW_Vn*v[A][i-1][j  ]
                     +AN_Vn*v[A][i  ][j+1]+AS_Vn*v[A][i  ][j-1]
                     -AP_Vn*v[A][i  ][j  ]+ B_Vn)*dt
                     +v[B][i  ][j  ];


        if(j == halo-1)
        {
        v[A][i][j] = 0.f;
        }
        if(j == yDim+halo-1)
        {
        v[A][i][j] = 0.f;
        }
        if(i == halo-1)
        {
        u[A][i][j] = uMax;
        }
        if(i == xDim+halo-1)
        {
        u[A][i][j] = u[A][i-1][j];
        }
        
        if(i == halo+ObX-1 && j>=halo+ObY && j<halo+ObY+ObD)
        u[A][i][j] = 0.f;
        if(i == halo+ObX+ObD-1 && j>=halo+ObY && j<halo+ObY+ObD)
        u[A][i][j] = 0.f;
        if(j == halo+ObY-1 && i>=halo+ObX && i<halo+ObX+ObD)
        v[A][i][j] = 0.f;
        if(j == halo+ObY+ObD-1 && i>=halo+ObX && i<halo+ObX+ObD)
        v[A][i][j] = 0.f;





        p[B][i][j] = -dt*((u[B][i][j]-u[B][i-1][j])/dx+(v[B][i][j]-v[B][i][j-1])/dy)/beta+p[B][i][j];

        float res = abs(dt*((u[B][i][j]-u[B][i-1][j])/dx+(v[B][i][j]-v[B][i][j-1])/dy)/beta);
        if(res>maxdp && (i > halo && j > halo && i < xDim+halo-1 && j < yDim+halo-1))
        {
        maxdp = res;
        }

        if(u[B][i][j] > 10000){
        cout<<"exploded at "<<t<<endl;
        t = maxIt;
        }


    }
    }


    //set tangential velocities on horizontal boundaries
    for(int i = halo; i<xDim+halo; i++) 
    {
    for(int j = 0; j<halo; j++)
    {
    u[B][i][yDim+halo+j] = u[B][i][yDim+halo-1];
    u[B][i][j] = u[B][i][halo];
    v[B][i][yDim+halo+j] = 0.f;
    v[B][i][j] = 0.f;
    }
    }
    //set tangential velocities on vertical boundaries
    for(int i = halo; i<yDim+halo; i++) 
    {
    for(int j = 0; j<halo; j++)
    {
    v[B][xDim+halo+j][i] = v[B][xDim+halo-1][i];
    v[B][j][i] = 0.f;
    u[B][xDim+halo+j][i] = u[B][xDim+halo-1][i];
    u[B][j][i] = uMax;
    }
    }
    for(int i = halo+ObX; i<halo+ObX+ObD; i++){
    u[B][i][halo+ObY      ] = -u[B][i][halo+ObY    -1];
    u[B][i][halo+ObY+ObD-1] = -u[B][i][halo+ObY+ObD  ];
    v[B][i][halo+ObY      ] = 0.f;
    v[B][i][halo+ObY+ObD-1] = 0.f;
    }
    for(int i = halo+ObY; i<halo+ObY+ObD; i++){
    v[B][halo+ObX      ][i] = -v[B][halo+ObX    -1][i];
    v[B][halo+ObX+ObD-1][i] = -v[B][halo+ObX+ObD  ][i];
    u[B][halo+ObX      ][i] = 0.f;
    u[B][halo+ObX+ObD-1][i] = 0.f;
    }

    output_res<<t<<", "<<maxdp/dt<<endl;

    //swap(B,A);
    
    if(maxdp/dt < maxRes && t>6){
    cout<<"converged to: "<<maxdp/dt<<"at t = "<<t<<endl;
    t = maxIt;
    }
    //cout<<t<<","<<v[0][41][4]<<","<<v[0][40][4]<<","<<v[0][41][5]<<","<<v[0][40][5]<<","<<v[0][41][3]<<endl;

    if (t%1000 == 0)
    WriteResults(output_results,u[A],v[A],p[A],xDim,yDim,halo);
    
    }//end iteration

    cout<<"final res: "<<maxdp/dt<<endl;






}


/*
ACM on staggered grids, flow over cylinder in dual time (1st order implicit for real time, 1st order explicit for pseudo time)
*/
void ACM5(float ***u, float ***v, float ***p, ofstream &output_res, ofstream &output_results, ofstream &output_force)
{
    int A,B,C,D; A=0,B=1,C=2,D=3;
    //float cm = 0.001f;

    //float dt = .0005f;
    float dx = 1.f;///ObD;
    float dy = 1.f;///ObD;
    float maxdp = -10000.f;
    float AP_Ue,AE_Ue,AW_Ue,AN_Ue,AS_Ue; //A coeff for East node on u of east face
    float AP_Vn,AE_Vn,AW_Vn,AN_Vn,AS_Vn;
    float Ae,Aw,An,As;
    float Fe,Fw,Fn,Fs;
    float De,Dw,Dn,Ds;
    float B_Ue,B_Vn;
    //float nu = 1.f/Re;


    for(int i = halo-1; i<xDim+halo; i++){
    for(int j = halo-1; j<xDim+halo; j++){
        u[C][i][j] = u[B][i][j];
        v[C][i][j] = v[B][i][j];
        p[C][i][j] = p[B][i][j];
    }}

    
    for(int rt = 0; rt<maxrt; rt++){
    for(int t = 0; t<maxIt; t++){
    maxdp = -10000.f;
    swap(B,A);
    //swap(D,C);
    for(int i = halo-1; i<xDim+halo; i++){
    for(int j = halo-1; j<yDim+halo; j++){
        Ae = dy; Aw = dy; An = dx; As = dx;
        Fe = 0.5f*(u[B][i  ][j  ]+u[B][i+1][j  ])*Ae;
        Fw = 0.5f*(u[B][i-1][j  ]+u[B][i  ][j  ])*Aw;
        Fn = 0.5f*(v[B][i  ][j  ]+v[B][i+1][j  ])*An;
        Fs = 0.5f*(v[B][i  ][j-1]+v[B][i+1][j-1])*As;
        De = nu*Ae/dx; Dw = nu*Aw/dx; Dn = nu*An/dy; Ds = nu*As/dy;
        AE_Ue = max(-Fe,0.f)+De;
        AW_Ue = max( Fw,0.f)+Dw;
        AN_Ue = max(-Fn,0.f)+Dn;
        AS_Ue = max( Fs,0.f)+Ds;
        AP_Ue = max( Fe,0.f)+max(-Fw,0.f)+max( Fn,0.f)+max(-Fs,0.f)+Dw+De+Dn+Ds;       
         B_Ue = Ae*(p[B][i][j]-p[B][i+1][j]);
        u[A][i][j] =( AE_Ue*u[B][i+1][j  ]+AW_Ue*u[B][i-1][j  ]
                     +AN_Ue*u[B][i  ][j+1]+AS_Ue*u[B][i  ][j-1]
                     -AP_Ue*u[B][i  ][j  ]+ B_Ue
                     -(u[B][i][j]-u[C][i][j])/dtr)*dt
                     +u[B][i  ][j  ];

        Fe = 0.5f*(u[B][i  ][j  ]+u[B][i  ][j+1])*Ae;
        Fw = 0.5f*(u[B][i-1][j  ]+u[B][i-1][j+1])*Aw;
        Fn = 0.5f*(v[B][i  ][j  ]+v[B][i  ][j+1])*An;
        Fs = 0.5f*(v[B][i  ][j  ]+v[B][i  ][j-1])*As;
        De = nu*Ae/dx; Dw = nu*Aw/dx; Dn = nu*An/dy; Ds = nu*As/dy;
        AE_Vn = max(-Fe,0.f)+De;
        AW_Vn = max( Fw,0.f)+Dw;
        AN_Vn = max(-Fn,0.f)+Dn;
        AS_Vn = max( Fs,0.f)+Ds;
        AP_Vn = max( Fe,0.f)+max(-Fw,0.f)+max( Fn,0.f)+max(-Fs,0.f)+Dw+De+Dn+Ds;       
         B_Vn = An*(p[B][i][j]-p[B][i][j+1]);
        v[A][i][j] = (AE_Vn*v[B][i+1][j  ]+AW_Vn*v[B][i-1][j  ]
                     +AN_Vn*v[B][i  ][j+1]+AS_Vn*v[B][i  ][j-1]
                     -AP_Vn*v[B][i  ][j  ]+ B_Vn
                     -(3.f*v[B][i][j]-4.f*v[C][i][j]+v[D][i][j])*0.5f/dtr)*dt
                     +v[B][i  ][j  ];


        if(j == halo-1)
        {
        v[A][i][j] = 0.f;
        }
        if(j == yDim+halo-1)
        {
        v[A][i][j] = 0.f;
        }
        if(i == halo-1)
        {
        u[A][i][j] = uMax;
        }
        if(i == xDim+halo-1)
        {
        u[A][i][j] = u[A][i-1][j];
        }
        
        if(i == halo+ObX-1 && j>=halo+ObY && j<halo+ObY+ObD)
        u[A][i][j] = 0.f;
        if(i == halo+ObX+ObD-1 && j>=halo+ObY && j<halo+ObY+ObD)
        u[A][i][j] = 0.f;
        if(j == halo+ObY-1 && i>=halo+ObX && i<halo+ObX+ObD)
        v[A][i][j] = 0.f;
        if(j == halo+ObY+ObD-1 && i>=halo+ObX && i<halo+ObX+ObD)
        v[A][i][j] = 0.f;



        p[A][i][j] = -dt*(dy*(u[A][i][j]-u[A][i-1][j])/dx+dx*(v[A][i][j]-v[A][i][j-1])/dy)/beta+p[B][i][j];

        if(abs(p[A][i][j]-p[B][i][j])>maxdp && (i > halo && j > halo && i < xDim+halo-1 && j < yDim+halo-1))
        {
        maxdp = abs(p[A][i][j]-p[B][i][j]);
        }

        if(u[A][i][j] > 10000){
        cout<<"exploded at "<<t<<endl;
        t = maxIt;
        rt = maxrt;
        }


    }
    }

    //set tangential velocities on horizontal boundaries
    for(int i = halo; i<xDim+halo; i++) 
    {
    for(int j = 0; j<halo; j++)
    {
    u[A][i][yDim+halo+j] = u[A][i][yDim+halo-1];
    u[A][i][j] = u[A][i][halo];
    v[A][i][yDim+halo+j] = 0.f;
    v[A][i][j] = 0.f;
    }
    }
    //set tangential velocities on vertical boundaries
    for(int i = halo; i<yDim+halo; i++) 
    {
    for(int j = 0; j<halo; j++)
    {
    v[A][xDim+halo+j][i] = v[A][xDim+halo-1][i];
    v[A][j][i] = 0.f;
    u[A][xDim+halo+j][i] = u[A][xDim+halo-1][i];
    u[A][j][i] = uMax;
    }
    }
    //set tangential velocities on square cylinder
    for(int i = halo+ObX; i<halo+ObX+ObD-1; i++){
    u[A][i][halo+ObY      ] = -u[A][i][halo+ObY    -1];
    u[A][i][halo+ObY+ObD-1] = -u[A][i][halo+ObY+ObD  ];
    if(rt<200) u[A][i][halo+ObY      ] = u[A][i][halo+ObY    -1];
    //v[A][i][halo+ObY      ] = 0.f;
    //v[A][i][halo+ObY+ObD-1] = 0.f;
    }
    for(int i = halo+ObY; i<halo+ObY+ObD-1; i++){
    v[A][halo+ObX      ][i] = -v[A][halo+ObX    -1][i];
    v[A][halo+ObX+ObD-1][i] = -v[A][halo+ObX+ObD  ][i];
    //u[A][halo+ObX      ][i] = 0.f;
    //u[A][halo+ObX+ObD-1][i] = 0.f;
    }





    output_res<<rt<<", "<<t<<", "<<maxdp/dt<<endl;

    
    if(maxdp/dt < maxRes && t>6){
    if(rt%50 == 0)cout<<"converged to: "<<maxdp/dt<<"at t = "<<t<<endl;
    t = maxIt;
    }
    //cout<<t<<","<<v[0][41][4]<<","<<v[0][40][4]<<","<<v[0][41][5]<<","<<v[0][40][5]<<","<<v[0][41][3]<<endl;

    //if (t%1000 == 0)
    
    }//end iteration


    for(int i = halo-1; i<xDim+halo; i++){
    for(int j = halo-1; j<xDim+halo; j++){
        u[D][i][j] = u[C][i][j];
        v[D][i][j] = v[C][i][j];
        p[D][i][j] = p[C][i][j];
    }}
    for(int i = halo-1; i<xDim+halo; i++){
    for(int j = halo-1; j<xDim+halo; j++){
        u[C][i][j] = u[A][i][j];
        v[C][i][j] = v[A][i][j];
        p[C][i][j] = p[A][i][j];
    }}

    float FX = 0;
    float FY = 0;
    //calculate pressure forces
    for(int i = halo+ObX; i<halo+ObX+ObD; i++){
    FY += dx*p[A][i][ObY+halo-1];
    FY -= dx*p[A][i][ObY+halo+ObD];
    }
    for(int j = halo+ObY; j<halo+ObY+ObD; j++){
    FX += dy*p[A][ObX+halo-1]  [j];
    FX -= dy*p[A][ObX+halo+ObD][j];
    }
    output_force<<rt<<", "<<FX*2.f<<", "<<FY*2.f<<", ";
    //calculate shear forces
    for(int i = halo+ObX; i<halo+ObX+ObD-1; i++){
    FX -= dx*nu*2.f*u[A][i][ObY+halo]    /dy;
    FX -= dx*nu*2.f*u[A][i][ObY+halo+ObD-1]/dy;
    }
    for(int j = halo+ObY; j<halo+ObY+ObD-1; j++){
    FY -= dy*nu*2.f*v[A][ObX+halo]    [j]/dx;
    FY -= dy*nu*2.f*v[A][ObX+halo+ObD-1][j]/dx;
    }
    output_force<<FX*2.f<<", "<<FY*2.f<<endl;
    if(rt%50 == 0) WriteResults(output_results,u[C],v[C],p[C],xDim,yDim,halo);
    if(rt%50 == 0) cout<<"finished time step "<<rt<<endl;

    }//end time loop



    cout<<"final res: "<<maxdp/dt<<endl;






}




int main (int argc, char *argv[])
{
    xDim = 576;
    yDim = 165;
    halo = 3;
    maxRes = 0.0001;
    maxIt = 100;
    maxrt = 3000;
    Re = 100;
    uMax = 1.f;
    URF_u = 0.4f;
    URF_v = 0.4f;
    beta = 0.05f; // 1/cm = c^2
    dt = 0.05f;
    dtr = 1.f;
    ObX = 122;
    ObY = 72;
    ObD = 20;
    //float URF_inc = 0.01f;
    //int maxRetry = 800;
    method = 2; //0:CDS, 1:UDS, 2:Hybrid, 3:QUICK
    string CaseName = "stretch";
    nu = uMax*ObD/Re;
    Ma = uMax*beta*beta;
    cout<<"Ma = "<<Ma<<endl;
    ofstream output_log,output_results,output_residual,output_vel,output_force;
    output_log.open ((CaseName+".log").c_str());
    output_results.open ((CaseName+".dat").c_str());
    output_residual.open ((CaseName+".res").c_str());
    output_vel.open ((CaseName+".vel").c_str());
    output_force.open ((CaseName+".frc").c_str());

    //write input parameters to console and log file
    WriteInputs(cout);
    WriteInputs(output_log);

    //allocate and initialize arrays
    float ***u,***v,***p;
    AllocateArray(&u,xDim+2*halo,yDim+2*halo);
    AllocateArray(&v,xDim+2*halo,yDim+2*halo);
    AllocateArray(&p,xDim+2*halo,yDim+2*halo);
    int count = 0;//counter to limit number of reruns
    //Initialize(u,v,p,xDim,yDim,halo);

    //ACM1(u,v,p,xDim,yDim,halo,maxIt,Re,cm,maxRes,dt,output_residual);
    //ACM3(u,v,p,output_residual,output_results);
    //ACM4(u,v,p,output_residual,output_results);

    //cout<<"finished ACM4"<<endl;


    struct timeval tdr0,tdr1;
    double restime;
    gettimeofday (&tdr0,NULL);

    //ACM5(u,v,p,output_residual,output_results,output_force);
    ACM4(u,v,p,output_residual,output_results);
    
    gettimeofday (&tdr1,NULL);
    timeval_subtract (&restime, &tdr1, &tdr0);
    int Nodes;
    Nodes = xDim*yDim;
    cout<<"Time taken for main kernel: "<<restime<<" ("
            <<double(Nodes*double(maxIt/1000000.f))/restime<<"MNUPS)\n";
    output_log<<"Time taken for main kernel: "<<restime<<" ("
            <<double(Nodes*double(maxIt/1000000.f))/restime<<"MNUPS)\n";


 
     //write tecplot output to *.dat
    WriteResults(output_results,u[0],v[0],p[0],xDim,yDim,halo);
    WriteResults(output_results,u[1],v[1],p[1],xDim,yDim,halo);
    //WriteResults(output_results,u[2],v[2],p[2],xDim,yDim,halo);
    //write velocity profile in csv to *.vel
    //WriteVelocityProfile(output_vel,u,v,p,xDim,yDim,halo,uMax);

    DeallocateArray(u,xDim+2*halo);
    DeallocateArray(v,xDim+2*halo);
    DeallocateArray(p,xDim+2*halo);

    output_log.close();
    output_results.close();
    output_residual.close();
    output_vel.close();

    return 0;
}
