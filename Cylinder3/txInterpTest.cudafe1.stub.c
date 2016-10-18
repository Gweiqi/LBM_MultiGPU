#include "crt/host_runtime.h"
#include "txInterpTest.fatbin.c"
extern void __device_stub__Z11simple_copyPfS_Pifm(float *, float *, int *, float, size_t);
extern void __device_stub__Z14ExtractFromC_dPfmf(float *, size_t, float);
extern void __device_stub__Z18LR_d_hybABCD_forcePfS_fmS_S_i(float *, float *, float, size_t, float *, float *, int);
extern void __device_stub__Z18LR_d_hybBACD_forcePfS_fmS_S_i(float *, float *, float, size_t, float *, float *, int);
extern void __device_stub__Z12LR_d_hybABCDPfS_fm(float *, float *, float, size_t);
extern void __device_stub__Z13LR_d_hybABCD2PfS_fmi(float *, float *, float, size_t, int);
extern void __device_stub__Z13LR_d_hybABDC2PfS_fmfi(float *, float *, float, size_t, float, int);
extern void __device_stub__Z10LR_d_ABDC2PfS_fmf(float *, float *, float, size_t, float);
extern void __device_stub__Z16LR_d_ABDC_InterpPfS_fmf(float *, float *, float, size_t, float);
extern void __device_stub__Z19LR_d_hybABDC_InterpPfS_fmf(float *, float *, float, size_t, float);
extern void __device_stub__Z12LR_d_hybBACDPfS_fm(float *, float *, float, size_t);
extern void __device_stub__Z13LR_d_hybBACD2PfS_fmi(float *, float *, float, size_t, int);
extern void __device_stub__Z10LR_d_BACD2PfS_fm(float *, float *, float, size_t);
extern void __device_stub__Z12LR_d_hybBADCPfS_fmf(float *, float *, float, size_t, float);
extern void __device_stub__Z13LR_d_hybBADC2PfS_fmfi(float *, float *, float, size_t, float, int);
extern void __device_stub__Z10LR_d_BADC2PfS_fmf(float *, float *, float, size_t, float);
extern void __device_stub__Z19LR_d_hybBADC_InterpPfS_fmf(float *, float *, float, size_t, float);
extern void __device_stub__Z9LR_d_ABCDPfS_fm(float *, float *, float, size_t);
extern void __device_stub__Z10LR_d_ABCD2PfS_fm(float *, float *, float, size_t);
extern void __device_stub__Z9LR_d_ABDCPfS_fmf(float *, float *, float, size_t, float);
extern void __device_stub__Z9LR_d_BACDPfS_fm(float *, float *, float, size_t);
extern void __device_stub__Z16LR_d_BADC_InterpPfS_fmf(float *, float *, float, size_t, float);
extern void __device_stub__Z12mrt_d_singlePfS_fm(float *, float *, float, size_t);
extern void __device_stub__Z18mrt_d_single_forcePfS_fmS_S_i(float *, float *, float, size_t, float *, float *, int);
extern void __device_stub__Z17mrt_d_hybAB_forcePfS_fmS_S_i(float *, float *, float, size_t, float *, float *, int);
extern void __device_stub__Z17mrt_d_hybBA_forcePfS_fmS_S_i(float *, float *, float, size_t, float *, float *, int);
extern void __device_stub__Z11mrt_d_hybABPfS_fm(float *, float *, float, size_t);
extern void __device_stub__Z11mrt_d_hybBAPfS_fm(float *, float *, float, size_t);
extern void __device_stub__Z12mrt_d_textABPfS_fm(float *, float *, float, size_t);
extern void __device_stub__Z12mrt_d_textBAPfS_fm(float *, float *, float, size_t);
extern void __device_stub__Z8mrt_d_LRPfS_fmf(float *, float *, float, size_t, float);
extern void __device_stub__Z17initialize_singlePfm(float *, size_t);
extern void __device_stub__Z13initialize_LRPfm(float *, size_t);
static void __sti____cudaRegisterAll_20_txInterpTest_cpp1_ii_8ec10853(void) __attribute__((__constructor__));
void __device_stub__Z11simple_copyPfS_Pifm(float *__par0, float *__par1, int *__par2, float __par3, size_t __par4){__cudaSetupArgSimple(__par0, 0UL);__cudaSetupArgSimple(__par1, 8UL);__cudaSetupArgSimple(__par2, 16UL);__cudaSetupArgSimple(__par3, 24UL);__cudaSetupArgSimple(__par4, 32UL);__cudaLaunch(((char *)((void ( *)(float *, float *, int *, float, size_t))simple_copy)));}
# 370 "txInterpTest.cu"
void simple_copy( float *__cuda_0,float *__cuda_1,int *__cuda_2,float __cuda_3,size_t __cuda_4)
# 372 "txInterpTest.cu"
{__device_stub__Z11simple_copyPfS_Pifm( __cuda_0,__cuda_1,__cuda_2,__cuda_3,__cuda_4);
# 379 "txInterpTest.cu"
}
# 1 "txInterpTest.cudafe1.stub.c"
void __device_stub__Z14ExtractFromC_dPfmf( float *__par0,  size_t __par1,  float __par2) {  __cudaSetupArgSimple(__par0, 0UL); __cudaSetupArgSimple(__par1, 8UL); __cudaSetupArgSimple(__par2, 16UL); __cudaLaunch(((char *)((void ( *)(float *, size_t, float))ExtractFromC_d))); }
# 381 "txInterpTest.cu"
void ExtractFromC_d( float *__cuda_0,size_t __cuda_1,float __cuda_2)
# 383 "txInterpTest.cu"
{__device_stub__Z14ExtractFromC_dPfmf( __cuda_0,__cuda_1,__cuda_2);
# 447 "txInterpTest.cu"
}
# 1 "txInterpTest.cudafe1.stub.c"
void __device_stub__Z18LR_d_hybABCD_forcePfS_fmS_S_i( float *__par0,  float *__par1,  float __par2,  size_t __par3,  float *__par4,  float *__par5,  int __par6) {  __cudaSetupArgSimple(__par0, 0UL); __cudaSetupArgSimple(__par1, 8UL); __cudaSetupArgSimple(__par2, 16UL); __cudaSetupArgSimple(__par3, 24UL); __cudaSetupArgSimple(__par4, 32UL); __cudaSetupArgSimple(__par5, 40UL); __cudaSetupArgSimple(__par6, 48UL); __cudaLaunch(((char *)((void ( *)(float *, float *, float, size_t, float *, float *, int))LR_d_hybABCD_force))); }
# 449 "txInterpTest.cu"
void LR_d_hybABCD_force( float *__cuda_0,float *__cuda_1,float __cuda_2,size_t __cuda_3,float *__cuda_4,float *__cuda_5,int __cuda_6)
# 451 "txInterpTest.cu"
{__device_stub__Z18LR_d_hybABCD_forcePfS_fmS_S_i( __cuda_0,__cuda_1,__cuda_2,__cuda_3,__cuda_4,__cuda_5,__cuda_6);
# 541 "txInterpTest.cu"
}
# 1 "txInterpTest.cudafe1.stub.c"
void __device_stub__Z18LR_d_hybBACD_forcePfS_fmS_S_i( float *__par0,  float *__par1,  float __par2,  size_t __par3,  float *__par4,  float *__par5,  int __par6) {  __cudaSetupArgSimple(__par0, 0UL); __cudaSetupArgSimple(__par1, 8UL); __cudaSetupArgSimple(__par2, 16UL); __cudaSetupArgSimple(__par3, 24UL); __cudaSetupArgSimple(__par4, 32UL); __cudaSetupArgSimple(__par5, 40UL); __cudaSetupArgSimple(__par6, 48UL); __cudaLaunch(((char *)((void ( *)(float *, float *, float, size_t, float *, float *, int))LR_d_hybBACD_force))); }
# 543 "txInterpTest.cu"
void LR_d_hybBACD_force( float *__cuda_0,float *__cuda_1,float __cuda_2,size_t __cuda_3,float *__cuda_4,float *__cuda_5,int __cuda_6)
# 545 "txInterpTest.cu"
{__device_stub__Z18LR_d_hybBACD_forcePfS_fmS_S_i( __cuda_0,__cuda_1,__cuda_2,__cuda_3,__cuda_4,__cuda_5,__cuda_6);
# 634 "txInterpTest.cu"
}
# 1 "txInterpTest.cudafe1.stub.c"
void __device_stub__Z12LR_d_hybABCDPfS_fm( float *__par0,  float *__par1,  float __par2,  size_t __par3) {  __cudaSetupArgSimple(__par0, 0UL); __cudaSetupArgSimple(__par1, 8UL); __cudaSetupArgSimple(__par2, 16UL); __cudaSetupArgSimple(__par3, 24UL); __cudaLaunch(((char *)((void ( *)(float *, float *, float, size_t))LR_d_hybABCD))); }
# 638 "txInterpTest.cu"
void LR_d_hybABCD( float *__cuda_0,float *__cuda_1,float __cuda_2,size_t __cuda_3)
# 640 "txInterpTest.cu"
{__device_stub__Z12LR_d_hybABCDPfS_fm( __cuda_0,__cuda_1,__cuda_2,__cuda_3);
# 691 "txInterpTest.cu"
}
# 1 "txInterpTest.cudafe1.stub.c"
void __device_stub__Z13LR_d_hybABCD2PfS_fmi( float *__par0,  float *__par1,  float __par2,  size_t __par3,  int __par4) {  __cudaSetupArgSimple(__par0, 0UL); __cudaSetupArgSimple(__par1, 8UL); __cudaSetupArgSimple(__par2, 16UL); __cudaSetupArgSimple(__par3, 24UL); __cudaSetupArgSimple(__par4, 32UL); __cudaLaunch(((char *)((void ( *)(float *, float *, float, size_t, int))LR_d_hybABCD2))); }
# 693 "txInterpTest.cu"
void LR_d_hybABCD2( float *__cuda_0,float *__cuda_1,float __cuda_2,size_t __cuda_3,int __cuda_4)
# 697 "txInterpTest.cu"
{__device_stub__Z13LR_d_hybABCD2PfS_fmi( __cuda_0,__cuda_1,__cuda_2,__cuda_3,__cuda_4);
# 749 "txInterpTest.cu"
}
# 1 "txInterpTest.cudafe1.stub.c"
void __device_stub__Z13LR_d_hybABDC2PfS_fmfi( float *__par0,  float *__par1,  float __par2,  size_t __par3,  float __par4,  int __par5) {  __cudaSetupArgSimple(__par0, 0UL); __cudaSetupArgSimple(__par1, 8UL); __cudaSetupArgSimple(__par2, 16UL); __cudaSetupArgSimple(__par3, 24UL); __cudaSetupArgSimple(__par4, 32UL); __cudaSetupArgSimple(__par5, 36UL); __cudaLaunch(((char *)((void ( *)(float *, float *, float, size_t, float, int))LR_d_hybABDC2))); }
# 751 "txInterpTest.cu"
void LR_d_hybABDC2( float *__cuda_0,float *__cuda_1,float __cuda_2,size_t __cuda_3,float __cuda_4,int __cuda_5)
# 753 "txInterpTest.cu"
{__device_stub__Z13LR_d_hybABDC2PfS_fmfi( __cuda_0,__cuda_1,__cuda_2,__cuda_3,__cuda_4,__cuda_5);
# 804 "txInterpTest.cu"
}
# 1 "txInterpTest.cudafe1.stub.c"
void __device_stub__Z10LR_d_ABDC2PfS_fmf( float *__par0,  float *__par1,  float __par2,  size_t __par3,  float __par4) {  __cudaSetupArgSimple(__par0, 0UL); __cudaSetupArgSimple(__par1, 8UL); __cudaSetupArgSimple(__par2, 16UL); __cudaSetupArgSimple(__par3, 24UL); __cudaSetupArgSimple(__par4, 32UL); __cudaLaunch(((char *)((void ( *)(float *, float *, float, size_t, float))LR_d_ABDC2))); }
# 805 "txInterpTest.cu"
void LR_d_ABDC2( float *__cuda_0,float *__cuda_1,float __cuda_2,size_t __cuda_3,float __cuda_4)
# 807 "txInterpTest.cu"
{__device_stub__Z10LR_d_ABDC2PfS_fmf( __cuda_0,__cuda_1,__cuda_2,__cuda_3,__cuda_4);
# 858 "txInterpTest.cu"
}
# 1 "txInterpTest.cudafe1.stub.c"
void __device_stub__Z16LR_d_ABDC_InterpPfS_fmf( float *__par0,  float *__par1,  float __par2,  size_t __par3,  float __par4) {  __cudaSetupArgSimple(__par0, 0UL); __cudaSetupArgSimple(__par1, 8UL); __cudaSetupArgSimple(__par2, 16UL); __cudaSetupArgSimple(__par3, 24UL); __cudaSetupArgSimple(__par4, 32UL); __cudaLaunch(((char *)((void ( *)(float *, float *, float, size_t, float))LR_d_ABDC_Interp))); }
# 860 "txInterpTest.cu"
void LR_d_ABDC_Interp( float *__cuda_0,float *__cuda_1,float __cuda_2,size_t __cuda_3,float __cuda_4)
# 862 "txInterpTest.cu"
{__device_stub__Z16LR_d_ABDC_InterpPfS_fmf( __cuda_0,__cuda_1,__cuda_2,__cuda_3,__cuda_4);
# 940 "txInterpTest.cu"
}
# 1 "txInterpTest.cudafe1.stub.c"
void __device_stub__Z19LR_d_hybABDC_InterpPfS_fmf( float *__par0,  float *__par1,  float __par2,  size_t __par3,  float __par4) {  __cudaSetupArgSimple(__par0, 0UL); __cudaSetupArgSimple(__par1, 8UL); __cudaSetupArgSimple(__par2, 16UL); __cudaSetupArgSimple(__par3, 24UL); __cudaSetupArgSimple(__par4, 32UL); __cudaLaunch(((char *)((void ( *)(float *, float *, float, size_t, float))LR_d_hybABDC_Interp))); }
# 943 "txInterpTest.cu"
void LR_d_hybABDC_Interp( float *__cuda_0,float *__cuda_1,float __cuda_2,size_t __cuda_3,float __cuda_4)
# 945 "txInterpTest.cu"
{__device_stub__Z19LR_d_hybABDC_InterpPfS_fmf( __cuda_0,__cuda_1,__cuda_2,__cuda_3,__cuda_4);
# 1023 "txInterpTest.cu"
}
# 1 "txInterpTest.cudafe1.stub.c"
void __device_stub__Z12LR_d_hybBACDPfS_fm( float *__par0,  float *__par1,  float __par2,  size_t __par3) {  __cudaSetupArgSimple(__par0, 0UL); __cudaSetupArgSimple(__par1, 8UL); __cudaSetupArgSimple(__par2, 16UL); __cudaSetupArgSimple(__par3, 24UL); __cudaLaunch(((char *)((void ( *)(float *, float *, float, size_t))LR_d_hybBACD))); }
# 1025 "txInterpTest.cu"
void LR_d_hybBACD( float *__cuda_0,float *__cuda_1,float __cuda_2,size_t __cuda_3)
# 1027 "txInterpTest.cu"
{__device_stub__Z12LR_d_hybBACDPfS_fm( __cuda_0,__cuda_1,__cuda_2,__cuda_3);
# 1075 "txInterpTest.cu"
}
# 1 "txInterpTest.cudafe1.stub.c"
void __device_stub__Z13LR_d_hybBACD2PfS_fmi( float *__par0,  float *__par1,  float __par2,  size_t __par3,  int __par4) {  __cudaSetupArgSimple(__par0, 0UL); __cudaSetupArgSimple(__par1, 8UL); __cudaSetupArgSimple(__par2, 16UL); __cudaSetupArgSimple(__par3, 24UL); __cudaSetupArgSimple(__par4, 32UL); __cudaLaunch(((char *)((void ( *)(float *, float *, float, size_t, int))LR_d_hybBACD2))); }
# 1077 "txInterpTest.cu"
void LR_d_hybBACD2( float *__cuda_0,float *__cuda_1,float __cuda_2,size_t __cuda_3,int __cuda_4)
# 1080 "txInterpTest.cu"
{__device_stub__Z13LR_d_hybBACD2PfS_fmi( __cuda_0,__cuda_1,__cuda_2,__cuda_3,__cuda_4);
# 1128 "txInterpTest.cu"
}
# 1 "txInterpTest.cudafe1.stub.c"
void __device_stub__Z10LR_d_BACD2PfS_fm( float *__par0,  float *__par1,  float __par2,  size_t __par3) {  __cudaSetupArgSimple(__par0, 0UL); __cudaSetupArgSimple(__par1, 8UL); __cudaSetupArgSimple(__par2, 16UL); __cudaSetupArgSimple(__par3, 24UL); __cudaLaunch(((char *)((void ( *)(float *, float *, float, size_t))LR_d_BACD2))); }
# 1129 "txInterpTest.cu"
void LR_d_BACD2( float *__cuda_0,float *__cuda_1,float __cuda_2,size_t __cuda_3)
# 1132 "txInterpTest.cu"
{__device_stub__Z10LR_d_BACD2PfS_fm( __cuda_0,__cuda_1,__cuda_2,__cuda_3);
# 1180 "txInterpTest.cu"
}
# 1 "txInterpTest.cudafe1.stub.c"
void __device_stub__Z12LR_d_hybBADCPfS_fmf( float *__par0,  float *__par1,  float __par2,  size_t __par3,  float __par4) {  __cudaSetupArgSimple(__par0, 0UL); __cudaSetupArgSimple(__par1, 8UL); __cudaSetupArgSimple(__par2, 16UL); __cudaSetupArgSimple(__par3, 24UL); __cudaSetupArgSimple(__par4, 32UL); __cudaLaunch(((char *)((void ( *)(float *, float *, float, size_t, float))LR_d_hybBADC))); }
# 1182 "txInterpTest.cu"
void LR_d_hybBADC( float *__cuda_0,float *__cuda_1,float __cuda_2,size_t __cuda_3,float __cuda_4)
# 1184 "txInterpTest.cu"
{__device_stub__Z12LR_d_hybBADCPfS_fmf( __cuda_0,__cuda_1,__cuda_2,__cuda_3,__cuda_4);
# 1234 "txInterpTest.cu"
}
# 1 "txInterpTest.cudafe1.stub.c"
void __device_stub__Z13LR_d_hybBADC2PfS_fmfi( float *__par0,  float *__par1,  float __par2,  size_t __par3,  float __par4,  int __par5) {  __cudaSetupArgSimple(__par0, 0UL); __cudaSetupArgSimple(__par1, 8UL); __cudaSetupArgSimple(__par2, 16UL); __cudaSetupArgSimple(__par3, 24UL); __cudaSetupArgSimple(__par4, 32UL); __cudaSetupArgSimple(__par5, 36UL); __cudaLaunch(((char *)((void ( *)(float *, float *, float, size_t, float, int))LR_d_hybBADC2))); }
# 1235 "txInterpTest.cu"
void LR_d_hybBADC2( float *__cuda_0,float *__cuda_1,float __cuda_2,size_t __cuda_3,float __cuda_4,int __cuda_5)
# 1237 "txInterpTest.cu"
{__device_stub__Z13LR_d_hybBADC2PfS_fmfi( __cuda_0,__cuda_1,__cuda_2,__cuda_3,__cuda_4,__cuda_5);
# 1287 "txInterpTest.cu"
}
# 1 "txInterpTest.cudafe1.stub.c"
void __device_stub__Z10LR_d_BADC2PfS_fmf( float *__par0,  float *__par1,  float __par2,  size_t __par3,  float __par4) {  __cudaSetupArgSimple(__par0, 0UL); __cudaSetupArgSimple(__par1, 8UL); __cudaSetupArgSimple(__par2, 16UL); __cudaSetupArgSimple(__par3, 24UL); __cudaSetupArgSimple(__par4, 32UL); __cudaLaunch(((char *)((void ( *)(float *, float *, float, size_t, float))LR_d_BADC2))); }
# 1288 "txInterpTest.cu"
void LR_d_BADC2( float *__cuda_0,float *__cuda_1,float __cuda_2,size_t __cuda_3,float __cuda_4)
# 1290 "txInterpTest.cu"
{__device_stub__Z10LR_d_BADC2PfS_fmf( __cuda_0,__cuda_1,__cuda_2,__cuda_3,__cuda_4);
# 1340 "txInterpTest.cu"
}
# 1 "txInterpTest.cudafe1.stub.c"
void __device_stub__Z19LR_d_hybBADC_InterpPfS_fmf( float *__par0,  float *__par1,  float __par2,  size_t __par3,  float __par4) {  __cudaSetupArgSimple(__par0, 0UL); __cudaSetupArgSimple(__par1, 8UL); __cudaSetupArgSimple(__par2, 16UL); __cudaSetupArgSimple(__par3, 24UL); __cudaSetupArgSimple(__par4, 32UL); __cudaLaunch(((char *)((void ( *)(float *, float *, float, size_t, float))LR_d_hybBADC_Interp))); }
# 1342 "txInterpTest.cu"
void LR_d_hybBADC_Interp( float *__cuda_0,float *__cuda_1,float __cuda_2,size_t __cuda_3,float __cuda_4)
# 1344 "txInterpTest.cu"
{__device_stub__Z19LR_d_hybBADC_InterpPfS_fmf( __cuda_0,__cuda_1,__cuda_2,__cuda_3,__cuda_4);
# 1421 "txInterpTest.cu"
}
# 1 "txInterpTest.cudafe1.stub.c"
void __device_stub__Z9LR_d_ABCDPfS_fm( float *__par0,  float *__par1,  float __par2,  size_t __par3) {  __cudaSetupArgSimple(__par0, 0UL); __cudaSetupArgSimple(__par1, 8UL); __cudaSetupArgSimple(__par2, 16UL); __cudaSetupArgSimple(__par3, 24UL); __cudaLaunch(((char *)((void ( *)(float *, float *, float, size_t))LR_d_ABCD))); }
# 1423 "txInterpTest.cu"
void LR_d_ABCD( float *__cuda_0,float *__cuda_1,float __cuda_2,size_t __cuda_3)
# 1425 "txInterpTest.cu"
{__device_stub__Z9LR_d_ABCDPfS_fm( __cuda_0,__cuda_1,__cuda_2,__cuda_3);
# 1473 "txInterpTest.cu"
}
# 1 "txInterpTest.cudafe1.stub.c"
void __device_stub__Z10LR_d_ABCD2PfS_fm( float *__par0,  float *__par1,  float __par2,  size_t __par3) {  __cudaSetupArgSimple(__par0, 0UL); __cudaSetupArgSimple(__par1, 8UL); __cudaSetupArgSimple(__par2, 16UL); __cudaSetupArgSimple(__par3, 24UL); __cudaLaunch(((char *)((void ( *)(float *, float *, float, size_t))LR_d_ABCD2))); }
# 1474 "txInterpTest.cu"
void LR_d_ABCD2( float *__cuda_0,float *__cuda_1,float __cuda_2,size_t __cuda_3)
# 1476 "txInterpTest.cu"
{__device_stub__Z10LR_d_ABCD2PfS_fm( __cuda_0,__cuda_1,__cuda_2,__cuda_3);
# 1524 "txInterpTest.cu"
}
# 1 "txInterpTest.cudafe1.stub.c"
void __device_stub__Z9LR_d_ABDCPfS_fmf( float *__par0,  float *__par1,  float __par2,  size_t __par3,  float __par4) {  __cudaSetupArgSimple(__par0, 0UL); __cudaSetupArgSimple(__par1, 8UL); __cudaSetupArgSimple(__par2, 16UL); __cudaSetupArgSimple(__par3, 24UL); __cudaSetupArgSimple(__par4, 32UL); __cudaLaunch(((char *)((void ( *)(float *, float *, float, size_t, float))LR_d_ABDC))); }
# 1526 "txInterpTest.cu"
void LR_d_ABDC( float *__cuda_0,float *__cuda_1,float __cuda_2,size_t __cuda_3,float __cuda_4)
# 1528 "txInterpTest.cu"
{__device_stub__Z9LR_d_ABDCPfS_fmf( __cuda_0,__cuda_1,__cuda_2,__cuda_3,__cuda_4);
# 1622 "txInterpTest.cu"
}
# 1 "txInterpTest.cudafe1.stub.c"
void __device_stub__Z9LR_d_BACDPfS_fm( float *__par0,  float *__par1,  float __par2,  size_t __par3) {  __cudaSetupArgSimple(__par0, 0UL); __cudaSetupArgSimple(__par1, 8UL); __cudaSetupArgSimple(__par2, 16UL); __cudaSetupArgSimple(__par3, 24UL); __cudaLaunch(((char *)((void ( *)(float *, float *, float, size_t))LR_d_BACD))); }
# 1624 "txInterpTest.cu"
void LR_d_BACD( float *__cuda_0,float *__cuda_1,float __cuda_2,size_t __cuda_3)
# 1626 "txInterpTest.cu"
{__device_stub__Z9LR_d_BACDPfS_fm( __cuda_0,__cuda_1,__cuda_2,__cuda_3);
# 1674 "txInterpTest.cu"
}
# 1 "txInterpTest.cudafe1.stub.c"
void __device_stub__Z16LR_d_BADC_InterpPfS_fmf( float *__par0,  float *__par1,  float __par2,  size_t __par3,  float __par4) {  __cudaSetupArgSimple(__par0, 0UL); __cudaSetupArgSimple(__par1, 8UL); __cudaSetupArgSimple(__par2, 16UL); __cudaSetupArgSimple(__par3, 24UL); __cudaSetupArgSimple(__par4, 32UL); __cudaLaunch(((char *)((void ( *)(float *, float *, float, size_t, float))LR_d_BADC_Interp))); }
# 1676 "txInterpTest.cu"
void LR_d_BADC_Interp( float *__cuda_0,float *__cuda_1,float __cuda_2,size_t __cuda_3,float __cuda_4)
# 1678 "txInterpTest.cu"
{__device_stub__Z16LR_d_BADC_InterpPfS_fmf( __cuda_0,__cuda_1,__cuda_2,__cuda_3,__cuda_4);
# 1773 "txInterpTest.cu"
}
# 1 "txInterpTest.cudafe1.stub.c"
void __device_stub__Z12mrt_d_singlePfS_fm( float *__par0,  float *__par1,  float __par2,  size_t __par3) {  __cudaSetupArgSimple(__par0, 0UL); __cudaSetupArgSimple(__par1, 8UL); __cudaSetupArgSimple(__par2, 16UL); __cudaSetupArgSimple(__par3, 24UL); __cudaLaunch(((char *)((void ( *)(float *, float *, float, size_t))mrt_d_single))); }
# 1774 "txInterpTest.cu"
void mrt_d_single( float *__cuda_0,float *__cuda_1,float __cuda_2,size_t __cuda_3)
# 1776 "txInterpTest.cu"
{__device_stub__Z12mrt_d_singlePfS_fm( __cuda_0,__cuda_1,__cuda_2,__cuda_3);
# 1837 "txInterpTest.cu"
}
# 1 "txInterpTest.cudafe1.stub.c"
void __device_stub__Z18mrt_d_single_forcePfS_fmS_S_i( float *__par0,  float *__par1,  float __par2,  size_t __par3,  float *__par4,  float *__par5,  int __par6) {  __cudaSetupArgSimple(__par0, 0UL); __cudaSetupArgSimple(__par1, 8UL); __cudaSetupArgSimple(__par2, 16UL); __cudaSetupArgSimple(__par3, 24UL); __cudaSetupArgSimple(__par4, 32UL); __cudaSetupArgSimple(__par5, 40UL); __cudaSetupArgSimple(__par6, 48UL); __cudaLaunch(((char *)((void ( *)(float *, float *, float, size_t, float *, float *, int))mrt_d_single_force))); }
# 1839 "txInterpTest.cu"
void mrt_d_single_force( float *__cuda_0,float *__cuda_1,float __cuda_2,size_t __cuda_3,float *__cuda_4,float *__cuda_5,int __cuda_6)
# 1841 "txInterpTest.cu"
{__device_stub__Z18mrt_d_single_forcePfS_fmS_S_i( __cuda_0,__cuda_1,__cuda_2,__cuda_3,__cuda_4,__cuda_5,__cuda_6);
# 1935 "txInterpTest.cu"
}
# 1 "txInterpTest.cudafe1.stub.c"
void __device_stub__Z17mrt_d_hybAB_forcePfS_fmS_S_i( float *__par0,  float *__par1,  float __par2,  size_t __par3,  float *__par4,  float *__par5,  int __par6) {  __cudaSetupArgSimple(__par0, 0UL); __cudaSetupArgSimple(__par1, 8UL); __cudaSetupArgSimple(__par2, 16UL); __cudaSetupArgSimple(__par3, 24UL); __cudaSetupArgSimple(__par4, 32UL); __cudaSetupArgSimple(__par5, 40UL); __cudaSetupArgSimple(__par6, 48UL); __cudaLaunch(((char *)((void ( *)(float *, float *, float, size_t, float *, float *, int))mrt_d_hybAB_force))); }
# 1936 "txInterpTest.cu"
void mrt_d_hybAB_force( float *__cuda_0,float *__cuda_1,float __cuda_2,size_t __cuda_3,float *__cuda_4,float *__cuda_5,int __cuda_6)
# 1938 "txInterpTest.cu"
{__device_stub__Z17mrt_d_hybAB_forcePfS_fmS_S_i( __cuda_0,__cuda_1,__cuda_2,__cuda_3,__cuda_4,__cuda_5,__cuda_6);
# 2052 "txInterpTest.cu"
}
# 1 "txInterpTest.cudafe1.stub.c"
void __device_stub__Z17mrt_d_hybBA_forcePfS_fmS_S_i( float *__par0,  float *__par1,  float __par2,  size_t __par3,  float *__par4,  float *__par5,  int __par6) {  __cudaSetupArgSimple(__par0, 0UL); __cudaSetupArgSimple(__par1, 8UL); __cudaSetupArgSimple(__par2, 16UL); __cudaSetupArgSimple(__par3, 24UL); __cudaSetupArgSimple(__par4, 32UL); __cudaSetupArgSimple(__par5, 40UL); __cudaSetupArgSimple(__par6, 48UL); __cudaLaunch(((char *)((void ( *)(float *, float *, float, size_t, float *, float *, int))mrt_d_hybBA_force))); }
# 2054 "txInterpTest.cu"
void mrt_d_hybBA_force( float *__cuda_0,float *__cuda_1,float __cuda_2,size_t __cuda_3,float *__cuda_4,float *__cuda_5,int __cuda_6)
# 2056 "txInterpTest.cu"
{__device_stub__Z17mrt_d_hybBA_forcePfS_fmS_S_i( __cuda_0,__cuda_1,__cuda_2,__cuda_3,__cuda_4,__cuda_5,__cuda_6);
# 2170 "txInterpTest.cu"
}
# 1 "txInterpTest.cudafe1.stub.c"
void __device_stub__Z11mrt_d_hybABPfS_fm( float *__par0,  float *__par1,  float __par2,  size_t __par3) {  __cudaSetupArgSimple(__par0, 0UL); __cudaSetupArgSimple(__par1, 8UL); __cudaSetupArgSimple(__par2, 16UL); __cudaSetupArgSimple(__par3, 24UL); __cudaLaunch(((char *)((void ( *)(float *, float *, float, size_t))mrt_d_hybAB))); }
# 2172 "txInterpTest.cu"
void mrt_d_hybAB( float *__cuda_0,float *__cuda_1,float __cuda_2,size_t __cuda_3)
# 2174 "txInterpTest.cu"
{__device_stub__Z11mrt_d_hybABPfS_fm( __cuda_0,__cuda_1,__cuda_2,__cuda_3);
# 2244 "txInterpTest.cu"
}
# 1 "txInterpTest.cudafe1.stub.c"
void __device_stub__Z11mrt_d_hybBAPfS_fm( float *__par0,  float *__par1,  float __par2,  size_t __par3) {  __cudaSetupArgSimple(__par0, 0UL); __cudaSetupArgSimple(__par1, 8UL); __cudaSetupArgSimple(__par2, 16UL); __cudaSetupArgSimple(__par3, 24UL); __cudaLaunch(((char *)((void ( *)(float *, float *, float, size_t))mrt_d_hybBA))); }
# 2245 "txInterpTest.cu"
void mrt_d_hybBA( float *__cuda_0,float *__cuda_1,float __cuda_2,size_t __cuda_3)
# 2247 "txInterpTest.cu"
{__device_stub__Z11mrt_d_hybBAPfS_fm( __cuda_0,__cuda_1,__cuda_2,__cuda_3);
# 2315 "txInterpTest.cu"
}
# 1 "txInterpTest.cudafe1.stub.c"
void __device_stub__Z12mrt_d_textABPfS_fm( float *__par0,  float *__par1,  float __par2,  size_t __par3) {  __cudaSetupArgSimple(__par0, 0UL); __cudaSetupArgSimple(__par1, 8UL); __cudaSetupArgSimple(__par2, 16UL); __cudaSetupArgSimple(__par3, 24UL); __cudaLaunch(((char *)((void ( *)(float *, float *, float, size_t))mrt_d_textAB))); }
# 2316 "txInterpTest.cu"
void mrt_d_textAB( float *__cuda_0,float *__cuda_1,float __cuda_2,size_t __cuda_3)
# 2318 "txInterpTest.cu"
{__device_stub__Z12mrt_d_textABPfS_fm( __cuda_0,__cuda_1,__cuda_2,__cuda_3);
# 2370 "txInterpTest.cu"
}
# 1 "txInterpTest.cudafe1.stub.c"
void __device_stub__Z12mrt_d_textBAPfS_fm( float *__par0,  float *__par1,  float __par2,  size_t __par3) {  __cudaSetupArgSimple(__par0, 0UL); __cudaSetupArgSimple(__par1, 8UL); __cudaSetupArgSimple(__par2, 16UL); __cudaSetupArgSimple(__par3, 24UL); __cudaLaunch(((char *)((void ( *)(float *, float *, float, size_t))mrt_d_textBA))); }
# 2371 "txInterpTest.cu"
void mrt_d_textBA( float *__cuda_0,float *__cuda_1,float __cuda_2,size_t __cuda_3)
# 2373 "txInterpTest.cu"
{__device_stub__Z12mrt_d_textBAPfS_fm( __cuda_0,__cuda_1,__cuda_2,__cuda_3);
# 2425 "txInterpTest.cu"
}
# 1 "txInterpTest.cudafe1.stub.c"
void __device_stub__Z8mrt_d_LRPfS_fmf( float *__par0,  float *__par1,  float __par2,  size_t __par3,  float __par4) {  __cudaSetupArgSimple(__par0, 0UL); __cudaSetupArgSimple(__par1, 8UL); __cudaSetupArgSimple(__par2, 16UL); __cudaSetupArgSimple(__par3, 24UL); __cudaSetupArgSimple(__par4, 32UL); __cudaLaunch(((char *)((void ( *)(float *, float *, float, size_t, float))mrt_d_LR))); }
# 2428 "txInterpTest.cu"
void mrt_d_LR( float *__cuda_0,float *__cuda_1,float __cuda_2,size_t __cuda_3,float __cuda_4)
# 2430 "txInterpTest.cu"
{__device_stub__Z8mrt_d_LRPfS_fmf( __cuda_0,__cuda_1,__cuda_2,__cuda_3,__cuda_4);
# 2490 "txInterpTest.cu"
}
# 1 "txInterpTest.cudafe1.stub.c"
void __device_stub__Z17initialize_singlePfm( float *__par0,  size_t __par1) {  __cudaSetupArgSimple(__par0, 0UL); __cudaSetupArgSimple(__par1, 8UL); __cudaLaunch(((char *)((void ( *)(float *, size_t))initialize_single))); }
# 2493 "txInterpTest.cu"
void initialize_single( float *__cuda_0,size_t __cuda_1)
# 2494 "txInterpTest.cu"
{__device_stub__Z17initialize_singlePfm( __cuda_0,__cuda_1);
# 2515 "txInterpTest.cu"
}
# 1 "txInterpTest.cudafe1.stub.c"
void __device_stub__Z13initialize_LRPfm( float *__par0,  size_t __par1) {  __cudaSetupArgSimple(__par0, 0UL); __cudaSetupArgSimple(__par1, 8UL); __cudaLaunch(((char *)((void ( *)(float *, size_t))initialize_LR))); }
# 2518 "txInterpTest.cu"
void initialize_LR( float *__cuda_0,size_t __cuda_1)
# 2519 "txInterpTest.cu"
{__device_stub__Z13initialize_LRPfm( __cuda_0,__cuda_1);
# 2540 "txInterpTest.cu"
}
# 1 "txInterpTest.cudafe1.stub.c"
static void __sti____cudaRegisterAll_20_txInterpTest_cpp1_ii_8ec10853(void) {  __cudaRegisterBinary(); __cudaRegisterEntry(((void ( *)(float *, size_t))initialize_LR), _Z13initialize_LRPfm, (-1)); __cudaRegisterEntry(((void ( *)(float *, size_t))initialize_single), _Z17initialize_singlePfm, (-1)); __cudaRegisterEntry(((void ( *)(float *, float *, float, size_t, float))mrt_d_LR), _Z8mrt_d_LRPfS_fmf, (-1)); __cudaRegisterEntry(((void ( *)(float *, float *, float, size_t))mrt_d_textBA), _Z12mrt_d_textBAPfS_fm, (-1)); __cudaRegisterEntry(((void ( *)(float *, float *, float, size_t))mrt_d_textAB), _Z12mrt_d_textABPfS_fm, (-1)); __cudaRegisterEntry(((void ( *)(float *, float *, float, size_t))mrt_d_hybBA), _Z11mrt_d_hybBAPfS_fm, (-1)); __cudaRegisterEntry(((void ( *)(float *, float *, float, size_t))mrt_d_hybAB), _Z11mrt_d_hybABPfS_fm, (-1)); __cudaRegisterEntry(((void ( *)(float *, float *, float, size_t, float *, float *, int))mrt_d_hybBA_force), _Z17mrt_d_hybBA_forcePfS_fmS_S_i, (-1)); __cudaRegisterEntry(((void ( *)(float *, float *, float, size_t, float *, float *, int))mrt_d_hybAB_force), _Z17mrt_d_hybAB_forcePfS_fmS_S_i, (-1)); __cudaRegisterEntry(((void ( *)(float *, float *, float, size_t, float *, float *, int))mrt_d_single_force), _Z18mrt_d_single_forcePfS_fmS_S_i, (-1)); __cudaRegisterEntry(((void ( *)(float *, float *, float, size_t))mrt_d_single), _Z12mrt_d_singlePfS_fm, (-1)); __cudaRegisterEntry(((void ( *)(float *, float *, float, size_t, float))LR_d_BADC_Interp), _Z16LR_d_BADC_InterpPfS_fmf, (-1)); __cudaRegisterEntry(((void ( *)(float *, float *, float, size_t))LR_d_BACD), _Z9LR_d_BACDPfS_fm, (-1)); __cudaRegisterEntry(((void ( *)(float *, float *, float, size_t, float))LR_d_ABDC), _Z9LR_d_ABDCPfS_fmf, (-1)); __cudaRegisterEntry(((void ( *)(float *, float *, float, size_t))LR_d_ABCD2), _Z10LR_d_ABCD2PfS_fm, (-1)); __cudaRegisterEntry(((void ( *)(float *, float *, float, size_t))LR_d_ABCD), _Z9LR_d_ABCDPfS_fm, (-1)); __cudaRegisterEntry(((void ( *)(float *, float *, float, size_t, float))LR_d_hybBADC_Interp), _Z19LR_d_hybBADC_InterpPfS_fmf, (-1)); __cudaRegisterEntry(((void ( *)(float *, float *, float, size_t, float))LR_d_BADC2), _Z10LR_d_BADC2PfS_fmf, (-1)); __cudaRegisterEntry(((void ( *)(float *, float *, float, size_t, float, int))LR_d_hybBADC2), _Z13LR_d_hybBADC2PfS_fmfi, (-1)); __cudaRegisterEntry(((void ( *)(float *, float *, float, size_t, float))LR_d_hybBADC), _Z12LR_d_hybBADCPfS_fmf, (-1)); __cudaRegisterEntry(((void ( *)(float *, float *, float, size_t))LR_d_BACD2), _Z10LR_d_BACD2PfS_fm, (-1)); __cudaRegisterEntry(((void ( *)(float *, float *, float, size_t, int))LR_d_hybBACD2), _Z13LR_d_hybBACD2PfS_fmi, (-1)); __cudaRegisterEntry(((void ( *)(float *, float *, float, size_t))LR_d_hybBACD), _Z12LR_d_hybBACDPfS_fm, (-1)); __cudaRegisterEntry(((void ( *)(float *, float *, float, size_t, float))LR_d_hybABDC_Interp), _Z19LR_d_hybABDC_InterpPfS_fmf, (-1)); __cudaRegisterEntry(((void ( *)(float *, float *, float, size_t, float))LR_d_ABDC_Interp), _Z16LR_d_ABDC_InterpPfS_fmf, (-1)); __cudaRegisterEntry(((void ( *)(float *, float *, float, size_t, float))LR_d_ABDC2), _Z10LR_d_ABDC2PfS_fmf, (-1)); __cudaRegisterEntry(((void ( *)(float *, float *, float, size_t, float, int))LR_d_hybABDC2), _Z13LR_d_hybABDC2PfS_fmfi, (-1)); __cudaRegisterEntry(((void ( *)(float *, float *, float, size_t, int))LR_d_hybABCD2), _Z13LR_d_hybABCD2PfS_fmi, (-1)); __cudaRegisterEntry(((void ( *)(float *, float *, float, size_t))LR_d_hybABCD), _Z12LR_d_hybABCDPfS_fm, (-1)); __cudaRegisterEntry(((void ( *)(float *, float *, float, size_t, float *, float *, int))LR_d_hybBACD_force), _Z18LR_d_hybBACD_forcePfS_fmS_S_i, (-1)); __cudaRegisterEntry(((void ( *)(float *, float *, float, size_t, float *, float *, int))LR_d_hybABCD_force), _Z18LR_d_hybABCD_forcePfS_fmS_S_i, (-1)); __cudaRegisterEntry(((void ( *)(float *, size_t, float))ExtractFromC_d), _Z14ExtractFromC_dPfmf, (-1)); __cudaRegisterEntry(((void ( *)(float *, float *, int *, float, size_t))simple_copy), _Z11simple_copyPfS_Pifm, (-1)); __cudaRegisterGlobalTexture(__text_var(texRef_f0A,texRef_f0A), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f1A,texRef_f1A), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f2A,texRef_f2A), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f3A,texRef_f3A), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f4A,texRef_f4A), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f5A,texRef_f5A), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f6A,texRef_f6A), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f7A,texRef_f7A), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f8A,texRef_f8A), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f0B,texRef_f0B), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f1B,texRef_f1B), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f2B,texRef_f2B), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f3B,texRef_f3B), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f4B,texRef_f4B), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f5B,texRef_f5B), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f6B,texRef_f6B), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f7B,texRef_f7B), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f8B,texRef_f8B), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f0C,texRef_f0C), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f1C,texRef_f1C), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f2C,texRef_f2C), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f3C,texRef_f3C), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f4C,texRef_f4C), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f5C,texRef_f5C), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f6C,texRef_f6C), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f7C,texRef_f7C), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f8C,texRef_f8C), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f0D,texRef_f0D), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f1D,texRef_f1D), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f2D,texRef_f2D), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f3D,texRef_f3D), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f4D,texRef_f4D), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f5D,texRef_f5D), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f6D,texRef_f6D), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f7D,texRef_f7D), 2, 0, 0); __cudaRegisterGlobalTexture(__text_var(texRef_f8D,texRef_f8D), 2, 0, 0);  }
