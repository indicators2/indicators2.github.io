//+------------------------------------------------------------------+
//|                                          i_Alex_Activity_v02.mq4 |
//+------------------------------------------------------------------+
#property copyright "fion"
#property link      ""

//---- indicator settings
#property  indicator_separate_window
#property  indicator_buffers 1
#property  indicator_color1  SkyBlue
#property  indicator_width1  2
//---- indicator parameters
extern int    BARS_Period=4;// период

//---- indicator buffers
double     LevelBuffer[]; int mp; string name;
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int init()
  {
   IndicatorBuffers(1);
   IndicatorDigits(1);
//---- 1 indicator buffers mapping
   SetIndexStyle(0,DRAW_HISTOGRAM);
   SetIndexBuffer(0,LevelBuffer);
//---- name for DataWindow and indicator subwindow label
   if(BARS_Period<1)BARS_Period=1;
   name = "i_Alex_Activity("+BARS_Period+")_v02";
   IndicatorShortName(name);
  //---- initialization done
   mp=1; if(Digits==3 || Digits==5)mp=10;
   return(0);
  }
//--------------------------------------------------------------------
int deinit(){ return(0);}
//+------------------------------------------------------------------+
//| Moving Average of Oscillator                                     |
//+------------------------------------------------------------------+
int start()
  {
   if(BARS_Period<1)BARS_Period=1;
   int limit;
   int counted_bars=IndicatorCounted();
//---- last counted bar will be recounted
   if(counted_bars>0) counted_bars--;
   limit=Bars-counted_bars;
//---- macd counted in the 1-st additional buffer
   for(int i=0; i<limit; i++){
       LevelBuffer[i]=Summa(i,BARS_Period);
       }
//---- done
   return(0);
  }
//+------------------------------------------------------------------+
int Summa(int shift,int bars){
int summa=0;
for(int i=shift; i<shift+bars; i++)
   {
    if(Close[i]-Open[i]>=0)summa+=(Close[i]-Open[i])/Point;
     else summa+=-(Open[i]-Close[i])/Point;
   }
return (summa/mp);
}

