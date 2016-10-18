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
	xDimCoarse = 256;
	yDimCoarse = 192;
	zDimCoarse = 192;
	int xDim,yDim,zDim;
	xDim = 128;
	yDim = 96;
	zDim = 96;
	float u,uPrev;
	float xMax,x;
	xMax = -1000;
	float xsMax = -1000;
	float xs = 0;
	float delx = 0.5;
    int tMax = 800000;
    int tStart = 400000;
    float Fx[tMax-tStart];
    float Fy[tMax-tStart];
    float Fz[tMax-tStart];
    //float Fx,Fy,Fz;
    float FxAv = 0;
    float FyAv = 0;
    float FzAv = 0;
    float FxFluc = 0;
    float FyFluc = 0;
    float FzFluc = 0;

	string casename = "Test25";

//Read input files
	string infilename = casename+".force";
	infile.open(infilename.c_str());
//	getline(infile, line);//zone info line
//	getline(infile, line);//zone info line


//	getline(infile, line);
//	getline(infile, line);
	for (i = 0; i<tStart; i++){
		getline(infile, line);
	}

//	getline(infile, line);
//	getline(infile, line);
	for (i = tStart; i<tMax; i++){
		getline(infile, line);
		stringstream data;
        istringstream tokenizer(line);
        istringstream int_iss;
        string token;

	    getline(tokenizer, token, ',');
	    istringstream int_iss0(token);

	    getline(tokenizer, token, ',');
	    istringstream int_iss2(token);
	    int_iss2 >> Fx[i-tStart];

	    getline(tokenizer, token, ',');
	    istringstream int_iss3(token);
	    int_iss3 >> Fy[i-tStart];

	    getline(tokenizer, token, ',');
	    istringstream int_iss4(token);
	    int_iss4 >> Fz[i-tStart];

        j = i-tStart;

        FxAv = FxAv*j/(j+1)+Fx[j]/(j+1);
        FyAv = FyAv*j/(j+1)+Fy[j]/(j+1);
        FzAv = FzAv*j/(j+1)+Fz[j]/(j+1);
	}
	for (i = tStart; i<tMax; i++){
        j = i-tStart;
        FxFluc = FxFluc*j/(j+1)+(Fx[j]-FxAv)*(Fx[j]-FxAv)/(j+1);
        FyFluc = FyFluc*j/(j+1)+(Fy[j]-FyAv)*(Fy[j]-FyAv)/(j+1);
        FzFluc = FzFluc*j/(j+1)+(Fz[j]-FzAv)*(Fz[j]-FzAv)/(j+1);
	}
//    cout<<Fx[tMax-tStart-1]<<endl;
//    cout<<Fy[tMax-tStart-1]<<endl;
//    cout<<Fz[tMax-tStart-1]<<endl;

	cout<<"FxAv = "<<FxAv<<", FxRMS = "<<sqrt(FxFluc)<<endl;
	cout<<"FyAv = "<<FyAv<<", FyRMS = "<<sqrt(FyFluc)<<endl;
	cout<<"FzAv = "<<FzAv<<", FzRMS = "<<sqrt(FzFluc)<<endl;
	infile.close();
}
