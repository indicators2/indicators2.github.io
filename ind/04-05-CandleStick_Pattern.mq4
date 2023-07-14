//+------------------------------------------------------------------+
//|                                     CandleStick_Pattern_indicator|
//|          (complete rewrite and name change of pattern alert)     |
//+------------------------------------------------------------------+
//|                                         Pattern Recognition.mq4  |
//|                                Copyright © 2009  |
//|                                    http://www.forex-indicators.ru  |
//|      This is still work in progress and needs LOTS of testing    |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2009."
#property link      "http://www.forex-indicators.ru"

#property indicator_chart_window
#property indicator_buffers 2
#property indicator_color1 Red
#property indicator_color2 Blue
//----
extern bool Show_Alert = true;
extern bool Display_Bearish_Engulfing = true;
extern bool Display_Three_Outside_Down = true;
extern bool Display_Three_Inside_Down = true;
extern bool Display_Dark_Cloud_Cover = true;
extern bool Display_Three_Black_Crows = true;
extern bool Display_Bullish_Engulfing = true;
extern bool Display_Three_Outside_Up = true;
extern bool Display_Three_Inside_Up = true;
extern bool Display_Piercing_Line = true;
extern bool Display_Three_White_Soldiers = true;
extern bool Display_Stars = true;
extern bool Display_Harami = true;
//---- buffers
double upArrow[];
double downArrow[];
string PatternText[5000];
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int init() 
  {
   SetIndexStyle(0, DRAW_ARROW, 0, 1);
   SetIndexArrow(0, 242);
   SetIndexBuffer(0, downArrow);      
//----
   SetIndexStyle(1, DRAW_ARROW, 0, 1);
   SetIndexArrow(1, 241);
   SetIndexBuffer(1, upArrow);
      
   return(0);
  }
//+------------------------------------------------------------------+
//| Custom indicator deinitialization function                       |
//+------------------------------------------------------------------+
int deinit() 
  {
   ObjectsDeleteAll(0, OBJ_TEXT);
   return(0);
  }
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int start()
  {
   double Range, AvgRange;
   int counter, setalert;
   static datetime prevtime = 0;
   int shift;
   int shift1;
   int shift2;
   int shift3;
   string pattern, period;
   int setPattern = 0;
   int alert = 0;
   int arrowShift;
   int textShift;
   double O, O1, O2, C, C1, C2, L, L1, L2, H, H1, H2;     
//----
   if(prevtime == Time[0]) 
     {
       return(0);
     }
   prevtime = Time[0];   
//----
   switch(Period()) 
     {
       case 1:     period = "M1";  break;
       case 5:     period = "M5";  break;
       case 15:    period = "M15"; break;
       case 30:    period = "M30"; break;      
       case 60:    period = "H1";  break;
       case 240:   period = "H4";  break;
       case 1440:  period = "D1";  break;
       case 10080: period = "W1";  break;
       case 43200: period = "MN";  break;
     }
//----
   for(int j = 0; j < Bars; j++) 
     { 
       PatternText[j] = "pattern-" + j;
     }
//----
   for(shift = 0; shift < Bars; shift++) 
     {
       setalert = 0;
       counter = shift;
       Range = 0;
       AvgRange = 0;
       for(counter = shift; counter <= shift + 9; counter++) 
         {
           AvgRange = AvgRange + MathAbs(High[counter] - Low[counter]);
         }
       Range = AvgRange / 10;
       shift1 = shift + 1;
       shift2 = shift + 2;
       shift3 = shift + 3;      
       O = Open[shift1];
       O1 = Open[shift2];
       O2 = Open[shift3];
       H = High[shift1];
       H1 = High[shift2];
       H2 = High[shift3];
       L = Low[shift1];
       L1 = Low[shift2];
       L2 = Low[shift3];
       C = Close[shift1];
       C1 = Close[shift2];
       C2 = Close[shift3];         
       // Медвежьи модели   
       // Медвежье поглощение
       if((C1 > O1) && (O > C) && (O >= C1) && (O1 >= C) && ((O - C) > (C1 - O1))) 
         {
           if(Display_Bearish_Engulfing == true) 
             {
               ObjectCreate(PatternText[shift], OBJ_TEXT, 0, Time[shift1], 
                            High[shift1] + Range*1.5);
               ObjectSetText(PatternText[shift], "Медвежье поглощение", 10, 
                             "Arial", White);
               downArrow[shift1] = High[shift1] + Range*0.5;
             }
           if(setalert == 0 && Show_Alert == true) 
             {
               pattern = "Медвежье поглощение";
               setalert = 1;
             }
         }
       // Три внешних дня вниз
       if((C2 > O2) && (O1 > C1) && (O1 >= C2) && (O2 >= C1) && ((O1 - C1) > (C2 - O2)) && 
          (O > C) && (C < C1)) 
         {
           if(Display_Three_Outside_Down == true) 
             {   
               ObjectCreate(PatternText[shift], OBJ_TEXT, 0, Time[shift1], 
                            Low[shift1] - Range*1.5);
               ObjectSetText(PatternText[shift], "Три внешних дня вниз", 10, 
                             "Arial", White);
               upArrow[shift1] = Low[shift1] - Range*0.5;
             }
           if(setalert == 0 && Show_Alert == true) 
             {
               pattern = "Три внешних дня вниз";
               setalert = 1;
             }
         }
       // Завеса из темных облаков
       if((C1 > O1) && (((C1 + O1) / 2) > C) && (O > C) && (O > C1) && (C > O1) && 
          ((O - C) / (0.001 + (H - L)) > 0.6)) 
         {
           if(Display_Dark_Cloud_Cover == true) 
             {   
               ObjectCreate(PatternText[shift], OBJ_TEXT, 0, Time[shift1], 
                            High[shift1] + Range*1.5);
               ObjectSetText(PatternText[shift], "Завеса из темных облаков", 10, 
                             "Arial", White);
               downArrow[shift1] = High[shift1] + Range*0.5;
             }
           //----
           if(setalert == 0 && Show_Alert == true) 
             {
               pattern = "Завеса из темных облаков";
               setalert = 1;
             }
         }     
       // Вечерняя доджи звезда
       if((C2 > O2) && ((C2 - O2) / (0.001 + H2 - L2) > 0.6) && (C2 < O1) && (C1 > O1) && 
          ((H1-L1) > (3*(C1 - O1))) && (O > C) && (O < O1)) 
         {
           if(Display_Stars == true) 
             {
               ObjectCreate(PatternText[shift], OBJ_TEXT, 0, Time[shift1], 
                            High[shift1] + Range*1.5);
               ObjectSetText(PatternText[shift], "Вечерняя доджи звезда", 10, 
                             "Arial", White);
               downArrow[shift1] = High[shift1] + Range*0.5;
             }
           //----
           if(setalert == 0 && Show_Alert == true) 
             {
               pattern = "Вечерняя доджи звезда";
               setalert = 1;
             }
         }     
       // Медвежья Харами
       if((C1 > O1) && (O > C) && (O <= C1) && (O1 <= C) && ((O - C) < (C1 - O1))) 
         {
           if(Display_Harami == true) 
             {   
               ObjectCreate(PatternText[shift], OBJ_TEXT, 0, Time[shift1], 
                            High[shift1] + Range*1.5);
               ObjectSetText(PatternText[shift], "Медвежья Харами", 10, 
                             "Arial", White);
               downArrow[shift1] = High[shift1] + Range*0.5;
             }
           if(shift == 0 && Show_Alert == true) 
             {
               pattern="Медвежья Харами";
               setalert = 1;
             }
         }
       // Три внутренних дня вниз
       if((C2 > O2) && (O1 > C1) && (O1 <= C2) && (O2 <= C1) && ((O1 - C1) < (C2 - O2)) && 
          (O > C) && (C < C1) && (O < O1)) 
         {
           if(Display_Three_Inside_Down == true) 
             {   
               ObjectCreate(PatternText[shift], OBJ_TEXT, 0, Time[shift1], 
                            High[shift1] + Range*1.5);
               ObjectSetText(PatternText[shift], "Три внутренних дня вниз", 10, 
                             "Arial", White);
               downArrow[shift1] = High[shift1] + Range*0.5;
             }
           if(shift == 0 && Show_Alert == true) 
             {
               pattern = "Три внутренних дня вниз";
               setalert = 1;
             }
         }   
       // Три черные вороны
       if((O > C*1.01) && (O1 > C1*1.01) && (O2 > C2*1.01) && (C < C1) && (C1 < C2) && 
          (O > C1) && (O < O1) && (O1 > C2) && (O1 < O2) && (((C - L) / (H - L)) < 0.2) && 
          (((C1 - L1) / (H1 - L1)) < 0.2) && (((C2 - L2) / (H2 - L2)) < 0.2))
         {
           if(Display_Three_Black_Crows == true)
             {   
               ObjectCreate(PatternText[shift], OBJ_TEXT, 0, Time[shift1], 
                            High[shift1] + Range*1.5);
               ObjectSetText(PatternText[shift], "Три черные вороны", 10, 
                             "Arial", White);
               downArrow[shift1] = High[shift1] + Range*0.5;
             }
           //----
           if(shift == 0 && Show_Alert == true) 
             {
               pattern = "Три черные вороны";
               setalert = 1;
             }
         }
       //Вечерняя звезда
       if((C2 > O2) && ((C2 - O2) / (0.001 + H2 - L2) > 0.6) && (C2 < O1) && (C1 > O1) && 
          ((H1 - L1) > (3*(C1 - O1))) && (O > C) && (O < O1)) 
         {
           if(Display_Stars == true) 
             {   
               ObjectCreate(PatternText[shift], OBJ_TEXT, 0, Time[shift1], 
                            High[shift1] + Range*1.5);
               ObjectSetText(PatternText[shift], "Вечерняя звезда", 10, "Arial", White);
               downArrow[shift1] = High[shift1] + Range*0.5;
             }
           //----
           if(shift == 0 && Show_Alert == true) 
             {
               pattern = "Вечерняя звезда";
               setalert = 1;
             }
         }
     
       // Бычьи модели
       // Бычье поглощение
       if((O1 > C1) && (C > O) && (C >= O1) && (C1 >= O) && ((C - O) > (O1 - C1))) 
         {
           if(Display_Bullish_Engulfing) 
             {   
               ObjectCreate(PatternText[shift], OBJ_TEXT, 0, Time[shift1], 
                            Low[shift1] - Range*1.5);
               ObjectSetText(PatternText[shift], "Бычье поглощение", 10, 
                             "Arial", White);
               upArrow[shift1] = Low[shift1] - Range*0.5;
             }
           if(shift == 0 && Show_Alert == true) 
             {
               pattern = "Бычье поглощение";
               setalert = 1;
             }
         }
       // Три внешних дня вверх
       if((O2 > C2) && (C1 > O1) && (C1 >= O2) && (C2 >= O1) && ((C1 - O1) > (O2 - C2)) && 
          (C > O) && (C > C1)) 
         {
           if(Display_Three_Outside_Up == true) 
             {   
               ObjectCreate(PatternText[shift], OBJ_TEXT, 0, Time[shift1], 
                            Low[shift1] - Range*1.5);
               ObjectSetText(PatternText[shift], "Три внешних дня вверх", 10, 
                             "Arial", White);
               upArrow[shift1] = Low[shift1] - Range*0.5;
             }
           if(shift == 0 && Show_Alert == true) 
             {
               pattern = "Три внешних дня вверх";
               setalert = 1;
             }
         }
       // Бычья Харами
       if((O1 > C1) && (C > O) && (C <= O1) && (C1 <= O) && ((C - O) < (O1 - C1))) 
         {
           if(Display_Harami == true) 
             {   
               ObjectCreate(PatternText[shift], OBJ_TEXT, 0, Time[shift1], 
                            Low[shift1] - Range*1.5);
               ObjectSetText(PatternText[shift], "Бычья Харами", 10, 
                             "Arial", White);
               upArrow[shift1] = Low[shift1] - Range*0.5;
             }
           if(shift == 0 && Show_Alert == true) 
             {
               pattern = "Бычье Харами";
               setalert = 1;
             } 
         }
       // Три веншних дня вверх
       if((O2 > C2) && (C1 > O1) && (C1 <= O2) && (C2 <= O1) && ((C1 - O1) < (O2 - C2)) && 
          (C > O) && (C > C1) && (O > O1)) 
         {
           if(Display_Three_Inside_Up == true) 
             {   
               ObjectCreate(PatternText[shift], OBJ_TEXT, 0, Time[shift1], 
                            Low[shift1] - Range*1.5);
               ObjectSetText(PatternText[shift], "Три веншних дня вверх", 10, 
                             "Arial", White);
               upArrow[shift1] = Low[shift1] - Range*0.5;
             }
           if(shift == 0 && Show_Alert == true) 
             {
               pattern = "Три веншних дня вверх";
               setalert = 1;
             }
         }      
       // Просвет в облаках
       if((C1 < O1) && (((O1 + C1) / 2) < C) && (O < C) && (O < C1) && (C < O1) && 
          ((C - O) / (0.001 + (H - L)) > 0.6)) 
         {
           if(Display_Piercing_Line == true) 
             {   
               ObjectCreate(PatternText[shift], OBJ_TEXT, 0, Time[shift1], 
                            Low[shift1] - Range*1.5);
               ObjectSetText(PatternText[shift], "Просвет в облаках", 10, 
                             "Arial", White);
               upArrow[shift1] = Low[shift1] - Range*0.5;
             }
           if(shift == 0 && Show_Alert == true) 
             {
               pattern = "Просвет в облаках";
               setalert = 1;
             }
         }      
       // Три белых солдата
       if((C > O*1.01) && (C1 > O1*1.01) && (C2 > O2*1.01) && (C > C1) && (C1 > C2) && 
          (O < C1) && (O > O1) && (O1 < C2) && (O1 > O2) && (((H - C) / (H - L)) < 0.2) && 
          (((H1 - C1) / (H1 - L1)) < 0.2) && (((H2 - C2) / (H2 - L2)) < 0.2)) 
         {
           if(Display_Three_White_Soldiers == true) 
             {   
               ObjectCreate(PatternText[shift], OBJ_TEXT, 0, Time[shift1], 
                            Low[shift1] - Range*1.5);
               ObjectSetText(PatternText[shift], "Три белых солдата", 10, 
                             "Arial", White);
               upArrow[shift1] = Low[shift1] - Range*0.5;
             }
           if(shift == 0 && Show_Alert == true) 
             {
               pattern = "Три белых солдата";
               setalert = 1;
             }
         }     
       // Утренняя доджи звезда
       if((O2 > C2) && ((O2 - C2) / (0.001 + H2 - L2) > 0.6) && (C2 > O1) && (O1 > C1) && 
          ((H1 - L1) > (3*(C1 - O1))) && (C > O) && (O > O1)) 
         {
           if(Display_Stars == true) 
             {   
               ObjectCreate(PatternText[shift], OBJ_TEXT, 0, Time[shift1], 
                            Low[shift1] - Range*1.5);
               ObjectSetText(PatternText[shift], "Утренняя доджи звезда", 10, 
                             "Arial", White);
               upArrow[shift1] = Low[shift1] - Range*0.5;
             }
           if(shift == 0 && Show_Alert == true) 
             {
               pattern = "Утренняя доджи звезда";
               setalert = 1;
             }
         }
       if(setalert == 1 && shift == 0) 
         {
           Alert(Symbol(), " ", period, " ", pattern);
           setalert = 0;
         }
     } // End of for loop
   return(0);
  }
//+------------------------------------------------------------------+