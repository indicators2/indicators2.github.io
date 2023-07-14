//+------------------------------------------------------------------+
//|                                             BBands_Stop_v1.2.mq4 |
//|                           Copyright © 2006, TrendLaboratory Ltd. |
//|            http://finance.groups.yahoo.com/group/TrendLaboratory |
//|                                   E-mail: igorad2003@yahoo.co.uk |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2006, TrendLaboratory Ltd."
#property link      "http://finance.groups.yahoo.com/group/TrendLaboratory"

#property indicator_chart_window
#property indicator_buffers 6
#property indicator_color1 Chartreuse
#property indicator_color2 Orange
#property indicator_color3 Chartreuse
#property indicator_color4 Orange
#property indicator_color5 Chartreuse
#property indicator_color6 Orange
//---- input parameters

extern int    MA_Mode=0;      // Mode of Moving Average    
extern int    MA_Length=20;   // Bollinger Bands Period
extern double Deviation=2;    // Deviation
extern int    Dev_Length=20;  // Period of Standard Deviation
extern double MoneyRisk=1.00; // Offset Factor
extern int    Signal=1;       // Display signals mode: 1-Signals & Stops; 0-only Stops; 2-only Signals;
extern int    Line=1;         // Display line mode: 0-no,1-yes  
//---- indicator buffers
double UpTrendBuffer[];
double DownTrendBuffer[];
double UpTrendSignal[];
double DownTrendSignal[];
double UpTrendLine[];
double DownTrendLine[];

int    time[2],TREND[2];
bool   Expert=true;
double SMAX[2],SMIN[2],BSMAX[2],BSMIN[2];
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
  int init()
  {
   string short_name;
//---- indicator line
   
   SetIndexBuffer(0,UpTrendBuffer);
   SetIndexBuffer(1,DownTrendBuffer);
   SetIndexBuffer(2,UpTrendSignal);
   SetIndexBuffer(3,DownTrendSignal);
   SetIndexBuffer(4,UpTrendLine);
   SetIndexBuffer(5,DownTrendLine);
   SetIndexStyle(0,DRAW_ARROW);
   SetIndexStyle(1,DRAW_ARROW);
   SetIndexStyle(2,DRAW_ARROW);
   SetIndexStyle(3,DRAW_ARROW);
   SetIndexStyle(4,DRAW_LINE);
   SetIndexStyle(5,DRAW_LINE);
   SetIndexArrow(0,159);
   SetIndexArrow(1,159);
   SetIndexArrow(2,108);
   SetIndexArrow(3,108);
   IndicatorDigits(MarketInfo(Symbol(),MODE_DIGITS));
//---- name for DataWindow and indicator subwindow label
   short_name="BBands Stop("+MA_Length+","+Dev_Length+","+Deviation+")";
   IndicatorShortName(short_name);
   SetIndexLabel(0,"UpTrend Stop");
   SetIndexLabel(1,"DownTrend Stop");
   SetIndexLabel(2,"UpTrend Signal");
   SetIndexLabel(3,"DownTrend Signal");
   SetIndexLabel(4,"UpTrend Line");
   SetIndexLabel(5,"DownTrend Line");
//----
   SetIndexDrawBegin(0,MA_Length+Dev_Length);
   SetIndexDrawBegin(1,MA_Length+Dev_Length);
   SetIndexDrawBegin(2,MA_Length+Dev_Length);
   SetIndexDrawBegin(3,MA_Length+Dev_Length);
   SetIndexDrawBegin(4,MA_Length+Dev_Length);
   SetIndexDrawBegin(5,MA_Length+Dev_Length);
//----
   return(0);
  }

//+------------------------------------------------------------------+
//| Bollinger Bands_Stop_v1.1                                        |
//+------------------------------------------------------------------+
int start()
{
   int    i,shift,trend, MaxBar,limit,counted_bars=IndicatorCounted();
   double smax[1],smin[1],bsmax[1],bsmin[1];
   
   if (Bars-1<MA_Length+Dev_Length+1)return(0);
   if (counted_bars<0)return(-1);
 
   if (counted_bars>0) counted_bars--;
 
   MaxBar=Bars-1-MA_Length-Dev_Length-1;
   limit=Bars-counted_bars-1; 

   if (limit>MaxBar)
   {
      for (shift=limit;shift>=MaxBar;shift--) 
      { 
      UpTrendBuffer[Bars-shift]=0;
      DownTrendBuffer[Bars-shift]=0;
      UpTrendSignal[Bars-shift]=0;
      DownTrendSignal[Bars-shift]=0;
      UpTrendLine[Bars-shift]=EMPTY_VALUE;
      DownTrendLine[Bars-shift]=EMPTY_VALUE;
      } 
   limit=MaxBar;
   }
   //----
   if(ArrayResize(smin,limit+2)!=limit+2)return(-1);
   if(ArrayResize(smax,limit+2)!=limit+2)return(-1);         
	if(ArrayResize(bsmin,limit+2)!=limit+2)return(-1);
   if(ArrayResize(bsmax,limit+2)!=limit+2)return(-1); 
   
   int Tnew=Time[limit+1];

   if (limit<MaxBar)
      if (Tnew==time[1])
      {
      trend=TREND[1];
      smin[limit+1]=SMIN[1];
      smax[limit+1]=SMAX[1];
      bsmin[limit+1]=BSMIN[1];
      bsmax[limit+1]=BSMAX[1];
      Expert=false;
      } 
      else 
      if (Tnew==time[0])
      {
      trend=TREND[0];
      smin[limit+1]=SMIN[0];
      smax[limit+1]=SMAX[0];
      bsmin[limit+1]=BSMIN[0];
      bsmax[limit+1]=BSMAX[0];
      
      TREND[1]=TREND[0];
      SMIN[1]=SMIN[0];
      SMAX[1]=SMAX[0];
      BSMIN[1]=BSMIN[0];
      BSMAX[1]=BSMAX[0];
      }  
   else
   {
   if (Tnew>time[1])Print("Error1");
   else Print("Error2");
   return(-1);  
   }
	
   	
	for(shift=limit;shift>=0;shift--) 
   {	
     	
	double ma = iMA(NULL,0,MA_Length,0,MA_Mode,PRICE_CLOSE,shift);
	double stddev = iStdDev(NULL,0,Dev_Length,0,MA_Mode,PRICE_CLOSE,shift);
	  
	smax[shift]= ma + Deviation*stddev;
	smin[shift]= ma - Deviation*stddev;
	  	  
	if (Close[shift]>smax[shift+1]) trend=1; 
	if (Close[shift]<smin[shift+1]) trend=-1;
		 	
	if(trend>0 && smin[shift]<smin[shift+1]) smin[shift]=smin[shift+1];
	if(trend<0 && smax[shift]>smax[shift+1]) smax[shift]=smax[shift+1];
	  	  
	bsmax[shift]=smax[shift]+0.5*(MoneyRisk-1)*(smax[shift]-smin[shift]);
	bsmin[shift]=smin[shift]-0.5*(MoneyRisk-1)*(smax[shift]-smin[shift]);
		
	if(trend>0 && bsmin[shift]<bsmin[shift+1]) bsmin[shift]=bsmin[shift+1];
	if(trend<0 && bsmax[shift]>bsmax[shift+1]) bsmax[shift]=bsmax[shift+1];
	  
      if (trend>0) 
      {
	     if (Signal>0 && UpTrendBuffer[shift+1]==-1.0)
	     {
	     UpTrendSignal[shift]=bsmin[shift];
	     UpTrendBuffer[shift]=bsmin[shift];
	     if(Line>0) UpTrendLine[shift]=bsmin[shift];
	     }
	     else
	     {
	     UpTrendBuffer[shift]=bsmin[shift];
	     if(Line>0) UpTrendLine[shift]=bsmin[shift];
	     UpTrendSignal[shift]=-1;
	     }
      if (Signal==2) UpTrendBuffer[shift]=0;   
      DownTrendSignal[shift]=-1;
	   DownTrendBuffer[shift]=-1.0;
	   DownTrendLine[shift]=EMPTY_VALUE;
	   }
      if (trend<0) 
	   {
	     if (Signal>0 && DownTrendBuffer[shift+1]==-1.0)
	     {
	     DownTrendSignal[shift]=bsmax[shift];
	     DownTrendBuffer[shift]=bsmax[shift];
	     if(Line>0) DownTrendLine[shift]=bsmax[shift];
	     }
	     else
	     {
	     DownTrendBuffer[shift]=bsmax[shift];
	     if(Line>0)DownTrendLine[shift]=bsmax[shift];
	     DownTrendSignal[shift]=-1;
	     }
      if (Signal==2) DownTrendBuffer[shift]=0;    
	   UpTrendSignal[shift]=-1;
	   UpTrendBuffer[shift]=-1.0;
	   UpTrendLine[shift]=EMPTY_VALUE;
	   }
	 
      if ((shift==2)||((shift==1)&&(Expert==true)))
      {
      time [shift-1]=Time [shift];
     
      TREND[shift-1]=trend;
      SMIN[shift-1]=smin[shift];
      SMAX[shift-1]=smax[shift];
      BSMIN[shift-1]=bsmin[shift];
      BSMAX[shift-1]=bsmax[shift];
      } 
   }
	return(0);	
}

