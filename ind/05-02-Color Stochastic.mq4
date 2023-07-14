//+------------------------------------------------------------------+
//|                                             Color Stochastic.mq4 |
//|                                                           mladen |
//+------------------------------------------------------------------+
#property copyright "mladen"
#property link      "mladenfx@gmail.com"

#property indicator_separate_window
#property indicator_buffers   6
#property indicator_color1  DimGray
#property indicator_color2  DimGray
#property indicator_color3  DeepSkyBlue
#property indicator_color4  DeepSkyBlue
#property indicator_color5  Red
#property indicator_color6  Red
#property indicator_style1  STYLE_DOT
#property indicator_width3  2
#property indicator_width4  2
#property indicator_width5  2
#property indicator_width6  2
#property indicator_minimum   0
#property indicator_maximum 100
 
//
//
//
//
//

extern int    KPeriod               =  14;
extern int    Slowing               =   3;
extern int    DPeriod               =   3;
extern int    MAMethod              =   2;
extern int    PriceField            =   0;
extern int    overBought            =  80;
extern int    overSold              =  20;
extern bool   showLevels            = true;
extern bool   showArrows            = true;
extern bool   showArrowsOnZoneEnter = true;
extern bool   showArrowsOnZoneExit  = true;
extern string arrowsIdentifier      = "Color stochastic";
extern color  arrowsOBColor         = DeepSkyBlue;
extern color  arrowsOSColor         = Red;

//
//
//
//
//

extern bool   alertsOn          = true;
extern bool   alertsOnZoneEnter = true;
extern bool   alertsOnZoneExit  = true;
extern bool   alertsOnCurrent   = true;
extern bool   alertsMessage     = true;
extern bool   alertsSound       = false;
extern bool   alertsEmail       = false;

//
//
//
//
//
//

double KFull[];
double DFull[];
double Uppera[];
double Upperb[];
double Lowera[];
double Lowerb[];
double trend[];


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+

int init()
{
   IndicatorBuffers(7);
      SetIndexBuffer(0,DFull);  SetIndexLabel(1,"Stochastic");
      SetIndexBuffer(1,KFull);  
      SetIndexBuffer(2,Uppera); SetIndexLabel(2,NULL);
      SetIndexBuffer(3,Upperb); SetIndexLabel(3,NULL);
      SetIndexBuffer(4,Lowera); SetIndexLabel(4,NULL);
      SetIndexBuffer(5,Lowerb); SetIndexLabel(5,NULL);
      SetIndexBuffer(6,trend);
      
      //
      //
      //
      //
      //
         
      DPeriod = MathMax(DPeriod,1);
      if (DPeriod==1) {
            SetIndexStyle(0,DRAW_NONE);
            SetIndexLabel(0,NULL);
          }
      else {
            SetIndexStyle(0,DRAW_LINE); 
            SetIndexLabel(0,"Signal");
         }               
      if (showLevels)
           { SetLevelValue(0,overBought); SetLevelValue(1,overSold); }
      else { SetLevelValue(0,EMPTY);      SetLevelValue(1,EMPTY);     }
         
   //
   //
   //
   //
   //

   string shortName = "Stochastic ("+KPeriod+","+Slowing+","+DPeriod+","+maDescription(MAMethod)+","+priceDescription(PriceField);
         if (overBought < overSold) overBought = overSold;
         if (overBought < 100)      shortName  = shortName+","+overBought;
         if (overSold   >   0)      shortName  = shortName+","+overSold;
   IndicatorShortName(shortName+")");
   return(0);
}

//
//
//
//
//

int deinit()
{
   deleteArrows();
   return(0);
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+

int start()
{
   int    counted_bars=IndicatorCounted();
   int    i,limit;

   if(counted_bars < 0)   return(-1);
   if(counted_bars > 0)   counted_bars--;
           limit = MathMin(Bars-counted_bars,Bars-2);

   //
   //
   //
   //
   //
  
   if (trend[limit]== 1) CleanPoint(limit,Uppera,Upperb);
   if (trend[limit]==-1) CleanPoint(limit,Lowera,Lowerb);
   for(i=limit; i>=0; i--)
   {
         KFull[i]  = iStochastic(NULL,0,KPeriod,DPeriod,Slowing,MAMethod,PriceField,MODE_MAIN,i);
         DFull[i]  = iStochastic(NULL,0,KPeriod,DPeriod,Slowing,MAMethod,PriceField,MODE_SIGNAL,i);
         Uppera[i] = EMPTY_VALUE;
         Upperb[i] = EMPTY_VALUE;
         Lowera[i] = EMPTY_VALUE;
         Lowerb[i] = EMPTY_VALUE;

         //
         //
         //
         //
         //

         trend[i] = trend[i+1];
            if (KFull[i] < overBought && KFull[i] > overSold) trend[i] =  0;
            if (KFull[i] > overBought)                        trend[i] =  1;
            if (KFull[i] < overSold  )                        trend[i] = -1;
            if (trend[i]== 1) PlotPoint(i,Uppera,Upperb,KFull);
            if (trend[i]==-1) PlotPoint(i,Lowera,Lowerb,KFull);

         //
         //
         //
         //
         //
            
         if (showArrows)
         {
            deleteArrow(Time[i]);
            if (trend[i]!=trend[i+1])
            {
               if (showArrowsOnZoneEnter && trend[i]   == 1)                 drawArrow(i,arrowsOBColor,241,false);
               if (showArrowsOnZoneEnter && trend[i]   ==-1)                 drawArrow(i,arrowsOSColor,242,true);
               if (showArrowsOnZoneExit  && trend[i+1] == 1 && trend[i]!=-1) drawArrow(i,arrowsOBColor,242,true);
               if (showArrowsOnZoneExit  && trend[i+1] ==-1 && trend[i]!= 1) drawArrow(i,arrowsOSColor,241,False);
            }
         }               
   }
   
   //
   //
   //
   //
   //
   
   if (alertsOn)
   {
      if (alertsOnCurrent)
           int whichBar = 0;
      else     whichBar = 1;
      if (trend[whichBar] != trend[whichBar+1])
      {
         if (alertsOnZoneEnter && trend[whichBar]   == 1)                        doAlert(DoubleToStr(overBought,2)+" crossed up");
         if (alertsOnZoneEnter && trend[whichBar]   ==-1)                        doAlert(DoubleToStr(overSold  ,2)+" crossed down");
         if (alertsOnZoneExit  && trend[whichBar+1] == 1 && trend[whichBar]!=-1) doAlert(DoubleToStr(overBought,2)+" crossed dow");
         if (alertsOnZoneExit  && trend[whichBar+1] ==-1 && trend[whichBar]!= 1) doAlert(DoubleToStr(overSold  ,2)+" crossed up");
      }         
   }
   return(0);
}


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
//
//
//
//
//

void drawArrow(int i,color theColor,int theCode,bool up)
{
   string name = arrowsIdentifier+":"+Time[i];
   double gap  = 3.0*iATR(NULL,0,20,i)/4.0;   
   
      //
      //
      //
      //
      //
      
      ObjectCreate(name,OBJ_ARROW,0,Time[i],0);
         ObjectSet(name,OBJPROP_ARROWCODE,theCode);
         ObjectSet(name,OBJPROP_COLOR,theColor);
         if (up)
               ObjectSet(name,OBJPROP_PRICE1,High[i]+gap);
         else  ObjectSet(name,OBJPROP_PRICE1,Low[i] -gap);
}

//
//
//
//
//

void deleteArrows()
{
   string lookFor       = arrowsIdentifier+":";
   int    lookForLength = StringLen(lookFor);
   for (int i=ObjectsTotal()-1; i>=0; i--)
   {
      string objectName = ObjectName(i);
         if (StringSubstr(objectName,0,lookForLength) == lookFor) ObjectDelete(objectName);
   }
}
void deleteArrow(datetime time)
{
   string lookFor = arrowsIdentifier+":"+time; ObjectDelete(lookFor);
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+  
//
//
//
//
//

void doAlert(string doWhat)
{
   static string   previousAlert="nothing";
   static datetime previousTime;
   string message;
   
      if (previousAlert != doWhat || previousTime != Time[0]) {
          previousAlert  = doWhat;
          previousTime   = Time[0];

          //
          //
          //
          //
          //

          message =  StringConcatenate(Symbol()," at ",TimeToStr(TimeLocal(),TIME_SECONDS)," stochastic level ",doWhat);
             if (alertsMessage) Alert(message);
             if (alertsEmail)   SendMail(StringConcatenate(Symbol(),"Color stochastic "),message);
             if (alertsSound)   PlaySound("alert2.wav");
      }
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
//
//
//
//
//

void CleanPoint(int i,double& first[],double& second[])
{
   if ((second[i]  != EMPTY_VALUE) && (second[i+1] != EMPTY_VALUE))
        second[i+1] = EMPTY_VALUE;
   else
      if ((first[i] != EMPTY_VALUE) && (first[i+1] != EMPTY_VALUE) && (first[i+2] == EMPTY_VALUE))
          first[i+1] = EMPTY_VALUE;
}

//
//
//
//
//

void PlotPoint(int i,double& first[],double& second[],double& from[])
{
   if (first[i+1] == EMPTY_VALUE)
      {
         if (first[i+2] == EMPTY_VALUE) {
                first[i]   = from[i];
                first[i+1] = from[i+1];
                second[i]  = EMPTY_VALUE;
            }
         else {
                second[i]   =  from[i];
                second[i+1] =  from[i+1];
                first[i]    = EMPTY_VALUE;
            }
      }
   else
      {
         first[i]  = from[i];
         second[i] = EMPTY_VALUE;
      }
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
//
//
//
//
//

string priceDescription(int mode)
{
   string answer;
   switch(mode)
   {
      case 0:  answer = "Low/High"    ; break; 
      case 1:  answer = "Close/Close" ; break;
      default: answer = "Invalid price field requested";
                                    Alert(answer);
   }
   return(answer);
}
string maDescription(int mode)
{
   string answer;
   switch(mode)
   {
      case MODE_SMA:  answer = "SMA"  ; break; 
      case MODE_EMA:  answer = "EMA"  ; break;
      case MODE_SMMA: answer = "SMMA" ; break;
      case MODE_LWMA: answer = "LWMA" ; break;
      default:        answer = "Invalid MA mode requested";
                                    Alert(answer);
   }
   return(answer);
}