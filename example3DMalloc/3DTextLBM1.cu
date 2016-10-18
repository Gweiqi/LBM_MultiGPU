
    #include <stdlib.h>
    #include <stdio.h>
    #include <string.h>
    #include <math.h>
//    #include <conio.h>
    #include <cutil_inline.h>

    //-----------------------------------------------------------
    // Device code
    __global__ void SumRow(cudaPitchedPtr devPitchedPtr, cudaExtent extent, float* devPtr_out,int pitch_out)
    {
    char* devPtr   = (char*)devPitchedPtr.ptr;
    int pitch      = devPitchedPtr.pitch;
    int slicePitch = pitch*extent.height;

    //blockDim.x  : depth
    //threadIdx.x : height
    char* slice = devPtr + blockIdx.x * slicePitch;
    float* row  = (float*)(slice + threadIdx.x * pitch);
    float* sum  = (float*)((char*)devPtr_out + blockIdx.x*pitch_out);

    sum[threadIdx.x] = 0.f;
    for(int x = 0; x<extent.width;x++){
    sum[threadIdx.x] += row[x];
    }
    }

    //-----------------------------------------------------------
    // host code

    int main_impl();

    int main( int argc, char** argv)  {
     
    main_impl();
    }

    int main_impl(){

    //print_data();
//    getch();
    size_t s[3] = {256,256,209};
    size_t N    = s[2]*s[1]*s[0];
    size_t size = N * sizeof(float);
    size_t N_out    = s[2]*s[1];
    size_t size_out = N_out * sizeof(float);
    printf("size[%f]GB\n",size/1024.f/1204.f/1024.f);


    // memory allocation and init. in the host memory.
    float* h_A;
    h_A = (float*)malloc(size);
    float* h_B;
    h_B = (float*)malloc(size);
    float* h_C;
    h_C = (float*)malloc(size_out);
    float* h_D;
    h_D = (float*)malloc(size_out);

    for(int i=0; i<N;i++){
    h_A[i] = i;
    h_B[i] = N-i;
    }

    // memory allocation for device memory
    cudaPitchedPtr devPitchedPtr;
    cudaExtent     extent = make_cudaExtent(s[0],s[1],s[2]);
    cudaMalloc3D(&devPitchedPtr,extent);

    float* devPtr; //2D result. (y,z)
    size_t pitch_out ;    // This variable will be set by cudaMallocPitch;
    cudaMallocPitch( (void**)&devPtr,&pitch_out, (size_t)(s[1]*sizeof(float)), s[2]);


    unsigned int timer = 0;
        cutilCheckError( cutCreateTimer( &timer));
        cutilCheckError( cutStartTimer( timer));


    // copy from host memory data to device memory data
    cudaMemcpy3DParms p = {0};
    p.srcPtr.ptr   = h_A;
    p.srcPtr.pitch = s[0] * sizeof(float);
    p.srcPtr.xsize = s[0];
    p.srcPtr.ysize = s[1];
    p.dstPtr.ptr   = devPitchedPtr.ptr;
    p.dstPtr.pitch = devPitchedPtr.pitch;
    p.dstPtr.xsize = s[0];
    p.dstPtr.ysize = s[1];
    p.extent.width  = s[0]*sizeof(float);
    p.extent.height = s[1];
    p.extent.depth  = s[2];
    p.kind = cudaMemcpyHostToDevice;
    cudaMemcpy3D(&p);

    int threadsPerBlock = s[1];
    int blocksPerGrid   = s[2];
    SumRow<<<blocksPerGrid,threadsPerBlock>>>(devPitchedPtr,extent,devPtr,pitch_out);
    cudaGetErrorString(cudaGetLastError());
    cudaMemcpy2D(h_C,s[1]*sizeof(float),devPtr,pitch_out,s[1]*sizeof(float),s[2],cudaMemcpyDeviceToHost);
    // free device memory.
    cudaFree(devPitchedPtr.ptr);

    // finish Timer
    cutilCheckError( cutStopTimer( timer));
    printf( "Processing time1: %f (ms)\n", cutGetTimerValue( timer));
    cutilCheckError( cutDeleteTimer( timer));


    // for reference.
    timer = 0;
    cutilCheckError( cutCreateTimer( &timer));
    cutilCheckError( cutStartTimer( timer));
    int i=0;
    int j=0;
    for(int z=0; z< s[2];z++){
    for(int y=0; y< s[1];y++){
    h_D[j] =0.f;
    for(int x=0; x< s[0];x++){
    h_D[j] += h_A[i];
    i++;
    }
    j++;
    }
    }
    cutilCheckError( cutStopTimer( timer));
    printf( "Processing time2: %f (ms)\n", cutGetTimerValue( timer));
    cutilCheckError( cutDeleteTimer( timer));

    // comparison
    for(i=0; i< N_out;i++){

    // printf("test N[%d][%6.5f/%6.5f]\n",i,h_C[i],h_D[i]);
    if( 0.0f < (h_C[i] - h_D[i]) ){
    printf("error N[%d][%6.5f/%6.5f]\n",i,h_C[i],h_D[i]);
    }
    }
    return 0;
    };

