//------------------------------------
#property indicator_chart_window
#property indicator_buffers 4
#property indicator_color1 DeepSkyBlue
#property indicator_color2 SlateGray
#property indicator_color3 SlateGray
#property indicator_color4 SlateGray
//-------------------------------------
extern int Points = 0;
extern double Percent = 1.0;
extern bool chHL = false;
extern bool Texts = true;
extern color color_ZZ = DeepSkyBlue;
extern color color_txt = Yellow; 
extern bool Show_C0=false;
//------------------------
double zz[],hm,lm,ha[],la[],sa[];
double fxH[],fxL[],di;
int fs,ai,bi,ta,tb;
double HL,HLp,HL1,k,k0;
int i,bar;
//***************************************
int init() 
{

   IndicatorBuffers(6);
   SetIndexStyle(0,1,0,1,color_ZZ);
   SetIndexBuffer(0,zz);
   SetIndexEmptyValue(0,0.0); 
   SetIndexBuffer(1,ha);
   SetIndexBuffer(2,la);
   SetIndexStyle(3,DRAW_LINE,2);  
   SetIndexBuffer(3,sa);
   SetIndexBuffer(4,fxH);
   SetIndexBuffer(5,fxL);

   if (chHL==false) 
   {
    SetIndexDrawBegin(1,2*Bars); 
    SetIndexDrawBegin(2,2*Bars); 
    SetIndexDrawBegin(3,2*Bars);
   }
   else
   {
    SetIndexDrawBegin(1,1); 
    SetIndexDrawBegin(2,1); 
    SetIndexDrawBegin(3,1);
   }
  
   if (Points!=0 && Percent==0) di=Points*Point;

   if (Texts) 
   {
    if (Show_C0) ObjectCreate("AZZfx0",OBJ_TEXT,0,Time[0],Close[0]); 
    ObjectCreate("AZZfx1",OBJ_TEXT,0,Time[0],Close[0]+0.0004);
   }

   return(0); 
}

//********************************************************
int start() 
{
   int n,cbi;
   int IC=IndicatorCounted();
   if (IC>3) cbi=Bars-IC-1; else 
   {cbi=Bars-2; hm=High[Bars-1]; lm=Low[Bars-1]; ai=Bars-2; bi=Bars-1; fs=0;}
  
   //======================================================================================================================
   //-----------------Functions------------------------------   
   for (i=cbi; i>=0; i--) 
   {
      fxH[i]=High[i];  
      fxL[i]=Low[i];
   }
   //========================================================
   //========================================================
   for (i=cbi; i>=0; i--) 
   {
      //------------------------------------------------------
      if (Points!=0 && Percent!=0) return(0);
      if (Points==0 && Percent!=0) di=Percent*NormalizeDouble(Close[i],3)/100;
      //-------------------Trigger----------------------------
      if (i==0) 
      {
         if (ta!=Time[ai]) {ai++; ta=Time[ai];} 
         if (tb!=Time[bi]) {bi++; tb=Time[bi];}
      }
      //======================================================================
     
      if (fxH[i]-fxL[i]>=di) 
      { 
         //------------1---------------
       
         if ((fxH[i]+fxL[i])/2>=(ha[i+1]+la[i+1])/2) 
         {
            hm=fxH[i]; 
            lm=hm-di; 
            if (fs==2) {zz[bi]=Low[bi]; if (Texts) af_txt(1,fs);} 
            ai=i;
            ta=Time[ai]; 
            fs=1;
         } 
         
         else 
         //------------2---------------
         { 
            lm=fxL[i]; 
            hm=lm+di; 
            if (fs==1) {zz[ai]=High[ai]; if (Texts) af_txt(1,fs);}
            bi=i;
            tb=Time[bi]; 
            fs=2;
         }
      } 
     
      else 
     
      //------------------------fs=1----------------------------------
      if (fxH[i]>hm) 
      {
         hm=fxH[i]; 
         lm=hm-di; 
         if (fs==2) {zz[bi]=Low[bi]; if (Texts) af_txt(1,fs);} 
         ai=i;
         ta=Time[ai]; 
         fs=1;
      }
      else
      //-------------------------fs=2---------------------------------
      if (fxL[i]<lm) 
      { 
         lm=fxL[i]; 
         hm=lm+di; 
         if (fs==1) {zz[ai]=High[ai]; if (Texts) af_txt(1,fs);}
         bi=i; 
         tb=Time[bi];
         fs=2;
      }
      //----------------------------------------------------------------
     
      ha[i]=hm; 
      la[i]=lm;
      sa[i]=(ha[i]+la[i])/2;
      
      //======================i=0======================================== 
      if (i==0) 
      {
         if (fs==1) for (n=0; n<=bi; n++) zz[n]=0.0;
         if (fs==2) for (n=0; n<=ai; n++) zz[n]=0.0;

         if (Show_C0) zz[0]=Close[0];
         zz[ai]=fxH[ai];
         zz[bi]=fxL[bi];

         if (Texts) af_txt(0,fs); 
      }
   } 
   //====================================================================================================
/*
   Comment
   (
     "fs = ",fs,"\n",
     "ai = ",ai,"\n",
     "bi = ",bi,"\n",
     "HLp = ",DoubleToStr(HLp/Point,0),"\n",
     "HL = ",DoubleToStr(HL/Point,0),"\n",
     "HL1 = ",DoubleToStr(HL1/Point,0)
   );
*/
   //======================================
   return(0); 
}
//*************************************************************************************************
void af_txt(int index, int fs)
{
   if (index==1)
   {
      HLp=HL; 
      HL=fxH[ai]-fxL[bi];
      if (HLp!=0) k=HL/HLp;
      
      if (fs==1)
      {
         ObjectCreate("AZZfx"+Time[ai],OBJ_TEXT,0,Time[ai],High[ai]+0.0007);
         ObjectSetText("AZZfx"+Time[ai]," "+DoubleToStr(k,2),8,"Arial",color_txt); 
      }
      
      if (fs==2)
      {
         ObjectCreate("AZZfx"+Time[bi],OBJ_TEXT,0,Time[bi],Low[bi]-0.0003);
         ObjectSetText("AZZfx"+Time[bi]," "+DoubleToStr(k,2),8,"Arial",color_txt);
      }
   }
    
   if (index==0)
   {
      HL1=fxH[ai]-fxL[bi];
      if (HL!=0) k=HL1/HL;

      if (fs==1) 
      {
         ObjectMove("AZZfx1",0,Time[ai],High[ai]+0.0007);
          
         if (Show_C0)
         {
           if (ai!=0)  
           {
              k0=MathAbs((fxH[ai]-Close[0])/HL1);
              ObjectMove("AZZfx0",0,Time[0],Low[0]-0.0003);
           }  
           else
           ObjectMove("AZZfx0",0,Time[0],0);
         }
      } 

      if (fs==2) 
      {
         ObjectMove("AZZfx1",0,Time[bi],Low[bi]-0.0003);
          
         if (Show_C0)
         {
           if (bi!=0) 
           {
              k0=MathAbs((fxL[bi]-Close[0])/HL1);
              ObjectMove("AZZfx0",0,Time[0],High[0]+0.0007);
           }
           else 
           ObjectMove("AZZfx0",0,Time[0],0);
         }
      }
           
      ObjectSetText("AZZfx1"," "+DoubleToStr(k,2),8,"Arial",Lime);
      if (Show_C0) ObjectSetText("AZZfx0"," "+DoubleToStr(k0,2),8,"Arial",Orange);
   }
    return;
}
//*************************************************
int deinit() 
{
  for (int i=Bars-1; i>=0; i--) ObjectDelete("AZZfx"+Time[i]); 
  ObjectDelete("AZZfx1"); 
  ObjectDelete("AZZfx0");
  return(0);
}
//*************************************************