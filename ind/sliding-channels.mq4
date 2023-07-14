//+------------+-----------------------------------------------------+
//| v.07.04.07 |                                 SlidingChannels.mq4 |
//+------------+                               "КАНАЛИЗАЦИЯ ФОРЕКСА" |
//|            |              Bookkeeper, 2007, yuzefovich@gmail.com |
//+------------+-----------------------------------------------------+
#property copyright ""
#property link      ""
//----
#property indicator_chart_window
//+------------------------------------------------------------------+
extern int    SR     = 3;  // = ZZx2
extern int    MainRZZ= 13; // = ZZx2
extern int    FP     = 21;
extern int    SMF    = 3;
extern int    NCHs   = 3; // сколько каналов строить на истории
                         // для "поглядеть" до 9 вкл., для работы =2
extern string Prefix="SCHs"; 
//+------------------------------------------------------------------+
double SA[];
double SM[];
//+------------------------------------------------------------------+
int   SSFR[11]={0,0,0,0,0,0,0,0,0,0,0};
color CCHs[11]={Black,
                Navy,
                DarkBlue,
                MediumBlue,
                RoyalBlue,
                CornflowerBlue,
                CornflowerBlue,
                CornflowerBlue,
                CornflowerBlue,
                CornflowerBlue,
                CornflowerBlue};
//+------------------------------------------------------------------+
double TCH1=0, TS=0;
int    MaxBar;
bool   First=true;
int    prevBars=0;
string GlobName;
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
void SACalc(int Pos) { int sw, i, w, ww, Shift; double sum;
SA[Pos]=iMA(NULL,0,SR+1,0,MODE_LWMA,PRICE_OPEN,Pos);
for(Shift=Pos+SR+2;Shift>Pos;Shift--) { sum=0.0; sw=0; i=0; w=Shift+SR;
ww=Shift-SR; if(ww<Pos) ww=Pos;
while(w>=Shift) {i++; sum=sum+i*SPrice(w); sw=sw+i; w--; }
while(w>=ww) { i--; sum=sum+i*SPrice(w); sw=sw+i; w--; }
SA[Shift]=sum/sw; } return; }
//----
double SPrice(int i) { return(Open[i]); }
//----
void SMCalc(int i) { double t, b;
for(int Shift=i+SR+2;Shift>=i;Shift--) {
t=SA[ArrayMaximum(SA,FP,Shift)]; b=SA[ArrayMinimum(SA,FP,Shift)];
SM[Shift]=(2*(2+SMF)*SA[Shift]-(t+b))/2/(1+SMF); } return; }
//+------------------------------------------------------------------+
void MainCalculation(int Pos) {
if((Bars-Pos)>(SR+1)) SACalc(Pos); else SA[Pos]=0; 
if((Bars-Pos)>(FP+SR+2)) SMCalc(Pos); else SM[Pos]=0; return; }
//+------------------------------------------------------------------+
void DelObj(string NO) { int N,i; N=ObjectsTotal(); 
for(i=N;i>=0;i--) { if(ObjectName(i)==NO) ObjectDelete(NO); } return;}
//+------------------------------------------------------------------+
//+         Для построения канала приспособлен код ANG3110           +
//+------------------------------------------------------------------+
int DrawTCH(int BarE, int BarB, int Num) { color CHcolor=Navy;
int p,i,n,f,f1,ai_1,ai_2,bi_1,bi_2,p1,p0,p2,fp;
double lr,lr0,lrp,sx,sy,sxy,sx2,aa,bb,dh,dl,dh_1,dl_1,dh_2,dl_2;
double hai,lai,dhi,dli,dhm,dlm,ha0,hap,la0,lap;
double price_p1,price_p0,price_p2,price_01,price_00,price_02;
string CHName=GlobName+Num,LName;
sx=0; sy=0; sxy=0; sx2=0; p=BarE-BarB;
for (n=0; n<=p; n++) { 
sx+=n; sy+=Close[n+BarB]; sxy+=n*Close[n+BarB]; sx2+=MathPow(n,2); } 
aa=(sx*sy-(p+1)*sxy)/(MathPow(sx,2)-(p+1)*sx2); bb=(sy-aa*sx)/(p+1);
for (i=0;i<=p;i++) { lr=bb+aa*i;dh=High[i+BarB]-lr;dl=Low[i+BarB]-lr;
if (i<p/2) { if (i==0) {dh_1=0.0; dl_1=0.0; ai_1=i; bi_1=i;} 
if (dh>=dh_1) {dh_1=dh; ai_1=i;} if (dl<=dl_1) {dl_1=dl; bi_1=i;} }  
if (i>=p/2) { if (i==p/2) {dh_2=0.0; dl_2=0.0; ai_2=i; bi_2=i;} 
if (dh>=dh_2) {dh_2=dh; ai_2=i;} if (dl<=dl_2) {dl_2=dl; bi_2=i;} } } 
lr0=bb; lrp=bb+aa*(i+p);
if (MathAbs(ai_1-ai_2)>MathAbs(bi_1-bi_2)) f=1;
if (MathAbs(ai_1-ai_2)<MathAbs(bi_1-bi_2)) f=2;
if (MathAbs(ai_1-ai_2)==MathAbs(bi_1-bi_2)) {
if (MathAbs(dh_1-dh_2)<MathAbs(dl_1-dl_2)) f=1;
if (MathAbs(dh_1-dh_2)>=MathAbs(dl_1-dl_2)) f=2; } 
if (f==1) { for (n=0; n<=20; n++) { f1=0; for (i=0; i<=p; i++) {
hai=High[ai_1+BarB]*(i-ai_2)/(ai_1-ai_2)+
    High[ai_2+BarB]*(i-ai_1)/(ai_2-ai_1);  
if (i==0 || i==p/2) dhm=0.0; 
if (High[i+BarB]-hai>dhm && i<p/2) {ai_1=i; f1=1;}
if (High[i+BarB]-hai>dhm && i>=p/2) {ai_2=i; f1=1;} } } 
for (i=0; i<=p; i++) {
hai=High[ai_1+BarB]*(i-ai_2)/(ai_1-ai_2)+
    High[ai_2+BarB]*(i-ai_1)/(ai_2-ai_1);  
dli=Low[i+BarB]-hai; if (i==0) dlm=0.0; if (dli<dlm) dlm=dli; }
ha0=High[ai_1+BarB]*(0-ai_2)/(ai_1-ai_2)+
    High[ai_2+BarB]*(0-ai_1)/(ai_2-ai_1); 
hap=High[ai_1+BarB]*(p-ai_2)/(ai_1-ai_2)+
    High[ai_2+BarB]*(p-ai_1)/(ai_2-ai_1);
price_p1=hap; price_p0=hap+dlm/2; price_p2=hap+dlm; price_01=ha0;
price_00=ha0+dlm/2; price_02=ha0+dlm; }
if (f==2) { for (n=0; n<=20; n++) { f1=0; for (i=0; i<=p; i++) {
lai=Low[bi_1+BarB]*(i-bi_2)/(bi_1-bi_2)+
    Low[bi_2+BarB]*(i-bi_1)/(bi_2-bi_1); 
if (i==0 || i==p/2) dlm=0.0; 
if (Low[i+BarB]-lai<dlm && i<p/2) {bi_1=i; f1=1;}
if (Low[i+BarB]-lai<dlm && i>=p/2) {bi_2=i; f1=1;} } }
for (i=0; i<=p; i++) { 
lai=Low[bi_1+BarB]*(i-bi_2)/(bi_1-bi_2)+
    Low[bi_2+BarB]*(i-bi_1)/(bi_2-bi_1); 
dhi=High[i+BarB]-lai; if (i==0) dhm=0.0; if (dhi>dhm) dhm=dhi; }   
la0=Low[bi_1+BarB]*(0-bi_2)/(bi_1-bi_2)+
    Low[bi_2+BarB]*(0-bi_1)/(bi_2-bi_1); 
lap=Low[bi_1+BarB]*(p-bi_2)/(bi_1-bi_2)+
    Low[bi_2+BarB]*(p-bi_1)/(bi_2-bi_1);
price_p1=lap; price_p0=lap+dhm/2; price_p2=lap+dhm; price_01=la0;
price_00=la0+dhm/2; price_02=la0+dhm; }
LName=CHName+"1"; DelObj(LName);
aa=MathMax(price_p1,price_p2); bb=MathMax(price_01,price_02);
ObjectCreate(LName,OBJ_TREND,0,Time[p+BarB],aa,Time[BarB],bb);
ObjectSet(LName,OBJPROP_COLOR,CCHs[Num]);
switch(Num) { 
case 0: 
ObjectSet(LName,OBJPROP_STYLE,STYLE_DASHDOTDOT);  break;
case 1: 
TCH1=100*(price_01-price_p1)/p/Point;
ObjectSet(LName,OBJPROP_STYLE,STYLE_SOLID);
ObjectSet(LName,OBJPROP_WIDTH,2); break;
case 2: 
ObjectSet(LName,OBJPROP_STYLE,STYLE_SOLID);  break;
default: 
ObjectSet(LName,OBJPROP_STYLE,STYLE_DOT);  break; }
LName=CHName+"2"; DelObj(LName);
aa=MathMin(price_p1,price_p2); bb=MathMin(price_01,price_02);
ObjectCreate(LName,OBJ_TREND,0,Time[p+BarB],aa,Time[BarB],bb);
ObjectSet(LName,OBJPROP_COLOR,CCHs[Num]);
switch(Num) { 
case 0: 
ObjectSet(LName,OBJPROP_STYLE,STYLE_DASHDOTDOT);  break;
case 1: 
ObjectSet(LName,OBJPROP_STYLE,STYLE_SOLID);
ObjectSet(LName,OBJPROP_WIDTH,2); break;
case 2: 
ObjectSet(LName,OBJPROP_STYLE,STYLE_SOLID);  break;
default: 
ObjectSet(LName,OBJPROP_STYLE,STYLE_DOT);  break; }
if(Num==1) { 
LName=CHName+"01"; DelObj(LName);
aa=price_p1*0.618+price_p2*0.382; bb=price_01*0.618+price_02*0.382;
ObjectCreate(LName,OBJ_TREND,0,Time[p+BarB],aa,Time[BarB],bb);
ObjectSet(LName,OBJPROP_COLOR,CLR_NONE);
ObjectSet(LName,OBJPROP_STYLE,STYLE_DASH);
LName=CHName+"02"; DelObj(LName);
aa=price_p1*0.382+price_p2*0.618; bb=price_01*0.382+price_02*0.618;
ObjectCreate(LName,OBJ_TREND,0,Time[p+BarB],aa,Time[BarB],bb);
ObjectSet(LName,OBJPROP_COLOR,CLR_NONE);
ObjectSet(LName,OBJPROP_STYLE,STYLE_DASH);
LName=CHName+"011"; DelObj(LName);
if(price_p1>price_01) {
aa=MathMax(price_p1,price_p2)*0.764+MathMin(price_p1,price_p2)*0.236; 
bb=MathMax(price_01,price_02)*0.764+MathMin(price_01,price_02)*0.236; }
else { 
aa=MathMin(price_p1,price_p2)*0.764+MathMax(price_p1,price_p2)*0.236; 
bb=MathMin(price_01,price_02)*0.764+MathMax(price_01,price_02)*0.236; }
ObjectCreate(LName,OBJ_TREND,0,Time[p+BarB],aa,Time[BarB],bb);
ObjectSet(LName,OBJPROP_COLOR,CLR_NONE);
ObjectSet(LName,OBJPROP_STYLE,STYLE_DASH); } return(0); }
//+------------------------------------------------------------------+
void SSCalc(int Pos) { int i,RBar,LBar,ZZ,NZZ,NZig,NZag; 
i=Pos-1; NZig=0; NZag=0; SSFR[0]=0;
while(i<MaxBar && ZZ==0) { i++; RBar=i-MainRZZ; if(RBar<Pos) RBar=Pos;
LBar=i+MainRZZ;
if(i==ArrayMinimum(SM,LBar-RBar+1,RBar)) { ZZ=-1; NZig=i; }
if(i==ArrayMaximum(SM,LBar-RBar+1,RBar)) { ZZ=1;NZag=i; } }
if(ZZ==0) return; NZZ=0; if(i>Pos) { if(SM[i]>SM[Pos]) { if(ZZ==1) {
if(i>=Pos+MainRZZ && NZZ<(NCHs+2)) { NZZ++; SSFR[NZZ]=i; } NZag=i; } }
else { if(ZZ==-1) { 
if(i>=Pos+MainRZZ && NZZ<(NCHs+2)) { NZZ++; SSFR[NZZ]=i; } NZig=i; } } }
while(NZZ<(NCHs+2)) { RBar=i-MainRZZ; if(RBar<Pos) RBar=Pos; LBar=i+MainRZZ;
if(i==ArrayMinimum(SM,LBar-RBar+1,RBar)) { 
if(ZZ==-1 && SM[i]<SM[NZig]) { 
if(i>=Pos+MainRZZ && NZZ<(NCHs+2)) SSFR[NZZ]=i; NZig=i; }
if(ZZ==1) { if(i>=Pos+MainRZZ && NZZ<(NCHs+2)) { NZZ++; SSFR[NZZ]=i; } 
ZZ=-1; NZig=i; } } if(i==ArrayMaximum(SM,LBar-RBar+1,RBar)) {
if(ZZ==1 && SM[i]>SM[NZag]) { 
if(i>=Pos+MainRZZ && NZZ<(NCHs+2)) SSFR[NZZ]=i; NZag=i; }
if(ZZ==-1) { if(i>=Pos+MainRZZ && NZZ<(NCHs+2)) { NZZ++; SSFR[NZZ]=i; } 
ZZ=1; NZag=i; } } i++; if(i>=MaxBar) return; } return; }
//+------------------------------------------------------------------+
int init() { IndicatorBuffers(2); 
SetIndexBuffer(0,SA); SetIndexStyle(0,DRAW_NONE);
SetIndexBuffer(1,SM); SetIndexStyle(1,DRAW_NONE);
GlobName=Prefix+"_"+Symbol()+"_"+Period()+"_"; return(0); }
//+------------------------------------------------------------------+
void deinit() { int N,i; string SStr,NO;
N=ObjectsTotal(); for(i=N;i>=0;i--) {
NO=ObjectName(i); SStr=StringSubstr(NO,0,StringLen(GlobName));
if(SStr==GlobName) ObjectDelete(NO); } return; }
//+------------------------------------------------------------------+
void start() { int counted_bars=IndicatorCounted(); int i,j,k;
if(First==true) { if(Bars<=2*(MainRZZ+SR+2)) return(-1); if(SR<2) SR=2;
if(NCHs>9) NCHs=9; if(NCHs<2) NCHs=2;
if(MainRZZ<=SR) MainRZZ=SR+1; MaxBar=Bars-(MainRZZ+SR+2); First=false; }
if(prevBars!=Bars) { if(counted_bars<0) return(-1); 
if(counted_bars>0) counted_bars--; j=Bars-counted_bars; 
for(i=j;i>=0;i--) MainCalculation(i); SSCalc(0); 
if(NCHs==2) DrawTCH(SSFR[3],SSFR[1],0); 
DrawTCH(SSFR[1],0,1);
for(i=2;i<=NCHs;i++) DrawTCH(SSFR[i],SSFR[i-1]-MainRZZ,i); 
prevBars=Bars; } return; }
//+------------------------------------------------------------------+


