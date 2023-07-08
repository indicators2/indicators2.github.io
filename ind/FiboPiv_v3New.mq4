//+------------------------------------------------------------------+
//|                                                   FiboPiv_v3.mq4 |
//|                                                          Kalenzo |
//|                                      bartlomiej.gorski@gmail.com |
//+------------------------------------------------------------------+
#property copyright "c. 2007-08, Kalenzo"
#property link      "bartlomiej.gorski@gmail.com"
#property indicator_buffers   7
#property indicator_color1 Goldenrod
#property indicator_style1 1
#property indicator_color2 Gray
#property indicator_style2 2
#property indicator_color3 Gray
#property indicator_style3 0
#property indicator_color4 Goldenrod 
#property indicator_style4 1
#property indicator_color5 Gray
#property indicator_style5 0
#property indicator_color6 Gray 
#property indicator_style6 2
#property indicator_color7 Goldenrod
#property indicator_style7 1

/*extern color Resistance_3 = Sienna;
extern color Resistance_2 = Red;
extern color Resistance_1 = Magenta;
extern color Pivot = Goldenrod;
extern color Support_1 = Lime;
extern color Support_2 = Green;
extern color Support_3 = DarkGreen;
*/
#property indicator_chart_window
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int init()
  {
//---- indicators
//----
   return(0);
  }
//+------------------------------------------------------------------+
//| Custom indicator deinitialization function                       |
//+------------------------------------------------------------------+
int deinit()
  {
//----
   ObjectDelete("S1");
   ObjectDelete("S2");
   ObjectDelete("S3");
   ObjectDelete("R1");
   ObjectDelete("R2");
   ObjectDelete("R3");
   ObjectDelete("PIVOT");
   ObjectDelete("S1");
   ObjectDelete("S2");
   ObjectDelete("Support 3");
   ObjectDelete("Pivot");
   ObjectDelete("R1");
   ObjectDelete("R2");
   ObjectDelete("Resistance 3");
   Comment(" ");
//----
   return(0);
  }
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int start()
  {
   
//----
double rates[1][6],yesterday_close,yesterday_high,yesterday_low;
ArrayCopyRates(rates, Symbol(), PERIOD_D1);

if(DayOfWeek() == 1)
{
   if(TimeDayOfWeek(iTime(Symbol(),PERIOD_D1,1)) == 5)
   {
       yesterday_close = rates[1][4];
       yesterday_high = rates[1][3];
       yesterday_low = rates[1][2];
   }
   else
   {
      for(int d = 5;d>=0;d--)
      {
         if(TimeDayOfWeek(iTime(Symbol(),PERIOD_D1,d)) == 5)
         {
             yesterday_close = rates[d][4];
             yesterday_high = rates[d][3];
             yesterday_low = rates[d][2];
         }
         
      }  
      
   }
}
else
{
    yesterday_close = rates[1][4];
    yesterday_high = rates[1][3];
    yesterday_low = rates[1][2];
}


//---- Calculate Pivots

Comment("\nYesterday quotations:\nH ",yesterday_high,"\nL ",yesterday_low, "\nC ",yesterday_close);
double R = yesterday_high - yesterday_low;//range
double p = (yesterday_high + yesterday_low + yesterday_close)/3;// Standard Pivot
double r3 = p + (R * 1.000);
double r2 = p + (R * 0.618);
double r1 = p + (R * 0.382);
double s1 = p - (R * 0.382);
double s2 = p - (R * 0.618);
double s3 = p - (R * 1.000);

drawLine(r3,"R3", indicator_color1,indicator_style1);
drawLabel("Resistance 3",r3,indicator_color1);
drawLine(r2,"R2", indicator_color2,indicator_style2);
drawLabel("R2: go up R3 or down R1",r2,indicator_color2);
drawLine(r1,"R1", indicator_color3,indicator_style3);
drawLabel("R1: go up R2 or down P",r1,indicator_color3);

drawLine(p,"PIVOT",indicator_color4,indicator_style4);
drawLabel("Pivot: go up R1 or down S1",p,indicator_color4);

drawLine(s1,"S1",indicator_color5,indicator_style5);
drawLabel("S1: go down S2 or up P",s1,indicator_color5);
drawLine(s2,"S2",indicator_color6,indicator_style6);
drawLabel("S2: go down S3 or up S1",s2,indicator_color6);
drawLine(s3,"S3",indicator_color7,indicator_style7);
drawLabel("Support 3",s3,indicator_color7);


//----
   return(0);
  }
//+------------------------------------------------------------------+
void drawLabel(string name,double lvl,color Color)
{
    if(ObjectFind(name) != 0)
    {
        ObjectCreate(name, OBJ_TEXT, 0, Time[10], lvl);
        ObjectSetText(name, name, 8, "Arial", EMPTY);
        ObjectSet(name, OBJPROP_COLOR, Color);
    }
    else
    {
        ObjectMove(name, 0, Time[10], lvl);
    }
}


void drawLine(double lvl,string name, color Col,int type)
{
         if(ObjectFind(name) != 0)
         {
            ObjectCreate(name, OBJ_HLINE, 0, Time[0], lvl,Time[0],lvl);
            
            if(type == 1)
            ObjectSet(name, OBJPROP_STYLE, STYLE_SOLID);
            else if(type == 2)
            ObjectSet(name, OBJPROP_STYLE, STYLE_DASHDOTDOT);
            else
            ObjectSet(name, OBJPROP_STYLE, STYLE_DOT);
            
            ObjectSet(name, OBJPROP_COLOR, Col);
            ObjectSet(name,OBJPROP_WIDTH,1);
            
         }
         else
         {
            ObjectDelete(name);
            ObjectCreate(name, OBJ_HLINE, 0, Time[0], lvl,Time[0],lvl);
            
            if(type == 1)
            ObjectSet(name, OBJPROP_STYLE, STYLE_SOLID);
            else if(type == 2)
            ObjectSet(name, OBJPROP_STYLE, STYLE_DASHDOTDOT);
            else
            ObjectSet(name, OBJPROP_STYLE, STYLE_DOT);
            
            ObjectSet(name, OBJPROP_COLOR, Col);        
            ObjectSet(name,OBJPROP_WIDTH,1);
          
         }
}