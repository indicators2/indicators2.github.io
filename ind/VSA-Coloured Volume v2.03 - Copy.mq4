//+------------------------------------------------------------------+
//|                                          Coloured Volume Two.mq4 |
//|                      Copyright © 2008, MetaQuotes Software Corp. |
//|                                        http://www.metaquotes.net |
//+------------------------------------------------------------------+
#define vers   "27.Sep.2011"
#define major  "2"
#define minor  "03"

#property indicator_separate_window
#property indicator_buffers 7
#property indicator_color1 Blue
#property indicator_width1 3

#property indicator_color2 Crimson
#property indicator_width2 3

#property indicator_color3 Aqua
#property indicator_width3 3

#property indicator_color4 Violet
#property indicator_width4 3

#property indicator_color5 Lime   //Vol MA
#property indicator_width5 2 
#property indicator_color6 Black//Vol MA Upperband
#property indicator_style6 STYLE_DOT

#property indicator_color7 White//Vol MA Upperband
#property indicator_style7 STYLE_DOT

//---- buffers
double RV_UP[], RV_DN[], RV_SAME[], RV_SMALLER[];
double Vol_MA[], Vol[], Vol_MA_Band1[];
double Vol_MA_Band2[],Vol_MA_Band3[];

extern int    Vol_MA_Pd = 15;
extern double VOL_MA_BandPercent1 = 0.854;
extern double VOL_MA_BandPercent2 = 1.382;
extern string Alerts = "===== ALERT OPTIONS =====";
extern bool   UseAlerts = false;
extern bool   MsgAlerts = false;
extern bool   SoundAlerts = false;
extern string AlertSoundFile = "";
extern bool   eMailAlerts = False;

//----
int ExtCountedBars=0;
int LastAlertBar1,LastAlertBar2;
string sCom, ShortName;
int Win = -2;

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//|------------------------------------------------------------------|
int init()
{
   IndicatorBuffers(8);

   IndicatorDigits(1);
   
   SetIndexBuffer(0, RV_UP);
   SetIndexStyle(0,DRAW_HISTOGRAM, 0, 3);   

   SetIndexBuffer(1, RV_DN);
   SetIndexStyle(1,DRAW_HISTOGRAM, 0, 3);   

   SetIndexBuffer(2, RV_SAME);
   SetIndexStyle(2,DRAW_HISTOGRAM, 0, 3);   
   
   SetIndexBuffer(3, RV_SMALLER);
   SetIndexStyle(3,DRAW_HISTOGRAM, 0, 3);   
   
   SetIndexBuffer(4, Vol_MA);
   SetIndexStyle(4,DRAW_LINE);   

   SetIndexBuffer(5, Vol_MA_Band1);
   SetIndexStyle(5,DRAW_LINE);   

   SetIndexBuffer(6, Vol_MA_Band2);
   SetIndexStyle(6,DRAW_LINE);  

   SetIndexBuffer(7, Vol);

   SetIndexDrawBegin(0,Vol_MA_Pd);
   SetIndexDrawBegin(1,Vol_MA_Pd);
   SetIndexDrawBegin(2,Vol_MA_Pd);
   SetIndexDrawBegin(3,Vol_MA_Pd);
   SetIndexDrawBegin(4,Vol_MA_Pd);
   SetIndexDrawBegin(5,Vol_MA_Pd);
   SetIndexDrawBegin(6,Vol_MA_Pd);
   LastAlertBar1 = Bars;
   LastAlertBar2 = Bars;
      
   ShortName = "Coloured Vol - v" + major + "." + minor + " (Band MA: " + Vol_MA_Pd + "pd, MA% 1: " + DoubleToStr(VOL_MA_BandPercent1*100,0)+"%, MA% 2: " + DoubleToStr(VOL_MA_BandPercent2*100,0)+"%)    ";
   IndicatorShortName(ShortName);
   
   return(0);
}

//+------------------------------------------------------------------+
//| Custor indicator deinitialization function                       |
//+------------------------------------------------------------------+
int deinit()
{
   Comment("");
   //Ensure that any objects the EA has created are removed
   DeleteObjects("Vol");
   return(0);
}

//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int start()
{
   //if(Win<0) Win = WindowFind(ShortName);
   //sCom = "Win: " + Win;

   int i;
   int counted_bars=IndicatorCounted();
   //---- check for possible errors
   if(counted_bars<0) return(-1);
   //---- last counted bar will be recounted
   if(counted_bars>0) counted_bars--;

   int limit=Bars-counted_bars;
   for(i=0;i<limit;i++)
   {
      RV_DN[i]=EMPTY_VALUE;
      RV_UP[i]=EMPTY_VALUE;
      RV_SAME[i]=EMPTY_VALUE;
      RV_SMALLER[i]=EMPTY_VALUE;

      if  (Volume[i]<Volume[i+1]&&Volume[i]<Volume[i+2])RV_SMALLER[i]= Volume[i];
      else if (Close[i]<Close[i+1])RV_DN[i]= Volume[i];
      else if (Close[i]>Close[i+1])RV_UP[i]= Volume[i];      
      else RV_SAME[i]= Volume[i];
      Vol[i] = Volume[i];
   }

   for(i=0;i<limit;i++)
   {
      double VolMA = iMAOnArray(Vol,0,Vol_MA_Pd,0,MODE_SMA,i);
      Vol_MA[i]=iMAOnArray(Vol,0,Vol_MA_Pd,0,MODE_SMA,i);
      Vol_MA_Band1[i]= VolMA+(VolMA*VOL_MA_BandPercent1);
      Vol_MA_Band2[i]= VolMA+(VolMA*VOL_MA_BandPercent2);
   }

   color VolCol = indicator_color1;
   if(RV_DN[1]!=EMPTY_VALUE) VolCol = indicator_color2;
   else if(RV_SAME[1]!=EMPTY_VALUE) VolCol = indicator_color3;
   else if(RV_SMALLER[1]!=EMPTY_VALUE) VolCol = indicator_color4;
      
   CreateLabel("Vol1", "Bar 1: " + FormatNumber(Vol[1],0,""), 8, "Arial", VolCol, 1, 10, 4);   
   CreateLabel("Vol2", "Vol_MA: " + FormatNumber(Vol_MA[1],0,""), 8, "Arial", VolCol, 1, 10, 18);   
   CreateLabel("Vol3", "Vol_MA_Band1: " + FormatNumber(Vol_MA_Band1[1],0,""), 8, "Arial", VolCol, 1, 10, 32);   
   CreateLabel("Vol4", "Vol_MA_Band2: " + FormatNumber(Vol_MA_Band2[1],0,""), 8, "Arial", VolCol, 1, 10, 32);   

   if(UseAlerts)
   {
      string Subj, Msg;
      if(Vol[1]>=Vol_MA_Band1[1] && LastAlertBar1<Bars)
      {
         LastAlertBar1=Bars;
         Subj = "VSA VOLUME BAND 1 ALERT. Volume > " + Vol_MA_Band1[1] + " on " + Symbol()+ ", " + TF2Str(Period());
         Msg = Subj + " @ Local Time: " + TimeToStr(TimeLocal(),TIME_MINUTES);
         DoAlerts(Msg,Subj,AlertSoundFile);   
      }
      if(Vol[1]>=Vol_MA_Band2[1] && LastAlertBar2<Bars)
      {
         LastAlertBar2=Bars;
         Subj = " VOL 2 ALERT. " + Vol_MA_Band2[1] + " on " + Symbol()+ ", " ;
         Msg = Subj + "  " + TimeToStr(TimeLocal(),TIME_MINUTES);
         DoAlerts(Msg,Subj,AlertSoundFile);   
      }
   }
   
   //Comment(sCom);
   
   return(0);
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CreateLabel( string LblName, string LblTxt, double FontSz, string FontName, color FontColor, int Corner, int xPos, int yPos)
{
   string lName = LblName;
   if(Win>0)
   {
      if(ObjectFind(lName) < 0) ObjectCreate(lName, OBJ_LABEL, Win, 0, 0);

      ObjectSetText(lName, LblTxt, FontSz, FontName, FontColor);
      ObjectSet(lName, OBJPROP_CORNER, Corner);
      ObjectSet(lName, OBJPROP_XDISTANCE, xPos);
      ObjectSet(lName, OBJPROP_YDISTANCE, yPos); 
      ObjectSet(lName, OBJPROP_BACK, True); 
   }
}

//+------------------------------------------------------------------+
//| Delete Objects that match ObjName                                |
//+------------------------------------------------------------------+
void DeleteObjects(string ObjName)
{
   for (int i=ObjectsTotal()-1; i >= 0; i--) 
   {
     string name = ObjectName(i);
     if (StringFind(name, ObjName) > -1) ObjectDelete(name);
   }
}
  
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string TF2Str(int period) 
{
  switch (period) 
  {
    case PERIOD_M1: return("M1");
    case PERIOD_M5: return("M5");
    case PERIOD_M15: return("M15");
    case PERIOD_M30: return("M30");
    case PERIOD_H1: return("H1");
    case PERIOD_H4: return("H4");
    case PERIOD_D1: return("D1");
    case PERIOD_W1: return("W1");
    case PERIOD_MN1: return("MN");
  }
  return (Period());
} 

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void DoAlerts(string msgText,string eMailSub, string SoundAlertFile)
{
   if (MsgAlerts) Alert(msgText);
   if (SoundAlerts)  PlaySound(SoundAlertFile);
   if (eMailAlerts) SendMail(eMailSub, msgText);
}
     
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string FormatNumber(double Value, int DecPlaces=0, string Format="$")
{
   string sDecimals = "";
   string result, tStr;

   tStr = DoubleToStr(MathAbs(Value),DecPlaces); //Manages any rounding automatically
   if(DecPlaces>0)
   {
      int pd = StringFind(tStr,".");
      sDecimals = StringSubstr(tStr,pd,StringLen(tStr)-1);
      tStr = StringSubstr(tStr,0,pd);
   }
   
   while(StringLen(tStr)>3)
   {
      if(StringLen(result)==0) result = StringSubstr(tStr,StringLen(tStr)-3,3);
      else result = StringSubstr(tStr,StringLen(tStr)-3,3) + "," + result;
      
      tStr = StringSubstr(tStr,0,StringLen(tStr)-3);
   }
        
   if(StringLen(result)==0) result = tStr; //Incase len of Value < 3
   else if (StringLen(tStr)>0) result = tStr + "," + result;
   
   if(Format=="%") result = result+sDecimals+Format;
   else result = Format+result+sDecimals;
   
   if(NormalizeDouble(Value,DecPlaces)<0) result = "-"+result;
   
   return(result); 
}

