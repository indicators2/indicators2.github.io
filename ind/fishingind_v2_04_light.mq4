//+------------------------------------------------------------------+
//|                                          FISHINGIND_V2_04_LIGHT  |
//|              MAX888 && PavelG && Pavka69 && Barrel && UserUserov |
//|             http://forum.tradelikeapro.ru/index.php?topic=4731.0 |
//|                                                          v. 2.04 |
//|                                     для оптимизации (без графики)|
//+------------------------------------------------------------------+
// v. 2.04
// - ищется второй экстремум, удовлетворяющий условию для линии. Может быть не соседний. Линия рисуется всегда.
// v. 2.03
// - добавлено пересчет заявленного количества свечей на каждом тике
// v. 2.02
// - добавлены рисование линий со старшего ТФ
//

#property copyright "MAX888 && PavelG && Pavka69 && Barrel && UserUserov"
#property link      "http://forum.tradelikeapro.ru/index.php?topic=4731.0"

#property indicator_chart_window
#property indicator_buffers 2
#property indicator_color1 Silver
#property indicator_color2 Silver
//--- input parameters
extern int        otstup = 50;//отступ от High Low в пунктах для рисования фрактала и линии
extern int        kolshow = 500; //количество свечей для расчета фракталов на графике
extern bool       linealways = true;//ищется ближайший экстремум, удовлетворяющий условию. линия рисуется всегда

//--- buffers
double High_[];
double Low_[];

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int init()
  {
//---- indicators
   SetIndexStyle(0,DRAW_ARROW);
   SetIndexArrow(0,217);
   SetIndexBuffer(0,High_);
   SetIndexEmptyValue(0,0.0);
   SetIndexStyle(1,DRAW_ARROW);
   SetIndexArrow(1,218);
   SetIndexBuffer(1,Low_);
   SetIndexEmptyValue(1,0.0);
   SetIndexDrawBegin(0,kolshow);
   SetIndexDrawBegin(1,kolshow);

//----
   return(0);
  }
//+------------------------------------------------------------------+
//| Custom indicator deinitialization function                       |
//+------------------------------------------------------------------+
int deinit()
  {
//----
//----
   return(0);
  }
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int start()
{
   int    counted_bars=IndicatorCounted();
   int count, m;
   if (Bars <= 4) return (0);
   count = kolshow;
   ArrayInitialize(High_,0.0);
   ArrayInitialize(Low_,0.0);
   
   for (int i = count; i >= 0; i--)
   {
      if(High[i+2]>High[i+1] && High[i+2]>=High[i+3]) High_[i+2] = High[i+2]+Point*otstup;
      if(Low[i+2]<Low[i+1] && Low[i+2]<=Low[i+3]) Low_[i+2] = Low[i+2]-Point*otstup;
   }

//----
   return(0);
}

