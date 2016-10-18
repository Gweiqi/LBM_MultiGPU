#include <sstream>
#include <fstream>
#include <iostream>
#include <stdio.h>
#include <string.h>
#include <math.h>
#include <cmath>
#include <vector>
#include "func_DFT.h"

using namespace std;

int main(){
//Declare and initialize variables
	const double PI =3.14159265358979; 
	int i,j,k;
	string line,line2;
	fstream infile,infile2,infile3,infile4,infile_2,infile2_2,infile3_2;
	vector<double> CL,CD,CL_Re,CL_Im,CD_Re,CD_Im,u,v,u_Re,u_Im,v_Re,v_Im,
					u_avg,v_avg,u_fluc,v_fluc,uv_fluc,
					u_avg2,v_avg2,u_fluc2,v_fluc2;
	double uMax = 0.1;
	double diam = 29;

	bool velocities = 1;
	bool DFTvelocities = 0;
	bool forces = 0;

	string casename = "3DCavity3_6";

	int LRlevel = 0;//refinement level
	stringstream lv;
	lv<<LRlevel;
	string level = lv.str();

	int vtime_tot = 30000;//40000*4/2;
	int vtime_start = 0;	
	if(DFTvelocities == 1){
//	u.resize(vtime_tot-vtime_start,0);
	v.resize(vtime_tot-vtime_start,0);
//	u_Re.resize(vtime_tot-vtime_start,0);
	v_Re.resize(vtime_tot-vtime_start,0);
	v_Im.resize(vtime_tot-vtime_start,0);
	}

	int veltime = 10000;//2000;
	int veltime_start = 0;	
	int velxnum = 32+1;//200;//number of data points in x
	int velynum = 32+1;//200;//number of data points in y
	if(velocities == 1){
	u_avg.resize(velxnum,0);
	v_avg.resize(velxnum,0);
	u_avg2.resize(velynum,0);
	v_avg2.resize(velynum,0);
	u_fluc.resize(velxnum,0);
	v_fluc.resize(velxnum,0);
	u_fluc2.resize(velynum,0);
	v_fluc2.resize(velynum,0);
	uv_fluc.resize(velxnum,0);
	}

	int ftime_tot = 60000*4/2;
	int ftime_start = 0;	
	if(forces == 1){
	CL.resize(ftime_tot-ftime_start,0);
	CD.resize(ftime_tot-ftime_start,0);
	CL_Re.resize(ftime_tot-ftime_start,0);
	CL_Im.resize(ftime_tot-ftime_start,0);
	CD_Re.resize(ftime_tot-ftime_start,0);
	CD_Im.resize(ftime_tot-ftime_start,0);
	}


//DFT of v
//Read input files
	if(DFTvelocities == 1){
	string infilename = casename+"_lv"+level+"_vVelocityHist.dat";
	infile.open(infilename.c_str());
	for (i = 0; i<vtime_tot; i++){
		getline(infile, line);
		stringstream data;
        istringstream tokenizer(line);
        istringstream int_iss;
        string token;
		for(j = 0; j<165; j++){
	        getline(tokenizer, token, ',');
        	istringstream int_iss(token);
		}
	    getline(tokenizer, token, ',');
	    istringstream int_iss2(token);
	    int_iss2 >> v[i];
	}
	DFT(v,v_Re,v_Im);
	ofstream outfile;
	string outfilename = casename+"_lv"+level+"_v_DFT.dat";
	outfile.open(outfilename.c_str());
	for (i = 0; i<vtime_tot-vtime_start; i++){
		outfile<<double(i)/(vtime_tot-vtime_start)/pow(2.0,LRlevel)<<","<<v_Re[i]<<","<<v_Im[i]<<endl;
	}
	outfile.close();
	infile.close();
	cout<<"finished v DFT"<<endl;
	}



	if(velocities == 1){

	string infilename2 = casename+"_lv"+level+"_uVelocityHist1.dat";
	infile2.open(infilename2.c_str());
	string infilename3 = casename+"_lv"+level+"_vVelocityHist1.dat";
	infile3.open(infilename3.c_str());

	string infilename2_2 = casename+"_lv"+level+"_uVelocityHist2.dat";
	infile2_2.open(infilename2_2.c_str());
	string infilename3_2 = casename+"_lv"+level+"_vVelocityHist2.dat";
	infile3_2.open(infilename3_2.c_str());

//average profile of u
	double u_in,v_in;
	for (i = 0; i<veltime; i++){
		getline(infile2, line);
        istringstream tokenizer(line);
        istringstream int_iss;
        string token;
		if(i >= veltime_start){
		for(j = 0; j<velxnum; j++){
		    getline(tokenizer, token, ',');
		    istringstream int_iss2(token);
		    int_iss2 >> u_in;
			u_avg[j] = u_avg[j]*(i-veltime_start)/(i-veltime_start+1)+u_in/(i-veltime_start+1);
		}
		}
	}
	for (i = 0; i<veltime; i++){
		getline(infile3, line);
        istringstream tokenizer(line);
        istringstream int_iss3;
        string token;
		if(i >= veltime_start){
		for(j = 0; j<velxnum; j++){
		    getline(tokenizer, token, ',');
		    istringstream int_iss4(token);
		    int_iss4 >> v_in;
			v_avg[j] = v_avg[j]*(i-veltime_start)/(i-veltime_start+1)+v_in/(i-veltime_start+1);
		}
		}
	}

	for (i = 0; i<veltime; i++){
		getline(infile2_2, line);
        istringstream tokenizer(line);
        istringstream int_iss_2;
        string token;
		if(i >= veltime_start){
		for(j = 0; j<velxnum; j++){
		    getline(tokenizer, token, ',');
		    istringstream int_iss2_2(token);
		    int_iss2_2 >> u_in;
			u_avg2[j] = u_avg2[j]*(i-veltime_start)/(i-veltime_start+1)+u_in/(i-veltime_start+1);
		}
		}
	}
	for (i = 0; i<veltime; i++){
		getline(infile3_2, line);
        istringstream tokenizer(line);
        istringstream int_iss3_2;
        string token;
		if(i >= veltime_start){
		for(j = 0; j<velxnum; j++){
		    getline(tokenizer, token, ',');
		    istringstream int_iss4_2(token);
		    int_iss4_2 >> v_in;
			v_avg2[j] = v_avg2[j]*(i-veltime_start)/(i-veltime_start+1)+v_in/(i-veltime_start+1);
		}
		}
	}

	infile2.close();
	infile3.close();
	infile2_2.close();
	infile3_2.close();

	ofstream outfile2;
	string outfilename2 = casename+"_lv"+level+"_u_avg_profile.dat";
	outfile2.open(outfilename2.c_str());
	for (j = 1; j<velxnum; j++){
		outfile2<<double(j-1)/pow(2.0,LRlevel)/diam<<","<<u_avg[j]/uMax<<","<<v_avg[j]/uMax<<endl;
	}
	outfile2.close();

	ofstream outfile2_2;
	string outfilename2_2 = casename+"_lv"+level+"_u_avg_profile2.dat";
	outfile2_2.open(outfilename2_2.c_str());
	for (j = 1; j<velynum; j++){
		outfile2_2<<double(j-1)/pow(2.0,LRlevel)/diam<<","<<u_avg2[j]/uMax<<","<<v_avg2[j]/uMax<<endl;
	}
	outfile2_2.close();
	cout<<"finished u averaging"<<endl;


	infile2.open(infilename2.c_str());
	infile3.open(infilename3.c_str());

	infile2_2.open(infilename2_2.c_str());
	infile3_2.open(infilename3_2.c_str());

//TKE
//	for (i = 0; i<veltime; i++){
//		getline(infile2, line);
//        istringstream tokenizer(line);
//        istringstream int_iss;
//        string token;
//		getline(infile3, line2);
//        tokenizer(line2);
//        istringstream int_iss3;
//        string token2;
//		for(j = 0; j<velxnum; j++){
//		    getline(tokenizer, token, ',');
//		    istringstream int_iss2(token);
//		    int_iss2 >> u_in;
//			u_fluc[j] = u_fluc[j]*(i)/(i+1)+(u_in-u_avg[j])*(u_in-u_avg[j])/(i+1);
//
//		    getline(tokenizer, token2, ',');
//		    istringstream int_iss4(token2);
//		    int_iss4 >> v_in;
//			v_fluc[j] = v_fluc[j]*(i)/(i+1)+(v_in-v_avg[j])*(v_in-v_avg[j])/(i+1);
//			uv_fluc[j] = uv_fluc[j]*(i)/(i+1)+(v_in-v_avg[j])*(u_in-u_avg[j])/(i+1);
//		}
//	}
	for (i = 0; i<veltime; i++){
		getline(infile3, line);
        istringstream tokenizer(line);
        istringstream int_iss3;
        string token;
		if(i >= veltime_start){
		for(j = 0; j<velxnum; j++){
		    getline(tokenizer, token, ',');
		    istringstream int_iss4(token);
		    int_iss4 >> v_in;
			v_fluc[j] = v_fluc[j]*(i-veltime_start)/(i-veltime_start+1)+(v_in-v_avg[j])*(v_in-v_avg[j])/(i-veltime_start+1);
		}
		}
	}
	for (i = 0; i<veltime; i++){
		getline(infile2, line);
        istringstream tokenizer(line);
        istringstream int_iss;
        string token;
		if(i >= veltime_start){
		for(j = 0; j<velxnum; j++){
		    getline(tokenizer, token, ',');
		    istringstream int_iss2(token);
		    int_iss2 >> u_in;
			u_fluc[j] = u_fluc[j]*(i-veltime_start)/(i-veltime_start+1)+(u_in-u_avg[j])*(u_in-u_avg[j])/(i-veltime_start+1);
		}
		}
	}

	for (i = 0; i<veltime; i++){
		getline(infile3_2, line);
        istringstream tokenizer(line);
        istringstream int_iss3_2;
        string token;
		if(i >= veltime_start){
		for(j = 0; j<velynum; j++){
		    getline(tokenizer, token, ',');
		    istringstream int_iss4_2(token);
		    int_iss4_2 >> v_in;
			v_fluc2[j] = v_fluc2[j]*(i-veltime_start)/(i-veltime_start+1)+(v_in-v_avg2[j])*(v_in-v_avg2[j])/(i-veltime_start+1);
		}
		}
	}
	for (i = 0; i<veltime; i++){
		getline(infile2_2, line);
        istringstream tokenizer(line);
        istringstream int_iss_2;
        string token;
		if(i >= veltime_start){
		for(j = 0; j<velynum; j++){
		    getline(tokenizer, token, ',');
		    istringstream int_iss2_2(token);
		    int_iss2_2 >> u_in;
			u_fluc2[j] = u_fluc2[j]*(i-veltime_start)/(i-veltime_start+1)+(u_in-u_avg2[j])*(u_in-u_avg2[j])/(i-veltime_start+1);
		}
		}
	}
//	for (i = 0; i<veltime; i++){
//		getline(infile3, line);
//        istringstream tokenizer(line);
//        istringstream int_iss3;
//        string token;
//		for(j = 0; j<velxnum; j++){
//		    getline(tokenizer, token, ',');
//		    istringstream int_iss4(token);
//		    int_iss4 >> v_in;
//			v_fluc[j] = v_fluc[j]*(i)/(i+1)+(v_in-v_avg[j])*(v_in-v_avg[j])/(i+1);
//		}
//	}
	ofstream outfile3;
	string outfilename3 = casename+"_lv"+level+"_u_fluc.dat";
	outfile3.open(outfilename3.c_str());
	for (j = 1; j<velxnum; j++){
		outfile3<<double(j-1)/pow(2.0,LRlevel)/diam<<","
				<<sqrt(u_fluc[j])/uMax<<","<<sqrt(v_fluc[j])/uMax<<
				","<<0.5*(u_fluc[j]+v_fluc[j])/(uMax*uMax)<<endl;
	}
	outfile3.close();

	ofstream outfile3_2;
	string outfilename3_2 = casename+"_lv"+level+"_u_fluc2.dat";
	outfile3_2.open(outfilename3_2.c_str());
	for (j = 1; j<velynum; j++){
		outfile3_2<<double(j-1)/pow(2.0,LRlevel)/diam<<","
				<<sqrt(u_fluc2[j])/uMax<<","<<sqrt(v_fluc2[j])/uMax<<
				","<<0.5*(u_fluc2[j]+v_fluc2[j])/(uMax*uMax)<<endl;
	}
	outfile3_2.close();

	infile2.close();
	infile3.close();
	infile2_2.close();
	infile3_2.close();

	}//end of velocities

	if(forces == 1){
	string infilename4 = casename+"_Force.dat";
	infile4.open(infilename4.c_str());
	for (i = 0; i<ftime_tot; i++){
		getline(infile4, line);
		stringstream data;
		if(i>=ftime_start){
	        istringstream tokenizer(line);
	        string token;
	
	        getline(tokenizer, token, ',');
	        istringstream int_iss(token);
	        int time;
	        int_iss >> time;
	        getline(tokenizer, token, ',');
	        istringstream int_iss2(token);
	        double CDin;
	        int_iss2 >> CD[i-ftime_start];
	        getline(tokenizer, token, ',');
	        istringstream int_iss3(token);
	        double CLin;
	        int_iss3 >> CL[i-ftime_start];
		}
	}
	infile4.close();
	DFT(CL,CL_Re,CL_Im);
//	DFT(CD,CD_Re,CD_Im);
	ofstream outfile;
	string outfilename4 = casename+"_DFT_Force.dat";
	outfile.open(outfilename4.c_str());
	for (i = 0; i<(ftime_tot-ftime_start); i++){
		outfile<<double(i)/((ftime_tot-ftime_start)/pow(2.0,LRlevel))<<","<<CL_Re[i]<<","<<CL_Im[i]<<","<<
				sqrt(CL_Re[i]*CL_Re[i]+CL_Im[i]*CL_Im[i])<<","<<
				CD_Re[i]<<","<<CD_Im[i]<<endl;
	}
	outfile.close();
	} //end of forces
}
