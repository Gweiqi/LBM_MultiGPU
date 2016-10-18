# 1 "txInterpTest.cudafe2.gpu"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "txInterpTest.cudafe2.gpu"
# 211 "/usr/lib/gcc/x86_64-linux-gnu/4.4.3/include/stddef.h" 3
typedef unsigned long size_t;
# 1 "/usr/local/cuda/bin/../include/crt/device_runtime.h" 1 3
# 38 "/usr/local/cuda/bin/../include/crt/device_runtime.h" 3
# 1 "/usr/local/cuda/bin/../include/host_defines.h" 1 3
# 39 "/usr/local/cuda/bin/../include/crt/device_runtime.h" 2 3




typedef const void *__texture_type__;
typedef const void *__surface_type__;
# 184 "/usr/local/cuda/bin/../include/crt/device_runtime.h" 3
# 1 "/usr/local/cuda/bin/../include/builtin_types.h" 1 3
# 56 "/usr/local/cuda/bin/../include/builtin_types.h" 3
# 1 "/usr/local/cuda/bin/../include/device_types.h" 1 3
# 53 "/usr/local/cuda/bin/../include/device_types.h" 3
# 1 "/usr/local/cuda/bin/../include/host_defines.h" 1 3
# 54 "/usr/local/cuda/bin/../include/device_types.h" 2 3







enum cudaRoundMode
{
    cudaRoundNearest,
    cudaRoundZero,
    cudaRoundPosInf,
    cudaRoundMinInf
};
# 57 "/usr/local/cuda/bin/../include/builtin_types.h" 2 3
# 1 "/usr/local/cuda/bin/../include/driver_types.h" 1 3
# 126 "/usr/local/cuda/bin/../include/driver_types.h" 3
enum cudaError
{





    cudaSuccess = 0,





    cudaErrorMissingConfiguration = 1,





    cudaErrorMemoryAllocation = 2,





    cudaErrorInitializationError = 3,
# 161 "/usr/local/cuda/bin/../include/driver_types.h" 3
    cudaErrorLaunchFailure = 4,
# 170 "/usr/local/cuda/bin/../include/driver_types.h" 3
    cudaErrorPriorLaunchFailure = 5,
# 180 "/usr/local/cuda/bin/../include/driver_types.h" 3
    cudaErrorLaunchTimeout = 6,
# 189 "/usr/local/cuda/bin/../include/driver_types.h" 3
    cudaErrorLaunchOutOfResources = 7,





    cudaErrorInvalidDeviceFunction = 8,
# 204 "/usr/local/cuda/bin/../include/driver_types.h" 3
    cudaErrorInvalidConfiguration = 9,





    cudaErrorInvalidDevice = 10,





    cudaErrorInvalidValue = 11,





    cudaErrorInvalidPitchValue = 12,





    cudaErrorInvalidSymbol = 13,




    cudaErrorMapBufferObjectFailed = 14,




    cudaErrorUnmapBufferObjectFailed = 15,





    cudaErrorInvalidHostPointer = 16,





    cudaErrorInvalidDevicePointer = 17,





    cudaErrorInvalidTexture = 18,





    cudaErrorInvalidTextureBinding = 19,






    cudaErrorInvalidChannelDescriptor = 20,





    cudaErrorInvalidMemcpyDirection = 21,
# 285 "/usr/local/cuda/bin/../include/driver_types.h" 3
    cudaErrorAddressOfConstant = 22,
# 294 "/usr/local/cuda/bin/../include/driver_types.h" 3
    cudaErrorTextureFetchFailed = 23,
# 303 "/usr/local/cuda/bin/../include/driver_types.h" 3
    cudaErrorTextureNotBound = 24,
# 312 "/usr/local/cuda/bin/../include/driver_types.h" 3
    cudaErrorSynchronizationError = 25,





    cudaErrorInvalidFilterSetting = 26,





    cudaErrorInvalidNormSetting = 27,







    cudaErrorMixedDeviceExecution = 28,






    cudaErrorCudartUnloading = 29,




    cudaErrorUnknown = 30,







    cudaErrorNotYetImplemented = 31,
# 361 "/usr/local/cuda/bin/../include/driver_types.h" 3
    cudaErrorMemoryValueTooLarge = 32,






    cudaErrorInvalidResourceHandle = 33,







    cudaErrorNotReady = 34,






    cudaErrorInsufficientDriver = 35,
# 396 "/usr/local/cuda/bin/../include/driver_types.h" 3
    cudaErrorSetOnActiveProcess = 36,





    cudaErrorInvalidSurface = 37,





    cudaErrorNoDevice = 38,





    cudaErrorECCUncorrectable = 39,




    cudaErrorSharedObjectSymbolNotFound = 40,




    cudaErrorSharedObjectInitFailed = 41,





    cudaErrorUnsupportedLimit = 42,





    cudaErrorDuplicateVariableName = 43,





    cudaErrorDuplicateTextureName = 44,





    cudaErrorDuplicateSurfaceName = 45,
# 458 "/usr/local/cuda/bin/../include/driver_types.h" 3
    cudaErrorDevicesUnavailable = 46,




    cudaErrorInvalidKernelImage = 47,







    cudaErrorNoKernelImageForDevice = 48,
# 484 "/usr/local/cuda/bin/../include/driver_types.h" 3
    cudaErrorIncompatibleDriverContext = 49,






    cudaErrorPeerAccessAlreadyEnabled = 50,






    cudaErrorPeerAccessNotEnabled = 51,





    cudaErrorDeviceAlreadyInUse = 54,







    cudaErrorProfilerDisabled = 55,






    cudaErrorProfilerNotInitialized = 56,






    cudaErrorProfilerAlreadyStarted = 57,





     cudaErrorProfilerAlreadyStopped = 58,







    cudaErrorAssert = 59,






    cudaErrorTooManyPeers = 60,





    cudaErrorHostMemoryAlreadyRegistered = 61,





    cudaErrorHostMemoryNotRegistered = 62,




    cudaErrorOperatingSystem = 63,




    cudaErrorStartupFailure = 0x7f,







    cudaErrorApiFailureBase = 10000
};




enum cudaChannelFormatKind
{
    cudaChannelFormatKindSigned = 0,
    cudaChannelFormatKindUnsigned = 1,
    cudaChannelFormatKindFloat = 2,
    cudaChannelFormatKindNone = 3
};




struct cudaChannelFormatDesc
{
    int x;
    int y;
    int z;
    int w;
    enum cudaChannelFormatKind f;
};




struct cudaArray;




enum cudaMemoryType
{
    cudaMemoryTypeHost = 1,
    cudaMemoryTypeDevice = 2
};




enum cudaMemcpyKind
{
    cudaMemcpyHostToHost = 0,
    cudaMemcpyHostToDevice = 1,
    cudaMemcpyDeviceToHost = 2,
    cudaMemcpyDeviceToDevice = 3,
    cudaMemcpyDefault = 4
};





struct cudaPitchedPtr
{
    void *ptr;
    size_t pitch;
    size_t xsize;
    size_t ysize;
};





struct cudaExtent
{
    size_t width;
    size_t height;
    size_t depth;
};





struct cudaPos
{
    size_t x;
    size_t y;
    size_t z;
};




struct cudaMemcpy3DParms
{
    struct cudaArray *srcArray;
    struct cudaPos srcPos;
    struct cudaPitchedPtr srcPtr;

    struct cudaArray *dstArray;
    struct cudaPos dstPos;
    struct cudaPitchedPtr dstPtr;

    struct cudaExtent extent;
    enum cudaMemcpyKind kind;
};




struct cudaMemcpy3DPeerParms
{
    struct cudaArray *srcArray;
    struct cudaPos srcPos;
    struct cudaPitchedPtr srcPtr;
    int srcDevice;

    struct cudaArray *dstArray;
    struct cudaPos dstPos;
    struct cudaPitchedPtr dstPtr;
    int dstDevice;

    struct cudaExtent extent;
};




struct cudaGraphicsResource;




enum cudaGraphicsRegisterFlags
{
    cudaGraphicsRegisterFlagsNone = 0,
    cudaGraphicsRegisterFlagsReadOnly = 1,
    cudaGraphicsRegisterFlagsWriteDiscard = 2,
    cudaGraphicsRegisterFlagsSurfaceLoadStore = 4,
    cudaGraphicsRegisterFlagsTextureGather = 8
};




enum cudaGraphicsMapFlags
{
    cudaGraphicsMapFlagsNone = 0,
    cudaGraphicsMapFlagsReadOnly = 1,
    cudaGraphicsMapFlagsWriteDiscard = 2
};




enum cudaGraphicsCubeFace
{
    cudaGraphicsCubeFacePositiveX = 0x00,
    cudaGraphicsCubeFaceNegativeX = 0x01,
    cudaGraphicsCubeFacePositiveY = 0x02,
    cudaGraphicsCubeFaceNegativeY = 0x03,
    cudaGraphicsCubeFacePositiveZ = 0x04,
    cudaGraphicsCubeFaceNegativeZ = 0x05
};




struct cudaPointerAttributes
{




    enum cudaMemoryType memoryType;
# 758 "/usr/local/cuda/bin/../include/driver_types.h" 3
    int device;





    void *devicePointer;





    void *hostPointer;
};




struct cudaFuncAttributes
{





   size_t sharedSizeBytes;





   size_t constSizeBytes;




   size_t localSizeBytes;






   int maxThreadsPerBlock;




   int numRegs;






   int ptxVersion;






   int binaryVersion;
};




enum cudaFuncCache
{
    cudaFuncCachePreferNone = 0,
    cudaFuncCachePreferShared = 1,
    cudaFuncCachePreferL1 = 2,
    cudaFuncCachePreferEqual = 3
};





enum cudaSharedMemConfig
{
    cudaSharedMemBankSizeDefault = 0,
    cudaSharedMemBankSizeFourByte = 1,
    cudaSharedMemBankSizeEightByte = 2
};




enum cudaComputeMode
{
    cudaComputeModeDefault = 0,
    cudaComputeModeExclusive = 1,
    cudaComputeModeProhibited = 2,
    cudaComputeModeExclusiveProcess = 3
};




enum cudaLimit
{
    cudaLimitStackSize = 0x00,
    cudaLimitPrintfFifoSize = 0x01,
    cudaLimitMallocHeapSize = 0x02
};




enum cudaOutputMode
{
    cudaKeyValuePair = 0x00,
    cudaCSV = 0x01
};




struct cudaDeviceProp
{
    char name[256];
    size_t totalGlobalMem;
    size_t sharedMemPerBlock;
    int regsPerBlock;
    int warpSize;
    size_t memPitch;
    int maxThreadsPerBlock;
    int maxThreadsDim[3];
    int maxGridSize[3];
    int clockRate;
    size_t totalConstMem;
    int major;
    int minor;
    size_t textureAlignment;
    size_t texturePitchAlignment;
    int deviceOverlap;
    int multiProcessorCount;
    int kernelExecTimeoutEnabled;
    int integrated;
    int canMapHostMemory;
    int computeMode;
    int maxTexture1D;
    int maxTexture1DLinear;
    int maxTexture2D[2];
    int maxTexture2DLinear[3];
    int maxTexture2DGather[2];
    int maxTexture3D[3];
    int maxTextureCubemap;
    int maxTexture1DLayered[2];
    int maxTexture2DLayered[3];
    int maxTextureCubemapLayered[2];
    int maxSurface1D;
    int maxSurface2D[2];
    int maxSurface3D[3];
    int maxSurface1DLayered[2];
    int maxSurface2DLayered[3];
    int maxSurfaceCubemap;
    int maxSurfaceCubemapLayered[2];
    size_t surfaceAlignment;
    int concurrentKernels;
    int ECCEnabled;
    int pciBusID;
    int pciDeviceID;
    int pciDomainID;
    int tccDriver;
    int asyncEngineCount;
    int unifiedAddressing;
    int memoryClockRate;
    int memoryBusWidth;
    int l2CacheSize;
    int maxThreadsPerMultiProcessor;
};
# 993 "/usr/local/cuda/bin/../include/driver_types.h" 3
struct cudaIpcEventHandle_st
{
    char reserved[64];
};

struct cudaIpcMemHandle_st
{
    char reserved[64];
};
# 1012 "/usr/local/cuda/bin/../include/driver_types.h" 3
typedef enum cudaError cudaError_t;




typedef struct CUstream_st *cudaStream_t;




typedef struct CUevent_st *cudaEvent_t;




typedef struct cudaGraphicsResource *cudaGraphicsResource_t;




typedef struct CUuuid_st cudaUUID_t;




typedef struct cudaIpcEventHandle_st cudaIpcEventHandle_t;
typedef struct cudaIpcMemHandle_st cudaIpcMemHandle_t;




typedef enum cudaOutputMode cudaOutputMode_t;
# 58 "/usr/local/cuda/bin/../include/builtin_types.h" 2 3
# 1 "/usr/local/cuda/bin/../include/surface_types.h" 1 3
# 84 "/usr/local/cuda/bin/../include/surface_types.h" 3
enum cudaSurfaceBoundaryMode
{
    cudaBoundaryModeZero = 0,
    cudaBoundaryModeClamp = 1,
    cudaBoundaryModeTrap = 2
};




enum cudaSurfaceFormatMode
{
    cudaFormatModeForced = 0,
    cudaFormatModeAuto = 1
};




struct surfaceReference
{



    struct cudaChannelFormatDesc channelDesc;
};
# 59 "/usr/local/cuda/bin/../include/builtin_types.h" 2 3
# 1 "/usr/local/cuda/bin/../include/texture_types.h" 1 3
# 84 "/usr/local/cuda/bin/../include/texture_types.h" 3
enum cudaTextureAddressMode
{
    cudaAddressModeWrap = 0,
    cudaAddressModeClamp = 1,
    cudaAddressModeMirror = 2,
    cudaAddressModeBorder = 3
};




enum cudaTextureFilterMode
{
    cudaFilterModePoint = 0,
    cudaFilterModeLinear = 1
};




enum cudaTextureReadMode
{
    cudaReadModeElementType = 0,
    cudaReadModeNormalizedFloat = 1
};




struct textureReference
{



    int normalized;



    enum cudaTextureFilterMode filterMode;



    enum cudaTextureAddressMode addressMode[3];



    struct cudaChannelFormatDesc channelDesc;



    int sRGB;
    int __cudaReserved[15];
};
# 60 "/usr/local/cuda/bin/../include/builtin_types.h" 2 3
# 1 "/usr/local/cuda/bin/../include/vector_types.h" 1 3
# 59 "/usr/local/cuda/bin/../include/vector_types.h" 3
# 1 "/usr/local/cuda/bin/../include/builtin_types.h" 1 3
# 60 "/usr/local/cuda/bin/../include/builtin_types.h" 3
# 1 "/usr/local/cuda/bin/../include/vector_types.h" 1 3
# 60 "/usr/local/cuda/bin/../include/builtin_types.h" 2 3
# 60 "/usr/local/cuda/bin/../include/vector_types.h" 2 3
# 94 "/usr/local/cuda/bin/../include/vector_types.h" 3
struct char1
{
    signed char x;
};

struct uchar1
{
    unsigned char x;
};


struct __attribute__((aligned(2))) char2
{
    signed char x, y;
};

struct __attribute__((aligned(2))) uchar2
{
    unsigned char x, y;
};

struct char3
{
    signed char x, y, z;
};

struct uchar3
{
    unsigned char x, y, z;
};

struct __attribute__((aligned(4))) char4
{
    signed char x, y, z, w;
};

struct __attribute__((aligned(4))) uchar4
{
    unsigned char x, y, z, w;
};

struct short1
{
    short x;
};

struct ushort1
{
    unsigned short x;
};

struct __attribute__((aligned(4))) short2
{
    short x, y;
};

struct __attribute__((aligned(4))) ushort2
{
    unsigned short x, y;
};

struct short3
{
    short x, y, z;
};

struct ushort3
{
    unsigned short x, y, z;
};

struct __attribute__((aligned(8))) short4 { short x; short y; short z; short w; };
struct __attribute__((aligned(8))) ushort4 { unsigned short x; unsigned short y; unsigned short z; unsigned short w; };

struct int1
{
    int x;
};

struct uint1
{
    unsigned int x;
};

struct __attribute__((aligned(8))) int2 { int x; int y; };
struct __attribute__((aligned(8))) uint2 { unsigned int x; unsigned int y; };

struct int3
{
    int x, y, z;
};

struct uint3
{
    unsigned int x, y, z;
};

struct __attribute__((aligned(16))) int4
{
    int x, y, z, w;
};

struct __attribute__((aligned(16))) uint4
{
    unsigned int x, y, z, w;
};

struct long1
{
    long int x;
};

struct ulong1
{
    unsigned long x;
};






struct __attribute__((aligned(2*sizeof(long int)))) long2
{
    long int x, y;
};

struct __attribute__((aligned(2*sizeof(unsigned long int)))) ulong2
{
    unsigned long int x, y;
};



struct long3
{
    long int x, y, z;
};

struct ulong3
{
    unsigned long int x, y, z;
};

struct __attribute__((aligned(16))) long4
{
    long int x, y, z, w;
};

struct __attribute__((aligned(16))) ulong4
{
    unsigned long int x, y, z, w;
};

struct float1
{
    float x;
};

struct __attribute__((aligned(8))) float2 { float x; float y; };

struct float3
{
    float x, y, z;
};

struct __attribute__((aligned(16))) float4
{
    float x, y, z, w;
};

struct longlong1
{
    long long int x;
};

struct ulonglong1
{
    unsigned long long int x;
};

struct __attribute__((aligned(16))) longlong2
{
    long long int x, y;
};

struct __attribute__((aligned(16))) ulonglong2
{
    unsigned long long int x, y;
};

struct longlong3
{
    long long int x, y, z;
};

struct ulonglong3
{
    unsigned long long int x, y, z;
};

struct __attribute__((aligned(16))) longlong4
{
    long long int x, y, z ,w;
};

struct __attribute__((aligned(16))) ulonglong4
{
    unsigned long long int x, y, z, w;
};

struct double1
{
    double x;
};

struct __attribute__((aligned(16))) double2
{
    double x, y;
};

struct double3
{
    double x, y, z;
};

struct __attribute__((aligned(16))) double4
{
    double x, y, z, w;
};
# 338 "/usr/local/cuda/bin/../include/vector_types.h" 3
typedef struct char1 char1;
typedef struct uchar1 uchar1;
typedef struct char2 char2;
typedef struct uchar2 uchar2;
typedef struct char3 char3;
typedef struct uchar3 uchar3;
typedef struct char4 char4;
typedef struct uchar4 uchar4;
typedef struct short1 short1;
typedef struct ushort1 ushort1;
typedef struct short2 short2;
typedef struct ushort2 ushort2;
typedef struct short3 short3;
typedef struct ushort3 ushort3;
typedef struct short4 short4;
typedef struct ushort4 ushort4;
typedef struct int1 int1;
typedef struct uint1 uint1;
typedef struct int2 int2;
typedef struct uint2 uint2;
typedef struct int3 int3;
typedef struct uint3 uint3;
typedef struct int4 int4;
typedef struct uint4 uint4;
typedef struct long1 long1;
typedef struct ulong1 ulong1;
typedef struct long2 long2;
typedef struct ulong2 ulong2;
typedef struct long3 long3;
typedef struct ulong3 ulong3;
typedef struct long4 long4;
typedef struct ulong4 ulong4;
typedef struct float1 float1;
typedef struct float2 float2;
typedef struct float3 float3;
typedef struct float4 float4;
typedef struct longlong1 longlong1;
typedef struct ulonglong1 ulonglong1;
typedef struct longlong2 longlong2;
typedef struct ulonglong2 ulonglong2;
typedef struct longlong3 longlong3;
typedef struct ulonglong3 ulonglong3;
typedef struct longlong4 longlong4;
typedef struct ulonglong4 ulonglong4;
typedef struct double1 double1;
typedef struct double2 double2;
typedef struct double3 double3;
typedef struct double4 double4;







struct dim3
{
    unsigned int x, y, z;





};

typedef struct dim3 dim3;
# 60 "/usr/local/cuda/bin/../include/builtin_types.h" 2 3
# 185 "/usr/local/cuda/bin/../include/crt/device_runtime.h" 2 3
# 1 "/usr/local/cuda/bin/../include/device_launch_parameters.h" 1 3
# 66 "/usr/local/cuda/bin/../include/device_launch_parameters.h" 3
uint3 extern const threadIdx;
uint3 extern const blockIdx;
dim3 extern const blockDim;
dim3 extern const gridDim;
int extern const warpSize;
# 186 "/usr/local/cuda/bin/../include/crt/device_runtime.h" 2 3
# 1 "/usr/local/cuda/bin/../include/crt/storage_class.h" 1 3
# 186 "/usr/local/cuda/bin/../include/crt/device_runtime.h" 2 3
# 213 "/usr/lib/gcc/x86_64-linux-gnu/4.4.3/include/stddef.h" 2 3
# 77 "/usr/local/cuda/bin/../include/sm_20_atomic_functions.h"
static __inline__ float _Z9atomicAddPff(float *, float);
# 64 "txInterpTest.cu"
extern __inline__ int _Z8ImageFcnff(float, float);
# 80 "txInterpTest.cu"
extern __inline__ int _Z8ImageFcnii(int, int);
# 195 "txInterpTest.cu"
extern void _Z11mrt_collideRfS_S_S_S_S_S_S_S_f(float *, float *, float *, float *, float *, float *, float *, float *, float *, float);
# 243 "txInterpTest.cu"
extern void _Z11NeumannEastRfS_S_S_S_S_S_S_S_i(float *, float *, float *, float *, float *, float *, float *, float *, float *, int);
# 266 "txInterpTest.cu"
extern void _Z13DirichletWestRfS_S_S_S_S_S_S_S_i(float *, float *, float *, float *, float *, float *, float *, float *, float *, int);
# 291 "txInterpTest.cu"
extern void _Z10boundariesRfS_S_S_S_S_S_S_S_ii(float *, float *, float *, float *, float *, float *, float *, float *, float *, int, int);
# 319 "txInterpTest.cu"
extern void _Z16boundaries_forceRfS_S_S_S_S_S_S_S_ii(float *, float *, float *, float *, float *, float *, float *, float *, float *, int, int);
# 359 "txInterpTest.cu"
extern int _Z4dminii(int, int);
# 364 "txInterpTest.cu"
extern int _Z4dmaxi(int);
# 370 "txInterpTest.cu"
__attribute__((global)) __attribute__((__used__)) extern void _Z11simple_copyPfS_Pifm(float *, float *, int *, float, size_t);
# 381 "txInterpTest.cu"
__attribute__((global)) __attribute__((__used__)) extern void _Z14ExtractFromC_dPfmf(float *, size_t, float);
# 449 "txInterpTest.cu"
__attribute__((global)) __attribute__((__used__)) extern void _Z18LR_d_hybABCD_forcePfS_fmS_S_i(float *, float *, float, size_t, float *, float *, int);
# 543 "txInterpTest.cu"
__attribute__((global)) __attribute__((__used__)) extern void _Z18LR_d_hybBACD_forcePfS_fmS_S_i(float *, float *, float, size_t, float *, float *, int);
# 638 "txInterpTest.cu"
__attribute__((global)) __attribute__((__used__)) extern void _Z12LR_d_hybABCDPfS_fm(float *, float *, float, size_t);
# 693 "txInterpTest.cu"
__attribute__((global)) __attribute__((__used__)) extern void _Z13LR_d_hybABCD2PfS_fmi(float *, float *, float, size_t, int);
# 751 "txInterpTest.cu"
__attribute__((global)) __attribute__((__used__)) extern void _Z13LR_d_hybABDC2PfS_fmfi(float *, float *, float, size_t, float, int);
# 805 "txInterpTest.cu"
__attribute__((global)) __attribute__((__used__)) extern void _Z10LR_d_ABDC2PfS_fmf(float *, float *, float, size_t, float);
# 860 "txInterpTest.cu"
__attribute__((global)) __attribute__((__used__)) extern void _Z16LR_d_ABDC_InterpPfS_fmf(float *, float *, float, size_t, float);
# 943 "txInterpTest.cu"
__attribute__((global)) __attribute__((__used__)) extern void _Z19LR_d_hybABDC_InterpPfS_fmf(float *, float *, float, size_t, float);
# 1025 "txInterpTest.cu"
__attribute__((global)) __attribute__((__used__)) extern void _Z12LR_d_hybBACDPfS_fm(float *, float *, float, size_t);
# 1077 "txInterpTest.cu"
__attribute__((global)) __attribute__((__used__)) extern void _Z13LR_d_hybBACD2PfS_fmi(float *, float *, float, size_t, int);
# 1129 "txInterpTest.cu"
__attribute__((global)) __attribute__((__used__)) extern void _Z10LR_d_BACD2PfS_fm(float *, float *, float, size_t);
# 1182 "txInterpTest.cu"
__attribute__((global)) __attribute__((__used__)) extern void _Z12LR_d_hybBADCPfS_fmf(float *, float *, float, size_t, float);
# 1235 "txInterpTest.cu"
__attribute__((global)) __attribute__((__used__)) extern void _Z13LR_d_hybBADC2PfS_fmfi(float *, float *, float, size_t, float, int);
# 1288 "txInterpTest.cu"
__attribute__((global)) __attribute__((__used__)) extern void _Z10LR_d_BADC2PfS_fmf(float *, float *, float, size_t, float);
# 1342 "txInterpTest.cu"
__attribute__((global)) __attribute__((__used__)) extern void _Z19LR_d_hybBADC_InterpPfS_fmf(float *, float *, float, size_t, float);
# 1423 "txInterpTest.cu"
__attribute__((global)) __attribute__((__used__)) extern void _Z9LR_d_ABCDPfS_fm(float *, float *, float, size_t);
# 1474 "txInterpTest.cu"
__attribute__((global)) __attribute__((__used__)) extern void _Z10LR_d_ABCD2PfS_fm(float *, float *, float, size_t);
# 1526 "txInterpTest.cu"
__attribute__((global)) __attribute__((__used__)) extern void _Z9LR_d_ABDCPfS_fmf(float *, float *, float, size_t, float);
# 1624 "txInterpTest.cu"
__attribute__((global)) __attribute__((__used__)) extern void _Z9LR_d_BACDPfS_fm(float *, float *, float, size_t);
# 1676 "txInterpTest.cu"
__attribute__((global)) __attribute__((__used__)) extern void _Z16LR_d_BADC_InterpPfS_fmf(float *, float *, float, size_t, float);
# 1774 "txInterpTest.cu"
__attribute__((global)) __attribute__((__used__)) extern void _Z12mrt_d_singlePfS_fm(float *, float *, float, size_t);
# 1839 "txInterpTest.cu"
__attribute__((global)) __attribute__((__used__)) extern void _Z18mrt_d_single_forcePfS_fmS_S_i(float *, float *, float, size_t, float *, float *, int);
# 1936 "txInterpTest.cu"
__attribute__((global)) __attribute__((__used__)) extern void _Z17mrt_d_hybAB_forcePfS_fmS_S_i(float *, float *, float, size_t, float *, float *, int);
# 2054 "txInterpTest.cu"
__attribute__((global)) __attribute__((__used__)) extern void _Z17mrt_d_hybBA_forcePfS_fmS_S_i(float *, float *, float, size_t, float *, float *, int);
# 2172 "txInterpTest.cu"
__attribute__((global)) __attribute__((__used__)) extern void _Z11mrt_d_hybABPfS_fm(float *, float *, float, size_t);
# 2245 "txInterpTest.cu"
__attribute__((global)) __attribute__((__used__)) extern void _Z11mrt_d_hybBAPfS_fm(float *, float *, float, size_t);
# 2316 "txInterpTest.cu"
__attribute__((global)) __attribute__((__used__)) extern void _Z12mrt_d_textABPfS_fm(float *, float *, float, size_t);
# 2371 "txInterpTest.cu"
__attribute__((global)) __attribute__((__used__)) extern void _Z12mrt_d_textBAPfS_fm(float *, float *, float, size_t);
# 2428 "txInterpTest.cu"
__attribute__((global)) __attribute__((__used__)) extern void _Z8mrt_d_LRPfS_fmf(float *, float *, float, size_t, float);
# 2493 "txInterpTest.cu"
__attribute__((global)) __attribute__((__used__)) extern void _Z17initialize_singlePfm(float *, size_t);
# 2518 "txInterpTest.cu"
__attribute__((global)) __attribute__((__used__)) extern void _Z13initialize_LRPfm(float *, size_t);
# 107 "txInterpTest.cu"
static __attribute__((__used__)) __attribute__((__texture__)) __texture_type__ texRef_f0A;
# 108 "txInterpTest.cu"
static __attribute__((__used__)) __attribute__((__texture__)) __texture_type__ texRef_f1A;
# 109 "txInterpTest.cu"
static __attribute__((__used__)) __attribute__((__texture__)) __texture_type__ texRef_f2A;
# 110 "txInterpTest.cu"
static __attribute__((__used__)) __attribute__((__texture__)) __texture_type__ texRef_f3A;
# 111 "txInterpTest.cu"
static __attribute__((__used__)) __attribute__((__texture__)) __texture_type__ texRef_f4A;
# 112 "txInterpTest.cu"
static __attribute__((__used__)) __attribute__((__texture__)) __texture_type__ texRef_f5A;
# 113 "txInterpTest.cu"
static __attribute__((__used__)) __attribute__((__texture__)) __texture_type__ texRef_f6A;
# 114 "txInterpTest.cu"
static __attribute__((__used__)) __attribute__((__texture__)) __texture_type__ texRef_f7A;
# 115 "txInterpTest.cu"
static __attribute__((__used__)) __attribute__((__texture__)) __texture_type__ texRef_f8A;
# 117 "txInterpTest.cu"
static __attribute__((__used__)) __attribute__((__texture__)) __texture_type__ texRef_f0B;
# 118 "txInterpTest.cu"
static __attribute__((__used__)) __attribute__((__texture__)) __texture_type__ texRef_f1B;
# 119 "txInterpTest.cu"
static __attribute__((__used__)) __attribute__((__texture__)) __texture_type__ texRef_f2B;
# 120 "txInterpTest.cu"
static __attribute__((__used__)) __attribute__((__texture__)) __texture_type__ texRef_f3B;
# 121 "txInterpTest.cu"
static __attribute__((__used__)) __attribute__((__texture__)) __texture_type__ texRef_f4B;
# 122 "txInterpTest.cu"
static __attribute__((__used__)) __attribute__((__texture__)) __texture_type__ texRef_f5B;
# 123 "txInterpTest.cu"
static __attribute__((__used__)) __attribute__((__texture__)) __texture_type__ texRef_f6B;
# 124 "txInterpTest.cu"
static __attribute__((__used__)) __attribute__((__texture__)) __texture_type__ texRef_f7B;
# 125 "txInterpTest.cu"
static __attribute__((__used__)) __attribute__((__texture__)) __texture_type__ texRef_f8B;
# 127 "txInterpTest.cu"
static __attribute__((__used__)) __attribute__((__texture__)) __texture_type__ texRef_f0C;
# 128 "txInterpTest.cu"
static __attribute__((__used__)) __attribute__((__texture__)) __texture_type__ texRef_f1C;
# 129 "txInterpTest.cu"
static __attribute__((__used__)) __attribute__((__texture__)) __texture_type__ texRef_f2C;
# 130 "txInterpTest.cu"
static __attribute__((__used__)) __attribute__((__texture__)) __texture_type__ texRef_f3C;
# 131 "txInterpTest.cu"
static __attribute__((__used__)) __attribute__((__texture__)) __texture_type__ texRef_f4C;
# 132 "txInterpTest.cu"
static __attribute__((__used__)) __attribute__((__texture__)) __texture_type__ texRef_f5C;
# 133 "txInterpTest.cu"
static __attribute__((__used__)) __attribute__((__texture__)) __texture_type__ texRef_f6C;
# 134 "txInterpTest.cu"
static __attribute__((__used__)) __attribute__((__texture__)) __texture_type__ texRef_f7C;
# 135 "txInterpTest.cu"
static __attribute__((__used__)) __attribute__((__texture__)) __texture_type__ texRef_f8C;
# 137 "txInterpTest.cu"
static __attribute__((__used__)) __attribute__((__texture__)) __texture_type__ texRef_f0D;
# 138 "txInterpTest.cu"
static __attribute__((__used__)) __attribute__((__texture__)) __texture_type__ texRef_f1D;
# 139 "txInterpTest.cu"
static __attribute__((__used__)) __attribute__((__texture__)) __texture_type__ texRef_f2D;
# 140 "txInterpTest.cu"
static __attribute__((__used__)) __attribute__((__texture__)) __texture_type__ texRef_f3D;
# 141 "txInterpTest.cu"
static __attribute__((__used__)) __attribute__((__texture__)) __texture_type__ texRef_f4D;
# 142 "txInterpTest.cu"
static __attribute__((__used__)) __attribute__((__texture__)) __texture_type__ texRef_f5D;
# 143 "txInterpTest.cu"
static __attribute__((__used__)) __attribute__((__texture__)) __texture_type__ texRef_f6D;
# 144 "txInterpTest.cu"
static __attribute__((__used__)) __attribute__((__texture__)) __texture_type__ texRef_f7D;
# 145 "txInterpTest.cu"
static __attribute__((__used__)) __attribute__((__texture__)) __texture_type__ texRef_f8D;
# 1 "/usr/local/cuda/bin/../include/common_functions.h" 1
# 159 "/usr/local/cuda/bin/../include/common_functions.h"
# 1 "/usr/local/cuda/bin/../include/math_functions.h" 1 3
# 2935 "/usr/local/cuda/bin/../include/math_functions.h" 3
# 1 "/usr/local/cuda/bin/../include/math_constants.h" 1 3
# 2936 "/usr/local/cuda/bin/../include/math_functions.h" 2 3






# 1 "/usr/local/cuda/bin/../include/device_functions.h" 1 3
# 1249 "/usr/local/cuda/bin/../include/device_functions.h" 3
static __inline__ __attribute__((always_inline)) float __sinf(float a)
{
  return __builtin_sinf(a);
}

static __inline__ __attribute__((always_inline)) float __cosf(float a)
{
  return __builtin_cosf(a);
}

static __inline__ __attribute__((always_inline)) float __log2f(float a)
{
  return __builtin_log2f(a);
}







static __inline__ __attribute__((always_inline)) float __tanf(float a)
{
  return __fdividef (__sinf(a), __cosf(a));
}

static __inline__ __attribute__((always_inline)) void __sincosf(float a, float *sptr, float *cptr)
{
  *sptr = __sinf(a);
  *cptr = __cosf(a);
}

static __inline__ __attribute__((always_inline)) float __expf(float a)
{
  return exp2f(a * 1.442695041f);
}

static __inline__ __attribute__((always_inline)) float __exp10f(float a)
{
  return exp2f(a * 3.321928094f);
}

static __inline__ __attribute__((always_inline)) float __log10f(float a)
{
  return 0.301029996f * __log2f(a);
}

static __inline__ __attribute__((always_inline)) float __logf(float a)
{
  return 0.693147181f * __log2f(a);
}

static __inline__ __attribute__((always_inline)) float __powf(float a, float b)
{
  return exp2f(b * __log2f(a));
}

static __inline__ __attribute__((always_inline)) float fdividef(float a, float b)
{



  return a / b;

}
# 1326 "/usr/local/cuda/bin/../include/device_functions.h" 3
static __inline__ __attribute__((always_inline)) double fdivide(double a, double b)
{
  return a / b;
}
# 1360 "/usr/local/cuda/bin/../include/device_functions.h" 3
static __inline__ __attribute__((always_inline)) int __hadd(int a, int b)
{
  return (a & b) + ((a ^ b) >> 1);
}

static __inline__ __attribute__((always_inline)) int __rhadd(int a, int b)
{
  return (a | b) - ((a ^ b) >> 1);
}

static __inline__ __attribute__((always_inline)) unsigned int __uhadd(unsigned int a, unsigned int b)
{
  return (a & b) + ((a ^ b) >> 1);
}

static __inline__ __attribute__((always_inline)) unsigned int __urhadd(unsigned int a, unsigned int b)
{
  return (a | b) - ((a ^ b) >> 1);
}
# 3400 "/usr/local/cuda/bin/../include/device_functions.h" 3
static __inline__ __attribute__((always_inline)) int __ffs(int a)
{
  return 32 - __clz(a & -a);
}

static __inline__ __attribute__((always_inline)) int __ffsll(long long int a)
{
  return 64 - __clzll(a & -a);
}
# 3418 "/usr/local/cuda/bin/../include/device_functions.h" 3
# 1 "/usr/local/cuda/bin/../include/sm_11_atomic_functions.h" 1 3
# 3419 "/usr/local/cuda/bin/../include/device_functions.h" 2 3
# 1 "/usr/local/cuda/bin/../include/sm_12_atomic_functions.h" 1 3
# 3420 "/usr/local/cuda/bin/../include/device_functions.h" 2 3
# 1 "/usr/local/cuda/bin/../include/sm_13_double_functions.h" 1 3
# 3421 "/usr/local/cuda/bin/../include/device_functions.h" 2 3
# 1 "/usr/local/cuda/bin/../include/sm_20_atomic_functions.h" 1 3
# 3422 "/usr/local/cuda/bin/../include/device_functions.h" 2 3
# 1 "/usr/local/cuda/bin/../include/sm_20_intrinsics.h" 1 3
# 3423 "/usr/local/cuda/bin/../include/device_functions.h" 2 3
# 1 "/usr/local/cuda/bin/../include/sm_30_intrinsics.h" 1 3
# 3424 "/usr/local/cuda/bin/../include/device_functions.h" 2 3
# 1 "/usr/local/cuda/bin/../include/surface_functions.h" 1 3
# 4487 "/usr/local/cuda/bin/../include/surface_functions.h" 3
extern uchar1 __surf1Dreadc1(const void*, int, enum cudaSurfaceBoundaryMode);
extern uchar2 __surf1Dreadc2(const void*, int, enum cudaSurfaceBoundaryMode);
extern uchar4 __surf1Dreadc4(const void*, int, enum cudaSurfaceBoundaryMode);
extern ushort1 __surf1Dreads1(const void*, int, enum cudaSurfaceBoundaryMode);
extern ushort2 __surf1Dreads2(const void*, int, enum cudaSurfaceBoundaryMode);
extern ushort4 __surf1Dreads4(const void*, int, enum cudaSurfaceBoundaryMode);
extern uint1 __surf1Dreadu1(const void*, int, enum cudaSurfaceBoundaryMode);
extern uint2 __surf1Dreadu2(const void*, int, enum cudaSurfaceBoundaryMode);
extern uint4 __surf1Dreadu4(const void*, int, enum cudaSurfaceBoundaryMode);
extern ulonglong1 __surf1Dreadl1(const void*, int, enum cudaSurfaceBoundaryMode);
extern ulonglong2 __surf1Dreadl2(const void*, int, enum cudaSurfaceBoundaryMode);
extern uchar1 __surf2Dreadc1(const void*, int, int, enum cudaSurfaceBoundaryMode);
extern uchar2 __surf2Dreadc2(const void*, int, int, enum cudaSurfaceBoundaryMode);
extern uchar4 __surf2Dreadc4(const void*, int, int, enum cudaSurfaceBoundaryMode);
extern ushort1 __surf2Dreads1(const void*, int, int, enum cudaSurfaceBoundaryMode);
extern ushort2 __surf2Dreads2(const void*, int, int, enum cudaSurfaceBoundaryMode);
extern ushort4 __surf2Dreads4(const void*, int, int, enum cudaSurfaceBoundaryMode);
extern uint1 __surf2Dreadu1(const void*, int, int, enum cudaSurfaceBoundaryMode);
extern uint2 __surf2Dreadu2(const void*, int, int, enum cudaSurfaceBoundaryMode);
extern uint4 __surf2Dreadu4(const void*, int, int, enum cudaSurfaceBoundaryMode);
extern ulonglong1 __surf2Dreadl1(const void*, int, int, enum cudaSurfaceBoundaryMode);
extern ulonglong2 __surf2Dreadl2(const void*, int, int, enum cudaSurfaceBoundaryMode);
extern uchar1 __surf3Dreadc1(const void*, int, int, int, enum cudaSurfaceBoundaryMode);
extern uchar2 __surf3Dreadc2(const void*, int, int, int, enum cudaSurfaceBoundaryMode);
extern uchar4 __surf3Dreadc4(const void*, int, int, int, enum cudaSurfaceBoundaryMode);
extern ushort1 __surf3Dreads1(const void*, int, int, int, enum cudaSurfaceBoundaryMode);
extern ushort2 __surf3Dreads2(const void*, int, int, int, enum cudaSurfaceBoundaryMode);
extern ushort4 __surf3Dreads4(const void*, int, int, int, enum cudaSurfaceBoundaryMode);
extern uint1 __surf3Dreadu1(const void*, int, int, int, enum cudaSurfaceBoundaryMode);
extern uint2 __surf3Dreadu2(const void*, int, int, int, enum cudaSurfaceBoundaryMode);
extern uint4 __surf3Dreadu4(const void*, int, int, int, enum cudaSurfaceBoundaryMode);
extern ulonglong1 __surf3Dreadl1(const void*, int, int, int, enum cudaSurfaceBoundaryMode);
extern ulonglong2 __surf3Dreadl2(const void*, int, int, int, enum cudaSurfaceBoundaryMode);
extern uchar1 __surf1DLayeredreadc1(const void*, int, int, enum cudaSurfaceBoundaryMode);
extern uchar2 __surf1DLayeredreadc2(const void*, int, int, enum cudaSurfaceBoundaryMode);
extern uchar4 __surf1DLayeredreadc4(const void*, int, int, enum cudaSurfaceBoundaryMode);
extern ushort1 __surf1DLayeredreads1(const void*, int, int, enum cudaSurfaceBoundaryMode);
extern ushort2 __surf1DLayeredreads2(const void*, int, int, enum cudaSurfaceBoundaryMode);
extern ushort4 __surf1DLayeredreads4(const void*, int, int, enum cudaSurfaceBoundaryMode);
extern uint1 __surf1DLayeredreadu1(const void*, int, int, enum cudaSurfaceBoundaryMode);
extern uint2 __surf1DLayeredreadu2(const void*, int, int, enum cudaSurfaceBoundaryMode);
extern uint4 __surf1DLayeredreadu4(const void*, int, int, enum cudaSurfaceBoundaryMode);
extern ulonglong1 __surf1DLayeredreadl1(const void*, int, int, enum cudaSurfaceBoundaryMode);
extern ulonglong2 __surf1DLayeredreadl2(const void*, int, int, enum cudaSurfaceBoundaryMode);
extern uchar1 __surf2DLayeredreadc1(const void*, int, int, int, enum cudaSurfaceBoundaryMode);
extern uchar2 __surf2DLayeredreadc2(const void*, int, int, int, enum cudaSurfaceBoundaryMode);
extern uchar4 __surf2DLayeredreadc4(const void*, int, int, int, enum cudaSurfaceBoundaryMode);
extern ushort1 __surf2DLayeredreads1(const void*, int, int, int, enum cudaSurfaceBoundaryMode);
extern ushort2 __surf2DLayeredreads2(const void*, int, int, int, enum cudaSurfaceBoundaryMode);
extern ushort4 __surf2DLayeredreads4(const void*, int, int, int, enum cudaSurfaceBoundaryMode);
extern uint1 __surf2DLayeredreadu1(const void*, int, int, int, enum cudaSurfaceBoundaryMode);
extern uint2 __surf2DLayeredreadu2(const void*, int, int, int, enum cudaSurfaceBoundaryMode);
extern uint4 __surf2DLayeredreadu4(const void*, int, int, int, enum cudaSurfaceBoundaryMode);
extern ulonglong1 __surf2DLayeredreadl1(const void*, int, int, int, enum cudaSurfaceBoundaryMode);
extern ulonglong2 __surf2DLayeredreadl2(const void*, int, int, int, enum cudaSurfaceBoundaryMode);
extern void __surf1Dwritec1( uchar1, const void*, int, enum cudaSurfaceBoundaryMode);
extern void __surf1Dwritec2( uchar2, const void*, int, enum cudaSurfaceBoundaryMode);
extern void __surf1Dwritec4( uchar4, const void*, int, enum cudaSurfaceBoundaryMode);
extern void __surf1Dwrites1( ushort1, const void*, int, enum cudaSurfaceBoundaryMode);
extern void __surf1Dwrites2( ushort2, const void*, int, enum cudaSurfaceBoundaryMode);
extern void __surf1Dwrites4( ushort4, const void*, int, enum cudaSurfaceBoundaryMode);
extern void __surf1Dwriteu1( uint1, const void*, int, enum cudaSurfaceBoundaryMode);
extern void __surf1Dwriteu2( uint2, const void*, int, enum cudaSurfaceBoundaryMode);
extern void __surf1Dwriteu4( uint4, const void*, int, enum cudaSurfaceBoundaryMode);
extern void __surf1Dwritel1(ulonglong1, const void*, int, enum cudaSurfaceBoundaryMode);
extern void __surf1Dwritel2(ulonglong2, const void*, int, enum cudaSurfaceBoundaryMode);
extern void __surf2Dwritec1( uchar1, const void*, int, int, enum cudaSurfaceBoundaryMode);
extern void __surf2Dwritec2( uchar2, const void*, int, int, enum cudaSurfaceBoundaryMode);
extern void __surf2Dwritec4( uchar4, const void*, int, int, enum cudaSurfaceBoundaryMode);
extern void __surf2Dwrites1( ushort1, const void*, int, int, enum cudaSurfaceBoundaryMode);
extern void __surf2Dwrites2( ushort2, const void*, int, int, enum cudaSurfaceBoundaryMode);
extern void __surf2Dwrites4( ushort4, const void*, int, int, enum cudaSurfaceBoundaryMode);
extern void __surf2Dwriteu1( uint1, const void*, int, int, enum cudaSurfaceBoundaryMode);
extern void __surf2Dwriteu2( uint2, const void*, int, int, enum cudaSurfaceBoundaryMode);
extern void __surf2Dwriteu4( uint4, const void*, int, int, enum cudaSurfaceBoundaryMode);
extern void __surf2Dwritel1(ulonglong1, const void*, int, int, enum cudaSurfaceBoundaryMode);
extern void __surf2Dwritel2(ulonglong2, const void*, int, int, enum cudaSurfaceBoundaryMode);
extern void __surf3Dwritec1( uchar1 val, const void*, int, int, int, enum cudaSurfaceBoundaryMode);
extern void __surf3Dwritec2( uchar2 val, const void*, int, int, int, enum cudaSurfaceBoundaryMode);
extern void __surf3Dwritec4( uchar4 val, const void*, int, int, int, enum cudaSurfaceBoundaryMode);
extern void __surf3Dwrites1( ushort1 val, const void*, int, int, int, enum cudaSurfaceBoundaryMode);
extern void __surf3Dwrites2( ushort2 val, const void*, int, int, int, enum cudaSurfaceBoundaryMode);
extern void __surf3Dwrites4( ushort4 val, const void*, int, int, int, enum cudaSurfaceBoundaryMode);
extern void __surf3Dwriteu1( uint1 val, const void*, int, int, int, enum cudaSurfaceBoundaryMode);
extern void __surf3Dwriteu2( uint2 val, const void*, int, int, int, enum cudaSurfaceBoundaryMode);
extern void __surf3Dwriteu4( uint4 val, const void*, int, int, int, enum cudaSurfaceBoundaryMode);
extern void __surf3Dwritel1(ulonglong1 val, const void*, int, int, int, enum cudaSurfaceBoundaryMode);
extern void __surf3Dwritel2(ulonglong2 val, const void*, int, int, int, enum cudaSurfaceBoundaryMode);
extern void __surf1DLayeredwritec1( uchar1 val, const void*, int, int, enum cudaSurfaceBoundaryMode);
extern void __surf1DLayeredwritec2( uchar2 val, const void*, int, int, enum cudaSurfaceBoundaryMode);
extern void __surf1DLayeredwritec4( uchar4 val, const void*, int, int, enum cudaSurfaceBoundaryMode);
extern void __surf1DLayeredwrites1( ushort1 val, const void*, int, int, enum cudaSurfaceBoundaryMode);
extern void __surf1DLayeredwrites2( ushort2 val, const void*, int, int, enum cudaSurfaceBoundaryMode);
extern void __surf1DLayeredwrites4( ushort4 val, const void*, int, int, enum cudaSurfaceBoundaryMode);
extern void __surf1DLayeredwriteu1( uint1 val, const void*, int, int, enum cudaSurfaceBoundaryMode);
extern void __surf1DLayeredwriteu2( uint2 val, const void*, int, int, enum cudaSurfaceBoundaryMode);
extern void __surf1DLayeredwriteu4( uint4 val, const void*, int, int, enum cudaSurfaceBoundaryMode);
extern void __surf1DLayeredwritel1(ulonglong1 val, const void*, int, int, enum cudaSurfaceBoundaryMode);
extern void __surf1DLayeredwritel2(ulonglong2 val, const void*, int, int, enum cudaSurfaceBoundaryMode);
extern void __surf2DLayeredwritec1( uchar1 val, const void*, int, int, int, enum cudaSurfaceBoundaryMode);
extern void __surf2DLayeredwritec2( uchar2 val, const void*, int, int, int, enum cudaSurfaceBoundaryMode);
extern void __surf2DLayeredwritec4( uchar4 val, const void*, int, int, int, enum cudaSurfaceBoundaryMode);
extern void __surf2DLayeredwrites1( ushort1 val, const void*, int, int, int, enum cudaSurfaceBoundaryMode);
extern void __surf2DLayeredwrites2( ushort2 val, const void*, int, int, int, enum cudaSurfaceBoundaryMode);
extern void __surf2DLayeredwrites4( ushort4 val, const void*, int, int, int, enum cudaSurfaceBoundaryMode);
extern void __surf2DLayeredwriteu1( uint1 val, const void*, int, int, int, enum cudaSurfaceBoundaryMode);
extern void __surf2DLayeredwriteu2( uint2 val, const void*, int, int, int, enum cudaSurfaceBoundaryMode);
extern void __surf2DLayeredwriteu4( uint4 val, const void*, int, int, int, enum cudaSurfaceBoundaryMode);
extern void __surf2DLayeredwritel1(ulonglong1 val, const void*, int, int, int, enum cudaSurfaceBoundaryMode);
extern void __surf2DLayeredwritel2(ulonglong2 val, const void*, int, int, int, enum cudaSurfaceBoundaryMode);
# 3425 "/usr/local/cuda/bin/../include/device_functions.h" 2 3
# 1 "/usr/local/cuda/bin/../include/texture_fetch_functions.h" 1 3
# 3690 "/usr/local/cuda/bin/../include/texture_fetch_functions.h" 3
extern uint4 __utexfetchi1D(const void*, int4);
extern int4 __itexfetchi1D(const void*, int4);
extern float4 __ftexfetchi1D(const void*, int4);
extern uint4 __utexfetch1D(const void*, float4);
extern int4 __itexfetch1D(const void*, float4);
extern float4 __ftexfetch1D(const void*, float4);
extern uint4 __utexfetch2D(const void*, float4);
extern int4 __itexfetch2D(const void*, float4);
extern float4 __ftexfetch2D(const void*, float4);
extern uint4 __utexfetch3D(const void*, float4);
extern int4 __itexfetch3D(const void*, float4);
extern float4 __ftexfetch3D(const void*, float4);
extern uint4 __utexfetchcube(const void*, float4);
extern int4 __itexfetchcube(const void*, float4);
extern float4 __ftexfetchcube(const void*, float4);
extern uint4 __utexfetchl1D(const void*, float4, int);
extern int4 __itexfetchl1D(const void*, float4, int);
extern float4 __ftexfetchl1D(const void*, float4, int);
extern uint4 __utexfetchl2D(const void*, float4, int);
extern int4 __itexfetchl2D(const void*, float4, int);
extern float4 __ftexfetchl2D(const void*, float4, int);
extern uint4 __utexfetchlcube(const void*, float4, int);
extern int4 __itexfetchlcube(const void*, float4, int);
extern float4 __ftexfetchlcube(const void*, float4, int);
# 4082 "/usr/local/cuda/bin/../include/texture_fetch_functions.h" 3
extern uint4 __utex2Dgather0(const void*, float2);
extern uint4 __utex2Dgather1(const void*, float2);
extern uint4 __utex2Dgather2(const void*, float2);
extern uint4 __utex2Dgather3(const void*, float2);
extern int4 __itex2Dgather0(const void*, float2);
extern int4 __itex2Dgather1(const void*, float2);
extern int4 __itex2Dgather2(const void*, float2);
extern int4 __itex2Dgather3(const void*, float2);
extern float4 __ftex2Dgather0(const void*, float2);
extern float4 __ftex2Dgather1(const void*, float2);
extern float4 __ftex2Dgather2(const void*, float2);
extern float4 __ftex2Dgather3(const void*, float2);
# 3426 "/usr/local/cuda/bin/../include/device_functions.h" 2 3
# 2943 "/usr/local/cuda/bin/../include/math_functions.h" 2 3
# 2956 "/usr/local/cuda/bin/../include/math_functions.h" 3
static __inline__ __attribute__((always_inline)) float rintf(float a)
{
  return __builtin_roundf(a);
}

static __inline__ __attribute__((always_inline)) long int lrintf(float a)
{

  return (long int)__float2ll_rn(a);



}

static __inline__ __attribute__((always_inline)) long long int llrintf(float a)
{
  return __float2ll_rn(a);
}

static __inline__ __attribute__((always_inline)) float nearbyintf(float a)
{
  return __builtin_roundf(a);
}







static __inline__ __attribute__((always_inline)) int __signbitf(float a)
{
  return (int)((unsigned int)__float_as_int(a) >> 31);
}




static __inline__ __attribute__((always_inline)) float copysignf(float a, float b)
{
  return __int_as_float((__float_as_int(b) & 0x80000000) |
                        (__float_as_int(a) & ~0x80000000));
}

static __inline__ __attribute__((always_inline)) int __finitef(float a)
{
  return fabsf(a) < __int_as_float(0x7f800000);
}
# 3014 "/usr/local/cuda/bin/../include/math_functions.h" 3
static __inline__ __attribute__((always_inline)) int __isinff(float a)
{
  return fabsf(a) == __int_as_float(0x7f800000);
}

static __inline__ __attribute__((always_inline)) int __isnanf(float a)
{
  return !(fabsf(a) <= __int_as_float(0x7f800000));
}

static __inline__ __attribute__((always_inline)) float nextafterf(float a, float b)
{
  unsigned int ia;
  unsigned int ib;
  ia = __float_as_int(a);
  ib = __float_as_int(b);




  if (__isnanf(a) || __isnanf(b)) return a + b;
  if (__int_as_float (ia | ib) == 0.0f) return __int_as_float(ib);





  if (__int_as_float(ia) == 0.0f) {
    return __int_as_float (0x00000001 | (__float_as_int(b) & 0x80000000));
  }

  if ((a < b) && (a < 0.0f)) ia--;
  if ((a < b) && (a > 0.0f)) ia++;
  if ((a > b) && (a < 0.0f)) ia++;
  if ((a > b) && (a > 0.0f)) ia--;
  a = __int_as_float(ia);





  return a;
}

static __inline__ __attribute__((always_inline)) unsigned long long int __internal_nan_kernel(const char *s)
{
  unsigned long long i = 0;
  int c;
  int ovfl = 0;
  int invld = 0;
  if (s && (*s == '0')) {
    s++;
    if ((*s == 'x') || (*s == 'X')) {
      s++;
      while (*s == '0') s++;
      while (*s) {
        if (i > 0x0fffffffffffffffULL) {
          ovfl = 1;
        }
        c = (((*s) >= 'A') && ((*s) <= 'F')) ? (*s + 'a' - 'A') : (*s);
        if ((c >= 'a') && (c <= 'f')) {
          c = c - 'a' + 10;
          i = i * 16 + c;
        } else if ((c >= '0') && (c <= '9')) {
          c = c - '0';
          i = i * 16 + c;
        } else {
          invld = 1;
        }
        s++;
      }
    } else {
      while (*s == '0') s++;
      while (*s) {
        if (i > 0x1fffffffffffffffULL) {
          ovfl = 1;
        }
        c = *s;
        if ((c >= '0') && (c <= '7')) {
          c = c - '0';
          i = i * 8 + c;
        } else {
          invld = 1;
        }
        s++;
      }
    }
  } else if (s) {
    while (*s) {
      c = *s;
      if ((i > 1844674407370955161ULL) ||
          ((i == 1844674407370955161ULL) && (c > '5'))) {
        ovfl = 1;
      }
      if ((c >= '0') && (c <= '9')) {
        c = c - '0';
        i = i * 10 + c;
      } else {
        invld = 1;
      }
      s++;
    }
  }
  if (ovfl) {
    i = ~0ULL;
  }
  if (invld) {
    i = 0ULL;
  }
  i = (i & 0x000fffffffffffffULL) | 0x7ff8000000000000ULL;
  return i;
}

static __inline__ __attribute__((always_inline)) float nanf(const char *tagp)
{
  return __int_as_float(0x7fffffff);
}

static __inline__ __attribute__((always_inline)) float __internal_fmad(float a, float b, float c)
{

  return __fmaf_rn (a, b, c);





}

static __inline__ __attribute__((always_inline)) float __internal_fast_rcpf(float a)
{
  float r;
  asm ("rcp.approx.ftz.f32 %0,%1;" : "=f"(r) : "f"(a));
  return r;
}


static __inline__ __attribute__((always_inline)) float __internal_atanhf_kernel(float a_1, float a_2)
{
  float a, a2, t;

  a = __fadd_rn (a_1, a_2);
  a2 = a * a;
  t = 1.566305595598990E-001f/64.0f;
  t = __internal_fmad (t, a2, 1.995081856004762E-001f/16.0f);
  t = __internal_fmad (t, a2, 3.333382699617026E-001f/4.0f);
  t = t * a2;
  t = __internal_fmad (t, a, a_2);
  t = t + a_1;
  return t;
}




static __inline__ __attribute__((always_inline)) float __internal_atanf_kernel(float a)
{
  float t4, t0, t1;

  t4 = __fmul_rn (a, a);
  t0 = -5.674867153f;
  t0 = __internal_fmad (t4, -0.823362947f, t0);
  t0 = __internal_fmad (t0, t4, -6.565555096f);
  t0 = t0 * t4;
  t0 = t0 * a;
  t1 = t4 + 11.33538818f;
  t1 = __internal_fmad (t1, t4, 28.84246826f);
  t1 = __internal_fmad (t1, t4, 19.69667053f);
  t1 = 1.0f / t1;
  a = __internal_fmad (t0, t1, a);
  return a;
}


static __inline__ __attribute__((always_inline)) float __internal_tan_kernel(float a)
{
  float a2, s, t;

  a2 = a * a;
  t = __internal_fmad (4.114678393115178E-003f, a2, -8.231194034909670E-001f);
  s = a2 - 2.469348886157666E+000f;
  s = 1.0f / s;
  t = t * s;
  t = t * a2;
  t = __internal_fmad (t, a, a);
  return t;
}

static __inline__ __attribute__((always_inline)) float __internal_accurate_logf(float a)
{
  float t;
  float z;
  float m;
  int ia;
  ia = __float_as_int(a);

  if ((a > 0.0f) && (a < __int_as_float(0x7f800000))) {
    int e = -127;


    if ((unsigned)ia < (unsigned)0x00800000) {
      a = a * 16777216.0f;
      e -= 24;
      ia = __float_as_int(a);
    }


    m = __int_as_float((ia & 0x807fffff) | 0x3f800000);
    e += ((unsigned)ia >> 23);
    if (m > 1.414213562f) {
      m = m * 0.5f;
      e = e + 1;
    }
    t = m - 1.0f;
    z = m + 1.0f;
    z = __fdividef (t, z);
    z = __fmul_rn (-t, z);
    z = __internal_atanhf_kernel(t, z);
    z = __internal_fmad ((float)e, 0.693147181f, z);
    return z;
  } else {

    return __logf(a);
  }
}

static __inline__ __attribute__((always_inline)) float2 __internal_log_ep(float a)
{
  float2 res;
  int expo;
  float m;
  float log_hi, log_lo;
  float t_hi, t_lo;
  float f, g, u, v, q;
  float r, s, e;
  expo = (__float_as_int(a) >> 23) & 0xff;


  if (expo == 0) {
    a *= 16777216.0f;
    expo = (__float_as_int(a) >> 23) & 0xff;
    expo -= 24;
  }

  expo -= 127;
  m = __int_as_float((__float_as_int(a) & 0x807fffff) | 0x3f800000);
  if (m > 1.414213562f) {
    m = m * 0.5f;
    expo = expo + 1;
  }






  f = m - 1.0f;
  g = m + 1.0f;
  g = 1.0f / g;
  u = 2.0f * f * g;
  v = u * u;
  q = 1.49356810919559350E-001f/64.0f;
  q = __internal_fmad (q, v, 1.99887797540072460E-001f/16.0f);
  q = __internal_fmad (q, v, 3.33333880955515580E-001f/4.0f);
  q = __fmul_rn (q, v);
  q = __fmul_rn (q, u);
  log_hi = __int_as_float(__float_as_int(u) & 0xfffff000);
  v = __int_as_float(__float_as_int(f) & 0xfffff000);
  u = 2.0f * (f - log_hi);
  f = f - v;
  u = __internal_fmad (-log_hi, v, u);
  u = __internal_fmad (-log_hi, f, u);
  u = __fmul_rn (g, u);



  r = log_hi + u;
  s = u - (r - log_hi);
  log_hi = r;
  log_lo = s;

  r = log_hi + q;
  s = ((log_hi - r) + q) + log_lo;
  log_hi = e = r + s;
  log_lo = (r - e) + s;


  t_hi = __fmul_rn (expo, 0.6931457519f);
  t_lo = __fmul_rn (expo, 1.4286067653e-6f);


  r = t_hi + log_hi;
  s = (((t_hi - r) + log_hi) + log_lo) + t_lo;
  res.y = e = r + s;
  res.x = (r - e) + s;
  return res;
}

static __inline__ __attribute__((always_inline)) float __internal_accurate_log2f(float a)
{
  return 1.442695041f * __internal_accurate_logf(a);
}




static __inline__ __attribute__((always_inline)) float2 __internal_dsmul (float2 x, float2 y)
{
    float2 z;
# 3336 "/usr/local/cuda/bin/../include/math_functions.h" 3
    float up, mh, ml;
    ml = __fmul_rn (x.y, y.y);
    mh = __fmaf_rn (x.y, y.y, -ml);
    mh = __fmaf_rn (x.y, y.x, mh);
    mh = __fmaf_rn (x.x, y.y, mh);
    z.y = up = __fadd_rn (ml, mh);
    z.x = __fadd_rn(__fadd_rn(ml, -up), mh);

    return z;
}


static __attribute__((constant)) unsigned int __cudart_i2opi_f [] = {
  0x3c439041,
  0xdb629599,
  0xf534ddc0,
  0xfc2757d1,
  0x4e441529,
  0xa2f9836e,
};


static

__inline__ __attribute__((always_inline))



float __internal_trig_reduction_slowpath(float a, int *quadrant)
{
  unsigned int ia = __float_as_int(a);
  unsigned int s = ia & 0x80000000;
  unsigned int result[7];
  unsigned int phi, plo;
  unsigned int hi, lo;
  unsigned int e;
  int idx;
  int q;
  e = ((ia >> 23) & 0xff) - 128;
  ia = (ia << 8) | 0x80000000;

  idx = 4 - (e >> 5);
  hi = 0;
#pragma unroll 1
  for (q = 0; q < 6; q++) {
    plo = __cudart_i2opi_f[q] * ia;
    phi = __umulhi (__cudart_i2opi_f[q], ia);
    lo = hi + plo;
    hi = phi + (lo < plo);
    result[q] = lo;
  }
  result[q] = hi;
  e = e & 31;



  hi = result[idx+2];
  lo = result[idx+1];
  if (e) {
    q = 32 - e;
    hi = (hi << e) + (lo >> q);
    lo = (lo << e) + (result[idx] >> q);
  }
  q = hi >> 30;

  hi = (hi << 2) + (lo >> 30);
  lo = (lo << 2);
  e = hi >> 31;
  q += e;
  if (s) q = -q;
  *quadrant = q;
  if (e) {
    unsigned int t;
    hi = ~hi;
    lo = -(int)lo;
    t = (lo == 0);
    hi += t;
    s = s ^ 0x80000000;
  }

  e = __clz(hi);
  if (e) {
      hi = (hi << e) + (lo >> (32 - e));
  }
  lo = hi * 0xc90fdaa2;
  hi = __umulhi(hi, 0xc90fdaa2);
  if ((int)hi > 0) {
    hi = (hi << 1) + (lo >> 31);
    e++;
  }
  ia = s | (((126 - e) << 23) + ((((hi + 1) >> 7) + 1) >> 1));
  return __int_as_float(ia);
}


static __inline__ __attribute__((always_inline)) float __internal_trig_reduction_kernel(float a, int *quadrant)
{
  float j, t;
  int q;
  q = __float2int_rn (a * 0.636619772f);
  j = (float)q;


  t = __fmaf_rn (-j, 1.5707962512969971e+000f, a);
  t = __fmaf_rn (-j, 7.5497894158615964e-008f, t);
  t = __fmaf_rn (-j, 5.3903029534742384e-015f, t);






  if (fabsf(a) > 48039.0f) {
    t = __internal_trig_reduction_slowpath (a, &q);
  }
  *quadrant = q;
  return t;
}

static __inline__ __attribute__((always_inline)) float __internal_expf_arg_reduction(float a, float *i)
{
  float j, z;

  j = truncf (a * 1.442695041f);
  z = __internal_fmad (j, -0.6931457519f, a);
  z = __internal_fmad (j, -1.4286067653e-6f, z);
  z = z * 1.442695041f;
  *i = j;
  return z;
}

static __inline__ __attribute__((always_inline)) float __internal_expf_kernel(float a, float scale)
{
  float j, z;

  z = __internal_expf_arg_reduction (a, &j);
  z = exp2f(z) * exp2f(j + scale);
  return z;
}

static __inline__ __attribute__((always_inline)) float __internal_expf_add_kernel(float a, float addend)
{
  float j, z;

  z = __internal_expf_arg_reduction (a, &j);
  z = __internal_fmad (exp2f(z), exp2f(j), addend);
  return z;
}

static __inline__ __attribute__((always_inline)) float __internal_accurate_expf(float a)
{
  float z;

  z = __internal_expf_kernel(a, 0.0f);
  if (a < -105.0f) z = 0.0f;
  if (a > 105.0f) z = __int_as_float(0x7f800000);
  return z;
}

static __inline__ __attribute__((always_inline)) float __internal_accurate_exp10f(float a)
{
  float j, z;

  j = truncf(a * 3.321928094f);
  z = __internal_fmad (j, -3.0102920532226563e-001f, a);
  z = __internal_fmad (j, -7.9034171557301747e-007f, z);
  z = z * 3.321928094f;
  z = exp2f(z) * exp2f(j);
  if (a < -46.0f) z = 0.0f;
  if (a > 46.0f) z = __int_as_float(0x7f800000);
  return z;
}

static __inline__ __attribute__((always_inline)) float __internal_lgammaf_pos(float a)
{
  float sum;
  float s, t;

  if (a == __int_as_float(0x7f800000)) {
    return a;
  }
  if (a >= 3.0f) {
    if (a >= 7.8f) {



      s = __internal_fast_rcpf (a);
      t = s * s;
      sum = 0.77783067e-3f;
      sum = __internal_fmad (sum, t, -0.2777655457e-2f);
      sum = __internal_fmad (sum, t, 0.83333273853e-1f);
      sum = __internal_fmad (sum, s, 0.918938533204672f);
      s = 0.5f * __internal_accurate_logf(a);
      t = a - 0.5f;
      s = __fmul_rn(s, t);
      t = s - a;
      s = __fadd_rn(s, sum);
      t = t + s;
      return t;
    } else {
      a = a - 3.0f;
      s = -7.488903254816711E+002f;
      s = __internal_fmad (s, a, -1.234974215949363E+004f);
      s = __internal_fmad (s, a, -4.106137688064877E+004f);
      s = __internal_fmad (s, a, -4.831066242492429E+004f);
      s = __internal_fmad (s, a, -1.430333998207429E+005f);
      t = a - 2.592509840117874E+002f;
      t = __internal_fmad (t, a, -1.077717972228532E+004f);
      t = __internal_fmad (t, a, -9.268505031444956E+004f);
      t = __internal_fmad (t, a, -2.063535768623558E+005f);
      t = __internal_fmad (s, __internal_fast_rcpf (t), a);
      return t;
    }
  } else if (a >= 1.5f) {
    a = a - 2.0f;
    t = 4.959849168282574E-005f;
    t = __internal_fmad (t, a, -2.208948403848352E-004f);
    t = __internal_fmad (t, a, 5.413142447864599E-004f);
    t = __internal_fmad (t, a, -1.204516976842832E-003f);
    t = __internal_fmad (t, a, 2.884251838546602E-003f);
    t = __internal_fmad (t, a, -7.382757963931180E-003f);
    t = __internal_fmad (t, a, 2.058131963026755E-002f);
    t = __internal_fmad (t, a, -6.735248600734503E-002f);
    t = __internal_fmad (t, a, 3.224670187176319E-001f);
    t = __internal_fmad (t, a, 4.227843368636472E-001f);
    t = t * a;
    return t;
  } else if (a >= 0.7f) {
    a = 1.0f - a;
    t = 4.588266515364258E-002f;
    t = __internal_fmad (t, a, 1.037396712740616E-001f);
    t = __internal_fmad (t, a, 1.228036339653591E-001f);
    t = __internal_fmad (t, a, 1.275242157462838E-001f);
    t = __internal_fmad (t, a, 1.432166835245778E-001f);
    t = __internal_fmad (t, a, 1.693435824224152E-001f);
    t = __internal_fmad (t, a, 2.074079329483975E-001f);
    t = __internal_fmad (t, a, 2.705875136435339E-001f);
    t = __internal_fmad (t, a, 4.006854436743395E-001f);
    t = __internal_fmad (t, a, 8.224669796332661E-001f);
    t = __internal_fmad (t, a, 5.772156651487230E-001f);
    t = t * a;
    return t;
  } else {
    t = 3.587515669447039E-003f;
    t = __internal_fmad (t, a, -5.471285428060787E-003f);
    t = __internal_fmad (t, a, -4.462712795343244E-002f);
    t = __internal_fmad (t, a, 1.673177015593242E-001f);
    t = __internal_fmad (t, a, -4.213597883575600E-002f);
    t = __internal_fmad (t, a, -6.558672843439567E-001f);
    t = __internal_fmad (t, a, 5.772153712885004E-001f);
    t = t * a;
    t = __internal_fmad (t, a, a);
    return -__internal_accurate_logf(t);
  }
}


static __inline__ __attribute__((always_inline)) float __internal_sin_kernel(float x)
{
  float x2, z;

  x2 = x * x;
  z = -1.95152959e-4f;
  z = __internal_fmad (z, x2, 8.33216087e-3f);
  z = __internal_fmad (z, x2, -1.66666546e-1f);
  z = z * x2;
  z = __internal_fmad (z, x, x);
  return z;
}


static __inline__ __attribute__((always_inline)) float __internal_cos_kernel(float x)
{
  float x2, z;

  x2 = x * x;
  z = 2.44331571e-5f;
  z = __internal_fmad (z, x2, -1.38873163e-3f);
  z = __internal_fmad (z, x2, 4.16666457e-2f);
  z = __internal_fmad (z, x2, -5.00000000e-1f);
  z = __internal_fmad (z, x2, 1.00000000e+0f);
  return z;
}

static __inline__ __attribute__((always_inline)) float __internal_accurate_sinf(float a)
{
  float z;
  int i;

  if (__isinff(a)) {
    a = __fmul_rn (a, 0.0f);
  }
  a = __internal_trig_reduction_kernel(a, &i);

  if (i & 1) {
    z = __internal_cos_kernel(a);
  } else {
    z = __internal_sin_kernel(a);
  }
  if (i & 2) {
    z = -z;
  }
  if (a == 0.0f) {
    z = __fmul_rn (a, 0.0f);
  }
  return z;
}

static __inline__ __attribute__((always_inline)) float __internal_accurate_cosf(float a)
{
  float z;
  int i;

  if (__isinff(a)) {
    a = __fmul_rn (a, 0.0f);
  }
  z = __internal_trig_reduction_kernel(a, &i);

  i++;
  if (i & 1) {
    z = __internal_cos_kernel(z);
  } else {
    z = __internal_sin_kernel(z);
  }
  if (i & 2) {
    z = -z;
  }
  return z;
}





static __inline__ __attribute__((always_inline)) float __cos_offset_f(float a, float offset)
{
  float z;
  int i;

  z = __internal_trig_reduction_kernel(a, &i);
  a = z + offset + (i & 3) * 1.570796327f;
  return __internal_accurate_cosf(a);
}







static __inline__ __attribute__((always_inline)) float sinf(float a)
{



  return __internal_accurate_sinf(a);

}

static __inline__ __attribute__((always_inline)) float cosf(float a)
{



  return __internal_accurate_cosf(a);

}

static __inline__ __attribute__((always_inline)) float sinpif(float a)
{

  float z;



  int i;

  if (__isinff(a)) {
    a = __fmul_rn (a, 0.0f);
  }
  if (a == truncf(a)) {
    a = __int_as_float(__float_as_int(a) & 0x80000000);
  }
  i = __float2int_rn (a * 2.0f);
  z = (float)i;
  z = __internal_fmad (-z, 0.5f, a);

  z = __fmaf_rn (z, 3.141592503e+00f, z * 1.509958025e-07f);



  if (i & 1) {
    z = __internal_cos_kernel(z);
  } else {
    z = __internal_sin_kernel(z);
  }
  if (i & 2) {
    z = -z;
  }
  if (a == 0.0f) {
    z = __fmul_rn (a, 0.0f);
  }
  return z;
}

static __inline__ __attribute__((always_inline)) float cospif(float a)
{

  float z;



  int i;

  if (fabsf(a) > 16777216.0f) {
    a = __fmul_rn (a, 0.0f);
  }
  i = __float2int_rn (a * 2.0f);
  z = (float)i;
  z = __internal_fmad (-z, 0.5f, a);

  z = __fmaf_rn (z, 3.141592503e+00f, z * 1.509958025e-07f);



  i++;
  if (i & 1) {
    z = __internal_cos_kernel(z);
  } else {
    z = __internal_sin_kernel(z);
  }
  if (i & 2) {
    z = -z;
  }
  if (z == 0.0f) {
    z = fabsf (z);
  }
  return z;
}

static __inline__ __attribute__((always_inline)) float tanf(float a)
{



  float z;
  int i;

  if (__isinff(a)) {
    a = __fmul_rn (a, 0.0f);
  }
  z = __internal_trig_reduction_kernel(a, &i);

  z = __internal_tan_kernel(z);
  if (i & 1) {
    z = - (1.0f / z);
  }
  return z;

}

static __inline__ __attribute__((always_inline)) float log2f(float a)
{



  return __internal_accurate_log2f(a);

}

static __inline__ __attribute__((always_inline)) float expf(float a)
{



  return __internal_accurate_expf(a);

}

static __inline__ __attribute__((always_inline)) float exp10f(float a)
{



  return __internal_accurate_exp10f(a);

}

static __inline__ __attribute__((always_inline)) float coshf(float a)
{
  float z;

  a = fabsf(a);
  z = __internal_expf_kernel(a, -2.0f);
  z = __internal_fmad (2.0f, z, __fdividef (0.125f, z));
  if (a >= 90.0f) {
    z = __int_as_float(0x7f800000);
  }
  return z;
}

static __inline__ __attribute__((always_inline)) float sinhf(float a)
{
  float s, z;

  s = a;
  a = fabsf(a);
  if (a >= 1.0f) {
    z = __internal_expf_kernel(a, -2.0f);
    z = __internal_fmad (2.0f, z, -__fdividef (0.125f, z));
    if (a >= 90.0f) {
      z = __int_as_float(0x7f800000);
    }
    z = __int_as_float(__float_as_int(z) | (__float_as_int(s) & 0x80000000));
  } else {
    float a2 = s * s;

    z = 2.816951222e-6f;
    z = __internal_fmad (z, a2, 1.983615978e-4f);
    z = __internal_fmad (z, a2, 8.333350058e-3f);
    z = __internal_fmad (z, a2, 1.666666650e-1f);
    z = z * a2;
    z = __internal_fmad (z, s, s);
  }
  return z;
}

static __inline__ __attribute__((always_inline)) float tanhf(float a)
{
  float s, t;

  t = fabsf(a);
  if (t >= 0.55f) {
    s = __internal_fmad (__internal_fast_rcpf (
                         __internal_expf_add_kernel (t+t, 1.0f)), -2.0f, 1.0f);
    if (t >= 88.0f) {
      s = 1.0f;
    }
    s = __int_as_float(__float_as_int(s) | (__float_as_int(a) & 0x80000000));
  } else {
    float z2;
    z2 = a * a;
    t = 1.643758066599993e-2f;
    t = __internal_fmad (t, z2, -5.267181327760551e-2f);
    t = __internal_fmad (t, z2, 1.332072505223051e-1f);
    t = __internal_fmad (t, z2, -3.333294663641083e-1f);
    t = t * z2;
    s = __internal_fmad (t, a, a);
    if (a == 0.0f) {
      s = a + a;
    }
  }
  return s;
}

static __inline__ __attribute__((always_inline)) float atan2f(float a, float b)
{
  float t0, t1, fa, fb;

  fb = fabsf(b);
  fa = fabsf(a);
  if ((fa == 0.0f) && (fb == 0.0f)) {
    t0 = (__float_as_int(b) < 0) ? 3.141592654f : 0.0f;
    t0 = __int_as_float(__float_as_int(t0) | (__float_as_int(a) & 0x80000000));
  } else if ((fa == __int_as_float(0x7f800000)) && (fb == __int_as_float(0x7f800000))) {
    t0 = (__float_as_int(b) < 0) ? 2.356194490f : 0.785398163f;
    t0 = __int_as_float(__float_as_int(t0) | (__float_as_int(a) & 0x80000000));
  } else {


    t0 = fminf(fa, fb);
    t1 = fmaxf(fa, fb);
    t0 = t0 / t1;
    t0 = __internal_atanf_kernel(t0);

    if (fa > fb) t0 = 1.570796327f - t0;
    if (b < 0.0f) t0 = 3.141592654f - t0;
    t0 = __int_as_float(__float_as_int(t0) | (__float_as_int(a) & 0x80000000));
    t1 = a + b;
    if (!(t1 <= __int_as_float(0x7f800000))) {

        t0 = t1;
    }
  }
  return t0;
}

static __inline__ __attribute__((always_inline)) float atanf(float a)
{
  float t0, t1;


  t0 = fabsf(a);
  t1 = t0;
  if (t0 > 1.0f) {
    t1 = 1.0f / t1;
  }

  t1 = __internal_atanf_kernel(t1);

  if (t0 > 1.0f) {
    t1 = 1.570796327f - t1;
  }
  if (t0 <= __int_as_float(0x7f800000)) {
    t1 = __int_as_float(__float_as_int(t1) | (__float_as_int(a) & 0x80000000));
  }
  return t1;
}


static __inline__ __attribute__((always_inline)) float __internal_asinf_kernel(float a)
{
  float a2, t;
  a2 = a * a;
  t = 5.175137819e-002f;
  t = __internal_fmad (t, a2, 1.816697683e-002f);
  t = __internal_fmad (t, a2, 4.675685871e-002f);
  t = __internal_fmad (t, a2, 7.484657646e-002f);
  t = __internal_fmad (t, a2, 1.666701424e-001f);
  t = t * a2;
  a = __internal_fmad (t, a, a);
  return a;
}

static __inline__ __attribute__((always_inline)) float asinf(float a)
{
  float t0, t1, t2;

  t0 = fabsf(a);
  t2 = 1.0f - t0;
  t2 = 0.5f * t2;
  t2 = sqrtf(t2);
  t1 = t0 > 0.57f ? t2 : t0;
  t1 = __internal_asinf_kernel(t1);
  t2 = __internal_fmad (-2.0f, t1, 1.570796327f);
  if (t0 > 0.57f) {
    t1 = t2;
  }
  if (t1 <= __int_as_float(0x7f800000)) {
    t1 = __int_as_float(__float_as_int(t1) | (__float_as_int(a) & 0x80000000));
  }
  return t1;
}

static __inline__ __attribute__((always_inline)) float acosf(float a)
{
  float t0, t1, t2;

  t0 = fabsf(a);
  t2 = 1.0f - t0;
  t2 = 0.5f * t2;
  t2 = sqrtf(t2);
  t1 = t0 > 0.57f ? t2 : t0;
  t1 = __internal_asinf_kernel(t1);
  t1 = t0 > 0.57f ? 2.0f * t1 : 1.570796327f - t1;
  if (__float_as_int(a) < 0) {
    t1 = 3.141592654f - t1;
  }
  return t1;
}

static __inline__ __attribute__((always_inline)) float logf(float a)
{



  return __internal_accurate_logf(a);

}

static __inline__ __attribute__((always_inline)) float log10f(float a)
{



  return 0.434294482f * __internal_accurate_logf(a);

}

static __inline__ __attribute__((always_inline)) float log1pf(float a)
{
  float t;
  if (a >= -0.394f && a <= 0.65f) {

    t = a + 2.0f;
    t = __fdividef (a, t);
    t = __fmul_rn (-a, t);
    t = __internal_atanhf_kernel (a, t);
  } else {
    t = __internal_accurate_logf (1.0f + a);
  }
  return t;
}

static __inline__ __attribute__((always_inline)) float acoshf(float a)
{
  float t;

  t = a - 1.0f;
  if (fabsf(t) > 8388608.0f) {

    return 0.693147181f + __internal_accurate_logf(a);
  } else {
    t = t + sqrtf(__fadd_rn(__fmul_rz(a, t), t));
    return log1pf(t);
  }
}

static __inline__ __attribute__((always_inline)) float asinhf(float a)
{
  float fa, oofa, t;

  fa = fabsf(a);
  if (fa > 8.507059173e37f) {
    t = __fadd_rn (0.693147181f, __logf(fa));
  } else {
    oofa = 1.0f / fa;
    t = __internal_fmad (fa, __internal_fast_rcpf (oofa +
                             sqrtf (__internal_fmad (oofa, oofa, 1.0f))), fa);
    t = log1pf(t);
  }
  if (fa <= __int_as_float(0x7f800000)) {
    t = __int_as_float(__float_as_int(t) | (__float_as_int(a) & 0x80000000));
  }
  return t;
}

static __inline__ __attribute__((always_inline)) float atanhf(float a)
{
  float fa, t;

  fa = fabsf(a);
  t = __fdividef ((2.0f * fa), (1.0f - fa));
  t = 0.5f * log1pf(t);
  if (fabsf(t) <= __int_as_float(0x7f800000)) {
    t = __int_as_float(__float_as_int(t) | (__float_as_int(a) & 0x80000000));
  }
  return t;
}

static __inline__ __attribute__((always_inline)) float expm1f(float a)
{
  float t, z, j, u;

  t = rintf (a * 1.442695041f);

  if (fabsf(a) < 0.41f) {
    t = 0.0f;
  }
  z = __internal_fmad (-t, 0.6931457519f, a);
  z = __internal_fmad (-t, 1.4286067653e-6f, z);

  j = t;
  if (t == 128.0f) j = j - 1.0f;

  u = 1.38795078474044430E-003f;
  u = __internal_fmad (u, z, 8.38241261853264930E-003f);
  u = __internal_fmad (u, z, 4.16678317762833940E-002f);
  u = __internal_fmad (u, z, 1.66663978874356580E-001f);
  u = __internal_fmad (u, z, 4.99999940395997040E-001f);
  u = u * z;
  u = __internal_fmad (u, z, z);

  z = exp2f (j);
  u = __internal_fmad (u, z, z - 1.0f);
  if (t == 128.0f) u = u + u;

  if (j > 128.0f) u = __int_as_float(0x7f800000);
  if (j < -25.0f) u = -1.0f;

  if (a == 0.0f) {
    u = __int_as_float(__float_as_int(a) & 0x80000000);
  }
  return u;
}

static __inline__ __attribute__((always_inline)) float hypotf(float a, float b)
{
  float v, w, s, t, fa, fb;

  fa = fabsf(a);
  fb = fabsf(b);
  v = s = fmaxf(fa, fb);
  w = t = fminf(fa, fb);
  if (v > 8.507059173e37f) {
    s = s * 0.25f;
    t = t * 0.25f;
  }
  t = __fdividef(t, s);
  t = __internal_fmad (t, t, 1.0f);
  t = v * sqrtf(t);
  if (v == 0.0f) {
    t = v + w;
  }
  if ((!(fa <= __int_as_float(0x7f800000))) || (!(fb <= __int_as_float(0x7f800000)))) {
    t = a + b;
  }
  if (v == __int_as_float(0x7f800000)) {
    t = v + w;
  }
  return t;
}

static __inline__ __attribute__((always_inline)) float cbrtf(float a)
{
  float s, t;

  s = fabsf(a);
  t = exp2f(0.333333333f * __log2f(s));
  s = __internal_fmad (__internal_fast_rcpf (t * t), -s, t);
  t = __internal_fmad (s, -0.333333333f, t);
  if (__float_as_int(a) < 0) {
    t = -t;
  }
  s = a + a;
  if (s == a) t = s;
  return t;
}

static __inline__ __attribute__((always_inline)) float rcbrtf(float a)
{
  float s, t;

  s = fabsf(a);
  t = exp2f(-0.333333333f * __log2f(s));
  t = __internal_fmad(__internal_fmad(t*t, -s*t, 1.0f), 0.333333333f*t, t);
  if (__float_as_int(a) < 0) {
    t = -t;
  }
  s = a + a;
  if (s == a) t = __internal_fast_rcpf(a);
  return t;
}

static __inline__ __attribute__((always_inline)) float j0f(float a)
{
  float t, r, x;
  r = 0.0f;
  t = fabsf(a);
  if (t <= 8.0f) {





    x = ((t - 2.4048254e0f) - 1.0870590e-7f);
    r = -1.2470738e-15f;
    r = __internal_fmad(r, x, -7.6677725e-14f);
    r = __internal_fmad(r, x, 2.7150556e-12f);
    r = __internal_fmad(r, x, -6.0280119e-12f);
    r = __internal_fmad(r, x, -4.2393267e-10f);
    r = __internal_fmad(r, x, 5.8276378e-10f);
    r = __internal_fmad(r, x, 5.8077841e-8f);
    r = __internal_fmad(r, x, 1.8003311e-9f);
    r = __internal_fmad(r, x, -5.4500733e-6f);
    r = __internal_fmad(r, x, -7.3432207e-6f);
    r = __internal_fmad(r, x, 3.0170320e-4f);
    r = __internal_fmad(r, x, 7.7395444e-4f);
    r = __internal_fmad(r, x, -7.2834617e-3f);
    r = __internal_fmad(r, x, -2.6668204e-2f);
    r *= x;
    r *= ((t - 5.5200782e0f) - -7.1934146e-8f);
    r *= ((t - 8.6537275e0f) - 3.8147792e-7f);
  } else if (!__isinff(t)) {




    float y = __internal_fast_rcpf(t);
    float y2 = y * y;
    float f, arg;
    f = 3.3592878957727e0f;
    f = __internal_fmad(f, y2, -5.1452267169952e-1f);
    f = __internal_fmad(f, y2, 1.0337056964636e-1f);
    f = __internal_fmad(f, y2, -6.2499724328518e-2f);
    f = __internal_fmad(f, y2, 1.0000000000000e0f);
    arg = 1.1396494694586e0f;
    arg = __internal_fmad(arg, y2, -2.0532675087452e-1f);
    arg = __internal_fmad(arg, y2, 6.5091736614704e-2f);
    arg = __internal_fmad(arg, y2, -1.2499999254942e-1f);
    arg = __internal_fmad(arg, y, t);
    r = rsqrtf(t) * 0.797884561f * f * __cos_offset_f(arg, -7.8539816e-1f);
  } else {

    r = 0.0f;
  }
  return r;
}

static __inline__ __attribute__((always_inline)) float j1f(float a)
{
  float t, r, x;
  r = 0.0f;
  t = fabsf(a);
  if (t <= 7.85f) {





    x = ((t - 3.8317060e0f) - -7.6850590e-8f);
    r = 7.7806488e-14f;
    r = __internal_fmad(r, x, 9.2190860e-13f);
    r = __internal_fmad(r, x, -2.5706883e-11f);
    r = __internal_fmad(r, x, -2.0179057e-10f);
    r = __internal_fmad(r, x, 4.5125277e-9f);
    r = __internal_fmad(r, x, 2.7016290e-8f);
    r = __internal_fmad(r, x, -5.3477970e-7f);
    r = __internal_fmad(r, x, -2.3602763e-6f);
    r = __internal_fmad(r, x, 4.1210809e-5f);
    r = __internal_fmad(r, x, 1.1917029e-4f);
    r = __internal_fmad(r, x, -1.8075588e-3f);
    r = __internal_fmad(r, x, -2.5548928e-3f);
    r = __internal_fmad(r, x, 3.3013891e-2f);
    r *= ((t - 7.0155869e0f) - -1.8321172e-7f);
    r *= x;
    r *= t;
  } else if (!__isinff(t)) {
    float y = __internal_fast_rcpf(t);
    float y2 = y * y;
    float f, arg;
    f = -4.0873065e0f;
    f = __internal_fmad(f, y2, 7.4987656e-1f);
    f = __internal_fmad(f, y2, -1.9291565e-1f);
    f = __internal_fmad(f, y2, 1.8749826e-1f);
    f = __internal_fmad(f, y2, 1.0000000e0f);
    arg = -1.5799448e0f;
    arg = __internal_fmad(arg, y2, 3.6148587e-1f);
    arg = __internal_fmad(arg, y2, -1.6401261e-1f);
    arg = __internal_fmad(arg, y2, 3.7499991e-1f);
    arg = __internal_fmad(arg, y, t);
    r = rsqrtf(t) * 0.797884561f * f * __cos_offset_f(arg, -2.3561945e0f);
  } else {
    r = 0.0f;
  }
  if (a < 0.0f) {
      r = -r;
  }
  if (t < 1e-30f) {
      r = copysignf(r, a);
  }
  return r;
}

static __inline__ __attribute__((always_inline)) float y0f(float a)
{
  float t, r, x;
  r = 0.0f;
  t = fabsf(a);
  if (t <= 4.4678848e-1f) {






    x = t * t;
    r = 1.0239759e-7f;
    r = __internal_fmad(r, x, -9.4943007e-6f);
    r = __internal_fmad(r, x, 5.3860247e-4f);
    r = __internal_fmad(r, x, -1.6073968e-2f);
    r = __internal_fmad(r, x, 1.7760602e-1f);
    r = __internal_fmad(r, x, -7.3804297e-2f);
    r += 0.636619772f * logf(t) * j0f(t);
  } else if (t <= 1.9256277e0f) {



    x = ((t - 8.9357698e-1f) - -1.3357979e-8f);
    r = 2.7073240e-2f;
    r = __internal_fmad(r, x, -1.2728614e-1f);
    r = __internal_fmad(r, x, 2.4919428e-1f);
    r = __internal_fmad(r, x, -2.7333531e-1f);
    r = __internal_fmad(r, x, 2.1465521e-1f);
    r = __internal_fmad(r, x, -1.8043898e-1f);
    r = __internal_fmad(r, x, 1.8990822e-1f);
    r = __internal_fmad(r, x, -2.0543173e-1f);
    r = __internal_fmad(r, x, 2.1968170e-1f);
    r = __internal_fmad(r, x, -2.2614010e-1f);
    r = __internal_fmad(r, x, 2.2052875e-1f);
    r = __internal_fmad(r, x, -4.9207821e-1f);
    r = __internal_fmad(r, x, 8.7942094e-1f);
    r *= x;
  } else if (t <= 5.5218647e0f) {
    x = ((t - 3.9576783e0f) - 1.0129118e-7f);
    r = -1.8800073e-7f;
    r = __internal_fmad(r, x, -2.0689195e-7f);
    r = __internal_fmad(r, x, -3.9767929e-6f);
    r = __internal_fmad(r, x, 5.0848408e-5f);
    r = __internal_fmad(r, x, 1.9341275e-4f);
    r = __internal_fmad(r, x, -2.1835594e-3f);
    r = __internal_fmad(r, x, -6.8510985e-3f);
    r = __internal_fmad(r, x, 5.8523852e-2f);
    r = __internal_fmad(r, x, 5.0855581e-2f);
    r = __internal_fmad(r, x, -4.0254268e-1f);
    r *= x;
  } else if (t <= 8.6541981e0f) {
    x = ((t - 7.0860510e0f) - 7.3058118e-8f);
    r = 5.3945030e-7f;
    r = __internal_fmad(r, x, 2.5310101e-6f);
    r = __internal_fmad(r, x, -4.5855297e-5f);
    r = __internal_fmad(r, x, -1.4028202e-4f);
    r = __internal_fmad(r, x, 2.1758752e-3f);
    r = __internal_fmad(r, x, 3.3181210e-3f);
    r = __internal_fmad(r, x, -4.8024025e-2f);
    r = __internal_fmad(r, x, -2.1175193e-2f);
    r = __internal_fmad(r, x, 3.0009761e-1f);
    r *= x;
  } else if (!__isinff(t)) {
    float y = __internal_fast_rcpf(t);
    float y2 = y * y;
    float f, arg;
    f = -3.9924583e-1f;
    f = __internal_fmad(f, y2, 1.0197055e-1f);
    f = __internal_fmad(f, y2, -6.2492687e-2f);
    f = __internal_fmad(f, y2, 1.0000000e0f);
    arg = 1.1000177e0f;
    arg = __internal_fmad(arg, y2, -2.0393032e-1f);
    arg = __internal_fmad(arg, y2, 6.5077804e-2f);
    arg = __internal_fmad(arg, y2, -1.2499996e-1f);
    arg = __internal_fmad(arg, y, t);
    r = rsqrtf(t) * 0.797884561f * f * __cos_offset_f(arg, -2.3561945e0f);
  } else {

    r = 0.0f;
  }
  if (a < 0.0f) {
      r = sqrtf(-1.0f);
  }
  return r;
}

static __inline__ __attribute__((always_inline)) float y1f(float a)
{
  float t, r, x;
  r = 0.0f;
  t = fabsf(a);
  if (t < 1.175494351e-38f) {

    r = -0.636619772f / t;
  } else if (t <= 1.6985707e0f) {






    x = t * t;
    r = 8.6371976e-9f;
    r = __internal_fmad(r, x, -9.9208705e-7f);
    r = __internal_fmad(r, x, 7.1642142e-5f);
    r = __internal_fmad(r, x, -2.9553052e-3f);
    r = __internal_fmad(r, x, 5.4348689e-2f);
    r = __internal_fmad(r, x, -1.9605710e-1f);
    r *= t;
    r += 0.636619772f * (logf(t) * j1f(t) - 1.0f / t);
  } else if (t <= 3.8134112e0f) {



    x = ((t - 2.1971414e0f) - -8.2889272e-8f);
    r = -1.6437198e-5f;
    r = __internal_fmad(r, x, 1.2807001e-4f);
    r = __internal_fmad(r, x, -4.5903810e-4f);
    r = __internal_fmad(r, x, 1.0938945e-3f);
    r = __internal_fmad(r, x, -2.6312035e-3f);
    r = __internal_fmad(r, x, 7.4269730e-3f);
    r = __internal_fmad(r, x, -4.7923904e-3f);
    r = __internal_fmad(r, x, -3.2858409e-2f);
    r = __internal_fmad(r, x, -1.1851477e-1f);
    r = __internal_fmad(r, x, 5.2078640e-1f);
    r *= x;
  } else if (t <= 7.0128435e0f) {
    x = ((t - 5.4296808e0f) - 2.1651435e-7f);
    r = 2.2158844e-8f;
    r = __internal_fmad(r, x, -5.0902725e-7f);
    r = __internal_fmad(r, x, -2.8541590e-6f);
    r = __internal_fmad(r, x, 4.6370558e-5f);
    r = __internal_fmad(r, x, 1.4660921e-4f);
    r = __internal_fmad(r, x, -2.1659129e-3f);
    r = __internal_fmad(r, x, -4.1601104e-3f);
    r = __internal_fmad(r, x, 5.0947908e-2f);
    r = __internal_fmad(r, x, 3.1338677e-2f);
    r = __internal_fmad(r, x, -3.4031805e-1f);
    r *= x;
  } else if (t <= 1.0172580e1f) {
    x = ((t - 8.5960054e0f) - 4.2857286e-7f);
    r = 5.2508420e-7f;
    r = __internal_fmad(r, x, 1.9455433e-6f);
    r = __internal_fmad(r, x, -4.3719487e-5f);
    r = __internal_fmad(r, x, -1.0394055e-4f);
    r = __internal_fmad(r, x, 2.0113946e-3f);
    r = __internal_fmad(r, x, 2.4177686e-3f);
    r = __internal_fmad(r, x, -4.3406386e-2f);
    r = __internal_fmad(r, x, -1.5789848e-2f);
    r = __internal_fmad(r, x, 2.7145988e-1f);
    r *= x;
  } else if (!__isinff(t)) {
    float y = __internal_fast_rcpf(t);
    float y2 = y * y;
    float f, arg;
    f = 6.5038110e-1f;
    f = __internal_fmad(f, y2, -1.9206071e-1f);
    f = __internal_fmad(f, y2, 1.8749522e-1f);
    f = __internal_fmad(f, y2, 1.0000000e0f);
    arg = -1.7881368e0f;
    arg = __internal_fmad(arg, y2, 3.6611685e-1f);
    arg = __internal_fmad(arg, y2, -1.6404507e-1f);
    arg = __internal_fmad(arg, y2, 3.7499997e-1f);
    arg = __internal_fmad(arg, y, t);
    r = rsqrtf(t) * 0.797884561f * f * __cos_offset_f(arg, -3.9269908e0f);
  } else {

    r = 0.0f;
  }
  if (a < 0.0f) {
      r = sqrtf(-1.0f);
  }
  return r;
}

static __inline__ __attribute__((always_inline)) float ynf(int n, float a)
{
  float yip1;
  float yi = y1f(a);
  float yim1 = y0f(a);
  float two_over_a;
  int i;
  if(n == 0) {
    return y0f(a);
  }
  if(n == 1) {
    return y1f(a);
  }
  if(n < 0) {
    return __int_as_float(0x7fffffff);
  }
  if(!(a >= 0.0f)) {

    return __int_as_float(0x7fffffff);
  }
  if(fabsf(a) < 1.175494351e-38f) {

    return -10e8f / fabsf(a);
  }
  two_over_a = 2.0f / a;
  for(i = 1; i < n; i++) {

    yip1 = __internal_fmad(i * two_over_a, yi, -yim1);
    yim1 = yi;
    yi = yip1;
  }
  if(__isnanf(yip1)) {

    return -__int_as_float(0x7f800000);
  }
  return yip1;
}

static __inline__ __attribute__((always_inline)) float jnf(int n, float a)
{
  float jip1 = 0.0f;
  float ji = 1.0f;
  float jim1;
  float lambda = 0.0f;
  float sum = 0.0f;
  int i;
  if(n == 0) {
    return y0f(a);
  }
  if(n == 1) {
    return y1f(a);
  }
  if(n < 0) {
    return __int_as_float(0x7fffffff);
  }
  if(fabsf(a) > (float)(n + (n > 4))) {

    float two_over_a = 2.0f / a;
    float ji = j1f(a);
    float jim1 = j0f(a);
    for(i = 1; i < n; i++) {
      jip1 = __internal_fmad(i * ji, two_over_a, -jim1);
      jim1 = ji;
      ji = jip1;
    }
    return jip1;
  } else {
    int m = n + (int)sqrtf(n * 40);
    m = (m >> 1) << 1;
    for(i = m; i >= 1; --i) {

      jim1 = i * 2.0f / a * ji - jip1;
      jip1 = ji;
      if(fabsf(jim1) > 1e15f) {

        jim1 *= 1e-15f;
        jip1 *= 1e-15f;
        lambda *= 1e-15f;
        sum *= 1e-15f;
      }
      ji = jim1;
      if(i - 1 == n) {
        lambda = ji;
      }
      if(i & 1) {
        sum += 2.0f * ji;
      }
    }
    sum -= ji;
    return lambda / sum;
  }
}

static __inline__ __attribute__((always_inline)) float erff(float a)
{
  float t, r, q;

  t = fabsf(a);
  if (t >= 1.0f) {



    q = __internal_fmad (t, 0.3275911f, 1.0f);
    q = 1.0f / q;
    r = 1.061405429f;
    r = __internal_fmad (r, q, -1.453152027f);
    r = __internal_fmad (r, q, 1.421413741f);
    r = __internal_fmad (r, q, -0.284496736f);
    r = __internal_fmad (r, q, 0.254829592f);
    r = r * q;
    q = __internal_expf_kernel(-a * a, 0.0f);
    r = __internal_fmad (-q, r, 1.0f);
    if (t >= 5.5f) {
      r = 1.0f;
    }
    a = __int_as_float (__float_as_int(r) | (__float_as_int(a) & 0x80000000));
  } else {
    t = a * a;
    r = -5.58510127926029810E-004f;
    r = __internal_fmad (r, t, 4.90688891415893070E-003f);
    r = __internal_fmad (r, t, -2.67027980930150640E-002f);
    r = __internal_fmad (r, t, 1.12799056505903940E-001f);
    r = __internal_fmad (r, t, -3.76122956138427440E-001f);
    r = __internal_fmad (r, t, 1.12837911712623450E+000f);
    a = a * r;
  }
  return a;
}
# 4603 "/usr/local/cuda/bin/../include/math_functions.h" 3
static __inline__ __attribute__((always_inline)) float erfinvf(float a)
{
  float s, t, r;


  s = __fmaf_rn (a, -a, 1.0f);





  t = - __log2f (s);
  if (t > 8.2f) {
    t = rsqrtf (t);
    r = -5.8991436871681446E-001f;
    r = __internal_fmad (r, t, -6.6300422537735360E-001f);
    r = __internal_fmad (r, t, 1.5970110948817704E+000f);
    r = __internal_fmad (r, t, -6.7521557026467416E-001f);
    r = __internal_fmad (r, t, -9.5224791160399669E-002f);
    r = __internal_fmad (r, t, 8.3535343797791939E-001f);
    t = 1.0f / t;
    t = r * t;
    if (a < 0.0f) t = -t;
    return t;
  } else {
    r = -2.5172707606685652E-010f;
    r = __internal_fmad (r, t, 9.4274289432374619E-009f);
    r = __internal_fmad (r, t, -1.2054753059594516E-007f);
    r = __internal_fmad (r, t, 2.1697004698667657E-007f);
    r = __internal_fmad (r, t, 8.0621488510822390E-006f);
    r = __internal_fmad (r, t, -3.1675491789646913E-005f);
    r = __internal_fmad (r, t, -7.7436312951712784E-004f);
    r = __internal_fmad (r, t, 5.5465877941375773E-003f);
    r = __internal_fmad (r, t, 1.6082022430967846E-001f);
    r = __internal_fmad (r, t, 8.8622690039402130E-001f);
    return r * a;
  }
}

static __inline__ __attribute__((always_inline)) float __internal_erfcxf_kernel (float a)
{
# 4654 "/usr/local/cuda/bin/../include/math_functions.h" 3
  float t1, t2, t3, t4;


  t1 = a - 4.0f;
  t2 = a + 4.0f;
  t2 = __internal_fast_rcpf (t2);
  t3 = __fmul_rn (t1, t2);
  t1 = __fmaf_rn (-4.0f, t3 + 1.0f, a);
  t1 = __fmaf_rn (-t3, a, t1);
  t2 = __fmaf_rn (t2, t1, t3);

  t1 = 8.9121708796596137E-004f;
  t1 = __fmaf_rn (t1, t2, 7.0457882096080539E-003f);
  t1 = __fmaf_rn (t1, t2, -1.5866896179569826E-002f);
  t1 = __fmaf_rn (t1, t2, 3.6429623548273796E-002f);
  t1 = __fmaf_rn (t1, t2, -6.6643431826764105E-002f);
  t1 = __fmaf_rn (t1, t2, 9.3814531408377352E-002f);
  t1 = __fmaf_rn (t1, t2, -1.0099056031741439E-001f);
  t1 = __fmaf_rn (t1, t2, 6.8094000865639340E-002f);
  t1 = __fmaf_rn (t1, t2, 1.5377387724225955E-002f);
  t1 = __fmaf_rn (t1, t2, -1.3962107929750070E-001f);
  t1 = __fmaf_rn (t1, t2, 1.2329951349050698E+000f);

  t2 = __fmaf_rn (2.0f, a, 1.0f);
  t2 = __internal_fast_rcpf (t2);
  t3 = __fmul_rn (t1, t2);
  t4 = __fmaf_rn (a, -2.0f*t3, t1);
  t4 = t4 - t3;
  t1 = __fmaf_rn (t4, t2, t3);
  return t1;
# 4708 "/usr/local/cuda/bin/../include/math_functions.h" 3
}

static __inline__ __attribute__((always_inline)) float erfcf(float a)
{

  float x, t1, t2, t3;
  x = fabsf(a);
  t1 = __internal_erfcxf_kernel (x);

  t2 = -x * x;
  t3 = __internal_expf_kernel (t2, 0.0f);
  t2 = __fmaf_rn (-x, x, -t2);
  t2 = __fmaf_rn (t3, t2, t3);
  t1 = t1 * t2;
  if (x > 10.055f) t1 = 0.0f;
  return (a < 0.0f) ? (2.0f - t1) : t1;
# 4748 "/usr/local/cuda/bin/../include/math_functions.h" 3
}

static __inline__ __attribute__((always_inline)) float erfcxf(float a)
{

  float x, t1, t2, t3;
  x = fabsf(a);
  if (x < 10.055f) {
    t1 = __internal_erfcxf_kernel(x);
  } else {

    t2 = __fdividef (0.25f, 0.25f * x);
    t3 = t2 * t2;
    t1 = +6.5625f;
    t1 = __fmaf_rn (t1, t3, -1.875f);
    t1 = __fmaf_rn (t1, t3, +0.75f);
    t1 = __fmaf_rn (t1, t3, -0.5f);
    t1 = __fmaf_rn (t1, t3, +1.0f);
    t2 = t2 * 5.6418958354775628e-001f;
    t1 = t1 * t2;
  }
  if (a < 0.0f) {

    t2 = __fmul_rz (x, x);
    t3 = __fmaf_rn (x, x, -t2);
    t2 = __internal_accurate_expf(t2);
    t2 = t2 + t2;
    t3 = __fmaf_rn (t2, t3, t2);
    t1 = t3 - t1;
    if (t2 == __int_as_float(0x7f800000)) t1 = t2;
  }
  return t1;
# 4828 "/usr/local/cuda/bin/../include/math_functions.h" 3
}

static __inline__ __attribute__((always_inline)) float erfcinvf(float a)
{
  float t;
  if (a <= 0.0f) {
    t = rsqrtf (__int_as_float (0xffc00000));
    if (a == 0.0f) {
      t = (1.0f - a) * __int_as_float(0x7f800000);
    }
  }
  else if (a >= 0.0625f) {
    t = erfinvf (1.0f - a);
  }
  else {
    float p, q;
    t = __internal_accurate_logf(a);
    t = rsqrtf(-t);
    p = -1.64441567910e-1f;
    p = __internal_fmad (p, t, 6.80544246825e-1f);
    p = __internal_fmad (p, t, -1.12808139162e+0f);
    p = __internal_fmad (p, t, 6.90969348887e-1f);
    p = __internal_fmad (p, t, 1.38271964963e+0f);
    p = __internal_fmad (p, t, 1.55047000312e-1f);
    q = t + 1.38522814199e+0f;
    q = __internal_fmad (q, t, 1.55024849822e-1f);
    q = q * t;
    t = __fdividef (p, q);
  }
  return t;
}

static __inline__ __attribute__((always_inline)) float lgammaf(float a)
{
  float t;
  float i;
  int quot;
  t = __internal_lgammaf_pos(fabsf(a));
  if (a >= 0.0f) return t;
  a = fabsf(a);
  i = floorf(a);
  if (a == i) return __int_as_float(0x7f800000);
  if (a < 1e-19f) return -__internal_accurate_logf(a);
  i = rintf (2.0f * a);
  quot = (int)i;
  i = __internal_fmad (-i, 0.5f, a);
  i = i * 3.141592654f;
  if (quot & 1) {
    i = __internal_cos_kernel(i);
  } else {
    i = __internal_sin_kernel(i);
  }
  i = fabsf(i);
  t = 1.144729886f - __internal_accurate_logf(i * a) - t;
  return t;
}

static __inline__ __attribute__((always_inline)) float ldexpf(float a, int b)
{
  float fa = fabsf(a);

  if ((fa == 0.0f) || (fa == __int_as_float(0x7f800000)) || (b == 0)) {
    if (!(fa > 0.0f)) a = a + a;
    return a;
  } else if (abs(b) < 126) {
    return a * exp2f((float)b);
  } else if (abs(b) < 252) {
    int bhalf = b / 2;
    return a * exp2f((float)bhalf) * exp2f((float)(b - bhalf));
  } else {
    int bquarter = b / 4;
    float t = exp2f((float)bquarter);
    return a * t * t * t * exp2f((float)(b - 3 * bquarter));
  }
}

static __inline__ __attribute__((always_inline)) float scalbnf(float a, int b)
{

  return ldexpf(a, b);
}

static __inline__ __attribute__((always_inline)) float scalblnf(float a, long int b)
{
  int t;
  if (b > 2147483647L) {
    t = 2147483647;
  } else if (b < (-2147483647 - 1)) {
    t = (-2147483647 - 1);
  } else {
    t = (int)b;
  }
  return scalbnf(a, t);
}

static __inline__ __attribute__((always_inline)) float frexpf(float a, int *b)
{
  float fa = fabsf(a);
  unsigned int expo;
  unsigned int denorm;

  if (fa < 1.175494351e-38f) {
    a *= 16777216.0f;
    denorm = 24;
  } else {
    denorm = 0;
  }
  expo = ((__float_as_int(a) >> 23) & 0xff);
  if ((fa == 0.0f) || (expo == 0xff)) {
    expo = 0;
    a = a + a;
  } else {
    expo = expo - denorm - 126;
    a = __int_as_float(((__float_as_int(a) & 0x807fffff) | 0x3f000000));
  }
  *b = expo;
  return a;
}

static __inline__ __attribute__((always_inline)) float modff(float a, float *b)
{
  float t;
  if (__finitef(a)) {
    t = truncf(a);
    *b = t;
    t = a - t;
    t = __int_as_float(__float_as_int(t) | (__float_as_int(a) & 0x80000000));
    return t;
  } else if (__isinff(a)) {
    *b = a;
    return __int_as_float(__float_as_int(a) & 0x80000000);
  } else {
    *b = a + a;
    return a + a;
  }
}

static __inline__ __attribute__((always_inline)) float fmodf(float a, float b)
{
  float orig_a = a;
  float orig_b = b;
  a = fabsf(a);
  b = fabsf(b);
  if (!((a <= __int_as_float(0x7f800000)) && (b <= __int_as_float(0x7f800000)))) {
    return orig_a + orig_b;
  }
  if ((a == __int_as_float(0x7f800000)) || (b == 0.0f)) {
    return rsqrtf (__int_as_float (0xffc00000));
  } else if (a >= b) {


    int expoa = (a < 1.175494351e-38f) ?
        ((int)__log2f(a)) : (((__float_as_int(a) >> 23) & 0xff) - 127);
    int expob = (b < 1.175494351e-38f) ?
        ((int)__log2f(b)) : (((__float_as_int(b) >> 23) & 0xff) - 127);
    int scale = expoa - expob;
    float scaled_b = ldexpf(b, scale);
    if (scaled_b <= 0.5f * a) {
      scaled_b *= 2.0f;
    }







    while (scaled_b >= b) {
      if (a >= scaled_b) {
        a -= scaled_b;
      }
      scaled_b *= 0.5f;
    }
    return __int_as_float (__float_as_int(a) |
                           (__float_as_int(orig_a) & 0x80000000));
  } else {
    if (!(a > 0.0f)) orig_a = orig_a + orig_a;
    return orig_a;
  }
}

static __inline__ __attribute__((always_inline)) float remainderf(float a, float b)
{

  float twoa = 0.0f;
  unsigned int quot0 = 0;
  float orig_a = a;
  float orig_b = b;

  a = fabsf(a);
  b = fabsf(b);
  if (!((a <= __int_as_float(0x7f800000)) && (b <= __int_as_float(0x7f800000)))) {
    return orig_a + orig_b;
  }
  if ((a == __int_as_float(0x7f800000)) || (b == 0.0f)) {
    return rsqrtf (__int_as_float (0xffc00000));
  } else if (a >= b) {

    int expoa = (a < 1.175494351e-38f) ?
        ((int)__log2f(a)) : (((__float_as_int(a) >> 23) & 0xff) - 127);
    int expob = (b < 1.175494351e-38f) ?
        ((int)__log2f(b)) : (((__float_as_int(b) >> 23) & 0xff) - 127);
    int scale = expoa - expob;
    float scaled_b = ldexpf(b, scale);
    if (scaled_b <= 0.5f * a) {
      scaled_b *= 2.0f;
    }
# 5046 "/usr/local/cuda/bin/../include/math_functions.h" 3
    while (scaled_b >= b) {
      quot0 = 0;
      if (a >= scaled_b) {
        twoa = __internal_fmad (a, 2.0f, -scaled_b) - scaled_b;
        a = a - scaled_b;
        quot0 = 1;
      }
      scaled_b *= 0.5f;
    }
  }


  twoa = 2.0f * a;
  if ((twoa > b) || ((twoa == b) && quot0)) {
    a -= b;
    a = __int_as_float(__float_as_int(a) | 0x80000000);
  }
# 5078 "/usr/local/cuda/bin/../include/math_functions.h" 3
  a = __int_as_float((__float_as_int(orig_a) & 0x80000000)^
                     __float_as_int(a));
  return a;
}

static __inline__ __attribute__((always_inline)) float remquof(float a, float b, int* quo)
{
  float twoa = 0.0f;
  unsigned int quot = 0;
  unsigned int sign;
  float orig_a = a;
  float orig_b = b;


  sign = 0 - ((__float_as_int(a) ^ __float_as_int(b)) < 0);
  a = fabsf(a);
  b = fabsf(b);
  if (!((a <= __int_as_float(0x7f800000)) && (b <= __int_as_float(0x7f800000)))) {
    *quo = quot;
    return orig_a + orig_b;
  }
  if ((a == __int_as_float(0x7f800000)) || (b == 0.0f)) {
    *quo = quot;
    return rsqrtf (__int_as_float (0xffc00000));
  } else if (a >= b) {


    int expoa = (a < 1.175494351e-38f) ?
        ((int)__log2f(a)) : (((__float_as_int(a) >> 23) & 0xff) - 127);
    int expob = (b < 1.175494351e-38f) ?
        ((int)__log2f(b)) : (((__float_as_int(b) >> 23) & 0xff) - 127);
    int scale = expoa - expob;
    float scaled_b = ldexpf(b, scale);
    if (scaled_b <= 0.5f * a) {
      scaled_b *= 2.0f;
    }
# 5134 "/usr/local/cuda/bin/../include/math_functions.h" 3
    while (scaled_b >= b) {
      quot <<= 1;
      if (a >= scaled_b) {
        twoa = (2.0f * a - scaled_b) - scaled_b;
        a -= scaled_b;
        quot += 1;
      }
      scaled_b *= 0.5f;
    }
  }


  twoa = 2.0f * a;
  if ((twoa > b) || ((twoa == b) && (quot & 1))) {
    quot++;
    a -= b;
    a = __int_as_float(__float_as_int(a) | 0x80000000);
  }
# 5169 "/usr/local/cuda/bin/../include/math_functions.h" 3
  a = __int_as_float((__float_as_int(orig_a) & 0x80000000)^
                     __float_as_int(a));
  quot = quot & (~((~0)<<3));
  quot = quot ^ sign;
  quot = quot - sign;
  *quo = quot;
  return a;
}

static __inline__ __attribute__((always_inline)) float fmaf(float a, float b, float c)
{
  return __fmaf_rn(a, b, c);
}

static __inline__ __attribute__((always_inline)) float __internal_accurate_powf(float a, float b)
{
  float2 loga, prod;
  float t;


  loga = __internal_log_ep(a);


  if (fabsf(b) > 1.0e34f) b *= 1.220703125e-4f;
  prod.y = b;
  prod.x = 0.0f;
  prod = __internal_dsmul (prod, loga);


  if (__float_as_int(prod.y) == 0x42b17218) {
    prod.y = __int_as_float(__float_as_int(prod.y) - 1);
    prod.x = prod.x + __int_as_float(0x37000000);
  }


  t = __internal_accurate_expf(prod.y);

  if (t != __int_as_float(0x7f800000)) {



    t = __internal_fmad (t, prod.x, t);
  }
  return t;
}

static __inline__ __attribute__((always_inline)) float powif(float a, int b)
{
  unsigned int e = abs(b);
  float r = 1.0f;

  while (1) {
    if ((e & 1) != 0) {
      r = __fmul_rn (r, a);
    }
    e = e >> 1;
    if (e == 0) {
      r = (b < 0) ? 1.0f / r : r;
      return r;
    }
    a = __fmul_rn (a, a);
  }
}

static __inline__ __attribute__((always_inline)) double powi(double a, int b)
{
  unsigned int e = abs(b);
  double r = 1.0;

  while (1) {
    if ((e & 1) != 0) {
      r = r * a;
    }
    e = e >> 1;
    if (e == 0) {
      return b < 0 ? 1.0 / r : r;
    }
    a = a * a;
  }
}

static __inline__ __attribute__((always_inline)) float powf(float a, float b)
{



  int bIsOddInteger;
  float t;
  if (a == 1.0f || b == 0.0f) {
    return 1.0f;
  }
  if (__isnanf(a) || __isnanf(b)) {
    return a + b;
  }
  if (a == __int_as_float(0x7f800000)) {
    return (__float_as_int(b) < 0) ? 0.0f : __int_as_float(0x7f800000);
  }
  if (__isinff(b)) {
    if (a == -1.0f) {
      return 1.0f;
    }
    t = (fabsf(a) > 1.0f) ? __int_as_float(0x7f800000) : 0.0f;
    if (b < 0.0f) {
      t = 1.0f / t;
    }
    return t + t;
  }
  bIsOddInteger = fabsf(b - (2.0f * truncf(0.5f * b))) == 1.0f;
  if (a == 0.0f) {
    t = bIsOddInteger ? a : 0.0f;
    if (b < 0.0f) {
      t = 1.0f / t;
    }
    return t + t;
  }
  if (a == -__int_as_float(0x7f800000)) {
    t = - ((b < 0.0f) ? (1.0f / a) : a);
    if (bIsOddInteger) {
      t = __int_as_float(__float_as_int(t) ^ 0x80000000);
    }
    return t;
  }
  if ((a < 0.0f) && (b != truncf(b))) {
    return rsqrtf(__int_as_float(0xffc00000));
  }
  t = fabsf(a);
  t = __internal_accurate_powf(t, b);
  if ((a < 0.0f) && bIsOddInteger) {
    t = __int_as_float(__float_as_int(t) ^ 0x80000000);
  }
  return t;

}


static __inline__ __attribute__((always_inline)) float __internal_tgammaf_kernel(float a)
{
  float t;
  t = -1.05767296987211380E-003f;
  t = __internal_fmad (t, a, 7.09279059435508670E-003f);
  t = __internal_fmad (t, a, -9.65347121958557050E-003f);
  t = __internal_fmad (t, a, -4.21736613253687960E-002f);
  t = __internal_fmad (t, a, 1.66542401247154280E-001f);
  t = __internal_fmad (t, a, -4.20043267827838460E-002f);
  t = __internal_fmad (t, a, -6.55878234051332940E-001f);
  t = __internal_fmad (t, a, 5.77215696929794240E-001f);
  t = __internal_fmad (t, a, 1.00000000000000000E+000f);
  return t;
}





static __inline__ __attribute__((always_inline)) float tgammaf(float a)
{
  float s, xx, x=a;
  if (x >= 0.0f) {
    if (x > 36.0f) x = 36.0f;
    s = 1.0f;
    xx = x;
    if (x > 34.03f) {
      xx -= 1.0f;
    }
    while (xx > 1.5f) {
      xx = xx - 1.0f;
      s = s * xx;
    }
    if (x >= 0.5f) {
      xx = xx - 1.0f;
    }
    xx = __internal_tgammaf_kernel(xx);
    if (x < 0.5f) {
      xx = xx * x;
    }
    s = __fdividef(s, xx);
    if (x > 34.03f) {

      xx = x - 1.0f;
      s = s * xx;
    }
    return s;
  } else {
    if (x == floorf(x)) {
      x = rsqrtf (__int_as_float (0xffc00000));
    }
    if (x < -41.1f) x = -41.1f;
    xx = x;
    if (x < -34.03f) {
      xx += 6.0f;
    }
    s = xx;
    while (xx < -0.5f) {
      xx = xx + 1.0f;
      s = s * xx;
    }
    xx = __internal_tgammaf_kernel(xx);
    s = s * xx;
    s = 1.0f / s;
    if (x < -34.03f) {
      xx = x;
      xx *= (x + 1.0f);
      xx *= (x + 2.0f);
      xx *= (x + 3.0f);
      xx *= (x + 4.0f);
      xx *= (x + 5.0f);
      xx = 1.0f / xx;
      s = s * xx;
      if ((a < -42.0f) && !(((int)a)&1)) {
        s = __int_as_float(0x80000000);
      }
    }
    return s;
  }
}

static __inline__ __attribute__((always_inline)) float roundf(float a)
{
  float fa = fabsf(a);
  float u = __int_as_float (0x3f000000 | (__float_as_int(a) & 0x80000000));
  u = truncf (a + u);
  if (fa > 8388608.0f) u = a;
  if (fa < 0.5f) u = truncf (a);
  return u;
}

static __inline__ __attribute__((always_inline)) long long int __internal_llroundf_kernel(float a)
{
  unsigned long long int res, t = 0ULL;
  int shift;
  unsigned int ia = __float_as_int(a);

  if ((ia << 1) > 0xff000000) return 0x8000000000000000LL;
  if ((int)ia >= 0x5f000000) return 0x7fffffffffffffffLL;
  if (ia >= 0xdf000000) return 0x8000000000000000LL;
  shift = 189 - ((ia >> 23) & 0xff);
  res = ((long long int)(((ia << 8) | 0x80000000) >> 1)) << 32;
  if (shift >= 64) {
    t = res;
    res = 0;
  } else if (shift) {
    t = res << (64 - shift);
    res = res >> shift;
  }
  if (t >= 0x8000000000000000ULL) {
    res++;
  }
  if ((int)ia < 0) res = (unsigned long long int)(-(long long int)res);
  return (long long int)res;
}

static __inline__ __attribute__((always_inline)) long long int llroundf(float a)
{
  return __internal_llroundf_kernel(a);
}

static __inline__ __attribute__((always_inline)) long int lroundf(float a)
{

  return (long int)llroundf(a);



}

static __inline__ __attribute__((always_inline)) float fdimf(float a, float b)
{
  float t;
  t = a - b;
  if (a <= b) {
    t = 0.0f;
  }
  return t;
}

static __inline__ __attribute__((always_inline)) int ilogbf(float a)
{
  unsigned int i;
  int expo;
  float fa;
  fa = fabsf(a);
  i = __float_as_int(fa);
  if (i < 0x00800000) {

    expo = -118 - __clz(i);
    if (i == 0x00000000) {
      expo = -((int)((unsigned int)-1 >> 1))-1;
    }
  } else {
    expo = ((int)((i >> 23) & 0xff)) - 127;
    if ((i == 0x7f800000)) {
      expo = ((int)((unsigned int)-1 >> 1));
    }
    if ((i > 0x7f800000)) {
      expo = -((int)((unsigned int)-1 >> 1))-1;
    }
  }
  return expo;
}

static __inline__ __attribute__((always_inline)) float logbf(float a)
{
  unsigned int i;
  int expo;
  float fa, res;
  fa = fabsf(a);
  i = __float_as_int(fa);
  if (i < 0x00800000) {

    expo = -118 - __clz(i);
    res = (float)expo;
    if (a == 0.0f) {
      res = -__int_as_float(0x7f800000);
    }
  } else {
    expo = ((int)((i >> 23) & 0xff)) - 127;
    res = (float)expo;
    if ((i >= 0x7f800000)) {

      res = a * a;
    }
  }
  return res;
}

static __inline__ __attribute__((always_inline)) void sincosf(float a, float *sptr, float *cptr)
{




  float s, c;



  float t;
  int quadrant;

  if (__isinff(a)) {
    a = __fmul_rn (a, 0.0f);
  }
  a = __internal_trig_reduction_kernel(a, &quadrant);
  c = __internal_cos_kernel(a);
  s = __internal_sin_kernel(a);
  t = s;
  if (quadrant & 1) {
     s = c;
     c = t;
  }
  if (quadrant & 2) {
    s = -s;
  }
  quadrant++;
  if (quadrant & 2) {
    c = -c;
  }
  if (a == 0.0f) {
    s = __fmul_rn (a, 0.0f);
  }
  *sptr = s;
  *cptr = c;

}
# 7730 "/usr/local/cuda/bin/../include/math_functions.h" 3
# 1 "/usr/local/cuda/bin/../include/math_functions_dbl_ptx3.h" 1 3
# 63 "/usr/local/cuda/bin/../include/math_functions_dbl_ptx3.h" 3
static __inline__ __attribute__((always_inline)) double rint(double a)
{
  return __builtin_round(a);
}

static __inline__ __attribute__((always_inline)) long int lrint(double a)
{

  return (long int)__double2ll_rn(a);



}

static __inline__ __attribute__((always_inline)) long long int llrint(double a)
{
  return __double2ll_rn(a);
}

static __inline__ __attribute__((always_inline)) double nearbyint(double a)
{
  return __builtin_round(a);
}







static __inline__ __attribute__((always_inline)) int __signbitd(double a)
{
  return (int)((unsigned int)__double2hiint(a) >> 31);
}

static __inline__ __attribute__((always_inline)) int __isfinited(double a)
{
  return fabs(a) < __longlong_as_double(0x7ff0000000000000ULL);
}

static __inline__ __attribute__((always_inline)) int __isinfd(double a)
{
  return fabs(a) == __longlong_as_double(0x7ff0000000000000ULL);
}

static __inline__ __attribute__((always_inline)) int __isnand(double a)
{
  return !(fabs(a) <= __longlong_as_double(0x7ff0000000000000ULL));
}
# 137 "/usr/local/cuda/bin/../include/math_functions_dbl_ptx3.h" 3
static __inline__ __attribute__((always_inline)) int __signbit(double a)
{
  return __signbitd(a);
}

static __inline__ __attribute__((always_inline)) int __signbitl( double a)
{
  return __signbit((double)a);
}

static __inline__ __attribute__((always_inline)) int __finite(double a)
{
  return __isfinited(a);
}

static __inline__ __attribute__((always_inline)) int __finitel( double a)
{
  return __finite((double)a);
}

static __inline__ __attribute__((always_inline)) int __isinf(double a)
{
  return __isinfd(a);
}

static __inline__ __attribute__((always_inline)) int __isinfl( double a)
{
  return __isinf((double)a);
}

static __inline__ __attribute__((always_inline)) int __isnan(double a)
{
  return __isnand(a);
}

static __inline__ __attribute__((always_inline)) int __isnanl( double a)
{
  return __isnan((double)a);
}



static __inline__ __attribute__((always_inline)) double copysign(double a, double b)
{
  int alo, ahi, bhi;

  bhi = __double2hiint(b);
  alo = __double2loint(a);
  ahi = __double2hiint(a);
  ahi = (bhi & 0x80000000) | (ahi & ~0x80000000);
  return __hiloint2double(ahi, alo);
}


static __inline__ __attribute__((always_inline)) double __internal_copysign_pos(double a, double b)
{
  int alo, ahi, bhi;

  bhi = __double2hiint(b);
  alo = __double2loint(a);
  ahi = __double2hiint(a);
  ahi = (bhi & 0x80000000) | ahi;
  return __hiloint2double(ahi, alo);
}

static __inline__ __attribute__((always_inline)) double __internal_fast_rcp(double a)
{
  double e, y;
  float x;
  asm ("cvt.f32.f64.rn     %0,%1;" : "=f"(x) : "d"(a));
  asm ("rcp.approx.f32.ftz %0,%1;" : "=f"(x) : "f"(x));
  asm ("cvt.f64.f32        %0,%1;" : "=d"(y) : "f"(x));
  e = __fma_rn (-a, y, 1.0);
  e = __fma_rn ( e, e, e);
  y = __fma_rn ( e, y, y);
  return y;
}

static __inline__ __attribute__((always_inline)) double __internal_fast_rsqrt(double a)
{
  double x, e, t;
  float f;
  asm ("cvt.f32.f64.rn       %0, %1;" : "=f"(f) : "d"(a));
  asm ("rsqrt.approx.f32.ftz %0, %1;" : "=f"(f) : "f"(f));
  asm ("cvt.f64.f32          %0, %1;" : "=d"(x) : "f"(f));
  t = __dmul_rn (x, -x);
  e = __fma_rn (t, a, 1.0);
  t = __dmul_rn (0.75, e);
  t = __fma_rn (t, e, e);
  t = __hiloint2double (__double2hiint(t) - 0x00100000, __double2loint(t));
  t = __fma_rn (t, x, x);
  return t;
}


static __attribute__((constant)) unsigned long long int __cudart_i2opi_d [] = {
  0x6bfb5fb11f8d5d08ULL,
  0x3d0739f78a5292eaULL,
  0x7527bac7ebe5f17bULL,
  0x4f463f669e5fea2dULL,
  0x6d367ecf27cb09b7ULL,
  0xef2f118b5a0a6d1fULL,
  0x1ff897ffde05980fULL,
  0x9c845f8bbdf9283bULL,
  0x3991d639835339f4ULL,
  0xe99c7026b45f7e41ULL,
  0xe88235f52ebb4484ULL,
  0xfe1deb1cb129a73eULL,
  0x06492eea09d1921cULL,
  0xb7246e3a424dd2e0ULL,
  0xfe5163abdebbc561ULL,
  0xdb6295993c439041ULL,
  0xfc2757d1f534ddc0ULL,
  0xa2f9836e4e441529ULL,
};


static

__attribute__((noinline))



double __internal_trig_reduction_slowpathd(double a, int *quadrant)
{
  unsigned long long int ia;
  unsigned long long int s;
  unsigned long long int result[5];
  unsigned long long int phi, plo;
  unsigned long long int hi, lo;
  unsigned int e;
  int idx;
  int q;
  ia = __double_as_longlong(a);
  s = ia & 0x8000000000000000ULL;
  e = (unsigned int)(((ia >> 52) & 0x7ff) - 1024);
  ia = (ia << 11) | 0x8000000000000000ULL;

  idx = 16 - (e >> 6);
  hi = 0;
#pragma unroll 1
  for (q = (idx-1); q < min(18,idx+3); q++) {
    plo = __cudart_i2opi_d[q] * ia;
    phi = __umul64hi (__cudart_i2opi_d[q], ia);
    lo = hi + plo;
    hi = phi + (lo < plo);
    result[q-(idx-1)] = lo;
  }
  result[q-(idx-1)] = hi;
  e = e & 63;



  hi = result[3];
  lo = result[2];
  if (e) {
    q = 64 - e;
    hi = (hi << e) | (lo >> q);
    lo = (lo << e) | (result[1] >> q);
  }
  q = (int)(hi >> 62);

  hi = (hi << 2) | (lo >> 62);
  lo = (lo << 2);
  e = hi >> 63;
  q += e;
  if (s) q = -q;
  *quadrant = q;
  if (e) {
    unsigned long long int t;
    hi = ~hi;
    lo = -(long long int)lo;
    t = (lo == 0ULL);
    hi += t;
    s = s ^ 0x8000000000000000ULL;
  }

  e = __clzll(hi);
  if (e) {
    hi = (hi << e) | (lo >> (64 - e));
  }
  lo = hi * 0xC90FDAA22168C235ULL;
  hi = __umul64hi (hi, 0xC90FDAA22168C235ULL);
  if ((long long int)hi > 0) {
    hi = (hi << 1) | (lo >> 63);
    e++;
  }
  ia = s | ((((unsigned long long int)(1022 - e)) << 52) +
            ((((hi + 1) >> 10) + 1) >> 1));
  return __longlong_as_double(ia);
}

static __inline__ __attribute__((always_inline)) double __internal_trig_reduction_kerneld(double a, int *quadrant)
{
  double j, t;
  int q;

  q = __double2int_rn (a * 6.3661977236758138e-1);
  j = (double)q;




  t = __fma_rn (-j, 1.5707963267948966e+000, a);
  t = __fma_rn (-j, 6.1232339957367574e-017, t);
  t = __fma_rn (-j, 8.4784276603688985e-032, t);
  if (fabs(a) > 2147483648.0) {
    t = __internal_trig_reduction_slowpathd (a, &q);
  }
  *quadrant = q;
  return t;
}


static __inline__ __attribute__((always_inline)) double __internal_sin_kerneld(double x)
{
  double x2, z;
  x2 = x * x;
  z = 1.5896230157221844E-010;
  z = __fma_rn (z, x2, -2.5050747762850355E-008);
  z = __fma_rn (z, x2, 2.7557313621385676E-006);
  z = __fma_rn (z, x2, -1.9841269829589539E-004);
  z = __fma_rn (z, x2, 8.3333333333221182E-003);
  z = __fma_rn (z, x2, -1.6666666666666630E-001);
  z = z * x2;
  z = __fma_rn (z, x, x);
  return z;
}


static __inline__ __attribute__((always_inline)) double __internal_cos_kerneld(double x)
{
  double x2, z;
  x2 = x * x;
  z = -1.136788825395985E-011;
  z = __fma_rn (z, x2, 2.087588480545065E-009);
  z = __fma_rn (z, x2, -2.755731555403950E-007);
  z = __fma_rn (z, x2, 2.480158729365970E-005);
  z = __fma_rn (z, x2, -1.388888888888074E-003);
  z = __fma_rn (z, x2, 4.166666666666664E-002);
  z = __fma_rn (z, x2, -5.000000000000000E-001);
  z = __fma_rn (z, x2, 1.000000000000000E+000);
  return z;
}


static __inline__ __attribute__((always_inline)) double __internal_tan_kerneld(double x, int i)
{
  double x2, z, q;
  x2 = x * x;
  z = 9.8006287203286300E-006;
  z = __fma_rn (z, x2, -2.4279526494179897E-005);
  z = __fma_rn (z, x2, 4.8644173130937162E-005);
  z = __fma_rn (z, x2, -2.5640012693782273E-005);
  z = __fma_rn (z, x2, 6.7223984330880073E-005);
  z = __fma_rn (z, x2, 8.3559287318211639E-005);
  z = __fma_rn (z, x2, 2.4375039850848564E-004);
  z = __fma_rn (z, x2, 5.8886487754856672E-004);
  z = __fma_rn (z, x2, 1.4560454844672040E-003);
  z = __fma_rn (z, x2, 3.5921008885857180E-003);
  z = __fma_rn (z, x2, 8.8632379218613715E-003);
  z = __fma_rn (z, x2, 2.1869488399337889E-002);
  z = __fma_rn (z, x2, 5.3968253972902704E-002);
  z = __fma_rn (z, x2, 1.3333333333325342E-001);
  z = __fma_rn (z, x2, 3.3333333333333381E-001);
  z = z * x2;
  q = __fma_rn (z, x, x);
  if (i) {
    double s = q - x;
    double w = __fma_rn (z, x, -s);
    z = __internal_fast_rcp (q);
    z = -z;
    s = __fma_rn (q, z, 1.0);
    q = __fma_rn (__fma_rn (z, w, s), z, z);
  }
  return q;
}


static __inline__ __attribute__((always_inline)) double __internal_expm1_kernel (double a)
{
  double t;
  t = 2.08842685477913050E-009;
  t = __fma_rn (t, a, 2.51366409033551950E-008);
  t = __fma_rn (t, a, 2.75574612072447230E-007);
  t = __fma_rn (t, a, 2.75571539284473460E-006);
  t = __fma_rn (t, a, 2.48015869443077950E-005);
  t = __fma_rn (t, a, 1.98412699878799470E-004);
  t = __fma_rn (t, a, 1.38888888892029890E-003);
  t = __fma_rn (t, a, 8.33333333327662860E-003);
  t = __fma_rn (t, a, 4.16666666666656370E-002);
  t = __fma_rn (t, a, 1.66666666666667380E-001);
  t = __fma_rn (t, a, 5.00000000000000000E-001);
  t = t * a;
  t = __fma_rn (t, a, a);
  return t;
}


static __inline__ __attribute__((always_inline)) double __internal_atanh_kernel (double a_1, double a_2)
{
  double a, a2, t;

  a = a_1 + a_2;
  a2 = a * a;
  t = 7.597322383488143E-002/65536.0;
  t = __fma_rn (t, a2, 6.457518383364042E-002/16384.0);
  t = __fma_rn (t, a2, 7.705685707267146E-002/4096.0);
  t = __fma_rn (t, a2, 9.090417561104036E-002/1024.0);
  t = __fma_rn (t, a2, 1.111112158368149E-001/256.0);
  t = __fma_rn (t, a2, 1.428571416261528E-001/64.0);
  t = __fma_rn (t, a2, 2.000000000069858E-001/16.0);
  t = __fma_rn (t, a2, 3.333333333333198E-001/4.0);
  t = t * a2;
  t = __fma_rn (t, a, a_2);
  t = t + a_1;
  return t;
}

static __inline__ __attribute__((always_inline)) double __internal_fast_log(double a)
{
  int hi, lo;
  double m, u2, t, f, g, u, e;


  hi = __double2hiint(a);
  lo = __double2loint(a);
  e = (double)((hi >> 20) & 0x7fe) - 1022;
  m = __hiloint2double ((hi & 0x801fffff) + 0x3fe00000, lo);

  f = m - 1.0;
  g = m + 1.0;
  g = __internal_fast_rcp(g);
  u = f * g;
  t = __fma_rn (-2.0, u, f);
  t = __fma_rn (-u, f, t);
  u = __fma_rn (t, g, u);

  u2 = u * u;
  t = 8.5048800515742276E-002;
  t = __fma_rn (t, u2, 4.1724849126860759E-002);
  t = __fma_rn (t, u2, 6.0524726220470643E-002);
  t = __fma_rn (t, u2, 6.6505606704187079E-002);
  t = __fma_rn (t, u2, 7.6932741976622004E-002);
  t = __fma_rn (t, u2, 9.0908722394788727E-002);
  t = __fma_rn (t, u2, 1.1111111976824838E-001);
  t = __fma_rn (t, u2, 1.4285714274058975E-001);
  t = __fma_rn (t, u2, 2.0000000000077559E-001);
  t = __fma_rn (t, u2, 3.3333333333333154E-001);
  t = t * u2;
  t = __fma_rn (t, u, u);
  t = t + t;

  t = __fma_rn (e, 6.93147180559945290e-001, t);
  return t;
}

static __inline__ __attribute__((always_inline)) double __internal_exp2i_kernel(int b)
{
  return __hiloint2double((b + 1023) << 20, 0);
}

static __inline__ __attribute__((always_inline)) double __internal_half(double a)
{
  unsigned int ihi, ilo;
  ilo = __double2loint(a);
  ihi = __double2hiint(a);
  return __hiloint2double(ihi - 0x00100000, ilo);
}

static __inline__ __attribute__((always_inline)) double __internal_twice(double a)
{
  unsigned int ihi, ilo;
  ilo = __double2loint(a);
  ihi = __double2hiint(a);
  return __hiloint2double(ihi + 0x00100000, ilo);
}

static __inline__ __attribute__((always_inline)) double sin(double a)
{
  double z;
  int i;
  if (__isinfd(a) || (a == 0.0)) {
    return __dmul_rn(a, 0.0);
  }
  z = __internal_trig_reduction_kerneld(a, &i);

  if (i & 1) {
    z = __internal_cos_kerneld(z);
  } else {
    z = __internal_sin_kerneld(z);
  }
  if (i & 2) {
    z = -z;
  }
  return z;
}

static __inline__ __attribute__((always_inline)) double sinpi(double a)
{

  double z;



  long long l;
  int i;

  if (__isinfd(a)) {
    a = __dmul_rn(a, 0.0);
  }
  if (a == trunc(a)) {
    a = __longlong_as_double(__double_as_longlong(a)&0x8000000000000000ULL);
  }
  l = __double2ll_rn (a * 2.0f);
  i = (int)l;
  z = (double)l;
  z = __fma_rn (-z, 0.5, a);
  z = __fma_rn (z, 3.1415926535897931e+0, z * 1.2246467991473532e-16);
  if (i & 1) {
    z = __internal_cos_kerneld(z);
  } else {
    z = __internal_sin_kerneld(z);
  }
  if (i & 2) {
    z = -z;
  }
  if (a == 0.0) {
    z = a;
  }
  return z;
}

static __inline__ __attribute__((always_inline)) double cospi(double a)
{

  double z;



  long long l;
  int i;

  if (fabs(a) > 9007199254740992.0) {
    a = __dmul_rn (a, 0.0);
  }
  l = __double2ll_rn (a * 2.0f);
  i = (int)l;
  z = (double)l;
  z = __fma_rn (-z, 0.5, a);
  z = __fma_rn (z, 3.1415926535897931e+0, z * 1.2246467991473532e-16);
  i++;
  if (i & 1) {
    z = __internal_cos_kerneld(z);
  } else {
    z = __internal_sin_kerneld(z);
  }
  if (i & 2) {
    z = -z;
  }
  if (z == 0.0) {
    z = fabs (z);
  }
  return z;
}

static __inline__ __attribute__((always_inline)) double cos(double a)
{
  double z;
  int i;
  if (__isinfd(a)) {
    return __longlong_as_double(0xfff8000000000000ULL);
  }
  z = __internal_trig_reduction_kerneld(a, &i);

  i++;
  if (i & 1) {
    z = __internal_cos_kerneld(z);
  } else {
    z = __internal_sin_kerneld(z);
  }
  if (i & 2) {
    z = -z;
  }
  return z;
}





static __inline__ __attribute__((always_inline)) double __cos_offset(double a, double offset)
{
  double z;
  int i;

  z = __internal_trig_reduction_kerneld(a, &i);
  a = z + offset + (i & 3) * 1.5707963267948966e+0;
  return cos(a);
}


static __inline__ __attribute__((always_inline)) void sincos(double a, double *sptr, double *cptr)
{

  double s, c;



  double t;
  int i;

  if (__isinfd(a)) {
    a = __dmul_rn (a, 0.0);
  }
  a = __internal_trig_reduction_kerneld(a, &i);
  c = __internal_cos_kerneld(a);
  s = __internal_sin_kerneld(a);
  t = s;
  if (i & 1) {
    s = c;
    c = t;
  }
  if (i & 2) {
    s = -s;
  }
  i++;
  if (i & 2) {
    c = -c;
  }
  if (a == 0.0) {
    s = a;
  }
  *sptr = s;
  *cptr = c;
}

static __inline__ __attribute__((always_inline)) double tan(double a)
{
  double z;
  int i;
  if (__isinfd(a)) {
    return __dadd_rn (a, -a);
  }
  z = __internal_trig_reduction_kerneld(a, &i);

  z = __internal_tan_kerneld(z, i & 1);
  return z;
}

static __inline__ __attribute__((always_inline)) double log(double a)
{
  double m, f, g, u, v, tmp, q, ulo, log_lo, log_hi;
  int ihi, ilo;

  ihi = __double2hiint(a);
  ilo = __double2loint(a);

  if ((a > 0.0) && (a < __longlong_as_double(0x7ff0000000000000ULL))) {
    int e = -1023;

    if ((unsigned)ihi < (unsigned)0x00100000) {
      a = a * 18014398509481984.0;
      e -= 54;
      ihi = __double2hiint(a);
      ilo = __double2loint(a);
    }



    e += (ihi >> 20);
    ihi = (ihi & 0x800fffff) | 0x3ff00000;
    m = __hiloint2double (ihi, ilo);
    if ((unsigned)ihi > (unsigned)0x3ff6a09e) {
      m = __internal_half(m);
      e = e + 1;
    }

    f = m - 1.0;
    g = m + 1.0;
    g = __internal_fast_rcp(g);
    u = f * g;
    u = u + u;

    v = u * u;
    q = 6.7261411553826339E-2/65536.0;
    q = __fma_rn (q, v, 6.6133829643643394E-2/16384.0);
    q = __fma_rn (q, v, 7.6940931149150890E-2/4096.0);
    q = __fma_rn (q, v, 9.0908745692137444E-2/1024.0);
    q = __fma_rn (q, v, 1.1111111499059706E-1/256.0);
    q = __fma_rn (q, v, 1.4285714283305975E-1/64.0);
    q = __fma_rn (q, v, 2.0000000000007223E-1/16.0);
    q = __fma_rn (q, v, 3.3333333333333326E-1/4.0);
    tmp = 2.0 * (f - u);
    tmp = __fma_rn (-u, f, tmp);
    ulo = g * tmp;

    q = q * v;

    log_hi = u;
    log_lo = __fma_rn (q, u, ulo);

    q = __fma_rn ( e, 6.9314718055994529e-1, log_hi);
    tmp = __fma_rn (-e, 6.9314718055994529e-1, q);
    tmp = tmp - log_hi;
    log_hi = q;
    log_lo = log_lo - tmp;
    log_lo = __fma_rn (e, 2.3190468138462996e-17, log_lo);
    return log_hi + log_lo;
  } else {
    if (__isnand(a)) {
      return a + a;
    }

    if (a == 0) {
      return -__longlong_as_double(0x7ff0000000000000ULL);
    }

    if (a == __longlong_as_double(0x7ff0000000000000ULL)) {
      return a;
    }

    return __longlong_as_double(0xfff8000000000000ULL);
  }
}


static __inline__ __attribute__((always_inline)) double2 __internal_ddadd_xgty (double2 x, double2 y)
{
  double2 z;
  double r, s, e;
  r = x.y + y.y;
  e = x.y - r;
  s = ((e + y.y) + y.x) + x.x;
  z.y = e = r + s;
  z.x = (r - e) + s;
  return z;
}


static __inline__ __attribute__((always_inline)) double2 __internal_ddmul (double2 x, double2 y)
{
  double e;
  double2 t, z;
  t.y = __dmul_rn (x.y, y.y);
  t.x = __fma_rn (x.y, y.y, -t.y);
  t.x = __fma_rn (x.y, y.x, t.x);
  t.x = __fma_rn (x.x, y.y, t.x);
  z.y = e = t.y + t.x;
  z.x = (t.y - e) + t.x;
  return z;
}

static __inline__ __attribute__((always_inline)) double2 __internal_log_ext_prec(double a)
{
  double2 res;
  double2 qq, cc, uu, tt;
  double f, g, u, v, q, ulo, tmp, m;
  int ilo, ihi, expo;

  ihi = __double2hiint(a);
  ilo = __double2loint(a);
  expo = (ihi >> 20) & 0x7ff;

  if (expo == 0) {
    a *= 18014398509481984.0;
    ihi = __double2hiint(a);
    ilo = __double2loint(a);
    expo = (ihi >> 20) & 0x7ff;
    expo -= 54;
  }
  expo -= 1023;




  ihi = (ihi & 0x800fffff) | 0x3ff00000;
  m = __hiloint2double (ihi, ilo);
  if ((unsigned)ihi > (unsigned)0x3ff6a09e) {
    m = __internal_half(m);
    expo = expo + 1;
  }





  f = m - 1.0;
  g = m + 1.0;
  g = __internal_fast_rcp(g);
  u = f * g;
  u = u + u;

  v = u * u;
  q = 6.6253631649203309E-2/65536.0;
  q = __fma_rn (q, v, 6.6250935587260612E-2/16384.0);
  q = __fma_rn (q, v, 7.6935437806732829E-2/4096.0);
  q = __fma_rn (q, v, 9.0908878711093280E-2/1024.0);
  q = __fma_rn (q, v, 1.1111111322892790E-1/256.0);
  q = __fma_rn (q, v, 1.4285714284546502E-1/64.0);
  q = __fma_rn (q, v, 2.0000000000003113E-1/16.0);
  q = q * v;

  tmp = 2.0 * (f - u);
  tmp = __fma_rn (-u, f, tmp);
  ulo = g * tmp;

  qq.y = q;
  qq.x = 0.0;
  uu.y = u;
  uu.x = ulo;
  cc.y = 3.3333333333333331E-1/4.0;
  cc.x = -9.8201492846582465E-18/4.0;
  qq = __internal_ddadd_xgty (cc, qq);

  qq = __internal_ddmul(qq, uu);
  qq = __internal_ddmul(qq, uu);
  qq = __internal_ddmul(qq, uu);
  uu = __internal_ddadd_xgty (uu, qq);
  u = uu.y;
  ulo = uu.x;

  tt.y = __dmul_rn(expo, 6.9314718055966296e-01);
  tt.x = __dmul_rn(expo, 2.8235290563031577e-13);

  res = __internal_ddadd_xgty (tt, uu);
  return res;
}

static __inline__ __attribute__((always_inline)) double log2(double a)
{
  double t;
  t = log(a);
  return __fma_rn (t, 1.4426950408889634e+0, t * 2.0355273740931033e-17);
}

static __inline__ __attribute__((always_inline)) double log10(double a)
{
  double t;
  t = log(a);
  return __fma_rn (t, 4.3429448190325182e-1, t * 1.09831965021676510e-17);
}

static __inline__ __attribute__((always_inline)) double log1p(double a)
{
  double t;
  int i;

  i = __double2hiint(a);
  if (((unsigned)i < (unsigned)0x3fe55555) || ((int)i < (int)0xbfd99999)) {

    t = a + 2.0;
    t = a / t;
    t = -a * t;
    t = __internal_atanh_kernel(a, t);
    return t;
  }
  return log (a + 1.0);
}


static __inline__ __attribute__((always_inline)) double __internal_exp_poly(double a)
{
  double t;

  t = 2.5052097064908941E-008;
  t = __fma_rn (t, a, 2.7626262793835868E-007);
  t = __fma_rn (t, a, 2.7557414788000726E-006);
  t = __fma_rn (t, a, 2.4801504602132958E-005);
  t = __fma_rn (t, a, 1.9841269707468915E-004);
  t = __fma_rn (t, a, 1.3888888932258898E-003);
  t = __fma_rn (t, a, 8.3333333333978320E-003);
  t = __fma_rn (t, a, 4.1666666666573905E-002);
  t = __fma_rn (t, a, 1.6666666666666563E-001);
  t = __fma_rn (t, a, 5.0000000000000056E-001);
  t = __fma_rn (t, a, 1.0000000000000000E+000);
  t = __fma_rn (t, a, 1.0000000000000000E+000);
  return t;
}


static __inline__ __attribute__((always_inline)) double __internal_exp_scale(double a, int i)
{
  double z;
  int j, k;

  k = (i << 20) + (1023 << 20);
  if (abs(i) < 1021) {
    z = __hiloint2double (k, 0);
    z = z * a;
  } else {
    j = 0x40000000;
    if (i < 0) {
      k += (55 << 20);
      j -= (55 << 20);
    }
    k = k - (1 << 20);
    z = __hiloint2double (j, 0);
    a = a * z;
    z = __hiloint2double (k, 0);
    z = a * z;
  }
  return z;
}

static __inline__ __attribute__((always_inline)) double __internal_exp_kernel(double a, int scale)
{
  double t, z;
  int i;

  t = rint (a * 1.4426950408889634e+0);
  i = (int)t;
  z = __fma_rn (t, -6.9314718055994529e-1, a);
  z = __fma_rn (t, -2.3190468138462996e-17, z);
  t = __internal_exp_poly (z);
  z = __internal_exp_scale (t, i + scale);
  return z;
}

static __inline__ __attribute__((always_inline)) double __internal_old_exp_kernel(double a, int scale)
{
  double t, z;
  int i, j, k;

  t = rint (a * 1.4426950408889634e+0);
  i = (int)t;
  z = __fma_rn (t, -6.9314718055994529e-1, a);
  z = __fma_rn (t, -2.3190468138462996e-17, z);
  t = __internal_expm1_kernel (z);
  k = ((i + scale) << 20) + (1023 << 20);
  if (abs(i) < 1021) {
    z = __hiloint2double (k, 0);
    z = __fma_rn (t, z, z);
  } else {
    j = 0x40000000;
    if (i < 0) {
      k += (55 << 20);
      j -= (55 << 20);
    }
    k = k - (1 << 20);
    z = __hiloint2double (j, 0);
    t = __fma_rn (t, z, z);
    z = __hiloint2double (k, 0);
    z = t * z;
  }
  return z;
}

static __inline__ __attribute__((always_inline)) double exp(double a)
{
  double t;
  int i;
  i = __double2hiint(a);
  if (((unsigned)i < (unsigned)0x40862e43) || ((int)i < (int)0xC0874911)) {
    t = __internal_exp_kernel(a, 0);
    return t;
  }
  t = (i < 0) ? 0.0 : __longlong_as_double(0x7ff0000000000000ULL);
  if (__isnand(a)) {
    t = a + a;
  }
  return t;
}

static __inline__ __attribute__((always_inline)) double exp2(double a)
{
  double t, z;
  int i;

  i = __double2hiint(a);
  if (((unsigned)i < (unsigned)0x40900000) || ((int)i < (int)0xc090cc00)) {
    t = rint (a);
    z = a - t;
    i = (int)t;

    z = __fma_rn (z, 6.9314718055994529e-1, z * 2.3190468138462996e-17);
    t = __internal_exp_poly (z);
    z = __internal_exp_scale (t, i);
    return z;
  }
  t = (i < 0) ? 0.0 : __longlong_as_double(0x7ff0000000000000ULL);
  if (__isnand(a)) {
    t = a + a;
  }
  return t;
}

static __inline__ __attribute__((always_inline)) double exp10(double a)
{
  double z;
  double t;
  int i;

  i = __double2hiint(a);
  if (((unsigned)i < (unsigned)0x40734414) || ((int)i < (int)0xc07439b8)) {
    t = rint (a * 3.3219280948873622e+0);
    i = (int)t;
    z = __fma_rn (t, -3.0102999566398120e-1, a);
    z = __fma_rn (t, -(-2.8037281277851704e-18), z);

    z = __fma_rn (z, 2.3025850929940459e+0, z * (-2.1707562233822494e-16));
    t = __internal_exp_poly (z);
    z = __internal_exp_scale (t, i);
    return z;
  }
  t = (i < 0) ? 0.0 : __longlong_as_double(0x7ff0000000000000ULL);
  if (__isnand(a)) {
    t = a + a;
  }
  return t;
}

static __inline__ __attribute__((always_inline)) double __internal_expm1_scaled(double a, int scale)
{
  double t, z, u;
  int i, j, k;
  k = __double2hiint(a);
  t = rint (a * 1.4426950408889634e+0);
  i = (int)t + scale;
  z = __fma_rn (t, -6.9314718055994529e-1, a);
  z = __fma_rn (t, -2.3190468138462996e-17, z);
  k = k + k;
  if ((unsigned)k < (unsigned)0x7fb3e647) {
    z = a;
    i = 0;
  }
  t = __internal_expm1_kernel(z);
  j = i;
  if (i == 1024) j--;
  u = __internal_exp2i_kernel(j);
  a = __hiloint2double(0x3ff00000 + (scale << 20), 0);
  a = u - a;
  t = __fma_rn (t, u, a);
  if (i == 1024) t = t + t;
  if (k == 0) t = z;
  return t;
}

static __inline__ __attribute__((always_inline)) double expm1(double a)
{
  double t;
  int k;

  k = __double2hiint(a);
  if (((unsigned)k < (unsigned)0x40862e43) || ((int)k < (int)0xc04a8000)) {
    return __internal_expm1_scaled(a, 0);
  }
  t = (k < 0) ? -1.0 : __longlong_as_double(0x7ff0000000000000ULL);
  if (__isnand(a)) {
    t = a + a;
  }
  return t;
}

static __inline__ __attribute__((always_inline)) double cosh(double a)
{
  double t, z;
  int i;

  z = fabs(a);
  i = __double2hiint(z);
  if ((unsigned)i < (unsigned)0x408633cf) {
    z = __internal_exp_kernel(z, -2);
    t = __internal_fast_rcp (z);
    z = __fma_rn(2.0, z, 0.125 * t);
    return z;
  } else {
    if (z > 0.0) a = __int_as_float(0x7f800000);
    return a + a;
  }
}

static __inline__ __attribute__((always_inline)) double sinh(double a)
{
  double s, z;
  s = a;
  a = fabs(a);
  if (__double2hiint(a) < 0x3ff00000) {
    double a2 = a * a;

    z = 1.632386098183803E-010;
    z = __fma_rn (z, a2, 2.504854501385687E-008);
    z = __fma_rn (z, a2, 2.755734274788706E-006);
    z = __fma_rn (z, a2, 1.984126976294102E-004);
    z = __fma_rn (z, a2, 8.333333333452911E-003);
    z = __fma_rn (z, a2, 1.666666666666606E-001);
    z = z * a2;
    z = __fma_rn (z, a, a);
  } else {
    z = __internal_expm1_scaled (a, -1);
    z = z + z / __fma_rn (2.0, z, 1.0);
    if (a >= 7.1047586007394398e+2) {
      z = __longlong_as_double(0x7ff0000000000000ULL);
    }
  }
  z = __internal_copysign_pos(z, s);
  return z;
}

static __inline__ __attribute__((always_inline)) double tanh(double a)
{
  double t;
  t = fabs(a);
  if (t >= 0.55) {
    double s;
    s = __internal_fast_rcp (__internal_old_exp_kernel (2.0 * t, 0) + 1.0);
    s = __fma_rn (2.0, -s, 1.0);
    if (t > 350.0) {
      s = 1.0;
    }
    a = __internal_copysign_pos(s, a);
  } else {
    double a2;
    a2 = a * a;
    t = 5.102147717274194E-005;
    t = __fma_rn (t, a2, -2.103023983278533E-004);
    t = __fma_rn (t, a2, 5.791370145050539E-004);
    t = __fma_rn (t, a2, -1.453216755611004E-003);
    t = __fma_rn (t, a2, 3.591719696944118E-003);
    t = __fma_rn (t, a2, -8.863194503940334E-003);
    t = __fma_rn (t, a2, 2.186948597477980E-002);
    t = __fma_rn (t, a2, -5.396825387607743E-002);
    t = __fma_rn (t, a2, 1.333333333316870E-001);
    t = __fma_rn (t, a2, -3.333333333333232E-001);
    t = t * a2;
    t = __fma_rn (t, a, a);
    a = __internal_copysign_pos(t, a);
  }
  return a;
}

static __inline__ __attribute__((always_inline)) double __internal_atan_kernel(double a)
{
  double t, a2;
  a2 = a * a;
  t = -2.0258553044438358E-005 ;
  t = __fma_rn (t, a2, 2.2302240345758510E-004);
  t = __fma_rn (t, a2, -1.1640717779930576E-003);
  t = __fma_rn (t, a2, 3.8559749383629918E-003);
  t = __fma_rn (t, a2, -9.1845592187165485E-003);
  t = __fma_rn (t, a2, 1.6978035834597331E-002);
  t = __fma_rn (t, a2, -2.5826796814495994E-002);
  t = __fma_rn (t, a2, 3.4067811082715123E-002);
  t = __fma_rn (t, a2, -4.0926382420509971E-002);
  t = __fma_rn (t, a2, 4.6739496199157994E-002);
  t = __fma_rn (t, a2, -5.2392330054601317E-002);
  t = __fma_rn (t, a2, 5.8773077721790849E-002);
  t = __fma_rn (t, a2, -6.6658603633512573E-002);
  t = __fma_rn (t, a2, 7.6922129305867837E-002);
  t = __fma_rn (t, a2, -9.0909012354005225E-002);
  t = __fma_rn (t, a2, 1.1111110678749424E-001);
  t = __fma_rn (t, a2, -1.4285714271334815E-001);
  t = __fma_rn (t, a2, 1.9999999999755019E-001);
  t = __fma_rn (t, a2, -3.3333333333331860E-001);
  t = t * a2;
  t = __fma_rn (t, a, a);
  return t;
}

static __inline__ __attribute__((always_inline)) double atan2(double a, double b)
{
  double t0, t1, t3;
  if (__isnand(a) || __isnand(b)) {
    return a + b;
  }
  t3 = fabs(b);
  t1 = fabs(a);
  if (t3 == 0.0 && t1 == 0.0) {
    t3 = (__double2hiint(b) < 0) ? 3.1415926535897931e+0 : 0;
  } else if (__isinfd(t3) && __isinfd(t1)) {
    t3 = (__double2hiint(b) < 0) ? 2.3561944901923448e+0 : 7.8539816339744828e-1;
  } else {
    t0 = fmax (t1, t3);
    t1 = fmin (t1, t3);
    t3 = t1 / t0;
    t3 = __internal_atan_kernel(t3);

    if (fabs(a) > fabs(b)) t3 = 1.5707963267948966e+0 - t3;
    if (b < 0.0) t3 = 3.1415926535897931e+0 - t3;
  }
  t3 = __internal_copysign_pos(t3, a);
  return t3;
}

static __inline__ __attribute__((always_inline)) double atan(double a)
{
  double t0, t1;

  t0 = fabs(a);
  t1 = t0;
  if (t0 > 1.0) {
    t1 = __internal_fast_rcp (t1);
    if (t0 == __longlong_as_double(0x7ff0000000000000ULL)) t1 = 0.0;
  }

  t1 = __internal_atan_kernel(t1);

  if (t0 > 1.0) {
    t1 = 1.5707963267948966e+0 - t1;
  }
  return __internal_copysign_pos(t1, a);
}


static __inline__ __attribute__((always_inline)) double __internal_asin_kernel(double a, double b)
{
  double r;
  r = 6.259798167646803E-002;
  r = __fma_rn (r, b, -7.620591484676952E-002);
  r = __fma_rn (r, b, 6.686894879337643E-002);
  r = __fma_rn (r, b, -1.787828218369301E-002);
  r = __fma_rn (r, b, 1.745227928732326E-002);
  r = __fma_rn (r, b, 1.000422754245580E-002);
  r = __fma_rn (r, b, 1.418108777515123E-002);
  r = __fma_rn (r, b, 1.733194598980628E-002);
  r = __fma_rn (r, b, 2.237350511593569E-002);
  r = __fma_rn (r, b, 3.038188875134962E-002);
  r = __fma_rn (r, b, 4.464285849810986E-002);
  r = __fma_rn (r, b, 7.499999998342270E-002);
  r = __fma_rn (r, b, 1.666666666667375E-001);
  r = r * b;
  return r;
}

static __inline__ __attribute__((always_inline)) double asin(double a)
{
  double fa, t0, t1;
  int ihi, ahi;
  ahi = __double2hiint(a);
  fa = fabs(a);
  ihi = __double2hiint(fa);
  if (ihi < 0x3fe26666) {
    t1 = fa * fa;
    t1 = __internal_asin_kernel (fa, t1);
    t1 = __fma_rn (t1, fa, fa);
    t1 = __internal_copysign_pos(t1, a);
  } else {
    t1 = __fma_rn (-0.5, fa, 0.5);
    t0 = sqrt (t1);
    t1 = __internal_asin_kernel (t0, t1);
    t0 = -2.0 * t0;
    t1 = __fma_rn (t0, t1, 6.1232339957367660e-17);
    t0 = t0 + 7.8539816339744828e-1;
    t1 = t0 + t1;
    t1 = t1 + 7.8539816339744828e-1;
    if (ahi < 0x3ff00000) {
      t1 = __internal_copysign_pos(t1, a);
    }
  }
  return t1;
}

static __inline__ __attribute__((always_inline)) double acos(double a)
{
  double t0, t1;
  int ihi, ahi;

  ahi = __double2hiint(a);
  t0 = fabs (a);
  ihi = __double2hiint(t0);
  if (ihi < 0x3fe26666) {
    t1 = t0 * t0;
    t1 = __internal_asin_kernel (t0, t1);
    t0 = __fma_rn (t1, t0, t0);
    if (ahi < 0) {
      t0 = __dadd_rn (t0, +6.1232339957367660e-17);
      t0 = __dadd_rn (1.5707963267948966e+0, +t0);
    } else {
      t0 = __dadd_rn (t0, -6.1232339957367660e-17);
      t0 = __dadd_rn (1.5707963267948966e+0, -t0);
    }
  } else {
    t1 = __fma_rn (-0.5, t0, 0.5);
    t0 = sqrt (t1);
    t1 = __internal_asin_kernel (t0, t1);
    t0 = __fma_rn (t1, t0, t0);
    t0 = 2.0 * t0;
    if (ahi < 0) {
      t0 = __dadd_rn (t0, -1.2246467991473532e-16);
      t0 = __dadd_rn (3.1415926535897931e+0, -t0);
    }
  }
  return t0;
}

static __inline__ __attribute__((always_inline)) double acosh(double a)
{
  double t;
  t = a - 1.0;
  if (fabs(t) > 4503599627370496.0) {

    return 6.9314718055994529e-1 + log(a);
  } else {
    t = t + sqrt(__fma_rn(a, t, t));
    return log1p(t);
  }
}

static __inline__ __attribute__((always_inline)) double asinh(double a)
{
  double fa, t;
  fa = fabs(a);
  if (__double2hiint(fa) >= 0x5ff00000) {
    t = 6.9314718055994529e-1 + log(fa);
  } else {
    t = fa * fa;
    t = log1p (fa + t / (1.0 + sqrt(1.0 + t)));
  }
  return __internal_copysign_pos(t, a);
}

static __inline__ __attribute__((always_inline)) double atanh(double a)
{
  double fa, t;
  fa = fabs(a);
  t = (2.0 * fa) / (1.0 - fa);
  t = 0.5 * log1p(t);
  if (__double2hiint(a) < 0) {
    t = -t;
  }
  return t;
}

static __inline__ __attribute__((always_inline)) double hypot(double a, double b)
{
  double v, w, t, fa, fb;

  fa = fabs(a);
  fb = fabs(b);
  v = fmax(fa, fb);
  w = fmin(fa, fb);
  t = w / v;
  t = __fma_rn (t, t, 1.0);
  t = v * sqrt(t);
  if (v == 0.0) {
    t = v + w;
  }
  if ((!(fa <= __longlong_as_double(0x7ff0000000000000ULL))) || (!(fb <= __longlong_as_double(0x7ff0000000000000ULL)))) {
    t = a + b;
  }
  if (v == __longlong_as_double(0x7ff0000000000000ULL)) {
    t = v + w;
  }
  return t;
}

static __inline__ __attribute__((always_inline)) double cbrt(double a)
{
  float s;
  double t, r;
  int ilo, ihi, expo, nexpo, denorm;
  if ((a == 0.0) || !(__isfinited(a))) {
    return a + a;
  }
  t = fabs(a);
  ilo = __double2loint(t);
  ihi = __double2hiint(t);
  expo = ((int)((unsigned int)ihi >> 20) & 0x7ff);
  denorm = 0;
  if (expo == 0) {

    t = t * 18014398509481984.0;
    denorm = 18;
    ilo = __double2loint(t);
    ihi = __double2hiint(t);
    expo = ((int)((unsigned int)ihi >> 20) & 0x7ff);
  }

  nexpo = __float2int_rn(0.333333333f * (float)(expo - 1022));
  ihi -= (3 * nexpo) << 20;
  r = __hiloint2double(ihi, ilo);

  s = (float)r;
  t = exp2f(-0.333333333f * __log2f(s));
  t = __fma_rn(__fma_rn(t*t,-r*t,1.0), 3.3333333333333333e-1*t, t);
  t = r * t * t;
  t = __fma_rn(t - (r / (t * t)), -3.3333333333333333e-1, t);

  ilo = __double2loint(t);
  ihi = __double2hiint(t);
  ihi += (nexpo - denorm) << 20;
  t = __hiloint2double(ihi, ilo);
  if (__double2hiint(a) < 0) {
    t = -t;
  }
  return t;
}

static __inline__ __attribute__((always_inline)) double rcbrt(double a)
{
  float s;
  double t, r;
  int ilo, ihi, expo, nexpo, denorm;
  if ((a == 0.0) || !(__isfinited(a))) {
    return 1.0 / a;
  }
  t = fabs(a);
  ilo = __double2loint(t);
  ihi = __double2hiint(t);
  expo = ((int)((unsigned int)ihi >> 20) & 0x7ff);
  denorm = 0;
  if (expo == 0) {

    t = t * 18014398509481984.0;
    denorm = 18;
    ilo = __double2loint(t);
    ihi = __double2hiint(t);
    expo = ((int)((unsigned int)ihi >> 20) & 0x7ff);
  }

  nexpo = __float2int_rn(0.333333333f * (float)(expo - 1022));
  ihi -= (3 * nexpo) << 20;
  r = __hiloint2double(ihi, ilo);

  s = (float)r;
  t = exp2f(-0.333333333f * __log2f(s));
  t = __fma_rn(__fma_rn(t*t,-r*t,1.0), 3.3333333333333333e-1*t, t);
  t = __fma_rn(__fma_rn(t*t,-r*t,1.0), 3.3333333333333333e-1*t, t);

  ilo = __double2loint(t);
  ihi = __double2hiint(t);
  ihi += (-(nexpo - denorm)) << 20;
  t = __hiloint2double(ihi, ilo);
  if (__double2hiint(a) < 0) {
    t = -t;
  }
  return t;
}

static __inline__ __attribute__((always_inline)) double __internal_accurate_pow(double a, double b)
{
  double2 loga;
  double2 prod;
  double t_hi, t_lo;
  double tmp;
  double e;


  loga = __internal_log_ext_prec(a);


  if (fabs(b) > 1e304) b *= 1.220703125e-4;

  t_hi = __dmul_rn (loga.y, b);
  t_lo = __fma_rn (loga.y, b, -t_hi);
  t_lo = __fma_rn (loga.x, b, t_lo);
  prod.y = e = t_hi + t_lo;
  prod.x = (t_hi - e) + t_lo;


  tmp = exp(prod.y);

  if (!__isinfd(tmp)) {



    tmp = __fma_rn (tmp, prod.x, tmp);
  }
  return tmp;
}

static __inline__ __attribute__((always_inline)) double pow(double a, double b)
{
  int bIsOddInteger;
  double t;

  if (a == 1.0 || b == 0.0) {
    return 1.0;
  }
  if (__isnand(a) || __isnand(b)) {
    return a + b;
  }
  if (a == __longlong_as_double(0x7ff0000000000000ULL)) {
    return (__double2hiint(b) < 0) ? 0.0 : __longlong_as_double(0x7ff0000000000000ULL);
  }
  if (__isinfd(b)) {
    if (a == -1.0) {
      return 1.0;
    }
    t = fabs(a) > 1.0 ? __longlong_as_double(0x7ff0000000000000ULL) : 0.0;
    if (b < 0.0) {
      t = 1.0 / t;
    }
    return t;
  }
  bIsOddInteger = fabs(b - (2.0f * trunc(0.5 * b))) == 1.0;
  if (a == 0.0) {
    t = bIsOddInteger ? a : 0.0;
    if (b < 0.0) {
      t = 1.0 / t;
    }
    return t;
  }
  if (a == -__longlong_as_double(0x7ff0000000000000ULL)) {
    t = (b < 0.0) ? -1.0/a : -a;
    if (bIsOddInteger) {
      t = __longlong_as_double(__double_as_longlong(t)^0x8000000000000000ULL);
    }
    return t;
  }
  if ((a < 0.0) && (b != trunc(b))) {
    return __longlong_as_double(0xfff8000000000000ULL);
  }
  t = fabs(a);
  t = __internal_accurate_pow(t, b);
  if ((a < 0.0) && bIsOddInteger) {
    t = __longlong_as_double(__double_as_longlong(t) ^ 0x8000000000000000ULL);
  }
  return t;
}

static __inline__ __attribute__((always_inline)) double j0(double a)
{
  double t, r, x;
  r = 0.0;
  t = fabs(a);
  if (t <= 3.962451833991041709e0) {
    x = ((t - 2.404825557695772886e0) - -1.176691651530894036e-16);
    r = -4.668055296522885552e-16;
    r = __fma_rn(r, x, -6.433200527258554127e-15);
    r = __fma_rn(r, x, 1.125154785441239563e-13);
    r = __fma_rn(r, x, 1.639521934089839047e-12);
    r = __fma_rn(r, x, -2.534199601670673987e-11);
    r = __fma_rn(r, x, -3.166660834754117150e-10);
    r = __fma_rn(r, x, 4.326570922239416813e-9);
    r = __fma_rn(r, x, 4.470057037570427580e-8);
    r = __fma_rn(r, x, -5.304914441394479122e-7);
    r = __fma_rn(r, x, -4.338826303234108986e-6);
    r = __fma_rn(r, x, 4.372919273219640746e-5);
    r = __fma_rn(r, x, 2.643770367619977359e-4);
    r = __fma_rn(r, x, -2.194200359017061189e-3);
    r = __fma_rn(r, x, -8.657669593307546971e-3);
    r = __fma_rn(r, x, 5.660177443794636720e-2);
    r = __fma_rn(r, x, 1.079387017549203048e-1);
    r = __fma_rn(r, x, -5.191474972894667417e-1);
    r *= x;
  } else if (t <= 7.086903011598661433e0) {
    x = ((t - 5.520078110286310569e0) - 8.088597146146722332e-17);
    r = 3.981548125960367572e-16;
    r = __fma_rn(r, x, 5.384425646000319613e-15);
    r = __fma_rn(r, x, -1.208169028319422770e-13);
    r = __fma_rn(r, x, -1.379791615846302261e-12);
    r = __fma_rn(r, x, 2.745222536512400531e-11);
    r = __fma_rn(r, x, 2.592191169087820231e-10);
    r = __fma_rn(r, x, -4.683395694900245463e-9);
    r = __fma_rn(r, x, -3.511535752914609294e-8);
    r = __fma_rn(r, x, 5.716490702257101151e-7);
    r = __fma_rn(r, x, 3.199786905053059080e-6);
    r = __fma_rn(r, x, -4.652109073941537520e-5);
    r = __fma_rn(r, x, -1.751857289934499263e-4);
    r = __fma_rn(r, x, 2.257440229032805189e-3);
    r = __fma_rn(r, x, 4.631042145907517116e-3);
    r = __fma_rn(r, x, -5.298855286760461442e-2);
    r = __fma_rn(r, x, -3.082065142559364118e-2);
    r = __fma_rn(r, x, 3.402648065583681602e-1);
    r *= x;
  } else if (t <= 1.022263117596264692e1) {
    x = ((t - 8.653727912911012510e0) - -2.928126073207789799e-16);
    r = -4.124304662099804879e-16;
    r = __fma_rn(r, x, -4.596716020545263225e-15);
    r = __fma_rn(r, x, 1.243104269818899322e-13);
    r = __fma_rn(r, x, 1.149516171925282771e-12);
    r = __fma_rn(r, x, -2.806255120718408997e-11);
    r = __fma_rn(r, x, -2.086671689271728758e-10);
    r = __fma_rn(r, x, 4.736806709085623724e-9);
    r = __fma_rn(r, x, 2.694156819104033891e-8);
    r = __fma_rn(r, x, -5.679379510457043302e-7);
    r = __fma_rn(r, x, -2.288391007218622664e-6);
    r = __fma_rn(r, x, 4.482303544494819955e-5);
    r = __fma_rn(r, x, 1.124348678929902644e-4);
    r = __fma_rn(r, x, -2.060335155125843105e-3);
    r = __fma_rn(r, x, -2.509302227210569083e-3);
    r = __fma_rn(r, x, 4.403377496341183417e-2);
    r = __fma_rn(r, x, 1.568412496095387618e-2);
    r = __fma_rn(r, x, -2.714522999283819349e-1);
    r *= x;
  } else if (!__isinfd(t)) {
    double y = __internal_fast_rcp(t);
    double y2 = y * y;
    double f, arg;
    f = -1.749518042413318545e4;
    f = __fma_rn(f, y2, 1.609818826277744392e3);
    f = __fma_rn(f, y2, -9.327297929346906358e1);
    f = __fma_rn(f, y2, 5.754657357710742716e0);
    f = __fma_rn(f, y2, -5.424139391385890407e-1);
    f = __fma_rn(f, y2, 1.035143619926359032e-1);
    f = __fma_rn(f, y2, -6.249999788858900951e-2);
    f = __fma_rn(f, y2, 9.999999999984622301e-1);
    arg = -2.885116220349355482e6;
    arg = __fma_rn(arg, y2, 2.523286424277686747e5);
    arg = __fma_rn(arg, y2, -1.210196952664123455e4);
    arg = __fma_rn(arg, y2, 4.916296687065029687e2);
    arg = __fma_rn(arg, y2, -2.323271029624128303e1);
    arg = __fma_rn(arg, y2, 1.637144946408570334e0);
    arg = __fma_rn(arg, y2, -2.095680312729443495e-1);
    arg = __fma_rn(arg, y2, 6.510416335987831427e-2);
    arg = __fma_rn(arg, y2, -1.249999999978858578e-1);
    arg = __fma_rn(arg, y, t);
    r = rsqrt(t) * 7.9788456080286536e-1 * f * __cos_offset(arg, -7.8539816339744831e-1);
  } else {

    r = 0.0;
  }
  return r;
}

static __inline__ __attribute__((always_inline)) double j1(double a)
{
  double t, r, x;
  r = 0.0;
  t = fabs(a);
  if (t <= 2.415852985103756012e0) {
    x = ((t - 0.000000000000000000e-1) - 0.000000000000000000e-1);
    r = 8.018399195792647872e-15;
    r = __fma_rn(r, x, -2.118695440834766210e-13);
    r = __fma_rn(r, x, 2.986477477755093929e-13);
    r = __fma_rn(r, x, 3.264658690505054749e-11);
    r = __fma_rn(r, x, 2.365918244990000764e-12);
    r = __fma_rn(r, x, -5.655535980321211576e-9);
    r = __fma_rn(r, x, 5.337726421910612559e-12);
    r = __fma_rn(r, x, 6.781633105423295953e-7);
    r = __fma_rn(r, x, 3.551463066921223471e-12);
    r = __fma_rn(r, x, -5.425347399642436942e-5);
    r = __fma_rn(r, x, 6.141520947159623346e-13);
    r = __fma_rn(r, x, 2.604166666526797937e-3);
    r = __fma_rn(r, x, 1.929721653824376829e-14);
    r = __fma_rn(r, x, -6.250000000000140166e-2);
    r = __fma_rn(r, x, 4.018089105880317857e-17);
    r = __fma_rn(r, x, 5.000000000000000000e-1);
    r *= x;
  } else if (t <= 5.423646320011565535e0) {
    x = ((t - 3.831705970207512468e0) - -1.526918409008806686e-16);
    r = -5.512780891825248469e-15;
    r = __fma_rn(r, x, 1.208228522598007249e-13);
    r = __fma_rn(r, x, 1.250828223475420523e-12);
    r = __fma_rn(r, x, -2.797792344085172005e-11);
    r = __fma_rn(r, x, -2.362345221426392649e-10);
    r = __fma_rn(r, x, 4.735362223346154893e-9);
    r = __fma_rn(r, x, 3.248288715654640665e-8);
    r = __fma_rn(r, x, -5.727805561466869718e-7);
    r = __fma_rn(r, x, -3.036863401211637746e-6);
    r = __fma_rn(r, x, 4.620870128840665444e-5);
    r = __fma_rn(r, x, 1.746642907294104828e-4);
    r = __fma_rn(r, x, -2.233125339145115504e-3);
    r = __fma_rn(r, x, -5.179719245640395341e-3);
    r = __fma_rn(r, x, 5.341044413272456881e-2);
    r = __fma_rn(r, x, 5.255614585697734181e-2);
    r = __fma_rn(r, x, -4.027593957025529803e-1);
    r *= x;
  } else if (t <= 8.594527402439170415e0) {
    x = ((t - 7.015586669815618848e0) - -9.414165653410388908e-17);
    r = 4.423133061281035160e-15;
    r = __fma_rn(r, x, -1.201320120922480112e-13);
    r = __fma_rn(r, x, -1.120851060072903875e-12);
    r = __fma_rn(r, x, 2.798783538427610697e-11);
    r = __fma_rn(r, x, 2.065329706440647244e-10);
    r = __fma_rn(r, x, -4.720444222309518119e-9);
    r = __fma_rn(r, x, -2.727342515669842039e-8);
    r = __fma_rn(r, x, 5.665269543584226731e-7);
    r = __fma_rn(r, x, 2.401580794492155375e-6);
    r = __fma_rn(r, x, -4.499147527210508836e-5);
    r = __fma_rn(r, x, -1.255079095508101735e-4);
    r = __fma_rn(r, x, 2.105587143238240189e-3);
    r = __fma_rn(r, x, 3.130291726048001991e-3);
    r = __fma_rn(r, x, -4.697047894974023391e-2);
    r = __fma_rn(r, x, -2.138921280934158106e-2);
    r = __fma_rn(r, x, 3.001157525261325398e-1);
    r *= x;
  } else if (!__isinfd(t)) {
    double y = __internal_fast_rcp(t);
    double y2 = y * y;
    double f, arg;
    f = 1.485383005325836814e4;
    f = __fma_rn(f, y2, -1.648096811830575007e3);
    f = __fma_rn(f, y2, 1.101438783774615899e2);
    f = __fma_rn(f, y2, -7.551889723469123794e0);
    f = __fma_rn(f, y2, 8.042591538676234775e-1);
    f = __fma_rn(f, y2, -1.933557706160460576e-1);
    f = __fma_rn(f, y2, 1.874999929278536315e-1);
    f = __fma_rn(f, y2, 1.000000000005957013e0);
    arg = -6.214794014836998139e7;
    arg = __fma_rn(arg, y2, 6.865585630355566740e6);
    arg = __fma_rn(arg, y2, -3.832405418387809768e5);
    arg = __fma_rn(arg, y2, 1.571235974698157042e4);
    arg = __fma_rn(arg, y2, -6.181902458868638632e2);
    arg = __fma_rn(arg, y2, 3.039697998508859911e1);
    arg = __fma_rn(arg, y2, -2.368515193214345782e0);
    arg = __fma_rn(arg, y2, 3.708961732933458433e-1);
    arg = __fma_rn(arg, y2, -1.640624965735098806e-1);
    arg = __fma_rn(arg, y2, 3.749999999976813547e-1);
    arg = __fma_rn(arg, y, t);
    r = rsqrt(t) * 7.9788456080286536e-1 * f * __cos_offset(arg, -2.3561944901923449e0);
  } else {

    r = 0.0;
  }
  if (a < 0.0) {
    r = -r;
  }
  if (t < 1e-30) {
    r = a * 0.5;
  }
  return r;
}

static __inline__ __attribute__((always_inline)) double y0(double a)
{
  double t, r, x;
  r = 0.0;
  t = fabs(a);
  if (t <= 7.967884831395837253e-1) {
    x = t * t;
    r = 5.374806887266719984e-17;
    r = __fma_rn(r, x, -1.690851667879507126e-14);
    r = __fma_rn(r, x, 4.136256698488524230e-12);
    r = __fma_rn(r, x, -7.675202391864751950e-10);
    r = __fma_rn(r, x, 1.032530269160133847e-7);
    r = __fma_rn(r, x, -9.450377743948014966e-6);
    r = __fma_rn(r, x, 5.345180760328465709e-4);
    r = __fma_rn(r, x, -1.584294153256949819e-2);
    r = __fma_rn(r, x, 1.707584669151278045e-1);
    r *= (x - 4.322145581245422363e-1) - -1.259433890510308629e-9;
    r += 6.3661977236758138e-1 * log(t) * j0(t);
  } else if (t <= 2.025627692797012713e0) {
    x = ((t - 8.935769662791674950e-1) - 2.659623153972038487e-17);
    r = -3.316256912072560202e-5;
    r = __fma_rn(r, x, 4.428203736344834521e-4);
    r = __fma_rn(r, x, -2.789856306341642004e-3);
    r = __fma_rn(r, x, 1.105846367024121250e-2);
    r = __fma_rn(r, x, -3.107223394960596102e-2);
    r = __fma_rn(r, x, 6.626287772780777019e-2);
    r = __fma_rn(r, x, -1.125221809100773462e-1);
    r = __fma_rn(r, x, 1.584073414576677719e-1);
    r = __fma_rn(r, x, -1.922273494240156200e-1);
    r = __fma_rn(r, x, 2.093393446684197468e-1);
    r = __fma_rn(r, x, -2.129333765401472400e-1);
    r = __fma_rn(r, x, 2.093702358334368907e-1);
    r = __fma_rn(r, x, -2.037455528835861451e-1);
    r = __fma_rn(r, x, 1.986558106005199553e-1);
    r = __fma_rn(r, x, -1.950678188917356060e-1);
    r = __fma_rn(r, x, 1.933768292594399973e-1);
    r = __fma_rn(r, x, -1.939501240454329922e-1);
    r = __fma_rn(r, x, 1.973356651370720138e-1);
    r = __fma_rn(r, x, -2.048771973714162697e-1);
    r = __fma_rn(r, x, 2.189484270119261000e-1);
    r = __fma_rn(r, x, -2.261217135462367245e-1);
    r = __fma_rn(r, x, 2.205528284817022400e-1);
    r = __fma_rn(r, x, -4.920789342629753871e-1);
    r = __fma_rn(r, x, 8.794208024971947868e-1);
    r *= x;
  } else if (t <= 5.521864739808315283e0) {
    x = ((t - 3.957678419314857976e0) - -1.076434069756270603e-16);
    r = -1.494114173821677059e-15;
    r = __fma_rn(r, x, -1.013791156119442377e-15);
    r = __fma_rn(r, x, 1.577311216240784649e-14);
    r = __fma_rn(r, x, 3.461700831703228390e-14);
    r = __fma_rn(r, x, -1.390049111128330285e-13);
    r = __fma_rn(r, x, -2.651585913591809710e-14);
    r = __fma_rn(r, x, -2.563422432591884445e-13);
    r = __fma_rn(r, x, 3.152125074327968061e-12);
    r = __fma_rn(r, x, -1.135177389965644664e-11);
    r = __fma_rn(r, x, 4.326378313976470202e-11);
    r = __fma_rn(r, x, -1.850879474448778845e-10);
    r = __fma_rn(r, x, 7.689088938316559034e-10);
    r = __fma_rn(r, x, -3.657694558233732877e-9);
    r = __fma_rn(r, x, 1.892629263079880039e-8);
    r = __fma_rn(r, x, -2.185282420222553349e-8);
    r = __fma_rn(r, x, -2.934871156586473999e-7);
    r = __fma_rn(r, x, -4.893369556967850888e-6);
    r = __fma_rn(r, x, 5.092291346093084947e-5);
    r = __fma_rn(r, x, 1.952694025023884918e-4);
    r = __fma_rn(r, x, -2.183518873989655565e-3);
    r = __fma_rn(r, x, -6.852566677116652717e-3);
    r = __fma_rn(r, x, 5.852382210516620525e-2);
    r = __fma_rn(r, x, 5.085590959215843115e-2);
    r = __fma_rn(r, x, -4.025426717750241745e-1);
    r *= x;
  } else if (t <= 8.654198051899094858e0) {
    x = ((t - 7.086051060301772786e0) - -8.835285723085408128e-17);
    r = 3.951031695740590034e-15;
    r = __fma_rn(r, x, -1.110810503294961990e-13);
    r = __fma_rn(r, x, -1.310829469053465703e-12);
    r = __fma_rn(r, x, 2.824621267525193929e-11);
    r = __fma_rn(r, x, 2.302923649674420956e-10);
    r = __fma_rn(r, x, -4.717174021172401832e-9);
    r = __fma_rn(r, x, -3.098470041689314533e-8);
    r = __fma_rn(r, x, 5.749349008560620678e-7);
    r = __fma_rn(r, x, 2.701363791846417715e-6);
    r = __fma_rn(r, x, -4.595140667075523833e-5);
    r = __fma_rn(r, x, -1.406025977407872123e-4);
    r = __fma_rn(r, x, 2.175984016431612746e-3);
    r = __fma_rn(r, x, 3.318348268895694383e-3);
    r = __fma_rn(r, x, -4.802407007625847379e-2);
    r = __fma_rn(r, x, -2.117523655676954025e-2);
    r = __fma_rn(r, x, 3.000976149104751523e-1);
    r *= x;
  } else if (!__isinfd(t)) {
    double y = __internal_fast_rcp(t);
    double y2 = y * y;
    double f, arg;
    f = -1.121823763318965797e4;
    f = __fma_rn(f, y2, 1.277353533221286625e3);
    f = __fma_rn(f, y2, -8.579416608392857313e1);
    f = __fma_rn(f, y2, 5.662125060937317933e0);
    f = __fma_rn(f, y2, -5.417345171533867187e-1);
    f = __fma_rn(f, y2, 1.035114040728313117e-1);
    f = __fma_rn(f, y2, -6.249999082419847168e-2);
    f = __fma_rn(f, y2, 9.999999999913266047e-1);
    arg = 5.562900148486682495e7;
    arg = __fma_rn(arg, y2, -6.039326416769045405e6);
    arg = __fma_rn(arg, y2, 3.303804467797655961e5);
    arg = __fma_rn(arg, y2, -1.320780106166394580e4);
    arg = __fma_rn(arg, y2, 5.015151566589033791e2);
    arg = __fma_rn(arg, y2, -2.329056718317451669e1);
    arg = __fma_rn(arg, y2, 1.637366947135598716e0);
    arg = __fma_rn(arg, y2, -2.095685710525915790e-1);
    arg = __fma_rn(arg, y2, 6.510416411708590256e-2);
    arg = __fma_rn(arg, y2, -1.249999999983588544e-1);
    arg = __fma_rn(arg, y, t);
    r = rsqrt(t) * 7.9788456080286536e-1 * f * __cos_offset(arg, -2.356194490192344929e0);
  } else {

    r = 0.0;
  }
  if (a < 0.0) {
    r = __longlong_as_double(0xfff8000000000000ULL);
  }
  return r;
}

static __inline__ __attribute__((always_inline)) double y1(double a)
{
  double t, r, x;
  r = 0.0;
  t = fabs(a);
  if (t < 1e-308) {

    r = -6.3661977236758138e-1 / t;
  } else if (t <= 1.298570663015508497e0) {
    x = t * t;
    r = 2.599016977114429789e-13;
    r = __fma_rn(r, x, -5.646936040707309767e-11);
    r = __fma_rn(r, x, 8.931867331036295581e-9);
    r = __fma_rn(r, x, -9.926740542145188722e-7);
    r = __fma_rn(r, x, 7.164268749708438400e-5);
    r = __fma_rn(r, x, -2.955305336079382290e-3);
    r = __fma_rn(r, x, 5.434868816051021539e-2);
    r = __fma_rn(r, x, -1.960570906462389407e-1);
    r *= t;
    r += 6.3661977236758138e-1 * (log(t) * j1(t) - 1.0 / t);
  } else if (t <= 3.213411183412576033e0) {
    x = ((t - 2.197141326031017083e0) - -4.825983587645496567e-17);
    r = -3.204918540045980739e-9;
    r = __fma_rn(r, x, 1.126985362938592444e-8);
    r = __fma_rn(r, x, -9.725182107962382221e-9);
    r = __fma_rn(r, x, 1.083612003186428926e-9);
    r = __fma_rn(r, x, -3.318806432859500986e-8);
    r = __fma_rn(r, x, 1.152009920780307640e-7);
    r = __fma_rn(r, x, -2.165762322547769634e-7);
    r = __fma_rn(r, x, 4.248883280005704350e-7);
    r = __fma_rn(r, x, -9.597291015128258274e-7);
    r = __fma_rn(r, x, 2.143651955073189370e-6);
    r = __fma_rn(r, x, -4.688317848511307222e-6);
    r = __fma_rn(r, x, 1.026066296099274397e-5);
    r = __fma_rn(r, x, -2.248872084380127776e-5);
    r = __fma_rn(r, x, 4.924499594496305443e-5);
    r = __fma_rn(r, x, -1.077609598179235436e-4);
    r = __fma_rn(r, x, 2.358698833633901006e-4);
    r = __fma_rn(r, x, -5.096012361553002188e-4);
    r = __fma_rn(r, x, 1.066853008500809634e-3);
    r = __fma_rn(r, x, -2.595241693183597629e-3);
    r = __fma_rn(r, x, 7.422553332334889779e-3);
    r = __fma_rn(r, x, -4.797811669942416563e-3);
    r = __fma_rn(r, x, -3.285739740527982705e-2);
    r = __fma_rn(r, x, -1.185145457490981991e-1);
    r = __fma_rn(r, x, 5.207864124022675290e-1);
    r *= x;
  } else if (t <= 7.012843454562652030e0) {
    x = ((t - 5.429681040794134717e0) - 4.162514026670377007e-16);
    r = 3.641000824697897087e-16;
    r = __fma_rn(r, x, 6.273399595774693961e-16);
    r = __fma_rn(r, x, -1.656717829265264444e-15);
    r = __fma_rn(r, x, -1.793477656341538960e-14);
    r = __fma_rn(r, x, 4.410546816390020042e-14);
    r = __fma_rn(r, x, -1.387851333205382620e-13);
    r = __fma_rn(r, x, 1.170075916815038820e-12);
    r = __fma_rn(r, x, -4.612886656846937267e-12);
    r = __fma_rn(r, x, 2.222126653072601592e-12);
    r = __fma_rn(r, x, -3.852562731318657049e-10);
    r = __fma_rn(r, x, 5.598172933325135304e-9);
    r = __fma_rn(r, x, 2.550481704211604017e-8);
    r = __fma_rn(r, x, -5.464422265470442015e-7);
    r = __fma_rn(r, x, -2.863862325810848798e-6);
    r = __fma_rn(r, x, 4.645867915733586050e-5);
    r = __fma_rn(r, x, 1.466208928172848137e-4);
    r = __fma_rn(r, x, -2.165998751115648553e-3);
    r = __fma_rn(r, x, -4.160115934377754676e-3);
    r = __fma_rn(r, x, 5.094793974342303605e-2);
    r = __fma_rn(r, x, 3.133867744408601330e-2);
    r = __fma_rn(r, x, -3.403180455234405821e-1);
    r *= x;
  } else if (t <= 9.172580349585524928e0) {
    x = ((t - 8.596005868331168642e0) - 2.841583834006366401e-16);
    r = 2.305446091542135639e-16;
    r = __fma_rn(r, x, -1.372616651279859895e-13);
    r = __fma_rn(r, x, -1.067085198258553687e-12);
    r = __fma_rn(r, x, 2.797080742350623921e-11);
    r = __fma_rn(r, x, 1.883663311130206595e-10);
    r = __fma_rn(r, x, -4.684316504597157100e-9);
    r = __fma_rn(r, x, -2.441923258474869187e-8);
    r = __fma_rn(r, x, 5.586530988420728856e-7);
    r = __fma_rn(r, x, 2.081926450587367740e-6);
    r = __fma_rn(r, x, -4.380739676566903498e-5);
    r = __fma_rn(r, x, -1.042014850604930338e-4);
    r = __fma_rn(r, x, 2.011492014389694005e-3);
    r = __fma_rn(r, x, 2.417956732829416259e-3);
    r = __fma_rn(r, x, -4.340642670740071929e-2);
    r = __fma_rn(r, x, -1.578988436429690570e-2);
    r = __fma_rn(r, x, 2.714598773115335373e-1);
    r *= x;
  } else if (!__isinfd(t)) {
    double y = __internal_fast_rcp(t);
    double y2 = y * y;
    double f, arg;
    f = 1.765479925082250655e4;
    f = __fma_rn(f, y2, -1.801727125254790963e3);
    f = __fma_rn(f, y2, 1.136675500338510290e2);
    f = __fma_rn(f, y2, -7.595622833654403827e0);
    f = __fma_rn(f, y2, 8.045758488114477247e-1);
    f = __fma_rn(f, y2, -1.933571068757167499e-1);
    f = __fma_rn(f, y2, 1.874999959666924232e-1);
    f = __fma_rn(f, y2, 1.000000000003085088e0);
    arg = -8.471357607824940103e7;
    arg = __fma_rn(arg, y2, 8.464204863822212443e6);
    arg = __fma_rn(arg, y2, -4.326694608144371887e5);
    arg = __fma_rn(arg, y2, 1.658700399613585250e4);
    arg = __fma_rn(arg, y2, -6.279420695465894369e2);
    arg = __fma_rn(arg, y2, 3.046796375066591622e1);
    arg = __fma_rn(arg, y2, -2.368852258237428732e0);
    arg = __fma_rn(arg, y2, 3.708971794716567350e-1);
    arg = __fma_rn(arg, y2, -1.640624982860321990e-1);
    arg = __fma_rn(arg, y2, 3.749999999989471755e-1);
    arg = __fma_rn(arg, y, t);
    r = rsqrt(t) * 7.9788456080286536e-1 * f * __cos_offset(arg, -3.926990816987241548e0);
  } else {
    r = 0.0;
  }
  if (a <= 0.0) {
    if (a == 0.0) {
      r = -__longlong_as_double(0x7ff0000000000000ULL);
    } else {
      r = __longlong_as_double(0xfff8000000000000ULL);
    }
  }
  return r;
}





static __inline__ __attribute__((always_inline)) double yn(int n, double a)
{
  double yip1;
  double yi = y1(a);
  double yim1 = y0(a);
  double two_over_a;
  int i;
  if(n == 0) {
    return y0(a);
  }
  if(n == 1) {
    return y1(a);
  }
  if(n < 0) {
    return __longlong_as_double(0xfff8000000000000ULL);
  }
  if(!(a >= 0.0)) {

    return __longlong_as_double(0xfff8000000000000ULL);
  }
  if (fabs(a) < 1e-308) {

    return -6.3661977236758138e-1 / a;
  }
  two_over_a = 2.0 / a;
  for(i = 1; i < n; i++) {

    yip1 = __fma_rn(i * two_over_a, yi, -yim1);
    yim1 = yi;
    yi = yip1;
  }
  if(__isnand(yip1)) {

    return -__longlong_as_double(0x7ff0000000000000ULL);
  }
  return yip1;
}
# 2043 "/usr/local/cuda/bin/../include/math_functions_dbl_ptx3.h" 3
static __inline__ __attribute__((always_inline)) double jn(int n, double a)
{
  double jip1 = 0.0;
  double ji = 1.0;
  double jim1;
  double lambda = 0.0;
  double sum = 0.0;
  int i;
  if(n == 0) {
    return y0(a);
  }
  if(n == 1) {
    return y1(a);
  }
  if(n < 0) {
    return __longlong_as_double(0xfff8000000000000ULL);
  }
  if(fabs(a) > (double)n - 1.0) {

    double two_over_a = 2.0 / a;
    double ji = j1(a);
    double jim1 = j0(a);
    for(i = 1; i < n; i++) {
      jip1 = __fma_rn(i * two_over_a, ji, -jim1);
      jim1 = ji;
      ji = jip1;
    }
    return jip1;
  } else {



    double two_over_a = 2.0 / a;
    int m = n + (int)sqrt(n * 60);
    m = (m >> 1) << 1;
    for(i = m; i >= 1; --i) {

      jim1 = __fma_rn(i * two_over_a, ji, -jip1);
      jip1 = ji;

      if(fabsf(jim1) > 1e15) {
        jim1 *= 1e-15;
        jip1 *= 1e-15;
        lambda *= 1e-15;
        sum *= 1e-15;
      }
      ji = jim1;
      if(i - 1 == n) {
        lambda = ji;
      }
      if(i & 1) {
        sum += 2.0 * ji;
      }
    }
    sum -= ji;
    return lambda / sum;
  }
}


static __inline__ __attribute__((always_inline)) double erf(double a)
{
  double t, r, q;

  t = fabs(a);
  if (t >= 1.0) {
    r = -1.28836351230756500E-019;
    r = __fma_rn (r, t, 1.30597472161093370E-017);
    r = __fma_rn (r, t, -6.33924401259620500E-016);
    r = __fma_rn (r, t, 1.96231865908940140E-014);
    r = __fma_rn (r, t, -4.35272243559990750E-013);
    r = __fma_rn (r, t, 7.37083927929352150E-012);
    r = __fma_rn (r, t, -9.91402142550461630E-011);
    r = __fma_rn (r, t, 1.08817017167760820E-009);
    r = __fma_rn (r, t, -9.93918713097634620E-009);
    r = __fma_rn (r, t, 7.66739923255145500E-008);
    r = __fma_rn (r, t, -5.05440278302806720E-007);
    r = __fma_rn (r, t, 2.87474157099000620E-006);
    r = __fma_rn (r, t, -1.42246725399722510E-005);
    r = __fma_rn (r, t, 6.16994555079419460E-005);
    r = __fma_rn (r, t, -2.36305221938908790E-004);
    r = __fma_rn (r, t, 8.05032844055371070E-004);
    r = __fma_rn (r, t, -2.45833366629108140E-003);
    r = __fma_rn (r, t, 6.78340988296706120E-003);
    r = __fma_rn (r, t, -1.70509103597554640E-002);
    r = __fma_rn (r, t, 3.93322852515666300E-002);
    r = __fma_rn (r, t, -8.37271292613764040E-002);
    r = __fma_rn (r, t, 1.64870423707623280E-001);
    r = __fma_rn (r, t, -2.99729521787681470E-001);
    r = __fma_rn (r, t, 4.99394435612628580E-001);
    r = __fma_rn (r, t, -7.52014596480123030E-001);
    r = __fma_rn (r, t, 9.99933138314926250E-001);
    r = __fma_rn (r, t, -1.12836725321102670E+000);
    r = __fma_rn (r, t, 9.99998988715182450E-001);
    q = __internal_exp_kernel(-t * t, 0);
    r = __fma_rn (r, -q, 1.0);
    if (t >= 6.5) {
      r = 1.0;
    }
    a = __internal_copysign_pos(r, a);
  } else {
    q = a * a;
    r = -7.77946848895991420E-010;
    r = __fma_rn (r, q, 1.37109803980285950E-008);
    r = __fma_rn (r, q, -1.62063137584932240E-007);
    r = __fma_rn (r, q, 1.64471315712790040E-006);
    r = __fma_rn (r, q, -1.49247123020098620E-005);
    r = __fma_rn (r, q, 1.20552935769006260E-004);
    r = __fma_rn (r, q, -8.54832592931448980E-004);
    r = __fma_rn (r, q, 5.22397760611847340E-003);
    r = __fma_rn (r, q, -2.68661706431114690E-002);
    r = __fma_rn (r, q, 1.12837916709441850E-001);
    r = __fma_rn (r, q, -3.76126389031835210E-001);
    r = __fma_rn (r, q, 1.12837916709551260E+000);
    a = r * a;
  }
  return a;
}






static __inline__ __attribute__((always_inline)) double erfinv(double a)
{
  if (fabs(a) < 1.0) {
    double t, r;
    t = __fma_rn (a, -a, 1.0);
    t = - __internal_fast_log (t);
    if (t < 6.25) {
      t = t - 3.125;
      r = -3.6444120640178197e-21;
      r = __fma_rn (r, t, -1.6850591381820166e-19);
      r = __fma_rn (r, t, 1.2858480715256400e-18);
      r = __fma_rn (r, t, 1.1157877678025181e-17);
      r = __fma_rn (r, t, -1.3331716628546209e-16);
      r = __fma_rn (r, t, 2.0972767875968562e-17);
      r = __fma_rn (r, t, 6.6376381343583238e-15);
      r = __fma_rn (r, t, -4.0545662729752069e-14);
      r = __fma_rn (r, t, -8.1519341976054722e-14);
      r = __fma_rn (r, t, 2.6335093153082323e-12);
      r = __fma_rn (r, t, -1.2975133253453532e-11);
      r = __fma_rn (r, t, -5.4154120542946279e-11);
      r = __fma_rn (r, t, 1.0512122733215323e-09);
      r = __fma_rn (r, t, -4.1126339803469837e-09);
      r = __fma_rn (r, t, -2.9070369957882005e-08);
      r = __fma_rn (r, t, 4.2347877827932404e-07);
      r = __fma_rn (r, t, -1.3654692000834679e-06);
      r = __fma_rn (r, t, -1.3882523362786469e-05);
      r = __fma_rn (r, t, 1.8673420803405714e-04);
      r = __fma_rn (r, t, -7.4070253416626698e-04);
      r = __fma_rn (r, t, -6.0336708714301491e-03);
      r = __fma_rn (r, t, 2.4015818242558962e-01);
      r = __fma_rn (r, t, 1.6536545626831027e+00);
    } else {
      t = sqrt(t);
      if (t < 4.0) {
        t = t - 3.25;
        r = 2.2137376921775787e-09;
        r = __fma_rn (r, t, 9.0756561938885391e-08);
        r = __fma_rn (r, t, -2.7517406297064545e-07);
        r = __fma_rn (r, t, 1.8239629214389228e-08);
        r = __fma_rn (r, t, 1.5027403968909828e-06);
        r = __fma_rn (r, t, -4.0138675269815460e-06);
        r = __fma_rn (r, t, 2.9234449089955446e-06);
        r = __fma_rn (r, t, 1.2475304481671779e-05);
        r = __fma_rn (r, t, -4.7318229009055734e-05);
        r = __fma_rn (r, t, 6.8284851459573175e-05);
        r = __fma_rn (r, t, 2.4031110387097894e-05);
        r = __fma_rn (r, t, -3.5503752036284748e-04);
        r = __fma_rn (r, t, 9.5328937973738050e-04);
        r = __fma_rn (r, t, -1.6882755560235047e-03);
        r = __fma_rn (r, t, 2.4914420961078508e-03);
        r = __fma_rn (r, t, -3.7512085075692412e-03);
        r = __fma_rn (r, t, 5.3709145535900636e-03);
        r = __fma_rn (r, t, 1.0052589676941592e+00);
        r = __fma_rn (r, t, 3.0838856104922208e+00);
      } else {
        t = t - 5.0;
        r = -2.7109920616438573e-11;
        r = __fma_rn (r, t, -2.5556418169965252e-10);
        r = __fma_rn (r, t, 1.5076572693500548e-09);
        r = __fma_rn (r, t, -3.7894654401267370e-09);
        r = __fma_rn (r, t, 7.6157012080783394e-09);
        r = __fma_rn (r, t, -1.4960026627149240e-08);
        r = __fma_rn (r, t, 2.9147953450901081e-08);
        r = __fma_rn (r, t, -6.7711997758452339e-08);
        r = __fma_rn (r, t, 2.2900482228026655e-07);
        r = __fma_rn (r, t, -9.9298272942317003e-07);
        r = __fma_rn (r, t, 4.5260625972231537e-06);
        r = __fma_rn (r, t, -1.9681778105531671e-05);
        r = __fma_rn (r, t, 7.5995277030017761e-05);
        r = __fma_rn (r, t, -2.1503011930044477e-04);
        r = __fma_rn (r, t, -1.3871931833623122e-04);
        r = __fma_rn (r, t, 1.0103004648645344e+00);
        r = __fma_rn (r, t, 4.8499064014085844e+00);
      }
    }
    return r * a;
  } else {
    if (__isnand(a)) {
      return a + a;
    }
    if (fabs(a) == 1.0) {
      return a * __longlong_as_double(0x7ff0000000000000ULL);
    }
    return __longlong_as_double(0xfff8000000000000ULL);
  }
}

static __inline__ __attribute__((always_inline)) double erfcinv(double a)
{
  double t;
  if (a <= 0.0) {
    t = __longlong_as_double(0xfff8000000000000ULL);
    if (a == 0.0) {
      t = (1.0 - a) * __longlong_as_double(0x7ff0000000000000ULL);
    }
  }
  else if (a >= 0.0625) {
    t = erfinv (1.0 - a);
  }
  else if (a >= 1e-100) {




    double p, q;
    t = __internal_fast_log (a);
    t = __internal_fast_rsqrt (-t);
    p = 2.7834010353747001060e-3;
    p = __fma_rn (p, t, 8.6030097526280260580e-1);
    p = __fma_rn (p, t, 2.1371214997265515515e+0);
    p = __fma_rn (p, t, 3.1598519601132090206e+0);
    p = __fma_rn (p, t, 3.5780402569085996758e+0);
    p = __fma_rn (p, t, 1.5335297523989890804e+0);
    p = __fma_rn (p, t, 3.4839207139657522572e-1);
    p = __fma_rn (p, t, 5.3644861147153648366e-2);
    p = __fma_rn (p, t, 4.3836709877126095665e-3);
    p = __fma_rn (p, t, 1.3858518113496718808e-4);
    p = __fma_rn (p, t, 1.1738352509991666680e-6);
    q = t+ 2.2859981272422905412e+0;
    q = __fma_rn (q, t, 4.3859045256449554654e+0);
    q = __fma_rn (q, t, 4.6632960348736635331e+0);
    q = __fma_rn (q, t, 3.9846608184671757296e+0);
    q = __fma_rn (q, t, 1.6068377709719017609e+0);
    q = __fma_rn (q, t, 3.5609087305900265560e-1);
    q = __fma_rn (q, t, 5.3963550303200816744e-2);
    q = __fma_rn (q, t, 4.3873424022706935023e-3);
    q = __fma_rn (q, t, 1.3858762165532246059e-4);
    q = __fma_rn (q, t, 1.1738313872397777529e-6);
    t = p / (q * t);
  }
  else {




    double p, q;
    t = log (a);
    t = rsqrt (-t);
    p = 6.9952990607058154858e-1;
    p = __fma_rn (p, t, 1.9507620287580568829e+0);
    p = __fma_rn (p, t, 8.2810030904462690216e-1);
    p = __fma_rn (p, t, 1.1279046353630280005e-1);
    p = __fma_rn (p, t, 6.0537914739162189689e-3);
    p = __fma_rn (p, t, 1.3714329569665128933e-4);
    p = __fma_rn (p, t, 1.2964481560643197452e-6);
    p = __fma_rn (p, t, 4.6156006321345332510e-9);
    p = __fma_rn (p, t, 4.5344689563209398450e-12);
    q = t+ 1.5771922386662040546e+0;
    q = __fma_rn (q, t, 2.1238242087454993542e+0);
    q = __fma_rn (q, t, 8.4001814918178042919e-1);
    q = __fma_rn (q, t, 1.1311889334355782065e-1);
    q = __fma_rn (q, t, 6.0574830550097140404e-3);
    q = __fma_rn (q, t, 1.3715891988350205065e-4);
    q = __fma_rn (q, t, 1.2964671850944981713e-6);
    q = __fma_rn (q, t, 4.6156017600933592558e-9);
    q = __fma_rn (q, t, 4.5344687377088206783e-12);
    t = p / (q * t);
  }
  return t;
}

static __inline__ __attribute__((always_inline)) double __internal_erfcx_kernel (double a)
{
# 2339 "/usr/local/cuda/bin/../include/math_functions_dbl_ptx3.h" 3
  double t1, t2, t3, t4;


  t1 = a - 4.0;
  t2 = a + 4.0;
  t2 = __internal_fast_rcp(t2);
  t3 = t1 * t2;
  t4 = __dadd_rn (t3, 1.0);
  t1 = __fma_rn (-4.0, t4, a);
  t1 = __fma_rn (-t3, a, t1);
  t2 = __fma_rn (t2, t1, t3);

  t1 = -3.5602694826817400E-010;
  t1 = __fma_rn (t1, t2, -9.7239122591447274E-009);
  t1 = __fma_rn (t1, t2, -8.9350224851649119E-009);
  t1 = __fma_rn (t1, t2, 1.0404430921625484E-007);
  t1 = __fma_rn (t1, t2, 5.8806698585341259E-008);
  t1 = __fma_rn (t1, t2, -8.2147414929116908E-007);
  t1 = __fma_rn (t1, t2, 3.0956409853306241E-007);
  t1 = __fma_rn (t1, t2, 5.7087871844325649E-006);
  t1 = __fma_rn (t1, t2, -1.1231787437600085E-005);
  t1 = __fma_rn (t1, t2, -2.4399558857200190E-005);
  t1 = __fma_rn (t1, t2, 1.5062557169571788E-004);
  t1 = __fma_rn (t1, t2, -1.9925637684786154E-004);
  t1 = __fma_rn (t1, t2, -7.5777429182785833E-004);
  t1 = __fma_rn (t1, t2, 5.0319698792599572E-003);
  t1 = __fma_rn (t1, t2, -1.6197733895953217E-002);
  t1 = __fma_rn (t1, t2, 3.7167515553018733E-002);
  t1 = __fma_rn (t1, t2, -6.6330365827532434E-002);
  t1 = __fma_rn (t1, t2, 9.3732834997115544E-002);
  t1 = __fma_rn (t1, t2, -1.0103906603555676E-001);
  t1 = __fma_rn (t1, t2, 6.8097054254735140E-002);
  t1 = __fma_rn (t1, t2, 1.5379652102605428E-002);
  t1 = __fma_rn (t1, t2, -1.3962111684056291E-001);
  t1 = __fma_rn (t1, t2, 1.2329951186255526E+000);

  t2 = __fma_rn (2.0, a, 1.0);
  t2 = __internal_fast_rcp(t2);
  t3 = t1 * t2;
  t4 = __fma_rn (a, -2.0*t3, t1);
  t4 = __dadd_rn (t4, -t3);
  t1 = __fma_rn (t4, t2, t3);
  return t1;
}

static __inline__ __attribute__((always_inline)) double erfc(double a)
{
  double x, t1, t2, t3;

  if (__isnand(a)) return a + a;
  x = fabs(a);
  t1 = __internal_erfcx_kernel (x);

  t2 = -x * x;
  t3 = __internal_exp_kernel (t2, 0);
  t2 = __fma_rn (-x, x, -t2);
  t2 = __fma_rn (t3, t2, t3);
  t1 = t1 * t2;
  if (x > 27.3) t1 = 0.0;
  return (__double2hiint(a) < 0) ? (2.0 - t1) : t1;
}

static __inline__ __attribute__((always_inline)) double erfcx(double a)
{
  double x, t1, t2, t3;
  x = fabs(a);
  if ((unsigned)__double2hiint(x) < (unsigned)0x40400000) {
    t1 = __internal_erfcx_kernel(x);
  } else {

    t2 = 1.0 / x;
    t3 = t2 * t2;
    t1 = -29.53125;
    t1 = __fma_rn (t1, t3, +6.5625);
    t1 = __fma_rn (t1, t3, -1.875);
    t1 = __fma_rn (t1, t3, +0.75);
    t1 = __fma_rn (t1, t3, -0.5);
    t1 = __fma_rn (t1, t3, +1.0);
    t2 = t2 * 5.6418958354775628e-001;
    t1 = t1 * t2;
  }
  if (__double2hiint(a) < 0) {

    t2 = x * x;
    t3 = __fma_rn (x, x, -t2);
    t2 = exp (t2);
    t2 = t2 + t2;
    t3 = __fma_rn (t2, t3, t2);
    t1 = t3 - t1;
    if (t2 == __longlong_as_double(0x7ff0000000000000ULL)) t1 = t2;
  }
  return t1;
}


static __inline__ __attribute__((always_inline)) double __internal_tgamma_kernel(double a)
{
  double t;
  t = -4.42689340712524750E-010;
  t = __fma_rn (t, a, -2.02665918466589540E-007);
  t = __fma_rn (t, a, 1.13812117211195270E-006);
  t = __fma_rn (t, a, -1.25077348166307480E-006);
  t = __fma_rn (t, a, -2.01365017404087710E-005);
  t = __fma_rn (t, a, 1.28050126073544860E-004);
  t = __fma_rn (t, a, -2.15241408115274180E-004);
  t = __fma_rn (t, a, -1.16516754597046040E-003);
  t = __fma_rn (t, a, 7.21894322484663810E-003);
  t = __fma_rn (t, a, -9.62197153268626320E-003);
  t = __fma_rn (t, a, -4.21977345547223940E-002);
  t = __fma_rn (t, a, 1.66538611382503560E-001);
  t = __fma_rn (t, a, -4.20026350341054440E-002);
  t = __fma_rn (t, a, -6.55878071520257120E-001);
  t = __fma_rn (t, a, 5.77215664901532870E-001);
  t = __fma_rn (t, a, 1.00000000000000000E+000);
  return t;
}


static __inline__ __attribute__((always_inline)) double __internal_stirling_poly(double a)
{
  double x = __internal_fast_rcp(a);
  double z = 0.0;
  z = __fma_rn (z, x, 8.3949872067208726e-004);
  z = __fma_rn (z, x, -5.1717909082605919e-005);
  z = __fma_rn (z, x, -5.9216643735369393e-004);
  z = __fma_rn (z, x, 6.9728137583658571e-005);
  z = __fma_rn (z, x, 7.8403922172006662e-004);
  z = __fma_rn (z, x, -2.2947209362139917e-004);
  z = __fma_rn (z, x, -2.6813271604938273e-003);
  z = __fma_rn (z, x, 3.4722222222222220e-003);
  z = __fma_rn (z, x, 8.3333333333333329e-002);
  z = __fma_rn (z, x, 1.0000000000000000e+000);
  return z;
}

static __inline__ __attribute__((always_inline)) double __internal_tgamma_stirling(double a)
{
  if (a < 1.7162437695630274e+002) {
    double t_hi, t_lo, e;

    double2 loga, prod;
    double z = __internal_stirling_poly (a);
    double b = a - 0.5;


    loga = __internal_log_ext_prec(a);


    t_hi = __dmul_rn (loga.y, b);
    t_lo = __fma_rn (loga.y, b, -t_hi);
    t_lo = __fma_rn (loga.x, b, t_lo);
    prod.y = e = t_hi + t_lo;
    prod.x = (t_hi - e) + t_lo;


    loga.y = -a;
    loga.x = 0.0;
    prod = __internal_ddadd_xgty (prod, loga);


    a = exp(prod.y);

    if (!__isinfd(a)) {



      a = __fma_rn (a, prod.x, a);
    }
    a = __fma_rn (a, 2.5066282746310007e+0, a * (-1.8328579980459167e-16));
    return a * z;
  } else {
    return __longlong_as_double(0x7ff0000000000000ULL);
  }
}

static __inline__ __attribute__((always_inline)) double tgamma(double a)
{
  double s, xx, x = a;
  if (__isnand(a)) {
    return a + a;
  }
  if (fabs(x) < 15.0) {




    if (x >= 0.0) {
      s = 1.0;
      xx = x;
      while (xx > 1.5) {
        s = __fma_rn(s, xx, -s);
        xx = xx - 1.0;
      }
      if (x >= 0.5) {
        xx = xx - 1.0;
      }
      xx = __internal_tgamma_kernel (xx);
      if (x < 0.5) {
        xx = xx * x;
      }
      s = s / xx;
    } else {
      xx = x;
      s = xx;
      if (x == trunc(x)) {
        return __longlong_as_double(0xfff8000000000000ULL);
      }
      while (xx < -0.5) {
        s = __fma_rn (s, xx, s);
        xx = xx + 1.0;
      }
      xx = __internal_tgamma_kernel (xx);
      s = s * xx;
      s = 1.0 / s;
    }
    return s;
  } else {
    if (x >= 0.0) {
      return __internal_tgamma_stirling (x);
    } else {
      double t;
      int quot;
      if (x == trunc(x)) {
        return __longlong_as_double(0xfff8000000000000ULL);
      }
      if (x < -185.0) {
        int negative;
        x = floor(x);
        negative = ((x - (2.0 * floor(0.5 * x))) == 1.0);
        return negative ? __longlong_as_double(0x8000000000000000ULL) : 0.0;
      }

      xx = rint (__internal_twice(x));
      quot = (int)xx;
      xx = __fma_rn (-0.5, xx, x);
      xx = xx * 3.1415926535897931e+0;
      if (quot & 1) {
        xx = __internal_cos_kerneld (xx);
      } else {
        xx = __internal_sin_kerneld (xx);
      }
      if (quot & 2) {
        xx = -xx;
      }
      s = __internal_exp_kernel (x, 0);
      x = fabs (x);
      t = x - 0.5;
      if (x > 140.0) t = __internal_half(t);
      t = __internal_accurate_pow (x, t);
      if (x > 140.0) s = s * t;
      s = s * __internal_stirling_poly (x);
      s = s * x;
      s = s * xx;
      s = 1.0 / s;
      s = __fma_rn (s, 1.2533141373155003e+0, (-9.1642899902295834e-17) * s);
      s = s / t;
      return s;
    }
  }
}

static __inline__ __attribute__((always_inline)) double __internal_lgamma_pos(double a)
{
  double sum;
  double s, t;

  if (a == __longlong_as_double(0x7ff0000000000000ULL)) {
    return a;
  }
  if (a >= 3.0) {
    if (a >= 8.0) {



      s = __internal_fast_rcp(a);
      t = s * s;
      sum = -0.1633436431e-2;
      sum = __fma_rn (sum, t, 0.83645878922e-3);
      sum = __fma_rn (sum, t, -0.5951896861197e-3);
      sum = __fma_rn (sum, t, 0.793650576493454e-3);
      sum = __fma_rn (sum, t, -0.277777777735865004e-2);
      sum = __fma_rn (sum, t, 0.833333333333331018375e-1);
      sum = __fma_rn (sum, s, 0.918938533204672);
      s = __internal_half(log (a));
      t = a - 0.5;
      sum = __fma_rn(s, t, sum);
      t = __fma_rn (s, t, - a);
      t = t + sum;
      return t;
    } else {
      a = a - 3.0;
      s = -4.02412642744125560E+003;
      s = __fma_rn (s, a, -2.97693796998962000E+005);
      s = __fma_rn (s, a, -6.38367087682528790E+006);
      s = __fma_rn (s, a, -5.57807214576539320E+007);
      s = __fma_rn (s, a, -2.24585140671479230E+008);
      s = __fma_rn (s, a, -4.70690608529125090E+008);
      s = __fma_rn (s, a, -7.62587065363263010E+008);
      s = __fma_rn (s, a, -9.71405112477113250E+008);
      t = a -1.02277248359873170E+003;
      t = __fma_rn (t, a, -1.34815350617954480E+005);
      t = __fma_rn (t, a, -4.64321188814343610E+006);
      t = __fma_rn (t, a, -6.48011106025542540E+007);
      t = __fma_rn (t, a, -4.19763847787431360E+008);
      t = __fma_rn (t, a, -1.25629926018000720E+009);
      t = __fma_rn (t, a, -1.40144133846491690E+009);
      t = s / t;
      t = t + a;
      return t;
    }
  } else if (a >= 1.5) {
    a = a - 2.0;
    t = 9.84839283076310610E-009;
    t = __fma_rn (t, a, -6.69743850483466500E-008);
    t = __fma_rn (t, a, 2.16565148880011450E-007);
    t = __fma_rn (t, a, -4.86170275781575260E-007);
    t = __fma_rn (t, a, 9.77962097401114400E-007);
    t = __fma_rn (t, a, -2.03041287574791810E-006);
    t = __fma_rn (t, a, 4.36119725805364580E-006);
    t = __fma_rn (t, a, -9.43829310866446590E-006);
    t = __fma_rn (t, a, 2.05106878496644220E-005);
    t = __fma_rn (t, a, -4.49271383742108440E-005);
    t = __fma_rn (t, a, 9.94570466342226000E-005);
    t = __fma_rn (t, a, -2.23154589559238440E-004);
    t = __fma_rn (t, a, 5.09669559149637430E-004);
    t = __fma_rn (t, a, -1.19275392649162300E-003);
    t = __fma_rn (t, a, 2.89051032936815490E-003);
    t = __fma_rn (t, a, -7.38555102806811700E-003);
    t = __fma_rn (t, a, 2.05808084278121250E-002);
    t = __fma_rn (t, a, -6.73523010532073720E-002);
    t = __fma_rn (t, a, 3.22467033424113040E-001);
    t = __fma_rn (t, a, 4.22784335098467190E-001);
    t = t * a;
    return t;
  } else if (a >= 0.7) {
    a = 1.0 - a;
    t = 1.17786911519331130E-002;
    t = __fma_rn (t, a, 3.89046747413522300E-002);
    t = __fma_rn (t, a, 5.90045711362049900E-002);
    t = __fma_rn (t, a, 6.02143305254344420E-002);
    t = __fma_rn (t, a, 5.61652708964839180E-002);
    t = __fma_rn (t, a, 5.75052755193461370E-002);
    t = __fma_rn (t, a, 6.21061973447320710E-002);
    t = __fma_rn (t, a, 6.67614724532521880E-002);
    t = __fma_rn (t, a, 7.14856037245421020E-002);
    t = __fma_rn (t, a, 7.69311251313347100E-002);
    t = __fma_rn (t, a, 8.33503129714946310E-002);
    t = __fma_rn (t, a, 9.09538288991182800E-002);
    t = __fma_rn (t, a, 1.00099591546322310E-001);
    t = __fma_rn (t, a, 1.11334278141734510E-001);
    t = __fma_rn (t, a, 1.25509666613462880E-001);
    t = __fma_rn (t, a, 1.44049896457704160E-001);
    t = __fma_rn (t, a, 1.69557177031481600E-001);
    t = __fma_rn (t, a, 2.07385551032182120E-001);
    t = __fma_rn (t, a, 2.70580808427600350E-001);
    t = __fma_rn (t, a, 4.00685634386517050E-001);
    t = __fma_rn (t, a, 8.22467033424113540E-001);
    t = __fma_rn (t, a, 5.77215664901532870E-001);
    t = t * a;
    return t;
  } else {
    t= -9.04051686831357990E-008;
    t = __fma_rn (t, a, 7.06814224969349250E-007);
    t = __fma_rn (t, a, -3.80702154637902830E-007);
    t = __fma_rn (t, a, -2.12880892189316100E-005);
    t = __fma_rn (t, a, 1.29108470307156190E-004);
    t = __fma_rn (t, a, -2.15932815215386580E-004);
    t = __fma_rn (t, a, -1.16484324388538480E-003);
    t = __fma_rn (t, a, 7.21883433044470670E-003);
    t = __fma_rn (t, a, -9.62194579514229560E-003);
    t = __fma_rn (t, a, -4.21977386992884450E-002);
    t = __fma_rn (t, a, 1.66538611813682460E-001);
    t = __fma_rn (t, a, -4.20026350606819980E-002);
    t = __fma_rn (t, a, -6.55878071519427450E-001);
    t = __fma_rn (t, a, 5.77215664901523870E-001);
    t = t * a;
    t = __fma_rn (t, a, a);
    return -log (t);
  }
}

static __inline__ __attribute__((always_inline)) double lgamma(double a)
{
  double t;
  double i;
  long long int quot;
  if (__isnand(a)) {
    return a + a;
  }
  t = __internal_lgamma_pos(fabs(a));
  if (a >= 0.0) return t;
  a = fabs(a);
  i = trunc(a);
  if (a == i) return __longlong_as_double(0x7ff0000000000000ULL);
  if (a < 1e-19) return -log(a);
  i = rint (2.0 * a);
  quot = (long long int)i;
  i = __fma_rn (-0.5, i, a);
  i = i * 3.1415926535897931e+0;
  if (quot & 1) {
    i = __internal_cos_kerneld(i);
  } else {
    i = __internal_sin_kerneld(i);
  }
  i = fabs(i);
  t = log(3.1415926535897931e+0 / (i * a)) - t;
  return t;
}

static __inline__ __attribute__((always_inline)) double ldexp(double a, int b)
{
  double fa = fabs (a);
  if ((fa == 0.0) || (fa == __longlong_as_double(0x7ff0000000000000ULL)) || (!(fa <= __longlong_as_double(0x7ff0000000000000ULL)))) {
    return a + a;
  }
  if (b == 0) {
    return a;
  }
  if (b > 2200) b = 2200;
  if (b < -2200) b = -2200;
  if (abs (b) < 1022) {
    return a * __internal_exp2i_kernel(b);
  }
  if (abs (b) < 2044) {
    int bhalf = b / 2;
    return a * __internal_exp2i_kernel (bhalf) *
           __internal_exp2i_kernel (b - bhalf);
  } else {
    int bquarter = b / 4;
    double t = __internal_exp2i_kernel(bquarter);
    return a * t * t * t *__internal_exp2i_kernel (b - 3 * bquarter);
  }
}

static __inline__ __attribute__((always_inline)) double scalbn(double a, int b)
{

  return ldexp(a, b);
}

static __inline__ __attribute__((always_inline)) double scalbln(double a, long int b)
{


  if (b < -2147483648L) b = -2147483648L;
  if (b > 2147483647L) b = 2147483647L;

  return scalbn(a, (int)b);
}

static __inline__ __attribute__((always_inline)) double frexp(double a, int *b)
{
  double fa = fabs(a);
  unsigned int expo;
  unsigned int denorm;

  if (fa < 2.22507385850720140e-308) {
    a *= 18014398509481984.0;
    denorm = 54;
  } else {
    denorm = 0;
  }
  expo = (__double2hiint(a) >> 20) & 0x7ff;
  if ((fa == 0.0) || (expo == 0x7ff)) {
    expo = 0;
    a = a + a;
  } else {
    expo = expo - denorm - 1022;
    a = __longlong_as_double((__double_as_longlong(a) & 0x800fffffffffffffULL)|
                              0x3fe0000000000000ULL);
  }
  *b = expo;
  return a;
}

static __inline__ __attribute__((always_inline)) double modf(double a, double *b)
{
  double t;
  if (__isfinited(a)) {
    t = trunc(a);
    *b = t;
    t = a - t;
    return __internal_copysign_pos(t, a);
  } else if (__isinfd(a)) {
    t = 0.0;
    *b = a;
    return __internal_copysign_pos(t, a);
  } else {
    *b = a + a;
    return a + a;
  }
}

static __inline__ __attribute__((always_inline)) double fmod(double a, double b)
{
  double orig_a = a;
  double orig_b = b;
  a = fabs(a);
  b = fabs(b);
  if (!((a <= __longlong_as_double(0x7ff0000000000000ULL)) && (b <= __longlong_as_double(0x7ff0000000000000ULL)))) {
      return orig_a + orig_b;
  }
  if (a == __longlong_as_double(0x7ff0000000000000ULL) || b == 0.0) {
    return __longlong_as_double(0xfff8000000000000ULL);
  } else if (a >= b) {
    int bhi = __double2hiint(b);
    int blo = __double2loint(b);
    int ahi = __double2hiint(a);
    double scaled_b = 0.0;
    if (b < 2.22507385850720140e-308) {
      double t = b;
      while ((t < a) && (t < 2.22507385850720140e-308)) {
        t = t + t;
      }
      bhi = __double2hiint(t);
      blo = __double2loint(t);
      scaled_b = t;
    }
    if (a >= 2.22507385850720140e-308) {
      scaled_b = __hiloint2double ((bhi & 0x000fffff)|(ahi & 0x7ff00000), blo);
    }
    if (scaled_b > a) {
      scaled_b *= 0.5;
    }
    while (scaled_b >= b) {
      if (a >= scaled_b) {
        a -= scaled_b;
      }
      scaled_b *= 0.5;
    }
    return __internal_copysign_pos(a, orig_a);
  } else {
    return orig_a;
  }
}

static __inline__ __attribute__((always_inline)) double remainder(double a, double b)
{
  double orig_a;
  double twoa = 0.0;
  unsigned int quot0 = 0;
  int bhi;
  int blo;
  int ahi;
  if (__isnand(a) || __isnand(b)) {
    return a + b;
  }
  orig_a = a;
  a = fabs(a);
  b = fabs(b);
  if (a == __longlong_as_double(0x7ff0000000000000ULL) || b == 0.0) {
    return __longlong_as_double(0xfff8000000000000ULL);
  } else if (a >= b) {
    double scaled_b = 0.0;
    bhi = __double2hiint(b);
    blo = __double2loint(b);
    ahi = __double2hiint(a);
    if (b < 2.22507385850720140e-308) {
      double t = b;
      while ((t < a) && (t < 2.22507385850720140e-308)) {
        t = t + t;
      }
      bhi = __double2hiint(t);
      blo = __double2loint(t);
      scaled_b = t;
    }
    if (a >= 2.22507385850720140e-308) {
      scaled_b = __hiloint2double ((bhi & 0x000fffff)|(ahi & 0x7ff00000), blo);
    }
    if (scaled_b > a) {
      scaled_b *= 0.5;
    }
    while (scaled_b >= b) {
      quot0 = 0;
      if (a >= scaled_b) {
        a -= scaled_b;
        quot0 = 1;
      }
      scaled_b *= 0.5;
    }
  }

  twoa = a + a;
  if ((twoa > b) || ((twoa == b) && quot0)) {
    a -= b;
  }
  bhi = __double2hiint(a);
  blo = __double2loint(a);
  ahi = __double2hiint(orig_a);
  a = __hiloint2double((ahi & 0x80000000) ^ bhi, blo);
  return a;
}

static __inline__ __attribute__((always_inline)) double remquo(double a, double b, int *c)
{
  double orig_a;
  double twoa = 0.0;
  unsigned int quot = 0;
  unsigned int sign;
  int bhi;
  int blo;
  int ahi;
  if (__isnand(a) || __isnand(b)) {
    *c = quot;
    return a + b;
  }
  orig_a = a;
  sign = 0 - ((__double2hiint(a) ^ __double2hiint(b)) < 0);
  a = fabs(a);
  b = fabs(b);
  if (a == __longlong_as_double(0x7ff0000000000000ULL) || b == 0.0) {
    *c = quot;
    return __longlong_as_double(0xfff8000000000000ULL);
  } else if (a >= b) {
    double scaled_b = 0.0;
    bhi = __double2hiint(b);
    blo = __double2loint(b);
    ahi = __double2hiint(a);
    if (b < 2.22507385850720140e-308) {
      double t = b;
      while ((t < a) && (t < 2.22507385850720140e-308)) {
        t = t + t;
      }
      bhi = __double2hiint(t);
      blo = __double2loint(t);
      scaled_b = t;
    }
    if (a >= 2.22507385850720140e-308) {
      scaled_b = __hiloint2double ((bhi & 0x000fffff)|(ahi & 0x7ff00000), blo);
    }
    if (scaled_b > a) {
      scaled_b *= 0.5;
    }
    while (scaled_b >= b) {
      quot <<= 1;
      if (a >= scaled_b) {
        a -= scaled_b;
        quot += 1;
      }
      scaled_b *= 0.5;
    }
  }

  twoa = a + a;
  if ((twoa > b) || ((twoa == b) && (quot & 1))) {
    quot++;
    a -= b;
  }
  bhi = __double2hiint(a);
  blo = __double2loint(a);
  ahi = __double2hiint(orig_a);
  a = __hiloint2double((ahi & 0x80000000) ^ bhi, blo);
  quot = quot & (~((~0)<<3));
  quot = quot ^ sign;
  quot = quot - sign;
  *c = quot;
  return a;
}

static __inline__ __attribute__((always_inline)) double nextafter(double a, double b)
{
  unsigned long long int ia;
  unsigned long long int ib;
  ia = __double_as_longlong(a);
  ib = __double_as_longlong(b);
  if (__isnand(a) || __isnand(b)) return a + b;
  if (((ia | ib) << 1) == 0ULL) return b;
  if ((ia + ia) == 0ULL) {
    return __internal_copysign_pos(__longlong_as_double(0x0000000000000001ULL), b);
  }
  if ((a < b) && (a < 0.0)) ia--;
  if ((a < b) && (a > 0.0)) ia++;
  if ((a > b) && (a < 0.0)) ia++;
  if ((a > b) && (a > 0.0)) ia--;
  a = __longlong_as_double(ia);
  return a;
}

static __inline__ __attribute__((always_inline)) double nan(const char *tagp)
{
  unsigned long long int i;

  i = __internal_nan_kernel (tagp);
  i = (i & 0x000fffffffffffffULL) | 0x7ff8000000000000ULL;
  return __longlong_as_double(i);
}

static __inline__ __attribute__((always_inline)) double round(double a)
{
  double fa = fabs(a);
  if (fa >= 4503599627370496.0) {
    return a;
  } else {
    double u;
    u = trunc(fa + 0.5);
    if (fa < 0.5) u = 0;
    u = __internal_copysign_pos(u, a);
    return u;
  }
}

static __inline__ __attribute__((always_inline)) long long int llround(double a)
{
  return (long long int)round(a);
}

static __inline__ __attribute__((always_inline)) long int lround(double a)
{

  return (long int)llround(a);



}

static __inline__ __attribute__((always_inline)) double fdim(double a, double b)
{
  double t;
  t = a - b;
  if (a <= b) {
    t = 0.0;
  }
  return t;
}

static __inline__ __attribute__((always_inline)) int ilogb(double a)
{
  unsigned long long int i;
  unsigned int ihi;
  unsigned int ilo;
  if (__isnand(a)) return -((int)((unsigned int)-1 >> 1))-1;
  if (__isinfd(a)) return ((int)((unsigned int)-1 >> 1));
  if (a == 0.0) return -((int)((unsigned int)-1 >> 1))-1;
  a = fabs(a);
  ilo = __double2loint(a);
  ihi = __double2hiint(a);
  i = ((unsigned long long int)ihi) << 32 | (unsigned long long int)ilo;
  if (a >= 2.22507385850720140e-308) {
    return ((int)((ihi >> 20) & 0x7ff)) - 1023;
  } else {
    return -1011 - __clzll(i);
  }
}

static __inline__ __attribute__((always_inline)) double logb(double a)
{
  unsigned long long int i;
  unsigned int ihi;
  unsigned int ilo;
  if (__isnand(a)) return a + a;
  a = fabs(a);
  if (a == __longlong_as_double(0x7ff0000000000000ULL)) return a;
  if (a == 0.0) return -__longlong_as_double(0x7ff0000000000000ULL);
  ilo = __double2loint(a);
  ihi = __double2hiint(a);
  i = ((unsigned long long int)ihi) << 32 | (unsigned long long int)ilo;
  if (a >= 2.22507385850720140e-308) {
    return (double)((int)((ihi >> 20) & 0x7ff)) - 1023;
  } else {
    int expo = -1011 - __clzll(i);
    return (double)expo;
  }
}

static __inline__ __attribute__((always_inline)) double fma(double a, double b, double c)
{
  return __fma_rn(a, b, c);
}
# 7731 "/usr/local/cuda/bin/../include/math_functions.h" 2 3
# 160 "/usr/local/cuda/bin/../include/common_functions.h" 2
# 147 "txInterpTest.cu" 2
# 77 "/usr/local/cuda/bin/../include/sm_20_atomic_functions.h"
static __inline__ float _Z9atomicAddPff(
# 77 "/usr/local/cuda/bin/../include/sm_20_atomic_functions.h"
float *address,
# 77 "/usr/local/cuda/bin/../include/sm_20_atomic_functions.h"
float val){
# 77 "/usr/local/cuda/bin/../include/sm_20_atomic_functions.h"
{
# 78 "/usr/local/cuda/bin/../include/sm_20_atomic_functions.h"
{
# 79 "/usr/local/cuda/bin/../include/sm_20_atomic_functions.h"
return __fAtomicAdd(address, val);
# 80 "/usr/local/cuda/bin/../include/sm_20_atomic_functions.h"
}
# 80 "/usr/local/cuda/bin/../include/sm_20_atomic_functions.h"
}}
# 64 "txInterpTest.cu"
 __inline__ int _Z8ImageFcnff(
# 64 "txInterpTest.cu"
float x,
# 64 "txInterpTest.cu"
float y){
# 64 "txInterpTest.cu"
{
# 64 "txInterpTest.cu"
{
# 74 "txInterpTest.cu"
if ((((x - (511.5F)) * (x - (511.5F))) + ((y - (383.5F)) * (y - (383.5F)))) < (64.0F))
# 74 "txInterpTest.cu"
{
# 75 "txInterpTest.cu"
return 10;
# 75 "txInterpTest.cu"
}
# 75 "txInterpTest.cu"
else
# 75 "txInterpTest.cu"
{
# 77 "txInterpTest.cu"
return 0;
# 77 "txInterpTest.cu"
}
# 78 "txInterpTest.cu"
}
# 78 "txInterpTest.cu"
}}
# 80 "txInterpTest.cu"
 __inline__ int _Z8ImageFcnii(
# 80 "txInterpTest.cu"
int x,
# 80 "txInterpTest.cu"
int y){
# 80 "txInterpTest.cu"
{
# 80 "txInterpTest.cu"
{
# 82 "txInterpTest.cu"
if (((float)x) < (0.1000000015F))
# 82 "txInterpTest.cu"
{
# 83 "txInterpTest.cu"
return 3;
# 83 "txInterpTest.cu"
}
# 83 "txInterpTest.cu"
else
# 83 "txInterpTest.cu"
{
# 84 "txInterpTest.cu"
if (((float)(1024 - x)) < (1.100000024F))
# 84 "txInterpTest.cu"
{
# 85 "txInterpTest.cu"
return 2;
# 85 "txInterpTest.cu"
}
# 85 "txInterpTest.cu"
else
# 85 "txInterpTest.cu"
{
# 86 "txInterpTest.cu"
if (((float)(768 - y)) < (1.100000024F))
# 86 "txInterpTest.cu"
{
# 87 "txInterpTest.cu"
return 11;
# 87 "txInterpTest.cu"
}
# 87 "txInterpTest.cu"
else
# 87 "txInterpTest.cu"
{
# 88 "txInterpTest.cu"
if (((float)y) < (0.1000000015F))
# 88 "txInterpTest.cu"
{
# 89 "txInterpTest.cu"
return 12;
# 89 "txInterpTest.cu"
}
# 89 "txInterpTest.cu"
else
# 89 "txInterpTest.cu"
{
# 90 "txInterpTest.cu"
if ((((((float)x) - (511.5F)) * (((float)x) - (511.5F))) + ((((float)y) - (383.5F)) * (((float)y) - (383.5F)))) < (64.0F))
# 90 "txInterpTest.cu"
{
# 92 "txInterpTest.cu"
return 10;
# 92 "txInterpTest.cu"
}
# 92 "txInterpTest.cu"
else
# 92 "txInterpTest.cu"
{
# 94 "txInterpTest.cu"
return 0;
# 94 "txInterpTest.cu"
}
# 94 "txInterpTest.cu"
}
# 94 "txInterpTest.cu"
}
# 94 "txInterpTest.cu"
}
# 94 "txInterpTest.cu"
}
# 96 "txInterpTest.cu"
}
# 96 "txInterpTest.cu"
}}
# 195 "txInterpTest.cu"
 void _Z11mrt_collideRfS_S_S_S_S_S_S_S_f(
# 195 "txInterpTest.cu"
float *f0,
# 195 "txInterpTest.cu"
float *f1,
# 195 "txInterpTest.cu"
float *f2,
# 196 "txInterpTest.cu"
float *f3,
# 196 "txInterpTest.cu"
float *f4,
# 196 "txInterpTest.cu"
float *f5,
# 197 "txInterpTest.cu"
float *f6,
# 197 "txInterpTest.cu"
float *f7,
# 197 "txInterpTest.cu"
float *f8,
# 197 "txInterpTest.cu"
float omega){
# 197 "txInterpTest.cu"
{
# 198 "txInterpTest.cu"
{
# 200 "txInterpTest.cu"
 float __cuda_local_var_36308_8_non_const_u;
# 200 "txInterpTest.cu"
 float __cuda_local_var_36308_10_non_const_v;
# 204 "txInterpTest.cu"
 float __cuda_local_var_36312_8_non_const_m1;
# 204 "txInterpTest.cu"
 float __cuda_local_var_36312_11_non_const_m2;
# 204 "txInterpTest.cu"
 float __cuda_local_var_36312_14_non_const_m4;
# 204 "txInterpTest.cu"
 float __cuda_local_var_36312_17_non_const_m6;
# 204 "txInterpTest.cu"
 float __cuda_local_var_36312_20_non_const_m7;
# 204 "txInterpTest.cu"
 float __cuda_local_var_36312_23_non_const_m8;
# 202 "txInterpTest.cu"
__cuda_local_var_36308_8_non_const_u = ((((((*f1) - (*f3)) + (*f5)) - (*f6)) - (*f7)) + (*f8));
# 203 "txInterpTest.cu"
__cuda_local_var_36308_10_non_const_v = ((((((*f2) - (*f4)) + (*f5)) + (*f6)) - (*f7)) - (*f8));
# 207 "txInterpTest.cu"
__cuda_local_var_36312_8_non_const_m1 = (((((((((((-2.0F) * (*f0)) + (*f1)) + (*f2)) + (*f3)) + (*f4)) + ((4.0F) * (*f5))) + ((4.0F) * (*f6))) + ((4.0F) * (*f7))) + ((4.0F) * (*f8))) - ((3.0F) * ((__cuda_local_var_36308_8_non_const_u * __cuda_local_var_36308_8_non_const_u) + (__cuda_local_var_36308_10_non_const_v * __cuda_local_var_36308_10_non_const_v))));
# 209 "txInterpTest.cu"
__cuda_local_var_36312_11_non_const_m2 = (((((((3.0F) * (*f0)) - ((3.0F) * (*f1))) - ((3.0F) * (*f2))) - ((3.0F) * (*f3))) - ((3.0F) * (*f4))) + ((3.0F) * ((__cuda_local_var_36308_8_non_const_u * __cuda_local_var_36308_8_non_const_u) + (__cuda_local_var_36308_10_non_const_v * __cuda_local_var_36308_10_non_const_v))));
# 211 "txInterpTest.cu"
__cuda_local_var_36312_14_non_const_m4 = ((((((-(*f1)) + (*f3)) + ((2.0F) * (*f5))) - ((2.0F) * (*f6))) - ((2.0F) * (*f7))) + ((2.0F) * (*f8)));
# 212 "txInterpTest.cu"
__cuda_local_var_36312_17_non_const_m6 = ((((((-(*f2)) + (*f4)) + ((2.0F) * (*f5))) + ((2.0F) * (*f6))) - ((2.0F) * (*f7))) - ((2.0F) * (*f8)));
# 213 "txInterpTest.cu"
__cuda_local_var_36312_20_non_const_m7 = (((((*f1) - (*f2)) + (*f3)) - (*f4)) - ((__cuda_local_var_36308_8_non_const_u * __cuda_local_var_36308_8_non_const_u) - (__cuda_local_var_36308_10_non_const_v * __cuda_local_var_36308_10_non_const_v)));
# 214 "txInterpTest.cu"
__cuda_local_var_36312_23_non_const_m8 = (((((*f5) - (*f6)) + (*f7)) - (*f8)) - (__cuda_local_var_36308_8_non_const_u * __cuda_local_var_36308_10_non_const_v));
# 223 "txInterpTest.cu"
(*f0) = ((*f0) - (((-__cuda_local_var_36312_8_non_const_m1) + __cuda_local_var_36312_11_non_const_m2) * (0.1111111119F)));
# 225 "txInterpTest.cu"
(*f1) = ((*f1) - (((((-__cuda_local_var_36312_8_non_const_m1) * (0.02777777612F)) - ((0.05555555597F) * __cuda_local_var_36312_11_non_const_m2)) - ((0.1666666716F) * __cuda_local_var_36312_14_non_const_m4)) + ((__cuda_local_var_36312_20_non_const_m7 * omega) * (0.25F))));
# 226 "txInterpTest.cu"
(*f2) = ((*f2) - (((((-__cuda_local_var_36312_8_non_const_m1) * (0.02777777612F)) - ((0.05555555597F) * __cuda_local_var_36312_11_non_const_m2)) - ((0.1666666716F) * __cuda_local_var_36312_17_non_const_m6)) - ((__cuda_local_var_36312_20_non_const_m7 * omega) * (0.25F))));
# 227 "txInterpTest.cu"
(*f3) = ((*f3) - (((((-__cuda_local_var_36312_8_non_const_m1) * (0.02777777612F)) - ((0.05555555597F) * __cuda_local_var_36312_11_non_const_m2)) + ((0.1666666716F) * __cuda_local_var_36312_14_non_const_m4)) + ((__cuda_local_var_36312_20_non_const_m7 * omega) * (0.25F))));
# 228 "txInterpTest.cu"
(*f4) = ((*f4) - (((((-__cuda_local_var_36312_8_non_const_m1) * (0.02777777612F)) - ((0.05555555597F) * __cuda_local_var_36312_11_non_const_m2)) + ((0.1666666716F) * __cuda_local_var_36312_17_non_const_m6)) - ((__cuda_local_var_36312_20_non_const_m7 * omega) * (0.25F))));
# 229 "txInterpTest.cu"
(*f5) = ((*f5) - ((((((0.05555555597F) * __cuda_local_var_36312_8_non_const_m1) + (__cuda_local_var_36312_11_non_const_m2 * (0.02777777612F))) + ((0.08333333582F) * __cuda_local_var_36312_14_non_const_m4)) + ((0.08333333582F) * __cuda_local_var_36312_17_non_const_m6)) + ((__cuda_local_var_36312_23_non_const_m8 * omega) * (0.25F))));
# 230 "txInterpTest.cu"
(*f6) = ((*f6) - ((((((0.05555555597F) * __cuda_local_var_36312_8_non_const_m1) + (__cuda_local_var_36312_11_non_const_m2 * (0.02777777612F))) - ((0.08333333582F) * __cuda_local_var_36312_14_non_const_m4)) + ((0.08333333582F) * __cuda_local_var_36312_17_non_const_m6)) - ((__cuda_local_var_36312_23_non_const_m8 * omega) * (0.25F))));
# 231 "txInterpTest.cu"
(*f7) = ((*f7) - ((((((0.05555555597F) * __cuda_local_var_36312_8_non_const_m1) + (__cuda_local_var_36312_11_non_const_m2 * (0.02777777612F))) - ((0.08333333582F) * __cuda_local_var_36312_14_non_const_m4)) - ((0.08333333582F) * __cuda_local_var_36312_17_non_const_m6)) + ((__cuda_local_var_36312_23_non_const_m8 * omega) * (0.25F))));
# 232 "txInterpTest.cu"
(*f8) = ((*f8) - ((((((0.05555555597F) * __cuda_local_var_36312_8_non_const_m1) + (__cuda_local_var_36312_11_non_const_m2 * (0.02777777612F))) + ((0.08333333582F) * __cuda_local_var_36312_14_non_const_m4)) - ((0.08333333582F) * __cuda_local_var_36312_17_non_const_m6)) - ((__cuda_local_var_36312_23_non_const_m8 * omega) * (0.25F))));
# 241 "txInterpTest.cu"
}
# 241 "txInterpTest.cu"
}}
# 243 "txInterpTest.cu"
 void _Z11NeumannEastRfS_S_S_S_S_S_S_S_i(
# 243 "txInterpTest.cu"
float *f0,
# 243 "txInterpTest.cu"
float *f1,
# 243 "txInterpTest.cu"
float *f2,
# 244 "txInterpTest.cu"
float *f3,
# 244 "txInterpTest.cu"
float *f4,
# 244 "txInterpTest.cu"
float *f5,
# 245 "txInterpTest.cu"
float *f6,
# 245 "txInterpTest.cu"
float *f7,
# 245 "txInterpTest.cu"
float *f8,
# 245 "txInterpTest.cu"
int y){
# 245 "txInterpTest.cu"
{
# 246 "txInterpTest.cu"
{
# 255 "txInterpTest.cu"
 float __cuda_local_var_36349_8_non_const_u;
# 255 "txInterpTest.cu"
 float __cuda_local_var_36349_10_non_const_rho;
# 247 "txInterpTest.cu"
if (y == 0)
# 247 "txInterpTest.cu"
{
# 248 "txInterpTest.cu"
(*f2) = (*f4);
# 249 "txInterpTest.cu"
(*f5) = (*f8);
# 250 "txInterpTest.cu"
}
# 250 "txInterpTest.cu"
else
# 250 "txInterpTest.cu"
{
# 251 "txInterpTest.cu"
if (y == 767)
# 251 "txInterpTest.cu"
{
# 252 "txInterpTest.cu"
(*f4) = (*f2);
# 253 "txInterpTest.cu"
(*f8) = (*f5);
# 254 "txInterpTest.cu"
}
# 254 "txInterpTest.cu"
}
# 257 "txInterpTest.cu"
__cuda_local_var_36349_10_non_const_rho = (1.0F);
# 258 "txInterpTest.cu"
__cuda_local_var_36349_8_non_const_u = ((-__cuda_local_var_36349_10_non_const_rho) + ((((((*f0) + (*f2)) + (*f4)) + ((2.0F) * (*f1))) + ((2.0F) * (*f5))) + ((2.0F) * (*f8))));
# 260 "txInterpTest.cu"
(*f3) = ((*f1) - (__cuda_local_var_36349_8_non_const_u * (0.6666666865F)));
# 261 "txInterpTest.cu"
(*f7) = (((*f5) + ((0.5F) * ((*f2) - (*f4)))) - (__cuda_local_var_36349_8_non_const_u * (0.1666666716F)));
# 262 "txInterpTest.cu"
(*f6) = (((*f8) - ((0.5F) * ((*f2) - (*f4)))) - (__cuda_local_var_36349_8_non_const_u * (0.1666666716F)));
# 265 "txInterpTest.cu"
}
# 265 "txInterpTest.cu"
}}
# 266 "txInterpTest.cu"
 void _Z13DirichletWestRfS_S_S_S_S_S_S_S_i(
# 266 "txInterpTest.cu"
float *f0,
# 266 "txInterpTest.cu"
float *f1,
# 266 "txInterpTest.cu"
float *f2,
# 267 "txInterpTest.cu"
float *f3,
# 267 "txInterpTest.cu"
float *f4,
# 267 "txInterpTest.cu"
float *f5,
# 268 "txInterpTest.cu"
float *f6,
# 268 "txInterpTest.cu"
float *f7,
# 268 "txInterpTest.cu"
float *f8,
# 268 "txInterpTest.cu"
int y){
# 268 "txInterpTest.cu"
{
# 269 "txInterpTest.cu"
{
# 278 "txInterpTest.cu"
 float __cuda_local_var_36372_8_non_const_u;
# 270 "txInterpTest.cu"
if (y == 0)
# 270 "txInterpTest.cu"
{
# 271 "txInterpTest.cu"
(*f2) = (*f4);
# 272 "txInterpTest.cu"
(*f6) = (*f7);
# 273 "txInterpTest.cu"
}
# 273 "txInterpTest.cu"
else
# 273 "txInterpTest.cu"
{
# 274 "txInterpTest.cu"
if (y == 767)
# 274 "txInterpTest.cu"
{
# 275 "txInterpTest.cu"
(*f4) = (*f2);
# 276 "txInterpTest.cu"
(*f7) = (*f6);
# 277 "txInterpTest.cu"
}
# 277 "txInterpTest.cu"
}
# 279 "txInterpTest.cu"
__cuda_local_var_36372_8_non_const_u = (0.07999999821F);
# 281 "txInterpTest.cu"
(*f1) = ((*f3) + (__cuda_local_var_36372_8_non_const_u * (0.6666666865F)));
# 282 "txInterpTest.cu"
(*f5) = (((*f7) - ((0.5F) * ((*f2) - (*f4)))) + (__cuda_local_var_36372_8_non_const_u * (0.1666666716F)));
# 283 "txInterpTest.cu"
(*f8) = (((*f6) + ((0.5F) * ((*f2) - (*f4)))) + (__cuda_local_var_36372_8_non_const_u * (0.1666666716F)));
# 286 "txInterpTest.cu"
}
# 286 "txInterpTest.cu"
}}
# 291 "txInterpTest.cu"
 void _Z10boundariesRfS_S_S_S_S_S_S_S_ii(
# 291 "txInterpTest.cu"
float *f0,
# 291 "txInterpTest.cu"
float *f1,
# 291 "txInterpTest.cu"
float *f2,
# 292 "txInterpTest.cu"
float *f3,
# 292 "txInterpTest.cu"
float *f4,
# 292 "txInterpTest.cu"
float *f5,
# 293 "txInterpTest.cu"
float *f6,
# 293 "txInterpTest.cu"
float *f7,
# 293 "txInterpTest.cu"
float *f8,
# 294 "txInterpTest.cu"
int y,
# 294 "txInterpTest.cu"
int im){
# 294 "txInterpTest.cu"
{
# 295 "txInterpTest.cu"
{
# 296 "txInterpTest.cu"
if (im == 2)
# 297 "txInterpTest.cu"
{
# 298 "txInterpTest.cu"
_Z11NeumannEastRfS_S_S_S_S_S_S_S_i(f0, f1, f2, f3, f4, f5, f6, f7, f8, y);
# 299 "txInterpTest.cu"
}
# 299 "txInterpTest.cu"
else
# 299 "txInterpTest.cu"
{
# 300 "txInterpTest.cu"
if (im == 3)
# 301 "txInterpTest.cu"
{
# 302 "txInterpTest.cu"
_Z13DirichletWestRfS_S_S_S_S_S_S_S_i(f0, f1, f2, f3, f4, f5, f6, f7, f8, y);
# 303 "txInterpTest.cu"
}
# 303 "txInterpTest.cu"
else
# 303 "txInterpTest.cu"
{
# 304 "txInterpTest.cu"
if (im == 11)
# 305 "txInterpTest.cu"
{
# 306 "txInterpTest.cu"
(*f4) = (*f2);
# 307 "txInterpTest.cu"
(*f7) = (*f6);
# 308 "txInterpTest.cu"
(*f8) = (*f5);
# 309 "txInterpTest.cu"
}
# 309 "txInterpTest.cu"
else
# 309 "txInterpTest.cu"
{
# 310 "txInterpTest.cu"
if (im == 12)
# 311 "txInterpTest.cu"
{
# 312 "txInterpTest.cu"
(*f2) = (*f4);
# 313 "txInterpTest.cu"
(*f6) = (*f7);
# 314 "txInterpTest.cu"
(*f5) = (*f8);
# 315 "txInterpTest.cu"
}
# 315 "txInterpTest.cu"
}
# 315 "txInterpTest.cu"
}
# 315 "txInterpTest.cu"
}
# 316 "txInterpTest.cu"
}
# 316 "txInterpTest.cu"
}}
# 319 "txInterpTest.cu"
 void _Z16boundaries_forceRfS_S_S_S_S_S_S_S_ii(
# 319 "txInterpTest.cu"
float *f0,
# 319 "txInterpTest.cu"
float *f1,
# 319 "txInterpTest.cu"
float *f2,
# 320 "txInterpTest.cu"
float *f3,
# 320 "txInterpTest.cu"
float *f4,
# 320 "txInterpTest.cu"
float *f5,
# 321 "txInterpTest.cu"
float *f6,
# 321 "txInterpTest.cu"
float *f7,
# 321 "txInterpTest.cu"
float *f8,
# 322 "txInterpTest.cu"
int y,
# 322 "txInterpTest.cu"
int im){
# 322 "txInterpTest.cu"
{
# 323 "txInterpTest.cu"
{
# 324 "txInterpTest.cu"
if (im == 2)
# 325 "txInterpTest.cu"
{
# 326 "txInterpTest.cu"
_Z11NeumannEastRfS_S_S_S_S_S_S_S_i(f0, f1, f2, f3, f4, f5, f6, f7, f8, y);
# 327 "txInterpTest.cu"
}
# 327 "txInterpTest.cu"
else
# 327 "txInterpTest.cu"
{
# 328 "txInterpTest.cu"
if (im == 3)
# 329 "txInterpTest.cu"
{
# 330 "txInterpTest.cu"
_Z13DirichletWestRfS_S_S_S_S_S_S_S_i(f0, f1, f2, f3, f4, f5, f6, f7, f8, y);
# 331 "txInterpTest.cu"
}
# 331 "txInterpTest.cu"
}
# 332 "txInterpTest.cu"
if (im == 11)
# 333 "txInterpTest.cu"
{
# 334 "txInterpTest.cu"
(*f4) = (*f2);
# 335 "txInterpTest.cu"
(*f7) = (*f6);
# 336 "txInterpTest.cu"
(*f8) = (*f5);
# 337 "txInterpTest.cu"
}
# 337 "txInterpTest.cu"
else
# 337 "txInterpTest.cu"
{
# 338 "txInterpTest.cu"
if (im == 12)
# 339 "txInterpTest.cu"
{
# 340 "txInterpTest.cu"
(*f2) = (*f4);
# 341 "txInterpTest.cu"
(*f6) = (*f7);
# 342 "txInterpTest.cu"
(*f5) = (*f8);
# 343 "txInterpTest.cu"
}
# 343 "txInterpTest.cu"
}
# 344 "txInterpTest.cu"
}
# 344 "txInterpTest.cu"
}}
# 359 "txInterpTest.cu"
 int _Z4dminii(
# 359 "txInterpTest.cu"
int a,
# 359 "txInterpTest.cu"
int b){
# 359 "txInterpTest.cu"
{
# 360 "txInterpTest.cu"
{
# 361 "txInterpTest.cu"
if (a < b)
# 361 "txInterpTest.cu"
{
# 361 "txInterpTest.cu"
return a;
# 361 "txInterpTest.cu"
}
# 361 "txInterpTest.cu"
else
# 361 "txInterpTest.cu"
{
# 362 "txInterpTest.cu"
return b - 1;
# 362 "txInterpTest.cu"
}
# 363 "txInterpTest.cu"
}
# 363 "txInterpTest.cu"
}}
# 364 "txInterpTest.cu"
 int _Z4dmaxi(
# 364 "txInterpTest.cu"
int a){
# 364 "txInterpTest.cu"
{
# 365 "txInterpTest.cu"
{
# 366 "txInterpTest.cu"
if (a > (-1))
# 366 "txInterpTest.cu"
{
# 366 "txInterpTest.cu"
return a;
# 366 "txInterpTest.cu"
}
# 366 "txInterpTest.cu"
else
# 366 "txInterpTest.cu"
{
# 367 "txInterpTest.cu"
return 0;
# 367 "txInterpTest.cu"
}
# 368 "txInterpTest.cu"
}
# 368 "txInterpTest.cu"
}}
# 370 "txInterpTest.cu"
__attribute__((global)) __attribute__((__used__)) void _Z11simple_copyPfS_Pifm(
# 370 "txInterpTest.cu"
float *fA,
# 370 "txInterpTest.cu"
float *fB,
# 371 "txInterpTest.cu"
int *image,
# 371 "txInterpTest.cu"
float omega,
# 371 "txInterpTest.cu"
size_t pitch){
# 371 "txInterpTest.cu"
{
# 372 "txInterpTest.cu"
{
# 373 "txInterpTest.cu"
 int __cuda_local_var_36467_6_non_const_x;
# 374 "txInterpTest.cu"
 int __cuda_local_var_36468_6_non_const_y;
# 375 "txInterpTest.cu"
 int __cuda_local_var_36469_6_non_const_z;
# 376 "txInterpTest.cu"
 int __cuda_local_var_36470_6_non_const_j;
# 373 "txInterpTest.cu"
__cuda_local_var_36467_6_non_const_x = ((int)((threadIdx.x) + ((blockIdx.x) * (blockDim.x))));
# 374 "txInterpTest.cu"
__cuda_local_var_36468_6_non_const_y = ((int)((threadIdx.y) + ((blockIdx.y) * (blockDim.y))));
# 375 "txInterpTest.cu"
__cuda_local_var_36469_6_non_const_z = ((int)((threadIdx.z) + ((blockIdx.z) * (blockDim.z))));
# 376 "txInterpTest.cu"
__cuda_local_var_36470_6_non_const_j = ((int)((((unsigned long)__cuda_local_var_36467_6_non_const_x) + (((unsigned long)__cuda_local_var_36468_6_non_const_y) * pitch)) + (((unsigned long)(__cuda_local_var_36469_6_non_const_z * 768)) * pitch)));
# 378 "txInterpTest.cu"
(fB[__cuda_local_var_36470_6_non_const_j]) = (fA[__cuda_local_var_36470_6_non_const_j]);
# 379 "txInterpTest.cu"
}
# 379 "txInterpTest.cu"
}}
# 381 "txInterpTest.cu"
__attribute__((global)) __attribute__((__used__)) void _Z14ExtractFromC_dPfmf(
# 381 "txInterpTest.cu"
float *fout,
# 382 "txInterpTest.cu"
size_t pitch,
# 382 "txInterpTest.cu"
float SF){
# 382 "txInterpTest.cu"
{
# 383 "txInterpTest.cu"
{
# 384 "txInterpTest.cu"
 int __cuda_local_var_36478_6_non_const_x;
# 385 "txInterpTest.cu"
 int __cuda_local_var_36479_6_non_const_y;
# 386 "txInterpTest.cu"
 float __cuda_local_var_36480_8_non_const_f0;
# 386 "txInterpTest.cu"
 float __cuda_local_var_36480_11_non_const_f1;
# 386 "txInterpTest.cu"
 float __cuda_local_var_36480_14_non_const_f2;
# 386 "txInterpTest.cu"
 float __cuda_local_var_36480_17_non_const_f3;
# 386 "txInterpTest.cu"
 float __cuda_local_var_36480_20_non_const_f4;
# 386 "txInterpTest.cu"
 float __cuda_local_var_36480_23_non_const_f5;
# 386 "txInterpTest.cu"
 float __cuda_local_var_36480_26_non_const_f6;
# 386 "txInterpTest.cu"
 float __cuda_local_var_36480_29_non_const_f7;
# 386 "txInterpTest.cu"
 float __cuda_local_var_36480_32_non_const_f8;
# 384 "txInterpTest.cu"
__cuda_local_var_36478_6_non_const_x = ((int)((threadIdx.x) + ((blockIdx.x) * (blockDim.x))));
# 385 "txInterpTest.cu"
__cuda_local_var_36479_6_non_const_y = ((int)((threadIdx.y) + ((blockIdx.y) * (blockDim.y))));
# 394 "txInterpTest.cu"
if (((((((double)__cuda_local_var_36478_6_non_const_x) > (416.625)) && (((double)__cuda_local_var_36478_6_non_const_x) < (606.625))) && (((double)__cuda_local_var_36479_6_non_const_y) > (320.625))) && (((double)__cuda_local_var_36479_6_non_const_y) < (446.625))) && ((((__cuda_local_var_36478_6_non_const_x == 417) || (__cuda_local_var_36478_6_non_const_x == 606)) || (__cuda_local_var_36479_6_non_const_y == 321)) || (__cuda_local_var_36479_6_non_const_y == 446)))
# 396 "txInterpTest.cu"
{
# 396 "txInterpTest.cu"
 __texture_type__ __T24;
# 397 "txInterpTest.cu"
 float4 __T25;
# 398 "txInterpTest.cu"
 float4 __T26;
# 399 "txInterpTest.cu"
 __texture_type__ __T27;
# 400 "txInterpTest.cu"
 float4 __T28;
# 401 "txInterpTest.cu"
 float4 __T29;
# 402 "txInterpTest.cu"
 __texture_type__ __T210;
# 403 "txInterpTest.cu"
 float4 __T211;
# 404 "txInterpTest.cu"
 float4 __T212;
# 405 "txInterpTest.cu"
 __texture_type__ __T213;
# 406 "txInterpTest.cu"
 float4 __T214;
# 407 "txInterpTest.cu"
 float4 __T215;
# 408 "txInterpTest.cu"
 __texture_type__ __T216;
# 409 "txInterpTest.cu"
 float4 __T217;
# 410 "txInterpTest.cu"
 float4 __T218;
# 411 "txInterpTest.cu"
 __texture_type__ __T219;
# 412 "txInterpTest.cu"
 float4 __T220;
# 413 "txInterpTest.cu"
 float4 __T221;
# 414 "txInterpTest.cu"
 __texture_type__ __T222;
# 415 "txInterpTest.cu"
 float4 __T223;
# 416 "txInterpTest.cu"
 float4 __T224;
# 417 "txInterpTest.cu"
 __texture_type__ __T225;
# 418 "txInterpTest.cu"
 float4 __T226;
# 419 "txInterpTest.cu"
 float4 __T227;
# 420 "txInterpTest.cu"
 __texture_type__ __T228;
# 421 "txInterpTest.cu"
 float4 __T229;
# 422 "txInterpTest.cu"
 float4 __T230;
# 399 "txInterpTest.cu"
 float __cuda_local_var_36493_8_non_const_xcoord;
# 400 "txInterpTest.cu"
 float __cuda_local_var_36494_8_non_const_ycoord;
# 411 "txInterpTest.cu"
 float __cuda_local_var_36505_8_non_const_rho;
# 411 "txInterpTest.cu"
 float __cuda_local_var_36505_12_non_const_u;
# 411 "txInterpTest.cu"
 float __cuda_local_var_36505_14_non_const_v;
# 415 "txInterpTest.cu"
 float __cuda_local_var_36509_8_non_const_usqr;
# 399 "txInterpTest.cu"
__cuda_local_var_36493_8_non_const_xcoord = ((float)(((double)(fdivide((((double)__cuda_local_var_36478_6_non_const_x) - (415.625)), (0.25)))) + (0.5)));
# 400 "txInterpTest.cu"
__cuda_local_var_36494_8_non_const_ycoord = ((float)(((double)(fdivide((((double)__cuda_local_var_36479_6_non_const_y) - (319.625)), (0.25)))) + (0.5)));
# 401 "txInterpTest.cu"
__cuda_local_var_36480_8_non_const_f0 = ((__T24 = texRef_f0C) , ((__T26 = (__ftexfetch2D(__T24, ((((((__T25.x) = __cuda_local_var_36493_8_non_const_xcoord) , ((void)((__T25.y) = __cuda_local_var_36494_8_non_const_ycoord))) , ((void)((__T25.z) = (0.0F)))) , ((void)((__T25.w) = (0.0F)))) , __T25)))) , (__T26.x)));
# 402 "txInterpTest.cu"
__cuda_local_var_36480_11_non_const_f1 = ((__T27 = texRef_f1C) , ((__T29 = (__ftexfetch2D(__T27, ((((((__T28.x) = __cuda_local_var_36493_8_non_const_xcoord) , ((void)((__T28.y) = __cuda_local_var_36494_8_non_const_ycoord))) , ((void)((__T28.z) = (0.0F)))) , ((void)((__T28.w) = (0.0F)))) , __T28)))) , (__T29.x)));
# 403 "txInterpTest.cu"
__cuda_local_var_36480_14_non_const_f2 = ((__T210 = texRef_f2C) , ((__T212 = (__ftexfetch2D(__T210, ((((((__T211.x) = __cuda_local_var_36493_8_non_const_xcoord) , ((void)((__T211.y) = __cuda_local_var_36494_8_non_const_ycoord))) , ((void)((__T211.z) = (0.0F)))) , ((void)((__T211.w) = (0.0F)))) , __T211)))) , (__T212.x)));
# 404 "txInterpTest.cu"
__cuda_local_var_36480_17_non_const_f3 = ((__T213 = texRef_f3C) , ((__T215 = (__ftexfetch2D(__T213, ((((((__T214.x) = __cuda_local_var_36493_8_non_const_xcoord) , ((void)((__T214.y) = __cuda_local_var_36494_8_non_const_ycoord))) , ((void)((__T214.z) = (0.0F)))) , ((void)((__T214.w) = (0.0F)))) , __T214)))) , (__T215.x)));
# 405 "txInterpTest.cu"
__cuda_local_var_36480_20_non_const_f4 = ((__T216 = texRef_f4C) , ((__T218 = (__ftexfetch2D(__T216, ((((((__T217.x) = __cuda_local_var_36493_8_non_const_xcoord) , ((void)((__T217.y) = __cuda_local_var_36494_8_non_const_ycoord))) , ((void)((__T217.z) = (0.0F)))) , ((void)((__T217.w) = (0.0F)))) , __T217)))) , (__T218.x)));
# 406 "txInterpTest.cu"
__cuda_local_var_36480_23_non_const_f5 = ((__T219 = texRef_f5C) , ((__T221 = (__ftexfetch2D(__T219, ((((((__T220.x) = __cuda_local_var_36493_8_non_const_xcoord) , ((void)((__T220.y) = __cuda_local_var_36494_8_non_const_ycoord))) , ((void)((__T220.z) = (0.0F)))) , ((void)((__T220.w) = (0.0F)))) , __T220)))) , (__T221.x)));
# 407 "txInterpTest.cu"
__cuda_local_var_36480_26_non_const_f6 = ((__T222 = texRef_f6C) , ((__T224 = (__ftexfetch2D(__T222, ((((((__T223.x) = __cuda_local_var_36493_8_non_const_xcoord) , ((void)((__T223.y) = __cuda_local_var_36494_8_non_const_ycoord))) , ((void)((__T223.z) = (0.0F)))) , ((void)((__T223.w) = (0.0F)))) , __T223)))) , (__T224.x)));
# 408 "txInterpTest.cu"
__cuda_local_var_36480_29_non_const_f7 = ((__T225 = texRef_f7C) , ((__T227 = (__ftexfetch2D(__T225, ((((((__T226.x) = __cuda_local_var_36493_8_non_const_xcoord) , ((void)((__T226.y) = __cuda_local_var_36494_8_non_const_ycoord))) , ((void)((__T226.z) = (0.0F)))) , ((void)((__T226.w) = (0.0F)))) , __T226)))) , (__T227.x)));
# 409 "txInterpTest.cu"
__cuda_local_var_36480_32_non_const_f8 = ((__T228 = texRef_f8C) , ((__T230 = (__ftexfetch2D(__T228, ((((((__T229.x) = __cuda_local_var_36493_8_non_const_xcoord) , ((void)((__T229.y) = __cuda_local_var_36494_8_non_const_ycoord))) , ((void)((__T229.z) = (0.0F)))) , ((void)((__T229.w) = (0.0F)))) , __T229)))) , (__T230.x)));
# 412 "txInterpTest.cu"
__cuda_local_var_36505_8_non_const_rho = ((((((((__cuda_local_var_36480_8_non_const_f0 + __cuda_local_var_36480_11_non_const_f1) + __cuda_local_var_36480_14_non_const_f2) + __cuda_local_var_36480_17_non_const_f3) + __cuda_local_var_36480_20_non_const_f4) + __cuda_local_var_36480_23_non_const_f5) + __cuda_local_var_36480_26_non_const_f6) + __cuda_local_var_36480_29_non_const_f7) + __cuda_local_var_36480_32_non_const_f8);
# 413 "txInterpTest.cu"
__cuda_local_var_36505_12_non_const_u = (((((__cuda_local_var_36480_11_non_const_f1 - __cuda_local_var_36480_17_non_const_f3) + __cuda_local_var_36480_23_non_const_f5) - __cuda_local_var_36480_26_non_const_f6) - __cuda_local_var_36480_29_non_const_f7) + __cuda_local_var_36480_32_non_const_f8);
# 414 "txInterpTest.cu"
__cuda_local_var_36505_14_non_const_v = (((((__cuda_local_var_36480_14_non_const_f2 - __cuda_local_var_36480_20_non_const_f4) + __cuda_local_var_36480_23_non_const_f5) + __cuda_local_var_36480_26_non_const_f6) - __cuda_local_var_36480_29_non_const_f7) - __cuda_local_var_36480_32_non_const_f8);
# 415 "txInterpTest.cu"
__cuda_local_var_36509_8_non_const_usqr = ((__cuda_local_var_36505_12_non_const_u * __cuda_local_var_36505_12_non_const_u) + (__cuda_local_var_36505_14_non_const_v * __cuda_local_var_36505_14_non_const_v));
# 427 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36478_6_non_const_x) + (((unsigned long)__cuda_local_var_36479_6_non_const_y) * pitch)) + ((0UL * pitch) * 768UL)))]) = ((SF * __cuda_local_var_36480_8_non_const_f0) + (((1.0F) - SF) * ((0.4444444478F) * (__cuda_local_var_36505_8_non_const_rho - ((1.5F) * __cuda_local_var_36509_8_non_const_usqr)))));
# 428 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36478_6_non_const_x) + (((unsigned long)__cuda_local_var_36479_6_non_const_y) * pitch)) + ((1UL * pitch) * 768UL)))]) = ((SF * __cuda_local_var_36480_11_non_const_f1) + (((1.0F) - SF) * ((0.1111111119F) * (((__cuda_local_var_36505_8_non_const_rho + ((3.0F) * __cuda_local_var_36505_12_non_const_u)) + (((4.5F) * __cuda_local_var_36505_12_non_const_u) * __cuda_local_var_36505_12_non_const_u)) - ((1.5F) * __cuda_local_var_36509_8_non_const_usqr)))));
# 429 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36478_6_non_const_x) + (((unsigned long)__cuda_local_var_36479_6_non_const_y) * pitch)) + ((2UL * pitch) * 768UL)))]) = ((SF * __cuda_local_var_36480_14_non_const_f2) + (((1.0F) - SF) * ((0.1111111119F) * (((__cuda_local_var_36505_8_non_const_rho + ((3.0F) * __cuda_local_var_36505_14_non_const_v)) + (((4.5F) * __cuda_local_var_36505_14_non_const_v) * __cuda_local_var_36505_14_non_const_v)) - ((1.5F) * __cuda_local_var_36509_8_non_const_usqr)))));
# 430 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36478_6_non_const_x) + (((unsigned long)__cuda_local_var_36479_6_non_const_y) * pitch)) + ((3UL * pitch) * 768UL)))]) = ((SF * __cuda_local_var_36480_17_non_const_f3) + (((1.0F) - SF) * ((0.1111111119F) * (((__cuda_local_var_36505_8_non_const_rho - ((3.0F) * __cuda_local_var_36505_12_non_const_u)) + (((4.5F) * __cuda_local_var_36505_12_non_const_u) * __cuda_local_var_36505_12_non_const_u)) - ((1.5F) * __cuda_local_var_36509_8_non_const_usqr)))));
# 431 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36478_6_non_const_x) + (((unsigned long)__cuda_local_var_36479_6_non_const_y) * pitch)) + ((4UL * pitch) * 768UL)))]) = ((SF * __cuda_local_var_36480_20_non_const_f4) + (((1.0F) - SF) * ((0.1111111119F) * (((__cuda_local_var_36505_8_non_const_rho - ((3.0F) * __cuda_local_var_36505_14_non_const_v)) + (((4.5F) * __cuda_local_var_36505_14_non_const_v) * __cuda_local_var_36505_14_non_const_v)) - ((1.5F) * __cuda_local_var_36509_8_non_const_usqr)))));
# 432 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36478_6_non_const_x) + (((unsigned long)__cuda_local_var_36479_6_non_const_y) * pitch)) + ((5UL * pitch) * 768UL)))]) = ((float)(((double)(SF * __cuda_local_var_36480_23_non_const_f5)) + (((double)((1.0F) - SF)) * ((0.02777777777999999864) * ((double)(((__cuda_local_var_36505_8_non_const_rho + ((3.0F) * (__cuda_local_var_36505_12_non_const_u + __cuda_local_var_36505_14_non_const_v))) + (((4.5F) * (__cuda_local_var_36505_12_non_const_u + __cuda_local_var_36505_14_non_const_v)) * (__cuda_local_var_36505_12_non_const_u + __cuda_local_var_36505_14_non_const_v))) - ((1.5F) * __cuda_local_var_36509_8_non_const_usqr)))))));
# 433 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36478_6_non_const_x) + (((unsigned long)__cuda_local_var_36479_6_non_const_y) * pitch)) + ((6UL * pitch) * 768UL)))]) = ((float)(((double)(SF * __cuda_local_var_36480_26_non_const_f6)) + (((double)((1.0F) - SF)) * ((0.02777777777999999864) * ((double)(((__cuda_local_var_36505_8_non_const_rho + ((3.0F) * ((-__cuda_local_var_36505_12_non_const_u) + __cuda_local_var_36505_14_non_const_v))) + (((4.5F) * ((-__cuda_local_var_36505_12_non_const_u) + __cuda_local_var_36505_14_non_const_v)) * ((-__cuda_local_var_36505_12_non_const_u) + __cuda_local_var_36505_14_non_const_v))) - ((1.5F) * __cuda_local_var_36509_8_non_const_usqr)))))));
# 434 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36478_6_non_const_x) + (((unsigned long)__cuda_local_var_36479_6_non_const_y) * pitch)) + ((7UL * pitch) * 768UL)))]) = ((float)(((double)(SF * __cuda_local_var_36480_29_non_const_f7)) + (((double)((1.0F) - SF)) * ((0.02777777777999999864) * ((double)(((__cuda_local_var_36505_8_non_const_rho + ((3.0F) * ((-__cuda_local_var_36505_12_non_const_u) - __cuda_local_var_36505_14_non_const_v))) + (((4.5F) * ((-__cuda_local_var_36505_12_non_const_u) - __cuda_local_var_36505_14_non_const_v)) * ((-__cuda_local_var_36505_12_non_const_u) - __cuda_local_var_36505_14_non_const_v))) - ((1.5F) * __cuda_local_var_36509_8_non_const_usqr)))))));
# 435 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36478_6_non_const_x) + (((unsigned long)__cuda_local_var_36479_6_non_const_y) * pitch)) + ((8UL * pitch) * 768UL)))]) = ((float)(((double)(SF * __cuda_local_var_36480_32_non_const_f8)) + (((double)((1.0F) - SF)) * ((0.02777777777999999864) * ((double)(((__cuda_local_var_36505_8_non_const_rho + ((3.0F) * (__cuda_local_var_36505_12_non_const_u - __cuda_local_var_36505_14_non_const_v))) + (((4.5F) * (__cuda_local_var_36505_12_non_const_u - __cuda_local_var_36505_14_non_const_v)) * (__cuda_local_var_36505_12_non_const_u - __cuda_local_var_36505_14_non_const_v))) - ((1.5F) * __cuda_local_var_36509_8_non_const_usqr)))))));
# 446 "txInterpTest.cu"
}
# 447 "txInterpTest.cu"
}
# 447 "txInterpTest.cu"
}}
# 449 "txInterpTest.cu"
__attribute__((global)) __attribute__((__used__)) void _Z18LR_d_hybABCD_forcePfS_fmS_S_i(
# 449 "txInterpTest.cu"
float *fin,
# 449 "txInterpTest.cu"
float *fout,
# 450 "txInterpTest.cu"
float omega,
# 450 "txInterpTest.cu"
size_t pitch,
# 450 "txInterpTest.cu"
float *FX,
# 450 "txInterpTest.cu"
float *FY,
# 450 "txInterpTest.cu"
int t){
# 450 "txInterpTest.cu"
{
# 451 "txInterpTest.cu"
{
# 451 "txInterpTest.cu"
 __texture_type__ __T231;
# 452 "txInterpTest.cu"
 float __T232;
# 453 "txInterpTest.cu"
 float __T233;
# 454 "txInterpTest.cu"
 float4 __T234;
# 455 "txInterpTest.cu"
 float4 __T235;
# 456 "txInterpTest.cu"
 __texture_type__ __T236;
# 457 "txInterpTest.cu"
 float __T237;
# 458 "txInterpTest.cu"
 float __T238;
# 459 "txInterpTest.cu"
 float4 __T239;
# 460 "txInterpTest.cu"
 float4 __T240;
# 461 "txInterpTest.cu"
 __texture_type__ __T241;
# 462 "txInterpTest.cu"
 float __T242;
# 463 "txInterpTest.cu"
 float __T243;
# 464 "txInterpTest.cu"
 float4 __T244;
# 465 "txInterpTest.cu"
 float4 __T245;
# 466 "txInterpTest.cu"
 __texture_type__ __T246;
# 467 "txInterpTest.cu"
 float __T247;
# 468 "txInterpTest.cu"
 float __T248;
# 469 "txInterpTest.cu"
 float4 __T249;
# 470 "txInterpTest.cu"
 float4 __T250;
# 471 "txInterpTest.cu"
 __texture_type__ __T251;
# 472 "txInterpTest.cu"
 float __T252;
# 473 "txInterpTest.cu"
 float __T253;
# 474 "txInterpTest.cu"
 float4 __T254;
# 475 "txInterpTest.cu"
 float4 __T255;
# 476 "txInterpTest.cu"
 __texture_type__ __T256;
# 477 "txInterpTest.cu"
 float __T257;
# 478 "txInterpTest.cu"
 float __T258;
# 479 "txInterpTest.cu"
 float4 __T259;
# 480 "txInterpTest.cu"
 float4 __T260;
# 481 "txInterpTest.cu"
 float __T261;
# 482 "txInterpTest.cu"
 float __T262;
# 483 "txInterpTest.cu"
 float __T263;
# 484 "txInterpTest.cu"
 float __T264;
# 452 "txInterpTest.cu"
 int __cuda_local_var_36527_6_non_const_x;
# 453 "txInterpTest.cu"
 int __cuda_local_var_36528_6_non_const_y;
# 454 "txInterpTest.cu"
 float __cuda_local_var_36529_8_non_const_xcoord;
# 455 "txInterpTest.cu"
 float __cuda_local_var_36530_8_non_const_ycoord;
# 456 "txInterpTest.cu"
 int __cuda_local_var_36531_6_non_const_j;
# 457 "txInterpTest.cu"
 int __cuda_local_var_36532_6_non_const_im;
# 458 "txInterpTest.cu"
 float __cuda_local_var_36533_8_non_const_f0;
# 458 "txInterpTest.cu"
 float __cuda_local_var_36533_11_non_const_f1;
# 458 "txInterpTest.cu"
 float __cuda_local_var_36533_14_non_const_f2;
# 458 "txInterpTest.cu"
 float __cuda_local_var_36533_17_non_const_f3;
# 458 "txInterpTest.cu"
 float __cuda_local_var_36533_20_non_const_f4;
# 458 "txInterpTest.cu"
 float __cuda_local_var_36533_23_non_const_f5;
# 458 "txInterpTest.cu"
 float __cuda_local_var_36533_26_non_const_f6;
# 458 "txInterpTest.cu"
 float __cuda_local_var_36533_29_non_const_f7;
# 458 "txInterpTest.cu"
 float __cuda_local_var_36533_32_non_const_f8;
# 459 "txInterpTest.cu"
static __attribute__((__used__)) __attribute__((shared)) float __cuda_local_var_36534_32_non_const_sumX[128];
# 459 "txInterpTest.cu"
static __attribute__((__used__)) __attribute__((shared)) float __cuda_local_var_36534_43_non_const_sumY[128];
# 460 "txInterpTest.cu"
static __attribute__((__used__)) __attribute__((shared)) int __cuda_local_var_36535_30_non_const_check[1];
# 452 "txInterpTest.cu"
__cuda_local_var_36527_6_non_const_x = ((int)((threadIdx.x) + ((blockIdx.x) * (blockDim.x))));
# 453 "txInterpTest.cu"
__cuda_local_var_36528_6_non_const_y = ((int)((threadIdx.y) + ((blockIdx.y) * (blockDim.y))));
# 454 "txInterpTest.cu"
__cuda_local_var_36529_8_non_const_xcoord = ((float)((415.625) + ((double)(((float)__cuda_local_var_36527_6_non_const_x) * (0.25F)))));
# 455 "txInterpTest.cu"
__cuda_local_var_36530_8_non_const_ycoord = ((float)((319.625) + ((double)(((float)__cuda_local_var_36528_6_non_const_y) * (0.25F)))));
# 456 "txInterpTest.cu"
__cuda_local_var_36531_6_non_const_j = ((int)(((unsigned long)__cuda_local_var_36527_6_non_const_x) + (((unsigned long)__cuda_local_var_36528_6_non_const_y) * pitch)));
# 457 "txInterpTest.cu"
__cuda_local_var_36532_6_non_const_im = (_Z8ImageFcnff(__cuda_local_var_36529_8_non_const_xcoord, __cuda_local_var_36530_8_non_const_ycoord));
# 461 "txInterpTest.cu"
((__cuda_local_var_36535_30_non_const_check)[0]) = 0;
# 462 "txInterpTest.cu"
{
# 462 "txInterpTest.cu"
__syncthreads();
# 462 "txInterpTest.cu"
}
# 464 "txInterpTest.cu"
if ((((__cuda_local_var_36527_6_non_const_x < 1) || (__cuda_local_var_36527_6_non_const_x > 766)) || (__cuda_local_var_36528_6_non_const_y < 1)) || (__cuda_local_var_36528_6_non_const_y > 510))
# 465 "txInterpTest.cu"
{
# 466 "txInterpTest.cu"
((__cuda_local_var_36534_32_non_const_sumX)[(threadIdx.x)]) = (0.0F);
# 467 "txInterpTest.cu"
((__cuda_local_var_36534_43_non_const_sumY)[(threadIdx.x)]) = (0.0F);
# 469 "txInterpTest.cu"
}
# 470 "txInterpTest.cu"
else
# 470 "txInterpTest.cu"
{
# 472 "txInterpTest.cu"
__cuda_local_var_36533_8_non_const_f0 = (fin[__cuda_local_var_36531_6_non_const_j]);
# 473 "txInterpTest.cu"
__cuda_local_var_36533_14_non_const_f2 = (fin[((int)((((unsigned long)__cuda_local_var_36527_6_non_const_x) + (((unsigned long)(__cuda_local_var_36528_6_non_const_y - 1)) * pitch)) + ((2UL * pitch) * 512UL)))]);
# 474 "txInterpTest.cu"
__cuda_local_var_36533_20_non_const_f4 = (fin[((int)((((unsigned long)__cuda_local_var_36527_6_non_const_x) + (((unsigned long)(__cuda_local_var_36528_6_non_const_y + 1)) * pitch)) + ((4UL * pitch) * 512UL)))]);
# 475 "txInterpTest.cu"
__cuda_local_var_36533_11_non_const_f1 = ((((__T231 = texRef_f1C) , ((void)(__T232 = (((float)(__cuda_local_var_36527_6_non_const_x - 1)) + (0.5F))))) , ((void)(__T233 = (((float)__cuda_local_var_36528_6_non_const_y) + (0.5F))))) , ((__T235 = (__ftexfetch2D(__T231, ((((((__T234.x) = __T232) , ((void)((__T234.y) = __T233))) , ((void)((__T234.z) = (0.0F)))) , ((void)((__T234.w) = (0.0F)))) , __T234)))) , (__T235.x)));
# 476 "txInterpTest.cu"
__cuda_local_var_36533_17_non_const_f3 = ((((__T236 = texRef_f3C) , ((void)(__T237 = (((float)(__cuda_local_var_36527_6_non_const_x + 1)) + (0.5F))))) , ((void)(__T238 = (((float)__cuda_local_var_36528_6_non_const_y) + (0.5F))))) , ((__T240 = (__ftexfetch2D(__T236, ((((((__T239.x) = __T237) , ((void)((__T239.y) = __T238))) , ((void)((__T239.z) = (0.0F)))) , ((void)((__T239.w) = (0.0F)))) , __T239)))) , (__T240.x)));
# 477 "txInterpTest.cu"
__cuda_local_var_36533_23_non_const_f5 = ((((__T241 = texRef_f5C) , ((void)(__T242 = (((float)(__cuda_local_var_36527_6_non_const_x - 1)) + (0.5F))))) , ((void)(__T243 = (((float)(__cuda_local_var_36528_6_non_const_y - 1)) + (0.5F))))) , ((__T245 = (__ftexfetch2D(__T241, ((((((__T244.x) = __T242) , ((void)((__T244.y) = __T243))) , ((void)((__T244.z) = (0.0F)))) , ((void)((__T244.w) = (0.0F)))) , __T244)))) , (__T245.x)));
# 478 "txInterpTest.cu"
__cuda_local_var_36533_26_non_const_f6 = ((((__T246 = texRef_f6C) , ((void)(__T247 = (((float)(__cuda_local_var_36527_6_non_const_x + 1)) + (0.5F))))) , ((void)(__T248 = (((float)(__cuda_local_var_36528_6_non_const_y - 1)) + (0.5F))))) , ((__T250 = (__ftexfetch2D(__T246, ((((((__T249.x) = __T247) , ((void)((__T249.y) = __T248))) , ((void)((__T249.z) = (0.0F)))) , ((void)((__T249.w) = (0.0F)))) , __T249)))) , (__T250.x)));
# 479 "txInterpTest.cu"
__cuda_local_var_36533_29_non_const_f7 = ((((__T251 = texRef_f7C) , ((void)(__T252 = (((float)(__cuda_local_var_36527_6_non_const_x + 1)) + (0.5F))))) , ((void)(__T253 = (((float)(__cuda_local_var_36528_6_non_const_y + 1)) + (0.5F))))) , ((__T255 = (__ftexfetch2D(__T251, ((((((__T254.x) = __T252) , ((void)((__T254.y) = __T253))) , ((void)((__T254.z) = (0.0F)))) , ((void)((__T254.w) = (0.0F)))) , __T254)))) , (__T255.x)));
# 480 "txInterpTest.cu"
__cuda_local_var_36533_32_non_const_f8 = ((((__T256 = texRef_f8C) , ((void)(__T257 = (((float)(__cuda_local_var_36527_6_non_const_x - 1)) + (0.5F))))) , ((void)(__T258 = (((float)(__cuda_local_var_36528_6_non_const_y + 1)) + (0.5F))))) , ((__T260 = (__ftexfetch2D(__T256, ((((((__T259.x) = __T257) , ((void)((__T259.y) = __T258))) , ((void)((__T259.z) = (0.0F)))) , ((void)((__T259.w) = (0.0F)))) , __T259)))) , (__T260.x)));
# 482 "txInterpTest.cu"
if ((__cuda_local_var_36532_6_non_const_im == 1) || (__cuda_local_var_36532_6_non_const_im == 10))
# 482 "txInterpTest.cu"
{
# 483 "txInterpTest.cu"
if (__cuda_local_var_36532_6_non_const_im == 10)
# 483 "txInterpTest.cu"
{
# 484 "txInterpTest.cu"
((__cuda_local_var_36535_30_non_const_check)[0]) = 1;
# 485 "txInterpTest.cu"
((__cuda_local_var_36534_32_non_const_sumX)[(threadIdx.x)]) = (((((((2.0F) * __cuda_local_var_36533_11_non_const_f1) - ((2.0F) * __cuda_local_var_36533_17_non_const_f3)) + ((2.0F) * __cuda_local_var_36533_23_non_const_f5)) + ((2.0F) * __cuda_local_var_36533_32_non_const_f8)) - ((2.0F) * __cuda_local_var_36533_26_non_const_f6)) - ((2.0F) * __cuda_local_var_36533_29_non_const_f7));
# 486 "txInterpTest.cu"
((__cuda_local_var_36534_43_non_const_sumY)[(threadIdx.x)]) = (((((((2.0F) * __cuda_local_var_36533_14_non_const_f2) - ((2.0F) * __cuda_local_var_36533_20_non_const_f4)) + ((2.0F) * __cuda_local_var_36533_23_non_const_f5)) - ((2.0F) * __cuda_local_var_36533_32_non_const_f8)) + ((2.0F) * __cuda_local_var_36533_26_non_const_f6)) - ((2.0F) * __cuda_local_var_36533_29_non_const_f7));
# 487 "txInterpTest.cu"
}
# 488 "txInterpTest.cu"
else
# 488 "txInterpTest.cu"
{
# 489 "txInterpTest.cu"
((__cuda_local_var_36534_32_non_const_sumX)[(threadIdx.x)]) = (0.0F);
# 490 "txInterpTest.cu"
((__cuda_local_var_36534_43_non_const_sumY)[(threadIdx.x)]) = (0.0F);
# 491 "txInterpTest.cu"
}
# 493 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36527_6_non_const_x) + (((unsigned long)__cuda_local_var_36528_6_non_const_y) * pitch)) + ((1UL * pitch) * 512UL)))]) = __cuda_local_var_36533_17_non_const_f3;
# 494 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36527_6_non_const_x) + (((unsigned long)__cuda_local_var_36528_6_non_const_y) * pitch)) + ((2UL * pitch) * 512UL)))]) = __cuda_local_var_36533_20_non_const_f4;
# 495 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36527_6_non_const_x) + (((unsigned long)__cuda_local_var_36528_6_non_const_y) * pitch)) + ((3UL * pitch) * 512UL)))]) = __cuda_local_var_36533_11_non_const_f1;
# 496 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36527_6_non_const_x) + (((unsigned long)__cuda_local_var_36528_6_non_const_y) * pitch)) + ((4UL * pitch) * 512UL)))]) = __cuda_local_var_36533_14_non_const_f2;
# 497 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36527_6_non_const_x) + (((unsigned long)__cuda_local_var_36528_6_non_const_y) * pitch)) + ((5UL * pitch) * 512UL)))]) = __cuda_local_var_36533_29_non_const_f7;
# 498 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36527_6_non_const_x) + (((unsigned long)__cuda_local_var_36528_6_non_const_y) * pitch)) + ((6UL * pitch) * 512UL)))]) = __cuda_local_var_36533_32_non_const_f8;
# 499 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36527_6_non_const_x) + (((unsigned long)__cuda_local_var_36528_6_non_const_y) * pitch)) + ((7UL * pitch) * 512UL)))]) = __cuda_local_var_36533_23_non_const_f5;
# 500 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36527_6_non_const_x) + (((unsigned long)__cuda_local_var_36528_6_non_const_y) * pitch)) + ((8UL * pitch) * 512UL)))]) = __cuda_local_var_36533_26_non_const_f6;
# 501 "txInterpTest.cu"
}
# 502 "txInterpTest.cu"
else
# 502 "txInterpTest.cu"
{
# 503 "txInterpTest.cu"
((__cuda_local_var_36534_32_non_const_sumX)[(threadIdx.x)]) = (0.0F);
# 504 "txInterpTest.cu"
((__cuda_local_var_36534_43_non_const_sumY)[(threadIdx.x)]) = (0.0F);
# 505 "txInterpTest.cu"
if (((const char *)"BGK") == ((const char *)"MRT"))
# 505 "txInterpTest.cu"
{
# 506 "txInterpTest.cu"
_Z11mrt_collideRfS_S_S_S_S_S_S_S_f((&__cuda_local_var_36533_8_non_const_f0), (&__cuda_local_var_36533_11_non_const_f1), (&__cuda_local_var_36533_14_non_const_f2), (&__cuda_local_var_36533_17_non_const_f3), (&__cuda_local_var_36533_20_non_const_f4), (&__cuda_local_var_36533_23_non_const_f5), (&__cuda_local_var_36533_26_non_const_f6), (&__cuda_local_var_36533_29_non_const_f7), (&__cuda_local_var_36533_32_non_const_f8), omega);
# 506 "txInterpTest.cu"
}
# 506 "txInterpTest.cu"
else
# 506 "txInterpTest.cu"
{
# 507 "txInterpTest.cu"
if (1)
# 507 "txInterpTest.cu"
{
# 508 "txInterpTest.cu"
{
# 508 "txInterpTest.cu"
__T261 = ((((((((__cuda_local_var_36533_8_non_const_f0 + __cuda_local_var_36533_11_non_const_f1) + __cuda_local_var_36533_14_non_const_f2) + __cuda_local_var_36533_17_non_const_f3) + __cuda_local_var_36533_20_non_const_f4) + __cuda_local_var_36533_23_non_const_f5) + __cuda_local_var_36533_26_non_const_f6) + __cuda_local_var_36533_29_non_const_f7) + __cuda_local_var_36533_32_non_const_f8);
# 508 "txInterpTest.cu"
__T262 = (((((__cuda_local_var_36533_11_non_const_f1 - __cuda_local_var_36533_17_non_const_f3) + __cuda_local_var_36533_23_non_const_f5) - __cuda_local_var_36533_26_non_const_f6) - __cuda_local_var_36533_29_non_const_f7) + __cuda_local_var_36533_32_non_const_f8);
# 508 "txInterpTest.cu"
__T263 = (((((__cuda_local_var_36533_14_non_const_f2 - __cuda_local_var_36533_20_non_const_f4) + __cuda_local_var_36533_23_non_const_f5) + __cuda_local_var_36533_26_non_const_f6) - __cuda_local_var_36533_29_non_const_f7) - __cuda_local_var_36533_32_non_const_f8);
# 508 "txInterpTest.cu"
__T264 = ((__T262 * __T262) + (__T263 * __T263));
# 508 "txInterpTest.cu"
__cuda_local_var_36533_8_non_const_f0 = (__cuda_local_var_36533_8_non_const_f0 - (omega * (__cuda_local_var_36533_8_non_const_f0 - ((0.4444444478F) * (__T261 - ((1.5F) * __T264))))));
# 508 "txInterpTest.cu"
__cuda_local_var_36533_11_non_const_f1 = (__cuda_local_var_36533_11_non_const_f1 - (omega * (__cuda_local_var_36533_11_non_const_f1 - ((0.1111111119F) * (((__T261 + ((3.0F) * __T262)) + (((4.5F) * __T262) * __T262)) - ((1.5F) * __T264))))));
# 508 "txInterpTest.cu"
__cuda_local_var_36533_14_non_const_f2 = (__cuda_local_var_36533_14_non_const_f2 - (omega * (__cuda_local_var_36533_14_non_const_f2 - ((0.1111111119F) * (((__T261 + ((3.0F) * __T263)) + (((4.5F) * __T263) * __T263)) - ((1.5F) * __T264))))));
# 508 "txInterpTest.cu"
__cuda_local_var_36533_17_non_const_f3 = (__cuda_local_var_36533_17_non_const_f3 - (omega * (__cuda_local_var_36533_17_non_const_f3 - ((0.1111111119F) * (((__T261 - ((3.0F) * __T262)) + (((4.5F) * __T262) * __T262)) - ((1.5F) * __T264))))));
# 508 "txInterpTest.cu"
__cuda_local_var_36533_20_non_const_f4 = (__cuda_local_var_36533_20_non_const_f4 - (omega * (__cuda_local_var_36533_20_non_const_f4 - ((0.1111111119F) * (((__T261 - ((3.0F) * __T263)) + (((4.5F) * __T263) * __T263)) - ((1.5F) * __T264))))));
# 508 "txInterpTest.cu"
__cuda_local_var_36533_23_non_const_f5 = ((float)(((double)__cuda_local_var_36533_23_non_const_f5) - (((double)omega) * (((double)__cuda_local_var_36533_23_non_const_f5) - ((0.02777777777999999864) * ((double)(((__T261 + ((3.0F) * (__T262 + __T263))) + (((4.5F) * (__T262 + __T263)) * (__T262 + __T263))) - ((1.5F) * __T264))))))));
# 508 "txInterpTest.cu"
__cuda_local_var_36533_26_non_const_f6 = ((float)(((double)__cuda_local_var_36533_26_non_const_f6) - (((double)omega) * (((double)__cuda_local_var_36533_26_non_const_f6) - ((0.02777777777999999864) * ((double)(((__T261 + ((3.0F) * ((-__T262) + __T263))) + (((4.5F) * ((-__T262) + __T263)) * ((-__T262) + __T263))) - ((1.5F) * __T264))))))));
# 508 "txInterpTest.cu"
__cuda_local_var_36533_29_non_const_f7 = ((float)(((double)__cuda_local_var_36533_29_non_const_f7) - (((double)omega) * (((double)__cuda_local_var_36533_29_non_const_f7) - ((0.02777777777999999864) * ((double)(((__T261 + ((3.0F) * ((-__T262) - __T263))) + (((4.5F) * ((-__T262) - __T263)) * ((-__T262) - __T263))) - ((1.5F) * __T264))))))));
# 508 "txInterpTest.cu"
__cuda_local_var_36533_32_non_const_f8 = ((float)(((double)__cuda_local_var_36533_32_non_const_f8) - (((double)omega) * (((double)__cuda_local_var_36533_32_non_const_f8) - ((0.02777777777999999864) * ((double)(((__T261 + ((3.0F) * (__T262 - __T263))) + (((4.5F) * (__T262 - __T263)) * (__T262 - __T263))) - ((1.5F) * __T264))))))));
# 508 "txInterpTest.cu"
}
# 508 "txInterpTest.cu"
}
# 508 "txInterpTest.cu"
}
# 509 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36527_6_non_const_x) + (((unsigned long)__cuda_local_var_36528_6_non_const_y) * pitch)) + ((0UL * pitch) * 512UL)))]) = __cuda_local_var_36533_8_non_const_f0;
# 510 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36527_6_non_const_x) + (((unsigned long)__cuda_local_var_36528_6_non_const_y) * pitch)) + ((1UL * pitch) * 512UL)))]) = __cuda_local_var_36533_11_non_const_f1;
# 511 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36527_6_non_const_x) + (((unsigned long)__cuda_local_var_36528_6_non_const_y) * pitch)) + ((2UL * pitch) * 512UL)))]) = __cuda_local_var_36533_14_non_const_f2;
# 512 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36527_6_non_const_x) + (((unsigned long)__cuda_local_var_36528_6_non_const_y) * pitch)) + ((3UL * pitch) * 512UL)))]) = __cuda_local_var_36533_17_non_const_f3;
# 513 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36527_6_non_const_x) + (((unsigned long)__cuda_local_var_36528_6_non_const_y) * pitch)) + ((4UL * pitch) * 512UL)))]) = __cuda_local_var_36533_20_non_const_f4;
# 514 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36527_6_non_const_x) + (((unsigned long)__cuda_local_var_36528_6_non_const_y) * pitch)) + ((5UL * pitch) * 512UL)))]) = __cuda_local_var_36533_23_non_const_f5;
# 515 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36527_6_non_const_x) + (((unsigned long)__cuda_local_var_36528_6_non_const_y) * pitch)) + ((6UL * pitch) * 512UL)))]) = __cuda_local_var_36533_26_non_const_f6;
# 516 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36527_6_non_const_x) + (((unsigned long)__cuda_local_var_36528_6_non_const_y) * pitch)) + ((7UL * pitch) * 512UL)))]) = __cuda_local_var_36533_29_non_const_f7;
# 517 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36527_6_non_const_x) + (((unsigned long)__cuda_local_var_36528_6_non_const_y) * pitch)) + ((8UL * pitch) * 512UL)))]) = __cuda_local_var_36533_32_non_const_f8;
# 518 "txInterpTest.cu"
}
# 520 "txInterpTest.cu"
}
# 522 "txInterpTest.cu"
{
# 522 "txInterpTest.cu"
__syncthreads();
# 522 "txInterpTest.cu"
}
# 523 "txInterpTest.cu"
if ((((__cuda_local_var_36535_30_non_const_check)[0]) == 1) && (((long)t) > 10000000000L))
# 523 "txInterpTest.cu"
{
# 525 "txInterpTest.cu"
 int __cuda_local_var_36600_6_non_const_nTotalThreads;
# 525 "txInterpTest.cu"
__cuda_local_var_36600_6_non_const_nTotalThreads = ((int)(blockDim.x));
# 526 "txInterpTest.cu"
while (__cuda_local_var_36600_6_non_const_nTotalThreads > 1)
# 526 "txInterpTest.cu"
{
# 527 "txInterpTest.cu"
 int __cuda_local_var_36602_7_non_const_halfPoint;
# 527 "txInterpTest.cu"
__cuda_local_var_36602_7_non_const_halfPoint = (__cuda_local_var_36600_6_non_const_nTotalThreads >> 1);
# 528 "txInterpTest.cu"
if ((threadIdx.x) < ((unsigned)__cuda_local_var_36602_7_non_const_halfPoint))
# 528 "txInterpTest.cu"
{
# 529 "txInterpTest.cu"
((__cuda_local_var_36534_32_non_const_sumX)[(threadIdx.x)]) += ((__cuda_local_var_36534_32_non_const_sumX)[((threadIdx.x) + ((unsigned)__cuda_local_var_36602_7_non_const_halfPoint))]);
# 530 "txInterpTest.cu"
((__cuda_local_var_36534_43_non_const_sumY)[(threadIdx.x)]) += ((__cuda_local_var_36534_43_non_const_sumY)[((threadIdx.x) + ((unsigned)__cuda_local_var_36602_7_non_const_halfPoint))]);
# 531 "txInterpTest.cu"
}
# 532 "txInterpTest.cu"
{
# 532 "txInterpTest.cu"
__syncthreads();
# 532 "txInterpTest.cu"
}
# 533 "txInterpTest.cu"
__cuda_local_var_36600_6_non_const_nTotalThreads = __cuda_local_var_36602_7_non_const_halfPoint;
# 534 "txInterpTest.cu"
}
# 535 "txInterpTest.cu"
if ((threadIdx.x) == 0U)
# 535 "txInterpTest.cu"
{
# 536 "txInterpTest.cu"
_Z9atomicAddPff((FX + t), ((__cuda_local_var_36534_32_non_const_sumX)[0]));
# 537 "txInterpTest.cu"
_Z9atomicAddPff((FY + t), ((__cuda_local_var_36534_43_non_const_sumY)[0]));
# 538 "txInterpTest.cu"
}
# 539 "txInterpTest.cu"
}
# 541 "txInterpTest.cu"
}
# 541 "txInterpTest.cu"
}}
# 543 "txInterpTest.cu"
__attribute__((global)) __attribute__((__used__)) void _Z18LR_d_hybBACD_forcePfS_fmS_S_i(
# 543 "txInterpTest.cu"
float *fin,
# 543 "txInterpTest.cu"
float *fout,
# 544 "txInterpTest.cu"
float omega,
# 544 "txInterpTest.cu"
size_t pitch,
# 544 "txInterpTest.cu"
float *FX,
# 544 "txInterpTest.cu"
float *FY,
# 544 "txInterpTest.cu"
int t){
# 544 "txInterpTest.cu"
{
# 545 "txInterpTest.cu"
{
# 545 "txInterpTest.cu"
 __texture_type__ __T265;
# 546 "txInterpTest.cu"
 float __T266;
# 547 "txInterpTest.cu"
 float __T267;
# 548 "txInterpTest.cu"
 float4 __T268;
# 549 "txInterpTest.cu"
 float4 __T269;
# 550 "txInterpTest.cu"
 __texture_type__ __T270;
# 551 "txInterpTest.cu"
 float __T271;
# 552 "txInterpTest.cu"
 float __T272;
# 553 "txInterpTest.cu"
 float4 __T273;
# 554 "txInterpTest.cu"
 float4 __T274;
# 555 "txInterpTest.cu"
 __texture_type__ __T275;
# 556 "txInterpTest.cu"
 float __T276;
# 557 "txInterpTest.cu"
 float __T277;
# 558 "txInterpTest.cu"
 float4 __T278;
# 559 "txInterpTest.cu"
 float4 __T279;
# 560 "txInterpTest.cu"
 __texture_type__ __T280;
# 561 "txInterpTest.cu"
 float __T281;
# 562 "txInterpTest.cu"
 float __T282;
# 563 "txInterpTest.cu"
 float4 __T283;
# 564 "txInterpTest.cu"
 float4 __T284;
# 565 "txInterpTest.cu"
 __texture_type__ __T285;
# 566 "txInterpTest.cu"
 float __T286;
# 567 "txInterpTest.cu"
 float __T287;
# 568 "txInterpTest.cu"
 float4 __T288;
# 569 "txInterpTest.cu"
 float4 __T289;
# 570 "txInterpTest.cu"
 __texture_type__ __T290;
# 571 "txInterpTest.cu"
 float __T291;
# 572 "txInterpTest.cu"
 float __T292;
# 573 "txInterpTest.cu"
 float4 __T293;
# 574 "txInterpTest.cu"
 float4 __T294;
# 575 "txInterpTest.cu"
 float __T295;
# 576 "txInterpTest.cu"
 float __T296;
# 577 "txInterpTest.cu"
 float __T297;
# 578 "txInterpTest.cu"
 float __T298;
# 546 "txInterpTest.cu"
 int __cuda_local_var_36621_6_non_const_x;
# 547 "txInterpTest.cu"
 int __cuda_local_var_36622_6_non_const_y;
# 548 "txInterpTest.cu"
 float __cuda_local_var_36623_8_non_const_xcoord;
# 549 "txInterpTest.cu"
 float __cuda_local_var_36624_8_non_const_ycoord;
# 550 "txInterpTest.cu"
 int __cuda_local_var_36625_6_non_const_j;
# 551 "txInterpTest.cu"
 int __cuda_local_var_36626_6_non_const_im;
# 552 "txInterpTest.cu"
 float __cuda_local_var_36627_8_non_const_f0;
# 552 "txInterpTest.cu"
 float __cuda_local_var_36627_11_non_const_f1;
# 552 "txInterpTest.cu"
 float __cuda_local_var_36627_14_non_const_f2;
# 552 "txInterpTest.cu"
 float __cuda_local_var_36627_17_non_const_f3;
# 552 "txInterpTest.cu"
 float __cuda_local_var_36627_20_non_const_f4;
# 552 "txInterpTest.cu"
 float __cuda_local_var_36627_23_non_const_f5;
# 552 "txInterpTest.cu"
 float __cuda_local_var_36627_26_non_const_f6;
# 552 "txInterpTest.cu"
 float __cuda_local_var_36627_29_non_const_f7;
# 552 "txInterpTest.cu"
 float __cuda_local_var_36627_32_non_const_f8;
# 553 "txInterpTest.cu"
static __attribute__((__used__)) __attribute__((shared)) float __cuda_local_var_36628_32_non_const_sumX[128];
# 553 "txInterpTest.cu"
static __attribute__((__used__)) __attribute__((shared)) float __cuda_local_var_36628_43_non_const_sumY[128];
# 554 "txInterpTest.cu"
static __attribute__((__used__)) __attribute__((shared)) int __cuda_local_var_36629_30_non_const_check[1];
# 546 "txInterpTest.cu"
__cuda_local_var_36621_6_non_const_x = ((int)((threadIdx.x) + ((blockIdx.x) * (blockDim.x))));
# 547 "txInterpTest.cu"
__cuda_local_var_36622_6_non_const_y = ((int)((threadIdx.y) + ((blockIdx.y) * (blockDim.y))));
# 548 "txInterpTest.cu"
__cuda_local_var_36623_8_non_const_xcoord = ((float)((415.625) + ((double)(((float)__cuda_local_var_36621_6_non_const_x) * (0.25F)))));
# 549 "txInterpTest.cu"
__cuda_local_var_36624_8_non_const_ycoord = ((float)((319.625) + ((double)(((float)__cuda_local_var_36622_6_non_const_y) * (0.25F)))));
# 550 "txInterpTest.cu"
__cuda_local_var_36625_6_non_const_j = ((int)(((unsigned long)__cuda_local_var_36621_6_non_const_x) + (((unsigned long)__cuda_local_var_36622_6_non_const_y) * pitch)));
# 551 "txInterpTest.cu"
__cuda_local_var_36626_6_non_const_im = (_Z8ImageFcnff(__cuda_local_var_36623_8_non_const_xcoord, __cuda_local_var_36624_8_non_const_ycoord));
# 555 "txInterpTest.cu"
((__cuda_local_var_36629_30_non_const_check)[0]) = 0;
# 556 "txInterpTest.cu"
{
# 556 "txInterpTest.cu"
__syncthreads();
# 556 "txInterpTest.cu"
}
# 558 "txInterpTest.cu"
if ((((__cuda_local_var_36621_6_non_const_x < 1) || (__cuda_local_var_36621_6_non_const_x > 766)) || (__cuda_local_var_36622_6_non_const_y < 1)) || (__cuda_local_var_36622_6_non_const_y > 510))
# 559 "txInterpTest.cu"
{
# 560 "txInterpTest.cu"
((__cuda_local_var_36628_32_non_const_sumX)[(threadIdx.x)]) = (0.0F);
# 561 "txInterpTest.cu"
((__cuda_local_var_36628_43_non_const_sumY)[(threadIdx.x)]) = (0.0F);
# 563 "txInterpTest.cu"
}
# 564 "txInterpTest.cu"
else
# 564 "txInterpTest.cu"
{
# 566 "txInterpTest.cu"
__cuda_local_var_36627_8_non_const_f0 = (fin[__cuda_local_var_36625_6_non_const_j]);
# 567 "txInterpTest.cu"
__cuda_local_var_36627_14_non_const_f2 = (fin[((int)((((unsigned long)__cuda_local_var_36621_6_non_const_x) + (((unsigned long)(__cuda_local_var_36622_6_non_const_y - 1)) * pitch)) + ((2UL * pitch) * 512UL)))]);
# 568 "txInterpTest.cu"
__cuda_local_var_36627_20_non_const_f4 = (fin[((int)((((unsigned long)__cuda_local_var_36621_6_non_const_x) + (((unsigned long)(__cuda_local_var_36622_6_non_const_y + 1)) * pitch)) + ((4UL * pitch) * 512UL)))]);
# 569 "txInterpTest.cu"
__cuda_local_var_36627_11_non_const_f1 = ((((__T265 = texRef_f1C) , ((void)(__T266 = (((float)(__cuda_local_var_36621_6_non_const_x - 1)) + (0.5F))))) , ((void)(__T267 = (((float)__cuda_local_var_36622_6_non_const_y) + (0.5F))))) , ((__T269 = (__ftexfetch2D(__T265, ((((((__T268.x) = __T266) , ((void)((__T268.y) = __T267))) , ((void)((__T268.z) = (0.0F)))) , ((void)((__T268.w) = (0.0F)))) , __T268)))) , (__T269.x)));
# 570 "txInterpTest.cu"
__cuda_local_var_36627_17_non_const_f3 = ((((__T270 = texRef_f3C) , ((void)(__T271 = (((float)(__cuda_local_var_36621_6_non_const_x + 1)) + (0.5F))))) , ((void)(__T272 = (((float)__cuda_local_var_36622_6_non_const_y) + (0.5F))))) , ((__T274 = (__ftexfetch2D(__T270, ((((((__T273.x) = __T271) , ((void)((__T273.y) = __T272))) , ((void)((__T273.z) = (0.0F)))) , ((void)((__T273.w) = (0.0F)))) , __T273)))) , (__T274.x)));
# 571 "txInterpTest.cu"
__cuda_local_var_36627_23_non_const_f5 = ((((__T275 = texRef_f5C) , ((void)(__T276 = (((float)(__cuda_local_var_36621_6_non_const_x - 1)) + (0.5F))))) , ((void)(__T277 = (((float)(__cuda_local_var_36622_6_non_const_y - 1)) + (0.5F))))) , ((__T279 = (__ftexfetch2D(__T275, ((((((__T278.x) = __T276) , ((void)((__T278.y) = __T277))) , ((void)((__T278.z) = (0.0F)))) , ((void)((__T278.w) = (0.0F)))) , __T278)))) , (__T279.x)));
# 572 "txInterpTest.cu"
__cuda_local_var_36627_26_non_const_f6 = ((((__T280 = texRef_f6C) , ((void)(__T281 = (((float)(__cuda_local_var_36621_6_non_const_x + 1)) + (0.5F))))) , ((void)(__T282 = (((float)(__cuda_local_var_36622_6_non_const_y - 1)) + (0.5F))))) , ((__T284 = (__ftexfetch2D(__T280, ((((((__T283.x) = __T281) , ((void)((__T283.y) = __T282))) , ((void)((__T283.z) = (0.0F)))) , ((void)((__T283.w) = (0.0F)))) , __T283)))) , (__T284.x)));
# 573 "txInterpTest.cu"
__cuda_local_var_36627_29_non_const_f7 = ((((__T285 = texRef_f7C) , ((void)(__T286 = (((float)(__cuda_local_var_36621_6_non_const_x + 1)) + (0.5F))))) , ((void)(__T287 = (((float)(__cuda_local_var_36622_6_non_const_y + 1)) + (0.5F))))) , ((__T289 = (__ftexfetch2D(__T285, ((((((__T288.x) = __T286) , ((void)((__T288.y) = __T287))) , ((void)((__T288.z) = (0.0F)))) , ((void)((__T288.w) = (0.0F)))) , __T288)))) , (__T289.x)));
# 574 "txInterpTest.cu"
__cuda_local_var_36627_32_non_const_f8 = ((((__T290 = texRef_f8C) , ((void)(__T291 = (((float)(__cuda_local_var_36621_6_non_const_x - 1)) + (0.5F))))) , ((void)(__T292 = (((float)(__cuda_local_var_36622_6_non_const_y + 1)) + (0.5F))))) , ((__T294 = (__ftexfetch2D(__T290, ((((((__T293.x) = __T291) , ((void)((__T293.y) = __T292))) , ((void)((__T293.z) = (0.0F)))) , ((void)((__T293.w) = (0.0F)))) , __T293)))) , (__T294.x)));
# 576 "txInterpTest.cu"
if ((__cuda_local_var_36626_6_non_const_im == 1) || (__cuda_local_var_36626_6_non_const_im == 10))
# 576 "txInterpTest.cu"
{
# 577 "txInterpTest.cu"
if (__cuda_local_var_36626_6_non_const_im == 10)
# 577 "txInterpTest.cu"
{
# 578 "txInterpTest.cu"
((__cuda_local_var_36629_30_non_const_check)[0]) = 1;
# 579 "txInterpTest.cu"
((__cuda_local_var_36628_32_non_const_sumX)[(threadIdx.x)]) = (((((((2.0F) * __cuda_local_var_36627_11_non_const_f1) - ((2.0F) * __cuda_local_var_36627_17_non_const_f3)) + ((2.0F) * __cuda_local_var_36627_23_non_const_f5)) + ((2.0F) * __cuda_local_var_36627_32_non_const_f8)) - ((2.0F) * __cuda_local_var_36627_26_non_const_f6)) - ((2.0F) * __cuda_local_var_36627_29_non_const_f7));
# 580 "txInterpTest.cu"
((__cuda_local_var_36628_43_non_const_sumY)[(threadIdx.x)]) = (((((((2.0F) * __cuda_local_var_36627_14_non_const_f2) - ((2.0F) * __cuda_local_var_36627_20_non_const_f4)) + ((2.0F) * __cuda_local_var_36627_23_non_const_f5)) - ((2.0F) * __cuda_local_var_36627_32_non_const_f8)) + ((2.0F) * __cuda_local_var_36627_26_non_const_f6)) - ((2.0F) * __cuda_local_var_36627_29_non_const_f7));
# 581 "txInterpTest.cu"
}
# 582 "txInterpTest.cu"
else
# 582 "txInterpTest.cu"
{
# 583 "txInterpTest.cu"
((__cuda_local_var_36628_32_non_const_sumX)[(threadIdx.x)]) = (0.0F);
# 584 "txInterpTest.cu"
((__cuda_local_var_36628_43_non_const_sumY)[(threadIdx.x)]) = (0.0F);
# 585 "txInterpTest.cu"
}
# 587 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36621_6_non_const_x) + (((unsigned long)__cuda_local_var_36622_6_non_const_y) * pitch)) + ((1UL * pitch) * 512UL)))]) = __cuda_local_var_36627_17_non_const_f3;
# 588 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36621_6_non_const_x) + (((unsigned long)__cuda_local_var_36622_6_non_const_y) * pitch)) + ((2UL * pitch) * 512UL)))]) = __cuda_local_var_36627_20_non_const_f4;
# 589 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36621_6_non_const_x) + (((unsigned long)__cuda_local_var_36622_6_non_const_y) * pitch)) + ((3UL * pitch) * 512UL)))]) = __cuda_local_var_36627_11_non_const_f1;
# 590 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36621_6_non_const_x) + (((unsigned long)__cuda_local_var_36622_6_non_const_y) * pitch)) + ((4UL * pitch) * 512UL)))]) = __cuda_local_var_36627_14_non_const_f2;
# 591 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36621_6_non_const_x) + (((unsigned long)__cuda_local_var_36622_6_non_const_y) * pitch)) + ((5UL * pitch) * 512UL)))]) = __cuda_local_var_36627_29_non_const_f7;
# 592 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36621_6_non_const_x) + (((unsigned long)__cuda_local_var_36622_6_non_const_y) * pitch)) + ((6UL * pitch) * 512UL)))]) = __cuda_local_var_36627_32_non_const_f8;
# 593 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36621_6_non_const_x) + (((unsigned long)__cuda_local_var_36622_6_non_const_y) * pitch)) + ((7UL * pitch) * 512UL)))]) = __cuda_local_var_36627_23_non_const_f5;
# 594 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36621_6_non_const_x) + (((unsigned long)__cuda_local_var_36622_6_non_const_y) * pitch)) + ((8UL * pitch) * 512UL)))]) = __cuda_local_var_36627_26_non_const_f6;
# 595 "txInterpTest.cu"
}
# 596 "txInterpTest.cu"
else
# 596 "txInterpTest.cu"
{
# 597 "txInterpTest.cu"
((__cuda_local_var_36628_32_non_const_sumX)[(threadIdx.x)]) = (0.0F);
# 598 "txInterpTest.cu"
((__cuda_local_var_36628_43_non_const_sumY)[(threadIdx.x)]) = (0.0F);
# 599 "txInterpTest.cu"
if (((const char *)"BGK") == ((const char *)"MRT"))
# 599 "txInterpTest.cu"
{
# 600 "txInterpTest.cu"
_Z11mrt_collideRfS_S_S_S_S_S_S_S_f((&__cuda_local_var_36627_8_non_const_f0), (&__cuda_local_var_36627_11_non_const_f1), (&__cuda_local_var_36627_14_non_const_f2), (&__cuda_local_var_36627_17_non_const_f3), (&__cuda_local_var_36627_20_non_const_f4), (&__cuda_local_var_36627_23_non_const_f5), (&__cuda_local_var_36627_26_non_const_f6), (&__cuda_local_var_36627_29_non_const_f7), (&__cuda_local_var_36627_32_non_const_f8), omega);
# 600 "txInterpTest.cu"
}
# 600 "txInterpTest.cu"
else
# 600 "txInterpTest.cu"
{
# 601 "txInterpTest.cu"
if (1)
# 601 "txInterpTest.cu"
{
# 602 "txInterpTest.cu"
{
# 602 "txInterpTest.cu"
__T295 = ((((((((__cuda_local_var_36627_8_non_const_f0 + __cuda_local_var_36627_11_non_const_f1) + __cuda_local_var_36627_14_non_const_f2) + __cuda_local_var_36627_17_non_const_f3) + __cuda_local_var_36627_20_non_const_f4) + __cuda_local_var_36627_23_non_const_f5) + __cuda_local_var_36627_26_non_const_f6) + __cuda_local_var_36627_29_non_const_f7) + __cuda_local_var_36627_32_non_const_f8);
# 602 "txInterpTest.cu"
__T296 = (((((__cuda_local_var_36627_11_non_const_f1 - __cuda_local_var_36627_17_non_const_f3) + __cuda_local_var_36627_23_non_const_f5) - __cuda_local_var_36627_26_non_const_f6) - __cuda_local_var_36627_29_non_const_f7) + __cuda_local_var_36627_32_non_const_f8);
# 602 "txInterpTest.cu"
__T297 = (((((__cuda_local_var_36627_14_non_const_f2 - __cuda_local_var_36627_20_non_const_f4) + __cuda_local_var_36627_23_non_const_f5) + __cuda_local_var_36627_26_non_const_f6) - __cuda_local_var_36627_29_non_const_f7) - __cuda_local_var_36627_32_non_const_f8);
# 602 "txInterpTest.cu"
__T298 = ((__T296 * __T296) + (__T297 * __T297));
# 602 "txInterpTest.cu"
__cuda_local_var_36627_8_non_const_f0 = (__cuda_local_var_36627_8_non_const_f0 - (omega * (__cuda_local_var_36627_8_non_const_f0 - ((0.4444444478F) * (__T295 - ((1.5F) * __T298))))));
# 602 "txInterpTest.cu"
__cuda_local_var_36627_11_non_const_f1 = (__cuda_local_var_36627_11_non_const_f1 - (omega * (__cuda_local_var_36627_11_non_const_f1 - ((0.1111111119F) * (((__T295 + ((3.0F) * __T296)) + (((4.5F) * __T296) * __T296)) - ((1.5F) * __T298))))));
# 602 "txInterpTest.cu"
__cuda_local_var_36627_14_non_const_f2 = (__cuda_local_var_36627_14_non_const_f2 - (omega * (__cuda_local_var_36627_14_non_const_f2 - ((0.1111111119F) * (((__T295 + ((3.0F) * __T297)) + (((4.5F) * __T297) * __T297)) - ((1.5F) * __T298))))));
# 602 "txInterpTest.cu"
__cuda_local_var_36627_17_non_const_f3 = (__cuda_local_var_36627_17_non_const_f3 - (omega * (__cuda_local_var_36627_17_non_const_f3 - ((0.1111111119F) * (((__T295 - ((3.0F) * __T296)) + (((4.5F) * __T296) * __T296)) - ((1.5F) * __T298))))));
# 602 "txInterpTest.cu"
__cuda_local_var_36627_20_non_const_f4 = (__cuda_local_var_36627_20_non_const_f4 - (omega * (__cuda_local_var_36627_20_non_const_f4 - ((0.1111111119F) * (((__T295 - ((3.0F) * __T297)) + (((4.5F) * __T297) * __T297)) - ((1.5F) * __T298))))));
# 602 "txInterpTest.cu"
__cuda_local_var_36627_23_non_const_f5 = ((float)(((double)__cuda_local_var_36627_23_non_const_f5) - (((double)omega) * (((double)__cuda_local_var_36627_23_non_const_f5) - ((0.02777777777999999864) * ((double)(((__T295 + ((3.0F) * (__T296 + __T297))) + (((4.5F) * (__T296 + __T297)) * (__T296 + __T297))) - ((1.5F) * __T298))))))));
# 602 "txInterpTest.cu"
__cuda_local_var_36627_26_non_const_f6 = ((float)(((double)__cuda_local_var_36627_26_non_const_f6) - (((double)omega) * (((double)__cuda_local_var_36627_26_non_const_f6) - ((0.02777777777999999864) * ((double)(((__T295 + ((3.0F) * ((-__T296) + __T297))) + (((4.5F) * ((-__T296) + __T297)) * ((-__T296) + __T297))) - ((1.5F) * __T298))))))));
# 602 "txInterpTest.cu"
__cuda_local_var_36627_29_non_const_f7 = ((float)(((double)__cuda_local_var_36627_29_non_const_f7) - (((double)omega) * (((double)__cuda_local_var_36627_29_non_const_f7) - ((0.02777777777999999864) * ((double)(((__T295 + ((3.0F) * ((-__T296) - __T297))) + (((4.5F) * ((-__T296) - __T297)) * ((-__T296) - __T297))) - ((1.5F) * __T298))))))));
# 602 "txInterpTest.cu"
__cuda_local_var_36627_32_non_const_f8 = ((float)(((double)__cuda_local_var_36627_32_non_const_f8) - (((double)omega) * (((double)__cuda_local_var_36627_32_non_const_f8) - ((0.02777777777999999864) * ((double)(((__T295 + ((3.0F) * (__T296 - __T297))) + (((4.5F) * (__T296 - __T297)) * (__T296 - __T297))) - ((1.5F) * __T298))))))));
# 602 "txInterpTest.cu"
}
# 602 "txInterpTest.cu"
}
# 602 "txInterpTest.cu"
}
# 603 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36621_6_non_const_x) + (((unsigned long)__cuda_local_var_36622_6_non_const_y) * pitch)) + ((0UL * pitch) * 512UL)))]) = __cuda_local_var_36627_8_non_const_f0;
# 604 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36621_6_non_const_x) + (((unsigned long)__cuda_local_var_36622_6_non_const_y) * pitch)) + ((1UL * pitch) * 512UL)))]) = __cuda_local_var_36627_11_non_const_f1;
# 605 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36621_6_non_const_x) + (((unsigned long)__cuda_local_var_36622_6_non_const_y) * pitch)) + ((2UL * pitch) * 512UL)))]) = __cuda_local_var_36627_14_non_const_f2;
# 606 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36621_6_non_const_x) + (((unsigned long)__cuda_local_var_36622_6_non_const_y) * pitch)) + ((3UL * pitch) * 512UL)))]) = __cuda_local_var_36627_17_non_const_f3;
# 607 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36621_6_non_const_x) + (((unsigned long)__cuda_local_var_36622_6_non_const_y) * pitch)) + ((4UL * pitch) * 512UL)))]) = __cuda_local_var_36627_20_non_const_f4;
# 608 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36621_6_non_const_x) + (((unsigned long)__cuda_local_var_36622_6_non_const_y) * pitch)) + ((5UL * pitch) * 512UL)))]) = __cuda_local_var_36627_23_non_const_f5;
# 609 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36621_6_non_const_x) + (((unsigned long)__cuda_local_var_36622_6_non_const_y) * pitch)) + ((6UL * pitch) * 512UL)))]) = __cuda_local_var_36627_26_non_const_f6;
# 610 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36621_6_non_const_x) + (((unsigned long)__cuda_local_var_36622_6_non_const_y) * pitch)) + ((7UL * pitch) * 512UL)))]) = __cuda_local_var_36627_29_non_const_f7;
# 611 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36621_6_non_const_x) + (((unsigned long)__cuda_local_var_36622_6_non_const_y) * pitch)) + ((8UL * pitch) * 512UL)))]) = __cuda_local_var_36627_32_non_const_f8;
# 612 "txInterpTest.cu"
}
# 613 "txInterpTest.cu"
}
# 615 "txInterpTest.cu"
{
# 615 "txInterpTest.cu"
__syncthreads();
# 615 "txInterpTest.cu"
}
# 616 "txInterpTest.cu"
if ((((__cuda_local_var_36629_30_non_const_check)[0]) == 1) && (((long)t) >= 10000000000L))
# 616 "txInterpTest.cu"
{
# 618 "txInterpTest.cu"
 int __cuda_local_var_36693_6_non_const_nTotalThreads;
# 618 "txInterpTest.cu"
__cuda_local_var_36693_6_non_const_nTotalThreads = ((int)(blockDim.x));
# 619 "txInterpTest.cu"
while (__cuda_local_var_36693_6_non_const_nTotalThreads > 1)
# 619 "txInterpTest.cu"
{
# 620 "txInterpTest.cu"
 int __cuda_local_var_36695_7_non_const_halfPoint;
# 620 "txInterpTest.cu"
__cuda_local_var_36695_7_non_const_halfPoint = (__cuda_local_var_36693_6_non_const_nTotalThreads >> 1);
# 621 "txInterpTest.cu"
if ((threadIdx.x) < ((unsigned)__cuda_local_var_36695_7_non_const_halfPoint))
# 621 "txInterpTest.cu"
{
# 622 "txInterpTest.cu"
((__cuda_local_var_36628_32_non_const_sumX)[(threadIdx.x)]) += ((__cuda_local_var_36628_32_non_const_sumX)[((threadIdx.x) + ((unsigned)__cuda_local_var_36695_7_non_const_halfPoint))]);
# 623 "txInterpTest.cu"
((__cuda_local_var_36628_43_non_const_sumY)[(threadIdx.x)]) += ((__cuda_local_var_36628_43_non_const_sumY)[((threadIdx.x) + ((unsigned)__cuda_local_var_36695_7_non_const_halfPoint))]);
# 624 "txInterpTest.cu"
}
# 625 "txInterpTest.cu"
{
# 625 "txInterpTest.cu"
__syncthreads();
# 625 "txInterpTest.cu"
}
# 626 "txInterpTest.cu"
__cuda_local_var_36693_6_non_const_nTotalThreads = __cuda_local_var_36695_7_non_const_halfPoint;
# 627 "txInterpTest.cu"
}
# 628 "txInterpTest.cu"
if ((threadIdx.x) == 0U)
# 628 "txInterpTest.cu"
{
# 629 "txInterpTest.cu"
_Z9atomicAddPff((FX + t), ((__cuda_local_var_36628_32_non_const_sumX)[0]));
# 630 "txInterpTest.cu"
_Z9atomicAddPff((FY + t), ((__cuda_local_var_36628_43_non_const_sumY)[0]));
# 631 "txInterpTest.cu"
}
# 632 "txInterpTest.cu"
}
# 634 "txInterpTest.cu"
}
# 634 "txInterpTest.cu"
}}
# 638 "txInterpTest.cu"
__attribute__((global)) __attribute__((__used__)) void _Z12LR_d_hybABCDPfS_fm(
# 638 "txInterpTest.cu"
float *fin,
# 638 "txInterpTest.cu"
float *fout,
# 639 "txInterpTest.cu"
float omega,
# 639 "txInterpTest.cu"
size_t pitch){
# 639 "txInterpTest.cu"
{
# 640 "txInterpTest.cu"
{
# 640 "txInterpTest.cu"
 float __T299;
# 641 "txInterpTest.cu"
 float __T2100;
# 642 "txInterpTest.cu"
 float __T2101;
# 643 "txInterpTest.cu"
 float __T2102;
# 641 "txInterpTest.cu"
 int __cuda_local_var_36716_6_non_const_x;
# 642 "txInterpTest.cu"
 int __cuda_local_var_36717_6_non_const_y;
# 643 "txInterpTest.cu"
 float __cuda_local_var_36718_8_non_const_xcoord;
# 644 "txInterpTest.cu"
 float __cuda_local_var_36719_8_non_const_ycoord;
# 645 "txInterpTest.cu"
 int __cuda_local_var_36720_6_non_const_j;
# 646 "txInterpTest.cu"
 int __cuda_local_var_36721_6_non_const_im;
# 647 "txInterpTest.cu"
 float __cuda_local_var_36722_8_non_const_f0;
# 647 "txInterpTest.cu"
 float __cuda_local_var_36722_11_non_const_f1;
# 647 "txInterpTest.cu"
 float __cuda_local_var_36722_14_non_const_f2;
# 647 "txInterpTest.cu"
 float __cuda_local_var_36722_17_non_const_f3;
# 647 "txInterpTest.cu"
 float __cuda_local_var_36722_20_non_const_f4;
# 647 "txInterpTest.cu"
 float __cuda_local_var_36722_23_non_const_f5;
# 647 "txInterpTest.cu"
 float __cuda_local_var_36722_26_non_const_f6;
# 647 "txInterpTest.cu"
 float __cuda_local_var_36722_29_non_const_f7;
# 647 "txInterpTest.cu"
 float __cuda_local_var_36722_32_non_const_f8;
# 641 "txInterpTest.cu"
__cuda_local_var_36716_6_non_const_x = ((int)((threadIdx.x) + ((blockIdx.x) * (blockDim.x))));
# 642 "txInterpTest.cu"
__cuda_local_var_36717_6_non_const_y = ((int)((threadIdx.y) + ((blockIdx.y) * (blockDim.y))));
# 643 "txInterpTest.cu"
__cuda_local_var_36718_8_non_const_xcoord = ((float)((415.625) + ((double)(((float)__cuda_local_var_36716_6_non_const_x) * (0.25F)))));
# 644 "txInterpTest.cu"
__cuda_local_var_36719_8_non_const_ycoord = ((float)((319.625) + ((double)(((float)__cuda_local_var_36717_6_non_const_y) * (0.25F)))));
# 645 "txInterpTest.cu"
__cuda_local_var_36720_6_non_const_j = ((int)(((unsigned long)__cuda_local_var_36716_6_non_const_x) + (((unsigned long)__cuda_local_var_36717_6_non_const_y) * pitch)));
# 646 "txInterpTest.cu"
__cuda_local_var_36721_6_non_const_im = (_Z8ImageFcnff(__cuda_local_var_36718_8_non_const_xcoord, __cuda_local_var_36719_8_non_const_ycoord));
# 649 "txInterpTest.cu"
if ((((__cuda_local_var_36716_6_non_const_x < 1) || (__cuda_local_var_36716_6_non_const_x > 766)) || (__cuda_local_var_36717_6_non_const_y < 1)) || (__cuda_local_var_36717_6_non_const_y > 510))
# 650 "txInterpTest.cu"
{
# 652 "txInterpTest.cu"
}
# 653 "txInterpTest.cu"
else
# 653 "txInterpTest.cu"
{
# 653 "txInterpTest.cu"
 __texture_type__ __T2103;
# 654 "txInterpTest.cu"
 float __T2104;
# 655 "txInterpTest.cu"
 float __T2105;
# 656 "txInterpTest.cu"
 float4 __T2106;
# 657 "txInterpTest.cu"
 float4 __T2107;
# 658 "txInterpTest.cu"
 __texture_type__ __T2108;
# 659 "txInterpTest.cu"
 float __T2109;
# 660 "txInterpTest.cu"
 float __T2110;
# 661 "txInterpTest.cu"
 float4 __T2111;
# 662 "txInterpTest.cu"
 float4 __T2112;
# 663 "txInterpTest.cu"
 __texture_type__ __T2113;
# 664 "txInterpTest.cu"
 float __T2114;
# 665 "txInterpTest.cu"
 float __T2115;
# 666 "txInterpTest.cu"
 float4 __T2116;
# 667 "txInterpTest.cu"
 float4 __T2117;
# 668 "txInterpTest.cu"
 __texture_type__ __T2118;
# 669 "txInterpTest.cu"
 float __T2119;
# 670 "txInterpTest.cu"
 float __T2120;
# 671 "txInterpTest.cu"
 float4 __T2121;
# 672 "txInterpTest.cu"
 float4 __T2122;
# 673 "txInterpTest.cu"
 __texture_type__ __T2123;
# 674 "txInterpTest.cu"
 float __T2124;
# 675 "txInterpTest.cu"
 float __T2125;
# 676 "txInterpTest.cu"
 float4 __T2126;
# 677 "txInterpTest.cu"
 float4 __T2127;
# 678 "txInterpTest.cu"
 __texture_type__ __T2128;
# 679 "txInterpTest.cu"
 float __T2129;
# 680 "txInterpTest.cu"
 float __T2130;
# 681 "txInterpTest.cu"
 float4 __T2131;
# 682 "txInterpTest.cu"
 float4 __T2132;
# 654 "txInterpTest.cu"
__cuda_local_var_36722_8_non_const_f0 = (fin[__cuda_local_var_36720_6_non_const_j]);
# 655 "txInterpTest.cu"
__cuda_local_var_36722_14_non_const_f2 = (fin[((int)((((unsigned long)__cuda_local_var_36716_6_non_const_x) + (((unsigned long)(__cuda_local_var_36717_6_non_const_y - 1)) * pitch)) + ((2UL * pitch) * 512UL)))]);
# 656 "txInterpTest.cu"
__cuda_local_var_36722_20_non_const_f4 = (fin[((int)((((unsigned long)__cuda_local_var_36716_6_non_const_x) + (((unsigned long)(__cuda_local_var_36717_6_non_const_y + 1)) * pitch)) + ((4UL * pitch) * 512UL)))]);
# 657 "txInterpTest.cu"
__cuda_local_var_36722_11_non_const_f1 = ((((__T2103 = texRef_f1C) , ((void)(__T2104 = (((float)(__cuda_local_var_36716_6_non_const_x - 1)) + (0.5F))))) , ((void)(__T2105 = (((float)__cuda_local_var_36717_6_non_const_y) + (0.5F))))) , ((__T2107 = (__ftexfetch2D(__T2103, ((((((__T2106.x) = __T2104) , ((void)((__T2106.y) = __T2105))) , ((void)((__T2106.z) = (0.0F)))) , ((void)((__T2106.w) = (0.0F)))) , __T2106)))) , (__T2107.x)));
# 658 "txInterpTest.cu"
__cuda_local_var_36722_17_non_const_f3 = ((((__T2108 = texRef_f3C) , ((void)(__T2109 = (((float)(__cuda_local_var_36716_6_non_const_x + 1)) + (0.5F))))) , ((void)(__T2110 = (((float)__cuda_local_var_36717_6_non_const_y) + (0.5F))))) , ((__T2112 = (__ftexfetch2D(__T2108, ((((((__T2111.x) = __T2109) , ((void)((__T2111.y) = __T2110))) , ((void)((__T2111.z) = (0.0F)))) , ((void)((__T2111.w) = (0.0F)))) , __T2111)))) , (__T2112.x)));
# 659 "txInterpTest.cu"
__cuda_local_var_36722_23_non_const_f5 = ((((__T2113 = texRef_f5C) , ((void)(__T2114 = (((float)(__cuda_local_var_36716_6_non_const_x - 1)) + (0.5F))))) , ((void)(__T2115 = (((float)(__cuda_local_var_36717_6_non_const_y - 1)) + (0.5F))))) , ((__T2117 = (__ftexfetch2D(__T2113, ((((((__T2116.x) = __T2114) , ((void)((__T2116.y) = __T2115))) , ((void)((__T2116.z) = (0.0F)))) , ((void)((__T2116.w) = (0.0F)))) , __T2116)))) , (__T2117.x)));
# 660 "txInterpTest.cu"
__cuda_local_var_36722_26_non_const_f6 = ((((__T2118 = texRef_f6C) , ((void)(__T2119 = (((float)(__cuda_local_var_36716_6_non_const_x + 1)) + (0.5F))))) , ((void)(__T2120 = (((float)(__cuda_local_var_36717_6_non_const_y - 1)) + (0.5F))))) , ((__T2122 = (__ftexfetch2D(__T2118, ((((((__T2121.x) = __T2119) , ((void)((__T2121.y) = __T2120))) , ((void)((__T2121.z) = (0.0F)))) , ((void)((__T2121.w) = (0.0F)))) , __T2121)))) , (__T2122.x)));
# 661 "txInterpTest.cu"
__cuda_local_var_36722_29_non_const_f7 = ((((__T2123 = texRef_f7C) , ((void)(__T2124 = (((float)(__cuda_local_var_36716_6_non_const_x + 1)) + (0.5F))))) , ((void)(__T2125 = (((float)(__cuda_local_var_36717_6_non_const_y + 1)) + (0.5F))))) , ((__T2127 = (__ftexfetch2D(__T2123, ((((((__T2126.x) = __T2124) , ((void)((__T2126.y) = __T2125))) , ((void)((__T2126.z) = (0.0F)))) , ((void)((__T2126.w) = (0.0F)))) , __T2126)))) , (__T2127.x)));
# 662 "txInterpTest.cu"
__cuda_local_var_36722_32_non_const_f8 = ((((__T2128 = texRef_f8C) , ((void)(__T2129 = (((float)(__cuda_local_var_36716_6_non_const_x - 1)) + (0.5F))))) , ((void)(__T2130 = (((float)(__cuda_local_var_36717_6_non_const_y + 1)) + (0.5F))))) , ((__T2132 = (__ftexfetch2D(__T2128, ((((((__T2131.x) = __T2129) , ((void)((__T2131.y) = __T2130))) , ((void)((__T2131.z) = (0.0F)))) , ((void)((__T2131.w) = (0.0F)))) , __T2131)))) , (__T2132.x)));
# 664 "txInterpTest.cu"
if ((__cuda_local_var_36721_6_non_const_im == 1) || (__cuda_local_var_36721_6_non_const_im == 10))
# 664 "txInterpTest.cu"
{
# 665 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36716_6_non_const_x) + (((unsigned long)__cuda_local_var_36717_6_non_const_y) * pitch)) + ((1UL * pitch) * 512UL)))]) = __cuda_local_var_36722_17_non_const_f3;
# 666 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36716_6_non_const_x) + (((unsigned long)__cuda_local_var_36717_6_non_const_y) * pitch)) + ((2UL * pitch) * 512UL)))]) = __cuda_local_var_36722_20_non_const_f4;
# 667 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36716_6_non_const_x) + (((unsigned long)__cuda_local_var_36717_6_non_const_y) * pitch)) + ((3UL * pitch) * 512UL)))]) = __cuda_local_var_36722_11_non_const_f1;
# 668 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36716_6_non_const_x) + (((unsigned long)__cuda_local_var_36717_6_non_const_y) * pitch)) + ((4UL * pitch) * 512UL)))]) = __cuda_local_var_36722_14_non_const_f2;
# 669 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36716_6_non_const_x) + (((unsigned long)__cuda_local_var_36717_6_non_const_y) * pitch)) + ((5UL * pitch) * 512UL)))]) = __cuda_local_var_36722_29_non_const_f7;
# 670 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36716_6_non_const_x) + (((unsigned long)__cuda_local_var_36717_6_non_const_y) * pitch)) + ((6UL * pitch) * 512UL)))]) = __cuda_local_var_36722_32_non_const_f8;
# 671 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36716_6_non_const_x) + (((unsigned long)__cuda_local_var_36717_6_non_const_y) * pitch)) + ((7UL * pitch) * 512UL)))]) = __cuda_local_var_36722_23_non_const_f5;
# 672 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36716_6_non_const_x) + (((unsigned long)__cuda_local_var_36717_6_non_const_y) * pitch)) + ((8UL * pitch) * 512UL)))]) = __cuda_local_var_36722_26_non_const_f6;
# 673 "txInterpTest.cu"
}
# 674 "txInterpTest.cu"
else
# 674 "txInterpTest.cu"
{
# 675 "txInterpTest.cu"
if (((const char *)"BGK") == ((const char *)"MRT"))
# 675 "txInterpTest.cu"
{
# 676 "txInterpTest.cu"
_Z11mrt_collideRfS_S_S_S_S_S_S_S_f((&__cuda_local_var_36722_8_non_const_f0), (&__cuda_local_var_36722_11_non_const_f1), (&__cuda_local_var_36722_14_non_const_f2), (&__cuda_local_var_36722_17_non_const_f3), (&__cuda_local_var_36722_20_non_const_f4), (&__cuda_local_var_36722_23_non_const_f5), (&__cuda_local_var_36722_26_non_const_f6), (&__cuda_local_var_36722_29_non_const_f7), (&__cuda_local_var_36722_32_non_const_f8), omega);
# 676 "txInterpTest.cu"
}
# 676 "txInterpTest.cu"
else
# 676 "txInterpTest.cu"
{
# 677 "txInterpTest.cu"
if (1)
# 677 "txInterpTest.cu"
{
# 678 "txInterpTest.cu"
{
# 678 "txInterpTest.cu"
__T299 = ((((((((__cuda_local_var_36722_8_non_const_f0 + __cuda_local_var_36722_11_non_const_f1) + __cuda_local_var_36722_14_non_const_f2) + __cuda_local_var_36722_17_non_const_f3) + __cuda_local_var_36722_20_non_const_f4) + __cuda_local_var_36722_23_non_const_f5) + __cuda_local_var_36722_26_non_const_f6) + __cuda_local_var_36722_29_non_const_f7) + __cuda_local_var_36722_32_non_const_f8);
# 678 "txInterpTest.cu"
__T2100 = (((((__cuda_local_var_36722_11_non_const_f1 - __cuda_local_var_36722_17_non_const_f3) + __cuda_local_var_36722_23_non_const_f5) - __cuda_local_var_36722_26_non_const_f6) - __cuda_local_var_36722_29_non_const_f7) + __cuda_local_var_36722_32_non_const_f8);
# 678 "txInterpTest.cu"
__T2101 = (((((__cuda_local_var_36722_14_non_const_f2 - __cuda_local_var_36722_20_non_const_f4) + __cuda_local_var_36722_23_non_const_f5) + __cuda_local_var_36722_26_non_const_f6) - __cuda_local_var_36722_29_non_const_f7) - __cuda_local_var_36722_32_non_const_f8);
# 678 "txInterpTest.cu"
__T2102 = ((__T2100 * __T2100) + (__T2101 * __T2101));
# 678 "txInterpTest.cu"
__cuda_local_var_36722_8_non_const_f0 = (__cuda_local_var_36722_8_non_const_f0 - (omega * (__cuda_local_var_36722_8_non_const_f0 - ((0.4444444478F) * (__T299 - ((1.5F) * __T2102))))));
# 678 "txInterpTest.cu"
__cuda_local_var_36722_11_non_const_f1 = (__cuda_local_var_36722_11_non_const_f1 - (omega * (__cuda_local_var_36722_11_non_const_f1 - ((0.1111111119F) * (((__T299 + ((3.0F) * __T2100)) + (((4.5F) * __T2100) * __T2100)) - ((1.5F) * __T2102))))));
# 678 "txInterpTest.cu"
__cuda_local_var_36722_14_non_const_f2 = (__cuda_local_var_36722_14_non_const_f2 - (omega * (__cuda_local_var_36722_14_non_const_f2 - ((0.1111111119F) * (((__T299 + ((3.0F) * __T2101)) + (((4.5F) * __T2101) * __T2101)) - ((1.5F) * __T2102))))));
# 678 "txInterpTest.cu"
__cuda_local_var_36722_17_non_const_f3 = (__cuda_local_var_36722_17_non_const_f3 - (omega * (__cuda_local_var_36722_17_non_const_f3 - ((0.1111111119F) * (((__T299 - ((3.0F) * __T2100)) + (((4.5F) * __T2100) * __T2100)) - ((1.5F) * __T2102))))));
# 678 "txInterpTest.cu"
__cuda_local_var_36722_20_non_const_f4 = (__cuda_local_var_36722_20_non_const_f4 - (omega * (__cuda_local_var_36722_20_non_const_f4 - ((0.1111111119F) * (((__T299 - ((3.0F) * __T2101)) + (((4.5F) * __T2101) * __T2101)) - ((1.5F) * __T2102))))));
# 678 "txInterpTest.cu"
__cuda_local_var_36722_23_non_const_f5 = ((float)(((double)__cuda_local_var_36722_23_non_const_f5) - (((double)omega) * (((double)__cuda_local_var_36722_23_non_const_f5) - ((0.02777777777999999864) * ((double)(((__T299 + ((3.0F) * (__T2100 + __T2101))) + (((4.5F) * (__T2100 + __T2101)) * (__T2100 + __T2101))) - ((1.5F) * __T2102))))))));
# 678 "txInterpTest.cu"
__cuda_local_var_36722_26_non_const_f6 = ((float)(((double)__cuda_local_var_36722_26_non_const_f6) - (((double)omega) * (((double)__cuda_local_var_36722_26_non_const_f6) - ((0.02777777777999999864) * ((double)(((__T299 + ((3.0F) * ((-__T2100) + __T2101))) + (((4.5F) * ((-__T2100) + __T2101)) * ((-__T2100) + __T2101))) - ((1.5F) * __T2102))))))));
# 678 "txInterpTest.cu"
__cuda_local_var_36722_29_non_const_f7 = ((float)(((double)__cuda_local_var_36722_29_non_const_f7) - (((double)omega) * (((double)__cuda_local_var_36722_29_non_const_f7) - ((0.02777777777999999864) * ((double)(((__T299 + ((3.0F) * ((-__T2100) - __T2101))) + (((4.5F) * ((-__T2100) - __T2101)) * ((-__T2100) - __T2101))) - ((1.5F) * __T2102))))))));
# 678 "txInterpTest.cu"
__cuda_local_var_36722_32_non_const_f8 = ((float)(((double)__cuda_local_var_36722_32_non_const_f8) - (((double)omega) * (((double)__cuda_local_var_36722_32_non_const_f8) - ((0.02777777777999999864) * ((double)(((__T299 + ((3.0F) * (__T2100 - __T2101))) + (((4.5F) * (__T2100 - __T2101)) * (__T2100 - __T2101))) - ((1.5F) * __T2102))))))));
# 678 "txInterpTest.cu"
}
# 678 "txInterpTest.cu"
}
# 678 "txInterpTest.cu"
}
# 679 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36716_6_non_const_x) + (((unsigned long)__cuda_local_var_36717_6_non_const_y) * pitch)) + ((0UL * pitch) * 512UL)))]) = __cuda_local_var_36722_8_non_const_f0;
# 680 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36716_6_non_const_x) + (((unsigned long)__cuda_local_var_36717_6_non_const_y) * pitch)) + ((1UL * pitch) * 512UL)))]) = __cuda_local_var_36722_11_non_const_f1;
# 681 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36716_6_non_const_x) + (((unsigned long)__cuda_local_var_36717_6_non_const_y) * pitch)) + ((2UL * pitch) * 512UL)))]) = __cuda_local_var_36722_14_non_const_f2;
# 682 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36716_6_non_const_x) + (((unsigned long)__cuda_local_var_36717_6_non_const_y) * pitch)) + ((3UL * pitch) * 512UL)))]) = __cuda_local_var_36722_17_non_const_f3;
# 683 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36716_6_non_const_x) + (((unsigned long)__cuda_local_var_36717_6_non_const_y) * pitch)) + ((4UL * pitch) * 512UL)))]) = __cuda_local_var_36722_20_non_const_f4;
# 684 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36716_6_non_const_x) + (((unsigned long)__cuda_local_var_36717_6_non_const_y) * pitch)) + ((5UL * pitch) * 512UL)))]) = __cuda_local_var_36722_23_non_const_f5;
# 685 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36716_6_non_const_x) + (((unsigned long)__cuda_local_var_36717_6_non_const_y) * pitch)) + ((6UL * pitch) * 512UL)))]) = __cuda_local_var_36722_26_non_const_f6;
# 686 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36716_6_non_const_x) + (((unsigned long)__cuda_local_var_36717_6_non_const_y) * pitch)) + ((7UL * pitch) * 512UL)))]) = __cuda_local_var_36722_29_non_const_f7;
# 687 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36716_6_non_const_x) + (((unsigned long)__cuda_local_var_36717_6_non_const_y) * pitch)) + ((8UL * pitch) * 512UL)))]) = __cuda_local_var_36722_32_non_const_f8;
# 688 "txInterpTest.cu"
}
# 690 "txInterpTest.cu"
}
# 691 "txInterpTest.cu"
}
# 691 "txInterpTest.cu"
}}
# 693 "txInterpTest.cu"
__attribute__((global)) __attribute__((__used__)) void _Z13LR_d_hybABCD2PfS_fmi(
# 693 "txInterpTest.cu"
float *fin,
# 693 "txInterpTest.cu"
float *fout,
# 694 "txInterpTest.cu"
float omega,
# 694 "txInterpTest.cu"
size_t pitch,
# 694 "txInterpTest.cu"
int n){
# 694 "txInterpTest.cu"
{
# 697 "txInterpTest.cu"
{
# 697 "txInterpTest.cu"
 float __T2133;
# 698 "txInterpTest.cu"
 float __T2134;
# 699 "txInterpTest.cu"
 float __T2135;
# 700 "txInterpTest.cu"
 float __T2136;
# 698 "txInterpTest.cu"
 int __cuda_local_var_36773_6_non_const_x;
# 699 "txInterpTest.cu"
 int __cuda_local_var_36774_6_non_const_y;
# 700 "txInterpTest.cu"
 float __cuda_local_var_36775_8_non_const_xcoord;
# 701 "txInterpTest.cu"
 float __cuda_local_var_36776_8_non_const_ycoord;
# 702 "txInterpTest.cu"
 int __cuda_local_var_36777_6_non_const_j;
# 703 "txInterpTest.cu"
 int __cuda_local_var_36778_6_non_const_im;
# 704 "txInterpTest.cu"
 float __cuda_local_var_36779_8_non_const_f0;
# 704 "txInterpTest.cu"
 float __cuda_local_var_36779_11_non_const_f1;
# 704 "txInterpTest.cu"
 float __cuda_local_var_36779_14_non_const_f2;
# 704 "txInterpTest.cu"
 float __cuda_local_var_36779_17_non_const_f3;
# 704 "txInterpTest.cu"
 float __cuda_local_var_36779_20_non_const_f4;
# 704 "txInterpTest.cu"
 float __cuda_local_var_36779_23_non_const_f5;
# 704 "txInterpTest.cu"
 float __cuda_local_var_36779_26_non_const_f6;
# 704 "txInterpTest.cu"
 float __cuda_local_var_36779_29_non_const_f7;
# 704 "txInterpTest.cu"
 float __cuda_local_var_36779_32_non_const_f8;
# 698 "txInterpTest.cu"
__cuda_local_var_36773_6_non_const_x = ((int)((threadIdx.x) + ((blockIdx.x) * (blockDim.x))));
# 699 "txInterpTest.cu"
__cuda_local_var_36774_6_non_const_y = ((int)((threadIdx.y) + ((blockIdx.y) * (blockDim.y))));
# 700 "txInterpTest.cu"
__cuda_local_var_36775_8_non_const_xcoord = ((float)((415.625) + ((double)(((float)__cuda_local_var_36773_6_non_const_x) * (0.25F)))));
# 701 "txInterpTest.cu"
__cuda_local_var_36776_8_non_const_ycoord = ((float)((319.625) + ((double)(((float)__cuda_local_var_36774_6_non_const_y) * (0.25F)))));
# 702 "txInterpTest.cu"
__cuda_local_var_36777_6_non_const_j = ((int)(((unsigned long)__cuda_local_var_36773_6_non_const_x) + (((unsigned long)__cuda_local_var_36774_6_non_const_y) * pitch)));
# 703 "txInterpTest.cu"
__cuda_local_var_36778_6_non_const_im = (_Z8ImageFcnff(__cuda_local_var_36775_8_non_const_xcoord, __cuda_local_var_36776_8_non_const_ycoord));
# 707 "txInterpTest.cu"
if ((((__cuda_local_var_36773_6_non_const_x < n) || (__cuda_local_var_36773_6_non_const_x > (767 - n))) || (__cuda_local_var_36774_6_non_const_y < n)) || (__cuda_local_var_36774_6_non_const_y > (511 - n)))
# 708 "txInterpTest.cu"
{
# 710 "txInterpTest.cu"
}
# 711 "txInterpTest.cu"
else
# 711 "txInterpTest.cu"
{
# 711 "txInterpTest.cu"
 __texture_type__ __T2137;
# 712 "txInterpTest.cu"
 float __T2138;
# 713 "txInterpTest.cu"
 float __T2139;
# 714 "txInterpTest.cu"
 float4 __T2140;
# 715 "txInterpTest.cu"
 float4 __T2141;
# 716 "txInterpTest.cu"
 __texture_type__ __T2142;
# 717 "txInterpTest.cu"
 float __T2143;
# 718 "txInterpTest.cu"
 float __T2144;
# 719 "txInterpTest.cu"
 float4 __T2145;
# 720 "txInterpTest.cu"
 float4 __T2146;
# 721 "txInterpTest.cu"
 __texture_type__ __T2147;
# 722 "txInterpTest.cu"
 float __T2148;
# 723 "txInterpTest.cu"
 float __T2149;
# 724 "txInterpTest.cu"
 float4 __T2150;
# 725 "txInterpTest.cu"
 float4 __T2151;
# 726 "txInterpTest.cu"
 __texture_type__ __T2152;
# 727 "txInterpTest.cu"
 float __T2153;
# 728 "txInterpTest.cu"
 float __T2154;
# 729 "txInterpTest.cu"
 float4 __T2155;
# 730 "txInterpTest.cu"
 float4 __T2156;
# 731 "txInterpTest.cu"
 __texture_type__ __T2157;
# 732 "txInterpTest.cu"
 float __T2158;
# 733 "txInterpTest.cu"
 float __T2159;
# 734 "txInterpTest.cu"
 float4 __T2160;
# 735 "txInterpTest.cu"
 float4 __T2161;
# 736 "txInterpTest.cu"
 __texture_type__ __T2162;
# 737 "txInterpTest.cu"
 float __T2163;
# 738 "txInterpTest.cu"
 float __T2164;
# 739 "txInterpTest.cu"
 float4 __T2165;
# 740 "txInterpTest.cu"
 float4 __T2166;
# 712 "txInterpTest.cu"
__cuda_local_var_36779_8_non_const_f0 = (fin[__cuda_local_var_36777_6_non_const_j]);
# 713 "txInterpTest.cu"
__cuda_local_var_36779_14_non_const_f2 = (fin[((int)((((unsigned long)__cuda_local_var_36773_6_non_const_x) + (((unsigned long)(__cuda_local_var_36774_6_non_const_y - 1)) * pitch)) + ((2UL * pitch) * 512UL)))]);
# 714 "txInterpTest.cu"
__cuda_local_var_36779_20_non_const_f4 = (fin[((int)((((unsigned long)__cuda_local_var_36773_6_non_const_x) + (((unsigned long)(__cuda_local_var_36774_6_non_const_y + 1)) * pitch)) + ((4UL * pitch) * 512UL)))]);
# 715 "txInterpTest.cu"
__cuda_local_var_36779_11_non_const_f1 = ((((__T2137 = texRef_f1C) , ((void)(__T2138 = (((float)(__cuda_local_var_36773_6_non_const_x - 1)) + (0.5F))))) , ((void)(__T2139 = (((float)__cuda_local_var_36774_6_non_const_y) + (0.5F))))) , ((__T2141 = (__ftexfetch2D(__T2137, ((((((__T2140.x) = __T2138) , ((void)((__T2140.y) = __T2139))) , ((void)((__T2140.z) = (0.0F)))) , ((void)((__T2140.w) = (0.0F)))) , __T2140)))) , (__T2141.x)));
# 716 "txInterpTest.cu"
__cuda_local_var_36779_17_non_const_f3 = ((((__T2142 = texRef_f3C) , ((void)(__T2143 = (((float)(__cuda_local_var_36773_6_non_const_x + 1)) + (0.5F))))) , ((void)(__T2144 = (((float)__cuda_local_var_36774_6_non_const_y) + (0.5F))))) , ((__T2146 = (__ftexfetch2D(__T2142, ((((((__T2145.x) = __T2143) , ((void)((__T2145.y) = __T2144))) , ((void)((__T2145.z) = (0.0F)))) , ((void)((__T2145.w) = (0.0F)))) , __T2145)))) , (__T2146.x)));
# 717 "txInterpTest.cu"
__cuda_local_var_36779_23_non_const_f5 = ((((__T2147 = texRef_f5C) , ((void)(__T2148 = (((float)(__cuda_local_var_36773_6_non_const_x - 1)) + (0.5F))))) , ((void)(__T2149 = (((float)(__cuda_local_var_36774_6_non_const_y - 1)) + (0.5F))))) , ((__T2151 = (__ftexfetch2D(__T2147, ((((((__T2150.x) = __T2148) , ((void)((__T2150.y) = __T2149))) , ((void)((__T2150.z) = (0.0F)))) , ((void)((__T2150.w) = (0.0F)))) , __T2150)))) , (__T2151.x)));
# 718 "txInterpTest.cu"
__cuda_local_var_36779_26_non_const_f6 = ((((__T2152 = texRef_f6C) , ((void)(__T2153 = (((float)(__cuda_local_var_36773_6_non_const_x + 1)) + (0.5F))))) , ((void)(__T2154 = (((float)(__cuda_local_var_36774_6_non_const_y - 1)) + (0.5F))))) , ((__T2156 = (__ftexfetch2D(__T2152, ((((((__T2155.x) = __T2153) , ((void)((__T2155.y) = __T2154))) , ((void)((__T2155.z) = (0.0F)))) , ((void)((__T2155.w) = (0.0F)))) , __T2155)))) , (__T2156.x)));
# 719 "txInterpTest.cu"
__cuda_local_var_36779_29_non_const_f7 = ((((__T2157 = texRef_f7C) , ((void)(__T2158 = (((float)(__cuda_local_var_36773_6_non_const_x + 1)) + (0.5F))))) , ((void)(__T2159 = (((float)(__cuda_local_var_36774_6_non_const_y + 1)) + (0.5F))))) , ((__T2161 = (__ftexfetch2D(__T2157, ((((((__T2160.x) = __T2158) , ((void)((__T2160.y) = __T2159))) , ((void)((__T2160.z) = (0.0F)))) , ((void)((__T2160.w) = (0.0F)))) , __T2160)))) , (__T2161.x)));
# 720 "txInterpTest.cu"
__cuda_local_var_36779_32_non_const_f8 = ((((__T2162 = texRef_f8C) , ((void)(__T2163 = (((float)(__cuda_local_var_36773_6_non_const_x - 1)) + (0.5F))))) , ((void)(__T2164 = (((float)(__cuda_local_var_36774_6_non_const_y + 1)) + (0.5F))))) , ((__T2166 = (__ftexfetch2D(__T2162, ((((((__T2165.x) = __T2163) , ((void)((__T2165.y) = __T2164))) , ((void)((__T2165.z) = (0.0F)))) , ((void)((__T2165.w) = (0.0F)))) , __T2165)))) , (__T2166.x)));
# 722 "txInterpTest.cu"
if ((__cuda_local_var_36778_6_non_const_im == 1) || (__cuda_local_var_36778_6_non_const_im == 10))
# 722 "txInterpTest.cu"
{
# 723 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36773_6_non_const_x) + (((unsigned long)__cuda_local_var_36774_6_non_const_y) * pitch)) + ((1UL * pitch) * 512UL)))]) = __cuda_local_var_36779_17_non_const_f3;
# 724 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36773_6_non_const_x) + (((unsigned long)__cuda_local_var_36774_6_non_const_y) * pitch)) + ((2UL * pitch) * 512UL)))]) = __cuda_local_var_36779_20_non_const_f4;
# 725 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36773_6_non_const_x) + (((unsigned long)__cuda_local_var_36774_6_non_const_y) * pitch)) + ((3UL * pitch) * 512UL)))]) = __cuda_local_var_36779_11_non_const_f1;
# 726 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36773_6_non_const_x) + (((unsigned long)__cuda_local_var_36774_6_non_const_y) * pitch)) + ((4UL * pitch) * 512UL)))]) = __cuda_local_var_36779_14_non_const_f2;
# 727 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36773_6_non_const_x) + (((unsigned long)__cuda_local_var_36774_6_non_const_y) * pitch)) + ((5UL * pitch) * 512UL)))]) = __cuda_local_var_36779_29_non_const_f7;
# 728 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36773_6_non_const_x) + (((unsigned long)__cuda_local_var_36774_6_non_const_y) * pitch)) + ((6UL * pitch) * 512UL)))]) = __cuda_local_var_36779_32_non_const_f8;
# 729 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36773_6_non_const_x) + (((unsigned long)__cuda_local_var_36774_6_non_const_y) * pitch)) + ((7UL * pitch) * 512UL)))]) = __cuda_local_var_36779_23_non_const_f5;
# 730 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36773_6_non_const_x) + (((unsigned long)__cuda_local_var_36774_6_non_const_y) * pitch)) + ((8UL * pitch) * 512UL)))]) = __cuda_local_var_36779_26_non_const_f6;
# 731 "txInterpTest.cu"
}
# 732 "txInterpTest.cu"
else
# 732 "txInterpTest.cu"
{
# 733 "txInterpTest.cu"
if (((const char *)"BGK") == ((const char *)"MRT"))
# 733 "txInterpTest.cu"
{
# 734 "txInterpTest.cu"
_Z11mrt_collideRfS_S_S_S_S_S_S_S_f((&__cuda_local_var_36779_8_non_const_f0), (&__cuda_local_var_36779_11_non_const_f1), (&__cuda_local_var_36779_14_non_const_f2), (&__cuda_local_var_36779_17_non_const_f3), (&__cuda_local_var_36779_20_non_const_f4), (&__cuda_local_var_36779_23_non_const_f5), (&__cuda_local_var_36779_26_non_const_f6), (&__cuda_local_var_36779_29_non_const_f7), (&__cuda_local_var_36779_32_non_const_f8), omega);
# 734 "txInterpTest.cu"
}
# 734 "txInterpTest.cu"
else
# 734 "txInterpTest.cu"
{
# 735 "txInterpTest.cu"
if (1)
# 735 "txInterpTest.cu"
{
# 736 "txInterpTest.cu"
{
# 736 "txInterpTest.cu"
__T2133 = ((((((((__cuda_local_var_36779_8_non_const_f0 + __cuda_local_var_36779_11_non_const_f1) + __cuda_local_var_36779_14_non_const_f2) + __cuda_local_var_36779_17_non_const_f3) + __cuda_local_var_36779_20_non_const_f4) + __cuda_local_var_36779_23_non_const_f5) + __cuda_local_var_36779_26_non_const_f6) + __cuda_local_var_36779_29_non_const_f7) + __cuda_local_var_36779_32_non_const_f8);
# 736 "txInterpTest.cu"
__T2134 = (((((__cuda_local_var_36779_11_non_const_f1 - __cuda_local_var_36779_17_non_const_f3) + __cuda_local_var_36779_23_non_const_f5) - __cuda_local_var_36779_26_non_const_f6) - __cuda_local_var_36779_29_non_const_f7) + __cuda_local_var_36779_32_non_const_f8);
# 736 "txInterpTest.cu"
__T2135 = (((((__cuda_local_var_36779_14_non_const_f2 - __cuda_local_var_36779_20_non_const_f4) + __cuda_local_var_36779_23_non_const_f5) + __cuda_local_var_36779_26_non_const_f6) - __cuda_local_var_36779_29_non_const_f7) - __cuda_local_var_36779_32_non_const_f8);
# 736 "txInterpTest.cu"
__T2136 = ((__T2134 * __T2134) + (__T2135 * __T2135));
# 736 "txInterpTest.cu"
__cuda_local_var_36779_8_non_const_f0 = (__cuda_local_var_36779_8_non_const_f0 - (omega * (__cuda_local_var_36779_8_non_const_f0 - ((0.4444444478F) * (__T2133 - ((1.5F) * __T2136))))));
# 736 "txInterpTest.cu"
__cuda_local_var_36779_11_non_const_f1 = (__cuda_local_var_36779_11_non_const_f1 - (omega * (__cuda_local_var_36779_11_non_const_f1 - ((0.1111111119F) * (((__T2133 + ((3.0F) * __T2134)) + (((4.5F) * __T2134) * __T2134)) - ((1.5F) * __T2136))))));
# 736 "txInterpTest.cu"
__cuda_local_var_36779_14_non_const_f2 = (__cuda_local_var_36779_14_non_const_f2 - (omega * (__cuda_local_var_36779_14_non_const_f2 - ((0.1111111119F) * (((__T2133 + ((3.0F) * __T2135)) + (((4.5F) * __T2135) * __T2135)) - ((1.5F) * __T2136))))));
# 736 "txInterpTest.cu"
__cuda_local_var_36779_17_non_const_f3 = (__cuda_local_var_36779_17_non_const_f3 - (omega * (__cuda_local_var_36779_17_non_const_f3 - ((0.1111111119F) * (((__T2133 - ((3.0F) * __T2134)) + (((4.5F) * __T2134) * __T2134)) - ((1.5F) * __T2136))))));
# 736 "txInterpTest.cu"
__cuda_local_var_36779_20_non_const_f4 = (__cuda_local_var_36779_20_non_const_f4 - (omega * (__cuda_local_var_36779_20_non_const_f4 - ((0.1111111119F) * (((__T2133 - ((3.0F) * __T2135)) + (((4.5F) * __T2135) * __T2135)) - ((1.5F) * __T2136))))));
# 736 "txInterpTest.cu"
__cuda_local_var_36779_23_non_const_f5 = ((float)(((double)__cuda_local_var_36779_23_non_const_f5) - (((double)omega) * (((double)__cuda_local_var_36779_23_non_const_f5) - ((0.02777777777999999864) * ((double)(((__T2133 + ((3.0F) * (__T2134 + __T2135))) + (((4.5F) * (__T2134 + __T2135)) * (__T2134 + __T2135))) - ((1.5F) * __T2136))))))));
# 736 "txInterpTest.cu"
__cuda_local_var_36779_26_non_const_f6 = ((float)(((double)__cuda_local_var_36779_26_non_const_f6) - (((double)omega) * (((double)__cuda_local_var_36779_26_non_const_f6) - ((0.02777777777999999864) * ((double)(((__T2133 + ((3.0F) * ((-__T2134) + __T2135))) + (((4.5F) * ((-__T2134) + __T2135)) * ((-__T2134) + __T2135))) - ((1.5F) * __T2136))))))));
# 736 "txInterpTest.cu"
__cuda_local_var_36779_29_non_const_f7 = ((float)(((double)__cuda_local_var_36779_29_non_const_f7) - (((double)omega) * (((double)__cuda_local_var_36779_29_non_const_f7) - ((0.02777777777999999864) * ((double)(((__T2133 + ((3.0F) * ((-__T2134) - __T2135))) + (((4.5F) * ((-__T2134) - __T2135)) * ((-__T2134) - __T2135))) - ((1.5F) * __T2136))))))));
# 736 "txInterpTest.cu"
__cuda_local_var_36779_32_non_const_f8 = ((float)(((double)__cuda_local_var_36779_32_non_const_f8) - (((double)omega) * (((double)__cuda_local_var_36779_32_non_const_f8) - ((0.02777777777999999864) * ((double)(((__T2133 + ((3.0F) * (__T2134 - __T2135))) + (((4.5F) * (__T2134 - __T2135)) * (__T2134 - __T2135))) - ((1.5F) * __T2136))))))));
# 736 "txInterpTest.cu"
}
# 736 "txInterpTest.cu"
}
# 736 "txInterpTest.cu"
}
# 737 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36773_6_non_const_x) + (((unsigned long)__cuda_local_var_36774_6_non_const_y) * pitch)) + ((0UL * pitch) * 512UL)))]) = __cuda_local_var_36779_8_non_const_f0;
# 738 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36773_6_non_const_x) + (((unsigned long)__cuda_local_var_36774_6_non_const_y) * pitch)) + ((1UL * pitch) * 512UL)))]) = __cuda_local_var_36779_11_non_const_f1;
# 739 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36773_6_non_const_x) + (((unsigned long)__cuda_local_var_36774_6_non_const_y) * pitch)) + ((2UL * pitch) * 512UL)))]) = __cuda_local_var_36779_14_non_const_f2;
# 740 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36773_6_non_const_x) + (((unsigned long)__cuda_local_var_36774_6_non_const_y) * pitch)) + ((3UL * pitch) * 512UL)))]) = __cuda_local_var_36779_17_non_const_f3;
# 741 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36773_6_non_const_x) + (((unsigned long)__cuda_local_var_36774_6_non_const_y) * pitch)) + ((4UL * pitch) * 512UL)))]) = __cuda_local_var_36779_20_non_const_f4;
# 742 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36773_6_non_const_x) + (((unsigned long)__cuda_local_var_36774_6_non_const_y) * pitch)) + ((5UL * pitch) * 512UL)))]) = __cuda_local_var_36779_23_non_const_f5;
# 743 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36773_6_non_const_x) + (((unsigned long)__cuda_local_var_36774_6_non_const_y) * pitch)) + ((6UL * pitch) * 512UL)))]) = __cuda_local_var_36779_26_non_const_f6;
# 744 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36773_6_non_const_x) + (((unsigned long)__cuda_local_var_36774_6_non_const_y) * pitch)) + ((7UL * pitch) * 512UL)))]) = __cuda_local_var_36779_29_non_const_f7;
# 745 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36773_6_non_const_x) + (((unsigned long)__cuda_local_var_36774_6_non_const_y) * pitch)) + ((8UL * pitch) * 512UL)))]) = __cuda_local_var_36779_32_non_const_f8;
# 746 "txInterpTest.cu"
}
# 748 "txInterpTest.cu"
}
# 749 "txInterpTest.cu"
}
# 749 "txInterpTest.cu"
}}
# 751 "txInterpTest.cu"
__attribute__((global)) __attribute__((__used__)) void _Z13LR_d_hybABDC2PfS_fmfi(
# 751 "txInterpTest.cu"
float *fin,
# 751 "txInterpTest.cu"
float *fout,
# 752 "txInterpTest.cu"
float omega,
# 752 "txInterpTest.cu"
size_t pitch,
# 752 "txInterpTest.cu"
float SF,
# 752 "txInterpTest.cu"
int n){
# 752 "txInterpTest.cu"
{
# 753 "txInterpTest.cu"
{
# 753 "txInterpTest.cu"
 float __T2167;
# 754 "txInterpTest.cu"
 float __T2168;
# 755 "txInterpTest.cu"
 float __T2169;
# 756 "txInterpTest.cu"
 float __T2170;
# 754 "txInterpTest.cu"
 int __cuda_local_var_36829_6_non_const_x;
# 755 "txInterpTest.cu"
 int __cuda_local_var_36830_6_non_const_y;
# 756 "txInterpTest.cu"
 float __cuda_local_var_36831_8_non_const_xcoord;
# 757 "txInterpTest.cu"
 float __cuda_local_var_36832_8_non_const_ycoord;
# 758 "txInterpTest.cu"
 int __cuda_local_var_36833_6_non_const_im;
# 759 "txInterpTest.cu"
 int __cuda_local_var_36834_6_non_const_j;
# 760 "txInterpTest.cu"
 float __cuda_local_var_36835_8_non_const_f0;
# 760 "txInterpTest.cu"
 float __cuda_local_var_36835_11_non_const_f1;
# 760 "txInterpTest.cu"
 float __cuda_local_var_36835_14_non_const_f2;
# 760 "txInterpTest.cu"
 float __cuda_local_var_36835_17_non_const_f3;
# 760 "txInterpTest.cu"
 float __cuda_local_var_36835_20_non_const_f4;
# 760 "txInterpTest.cu"
 float __cuda_local_var_36835_23_non_const_f5;
# 760 "txInterpTest.cu"
 float __cuda_local_var_36835_26_non_const_f6;
# 760 "txInterpTest.cu"
 float __cuda_local_var_36835_29_non_const_f7;
# 760 "txInterpTest.cu"
 float __cuda_local_var_36835_32_non_const_f8;
# 754 "txInterpTest.cu"
__cuda_local_var_36829_6_non_const_x = ((int)((threadIdx.x) + ((blockIdx.x) * (blockDim.x))));
# 755 "txInterpTest.cu"
__cuda_local_var_36830_6_non_const_y = ((int)((threadIdx.y) + ((blockIdx.y) * (blockDim.y))));
# 756 "txInterpTest.cu"
__cuda_local_var_36831_8_non_const_xcoord = ((float)((415.625) + ((double)(((float)__cuda_local_var_36829_6_non_const_x) * (0.25F)))));
# 757 "txInterpTest.cu"
__cuda_local_var_36832_8_non_const_ycoord = ((float)((319.625) + ((double)(((float)__cuda_local_var_36830_6_non_const_y) * (0.25F)))));
# 758 "txInterpTest.cu"
__cuda_local_var_36833_6_non_const_im = (_Z8ImageFcnff(__cuda_local_var_36831_8_non_const_xcoord, __cuda_local_var_36832_8_non_const_ycoord));
# 759 "txInterpTest.cu"
__cuda_local_var_36834_6_non_const_j = ((int)(((unsigned long)__cuda_local_var_36829_6_non_const_x) + (((unsigned long)__cuda_local_var_36830_6_non_const_y) * pitch)));
# 762 "txInterpTest.cu"
if ((((__cuda_local_var_36829_6_non_const_x < n) || (__cuda_local_var_36829_6_non_const_x > (767 - n))) || (__cuda_local_var_36830_6_non_const_y < n)) || (__cuda_local_var_36830_6_non_const_y > (511 - n)))
# 763 "txInterpTest.cu"
{
# 765 "txInterpTest.cu"
}
# 766 "txInterpTest.cu"
else
# 766 "txInterpTest.cu"
{
# 766 "txInterpTest.cu"
 __texture_type__ __T2171;
# 767 "txInterpTest.cu"
 float __T2172;
# 768 "txInterpTest.cu"
 float __T2173;
# 769 "txInterpTest.cu"
 float4 __T2174;
# 770 "txInterpTest.cu"
 float4 __T2175;
# 771 "txInterpTest.cu"
 __texture_type__ __T2176;
# 772 "txInterpTest.cu"
 float __T2177;
# 773 "txInterpTest.cu"
 float __T2178;
# 774 "txInterpTest.cu"
 float4 __T2179;
# 775 "txInterpTest.cu"
 float4 __T2180;
# 776 "txInterpTest.cu"
 __texture_type__ __T2181;
# 777 "txInterpTest.cu"
 float __T2182;
# 778 "txInterpTest.cu"
 float __T2183;
# 779 "txInterpTest.cu"
 float4 __T2184;
# 780 "txInterpTest.cu"
 float4 __T2185;
# 781 "txInterpTest.cu"
 __texture_type__ __T2186;
# 782 "txInterpTest.cu"
 float __T2187;
# 783 "txInterpTest.cu"
 float __T2188;
# 784 "txInterpTest.cu"
 float4 __T2189;
# 785 "txInterpTest.cu"
 float4 __T2190;
# 786 "txInterpTest.cu"
 __texture_type__ __T2191;
# 787 "txInterpTest.cu"
 float __T2192;
# 788 "txInterpTest.cu"
 float __T2193;
# 789 "txInterpTest.cu"
 float4 __T2194;
# 790 "txInterpTest.cu"
 float4 __T2195;
# 791 "txInterpTest.cu"
 __texture_type__ __T2196;
# 792 "txInterpTest.cu"
 float __T2197;
# 793 "txInterpTest.cu"
 float __T2198;
# 794 "txInterpTest.cu"
 float4 __T2199;
# 795 "txInterpTest.cu"
 float4 __T2200;
# 767 "txInterpTest.cu"
__cuda_local_var_36835_8_non_const_f0 = (fin[__cuda_local_var_36834_6_non_const_j]);
# 768 "txInterpTest.cu"
__cuda_local_var_36835_14_non_const_f2 = (fin[((int)((((unsigned long)__cuda_local_var_36829_6_non_const_x) + (((unsigned long)(__cuda_local_var_36830_6_non_const_y - 1)) * pitch)) + ((2UL * pitch) * 512UL)))]);
# 769 "txInterpTest.cu"
__cuda_local_var_36835_20_non_const_f4 = (fin[((int)((((unsigned long)__cuda_local_var_36829_6_non_const_x) + (((unsigned long)(__cuda_local_var_36830_6_non_const_y + 1)) * pitch)) + ((4UL * pitch) * 512UL)))]);
# 770 "txInterpTest.cu"
__cuda_local_var_36835_11_non_const_f1 = ((((__T2171 = texRef_f1D) , ((void)(__T2172 = (((float)(__cuda_local_var_36829_6_non_const_x - 1)) + (0.5F))))) , ((void)(__T2173 = (((float)__cuda_local_var_36830_6_non_const_y) + (0.5F))))) , ((__T2175 = (__ftexfetch2D(__T2171, ((((((__T2174.x) = __T2172) , ((void)((__T2174.y) = __T2173))) , ((void)((__T2174.z) = (0.0F)))) , ((void)((__T2174.w) = (0.0F)))) , __T2174)))) , (__T2175.x)));
# 771 "txInterpTest.cu"
__cuda_local_var_36835_17_non_const_f3 = ((((__T2176 = texRef_f3D) , ((void)(__T2177 = (((float)(__cuda_local_var_36829_6_non_const_x + 1)) + (0.5F))))) , ((void)(__T2178 = (((float)__cuda_local_var_36830_6_non_const_y) + (0.5F))))) , ((__T2180 = (__ftexfetch2D(__T2176, ((((((__T2179.x) = __T2177) , ((void)((__T2179.y) = __T2178))) , ((void)((__T2179.z) = (0.0F)))) , ((void)((__T2179.w) = (0.0F)))) , __T2179)))) , (__T2180.x)));
# 772 "txInterpTest.cu"
__cuda_local_var_36835_23_non_const_f5 = ((((__T2181 = texRef_f5D) , ((void)(__T2182 = (((float)(__cuda_local_var_36829_6_non_const_x - 1)) + (0.5F))))) , ((void)(__T2183 = (((float)(__cuda_local_var_36830_6_non_const_y - 1)) + (0.5F))))) , ((__T2185 = (__ftexfetch2D(__T2181, ((((((__T2184.x) = __T2182) , ((void)((__T2184.y) = __T2183))) , ((void)((__T2184.z) = (0.0F)))) , ((void)((__T2184.w) = (0.0F)))) , __T2184)))) , (__T2185.x)));
# 773 "txInterpTest.cu"
__cuda_local_var_36835_26_non_const_f6 = ((((__T2186 = texRef_f6D) , ((void)(__T2187 = (((float)(__cuda_local_var_36829_6_non_const_x + 1)) + (0.5F))))) , ((void)(__T2188 = (((float)(__cuda_local_var_36830_6_non_const_y - 1)) + (0.5F))))) , ((__T2190 = (__ftexfetch2D(__T2186, ((((((__T2189.x) = __T2187) , ((void)((__T2189.y) = __T2188))) , ((void)((__T2189.z) = (0.0F)))) , ((void)((__T2189.w) = (0.0F)))) , __T2189)))) , (__T2190.x)));
# 774 "txInterpTest.cu"
__cuda_local_var_36835_29_non_const_f7 = ((((__T2191 = texRef_f7D) , ((void)(__T2192 = (((float)(__cuda_local_var_36829_6_non_const_x + 1)) + (0.5F))))) , ((void)(__T2193 = (((float)(__cuda_local_var_36830_6_non_const_y + 1)) + (0.5F))))) , ((__T2195 = (__ftexfetch2D(__T2191, ((((((__T2194.x) = __T2192) , ((void)((__T2194.y) = __T2193))) , ((void)((__T2194.z) = (0.0F)))) , ((void)((__T2194.w) = (0.0F)))) , __T2194)))) , (__T2195.x)));
# 775 "txInterpTest.cu"
__cuda_local_var_36835_32_non_const_f8 = ((((__T2196 = texRef_f8D) , ((void)(__T2197 = (((float)(__cuda_local_var_36829_6_non_const_x - 1)) + (0.5F))))) , ((void)(__T2198 = (((float)(__cuda_local_var_36830_6_non_const_y + 1)) + (0.5F))))) , ((__T2200 = (__ftexfetch2D(__T2196, ((((((__T2199.x) = __T2197) , ((void)((__T2199.y) = __T2198))) , ((void)((__T2199.z) = (0.0F)))) , ((void)((__T2199.w) = (0.0F)))) , __T2199)))) , (__T2200.x)));
# 777 "txInterpTest.cu"
if ((__cuda_local_var_36833_6_non_const_im == 1) || (__cuda_local_var_36833_6_non_const_im == 10))
# 777 "txInterpTest.cu"
{
# 778 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36829_6_non_const_x) + (((unsigned long)__cuda_local_var_36830_6_non_const_y) * pitch)) + ((1UL * pitch) * 512UL)))]) = __cuda_local_var_36835_17_non_const_f3;
# 779 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36829_6_non_const_x) + (((unsigned long)__cuda_local_var_36830_6_non_const_y) * pitch)) + ((2UL * pitch) * 512UL)))]) = __cuda_local_var_36835_20_non_const_f4;
# 780 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36829_6_non_const_x) + (((unsigned long)__cuda_local_var_36830_6_non_const_y) * pitch)) + ((3UL * pitch) * 512UL)))]) = __cuda_local_var_36835_11_non_const_f1;
# 781 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36829_6_non_const_x) + (((unsigned long)__cuda_local_var_36830_6_non_const_y) * pitch)) + ((4UL * pitch) * 512UL)))]) = __cuda_local_var_36835_14_non_const_f2;
# 782 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36829_6_non_const_x) + (((unsigned long)__cuda_local_var_36830_6_non_const_y) * pitch)) + ((5UL * pitch) * 512UL)))]) = __cuda_local_var_36835_29_non_const_f7;
# 783 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36829_6_non_const_x) + (((unsigned long)__cuda_local_var_36830_6_non_const_y) * pitch)) + ((6UL * pitch) * 512UL)))]) = __cuda_local_var_36835_32_non_const_f8;
# 784 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36829_6_non_const_x) + (((unsigned long)__cuda_local_var_36830_6_non_const_y) * pitch)) + ((7UL * pitch) * 512UL)))]) = __cuda_local_var_36835_23_non_const_f5;
# 785 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36829_6_non_const_x) + (((unsigned long)__cuda_local_var_36830_6_non_const_y) * pitch)) + ((8UL * pitch) * 512UL)))]) = __cuda_local_var_36835_26_non_const_f6;
# 786 "txInterpTest.cu"
}
# 787 "txInterpTest.cu"
else
# 787 "txInterpTest.cu"
{
# 788 "txInterpTest.cu"
if (((const char *)"BGK") == ((const char *)"MRT"))
# 788 "txInterpTest.cu"
{
# 789 "txInterpTest.cu"
_Z11mrt_collideRfS_S_S_S_S_S_S_S_f((&__cuda_local_var_36835_8_non_const_f0), (&__cuda_local_var_36835_11_non_const_f1), (&__cuda_local_var_36835_14_non_const_f2), (&__cuda_local_var_36835_17_non_const_f3), (&__cuda_local_var_36835_20_non_const_f4), (&__cuda_local_var_36835_23_non_const_f5), (&__cuda_local_var_36835_26_non_const_f6), (&__cuda_local_var_36835_29_non_const_f7), (&__cuda_local_var_36835_32_non_const_f8), omega);
# 789 "txInterpTest.cu"
}
# 789 "txInterpTest.cu"
else
# 789 "txInterpTest.cu"
{
# 790 "txInterpTest.cu"
if (1)
# 790 "txInterpTest.cu"
{
# 791 "txInterpTest.cu"
{
# 791 "txInterpTest.cu"
__T2167 = ((((((((__cuda_local_var_36835_8_non_const_f0 + __cuda_local_var_36835_11_non_const_f1) + __cuda_local_var_36835_14_non_const_f2) + __cuda_local_var_36835_17_non_const_f3) + __cuda_local_var_36835_20_non_const_f4) + __cuda_local_var_36835_23_non_const_f5) + __cuda_local_var_36835_26_non_const_f6) + __cuda_local_var_36835_29_non_const_f7) + __cuda_local_var_36835_32_non_const_f8);
# 791 "txInterpTest.cu"
__T2168 = (((((__cuda_local_var_36835_11_non_const_f1 - __cuda_local_var_36835_17_non_const_f3) + __cuda_local_var_36835_23_non_const_f5) - __cuda_local_var_36835_26_non_const_f6) - __cuda_local_var_36835_29_non_const_f7) + __cuda_local_var_36835_32_non_const_f8);
# 791 "txInterpTest.cu"
__T2169 = (((((__cuda_local_var_36835_14_non_const_f2 - __cuda_local_var_36835_20_non_const_f4) + __cuda_local_var_36835_23_non_const_f5) + __cuda_local_var_36835_26_non_const_f6) - __cuda_local_var_36835_29_non_const_f7) - __cuda_local_var_36835_32_non_const_f8);
# 791 "txInterpTest.cu"
__T2170 = ((__T2168 * __T2168) + (__T2169 * __T2169));
# 791 "txInterpTest.cu"
__cuda_local_var_36835_8_non_const_f0 = (__cuda_local_var_36835_8_non_const_f0 - (omega * (__cuda_local_var_36835_8_non_const_f0 - ((0.4444444478F) * (__T2167 - ((1.5F) * __T2170))))));
# 791 "txInterpTest.cu"
__cuda_local_var_36835_11_non_const_f1 = (__cuda_local_var_36835_11_non_const_f1 - (omega * (__cuda_local_var_36835_11_non_const_f1 - ((0.1111111119F) * (((__T2167 + ((3.0F) * __T2168)) + (((4.5F) * __T2168) * __T2168)) - ((1.5F) * __T2170))))));
# 791 "txInterpTest.cu"
__cuda_local_var_36835_14_non_const_f2 = (__cuda_local_var_36835_14_non_const_f2 - (omega * (__cuda_local_var_36835_14_non_const_f2 - ((0.1111111119F) * (((__T2167 + ((3.0F) * __T2169)) + (((4.5F) * __T2169) * __T2169)) - ((1.5F) * __T2170))))));
# 791 "txInterpTest.cu"
__cuda_local_var_36835_17_non_const_f3 = (__cuda_local_var_36835_17_non_const_f3 - (omega * (__cuda_local_var_36835_17_non_const_f3 - ((0.1111111119F) * (((__T2167 - ((3.0F) * __T2168)) + (((4.5F) * __T2168) * __T2168)) - ((1.5F) * __T2170))))));
# 791 "txInterpTest.cu"
__cuda_local_var_36835_20_non_const_f4 = (__cuda_local_var_36835_20_non_const_f4 - (omega * (__cuda_local_var_36835_20_non_const_f4 - ((0.1111111119F) * (((__T2167 - ((3.0F) * __T2169)) + (((4.5F) * __T2169) * __T2169)) - ((1.5F) * __T2170))))));
# 791 "txInterpTest.cu"
__cuda_local_var_36835_23_non_const_f5 = ((float)(((double)__cuda_local_var_36835_23_non_const_f5) - (((double)omega) * (((double)__cuda_local_var_36835_23_non_const_f5) - ((0.02777777777999999864) * ((double)(((__T2167 + ((3.0F) * (__T2168 + __T2169))) + (((4.5F) * (__T2168 + __T2169)) * (__T2168 + __T2169))) - ((1.5F) * __T2170))))))));
# 791 "txInterpTest.cu"
__cuda_local_var_36835_26_non_const_f6 = ((float)(((double)__cuda_local_var_36835_26_non_const_f6) - (((double)omega) * (((double)__cuda_local_var_36835_26_non_const_f6) - ((0.02777777777999999864) * ((double)(((__T2167 + ((3.0F) * ((-__T2168) + __T2169))) + (((4.5F) * ((-__T2168) + __T2169)) * ((-__T2168) + __T2169))) - ((1.5F) * __T2170))))))));
# 791 "txInterpTest.cu"
__cuda_local_var_36835_29_non_const_f7 = ((float)(((double)__cuda_local_var_36835_29_non_const_f7) - (((double)omega) * (((double)__cuda_local_var_36835_29_non_const_f7) - ((0.02777777777999999864) * ((double)(((__T2167 + ((3.0F) * ((-__T2168) - __T2169))) + (((4.5F) * ((-__T2168) - __T2169)) * ((-__T2168) - __T2169))) - ((1.5F) * __T2170))))))));
# 791 "txInterpTest.cu"
__cuda_local_var_36835_32_non_const_f8 = ((float)(((double)__cuda_local_var_36835_32_non_const_f8) - (((double)omega) * (((double)__cuda_local_var_36835_32_non_const_f8) - ((0.02777777777999999864) * ((double)(((__T2167 + ((3.0F) * (__T2168 - __T2169))) + (((4.5F) * (__T2168 - __T2169)) * (__T2168 - __T2169))) - ((1.5F) * __T2170))))))));
# 791 "txInterpTest.cu"
}
# 791 "txInterpTest.cu"
}
# 791 "txInterpTest.cu"
}
# 793 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36829_6_non_const_x) + (((unsigned long)__cuda_local_var_36830_6_non_const_y) * pitch)) + ((0UL * pitch) * 512UL)))]) = __cuda_local_var_36835_8_non_const_f0;
# 794 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36829_6_non_const_x) + (((unsigned long)__cuda_local_var_36830_6_non_const_y) * pitch)) + ((1UL * pitch) * 512UL)))]) = __cuda_local_var_36835_11_non_const_f1;
# 795 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36829_6_non_const_x) + (((unsigned long)__cuda_local_var_36830_6_non_const_y) * pitch)) + ((2UL * pitch) * 512UL)))]) = __cuda_local_var_36835_14_non_const_f2;
# 796 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36829_6_non_const_x) + (((unsigned long)__cuda_local_var_36830_6_non_const_y) * pitch)) + ((3UL * pitch) * 512UL)))]) = __cuda_local_var_36835_17_non_const_f3;
# 797 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36829_6_non_const_x) + (((unsigned long)__cuda_local_var_36830_6_non_const_y) * pitch)) + ((4UL * pitch) * 512UL)))]) = __cuda_local_var_36835_20_non_const_f4;
# 798 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36829_6_non_const_x) + (((unsigned long)__cuda_local_var_36830_6_non_const_y) * pitch)) + ((5UL * pitch) * 512UL)))]) = __cuda_local_var_36835_23_non_const_f5;
# 799 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36829_6_non_const_x) + (((unsigned long)__cuda_local_var_36830_6_non_const_y) * pitch)) + ((6UL * pitch) * 512UL)))]) = __cuda_local_var_36835_26_non_const_f6;
# 800 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36829_6_non_const_x) + (((unsigned long)__cuda_local_var_36830_6_non_const_y) * pitch)) + ((7UL * pitch) * 512UL)))]) = __cuda_local_var_36835_29_non_const_f7;
# 801 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36829_6_non_const_x) + (((unsigned long)__cuda_local_var_36830_6_non_const_y) * pitch)) + ((8UL * pitch) * 512UL)))]) = __cuda_local_var_36835_32_non_const_f8;
# 802 "txInterpTest.cu"
}
# 803 "txInterpTest.cu"
}
# 804 "txInterpTest.cu"
}
# 804 "txInterpTest.cu"
}}
# 805 "txInterpTest.cu"
__attribute__((global)) __attribute__((__used__)) void _Z10LR_d_ABDC2PfS_fmf(
# 805 "txInterpTest.cu"
float *fin,
# 805 "txInterpTest.cu"
float *fout,
# 806 "txInterpTest.cu"
float omega,
# 806 "txInterpTest.cu"
size_t pitch,
# 806 "txInterpTest.cu"
float SF){
# 806 "txInterpTest.cu"
{
# 807 "txInterpTest.cu"
{
# 808 "txInterpTest.cu"
 int __cuda_local_var_36883_6_non_const_x;
# 809 "txInterpTest.cu"
 int __cuda_local_var_36884_6_non_const_y;
# 810 "txInterpTest.cu"
 float __cuda_local_var_36885_8_non_const_xcoord;
# 811 "txInterpTest.cu"
 float __cuda_local_var_36886_8_non_const_ycoord;
# 812 "txInterpTest.cu"
 int __cuda_local_var_36887_6_non_const_im;
# 813 "txInterpTest.cu"
 int __cuda_local_var_36888_6_non_const_j;
# 814 "txInterpTest.cu"
 float __cuda_local_var_36889_8_non_const_f0;
# 814 "txInterpTest.cu"
 float __cuda_local_var_36889_11_non_const_f1;
# 814 "txInterpTest.cu"
 float __cuda_local_var_36889_14_non_const_f2;
# 814 "txInterpTest.cu"
 float __cuda_local_var_36889_17_non_const_f3;
# 814 "txInterpTest.cu"
 float __cuda_local_var_36889_20_non_const_f4;
# 814 "txInterpTest.cu"
 float __cuda_local_var_36889_23_non_const_f5;
# 814 "txInterpTest.cu"
 float __cuda_local_var_36889_26_non_const_f6;
# 814 "txInterpTest.cu"
 float __cuda_local_var_36889_29_non_const_f7;
# 814 "txInterpTest.cu"
 float __cuda_local_var_36889_32_non_const_f8;
# 808 "txInterpTest.cu"
__cuda_local_var_36883_6_non_const_x = ((int)((threadIdx.x) + ((blockIdx.x) * (blockDim.x))));
# 809 "txInterpTest.cu"
__cuda_local_var_36884_6_non_const_y = ((int)((threadIdx.y) + ((blockIdx.y) * (blockDim.y))));
# 810 "txInterpTest.cu"
__cuda_local_var_36885_8_non_const_xcoord = ((float)((415.625) + ((double)(((float)__cuda_local_var_36883_6_non_const_x) * (0.25F)))));
# 811 "txInterpTest.cu"
__cuda_local_var_36886_8_non_const_ycoord = ((float)((319.625) + ((double)(((float)__cuda_local_var_36884_6_non_const_y) * (0.25F)))));
# 812 "txInterpTest.cu"
__cuda_local_var_36887_6_non_const_im = (_Z8ImageFcnff(__cuda_local_var_36885_8_non_const_xcoord, __cuda_local_var_36886_8_non_const_ycoord));
# 813 "txInterpTest.cu"
__cuda_local_var_36888_6_non_const_j = ((int)(((unsigned long)__cuda_local_var_36883_6_non_const_x) + (((unsigned long)__cuda_local_var_36884_6_non_const_y) * pitch)));
# 821 "txInterpTest.cu"
__cuda_local_var_36889_8_non_const_f0 = (fin[__cuda_local_var_36888_6_non_const_j]);
# 822 "txInterpTest.cu"
__cuda_local_var_36889_11_non_const_f1 = (fin[((int)((((unsigned long)(__cuda_local_var_36883_6_non_const_x - 1)) + (((unsigned long)__cuda_local_var_36884_6_non_const_y) * pitch)) + ((1UL * pitch) * 512UL)))]);
# 823 "txInterpTest.cu"
__cuda_local_var_36889_14_non_const_f2 = (fin[((int)((((unsigned long)__cuda_local_var_36883_6_non_const_x) + (((unsigned long)(__cuda_local_var_36884_6_non_const_y - 1)) * pitch)) + ((2UL * pitch) * 512UL)))]);
# 824 "txInterpTest.cu"
__cuda_local_var_36889_17_non_const_f3 = (fin[((int)((((unsigned long)(__cuda_local_var_36883_6_non_const_x + 1)) + (((unsigned long)__cuda_local_var_36884_6_non_const_y) * pitch)) + ((3UL * pitch) * 512UL)))]);
# 825 "txInterpTest.cu"
__cuda_local_var_36889_20_non_const_f4 = (fin[((int)((((unsigned long)__cuda_local_var_36883_6_non_const_x) + (((unsigned long)(__cuda_local_var_36884_6_non_const_y + 1)) * pitch)) + ((4UL * pitch) * 512UL)))]);
# 826 "txInterpTest.cu"
__cuda_local_var_36889_23_non_const_f5 = (fin[((int)((((unsigned long)(__cuda_local_var_36883_6_non_const_x - 1)) + (((unsigned long)(__cuda_local_var_36884_6_non_const_y - 1)) * pitch)) + ((5UL * pitch) * 512UL)))]);
# 827 "txInterpTest.cu"
__cuda_local_var_36889_26_non_const_f6 = (fin[((int)((((unsigned long)(__cuda_local_var_36883_6_non_const_x + 1)) + (((unsigned long)(__cuda_local_var_36884_6_non_const_y - 1)) * pitch)) + ((6UL * pitch) * 512UL)))]);
# 828 "txInterpTest.cu"
__cuda_local_var_36889_29_non_const_f7 = (fin[((int)((((unsigned long)(__cuda_local_var_36883_6_non_const_x + 1)) + (((unsigned long)(__cuda_local_var_36884_6_non_const_y + 1)) * pitch)) + ((7UL * pitch) * 512UL)))]);
# 829 "txInterpTest.cu"
__cuda_local_var_36889_32_non_const_f8 = (fin[((int)((((unsigned long)(__cuda_local_var_36883_6_non_const_x - 1)) + (((unsigned long)(__cuda_local_var_36884_6_non_const_y + 1)) * pitch)) + ((8UL * pitch) * 512UL)))]);
# 831 "txInterpTest.cu"
if ((__cuda_local_var_36887_6_non_const_im == 1) || (__cuda_local_var_36887_6_non_const_im == 10))
# 831 "txInterpTest.cu"
{
# 832 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36883_6_non_const_x) + (((unsigned long)__cuda_local_var_36884_6_non_const_y) * pitch)) + ((1UL * pitch) * 512UL)))]) = __cuda_local_var_36889_17_non_const_f3;
# 833 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36883_6_non_const_x) + (((unsigned long)__cuda_local_var_36884_6_non_const_y) * pitch)) + ((2UL * pitch) * 512UL)))]) = __cuda_local_var_36889_20_non_const_f4;
# 834 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36883_6_non_const_x) + (((unsigned long)__cuda_local_var_36884_6_non_const_y) * pitch)) + ((3UL * pitch) * 512UL)))]) = __cuda_local_var_36889_11_non_const_f1;
# 835 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36883_6_non_const_x) + (((unsigned long)__cuda_local_var_36884_6_non_const_y) * pitch)) + ((4UL * pitch) * 512UL)))]) = __cuda_local_var_36889_14_non_const_f2;
# 836 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36883_6_non_const_x) + (((unsigned long)__cuda_local_var_36884_6_non_const_y) * pitch)) + ((5UL * pitch) * 512UL)))]) = __cuda_local_var_36889_29_non_const_f7;
# 837 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36883_6_non_const_x) + (((unsigned long)__cuda_local_var_36884_6_non_const_y) * pitch)) + ((6UL * pitch) * 512UL)))]) = __cuda_local_var_36889_32_non_const_f8;
# 838 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36883_6_non_const_x) + (((unsigned long)__cuda_local_var_36884_6_non_const_y) * pitch)) + ((7UL * pitch) * 512UL)))]) = __cuda_local_var_36889_23_non_const_f5;
# 839 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36883_6_non_const_x) + (((unsigned long)__cuda_local_var_36884_6_non_const_y) * pitch)) + ((8UL * pitch) * 512UL)))]) = __cuda_local_var_36889_26_non_const_f6;
# 840 "txInterpTest.cu"
}
# 841 "txInterpTest.cu"
else
# 841 "txInterpTest.cu"
{
# 842 "txInterpTest.cu"
if (((const char *)"BGK") == ((const char *)"MRT"))
# 842 "txInterpTest.cu"
{
# 843 "txInterpTest.cu"
_Z11mrt_collideRfS_S_S_S_S_S_S_S_f((&__cuda_local_var_36889_8_non_const_f0), (&__cuda_local_var_36889_11_non_const_f1), (&__cuda_local_var_36889_14_non_const_f2), (&__cuda_local_var_36889_17_non_const_f3), (&__cuda_local_var_36889_20_non_const_f4), (&__cuda_local_var_36889_23_non_const_f5), (&__cuda_local_var_36889_26_non_const_f6), (&__cuda_local_var_36889_29_non_const_f7), (&__cuda_local_var_36889_32_non_const_f8), omega);
# 843 "txInterpTest.cu"
}
# 843 "txInterpTest.cu"
else
# 843 "txInterpTest.cu"
{
# 844 "txInterpTest.cu"
if (1)
# 844 "txInterpTest.cu"
{
# 844 "txInterpTest.cu"
 float __T2201;
# 845 "txInterpTest.cu"
 float __T2202;
# 846 "txInterpTest.cu"
 float __T2203;
# 847 "txInterpTest.cu"
 float __T2204;
# 845 "txInterpTest.cu"
{
# 845 "txInterpTest.cu"
__T2201 = ((((((((__cuda_local_var_36889_8_non_const_f0 + __cuda_local_var_36889_11_non_const_f1) + __cuda_local_var_36889_14_non_const_f2) + __cuda_local_var_36889_17_non_const_f3) + __cuda_local_var_36889_20_non_const_f4) + __cuda_local_var_36889_23_non_const_f5) + __cuda_local_var_36889_26_non_const_f6) + __cuda_local_var_36889_29_non_const_f7) + __cuda_local_var_36889_32_non_const_f8);
# 845 "txInterpTest.cu"
__T2202 = (((((__cuda_local_var_36889_11_non_const_f1 - __cuda_local_var_36889_17_non_const_f3) + __cuda_local_var_36889_23_non_const_f5) - __cuda_local_var_36889_26_non_const_f6) - __cuda_local_var_36889_29_non_const_f7) + __cuda_local_var_36889_32_non_const_f8);
# 845 "txInterpTest.cu"
__T2203 = (((((__cuda_local_var_36889_14_non_const_f2 - __cuda_local_var_36889_20_non_const_f4) + __cuda_local_var_36889_23_non_const_f5) + __cuda_local_var_36889_26_non_const_f6) - __cuda_local_var_36889_29_non_const_f7) - __cuda_local_var_36889_32_non_const_f8);
# 845 "txInterpTest.cu"
__T2204 = ((__T2202 * __T2202) + (__T2203 * __T2203));
# 845 "txInterpTest.cu"
__cuda_local_var_36889_8_non_const_f0 = (__cuda_local_var_36889_8_non_const_f0 - (omega * (__cuda_local_var_36889_8_non_const_f0 - ((0.4444444478F) * (__T2201 - ((1.5F) * __T2204))))));
# 845 "txInterpTest.cu"
__cuda_local_var_36889_11_non_const_f1 = (__cuda_local_var_36889_11_non_const_f1 - (omega * (__cuda_local_var_36889_11_non_const_f1 - ((0.1111111119F) * (((__T2201 + ((3.0F) * __T2202)) + (((4.5F) * __T2202) * __T2202)) - ((1.5F) * __T2204))))));
# 845 "txInterpTest.cu"
__cuda_local_var_36889_14_non_const_f2 = (__cuda_local_var_36889_14_non_const_f2 - (omega * (__cuda_local_var_36889_14_non_const_f2 - ((0.1111111119F) * (((__T2201 + ((3.0F) * __T2203)) + (((4.5F) * __T2203) * __T2203)) - ((1.5F) * __T2204))))));
# 845 "txInterpTest.cu"
__cuda_local_var_36889_17_non_const_f3 = (__cuda_local_var_36889_17_non_const_f3 - (omega * (__cuda_local_var_36889_17_non_const_f3 - ((0.1111111119F) * (((__T2201 - ((3.0F) * __T2202)) + (((4.5F) * __T2202) * __T2202)) - ((1.5F) * __T2204))))));
# 845 "txInterpTest.cu"
__cuda_local_var_36889_20_non_const_f4 = (__cuda_local_var_36889_20_non_const_f4 - (omega * (__cuda_local_var_36889_20_non_const_f4 - ((0.1111111119F) * (((__T2201 - ((3.0F) * __T2203)) + (((4.5F) * __T2203) * __T2203)) - ((1.5F) * __T2204))))));
# 845 "txInterpTest.cu"
__cuda_local_var_36889_23_non_const_f5 = ((float)(((double)__cuda_local_var_36889_23_non_const_f5) - (((double)omega) * (((double)__cuda_local_var_36889_23_non_const_f5) - ((0.02777777777999999864) * ((double)(((__T2201 + ((3.0F) * (__T2202 + __T2203))) + (((4.5F) * (__T2202 + __T2203)) * (__T2202 + __T2203))) - ((1.5F) * __T2204))))))));
# 845 "txInterpTest.cu"
__cuda_local_var_36889_26_non_const_f6 = ((float)(((double)__cuda_local_var_36889_26_non_const_f6) - (((double)omega) * (((double)__cuda_local_var_36889_26_non_const_f6) - ((0.02777777777999999864) * ((double)(((__T2201 + ((3.0F) * ((-__T2202) + __T2203))) + (((4.5F) * ((-__T2202) + __T2203)) * ((-__T2202) + __T2203))) - ((1.5F) * __T2204))))))));
# 845 "txInterpTest.cu"
__cuda_local_var_36889_29_non_const_f7 = ((float)(((double)__cuda_local_var_36889_29_non_const_f7) - (((double)omega) * (((double)__cuda_local_var_36889_29_non_const_f7) - ((0.02777777777999999864) * ((double)(((__T2201 + ((3.0F) * ((-__T2202) - __T2203))) + (((4.5F) * ((-__T2202) - __T2203)) * ((-__T2202) - __T2203))) - ((1.5F) * __T2204))))))));
# 845 "txInterpTest.cu"
__cuda_local_var_36889_32_non_const_f8 = ((float)(((double)__cuda_local_var_36889_32_non_const_f8) - (((double)omega) * (((double)__cuda_local_var_36889_32_non_const_f8) - ((0.02777777777999999864) * ((double)(((__T2201 + ((3.0F) * (__T2202 - __T2203))) + (((4.5F) * (__T2202 - __T2203)) * (__T2202 - __T2203))) - ((1.5F) * __T2204))))))));
# 845 "txInterpTest.cu"
}
# 845 "txInterpTest.cu"
}
# 845 "txInterpTest.cu"
}
# 847 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36883_6_non_const_x) + (((unsigned long)__cuda_local_var_36884_6_non_const_y) * pitch)) + ((0UL * pitch) * 512UL)))]) = __cuda_local_var_36889_8_non_const_f0;
# 848 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36883_6_non_const_x) + (((unsigned long)__cuda_local_var_36884_6_non_const_y) * pitch)) + ((1UL * pitch) * 512UL)))]) = __cuda_local_var_36889_11_non_const_f1;
# 849 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36883_6_non_const_x) + (((unsigned long)__cuda_local_var_36884_6_non_const_y) * pitch)) + ((2UL * pitch) * 512UL)))]) = __cuda_local_var_36889_14_non_const_f2;
# 850 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36883_6_non_const_x) + (((unsigned long)__cuda_local_var_36884_6_non_const_y) * pitch)) + ((3UL * pitch) * 512UL)))]) = __cuda_local_var_36889_17_non_const_f3;
# 851 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36883_6_non_const_x) + (((unsigned long)__cuda_local_var_36884_6_non_const_y) * pitch)) + ((4UL * pitch) * 512UL)))]) = __cuda_local_var_36889_20_non_const_f4;
# 852 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36883_6_non_const_x) + (((unsigned long)__cuda_local_var_36884_6_non_const_y) * pitch)) + ((5UL * pitch) * 512UL)))]) = __cuda_local_var_36889_23_non_const_f5;
# 853 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36883_6_non_const_x) + (((unsigned long)__cuda_local_var_36884_6_non_const_y) * pitch)) + ((6UL * pitch) * 512UL)))]) = __cuda_local_var_36889_26_non_const_f6;
# 854 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36883_6_non_const_x) + (((unsigned long)__cuda_local_var_36884_6_non_const_y) * pitch)) + ((7UL * pitch) * 512UL)))]) = __cuda_local_var_36889_29_non_const_f7;
# 855 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36883_6_non_const_x) + (((unsigned long)__cuda_local_var_36884_6_non_const_y) * pitch)) + ((8UL * pitch) * 512UL)))]) = __cuda_local_var_36889_32_non_const_f8;
# 856 "txInterpTest.cu"
}
# 858 "txInterpTest.cu"
}
# 858 "txInterpTest.cu"
}}
# 860 "txInterpTest.cu"
__attribute__((global)) __attribute__((__used__)) void _Z16LR_d_ABDC_InterpPfS_fmf(
# 860 "txInterpTest.cu"
float *fin,
# 860 "txInterpTest.cu"
float *fout,
# 861 "txInterpTest.cu"
float omega,
# 861 "txInterpTest.cu"
size_t pitch,
# 861 "txInterpTest.cu"
float SF){
# 861 "txInterpTest.cu"
{
# 862 "txInterpTest.cu"
{
# 862 "txInterpTest.cu"
 float __T2205;
# 863 "txInterpTest.cu"
 float __T2206;
# 864 "txInterpTest.cu"
 float __T2207;
# 865 "txInterpTest.cu"
 float __T2208;
# 863 "txInterpTest.cu"
 int __cuda_local_var_36938_6_non_const_x;
# 864 "txInterpTest.cu"
 int __cuda_local_var_36939_6_non_const_y;
# 865 "txInterpTest.cu"
 float __cuda_local_var_36940_8_non_const_xcoord;
# 866 "txInterpTest.cu"
 float __cuda_local_var_36941_8_non_const_ycoord;
# 867 "txInterpTest.cu"
 int __cuda_local_var_36942_6_non_const_im;
# 868 "txInterpTest.cu"
 int __cuda_local_var_36943_6_non_const_j;
# 869 "txInterpTest.cu"
 float __cuda_local_var_36944_8_non_const_f0;
# 869 "txInterpTest.cu"
 float __cuda_local_var_36944_11_non_const_f1;
# 869 "txInterpTest.cu"
 float __cuda_local_var_36944_14_non_const_f2;
# 869 "txInterpTest.cu"
 float __cuda_local_var_36944_17_non_const_f3;
# 869 "txInterpTest.cu"
 float __cuda_local_var_36944_20_non_const_f4;
# 869 "txInterpTest.cu"
 float __cuda_local_var_36944_23_non_const_f5;
# 869 "txInterpTest.cu"
 float __cuda_local_var_36944_26_non_const_f6;
# 869 "txInterpTest.cu"
 float __cuda_local_var_36944_29_non_const_f7;
# 869 "txInterpTest.cu"
 float __cuda_local_var_36944_32_non_const_f8;
# 863 "txInterpTest.cu"
__cuda_local_var_36938_6_non_const_x = ((int)((threadIdx.x) + ((blockIdx.x) * (blockDim.x))));
# 864 "txInterpTest.cu"
__cuda_local_var_36939_6_non_const_y = ((int)((threadIdx.y) + ((blockIdx.y) * (blockDim.y))));
# 865 "txInterpTest.cu"
__cuda_local_var_36940_8_non_const_xcoord = ((float)((415.625) + ((double)(((float)__cuda_local_var_36938_6_non_const_x) * (0.25F)))));
# 866 "txInterpTest.cu"
__cuda_local_var_36941_8_non_const_ycoord = ((float)((319.625) + ((double)(((float)__cuda_local_var_36939_6_non_const_y) * (0.25F)))));
# 867 "txInterpTest.cu"
__cuda_local_var_36942_6_non_const_im = (_Z8ImageFcnff(__cuda_local_var_36940_8_non_const_xcoord, __cuda_local_var_36941_8_non_const_ycoord));
# 868 "txInterpTest.cu"
__cuda_local_var_36943_6_non_const_j = ((int)(((unsigned long)__cuda_local_var_36938_6_non_const_x) + (((unsigned long)__cuda_local_var_36939_6_non_const_y) * pitch)));
# 871 "txInterpTest.cu"
if ((((__cuda_local_var_36938_6_non_const_x < 4) || (__cuda_local_var_36938_6_non_const_x > 763)) || (__cuda_local_var_36939_6_non_const_y < 4)) || (__cuda_local_var_36939_6_non_const_y > 507))
# 873 "txInterpTest.cu"
{
# 873 "txInterpTest.cu"
 __texture_type__ __T2209;
# 874 "txInterpTest.cu"
 float __T2210;
# 875 "txInterpTest.cu"
 float __T2211;
# 876 "txInterpTest.cu"
 float4 __T2212;
# 877 "txInterpTest.cu"
 float4 __T2213;
# 878 "txInterpTest.cu"
 __texture_type__ __T2214;
# 879 "txInterpTest.cu"
 float __T2215;
# 880 "txInterpTest.cu"
 float __T2216;
# 881 "txInterpTest.cu"
 float4 __T2217;
# 882 "txInterpTest.cu"
 float4 __T2218;
# 883 "txInterpTest.cu"
 __texture_type__ __T2219;
# 884 "txInterpTest.cu"
 float __T2220;
# 885 "txInterpTest.cu"
 float __T2221;
# 886 "txInterpTest.cu"
 float4 __T2222;
# 887 "txInterpTest.cu"
 float4 __T2223;
# 888 "txInterpTest.cu"
 __texture_type__ __T2224;
# 889 "txInterpTest.cu"
 float __T2225;
# 890 "txInterpTest.cu"
 float __T2226;
# 891 "txInterpTest.cu"
 float4 __T2227;
# 892 "txInterpTest.cu"
 float4 __T2228;
# 893 "txInterpTest.cu"
 __texture_type__ __T2229;
# 894 "txInterpTest.cu"
 float __T2230;
# 895 "txInterpTest.cu"
 float __T2231;
# 896 "txInterpTest.cu"
 float4 __T2232;
# 897 "txInterpTest.cu"
 float4 __T2233;
# 898 "txInterpTest.cu"
 __texture_type__ __T2234;
# 899 "txInterpTest.cu"
 float __T2235;
# 900 "txInterpTest.cu"
 float __T2236;
# 901 "txInterpTest.cu"
 float4 __T2237;
# 902 "txInterpTest.cu"
 float4 __T2238;
# 903 "txInterpTest.cu"
 __texture_type__ __T2239;
# 904 "txInterpTest.cu"
 float __T2240;
# 905 "txInterpTest.cu"
 float __T2241;
# 906 "txInterpTest.cu"
 float4 __T2242;
# 907 "txInterpTest.cu"
 float4 __T2243;
# 908 "txInterpTest.cu"
 __texture_type__ __T2244;
# 909 "txInterpTest.cu"
 float __T2245;
# 910 "txInterpTest.cu"
 float __T2246;
# 911 "txInterpTest.cu"
 float4 __T2247;
# 912 "txInterpTest.cu"
 float4 __T2248;
# 913 "txInterpTest.cu"
 __texture_type__ __T2249;
# 914 "txInterpTest.cu"
 float __T2250;
# 915 "txInterpTest.cu"
 float __T2251;
# 916 "txInterpTest.cu"
 float4 __T2252;
# 917 "txInterpTest.cu"
 float4 __T2253;
# 885 "txInterpTest.cu"
 float __cuda_local_var_36960_8_non_const_rho;
# 885 "txInterpTest.cu"
 float __cuda_local_var_36960_12_non_const_u;
# 885 "txInterpTest.cu"
 float __cuda_local_var_36960_14_non_const_v;
# 889 "txInterpTest.cu"
 float __cuda_local_var_36964_8_non_const_usqr;
# 875 "txInterpTest.cu"
__cuda_local_var_36944_8_non_const_f0 = ((((__T2209 = texRef_f0B) , ((void)(__T2210 = (__cuda_local_var_36940_8_non_const_xcoord + (0.5F))))) , ((void)(__T2211 = (__cuda_local_var_36941_8_non_const_ycoord + (0.5F))))) , ((__T2213 = (__ftexfetch2D(__T2209, ((((((__T2212.x) = __T2210) , ((void)((__T2212.y) = __T2211))) , ((void)((__T2212.z) = (0.0F)))) , ((void)((__T2212.w) = (0.0F)))) , __T2212)))) , (__T2213.x)));
# 876 "txInterpTest.cu"
__cuda_local_var_36944_11_non_const_f1 = ((((__T2214 = texRef_f1B) , ((void)(__T2215 = (__cuda_local_var_36940_8_non_const_xcoord + (0.5F))))) , ((void)(__T2216 = (__cuda_local_var_36941_8_non_const_ycoord + (0.5F))))) , ((__T2218 = (__ftexfetch2D(__T2214, ((((((__T2217.x) = __T2215) , ((void)((__T2217.y) = __T2216))) , ((void)((__T2217.z) = (0.0F)))) , ((void)((__T2217.w) = (0.0F)))) , __T2217)))) , (__T2218.x)));
# 877 "txInterpTest.cu"
__cuda_local_var_36944_14_non_const_f2 = ((((__T2219 = texRef_f2B) , ((void)(__T2220 = (__cuda_local_var_36940_8_non_const_xcoord + (0.5F))))) , ((void)(__T2221 = (__cuda_local_var_36941_8_non_const_ycoord + (0.5F))))) , ((__T2223 = (__ftexfetch2D(__T2219, ((((((__T2222.x) = __T2220) , ((void)((__T2222.y) = __T2221))) , ((void)((__T2222.z) = (0.0F)))) , ((void)((__T2222.w) = (0.0F)))) , __T2222)))) , (__T2223.x)));
# 878 "txInterpTest.cu"
__cuda_local_var_36944_17_non_const_f3 = ((((__T2224 = texRef_f3B) , ((void)(__T2225 = (__cuda_local_var_36940_8_non_const_xcoord + (0.5F))))) , ((void)(__T2226 = (__cuda_local_var_36941_8_non_const_ycoord + (0.5F))))) , ((__T2228 = (__ftexfetch2D(__T2224, ((((((__T2227.x) = __T2225) , ((void)((__T2227.y) = __T2226))) , ((void)((__T2227.z) = (0.0F)))) , ((void)((__T2227.w) = (0.0F)))) , __T2227)))) , (__T2228.x)));
# 879 "txInterpTest.cu"
__cuda_local_var_36944_20_non_const_f4 = ((((__T2229 = texRef_f4B) , ((void)(__T2230 = (__cuda_local_var_36940_8_non_const_xcoord + (0.5F))))) , ((void)(__T2231 = (__cuda_local_var_36941_8_non_const_ycoord + (0.5F))))) , ((__T2233 = (__ftexfetch2D(__T2229, ((((((__T2232.x) = __T2230) , ((void)((__T2232.y) = __T2231))) , ((void)((__T2232.z) = (0.0F)))) , ((void)((__T2232.w) = (0.0F)))) , __T2232)))) , (__T2233.x)));
# 880 "txInterpTest.cu"
__cuda_local_var_36944_23_non_const_f5 = ((((__T2234 = texRef_f5B) , ((void)(__T2235 = (__cuda_local_var_36940_8_non_const_xcoord + (0.5F))))) , ((void)(__T2236 = (__cuda_local_var_36941_8_non_const_ycoord + (0.5F))))) , ((__T2238 = (__ftexfetch2D(__T2234, ((((((__T2237.x) = __T2235) , ((void)((__T2237.y) = __T2236))) , ((void)((__T2237.z) = (0.0F)))) , ((void)((__T2237.w) = (0.0F)))) , __T2237)))) , (__T2238.x)));
# 881 "txInterpTest.cu"
__cuda_local_var_36944_26_non_const_f6 = ((((__T2239 = texRef_f6B) , ((void)(__T2240 = (__cuda_local_var_36940_8_non_const_xcoord + (0.5F))))) , ((void)(__T2241 = (__cuda_local_var_36941_8_non_const_ycoord + (0.5F))))) , ((__T2243 = (__ftexfetch2D(__T2239, ((((((__T2242.x) = __T2240) , ((void)((__T2242.y) = __T2241))) , ((void)((__T2242.z) = (0.0F)))) , ((void)((__T2242.w) = (0.0F)))) , __T2242)))) , (__T2243.x)));
# 882 "txInterpTest.cu"
__cuda_local_var_36944_29_non_const_f7 = ((((__T2244 = texRef_f7B) , ((void)(__T2245 = (__cuda_local_var_36940_8_non_const_xcoord + (0.5F))))) , ((void)(__T2246 = (__cuda_local_var_36941_8_non_const_ycoord + (0.5F))))) , ((__T2248 = (__ftexfetch2D(__T2244, ((((((__T2247.x) = __T2245) , ((void)((__T2247.y) = __T2246))) , ((void)((__T2247.z) = (0.0F)))) , ((void)((__T2247.w) = (0.0F)))) , __T2247)))) , (__T2248.x)));
# 883 "txInterpTest.cu"
__cuda_local_var_36944_32_non_const_f8 = ((((__T2249 = texRef_f8B) , ((void)(__T2250 = (__cuda_local_var_36940_8_non_const_xcoord + (0.5F))))) , ((void)(__T2251 = (__cuda_local_var_36941_8_non_const_ycoord + (0.5F))))) , ((__T2253 = (__ftexfetch2D(__T2249, ((((((__T2252.x) = __T2250) , ((void)((__T2252.y) = __T2251))) , ((void)((__T2252.z) = (0.0F)))) , ((void)((__T2252.w) = (0.0F)))) , __T2252)))) , (__T2253.x)));
# 886 "txInterpTest.cu"
__cuda_local_var_36960_8_non_const_rho = ((((((((__cuda_local_var_36944_8_non_const_f0 + __cuda_local_var_36944_11_non_const_f1) + __cuda_local_var_36944_14_non_const_f2) + __cuda_local_var_36944_17_non_const_f3) + __cuda_local_var_36944_20_non_const_f4) + __cuda_local_var_36944_23_non_const_f5) + __cuda_local_var_36944_26_non_const_f6) + __cuda_local_var_36944_29_non_const_f7) + __cuda_local_var_36944_32_non_const_f8);
# 887 "txInterpTest.cu"
__cuda_local_var_36960_12_non_const_u = (((((__cuda_local_var_36944_11_non_const_f1 - __cuda_local_var_36944_17_non_const_f3) + __cuda_local_var_36944_23_non_const_f5) - __cuda_local_var_36944_26_non_const_f6) - __cuda_local_var_36944_29_non_const_f7) + __cuda_local_var_36944_32_non_const_f8);
# 888 "txInterpTest.cu"
__cuda_local_var_36960_14_non_const_v = (((((__cuda_local_var_36944_14_non_const_f2 - __cuda_local_var_36944_20_non_const_f4) + __cuda_local_var_36944_23_non_const_f5) + __cuda_local_var_36944_26_non_const_f6) - __cuda_local_var_36944_29_non_const_f7) - __cuda_local_var_36944_32_non_const_f8);
# 889 "txInterpTest.cu"
__cuda_local_var_36964_8_non_const_usqr = ((__cuda_local_var_36960_12_non_const_u * __cuda_local_var_36960_12_non_const_u) + (__cuda_local_var_36960_14_non_const_v * __cuda_local_var_36960_14_non_const_v));
# 891 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36938_6_non_const_x) + (((unsigned long)__cuda_local_var_36939_6_non_const_y) * pitch)) + ((0UL * pitch) * 512UL)))]) = ((SF * __cuda_local_var_36944_8_non_const_f0) + (((1.0F) - SF) * ((0.4444444478F) * (__cuda_local_var_36960_8_non_const_rho - ((1.5F) * __cuda_local_var_36964_8_non_const_usqr)))));
# 892 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36938_6_non_const_x) + (((unsigned long)__cuda_local_var_36939_6_non_const_y) * pitch)) + ((1UL * pitch) * 512UL)))]) = ((SF * __cuda_local_var_36944_11_non_const_f1) + (((1.0F) - SF) * ((0.1111111119F) * (((__cuda_local_var_36960_8_non_const_rho + ((3.0F) * __cuda_local_var_36960_12_non_const_u)) + (((4.5F) * __cuda_local_var_36960_12_non_const_u) * __cuda_local_var_36960_12_non_const_u)) - ((1.5F) * __cuda_local_var_36964_8_non_const_usqr)))));
# 893 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36938_6_non_const_x) + (((unsigned long)__cuda_local_var_36939_6_non_const_y) * pitch)) + ((2UL * pitch) * 512UL)))]) = ((SF * __cuda_local_var_36944_14_non_const_f2) + (((1.0F) - SF) * ((0.1111111119F) * (((__cuda_local_var_36960_8_non_const_rho + ((3.0F) * __cuda_local_var_36960_14_non_const_v)) + (((4.5F) * __cuda_local_var_36960_14_non_const_v) * __cuda_local_var_36960_14_non_const_v)) - ((1.5F) * __cuda_local_var_36964_8_non_const_usqr)))));
# 894 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36938_6_non_const_x) + (((unsigned long)__cuda_local_var_36939_6_non_const_y) * pitch)) + ((3UL * pitch) * 512UL)))]) = ((SF * __cuda_local_var_36944_17_non_const_f3) + (((1.0F) - SF) * ((0.1111111119F) * (((__cuda_local_var_36960_8_non_const_rho - ((3.0F) * __cuda_local_var_36960_12_non_const_u)) + (((4.5F) * __cuda_local_var_36960_12_non_const_u) * __cuda_local_var_36960_12_non_const_u)) - ((1.5F) * __cuda_local_var_36964_8_non_const_usqr)))));
# 895 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36938_6_non_const_x) + (((unsigned long)__cuda_local_var_36939_6_non_const_y) * pitch)) + ((4UL * pitch) * 512UL)))]) = ((SF * __cuda_local_var_36944_20_non_const_f4) + (((1.0F) - SF) * ((0.1111111119F) * (((__cuda_local_var_36960_8_non_const_rho - ((3.0F) * __cuda_local_var_36960_14_non_const_v)) + (((4.5F) * __cuda_local_var_36960_14_non_const_v) * __cuda_local_var_36960_14_non_const_v)) - ((1.5F) * __cuda_local_var_36964_8_non_const_usqr)))));
# 896 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36938_6_non_const_x) + (((unsigned long)__cuda_local_var_36939_6_non_const_y) * pitch)) + ((5UL * pitch) * 512UL)))]) = ((float)(((double)(SF * __cuda_local_var_36944_23_non_const_f5)) + (((double)((1.0F) - SF)) * ((0.02777777777999999864) * ((double)(((__cuda_local_var_36960_8_non_const_rho + ((3.0F) * (__cuda_local_var_36960_12_non_const_u + __cuda_local_var_36960_14_non_const_v))) + (((4.5F) * (__cuda_local_var_36960_12_non_const_u + __cuda_local_var_36960_14_non_const_v)) * (__cuda_local_var_36960_12_non_const_u + __cuda_local_var_36960_14_non_const_v))) - ((1.5F) * __cuda_local_var_36964_8_non_const_usqr)))))));
# 897 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36938_6_non_const_x) + (((unsigned long)__cuda_local_var_36939_6_non_const_y) * pitch)) + ((6UL * pitch) * 512UL)))]) = ((float)(((double)(SF * __cuda_local_var_36944_26_non_const_f6)) + (((double)((1.0F) - SF)) * ((0.02777777777999999864) * ((double)(((__cuda_local_var_36960_8_non_const_rho + ((3.0F) * ((-__cuda_local_var_36960_12_non_const_u) + __cuda_local_var_36960_14_non_const_v))) + (((4.5F) * ((-__cuda_local_var_36960_12_non_const_u) + __cuda_local_var_36960_14_non_const_v)) * ((-__cuda_local_var_36960_12_non_const_u) + __cuda_local_var_36960_14_non_const_v))) - ((1.5F) * __cuda_local_var_36964_8_non_const_usqr)))))));
# 898 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36938_6_non_const_x) + (((unsigned long)__cuda_local_var_36939_6_non_const_y) * pitch)) + ((7UL * pitch) * 512UL)))]) = ((float)(((double)(SF * __cuda_local_var_36944_29_non_const_f7)) + (((double)((1.0F) - SF)) * ((0.02777777777999999864) * ((double)(((__cuda_local_var_36960_8_non_const_rho + ((3.0F) * ((-__cuda_local_var_36960_12_non_const_u) - __cuda_local_var_36960_14_non_const_v))) + (((4.5F) * ((-__cuda_local_var_36960_12_non_const_u) - __cuda_local_var_36960_14_non_const_v)) * ((-__cuda_local_var_36960_12_non_const_u) - __cuda_local_var_36960_14_non_const_v))) - ((1.5F) * __cuda_local_var_36964_8_non_const_usqr)))))));
# 899 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36938_6_non_const_x) + (((unsigned long)__cuda_local_var_36939_6_non_const_y) * pitch)) + ((8UL * pitch) * 512UL)))]) = ((float)(((double)(SF * __cuda_local_var_36944_32_non_const_f8)) + (((double)((1.0F) - SF)) * ((0.02777777777999999864) * ((double)(((__cuda_local_var_36960_8_non_const_rho + ((3.0F) * (__cuda_local_var_36960_12_non_const_u - __cuda_local_var_36960_14_non_const_v))) + (((4.5F) * (__cuda_local_var_36960_12_non_const_u - __cuda_local_var_36960_14_non_const_v)) * (__cuda_local_var_36960_12_non_const_u - __cuda_local_var_36960_14_non_const_v))) - ((1.5F) * __cuda_local_var_36964_8_non_const_usqr)))))));
# 901 "txInterpTest.cu"
}
# 902 "txInterpTest.cu"
else
# 902 "txInterpTest.cu"
{
# 903 "txInterpTest.cu"
__cuda_local_var_36944_8_non_const_f0 = (fin[__cuda_local_var_36943_6_non_const_j]);
# 904 "txInterpTest.cu"
__cuda_local_var_36944_11_non_const_f1 = (fin[((int)((((unsigned long)(__cuda_local_var_36938_6_non_const_x - 1)) + (((unsigned long)__cuda_local_var_36939_6_non_const_y) * pitch)) + ((1UL * pitch) * 512UL)))]);
# 905 "txInterpTest.cu"
__cuda_local_var_36944_14_non_const_f2 = (fin[((int)((((unsigned long)__cuda_local_var_36938_6_non_const_x) + (((unsigned long)(__cuda_local_var_36939_6_non_const_y - 1)) * pitch)) + ((2UL * pitch) * 512UL)))]);
# 906 "txInterpTest.cu"
__cuda_local_var_36944_17_non_const_f3 = (fin[((int)((((unsigned long)(__cuda_local_var_36938_6_non_const_x + 1)) + (((unsigned long)__cuda_local_var_36939_6_non_const_y) * pitch)) + ((3UL * pitch) * 512UL)))]);
# 907 "txInterpTest.cu"
__cuda_local_var_36944_20_non_const_f4 = (fin[((int)((((unsigned long)__cuda_local_var_36938_6_non_const_x) + (((unsigned long)(__cuda_local_var_36939_6_non_const_y + 1)) * pitch)) + ((4UL * pitch) * 512UL)))]);
# 908 "txInterpTest.cu"
__cuda_local_var_36944_23_non_const_f5 = (fin[((int)((((unsigned long)(__cuda_local_var_36938_6_non_const_x - 1)) + (((unsigned long)(__cuda_local_var_36939_6_non_const_y - 1)) * pitch)) + ((5UL * pitch) * 512UL)))]);
# 909 "txInterpTest.cu"
__cuda_local_var_36944_26_non_const_f6 = (fin[((int)((((unsigned long)(__cuda_local_var_36938_6_non_const_x + 1)) + (((unsigned long)(__cuda_local_var_36939_6_non_const_y - 1)) * pitch)) + ((6UL * pitch) * 512UL)))]);
# 910 "txInterpTest.cu"
__cuda_local_var_36944_29_non_const_f7 = (fin[((int)((((unsigned long)(__cuda_local_var_36938_6_non_const_x + 1)) + (((unsigned long)(__cuda_local_var_36939_6_non_const_y + 1)) * pitch)) + ((7UL * pitch) * 512UL)))]);
# 911 "txInterpTest.cu"
__cuda_local_var_36944_32_non_const_f8 = (fin[((int)((((unsigned long)(__cuda_local_var_36938_6_non_const_x - 1)) + (((unsigned long)(__cuda_local_var_36939_6_non_const_y + 1)) * pitch)) + ((8UL * pitch) * 512UL)))]);
# 913 "txInterpTest.cu"
if ((__cuda_local_var_36942_6_non_const_im == 1) || (__cuda_local_var_36942_6_non_const_im == 10))
# 913 "txInterpTest.cu"
{
# 914 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36938_6_non_const_x) + (((unsigned long)__cuda_local_var_36939_6_non_const_y) * pitch)) + ((1UL * pitch) * 512UL)))]) = __cuda_local_var_36944_17_non_const_f3;
# 915 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36938_6_non_const_x) + (((unsigned long)__cuda_local_var_36939_6_non_const_y) * pitch)) + ((2UL * pitch) * 512UL)))]) = __cuda_local_var_36944_20_non_const_f4;
# 916 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36938_6_non_const_x) + (((unsigned long)__cuda_local_var_36939_6_non_const_y) * pitch)) + ((3UL * pitch) * 512UL)))]) = __cuda_local_var_36944_11_non_const_f1;
# 917 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36938_6_non_const_x) + (((unsigned long)__cuda_local_var_36939_6_non_const_y) * pitch)) + ((4UL * pitch) * 512UL)))]) = __cuda_local_var_36944_14_non_const_f2;
# 918 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36938_6_non_const_x) + (((unsigned long)__cuda_local_var_36939_6_non_const_y) * pitch)) + ((5UL * pitch) * 512UL)))]) = __cuda_local_var_36944_29_non_const_f7;
# 919 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36938_6_non_const_x) + (((unsigned long)__cuda_local_var_36939_6_non_const_y) * pitch)) + ((6UL * pitch) * 512UL)))]) = __cuda_local_var_36944_32_non_const_f8;
# 920 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36938_6_non_const_x) + (((unsigned long)__cuda_local_var_36939_6_non_const_y) * pitch)) + ((7UL * pitch) * 512UL)))]) = __cuda_local_var_36944_23_non_const_f5;
# 921 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36938_6_non_const_x) + (((unsigned long)__cuda_local_var_36939_6_non_const_y) * pitch)) + ((8UL * pitch) * 512UL)))]) = __cuda_local_var_36944_26_non_const_f6;
# 922 "txInterpTest.cu"
}
# 923 "txInterpTest.cu"
else
# 923 "txInterpTest.cu"
{
# 924 "txInterpTest.cu"
if (((const char *)"BGK") == ((const char *)"MRT"))
# 924 "txInterpTest.cu"
{
# 925 "txInterpTest.cu"
_Z11mrt_collideRfS_S_S_S_S_S_S_S_f((&__cuda_local_var_36944_8_non_const_f0), (&__cuda_local_var_36944_11_non_const_f1), (&__cuda_local_var_36944_14_non_const_f2), (&__cuda_local_var_36944_17_non_const_f3), (&__cuda_local_var_36944_20_non_const_f4), (&__cuda_local_var_36944_23_non_const_f5), (&__cuda_local_var_36944_26_non_const_f6), (&__cuda_local_var_36944_29_non_const_f7), (&__cuda_local_var_36944_32_non_const_f8), omega);
# 925 "txInterpTest.cu"
}
# 925 "txInterpTest.cu"
else
# 925 "txInterpTest.cu"
{
# 926 "txInterpTest.cu"
if (1)
# 926 "txInterpTest.cu"
{
# 927 "txInterpTest.cu"
{
# 927 "txInterpTest.cu"
__T2205 = ((((((((__cuda_local_var_36944_8_non_const_f0 + __cuda_local_var_36944_11_non_const_f1) + __cuda_local_var_36944_14_non_const_f2) + __cuda_local_var_36944_17_non_const_f3) + __cuda_local_var_36944_20_non_const_f4) + __cuda_local_var_36944_23_non_const_f5) + __cuda_local_var_36944_26_non_const_f6) + __cuda_local_var_36944_29_non_const_f7) + __cuda_local_var_36944_32_non_const_f8);
# 927 "txInterpTest.cu"
__T2206 = (((((__cuda_local_var_36944_11_non_const_f1 - __cuda_local_var_36944_17_non_const_f3) + __cuda_local_var_36944_23_non_const_f5) - __cuda_local_var_36944_26_non_const_f6) - __cuda_local_var_36944_29_non_const_f7) + __cuda_local_var_36944_32_non_const_f8);
# 927 "txInterpTest.cu"
__T2207 = (((((__cuda_local_var_36944_14_non_const_f2 - __cuda_local_var_36944_20_non_const_f4) + __cuda_local_var_36944_23_non_const_f5) + __cuda_local_var_36944_26_non_const_f6) - __cuda_local_var_36944_29_non_const_f7) - __cuda_local_var_36944_32_non_const_f8);
# 927 "txInterpTest.cu"
__T2208 = ((__T2206 * __T2206) + (__T2207 * __T2207));
# 927 "txInterpTest.cu"
__cuda_local_var_36944_8_non_const_f0 = (__cuda_local_var_36944_8_non_const_f0 - (omega * (__cuda_local_var_36944_8_non_const_f0 - ((0.4444444478F) * (__T2205 - ((1.5F) * __T2208))))));
# 927 "txInterpTest.cu"
__cuda_local_var_36944_11_non_const_f1 = (__cuda_local_var_36944_11_non_const_f1 - (omega * (__cuda_local_var_36944_11_non_const_f1 - ((0.1111111119F) * (((__T2205 + ((3.0F) * __T2206)) + (((4.5F) * __T2206) * __T2206)) - ((1.5F) * __T2208))))));
# 927 "txInterpTest.cu"
__cuda_local_var_36944_14_non_const_f2 = (__cuda_local_var_36944_14_non_const_f2 - (omega * (__cuda_local_var_36944_14_non_const_f2 - ((0.1111111119F) * (((__T2205 + ((3.0F) * __T2207)) + (((4.5F) * __T2207) * __T2207)) - ((1.5F) * __T2208))))));
# 927 "txInterpTest.cu"
__cuda_local_var_36944_17_non_const_f3 = (__cuda_local_var_36944_17_non_const_f3 - (omega * (__cuda_local_var_36944_17_non_const_f3 - ((0.1111111119F) * (((__T2205 - ((3.0F) * __T2206)) + (((4.5F) * __T2206) * __T2206)) - ((1.5F) * __T2208))))));
# 927 "txInterpTest.cu"
__cuda_local_var_36944_20_non_const_f4 = (__cuda_local_var_36944_20_non_const_f4 - (omega * (__cuda_local_var_36944_20_non_const_f4 - ((0.1111111119F) * (((__T2205 - ((3.0F) * __T2207)) + (((4.5F) * __T2207) * __T2207)) - ((1.5F) * __T2208))))));
# 927 "txInterpTest.cu"
__cuda_local_var_36944_23_non_const_f5 = ((float)(((double)__cuda_local_var_36944_23_non_const_f5) - (((double)omega) * (((double)__cuda_local_var_36944_23_non_const_f5) - ((0.02777777777999999864) * ((double)(((__T2205 + ((3.0F) * (__T2206 + __T2207))) + (((4.5F) * (__T2206 + __T2207)) * (__T2206 + __T2207))) - ((1.5F) * __T2208))))))));
# 927 "txInterpTest.cu"
__cuda_local_var_36944_26_non_const_f6 = ((float)(((double)__cuda_local_var_36944_26_non_const_f6) - (((double)omega) * (((double)__cuda_local_var_36944_26_non_const_f6) - ((0.02777777777999999864) * ((double)(((__T2205 + ((3.0F) * ((-__T2206) + __T2207))) + (((4.5F) * ((-__T2206) + __T2207)) * ((-__T2206) + __T2207))) - ((1.5F) * __T2208))))))));
# 927 "txInterpTest.cu"
__cuda_local_var_36944_29_non_const_f7 = ((float)(((double)__cuda_local_var_36944_29_non_const_f7) - (((double)omega) * (((double)__cuda_local_var_36944_29_non_const_f7) - ((0.02777777777999999864) * ((double)(((__T2205 + ((3.0F) * ((-__T2206) - __T2207))) + (((4.5F) * ((-__T2206) - __T2207)) * ((-__T2206) - __T2207))) - ((1.5F) * __T2208))))))));
# 927 "txInterpTest.cu"
__cuda_local_var_36944_32_non_const_f8 = ((float)(((double)__cuda_local_var_36944_32_non_const_f8) - (((double)omega) * (((double)__cuda_local_var_36944_32_non_const_f8) - ((0.02777777777999999864) * ((double)(((__T2205 + ((3.0F) * (__T2206 - __T2207))) + (((4.5F) * (__T2206 - __T2207)) * (__T2206 - __T2207))) - ((1.5F) * __T2208))))))));
# 927 "txInterpTest.cu"
}
# 927 "txInterpTest.cu"
}
# 927 "txInterpTest.cu"
}
# 929 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36938_6_non_const_x) + (((unsigned long)__cuda_local_var_36939_6_non_const_y) * pitch)) + ((0UL * pitch) * 512UL)))]) = __cuda_local_var_36944_8_non_const_f0;
# 930 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36938_6_non_const_x) + (((unsigned long)__cuda_local_var_36939_6_non_const_y) * pitch)) + ((1UL * pitch) * 512UL)))]) = __cuda_local_var_36944_11_non_const_f1;
# 931 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36938_6_non_const_x) + (((unsigned long)__cuda_local_var_36939_6_non_const_y) * pitch)) + ((2UL * pitch) * 512UL)))]) = __cuda_local_var_36944_14_non_const_f2;
# 932 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36938_6_non_const_x) + (((unsigned long)__cuda_local_var_36939_6_non_const_y) * pitch)) + ((3UL * pitch) * 512UL)))]) = __cuda_local_var_36944_17_non_const_f3;
# 933 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36938_6_non_const_x) + (((unsigned long)__cuda_local_var_36939_6_non_const_y) * pitch)) + ((4UL * pitch) * 512UL)))]) = __cuda_local_var_36944_20_non_const_f4;
# 934 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36938_6_non_const_x) + (((unsigned long)__cuda_local_var_36939_6_non_const_y) * pitch)) + ((5UL * pitch) * 512UL)))]) = __cuda_local_var_36944_23_non_const_f5;
# 935 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36938_6_non_const_x) + (((unsigned long)__cuda_local_var_36939_6_non_const_y) * pitch)) + ((6UL * pitch) * 512UL)))]) = __cuda_local_var_36944_26_non_const_f6;
# 936 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36938_6_non_const_x) + (((unsigned long)__cuda_local_var_36939_6_non_const_y) * pitch)) + ((7UL * pitch) * 512UL)))]) = __cuda_local_var_36944_29_non_const_f7;
# 937 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_36938_6_non_const_x) + (((unsigned long)__cuda_local_var_36939_6_non_const_y) * pitch)) + ((8UL * pitch) * 512UL)))]) = __cuda_local_var_36944_32_non_const_f8;
# 938 "txInterpTest.cu"
}
# 939 "txInterpTest.cu"
}
# 940 "txInterpTest.cu"
}
# 940 "txInterpTest.cu"
}}
# 943 "txInterpTest.cu"
__attribute__((global)) __attribute__((__used__)) void _Z19LR_d_hybABDC_InterpPfS_fmf(
# 943 "txInterpTest.cu"
float *fin,
# 943 "txInterpTest.cu"
float *fout,
# 944 "txInterpTest.cu"
float omega,
# 944 "txInterpTest.cu"
size_t pitch,
# 944 "txInterpTest.cu"
float SF){
# 944 "txInterpTest.cu"
{
# 945 "txInterpTest.cu"
{
# 945 "txInterpTest.cu"
 __texture_type__ __T2254;
# 946 "txInterpTest.cu"
 float __T2255;
# 947 "txInterpTest.cu"
 float __T2256;
# 948 "txInterpTest.cu"
 float4 __T2257;
# 949 "txInterpTest.cu"
 float4 __T2258;
# 950 "txInterpTest.cu"
 __texture_type__ __T2259;
# 951 "txInterpTest.cu"
 float __T2260;
# 952 "txInterpTest.cu"
 float __T2261;
# 953 "txInterpTest.cu"
 float4 __T2262;
# 954 "txInterpTest.cu"
 float4 __T2263;
# 955 "txInterpTest.cu"
 __texture_type__ __T2264;
# 956 "txInterpTest.cu"
 float __T2265;
# 957 "txInterpTest.cu"
 float __T2266;
# 958 "txInterpTest.cu"
 float4 __T2267;
# 959 "txInterpTest.cu"
 float4 __T2268;
# 960 "txInterpTest.cu"
 __texture_type__ __T2269;
# 961 "txInterpTest.cu"
 float __T2270;
# 962 "txInterpTest.cu"
 float __T2271;
# 963 "txInterpTest.cu"
 float4 __T2272;
# 964 "txInterpTest.cu"
 float4 __T2273;
# 965 "txInterpTest.cu"
 __texture_type__ __T2274;
# 966 "txInterpTest.cu"
 float __T2275;
# 967 "txInterpTest.cu"
 float __T2276;
# 968 "txInterpTest.cu"
 float4 __T2277;
# 969 "txInterpTest.cu"
 float4 __T2278;
# 970 "txInterpTest.cu"
 __texture_type__ __T2279;
# 971 "txInterpTest.cu"
 float __T2280;
# 972 "txInterpTest.cu"
 float __T2281;
# 973 "txInterpTest.cu"
 float4 __T2282;
# 974 "txInterpTest.cu"
 float4 __T2283;
# 975 "txInterpTest.cu"
 float __T2284;
# 976 "txInterpTest.cu"
 float __T2285;
# 977 "txInterpTest.cu"
 float __T2286;
# 978 "txInterpTest.cu"
 float __T2287;
# 946 "txInterpTest.cu"
 int __cuda_local_var_37021_6_non_const_x;
# 947 "txInterpTest.cu"
 int __cuda_local_var_37022_6_non_const_y;
# 948 "txInterpTest.cu"
 float __cuda_local_var_37023_8_non_const_xcoord;
# 949 "txInterpTest.cu"
 float __cuda_local_var_37024_8_non_const_ycoord;
# 950 "txInterpTest.cu"
 int __cuda_local_var_37025_6_non_const_im;
# 951 "txInterpTest.cu"
 int __cuda_local_var_37026_6_non_const_j;
# 952 "txInterpTest.cu"
 float __cuda_local_var_37027_8_non_const_f0;
# 952 "txInterpTest.cu"
 float __cuda_local_var_37027_11_non_const_f1;
# 952 "txInterpTest.cu"
 float __cuda_local_var_37027_14_non_const_f2;
# 952 "txInterpTest.cu"
 float __cuda_local_var_37027_17_non_const_f3;
# 952 "txInterpTest.cu"
 float __cuda_local_var_37027_20_non_const_f4;
# 952 "txInterpTest.cu"
 float __cuda_local_var_37027_23_non_const_f5;
# 952 "txInterpTest.cu"
 float __cuda_local_var_37027_26_non_const_f6;
# 952 "txInterpTest.cu"
 float __cuda_local_var_37027_29_non_const_f7;
# 952 "txInterpTest.cu"
 float __cuda_local_var_37027_32_non_const_f8;
# 946 "txInterpTest.cu"
__cuda_local_var_37021_6_non_const_x = ((int)((threadIdx.x) + ((blockIdx.x) * (blockDim.x))));
# 947 "txInterpTest.cu"
__cuda_local_var_37022_6_non_const_y = ((int)((threadIdx.y) + ((blockIdx.y) * (blockDim.y))));
# 948 "txInterpTest.cu"
__cuda_local_var_37023_8_non_const_xcoord = ((float)((415.625) + ((double)(((float)__cuda_local_var_37021_6_non_const_x) * (0.25F)))));
# 949 "txInterpTest.cu"
__cuda_local_var_37024_8_non_const_ycoord = ((float)((319.625) + ((double)(((float)__cuda_local_var_37022_6_non_const_y) * (0.25F)))));
# 950 "txInterpTest.cu"
__cuda_local_var_37025_6_non_const_im = (_Z8ImageFcnff(__cuda_local_var_37023_8_non_const_xcoord, __cuda_local_var_37024_8_non_const_ycoord));
# 951 "txInterpTest.cu"
__cuda_local_var_37026_6_non_const_j = ((int)(((unsigned long)__cuda_local_var_37021_6_non_const_x) + (((unsigned long)__cuda_local_var_37022_6_non_const_y) * pitch)));
# 954 "txInterpTest.cu"
if ((((__cuda_local_var_37021_6_non_const_x < 4) || (__cuda_local_var_37021_6_non_const_x > 763)) || (__cuda_local_var_37022_6_non_const_y < 4)) || (__cuda_local_var_37022_6_non_const_y > 507))
# 956 "txInterpTest.cu"
{
# 956 "txInterpTest.cu"
 __texture_type__ __T2288;
# 957 "txInterpTest.cu"
 float __T2289;
# 958 "txInterpTest.cu"
 float __T2290;
# 959 "txInterpTest.cu"
 float4 __T2291;
# 960 "txInterpTest.cu"
 float4 __T2292;
# 961 "txInterpTest.cu"
 __texture_type__ __T2293;
# 962 "txInterpTest.cu"
 float __T2294;
# 963 "txInterpTest.cu"
 float __T2295;
# 964 "txInterpTest.cu"
 float4 __T2296;
# 965 "txInterpTest.cu"
 float4 __T2297;
# 966 "txInterpTest.cu"
 __texture_type__ __T2298;
# 967 "txInterpTest.cu"
 float __T2299;
# 968 "txInterpTest.cu"
 float __T2300;
# 969 "txInterpTest.cu"
 float4 __T2301;
# 970 "txInterpTest.cu"
 float4 __T2302;
# 971 "txInterpTest.cu"
 __texture_type__ __T2303;
# 972 "txInterpTest.cu"
 float __T2304;
# 973 "txInterpTest.cu"
 float __T2305;
# 974 "txInterpTest.cu"
 float4 __T2306;
# 975 "txInterpTest.cu"
 float4 __T2307;
# 976 "txInterpTest.cu"
 __texture_type__ __T2308;
# 977 "txInterpTest.cu"
 float __T2309;
# 978 "txInterpTest.cu"
 float __T2310;
# 979 "txInterpTest.cu"
 float4 __T2311;
# 980 "txInterpTest.cu"
 float4 __T2312;
# 981 "txInterpTest.cu"
 __texture_type__ __T2313;
# 982 "txInterpTest.cu"
 float __T2314;
# 983 "txInterpTest.cu"
 float __T2315;
# 984 "txInterpTest.cu"
 float4 __T2316;
# 985 "txInterpTest.cu"
 float4 __T2317;
# 986 "txInterpTest.cu"
 __texture_type__ __T2318;
# 987 "txInterpTest.cu"
 float __T2319;
# 988 "txInterpTest.cu"
 float __T2320;
# 989 "txInterpTest.cu"
 float4 __T2321;
# 990 "txInterpTest.cu"
 float4 __T2322;
# 991 "txInterpTest.cu"
 __texture_type__ __T2323;
# 992 "txInterpTest.cu"
 float __T2324;
# 993 "txInterpTest.cu"
 float __T2325;
# 994 "txInterpTest.cu"
 float4 __T2326;
# 995 "txInterpTest.cu"
 float4 __T2327;
# 996 "txInterpTest.cu"
 __texture_type__ __T2328;
# 997 "txInterpTest.cu"
 float __T2329;
# 998 "txInterpTest.cu"
 float __T2330;
# 999 "txInterpTest.cu"
 float4 __T2331;
# 1000 "txInterpTest.cu"
 float4 __T2332;
# 968 "txInterpTest.cu"
 float __cuda_local_var_37043_8_non_const_rho;
# 968 "txInterpTest.cu"
 float __cuda_local_var_37043_12_non_const_u;
# 968 "txInterpTest.cu"
 float __cuda_local_var_37043_14_non_const_v;
# 972 "txInterpTest.cu"
 float __cuda_local_var_37047_8_non_const_usqr;
# 958 "txInterpTest.cu"
__cuda_local_var_37027_8_non_const_f0 = ((((__T2288 = texRef_f0B) , ((void)(__T2289 = (__cuda_local_var_37023_8_non_const_xcoord + (0.5F))))) , ((void)(__T2290 = (__cuda_local_var_37024_8_non_const_ycoord + (0.5F))))) , ((__T2292 = (__ftexfetch2D(__T2288, ((((((__T2291.x) = __T2289) , ((void)((__T2291.y) = __T2290))) , ((void)((__T2291.z) = (0.0F)))) , ((void)((__T2291.w) = (0.0F)))) , __T2291)))) , (__T2292.x)));
# 959 "txInterpTest.cu"
__cuda_local_var_37027_11_non_const_f1 = ((((__T2293 = texRef_f1B) , ((void)(__T2294 = (__cuda_local_var_37023_8_non_const_xcoord + (0.5F))))) , ((void)(__T2295 = (__cuda_local_var_37024_8_non_const_ycoord + (0.5F))))) , ((__T2297 = (__ftexfetch2D(__T2293, ((((((__T2296.x) = __T2294) , ((void)((__T2296.y) = __T2295))) , ((void)((__T2296.z) = (0.0F)))) , ((void)((__T2296.w) = (0.0F)))) , __T2296)))) , (__T2297.x)));
# 960 "txInterpTest.cu"
__cuda_local_var_37027_14_non_const_f2 = ((((__T2298 = texRef_f2B) , ((void)(__T2299 = (__cuda_local_var_37023_8_non_const_xcoord + (0.5F))))) , ((void)(__T2300 = (__cuda_local_var_37024_8_non_const_ycoord + (0.5F))))) , ((__T2302 = (__ftexfetch2D(__T2298, ((((((__T2301.x) = __T2299) , ((void)((__T2301.y) = __T2300))) , ((void)((__T2301.z) = (0.0F)))) , ((void)((__T2301.w) = (0.0F)))) , __T2301)))) , (__T2302.x)));
# 961 "txInterpTest.cu"
__cuda_local_var_37027_17_non_const_f3 = ((((__T2303 = texRef_f3B) , ((void)(__T2304 = (__cuda_local_var_37023_8_non_const_xcoord + (0.5F))))) , ((void)(__T2305 = (__cuda_local_var_37024_8_non_const_ycoord + (0.5F))))) , ((__T2307 = (__ftexfetch2D(__T2303, ((((((__T2306.x) = __T2304) , ((void)((__T2306.y) = __T2305))) , ((void)((__T2306.z) = (0.0F)))) , ((void)((__T2306.w) = (0.0F)))) , __T2306)))) , (__T2307.x)));
# 962 "txInterpTest.cu"
__cuda_local_var_37027_20_non_const_f4 = ((((__T2308 = texRef_f4B) , ((void)(__T2309 = (__cuda_local_var_37023_8_non_const_xcoord + (0.5F))))) , ((void)(__T2310 = (__cuda_local_var_37024_8_non_const_ycoord + (0.5F))))) , ((__T2312 = (__ftexfetch2D(__T2308, ((((((__T2311.x) = __T2309) , ((void)((__T2311.y) = __T2310))) , ((void)((__T2311.z) = (0.0F)))) , ((void)((__T2311.w) = (0.0F)))) , __T2311)))) , (__T2312.x)));
# 963 "txInterpTest.cu"
__cuda_local_var_37027_23_non_const_f5 = ((((__T2313 = texRef_f5B) , ((void)(__T2314 = (__cuda_local_var_37023_8_non_const_xcoord + (0.5F))))) , ((void)(__T2315 = (__cuda_local_var_37024_8_non_const_ycoord + (0.5F))))) , ((__T2317 = (__ftexfetch2D(__T2313, ((((((__T2316.x) = __T2314) , ((void)((__T2316.y) = __T2315))) , ((void)((__T2316.z) = (0.0F)))) , ((void)((__T2316.w) = (0.0F)))) , __T2316)))) , (__T2317.x)));
# 964 "txInterpTest.cu"
__cuda_local_var_37027_26_non_const_f6 = ((((__T2318 = texRef_f6B) , ((void)(__T2319 = (__cuda_local_var_37023_8_non_const_xcoord + (0.5F))))) , ((void)(__T2320 = (__cuda_local_var_37024_8_non_const_ycoord + (0.5F))))) , ((__T2322 = (__ftexfetch2D(__T2318, ((((((__T2321.x) = __T2319) , ((void)((__T2321.y) = __T2320))) , ((void)((__T2321.z) = (0.0F)))) , ((void)((__T2321.w) = (0.0F)))) , __T2321)))) , (__T2322.x)));
# 965 "txInterpTest.cu"
__cuda_local_var_37027_29_non_const_f7 = ((((__T2323 = texRef_f7B) , ((void)(__T2324 = (__cuda_local_var_37023_8_non_const_xcoord + (0.5F))))) , ((void)(__T2325 = (__cuda_local_var_37024_8_non_const_ycoord + (0.5F))))) , ((__T2327 = (__ftexfetch2D(__T2323, ((((((__T2326.x) = __T2324) , ((void)((__T2326.y) = __T2325))) , ((void)((__T2326.z) = (0.0F)))) , ((void)((__T2326.w) = (0.0F)))) , __T2326)))) , (__T2327.x)));
# 966 "txInterpTest.cu"
__cuda_local_var_37027_32_non_const_f8 = ((((__T2328 = texRef_f8B) , ((void)(__T2329 = (__cuda_local_var_37023_8_non_const_xcoord + (0.5F))))) , ((void)(__T2330 = (__cuda_local_var_37024_8_non_const_ycoord + (0.5F))))) , ((__T2332 = (__ftexfetch2D(__T2328, ((((((__T2331.x) = __T2329) , ((void)((__T2331.y) = __T2330))) , ((void)((__T2331.z) = (0.0F)))) , ((void)((__T2331.w) = (0.0F)))) , __T2331)))) , (__T2332.x)));
# 969 "txInterpTest.cu"
__cuda_local_var_37043_8_non_const_rho = ((((((((__cuda_local_var_37027_8_non_const_f0 + __cuda_local_var_37027_11_non_const_f1) + __cuda_local_var_37027_14_non_const_f2) + __cuda_local_var_37027_17_non_const_f3) + __cuda_local_var_37027_20_non_const_f4) + __cuda_local_var_37027_23_non_const_f5) + __cuda_local_var_37027_26_non_const_f6) + __cuda_local_var_37027_29_non_const_f7) + __cuda_local_var_37027_32_non_const_f8);
# 970 "txInterpTest.cu"
__cuda_local_var_37043_12_non_const_u = (((((__cuda_local_var_37027_11_non_const_f1 - __cuda_local_var_37027_17_non_const_f3) + __cuda_local_var_37027_23_non_const_f5) - __cuda_local_var_37027_26_non_const_f6) - __cuda_local_var_37027_29_non_const_f7) + __cuda_local_var_37027_32_non_const_f8);
# 971 "txInterpTest.cu"
__cuda_local_var_37043_14_non_const_v = (((((__cuda_local_var_37027_14_non_const_f2 - __cuda_local_var_37027_20_non_const_f4) + __cuda_local_var_37027_23_non_const_f5) + __cuda_local_var_37027_26_non_const_f6) - __cuda_local_var_37027_29_non_const_f7) - __cuda_local_var_37027_32_non_const_f8);
# 972 "txInterpTest.cu"
__cuda_local_var_37047_8_non_const_usqr = ((__cuda_local_var_37043_12_non_const_u * __cuda_local_var_37043_12_non_const_u) + (__cuda_local_var_37043_14_non_const_v * __cuda_local_var_37043_14_non_const_v));
# 974 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37021_6_non_const_x) + (((unsigned long)__cuda_local_var_37022_6_non_const_y) * pitch)) + ((0UL * pitch) * 512UL)))]) = ((SF * __cuda_local_var_37027_8_non_const_f0) + (((1.0F) - SF) * ((0.4444444478F) * (__cuda_local_var_37043_8_non_const_rho - ((1.5F) * __cuda_local_var_37047_8_non_const_usqr)))));
# 975 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37021_6_non_const_x) + (((unsigned long)__cuda_local_var_37022_6_non_const_y) * pitch)) + ((1UL * pitch) * 512UL)))]) = ((SF * __cuda_local_var_37027_11_non_const_f1) + (((1.0F) - SF) * ((0.1111111119F) * (((__cuda_local_var_37043_8_non_const_rho + ((3.0F) * __cuda_local_var_37043_12_non_const_u)) + (((4.5F) * __cuda_local_var_37043_12_non_const_u) * __cuda_local_var_37043_12_non_const_u)) - ((1.5F) * __cuda_local_var_37047_8_non_const_usqr)))));
# 976 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37021_6_non_const_x) + (((unsigned long)__cuda_local_var_37022_6_non_const_y) * pitch)) + ((2UL * pitch) * 512UL)))]) = ((SF * __cuda_local_var_37027_14_non_const_f2) + (((1.0F) - SF) * ((0.1111111119F) * (((__cuda_local_var_37043_8_non_const_rho + ((3.0F) * __cuda_local_var_37043_14_non_const_v)) + (((4.5F) * __cuda_local_var_37043_14_non_const_v) * __cuda_local_var_37043_14_non_const_v)) - ((1.5F) * __cuda_local_var_37047_8_non_const_usqr)))));
# 977 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37021_6_non_const_x) + (((unsigned long)__cuda_local_var_37022_6_non_const_y) * pitch)) + ((3UL * pitch) * 512UL)))]) = ((SF * __cuda_local_var_37027_17_non_const_f3) + (((1.0F) - SF) * ((0.1111111119F) * (((__cuda_local_var_37043_8_non_const_rho - ((3.0F) * __cuda_local_var_37043_12_non_const_u)) + (((4.5F) * __cuda_local_var_37043_12_non_const_u) * __cuda_local_var_37043_12_non_const_u)) - ((1.5F) * __cuda_local_var_37047_8_non_const_usqr)))));
# 978 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37021_6_non_const_x) + (((unsigned long)__cuda_local_var_37022_6_non_const_y) * pitch)) + ((4UL * pitch) * 512UL)))]) = ((SF * __cuda_local_var_37027_20_non_const_f4) + (((1.0F) - SF) * ((0.1111111119F) * (((__cuda_local_var_37043_8_non_const_rho - ((3.0F) * __cuda_local_var_37043_14_non_const_v)) + (((4.5F) * __cuda_local_var_37043_14_non_const_v) * __cuda_local_var_37043_14_non_const_v)) - ((1.5F) * __cuda_local_var_37047_8_non_const_usqr)))));
# 979 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37021_6_non_const_x) + (((unsigned long)__cuda_local_var_37022_6_non_const_y) * pitch)) + ((5UL * pitch) * 512UL)))]) = ((float)(((double)(SF * __cuda_local_var_37027_23_non_const_f5)) + (((double)((1.0F) - SF)) * ((0.02777777777999999864) * ((double)(((__cuda_local_var_37043_8_non_const_rho + ((3.0F) * (__cuda_local_var_37043_12_non_const_u + __cuda_local_var_37043_14_non_const_v))) + (((4.5F) * (__cuda_local_var_37043_12_non_const_u + __cuda_local_var_37043_14_non_const_v)) * (__cuda_local_var_37043_12_non_const_u + __cuda_local_var_37043_14_non_const_v))) - ((1.5F) * __cuda_local_var_37047_8_non_const_usqr)))))));
# 980 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37021_6_non_const_x) + (((unsigned long)__cuda_local_var_37022_6_non_const_y) * pitch)) + ((6UL * pitch) * 512UL)))]) = ((float)(((double)(SF * __cuda_local_var_37027_26_non_const_f6)) + (((double)((1.0F) - SF)) * ((0.02777777777999999864) * ((double)(((__cuda_local_var_37043_8_non_const_rho + ((3.0F) * ((-__cuda_local_var_37043_12_non_const_u) + __cuda_local_var_37043_14_non_const_v))) + (((4.5F) * ((-__cuda_local_var_37043_12_non_const_u) + __cuda_local_var_37043_14_non_const_v)) * ((-__cuda_local_var_37043_12_non_const_u) + __cuda_local_var_37043_14_non_const_v))) - ((1.5F) * __cuda_local_var_37047_8_non_const_usqr)))))));
# 981 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37021_6_non_const_x) + (((unsigned long)__cuda_local_var_37022_6_non_const_y) * pitch)) + ((7UL * pitch) * 512UL)))]) = ((float)(((double)(SF * __cuda_local_var_37027_29_non_const_f7)) + (((double)((1.0F) - SF)) * ((0.02777777777999999864) * ((double)(((__cuda_local_var_37043_8_non_const_rho + ((3.0F) * ((-__cuda_local_var_37043_12_non_const_u) - __cuda_local_var_37043_14_non_const_v))) + (((4.5F) * ((-__cuda_local_var_37043_12_non_const_u) - __cuda_local_var_37043_14_non_const_v)) * ((-__cuda_local_var_37043_12_non_const_u) - __cuda_local_var_37043_14_non_const_v))) - ((1.5F) * __cuda_local_var_37047_8_non_const_usqr)))))));
# 982 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37021_6_non_const_x) + (((unsigned long)__cuda_local_var_37022_6_non_const_y) * pitch)) + ((8UL * pitch) * 512UL)))]) = ((float)(((double)(SF * __cuda_local_var_37027_32_non_const_f8)) + (((double)((1.0F) - SF)) * ((0.02777777777999999864) * ((double)(((__cuda_local_var_37043_8_non_const_rho + ((3.0F) * (__cuda_local_var_37043_12_non_const_u - __cuda_local_var_37043_14_non_const_v))) + (((4.5F) * (__cuda_local_var_37043_12_non_const_u - __cuda_local_var_37043_14_non_const_v)) * (__cuda_local_var_37043_12_non_const_u - __cuda_local_var_37043_14_non_const_v))) - ((1.5F) * __cuda_local_var_37047_8_non_const_usqr)))))));
# 984 "txInterpTest.cu"
}
# 985 "txInterpTest.cu"
else
# 985 "txInterpTest.cu"
{
# 986 "txInterpTest.cu"
__cuda_local_var_37027_8_non_const_f0 = (fin[__cuda_local_var_37026_6_non_const_j]);
# 987 "txInterpTest.cu"
__cuda_local_var_37027_14_non_const_f2 = (fin[((int)((((unsigned long)__cuda_local_var_37021_6_non_const_x) + (((unsigned long)(__cuda_local_var_37022_6_non_const_y - 1)) * pitch)) + ((2UL * pitch) * 512UL)))]);
# 988 "txInterpTest.cu"
__cuda_local_var_37027_20_non_const_f4 = (fin[((int)((((unsigned long)__cuda_local_var_37021_6_non_const_x) + (((unsigned long)(__cuda_local_var_37022_6_non_const_y + 1)) * pitch)) + ((4UL * pitch) * 512UL)))]);
# 989 "txInterpTest.cu"
__cuda_local_var_37027_11_non_const_f1 = ((((__T2254 = texRef_f1D) , ((void)(__T2255 = (((float)(__cuda_local_var_37021_6_non_const_x - 1)) + (0.5F))))) , ((void)(__T2256 = (((float)__cuda_local_var_37022_6_non_const_y) + (0.5F))))) , ((__T2258 = (__ftexfetch2D(__T2254, ((((((__T2257.x) = __T2255) , ((void)((__T2257.y) = __T2256))) , ((void)((__T2257.z) = (0.0F)))) , ((void)((__T2257.w) = (0.0F)))) , __T2257)))) , (__T2258.x)));
# 990 "txInterpTest.cu"
__cuda_local_var_37027_17_non_const_f3 = ((((__T2259 = texRef_f3D) , ((void)(__T2260 = (((float)(__cuda_local_var_37021_6_non_const_x + 1)) + (0.5F))))) , ((void)(__T2261 = (((float)__cuda_local_var_37022_6_non_const_y) + (0.5F))))) , ((__T2263 = (__ftexfetch2D(__T2259, ((((((__T2262.x) = __T2260) , ((void)((__T2262.y) = __T2261))) , ((void)((__T2262.z) = (0.0F)))) , ((void)((__T2262.w) = (0.0F)))) , __T2262)))) , (__T2263.x)));
# 991 "txInterpTest.cu"
__cuda_local_var_37027_23_non_const_f5 = ((((__T2264 = texRef_f5D) , ((void)(__T2265 = (((float)(__cuda_local_var_37021_6_non_const_x - 1)) + (0.5F))))) , ((void)(__T2266 = (((float)(__cuda_local_var_37022_6_non_const_y - 1)) + (0.5F))))) , ((__T2268 = (__ftexfetch2D(__T2264, ((((((__T2267.x) = __T2265) , ((void)((__T2267.y) = __T2266))) , ((void)((__T2267.z) = (0.0F)))) , ((void)((__T2267.w) = (0.0F)))) , __T2267)))) , (__T2268.x)));
# 992 "txInterpTest.cu"
__cuda_local_var_37027_26_non_const_f6 = ((((__T2269 = texRef_f6D) , ((void)(__T2270 = (((float)(__cuda_local_var_37021_6_non_const_x + 1)) + (0.5F))))) , ((void)(__T2271 = (((float)(__cuda_local_var_37022_6_non_const_y - 1)) + (0.5F))))) , ((__T2273 = (__ftexfetch2D(__T2269, ((((((__T2272.x) = __T2270) , ((void)((__T2272.y) = __T2271))) , ((void)((__T2272.z) = (0.0F)))) , ((void)((__T2272.w) = (0.0F)))) , __T2272)))) , (__T2273.x)));
# 993 "txInterpTest.cu"
__cuda_local_var_37027_29_non_const_f7 = ((((__T2274 = texRef_f7D) , ((void)(__T2275 = (((float)(__cuda_local_var_37021_6_non_const_x + 1)) + (0.5F))))) , ((void)(__T2276 = (((float)(__cuda_local_var_37022_6_non_const_y + 1)) + (0.5F))))) , ((__T2278 = (__ftexfetch2D(__T2274, ((((((__T2277.x) = __T2275) , ((void)((__T2277.y) = __T2276))) , ((void)((__T2277.z) = (0.0F)))) , ((void)((__T2277.w) = (0.0F)))) , __T2277)))) , (__T2278.x)));
# 994 "txInterpTest.cu"
__cuda_local_var_37027_32_non_const_f8 = ((((__T2279 = texRef_f8D) , ((void)(__T2280 = (((float)(__cuda_local_var_37021_6_non_const_x - 1)) + (0.5F))))) , ((void)(__T2281 = (((float)(__cuda_local_var_37022_6_non_const_y + 1)) + (0.5F))))) , ((__T2283 = (__ftexfetch2D(__T2279, ((((((__T2282.x) = __T2280) , ((void)((__T2282.y) = __T2281))) , ((void)((__T2282.z) = (0.0F)))) , ((void)((__T2282.w) = (0.0F)))) , __T2282)))) , (__T2283.x)));
# 996 "txInterpTest.cu"
if ((__cuda_local_var_37025_6_non_const_im == 1) || (__cuda_local_var_37025_6_non_const_im == 10))
# 996 "txInterpTest.cu"
{
# 997 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37021_6_non_const_x) + (((unsigned long)__cuda_local_var_37022_6_non_const_y) * pitch)) + ((1UL * pitch) * 512UL)))]) = __cuda_local_var_37027_17_non_const_f3;
# 998 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37021_6_non_const_x) + (((unsigned long)__cuda_local_var_37022_6_non_const_y) * pitch)) + ((2UL * pitch) * 512UL)))]) = __cuda_local_var_37027_20_non_const_f4;
# 999 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37021_6_non_const_x) + (((unsigned long)__cuda_local_var_37022_6_non_const_y) * pitch)) + ((3UL * pitch) * 512UL)))]) = __cuda_local_var_37027_11_non_const_f1;
# 1000 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37021_6_non_const_x) + (((unsigned long)__cuda_local_var_37022_6_non_const_y) * pitch)) + ((4UL * pitch) * 512UL)))]) = __cuda_local_var_37027_14_non_const_f2;
# 1001 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37021_6_non_const_x) + (((unsigned long)__cuda_local_var_37022_6_non_const_y) * pitch)) + ((5UL * pitch) * 512UL)))]) = __cuda_local_var_37027_29_non_const_f7;
# 1002 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37021_6_non_const_x) + (((unsigned long)__cuda_local_var_37022_6_non_const_y) * pitch)) + ((6UL * pitch) * 512UL)))]) = __cuda_local_var_37027_32_non_const_f8;
# 1003 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37021_6_non_const_x) + (((unsigned long)__cuda_local_var_37022_6_non_const_y) * pitch)) + ((7UL * pitch) * 512UL)))]) = __cuda_local_var_37027_23_non_const_f5;
# 1004 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37021_6_non_const_x) + (((unsigned long)__cuda_local_var_37022_6_non_const_y) * pitch)) + ((8UL * pitch) * 512UL)))]) = __cuda_local_var_37027_26_non_const_f6;
# 1005 "txInterpTest.cu"
}
# 1006 "txInterpTest.cu"
else
# 1006 "txInterpTest.cu"
{
# 1007 "txInterpTest.cu"
if (((const char *)"BGK") == ((const char *)"MRT"))
# 1007 "txInterpTest.cu"
{
# 1008 "txInterpTest.cu"
_Z11mrt_collideRfS_S_S_S_S_S_S_S_f((&__cuda_local_var_37027_8_non_const_f0), (&__cuda_local_var_37027_11_non_const_f1), (&__cuda_local_var_37027_14_non_const_f2), (&__cuda_local_var_37027_17_non_const_f3), (&__cuda_local_var_37027_20_non_const_f4), (&__cuda_local_var_37027_23_non_const_f5), (&__cuda_local_var_37027_26_non_const_f6), (&__cuda_local_var_37027_29_non_const_f7), (&__cuda_local_var_37027_32_non_const_f8), omega);
# 1008 "txInterpTest.cu"
}
# 1008 "txInterpTest.cu"
else
# 1008 "txInterpTest.cu"
{
# 1009 "txInterpTest.cu"
if (1)
# 1009 "txInterpTest.cu"
{
# 1010 "txInterpTest.cu"
{
# 1010 "txInterpTest.cu"
__T2284 = ((((((((__cuda_local_var_37027_8_non_const_f0 + __cuda_local_var_37027_11_non_const_f1) + __cuda_local_var_37027_14_non_const_f2) + __cuda_local_var_37027_17_non_const_f3) + __cuda_local_var_37027_20_non_const_f4) + __cuda_local_var_37027_23_non_const_f5) + __cuda_local_var_37027_26_non_const_f6) + __cuda_local_var_37027_29_non_const_f7) + __cuda_local_var_37027_32_non_const_f8);
# 1010 "txInterpTest.cu"
__T2285 = (((((__cuda_local_var_37027_11_non_const_f1 - __cuda_local_var_37027_17_non_const_f3) + __cuda_local_var_37027_23_non_const_f5) - __cuda_local_var_37027_26_non_const_f6) - __cuda_local_var_37027_29_non_const_f7) + __cuda_local_var_37027_32_non_const_f8);
# 1010 "txInterpTest.cu"
__T2286 = (((((__cuda_local_var_37027_14_non_const_f2 - __cuda_local_var_37027_20_non_const_f4) + __cuda_local_var_37027_23_non_const_f5) + __cuda_local_var_37027_26_non_const_f6) - __cuda_local_var_37027_29_non_const_f7) - __cuda_local_var_37027_32_non_const_f8);
# 1010 "txInterpTest.cu"
__T2287 = ((__T2285 * __T2285) + (__T2286 * __T2286));
# 1010 "txInterpTest.cu"
__cuda_local_var_37027_8_non_const_f0 = (__cuda_local_var_37027_8_non_const_f0 - (omega * (__cuda_local_var_37027_8_non_const_f0 - ((0.4444444478F) * (__T2284 - ((1.5F) * __T2287))))));
# 1010 "txInterpTest.cu"
__cuda_local_var_37027_11_non_const_f1 = (__cuda_local_var_37027_11_non_const_f1 - (omega * (__cuda_local_var_37027_11_non_const_f1 - ((0.1111111119F) * (((__T2284 + ((3.0F) * __T2285)) + (((4.5F) * __T2285) * __T2285)) - ((1.5F) * __T2287))))));
# 1010 "txInterpTest.cu"
__cuda_local_var_37027_14_non_const_f2 = (__cuda_local_var_37027_14_non_const_f2 - (omega * (__cuda_local_var_37027_14_non_const_f2 - ((0.1111111119F) * (((__T2284 + ((3.0F) * __T2286)) + (((4.5F) * __T2286) * __T2286)) - ((1.5F) * __T2287))))));
# 1010 "txInterpTest.cu"
__cuda_local_var_37027_17_non_const_f3 = (__cuda_local_var_37027_17_non_const_f3 - (omega * (__cuda_local_var_37027_17_non_const_f3 - ((0.1111111119F) * (((__T2284 - ((3.0F) * __T2285)) + (((4.5F) * __T2285) * __T2285)) - ((1.5F) * __T2287))))));
# 1010 "txInterpTest.cu"
__cuda_local_var_37027_20_non_const_f4 = (__cuda_local_var_37027_20_non_const_f4 - (omega * (__cuda_local_var_37027_20_non_const_f4 - ((0.1111111119F) * (((__T2284 - ((3.0F) * __T2286)) + (((4.5F) * __T2286) * __T2286)) - ((1.5F) * __T2287))))));
# 1010 "txInterpTest.cu"
__cuda_local_var_37027_23_non_const_f5 = ((float)(((double)__cuda_local_var_37027_23_non_const_f5) - (((double)omega) * (((double)__cuda_local_var_37027_23_non_const_f5) - ((0.02777777777999999864) * ((double)(((__T2284 + ((3.0F) * (__T2285 + __T2286))) + (((4.5F) * (__T2285 + __T2286)) * (__T2285 + __T2286))) - ((1.5F) * __T2287))))))));
# 1010 "txInterpTest.cu"
__cuda_local_var_37027_26_non_const_f6 = ((float)(((double)__cuda_local_var_37027_26_non_const_f6) - (((double)omega) * (((double)__cuda_local_var_37027_26_non_const_f6) - ((0.02777777777999999864) * ((double)(((__T2284 + ((3.0F) * ((-__T2285) + __T2286))) + (((4.5F) * ((-__T2285) + __T2286)) * ((-__T2285) + __T2286))) - ((1.5F) * __T2287))))))));
# 1010 "txInterpTest.cu"
__cuda_local_var_37027_29_non_const_f7 = ((float)(((double)__cuda_local_var_37027_29_non_const_f7) - (((double)omega) * (((double)__cuda_local_var_37027_29_non_const_f7) - ((0.02777777777999999864) * ((double)(((__T2284 + ((3.0F) * ((-__T2285) - __T2286))) + (((4.5F) * ((-__T2285) - __T2286)) * ((-__T2285) - __T2286))) - ((1.5F) * __T2287))))))));
# 1010 "txInterpTest.cu"
__cuda_local_var_37027_32_non_const_f8 = ((float)(((double)__cuda_local_var_37027_32_non_const_f8) - (((double)omega) * (((double)__cuda_local_var_37027_32_non_const_f8) - ((0.02777777777999999864) * ((double)(((__T2284 + ((3.0F) * (__T2285 - __T2286))) + (((4.5F) * (__T2285 - __T2286)) * (__T2285 - __T2286))) - ((1.5F) * __T2287))))))));
# 1010 "txInterpTest.cu"
}
# 1010 "txInterpTest.cu"
}
# 1010 "txInterpTest.cu"
}
# 1012 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37021_6_non_const_x) + (((unsigned long)__cuda_local_var_37022_6_non_const_y) * pitch)) + ((0UL * pitch) * 512UL)))]) = __cuda_local_var_37027_8_non_const_f0;
# 1013 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37021_6_non_const_x) + (((unsigned long)__cuda_local_var_37022_6_non_const_y) * pitch)) + ((1UL * pitch) * 512UL)))]) = __cuda_local_var_37027_11_non_const_f1;
# 1014 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37021_6_non_const_x) + (((unsigned long)__cuda_local_var_37022_6_non_const_y) * pitch)) + ((2UL * pitch) * 512UL)))]) = __cuda_local_var_37027_14_non_const_f2;
# 1015 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37021_6_non_const_x) + (((unsigned long)__cuda_local_var_37022_6_non_const_y) * pitch)) + ((3UL * pitch) * 512UL)))]) = __cuda_local_var_37027_17_non_const_f3;
# 1016 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37021_6_non_const_x) + (((unsigned long)__cuda_local_var_37022_6_non_const_y) * pitch)) + ((4UL * pitch) * 512UL)))]) = __cuda_local_var_37027_20_non_const_f4;
# 1017 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37021_6_non_const_x) + (((unsigned long)__cuda_local_var_37022_6_non_const_y) * pitch)) + ((5UL * pitch) * 512UL)))]) = __cuda_local_var_37027_23_non_const_f5;
# 1018 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37021_6_non_const_x) + (((unsigned long)__cuda_local_var_37022_6_non_const_y) * pitch)) + ((6UL * pitch) * 512UL)))]) = __cuda_local_var_37027_26_non_const_f6;
# 1019 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37021_6_non_const_x) + (((unsigned long)__cuda_local_var_37022_6_non_const_y) * pitch)) + ((7UL * pitch) * 512UL)))]) = __cuda_local_var_37027_29_non_const_f7;
# 1020 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37021_6_non_const_x) + (((unsigned long)__cuda_local_var_37022_6_non_const_y) * pitch)) + ((8UL * pitch) * 512UL)))]) = __cuda_local_var_37027_32_non_const_f8;
# 1021 "txInterpTest.cu"
}
# 1022 "txInterpTest.cu"
}
# 1023 "txInterpTest.cu"
}
# 1023 "txInterpTest.cu"
}}
# 1025 "txInterpTest.cu"
__attribute__((global)) __attribute__((__used__)) void _Z12LR_d_hybBACDPfS_fm(
# 1025 "txInterpTest.cu"
float *fin,
# 1025 "txInterpTest.cu"
float *fout,
# 1026 "txInterpTest.cu"
float omega,
# 1026 "txInterpTest.cu"
size_t pitch){
# 1026 "txInterpTest.cu"
{
# 1027 "txInterpTest.cu"
{
# 1027 "txInterpTest.cu"
 float __T2333;
# 1028 "txInterpTest.cu"
 float __T2334;
# 1029 "txInterpTest.cu"
 float __T2335;
# 1030 "txInterpTest.cu"
 float __T2336;
# 1028 "txInterpTest.cu"
 int __cuda_local_var_37103_6_non_const_x;
# 1029 "txInterpTest.cu"
 int __cuda_local_var_37104_6_non_const_y;
# 1030 "txInterpTest.cu"
 float __cuda_local_var_37105_8_non_const_xcoord;
# 1031 "txInterpTest.cu"
 float __cuda_local_var_37106_8_non_const_ycoord;
# 1032 "txInterpTest.cu"
 int __cuda_local_var_37107_6_non_const_j;
# 1033 "txInterpTest.cu"
 int __cuda_local_var_37108_6_non_const_im;
# 1034 "txInterpTest.cu"
 float __cuda_local_var_37109_8_non_const_f0;
# 1034 "txInterpTest.cu"
 float __cuda_local_var_37109_11_non_const_f1;
# 1034 "txInterpTest.cu"
 float __cuda_local_var_37109_14_non_const_f2;
# 1034 "txInterpTest.cu"
 float __cuda_local_var_37109_17_non_const_f3;
# 1034 "txInterpTest.cu"
 float __cuda_local_var_37109_20_non_const_f4;
# 1034 "txInterpTest.cu"
 float __cuda_local_var_37109_23_non_const_f5;
# 1034 "txInterpTest.cu"
 float __cuda_local_var_37109_26_non_const_f6;
# 1034 "txInterpTest.cu"
 float __cuda_local_var_37109_29_non_const_f7;
# 1034 "txInterpTest.cu"
 float __cuda_local_var_37109_32_non_const_f8;
# 1028 "txInterpTest.cu"
__cuda_local_var_37103_6_non_const_x = ((int)((threadIdx.x) + ((blockIdx.x) * (blockDim.x))));
# 1029 "txInterpTest.cu"
__cuda_local_var_37104_6_non_const_y = ((int)((threadIdx.y) + ((blockIdx.y) * (blockDim.y))));
# 1030 "txInterpTest.cu"
__cuda_local_var_37105_8_non_const_xcoord = ((float)((415.625) + ((double)(((float)__cuda_local_var_37103_6_non_const_x) * (0.25F)))));
# 1031 "txInterpTest.cu"
__cuda_local_var_37106_8_non_const_ycoord = ((float)((319.625) + ((double)(((float)__cuda_local_var_37104_6_non_const_y) * (0.25F)))));
# 1032 "txInterpTest.cu"
__cuda_local_var_37107_6_non_const_j = ((int)(((unsigned long)__cuda_local_var_37103_6_non_const_x) + (((unsigned long)__cuda_local_var_37104_6_non_const_y) * pitch)));
# 1033 "txInterpTest.cu"
__cuda_local_var_37108_6_non_const_im = (_Z8ImageFcnff(__cuda_local_var_37105_8_non_const_xcoord, __cuda_local_var_37106_8_non_const_ycoord));
# 1035 "txInterpTest.cu"
if ((((__cuda_local_var_37103_6_non_const_x < 1) || (__cuda_local_var_37103_6_non_const_x > 766)) || (__cuda_local_var_37104_6_non_const_y < 1)) || (__cuda_local_var_37104_6_non_const_y > 510))
# 1036 "txInterpTest.cu"
{
# 1038 "txInterpTest.cu"
}
# 1039 "txInterpTest.cu"
else
# 1039 "txInterpTest.cu"
{
# 1039 "txInterpTest.cu"
 __texture_type__ __T2337;
# 1040 "txInterpTest.cu"
 float __T2338;
# 1041 "txInterpTest.cu"
 float __T2339;
# 1042 "txInterpTest.cu"
 float4 __T2340;
# 1043 "txInterpTest.cu"
 float4 __T2341;
# 1044 "txInterpTest.cu"
 __texture_type__ __T2342;
# 1045 "txInterpTest.cu"
 float __T2343;
# 1046 "txInterpTest.cu"
 float __T2344;
# 1047 "txInterpTest.cu"
 float4 __T2345;
# 1048 "txInterpTest.cu"
 float4 __T2346;
# 1049 "txInterpTest.cu"
 __texture_type__ __T2347;
# 1050 "txInterpTest.cu"
 float __T2348;
# 1051 "txInterpTest.cu"
 float __T2349;
# 1052 "txInterpTest.cu"
 float4 __T2350;
# 1053 "txInterpTest.cu"
 float4 __T2351;
# 1054 "txInterpTest.cu"
 __texture_type__ __T2352;
# 1055 "txInterpTest.cu"
 float __T2353;
# 1056 "txInterpTest.cu"
 float __T2354;
# 1057 "txInterpTest.cu"
 float4 __T2355;
# 1058 "txInterpTest.cu"
 float4 __T2356;
# 1059 "txInterpTest.cu"
 __texture_type__ __T2357;
# 1060 "txInterpTest.cu"
 float __T2358;
# 1061 "txInterpTest.cu"
 float __T2359;
# 1062 "txInterpTest.cu"
 float4 __T2360;
# 1063 "txInterpTest.cu"
 float4 __T2361;
# 1064 "txInterpTest.cu"
 __texture_type__ __T2362;
# 1065 "txInterpTest.cu"
 float __T2363;
# 1066 "txInterpTest.cu"
 float __T2364;
# 1067 "txInterpTest.cu"
 float4 __T2365;
# 1068 "txInterpTest.cu"
 float4 __T2366;
# 1040 "txInterpTest.cu"
__cuda_local_var_37109_8_non_const_f0 = (fin[__cuda_local_var_37107_6_non_const_j]);
# 1041 "txInterpTest.cu"
__cuda_local_var_37109_14_non_const_f2 = (fin[((int)((((unsigned long)__cuda_local_var_37103_6_non_const_x) + (((unsigned long)(__cuda_local_var_37104_6_non_const_y - 1)) * pitch)) + ((2UL * pitch) * 512UL)))]);
# 1042 "txInterpTest.cu"
__cuda_local_var_37109_20_non_const_f4 = (fin[((int)((((unsigned long)__cuda_local_var_37103_6_non_const_x) + (((unsigned long)(__cuda_local_var_37104_6_non_const_y + 1)) * pitch)) + ((4UL * pitch) * 512UL)))]);
# 1043 "txInterpTest.cu"
__cuda_local_var_37109_11_non_const_f1 = ((((__T2337 = texRef_f1C) , ((void)(__T2338 = (((float)(__cuda_local_var_37103_6_non_const_x - 1)) + (0.5F))))) , ((void)(__T2339 = (((float)__cuda_local_var_37104_6_non_const_y) + (0.5F))))) , ((__T2341 = (__ftexfetch2D(__T2337, ((((((__T2340.x) = __T2338) , ((void)((__T2340.y) = __T2339))) , ((void)((__T2340.z) = (0.0F)))) , ((void)((__T2340.w) = (0.0F)))) , __T2340)))) , (__T2341.x)));
# 1044 "txInterpTest.cu"
__cuda_local_var_37109_17_non_const_f3 = ((((__T2342 = texRef_f3C) , ((void)(__T2343 = (((float)(__cuda_local_var_37103_6_non_const_x + 1)) + (0.5F))))) , ((void)(__T2344 = (((float)__cuda_local_var_37104_6_non_const_y) + (0.5F))))) , ((__T2346 = (__ftexfetch2D(__T2342, ((((((__T2345.x) = __T2343) , ((void)((__T2345.y) = __T2344))) , ((void)((__T2345.z) = (0.0F)))) , ((void)((__T2345.w) = (0.0F)))) , __T2345)))) , (__T2346.x)));
# 1045 "txInterpTest.cu"
__cuda_local_var_37109_23_non_const_f5 = ((((__T2347 = texRef_f5C) , ((void)(__T2348 = (((float)(__cuda_local_var_37103_6_non_const_x - 1)) + (0.5F))))) , ((void)(__T2349 = (((float)(__cuda_local_var_37104_6_non_const_y - 1)) + (0.5F))))) , ((__T2351 = (__ftexfetch2D(__T2347, ((((((__T2350.x) = __T2348) , ((void)((__T2350.y) = __T2349))) , ((void)((__T2350.z) = (0.0F)))) , ((void)((__T2350.w) = (0.0F)))) , __T2350)))) , (__T2351.x)));
# 1046 "txInterpTest.cu"
__cuda_local_var_37109_26_non_const_f6 = ((((__T2352 = texRef_f6C) , ((void)(__T2353 = (((float)(__cuda_local_var_37103_6_non_const_x + 1)) + (0.5F))))) , ((void)(__T2354 = (((float)(__cuda_local_var_37104_6_non_const_y - 1)) + (0.5F))))) , ((__T2356 = (__ftexfetch2D(__T2352, ((((((__T2355.x) = __T2353) , ((void)((__T2355.y) = __T2354))) , ((void)((__T2355.z) = (0.0F)))) , ((void)((__T2355.w) = (0.0F)))) , __T2355)))) , (__T2356.x)));
# 1047 "txInterpTest.cu"
__cuda_local_var_37109_29_non_const_f7 = ((((__T2357 = texRef_f7C) , ((void)(__T2358 = (((float)(__cuda_local_var_37103_6_non_const_x + 1)) + (0.5F))))) , ((void)(__T2359 = (((float)(__cuda_local_var_37104_6_non_const_y + 1)) + (0.5F))))) , ((__T2361 = (__ftexfetch2D(__T2357, ((((((__T2360.x) = __T2358) , ((void)((__T2360.y) = __T2359))) , ((void)((__T2360.z) = (0.0F)))) , ((void)((__T2360.w) = (0.0F)))) , __T2360)))) , (__T2361.x)));
# 1048 "txInterpTest.cu"
__cuda_local_var_37109_32_non_const_f8 = ((((__T2362 = texRef_f8C) , ((void)(__T2363 = (((float)(__cuda_local_var_37103_6_non_const_x - 1)) + (0.5F))))) , ((void)(__T2364 = (((float)(__cuda_local_var_37104_6_non_const_y + 1)) + (0.5F))))) , ((__T2366 = (__ftexfetch2D(__T2362, ((((((__T2365.x) = __T2363) , ((void)((__T2365.y) = __T2364))) , ((void)((__T2365.z) = (0.0F)))) , ((void)((__T2365.w) = (0.0F)))) , __T2365)))) , (__T2366.x)));
# 1049 "txInterpTest.cu"
if ((__cuda_local_var_37108_6_non_const_im == 1) || (__cuda_local_var_37108_6_non_const_im == 10))
# 1049 "txInterpTest.cu"
{
# 1050 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37103_6_non_const_x) + (((unsigned long)__cuda_local_var_37104_6_non_const_y) * pitch)) + ((1UL * pitch) * 512UL)))]) = __cuda_local_var_37109_17_non_const_f3;
# 1051 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37103_6_non_const_x) + (((unsigned long)__cuda_local_var_37104_6_non_const_y) * pitch)) + ((2UL * pitch) * 512UL)))]) = __cuda_local_var_37109_20_non_const_f4;
# 1052 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37103_6_non_const_x) + (((unsigned long)__cuda_local_var_37104_6_non_const_y) * pitch)) + ((3UL * pitch) * 512UL)))]) = __cuda_local_var_37109_11_non_const_f1;
# 1053 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37103_6_non_const_x) + (((unsigned long)__cuda_local_var_37104_6_non_const_y) * pitch)) + ((4UL * pitch) * 512UL)))]) = __cuda_local_var_37109_14_non_const_f2;
# 1054 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37103_6_non_const_x) + (((unsigned long)__cuda_local_var_37104_6_non_const_y) * pitch)) + ((5UL * pitch) * 512UL)))]) = __cuda_local_var_37109_29_non_const_f7;
# 1055 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37103_6_non_const_x) + (((unsigned long)__cuda_local_var_37104_6_non_const_y) * pitch)) + ((6UL * pitch) * 512UL)))]) = __cuda_local_var_37109_32_non_const_f8;
# 1056 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37103_6_non_const_x) + (((unsigned long)__cuda_local_var_37104_6_non_const_y) * pitch)) + ((7UL * pitch) * 512UL)))]) = __cuda_local_var_37109_23_non_const_f5;
# 1057 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37103_6_non_const_x) + (((unsigned long)__cuda_local_var_37104_6_non_const_y) * pitch)) + ((8UL * pitch) * 512UL)))]) = __cuda_local_var_37109_26_non_const_f6;
# 1058 "txInterpTest.cu"
}
# 1059 "txInterpTest.cu"
else
# 1059 "txInterpTest.cu"
{
# 1060 "txInterpTest.cu"
if (((const char *)"BGK") == ((const char *)"MRT"))
# 1060 "txInterpTest.cu"
{
# 1061 "txInterpTest.cu"
_Z11mrt_collideRfS_S_S_S_S_S_S_S_f((&__cuda_local_var_37109_8_non_const_f0), (&__cuda_local_var_37109_11_non_const_f1), (&__cuda_local_var_37109_14_non_const_f2), (&__cuda_local_var_37109_17_non_const_f3), (&__cuda_local_var_37109_20_non_const_f4), (&__cuda_local_var_37109_23_non_const_f5), (&__cuda_local_var_37109_26_non_const_f6), (&__cuda_local_var_37109_29_non_const_f7), (&__cuda_local_var_37109_32_non_const_f8), omega);
# 1061 "txInterpTest.cu"
}
# 1061 "txInterpTest.cu"
else
# 1061 "txInterpTest.cu"
{
# 1062 "txInterpTest.cu"
if (1)
# 1062 "txInterpTest.cu"
{
# 1063 "txInterpTest.cu"
{
# 1063 "txInterpTest.cu"
__T2333 = ((((((((__cuda_local_var_37109_8_non_const_f0 + __cuda_local_var_37109_11_non_const_f1) + __cuda_local_var_37109_14_non_const_f2) + __cuda_local_var_37109_17_non_const_f3) + __cuda_local_var_37109_20_non_const_f4) + __cuda_local_var_37109_23_non_const_f5) + __cuda_local_var_37109_26_non_const_f6) + __cuda_local_var_37109_29_non_const_f7) + __cuda_local_var_37109_32_non_const_f8);
# 1063 "txInterpTest.cu"
__T2334 = (((((__cuda_local_var_37109_11_non_const_f1 - __cuda_local_var_37109_17_non_const_f3) + __cuda_local_var_37109_23_non_const_f5) - __cuda_local_var_37109_26_non_const_f6) - __cuda_local_var_37109_29_non_const_f7) + __cuda_local_var_37109_32_non_const_f8);
# 1063 "txInterpTest.cu"
__T2335 = (((((__cuda_local_var_37109_14_non_const_f2 - __cuda_local_var_37109_20_non_const_f4) + __cuda_local_var_37109_23_non_const_f5) + __cuda_local_var_37109_26_non_const_f6) - __cuda_local_var_37109_29_non_const_f7) - __cuda_local_var_37109_32_non_const_f8);
# 1063 "txInterpTest.cu"
__T2336 = ((__T2334 * __T2334) + (__T2335 * __T2335));
# 1063 "txInterpTest.cu"
__cuda_local_var_37109_8_non_const_f0 = (__cuda_local_var_37109_8_non_const_f0 - (omega * (__cuda_local_var_37109_8_non_const_f0 - ((0.4444444478F) * (__T2333 - ((1.5F) * __T2336))))));
# 1063 "txInterpTest.cu"
__cuda_local_var_37109_11_non_const_f1 = (__cuda_local_var_37109_11_non_const_f1 - (omega * (__cuda_local_var_37109_11_non_const_f1 - ((0.1111111119F) * (((__T2333 + ((3.0F) * __T2334)) + (((4.5F) * __T2334) * __T2334)) - ((1.5F) * __T2336))))));
# 1063 "txInterpTest.cu"
__cuda_local_var_37109_14_non_const_f2 = (__cuda_local_var_37109_14_non_const_f2 - (omega * (__cuda_local_var_37109_14_non_const_f2 - ((0.1111111119F) * (((__T2333 + ((3.0F) * __T2335)) + (((4.5F) * __T2335) * __T2335)) - ((1.5F) * __T2336))))));
# 1063 "txInterpTest.cu"
__cuda_local_var_37109_17_non_const_f3 = (__cuda_local_var_37109_17_non_const_f3 - (omega * (__cuda_local_var_37109_17_non_const_f3 - ((0.1111111119F) * (((__T2333 - ((3.0F) * __T2334)) + (((4.5F) * __T2334) * __T2334)) - ((1.5F) * __T2336))))));
# 1063 "txInterpTest.cu"
__cuda_local_var_37109_20_non_const_f4 = (__cuda_local_var_37109_20_non_const_f4 - (omega * (__cuda_local_var_37109_20_non_const_f4 - ((0.1111111119F) * (((__T2333 - ((3.0F) * __T2335)) + (((4.5F) * __T2335) * __T2335)) - ((1.5F) * __T2336))))));
# 1063 "txInterpTest.cu"
__cuda_local_var_37109_23_non_const_f5 = ((float)(((double)__cuda_local_var_37109_23_non_const_f5) - (((double)omega) * (((double)__cuda_local_var_37109_23_non_const_f5) - ((0.02777777777999999864) * ((double)(((__T2333 + ((3.0F) * (__T2334 + __T2335))) + (((4.5F) * (__T2334 + __T2335)) * (__T2334 + __T2335))) - ((1.5F) * __T2336))))))));
# 1063 "txInterpTest.cu"
__cuda_local_var_37109_26_non_const_f6 = ((float)(((double)__cuda_local_var_37109_26_non_const_f6) - (((double)omega) * (((double)__cuda_local_var_37109_26_non_const_f6) - ((0.02777777777999999864) * ((double)(((__T2333 + ((3.0F) * ((-__T2334) + __T2335))) + (((4.5F) * ((-__T2334) + __T2335)) * ((-__T2334) + __T2335))) - ((1.5F) * __T2336))))))));
# 1063 "txInterpTest.cu"
__cuda_local_var_37109_29_non_const_f7 = ((float)(((double)__cuda_local_var_37109_29_non_const_f7) - (((double)omega) * (((double)__cuda_local_var_37109_29_non_const_f7) - ((0.02777777777999999864) * ((double)(((__T2333 + ((3.0F) * ((-__T2334) - __T2335))) + (((4.5F) * ((-__T2334) - __T2335)) * ((-__T2334) - __T2335))) - ((1.5F) * __T2336))))))));
# 1063 "txInterpTest.cu"
__cuda_local_var_37109_32_non_const_f8 = ((float)(((double)__cuda_local_var_37109_32_non_const_f8) - (((double)omega) * (((double)__cuda_local_var_37109_32_non_const_f8) - ((0.02777777777999999864) * ((double)(((__T2333 + ((3.0F) * (__T2334 - __T2335))) + (((4.5F) * (__T2334 - __T2335)) * (__T2334 - __T2335))) - ((1.5F) * __T2336))))))));
# 1063 "txInterpTest.cu"
}
# 1063 "txInterpTest.cu"
}
# 1063 "txInterpTest.cu"
}
# 1064 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37103_6_non_const_x) + (((unsigned long)__cuda_local_var_37104_6_non_const_y) * pitch)) + ((0UL * pitch) * 512UL)))]) = __cuda_local_var_37109_8_non_const_f0;
# 1065 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37103_6_non_const_x) + (((unsigned long)__cuda_local_var_37104_6_non_const_y) * pitch)) + ((1UL * pitch) * 512UL)))]) = __cuda_local_var_37109_11_non_const_f1;
# 1066 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37103_6_non_const_x) + (((unsigned long)__cuda_local_var_37104_6_non_const_y) * pitch)) + ((2UL * pitch) * 512UL)))]) = __cuda_local_var_37109_14_non_const_f2;
# 1067 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37103_6_non_const_x) + (((unsigned long)__cuda_local_var_37104_6_non_const_y) * pitch)) + ((3UL * pitch) * 512UL)))]) = __cuda_local_var_37109_17_non_const_f3;
# 1068 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37103_6_non_const_x) + (((unsigned long)__cuda_local_var_37104_6_non_const_y) * pitch)) + ((4UL * pitch) * 512UL)))]) = __cuda_local_var_37109_20_non_const_f4;
# 1069 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37103_6_non_const_x) + (((unsigned long)__cuda_local_var_37104_6_non_const_y) * pitch)) + ((5UL * pitch) * 512UL)))]) = __cuda_local_var_37109_23_non_const_f5;
# 1070 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37103_6_non_const_x) + (((unsigned long)__cuda_local_var_37104_6_non_const_y) * pitch)) + ((6UL * pitch) * 512UL)))]) = __cuda_local_var_37109_26_non_const_f6;
# 1071 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37103_6_non_const_x) + (((unsigned long)__cuda_local_var_37104_6_non_const_y) * pitch)) + ((7UL * pitch) * 512UL)))]) = __cuda_local_var_37109_29_non_const_f7;
# 1072 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37103_6_non_const_x) + (((unsigned long)__cuda_local_var_37104_6_non_const_y) * pitch)) + ((8UL * pitch) * 512UL)))]) = __cuda_local_var_37109_32_non_const_f8;
# 1073 "txInterpTest.cu"
}
# 1074 "txInterpTest.cu"
}
# 1075 "txInterpTest.cu"
}
# 1075 "txInterpTest.cu"
}}
# 1077 "txInterpTest.cu"
__attribute__((global)) __attribute__((__used__)) void _Z13LR_d_hybBACD2PfS_fmi(
# 1077 "txInterpTest.cu"
float *fin,
# 1077 "txInterpTest.cu"
float *fout,
# 1078 "txInterpTest.cu"
float omega,
# 1078 "txInterpTest.cu"
size_t pitch,
# 1078 "txInterpTest.cu"
int n){
# 1078 "txInterpTest.cu"
{
# 1080 "txInterpTest.cu"
{
# 1080 "txInterpTest.cu"
 float __T2367;
# 1081 "txInterpTest.cu"
 float __T2368;
# 1082 "txInterpTest.cu"
 float __T2369;
# 1083 "txInterpTest.cu"
 float __T2370;
# 1081 "txInterpTest.cu"
 int __cuda_local_var_37156_6_non_const_x;
# 1082 "txInterpTest.cu"
 int __cuda_local_var_37157_6_non_const_y;
# 1083 "txInterpTest.cu"
 float __cuda_local_var_37158_8_non_const_xcoord;
# 1084 "txInterpTest.cu"
 float __cuda_local_var_37159_8_non_const_ycoord;
# 1085 "txInterpTest.cu"
 int __cuda_local_var_37160_6_non_const_j;
# 1086 "txInterpTest.cu"
 int __cuda_local_var_37161_6_non_const_im;
# 1087 "txInterpTest.cu"
 float __cuda_local_var_37162_8_non_const_f0;
# 1087 "txInterpTest.cu"
 float __cuda_local_var_37162_11_non_const_f1;
# 1087 "txInterpTest.cu"
 float __cuda_local_var_37162_14_non_const_f2;
# 1087 "txInterpTest.cu"
 float __cuda_local_var_37162_17_non_const_f3;
# 1087 "txInterpTest.cu"
 float __cuda_local_var_37162_20_non_const_f4;
# 1087 "txInterpTest.cu"
 float __cuda_local_var_37162_23_non_const_f5;
# 1087 "txInterpTest.cu"
 float __cuda_local_var_37162_26_non_const_f6;
# 1087 "txInterpTest.cu"
 float __cuda_local_var_37162_29_non_const_f7;
# 1087 "txInterpTest.cu"
 float __cuda_local_var_37162_32_non_const_f8;
# 1081 "txInterpTest.cu"
__cuda_local_var_37156_6_non_const_x = ((int)((threadIdx.x) + ((blockIdx.x) * (blockDim.x))));
# 1082 "txInterpTest.cu"
__cuda_local_var_37157_6_non_const_y = ((int)((threadIdx.y) + ((blockIdx.y) * (blockDim.y))));
# 1083 "txInterpTest.cu"
__cuda_local_var_37158_8_non_const_xcoord = ((float)((415.625) + ((double)(((float)__cuda_local_var_37156_6_non_const_x) * (0.25F)))));
# 1084 "txInterpTest.cu"
__cuda_local_var_37159_8_non_const_ycoord = ((float)((319.625) + ((double)(((float)__cuda_local_var_37157_6_non_const_y) * (0.25F)))));
# 1085 "txInterpTest.cu"
__cuda_local_var_37160_6_non_const_j = ((int)(((unsigned long)__cuda_local_var_37156_6_non_const_x) + (((unsigned long)__cuda_local_var_37157_6_non_const_y) * pitch)));
# 1086 "txInterpTest.cu"
__cuda_local_var_37161_6_non_const_im = (_Z8ImageFcnff(__cuda_local_var_37158_8_non_const_xcoord, __cuda_local_var_37159_8_non_const_ycoord));
# 1088 "txInterpTest.cu"
if ((((__cuda_local_var_37156_6_non_const_x < n) || (__cuda_local_var_37156_6_non_const_x > (767 - n))) || (__cuda_local_var_37157_6_non_const_y < n)) || (__cuda_local_var_37157_6_non_const_y > (511 - n)))
# 1089 "txInterpTest.cu"
{
# 1091 "txInterpTest.cu"
}
# 1092 "txInterpTest.cu"
else
# 1092 "txInterpTest.cu"
{
# 1092 "txInterpTest.cu"
 __texture_type__ __T2371;
# 1093 "txInterpTest.cu"
 float __T2372;
# 1094 "txInterpTest.cu"
 float __T2373;
# 1095 "txInterpTest.cu"
 float4 __T2374;
# 1096 "txInterpTest.cu"
 float4 __T2375;
# 1097 "txInterpTest.cu"
 __texture_type__ __T2376;
# 1098 "txInterpTest.cu"
 float __T2377;
# 1099 "txInterpTest.cu"
 float __T2378;
# 1100 "txInterpTest.cu"
 float4 __T2379;
# 1101 "txInterpTest.cu"
 float4 __T2380;
# 1102 "txInterpTest.cu"
 __texture_type__ __T2381;
# 1103 "txInterpTest.cu"
 float __T2382;
# 1104 "txInterpTest.cu"
 float __T2383;
# 1105 "txInterpTest.cu"
 float4 __T2384;
# 1106 "txInterpTest.cu"
 float4 __T2385;
# 1107 "txInterpTest.cu"
 __texture_type__ __T2386;
# 1108 "txInterpTest.cu"
 float __T2387;
# 1109 "txInterpTest.cu"
 float __T2388;
# 1110 "txInterpTest.cu"
 float4 __T2389;
# 1111 "txInterpTest.cu"
 float4 __T2390;
# 1112 "txInterpTest.cu"
 __texture_type__ __T2391;
# 1113 "txInterpTest.cu"
 float __T2392;
# 1114 "txInterpTest.cu"
 float __T2393;
# 1115 "txInterpTest.cu"
 float4 __T2394;
# 1116 "txInterpTest.cu"
 float4 __T2395;
# 1117 "txInterpTest.cu"
 __texture_type__ __T2396;
# 1118 "txInterpTest.cu"
 float __T2397;
# 1119 "txInterpTest.cu"
 float __T2398;
# 1120 "txInterpTest.cu"
 float4 __T2399;
# 1121 "txInterpTest.cu"
 float4 __T2400;
# 1093 "txInterpTest.cu"
__cuda_local_var_37162_8_non_const_f0 = (fin[__cuda_local_var_37160_6_non_const_j]);
# 1094 "txInterpTest.cu"
__cuda_local_var_37162_14_non_const_f2 = (fin[((int)((((unsigned long)__cuda_local_var_37156_6_non_const_x) + (((unsigned long)(__cuda_local_var_37157_6_non_const_y - 1)) * pitch)) + ((2UL * pitch) * 512UL)))]);
# 1095 "txInterpTest.cu"
__cuda_local_var_37162_20_non_const_f4 = (fin[((int)((((unsigned long)__cuda_local_var_37156_6_non_const_x) + (((unsigned long)(__cuda_local_var_37157_6_non_const_y + 1)) * pitch)) + ((4UL * pitch) * 512UL)))]);
# 1096 "txInterpTest.cu"
__cuda_local_var_37162_11_non_const_f1 = ((((__T2371 = texRef_f1C) , ((void)(__T2372 = (((float)(__cuda_local_var_37156_6_non_const_x - 1)) + (0.5F))))) , ((void)(__T2373 = (((float)__cuda_local_var_37157_6_non_const_y) + (0.5F))))) , ((__T2375 = (__ftexfetch2D(__T2371, ((((((__T2374.x) = __T2372) , ((void)((__T2374.y) = __T2373))) , ((void)((__T2374.z) = (0.0F)))) , ((void)((__T2374.w) = (0.0F)))) , __T2374)))) , (__T2375.x)));
# 1097 "txInterpTest.cu"
__cuda_local_var_37162_17_non_const_f3 = ((((__T2376 = texRef_f3C) , ((void)(__T2377 = (((float)(__cuda_local_var_37156_6_non_const_x + 1)) + (0.5F))))) , ((void)(__T2378 = (((float)__cuda_local_var_37157_6_non_const_y) + (0.5F))))) , ((__T2380 = (__ftexfetch2D(__T2376, ((((((__T2379.x) = __T2377) , ((void)((__T2379.y) = __T2378))) , ((void)((__T2379.z) = (0.0F)))) , ((void)((__T2379.w) = (0.0F)))) , __T2379)))) , (__T2380.x)));
# 1098 "txInterpTest.cu"
__cuda_local_var_37162_23_non_const_f5 = ((((__T2381 = texRef_f5C) , ((void)(__T2382 = (((float)(__cuda_local_var_37156_6_non_const_x - 1)) + (0.5F))))) , ((void)(__T2383 = (((float)(__cuda_local_var_37157_6_non_const_y - 1)) + (0.5F))))) , ((__T2385 = (__ftexfetch2D(__T2381, ((((((__T2384.x) = __T2382) , ((void)((__T2384.y) = __T2383))) , ((void)((__T2384.z) = (0.0F)))) , ((void)((__T2384.w) = (0.0F)))) , __T2384)))) , (__T2385.x)));
# 1099 "txInterpTest.cu"
__cuda_local_var_37162_26_non_const_f6 = ((((__T2386 = texRef_f6C) , ((void)(__T2387 = (((float)(__cuda_local_var_37156_6_non_const_x + 1)) + (0.5F))))) , ((void)(__T2388 = (((float)(__cuda_local_var_37157_6_non_const_y - 1)) + (0.5F))))) , ((__T2390 = (__ftexfetch2D(__T2386, ((((((__T2389.x) = __T2387) , ((void)((__T2389.y) = __T2388))) , ((void)((__T2389.z) = (0.0F)))) , ((void)((__T2389.w) = (0.0F)))) , __T2389)))) , (__T2390.x)));
# 1100 "txInterpTest.cu"
__cuda_local_var_37162_29_non_const_f7 = ((((__T2391 = texRef_f7C) , ((void)(__T2392 = (((float)(__cuda_local_var_37156_6_non_const_x + 1)) + (0.5F))))) , ((void)(__T2393 = (((float)(__cuda_local_var_37157_6_non_const_y + 1)) + (0.5F))))) , ((__T2395 = (__ftexfetch2D(__T2391, ((((((__T2394.x) = __T2392) , ((void)((__T2394.y) = __T2393))) , ((void)((__T2394.z) = (0.0F)))) , ((void)((__T2394.w) = (0.0F)))) , __T2394)))) , (__T2395.x)));
# 1101 "txInterpTest.cu"
__cuda_local_var_37162_32_non_const_f8 = ((((__T2396 = texRef_f8C) , ((void)(__T2397 = (((float)(__cuda_local_var_37156_6_non_const_x - 1)) + (0.5F))))) , ((void)(__T2398 = (((float)(__cuda_local_var_37157_6_non_const_y + 1)) + (0.5F))))) , ((__T2400 = (__ftexfetch2D(__T2396, ((((((__T2399.x) = __T2397) , ((void)((__T2399.y) = __T2398))) , ((void)((__T2399.z) = (0.0F)))) , ((void)((__T2399.w) = (0.0F)))) , __T2399)))) , (__T2400.x)));
# 1102 "txInterpTest.cu"
if ((__cuda_local_var_37161_6_non_const_im == 1) || (__cuda_local_var_37161_6_non_const_im == 10))
# 1102 "txInterpTest.cu"
{
# 1103 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37156_6_non_const_x) + (((unsigned long)__cuda_local_var_37157_6_non_const_y) * pitch)) + ((1UL * pitch) * 512UL)))]) = __cuda_local_var_37162_17_non_const_f3;
# 1104 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37156_6_non_const_x) + (((unsigned long)__cuda_local_var_37157_6_non_const_y) * pitch)) + ((2UL * pitch) * 512UL)))]) = __cuda_local_var_37162_20_non_const_f4;
# 1105 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37156_6_non_const_x) + (((unsigned long)__cuda_local_var_37157_6_non_const_y) * pitch)) + ((3UL * pitch) * 512UL)))]) = __cuda_local_var_37162_11_non_const_f1;
# 1106 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37156_6_non_const_x) + (((unsigned long)__cuda_local_var_37157_6_non_const_y) * pitch)) + ((4UL * pitch) * 512UL)))]) = __cuda_local_var_37162_14_non_const_f2;
# 1107 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37156_6_non_const_x) + (((unsigned long)__cuda_local_var_37157_6_non_const_y) * pitch)) + ((5UL * pitch) * 512UL)))]) = __cuda_local_var_37162_29_non_const_f7;
# 1108 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37156_6_non_const_x) + (((unsigned long)__cuda_local_var_37157_6_non_const_y) * pitch)) + ((6UL * pitch) * 512UL)))]) = __cuda_local_var_37162_32_non_const_f8;
# 1109 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37156_6_non_const_x) + (((unsigned long)__cuda_local_var_37157_6_non_const_y) * pitch)) + ((7UL * pitch) * 512UL)))]) = __cuda_local_var_37162_23_non_const_f5;
# 1110 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37156_6_non_const_x) + (((unsigned long)__cuda_local_var_37157_6_non_const_y) * pitch)) + ((8UL * pitch) * 512UL)))]) = __cuda_local_var_37162_26_non_const_f6;
# 1111 "txInterpTest.cu"
}
# 1112 "txInterpTest.cu"
else
# 1112 "txInterpTest.cu"
{
# 1113 "txInterpTest.cu"
if (((const char *)"BGK") == ((const char *)"MRT"))
# 1113 "txInterpTest.cu"
{
# 1114 "txInterpTest.cu"
_Z11mrt_collideRfS_S_S_S_S_S_S_S_f((&__cuda_local_var_37162_8_non_const_f0), (&__cuda_local_var_37162_11_non_const_f1), (&__cuda_local_var_37162_14_non_const_f2), (&__cuda_local_var_37162_17_non_const_f3), (&__cuda_local_var_37162_20_non_const_f4), (&__cuda_local_var_37162_23_non_const_f5), (&__cuda_local_var_37162_26_non_const_f6), (&__cuda_local_var_37162_29_non_const_f7), (&__cuda_local_var_37162_32_non_const_f8), omega);
# 1114 "txInterpTest.cu"
}
# 1114 "txInterpTest.cu"
else
# 1114 "txInterpTest.cu"
{
# 1115 "txInterpTest.cu"
if (1)
# 1115 "txInterpTest.cu"
{
# 1116 "txInterpTest.cu"
{
# 1116 "txInterpTest.cu"
__T2367 = ((((((((__cuda_local_var_37162_8_non_const_f0 + __cuda_local_var_37162_11_non_const_f1) + __cuda_local_var_37162_14_non_const_f2) + __cuda_local_var_37162_17_non_const_f3) + __cuda_local_var_37162_20_non_const_f4) + __cuda_local_var_37162_23_non_const_f5) + __cuda_local_var_37162_26_non_const_f6) + __cuda_local_var_37162_29_non_const_f7) + __cuda_local_var_37162_32_non_const_f8);
# 1116 "txInterpTest.cu"
__T2368 = (((((__cuda_local_var_37162_11_non_const_f1 - __cuda_local_var_37162_17_non_const_f3) + __cuda_local_var_37162_23_non_const_f5) - __cuda_local_var_37162_26_non_const_f6) - __cuda_local_var_37162_29_non_const_f7) + __cuda_local_var_37162_32_non_const_f8);
# 1116 "txInterpTest.cu"
__T2369 = (((((__cuda_local_var_37162_14_non_const_f2 - __cuda_local_var_37162_20_non_const_f4) + __cuda_local_var_37162_23_non_const_f5) + __cuda_local_var_37162_26_non_const_f6) - __cuda_local_var_37162_29_non_const_f7) - __cuda_local_var_37162_32_non_const_f8);
# 1116 "txInterpTest.cu"
__T2370 = ((__T2368 * __T2368) + (__T2369 * __T2369));
# 1116 "txInterpTest.cu"
__cuda_local_var_37162_8_non_const_f0 = (__cuda_local_var_37162_8_non_const_f0 - (omega * (__cuda_local_var_37162_8_non_const_f0 - ((0.4444444478F) * (__T2367 - ((1.5F) * __T2370))))));
# 1116 "txInterpTest.cu"
__cuda_local_var_37162_11_non_const_f1 = (__cuda_local_var_37162_11_non_const_f1 - (omega * (__cuda_local_var_37162_11_non_const_f1 - ((0.1111111119F) * (((__T2367 + ((3.0F) * __T2368)) + (((4.5F) * __T2368) * __T2368)) - ((1.5F) * __T2370))))));
# 1116 "txInterpTest.cu"
__cuda_local_var_37162_14_non_const_f2 = (__cuda_local_var_37162_14_non_const_f2 - (omega * (__cuda_local_var_37162_14_non_const_f2 - ((0.1111111119F) * (((__T2367 + ((3.0F) * __T2369)) + (((4.5F) * __T2369) * __T2369)) - ((1.5F) * __T2370))))));
# 1116 "txInterpTest.cu"
__cuda_local_var_37162_17_non_const_f3 = (__cuda_local_var_37162_17_non_const_f3 - (omega * (__cuda_local_var_37162_17_non_const_f3 - ((0.1111111119F) * (((__T2367 - ((3.0F) * __T2368)) + (((4.5F) * __T2368) * __T2368)) - ((1.5F) * __T2370))))));
# 1116 "txInterpTest.cu"
__cuda_local_var_37162_20_non_const_f4 = (__cuda_local_var_37162_20_non_const_f4 - (omega * (__cuda_local_var_37162_20_non_const_f4 - ((0.1111111119F) * (((__T2367 - ((3.0F) * __T2369)) + (((4.5F) * __T2369) * __T2369)) - ((1.5F) * __T2370))))));
# 1116 "txInterpTest.cu"
__cuda_local_var_37162_23_non_const_f5 = ((float)(((double)__cuda_local_var_37162_23_non_const_f5) - (((double)omega) * (((double)__cuda_local_var_37162_23_non_const_f5) - ((0.02777777777999999864) * ((double)(((__T2367 + ((3.0F) * (__T2368 + __T2369))) + (((4.5F) * (__T2368 + __T2369)) * (__T2368 + __T2369))) - ((1.5F) * __T2370))))))));
# 1116 "txInterpTest.cu"
__cuda_local_var_37162_26_non_const_f6 = ((float)(((double)__cuda_local_var_37162_26_non_const_f6) - (((double)omega) * (((double)__cuda_local_var_37162_26_non_const_f6) - ((0.02777777777999999864) * ((double)(((__T2367 + ((3.0F) * ((-__T2368) + __T2369))) + (((4.5F) * ((-__T2368) + __T2369)) * ((-__T2368) + __T2369))) - ((1.5F) * __T2370))))))));
# 1116 "txInterpTest.cu"
__cuda_local_var_37162_29_non_const_f7 = ((float)(((double)__cuda_local_var_37162_29_non_const_f7) - (((double)omega) * (((double)__cuda_local_var_37162_29_non_const_f7) - ((0.02777777777999999864) * ((double)(((__T2367 + ((3.0F) * ((-__T2368) - __T2369))) + (((4.5F) * ((-__T2368) - __T2369)) * ((-__T2368) - __T2369))) - ((1.5F) * __T2370))))))));
# 1116 "txInterpTest.cu"
__cuda_local_var_37162_32_non_const_f8 = ((float)(((double)__cuda_local_var_37162_32_non_const_f8) - (((double)omega) * (((double)__cuda_local_var_37162_32_non_const_f8) - ((0.02777777777999999864) * ((double)(((__T2367 + ((3.0F) * (__T2368 - __T2369))) + (((4.5F) * (__T2368 - __T2369)) * (__T2368 - __T2369))) - ((1.5F) * __T2370))))))));
# 1116 "txInterpTest.cu"
}
# 1116 "txInterpTest.cu"
}
# 1116 "txInterpTest.cu"
}
# 1117 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37156_6_non_const_x) + (((unsigned long)__cuda_local_var_37157_6_non_const_y) * pitch)) + ((0UL * pitch) * 512UL)))]) = __cuda_local_var_37162_8_non_const_f0;
# 1118 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37156_6_non_const_x) + (((unsigned long)__cuda_local_var_37157_6_non_const_y) * pitch)) + ((1UL * pitch) * 512UL)))]) = __cuda_local_var_37162_11_non_const_f1;
# 1119 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37156_6_non_const_x) + (((unsigned long)__cuda_local_var_37157_6_non_const_y) * pitch)) + ((2UL * pitch) * 512UL)))]) = __cuda_local_var_37162_14_non_const_f2;
# 1120 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37156_6_non_const_x) + (((unsigned long)__cuda_local_var_37157_6_non_const_y) * pitch)) + ((3UL * pitch) * 512UL)))]) = __cuda_local_var_37162_17_non_const_f3;
# 1121 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37156_6_non_const_x) + (((unsigned long)__cuda_local_var_37157_6_non_const_y) * pitch)) + ((4UL * pitch) * 512UL)))]) = __cuda_local_var_37162_20_non_const_f4;
# 1122 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37156_6_non_const_x) + (((unsigned long)__cuda_local_var_37157_6_non_const_y) * pitch)) + ((5UL * pitch) * 512UL)))]) = __cuda_local_var_37162_23_non_const_f5;
# 1123 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37156_6_non_const_x) + (((unsigned long)__cuda_local_var_37157_6_non_const_y) * pitch)) + ((6UL * pitch) * 512UL)))]) = __cuda_local_var_37162_26_non_const_f6;
# 1124 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37156_6_non_const_x) + (((unsigned long)__cuda_local_var_37157_6_non_const_y) * pitch)) + ((7UL * pitch) * 512UL)))]) = __cuda_local_var_37162_29_non_const_f7;
# 1125 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37156_6_non_const_x) + (((unsigned long)__cuda_local_var_37157_6_non_const_y) * pitch)) + ((8UL * pitch) * 512UL)))]) = __cuda_local_var_37162_32_non_const_f8;
# 1126 "txInterpTest.cu"
}
# 1127 "txInterpTest.cu"
}
# 1128 "txInterpTest.cu"
}
# 1128 "txInterpTest.cu"
}}
# 1129 "txInterpTest.cu"
__attribute__((global)) __attribute__((__used__)) void _Z10LR_d_BACD2PfS_fm(
# 1129 "txInterpTest.cu"
float *fin,
# 1129 "txInterpTest.cu"
float *fout,
# 1130 "txInterpTest.cu"
float omega,
# 1130 "txInterpTest.cu"
size_t pitch){
# 1130 "txInterpTest.cu"
{
# 1132 "txInterpTest.cu"
{
# 1133 "txInterpTest.cu"
 int __cuda_local_var_37208_6_non_const_x;
# 1134 "txInterpTest.cu"
 int __cuda_local_var_37209_6_non_const_y;
# 1135 "txInterpTest.cu"
 float __cuda_local_var_37210_8_non_const_xcoord;
# 1136 "txInterpTest.cu"
 float __cuda_local_var_37211_8_non_const_ycoord;
# 1137 "txInterpTest.cu"
 int __cuda_local_var_37212_6_non_const_j;
# 1138 "txInterpTest.cu"
 int __cuda_local_var_37213_6_non_const_im;
# 1139 "txInterpTest.cu"
 float __cuda_local_var_37214_8_non_const_f0;
# 1139 "txInterpTest.cu"
 float __cuda_local_var_37214_11_non_const_f1;
# 1139 "txInterpTest.cu"
 float __cuda_local_var_37214_14_non_const_f2;
# 1139 "txInterpTest.cu"
 float __cuda_local_var_37214_17_non_const_f3;
# 1139 "txInterpTest.cu"
 float __cuda_local_var_37214_20_non_const_f4;
# 1139 "txInterpTest.cu"
 float __cuda_local_var_37214_23_non_const_f5;
# 1139 "txInterpTest.cu"
 float __cuda_local_var_37214_26_non_const_f6;
# 1139 "txInterpTest.cu"
 float __cuda_local_var_37214_29_non_const_f7;
# 1139 "txInterpTest.cu"
 float __cuda_local_var_37214_32_non_const_f8;
# 1133 "txInterpTest.cu"
__cuda_local_var_37208_6_non_const_x = ((int)((threadIdx.x) + ((blockIdx.x) * (blockDim.x))));
# 1134 "txInterpTest.cu"
__cuda_local_var_37209_6_non_const_y = ((int)((threadIdx.y) + ((blockIdx.y) * (blockDim.y))));
# 1135 "txInterpTest.cu"
__cuda_local_var_37210_8_non_const_xcoord = ((float)((415.625) + ((double)(((float)__cuda_local_var_37208_6_non_const_x) * (0.25F)))));
# 1136 "txInterpTest.cu"
__cuda_local_var_37211_8_non_const_ycoord = ((float)((319.625) + ((double)(((float)__cuda_local_var_37209_6_non_const_y) * (0.25F)))));
# 1137 "txInterpTest.cu"
__cuda_local_var_37212_6_non_const_j = ((int)(((unsigned long)__cuda_local_var_37208_6_non_const_x) + (((unsigned long)__cuda_local_var_37209_6_non_const_y) * pitch)));
# 1138 "txInterpTest.cu"
__cuda_local_var_37213_6_non_const_im = (_Z8ImageFcnff(__cuda_local_var_37210_8_non_const_xcoord, __cuda_local_var_37211_8_non_const_ycoord));
# 1145 "txInterpTest.cu"
__cuda_local_var_37214_8_non_const_f0 = (fin[__cuda_local_var_37212_6_non_const_j]);
# 1146 "txInterpTest.cu"
__cuda_local_var_37214_11_non_const_f1 = (fin[((int)((((unsigned long)(__cuda_local_var_37208_6_non_const_x - 1)) + (((unsigned long)__cuda_local_var_37209_6_non_const_y) * pitch)) + ((1UL * pitch) * 512UL)))]);
# 1147 "txInterpTest.cu"
__cuda_local_var_37214_14_non_const_f2 = (fin[((int)((((unsigned long)__cuda_local_var_37208_6_non_const_x) + (((unsigned long)(__cuda_local_var_37209_6_non_const_y - 1)) * pitch)) + ((2UL * pitch) * 512UL)))]);
# 1148 "txInterpTest.cu"
__cuda_local_var_37214_17_non_const_f3 = (fin[((int)((((unsigned long)(__cuda_local_var_37208_6_non_const_x + 1)) + (((unsigned long)__cuda_local_var_37209_6_non_const_y) * pitch)) + ((3UL * pitch) * 512UL)))]);
# 1149 "txInterpTest.cu"
__cuda_local_var_37214_20_non_const_f4 = (fin[((int)((((unsigned long)__cuda_local_var_37208_6_non_const_x) + (((unsigned long)(__cuda_local_var_37209_6_non_const_y + 1)) * pitch)) + ((4UL * pitch) * 512UL)))]);
# 1150 "txInterpTest.cu"
__cuda_local_var_37214_23_non_const_f5 = (fin[((int)((((unsigned long)(__cuda_local_var_37208_6_non_const_x - 1)) + (((unsigned long)(__cuda_local_var_37209_6_non_const_y - 1)) * pitch)) + ((5UL * pitch) * 512UL)))]);
# 1151 "txInterpTest.cu"
__cuda_local_var_37214_26_non_const_f6 = (fin[((int)((((unsigned long)(__cuda_local_var_37208_6_non_const_x + 1)) + (((unsigned long)(__cuda_local_var_37209_6_non_const_y - 1)) * pitch)) + ((6UL * pitch) * 512UL)))]);
# 1152 "txInterpTest.cu"
__cuda_local_var_37214_29_non_const_f7 = (fin[((int)((((unsigned long)(__cuda_local_var_37208_6_non_const_x + 1)) + (((unsigned long)(__cuda_local_var_37209_6_non_const_y + 1)) * pitch)) + ((7UL * pitch) * 512UL)))]);
# 1153 "txInterpTest.cu"
__cuda_local_var_37214_32_non_const_f8 = (fin[((int)((((unsigned long)(__cuda_local_var_37208_6_non_const_x - 1)) + (((unsigned long)(__cuda_local_var_37209_6_non_const_y + 1)) * pitch)) + ((8UL * pitch) * 512UL)))]);
# 1154 "txInterpTest.cu"
if ((__cuda_local_var_37213_6_non_const_im == 1) || (__cuda_local_var_37213_6_non_const_im == 10))
# 1154 "txInterpTest.cu"
{
# 1155 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37208_6_non_const_x) + (((unsigned long)__cuda_local_var_37209_6_non_const_y) * pitch)) + ((1UL * pitch) * 512UL)))]) = __cuda_local_var_37214_17_non_const_f3;
# 1156 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37208_6_non_const_x) + (((unsigned long)__cuda_local_var_37209_6_non_const_y) * pitch)) + ((2UL * pitch) * 512UL)))]) = __cuda_local_var_37214_20_non_const_f4;
# 1157 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37208_6_non_const_x) + (((unsigned long)__cuda_local_var_37209_6_non_const_y) * pitch)) + ((3UL * pitch) * 512UL)))]) = __cuda_local_var_37214_11_non_const_f1;
# 1158 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37208_6_non_const_x) + (((unsigned long)__cuda_local_var_37209_6_non_const_y) * pitch)) + ((4UL * pitch) * 512UL)))]) = __cuda_local_var_37214_14_non_const_f2;
# 1159 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37208_6_non_const_x) + (((unsigned long)__cuda_local_var_37209_6_non_const_y) * pitch)) + ((5UL * pitch) * 512UL)))]) = __cuda_local_var_37214_29_non_const_f7;
# 1160 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37208_6_non_const_x) + (((unsigned long)__cuda_local_var_37209_6_non_const_y) * pitch)) + ((6UL * pitch) * 512UL)))]) = __cuda_local_var_37214_32_non_const_f8;
# 1161 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37208_6_non_const_x) + (((unsigned long)__cuda_local_var_37209_6_non_const_y) * pitch)) + ((7UL * pitch) * 512UL)))]) = __cuda_local_var_37214_23_non_const_f5;
# 1162 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37208_6_non_const_x) + (((unsigned long)__cuda_local_var_37209_6_non_const_y) * pitch)) + ((8UL * pitch) * 512UL)))]) = __cuda_local_var_37214_26_non_const_f6;
# 1163 "txInterpTest.cu"
}
# 1164 "txInterpTest.cu"
else
# 1164 "txInterpTest.cu"
{
# 1165 "txInterpTest.cu"
if (((const char *)"BGK") == ((const char *)"MRT"))
# 1165 "txInterpTest.cu"
{
# 1166 "txInterpTest.cu"
_Z11mrt_collideRfS_S_S_S_S_S_S_S_f((&__cuda_local_var_37214_8_non_const_f0), (&__cuda_local_var_37214_11_non_const_f1), (&__cuda_local_var_37214_14_non_const_f2), (&__cuda_local_var_37214_17_non_const_f3), (&__cuda_local_var_37214_20_non_const_f4), (&__cuda_local_var_37214_23_non_const_f5), (&__cuda_local_var_37214_26_non_const_f6), (&__cuda_local_var_37214_29_non_const_f7), (&__cuda_local_var_37214_32_non_const_f8), omega);
# 1166 "txInterpTest.cu"
}
# 1166 "txInterpTest.cu"
else
# 1166 "txInterpTest.cu"
{
# 1167 "txInterpTest.cu"
if (1)
# 1167 "txInterpTest.cu"
{
# 1167 "txInterpTest.cu"
 float __T2401;
# 1168 "txInterpTest.cu"
 float __T2402;
# 1169 "txInterpTest.cu"
 float __T2403;
# 1170 "txInterpTest.cu"
 float __T2404;
# 1168 "txInterpTest.cu"
{
# 1168 "txInterpTest.cu"
__T2401 = ((((((((__cuda_local_var_37214_8_non_const_f0 + __cuda_local_var_37214_11_non_const_f1) + __cuda_local_var_37214_14_non_const_f2) + __cuda_local_var_37214_17_non_const_f3) + __cuda_local_var_37214_20_non_const_f4) + __cuda_local_var_37214_23_non_const_f5) + __cuda_local_var_37214_26_non_const_f6) + __cuda_local_var_37214_29_non_const_f7) + __cuda_local_var_37214_32_non_const_f8);
# 1168 "txInterpTest.cu"
__T2402 = (((((__cuda_local_var_37214_11_non_const_f1 - __cuda_local_var_37214_17_non_const_f3) + __cuda_local_var_37214_23_non_const_f5) - __cuda_local_var_37214_26_non_const_f6) - __cuda_local_var_37214_29_non_const_f7) + __cuda_local_var_37214_32_non_const_f8);
# 1168 "txInterpTest.cu"
__T2403 = (((((__cuda_local_var_37214_14_non_const_f2 - __cuda_local_var_37214_20_non_const_f4) + __cuda_local_var_37214_23_non_const_f5) + __cuda_local_var_37214_26_non_const_f6) - __cuda_local_var_37214_29_non_const_f7) - __cuda_local_var_37214_32_non_const_f8);
# 1168 "txInterpTest.cu"
__T2404 = ((__T2402 * __T2402) + (__T2403 * __T2403));
# 1168 "txInterpTest.cu"
__cuda_local_var_37214_8_non_const_f0 = (__cuda_local_var_37214_8_non_const_f0 - (omega * (__cuda_local_var_37214_8_non_const_f0 - ((0.4444444478F) * (__T2401 - ((1.5F) * __T2404))))));
# 1168 "txInterpTest.cu"
__cuda_local_var_37214_11_non_const_f1 = (__cuda_local_var_37214_11_non_const_f1 - (omega * (__cuda_local_var_37214_11_non_const_f1 - ((0.1111111119F) * (((__T2401 + ((3.0F) * __T2402)) + (((4.5F) * __T2402) * __T2402)) - ((1.5F) * __T2404))))));
# 1168 "txInterpTest.cu"
__cuda_local_var_37214_14_non_const_f2 = (__cuda_local_var_37214_14_non_const_f2 - (omega * (__cuda_local_var_37214_14_non_const_f2 - ((0.1111111119F) * (((__T2401 + ((3.0F) * __T2403)) + (((4.5F) * __T2403) * __T2403)) - ((1.5F) * __T2404))))));
# 1168 "txInterpTest.cu"
__cuda_local_var_37214_17_non_const_f3 = (__cuda_local_var_37214_17_non_const_f3 - (omega * (__cuda_local_var_37214_17_non_const_f3 - ((0.1111111119F) * (((__T2401 - ((3.0F) * __T2402)) + (((4.5F) * __T2402) * __T2402)) - ((1.5F) * __T2404))))));
# 1168 "txInterpTest.cu"
__cuda_local_var_37214_20_non_const_f4 = (__cuda_local_var_37214_20_non_const_f4 - (omega * (__cuda_local_var_37214_20_non_const_f4 - ((0.1111111119F) * (((__T2401 - ((3.0F) * __T2403)) + (((4.5F) * __T2403) * __T2403)) - ((1.5F) * __T2404))))));
# 1168 "txInterpTest.cu"
__cuda_local_var_37214_23_non_const_f5 = ((float)(((double)__cuda_local_var_37214_23_non_const_f5) - (((double)omega) * (((double)__cuda_local_var_37214_23_non_const_f5) - ((0.02777777777999999864) * ((double)(((__T2401 + ((3.0F) * (__T2402 + __T2403))) + (((4.5F) * (__T2402 + __T2403)) * (__T2402 + __T2403))) - ((1.5F) * __T2404))))))));
# 1168 "txInterpTest.cu"
__cuda_local_var_37214_26_non_const_f6 = ((float)(((double)__cuda_local_var_37214_26_non_const_f6) - (((double)omega) * (((double)__cuda_local_var_37214_26_non_const_f6) - ((0.02777777777999999864) * ((double)(((__T2401 + ((3.0F) * ((-__T2402) + __T2403))) + (((4.5F) * ((-__T2402) + __T2403)) * ((-__T2402) + __T2403))) - ((1.5F) * __T2404))))))));
# 1168 "txInterpTest.cu"
__cuda_local_var_37214_29_non_const_f7 = ((float)(((double)__cuda_local_var_37214_29_non_const_f7) - (((double)omega) * (((double)__cuda_local_var_37214_29_non_const_f7) - ((0.02777777777999999864) * ((double)(((__T2401 + ((3.0F) * ((-__T2402) - __T2403))) + (((4.5F) * ((-__T2402) - __T2403)) * ((-__T2402) - __T2403))) - ((1.5F) * __T2404))))))));
# 1168 "txInterpTest.cu"
__cuda_local_var_37214_32_non_const_f8 = ((float)(((double)__cuda_local_var_37214_32_non_const_f8) - (((double)omega) * (((double)__cuda_local_var_37214_32_non_const_f8) - ((0.02777777777999999864) * ((double)(((__T2401 + ((3.0F) * (__T2402 - __T2403))) + (((4.5F) * (__T2402 - __T2403)) * (__T2402 - __T2403))) - ((1.5F) * __T2404))))))));
# 1168 "txInterpTest.cu"
}
# 1168 "txInterpTest.cu"
}
# 1168 "txInterpTest.cu"
}
# 1169 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37208_6_non_const_x) + (((unsigned long)__cuda_local_var_37209_6_non_const_y) * pitch)) + ((0UL * pitch) * 512UL)))]) = __cuda_local_var_37214_8_non_const_f0;
# 1170 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37208_6_non_const_x) + (((unsigned long)__cuda_local_var_37209_6_non_const_y) * pitch)) + ((1UL * pitch) * 512UL)))]) = __cuda_local_var_37214_11_non_const_f1;
# 1171 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37208_6_non_const_x) + (((unsigned long)__cuda_local_var_37209_6_non_const_y) * pitch)) + ((2UL * pitch) * 512UL)))]) = __cuda_local_var_37214_14_non_const_f2;
# 1172 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37208_6_non_const_x) + (((unsigned long)__cuda_local_var_37209_6_non_const_y) * pitch)) + ((3UL * pitch) * 512UL)))]) = __cuda_local_var_37214_17_non_const_f3;
# 1173 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37208_6_non_const_x) + (((unsigned long)__cuda_local_var_37209_6_non_const_y) * pitch)) + ((4UL * pitch) * 512UL)))]) = __cuda_local_var_37214_20_non_const_f4;
# 1174 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37208_6_non_const_x) + (((unsigned long)__cuda_local_var_37209_6_non_const_y) * pitch)) + ((5UL * pitch) * 512UL)))]) = __cuda_local_var_37214_23_non_const_f5;
# 1175 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37208_6_non_const_x) + (((unsigned long)__cuda_local_var_37209_6_non_const_y) * pitch)) + ((6UL * pitch) * 512UL)))]) = __cuda_local_var_37214_26_non_const_f6;
# 1176 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37208_6_non_const_x) + (((unsigned long)__cuda_local_var_37209_6_non_const_y) * pitch)) + ((7UL * pitch) * 512UL)))]) = __cuda_local_var_37214_29_non_const_f7;
# 1177 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37208_6_non_const_x) + (((unsigned long)__cuda_local_var_37209_6_non_const_y) * pitch)) + ((8UL * pitch) * 512UL)))]) = __cuda_local_var_37214_32_non_const_f8;
# 1178 "txInterpTest.cu"
}
# 1180 "txInterpTest.cu"
}
# 1180 "txInterpTest.cu"
}}
# 1182 "txInterpTest.cu"
__attribute__((global)) __attribute__((__used__)) void _Z12LR_d_hybBADCPfS_fmf(
# 1182 "txInterpTest.cu"
float *fin,
# 1182 "txInterpTest.cu"
float *fout,
# 1183 "txInterpTest.cu"
float omega,
# 1183 "txInterpTest.cu"
size_t pitch,
# 1183 "txInterpTest.cu"
float SF){
# 1183 "txInterpTest.cu"
{
# 1184 "txInterpTest.cu"
{
# 1184 "txInterpTest.cu"
 float __T2405;
# 1185 "txInterpTest.cu"
 float __T2406;
# 1186 "txInterpTest.cu"
 float __T2407;
# 1187 "txInterpTest.cu"
 float __T2408;
# 1185 "txInterpTest.cu"
 int __cuda_local_var_37260_6_non_const_x;
# 1186 "txInterpTest.cu"
 int __cuda_local_var_37261_6_non_const_y;
# 1187 "txInterpTest.cu"
 float __cuda_local_var_37262_8_non_const_xcoord;
# 1188 "txInterpTest.cu"
 float __cuda_local_var_37263_8_non_const_ycoord;
# 1189 "txInterpTest.cu"
 int __cuda_local_var_37264_6_non_const_j;
# 1190 "txInterpTest.cu"
 float __cuda_local_var_37265_8_non_const_f0;
# 1190 "txInterpTest.cu"
 float __cuda_local_var_37265_11_non_const_f1;
# 1190 "txInterpTest.cu"
 float __cuda_local_var_37265_14_non_const_f2;
# 1190 "txInterpTest.cu"
 float __cuda_local_var_37265_17_non_const_f3;
# 1190 "txInterpTest.cu"
 float __cuda_local_var_37265_20_non_const_f4;
# 1190 "txInterpTest.cu"
 float __cuda_local_var_37265_23_non_const_f5;
# 1190 "txInterpTest.cu"
 float __cuda_local_var_37265_26_non_const_f6;
# 1190 "txInterpTest.cu"
 float __cuda_local_var_37265_29_non_const_f7;
# 1190 "txInterpTest.cu"
 float __cuda_local_var_37265_32_non_const_f8;
# 1191 "txInterpTest.cu"
 int __cuda_local_var_37266_6_non_const_im;
# 1185 "txInterpTest.cu"
__cuda_local_var_37260_6_non_const_x = ((int)((threadIdx.x) + ((blockIdx.x) * (blockDim.x))));
# 1186 "txInterpTest.cu"
__cuda_local_var_37261_6_non_const_y = ((int)((threadIdx.y) + ((blockIdx.y) * (blockDim.y))));
# 1187 "txInterpTest.cu"
__cuda_local_var_37262_8_non_const_xcoord = ((float)((415.625) + ((double)(((float)__cuda_local_var_37260_6_non_const_x) * (0.25F)))));
# 1188 "txInterpTest.cu"
__cuda_local_var_37263_8_non_const_ycoord = ((float)((319.625) + ((double)(((float)__cuda_local_var_37261_6_non_const_y) * (0.25F)))));
# 1189 "txInterpTest.cu"
__cuda_local_var_37264_6_non_const_j = ((int)(((unsigned long)__cuda_local_var_37260_6_non_const_x) + (((unsigned long)__cuda_local_var_37261_6_non_const_y) * pitch)));
# 1191 "txInterpTest.cu"
__cuda_local_var_37266_6_non_const_im = (_Z8ImageFcnff(__cuda_local_var_37262_8_non_const_xcoord, __cuda_local_var_37263_8_non_const_ycoord));
# 1193 "txInterpTest.cu"
if ((((__cuda_local_var_37260_6_non_const_x < 2) || (__cuda_local_var_37260_6_non_const_x > 765)) || (__cuda_local_var_37261_6_non_const_y < 2)) || (__cuda_local_var_37261_6_non_const_y > 509))
# 1194 "txInterpTest.cu"
{
# 1196 "txInterpTest.cu"
}
# 1197 "txInterpTest.cu"
else
# 1197 "txInterpTest.cu"
{
# 1197 "txInterpTest.cu"
 __texture_type__ __T2409;
# 1198 "txInterpTest.cu"
 float __T2410;
# 1199 "txInterpTest.cu"
 float __T2411;
# 1200 "txInterpTest.cu"
 float4 __T2412;
# 1201 "txInterpTest.cu"
 float4 __T2413;
# 1202 "txInterpTest.cu"
 __texture_type__ __T2414;
# 1203 "txInterpTest.cu"
 float __T2415;
# 1204 "txInterpTest.cu"
 float __T2416;
# 1205 "txInterpTest.cu"
 float4 __T2417;
# 1206 "txInterpTest.cu"
 float4 __T2418;
# 1207 "txInterpTest.cu"
 __texture_type__ __T2419;
# 1208 "txInterpTest.cu"
 float __T2420;
# 1209 "txInterpTest.cu"
 float __T2421;
# 1210 "txInterpTest.cu"
 float4 __T2422;
# 1211 "txInterpTest.cu"
 float4 __T2423;
# 1212 "txInterpTest.cu"
 __texture_type__ __T2424;
# 1213 "txInterpTest.cu"
 float __T2425;
# 1214 "txInterpTest.cu"
 float __T2426;
# 1215 "txInterpTest.cu"
 float4 __T2427;
# 1216 "txInterpTest.cu"
 float4 __T2428;
# 1217 "txInterpTest.cu"
 __texture_type__ __T2429;
# 1218 "txInterpTest.cu"
 float __T2430;
# 1219 "txInterpTest.cu"
 float __T2431;
# 1220 "txInterpTest.cu"
 float4 __T2432;
# 1221 "txInterpTest.cu"
 float4 __T2433;
# 1222 "txInterpTest.cu"
 __texture_type__ __T2434;
# 1223 "txInterpTest.cu"
 float __T2435;
# 1224 "txInterpTest.cu"
 float __T2436;
# 1225 "txInterpTest.cu"
 float4 __T2437;
# 1226 "txInterpTest.cu"
 float4 __T2438;
# 1198 "txInterpTest.cu"
__cuda_local_var_37265_8_non_const_f0 = (fin[__cuda_local_var_37264_6_non_const_j]);
# 1199 "txInterpTest.cu"
__cuda_local_var_37265_14_non_const_f2 = (fin[((int)((((unsigned long)__cuda_local_var_37260_6_non_const_x) + (((unsigned long)(__cuda_local_var_37261_6_non_const_y - 1)) * pitch)) + ((2UL * pitch) * 512UL)))]);
# 1200 "txInterpTest.cu"
__cuda_local_var_37265_20_non_const_f4 = (fin[((int)((((unsigned long)__cuda_local_var_37260_6_non_const_x) + (((unsigned long)(__cuda_local_var_37261_6_non_const_y + 1)) * pitch)) + ((4UL * pitch) * 512UL)))]);
# 1201 "txInterpTest.cu"
__cuda_local_var_37265_11_non_const_f1 = ((((__T2409 = texRef_f1D) , ((void)(__T2410 = (((float)(__cuda_local_var_37260_6_non_const_x - 1)) + (0.5F))))) , ((void)(__T2411 = (((float)__cuda_local_var_37261_6_non_const_y) + (0.5F))))) , ((__T2413 = (__ftexfetch2D(__T2409, ((((((__T2412.x) = __T2410) , ((void)((__T2412.y) = __T2411))) , ((void)((__T2412.z) = (0.0F)))) , ((void)((__T2412.w) = (0.0F)))) , __T2412)))) , (__T2413.x)));
# 1202 "txInterpTest.cu"
__cuda_local_var_37265_17_non_const_f3 = ((((__T2414 = texRef_f3D) , ((void)(__T2415 = (((float)(__cuda_local_var_37260_6_non_const_x + 1)) + (0.5F))))) , ((void)(__T2416 = (((float)__cuda_local_var_37261_6_non_const_y) + (0.5F))))) , ((__T2418 = (__ftexfetch2D(__T2414, ((((((__T2417.x) = __T2415) , ((void)((__T2417.y) = __T2416))) , ((void)((__T2417.z) = (0.0F)))) , ((void)((__T2417.w) = (0.0F)))) , __T2417)))) , (__T2418.x)));
# 1203 "txInterpTest.cu"
__cuda_local_var_37265_23_non_const_f5 = ((((__T2419 = texRef_f5D) , ((void)(__T2420 = (((float)(__cuda_local_var_37260_6_non_const_x - 1)) + (0.5F))))) , ((void)(__T2421 = (((float)(__cuda_local_var_37261_6_non_const_y - 1)) + (0.5F))))) , ((__T2423 = (__ftexfetch2D(__T2419, ((((((__T2422.x) = __T2420) , ((void)((__T2422.y) = __T2421))) , ((void)((__T2422.z) = (0.0F)))) , ((void)((__T2422.w) = (0.0F)))) , __T2422)))) , (__T2423.x)));
# 1204 "txInterpTest.cu"
__cuda_local_var_37265_26_non_const_f6 = ((((__T2424 = texRef_f6D) , ((void)(__T2425 = (((float)(__cuda_local_var_37260_6_non_const_x + 1)) + (0.5F))))) , ((void)(__T2426 = (((float)(__cuda_local_var_37261_6_non_const_y - 1)) + (0.5F))))) , ((__T2428 = (__ftexfetch2D(__T2424, ((((((__T2427.x) = __T2425) , ((void)((__T2427.y) = __T2426))) , ((void)((__T2427.z) = (0.0F)))) , ((void)((__T2427.w) = (0.0F)))) , __T2427)))) , (__T2428.x)));
# 1205 "txInterpTest.cu"
__cuda_local_var_37265_29_non_const_f7 = ((((__T2429 = texRef_f7D) , ((void)(__T2430 = (((float)(__cuda_local_var_37260_6_non_const_x + 1)) + (0.5F))))) , ((void)(__T2431 = (((float)(__cuda_local_var_37261_6_non_const_y + 1)) + (0.5F))))) , ((__T2433 = (__ftexfetch2D(__T2429, ((((((__T2432.x) = __T2430) , ((void)((__T2432.y) = __T2431))) , ((void)((__T2432.z) = (0.0F)))) , ((void)((__T2432.w) = (0.0F)))) , __T2432)))) , (__T2433.x)));
# 1206 "txInterpTest.cu"
__cuda_local_var_37265_32_non_const_f8 = ((((__T2434 = texRef_f8D) , ((void)(__T2435 = (((float)(__cuda_local_var_37260_6_non_const_x - 1)) + (0.5F))))) , ((void)(__T2436 = (((float)(__cuda_local_var_37261_6_non_const_y + 1)) + (0.5F))))) , ((__T2438 = (__ftexfetch2D(__T2434, ((((((__T2437.x) = __T2435) , ((void)((__T2437.y) = __T2436))) , ((void)((__T2437.z) = (0.0F)))) , ((void)((__T2437.w) = (0.0F)))) , __T2437)))) , (__T2438.x)));
# 1207 "txInterpTest.cu"
if ((__cuda_local_var_37266_6_non_const_im == 1) || (__cuda_local_var_37266_6_non_const_im == 10))
# 1207 "txInterpTest.cu"
{
# 1208 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37260_6_non_const_x) + (((unsigned long)__cuda_local_var_37261_6_non_const_y) * pitch)) + ((1UL * pitch) * 512UL)))]) = __cuda_local_var_37265_17_non_const_f3;
# 1209 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37260_6_non_const_x) + (((unsigned long)__cuda_local_var_37261_6_non_const_y) * pitch)) + ((2UL * pitch) * 512UL)))]) = __cuda_local_var_37265_20_non_const_f4;
# 1210 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37260_6_non_const_x) + (((unsigned long)__cuda_local_var_37261_6_non_const_y) * pitch)) + ((3UL * pitch) * 512UL)))]) = __cuda_local_var_37265_11_non_const_f1;
# 1211 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37260_6_non_const_x) + (((unsigned long)__cuda_local_var_37261_6_non_const_y) * pitch)) + ((4UL * pitch) * 512UL)))]) = __cuda_local_var_37265_14_non_const_f2;
# 1212 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37260_6_non_const_x) + (((unsigned long)__cuda_local_var_37261_6_non_const_y) * pitch)) + ((5UL * pitch) * 512UL)))]) = __cuda_local_var_37265_29_non_const_f7;
# 1213 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37260_6_non_const_x) + (((unsigned long)__cuda_local_var_37261_6_non_const_y) * pitch)) + ((6UL * pitch) * 512UL)))]) = __cuda_local_var_37265_32_non_const_f8;
# 1214 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37260_6_non_const_x) + (((unsigned long)__cuda_local_var_37261_6_non_const_y) * pitch)) + ((7UL * pitch) * 512UL)))]) = __cuda_local_var_37265_23_non_const_f5;
# 1215 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37260_6_non_const_x) + (((unsigned long)__cuda_local_var_37261_6_non_const_y) * pitch)) + ((8UL * pitch) * 512UL)))]) = __cuda_local_var_37265_26_non_const_f6;
# 1216 "txInterpTest.cu"
}
# 1217 "txInterpTest.cu"
else
# 1217 "txInterpTest.cu"
{
# 1218 "txInterpTest.cu"
if (((const char *)"BGK") == ((const char *)"MRT"))
# 1218 "txInterpTest.cu"
{
# 1219 "txInterpTest.cu"
_Z11mrt_collideRfS_S_S_S_S_S_S_S_f((&__cuda_local_var_37265_8_non_const_f0), (&__cuda_local_var_37265_11_non_const_f1), (&__cuda_local_var_37265_14_non_const_f2), (&__cuda_local_var_37265_17_non_const_f3), (&__cuda_local_var_37265_20_non_const_f4), (&__cuda_local_var_37265_23_non_const_f5), (&__cuda_local_var_37265_26_non_const_f6), (&__cuda_local_var_37265_29_non_const_f7), (&__cuda_local_var_37265_32_non_const_f8), omega);
# 1219 "txInterpTest.cu"
}
# 1219 "txInterpTest.cu"
else
# 1219 "txInterpTest.cu"
{
# 1220 "txInterpTest.cu"
if (1)
# 1220 "txInterpTest.cu"
{
# 1221 "txInterpTest.cu"
{
# 1221 "txInterpTest.cu"
__T2405 = ((((((((__cuda_local_var_37265_8_non_const_f0 + __cuda_local_var_37265_11_non_const_f1) + __cuda_local_var_37265_14_non_const_f2) + __cuda_local_var_37265_17_non_const_f3) + __cuda_local_var_37265_20_non_const_f4) + __cuda_local_var_37265_23_non_const_f5) + __cuda_local_var_37265_26_non_const_f6) + __cuda_local_var_37265_29_non_const_f7) + __cuda_local_var_37265_32_non_const_f8);
# 1221 "txInterpTest.cu"
__T2406 = (((((__cuda_local_var_37265_11_non_const_f1 - __cuda_local_var_37265_17_non_const_f3) + __cuda_local_var_37265_23_non_const_f5) - __cuda_local_var_37265_26_non_const_f6) - __cuda_local_var_37265_29_non_const_f7) + __cuda_local_var_37265_32_non_const_f8);
# 1221 "txInterpTest.cu"
__T2407 = (((((__cuda_local_var_37265_14_non_const_f2 - __cuda_local_var_37265_20_non_const_f4) + __cuda_local_var_37265_23_non_const_f5) + __cuda_local_var_37265_26_non_const_f6) - __cuda_local_var_37265_29_non_const_f7) - __cuda_local_var_37265_32_non_const_f8);
# 1221 "txInterpTest.cu"
__T2408 = ((__T2406 * __T2406) + (__T2407 * __T2407));
# 1221 "txInterpTest.cu"
__cuda_local_var_37265_8_non_const_f0 = (__cuda_local_var_37265_8_non_const_f0 - (omega * (__cuda_local_var_37265_8_non_const_f0 - ((0.4444444478F) * (__T2405 - ((1.5F) * __T2408))))));
# 1221 "txInterpTest.cu"
__cuda_local_var_37265_11_non_const_f1 = (__cuda_local_var_37265_11_non_const_f1 - (omega * (__cuda_local_var_37265_11_non_const_f1 - ((0.1111111119F) * (((__T2405 + ((3.0F) * __T2406)) + (((4.5F) * __T2406) * __T2406)) - ((1.5F) * __T2408))))));
# 1221 "txInterpTest.cu"
__cuda_local_var_37265_14_non_const_f2 = (__cuda_local_var_37265_14_non_const_f2 - (omega * (__cuda_local_var_37265_14_non_const_f2 - ((0.1111111119F) * (((__T2405 + ((3.0F) * __T2407)) + (((4.5F) * __T2407) * __T2407)) - ((1.5F) * __T2408))))));
# 1221 "txInterpTest.cu"
__cuda_local_var_37265_17_non_const_f3 = (__cuda_local_var_37265_17_non_const_f3 - (omega * (__cuda_local_var_37265_17_non_const_f3 - ((0.1111111119F) * (((__T2405 - ((3.0F) * __T2406)) + (((4.5F) * __T2406) * __T2406)) - ((1.5F) * __T2408))))));
# 1221 "txInterpTest.cu"
__cuda_local_var_37265_20_non_const_f4 = (__cuda_local_var_37265_20_non_const_f4 - (omega * (__cuda_local_var_37265_20_non_const_f4 - ((0.1111111119F) * (((__T2405 - ((3.0F) * __T2407)) + (((4.5F) * __T2407) * __T2407)) - ((1.5F) * __T2408))))));
# 1221 "txInterpTest.cu"
__cuda_local_var_37265_23_non_const_f5 = ((float)(((double)__cuda_local_var_37265_23_non_const_f5) - (((double)omega) * (((double)__cuda_local_var_37265_23_non_const_f5) - ((0.02777777777999999864) * ((double)(((__T2405 + ((3.0F) * (__T2406 + __T2407))) + (((4.5F) * (__T2406 + __T2407)) * (__T2406 + __T2407))) - ((1.5F) * __T2408))))))));
# 1221 "txInterpTest.cu"
__cuda_local_var_37265_26_non_const_f6 = ((float)(((double)__cuda_local_var_37265_26_non_const_f6) - (((double)omega) * (((double)__cuda_local_var_37265_26_non_const_f6) - ((0.02777777777999999864) * ((double)(((__T2405 + ((3.0F) * ((-__T2406) + __T2407))) + (((4.5F) * ((-__T2406) + __T2407)) * ((-__T2406) + __T2407))) - ((1.5F) * __T2408))))))));
# 1221 "txInterpTest.cu"
__cuda_local_var_37265_29_non_const_f7 = ((float)(((double)__cuda_local_var_37265_29_non_const_f7) - (((double)omega) * (((double)__cuda_local_var_37265_29_non_const_f7) - ((0.02777777777999999864) * ((double)(((__T2405 + ((3.0F) * ((-__T2406) - __T2407))) + (((4.5F) * ((-__T2406) - __T2407)) * ((-__T2406) - __T2407))) - ((1.5F) * __T2408))))))));
# 1221 "txInterpTest.cu"
__cuda_local_var_37265_32_non_const_f8 = ((float)(((double)__cuda_local_var_37265_32_non_const_f8) - (((double)omega) * (((double)__cuda_local_var_37265_32_non_const_f8) - ((0.02777777777999999864) * ((double)(((__T2405 + ((3.0F) * (__T2406 - __T2407))) + (((4.5F) * (__T2406 - __T2407)) * (__T2406 - __T2407))) - ((1.5F) * __T2408))))))));
# 1221 "txInterpTest.cu"
}
# 1221 "txInterpTest.cu"
}
# 1221 "txInterpTest.cu"
}
# 1223 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37260_6_non_const_x) + (((unsigned long)__cuda_local_var_37261_6_non_const_y) * pitch)) + ((0UL * pitch) * 512UL)))]) = __cuda_local_var_37265_8_non_const_f0;
# 1224 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37260_6_non_const_x) + (((unsigned long)__cuda_local_var_37261_6_non_const_y) * pitch)) + ((1UL * pitch) * 512UL)))]) = __cuda_local_var_37265_11_non_const_f1;
# 1225 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37260_6_non_const_x) + (((unsigned long)__cuda_local_var_37261_6_non_const_y) * pitch)) + ((2UL * pitch) * 512UL)))]) = __cuda_local_var_37265_14_non_const_f2;
# 1226 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37260_6_non_const_x) + (((unsigned long)__cuda_local_var_37261_6_non_const_y) * pitch)) + ((3UL * pitch) * 512UL)))]) = __cuda_local_var_37265_17_non_const_f3;
# 1227 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37260_6_non_const_x) + (((unsigned long)__cuda_local_var_37261_6_non_const_y) * pitch)) + ((4UL * pitch) * 512UL)))]) = __cuda_local_var_37265_20_non_const_f4;
# 1228 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37260_6_non_const_x) + (((unsigned long)__cuda_local_var_37261_6_non_const_y) * pitch)) + ((5UL * pitch) * 512UL)))]) = __cuda_local_var_37265_23_non_const_f5;
# 1229 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37260_6_non_const_x) + (((unsigned long)__cuda_local_var_37261_6_non_const_y) * pitch)) + ((6UL * pitch) * 512UL)))]) = __cuda_local_var_37265_26_non_const_f6;
# 1230 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37260_6_non_const_x) + (((unsigned long)__cuda_local_var_37261_6_non_const_y) * pitch)) + ((7UL * pitch) * 512UL)))]) = __cuda_local_var_37265_29_non_const_f7;
# 1231 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37260_6_non_const_x) + (((unsigned long)__cuda_local_var_37261_6_non_const_y) * pitch)) + ((8UL * pitch) * 512UL)))]) = __cuda_local_var_37265_32_non_const_f8;
# 1232 "txInterpTest.cu"
}
# 1233 "txInterpTest.cu"
}
# 1234 "txInterpTest.cu"
}
# 1234 "txInterpTest.cu"
}}
# 1235 "txInterpTest.cu"
__attribute__((global)) __attribute__((__used__)) void _Z13LR_d_hybBADC2PfS_fmfi(
# 1235 "txInterpTest.cu"
float *fin,
# 1235 "txInterpTest.cu"
float *fout,
# 1236 "txInterpTest.cu"
float omega,
# 1236 "txInterpTest.cu"
size_t pitch,
# 1236 "txInterpTest.cu"
float SF,
# 1236 "txInterpTest.cu"
int n){
# 1236 "txInterpTest.cu"
{
# 1237 "txInterpTest.cu"
{
# 1237 "txInterpTest.cu"
 float __T2439;
# 1238 "txInterpTest.cu"
 float __T2440;
# 1239 "txInterpTest.cu"
 float __T2441;
# 1240 "txInterpTest.cu"
 float __T2442;
# 1238 "txInterpTest.cu"
 int __cuda_local_var_37313_6_non_const_x;
# 1239 "txInterpTest.cu"
 int __cuda_local_var_37314_6_non_const_y;
# 1240 "txInterpTest.cu"
 float __cuda_local_var_37315_8_non_const_xcoord;
# 1241 "txInterpTest.cu"
 float __cuda_local_var_37316_8_non_const_ycoord;
# 1242 "txInterpTest.cu"
 int __cuda_local_var_37317_6_non_const_j;
# 1243 "txInterpTest.cu"
 float __cuda_local_var_37318_8_non_const_f0;
# 1243 "txInterpTest.cu"
 float __cuda_local_var_37318_11_non_const_f1;
# 1243 "txInterpTest.cu"
 float __cuda_local_var_37318_14_non_const_f2;
# 1243 "txInterpTest.cu"
 float __cuda_local_var_37318_17_non_const_f3;
# 1243 "txInterpTest.cu"
 float __cuda_local_var_37318_20_non_const_f4;
# 1243 "txInterpTest.cu"
 float __cuda_local_var_37318_23_non_const_f5;
# 1243 "txInterpTest.cu"
 float __cuda_local_var_37318_26_non_const_f6;
# 1243 "txInterpTest.cu"
 float __cuda_local_var_37318_29_non_const_f7;
# 1243 "txInterpTest.cu"
 float __cuda_local_var_37318_32_non_const_f8;
# 1244 "txInterpTest.cu"
 int __cuda_local_var_37319_6_non_const_im;
# 1238 "txInterpTest.cu"
__cuda_local_var_37313_6_non_const_x = ((int)((threadIdx.x) + ((blockIdx.x) * (blockDim.x))));
# 1239 "txInterpTest.cu"
__cuda_local_var_37314_6_non_const_y = ((int)((threadIdx.y) + ((blockIdx.y) * (blockDim.y))));
# 1240 "txInterpTest.cu"
__cuda_local_var_37315_8_non_const_xcoord = ((float)((415.625) + ((double)(((float)__cuda_local_var_37313_6_non_const_x) * (0.25F)))));
# 1241 "txInterpTest.cu"
__cuda_local_var_37316_8_non_const_ycoord = ((float)((319.625) + ((double)(((float)__cuda_local_var_37314_6_non_const_y) * (0.25F)))));
# 1242 "txInterpTest.cu"
__cuda_local_var_37317_6_non_const_j = ((int)(((unsigned long)__cuda_local_var_37313_6_non_const_x) + (((unsigned long)__cuda_local_var_37314_6_non_const_y) * pitch)));
# 1244 "txInterpTest.cu"
__cuda_local_var_37319_6_non_const_im = (_Z8ImageFcnff(__cuda_local_var_37315_8_non_const_xcoord, __cuda_local_var_37316_8_non_const_ycoord));
# 1246 "txInterpTest.cu"
if ((((__cuda_local_var_37313_6_non_const_x < n) || (__cuda_local_var_37313_6_non_const_x > (767 - n))) || (__cuda_local_var_37314_6_non_const_y < n)) || (__cuda_local_var_37314_6_non_const_y > (511 - n)))
# 1247 "txInterpTest.cu"
{
# 1249 "txInterpTest.cu"
}
# 1250 "txInterpTest.cu"
else
# 1250 "txInterpTest.cu"
{
# 1250 "txInterpTest.cu"
 __texture_type__ __T2443;
# 1251 "txInterpTest.cu"
 float __T2444;
# 1252 "txInterpTest.cu"
 float __T2445;
# 1253 "txInterpTest.cu"
 float4 __T2446;
# 1254 "txInterpTest.cu"
 float4 __T2447;
# 1255 "txInterpTest.cu"
 __texture_type__ __T2448;
# 1256 "txInterpTest.cu"
 float __T2449;
# 1257 "txInterpTest.cu"
 float __T2450;
# 1258 "txInterpTest.cu"
 float4 __T2451;
# 1259 "txInterpTest.cu"
 float4 __T2452;
# 1260 "txInterpTest.cu"
 __texture_type__ __T2453;
# 1261 "txInterpTest.cu"
 float __T2454;
# 1262 "txInterpTest.cu"
 float __T2455;
# 1263 "txInterpTest.cu"
 float4 __T2456;
# 1264 "txInterpTest.cu"
 float4 __T2457;
# 1265 "txInterpTest.cu"
 __texture_type__ __T2458;
# 1266 "txInterpTest.cu"
 float __T2459;
# 1267 "txInterpTest.cu"
 float __T2460;
# 1268 "txInterpTest.cu"
 float4 __T2461;
# 1269 "txInterpTest.cu"
 float4 __T2462;
# 1270 "txInterpTest.cu"
 __texture_type__ __T2463;
# 1271 "txInterpTest.cu"
 float __T2464;
# 1272 "txInterpTest.cu"
 float __T2465;
# 1273 "txInterpTest.cu"
 float4 __T2466;
# 1274 "txInterpTest.cu"
 float4 __T2467;
# 1275 "txInterpTest.cu"
 __texture_type__ __T2468;
# 1276 "txInterpTest.cu"
 float __T2469;
# 1277 "txInterpTest.cu"
 float __T2470;
# 1278 "txInterpTest.cu"
 float4 __T2471;
# 1279 "txInterpTest.cu"
 float4 __T2472;
# 1251 "txInterpTest.cu"
__cuda_local_var_37318_8_non_const_f0 = (fin[__cuda_local_var_37317_6_non_const_j]);
# 1252 "txInterpTest.cu"
__cuda_local_var_37318_14_non_const_f2 = (fin[((int)((((unsigned long)__cuda_local_var_37313_6_non_const_x) + (((unsigned long)(__cuda_local_var_37314_6_non_const_y - 1)) * pitch)) + ((2UL * pitch) * 512UL)))]);
# 1253 "txInterpTest.cu"
__cuda_local_var_37318_20_non_const_f4 = (fin[((int)((((unsigned long)__cuda_local_var_37313_6_non_const_x) + (((unsigned long)(__cuda_local_var_37314_6_non_const_y + 1)) * pitch)) + ((4UL * pitch) * 512UL)))]);
# 1254 "txInterpTest.cu"
__cuda_local_var_37318_11_non_const_f1 = ((((__T2443 = texRef_f1D) , ((void)(__T2444 = (((float)(__cuda_local_var_37313_6_non_const_x - 1)) + (0.5F))))) , ((void)(__T2445 = (((float)__cuda_local_var_37314_6_non_const_y) + (0.5F))))) , ((__T2447 = (__ftexfetch2D(__T2443, ((((((__T2446.x) = __T2444) , ((void)((__T2446.y) = __T2445))) , ((void)((__T2446.z) = (0.0F)))) , ((void)((__T2446.w) = (0.0F)))) , __T2446)))) , (__T2447.x)));
# 1255 "txInterpTest.cu"
__cuda_local_var_37318_17_non_const_f3 = ((((__T2448 = texRef_f3D) , ((void)(__T2449 = (((float)(__cuda_local_var_37313_6_non_const_x + 1)) + (0.5F))))) , ((void)(__T2450 = (((float)__cuda_local_var_37314_6_non_const_y) + (0.5F))))) , ((__T2452 = (__ftexfetch2D(__T2448, ((((((__T2451.x) = __T2449) , ((void)((__T2451.y) = __T2450))) , ((void)((__T2451.z) = (0.0F)))) , ((void)((__T2451.w) = (0.0F)))) , __T2451)))) , (__T2452.x)));
# 1256 "txInterpTest.cu"
__cuda_local_var_37318_23_non_const_f5 = ((((__T2453 = texRef_f5D) , ((void)(__T2454 = (((float)(__cuda_local_var_37313_6_non_const_x - 1)) + (0.5F))))) , ((void)(__T2455 = (((float)(__cuda_local_var_37314_6_non_const_y - 1)) + (0.5F))))) , ((__T2457 = (__ftexfetch2D(__T2453, ((((((__T2456.x) = __T2454) , ((void)((__T2456.y) = __T2455))) , ((void)((__T2456.z) = (0.0F)))) , ((void)((__T2456.w) = (0.0F)))) , __T2456)))) , (__T2457.x)));
# 1257 "txInterpTest.cu"
__cuda_local_var_37318_26_non_const_f6 = ((((__T2458 = texRef_f6D) , ((void)(__T2459 = (((float)(__cuda_local_var_37313_6_non_const_x + 1)) + (0.5F))))) , ((void)(__T2460 = (((float)(__cuda_local_var_37314_6_non_const_y - 1)) + (0.5F))))) , ((__T2462 = (__ftexfetch2D(__T2458, ((((((__T2461.x) = __T2459) , ((void)((__T2461.y) = __T2460))) , ((void)((__T2461.z) = (0.0F)))) , ((void)((__T2461.w) = (0.0F)))) , __T2461)))) , (__T2462.x)));
# 1258 "txInterpTest.cu"
__cuda_local_var_37318_29_non_const_f7 = ((((__T2463 = texRef_f7D) , ((void)(__T2464 = (((float)(__cuda_local_var_37313_6_non_const_x + 1)) + (0.5F))))) , ((void)(__T2465 = (((float)(__cuda_local_var_37314_6_non_const_y + 1)) + (0.5F))))) , ((__T2467 = (__ftexfetch2D(__T2463, ((((((__T2466.x) = __T2464) , ((void)((__T2466.y) = __T2465))) , ((void)((__T2466.z) = (0.0F)))) , ((void)((__T2466.w) = (0.0F)))) , __T2466)))) , (__T2467.x)));
# 1259 "txInterpTest.cu"
__cuda_local_var_37318_32_non_const_f8 = ((((__T2468 = texRef_f8D) , ((void)(__T2469 = (((float)(__cuda_local_var_37313_6_non_const_x - 1)) + (0.5F))))) , ((void)(__T2470 = (((float)(__cuda_local_var_37314_6_non_const_y + 1)) + (0.5F))))) , ((__T2472 = (__ftexfetch2D(__T2468, ((((((__T2471.x) = __T2469) , ((void)((__T2471.y) = __T2470))) , ((void)((__T2471.z) = (0.0F)))) , ((void)((__T2471.w) = (0.0F)))) , __T2471)))) , (__T2472.x)));
# 1260 "txInterpTest.cu"
if ((__cuda_local_var_37319_6_non_const_im == 1) || (__cuda_local_var_37319_6_non_const_im == 10))
# 1260 "txInterpTest.cu"
{
# 1261 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37313_6_non_const_x) + (((unsigned long)__cuda_local_var_37314_6_non_const_y) * pitch)) + ((1UL * pitch) * 512UL)))]) = __cuda_local_var_37318_17_non_const_f3;
# 1262 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37313_6_non_const_x) + (((unsigned long)__cuda_local_var_37314_6_non_const_y) * pitch)) + ((2UL * pitch) * 512UL)))]) = __cuda_local_var_37318_20_non_const_f4;
# 1263 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37313_6_non_const_x) + (((unsigned long)__cuda_local_var_37314_6_non_const_y) * pitch)) + ((3UL * pitch) * 512UL)))]) = __cuda_local_var_37318_11_non_const_f1;
# 1264 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37313_6_non_const_x) + (((unsigned long)__cuda_local_var_37314_6_non_const_y) * pitch)) + ((4UL * pitch) * 512UL)))]) = __cuda_local_var_37318_14_non_const_f2;
# 1265 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37313_6_non_const_x) + (((unsigned long)__cuda_local_var_37314_6_non_const_y) * pitch)) + ((5UL * pitch) * 512UL)))]) = __cuda_local_var_37318_29_non_const_f7;
# 1266 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37313_6_non_const_x) + (((unsigned long)__cuda_local_var_37314_6_non_const_y) * pitch)) + ((6UL * pitch) * 512UL)))]) = __cuda_local_var_37318_32_non_const_f8;
# 1267 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37313_6_non_const_x) + (((unsigned long)__cuda_local_var_37314_6_non_const_y) * pitch)) + ((7UL * pitch) * 512UL)))]) = __cuda_local_var_37318_23_non_const_f5;
# 1268 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37313_6_non_const_x) + (((unsigned long)__cuda_local_var_37314_6_non_const_y) * pitch)) + ((8UL * pitch) * 512UL)))]) = __cuda_local_var_37318_26_non_const_f6;
# 1269 "txInterpTest.cu"
}
# 1270 "txInterpTest.cu"
else
# 1270 "txInterpTest.cu"
{
# 1271 "txInterpTest.cu"
if (((const char *)"BGK") == ((const char *)"MRT"))
# 1271 "txInterpTest.cu"
{
# 1272 "txInterpTest.cu"
_Z11mrt_collideRfS_S_S_S_S_S_S_S_f((&__cuda_local_var_37318_8_non_const_f0), (&__cuda_local_var_37318_11_non_const_f1), (&__cuda_local_var_37318_14_non_const_f2), (&__cuda_local_var_37318_17_non_const_f3), (&__cuda_local_var_37318_20_non_const_f4), (&__cuda_local_var_37318_23_non_const_f5), (&__cuda_local_var_37318_26_non_const_f6), (&__cuda_local_var_37318_29_non_const_f7), (&__cuda_local_var_37318_32_non_const_f8), omega);
# 1272 "txInterpTest.cu"
}
# 1272 "txInterpTest.cu"
else
# 1272 "txInterpTest.cu"
{
# 1273 "txInterpTest.cu"
if (1)
# 1273 "txInterpTest.cu"
{
# 1274 "txInterpTest.cu"
{
# 1274 "txInterpTest.cu"
__T2439 = ((((((((__cuda_local_var_37318_8_non_const_f0 + __cuda_local_var_37318_11_non_const_f1) + __cuda_local_var_37318_14_non_const_f2) + __cuda_local_var_37318_17_non_const_f3) + __cuda_local_var_37318_20_non_const_f4) + __cuda_local_var_37318_23_non_const_f5) + __cuda_local_var_37318_26_non_const_f6) + __cuda_local_var_37318_29_non_const_f7) + __cuda_local_var_37318_32_non_const_f8);
# 1274 "txInterpTest.cu"
__T2440 = (((((__cuda_local_var_37318_11_non_const_f1 - __cuda_local_var_37318_17_non_const_f3) + __cuda_local_var_37318_23_non_const_f5) - __cuda_local_var_37318_26_non_const_f6) - __cuda_local_var_37318_29_non_const_f7) + __cuda_local_var_37318_32_non_const_f8);
# 1274 "txInterpTest.cu"
__T2441 = (((((__cuda_local_var_37318_14_non_const_f2 - __cuda_local_var_37318_20_non_const_f4) + __cuda_local_var_37318_23_non_const_f5) + __cuda_local_var_37318_26_non_const_f6) - __cuda_local_var_37318_29_non_const_f7) - __cuda_local_var_37318_32_non_const_f8);
# 1274 "txInterpTest.cu"
__T2442 = ((__T2440 * __T2440) + (__T2441 * __T2441));
# 1274 "txInterpTest.cu"
__cuda_local_var_37318_8_non_const_f0 = (__cuda_local_var_37318_8_non_const_f0 - (omega * (__cuda_local_var_37318_8_non_const_f0 - ((0.4444444478F) * (__T2439 - ((1.5F) * __T2442))))));
# 1274 "txInterpTest.cu"
__cuda_local_var_37318_11_non_const_f1 = (__cuda_local_var_37318_11_non_const_f1 - (omega * (__cuda_local_var_37318_11_non_const_f1 - ((0.1111111119F) * (((__T2439 + ((3.0F) * __T2440)) + (((4.5F) * __T2440) * __T2440)) - ((1.5F) * __T2442))))));
# 1274 "txInterpTest.cu"
__cuda_local_var_37318_14_non_const_f2 = (__cuda_local_var_37318_14_non_const_f2 - (omega * (__cuda_local_var_37318_14_non_const_f2 - ((0.1111111119F) * (((__T2439 + ((3.0F) * __T2441)) + (((4.5F) * __T2441) * __T2441)) - ((1.5F) * __T2442))))));
# 1274 "txInterpTest.cu"
__cuda_local_var_37318_17_non_const_f3 = (__cuda_local_var_37318_17_non_const_f3 - (omega * (__cuda_local_var_37318_17_non_const_f3 - ((0.1111111119F) * (((__T2439 - ((3.0F) * __T2440)) + (((4.5F) * __T2440) * __T2440)) - ((1.5F) * __T2442))))));
# 1274 "txInterpTest.cu"
__cuda_local_var_37318_20_non_const_f4 = (__cuda_local_var_37318_20_non_const_f4 - (omega * (__cuda_local_var_37318_20_non_const_f4 - ((0.1111111119F) * (((__T2439 - ((3.0F) * __T2441)) + (((4.5F) * __T2441) * __T2441)) - ((1.5F) * __T2442))))));
# 1274 "txInterpTest.cu"
__cuda_local_var_37318_23_non_const_f5 = ((float)(((double)__cuda_local_var_37318_23_non_const_f5) - (((double)omega) * (((double)__cuda_local_var_37318_23_non_const_f5) - ((0.02777777777999999864) * ((double)(((__T2439 + ((3.0F) * (__T2440 + __T2441))) + (((4.5F) * (__T2440 + __T2441)) * (__T2440 + __T2441))) - ((1.5F) * __T2442))))))));
# 1274 "txInterpTest.cu"
__cuda_local_var_37318_26_non_const_f6 = ((float)(((double)__cuda_local_var_37318_26_non_const_f6) - (((double)omega) * (((double)__cuda_local_var_37318_26_non_const_f6) - ((0.02777777777999999864) * ((double)(((__T2439 + ((3.0F) * ((-__T2440) + __T2441))) + (((4.5F) * ((-__T2440) + __T2441)) * ((-__T2440) + __T2441))) - ((1.5F) * __T2442))))))));
# 1274 "txInterpTest.cu"
__cuda_local_var_37318_29_non_const_f7 = ((float)(((double)__cuda_local_var_37318_29_non_const_f7) - (((double)omega) * (((double)__cuda_local_var_37318_29_non_const_f7) - ((0.02777777777999999864) * ((double)(((__T2439 + ((3.0F) * ((-__T2440) - __T2441))) + (((4.5F) * ((-__T2440) - __T2441)) * ((-__T2440) - __T2441))) - ((1.5F) * __T2442))))))));
# 1274 "txInterpTest.cu"
__cuda_local_var_37318_32_non_const_f8 = ((float)(((double)__cuda_local_var_37318_32_non_const_f8) - (((double)omega) * (((double)__cuda_local_var_37318_32_non_const_f8) - ((0.02777777777999999864) * ((double)(((__T2439 + ((3.0F) * (__T2440 - __T2441))) + (((4.5F) * (__T2440 - __T2441)) * (__T2440 - __T2441))) - ((1.5F) * __T2442))))))));
# 1274 "txInterpTest.cu"
}
# 1274 "txInterpTest.cu"
}
# 1274 "txInterpTest.cu"
}
# 1276 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37313_6_non_const_x) + (((unsigned long)__cuda_local_var_37314_6_non_const_y) * pitch)) + ((0UL * pitch) * 512UL)))]) = __cuda_local_var_37318_8_non_const_f0;
# 1277 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37313_6_non_const_x) + (((unsigned long)__cuda_local_var_37314_6_non_const_y) * pitch)) + ((1UL * pitch) * 512UL)))]) = __cuda_local_var_37318_11_non_const_f1;
# 1278 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37313_6_non_const_x) + (((unsigned long)__cuda_local_var_37314_6_non_const_y) * pitch)) + ((2UL * pitch) * 512UL)))]) = __cuda_local_var_37318_14_non_const_f2;
# 1279 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37313_6_non_const_x) + (((unsigned long)__cuda_local_var_37314_6_non_const_y) * pitch)) + ((3UL * pitch) * 512UL)))]) = __cuda_local_var_37318_17_non_const_f3;
# 1280 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37313_6_non_const_x) + (((unsigned long)__cuda_local_var_37314_6_non_const_y) * pitch)) + ((4UL * pitch) * 512UL)))]) = __cuda_local_var_37318_20_non_const_f4;
# 1281 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37313_6_non_const_x) + (((unsigned long)__cuda_local_var_37314_6_non_const_y) * pitch)) + ((5UL * pitch) * 512UL)))]) = __cuda_local_var_37318_23_non_const_f5;
# 1282 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37313_6_non_const_x) + (((unsigned long)__cuda_local_var_37314_6_non_const_y) * pitch)) + ((6UL * pitch) * 512UL)))]) = __cuda_local_var_37318_26_non_const_f6;
# 1283 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37313_6_non_const_x) + (((unsigned long)__cuda_local_var_37314_6_non_const_y) * pitch)) + ((7UL * pitch) * 512UL)))]) = __cuda_local_var_37318_29_non_const_f7;
# 1284 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37313_6_non_const_x) + (((unsigned long)__cuda_local_var_37314_6_non_const_y) * pitch)) + ((8UL * pitch) * 512UL)))]) = __cuda_local_var_37318_32_non_const_f8;
# 1285 "txInterpTest.cu"
}
# 1286 "txInterpTest.cu"
}
# 1287 "txInterpTest.cu"
}
# 1287 "txInterpTest.cu"
}}
# 1288 "txInterpTest.cu"
__attribute__((global)) __attribute__((__used__)) void _Z10LR_d_BADC2PfS_fmf(
# 1288 "txInterpTest.cu"
float *fin,
# 1288 "txInterpTest.cu"
float *fout,
# 1289 "txInterpTest.cu"
float omega,
# 1289 "txInterpTest.cu"
size_t pitch,
# 1289 "txInterpTest.cu"
float SF){
# 1289 "txInterpTest.cu"
{
# 1290 "txInterpTest.cu"
{
# 1291 "txInterpTest.cu"
 int __cuda_local_var_37366_6_non_const_x;
# 1292 "txInterpTest.cu"
 int __cuda_local_var_37367_6_non_const_y;
# 1293 "txInterpTest.cu"
 float __cuda_local_var_37368_8_non_const_xcoord;
# 1294 "txInterpTest.cu"
 float __cuda_local_var_37369_8_non_const_ycoord;
# 1295 "txInterpTest.cu"
 int __cuda_local_var_37370_6_non_const_j;
# 1296 "txInterpTest.cu"
 float __cuda_local_var_37371_8_non_const_f0;
# 1296 "txInterpTest.cu"
 float __cuda_local_var_37371_11_non_const_f1;
# 1296 "txInterpTest.cu"
 float __cuda_local_var_37371_14_non_const_f2;
# 1296 "txInterpTest.cu"
 float __cuda_local_var_37371_17_non_const_f3;
# 1296 "txInterpTest.cu"
 float __cuda_local_var_37371_20_non_const_f4;
# 1296 "txInterpTest.cu"
 float __cuda_local_var_37371_23_non_const_f5;
# 1296 "txInterpTest.cu"
 float __cuda_local_var_37371_26_non_const_f6;
# 1296 "txInterpTest.cu"
 float __cuda_local_var_37371_29_non_const_f7;
# 1296 "txInterpTest.cu"
 float __cuda_local_var_37371_32_non_const_f8;
# 1297 "txInterpTest.cu"
 int __cuda_local_var_37372_6_non_const_im;
# 1291 "txInterpTest.cu"
__cuda_local_var_37366_6_non_const_x = ((int)((threadIdx.x) + ((blockIdx.x) * (blockDim.x))));
# 1292 "txInterpTest.cu"
__cuda_local_var_37367_6_non_const_y = ((int)((threadIdx.y) + ((blockIdx.y) * (blockDim.y))));
# 1293 "txInterpTest.cu"
__cuda_local_var_37368_8_non_const_xcoord = ((float)((415.625) + ((double)(((float)__cuda_local_var_37366_6_non_const_x) * (0.25F)))));
# 1294 "txInterpTest.cu"
__cuda_local_var_37369_8_non_const_ycoord = ((float)((319.625) + ((double)(((float)__cuda_local_var_37367_6_non_const_y) * (0.25F)))));
# 1295 "txInterpTest.cu"
__cuda_local_var_37370_6_non_const_j = ((int)(((unsigned long)__cuda_local_var_37366_6_non_const_x) + (((unsigned long)__cuda_local_var_37367_6_non_const_y) * pitch)));
# 1297 "txInterpTest.cu"
__cuda_local_var_37372_6_non_const_im = (_Z8ImageFcnff(__cuda_local_var_37368_8_non_const_xcoord, __cuda_local_var_37369_8_non_const_ycoord));
# 1304 "txInterpTest.cu"
__cuda_local_var_37371_8_non_const_f0 = (fin[__cuda_local_var_37370_6_non_const_j]);
# 1305 "txInterpTest.cu"
__cuda_local_var_37371_11_non_const_f1 = (fin[((int)((((unsigned long)(__cuda_local_var_37366_6_non_const_x - 1)) + (((unsigned long)__cuda_local_var_37367_6_non_const_y) * pitch)) + ((1UL * pitch) * 512UL)))]);
# 1306 "txInterpTest.cu"
__cuda_local_var_37371_14_non_const_f2 = (fin[((int)((((unsigned long)__cuda_local_var_37366_6_non_const_x) + (((unsigned long)(__cuda_local_var_37367_6_non_const_y - 1)) * pitch)) + ((2UL * pitch) * 512UL)))]);
# 1307 "txInterpTest.cu"
__cuda_local_var_37371_17_non_const_f3 = (fin[((int)((((unsigned long)(__cuda_local_var_37366_6_non_const_x + 1)) + (((unsigned long)__cuda_local_var_37367_6_non_const_y) * pitch)) + ((3UL * pitch) * 512UL)))]);
# 1308 "txInterpTest.cu"
__cuda_local_var_37371_20_non_const_f4 = (fin[((int)((((unsigned long)__cuda_local_var_37366_6_non_const_x) + (((unsigned long)(__cuda_local_var_37367_6_non_const_y + 1)) * pitch)) + ((4UL * pitch) * 512UL)))]);
# 1309 "txInterpTest.cu"
__cuda_local_var_37371_23_non_const_f5 = (fin[((int)((((unsigned long)(__cuda_local_var_37366_6_non_const_x - 1)) + (((unsigned long)(__cuda_local_var_37367_6_non_const_y - 1)) * pitch)) + ((5UL * pitch) * 512UL)))]);
# 1310 "txInterpTest.cu"
__cuda_local_var_37371_26_non_const_f6 = (fin[((int)((((unsigned long)(__cuda_local_var_37366_6_non_const_x + 1)) + (((unsigned long)(__cuda_local_var_37367_6_non_const_y - 1)) * pitch)) + ((6UL * pitch) * 512UL)))]);
# 1311 "txInterpTest.cu"
__cuda_local_var_37371_29_non_const_f7 = (fin[((int)((((unsigned long)(__cuda_local_var_37366_6_non_const_x + 1)) + (((unsigned long)(__cuda_local_var_37367_6_non_const_y + 1)) * pitch)) + ((7UL * pitch) * 512UL)))]);
# 1312 "txInterpTest.cu"
__cuda_local_var_37371_32_non_const_f8 = (fin[((int)((((unsigned long)(__cuda_local_var_37366_6_non_const_x - 1)) + (((unsigned long)(__cuda_local_var_37367_6_non_const_y + 1)) * pitch)) + ((8UL * pitch) * 512UL)))]);
# 1313 "txInterpTest.cu"
if ((__cuda_local_var_37372_6_non_const_im == 1) || (__cuda_local_var_37372_6_non_const_im == 10))
# 1313 "txInterpTest.cu"
{
# 1314 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37366_6_non_const_x) + (((unsigned long)__cuda_local_var_37367_6_non_const_y) * pitch)) + ((1UL * pitch) * 512UL)))]) = __cuda_local_var_37371_17_non_const_f3;
# 1315 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37366_6_non_const_x) + (((unsigned long)__cuda_local_var_37367_6_non_const_y) * pitch)) + ((2UL * pitch) * 512UL)))]) = __cuda_local_var_37371_20_non_const_f4;
# 1316 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37366_6_non_const_x) + (((unsigned long)__cuda_local_var_37367_6_non_const_y) * pitch)) + ((3UL * pitch) * 512UL)))]) = __cuda_local_var_37371_11_non_const_f1;
# 1317 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37366_6_non_const_x) + (((unsigned long)__cuda_local_var_37367_6_non_const_y) * pitch)) + ((4UL * pitch) * 512UL)))]) = __cuda_local_var_37371_14_non_const_f2;
# 1318 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37366_6_non_const_x) + (((unsigned long)__cuda_local_var_37367_6_non_const_y) * pitch)) + ((5UL * pitch) * 512UL)))]) = __cuda_local_var_37371_29_non_const_f7;
# 1319 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37366_6_non_const_x) + (((unsigned long)__cuda_local_var_37367_6_non_const_y) * pitch)) + ((6UL * pitch) * 512UL)))]) = __cuda_local_var_37371_32_non_const_f8;
# 1320 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37366_6_non_const_x) + (((unsigned long)__cuda_local_var_37367_6_non_const_y) * pitch)) + ((7UL * pitch) * 512UL)))]) = __cuda_local_var_37371_23_non_const_f5;
# 1321 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37366_6_non_const_x) + (((unsigned long)__cuda_local_var_37367_6_non_const_y) * pitch)) + ((8UL * pitch) * 512UL)))]) = __cuda_local_var_37371_26_non_const_f6;
# 1322 "txInterpTest.cu"
}
# 1323 "txInterpTest.cu"
else
# 1323 "txInterpTest.cu"
{
# 1324 "txInterpTest.cu"
if (((const char *)"BGK") == ((const char *)"MRT"))
# 1324 "txInterpTest.cu"
{
# 1325 "txInterpTest.cu"
_Z11mrt_collideRfS_S_S_S_S_S_S_S_f((&__cuda_local_var_37371_8_non_const_f0), (&__cuda_local_var_37371_11_non_const_f1), (&__cuda_local_var_37371_14_non_const_f2), (&__cuda_local_var_37371_17_non_const_f3), (&__cuda_local_var_37371_20_non_const_f4), (&__cuda_local_var_37371_23_non_const_f5), (&__cuda_local_var_37371_26_non_const_f6), (&__cuda_local_var_37371_29_non_const_f7), (&__cuda_local_var_37371_32_non_const_f8), omega);
# 1325 "txInterpTest.cu"
}
# 1325 "txInterpTest.cu"
else
# 1325 "txInterpTest.cu"
{
# 1326 "txInterpTest.cu"
if (1)
# 1326 "txInterpTest.cu"
{
# 1326 "txInterpTest.cu"
 float __T2473;
# 1327 "txInterpTest.cu"
 float __T2474;
# 1328 "txInterpTest.cu"
 float __T2475;
# 1329 "txInterpTest.cu"
 float __T2476;
# 1327 "txInterpTest.cu"
{
# 1327 "txInterpTest.cu"
__T2473 = ((((((((__cuda_local_var_37371_8_non_const_f0 + __cuda_local_var_37371_11_non_const_f1) + __cuda_local_var_37371_14_non_const_f2) + __cuda_local_var_37371_17_non_const_f3) + __cuda_local_var_37371_20_non_const_f4) + __cuda_local_var_37371_23_non_const_f5) + __cuda_local_var_37371_26_non_const_f6) + __cuda_local_var_37371_29_non_const_f7) + __cuda_local_var_37371_32_non_const_f8);
# 1327 "txInterpTest.cu"
__T2474 = (((((__cuda_local_var_37371_11_non_const_f1 - __cuda_local_var_37371_17_non_const_f3) + __cuda_local_var_37371_23_non_const_f5) - __cuda_local_var_37371_26_non_const_f6) - __cuda_local_var_37371_29_non_const_f7) + __cuda_local_var_37371_32_non_const_f8);
# 1327 "txInterpTest.cu"
__T2475 = (((((__cuda_local_var_37371_14_non_const_f2 - __cuda_local_var_37371_20_non_const_f4) + __cuda_local_var_37371_23_non_const_f5) + __cuda_local_var_37371_26_non_const_f6) - __cuda_local_var_37371_29_non_const_f7) - __cuda_local_var_37371_32_non_const_f8);
# 1327 "txInterpTest.cu"
__T2476 = ((__T2474 * __T2474) + (__T2475 * __T2475));
# 1327 "txInterpTest.cu"
__cuda_local_var_37371_8_non_const_f0 = (__cuda_local_var_37371_8_non_const_f0 - (omega * (__cuda_local_var_37371_8_non_const_f0 - ((0.4444444478F) * (__T2473 - ((1.5F) * __T2476))))));
# 1327 "txInterpTest.cu"
__cuda_local_var_37371_11_non_const_f1 = (__cuda_local_var_37371_11_non_const_f1 - (omega * (__cuda_local_var_37371_11_non_const_f1 - ((0.1111111119F) * (((__T2473 + ((3.0F) * __T2474)) + (((4.5F) * __T2474) * __T2474)) - ((1.5F) * __T2476))))));
# 1327 "txInterpTest.cu"
__cuda_local_var_37371_14_non_const_f2 = (__cuda_local_var_37371_14_non_const_f2 - (omega * (__cuda_local_var_37371_14_non_const_f2 - ((0.1111111119F) * (((__T2473 + ((3.0F) * __T2475)) + (((4.5F) * __T2475) * __T2475)) - ((1.5F) * __T2476))))));
# 1327 "txInterpTest.cu"
__cuda_local_var_37371_17_non_const_f3 = (__cuda_local_var_37371_17_non_const_f3 - (omega * (__cuda_local_var_37371_17_non_const_f3 - ((0.1111111119F) * (((__T2473 - ((3.0F) * __T2474)) + (((4.5F) * __T2474) * __T2474)) - ((1.5F) * __T2476))))));
# 1327 "txInterpTest.cu"
__cuda_local_var_37371_20_non_const_f4 = (__cuda_local_var_37371_20_non_const_f4 - (omega * (__cuda_local_var_37371_20_non_const_f4 - ((0.1111111119F) * (((__T2473 - ((3.0F) * __T2475)) + (((4.5F) * __T2475) * __T2475)) - ((1.5F) * __T2476))))));
# 1327 "txInterpTest.cu"
__cuda_local_var_37371_23_non_const_f5 = ((float)(((double)__cuda_local_var_37371_23_non_const_f5) - (((double)omega) * (((double)__cuda_local_var_37371_23_non_const_f5) - ((0.02777777777999999864) * ((double)(((__T2473 + ((3.0F) * (__T2474 + __T2475))) + (((4.5F) * (__T2474 + __T2475)) * (__T2474 + __T2475))) - ((1.5F) * __T2476))))))));
# 1327 "txInterpTest.cu"
__cuda_local_var_37371_26_non_const_f6 = ((float)(((double)__cuda_local_var_37371_26_non_const_f6) - (((double)omega) * (((double)__cuda_local_var_37371_26_non_const_f6) - ((0.02777777777999999864) * ((double)(((__T2473 + ((3.0F) * ((-__T2474) + __T2475))) + (((4.5F) * ((-__T2474) + __T2475)) * ((-__T2474) + __T2475))) - ((1.5F) * __T2476))))))));
# 1327 "txInterpTest.cu"
__cuda_local_var_37371_29_non_const_f7 = ((float)(((double)__cuda_local_var_37371_29_non_const_f7) - (((double)omega) * (((double)__cuda_local_var_37371_29_non_const_f7) - ((0.02777777777999999864) * ((double)(((__T2473 + ((3.0F) * ((-__T2474) - __T2475))) + (((4.5F) * ((-__T2474) - __T2475)) * ((-__T2474) - __T2475))) - ((1.5F) * __T2476))))))));
# 1327 "txInterpTest.cu"
__cuda_local_var_37371_32_non_const_f8 = ((float)(((double)__cuda_local_var_37371_32_non_const_f8) - (((double)omega) * (((double)__cuda_local_var_37371_32_non_const_f8) - ((0.02777777777999999864) * ((double)(((__T2473 + ((3.0F) * (__T2474 - __T2475))) + (((4.5F) * (__T2474 - __T2475)) * (__T2474 - __T2475))) - ((1.5F) * __T2476))))))));
# 1327 "txInterpTest.cu"
}
# 1327 "txInterpTest.cu"
}
# 1327 "txInterpTest.cu"
}
# 1329 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37366_6_non_const_x) + (((unsigned long)__cuda_local_var_37367_6_non_const_y) * pitch)) + ((0UL * pitch) * 512UL)))]) = __cuda_local_var_37371_8_non_const_f0;
# 1330 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37366_6_non_const_x) + (((unsigned long)__cuda_local_var_37367_6_non_const_y) * pitch)) + ((1UL * pitch) * 512UL)))]) = __cuda_local_var_37371_11_non_const_f1;
# 1331 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37366_6_non_const_x) + (((unsigned long)__cuda_local_var_37367_6_non_const_y) * pitch)) + ((2UL * pitch) * 512UL)))]) = __cuda_local_var_37371_14_non_const_f2;
# 1332 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37366_6_non_const_x) + (((unsigned long)__cuda_local_var_37367_6_non_const_y) * pitch)) + ((3UL * pitch) * 512UL)))]) = __cuda_local_var_37371_17_non_const_f3;
# 1333 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37366_6_non_const_x) + (((unsigned long)__cuda_local_var_37367_6_non_const_y) * pitch)) + ((4UL * pitch) * 512UL)))]) = __cuda_local_var_37371_20_non_const_f4;
# 1334 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37366_6_non_const_x) + (((unsigned long)__cuda_local_var_37367_6_non_const_y) * pitch)) + ((5UL * pitch) * 512UL)))]) = __cuda_local_var_37371_23_non_const_f5;
# 1335 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37366_6_non_const_x) + (((unsigned long)__cuda_local_var_37367_6_non_const_y) * pitch)) + ((6UL * pitch) * 512UL)))]) = __cuda_local_var_37371_26_non_const_f6;
# 1336 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37366_6_non_const_x) + (((unsigned long)__cuda_local_var_37367_6_non_const_y) * pitch)) + ((7UL * pitch) * 512UL)))]) = __cuda_local_var_37371_29_non_const_f7;
# 1337 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37366_6_non_const_x) + (((unsigned long)__cuda_local_var_37367_6_non_const_y) * pitch)) + ((8UL * pitch) * 512UL)))]) = __cuda_local_var_37371_32_non_const_f8;
# 1338 "txInterpTest.cu"
}
# 1340 "txInterpTest.cu"
}
# 1340 "txInterpTest.cu"
}}
# 1342 "txInterpTest.cu"
__attribute__((global)) __attribute__((__used__)) void _Z19LR_d_hybBADC_InterpPfS_fmf(
# 1342 "txInterpTest.cu"
float *fin,
# 1342 "txInterpTest.cu"
float *fout,
# 1343 "txInterpTest.cu"
float omega,
# 1343 "txInterpTest.cu"
size_t pitch,
# 1343 "txInterpTest.cu"
float SF){
# 1343 "txInterpTest.cu"
{
# 1344 "txInterpTest.cu"
{
# 1344 "txInterpTest.cu"
 __texture_type__ __T2477;
# 1345 "txInterpTest.cu"
 float __T2478;
# 1346 "txInterpTest.cu"
 float __T2479;
# 1347 "txInterpTest.cu"
 float4 __T2480;
# 1348 "txInterpTest.cu"
 float4 __T2481;
# 1349 "txInterpTest.cu"
 __texture_type__ __T2482;
# 1350 "txInterpTest.cu"
 float __T2483;
# 1351 "txInterpTest.cu"
 float __T2484;
# 1352 "txInterpTest.cu"
 float4 __T2485;
# 1353 "txInterpTest.cu"
 float4 __T2486;
# 1354 "txInterpTest.cu"
 __texture_type__ __T2487;
# 1355 "txInterpTest.cu"
 float __T2488;
# 1356 "txInterpTest.cu"
 float __T2489;
# 1357 "txInterpTest.cu"
 float4 __T2490;
# 1358 "txInterpTest.cu"
 float4 __T2491;
# 1359 "txInterpTest.cu"
 __texture_type__ __T2492;
# 1360 "txInterpTest.cu"
 float __T2493;
# 1361 "txInterpTest.cu"
 float __T2494;
# 1362 "txInterpTest.cu"
 float4 __T2495;
# 1363 "txInterpTest.cu"
 float4 __T2496;
# 1364 "txInterpTest.cu"
 __texture_type__ __T2497;
# 1365 "txInterpTest.cu"
 float __T2498;
# 1366 "txInterpTest.cu"
 float __T2499;
# 1367 "txInterpTest.cu"
 float4 __T2500;
# 1368 "txInterpTest.cu"
 float4 __T2501;
# 1369 "txInterpTest.cu"
 __texture_type__ __T2502;
# 1370 "txInterpTest.cu"
 float __T2503;
# 1371 "txInterpTest.cu"
 float __T2504;
# 1372 "txInterpTest.cu"
 float4 __T2505;
# 1373 "txInterpTest.cu"
 float4 __T2506;
# 1374 "txInterpTest.cu"
 float __T2507;
# 1375 "txInterpTest.cu"
 float __T2508;
# 1376 "txInterpTest.cu"
 float __T2509;
# 1377 "txInterpTest.cu"
 float __T2510;
# 1345 "txInterpTest.cu"
 int __cuda_local_var_37420_6_non_const_x;
# 1346 "txInterpTest.cu"
 int __cuda_local_var_37421_6_non_const_y;
# 1347 "txInterpTest.cu"
 float __cuda_local_var_37422_8_non_const_xcoord;
# 1348 "txInterpTest.cu"
 float __cuda_local_var_37423_8_non_const_ycoord;
# 1349 "txInterpTest.cu"
 int __cuda_local_var_37424_6_non_const_j;
# 1350 "txInterpTest.cu"
 float __cuda_local_var_37425_8_non_const_f0;
# 1350 "txInterpTest.cu"
 float __cuda_local_var_37425_11_non_const_f1;
# 1350 "txInterpTest.cu"
 float __cuda_local_var_37425_14_non_const_f2;
# 1350 "txInterpTest.cu"
 float __cuda_local_var_37425_17_non_const_f3;
# 1350 "txInterpTest.cu"
 float __cuda_local_var_37425_20_non_const_f4;
# 1350 "txInterpTest.cu"
 float __cuda_local_var_37425_23_non_const_f5;
# 1350 "txInterpTest.cu"
 float __cuda_local_var_37425_26_non_const_f6;
# 1350 "txInterpTest.cu"
 float __cuda_local_var_37425_29_non_const_f7;
# 1350 "txInterpTest.cu"
 float __cuda_local_var_37425_32_non_const_f8;
# 1351 "txInterpTest.cu"
 int __cuda_local_var_37426_6_non_const_im;
# 1345 "txInterpTest.cu"
__cuda_local_var_37420_6_non_const_x = ((int)((threadIdx.x) + ((blockIdx.x) * (blockDim.x))));
# 1346 "txInterpTest.cu"
__cuda_local_var_37421_6_non_const_y = ((int)((threadIdx.y) + ((blockIdx.y) * (blockDim.y))));
# 1347 "txInterpTest.cu"
__cuda_local_var_37422_8_non_const_xcoord = ((float)((415.625) + ((double)(((float)__cuda_local_var_37420_6_non_const_x) * (0.25F)))));
# 1348 "txInterpTest.cu"
__cuda_local_var_37423_8_non_const_ycoord = ((float)((319.625) + ((double)(((float)__cuda_local_var_37421_6_non_const_y) * (0.25F)))));
# 1349 "txInterpTest.cu"
__cuda_local_var_37424_6_non_const_j = ((int)(((unsigned long)__cuda_local_var_37420_6_non_const_x) + (((unsigned long)__cuda_local_var_37421_6_non_const_y) * pitch)));
# 1351 "txInterpTest.cu"
__cuda_local_var_37426_6_non_const_im = (_Z8ImageFcnff(__cuda_local_var_37422_8_non_const_xcoord, __cuda_local_var_37423_8_non_const_ycoord));
# 1353 "txInterpTest.cu"
if ((((__cuda_local_var_37420_6_non_const_x < 4) || (__cuda_local_var_37420_6_non_const_x > 763)) || (__cuda_local_var_37421_6_non_const_y < 4)) || (__cuda_local_var_37421_6_non_const_y > 507))
# 1355 "txInterpTest.cu"
{
# 1355 "txInterpTest.cu"
 __texture_type__ __T2511;
# 1356 "txInterpTest.cu"
 float __T2512;
# 1357 "txInterpTest.cu"
 float __T2513;
# 1358 "txInterpTest.cu"
 float4 __T2514;
# 1359 "txInterpTest.cu"
 float4 __T2515;
# 1360 "txInterpTest.cu"
 __texture_type__ __T2516;
# 1361 "txInterpTest.cu"
 float __T2517;
# 1362 "txInterpTest.cu"
 float __T2518;
# 1363 "txInterpTest.cu"
 float4 __T2519;
# 1364 "txInterpTest.cu"
 float4 __T2520;
# 1365 "txInterpTest.cu"
 __texture_type__ __T2521;
# 1366 "txInterpTest.cu"
 float __T2522;
# 1367 "txInterpTest.cu"
 float __T2523;
# 1368 "txInterpTest.cu"
 float4 __T2524;
# 1369 "txInterpTest.cu"
 float4 __T2525;
# 1370 "txInterpTest.cu"
 __texture_type__ __T2526;
# 1371 "txInterpTest.cu"
 float __T2527;
# 1372 "txInterpTest.cu"
 float __T2528;
# 1373 "txInterpTest.cu"
 float4 __T2529;
# 1374 "txInterpTest.cu"
 float4 __T2530;
# 1375 "txInterpTest.cu"
 __texture_type__ __T2531;
# 1376 "txInterpTest.cu"
 float __T2532;
# 1377 "txInterpTest.cu"
 float __T2533;
# 1378 "txInterpTest.cu"
 float4 __T2534;
# 1379 "txInterpTest.cu"
 float4 __T2535;
# 1380 "txInterpTest.cu"
 __texture_type__ __T2536;
# 1381 "txInterpTest.cu"
 float __T2537;
# 1382 "txInterpTest.cu"
 float __T2538;
# 1383 "txInterpTest.cu"
 float4 __T2539;
# 1384 "txInterpTest.cu"
 float4 __T2540;
# 1385 "txInterpTest.cu"
 __texture_type__ __T2541;
# 1386 "txInterpTest.cu"
 float __T2542;
# 1387 "txInterpTest.cu"
 float __T2543;
# 1388 "txInterpTest.cu"
 float4 __T2544;
# 1389 "txInterpTest.cu"
 float4 __T2545;
# 1390 "txInterpTest.cu"
 __texture_type__ __T2546;
# 1391 "txInterpTest.cu"
 float __T2547;
# 1392 "txInterpTest.cu"
 float __T2548;
# 1393 "txInterpTest.cu"
 float4 __T2549;
# 1394 "txInterpTest.cu"
 float4 __T2550;
# 1395 "txInterpTest.cu"
 __texture_type__ __T2551;
# 1396 "txInterpTest.cu"
 float __T2552;
# 1397 "txInterpTest.cu"
 float __T2553;
# 1398 "txInterpTest.cu"
 float4 __T2554;
# 1399 "txInterpTest.cu"
 float4 __T2555;
# 1367 "txInterpTest.cu"
 float __cuda_local_var_37442_8_non_const_rho;
# 1367 "txInterpTest.cu"
 float __cuda_local_var_37442_12_non_const_u;
# 1367 "txInterpTest.cu"
 float __cuda_local_var_37442_14_non_const_v;
# 1371 "txInterpTest.cu"
 float __cuda_local_var_37446_8_non_const_usqr;
# 1357 "txInterpTest.cu"
__cuda_local_var_37425_8_non_const_f0 = ((((__T2511 = texRef_f0A) , ((void)(__T2512 = (__cuda_local_var_37422_8_non_const_xcoord + (0.5F))))) , ((void)(__T2513 = (__cuda_local_var_37423_8_non_const_ycoord + (0.5F))))) , ((__T2515 = (__ftexfetch2D(__T2511, ((((((__T2514.x) = __T2512) , ((void)((__T2514.y) = __T2513))) , ((void)((__T2514.z) = (0.0F)))) , ((void)((__T2514.w) = (0.0F)))) , __T2514)))) , (__T2515.x)));
# 1358 "txInterpTest.cu"
__cuda_local_var_37425_11_non_const_f1 = ((((__T2516 = texRef_f1A) , ((void)(__T2517 = (__cuda_local_var_37422_8_non_const_xcoord + (0.5F))))) , ((void)(__T2518 = (__cuda_local_var_37423_8_non_const_ycoord + (0.5F))))) , ((__T2520 = (__ftexfetch2D(__T2516, ((((((__T2519.x) = __T2517) , ((void)((__T2519.y) = __T2518))) , ((void)((__T2519.z) = (0.0F)))) , ((void)((__T2519.w) = (0.0F)))) , __T2519)))) , (__T2520.x)));
# 1359 "txInterpTest.cu"
__cuda_local_var_37425_14_non_const_f2 = ((((__T2521 = texRef_f2A) , ((void)(__T2522 = (__cuda_local_var_37422_8_non_const_xcoord + (0.5F))))) , ((void)(__T2523 = (__cuda_local_var_37423_8_non_const_ycoord + (0.5F))))) , ((__T2525 = (__ftexfetch2D(__T2521, ((((((__T2524.x) = __T2522) , ((void)((__T2524.y) = __T2523))) , ((void)((__T2524.z) = (0.0F)))) , ((void)((__T2524.w) = (0.0F)))) , __T2524)))) , (__T2525.x)));
# 1360 "txInterpTest.cu"
__cuda_local_var_37425_17_non_const_f3 = ((((__T2526 = texRef_f3A) , ((void)(__T2527 = (__cuda_local_var_37422_8_non_const_xcoord + (0.5F))))) , ((void)(__T2528 = (__cuda_local_var_37423_8_non_const_ycoord + (0.5F))))) , ((__T2530 = (__ftexfetch2D(__T2526, ((((((__T2529.x) = __T2527) , ((void)((__T2529.y) = __T2528))) , ((void)((__T2529.z) = (0.0F)))) , ((void)((__T2529.w) = (0.0F)))) , __T2529)))) , (__T2530.x)));
# 1361 "txInterpTest.cu"
__cuda_local_var_37425_20_non_const_f4 = ((((__T2531 = texRef_f4A) , ((void)(__T2532 = (__cuda_local_var_37422_8_non_const_xcoord + (0.5F))))) , ((void)(__T2533 = (__cuda_local_var_37423_8_non_const_ycoord + (0.5F))))) , ((__T2535 = (__ftexfetch2D(__T2531, ((((((__T2534.x) = __T2532) , ((void)((__T2534.y) = __T2533))) , ((void)((__T2534.z) = (0.0F)))) , ((void)((__T2534.w) = (0.0F)))) , __T2534)))) , (__T2535.x)));
# 1362 "txInterpTest.cu"
__cuda_local_var_37425_23_non_const_f5 = ((((__T2536 = texRef_f5A) , ((void)(__T2537 = (__cuda_local_var_37422_8_non_const_xcoord + (0.5F))))) , ((void)(__T2538 = (__cuda_local_var_37423_8_non_const_ycoord + (0.5F))))) , ((__T2540 = (__ftexfetch2D(__T2536, ((((((__T2539.x) = __T2537) , ((void)((__T2539.y) = __T2538))) , ((void)((__T2539.z) = (0.0F)))) , ((void)((__T2539.w) = (0.0F)))) , __T2539)))) , (__T2540.x)));
# 1363 "txInterpTest.cu"
__cuda_local_var_37425_26_non_const_f6 = ((((__T2541 = texRef_f6A) , ((void)(__T2542 = (__cuda_local_var_37422_8_non_const_xcoord + (0.5F))))) , ((void)(__T2543 = (__cuda_local_var_37423_8_non_const_ycoord + (0.5F))))) , ((__T2545 = (__ftexfetch2D(__T2541, ((((((__T2544.x) = __T2542) , ((void)((__T2544.y) = __T2543))) , ((void)((__T2544.z) = (0.0F)))) , ((void)((__T2544.w) = (0.0F)))) , __T2544)))) , (__T2545.x)));
# 1364 "txInterpTest.cu"
__cuda_local_var_37425_29_non_const_f7 = ((((__T2546 = texRef_f7A) , ((void)(__T2547 = (__cuda_local_var_37422_8_non_const_xcoord + (0.5F))))) , ((void)(__T2548 = (__cuda_local_var_37423_8_non_const_ycoord + (0.5F))))) , ((__T2550 = (__ftexfetch2D(__T2546, ((((((__T2549.x) = __T2547) , ((void)((__T2549.y) = __T2548))) , ((void)((__T2549.z) = (0.0F)))) , ((void)((__T2549.w) = (0.0F)))) , __T2549)))) , (__T2550.x)));
# 1365 "txInterpTest.cu"
__cuda_local_var_37425_32_non_const_f8 = ((((__T2551 = texRef_f8A) , ((void)(__T2552 = (__cuda_local_var_37422_8_non_const_xcoord + (0.5F))))) , ((void)(__T2553 = (__cuda_local_var_37423_8_non_const_ycoord + (0.5F))))) , ((__T2555 = (__ftexfetch2D(__T2551, ((((((__T2554.x) = __T2552) , ((void)((__T2554.y) = __T2553))) , ((void)((__T2554.z) = (0.0F)))) , ((void)((__T2554.w) = (0.0F)))) , __T2554)))) , (__T2555.x)));
# 1368 "txInterpTest.cu"
__cuda_local_var_37442_8_non_const_rho = ((((((((__cuda_local_var_37425_8_non_const_f0 + __cuda_local_var_37425_11_non_const_f1) + __cuda_local_var_37425_14_non_const_f2) + __cuda_local_var_37425_17_non_const_f3) + __cuda_local_var_37425_20_non_const_f4) + __cuda_local_var_37425_23_non_const_f5) + __cuda_local_var_37425_26_non_const_f6) + __cuda_local_var_37425_29_non_const_f7) + __cuda_local_var_37425_32_non_const_f8);
# 1369 "txInterpTest.cu"
__cuda_local_var_37442_12_non_const_u = (((((__cuda_local_var_37425_11_non_const_f1 - __cuda_local_var_37425_17_non_const_f3) + __cuda_local_var_37425_23_non_const_f5) - __cuda_local_var_37425_26_non_const_f6) - __cuda_local_var_37425_29_non_const_f7) + __cuda_local_var_37425_32_non_const_f8);
# 1370 "txInterpTest.cu"
__cuda_local_var_37442_14_non_const_v = (((((__cuda_local_var_37425_14_non_const_f2 - __cuda_local_var_37425_20_non_const_f4) + __cuda_local_var_37425_23_non_const_f5) + __cuda_local_var_37425_26_non_const_f6) - __cuda_local_var_37425_29_non_const_f7) - __cuda_local_var_37425_32_non_const_f8);
# 1371 "txInterpTest.cu"
__cuda_local_var_37446_8_non_const_usqr = ((__cuda_local_var_37442_12_non_const_u * __cuda_local_var_37442_12_non_const_u) + (__cuda_local_var_37442_14_non_const_v * __cuda_local_var_37442_14_non_const_v));
# 1373 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37420_6_non_const_x) + (((unsigned long)__cuda_local_var_37421_6_non_const_y) * pitch)) + ((0UL * pitch) * 512UL)))]) = ((SF * __cuda_local_var_37425_8_non_const_f0) + (((1.0F) - SF) * ((0.4444444478F) * (__cuda_local_var_37442_8_non_const_rho - ((1.5F) * __cuda_local_var_37446_8_non_const_usqr)))));
# 1374 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37420_6_non_const_x) + (((unsigned long)__cuda_local_var_37421_6_non_const_y) * pitch)) + ((1UL * pitch) * 512UL)))]) = ((SF * __cuda_local_var_37425_11_non_const_f1) + (((1.0F) - SF) * ((0.1111111119F) * (((__cuda_local_var_37442_8_non_const_rho + ((3.0F) * __cuda_local_var_37442_12_non_const_u)) + (((4.5F) * __cuda_local_var_37442_12_non_const_u) * __cuda_local_var_37442_12_non_const_u)) - ((1.5F) * __cuda_local_var_37446_8_non_const_usqr)))));
# 1375 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37420_6_non_const_x) + (((unsigned long)__cuda_local_var_37421_6_non_const_y) * pitch)) + ((2UL * pitch) * 512UL)))]) = ((SF * __cuda_local_var_37425_14_non_const_f2) + (((1.0F) - SF) * ((0.1111111119F) * (((__cuda_local_var_37442_8_non_const_rho + ((3.0F) * __cuda_local_var_37442_14_non_const_v)) + (((4.5F) * __cuda_local_var_37442_14_non_const_v) * __cuda_local_var_37442_14_non_const_v)) - ((1.5F) * __cuda_local_var_37446_8_non_const_usqr)))));
# 1376 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37420_6_non_const_x) + (((unsigned long)__cuda_local_var_37421_6_non_const_y) * pitch)) + ((3UL * pitch) * 512UL)))]) = ((SF * __cuda_local_var_37425_17_non_const_f3) + (((1.0F) - SF) * ((0.1111111119F) * (((__cuda_local_var_37442_8_non_const_rho - ((3.0F) * __cuda_local_var_37442_12_non_const_u)) + (((4.5F) * __cuda_local_var_37442_12_non_const_u) * __cuda_local_var_37442_12_non_const_u)) - ((1.5F) * __cuda_local_var_37446_8_non_const_usqr)))));
# 1377 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37420_6_non_const_x) + (((unsigned long)__cuda_local_var_37421_6_non_const_y) * pitch)) + ((4UL * pitch) * 512UL)))]) = ((SF * __cuda_local_var_37425_20_non_const_f4) + (((1.0F) - SF) * ((0.1111111119F) * (((__cuda_local_var_37442_8_non_const_rho - ((3.0F) * __cuda_local_var_37442_14_non_const_v)) + (((4.5F) * __cuda_local_var_37442_14_non_const_v) * __cuda_local_var_37442_14_non_const_v)) - ((1.5F) * __cuda_local_var_37446_8_non_const_usqr)))));
# 1378 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37420_6_non_const_x) + (((unsigned long)__cuda_local_var_37421_6_non_const_y) * pitch)) + ((5UL * pitch) * 512UL)))]) = ((float)(((double)(SF * __cuda_local_var_37425_23_non_const_f5)) + (((double)((1.0F) - SF)) * ((0.02777777777999999864) * ((double)(((__cuda_local_var_37442_8_non_const_rho + ((3.0F) * (__cuda_local_var_37442_12_non_const_u + __cuda_local_var_37442_14_non_const_v))) + (((4.5F) * (__cuda_local_var_37442_12_non_const_u + __cuda_local_var_37442_14_non_const_v)) * (__cuda_local_var_37442_12_non_const_u + __cuda_local_var_37442_14_non_const_v))) - ((1.5F) * __cuda_local_var_37446_8_non_const_usqr)))))));
# 1379 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37420_6_non_const_x) + (((unsigned long)__cuda_local_var_37421_6_non_const_y) * pitch)) + ((6UL * pitch) * 512UL)))]) = ((float)(((double)(SF * __cuda_local_var_37425_26_non_const_f6)) + (((double)((1.0F) - SF)) * ((0.02777777777999999864) * ((double)(((__cuda_local_var_37442_8_non_const_rho + ((3.0F) * ((-__cuda_local_var_37442_12_non_const_u) + __cuda_local_var_37442_14_non_const_v))) + (((4.5F) * ((-__cuda_local_var_37442_12_non_const_u) + __cuda_local_var_37442_14_non_const_v)) * ((-__cuda_local_var_37442_12_non_const_u) + __cuda_local_var_37442_14_non_const_v))) - ((1.5F) * __cuda_local_var_37446_8_non_const_usqr)))))));
# 1380 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37420_6_non_const_x) + (((unsigned long)__cuda_local_var_37421_6_non_const_y) * pitch)) + ((7UL * pitch) * 512UL)))]) = ((float)(((double)(SF * __cuda_local_var_37425_29_non_const_f7)) + (((double)((1.0F) - SF)) * ((0.02777777777999999864) * ((double)(((__cuda_local_var_37442_8_non_const_rho + ((3.0F) * ((-__cuda_local_var_37442_12_non_const_u) - __cuda_local_var_37442_14_non_const_v))) + (((4.5F) * ((-__cuda_local_var_37442_12_non_const_u) - __cuda_local_var_37442_14_non_const_v)) * ((-__cuda_local_var_37442_12_non_const_u) - __cuda_local_var_37442_14_non_const_v))) - ((1.5F) * __cuda_local_var_37446_8_non_const_usqr)))))));
# 1381 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37420_6_non_const_x) + (((unsigned long)__cuda_local_var_37421_6_non_const_y) * pitch)) + ((8UL * pitch) * 512UL)))]) = ((float)(((double)(SF * __cuda_local_var_37425_32_non_const_f8)) + (((double)((1.0F) - SF)) * ((0.02777777777999999864) * ((double)(((__cuda_local_var_37442_8_non_const_rho + ((3.0F) * (__cuda_local_var_37442_12_non_const_u - __cuda_local_var_37442_14_non_const_v))) + (((4.5F) * (__cuda_local_var_37442_12_non_const_u - __cuda_local_var_37442_14_non_const_v)) * (__cuda_local_var_37442_12_non_const_u - __cuda_local_var_37442_14_non_const_v))) - ((1.5F) * __cuda_local_var_37446_8_non_const_usqr)))))));
# 1383 "txInterpTest.cu"
}
# 1384 "txInterpTest.cu"
else
# 1384 "txInterpTest.cu"
{
# 1385 "txInterpTest.cu"
__cuda_local_var_37425_8_non_const_f0 = (fin[__cuda_local_var_37424_6_non_const_j]);
# 1386 "txInterpTest.cu"
__cuda_local_var_37425_14_non_const_f2 = (fin[((int)((((unsigned long)__cuda_local_var_37420_6_non_const_x) + (((unsigned long)(__cuda_local_var_37421_6_non_const_y - 1)) * pitch)) + ((2UL * pitch) * 512UL)))]);
# 1387 "txInterpTest.cu"
__cuda_local_var_37425_20_non_const_f4 = (fin[((int)((((unsigned long)__cuda_local_var_37420_6_non_const_x) + (((unsigned long)(__cuda_local_var_37421_6_non_const_y + 1)) * pitch)) + ((4UL * pitch) * 512UL)))]);
# 1388 "txInterpTest.cu"
__cuda_local_var_37425_11_non_const_f1 = ((((__T2477 = texRef_f1D) , ((void)(__T2478 = (((float)(__cuda_local_var_37420_6_non_const_x - 1)) + (0.5F))))) , ((void)(__T2479 = (((float)__cuda_local_var_37421_6_non_const_y) + (0.5F))))) , ((__T2481 = (__ftexfetch2D(__T2477, ((((((__T2480.x) = __T2478) , ((void)((__T2480.y) = __T2479))) , ((void)((__T2480.z) = (0.0F)))) , ((void)((__T2480.w) = (0.0F)))) , __T2480)))) , (__T2481.x)));
# 1389 "txInterpTest.cu"
__cuda_local_var_37425_17_non_const_f3 = ((((__T2482 = texRef_f3D) , ((void)(__T2483 = (((float)(__cuda_local_var_37420_6_non_const_x + 1)) + (0.5F))))) , ((void)(__T2484 = (((float)__cuda_local_var_37421_6_non_const_y) + (0.5F))))) , ((__T2486 = (__ftexfetch2D(__T2482, ((((((__T2485.x) = __T2483) , ((void)((__T2485.y) = __T2484))) , ((void)((__T2485.z) = (0.0F)))) , ((void)((__T2485.w) = (0.0F)))) , __T2485)))) , (__T2486.x)));
# 1390 "txInterpTest.cu"
__cuda_local_var_37425_23_non_const_f5 = ((((__T2487 = texRef_f5D) , ((void)(__T2488 = (((float)(__cuda_local_var_37420_6_non_const_x - 1)) + (0.5F))))) , ((void)(__T2489 = (((float)(__cuda_local_var_37421_6_non_const_y - 1)) + (0.5F))))) , ((__T2491 = (__ftexfetch2D(__T2487, ((((((__T2490.x) = __T2488) , ((void)((__T2490.y) = __T2489))) , ((void)((__T2490.z) = (0.0F)))) , ((void)((__T2490.w) = (0.0F)))) , __T2490)))) , (__T2491.x)));
# 1391 "txInterpTest.cu"
__cuda_local_var_37425_26_non_const_f6 = ((((__T2492 = texRef_f6D) , ((void)(__T2493 = (((float)(__cuda_local_var_37420_6_non_const_x + 1)) + (0.5F))))) , ((void)(__T2494 = (((float)(__cuda_local_var_37421_6_non_const_y - 1)) + (0.5F))))) , ((__T2496 = (__ftexfetch2D(__T2492, ((((((__T2495.x) = __T2493) , ((void)((__T2495.y) = __T2494))) , ((void)((__T2495.z) = (0.0F)))) , ((void)((__T2495.w) = (0.0F)))) , __T2495)))) , (__T2496.x)));
# 1392 "txInterpTest.cu"
__cuda_local_var_37425_29_non_const_f7 = ((((__T2497 = texRef_f7D) , ((void)(__T2498 = (((float)(__cuda_local_var_37420_6_non_const_x + 1)) + (0.5F))))) , ((void)(__T2499 = (((float)(__cuda_local_var_37421_6_non_const_y + 1)) + (0.5F))))) , ((__T2501 = (__ftexfetch2D(__T2497, ((((((__T2500.x) = __T2498) , ((void)((__T2500.y) = __T2499))) , ((void)((__T2500.z) = (0.0F)))) , ((void)((__T2500.w) = (0.0F)))) , __T2500)))) , (__T2501.x)));
# 1393 "txInterpTest.cu"
__cuda_local_var_37425_32_non_const_f8 = ((((__T2502 = texRef_f8D) , ((void)(__T2503 = (((float)(__cuda_local_var_37420_6_non_const_x - 1)) + (0.5F))))) , ((void)(__T2504 = (((float)(__cuda_local_var_37421_6_non_const_y + 1)) + (0.5F))))) , ((__T2506 = (__ftexfetch2D(__T2502, ((((((__T2505.x) = __T2503) , ((void)((__T2505.y) = __T2504))) , ((void)((__T2505.z) = (0.0F)))) , ((void)((__T2505.w) = (0.0F)))) , __T2505)))) , (__T2506.x)));
# 1394 "txInterpTest.cu"
if ((__cuda_local_var_37426_6_non_const_im == 1) || (__cuda_local_var_37426_6_non_const_im == 10))
# 1394 "txInterpTest.cu"
{
# 1395 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37420_6_non_const_x) + (((unsigned long)__cuda_local_var_37421_6_non_const_y) * pitch)) + ((1UL * pitch) * 512UL)))]) = __cuda_local_var_37425_17_non_const_f3;
# 1396 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37420_6_non_const_x) + (((unsigned long)__cuda_local_var_37421_6_non_const_y) * pitch)) + ((2UL * pitch) * 512UL)))]) = __cuda_local_var_37425_20_non_const_f4;
# 1397 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37420_6_non_const_x) + (((unsigned long)__cuda_local_var_37421_6_non_const_y) * pitch)) + ((3UL * pitch) * 512UL)))]) = __cuda_local_var_37425_11_non_const_f1;
# 1398 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37420_6_non_const_x) + (((unsigned long)__cuda_local_var_37421_6_non_const_y) * pitch)) + ((4UL * pitch) * 512UL)))]) = __cuda_local_var_37425_14_non_const_f2;
# 1399 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37420_6_non_const_x) + (((unsigned long)__cuda_local_var_37421_6_non_const_y) * pitch)) + ((5UL * pitch) * 512UL)))]) = __cuda_local_var_37425_29_non_const_f7;
# 1400 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37420_6_non_const_x) + (((unsigned long)__cuda_local_var_37421_6_non_const_y) * pitch)) + ((6UL * pitch) * 512UL)))]) = __cuda_local_var_37425_32_non_const_f8;
# 1401 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37420_6_non_const_x) + (((unsigned long)__cuda_local_var_37421_6_non_const_y) * pitch)) + ((7UL * pitch) * 512UL)))]) = __cuda_local_var_37425_23_non_const_f5;
# 1402 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37420_6_non_const_x) + (((unsigned long)__cuda_local_var_37421_6_non_const_y) * pitch)) + ((8UL * pitch) * 512UL)))]) = __cuda_local_var_37425_26_non_const_f6;
# 1403 "txInterpTest.cu"
}
# 1404 "txInterpTest.cu"
else
# 1404 "txInterpTest.cu"
{
# 1405 "txInterpTest.cu"
if (((const char *)"BGK") == ((const char *)"MRT"))
# 1405 "txInterpTest.cu"
{
# 1406 "txInterpTest.cu"
_Z11mrt_collideRfS_S_S_S_S_S_S_S_f((&__cuda_local_var_37425_8_non_const_f0), (&__cuda_local_var_37425_11_non_const_f1), (&__cuda_local_var_37425_14_non_const_f2), (&__cuda_local_var_37425_17_non_const_f3), (&__cuda_local_var_37425_20_non_const_f4), (&__cuda_local_var_37425_23_non_const_f5), (&__cuda_local_var_37425_26_non_const_f6), (&__cuda_local_var_37425_29_non_const_f7), (&__cuda_local_var_37425_32_non_const_f8), omega);
# 1406 "txInterpTest.cu"
}
# 1406 "txInterpTest.cu"
else
# 1406 "txInterpTest.cu"
{
# 1407 "txInterpTest.cu"
if (1)
# 1407 "txInterpTest.cu"
{
# 1408 "txInterpTest.cu"
{
# 1408 "txInterpTest.cu"
__T2507 = ((((((((__cuda_local_var_37425_8_non_const_f0 + __cuda_local_var_37425_11_non_const_f1) + __cuda_local_var_37425_14_non_const_f2) + __cuda_local_var_37425_17_non_const_f3) + __cuda_local_var_37425_20_non_const_f4) + __cuda_local_var_37425_23_non_const_f5) + __cuda_local_var_37425_26_non_const_f6) + __cuda_local_var_37425_29_non_const_f7) + __cuda_local_var_37425_32_non_const_f8);
# 1408 "txInterpTest.cu"
__T2508 = (((((__cuda_local_var_37425_11_non_const_f1 - __cuda_local_var_37425_17_non_const_f3) + __cuda_local_var_37425_23_non_const_f5) - __cuda_local_var_37425_26_non_const_f6) - __cuda_local_var_37425_29_non_const_f7) + __cuda_local_var_37425_32_non_const_f8);
# 1408 "txInterpTest.cu"
__T2509 = (((((__cuda_local_var_37425_14_non_const_f2 - __cuda_local_var_37425_20_non_const_f4) + __cuda_local_var_37425_23_non_const_f5) + __cuda_local_var_37425_26_non_const_f6) - __cuda_local_var_37425_29_non_const_f7) - __cuda_local_var_37425_32_non_const_f8);
# 1408 "txInterpTest.cu"
__T2510 = ((__T2508 * __T2508) + (__T2509 * __T2509));
# 1408 "txInterpTest.cu"
__cuda_local_var_37425_8_non_const_f0 = (__cuda_local_var_37425_8_non_const_f0 - (omega * (__cuda_local_var_37425_8_non_const_f0 - ((0.4444444478F) * (__T2507 - ((1.5F) * __T2510))))));
# 1408 "txInterpTest.cu"
__cuda_local_var_37425_11_non_const_f1 = (__cuda_local_var_37425_11_non_const_f1 - (omega * (__cuda_local_var_37425_11_non_const_f1 - ((0.1111111119F) * (((__T2507 + ((3.0F) * __T2508)) + (((4.5F) * __T2508) * __T2508)) - ((1.5F) * __T2510))))));
# 1408 "txInterpTest.cu"
__cuda_local_var_37425_14_non_const_f2 = (__cuda_local_var_37425_14_non_const_f2 - (omega * (__cuda_local_var_37425_14_non_const_f2 - ((0.1111111119F) * (((__T2507 + ((3.0F) * __T2509)) + (((4.5F) * __T2509) * __T2509)) - ((1.5F) * __T2510))))));
# 1408 "txInterpTest.cu"
__cuda_local_var_37425_17_non_const_f3 = (__cuda_local_var_37425_17_non_const_f3 - (omega * (__cuda_local_var_37425_17_non_const_f3 - ((0.1111111119F) * (((__T2507 - ((3.0F) * __T2508)) + (((4.5F) * __T2508) * __T2508)) - ((1.5F) * __T2510))))));
# 1408 "txInterpTest.cu"
__cuda_local_var_37425_20_non_const_f4 = (__cuda_local_var_37425_20_non_const_f4 - (omega * (__cuda_local_var_37425_20_non_const_f4 - ((0.1111111119F) * (((__T2507 - ((3.0F) * __T2509)) + (((4.5F) * __T2509) * __T2509)) - ((1.5F) * __T2510))))));
# 1408 "txInterpTest.cu"
__cuda_local_var_37425_23_non_const_f5 = ((float)(((double)__cuda_local_var_37425_23_non_const_f5) - (((double)omega) * (((double)__cuda_local_var_37425_23_non_const_f5) - ((0.02777777777999999864) * ((double)(((__T2507 + ((3.0F) * (__T2508 + __T2509))) + (((4.5F) * (__T2508 + __T2509)) * (__T2508 + __T2509))) - ((1.5F) * __T2510))))))));
# 1408 "txInterpTest.cu"
__cuda_local_var_37425_26_non_const_f6 = ((float)(((double)__cuda_local_var_37425_26_non_const_f6) - (((double)omega) * (((double)__cuda_local_var_37425_26_non_const_f6) - ((0.02777777777999999864) * ((double)(((__T2507 + ((3.0F) * ((-__T2508) + __T2509))) + (((4.5F) * ((-__T2508) + __T2509)) * ((-__T2508) + __T2509))) - ((1.5F) * __T2510))))))));
# 1408 "txInterpTest.cu"
__cuda_local_var_37425_29_non_const_f7 = ((float)(((double)__cuda_local_var_37425_29_non_const_f7) - (((double)omega) * (((double)__cuda_local_var_37425_29_non_const_f7) - ((0.02777777777999999864) * ((double)(((__T2507 + ((3.0F) * ((-__T2508) - __T2509))) + (((4.5F) * ((-__T2508) - __T2509)) * ((-__T2508) - __T2509))) - ((1.5F) * __T2510))))))));
# 1408 "txInterpTest.cu"
__cuda_local_var_37425_32_non_const_f8 = ((float)(((double)__cuda_local_var_37425_32_non_const_f8) - (((double)omega) * (((double)__cuda_local_var_37425_32_non_const_f8) - ((0.02777777777999999864) * ((double)(((__T2507 + ((3.0F) * (__T2508 - __T2509))) + (((4.5F) * (__T2508 - __T2509)) * (__T2508 - __T2509))) - ((1.5F) * __T2510))))))));
# 1408 "txInterpTest.cu"
}
# 1408 "txInterpTest.cu"
}
# 1408 "txInterpTest.cu"
}
# 1410 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37420_6_non_const_x) + (((unsigned long)__cuda_local_var_37421_6_non_const_y) * pitch)) + ((0UL * pitch) * 512UL)))]) = __cuda_local_var_37425_8_non_const_f0;
# 1411 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37420_6_non_const_x) + (((unsigned long)__cuda_local_var_37421_6_non_const_y) * pitch)) + ((1UL * pitch) * 512UL)))]) = __cuda_local_var_37425_11_non_const_f1;
# 1412 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37420_6_non_const_x) + (((unsigned long)__cuda_local_var_37421_6_non_const_y) * pitch)) + ((2UL * pitch) * 512UL)))]) = __cuda_local_var_37425_14_non_const_f2;
# 1413 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37420_6_non_const_x) + (((unsigned long)__cuda_local_var_37421_6_non_const_y) * pitch)) + ((3UL * pitch) * 512UL)))]) = __cuda_local_var_37425_17_non_const_f3;
# 1414 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37420_6_non_const_x) + (((unsigned long)__cuda_local_var_37421_6_non_const_y) * pitch)) + ((4UL * pitch) * 512UL)))]) = __cuda_local_var_37425_20_non_const_f4;
# 1415 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37420_6_non_const_x) + (((unsigned long)__cuda_local_var_37421_6_non_const_y) * pitch)) + ((5UL * pitch) * 512UL)))]) = __cuda_local_var_37425_23_non_const_f5;
# 1416 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37420_6_non_const_x) + (((unsigned long)__cuda_local_var_37421_6_non_const_y) * pitch)) + ((6UL * pitch) * 512UL)))]) = __cuda_local_var_37425_26_non_const_f6;
# 1417 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37420_6_non_const_x) + (((unsigned long)__cuda_local_var_37421_6_non_const_y) * pitch)) + ((7UL * pitch) * 512UL)))]) = __cuda_local_var_37425_29_non_const_f7;
# 1418 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37420_6_non_const_x) + (((unsigned long)__cuda_local_var_37421_6_non_const_y) * pitch)) + ((8UL * pitch) * 512UL)))]) = __cuda_local_var_37425_32_non_const_f8;
# 1419 "txInterpTest.cu"
}
# 1420 "txInterpTest.cu"
}
# 1421 "txInterpTest.cu"
}
# 1421 "txInterpTest.cu"
}}
# 1423 "txInterpTest.cu"
__attribute__((global)) __attribute__((__used__)) void _Z9LR_d_ABCDPfS_fm(
# 1423 "txInterpTest.cu"
float *fin,
# 1423 "txInterpTest.cu"
float *fout,
# 1424 "txInterpTest.cu"
float omega,
# 1424 "txInterpTest.cu"
size_t pitch){
# 1424 "txInterpTest.cu"
{
# 1425 "txInterpTest.cu"
{
# 1426 "txInterpTest.cu"
 int __cuda_local_var_37501_6_non_const_x;
# 1427 "txInterpTest.cu"
 int __cuda_local_var_37502_6_non_const_y;
# 1428 "txInterpTest.cu"
 float __cuda_local_var_37503_8_non_const_xcoord;
# 1429 "txInterpTest.cu"
 float __cuda_local_var_37504_8_non_const_ycoord;
# 1430 "txInterpTest.cu"
 int __cuda_local_var_37505_6_non_const_j;
# 1431 "txInterpTest.cu"
 int __cuda_local_var_37506_6_non_const_im;
# 1432 "txInterpTest.cu"
 float __cuda_local_var_37507_8_non_const_f0;
# 1432 "txInterpTest.cu"
 float __cuda_local_var_37507_11_non_const_f1;
# 1432 "txInterpTest.cu"
 float __cuda_local_var_37507_14_non_const_f2;
# 1432 "txInterpTest.cu"
 float __cuda_local_var_37507_17_non_const_f3;
# 1432 "txInterpTest.cu"
 float __cuda_local_var_37507_20_non_const_f4;
# 1432 "txInterpTest.cu"
 float __cuda_local_var_37507_23_non_const_f5;
# 1432 "txInterpTest.cu"
 float __cuda_local_var_37507_26_non_const_f6;
# 1432 "txInterpTest.cu"
 float __cuda_local_var_37507_29_non_const_f7;
# 1432 "txInterpTest.cu"
 float __cuda_local_var_37507_32_non_const_f8;
# 1426 "txInterpTest.cu"
__cuda_local_var_37501_6_non_const_x = ((int)((threadIdx.x) + ((blockIdx.x) * (blockDim.x))));
# 1427 "txInterpTest.cu"
__cuda_local_var_37502_6_non_const_y = ((int)((threadIdx.y) + ((blockIdx.y) * (blockDim.y))));
# 1428 "txInterpTest.cu"
__cuda_local_var_37503_8_non_const_xcoord = ((float)((415.625) + ((double)(((float)__cuda_local_var_37501_6_non_const_x) * (0.25F)))));
# 1429 "txInterpTest.cu"
__cuda_local_var_37504_8_non_const_ycoord = ((float)((319.625) + ((double)(((float)__cuda_local_var_37502_6_non_const_y) * (0.25F)))));
# 1430 "txInterpTest.cu"
__cuda_local_var_37505_6_non_const_j = ((int)(((unsigned long)__cuda_local_var_37501_6_non_const_x) + (((unsigned long)__cuda_local_var_37502_6_non_const_y) * pitch)));
# 1431 "txInterpTest.cu"
__cuda_local_var_37506_6_non_const_im = (_Z8ImageFcnff(__cuda_local_var_37503_8_non_const_xcoord, __cuda_local_var_37504_8_non_const_ycoord));
# 1438 "txInterpTest.cu"
__cuda_local_var_37507_8_non_const_f0 = (fin[__cuda_local_var_37505_6_non_const_j]);
# 1439 "txInterpTest.cu"
__cuda_local_var_37507_11_non_const_f1 = (fin[((int)((((unsigned long)(__cuda_local_var_37501_6_non_const_x - 1)) + (((unsigned long)__cuda_local_var_37502_6_non_const_y) * pitch)) + ((1UL * pitch) * 512UL)))]);
# 1440 "txInterpTest.cu"
__cuda_local_var_37507_14_non_const_f2 = (fin[((int)((((unsigned long)__cuda_local_var_37501_6_non_const_x) + (((unsigned long)(__cuda_local_var_37502_6_non_const_y - 1)) * pitch)) + ((2UL * pitch) * 512UL)))]);
# 1441 "txInterpTest.cu"
__cuda_local_var_37507_17_non_const_f3 = (fin[((int)((((unsigned long)(__cuda_local_var_37501_6_non_const_x + 1)) + (((unsigned long)__cuda_local_var_37502_6_non_const_y) * pitch)) + ((3UL * pitch) * 512UL)))]);
# 1442 "txInterpTest.cu"
__cuda_local_var_37507_20_non_const_f4 = (fin[((int)((((unsigned long)__cuda_local_var_37501_6_non_const_x) + (((unsigned long)(__cuda_local_var_37502_6_non_const_y + 1)) * pitch)) + ((4UL * pitch) * 512UL)))]);
# 1443 "txInterpTest.cu"
__cuda_local_var_37507_23_non_const_f5 = (fin[((int)((((unsigned long)(__cuda_local_var_37501_6_non_const_x - 1)) + (((unsigned long)(__cuda_local_var_37502_6_non_const_y - 1)) * pitch)) + ((5UL * pitch) * 512UL)))]);
# 1444 "txInterpTest.cu"
__cuda_local_var_37507_26_non_const_f6 = (fin[((int)((((unsigned long)(__cuda_local_var_37501_6_non_const_x + 1)) + (((unsigned long)(__cuda_local_var_37502_6_non_const_y - 1)) * pitch)) + ((6UL * pitch) * 512UL)))]);
# 1445 "txInterpTest.cu"
__cuda_local_var_37507_29_non_const_f7 = (fin[((int)((((unsigned long)(__cuda_local_var_37501_6_non_const_x + 1)) + (((unsigned long)(__cuda_local_var_37502_6_non_const_y + 1)) * pitch)) + ((7UL * pitch) * 512UL)))]);
# 1446 "txInterpTest.cu"
__cuda_local_var_37507_32_non_const_f8 = (fin[((int)((((unsigned long)(__cuda_local_var_37501_6_non_const_x - 1)) + (((unsigned long)(__cuda_local_var_37502_6_non_const_y + 1)) * pitch)) + ((8UL * pitch) * 512UL)))]);
# 1447 "txInterpTest.cu"
if ((__cuda_local_var_37506_6_non_const_im == 1) || (__cuda_local_var_37506_6_non_const_im == 10))
# 1447 "txInterpTest.cu"
{
# 1448 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37501_6_non_const_x) + (((unsigned long)__cuda_local_var_37502_6_non_const_y) * pitch)) + ((1UL * pitch) * 512UL)))]) = __cuda_local_var_37507_17_non_const_f3;
# 1449 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37501_6_non_const_x) + (((unsigned long)__cuda_local_var_37502_6_non_const_y) * pitch)) + ((2UL * pitch) * 512UL)))]) = __cuda_local_var_37507_20_non_const_f4;
# 1450 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37501_6_non_const_x) + (((unsigned long)__cuda_local_var_37502_6_non_const_y) * pitch)) + ((3UL * pitch) * 512UL)))]) = __cuda_local_var_37507_11_non_const_f1;
# 1451 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37501_6_non_const_x) + (((unsigned long)__cuda_local_var_37502_6_non_const_y) * pitch)) + ((4UL * pitch) * 512UL)))]) = __cuda_local_var_37507_14_non_const_f2;
# 1452 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37501_6_non_const_x) + (((unsigned long)__cuda_local_var_37502_6_non_const_y) * pitch)) + ((5UL * pitch) * 512UL)))]) = __cuda_local_var_37507_29_non_const_f7;
# 1453 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37501_6_non_const_x) + (((unsigned long)__cuda_local_var_37502_6_non_const_y) * pitch)) + ((6UL * pitch) * 512UL)))]) = __cuda_local_var_37507_32_non_const_f8;
# 1454 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37501_6_non_const_x) + (((unsigned long)__cuda_local_var_37502_6_non_const_y) * pitch)) + ((7UL * pitch) * 512UL)))]) = __cuda_local_var_37507_23_non_const_f5;
# 1455 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37501_6_non_const_x) + (((unsigned long)__cuda_local_var_37502_6_non_const_y) * pitch)) + ((8UL * pitch) * 512UL)))]) = __cuda_local_var_37507_26_non_const_f6;
# 1456 "txInterpTest.cu"
}
# 1457 "txInterpTest.cu"
else
# 1457 "txInterpTest.cu"
{
# 1458 "txInterpTest.cu"
if (((const char *)"BGK") == ((const char *)"MRT"))
# 1458 "txInterpTest.cu"
{
# 1459 "txInterpTest.cu"
_Z11mrt_collideRfS_S_S_S_S_S_S_S_f((&__cuda_local_var_37507_8_non_const_f0), (&__cuda_local_var_37507_11_non_const_f1), (&__cuda_local_var_37507_14_non_const_f2), (&__cuda_local_var_37507_17_non_const_f3), (&__cuda_local_var_37507_20_non_const_f4), (&__cuda_local_var_37507_23_non_const_f5), (&__cuda_local_var_37507_26_non_const_f6), (&__cuda_local_var_37507_29_non_const_f7), (&__cuda_local_var_37507_32_non_const_f8), omega);
# 1459 "txInterpTest.cu"
}
# 1459 "txInterpTest.cu"
else
# 1459 "txInterpTest.cu"
{
# 1460 "txInterpTest.cu"
if (1)
# 1460 "txInterpTest.cu"
{
# 1460 "txInterpTest.cu"
 float __T2556;
# 1461 "txInterpTest.cu"
 float __T2557;
# 1462 "txInterpTest.cu"
 float __T2558;
# 1463 "txInterpTest.cu"
 float __T2559;
# 1461 "txInterpTest.cu"
{
# 1461 "txInterpTest.cu"
__T2556 = ((((((((__cuda_local_var_37507_8_non_const_f0 + __cuda_local_var_37507_11_non_const_f1) + __cuda_local_var_37507_14_non_const_f2) + __cuda_local_var_37507_17_non_const_f3) + __cuda_local_var_37507_20_non_const_f4) + __cuda_local_var_37507_23_non_const_f5) + __cuda_local_var_37507_26_non_const_f6) + __cuda_local_var_37507_29_non_const_f7) + __cuda_local_var_37507_32_non_const_f8);
# 1461 "txInterpTest.cu"
__T2557 = (((((__cuda_local_var_37507_11_non_const_f1 - __cuda_local_var_37507_17_non_const_f3) + __cuda_local_var_37507_23_non_const_f5) - __cuda_local_var_37507_26_non_const_f6) - __cuda_local_var_37507_29_non_const_f7) + __cuda_local_var_37507_32_non_const_f8);
# 1461 "txInterpTest.cu"
__T2558 = (((((__cuda_local_var_37507_14_non_const_f2 - __cuda_local_var_37507_20_non_const_f4) + __cuda_local_var_37507_23_non_const_f5) + __cuda_local_var_37507_26_non_const_f6) - __cuda_local_var_37507_29_non_const_f7) - __cuda_local_var_37507_32_non_const_f8);
# 1461 "txInterpTest.cu"
__T2559 = ((__T2557 * __T2557) + (__T2558 * __T2558));
# 1461 "txInterpTest.cu"
__cuda_local_var_37507_8_non_const_f0 = (__cuda_local_var_37507_8_non_const_f0 - (omega * (__cuda_local_var_37507_8_non_const_f0 - ((0.4444444478F) * (__T2556 - ((1.5F) * __T2559))))));
# 1461 "txInterpTest.cu"
__cuda_local_var_37507_11_non_const_f1 = (__cuda_local_var_37507_11_non_const_f1 - (omega * (__cuda_local_var_37507_11_non_const_f1 - ((0.1111111119F) * (((__T2556 + ((3.0F) * __T2557)) + (((4.5F) * __T2557) * __T2557)) - ((1.5F) * __T2559))))));
# 1461 "txInterpTest.cu"
__cuda_local_var_37507_14_non_const_f2 = (__cuda_local_var_37507_14_non_const_f2 - (omega * (__cuda_local_var_37507_14_non_const_f2 - ((0.1111111119F) * (((__T2556 + ((3.0F) * __T2558)) + (((4.5F) * __T2558) * __T2558)) - ((1.5F) * __T2559))))));
# 1461 "txInterpTest.cu"
__cuda_local_var_37507_17_non_const_f3 = (__cuda_local_var_37507_17_non_const_f3 - (omega * (__cuda_local_var_37507_17_non_const_f3 - ((0.1111111119F) * (((__T2556 - ((3.0F) * __T2557)) + (((4.5F) * __T2557) * __T2557)) - ((1.5F) * __T2559))))));
# 1461 "txInterpTest.cu"
__cuda_local_var_37507_20_non_const_f4 = (__cuda_local_var_37507_20_non_const_f4 - (omega * (__cuda_local_var_37507_20_non_const_f4 - ((0.1111111119F) * (((__T2556 - ((3.0F) * __T2558)) + (((4.5F) * __T2558) * __T2558)) - ((1.5F) * __T2559))))));
# 1461 "txInterpTest.cu"
__cuda_local_var_37507_23_non_const_f5 = ((float)(((double)__cuda_local_var_37507_23_non_const_f5) - (((double)omega) * (((double)__cuda_local_var_37507_23_non_const_f5) - ((0.02777777777999999864) * ((double)(((__T2556 + ((3.0F) * (__T2557 + __T2558))) + (((4.5F) * (__T2557 + __T2558)) * (__T2557 + __T2558))) - ((1.5F) * __T2559))))))));
# 1461 "txInterpTest.cu"
__cuda_local_var_37507_26_non_const_f6 = ((float)(((double)__cuda_local_var_37507_26_non_const_f6) - (((double)omega) * (((double)__cuda_local_var_37507_26_non_const_f6) - ((0.02777777777999999864) * ((double)(((__T2556 + ((3.0F) * ((-__T2557) + __T2558))) + (((4.5F) * ((-__T2557) + __T2558)) * ((-__T2557) + __T2558))) - ((1.5F) * __T2559))))))));
# 1461 "txInterpTest.cu"
__cuda_local_var_37507_29_non_const_f7 = ((float)(((double)__cuda_local_var_37507_29_non_const_f7) - (((double)omega) * (((double)__cuda_local_var_37507_29_non_const_f7) - ((0.02777777777999999864) * ((double)(((__T2556 + ((3.0F) * ((-__T2557) - __T2558))) + (((4.5F) * ((-__T2557) - __T2558)) * ((-__T2557) - __T2558))) - ((1.5F) * __T2559))))))));
# 1461 "txInterpTest.cu"
__cuda_local_var_37507_32_non_const_f8 = ((float)(((double)__cuda_local_var_37507_32_non_const_f8) - (((double)omega) * (((double)__cuda_local_var_37507_32_non_const_f8) - ((0.02777777777999999864) * ((double)(((__T2556 + ((3.0F) * (__T2557 - __T2558))) + (((4.5F) * (__T2557 - __T2558)) * (__T2557 - __T2558))) - ((1.5F) * __T2559))))))));
# 1461 "txInterpTest.cu"
}
# 1461 "txInterpTest.cu"
}
# 1461 "txInterpTest.cu"
}
# 1462 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37501_6_non_const_x) + (((unsigned long)__cuda_local_var_37502_6_non_const_y) * pitch)) + ((0UL * pitch) * 512UL)))]) = __cuda_local_var_37507_8_non_const_f0;
# 1463 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37501_6_non_const_x) + (((unsigned long)__cuda_local_var_37502_6_non_const_y) * pitch)) + ((1UL * pitch) * 512UL)))]) = __cuda_local_var_37507_11_non_const_f1;
# 1464 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37501_6_non_const_x) + (((unsigned long)__cuda_local_var_37502_6_non_const_y) * pitch)) + ((2UL * pitch) * 512UL)))]) = __cuda_local_var_37507_14_non_const_f2;
# 1465 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37501_6_non_const_x) + (((unsigned long)__cuda_local_var_37502_6_non_const_y) * pitch)) + ((3UL * pitch) * 512UL)))]) = __cuda_local_var_37507_17_non_const_f3;
# 1466 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37501_6_non_const_x) + (((unsigned long)__cuda_local_var_37502_6_non_const_y) * pitch)) + ((4UL * pitch) * 512UL)))]) = __cuda_local_var_37507_20_non_const_f4;
# 1467 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37501_6_non_const_x) + (((unsigned long)__cuda_local_var_37502_6_non_const_y) * pitch)) + ((5UL * pitch) * 512UL)))]) = __cuda_local_var_37507_23_non_const_f5;
# 1468 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37501_6_non_const_x) + (((unsigned long)__cuda_local_var_37502_6_non_const_y) * pitch)) + ((6UL * pitch) * 512UL)))]) = __cuda_local_var_37507_26_non_const_f6;
# 1469 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37501_6_non_const_x) + (((unsigned long)__cuda_local_var_37502_6_non_const_y) * pitch)) + ((7UL * pitch) * 512UL)))]) = __cuda_local_var_37507_29_non_const_f7;
# 1470 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37501_6_non_const_x) + (((unsigned long)__cuda_local_var_37502_6_non_const_y) * pitch)) + ((8UL * pitch) * 512UL)))]) = __cuda_local_var_37507_32_non_const_f8;
# 1471 "txInterpTest.cu"
}
# 1473 "txInterpTest.cu"
}
# 1473 "txInterpTest.cu"
}}
# 1474 "txInterpTest.cu"
__attribute__((global)) __attribute__((__used__)) void _Z10LR_d_ABCD2PfS_fm(
# 1474 "txInterpTest.cu"
float *fin,
# 1474 "txInterpTest.cu"
float *fout,
# 1475 "txInterpTest.cu"
float omega,
# 1475 "txInterpTest.cu"
size_t pitch){
# 1475 "txInterpTest.cu"
{
# 1476 "txInterpTest.cu"
{
# 1477 "txInterpTest.cu"
 int __cuda_local_var_37552_6_non_const_x;
# 1478 "txInterpTest.cu"
 int __cuda_local_var_37553_6_non_const_y;
# 1479 "txInterpTest.cu"
 float __cuda_local_var_37554_8_non_const_xcoord;
# 1480 "txInterpTest.cu"
 float __cuda_local_var_37555_8_non_const_ycoord;
# 1481 "txInterpTest.cu"
 int __cuda_local_var_37556_6_non_const_j;
# 1482 "txInterpTest.cu"
 int __cuda_local_var_37557_6_non_const_im;
# 1483 "txInterpTest.cu"
 float __cuda_local_var_37558_8_non_const_f0;
# 1483 "txInterpTest.cu"
 float __cuda_local_var_37558_11_non_const_f1;
# 1483 "txInterpTest.cu"
 float __cuda_local_var_37558_14_non_const_f2;
# 1483 "txInterpTest.cu"
 float __cuda_local_var_37558_17_non_const_f3;
# 1483 "txInterpTest.cu"
 float __cuda_local_var_37558_20_non_const_f4;
# 1483 "txInterpTest.cu"
 float __cuda_local_var_37558_23_non_const_f5;
# 1483 "txInterpTest.cu"
 float __cuda_local_var_37558_26_non_const_f6;
# 1483 "txInterpTest.cu"
 float __cuda_local_var_37558_29_non_const_f7;
# 1483 "txInterpTest.cu"
 float __cuda_local_var_37558_32_non_const_f8;
# 1477 "txInterpTest.cu"
__cuda_local_var_37552_6_non_const_x = ((int)((threadIdx.x) + ((blockIdx.x) * (blockDim.x))));
# 1478 "txInterpTest.cu"
__cuda_local_var_37553_6_non_const_y = ((int)((threadIdx.y) + ((blockIdx.y) * (blockDim.y))));
# 1479 "txInterpTest.cu"
__cuda_local_var_37554_8_non_const_xcoord = ((float)((415.625) + ((double)(((float)__cuda_local_var_37552_6_non_const_x) * (0.25F)))));
# 1480 "txInterpTest.cu"
__cuda_local_var_37555_8_non_const_ycoord = ((float)((319.625) + ((double)(((float)__cuda_local_var_37553_6_non_const_y) * (0.25F)))));
# 1481 "txInterpTest.cu"
__cuda_local_var_37556_6_non_const_j = ((int)(((unsigned long)__cuda_local_var_37552_6_non_const_x) + (((unsigned long)__cuda_local_var_37553_6_non_const_y) * pitch)));
# 1482 "txInterpTest.cu"
__cuda_local_var_37557_6_non_const_im = (_Z8ImageFcnff(__cuda_local_var_37554_8_non_const_xcoord, __cuda_local_var_37555_8_non_const_ycoord));
# 1489 "txInterpTest.cu"
__cuda_local_var_37558_8_non_const_f0 = (fin[__cuda_local_var_37556_6_non_const_j]);
# 1490 "txInterpTest.cu"
__cuda_local_var_37558_11_non_const_f1 = (fin[((int)((((unsigned long)(__cuda_local_var_37552_6_non_const_x - 1)) + (((unsigned long)__cuda_local_var_37553_6_non_const_y) * pitch)) + ((1UL * pitch) * 512UL)))]);
# 1491 "txInterpTest.cu"
__cuda_local_var_37558_14_non_const_f2 = (fin[((int)((((unsigned long)__cuda_local_var_37552_6_non_const_x) + (((unsigned long)(__cuda_local_var_37553_6_non_const_y - 1)) * pitch)) + ((2UL * pitch) * 512UL)))]);
# 1492 "txInterpTest.cu"
__cuda_local_var_37558_17_non_const_f3 = (fin[((int)((((unsigned long)(__cuda_local_var_37552_6_non_const_x + 1)) + (((unsigned long)__cuda_local_var_37553_6_non_const_y) * pitch)) + ((3UL * pitch) * 512UL)))]);
# 1493 "txInterpTest.cu"
__cuda_local_var_37558_20_non_const_f4 = (fin[((int)((((unsigned long)__cuda_local_var_37552_6_non_const_x) + (((unsigned long)(__cuda_local_var_37553_6_non_const_y + 1)) * pitch)) + ((4UL * pitch) * 512UL)))]);
# 1494 "txInterpTest.cu"
__cuda_local_var_37558_23_non_const_f5 = (fin[((int)((((unsigned long)(__cuda_local_var_37552_6_non_const_x - 1)) + (((unsigned long)(__cuda_local_var_37553_6_non_const_y - 1)) * pitch)) + ((5UL * pitch) * 512UL)))]);
# 1495 "txInterpTest.cu"
__cuda_local_var_37558_26_non_const_f6 = (fin[((int)((((unsigned long)(__cuda_local_var_37552_6_non_const_x + 1)) + (((unsigned long)(__cuda_local_var_37553_6_non_const_y - 1)) * pitch)) + ((6UL * pitch) * 512UL)))]);
# 1496 "txInterpTest.cu"
__cuda_local_var_37558_29_non_const_f7 = (fin[((int)((((unsigned long)(__cuda_local_var_37552_6_non_const_x + 1)) + (((unsigned long)(__cuda_local_var_37553_6_non_const_y + 1)) * pitch)) + ((7UL * pitch) * 512UL)))]);
# 1497 "txInterpTest.cu"
__cuda_local_var_37558_32_non_const_f8 = (fin[((int)((((unsigned long)(__cuda_local_var_37552_6_non_const_x - 1)) + (((unsigned long)(__cuda_local_var_37553_6_non_const_y + 1)) * pitch)) + ((8UL * pitch) * 512UL)))]);
# 1498 "txInterpTest.cu"
if ((__cuda_local_var_37557_6_non_const_im == 1) || (__cuda_local_var_37557_6_non_const_im == 10))
# 1498 "txInterpTest.cu"
{
# 1499 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37552_6_non_const_x) + (((unsigned long)__cuda_local_var_37553_6_non_const_y) * pitch)) + ((1UL * pitch) * 512UL)))]) = __cuda_local_var_37558_17_non_const_f3;
# 1500 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37552_6_non_const_x) + (((unsigned long)__cuda_local_var_37553_6_non_const_y) * pitch)) + ((2UL * pitch) * 512UL)))]) = __cuda_local_var_37558_20_non_const_f4;
# 1501 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37552_6_non_const_x) + (((unsigned long)__cuda_local_var_37553_6_non_const_y) * pitch)) + ((3UL * pitch) * 512UL)))]) = __cuda_local_var_37558_11_non_const_f1;
# 1502 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37552_6_non_const_x) + (((unsigned long)__cuda_local_var_37553_6_non_const_y) * pitch)) + ((4UL * pitch) * 512UL)))]) = __cuda_local_var_37558_14_non_const_f2;
# 1503 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37552_6_non_const_x) + (((unsigned long)__cuda_local_var_37553_6_non_const_y) * pitch)) + ((5UL * pitch) * 512UL)))]) = __cuda_local_var_37558_29_non_const_f7;
# 1504 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37552_6_non_const_x) + (((unsigned long)__cuda_local_var_37553_6_non_const_y) * pitch)) + ((6UL * pitch) * 512UL)))]) = __cuda_local_var_37558_32_non_const_f8;
# 1505 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37552_6_non_const_x) + (((unsigned long)__cuda_local_var_37553_6_non_const_y) * pitch)) + ((7UL * pitch) * 512UL)))]) = __cuda_local_var_37558_23_non_const_f5;
# 1506 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37552_6_non_const_x) + (((unsigned long)__cuda_local_var_37553_6_non_const_y) * pitch)) + ((8UL * pitch) * 512UL)))]) = __cuda_local_var_37558_26_non_const_f6;
# 1507 "txInterpTest.cu"
}
# 1508 "txInterpTest.cu"
else
# 1508 "txInterpTest.cu"
{
# 1509 "txInterpTest.cu"
if (((const char *)"BGK") == ((const char *)"MRT"))
# 1509 "txInterpTest.cu"
{
# 1510 "txInterpTest.cu"
_Z11mrt_collideRfS_S_S_S_S_S_S_S_f((&__cuda_local_var_37558_8_non_const_f0), (&__cuda_local_var_37558_11_non_const_f1), (&__cuda_local_var_37558_14_non_const_f2), (&__cuda_local_var_37558_17_non_const_f3), (&__cuda_local_var_37558_20_non_const_f4), (&__cuda_local_var_37558_23_non_const_f5), (&__cuda_local_var_37558_26_non_const_f6), (&__cuda_local_var_37558_29_non_const_f7), (&__cuda_local_var_37558_32_non_const_f8), omega);
# 1510 "txInterpTest.cu"
}
# 1510 "txInterpTest.cu"
else
# 1510 "txInterpTest.cu"
{
# 1511 "txInterpTest.cu"
if (1)
# 1511 "txInterpTest.cu"
{
# 1511 "txInterpTest.cu"
 float __T2560;
# 1512 "txInterpTest.cu"
 float __T2561;
# 1513 "txInterpTest.cu"
 float __T2562;
# 1514 "txInterpTest.cu"
 float __T2563;
# 1512 "txInterpTest.cu"
{
# 1512 "txInterpTest.cu"
__T2560 = ((((((((__cuda_local_var_37558_8_non_const_f0 + __cuda_local_var_37558_11_non_const_f1) + __cuda_local_var_37558_14_non_const_f2) + __cuda_local_var_37558_17_non_const_f3) + __cuda_local_var_37558_20_non_const_f4) + __cuda_local_var_37558_23_non_const_f5) + __cuda_local_var_37558_26_non_const_f6) + __cuda_local_var_37558_29_non_const_f7) + __cuda_local_var_37558_32_non_const_f8);
# 1512 "txInterpTest.cu"
__T2561 = (((((__cuda_local_var_37558_11_non_const_f1 - __cuda_local_var_37558_17_non_const_f3) + __cuda_local_var_37558_23_non_const_f5) - __cuda_local_var_37558_26_non_const_f6) - __cuda_local_var_37558_29_non_const_f7) + __cuda_local_var_37558_32_non_const_f8);
# 1512 "txInterpTest.cu"
__T2562 = (((((__cuda_local_var_37558_14_non_const_f2 - __cuda_local_var_37558_20_non_const_f4) + __cuda_local_var_37558_23_non_const_f5) + __cuda_local_var_37558_26_non_const_f6) - __cuda_local_var_37558_29_non_const_f7) - __cuda_local_var_37558_32_non_const_f8);
# 1512 "txInterpTest.cu"
__T2563 = ((__T2561 * __T2561) + (__T2562 * __T2562));
# 1512 "txInterpTest.cu"
__cuda_local_var_37558_8_non_const_f0 = (__cuda_local_var_37558_8_non_const_f0 - (omega * (__cuda_local_var_37558_8_non_const_f0 - ((0.4444444478F) * (__T2560 - ((1.5F) * __T2563))))));
# 1512 "txInterpTest.cu"
__cuda_local_var_37558_11_non_const_f1 = (__cuda_local_var_37558_11_non_const_f1 - (omega * (__cuda_local_var_37558_11_non_const_f1 - ((0.1111111119F) * (((__T2560 + ((3.0F) * __T2561)) + (((4.5F) * __T2561) * __T2561)) - ((1.5F) * __T2563))))));
# 1512 "txInterpTest.cu"
__cuda_local_var_37558_14_non_const_f2 = (__cuda_local_var_37558_14_non_const_f2 - (omega * (__cuda_local_var_37558_14_non_const_f2 - ((0.1111111119F) * (((__T2560 + ((3.0F) * __T2562)) + (((4.5F) * __T2562) * __T2562)) - ((1.5F) * __T2563))))));
# 1512 "txInterpTest.cu"
__cuda_local_var_37558_17_non_const_f3 = (__cuda_local_var_37558_17_non_const_f3 - (omega * (__cuda_local_var_37558_17_non_const_f3 - ((0.1111111119F) * (((__T2560 - ((3.0F) * __T2561)) + (((4.5F) * __T2561) * __T2561)) - ((1.5F) * __T2563))))));
# 1512 "txInterpTest.cu"
__cuda_local_var_37558_20_non_const_f4 = (__cuda_local_var_37558_20_non_const_f4 - (omega * (__cuda_local_var_37558_20_non_const_f4 - ((0.1111111119F) * (((__T2560 - ((3.0F) * __T2562)) + (((4.5F) * __T2562) * __T2562)) - ((1.5F) * __T2563))))));
# 1512 "txInterpTest.cu"
__cuda_local_var_37558_23_non_const_f5 = ((float)(((double)__cuda_local_var_37558_23_non_const_f5) - (((double)omega) * (((double)__cuda_local_var_37558_23_non_const_f5) - ((0.02777777777999999864) * ((double)(((__T2560 + ((3.0F) * (__T2561 + __T2562))) + (((4.5F) * (__T2561 + __T2562)) * (__T2561 + __T2562))) - ((1.5F) * __T2563))))))));
# 1512 "txInterpTest.cu"
__cuda_local_var_37558_26_non_const_f6 = ((float)(((double)__cuda_local_var_37558_26_non_const_f6) - (((double)omega) * (((double)__cuda_local_var_37558_26_non_const_f6) - ((0.02777777777999999864) * ((double)(((__T2560 + ((3.0F) * ((-__T2561) + __T2562))) + (((4.5F) * ((-__T2561) + __T2562)) * ((-__T2561) + __T2562))) - ((1.5F) * __T2563))))))));
# 1512 "txInterpTest.cu"
__cuda_local_var_37558_29_non_const_f7 = ((float)(((double)__cuda_local_var_37558_29_non_const_f7) - (((double)omega) * (((double)__cuda_local_var_37558_29_non_const_f7) - ((0.02777777777999999864) * ((double)(((__T2560 + ((3.0F) * ((-__T2561) - __T2562))) + (((4.5F) * ((-__T2561) - __T2562)) * ((-__T2561) - __T2562))) - ((1.5F) * __T2563))))))));
# 1512 "txInterpTest.cu"
__cuda_local_var_37558_32_non_const_f8 = ((float)(((double)__cuda_local_var_37558_32_non_const_f8) - (((double)omega) * (((double)__cuda_local_var_37558_32_non_const_f8) - ((0.02777777777999999864) * ((double)(((__T2560 + ((3.0F) * (__T2561 - __T2562))) + (((4.5F) * (__T2561 - __T2562)) * (__T2561 - __T2562))) - ((1.5F) * __T2563))))))));
# 1512 "txInterpTest.cu"
}
# 1512 "txInterpTest.cu"
}
# 1512 "txInterpTest.cu"
}
# 1513 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37552_6_non_const_x) + (((unsigned long)__cuda_local_var_37553_6_non_const_y) * pitch)) + ((0UL * pitch) * 512UL)))]) = __cuda_local_var_37558_8_non_const_f0;
# 1514 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37552_6_non_const_x) + (((unsigned long)__cuda_local_var_37553_6_non_const_y) * pitch)) + ((1UL * pitch) * 512UL)))]) = __cuda_local_var_37558_11_non_const_f1;
# 1515 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37552_6_non_const_x) + (((unsigned long)__cuda_local_var_37553_6_non_const_y) * pitch)) + ((2UL * pitch) * 512UL)))]) = __cuda_local_var_37558_14_non_const_f2;
# 1516 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37552_6_non_const_x) + (((unsigned long)__cuda_local_var_37553_6_non_const_y) * pitch)) + ((3UL * pitch) * 512UL)))]) = __cuda_local_var_37558_17_non_const_f3;
# 1517 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37552_6_non_const_x) + (((unsigned long)__cuda_local_var_37553_6_non_const_y) * pitch)) + ((4UL * pitch) * 512UL)))]) = __cuda_local_var_37558_20_non_const_f4;
# 1518 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37552_6_non_const_x) + (((unsigned long)__cuda_local_var_37553_6_non_const_y) * pitch)) + ((5UL * pitch) * 512UL)))]) = __cuda_local_var_37558_23_non_const_f5;
# 1519 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37552_6_non_const_x) + (((unsigned long)__cuda_local_var_37553_6_non_const_y) * pitch)) + ((6UL * pitch) * 512UL)))]) = __cuda_local_var_37558_26_non_const_f6;
# 1520 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37552_6_non_const_x) + (((unsigned long)__cuda_local_var_37553_6_non_const_y) * pitch)) + ((7UL * pitch) * 512UL)))]) = __cuda_local_var_37558_29_non_const_f7;
# 1521 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37552_6_non_const_x) + (((unsigned long)__cuda_local_var_37553_6_non_const_y) * pitch)) + ((8UL * pitch) * 512UL)))]) = __cuda_local_var_37558_32_non_const_f8;
# 1522 "txInterpTest.cu"
}
# 1524 "txInterpTest.cu"
}
# 1524 "txInterpTest.cu"
}}
# 1526 "txInterpTest.cu"
__attribute__((global)) __attribute__((__used__)) void _Z9LR_d_ABDCPfS_fmf(
# 1526 "txInterpTest.cu"
float *fin,
# 1526 "txInterpTest.cu"
float *fout,
# 1527 "txInterpTest.cu"
float omega,
# 1527 "txInterpTest.cu"
size_t pitch,
# 1527 "txInterpTest.cu"
float SF){
# 1527 "txInterpTest.cu"
{
# 1528 "txInterpTest.cu"
{
# 1528 "txInterpTest.cu"
 int __T2564;
# 1529 "txInterpTest.cu"
 int __T2565;
# 1530 "txInterpTest.cu"
 int __T2566;
# 1531 "txInterpTest.cu"
 int __T2567;
# 1532 "txInterpTest.cu"
 int __T2568;
# 1533 "txInterpTest.cu"
 int __T2569;
# 1534 "txInterpTest.cu"
 int __T2570;
# 1535 "txInterpTest.cu"
 int __T2571;
# 1536 "txInterpTest.cu"
 int __T2572;
# 1537 "txInterpTest.cu"
 int __T2573;
# 1538 "txInterpTest.cu"
 int __T2574;
# 1539 "txInterpTest.cu"
 int __T2575;
# 1540 "txInterpTest.cu"
 float __T2576;
# 1541 "txInterpTest.cu"
 float __T2577;
# 1542 "txInterpTest.cu"
 float __T2578;
# 1543 "txInterpTest.cu"
 float __T2579;
# 1529 "txInterpTest.cu"
 int __cuda_local_var_37604_6_non_const_x;
# 1530 "txInterpTest.cu"
 int __cuda_local_var_37605_6_non_const_y;
# 1531 "txInterpTest.cu"
 float __cuda_local_var_37606_8_non_const_xcoord;
# 1532 "txInterpTest.cu"
 float __cuda_local_var_37607_8_non_const_ycoord;
# 1533 "txInterpTest.cu"
 int __cuda_local_var_37608_6_non_const_im;
# 1534 "txInterpTest.cu"
 int __cuda_local_var_37609_6_non_const_j;
# 1535 "txInterpTest.cu"
 float __cuda_local_var_37610_8_non_const_f0;
# 1535 "txInterpTest.cu"
 float __cuda_local_var_37610_11_non_const_f1;
# 1535 "txInterpTest.cu"
 float __cuda_local_var_37610_14_non_const_f2;
# 1535 "txInterpTest.cu"
 float __cuda_local_var_37610_17_non_const_f3;
# 1535 "txInterpTest.cu"
 float __cuda_local_var_37610_20_non_const_f4;
# 1535 "txInterpTest.cu"
 float __cuda_local_var_37610_23_non_const_f5;
# 1535 "txInterpTest.cu"
 float __cuda_local_var_37610_26_non_const_f6;
# 1535 "txInterpTest.cu"
 float __cuda_local_var_37610_29_non_const_f7;
# 1535 "txInterpTest.cu"
 float __cuda_local_var_37610_32_non_const_f8;
# 1529 "txInterpTest.cu"
__cuda_local_var_37604_6_non_const_x = ((int)((threadIdx.x) + ((blockIdx.x) * (blockDim.x))));
# 1530 "txInterpTest.cu"
__cuda_local_var_37605_6_non_const_y = ((int)((threadIdx.y) + ((blockIdx.y) * (blockDim.y))));
# 1531 "txInterpTest.cu"
__cuda_local_var_37606_8_non_const_xcoord = ((float)((415.625) + ((double)(((float)__cuda_local_var_37604_6_non_const_x) * (0.25F)))));
# 1532 "txInterpTest.cu"
__cuda_local_var_37607_8_non_const_ycoord = ((float)((319.625) + ((double)(((float)__cuda_local_var_37605_6_non_const_y) * (0.25F)))));
# 1533 "txInterpTest.cu"
__cuda_local_var_37608_6_non_const_im = (_Z8ImageFcnff(__cuda_local_var_37606_8_non_const_xcoord, __cuda_local_var_37607_8_non_const_ycoord));
# 1534 "txInterpTest.cu"
__cuda_local_var_37609_6_non_const_j = ((int)(((unsigned long)__cuda_local_var_37604_6_non_const_x) + (((unsigned long)__cuda_local_var_37605_6_non_const_y) * pitch)));
# 1537 "txInterpTest.cu"
if ((((__cuda_local_var_37604_6_non_const_x < 2) || (__cuda_local_var_37604_6_non_const_x > 765)) || (__cuda_local_var_37605_6_non_const_y < 2)) || (__cuda_local_var_37605_6_non_const_y > 509))
# 1538 "txInterpTest.cu"
{
# 1538 "txInterpTest.cu"
 __texture_type__ __T2580;
# 1539 "txInterpTest.cu"
 float __T2581;
# 1540 "txInterpTest.cu"
 float __T2582;
# 1541 "txInterpTest.cu"
 float4 __T2583;
# 1542 "txInterpTest.cu"
 float4 __T2584;
# 1543 "txInterpTest.cu"
 __texture_type__ __T2585;
# 1544 "txInterpTest.cu"
 float __T2586;
# 1545 "txInterpTest.cu"
 float __T2587;
# 1546 "txInterpTest.cu"
 float4 __T2588;
# 1547 "txInterpTest.cu"
 float4 __T2589;
# 1548 "txInterpTest.cu"
 __texture_type__ __T2590;
# 1549 "txInterpTest.cu"
 float __T2591;
# 1550 "txInterpTest.cu"
 float __T2592;
# 1551 "txInterpTest.cu"
 float4 __T2593;
# 1552 "txInterpTest.cu"
 float4 __T2594;
# 1553 "txInterpTest.cu"
 __texture_type__ __T2595;
# 1554 "txInterpTest.cu"
 float __T2596;
# 1555 "txInterpTest.cu"
 float __T2597;
# 1556 "txInterpTest.cu"
 float4 __T2598;
# 1557 "txInterpTest.cu"
 float4 __T2599;
# 1558 "txInterpTest.cu"
 __texture_type__ __T2600;
# 1559 "txInterpTest.cu"
 float __T2601;
# 1560 "txInterpTest.cu"
 float __T2602;
# 1561 "txInterpTest.cu"
 float4 __T2603;
# 1562 "txInterpTest.cu"
 float4 __T2604;
# 1563 "txInterpTest.cu"
 __texture_type__ __T2605;
# 1564 "txInterpTest.cu"
 float __T2606;
# 1565 "txInterpTest.cu"
 float __T2607;
# 1566 "txInterpTest.cu"
 float4 __T2608;
# 1567 "txInterpTest.cu"
 float4 __T2609;
# 1568 "txInterpTest.cu"
 __texture_type__ __T2610;
# 1569 "txInterpTest.cu"
 float __T2611;
# 1570 "txInterpTest.cu"
 float __T2612;
# 1571 "txInterpTest.cu"
 float4 __T2613;
# 1572 "txInterpTest.cu"
 float4 __T2614;
# 1573 "txInterpTest.cu"
 __texture_type__ __T2615;
# 1574 "txInterpTest.cu"
 float __T2616;
# 1575 "txInterpTest.cu"
 float __T2617;
# 1576 "txInterpTest.cu"
 float4 __T2618;
# 1577 "txInterpTest.cu"
 float4 __T2619;
# 1578 "txInterpTest.cu"
 __texture_type__ __T2620;
# 1579 "txInterpTest.cu"
 float __T2621;
# 1580 "txInterpTest.cu"
 float __T2622;
# 1581 "txInterpTest.cu"
 float4 __T2623;
# 1582 "txInterpTest.cu"
 float4 __T2624;
# 1550 "txInterpTest.cu"
 float __cuda_local_var_37625_8_non_const_rho;
# 1550 "txInterpTest.cu"
 float __cuda_local_var_37625_12_non_const_u;
# 1550 "txInterpTest.cu"
 float __cuda_local_var_37625_14_non_const_v;
# 1554 "txInterpTest.cu"
 float __cuda_local_var_37629_8_non_const_usqr;
# 1540 "txInterpTest.cu"
__cuda_local_var_37610_8_non_const_f0 = ((((__T2580 = texRef_f0B) , ((void)(__T2581 = (__cuda_local_var_37606_8_non_const_xcoord + (0.5F))))) , ((void)(__T2582 = (__cuda_local_var_37607_8_non_const_ycoord + (0.5F))))) , ((__T2584 = (__ftexfetch2D(__T2580, ((((((__T2583.x) = __T2581) , ((void)((__T2583.y) = __T2582))) , ((void)((__T2583.z) = (0.0F)))) , ((void)((__T2583.w) = (0.0F)))) , __T2583)))) , (__T2584.x)));
# 1541 "txInterpTest.cu"
__cuda_local_var_37610_11_non_const_f1 = ((((__T2585 = texRef_f1B) , ((void)(__T2586 = (__cuda_local_var_37606_8_non_const_xcoord + (0.5F))))) , ((void)(__T2587 = (__cuda_local_var_37607_8_non_const_ycoord + (0.5F))))) , ((__T2589 = (__ftexfetch2D(__T2585, ((((((__T2588.x) = __T2586) , ((void)((__T2588.y) = __T2587))) , ((void)((__T2588.z) = (0.0F)))) , ((void)((__T2588.w) = (0.0F)))) , __T2588)))) , (__T2589.x)));
# 1542 "txInterpTest.cu"
__cuda_local_var_37610_14_non_const_f2 = ((((__T2590 = texRef_f2B) , ((void)(__T2591 = (__cuda_local_var_37606_8_non_const_xcoord + (0.5F))))) , ((void)(__T2592 = (__cuda_local_var_37607_8_non_const_ycoord + (0.5F))))) , ((__T2594 = (__ftexfetch2D(__T2590, ((((((__T2593.x) = __T2591) , ((void)((__T2593.y) = __T2592))) , ((void)((__T2593.z) = (0.0F)))) , ((void)((__T2593.w) = (0.0F)))) , __T2593)))) , (__T2594.x)));
# 1543 "txInterpTest.cu"
__cuda_local_var_37610_17_non_const_f3 = ((((__T2595 = texRef_f3B) , ((void)(__T2596 = (__cuda_local_var_37606_8_non_const_xcoord + (0.5F))))) , ((void)(__T2597 = (__cuda_local_var_37607_8_non_const_ycoord + (0.5F))))) , ((__T2599 = (__ftexfetch2D(__T2595, ((((((__T2598.x) = __T2596) , ((void)((__T2598.y) = __T2597))) , ((void)((__T2598.z) = (0.0F)))) , ((void)((__T2598.w) = (0.0F)))) , __T2598)))) , (__T2599.x)));
# 1544 "txInterpTest.cu"
__cuda_local_var_37610_20_non_const_f4 = ((((__T2600 = texRef_f4B) , ((void)(__T2601 = (__cuda_local_var_37606_8_non_const_xcoord + (0.5F))))) , ((void)(__T2602 = (__cuda_local_var_37607_8_non_const_ycoord + (0.5F))))) , ((__T2604 = (__ftexfetch2D(__T2600, ((((((__T2603.x) = __T2601) , ((void)((__T2603.y) = __T2602))) , ((void)((__T2603.z) = (0.0F)))) , ((void)((__T2603.w) = (0.0F)))) , __T2603)))) , (__T2604.x)));
# 1545 "txInterpTest.cu"
__cuda_local_var_37610_23_non_const_f5 = ((((__T2605 = texRef_f5B) , ((void)(__T2606 = (__cuda_local_var_37606_8_non_const_xcoord + (0.5F))))) , ((void)(__T2607 = (__cuda_local_var_37607_8_non_const_ycoord + (0.5F))))) , ((__T2609 = (__ftexfetch2D(__T2605, ((((((__T2608.x) = __T2606) , ((void)((__T2608.y) = __T2607))) , ((void)((__T2608.z) = (0.0F)))) , ((void)((__T2608.w) = (0.0F)))) , __T2608)))) , (__T2609.x)));
# 1546 "txInterpTest.cu"
__cuda_local_var_37610_26_non_const_f6 = ((((__T2610 = texRef_f6B) , ((void)(__T2611 = (__cuda_local_var_37606_8_non_const_xcoord + (0.5F))))) , ((void)(__T2612 = (__cuda_local_var_37607_8_non_const_ycoord + (0.5F))))) , ((__T2614 = (__ftexfetch2D(__T2610, ((((((__T2613.x) = __T2611) , ((void)((__T2613.y) = __T2612))) , ((void)((__T2613.z) = (0.0F)))) , ((void)((__T2613.w) = (0.0F)))) , __T2613)))) , (__T2614.x)));
# 1547 "txInterpTest.cu"
__cuda_local_var_37610_29_non_const_f7 = ((((__T2615 = texRef_f7B) , ((void)(__T2616 = (__cuda_local_var_37606_8_non_const_xcoord + (0.5F))))) , ((void)(__T2617 = (__cuda_local_var_37607_8_non_const_ycoord + (0.5F))))) , ((__T2619 = (__ftexfetch2D(__T2615, ((((((__T2618.x) = __T2616) , ((void)((__T2618.y) = __T2617))) , ((void)((__T2618.z) = (0.0F)))) , ((void)((__T2618.w) = (0.0F)))) , __T2618)))) , (__T2619.x)));
# 1548 "txInterpTest.cu"
__cuda_local_var_37610_32_non_const_f8 = ((((__T2620 = texRef_f8B) , ((void)(__T2621 = (__cuda_local_var_37606_8_non_const_xcoord + (0.5F))))) , ((void)(__T2622 = (__cuda_local_var_37607_8_non_const_ycoord + (0.5F))))) , ((__T2624 = (__ftexfetch2D(__T2620, ((((((__T2623.x) = __T2621) , ((void)((__T2623.y) = __T2622))) , ((void)((__T2623.z) = (0.0F)))) , ((void)((__T2623.w) = (0.0F)))) , __T2623)))) , (__T2624.x)));
# 1551 "txInterpTest.cu"
__cuda_local_var_37625_8_non_const_rho = ((((((((__cuda_local_var_37610_8_non_const_f0 + __cuda_local_var_37610_11_non_const_f1) + __cuda_local_var_37610_14_non_const_f2) + __cuda_local_var_37610_17_non_const_f3) + __cuda_local_var_37610_20_non_const_f4) + __cuda_local_var_37610_23_non_const_f5) + __cuda_local_var_37610_26_non_const_f6) + __cuda_local_var_37610_29_non_const_f7) + __cuda_local_var_37610_32_non_const_f8);
# 1552 "txInterpTest.cu"
__cuda_local_var_37625_12_non_const_u = (((((__cuda_local_var_37610_11_non_const_f1 - __cuda_local_var_37610_17_non_const_f3) + __cuda_local_var_37610_23_non_const_f5) - __cuda_local_var_37610_26_non_const_f6) - __cuda_local_var_37610_29_non_const_f7) + __cuda_local_var_37610_32_non_const_f8);
# 1553 "txInterpTest.cu"
__cuda_local_var_37625_14_non_const_v = (((((__cuda_local_var_37610_14_non_const_f2 - __cuda_local_var_37610_20_non_const_f4) + __cuda_local_var_37610_23_non_const_f5) + __cuda_local_var_37610_26_non_const_f6) - __cuda_local_var_37610_29_non_const_f7) - __cuda_local_var_37610_32_non_const_f8);
# 1554 "txInterpTest.cu"
__cuda_local_var_37629_8_non_const_usqr = ((__cuda_local_var_37625_12_non_const_u * __cuda_local_var_37625_12_non_const_u) + (__cuda_local_var_37625_14_non_const_v * __cuda_local_var_37625_14_non_const_v));
# 1556 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37604_6_non_const_x) + (((unsigned long)__cuda_local_var_37605_6_non_const_y) * pitch)) + ((0UL * pitch) * 512UL)))]) = ((SF * __cuda_local_var_37610_8_non_const_f0) + (((1.0F) - SF) * ((0.4444444478F) * (__cuda_local_var_37625_8_non_const_rho - ((1.5F) * __cuda_local_var_37629_8_non_const_usqr)))));
# 1557 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37604_6_non_const_x) + (((unsigned long)__cuda_local_var_37605_6_non_const_y) * pitch)) + ((1UL * pitch) * 512UL)))]) = ((SF * __cuda_local_var_37610_11_non_const_f1) + (((1.0F) - SF) * ((0.1111111119F) * (((__cuda_local_var_37625_8_non_const_rho + ((3.0F) * __cuda_local_var_37625_12_non_const_u)) + (((4.5F) * __cuda_local_var_37625_12_non_const_u) * __cuda_local_var_37625_12_non_const_u)) - ((1.5F) * __cuda_local_var_37629_8_non_const_usqr)))));
# 1558 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37604_6_non_const_x) + (((unsigned long)__cuda_local_var_37605_6_non_const_y) * pitch)) + ((2UL * pitch) * 512UL)))]) = ((SF * __cuda_local_var_37610_14_non_const_f2) + (((1.0F) - SF) * ((0.1111111119F) * (((__cuda_local_var_37625_8_non_const_rho + ((3.0F) * __cuda_local_var_37625_14_non_const_v)) + (((4.5F) * __cuda_local_var_37625_14_non_const_v) * __cuda_local_var_37625_14_non_const_v)) - ((1.5F) * __cuda_local_var_37629_8_non_const_usqr)))));
# 1559 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37604_6_non_const_x) + (((unsigned long)__cuda_local_var_37605_6_non_const_y) * pitch)) + ((3UL * pitch) * 512UL)))]) = ((SF * __cuda_local_var_37610_17_non_const_f3) + (((1.0F) - SF) * ((0.1111111119F) * (((__cuda_local_var_37625_8_non_const_rho - ((3.0F) * __cuda_local_var_37625_12_non_const_u)) + (((4.5F) * __cuda_local_var_37625_12_non_const_u) * __cuda_local_var_37625_12_non_const_u)) - ((1.5F) * __cuda_local_var_37629_8_non_const_usqr)))));
# 1560 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37604_6_non_const_x) + (((unsigned long)__cuda_local_var_37605_6_non_const_y) * pitch)) + ((4UL * pitch) * 512UL)))]) = ((SF * __cuda_local_var_37610_20_non_const_f4) + (((1.0F) - SF) * ((0.1111111119F) * (((__cuda_local_var_37625_8_non_const_rho - ((3.0F) * __cuda_local_var_37625_14_non_const_v)) + (((4.5F) * __cuda_local_var_37625_14_non_const_v) * __cuda_local_var_37625_14_non_const_v)) - ((1.5F) * __cuda_local_var_37629_8_non_const_usqr)))));
# 1561 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37604_6_non_const_x) + (((unsigned long)__cuda_local_var_37605_6_non_const_y) * pitch)) + ((5UL * pitch) * 512UL)))]) = ((float)(((double)(SF * __cuda_local_var_37610_23_non_const_f5)) + (((double)((1.0F) - SF)) * ((0.02777777777999999864) * ((double)(((__cuda_local_var_37625_8_non_const_rho + ((3.0F) * (__cuda_local_var_37625_12_non_const_u + __cuda_local_var_37625_14_non_const_v))) + (((4.5F) * (__cuda_local_var_37625_12_non_const_u + __cuda_local_var_37625_14_non_const_v)) * (__cuda_local_var_37625_12_non_const_u + __cuda_local_var_37625_14_non_const_v))) - ((1.5F) * __cuda_local_var_37629_8_non_const_usqr)))))));
# 1562 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37604_6_non_const_x) + (((unsigned long)__cuda_local_var_37605_6_non_const_y) * pitch)) + ((6UL * pitch) * 512UL)))]) = ((float)(((double)(SF * __cuda_local_var_37610_26_non_const_f6)) + (((double)((1.0F) - SF)) * ((0.02777777777999999864) * ((double)(((__cuda_local_var_37625_8_non_const_rho + ((3.0F) * ((-__cuda_local_var_37625_12_non_const_u) + __cuda_local_var_37625_14_non_const_v))) + (((4.5F) * ((-__cuda_local_var_37625_12_non_const_u) + __cuda_local_var_37625_14_non_const_v)) * ((-__cuda_local_var_37625_12_non_const_u) + __cuda_local_var_37625_14_non_const_v))) - ((1.5F) * __cuda_local_var_37629_8_non_const_usqr)))))));
# 1563 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37604_6_non_const_x) + (((unsigned long)__cuda_local_var_37605_6_non_const_y) * pitch)) + ((7UL * pitch) * 512UL)))]) = ((float)(((double)(SF * __cuda_local_var_37610_29_non_const_f7)) + (((double)((1.0F) - SF)) * ((0.02777777777999999864) * ((double)(((__cuda_local_var_37625_8_non_const_rho + ((3.0F) * ((-__cuda_local_var_37625_12_non_const_u) - __cuda_local_var_37625_14_non_const_v))) + (((4.5F) * ((-__cuda_local_var_37625_12_non_const_u) - __cuda_local_var_37625_14_non_const_v)) * ((-__cuda_local_var_37625_12_non_const_u) - __cuda_local_var_37625_14_non_const_v))) - ((1.5F) * __cuda_local_var_37629_8_non_const_usqr)))))));
# 1564 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37604_6_non_const_x) + (((unsigned long)__cuda_local_var_37605_6_non_const_y) * pitch)) + ((8UL * pitch) * 512UL)))]) = ((float)(((double)(SF * __cuda_local_var_37610_32_non_const_f8)) + (((double)((1.0F) - SF)) * ((0.02777777777999999864) * ((double)(((__cuda_local_var_37625_8_non_const_rho + ((3.0F) * (__cuda_local_var_37625_12_non_const_u - __cuda_local_var_37625_14_non_const_v))) + (((4.5F) * (__cuda_local_var_37625_12_non_const_u - __cuda_local_var_37625_14_non_const_v)) * (__cuda_local_var_37625_12_non_const_u - __cuda_local_var_37625_14_non_const_v))) - ((1.5F) * __cuda_local_var_37629_8_non_const_usqr)))))));
# 1584 "txInterpTest.cu"
}
# 1585 "txInterpTest.cu"
else
# 1585 "txInterpTest.cu"
{
# 1586 "txInterpTest.cu"
__cuda_local_var_37610_8_non_const_f0 = (fin[__cuda_local_var_37609_6_non_const_j]);
# 1587 "txInterpTest.cu"
__cuda_local_var_37610_11_non_const_f1 = (fin[(((__T2564 = (_Z4dmaxi((__cuda_local_var_37604_6_non_const_x - 1)))) , ((void)(__T2565 = __cuda_local_var_37605_6_non_const_y))) , ((int)((((unsigned long)__T2564) + (((unsigned long)__T2565) * pitch)) + ((1UL * pitch) * 512UL))))]);
# 1588 "txInterpTest.cu"
__cuda_local_var_37610_17_non_const_f3 = (fin[(((__T2566 = (_Z4dminii((__cuda_local_var_37604_6_non_const_x + 1), 1024))) , ((void)(__T2567 = __cuda_local_var_37605_6_non_const_y))) , ((int)((((unsigned long)__T2566) + (((unsigned long)__T2567) * pitch)) + ((3UL * pitch) * 512UL))))]);
# 1589 "txInterpTest.cu"
__cuda_local_var_37610_14_non_const_f2 = (fin[((int)((((unsigned long)__cuda_local_var_37604_6_non_const_x) + (((unsigned long)(__cuda_local_var_37605_6_non_const_y - 1)) * pitch)) + ((2UL * pitch) * 512UL)))]);
# 1590 "txInterpTest.cu"
__cuda_local_var_37610_23_non_const_f5 = (fin[(((__T2568 = (_Z4dmaxi((__cuda_local_var_37604_6_non_const_x - 1)))) , ((void)(__T2569 = (__cuda_local_var_37605_6_non_const_y - 1)))) , ((int)((((unsigned long)__T2568) + (((unsigned long)__T2569) * pitch)) + ((5UL * pitch) * 512UL))))]);
# 1591 "txInterpTest.cu"
__cuda_local_var_37610_26_non_const_f6 = (fin[(((__T2570 = (_Z4dminii((__cuda_local_var_37604_6_non_const_x + 1), 1024))) , ((void)(__T2571 = (__cuda_local_var_37605_6_non_const_y - 1)))) , ((int)((((unsigned long)__T2570) + (((unsigned long)__T2571) * pitch)) + ((6UL * pitch) * 512UL))))]);
# 1592 "txInterpTest.cu"
__cuda_local_var_37610_20_non_const_f4 = (fin[((int)((((unsigned long)__cuda_local_var_37604_6_non_const_x) + (((unsigned long)(__cuda_local_var_37605_6_non_const_y + 1)) * pitch)) + ((4UL * pitch) * 512UL)))]);
# 1593 "txInterpTest.cu"
__cuda_local_var_37610_29_non_const_f7 = (fin[(((__T2572 = (_Z4dminii((__cuda_local_var_37604_6_non_const_x + 1), 1024))) , ((void)(__T2573 = (__cuda_local_var_37605_6_non_const_y + 1)))) , ((int)((((unsigned long)__T2572) + (((unsigned long)__T2573) * pitch)) + ((7UL * pitch) * 512UL))))]);
# 1594 "txInterpTest.cu"
__cuda_local_var_37610_32_non_const_f8 = (fin[(((__T2574 = (_Z4dmaxi((__cuda_local_var_37604_6_non_const_x - 1)))) , ((void)(__T2575 = (_Z4dminii((__cuda_local_var_37605_6_non_const_y + 1), 768))))) , ((int)((((unsigned long)__T2574) + (((unsigned long)__T2575) * pitch)) + ((8UL * pitch) * 512UL))))]);
# 1595 "txInterpTest.cu"
if ((__cuda_local_var_37608_6_non_const_im == 1) || (__cuda_local_var_37608_6_non_const_im == 10))
# 1595 "txInterpTest.cu"
{
# 1596 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37604_6_non_const_x) + (((unsigned long)__cuda_local_var_37605_6_non_const_y) * pitch)) + ((1UL * pitch) * 512UL)))]) = __cuda_local_var_37610_17_non_const_f3;
# 1597 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37604_6_non_const_x) + (((unsigned long)__cuda_local_var_37605_6_non_const_y) * pitch)) + ((2UL * pitch) * 512UL)))]) = __cuda_local_var_37610_20_non_const_f4;
# 1598 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37604_6_non_const_x) + (((unsigned long)__cuda_local_var_37605_6_non_const_y) * pitch)) + ((3UL * pitch) * 512UL)))]) = __cuda_local_var_37610_11_non_const_f1;
# 1599 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37604_6_non_const_x) + (((unsigned long)__cuda_local_var_37605_6_non_const_y) * pitch)) + ((4UL * pitch) * 512UL)))]) = __cuda_local_var_37610_14_non_const_f2;
# 1600 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37604_6_non_const_x) + (((unsigned long)__cuda_local_var_37605_6_non_const_y) * pitch)) + ((5UL * pitch) * 512UL)))]) = __cuda_local_var_37610_29_non_const_f7;
# 1601 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37604_6_non_const_x) + (((unsigned long)__cuda_local_var_37605_6_non_const_y) * pitch)) + ((6UL * pitch) * 512UL)))]) = __cuda_local_var_37610_32_non_const_f8;
# 1602 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37604_6_non_const_x) + (((unsigned long)__cuda_local_var_37605_6_non_const_y) * pitch)) + ((7UL * pitch) * 512UL)))]) = __cuda_local_var_37610_23_non_const_f5;
# 1603 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37604_6_non_const_x) + (((unsigned long)__cuda_local_var_37605_6_non_const_y) * pitch)) + ((8UL * pitch) * 512UL)))]) = __cuda_local_var_37610_26_non_const_f6;
# 1604 "txInterpTest.cu"
}
# 1605 "txInterpTest.cu"
else
# 1605 "txInterpTest.cu"
{
# 1606 "txInterpTest.cu"
if (((const char *)"BGK") == ((const char *)"MRT"))
# 1606 "txInterpTest.cu"
{
# 1607 "txInterpTest.cu"
_Z11mrt_collideRfS_S_S_S_S_S_S_S_f((&__cuda_local_var_37610_8_non_const_f0), (&__cuda_local_var_37610_11_non_const_f1), (&__cuda_local_var_37610_14_non_const_f2), (&__cuda_local_var_37610_17_non_const_f3), (&__cuda_local_var_37610_20_non_const_f4), (&__cuda_local_var_37610_23_non_const_f5), (&__cuda_local_var_37610_26_non_const_f6), (&__cuda_local_var_37610_29_non_const_f7), (&__cuda_local_var_37610_32_non_const_f8), omega);
# 1607 "txInterpTest.cu"
}
# 1607 "txInterpTest.cu"
else
# 1607 "txInterpTest.cu"
{
# 1608 "txInterpTest.cu"
if (1)
# 1608 "txInterpTest.cu"
{
# 1609 "txInterpTest.cu"
{
# 1609 "txInterpTest.cu"
__T2576 = ((((((((__cuda_local_var_37610_8_non_const_f0 + __cuda_local_var_37610_11_non_const_f1) + __cuda_local_var_37610_14_non_const_f2) + __cuda_local_var_37610_17_non_const_f3) + __cuda_local_var_37610_20_non_const_f4) + __cuda_local_var_37610_23_non_const_f5) + __cuda_local_var_37610_26_non_const_f6) + __cuda_local_var_37610_29_non_const_f7) + __cuda_local_var_37610_32_non_const_f8);
# 1609 "txInterpTest.cu"
__T2577 = (((((__cuda_local_var_37610_11_non_const_f1 - __cuda_local_var_37610_17_non_const_f3) + __cuda_local_var_37610_23_non_const_f5) - __cuda_local_var_37610_26_non_const_f6) - __cuda_local_var_37610_29_non_const_f7) + __cuda_local_var_37610_32_non_const_f8);
# 1609 "txInterpTest.cu"
__T2578 = (((((__cuda_local_var_37610_14_non_const_f2 - __cuda_local_var_37610_20_non_const_f4) + __cuda_local_var_37610_23_non_const_f5) + __cuda_local_var_37610_26_non_const_f6) - __cuda_local_var_37610_29_non_const_f7) - __cuda_local_var_37610_32_non_const_f8);
# 1609 "txInterpTest.cu"
__T2579 = ((__T2577 * __T2577) + (__T2578 * __T2578));
# 1609 "txInterpTest.cu"
__cuda_local_var_37610_8_non_const_f0 = (__cuda_local_var_37610_8_non_const_f0 - (omega * (__cuda_local_var_37610_8_non_const_f0 - ((0.4444444478F) * (__T2576 - ((1.5F) * __T2579))))));
# 1609 "txInterpTest.cu"
__cuda_local_var_37610_11_non_const_f1 = (__cuda_local_var_37610_11_non_const_f1 - (omega * (__cuda_local_var_37610_11_non_const_f1 - ((0.1111111119F) * (((__T2576 + ((3.0F) * __T2577)) + (((4.5F) * __T2577) * __T2577)) - ((1.5F) * __T2579))))));
# 1609 "txInterpTest.cu"
__cuda_local_var_37610_14_non_const_f2 = (__cuda_local_var_37610_14_non_const_f2 - (omega * (__cuda_local_var_37610_14_non_const_f2 - ((0.1111111119F) * (((__T2576 + ((3.0F) * __T2578)) + (((4.5F) * __T2578) * __T2578)) - ((1.5F) * __T2579))))));
# 1609 "txInterpTest.cu"
__cuda_local_var_37610_17_non_const_f3 = (__cuda_local_var_37610_17_non_const_f3 - (omega * (__cuda_local_var_37610_17_non_const_f3 - ((0.1111111119F) * (((__T2576 - ((3.0F) * __T2577)) + (((4.5F) * __T2577) * __T2577)) - ((1.5F) * __T2579))))));
# 1609 "txInterpTest.cu"
__cuda_local_var_37610_20_non_const_f4 = (__cuda_local_var_37610_20_non_const_f4 - (omega * (__cuda_local_var_37610_20_non_const_f4 - ((0.1111111119F) * (((__T2576 - ((3.0F) * __T2578)) + (((4.5F) * __T2578) * __T2578)) - ((1.5F) * __T2579))))));
# 1609 "txInterpTest.cu"
__cuda_local_var_37610_23_non_const_f5 = ((float)(((double)__cuda_local_var_37610_23_non_const_f5) - (((double)omega) * (((double)__cuda_local_var_37610_23_non_const_f5) - ((0.02777777777999999864) * ((double)(((__T2576 + ((3.0F) * (__T2577 + __T2578))) + (((4.5F) * (__T2577 + __T2578)) * (__T2577 + __T2578))) - ((1.5F) * __T2579))))))));
# 1609 "txInterpTest.cu"
__cuda_local_var_37610_26_non_const_f6 = ((float)(((double)__cuda_local_var_37610_26_non_const_f6) - (((double)omega) * (((double)__cuda_local_var_37610_26_non_const_f6) - ((0.02777777777999999864) * ((double)(((__T2576 + ((3.0F) * ((-__T2577) + __T2578))) + (((4.5F) * ((-__T2577) + __T2578)) * ((-__T2577) + __T2578))) - ((1.5F) * __T2579))))))));
# 1609 "txInterpTest.cu"
__cuda_local_var_37610_29_non_const_f7 = ((float)(((double)__cuda_local_var_37610_29_non_const_f7) - (((double)omega) * (((double)__cuda_local_var_37610_29_non_const_f7) - ((0.02777777777999999864) * ((double)(((__T2576 + ((3.0F) * ((-__T2577) - __T2578))) + (((4.5F) * ((-__T2577) - __T2578)) * ((-__T2577) - __T2578))) - ((1.5F) * __T2579))))))));
# 1609 "txInterpTest.cu"
__cuda_local_var_37610_32_non_const_f8 = ((float)(((double)__cuda_local_var_37610_32_non_const_f8) - (((double)omega) * (((double)__cuda_local_var_37610_32_non_const_f8) - ((0.02777777777999999864) * ((double)(((__T2576 + ((3.0F) * (__T2577 - __T2578))) + (((4.5F) * (__T2577 - __T2578)) * (__T2577 - __T2578))) - ((1.5F) * __T2579))))))));
# 1609 "txInterpTest.cu"
}
# 1609 "txInterpTest.cu"
}
# 1609 "txInterpTest.cu"
}
# 1611 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37604_6_non_const_x) + (((unsigned long)__cuda_local_var_37605_6_non_const_y) * pitch)) + ((0UL * pitch) * 512UL)))]) = __cuda_local_var_37610_8_non_const_f0;
# 1612 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37604_6_non_const_x) + (((unsigned long)__cuda_local_var_37605_6_non_const_y) * pitch)) + ((1UL * pitch) * 512UL)))]) = __cuda_local_var_37610_11_non_const_f1;
# 1613 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37604_6_non_const_x) + (((unsigned long)__cuda_local_var_37605_6_non_const_y) * pitch)) + ((2UL * pitch) * 512UL)))]) = __cuda_local_var_37610_14_non_const_f2;
# 1614 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37604_6_non_const_x) + (((unsigned long)__cuda_local_var_37605_6_non_const_y) * pitch)) + ((3UL * pitch) * 512UL)))]) = __cuda_local_var_37610_17_non_const_f3;
# 1615 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37604_6_non_const_x) + (((unsigned long)__cuda_local_var_37605_6_non_const_y) * pitch)) + ((4UL * pitch) * 512UL)))]) = __cuda_local_var_37610_20_non_const_f4;
# 1616 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37604_6_non_const_x) + (((unsigned long)__cuda_local_var_37605_6_non_const_y) * pitch)) + ((5UL * pitch) * 512UL)))]) = __cuda_local_var_37610_23_non_const_f5;
# 1617 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37604_6_non_const_x) + (((unsigned long)__cuda_local_var_37605_6_non_const_y) * pitch)) + ((6UL * pitch) * 512UL)))]) = __cuda_local_var_37610_26_non_const_f6;
# 1618 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37604_6_non_const_x) + (((unsigned long)__cuda_local_var_37605_6_non_const_y) * pitch)) + ((7UL * pitch) * 512UL)))]) = __cuda_local_var_37610_29_non_const_f7;
# 1619 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37604_6_non_const_x) + (((unsigned long)__cuda_local_var_37605_6_non_const_y) * pitch)) + ((8UL * pitch) * 512UL)))]) = __cuda_local_var_37610_32_non_const_f8;
# 1620 "txInterpTest.cu"
}
# 1621 "txInterpTest.cu"
}
# 1622 "txInterpTest.cu"
}
# 1622 "txInterpTest.cu"
}}
# 1624 "txInterpTest.cu"
__attribute__((global)) __attribute__((__used__)) void _Z9LR_d_BACDPfS_fm(
# 1624 "txInterpTest.cu"
float *fin,
# 1624 "txInterpTest.cu"
float *fout,
# 1625 "txInterpTest.cu"
float omega,
# 1625 "txInterpTest.cu"
size_t pitch){
# 1625 "txInterpTest.cu"
{
# 1626 "txInterpTest.cu"
{
# 1627 "txInterpTest.cu"
 int __cuda_local_var_37684_6_non_const_x;
# 1628 "txInterpTest.cu"
 int __cuda_local_var_37685_6_non_const_y;
# 1629 "txInterpTest.cu"
 float __cuda_local_var_37686_8_non_const_xcoord;
# 1630 "txInterpTest.cu"
 float __cuda_local_var_37687_8_non_const_ycoord;
# 1631 "txInterpTest.cu"
 int __cuda_local_var_37688_6_non_const_j;
# 1632 "txInterpTest.cu"
 int __cuda_local_var_37689_6_non_const_im;
# 1633 "txInterpTest.cu"
 float __cuda_local_var_37690_8_non_const_f0;
# 1633 "txInterpTest.cu"
 float __cuda_local_var_37690_11_non_const_f1;
# 1633 "txInterpTest.cu"
 float __cuda_local_var_37690_14_non_const_f2;
# 1633 "txInterpTest.cu"
 float __cuda_local_var_37690_17_non_const_f3;
# 1633 "txInterpTest.cu"
 float __cuda_local_var_37690_20_non_const_f4;
# 1633 "txInterpTest.cu"
 float __cuda_local_var_37690_23_non_const_f5;
# 1633 "txInterpTest.cu"
 float __cuda_local_var_37690_26_non_const_f6;
# 1633 "txInterpTest.cu"
 float __cuda_local_var_37690_29_non_const_f7;
# 1633 "txInterpTest.cu"
 float __cuda_local_var_37690_32_non_const_f8;
# 1627 "txInterpTest.cu"
__cuda_local_var_37684_6_non_const_x = ((int)((threadIdx.x) + ((blockIdx.x) * (blockDim.x))));
# 1628 "txInterpTest.cu"
__cuda_local_var_37685_6_non_const_y = ((int)((threadIdx.y) + ((blockIdx.y) * (blockDim.y))));
# 1629 "txInterpTest.cu"
__cuda_local_var_37686_8_non_const_xcoord = ((float)((415.625) + ((double)(((float)__cuda_local_var_37684_6_non_const_x) * (0.25F)))));
# 1630 "txInterpTest.cu"
__cuda_local_var_37687_8_non_const_ycoord = ((float)((319.625) + ((double)(((float)__cuda_local_var_37685_6_non_const_y) * (0.25F)))));
# 1631 "txInterpTest.cu"
__cuda_local_var_37688_6_non_const_j = ((int)(((unsigned long)__cuda_local_var_37684_6_non_const_x) + (((unsigned long)__cuda_local_var_37685_6_non_const_y) * pitch)));
# 1632 "txInterpTest.cu"
__cuda_local_var_37689_6_non_const_im = (_Z8ImageFcnff(__cuda_local_var_37686_8_non_const_xcoord, __cuda_local_var_37687_8_non_const_ycoord));
# 1639 "txInterpTest.cu"
__cuda_local_var_37690_8_non_const_f0 = (fin[__cuda_local_var_37688_6_non_const_j]);
# 1640 "txInterpTest.cu"
__cuda_local_var_37690_11_non_const_f1 = (fin[((int)((((unsigned long)(__cuda_local_var_37684_6_non_const_x - 1)) + (((unsigned long)__cuda_local_var_37685_6_non_const_y) * pitch)) + ((1UL * pitch) * 512UL)))]);
# 1641 "txInterpTest.cu"
__cuda_local_var_37690_17_non_const_f3 = (fin[((int)((((unsigned long)(__cuda_local_var_37684_6_non_const_x + 1)) + (((unsigned long)__cuda_local_var_37685_6_non_const_y) * pitch)) + ((3UL * pitch) * 512UL)))]);
# 1642 "txInterpTest.cu"
__cuda_local_var_37690_14_non_const_f2 = (fin[((int)((((unsigned long)__cuda_local_var_37684_6_non_const_x) + (((unsigned long)(__cuda_local_var_37685_6_non_const_y - 1)) * pitch)) + ((2UL * pitch) * 512UL)))]);
# 1643 "txInterpTest.cu"
__cuda_local_var_37690_23_non_const_f5 = (fin[((int)((((unsigned long)(__cuda_local_var_37684_6_non_const_x - 1)) + (((unsigned long)(__cuda_local_var_37685_6_non_const_y - 1)) * pitch)) + ((5UL * pitch) * 512UL)))]);
# 1644 "txInterpTest.cu"
__cuda_local_var_37690_26_non_const_f6 = (fin[((int)((((unsigned long)(__cuda_local_var_37684_6_non_const_x + 1)) + (((unsigned long)(__cuda_local_var_37685_6_non_const_y - 1)) * pitch)) + ((6UL * pitch) * 512UL)))]);
# 1645 "txInterpTest.cu"
__cuda_local_var_37690_20_non_const_f4 = (fin[((int)((((unsigned long)__cuda_local_var_37684_6_non_const_x) + (((unsigned long)(__cuda_local_var_37685_6_non_const_y + 1)) * pitch)) + ((4UL * pitch) * 512UL)))]);
# 1646 "txInterpTest.cu"
__cuda_local_var_37690_29_non_const_f7 = (fin[((int)((((unsigned long)(__cuda_local_var_37684_6_non_const_x + 1)) + (((unsigned long)(__cuda_local_var_37685_6_non_const_y + 1)) * pitch)) + ((7UL * pitch) * 512UL)))]);
# 1647 "txInterpTest.cu"
__cuda_local_var_37690_32_non_const_f8 = (fin[((int)((((unsigned long)(__cuda_local_var_37684_6_non_const_x - 1)) + (((unsigned long)(__cuda_local_var_37685_6_non_const_y + 1)) * pitch)) + ((8UL * pitch) * 512UL)))]);
# 1648 "txInterpTest.cu"
if ((__cuda_local_var_37689_6_non_const_im == 1) || (__cuda_local_var_37689_6_non_const_im == 10))
# 1648 "txInterpTest.cu"
{
# 1649 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37684_6_non_const_x) + (((unsigned long)__cuda_local_var_37685_6_non_const_y) * pitch)) + ((1UL * pitch) * 512UL)))]) = __cuda_local_var_37690_17_non_const_f3;
# 1650 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37684_6_non_const_x) + (((unsigned long)__cuda_local_var_37685_6_non_const_y) * pitch)) + ((2UL * pitch) * 512UL)))]) = __cuda_local_var_37690_20_non_const_f4;
# 1651 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37684_6_non_const_x) + (((unsigned long)__cuda_local_var_37685_6_non_const_y) * pitch)) + ((3UL * pitch) * 512UL)))]) = __cuda_local_var_37690_11_non_const_f1;
# 1652 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37684_6_non_const_x) + (((unsigned long)__cuda_local_var_37685_6_non_const_y) * pitch)) + ((4UL * pitch) * 512UL)))]) = __cuda_local_var_37690_14_non_const_f2;
# 1653 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37684_6_non_const_x) + (((unsigned long)__cuda_local_var_37685_6_non_const_y) * pitch)) + ((5UL * pitch) * 512UL)))]) = __cuda_local_var_37690_29_non_const_f7;
# 1654 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37684_6_non_const_x) + (((unsigned long)__cuda_local_var_37685_6_non_const_y) * pitch)) + ((6UL * pitch) * 512UL)))]) = __cuda_local_var_37690_32_non_const_f8;
# 1655 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37684_6_non_const_x) + (((unsigned long)__cuda_local_var_37685_6_non_const_y) * pitch)) + ((7UL * pitch) * 512UL)))]) = __cuda_local_var_37690_23_non_const_f5;
# 1656 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37684_6_non_const_x) + (((unsigned long)__cuda_local_var_37685_6_non_const_y) * pitch)) + ((8UL * pitch) * 512UL)))]) = __cuda_local_var_37690_26_non_const_f6;
# 1657 "txInterpTest.cu"
}
# 1658 "txInterpTest.cu"
else
# 1658 "txInterpTest.cu"
{
# 1659 "txInterpTest.cu"
if (((const char *)"BGK") == ((const char *)"MRT"))
# 1659 "txInterpTest.cu"
{
# 1660 "txInterpTest.cu"
_Z11mrt_collideRfS_S_S_S_S_S_S_S_f((&__cuda_local_var_37690_8_non_const_f0), (&__cuda_local_var_37690_11_non_const_f1), (&__cuda_local_var_37690_14_non_const_f2), (&__cuda_local_var_37690_17_non_const_f3), (&__cuda_local_var_37690_20_non_const_f4), (&__cuda_local_var_37690_23_non_const_f5), (&__cuda_local_var_37690_26_non_const_f6), (&__cuda_local_var_37690_29_non_const_f7), (&__cuda_local_var_37690_32_non_const_f8), omega);
# 1660 "txInterpTest.cu"
}
# 1660 "txInterpTest.cu"
else
# 1660 "txInterpTest.cu"
{
# 1661 "txInterpTest.cu"
if (1)
# 1661 "txInterpTest.cu"
{
# 1661 "txInterpTest.cu"
 float __T2625;
# 1662 "txInterpTest.cu"
 float __T2626;
# 1663 "txInterpTest.cu"
 float __T2627;
# 1664 "txInterpTest.cu"
 float __T2628;
# 1662 "txInterpTest.cu"
{
# 1662 "txInterpTest.cu"
__T2625 = ((((((((__cuda_local_var_37690_8_non_const_f0 + __cuda_local_var_37690_11_non_const_f1) + __cuda_local_var_37690_14_non_const_f2) + __cuda_local_var_37690_17_non_const_f3) + __cuda_local_var_37690_20_non_const_f4) + __cuda_local_var_37690_23_non_const_f5) + __cuda_local_var_37690_26_non_const_f6) + __cuda_local_var_37690_29_non_const_f7) + __cuda_local_var_37690_32_non_const_f8);
# 1662 "txInterpTest.cu"
__T2626 = (((((__cuda_local_var_37690_11_non_const_f1 - __cuda_local_var_37690_17_non_const_f3) + __cuda_local_var_37690_23_non_const_f5) - __cuda_local_var_37690_26_non_const_f6) - __cuda_local_var_37690_29_non_const_f7) + __cuda_local_var_37690_32_non_const_f8);
# 1662 "txInterpTest.cu"
__T2627 = (((((__cuda_local_var_37690_14_non_const_f2 - __cuda_local_var_37690_20_non_const_f4) + __cuda_local_var_37690_23_non_const_f5) + __cuda_local_var_37690_26_non_const_f6) - __cuda_local_var_37690_29_non_const_f7) - __cuda_local_var_37690_32_non_const_f8);
# 1662 "txInterpTest.cu"
__T2628 = ((__T2626 * __T2626) + (__T2627 * __T2627));
# 1662 "txInterpTest.cu"
__cuda_local_var_37690_8_non_const_f0 = (__cuda_local_var_37690_8_non_const_f0 - (omega * (__cuda_local_var_37690_8_non_const_f0 - ((0.4444444478F) * (__T2625 - ((1.5F) * __T2628))))));
# 1662 "txInterpTest.cu"
__cuda_local_var_37690_11_non_const_f1 = (__cuda_local_var_37690_11_non_const_f1 - (omega * (__cuda_local_var_37690_11_non_const_f1 - ((0.1111111119F) * (((__T2625 + ((3.0F) * __T2626)) + (((4.5F) * __T2626) * __T2626)) - ((1.5F) * __T2628))))));
# 1662 "txInterpTest.cu"
__cuda_local_var_37690_14_non_const_f2 = (__cuda_local_var_37690_14_non_const_f2 - (omega * (__cuda_local_var_37690_14_non_const_f2 - ((0.1111111119F) * (((__T2625 + ((3.0F) * __T2627)) + (((4.5F) * __T2627) * __T2627)) - ((1.5F) * __T2628))))));
# 1662 "txInterpTest.cu"
__cuda_local_var_37690_17_non_const_f3 = (__cuda_local_var_37690_17_non_const_f3 - (omega * (__cuda_local_var_37690_17_non_const_f3 - ((0.1111111119F) * (((__T2625 - ((3.0F) * __T2626)) + (((4.5F) * __T2626) * __T2626)) - ((1.5F) * __T2628))))));
# 1662 "txInterpTest.cu"
__cuda_local_var_37690_20_non_const_f4 = (__cuda_local_var_37690_20_non_const_f4 - (omega * (__cuda_local_var_37690_20_non_const_f4 - ((0.1111111119F) * (((__T2625 - ((3.0F) * __T2627)) + (((4.5F) * __T2627) * __T2627)) - ((1.5F) * __T2628))))));
# 1662 "txInterpTest.cu"
__cuda_local_var_37690_23_non_const_f5 = ((float)(((double)__cuda_local_var_37690_23_non_const_f5) - (((double)omega) * (((double)__cuda_local_var_37690_23_non_const_f5) - ((0.02777777777999999864) * ((double)(((__T2625 + ((3.0F) * (__T2626 + __T2627))) + (((4.5F) * (__T2626 + __T2627)) * (__T2626 + __T2627))) - ((1.5F) * __T2628))))))));
# 1662 "txInterpTest.cu"
__cuda_local_var_37690_26_non_const_f6 = ((float)(((double)__cuda_local_var_37690_26_non_const_f6) - (((double)omega) * (((double)__cuda_local_var_37690_26_non_const_f6) - ((0.02777777777999999864) * ((double)(((__T2625 + ((3.0F) * ((-__T2626) + __T2627))) + (((4.5F) * ((-__T2626) + __T2627)) * ((-__T2626) + __T2627))) - ((1.5F) * __T2628))))))));
# 1662 "txInterpTest.cu"
__cuda_local_var_37690_29_non_const_f7 = ((float)(((double)__cuda_local_var_37690_29_non_const_f7) - (((double)omega) * (((double)__cuda_local_var_37690_29_non_const_f7) - ((0.02777777777999999864) * ((double)(((__T2625 + ((3.0F) * ((-__T2626) - __T2627))) + (((4.5F) * ((-__T2626) - __T2627)) * ((-__T2626) - __T2627))) - ((1.5F) * __T2628))))))));
# 1662 "txInterpTest.cu"
__cuda_local_var_37690_32_non_const_f8 = ((float)(((double)__cuda_local_var_37690_32_non_const_f8) - (((double)omega) * (((double)__cuda_local_var_37690_32_non_const_f8) - ((0.02777777777999999864) * ((double)(((__T2625 + ((3.0F) * (__T2626 - __T2627))) + (((4.5F) * (__T2626 - __T2627)) * (__T2626 - __T2627))) - ((1.5F) * __T2628))))))));
# 1662 "txInterpTest.cu"
}
# 1662 "txInterpTest.cu"
}
# 1662 "txInterpTest.cu"
}
# 1663 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37684_6_non_const_x) + (((unsigned long)__cuda_local_var_37685_6_non_const_y) * pitch)) + ((0UL * pitch) * 512UL)))]) = __cuda_local_var_37690_8_non_const_f0;
# 1664 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37684_6_non_const_x) + (((unsigned long)__cuda_local_var_37685_6_non_const_y) * pitch)) + ((1UL * pitch) * 512UL)))]) = __cuda_local_var_37690_11_non_const_f1;
# 1665 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37684_6_non_const_x) + (((unsigned long)__cuda_local_var_37685_6_non_const_y) * pitch)) + ((2UL * pitch) * 512UL)))]) = __cuda_local_var_37690_14_non_const_f2;
# 1666 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37684_6_non_const_x) + (((unsigned long)__cuda_local_var_37685_6_non_const_y) * pitch)) + ((3UL * pitch) * 512UL)))]) = __cuda_local_var_37690_17_non_const_f3;
# 1667 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37684_6_non_const_x) + (((unsigned long)__cuda_local_var_37685_6_non_const_y) * pitch)) + ((4UL * pitch) * 512UL)))]) = __cuda_local_var_37690_20_non_const_f4;
# 1668 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37684_6_non_const_x) + (((unsigned long)__cuda_local_var_37685_6_non_const_y) * pitch)) + ((5UL * pitch) * 512UL)))]) = __cuda_local_var_37690_23_non_const_f5;
# 1669 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37684_6_non_const_x) + (((unsigned long)__cuda_local_var_37685_6_non_const_y) * pitch)) + ((6UL * pitch) * 512UL)))]) = __cuda_local_var_37690_26_non_const_f6;
# 1670 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37684_6_non_const_x) + (((unsigned long)__cuda_local_var_37685_6_non_const_y) * pitch)) + ((7UL * pitch) * 512UL)))]) = __cuda_local_var_37690_29_non_const_f7;
# 1671 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37684_6_non_const_x) + (((unsigned long)__cuda_local_var_37685_6_non_const_y) * pitch)) + ((8UL * pitch) * 512UL)))]) = __cuda_local_var_37690_32_non_const_f8;
# 1672 "txInterpTest.cu"
}
# 1674 "txInterpTest.cu"
}
# 1674 "txInterpTest.cu"
}}
# 1676 "txInterpTest.cu"
__attribute__((global)) __attribute__((__used__)) void _Z16LR_d_BADC_InterpPfS_fmf(
# 1676 "txInterpTest.cu"
float *fin,
# 1676 "txInterpTest.cu"
float *fout,
# 1677 "txInterpTest.cu"
float omega,
# 1677 "txInterpTest.cu"
size_t pitch,
# 1677 "txInterpTest.cu"
float SF){
# 1677 "txInterpTest.cu"
{
# 1678 "txInterpTest.cu"
{
# 1678 "txInterpTest.cu"
 float __T2629;
# 1679 "txInterpTest.cu"
 float __T2630;
# 1680 "txInterpTest.cu"
 float __T2631;
# 1681 "txInterpTest.cu"
 float __T2632;
# 1679 "txInterpTest.cu"
 int __cuda_local_var_37736_6_non_const_x;
# 1680 "txInterpTest.cu"
 int __cuda_local_var_37737_6_non_const_y;
# 1681 "txInterpTest.cu"
 float __cuda_local_var_37738_8_non_const_xcoord;
# 1682 "txInterpTest.cu"
 float __cuda_local_var_37739_8_non_const_ycoord;
# 1683 "txInterpTest.cu"
 int __cuda_local_var_37740_6_non_const_j;
# 1684 "txInterpTest.cu"
 float __cuda_local_var_37741_8_non_const_f0;
# 1684 "txInterpTest.cu"
 float __cuda_local_var_37741_11_non_const_f1;
# 1684 "txInterpTest.cu"
 float __cuda_local_var_37741_14_non_const_f2;
# 1684 "txInterpTest.cu"
 float __cuda_local_var_37741_17_non_const_f3;
# 1684 "txInterpTest.cu"
 float __cuda_local_var_37741_20_non_const_f4;
# 1684 "txInterpTest.cu"
 float __cuda_local_var_37741_23_non_const_f5;
# 1684 "txInterpTest.cu"
 float __cuda_local_var_37741_26_non_const_f6;
# 1684 "txInterpTest.cu"
 float __cuda_local_var_37741_29_non_const_f7;
# 1684 "txInterpTest.cu"
 float __cuda_local_var_37741_32_non_const_f8;
# 1685 "txInterpTest.cu"
 int __cuda_local_var_37742_6_non_const_im;
# 1679 "txInterpTest.cu"
__cuda_local_var_37736_6_non_const_x = ((int)((threadIdx.x) + ((blockIdx.x) * (blockDim.x))));
# 1680 "txInterpTest.cu"
__cuda_local_var_37737_6_non_const_y = ((int)((threadIdx.y) + ((blockIdx.y) * (blockDim.y))));
# 1681 "txInterpTest.cu"
__cuda_local_var_37738_8_non_const_xcoord = ((float)((415.625) + ((double)(((float)__cuda_local_var_37736_6_non_const_x) * (0.25F)))));
# 1682 "txInterpTest.cu"
__cuda_local_var_37739_8_non_const_ycoord = ((float)((319.625) + ((double)(((float)__cuda_local_var_37737_6_non_const_y) * (0.25F)))));
# 1683 "txInterpTest.cu"
__cuda_local_var_37740_6_non_const_j = ((int)(((unsigned long)__cuda_local_var_37736_6_non_const_x) + (((unsigned long)__cuda_local_var_37737_6_non_const_y) * pitch)));
# 1685 "txInterpTest.cu"
__cuda_local_var_37742_6_non_const_im = (_Z8ImageFcnff(__cuda_local_var_37738_8_non_const_xcoord, __cuda_local_var_37739_8_non_const_ycoord));
# 1688 "txInterpTest.cu"
if ((((__cuda_local_var_37736_6_non_const_x < 4) || (__cuda_local_var_37736_6_non_const_x > 763)) || (__cuda_local_var_37737_6_non_const_y < 4)) || (__cuda_local_var_37737_6_non_const_y > 507))
# 1689 "txInterpTest.cu"
{
# 1689 "txInterpTest.cu"
 __texture_type__ __T2633;
# 1690 "txInterpTest.cu"
 float __T2634;
# 1691 "txInterpTest.cu"
 float __T2635;
# 1692 "txInterpTest.cu"
 float4 __T2636;
# 1693 "txInterpTest.cu"
 float4 __T2637;
# 1694 "txInterpTest.cu"
 __texture_type__ __T2638;
# 1695 "txInterpTest.cu"
 float __T2639;
# 1696 "txInterpTest.cu"
 float __T2640;
# 1697 "txInterpTest.cu"
 float4 __T2641;
# 1698 "txInterpTest.cu"
 float4 __T2642;
# 1699 "txInterpTest.cu"
 __texture_type__ __T2643;
# 1700 "txInterpTest.cu"
 float __T2644;
# 1701 "txInterpTest.cu"
 float __T2645;
# 1702 "txInterpTest.cu"
 float4 __T2646;
# 1703 "txInterpTest.cu"
 float4 __T2647;
# 1704 "txInterpTest.cu"
 __texture_type__ __T2648;
# 1705 "txInterpTest.cu"
 float __T2649;
# 1706 "txInterpTest.cu"
 float __T2650;
# 1707 "txInterpTest.cu"
 float4 __T2651;
# 1708 "txInterpTest.cu"
 float4 __T2652;
# 1709 "txInterpTest.cu"
 __texture_type__ __T2653;
# 1710 "txInterpTest.cu"
 float __T2654;
# 1711 "txInterpTest.cu"
 float __T2655;
# 1712 "txInterpTest.cu"
 float4 __T2656;
# 1713 "txInterpTest.cu"
 float4 __T2657;
# 1714 "txInterpTest.cu"
 __texture_type__ __T2658;
# 1715 "txInterpTest.cu"
 float __T2659;
# 1716 "txInterpTest.cu"
 float __T2660;
# 1717 "txInterpTest.cu"
 float4 __T2661;
# 1718 "txInterpTest.cu"
 float4 __T2662;
# 1719 "txInterpTest.cu"
 __texture_type__ __T2663;
# 1720 "txInterpTest.cu"
 float __T2664;
# 1721 "txInterpTest.cu"
 float __T2665;
# 1722 "txInterpTest.cu"
 float4 __T2666;
# 1723 "txInterpTest.cu"
 float4 __T2667;
# 1724 "txInterpTest.cu"
 __texture_type__ __T2668;
# 1725 "txInterpTest.cu"
 float __T2669;
# 1726 "txInterpTest.cu"
 float __T2670;
# 1727 "txInterpTest.cu"
 float4 __T2671;
# 1728 "txInterpTest.cu"
 float4 __T2672;
# 1729 "txInterpTest.cu"
 __texture_type__ __T2673;
# 1730 "txInterpTest.cu"
 float __T2674;
# 1731 "txInterpTest.cu"
 float __T2675;
# 1732 "txInterpTest.cu"
 float4 __T2676;
# 1733 "txInterpTest.cu"
 float4 __T2677;
# 1701 "txInterpTest.cu"
 float __cuda_local_var_37758_8_non_const_rho;
# 1701 "txInterpTest.cu"
 float __cuda_local_var_37758_12_non_const_u;
# 1701 "txInterpTest.cu"
 float __cuda_local_var_37758_14_non_const_v;
# 1705 "txInterpTest.cu"
 float __cuda_local_var_37762_8_non_const_usqr;
# 1691 "txInterpTest.cu"
__cuda_local_var_37741_8_non_const_f0 = ((((__T2633 = texRef_f0A) , ((void)(__T2634 = (__cuda_local_var_37738_8_non_const_xcoord + (0.5F))))) , ((void)(__T2635 = (__cuda_local_var_37739_8_non_const_ycoord + (0.5F))))) , ((__T2637 = (__ftexfetch2D(__T2633, ((((((__T2636.x) = __T2634) , ((void)((__T2636.y) = __T2635))) , ((void)((__T2636.z) = (0.0F)))) , ((void)((__T2636.w) = (0.0F)))) , __T2636)))) , (__T2637.x)));
# 1692 "txInterpTest.cu"
__cuda_local_var_37741_11_non_const_f1 = ((((__T2638 = texRef_f1A) , ((void)(__T2639 = (__cuda_local_var_37738_8_non_const_xcoord + (0.5F))))) , ((void)(__T2640 = (__cuda_local_var_37739_8_non_const_ycoord + (0.5F))))) , ((__T2642 = (__ftexfetch2D(__T2638, ((((((__T2641.x) = __T2639) , ((void)((__T2641.y) = __T2640))) , ((void)((__T2641.z) = (0.0F)))) , ((void)((__T2641.w) = (0.0F)))) , __T2641)))) , (__T2642.x)));
# 1693 "txInterpTest.cu"
__cuda_local_var_37741_14_non_const_f2 = ((((__T2643 = texRef_f2A) , ((void)(__T2644 = (__cuda_local_var_37738_8_non_const_xcoord + (0.5F))))) , ((void)(__T2645 = (__cuda_local_var_37739_8_non_const_ycoord + (0.5F))))) , ((__T2647 = (__ftexfetch2D(__T2643, ((((((__T2646.x) = __T2644) , ((void)((__T2646.y) = __T2645))) , ((void)((__T2646.z) = (0.0F)))) , ((void)((__T2646.w) = (0.0F)))) , __T2646)))) , (__T2647.x)));
# 1694 "txInterpTest.cu"
__cuda_local_var_37741_17_non_const_f3 = ((((__T2648 = texRef_f3A) , ((void)(__T2649 = (__cuda_local_var_37738_8_non_const_xcoord + (0.5F))))) , ((void)(__T2650 = (__cuda_local_var_37739_8_non_const_ycoord + (0.5F))))) , ((__T2652 = (__ftexfetch2D(__T2648, ((((((__T2651.x) = __T2649) , ((void)((__T2651.y) = __T2650))) , ((void)((__T2651.z) = (0.0F)))) , ((void)((__T2651.w) = (0.0F)))) , __T2651)))) , (__T2652.x)));
# 1695 "txInterpTest.cu"
__cuda_local_var_37741_20_non_const_f4 = ((((__T2653 = texRef_f4A) , ((void)(__T2654 = (__cuda_local_var_37738_8_non_const_xcoord + (0.5F))))) , ((void)(__T2655 = (__cuda_local_var_37739_8_non_const_ycoord + (0.5F))))) , ((__T2657 = (__ftexfetch2D(__T2653, ((((((__T2656.x) = __T2654) , ((void)((__T2656.y) = __T2655))) , ((void)((__T2656.z) = (0.0F)))) , ((void)((__T2656.w) = (0.0F)))) , __T2656)))) , (__T2657.x)));
# 1696 "txInterpTest.cu"
__cuda_local_var_37741_23_non_const_f5 = ((((__T2658 = texRef_f5A) , ((void)(__T2659 = (__cuda_local_var_37738_8_non_const_xcoord + (0.5F))))) , ((void)(__T2660 = (__cuda_local_var_37739_8_non_const_ycoord + (0.5F))))) , ((__T2662 = (__ftexfetch2D(__T2658, ((((((__T2661.x) = __T2659) , ((void)((__T2661.y) = __T2660))) , ((void)((__T2661.z) = (0.0F)))) , ((void)((__T2661.w) = (0.0F)))) , __T2661)))) , (__T2662.x)));
# 1697 "txInterpTest.cu"
__cuda_local_var_37741_26_non_const_f6 = ((((__T2663 = texRef_f6A) , ((void)(__T2664 = (__cuda_local_var_37738_8_non_const_xcoord + (0.5F))))) , ((void)(__T2665 = (__cuda_local_var_37739_8_non_const_ycoord + (0.5F))))) , ((__T2667 = (__ftexfetch2D(__T2663, ((((((__T2666.x) = __T2664) , ((void)((__T2666.y) = __T2665))) , ((void)((__T2666.z) = (0.0F)))) , ((void)((__T2666.w) = (0.0F)))) , __T2666)))) , (__T2667.x)));
# 1698 "txInterpTest.cu"
__cuda_local_var_37741_29_non_const_f7 = ((((__T2668 = texRef_f7A) , ((void)(__T2669 = (__cuda_local_var_37738_8_non_const_xcoord + (0.5F))))) , ((void)(__T2670 = (__cuda_local_var_37739_8_non_const_ycoord + (0.5F))))) , ((__T2672 = (__ftexfetch2D(__T2668, ((((((__T2671.x) = __T2669) , ((void)((__T2671.y) = __T2670))) , ((void)((__T2671.z) = (0.0F)))) , ((void)((__T2671.w) = (0.0F)))) , __T2671)))) , (__T2672.x)));
# 1699 "txInterpTest.cu"
__cuda_local_var_37741_32_non_const_f8 = ((((__T2673 = texRef_f8A) , ((void)(__T2674 = (__cuda_local_var_37738_8_non_const_xcoord + (0.5F))))) , ((void)(__T2675 = (__cuda_local_var_37739_8_non_const_ycoord + (0.5F))))) , ((__T2677 = (__ftexfetch2D(__T2673, ((((((__T2676.x) = __T2674) , ((void)((__T2676.y) = __T2675))) , ((void)((__T2676.z) = (0.0F)))) , ((void)((__T2676.w) = (0.0F)))) , __T2676)))) , (__T2677.x)));
# 1702 "txInterpTest.cu"
__cuda_local_var_37758_8_non_const_rho = ((((((((__cuda_local_var_37741_8_non_const_f0 + __cuda_local_var_37741_11_non_const_f1) + __cuda_local_var_37741_14_non_const_f2) + __cuda_local_var_37741_17_non_const_f3) + __cuda_local_var_37741_20_non_const_f4) + __cuda_local_var_37741_23_non_const_f5) + __cuda_local_var_37741_26_non_const_f6) + __cuda_local_var_37741_29_non_const_f7) + __cuda_local_var_37741_32_non_const_f8);
# 1703 "txInterpTest.cu"
__cuda_local_var_37758_12_non_const_u = (((((__cuda_local_var_37741_11_non_const_f1 - __cuda_local_var_37741_17_non_const_f3) + __cuda_local_var_37741_23_non_const_f5) - __cuda_local_var_37741_26_non_const_f6) - __cuda_local_var_37741_29_non_const_f7) + __cuda_local_var_37741_32_non_const_f8);
# 1704 "txInterpTest.cu"
__cuda_local_var_37758_14_non_const_v = (((((__cuda_local_var_37741_14_non_const_f2 - __cuda_local_var_37741_20_non_const_f4) + __cuda_local_var_37741_23_non_const_f5) + __cuda_local_var_37741_26_non_const_f6) - __cuda_local_var_37741_29_non_const_f7) - __cuda_local_var_37741_32_non_const_f8);
# 1705 "txInterpTest.cu"
__cuda_local_var_37762_8_non_const_usqr = ((__cuda_local_var_37758_12_non_const_u * __cuda_local_var_37758_12_non_const_u) + (__cuda_local_var_37758_14_non_const_v * __cuda_local_var_37758_14_non_const_v));
# 1707 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37736_6_non_const_x) + (((unsigned long)__cuda_local_var_37737_6_non_const_y) * pitch)) + ((0UL * pitch) * 512UL)))]) = ((SF * __cuda_local_var_37741_8_non_const_f0) + (((1.0F) - SF) * ((0.4444444478F) * (__cuda_local_var_37758_8_non_const_rho - ((1.5F) * __cuda_local_var_37762_8_non_const_usqr)))));
# 1708 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37736_6_non_const_x) + (((unsigned long)__cuda_local_var_37737_6_non_const_y) * pitch)) + ((1UL * pitch) * 512UL)))]) = ((SF * __cuda_local_var_37741_11_non_const_f1) + (((1.0F) - SF) * ((0.1111111119F) * (((__cuda_local_var_37758_8_non_const_rho + ((3.0F) * __cuda_local_var_37758_12_non_const_u)) + (((4.5F) * __cuda_local_var_37758_12_non_const_u) * __cuda_local_var_37758_12_non_const_u)) - ((1.5F) * __cuda_local_var_37762_8_non_const_usqr)))));
# 1709 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37736_6_non_const_x) + (((unsigned long)__cuda_local_var_37737_6_non_const_y) * pitch)) + ((2UL * pitch) * 512UL)))]) = ((SF * __cuda_local_var_37741_14_non_const_f2) + (((1.0F) - SF) * ((0.1111111119F) * (((__cuda_local_var_37758_8_non_const_rho + ((3.0F) * __cuda_local_var_37758_14_non_const_v)) + (((4.5F) * __cuda_local_var_37758_14_non_const_v) * __cuda_local_var_37758_14_non_const_v)) - ((1.5F) * __cuda_local_var_37762_8_non_const_usqr)))));
# 1710 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37736_6_non_const_x) + (((unsigned long)__cuda_local_var_37737_6_non_const_y) * pitch)) + ((3UL * pitch) * 512UL)))]) = ((SF * __cuda_local_var_37741_17_non_const_f3) + (((1.0F) - SF) * ((0.1111111119F) * (((__cuda_local_var_37758_8_non_const_rho - ((3.0F) * __cuda_local_var_37758_12_non_const_u)) + (((4.5F) * __cuda_local_var_37758_12_non_const_u) * __cuda_local_var_37758_12_non_const_u)) - ((1.5F) * __cuda_local_var_37762_8_non_const_usqr)))));
# 1711 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37736_6_non_const_x) + (((unsigned long)__cuda_local_var_37737_6_non_const_y) * pitch)) + ((4UL * pitch) * 512UL)))]) = ((SF * __cuda_local_var_37741_20_non_const_f4) + (((1.0F) - SF) * ((0.1111111119F) * (((__cuda_local_var_37758_8_non_const_rho - ((3.0F) * __cuda_local_var_37758_14_non_const_v)) + (((4.5F) * __cuda_local_var_37758_14_non_const_v) * __cuda_local_var_37758_14_non_const_v)) - ((1.5F) * __cuda_local_var_37762_8_non_const_usqr)))));
# 1712 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37736_6_non_const_x) + (((unsigned long)__cuda_local_var_37737_6_non_const_y) * pitch)) + ((5UL * pitch) * 512UL)))]) = ((float)(((double)(SF * __cuda_local_var_37741_23_non_const_f5)) + (((double)((1.0F) - SF)) * ((0.02777777777999999864) * ((double)(((__cuda_local_var_37758_8_non_const_rho + ((3.0F) * (__cuda_local_var_37758_12_non_const_u + __cuda_local_var_37758_14_non_const_v))) + (((4.5F) * (__cuda_local_var_37758_12_non_const_u + __cuda_local_var_37758_14_non_const_v)) * (__cuda_local_var_37758_12_non_const_u + __cuda_local_var_37758_14_non_const_v))) - ((1.5F) * __cuda_local_var_37762_8_non_const_usqr)))))));
# 1713 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37736_6_non_const_x) + (((unsigned long)__cuda_local_var_37737_6_non_const_y) * pitch)) + ((6UL * pitch) * 512UL)))]) = ((float)(((double)(SF * __cuda_local_var_37741_26_non_const_f6)) + (((double)((1.0F) - SF)) * ((0.02777777777999999864) * ((double)(((__cuda_local_var_37758_8_non_const_rho + ((3.0F) * ((-__cuda_local_var_37758_12_non_const_u) + __cuda_local_var_37758_14_non_const_v))) + (((4.5F) * ((-__cuda_local_var_37758_12_non_const_u) + __cuda_local_var_37758_14_non_const_v)) * ((-__cuda_local_var_37758_12_non_const_u) + __cuda_local_var_37758_14_non_const_v))) - ((1.5F) * __cuda_local_var_37762_8_non_const_usqr)))))));
# 1714 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37736_6_non_const_x) + (((unsigned long)__cuda_local_var_37737_6_non_const_y) * pitch)) + ((7UL * pitch) * 512UL)))]) = ((float)(((double)(SF * __cuda_local_var_37741_29_non_const_f7)) + (((double)((1.0F) - SF)) * ((0.02777777777999999864) * ((double)(((__cuda_local_var_37758_8_non_const_rho + ((3.0F) * ((-__cuda_local_var_37758_12_non_const_u) - __cuda_local_var_37758_14_non_const_v))) + (((4.5F) * ((-__cuda_local_var_37758_12_non_const_u) - __cuda_local_var_37758_14_non_const_v)) * ((-__cuda_local_var_37758_12_non_const_u) - __cuda_local_var_37758_14_non_const_v))) - ((1.5F) * __cuda_local_var_37762_8_non_const_usqr)))))));
# 1715 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37736_6_non_const_x) + (((unsigned long)__cuda_local_var_37737_6_non_const_y) * pitch)) + ((8UL * pitch) * 512UL)))]) = ((float)(((double)(SF * __cuda_local_var_37741_32_non_const_f8)) + (((double)((1.0F) - SF)) * ((0.02777777777999999864) * ((double)(((__cuda_local_var_37758_8_non_const_rho + ((3.0F) * (__cuda_local_var_37758_12_non_const_u - __cuda_local_var_37758_14_non_const_v))) + (((4.5F) * (__cuda_local_var_37758_12_non_const_u - __cuda_local_var_37758_14_non_const_v)) * (__cuda_local_var_37758_12_non_const_u - __cuda_local_var_37758_14_non_const_v))) - ((1.5F) * __cuda_local_var_37762_8_non_const_usqr)))))));
# 1735 "txInterpTest.cu"
}
# 1736 "txInterpTest.cu"
else
# 1736 "txInterpTest.cu"
{
# 1737 "txInterpTest.cu"
__cuda_local_var_37741_8_non_const_f0 = (fin[__cuda_local_var_37740_6_non_const_j]);
# 1738 "txInterpTest.cu"
__cuda_local_var_37741_11_non_const_f1 = (fin[((int)((((unsigned long)(__cuda_local_var_37736_6_non_const_x - 1)) + (((unsigned long)__cuda_local_var_37737_6_non_const_y) * pitch)) + ((1UL * pitch) * 512UL)))]);
# 1739 "txInterpTest.cu"
__cuda_local_var_37741_17_non_const_f3 = (fin[((int)((((unsigned long)(__cuda_local_var_37736_6_non_const_x + 1)) + (((unsigned long)__cuda_local_var_37737_6_non_const_y) * pitch)) + ((3UL * pitch) * 512UL)))]);
# 1740 "txInterpTest.cu"
__cuda_local_var_37741_14_non_const_f2 = (fin[((int)((((unsigned long)__cuda_local_var_37736_6_non_const_x) + (((unsigned long)(__cuda_local_var_37737_6_non_const_y - 1)) * pitch)) + ((2UL * pitch) * 512UL)))]);
# 1741 "txInterpTest.cu"
__cuda_local_var_37741_23_non_const_f5 = (fin[((int)((((unsigned long)(__cuda_local_var_37736_6_non_const_x - 1)) + (((unsigned long)(__cuda_local_var_37737_6_non_const_y - 1)) * pitch)) + ((5UL * pitch) * 512UL)))]);
# 1742 "txInterpTest.cu"
__cuda_local_var_37741_26_non_const_f6 = (fin[((int)((((unsigned long)(__cuda_local_var_37736_6_non_const_x + 1)) + (((unsigned long)(__cuda_local_var_37737_6_non_const_y - 1)) * pitch)) + ((6UL * pitch) * 512UL)))]);
# 1743 "txInterpTest.cu"
__cuda_local_var_37741_20_non_const_f4 = (fin[((int)((((unsigned long)__cuda_local_var_37736_6_non_const_x) + (((unsigned long)(__cuda_local_var_37737_6_non_const_y + 1)) * pitch)) + ((4UL * pitch) * 512UL)))]);
# 1744 "txInterpTest.cu"
__cuda_local_var_37741_29_non_const_f7 = (fin[((int)((((unsigned long)(__cuda_local_var_37736_6_non_const_x + 1)) + (((unsigned long)(__cuda_local_var_37737_6_non_const_y + 1)) * pitch)) + ((7UL * pitch) * 512UL)))]);
# 1745 "txInterpTest.cu"
__cuda_local_var_37741_32_non_const_f8 = (fin[((int)((((unsigned long)(__cuda_local_var_37736_6_non_const_x - 1)) + (((unsigned long)(__cuda_local_var_37737_6_non_const_y + 1)) * pitch)) + ((8UL * pitch) * 512UL)))]);
# 1746 "txInterpTest.cu"
if ((__cuda_local_var_37742_6_non_const_im == 1) || (__cuda_local_var_37742_6_non_const_im == 10))
# 1746 "txInterpTest.cu"
{
# 1747 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37736_6_non_const_x) + (((unsigned long)__cuda_local_var_37737_6_non_const_y) * pitch)) + ((1UL * pitch) * 512UL)))]) = __cuda_local_var_37741_17_non_const_f3;
# 1748 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37736_6_non_const_x) + (((unsigned long)__cuda_local_var_37737_6_non_const_y) * pitch)) + ((2UL * pitch) * 512UL)))]) = __cuda_local_var_37741_20_non_const_f4;
# 1749 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37736_6_non_const_x) + (((unsigned long)__cuda_local_var_37737_6_non_const_y) * pitch)) + ((3UL * pitch) * 512UL)))]) = __cuda_local_var_37741_11_non_const_f1;
# 1750 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37736_6_non_const_x) + (((unsigned long)__cuda_local_var_37737_6_non_const_y) * pitch)) + ((4UL * pitch) * 512UL)))]) = __cuda_local_var_37741_14_non_const_f2;
# 1751 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37736_6_non_const_x) + (((unsigned long)__cuda_local_var_37737_6_non_const_y) * pitch)) + ((5UL * pitch) * 512UL)))]) = __cuda_local_var_37741_29_non_const_f7;
# 1752 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37736_6_non_const_x) + (((unsigned long)__cuda_local_var_37737_6_non_const_y) * pitch)) + ((6UL * pitch) * 512UL)))]) = __cuda_local_var_37741_32_non_const_f8;
# 1753 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37736_6_non_const_x) + (((unsigned long)__cuda_local_var_37737_6_non_const_y) * pitch)) + ((7UL * pitch) * 512UL)))]) = __cuda_local_var_37741_23_non_const_f5;
# 1754 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37736_6_non_const_x) + (((unsigned long)__cuda_local_var_37737_6_non_const_y) * pitch)) + ((8UL * pitch) * 512UL)))]) = __cuda_local_var_37741_26_non_const_f6;
# 1755 "txInterpTest.cu"
}
# 1756 "txInterpTest.cu"
else
# 1756 "txInterpTest.cu"
{
# 1757 "txInterpTest.cu"
if (((const char *)"BGK") == ((const char *)"MRT"))
# 1757 "txInterpTest.cu"
{
# 1758 "txInterpTest.cu"
_Z11mrt_collideRfS_S_S_S_S_S_S_S_f((&__cuda_local_var_37741_8_non_const_f0), (&__cuda_local_var_37741_11_non_const_f1), (&__cuda_local_var_37741_14_non_const_f2), (&__cuda_local_var_37741_17_non_const_f3), (&__cuda_local_var_37741_20_non_const_f4), (&__cuda_local_var_37741_23_non_const_f5), (&__cuda_local_var_37741_26_non_const_f6), (&__cuda_local_var_37741_29_non_const_f7), (&__cuda_local_var_37741_32_non_const_f8), omega);
# 1758 "txInterpTest.cu"
}
# 1758 "txInterpTest.cu"
else
# 1758 "txInterpTest.cu"
{
# 1759 "txInterpTest.cu"
if (1)
# 1759 "txInterpTest.cu"
{
# 1760 "txInterpTest.cu"
{
# 1760 "txInterpTest.cu"
__T2629 = ((((((((__cuda_local_var_37741_8_non_const_f0 + __cuda_local_var_37741_11_non_const_f1) + __cuda_local_var_37741_14_non_const_f2) + __cuda_local_var_37741_17_non_const_f3) + __cuda_local_var_37741_20_non_const_f4) + __cuda_local_var_37741_23_non_const_f5) + __cuda_local_var_37741_26_non_const_f6) + __cuda_local_var_37741_29_non_const_f7) + __cuda_local_var_37741_32_non_const_f8);
# 1760 "txInterpTest.cu"
__T2630 = (((((__cuda_local_var_37741_11_non_const_f1 - __cuda_local_var_37741_17_non_const_f3) + __cuda_local_var_37741_23_non_const_f5) - __cuda_local_var_37741_26_non_const_f6) - __cuda_local_var_37741_29_non_const_f7) + __cuda_local_var_37741_32_non_const_f8);
# 1760 "txInterpTest.cu"
__T2631 = (((((__cuda_local_var_37741_14_non_const_f2 - __cuda_local_var_37741_20_non_const_f4) + __cuda_local_var_37741_23_non_const_f5) + __cuda_local_var_37741_26_non_const_f6) - __cuda_local_var_37741_29_non_const_f7) - __cuda_local_var_37741_32_non_const_f8);
# 1760 "txInterpTest.cu"
__T2632 = ((__T2630 * __T2630) + (__T2631 * __T2631));
# 1760 "txInterpTest.cu"
__cuda_local_var_37741_8_non_const_f0 = (__cuda_local_var_37741_8_non_const_f0 - (omega * (__cuda_local_var_37741_8_non_const_f0 - ((0.4444444478F) * (__T2629 - ((1.5F) * __T2632))))));
# 1760 "txInterpTest.cu"
__cuda_local_var_37741_11_non_const_f1 = (__cuda_local_var_37741_11_non_const_f1 - (omega * (__cuda_local_var_37741_11_non_const_f1 - ((0.1111111119F) * (((__T2629 + ((3.0F) * __T2630)) + (((4.5F) * __T2630) * __T2630)) - ((1.5F) * __T2632))))));
# 1760 "txInterpTest.cu"
__cuda_local_var_37741_14_non_const_f2 = (__cuda_local_var_37741_14_non_const_f2 - (omega * (__cuda_local_var_37741_14_non_const_f2 - ((0.1111111119F) * (((__T2629 + ((3.0F) * __T2631)) + (((4.5F) * __T2631) * __T2631)) - ((1.5F) * __T2632))))));
# 1760 "txInterpTest.cu"
__cuda_local_var_37741_17_non_const_f3 = (__cuda_local_var_37741_17_non_const_f3 - (omega * (__cuda_local_var_37741_17_non_const_f3 - ((0.1111111119F) * (((__T2629 - ((3.0F) * __T2630)) + (((4.5F) * __T2630) * __T2630)) - ((1.5F) * __T2632))))));
# 1760 "txInterpTest.cu"
__cuda_local_var_37741_20_non_const_f4 = (__cuda_local_var_37741_20_non_const_f4 - (omega * (__cuda_local_var_37741_20_non_const_f4 - ((0.1111111119F) * (((__T2629 - ((3.0F) * __T2631)) + (((4.5F) * __T2631) * __T2631)) - ((1.5F) * __T2632))))));
# 1760 "txInterpTest.cu"
__cuda_local_var_37741_23_non_const_f5 = ((float)(((double)__cuda_local_var_37741_23_non_const_f5) - (((double)omega) * (((double)__cuda_local_var_37741_23_non_const_f5) - ((0.02777777777999999864) * ((double)(((__T2629 + ((3.0F) * (__T2630 + __T2631))) + (((4.5F) * (__T2630 + __T2631)) * (__T2630 + __T2631))) - ((1.5F) * __T2632))))))));
# 1760 "txInterpTest.cu"
__cuda_local_var_37741_26_non_const_f6 = ((float)(((double)__cuda_local_var_37741_26_non_const_f6) - (((double)omega) * (((double)__cuda_local_var_37741_26_non_const_f6) - ((0.02777777777999999864) * ((double)(((__T2629 + ((3.0F) * ((-__T2630) + __T2631))) + (((4.5F) * ((-__T2630) + __T2631)) * ((-__T2630) + __T2631))) - ((1.5F) * __T2632))))))));
# 1760 "txInterpTest.cu"
__cuda_local_var_37741_29_non_const_f7 = ((float)(((double)__cuda_local_var_37741_29_non_const_f7) - (((double)omega) * (((double)__cuda_local_var_37741_29_non_const_f7) - ((0.02777777777999999864) * ((double)(((__T2629 + ((3.0F) * ((-__T2630) - __T2631))) + (((4.5F) * ((-__T2630) - __T2631)) * ((-__T2630) - __T2631))) - ((1.5F) * __T2632))))))));
# 1760 "txInterpTest.cu"
__cuda_local_var_37741_32_non_const_f8 = ((float)(((double)__cuda_local_var_37741_32_non_const_f8) - (((double)omega) * (((double)__cuda_local_var_37741_32_non_const_f8) - ((0.02777777777999999864) * ((double)(((__T2629 + ((3.0F) * (__T2630 - __T2631))) + (((4.5F) * (__T2630 - __T2631)) * (__T2630 - __T2631))) - ((1.5F) * __T2632))))))));
# 1760 "txInterpTest.cu"
}
# 1760 "txInterpTest.cu"
}
# 1760 "txInterpTest.cu"
}
# 1762 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37736_6_non_const_x) + (((unsigned long)__cuda_local_var_37737_6_non_const_y) * pitch)) + ((0UL * pitch) * 512UL)))]) = __cuda_local_var_37741_8_non_const_f0;
# 1763 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37736_6_non_const_x) + (((unsigned long)__cuda_local_var_37737_6_non_const_y) * pitch)) + ((1UL * pitch) * 512UL)))]) = __cuda_local_var_37741_11_non_const_f1;
# 1764 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37736_6_non_const_x) + (((unsigned long)__cuda_local_var_37737_6_non_const_y) * pitch)) + ((2UL * pitch) * 512UL)))]) = __cuda_local_var_37741_14_non_const_f2;
# 1765 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37736_6_non_const_x) + (((unsigned long)__cuda_local_var_37737_6_non_const_y) * pitch)) + ((3UL * pitch) * 512UL)))]) = __cuda_local_var_37741_17_non_const_f3;
# 1766 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37736_6_non_const_x) + (((unsigned long)__cuda_local_var_37737_6_non_const_y) * pitch)) + ((4UL * pitch) * 512UL)))]) = __cuda_local_var_37741_20_non_const_f4;
# 1767 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37736_6_non_const_x) + (((unsigned long)__cuda_local_var_37737_6_non_const_y) * pitch)) + ((5UL * pitch) * 512UL)))]) = __cuda_local_var_37741_23_non_const_f5;
# 1768 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37736_6_non_const_x) + (((unsigned long)__cuda_local_var_37737_6_non_const_y) * pitch)) + ((6UL * pitch) * 512UL)))]) = __cuda_local_var_37741_26_non_const_f6;
# 1769 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37736_6_non_const_x) + (((unsigned long)__cuda_local_var_37737_6_non_const_y) * pitch)) + ((7UL * pitch) * 512UL)))]) = __cuda_local_var_37741_29_non_const_f7;
# 1770 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37736_6_non_const_x) + (((unsigned long)__cuda_local_var_37737_6_non_const_y) * pitch)) + ((8UL * pitch) * 512UL)))]) = __cuda_local_var_37741_32_non_const_f8;
# 1771 "txInterpTest.cu"
}
# 1772 "txInterpTest.cu"
}
# 1773 "txInterpTest.cu"
}
# 1773 "txInterpTest.cu"
}}
# 1774 "txInterpTest.cu"
__attribute__((global)) __attribute__((__used__)) void _Z12mrt_d_singlePfS_fm(
# 1774 "txInterpTest.cu"
float *fA,
# 1774 "txInterpTest.cu"
float *fB,
# 1775 "txInterpTest.cu"
float omega,
# 1775 "txInterpTest.cu"
size_t pitch){
# 1775 "txInterpTest.cu"
{
# 1776 "txInterpTest.cu"
{
# 1777 "txInterpTest.cu"
 int __cuda_local_var_37816_6_non_const_x;
# 1778 "txInterpTest.cu"
 int __cuda_local_var_37817_6_non_const_y;
# 1779 "txInterpTest.cu"
 int __cuda_local_var_37818_6_non_const_j;
# 1780 "txInterpTest.cu"
 int __cuda_local_var_37819_6_non_const_im;
# 1781 "txInterpTest.cu"
 float __cuda_local_var_37820_8_non_const_f0;
# 1781 "txInterpTest.cu"
 float __cuda_local_var_37820_11_non_const_f1;
# 1781 "txInterpTest.cu"
 float __cuda_local_var_37820_14_non_const_f2;
# 1781 "txInterpTest.cu"
 float __cuda_local_var_37820_17_non_const_f3;
# 1781 "txInterpTest.cu"
 float __cuda_local_var_37820_20_non_const_f4;
# 1781 "txInterpTest.cu"
 float __cuda_local_var_37820_23_non_const_f5;
# 1781 "txInterpTest.cu"
 float __cuda_local_var_37820_26_non_const_f6;
# 1781 "txInterpTest.cu"
 float __cuda_local_var_37820_29_non_const_f7;
# 1781 "txInterpTest.cu"
 float __cuda_local_var_37820_32_non_const_f8;
# 1777 "txInterpTest.cu"
__cuda_local_var_37816_6_non_const_x = ((int)((threadIdx.x) + ((blockIdx.x) * (blockDim.x))));
# 1778 "txInterpTest.cu"
__cuda_local_var_37817_6_non_const_y = ((int)((threadIdx.y) + ((blockIdx.y) * (blockDim.y))));
# 1779 "txInterpTest.cu"
__cuda_local_var_37818_6_non_const_j = ((int)(((unsigned long)__cuda_local_var_37816_6_non_const_x) + (((unsigned long)__cuda_local_var_37817_6_non_const_y) * pitch)));
# 1780 "txInterpTest.cu"
__cuda_local_var_37819_6_non_const_im = (_Z8ImageFcnii(__cuda_local_var_37816_6_non_const_x, __cuda_local_var_37817_6_non_const_y));
# 1786 "txInterpTest.cu"
__cuda_local_var_37820_8_non_const_f0 = (fA[__cuda_local_var_37818_6_non_const_j]);
# 1787 "txInterpTest.cu"
__cuda_local_var_37820_11_non_const_f1 = (fA[((int)((((unsigned long)(__cuda_local_var_37816_6_non_const_x - 1)) + (((unsigned long)__cuda_local_var_37817_6_non_const_y) * pitch)) + ((1UL * pitch) * 768UL)))]);
# 1788 "txInterpTest.cu"
__cuda_local_var_37820_17_non_const_f3 = (fA[((int)((((unsigned long)(__cuda_local_var_37816_6_non_const_x + 1)) + (((unsigned long)__cuda_local_var_37817_6_non_const_y) * pitch)) + ((3UL * pitch) * 768UL)))]);
# 1789 "txInterpTest.cu"
__cuda_local_var_37820_14_non_const_f2 = (fA[((int)((((unsigned long)__cuda_local_var_37816_6_non_const_x) + (((unsigned long)(__cuda_local_var_37817_6_non_const_y - 1)) * pitch)) + ((2UL * pitch) * 768UL)))]);
# 1790 "txInterpTest.cu"
__cuda_local_var_37820_23_non_const_f5 = (fA[((int)((((unsigned long)(__cuda_local_var_37816_6_non_const_x - 1)) + (((unsigned long)(__cuda_local_var_37817_6_non_const_y - 1)) * pitch)) + ((5UL * pitch) * 768UL)))]);
# 1791 "txInterpTest.cu"
__cuda_local_var_37820_26_non_const_f6 = (fA[((int)((((unsigned long)(__cuda_local_var_37816_6_non_const_x + 1)) + (((unsigned long)(__cuda_local_var_37817_6_non_const_y - 1)) * pitch)) + ((6UL * pitch) * 768UL)))]);
# 1792 "txInterpTest.cu"
__cuda_local_var_37820_20_non_const_f4 = (fA[((int)((((unsigned long)__cuda_local_var_37816_6_non_const_x) + (((unsigned long)(__cuda_local_var_37817_6_non_const_y + 1)) * pitch)) + ((4UL * pitch) * 768UL)))]);
# 1793 "txInterpTest.cu"
__cuda_local_var_37820_29_non_const_f7 = (fA[((int)((((unsigned long)(__cuda_local_var_37816_6_non_const_x + 1)) + (((unsigned long)(__cuda_local_var_37817_6_non_const_y + 1)) * pitch)) + ((7UL * pitch) * 768UL)))]);
# 1794 "txInterpTest.cu"
if (__cuda_local_var_37817_6_non_const_y != 767)
# 1794 "txInterpTest.cu"
{
# 1795 "txInterpTest.cu"
__cuda_local_var_37820_32_non_const_f8 = (fA[((int)((((unsigned long)(__cuda_local_var_37816_6_non_const_x - 1)) + (((unsigned long)(__cuda_local_var_37817_6_non_const_y + 1)) * pitch)) + ((8UL * pitch) * 768UL)))]);
# 1795 "txInterpTest.cu"
}
# 1805 "txInterpTest.cu"
if ((__cuda_local_var_37819_6_non_const_im == 1) || (__cuda_local_var_37819_6_non_const_im == 10))
# 1805 "txInterpTest.cu"
{
# 1807 "txInterpTest.cu"
(fB[((int)((((unsigned long)__cuda_local_var_37816_6_non_const_x) + (((unsigned long)__cuda_local_var_37817_6_non_const_y) * pitch)) + ((1UL * pitch) * 768UL)))]) = __cuda_local_var_37820_17_non_const_f3;
# 1808 "txInterpTest.cu"
(fB[((int)((((unsigned long)__cuda_local_var_37816_6_non_const_x) + (((unsigned long)__cuda_local_var_37817_6_non_const_y) * pitch)) + ((2UL * pitch) * 768UL)))]) = __cuda_local_var_37820_20_non_const_f4;
# 1809 "txInterpTest.cu"
(fB[((int)((((unsigned long)__cuda_local_var_37816_6_non_const_x) + (((unsigned long)__cuda_local_var_37817_6_non_const_y) * pitch)) + ((3UL * pitch) * 768UL)))]) = __cuda_local_var_37820_11_non_const_f1;
# 1810 "txInterpTest.cu"
(fB[((int)((((unsigned long)__cuda_local_var_37816_6_non_const_x) + (((unsigned long)__cuda_local_var_37817_6_non_const_y) * pitch)) + ((4UL * pitch) * 768UL)))]) = __cuda_local_var_37820_14_non_const_f2;
# 1811 "txInterpTest.cu"
(fB[((int)((((unsigned long)__cuda_local_var_37816_6_non_const_x) + (((unsigned long)__cuda_local_var_37817_6_non_const_y) * pitch)) + ((5UL * pitch) * 768UL)))]) = __cuda_local_var_37820_29_non_const_f7;
# 1812 "txInterpTest.cu"
(fB[((int)((((unsigned long)__cuda_local_var_37816_6_non_const_x) + (((unsigned long)__cuda_local_var_37817_6_non_const_y) * pitch)) + ((6UL * pitch) * 768UL)))]) = __cuda_local_var_37820_32_non_const_f8;
# 1813 "txInterpTest.cu"
(fB[((int)((((unsigned long)__cuda_local_var_37816_6_non_const_x) + (((unsigned long)__cuda_local_var_37817_6_non_const_y) * pitch)) + ((7UL * pitch) * 768UL)))]) = __cuda_local_var_37820_23_non_const_f5;
# 1814 "txInterpTest.cu"
(fB[((int)((((unsigned long)__cuda_local_var_37816_6_non_const_x) + (((unsigned long)__cuda_local_var_37817_6_non_const_y) * pitch)) + ((8UL * pitch) * 768UL)))]) = __cuda_local_var_37820_26_non_const_f6;
# 1815 "txInterpTest.cu"
}
# 1816 "txInterpTest.cu"
else
# 1816 "txInterpTest.cu"
{
# 1818 "txInterpTest.cu"
_Z10boundariesRfS_S_S_S_S_S_S_S_ii((&__cuda_local_var_37820_8_non_const_f0), (&__cuda_local_var_37820_11_non_const_f1), (&__cuda_local_var_37820_14_non_const_f2), (&__cuda_local_var_37820_17_non_const_f3), (&__cuda_local_var_37820_20_non_const_f4), (&__cuda_local_var_37820_23_non_const_f5), (&__cuda_local_var_37820_26_non_const_f6), (&__cuda_local_var_37820_29_non_const_f7), (&__cuda_local_var_37820_32_non_const_f8), __cuda_local_var_37817_6_non_const_y, __cuda_local_var_37819_6_non_const_im);
# 1820 "txInterpTest.cu"
if (((const char *)"BGK") == ((const char *)"MRT"))
# 1820 "txInterpTest.cu"
{
# 1821 "txInterpTest.cu"
_Z11mrt_collideRfS_S_S_S_S_S_S_S_f((&__cuda_local_var_37820_8_non_const_f0), (&__cuda_local_var_37820_11_non_const_f1), (&__cuda_local_var_37820_14_non_const_f2), (&__cuda_local_var_37820_17_non_const_f3), (&__cuda_local_var_37820_20_non_const_f4), (&__cuda_local_var_37820_23_non_const_f5), (&__cuda_local_var_37820_26_non_const_f6), (&__cuda_local_var_37820_29_non_const_f7), (&__cuda_local_var_37820_32_non_const_f8), omega);
# 1821 "txInterpTest.cu"
}
# 1821 "txInterpTest.cu"
else
# 1821 "txInterpTest.cu"
{
# 1822 "txInterpTest.cu"
if (1)
# 1822 "txInterpTest.cu"
{
# 1822 "txInterpTest.cu"
 float __T2678;
# 1823 "txInterpTest.cu"
 float __T2679;
# 1824 "txInterpTest.cu"
 float __T2680;
# 1825 "txInterpTest.cu"
 float __T2681;
# 1823 "txInterpTest.cu"
{
# 1823 "txInterpTest.cu"
__T2678 = ((((((((__cuda_local_var_37820_8_non_const_f0 + __cuda_local_var_37820_11_non_const_f1) + __cuda_local_var_37820_14_non_const_f2) + __cuda_local_var_37820_17_non_const_f3) + __cuda_local_var_37820_20_non_const_f4) + __cuda_local_var_37820_23_non_const_f5) + __cuda_local_var_37820_26_non_const_f6) + __cuda_local_var_37820_29_non_const_f7) + __cuda_local_var_37820_32_non_const_f8);
# 1823 "txInterpTest.cu"
__T2679 = (((((__cuda_local_var_37820_11_non_const_f1 - __cuda_local_var_37820_17_non_const_f3) + __cuda_local_var_37820_23_non_const_f5) - __cuda_local_var_37820_26_non_const_f6) - __cuda_local_var_37820_29_non_const_f7) + __cuda_local_var_37820_32_non_const_f8);
# 1823 "txInterpTest.cu"
__T2680 = (((((__cuda_local_var_37820_14_non_const_f2 - __cuda_local_var_37820_20_non_const_f4) + __cuda_local_var_37820_23_non_const_f5) + __cuda_local_var_37820_26_non_const_f6) - __cuda_local_var_37820_29_non_const_f7) - __cuda_local_var_37820_32_non_const_f8);
# 1823 "txInterpTest.cu"
__T2681 = ((__T2679 * __T2679) + (__T2680 * __T2680));
# 1823 "txInterpTest.cu"
__cuda_local_var_37820_8_non_const_f0 = (__cuda_local_var_37820_8_non_const_f0 - (omega * (__cuda_local_var_37820_8_non_const_f0 - ((0.4444444478F) * (__T2678 - ((1.5F) * __T2681))))));
# 1823 "txInterpTest.cu"
__cuda_local_var_37820_11_non_const_f1 = (__cuda_local_var_37820_11_non_const_f1 - (omega * (__cuda_local_var_37820_11_non_const_f1 - ((0.1111111119F) * (((__T2678 + ((3.0F) * __T2679)) + (((4.5F) * __T2679) * __T2679)) - ((1.5F) * __T2681))))));
# 1823 "txInterpTest.cu"
__cuda_local_var_37820_14_non_const_f2 = (__cuda_local_var_37820_14_non_const_f2 - (omega * (__cuda_local_var_37820_14_non_const_f2 - ((0.1111111119F) * (((__T2678 + ((3.0F) * __T2680)) + (((4.5F) * __T2680) * __T2680)) - ((1.5F) * __T2681))))));
# 1823 "txInterpTest.cu"
__cuda_local_var_37820_17_non_const_f3 = (__cuda_local_var_37820_17_non_const_f3 - (omega * (__cuda_local_var_37820_17_non_const_f3 - ((0.1111111119F) * (((__T2678 - ((3.0F) * __T2679)) + (((4.5F) * __T2679) * __T2679)) - ((1.5F) * __T2681))))));
# 1823 "txInterpTest.cu"
__cuda_local_var_37820_20_non_const_f4 = (__cuda_local_var_37820_20_non_const_f4 - (omega * (__cuda_local_var_37820_20_non_const_f4 - ((0.1111111119F) * (((__T2678 - ((3.0F) * __T2680)) + (((4.5F) * __T2680) * __T2680)) - ((1.5F) * __T2681))))));
# 1823 "txInterpTest.cu"
__cuda_local_var_37820_23_non_const_f5 = ((float)(((double)__cuda_local_var_37820_23_non_const_f5) - (((double)omega) * (((double)__cuda_local_var_37820_23_non_const_f5) - ((0.02777777777999999864) * ((double)(((__T2678 + ((3.0F) * (__T2679 + __T2680))) + (((4.5F) * (__T2679 + __T2680)) * (__T2679 + __T2680))) - ((1.5F) * __T2681))))))));
# 1823 "txInterpTest.cu"
__cuda_local_var_37820_26_non_const_f6 = ((float)(((double)__cuda_local_var_37820_26_non_const_f6) - (((double)omega) * (((double)__cuda_local_var_37820_26_non_const_f6) - ((0.02777777777999999864) * ((double)(((__T2678 + ((3.0F) * ((-__T2679) + __T2680))) + (((4.5F) * ((-__T2679) + __T2680)) * ((-__T2679) + __T2680))) - ((1.5F) * __T2681))))))));
# 1823 "txInterpTest.cu"
__cuda_local_var_37820_29_non_const_f7 = ((float)(((double)__cuda_local_var_37820_29_non_const_f7) - (((double)omega) * (((double)__cuda_local_var_37820_29_non_const_f7) - ((0.02777777777999999864) * ((double)(((__T2678 + ((3.0F) * ((-__T2679) - __T2680))) + (((4.5F) * ((-__T2679) - __T2680)) * ((-__T2679) - __T2680))) - ((1.5F) * __T2681))))))));
# 1823 "txInterpTest.cu"
__cuda_local_var_37820_32_non_const_f8 = ((float)(((double)__cuda_local_var_37820_32_non_const_f8) - (((double)omega) * (((double)__cuda_local_var_37820_32_non_const_f8) - ((0.02777777777999999864) * ((double)(((__T2678 + ((3.0F) * (__T2679 - __T2680))) + (((4.5F) * (__T2679 - __T2680)) * (__T2679 - __T2680))) - ((1.5F) * __T2681))))))));
# 1823 "txInterpTest.cu"
}
# 1823 "txInterpTest.cu"
}
# 1823 "txInterpTest.cu"
}
# 1825 "txInterpTest.cu"
(fB[((int)((((unsigned long)__cuda_local_var_37816_6_non_const_x) + (((unsigned long)__cuda_local_var_37817_6_non_const_y) * pitch)) + ((0UL * pitch) * 768UL)))]) = __cuda_local_var_37820_8_non_const_f0;
# 1826 "txInterpTest.cu"
(fB[((int)((((unsigned long)__cuda_local_var_37816_6_non_const_x) + (((unsigned long)__cuda_local_var_37817_6_non_const_y) * pitch)) + ((1UL * pitch) * 768UL)))]) = __cuda_local_var_37820_11_non_const_f1;
# 1827 "txInterpTest.cu"
(fB[((int)((((unsigned long)__cuda_local_var_37816_6_non_const_x) + (((unsigned long)__cuda_local_var_37817_6_non_const_y) * pitch)) + ((2UL * pitch) * 768UL)))]) = __cuda_local_var_37820_14_non_const_f2;
# 1828 "txInterpTest.cu"
(fB[((int)((((unsigned long)__cuda_local_var_37816_6_non_const_x) + (((unsigned long)__cuda_local_var_37817_6_non_const_y) * pitch)) + ((3UL * pitch) * 768UL)))]) = __cuda_local_var_37820_17_non_const_f3;
# 1829 "txInterpTest.cu"
(fB[((int)((((unsigned long)__cuda_local_var_37816_6_non_const_x) + (((unsigned long)__cuda_local_var_37817_6_non_const_y) * pitch)) + ((4UL * pitch) * 768UL)))]) = __cuda_local_var_37820_20_non_const_f4;
# 1830 "txInterpTest.cu"
(fB[((int)((((unsigned long)__cuda_local_var_37816_6_non_const_x) + (((unsigned long)__cuda_local_var_37817_6_non_const_y) * pitch)) + ((5UL * pitch) * 768UL)))]) = __cuda_local_var_37820_23_non_const_f5;
# 1831 "txInterpTest.cu"
(fB[((int)((((unsigned long)__cuda_local_var_37816_6_non_const_x) + (((unsigned long)__cuda_local_var_37817_6_non_const_y) * pitch)) + ((6UL * pitch) * 768UL)))]) = __cuda_local_var_37820_26_non_const_f6;
# 1832 "txInterpTest.cu"
(fB[((int)((((unsigned long)__cuda_local_var_37816_6_non_const_x) + (((unsigned long)__cuda_local_var_37817_6_non_const_y) * pitch)) + ((7UL * pitch) * 768UL)))]) = __cuda_local_var_37820_29_non_const_f7;
# 1833 "txInterpTest.cu"
(fB[((int)((((unsigned long)__cuda_local_var_37816_6_non_const_x) + (((unsigned long)__cuda_local_var_37817_6_non_const_y) * pitch)) + ((8UL * pitch) * 768UL)))]) = __cuda_local_var_37820_32_non_const_f8;
# 1834 "txInterpTest.cu"
}
# 1837 "txInterpTest.cu"
}
# 1837 "txInterpTest.cu"
}}
# 1839 "txInterpTest.cu"
__attribute__((global)) __attribute__((__used__)) void _Z18mrt_d_single_forcePfS_fmS_S_i(
# 1839 "txInterpTest.cu"
float *fA,
# 1839 "txInterpTest.cu"
float *fB,
# 1840 "txInterpTest.cu"
float omega,
# 1840 "txInterpTest.cu"
size_t pitch,
# 1840 "txInterpTest.cu"
float *FX,
# 1840 "txInterpTest.cu"
float *FY,
# 1840 "txInterpTest.cu"
int t){
# 1840 "txInterpTest.cu"
{
# 1841 "txInterpTest.cu"
{
# 1841 "txInterpTest.cu"
 int __T2682;
# 1842 "txInterpTest.cu"
 int __T2683;
# 1843 "txInterpTest.cu"
 int __T2684;
# 1844 "txInterpTest.cu"
 int __T2685;
# 1845 "txInterpTest.cu"
 int __T2686;
# 1846 "txInterpTest.cu"
 int __T2687;
# 1847 "txInterpTest.cu"
 int __T2688;
# 1848 "txInterpTest.cu"
 int __T2689;
# 1849 "txInterpTest.cu"
 int __T2690;
# 1850 "txInterpTest.cu"
 int __T2691;
# 1851 "txInterpTest.cu"
 int __T2692;
# 1852 "txInterpTest.cu"
 int __T2693;
# 1853 "txInterpTest.cu"
 float __T2694;
# 1854 "txInterpTest.cu"
 float __T2695;
# 1855 "txInterpTest.cu"
 float __T2696;
# 1856 "txInterpTest.cu"
 float __T2697;
# 1842 "txInterpTest.cu"
 int __cuda_local_var_37873_6_non_const_x;
# 1843 "txInterpTest.cu"
 int __cuda_local_var_37874_6_non_const_y;
# 1844 "txInterpTest.cu"
 int __cuda_local_var_37875_6_non_const_j;
# 1845 "txInterpTest.cu"
 int __cuda_local_var_37876_6_non_const_im;
# 1847 "txInterpTest.cu"
 float __cuda_local_var_37878_8_non_const_f0;
# 1847 "txInterpTest.cu"
 float __cuda_local_var_37878_11_non_const_f1;
# 1847 "txInterpTest.cu"
 float __cuda_local_var_37878_14_non_const_f2;
# 1847 "txInterpTest.cu"
 float __cuda_local_var_37878_17_non_const_f3;
# 1847 "txInterpTest.cu"
 float __cuda_local_var_37878_20_non_const_f4;
# 1847 "txInterpTest.cu"
 float __cuda_local_var_37878_23_non_const_f5;
# 1847 "txInterpTest.cu"
 float __cuda_local_var_37878_26_non_const_f6;
# 1847 "txInterpTest.cu"
 float __cuda_local_var_37878_29_non_const_f7;
# 1847 "txInterpTest.cu"
 float __cuda_local_var_37878_32_non_const_f8;
# 1848 "txInterpTest.cu"
static __attribute__((__used__)) __attribute__((shared)) float __cuda_local_var_37879_32_non_const_sumX[128];
# 1848 "txInterpTest.cu"
static __attribute__((__used__)) __attribute__((shared)) float __cuda_local_var_37879_43_non_const_sumY[128];
# 1849 "txInterpTest.cu"
static __attribute__((__used__)) __attribute__((shared)) int __cuda_local_var_37880_30_non_const_check[1];
# 1842 "txInterpTest.cu"
__cuda_local_var_37873_6_non_const_x = ((int)((threadIdx.x) + ((blockIdx.x) * (blockDim.x))));
# 1843 "txInterpTest.cu"
__cuda_local_var_37874_6_non_const_y = ((int)((threadIdx.y) + ((blockIdx.y) * (blockDim.y))));
# 1844 "txInterpTest.cu"
__cuda_local_var_37875_6_non_const_j = ((int)(((unsigned long)__cuda_local_var_37873_6_non_const_x) + (((unsigned long)__cuda_local_var_37874_6_non_const_y) * pitch)));
# 1845 "txInterpTest.cu"
__cuda_local_var_37876_6_non_const_im = (_Z8ImageFcnii(__cuda_local_var_37873_6_non_const_x, __cuda_local_var_37874_6_non_const_y));
# 1850 "txInterpTest.cu"
((__cuda_local_var_37880_30_non_const_check)[0]) = 0;
# 1851 "txInterpTest.cu"
{
# 1851 "txInterpTest.cu"
__syncthreads();
# 1851 "txInterpTest.cu"
}
# 1853 "txInterpTest.cu"
if ((((((1) && (((double)__cuda_local_var_37873_6_non_const_x) > (416.625))) && (((double)__cuda_local_var_37873_6_non_const_x) < (606.375))) && (((double)__cuda_local_var_37874_6_non_const_y) > (320.625))) && (((double)__cuda_local_var_37874_6_non_const_y) < (446.375))) || (__cuda_local_var_37873_6_non_const_x > 1023))
# 1853 "txInterpTest.cu"
{
# 1854 "txInterpTest.cu"
}
# 1855 "txInterpTest.cu"
else
# 1855 "txInterpTest.cu"
{
# 1856 "txInterpTest.cu"
__cuda_local_var_37878_8_non_const_f0 = (fA[__cuda_local_var_37875_6_non_const_j]);
# 1857 "txInterpTest.cu"
__cuda_local_var_37878_11_non_const_f1 = (fA[(((__T2682 = (_Z4dmaxi((__cuda_local_var_37873_6_non_const_x - 1)))) , ((void)(__T2683 = __cuda_local_var_37874_6_non_const_y))) , ((int)((((unsigned long)__T2682) + (((unsigned long)__T2683) * pitch)) + ((1UL * pitch) * 768UL))))]);
# 1858 "txInterpTest.cu"
__cuda_local_var_37878_17_non_const_f3 = (fA[(((__T2684 = (_Z4dminii((__cuda_local_var_37873_6_non_const_x + 1), 1024))) , ((void)(__T2685 = __cuda_local_var_37874_6_non_const_y))) , ((int)((((unsigned long)__T2684) + (((unsigned long)__T2685) * pitch)) + ((3UL * pitch) * 768UL))))]);
# 1859 "txInterpTest.cu"
__cuda_local_var_37878_14_non_const_f2 = (fA[((int)((((unsigned long)__cuda_local_var_37873_6_non_const_x) + (((unsigned long)(__cuda_local_var_37874_6_non_const_y - 1)) * pitch)) + ((2UL * pitch) * 768UL)))]);
# 1860 "txInterpTest.cu"
__cuda_local_var_37878_23_non_const_f5 = (fA[(((__T2686 = (_Z4dmaxi((__cuda_local_var_37873_6_non_const_x - 1)))) , ((void)(__T2687 = (__cuda_local_var_37874_6_non_const_y - 1)))) , ((int)((((unsigned long)__T2686) + (((unsigned long)__T2687) * pitch)) + ((5UL * pitch) * 768UL))))]);
# 1861 "txInterpTest.cu"
__cuda_local_var_37878_26_non_const_f6 = (fA[(((__T2688 = (_Z4dminii((__cuda_local_var_37873_6_non_const_x + 1), 1024))) , ((void)(__T2689 = (__cuda_local_var_37874_6_non_const_y - 1)))) , ((int)((((unsigned long)__T2688) + (((unsigned long)__T2689) * pitch)) + ((6UL * pitch) * 768UL))))]);
# 1862 "txInterpTest.cu"
__cuda_local_var_37878_20_non_const_f4 = (fA[((int)((((unsigned long)__cuda_local_var_37873_6_non_const_x) + (((unsigned long)(__cuda_local_var_37874_6_non_const_y + 1)) * pitch)) + ((4UL * pitch) * 768UL)))]);
# 1863 "txInterpTest.cu"
__cuda_local_var_37878_29_non_const_f7 = (fA[(((__T2690 = (_Z4dminii((__cuda_local_var_37873_6_non_const_x + 1), 1024))) , ((void)(__T2691 = (__cuda_local_var_37874_6_non_const_y + 1)))) , ((int)((((unsigned long)__T2690) + (((unsigned long)__T2691) * pitch)) + ((7UL * pitch) * 768UL))))]);
# 1864 "txInterpTest.cu"
__cuda_local_var_37878_32_non_const_f8 = (fA[(((__T2692 = (_Z4dmaxi((__cuda_local_var_37873_6_non_const_x - 1)))) , ((void)(__T2693 = (_Z4dminii((__cuda_local_var_37874_6_non_const_y + 1), 768))))) , ((int)((((unsigned long)__T2692) + (((unsigned long)__T2693) * pitch)) + ((8UL * pitch) * 768UL))))]);
# 1865 "txInterpTest.cu"
if ((__cuda_local_var_37876_6_non_const_im == 1) || (__cuda_local_var_37876_6_non_const_im == 10))
# 1865 "txInterpTest.cu"
{
# 1866 "txInterpTest.cu"
if (__cuda_local_var_37876_6_non_const_im == 10)
# 1866 "txInterpTest.cu"
{
# 1867 "txInterpTest.cu"
((__cuda_local_var_37880_30_non_const_check)[0]) = 1;
# 1869 "txInterpTest.cu"
((__cuda_local_var_37879_32_non_const_sumX)[(threadIdx.x)]) = (((((((2.0F) * __cuda_local_var_37878_11_non_const_f1) - ((2.0F) * __cuda_local_var_37878_17_non_const_f3)) + ((2.0F) * __cuda_local_var_37878_23_non_const_f5)) + ((2.0F) * __cuda_local_var_37878_32_non_const_f8)) - ((2.0F) * __cuda_local_var_37878_26_non_const_f6)) - ((2.0F) * __cuda_local_var_37878_29_non_const_f7));
# 1870 "txInterpTest.cu"
((__cuda_local_var_37879_43_non_const_sumY)[(threadIdx.x)]) = (((((((2.0F) * __cuda_local_var_37878_14_non_const_f2) - ((2.0F) * __cuda_local_var_37878_20_non_const_f4)) + ((2.0F) * __cuda_local_var_37878_23_non_const_f5)) - ((2.0F) * __cuda_local_var_37878_32_non_const_f8)) + ((2.0F) * __cuda_local_var_37878_26_non_const_f6)) - ((2.0F) * __cuda_local_var_37878_29_non_const_f7));
# 1871 "txInterpTest.cu"
}
# 1872 "txInterpTest.cu"
else
# 1872 "txInterpTest.cu"
{
# 1873 "txInterpTest.cu"
((__cuda_local_var_37879_32_non_const_sumX)[(threadIdx.x)]) = (0.0F);
# 1874 "txInterpTest.cu"
((__cuda_local_var_37879_43_non_const_sumY)[(threadIdx.x)]) = (0.0F);
# 1875 "txInterpTest.cu"
}
# 1877 "txInterpTest.cu"
(fB[((int)((((unsigned long)__cuda_local_var_37873_6_non_const_x) + (((unsigned long)__cuda_local_var_37874_6_non_const_y) * pitch)) + ((1UL * pitch) * 768UL)))]) = __cuda_local_var_37878_17_non_const_f3;
# 1878 "txInterpTest.cu"
(fB[((int)((((unsigned long)__cuda_local_var_37873_6_non_const_x) + (((unsigned long)__cuda_local_var_37874_6_non_const_y) * pitch)) + ((2UL * pitch) * 768UL)))]) = __cuda_local_var_37878_20_non_const_f4;
# 1879 "txInterpTest.cu"
(fB[((int)((((unsigned long)__cuda_local_var_37873_6_non_const_x) + (((unsigned long)__cuda_local_var_37874_6_non_const_y) * pitch)) + ((3UL * pitch) * 768UL)))]) = __cuda_local_var_37878_11_non_const_f1;
# 1880 "txInterpTest.cu"
(fB[((int)((((unsigned long)__cuda_local_var_37873_6_non_const_x) + (((unsigned long)__cuda_local_var_37874_6_non_const_y) * pitch)) + ((4UL * pitch) * 768UL)))]) = __cuda_local_var_37878_14_non_const_f2;
# 1881 "txInterpTest.cu"
(fB[((int)((((unsigned long)__cuda_local_var_37873_6_non_const_x) + (((unsigned long)__cuda_local_var_37874_6_non_const_y) * pitch)) + ((5UL * pitch) * 768UL)))]) = __cuda_local_var_37878_29_non_const_f7;
# 1882 "txInterpTest.cu"
(fB[((int)((((unsigned long)__cuda_local_var_37873_6_non_const_x) + (((unsigned long)__cuda_local_var_37874_6_non_const_y) * pitch)) + ((6UL * pitch) * 768UL)))]) = __cuda_local_var_37878_32_non_const_f8;
# 1883 "txInterpTest.cu"
(fB[((int)((((unsigned long)__cuda_local_var_37873_6_non_const_x) + (((unsigned long)__cuda_local_var_37874_6_non_const_y) * pitch)) + ((7UL * pitch) * 768UL)))]) = __cuda_local_var_37878_23_non_const_f5;
# 1884 "txInterpTest.cu"
(fB[((int)((((unsigned long)__cuda_local_var_37873_6_non_const_x) + (((unsigned long)__cuda_local_var_37874_6_non_const_y) * pitch)) + ((8UL * pitch) * 768UL)))]) = __cuda_local_var_37878_26_non_const_f6;
# 1885 "txInterpTest.cu"
}
# 1886 "txInterpTest.cu"
else
# 1886 "txInterpTest.cu"
{
# 1887 "txInterpTest.cu"
((__cuda_local_var_37879_32_non_const_sumX)[(threadIdx.x)]) = (0.0F);
# 1888 "txInterpTest.cu"
((__cuda_local_var_37879_43_non_const_sumY)[(threadIdx.x)]) = (0.0F);
# 1898 "txInterpTest.cu"
_Z16boundaries_forceRfS_S_S_S_S_S_S_S_ii((&__cuda_local_var_37878_8_non_const_f0), (&__cuda_local_var_37878_11_non_const_f1), (&__cuda_local_var_37878_14_non_const_f2), (&__cuda_local_var_37878_17_non_const_f3), (&__cuda_local_var_37878_20_non_const_f4), (&__cuda_local_var_37878_23_non_const_f5), (&__cuda_local_var_37878_26_non_const_f6), (&__cuda_local_var_37878_29_non_const_f7), (&__cuda_local_var_37878_32_non_const_f8), __cuda_local_var_37874_6_non_const_y, __cuda_local_var_37876_6_non_const_im);
# 1900 "txInterpTest.cu"
if (((const char *)"BGK") == ((const char *)"MRT"))
# 1900 "txInterpTest.cu"
{
# 1901 "txInterpTest.cu"
_Z11mrt_collideRfS_S_S_S_S_S_S_S_f((&__cuda_local_var_37878_8_non_const_f0), (&__cuda_local_var_37878_11_non_const_f1), (&__cuda_local_var_37878_14_non_const_f2), (&__cuda_local_var_37878_17_non_const_f3), (&__cuda_local_var_37878_20_non_const_f4), (&__cuda_local_var_37878_23_non_const_f5), (&__cuda_local_var_37878_26_non_const_f6), (&__cuda_local_var_37878_29_non_const_f7), (&__cuda_local_var_37878_32_non_const_f8), omega);
# 1901 "txInterpTest.cu"
}
# 1901 "txInterpTest.cu"
else
# 1901 "txInterpTest.cu"
{
# 1902 "txInterpTest.cu"
if (1)
# 1902 "txInterpTest.cu"
{
# 1903 "txInterpTest.cu"
{
# 1903 "txInterpTest.cu"
__T2694 = ((((((((__cuda_local_var_37878_8_non_const_f0 + __cuda_local_var_37878_11_non_const_f1) + __cuda_local_var_37878_14_non_const_f2) + __cuda_local_var_37878_17_non_const_f3) + __cuda_local_var_37878_20_non_const_f4) + __cuda_local_var_37878_23_non_const_f5) + __cuda_local_var_37878_26_non_const_f6) + __cuda_local_var_37878_29_non_const_f7) + __cuda_local_var_37878_32_non_const_f8);
# 1903 "txInterpTest.cu"
__T2695 = (((((__cuda_local_var_37878_11_non_const_f1 - __cuda_local_var_37878_17_non_const_f3) + __cuda_local_var_37878_23_non_const_f5) - __cuda_local_var_37878_26_non_const_f6) - __cuda_local_var_37878_29_non_const_f7) + __cuda_local_var_37878_32_non_const_f8);
# 1903 "txInterpTest.cu"
__T2696 = (((((__cuda_local_var_37878_14_non_const_f2 - __cuda_local_var_37878_20_non_const_f4) + __cuda_local_var_37878_23_non_const_f5) + __cuda_local_var_37878_26_non_const_f6) - __cuda_local_var_37878_29_non_const_f7) - __cuda_local_var_37878_32_non_const_f8);
# 1903 "txInterpTest.cu"
__T2697 = ((__T2695 * __T2695) + (__T2696 * __T2696));
# 1903 "txInterpTest.cu"
__cuda_local_var_37878_8_non_const_f0 = (__cuda_local_var_37878_8_non_const_f0 - (omega * (__cuda_local_var_37878_8_non_const_f0 - ((0.4444444478F) * (__T2694 - ((1.5F) * __T2697))))));
# 1903 "txInterpTest.cu"
__cuda_local_var_37878_11_non_const_f1 = (__cuda_local_var_37878_11_non_const_f1 - (omega * (__cuda_local_var_37878_11_non_const_f1 - ((0.1111111119F) * (((__T2694 + ((3.0F) * __T2695)) + (((4.5F) * __T2695) * __T2695)) - ((1.5F) * __T2697))))));
# 1903 "txInterpTest.cu"
__cuda_local_var_37878_14_non_const_f2 = (__cuda_local_var_37878_14_non_const_f2 - (omega * (__cuda_local_var_37878_14_non_const_f2 - ((0.1111111119F) * (((__T2694 + ((3.0F) * __T2696)) + (((4.5F) * __T2696) * __T2696)) - ((1.5F) * __T2697))))));
# 1903 "txInterpTest.cu"
__cuda_local_var_37878_17_non_const_f3 = (__cuda_local_var_37878_17_non_const_f3 - (omega * (__cuda_local_var_37878_17_non_const_f3 - ((0.1111111119F) * (((__T2694 - ((3.0F) * __T2695)) + (((4.5F) * __T2695) * __T2695)) - ((1.5F) * __T2697))))));
# 1903 "txInterpTest.cu"
__cuda_local_var_37878_20_non_const_f4 = (__cuda_local_var_37878_20_non_const_f4 - (omega * (__cuda_local_var_37878_20_non_const_f4 - ((0.1111111119F) * (((__T2694 - ((3.0F) * __T2696)) + (((4.5F) * __T2696) * __T2696)) - ((1.5F) * __T2697))))));
# 1903 "txInterpTest.cu"
__cuda_local_var_37878_23_non_const_f5 = ((float)(((double)__cuda_local_var_37878_23_non_const_f5) - (((double)omega) * (((double)__cuda_local_var_37878_23_non_const_f5) - ((0.02777777777999999864) * ((double)(((__T2694 + ((3.0F) * (__T2695 + __T2696))) + (((4.5F) * (__T2695 + __T2696)) * (__T2695 + __T2696))) - ((1.5F) * __T2697))))))));
# 1903 "txInterpTest.cu"
__cuda_local_var_37878_26_non_const_f6 = ((float)(((double)__cuda_local_var_37878_26_non_const_f6) - (((double)omega) * (((double)__cuda_local_var_37878_26_non_const_f6) - ((0.02777777777999999864) * ((double)(((__T2694 + ((3.0F) * ((-__T2695) + __T2696))) + (((4.5F) * ((-__T2695) + __T2696)) * ((-__T2695) + __T2696))) - ((1.5F) * __T2697))))))));
# 1903 "txInterpTest.cu"
__cuda_local_var_37878_29_non_const_f7 = ((float)(((double)__cuda_local_var_37878_29_non_const_f7) - (((double)omega) * (((double)__cuda_local_var_37878_29_non_const_f7) - ((0.02777777777999999864) * ((double)(((__T2694 + ((3.0F) * ((-__T2695) - __T2696))) + (((4.5F) * ((-__T2695) - __T2696)) * ((-__T2695) - __T2696))) - ((1.5F) * __T2697))))))));
# 1903 "txInterpTest.cu"
__cuda_local_var_37878_32_non_const_f8 = ((float)(((double)__cuda_local_var_37878_32_non_const_f8) - (((double)omega) * (((double)__cuda_local_var_37878_32_non_const_f8) - ((0.02777777777999999864) * ((double)(((__T2694 + ((3.0F) * (__T2695 - __T2696))) + (((4.5F) * (__T2695 - __T2696)) * (__T2695 - __T2696))) - ((1.5F) * __T2697))))))));
# 1903 "txInterpTest.cu"
}
# 1903 "txInterpTest.cu"
}
# 1903 "txInterpTest.cu"
}
# 1905 "txInterpTest.cu"
(fB[((int)((((unsigned long)__cuda_local_var_37873_6_non_const_x) + (((unsigned long)__cuda_local_var_37874_6_non_const_y) * pitch)) + ((0UL * pitch) * 768UL)))]) = __cuda_local_var_37878_8_non_const_f0;
# 1906 "txInterpTest.cu"
(fB[((int)((((unsigned long)__cuda_local_var_37873_6_non_const_x) + (((unsigned long)__cuda_local_var_37874_6_non_const_y) * pitch)) + ((1UL * pitch) * 768UL)))]) = __cuda_local_var_37878_11_non_const_f1;
# 1907 "txInterpTest.cu"
(fB[((int)((((unsigned long)__cuda_local_var_37873_6_non_const_x) + (((unsigned long)__cuda_local_var_37874_6_non_const_y) * pitch)) + ((2UL * pitch) * 768UL)))]) = __cuda_local_var_37878_14_non_const_f2;
# 1908 "txInterpTest.cu"
(fB[((int)((((unsigned long)__cuda_local_var_37873_6_non_const_x) + (((unsigned long)__cuda_local_var_37874_6_non_const_y) * pitch)) + ((3UL * pitch) * 768UL)))]) = __cuda_local_var_37878_17_non_const_f3;
# 1909 "txInterpTest.cu"
(fB[((int)((((unsigned long)__cuda_local_var_37873_6_non_const_x) + (((unsigned long)__cuda_local_var_37874_6_non_const_y) * pitch)) + ((4UL * pitch) * 768UL)))]) = __cuda_local_var_37878_20_non_const_f4;
# 1910 "txInterpTest.cu"
(fB[((int)((((unsigned long)__cuda_local_var_37873_6_non_const_x) + (((unsigned long)__cuda_local_var_37874_6_non_const_y) * pitch)) + ((5UL * pitch) * 768UL)))]) = __cuda_local_var_37878_23_non_const_f5;
# 1911 "txInterpTest.cu"
(fB[((int)((((unsigned long)__cuda_local_var_37873_6_non_const_x) + (((unsigned long)__cuda_local_var_37874_6_non_const_y) * pitch)) + ((6UL * pitch) * 768UL)))]) = __cuda_local_var_37878_26_non_const_f6;
# 1912 "txInterpTest.cu"
(fB[((int)((((unsigned long)__cuda_local_var_37873_6_non_const_x) + (((unsigned long)__cuda_local_var_37874_6_non_const_y) * pitch)) + ((7UL * pitch) * 768UL)))]) = __cuda_local_var_37878_29_non_const_f7;
# 1913 "txInterpTest.cu"
(fB[((int)((((unsigned long)__cuda_local_var_37873_6_non_const_x) + (((unsigned long)__cuda_local_var_37874_6_non_const_y) * pitch)) + ((8UL * pitch) * 768UL)))]) = __cuda_local_var_37878_32_non_const_f8;
# 1914 "txInterpTest.cu"
}
# 1916 "txInterpTest.cu"
{
# 1916 "txInterpTest.cu"
__syncthreads();
# 1916 "txInterpTest.cu"
}
# 1917 "txInterpTest.cu"
if ((((__cuda_local_var_37880_30_non_const_check)[0]) == 1) && (((long)t) >= 10000000000L))
# 1917 "txInterpTest.cu"
{
# 1919 "txInterpTest.cu"
 int __cuda_local_var_37942_6_non_const_nTotalThreads;
# 1919 "txInterpTest.cu"
__cuda_local_var_37942_6_non_const_nTotalThreads = ((int)(blockDim.x));
# 1920 "txInterpTest.cu"
while (__cuda_local_var_37942_6_non_const_nTotalThreads > 1)
# 1920 "txInterpTest.cu"
{
# 1921 "txInterpTest.cu"
 int __cuda_local_var_37944_7_non_const_halfPoint;
# 1921 "txInterpTest.cu"
__cuda_local_var_37944_7_non_const_halfPoint = (__cuda_local_var_37942_6_non_const_nTotalThreads >> 1);
# 1922 "txInterpTest.cu"
if ((threadIdx.x) < ((unsigned)__cuda_local_var_37944_7_non_const_halfPoint))
# 1922 "txInterpTest.cu"
{
# 1923 "txInterpTest.cu"
((__cuda_local_var_37879_32_non_const_sumX)[(threadIdx.x)]) += ((__cuda_local_var_37879_32_non_const_sumX)[((threadIdx.x) + ((unsigned)__cuda_local_var_37944_7_non_const_halfPoint))]);
# 1924 "txInterpTest.cu"
((__cuda_local_var_37879_43_non_const_sumY)[(threadIdx.x)]) += ((__cuda_local_var_37879_43_non_const_sumY)[((threadIdx.x) + ((unsigned)__cuda_local_var_37944_7_non_const_halfPoint))]);
# 1925 "txInterpTest.cu"
}
# 1926 "txInterpTest.cu"
{
# 1926 "txInterpTest.cu"
__syncthreads();
# 1926 "txInterpTest.cu"
}
# 1927 "txInterpTest.cu"
__cuda_local_var_37942_6_non_const_nTotalThreads = __cuda_local_var_37944_7_non_const_halfPoint;
# 1928 "txInterpTest.cu"
}
# 1929 "txInterpTest.cu"
if ((threadIdx.x) == 0U)
# 1929 "txInterpTest.cu"
{
# 1930 "txInterpTest.cu"
_Z9atomicAddPff((FX + t), ((__cuda_local_var_37879_32_non_const_sumX)[0]));
# 1931 "txInterpTest.cu"
_Z9atomicAddPff((FY + t), ((__cuda_local_var_37879_43_non_const_sumY)[0]));
# 1932 "txInterpTest.cu"
}
# 1933 "txInterpTest.cu"
}
# 1934 "txInterpTest.cu"
}
# 1935 "txInterpTest.cu"
}
# 1935 "txInterpTest.cu"
}}
# 1936 "txInterpTest.cu"
__attribute__((global)) __attribute__((__used__)) void _Z17mrt_d_hybAB_forcePfS_fmS_S_i(
# 1936 "txInterpTest.cu"
float *fin,
# 1936 "txInterpTest.cu"
float *fout,
# 1937 "txInterpTest.cu"
float omega,
# 1937 "txInterpTest.cu"
size_t pitch,
# 1937 "txInterpTest.cu"
float *FX,
# 1937 "txInterpTest.cu"
float *FY,
# 1937 "txInterpTest.cu"
int t){
# 1937 "txInterpTest.cu"
{
# 1938 "txInterpTest.cu"
{
# 1939 "txInterpTest.cu"
 int __cuda_local_var_37962_6_non_const_x;
# 1940 "txInterpTest.cu"
 int __cuda_local_var_37963_6_non_const_y;
# 1941 "txInterpTest.cu"
 int __cuda_local_var_37964_6_non_const_j;
# 1942 "txInterpTest.cu"
 float __cuda_local_var_37965_8_non_const_f0;
# 1942 "txInterpTest.cu"
 float __cuda_local_var_37965_11_non_const_f1;
# 1942 "txInterpTest.cu"
 float __cuda_local_var_37965_14_non_const_f2;
# 1942 "txInterpTest.cu"
 float __cuda_local_var_37965_17_non_const_f3;
# 1942 "txInterpTest.cu"
 float __cuda_local_var_37965_20_non_const_f4;
# 1942 "txInterpTest.cu"
 float __cuda_local_var_37965_23_non_const_f5;
# 1942 "txInterpTest.cu"
 float __cuda_local_var_37965_26_non_const_f6;
# 1942 "txInterpTest.cu"
 float __cuda_local_var_37965_29_non_const_f7;
# 1942 "txInterpTest.cu"
 float __cuda_local_var_37965_32_non_const_f8;
# 1943 "txInterpTest.cu"
static __attribute__((__used__)) __attribute__((shared)) float __cuda_local_var_37966_32_non_const_sumX[128];
# 1943 "txInterpTest.cu"
static __attribute__((__used__)) __attribute__((shared)) float __cuda_local_var_37966_43_non_const_sumY[128];
# 1944 "txInterpTest.cu"
static __attribute__((__used__)) __attribute__((shared)) int __cuda_local_var_37967_30_non_const_check[1];
# 1939 "txInterpTest.cu"
__cuda_local_var_37962_6_non_const_x = ((int)((threadIdx.x) + ((blockIdx.x) * (blockDim.x))));
# 1940 "txInterpTest.cu"
__cuda_local_var_37963_6_non_const_y = ((int)((threadIdx.y) + ((blockIdx.y) * (blockDim.y))));
# 1941 "txInterpTest.cu"
__cuda_local_var_37964_6_non_const_j = ((int)(((unsigned long)__cuda_local_var_37962_6_non_const_x) + (((unsigned long)__cuda_local_var_37963_6_non_const_y) * pitch)));
# 1945 "txInterpTest.cu"
((__cuda_local_var_37967_30_non_const_check)[0]) = 0;
# 1946 "txInterpTest.cu"
{
# 1946 "txInterpTest.cu"
__syncthreads();
# 1946 "txInterpTest.cu"
}
# 1948 "txInterpTest.cu"
if ((((((1) && (((double)__cuda_local_var_37962_6_non_const_x) > (416.625))) && (((double)__cuda_local_var_37962_6_non_const_x) < (606.375))) && (((double)__cuda_local_var_37963_6_non_const_y) > (320.625))) && (((double)__cuda_local_var_37963_6_non_const_y) < (446.375))) || (__cuda_local_var_37962_6_non_const_x > 1023))
# 1948 "txInterpTest.cu"
{
# 1949 "txInterpTest.cu"
}
# 1950 "txInterpTest.cu"
else
# 1950 "txInterpTest.cu"
{
# 1950 "txInterpTest.cu"
 __texture_type__ __T2698;
# 1951 "txInterpTest.cu"
 float __T2699;
# 1952 "txInterpTest.cu"
 float __T2700;
# 1953 "txInterpTest.cu"
 float4 __T2701;
# 1954 "txInterpTest.cu"
 float4 __T2702;
# 1955 "txInterpTest.cu"
 __texture_type__ __T2703;
# 1956 "txInterpTest.cu"
 float __T2704;
# 1957 "txInterpTest.cu"
 float __T2705;
# 1958 "txInterpTest.cu"
 float4 __T2706;
# 1959 "txInterpTest.cu"
 float4 __T2707;
# 1960 "txInterpTest.cu"
 __texture_type__ __T2708;
# 1961 "txInterpTest.cu"
 float __T2709;
# 1962 "txInterpTest.cu"
 float __T2710;
# 1963 "txInterpTest.cu"
 float4 __T2711;
# 1964 "txInterpTest.cu"
 float4 __T2712;
# 1965 "txInterpTest.cu"
 __texture_type__ __T2713;
# 1966 "txInterpTest.cu"
 float __T2714;
# 1967 "txInterpTest.cu"
 float __T2715;
# 1968 "txInterpTest.cu"
 float4 __T2716;
# 1969 "txInterpTest.cu"
 float4 __T2717;
# 1970 "txInterpTest.cu"
 __texture_type__ __T2718;
# 1971 "txInterpTest.cu"
 float __T2719;
# 1972 "txInterpTest.cu"
 float __T2720;
# 1973 "txInterpTest.cu"
 float4 __T2721;
# 1974 "txInterpTest.cu"
 float4 __T2722;
# 1975 "txInterpTest.cu"
 __texture_type__ __T2723;
# 1976 "txInterpTest.cu"
 float __T2724;
# 1977 "txInterpTest.cu"
 float __T2725;
# 1978 "txInterpTest.cu"
 float4 __T2726;
# 1979 "txInterpTest.cu"
 float4 __T2727;
# 1980 "txInterpTest.cu"
 float __T2728;
# 1981 "txInterpTest.cu"
 float __T2729;
# 1982 "txInterpTest.cu"
 float __T2730;
# 1983 "txInterpTest.cu"
 float __T2731;
# 1969 "txInterpTest.cu"
 int __cuda_local_var_37992_6_non_const_im;
# 1952 "txInterpTest.cu"
__cuda_local_var_37965_8_non_const_f0 = (fin[__cuda_local_var_37964_6_non_const_j]);
# 1953 "txInterpTest.cu"
__cuda_local_var_37965_14_non_const_f2 = (fin[((int)((((unsigned long)__cuda_local_var_37962_6_non_const_x) + (((unsigned long)(__cuda_local_var_37963_6_non_const_y - 1)) * pitch)) + ((2UL * pitch) * 768UL)))]);
# 1954 "txInterpTest.cu"
__cuda_local_var_37965_20_non_const_f4 = (fin[((int)((((unsigned long)__cuda_local_var_37962_6_non_const_x) + (((unsigned long)(__cuda_local_var_37963_6_non_const_y + 1)) * pitch)) + ((4UL * pitch) * 768UL)))]);
# 1962 "txInterpTest.cu"
__cuda_local_var_37965_11_non_const_f1 = ((((__T2698 = texRef_f1A) , ((void)(__T2699 = (((float)(__cuda_local_var_37962_6_non_const_x - 1)) + (0.5F))))) , ((void)(__T2700 = (((float)__cuda_local_var_37963_6_non_const_y) + (0.5F))))) , ((__T2702 = (__ftexfetch2D(__T2698, ((((((__T2701.x) = __T2699) , ((void)((__T2701.y) = __T2700))) , ((void)((__T2701.z) = (0.0F)))) , ((void)((__T2701.w) = (0.0F)))) , __T2701)))) , (__T2702.x)));
# 1963 "txInterpTest.cu"
__cuda_local_var_37965_17_non_const_f3 = ((((__T2703 = texRef_f3A) , ((void)(__T2704 = (((float)(__cuda_local_var_37962_6_non_const_x + 1)) + (0.5F))))) , ((void)(__T2705 = (((float)__cuda_local_var_37963_6_non_const_y) + (0.5F))))) , ((__T2707 = (__ftexfetch2D(__T2703, ((((((__T2706.x) = __T2704) , ((void)((__T2706.y) = __T2705))) , ((void)((__T2706.z) = (0.0F)))) , ((void)((__T2706.w) = (0.0F)))) , __T2706)))) , (__T2707.x)));
# 1964 "txInterpTest.cu"
__cuda_local_var_37965_23_non_const_f5 = ((((__T2708 = texRef_f5A) , ((void)(__T2709 = (((float)(__cuda_local_var_37962_6_non_const_x - 1)) + (0.5F))))) , ((void)(__T2710 = (((float)(__cuda_local_var_37963_6_non_const_y - 1)) + (0.5F))))) , ((__T2712 = (__ftexfetch2D(__T2708, ((((((__T2711.x) = __T2709) , ((void)((__T2711.y) = __T2710))) , ((void)((__T2711.z) = (0.0F)))) , ((void)((__T2711.w) = (0.0F)))) , __T2711)))) , (__T2712.x)));
# 1965 "txInterpTest.cu"
__cuda_local_var_37965_26_non_const_f6 = ((((__T2713 = texRef_f6A) , ((void)(__T2714 = (((float)(__cuda_local_var_37962_6_non_const_x + 1)) + (0.5F))))) , ((void)(__T2715 = (((float)(__cuda_local_var_37963_6_non_const_y - 1)) + (0.5F))))) , ((__T2717 = (__ftexfetch2D(__T2713, ((((((__T2716.x) = __T2714) , ((void)((__T2716.y) = __T2715))) , ((void)((__T2716.z) = (0.0F)))) , ((void)((__T2716.w) = (0.0F)))) , __T2716)))) , (__T2717.x)));
# 1966 "txInterpTest.cu"
__cuda_local_var_37965_29_non_const_f7 = ((((__T2718 = texRef_f7A) , ((void)(__T2719 = (((float)(__cuda_local_var_37962_6_non_const_x + 1)) + (0.5F))))) , ((void)(__T2720 = (((float)(__cuda_local_var_37963_6_non_const_y + 1)) + (0.5F))))) , ((__T2722 = (__ftexfetch2D(__T2718, ((((((__T2721.x) = __T2719) , ((void)((__T2721.y) = __T2720))) , ((void)((__T2721.z) = (0.0F)))) , ((void)((__T2721.w) = (0.0F)))) , __T2721)))) , (__T2722.x)));
# 1967 "txInterpTest.cu"
__cuda_local_var_37965_32_non_const_f8 = ((((__T2723 = texRef_f8A) , ((void)(__T2724 = (((float)(__cuda_local_var_37962_6_non_const_x - 1)) + (0.5F))))) , ((void)(__T2725 = (((float)(__cuda_local_var_37963_6_non_const_y + 1)) + (0.5F))))) , ((__T2727 = (__ftexfetch2D(__T2723, ((((((__T2726.x) = __T2724) , ((void)((__T2726.y) = __T2725))) , ((void)((__T2726.z) = (0.0F)))) , ((void)((__T2726.w) = (0.0F)))) , __T2726)))) , (__T2727.x)));
# 1969 "txInterpTest.cu"
__cuda_local_var_37992_6_non_const_im = (_Z8ImageFcnii(__cuda_local_var_37962_6_non_const_x, __cuda_local_var_37963_6_non_const_y));
# 1970 "txInterpTest.cu"
if ((__cuda_local_var_37992_6_non_const_im == 1) || (__cuda_local_var_37992_6_non_const_im == 10))
# 1970 "txInterpTest.cu"
{
# 1971 "txInterpTest.cu"
if (__cuda_local_var_37992_6_non_const_im == 10)
# 1971 "txInterpTest.cu"
{
# 1972 "txInterpTest.cu"
((__cuda_local_var_37967_30_non_const_check)[0]) = 1;
# 1973 "txInterpTest.cu"
((__cuda_local_var_37966_32_non_const_sumX)[(threadIdx.x)]) = (((((((2.0F) * __cuda_local_var_37965_11_non_const_f1) - ((2.0F) * __cuda_local_var_37965_17_non_const_f3)) + ((2.0F) * __cuda_local_var_37965_23_non_const_f5)) + ((2.0F) * __cuda_local_var_37965_32_non_const_f8)) - ((2.0F) * __cuda_local_var_37965_26_non_const_f6)) - ((2.0F) * __cuda_local_var_37965_29_non_const_f7));
# 1974 "txInterpTest.cu"
((__cuda_local_var_37966_43_non_const_sumY)[(threadIdx.x)]) = (((((((2.0F) * __cuda_local_var_37965_14_non_const_f2) - ((2.0F) * __cuda_local_var_37965_20_non_const_f4)) + ((2.0F) * __cuda_local_var_37965_23_non_const_f5)) - ((2.0F) * __cuda_local_var_37965_32_non_const_f8)) + ((2.0F) * __cuda_local_var_37965_26_non_const_f6)) - ((2.0F) * __cuda_local_var_37965_29_non_const_f7));
# 1975 "txInterpTest.cu"
}
# 1976 "txInterpTest.cu"
else
# 1976 "txInterpTest.cu"
{
# 1977 "txInterpTest.cu"
((__cuda_local_var_37966_32_non_const_sumX)[(threadIdx.x)]) = (0.0F);
# 1978 "txInterpTest.cu"
((__cuda_local_var_37966_43_non_const_sumY)[(threadIdx.x)]) = (0.0F);
# 1979 "txInterpTest.cu"
}
# 1980 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37962_6_non_const_x) + (((unsigned long)__cuda_local_var_37963_6_non_const_y) * pitch)) + ((1UL * pitch) * 768UL)))]) = __cuda_local_var_37965_17_non_const_f3;
# 1981 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37962_6_non_const_x) + (((unsigned long)__cuda_local_var_37963_6_non_const_y) * pitch)) + ((2UL * pitch) * 768UL)))]) = __cuda_local_var_37965_20_non_const_f4;
# 1982 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37962_6_non_const_x) + (((unsigned long)__cuda_local_var_37963_6_non_const_y) * pitch)) + ((3UL * pitch) * 768UL)))]) = __cuda_local_var_37965_11_non_const_f1;
# 1983 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37962_6_non_const_x) + (((unsigned long)__cuda_local_var_37963_6_non_const_y) * pitch)) + ((4UL * pitch) * 768UL)))]) = __cuda_local_var_37965_14_non_const_f2;
# 1984 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37962_6_non_const_x) + (((unsigned long)__cuda_local_var_37963_6_non_const_y) * pitch)) + ((5UL * pitch) * 768UL)))]) = __cuda_local_var_37965_29_non_const_f7;
# 1985 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37962_6_non_const_x) + (((unsigned long)__cuda_local_var_37963_6_non_const_y) * pitch)) + ((6UL * pitch) * 768UL)))]) = __cuda_local_var_37965_32_non_const_f8;
# 1986 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37962_6_non_const_x) + (((unsigned long)__cuda_local_var_37963_6_non_const_y) * pitch)) + ((7UL * pitch) * 768UL)))]) = __cuda_local_var_37965_23_non_const_f5;
# 1987 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37962_6_non_const_x) + (((unsigned long)__cuda_local_var_37963_6_non_const_y) * pitch)) + ((8UL * pitch) * 768UL)))]) = __cuda_local_var_37965_26_non_const_f6;
# 1988 "txInterpTest.cu"
}
# 1989 "txInterpTest.cu"
else
# 1989 "txInterpTest.cu"
{
# 1990 "txInterpTest.cu"
((__cuda_local_var_37966_32_non_const_sumX)[(threadIdx.x)]) = (0.0F);
# 1991 "txInterpTest.cu"
((__cuda_local_var_37966_43_non_const_sumY)[(threadIdx.x)]) = (0.0F);
# 2013 "txInterpTest.cu"
_Z16boundaries_forceRfS_S_S_S_S_S_S_S_ii((&__cuda_local_var_37965_8_non_const_f0), (&__cuda_local_var_37965_11_non_const_f1), (&__cuda_local_var_37965_14_non_const_f2), (&__cuda_local_var_37965_17_non_const_f3), (&__cuda_local_var_37965_20_non_const_f4), (&__cuda_local_var_37965_23_non_const_f5), (&__cuda_local_var_37965_26_non_const_f6), (&__cuda_local_var_37965_29_non_const_f7), (&__cuda_local_var_37965_32_non_const_f8), __cuda_local_var_37963_6_non_const_y, __cuda_local_var_37992_6_non_const_im);
# 2015 "txInterpTest.cu"
if (((const char *)"BGK") == ((const char *)"MRT"))
# 2015 "txInterpTest.cu"
{
# 2016 "txInterpTest.cu"
_Z11mrt_collideRfS_S_S_S_S_S_S_S_f((&__cuda_local_var_37965_8_non_const_f0), (&__cuda_local_var_37965_11_non_const_f1), (&__cuda_local_var_37965_14_non_const_f2), (&__cuda_local_var_37965_17_non_const_f3), (&__cuda_local_var_37965_20_non_const_f4), (&__cuda_local_var_37965_23_non_const_f5), (&__cuda_local_var_37965_26_non_const_f6), (&__cuda_local_var_37965_29_non_const_f7), (&__cuda_local_var_37965_32_non_const_f8), omega);
# 2016 "txInterpTest.cu"
}
# 2016 "txInterpTest.cu"
else
# 2016 "txInterpTest.cu"
{
# 2017 "txInterpTest.cu"
if (1)
# 2017 "txInterpTest.cu"
{
# 2018 "txInterpTest.cu"
{
# 2018 "txInterpTest.cu"
__T2728 = ((((((((__cuda_local_var_37965_8_non_const_f0 + __cuda_local_var_37965_11_non_const_f1) + __cuda_local_var_37965_14_non_const_f2) + __cuda_local_var_37965_17_non_const_f3) + __cuda_local_var_37965_20_non_const_f4) + __cuda_local_var_37965_23_non_const_f5) + __cuda_local_var_37965_26_non_const_f6) + __cuda_local_var_37965_29_non_const_f7) + __cuda_local_var_37965_32_non_const_f8);
# 2018 "txInterpTest.cu"
__T2729 = (((((__cuda_local_var_37965_11_non_const_f1 - __cuda_local_var_37965_17_non_const_f3) + __cuda_local_var_37965_23_non_const_f5) - __cuda_local_var_37965_26_non_const_f6) - __cuda_local_var_37965_29_non_const_f7) + __cuda_local_var_37965_32_non_const_f8);
# 2018 "txInterpTest.cu"
__T2730 = (((((__cuda_local_var_37965_14_non_const_f2 - __cuda_local_var_37965_20_non_const_f4) + __cuda_local_var_37965_23_non_const_f5) + __cuda_local_var_37965_26_non_const_f6) - __cuda_local_var_37965_29_non_const_f7) - __cuda_local_var_37965_32_non_const_f8);
# 2018 "txInterpTest.cu"
__T2731 = ((__T2729 * __T2729) + (__T2730 * __T2730));
# 2018 "txInterpTest.cu"
__cuda_local_var_37965_8_non_const_f0 = (__cuda_local_var_37965_8_non_const_f0 - (omega * (__cuda_local_var_37965_8_non_const_f0 - ((0.4444444478F) * (__T2728 - ((1.5F) * __T2731))))));
# 2018 "txInterpTest.cu"
__cuda_local_var_37965_11_non_const_f1 = (__cuda_local_var_37965_11_non_const_f1 - (omega * (__cuda_local_var_37965_11_non_const_f1 - ((0.1111111119F) * (((__T2728 + ((3.0F) * __T2729)) + (((4.5F) * __T2729) * __T2729)) - ((1.5F) * __T2731))))));
# 2018 "txInterpTest.cu"
__cuda_local_var_37965_14_non_const_f2 = (__cuda_local_var_37965_14_non_const_f2 - (omega * (__cuda_local_var_37965_14_non_const_f2 - ((0.1111111119F) * (((__T2728 + ((3.0F) * __T2730)) + (((4.5F) * __T2730) * __T2730)) - ((1.5F) * __T2731))))));
# 2018 "txInterpTest.cu"
__cuda_local_var_37965_17_non_const_f3 = (__cuda_local_var_37965_17_non_const_f3 - (omega * (__cuda_local_var_37965_17_non_const_f3 - ((0.1111111119F) * (((__T2728 - ((3.0F) * __T2729)) + (((4.5F) * __T2729) * __T2729)) - ((1.5F) * __T2731))))));
# 2018 "txInterpTest.cu"
__cuda_local_var_37965_20_non_const_f4 = (__cuda_local_var_37965_20_non_const_f4 - (omega * (__cuda_local_var_37965_20_non_const_f4 - ((0.1111111119F) * (((__T2728 - ((3.0F) * __T2730)) + (((4.5F) * __T2730) * __T2730)) - ((1.5F) * __T2731))))));
# 2018 "txInterpTest.cu"
__cuda_local_var_37965_23_non_const_f5 = ((float)(((double)__cuda_local_var_37965_23_non_const_f5) - (((double)omega) * (((double)__cuda_local_var_37965_23_non_const_f5) - ((0.02777777777999999864) * ((double)(((__T2728 + ((3.0F) * (__T2729 + __T2730))) + (((4.5F) * (__T2729 + __T2730)) * (__T2729 + __T2730))) - ((1.5F) * __T2731))))))));
# 2018 "txInterpTest.cu"
__cuda_local_var_37965_26_non_const_f6 = ((float)(((double)__cuda_local_var_37965_26_non_const_f6) - (((double)omega) * (((double)__cuda_local_var_37965_26_non_const_f6) - ((0.02777777777999999864) * ((double)(((__T2728 + ((3.0F) * ((-__T2729) + __T2730))) + (((4.5F) * ((-__T2729) + __T2730)) * ((-__T2729) + __T2730))) - ((1.5F) * __T2731))))))));
# 2018 "txInterpTest.cu"
__cuda_local_var_37965_29_non_const_f7 = ((float)(((double)__cuda_local_var_37965_29_non_const_f7) - (((double)omega) * (((double)__cuda_local_var_37965_29_non_const_f7) - ((0.02777777777999999864) * ((double)(((__T2728 + ((3.0F) * ((-__T2729) - __T2730))) + (((4.5F) * ((-__T2729) - __T2730)) * ((-__T2729) - __T2730))) - ((1.5F) * __T2731))))))));
# 2018 "txInterpTest.cu"
__cuda_local_var_37965_32_non_const_f8 = ((float)(((double)__cuda_local_var_37965_32_non_const_f8) - (((double)omega) * (((double)__cuda_local_var_37965_32_non_const_f8) - ((0.02777777777999999864) * ((double)(((__T2728 + ((3.0F) * (__T2729 - __T2730))) + (((4.5F) * (__T2729 - __T2730)) * (__T2729 - __T2730))) - ((1.5F) * __T2731))))))));
# 2018 "txInterpTest.cu"
}
# 2018 "txInterpTest.cu"
}
# 2018 "txInterpTest.cu"
}
# 2020 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37962_6_non_const_x) + (((unsigned long)__cuda_local_var_37963_6_non_const_y) * pitch)) + ((0UL * pitch) * 768UL)))]) = __cuda_local_var_37965_8_non_const_f0;
# 2021 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37962_6_non_const_x) + (((unsigned long)__cuda_local_var_37963_6_non_const_y) * pitch)) + ((1UL * pitch) * 768UL)))]) = __cuda_local_var_37965_11_non_const_f1;
# 2022 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37962_6_non_const_x) + (((unsigned long)__cuda_local_var_37963_6_non_const_y) * pitch)) + ((2UL * pitch) * 768UL)))]) = __cuda_local_var_37965_14_non_const_f2;
# 2023 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37962_6_non_const_x) + (((unsigned long)__cuda_local_var_37963_6_non_const_y) * pitch)) + ((3UL * pitch) * 768UL)))]) = __cuda_local_var_37965_17_non_const_f3;
# 2024 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37962_6_non_const_x) + (((unsigned long)__cuda_local_var_37963_6_non_const_y) * pitch)) + ((4UL * pitch) * 768UL)))]) = __cuda_local_var_37965_20_non_const_f4;
# 2025 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37962_6_non_const_x) + (((unsigned long)__cuda_local_var_37963_6_non_const_y) * pitch)) + ((5UL * pitch) * 768UL)))]) = __cuda_local_var_37965_23_non_const_f5;
# 2026 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37962_6_non_const_x) + (((unsigned long)__cuda_local_var_37963_6_non_const_y) * pitch)) + ((6UL * pitch) * 768UL)))]) = __cuda_local_var_37965_26_non_const_f6;
# 2027 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37962_6_non_const_x) + (((unsigned long)__cuda_local_var_37963_6_non_const_y) * pitch)) + ((7UL * pitch) * 768UL)))]) = __cuda_local_var_37965_29_non_const_f7;
# 2028 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_37962_6_non_const_x) + (((unsigned long)__cuda_local_var_37963_6_non_const_y) * pitch)) + ((8UL * pitch) * 768UL)))]) = __cuda_local_var_37965_32_non_const_f8;
# 2030 "txInterpTest.cu"
}
# 2032 "txInterpTest.cu"
{
# 2032 "txInterpTest.cu"
__syncthreads();
# 2032 "txInterpTest.cu"
}
# 2033 "txInterpTest.cu"
if ((((__cuda_local_var_37967_30_non_const_check)[0]) == 1) && (((long)t) >= 10000000000L))
# 2033 "txInterpTest.cu"
{
# 2035 "txInterpTest.cu"
 int __cuda_local_var_38038_6_non_const_nTotalThreads;
# 2035 "txInterpTest.cu"
__cuda_local_var_38038_6_non_const_nTotalThreads = ((int)(blockDim.x));
# 2036 "txInterpTest.cu"
while (__cuda_local_var_38038_6_non_const_nTotalThreads > 1)
# 2036 "txInterpTest.cu"
{
# 2037 "txInterpTest.cu"
 int __cuda_local_var_38040_7_non_const_halfPoint;
# 2037 "txInterpTest.cu"
__cuda_local_var_38040_7_non_const_halfPoint = (__cuda_local_var_38038_6_non_const_nTotalThreads >> 1);
# 2038 "txInterpTest.cu"
if ((threadIdx.x) < ((unsigned)__cuda_local_var_38040_7_non_const_halfPoint))
# 2038 "txInterpTest.cu"
{
# 2039 "txInterpTest.cu"
((__cuda_local_var_37966_32_non_const_sumX)[(threadIdx.x)]) += ((__cuda_local_var_37966_32_non_const_sumX)[((threadIdx.x) + ((unsigned)__cuda_local_var_38040_7_non_const_halfPoint))]);
# 2040 "txInterpTest.cu"
((__cuda_local_var_37966_43_non_const_sumY)[(threadIdx.x)]) += ((__cuda_local_var_37966_43_non_const_sumY)[((threadIdx.x) + ((unsigned)__cuda_local_var_38040_7_non_const_halfPoint))]);
# 2041 "txInterpTest.cu"
}
# 2042 "txInterpTest.cu"
{
# 2042 "txInterpTest.cu"
__syncthreads();
# 2042 "txInterpTest.cu"
}
# 2043 "txInterpTest.cu"
__cuda_local_var_38038_6_non_const_nTotalThreads = __cuda_local_var_38040_7_non_const_halfPoint;
# 2044 "txInterpTest.cu"
}
# 2045 "txInterpTest.cu"
if ((threadIdx.x) == 0U)
# 2045 "txInterpTest.cu"
{
# 2046 "txInterpTest.cu"
_Z9atomicAddPff((FX + t), ((__cuda_local_var_37966_32_non_const_sumX)[0]));
# 2047 "txInterpTest.cu"
_Z9atomicAddPff((FY + t), ((__cuda_local_var_37966_43_non_const_sumY)[0]));
# 2048 "txInterpTest.cu"
}
# 2049 "txInterpTest.cu"
}
# 2051 "txInterpTest.cu"
}
# 2052 "txInterpTest.cu"
}
# 2052 "txInterpTest.cu"
}}
# 2054 "txInterpTest.cu"
__attribute__((global)) __attribute__((__used__)) void _Z17mrt_d_hybBA_forcePfS_fmS_S_i(
# 2054 "txInterpTest.cu"
float *fin,
# 2054 "txInterpTest.cu"
float *fout,
# 2055 "txInterpTest.cu"
float omega,
# 2055 "txInterpTest.cu"
size_t pitch,
# 2055 "txInterpTest.cu"
float *FX,
# 2055 "txInterpTest.cu"
float *FY,
# 2055 "txInterpTest.cu"
int t){
# 2055 "txInterpTest.cu"
{
# 2056 "txInterpTest.cu"
{
# 2057 "txInterpTest.cu"
 int __cuda_local_var_38060_6_non_const_x;
# 2058 "txInterpTest.cu"
 int __cuda_local_var_38061_6_non_const_y;
# 2059 "txInterpTest.cu"
 int __cuda_local_var_38062_6_non_const_j;
# 2060 "txInterpTest.cu"
 float __cuda_local_var_38063_8_non_const_f0;
# 2060 "txInterpTest.cu"
 float __cuda_local_var_38063_11_non_const_f1;
# 2060 "txInterpTest.cu"
 float __cuda_local_var_38063_14_non_const_f2;
# 2060 "txInterpTest.cu"
 float __cuda_local_var_38063_17_non_const_f3;
# 2060 "txInterpTest.cu"
 float __cuda_local_var_38063_20_non_const_f4;
# 2060 "txInterpTest.cu"
 float __cuda_local_var_38063_23_non_const_f5;
# 2060 "txInterpTest.cu"
 float __cuda_local_var_38063_26_non_const_f6;
# 2060 "txInterpTest.cu"
 float __cuda_local_var_38063_29_non_const_f7;
# 2060 "txInterpTest.cu"
 float __cuda_local_var_38063_32_non_const_f8;
# 2061 "txInterpTest.cu"
static __attribute__((__used__)) __attribute__((shared)) float __cuda_local_var_38064_32_non_const_sumX[128];
# 2061 "txInterpTest.cu"
static __attribute__((__used__)) __attribute__((shared)) float __cuda_local_var_38064_43_non_const_sumY[128];
# 2062 "txInterpTest.cu"
static __attribute__((__used__)) __attribute__((shared)) int __cuda_local_var_38065_30_non_const_check[1];
# 2057 "txInterpTest.cu"
__cuda_local_var_38060_6_non_const_x = ((int)((threadIdx.x) + ((blockIdx.x) * (blockDim.x))));
# 2058 "txInterpTest.cu"
__cuda_local_var_38061_6_non_const_y = ((int)((threadIdx.y) + ((blockIdx.y) * (blockDim.y))));
# 2059 "txInterpTest.cu"
__cuda_local_var_38062_6_non_const_j = ((int)(((unsigned long)__cuda_local_var_38060_6_non_const_x) + (((unsigned long)__cuda_local_var_38061_6_non_const_y) * pitch)));
# 2063 "txInterpTest.cu"
((__cuda_local_var_38065_30_non_const_check)[0]) = 0;
# 2064 "txInterpTest.cu"
{
# 2064 "txInterpTest.cu"
__syncthreads();
# 2064 "txInterpTest.cu"
}
# 2066 "txInterpTest.cu"
if ((((((1) && (((double)__cuda_local_var_38060_6_non_const_x) > (416.625))) && (((double)__cuda_local_var_38060_6_non_const_x) < (606.375))) && (((double)__cuda_local_var_38061_6_non_const_y) > (320.625))) && (((double)__cuda_local_var_38061_6_non_const_y) < (446.375))) || (__cuda_local_var_38060_6_non_const_x > 1023))
# 2066 "txInterpTest.cu"
{
# 2067 "txInterpTest.cu"
}
# 2068 "txInterpTest.cu"
else
# 2068 "txInterpTest.cu"
{
# 2068 "txInterpTest.cu"
 __texture_type__ __T2732;
# 2069 "txInterpTest.cu"
 float __T2733;
# 2070 "txInterpTest.cu"
 float __T2734;
# 2071 "txInterpTest.cu"
 float4 __T2735;
# 2072 "txInterpTest.cu"
 float4 __T2736;
# 2073 "txInterpTest.cu"
 __texture_type__ __T2737;
# 2074 "txInterpTest.cu"
 float __T2738;
# 2075 "txInterpTest.cu"
 float __T2739;
# 2076 "txInterpTest.cu"
 float4 __T2740;
# 2077 "txInterpTest.cu"
 float4 __T2741;
# 2078 "txInterpTest.cu"
 __texture_type__ __T2742;
# 2079 "txInterpTest.cu"
 float __T2743;
# 2080 "txInterpTest.cu"
 float __T2744;
# 2081 "txInterpTest.cu"
 float4 __T2745;
# 2082 "txInterpTest.cu"
 float4 __T2746;
# 2083 "txInterpTest.cu"
 __texture_type__ __T2747;
# 2084 "txInterpTest.cu"
 float __T2748;
# 2085 "txInterpTest.cu"
 float __T2749;
# 2086 "txInterpTest.cu"
 float4 __T2750;
# 2087 "txInterpTest.cu"
 float4 __T2751;
# 2088 "txInterpTest.cu"
 __texture_type__ __T2752;
# 2089 "txInterpTest.cu"
 float __T2753;
# 2090 "txInterpTest.cu"
 float __T2754;
# 2091 "txInterpTest.cu"
 float4 __T2755;
# 2092 "txInterpTest.cu"
 float4 __T2756;
# 2093 "txInterpTest.cu"
 __texture_type__ __T2757;
# 2094 "txInterpTest.cu"
 float __T2758;
# 2095 "txInterpTest.cu"
 float __T2759;
# 2096 "txInterpTest.cu"
 float4 __T2760;
# 2097 "txInterpTest.cu"
 float4 __T2761;
# 2098 "txInterpTest.cu"
 float __T2762;
# 2099 "txInterpTest.cu"
 float __T2763;
# 2100 "txInterpTest.cu"
 float __T2764;
# 2101 "txInterpTest.cu"
 float __T2765;
# 2087 "txInterpTest.cu"
 int __cuda_local_var_38090_6_non_const_im;
# 2070 "txInterpTest.cu"
__cuda_local_var_38063_8_non_const_f0 = (fin[__cuda_local_var_38062_6_non_const_j]);
# 2071 "txInterpTest.cu"
__cuda_local_var_38063_14_non_const_f2 = (fin[((int)((((unsigned long)__cuda_local_var_38060_6_non_const_x) + (((unsigned long)(__cuda_local_var_38061_6_non_const_y - 1)) * pitch)) + ((2UL * pitch) * 768UL)))]);
# 2072 "txInterpTest.cu"
__cuda_local_var_38063_20_non_const_f4 = (fin[((int)((((unsigned long)__cuda_local_var_38060_6_non_const_x) + (((unsigned long)(__cuda_local_var_38061_6_non_const_y + 1)) * pitch)) + ((4UL * pitch) * 768UL)))]);
# 2080 "txInterpTest.cu"
__cuda_local_var_38063_11_non_const_f1 = ((((__T2732 = texRef_f1B) , ((void)(__T2733 = (((float)(__cuda_local_var_38060_6_non_const_x - 1)) + (0.5F))))) , ((void)(__T2734 = (((float)__cuda_local_var_38061_6_non_const_y) + (0.5F))))) , ((__T2736 = (__ftexfetch2D(__T2732, ((((((__T2735.x) = __T2733) , ((void)((__T2735.y) = __T2734))) , ((void)((__T2735.z) = (0.0F)))) , ((void)((__T2735.w) = (0.0F)))) , __T2735)))) , (__T2736.x)));
# 2081 "txInterpTest.cu"
__cuda_local_var_38063_17_non_const_f3 = ((((__T2737 = texRef_f3B) , ((void)(__T2738 = (((float)(__cuda_local_var_38060_6_non_const_x + 1)) + (0.5F))))) , ((void)(__T2739 = (((float)__cuda_local_var_38061_6_non_const_y) + (0.5F))))) , ((__T2741 = (__ftexfetch2D(__T2737, ((((((__T2740.x) = __T2738) , ((void)((__T2740.y) = __T2739))) , ((void)((__T2740.z) = (0.0F)))) , ((void)((__T2740.w) = (0.0F)))) , __T2740)))) , (__T2741.x)));
# 2082 "txInterpTest.cu"
__cuda_local_var_38063_23_non_const_f5 = ((((__T2742 = texRef_f5B) , ((void)(__T2743 = (((float)(__cuda_local_var_38060_6_non_const_x - 1)) + (0.5F))))) , ((void)(__T2744 = (((float)(__cuda_local_var_38061_6_non_const_y - 1)) + (0.5F))))) , ((__T2746 = (__ftexfetch2D(__T2742, ((((((__T2745.x) = __T2743) , ((void)((__T2745.y) = __T2744))) , ((void)((__T2745.z) = (0.0F)))) , ((void)((__T2745.w) = (0.0F)))) , __T2745)))) , (__T2746.x)));
# 2083 "txInterpTest.cu"
__cuda_local_var_38063_26_non_const_f6 = ((((__T2747 = texRef_f6B) , ((void)(__T2748 = (((float)(__cuda_local_var_38060_6_non_const_x + 1)) + (0.5F))))) , ((void)(__T2749 = (((float)(__cuda_local_var_38061_6_non_const_y - 1)) + (0.5F))))) , ((__T2751 = (__ftexfetch2D(__T2747, ((((((__T2750.x) = __T2748) , ((void)((__T2750.y) = __T2749))) , ((void)((__T2750.z) = (0.0F)))) , ((void)((__T2750.w) = (0.0F)))) , __T2750)))) , (__T2751.x)));
# 2084 "txInterpTest.cu"
__cuda_local_var_38063_29_non_const_f7 = ((((__T2752 = texRef_f7B) , ((void)(__T2753 = (((float)(__cuda_local_var_38060_6_non_const_x + 1)) + (0.5F))))) , ((void)(__T2754 = (((float)(__cuda_local_var_38061_6_non_const_y + 1)) + (0.5F))))) , ((__T2756 = (__ftexfetch2D(__T2752, ((((((__T2755.x) = __T2753) , ((void)((__T2755.y) = __T2754))) , ((void)((__T2755.z) = (0.0F)))) , ((void)((__T2755.w) = (0.0F)))) , __T2755)))) , (__T2756.x)));
# 2085 "txInterpTest.cu"
__cuda_local_var_38063_32_non_const_f8 = ((((__T2757 = texRef_f8B) , ((void)(__T2758 = (((float)(__cuda_local_var_38060_6_non_const_x - 1)) + (0.5F))))) , ((void)(__T2759 = (((float)(__cuda_local_var_38061_6_non_const_y + 1)) + (0.5F))))) , ((__T2761 = (__ftexfetch2D(__T2757, ((((((__T2760.x) = __T2758) , ((void)((__T2760.y) = __T2759))) , ((void)((__T2760.z) = (0.0F)))) , ((void)((__T2760.w) = (0.0F)))) , __T2760)))) , (__T2761.x)));
# 2087 "txInterpTest.cu"
__cuda_local_var_38090_6_non_const_im = (_Z8ImageFcnii(__cuda_local_var_38060_6_non_const_x, __cuda_local_var_38061_6_non_const_y));
# 2088 "txInterpTest.cu"
if ((__cuda_local_var_38090_6_non_const_im == 1) || (__cuda_local_var_38090_6_non_const_im == 10))
# 2088 "txInterpTest.cu"
{
# 2089 "txInterpTest.cu"
if (__cuda_local_var_38090_6_non_const_im == 10)
# 2089 "txInterpTest.cu"
{
# 2090 "txInterpTest.cu"
((__cuda_local_var_38065_30_non_const_check)[0]) = 1;
# 2091 "txInterpTest.cu"
((__cuda_local_var_38064_32_non_const_sumX)[(threadIdx.x)]) = (((((((2.0F) * __cuda_local_var_38063_11_non_const_f1) - ((2.0F) * __cuda_local_var_38063_17_non_const_f3)) + ((2.0F) * __cuda_local_var_38063_23_non_const_f5)) + ((2.0F) * __cuda_local_var_38063_32_non_const_f8)) - ((2.0F) * __cuda_local_var_38063_26_non_const_f6)) - ((2.0F) * __cuda_local_var_38063_29_non_const_f7));
# 2092 "txInterpTest.cu"
((__cuda_local_var_38064_43_non_const_sumY)[(threadIdx.x)]) = (((((((2.0F) * __cuda_local_var_38063_14_non_const_f2) - ((2.0F) * __cuda_local_var_38063_20_non_const_f4)) + ((2.0F) * __cuda_local_var_38063_23_non_const_f5)) - ((2.0F) * __cuda_local_var_38063_32_non_const_f8)) + ((2.0F) * __cuda_local_var_38063_26_non_const_f6)) - ((2.0F) * __cuda_local_var_38063_29_non_const_f7));
# 2093 "txInterpTest.cu"
}
# 2094 "txInterpTest.cu"
else
# 2094 "txInterpTest.cu"
{
# 2095 "txInterpTest.cu"
((__cuda_local_var_38064_32_non_const_sumX)[(threadIdx.x)]) = (0.0F);
# 2096 "txInterpTest.cu"
((__cuda_local_var_38064_43_non_const_sumY)[(threadIdx.x)]) = (0.0F);
# 2097 "txInterpTest.cu"
}
# 2098 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_38060_6_non_const_x) + (((unsigned long)__cuda_local_var_38061_6_non_const_y) * pitch)) + ((1UL * pitch) * 768UL)))]) = __cuda_local_var_38063_17_non_const_f3;
# 2099 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_38060_6_non_const_x) + (((unsigned long)__cuda_local_var_38061_6_non_const_y) * pitch)) + ((2UL * pitch) * 768UL)))]) = __cuda_local_var_38063_20_non_const_f4;
# 2100 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_38060_6_non_const_x) + (((unsigned long)__cuda_local_var_38061_6_non_const_y) * pitch)) + ((3UL * pitch) * 768UL)))]) = __cuda_local_var_38063_11_non_const_f1;
# 2101 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_38060_6_non_const_x) + (((unsigned long)__cuda_local_var_38061_6_non_const_y) * pitch)) + ((4UL * pitch) * 768UL)))]) = __cuda_local_var_38063_14_non_const_f2;
# 2102 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_38060_6_non_const_x) + (((unsigned long)__cuda_local_var_38061_6_non_const_y) * pitch)) + ((5UL * pitch) * 768UL)))]) = __cuda_local_var_38063_29_non_const_f7;
# 2103 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_38060_6_non_const_x) + (((unsigned long)__cuda_local_var_38061_6_non_const_y) * pitch)) + ((6UL * pitch) * 768UL)))]) = __cuda_local_var_38063_32_non_const_f8;
# 2104 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_38060_6_non_const_x) + (((unsigned long)__cuda_local_var_38061_6_non_const_y) * pitch)) + ((7UL * pitch) * 768UL)))]) = __cuda_local_var_38063_23_non_const_f5;
# 2105 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_38060_6_non_const_x) + (((unsigned long)__cuda_local_var_38061_6_non_const_y) * pitch)) + ((8UL * pitch) * 768UL)))]) = __cuda_local_var_38063_26_non_const_f6;
# 2106 "txInterpTest.cu"
}
# 2107 "txInterpTest.cu"
else
# 2107 "txInterpTest.cu"
{
# 2108 "txInterpTest.cu"
((__cuda_local_var_38064_32_non_const_sumX)[(threadIdx.x)]) = (0.0F);
# 2109 "txInterpTest.cu"
((__cuda_local_var_38064_43_non_const_sumY)[(threadIdx.x)]) = (0.0F);
# 2131 "txInterpTest.cu"
_Z16boundaries_forceRfS_S_S_S_S_S_S_S_ii((&__cuda_local_var_38063_8_non_const_f0), (&__cuda_local_var_38063_11_non_const_f1), (&__cuda_local_var_38063_14_non_const_f2), (&__cuda_local_var_38063_17_non_const_f3), (&__cuda_local_var_38063_20_non_const_f4), (&__cuda_local_var_38063_23_non_const_f5), (&__cuda_local_var_38063_26_non_const_f6), (&__cuda_local_var_38063_29_non_const_f7), (&__cuda_local_var_38063_32_non_const_f8), __cuda_local_var_38061_6_non_const_y, __cuda_local_var_38090_6_non_const_im);
# 2133 "txInterpTest.cu"
if (((const char *)"BGK") == ((const char *)"MRT"))
# 2133 "txInterpTest.cu"
{
# 2134 "txInterpTest.cu"
_Z11mrt_collideRfS_S_S_S_S_S_S_S_f((&__cuda_local_var_38063_8_non_const_f0), (&__cuda_local_var_38063_11_non_const_f1), (&__cuda_local_var_38063_14_non_const_f2), (&__cuda_local_var_38063_17_non_const_f3), (&__cuda_local_var_38063_20_non_const_f4), (&__cuda_local_var_38063_23_non_const_f5), (&__cuda_local_var_38063_26_non_const_f6), (&__cuda_local_var_38063_29_non_const_f7), (&__cuda_local_var_38063_32_non_const_f8), omega);
# 2134 "txInterpTest.cu"
}
# 2134 "txInterpTest.cu"
else
# 2134 "txInterpTest.cu"
{
# 2135 "txInterpTest.cu"
if (1)
# 2135 "txInterpTest.cu"
{
# 2136 "txInterpTest.cu"
{
# 2136 "txInterpTest.cu"
__T2762 = ((((((((__cuda_local_var_38063_8_non_const_f0 + __cuda_local_var_38063_11_non_const_f1) + __cuda_local_var_38063_14_non_const_f2) + __cuda_local_var_38063_17_non_const_f3) + __cuda_local_var_38063_20_non_const_f4) + __cuda_local_var_38063_23_non_const_f5) + __cuda_local_var_38063_26_non_const_f6) + __cuda_local_var_38063_29_non_const_f7) + __cuda_local_var_38063_32_non_const_f8);
# 2136 "txInterpTest.cu"
__T2763 = (((((__cuda_local_var_38063_11_non_const_f1 - __cuda_local_var_38063_17_non_const_f3) + __cuda_local_var_38063_23_non_const_f5) - __cuda_local_var_38063_26_non_const_f6) - __cuda_local_var_38063_29_non_const_f7) + __cuda_local_var_38063_32_non_const_f8);
# 2136 "txInterpTest.cu"
__T2764 = (((((__cuda_local_var_38063_14_non_const_f2 - __cuda_local_var_38063_20_non_const_f4) + __cuda_local_var_38063_23_non_const_f5) + __cuda_local_var_38063_26_non_const_f6) - __cuda_local_var_38063_29_non_const_f7) - __cuda_local_var_38063_32_non_const_f8);
# 2136 "txInterpTest.cu"
__T2765 = ((__T2763 * __T2763) + (__T2764 * __T2764));
# 2136 "txInterpTest.cu"
__cuda_local_var_38063_8_non_const_f0 = (__cuda_local_var_38063_8_non_const_f0 - (omega * (__cuda_local_var_38063_8_non_const_f0 - ((0.4444444478F) * (__T2762 - ((1.5F) * __T2765))))));
# 2136 "txInterpTest.cu"
__cuda_local_var_38063_11_non_const_f1 = (__cuda_local_var_38063_11_non_const_f1 - (omega * (__cuda_local_var_38063_11_non_const_f1 - ((0.1111111119F) * (((__T2762 + ((3.0F) * __T2763)) + (((4.5F) * __T2763) * __T2763)) - ((1.5F) * __T2765))))));
# 2136 "txInterpTest.cu"
__cuda_local_var_38063_14_non_const_f2 = (__cuda_local_var_38063_14_non_const_f2 - (omega * (__cuda_local_var_38063_14_non_const_f2 - ((0.1111111119F) * (((__T2762 + ((3.0F) * __T2764)) + (((4.5F) * __T2764) * __T2764)) - ((1.5F) * __T2765))))));
# 2136 "txInterpTest.cu"
__cuda_local_var_38063_17_non_const_f3 = (__cuda_local_var_38063_17_non_const_f3 - (omega * (__cuda_local_var_38063_17_non_const_f3 - ((0.1111111119F) * (((__T2762 - ((3.0F) * __T2763)) + (((4.5F) * __T2763) * __T2763)) - ((1.5F) * __T2765))))));
# 2136 "txInterpTest.cu"
__cuda_local_var_38063_20_non_const_f4 = (__cuda_local_var_38063_20_non_const_f4 - (omega * (__cuda_local_var_38063_20_non_const_f4 - ((0.1111111119F) * (((__T2762 - ((3.0F) * __T2764)) + (((4.5F) * __T2764) * __T2764)) - ((1.5F) * __T2765))))));
# 2136 "txInterpTest.cu"
__cuda_local_var_38063_23_non_const_f5 = ((float)(((double)__cuda_local_var_38063_23_non_const_f5) - (((double)omega) * (((double)__cuda_local_var_38063_23_non_const_f5) - ((0.02777777777999999864) * ((double)(((__T2762 + ((3.0F) * (__T2763 + __T2764))) + (((4.5F) * (__T2763 + __T2764)) * (__T2763 + __T2764))) - ((1.5F) * __T2765))))))));
# 2136 "txInterpTest.cu"
__cuda_local_var_38063_26_non_const_f6 = ((float)(((double)__cuda_local_var_38063_26_non_const_f6) - (((double)omega) * (((double)__cuda_local_var_38063_26_non_const_f6) - ((0.02777777777999999864) * ((double)(((__T2762 + ((3.0F) * ((-__T2763) + __T2764))) + (((4.5F) * ((-__T2763) + __T2764)) * ((-__T2763) + __T2764))) - ((1.5F) * __T2765))))))));
# 2136 "txInterpTest.cu"
__cuda_local_var_38063_29_non_const_f7 = ((float)(((double)__cuda_local_var_38063_29_non_const_f7) - (((double)omega) * (((double)__cuda_local_var_38063_29_non_const_f7) - ((0.02777777777999999864) * ((double)(((__T2762 + ((3.0F) * ((-__T2763) - __T2764))) + (((4.5F) * ((-__T2763) - __T2764)) * ((-__T2763) - __T2764))) - ((1.5F) * __T2765))))))));
# 2136 "txInterpTest.cu"
__cuda_local_var_38063_32_non_const_f8 = ((float)(((double)__cuda_local_var_38063_32_non_const_f8) - (((double)omega) * (((double)__cuda_local_var_38063_32_non_const_f8) - ((0.02777777777999999864) * ((double)(((__T2762 + ((3.0F) * (__T2763 - __T2764))) + (((4.5F) * (__T2763 - __T2764)) * (__T2763 - __T2764))) - ((1.5F) * __T2765))))))));
# 2136 "txInterpTest.cu"
}
# 2136 "txInterpTest.cu"
}
# 2136 "txInterpTest.cu"
}
# 2138 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_38060_6_non_const_x) + (((unsigned long)__cuda_local_var_38061_6_non_const_y) * pitch)) + ((0UL * pitch) * 768UL)))]) = __cuda_local_var_38063_8_non_const_f0;
# 2139 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_38060_6_non_const_x) + (((unsigned long)__cuda_local_var_38061_6_non_const_y) * pitch)) + ((1UL * pitch) * 768UL)))]) = __cuda_local_var_38063_11_non_const_f1;
# 2140 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_38060_6_non_const_x) + (((unsigned long)__cuda_local_var_38061_6_non_const_y) * pitch)) + ((2UL * pitch) * 768UL)))]) = __cuda_local_var_38063_14_non_const_f2;
# 2141 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_38060_6_non_const_x) + (((unsigned long)__cuda_local_var_38061_6_non_const_y) * pitch)) + ((3UL * pitch) * 768UL)))]) = __cuda_local_var_38063_17_non_const_f3;
# 2142 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_38060_6_non_const_x) + (((unsigned long)__cuda_local_var_38061_6_non_const_y) * pitch)) + ((4UL * pitch) * 768UL)))]) = __cuda_local_var_38063_20_non_const_f4;
# 2143 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_38060_6_non_const_x) + (((unsigned long)__cuda_local_var_38061_6_non_const_y) * pitch)) + ((5UL * pitch) * 768UL)))]) = __cuda_local_var_38063_23_non_const_f5;
# 2144 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_38060_6_non_const_x) + (((unsigned long)__cuda_local_var_38061_6_non_const_y) * pitch)) + ((6UL * pitch) * 768UL)))]) = __cuda_local_var_38063_26_non_const_f6;
# 2145 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_38060_6_non_const_x) + (((unsigned long)__cuda_local_var_38061_6_non_const_y) * pitch)) + ((7UL * pitch) * 768UL)))]) = __cuda_local_var_38063_29_non_const_f7;
# 2146 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_38060_6_non_const_x) + (((unsigned long)__cuda_local_var_38061_6_non_const_y) * pitch)) + ((8UL * pitch) * 768UL)))]) = __cuda_local_var_38063_32_non_const_f8;
# 2148 "txInterpTest.cu"
}
# 2150 "txInterpTest.cu"
{
# 2150 "txInterpTest.cu"
__syncthreads();
# 2150 "txInterpTest.cu"
}
# 2151 "txInterpTest.cu"
if ((((__cuda_local_var_38065_30_non_const_check)[0]) == 1) && (((long)t) >= 10000000000L))
# 2151 "txInterpTest.cu"
{
# 2153 "txInterpTest.cu"
 int __cuda_local_var_38136_6_non_const_nTotalThreads;
# 2153 "txInterpTest.cu"
__cuda_local_var_38136_6_non_const_nTotalThreads = ((int)(blockDim.x));
# 2154 "txInterpTest.cu"
while (__cuda_local_var_38136_6_non_const_nTotalThreads > 1)
# 2154 "txInterpTest.cu"
{
# 2155 "txInterpTest.cu"
 int __cuda_local_var_38138_7_non_const_halfPoint;
# 2155 "txInterpTest.cu"
__cuda_local_var_38138_7_non_const_halfPoint = (__cuda_local_var_38136_6_non_const_nTotalThreads >> 1);
# 2156 "txInterpTest.cu"
if ((threadIdx.x) < ((unsigned)__cuda_local_var_38138_7_non_const_halfPoint))
# 2156 "txInterpTest.cu"
{
# 2157 "txInterpTest.cu"
((__cuda_local_var_38064_32_non_const_sumX)[(threadIdx.x)]) += ((__cuda_local_var_38064_32_non_const_sumX)[((threadIdx.x) + ((unsigned)__cuda_local_var_38138_7_non_const_halfPoint))]);
# 2158 "txInterpTest.cu"
((__cuda_local_var_38064_43_non_const_sumY)[(threadIdx.x)]) += ((__cuda_local_var_38064_43_non_const_sumY)[((threadIdx.x) + ((unsigned)__cuda_local_var_38138_7_non_const_halfPoint))]);
# 2159 "txInterpTest.cu"
}
# 2160 "txInterpTest.cu"
{
# 2160 "txInterpTest.cu"
__syncthreads();
# 2160 "txInterpTest.cu"
}
# 2161 "txInterpTest.cu"
__cuda_local_var_38136_6_non_const_nTotalThreads = __cuda_local_var_38138_7_non_const_halfPoint;
# 2162 "txInterpTest.cu"
}
# 2163 "txInterpTest.cu"
if ((threadIdx.x) == 0U)
# 2163 "txInterpTest.cu"
{
# 2164 "txInterpTest.cu"
_Z9atomicAddPff((FX + t), ((__cuda_local_var_38064_32_non_const_sumX)[0]));
# 2165 "txInterpTest.cu"
_Z9atomicAddPff((FY + t), ((__cuda_local_var_38064_43_non_const_sumY)[0]));
# 2166 "txInterpTest.cu"
}
# 2167 "txInterpTest.cu"
}
# 2169 "txInterpTest.cu"
}
# 2170 "txInterpTest.cu"
}
# 2170 "txInterpTest.cu"
}}
# 2172 "txInterpTest.cu"
__attribute__((global)) __attribute__((__used__)) void _Z11mrt_d_hybABPfS_fm(
# 2172 "txInterpTest.cu"
float *fin,
# 2172 "txInterpTest.cu"
float *fout,
# 2173 "txInterpTest.cu"
float omega,
# 2173 "txInterpTest.cu"
size_t pitch){
# 2173 "txInterpTest.cu"
{
# 2174 "txInterpTest.cu"
{
# 2175 "txInterpTest.cu"
 int __cuda_local_var_38158_6_non_const_x;
# 2176 "txInterpTest.cu"
 int __cuda_local_var_38159_6_non_const_y;
# 2177 "txInterpTest.cu"
 int __cuda_local_var_38160_6_non_const_j;
# 2178 "txInterpTest.cu"
 float __cuda_local_var_38161_8_non_const_f0;
# 2178 "txInterpTest.cu"
 float __cuda_local_var_38161_11_non_const_f1;
# 2178 "txInterpTest.cu"
 float __cuda_local_var_38161_14_non_const_f2;
# 2178 "txInterpTest.cu"
 float __cuda_local_var_38161_17_non_const_f3;
# 2178 "txInterpTest.cu"
 float __cuda_local_var_38161_20_non_const_f4;
# 2178 "txInterpTest.cu"
 float __cuda_local_var_38161_23_non_const_f5;
# 2178 "txInterpTest.cu"
 float __cuda_local_var_38161_26_non_const_f6;
# 2178 "txInterpTest.cu"
 float __cuda_local_var_38161_29_non_const_f7;
# 2178 "txInterpTest.cu"
 float __cuda_local_var_38161_32_non_const_f8;
# 2175 "txInterpTest.cu"
__cuda_local_var_38158_6_non_const_x = ((int)((threadIdx.x) + ((blockIdx.x) * (blockDim.x))));
# 2176 "txInterpTest.cu"
__cuda_local_var_38159_6_non_const_y = ((int)((threadIdx.y) + ((blockIdx.y) * (blockDim.y))));
# 2177 "txInterpTest.cu"
__cuda_local_var_38160_6_non_const_j = ((int)(((unsigned long)__cuda_local_var_38158_6_non_const_x) + (((unsigned long)__cuda_local_var_38159_6_non_const_y) * pitch)));
# 2180 "txInterpTest.cu"
if ((((((1) && (((double)__cuda_local_var_38158_6_non_const_x) > (416.625))) && (((double)__cuda_local_var_38158_6_non_const_x) < (606.375))) && (((double)__cuda_local_var_38159_6_non_const_y) > (320.625))) && (((double)__cuda_local_var_38159_6_non_const_y) < (446.375))) || (__cuda_local_var_38158_6_non_const_x > 1023))
# 2180 "txInterpTest.cu"
{
# 2181 "txInterpTest.cu"
}
# 2182 "txInterpTest.cu"
else
# 2182 "txInterpTest.cu"
{
# 2182 "txInterpTest.cu"
 __texture_type__ __T2766;
# 2183 "txInterpTest.cu"
 float __T2767;
# 2184 "txInterpTest.cu"
 float __T2768;
# 2185 "txInterpTest.cu"
 float4 __T2769;
# 2186 "txInterpTest.cu"
 float4 __T2770;
# 2187 "txInterpTest.cu"
 __texture_type__ __T2771;
# 2188 "txInterpTest.cu"
 float __T2772;
# 2189 "txInterpTest.cu"
 float __T2773;
# 2190 "txInterpTest.cu"
 float4 __T2774;
# 2191 "txInterpTest.cu"
 float4 __T2775;
# 2192 "txInterpTest.cu"
 __texture_type__ __T2776;
# 2193 "txInterpTest.cu"
 float __T2777;
# 2194 "txInterpTest.cu"
 float __T2778;
# 2195 "txInterpTest.cu"
 float4 __T2779;
# 2196 "txInterpTest.cu"
 float4 __T2780;
# 2197 "txInterpTest.cu"
 __texture_type__ __T2781;
# 2198 "txInterpTest.cu"
 float __T2782;
# 2199 "txInterpTest.cu"
 float __T2783;
# 2200 "txInterpTest.cu"
 float4 __T2784;
# 2201 "txInterpTest.cu"
 float4 __T2785;
# 2202 "txInterpTest.cu"
 __texture_type__ __T2786;
# 2203 "txInterpTest.cu"
 float __T2787;
# 2204 "txInterpTest.cu"
 float __T2788;
# 2205 "txInterpTest.cu"
 float4 __T2789;
# 2206 "txInterpTest.cu"
 float4 __T2790;
# 2207 "txInterpTest.cu"
 __texture_type__ __T2791;
# 2208 "txInterpTest.cu"
 float __T2792;
# 2209 "txInterpTest.cu"
 float __T2793;
# 2210 "txInterpTest.cu"
 float4 __T2794;
# 2211 "txInterpTest.cu"
 float4 __T2795;
# 2194 "txInterpTest.cu"
 int __cuda_local_var_38177_6_non_const_im;
# 2184 "txInterpTest.cu"
__cuda_local_var_38161_8_non_const_f0 = (fin[__cuda_local_var_38160_6_non_const_j]);
# 2185 "txInterpTest.cu"
__cuda_local_var_38161_14_non_const_f2 = (fin[((int)((((unsigned long)__cuda_local_var_38158_6_non_const_x) + (((unsigned long)(__cuda_local_var_38159_6_non_const_y - 1)) * pitch)) + ((2UL * pitch) * 768UL)))]);
# 2186 "txInterpTest.cu"
__cuda_local_var_38161_20_non_const_f4 = (fin[((int)((((unsigned long)__cuda_local_var_38158_6_non_const_x) + (((unsigned long)(__cuda_local_var_38159_6_non_const_y + 1)) * pitch)) + ((4UL * pitch) * 768UL)))]);
# 2187 "txInterpTest.cu"
__cuda_local_var_38161_11_non_const_f1 = ((((__T2766 = texRef_f1A) , ((void)(__T2767 = (((float)(__cuda_local_var_38158_6_non_const_x - 1)) + (0.5F))))) , ((void)(__T2768 = (((float)__cuda_local_var_38159_6_non_const_y) + (0.5F))))) , ((__T2770 = (__ftexfetch2D(__T2766, ((((((__T2769.x) = __T2767) , ((void)((__T2769.y) = __T2768))) , ((void)((__T2769.z) = (0.0F)))) , ((void)((__T2769.w) = (0.0F)))) , __T2769)))) , (__T2770.x)));
# 2188 "txInterpTest.cu"
__cuda_local_var_38161_17_non_const_f3 = ((((__T2771 = texRef_f3A) , ((void)(__T2772 = (((float)(__cuda_local_var_38158_6_non_const_x + 1)) + (0.5F))))) , ((void)(__T2773 = (((float)__cuda_local_var_38159_6_non_const_y) + (0.5F))))) , ((__T2775 = (__ftexfetch2D(__T2771, ((((((__T2774.x) = __T2772) , ((void)((__T2774.y) = __T2773))) , ((void)((__T2774.z) = (0.0F)))) , ((void)((__T2774.w) = (0.0F)))) , __T2774)))) , (__T2775.x)));
# 2189 "txInterpTest.cu"
__cuda_local_var_38161_23_non_const_f5 = ((((__T2776 = texRef_f5A) , ((void)(__T2777 = (((float)(__cuda_local_var_38158_6_non_const_x - 1)) + (0.5F))))) , ((void)(__T2778 = (((float)(__cuda_local_var_38159_6_non_const_y - 1)) + (0.5F))))) , ((__T2780 = (__ftexfetch2D(__T2776, ((((((__T2779.x) = __T2777) , ((void)((__T2779.y) = __T2778))) , ((void)((__T2779.z) = (0.0F)))) , ((void)((__T2779.w) = (0.0F)))) , __T2779)))) , (__T2780.x)));
# 2190 "txInterpTest.cu"
__cuda_local_var_38161_26_non_const_f6 = ((((__T2781 = texRef_f6A) , ((void)(__T2782 = (((float)(__cuda_local_var_38158_6_non_const_x + 1)) + (0.5F))))) , ((void)(__T2783 = (((float)(__cuda_local_var_38159_6_non_const_y - 1)) + (0.5F))))) , ((__T2785 = (__ftexfetch2D(__T2781, ((((((__T2784.x) = __T2782) , ((void)((__T2784.y) = __T2783))) , ((void)((__T2784.z) = (0.0F)))) , ((void)((__T2784.w) = (0.0F)))) , __T2784)))) , (__T2785.x)));
# 2191 "txInterpTest.cu"
__cuda_local_var_38161_29_non_const_f7 = ((((__T2786 = texRef_f7A) , ((void)(__T2787 = (((float)(__cuda_local_var_38158_6_non_const_x + 1)) + (0.5F))))) , ((void)(__T2788 = (((float)(__cuda_local_var_38159_6_non_const_y + 1)) + (0.5F))))) , ((__T2790 = (__ftexfetch2D(__T2786, ((((((__T2789.x) = __T2787) , ((void)((__T2789.y) = __T2788))) , ((void)((__T2789.z) = (0.0F)))) , ((void)((__T2789.w) = (0.0F)))) , __T2789)))) , (__T2790.x)));
# 2192 "txInterpTest.cu"
__cuda_local_var_38161_32_non_const_f8 = ((((__T2791 = texRef_f8A) , ((void)(__T2792 = (((float)(__cuda_local_var_38158_6_non_const_x - 1)) + (0.5F))))) , ((void)(__T2793 = (((float)(__cuda_local_var_38159_6_non_const_y + 1)) + (0.5F))))) , ((__T2795 = (__ftexfetch2D(__T2791, ((((((__T2794.x) = __T2792) , ((void)((__T2794.y) = __T2793))) , ((void)((__T2794.z) = (0.0F)))) , ((void)((__T2794.w) = (0.0F)))) , __T2794)))) , (__T2795.x)));
# 2194 "txInterpTest.cu"
__cuda_local_var_38177_6_non_const_im = (_Z8ImageFcnii(__cuda_local_var_38158_6_non_const_x, __cuda_local_var_38159_6_non_const_y));
# 2195 "txInterpTest.cu"
if ((__cuda_local_var_38177_6_non_const_im == 1) || (__cuda_local_var_38177_6_non_const_im == 10))
# 2195 "txInterpTest.cu"
{
# 2196 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_38158_6_non_const_x) + (((unsigned long)__cuda_local_var_38159_6_non_const_y) * pitch)) + ((1UL * pitch) * 768UL)))]) = __cuda_local_var_38161_17_non_const_f3;
# 2197 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_38158_6_non_const_x) + (((unsigned long)__cuda_local_var_38159_6_non_const_y) * pitch)) + ((2UL * pitch) * 768UL)))]) = __cuda_local_var_38161_20_non_const_f4;
# 2198 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_38158_6_non_const_x) + (((unsigned long)__cuda_local_var_38159_6_non_const_y) * pitch)) + ((3UL * pitch) * 768UL)))]) = __cuda_local_var_38161_11_non_const_f1;
# 2199 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_38158_6_non_const_x) + (((unsigned long)__cuda_local_var_38159_6_non_const_y) * pitch)) + ((4UL * pitch) * 768UL)))]) = __cuda_local_var_38161_14_non_const_f2;
# 2200 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_38158_6_non_const_x) + (((unsigned long)__cuda_local_var_38159_6_non_const_y) * pitch)) + ((5UL * pitch) * 768UL)))]) = __cuda_local_var_38161_29_non_const_f7;
# 2201 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_38158_6_non_const_x) + (((unsigned long)__cuda_local_var_38159_6_non_const_y) * pitch)) + ((6UL * pitch) * 768UL)))]) = __cuda_local_var_38161_32_non_const_f8;
# 2202 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_38158_6_non_const_x) + (((unsigned long)__cuda_local_var_38159_6_non_const_y) * pitch)) + ((7UL * pitch) * 768UL)))]) = __cuda_local_var_38161_23_non_const_f5;
# 2203 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_38158_6_non_const_x) + (((unsigned long)__cuda_local_var_38159_6_non_const_y) * pitch)) + ((8UL * pitch) * 768UL)))]) = __cuda_local_var_38161_26_non_const_f6;
# 2204 "txInterpTest.cu"
}
# 2205 "txInterpTest.cu"
else
# 2205 "txInterpTest.cu"
{
# 2227 "txInterpTest.cu"
_Z10boundariesRfS_S_S_S_S_S_S_S_ii((&__cuda_local_var_38161_8_non_const_f0), (&__cuda_local_var_38161_11_non_const_f1), (&__cuda_local_var_38161_14_non_const_f2), (&__cuda_local_var_38161_17_non_const_f3), (&__cuda_local_var_38161_20_non_const_f4), (&__cuda_local_var_38161_23_non_const_f5), (&__cuda_local_var_38161_26_non_const_f6), (&__cuda_local_var_38161_29_non_const_f7), (&__cuda_local_var_38161_32_non_const_f8), __cuda_local_var_38159_6_non_const_y, __cuda_local_var_38177_6_non_const_im);
# 2229 "txInterpTest.cu"
if (((const char *)"BGK") == ((const char *)"MRT"))
# 2229 "txInterpTest.cu"
{
# 2230 "txInterpTest.cu"
_Z11mrt_collideRfS_S_S_S_S_S_S_S_f((&__cuda_local_var_38161_8_non_const_f0), (&__cuda_local_var_38161_11_non_const_f1), (&__cuda_local_var_38161_14_non_const_f2), (&__cuda_local_var_38161_17_non_const_f3), (&__cuda_local_var_38161_20_non_const_f4), (&__cuda_local_var_38161_23_non_const_f5), (&__cuda_local_var_38161_26_non_const_f6), (&__cuda_local_var_38161_29_non_const_f7), (&__cuda_local_var_38161_32_non_const_f8), omega);
# 2230 "txInterpTest.cu"
}
# 2230 "txInterpTest.cu"
else
# 2230 "txInterpTest.cu"
{
# 2231 "txInterpTest.cu"
if (1)
# 2231 "txInterpTest.cu"
{
# 2231 "txInterpTest.cu"
 float __T2796;
# 2232 "txInterpTest.cu"
 float __T2797;
# 2233 "txInterpTest.cu"
 float __T2798;
# 2234 "txInterpTest.cu"
 float __T2799;
# 2232 "txInterpTest.cu"
{
# 2232 "txInterpTest.cu"
__T2796 = ((((((((__cuda_local_var_38161_8_non_const_f0 + __cuda_local_var_38161_11_non_const_f1) + __cuda_local_var_38161_14_non_const_f2) + __cuda_local_var_38161_17_non_const_f3) + __cuda_local_var_38161_20_non_const_f4) + __cuda_local_var_38161_23_non_const_f5) + __cuda_local_var_38161_26_non_const_f6) + __cuda_local_var_38161_29_non_const_f7) + __cuda_local_var_38161_32_non_const_f8);
# 2232 "txInterpTest.cu"
__T2797 = (((((__cuda_local_var_38161_11_non_const_f1 - __cuda_local_var_38161_17_non_const_f3) + __cuda_local_var_38161_23_non_const_f5) - __cuda_local_var_38161_26_non_const_f6) - __cuda_local_var_38161_29_non_const_f7) + __cuda_local_var_38161_32_non_const_f8);
# 2232 "txInterpTest.cu"
__T2798 = (((((__cuda_local_var_38161_14_non_const_f2 - __cuda_local_var_38161_20_non_const_f4) + __cuda_local_var_38161_23_non_const_f5) + __cuda_local_var_38161_26_non_const_f6) - __cuda_local_var_38161_29_non_const_f7) - __cuda_local_var_38161_32_non_const_f8);
# 2232 "txInterpTest.cu"
__T2799 = ((__T2797 * __T2797) + (__T2798 * __T2798));
# 2232 "txInterpTest.cu"
__cuda_local_var_38161_8_non_const_f0 = (__cuda_local_var_38161_8_non_const_f0 - (omega * (__cuda_local_var_38161_8_non_const_f0 - ((0.4444444478F) * (__T2796 - ((1.5F) * __T2799))))));
# 2232 "txInterpTest.cu"
__cuda_local_var_38161_11_non_const_f1 = (__cuda_local_var_38161_11_non_const_f1 - (omega * (__cuda_local_var_38161_11_non_const_f1 - ((0.1111111119F) * (((__T2796 + ((3.0F) * __T2797)) + (((4.5F) * __T2797) * __T2797)) - ((1.5F) * __T2799))))));
# 2232 "txInterpTest.cu"
__cuda_local_var_38161_14_non_const_f2 = (__cuda_local_var_38161_14_non_const_f2 - (omega * (__cuda_local_var_38161_14_non_const_f2 - ((0.1111111119F) * (((__T2796 + ((3.0F) * __T2798)) + (((4.5F) * __T2798) * __T2798)) - ((1.5F) * __T2799))))));
# 2232 "txInterpTest.cu"
__cuda_local_var_38161_17_non_const_f3 = (__cuda_local_var_38161_17_non_const_f3 - (omega * (__cuda_local_var_38161_17_non_const_f3 - ((0.1111111119F) * (((__T2796 - ((3.0F) * __T2797)) + (((4.5F) * __T2797) * __T2797)) - ((1.5F) * __T2799))))));
# 2232 "txInterpTest.cu"
__cuda_local_var_38161_20_non_const_f4 = (__cuda_local_var_38161_20_non_const_f4 - (omega * (__cuda_local_var_38161_20_non_const_f4 - ((0.1111111119F) * (((__T2796 - ((3.0F) * __T2798)) + (((4.5F) * __T2798) * __T2798)) - ((1.5F) * __T2799))))));
# 2232 "txInterpTest.cu"
__cuda_local_var_38161_23_non_const_f5 = ((float)(((double)__cuda_local_var_38161_23_non_const_f5) - (((double)omega) * (((double)__cuda_local_var_38161_23_non_const_f5) - ((0.02777777777999999864) * ((double)(((__T2796 + ((3.0F) * (__T2797 + __T2798))) + (((4.5F) * (__T2797 + __T2798)) * (__T2797 + __T2798))) - ((1.5F) * __T2799))))))));
# 2232 "txInterpTest.cu"
__cuda_local_var_38161_26_non_const_f6 = ((float)(((double)__cuda_local_var_38161_26_non_const_f6) - (((double)omega) * (((double)__cuda_local_var_38161_26_non_const_f6) - ((0.02777777777999999864) * ((double)(((__T2796 + ((3.0F) * ((-__T2797) + __T2798))) + (((4.5F) * ((-__T2797) + __T2798)) * ((-__T2797) + __T2798))) - ((1.5F) * __T2799))))))));
# 2232 "txInterpTest.cu"
__cuda_local_var_38161_29_non_const_f7 = ((float)(((double)__cuda_local_var_38161_29_non_const_f7) - (((double)omega) * (((double)__cuda_local_var_38161_29_non_const_f7) - ((0.02777777777999999864) * ((double)(((__T2796 + ((3.0F) * ((-__T2797) - __T2798))) + (((4.5F) * ((-__T2797) - __T2798)) * ((-__T2797) - __T2798))) - ((1.5F) * __T2799))))))));
# 2232 "txInterpTest.cu"
__cuda_local_var_38161_32_non_const_f8 = ((float)(((double)__cuda_local_var_38161_32_non_const_f8) - (((double)omega) * (((double)__cuda_local_var_38161_32_non_const_f8) - ((0.02777777777999999864) * ((double)(((__T2796 + ((3.0F) * (__T2797 - __T2798))) + (((4.5F) * (__T2797 - __T2798)) * (__T2797 - __T2798))) - ((1.5F) * __T2799))))))));
# 2232 "txInterpTest.cu"
}
# 2232 "txInterpTest.cu"
}
# 2232 "txInterpTest.cu"
}
# 2233 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_38158_6_non_const_x) + (((unsigned long)__cuda_local_var_38159_6_non_const_y) * pitch)) + ((0UL * pitch) * 768UL)))]) = __cuda_local_var_38161_8_non_const_f0;
# 2234 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_38158_6_non_const_x) + (((unsigned long)__cuda_local_var_38159_6_non_const_y) * pitch)) + ((1UL * pitch) * 768UL)))]) = __cuda_local_var_38161_11_non_const_f1;
# 2235 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_38158_6_non_const_x) + (((unsigned long)__cuda_local_var_38159_6_non_const_y) * pitch)) + ((2UL * pitch) * 768UL)))]) = __cuda_local_var_38161_14_non_const_f2;
# 2236 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_38158_6_non_const_x) + (((unsigned long)__cuda_local_var_38159_6_non_const_y) * pitch)) + ((3UL * pitch) * 768UL)))]) = __cuda_local_var_38161_17_non_const_f3;
# 2237 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_38158_6_non_const_x) + (((unsigned long)__cuda_local_var_38159_6_non_const_y) * pitch)) + ((4UL * pitch) * 768UL)))]) = __cuda_local_var_38161_20_non_const_f4;
# 2238 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_38158_6_non_const_x) + (((unsigned long)__cuda_local_var_38159_6_non_const_y) * pitch)) + ((5UL * pitch) * 768UL)))]) = __cuda_local_var_38161_23_non_const_f5;
# 2239 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_38158_6_non_const_x) + (((unsigned long)__cuda_local_var_38159_6_non_const_y) * pitch)) + ((6UL * pitch) * 768UL)))]) = __cuda_local_var_38161_26_non_const_f6;
# 2240 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_38158_6_non_const_x) + (((unsigned long)__cuda_local_var_38159_6_non_const_y) * pitch)) + ((7UL * pitch) * 768UL)))]) = __cuda_local_var_38161_29_non_const_f7;
# 2241 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_38158_6_non_const_x) + (((unsigned long)__cuda_local_var_38159_6_non_const_y) * pitch)) + ((8UL * pitch) * 768UL)))]) = __cuda_local_var_38161_32_non_const_f8;
# 2242 "txInterpTest.cu"
}
# 2243 "txInterpTest.cu"
}
# 2244 "txInterpTest.cu"
}
# 2244 "txInterpTest.cu"
}}
# 2245 "txInterpTest.cu"
__attribute__((global)) __attribute__((__used__)) void _Z11mrt_d_hybBAPfS_fm(
# 2245 "txInterpTest.cu"
float *fin,
# 2245 "txInterpTest.cu"
float *fout,
# 2246 "txInterpTest.cu"
float omega,
# 2246 "txInterpTest.cu"
size_t pitch){
# 2246 "txInterpTest.cu"
{
# 2247 "txInterpTest.cu"
{
# 2247 "txInterpTest.cu"
 __texture_type__ __T2800;
# 2248 "txInterpTest.cu"
 float __T2801;
# 2249 "txInterpTest.cu"
 float __T2802;
# 2250 "txInterpTest.cu"
 float4 __T2803;
# 2251 "txInterpTest.cu"
 float4 __T2804;
# 2252 "txInterpTest.cu"
 __texture_type__ __T2805;
# 2253 "txInterpTest.cu"
 float __T2806;
# 2254 "txInterpTest.cu"
 float __T2807;
# 2255 "txInterpTest.cu"
 float4 __T2808;
# 2256 "txInterpTest.cu"
 float4 __T2809;
# 2257 "txInterpTest.cu"
 __texture_type__ __T2810;
# 2258 "txInterpTest.cu"
 float __T2811;
# 2259 "txInterpTest.cu"
 float __T2812;
# 2260 "txInterpTest.cu"
 float4 __T2813;
# 2261 "txInterpTest.cu"
 float4 __T2814;
# 2262 "txInterpTest.cu"
 __texture_type__ __T2815;
# 2263 "txInterpTest.cu"
 float __T2816;
# 2264 "txInterpTest.cu"
 float __T2817;
# 2265 "txInterpTest.cu"
 float4 __T2818;
# 2266 "txInterpTest.cu"
 float4 __T2819;
# 2267 "txInterpTest.cu"
 __texture_type__ __T2820;
# 2268 "txInterpTest.cu"
 float __T2821;
# 2269 "txInterpTest.cu"
 float __T2822;
# 2270 "txInterpTest.cu"
 float4 __T2823;
# 2271 "txInterpTest.cu"
 float4 __T2824;
# 2272 "txInterpTest.cu"
 __texture_type__ __T2825;
# 2273 "txInterpTest.cu"
 float __T2826;
# 2274 "txInterpTest.cu"
 float __T2827;
# 2275 "txInterpTest.cu"
 float4 __T2828;
# 2276 "txInterpTest.cu"
 float4 __T2829;
# 2248 "txInterpTest.cu"
 int __cuda_local_var_38211_6_non_const_x;
# 2249 "txInterpTest.cu"
 int __cuda_local_var_38212_6_non_const_y;
# 2250 "txInterpTest.cu"
 int __cuda_local_var_38213_6_non_const_j;
# 2251 "txInterpTest.cu"
 float __cuda_local_var_38214_8_non_const_f0;
# 2251 "txInterpTest.cu"
 float __cuda_local_var_38214_11_non_const_f1;
# 2251 "txInterpTest.cu"
 float __cuda_local_var_38214_14_non_const_f2;
# 2251 "txInterpTest.cu"
 float __cuda_local_var_38214_17_non_const_f3;
# 2251 "txInterpTest.cu"
 float __cuda_local_var_38214_20_non_const_f4;
# 2251 "txInterpTest.cu"
 float __cuda_local_var_38214_23_non_const_f5;
# 2251 "txInterpTest.cu"
 float __cuda_local_var_38214_26_non_const_f6;
# 2251 "txInterpTest.cu"
 float __cuda_local_var_38214_29_non_const_f7;
# 2251 "txInterpTest.cu"
 float __cuda_local_var_38214_32_non_const_f8;
# 2265 "txInterpTest.cu"
 int __cuda_local_var_38228_6_non_const_im;
# 2248 "txInterpTest.cu"
__cuda_local_var_38211_6_non_const_x = ((int)((threadIdx.x) + ((blockIdx.x) * (blockDim.x))));
# 2249 "txInterpTest.cu"
__cuda_local_var_38212_6_non_const_y = ((int)((threadIdx.y) + ((blockIdx.y) * (blockDim.y))));
# 2250 "txInterpTest.cu"
__cuda_local_var_38213_6_non_const_j = ((int)(((unsigned long)__cuda_local_var_38211_6_non_const_x) + (((unsigned long)__cuda_local_var_38212_6_non_const_y) * pitch)));
# 2255 "txInterpTest.cu"
__cuda_local_var_38214_8_non_const_f0 = (fin[__cuda_local_var_38213_6_non_const_j]);
# 2256 "txInterpTest.cu"
__cuda_local_var_38214_14_non_const_f2 = (fin[((int)((((unsigned long)__cuda_local_var_38211_6_non_const_x) + (((unsigned long)(__cuda_local_var_38212_6_non_const_y - 1)) * pitch)) + ((2UL * pitch) * 768UL)))]);
# 2257 "txInterpTest.cu"
__cuda_local_var_38214_20_non_const_f4 = (fin[((int)((((unsigned long)__cuda_local_var_38211_6_non_const_x) + (((unsigned long)(__cuda_local_var_38212_6_non_const_y + 1)) * pitch)) + ((4UL * pitch) * 768UL)))]);
# 2258 "txInterpTest.cu"
__cuda_local_var_38214_11_non_const_f1 = ((((__T2800 = texRef_f1B) , ((void)(__T2801 = (((float)(__cuda_local_var_38211_6_non_const_x - 1)) + (0.5F))))) , ((void)(__T2802 = (((float)__cuda_local_var_38212_6_non_const_y) + (0.5F))))) , ((__T2804 = (__ftexfetch2D(__T2800, ((((((__T2803.x) = __T2801) , ((void)((__T2803.y) = __T2802))) , ((void)((__T2803.z) = (0.0F)))) , ((void)((__T2803.w) = (0.0F)))) , __T2803)))) , (__T2804.x)));
# 2259 "txInterpTest.cu"
__cuda_local_var_38214_17_non_const_f3 = ((((__T2805 = texRef_f3B) , ((void)(__T2806 = (((float)(__cuda_local_var_38211_6_non_const_x + 1)) + (0.5F))))) , ((void)(__T2807 = (((float)__cuda_local_var_38212_6_non_const_y) + (0.5F))))) , ((__T2809 = (__ftexfetch2D(__T2805, ((((((__T2808.x) = __T2806) , ((void)((__T2808.y) = __T2807))) , ((void)((__T2808.z) = (0.0F)))) , ((void)((__T2808.w) = (0.0F)))) , __T2808)))) , (__T2809.x)));
# 2260 "txInterpTest.cu"
__cuda_local_var_38214_23_non_const_f5 = ((((__T2810 = texRef_f5B) , ((void)(__T2811 = (((float)(__cuda_local_var_38211_6_non_const_x - 1)) + (0.5F))))) , ((void)(__T2812 = (((float)(__cuda_local_var_38212_6_non_const_y - 1)) + (0.5F))))) , ((__T2814 = (__ftexfetch2D(__T2810, ((((((__T2813.x) = __T2811) , ((void)((__T2813.y) = __T2812))) , ((void)((__T2813.z) = (0.0F)))) , ((void)((__T2813.w) = (0.0F)))) , __T2813)))) , (__T2814.x)));
# 2261 "txInterpTest.cu"
__cuda_local_var_38214_26_non_const_f6 = ((((__T2815 = texRef_f6B) , ((void)(__T2816 = (((float)(__cuda_local_var_38211_6_non_const_x + 1)) + (0.5F))))) , ((void)(__T2817 = (((float)(__cuda_local_var_38212_6_non_const_y - 1)) + (0.5F))))) , ((__T2819 = (__ftexfetch2D(__T2815, ((((((__T2818.x) = __T2816) , ((void)((__T2818.y) = __T2817))) , ((void)((__T2818.z) = (0.0F)))) , ((void)((__T2818.w) = (0.0F)))) , __T2818)))) , (__T2819.x)));
# 2262 "txInterpTest.cu"
__cuda_local_var_38214_29_non_const_f7 = ((((__T2820 = texRef_f7B) , ((void)(__T2821 = (((float)(__cuda_local_var_38211_6_non_const_x + 1)) + (0.5F))))) , ((void)(__T2822 = (((float)(__cuda_local_var_38212_6_non_const_y + 1)) + (0.5F))))) , ((__T2824 = (__ftexfetch2D(__T2820, ((((((__T2823.x) = __T2821) , ((void)((__T2823.y) = __T2822))) , ((void)((__T2823.z) = (0.0F)))) , ((void)((__T2823.w) = (0.0F)))) , __T2823)))) , (__T2824.x)));
# 2263 "txInterpTest.cu"
__cuda_local_var_38214_32_non_const_f8 = ((((__T2825 = texRef_f8B) , ((void)(__T2826 = (((float)(__cuda_local_var_38211_6_non_const_x - 1)) + (0.5F))))) , ((void)(__T2827 = (((float)(__cuda_local_var_38212_6_non_const_y + 1)) + (0.5F))))) , ((__T2829 = (__ftexfetch2D(__T2825, ((((((__T2828.x) = __T2826) , ((void)((__T2828.y) = __T2827))) , ((void)((__T2828.z) = (0.0F)))) , ((void)((__T2828.w) = (0.0F)))) , __T2828)))) , (__T2829.x)));
# 2265 "txInterpTest.cu"
__cuda_local_var_38228_6_non_const_im = (_Z8ImageFcnii(__cuda_local_var_38211_6_non_const_x, __cuda_local_var_38212_6_non_const_y));
# 2266 "txInterpTest.cu"
if ((__cuda_local_var_38228_6_non_const_im == 1) || (__cuda_local_var_38228_6_non_const_im == 10))
# 2266 "txInterpTest.cu"
{
# 2267 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_38211_6_non_const_x) + (((unsigned long)__cuda_local_var_38212_6_non_const_y) * pitch)) + ((1UL * pitch) * 768UL)))]) = __cuda_local_var_38214_17_non_const_f3;
# 2268 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_38211_6_non_const_x) + (((unsigned long)__cuda_local_var_38212_6_non_const_y) * pitch)) + ((2UL * pitch) * 768UL)))]) = __cuda_local_var_38214_20_non_const_f4;
# 2269 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_38211_6_non_const_x) + (((unsigned long)__cuda_local_var_38212_6_non_const_y) * pitch)) + ((3UL * pitch) * 768UL)))]) = __cuda_local_var_38214_11_non_const_f1;
# 2270 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_38211_6_non_const_x) + (((unsigned long)__cuda_local_var_38212_6_non_const_y) * pitch)) + ((4UL * pitch) * 768UL)))]) = __cuda_local_var_38214_14_non_const_f2;
# 2271 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_38211_6_non_const_x) + (((unsigned long)__cuda_local_var_38212_6_non_const_y) * pitch)) + ((5UL * pitch) * 768UL)))]) = __cuda_local_var_38214_29_non_const_f7;
# 2272 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_38211_6_non_const_x) + (((unsigned long)__cuda_local_var_38212_6_non_const_y) * pitch)) + ((6UL * pitch) * 768UL)))]) = __cuda_local_var_38214_32_non_const_f8;
# 2273 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_38211_6_non_const_x) + (((unsigned long)__cuda_local_var_38212_6_non_const_y) * pitch)) + ((7UL * pitch) * 768UL)))]) = __cuda_local_var_38214_23_non_const_f5;
# 2274 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_38211_6_non_const_x) + (((unsigned long)__cuda_local_var_38212_6_non_const_y) * pitch)) + ((8UL * pitch) * 768UL)))]) = __cuda_local_var_38214_26_non_const_f6;
# 2275 "txInterpTest.cu"
}
# 2276 "txInterpTest.cu"
else
# 2276 "txInterpTest.cu"
{
# 2298 "txInterpTest.cu"
_Z10boundariesRfS_S_S_S_S_S_S_S_ii((&__cuda_local_var_38214_11_non_const_f1), (&__cuda_local_var_38214_11_non_const_f1), (&__cuda_local_var_38214_14_non_const_f2), (&__cuda_local_var_38214_17_non_const_f3), (&__cuda_local_var_38214_20_non_const_f4), (&__cuda_local_var_38214_23_non_const_f5), (&__cuda_local_var_38214_26_non_const_f6), (&__cuda_local_var_38214_29_non_const_f7), (&__cuda_local_var_38214_32_non_const_f8), __cuda_local_var_38212_6_non_const_y, __cuda_local_var_38228_6_non_const_im);
# 2300 "txInterpTest.cu"
if (((const char *)"BGK") == ((const char *)"MRT"))
# 2300 "txInterpTest.cu"
{
# 2301 "txInterpTest.cu"
_Z11mrt_collideRfS_S_S_S_S_S_S_S_f((&__cuda_local_var_38214_8_non_const_f0), (&__cuda_local_var_38214_11_non_const_f1), (&__cuda_local_var_38214_14_non_const_f2), (&__cuda_local_var_38214_17_non_const_f3), (&__cuda_local_var_38214_20_non_const_f4), (&__cuda_local_var_38214_23_non_const_f5), (&__cuda_local_var_38214_26_non_const_f6), (&__cuda_local_var_38214_29_non_const_f7), (&__cuda_local_var_38214_32_non_const_f8), omega);
# 2301 "txInterpTest.cu"
}
# 2301 "txInterpTest.cu"
else
# 2301 "txInterpTest.cu"
{
# 2302 "txInterpTest.cu"
if (1)
# 2302 "txInterpTest.cu"
{
# 2302 "txInterpTest.cu"
 float __T2830;
# 2303 "txInterpTest.cu"
 float __T2831;
# 2304 "txInterpTest.cu"
 float __T2832;
# 2305 "txInterpTest.cu"
 float __T2833;
# 2303 "txInterpTest.cu"
{
# 2303 "txInterpTest.cu"
__T2830 = ((((((((__cuda_local_var_38214_8_non_const_f0 + __cuda_local_var_38214_11_non_const_f1) + __cuda_local_var_38214_14_non_const_f2) + __cuda_local_var_38214_17_non_const_f3) + __cuda_local_var_38214_20_non_const_f4) + __cuda_local_var_38214_23_non_const_f5) + __cuda_local_var_38214_26_non_const_f6) + __cuda_local_var_38214_29_non_const_f7) + __cuda_local_var_38214_32_non_const_f8);
# 2303 "txInterpTest.cu"
__T2831 = (((((__cuda_local_var_38214_11_non_const_f1 - __cuda_local_var_38214_17_non_const_f3) + __cuda_local_var_38214_23_non_const_f5) - __cuda_local_var_38214_26_non_const_f6) - __cuda_local_var_38214_29_non_const_f7) + __cuda_local_var_38214_32_non_const_f8);
# 2303 "txInterpTest.cu"
__T2832 = (((((__cuda_local_var_38214_14_non_const_f2 - __cuda_local_var_38214_20_non_const_f4) + __cuda_local_var_38214_23_non_const_f5) + __cuda_local_var_38214_26_non_const_f6) - __cuda_local_var_38214_29_non_const_f7) - __cuda_local_var_38214_32_non_const_f8);
# 2303 "txInterpTest.cu"
__T2833 = ((__T2831 * __T2831) + (__T2832 * __T2832));
# 2303 "txInterpTest.cu"
__cuda_local_var_38214_8_non_const_f0 = (__cuda_local_var_38214_8_non_const_f0 - (omega * (__cuda_local_var_38214_8_non_const_f0 - ((0.4444444478F) * (__T2830 - ((1.5F) * __T2833))))));
# 2303 "txInterpTest.cu"
__cuda_local_var_38214_11_non_const_f1 = (__cuda_local_var_38214_11_non_const_f1 - (omega * (__cuda_local_var_38214_11_non_const_f1 - ((0.1111111119F) * (((__T2830 + ((3.0F) * __T2831)) + (((4.5F) * __T2831) * __T2831)) - ((1.5F) * __T2833))))));
# 2303 "txInterpTest.cu"
__cuda_local_var_38214_14_non_const_f2 = (__cuda_local_var_38214_14_non_const_f2 - (omega * (__cuda_local_var_38214_14_non_const_f2 - ((0.1111111119F) * (((__T2830 + ((3.0F) * __T2832)) + (((4.5F) * __T2832) * __T2832)) - ((1.5F) * __T2833))))));
# 2303 "txInterpTest.cu"
__cuda_local_var_38214_17_non_const_f3 = (__cuda_local_var_38214_17_non_const_f3 - (omega * (__cuda_local_var_38214_17_non_const_f3 - ((0.1111111119F) * (((__T2830 - ((3.0F) * __T2831)) + (((4.5F) * __T2831) * __T2831)) - ((1.5F) * __T2833))))));
# 2303 "txInterpTest.cu"
__cuda_local_var_38214_20_non_const_f4 = (__cuda_local_var_38214_20_non_const_f4 - (omega * (__cuda_local_var_38214_20_non_const_f4 - ((0.1111111119F) * (((__T2830 - ((3.0F) * __T2832)) + (((4.5F) * __T2832) * __T2832)) - ((1.5F) * __T2833))))));
# 2303 "txInterpTest.cu"
__cuda_local_var_38214_23_non_const_f5 = ((float)(((double)__cuda_local_var_38214_23_non_const_f5) - (((double)omega) * (((double)__cuda_local_var_38214_23_non_const_f5) - ((0.02777777777999999864) * ((double)(((__T2830 + ((3.0F) * (__T2831 + __T2832))) + (((4.5F) * (__T2831 + __T2832)) * (__T2831 + __T2832))) - ((1.5F) * __T2833))))))));
# 2303 "txInterpTest.cu"
__cuda_local_var_38214_26_non_const_f6 = ((float)(((double)__cuda_local_var_38214_26_non_const_f6) - (((double)omega) * (((double)__cuda_local_var_38214_26_non_const_f6) - ((0.02777777777999999864) * ((double)(((__T2830 + ((3.0F) * ((-__T2831) + __T2832))) + (((4.5F) * ((-__T2831) + __T2832)) * ((-__T2831) + __T2832))) - ((1.5F) * __T2833))))))));
# 2303 "txInterpTest.cu"
__cuda_local_var_38214_29_non_const_f7 = ((float)(((double)__cuda_local_var_38214_29_non_const_f7) - (((double)omega) * (((double)__cuda_local_var_38214_29_non_const_f7) - ((0.02777777777999999864) * ((double)(((__T2830 + ((3.0F) * ((-__T2831) - __T2832))) + (((4.5F) * ((-__T2831) - __T2832)) * ((-__T2831) - __T2832))) - ((1.5F) * __T2833))))))));
# 2303 "txInterpTest.cu"
__cuda_local_var_38214_32_non_const_f8 = ((float)(((double)__cuda_local_var_38214_32_non_const_f8) - (((double)omega) * (((double)__cuda_local_var_38214_32_non_const_f8) - ((0.02777777777999999864) * ((double)(((__T2830 + ((3.0F) * (__T2831 - __T2832))) + (((4.5F) * (__T2831 - __T2832)) * (__T2831 - __T2832))) - ((1.5F) * __T2833))))))));
# 2303 "txInterpTest.cu"
}
# 2303 "txInterpTest.cu"
}
# 2303 "txInterpTest.cu"
}
# 2304 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_38211_6_non_const_x) + (((unsigned long)__cuda_local_var_38212_6_non_const_y) * pitch)) + ((0UL * pitch) * 768UL)))]) = __cuda_local_var_38214_8_non_const_f0;
# 2305 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_38211_6_non_const_x) + (((unsigned long)__cuda_local_var_38212_6_non_const_y) * pitch)) + ((1UL * pitch) * 768UL)))]) = __cuda_local_var_38214_11_non_const_f1;
# 2306 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_38211_6_non_const_x) + (((unsigned long)__cuda_local_var_38212_6_non_const_y) * pitch)) + ((2UL * pitch) * 768UL)))]) = __cuda_local_var_38214_14_non_const_f2;
# 2307 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_38211_6_non_const_x) + (((unsigned long)__cuda_local_var_38212_6_non_const_y) * pitch)) + ((3UL * pitch) * 768UL)))]) = __cuda_local_var_38214_17_non_const_f3;
# 2308 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_38211_6_non_const_x) + (((unsigned long)__cuda_local_var_38212_6_non_const_y) * pitch)) + ((4UL * pitch) * 768UL)))]) = __cuda_local_var_38214_20_non_const_f4;
# 2309 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_38211_6_non_const_x) + (((unsigned long)__cuda_local_var_38212_6_non_const_y) * pitch)) + ((5UL * pitch) * 768UL)))]) = __cuda_local_var_38214_23_non_const_f5;
# 2310 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_38211_6_non_const_x) + (((unsigned long)__cuda_local_var_38212_6_non_const_y) * pitch)) + ((6UL * pitch) * 768UL)))]) = __cuda_local_var_38214_26_non_const_f6;
# 2311 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_38211_6_non_const_x) + (((unsigned long)__cuda_local_var_38212_6_non_const_y) * pitch)) + ((7UL * pitch) * 768UL)))]) = __cuda_local_var_38214_29_non_const_f7;
# 2312 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_38211_6_non_const_x) + (((unsigned long)__cuda_local_var_38212_6_non_const_y) * pitch)) + ((8UL * pitch) * 768UL)))]) = __cuda_local_var_38214_32_non_const_f8;
# 2313 "txInterpTest.cu"
}
# 2315 "txInterpTest.cu"
}
# 2315 "txInterpTest.cu"
}}
# 2316 "txInterpTest.cu"
__attribute__((global)) __attribute__((__used__)) void _Z12mrt_d_textABPfS_fm(
# 2316 "txInterpTest.cu"
float *fin,
# 2316 "txInterpTest.cu"
float *fout,
# 2317 "txInterpTest.cu"
float omega,
# 2317 "txInterpTest.cu"
size_t pitch){
# 2317 "txInterpTest.cu"
{
# 2318 "txInterpTest.cu"
{
# 2318 "txInterpTest.cu"
 __texture_type__ __T2834;
# 2319 "txInterpTest.cu"
 float __T2835;
# 2320 "txInterpTest.cu"
 float __T2836;
# 2321 "txInterpTest.cu"
 float4 __T2837;
# 2322 "txInterpTest.cu"
 float4 __T2838;
# 2323 "txInterpTest.cu"
 __texture_type__ __T2839;
# 2324 "txInterpTest.cu"
 float __T2840;
# 2325 "txInterpTest.cu"
 float __T2841;
# 2326 "txInterpTest.cu"
 float4 __T2842;
# 2327 "txInterpTest.cu"
 float4 __T2843;
# 2328 "txInterpTest.cu"
 __texture_type__ __T2844;
# 2329 "txInterpTest.cu"
 float __T2845;
# 2330 "txInterpTest.cu"
 float __T2846;
# 2331 "txInterpTest.cu"
 float4 __T2847;
# 2332 "txInterpTest.cu"
 float4 __T2848;
# 2333 "txInterpTest.cu"
 __texture_type__ __T2849;
# 2334 "txInterpTest.cu"
 float __T2850;
# 2335 "txInterpTest.cu"
 float __T2851;
# 2336 "txInterpTest.cu"
 float4 __T2852;
# 2337 "txInterpTest.cu"
 float4 __T2853;
# 2338 "txInterpTest.cu"
 __texture_type__ __T2854;
# 2339 "txInterpTest.cu"
 float __T2855;
# 2340 "txInterpTest.cu"
 float __T2856;
# 2341 "txInterpTest.cu"
 float4 __T2857;
# 2342 "txInterpTest.cu"
 float4 __T2858;
# 2343 "txInterpTest.cu"
 __texture_type__ __T2859;
# 2344 "txInterpTest.cu"
 float __T2860;
# 2345 "txInterpTest.cu"
 float __T2861;
# 2346 "txInterpTest.cu"
 float4 __T2862;
# 2347 "txInterpTest.cu"
 float4 __T2863;
# 2348 "txInterpTest.cu"
 __texture_type__ __T2864;
# 2349 "txInterpTest.cu"
 float __T2865;
# 2350 "txInterpTest.cu"
 float __T2866;
# 2351 "txInterpTest.cu"
 float4 __T2867;
# 2352 "txInterpTest.cu"
 float4 __T2868;
# 2353 "txInterpTest.cu"
 __texture_type__ __T2869;
# 2354 "txInterpTest.cu"
 float __T2870;
# 2355 "txInterpTest.cu"
 float __T2871;
# 2356 "txInterpTest.cu"
 float4 __T2872;
# 2357 "txInterpTest.cu"
 float4 __T2873;
# 2319 "txInterpTest.cu"
 int __cuda_local_var_38262_6_non_const_x;
# 2320 "txInterpTest.cu"
 int __cuda_local_var_38263_6_non_const_y;
# 2321 "txInterpTest.cu"
 int __cuda_local_var_38264_6_non_const_j;
# 2322 "txInterpTest.cu"
 float __cuda_local_var_38265_8_non_const_f0;
# 2322 "txInterpTest.cu"
 float __cuda_local_var_38265_11_non_const_f1;
# 2322 "txInterpTest.cu"
 float __cuda_local_var_38265_14_non_const_f2;
# 2322 "txInterpTest.cu"
 float __cuda_local_var_38265_17_non_const_f3;
# 2322 "txInterpTest.cu"
 float __cuda_local_var_38265_20_non_const_f4;
# 2322 "txInterpTest.cu"
 float __cuda_local_var_38265_23_non_const_f5;
# 2322 "txInterpTest.cu"
 float __cuda_local_var_38265_26_non_const_f6;
# 2322 "txInterpTest.cu"
 float __cuda_local_var_38265_29_non_const_f7;
# 2322 "txInterpTest.cu"
 float __cuda_local_var_38265_32_non_const_f8;
# 2333 "txInterpTest.cu"
 int __cuda_local_var_38276_6_non_const_im;
# 2319 "txInterpTest.cu"
__cuda_local_var_38262_6_non_const_x = ((int)((threadIdx.x) + ((blockIdx.x) * (blockDim.x))));
# 2320 "txInterpTest.cu"
__cuda_local_var_38263_6_non_const_y = ((int)((threadIdx.y) + ((blockIdx.y) * (blockDim.y))));
# 2321 "txInterpTest.cu"
__cuda_local_var_38264_6_non_const_j = ((int)(((unsigned long)__cuda_local_var_38262_6_non_const_x) + (((unsigned long)__cuda_local_var_38263_6_non_const_y) * pitch)));
# 2323 "txInterpTest.cu"
__cuda_local_var_38265_8_non_const_f0 = (fin[__cuda_local_var_38264_6_non_const_j]);
# 2324 "txInterpTest.cu"
__cuda_local_var_38265_14_non_const_f2 = ((((__T2834 = texRef_f2A) , ((void)(__T2835 = (((float)__cuda_local_var_38262_6_non_const_x) + (0.5F))))) , ((void)(__T2836 = (((float)(__cuda_local_var_38263_6_non_const_y - 1)) + (0.5F))))) , ((__T2838 = (__ftexfetch2D(__T2834, ((((((__T2837.x) = __T2835) , ((void)((__T2837.y) = __T2836))) , ((void)((__T2837.z) = (0.0F)))) , ((void)((__T2837.w) = (0.0F)))) , __T2837)))) , (__T2838.x)));
# 2325 "txInterpTest.cu"
__cuda_local_var_38265_20_non_const_f4 = ((((__T2839 = texRef_f4A) , ((void)(__T2840 = (((float)__cuda_local_var_38262_6_non_const_x) + (0.5F))))) , ((void)(__T2841 = (((float)(__cuda_local_var_38263_6_non_const_y + 1)) + (0.5F))))) , ((__T2843 = (__ftexfetch2D(__T2839, ((((((__T2842.x) = __T2840) , ((void)((__T2842.y) = __T2841))) , ((void)((__T2842.z) = (0.0F)))) , ((void)((__T2842.w) = (0.0F)))) , __T2842)))) , (__T2843.x)));
# 2326 "txInterpTest.cu"
__cuda_local_var_38265_11_non_const_f1 = ((((__T2844 = texRef_f1A) , ((void)(__T2845 = (((float)(__cuda_local_var_38262_6_non_const_x - 1)) + (0.5F))))) , ((void)(__T2846 = (((float)__cuda_local_var_38263_6_non_const_y) + (0.5F))))) , ((__T2848 = (__ftexfetch2D(__T2844, ((((((__T2847.x) = __T2845) , ((void)((__T2847.y) = __T2846))) , ((void)((__T2847.z) = (0.0F)))) , ((void)((__T2847.w) = (0.0F)))) , __T2847)))) , (__T2848.x)));
# 2327 "txInterpTest.cu"
__cuda_local_var_38265_17_non_const_f3 = ((((__T2849 = texRef_f3A) , ((void)(__T2850 = (((float)(__cuda_local_var_38262_6_non_const_x + 1)) + (0.5F))))) , ((void)(__T2851 = (((float)__cuda_local_var_38263_6_non_const_y) + (0.5F))))) , ((__T2853 = (__ftexfetch2D(__T2849, ((((((__T2852.x) = __T2850) , ((void)((__T2852.y) = __T2851))) , ((void)((__T2852.z) = (0.0F)))) , ((void)((__T2852.w) = (0.0F)))) , __T2852)))) , (__T2853.x)));
# 2328 "txInterpTest.cu"
__cuda_local_var_38265_23_non_const_f5 = ((((__T2854 = texRef_f5A) , ((void)(__T2855 = (((float)(__cuda_local_var_38262_6_non_const_x - 1)) + (0.5F))))) , ((void)(__T2856 = (((float)(__cuda_local_var_38263_6_non_const_y - 1)) + (0.5F))))) , ((__T2858 = (__ftexfetch2D(__T2854, ((((((__T2857.x) = __T2855) , ((void)((__T2857.y) = __T2856))) , ((void)((__T2857.z) = (0.0F)))) , ((void)((__T2857.w) = (0.0F)))) , __T2857)))) , (__T2858.x)));
# 2329 "txInterpTest.cu"
__cuda_local_var_38265_26_non_const_f6 = ((((__T2859 = texRef_f6A) , ((void)(__T2860 = (((float)(__cuda_local_var_38262_6_non_const_x + 1)) + (0.5F))))) , ((void)(__T2861 = (((float)(__cuda_local_var_38263_6_non_const_y - 1)) + (0.5F))))) , ((__T2863 = (__ftexfetch2D(__T2859, ((((((__T2862.x) = __T2860) , ((void)((__T2862.y) = __T2861))) , ((void)((__T2862.z) = (0.0F)))) , ((void)((__T2862.w) = (0.0F)))) , __T2862)))) , (__T2863.x)));
# 2330 "txInterpTest.cu"
__cuda_local_var_38265_29_non_const_f7 = ((((__T2864 = texRef_f7A) , ((void)(__T2865 = (((float)(__cuda_local_var_38262_6_non_const_x + 1)) + (0.5F))))) , ((void)(__T2866 = (((float)(__cuda_local_var_38263_6_non_const_y + 1)) + (0.5F))))) , ((__T2868 = (__ftexfetch2D(__T2864, ((((((__T2867.x) = __T2865) , ((void)((__T2867.y) = __T2866))) , ((void)((__T2867.z) = (0.0F)))) , ((void)((__T2867.w) = (0.0F)))) , __T2867)))) , (__T2868.x)));
# 2331 "txInterpTest.cu"
__cuda_local_var_38265_32_non_const_f8 = ((((__T2869 = texRef_f8A) , ((void)(__T2870 = (((float)(__cuda_local_var_38262_6_non_const_x - 1)) + (0.5F))))) , ((void)(__T2871 = (((float)(__cuda_local_var_38263_6_non_const_y + 1)) + (0.5F))))) , ((__T2873 = (__ftexfetch2D(__T2869, ((((((__T2872.x) = __T2870) , ((void)((__T2872.y) = __T2871))) , ((void)((__T2872.z) = (0.0F)))) , ((void)((__T2872.w) = (0.0F)))) , __T2872)))) , (__T2873.x)));
# 2333 "txInterpTest.cu"
__cuda_local_var_38276_6_non_const_im = (_Z8ImageFcnii(__cuda_local_var_38262_6_non_const_x, __cuda_local_var_38263_6_non_const_y));
# 2334 "txInterpTest.cu"
if ((__cuda_local_var_38276_6_non_const_im == 1) || (__cuda_local_var_38276_6_non_const_im == 10))
# 2334 "txInterpTest.cu"
{
# 2335 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_38262_6_non_const_x) + (((unsigned long)__cuda_local_var_38263_6_non_const_y) * pitch)) + ((1UL * pitch) * 768UL)))]) = __cuda_local_var_38265_17_non_const_f3;
# 2336 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_38262_6_non_const_x) + (((unsigned long)__cuda_local_var_38263_6_non_const_y) * pitch)) + ((2UL * pitch) * 768UL)))]) = __cuda_local_var_38265_20_non_const_f4;
# 2337 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_38262_6_non_const_x) + (((unsigned long)__cuda_local_var_38263_6_non_const_y) * pitch)) + ((3UL * pitch) * 768UL)))]) = __cuda_local_var_38265_11_non_const_f1;
# 2338 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_38262_6_non_const_x) + (((unsigned long)__cuda_local_var_38263_6_non_const_y) * pitch)) + ((4UL * pitch) * 768UL)))]) = __cuda_local_var_38265_14_non_const_f2;
# 2339 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_38262_6_non_const_x) + (((unsigned long)__cuda_local_var_38263_6_non_const_y) * pitch)) + ((5UL * pitch) * 768UL)))]) = __cuda_local_var_38265_29_non_const_f7;
# 2340 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_38262_6_non_const_x) + (((unsigned long)__cuda_local_var_38263_6_non_const_y) * pitch)) + ((6UL * pitch) * 768UL)))]) = __cuda_local_var_38265_32_non_const_f8;
# 2341 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_38262_6_non_const_x) + (((unsigned long)__cuda_local_var_38263_6_non_const_y) * pitch)) + ((7UL * pitch) * 768UL)))]) = __cuda_local_var_38265_23_non_const_f5;
# 2342 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_38262_6_non_const_x) + (((unsigned long)__cuda_local_var_38263_6_non_const_y) * pitch)) + ((8UL * pitch) * 768UL)))]) = __cuda_local_var_38265_26_non_const_f6;
# 2343 "txInterpTest.cu"
}
# 2344 "txInterpTest.cu"
else
# 2344 "txInterpTest.cu"
{
# 2345 "txInterpTest.cu"
if (__cuda_local_var_38276_6_non_const_im == 2)
# 2346 "txInterpTest.cu"
{
# 2347 "txInterpTest.cu"
_Z11NeumannEastRfS_S_S_S_S_S_S_S_i((&__cuda_local_var_38265_8_non_const_f0), (&__cuda_local_var_38265_11_non_const_f1), (&__cuda_local_var_38265_14_non_const_f2), (&__cuda_local_var_38265_17_non_const_f3), (&__cuda_local_var_38265_20_non_const_f4), (&__cuda_local_var_38265_23_non_const_f5), (&__cuda_local_var_38265_26_non_const_f6), (&__cuda_local_var_38265_29_non_const_f7), (&__cuda_local_var_38265_32_non_const_f8), __cuda_local_var_38263_6_non_const_y);
# 2348 "txInterpTest.cu"
}
# 2348 "txInterpTest.cu"
else
# 2348 "txInterpTest.cu"
{
# 2349 "txInterpTest.cu"
if (__cuda_local_var_38276_6_non_const_im == 3)
# 2350 "txInterpTest.cu"
{
# 2351 "txInterpTest.cu"
_Z13DirichletWestRfS_S_S_S_S_S_S_S_i((&__cuda_local_var_38265_8_non_const_f0), (&__cuda_local_var_38265_11_non_const_f1), (&__cuda_local_var_38265_14_non_const_f2), (&__cuda_local_var_38265_17_non_const_f3), (&__cuda_local_var_38265_20_non_const_f4), (&__cuda_local_var_38265_23_non_const_f5), (&__cuda_local_var_38265_26_non_const_f6), (&__cuda_local_var_38265_29_non_const_f7), (&__cuda_local_var_38265_32_non_const_f8), __cuda_local_var_38263_6_non_const_y);
# 2352 "txInterpTest.cu"
}
# 2352 "txInterpTest.cu"
}
# 2354 "txInterpTest.cu"
if (((const char *)"BGK") == ((const char *)"MRT"))
# 2354 "txInterpTest.cu"
{
# 2355 "txInterpTest.cu"
_Z11mrt_collideRfS_S_S_S_S_S_S_S_f((&__cuda_local_var_38265_8_non_const_f0), (&__cuda_local_var_38265_11_non_const_f1), (&__cuda_local_var_38265_14_non_const_f2), (&__cuda_local_var_38265_17_non_const_f3), (&__cuda_local_var_38265_20_non_const_f4), (&__cuda_local_var_38265_23_non_const_f5), (&__cuda_local_var_38265_26_non_const_f6), (&__cuda_local_var_38265_29_non_const_f7), (&__cuda_local_var_38265_32_non_const_f8), omega);
# 2355 "txInterpTest.cu"
}
# 2355 "txInterpTest.cu"
else
# 2355 "txInterpTest.cu"
{
# 2356 "txInterpTest.cu"
if (1)
# 2356 "txInterpTest.cu"
{
# 2356 "txInterpTest.cu"
 float __T2874;
# 2357 "txInterpTest.cu"
 float __T2875;
# 2358 "txInterpTest.cu"
 float __T2876;
# 2359 "txInterpTest.cu"
 float __T2877;
# 2357 "txInterpTest.cu"
{
# 2357 "txInterpTest.cu"
__T2874 = ((((((((__cuda_local_var_38265_8_non_const_f0 + __cuda_local_var_38265_11_non_const_f1) + __cuda_local_var_38265_14_non_const_f2) + __cuda_local_var_38265_17_non_const_f3) + __cuda_local_var_38265_20_non_const_f4) + __cuda_local_var_38265_23_non_const_f5) + __cuda_local_var_38265_26_non_const_f6) + __cuda_local_var_38265_29_non_const_f7) + __cuda_local_var_38265_32_non_const_f8);
# 2357 "txInterpTest.cu"
__T2875 = (((((__cuda_local_var_38265_11_non_const_f1 - __cuda_local_var_38265_17_non_const_f3) + __cuda_local_var_38265_23_non_const_f5) - __cuda_local_var_38265_26_non_const_f6) - __cuda_local_var_38265_29_non_const_f7) + __cuda_local_var_38265_32_non_const_f8);
# 2357 "txInterpTest.cu"
__T2876 = (((((__cuda_local_var_38265_14_non_const_f2 - __cuda_local_var_38265_20_non_const_f4) + __cuda_local_var_38265_23_non_const_f5) + __cuda_local_var_38265_26_non_const_f6) - __cuda_local_var_38265_29_non_const_f7) - __cuda_local_var_38265_32_non_const_f8);
# 2357 "txInterpTest.cu"
__T2877 = ((__T2875 * __T2875) + (__T2876 * __T2876));
# 2357 "txInterpTest.cu"
__cuda_local_var_38265_8_non_const_f0 = (__cuda_local_var_38265_8_non_const_f0 - (omega * (__cuda_local_var_38265_8_non_const_f0 - ((0.4444444478F) * (__T2874 - ((1.5F) * __T2877))))));
# 2357 "txInterpTest.cu"
__cuda_local_var_38265_11_non_const_f1 = (__cuda_local_var_38265_11_non_const_f1 - (omega * (__cuda_local_var_38265_11_non_const_f1 - ((0.1111111119F) * (((__T2874 + ((3.0F) * __T2875)) + (((4.5F) * __T2875) * __T2875)) - ((1.5F) * __T2877))))));
# 2357 "txInterpTest.cu"
__cuda_local_var_38265_14_non_const_f2 = (__cuda_local_var_38265_14_non_const_f2 - (omega * (__cuda_local_var_38265_14_non_const_f2 - ((0.1111111119F) * (((__T2874 + ((3.0F) * __T2876)) + (((4.5F) * __T2876) * __T2876)) - ((1.5F) * __T2877))))));
# 2357 "txInterpTest.cu"
__cuda_local_var_38265_17_non_const_f3 = (__cuda_local_var_38265_17_non_const_f3 - (omega * (__cuda_local_var_38265_17_non_const_f3 - ((0.1111111119F) * (((__T2874 - ((3.0F) * __T2875)) + (((4.5F) * __T2875) * __T2875)) - ((1.5F) * __T2877))))));
# 2357 "txInterpTest.cu"
__cuda_local_var_38265_20_non_const_f4 = (__cuda_local_var_38265_20_non_const_f4 - (omega * (__cuda_local_var_38265_20_non_const_f4 - ((0.1111111119F) * (((__T2874 - ((3.0F) * __T2876)) + (((4.5F) * __T2876) * __T2876)) - ((1.5F) * __T2877))))));
# 2357 "txInterpTest.cu"
__cuda_local_var_38265_23_non_const_f5 = ((float)(((double)__cuda_local_var_38265_23_non_const_f5) - (((double)omega) * (((double)__cuda_local_var_38265_23_non_const_f5) - ((0.02777777777999999864) * ((double)(((__T2874 + ((3.0F) * (__T2875 + __T2876))) + (((4.5F) * (__T2875 + __T2876)) * (__T2875 + __T2876))) - ((1.5F) * __T2877))))))));
# 2357 "txInterpTest.cu"
__cuda_local_var_38265_26_non_const_f6 = ((float)(((double)__cuda_local_var_38265_26_non_const_f6) - (((double)omega) * (((double)__cuda_local_var_38265_26_non_const_f6) - ((0.02777777777999999864) * ((double)(((__T2874 + ((3.0F) * ((-__T2875) + __T2876))) + (((4.5F) * ((-__T2875) + __T2876)) * ((-__T2875) + __T2876))) - ((1.5F) * __T2877))))))));
# 2357 "txInterpTest.cu"
__cuda_local_var_38265_29_non_const_f7 = ((float)(((double)__cuda_local_var_38265_29_non_const_f7) - (((double)omega) * (((double)__cuda_local_var_38265_29_non_const_f7) - ((0.02777777777999999864) * ((double)(((__T2874 + ((3.0F) * ((-__T2875) - __T2876))) + (((4.5F) * ((-__T2875) - __T2876)) * ((-__T2875) - __T2876))) - ((1.5F) * __T2877))))))));
# 2357 "txInterpTest.cu"
__cuda_local_var_38265_32_non_const_f8 = ((float)(((double)__cuda_local_var_38265_32_non_const_f8) - (((double)omega) * (((double)__cuda_local_var_38265_32_non_const_f8) - ((0.02777777777999999864) * ((double)(((__T2874 + ((3.0F) * (__T2875 - __T2876))) + (((4.5F) * (__T2875 - __T2876)) * (__T2875 - __T2876))) - ((1.5F) * __T2877))))))));
# 2357 "txInterpTest.cu"
}
# 2357 "txInterpTest.cu"
}
# 2357 "txInterpTest.cu"
}
# 2359 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_38262_6_non_const_x) + (((unsigned long)__cuda_local_var_38263_6_non_const_y) * pitch)) + ((0UL * pitch) * 768UL)))]) = __cuda_local_var_38265_8_non_const_f0;
# 2360 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_38262_6_non_const_x) + (((unsigned long)__cuda_local_var_38263_6_non_const_y) * pitch)) + ((1UL * pitch) * 768UL)))]) = __cuda_local_var_38265_11_non_const_f1;
# 2361 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_38262_6_non_const_x) + (((unsigned long)__cuda_local_var_38263_6_non_const_y) * pitch)) + ((2UL * pitch) * 768UL)))]) = __cuda_local_var_38265_14_non_const_f2;
# 2362 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_38262_6_non_const_x) + (((unsigned long)__cuda_local_var_38263_6_non_const_y) * pitch)) + ((3UL * pitch) * 768UL)))]) = __cuda_local_var_38265_17_non_const_f3;
# 2363 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_38262_6_non_const_x) + (((unsigned long)__cuda_local_var_38263_6_non_const_y) * pitch)) + ((4UL * pitch) * 768UL)))]) = __cuda_local_var_38265_20_non_const_f4;
# 2364 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_38262_6_non_const_x) + (((unsigned long)__cuda_local_var_38263_6_non_const_y) * pitch)) + ((5UL * pitch) * 768UL)))]) = __cuda_local_var_38265_23_non_const_f5;
# 2365 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_38262_6_non_const_x) + (((unsigned long)__cuda_local_var_38263_6_non_const_y) * pitch)) + ((6UL * pitch) * 768UL)))]) = __cuda_local_var_38265_26_non_const_f6;
# 2366 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_38262_6_non_const_x) + (((unsigned long)__cuda_local_var_38263_6_non_const_y) * pitch)) + ((7UL * pitch) * 768UL)))]) = __cuda_local_var_38265_29_non_const_f7;
# 2367 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_38262_6_non_const_x) + (((unsigned long)__cuda_local_var_38263_6_non_const_y) * pitch)) + ((8UL * pitch) * 768UL)))]) = __cuda_local_var_38265_32_non_const_f8;
# 2369 "txInterpTest.cu"
}
# 2370 "txInterpTest.cu"
}
# 2370 "txInterpTest.cu"
}}
# 2371 "txInterpTest.cu"
__attribute__((global)) __attribute__((__used__)) void _Z12mrt_d_textBAPfS_fm(
# 2371 "txInterpTest.cu"
float *fin,
# 2371 "txInterpTest.cu"
float *fout,
# 2372 "txInterpTest.cu"
float omega,
# 2372 "txInterpTest.cu"
size_t pitch){
# 2372 "txInterpTest.cu"
{
# 2373 "txInterpTest.cu"
{
# 2373 "txInterpTest.cu"
 __texture_type__ __T2878;
# 2374 "txInterpTest.cu"
 float __T2879;
# 2375 "txInterpTest.cu"
 float __T2880;
# 2376 "txInterpTest.cu"
 float4 __T2881;
# 2377 "txInterpTest.cu"
 float4 __T2882;
# 2378 "txInterpTest.cu"
 __texture_type__ __T2883;
# 2379 "txInterpTest.cu"
 float __T2884;
# 2380 "txInterpTest.cu"
 float __T2885;
# 2381 "txInterpTest.cu"
 float4 __T2886;
# 2382 "txInterpTest.cu"
 float4 __T2887;
# 2383 "txInterpTest.cu"
 __texture_type__ __T2888;
# 2384 "txInterpTest.cu"
 float __T2889;
# 2385 "txInterpTest.cu"
 float __T2890;
# 2386 "txInterpTest.cu"
 float4 __T2891;
# 2387 "txInterpTest.cu"
 float4 __T2892;
# 2388 "txInterpTest.cu"
 __texture_type__ __T2893;
# 2389 "txInterpTest.cu"
 float __T2894;
# 2390 "txInterpTest.cu"
 float __T2895;
# 2391 "txInterpTest.cu"
 float4 __T2896;
# 2392 "txInterpTest.cu"
 float4 __T2897;
# 2393 "txInterpTest.cu"
 __texture_type__ __T2898;
# 2394 "txInterpTest.cu"
 float __T2899;
# 2395 "txInterpTest.cu"
 float __T2900;
# 2396 "txInterpTest.cu"
 float4 __T2901;
# 2397 "txInterpTest.cu"
 float4 __T2902;
# 2398 "txInterpTest.cu"
 __texture_type__ __T2903;
# 2399 "txInterpTest.cu"
 float __T2904;
# 2400 "txInterpTest.cu"
 float __T2905;
# 2401 "txInterpTest.cu"
 float4 __T2906;
# 2402 "txInterpTest.cu"
 float4 __T2907;
# 2403 "txInterpTest.cu"
 __texture_type__ __T2908;
# 2404 "txInterpTest.cu"
 float __T2909;
# 2405 "txInterpTest.cu"
 float __T2910;
# 2406 "txInterpTest.cu"
 float4 __T2911;
# 2407 "txInterpTest.cu"
 float4 __T2912;
# 2408 "txInterpTest.cu"
 __texture_type__ __T2913;
# 2409 "txInterpTest.cu"
 float __T2914;
# 2410 "txInterpTest.cu"
 float __T2915;
# 2411 "txInterpTest.cu"
 float4 __T2916;
# 2412 "txInterpTest.cu"
 float4 __T2917;
# 2374 "txInterpTest.cu"
 int __cuda_local_var_38317_6_non_const_x;
# 2375 "txInterpTest.cu"
 int __cuda_local_var_38318_6_non_const_y;
# 2376 "txInterpTest.cu"
 int __cuda_local_var_38319_6_non_const_j;
# 2377 "txInterpTest.cu"
 float __cuda_local_var_38320_8_non_const_f0;
# 2377 "txInterpTest.cu"
 float __cuda_local_var_38320_11_non_const_f1;
# 2377 "txInterpTest.cu"
 float __cuda_local_var_38320_14_non_const_f2;
# 2377 "txInterpTest.cu"
 float __cuda_local_var_38320_17_non_const_f3;
# 2377 "txInterpTest.cu"
 float __cuda_local_var_38320_20_non_const_f4;
# 2377 "txInterpTest.cu"
 float __cuda_local_var_38320_23_non_const_f5;
# 2377 "txInterpTest.cu"
 float __cuda_local_var_38320_26_non_const_f6;
# 2377 "txInterpTest.cu"
 float __cuda_local_var_38320_29_non_const_f7;
# 2377 "txInterpTest.cu"
 float __cuda_local_var_38320_32_non_const_f8;
# 2388 "txInterpTest.cu"
 int __cuda_local_var_38331_6_non_const_im;
# 2374 "txInterpTest.cu"
__cuda_local_var_38317_6_non_const_x = ((int)((threadIdx.x) + ((blockIdx.x) * (blockDim.x))));
# 2375 "txInterpTest.cu"
__cuda_local_var_38318_6_non_const_y = ((int)((threadIdx.y) + ((blockIdx.y) * (blockDim.y))));
# 2376 "txInterpTest.cu"
__cuda_local_var_38319_6_non_const_j = ((int)(((unsigned long)__cuda_local_var_38317_6_non_const_x) + (((unsigned long)__cuda_local_var_38318_6_non_const_y) * pitch)));
# 2378 "txInterpTest.cu"
__cuda_local_var_38320_8_non_const_f0 = (fin[__cuda_local_var_38319_6_non_const_j]);
# 2379 "txInterpTest.cu"
__cuda_local_var_38320_14_non_const_f2 = ((((__T2878 = texRef_f2B) , ((void)(__T2879 = (((float)__cuda_local_var_38317_6_non_const_x) + (0.5F))))) , ((void)(__T2880 = (((float)(__cuda_local_var_38318_6_non_const_y - 1)) + (0.5F))))) , ((__T2882 = (__ftexfetch2D(__T2878, ((((((__T2881.x) = __T2879) , ((void)((__T2881.y) = __T2880))) , ((void)((__T2881.z) = (0.0F)))) , ((void)((__T2881.w) = (0.0F)))) , __T2881)))) , (__T2882.x)));
# 2380 "txInterpTest.cu"
__cuda_local_var_38320_20_non_const_f4 = ((((__T2883 = texRef_f4B) , ((void)(__T2884 = (((float)__cuda_local_var_38317_6_non_const_x) + (0.5F))))) , ((void)(__T2885 = (((float)(__cuda_local_var_38318_6_non_const_y + 1)) + (0.5F))))) , ((__T2887 = (__ftexfetch2D(__T2883, ((((((__T2886.x) = __T2884) , ((void)((__T2886.y) = __T2885))) , ((void)((__T2886.z) = (0.0F)))) , ((void)((__T2886.w) = (0.0F)))) , __T2886)))) , (__T2887.x)));
# 2381 "txInterpTest.cu"
__cuda_local_var_38320_11_non_const_f1 = ((((__T2888 = texRef_f1B) , ((void)(__T2889 = (((float)(__cuda_local_var_38317_6_non_const_x - 1)) + (0.5F))))) , ((void)(__T2890 = (((float)__cuda_local_var_38318_6_non_const_y) + (0.5F))))) , ((__T2892 = (__ftexfetch2D(__T2888, ((((((__T2891.x) = __T2889) , ((void)((__T2891.y) = __T2890))) , ((void)((__T2891.z) = (0.0F)))) , ((void)((__T2891.w) = (0.0F)))) , __T2891)))) , (__T2892.x)));
# 2382 "txInterpTest.cu"
__cuda_local_var_38320_17_non_const_f3 = ((((__T2893 = texRef_f3B) , ((void)(__T2894 = (((float)(__cuda_local_var_38317_6_non_const_x + 1)) + (0.5F))))) , ((void)(__T2895 = (((float)__cuda_local_var_38318_6_non_const_y) + (0.5F))))) , ((__T2897 = (__ftexfetch2D(__T2893, ((((((__T2896.x) = __T2894) , ((void)((__T2896.y) = __T2895))) , ((void)((__T2896.z) = (0.0F)))) , ((void)((__T2896.w) = (0.0F)))) , __T2896)))) , (__T2897.x)));
# 2383 "txInterpTest.cu"
__cuda_local_var_38320_23_non_const_f5 = ((((__T2898 = texRef_f5B) , ((void)(__T2899 = (((float)(__cuda_local_var_38317_6_non_const_x - 1)) + (0.5F))))) , ((void)(__T2900 = (((float)(__cuda_local_var_38318_6_non_const_y - 1)) + (0.5F))))) , ((__T2902 = (__ftexfetch2D(__T2898, ((((((__T2901.x) = __T2899) , ((void)((__T2901.y) = __T2900))) , ((void)((__T2901.z) = (0.0F)))) , ((void)((__T2901.w) = (0.0F)))) , __T2901)))) , (__T2902.x)));
# 2384 "txInterpTest.cu"
__cuda_local_var_38320_26_non_const_f6 = ((((__T2903 = texRef_f6B) , ((void)(__T2904 = (((float)(__cuda_local_var_38317_6_non_const_x + 1)) + (0.5F))))) , ((void)(__T2905 = (((float)(__cuda_local_var_38318_6_non_const_y - 1)) + (0.5F))))) , ((__T2907 = (__ftexfetch2D(__T2903, ((((((__T2906.x) = __T2904) , ((void)((__T2906.y) = __T2905))) , ((void)((__T2906.z) = (0.0F)))) , ((void)((__T2906.w) = (0.0F)))) , __T2906)))) , (__T2907.x)));
# 2385 "txInterpTest.cu"
__cuda_local_var_38320_29_non_const_f7 = ((((__T2908 = texRef_f7B) , ((void)(__T2909 = (((float)(__cuda_local_var_38317_6_non_const_x + 1)) + (0.5F))))) , ((void)(__T2910 = (((float)(__cuda_local_var_38318_6_non_const_y + 1)) + (0.5F))))) , ((__T2912 = (__ftexfetch2D(__T2908, ((((((__T2911.x) = __T2909) , ((void)((__T2911.y) = __T2910))) , ((void)((__T2911.z) = (0.0F)))) , ((void)((__T2911.w) = (0.0F)))) , __T2911)))) , (__T2912.x)));
# 2386 "txInterpTest.cu"
__cuda_local_var_38320_32_non_const_f8 = ((((__T2913 = texRef_f8B) , ((void)(__T2914 = (((float)(__cuda_local_var_38317_6_non_const_x - 1)) + (0.5F))))) , ((void)(__T2915 = (((float)(__cuda_local_var_38318_6_non_const_y + 1)) + (0.5F))))) , ((__T2917 = (__ftexfetch2D(__T2913, ((((((__T2916.x) = __T2914) , ((void)((__T2916.y) = __T2915))) , ((void)((__T2916.z) = (0.0F)))) , ((void)((__T2916.w) = (0.0F)))) , __T2916)))) , (__T2917.x)));
# 2388 "txInterpTest.cu"
__cuda_local_var_38331_6_non_const_im = (_Z8ImageFcnii(__cuda_local_var_38317_6_non_const_x, __cuda_local_var_38318_6_non_const_y));
# 2389 "txInterpTest.cu"
if ((__cuda_local_var_38331_6_non_const_im == 1) || (__cuda_local_var_38331_6_non_const_im == 10))
# 2389 "txInterpTest.cu"
{
# 2390 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_38317_6_non_const_x) + (((unsigned long)__cuda_local_var_38318_6_non_const_y) * pitch)) + ((1UL * pitch) * 768UL)))]) = __cuda_local_var_38320_17_non_const_f3;
# 2391 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_38317_6_non_const_x) + (((unsigned long)__cuda_local_var_38318_6_non_const_y) * pitch)) + ((2UL * pitch) * 768UL)))]) = __cuda_local_var_38320_20_non_const_f4;
# 2392 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_38317_6_non_const_x) + (((unsigned long)__cuda_local_var_38318_6_non_const_y) * pitch)) + ((3UL * pitch) * 768UL)))]) = __cuda_local_var_38320_11_non_const_f1;
# 2393 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_38317_6_non_const_x) + (((unsigned long)__cuda_local_var_38318_6_non_const_y) * pitch)) + ((4UL * pitch) * 768UL)))]) = __cuda_local_var_38320_14_non_const_f2;
# 2394 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_38317_6_non_const_x) + (((unsigned long)__cuda_local_var_38318_6_non_const_y) * pitch)) + ((5UL * pitch) * 768UL)))]) = __cuda_local_var_38320_29_non_const_f7;
# 2395 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_38317_6_non_const_x) + (((unsigned long)__cuda_local_var_38318_6_non_const_y) * pitch)) + ((6UL * pitch) * 768UL)))]) = __cuda_local_var_38320_32_non_const_f8;
# 2396 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_38317_6_non_const_x) + (((unsigned long)__cuda_local_var_38318_6_non_const_y) * pitch)) + ((7UL * pitch) * 768UL)))]) = __cuda_local_var_38320_23_non_const_f5;
# 2397 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_38317_6_non_const_x) + (((unsigned long)__cuda_local_var_38318_6_non_const_y) * pitch)) + ((8UL * pitch) * 768UL)))]) = __cuda_local_var_38320_26_non_const_f6;
# 2398 "txInterpTest.cu"
}
# 2399 "txInterpTest.cu"
else
# 2399 "txInterpTest.cu"
{
# 2400 "txInterpTest.cu"
if (__cuda_local_var_38331_6_non_const_im == 2)
# 2401 "txInterpTest.cu"
{
# 2402 "txInterpTest.cu"
_Z11NeumannEastRfS_S_S_S_S_S_S_S_i((&__cuda_local_var_38320_8_non_const_f0), (&__cuda_local_var_38320_11_non_const_f1), (&__cuda_local_var_38320_14_non_const_f2), (&__cuda_local_var_38320_17_non_const_f3), (&__cuda_local_var_38320_20_non_const_f4), (&__cuda_local_var_38320_23_non_const_f5), (&__cuda_local_var_38320_26_non_const_f6), (&__cuda_local_var_38320_29_non_const_f7), (&__cuda_local_var_38320_32_non_const_f8), __cuda_local_var_38318_6_non_const_y);
# 2403 "txInterpTest.cu"
}
# 2403 "txInterpTest.cu"
else
# 2403 "txInterpTest.cu"
{
# 2404 "txInterpTest.cu"
if (__cuda_local_var_38331_6_non_const_im == 3)
# 2405 "txInterpTest.cu"
{
# 2406 "txInterpTest.cu"
_Z13DirichletWestRfS_S_S_S_S_S_S_S_i((&__cuda_local_var_38320_8_non_const_f0), (&__cuda_local_var_38320_11_non_const_f1), (&__cuda_local_var_38320_14_non_const_f2), (&__cuda_local_var_38320_17_non_const_f3), (&__cuda_local_var_38320_20_non_const_f4), (&__cuda_local_var_38320_23_non_const_f5), (&__cuda_local_var_38320_26_non_const_f6), (&__cuda_local_var_38320_29_non_const_f7), (&__cuda_local_var_38320_32_non_const_f8), __cuda_local_var_38318_6_non_const_y);
# 2407 "txInterpTest.cu"
}
# 2407 "txInterpTest.cu"
}
# 2409 "txInterpTest.cu"
if (((const char *)"BGK") == ((const char *)"MRT"))
# 2409 "txInterpTest.cu"
{
# 2410 "txInterpTest.cu"
_Z11mrt_collideRfS_S_S_S_S_S_S_S_f((&__cuda_local_var_38320_8_non_const_f0), (&__cuda_local_var_38320_11_non_const_f1), (&__cuda_local_var_38320_14_non_const_f2), (&__cuda_local_var_38320_17_non_const_f3), (&__cuda_local_var_38320_20_non_const_f4), (&__cuda_local_var_38320_23_non_const_f5), (&__cuda_local_var_38320_26_non_const_f6), (&__cuda_local_var_38320_29_non_const_f7), (&__cuda_local_var_38320_32_non_const_f8), omega);
# 2410 "txInterpTest.cu"
}
# 2410 "txInterpTest.cu"
else
# 2410 "txInterpTest.cu"
{
# 2411 "txInterpTest.cu"
if (1)
# 2411 "txInterpTest.cu"
{
# 2411 "txInterpTest.cu"
 float __T2918;
# 2412 "txInterpTest.cu"
 float __T2919;
# 2413 "txInterpTest.cu"
 float __T2920;
# 2414 "txInterpTest.cu"
 float __T2921;
# 2412 "txInterpTest.cu"
{
# 2412 "txInterpTest.cu"
__T2918 = ((((((((__cuda_local_var_38320_8_non_const_f0 + __cuda_local_var_38320_11_non_const_f1) + __cuda_local_var_38320_14_non_const_f2) + __cuda_local_var_38320_17_non_const_f3) + __cuda_local_var_38320_20_non_const_f4) + __cuda_local_var_38320_23_non_const_f5) + __cuda_local_var_38320_26_non_const_f6) + __cuda_local_var_38320_29_non_const_f7) + __cuda_local_var_38320_32_non_const_f8);
# 2412 "txInterpTest.cu"
__T2919 = (((((__cuda_local_var_38320_11_non_const_f1 - __cuda_local_var_38320_17_non_const_f3) + __cuda_local_var_38320_23_non_const_f5) - __cuda_local_var_38320_26_non_const_f6) - __cuda_local_var_38320_29_non_const_f7) + __cuda_local_var_38320_32_non_const_f8);
# 2412 "txInterpTest.cu"
__T2920 = (((((__cuda_local_var_38320_14_non_const_f2 - __cuda_local_var_38320_20_non_const_f4) + __cuda_local_var_38320_23_non_const_f5) + __cuda_local_var_38320_26_non_const_f6) - __cuda_local_var_38320_29_non_const_f7) - __cuda_local_var_38320_32_non_const_f8);
# 2412 "txInterpTest.cu"
__T2921 = ((__T2919 * __T2919) + (__T2920 * __T2920));
# 2412 "txInterpTest.cu"
__cuda_local_var_38320_8_non_const_f0 = (__cuda_local_var_38320_8_non_const_f0 - (omega * (__cuda_local_var_38320_8_non_const_f0 - ((0.4444444478F) * (__T2918 - ((1.5F) * __T2921))))));
# 2412 "txInterpTest.cu"
__cuda_local_var_38320_11_non_const_f1 = (__cuda_local_var_38320_11_non_const_f1 - (omega * (__cuda_local_var_38320_11_non_const_f1 - ((0.1111111119F) * (((__T2918 + ((3.0F) * __T2919)) + (((4.5F) * __T2919) * __T2919)) - ((1.5F) * __T2921))))));
# 2412 "txInterpTest.cu"
__cuda_local_var_38320_14_non_const_f2 = (__cuda_local_var_38320_14_non_const_f2 - (omega * (__cuda_local_var_38320_14_non_const_f2 - ((0.1111111119F) * (((__T2918 + ((3.0F) * __T2920)) + (((4.5F) * __T2920) * __T2920)) - ((1.5F) * __T2921))))));
# 2412 "txInterpTest.cu"
__cuda_local_var_38320_17_non_const_f3 = (__cuda_local_var_38320_17_non_const_f3 - (omega * (__cuda_local_var_38320_17_non_const_f3 - ((0.1111111119F) * (((__T2918 - ((3.0F) * __T2919)) + (((4.5F) * __T2919) * __T2919)) - ((1.5F) * __T2921))))));
# 2412 "txInterpTest.cu"
__cuda_local_var_38320_20_non_const_f4 = (__cuda_local_var_38320_20_non_const_f4 - (omega * (__cuda_local_var_38320_20_non_const_f4 - ((0.1111111119F) * (((__T2918 - ((3.0F) * __T2920)) + (((4.5F) * __T2920) * __T2920)) - ((1.5F) * __T2921))))));
# 2412 "txInterpTest.cu"
__cuda_local_var_38320_23_non_const_f5 = ((float)(((double)__cuda_local_var_38320_23_non_const_f5) - (((double)omega) * (((double)__cuda_local_var_38320_23_non_const_f5) - ((0.02777777777999999864) * ((double)(((__T2918 + ((3.0F) * (__T2919 + __T2920))) + (((4.5F) * (__T2919 + __T2920)) * (__T2919 + __T2920))) - ((1.5F) * __T2921))))))));
# 2412 "txInterpTest.cu"
__cuda_local_var_38320_26_non_const_f6 = ((float)(((double)__cuda_local_var_38320_26_non_const_f6) - (((double)omega) * (((double)__cuda_local_var_38320_26_non_const_f6) - ((0.02777777777999999864) * ((double)(((__T2918 + ((3.0F) * ((-__T2919) + __T2920))) + (((4.5F) * ((-__T2919) + __T2920)) * ((-__T2919) + __T2920))) - ((1.5F) * __T2921))))))));
# 2412 "txInterpTest.cu"
__cuda_local_var_38320_29_non_const_f7 = ((float)(((double)__cuda_local_var_38320_29_non_const_f7) - (((double)omega) * (((double)__cuda_local_var_38320_29_non_const_f7) - ((0.02777777777999999864) * ((double)(((__T2918 + ((3.0F) * ((-__T2919) - __T2920))) + (((4.5F) * ((-__T2919) - __T2920)) * ((-__T2919) - __T2920))) - ((1.5F) * __T2921))))))));
# 2412 "txInterpTest.cu"
__cuda_local_var_38320_32_non_const_f8 = ((float)(((double)__cuda_local_var_38320_32_non_const_f8) - (((double)omega) * (((double)__cuda_local_var_38320_32_non_const_f8) - ((0.02777777777999999864) * ((double)(((__T2918 + ((3.0F) * (__T2919 - __T2920))) + (((4.5F) * (__T2919 - __T2920)) * (__T2919 - __T2920))) - ((1.5F) * __T2921))))))));
# 2412 "txInterpTest.cu"
}
# 2412 "txInterpTest.cu"
}
# 2412 "txInterpTest.cu"
}
# 2414 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_38317_6_non_const_x) + (((unsigned long)__cuda_local_var_38318_6_non_const_y) * pitch)) + ((0UL * pitch) * 768UL)))]) = __cuda_local_var_38320_8_non_const_f0;
# 2415 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_38317_6_non_const_x) + (((unsigned long)__cuda_local_var_38318_6_non_const_y) * pitch)) + ((1UL * pitch) * 768UL)))]) = __cuda_local_var_38320_11_non_const_f1;
# 2416 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_38317_6_non_const_x) + (((unsigned long)__cuda_local_var_38318_6_non_const_y) * pitch)) + ((2UL * pitch) * 768UL)))]) = __cuda_local_var_38320_14_non_const_f2;
# 2417 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_38317_6_non_const_x) + (((unsigned long)__cuda_local_var_38318_6_non_const_y) * pitch)) + ((3UL * pitch) * 768UL)))]) = __cuda_local_var_38320_17_non_const_f3;
# 2418 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_38317_6_non_const_x) + (((unsigned long)__cuda_local_var_38318_6_non_const_y) * pitch)) + ((4UL * pitch) * 768UL)))]) = __cuda_local_var_38320_20_non_const_f4;
# 2419 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_38317_6_non_const_x) + (((unsigned long)__cuda_local_var_38318_6_non_const_y) * pitch)) + ((5UL * pitch) * 768UL)))]) = __cuda_local_var_38320_23_non_const_f5;
# 2420 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_38317_6_non_const_x) + (((unsigned long)__cuda_local_var_38318_6_non_const_y) * pitch)) + ((6UL * pitch) * 768UL)))]) = __cuda_local_var_38320_26_non_const_f6;
# 2421 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_38317_6_non_const_x) + (((unsigned long)__cuda_local_var_38318_6_non_const_y) * pitch)) + ((7UL * pitch) * 768UL)))]) = __cuda_local_var_38320_29_non_const_f7;
# 2422 "txInterpTest.cu"
(fout[((int)((((unsigned long)__cuda_local_var_38317_6_non_const_x) + (((unsigned long)__cuda_local_var_38318_6_non_const_y) * pitch)) + ((8UL * pitch) * 768UL)))]) = __cuda_local_var_38320_32_non_const_f8;
# 2424 "txInterpTest.cu"
}
# 2425 "txInterpTest.cu"
}
# 2425 "txInterpTest.cu"
}}
# 2428 "txInterpTest.cu"
__attribute__((global)) __attribute__((__used__)) void _Z8mrt_d_LRPfS_fmf(
# 2428 "txInterpTest.cu"
float *fA,
# 2428 "txInterpTest.cu"
float *fB,
# 2429 "txInterpTest.cu"
float omega,
# 2429 "txInterpTest.cu"
size_t pitch,
# 2429 "txInterpTest.cu"
float SF){
# 2429 "txInterpTest.cu"
{
# 2430 "txInterpTest.cu"
{
# 2430 "txInterpTest.cu"
 int __T2922;
# 2431 "txInterpTest.cu"
 int __T2923;
# 2432 "txInterpTest.cu"
 int __T2924;
# 2433 "txInterpTest.cu"
 int __T2925;
# 2434 "txInterpTest.cu"
 int __T2926;
# 2435 "txInterpTest.cu"
 int __T2927;
# 2436 "txInterpTest.cu"
 int __T2928;
# 2437 "txInterpTest.cu"
 int __T2929;
# 2438 "txInterpTest.cu"
 int __T2930;
# 2439 "txInterpTest.cu"
 int __T2931;
# 2440 "txInterpTest.cu"
 int __T2932;
# 2441 "txInterpTest.cu"
 int __T2933;
# 2442 "txInterpTest.cu"
 float __T2934;
# 2443 "txInterpTest.cu"
 float __T2935;
# 2444 "txInterpTest.cu"
 float __T2936;
# 2445 "txInterpTest.cu"
 float __T2937;
# 2431 "txInterpTest.cu"
 int __cuda_local_var_38374_6_non_const_x;
# 2432 "txInterpTest.cu"
 int __cuda_local_var_38375_6_non_const_y;
# 2433 "txInterpTest.cu"
 int __cuda_local_var_38376_6_non_const_j;
# 2434 "txInterpTest.cu"
 int __cuda_local_var_38377_6_non_const_im;
# 2435 "txInterpTest.cu"
 float __cuda_local_var_38378_8_non_const_f0;
# 2435 "txInterpTest.cu"
 float __cuda_local_var_38378_11_non_const_f1;
# 2435 "txInterpTest.cu"
 float __cuda_local_var_38378_14_non_const_f2;
# 2435 "txInterpTest.cu"
 float __cuda_local_var_38378_17_non_const_f3;
# 2435 "txInterpTest.cu"
 float __cuda_local_var_38378_20_non_const_f4;
# 2435 "txInterpTest.cu"
 float __cuda_local_var_38378_23_non_const_f5;
# 2435 "txInterpTest.cu"
 float __cuda_local_var_38378_26_non_const_f6;
# 2435 "txInterpTest.cu"
 float __cuda_local_var_38378_29_non_const_f7;
# 2435 "txInterpTest.cu"
 float __cuda_local_var_38378_32_non_const_f8;
# 2431 "txInterpTest.cu"
__cuda_local_var_38374_6_non_const_x = ((int)((threadIdx.x) + ((blockIdx.x) * (blockDim.x))));
# 2432 "txInterpTest.cu"
__cuda_local_var_38375_6_non_const_y = ((int)((threadIdx.y) + ((blockIdx.y) * (blockDim.y))));
# 2433 "txInterpTest.cu"
__cuda_local_var_38376_6_non_const_j = ((int)(((unsigned long)__cuda_local_var_38374_6_non_const_x) + (((unsigned long)__cuda_local_var_38375_6_non_const_y) * pitch)));
# 2434 "txInterpTest.cu"
__cuda_local_var_38377_6_non_const_im = (_Z8ImageFcnii(__cuda_local_var_38374_6_non_const_x, __cuda_local_var_38375_6_non_const_y));
# 2437 "txInterpTest.cu"
__cuda_local_var_38378_8_non_const_f0 = (fA[__cuda_local_var_38376_6_non_const_j]);
# 2438 "txInterpTest.cu"
__cuda_local_var_38378_11_non_const_f1 = (fA[(((__T2922 = (_Z4dmaxi((__cuda_local_var_38374_6_non_const_x - 1)))) , ((void)(__T2923 = __cuda_local_var_38375_6_non_const_y))) , ((int)((((unsigned long)__T2922) + (((unsigned long)__T2923) * pitch)) + ((1UL * pitch) * 768UL))))]);
# 2439 "txInterpTest.cu"
__cuda_local_var_38378_17_non_const_f3 = (fA[(((__T2924 = (_Z4dminii((__cuda_local_var_38374_6_non_const_x + 1), 1024))) , ((void)(__T2925 = __cuda_local_var_38375_6_non_const_y))) , ((int)((((unsigned long)__T2924) + (((unsigned long)__T2925) * pitch)) + ((3UL * pitch) * 768UL))))]);
# 2440 "txInterpTest.cu"
__cuda_local_var_38378_14_non_const_f2 = (fA[((int)((((unsigned long)__cuda_local_var_38374_6_non_const_x) + (((unsigned long)(__cuda_local_var_38375_6_non_const_y - 1)) * pitch)) + ((2UL * pitch) * 768UL)))]);
# 2441 "txInterpTest.cu"
__cuda_local_var_38378_23_non_const_f5 = (fA[(((__T2926 = (_Z4dmaxi((__cuda_local_var_38374_6_non_const_x - 1)))) , ((void)(__T2927 = (__cuda_local_var_38375_6_non_const_y - 1)))) , ((int)((((unsigned long)__T2926) + (((unsigned long)__T2927) * pitch)) + ((5UL * pitch) * 768UL))))]);
# 2442 "txInterpTest.cu"
__cuda_local_var_38378_26_non_const_f6 = (fA[(((__T2928 = (_Z4dminii((__cuda_local_var_38374_6_non_const_x + 1), 1024))) , ((void)(__T2929 = (__cuda_local_var_38375_6_non_const_y - 1)))) , ((int)((((unsigned long)__T2928) + (((unsigned long)__T2929) * pitch)) + ((6UL * pitch) * 768UL))))]);
# 2443 "txInterpTest.cu"
__cuda_local_var_38378_20_non_const_f4 = (fA[((int)((((unsigned long)__cuda_local_var_38374_6_non_const_x) + (((unsigned long)(__cuda_local_var_38375_6_non_const_y + 1)) * pitch)) + ((4UL * pitch) * 768UL)))]);
# 2444 "txInterpTest.cu"
__cuda_local_var_38378_29_non_const_f7 = (fA[(((__T2930 = (_Z4dminii((__cuda_local_var_38374_6_non_const_x + 1), 1024))) , ((void)(__T2931 = (__cuda_local_var_38375_6_non_const_y + 1)))) , ((int)((((unsigned long)__T2930) + (((unsigned long)__T2931) * pitch)) + ((7UL * pitch) * 768UL))))]);
# 2445 "txInterpTest.cu"
__cuda_local_var_38378_32_non_const_f8 = (fA[(((__T2932 = (_Z4dmaxi((__cuda_local_var_38374_6_non_const_x - 1)))) , ((void)(__T2933 = (_Z4dminii((__cuda_local_var_38375_6_non_const_y + 1), 768))))) , ((int)((((unsigned long)__T2932) + (((unsigned long)__T2933) * pitch)) + ((8UL * pitch) * 768UL))))]);
# 2446 "txInterpTest.cu"
if ((__cuda_local_var_38377_6_non_const_im == 1) || (__cuda_local_var_38377_6_non_const_im == 10))
# 2446 "txInterpTest.cu"
{
# 2447 "txInterpTest.cu"
(fB[((int)((((unsigned long)__cuda_local_var_38374_6_non_const_x) + (((unsigned long)__cuda_local_var_38375_6_non_const_y) * pitch)) + ((1UL * pitch) * 768UL)))]) = __cuda_local_var_38378_17_non_const_f3;
# 2448 "txInterpTest.cu"
(fB[((int)((((unsigned long)__cuda_local_var_38374_6_non_const_x) + (((unsigned long)__cuda_local_var_38375_6_non_const_y) * pitch)) + ((2UL * pitch) * 768UL)))]) = __cuda_local_var_38378_20_non_const_f4;
# 2449 "txInterpTest.cu"
(fB[((int)((((unsigned long)__cuda_local_var_38374_6_non_const_x) + (((unsigned long)__cuda_local_var_38375_6_non_const_y) * pitch)) + ((3UL * pitch) * 768UL)))]) = __cuda_local_var_38378_11_non_const_f1;
# 2450 "txInterpTest.cu"
(fB[((int)((((unsigned long)__cuda_local_var_38374_6_non_const_x) + (((unsigned long)__cuda_local_var_38375_6_non_const_y) * pitch)) + ((4UL * pitch) * 768UL)))]) = __cuda_local_var_38378_14_non_const_f2;
# 2451 "txInterpTest.cu"
(fB[((int)((((unsigned long)__cuda_local_var_38374_6_non_const_x) + (((unsigned long)__cuda_local_var_38375_6_non_const_y) * pitch)) + ((5UL * pitch) * 768UL)))]) = __cuda_local_var_38378_29_non_const_f7;
# 2452 "txInterpTest.cu"
(fB[((int)((((unsigned long)__cuda_local_var_38374_6_non_const_x) + (((unsigned long)__cuda_local_var_38375_6_non_const_y) * pitch)) + ((6UL * pitch) * 768UL)))]) = __cuda_local_var_38378_32_non_const_f8;
# 2453 "txInterpTest.cu"
(fB[((int)((((unsigned long)__cuda_local_var_38374_6_non_const_x) + (((unsigned long)__cuda_local_var_38375_6_non_const_y) * pitch)) + ((7UL * pitch) * 768UL)))]) = __cuda_local_var_38378_23_non_const_f5;
# 2454 "txInterpTest.cu"
(fB[((int)((((unsigned long)__cuda_local_var_38374_6_non_const_x) + (((unsigned long)__cuda_local_var_38375_6_non_const_y) * pitch)) + ((8UL * pitch) * 768UL)))]) = __cuda_local_var_38378_26_non_const_f6;
# 2455 "txInterpTest.cu"
}
# 2456 "txInterpTest.cu"
else
# 2456 "txInterpTest.cu"
{
# 2457 "txInterpTest.cu"
if (__cuda_local_var_38377_6_non_const_im == 3)
# 2458 "txInterpTest.cu"
{
# 2467 "txInterpTest.cu"
 float __cuda_local_var_38410_10_non_const_u;
# 2467 "txInterpTest.cu"
 float __cuda_local_var_38410_12_non_const_v;
# 2459 "txInterpTest.cu"
if (__cuda_local_var_38375_6_non_const_y == 0)
# 2459 "txInterpTest.cu"
{
# 2460 "txInterpTest.cu"
__cuda_local_var_38378_14_non_const_f2 = __cuda_local_var_38378_20_non_const_f4;
# 2461 "txInterpTest.cu"
__cuda_local_var_38378_26_non_const_f6 = __cuda_local_var_38378_29_non_const_f7;
# 2462 "txInterpTest.cu"
}
# 2462 "txInterpTest.cu"
else
# 2462 "txInterpTest.cu"
{
# 2463 "txInterpTest.cu"
if (__cuda_local_var_38375_6_non_const_y == 767)
# 2463 "txInterpTest.cu"
{
# 2464 "txInterpTest.cu"
__cuda_local_var_38378_20_non_const_f4 = __cuda_local_var_38378_14_non_const_f2;
# 2465 "txInterpTest.cu"
__cuda_local_var_38378_29_non_const_f7 = __cuda_local_var_38378_26_non_const_f6;
# 2466 "txInterpTest.cu"
}
# 2466 "txInterpTest.cu"
}
# 2468 "txInterpTest.cu"
__cuda_local_var_38410_10_non_const_u = (0.0F);
# 2469 "txInterpTest.cu"
__cuda_local_var_38410_12_non_const_v = (0.07999999821F);
# 2470 "txInterpTest.cu"
__cuda_local_var_38378_11_non_const_f1 = (__cuda_local_var_38378_17_non_const_f3 + (__cuda_local_var_38410_10_non_const_u * (0.6666666865F)));
# 2471 "txInterpTest.cu"
__cuda_local_var_38378_23_non_const_f5 = (((__cuda_local_var_38378_29_non_const_f7 - ((0.5F) * (__cuda_local_var_38378_14_non_const_f2 - __cuda_local_var_38378_20_non_const_f4))) + (__cuda_local_var_38410_12_non_const_v * (0.5F))) + (__cuda_local_var_38410_10_non_const_u * (0.1666666716F)));
# 2472 "txInterpTest.cu"
__cuda_local_var_38378_32_non_const_f8 = (((__cuda_local_var_38378_26_non_const_f6 + ((0.5F) * (__cuda_local_var_38378_14_non_const_f2 - __cuda_local_var_38378_20_non_const_f4))) - (__cuda_local_var_38410_12_non_const_v * (0.5F))) + (__cuda_local_var_38410_10_non_const_u * (0.1666666716F)));
# 2473 "txInterpTest.cu"
}
# 2475 "txInterpTest.cu"
if (((const char *)"BGK") == ((const char *)"MRT"))
# 2475 "txInterpTest.cu"
{
# 2476 "txInterpTest.cu"
_Z11mrt_collideRfS_S_S_S_S_S_S_S_f((&__cuda_local_var_38378_8_non_const_f0), (&__cuda_local_var_38378_11_non_const_f1), (&__cuda_local_var_38378_14_non_const_f2), (&__cuda_local_var_38378_17_non_const_f3), (&__cuda_local_var_38378_20_non_const_f4), (&__cuda_local_var_38378_23_non_const_f5), (&__cuda_local_var_38378_26_non_const_f6), (&__cuda_local_var_38378_29_non_const_f7), (&__cuda_local_var_38378_32_non_const_f8), omega);
# 2476 "txInterpTest.cu"
}
# 2476 "txInterpTest.cu"
else
# 2476 "txInterpTest.cu"
{
# 2477 "txInterpTest.cu"
if (1)
# 2477 "txInterpTest.cu"
{
# 2478 "txInterpTest.cu"
{
# 2478 "txInterpTest.cu"
__T2934 = ((((((((__cuda_local_var_38378_8_non_const_f0 + __cuda_local_var_38378_11_non_const_f1) + __cuda_local_var_38378_14_non_const_f2) + __cuda_local_var_38378_17_non_const_f3) + __cuda_local_var_38378_20_non_const_f4) + __cuda_local_var_38378_23_non_const_f5) + __cuda_local_var_38378_26_non_const_f6) + __cuda_local_var_38378_29_non_const_f7) + __cuda_local_var_38378_32_non_const_f8);
# 2478 "txInterpTest.cu"
__T2935 = (((((__cuda_local_var_38378_11_non_const_f1 - __cuda_local_var_38378_17_non_const_f3) + __cuda_local_var_38378_23_non_const_f5) - __cuda_local_var_38378_26_non_const_f6) - __cuda_local_var_38378_29_non_const_f7) + __cuda_local_var_38378_32_non_const_f8);
# 2478 "txInterpTest.cu"
__T2936 = (((((__cuda_local_var_38378_14_non_const_f2 - __cuda_local_var_38378_20_non_const_f4) + __cuda_local_var_38378_23_non_const_f5) + __cuda_local_var_38378_26_non_const_f6) - __cuda_local_var_38378_29_non_const_f7) - __cuda_local_var_38378_32_non_const_f8);
# 2478 "txInterpTest.cu"
__T2937 = ((__T2935 * __T2935) + (__T2936 * __T2936));
# 2478 "txInterpTest.cu"
__cuda_local_var_38378_8_non_const_f0 = (__cuda_local_var_38378_8_non_const_f0 - (omega * (__cuda_local_var_38378_8_non_const_f0 - ((0.4444444478F) * (__T2934 - ((1.5F) * __T2937))))));
# 2478 "txInterpTest.cu"
__cuda_local_var_38378_11_non_const_f1 = (__cuda_local_var_38378_11_non_const_f1 - (omega * (__cuda_local_var_38378_11_non_const_f1 - ((0.1111111119F) * (((__T2934 + ((3.0F) * __T2935)) + (((4.5F) * __T2935) * __T2935)) - ((1.5F) * __T2937))))));
# 2478 "txInterpTest.cu"
__cuda_local_var_38378_14_non_const_f2 = (__cuda_local_var_38378_14_non_const_f2 - (omega * (__cuda_local_var_38378_14_non_const_f2 - ((0.1111111119F) * (((__T2934 + ((3.0F) * __T2936)) + (((4.5F) * __T2936) * __T2936)) - ((1.5F) * __T2937))))));
# 2478 "txInterpTest.cu"
__cuda_local_var_38378_17_non_const_f3 = (__cuda_local_var_38378_17_non_const_f3 - (omega * (__cuda_local_var_38378_17_non_const_f3 - ((0.1111111119F) * (((__T2934 - ((3.0F) * __T2935)) + (((4.5F) * __T2935) * __T2935)) - ((1.5F) * __T2937))))));
# 2478 "txInterpTest.cu"
__cuda_local_var_38378_20_non_const_f4 = (__cuda_local_var_38378_20_non_const_f4 - (omega * (__cuda_local_var_38378_20_non_const_f4 - ((0.1111111119F) * (((__T2934 - ((3.0F) * __T2936)) + (((4.5F) * __T2936) * __T2936)) - ((1.5F) * __T2937))))));
# 2478 "txInterpTest.cu"
__cuda_local_var_38378_23_non_const_f5 = ((float)(((double)__cuda_local_var_38378_23_non_const_f5) - (((double)omega) * (((double)__cuda_local_var_38378_23_non_const_f5) - ((0.02777777777999999864) * ((double)(((__T2934 + ((3.0F) * (__T2935 + __T2936))) + (((4.5F) * (__T2935 + __T2936)) * (__T2935 + __T2936))) - ((1.5F) * __T2937))))))));
# 2478 "txInterpTest.cu"
__cuda_local_var_38378_26_non_const_f6 = ((float)(((double)__cuda_local_var_38378_26_non_const_f6) - (((double)omega) * (((double)__cuda_local_var_38378_26_non_const_f6) - ((0.02777777777999999864) * ((double)(((__T2934 + ((3.0F) * ((-__T2935) + __T2936))) + (((4.5F) * ((-__T2935) + __T2936)) * ((-__T2935) + __T2936))) - ((1.5F) * __T2937))))))));
# 2478 "txInterpTest.cu"
__cuda_local_var_38378_29_non_const_f7 = ((float)(((double)__cuda_local_var_38378_29_non_const_f7) - (((double)omega) * (((double)__cuda_local_var_38378_29_non_const_f7) - ((0.02777777777999999864) * ((double)(((__T2934 + ((3.0F) * ((-__T2935) - __T2936))) + (((4.5F) * ((-__T2935) - __T2936)) * ((-__T2935) - __T2936))) - ((1.5F) * __T2937))))))));
# 2478 "txInterpTest.cu"
__cuda_local_var_38378_32_non_const_f8 = ((float)(((double)__cuda_local_var_38378_32_non_const_f8) - (((double)omega) * (((double)__cuda_local_var_38378_32_non_const_f8) - ((0.02777777777999999864) * ((double)(((__T2934 + ((3.0F) * (__T2935 - __T2936))) + (((4.5F) * (__T2935 - __T2936)) * (__T2935 - __T2936))) - ((1.5F) * __T2937))))))));
# 2478 "txInterpTest.cu"
}
# 2478 "txInterpTest.cu"
}
# 2478 "txInterpTest.cu"
}
# 2480 "txInterpTest.cu"
(fB[((int)((((unsigned long)__cuda_local_var_38374_6_non_const_x) + (((unsigned long)__cuda_local_var_38375_6_non_const_y) * pitch)) + ((0UL * pitch) * 768UL)))]) = __cuda_local_var_38378_8_non_const_f0;
# 2481 "txInterpTest.cu"
(fB[((int)((((unsigned long)__cuda_local_var_38374_6_non_const_x) + (((unsigned long)__cuda_local_var_38375_6_non_const_y) * pitch)) + ((1UL * pitch) * 768UL)))]) = __cuda_local_var_38378_11_non_const_f1;
# 2482 "txInterpTest.cu"
(fB[((int)((((unsigned long)__cuda_local_var_38374_6_non_const_x) + (((unsigned long)__cuda_local_var_38375_6_non_const_y) * pitch)) + ((2UL * pitch) * 768UL)))]) = __cuda_local_var_38378_14_non_const_f2;
# 2483 "txInterpTest.cu"
(fB[((int)((((unsigned long)__cuda_local_var_38374_6_non_const_x) + (((unsigned long)__cuda_local_var_38375_6_non_const_y) * pitch)) + ((3UL * pitch) * 768UL)))]) = __cuda_local_var_38378_17_non_const_f3;
# 2484 "txInterpTest.cu"
(fB[((int)((((unsigned long)__cuda_local_var_38374_6_non_const_x) + (((unsigned long)__cuda_local_var_38375_6_non_const_y) * pitch)) + ((4UL * pitch) * 768UL)))]) = __cuda_local_var_38378_20_non_const_f4;
# 2485 "txInterpTest.cu"
(fB[((int)((((unsigned long)__cuda_local_var_38374_6_non_const_x) + (((unsigned long)__cuda_local_var_38375_6_non_const_y) * pitch)) + ((5UL * pitch) * 768UL)))]) = __cuda_local_var_38378_23_non_const_f5;
# 2486 "txInterpTest.cu"
(fB[((int)((((unsigned long)__cuda_local_var_38374_6_non_const_x) + (((unsigned long)__cuda_local_var_38375_6_non_const_y) * pitch)) + ((6UL * pitch) * 768UL)))]) = __cuda_local_var_38378_26_non_const_f6;
# 2487 "txInterpTest.cu"
(fB[((int)((((unsigned long)__cuda_local_var_38374_6_non_const_x) + (((unsigned long)__cuda_local_var_38375_6_non_const_y) * pitch)) + ((7UL * pitch) * 768UL)))]) = __cuda_local_var_38378_29_non_const_f7;
# 2488 "txInterpTest.cu"
(fB[((int)((((unsigned long)__cuda_local_var_38374_6_non_const_x) + (((unsigned long)__cuda_local_var_38375_6_non_const_y) * pitch)) + ((8UL * pitch) * 768UL)))]) = __cuda_local_var_38378_32_non_const_f8;
# 2489 "txInterpTest.cu"
}
# 2490 "txInterpTest.cu"
}
# 2490 "txInterpTest.cu"
}}
# 2493 "txInterpTest.cu"
__attribute__((global)) __attribute__((__used__)) void _Z17initialize_singlePfm(
# 2493 "txInterpTest.cu"
float *f,
# 2493 "txInterpTest.cu"
size_t pitch){
# 2493 "txInterpTest.cu"
{
# 2494 "txInterpTest.cu"
{
# 2495 "txInterpTest.cu"
 int __cuda_local_var_38438_6_non_const_x;
# 2496 "txInterpTest.cu"
 int __cuda_local_var_38439_6_non_const_y;
# 2497 "txInterpTest.cu"
 int __cuda_local_var_38440_6_non_const_j;
# 2495 "txInterpTest.cu"
__cuda_local_var_38438_6_non_const_x = ((int)((threadIdx.x) + ((blockIdx.x) * (blockDim.x))));
# 2496 "txInterpTest.cu"
__cuda_local_var_38439_6_non_const_y = ((int)((threadIdx.y) + ((blockIdx.y) * (blockDim.y))));
# 2497 "txInterpTest.cu"
__cuda_local_var_38440_6_non_const_j = ((int)(((unsigned long)__cuda_local_var_38438_6_non_const_x) + (((unsigned long)__cuda_local_var_38439_6_non_const_y) * pitch)));
# 2498 "txInterpTest.cu"
if ((__cuda_local_var_38438_6_non_const_x < 1024) && (__cuda_local_var_38439_6_non_const_y < 768))
# 2498 "txInterpTest.cu"
{
# 2499 "txInterpTest.cu"
 float __cuda_local_var_38442_8_non_const_u;
# 2499 "txInterpTest.cu"
 float __cuda_local_var_38442_10_non_const_v;
# 2499 "txInterpTest.cu"
 float __cuda_local_var_38442_12_non_const_rho;
# 2499 "txInterpTest.cu"
 float __cuda_local_var_38442_16_non_const_usqr;
# 2500 "txInterpTest.cu"
__cuda_local_var_38442_12_non_const_rho = (1.0F);
# 2501 "txInterpTest.cu"
__cuda_local_var_38442_8_non_const_u = (0.0F);
# 2502 "txInterpTest.cu"
__cuda_local_var_38442_10_non_const_v = (0.0F);
# 2503 "txInterpTest.cu"
__cuda_local_var_38442_16_non_const_usqr = ((__cuda_local_var_38442_8_non_const_u * __cuda_local_var_38442_8_non_const_u) + (__cuda_local_var_38442_10_non_const_v * __cuda_local_var_38442_10_non_const_v));
# 2505 "txInterpTest.cu"
(f[(((unsigned long)__cuda_local_var_38440_6_non_const_j) + ((0UL * pitch) * 768UL))]) = ((0.4444444478F) * (__cuda_local_var_38442_12_non_const_rho - ((1.5F) * __cuda_local_var_38442_16_non_const_usqr)));
# 2506 "txInterpTest.cu"
(f[(((unsigned long)__cuda_local_var_38440_6_non_const_j) + ((1UL * pitch) * 768UL))]) = ((0.1111111119F) * (((__cuda_local_var_38442_12_non_const_rho + ((3.0F) * __cuda_local_var_38442_8_non_const_u)) + (((4.5F) * __cuda_local_var_38442_8_non_const_u) * __cuda_local_var_38442_8_non_const_u)) - ((1.5F) * __cuda_local_var_38442_16_non_const_usqr)));
# 2507 "txInterpTest.cu"
(f[(((unsigned long)__cuda_local_var_38440_6_non_const_j) + ((2UL * pitch) * 768UL))]) = ((0.1111111119F) * (((__cuda_local_var_38442_12_non_const_rho + ((3.0F) * __cuda_local_var_38442_10_non_const_v)) + (((4.5F) * __cuda_local_var_38442_10_non_const_v) * __cuda_local_var_38442_10_non_const_v)) - ((1.5F) * __cuda_local_var_38442_16_non_const_usqr)));
# 2508 "txInterpTest.cu"
(f[(((unsigned long)__cuda_local_var_38440_6_non_const_j) + ((3UL * pitch) * 768UL))]) = ((0.1111111119F) * (((__cuda_local_var_38442_12_non_const_rho - ((3.0F) * __cuda_local_var_38442_8_non_const_u)) + (((4.5F) * __cuda_local_var_38442_8_non_const_u) * __cuda_local_var_38442_8_non_const_u)) - ((1.5F) * __cuda_local_var_38442_16_non_const_usqr)));
# 2509 "txInterpTest.cu"
(f[(((unsigned long)__cuda_local_var_38440_6_non_const_j) + ((4UL * pitch) * 768UL))]) = ((0.1111111119F) * (((__cuda_local_var_38442_12_non_const_rho - ((3.0F) * __cuda_local_var_38442_10_non_const_v)) + (((4.5F) * __cuda_local_var_38442_10_non_const_v) * __cuda_local_var_38442_10_non_const_v)) - ((1.5F) * __cuda_local_var_38442_16_non_const_usqr)));
# 2510 "txInterpTest.cu"
(f[(((unsigned long)__cuda_local_var_38440_6_non_const_j) + ((5UL * pitch) * 768UL))]) = ((float)((0.02777777777999999864) * ((double)(((__cuda_local_var_38442_12_non_const_rho + ((3.0F) * (__cuda_local_var_38442_8_non_const_u + __cuda_local_var_38442_10_non_const_v))) + (((4.5F) * (__cuda_local_var_38442_8_non_const_u + __cuda_local_var_38442_10_non_const_v)) * (__cuda_local_var_38442_8_non_const_u + __cuda_local_var_38442_10_non_const_v))) - ((1.5F) * __cuda_local_var_38442_16_non_const_usqr)))));
# 2511 "txInterpTest.cu"
(f[(((unsigned long)__cuda_local_var_38440_6_non_const_j) + ((6UL * pitch) * 768UL))]) = ((float)((0.02777777777999999864) * ((double)(((__cuda_local_var_38442_12_non_const_rho + ((3.0F) * ((-__cuda_local_var_38442_8_non_const_u) + __cuda_local_var_38442_10_non_const_v))) + (((4.5F) * ((-__cuda_local_var_38442_8_non_const_u) + __cuda_local_var_38442_10_non_const_v)) * ((-__cuda_local_var_38442_8_non_const_u) + __cuda_local_var_38442_10_non_const_v))) - ((1.5F) * __cuda_local_var_38442_16_non_const_usqr)))));
# 2512 "txInterpTest.cu"
(f[(((unsigned long)__cuda_local_var_38440_6_non_const_j) + ((7UL * pitch) * 768UL))]) = ((float)((0.02777777777999999864) * ((double)(((__cuda_local_var_38442_12_non_const_rho + ((3.0F) * ((-__cuda_local_var_38442_8_non_const_u) - __cuda_local_var_38442_10_non_const_v))) + (((4.5F) * ((-__cuda_local_var_38442_8_non_const_u) - __cuda_local_var_38442_10_non_const_v)) * ((-__cuda_local_var_38442_8_non_const_u) - __cuda_local_var_38442_10_non_const_v))) - ((1.5F) * __cuda_local_var_38442_16_non_const_usqr)))));
# 2513 "txInterpTest.cu"
(f[(((unsigned long)__cuda_local_var_38440_6_non_const_j) + ((8UL * pitch) * 768UL))]) = ((float)((0.02777777777999999864) * ((double)(((__cuda_local_var_38442_12_non_const_rho + ((3.0F) * (__cuda_local_var_38442_8_non_const_u - __cuda_local_var_38442_10_non_const_v))) + (((4.5F) * (__cuda_local_var_38442_8_non_const_u - __cuda_local_var_38442_10_non_const_v)) * (__cuda_local_var_38442_8_non_const_u - __cuda_local_var_38442_10_non_const_v))) - ((1.5F) * __cuda_local_var_38442_16_non_const_usqr)))));
# 2514 "txInterpTest.cu"
}
# 2515 "txInterpTest.cu"
}
# 2515 "txInterpTest.cu"
}}
# 2518 "txInterpTest.cu"
__attribute__((global)) __attribute__((__used__)) void _Z13initialize_LRPfm(
# 2518 "txInterpTest.cu"
float *f,
# 2518 "txInterpTest.cu"
size_t pitch){
# 2518 "txInterpTest.cu"
{
# 2519 "txInterpTest.cu"
{
# 2520 "txInterpTest.cu"
 int __cuda_local_var_38463_6_non_const_x;
# 2521 "txInterpTest.cu"
 int __cuda_local_var_38464_6_non_const_y;
# 2522 "txInterpTest.cu"
 int __cuda_local_var_38465_6_non_const_j;
# 2520 "txInterpTest.cu"
__cuda_local_var_38463_6_non_const_x = ((int)((threadIdx.x) + ((blockIdx.x) * (blockDim.x))));
# 2521 "txInterpTest.cu"
__cuda_local_var_38464_6_non_const_y = ((int)((threadIdx.y) + ((blockIdx.y) * (blockDim.y))));
# 2522 "txInterpTest.cu"
__cuda_local_var_38465_6_non_const_j = ((int)(((unsigned long)__cuda_local_var_38463_6_non_const_x) + (((unsigned long)__cuda_local_var_38464_6_non_const_y) * pitch)));
# 2523 "txInterpTest.cu"
if ((__cuda_local_var_38463_6_non_const_x < 768) && (__cuda_local_var_38464_6_non_const_y < 512))
# 2523 "txInterpTest.cu"
{
# 2524 "txInterpTest.cu"
 float __cuda_local_var_38467_8_non_const_u;
# 2524 "txInterpTest.cu"
 float __cuda_local_var_38467_10_non_const_v;
# 2524 "txInterpTest.cu"
 float __cuda_local_var_38467_12_non_const_rho;
# 2524 "txInterpTest.cu"
 float __cuda_local_var_38467_16_non_const_usqr;
# 2525 "txInterpTest.cu"
__cuda_local_var_38467_12_non_const_rho = (1.0F);
# 2526 "txInterpTest.cu"
__cuda_local_var_38467_8_non_const_u = (0.0F);
# 2527 "txInterpTest.cu"
__cuda_local_var_38467_10_non_const_v = (0.0F);
# 2528 "txInterpTest.cu"
__cuda_local_var_38467_16_non_const_usqr = ((__cuda_local_var_38467_8_non_const_u * __cuda_local_var_38467_8_non_const_u) + (__cuda_local_var_38467_10_non_const_v * __cuda_local_var_38467_10_non_const_v));
# 2530 "txInterpTest.cu"
(f[(((unsigned long)__cuda_local_var_38465_6_non_const_j) + ((0UL * pitch) * 512UL))]) = ((0.4444444478F) * (__cuda_local_var_38467_12_non_const_rho - ((1.5F) * __cuda_local_var_38467_16_non_const_usqr)));
# 2531 "txInterpTest.cu"
(f[(((unsigned long)__cuda_local_var_38465_6_non_const_j) + ((1UL * pitch) * 512UL))]) = ((0.1111111119F) * (((__cuda_local_var_38467_12_non_const_rho + ((3.0F) * __cuda_local_var_38467_8_non_const_u)) + (((4.5F) * __cuda_local_var_38467_8_non_const_u) * __cuda_local_var_38467_8_non_const_u)) - ((1.5F) * __cuda_local_var_38467_16_non_const_usqr)));
# 2532 "txInterpTest.cu"
(f[(((unsigned long)__cuda_local_var_38465_6_non_const_j) + ((2UL * pitch) * 512UL))]) = ((0.1111111119F) * (((__cuda_local_var_38467_12_non_const_rho + ((3.0F) * __cuda_local_var_38467_10_non_const_v)) + (((4.5F) * __cuda_local_var_38467_10_non_const_v) * __cuda_local_var_38467_10_non_const_v)) - ((1.5F) * __cuda_local_var_38467_16_non_const_usqr)));
# 2533 "txInterpTest.cu"
(f[(((unsigned long)__cuda_local_var_38465_6_non_const_j) + ((3UL * pitch) * 512UL))]) = ((0.1111111119F) * (((__cuda_local_var_38467_12_non_const_rho - ((3.0F) * __cuda_local_var_38467_8_non_const_u)) + (((4.5F) * __cuda_local_var_38467_8_non_const_u) * __cuda_local_var_38467_8_non_const_u)) - ((1.5F) * __cuda_local_var_38467_16_non_const_usqr)));
# 2534 "txInterpTest.cu"
(f[(((unsigned long)__cuda_local_var_38465_6_non_const_j) + ((4UL * pitch) * 512UL))]) = ((0.1111111119F) * (((__cuda_local_var_38467_12_non_const_rho - ((3.0F) * __cuda_local_var_38467_10_non_const_v)) + (((4.5F) * __cuda_local_var_38467_10_non_const_v) * __cuda_local_var_38467_10_non_const_v)) - ((1.5F) * __cuda_local_var_38467_16_non_const_usqr)));
# 2535 "txInterpTest.cu"
(f[(((unsigned long)__cuda_local_var_38465_6_non_const_j) + ((5UL * pitch) * 512UL))]) = ((float)((0.02777777777999999864) * ((double)(((__cuda_local_var_38467_12_non_const_rho + ((3.0F) * (__cuda_local_var_38467_8_non_const_u + __cuda_local_var_38467_10_non_const_v))) + (((4.5F) * (__cuda_local_var_38467_8_non_const_u + __cuda_local_var_38467_10_non_const_v)) * (__cuda_local_var_38467_8_non_const_u + __cuda_local_var_38467_10_non_const_v))) - ((1.5F) * __cuda_local_var_38467_16_non_const_usqr)))));
# 2536 "txInterpTest.cu"
(f[(((unsigned long)__cuda_local_var_38465_6_non_const_j) + ((6UL * pitch) * 512UL))]) = ((float)((0.02777777777999999864) * ((double)(((__cuda_local_var_38467_12_non_const_rho + ((3.0F) * ((-__cuda_local_var_38467_8_non_const_u) + __cuda_local_var_38467_10_non_const_v))) + (((4.5F) * ((-__cuda_local_var_38467_8_non_const_u) + __cuda_local_var_38467_10_non_const_v)) * ((-__cuda_local_var_38467_8_non_const_u) + __cuda_local_var_38467_10_non_const_v))) - ((1.5F) * __cuda_local_var_38467_16_non_const_usqr)))));
# 2537 "txInterpTest.cu"
(f[(((unsigned long)__cuda_local_var_38465_6_non_const_j) + ((7UL * pitch) * 512UL))]) = ((float)((0.02777777777999999864) * ((double)(((__cuda_local_var_38467_12_non_const_rho + ((3.0F) * ((-__cuda_local_var_38467_8_non_const_u) - __cuda_local_var_38467_10_non_const_v))) + (((4.5F) * ((-__cuda_local_var_38467_8_non_const_u) - __cuda_local_var_38467_10_non_const_v)) * ((-__cuda_local_var_38467_8_non_const_u) - __cuda_local_var_38467_10_non_const_v))) - ((1.5F) * __cuda_local_var_38467_16_non_const_usqr)))));
# 2538 "txInterpTest.cu"
(f[(((unsigned long)__cuda_local_var_38465_6_non_const_j) + ((8UL * pitch) * 512UL))]) = ((float)((0.02777777777999999864) * ((double)(((__cuda_local_var_38467_12_non_const_rho + ((3.0F) * (__cuda_local_var_38467_8_non_const_u - __cuda_local_var_38467_10_non_const_v))) + (((4.5F) * (__cuda_local_var_38467_8_non_const_u - __cuda_local_var_38467_10_non_const_v)) * (__cuda_local_var_38467_8_non_const_u - __cuda_local_var_38467_10_non_const_v))) - ((1.5F) * __cuda_local_var_38467_16_non_const_usqr)))));
# 2539 "txInterpTest.cu"
}
# 2540 "txInterpTest.cu"
}
# 2540 "txInterpTest.cu"
}}
