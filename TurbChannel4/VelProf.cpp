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
//Declare and initialize variables
	const double PI =3.14159265358979; 
	int i,j,k;
	string line;
	fstream infile;
	int xDim,yDim;
	xDim = 64;
	yDim = 128;
	int H = 62;
    float d = 62.f;
    float Re = 5400.f;
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
	string casename = "bgk_1";

//Read input files
	string infilename = casename+"_slice.dat";
	string outfilename = casename+".prof";
    cout<<"Infile: \t"<<infilename<<endl;
    cout<<"Outfile:\t"<<outfilename<<endl;
    ofstream output;
    output.open(outfilename.c_str());
	infile.open(infilename.c_str());
	getline(infile, line);//zone info line
	getline(infile, line);//zone info line
    
    float u_tau = 100000.f;

	for (i = 0; i<xDim/2; i++){
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

        if(i == 1) u_tau = sqrt(v*2.f*nu);

        yplus[i] = (i-0.5f)*u_tau/nu;
        vplus[i] = v/u_tau;
        urmsplus[i] = sqrt(ufluc)/u_tau;
        vrmsplus[i] = sqrt(vfluc)/u_tau;
        wrmsplus[i] = sqrt(wfluc)/u_tau;
	}
	output<<"x,u,v,urms,vrms"<<endl;
    for(i = 0; i<xDim; i++){
	output<<i<<","<<yplus[i]<<","<<vplus[i]<<","<<urmsplus[i]<<","<<vrmsplus[i]<<","<<wrmsplus[i]<<endl;
    }
    cout<<u_tau<<endl;
	infile.close();
	output.close();
}
