/*
   G e n e r a t e d  by ex4-to-mq4 decompiler FREEWARE 4.0.509.5
   Website:  hTTp:/ /ww W. M e t A q U oTEs.nE T
   E-mail : S UpPO RT @ ME T A Q uo T Es . n Et
*/
#property copyright "this is public domain software"
#property link      "www.forex-tsd.com"

#property indicator_separate_window
#property indicator_minimum 0.0
#property indicator_maximum 100.0
#property indicator_levelcolor White
#property indicator_buffers 2
#property indicator_color1 Blue
#property indicator_color2 Red
#property indicator_width1 2
#property indicator_level1 20.0
#property indicator_width2 1
#property indicator_level2 50.0
#property indicator_level3 80.0

extern int Kperiod = 8;
extern int Dperiod = 3;
extern int Slowing = 3;
extern int MAMethod = 0;
extern int PriceField = 0;
extern string __ = "Chose timeframes";
extern string timeFrames = "M15;M30;H1";
extern int barsPerTimeFrame = 16;
extern bool shiftRight = FALSE;
extern bool currentFirst = FALSE;
extern color txtColor = White;
extern color separatorColor = DimGray;
double G_ibuf_132[];
double G_ibuf_136[];
string Gs_140;
string Gsa_148[];
int Gia_152[];
int Gi_156;

int init() {
   int Li_8;
   string Ls_12;
   string Ls_20;
   int Li_28;
   if (shiftRight) Gi_156 = 1;
   else Gi_156 = 0;
   barsPerTimeFrame = MathMax(barsPerTimeFrame, 15);
   Gs_140 = "All Stochastic" + " (" + Kperiod + "," + Dperiod + "," + Slowing + ")";
   IndicatorShortName(Gs_140);
   SetIndexBuffer(0, G_ibuf_132);
   SetIndexBuffer(1, G_ibuf_136);
   SetIndexShift(0, Gi_156 * (barsPerTimeFrame + 1));
   SetIndexShift(1, Gi_156 * (barsPerTimeFrame + 1));
   SetIndexLabel(0, "Stochastic");
   SetIndexLabel(1, "Signal");
   timeFrames = StringTrimLeft(StringTrimRight(timeFrames));
   if (StringSubstr(timeFrames, StringLen(timeFrames), 1) != ";") timeFrames = StringConcatenate(timeFrames, ";");
   int Li_0 = 0;
   for (int Li_4 = StringFind(timeFrames, ";", Li_0); Li_4 > 0; Li_4 = StringFind(timeFrames, ";", Li_0)) {
      Ls_12 = StringSubstr(timeFrames, Li_0, Li_4 - Li_0);
      Li_8 = stringToTimeFrame(Ls_12);
      if (Li_8 > 0) {
         ArrayResize(Gsa_148, ArraySize(Gsa_148) + 1);
         ArrayResize(Gia_152, ArraySize(Gia_152) + 1);
         Gsa_148[ArraySize(Gsa_148) - 1] = TimeFrameToString(Li_8);
         Gia_152[ArraySize(Gia_152) - 1] = Li_8;
      }
      Li_0 = Li_4 + 1;
   }
   if (currentFirst) {
      for (Li_4 = 1; Li_4 < ArraySize(Gia_152); Li_4++) {
         if (Period() == Gia_152[Li_4]) {
            Ls_20 = Gsa_148[Li_4];
            Li_28 = Gia_152[Li_4];
            for (int Li_32 = Li_4; Li_32 > 0; Li_32--) {
               Gsa_148[Li_32] = Gsa_148[Li_32 - 1];
               Gia_152[Li_32] = Gia_152[Li_32 - 1];
            }
            Gsa_148[0] = Ls_20;
            Gia_152[0] = Li_28;
         }
      }
   }
   return (0);
}

int deinit() {
   for (int count_0 = 0; count_0 < ArraySize(Gia_152); count_0++) {
      ObjectDelete("All Stochastic" + count_0);
      ObjectDelete("All Stochastic" + count_0 + "label");
   }
   return (0);
}

int start() {
   string name_0;
   int shift_20;
   int window_8 = WindowFind(Gs_140);
   int index_12 = 0;
   for (int index_16 = 0; index_16 < ArraySize(Gia_152); index_16++) {
      shift_20 = 0;
      while (shift_20 < barsPerTimeFrame) {
         G_ibuf_132[index_12] = iStochastic(NULL, Gia_152[index_16], Kperiod, Dperiod, Slowing, MAMethod, PriceField, MODE_MAIN, shift_20);
         G_ibuf_136[index_12] = iStochastic(NULL, Gia_152[index_16], Kperiod, Dperiod, Slowing, MAMethod, PriceField, MODE_SIGNAL, shift_20);
         shift_20++;
         index_12++;
      }
      G_ibuf_132[index_12] = EMPTY_VALUE;
      G_ibuf_136[index_12] = EMPTY_VALUE;
      index_12++;
      name_0 = "All Stochastic" + index_16;
      if (ObjectFind(name_0) == -1) ObjectCreate(name_0, OBJ_TREND, window_8, 0, 0);
      ObjectSet(name_0, OBJPROP_TIME1, barTime(index_12 - Gi_156 * (barsPerTimeFrame + 1) - 1));
      ObjectSet(name_0, OBJPROP_TIME2, barTime(index_12 - Gi_156 * (barsPerTimeFrame + 1) - 1));
      ObjectSet(name_0, OBJPROP_PRICE1, 0);
      ObjectSet(name_0, OBJPROP_PRICE2, 100);
      ObjectSet(name_0, OBJPROP_COLOR, separatorColor);
      ObjectSet(name_0, OBJPROP_WIDTH, 2);
      name_0 = "All Stochastic" + index_16 + "label";
      if (ObjectFind(name_0) == -1) ObjectCreate(name_0, OBJ_TEXT, window_8, 0, 0);
      ObjectSet(name_0, OBJPROP_TIME1, barTime(index_12 - Gi_156 * (barsPerTimeFrame + 1) - 5));
      ObjectSet(name_0, OBJPROP_PRICE1, 100);
      ObjectSetText(name_0, Gsa_148[index_16], 9, "Arial", txtColor);
   }
   SetIndexDrawBegin(0, Bars - index_12);
   SetIndexDrawBegin(1, Bars - index_12);
   return (0);
}

int barTime(int Ai_0) {
   if (Ai_0 < 0) return (Time[0] + 60 * Period() * MathAbs(Ai_0));
   return (Time[Ai_0]);
}

int stringToTimeFrame(string As_0) {
   int Li_ret_8 = 0;
   As_0 = StringUpperCase(As_0);
   if (As_0 == "M1" || As_0 == "1") Li_ret_8 = 1;
   if (As_0 == "M5" || As_0 == "5") Li_ret_8 = 5;
   if (As_0 == "M15" || As_0 == "15") Li_ret_8 = 15;
   if (As_0 == "M30" || As_0 == "30") Li_ret_8 = 30;
   if (As_0 == "H1" || As_0 == "60") Li_ret_8 = 60;
   if (As_0 == "H4" || As_0 == "240") Li_ret_8 = 240;
   if (As_0 == "D1" || As_0 == "1440") Li_ret_8 = 1440;
   if (As_0 == "W1" || As_0 == "10080") Li_ret_8 = 10080;
   if (As_0 == "MN" || As_0 == "43200") Li_ret_8 = 43200;
   return (Li_ret_8);
}

string TimeFrameToString(int Ai_0) {
   string Ls_ret_4 = "Current time frame";
   switch (Ai_0) {
   case 1:
      Ls_ret_4 = "M1";
      break;
   case 5:
      Ls_ret_4 = "M5";
      break;
   case 15:
      Ls_ret_4 = "M15";
      break;
   case 30:
      Ls_ret_4 = "M30";
      break;
   case 60:
      Ls_ret_4 = "H1";
      break;
   case 240:
      Ls_ret_4 = "H4";
      break;
   case 1440:
      Ls_ret_4 = "D1";
      break;
   case 10080:
      Ls_ret_4 = "W1";
      break;
   case 43200:
      Ls_ret_4 = "MN1";
   }
   return (Ls_ret_4);
}

string StringUpperCase(string As_0) {
   int Li_20;
   string Ls_ret_8 = As_0;
   for (int Li_16 = StringLen(As_0) - 1; Li_16 >= 0; Li_16--) {
      Li_20 = StringGetChar(Ls_ret_8, Li_16);
      if ((Li_20 > '`' && Li_20 < '{') || (Li_20 > 'ß' && Li_20 < 256)) Ls_ret_8 = StringSetChar(Ls_ret_8, Li_16, Li_20 - 32);
      else
         if (Li_20 > -33 && Li_20 < 0) Ls_ret_8 = StringSetChar(Ls_ret_8, Li_16, Li_20 + 224);
   }
   return (Ls_ret_8);
}
