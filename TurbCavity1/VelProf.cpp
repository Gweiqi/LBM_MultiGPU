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
	double uMax = 0.06;
	double diam = 8;
	int xDimCoarse,yDimCoarse,zDimCoarse;
	int xDim,yDim,zDim;
	xDim = 128;
	yDim = 128;
	zDim = 16;
	float u,uPrev,v,w;
    float ufluc, vfluc;
	float xMax;
    int x,y,z;
	xMax = -1000;
	float xsMax = -1000;
	float xs = 0;
	float delx = 0.5;
    int tMax = 800000;
    int tStart = 400000;
    float uave[yDim];
    float vave[xDim];
    float urms[yDim];
    float vrms[xDim];
    //float Fx,Fy,Fz;
    float FxAv = 0;
    float FyAv = 0;
    float FzAv = 0;
    float FxFluc = 0;
    float FyFluc = 0;
    float FzFluc = 0;

	string casename = "test";

//Read input files
	string infilename = casename+".dat";
	string outfilename = casename+".vel";
    cout<<"Infile: \t"<<infilename<<endl;
    cout<<"Outfile:\t"<<outfilename<<endl;
    cout<<"uMax =\t"<<uMax<<endl;
    ofstream output;
    output.open(outfilename.c_str());
	infile.open(infilename.c_str());
	getline(infile, line);//zone info line
	getline(infile, line);//zone info line

    int half = xDim*yDim*zDim/2;
	for (i = 0; i<half; i++){
		getline(infile, line);
	}

	for (i = 0; i<xDim*yDim; i++){
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
	    int_iss4 >> ufluc;
	    getline(tokenizer, token, ',');
	    istringstream int_iss5(token);
	    int_iss5 >> vfluc;

        if(y == yDim/2){
            vave[x] = v/uMax;
            vrms[x] = sqrt(vfluc)/uMax;
        }
        if(x == xDim/2){
            uave[y] = u/uMax;
            urms[y] = sqrt(ufluc)/uMax;
        }
	}
	output<<"x,u,v,urms,vrms"<<endl;
    for(i = 0; i<xDim; i++){
	output<<float(i)/xDim<<","<<uave[i]<<","<<vave[i]<<","<<urms[i]<<","<<vrms[i]<<endl;
    }
	infile.close();
	output.close();
}
