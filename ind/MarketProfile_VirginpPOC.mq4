//+------------------------------------------------------------------+
//|                                     MarketProfile_Virgin POC.mq4 |
//|                             Copyright © 2006, V&K Software Corp. |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2006, V&K Software Corp."
#property link      ""

#property indicator_chart_window

extern int     Days_with_the_histogram     = 1; // Количество дней для построения Гистограммы
extern bool    To_show_values     =true;// включить значения уровней
extern int     Range_percent       =70;
extern color   Color_VirginPOCs         =Green;// цвет уровня Virgin POC(Point of Control Formation) 
extern color   Color_POCs               =DarkGray;// цвет уровня POC точки формирования контроля
extern color   Colour_in_a_range   =MediumVioletRed;// цвет внутреннего диапазона цен
extern color   Colour_behind_a_range      =RoyalBlue;// цвет внешнего диапазона цен
extern int     Displacement_GMT            =0; // смещение меток относительно 0 бара
extern bool    To_build_today         =false; // Построения для текущего дня
extern int     Construction_step          = 1; // Шаг сетки построения
extern int     Max_of_days_calculation        = 90; // Максимальное колво дней для расчета если -1 вся доступная история
extern int     Shift                   = 8; // смещение меток относительно 0 бара

// Глобальные переменные
bool           RedrawFlag;
double         Divider;
datetime       TimeZero=0;
int            CountPOC=0;
string         VirginPOC[];
string         StartTime, EndTime;
string         PrefixName="MARKET_VIRGIN";
//string         Comm;
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int init()
{
//---- indicators
   RedrawFlag=true;
//----
   switch(Period())
   {
      case PERIOD_M1:   Divider=(PERIOD_D1/5.0)/(PERIOD_D1/PERIOD_M1);
                        break;
      case PERIOD_M5:   Divider=(PERIOD_D1/5.0)/(PERIOD_D1/PERIOD_M5);
                        break;
      case PERIOD_M15:  Divider=(PERIOD_D1/5.0)/(PERIOD_D1/PERIOD_M15)-1;
                        break;
      case PERIOD_M30:  Divider=(PERIOD_D1/5.0)/(PERIOD_D1/PERIOD_M30)-2;
                        break;
      case PERIOD_H1:   Divider=(PERIOD_D1/5.0)/(PERIOD_D1/PERIOD_H1)-8;
                        break;
      case PERIOD_H4:   Divider=12;
                        break;
      case PERIOD_D1:   Divider=5.0/PERIOD_D1*2;
                        break;
      case PERIOD_W1:   Divider=5.0/PERIOD_W1;
                        break;
      default:
                        Divider=1;
                        break;                  
   }
   if(StringFind( Symbol(), "#")!=-1||StringFind( Symbol(), "_")!=-1)
   {
      StartTime="13:30";
      EndTime="19:59";
   }
   else
   {
      StartTime="0:00";
//      StartTime="13:30";
//      EndTime="19:59";
      EndTime="23:00";
   }
   if(StringFind( Symbol(), "_ES")!=-1)
      Construction_step=10;
   return(0);
}
//+------------------------------------------------------------------+
//| Custom indicator deinitialization function                       |
//+------------------------------------------------------------------+
int deinit()
{
   int i = 0; 
   string ObjName;
   while(i < ObjectsTotal())
   {
      ObjName = ObjectName(i);
      if(StringFind( ObjName, PrefixName)==-1) 
      { 
         i++; 
         continue;
      }
      ObjectDelete(ObjName);
   }
//----
   return(0);
}
//+==================================================================+
//| Уменьшение даты на один торговый день                            |
//| Параметры:                                                       |
//|   dt - дата торгового дня без учета выходных                     |
//+------------------------------------------------------------------+
datetime decDateTradeDay (datetime dt)
{
   datetime result;
   result=StrToTime(TimeToStr(StrToTime(TimeToStr(dt,TIME_DATE)+" 0:00")-PERIOD_D1,TIME_DATE));
   while (TimeDayOfWeek(result)>5||TimeDayOfWeek(result)<1) result=decDateTradeDay(result);
   return(result);
}
//+==================================================================+
//| Построение и проверка уровней POCs                               |
//| Параметры:                                                       |
//|   X           - дата стартового дня                              |
//|   Y           - значение уровня                                  |
//+------------------------------------------------------------------+
void Draw_POCs(datetime X, double Y)
{
   
   bool     VirginFlag=true;
   color    Color;
   datetime EndX;
   string   name_line;
   int      StartBar, EndBar;
   if(TimeDayOfWeek(X)==5)
      StartBar=iBarShift(NULL,PERIOD_M5,X+PERIOD_D1*60*3);
   else
      StartBar=iBarShift(NULL,PERIOD_M5,X+PERIOD_D1*60);
   EndBar=iBarShift(NULL,PERIOD_M5,StrToTime(TimeToStr(Time[0],TIME_DATE)));
   for(int i=StartBar; i>=EndBar; i--)
   {
      if(Y<iHigh(NULL, PERIOD_M5, i) && Y>iLow(NULL, PERIOD_M5, i))
         break;
   }
   name_line=PrefixName+TimeToStr(X)+"POC";
   if(i!=EndBar-1)
   {
      VirginFlag=false;
      Color=Color_POCs;
      EndX=iTime(NULL, PERIOD_M5, i);
      if(TimeToStr(EndX,TIME_DATE)==TimeToStr(TimeCurrent(),TIME_DATE) || TimeToStr(Time[0],TIME_DATE)==TimeToStr(X,TIME_DATE))
         VirginFlag=true;
   }
   if(VirginFlag)
   {
      Color=Color_VirginPOCs;
      EndX=Time[0]+Shift*Period()*60;
      int size=ArrayRange(VirginPOC,0)+1;
      ArrayResize(VirginPOC,size);
      VirginPOC[size-1]=name_line;
   }
   if(ObjectFind(name_line)==-1)
   {
      ObjectCreate(name_line, OBJ_TREND, 0, 0, 0, 0, 0);
      ObjectSet(name_line, OBJPROP_BACK, false);
      ObjectSet(name_line, OBJPROP_RAY, 0);
   }
   ObjectMove(name_line,0, X, Y);
   ObjectMove(name_line,1, EndX, Y);
   ObjectSet(name_line, OBJPROP_COLOR, Color);
   if(!To_show_values && !VirginFlag)
      return;
   name_line = name_line+" LABLE";
   if(ObjectFind(name_line) == -1)
   {
      ObjectCreate(name_line, OBJ_ARROW, 0, 0,0);
      ObjectSet(name_line, OBJPROP_BACK, false);
   }
   if(VirginFlag)
      ObjectSet(name_line, OBJPROP_ARROWCODE, SYMBOL_RIGHTPRICE);
   else
      ObjectSet(name_line, OBJPROP_ARROWCODE, SYMBOL_LEFTPRICE);
   ObjectMove(name_line, 0, EndX,Y);
   ObjectSet(name_line, OBJPROP_COLOR, Color);
   
//   Comm=Comm+TimeToStr(X)+"  "+VirginFlag+"  "+TimeToStr(iTime(NULL,PERIOD_M5,i))+"\n";
}
//+==================================================================+
//| Расчет и построение рыночного профиля                            |
//| Параметры:                                                       |
//|   dt          - дата торгового                                   |
//|   StartTime   - время открытия сесии                             |
//|   EndTime     - время закрытия сесии                             |
//|   Draw        - флаг построения                                  |
//+------------------------------------------------------------------+
void DrawMarket(datetime dt, string StartTime, string EndTime, bool HDraw)
{
   datetime    GMT=Displacement_GMT*PERIOD_H1*60;
   datetime    dt0=StrToTime(TimeToStr(dt,TIME_DATE)+" "+StartTime)+GMT;
   datetime    dt1=StrToTime(TimeToStr(dt,TIME_DATE)+" "+EndTime)+GMT;
   int         StartBar=iBarShift(NULL,PERIOD_M5,dt0);
   int         EndBar=iBarShift(NULL,PERIOD_M5,dt1);
   int         BarCount=StartBar-EndBar+1;
   double      HighDay=iHigh(NULL,PERIOD_M5,iHighest(NULL,PERIOD_M5,MODE_HIGH,BarCount,EndBar));
   double      LowDay=iLow(NULL, PERIOD_M5, iLowest(NULL,PERIOD_M5,MODE_LOW,BarCount,EndBar));
   int         NumberOfPoints = (HighDay - LowDay) / (1.0*Point*Construction_step) + 1;
   // Заполнение массива уровней и поиск уровня на котором цена находилась макс. кол-во времени
   int Count[];
   ArrayResize(Count, NumberOfPoints);
   ArrayInitialize(Count,0);

   for(int i = StartBar; i >= EndBar; i--)
   {
      double C = iLow(NULL, PERIOD_M5, i);
      while(C < iHigh(NULL, PERIOD_M5, i))
      {
         int Index = (C-LowDay) / (1.0*Point*Construction_step);
         Count[Index]++;    
         C += 1.0*Point*Construction_step;
      }
   }
   int MaxLine = ArrayMaximum( Count, NumberOfPoints);
   // Выводим на экран линию POCs
   Draw_POCs(iTime(NULL, PERIOD_M5, StartBar), LowDay + 1.0*Point*Construction_step*MaxLine);
   
   if(!HDraw)
   {
      ArrayResize(Count, 0);
      return;
   }

   int tmp=Count[MaxLine]-Count[MaxLine]*Range_percent/100;
   int DownLine=0;
   int UpLine=0;
   for(i=0; i < NumberOfPoints; i++)
   {
      if(Count[i]>=tmp)
      {
         DownLine=i;
         break;
      }
   }
   for(i=NumberOfPoints-1; i > 0; i--)
   {
      if(Count[i]>=tmp)
      {
         UpLine=i;
         break;
      }
   }
   if(DownLine==0)
      DownLine=MaxLine;
   if(UpLine==0)
      UpLine=MaxLine;
      
   for(i = 0; i < NumberOfPoints; i++)
   {
      datetime StartX = iTime(NULL, PERIOD_M5, StartBar);
      double StartY = LowDay + 1.0*Point*Construction_step*i; 
      datetime EndX   = StartX+(Count[i]/Divider+1)*Period()*60; //Time[StartBar+Count[i]];
      double EndY   = StartY;
      string name_line = PrefixName+TimeToStr(dt0)+i;
      if(ObjectFind(name_line)==-1)
      {
         ObjectCreate(name_line, OBJ_TREND, 0, StartX, StartY, EndX, EndY);
         ObjectSet(name_line, OBJPROP_BACK, true);
         ObjectSet(name_line, OBJPROP_RAY, 0);
      }
      ObjectMove(name_line,0, StartX, StartY);
      ObjectMove(name_line,1, EndX, EndY);
      ObjectSet(name_line, OBJPROP_WIDTH, 1);
      if( i==MaxLine)
      {
         ObjectSet(name_line, OBJPROP_COLOR, Color_POCs);
         ObjectSet(name_line, OBJPROP_WIDTH, 3);
      }
      if(i>=DownLine&&i<=UpLine)
      {
         int shift=60;
         if(TimeDayOfWeek(dt0)==5)
            shift=60*3;
         if(i!=MaxLine)ObjectSet(name_line, OBJPROP_COLOR, Colour_in_a_range);
         if(i==DownLine)
         {
            datetime today=dt1;//StrToTime(TimeToStr(dt1+PERIOD_D1*shift,TIME_DATE));
            double   DownY=StartY;
//               Comm=Comm+TimeToStr(today)+"  "+TimeToStr(today+PERIOD_D1*shift)+"\n";
            name_line = PrefixName+TimeToStr(dt0)+"DOWN";
            if(ObjectFind(name_line)==-1)
            {
               ObjectCreate(name_line, OBJ_TREND, 0, 0, 0, 0, 0);
               ObjectSet(name_line, OBJPROP_RAY, 0);
            }
            ObjectMove(name_line,0, today, StartY);
            ObjectMove(name_line,1, today+PERIOD_D1*shift, EndY);
            ObjectSet(name_line, OBJPROP_COLOR, Colour_in_a_range);
         }
         if(i==UpLine)
         {
            double   UpY=StartY;
            name_line = PrefixName+TimeToStr(dt0)+"UP";
            if(ObjectFind(name_line)==-1)
            {
               ObjectCreate(name_line, OBJ_TREND, 0, 0, 0, 0, 0);
               ObjectSet(name_line, OBJPROP_RAY, 0);
            }
            ObjectMove(name_line,0, today, StartY);
            ObjectMove(name_line,1, today+PERIOD_D1*shift, EndY);
            ObjectSet(name_line, OBJPROP_COLOR, Colour_in_a_range);
         }
      }
      else
      {
         ObjectSet(name_line, OBJPROP_COLOR, Colour_behind_a_range);
      }
   }
/*   name_line = PrefixName+TimeToStr(dt0)+"BOX";
   if(ObjectFind(name_line)==-1)
   {
      ObjectCreate(name_line, OBJ_RECTANGLE, 0, 0, 0, 0, 0);
         ObjectSet(name_line, OBJPROP_BACK, true);
         ObjectSet(name_line, OBJPROP_RAY, 0);
      }
      ObjectMove(name_line,0, today, UpY);
      ObjectMove(name_line,1, today+PERIOD_D1*shift, DownY);
      ObjectSet(name_line, OBJPROP_WIDTH, 1);
      ObjectSet(name_line, OBJPROP_COLOR, Bisque); */
   ArrayResize(Count, 0);
}
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int start()
{
   int         counted_bars=IndicatorCounted();
   datetime    dt, end_dt;
//----
   if(Period()>PERIOD_H4) return(-1); //Проверяем ТаймФрейм если боьше H4 выходим
//----
   dt=TimeCurrent();
   if(TimeZero!=Time[0])
   {
      double   c=iClose(NULL,PERIOD_M1,1);
               c=iClose(NULL,PERIOD_M5,1);
               c=iClose(NULL,PERIOD_M15,1);
               c=iClose(NULL,PERIOD_M30,1);
               c=iClose(NULL,PERIOD_H1,1);
               c=iClose(NULL,PERIOD_H4,1);
               c=iClose(NULL,PERIOD_D1,1);
               c=iClose(NULL,PERIOD_W1,1);
               c=iClose(NULL,PERIOD_MN1,1);
      TimeZero=Time[0];
   }
   if(!To_build_today)
      dt=decDateTradeDay(dt);
   else
   {
      DrawMarket(dt, StartTime, EndTime, true);
      dt=decDateTradeDay(dt);
   }
   if(RedrawFlag)
   {
      end_dt=StrToTime(TimeToStr(iTime(NULL,PERIOD_M5, iBars(NULL,PERIOD_M5)-1),TIME_DATE));
      if(Max_of_days_calculation >= 1)
         end_dt=StrToTime(TimeToStr(iTime(NULL,PERIOD_D1, Max_of_days_calculation),TIME_DATE));
      int i=1;
      while(end_dt!=dt)
      {
         if(i<=Days_with_the_histogram)
            DrawMarket(dt, StartTime, EndTime, true);
         else
            DrawMarket(dt, StartTime, EndTime, false);
         dt=decDateTradeDay(dt);
         i++;
      }
   }
   RedrawFlag=false;
   for(i=0; i< ArrayRange(VirginPOC,0); i++)
   {
      ObjectMove(VirginPOC[i], 1,Time[0]+Shift*Period()*60,ObjectGet(VirginPOC[i],OBJPROP_PRICE1));
      ObjectMove(VirginPOC[i]+" LABLE", 0,Time[0]+Shift*Period()*60,ObjectGet(VirginPOC[i]+" LABLE",OBJPROP_PRICE1));
   }
//   Comment(Comm);
//----
   return(0);
  }
//+------------------------------------------------------------------+