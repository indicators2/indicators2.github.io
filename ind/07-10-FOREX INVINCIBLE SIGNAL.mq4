
#property copyright "Copyright © 2010"
#property link      ""

#property indicator_chart_window

extern bool alert = TRUE;
int gi_80 = 7;
double gd_84 = 1.7;
int gi_92 = 0;
int gi_96 = 2000;
int g_count_100;
int gi_104;
int gi_108;
int gi_112;
int gi_116;
double g_ibuf_120[];
double g_ibuf_124[];
bool gi_128 = FALSE;
bool gi_132 = FALSE;
bool gi_unused_136 = FALSE;
bool gi_unused_140 = FALSE;
extern int SRPeriod = 5;
double g_point_148;
string gs_156 = "";

int init() {
   SetIndexStyle(0, DRAW_LINE, STYLE_SOLID, 2);
   SetIndexStyle(1, DRAW_LINE, STYLE_SOLID, 2);
   SetIndexBuffer(0, g_ibuf_120);
   SetIndexBuffer(1, g_ibuf_124);
   IndicatorDigits(MarketInfo(Symbol(), MODE_DIGITS));
   SetIndexLabel(0, "StepMA Stoch 1");
   SetIndexLabel(1, "StepMA Stoch 2");
   SetIndexDrawBegin(0, gi_80);
   SetIndexDrawBegin(1, gi_80);
   ArrayInitialize(g_ibuf_120, 0);
   ArrayInitialize(g_ibuf_124, 0);
   SetIndexEmptyValue(0, 0);
   SetIndexEmptyValue(1, 0);
      return (0);
}

int deinit() {
   ObjectsDeleteAll();
   for (g_count_100 = 0; g_count_100 < Bars; g_count_100++) {
      ObjectDelete("BS" + g_count_100);
      ObjectDelete("BT" + g_count_100 + "txt");
      ObjectDelete("SS" + g_count_100);
      ObjectDelete("ST" + g_count_100 + "txt");
   }
   return (0);
}

int start() {
   double l_iclose_0 = iClose(NULL, PERIOD_D1, iHighest(NULL, PERIOD_D1, MODE_CLOSE, SRPeriod, 1));
   double l_iclose_8 = iClose(NULL, PERIOD_H4, iHighest(NULL, PERIOD_H4, MODE_CLOSE, SRPeriod, 1));
   double l_iclose_16 = iClose(NULL, PERIOD_H1, iHighest(NULL, PERIOD_H1, MODE_CLOSE, SRPeriod, 1));
   double l_iclose_24 = iClose(NULL, PERIOD_M30, iHighest(NULL, PERIOD_M30, MODE_CLOSE, SRPeriod, 1));
   double l_iclose_32 = iClose(NULL, PERIOD_M15, iHighest(NULL, PERIOD_M15, MODE_CLOSE, SRPeriod, 1));
   drawLine("HH_D1r %", Time[50], Time[40], l_iclose_0, l_iclose_0, 2, 2, Blue, 0);
   double l_iclose_40 = iClose(NULL, PERIOD_D1, iLowest(NULL, PERIOD_D1, MODE_CLOSE, SRPeriod, 1));
   double l_iclose_48 = iClose(NULL, PERIOD_H4, iLowest(NULL, PERIOD_H4, MODE_CLOSE, SRPeriod, 1));
   double l_iclose_56 = iClose(NULL, PERIOD_H1, iLowest(NULL, PERIOD_H1, MODE_CLOSE, SRPeriod, 1));
   double l_iclose_64 = iClose(NULL, PERIOD_M30, iLowest(NULL, PERIOD_M30, MODE_CLOSE, SRPeriod, 1));
   double l_iclose_72 = iClose(NULL, PERIOD_M15, iLowest(NULL, PERIOD_M15, MODE_CLOSE, SRPeriod, 1));
   drawLine("LL_D1r", Time[50], Time[40], l_iclose_40, l_iclose_40, 2, 2, Red, 0);
   drawLabel();
   return (0);
}

void drawLine(string a_name_0, int a_datetime_8, int a_datetime_12, double a_price_16, double a_price_24, int a_width_32, int a_bool_36, color a_color_40, int ai_44) {
   if (ObjectFind(a_name_0) != 0) {
      ObjectCreate(a_name_0, OBJ_TREND, 0, a_datetime_8, a_price_16, a_datetime_12, a_price_24);
      if (ai_44 == 1) ObjectSet(a_name_0, OBJPROP_STYLE, STYLE_SOLID);
      else {
         if (ai_44 == 2) ObjectSet(a_name_0, OBJPROP_STYLE, STYLE_DASHDOT);
         else ObjectSet(a_name_0, OBJPROP_STYLE, STYLE_DOT);
      }
      ObjectSet(a_name_0, OBJPROP_COLOR, a_color_40);
      ObjectSet(a_name_0, OBJPROP_WIDTH, a_width_32);
      ObjectSet(a_name_0, OBJPROP_RAY, a_bool_36);
      return;
   }
   ObjectDelete(a_name_0);
   ObjectCreate(a_name_0, OBJ_TREND, 0, a_datetime_8, a_price_16, a_datetime_12, a_price_24);
   if (ai_44 == 1) ObjectSet(a_name_0, OBJPROP_STYLE, STYLE_SOLID);
   else {
      if (ai_44 == 2) ObjectSet(a_name_0, OBJPROP_STYLE, STYLE_DASHDOT);
      else ObjectSet(a_name_0, OBJPROP_STYLE, STYLE_DOT);
   }
   ObjectSet(a_name_0, OBJPROP_COLOR, a_color_40);
   ObjectSet(a_name_0, OBJPROP_WIDTH, a_width_32);
   ObjectSet(a_name_0, OBJPROP_RAY, a_bool_36);
}

void drawLabel() {
   int li_8;
   int li_12;
   int li_16;
   double ld_20;
   double ld_28;
   double ld_36;
   double ld_44;
   double ld_52;
   double ld_60;
   double ld_68;
   double ld_76;
   double ld_84;
   double ld_92;
   double ld_100;
   double ld_108;
   double ld_116;
   double ld_124;
   double ld_132;
   double ld_140;
   double ld_148;
   double ld_156;
   double ld_164;
   double ld_172;
   double ld_180;
   double ld_188;
   double ld_196;
   double ld_204;
   int li_212;
   int li_216;
   int li_220;
   string ls_0 = " " + " ";
   if (Point == 0.00001) g_point_148 = 0.0001;
   else {
      if (Point == 0.001) g_point_148 = 0.01;
      else g_point_148 = Point;
   }
   Comment("" 
      + "\n" 
      + "FOREX INVINCIBLE" 
      + "\n" 
      + "------------------------------------------------" 
      + "\n" 
      + "BROKER DATA:" 
      + "\n" 
      + "Company:      " + AccountCompany() 
      + "\n" 
      + "------------------------------------------------" 
      + "\n" 
      + "ACCOUNT DATA:" 
      + "\n" 
      + "Name:          " + AccountName() 
      + "\n" 
      + "Number:       " + AccountNumber() 
      + "\n" 
      + "Leverage:     " + DoubleToStr(AccountLeverage(), 0) 
      + "\n" 
      + "Balance:       " + DoubleToStr(AccountBalance(), 2) 
      + "\n" 
      + "Currency:     " + AccountCurrency() 
      + "\n" 
      + "Equity:         " + DoubleToStr(AccountEquity(), 2) 
      + "\n" 
      + "------------------------------------------------" 
      + "\n" 
      + "MARGIN DATA:" 
      + "\n" 
      + "Free Margin:              " + DoubleToStr(AccountFreeMargin(), 2) 
      + "\n" 
      + "Used Margin:              " + DoubleToStr(AccountMargin(), 2) 
      + "\n" 
      + "------------------------------------------------" 
   + "\n");
   string ls_224 = "Max bars to count: |" + ((Bars - 1)) + "| ";
   IndicatorShortName(ls_224);
   double ld_232 = 0;
   double ld_unused_240 = 0;
   ObjectsDeleteAll(0, OBJ_ARROW);
   ObjectsDeleteAll(0, OBJ_TEXT);
   for (int li_248 = gi_96 - 1; li_248 >= 0; li_248--) {
      ld_52 = 0;
      for (int li_252 = gi_80 - 1; li_252 >= 0; li_252--) {
         ld_60 = 1.0 * (gi_80 - li_252) / gi_80 + 1.0;
         ld_52 += ld_60 * MathAbs(High[li_252 + li_248] - (Low[li_252 + li_248]));
      }
      ld_68 = ld_52 / gi_80;
      ld_76 = MathMax(ld_68, ld_76);
      if (li_248 == gi_96 - 1 - gi_80) ld_84 = ld_68;
      ld_84 = MathMin(ld_68, ld_84);
      li_212 = MathRound(gd_84 * ld_84 / g_point_148);
      li_216 = MathRound(gd_84 * ld_76 / g_point_148);
      li_220 = MathRound(gd_84 / 2.0 * (ld_76 + ld_84) / g_point_148);
      if (gi_92 > 0) {
         ld_28 = Low[li_248] + li_212 * 2 * g_point_148;
         ld_20 = High[li_248] - li_212 * 2 * g_point_148;
         ld_100 = Low[li_248] + li_216 * 2 * g_point_148;
         ld_92 = High[li_248] - li_216 * 2 * g_point_148;
         ld_132 = Low[li_248] + li_220 * 2 * g_point_148;
         ld_124 = High[li_248] - li_220 * 2 * g_point_148;
         if (Close[li_248] > ld_44) li_8 = 1;
         if (Close[li_248] < ld_36) li_8 = -1;
         if (Close[li_248] > ld_116) li_12 = 1;
         if (Close[li_248] < ld_108) li_12 = -1;
         if (Close[li_248] > ld_148) li_16 = 1;
         if (Close[li_248] < ld_140) li_16 = -1;
      }
      if (gi_92 == 0) {
         ld_28 = Close[li_248] + li_212 * 2 * g_point_148;
         ld_20 = Close[li_248] - li_212 * 2 * g_point_148;
         ld_100 = Close[li_248] + li_216 * 2 * g_point_148;
         ld_92 = Close[li_248] - li_216 * 2 * g_point_148;
         ld_132 = Close[li_248] + li_220 * 2 * g_point_148;
         ld_124 = Close[li_248] - li_220 * 2 * g_point_148;
         if (Close[li_248] > ld_44) li_8 = 1;
         if (Close[li_248] < ld_36) li_8 = -1;
         if (Close[li_248] > ld_116) li_12 = 1;
         if (Close[li_248] < ld_108) li_12 = -1;
         if (Close[li_248] > ld_148) li_16 = 1;
         if (Close[li_248] < ld_140) li_16 = -1;
      }
      if (li_8 > 0 && ld_20 < ld_36) ld_20 = ld_36;
      if (li_8 < 0 && ld_28 > ld_44) ld_28 = ld_44;
      if (li_12 > 0 && ld_92 < ld_108) ld_92 = ld_108;
      if (li_12 < 0 && ld_100 > ld_116) ld_100 = ld_116;
      if (li_16 > 0 && ld_124 < ld_140) ld_124 = ld_140;
      if (li_16 < 0 && ld_132 > ld_148) ld_132 = ld_148;
      if (li_8 > 0) ld_156 = ld_20 + li_212 * g_point_148;
      if (li_8 < 0) ld_156 = ld_28 - li_212 * g_point_148;
      if (li_12 > 0) ld_164 = ld_92 + li_216 * g_point_148;
      if (li_12 < 0) ld_164 = ld_100 - li_216 * g_point_148;
      if (li_16 > 0) ld_172 = ld_124 + li_220 * g_point_148;
      if (li_16 < 0) ld_172 = ld_132 - li_220 * g_point_148;
      if (Period() == PERIOD_M1) {
         gi_104 = 2;
         gi_108 = 4;
         gi_112 = 2;
         gi_116 = 4;
      }
      if (Period() == PERIOD_M5) {
         gi_104 = 3;
         gi_108 = 6;
         gi_112 = 3;
         gi_116 = 7;
      }
      if (Period() == PERIOD_M15) {
         gi_104 = 3;
         gi_108 = 6;
         gi_112 = 4;
         gi_116 = 9;
      }
      if (Period() == PERIOD_M30) {
         gi_104 = 3;
         gi_108 = 8;
         gi_112 = 5;
         gi_116 = 12;
      }
      if (Period() == PERIOD_H1) {
         gi_104 = 3;
         gi_108 = 10;
         gi_112 = 7;
         gi_116 = 15;
      }
      if (Period() == PERIOD_H4) {
         gi_104 = 3;
         gi_108 = 15;
         gi_112 = 10;
         gi_116 = 28;
      }
      if (Period() == PERIOD_D1) {
         gi_104 = 4;
         gi_108 = 30;
         gi_112 = 30;
         gi_116 = 70;
      }
      if (Period() == PERIOD_W1) {
         gi_104 = 5;
         gi_108 = 40;
         gi_112 = 40;
         gi_116 = 80;
      }
      if (Period() == PERIOD_MN1) {
         gi_104 = 6;
         gi_108 = 50;
         gi_112 = 50;
         gi_116 = 90;
      }
      ld_196 = ld_164 - li_216 * g_point_148;
      ld_204 = ld_164 + li_216 * g_point_148;
      ld_180 = NormalizeDouble((ld_156 - ld_196) / (ld_204 - ld_196), 6);
      ld_188 = NormalizeDouble((ld_172 - ld_196) / (ld_204 - ld_196), 6);
      ld_232 = ld_180 - ld_188;
      if (ld_232 < 0.0) {
         g_ibuf_120[li_248] = ld_232;
         g_ibuf_124[li_248] = 0;
         if (ld_232 < 0.0 && gs_156 == "Buy" || gs_156 == "") {
            drawArrow1("SS" + li_248, Red, 234, "", Time[li_248], High[li_248] + gi_112 * g_point_148);
            drawArrow2("ST" + li_248, White, 0, "Sell", Time[li_248], High[li_248] + gi_116 * g_point_148);
            gs_156 = "Sell";
         }
      } else {
         if (ld_232 > 0.0) {
            g_ibuf_124[li_248] = ld_232;
            g_ibuf_120[li_248] = 0;
            if (ld_232 > 0.0 && gs_156 == "Sell" || gs_156 == "") {
               drawArrow1("BS" + li_248, Blue, 233, "", Time[li_248], Low[li_248] - gi_104 * g_point_148);
               drawArrow2("BT" + li_248, White, 0, "Buy", Time[li_248], Low[li_248] - gi_108 * g_point_148);
               gs_156 = "Buy";
            }
         }
      }
      ld_36 = ld_20;
      ld_44 = ld_28;
      ld_108 = ld_92;
      ld_116 = ld_100;
      ld_140 = ld_124;
      ld_148 = ld_132;
   }
   if (alert == TRUE && gi_132 == FALSE && gs_156 == "Buy") {
      Alert("FOREX INVINCIBLE SIGNAL ", 
         "\n" 
      + Symbol() + " " + Period() + " Minute " + gs_156 + " at " + DoubleToStr(Bid, 4) + " Date " + TimeToStr(TimeCurrent(), TIME_DATE) + " Time " + TimeToStr(TimeCurrent(), TIME_MINUTES));
      gi_132 = TRUE;
      gi_128 = FALSE;
   }
   if (alert == TRUE && gi_128 == FALSE && gs_156 == "Sell") {
      Alert("FOREX INVINCIBLE SIGNAL ", 
         "\n" 
      + Symbol() + " " + Period() + " Minute " + gs_156 + " at " + DoubleToStr(Ask, 4) + " Date " + TimeToStr(TimeCurrent(), TIME_DATE) + " Time " + TimeToStr(TimeCurrent(), TIME_MINUTES));
      gi_132 = FALSE;
      gi_128 = TRUE;
   }
}

void drawArrow1(string a_name_0, color a_color_8, int ai_12, string as_unused_16, int a_datetime_24, double a_price_28) {
   ObjectCreate(a_name_0, OBJ_ARROW, 0, a_datetime_24, a_price_28);
   ObjectSet(a_name_0, OBJPROP_ARROWCODE, ai_12);
   ObjectSet(a_name_0, OBJPROP_COLOR, a_color_8);
   ObjectSet(a_name_0, OBJPROP_WIDTH, 3);
}

void drawArrow2(string as_0, color a_color_8, int ai_unused_12, string a_text_16, int a_datetime_24, double a_price_28) {
   ObjectCreate(as_0 + "txt", OBJ_TEXT, 0, a_datetime_24, a_price_28);
   ObjectSetText(as_0 + "txt", a_text_16, 12, "Tahoma", a_color_8);
}