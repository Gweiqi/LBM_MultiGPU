#include <iostream>
#include <ostream>
#include <fstream>
using namespace std;

int main(){

	float u,v,w;	
	float f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18;
    f0 = 0.5f;
    f1 = 1.f;
    f3 = 3.f;
    f2 = 2.f;
    f5 = 5.f;
    f6 = 6.f;
    f4 = 4.f;
    f7 = 7.f;
    f8 = 8.f;
    f9 = 9.f;
    f10= 10.f;
    f11= 11.f;
    f12= 12.f;
    f13= 13.f;
    f14= 14.f;
    f15= 15.f;
    f16= 16.f;
    f17= 17.f;
	u = f1-f3+f5-f6-f7+f8+f10-f12+f15-f17;
	v = f2-f4+f5+f6-f7-f8+f11-f13+f16-f18;
	w = f9+f10+f11+f12+f13-f14-f15-f16-f17-f18;
    float omega = 100.f;
//	float rho = f0+f1+f2+f3+f4+f5+f6+f7+f8+f9+
//	      f10+f11+f12+f13+f14+f15+f16+f17+f18;
//	u = rho*u;
//	v = rho*v;
//	w = rho*w;

    

	float m1,m2,m4,m6,m8,m9,m10,m11,m12,m13,m14,m15,m16,m17,m18;

//	//COMPUTE M-MEQ
//	//m1  = -19.f*f0+ 19.f*f5+19.f*f6+19.f*f7+19.f*f8+19.f*f10+19.f*f11+19.f*f12+19.f*f13+19.f*f15+19.f*f16+19.f*f17+19.f*f18   -19.f*(u*u+v*v+w*w);//+8.f*(f5+f6+f7+f8+f10+f11+f12+f13+f15+f16+f17+f18);
//	//m4  = -3.33333333f*f1+3.33333333f*f3+1.66666667f*f5-1.66666667f*f6-1.66666667f*f7+1.66666667f*f8+1.66666667f*f10-1.66666667f*f12+1.66666667f*f15-1.66666667f*f17;
//	//m6  = -3.33333333f*f2+3.33333333f*f4+1.66666667f*f5+1.66666667f*f6-1.66666667f*f7-1.66666667f*f8+1.66666667f*f11-1.66666667f*f13+1.66666667f*f16-1.66666667f*f18;
//	//m8  = -3.33333333f*f9+1.66666667f*f10+1.66666667f*f11+1.66666667f*f12+1.66666667f*f13+3.33333333f*f14-1.66666667f*f15-1.66666667f*f16-1.66666667f*f17-1.66666667f*f18;
//	m1  = 19.f*(-f0+ f5+f6+f7+f8+f10+f11+f12+f13+f15+f16+f17+f18   -(u*u+v*v+w*w));//+8.f*(f5+f6+f7+f8+f10+f11+f12+f13+f15+f16+f17+f18);
//	m2  =  12.f*f0+ -4.f*f1+ -4.f*f2+ -4.f*f3+ -4.f*f4+      f5+      f6+      f7+      f8+ -4.f*f9+    f10+        f11+      f12+      f13+ -4.f*f14+      f15+      f16+      f17+      f18 +7.53968254f*(u*u+v*v+w*w);
////	m4  = 1.666666667f*(-2.f*f1+2.f*f3+f5-f6-f7+f8+f10-f12+f15-f17);
////	m6  = 1.666666667f*(-2.f*f2+2.f*f4+f5+f6-f7-f8+f11-f13+f16-f18);
////	m8  = 1.666666667f*(-2.f*f9+f10+f11+f12+f13+2.f*f14-f15-f16-f17-f18);
//	m4  = 1.666666667f*(-3.f*f1+3.f*f3+u);
//	m6  = 1.666666667f*(-3.f*f2+3.f*f4+v);
//	m8  = 1.666666667f*(-3.f*f9+3.f*f14+w);
//	m9  = 2.f*f1+  -  f2+  2.f*f3+  -  f4+ f5+ f6+ f7+ f8+-    f9+ f10+ -2.f*f11+ f12+-2.f*f13+-    f14+ f15+ -2.f*f16+ f17+-2.f*f18  -(2.f*u*u-(v*v+w*w));
//	m10 =-4.f*f1+ 2.f*f2+ -4.f*f3+ 2.f*f4+ f5+ f6+ f7+ f8+ 2.f*f9+ f10+ -2.f*f11+ f12+-2.f*f13+ 2.f*f14+ f15+ -2.f*f16+ f17+-2.f*f18;
//	m11 =             f2         +     f4+ f5+ f6+ f7+ f8+-    f9+-f10          +-f12         +-    f14+-f15          +-f17         -(v*v-w*w);
//	m12 =        -2.f*f2          -2.f*f4+ f5+ f6+ f7+ f8+ 2.f*f9+-f10          +-f12         + 2.f*f14+-f15          +-f17         ;
//	m13 =                                  f5+-f6+ f7+-f8                                                                             -u*v;
//	m14 =                                                                    f11     +-    f13              + -    f16     +     f18  -v*w;
//	m15 =                                                          f10        + - f12                  +-f15          + f17           -u*w;  
//	m16 =                                  f5+-f6+-f7+ f8         -f10        +   f12                  +-f15          + f17         ;  
//	m17 =                                 -f5+-f6+ f7+ f8              +     f11     +-    f13              +      f16     +-    f18;  
//	m18 =                                                          f10+-     f11+ f12+-    f13         +-f15+      f16+-f17+     f18;
//
//f0 -=- 0.012531328f*(m1)+ 0.047619048f*(m2);
//f1 -=-0.0045948204f*(m1)+-0.015873016f*(m2)+  -0.1f*(m4)                 + 0.055555556f*((m9)*omega-m10);
//f2 -=-0.0045948204f*(m1)+-0.015873016f*(m2)             +   -0.1f*(m6)   +-0.027777778f*((m9)*omega-m10)+ 0.083333333f*((m11)*omega-m12);
//f3 -=-0.0045948204f*(m1)+-0.015873016f*(m2)+   0.1f*(m4)                 + 0.055555556f*((m9)*omega-m10);                                                                                         
//f4 -=-0.0045948204f*(m1)+-0.015873016f*(m2)             +    0.1f*(m6)   +-0.027777778f*((m9)*omega-m10)+ 0.083333333f*((m11)*omega-m12);
//f5 -= 0.0033416876f*(m1)+ 0.003968254f*(m2)+ 0.025f*(m4+m6)              +0.013888889f*(m10)+0.041666667f*(m12)+0.125f*( m16-m17)+ omega*(0.027777778f*(m9) +0.083333333f*(m11)+( 0.25f*(m13)));
//f6 -= 0.0033416876f*(m1)+ 0.003968254f*(m2)+-0.025f*(m4-m6)              +0.013888889f*(m10)+0.041666667f*(m12)+0.125f*(-m16-m17)+ omega*(0.027777778f*(m9) +0.083333333f*(m11)+(-0.25f*(m13)));
//f7 -= 0.0033416876f*(m1)+ 0.003968254f*(m2)+-0.025f*(m4+m6)              +0.013888889f*(m10)+0.041666667f*(m12)+0.125f*(-m16+m17)+ omega*(0.027777778f*(m9) +0.083333333f*(m11)+( 0.25f*(m13)));
//f8 -= 0.0033416876f*(m1)+ 0.003968254f*(m2)+ 0.025f*(m4-m6)              +0.013888889f*(m10)+0.041666667f*(m12)+0.125f*( m16+m17)+ omega*(0.027777778f*(m9) +0.083333333f*(m11)+(-0.25f*(m13)));
//f9 -=-0.0045948204f*(m1)+-0.015873016f*(m2)                +   -0.1f*(m8)+-0.027777778f*((m9)*omega-m10)+-0.083333333f*((m11)*omega-m12);                                       
//f10-= 0.0033416876f*(m1)+ 0.003968254f*(m2)+ 0.025f*(m4+m8)              +0.013888889f*(m10)-0.041666667f*(m12)+0.125f*(-m16+m18)+ omega*(0.027777778f*(m9) -0.083333333f*(m11)+( 0.25f*(m15)));
//f11-= 0.0033416876f*(m1)+ 0.003968254f*(m2)             +  0.025f*(m6+m8)+0.125f*( m17-m18)-0.027777778f*(m10)+omega*(-0.055555556f*(m9) +( 0.25f*(m14)));
//f12-= 0.0033416876f*(m1)+ 0.003968254f*(m2)+-0.025f*(m4-m8)              +0.013888889f*(m10)-0.041666667f*(m12)+0.125f*( m16+m18)+ omega*(0.027777778f*(m9) -0.083333333f*(m11)+(-0.25f*(m15)));
//f13-= 0.0033416876f*(m1)+ 0.003968254f*(m2)             + -0.025f*(m6-m8)+0.125f*(-m17-m18)-0.027777778f*(m10)+omega*(-0.055555556f*(m9) +(-0.25f*(m14)));
//f14-=-0.0045948204f*(m1)+-0.015873016f*(m2)                +    0.1f*(m8)+-0.027777778f*((m9)*omega-m10)+-0.083333333f*((m11)*omega-m12);                                      
//f15-= 0.0033416876f*(m1)+ 0.003968254f*(m2)+ 0.025f*(m4-m8)              +0.013888889f*(m10)-0.041666667f*(m12)+0.125f*(-m16-m18)+ omega*(0.027777778f*(m9) -0.083333333f*(m11)+(-0.25f*(m15)));
//f16-= 0.0033416876f*(m1)+ 0.003968254f*(m2)             +  0.025f*(m6-m8)+0.125f*( m17+m18)-0.027777778f*(m10)+omega*(-0.055555556f*(m9) +(-0.25f*(m14)));
//f17-= 0.0033416876f*(m1)+ 0.003968254f*(m2)+-0.025f*(m4+m8)              +0.013888889f*(m10)-0.041666667f*(m12)+0.125f*( m16-m18)+ omega*(0.027777778f*(m9) -0.083333333f*(m11)+( 0.25f*(m15)));
//f18-= 0.0033416876f*(m1)+ 0.003968254f*(m2)             + -0.025f*(m6+m8)+0.125f*(-m17+m18)-0.027777778f*(m10)+omega*(-0.055555556f*(m9) +( 0.25f*(m14)));


    //COMPUTE M-MEQ
	m1  = (-f0+ f5+f6+f7+f8+f10+f11+f12+f13+f15+f16+f17+f18   -(u*u+v*v+w*w));//+8.f*(f5+f6+f7+f8+f10+f11+f12+f13+f15+f16+f17+f18);
	m2  =  12.f*f0+ -4.f*f1+ -4.f*f2+ -4.f*f3+ -4.f*f4+      f5+      f6+      f7+      f8+ -4.f*f9+    f10+        f11+      f12+      f13+ -4.f*f14+      f15+      f16+      f17+      f18 +7.53968254f*(u*u+v*v+w*w);
	m4  = (-5.f*f1+5.f*f3 +1.666666667f*u);
	m6  = (-5.f*f2+5.f*f4 +1.666666667f*v);
	m8  = (-5.f*f9+5.f*f14+1.666666667f*w);
	m9  = 2.f*f1+  -  f2+  2.f*f3+  -  f4+ f5+ f6+ f7+ f8+-    f9+ f10+ -2.f*f11+ f12+-2.f*f13+-    f14+ f15+ -2.f*f16+ f17+-2.f*f18  -(2.f*u*u-(v*v+w*w));
	m10 =-4.f*f1+ 2.f*f2+ -4.f*f3+ 2.f*f4+ f5+ f6+ f7+ f8+ 2.f*f9+ f10+ -2.f*f11+ f12+-2.f*f13+ 2.f*f14+ f15+ -2.f*f16+ f17+-2.f*f18;
	m11 =             f2         +     f4+ f5+ f6+ f7+ f8+-    f9+-f10          +-f12         +-    f14+-f15          +-f17         -(v*v-w*w);
	m12 =        -2.f*f2          -2.f*f4+ f5+ f6+ f7+ f8+ 2.f*f9+-f10          +-f12         + 2.f*f14+-f15          +-f17         ;
	m13 =                                  f5+-f6+ f7+-f8                                                                             -u*v;
	m14 =                                                                    f11     +-    f13              + -    f16     +     f18  -v*w;
	m15 =                                                          f10        + - f12                  +-f15          + f17           -u*w;  
	m16 =                                  f5+-f6+-f7+ f8         -f10        +   f12                  +-f15          + f17         ;  
	m17 =                                 -f5+-f6+ f7+ f8              +     f11     +-    f13              +      f16     +-    f18;  
	m18 =                                                          f10+-     f11+ f12+-    f13         +-f15+      f16+-f17+     f18;

//	m16 =                                  f5+-f6+-f7+ f8         -f10        +   f12                  +-f15          + f17         ;  
//	m17 =                                 -f5+-f6+ f7+ f8              +     f11     +-    f13              +      f16     +-    f18;  
//m16+m17 =                                    +-2.f*f6+ 2.f*f7+ 2.f*f8         -f10 +     f11 +f12+-    f13         +-f15+      f16+ f17+-    f18;  



    m13 *= 0.25f;
    m14 *= 0.25f;
    m15 *= 0.25f*omega;
    m16 *= 0.125f;
    m17 *= 0.125f;
    m18 *= 0.125f;
    m12 *= 0.04166666667f;
    m11 *= 0.08333333333f*omega;
    m10 *= 0.01388888889f;
    m9  *= 0.02777777778f*omega;
    m4  *= 0.025f;
    m6  *= 0.025f;
    m8  *= 0.025f;
    m2  *= 0.003968254f;


f0 -=-0.23809524f*m1+ 12.0f*m2;
f1 -=-0.08730159f*m1+- 4.0f*m2+-  4.0f*m4                      + 2.f*m9+-4.0f*m10                                                     ;
f2 -=-0.08730159f*m1+- 4.0f*m2           +  -4.0f*m6           +-    m9+ 2.0f*m10+ m11+-2.f*m12                                       ;
f3 -=-0.08730159f*m1+- 4.0f*m2+   4.0f*m4                      + 2.f*m9+-4.0f*m10                                                     ;
f4 -=-0.08730159f*m1+- 4.0f*m2           +   4.0f*m6           +-    m9+ 2.0f*m10+ m11+-2.f*m12                                       ;
f5 -= 0.06349206f*m1+       m2+        m4+        m6           +     m9+      m10+ m11+     m12+ m13                +  m16+ -m17      ;
f6 -= 0.06349206f*m1+       m2+-       m4+        m6           +     m9+      m10+ m11+     m12+-m13                + -m16+ -m17      ;
f7 -= 0.06349206f*m1+       m2+-       m4+-       m6           +     m9+      m10+ m11+     m12+ m13                + -m16+  m17      ;
f8 -= 0.06349206f*m1+       m2+        m4+-       m6           +     m9+      m10+ m11+     m12+-m13                +0.125f*(-2.f*f6+ 2.f*f8         -f10 +     f11 +f12+-    f13         +-f15+      f16+ f17+-    f18      );
f9 -=-0.08730159f*m1+- 4.0f*m2                      +-  4.0f*m8+-    m9+ 2.0f*m10+-m11+ 2.f*m12                                       ;
f10-= 0.06349206f*m1+       m2+        m4           +        m8+     m9+      m10+-m11+-    m12               +  m15+ -m16      +  m18;
f11-= 0.06349206f*m1+       m2           +        m6+        m8+-2.f*m9+-2.0f*m10                   +  m14                +  m17+ -m18;
f12-= 0.06349206f*m1+       m2+-       m4           +        m8+     m9+      m10+-m11+-    m12               + -m15+  m16      +  m18;
f13-= 0.06349206f*m1+       m2           +-       m6+        m8+-2.f*m9+-2.0f*m10                   + -m14                + -m17+ -m18;
f14-=-0.08730159f*m1+- 4.0f*m2                      +   4.0f*m8+-    m9+ 2.0f*m10+-m11+ 2.f*m12                                       ;          
f15-= 0.06349206f*m1+       m2+        m4           +-       m8+     m9+      m10+-m11+-    m12               + -m15+ -m16      + -m18;
f16-= 0.06349206f*m1+       m2           +        m6+-       m8+-2.f*m9+-2.0f*m10                   + -m14                +  m17+  m18;
f17-= 0.06349206f*m1+       m2+-       m4           +-       m8+     m9+      m10+-m11+-    m12               +  m15+  m16      + -m18;
f18-= 0.06349206f*m1+       m2           +-       m6+-       m8+-2.f*m9+-2.0f*m10                   +  m14                + -m17+  m18;

//f0 -=-0.23809524f*m1+ 0.047619048f*m2;
//f1 -=-0.08730159f*m1+-0.015873016f*m2+-  0.1f*m4                      + 0.0555555556f*m9*omega+-0.0555555556f*m10                                                                                     ;
//f2 -=-0.08730159f*m1+-0.015873016f*m2           +  -0.1f*m6           +-0.0277777778f*m9*omega+ 0.0277777778f*m10+ 0.083333333f*m11*omega+-0.083333333f*m12                                                                 ;
//f3 -=-0.08730159f*m1+-0.015873016f*m2+   0.1f*m4                      + 0.0555555556f*m9*omega+-0.0555555556f*m10                                                                                     ;
//f4 -=-0.08730159f*m1+-0.015873016f*m2           +   0.1f*m6           +-0.0277777778f*m9*omega+ 0.0277777778f*m10+ 0.083333333f*m11*omega+-0.083333333f*m12                                                                 ;
//f5 -= 0.06349206f*m1+ 0.003968254f*m2+ 0.025f*m4+ 0.025f*m6           + 0.0277777778f*m9*omega+ 0.0138888889f*m10+ 0.083333333f*m11*omega+ 0.041666667f*m12+ 0.25f*m13                          +  0.125f*m16+ -0.125f*m17          ;
//f6 -= 0.06349206f*m1+ 0.003968254f*m2+-0.025f*m4+ 0.025f*m6           + 0.0277777778f*m9*omega+ 0.0138888889f*m10+ 0.083333333f*m11*omega+ 0.041666667f*m12+-0.25f*m13                          + -0.125f*m16+ -0.125f*m17          ;
//f7 -= 0.06349206f*m1+ 0.003968254f*m2+-0.025f*m4+-0.025f*m6           + 0.0277777778f*m9*omega+ 0.0138888889f*m10+ 0.083333333f*m11*omega+ 0.041666667f*m12+ 0.25f*m13                          + -0.125f*m16+  0.125f*m17          ;
//f8 -= 0.06349206f*m1+ 0.003968254f*m2+ 0.025f*m4+-0.025f*m6           + 0.0277777778f*m9*omega+ 0.0138888889f*m10+ 0.083333333f*m11*omega+ 0.041666667f*m12+-0.25f*m13                          +  0.125f*m16+  0.125f*m17          ;
//f9 -=-0.08730159f*m1+-0.015873016f*m2                      +-  0.1f*m8+-0.0277777778f*m9*omega+ 0.0277777778f*m10+-0.083333333f*m11*omega+ 0.083333333f*m12                                                                 ;
//f10-= 0.06349206f*m1+ 0.003968254f*m2+ 0.025f*m4           + 0.025f*m8+ 0.0277777778f*m9*omega+ 0.0138888889f*m10+-0.083333333f*m11*omega+-0.041666667f*m12                   +  0.25f*m15*omega+ -0.125f*m16          +  0.125f*m18;
//f11-= 0.06349206f*m1+ 0.003968254f*m2           + 0.025f*m6+ 0.025f*m8+-0.0555555556f*m9*omega+-0.0277777778f*m10                                                   +  0.25f*m14                          +  0.125f*m17+ -0.125f*m18;
//f12-= 0.06349206f*m1+ 0.003968254f*m2+-0.025f*m4           + 0.025f*m8+ 0.0277777778f*m9*omega+ 0.0138888889f*m10+-0.083333333f*m11*omega+-0.041666667f*m12                   + -0.25f*m15*omega+  0.125f*m16          +  0.125f*m18;
//f13-= 0.06349206f*m1+ 0.003968254f*m2           +-0.025f*m6+ 0.025f*m8+-0.0555555556f*m9*omega+-0.0277777778f*m10                                                   + -0.25f*m14                          + -0.125f*m17+ -0.125f*m18;
//f14-=-0.08730159f*m1+-0.015873016f*m2                      +   0.1f*m8+-0.0277777778f*m9*omega+ 0.0277777778f*m10+-0.083333333f*m11*omega+ 0.083333333f*m12                                                                 ;
//f15-= 0.06349206f*m1+ 0.003968254f*m2+ 0.025f*m4           +-0.025f*m8+ 0.0277777778f*m9*omega+ 0.0138888889f*m10+-0.083333333f*m11*omega+-0.041666667f*m12                   + -0.25f*m15*omega+ -0.125f*m16          + -0.125f*m18;
//f16-= 0.06349206f*m1+ 0.003968254f*m2           + 0.025f*m6+-0.025f*m8+-0.0555555556f*m9*omega+-0.0277777778f*m10                                                   + -0.25f*m14                          +  0.125f*m17+  0.125f*m18;
//f17-= 0.06349206f*m1+ 0.003968254f*m2+-0.025f*m4           +-0.025f*m8+ 0.0277777778f*m9*omega+ 0.0138888889f*m10+-0.083333333f*m11*omega+-0.041666667f*m12                   +  0.25f*m15*omega+  0.125f*m16          + -0.125f*m18;
//f18-= 0.06349206f*m1+ 0.003968254f*m2           +-0.025f*m6+-0.025f*m8+-0.0555555556f*m9*omega+-0.0277777778f*m10                                                   +  0.25f*m14                          + -0.125f*m17+  0.125f*m18;

//f0 -= -30.f*19.f*m1/2394.f+ 12.f*m2/252.f                                                                                                                                                                               ;
//f1 -= -11.f*19.f*m1/2394.f+ -4.f*m2/252.f+ -4.f*m4/40.f                            +  2.f*m9*omega/36.f+ -4.f*m10/72.f                                                                                                  ;
//f2 -= -11.f*19.f*m1/2394.f+ -4.f*m2/252.f              + -4.f*m6/40.f              + -    m9*omega/36.f+  2.f*m10/72.f+  m11*omega/12.f+ -2.f*m12/24.f                                                                  ;
//f3 -= -11.f*19.f*m1/2394.f+ -4.f*m2/252.f+  4.f*m4/40.f                            +  2.f*m9*omega/36.f+ -4.f*m10/72.f                                                                                                  ;
//f4 -= -11.f*19.f*m1/2394.f+ -4.f*m2/252.f              +  4.f*m6/40.f              + -    m9*omega/36.f+  2.f*m10/72.f+  m11*omega/12.f+ -2.f*m12/24.f                                                                  ;
//f5 -=   8.f*19.f*m1/2394.f+      m2/252.f+      m4/40.f+      m6/40.f              +      m9*omega/36.f+      m10/72.f+  m11*omega/12.f+      m12/24.f+  m13/4.f                          +  m16/8.f+ -m17/8.f          ;
//f6 -=   8.f*19.f*m1/2394.f+      m2/252.f+ -    m4/40.f+      m6/40.f              +      m9*omega/36.f+      m10/72.f+  m11*omega/12.f+      m12/24.f+ -m13/4.f                          + -m16/8.f+ -m17/8.f          ;
//f7 -=   8.f*19.f*m1/2394.f+      m2/252.f+ -    m4/40.f+ -    m6/40.f              +      m9*omega/36.f+      m10/72.f+  m11*omega/12.f+      m12/24.f+  m13/4.f                          + -m16/8.f+  m17/8.f          ;
//f8 -=   8.f*19.f*m1/2394.f+      m2/252.f+      m4/40.f+ -    m6/40.f              +      m9*omega/36.f+      m10/72.f+  m11*omega/12.f+      m12/24.f+ -m13/4.f                          +  m16/8.f+  m17/8.f          ;
//f9 -= -11.f*19.f*m1/2394.f+ -4.f*m2/252.f                            + -4.f*m8/40.f+ -    m9*omega/36.f+  2.f*m10/72.f+ -m11*omega/12.f+  2.f*m12/24.f                                                                  ;
//f10-=   8.f*19.f*m1/2394.f+      m2/252.f+      m4/40.f              +      m8/40.f+      m9*omega/36.f+      m10/72.f+ -m11*omega/12.f+ -    m12/24.f                    +  m15*omega/4.f+ -m16/8.f          +  m18/8.f;
//f11-=   8.f*19.f*m1/2394.f+      m2/252.f              +      m6/40.f+      m8/40.f+ -2.f*m9*omega/36.f+ -2.f*m10/72.f                                          +  m14/4.f                          +  m17/8.f+ -m18/8.f;
//f12-=   8.f*19.f*m1/2394.f+      m2/252.f+ -    m4/40.f              +      m8/40.f+      m9*omega/36.f+      m10/72.f+ -m11*omega/12.f+ -    m12/24.f                    + -m15*omega/4.f+  m16/8.f          +  m18/8.f;
//f13-=   8.f*19.f*m1/2394.f+      m2/252.f              + -    m6/40.f+      m8/40.f+ -2.f*m9*omega/36.f+ -2.f*m10/72.f                                          + -m14/4.f                          + -m17/8.f+ -m18/8.f;
//f14-= -11.f*19.f*m1/2394.f+ -4.f*m2/252.f                            +  4.f*m8/40.f+ -    m9*omega/36.f+  2.f*m10/72.f+ -m11*omega/12.f+  2.f*m12/24.f                                                                  ;
//f15-=   8.f*19.f*m1/2394.f+      m2/252.f+      m4/40.f              + -    m8/40.f+      m9*omega/36.f+      m10/72.f+ -m11*omega/12.f+ -    m12/24.f                    + -m15*omega/4.f+ -m16/8.f          + -m18/8.f;
//f16-=   8.f*19.f*m1/2394.f+      m2/252.f              +      m6/40.f+ -    m8/40.f+ -2.f*m9*omega/36.f+ -2.f*m10/72.f                                          + -m14/4.f                          +  m17/8.f+  m18/8.f;
//f17-=   8.f*19.f*m1/2394.f+      m2/252.f+ -    m4/40.f              + -    m8/40.f+      m9*omega/36.f+      m10/72.f+ -m11*omega/12.f+ -    m12/24.f                    +  m15*omega/4.f+  m16/8.f          + -m18/8.f;
//f18-=   8.f*19.f*m1/2394.f+      m2/252.f              + -    m6/40.f+ -    m8/40.f+ -2.f*m9*omega/36.f+ -2.f*m10/72.f                                          +  m14/4.f                          + -m17/8.f+  m18/8.f;

//f0 -= -30.f*m1/2394.f+ 12.f*m2/252.f+  0.f*m4/40.f+  0.f*m6/40.f+  0.f*m8/40.f+  0.f*m9*omega/36.f+  0.f*m10/72.f+  0.f*m11*omega/12.f+  0.f*m12/24.f+  0.f*m13/4.f+  0.f*m14/4.f+  0.f*m15*omega/4.f+  0.f*m16/8.f+  0.f*m17/8.f+  0.f*m18/8.f;
//f1 -= -11.f*m1/2394.f+ -4.f*m2/252.f+ -4.f*m4/40.f+  0.f*m6/40.f+  0.f*m8/40.f+  2.f*m9*omega/36.f+ -4.f*m10/72.f+  0.f*m11*omega/12.f+  0.f*m12/24.f+  0.f*m13/4.f+  0.f*m14/4.f+  0.f*m15*omega/4.f+  0.f*m16/8.f+  0.f*m17/8.f+  0.f*m18/8.f;
//f2 -= -11.f*m1/2394.f+ -4.f*m2/252.f+  0.f*m4/40.f+ -4.f*m6/40.f+  0.f*m8/40.f+ -1.f*m9*omega/36.f+  2.f*m10/72.f+  1.f*m11*omega/12.f+ -2.f*m12/24.f+  0.f*m13/4.f+  0.f*m14/4.f+  0.f*m15*omega/4.f+  0.f*m16/8.f+  0.f*m17/8.f+  0.f*m18/8.f;
//f3 -= -11.f*m1/2394.f+ -4.f*m2/252.f+  4.f*m4/40.f+  0.f*m6/40.f+  0.f*m8/40.f+  2.f*m9*omega/36.f+ -4.f*m10/72.f+  0.f*m11*omega/12.f+  0.f*m12/24.f+  0.f*m13/4.f+  0.f*m14/4.f+  0.f*m15*omega/4.f+  0.f*m16/8.f+  0.f*m17/8.f+  0.f*m18/8.f;
//f4 -= -11.f*m1/2394.f+ -4.f*m2/252.f+  0.f*m4/40.f+  4.f*m6/40.f+  0.f*m8/40.f+ -1.f*m9*omega/36.f+  2.f*m10/72.f+  1.f*m11*omega/12.f+ -2.f*m12/24.f+  0.f*m13/4.f+  0.f*m14/4.f+  0.f*m15*omega/4.f+  0.f*m16/8.f+  0.f*m17/8.f+  0.f*m18/8.f;
//f5 -=   8.f*m1/2394.f+  1.f*m2/252.f+  1.f*m4/40.f+  1.f*m6/40.f+  0.f*m8/40.f+  1.f*m9*omega/36.f+  1.f*m10/72.f+  1.f*m11*omega/12.f+  1.f*m12/24.f+  1.f*m13/4.f+  0.f*m14/4.f+  0.f*m15*omega/4.f+  1.f*m16/8.f+ -1.f*m17/8.f+  0.f*m18/8.f;
//f6 -=   8.f*m1/2394.f+  1.f*m2/252.f+ -1.f*m4/40.f+  1.f*m6/40.f+  0.f*m8/40.f+  1.f*m9*omega/36.f+  1.f*m10/72.f+  1.f*m11*omega/12.f+  1.f*m12/24.f+ -1.f*m13/4.f+  0.f*m14/4.f+  0.f*m15*omega/4.f+ -1.f*m16/8.f+ -1.f*m17/8.f+  0.f*m18/8.f;
//f7 -=   8.f*m1/2394.f+  1.f*m2/252.f+ -1.f*m4/40.f+ -1.f*m6/40.f+  0.f*m8/40.f+  1.f*m9*omega/36.f+  1.f*m10/72.f+  1.f*m11*omega/12.f+  1.f*m12/24.f+  1.f*m13/4.f+  0.f*m14/4.f+  0.f*m15*omega/4.f+ -1.f*m16/8.f+  1.f*m17/8.f+  0.f*m18/8.f;
//f8 -=   8.f*m1/2394.f+  1.f*m2/252.f+  1.f*m4/40.f+ -1.f*m6/40.f+  0.f*m8/40.f+  1.f*m9*omega/36.f+  1.f*m10/72.f+  1.f*m11*omega/12.f+  1.f*m12/24.f+ -1.f*m13/4.f+  0.f*m14/4.f+  0.f*m15*omega/4.f+  1.f*m16/8.f+  1.f*m17/8.f+  0.f*m18/8.f;
//f9 -= -11.f*m1/2394.f+ -4.f*m2/252.f+  0.f*m4/40.f+  0.f*m6/40.f+ -4.f*m8/40.f+ -1.f*m9*omega/36.f+  2.f*m10/72.f+ -1.f*m11*omega/12.f+  2.f*m12/24.f+  0.f*m13/4.f+  0.f*m14/4.f+  0.f*m15*omega/4.f+  0.f*m16/8.f+  0.f*m17/8.f+  0.f*m18/8.f;
//f10-=   8.f*m1/2394.f+  1.f*m2/252.f+  1.f*m4/40.f+  0.f*m6/40.f+  1.f*m8/40.f+  1.f*m9*omega/36.f+  1.f*m10/72.f+ -1.f*m11*omega/12.f+ -1.f*m12/24.f+  0.f*m13/4.f+  0.f*m14/4.f+  1.f*m15*omega/4.f+ -1.f*m16/8.f+  0.f*m17/8.f+  1.f*m18/8.f;
//f11-=   8.f*m1/2394.f+  1.f*m2/252.f+  0.f*m4/40.f+  1.f*m6/40.f+  1.f*m8/40.f+ -2.f*m9*omega/36.f+ -2.f*m10/72.f+  0.f*m11*omega/12.f+  0.f*m12/24.f+  0.f*m13/4.f+  1.f*m14/4.f+  0.f*m15*omega/4.f+  0.f*m16/8.f+  1.f*m17/8.f+ -1.f*m18/8.f;
//f12-=   8.f*m1/2394.f+  1.f*m2/252.f+ -1.f*m4/40.f+  0.f*m6/40.f+  1.f*m8/40.f+  1.f*m9*omega/36.f+  1.f*m10/72.f+ -1.f*m11*omega/12.f+ -1.f*m12/24.f+  0.f*m13/4.f+  0.f*m14/4.f+ -1.f*m15*omega/4.f+  1.f*m16/8.f+  0.f*m17/8.f+  1.f*m18/8.f;
//f13-=   8.f*m1/2394.f+  1.f*m2/252.f+  0.f*m4/40.f+ -1.f*m6/40.f+  1.f*m8/40.f+ -2.f*m9*omega/36.f+ -2.f*m10/72.f+  0.f*m11*omega/12.f+  0.f*m12/24.f+  0.f*m13/4.f+ -1.f*m14/4.f+  0.f*m15*omega/4.f+  0.f*m16/8.f+ -1.f*m17/8.f+ -1.f*m18/8.f;
//f14-= -11.f*m1/2394.f+ -4.f*m2/252.f+  0.f*m4/40.f+  0.f*m6/40.f+  4.f*m8/40.f+ -1.f*m9*omega/36.f+  2.f*m10/72.f+ -1.f*m11*omega/12.f+  2.f*m12/24.f+  0.f*m13/4.f+  0.f*m14/4.f+  0.f*m15*omega/4.f+  0.f*m16/8.f+  0.f*m17/8.f+  0.f*m18/8.f;
//f15-=   8.f*m1/2394.f+  1.f*m2/252.f+  1.f*m4/40.f+  0.f*m6/40.f+ -1.f*m8/40.f+  1.f*m9*omega/36.f+  1.f*m10/72.f+ -1.f*m11*omega/12.f+ -1.f*m12/24.f+  0.f*m13/4.f+  0.f*m14/4.f+ -1.f*m15*omega/4.f+ -1.f*m16/8.f+  0.f*m17/8.f+ -1.f*m18/8.f;
//f16-=   8.f*m1/2394.f+  1.f*m2/252.f+  0.f*m4/40.f+  1.f*m6/40.f+ -1.f*m8/40.f+ -2.f*m9*omega/36.f+ -2.f*m10/72.f+  0.f*m11*omega/12.f+  0.f*m12/24.f+  0.f*m13/4.f+ -1.f*m14/4.f+  0.f*m15*omega/4.f+  0.f*m16/8.f+  1.f*m17/8.f+  1.f*m18/8.f;
//f17-=   8.f*m1/2394.f+  1.f*m2/252.f+ -1.f*m4/40.f+  0.f*m6/40.f+ -1.f*m8/40.f+  1.f*m9*omega/36.f+  1.f*m10/72.f+ -1.f*m11*omega/12.f+ -1.f*m12/24.f+  0.f*m13/4.f+  0.f*m14/4.f+  1.f*m15*omega/4.f+  1.f*m16/8.f+  0.f*m17/8.f+ -1.f*m18/8.f;
//f18-=   8.f*m1/2394.f+  1.f*m2/252.f+  0.f*m4/40.f+ -1.f*m6/40.f+ -1.f*m8/40.f+ -2.f*m9*omega/36.f+ -2.f*m10/72.f+  0.f*m11*omega/12.f+  0.f*m12/24.f+  0.f*m13/4.f+  1.f*m14/4.f+  0.f*m15*omega/4.f+  0.f*m16/8.f+ -1.f*m17/8.f+  1.f*m18/8.f;



















//f0  -= - 0.012531328f*(m1)+  0.047619048f*(m2);
//f1  -= -0.0045948204f*(m1)+ -0.015873016f*(m2)+   -0.1f*(m4)                                                      +  0.055555556f*(m9)*omega + -0.055555556f*(m10);
//f2  -= -0.0045948204f*(m1)+ -0.015873016f*(m2)                           +   -0.1f*(m6)                           + -0.027777778f*(m9)*omega +  0.027777778f*(m10);
//f3  -= -0.0045948204f*(m1)+ -0.015873016f*(m2)+    0.1f*(m4)                                                      +  0.055555556f*(m9)*omega + -0.055555556f*(m10);
//f4  -= -0.0045948204f*(m1)+ -0.015873016f*(m2)                           +    0.1f*(m6)                           + -0.027777778f*(m9)*omega +  0.027777778f*(m10);
//f5  -=  0.0033416876f*(m1)+  0.003968254f*(m2)+  0.025f*(m4)+  0.025f*(m6)                           +  0.027777778f*(m9)*omega +  0.013888889f*(m10);
//f6  -=  0.0033416876f*(m1)+  0.003968254f*(m2)+ -0.025f*(m4)+  0.025f*(m6)                           +  0.027777778f*(m9)*omega +  0.013888889f*(m10);
//f7  -=  0.0033416876f*(m1)+  0.003968254f*(m2)+ -0.025f*(m4)+ -0.025f*(m6)                           +  0.027777778f*(m9)*omega +  0.013888889f*(m10);
//f8  -=  0.0033416876f*(m1)+  0.003968254f*(m2)+  0.025f*(m4)+ -0.025f*(m6)                           +  0.027777778f*(m9)*omega +  0.013888889f*(m10);
//f9  -= -0.0045948204f*(m1)+ -0.015873016f*(m2)                                                      +   -0.1f*(m8)+ -0.027777778f*(m9)*omega +  0.027777778f*(m10);
//f10 -=  0.0033416876f*(m1)+  0.003968254f*(m2)+  0.025f*(m4)                           +  0.025f*(m8)+  0.027777778f*(m9)*omega +  0.013888889f*(m10);
//f11 -=  0.0033416876f*(m1)+  0.003968254f*(m2)                           +  0.025f*(m6)+  0.025f*(m8)+ -0.055555556f*(m9)*omega + -0.027777778f*(m10);
//f12 -=  0.0033416876f*(m1)+  0.003968254f*(m2)+ -0.025f*(m4)                           +  0.025f*(m8)+  0.027777778f*(m9)*omega +  0.013888889f*(m10);
//f13 -=  0.0033416876f*(m1)+  0.003968254f*(m2)                           + -0.025f*(m6)+  0.025f*(m8)+ -0.055555556f*(m9)*omega + -0.027777778f*(m10);
//f14 -= -0.0045948204f*(m1)+ -0.015873016f*(m2)                                                      +    0.1f*(m8)+ -0.027777778f*(m9)*omega +  0.027777778f*(m10);
//f15 -=  0.0033416876f*(m1)+  0.003968254f*(m2)+  0.025f*(m4)                           + -0.025f*(m8)+  0.027777778f*(m9)*omega +  0.013888889f*(m10);
//f16 -=  0.0033416876f*(m1)+  0.003968254f*(m2)                           +  0.025f*(m6)+ -0.025f*(m8)+ -0.055555556f*(m9)*omega + -0.027777778f*(m10);
//f17 -=  0.0033416876f*(m1)+  0.003968254f*(m2)+ -0.025f*(m4)                           + -0.025f*(m8)+  0.027777778f*(m9)*omega +  0.013888889f*(m10);
//f18 -=  0.0033416876f*(m1)+  0.003968254f*(m2)                           + -0.025f*(m6)+ -0.025f*(m8)+ -0.055555556f*(m9)*omega + -0.027777778f*(m10);
//
//f2  -=  0.083333333f*(m11)*omega + -0.083333333f*(m12);
//f4  -=  0.083333333f*(m11)*omega + -0.083333333f*(m12);
//f5  -=  0.083333333f*(m11)*omega +  0.041666667f*(m12)+ ( 0.25f*(m13)                                                )*omega; 
//f6  -=  0.083333333f*(m11)*omega +  0.041666667f*(m12)+ (-0.25f*(m13)                                                )*omega; 
//f7  -=  0.083333333f*(m11)*omega +  0.041666667f*(m12)+ ( 0.25f*(m13)                                                )*omega; 
//f8  -=  0.083333333f*(m11)*omega +  0.041666667f*(m12)+ (-0.25f*(m13)                                                )*omega; 
//f9  -= -0.083333333f*(m11)*omega +  0.083333333f*(m12);
//f10 -= -0.083333333f*(m11)*omega + -0.041666667f*(m12) +(                                              +  0.25f*(m15))*omega ;
//f11 -=                                                                         +(                         0.25f*(m14)                        )*omega ;
//f12 -= -0.083333333f*(m11)*omega + -0.041666667f*(m12) +(                                              + -0.25f*(m15))*omega ;
//f13 -=                                                                         +(                        -0.25f*(m14)                        )*omega ;
//f14 -= -0.083333333f*(m11)*omega +  0.083333333f*(m12);
//f15 -= -0.083333333f*(m11)*omega + -0.041666667f*(m12) +(                                              + -0.25f*(m15))*omega ;
//f16 -=                                                                         +(                        -0.25f*(m14)                        )*omega ;
//f17 -= -0.083333333f*(m11)*omega + -0.041666667f*(m12) +(                                              +  0.25f*(m15))*omega ;
//f18 -=                                                                         +(                         0.25f*(m14)                        )*omega ;
//
//f5  -=  0.125f*(m16)+ -0.125f*(m17);                        
//f6  -= -0.125f*(m16)+ -0.125f*(m17);                        
//f7  -= -0.125f*(m16)+  0.125f*(m17);                        
//f8  -=  0.125f*(m16)+  0.125f*(m17);                        
//f10 -= -0.125f*(m16)                              +  0.125f*(m18);
//f11 -=                             +  0.125f*(m17)+ -0.125f*(m18);
//f12 -=  0.125f*(m16)                              +  0.125f*(m18);
//f13 -=                             + -0.125f*(m17)+ -0.125f*(m18);
//f15 -= -0.125f*(m16)                              + -0.125f*(m18);
//f16 -=                             +  0.125f*(m17)+  0.125f*(m18);
//f17 -=  0.125f*(m16)                              + -0.125f*(m18);
//f18 -=                             + -0.125f*(m17)+  0.125f*(m18);

    cout<<f0 <<endl;
    cout<<f1 <<endl;
    cout<<f3 <<endl;
    cout<<f2 <<endl;
    cout<<f5 <<endl;
    cout<<f6 <<endl;
    cout<<f4 <<endl;
    cout<<f7 <<endl;
    cout<<f8 <<endl;
    cout<<f9 <<endl;
    cout<<f10<<endl;
    cout<<f11<<endl;
    cout<<f12<<endl;
    cout<<f13<<endl;
    cout<<f14<<endl;
    cout<<f15<<endl;
    cout<<f16<<endl;
    cout<<f17<<endl;




    return 0;
}
