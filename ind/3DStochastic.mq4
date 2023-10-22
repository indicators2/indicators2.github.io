//+---------------------------------------------------------------------+
//|                                        #_i_3D_Stochastic.mq4        |
//|                                    Copyright © 2009, TigraVK        |
//|                                                                     |
//|Индикатор отображает поведение классического стохастика в            |
//|трехмерной диаграмме в основном окне графика торгового               |
//|инструмента. Построчно отбражаются стохастики с пошагово             |
//|увеличивающимися периодами %K, %D и проч. по желанию пользователя    |
//|В результате получается трехмерная картинка стохаастического веера   |
//|В данной версии индикатора возможны режимы отображения               |
//|направления движения стохастической кривой;                          |
//|ее абсолютного значения;                                             |
//|ее скорости роста или снижения.                                      |
//|                                                                     |
//|Координата Х на диаграмме - время в формате графика торгового        |
//|инструмента                                                          |
//|Координата Y на диаграмме - сверху вниз последовательное отображение |
//|стохастиков с различными параметрами                                 |
//|Координата Z отражена различными цветами в зависимости от ситуации   |
//|и положения стохастика в данной временнОй точке                      |
//+---------------------------------------------------------------------+
#property copyright "Copyright © 2009, TigraVK"
#property link      "tigravk@yandex.ru"

#property indicator_chart_window
#include <stdlib.mqh>

#define ELEMENTS 40           //количество отображаемых строк в диаграмме
extern int IndMode = 1;       //один из трех режимов отрисовки диаграмм: 0-Направление;1-абсолютное значение;2-баровая скорость изменения 
extern int Columns = 120;    //Количество отображаемых столбцов диаграммы
extern int Width = 1;         //Ширина столбца, в барах
extern int DrawShift = 0;     //Смещение нулевого столбца (в барах) относительно правой границы окна графика
                              //применяется в случае вывода двух копий индикатора с разными параметрами в одно окно
                              //для исключения визуальных пересечений диаграмм
                              //Например, для вывода второй диаграммы корректно будет установить DrawShift=Columns+4

//-- Начальные параметры стохастика и их приращения -----------
extern int Kp = 3;
extern int Kp_step = 3;
extern int Dp = 2;
extern int Dp_step = 1;
extern int Slowing = 2;
extern int Slowing_step = 1;
extern int Method = MODE_SMA;
extern int Price_field = 0;    //0 - Low/High или 1 - Close/Close
extern int Mode = MODE_SIGNAL; //MODE_MAIN 0 Основная линия; MODE_SIGNAL 1 Сигнальная линия 
//-------------------------------

#define COLUMNS_DOP 3   //кол-во дополнительных колонок в массиве STOCH[][] (типа, вычислительный запас)
#define HEADER 2        //место под заголовок (измеряется высотой элемета диаграммы)
#define GAP 0           //пробел (в барах) между элементами диаграммы в горизонтали
#define GAP_PERCENT 20  //пробел (в процентах от высоты элемента диаграммы) между элементами диаграммы в вертикали

double STOCH[][ELEMENTS];//массив карта данных с данными всех стохастиков
double Top;
double Bottom;
int    FreeBars;
string el_name;
string indname = "#_i_3D_Stochastic";
datetime tm;
int shift;

//+------------------------------------------------------------------+
int init()
{
   tm=Time[0];
   shift=DrawShift*(Width+GAP);
   Top    =WindowPriceMax(0);
   Bottom =WindowPriceMin(0);
   FreeBars=WindowBarsPerChart()-WindowFirstVisibleBar()-shift;
   if(IndMode==0)
   {
      el_name = "RCTDIR";
      CreateHeader("Direction", Top, Width, Columns, FreeBars, Yellow);
   }
   else if(IndMode==1)
   {
      el_name = "RCTABS";
      CreateHeader("Absolute", Top, Width, Columns, FreeBars, Yellow);
   }
   else if(IndMode==2)
   {
      el_name = "RCTACC";
      CreateHeader("Acceleration", Top, Width, Columns, FreeBars, Yellow);
   }
   else
   {
      el_name = "RCT";
      CreateHeader("NONE", Top, Width, Columns, FreeBars, Yellow);
   }
   
   IndicatorShortName(indname);
   
   ArrayResize(STOCH,Columns+COLUMNS_DOP);
   ArrayInitialize(STOCH, 0.0);
   
   //создаем квадратики
   for(int i=0; i<Columns; i++)
      CreateShield(el_name+i+"_", Top, Bottom, Width, FreeBars-(Width+GAP)*i, Gray);

   return(0);
}
//+------------------------------------------------------------------+
int deinit()
{
   DeleteIndicatorObject(el_name);
   return(0);
}
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int start()
{
   int i;
   int limit;
   double top    =WindowPriceMax(0);
   double bottom =WindowPriceMin(0);
   int free_bars =WindowBarsPerChart()-WindowFirstVisibleBar()-shift;
   
   int counted_bars=IndicatorCounted();
   limit=Bars-counted_bars;
   if(limit>Columns+COLUMNS_DOP) limit=Columns+COLUMNS_DOP;


   //Процедура перерисовки диаграммы при смене текущего бара или размеров экранной области графика
   if(Top!=top || Bottom!=bottom || FreeBars!=free_bars || tm!=Time[0])
   {
      Top=top; Bottom=bottom; FreeBars=free_bars; tm=Time[0];
      for(i=0; i<Columns; i++)
      {
         if(MoveShield(el_name+i+"_", Top, Bottom, Width, FreeBars-(Width+GAP)*i)<0)
         {
            DeleteIndicatorObject(el_name+i+"_");
            CreateShield(el_name+i+"_", Top, Bottom, Width, FreeBars-(Width+GAP)*i, Gray);
         }
      }
      MoveHeader(Top, Width, Columns, FreeBars, Yellow);
   }



   if(limit>=Columns+COLUMNS_DOP) //полная отрисовка при запуске индикатора
   {
      StochDATA_fill(STOCH, limit, 0, 0);
      if(IndMode==0)      StochasticWeerDirection(STOCH, Columns);
      else if(IndMode==1) StochasticWeerAbsolute(STOCH, Columns);
      else if(IndMode==2) StochasticWeerAcceleration(STOCH, Columns);
   }
   else if(limit>1 && limit<Columns+COLUMNS_DOP) //перерисовка при смене бара
   {
      StochDATA_leftShift(STOCH, Columns+COLUMNS_DOP, limit-1);
      StochDATA_fill(STOCH, limit-1, 0, 0);
      if(IndMode==0)      StochasticWeerDirection(STOCH, Columns);
      else if(IndMode==1) StochasticWeerAbsolute(STOCH, Columns);
      else if(IndMode==2) StochasticWeerAcceleration(STOCH, Columns);
   }
   else //перерисовка только текущего бара
   {
      StochDATA_fill(STOCH, limit, 0, 0);
      if(IndMode==0)      StochasticWeerDirection(STOCH, limit);
      else if(IndMode==1) StochasticWeerAbsolute(STOCH, limit);
      else if(IndMode==2) StochasticWeerAcceleration(STOCH, Columns);
   }
   err("Start:  ");
   return(0);
}


//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
void StochDATA_fill(double& DATA[][], int recount_columns, int start_columns, int historyBarShift)
{
   int i,j;
   int kp=Kp;
   int dp=Dp;
   int sl=Slowing;
   
   for(j=start_columns; j<recount_columns+start_columns; j++)
   {
      kp=Kp; dp=Dp; sl=Slowing;
      for(i=0; i<ELEMENTS; i++)
      {
         DATA[j][i] = iStochastic(NULL, 0, kp, dp, sl, Method, Price_field, Mode, j+historyBarShift);
         kp=kp+Kp_step;
         dp=dp+Dp_step;
         sl=sl+Slowing_step;
      }
   }
   return;
}

//+------------------------------------------------------------------+
void StochDATA_leftShift(double& DATA[][], int columns, int shift_columns_count)
{
   int i,j,k;
   for(k=1; k<=shift_columns_count; k++)
   {   
      for(j=columns-1; j>0; j--)
      {
         for(i=0; i<ELEMENTS; i++)
            DATA[j][i] = DATA[j-1][i];
      }
      for(i=0; i<ELEMENTS; i++)
         DATA[0][i] = 0.0;
   }
}

//+------------------------------------------------------------------+
void StochasticWeerDirection(double& DATA[][], int recount_columns)
{
   int i,j;
   for(j=recount_columns; j>0; j--)
   {
      for(i=0; i<ELEMENTS; i++)
      {
         if(DATA[j-1][i]-DATA[j][i]>0.0) ObjectSet(el_name+DoubleToStr(j-1,0)+"_"+i, OBJPROP_COLOR, LightGreen);
         else                            ObjectSet(el_name+DoubleToStr(j-1,0)+"_"+i, OBJPROP_COLOR, Red);
      }
   }
}

//+------------------------------------------------------------------+
void StochasticWeerAbsolute(double& DATA[][], int recount_columns)
{
   int i,j;
   color clr;

   for(j=recount_columns; j>0; j--)
   {
      for(i=0; i<ELEMENTS; i++)
      {
         if(DATA[j][i]>=50 && DATA[j][i]<80)
         {
            clr = ColorGradient(DATA[j][i], 50, 80, 1); //зеленый
            ObjectSet(el_name+DoubleToStr(j-1,0)+"_"+i, OBJPROP_COLOR, clr);
         }
         else if(DATA[j][i]>=80 && DATA[j][i]<90)
            ObjectSet(el_name+DoubleToStr(j-1,0)+"_"+i, OBJPROP_COLOR, Chocolate);
         else if(DATA[j][i]>=90 && DATA[j][i]<=100)
            ObjectSet(el_name+DoubleToStr(j-1,0)+"_"+i, OBJPROP_COLOR, Maroon);
         else if(DATA[j][i]<50 && DATA[j][i]>=20)
         {
            clr = ColorGradient(-DATA[j][i], -50, -20, 2); //синий
            ObjectSet(el_name+DoubleToStr(j-1,0)+"_"+i, OBJPROP_COLOR, clr);
         }
         else if(DATA[j][i]<20 && DATA[j][i]>=10)
            ObjectSet(el_name+DoubleToStr(j-1,0)+"_"+i, OBJPROP_COLOR, Navy);
         else if(DATA[j][i]<10 && DATA[j][i]>=0)
            ObjectSet(el_name+DoubleToStr(j-1,0)+"_"+i, OBJPROP_COLOR, Black);
      }
   }
}

//+------------------------------------------------------------------+
void StochasticWeerAcceleration(double& DATA[][], int columns)
{
   int i,j;
   color clr;
   double max_vel;
   double VEL[][ELEMENTS];
   ArrayResize(VEL, columns);
     
   //Нарисуем матрицу скоростей
   for(j=columns; j>0; j--)
      for(i=0; i<ELEMENTS; i++)
         VEL[j-1][i]=DATA[j-1][i]-DATA[j][i];
   
   //за период Columns самая сильная абсолютная баровая скорость
   for(i=0; i<ELEMENTS; i++)
   {
      max_vel=-10000;
      for(j=0; j<columns; j++)
            max_vel=MathMax(max_vel, MathAbs(VEL[j][i]));
   
      //Скорость вниз - красный градиент; скорость вверх - зеленый
      for(j=0; j<columns; j++)
      {
         if(VEL[j][i]>=0)   
         {
            clr = ColorGradient(VEL[j][i], 0, max_vel, 1); //зеленый
            ObjectSet(el_name+j+"_"+i, OBJPROP_COLOR, clr);
         }
         else
         {
            clr = ColorGradient(-VEL[j][i], 0, max_vel, 0); //красный
            ObjectSet(el_name+j+"_"+i, OBJPROP_COLOR, clr);
         }
      }
   }
}


//+------------------------------------------------------------------+
color ColorGradient(double current_vol, double min_vol, double max_vol, int maincolor)
{
   int R,G,B;
   int cur;
   if(current_vol<min_vol) current_vol=min_vol;    
   if(current_vol>max_vol) current_vol=max_vol;    

   cur = 255-255*(current_vol-min_vol)/(max_vol-min_vol);
   if(maincolor==0)  //RED
   { R=255; G=cur; B=cur; }
   else if(maincolor==1) //GREEN
   { R=cur; G=255; B=cur; }
   else if(maincolor==2) //BLUE
   { R=cur; G=cur; B=255; }
   else {R=0;G=0;B=0;}   
   
   G<<=8;
   B<<=16;
   return(R+G+B);
}

//+------------------------------------------------------------------+
void CreateShield(string name_mask, double top, double bottom, int width, int freebars, color clr)
{
   double high, gap, y1, y2;
   datetime fut0, fut1;

   high = (top-bottom)/(ELEMENTS*1.0);
   gap= high*GAP_PERCENT/100.0;
   bottom=bottom+gap;
   top=top-HEADER*high;
   high = (top-bottom)/(ELEMENTS*1.0);
   gap= high*GAP_PERCENT/100.0;
   high=high-gap;
   
   if(freebars>0)
   {
      fut0=Time[0]+Period()*freebars*60;
      fut1=Time[width]+Period()*freebars*60;
   }
   else
   {
      fut0=iTime(NULL,0,-freebars);
      fut1=iTime(NULL,0,-freebars+width);
   }
   y2=top;
   for(int i=0; i<ELEMENTS; i++)
   {
      y1=y2-gap;
      y2=y1-high;
      ObjectCreate(name_mask+i, OBJ_RECTANGLE, 0, fut0, y1, fut1, y2);
      ObjectSet(name_mask+i, OBJPROP_COLOR, clr);
   }
   return;
}

//+------------------------------------------------------------------+
int MoveShield(string name_mask, double top, double bottom, int width, int freebars)
{
   double high, gap, y1, y2;
   datetime fut0, fut1;

   high = (top-bottom)/(ELEMENTS*1.0);
   gap= high*GAP_PERCENT/100.0;
   bottom=bottom+gap;
   top=top-HEADER*high;
   high = (top-bottom)/(ELEMENTS*1.0);
   gap= high*GAP_PERCENT/100.0;
   high=high-gap;
   
   if(freebars>0)
   {
      fut0=Time[0]+Period()*freebars*60;
      fut1=Time[width]+Period()*freebars*60;
   }
   else
   {
      fut0=iTime(NULL,0,-freebars);
      fut1=iTime(NULL,0,-freebars+width);
   }
   y2=top;
   for(int i=0; i<ELEMENTS; i++)
   {
      y1=y2-gap;
      y2=y1-high;
      if(ObjectMove(name_mask+i, 0, fut0, y1)==false) return(-1);
      ObjectMove(name_mask+i, 1, fut1, y2);
   }
   return(0);
}

//+------------------------------------------------------------------+
void CreateHeader(string text, double top, int width, int columns, int freebars, color clr)
{
   datetime time_center;
   int allbars;
   if(freebars<0) {Print("ERROR CreateHeader: freebars<0"); return;}   
   allbars = columns*(width+GAP); //столько нужно баров под диаграмму
   if(allbars/2<freebars) //центр заголовка умещается в зоне за графиком справа
      time_center=Time[0] + 60*Period()*(freebars - columns*(width+GAP)/2);
   else   //отрисовка частично захватывает историческую зону
      time_center = iTime(NULL, 0, allbars/2-freebars);
   ObjectCreate(el_name+"_HEAD", OBJ_TEXT, 0, time_center, top);
   ObjectSetText(el_name+"_HEAD", text, 14, "Areal", clr);
   return;
}

//+------------------------------------------------------------------+
void MoveHeader(double top, int width, int columns, int freebars, color clr)
{
   datetime time_center;
   int allbars;
   if(freebars<0) {Print("ERROR CreateHeader: freebars<0"); return;}   
   allbars = columns*(width+GAP); //столько нужно баров под диаграмму
   if(allbars/2<freebars) //центр заголовка умещается в зоне за графиком справа
      time_center=Time[0] + 60*Period()*(freebars - columns*(width+GAP)/2);
   else   //отрисовка частично захватывает историческую зону
      time_center = iTime(NULL, 0, allbars/2-freebars);
   ObjectMove(el_name+"_HEAD", 0, time_center, top);
}

//+------------------------------------------------------------------+
void DeleteIndicatorObject(string mask)
{
   int obj_total, i, out;
   string name;
   out=1;
   while(out>0)
   {   
      obj_total=ObjectsTotal();
      out=0;
      for(i=0;i<obj_total;i++)
      {
         name = ObjectName(i);
         if(StringFind(name,mask)>=0) { ObjectDelete(name); out++; }
      }
   }
}
//+------------------------------------------------------------------+
void err(string name)
{
   int err=GetLastError();
   if(err!=0)  Print(name," ERROR(",err,"): ",ErrorDescription(err));
}

