#include "crt/host_runtime.h"
#include "MRT.fatbin.c"
extern void __device_stub__Z8testfuncPf(float *);
extern void __device_stub__Z11simple_copyPfS_m(float *, float *, size_t);
extern void __device_stub__Z11simple_textPfS_m(float *, float *, size_t);
extern void __device_stub__Z14ExtractFromC_dPfmf(float *, size_t, float);
extern void __device_stub__Z18LR_d_hybABCD_forcePfS_fmS_S_S_i(float *, float *, float, size_t, float *, float *, float *, int);
extern void __device_stub__Z18LR_d_hybBACD_forcePfS_fmS_S_S_i(float *, float *, float, size_t, float *, float *, float *, int);
extern void __device_stub__Z12LR_d_hybABCDPfS_fm(float *, float *, float, size_t);
extern void __device_stub__Z13LR_d_hybABCD2PfS_fmi(float *, float *, float, size_t, int);
extern void __device_stub__Z12LR_d_hybABDCPfS_fmf(float *, float *, float, size_t, float);
extern void __device_stub__Z13LR_d_hybABDC2PfS_fmfi(float *, float *, float, size_t, float, int);
extern void __device_stub__Z19LR_d_hybABDC_InterpPfS_fmf(float *, float *, float, size_t, float);
extern void __device_stub__Z12LR_d_hybBADCPfS_fmf(float *, float *, float, size_t, float);
extern void __device_stub__Z13LR_d_hybBADC2PfS_fmfi(float *, float *, float, size_t, float, int);
extern void __device_stub__Z19LR_d_hybBADC_InterpPfS_fmf(float *, float *, float, size_t, float);
extern void __device_stub__Z9LR_d_ABCDPfS_fm(float *, float *, float, size_t);
extern void __device_stub__Z9LR_d_ABDCPfS_fmf(float *, float *, float, size_t, float);
extern void __device_stub__Z9LR_d_BACDPfS_fm(float *, float *, float, size_t);
extern void __device_stub__Z9LR_d_BADCPfS_fmf(float *, float *, float, size_t, float);
extern void __device_stub__Z17mrt_d_hybAB_forcePfS_fmS_S_S_i(float *, float *, float, size_t, float *, float *, float *, int);
extern void __device_stub__Z17mrt_d_hybBA_forcePfS_fmS_S_S_i(float *, float *, float, size_t, float *, float *, float *, int);
extern void __device_stub__Z11mrt_d_hybABPfS_fm(float *, float *, float, size_t);
extern void __device_stub__Z11mrt_d_hybBAPfS_fm(float *, float *, float, size_t);
extern void __device_stub__Z12mrt_d_singlePfS_fm(float *, float *, float, size_t);
extern void __device_stub__Z17initialize_singlePfm(float *, size_t);
extern void __device_stub__Z13initialize_LRPfm(float *, size_t);
extern void __device_stub__Z10initializePfS_S_S_S_S_S_S_S_S_S_S_S_S_S_S_S_S_S_m(float *, float *, float *, float *, float *, float *, float *, float *, float *, float *, float *, float *, float *, float *, float *, float *, float *, float *, float *, size_t);
static void __sti____cudaRegisterAll_11_MRT_cpp1_ii_887ef395(void) __attribute__((__constructor__));
void __device_stub__Z8testfuncPf(float *__par0){__cudaSetupArgSimple(__par0, 0UL);__cudaLaunch(((char *)((void ( *)(float *))testfunc)));}
# 1428 "MRT.cu"
void testfunc( float *__cuda_0)
# 1429 "MRT.cu"
{__device_stub__Z8testfuncPf( __cuda_0);
# 1474 "MRT.cu"
}
# 1 "MRT.cudafe1.stub.c"
void __device_stub__Z11simple_copyPfS_m( float *__par0,  float *__par1,  size_t __par2) {  __cudaSetupArgSimple(__par0, 0UL); __cudaSetupArgSimple(__par1, 8UL); __cudaSetupArgSimple(__par2, 16UL); __cudaLaunch(((char *)((void ( *)(float *, float *, size_t))simple_copy))); }
# 1475 "MRT.cu"
void simple_copy( float *__cuda_0,float *__cuda_1,size_t __cuda_2)
# 1477 "MRT.cu"
{__device_stub__Z11simple_copyPfS_m( __cuda_0,__cuda_1,__cuda_2);
# 1485 "MRT.cu"
}
# 1 "MRT.cudafe1.stub.c"
void __device_stub__Z11simple_textPfS_m( float *__par0,  float *__par1,  size_t __par2) {  __cudaSetupArgSimple(__par0, 0UL); __cudaSetupArgSimple(__par1, 8UL); __cudaSetupArgSimple(__par2, 16UL); __cudaLaunch(((char *)((void ( *)(float *, float *, size_t))simple_text))); }
# 1486 "MRT.cu"
void simple_text( float *__cuda_0,float *__cuda_1,size_t __cuda_2)
# 1488 "MRT.cu"
{__device_stub__Z11simple_textPfS_m( __cuda_0,__cuda_1,__cuda_2);
# 1494 "MRT.cu"
}
# 1 "MRT.cudafe1.stub.c"
void __device_stub__Z14ExtractFromC_dPfmf( float *__par0,  size_t __par1,  float __par2) {  __cudaSetupArgSimple(__par0, 0UL); __cudaSetupArgSimple(__par1, 8UL); __cudaSetupArgSimple(__par2, 16UL); __cudaLaunch(((char *)((void ( *)(float *, size_t, float))ExtractFromC_d))); }
# 1496 "MRT.cu"
void ExtractFromC_d( float *__cuda_0,size_t __cuda_1,float __cuda_2)
# 1498 "MRT.cu"
{__device_stub__Z14ExtractFromC_dPfmf( __cuda_0,__cuda_1,__cuda_2);
# 1728 "MRT.cu"
}
# 1 "MRT.cudafe1.stub.c"
void __device_stub__Z18LR_d_hybABCD_forcePfS_fmS_S_S_i( float *__par0,  float *__par1,  float __par2,  size_t __par3,  float *__par4,  float *__par5,  float *__par6,  int __par7) {  __cudaSetupArgSimple(__par0, 0UL); __cudaSetupArgSimple(__par1, 8UL); __cudaSetupArgSimple(__par2, 16UL); __cudaSetupArgSimple(__par3, 24UL); __cudaSetupArgSimple(__par4, 32UL); __cudaSetupArgSimple(__par5, 40UL); __cudaSetupArgSimple(__par6, 48UL); __cudaSetupArgSimple(__par7, 56UL); __cudaLaunch(((char *)((void ( *)(float *, float *, float, size_t, float *, float *, float *, int))LR_d_hybABCD_force))); }
# 1729 "MRT.cu"
void LR_d_hybABCD_force( float *__cuda_0,float *__cuda_1,float __cuda_2,size_t __cuda_3,float *__cuda_4,float *__cuda_5,float *__cuda_6,int __cuda_7)
# 1731 "MRT.cu"
{__device_stub__Z18LR_d_hybABCD_forcePfS_fmS_S_S_i( __cuda_0,__cuda_1,__cuda_2,__cuda_3,__cuda_4,__cuda_5,__cuda_6,__cuda_7);
# 1879 "MRT.cu"
}
# 1 "MRT.cudafe1.stub.c"
void __device_stub__Z18LR_d_hybBACD_forcePfS_fmS_S_S_i( float *__par0,  float *__par1,  float __par2,  size_t __par3,  float *__par4,  float *__par5,  float *__par6,  int __par7) {  __cudaSetupArgSimple(__par0, 0UL); __cudaSetupArgSimple(__par1, 8UL); __cudaSetupArgSimple(__par2, 16UL); __cudaSetupArgSimple(__par3, 24UL); __cudaSetupArgSimple(__par4, 32UL); __cudaSetupArgSimple(__par5, 40UL); __cudaSetupArgSimple(__par6, 48UL); __cudaSetupArgSimple(__par7, 56UL); __cudaLaunch(((char *)((void ( *)(float *, float *, float, size_t, float *, float *, float *, int))LR_d_hybBACD_force))); }
# 1880 "MRT.cu"
void LR_d_hybBACD_force( float *__cuda_0,float *__cuda_1,float __cuda_2,size_t __cuda_3,float *__cuda_4,float *__cuda_5,float *__cuda_6,int __cuda_7)
# 1882 "MRT.cu"
{__device_stub__Z18LR_d_hybBACD_forcePfS_fmS_S_S_i( __cuda_0,__cuda_1,__cuda_2,__cuda_3,__cuda_4,__cuda_5,__cuda_6,__cuda_7);
# 2026 "MRT.cu"
}
# 1 "MRT.cudafe1.stub.c"
void __device_stub__Z12LR_d_hybABCDPfS_fm( float *__par0,  float *__par1,  float __par2,  size_t __par3) {  __cudaSetupArgSimple(__par0, 0UL); __cudaSetupArgSimple(__par1, 8UL); __cudaSetupArgSimple(__par2, 16UL); __cudaSetupArgSimple(__par3, 24UL); __cudaLaunch(((char *)((void ( *)(float *, float *, float, size_t))LR_d_hybABCD))); }
# 2027 "MRT.cu"
void LR_d_hybABCD( float *__cuda_0,float *__cuda_1,float __cuda_2,size_t __cuda_3)
# 2029 "MRT.cu"
{__device_stub__Z12LR_d_hybABCDPfS_fm( __cuda_0,__cuda_1,__cuda_2,__cuda_3);
# 2127 "MRT.cu"
}
# 1 "MRT.cudafe1.stub.c"
void __device_stub__Z13LR_d_hybABCD2PfS_fmi( float *__par0,  float *__par1,  float __par2,  size_t __par3,  int __par4) {  __cudaSetupArgSimple(__par0, 0UL); __cudaSetupArgSimple(__par1, 8UL); __cudaSetupArgSimple(__par2, 16UL); __cudaSetupArgSimple(__par3, 24UL); __cudaSetupArgSimple(__par4, 32UL); __cudaLaunch(((char *)((void ( *)(float *, float *, float, size_t, int))LR_d_hybABCD2))); }
# 2128 "MRT.cu"
void LR_d_hybABCD2( float *__cuda_0,float *__cuda_1,float __cuda_2,size_t __cuda_3,int __cuda_4)
# 2130 "MRT.cu"
{__device_stub__Z13LR_d_hybABCD2PfS_fmi( __cuda_0,__cuda_1,__cuda_2,__cuda_3,__cuda_4);
# 2227 "MRT.cu"
}
# 1 "MRT.cudafe1.stub.c"
void __device_stub__Z12LR_d_hybABDCPfS_fmf( float *__par0,  float *__par1,  float __par2,  size_t __par3,  float __par4) {  __cudaSetupArgSimple(__par0, 0UL); __cudaSetupArgSimple(__par1, 8UL); __cudaSetupArgSimple(__par2, 16UL); __cudaSetupArgSimple(__par3, 24UL); __cudaSetupArgSimple(__par4, 32UL); __cudaLaunch(((char *)((void ( *)(float *, float *, float, size_t, float))LR_d_hybABDC))); }
# 2228 "MRT.cu"
void LR_d_hybABDC( float *__cuda_0,float *__cuda_1,float __cuda_2,size_t __cuda_3,float __cuda_4)
# 2230 "MRT.cu"
{__device_stub__Z12LR_d_hybABDCPfS_fmf( __cuda_0,__cuda_1,__cuda_2,__cuda_3,__cuda_4);
# 2329 "MRT.cu"
}
# 1 "MRT.cudafe1.stub.c"
void __device_stub__Z13LR_d_hybABDC2PfS_fmfi( float *__par0,  float *__par1,  float __par2,  size_t __par3,  float __par4,  int __par5) {  __cudaSetupArgSimple(__par0, 0UL); __cudaSetupArgSimple(__par1, 8UL); __cudaSetupArgSimple(__par2, 16UL); __cudaSetupArgSimple(__par3, 24UL); __cudaSetupArgSimple(__par4, 32UL); __cudaSetupArgSimple(__par5, 36UL); __cudaLaunch(((char *)((void ( *)(float *, float *, float, size_t, float, int))LR_d_hybABDC2))); }
# 2330 "MRT.cu"
void LR_d_hybABDC2( float *__cuda_0,float *__cuda_1,float __cuda_2,size_t __cuda_3,float __cuda_4,int __cuda_5)
# 2332 "MRT.cu"
{__device_stub__Z13LR_d_hybABDC2PfS_fmfi( __cuda_0,__cuda_1,__cuda_2,__cuda_3,__cuda_4,__cuda_5);
# 2431 "MRT.cu"
}
# 1 "MRT.cudafe1.stub.c"
void __device_stub__Z19LR_d_hybABDC_InterpPfS_fmf( float *__par0,  float *__par1,  float __par2,  size_t __par3,  float __par4) {  __cudaSetupArgSimple(__par0, 0UL); __cudaSetupArgSimple(__par1, 8UL); __cudaSetupArgSimple(__par2, 16UL); __cudaSetupArgSimple(__par3, 24UL); __cudaSetupArgSimple(__par4, 32UL); __cudaLaunch(((char *)((void ( *)(float *, float *, float, size_t, float))LR_d_hybABDC_Interp))); }
# 2432 "MRT.cu"
void LR_d_hybABDC_Interp( float *__cuda_0,float *__cuda_1,float __cuda_2,size_t __cuda_3,float __cuda_4)
# 2434 "MRT.cu"
{__device_stub__Z19LR_d_hybABDC_InterpPfS_fmf( __cuda_0,__cuda_1,__cuda_2,__cuda_3,__cuda_4);
# 2738 "MRT.cu"
}
# 1 "MRT.cudafe1.stub.c"
void __device_stub__Z12LR_d_hybBADCPfS_fmf( float *__par0,  float *__par1,  float __par2,  size_t __par3,  float __par4) {  __cudaSetupArgSimple(__par0, 0UL); __cudaSetupArgSimple(__par1, 8UL); __cudaSetupArgSimple(__par2, 16UL); __cudaSetupArgSimple(__par3, 24UL); __cudaSetupArgSimple(__par4, 32UL); __cudaLaunch(((char *)((void ( *)(float *, float *, float, size_t, float))LR_d_hybBADC))); }
# 2739 "MRT.cu"
void LR_d_hybBADC( float *__cuda_0,float *__cuda_1,float __cuda_2,size_t __cuda_3,float __cuda_4)
# 2741 "MRT.cu"
{__device_stub__Z12LR_d_hybBADCPfS_fmf( __cuda_0,__cuda_1,__cuda_2,__cuda_3,__cuda_4);
# 2840 "MRT.cu"
}
# 1 "MRT.cudafe1.stub.c"
void __device_stub__Z13LR_d_hybBADC2PfS_fmfi( float *__par0,  float *__par1,  float __par2,  size_t __par3,  float __par4,  int __par5) {  __cudaSetupArgSimple(__par0, 0UL); __cudaSetupArgSimple(__par1, 8UL); __cudaSetupArgSimple(__par2, 16UL); __cudaSetupArgSimple(__par3, 24UL); __cudaSetupArgSimple(__par4, 32UL); __cudaSetupArgSimple(__par5, 36UL); __cudaLaunch(((char *)((void ( *)(float *, float *, float, size_t, float, int))LR_d_hybBADC2))); }
# 2841 "MRT.cu"
void LR_d_hybBADC2( float *__cuda_0,float *__cuda_1,float __cuda_2,size_t __cuda_3,float __cuda_4,int __cuda_5)
# 2843 "MRT.cu"
{__device_stub__Z13LR_d_hybBADC2PfS_fmfi( __cuda_0,__cuda_1,__cuda_2,__cuda_3,__cuda_4,__cuda_5);
# 2942 "MRT.cu"
}
# 1 "MRT.cudafe1.stub.c"
void __device_stub__Z19LR_d_hybBADC_InterpPfS_fmf( float *__par0,  float *__par1,  float __par2,  size_t __par3,  float __par4) {  __cudaSetupArgSimple(__par0, 0UL); __cudaSetupArgSimple(__par1, 8UL); __cudaSetupArgSimple(__par2, 16UL); __cudaSetupArgSimple(__par3, 24UL); __cudaSetupArgSimple(__par4, 32UL); __cudaLaunch(((char *)((void ( *)(float *, float *, float, size_t, float))LR_d_hybBADC_Interp))); }
# 2943 "MRT.cu"
void LR_d_hybBADC_Interp( float *__cuda_0,float *__cuda_1,float __cuda_2,size_t __cuda_3,float __cuda_4)
# 2945 "MRT.cu"
{__device_stub__Z19LR_d_hybBADC_InterpPfS_fmf( __cuda_0,__cuda_1,__cuda_2,__cuda_3,__cuda_4);
# 3246 "MRT.cu"
}
# 1 "MRT.cudafe1.stub.c"
void __device_stub__Z9LR_d_ABCDPfS_fm( float *__par0,  float *__par1,  float __par2,  size_t __par3) {  __cudaSetupArgSimple(__par0, 0UL); __cudaSetupArgSimple(__par1, 8UL); __cudaSetupArgSimple(__par2, 16UL); __cudaSetupArgSimple(__par3, 24UL); __cudaLaunch(((char *)((void ( *)(float *, float *, float, size_t))LR_d_ABCD))); }
# 3248 "MRT.cu"
void LR_d_ABCD( float *__cuda_0,float *__cuda_1,float __cuda_2,size_t __cuda_3)
# 3250 "MRT.cu"
{__device_stub__Z9LR_d_ABCDPfS_fm( __cuda_0,__cuda_1,__cuda_2,__cuda_3);
# 3338 "MRT.cu"
}
# 1 "MRT.cudafe1.stub.c"
void __device_stub__Z9LR_d_ABDCPfS_fmf( float *__par0,  float *__par1,  float __par2,  size_t __par3,  float __par4) {  __cudaSetupArgSimple(__par0, 0UL); __cudaSetupArgSimple(__par1, 8UL); __cudaSetupArgSimple(__par2, 16UL); __cudaSetupArgSimple(__par3, 24UL); __cudaSetupArgSimple(__par4, 32UL); __cudaLaunch(((char *)((void ( *)(float *, float *, float, size_t, float))LR_d_ABDC))); }
# 3340 "MRT.cu"
void LR_d_ABDC( float *__cuda_0,float *__cuda_1,float __cuda_2,size_t __cuda_3,float __cuda_4)
# 3342 "MRT.cu"
{__device_stub__Z9LR_d_ABDCPfS_fmf( __cuda_0,__cuda_1,__cuda_2,__cuda_3,__cuda_4);
# 3533 "MRT.cu"
}
# 1 "MRT.cudafe1.stub.c"
void __device_stub__Z9LR_d_BACDPfS_fm( float *__par0,  float *__par1,  float __par2,  size_t __par3) {  __cudaSetupArgSimple(__par0, 0UL); __cudaSetupArgSimple(__par1, 8UL); __cudaSetupArgSimple(__par2, 16UL); __cudaSetupArgSimple(__par3, 24UL); __cudaLaunch(((char *)((void ( *)(float *, float *, float, size_t))LR_d_BACD))); }
# 3535 "MRT.cu"
void LR_d_BACD( float *__cuda_0,float *__cuda_1,float __cuda_2,size_t __cuda_3)
# 3537 "MRT.cu"
{__device_stub__Z9LR_d_BACDPfS_fm( __cuda_0,__cuda_1,__cuda_2,__cuda_3);
# 3625 "MRT.cu"
}
# 1 "MRT.cudafe1.stub.c"
void __device_stub__Z9LR_d_BADCPfS_fmf( float *__par0,  float *__par1,  float __par2,  size_t __par3,  float __par4) {  __cudaSetupArgSimple(__par0, 0UL); __cudaSetupArgSimple(__par1, 8UL); __cudaSetupArgSimple(__par2, 16UL); __cudaSetupArgSimple(__par3, 24UL); __cudaSetupArgSimple(__par4, 32UL); __cudaLaunch(((char *)((void ( *)(float *, float *, float, size_t, float))LR_d_BADC))); }
# 3627 "MRT.cu"
void LR_d_BADC( float *__cuda_0,float *__cuda_1,float __cuda_2,size_t __cuda_3,float __cuda_4)
# 3629 "MRT.cu"
{__device_stub__Z9LR_d_BADCPfS_fmf( __cuda_0,__cuda_1,__cuda_2,__cuda_3,__cuda_4);
# 3820 "MRT.cu"
}
# 1 "MRT.cudafe1.stub.c"
void __device_stub__Z17mrt_d_hybAB_forcePfS_fmS_S_S_i( float *__par0,  float *__par1,  float __par2,  size_t __par3,  float *__par4,  float *__par5,  float *__par6,  int __par7) {  __cudaSetupArgSimple(__par0, 0UL); __cudaSetupArgSimple(__par1, 8UL); __cudaSetupArgSimple(__par2, 16UL); __cudaSetupArgSimple(__par3, 24UL); __cudaSetupArgSimple(__par4, 32UL); __cudaSetupArgSimple(__par5, 40UL); __cudaSetupArgSimple(__par6, 48UL); __cudaSetupArgSimple(__par7, 56UL); __cudaLaunch(((char *)((void ( *)(float *, float *, float, size_t, float *, float *, float *, int))mrt_d_hybAB_force))); }
# 3821 "MRT.cu"
void mrt_d_hybAB_force( float *__cuda_0,float *__cuda_1,float __cuda_2,size_t __cuda_3,float *__cuda_4,float *__cuda_5,float *__cuda_6,int __cuda_7)
# 3823 "MRT.cu"
{__device_stub__Z17mrt_d_hybAB_forcePfS_fmS_S_S_i( __cuda_0,__cuda_1,__cuda_2,__cuda_3,__cuda_4,__cuda_5,__cuda_6,__cuda_7);
# 3991 "MRT.cu"
}
# 1 "MRT.cudafe1.stub.c"
void __device_stub__Z17mrt_d_hybBA_forcePfS_fmS_S_S_i( float *__par0,  float *__par1,  float __par2,  size_t __par3,  float *__par4,  float *__par5,  float *__par6,  int __par7) {  __cudaSetupArgSimple(__par0, 0UL); __cudaSetupArgSimple(__par1, 8UL); __cudaSetupArgSimple(__par2, 16UL); __cudaSetupArgSimple(__par3, 24UL); __cudaSetupArgSimple(__par4, 32UL); __cudaSetupArgSimple(__par5, 40UL); __cudaSetupArgSimple(__par6, 48UL); __cudaSetupArgSimple(__par7, 56UL); __cudaLaunch(((char *)((void ( *)(float *, float *, float, size_t, float *, float *, float *, int))mrt_d_hybBA_force))); }
# 3992 "MRT.cu"
void mrt_d_hybBA_force( float *__cuda_0,float *__cuda_1,float __cuda_2,size_t __cuda_3,float *__cuda_4,float *__cuda_5,float *__cuda_6,int __cuda_7)
# 3994 "MRT.cu"
{__device_stub__Z17mrt_d_hybBA_forcePfS_fmS_S_S_i( __cuda_0,__cuda_1,__cuda_2,__cuda_3,__cuda_4,__cuda_5,__cuda_6,__cuda_7);
# 4164 "MRT.cu"
}
# 1 "MRT.cudafe1.stub.c"
void __device_stub__Z11mrt_d_hybABPfS_fm( float *__par0,  float *__par1,  float __par2,  size_t __par3) {  __cudaSetupArgSimple(__par0, 0UL); __cudaSetupArgSimple(__par1, 8UL); __cudaSetupArgSimple(__par2, 16UL); __cudaSetupArgSimple(__par3, 24UL); __cudaLaunch(((char *)((void ( *)(float *, float *, float, size_t))mrt_d_hybAB))); }
# 4166 "MRT.cu"
void mrt_d_hybAB( float *__cuda_0,float *__cuda_1,float __cuda_2,size_t __cuda_3)
# 4168 "MRT.cu"
{__device_stub__Z11mrt_d_hybABPfS_fm( __cuda_0,__cuda_1,__cuda_2,__cuda_3);
# 4344 "MRT.cu"
}
# 1 "MRT.cudafe1.stub.c"
void __device_stub__Z11mrt_d_hybBAPfS_fm( float *__par0,  float *__par1,  float __par2,  size_t __par3) {  __cudaSetupArgSimple(__par0, 0UL); __cudaSetupArgSimple(__par1, 8UL); __cudaSetupArgSimple(__par2, 16UL); __cudaSetupArgSimple(__par3, 24UL); __cudaLaunch(((char *)((void ( *)(float *, float *, float, size_t))mrt_d_hybBA))); }
# 4498 "MRT.cu"
void mrt_d_hybBA( float *__cuda_0,float *__cuda_1,float __cuda_2,size_t __cuda_3)
# 4500 "MRT.cu"
{__device_stub__Z11mrt_d_hybBAPfS_fm( __cuda_0,__cuda_1,__cuda_2,__cuda_3);
# 4637 "MRT.cu"
}
# 1 "MRT.cudafe1.stub.c"
void __device_stub__Z12mrt_d_singlePfS_fm( float *__par0,  float *__par1,  float __par2,  size_t __par3) {  __cudaSetupArgSimple(__par0, 0UL); __cudaSetupArgSimple(__par1, 8UL); __cudaSetupArgSimple(__par2, 16UL); __cudaSetupArgSimple(__par3, 24UL); __cudaLaunch(((char *)((void ( *)(float *, float *, float, size_t))mrt_d_single))); }
# 4640 "MRT.cu"
void mrt_d_single( float *__cuda_0,float *__cuda_1,float __cuda_2,size_t __cuda_3)
# 4642 "MRT.cu"
{__device_stub__Z12mrt_d_singlePfS_fm( __cuda_0,__cuda_1,__cuda_2,__cuda_3);
# 4730 "MRT.cu"
}
# 1 "MRT.cudafe1.stub.c"
void __device_stub__Z17initialize_singlePfm( float *__par0,  size_t __par1) {  __cudaSetupArgSimple(__par0, 0UL); __cudaSetupArgSimple(__par1, 8UL); __cudaLaunch(((char *)((void ( *)(float *, size_t))initialize_single))); }
# 4743 "MRT.cu"
void initialize_single( float *__cuda_0,size_t __cuda_1)
# 4744 "MRT.cu"
{__device_stub__Z17initialize_singlePfm( __cuda_0,__cuda_1);
# 4803 "MRT.cu"
}
# 1 "MRT.cudafe1.stub.c"
void __device_stub__Z13initialize_LRPfm( float *__par0,  size_t __par1) {  __cudaSetupArgSimple(__par0, 0UL); __cudaSetupArgSimple(__par1, 8UL); __cudaLaunch(((char *)((void ( *)(float *, size_t))initialize_LR))); }
# 4804 "MRT.cu"
void initialize_LR( float *__cuda_0,size_t __cuda_1)
# 4805 "MRT.cu"
{__device_stub__Z13initialize_LRPfm( __cuda_0,__cuda_1);
# 4838 "MRT.cu"
}
# 1 "MRT.cudafe1.stub.c"
void __device_stub__Z10initializePfS_S_S_S_S_S_S_S_S_S_S_S_S_S_S_S_S_S_m( float *__par0,  float *__par1,  float *__par2,  float *__par3,  float *__par4,  float *__par5,  float *__par6,  float *__par7,  float *__par8,  float *__par9,  float *__par10,  float *__par11,  float *__par12,  float *__par13,  float *__par14,  float *__par15,  float *__par16,  float *__par17,  float *__par18,  size_t __par19) {  __cudaSetupArgSimple(__par0, 0UL); __cudaSetupArgSimple(__par1, 8UL); __cudaSetupArgSimple(__par2, 16UL); __cudaSetupArgSimple(__par3, 24UL); __cudaSetupArgSimple(__par4, 32UL); __cudaSetupArgSimple(__par5, 40UL); __cudaSetupArgSimple(__par6, 48UL); __cudaSetupArgSimple(__par7, 56UL); __cudaSetupArgSimple(__par8, 64UL); __cudaSetupArgSimple(__par9, 72UL); __cudaSetupArgSimple(__par10, 80UL); __cudaSetupArgSimple(__par11, 88UL); __cudaSetupArgSimple(__par12, 96UL); __cudaSetupArgSimple(__par13, 104UL); __cudaSetupArgSimple(__par14, 112UL); __cudaSetupArgSimple(__par15, 120UL); __cudaSetupArgSimple(__par16, 128UL); __cudaSetupArgSimple(__par17, 136UL); __cudaSetupArgSimple(__par18, 144UL); __cudaSetupArgSimple(__par19, 152UL); __cudaLaunch(((char *)((void ( *)(float *, float *, float *, float *, float *, float *, float *, float *, float *, float *, float *, float *, float *, float *, float *, float *, float *, float *, float *, size_t))initialize))); }
# 4839 "MRT.cu"
void initialize( float *__cuda_0,float *__cuda_1,float *__cuda_2,float *__cuda_3,float *__cuda_4,float *__cuda_5,float *__cuda_6,float *__cuda_7,float *__cuda_8,float *__cuda_9,float *__cuda_10,float *__cuda_11,float *__cuda_12,float *__cuda_13,float *__cuda_14,float *__cuda_15,float *__cuda_16,float *__cuda_17,float *__cuda_18,size_t __cuda_19)
# 4848 "MRT.cu"
{__device_stub__Z10initializePfS_S_S_S_S_S_S_S_S_S_S_S_S_S_S_S_S_S_m( __cuda_0,__cuda_1,__cuda_2,__cuda_3,__cuda_4,__cuda_5,__cuda_6,__cuda_7,__cuda_8,__cuda_9,__cuda_10,__cuda_11,__cuda_12,__cuda_13,__cuda_14,__cuda_15,__cuda_16,__cuda_17,__cuda_18,__cuda_19);
# 4903 "MRT.cu"
}
# 1 "MRT.cudafe1.stub.c"
static void __sti____cudaRegisterAll_11_MRT_cpp1_ii_887ef395(void) {  __cudaRegisterBinary(); __cudaRegisterEntry(((void ( *)(float *, float *, float *, float *, float *, float *, float *, float *, float *, float *, float *, float *, float *, float *, float *, float *, float *, float *, float *, size_t))initialize), _Z10initializePfS_S_S_S_S_S_S_S_S_S_S_S_S_S_S_S_S_S_m, (-1)); __cudaRegisterEntry(((void ( *)(float *, size_t))initialize_LR), _Z13initialize_LRPfm, (-1)); __cudaRegisterEntry(((void ( *)(float *, size_t))initialize_single), _Z17initialize_singlePfm, (-1)); __cudaRegisterEntry(((void ( *)(float *, float *, float, size_t))mrt_d_single), _Z12mrt_d_singlePfS_fm, (-1)); __cudaRegisterEntry(((void ( *)(float *, float *, float, size_t))mrt_d_hybBA), _Z11mrt_d_hybBAPfS_fm, (-1)); __cudaRegisterEntry(((void ( *)(float *, float *, float, size_t))mrt_d_hybAB), _Z11mrt_d_hybABPfS_fm, (-1)); __cudaRegisterEntry(((void ( *)(float *, float *, float, size_t, float *, float *, float *, int))mrt_d_hybBA_force), _Z17mrt_d_hybBA_forcePfS_fmS_S_S_i, (-1)); __cudaRegisterEntry(((void ( *)(float *, float *, float, size_t, float *, float *, float *, int))mrt_d_hybAB_force), _Z17mrt_d_hybAB_forcePfS_fmS_S_S_i, (-1)); __cudaRegisterEntry(((void ( *)(float *, float *, float, size_t, float))LR_d_BADC), _Z9LR_d_BADCPfS_fmf, (-1)); __cudaRegisterEntry(((void ( *)(float *, float *, float, size_t))LR_d_BACD), _Z9LR_d_BACDPfS_fm, (-1)); __cudaRegisterEntry(((void ( *)(float *, float *, float, size_t, float))LR_d_ABDC), _Z9LR_d_ABDCPfS_fmf, (-1)); __cudaRegisterEntry(((void ( *)(float *, float *, float, size_t))LR_d_ABCD), _Z9LR_d_ABCDPfS_fm, (-1)); __cudaRegisterEntry(((void ( *)(float *, float *, float, size_t, float))LR_d_hybBADC_Interp), _Z19LR_d_hybBADC_InterpPfS_fmf, (-1)); __cudaRegisterEntry(((void ( *)(float *, float *, float, size_t, float, int))LR_d_hybBADC2), _Z13LR_d_hybBADC2PfS_fmfi, (-1)); __cudaRegisterEntry(((void ( *)(float *, float *, float, size_t, float))LR_d_hybBADC), _Z12LR_d_hybBADCPfS_fmf, (-1)); __cudaRegisterEntry(((void ( *)(float *, float *, float, size_t, float))LR_d_hybABDC_Interp), _Z19LR_d_hybABDC_InterpPfS_fmf, (-1)); __cudaRegisterEntry(((void ( *)(float *, float *, float, size_t, float, int))LR_d_hybABDC2), _Z13LR_d_hybABDC2PfS_fmfi, (-1)); __cudaRegisterEntry(((void ( *)(float *, float *, float, size_t, float))LR_d_hybABDC), _Z12LR_d_hybABDCPfS_fmf, (-1)); __cudaRegisterEntry(((void ( *)(float *, float *, float, size_t, int))LR_d_hybABCD2), _Z13LR_d_hybABCD2PfS_fmi, (-1)); __cudaRegisterEntry(((void ( *)(float *, float *, float, size_t))LR_d_hybABCD), _Z12LR_d_hybABCDPfS_fm, (-1)); __cudaRegisterEntry(((void ( *)(float *, float *, float, size_t, float *, float *, float *, int))LR_d_hybBACD_force), _Z18LR_d_hybBACD_forcePfS_fmS_S_S_i, (-1)); __cudaRegisterEntry(((void ( *)(float *, float *, float, size_t, float *, float *, float *, int))LR_d_hybABCD_force), _Z18LR_d_hybABCD_forcePfS_fmS_S_S_i, (-1)); __cudaRegisterEntry(((void ( *)(float *, size_t, float))ExtractFromC_d), _Z14ExtractFromC_dPfmf, (-1)); __cudaRegisterEntry(((void ( *)(float *, float *, size_t))simple_text), _Z11simple_textPfS_m, (-1)); __cudaRegisterEntry(((void ( *)(float *, float *, size_t))simple_copy), _Z11simple_copyPfS_m, (-1)); __cudaRegisterEntry(((void ( *)(float *))testfunc), _Z8testfuncPf, (-1)); __cudaRegisterGlobalTexture(__text_var(texRef_f0A,texRef_f0A), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f1A,texRef_f1A), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f2A,texRef_f2A), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f3A,texRef_f3A), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f4A,texRef_f4A), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f5A,texRef_f5A), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f6A,texRef_f6A), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f7A,texRef_f7A), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f8A,texRef_f8A), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f9A,texRef_f9A), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f10A,texRef_f10A), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f11A,texRef_f11A), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f12A,texRef_f12A), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f13A,texRef_f13A), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f14A,texRef_f14A), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f15A,texRef_f15A), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f16A,texRef_f16A), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f17A,texRef_f17A), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f18A,texRef_f18A), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f0B,texRef_f0B), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f1B,texRef_f1B), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f2B,texRef_f2B), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f3B,texRef_f3B), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f4B,texRef_f4B), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f5B,texRef_f5B), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f6B,texRef_f6B), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f7B,texRef_f7B), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f8B,texRef_f8B), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f9B,texRef_f9B), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f10B,texRef_f10B), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f11B,texRef_f11B), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f12B,texRef_f12B), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f13B,texRef_f13B), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f14B,texRef_f14B), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f15B,texRef_f15B), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f16B,texRef_f16B), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f17B,texRef_f17B), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f18B,texRef_f18B), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f0C,texRef_f0C), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f1C,texRef_f1C), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f2C,texRef_f2C), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f3C,texRef_f3C), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f4C,texRef_f4C), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f5C,texRef_f5C), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f6C,texRef_f6C), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f7C,texRef_f7C), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f8C,texRef_f8C), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f9C,texRef_f9C), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f10C,texRef_f10C), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f11C,texRef_f11C), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f12C,texRef_f12C), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f13C,texRef_f13C), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f14C,texRef_f14C), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f15C,texRef_f15C), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f16C,texRef_f16C), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f17C,texRef_f17C), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f18C,texRef_f18C), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f0D,texRef_f0D), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f1D,texRef_f1D), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f2D,texRef_f2D), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f3D,texRef_f3D), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f4D,texRef_f4D), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f5D,texRef_f5D), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f6D,texRef_f6D), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f7D,texRef_f7D), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f8D,texRef_f8D), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f9D,texRef_f9D), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f10D,texRef_f10D), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f11D,texRef_f11D), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f12D,texRef_f12D), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f13D,texRef_f13D), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f14D,texRef_f14D), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f15D,texRef_f15D), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f16D,texRef_f16D), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f17D,texRef_f17D), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f18D,texRef_f18D), 2, 0, 0);  }
