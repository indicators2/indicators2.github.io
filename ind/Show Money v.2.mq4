//+------------------------------------------------------------------+
//|                                                   Show Money.mq4 |
//|                                          Copyright 2014, ForexDE |
//+------------------------------------------------------------------+
#property copyright "Copyright 2014, ForexDE"
#property link      ""
#property version   "1.00"
#property strict
#property indicator_chart_window

//+------------------------------------------------------------------+
//| Parameters                                                       |
//+------------------------------------------------------------------+
enum ENUM_SHOW_TYPE 
{
   a = 0,   // ����� �� �����
   b = 1,   // ��� ����������
   c = 2,   // � ��������� ���� ������
};
extern ENUM_SHOW_TYPE show_type = 0;         // ��� �����������
extern int     corner      =  3;             // ���� �������� ������
extern bool    show_profit =  false;         // ���������� ������?
extern bool    show_perc   =  false;         // ���������� ������ � %?
extern bool    show_spread =  true;          // ���������� �����?
extern bool    show_time   =  true;          // ���������� ����� �� �������� ����?
extern color   colortext   =  clrBlack;      // ���� ������
extern color   ecProfit    =  clrBlue;       // ���� �������
extern color   ecLoss      =  clrRed;        // ���� ������
enum ENUM_SEPARATOR 
{
   d = 124,    // |
   e =  47,    // /
   f =  46,    // .
   g =  92,    // \
   h =  35,    // #
};
extern ENUM_SEPARATOR separator = 124;       // �����������
extern int     coord_y     =  12;            // ���������� Y
extern int     otstup      =  5;             // ������ � �����
extern int     text_size   =  8;             // ������ ������
extern string  text_font   =  "Calibry";     // �����

string         name_1      =  "show_money_text_1";
string         text_1      =  "";
double         n           =  1.0;

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
{
   if (Digits == 3 || Digits == 5) n *= 10;
   
   //separator = 124;
   //show_type = 0;
   
   return(INIT_SUCCEEDED);
}
//+------------------------------------------------------------------+
//| Custom indicator deinitialization function                       |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
{
   Comment("");
   ObjectDelete(name_1);
}
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
{  

   if (AccountBalance() == 0.0) return(0);
   double tu = GetProfitOpenPosInPoint();
   double tp = GetProfitOpenPos();
   double tr = tp * 100.0 / AccountBalance();
   double sp = MarketInfo(Symbol(), MODE_SPREAD);
   
   //Time to bar expiry
   int m = int(Time[0] + Period()*60 - TimeCurrent());
   int s = m%60;
   m = (m - s)/60;
   string _sp, _m="", _s="";
   string sep = " " + CharToString(char(separator)) + " ";
   if (m < 10)          _m  = "0";
   if (s < 10)          _s  = "0";
   if (sp < 10)         _sp = "..";
   else if (sp < 100)   _sp = ".";
   //if (n == 10) tu /= n;
   
   text_1 = DoubleToStr(tu,1) + " ��";
   
   if (show_profit) text_1 += sep + DoubleToStr(tp,2) + " " + AccountCurrency();
   if (show_perc)   text_1 += sep + DoubleToStr(tr,1) + "%";
   if (show_spread) text_1 += sep + DoubleToStr(sp,0) + _sp;
   if (show_time)   text_1 += sep + _m + DoubleToStr(m,0) + ":" + _s + DoubleToStr(s,0); // Next bar in 
   
   if (show_type == 0) {
      SetText(name_1, text_1, ColorOnSign(tp), TimeCurrent(), SymbolInfoDouble(Symbol(),SYMBOL_BID), text_size);
   }
   if (show_type == 1) 
      Comment(text_1);
   if (show_type == 2)
      SetLabel(name_1, text_1, ColorOnSign(tp), 3, coord_y, corner, text_size);
   
   return(rates_total);
}
//+------------------------------------------------------------------+
double GetProfitOpenPos(int mn = -1)
{
   int i, k = OrdersTotal();
   double pr = 0.0;

   for (i = 0; i < k; i++) {
      if (OrderSelect(i, SELECT_BY_POS, MODE_TRADES)) {
         if (OrderSymbol() == Symbol()) {
            if (mn < 0 || OrderMagicNumber() == mn) {
               pr += OrderProfit() + OrderCommission() + OrderSwap();
            }
         }
      }
   }
   return (pr);
}
//+----------------------------------------------------------------------------+
//|  �����    : ��� ����� �. aka KimIV,  http://www.kimiv.ru                   |
//+----------------------------------------------------------------------------+
//|  ������   : 01.08.2008                                                     |
//|  �������� : ���������� ��������� ������ �������� ������� � �������         |
//+----------------------------------------------------------------------------+
//|  ���������:                                                                |
//|    sy - ������������ �����������   (""   - ����� ������,                   |
//|                                     NULL - ������� ������)                 |
//|    op - ��������                   (-1   - ����� �������)                  |
//|    mn - MagicNumber                (-1   - ����� �����)                    |
//+----------------------------------------------------------------------------+
double GetProfitOpenPosInPoint(int op=-1, int mn=-1) 
{
   double pr = 0.0;
   //Comment(MarketInfo(Symbol(),MODE_TICKVALUE) / MarketInfo(Symbol(),MODE_TICKSIZE) / MarketInfo(Symbol(),MODE_POINT));
   
   for (int i = 0; i < OrdersTotal(); i++) {
      if (OrderSelect(i, SELECT_BY_POS, MODE_TRADES)) {
         if ((OrderSymbol() == Symbol()) && (op < 0 || OrderType() == op)) {
            if (mn < 0 || OrderMagicNumber() == mn) {
               if (OrderType() == OP_BUY) {
                  pr += (OrderProfit() / OrderLots() / MarketInfo( OrderSymbol(), MODE_TICKVALUE )) / n;
               }
               if (OrderType() == OP_SELL) {
                  pr += (OrderProfit() / OrderLots() / MarketInfo( OrderSymbol(), MODE_TICKVALUE )) / n;
               }
            }
         }
      }
   }
   return (pr);
}
//+------------------------------------------------------------------+
//|  ���������:                                                      |
//|    nm - ������������ �������                                     |
//|    tx - �����                                                    |
//|    cl - ���� �����                                               |
//|    xd - ���������� X � ��������                                  |
//|    yd - ���������� Y � ��������                                  |
//|    cr - ����� ���� ��������        (0 - ����� �������)           |
//|    fs - ������ ������              (8 - �� ���������)            |
//+------------------------------------------------------------------+
bool SetText(string nm, string tx, color cl, datetime time, double price, int fs) 
{
   time += otstup*Period()*60;
   //--- ������� �������� ������
   ResetLastError();
   //--- �������� ������ "�����"
   if (ObjectFind(nm) < 0) {
      ObjectCreate(0, nm, OBJ_TEXT, 0, time, price);
   } 
   
   ObjectMove(0, nm, 0, time, price);
     
   //--- ��������� �����
   ObjectSetString(0, nm, OBJPROP_TEXT, tx);
      
   //--- ��������� �����
   ObjectSetString(0, nm, OBJPROP_FONT, text_font);
   
   //--- ��������� ������ ������
   ObjectSetInteger(0, nm, OBJPROP_FONTSIZE, fs);
   
   //--- ��������� ���� ������� ������
   ObjectSetDouble(0, nm, OBJPROP_ANGLE, 0.0);
   
   //--- ��������� ������ ��������
   ObjectSetInteger(0, nm, OBJPROP_ANCHOR, ANCHOR_LEFT_LOWER);
   
   //--- ��������� ���� 
   ObjectSetInteger(0, nm, OBJPROP_COLOR, cl);
   
   //--- ��������� �� �������� (false) ��� ������ (true) �����
   ObjectSetInteger(0, nm, OBJPROP_BACK, false);
   
   //--- ������� (true) ��� �������� (false) ����� ����������� ������� �����
   ObjectSetInteger(0, nm, OBJPROP_SELECTABLE, false);
   ObjectSetInteger(0 ,nm, OBJPROP_SELECTED,   false);
   
   return (true);
}
//+------------------------------------------------------------------+
//|  ���������:                                                      |
//|    nm - ������������ �������                                     |
//|    tx - �����                                                    |
//|    cl - ���� �����                                               |
//|    xd - ���������� X � ��������                                  |
//|    yd - ���������� Y � ��������                                  |
//|    cr - ����� ���� ��������        (0 - ����� �������)           |
//|    fs - ������ ������              (8 - �� ���������)            |
//+------------------------------------------------------------------+
void SetLabel(string nm, string tx, color cl, int xd, int yd, int cr, int fs) 
{
   if (ObjectFind(nm) < 0) 
      ObjectCreate(nm, OBJ_LABEL, 0, 0,0);
   
   ObjectSetText(nm, tx, fs);
   ObjectSet(nm, OBJPROP_COLOR    , cl);
   ObjectSet(nm, OBJPROP_XDISTANCE, xd);
   ObjectSet(nm, OBJPROP_YDISTANCE, yd);
   ObjectSet(nm, OBJPROP_CORNER   , cr);
   ObjectSet(nm, OBJPROP_FONTSIZE , fs);
}
//+------------------------------------------------------------------+
//+----------------------------------------------------------------------------+
//|  ���������� ���� �� ����� �����                                            |
//+----------------------------------------------------------------------------+
color ColorOnSign(double nu) 
{
   color lcColor = colortext;

   if (nu > 0) lcColor = ecProfit;
   if (nu < 0) lcColor = ecLoss;

   return(lcColor);
}