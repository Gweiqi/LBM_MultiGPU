#include <cuda.h>
//#include <cutil.h>
#include <iostream>
#include <ostream>
#include <fstream>
#include "/home/yusuke/NVIDIA_GPU_Computing_SDK/C/common/inc/cutil.h"
using namespace std;


void saxpy_cpu(float *vecY, float *vecX, float alpha, int n)
{
	int i;

	for(i = 0; i<n; i++)
		vecY[i] = alpha*vecX[i]+vecY[i];
}


__global__ void saxpy_gpu(float *vecY, float *vecX, float alpha, int n)
{
	int i;
	i = blockIdx.x*blockDim.x+threadIdx.x;
	if(i<n)
		vecY[i] = alpha*vecX[i]+vecY[i];
}



int main(int argc, char *argv[])
{
	float *x_host, *y_host;
	float *x_dev, *y_dev;
	float *y_shadow;

	ofstream output;
	output.open ("saxpy_out.dat");

	int n = 16*1024*1024;
	float alpha = 0.5f;

	size_t memsize;
	int i, blockSize, nBlocks;

	CUT_DEVICE_INIT(argc,argv);

	memsize = n*sizeof(float);

	x_host = (float *)malloc(memsize);
	y_host = (float *)malloc(memsize);
	y_shadow = (float *)malloc(memsize);

	CUDA_SAFE_CALL(cudaMalloc((void **) &x_dev, memsize));
	CUDA_SAFE_CALL(cudaMalloc((void **) &y_dev, memsize));

	for (i = 0; i < n; i++)
	{
		x_host[i] = rand()/(float)RAND_MAX;
		y_host[i] = rand()/(float)RAND_MAX;
	}

	CUDA_SAFE_CALL(cudaMemcpy(x_dev, x_host, memsize, cudaMemcpyHostToDevice));
	CUDA_SAFE_CALL(cudaMemcpy(y_dev, y_host, memsize, cudaMemcpyHostToDevice));

	blockSize = 512;
	nBlocks = n/blockSize+(n%blockSize > 0);

	saxpy_gpu<<<nBlocks, blockSize>>>(y_dev, x_dev, alpha, n);

	CUT_CHECK_ERROR("Kernel execution failed");

	saxpy_cpu(y_host,x_host,alpha,n);

	CUDA_SAFE_CALL(cudaMemcpy(y_shadow, y_dev, memsize, cudaMemcpyDeviceToHost));

	if(cutComparef(y_shadow,y_host,n))
		printf("Passed!\n");
	else
		printf("Failed!\n");
		
	for(i = 0; i<20; i++)
	{
		output<<x_host[i]<<endl;
	}
	cout<<y_host[0]<<endl;

	free(x_host);
	free(y_host);
	free(y_shadow);

	output.close();

	CUDA_SAFE_CALL(cudaFree(x_dev));
	CUDA_SAFE_CALL(cudaFree(y_dev));

	return(0);

}
