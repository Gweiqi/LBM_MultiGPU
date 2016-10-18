# 1 "MRT.cu"
# 1017 "/usr/local/cuda/bin/../include/driver_types.h"
struct CUstream_st;
# 28 "/usr/include/xlocale.h" 3
struct __locale_struct;
# 87 "/usr/include/wchar.h" 3
union _ZN11__mbstate_tUt_E;
# 84 "/usr/include/wchar.h" 3
struct __mbstate_t;
# 206 "/usr/include/libio.h" 3
enum __codecvt_result {

__codecvt_ok,
__codecvt_partial,
__codecvt_error,
__codecvt_noconv};
# 271 "/usr/include/libio.h" 3
struct _IO_FILE;
# 69 "/usr/include/bits/time.h" 3
struct timeval;
# 61 "/usr/include/bits/pthreadtypes.h" 3
struct __pthread_internal_list;
# 78 "/usr/include/bits/pthreadtypes.h" 3
struct _ZN15pthread_mutex_t17__pthread_mutex_sE;
# 77 "/usr/include/bits/pthreadtypes.h" 3
union pthread_mutex_t;
# 203 "/usr/include/math.h" 3
enum _ZUt_ {
FP_NAN,

FP_INFINITE,

FP_ZERO,

FP_SUBNORMAL,

FP_NORMAL};
# 296 "/usr/include/math.h" 3
enum _LIB_VERSION_TYPE {
_IEEE_ = (-1),
_SVID_,
_XOPEN_,
_POSIX_,
_ISOC_};
# 74 "/usr/local/cuda/bin/../include/cuda_texture_types.h"
struct _Z7textureIfLi2EL19cudaTextureReadMode0EE;
# 195 "/usr/local/cuda/bin/../include/cuda.h"
enum CUipcMem_flags_enum {
CU_IPC_MEM_LAZY_ENABLE_PEER_ACCESS = 1};
# 204 "/usr/local/cuda/bin/../include/cuda.h"
enum CUctx_flags_enum {
CU_CTX_SCHED_AUTO,
CU_CTX_SCHED_SPIN,
CU_CTX_SCHED_YIELD,
CU_CTX_SCHED_BLOCKING_SYNC = 4,
CU_CTX_BLOCKING_SYNC = 4,


CU_CTX_SCHED_MASK = 7,
CU_CTX_MAP_HOST,
CU_CTX_LMEM_RESIZE_TO_MAX = 16,
CU_CTX_FLAGS_MASK = 31};
# 221 "/usr/local/cuda/bin/../include/cuda.h"
enum CUevent_flags_enum {
CU_EVENT_DEFAULT,
CU_EVENT_BLOCKING_SYNC,
CU_EVENT_DISABLE_TIMING,
CU_EVENT_INTERPROCESS = 4};
# 231 "/usr/local/cuda/bin/../include/cuda.h"
enum CUarray_format_enum {
CU_AD_FORMAT_UNSIGNED_INT8 = 1,
CU_AD_FORMAT_UNSIGNED_INT16,
CU_AD_FORMAT_UNSIGNED_INT32,
CU_AD_FORMAT_SIGNED_INT8 = 8,
CU_AD_FORMAT_SIGNED_INT16,
CU_AD_FORMAT_SIGNED_INT32,
CU_AD_FORMAT_HALF = 16,
CU_AD_FORMAT_FLOAT = 32};
# 245 "/usr/local/cuda/bin/../include/cuda.h"
enum CUaddress_mode_enum {
CU_TR_ADDRESS_MODE_WRAP,
CU_TR_ADDRESS_MODE_CLAMP,
CU_TR_ADDRESS_MODE_MIRROR,
CU_TR_ADDRESS_MODE_BORDER};
# 255 "/usr/local/cuda/bin/../include/cuda.h"
enum CUfilter_mode_enum {
CU_TR_FILTER_MODE_POINT,
CU_TR_FILTER_MODE_LINEAR};
# 263 "/usr/local/cuda/bin/../include/cuda.h"
enum CUdevice_attribute_enum {
CU_DEVICE_ATTRIBUTE_MAX_THREADS_PER_BLOCK = 1,
CU_DEVICE_ATTRIBUTE_MAX_BLOCK_DIM_X,
CU_DEVICE_ATTRIBUTE_MAX_BLOCK_DIM_Y,
CU_DEVICE_ATTRIBUTE_MAX_BLOCK_DIM_Z,
CU_DEVICE_ATTRIBUTE_MAX_GRID_DIM_X,
CU_DEVICE_ATTRIBUTE_MAX_GRID_DIM_Y,
CU_DEVICE_ATTRIBUTE_MAX_GRID_DIM_Z,
CU_DEVICE_ATTRIBUTE_MAX_SHARED_MEMORY_PER_BLOCK,
CU_DEVICE_ATTRIBUTE_SHARED_MEMORY_PER_BLOCK = 8,
CU_DEVICE_ATTRIBUTE_TOTAL_CONSTANT_MEMORY,
CU_DEVICE_ATTRIBUTE_WARP_SIZE,
CU_DEVICE_ATTRIBUTE_MAX_PITCH,
CU_DEVICE_ATTRIBUTE_MAX_REGISTERS_PER_BLOCK,
CU_DEVICE_ATTRIBUTE_REGISTERS_PER_BLOCK = 12,
CU_DEVICE_ATTRIBUTE_CLOCK_RATE,
CU_DEVICE_ATTRIBUTE_TEXTURE_ALIGNMENT,
CU_DEVICE_ATTRIBUTE_GPU_OVERLAP,
CU_DEVICE_ATTRIBUTE_MULTIPROCESSOR_COUNT,
CU_DEVICE_ATTRIBUTE_KERNEL_EXEC_TIMEOUT,
CU_DEVICE_ATTRIBUTE_INTEGRATED,
CU_DEVICE_ATTRIBUTE_CAN_MAP_HOST_MEMORY,
CU_DEVICE_ATTRIBUTE_COMPUTE_MODE,
CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE1D_WIDTH,
CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_WIDTH,
CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_HEIGHT,
CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE3D_WIDTH,
CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE3D_HEIGHT,
CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE3D_DEPTH,
CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_LAYERED_WIDTH,
CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_LAYERED_HEIGHT,
CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_LAYERED_LAYERS,
CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_ARRAY_WIDTH = 27,
CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_ARRAY_HEIGHT,
CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_ARRAY_NUMSLICES,
CU_DEVICE_ATTRIBUTE_SURFACE_ALIGNMENT,
CU_DEVICE_ATTRIBUTE_CONCURRENT_KERNELS,
CU_DEVICE_ATTRIBUTE_ECC_ENABLED,
CU_DEVICE_ATTRIBUTE_PCI_BUS_ID,
CU_DEVICE_ATTRIBUTE_PCI_DEVICE_ID,
CU_DEVICE_ATTRIBUTE_TCC_DRIVER,
CU_DEVICE_ATTRIBUTE_MEMORY_CLOCK_RATE,
CU_DEVICE_ATTRIBUTE_GLOBAL_MEMORY_BUS_WIDTH,
CU_DEVICE_ATTRIBUTE_L2_CACHE_SIZE,
CU_DEVICE_ATTRIBUTE_MAX_THREADS_PER_MULTIPROCESSOR,
CU_DEVICE_ATTRIBUTE_ASYNC_ENGINE_COUNT,
CU_DEVICE_ATTRIBUTE_UNIFIED_ADDRESSING,
CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE1D_LAYERED_WIDTH,
CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE1D_LAYERED_LAYERS,
CU_DEVICE_ATTRIBUTE_CAN_TEX2D_GATHER,
CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_GATHER_WIDTH,
CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_GATHER_HEIGHT,
CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE3D_WIDTH_ALTERNATE,
CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE3D_HEIGHT_ALTERNATE,
CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE3D_DEPTH_ALTERNATE,
CU_DEVICE_ATTRIBUTE_PCI_DOMAIN_ID,
CU_DEVICE_ATTRIBUTE_TEXTURE_PITCH_ALIGNMENT,
CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURECUBEMAP_WIDTH,
CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURECUBEMAP_LAYERED_WIDTH,
CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURECUBEMAP_LAYERED_LAYERS,
CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACE1D_WIDTH,
CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACE2D_WIDTH,
CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACE2D_HEIGHT,
CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACE3D_WIDTH,
CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACE3D_HEIGHT,
CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACE3D_DEPTH,
CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACE1D_LAYERED_WIDTH,
CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACE1D_LAYERED_LAYERS,
CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACE2D_LAYERED_WIDTH,
CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACE2D_LAYERED_HEIGHT,
CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACE2D_LAYERED_LAYERS,
CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACECUBEMAP_WIDTH,
CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACECUBEMAP_LAYERED_WIDTH,
CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACECUBEMAP_LAYERED_LAYERS,
CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE1D_LINEAR_WIDTH,
CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_LINEAR_WIDTH,
CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_LINEAR_HEIGHT,
CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_LINEAR_PITCH};
# 362 "/usr/local/cuda/bin/../include/cuda.h"
enum CUpointer_attribute_enum {
CU_POINTER_ATTRIBUTE_CONTEXT = 1,
CU_POINTER_ATTRIBUTE_MEMORY_TYPE,
CU_POINTER_ATTRIBUTE_DEVICE_POINTER,
CU_POINTER_ATTRIBUTE_HOST_POINTER};
# 372 "/usr/local/cuda/bin/../include/cuda.h"
enum CUfunction_attribute_enum {
# 378 "/usr/local/cuda/bin/../include/cuda.h"
CU_FUNC_ATTRIBUTE_MAX_THREADS_PER_BLOCK,
# 385 "/usr/local/cuda/bin/../include/cuda.h"
CU_FUNC_ATTRIBUTE_SHARED_SIZE_BYTES,
# 391 "/usr/local/cuda/bin/../include/cuda.h"
CU_FUNC_ATTRIBUTE_CONST_SIZE_BYTES,




CU_FUNC_ATTRIBUTE_LOCAL_SIZE_BYTES,




CU_FUNC_ATTRIBUTE_NUM_REGS,
# 410 "/usr/local/cuda/bin/../include/cuda.h"
CU_FUNC_ATTRIBUTE_PTX_VERSION,
# 419 "/usr/local/cuda/bin/../include/cuda.h"
CU_FUNC_ATTRIBUTE_BINARY_VERSION,

CU_FUNC_ATTRIBUTE_MAX};
# 427 "/usr/local/cuda/bin/../include/cuda.h"
enum CUfunc_cache_enum {
CU_FUNC_CACHE_PREFER_NONE,
CU_FUNC_CACHE_PREFER_SHARED,
CU_FUNC_CACHE_PREFER_L1,
CU_FUNC_CACHE_PREFER_EQUAL};
# 437 "/usr/local/cuda/bin/../include/cuda.h"
enum CUsharedconfig_enum {
CU_SHARED_MEM_CONFIG_DEFAULT_BANK_SIZE,
CU_SHARED_MEM_CONFIG_FOUR_BYTE_BANK_SIZE,
CU_SHARED_MEM_CONFIG_EIGHT_BYTE_BANK_SIZE};
# 446 "/usr/local/cuda/bin/../include/cuda.h"
enum CUmemorytype_enum {
CU_MEMORYTYPE_HOST = 1,
CU_MEMORYTYPE_DEVICE,
CU_MEMORYTYPE_ARRAY,
CU_MEMORYTYPE_UNIFIED};
# 456 "/usr/local/cuda/bin/../include/cuda.h"
enum CUcomputemode_enum {
CU_COMPUTEMODE_DEFAULT,
CU_COMPUTEMODE_EXCLUSIVE,
CU_COMPUTEMODE_PROHIBITED,
CU_COMPUTEMODE_EXCLUSIVE_PROCESS};
# 466 "/usr/local/cuda/bin/../include/cuda.h"
enum CUjit_option_enum {
# 472 "/usr/local/cuda/bin/../include/cuda.h"
CU_JIT_MAX_REGISTERS,
# 485 "/usr/local/cuda/bin/../include/cuda.h"
CU_JIT_THREADS_PER_BLOCK,
# 492 "/usr/local/cuda/bin/../include/cuda.h"
CU_JIT_WALL_TIME,
# 500 "/usr/local/cuda/bin/../include/cuda.h"
CU_JIT_INFO_LOG_BUFFER,
# 508 "/usr/local/cuda/bin/../include/cuda.h"
CU_JIT_INFO_LOG_BUFFER_SIZE_BYTES,
# 516 "/usr/local/cuda/bin/../include/cuda.h"
CU_JIT_ERROR_LOG_BUFFER,
# 524 "/usr/local/cuda/bin/../include/cuda.h"
CU_JIT_ERROR_LOG_BUFFER_SIZE_BYTES,
# 531 "/usr/local/cuda/bin/../include/cuda.h"
CU_JIT_OPTIMIZATION_LEVEL,
# 538 "/usr/local/cuda/bin/../include/cuda.h"
CU_JIT_TARGET_FROM_CUCONTEXT,
# 544 "/usr/local/cuda/bin/../include/cuda.h"
CU_JIT_TARGET,
# 551 "/usr/local/cuda/bin/../include/cuda.h"
CU_JIT_FALLBACK_STRATEGY};
# 558 "/usr/local/cuda/bin/../include/cuda.h"
enum CUjit_target_enum {

CU_TARGET_COMPUTE_10,
CU_TARGET_COMPUTE_11,
CU_TARGET_COMPUTE_12,
CU_TARGET_COMPUTE_13,
CU_TARGET_COMPUTE_20,
CU_TARGET_COMPUTE_21,
CU_TARGET_COMPUTE_30};
# 572 "/usr/local/cuda/bin/../include/cuda.h"
enum CUjit_fallback_enum {

CU_PREFER_PTX,

CU_PREFER_BINARY};
# 583 "/usr/local/cuda/bin/../include/cuda.h"
enum CUgraphicsRegisterFlags_enum {
CU_GRAPHICS_REGISTER_FLAGS_NONE,
CU_GRAPHICS_REGISTER_FLAGS_READ_ONLY,
CU_GRAPHICS_REGISTER_FLAGS_WRITE_DISCARD,
CU_GRAPHICS_REGISTER_FLAGS_SURFACE_LDST = 4,
CU_GRAPHICS_REGISTER_FLAGS_TEXTURE_GATHER = 8};
# 594 "/usr/local/cuda/bin/../include/cuda.h"
enum CUgraphicsMapResourceFlags_enum {
CU_GRAPHICS_MAP_RESOURCE_FLAGS_NONE,
CU_GRAPHICS_MAP_RESOURCE_FLAGS_READ_ONLY,
CU_GRAPHICS_MAP_RESOURCE_FLAGS_WRITE_DISCARD};
# 603 "/usr/local/cuda/bin/../include/cuda.h"
enum CUarray_cubemap_face_enum {
CU_CUBEMAP_FACE_POSITIVE_X,
CU_CUBEMAP_FACE_NEGATIVE_X,
CU_CUBEMAP_FACE_POSITIVE_Y,
CU_CUBEMAP_FACE_NEGATIVE_Y,
CU_CUBEMAP_FACE_POSITIVE_Z,
CU_CUBEMAP_FACE_NEGATIVE_Z};
# 615 "/usr/local/cuda/bin/../include/cuda.h"
enum CUlimit_enum {
CU_LIMIT_STACK_SIZE,
CU_LIMIT_PRINTF_FIFO_SIZE,
CU_LIMIT_MALLOC_HEAP_SIZE};
# 624 "/usr/local/cuda/bin/../include/cuda.h"
enum cudaError_enum {
# 630 "/usr/local/cuda/bin/../include/cuda.h"
CUDA_SUCCESS,
# 636 "/usr/local/cuda/bin/../include/cuda.h"
CUDA_ERROR_INVALID_VALUE,
# 642 "/usr/local/cuda/bin/../include/cuda.h"
CUDA_ERROR_OUT_OF_MEMORY,
# 648 "/usr/local/cuda/bin/../include/cuda.h"
CUDA_ERROR_NOT_INITIALIZED,




CUDA_ERROR_DEINITIALIZED,
# 659 "/usr/local/cuda/bin/../include/cuda.h"
CUDA_ERROR_PROFILER_DISABLED,




CUDA_ERROR_PROFILER_NOT_INITIALIZED,




CUDA_ERROR_PROFILER_ALREADY_STARTED,




CUDA_ERROR_PROFILER_ALREADY_STOPPED,




CUDA_ERROR_NO_DEVICE = 100,
# 685 "/usr/local/cuda/bin/../include/cuda.h"
CUDA_ERROR_INVALID_DEVICE,
# 692 "/usr/local/cuda/bin/../include/cuda.h"
CUDA_ERROR_INVALID_IMAGE = 200,
# 702 "/usr/local/cuda/bin/../include/cuda.h"
CUDA_ERROR_INVALID_CONTEXT,
# 711 "/usr/local/cuda/bin/../include/cuda.h"
CUDA_ERROR_CONTEXT_ALREADY_CURRENT,




CUDA_ERROR_MAP_FAILED = 205,




CUDA_ERROR_UNMAP_FAILED,
# 727 "/usr/local/cuda/bin/../include/cuda.h"
CUDA_ERROR_ARRAY_IS_MAPPED,




CUDA_ERROR_ALREADY_MAPPED,
# 740 "/usr/local/cuda/bin/../include/cuda.h"
CUDA_ERROR_NO_BINARY_FOR_GPU,




CUDA_ERROR_ALREADY_ACQUIRED,




CUDA_ERROR_NOT_MAPPED,
# 756 "/usr/local/cuda/bin/../include/cuda.h"
CUDA_ERROR_NOT_MAPPED_AS_ARRAY,
# 762 "/usr/local/cuda/bin/../include/cuda.h"
CUDA_ERROR_NOT_MAPPED_AS_POINTER,
# 768 "/usr/local/cuda/bin/../include/cuda.h"
CUDA_ERROR_ECC_UNCORRECTABLE,
# 774 "/usr/local/cuda/bin/../include/cuda.h"
CUDA_ERROR_UNSUPPORTED_LIMIT,
# 781 "/usr/local/cuda/bin/../include/cuda.h"
CUDA_ERROR_CONTEXT_ALREADY_IN_USE,




CUDA_ERROR_INVALID_SOURCE = 300,




CUDA_ERROR_FILE_NOT_FOUND,




CUDA_ERROR_SHARED_OBJECT_SYMBOL_NOT_FOUND,




CUDA_ERROR_SHARED_OBJECT_INIT_FAILED,




CUDA_ERROR_OPERATING_SYSTEM,
# 813 "/usr/local/cuda/bin/../include/cuda.h"
CUDA_ERROR_INVALID_HANDLE = 400,
# 820 "/usr/local/cuda/bin/../include/cuda.h"
CUDA_ERROR_NOT_FOUND = 500,
# 829 "/usr/local/cuda/bin/../include/cuda.h"
CUDA_ERROR_NOT_READY = 600,
# 840 "/usr/local/cuda/bin/../include/cuda.h"
CUDA_ERROR_LAUNCH_FAILED = 700,
# 851 "/usr/local/cuda/bin/../include/cuda.h"
CUDA_ERROR_LAUNCH_OUT_OF_RESOURCES,
# 862 "/usr/local/cuda/bin/../include/cuda.h"
CUDA_ERROR_LAUNCH_TIMEOUT,
# 868 "/usr/local/cuda/bin/../include/cuda.h"
CUDA_ERROR_LAUNCH_INCOMPATIBLE_TEXTURING,
# 875 "/usr/local/cuda/bin/../include/cuda.h"
CUDA_ERROR_PEER_ACCESS_ALREADY_ENABLED,
# 882 "/usr/local/cuda/bin/../include/cuda.h"
CUDA_ERROR_PEER_ACCESS_NOT_ENABLED,
# 888 "/usr/local/cuda/bin/../include/cuda.h"
CUDA_ERROR_PRIMARY_CONTEXT_ACTIVE = 708,
# 895 "/usr/local/cuda/bin/../include/cuda.h"
CUDA_ERROR_CONTEXT_IS_DESTROYED,
# 903 "/usr/local/cuda/bin/../include/cuda.h"
CUDA_ERROR_ASSERT,
# 910 "/usr/local/cuda/bin/../include/cuda.h"
CUDA_ERROR_TOO_MANY_PEERS,
# 916 "/usr/local/cuda/bin/../include/cuda.h"
CUDA_ERROR_HOST_MEMORY_ALREADY_REGISTERED,
# 922 "/usr/local/cuda/bin/../include/cuda.h"
CUDA_ERROR_HOST_MEMORY_NOT_REGISTERED,




CUDA_ERROR_UNKNOWN = 999};
# 28 "/usr/include/bits/locale.h" 3
enum _ZUt0_ {
__LC_CTYPE,
__LC_NUMERIC,
__LC_TIME,
__LC_COLLATE,
__LC_MONETARY,
__LC_MESSAGES,
__LC_ALL,
__LC_PAPER,
__LC_NAME,
__LC_ADDRESS,
__LC_TELEPHONE,
__LC_MEASUREMENT,
__LC_IDENTIFICATION};
# 49 "/usr/include/ctype.h" 3
enum _ZUt1_ {
_ISupper = 256,
_ISlower = 512,
_ISalpha = 1024,
_ISdigit = 2048,
_ISxdigit = 4096,
_ISspace = 8192,
_ISprint = 16384,
_ISgraph = 32768,
_ISblank = 1,
_IScntrl,
_ISpunct = 4,
_ISalnum = 8};
# 37 "/usr/include/pthread.h" 3
enum _ZUt2_ {
PTHREAD_CREATE_JOINABLE,

PTHREAD_CREATE_DETACHED};
# 47 "/usr/include/pthread.h" 3
enum _ZUt3_ {
PTHREAD_MUTEX_TIMED_NP,
PTHREAD_MUTEX_RECURSIVE_NP,
PTHREAD_MUTEX_ERRORCHECK_NP,
PTHREAD_MUTEX_ADAPTIVE_NP,


PTHREAD_MUTEX_NORMAL = 0,
PTHREAD_MUTEX_RECURSIVE,
PTHREAD_MUTEX_ERRORCHECK,
PTHREAD_MUTEX_DEFAULT = 0,



PTHREAD_MUTEX_FAST_NP = 0};
# 69 "/usr/include/pthread.h" 3
enum _ZUt4_ {
PTHREAD_MUTEX_STALLED,
PTHREAD_MUTEX_STALLED_NP = 0,
PTHREAD_MUTEX_ROBUST,
PTHREAD_MUTEX_ROBUST_NP = 1};
# 81 "/usr/include/pthread.h" 3
enum _ZUt5_ {
PTHREAD_PRIO_NONE,
PTHREAD_PRIO_INHERIT,
PTHREAD_PRIO_PROTECT};
# 118 "/usr/include/pthread.h" 3
enum _ZUt6_ {
PTHREAD_RWLOCK_PREFER_READER_NP,
PTHREAD_RWLOCK_PREFER_WRITER_NP,
PTHREAD_RWLOCK_PREFER_WRITER_NONRECURSIVE_NP,
PTHREAD_RWLOCK_DEFAULT_NP = 0};
# 150 "/usr/include/pthread.h" 3
enum _ZUt7_ {
PTHREAD_INHERIT_SCHED,

PTHREAD_EXPLICIT_SCHED};
# 160 "/usr/include/pthread.h" 3
enum _ZUt8_ {
PTHREAD_SCOPE_SYSTEM,

PTHREAD_SCOPE_PROCESS};
# 170 "/usr/include/pthread.h" 3
enum _ZUt9_ {
PTHREAD_PROCESS_PRIVATE,

PTHREAD_PROCESS_SHARED};
# 194 "/usr/include/pthread.h" 3
enum _ZUt10_ {
PTHREAD_CANCEL_ENABLE,

PTHREAD_CANCEL_DISABLE};



enum _ZUt11_ {
PTHREAD_CANCEL_DEFERRED,

PTHREAD_CANCEL_ASYNCHRONOUS};
# 27 "/usr/include/bits/confname.h" 3
enum _ZUt12_ {
_PC_LINK_MAX,

_PC_MAX_CANON,

_PC_MAX_INPUT,

_PC_NAME_MAX,

_PC_PATH_MAX,

_PC_PIPE_BUF,

_PC_CHOWN_RESTRICTED,

_PC_NO_TRUNC,

_PC_VDISABLE,

_PC_SYNC_IO,

_PC_ASYNC_IO,

_PC_PRIO_IO,

_PC_SOCK_MAXBUF,

_PC_FILESIZEBITS,

_PC_REC_INCR_XFER_SIZE,

_PC_REC_MAX_XFER_SIZE,

_PC_REC_MIN_XFER_SIZE,

_PC_REC_XFER_ALIGN,

_PC_ALLOC_SIZE_MIN,

_PC_SYMLINK_MAX,

_PC_2_SYMLINKS};
# 74 "/usr/include/bits/confname.h" 3
enum _ZUt13_ {
_SC_ARG_MAX,

_SC_CHILD_MAX,

_SC_CLK_TCK,

_SC_NGROUPS_MAX,

_SC_OPEN_MAX,

_SC_STREAM_MAX,

_SC_TZNAME_MAX,

_SC_JOB_CONTROL,

_SC_SAVED_IDS,

_SC_REALTIME_SIGNALS,

_SC_PRIORITY_SCHEDULING,

_SC_TIMERS,

_SC_ASYNCHRONOUS_IO,

_SC_PRIORITIZED_IO,

_SC_SYNCHRONIZED_IO,

_SC_FSYNC,

_SC_MAPPED_FILES,

_SC_MEMLOCK,

_SC_MEMLOCK_RANGE,

_SC_MEMORY_PROTECTION,

_SC_MESSAGE_PASSING,

_SC_SEMAPHORES,

_SC_SHARED_MEMORY_OBJECTS,

_SC_AIO_LISTIO_MAX,

_SC_AIO_MAX,

_SC_AIO_PRIO_DELTA_MAX,

_SC_DELAYTIMER_MAX,

_SC_MQ_OPEN_MAX,

_SC_MQ_PRIO_MAX,

_SC_VERSION,

_SC_PAGESIZE,


_SC_RTSIG_MAX,

_SC_SEM_NSEMS_MAX,

_SC_SEM_VALUE_MAX,

_SC_SIGQUEUE_MAX,

_SC_TIMER_MAX,




_SC_BC_BASE_MAX,

_SC_BC_DIM_MAX,

_SC_BC_SCALE_MAX,

_SC_BC_STRING_MAX,

_SC_COLL_WEIGHTS_MAX,

_SC_EQUIV_CLASS_MAX,

_SC_EXPR_NEST_MAX,

_SC_LINE_MAX,

_SC_RE_DUP_MAX,

_SC_CHARCLASS_NAME_MAX,


_SC_2_VERSION,

_SC_2_C_BIND,

_SC_2_C_DEV,

_SC_2_FORT_DEV,

_SC_2_FORT_RUN,

_SC_2_SW_DEV,

_SC_2_LOCALEDEF,


_SC_PII,

_SC_PII_XTI,

_SC_PII_SOCKET,

_SC_PII_INTERNET,

_SC_PII_OSI,

_SC_POLL,

_SC_SELECT,

_SC_UIO_MAXIOV,

_SC_IOV_MAX = 60,

_SC_PII_INTERNET_STREAM,

_SC_PII_INTERNET_DGRAM,

_SC_PII_OSI_COTS,

_SC_PII_OSI_CLTS,

_SC_PII_OSI_M,

_SC_T_IOV_MAX,



_SC_THREADS,

_SC_THREAD_SAFE_FUNCTIONS,

_SC_GETGR_R_SIZE_MAX,

_SC_GETPW_R_SIZE_MAX,

_SC_LOGIN_NAME_MAX,

_SC_TTY_NAME_MAX,

_SC_THREAD_DESTRUCTOR_ITERATIONS,

_SC_THREAD_KEYS_MAX,

_SC_THREAD_STACK_MIN,

_SC_THREAD_THREADS_MAX,

_SC_THREAD_ATTR_STACKADDR,

_SC_THREAD_ATTR_STACKSIZE,

_SC_THREAD_PRIORITY_SCHEDULING,

_SC_THREAD_PRIO_INHERIT,

_SC_THREAD_PRIO_PROTECT,

_SC_THREAD_PROCESS_SHARED,


_SC_NPROCESSORS_CONF,

_SC_NPROCESSORS_ONLN,

_SC_PHYS_PAGES,

_SC_AVPHYS_PAGES,

_SC_ATEXIT_MAX,

_SC_PASS_MAX,


_SC_XOPEN_VERSION,

_SC_XOPEN_XCU_VERSION,

_SC_XOPEN_UNIX,

_SC_XOPEN_CRYPT,

_SC_XOPEN_ENH_I18N,

_SC_XOPEN_SHM,


_SC_2_CHAR_TERM,

_SC_2_C_VERSION,

_SC_2_UPE,


_SC_XOPEN_XPG2,

_SC_XOPEN_XPG3,

_SC_XOPEN_XPG4,


_SC_CHAR_BIT,

_SC_CHAR_MAX,

_SC_CHAR_MIN,

_SC_INT_MAX,

_SC_INT_MIN,

_SC_LONG_BIT,

_SC_WORD_BIT,

_SC_MB_LEN_MAX,

_SC_NZERO,

_SC_SSIZE_MAX,

_SC_SCHAR_MAX,

_SC_SCHAR_MIN,

_SC_SHRT_MAX,

_SC_SHRT_MIN,

_SC_UCHAR_MAX,

_SC_UINT_MAX,

_SC_ULONG_MAX,

_SC_USHRT_MAX,


_SC_NL_ARGMAX,

_SC_NL_LANGMAX,

_SC_NL_MSGMAX,

_SC_NL_NMAX,

_SC_NL_SETMAX,

_SC_NL_TEXTMAX,


_SC_XBS5_ILP32_OFF32,

_SC_XBS5_ILP32_OFFBIG,

_SC_XBS5_LP64_OFF64,

_SC_XBS5_LPBIG_OFFBIG,


_SC_XOPEN_LEGACY,

_SC_XOPEN_REALTIME,

_SC_XOPEN_REALTIME_THREADS,


_SC_ADVISORY_INFO,

_SC_BARRIERS,

_SC_BASE,

_SC_C_LANG_SUPPORT,

_SC_C_LANG_SUPPORT_R,

_SC_CLOCK_SELECTION,

_SC_CPUTIME,

_SC_THREAD_CPUTIME,

_SC_DEVICE_IO,

_SC_DEVICE_SPECIFIC,

_SC_DEVICE_SPECIFIC_R,

_SC_FD_MGMT,

_SC_FIFO,

_SC_PIPE,

_SC_FILE_ATTRIBUTES,

_SC_FILE_LOCKING,

_SC_FILE_SYSTEM,

_SC_MONOTONIC_CLOCK,

_SC_MULTI_PROCESS,

_SC_SINGLE_PROCESS,

_SC_NETWORKING,

_SC_READER_WRITER_LOCKS,

_SC_SPIN_LOCKS,

_SC_REGEXP,

_SC_REGEX_VERSION,

_SC_SHELL,

_SC_SIGNALS,

_SC_SPAWN,

_SC_SPORADIC_SERVER,

_SC_THREAD_SPORADIC_SERVER,

_SC_SYSTEM_DATABASE,

_SC_SYSTEM_DATABASE_R,

_SC_TIMEOUTS,

_SC_TYPED_MEMORY_OBJECTS,

_SC_USER_GROUPS,

_SC_USER_GROUPS_R,

_SC_2_PBS,

_SC_2_PBS_ACCOUNTING,

_SC_2_PBS_LOCATE,

_SC_2_PBS_MESSAGE,

_SC_2_PBS_TRACK,

_SC_SYMLOOP_MAX,

_SC_STREAMS,

_SC_2_PBS_CHECKPOINT,


_SC_V6_ILP32_OFF32,

_SC_V6_ILP32_OFFBIG,

_SC_V6_LP64_OFF64,

_SC_V6_LPBIG_OFFBIG,


_SC_HOST_NAME_MAX,

_SC_TRACE,

_SC_TRACE_EVENT_FILTER,

_SC_TRACE_INHERIT,

_SC_TRACE_LOG,


_SC_LEVEL1_ICACHE_SIZE,

_SC_LEVEL1_ICACHE_ASSOC,

_SC_LEVEL1_ICACHE_LINESIZE,

_SC_LEVEL1_DCACHE_SIZE,

_SC_LEVEL1_DCACHE_ASSOC,

_SC_LEVEL1_DCACHE_LINESIZE,

_SC_LEVEL2_CACHE_SIZE,

_SC_LEVEL2_CACHE_ASSOC,

_SC_LEVEL2_CACHE_LINESIZE,

_SC_LEVEL3_CACHE_SIZE,

_SC_LEVEL3_CACHE_ASSOC,

_SC_LEVEL3_CACHE_LINESIZE,

_SC_LEVEL4_CACHE_SIZE,

_SC_LEVEL4_CACHE_ASSOC,

_SC_LEVEL4_CACHE_LINESIZE,



_SC_IPV6 = 235,

_SC_RAW_SOCKETS,


_SC_V7_ILP32_OFF32,

_SC_V7_ILP32_OFFBIG,

_SC_V7_LP64_OFF64,

_SC_V7_LPBIG_OFFBIG,


_SC_SS_REPL_MAX,


_SC_TRACE_EVENT_NAME_MAX,

_SC_TRACE_NAME_MAX,

_SC_TRACE_SYS_MAX,

_SC_TRACE_USER_EVENT_MAX,


_SC_XOPEN_STREAMS,


_SC_THREAD_ROBUST_PRIO_INHERIT,

_SC_THREAD_ROBUST_PRIO_PROTECT};
# 536 "/usr/include/bits/confname.h" 3
enum _ZUt14_ {
_CS_PATH,


_CS_V6_WIDTH_RESTRICTED_ENVS,



_CS_GNU_LIBC_VERSION,

_CS_GNU_LIBPTHREAD_VERSION,


_CS_V5_WIDTH_RESTRICTED_ENVS,



_CS_V7_WIDTH_RESTRICTED_ENVS,



_CS_LFS_CFLAGS = 1000,

_CS_LFS_LDFLAGS,

_CS_LFS_LIBS,

_CS_LFS_LINTFLAGS,

_CS_LFS64_CFLAGS,

_CS_LFS64_LDFLAGS,

_CS_LFS64_LIBS,

_CS_LFS64_LINTFLAGS,


_CS_XBS5_ILP32_OFF32_CFLAGS = 1100,

_CS_XBS5_ILP32_OFF32_LDFLAGS,

_CS_XBS5_ILP32_OFF32_LIBS,

_CS_XBS5_ILP32_OFF32_LINTFLAGS,

_CS_XBS5_ILP32_OFFBIG_CFLAGS,

_CS_XBS5_ILP32_OFFBIG_LDFLAGS,

_CS_XBS5_ILP32_OFFBIG_LIBS,

_CS_XBS5_ILP32_OFFBIG_LINTFLAGS,

_CS_XBS5_LP64_OFF64_CFLAGS,

_CS_XBS5_LP64_OFF64_LDFLAGS,

_CS_XBS5_LP64_OFF64_LIBS,

_CS_XBS5_LP64_OFF64_LINTFLAGS,

_CS_XBS5_LPBIG_OFFBIG_CFLAGS,

_CS_XBS5_LPBIG_OFFBIG_LDFLAGS,

_CS_XBS5_LPBIG_OFFBIG_LIBS,

_CS_XBS5_LPBIG_OFFBIG_LINTFLAGS,


_CS_POSIX_V6_ILP32_OFF32_CFLAGS,

_CS_POSIX_V6_ILP32_OFF32_LDFLAGS,

_CS_POSIX_V6_ILP32_OFF32_LIBS,

_CS_POSIX_V6_ILP32_OFF32_LINTFLAGS,

_CS_POSIX_V6_ILP32_OFFBIG_CFLAGS,

_CS_POSIX_V6_ILP32_OFFBIG_LDFLAGS,

_CS_POSIX_V6_ILP32_OFFBIG_LIBS,

_CS_POSIX_V6_ILP32_OFFBIG_LINTFLAGS,

_CS_POSIX_V6_LP64_OFF64_CFLAGS,

_CS_POSIX_V6_LP64_OFF64_LDFLAGS,

_CS_POSIX_V6_LP64_OFF64_LIBS,

_CS_POSIX_V6_LP64_OFF64_LINTFLAGS,

_CS_POSIX_V6_LPBIG_OFFBIG_CFLAGS,

_CS_POSIX_V6_LPBIG_OFFBIG_LDFLAGS,

_CS_POSIX_V6_LPBIG_OFFBIG_LIBS,

_CS_POSIX_V6_LPBIG_OFFBIG_LINTFLAGS,


_CS_POSIX_V7_ILP32_OFF32_CFLAGS,

_CS_POSIX_V7_ILP32_OFF32_LDFLAGS,

_CS_POSIX_V7_ILP32_OFF32_LIBS,

_CS_POSIX_V7_ILP32_OFF32_LINTFLAGS,

_CS_POSIX_V7_ILP32_OFFBIG_CFLAGS,

_CS_POSIX_V7_ILP32_OFFBIG_LDFLAGS,

_CS_POSIX_V7_ILP32_OFFBIG_LIBS,

_CS_POSIX_V7_ILP32_OFFBIG_LINTFLAGS,

_CS_POSIX_V7_LP64_OFF64_CFLAGS,

_CS_POSIX_V7_LP64_OFF64_LDFLAGS,

_CS_POSIX_V7_LP64_OFF64_LIBS,

_CS_POSIX_V7_LP64_OFF64_LINTFLAGS,

_CS_POSIX_V7_LPBIG_OFFBIG_CFLAGS,

_CS_POSIX_V7_LPBIG_OFFBIG_LDFLAGS,

_CS_POSIX_V7_LPBIG_OFFBIG_LIBS,

_CS_POSIX_V7_LPBIG_OFFBIG_LINTFLAGS};
# 73 "/usr/include/wctype.h" 3
enum _ZUt15_ {
__ISwupper,
__ISwlower,
__ISwalpha,
__ISwdigit,
__ISwxdigit,
__ISwspace,
__ISwprint,
__ISwgraph,
__ISwblank,
__ISwcntrl,
__ISwpunct,
__ISwalnum,

_ISwupper = 16777216,
_ISwlower = 33554432,
_ISwalpha = 67108864,
_ISwdigit = 134217728,
_ISwxdigit = 268435456,
_ISwspace = 536870912,
_ISwprint = 1073741824,
_ISwgraph = (-2147483647-1),
_ISwblank = 65536,
_ISwcntrl = 131072,
_ISwpunct = 262144,
_ISwalnum = 524288};
# 57 "/usr/include/sys/time.h" 3
struct timezone;
# 93 "/usr/include/sys/time.h" 3
enum __itimer_which {


ITIMER_REAL,


ITIMER_VIRTUAL,



ITIMER_PROF};
# 124 "/usr/include/c++/4.4/bits/cpp_type_traits.h" 3
enum _ZNSt9__is_voidIvEUt_E { _ZNSt9__is_voidIvE7__valueE = 1};
# 144 "/usr/include/c++/4.4/bits/cpp_type_traits.h" 3
enum _ZNSt12__is_integerIbEUt_E { _ZNSt12__is_integerIbE7__valueE = 1};
# 151 "/usr/include/c++/4.4/bits/cpp_type_traits.h" 3
enum _ZNSt12__is_integerIcEUt_E { _ZNSt12__is_integerIcE7__valueE = 1};
# 158 "/usr/include/c++/4.4/bits/cpp_type_traits.h" 3
enum _ZNSt12__is_integerIaEUt_E { _ZNSt12__is_integerIaE7__valueE = 1};
# 165 "/usr/include/c++/4.4/bits/cpp_type_traits.h" 3
enum _ZNSt12__is_integerIhEUt_E { _ZNSt12__is_integerIhE7__valueE = 1};
# 173 "/usr/include/c++/4.4/bits/cpp_type_traits.h" 3
enum _ZNSt12__is_integerIwEUt_E { _ZNSt12__is_integerIwE7__valueE = 1};
# 197 "/usr/include/c++/4.4/bits/cpp_type_traits.h" 3
enum _ZNSt12__is_integerIsEUt_E { _ZNSt12__is_integerIsE7__valueE = 1};
# 204 "/usr/include/c++/4.4/bits/cpp_type_traits.h" 3
enum _ZNSt12__is_integerItEUt_E { _ZNSt12__is_integerItE7__valueE = 1};
# 211 "/usr/include/c++/4.4/bits/cpp_type_traits.h" 3
enum _ZNSt12__is_integerIiEUt_E { _ZNSt12__is_integerIiE7__valueE = 1};
# 218 "/usr/include/c++/4.4/bits/cpp_type_traits.h" 3
enum _ZNSt12__is_integerIjEUt_E { _ZNSt12__is_integerIjE7__valueE = 1};
# 225 "/usr/include/c++/4.4/bits/cpp_type_traits.h" 3
enum _ZNSt12__is_integerIlEUt_E { _ZNSt12__is_integerIlE7__valueE = 1};
# 232 "/usr/include/c++/4.4/bits/cpp_type_traits.h" 3
enum _ZNSt12__is_integerImEUt_E { _ZNSt12__is_integerImE7__valueE = 1};
# 239 "/usr/include/c++/4.4/bits/cpp_type_traits.h" 3
enum _ZNSt12__is_integerIxEUt_E { _ZNSt12__is_integerIxE7__valueE = 1};
# 246 "/usr/include/c++/4.4/bits/cpp_type_traits.h" 3
enum _ZNSt12__is_integerIyEUt_E { _ZNSt12__is_integerIyE7__valueE = 1};
# 264 "/usr/include/c++/4.4/bits/cpp_type_traits.h" 3
enum _ZNSt13__is_floatingIfEUt_E { _ZNSt13__is_floatingIfE7__valueE = 1};
# 271 "/usr/include/c++/4.4/bits/cpp_type_traits.h" 3
enum _ZNSt13__is_floatingIdEUt_E { _ZNSt13__is_floatingIdE7__valueE = 1};
# 278 "/usr/include/c++/4.4/bits/cpp_type_traits.h" 3
enum _ZNSt13__is_floatingIeEUt_E { _ZNSt13__is_floatingIeE7__valueE = 1};
# 354 "/usr/include/c++/4.4/bits/cpp_type_traits.h" 3
enum _ZNSt9__is_charIcEUt_E { _ZNSt9__is_charIcE7__valueE = 1};
# 362 "/usr/include/c++/4.4/bits/cpp_type_traits.h" 3
enum _ZNSt9__is_charIwEUt_E { _ZNSt9__is_charIwE7__valueE = 1};
# 377 "/usr/include/c++/4.4/bits/cpp_type_traits.h" 3
enum _ZNSt9__is_byteIcEUt_E { _ZNSt9__is_byteIcE7__valueE = 1};
# 384 "/usr/include/c++/4.4/bits/cpp_type_traits.h" 3
enum _ZNSt9__is_byteIaEUt_E { _ZNSt9__is_byteIaE7__valueE = 1};
# 391 "/usr/include/c++/4.4/bits/cpp_type_traits.h" 3
enum _ZNSt9__is_byteIhEUt_E { _ZNSt9__is_byteIhE7__valueE = 1};
# 237 "/usr/include/c++/4.4/bits/char_traits.h" 3
struct _ZSt11char_traitsIcE;
# 45 "/usr/include/c++/4.4/bits/stringfwd.h" 3
struct _ZSaIcE;
# 140 "/usr/include/c++/4.4/bits/basic_string.h" 3
struct _ZNSs9_Rep_baseE;
# 147 "/usr/include/c++/4.4/bits/basic_string.h" 3
struct _ZNSs4_RepE;
# 252 "/usr/include/c++/4.4/bits/basic_string.h" 3
struct _ZNSs12_Alloc_hiderE;
# 52 "/usr/include/c++/4.4/bits/stringfwd.h" 3
struct _ZSs;
# 335 "/usr/include/c++/4.4/bits/locale_classes.h" 3
struct _ZNSt6locale5facetE; struct __SO__NSt6locale5facetE;
# 465 "/usr/include/c++/4.4/bits/locale_classes.h" 3
struct _ZNSt6locale5_ImplE;
# 302 "/usr/include/c++/4.4/bits/locale_classes.h" 3
enum _ZNSt6localeUt_E { _ZNSt6locale18_S_categories_sizeE = 12};
# 61 "/usr/include/c++/4.4/bits/locale_classes.h" 3
struct _ZSt6locale;
# 60 "/usr/include/c++/4.4/bits/ios_base.h" 3
enum _ZSt13_Ios_Fmtflags {

_ZSt12_S_boolalpha = 1,
_ZSt6_S_dec,
_ZSt8_S_fixed = 4,
_ZSt6_S_hex = 8,
_ZSt11_S_internal = 16,
_ZSt7_S_left = 32,
_ZSt6_S_oct = 64,
_ZSt8_S_right = 128,
_ZSt13_S_scientific = 256,
_ZSt11_S_showbase = 512,
_ZSt12_S_showpoint = 1024,
_ZSt10_S_showpos = 2048,
_ZSt9_S_skipws = 4096,
_ZSt10_S_unitbuf = 8192,
_ZSt12_S_uppercase = 16384,
_ZSt14_S_adjustfield = 176,
_ZSt12_S_basefield = 74,
_ZSt13_S_floatfield = 260,
_ZSt19_S_ios_fmtflags_end = 65536};
# 112 "/usr/include/c++/4.4/bits/ios_base.h" 3
enum _ZSt13_Ios_Openmode {

_ZSt6_S_app = 1,
_ZSt6_S_ate,
_ZSt6_S_bin = 4,
_ZSt5_S_in = 8,
_ZSt6_S_out = 16,
_ZSt8_S_trunc = 32,
_ZSt19_S_ios_openmode_end = 65536};
# 152 "/usr/include/c++/4.4/bits/ios_base.h" 3
enum _ZSt12_Ios_Iostate {

_ZSt10_S_goodbit,
_ZSt9_S_badbit,
_ZSt9_S_eofbit,
_ZSt10_S_failbit = 4,
_ZSt18_S_ios_iostate_end = 65536};
# 189 "/usr/include/c++/4.4/bits/ios_base.h" 3
enum _ZSt12_Ios_Seekdir {

_ZSt6_S_beg,
_ZSt6_S_cur,
_ZSt6_S_end,
_ZSt18_S_ios_seekdir_end = 65536};
# 427 "/usr/include/c++/4.4/bits/ios_base.h" 3
enum _ZNSt8ios_base5eventE {

_ZNSt8ios_base11erase_eventE,
_ZNSt8ios_base11imbue_eventE,
_ZNSt8ios_base13copyfmt_eventE};
# 473 "/usr/include/c++/4.4/bits/ios_base.h" 3
struct _ZNSt8ios_base14_Callback_listE;
# 503 "/usr/include/c++/4.4/bits/ios_base.h" 3
struct _ZNSt8ios_base6_WordsE;
# 515 "/usr/include/c++/4.4/bits/ios_base.h" 3
enum _ZNSt8ios_baseUt_E { _ZNSt8ios_base18_S_local_word_sizeE = 8};
# 537 "/usr/include/c++/4.4/bits/ios_base.h" 3
struct _ZNSt8ios_base4InitE;
# 207 "/usr/include/c++/4.4/bits/ios_base.h" 3
struct _ZSt8ios_base;
# 90 "/usr/include/c++/4.4/iosfwd" 3
struct _ZSt19istreambuf_iteratorIcSt11char_traitsIcEE;


struct _ZSt19ostreambuf_iteratorIcSt11char_traitsIcEE;
# 50 "/usr/include/c++/4.4/iosfwd" 3
struct _ZSt15basic_streambufIcSt11char_traitsIcEE;
# 40 "/usr/include/c++/4.4/x86_64-linux-gnu/bits/ctype_base.h" 3
struct _ZSt10ctype_base;
# 674 "/usr/include/c++/4.4/bits/locale_facets.h" 3
struct _ZSt5ctypeIcE;
# 1521 "/usr/include/c++/4.4/bits/locale_facets.h" 3
enum _ZNSt10__num_baseUt_E {
_ZNSt10__num_base9_S_ominusE,
_ZNSt10__num_base8_S_oplusE,
_ZNSt10__num_base5_S_oxE,
_ZNSt10__num_base5_S_oXE,
_ZNSt10__num_base10_S_odigitsE,
_ZNSt10__num_base14_S_odigits_endE = 20,
_ZNSt10__num_base11_S_oudigitsE = 20,
_ZNSt10__num_base15_S_oudigits_endE = 36,
_ZNSt10__num_base5_S_oeE = 18,
_ZNSt10__num_base5_S_oEE = 34,
_ZNSt10__num_base7_S_oendE = 36};
# 1547 "/usr/include/c++/4.4/bits/locale_facets.h" 3
enum _ZNSt10__num_baseUt0_E {
_ZNSt10__num_base9_S_iminusE,
_ZNSt10__num_base8_S_iplusE,
_ZNSt10__num_base5_S_ixE,
_ZNSt10__num_base5_S_iXE,
_ZNSt10__num_base8_S_izeroE,
_ZNSt10__num_base5_S_ieE = 18,
_ZNSt10__num_base5_S_iEE = 24,
_ZNSt10__num_base7_S_iendE = 26};
# 1908 "/usr/include/c++/4.4/bits/locale_facets.h" 3
struct _ZSt7num_getIcSt19istreambuf_iteratorIcSt11char_traitsIcEEE;
# 2245 "/usr/include/c++/4.4/bits/locale_facets.h" 3
struct _ZSt7num_putIcSt19ostreambuf_iteratorIcSt11char_traitsIcEEE;
# 47 "/usr/include/c++/4.4/iosfwd" 3
struct _ZSt9basic_iosIcSt11char_traitsIcEE;
# 56 "/usr/include/c++/4.4/iosfwd" 3
struct _ZSo; struct __SO__So;
# 48 "/usr/include/c++/4.4/bits/codecvt.h" 3
enum _ZNSt12codecvt_base6resultE {

_ZNSt12codecvt_base2okE,
_ZNSt12codecvt_base7partialE,
_ZNSt12codecvt_base5errorE,
_ZNSt12codecvt_base6noconvE};
# 330 "/usr/include/c++/4.4/bits/codecvt.h" 3
struct _ZSt7codecvtIcc11__mbstate_tE;
# 52 "/usr/include/c++/4.4/x86_64-linux-gnu/bits/basic_file.h" 3
struct _ZSt12__basic_fileIcE;
# 78 "/usr/include/c++/4.4/iosfwd" 3
struct _ZSt13basic_filebufIcSt11char_traitsIcEE;
# 84 "/usr/include/c++/4.4/iosfwd" 3
struct _ZSt14basic_ofstreamIcSt11char_traitsIcEE;
# 51 "/usr/include/c++/4.4/ext/new_allocator.h" 3
struct _ZN9__gnu_cxx13new_allocatorIcEE;
# 149 "/usr/lib/gcc/x86_64-linux-gnu/4.4.3/include/stddef.h" 3
typedef long ptrdiff_t;
# 211 "/usr/lib/gcc/x86_64-linux-gnu/4.4.3/include/stddef.h" 3
typedef unsigned long size_t;
#include "crt/host_runtime.h"
# 40 "/usr/include/xlocale.h" 3
typedef struct __locale_struct *__locale_t;
# 149 "/usr/include/bits/types.h" 3
typedef long __time_t;

typedef long __suseconds_t;
# 49 "/usr/include/stdio.h" 3
typedef struct _IO_FILE FILE;
# 87 "/usr/include/wchar.h" 3
union _ZN11__mbstate_tUt_E {

unsigned __wch;



char __wchb[4];};
# 84 "/usr/include/wchar.h" 3
struct __mbstate_t {
int __count;
# 94 "/usr/include/wchar.h" 3
union _ZN11__mbstate_tUt_E __value;};
typedef struct __mbstate_t __mbstate_t;
# 69 "/usr/include/bits/time.h" 3
struct timeval {

__time_t tv_sec;
__suseconds_t tv_usec;};
# 50 "/usr/include/bits/pthreadtypes.h" 3
typedef unsigned long pthread_t;
# 61 "/usr/include/bits/pthreadtypes.h" 3
struct __pthread_internal_list {

struct __pthread_internal_list *__prev;
struct __pthread_internal_list *__next;};
typedef struct __pthread_internal_list __pthread_list_t;
# 78 "/usr/include/bits/pthreadtypes.h" 3
struct _ZN15pthread_mutex_t17__pthread_mutex_sE {

int __lock;
unsigned __count;
int __owner;

unsigned __nusers;



int __kind;

int __spins;
__pthread_list_t __list;};
# 77 "/usr/include/bits/pthreadtypes.h" 3
union pthread_mutex_t {
# 101 "/usr/include/bits/pthreadtypes.h" 3
struct _ZN15pthread_mutex_t17__pthread_mutex_sE __data;
char __size[40];
long __align;};
typedef union pthread_mutex_t pthread_mutex_t;
# 74 "/usr/local/cuda/bin/../include/cuda_texture_types.h"
struct _Z7textureIfLi2EL19cudaTextureReadMode0EE { struct textureReference __b_16textureReference;};
# 106 "/usr/include/wchar.h" 3
typedef __mbstate_t mbstate_t;
# 47 "/usr/include/c++/4.4/x86_64-linux-gnu/bits/gthr-default.h" 3
typedef pthread_mutex_t __gthread_mutex_t;
# 32 "/usr/include/c++/4.4/x86_64-linux-gnu/bits/atomic_word.h" 3
typedef int _Atomic_word;
# 63 "/usr/include/sys/time.h" 3
typedef struct timezone *__restrict__ __timezone_ptr_t;
# 56 "/usr/include/c++/4.4/bits/stringfwd.h" 3
typedef struct _ZSs _ZSt6string;
# 98 "/usr/include/c++/4.4/bits/postypes.h" 3
typedef ptrdiff_t _ZSt10streamsize;
# 130 "/usr/include/c++/4.4/iosfwd" 3
typedef struct _ZSo _ZSt7ostream;
# 138 "/usr/include/c++/4.4/iosfwd" 3
typedef struct _ZSt14basic_ofstreamIcSt11char_traitsIcEE _ZSt8ofstream;
# 243 "/usr/include/c++/4.4/bits/char_traits.h" 3
typedef mbstate_t _ZNSt11char_traitsIcE10state_typeE;
# 237 "/usr/include/c++/4.4/bits/char_traits.h" 3
struct _ZSt11char_traitsIcE {char __nv_no_debug_dummy_end_padding_0;};
# 59 "/usr/include/c++/4.4/x86_64-linux-gnu/bits/c++locale.h" 3
typedef __locale_t _ZSt10__c_locale;
# 89 "/usr/include/c++/4.4/bits/allocator.h" 3
typedef size_t _ZNSaIcE9size_typeE;
# 45 "/usr/include/c++/4.4/bits/stringfwd.h" 3
struct _ZSaIcE {char __nv_no_debug_dummy_end_padding_0;};
# 112 "/usr/include/c++/4.4/bits/basic_string.h" 3
typedef struct _ZSaIcE _ZNSs14allocator_typeE;
typedef _ZNSaIcE9size_typeE _ZNSs9size_typeE;
# 140 "/usr/include/c++/4.4/bits/basic_string.h" 3
struct _ZNSs9_Rep_baseE {

_ZNSs9size_typeE _M_length;
_ZNSs9size_typeE _M_capacity;
_Atomic_word _M_refcount;char __nv_no_debug_dummy_end_padding_0[4];};


struct _ZNSs4_RepE { struct _ZNSs9_Rep_baseE __b_NSs9_Rep_baseE;};
# 252 "/usr/include/c++/4.4/bits/basic_string.h" 3
struct _ZNSs12_Alloc_hiderE {




char *_M_p;};
# 52 "/usr/include/c++/4.4/bits/stringfwd.h" 3
struct _ZSs {
# 269 "/usr/include/c++/4.4/bits/basic_string.h" 3
struct _ZNSs12_Alloc_hiderE _M_dataplus;};
# 335 "/usr/include/c++/4.4/bits/locale_classes.h" 3
struct _ZNSt6locale5facetE { const long *__vptr;
# 341 "/usr/include/c++/4.4/bits/locale_classes.h" 3
_Atomic_word _M_refcount;char __nv_no_debug_dummy_end_padding_0[4];};
# 335 "/usr/include/c++/4.4/bits/locale_classes.h" 3
struct __SO__NSt6locale5facetE { const long *__vptr;
# 341 "/usr/include/c++/4.4/bits/locale_classes.h" 3
_Atomic_word _M_refcount;};
# 61 "/usr/include/c++/4.4/bits/locale_classes.h" 3
struct _ZSt6locale {
# 278 "/usr/include/c++/4.4/bits/locale_classes.h" 3
struct _ZNSt6locale5_ImplE *_M_impl;};
# 263 "/usr/include/c++/4.4/bits/ios_base.h" 3
typedef enum _ZSt13_Ios_Fmtflags _ZNSt8ios_base8fmtflagsE;
# 338 "/usr/include/c++/4.4/bits/ios_base.h" 3
typedef enum _ZSt12_Ios_Iostate _ZNSt8ios_base7iostateE;
# 369 "/usr/include/c++/4.4/bits/ios_base.h" 3
typedef enum _ZSt13_Ios_Openmode _ZNSt8ios_base8openmodeE;
# 503 "/usr/include/c++/4.4/bits/ios_base.h" 3
struct _ZNSt8ios_base6_WordsE {

void *_M_pword;
long _M_iword;};
# 537 "/usr/include/c++/4.4/bits/ios_base.h" 3
struct _ZNSt8ios_base4InitE {char __nv_no_debug_dummy_end_padding_0;};
# 207 "/usr/include/c++/4.4/bits/ios_base.h" 3
struct _ZSt8ios_base { const long *__vptr;
# 464 "/usr/include/c++/4.4/bits/ios_base.h" 3
_ZSt10streamsize _M_precision;
_ZSt10streamsize _M_width;
_ZNSt8ios_base8fmtflagsE _M_flags;
_ZNSt8ios_base7iostateE _M_exception;
_ZNSt8ios_base7iostateE _M_streambuf_state;
# 494 "/usr/include/c++/4.4/bits/ios_base.h" 3
struct _ZNSt8ios_base14_Callback_listE *_M_callbacks;
# 511 "/usr/include/c++/4.4/bits/ios_base.h" 3
struct _ZNSt8ios_base6_WordsE _M_word_zero;




struct _ZNSt8ios_base6_WordsE _M_local_word[8];


int _M_word_size;
struct _ZNSt8ios_base6_WordsE *_M_word;
# 526 "/usr/include/c++/4.4/bits/ios_base.h" 3
struct _ZSt6locale _M_ios_locale;};
# 123 "/usr/include/c++/4.4/streambuf" 3
typedef char _ZNSt15basic_streambufIcSt11char_traitsIcEE9char_typeE;
typedef struct _ZSt11char_traitsIcE _ZNSt15basic_streambufIcSt11char_traitsIcEE11traits_typeE;
# 50 "/usr/include/c++/4.4/iosfwd" 3
struct _ZSt15basic_streambufIcSt11char_traitsIcEE { const long *__vptr;
# 179 "/usr/include/c++/4.4/streambuf" 3
_ZNSt15basic_streambufIcSt11char_traitsIcEE9char_typeE *_M_in_beg;
_ZNSt15basic_streambufIcSt11char_traitsIcEE9char_typeE *_M_in_cur;
_ZNSt15basic_streambufIcSt11char_traitsIcEE9char_typeE *_M_in_end;
_ZNSt15basic_streambufIcSt11char_traitsIcEE9char_typeE *_M_out_beg;
_ZNSt15basic_streambufIcSt11char_traitsIcEE9char_typeE *_M_out_cur;
_ZNSt15basic_streambufIcSt11char_traitsIcEE9char_typeE *_M_out_end;


struct _ZSt6locale _M_buf_locale;};
# 43 "/usr/include/c++/4.4/x86_64-linux-gnu/bits/ctype_base.h" 3
typedef const int *_ZNSt10ctype_base9__to_typeE;



typedef unsigned short _ZNSt10ctype_base4maskE;
# 40 "/usr/include/c++/4.4/x86_64-linux-gnu/bits/ctype_base.h" 3
struct _ZSt10ctype_base {char __nv_no_debug_dummy_end_padding_0;};
# 679 "/usr/include/c++/4.4/bits/locale_facets.h" 3
typedef char _ZNSt5ctypeIcE9char_typeE;
# 674 "/usr/include/c++/4.4/bits/locale_facets.h" 3
struct _ZSt5ctypeIcE {  const long *__b_NSt6locale5facetE___vptr;
# 341 "/usr/include/c++/4.4/bits/locale_classes.h" 3
_Atomic_word __b_NSt6locale5facetE__M_refcount;
# 683 "/usr/include/c++/4.4/bits/locale_facets.h" 3
_ZSt10__c_locale _M_c_locale_ctype;
char _M_del;
_ZNSt10ctype_base9__to_typeE _M_toupper;
_ZNSt10ctype_base9__to_typeE _M_tolower;
const _ZNSt10ctype_base4maskE *_M_table;
char _M_widen_ok;
char _M_widen[256];
char _M_narrow[256];
char _M_narrow_ok;char __nv_no_debug_dummy_end_padding_0[6];};
# 71 "/usr/include/c++/4.4/bits/basic_ios.h" 3
typedef char _ZNSt9basic_iosIcSt11char_traitsIcEE9char_typeE;
# 82 "/usr/include/c++/4.4/bits/basic_ios.h" 3
typedef struct _ZSt5ctypeIcE _ZNSt9basic_iosIcSt11char_traitsIcEE12__ctype_typeE;

typedef struct _ZSt7num_putIcSt19ostreambuf_iteratorIcSt11char_traitsIcEEE _ZNSt9basic_iosIcSt11char_traitsIcEE14__num_put_typeE;

typedef struct _ZSt7num_getIcSt19istreambuf_iteratorIcSt11char_traitsIcEEE _ZNSt9basic_iosIcSt11char_traitsIcEE14__num_get_typeE;
# 47 "/usr/include/c++/4.4/iosfwd" 3
struct _ZSt9basic_iosIcSt11char_traitsIcEE { struct _ZSt8ios_base __b_St8ios_base;
# 91 "/usr/include/c++/4.4/bits/basic_ios.h" 3
struct _ZSo *_M_tie;
_ZNSt9basic_iosIcSt11char_traitsIcEE9char_typeE _M_fill;
char _M_fill_init;
struct _ZSt15basic_streambufIcSt11char_traitsIcEE *_M_streambuf;


const _ZNSt9basic_iosIcSt11char_traitsIcEE12__ctype_typeE *_M_ctype;

const _ZNSt9basic_iosIcSt11char_traitsIcEE14__num_put_typeE *_M_num_put;

const _ZNSt9basic_iosIcSt11char_traitsIcEE14__num_get_typeE *_M_num_get;};
# 59 "/usr/include/c++/4.4/ostream" 3
typedef char _ZNSo9char_typeE;
# 68 "/usr/include/c++/4.4/ostream" 3
typedef struct _ZSo _ZNSo14__ostream_typeE;
# 56 "/usr/include/c++/4.4/iosfwd" 3
struct _ZSo { const long *__vptr; struct _ZSt9basic_iosIcSt11char_traitsIcEE __v_St9basic_iosIcSt11char_traitsIcEE;}; struct __SO__So { const long *__vptr;};
# 42 "/usr/include/c++/4.4/x86_64-linux-gnu/bits/c++io.h" 3
typedef __gthread_mutex_t _ZSt8__c_lock;


typedef FILE _ZSt8__c_file;
# 52 "/usr/include/c++/4.4/x86_64-linux-gnu/bits/basic_file.h" 3
struct _ZSt12__basic_fileIcE {


_ZSt8__c_file *_M_cfile;


char _M_cfile_created;char __nv_no_debug_dummy_end_padding_0[7];};
# 71 "/usr/include/c++/4.4/fstream" 3
typedef char _ZNSt13basic_filebufIcSt11char_traitsIcEE9char_typeE;
# 78 "/usr/include/c++/4.4/fstream" 3
typedef struct _ZSt13basic_filebufIcSt11char_traitsIcEE _ZNSt13basic_filebufIcSt11char_traitsIcEE14__filebuf_typeE;
typedef struct _ZSt12__basic_fileIcE _ZNSt13basic_filebufIcSt11char_traitsIcEE11__file_typeE;
typedef _ZNSt11char_traitsIcE10state_typeE _ZNSt13basic_filebufIcSt11char_traitsIcEE12__state_typeE;
typedef struct _ZSt7codecvtIcc11__mbstate_tE _ZNSt13basic_filebufIcSt11char_traitsIcEE14__codecvt_typeE;
# 78 "/usr/include/c++/4.4/iosfwd" 3
struct _ZSt13basic_filebufIcSt11char_traitsIcEE { struct _ZSt15basic_streambufIcSt11char_traitsIcEE __b_St15basic_streambufIcSt11char_traitsIcEE;
# 88 "/usr/include/c++/4.4/fstream" 3
_ZSt8__c_lock _M_lock;


_ZNSt13basic_filebufIcSt11char_traitsIcEE11__file_typeE _M_file;


_ZNSt8ios_base8openmodeE _M_mode;


_ZNSt13basic_filebufIcSt11char_traitsIcEE12__state_typeE _M_state_beg;




_ZNSt13basic_filebufIcSt11char_traitsIcEE12__state_typeE _M_state_cur;



_ZNSt13basic_filebufIcSt11char_traitsIcEE12__state_typeE _M_state_last;


_ZNSt13basic_filebufIcSt11char_traitsIcEE9char_typeE *_M_buf;
# 116 "/usr/include/c++/4.4/fstream" 3
size_t _M_buf_size;


char _M_buf_allocated;
# 128 "/usr/include/c++/4.4/fstream" 3
char _M_reading;
char _M_writing;
# 137 "/usr/include/c++/4.4/fstream" 3
_ZNSt13basic_filebufIcSt11char_traitsIcEE9char_typeE _M_pback;
_ZNSt13basic_filebufIcSt11char_traitsIcEE9char_typeE *_M_pback_cur_save;
_ZNSt13basic_filebufIcSt11char_traitsIcEE9char_typeE *_M_pback_end_save;
char _M_pback_init;



const _ZNSt13basic_filebufIcSt11char_traitsIcEE14__codecvt_typeE *_M_codecvt;
# 151 "/usr/include/c++/4.4/fstream" 3
char *_M_ext_buf;




_ZSt10streamsize _M_ext_buf_size;
# 163 "/usr/include/c++/4.4/fstream" 3
const char *_M_ext_next;
char *_M_ext_end;};
# 593 "/usr/include/c++/4.4/fstream" 3
typedef struct _ZSt13basic_filebufIcSt11char_traitsIcEE _ZNSt14basic_ofstreamIcSt11char_traitsIcEE14__filebuf_typeE;
# 84 "/usr/include/c++/4.4/iosfwd" 3
struct _ZSt14basic_ofstreamIcSt11char_traitsIcEE { struct __SO__So __b_So;
# 597 "/usr/include/c++/4.4/fstream" 3
_ZNSt14basic_ofstreamIcSt11char_traitsIcEE14__filebuf_typeE _M_filebuf; struct _ZSt9basic_iosIcSt11char_traitsIcEE __v_St9basic_iosIcSt11char_traitsIcEE;};
# 51 "/usr/include/c++/4.4/ext/new_allocator.h" 3
struct _ZN9__gnu_cxx13new_allocatorIcEE {char __nv_no_debug_dummy_end_padding_0;};
void *memcpy(void*, const void*, size_t); void *memset(void*, int, size_t);
# 140 "/usr/local/cuda/bin/../include/common_functions.h"
extern __attribute__((visibility("default"))) void _ZdlPv(void *);
# 217 "/usr/local/cuda/bin/../include/cuda_runtime_api.h"
extern cudaError_t cudaDeviceSynchronize(void);
# 1786 "/usr/local/cuda/bin/../include/cuda_runtime_api.h"
extern cudaError_t cudaConfigureCall(dim3, dim3, size_t, cudaStream_t);
# 1859 "/usr/local/cuda/bin/../include/cuda_runtime_api.h"
extern cudaError_t cudaFuncSetCacheConfig(const char *, enum cudaFuncCache);
# 2055 "/usr/local/cuda/bin/../include/cuda_runtime_api.h"
extern cudaError_t cudaMalloc(void **, size_t);
# 2123 "/usr/local/cuda/bin/../include/cuda_runtime_api.h"
extern cudaError_t cudaMallocPitch(void **, size_t *, size_t, size_t);
# 2189 "/usr/local/cuda/bin/../include/cuda_runtime_api.h"
extern cudaError_t cudaFree(void *);
# 2870 "/usr/local/cuda/bin/../include/cuda_runtime_api.h"
extern cudaError_t cudaMemcpy(void *, const void *, size_t, enum cudaMemcpyKind);
# 3047 "/usr/local/cuda/bin/../include/cuda_runtime_api.h"
extern cudaError_t cudaMemcpy2D(void *, size_t, const void *, size_t, size_t, size_t, enum cudaMemcpyKind);
# 4396 "/usr/local/cuda/bin/../include/cuda_runtime_api.h"
extern struct cudaChannelFormatDesc cudaCreateChannelDesc(int, int, int, int, enum cudaChannelFormatKind);
# 4494 "/usr/local/cuda/bin/../include/cuda_runtime_api.h"
extern cudaError_t cudaBindTexture2D(size_t *, const struct textureReference *, const void *, const struct cudaChannelFormatDesc *, size_t, size_t, size_t);
# 4543 "/usr/local/cuda/bin/../include/cuda_runtime_api.h"
extern cudaError_t cudaUnbindTexture(const struct textureReference *);
# 103 "/usr/local/cuda/bin/../include/common_functions.h"
extern __attribute__((__malloc__)) void *malloc(size_t);
# 1966 "/usr/local/cuda/bin/../include/math_functions.h"
extern float fmaf(float, float, float);
# 487 "/usr/include/pthread.h" 3
extern __attribute__((visibility("default"))) int pthread_cancel(pthread_t);
# 127 "/usr/include/c++/4.4/x86_64-linux-gnu/bits/gthr-default.h" 3
static __attribute__((__weakref__("pthread_cancel"))) __attribute__((visibility("default"))) int _Z22__gthrw_pthread_cancelm(pthread_t);
# 238 "/usr/include/c++/4.4/x86_64-linux-gnu/bits/gthr-default.h" 3
static __inline__ __attribute__((visibility("default"))) int _Z18__gthread_active_pv(void);
# 73 "/usr/include/sys/time.h" 3
extern int gettimeofday(struct timeval *__restrict__, struct timezone *__restrict__);
# 829 "MRT.cu"
extern int _Z16timeval_subtractPdP7timevalS1_(double *, struct timeval *, struct timeval *);
# 4907 "MRT.cu"
extern int main(int, char **);
# 901 "/usr/local/cuda/bin/../include/cuda_runtime.h"
extern  __attribute__((__weak__)) /* COMDAT group: _Z22cudaFuncSetCacheConfigIFvPfS0_fmEE9cudaErrorPT_13cudaFuncCache */ __inline__ cudaError_t _Z22cudaFuncSetCacheConfigIFvPfS0_fmEE9cudaErrorPT_13cudaFuncCache(void (*)(float *, float *, float, size_t), enum cudaFuncCache);
# 901 "/usr/local/cuda/bin/../include/cuda_runtime.h"
extern  __attribute__((__weak__)) /* COMDAT group: _Z22cudaFuncSetCacheConfigIFvPfS0_fmS0_S0_S0_iEE9cudaErrorPT_13cudaFuncCache */ __inline__ cudaError_t _Z22cudaFuncSetCacheConfigIFvPfS0_fmS0_S0_S0_iEE9cudaErrorPT_13cudaFuncCache(void (*)(float *, float *, float, size_t, float *, float *, float *, int), enum cudaFuncCache);
# 901 "/usr/local/cuda/bin/../include/cuda_runtime.h"
extern  __attribute__((__weak__)) /* COMDAT group: _Z22cudaFuncSetCacheConfigIFvPfS0_fmiEE9cudaErrorPT_13cudaFuncCache */ __inline__ cudaError_t _Z22cudaFuncSetCacheConfigIFvPfS0_fmiEE9cudaErrorPT_13cudaFuncCache(void (*)(float *, float *, float, size_t, int), enum cudaFuncCache);
# 901 "/usr/local/cuda/bin/../include/cuda_runtime.h"
extern  __attribute__((__weak__)) /* COMDAT group: _Z22cudaFuncSetCacheConfigIFvPfS0_fmfiEE9cudaErrorPT_13cudaFuncCache */ __inline__ cudaError_t _Z22cudaFuncSetCacheConfigIFvPfS0_fmfiEE9cudaErrorPT_13cudaFuncCache(void (*)(float *, float *, float, size_t, float, int), enum cudaFuncCache);
# 901 "/usr/local/cuda/bin/../include/cuda_runtime.h"
extern  __attribute__((__weak__)) /* COMDAT group: _Z22cudaFuncSetCacheConfigIFvPfS0_fmfEE9cudaErrorPT_13cudaFuncCache */ __inline__ cudaError_t _Z22cudaFuncSetCacheConfigIFvPfS0_fmfEE9cudaErrorPT_13cudaFuncCache(void (*)(float *, float *, float, size_t, float), enum cudaFuncCache);
# 901 "/usr/local/cuda/bin/../include/cuda_runtime.h"
extern  __attribute__((__weak__)) /* COMDAT group: _Z22cudaFuncSetCacheConfigIFvPfmfEE9cudaErrorPT_13cudaFuncCache */ __inline__ cudaError_t _Z22cudaFuncSetCacheConfigIFvPfmfEE9cudaErrorPT_13cudaFuncCache(void (*)(float *, size_t, float), enum cudaFuncCache);
# 901 "/usr/local/cuda/bin/../include/cuda_runtime.h"
extern  __attribute__((__weak__)) /* COMDAT group: _Z22cudaFuncSetCacheConfigIFvPfS0_mEE9cudaErrorPT_13cudaFuncCache */ __inline__ cudaError_t _Z22cudaFuncSetCacheConfigIFvPfS0_mEE9cudaErrorPT_13cudaFuncCache(void (*)(float *, float *, size_t), enum cudaFuncCache);
# 800 "/usr/local/cuda/bin/../include/cuda_runtime.h"
extern  __attribute__((__weak__)) /* COMDAT group: _Z17cudaUnbindTextureIfLi2EL19cudaTextureReadMode0EE9cudaErrorRK7textureIT_XT0_EXT1_EE */ __inline__ cudaError_t _Z17cudaUnbindTextureIfLi2EL19cudaTextureReadMode0EE9cudaErrorRK7textureIT_XT0_EXT1_EE(const struct _Z7textureIfLi2EL19cudaTextureReadMode0EE *);
extern int __cudaSetupArgSimple();
extern int __cudaLaunch();
# 76 "/usr/local/cuda/bin/../include/cuda_texture_types.h"
extern  __attribute__((__weak__)) /* COMDAT group: _ZN7textureIfLi2EL19cudaTextureReadMode0EEC1Ei21cudaTextureFilterMode22cudaTextureAddressMode */ __inline__ void _ZN7textureIfLi2EL19cudaTextureReadMode0EEC1Ei21cudaTextureFilterMode22cudaTextureAddressMode(struct _Z7textureIfLi2EL19cudaTextureReadMode0EE *const, int, enum cudaTextureFilterMode, enum cudaTextureAddressMode);
extern  __attribute__((__weak__)) /* COMDAT group: _ZN7textureIfLi2EL19cudaTextureReadMode0EEC2Ei21cudaTextureFilterMode22cudaTextureAddressMode */ __inline__ void _ZN7textureIfLi2EL19cudaTextureReadMode0EEC2Ei21cudaTextureFilterMode22cudaTextureAddressMode(struct _Z7textureIfLi2EL19cudaTextureReadMode0EE *const, int, enum cudaTextureFilterMode, enum cudaTextureAddressMode);
# 101 "/usr/include/c++/4.4/bits/allocator.h" 3
extern __inline__ __attribute__((visibility("default"))) void _ZNSaIcEC1Ev(struct _ZSaIcE *const);
extern __inline__ __attribute__((visibility("default"))) void _ZNSaIcEC2Ev(struct _ZSaIcE *const);
# 109 "/usr/include/c++/4.4/bits/allocator.h" 3
extern __inline__ __attribute__((visibility("default"))) void _ZNSaIcED1Ev(struct _ZSaIcE *const);
extern __inline__ __attribute__((visibility("default"))) void _ZNSaIcED2Ev(struct _ZSaIcE *const);
# 431 "/usr/include/c++/4.4/bits/basic_string.h" 3
extern __attribute__((visibility("default"))) void _ZNSsC1ERKSs(struct _ZSs *const, const struct _ZSs *);
# 466 "/usr/include/c++/4.4/bits/basic_string.h" 3
extern __attribute__((visibility("default"))) void _ZNSsC1EPKcRKSaIcE(struct _ZSs *const, const char *, const struct _ZSaIcE *);
# 497 "/usr/include/c++/4.4/bits/basic_string.h" 3
extern __inline__ __attribute__((visibility("default"))) void _ZNSsD1Ev(struct _ZSs *const);
extern __inline__ __attribute__((visibility("default"))) void _ZNSsD2Ev(struct _ZSs *const);
# 855 "/usr/include/c++/4.4/bits/basic_string.h" 3
extern __attribute__((visibility("default"))) struct _ZSs *_ZNSs6appendEPKcm(struct _ZSs *const, const char *, _ZNSs9size_typeE);
# 1615 "/usr/include/c++/4.4/bits/basic_string.h" 3
extern __inline__ __attribute__((visibility("default"))) const char *_ZNKSs5c_strEv(const struct _ZSs *const);
# 235 "/usr/include/c++/4.4/bits/basic_string.h" 3
extern __attribute__((visibility("default"))) void _ZNSs4_Rep10_M_destroyERKSaIcE(struct _ZNSs4_RepE *const, const struct _ZSaIcE *);
# 252 "/usr/include/c++/4.4/bits/basic_string.h" 3
extern  __attribute__((__weak__)) /* COMDAT group: _ZNSs12_Alloc_hiderD1Ev */ __inline__ __attribute__((visibility("default"))) void _ZNSs12_Alloc_hiderD1Ev(struct _ZNSs12_Alloc_hiderE *const);
extern  __attribute__((__weak__)) /* COMDAT group: _ZNSs12_Alloc_hiderD2Ev */ __inline__ __attribute__((visibility("default"))) void _ZNSs12_Alloc_hiderD2Ev(struct _ZNSs12_Alloc_hiderE *const);
# 179 "/usr/include/c++/4.4/bits/locale_classes.h" 3
extern __attribute__((visibility("default"))) void _ZNSt6localeD1Ev(struct _ZSt6locale *const);
# 782 "/usr/include/c++/4.4/bits/ios_base.h" 3
extern __attribute__((visibility("default"))) void _ZNSt8ios_baseD1Ev(struct _ZSt8ios_base *const);
extern __attribute__((visibility("default"))) void _ZNSt8ios_baseD2Ev(struct _ZSt8ios_base *const);

extern __attribute__((visibility("default"))) void _ZNSt8ios_baseC1Ev(struct _ZSt8ios_base *const);
extern __attribute__((visibility("default"))) void _ZNSt8ios_baseC2Ev(struct _ZSt8ios_base *const);
# 541 "/usr/include/c++/4.4/bits/ios_base.h" 3
extern __attribute__((visibility("default"))) void _ZNSt8ios_base4InitC1Ev(struct _ZNSt8ios_base4InitE *const);
extern __attribute__((visibility("default"))) void _ZNSt8ios_base4InitD1Ev(struct _ZNSt8ios_base4InitE *const);
# 192 "/usr/include/c++/4.4/streambuf" 3
extern __inline__ __attribute__((visibility("default"))) void _ZNSt15basic_streambufIcSt11char_traitsIcEED1Ev(struct _ZSt15basic_streambufIcSt11char_traitsIcEE *const);
extern __inline__ __attribute__((visibility("default"))) void _ZNSt15basic_streambufIcSt11char_traitsIcEED0Ev(struct _ZSt15basic_streambufIcSt11char_traitsIcEE *const);
extern __inline__ __attribute__((visibility("default"))) void _ZNSt15basic_streambufIcSt11char_traitsIcEED2Ev(struct _ZSt15basic_streambufIcSt11char_traitsIcEE *const);
# 865 "/usr/include/c++/4.4/bits/locale_facets.h" 3
extern  __attribute__((__weak__)) /* COMDAT group: _ZNKSt5ctypeIcE5widenEc */ __inline__ __attribute__((visibility("default"))) _ZNSt5ctypeIcE9char_typeE _ZNKSt5ctypeIcE5widenEc(const struct _ZSt5ctypeIcE *const, char);
# 1159 "/usr/include/c++/4.4/bits/locale_facets.h" 3
extern __attribute__((visibility("default"))) void _ZNKSt5ctypeIcE13_M_widen_initEv(const struct _ZSt5ctypeIcE *const);
# 138 "/usr/include/c++/4.4/bits/basic_ios.h" 3
extern __attribute__((visibility("default"))) void _ZNSt9basic_iosIcSt11char_traitsIcEE5clearESt12_Ios_Iostate(struct _ZSt9basic_iosIcSt11char_traitsIcEE *const, _ZNSt8ios_base7iostateE);
# 272 "/usr/include/c++/4.4/bits/basic_ios.h" 3
extern __inline__ __attribute__((visibility("default"))) void _ZNSt9basic_iosIcSt11char_traitsIcEED1Ev(struct _ZSt9basic_iosIcSt11char_traitsIcEE *const);
extern __inline__ __attribute__((visibility("default"))) void _ZNSt9basic_iosIcSt11char_traitsIcEED0Ev(struct _ZSt9basic_iosIcSt11char_traitsIcEE *const);
extern __inline__ __attribute__((visibility("default"))) void _ZNSt9basic_iosIcSt11char_traitsIcEED2Ev(struct _ZSt9basic_iosIcSt11char_traitsIcEE *const);
# 450 "/usr/include/c++/4.4/bits/basic_ios.h" 3
extern __inline__ __attribute__((visibility("default"))) void _ZNSt9basic_iosIcSt11char_traitsIcEEC1Ev(struct _ZSt9basic_iosIcSt11char_traitsIcEE *const);
extern __inline__ __attribute__((visibility("default"))) void _ZNSt9basic_iosIcSt11char_traitsIcEEC2Ev(struct _ZSt9basic_iosIcSt11char_traitsIcEE *const);
# 462 "/usr/include/c++/4.4/bits/basic_ios.h" 3
extern __attribute__((visibility("default"))) void _ZNSt9basic_iosIcSt11char_traitsIcEE4initEPSt15basic_streambufIcS1_E(struct _ZSt9basic_iosIcSt11char_traitsIcEE *const, struct _ZSt15basic_streambufIcSt11char_traitsIcEE *);
# 91 "/usr/include/c++/4.4/ostream" 3
extern __inline__ __attribute__((visibility("default"))) void _ZNSoD2Ev(struct _ZSo *const, const long *const *);
extern __inline__ __attribute__((visibility("default"))) void _ZNSoD0Ev(struct _ZSo *const);
extern __inline__ __attribute__((visibility("default"))) void _ZTv0_n24_NSoD0Ev(struct _ZSo *const);
extern __inline__ __attribute__((visibility("default"))) void _ZNSoD1Ev(struct _ZSo *const);
extern __inline__ __attribute__((visibility("default"))) void _ZTv0_n24_NSoD1Ev(struct _ZSo *const);
# 108 "/usr/include/c++/4.4/ostream" 3
extern __inline__ __attribute__((visibility("default"))) _ZNSo14__ostream_typeE *_ZNSolsEPFRSoS_E(struct _ZSo *const, _ZNSo14__ostream_typeE *(*)(_ZNSo14__ostream_typeE *));
# 169 "/usr/include/c++/4.4/ostream" 3
extern __inline__ __attribute__((visibility("default"))) _ZNSo14__ostream_typeE *_ZNSolsEm(struct _ZSo *const, unsigned long);
# 188 "/usr/include/c++/4.4/ostream" 3
extern __attribute__((visibility("default"))) _ZNSo14__ostream_typeE *_ZNSolsEi(struct _ZSo *const, int);
# 209 "/usr/include/c++/4.4/ostream" 3
extern __inline__ __attribute__((visibility("default"))) _ZNSo14__ostream_typeE *_ZNSolsEd(struct _ZSo *const, double);



extern __inline__ __attribute__((visibility("default"))) _ZNSo14__ostream_typeE *_ZNSolsEf(struct _ZSo *const, float);
# 283 "/usr/include/c++/4.4/ostream" 3
extern __attribute__((visibility("default"))) _ZNSo14__ostream_typeE *_ZNSo3putEc(struct _ZSo *const, _ZNSo9char_typeE);
# 324 "/usr/include/c++/4.4/ostream" 3
extern __attribute__((visibility("default"))) _ZNSo14__ostream_typeE *_ZNSo5flushEv(struct _ZSo *const);
# 366 "/usr/include/c++/4.4/ostream" 3
extern __attribute__((visibility("default"))) _ZNSo14__ostream_typeE *_ZNSo9_M_insertImEERSoT_(struct _ZSo *const, unsigned long);
# 366 "/usr/include/c++/4.4/ostream" 3
extern __attribute__((visibility("default"))) _ZNSo14__ostream_typeE *_ZNSo9_M_insertIdEERSoT_(struct _ZSo *const, double);
# 84 "/usr/include/c++/4.4/x86_64-linux-gnu/bits/basic_file.h" 3
extern __attribute__((visibility("default"))) void _ZNSt12__basic_fileIcED1Ev(struct _ZSt12__basic_fileIcE *const);
# 208 "/usr/include/c++/4.4/fstream" 3
extern __attribute__((visibility("default"))) void _ZNSt13basic_filebufIcSt11char_traitsIcEEC1Ev(struct _ZSt13basic_filebufIcSt11char_traitsIcEE *const);





extern __inline__ __attribute__((visibility("default"))) void _ZNSt13basic_filebufIcSt11char_traitsIcEED1Ev(struct _ZSt13basic_filebufIcSt11char_traitsIcEE *const);
extern __inline__ __attribute__((visibility("default"))) void _ZNSt13basic_filebufIcSt11char_traitsIcEED0Ev(struct _ZSt13basic_filebufIcSt11char_traitsIcEE *const);
extern __inline__ __attribute__((visibility("default"))) void _ZNSt13basic_filebufIcSt11char_traitsIcEED2Ev(struct _ZSt13basic_filebufIcSt11char_traitsIcEE *const);
# 265 "/usr/include/c++/4.4/fstream" 3
extern __attribute__((visibility("default"))) _ZNSt13basic_filebufIcSt11char_traitsIcEE14__filebuf_typeE *_ZNSt13basic_filebufIcSt11char_traitsIcEE4openEPKcSt13_Ios_Openmode(struct _ZSt13basic_filebufIcSt11char_traitsIcEE *const, const char *, _ZNSt8ios_base8openmodeE);
# 291 "/usr/include/c++/4.4/fstream" 3
extern __attribute__((visibility("default"))) _ZNSt13basic_filebufIcSt11char_traitsIcEE14__filebuf_typeE *_ZNSt13basic_filebufIcSt11char_traitsIcEE5closeEv(struct _ZSt13basic_filebufIcSt11char_traitsIcEE *const);
# 608 "/usr/include/c++/4.4/fstream" 3
extern __inline__ __attribute__((visibility("default"))) void _ZNSt14basic_ofstreamIcSt11char_traitsIcEEC2Ev(struct _ZSt14basic_ofstreamIcSt11char_traitsIcEE *const, const long *const *);
extern __inline__ __attribute__((visibility("default"))) void _ZNSt14basic_ofstreamIcSt11char_traitsIcEEC1Ev(struct _ZSt14basic_ofstreamIcSt11char_traitsIcEE *const);
# 656 "/usr/include/c++/4.4/fstream" 3
extern __inline__ __attribute__((visibility("default"))) void _ZNSt14basic_ofstreamIcSt11char_traitsIcEED2Ev(struct _ZSt14basic_ofstreamIcSt11char_traitsIcEE *const, const long *const *);
extern __inline__ __attribute__((visibility("default"))) void _ZNSt14basic_ofstreamIcSt11char_traitsIcEED0Ev(struct _ZSt14basic_ofstreamIcSt11char_traitsIcEE *const);
extern __inline__ __attribute__((visibility("default"))) void _ZTv0_n24_NSt14basic_ofstreamIcSt11char_traitsIcEED0Ev(struct _ZSt14basic_ofstreamIcSt11char_traitsIcEE *const);
extern __inline__ __attribute__((visibility("default"))) void _ZNSt14basic_ofstreamIcSt11char_traitsIcEED1Ev(struct _ZSt14basic_ofstreamIcSt11char_traitsIcEE *const);
extern __attribute__((visibility("default"))) void _ZTv0_n24_NSt14basic_ofstreamIcSt11char_traitsIcEED1Ev(struct _ZSt14basic_ofstreamIcSt11char_traitsIcEE *const);
# 696 "/usr/include/c++/4.4/fstream" 3
extern __inline__ __attribute__((visibility("default"))) void _ZNSt14basic_ofstreamIcSt11char_traitsIcEE4openEPKcSt13_Ios_Openmode(struct _ZSt14basic_ofstreamIcSt11char_traitsIcEE *const, const char *, _ZNSt8ios_base8openmodeE);
# 736 "/usr/include/c++/4.4/fstream" 3
extern __inline__ __attribute__((visibility("default"))) void _ZNSt14basic_ofstreamIcSt11char_traitsIcEE5closeEv(struct _ZSt14basic_ofstreamIcSt11char_traitsIcEE *const);
# 66 "/usr/include/c++/4.4/ext/new_allocator.h" 3
extern  __attribute__((__weak__)) /* COMDAT group: _ZN9__gnu_cxx13new_allocatorIcEC1Ev */ __inline__ void _ZN9__gnu_cxx13new_allocatorIcEC1Ev(struct _ZN9__gnu_cxx13new_allocatorIcEE *const);
extern  __attribute__((__weak__)) /* COMDAT group: _ZN9__gnu_cxx13new_allocatorIcEC2Ev */ __inline__ void _ZN9__gnu_cxx13new_allocatorIcEC2Ev(struct _ZN9__gnu_cxx13new_allocatorIcEE *const);
extern  __attribute__((__weak__)) /* COMDAT group: _ZN9__gnu_cxx13new_allocatorIcEC1ERKS1_ */ __inline__ void _ZN9__gnu_cxx13new_allocatorIcEC1ERKS1_(struct _ZN9__gnu_cxx13new_allocatorIcEE *const, const struct _ZN9__gnu_cxx13new_allocatorIcEE *);
extern  __attribute__((__weak__)) /* COMDAT group: _ZN9__gnu_cxx13new_allocatorIcEC2ERKS1_ */ __inline__ void _ZN9__gnu_cxx13new_allocatorIcEC2ERKS1_(struct _ZN9__gnu_cxx13new_allocatorIcEE *const, const struct _ZN9__gnu_cxx13new_allocatorIcEE *);



extern  __attribute__((__weak__)) /* COMDAT group: _ZN9__gnu_cxx13new_allocatorIcED1Ev */ __inline__ void _ZN9__gnu_cxx13new_allocatorIcED1Ev(struct _ZN9__gnu_cxx13new_allocatorIcEE *const);
extern  __attribute__((__weak__)) /* COMDAT group: _ZN9__gnu_cxx13new_allocatorIcED2Ev */ __inline__ void _ZN9__gnu_cxx13new_allocatorIcED2Ev(struct _ZN9__gnu_cxx13new_allocatorIcEE *const);
# 51 "/usr/include/c++/4.4/bits/functexcept.h" 3
extern __attribute__((__noreturn__)) __attribute__((visibility("default"))) void _ZSt16__throw_bad_castv(void);
# 74 "/usr/include/c++/4.4/bits/ostream_insert.h" 3
extern struct _ZSo *_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(struct _ZSo *, const char *, _ZSt10streamsize);
# 538 "/usr/include/c++/4.4/ostream" 3
extern __inline__ struct _ZSo *_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_(struct _ZSo *);
# 505 "/usr/include/c++/4.4/ostream" 3
extern __inline__ struct _ZSo *_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc(struct _ZSo *, const char *);
# 2201 "/usr/include/c++/4.4/bits/basic_string.h" 3
extern  __attribute__((__weak__)) /* COMDAT group: _ZStplIcSt11char_traitsIcESaIcEESbIT_T0_T1_ERKS6_PKS3_ */ __inline__ void _ZStplIcSt11char_traitsIcESaIcEESbIT_T0_T1_ERKS6_PKS3_(struct _ZSs *, const struct _ZSs *, const char *);
# 75 "/usr/include/c++/4.4/ext/atomicity.h" 3
static __inline__ __attribute__((__unused__)) __attribute__((visibility("default"))) _Atomic_word _ZN9__gnu_cxx27__exchange_and_add_dispatchEPii(_Atomic_word *, int);
extern int __cudaRegisterBinary();
extern int __cudaRegisterEntry();
extern int __cudaRegisterGlobalTexture();
static void __sti___11_MRT_cpp1_ii_887ef395(void) __attribute__((__constructor__));
extern int __cxa_atexit();
# 746 "MRT.cu"
__loc_sc__(__text__,,) struct _Z7textureIfLi2EL19cudaTextureReadMode0EE __text_var(texRef_f0A,texRef_f0A);
__loc_sc__(__text__,,) struct _Z7textureIfLi2EL19cudaTextureReadMode0EE __text_var(texRef_f1A,texRef_f1A);
__loc_sc__(__text__,,) struct _Z7textureIfLi2EL19cudaTextureReadMode0EE __text_var(texRef_f2A,texRef_f2A);
__loc_sc__(__text__,,) struct _Z7textureIfLi2EL19cudaTextureReadMode0EE __text_var(texRef_f3A,texRef_f3A);
__loc_sc__(__text__,,) struct _Z7textureIfLi2EL19cudaTextureReadMode0EE __text_var(texRef_f4A,texRef_f4A);
__loc_sc__(__text__,,) struct _Z7textureIfLi2EL19cudaTextureReadMode0EE __text_var(texRef_f5A,texRef_f5A);
__loc_sc__(__text__,,) struct _Z7textureIfLi2EL19cudaTextureReadMode0EE __text_var(texRef_f6A,texRef_f6A);
__loc_sc__(__text__,,) struct _Z7textureIfLi2EL19cudaTextureReadMode0EE __text_var(texRef_f7A,texRef_f7A);
__loc_sc__(__text__,,) struct _Z7textureIfLi2EL19cudaTextureReadMode0EE __text_var(texRef_f8A,texRef_f8A);
__loc_sc__(__text__,,) struct _Z7textureIfLi2EL19cudaTextureReadMode0EE __text_var(texRef_f9A,texRef_f9A);
__loc_sc__(__text__,,) struct _Z7textureIfLi2EL19cudaTextureReadMode0EE __text_var(texRef_f10A,texRef_f10A);
__loc_sc__(__text__,,) struct _Z7textureIfLi2EL19cudaTextureReadMode0EE __text_var(texRef_f11A,texRef_f11A);
__loc_sc__(__text__,,) struct _Z7textureIfLi2EL19cudaTextureReadMode0EE __text_var(texRef_f12A,texRef_f12A);
__loc_sc__(__text__,,) struct _Z7textureIfLi2EL19cudaTextureReadMode0EE __text_var(texRef_f13A,texRef_f13A);
__loc_sc__(__text__,,) struct _Z7textureIfLi2EL19cudaTextureReadMode0EE __text_var(texRef_f14A,texRef_f14A);
__loc_sc__(__text__,,) struct _Z7textureIfLi2EL19cudaTextureReadMode0EE __text_var(texRef_f15A,texRef_f15A);
__loc_sc__(__text__,,) struct _Z7textureIfLi2EL19cudaTextureReadMode0EE __text_var(texRef_f16A,texRef_f16A);
__loc_sc__(__text__,,) struct _Z7textureIfLi2EL19cudaTextureReadMode0EE __text_var(texRef_f17A,texRef_f17A);
__loc_sc__(__text__,,) struct _Z7textureIfLi2EL19cudaTextureReadMode0EE __text_var(texRef_f18A,texRef_f18A);

__loc_sc__(__text__,,) struct _Z7textureIfLi2EL19cudaTextureReadMode0EE __text_var(texRef_f0B,texRef_f0B);
__loc_sc__(__text__,,) struct _Z7textureIfLi2EL19cudaTextureReadMode0EE __text_var(texRef_f1B,texRef_f1B);
__loc_sc__(__text__,,) struct _Z7textureIfLi2EL19cudaTextureReadMode0EE __text_var(texRef_f2B,texRef_f2B);
__loc_sc__(__text__,,) struct _Z7textureIfLi2EL19cudaTextureReadMode0EE __text_var(texRef_f3B,texRef_f3B);
__loc_sc__(__text__,,) struct _Z7textureIfLi2EL19cudaTextureReadMode0EE __text_var(texRef_f4B,texRef_f4B);
__loc_sc__(__text__,,) struct _Z7textureIfLi2EL19cudaTextureReadMode0EE __text_var(texRef_f5B,texRef_f5B);
__loc_sc__(__text__,,) struct _Z7textureIfLi2EL19cudaTextureReadMode0EE __text_var(texRef_f6B,texRef_f6B);
__loc_sc__(__text__,,) struct _Z7textureIfLi2EL19cudaTextureReadMode0EE __text_var(texRef_f7B,texRef_f7B);
__loc_sc__(__text__,,) struct _Z7textureIfLi2EL19cudaTextureReadMode0EE __text_var(texRef_f8B,texRef_f8B);
__loc_sc__(__text__,,) struct _Z7textureIfLi2EL19cudaTextureReadMode0EE __text_var(texRef_f9B,texRef_f9B);
__loc_sc__(__text__,,) struct _Z7textureIfLi2EL19cudaTextureReadMode0EE __text_var(texRef_f10B,texRef_f10B);
__loc_sc__(__text__,,) struct _Z7textureIfLi2EL19cudaTextureReadMode0EE __text_var(texRef_f11B,texRef_f11B);
__loc_sc__(__text__,,) struct _Z7textureIfLi2EL19cudaTextureReadMode0EE __text_var(texRef_f12B,texRef_f12B);
__loc_sc__(__text__,,) struct _Z7textureIfLi2EL19cudaTextureReadMode0EE __text_var(texRef_f13B,texRef_f13B);
__loc_sc__(__text__,,) struct _Z7textureIfLi2EL19cudaTextureReadMode0EE __text_var(texRef_f14B,texRef_f14B);
__loc_sc__(__text__,,) struct _Z7textureIfLi2EL19cudaTextureReadMode0EE __text_var(texRef_f15B,texRef_f15B);
__loc_sc__(__text__,,) struct _Z7textureIfLi2EL19cudaTextureReadMode0EE __text_var(texRef_f16B,texRef_f16B);
__loc_sc__(__text__,,) struct _Z7textureIfLi2EL19cudaTextureReadMode0EE __text_var(texRef_f17B,texRef_f17B);
__loc_sc__(__text__,,) struct _Z7textureIfLi2EL19cudaTextureReadMode0EE __text_var(texRef_f18B,texRef_f18B);


__loc_sc__(__text__,,) struct _Z7textureIfLi2EL19cudaTextureReadMode0EE __text_var(texRef_f0C,texRef_f0C);
__loc_sc__(__text__,,) struct _Z7textureIfLi2EL19cudaTextureReadMode0EE __text_var(texRef_f1C,texRef_f1C);
__loc_sc__(__text__,,) struct _Z7textureIfLi2EL19cudaTextureReadMode0EE __text_var(texRef_f2C,texRef_f2C);
__loc_sc__(__text__,,) struct _Z7textureIfLi2EL19cudaTextureReadMode0EE __text_var(texRef_f3C,texRef_f3C);
__loc_sc__(__text__,,) struct _Z7textureIfLi2EL19cudaTextureReadMode0EE __text_var(texRef_f4C,texRef_f4C);
__loc_sc__(__text__,,) struct _Z7textureIfLi2EL19cudaTextureReadMode0EE __text_var(texRef_f5C,texRef_f5C);
__loc_sc__(__text__,,) struct _Z7textureIfLi2EL19cudaTextureReadMode0EE __text_var(texRef_f6C,texRef_f6C);
__loc_sc__(__text__,,) struct _Z7textureIfLi2EL19cudaTextureReadMode0EE __text_var(texRef_f7C,texRef_f7C);
__loc_sc__(__text__,,) struct _Z7textureIfLi2EL19cudaTextureReadMode0EE __text_var(texRef_f8C,texRef_f8C);
__loc_sc__(__text__,,) struct _Z7textureIfLi2EL19cudaTextureReadMode0EE __text_var(texRef_f9C,texRef_f9C);
__loc_sc__(__text__,,) struct _Z7textureIfLi2EL19cudaTextureReadMode0EE __text_var(texRef_f10C,texRef_f10C);
__loc_sc__(__text__,,) struct _Z7textureIfLi2EL19cudaTextureReadMode0EE __text_var(texRef_f11C,texRef_f11C);
__loc_sc__(__text__,,) struct _Z7textureIfLi2EL19cudaTextureReadMode0EE __text_var(texRef_f12C,texRef_f12C);
__loc_sc__(__text__,,) struct _Z7textureIfLi2EL19cudaTextureReadMode0EE __text_var(texRef_f13C,texRef_f13C);
__loc_sc__(__text__,,) struct _Z7textureIfLi2EL19cudaTextureReadMode0EE __text_var(texRef_f14C,texRef_f14C);
__loc_sc__(__text__,,) struct _Z7textureIfLi2EL19cudaTextureReadMode0EE __text_var(texRef_f15C,texRef_f15C);
__loc_sc__(__text__,,) struct _Z7textureIfLi2EL19cudaTextureReadMode0EE __text_var(texRef_f16C,texRef_f16C);
__loc_sc__(__text__,,) struct _Z7textureIfLi2EL19cudaTextureReadMode0EE __text_var(texRef_f17C,texRef_f17C);
__loc_sc__(__text__,,) struct _Z7textureIfLi2EL19cudaTextureReadMode0EE __text_var(texRef_f18C,texRef_f18C);

__loc_sc__(__text__,,) struct _Z7textureIfLi2EL19cudaTextureReadMode0EE __text_var(texRef_f0D,texRef_f0D);
__loc_sc__(__text__,,) struct _Z7textureIfLi2EL19cudaTextureReadMode0EE __text_var(texRef_f1D,texRef_f1D);
__loc_sc__(__text__,,) struct _Z7textureIfLi2EL19cudaTextureReadMode0EE __text_var(texRef_f2D,texRef_f2D);
__loc_sc__(__text__,,) struct _Z7textureIfLi2EL19cudaTextureReadMode0EE __text_var(texRef_f3D,texRef_f3D);
__loc_sc__(__text__,,) struct _Z7textureIfLi2EL19cudaTextureReadMode0EE __text_var(texRef_f4D,texRef_f4D);
__loc_sc__(__text__,,) struct _Z7textureIfLi2EL19cudaTextureReadMode0EE __text_var(texRef_f5D,texRef_f5D);
__loc_sc__(__text__,,) struct _Z7textureIfLi2EL19cudaTextureReadMode0EE __text_var(texRef_f6D,texRef_f6D);
__loc_sc__(__text__,,) struct _Z7textureIfLi2EL19cudaTextureReadMode0EE __text_var(texRef_f7D,texRef_f7D);
__loc_sc__(__text__,,) struct _Z7textureIfLi2EL19cudaTextureReadMode0EE __text_var(texRef_f8D,texRef_f8D);
__loc_sc__(__text__,,) struct _Z7textureIfLi2EL19cudaTextureReadMode0EE __text_var(texRef_f9D,texRef_f9D);
__loc_sc__(__text__,,) struct _Z7textureIfLi2EL19cudaTextureReadMode0EE __text_var(texRef_f10D,texRef_f10D);
__loc_sc__(__text__,,) struct _Z7textureIfLi2EL19cudaTextureReadMode0EE __text_var(texRef_f11D,texRef_f11D);
__loc_sc__(__text__,,) struct _Z7textureIfLi2EL19cudaTextureReadMode0EE __text_var(texRef_f12D,texRef_f12D);
__loc_sc__(__text__,,) struct _Z7textureIfLi2EL19cudaTextureReadMode0EE __text_var(texRef_f13D,texRef_f13D);
__loc_sc__(__text__,,) struct _Z7textureIfLi2EL19cudaTextureReadMode0EE __text_var(texRef_f14D,texRef_f14D);
__loc_sc__(__text__,,) struct _Z7textureIfLi2EL19cudaTextureReadMode0EE __text_var(texRef_f15D,texRef_f15D);
__loc_sc__(__text__,,) struct _Z7textureIfLi2EL19cudaTextureReadMode0EE __text_var(texRef_f16D,texRef_f16D);
__loc_sc__(__text__,,) struct _Z7textureIfLi2EL19cudaTextureReadMode0EE __text_var(texRef_f17D,texRef_f17D);
__loc_sc__(__text__,,) struct _Z7textureIfLi2EL19cudaTextureReadMode0EE __text_var(texRef_f18D,texRef_f18D);
extern  __attribute__((__weak__)) /* COMDAT group: _ZTSSt9exception */ const char _ZTSSt9exception[13] __attribute__((visibility("default")));
extern  __attribute__((__weak__)) /* COMDAT group: _ZTSSt9bad_alloc */ const char _ZTSSt9bad_alloc[13] __attribute__((visibility("default")));
# 170 "/usr/include/c++/4.4/bits/basic_string.h" 3
extern _ZNSs9size_typeE _ZNSs4_Rep20_S_empty_rep_storageE[] __attribute__((visibility("default")));
# 59 "/usr/include/c++/4.4/iostream" 3
extern _ZSt7ostream _ZSt4cout __attribute__((visibility("default")));
# 72 "/usr/include/c++/4.4/iostream" 3
static struct _ZNSt8ios_base4InitE _ZSt8__ioinit __attribute__((visibility("default"))) = {0};
extern void *__dso_handle __attribute__((visibility("hidden")));
 __attribute__((__weak__)) /* COMDAT group: _ZTSSt9exception */ const char _ZTSSt9exception[13] __attribute__((visibility("default"))) = "St9exception";
 __attribute__((__weak__)) /* COMDAT group: _ZTSSt9bad_alloc */ const char _ZTSSt9bad_alloc[13] __attribute__((visibility("default"))) = "St9bad_alloc";
# 238 "/usr/include/c++/4.4/x86_64-linux-gnu/bits/gthr-default.h" 3
static __inline__ __attribute__((visibility("default"))) int _Z18__gthread_active_pv(void)
{


return (int)(((void *)_Z22__gthrw_pthread_cancelm) != ((void *)0LL));
}
# 829 "MRT.cu"
int _Z16timeval_subtractPdP7timevalS1_( double *result,  struct timeval *x,  struct timeval *y)
{
 struct timeval __cuda_local_var_36761_18_non_const_result0;


if ((x->tv_usec) < (y->tv_usec)) {
 int __cuda_local_var_36765_9_non_const_nsec;
# 835 "MRT.cu"
__cuda_local_var_36765_9_non_const_nsec = ((int)((((y->tv_usec) - (x->tv_usec)) / 1000000L) + 1L));
(y->tv_usec) -= ((long)(1000000 * __cuda_local_var_36765_9_non_const_nsec));
(y->tv_sec) += ((long)__cuda_local_var_36765_9_non_const_nsec);
}
if (((x->tv_usec) - (y->tv_usec)) > 1000000L) {
 int __cuda_local_var_36770_9_non_const_nsec;
# 840 "MRT.cu"
__cuda_local_var_36770_9_non_const_nsec = ((int)(((y->tv_usec) - (x->tv_usec)) / 1000000L));
(y->tv_usec) += ((long)(1000000 * __cuda_local_var_36770_9_non_const_nsec));
(y->tv_sec) -= ((long)__cuda_local_var_36770_9_non_const_nsec);
}



(__cuda_local_var_36761_18_non_const_result0.tv_sec) = ((x->tv_sec) - (y->tv_sec));
(__cuda_local_var_36761_18_non_const_result0.tv_usec) = ((x->tv_usec) - (y->tv_usec));
(*result) = ((((double)(__cuda_local_var_36761_18_non_const_result0.tv_usec)) / (1000000.0)) + ((double)(__cuda_local_var_36761_18_non_const_result0.tv_sec)));


return (int)((x->tv_sec) < (y->tv_sec));
}
# 4907 "MRT.cu"
int main( int argc,  char **argv)
{  struct _ZSaIcE __T210;
 struct _ZSs __T211;
 struct _ZSs __T212;
 int __T213;
 _ZSt8ofstream __cuda_local_var_39376_11_non_const_output;
 _ZSt8ofstream __cuda_local_var_39377_11_non_const_output2;
 _ZSt6string __cuda_local_var_39378_9_non_const_FileName;




 size_t __cuda_local_var_39383_9_non_const_memsize;
# 4919 "MRT.cu"
 size_t __cuda_local_var_39383_18_non_const_memsize2;
 size_t __cuda_local_var_39384_9_non_const_pitch;
 size_t __cuda_local_var_39385_9_non_const_pitch2;
 int __cuda_local_var_39386_6_non_const_i;
# 4922 "MRT.cu"
 int __cuda_local_var_39386_9_non_const_n;
# 4922 "MRT.cu"
 int __cuda_local_var_39386_12_non_const_nBlocks;
# 4922 "MRT.cu"
 int __cuda_local_var_39386_21_non_const_nBlocks2;
# 4922 "MRT.cu"
 int __cuda_local_var_39386_31_non_const_n2;
 float __cuda_local_var_39387_8_non_const_omega;
# 4923 "MRT.cu"
 float __cuda_local_var_39387_15_non_const_CharLength;
# 4923 "MRT.cu"
 float __cuda_local_var_39387_27_non_const_omega2;
# 4937 "MRT.cu"
 float __cuda_local_var_39401_8_non_const_SF_cf;
 float __cuda_local_var_39402_8_non_const_SF_fc;
# 4953 "MRT.cu"
 int __cuda_local_var_39417_6_non_const_B;
 int __cuda_local_var_39418_6_non_const_B2;




 dim3 __cuda_local_var_39423_10_non_const_threads;
 dim3 __cuda_local_var_39424_10_non_const_grid;

 dim3 __cuda_local_var_39426_10_non_const_threads2;
 dim3 __cuda_local_var_39427_10_non_const_grid2;
# 4973 "MRT.cu"
 float *__cuda_local_var_39437_9_non_const_fA_h;
# 4973 "MRT.cu"
 float *__cuda_local_var_39437_15_non_const_fA_d;
# 4973 "MRT.cu"
 float *__cuda_local_var_39437_21_non_const_fB_d;
# 4973 "MRT.cu"
 float *__cuda_local_var_39437_27_non_const_fC_h;
# 4973 "MRT.cu"
 float *__cuda_local_var_39437_33_non_const_fC_d;
# 4973 "MRT.cu"
 float *__cuda_local_var_39437_39_non_const_fD_d;
 float *__cuda_local_var_39438_9_non_const_FX_h;
# 4974 "MRT.cu"
 float *__cuda_local_var_39438_15_non_const_FY_h;
# 4974 "MRT.cu"
 float *__cuda_local_var_39438_21_non_const_FZ_h;
# 4974 "MRT.cu"
 float *__cuda_local_var_39438_27_non_const_FX_d;
# 4974 "MRT.cu"
 float *__cuda_local_var_39438_33_non_const_FY_d;
# 4974 "MRT.cu"
 float *__cuda_local_var_39438_39_non_const_FZ_d;
# 4994 "MRT.cu"
 size_t __cuda_local_var_39458_9_non_const_pitch_elements;
 size_t __cuda_local_var_39459_9_non_const_pitch_elements2;

 struct cudaChannelFormatDesc __cuda_local_var_39461_24_non_const_desc;
# 5354 "MRT.cu"
 struct timeval __cuda_local_var_39805_17_non_const_tdr0;
# 5354 "MRT.cu"
 struct timeval __cuda_local_var_39805_22_non_const_tdr1;
 double __cuda_local_var_39806_9_non_const_restime;
# 5459 "MRT.cu"
 int __cuda_local_var_39903_6_non_const_Nodes;
# 5571 "MRT.cu"
 int __cuda_local_var_40015_6_non_const_row;
 int __cuda_local_var_40016_6_non_const_col;
 int __cuda_local_var_40017_6_non_const_dep;

 float __cuda_local_var_40019_8_non_const_rho;
# 5575 "MRT.cu"
 float __cuda_local_var_40019_13_non_const_u;
# 5575 "MRT.cu"
 float __cuda_local_var_40019_16_non_const_v;
# 5575 "MRT.cu"
 float __cuda_local_var_40019_19_non_const_w;
 int __cuda_local_var_40020_6_non_const_j;
# 4912 "MRT.cu"
_ZNSt14basic_ofstreamIcSt11char_traitsIcEEC1Ev((&__cuda_local_var_39376_11_non_const_output));
_ZNSt14basic_ofstreamIcSt11char_traitsIcEEC1Ev((&__cuda_local_var_39377_11_non_const_output2));
_ZNSsC1EPKcRKSaIcE((&__cuda_local_var_39378_9_non_const_FileName), ((const char *)"test0"), ((_ZNSaIcEC1Ev((&__T210))) , (((const struct _ZSaIcE *)&__T210)))); _ZNSaIcED1Ev((&__T210));

(_ZNSt14basic_ofstreamIcSt11char_traitsIcEE4openEPKcSt13_Ios_Openmode((&__cuda_local_var_39376_11_non_const_output), (_ZNKSs5c_strEv(((_ZStplIcSt11char_traitsIcESaIcEESbIT_T0_T1_ERKS6_PKS3_((&__T211), (((const struct _ZSs *)&__cuda_local_var_39378_9_non_const_FileName)), ((const char *)".dat"))) , (((const struct _ZSs *)&__T211))))), ((enum _ZSt13_Ios_Openmode)(((int)_ZSt6_S_out) | ((int)_ZSt8_S_trunc))))) , (void)(_ZNSsD1Ev((&__T211)));
(_ZNSt14basic_ofstreamIcSt11char_traitsIcEE4openEPKcSt13_Ios_Openmode((&__cuda_local_var_39377_11_non_const_output2), (_ZNKSs5c_strEv(((_ZStplIcSt11char_traitsIcESaIcEESbIT_T0_T1_ERKS6_PKS3_((&__T212), (((const struct _ZSs *)&__cuda_local_var_39378_9_non_const_FileName)), ((const char *)".force"))) , (((const struct _ZSs *)&__T212))))), ((enum _ZSt13_Ios_Openmode)(((int)_ZSt6_S_out) | ((int)_ZSt8_S_trunc))))) , (void)(_ZNSsD1Ev((&__T212)));


__cuda_local_var_39384_9_non_const_pitch = 0UL;
__cuda_local_var_39385_9_non_const_pitch2 = 0UL;



if ((__builtin_fabsf((0.0F))) > (0.001000000047F)) {
_ZNSolsEPFRSoS_E((_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc((&_ZSt4cout), ((const char *)"LRLEVEL and LRFACTOR don\'t match! Exiting..."))), _ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_); {
_ZNSsD1Ev((&__cuda_local_var_39378_9_non_const_FileName)); _ZNSt14basic_ofstreamIcSt11char_traitsIcEED1Ev((&__cuda_local_var_39377_11_non_const_output2)); _ZNSt14basic_ofstreamIcSt11char_traitsIcEED1Ev((&__cuda_local_var_39376_11_non_const_output)); return 0; }
}

__cuda_local_var_39387_15_non_const_CharLength = (8.0F);

__cuda_local_var_39387_8_non_const_omega = ((1.0F) / (((3.0F) * (((0.07999999821F) * __cuda_local_var_39387_15_non_const_CharLength) / (100.0F))) + (0.5F)));
__cuda_local_var_39387_27_non_const_omega2 = ((2.0F) / ((1.0F) + ((2.0F) * (((2.0F) / __cuda_local_var_39387_8_non_const_omega) - (1.0F)))));
if (0) {
__cuda_local_var_39387_27_non_const_omega2 = ((2.0F) / ((1.0F) + ((2.0F) * (((2.0F) / __cuda_local_var_39387_27_non_const_omega2) - (1.0F)))));
}
__cuda_local_var_39401_8_non_const_SF_cf = ((__cuda_local_var_39387_8_non_const_omega * ((1.0F) - __cuda_local_var_39387_27_non_const_omega2)) / ((((1.0F) - __cuda_local_var_39387_8_non_const_omega) * __cuda_local_var_39387_27_non_const_omega2) / (0.5F)));
__cuda_local_var_39402_8_non_const_SF_fc = ((1.0F) / __cuda_local_var_39401_8_non_const_SF_cf);

_ZNSolsEPFRSoS_E((_ZNSolsEf((_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc((&_ZSt4cout), ((const char *)"omega: "))), __cuda_local_var_39387_8_non_const_omega)), _ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_);
_ZNSolsEPFRSoS_E((_ZNSolsEi((_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc((_ZNSolsEi((_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc((_ZNSolsEi((_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc((&_ZSt4cout), ((const char *)"blocksize: "))), 64)), ((const char *)"x"))), 1)), ((const char *)"x"))), 1)), _ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_);
_ZNSolsEPFRSoS_E((_ZNSolsEi((_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc((_ZNSolsEi((_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc((_ZNSolsEi((_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc((&_ZSt4cout), ((const char *)"grid: "))), 64)), ((const char *)"x"))), 64)), ((const char *)"x"))), 64)), _ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_);
_ZNSolsEPFRSoS_E((_ZNSolsEi((_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc((_ZNSolsEi((_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc((_ZNSolsEi((_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc((&_ZSt4cout), ((const char *)"LRblocksize: "))), 64)), ((const char *)"x"))), 1)), ((const char *)"x"))), 1)), _ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_);
_ZNSolsEPFRSoS_E((_ZNSolsEi((_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc((_ZNSolsEi((_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc((_ZNSolsEi((_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc((&_ZSt4cout), ((const char *)"LRgrid: "))), 64)), ((const char *)"x"))), 64)), ((const char *)"x"))), 64)), _ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_);
_ZNSolsEPFRSoS_E((_ZNSolsEi((_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc((&_ZSt4cout), ((const char *)"TMAX: "))), 500)), _ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_);
_ZNSolsEPFRSoS_E((_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc((_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc((&_ZSt4cout), ((const char *)"Method: "))), ((const char *)"SINGLE"))), _ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_);
_ZNSolsEPFRSoS_E((_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc((_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc((&_ZSt4cout), ((const char *)"Model: "))), ((const char *)"MRT"))), _ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_);

__cuda_local_var_39386_12_non_const_nBlocks = 4096;

__cuda_local_var_39386_21_non_const_nBlocks2 = 4096;

__cuda_local_var_39417_6_non_const_B = 64;
__cuda_local_var_39418_6_non_const_B2 = 64;
__cuda_local_var_39386_9_non_const_n = (__cuda_local_var_39386_12_non_const_nBlocks * __cuda_local_var_39417_6_non_const_B);
__cuda_local_var_39386_31_non_const_n2 = (__cuda_local_var_39386_21_non_const_nBlocks2 * __cuda_local_var_39418_6_non_const_B2);
_ZNSolsEPFRSoS_E((_ZNSolsEi((_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc((&_ZSt4cout), ((const char *)"nBlocks:"))), __cuda_local_var_39386_12_non_const_nBlocks)), _ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_);

{ (__cuda_local_var_39423_10_non_const_threads.x) = 64U; (__cuda_local_var_39423_10_non_const_threads.y) = 1U; (__cuda_local_var_39423_10_non_const_threads.z) = 1U; }
{ (__cuda_local_var_39424_10_non_const_grid.x) = 1U; (__cuda_local_var_39424_10_non_const_grid.y) = 64U; (__cuda_local_var_39424_10_non_const_grid.z) = 64U; }

{ (__cuda_local_var_39426_10_non_const_threads2.x) = 64U; (__cuda_local_var_39426_10_non_const_threads2.y) = 1U; (__cuda_local_var_39426_10_non_const_threads2.z) = 1U; }
{ (__cuda_local_var_39427_10_non_const_grid2.x) = 1U; (__cuda_local_var_39427_10_non_const_grid2.y) = 64U; (__cuda_local_var_39427_10_non_const_grid2.z) = 64U; }

__cuda_local_var_39383_9_non_const_memsize = (((unsigned long)__cuda_local_var_39386_9_non_const_n) * 4UL);

__cuda_local_var_39383_18_non_const_memsize2 = (((unsigned long)__cuda_local_var_39386_31_non_const_n2) * 4UL);
# 4975 "MRT.cu"
__cuda_local_var_39437_9_non_const_fA_h = ((float *)(malloc((__cuda_local_var_39383_9_non_const_memsize * 19UL))));
__cuda_local_var_39437_27_non_const_fC_h = ((float *)(malloc((__cuda_local_var_39383_18_non_const_memsize2 * 19UL))));
__cuda_local_var_39438_9_non_const_FX_h = ((float *)(malloc(2000UL)));
__cuda_local_var_39438_15_non_const_FY_h = ((float *)(malloc(2000UL)));
__cuda_local_var_39438_21_non_const_FZ_h = ((float *)(malloc(2000UL)));
cudaMallocPitch(((void **)(&__cuda_local_var_39437_15_non_const_fA_d)), (&__cuda_local_var_39384_9_non_const_pitch), 256UL, 77824UL);
cudaMallocPitch(((void **)(&__cuda_local_var_39437_21_non_const_fB_d)), (&__cuda_local_var_39384_9_non_const_pitch), 256UL, 77824UL);

if (((const char *)"NO") == ((const char *)"YES")) {
cudaMallocPitch(((void **)(&__cuda_local_var_39437_33_non_const_fC_d)), (&__cuda_local_var_39385_9_non_const_pitch2), 256UL, 77824UL);
cudaMallocPitch(((void **)(&__cuda_local_var_39437_39_non_const_fD_d)), (&__cuda_local_var_39385_9_non_const_pitch2), 256UL, 77824UL);
}

cudaMalloc(((void **)(&__cuda_local_var_39438_27_non_const_FX_d)), 2000UL);
cudaMalloc(((void **)(&__cuda_local_var_39438_33_non_const_FY_d)), 2000UL);
cudaMalloc(((void **)(&__cuda_local_var_39438_39_non_const_FZ_d)), 2000UL);

_ZNSolsEPFRSoS_E((_ZNSolsEm((_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc((_ZNSolsEm((&_ZSt4cout), __cuda_local_var_39384_9_non_const_pitch)), ((const char *)", "))), __cuda_local_var_39385_9_non_const_pitch2)), _ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_);

__cuda_local_var_39458_9_non_const_pitch_elements = (__cuda_local_var_39384_9_non_const_pitch / 4UL);
__cuda_local_var_39459_9_non_const_pitch_elements2 = (__cuda_local_var_39385_9_non_const_pitch2 / 4UL);

__cuda_local_var_39461_24_non_const_desc = ((__T213 = 32) , (cudaCreateChannelDesc(__T213, 0, 0, 0, cudaChannelFormatKindFloat)));
for (__cuda_local_var_39386_6_non_const_i = 0; (__cuda_local_var_39386_6_non_const_i < (__cuda_local_var_39386_9_non_const_n * 19)); __cuda_local_var_39386_6_non_const_i++)
{
(__cuda_local_var_39437_9_non_const_fA_h[__cuda_local_var_39386_6_non_const_i]) = ((float)__cuda_local_var_39386_6_non_const_i);
}
for (__cuda_local_var_39386_6_non_const_i = 0; (__cuda_local_var_39386_6_non_const_i < (__cuda_local_var_39386_31_non_const_n2 * 19)); __cuda_local_var_39386_6_non_const_i++)
{
(__cuda_local_var_39437_27_non_const_fC_h[__cuda_local_var_39386_6_non_const_i]) = (0.0F);
}
for (__cuda_local_var_39386_6_non_const_i = 0; (__cuda_local_var_39386_6_non_const_i < 500); __cuda_local_var_39386_6_non_const_i++) {
(__cuda_local_var_39438_9_non_const_FX_h[__cuda_local_var_39386_6_non_const_i]) = (0.0F);
(__cuda_local_var_39438_15_non_const_FY_h[__cuda_local_var_39386_6_non_const_i]) = (0.0F);
(__cuda_local_var_39438_21_non_const_FZ_h[__cuda_local_var_39386_6_non_const_i]) = (0.0F);
}
cudaMemcpy(((void *)__cuda_local_var_39438_27_non_const_FX_d), ((const void *)__cuda_local_var_39438_9_non_const_FX_h), 2000UL, cudaMemcpyHostToDevice);
cudaMemcpy(((void *)__cuda_local_var_39438_33_non_const_FY_d), ((const void *)__cuda_local_var_39438_15_non_const_FY_h), 2000UL, cudaMemcpyHostToDevice);
cudaMemcpy(((void *)__cuda_local_var_39438_39_non_const_FZ_d), ((const void *)__cuda_local_var_39438_21_non_const_FZ_h), 2000UL, cudaMemcpyHostToDevice);
# 5028 "MRT.cu"
if (1)
{
((__text_var(texRef_f0B,texRef_f0B).__b_16textureReference).normalized) = 0;
((__text_var(texRef_f1B,texRef_f1B).__b_16textureReference).normalized) = 0;
((__text_var(texRef_f2B,texRef_f2B).__b_16textureReference).normalized) = 0;
((__text_var(texRef_f3B,texRef_f3B).__b_16textureReference).normalized) = 0;
((__text_var(texRef_f4B,texRef_f4B).__b_16textureReference).normalized) = 0;
((__text_var(texRef_f5B,texRef_f5B).__b_16textureReference).normalized) = 0;
((__text_var(texRef_f6B,texRef_f6B).__b_16textureReference).normalized) = 0;
((__text_var(texRef_f7B,texRef_f7B).__b_16textureReference).normalized) = 0;
((__text_var(texRef_f8B,texRef_f8B).__b_16textureReference).normalized) = 0;
((__text_var(texRef_f9B,texRef_f9B).__b_16textureReference).normalized) = 0;
((__text_var(texRef_f10B,texRef_f10B).__b_16textureReference).normalized) = 0;
((__text_var(texRef_f11B,texRef_f11B).__b_16textureReference).normalized) = 0;
((__text_var(texRef_f12B,texRef_f12B).__b_16textureReference).normalized) = 0;
((__text_var(texRef_f13B,texRef_f13B).__b_16textureReference).normalized) = 0;
((__text_var(texRef_f14B,texRef_f14B).__b_16textureReference).normalized) = 0;
((__text_var(texRef_f15B,texRef_f15B).__b_16textureReference).normalized) = 0;
((__text_var(texRef_f16B,texRef_f16B).__b_16textureReference).normalized) = 0;
((__text_var(texRef_f17B,texRef_f17B).__b_16textureReference).normalized) = 0;
((__text_var(texRef_f18B,texRef_f18B).__b_16textureReference).normalized) = 0;
((__text_var(texRef_f0B,texRef_f0B).__b_16textureReference).filterMode) = cudaFilterModeLinear;
((__text_var(texRef_f1B,texRef_f1B).__b_16textureReference).filterMode) = cudaFilterModeLinear;
((__text_var(texRef_f2B,texRef_f2B).__b_16textureReference).filterMode) = cudaFilterModeLinear;
((__text_var(texRef_f3B,texRef_f3B).__b_16textureReference).filterMode) = cudaFilterModeLinear;
((__text_var(texRef_f4B,texRef_f4B).__b_16textureReference).filterMode) = cudaFilterModeLinear;
((__text_var(texRef_f5B,texRef_f5B).__b_16textureReference).filterMode) = cudaFilterModeLinear;
((__text_var(texRef_f6B,texRef_f6B).__b_16textureReference).filterMode) = cudaFilterModeLinear;
((__text_var(texRef_f7B,texRef_f7B).__b_16textureReference).filterMode) = cudaFilterModeLinear;
((__text_var(texRef_f8B,texRef_f8B).__b_16textureReference).filterMode) = cudaFilterModeLinear;
((__text_var(texRef_f9B,texRef_f9B).__b_16textureReference).filterMode) = cudaFilterModeLinear;
((__text_var(texRef_f10B,texRef_f10B).__b_16textureReference).filterMode) = cudaFilterModeLinear;
((__text_var(texRef_f11B,texRef_f11B).__b_16textureReference).filterMode) = cudaFilterModeLinear;
((__text_var(texRef_f12B,texRef_f12B).__b_16textureReference).filterMode) = cudaFilterModeLinear;
((__text_var(texRef_f13B,texRef_f13B).__b_16textureReference).filterMode) = cudaFilterModeLinear;
((__text_var(texRef_f14B,texRef_f14B).__b_16textureReference).filterMode) = cudaFilterModeLinear;
((__text_var(texRef_f15B,texRef_f15B).__b_16textureReference).filterMode) = cudaFilterModeLinear;
((__text_var(texRef_f16B,texRef_f16B).__b_16textureReference).filterMode) = cudaFilterModeLinear;
((__text_var(texRef_f17B,texRef_f17B).__b_16textureReference).filterMode) = cudaFilterModeLinear;
((__text_var(texRef_f18B,texRef_f18B).__b_16textureReference).filterMode) = cudaFilterModeLinear;

((__text_var(texRef_f0A,texRef_f0A).__b_16textureReference).normalized) = 0;
((__text_var(texRef_f1A,texRef_f1A).__b_16textureReference).normalized) = 0;
((__text_var(texRef_f2A,texRef_f2A).__b_16textureReference).normalized) = 0;
((__text_var(texRef_f3A,texRef_f3A).__b_16textureReference).normalized) = 0;
((__text_var(texRef_f4A,texRef_f4A).__b_16textureReference).normalized) = 0;
((__text_var(texRef_f5A,texRef_f5A).__b_16textureReference).normalized) = 0;
((__text_var(texRef_f6A,texRef_f6A).__b_16textureReference).normalized) = 0;
((__text_var(texRef_f7A,texRef_f7A).__b_16textureReference).normalized) = 0;
((__text_var(texRef_f8A,texRef_f8A).__b_16textureReference).normalized) = 0;
((__text_var(texRef_f9A,texRef_f9A).__b_16textureReference).normalized) = 0;
((__text_var(texRef_f10A,texRef_f10A).__b_16textureReference).normalized) = 0;
((__text_var(texRef_f11A,texRef_f11A).__b_16textureReference).normalized) = 0;
((__text_var(texRef_f12A,texRef_f12A).__b_16textureReference).normalized) = 0;
((__text_var(texRef_f13A,texRef_f13A).__b_16textureReference).normalized) = 0;
((__text_var(texRef_f14A,texRef_f14A).__b_16textureReference).normalized) = 0;
((__text_var(texRef_f15A,texRef_f15A).__b_16textureReference).normalized) = 0;
((__text_var(texRef_f16A,texRef_f16A).__b_16textureReference).normalized) = 0;
((__text_var(texRef_f17A,texRef_f17A).__b_16textureReference).normalized) = 0;
((__text_var(texRef_f18A,texRef_f18A).__b_16textureReference).normalized) = 0;
((__text_var(texRef_f0A,texRef_f0A).__b_16textureReference).filterMode) = cudaFilterModeLinear;
((__text_var(texRef_f1A,texRef_f1A).__b_16textureReference).filterMode) = cudaFilterModeLinear;
((__text_var(texRef_f2A,texRef_f2A).__b_16textureReference).filterMode) = cudaFilterModeLinear;
((__text_var(texRef_f3A,texRef_f3A).__b_16textureReference).filterMode) = cudaFilterModeLinear;
((__text_var(texRef_f4A,texRef_f4A).__b_16textureReference).filterMode) = cudaFilterModeLinear;
((__text_var(texRef_f5A,texRef_f5A).__b_16textureReference).filterMode) = cudaFilterModeLinear;
((__text_var(texRef_f6A,texRef_f6A).__b_16textureReference).filterMode) = cudaFilterModeLinear;
((__text_var(texRef_f7A,texRef_f7A).__b_16textureReference).filterMode) = cudaFilterModeLinear;
((__text_var(texRef_f8A,texRef_f8A).__b_16textureReference).filterMode) = cudaFilterModeLinear;
((__text_var(texRef_f9A,texRef_f9A).__b_16textureReference).filterMode) = cudaFilterModeLinear;
((__text_var(texRef_f10A,texRef_f10A).__b_16textureReference).filterMode) = cudaFilterModeLinear;
((__text_var(texRef_f11A,texRef_f11A).__b_16textureReference).filterMode) = cudaFilterModeLinear;
((__text_var(texRef_f12A,texRef_f12A).__b_16textureReference).filterMode) = cudaFilterModeLinear;
((__text_var(texRef_f13A,texRef_f13A).__b_16textureReference).filterMode) = cudaFilterModeLinear;
((__text_var(texRef_f14A,texRef_f14A).__b_16textureReference).filterMode) = cudaFilterModeLinear;
((__text_var(texRef_f15A,texRef_f15A).__b_16textureReference).filterMode) = cudaFilterModeLinear;
((__text_var(texRef_f16A,texRef_f16A).__b_16textureReference).filterMode) = cudaFilterModeLinear;
((__text_var(texRef_f17A,texRef_f17A).__b_16textureReference).filterMode) = cudaFilterModeLinear;
((__text_var(texRef_f18A,texRef_f18A).__b_16textureReference).filterMode) = cudaFilterModeLinear;


((__text_var(texRef_f0C,texRef_f0C).__b_16textureReference).normalized) = 0;
((__text_var(texRef_f1C,texRef_f1C).__b_16textureReference).normalized) = 0;
((__text_var(texRef_f2C,texRef_f2C).__b_16textureReference).normalized) = 0;
((__text_var(texRef_f3C,texRef_f3C).__b_16textureReference).normalized) = 0;
((__text_var(texRef_f4C,texRef_f4C).__b_16textureReference).normalized) = 0;
((__text_var(texRef_f5C,texRef_f5C).__b_16textureReference).normalized) = 0;
((__text_var(texRef_f6C,texRef_f6C).__b_16textureReference).normalized) = 0;
((__text_var(texRef_f7C,texRef_f7C).__b_16textureReference).normalized) = 0;
((__text_var(texRef_f8C,texRef_f8C).__b_16textureReference).normalized) = 0;
((__text_var(texRef_f9C,texRef_f9C).__b_16textureReference).normalized) = 0;
((__text_var(texRef_f10C,texRef_f10C).__b_16textureReference).normalized) = 0;
((__text_var(texRef_f11C,texRef_f11C).__b_16textureReference).normalized) = 0;
((__text_var(texRef_f12C,texRef_f12C).__b_16textureReference).normalized) = 0;
((__text_var(texRef_f13C,texRef_f13C).__b_16textureReference).normalized) = 0;
((__text_var(texRef_f14C,texRef_f14C).__b_16textureReference).normalized) = 0;
((__text_var(texRef_f15C,texRef_f15C).__b_16textureReference).normalized) = 0;
((__text_var(texRef_f16C,texRef_f16C).__b_16textureReference).normalized) = 0;
((__text_var(texRef_f17C,texRef_f17C).__b_16textureReference).normalized) = 0;
((__text_var(texRef_f18C,texRef_f18C).__b_16textureReference).normalized) = 0;
((__text_var(texRef_f0C,texRef_f0C).__b_16textureReference).filterMode) = cudaFilterModeLinear;
((__text_var(texRef_f1C,texRef_f1C).__b_16textureReference).filterMode) = cudaFilterModeLinear;
((__text_var(texRef_f2C,texRef_f2C).__b_16textureReference).filterMode) = cudaFilterModeLinear;
((__text_var(texRef_f3C,texRef_f3C).__b_16textureReference).filterMode) = cudaFilterModeLinear;
((__text_var(texRef_f4C,texRef_f4C).__b_16textureReference).filterMode) = cudaFilterModeLinear;
((__text_var(texRef_f5C,texRef_f5C).__b_16textureReference).filterMode) = cudaFilterModeLinear;
((__text_var(texRef_f6C,texRef_f6C).__b_16textureReference).filterMode) = cudaFilterModeLinear;
((__text_var(texRef_f7C,texRef_f7C).__b_16textureReference).filterMode) = cudaFilterModeLinear;
((__text_var(texRef_f8C,texRef_f8C).__b_16textureReference).filterMode) = cudaFilterModeLinear;
((__text_var(texRef_f9C,texRef_f9C).__b_16textureReference).filterMode) = cudaFilterModeLinear;
((__text_var(texRef_f10C,texRef_f10C).__b_16textureReference).filterMode) = cudaFilterModeLinear;
((__text_var(texRef_f11C,texRef_f11C).__b_16textureReference).filterMode) = cudaFilterModeLinear;
((__text_var(texRef_f12C,texRef_f12C).__b_16textureReference).filterMode) = cudaFilterModeLinear;
((__text_var(texRef_f13C,texRef_f13C).__b_16textureReference).filterMode) = cudaFilterModeLinear;
((__text_var(texRef_f14C,texRef_f14C).__b_16textureReference).filterMode) = cudaFilterModeLinear;
((__text_var(texRef_f15C,texRef_f15C).__b_16textureReference).filterMode) = cudaFilterModeLinear;
((__text_var(texRef_f16C,texRef_f16C).__b_16textureReference).filterMode) = cudaFilterModeLinear;
((__text_var(texRef_f17C,texRef_f17C).__b_16textureReference).filterMode) = cudaFilterModeLinear;
((__text_var(texRef_f18C,texRef_f18C).__b_16textureReference).filterMode) = cudaFilterModeLinear;
((__text_var(texRef_f0D,texRef_f0D).__b_16textureReference).normalized) = 0;
((__text_var(texRef_f1D,texRef_f1D).__b_16textureReference).normalized) = 0;
((__text_var(texRef_f2D,texRef_f2D).__b_16textureReference).normalized) = 0;
((__text_var(texRef_f3D,texRef_f3D).__b_16textureReference).normalized) = 0;
((__text_var(texRef_f4D,texRef_f4D).__b_16textureReference).normalized) = 0;
((__text_var(texRef_f5D,texRef_f5D).__b_16textureReference).normalized) = 0;
((__text_var(texRef_f6D,texRef_f6D).__b_16textureReference).normalized) = 0;
((__text_var(texRef_f7D,texRef_f7D).__b_16textureReference).normalized) = 0;
((__text_var(texRef_f8D,texRef_f8D).__b_16textureReference).normalized) = 0;
((__text_var(texRef_f9D,texRef_f9D).__b_16textureReference).normalized) = 0;
((__text_var(texRef_f10D,texRef_f10D).__b_16textureReference).normalized) = 0;
((__text_var(texRef_f11D,texRef_f11D).__b_16textureReference).normalized) = 0;
((__text_var(texRef_f12D,texRef_f12D).__b_16textureReference).normalized) = 0;
((__text_var(texRef_f13D,texRef_f13D).__b_16textureReference).normalized) = 0;
((__text_var(texRef_f14D,texRef_f14D).__b_16textureReference).normalized) = 0;
((__text_var(texRef_f15D,texRef_f15D).__b_16textureReference).normalized) = 0;
((__text_var(texRef_f16D,texRef_f16D).__b_16textureReference).normalized) = 0;
((__text_var(texRef_f17D,texRef_f17D).__b_16textureReference).normalized) = 0;
((__text_var(texRef_f18D,texRef_f18D).__b_16textureReference).normalized) = 0;
((__text_var(texRef_f0D,texRef_f0D).__b_16textureReference).filterMode) = cudaFilterModeLinear;
((__text_var(texRef_f1D,texRef_f1D).__b_16textureReference).filterMode) = cudaFilterModeLinear;
((__text_var(texRef_f2D,texRef_f2D).__b_16textureReference).filterMode) = cudaFilterModeLinear;
((__text_var(texRef_f3D,texRef_f3D).__b_16textureReference).filterMode) = cudaFilterModeLinear;
((__text_var(texRef_f4D,texRef_f4D).__b_16textureReference).filterMode) = cudaFilterModeLinear;
((__text_var(texRef_f5D,texRef_f5D).__b_16textureReference).filterMode) = cudaFilterModeLinear;
((__text_var(texRef_f6D,texRef_f6D).__b_16textureReference).filterMode) = cudaFilterModeLinear;
((__text_var(texRef_f7D,texRef_f7D).__b_16textureReference).filterMode) = cudaFilterModeLinear;
((__text_var(texRef_f8D,texRef_f8D).__b_16textureReference).filterMode) = cudaFilterModeLinear;
((__text_var(texRef_f9D,texRef_f9D).__b_16textureReference).filterMode) = cudaFilterModeLinear;
((__text_var(texRef_f10D,texRef_f10D).__b_16textureReference).filterMode) = cudaFilterModeLinear;
((__text_var(texRef_f11D,texRef_f11D).__b_16textureReference).filterMode) = cudaFilterModeLinear;
((__text_var(texRef_f12D,texRef_f12D).__b_16textureReference).filterMode) = cudaFilterModeLinear;
((__text_var(texRef_f13D,texRef_f13D).__b_16textureReference).filterMode) = cudaFilterModeLinear;
((__text_var(texRef_f14D,texRef_f14D).__b_16textureReference).filterMode) = cudaFilterModeLinear;
((__text_var(texRef_f15D,texRef_f15D).__b_16textureReference).filterMode) = cudaFilterModeLinear;
((__text_var(texRef_f16D,texRef_f16D).__b_16textureReference).filterMode) = cudaFilterModeLinear;
((__text_var(texRef_f17D,texRef_f17D).__b_16textureReference).filterMode) = cudaFilterModeLinear;
((__text_var(texRef_f18D,texRef_f18D).__b_16textureReference).filterMode) = cudaFilterModeLinear; {


 int i;
# 5187 "MRT.cu"
i = 0; for (; (i < 2); i++) {
((((__text_var(texRef_f0A,texRef_f0A).__b_16textureReference).addressMode))[i]) = cudaAddressModeClamp;
((((__text_var(texRef_f1A,texRef_f1A).__b_16textureReference).addressMode))[i]) = cudaAddressModeClamp;
((((__text_var(texRef_f2A,texRef_f2A).__b_16textureReference).addressMode))[i]) = cudaAddressModeClamp;
((((__text_var(texRef_f3A,texRef_f3A).__b_16textureReference).addressMode))[i]) = cudaAddressModeClamp;
((((__text_var(texRef_f4A,texRef_f4A).__b_16textureReference).addressMode))[i]) = cudaAddressModeClamp;
((((__text_var(texRef_f5A,texRef_f5A).__b_16textureReference).addressMode))[i]) = cudaAddressModeClamp;
((((__text_var(texRef_f6A,texRef_f6A).__b_16textureReference).addressMode))[i]) = cudaAddressModeClamp;
((((__text_var(texRef_f7A,texRef_f7A).__b_16textureReference).addressMode))[i]) = cudaAddressModeClamp;
((((__text_var(texRef_f8A,texRef_f8A).__b_16textureReference).addressMode))[i]) = cudaAddressModeClamp;
((((__text_var(texRef_f9A,texRef_f9A).__b_16textureReference).addressMode))[i]) = cudaAddressModeClamp;
((((__text_var(texRef_f10A,texRef_f10A).__b_16textureReference).addressMode))[i]) = cudaAddressModeClamp;
((((__text_var(texRef_f11A,texRef_f11A).__b_16textureReference).addressMode))[i]) = cudaAddressModeClamp;
((((__text_var(texRef_f12A,texRef_f12A).__b_16textureReference).addressMode))[i]) = cudaAddressModeClamp;
((((__text_var(texRef_f13A,texRef_f13A).__b_16textureReference).addressMode))[i]) = cudaAddressModeClamp;
((((__text_var(texRef_f14A,texRef_f14A).__b_16textureReference).addressMode))[i]) = cudaAddressModeClamp;
((((__text_var(texRef_f15A,texRef_f15A).__b_16textureReference).addressMode))[i]) = cudaAddressModeClamp;
((((__text_var(texRef_f16A,texRef_f16A).__b_16textureReference).addressMode))[i]) = cudaAddressModeClamp;
((((__text_var(texRef_f17A,texRef_f17A).__b_16textureReference).addressMode))[i]) = cudaAddressModeClamp;
((((__text_var(texRef_f18A,texRef_f18A).__b_16textureReference).addressMode))[i]) = cudaAddressModeClamp;
((((__text_var(texRef_f0B,texRef_f0B).__b_16textureReference).addressMode))[i]) = cudaAddressModeClamp;
((((__text_var(texRef_f1B,texRef_f1B).__b_16textureReference).addressMode))[i]) = cudaAddressModeClamp;
((((__text_var(texRef_f2B,texRef_f2B).__b_16textureReference).addressMode))[i]) = cudaAddressModeClamp;
((((__text_var(texRef_f3B,texRef_f3B).__b_16textureReference).addressMode))[i]) = cudaAddressModeClamp;
((((__text_var(texRef_f4B,texRef_f4B).__b_16textureReference).addressMode))[i]) = cudaAddressModeClamp;
((((__text_var(texRef_f5B,texRef_f5B).__b_16textureReference).addressMode))[i]) = cudaAddressModeClamp;
((((__text_var(texRef_f6B,texRef_f6B).__b_16textureReference).addressMode))[i]) = cudaAddressModeClamp;
((((__text_var(texRef_f7B,texRef_f7B).__b_16textureReference).addressMode))[i]) = cudaAddressModeClamp;
((((__text_var(texRef_f8B,texRef_f8B).__b_16textureReference).addressMode))[i]) = cudaAddressModeClamp;
((((__text_var(texRef_f9B,texRef_f9B).__b_16textureReference).addressMode))[i]) = cudaAddressModeClamp;
((((__text_var(texRef_f10B,texRef_f10B).__b_16textureReference).addressMode))[i]) = cudaAddressModeClamp;
((((__text_var(texRef_f11B,texRef_f11B).__b_16textureReference).addressMode))[i]) = cudaAddressModeClamp;
((((__text_var(texRef_f12B,texRef_f12B).__b_16textureReference).addressMode))[i]) = cudaAddressModeClamp;
((((__text_var(texRef_f13B,texRef_f13B).__b_16textureReference).addressMode))[i]) = cudaAddressModeClamp;
((((__text_var(texRef_f14B,texRef_f14B).__b_16textureReference).addressMode))[i]) = cudaAddressModeClamp;
((((__text_var(texRef_f15B,texRef_f15B).__b_16textureReference).addressMode))[i]) = cudaAddressModeClamp;
((((__text_var(texRef_f16B,texRef_f16B).__b_16textureReference).addressMode))[i]) = cudaAddressModeClamp;
((((__text_var(texRef_f17B,texRef_f17B).__b_16textureReference).addressMode))[i]) = cudaAddressModeClamp;
((((__text_var(texRef_f18B,texRef_f18B).__b_16textureReference).addressMode))[i]) = cudaAddressModeClamp;
} }

}

cudaMemcpy2D(((void *)__cuda_local_var_39437_15_non_const_fA_d), __cuda_local_var_39384_9_non_const_pitch, ((const void *)__cuda_local_var_39437_9_non_const_fA_h), 256UL, 256UL, 77824UL, cudaMemcpyHostToDevice);
cudaMemcpy2D(((void *)__cuda_local_var_39437_21_non_const_fB_d), __cuda_local_var_39384_9_non_const_pitch, ((const void *)__cuda_local_var_39437_9_non_const_fA_h), 256UL, 256UL, 77824UL, cudaMemcpyHostToDevice);
if (((const char *)"NO") == ((const char *)"YES")) {
cudaMemcpy2D(((void *)__cuda_local_var_39437_33_non_const_fC_d), __cuda_local_var_39385_9_non_const_pitch2, ((const void *)__cuda_local_var_39437_27_non_const_fC_h), 256UL, 256UL, 77824UL, cudaMemcpyHostToDevice);
cudaMemcpy2D(((void *)__cuda_local_var_39437_39_non_const_fD_d), __cuda_local_var_39385_9_non_const_pitch2, ((const void *)__cuda_local_var_39437_27_non_const_fC_h), 256UL, 256UL, 77824UL, cudaMemcpyHostToDevice);
}
# 5243 "MRT.cu"
if (1)
{
cudaBindTexture2D(((size_t *)0LL), ((const struct textureReference *)(&__text_var(texRef_f0A,texRef_f0A).__b_16textureReference)), ((const void *)__cuda_local_var_39437_15_non_const_fA_d), ((const struct cudaChannelFormatDesc *)(&__cuda_local_var_39461_24_non_const_desc)), 64UL, 4096UL, __cuda_local_var_39384_9_non_const_pitch);
cudaBindTexture2D(((size_t *)0LL), ((const struct textureReference *)(&__text_var(texRef_f1A,texRef_f1A).__b_16textureReference)), ((const void *)(__cuda_local_var_39437_15_non_const_fA_d + ((__cuda_local_var_39458_9_non_const_pitch_elements * 64UL) * 64UL))), ((const struct cudaChannelFormatDesc *)(&__cuda_local_var_39461_24_non_const_desc)), 64UL, 4096UL, __cuda_local_var_39384_9_non_const_pitch);
cudaBindTexture2D(((size_t *)0LL), ((const struct textureReference *)(&__text_var(texRef_f2A,texRef_f2A).__b_16textureReference)), ((const void *)(__cuda_local_var_39437_15_non_const_fA_d + (((__cuda_local_var_39458_9_non_const_pitch_elements * 64UL) * 64UL) * 2UL))), ((const struct cudaChannelFormatDesc *)(&__cuda_local_var_39461_24_non_const_desc)), 64UL, 4096UL, __cuda_local_var_39384_9_non_const_pitch);
cudaBindTexture2D(((size_t *)0LL), ((const struct textureReference *)(&__text_var(texRef_f3A,texRef_f3A).__b_16textureReference)), ((const void *)(__cuda_local_var_39437_15_non_const_fA_d + (((__cuda_local_var_39458_9_non_const_pitch_elements * 64UL) * 64UL) * 3UL))), ((const struct cudaChannelFormatDesc *)(&__cuda_local_var_39461_24_non_const_desc)), 64UL, 4096UL, __cuda_local_var_39384_9_non_const_pitch);
cudaBindTexture2D(((size_t *)0LL), ((const struct textureReference *)(&__text_var(texRef_f4A,texRef_f4A).__b_16textureReference)), ((const void *)(__cuda_local_var_39437_15_non_const_fA_d + (((__cuda_local_var_39458_9_non_const_pitch_elements * 64UL) * 64UL) * 4UL))), ((const struct cudaChannelFormatDesc *)(&__cuda_local_var_39461_24_non_const_desc)), 64UL, 4096UL, __cuda_local_var_39384_9_non_const_pitch);
cudaBindTexture2D(((size_t *)0LL), ((const struct textureReference *)(&__text_var(texRef_f5A,texRef_f5A).__b_16textureReference)), ((const void *)(__cuda_local_var_39437_15_non_const_fA_d + (((__cuda_local_var_39458_9_non_const_pitch_elements * 64UL) * 64UL) * 5UL))), ((const struct cudaChannelFormatDesc *)(&__cuda_local_var_39461_24_non_const_desc)), 64UL, 4096UL, __cuda_local_var_39384_9_non_const_pitch);
cudaBindTexture2D(((size_t *)0LL), ((const struct textureReference *)(&__text_var(texRef_f6A,texRef_f6A).__b_16textureReference)), ((const void *)(__cuda_local_var_39437_15_non_const_fA_d + (((__cuda_local_var_39458_9_non_const_pitch_elements * 64UL) * 64UL) * 6UL))), ((const struct cudaChannelFormatDesc *)(&__cuda_local_var_39461_24_non_const_desc)), 64UL, 4096UL, __cuda_local_var_39384_9_non_const_pitch);
cudaBindTexture2D(((size_t *)0LL), ((const struct textureReference *)(&__text_var(texRef_f7A,texRef_f7A).__b_16textureReference)), ((const void *)(__cuda_local_var_39437_15_non_const_fA_d + (((__cuda_local_var_39458_9_non_const_pitch_elements * 64UL) * 64UL) * 7UL))), ((const struct cudaChannelFormatDesc *)(&__cuda_local_var_39461_24_non_const_desc)), 64UL, 4096UL, __cuda_local_var_39384_9_non_const_pitch);
cudaBindTexture2D(((size_t *)0LL), ((const struct textureReference *)(&__text_var(texRef_f8A,texRef_f8A).__b_16textureReference)), ((const void *)(__cuda_local_var_39437_15_non_const_fA_d + (((__cuda_local_var_39458_9_non_const_pitch_elements * 64UL) * 64UL) * 8UL))), ((const struct cudaChannelFormatDesc *)(&__cuda_local_var_39461_24_non_const_desc)), 64UL, 4096UL, __cuda_local_var_39384_9_non_const_pitch);
cudaBindTexture2D(((size_t *)0LL), ((const struct textureReference *)(&__text_var(texRef_f9A,texRef_f9A).__b_16textureReference)), ((const void *)(__cuda_local_var_39437_15_non_const_fA_d + (((__cuda_local_var_39458_9_non_const_pitch_elements * 64UL) * 64UL) * 9UL))), ((const struct cudaChannelFormatDesc *)(&__cuda_local_var_39461_24_non_const_desc)), 64UL, 4096UL, __cuda_local_var_39384_9_non_const_pitch);
cudaBindTexture2D(((size_t *)0LL), ((const struct textureReference *)(&__text_var(texRef_f10A,texRef_f10A).__b_16textureReference)), ((const void *)(__cuda_local_var_39437_15_non_const_fA_d + (((__cuda_local_var_39458_9_non_const_pitch_elements * 64UL) * 64UL) * 10UL))), ((const struct cudaChannelFormatDesc *)(&__cuda_local_var_39461_24_non_const_desc)), 64UL, 4096UL, __cuda_local_var_39384_9_non_const_pitch);
cudaBindTexture2D(((size_t *)0LL), ((const struct textureReference *)(&__text_var(texRef_f11A,texRef_f11A).__b_16textureReference)), ((const void *)(__cuda_local_var_39437_15_non_const_fA_d + (((__cuda_local_var_39458_9_non_const_pitch_elements * 64UL) * 64UL) * 11UL))), ((const struct cudaChannelFormatDesc *)(&__cuda_local_var_39461_24_non_const_desc)), 64UL, 4096UL, __cuda_local_var_39384_9_non_const_pitch);
cudaBindTexture2D(((size_t *)0LL), ((const struct textureReference *)(&__text_var(texRef_f12A,texRef_f12A).__b_16textureReference)), ((const void *)(__cuda_local_var_39437_15_non_const_fA_d + (((__cuda_local_var_39458_9_non_const_pitch_elements * 64UL) * 64UL) * 12UL))), ((const struct cudaChannelFormatDesc *)(&__cuda_local_var_39461_24_non_const_desc)), 64UL, 4096UL, __cuda_local_var_39384_9_non_const_pitch);
cudaBindTexture2D(((size_t *)0LL), ((const struct textureReference *)(&__text_var(texRef_f13A,texRef_f13A).__b_16textureReference)), ((const void *)(__cuda_local_var_39437_15_non_const_fA_d + (((__cuda_local_var_39458_9_non_const_pitch_elements * 64UL) * 64UL) * 13UL))), ((const struct cudaChannelFormatDesc *)(&__cuda_local_var_39461_24_non_const_desc)), 64UL, 4096UL, __cuda_local_var_39384_9_non_const_pitch);
cudaBindTexture2D(((size_t *)0LL), ((const struct textureReference *)(&__text_var(texRef_f14A,texRef_f14A).__b_16textureReference)), ((const void *)(__cuda_local_var_39437_15_non_const_fA_d + (((__cuda_local_var_39458_9_non_const_pitch_elements * 64UL) * 64UL) * 14UL))), ((const struct cudaChannelFormatDesc *)(&__cuda_local_var_39461_24_non_const_desc)), 64UL, 4096UL, __cuda_local_var_39384_9_non_const_pitch);
cudaBindTexture2D(((size_t *)0LL), ((const struct textureReference *)(&__text_var(texRef_f15A,texRef_f15A).__b_16textureReference)), ((const void *)(__cuda_local_var_39437_15_non_const_fA_d + (((__cuda_local_var_39458_9_non_const_pitch_elements * 64UL) * 64UL) * 15UL))), ((const struct cudaChannelFormatDesc *)(&__cuda_local_var_39461_24_non_const_desc)), 64UL, 4096UL, __cuda_local_var_39384_9_non_const_pitch);
cudaBindTexture2D(((size_t *)0LL), ((const struct textureReference *)(&__text_var(texRef_f16A,texRef_f16A).__b_16textureReference)), ((const void *)(__cuda_local_var_39437_15_non_const_fA_d + (((__cuda_local_var_39458_9_non_const_pitch_elements * 64UL) * 64UL) * 16UL))), ((const struct cudaChannelFormatDesc *)(&__cuda_local_var_39461_24_non_const_desc)), 64UL, 4096UL, __cuda_local_var_39384_9_non_const_pitch);
cudaBindTexture2D(((size_t *)0LL), ((const struct textureReference *)(&__text_var(texRef_f17A,texRef_f17A).__b_16textureReference)), ((const void *)(__cuda_local_var_39437_15_non_const_fA_d + (((__cuda_local_var_39458_9_non_const_pitch_elements * 64UL) * 64UL) * 17UL))), ((const struct cudaChannelFormatDesc *)(&__cuda_local_var_39461_24_non_const_desc)), 64UL, 4096UL, __cuda_local_var_39384_9_non_const_pitch);
cudaBindTexture2D(((size_t *)0LL), ((const struct textureReference *)(&__text_var(texRef_f18A,texRef_f18A).__b_16textureReference)), ((const void *)(__cuda_local_var_39437_15_non_const_fA_d + (((__cuda_local_var_39458_9_non_const_pitch_elements * 64UL) * 64UL) * 18UL))), ((const struct cudaChannelFormatDesc *)(&__cuda_local_var_39461_24_non_const_desc)), 64UL, 4096UL, __cuda_local_var_39384_9_non_const_pitch);
cudaBindTexture2D(((size_t *)0LL), ((const struct textureReference *)(&__text_var(texRef_f0B,texRef_f0B).__b_16textureReference)), ((const void *)__cuda_local_var_39437_21_non_const_fB_d), ((const struct cudaChannelFormatDesc *)(&__cuda_local_var_39461_24_non_const_desc)), 64UL, 4096UL, __cuda_local_var_39384_9_non_const_pitch);
cudaBindTexture2D(((size_t *)0LL), ((const struct textureReference *)(&__text_var(texRef_f1B,texRef_f1B).__b_16textureReference)), ((const void *)(__cuda_local_var_39437_21_non_const_fB_d + ((__cuda_local_var_39458_9_non_const_pitch_elements * 64UL) * 64UL))), ((const struct cudaChannelFormatDesc *)(&__cuda_local_var_39461_24_non_const_desc)), 64UL, 4096UL, __cuda_local_var_39384_9_non_const_pitch);
cudaBindTexture2D(((size_t *)0LL), ((const struct textureReference *)(&__text_var(texRef_f2B,texRef_f2B).__b_16textureReference)), ((const void *)(__cuda_local_var_39437_21_non_const_fB_d + (((__cuda_local_var_39458_9_non_const_pitch_elements * 64UL) * 64UL) * 2UL))), ((const struct cudaChannelFormatDesc *)(&__cuda_local_var_39461_24_non_const_desc)), 64UL, 4096UL, __cuda_local_var_39384_9_non_const_pitch);
cudaBindTexture2D(((size_t *)0LL), ((const struct textureReference *)(&__text_var(texRef_f3B,texRef_f3B).__b_16textureReference)), ((const void *)(__cuda_local_var_39437_21_non_const_fB_d + (((__cuda_local_var_39458_9_non_const_pitch_elements * 64UL) * 64UL) * 3UL))), ((const struct cudaChannelFormatDesc *)(&__cuda_local_var_39461_24_non_const_desc)), 64UL, 4096UL, __cuda_local_var_39384_9_non_const_pitch);
cudaBindTexture2D(((size_t *)0LL), ((const struct textureReference *)(&__text_var(texRef_f4B,texRef_f4B).__b_16textureReference)), ((const void *)(__cuda_local_var_39437_21_non_const_fB_d + (((__cuda_local_var_39458_9_non_const_pitch_elements * 64UL) * 64UL) * 4UL))), ((const struct cudaChannelFormatDesc *)(&__cuda_local_var_39461_24_non_const_desc)), 64UL, 4096UL, __cuda_local_var_39384_9_non_const_pitch);
cudaBindTexture2D(((size_t *)0LL), ((const struct textureReference *)(&__text_var(texRef_f5B,texRef_f5B).__b_16textureReference)), ((const void *)(__cuda_local_var_39437_21_non_const_fB_d + (((__cuda_local_var_39458_9_non_const_pitch_elements * 64UL) * 64UL) * 5UL))), ((const struct cudaChannelFormatDesc *)(&__cuda_local_var_39461_24_non_const_desc)), 64UL, 4096UL, __cuda_local_var_39384_9_non_const_pitch);
cudaBindTexture2D(((size_t *)0LL), ((const struct textureReference *)(&__text_var(texRef_f6B,texRef_f6B).__b_16textureReference)), ((const void *)(__cuda_local_var_39437_21_non_const_fB_d + (((__cuda_local_var_39458_9_non_const_pitch_elements * 64UL) * 64UL) * 6UL))), ((const struct cudaChannelFormatDesc *)(&__cuda_local_var_39461_24_non_const_desc)), 64UL, 4096UL, __cuda_local_var_39384_9_non_const_pitch);
cudaBindTexture2D(((size_t *)0LL), ((const struct textureReference *)(&__text_var(texRef_f7B,texRef_f7B).__b_16textureReference)), ((const void *)(__cuda_local_var_39437_21_non_const_fB_d + (((__cuda_local_var_39458_9_non_const_pitch_elements * 64UL) * 64UL) * 7UL))), ((const struct cudaChannelFormatDesc *)(&__cuda_local_var_39461_24_non_const_desc)), 64UL, 4096UL, __cuda_local_var_39384_9_non_const_pitch);
cudaBindTexture2D(((size_t *)0LL), ((const struct textureReference *)(&__text_var(texRef_f8B,texRef_f8B).__b_16textureReference)), ((const void *)(__cuda_local_var_39437_21_non_const_fB_d + (((__cuda_local_var_39458_9_non_const_pitch_elements * 64UL) * 64UL) * 8UL))), ((const struct cudaChannelFormatDesc *)(&__cuda_local_var_39461_24_non_const_desc)), 64UL, 4096UL, __cuda_local_var_39384_9_non_const_pitch);
cudaBindTexture2D(((size_t *)0LL), ((const struct textureReference *)(&__text_var(texRef_f9B,texRef_f9B).__b_16textureReference)), ((const void *)(__cuda_local_var_39437_21_non_const_fB_d + (((__cuda_local_var_39458_9_non_const_pitch_elements * 64UL) * 64UL) * 9UL))), ((const struct cudaChannelFormatDesc *)(&__cuda_local_var_39461_24_non_const_desc)), 64UL, 4096UL, __cuda_local_var_39384_9_non_const_pitch);
cudaBindTexture2D(((size_t *)0LL), ((const struct textureReference *)(&__text_var(texRef_f10B,texRef_f10B).__b_16textureReference)), ((const void *)(__cuda_local_var_39437_21_non_const_fB_d + (((__cuda_local_var_39458_9_non_const_pitch_elements * 64UL) * 64UL) * 10UL))), ((const struct cudaChannelFormatDesc *)(&__cuda_local_var_39461_24_non_const_desc)), 64UL, 4096UL, __cuda_local_var_39384_9_non_const_pitch);
cudaBindTexture2D(((size_t *)0LL), ((const struct textureReference *)(&__text_var(texRef_f11B,texRef_f11B).__b_16textureReference)), ((const void *)(__cuda_local_var_39437_21_non_const_fB_d + (((__cuda_local_var_39458_9_non_const_pitch_elements * 64UL) * 64UL) * 11UL))), ((const struct cudaChannelFormatDesc *)(&__cuda_local_var_39461_24_non_const_desc)), 64UL, 4096UL, __cuda_local_var_39384_9_non_const_pitch);
cudaBindTexture2D(((size_t *)0LL), ((const struct textureReference *)(&__text_var(texRef_f12B,texRef_f12B).__b_16textureReference)), ((const void *)(__cuda_local_var_39437_21_non_const_fB_d + (((__cuda_local_var_39458_9_non_const_pitch_elements * 64UL) * 64UL) * 12UL))), ((const struct cudaChannelFormatDesc *)(&__cuda_local_var_39461_24_non_const_desc)), 64UL, 4096UL, __cuda_local_var_39384_9_non_const_pitch);
cudaBindTexture2D(((size_t *)0LL), ((const struct textureReference *)(&__text_var(texRef_f13B,texRef_f13B).__b_16textureReference)), ((const void *)(__cuda_local_var_39437_21_non_const_fB_d + (((__cuda_local_var_39458_9_non_const_pitch_elements * 64UL) * 64UL) * 13UL))), ((const struct cudaChannelFormatDesc *)(&__cuda_local_var_39461_24_non_const_desc)), 64UL, 4096UL, __cuda_local_var_39384_9_non_const_pitch);
cudaBindTexture2D(((size_t *)0LL), ((const struct textureReference *)(&__text_var(texRef_f14B,texRef_f14B).__b_16textureReference)), ((const void *)(__cuda_local_var_39437_21_non_const_fB_d + (((__cuda_local_var_39458_9_non_const_pitch_elements * 64UL) * 64UL) * 14UL))), ((const struct cudaChannelFormatDesc *)(&__cuda_local_var_39461_24_non_const_desc)), 64UL, 4096UL, __cuda_local_var_39384_9_non_const_pitch);
cudaBindTexture2D(((size_t *)0LL), ((const struct textureReference *)(&__text_var(texRef_f15B,texRef_f15B).__b_16textureReference)), ((const void *)(__cuda_local_var_39437_21_non_const_fB_d + (((__cuda_local_var_39458_9_non_const_pitch_elements * 64UL) * 64UL) * 15UL))), ((const struct cudaChannelFormatDesc *)(&__cuda_local_var_39461_24_non_const_desc)), 64UL, 4096UL, __cuda_local_var_39384_9_non_const_pitch);
cudaBindTexture2D(((size_t *)0LL), ((const struct textureReference *)(&__text_var(texRef_f16B,texRef_f16B).__b_16textureReference)), ((const void *)(__cuda_local_var_39437_21_non_const_fB_d + (((__cuda_local_var_39458_9_non_const_pitch_elements * 64UL) * 64UL) * 16UL))), ((const struct cudaChannelFormatDesc *)(&__cuda_local_var_39461_24_non_const_desc)), 64UL, 4096UL, __cuda_local_var_39384_9_non_const_pitch);
cudaBindTexture2D(((size_t *)0LL), ((const struct textureReference *)(&__text_var(texRef_f17B,texRef_f17B).__b_16textureReference)), ((const void *)(__cuda_local_var_39437_21_non_const_fB_d + (((__cuda_local_var_39458_9_non_const_pitch_elements * 64UL) * 64UL) * 17UL))), ((const struct cudaChannelFormatDesc *)(&__cuda_local_var_39461_24_non_const_desc)), 64UL, 4096UL, __cuda_local_var_39384_9_non_const_pitch);
cudaBindTexture2D(((size_t *)0LL), ((const struct textureReference *)(&__text_var(texRef_f18B,texRef_f18B).__b_16textureReference)), ((const void *)(__cuda_local_var_39437_21_non_const_fB_d + (((__cuda_local_var_39458_9_non_const_pitch_elements * 64UL) * 64UL) * 18UL))), ((const struct cudaChannelFormatDesc *)(&__cuda_local_var_39461_24_non_const_desc)), 64UL, 4096UL, __cuda_local_var_39384_9_non_const_pitch);


cudaBindTexture2D(((size_t *)0LL), ((const struct textureReference *)(&__text_var(texRef_f0C,texRef_f0C).__b_16textureReference)), ((const void *)__cuda_local_var_39437_33_non_const_fC_d), ((const struct cudaChannelFormatDesc *)(&__cuda_local_var_39461_24_non_const_desc)), 64UL, 4096UL, __cuda_local_var_39385_9_non_const_pitch2);
cudaBindTexture2D(((size_t *)0LL), ((const struct textureReference *)(&__text_var(texRef_f1C,texRef_f1C).__b_16textureReference)), ((const void *)(__cuda_local_var_39437_33_non_const_fC_d + ((__cuda_local_var_39459_9_non_const_pitch_elements2 * 64UL) * 64UL))), ((const struct cudaChannelFormatDesc *)(&__cuda_local_var_39461_24_non_const_desc)), 64UL, 4096UL, __cuda_local_var_39385_9_non_const_pitch2);
cudaBindTexture2D(((size_t *)0LL), ((const struct textureReference *)(&__text_var(texRef_f2C,texRef_f2C).__b_16textureReference)), ((const void *)(__cuda_local_var_39437_33_non_const_fC_d + (((__cuda_local_var_39459_9_non_const_pitch_elements2 * 64UL) * 64UL) * 2UL))), ((const struct cudaChannelFormatDesc *)(&__cuda_local_var_39461_24_non_const_desc)), 64UL, 4096UL, __cuda_local_var_39385_9_non_const_pitch2);
cudaBindTexture2D(((size_t *)0LL), ((const struct textureReference *)(&__text_var(texRef_f3C,texRef_f3C).__b_16textureReference)), ((const void *)(__cuda_local_var_39437_33_non_const_fC_d + (((__cuda_local_var_39459_9_non_const_pitch_elements2 * 64UL) * 64UL) * 3UL))), ((const struct cudaChannelFormatDesc *)(&__cuda_local_var_39461_24_non_const_desc)), 64UL, 4096UL, __cuda_local_var_39385_9_non_const_pitch2);
cudaBindTexture2D(((size_t *)0LL), ((const struct textureReference *)(&__text_var(texRef_f4C,texRef_f4C).__b_16textureReference)), ((const void *)(__cuda_local_var_39437_33_non_const_fC_d + (((__cuda_local_var_39459_9_non_const_pitch_elements2 * 64UL) * 64UL) * 4UL))), ((const struct cudaChannelFormatDesc *)(&__cuda_local_var_39461_24_non_const_desc)), 64UL, 4096UL, __cuda_local_var_39385_9_non_const_pitch2);
cudaBindTexture2D(((size_t *)0LL), ((const struct textureReference *)(&__text_var(texRef_f5C,texRef_f5C).__b_16textureReference)), ((const void *)(__cuda_local_var_39437_33_non_const_fC_d + (((__cuda_local_var_39459_9_non_const_pitch_elements2 * 64UL) * 64UL) * 5UL))), ((const struct cudaChannelFormatDesc *)(&__cuda_local_var_39461_24_non_const_desc)), 64UL, 4096UL, __cuda_local_var_39385_9_non_const_pitch2);
cudaBindTexture2D(((size_t *)0LL), ((const struct textureReference *)(&__text_var(texRef_f6C,texRef_f6C).__b_16textureReference)), ((const void *)(__cuda_local_var_39437_33_non_const_fC_d + (((__cuda_local_var_39459_9_non_const_pitch_elements2 * 64UL) * 64UL) * 6UL))), ((const struct cudaChannelFormatDesc *)(&__cuda_local_var_39461_24_non_const_desc)), 64UL, 4096UL, __cuda_local_var_39385_9_non_const_pitch2);
cudaBindTexture2D(((size_t *)0LL), ((const struct textureReference *)(&__text_var(texRef_f7C,texRef_f7C).__b_16textureReference)), ((const void *)(__cuda_local_var_39437_33_non_const_fC_d + (((__cuda_local_var_39459_9_non_const_pitch_elements2 * 64UL) * 64UL) * 7UL))), ((const struct cudaChannelFormatDesc *)(&__cuda_local_var_39461_24_non_const_desc)), 64UL, 4096UL, __cuda_local_var_39385_9_non_const_pitch2);
cudaBindTexture2D(((size_t *)0LL), ((const struct textureReference *)(&__text_var(texRef_f8C,texRef_f8C).__b_16textureReference)), ((const void *)(__cuda_local_var_39437_33_non_const_fC_d + (((__cuda_local_var_39459_9_non_const_pitch_elements2 * 64UL) * 64UL) * 8UL))), ((const struct cudaChannelFormatDesc *)(&__cuda_local_var_39461_24_non_const_desc)), 64UL, 4096UL, __cuda_local_var_39385_9_non_const_pitch2);
cudaBindTexture2D(((size_t *)0LL), ((const struct textureReference *)(&__text_var(texRef_f9C,texRef_f9C).__b_16textureReference)), ((const void *)(__cuda_local_var_39437_33_non_const_fC_d + (((__cuda_local_var_39459_9_non_const_pitch_elements2 * 64UL) * 64UL) * 9UL))), ((const struct cudaChannelFormatDesc *)(&__cuda_local_var_39461_24_non_const_desc)), 64UL, 4096UL, __cuda_local_var_39385_9_non_const_pitch2);
cudaBindTexture2D(((size_t *)0LL), ((const struct textureReference *)(&__text_var(texRef_f10C,texRef_f10C).__b_16textureReference)), ((const void *)(__cuda_local_var_39437_33_non_const_fC_d + (((__cuda_local_var_39459_9_non_const_pitch_elements2 * 64UL) * 64UL) * 10UL))), ((const struct cudaChannelFormatDesc *)(&__cuda_local_var_39461_24_non_const_desc)), 64UL, 4096UL, __cuda_local_var_39385_9_non_const_pitch2);
cudaBindTexture2D(((size_t *)0LL), ((const struct textureReference *)(&__text_var(texRef_f11C,texRef_f11C).__b_16textureReference)), ((const void *)(__cuda_local_var_39437_33_non_const_fC_d + (((__cuda_local_var_39459_9_non_const_pitch_elements2 * 64UL) * 64UL) * 11UL))), ((const struct cudaChannelFormatDesc *)(&__cuda_local_var_39461_24_non_const_desc)), 64UL, 4096UL, __cuda_local_var_39385_9_non_const_pitch2);
cudaBindTexture2D(((size_t *)0LL), ((const struct textureReference *)(&__text_var(texRef_f12C,texRef_f12C).__b_16textureReference)), ((const void *)(__cuda_local_var_39437_33_non_const_fC_d + (((__cuda_local_var_39459_9_non_const_pitch_elements2 * 64UL) * 64UL) * 12UL))), ((const struct cudaChannelFormatDesc *)(&__cuda_local_var_39461_24_non_const_desc)), 64UL, 4096UL, __cuda_local_var_39385_9_non_const_pitch2);
cudaBindTexture2D(((size_t *)0LL), ((const struct textureReference *)(&__text_var(texRef_f13C,texRef_f13C).__b_16textureReference)), ((const void *)(__cuda_local_var_39437_33_non_const_fC_d + (((__cuda_local_var_39459_9_non_const_pitch_elements2 * 64UL) * 64UL) * 13UL))), ((const struct cudaChannelFormatDesc *)(&__cuda_local_var_39461_24_non_const_desc)), 64UL, 4096UL, __cuda_local_var_39385_9_non_const_pitch2);
cudaBindTexture2D(((size_t *)0LL), ((const struct textureReference *)(&__text_var(texRef_f14C,texRef_f14C).__b_16textureReference)), ((const void *)(__cuda_local_var_39437_33_non_const_fC_d + (((__cuda_local_var_39459_9_non_const_pitch_elements2 * 64UL) * 64UL) * 14UL))), ((const struct cudaChannelFormatDesc *)(&__cuda_local_var_39461_24_non_const_desc)), 64UL, 4096UL, __cuda_local_var_39385_9_non_const_pitch2);
cudaBindTexture2D(((size_t *)0LL), ((const struct textureReference *)(&__text_var(texRef_f15C,texRef_f15C).__b_16textureReference)), ((const void *)(__cuda_local_var_39437_33_non_const_fC_d + (((__cuda_local_var_39459_9_non_const_pitch_elements2 * 64UL) * 64UL) * 15UL))), ((const struct cudaChannelFormatDesc *)(&__cuda_local_var_39461_24_non_const_desc)), 64UL, 4096UL, __cuda_local_var_39385_9_non_const_pitch2);
cudaBindTexture2D(((size_t *)0LL), ((const struct textureReference *)(&__text_var(texRef_f16C,texRef_f16C).__b_16textureReference)), ((const void *)(__cuda_local_var_39437_33_non_const_fC_d + (((__cuda_local_var_39459_9_non_const_pitch_elements2 * 64UL) * 64UL) * 16UL))), ((const struct cudaChannelFormatDesc *)(&__cuda_local_var_39461_24_non_const_desc)), 64UL, 4096UL, __cuda_local_var_39385_9_non_const_pitch2);
cudaBindTexture2D(((size_t *)0LL), ((const struct textureReference *)(&__text_var(texRef_f17C,texRef_f17C).__b_16textureReference)), ((const void *)(__cuda_local_var_39437_33_non_const_fC_d + (((__cuda_local_var_39459_9_non_const_pitch_elements2 * 64UL) * 64UL) * 17UL))), ((const struct cudaChannelFormatDesc *)(&__cuda_local_var_39461_24_non_const_desc)), 64UL, 4096UL, __cuda_local_var_39385_9_non_const_pitch2);
cudaBindTexture2D(((size_t *)0LL), ((const struct textureReference *)(&__text_var(texRef_f18C,texRef_f18C).__b_16textureReference)), ((const void *)(__cuda_local_var_39437_33_non_const_fC_d + (((__cuda_local_var_39459_9_non_const_pitch_elements2 * 64UL) * 64UL) * 18UL))), ((const struct cudaChannelFormatDesc *)(&__cuda_local_var_39461_24_non_const_desc)), 64UL, 4096UL, __cuda_local_var_39385_9_non_const_pitch2);
cudaBindTexture2D(((size_t *)0LL), ((const struct textureReference *)(&__text_var(texRef_f0D,texRef_f0D).__b_16textureReference)), ((const void *)__cuda_local_var_39437_39_non_const_fD_d), ((const struct cudaChannelFormatDesc *)(&__cuda_local_var_39461_24_non_const_desc)), 64UL, 4096UL, __cuda_local_var_39385_9_non_const_pitch2);
cudaBindTexture2D(((size_t *)0LL), ((const struct textureReference *)(&__text_var(texRef_f1D,texRef_f1D).__b_16textureReference)), ((const void *)(__cuda_local_var_39437_39_non_const_fD_d + ((__cuda_local_var_39459_9_non_const_pitch_elements2 * 64UL) * 64UL))), ((const struct cudaChannelFormatDesc *)(&__cuda_local_var_39461_24_non_const_desc)), 64UL, 4096UL, __cuda_local_var_39385_9_non_const_pitch2);
cudaBindTexture2D(((size_t *)0LL), ((const struct textureReference *)(&__text_var(texRef_f2D,texRef_f2D).__b_16textureReference)), ((const void *)(__cuda_local_var_39437_39_non_const_fD_d + (((__cuda_local_var_39459_9_non_const_pitch_elements2 * 64UL) * 64UL) * 2UL))), ((const struct cudaChannelFormatDesc *)(&__cuda_local_var_39461_24_non_const_desc)), 64UL, 4096UL, __cuda_local_var_39385_9_non_const_pitch2);
cudaBindTexture2D(((size_t *)0LL), ((const struct textureReference *)(&__text_var(texRef_f3D,texRef_f3D).__b_16textureReference)), ((const void *)(__cuda_local_var_39437_39_non_const_fD_d + (((__cuda_local_var_39459_9_non_const_pitch_elements2 * 64UL) * 64UL) * 3UL))), ((const struct cudaChannelFormatDesc *)(&__cuda_local_var_39461_24_non_const_desc)), 64UL, 4096UL, __cuda_local_var_39385_9_non_const_pitch2);
cudaBindTexture2D(((size_t *)0LL), ((const struct textureReference *)(&__text_var(texRef_f4D,texRef_f4D).__b_16textureReference)), ((const void *)(__cuda_local_var_39437_39_non_const_fD_d + (((__cuda_local_var_39459_9_non_const_pitch_elements2 * 64UL) * 64UL) * 4UL))), ((const struct cudaChannelFormatDesc *)(&__cuda_local_var_39461_24_non_const_desc)), 64UL, 4096UL, __cuda_local_var_39385_9_non_const_pitch2);
cudaBindTexture2D(((size_t *)0LL), ((const struct textureReference *)(&__text_var(texRef_f5D,texRef_f5D).__b_16textureReference)), ((const void *)(__cuda_local_var_39437_39_non_const_fD_d + (((__cuda_local_var_39459_9_non_const_pitch_elements2 * 64UL) * 64UL) * 5UL))), ((const struct cudaChannelFormatDesc *)(&__cuda_local_var_39461_24_non_const_desc)), 64UL, 4096UL, __cuda_local_var_39385_9_non_const_pitch2);
cudaBindTexture2D(((size_t *)0LL), ((const struct textureReference *)(&__text_var(texRef_f6D,texRef_f6D).__b_16textureReference)), ((const void *)(__cuda_local_var_39437_39_non_const_fD_d + (((__cuda_local_var_39459_9_non_const_pitch_elements2 * 64UL) * 64UL) * 6UL))), ((const struct cudaChannelFormatDesc *)(&__cuda_local_var_39461_24_non_const_desc)), 64UL, 4096UL, __cuda_local_var_39385_9_non_const_pitch2);
cudaBindTexture2D(((size_t *)0LL), ((const struct textureReference *)(&__text_var(texRef_f7D,texRef_f7D).__b_16textureReference)), ((const void *)(__cuda_local_var_39437_39_non_const_fD_d + (((__cuda_local_var_39459_9_non_const_pitch_elements2 * 64UL) * 64UL) * 7UL))), ((const struct cudaChannelFormatDesc *)(&__cuda_local_var_39461_24_non_const_desc)), 64UL, 4096UL, __cuda_local_var_39385_9_non_const_pitch2);
cudaBindTexture2D(((size_t *)0LL), ((const struct textureReference *)(&__text_var(texRef_f8D,texRef_f8D).__b_16textureReference)), ((const void *)(__cuda_local_var_39437_39_non_const_fD_d + (((__cuda_local_var_39459_9_non_const_pitch_elements2 * 64UL) * 64UL) * 8UL))), ((const struct cudaChannelFormatDesc *)(&__cuda_local_var_39461_24_non_const_desc)), 64UL, 4096UL, __cuda_local_var_39385_9_non_const_pitch2);
cudaBindTexture2D(((size_t *)0LL), ((const struct textureReference *)(&__text_var(texRef_f9D,texRef_f9D).__b_16textureReference)), ((const void *)(__cuda_local_var_39437_39_non_const_fD_d + (((__cuda_local_var_39459_9_non_const_pitch_elements2 * 64UL) * 64UL) * 9UL))), ((const struct cudaChannelFormatDesc *)(&__cuda_local_var_39461_24_non_const_desc)), 64UL, 4096UL, __cuda_local_var_39385_9_non_const_pitch2);
cudaBindTexture2D(((size_t *)0LL), ((const struct textureReference *)(&__text_var(texRef_f10D,texRef_f10D).__b_16textureReference)), ((const void *)(__cuda_local_var_39437_39_non_const_fD_d + (((__cuda_local_var_39459_9_non_const_pitch_elements2 * 64UL) * 64UL) * 10UL))), ((const struct cudaChannelFormatDesc *)(&__cuda_local_var_39461_24_non_const_desc)), 64UL, 4096UL, __cuda_local_var_39385_9_non_const_pitch2);
cudaBindTexture2D(((size_t *)0LL), ((const struct textureReference *)(&__text_var(texRef_f11D,texRef_f11D).__b_16textureReference)), ((const void *)(__cuda_local_var_39437_39_non_const_fD_d + (((__cuda_local_var_39459_9_non_const_pitch_elements2 * 64UL) * 64UL) * 11UL))), ((const struct cudaChannelFormatDesc *)(&__cuda_local_var_39461_24_non_const_desc)), 64UL, 4096UL, __cuda_local_var_39385_9_non_const_pitch2);
cudaBindTexture2D(((size_t *)0LL), ((const struct textureReference *)(&__text_var(texRef_f12D,texRef_f12D).__b_16textureReference)), ((const void *)(__cuda_local_var_39437_39_non_const_fD_d + (((__cuda_local_var_39459_9_non_const_pitch_elements2 * 64UL) * 64UL) * 12UL))), ((const struct cudaChannelFormatDesc *)(&__cuda_local_var_39461_24_non_const_desc)), 64UL, 4096UL, __cuda_local_var_39385_9_non_const_pitch2);
cudaBindTexture2D(((size_t *)0LL), ((const struct textureReference *)(&__text_var(texRef_f13D,texRef_f13D).__b_16textureReference)), ((const void *)(__cuda_local_var_39437_39_non_const_fD_d + (((__cuda_local_var_39459_9_non_const_pitch_elements2 * 64UL) * 64UL) * 13UL))), ((const struct cudaChannelFormatDesc *)(&__cuda_local_var_39461_24_non_const_desc)), 64UL, 4096UL, __cuda_local_var_39385_9_non_const_pitch2);
cudaBindTexture2D(((size_t *)0LL), ((const struct textureReference *)(&__text_var(texRef_f14D,texRef_f14D).__b_16textureReference)), ((const void *)(__cuda_local_var_39437_39_non_const_fD_d + (((__cuda_local_var_39459_9_non_const_pitch_elements2 * 64UL) * 64UL) * 14UL))), ((const struct cudaChannelFormatDesc *)(&__cuda_local_var_39461_24_non_const_desc)), 64UL, 4096UL, __cuda_local_var_39385_9_non_const_pitch2);
cudaBindTexture2D(((size_t *)0LL), ((const struct textureReference *)(&__text_var(texRef_f15D,texRef_f15D).__b_16textureReference)), ((const void *)(__cuda_local_var_39437_39_non_const_fD_d + (((__cuda_local_var_39459_9_non_const_pitch_elements2 * 64UL) * 64UL) * 15UL))), ((const struct cudaChannelFormatDesc *)(&__cuda_local_var_39461_24_non_const_desc)), 64UL, 4096UL, __cuda_local_var_39385_9_non_const_pitch2);
cudaBindTexture2D(((size_t *)0LL), ((const struct textureReference *)(&__text_var(texRef_f16D,texRef_f16D).__b_16textureReference)), ((const void *)(__cuda_local_var_39437_39_non_const_fD_d + (((__cuda_local_var_39459_9_non_const_pitch_elements2 * 64UL) * 64UL) * 16UL))), ((const struct cudaChannelFormatDesc *)(&__cuda_local_var_39461_24_non_const_desc)), 64UL, 4096UL, __cuda_local_var_39385_9_non_const_pitch2);
cudaBindTexture2D(((size_t *)0LL), ((const struct textureReference *)(&__text_var(texRef_f17D,texRef_f17D).__b_16textureReference)), ((const void *)(__cuda_local_var_39437_39_non_const_fD_d + (((__cuda_local_var_39459_9_non_const_pitch_elements2 * 64UL) * 64UL) * 17UL))), ((const struct cudaChannelFormatDesc *)(&__cuda_local_var_39461_24_non_const_desc)), 64UL, 4096UL, __cuda_local_var_39385_9_non_const_pitch2);
cudaBindTexture2D(((size_t *)0LL), ((const struct textureReference *)(&__text_var(texRef_f18D,texRef_f18D).__b_16textureReference)), ((const void *)(__cuda_local_var_39437_39_non_const_fD_d + (((__cuda_local_var_39459_9_non_const_pitch_elements2 * 64UL) * 64UL) * 18UL))), ((const struct cudaChannelFormatDesc *)(&__cuda_local_var_39461_24_non_const_desc)), 64UL, 4096UL, __cuda_local_var_39385_9_non_const_pitch2);

}


(cudaConfigureCall(__cuda_local_var_39424_10_non_const_grid, __cuda_local_var_39423_10_non_const_threads, 0UL, ((cudaStream_t)0LL))) ? ((void)0) : (__device_stub__Z17initialize_singlePfm(__cuda_local_var_39437_15_non_const_fA_d, __cuda_local_var_39458_9_non_const_pitch_elements));
(cudaConfigureCall(__cuda_local_var_39424_10_non_const_grid, __cuda_local_var_39423_10_non_const_threads, 0UL, ((cudaStream_t)0LL))) ? ((void)0) : (__device_stub__Z17initialize_singlePfm(__cuda_local_var_39437_21_non_const_fB_d, __cuda_local_var_39458_9_non_const_pitch_elements));
if (((const char *)"NO") == ((const char *)"YES")) {
(cudaConfigureCall(__cuda_local_var_39427_10_non_const_grid2, __cuda_local_var_39426_10_non_const_threads2, 0UL, ((cudaStream_t)0LL))) ? ((void)0) : (__device_stub__Z13initialize_LRPfm(__cuda_local_var_39437_33_non_const_fC_d, __cuda_local_var_39459_9_non_const_pitch_elements2));
}

_Z22cudaFuncSetCacheConfigIFvPfS0_fmEE9cudaErrorPT_13cudaFuncCache(__device_stub__Z12mrt_d_singlePfS_fm, cudaFuncCachePreferL1);
_Z22cudaFuncSetCacheConfigIFvPfS0_fmEE9cudaErrorPT_13cudaFuncCache(__device_stub__Z11mrt_d_hybABPfS_fm, cudaFuncCachePreferL1);
_Z22cudaFuncSetCacheConfigIFvPfS0_fmS0_S0_S0_iEE9cudaErrorPT_13cudaFuncCache(__device_stub__Z17mrt_d_hybAB_forcePfS_fmS_S_S_i, cudaFuncCachePreferL1);
_Z22cudaFuncSetCacheConfigIFvPfS0_fmS0_S0_S0_iEE9cudaErrorPT_13cudaFuncCache(__device_stub__Z18LR_d_hybABCD_forcePfS_fmS_S_S_i, cudaFuncCachePreferL1);
_Z22cudaFuncSetCacheConfigIFvPfS0_fmEE9cudaErrorPT_13cudaFuncCache(__device_stub__Z12LR_d_hybABCDPfS_fm, cudaFuncCachePreferL1);
_Z22cudaFuncSetCacheConfigIFvPfS0_fmiEE9cudaErrorPT_13cudaFuncCache(__device_stub__Z13LR_d_hybABCD2PfS_fmi, cudaFuncCachePreferL1);
_Z22cudaFuncSetCacheConfigIFvPfS0_fmfiEE9cudaErrorPT_13cudaFuncCache(__device_stub__Z13LR_d_hybABDC2PfS_fmfi, cudaFuncCachePreferL1);
_Z22cudaFuncSetCacheConfigIFvPfS0_fmfEE9cudaErrorPT_13cudaFuncCache(__device_stub__Z19LR_d_hybABDC_InterpPfS_fmf, cudaFuncCachePreferL1);

_Z22cudaFuncSetCacheConfigIFvPfS0_fmEE9cudaErrorPT_13cudaFuncCache(__device_stub__Z11mrt_d_hybBAPfS_fm, cudaFuncCachePreferL1);
_Z22cudaFuncSetCacheConfigIFvPfS0_fmS0_S0_S0_iEE9cudaErrorPT_13cudaFuncCache(__device_stub__Z17mrt_d_hybBA_forcePfS_fmS_S_S_i, cudaFuncCachePreferL1);


_Z22cudaFuncSetCacheConfigIFvPfS0_fmfiEE9cudaErrorPT_13cudaFuncCache(__device_stub__Z13LR_d_hybBADC2PfS_fmfi, cudaFuncCachePreferL1);
_Z22cudaFuncSetCacheConfigIFvPfS0_fmfEE9cudaErrorPT_13cudaFuncCache(__device_stub__Z19LR_d_hybBADC_InterpPfS_fmf, cudaFuncCachePreferL1);

_Z22cudaFuncSetCacheConfigIFvPfmfEE9cudaErrorPT_13cudaFuncCache(__device_stub__Z14ExtractFromC_dPfmf, cudaFuncCachePreferL1);

_Z22cudaFuncSetCacheConfigIFvPfS0_mEE9cudaErrorPT_13cudaFuncCache(__device_stub__Z11simple_copyPfS_m, cudaFuncCachePreferL1);




cudaDeviceSynchronize();
gettimeofday((&__cuda_local_var_39805_17_non_const_tdr0), ((struct timezone *)0LL)); {
 int t;
# 5358 "MRT.cu"
t = 0; for (; (t < 500); t = (t + 2)) {
if (1) {
(cudaConfigureCall(__cuda_local_var_39424_10_non_const_grid, __cuda_local_var_39423_10_non_const_threads, 0UL, ((cudaStream_t)0LL))) ? ((void)0) : (__device_stub__Z12mrt_d_singlePfS_fm(__cuda_local_var_39437_15_non_const_fA_d, __cuda_local_var_39437_21_non_const_fB_d, __cuda_local_var_39387_8_non_const_omega, __cuda_local_var_39458_9_non_const_pitch_elements));

if (((const char *)"NO") == ((const char *)"YES")) {
(cudaConfigureCall(__cuda_local_var_39427_10_non_const_grid2, __cuda_local_var_39426_10_non_const_threads2, 0UL, ((cudaStream_t)0LL))) ? ((void)0) : (__device_stub__Z9LR_d_ABCDPfS_fm(__cuda_local_var_39437_33_non_const_fC_d, __cuda_local_var_39437_39_non_const_fD_d, __cuda_local_var_39387_27_non_const_omega2, __cuda_local_var_39459_9_non_const_pitch_elements2));
(cudaConfigureCall(__cuda_local_var_39427_10_non_const_grid2, __cuda_local_var_39426_10_non_const_threads2, 0UL, ((cudaStream_t)0LL))) ? ((void)0) : (__device_stub__Z9LR_d_ABDCPfS_fmf(__cuda_local_var_39437_39_non_const_fD_d, __cuda_local_var_39437_33_non_const_fC_d, __cuda_local_var_39387_27_non_const_omega2, __cuda_local_var_39459_9_non_const_pitch_elements2, __cuda_local_var_39401_8_non_const_SF_cf));

(cudaConfigureCall(__cuda_local_var_39424_10_non_const_grid, __cuda_local_var_39423_10_non_const_threads, 0UL, ((cudaStream_t)0LL))) ? ((void)0) : (__device_stub__Z14ExtractFromC_dPfmf(__cuda_local_var_39437_21_non_const_fB_d, __cuda_local_var_39458_9_non_const_pitch_elements, __cuda_local_var_39402_8_non_const_SF_fc));
}
(cudaConfigureCall(__cuda_local_var_39424_10_non_const_grid, __cuda_local_var_39423_10_non_const_threads, 0UL, ((cudaStream_t)0LL))) ? ((void)0) : (__device_stub__Z12mrt_d_singlePfS_fm(__cuda_local_var_39437_21_non_const_fB_d, __cuda_local_var_39437_15_non_const_fA_d, __cuda_local_var_39387_8_non_const_omega, __cuda_local_var_39458_9_non_const_pitch_elements));

if (((const char *)"NO") == ((const char *)"YES")) {
(cudaConfigureCall(__cuda_local_var_39427_10_non_const_grid2, __cuda_local_var_39426_10_non_const_threads2, 0UL, ((cudaStream_t)0LL))) ? ((void)0) : (__device_stub__Z9LR_d_BACDPfS_fm(__cuda_local_var_39437_33_non_const_fC_d, __cuda_local_var_39437_39_non_const_fD_d, __cuda_local_var_39387_27_non_const_omega2, __cuda_local_var_39459_9_non_const_pitch_elements2));
(cudaConfigureCall(__cuda_local_var_39427_10_non_const_grid2, __cuda_local_var_39426_10_non_const_threads2, 0UL, ((cudaStream_t)0LL))) ? ((void)0) : (__device_stub__Z9LR_d_BADCPfS_fmf(__cuda_local_var_39437_39_non_const_fD_d, __cuda_local_var_39437_33_non_const_fC_d, __cuda_local_var_39387_27_non_const_omega2, __cuda_local_var_39459_9_non_const_pitch_elements2, __cuda_local_var_39401_8_non_const_SF_cf));

(cudaConfigureCall(__cuda_local_var_39424_10_non_const_grid, __cuda_local_var_39423_10_non_const_threads, 0UL, ((cudaStream_t)0LL))) ? ((void)0) : (__device_stub__Z14ExtractFromC_dPfmf(__cuda_local_var_39437_15_non_const_fA_d, __cuda_local_var_39458_9_non_const_pitch_elements, __cuda_local_var_39402_8_non_const_SF_fc));
}
} else  {
# 5382 "MRT.cu"
if (((const char *)"SINGLE") == ((const char *)"HYB")) {
if ((t >= 10000) && (1)) {
(cudaConfigureCall(__cuda_local_var_39424_10_non_const_grid, __cuda_local_var_39423_10_non_const_threads, 0UL, ((cudaStream_t)0LL))) ? ((void)0) : (__device_stub__Z17mrt_d_hybAB_forcePfS_fmS_S_S_i(__cuda_local_var_39437_15_non_const_fA_d, __cuda_local_var_39437_21_non_const_fB_d, __cuda_local_var_39387_8_non_const_omega, __cuda_local_var_39458_9_non_const_pitch_elements, __cuda_local_var_39438_27_non_const_FX_d, __cuda_local_var_39438_33_non_const_FY_d, __cuda_local_var_39438_39_non_const_FZ_d, t)); } else  {

(cudaConfigureCall(__cuda_local_var_39424_10_non_const_grid, __cuda_local_var_39423_10_non_const_threads, 0UL, ((cudaStream_t)0LL))) ? ((void)0) : (__device_stub__Z11mrt_d_hybABPfS_fm(__cuda_local_var_39437_15_non_const_fA_d, __cuda_local_var_39437_21_non_const_fB_d, __cuda_local_var_39387_8_non_const_omega, __cuda_local_var_39458_9_non_const_pitch_elements)); }

if (((const char *)"NO") == ((const char *)"YES")) {
if (1)
{
if (t >= 10000) {
(cudaConfigureCall(__cuda_local_var_39427_10_non_const_grid2, __cuda_local_var_39426_10_non_const_threads2, 0UL, ((cudaStream_t)0LL))) ? ((void)0) : (__device_stub__Z18LR_d_hybABCD_forcePfS_fmS_S_S_i(__cuda_local_var_39437_33_non_const_fC_d, __cuda_local_var_39437_39_non_const_fD_d, __cuda_local_var_39387_27_non_const_omega2, __cuda_local_var_39459_9_non_const_pitch_elements2, __cuda_local_var_39438_27_non_const_FX_d, __cuda_local_var_39438_33_non_const_FY_d, __cuda_local_var_39438_39_non_const_FZ_d, t)); } else  {

(cudaConfigureCall(__cuda_local_var_39427_10_non_const_grid2, __cuda_local_var_39426_10_non_const_threads2, 0UL, ((cudaStream_t)0LL))) ? ((void)0) : (__device_stub__Z12LR_d_hybABCDPfS_fm(__cuda_local_var_39437_33_non_const_fC_d, __cuda_local_var_39437_39_non_const_fD_d, __cuda_local_var_39387_27_non_const_omega2, __cuda_local_var_39459_9_non_const_pitch_elements2)); }

(cudaConfigureCall(__cuda_local_var_39427_10_non_const_grid2, __cuda_local_var_39426_10_non_const_threads2, 0UL, ((cudaStream_t)0LL))) ? ((void)0) : (__device_stub__Z19LR_d_hybABDC_InterpPfS_fmf(__cuda_local_var_39437_39_non_const_fD_d, __cuda_local_var_39437_33_non_const_fC_d, __cuda_local_var_39387_27_non_const_omega2, __cuda_local_var_39459_9_non_const_pitch_elements2, __cuda_local_var_39401_8_non_const_SF_cf));
} else  {
if (0)
{
if (t >= 10000) {
(cudaConfigureCall(__cuda_local_var_39427_10_non_const_grid2, __cuda_local_var_39426_10_non_const_threads2, 0UL, ((cudaStream_t)0LL))) ? ((void)0) : (__device_stub__Z18LR_d_hybABCD_forcePfS_fmS_S_S_i(__cuda_local_var_39437_33_non_const_fC_d, __cuda_local_var_39437_39_non_const_fD_d, __cuda_local_var_39387_27_non_const_omega2, __cuda_local_var_39459_9_non_const_pitch_elements2, __cuda_local_var_39438_27_non_const_FX_d, __cuda_local_var_39438_33_non_const_FY_d, __cuda_local_var_39438_39_non_const_FZ_d, t)); } else  {

(cudaConfigureCall(__cuda_local_var_39427_10_non_const_grid2, __cuda_local_var_39426_10_non_const_threads2, 0UL, ((cudaStream_t)0LL))) ? ((void)0) : (__device_stub__Z12LR_d_hybABCDPfS_fm(__cuda_local_var_39437_33_non_const_fC_d, __cuda_local_var_39437_39_non_const_fD_d, __cuda_local_var_39387_27_non_const_omega2, __cuda_local_var_39459_9_non_const_pitch_elements2)); }

(cudaConfigureCall(__cuda_local_var_39427_10_non_const_grid2, __cuda_local_var_39426_10_non_const_threads2, 0UL, ((cudaStream_t)0LL))) ? ((void)0) : (__device_stub__Z13LR_d_hybABDC2PfS_fmfi(__cuda_local_var_39437_39_non_const_fD_d, __cuda_local_var_39437_33_non_const_fC_d, __cuda_local_var_39387_27_non_const_omega2, __cuda_local_var_39459_9_non_const_pitch_elements2, __cuda_local_var_39401_8_non_const_SF_cf, 2));

(cudaConfigureCall(__cuda_local_var_39427_10_non_const_grid2, __cuda_local_var_39426_10_non_const_threads2, 0UL, ((cudaStream_t)0LL))) ? ((void)0) : (__device_stub__Z13LR_d_hybABCD2PfS_fmi(__cuda_local_var_39437_33_non_const_fC_d, __cuda_local_var_39437_39_non_const_fD_d, __cuda_local_var_39387_27_non_const_omega2, __cuda_local_var_39459_9_non_const_pitch_elements2, 3));
(cudaConfigureCall(__cuda_local_var_39427_10_non_const_grid2, __cuda_local_var_39426_10_non_const_threads2, 0UL, ((cudaStream_t)0LL))) ? ((void)0) : (__device_stub__Z19LR_d_hybABDC_InterpPfS_fmf(__cuda_local_var_39437_39_non_const_fD_d, __cuda_local_var_39437_33_non_const_fC_d, __cuda_local_var_39387_27_non_const_omega2, __cuda_local_var_39459_9_non_const_pitch_elements2, __cuda_local_var_39401_8_non_const_SF_cf));
} }

(cudaConfigureCall(__cuda_local_var_39424_10_non_const_grid, __cuda_local_var_39423_10_non_const_threads, 0UL, ((cudaStream_t)0LL))) ? ((void)0) : (__device_stub__Z14ExtractFromC_dPfmf(__cuda_local_var_39437_21_non_const_fB_d, __cuda_local_var_39458_9_non_const_pitch_elements, __cuda_local_var_39402_8_non_const_SF_fc));
}

if ((t >= 10000) && (1)) {
(cudaConfigureCall(__cuda_local_var_39424_10_non_const_grid, __cuda_local_var_39423_10_non_const_threads, 0UL, ((cudaStream_t)0LL))) ? ((void)0) : (__device_stub__Z17mrt_d_hybBA_forcePfS_fmS_S_S_i(__cuda_local_var_39437_21_non_const_fB_d, __cuda_local_var_39437_15_non_const_fA_d, __cuda_local_var_39387_8_non_const_omega, __cuda_local_var_39458_9_non_const_pitch_elements, __cuda_local_var_39438_27_non_const_FX_d, __cuda_local_var_39438_33_non_const_FY_d, __cuda_local_var_39438_39_non_const_FZ_d, (t + 1))); } else  {

(cudaConfigureCall(__cuda_local_var_39424_10_non_const_grid, __cuda_local_var_39423_10_non_const_threads, 0UL, ((cudaStream_t)0LL))) ? ((void)0) : (__device_stub__Z11mrt_d_hybBAPfS_fm(__cuda_local_var_39437_21_non_const_fB_d, __cuda_local_var_39437_15_non_const_fA_d, __cuda_local_var_39387_8_non_const_omega, __cuda_local_var_39458_9_non_const_pitch_elements)); }

if (((const char *)"NO") == ((const char *)"YES")) {
if (1)
{
if (t >= 10000) {
(cudaConfigureCall(__cuda_local_var_39427_10_non_const_grid2, __cuda_local_var_39426_10_non_const_threads2, 0UL, ((cudaStream_t)0LL))) ? ((void)0) : (__device_stub__Z18LR_d_hybABCD_forcePfS_fmS_S_S_i(__cuda_local_var_39437_33_non_const_fC_d, __cuda_local_var_39437_39_non_const_fD_d, __cuda_local_var_39387_27_non_const_omega2, __cuda_local_var_39459_9_non_const_pitch_elements2, __cuda_local_var_39438_27_non_const_FX_d, __cuda_local_var_39438_33_non_const_FY_d, __cuda_local_var_39438_39_non_const_FZ_d, (t + 1))); } else  {

(cudaConfigureCall(__cuda_local_var_39427_10_non_const_grid2, __cuda_local_var_39426_10_non_const_threads2, 0UL, ((cudaStream_t)0LL))) ? ((void)0) : (__device_stub__Z12LR_d_hybABCDPfS_fm(__cuda_local_var_39437_33_non_const_fC_d, __cuda_local_var_39437_39_non_const_fD_d, __cuda_local_var_39387_27_non_const_omega2, __cuda_local_var_39459_9_non_const_pitch_elements2)); }

(cudaConfigureCall(__cuda_local_var_39427_10_non_const_grid2, __cuda_local_var_39426_10_non_const_threads2, 0UL, ((cudaStream_t)0LL))) ? ((void)0) : (__device_stub__Z19LR_d_hybBADC_InterpPfS_fmf(__cuda_local_var_39437_39_non_const_fD_d, __cuda_local_var_39437_33_non_const_fC_d, __cuda_local_var_39387_27_non_const_omega2, __cuda_local_var_39459_9_non_const_pitch_elements2, __cuda_local_var_39401_8_non_const_SF_cf));
} else  {
if (0)
{
if (t >= 10000) {
(cudaConfigureCall(__cuda_local_var_39427_10_non_const_grid2, __cuda_local_var_39426_10_non_const_threads2, 0UL, ((cudaStream_t)0LL))) ? ((void)0) : (__device_stub__Z18LR_d_hybABCD_forcePfS_fmS_S_S_i(__cuda_local_var_39437_33_non_const_fC_d, __cuda_local_var_39437_39_non_const_fD_d, __cuda_local_var_39387_27_non_const_omega2, __cuda_local_var_39459_9_non_const_pitch_elements2, __cuda_local_var_39438_27_non_const_FX_d, __cuda_local_var_39438_33_non_const_FY_d, __cuda_local_var_39438_39_non_const_FZ_d, (t + 1))); } else  {

(cudaConfigureCall(__cuda_local_var_39427_10_non_const_grid2, __cuda_local_var_39426_10_non_const_threads2, 0UL, ((cudaStream_t)0LL))) ? ((void)0) : (__device_stub__Z12LR_d_hybABCDPfS_fm(__cuda_local_var_39437_33_non_const_fC_d, __cuda_local_var_39437_39_non_const_fD_d, __cuda_local_var_39387_27_non_const_omega2, __cuda_local_var_39459_9_non_const_pitch_elements2)); }

(cudaConfigureCall(__cuda_local_var_39427_10_non_const_grid2, __cuda_local_var_39426_10_non_const_threads2, 0UL, ((cudaStream_t)0LL))) ? ((void)0) : (__device_stub__Z13LR_d_hybBADC2PfS_fmfi(__cuda_local_var_39437_39_non_const_fD_d, __cuda_local_var_39437_33_non_const_fC_d, __cuda_local_var_39387_27_non_const_omega2, __cuda_local_var_39459_9_non_const_pitch_elements2, __cuda_local_var_39401_8_non_const_SF_cf, 2));

(cudaConfigureCall(__cuda_local_var_39427_10_non_const_grid2, __cuda_local_var_39426_10_non_const_threads2, 0UL, ((cudaStream_t)0LL))) ? ((void)0) : (__device_stub__Z13LR_d_hybABCD2PfS_fmi(__cuda_local_var_39437_33_non_const_fC_d, __cuda_local_var_39437_39_non_const_fD_d, __cuda_local_var_39387_27_non_const_omega2, __cuda_local_var_39459_9_non_const_pitch_elements2, 3));
(cudaConfigureCall(__cuda_local_var_39427_10_non_const_grid2, __cuda_local_var_39426_10_non_const_threads2, 0UL, ((cudaStream_t)0LL))) ? ((void)0) : (__device_stub__Z19LR_d_hybBADC_InterpPfS_fmf(__cuda_local_var_39437_39_non_const_fD_d, __cuda_local_var_39437_33_non_const_fC_d, __cuda_local_var_39387_27_non_const_omega2, __cuda_local_var_39459_9_non_const_pitch_elements2, __cuda_local_var_39401_8_non_const_SF_cf));
} }

(cudaConfigureCall(__cuda_local_var_39424_10_non_const_grid, __cuda_local_var_39423_10_non_const_threads, 0UL, ((cudaStream_t)0LL))) ? ((void)0) : (__device_stub__Z14ExtractFromC_dPfmf(__cuda_local_var_39437_15_non_const_fA_d, __cuda_local_var_39458_9_non_const_pitch_elements, __cuda_local_var_39402_8_non_const_SF_fc));
}
} }
# 5453 "MRT.cu"
if (((t % 1000) == 0) && (t > 0)) { _ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc((_ZNSolsEi((_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc((&_ZSt4cout), ((const char *)"finished "))), t)), ((const char *)" timesteps\n")); }
} }
cudaDeviceSynchronize();

gettimeofday((&__cuda_local_var_39805_22_non_const_tdr1), ((struct timezone *)0LL));
_Z16timeval_subtractPdP7timevalS1_((&__cuda_local_var_39806_9_non_const_restime), (&__cuda_local_var_39805_22_non_const_tdr1), (&__cuda_local_var_39805_17_non_const_tdr0));

if (((const char *)"NO") == ((const char *)"YES")) {
__cuda_local_var_39903_6_non_const_Nodes = 786432;
}
else  {
__cuda_local_var_39903_6_non_const_Nodes = 262144;
}
_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc((_ZNSolsEd((_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc((_ZNSolsEd((_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc((&_ZSt4cout), ((const char *)"Time taken for main kernel: "))), __cuda_local_var_39806_9_non_const_restime)), ((const char *)" ("))), (((double)(((double)__cuda_local_var_39903_6_non_const_Nodes) * (0.0005000000237487256527))) / __cuda_local_var_39806_9_non_const_restime))), ((const char *)"MLUPS)"));

if (((const char *)"NO") == ((const char *)"YES")) {
 int __cuda_local_var_39913_6_non_const_effNodes;
# 5469 "MRT.cu"
__cuda_local_var_39913_6_non_const_effNodes = 753664;

_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc((_ZNSolsEd((_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc((&_ZSt4cout), ((const char *)" (eff: "))), (((double)(((double)__cuda_local_var_39913_6_non_const_effNodes) * (0.0005000000237487256527))) / __cuda_local_var_39806_9_non_const_restime))), ((const char *)"MLUPS)"));
}
_ZNSolsEPFRSoS_E((&_ZSt4cout), _ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_);
_ZNSolsEPFRSoS_E((_ZNSolsEd((_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc((_ZNSolsEi((_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc((_ZNSolsEi((_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc((_ZNSolsEi((_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc((_ZNSolsEi((&_ZSt4cout), 64)), ((const char *)","))), 64)), ((const char *)","))), 64)), ((const char *)","))), 500)), ((const char *)","))), __cuda_local_var_39806_9_non_const_restime)), _ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_);


if (1) {
_Z17cudaUnbindTextureIfLi2EL19cudaTextureReadMode0EE9cudaErrorRK7textureIT_XT0_EXT1_EE((((const struct _Z7textureIfLi2EL19cudaTextureReadMode0EE *)&__text_var(texRef_f0A,texRef_f0A))));
_Z17cudaUnbindTextureIfLi2EL19cudaTextureReadMode0EE9cudaErrorRK7textureIT_XT0_EXT1_EE((((const struct _Z7textureIfLi2EL19cudaTextureReadMode0EE *)&__text_var(texRef_f1A,texRef_f1A))));
_Z17cudaUnbindTextureIfLi2EL19cudaTextureReadMode0EE9cudaErrorRK7textureIT_XT0_EXT1_EE((((const struct _Z7textureIfLi2EL19cudaTextureReadMode0EE *)&__text_var(texRef_f2A,texRef_f2A))));
_Z17cudaUnbindTextureIfLi2EL19cudaTextureReadMode0EE9cudaErrorRK7textureIT_XT0_EXT1_EE((((const struct _Z7textureIfLi2EL19cudaTextureReadMode0EE *)&__text_var(texRef_f3A,texRef_f3A))));
_Z17cudaUnbindTextureIfLi2EL19cudaTextureReadMode0EE9cudaErrorRK7textureIT_XT0_EXT1_EE((((const struct _Z7textureIfLi2EL19cudaTextureReadMode0EE *)&__text_var(texRef_f4A,texRef_f4A))));
_Z17cudaUnbindTextureIfLi2EL19cudaTextureReadMode0EE9cudaErrorRK7textureIT_XT0_EXT1_EE((((const struct _Z7textureIfLi2EL19cudaTextureReadMode0EE *)&__text_var(texRef_f5A,texRef_f5A))));
_Z17cudaUnbindTextureIfLi2EL19cudaTextureReadMode0EE9cudaErrorRK7textureIT_XT0_EXT1_EE((((const struct _Z7textureIfLi2EL19cudaTextureReadMode0EE *)&__text_var(texRef_f6A,texRef_f6A))));
_Z17cudaUnbindTextureIfLi2EL19cudaTextureReadMode0EE9cudaErrorRK7textureIT_XT0_EXT1_EE((((const struct _Z7textureIfLi2EL19cudaTextureReadMode0EE *)&__text_var(texRef_f7A,texRef_f7A))));
_Z17cudaUnbindTextureIfLi2EL19cudaTextureReadMode0EE9cudaErrorRK7textureIT_XT0_EXT1_EE((((const struct _Z7textureIfLi2EL19cudaTextureReadMode0EE *)&__text_var(texRef_f8A,texRef_f8A))));
_Z17cudaUnbindTextureIfLi2EL19cudaTextureReadMode0EE9cudaErrorRK7textureIT_XT0_EXT1_EE((((const struct _Z7textureIfLi2EL19cudaTextureReadMode0EE *)&__text_var(texRef_f9A,texRef_f9A))));
_Z17cudaUnbindTextureIfLi2EL19cudaTextureReadMode0EE9cudaErrorRK7textureIT_XT0_EXT1_EE((((const struct _Z7textureIfLi2EL19cudaTextureReadMode0EE *)&__text_var(texRef_f10A,texRef_f10A))));
_Z17cudaUnbindTextureIfLi2EL19cudaTextureReadMode0EE9cudaErrorRK7textureIT_XT0_EXT1_EE((((const struct _Z7textureIfLi2EL19cudaTextureReadMode0EE *)&__text_var(texRef_f11A,texRef_f11A))));
_Z17cudaUnbindTextureIfLi2EL19cudaTextureReadMode0EE9cudaErrorRK7textureIT_XT0_EXT1_EE((((const struct _Z7textureIfLi2EL19cudaTextureReadMode0EE *)&__text_var(texRef_f12A,texRef_f12A))));
_Z17cudaUnbindTextureIfLi2EL19cudaTextureReadMode0EE9cudaErrorRK7textureIT_XT0_EXT1_EE((((const struct _Z7textureIfLi2EL19cudaTextureReadMode0EE *)&__text_var(texRef_f13A,texRef_f13A))));
_Z17cudaUnbindTextureIfLi2EL19cudaTextureReadMode0EE9cudaErrorRK7textureIT_XT0_EXT1_EE((((const struct _Z7textureIfLi2EL19cudaTextureReadMode0EE *)&__text_var(texRef_f14A,texRef_f14A))));
_Z17cudaUnbindTextureIfLi2EL19cudaTextureReadMode0EE9cudaErrorRK7textureIT_XT0_EXT1_EE((((const struct _Z7textureIfLi2EL19cudaTextureReadMode0EE *)&__text_var(texRef_f15A,texRef_f15A))));
_Z17cudaUnbindTextureIfLi2EL19cudaTextureReadMode0EE9cudaErrorRK7textureIT_XT0_EXT1_EE((((const struct _Z7textureIfLi2EL19cudaTextureReadMode0EE *)&__text_var(texRef_f16A,texRef_f16A))));
_Z17cudaUnbindTextureIfLi2EL19cudaTextureReadMode0EE9cudaErrorRK7textureIT_XT0_EXT1_EE((((const struct _Z7textureIfLi2EL19cudaTextureReadMode0EE *)&__text_var(texRef_f17A,texRef_f17A))));
_Z17cudaUnbindTextureIfLi2EL19cudaTextureReadMode0EE9cudaErrorRK7textureIT_XT0_EXT1_EE((((const struct _Z7textureIfLi2EL19cudaTextureReadMode0EE *)&__text_var(texRef_f18A,texRef_f18A))));
_Z17cudaUnbindTextureIfLi2EL19cudaTextureReadMode0EE9cudaErrorRK7textureIT_XT0_EXT1_EE((((const struct _Z7textureIfLi2EL19cudaTextureReadMode0EE *)&__text_var(texRef_f0B,texRef_f0B))));
_Z17cudaUnbindTextureIfLi2EL19cudaTextureReadMode0EE9cudaErrorRK7textureIT_XT0_EXT1_EE((((const struct _Z7textureIfLi2EL19cudaTextureReadMode0EE *)&__text_var(texRef_f1B,texRef_f1B))));
_Z17cudaUnbindTextureIfLi2EL19cudaTextureReadMode0EE9cudaErrorRK7textureIT_XT0_EXT1_EE((((const struct _Z7textureIfLi2EL19cudaTextureReadMode0EE *)&__text_var(texRef_f2B,texRef_f2B))));
_Z17cudaUnbindTextureIfLi2EL19cudaTextureReadMode0EE9cudaErrorRK7textureIT_XT0_EXT1_EE((((const struct _Z7textureIfLi2EL19cudaTextureReadMode0EE *)&__text_var(texRef_f3B,texRef_f3B))));
_Z17cudaUnbindTextureIfLi2EL19cudaTextureReadMode0EE9cudaErrorRK7textureIT_XT0_EXT1_EE((((const struct _Z7textureIfLi2EL19cudaTextureReadMode0EE *)&__text_var(texRef_f4B,texRef_f4B))));
_Z17cudaUnbindTextureIfLi2EL19cudaTextureReadMode0EE9cudaErrorRK7textureIT_XT0_EXT1_EE((((const struct _Z7textureIfLi2EL19cudaTextureReadMode0EE *)&__text_var(texRef_f5B,texRef_f5B))));
_Z17cudaUnbindTextureIfLi2EL19cudaTextureReadMode0EE9cudaErrorRK7textureIT_XT0_EXT1_EE((((const struct _Z7textureIfLi2EL19cudaTextureReadMode0EE *)&__text_var(texRef_f6B,texRef_f6B))));
_Z17cudaUnbindTextureIfLi2EL19cudaTextureReadMode0EE9cudaErrorRK7textureIT_XT0_EXT1_EE((((const struct _Z7textureIfLi2EL19cudaTextureReadMode0EE *)&__text_var(texRef_f7B,texRef_f7B))));
_Z17cudaUnbindTextureIfLi2EL19cudaTextureReadMode0EE9cudaErrorRK7textureIT_XT0_EXT1_EE((((const struct _Z7textureIfLi2EL19cudaTextureReadMode0EE *)&__text_var(texRef_f8B,texRef_f8B))));
_Z17cudaUnbindTextureIfLi2EL19cudaTextureReadMode0EE9cudaErrorRK7textureIT_XT0_EXT1_EE((((const struct _Z7textureIfLi2EL19cudaTextureReadMode0EE *)&__text_var(texRef_f9B,texRef_f9B))));
_Z17cudaUnbindTextureIfLi2EL19cudaTextureReadMode0EE9cudaErrorRK7textureIT_XT0_EXT1_EE((((const struct _Z7textureIfLi2EL19cudaTextureReadMode0EE *)&__text_var(texRef_f10B,texRef_f10B))));
_Z17cudaUnbindTextureIfLi2EL19cudaTextureReadMode0EE9cudaErrorRK7textureIT_XT0_EXT1_EE((((const struct _Z7textureIfLi2EL19cudaTextureReadMode0EE *)&__text_var(texRef_f11B,texRef_f11B))));
_Z17cudaUnbindTextureIfLi2EL19cudaTextureReadMode0EE9cudaErrorRK7textureIT_XT0_EXT1_EE((((const struct _Z7textureIfLi2EL19cudaTextureReadMode0EE *)&__text_var(texRef_f12B,texRef_f12B))));
_Z17cudaUnbindTextureIfLi2EL19cudaTextureReadMode0EE9cudaErrorRK7textureIT_XT0_EXT1_EE((((const struct _Z7textureIfLi2EL19cudaTextureReadMode0EE *)&__text_var(texRef_f13B,texRef_f13B))));
_Z17cudaUnbindTextureIfLi2EL19cudaTextureReadMode0EE9cudaErrorRK7textureIT_XT0_EXT1_EE((((const struct _Z7textureIfLi2EL19cudaTextureReadMode0EE *)&__text_var(texRef_f14B,texRef_f14B))));
_Z17cudaUnbindTextureIfLi2EL19cudaTextureReadMode0EE9cudaErrorRK7textureIT_XT0_EXT1_EE((((const struct _Z7textureIfLi2EL19cudaTextureReadMode0EE *)&__text_var(texRef_f15B,texRef_f15B))));
_Z17cudaUnbindTextureIfLi2EL19cudaTextureReadMode0EE9cudaErrorRK7textureIT_XT0_EXT1_EE((((const struct _Z7textureIfLi2EL19cudaTextureReadMode0EE *)&__text_var(texRef_f16B,texRef_f16B))));
_Z17cudaUnbindTextureIfLi2EL19cudaTextureReadMode0EE9cudaErrorRK7textureIT_XT0_EXT1_EE((((const struct _Z7textureIfLi2EL19cudaTextureReadMode0EE *)&__text_var(texRef_f17B,texRef_f17B))));
_Z17cudaUnbindTextureIfLi2EL19cudaTextureReadMode0EE9cudaErrorRK7textureIT_XT0_EXT1_EE((((const struct _Z7textureIfLi2EL19cudaTextureReadMode0EE *)&__text_var(texRef_f18B,texRef_f18B))));

_Z17cudaUnbindTextureIfLi2EL19cudaTextureReadMode0EE9cudaErrorRK7textureIT_XT0_EXT1_EE((((const struct _Z7textureIfLi2EL19cudaTextureReadMode0EE *)&__text_var(texRef_f0C,texRef_f0C))));
_Z17cudaUnbindTextureIfLi2EL19cudaTextureReadMode0EE9cudaErrorRK7textureIT_XT0_EXT1_EE((((const struct _Z7textureIfLi2EL19cudaTextureReadMode0EE *)&__text_var(texRef_f1C,texRef_f1C))));
_Z17cudaUnbindTextureIfLi2EL19cudaTextureReadMode0EE9cudaErrorRK7textureIT_XT0_EXT1_EE((((const struct _Z7textureIfLi2EL19cudaTextureReadMode0EE *)&__text_var(texRef_f2C,texRef_f2C))));
_Z17cudaUnbindTextureIfLi2EL19cudaTextureReadMode0EE9cudaErrorRK7textureIT_XT0_EXT1_EE((((const struct _Z7textureIfLi2EL19cudaTextureReadMode0EE *)&__text_var(texRef_f3C,texRef_f3C))));
_Z17cudaUnbindTextureIfLi2EL19cudaTextureReadMode0EE9cudaErrorRK7textureIT_XT0_EXT1_EE((((const struct _Z7textureIfLi2EL19cudaTextureReadMode0EE *)&__text_var(texRef_f4C,texRef_f4C))));
_Z17cudaUnbindTextureIfLi2EL19cudaTextureReadMode0EE9cudaErrorRK7textureIT_XT0_EXT1_EE((((const struct _Z7textureIfLi2EL19cudaTextureReadMode0EE *)&__text_var(texRef_f5C,texRef_f5C))));
_Z17cudaUnbindTextureIfLi2EL19cudaTextureReadMode0EE9cudaErrorRK7textureIT_XT0_EXT1_EE((((const struct _Z7textureIfLi2EL19cudaTextureReadMode0EE *)&__text_var(texRef_f6C,texRef_f6C))));
_Z17cudaUnbindTextureIfLi2EL19cudaTextureReadMode0EE9cudaErrorRK7textureIT_XT0_EXT1_EE((((const struct _Z7textureIfLi2EL19cudaTextureReadMode0EE *)&__text_var(texRef_f7C,texRef_f7C))));
_Z17cudaUnbindTextureIfLi2EL19cudaTextureReadMode0EE9cudaErrorRK7textureIT_XT0_EXT1_EE((((const struct _Z7textureIfLi2EL19cudaTextureReadMode0EE *)&__text_var(texRef_f8C,texRef_f8C))));
_Z17cudaUnbindTextureIfLi2EL19cudaTextureReadMode0EE9cudaErrorRK7textureIT_XT0_EXT1_EE((((const struct _Z7textureIfLi2EL19cudaTextureReadMode0EE *)&__text_var(texRef_f9C,texRef_f9C))));
_Z17cudaUnbindTextureIfLi2EL19cudaTextureReadMode0EE9cudaErrorRK7textureIT_XT0_EXT1_EE((((const struct _Z7textureIfLi2EL19cudaTextureReadMode0EE *)&__text_var(texRef_f10C,texRef_f10C))));
_Z17cudaUnbindTextureIfLi2EL19cudaTextureReadMode0EE9cudaErrorRK7textureIT_XT0_EXT1_EE((((const struct _Z7textureIfLi2EL19cudaTextureReadMode0EE *)&__text_var(texRef_f11C,texRef_f11C))));
_Z17cudaUnbindTextureIfLi2EL19cudaTextureReadMode0EE9cudaErrorRK7textureIT_XT0_EXT1_EE((((const struct _Z7textureIfLi2EL19cudaTextureReadMode0EE *)&__text_var(texRef_f12C,texRef_f12C))));
_Z17cudaUnbindTextureIfLi2EL19cudaTextureReadMode0EE9cudaErrorRK7textureIT_XT0_EXT1_EE((((const struct _Z7textureIfLi2EL19cudaTextureReadMode0EE *)&__text_var(texRef_f13C,texRef_f13C))));
_Z17cudaUnbindTextureIfLi2EL19cudaTextureReadMode0EE9cudaErrorRK7textureIT_XT0_EXT1_EE((((const struct _Z7textureIfLi2EL19cudaTextureReadMode0EE *)&__text_var(texRef_f14C,texRef_f14C))));
_Z17cudaUnbindTextureIfLi2EL19cudaTextureReadMode0EE9cudaErrorRK7textureIT_XT0_EXT1_EE((((const struct _Z7textureIfLi2EL19cudaTextureReadMode0EE *)&__text_var(texRef_f15C,texRef_f15C))));
_Z17cudaUnbindTextureIfLi2EL19cudaTextureReadMode0EE9cudaErrorRK7textureIT_XT0_EXT1_EE((((const struct _Z7textureIfLi2EL19cudaTextureReadMode0EE *)&__text_var(texRef_f16C,texRef_f16C))));
_Z17cudaUnbindTextureIfLi2EL19cudaTextureReadMode0EE9cudaErrorRK7textureIT_XT0_EXT1_EE((((const struct _Z7textureIfLi2EL19cudaTextureReadMode0EE *)&__text_var(texRef_f17C,texRef_f17C))));
_Z17cudaUnbindTextureIfLi2EL19cudaTextureReadMode0EE9cudaErrorRK7textureIT_XT0_EXT1_EE((((const struct _Z7textureIfLi2EL19cudaTextureReadMode0EE *)&__text_var(texRef_f18C,texRef_f18C))));
_Z17cudaUnbindTextureIfLi2EL19cudaTextureReadMode0EE9cudaErrorRK7textureIT_XT0_EXT1_EE((((const struct _Z7textureIfLi2EL19cudaTextureReadMode0EE *)&__text_var(texRef_f0D,texRef_f0D))));
_Z17cudaUnbindTextureIfLi2EL19cudaTextureReadMode0EE9cudaErrorRK7textureIT_XT0_EXT1_EE((((const struct _Z7textureIfLi2EL19cudaTextureReadMode0EE *)&__text_var(texRef_f1D,texRef_f1D))));
_Z17cudaUnbindTextureIfLi2EL19cudaTextureReadMode0EE9cudaErrorRK7textureIT_XT0_EXT1_EE((((const struct _Z7textureIfLi2EL19cudaTextureReadMode0EE *)&__text_var(texRef_f2D,texRef_f2D))));
_Z17cudaUnbindTextureIfLi2EL19cudaTextureReadMode0EE9cudaErrorRK7textureIT_XT0_EXT1_EE((((const struct _Z7textureIfLi2EL19cudaTextureReadMode0EE *)&__text_var(texRef_f3D,texRef_f3D))));
_Z17cudaUnbindTextureIfLi2EL19cudaTextureReadMode0EE9cudaErrorRK7textureIT_XT0_EXT1_EE((((const struct _Z7textureIfLi2EL19cudaTextureReadMode0EE *)&__text_var(texRef_f4D,texRef_f4D))));
_Z17cudaUnbindTextureIfLi2EL19cudaTextureReadMode0EE9cudaErrorRK7textureIT_XT0_EXT1_EE((((const struct _Z7textureIfLi2EL19cudaTextureReadMode0EE *)&__text_var(texRef_f5D,texRef_f5D))));
_Z17cudaUnbindTextureIfLi2EL19cudaTextureReadMode0EE9cudaErrorRK7textureIT_XT0_EXT1_EE((((const struct _Z7textureIfLi2EL19cudaTextureReadMode0EE *)&__text_var(texRef_f6D,texRef_f6D))));
_Z17cudaUnbindTextureIfLi2EL19cudaTextureReadMode0EE9cudaErrorRK7textureIT_XT0_EXT1_EE((((const struct _Z7textureIfLi2EL19cudaTextureReadMode0EE *)&__text_var(texRef_f7D,texRef_f7D))));
_Z17cudaUnbindTextureIfLi2EL19cudaTextureReadMode0EE9cudaErrorRK7textureIT_XT0_EXT1_EE((((const struct _Z7textureIfLi2EL19cudaTextureReadMode0EE *)&__text_var(texRef_f8D,texRef_f8D))));
_Z17cudaUnbindTextureIfLi2EL19cudaTextureReadMode0EE9cudaErrorRK7textureIT_XT0_EXT1_EE((((const struct _Z7textureIfLi2EL19cudaTextureReadMode0EE *)&__text_var(texRef_f9D,texRef_f9D))));
_Z17cudaUnbindTextureIfLi2EL19cudaTextureReadMode0EE9cudaErrorRK7textureIT_XT0_EXT1_EE((((const struct _Z7textureIfLi2EL19cudaTextureReadMode0EE *)&__text_var(texRef_f10D,texRef_f10D))));
_Z17cudaUnbindTextureIfLi2EL19cudaTextureReadMode0EE9cudaErrorRK7textureIT_XT0_EXT1_EE((((const struct _Z7textureIfLi2EL19cudaTextureReadMode0EE *)&__text_var(texRef_f11D,texRef_f11D))));
_Z17cudaUnbindTextureIfLi2EL19cudaTextureReadMode0EE9cudaErrorRK7textureIT_XT0_EXT1_EE((((const struct _Z7textureIfLi2EL19cudaTextureReadMode0EE *)&__text_var(texRef_f12D,texRef_f12D))));
_Z17cudaUnbindTextureIfLi2EL19cudaTextureReadMode0EE9cudaErrorRK7textureIT_XT0_EXT1_EE((((const struct _Z7textureIfLi2EL19cudaTextureReadMode0EE *)&__text_var(texRef_f13D,texRef_f13D))));
_Z17cudaUnbindTextureIfLi2EL19cudaTextureReadMode0EE9cudaErrorRK7textureIT_XT0_EXT1_EE((((const struct _Z7textureIfLi2EL19cudaTextureReadMode0EE *)&__text_var(texRef_f14D,texRef_f14D))));
_Z17cudaUnbindTextureIfLi2EL19cudaTextureReadMode0EE9cudaErrorRK7textureIT_XT0_EXT1_EE((((const struct _Z7textureIfLi2EL19cudaTextureReadMode0EE *)&__text_var(texRef_f15D,texRef_f15D))));
_Z17cudaUnbindTextureIfLi2EL19cudaTextureReadMode0EE9cudaErrorRK7textureIT_XT0_EXT1_EE((((const struct _Z7textureIfLi2EL19cudaTextureReadMode0EE *)&__text_var(texRef_f16D,texRef_f16D))));
_Z17cudaUnbindTextureIfLi2EL19cudaTextureReadMode0EE9cudaErrorRK7textureIT_XT0_EXT1_EE((((const struct _Z7textureIfLi2EL19cudaTextureReadMode0EE *)&__text_var(texRef_f17D,texRef_f17D))));
_Z17cudaUnbindTextureIfLi2EL19cudaTextureReadMode0EE9cudaErrorRK7textureIT_XT0_EXT1_EE((((const struct _Z7textureIfLi2EL19cudaTextureReadMode0EE *)&__text_var(texRef_f18D,texRef_f18D))));
}

cudaMemcpy2D(((void *)__cuda_local_var_39437_9_non_const_fA_h), 256UL, ((const void *)__cuda_local_var_39437_15_non_const_fA_d), __cuda_local_var_39384_9_non_const_pitch, 256UL, 77824UL, cudaMemcpyDeviceToHost);
if (((const char *)"NO") == ((const char *)"YES")) {
cudaMemcpy2D(((void *)__cuda_local_var_39437_27_non_const_fC_h), 256UL, ((const void *)__cuda_local_var_39437_33_non_const_fC_d), __cuda_local_var_39385_9_non_const_pitch2, 256UL, 77824UL, cudaMemcpyDeviceToHost);
}
cudaMemcpy(((void *)__cuda_local_var_39438_9_non_const_FX_h), ((const void *)__cuda_local_var_39438_27_non_const_FX_d), 2000UL, cudaMemcpyDeviceToHost);
cudaMemcpy(((void *)__cuda_local_var_39438_15_non_const_FY_h), ((const void *)__cuda_local_var_39438_33_non_const_FY_d), 2000UL, cudaMemcpyDeviceToHost);
cudaMemcpy(((void *)__cuda_local_var_39438_21_non_const_FZ_h), ((const void *)__cuda_local_var_39438_39_non_const_FZ_d), 2000UL, cudaMemcpyDeviceToHost);




_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc((((struct _ZSo *)&__cuda_local_var_39376_11_non_const_output)), ((const char *)"VARIABLES = \"X\",\"Y\",\"Z\",\"u\",\"v\",\"w\",\"rho\"\n"));
_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc((_ZNSolsEi((_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc((_ZNSolsEi((_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc((_ZNSolsEi((_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc((((struct _ZSo *)&__cuda_local_var_39376_11_non_const_output)), ((const char *)"ZONE F=POINT, I="))), 64)), ((const char *)", J="))), 64)), ((const char *)", K="))), 64)), ((const char *)"\n"));

__cuda_local_var_40015_6_non_const_row = 0;
__cuda_local_var_40016_6_non_const_col = 0;
__cuda_local_var_40017_6_non_const_dep = 0;
__cuda_local_var_39386_6_non_const_i = 0;



for (__cuda_local_var_40017_6_non_const_dep = 0; (__cuda_local_var_40017_6_non_const_dep < 64); __cuda_local_var_40017_6_non_const_dep++) {
for (__cuda_local_var_40015_6_non_const_row = 0; (__cuda_local_var_40015_6_non_const_row < 64); __cuda_local_var_40015_6_non_const_row++) {
for (__cuda_local_var_40016_6_non_const_col = 0; (__cuda_local_var_40016_6_non_const_col < 64); __cuda_local_var_40016_6_non_const_col++) {
__cuda_local_var_39386_6_non_const_i = ((((__cuda_local_var_40017_6_non_const_dep * 64) * 64) + (__cuda_local_var_40015_6_non_const_row * 64)) + __cuda_local_var_40016_6_non_const_col);

__cuda_local_var_40019_8_non_const_rho = (__cuda_local_var_39437_9_non_const_fA_h[__cuda_local_var_39386_6_non_const_i]);
for (__cuda_local_var_40020_6_non_const_j = 1; (__cuda_local_var_40020_6_non_const_j < 19); __cuda_local_var_40020_6_non_const_j++) {
__cuda_local_var_40019_8_non_const_rho += (__cuda_local_var_39437_9_non_const_fA_h[(__cuda_local_var_39386_6_non_const_i + (262144 * __cuda_local_var_40020_6_non_const_j))]); }


__cuda_local_var_40019_13_non_const_u = ((((((((((__cuda_local_var_39437_9_non_const_fA_h[(__cuda_local_var_39386_6_non_const_i + 262144)]) - (__cuda_local_var_39437_9_non_const_fA_h[(__cuda_local_var_39386_6_non_const_i + 786432)])) + (__cuda_local_var_39437_9_non_const_fA_h[(__cuda_local_var_39386_6_non_const_i + 1310720)])) - (__cuda_local_var_39437_9_non_const_fA_h[(__cuda_local_var_39386_6_non_const_i + 1572864)])) - (__cuda_local_var_39437_9_non_const_fA_h[(__cuda_local_var_39386_6_non_const_i + 1835008)])) + (__cuda_local_var_39437_9_non_const_fA_h[(__cuda_local_var_39386_6_non_const_i + 2097152)])) + (__cuda_local_var_39437_9_non_const_fA_h[(__cuda_local_var_39386_6_non_const_i + 2621440)])) - (__cuda_local_var_39437_9_non_const_fA_h[(__cuda_local_var_39386_6_non_const_i + 3145728)])) + (__cuda_local_var_39437_9_non_const_fA_h[(__cuda_local_var_39386_6_non_const_i + 3932160)])) - (__cuda_local_var_39437_9_non_const_fA_h[(__cuda_local_var_39386_6_non_const_i + 4456448)]));


__cuda_local_var_40019_16_non_const_v = ((((((((((__cuda_local_var_39437_9_non_const_fA_h[(__cuda_local_var_39386_6_non_const_i + 524288)]) - (__cuda_local_var_39437_9_non_const_fA_h[(__cuda_local_var_39386_6_non_const_i + 1048576)])) + (__cuda_local_var_39437_9_non_const_fA_h[(__cuda_local_var_39386_6_non_const_i + 1310720)])) + (__cuda_local_var_39437_9_non_const_fA_h[(__cuda_local_var_39386_6_non_const_i + 1572864)])) - (__cuda_local_var_39437_9_non_const_fA_h[(__cuda_local_var_39386_6_non_const_i + 1835008)])) - (__cuda_local_var_39437_9_non_const_fA_h[(__cuda_local_var_39386_6_non_const_i + 2097152)])) + (__cuda_local_var_39437_9_non_const_fA_h[(__cuda_local_var_39386_6_non_const_i + 2883584)])) - (__cuda_local_var_39437_9_non_const_fA_h[(__cuda_local_var_39386_6_non_const_i + 3407872)])) + (__cuda_local_var_39437_9_non_const_fA_h[(__cuda_local_var_39386_6_non_const_i + 4194304)])) - (__cuda_local_var_39437_9_non_const_fA_h[(__cuda_local_var_39386_6_non_const_i + 4718592)]));
__cuda_local_var_40019_19_non_const_w = ((((((((((__cuda_local_var_39437_9_non_const_fA_h[(__cuda_local_var_39386_6_non_const_i + 2359296)]) + (__cuda_local_var_39437_9_non_const_fA_h[(__cuda_local_var_39386_6_non_const_i + 2621440)])) + (__cuda_local_var_39437_9_non_const_fA_h[(__cuda_local_var_39386_6_non_const_i + 2883584)])) + (__cuda_local_var_39437_9_non_const_fA_h[(__cuda_local_var_39386_6_non_const_i + 3145728)])) + (__cuda_local_var_39437_9_non_const_fA_h[(__cuda_local_var_39386_6_non_const_i + 3407872)])) - (__cuda_local_var_39437_9_non_const_fA_h[(__cuda_local_var_39386_6_non_const_i + 3670016)])) - (__cuda_local_var_39437_9_non_const_fA_h[(__cuda_local_var_39386_6_non_const_i + 3932160)])) - (__cuda_local_var_39437_9_non_const_fA_h[(__cuda_local_var_39386_6_non_const_i + 4194304)])) - (__cuda_local_var_39437_9_non_const_fA_h[(__cuda_local_var_39386_6_non_const_i + 4456448)])) - (__cuda_local_var_39437_9_non_const_fA_h[(__cuda_local_var_39386_6_non_const_i + 4718592)]));
_ZNSolsEPFRSoS_E((_ZNSolsEf((_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc((_ZNSolsEf((_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc((_ZNSolsEf((_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc((_ZNSolsEf((_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc((_ZNSolsEi((_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc((_ZNSolsEi((_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc((_ZNSolsEi((((struct _ZSo *)&__cuda_local_var_39376_11_non_const_output)), __cuda_local_var_40016_6_non_const_col)), ((const char *)", "))), __cuda_local_var_40015_6_non_const_row)), ((const char *)", "))), __cuda_local_var_40017_6_non_const_dep)), ((const char *)", "))), __cuda_local_var_40019_13_non_const_u)), ((const char *)","))), __cuda_local_var_40019_16_non_const_v)), ((const char *)","))), __cuda_local_var_40019_19_non_const_w)), ((const char *)","))), __cuda_local_var_40019_8_non_const_rho)), _ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_);

}
}
}

if (((const char *)"NO") == ((const char *)"YES")) {
_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc((_ZNSolsEPFRSoS_E((((struct _ZSo *)&__cuda_local_var_39376_11_non_const_output)), _ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_)), ((const char *)"VARIABLES = \"X\",\"Y\",\"Z\",\"u\",\"v\",\"w\",\"rho\"\n"));
_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc((_ZNSolsEi((_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc((_ZNSolsEi((_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc((_ZNSolsEi((_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc((((struct _ZSo *)&__cuda_local_var_39376_11_non_const_output)), ((const char *)"ZONE F=POINT, I="))), 64)), ((const char *)", J="))), 64)), ((const char *)", K="))), 64)), ((const char *)"\n"));

for (__cuda_local_var_40017_6_non_const_dep = 0; (__cuda_local_var_40017_6_non_const_dep < 64); __cuda_local_var_40017_6_non_const_dep++) {
for (__cuda_local_var_40015_6_non_const_row = 0; (__cuda_local_var_40015_6_non_const_row < 64); __cuda_local_var_40015_6_non_const_row++) {
for (__cuda_local_var_40016_6_non_const_col = 0; (__cuda_local_var_40016_6_non_const_col < 64); __cuda_local_var_40016_6_non_const_col++) {
__cuda_local_var_39386_6_non_const_i = ((((__cuda_local_var_40017_6_non_const_dep * 64) * 64) + (__cuda_local_var_40015_6_non_const_row * 64)) + __cuda_local_var_40016_6_non_const_col);
__cuda_local_var_40019_8_non_const_rho = (__cuda_local_var_39437_27_non_const_fC_h[__cuda_local_var_39386_6_non_const_i]);
for (__cuda_local_var_40020_6_non_const_j = 1; (__cuda_local_var_40020_6_non_const_j < 19); __cuda_local_var_40020_6_non_const_j++) {

__cuda_local_var_40019_8_non_const_rho += (__cuda_local_var_39437_27_non_const_fC_h[(__cuda_local_var_39386_6_non_const_i + (262144 * __cuda_local_var_40020_6_non_const_j))]); }
__cuda_local_var_40019_13_non_const_u = ((((((((((__cuda_local_var_39437_27_non_const_fC_h[(__cuda_local_var_39386_6_non_const_i + 262144)]) - (__cuda_local_var_39437_27_non_const_fC_h[(__cuda_local_var_39386_6_non_const_i + 786432)])) + (__cuda_local_var_39437_27_non_const_fC_h[(__cuda_local_var_39386_6_non_const_i + 1310720)])) - (__cuda_local_var_39437_27_non_const_fC_h[(__cuda_local_var_39386_6_non_const_i + 1572864)])) - (__cuda_local_var_39437_27_non_const_fC_h[(__cuda_local_var_39386_6_non_const_i + 1835008)])) + (__cuda_local_var_39437_27_non_const_fC_h[(__cuda_local_var_39386_6_non_const_i + 2097152)])) + (__cuda_local_var_39437_27_non_const_fC_h[(__cuda_local_var_39386_6_non_const_i + 2621440)])) - (__cuda_local_var_39437_27_non_const_fC_h[(__cuda_local_var_39386_6_non_const_i + 3145728)])) + (__cuda_local_var_39437_27_non_const_fC_h[(__cuda_local_var_39386_6_non_const_i + 3932160)])) - (__cuda_local_var_39437_27_non_const_fC_h[(__cuda_local_var_39386_6_non_const_i + 4456448)]));


__cuda_local_var_40019_16_non_const_v = ((((((((((__cuda_local_var_39437_27_non_const_fC_h[(__cuda_local_var_39386_6_non_const_i + 524288)]) - (__cuda_local_var_39437_27_non_const_fC_h[(__cuda_local_var_39386_6_non_const_i + 1048576)])) + (__cuda_local_var_39437_27_non_const_fC_h[(__cuda_local_var_39386_6_non_const_i + 1310720)])) + (__cuda_local_var_39437_27_non_const_fC_h[(__cuda_local_var_39386_6_non_const_i + 1572864)])) - (__cuda_local_var_39437_27_non_const_fC_h[(__cuda_local_var_39386_6_non_const_i + 1835008)])) - (__cuda_local_var_39437_27_non_const_fC_h[(__cuda_local_var_39386_6_non_const_i + 2097152)])) + (__cuda_local_var_39437_27_non_const_fC_h[(__cuda_local_var_39386_6_non_const_i + 2883584)])) - (__cuda_local_var_39437_27_non_const_fC_h[(__cuda_local_var_39386_6_non_const_i + 3407872)])) + (__cuda_local_var_39437_27_non_const_fC_h[(__cuda_local_var_39386_6_non_const_i + 4194304)])) - (__cuda_local_var_39437_27_non_const_fC_h[(__cuda_local_var_39386_6_non_const_i + 4718592)]));
__cuda_local_var_40019_19_non_const_w = ((((((((((__cuda_local_var_39437_27_non_const_fC_h[(__cuda_local_var_39386_6_non_const_i + 2359296)]) + (__cuda_local_var_39437_27_non_const_fC_h[(__cuda_local_var_39386_6_non_const_i + 2621440)])) + (__cuda_local_var_39437_27_non_const_fC_h[(__cuda_local_var_39386_6_non_const_i + 2883584)])) + (__cuda_local_var_39437_27_non_const_fC_h[(__cuda_local_var_39386_6_non_const_i + 3145728)])) + (__cuda_local_var_39437_27_non_const_fC_h[(__cuda_local_var_39386_6_non_const_i + 3407872)])) - (__cuda_local_var_39437_27_non_const_fC_h[(__cuda_local_var_39386_6_non_const_i + 3670016)])) - (__cuda_local_var_39437_27_non_const_fC_h[(__cuda_local_var_39386_6_non_const_i + 3932160)])) - (__cuda_local_var_39437_27_non_const_fC_h[(__cuda_local_var_39386_6_non_const_i + 4194304)])) - (__cuda_local_var_39437_27_non_const_fC_h[(__cuda_local_var_39386_6_non_const_i + 4456448)])) - (__cuda_local_var_39437_27_non_const_fC_h[(__cuda_local_var_39386_6_non_const_i + 4718592)]));
_ZNSolsEPFRSoS_E((_ZNSolsEf((_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc((_ZNSolsEf((_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc((_ZNSolsEf((_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc((_ZNSolsEf((_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc((_ZNSolsEf((_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc((_ZNSolsEf((_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc((_ZNSolsEf((((struct _ZSo *)&__cuda_local_var_39376_11_non_const_output)), ((15.75F) + (((float)__cuda_local_var_40016_6_non_const_col) * (0.5F))))), ((const char *)", "))), ((15.75F) + (((float)__cuda_local_var_40015_6_non_const_row) * (0.5F))))), ((const char *)", "))), ((15.75F) + (((float)__cuda_local_var_40017_6_non_const_dep) * (0.5F))))), ((const char *)", "))), __cuda_local_var_40019_13_non_const_u)), ((const char *)","))), __cuda_local_var_40019_16_non_const_v)), ((const char *)","))), __cuda_local_var_40019_19_non_const_w)), ((const char *)","))), __cuda_local_var_40019_8_non_const_rho)), _ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_);


}
}
}
}

_ZNSt14basic_ofstreamIcSt11char_traitsIcEE5closeEv((&__cuda_local_var_39376_11_non_const_output)); {


 int t;
# 5627 "MRT.cu"
t = 0; for (; (t < 500); t++) {
_ZNSolsEPFRSoS_E((_ZNSolsEf((_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc((_ZNSolsEf((_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc((_ZNSolsEf((_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc((_ZNSolsEi((((struct _ZSo *)&__cuda_local_var_39377_11_non_const_output2)), t)), ((const char *)", "))), ((__cuda_local_var_39438_9_non_const_FX_h[t]) / (0.1608489007F)))), ((const char *)", "))), ((__cuda_local_var_39438_15_non_const_FY_h[t]) / (0.1608489007F)))), ((const char *)", "))), ((__cuda_local_var_39438_21_non_const_FZ_h[t]) / (0.1608489007F)))), _ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_);


} }
_ZNSt14basic_ofstreamIcSt11char_traitsIcEE5closeEv((&__cuda_local_var_39377_11_non_const_output2));
# 5639 "MRT.cu"
cudaFree(((void *)__cuda_local_var_39437_15_non_const_fA_d));
cudaFree(((void *)__cuda_local_var_39437_21_non_const_fB_d));
cudaFree(((void *)__cuda_local_var_39437_33_non_const_fC_d));
cudaFree(((void *)__cuda_local_var_39437_39_non_const_fD_d)); {
_ZNSsD1Ev((&__cuda_local_var_39378_9_non_const_FileName)); _ZNSt14basic_ofstreamIcSt11char_traitsIcEED1Ev((&__cuda_local_var_39377_11_non_const_output2)); _ZNSt14basic_ofstreamIcSt11char_traitsIcEED1Ev((&__cuda_local_var_39376_11_non_const_output)); return 0; }

}
# 901 "/usr/local/cuda/bin/../include/cuda_runtime.h"
 __attribute__((__weak__)) /* COMDAT group: _Z22cudaFuncSetCacheConfigIFvPfS0_fmEE9cudaErrorPT_13cudaFuncCache */ __inline__ cudaError_t _Z22cudaFuncSetCacheConfigIFvPfS0_fmEE9cudaErrorPT_13cudaFuncCache(
void (*func)(float *, float *, float, size_t), 
enum cudaFuncCache cacheConfig)

{
return cudaFuncSetCacheConfig(((const char *)func), cacheConfig);
}
# 901 "/usr/local/cuda/bin/../include/cuda_runtime.h"
 __attribute__((__weak__)) /* COMDAT group: _Z22cudaFuncSetCacheConfigIFvPfS0_fmS0_S0_S0_iEE9cudaErrorPT_13cudaFuncCache */ __inline__ cudaError_t _Z22cudaFuncSetCacheConfigIFvPfS0_fmS0_S0_S0_iEE9cudaErrorPT_13cudaFuncCache(
void (*func)(float *, float *, float, size_t, float *, float *, float *, int), 
enum cudaFuncCache cacheConfig)

{
return cudaFuncSetCacheConfig(((const char *)func), cacheConfig);
}
# 901 "/usr/local/cuda/bin/../include/cuda_runtime.h"
 __attribute__((__weak__)) /* COMDAT group: _Z22cudaFuncSetCacheConfigIFvPfS0_fmiEE9cudaErrorPT_13cudaFuncCache */ __inline__ cudaError_t _Z22cudaFuncSetCacheConfigIFvPfS0_fmiEE9cudaErrorPT_13cudaFuncCache(
void (*func)(float *, float *, float, size_t, int), 
enum cudaFuncCache cacheConfig)

{
return cudaFuncSetCacheConfig(((const char *)func), cacheConfig);
}
# 901 "/usr/local/cuda/bin/../include/cuda_runtime.h"
 __attribute__((__weak__)) /* COMDAT group: _Z22cudaFuncSetCacheConfigIFvPfS0_fmfiEE9cudaErrorPT_13cudaFuncCache */ __inline__ cudaError_t _Z22cudaFuncSetCacheConfigIFvPfS0_fmfiEE9cudaErrorPT_13cudaFuncCache(
void (*func)(float *, float *, float, size_t, float, int), 
enum cudaFuncCache cacheConfig)

{
return cudaFuncSetCacheConfig(((const char *)func), cacheConfig);
}
# 901 "/usr/local/cuda/bin/../include/cuda_runtime.h"
 __attribute__((__weak__)) /* COMDAT group: _Z22cudaFuncSetCacheConfigIFvPfS0_fmfEE9cudaErrorPT_13cudaFuncCache */ __inline__ cudaError_t _Z22cudaFuncSetCacheConfigIFvPfS0_fmfEE9cudaErrorPT_13cudaFuncCache(
void (*func)(float *, float *, float, size_t, float), 
enum cudaFuncCache cacheConfig)

{
return cudaFuncSetCacheConfig(((const char *)func), cacheConfig);
}
# 901 "/usr/local/cuda/bin/../include/cuda_runtime.h"
 __attribute__((__weak__)) /* COMDAT group: _Z22cudaFuncSetCacheConfigIFvPfmfEE9cudaErrorPT_13cudaFuncCache */ __inline__ cudaError_t _Z22cudaFuncSetCacheConfigIFvPfmfEE9cudaErrorPT_13cudaFuncCache(
void (*func)(float *, size_t, float), 
enum cudaFuncCache cacheConfig)

{
return cudaFuncSetCacheConfig(((const char *)func), cacheConfig);
}
# 901 "/usr/local/cuda/bin/../include/cuda_runtime.h"
 __attribute__((__weak__)) /* COMDAT group: _Z22cudaFuncSetCacheConfigIFvPfS0_mEE9cudaErrorPT_13cudaFuncCache */ __inline__ cudaError_t _Z22cudaFuncSetCacheConfigIFvPfS0_mEE9cudaErrorPT_13cudaFuncCache(
void (*func)(float *, float *, size_t), 
enum cudaFuncCache cacheConfig)

{
return cudaFuncSetCacheConfig(((const char *)func), cacheConfig);
}
# 800 "/usr/local/cuda/bin/../include/cuda_runtime.h"
 __attribute__((__weak__)) /* COMDAT group: _Z17cudaUnbindTextureIfLi2EL19cudaTextureReadMode0EE9cudaErrorRK7textureIT_XT0_EXT1_EE */ __inline__ cudaError_t _Z17cudaUnbindTextureIfLi2EL19cudaTextureReadMode0EE9cudaErrorRK7textureIT_XT0_EXT1_EE(
const struct _Z7textureIfLi2EL19cudaTextureReadMode0EE *tex)

{
return cudaUnbindTexture((&(tex->__b_16textureReference)));
}
__asm__(".align 2");
# 76 "/usr/local/cuda/bin/../include/cuda_texture_types.h"
 __attribute__((__weak__)) /* COMDAT group: _ZN7textureIfLi2EL19cudaTextureReadMode0EEC1Ei21cudaTextureFilterMode22cudaTextureAddressMode */ __inline__ void _ZN7textureIfLi2EL19cudaTextureReadMode0EEC1Ei21cudaTextureFilterMode22cudaTextureAddressMode( struct _Z7textureIfLi2EL19cudaTextureReadMode0EE *const this,  int norm, 
enum cudaTextureFilterMode fMode, 
enum cudaTextureAddressMode aMode)
{  int __T22200;
((this->__b_16textureReference).normalized) = norm;
((this->__b_16textureReference).filterMode) = fMode;
((((this->__b_16textureReference).addressMode))[0]) = aMode;
((((this->__b_16textureReference).addressMode))[1]) = aMode;
((((this->__b_16textureReference).addressMode))[2]) = aMode;
((this->__b_16textureReference).channelDesc) = ((__T22200 = 32) , (cudaCreateChannelDesc(__T22200, 0, 0, 0, cudaChannelFormatKindFloat)));
((this->__b_16textureReference).sRGB) = 0; 
}
__asm__(".align 2");
 __attribute__((__weak__)) /* COMDAT group: _ZN7textureIfLi2EL19cudaTextureReadMode0EEC2Ei21cudaTextureFilterMode22cudaTextureAddressMode */ __inline__ void _ZN7textureIfLi2EL19cudaTextureReadMode0EEC2Ei21cudaTextureFilterMode22cudaTextureAddressMode( struct _Z7textureIfLi2EL19cudaTextureReadMode0EE *const this,  int __T22201,  enum cudaTextureFilterMode __T22202,  enum cudaTextureAddressMode __T22203) {  _ZN7textureIfLi2EL19cudaTextureReadMode0EEC1Ei21cudaTextureFilterMode22cudaTextureAddressMode(this, __T22201, __T22202, __T22203);  }
__asm__(".align 2");
# 101 "/usr/include/c++/4.4/bits/allocator.h" 3
extern __inline__ __attribute__((visibility("default"))) void _ZNSaIcEC1Ev( struct _ZSaIcE *const this) { { _ZN9__gnu_cxx13new_allocatorIcEC1Ev(((struct _ZN9__gnu_cxx13new_allocatorIcEE *)this)); }  }
__asm__(".align 2");
extern __inline__ __attribute__((visibility("default"))) void _ZNSaIcEC2Ev( struct _ZSaIcE *const this) {  _ZNSaIcEC1Ev(this);  }
__asm__(".align 2");




extern __inline__ __attribute__((visibility("default"))) void _ZNSaIcED1Ev( struct _ZSaIcE *const this) {  { { _ZN9__gnu_cxx13new_allocatorIcED1Ev(((struct _ZN9__gnu_cxx13new_allocatorIcEE *)this)); } }  }
__asm__(".align 2");
extern __inline__ __attribute__((visibility("default"))) void _ZNSaIcED2Ev( struct _ZSaIcE *const this) {  _ZNSaIcED1Ev(this);  }
__asm__(".align 2");
# 497 "/usr/include/c++/4.4/bits/basic_string.h" 3
extern __inline__ __attribute__((visibility("default"))) void _ZNSsD1Ev( struct _ZSs *const this)
{  _ZNSs14allocator_typeE __T22204;
 struct _ZNSs4_RepE *__T22205;
 const struct _ZSaIcE *__T22206;
 void *__T22207;
# 498 "/usr/include/c++/4.4/bits/basic_string.h" 3
(((__T22205 = (((struct _ZNSs4_RepE *)((((struct _ZSs *)((const struct _ZSs *)this))->_M_dataplus)._M_p)) + (-1))) , (void)(__T22206 = ((_ZN9__gnu_cxx13new_allocatorIcEC1ERKS1_(((struct _ZN9__gnu_cxx13new_allocatorIcEE *)(&__T22204)), ((const struct _ZN9__gnu_cxx13new_allocatorIcEE *)((struct _ZN9__gnu_cxx13new_allocatorIcEE *)((const struct _ZSaIcE *)(((struct _ZSaIcE *)&(((struct _ZSs *)((const struct _ZSs *)this))->_M_dataplus)))))))) , (((const struct _ZSaIcE *)&__T22204))))) , (void)((__builtin_expect(((long)(__T22205 != ((__T22207 = ((void *)_ZNSs4_Rep20_S_empty_rep_storageE)) , ((struct _ZNSs4_RepE *)__T22207)))), 0L)) ? (((_ZN9__gnu_cxx27__exchange_and_add_dispatchEPii((&((__T22205->__b_NSs9_Rep_baseE)._M_refcount)), (-1))) <= 0) ? (_ZNSs4_Rep10_M_destroyERKSaIcE(__T22205, __T22206)) : ((void)0)) : ((void)0))) , (void)(_ZN9__gnu_cxx13new_allocatorIcED1Ev(((struct _ZN9__gnu_cxx13new_allocatorIcEE *)(&__T22204)))); { { _ZNSaIcED1Ev(((struct _ZSaIcE *)(&(this->_M_dataplus)))); } }  }
__asm__(".align 2");
extern __inline__ __attribute__((visibility("default"))) void _ZNSsD2Ev( struct _ZSs *const this) {  _ZNSsD1Ev(this);  }
__asm__(".align 2");
# 1615 "/usr/include/c++/4.4/bits/basic_string.h" 3
extern __inline__ __attribute__((visibility("default"))) const char *_ZNKSs5c_strEv( const struct _ZSs *const this)
{ return (const char *)((((struct _ZSs *)this)->_M_dataplus)._M_p); }
__asm__(".align 2");
# 252 "/usr/include/c++/4.4/bits/basic_string.h" 3
 __attribute__((__weak__)) /* COMDAT group: _ZNSs12_Alloc_hiderD1Ev */ __inline__ __attribute__((visibility("default"))) void _ZNSs12_Alloc_hiderD1Ev( struct _ZNSs12_Alloc_hiderE *const this) {  { { _ZNSaIcED1Ev(((struct _ZSaIcE *)this)); } }  }
__asm__(".align 2");
 __attribute__((__weak__)) /* COMDAT group: _ZNSs12_Alloc_hiderD2Ev */ __inline__ __attribute__((visibility("default"))) void _ZNSs12_Alloc_hiderD2Ev( struct _ZNSs12_Alloc_hiderE *const this) {  _ZNSaIcED1Ev(((struct _ZSaIcE *)this));  }
__asm__(".align 2");
# 192 "/usr/include/c++/4.4/streambuf" 3
extern __inline__ __attribute__((visibility("default"))) void _ZNSt15basic_streambufIcSt11char_traitsIcEED1Ev( struct _ZSt15basic_streambufIcSt11char_traitsIcEE *const this)
{  (this->__vptr) = (_ZTVSt15basic_streambufIcSt11char_traitsIcEE + 2); { _ZNSt6localeD1Ev((&(this->_M_buf_locale))); }  }
__asm__(".align 2");
extern __inline__ __attribute__((visibility("default"))) void _ZNSt15basic_streambufIcSt11char_traitsIcEED0Ev( struct _ZSt15basic_streambufIcSt11char_traitsIcEE *const this) {  if (this) { _ZNSt15basic_streambufIcSt11char_traitsIcEED1Ev(this); _ZdlPv(((void *)this)); }  }
__asm__(".align 2");
extern __inline__ __attribute__((visibility("default"))) void _ZNSt15basic_streambufIcSt11char_traitsIcEED2Ev( struct _ZSt15basic_streambufIcSt11char_traitsIcEE *const this) {  _ZNSt15basic_streambufIcSt11char_traitsIcEED1Ev(this);  }
__asm__(".align 2");
# 865 "/usr/include/c++/4.4/bits/locale_facets.h" 3
 __attribute__((__weak__)) /* COMDAT group: _ZNKSt5ctypeIcE5widenEc */ __inline__ __attribute__((visibility("default"))) _ZNSt5ctypeIcE9char_typeE _ZNKSt5ctypeIcE5widenEc( const struct _ZSt5ctypeIcE *const this,  char __c)
{
if (((struct _ZSt5ctypeIcE *)this)->_M_widen_ok) {
return ((((struct _ZSt5ctypeIcE *)this)->_M_widen))[((unsigned char)__c)]; }
_ZNKSt5ctypeIcE13_M_widen_initEv(this);
return (*((_ZNSt5ctypeIcE9char_typeE (**)(const struct _ZSt5ctypeIcE *const, char))((((*(struct __SO__NSt6locale5facetE *)&(this->__b_NSt6locale5facetE___vptr))).__vptr) + 6)))(this, __c);
}
__asm__(".align 2");
# 272 "/usr/include/c++/4.4/bits/basic_ios.h" 3
extern __inline__ __attribute__((visibility("default"))) void _ZNSt9basic_iosIcSt11char_traitsIcEED1Ev( struct _ZSt9basic_iosIcSt11char_traitsIcEE *const this) {  ((this->__b_St8ios_base).__vptr) = (_ZTVSt9basic_iosIcSt11char_traitsIcEE + 2); { _ZNSt8ios_baseD2Ev((&(this->__b_St8ios_base))); }  }
__asm__(".align 2");
extern __inline__ __attribute__((visibility("default"))) void _ZNSt9basic_iosIcSt11char_traitsIcEED0Ev( struct _ZSt9basic_iosIcSt11char_traitsIcEE *const this) {  if (this) { _ZNSt9basic_iosIcSt11char_traitsIcEED1Ev(this); _ZdlPv(((void *)this)); }  }
__asm__(".align 2");
extern __inline__ __attribute__((visibility("default"))) void _ZNSt9basic_iosIcSt11char_traitsIcEED2Ev( struct _ZSt9basic_iosIcSt11char_traitsIcEE *const this) {  _ZNSt9basic_iosIcSt11char_traitsIcEED1Ev(this);  }
__asm__(".align 2");
# 450 "/usr/include/c++/4.4/bits/basic_ios.h" 3
extern __inline__ __attribute__((visibility("default"))) void _ZNSt9basic_iosIcSt11char_traitsIcEEC1Ev( struct _ZSt9basic_iosIcSt11char_traitsIcEE *const this)


{ _ZNSt8ios_baseC2Ev((&(this->__b_St8ios_base))); ((this->__b_St8ios_base).__vptr) = (_ZTVSt9basic_iosIcSt11char_traitsIcEE + 2); (this->_M_tie) = ((struct _ZSo *)0LL); (this->_M_fill) = ((_ZNSt9basic_iosIcSt11char_traitsIcEE9char_typeE)0); (this->_M_fill_init) = ((char)0); (this->_M_streambuf) = ((struct _ZSt15basic_streambufIcSt11char_traitsIcEE *)0LL); (this->_M_ctype) = ((const _ZNSt9basic_iosIcSt11char_traitsIcEE12__ctype_typeE *)0LL); (this->_M_num_put) = ((const _ZNSt9basic_iosIcSt11char_traitsIcEE14__num_put_typeE *)0LL); (this->_M_num_get) = ((const _ZNSt9basic_iosIcSt11char_traitsIcEE14__num_get_typeE *)0LL);  }
__asm__(".align 2");
extern __inline__ __attribute__((visibility("default"))) void _ZNSt9basic_iosIcSt11char_traitsIcEEC2Ev( struct _ZSt9basic_iosIcSt11char_traitsIcEE *const this) {  _ZNSt9basic_iosIcSt11char_traitsIcEEC1Ev(this);  }
__asm__(".align 2");
# 91 "/usr/include/c++/4.4/ostream" 3
extern __inline__ __attribute__((visibility("default"))) void _ZNSoD2Ev( struct _ZSo *const this,  const long *const *__T22208) {  (this->__vptr) = (*__T22208); ((((struct _ZSt9basic_iosIcSt11char_traitsIcEE *)(((char *)this) + ((this->__vptr)[(-3L)])))->__b_St8ios_base).__vptr) = (*(__T22208 + 1UL));  }
__asm__(".align 2");
extern __inline__ __attribute__((visibility("default"))) void _ZNSoD0Ev( struct _ZSo *const this) {  const long *const *__T22209;
if (this) { ((__T22209 = (_ZTTSo)) , (void)(_ZNSoD2Ev(this, __T22209))) , (void)(_ZNSt9basic_iosIcSt11char_traitsIcEED1Ev((&(this->__v_St9basic_iosIcSt11char_traitsIcEE)))); _ZdlPv(((void *)this)); }  }
__asm__(".align 2");
extern __inline__ __attribute__((visibility("default"))) void _ZNSoD1Ev( struct _ZSo *const this) {  const long *const *__T22210;
__T22210 = (_ZTTSo); _ZNSoD2Ev(this, __T22210);
# 91 "/usr/include/c++/4.4/ostream" 3
{ _ZNSt9basic_iosIcSt11char_traitsIcEED1Ev((&(this->__v_St9basic_iosIcSt11char_traitsIcEE))); }  }
__asm__(".align 2");
# 108 "/usr/include/c++/4.4/ostream" 3
extern __inline__ __attribute__((visibility("default"))) _ZNSo14__ostream_typeE *_ZNSolsEPFRSoS_E( struct _ZSo *const this,  _ZNSo14__ostream_typeE *(*__pf)(_ZNSo14__ostream_typeE *))
{



return __pf(this);
}
__asm__(".align 2");
# 169 "/usr/include/c++/4.4/ostream" 3
extern __inline__ __attribute__((visibility("default"))) _ZNSo14__ostream_typeE *_ZNSolsEm( struct _ZSo *const this,  unsigned long __n)
{ return _ZNSo9_M_insertImEERSoT_(this, __n); }
__asm__(".align 2");
# 209 "/usr/include/c++/4.4/ostream" 3
extern __inline__ __attribute__((visibility("default"))) _ZNSo14__ostream_typeE *_ZNSolsEd( struct _ZSo *const this,  double __f)
{ return _ZNSo9_M_insertIdEERSoT_(this, __f); }
__asm__(".align 2");

extern __inline__ __attribute__((visibility("default"))) _ZNSo14__ostream_typeE *_ZNSolsEf( struct _ZSo *const this,  float __f)
{


return _ZNSo9_M_insertIdEERSoT_(this, ((double)__f));
}
__asm__(".align 2");
# 214 "/usr/include/c++/4.4/fstream" 3
extern __inline__ __attribute__((visibility("default"))) void _ZNSt13basic_filebufIcSt11char_traitsIcEED1Ev( struct _ZSt13basic_filebufIcSt11char_traitsIcEE *const this)
{  ((this->__b_St15basic_streambufIcSt11char_traitsIcEE).__vptr) = (_ZTVSt13basic_filebufIcSt11char_traitsIcEE + 2); _ZNSt13basic_filebufIcSt11char_traitsIcEE5closeEv(this); { _ZNSt12__basic_fileIcED1Ev((&(this->_M_file))); { _ZNSt15basic_streambufIcSt11char_traitsIcEED1Ev((&(this->__b_St15basic_streambufIcSt11char_traitsIcEE))); } }  }
__asm__(".align 2");
extern __inline__ __attribute__((visibility("default"))) void _ZNSt13basic_filebufIcSt11char_traitsIcEED0Ev( struct _ZSt13basic_filebufIcSt11char_traitsIcEE *const this) {  if (this) { _ZNSt13basic_filebufIcSt11char_traitsIcEED1Ev(this); _ZdlPv(((void *)this)); }  }
__asm__(".align 2");
extern __inline__ __attribute__((visibility("default"))) void _ZNSt13basic_filebufIcSt11char_traitsIcEED2Ev( struct _ZSt13basic_filebufIcSt11char_traitsIcEE *const this) {  _ZNSt13basic_filebufIcSt11char_traitsIcEED1Ev(this);  }
__asm__(".align 2");
# 608 "/usr/include/c++/4.4/fstream" 3
extern __inline__ __attribute__((visibility("default"))) void _ZNSt14basic_ofstreamIcSt11char_traitsIcEEC2Ev( struct _ZSt14basic_ofstreamIcSt11char_traitsIcEE *const this,  const long *const *__T22211)
{ { (((struct _ZSo *)this)->__vptr) = (*(__T22211 + 1UL)); ((((struct _ZSt9basic_iosIcSt11char_traitsIcEE *)(((char *)((struct _ZSo *)this)) + ((((struct _ZSo *)this)->__vptr)[(-3L)])))->__b_St8ios_base).__vptr) = (*((__T22211 + 1UL) + 1UL)); _ZNSt9basic_iosIcSt11char_traitsIcEE4initEPSt15basic_streambufIcS1_E(((struct _ZSt9basic_iosIcSt11char_traitsIcEE *)(((char *)((struct _ZSo *)this)) + ((((struct _ZSo *)this)->__vptr)[(-3L)]))), ((struct _ZSt15basic_streambufIcSt11char_traitsIcEE *)0LL)); } ((this->__b_So).__vptr) = (*__T22211); ((((struct _ZSt9basic_iosIcSt11char_traitsIcEE *)(((char *)this) + (((this->__b_So).__vptr)[(-3L)])))->__b_St8ios_base).__vptr) = (*(__T22211 + 3UL)); _ZNSt13basic_filebufIcSt11char_traitsIcEEC1Ev((&(this->_M_filebuf))); _ZNSt9basic_iosIcSt11char_traitsIcEE4initEPSt15basic_streambufIcS1_E(((struct _ZSt9basic_iosIcSt11char_traitsIcEE *)(((char *)this) + (((this->__b_So).__vptr)[(-3L)]))), (&((this->_M_filebuf).__b_St15basic_streambufIcSt11char_traitsIcEE)));  }
__asm__(".align 2");
extern __inline__ __attribute__((visibility("default"))) void _ZNSt14basic_ofstreamIcSt11char_traitsIcEEC1Ev( struct _ZSt14basic_ofstreamIcSt11char_traitsIcEE *const this) {  const long *const *__T22212;
__T22212 = (_ZTTSt14basic_ofstreamIcSt11char_traitsIcEE); ((this->__b_So).__vptr) = (*__T22212);
# 609 "/usr/include/c++/4.4/fstream" 3
{ _ZNSt9basic_iosIcSt11char_traitsIcEEC1Ev((&(this->__v_St9basic_iosIcSt11char_traitsIcEE))); } _ZNSt14basic_ofstreamIcSt11char_traitsIcEEC2Ev(this, __T22212);  }
__asm__(".align 2");
# 656 "/usr/include/c++/4.4/fstream" 3
extern __inline__ __attribute__((visibility("default"))) void _ZNSt14basic_ofstreamIcSt11char_traitsIcEED2Ev( struct _ZSt14basic_ofstreamIcSt11char_traitsIcEE *const this,  const long *const *__T22213)
{  ((this->__b_So).__vptr) = (*__T22213); ((((struct _ZSt9basic_iosIcSt11char_traitsIcEE *)(((char *)this) + (((this->__b_So).__vptr)[(-3L)])))->__b_St8ios_base).__vptr) = (*(__T22213 + 3UL)); { { (((this->_M_filebuf).__b_St15basic_streambufIcSt11char_traitsIcEE).__vptr) = (_ZTVSt13basic_filebufIcSt11char_traitsIcEE + 2); _ZNSt13basic_filebufIcSt11char_traitsIcEE5closeEv((&(this->_M_filebuf))); { _ZNSt12__basic_fileIcED1Ev((&((this->_M_filebuf)._M_file))); { _ZNSt15basic_streambufIcSt11char_traitsIcEED1Ev((&((this->_M_filebuf).__b_St15basic_streambufIcSt11char_traitsIcEE))); } } } { (((struct _ZSo *)this)->__vptr) = (*(__T22213 + 1UL)); ((((struct _ZSt9basic_iosIcSt11char_traitsIcEE *)(((char *)((struct _ZSo *)this)) + ((((struct _ZSo *)this)->__vptr)[(-3L)])))->__b_St8ios_base).__vptr) = (*((__T22213 + 1UL) + 1UL)); } }  }
__asm__(".align 2");
extern __inline__ __attribute__((visibility("default"))) void _ZNSt14basic_ofstreamIcSt11char_traitsIcEED0Ev( struct _ZSt14basic_ofstreamIcSt11char_traitsIcEE *const this) {  const long *const *__T22214;
if (this) { ((__T22214 = (_ZTTSt14basic_ofstreamIcSt11char_traitsIcEE)) , (void)(_ZNSt14basic_ofstreamIcSt11char_traitsIcEED2Ev(this, __T22214))) , (void)(_ZNSt9basic_iosIcSt11char_traitsIcEED1Ev((&(this->__v_St9basic_iosIcSt11char_traitsIcEE)))); _ZdlPv(((void *)this)); }  }
__asm__(".align 2");
extern __inline__ __attribute__((visibility("default"))) void _ZNSt14basic_ofstreamIcSt11char_traitsIcEED1Ev( struct _ZSt14basic_ofstreamIcSt11char_traitsIcEE *const this) {  const long *const *__T22215;
__T22215 = (_ZTTSt14basic_ofstreamIcSt11char_traitsIcEE); _ZNSt14basic_ofstreamIcSt11char_traitsIcEED2Ev(this, __T22215);
# 657 "/usr/include/c++/4.4/fstream" 3
{ _ZNSt9basic_iosIcSt11char_traitsIcEED1Ev((&(this->__v_St9basic_iosIcSt11char_traitsIcEE))); }  }
__asm__(".align 2");
# 696 "/usr/include/c++/4.4/fstream" 3
extern __inline__ __attribute__((visibility("default"))) void _ZNSt14basic_ofstreamIcSt11char_traitsIcEE4openEPKcSt13_Ios_Openmode( struct _ZSt14basic_ofstreamIcSt11char_traitsIcEE *const this,  const char *__s, 
_ZNSt8ios_base8openmodeE __mode)
{  struct _ZSt9basic_iosIcSt11char_traitsIcEE *__T22216;
if (!(_ZNSt13basic_filebufIcSt11char_traitsIcEE4openEPKcSt13_Ios_Openmode((&(this->_M_filebuf)), __s, ((enum _ZSt13_Ios_Openmode)(((int)__mode) | ((int)_ZSt6_S_out)))))) {
{ __T22216 = ((struct _ZSt9basic_iosIcSt11char_traitsIcEE *)(((char *)this) + (((this->__b_So).__vptr)[(-3L)]))); { _ZNSt9basic_iosIcSt11char_traitsIcEE5clearESt12_Ios_Iostate(__T22216, ((enum _ZSt12_Ios_Iostate)(((int)((((const struct _ZSt9basic_iosIcSt11char_traitsIcEE *)__T22216)->__b_St8ios_base)._M_streambuf_state)) | ((int)((_ZNSt8ios_base7iostateE)4))))); } } } else  {



_ZNSt9basic_iosIcSt11char_traitsIcEE5clearESt12_Ios_Iostate(((struct _ZSt9basic_iosIcSt11char_traitsIcEE *)(((char *)this) + (((this->__b_So).__vptr)[(-3L)]))), ((_ZNSt8ios_base7iostateE)0)); } 
}
__asm__(".align 2");
# 736 "/usr/include/c++/4.4/fstream" 3
extern __inline__ __attribute__((visibility("default"))) void _ZNSt14basic_ofstreamIcSt11char_traitsIcEE5closeEv( struct _ZSt14basic_ofstreamIcSt11char_traitsIcEE *const this)
{  struct _ZSt9basic_iosIcSt11char_traitsIcEE *__T22217;
if (!(_ZNSt13basic_filebufIcSt11char_traitsIcEE5closeEv((&(this->_M_filebuf))))) {
{ __T22217 = ((struct _ZSt9basic_iosIcSt11char_traitsIcEE *)(((char *)this) + (((this->__b_So).__vptr)[(-3L)]))); { _ZNSt9basic_iosIcSt11char_traitsIcEE5clearESt12_Ios_Iostate(__T22217, ((enum _ZSt12_Ios_Iostate)(((int)((((const struct _ZSt9basic_iosIcSt11char_traitsIcEE *)__T22217)->__b_St8ios_base)._M_streambuf_state)) | ((int)((_ZNSt8ios_base7iostateE)4))))); } } } 
}
__asm__(".align 2");
# 66 "/usr/include/c++/4.4/ext/new_allocator.h" 3
 __attribute__((__weak__)) /* COMDAT group: _ZN9__gnu_cxx13new_allocatorIcEC1Ev */ __inline__ void _ZN9__gnu_cxx13new_allocatorIcEC1Ev( struct _ZN9__gnu_cxx13new_allocatorIcEE *const this) {   }
__asm__(".align 2");
 __attribute__((__weak__)) /* COMDAT group: _ZN9__gnu_cxx13new_allocatorIcEC2Ev */ __inline__ void _ZN9__gnu_cxx13new_allocatorIcEC2Ev( struct _ZN9__gnu_cxx13new_allocatorIcEE *const this) {  _ZN9__gnu_cxx13new_allocatorIcEC1Ev(this);  }
__asm__(".align 2");
# 68 "/usr/include/c++/4.4/ext/new_allocator.h" 3
 __attribute__((__weak__)) /* COMDAT group: _ZN9__gnu_cxx13new_allocatorIcEC1ERKS1_ */ __inline__ void _ZN9__gnu_cxx13new_allocatorIcEC1ERKS1_( struct _ZN9__gnu_cxx13new_allocatorIcEE *const this,  const struct _ZN9__gnu_cxx13new_allocatorIcEE *__T22218) {   }
__asm__(".align 2");
 __attribute__((__weak__)) /* COMDAT group: _ZN9__gnu_cxx13new_allocatorIcEC2ERKS1_ */ __inline__ void _ZN9__gnu_cxx13new_allocatorIcEC2ERKS1_( struct _ZN9__gnu_cxx13new_allocatorIcEE *const this,  const struct _ZN9__gnu_cxx13new_allocatorIcEE *__T22219) {  _ZN9__gnu_cxx13new_allocatorIcEC1ERKS1_(this, __T22219);  }
__asm__(".align 2");

 __attribute__((__weak__)) /* COMDAT group: _ZN9__gnu_cxx13new_allocatorIcED1Ev */ __inline__ void _ZN9__gnu_cxx13new_allocatorIcED1Ev( struct _ZN9__gnu_cxx13new_allocatorIcEE *const this) {   }
__asm__(".align 2");
 __attribute__((__weak__)) /* COMDAT group: _ZN9__gnu_cxx13new_allocatorIcED2Ev */ __inline__ void _ZN9__gnu_cxx13new_allocatorIcED2Ev( struct _ZN9__gnu_cxx13new_allocatorIcEE *const this) {  _ZN9__gnu_cxx13new_allocatorIcED1Ev(this);  }
# 538 "/usr/include/c++/4.4/ostream" 3
extern __inline__ struct _ZSo *_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_( struct _ZSo *__os)
{  const struct _ZSt9basic_iosIcSt11char_traitsIcEE *__T22220;
 const _ZNSt9basic_iosIcSt11char_traitsIcEE12__ctype_typeE *__T22221;
 struct _ZSo *__T22222;
# 539 "/usr/include/c++/4.4/ostream" 3
return (__T22222 = (_ZNSo3putEc(__os, ((__T22220 = ((const struct _ZSt9basic_iosIcSt11char_traitsIcEE *)((__os) ? ((struct _ZSt9basic_iosIcSt11char_traitsIcEE *)(((char *)__os) + ((__os->__vptr)[(-3L)]))) : ((struct _ZSt9basic_iosIcSt11char_traitsIcEE *)0LL)))) , (_ZNKSt5ctypeIcE5widenEc(((__T22221 = (__T22220->_M_ctype)) , (((!(__T22221)) ? (_ZSt16__throw_bad_castv()) : ((void)0)) , __T22221)), ((char)10))))))) , (_ZNSo5flushEv(__T22222)); }
# 505 "/usr/include/c++/4.4/ostream" 3
extern __inline__ struct _ZSo *_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc( struct _ZSo *__out,  const char *__s)
{  struct _ZSt9basic_iosIcSt11char_traitsIcEE *__T22223;
if (!(__s)) {
{ __T22223 = ((__out) ? ((struct _ZSt9basic_iosIcSt11char_traitsIcEE *)(((char *)__out) + ((__out->__vptr)[(-3L)]))) : ((struct _ZSt9basic_iosIcSt11char_traitsIcEE *)0LL)); { _ZNSt9basic_iosIcSt11char_traitsIcEE5clearESt12_Ios_Iostate(__T22223, ((enum _ZSt12_Ios_Iostate)(((int)((((const struct _ZSt9basic_iosIcSt11char_traitsIcEE *)__T22223)->__b_St8ios_base)._M_streambuf_state)) | ((int)((_ZNSt8ios_base7iostateE)1))))); } } } else  {

_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(__out, __s, ((_ZSt10streamsize)(__builtin_strlen(__s)))); }

return __out;
}
# 2201 "/usr/include/c++/4.4/bits/basic_string.h" 3
 __attribute__((__weak__)) /* COMDAT group: _ZStplIcSt11char_traitsIcESaIcEESbIT_T0_T1_ERKS6_PKS3_ */ __inline__ void _ZStplIcSt11char_traitsIcESaIcEESbIT_T0_T1_ERKS6_PKS3_( struct _ZSs *__T22224,  const struct _ZSs *__lhs, 
const char *__rhs)
{
_ZNSsC1ERKSs(__T22224, __lhs);
_ZNSs6appendEPKcm(__T22224, __rhs, (__builtin_strlen(__rhs)));
return;
}
# 75 "/usr/include/c++/4.4/ext/atomicity.h" 3
static __inline__ __attribute__((__unused__)) __attribute__((visibility("default"))) _Atomic_word _ZN9__gnu_cxx27__exchange_and_add_dispatchEPii( _Atomic_word *__mem,  int __val)
{  _Atomic_word __T22225;

if (_Z18__gthread_active_pv()) {
return (int)(__sync_fetch_and_add_4(((volatile void *)((volatile _Atomic_word *)__mem)), ((unsigned)__val))); } else  {

return ((__T22225 = (*__mem)) , (void)((*__mem) += __val)) , __T22225; }



}
static void __sti___11_MRT_cpp1_ii_887ef395(void) {
# 72 "/usr/include/c++/4.4/iostream" 3
_ZNSt8ios_base4InitC1Ev((&_ZSt8__ioinit)); __cxa_atexit(_ZNSt8ios_base4InitD1Ev, ((void *)(&_ZSt8__ioinit)), (&__dso_handle));
# 746 "MRT.cu"
_ZN7textureIfLi2EL19cudaTextureReadMode0EEC1Ei21cudaTextureFilterMode22cudaTextureAddressMode((&__text_var(texRef_f0A,texRef_f0A)), 0, cudaFilterModePoint, cudaAddressModeClamp);
_ZN7textureIfLi2EL19cudaTextureReadMode0EEC1Ei21cudaTextureFilterMode22cudaTextureAddressMode((&__text_var(texRef_f1A,texRef_f1A)), 0, cudaFilterModePoint, cudaAddressModeClamp);
_ZN7textureIfLi2EL19cudaTextureReadMode0EEC1Ei21cudaTextureFilterMode22cudaTextureAddressMode((&__text_var(texRef_f2A,texRef_f2A)), 0, cudaFilterModePoint, cudaAddressModeClamp);
_ZN7textureIfLi2EL19cudaTextureReadMode0EEC1Ei21cudaTextureFilterMode22cudaTextureAddressMode((&__text_var(texRef_f3A,texRef_f3A)), 0, cudaFilterModePoint, cudaAddressModeClamp);
_ZN7textureIfLi2EL19cudaTextureReadMode0EEC1Ei21cudaTextureFilterMode22cudaTextureAddressMode((&__text_var(texRef_f4A,texRef_f4A)), 0, cudaFilterModePoint, cudaAddressModeClamp);
_ZN7textureIfLi2EL19cudaTextureReadMode0EEC1Ei21cudaTextureFilterMode22cudaTextureAddressMode((&__text_var(texRef_f5A,texRef_f5A)), 0, cudaFilterModePoint, cudaAddressModeClamp);
_ZN7textureIfLi2EL19cudaTextureReadMode0EEC1Ei21cudaTextureFilterMode22cudaTextureAddressMode((&__text_var(texRef_f6A,texRef_f6A)), 0, cudaFilterModePoint, cudaAddressModeClamp);
_ZN7textureIfLi2EL19cudaTextureReadMode0EEC1Ei21cudaTextureFilterMode22cudaTextureAddressMode((&__text_var(texRef_f7A,texRef_f7A)), 0, cudaFilterModePoint, cudaAddressModeClamp);
_ZN7textureIfLi2EL19cudaTextureReadMode0EEC1Ei21cudaTextureFilterMode22cudaTextureAddressMode((&__text_var(texRef_f8A,texRef_f8A)), 0, cudaFilterModePoint, cudaAddressModeClamp);
_ZN7textureIfLi2EL19cudaTextureReadMode0EEC1Ei21cudaTextureFilterMode22cudaTextureAddressMode((&__text_var(texRef_f9A,texRef_f9A)), 0, cudaFilterModePoint, cudaAddressModeClamp);
_ZN7textureIfLi2EL19cudaTextureReadMode0EEC1Ei21cudaTextureFilterMode22cudaTextureAddressMode((&__text_var(texRef_f10A,texRef_f10A)), 0, cudaFilterModePoint, cudaAddressModeClamp);
_ZN7textureIfLi2EL19cudaTextureReadMode0EEC1Ei21cudaTextureFilterMode22cudaTextureAddressMode((&__text_var(texRef_f11A,texRef_f11A)), 0, cudaFilterModePoint, cudaAddressModeClamp);
_ZN7textureIfLi2EL19cudaTextureReadMode0EEC1Ei21cudaTextureFilterMode22cudaTextureAddressMode((&__text_var(texRef_f12A,texRef_f12A)), 0, cudaFilterModePoint, cudaAddressModeClamp);
_ZN7textureIfLi2EL19cudaTextureReadMode0EEC1Ei21cudaTextureFilterMode22cudaTextureAddressMode((&__text_var(texRef_f13A,texRef_f13A)), 0, cudaFilterModePoint, cudaAddressModeClamp);
_ZN7textureIfLi2EL19cudaTextureReadMode0EEC1Ei21cudaTextureFilterMode22cudaTextureAddressMode((&__text_var(texRef_f14A,texRef_f14A)), 0, cudaFilterModePoint, cudaAddressModeClamp);
_ZN7textureIfLi2EL19cudaTextureReadMode0EEC1Ei21cudaTextureFilterMode22cudaTextureAddressMode((&__text_var(texRef_f15A,texRef_f15A)), 0, cudaFilterModePoint, cudaAddressModeClamp);
_ZN7textureIfLi2EL19cudaTextureReadMode0EEC1Ei21cudaTextureFilterMode22cudaTextureAddressMode((&__text_var(texRef_f16A,texRef_f16A)), 0, cudaFilterModePoint, cudaAddressModeClamp);
_ZN7textureIfLi2EL19cudaTextureReadMode0EEC1Ei21cudaTextureFilterMode22cudaTextureAddressMode((&__text_var(texRef_f17A,texRef_f17A)), 0, cudaFilterModePoint, cudaAddressModeClamp);
_ZN7textureIfLi2EL19cudaTextureReadMode0EEC1Ei21cudaTextureFilterMode22cudaTextureAddressMode((&__text_var(texRef_f18A,texRef_f18A)), 0, cudaFilterModePoint, cudaAddressModeClamp);

_ZN7textureIfLi2EL19cudaTextureReadMode0EEC1Ei21cudaTextureFilterMode22cudaTextureAddressMode((&__text_var(texRef_f0B,texRef_f0B)), 0, cudaFilterModePoint, cudaAddressModeClamp);
_ZN7textureIfLi2EL19cudaTextureReadMode0EEC1Ei21cudaTextureFilterMode22cudaTextureAddressMode((&__text_var(texRef_f1B,texRef_f1B)), 0, cudaFilterModePoint, cudaAddressModeClamp);
_ZN7textureIfLi2EL19cudaTextureReadMode0EEC1Ei21cudaTextureFilterMode22cudaTextureAddressMode((&__text_var(texRef_f2B,texRef_f2B)), 0, cudaFilterModePoint, cudaAddressModeClamp);
_ZN7textureIfLi2EL19cudaTextureReadMode0EEC1Ei21cudaTextureFilterMode22cudaTextureAddressMode((&__text_var(texRef_f3B,texRef_f3B)), 0, cudaFilterModePoint, cudaAddressModeClamp);
_ZN7textureIfLi2EL19cudaTextureReadMode0EEC1Ei21cudaTextureFilterMode22cudaTextureAddressMode((&__text_var(texRef_f4B,texRef_f4B)), 0, cudaFilterModePoint, cudaAddressModeClamp);
_ZN7textureIfLi2EL19cudaTextureReadMode0EEC1Ei21cudaTextureFilterMode22cudaTextureAddressMode((&__text_var(texRef_f5B,texRef_f5B)), 0, cudaFilterModePoint, cudaAddressModeClamp);
_ZN7textureIfLi2EL19cudaTextureReadMode0EEC1Ei21cudaTextureFilterMode22cudaTextureAddressMode((&__text_var(texRef_f6B,texRef_f6B)), 0, cudaFilterModePoint, cudaAddressModeClamp);
_ZN7textureIfLi2EL19cudaTextureReadMode0EEC1Ei21cudaTextureFilterMode22cudaTextureAddressMode((&__text_var(texRef_f7B,texRef_f7B)), 0, cudaFilterModePoint, cudaAddressModeClamp);
_ZN7textureIfLi2EL19cudaTextureReadMode0EEC1Ei21cudaTextureFilterMode22cudaTextureAddressMode((&__text_var(texRef_f8B,texRef_f8B)), 0, cudaFilterModePoint, cudaAddressModeClamp);
_ZN7textureIfLi2EL19cudaTextureReadMode0EEC1Ei21cudaTextureFilterMode22cudaTextureAddressMode((&__text_var(texRef_f9B,texRef_f9B)), 0, cudaFilterModePoint, cudaAddressModeClamp);
_ZN7textureIfLi2EL19cudaTextureReadMode0EEC1Ei21cudaTextureFilterMode22cudaTextureAddressMode((&__text_var(texRef_f10B,texRef_f10B)), 0, cudaFilterModePoint, cudaAddressModeClamp);
_ZN7textureIfLi2EL19cudaTextureReadMode0EEC1Ei21cudaTextureFilterMode22cudaTextureAddressMode((&__text_var(texRef_f11B,texRef_f11B)), 0, cudaFilterModePoint, cudaAddressModeClamp);
_ZN7textureIfLi2EL19cudaTextureReadMode0EEC1Ei21cudaTextureFilterMode22cudaTextureAddressMode((&__text_var(texRef_f12B,texRef_f12B)), 0, cudaFilterModePoint, cudaAddressModeClamp);
_ZN7textureIfLi2EL19cudaTextureReadMode0EEC1Ei21cudaTextureFilterMode22cudaTextureAddressMode((&__text_var(texRef_f13B,texRef_f13B)), 0, cudaFilterModePoint, cudaAddressModeClamp);
_ZN7textureIfLi2EL19cudaTextureReadMode0EEC1Ei21cudaTextureFilterMode22cudaTextureAddressMode((&__text_var(texRef_f14B,texRef_f14B)), 0, cudaFilterModePoint, cudaAddressModeClamp);
_ZN7textureIfLi2EL19cudaTextureReadMode0EEC1Ei21cudaTextureFilterMode22cudaTextureAddressMode((&__text_var(texRef_f15B,texRef_f15B)), 0, cudaFilterModePoint, cudaAddressModeClamp);
_ZN7textureIfLi2EL19cudaTextureReadMode0EEC1Ei21cudaTextureFilterMode22cudaTextureAddressMode((&__text_var(texRef_f16B,texRef_f16B)), 0, cudaFilterModePoint, cudaAddressModeClamp);
_ZN7textureIfLi2EL19cudaTextureReadMode0EEC1Ei21cudaTextureFilterMode22cudaTextureAddressMode((&__text_var(texRef_f17B,texRef_f17B)), 0, cudaFilterModePoint, cudaAddressModeClamp);
_ZN7textureIfLi2EL19cudaTextureReadMode0EEC1Ei21cudaTextureFilterMode22cudaTextureAddressMode((&__text_var(texRef_f18B,texRef_f18B)), 0, cudaFilterModePoint, cudaAddressModeClamp);


_ZN7textureIfLi2EL19cudaTextureReadMode0EEC1Ei21cudaTextureFilterMode22cudaTextureAddressMode((&__text_var(texRef_f0C,texRef_f0C)), 0, cudaFilterModePoint, cudaAddressModeClamp);
_ZN7textureIfLi2EL19cudaTextureReadMode0EEC1Ei21cudaTextureFilterMode22cudaTextureAddressMode((&__text_var(texRef_f1C,texRef_f1C)), 0, cudaFilterModePoint, cudaAddressModeClamp);
_ZN7textureIfLi2EL19cudaTextureReadMode0EEC1Ei21cudaTextureFilterMode22cudaTextureAddressMode((&__text_var(texRef_f2C,texRef_f2C)), 0, cudaFilterModePoint, cudaAddressModeClamp);
_ZN7textureIfLi2EL19cudaTextureReadMode0EEC1Ei21cudaTextureFilterMode22cudaTextureAddressMode((&__text_var(texRef_f3C,texRef_f3C)), 0, cudaFilterModePoint, cudaAddressModeClamp);
_ZN7textureIfLi2EL19cudaTextureReadMode0EEC1Ei21cudaTextureFilterMode22cudaTextureAddressMode((&__text_var(texRef_f4C,texRef_f4C)), 0, cudaFilterModePoint, cudaAddressModeClamp);
_ZN7textureIfLi2EL19cudaTextureReadMode0EEC1Ei21cudaTextureFilterMode22cudaTextureAddressMode((&__text_var(texRef_f5C,texRef_f5C)), 0, cudaFilterModePoint, cudaAddressModeClamp);
_ZN7textureIfLi2EL19cudaTextureReadMode0EEC1Ei21cudaTextureFilterMode22cudaTextureAddressMode((&__text_var(texRef_f6C,texRef_f6C)), 0, cudaFilterModePoint, cudaAddressModeClamp);
_ZN7textureIfLi2EL19cudaTextureReadMode0EEC1Ei21cudaTextureFilterMode22cudaTextureAddressMode((&__text_var(texRef_f7C,texRef_f7C)), 0, cudaFilterModePoint, cudaAddressModeClamp);
_ZN7textureIfLi2EL19cudaTextureReadMode0EEC1Ei21cudaTextureFilterMode22cudaTextureAddressMode((&__text_var(texRef_f8C,texRef_f8C)), 0, cudaFilterModePoint, cudaAddressModeClamp);
_ZN7textureIfLi2EL19cudaTextureReadMode0EEC1Ei21cudaTextureFilterMode22cudaTextureAddressMode((&__text_var(texRef_f9C,texRef_f9C)), 0, cudaFilterModePoint, cudaAddressModeClamp);
_ZN7textureIfLi2EL19cudaTextureReadMode0EEC1Ei21cudaTextureFilterMode22cudaTextureAddressMode((&__text_var(texRef_f10C,texRef_f10C)), 0, cudaFilterModePoint, cudaAddressModeClamp);
_ZN7textureIfLi2EL19cudaTextureReadMode0EEC1Ei21cudaTextureFilterMode22cudaTextureAddressMode((&__text_var(texRef_f11C,texRef_f11C)), 0, cudaFilterModePoint, cudaAddressModeClamp);
_ZN7textureIfLi2EL19cudaTextureReadMode0EEC1Ei21cudaTextureFilterMode22cudaTextureAddressMode((&__text_var(texRef_f12C,texRef_f12C)), 0, cudaFilterModePoint, cudaAddressModeClamp);
_ZN7textureIfLi2EL19cudaTextureReadMode0EEC1Ei21cudaTextureFilterMode22cudaTextureAddressMode((&__text_var(texRef_f13C,texRef_f13C)), 0, cudaFilterModePoint, cudaAddressModeClamp);
_ZN7textureIfLi2EL19cudaTextureReadMode0EEC1Ei21cudaTextureFilterMode22cudaTextureAddressMode((&__text_var(texRef_f14C,texRef_f14C)), 0, cudaFilterModePoint, cudaAddressModeClamp);
_ZN7textureIfLi2EL19cudaTextureReadMode0EEC1Ei21cudaTextureFilterMode22cudaTextureAddressMode((&__text_var(texRef_f15C,texRef_f15C)), 0, cudaFilterModePoint, cudaAddressModeClamp);
_ZN7textureIfLi2EL19cudaTextureReadMode0EEC1Ei21cudaTextureFilterMode22cudaTextureAddressMode((&__text_var(texRef_f16C,texRef_f16C)), 0, cudaFilterModePoint, cudaAddressModeClamp);
_ZN7textureIfLi2EL19cudaTextureReadMode0EEC1Ei21cudaTextureFilterMode22cudaTextureAddressMode((&__text_var(texRef_f17C,texRef_f17C)), 0, cudaFilterModePoint, cudaAddressModeClamp);
_ZN7textureIfLi2EL19cudaTextureReadMode0EEC1Ei21cudaTextureFilterMode22cudaTextureAddressMode((&__text_var(texRef_f18C,texRef_f18C)), 0, cudaFilterModePoint, cudaAddressModeClamp);

_ZN7textureIfLi2EL19cudaTextureReadMode0EEC1Ei21cudaTextureFilterMode22cudaTextureAddressMode((&__text_var(texRef_f0D,texRef_f0D)), 0, cudaFilterModePoint, cudaAddressModeClamp);
_ZN7textureIfLi2EL19cudaTextureReadMode0EEC1Ei21cudaTextureFilterMode22cudaTextureAddressMode((&__text_var(texRef_f1D,texRef_f1D)), 0, cudaFilterModePoint, cudaAddressModeClamp);
_ZN7textureIfLi2EL19cudaTextureReadMode0EEC1Ei21cudaTextureFilterMode22cudaTextureAddressMode((&__text_var(texRef_f2D,texRef_f2D)), 0, cudaFilterModePoint, cudaAddressModeClamp);
_ZN7textureIfLi2EL19cudaTextureReadMode0EEC1Ei21cudaTextureFilterMode22cudaTextureAddressMode((&__text_var(texRef_f3D,texRef_f3D)), 0, cudaFilterModePoint, cudaAddressModeClamp);
_ZN7textureIfLi2EL19cudaTextureReadMode0EEC1Ei21cudaTextureFilterMode22cudaTextureAddressMode((&__text_var(texRef_f4D,texRef_f4D)), 0, cudaFilterModePoint, cudaAddressModeClamp);
_ZN7textureIfLi2EL19cudaTextureReadMode0EEC1Ei21cudaTextureFilterMode22cudaTextureAddressMode((&__text_var(texRef_f5D,texRef_f5D)), 0, cudaFilterModePoint, cudaAddressModeClamp);
_ZN7textureIfLi2EL19cudaTextureReadMode0EEC1Ei21cudaTextureFilterMode22cudaTextureAddressMode((&__text_var(texRef_f6D,texRef_f6D)), 0, cudaFilterModePoint, cudaAddressModeClamp);
_ZN7textureIfLi2EL19cudaTextureReadMode0EEC1Ei21cudaTextureFilterMode22cudaTextureAddressMode((&__text_var(texRef_f7D,texRef_f7D)), 0, cudaFilterModePoint, cudaAddressModeClamp);
_ZN7textureIfLi2EL19cudaTextureReadMode0EEC1Ei21cudaTextureFilterMode22cudaTextureAddressMode((&__text_var(texRef_f8D,texRef_f8D)), 0, cudaFilterModePoint, cudaAddressModeClamp);
_ZN7textureIfLi2EL19cudaTextureReadMode0EEC1Ei21cudaTextureFilterMode22cudaTextureAddressMode((&__text_var(texRef_f9D,texRef_f9D)), 0, cudaFilterModePoint, cudaAddressModeClamp);
_ZN7textureIfLi2EL19cudaTextureReadMode0EEC1Ei21cudaTextureFilterMode22cudaTextureAddressMode((&__text_var(texRef_f10D,texRef_f10D)), 0, cudaFilterModePoint, cudaAddressModeClamp);
_ZN7textureIfLi2EL19cudaTextureReadMode0EEC1Ei21cudaTextureFilterMode22cudaTextureAddressMode((&__text_var(texRef_f11D,texRef_f11D)), 0, cudaFilterModePoint, cudaAddressModeClamp);
_ZN7textureIfLi2EL19cudaTextureReadMode0EEC1Ei21cudaTextureFilterMode22cudaTextureAddressMode((&__text_var(texRef_f12D,texRef_f12D)), 0, cudaFilterModePoint, cudaAddressModeClamp);
_ZN7textureIfLi2EL19cudaTextureReadMode0EEC1Ei21cudaTextureFilterMode22cudaTextureAddressMode((&__text_var(texRef_f13D,texRef_f13D)), 0, cudaFilterModePoint, cudaAddressModeClamp);
_ZN7textureIfLi2EL19cudaTextureReadMode0EEC1Ei21cudaTextureFilterMode22cudaTextureAddressMode((&__text_var(texRef_f14D,texRef_f14D)), 0, cudaFilterModePoint, cudaAddressModeClamp);
_ZN7textureIfLi2EL19cudaTextureReadMode0EEC1Ei21cudaTextureFilterMode22cudaTextureAddressMode((&__text_var(texRef_f15D,texRef_f15D)), 0, cudaFilterModePoint, cudaAddressModeClamp);
_ZN7textureIfLi2EL19cudaTextureReadMode0EEC1Ei21cudaTextureFilterMode22cudaTextureAddressMode((&__text_var(texRef_f16D,texRef_f16D)), 0, cudaFilterModePoint, cudaAddressModeClamp);
_ZN7textureIfLi2EL19cudaTextureReadMode0EEC1Ei21cudaTextureFilterMode22cudaTextureAddressMode((&__text_var(texRef_f17D,texRef_f17D)), 0, cudaFilterModePoint, cudaAddressModeClamp);
_ZN7textureIfLi2EL19cudaTextureReadMode0EEC1Ei21cudaTextureFilterMode22cudaTextureAddressMode((&__text_var(texRef_f18D,texRef_f18D)), 0, cudaFilterModePoint, cudaAddressModeClamp);  }

#include "MRT.cudafe1.stub.c"
