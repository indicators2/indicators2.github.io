//+------------------------------------------------------------------+
//|                                                (Shu)-AccInfo.mq4 |
//|                                                             `Shu |
//|                                            http://SovetnikShu.ru |
//+------------------------------------------------------------------+
#property copyright "`Shu"
#property link      "http://SovetnikShu.ru"

#property indicator_separate_window

extern int Months = 6;
extern int Weeks  = 6;


extern color clrHead = clrAqua;
extern color clrGood = clrLime;
extern color clrBaad = clrRed;

int win;

string shu = " [1.02] (c) `Shu [http://SovetnikShu.ru]";
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int init() {
   Print(WindowExpertName() + shu);

return(0);
}
//+------------------------------------------------------------------+
//| Custom indicator deinitialization function                       |
//+------------------------------------------------------------------+
int deinit() {
return(0);
}
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int start() {
   int i;
   double d;
   datetime dt,dt_temp;
   string s;

   IndicatorShortNameshu("(Shu)-AccInfo: " + AccountNumber() + " " + AccountCompany());   

   ccc(win, "");
   ccc(win, "Счёт: "   + ns0(AccountNumber()),  clrHead, 0, 20, 20, 20);
   ccc(win, "Баланс: " + ns2(AccountBalance()), clrGood);
   ccc(win, "Эквити: " + ns2(AccountEquity()),  clrGood);
   
   d = Result(0, TimeCurrent() + 1);
   s = "Результат: " + ns2(d);
   ccc(win, s, iif(d >= 0, clrGood, clrBaad));    
   
   ccc(win, "Месяцы: ", clrHead, 0, 160, 20, 0);
   
   for (i = 0; i > -Months; i--) {
      dt = StartMonth(TimeCurrent(), i);   
      d = Result(dt, StartMonth(dt, 1) - 1);
      s = MonthTxt(TimeMonth(dt)) + ": " + ns2(d);
      ccc(win, s, iif(d >= 0, clrGood, clrBaad));      
   }

   ccc(win, "Недели: ", clrHead, 0, 300, 20, 0);

   for (i = 0; i > -Weeks; i--) {
      dt = StartWeek(TimeCurrent(), i);   
      d = Result(dt, StartWeek(dt, 1) - 1);
      s = TimeToStr(dt, TIME_DATE) + ": " + ns2(d);
      ccc(win, s, iif(d >= 0, clrGood, clrBaad));    
   }

   ccc(win, "Дни: ", clrHead, 0, 460, 20, 0);

   for (i = 4; i > -1; i--) {
      dt = StartWeek(TimeCurrent(), 0);
      dt_temp = dt + i * 86400;   
      d = Result(dt_temp, dt_temp + 86400);
      s = DayTxt(TimeDayOfWeek(dt_temp)) + ": " + ns2(d);
      ccc(win, s, iif(d >= 0, clrGood, clrBaad));    
   }

return(0);
}
//+------------------------------------------------------------------+
void ccc(int wn = 0, string txt = "", color clr = Green, int cr = 0, int X = 0, int Y = 0, int stp = 0, string font = "Colibri Bold", int fs = 10) {
   static int num = 0;
   static int x, y;
   static int step = 10;
   int i;
   int x0 = 0, y0 = 0;
   string on, n;

   on = "ccc" + "." + wn;
   
   if (txt == "") {
      x = x0;
      y = y0;
      num = 0;
      for (i = ObjectsTotal() - 1; i >= 0 ; i--) {
         n = ObjectName(i);
         if (ObjectType(n) != OBJ_LABEL) continue;
         if (StringFind(n, on) != -1) ObjectDelete(n);
      }   
      return;
   }
   
   if (stp > 0) step = stp;
   
   if ((X <  0) || (Y <  0)) {x = x0; y = y0;} 
   if ((X >  0) || (Y >  0)) {x = X;  y = Y; } 
   
   on = on + "." + num;
   
   ObjectCreate(on, OBJ_LABEL, wn, 0, 0);
   ObjectSet   (on, OBJPROP_CORNER, cr);
   ObjectSet   (on, OBJPROP_XDISTANCE, x);
   ObjectSet   (on, OBJPROP_YDISTANCE, y);
   ObjectSet   (on, OBJPROP_COLOR, clr);
   ObjectSetText(on, txt, fs, font, clr);
   
   num++;
   y = y + step;
   
return;
}
//+------------------------------------------------------------------+
string ns2(double Значение) {
   return(DoubleToStr(Значение, 2));
}
//+------------------------------------------------------------------+
string ns0(double Значение) {
   return(DoubleToStr(Значение, 0));
}
//+------------------------------------------------------------------+
void IndicatorShortNameshu(string s) {
   IndicatorShortName(s);
   win = WindowFind(s);
return; 
}
//+------------------------------------------------------------------+
string MonthTxt(int m) {
   string r;
   switch (m) {
      case  1:  r = "Январь";    break;
      case  2:  r = "Февраль";   break;
      case  3:  r = "Март";      break;
      case  4:  r = "Апрель";    break;
      case  5:  r = "Май";       break;
      case  6:  r = "Июнь";      break;
      case  7:  r = "Июль";      break;
      case  8:  r = "Август";    break;
      case  9:  r = "Сентябрь";  break;
      case 10:  r = "Октябрь";   break;
      case 11:  r = "Ноябрь";    break;
      case 12:  r = "Декабрь";   break;
      default:  r = "---";
   }
return(r);
}
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
string DayTxt(int m) {
   string r;
   switch (m) {
      case  0:  r = "Воскресенье"; break;
      case  1:  r = "Понедельник"; break;      
      case  2:  r = "Вторник    "; break;
      case  3:  r = "Среда      "; break;
      case  4:  r = "Четверг    "; break;
      case  5:  r = "Пятница    "; break;
      case  6:  r = "Суббота    "; break;
      default:  r = "---";
   }
return(r);
}
//+------------------------------------------------------------------+

double Result(datetime dt1, datetime dt2) {
   int i;
   double r;
   
   r = 0;
   for (i = 0; i < OrdersHistoryTotal(); i++) {
      if (OrderSelect(i, SELECT_BY_POS, MODE_HISTORY)) {
         if (OrderClosePrice() == 0) continue;
         if ((OrderCloseTime() < dt1) || (OrderCloseTime() > dt2)) continue;
         r = r + OrderProfit() + OrderCommission() + OrderSwap();
      }
   }
return(r);   
}
//+------------------------------------------------------------------+
datetime StartMonth(datetime dt = 0, int shift = 0) {
   int i, y, m;
   if (dt == 0) dt = TimeCurrent();
   
   y = TimeYear(dt);
   m = TimeMonth(dt);
   while (shift != 0) {
      if (shift > 0) {
         shift--;
         m++;
         if (m > 12) {
            m = 1;
            y++;
         }
      }
      if (shift < 0) {
         shift++;
         m--;
         if (m < 1) {
            m = 12;
            y--;
         }
      }
   }
   
   dt = StrToTime(y + "." + m + ".1");
   
return(dt);   
}
//+------------------------------------------------------------------+
// * возвращаем время 
datetime StartWeek(datetime dt, int shift = 0) {
   datetime r;

   r = dt + shift * PERIOD_W1 * 60;
   
   r = r / (PERIOD_D1 * 60);
   r = r  * (PERIOD_D1 * 60);                       // - здесь получили время начала дня
   
   switch(TimeDayOfWeek(r)) {
      case 1:  break;
      case 2:
      case 3:
      case 4:
      case 5:
      case 6:
               r = r - (PERIOD_D1 * 60) * (TimeDayOfWeek(r) - 1);
               break;
      case 0:
               r = r - (PERIOD_D1 * 60) * 6;
               break;
   }
   
return(r);   
}
//+------------------------------------------------------------------+
// условное назначение DOUBLE (!)
double iif(bool Условие, double ПервоеЗначение, double ВтороеЗначение) {
   if (Условие)      return(ПервоеЗначение);
               else  return(ВтороеЗначение);
}
//+------------------------------------------------------------------+

