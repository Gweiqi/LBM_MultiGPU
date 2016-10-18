#include <sstream>
#include <fstream>
#include <iostream>
#include <stdio.h>
#include <string.h>
#include <math.h>
#include <cmath>
#include <vector>

using namespace std;

int main(){
	string line;
	fstream infile;
	string casename = "DynInlet3_12";

//Read input files
	string infilename = casename+"_slice.dat";
	string outfilename = casename+".prof2";
    cout<<"Infile: \t"<<infilename<<endl;
    cout<<"Outfile:\t"<<outfilename<<endl;
    ofstream output;
    output.open(outfilename.c_str());
	infile.open(infilename.c_str());
	getline(infile, line);//zone info line
	getline(infile, line);//zone info line

//Declare and initialize variables
	const double PI =3.14159265358979; 
	int i,j,k;

	int xDim,yDim;
	xDim = 224;
	yDim = 1000;
    float ObY = 340.5f;
	int H = 200;
    float d = 40.f;
    float Re = 3000.f;
    float uMax = 0.06f;
    float nu = uMax*d/Re;
	float u,uPrev,v,w;
    float ufluc, vfluc, wfluc;
    int x,y,z;
    float yplus[xDim/2];
    float vplus[xDim/2];
    float urmsplus[xDim/2];
    float vrmsplus[xDim/2];
    float wrmsplus[xDim/2];

    float **uav,**vav;
    float **urms,**vrms;

    uav = new float* [xDim];
    vav = new float* [xDim];
    urms= new float* [xDim];
    vrms= new float* [xDim];
    for(i = 0; i<xDim; i++){
    uav [i] = new float [yDim];
    vav [i] = new float [yDim];
    urms[i] = new float [yDim];
    vrms[i] = new float [yDim];
    }
    
	for (j = 0; j<yDim; j++){
	for (i = 0; i<xDim; i++){
		getline(infile, line);
		stringstream data;
        istringstream tokenizer(line);
        istringstream int_iss;
        string token;

	    getline(tokenizer, token, ',');
	    istringstream int_issX(token);
	    int_issX >> x;
	    getline(tokenizer, token, ',');
	    istringstream int_issY(token);
	    int_issY >> y;
	    getline(tokenizer, token, ',');
	    istringstream int_issZ(token);
	    int_issZ >> z;

	    getline(tokenizer, token, ',');//u
	    istringstream int_issu(token);
	    getline(tokenizer, token, ',');//v
	    istringstream int_issv(token);
	    getline(tokenizer, token, ',');//w
	    istringstream int_issw(token);
	    getline(tokenizer, token, ',');//rho
	    istringstream int_isswho(token);

	    getline(tokenizer, token, ',');
	    istringstream int_iss2(token);
	    int_iss2 >> u;
	    getline(tokenizer, token, ',');
	    istringstream int_iss3(token);
	    int_iss3 >> v;
	    getline(tokenizer, token, ',');
	    istringstream int_iss4(token);
	    int_iss4 >> w;
	    getline(tokenizer, token, ',');
	    istringstream int_iss5(token);
	    int_iss5 >> ufluc;
	    getline(tokenizer, token, ',');
	    istringstream int_iss6(token);
	    int_iss6 >> vfluc;
	    getline(tokenizer, token, ',');
	    istringstream int_iss7(token);
	    int_iss7 >> wfluc;

        uav [i][j] = u/uMax;
        vav [i][j] = v/uMax;
        urms[i][j] = sqrt(ufluc)/uMax;
        vrms[i][j] = sqrt(vfluc)/uMax;
	}
	}

	output<<"x=1d"<<endl;
    j = ObY+d*0.5f+1+d;
    for(i = 0; i<H/2+1; i++){
    output<<i/d<<", "<<uav[i][j]<<", "<<vav[i][j]<<", "<<urms[i][j]<<", "<<vrms[i][j]<<endl;
    }
	output<<"x=3.5d"<<endl;
    j = ObY+d*0.5f+1+3.5f*d;
    for(i = 0; i<H/2+1; i++){
    output<<i/d<<", "<<uav[i][j]<<", "<<vav[i][j]<<", "<<urms[i][j]<<", "<<vrms[i][j]<<endl;
    }
	output<<"x=6d"<<endl;
    j = ObY+d*0.5f+1+6.f*d;
    for(i = 0; i<H/2+1; i++){
    output<<i/d<<", "<<uav[i][j]<<", "<<vav[i][j]<<", "<<urms[i][j]<<", "<<vrms[i][j]<<endl;
    }
	output<<"x=8.5d"<<endl;
    j = ObY+d*0.5f+1+8.5f*d;
    for(i = 0; i<H/2+1; i++){
    output<<i/d<<", "<<uav[i][j]<<", "<<vav[i][j]<<", "<<urms[i][j]<<", "<<vrms[i][j]<<endl;
    }
	output<<"wake profile"<<endl;
    i = H/2;
    for(j = ObY+d*0.5f+1; j<ObY+d*0.5f+1+8.f*d; j++){
    float u_av = 0.5f*uav [i][j]+0.5f*uav [i+1][j];
    float v_av = 0.5f*vav [i][j]+0.5f*vav [i+1][j];
    float u_rms= 0.5f*urms[i][j]+0.5f*urms[i+1][j];
    float v_rms= 0.5f*vrms[i][j]+0.5f*vrms[i+1][j];
    output<<(j-ObY-d*0.5f)/d<<", "<<uav[i][j]<<", "<<vav[i][j]<<", "<<urms[i][j]<<", "<<vrms[i][j]<<endl;
    }



//	output<<"x,u,v,urms,vrms"<<endl;
//    for(i = 0; i<xDim; i++){
//	output<<i<<","<<yplus[i]<<","<<vplus[i]<<","<<urmsplus[i]<<","<<vrmsplus[i]<<","<<wrmsplus[i]<<endl;
//    }
	infile.close();
	output.close();
}
