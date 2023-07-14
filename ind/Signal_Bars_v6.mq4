/*
   G e n e r a t e d  by ex4-to-mq4 decompiler FREEWARE 4.0.509.5
   Website:  h TTp:/ / Ww W . Me taQUotes.net
   E-mail : s up PO R t @ me TaQ u OtES.n eT
*/
#property copyright "Copyright © 2006, MetaQuotes Software Corp."
#property link      "http://www.metaquotes.net"

#property indicator_chart_window

extern string IIIIIIIIIIIIIIIIIII = "<<<< Indicator Settings >>>>>>>>>>";
extern bool Show_intradayRange = TRUE;
extern string IIIIIIIIIIIIIIIIIIII = "<<<< Chart Posistion Settings >>>>>";
extern bool Corner_of_Chart_RIGHT_TOP = TRUE;
extern string IIIIIIIIIIIIIIIIIIIII = " <<<< Comments Settings >>>>>>>>";
extern bool Show_Price = TRUE;
extern bool Show_Xtra_Details = TRUE;
extern bool Show_Smaller_Size = FALSE;
extern int Shift_UP_DN = 0;
extern int Adjust_Side_to_side = 20;
extern color BarLabel_color = LightSteelBlue;
extern color CommentLabel_color = LightSteelBlue;
extern color Spread_color = Gold;
extern color HI_LO_color = Gold;
extern color Pips_UP = Lime;
extern color Pips_DN = OrangeRed;
extern color Daily_AV_UP = Lime;
extern color Daily_AV_DN = OrangeRed;
extern string IIIIIIIIIIIIIIIIIIIIII = "<<<< MACD Settings >>>>>>>>>>>";
extern int MACD_Fast = 8;
extern int MACD_Slow = 17;
extern int MACD_Signal = 9;
extern int MACD_PRICE_TYPE = 0;
extern string IIIIIIIIIIIIIIIIIIIIIII = "<<<< MACD Colors >>>>>>>>>>>>>>>>>>";
extern color XUP_above_0 = Lime;
extern color XDN_above_0 = Tomato;
extern color XUP_below_0 = Green;
extern color XDN_below_0 = Red;
extern string IIIIIIIIIIIIIIIIIIIIIIII = "<<<< RSI Settings >>>>>>>>>>>>>";
extern int RSI_Period = 9;
extern int RSI_PRICE_TYPE = 0;
extern string IIIIIIIIIIIIIIIIIIIIIIIII = "<<<< CCI Settings >>>>>>>>>>>>>>";
extern int CCI_Period = 13;
extern int CCI_PRICE_TYPE = 0;
extern string IIIIIIIIIIIIIIIIIIIIIIIIII = "<<<< STOCH Settings >>>>>>>>>>>";
extern int STOCH_K_Period = 5;
extern int STOCH_D_Period = 3;
extern int STOCH_Slowing = 3;
extern int STOCH_MA_MODE = 1;
extern string IIIIIIIIIIIIIIIIIIIIIIIIIII = "<<<< STR Colors >>>>>>>>>>>>>>>>";
extern color STR_UP = Lime;
extern color STR_DN = Red;
extern color STR_NO_Signal = Orange;
extern string IIIIIIIIIIIIIIIIIIIIIIIIIIII = "<<<< MA Settings >>>>>>>>>>>>>>";
extern int MA_Fast = 5;
extern int MA_Slow = 9;
extern int MA_MODE = 1;
extern int MA_PRICE_TYPE = 0;
extern string IIIIIIIIIIIIIIIIIIIIIIIIIIIII = "<<<< MA Colors >>>>>>>>>>>>>>";
extern color MA_UP = Lime;
extern color MA_DN = Red;

int init() {
   return (0);
}

int deinit() {
   ObjectsDeleteAll(0, OBJ_LABEL);
   return (0);
}

int start() {
   color color_76;
   color color_80;
   color color_84;
   color color_88;
   color color_92;
   color color_96;
   color color_100;
   color color_104;
   color color_108;
   color color_548;
   color color_552;
   color color_556;
   color color_560;
   color color_564;
   color color_568;
   color color_572;
   color color_576;
   color color_580;
   color color_808;
   color color_812;
   color color_816;
   color color_820;
   color color_824;
   color color_828;
   color color_832;
   color color_836;
   color color_840;
   color color_956;
   color color_960;
   int ind_counted_0 = IndicatorCounted();
   string text_4 = "";
   string text_12 = "";
   string text_20 = "";
   string text_28 = "";
   string text_36 = "";
   string text_44 = "";
   string text_52 = "";
   string text_60 = "";
   string text_68 = "";
   double imacd_112 = iMACD(NULL, PERIOD_M1, MACD_Fast, MACD_Slow, MACD_Signal, MACD_PRICE_TYPE, MODE_MAIN, 0);
   double imacd_120 = iMACD(NULL, PERIOD_M1, MACD_Fast, MACD_Slow, MACD_Signal, MACD_PRICE_TYPE, MODE_SIGNAL, 0);
   double imacd_128 = iMACD(NULL, PERIOD_M5, MACD_Fast, MACD_Slow, MACD_Signal, MACD_PRICE_TYPE, MODE_MAIN, 0);
   double imacd_136 = iMACD(NULL, PERIOD_M5, MACD_Fast, MACD_Slow, MACD_Signal, MACD_PRICE_TYPE, MODE_SIGNAL, 0);
   double imacd_144 = iMACD(NULL, PERIOD_M15, MACD_Fast, MACD_Slow, MACD_Signal, MACD_PRICE_TYPE, MODE_MAIN, 0);
   double imacd_152 = iMACD(NULL, PERIOD_M15, MACD_Fast, MACD_Slow, MACD_Signal, MACD_PRICE_TYPE, MODE_SIGNAL, 0);
   double imacd_160 = iMACD(NULL, PERIOD_M30, MACD_Fast, MACD_Slow, MACD_Signal, MACD_PRICE_TYPE, MODE_MAIN, 0);
   double imacd_168 = iMACD(NULL, PERIOD_M30, MACD_Fast, MACD_Slow, MACD_Signal, MACD_PRICE_TYPE, MODE_SIGNAL, 0);
   double imacd_176 = iMACD(NULL, PERIOD_H1, MACD_Fast, MACD_Slow, MACD_Signal, MACD_PRICE_TYPE, MODE_MAIN, 0);
   double imacd_184 = iMACD(NULL, PERIOD_H1, MACD_Fast, MACD_Slow, MACD_Signal, MACD_PRICE_TYPE, MODE_SIGNAL, 0);
   double imacd_192 = iMACD(NULL, PERIOD_H4, MACD_Fast, MACD_Slow, MACD_Signal, MACD_PRICE_TYPE, MODE_MAIN, 0);
   double imacd_200 = iMACD(NULL, PERIOD_H4, MACD_Fast, MACD_Slow, MACD_Signal, MACD_PRICE_TYPE, MODE_SIGNAL, 0);
   double imacd_208 = iMACD(NULL, PERIOD_D1, MACD_Fast, MACD_Slow, MACD_Signal, MACD_PRICE_TYPE, MODE_MAIN, 0);
   double imacd_216 = iMACD(NULL, PERIOD_D1, MACD_Fast, MACD_Slow, MACD_Signal, MACD_PRICE_TYPE, MODE_SIGNAL, 0);
   double imacd_224 = iMACD(NULL, PERIOD_W1, MACD_Fast, MACD_Slow, MACD_Signal, MACD_PRICE_TYPE, MODE_MAIN, 0);
   double imacd_232 = iMACD(NULL, PERIOD_W1, MACD_Fast, MACD_Slow, MACD_Signal, MACD_PRICE_TYPE, MODE_SIGNAL, 0);
   double imacd_240 = iMACD(NULL, PERIOD_MN1, MACD_Fast, MACD_Slow, MACD_Signal, MACD_PRICE_TYPE, MODE_MAIN, 0);
   double imacd_248 = iMACD(NULL, PERIOD_MN1, MACD_Fast, MACD_Slow, MACD_Signal, MACD_PRICE_TYPE, MODE_SIGNAL, 0);
   if (Show_intradayRange == TRUE) {
      if (imacd_112 > imacd_120) {
         text_28 = "-";
         color_88 = XUP_below_0;
      }
      if (imacd_112 <= imacd_120) {
         text_28 = "-";
         color_88 = XDN_above_0;
      }
      if (imacd_112 > imacd_120 && imacd_112 > 0.0) {
         text_28 = "-";
         color_88 = XUP_above_0;
      }
      if (imacd_112 <= imacd_120 && imacd_112 < 0.0) {
         text_28 = "-";
         color_88 = XDN_below_0;
      }
      if (imacd_128 > imacd_136) {
         text_36 = "-";
         color_92 = XUP_below_0;
      }
      if (imacd_128 <= imacd_136) {
         text_36 = "-";
         color_92 = XDN_above_0;
      }
      if (imacd_128 > imacd_136 && imacd_128 > 0.0) {
         text_36 = "-";
         color_92 = XUP_above_0;
      }
      if (imacd_128 <= imacd_136 && imacd_128 < 0.0) {
         text_36 = "-";
         color_92 = XDN_below_0;
      }
      if (imacd_144 > imacd_152) {
         text_44 = "-";
         color_96 = XUP_below_0;
      }
      if (imacd_144 <= imacd_152) {
         text_44 = "-";
         color_96 = XDN_above_0;
      }
      if (imacd_144 > imacd_152 && imacd_144 > 0.0) {
         text_44 = "-";
         color_96 = XUP_above_0;
      }
      if (imacd_144 <= imacd_152 && imacd_144 < 0.0) {
         text_44 = "-";
         color_96 = XDN_below_0;
      }
      if (imacd_160 > imacd_168) {
         text_52 = "-";
         color_100 = XUP_below_0;
      }
      if (imacd_160 <= imacd_168) {
         text_52 = "-";
         color_100 = XDN_above_0;
      }
      if (imacd_160 > imacd_168 && imacd_160 > 0.0) {
         text_52 = "-";
         color_100 = XUP_above_0;
      }
      if (imacd_160 <= imacd_168 && imacd_160 < 0.0) {
         text_52 = "-";
         color_100 = XDN_below_0;
      }
      if (imacd_176 > imacd_184) {
         text_12 = "-";
         color_80 = XUP_below_0;
      }
      if (imacd_176 <= imacd_184) {
         text_12 = "-";
         color_80 = XDN_above_0;
      }
      if (imacd_176 > imacd_184 && imacd_176 > 0.0) {
         text_12 = "-";
         color_80 = XUP_above_0;
      }
      if (imacd_176 <= imacd_184 && imacd_176 < 0.0) {
         text_12 = "-";
         color_80 = XDN_below_0;
      }
      if (imacd_192 > imacd_200) {
         text_20 = "-";
         color_84 = XUP_below_0;
      }
      if (imacd_192 <= imacd_200) {
         text_20 = "-";
         color_84 = XDN_above_0;
      }
      if (imacd_192 > imacd_200 && imacd_192 > 0.0) {
         text_20 = "-";
         color_84 = XUP_above_0;
      }
      if (imacd_192 <= imacd_200 && imacd_192 < 0.0) {
         text_20 = "-";
         color_84 = XDN_below_0;
      }
   }
   if (Show_intradayRange == FALSE) {
      if (imacd_112 > imacd_120) {
         text_28 = "-";
         color_88 = XUP_below_0;
      }
      if (imacd_112 <= imacd_120) {
         text_28 = "-";
         color_88 = XDN_above_0;
      }
      if (imacd_112 > imacd_120 && imacd_112 > 0.0) {
         text_28 = "-";
         color_88 = XUP_above_0;
      }
      if (imacd_112 <= imacd_120 && imacd_112 < 0.0) {
         text_28 = "-";
         color_88 = XDN_below_0;
      }
      if (imacd_128 > imacd_136) {
         text_36 = "-";
         color_92 = XUP_below_0;
      }
      if (imacd_128 <= imacd_136) {
         text_36 = "-";
         color_92 = XDN_above_0;
      }
      if (imacd_128 > imacd_136 && imacd_128 > 0.0) {
         text_36 = "-";
         color_92 = XUP_above_0;
      }
      if (imacd_128 <= imacd_136 && imacd_128 < 0.0) {
         text_36 = "-";
         color_92 = XDN_below_0;
      }
      if (imacd_144 > imacd_152) {
         text_44 = "-";
         color_96 = XUP_below_0;
      }
      if (imacd_144 <= imacd_152) {
         text_44 = "-";
         color_96 = XDN_above_0;
      }
      if (imacd_144 > imacd_152 && imacd_144 > 0.0) {
         text_44 = "-";
         color_96 = XUP_above_0;
      }
      if (imacd_144 <= imacd_152 && imacd_144 < 0.0) {
         text_44 = "-";
         color_96 = XDN_below_0;
      }
      if (imacd_160 > imacd_168) {
         text_52 = "-";
         color_100 = XUP_below_0;
      }
      if (imacd_160 <= imacd_168) {
         text_52 = "-";
         color_100 = XDN_above_0;
      }
      if (imacd_160 > imacd_168 && imacd_160 > 0.0) {
         text_52 = "-";
         color_100 = XUP_above_0;
      }
      if (imacd_160 <= imacd_168 && imacd_160 < 0.0) {
         text_52 = "-";
         color_100 = XDN_below_0;
      }
      if (imacd_176 > imacd_184) {
         text_12 = "-";
         color_80 = XUP_below_0;
      }
      if (imacd_176 <= imacd_184) {
         text_12 = "-";
         color_80 = XDN_above_0;
      }
      if (imacd_176 > imacd_184 && imacd_176 > 0.0) {
         text_12 = "-";
         color_80 = XUP_above_0;
      }
      if (imacd_176 <= imacd_184 && imacd_176 < 0.0) {
         text_12 = "-";
         color_80 = XDN_below_0;
      }
      if (imacd_192 > imacd_200) {
         text_20 = "-";
         color_84 = XUP_below_0;
      }
      if (imacd_192 <= imacd_200) {
         text_20 = "-";
         color_84 = XDN_above_0;
      }
      if (imacd_192 > imacd_200 && imacd_192 > 0.0) {
         text_20 = "-";
         color_84 = XUP_above_0;
      }
      if (imacd_192 <= imacd_200 && imacd_192 < 0.0) {
         text_20 = "-";
         color_84 = XDN_below_0;
      }
      if (imacd_208 > imacd_216) {
         text_4 = "-";
         color_76 = XUP_below_0;
      }
      if (imacd_208 <= imacd_216) {
         text_4 = "-";
         color_76 = XDN_above_0;
      }
      if (imacd_208 > imacd_216 && imacd_208 > 0.0) {
         text_4 = "-";
         color_76 = XUP_above_0;
      }
      if (imacd_208 <= imacd_216 && imacd_208 < 0.0) {
         text_4 = "-";
         color_76 = XDN_below_0;
      }
      if (imacd_224 > imacd_232) {
         text_60 = "-";
         color_104 = XUP_below_0;
      }
      if (imacd_224 <= imacd_232) {
         text_60 = "-";
         color_104 = XDN_above_0;
      }
      if (imacd_224 > imacd_232 && imacd_224 > 0.0) {
         text_60 = "-";
         color_104 = XUP_above_0;
      }
      if (imacd_224 <= imacd_232 && imacd_224 < 0.0) {
         text_60 = "-";
         color_104 = XDN_below_0;
      }
      if (imacd_240 > imacd_248) {
         text_68 = "-";
         color_108 = XUP_below_0;
      }
      if (imacd_240 <= imacd_248) {
         text_68 = "-";
         color_108 = XDN_above_0;
      }
      if (imacd_240 > imacd_248 && imacd_240 > 0.0) {
         text_68 = "-";
         color_108 = XUP_above_0;
      }
      if (imacd_240 <= imacd_248 && imacd_240 < 0.0) {
         text_68 = "-";
         color_108 = XDN_below_0;
      }
   }
   if (Show_intradayRange == TRUE) {
      if (Corner_of_Chart_RIGHT_TOP == 1) {
         ObjectCreate("Numbers", OBJ_LABEL, 0, 0, 0);
         ObjectSetText("Numbers", " M1     M5    M15   M30   H1     H4", 6, "Tahoma Narrow", BarLabel_color);
         ObjectSet("Numbers", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
         ObjectSet("Numbers", OBJPROP_XDISTANCE, Adjust_Side_to_side + 15);
         ObjectSet("Numbers", OBJPROP_YDISTANCE, Shift_UP_DN + 25);
      }
      if (Corner_of_Chart_RIGHT_TOP == 0) {
         ObjectCreate("Numbers", OBJ_LABEL, 0, 0, 0);
         ObjectSetText("Numbers", "H4    H1    M30   M15    M5    M1", 6, "Tahoma Narrow", BarLabel_color);
         ObjectSet("Numbers", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
         ObjectSet("Numbers", OBJPROP_XDISTANCE, Adjust_Side_to_side + 15);
         ObjectSet("Numbers", OBJPROP_YDISTANCE, Shift_UP_DN + 25);
      }
      ObjectCreate("SSignalMACDM1t", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("SSignalMACDM1t", "MACD", 6, "Tahoma Narrow", BarLabel_color);
      ObjectSet("SSignalMACDM1t", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
      ObjectSet("SSignalMACDM1t", OBJPROP_XDISTANCE, Adjust_Side_to_side + 135);
      ObjectSet("SSignalMACDM1t", OBJPROP_YDISTANCE, Shift_UP_DN + 35);
      ObjectCreate("SSignalMACDM1", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("SSignalMACDM1", text_28, 45, "Tahoma Narrow", color_88);
      ObjectSet("SSignalMACDM1", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
      ObjectSet("SSignalMACDM1", OBJPROP_XDISTANCE, Adjust_Side_to_side + 110);
      ObjectSet("SSignalMACDM1", OBJPROP_YDISTANCE, Shift_UP_DN + 2);
      ObjectCreate("SSignalMACDM5", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("SSignalMACDM5", text_36, 45, "Tahoma Narrow", color_92);
      ObjectSet("SSignalMACDM5", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
      ObjectSet("SSignalMACDM5", OBJPROP_XDISTANCE, Adjust_Side_to_side + 90);
      ObjectSet("SSignalMACDM5", OBJPROP_YDISTANCE, Shift_UP_DN + 2);
      ObjectCreate("SSignalMACDM15", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("SSignalMACDM15", text_44, 45, "Tahoma Narrow", color_96);
      ObjectSet("SSignalMACDM15", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
      ObjectSet("SSignalMACDM15", OBJPROP_XDISTANCE, Adjust_Side_to_side + 70);
      ObjectSet("SSignalMACDM15", OBJPROP_YDISTANCE, Shift_UP_DN + 2);
      ObjectCreate("SSignalMACDM30", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("SSignalMACDM30", text_52, 45, "Tahoma Narrow", color_100);
      ObjectSet("SSignalMACDM30", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
      ObjectSet("SSignalMACDM30", OBJPROP_XDISTANCE, Adjust_Side_to_side + 50);
      ObjectSet("SSignalMACDM30", OBJPROP_YDISTANCE, Shift_UP_DN + 2);
      ObjectCreate("SSignalMACDH1", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("SSignalMACDH1", text_12, 45, "Tahoma Narrow", color_80);
      ObjectSet("SSignalMACDH1", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
      ObjectSet("SSignalMACDH1", OBJPROP_XDISTANCE, Adjust_Side_to_side + 30);
      ObjectSet("SSignalMACDH1", OBJPROP_YDISTANCE, Shift_UP_DN + 2);
      ObjectCreate("SSignalMACDH4", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("SSignalMACDH4", text_20, 45, "Tahoma Narrow", color_84);
      ObjectSet("SSignalMACDH4", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
      ObjectSet("SSignalMACDH4", OBJPROP_XDISTANCE, Adjust_Side_to_side + 10);
      ObjectSet("SSignalMACDH4", OBJPROP_YDISTANCE, Shift_UP_DN + 2);
   }
   if (Show_intradayRange == FALSE) {
      if (Corner_of_Chart_RIGHT_TOP == 1) {
         ObjectCreate("Numbers", OBJ_LABEL, 0, 0, 0);
         ObjectSetText("Numbers", "1      5     15   30   H1    H4   D   W   MN ", 6, "Tahoma Narrow", BarLabel_color);
         ObjectSet("Numbers", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
         ObjectSet("Numbers", OBJPROP_XDISTANCE, Adjust_Side_to_side + 11);
         ObjectSet("Numbers", OBJPROP_YDISTANCE, Shift_UP_DN + 25);
      }
      if (Corner_of_Chart_RIGHT_TOP == 0) {
         ObjectCreate("Numbers", OBJ_LABEL, 0, 0, 0);
         ObjectSetText("Numbers", " MN   W   D    H4   H1    30   15    5    1", 6, "Tahoma Narrow", BarLabel_color);
         ObjectSet("Numbers", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
         ObjectSet("Numbers", OBJPROP_XDISTANCE, Adjust_Side_to_side + 11);
         ObjectSet("Numbers", OBJPROP_YDISTANCE, Shift_UP_DN + 25);
      }
      ObjectCreate("SSignalMACDM1t", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("SSignalMACDM1t", "MACD", 6, "Tahoma Narrow", BarLabel_color);
      ObjectSet("SSignalMACDM1t", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
      ObjectSet("SSignalMACDM1t", OBJPROP_XDISTANCE, Adjust_Side_to_side + 152);
      ObjectSet("SSignalMACDM1t", OBJPROP_YDISTANCE, Shift_UP_DN + 35);
      ObjectCreate("SSignalMACDM1", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("SSignalMACDM1", text_28, 35, "Tahoma Narrow", color_88);
      ObjectSet("SSignalMACDM1", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
      ObjectSet("SSignalMACDM1", OBJPROP_XDISTANCE, Adjust_Side_to_side + 132);
      ObjectSet("SSignalMACDM1", OBJPROP_YDISTANCE, Shift_UP_DN + 11);
      ObjectCreate("SSignalMACDM5", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("SSignalMACDM5", text_36, 35, "Tahoma Narrow", color_92);
      ObjectSet("SSignalMACDM5", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
      ObjectSet("SSignalMACDM5", OBJPROP_XDISTANCE, Adjust_Side_to_side + 117);
      ObjectSet("SSignalMACDM5", OBJPROP_YDISTANCE, Shift_UP_DN + 11);
      ObjectCreate("SSignalMACDM15", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("SSignalMACDM15", text_44, 35, "Tahoma Narrow", color_96);
      ObjectSet("SSignalMACDM15", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
      ObjectSet("SSignalMACDM15", OBJPROP_XDISTANCE, Adjust_Side_to_side + 102);
      ObjectSet("SSignalMACDM15", OBJPROP_YDISTANCE, Shift_UP_DN + 11);
      ObjectCreate("SSignalMACDM30", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("SSignalMACDM30", text_52, 35, "Tahoma Narrow", color_100);
      ObjectSet("SSignalMACDM30", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
      ObjectSet("SSignalMACDM30", OBJPROP_XDISTANCE, Adjust_Side_to_side + 87);
      ObjectSet("SSignalMACDM30", OBJPROP_YDISTANCE, Shift_UP_DN + 11);
      ObjectCreate("SSignalMACDH1", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("SSignalMACDH1", text_12, 35, "Tahoma Narrow", color_80);
      ObjectSet("SSignalMACDH1", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
      ObjectSet("SSignalMACDH1", OBJPROP_XDISTANCE, Adjust_Side_to_side + 72);
      ObjectSet("SSignalMACDH1", OBJPROP_YDISTANCE, Shift_UP_DN + 11);
      ObjectCreate("SSignalMACDH4", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("SSignalMACDH4", text_20, 35, "Tahoma Narrow", color_84);
      ObjectSet("SSignalMACDH4", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
      ObjectSet("SSignalMACDH4", OBJPROP_XDISTANCE, Adjust_Side_to_side + 57);
      ObjectSet("SSignalMACDH4", OBJPROP_YDISTANCE, Shift_UP_DN + 11);
      ObjectCreate("SSignalMACDD1", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("SSignalMACDD1", text_4, 35, "Tahoma Narrow", color_76);
      ObjectSet("SSignalMACDD1", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
      ObjectSet("SSignalMACDD1", OBJPROP_XDISTANCE, Adjust_Side_to_side + 42);
      ObjectSet("SSignalMACDD1", OBJPROP_YDISTANCE, Shift_UP_DN + 11);
      ObjectCreate("SSignalMACDW1", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("SSignalMACDW1", text_60, 35, "Tahoma Narrow", color_104);
      ObjectSet("SSignalMACDW1", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
      ObjectSet("SSignalMACDW1", OBJPROP_XDISTANCE, Adjust_Side_to_side + 27);
      ObjectSet("SSignalMACDW1", OBJPROP_YDISTANCE, Shift_UP_DN + 11);
      ObjectCreate("SSignalMACDMN1", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("SSignalMACDMN1", text_68, 35, "Tahoma Narrow", color_108);
      ObjectSet("SSignalMACDMN1", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
      ObjectSet("SSignalMACDMN1", OBJPROP_XDISTANCE, Adjust_Side_to_side + 12);
      ObjectSet("SSignalMACDMN1", OBJPROP_YDISTANCE, Shift_UP_DN + 11);
   }
   double irsi_256 = iRSI(NULL, PERIOD_MN1, RSI_Period, RSI_PRICE_TYPE, 0);
   double irsi_264 = iRSI(NULL, PERIOD_W1, RSI_Period, RSI_PRICE_TYPE, 0);
   double irsi_272 = iRSI(NULL, PERIOD_D1, RSI_Period, RSI_PRICE_TYPE, 0);
   double irsi_280 = iRSI(NULL, PERIOD_H4, RSI_Period, RSI_PRICE_TYPE, 0);
   double irsi_288 = iRSI(NULL, PERIOD_H1, RSI_Period, RSI_PRICE_TYPE, 0);
   double irsi_296 = iRSI(NULL, PERIOD_M30, RSI_Period, RSI_PRICE_TYPE, 0);
   double irsi_304 = iRSI(NULL, PERIOD_M15, RSI_Period, RSI_PRICE_TYPE, 0);
   double irsi_312 = iRSI(NULL, PERIOD_M5, RSI_Period, RSI_PRICE_TYPE, 0);
   double irsi_320 = iRSI(NULL, PERIOD_M1, RSI_Period, RSI_PRICE_TYPE, 0);
   double istochastic_328 = iStochastic(NULL, PERIOD_MN1, STOCH_K_Period, STOCH_D_Period, STOCH_Slowing, STOCH_MA_MODE, 0, MODE_MAIN, 0);
   double istochastic_336 = iStochastic(NULL, PERIOD_W1, STOCH_K_Period, STOCH_D_Period, STOCH_Slowing, STOCH_MA_MODE, 0, MODE_MAIN, 0);
   double istochastic_344 = iStochastic(NULL, PERIOD_D1, STOCH_K_Period, STOCH_D_Period, STOCH_Slowing, STOCH_MA_MODE, 0, MODE_MAIN, 0);
   double istochastic_352 = iStochastic(NULL, PERIOD_H4, STOCH_K_Period, STOCH_D_Period, STOCH_Slowing, STOCH_MA_MODE, 0, MODE_MAIN, 0);
   double istochastic_360 = iStochastic(NULL, PERIOD_H1, STOCH_K_Period, STOCH_D_Period, STOCH_Slowing, STOCH_MA_MODE, 0, MODE_MAIN, 0);
   double istochastic_368 = iStochastic(NULL, PERIOD_M30, STOCH_K_Period, STOCH_D_Period, STOCH_Slowing, STOCH_MA_MODE, 0, MODE_MAIN, 0);
   double istochastic_376 = iStochastic(NULL, PERIOD_M15, STOCH_K_Period, STOCH_D_Period, STOCH_Slowing, STOCH_MA_MODE, 0, MODE_MAIN, 0);
   double istochastic_384 = iStochastic(NULL, PERIOD_M5, STOCH_K_Period, STOCH_D_Period, STOCH_Slowing, STOCH_MA_MODE, 0, MODE_MAIN, 0);
   double istochastic_392 = iStochastic(NULL, PERIOD_M1, STOCH_K_Period, STOCH_D_Period, STOCH_Slowing, STOCH_MA_MODE, 0, MODE_MAIN, 0);
   double icci_400 = iCCI(NULL, PERIOD_MN1, CCI_Period, CCI_PRICE_TYPE, 0);
   double icci_408 = iCCI(NULL, PERIOD_W1, CCI_Period, CCI_PRICE_TYPE, 0);
   double icci_416 = iCCI(NULL, PERIOD_D1, CCI_Period, CCI_PRICE_TYPE, 0);
   double icci_424 = iCCI(NULL, PERIOD_H4, CCI_Period, CCI_PRICE_TYPE, 0);
   double icci_432 = iCCI(NULL, PERIOD_H1, CCI_Period, CCI_PRICE_TYPE, 0);
   double icci_440 = iCCI(NULL, PERIOD_M30, CCI_Period, CCI_PRICE_TYPE, 0);
   double icci_448 = iCCI(NULL, PERIOD_M15, CCI_Period, CCI_PRICE_TYPE, 0);
   double icci_456 = iCCI(NULL, PERIOD_M5, CCI_Period, CCI_PRICE_TYPE, 0);
   double icci_464 = iCCI(NULL, PERIOD_M1, CCI_Period, CCI_PRICE_TYPE, 0);
   string text_472 = "";
   string text_480 = "";
   string text_488 = "";
   string text_496 = "";
   string text_504 = "";
   string text_512 = "";
   string text_520 = "";
   string text_528 = "";
   string text_536 = "";
   if (Show_intradayRange == TRUE) {
      text_504 = "-";
      color_568 = STR_NO_Signal;
      text_472 = "-";
      color_564 = STR_NO_Signal;
      text_512 = "-";
      color_560 = STR_NO_Signal;
      text_480 = "-";
      color_556 = STR_NO_Signal;
      text_488 = "-";
      color_552 = STR_NO_Signal;
      text_496 = "-";
      color_548 = STR_NO_Signal;
      if (irsi_280 > 50.0 && istochastic_352 > 40.0 && icci_424 > 0.0) {
         text_504 = "-";
         color_568 = STR_UP;
      }
      if (irsi_288 > 50.0 && istochastic_360 > 40.0 && icci_432 > 0.0) {
         text_472 = "-";
         color_564 = STR_UP;
      }
      if (irsi_296 > 50.0 && istochastic_368 > 40.0 && icci_440 > 0.0) {
         text_512 = "-";
         color_560 = STR_UP;
      }
      if (irsi_304 > 50.0 && istochastic_376 > 40.0 && icci_448 > 0.0) {
         text_480 = "-";
         color_556 = STR_UP;
      }
      if (irsi_312 > 50.0 && istochastic_384 > 40.0 && icci_456 > 0.0) {
         text_488 = "-";
         color_552 = STR_UP;
      }
      if (irsi_320 > 50.0 && istochastic_392 > 40.0 && icci_464 > 0.0) {
         text_496 = "-";
         color_548 = STR_UP;
      }
      if (irsi_280 < 50.0 && istochastic_352 < 60.0 && icci_424 < 0.0) {
         text_504 = "-";
         color_568 = STR_DN;
      }
      if (irsi_288 < 50.0 && istochastic_360 < 60.0 && icci_432 < 0.0) {
         text_472 = "-";
         color_564 = STR_DN;
      }
      if (irsi_296 < 50.0 && istochastic_368 < 60.0 && icci_440 < 0.0) {
         text_512 = "-";
         color_560 = STR_DN;
      }
      if (irsi_304 < 50.0 && istochastic_376 < 60.0 && icci_448 < 0.0) {
         text_480 = "-";
         color_556 = STR_DN;
      }
      if (irsi_312 < 50.0 && istochastic_384 < 60.0 && icci_456 < 0.0) {
         text_488 = "-";
         color_552 = STR_DN;
      }
      if (irsi_320 < 50.0 && istochastic_392 < 60.0 && icci_464 < 0.0) {
         text_496 = "-";
         color_548 = STR_DN;
      }
   }
   if (Show_intradayRange == FALSE) {
      text_536 = "-";
      color_580 = STR_NO_Signal;
      text_528 = "-";
      color_576 = STR_NO_Signal;
      text_520 = "-";
      color_572 = STR_NO_Signal;
      text_504 = "-";
      color_568 = STR_NO_Signal;
      text_472 = "-";
      color_564 = STR_NO_Signal;
      text_512 = "-";
      color_560 = STR_NO_Signal;
      text_480 = "-";
      color_556 = STR_NO_Signal;
      text_488 = "-";
      color_552 = STR_NO_Signal;
      text_496 = "-";
      color_548 = STR_NO_Signal;
      if (irsi_256 > 50.0 && istochastic_328 > 40.0 && icci_400 > 0.0) {
         text_536 = "-";
         color_580 = STR_UP;
      }
      if (irsi_264 > 50.0 && istochastic_336 > 40.0 && icci_408 > 0.0) {
         text_528 = "-";
         color_576 = STR_UP;
      }
      if (irsi_272 > 50.0 && istochastic_344 > 40.0 && icci_416 > 0.0) {
         text_520 = "-";
         color_572 = STR_UP;
      }
      if (irsi_280 > 50.0 && istochastic_352 > 40.0 && icci_424 > 0.0) {
         text_504 = "-";
         color_568 = STR_UP;
      }
      if (irsi_288 > 50.0 && istochastic_360 > 40.0 && icci_432 > 0.0) {
         text_472 = "-";
         color_564 = STR_UP;
      }
      if (irsi_296 > 50.0 && istochastic_368 > 40.0 && icci_440 > 0.0) {
         text_512 = "-";
         color_560 = STR_UP;
      }
      if (irsi_304 > 50.0 && istochastic_376 > 40.0 && icci_448 > 0.0) {
         text_480 = "-";
         color_556 = STR_UP;
      }
      if (irsi_312 > 50.0 && istochastic_384 > 40.0 && icci_456 > 0.0) {
         text_488 = "-";
         color_552 = STR_UP;
      }
      if (irsi_320 > 50.0 && istochastic_392 > 40.0 && icci_464 > 0.0) {
         text_496 = "-";
         color_548 = STR_UP;
      }
      if (irsi_256 < 50.0 && istochastic_328 < 60.0 && icci_400 < 0.0) {
         text_536 = "-";
         color_580 = STR_DN;
      }
      if (irsi_264 < 50.0 && istochastic_336 < 60.0 && icci_408 < 0.0) {
         text_528 = "-";
         color_576 = STR_DN;
      }
      if (irsi_272 < 50.0 && istochastic_344 < 60.0 && icci_416 < 0.0) {
         text_520 = "-";
         color_572 = STR_DN;
      }
      if (irsi_280 < 50.0 && istochastic_352 < 60.0 && icci_424 < 0.0) {
         text_504 = "-";
         color_568 = STR_DN;
      }
      if (irsi_288 < 50.0 && istochastic_360 < 60.0 && icci_432 < 0.0) {
         text_472 = "-";
         color_564 = STR_DN;
      }
      if (irsi_296 < 50.0 && istochastic_368 < 60.0 && icci_440 < 0.0) {
         text_512 = "-";
         color_560 = STR_DN;
      }
      if (irsi_304 < 50.0 && istochastic_376 < 60.0 && icci_448 < 0.0) {
         text_480 = "-";
         color_556 = STR_DN;
      }
      if (irsi_312 < 50.0 && istochastic_384 < 60.0 && icci_456 < 0.0) {
         text_488 = "-";
         color_552 = STR_DN;
      }
      if (irsi_320 < 50.0 && istochastic_392 < 60.0 && icci_464 < 0.0) {
         text_496 = "-";
         color_548 = STR_DN;
      }
   }
   if (Show_intradayRange == TRUE) {
      ObjectCreate("SignalSTRM1t", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("SignalSTRM1t", "STR", 6, "Tahoma Narrow", BarLabel_color);
      ObjectSet("SignalSTRM1t", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
      ObjectSet("SignalSTRM1t", OBJPROP_XDISTANCE, Adjust_Side_to_side + 135);
      ObjectSet("SignalSTRM1t", OBJPROP_YDISTANCE, Shift_UP_DN + 43);
      ObjectCreate("SignalSTRM1", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("SignalSTRM1", text_496, 45, "Tahoma Narrow", color_548);
      ObjectSet("SignalSTRM1", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
      ObjectSet("SignalSTRM1", OBJPROP_XDISTANCE, Adjust_Side_to_side + 110);
      ObjectSet("SignalSTRM1", OBJPROP_YDISTANCE, Shift_UP_DN + 10);
      ObjectCreate("SignalSTRM5", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("SignalSTRM5", text_488, 45, "Tahoma Narrow", color_552);
      ObjectSet("SignalSTRM5", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
      ObjectSet("SignalSTRM5", OBJPROP_XDISTANCE, Adjust_Side_to_side + 90);
      ObjectSet("SignalSTRM5", OBJPROP_YDISTANCE, Shift_UP_DN + 10);
      ObjectCreate("SignalSTRM15", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("SignalSTRM15", text_480, 45, "Tahoma Narrow", color_556);
      ObjectSet("SignalSTRM15", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
      ObjectSet("SignalSTRM15", OBJPROP_XDISTANCE, Adjust_Side_to_side + 70);
      ObjectSet("SignalSTRM15", OBJPROP_YDISTANCE, Shift_UP_DN + 10);
      ObjectCreate("SignalSTRM30", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("SignalSTRM30", text_512, 45, "Tahoma Narrow", color_560);
      ObjectSet("SignalSTRM30", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
      ObjectSet("SignalSTRM30", OBJPROP_XDISTANCE, Adjust_Side_to_side + 50);
      ObjectSet("SignalSTRM30", OBJPROP_YDISTANCE, Shift_UP_DN + 10);
      ObjectCreate("SignalSTRM60", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("SignalSTRM60", text_472, 45, "Tahoma Narrow", color_564);
      ObjectSet("SignalSTRM60", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
      ObjectSet("SignalSTRM60", OBJPROP_XDISTANCE, Adjust_Side_to_side + 30);
      ObjectSet("SignalSTRM60", OBJPROP_YDISTANCE, Shift_UP_DN + 10);
      ObjectCreate("SignalSTRM240", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("SignalSTRM240", text_504, 45, "Tahoma Narrow", color_568);
      ObjectSet("SignalSTRM240", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
      ObjectSet("SignalSTRM240", OBJPROP_XDISTANCE, Adjust_Side_to_side + 10);
      ObjectSet("SignalSTRM240", OBJPROP_YDISTANCE, Shift_UP_DN + 10);
   }
   if (Show_intradayRange == FALSE) {
      ObjectCreate("SignalSTRM1t", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("SignalSTRM1t", "STR", 6, "Tahoma Narrow", BarLabel_color);
      ObjectSet("SignalSTRM1t", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
      ObjectSet("SignalSTRM1t", OBJPROP_XDISTANCE, Adjust_Side_to_side + 152);
      ObjectSet("SignalSTRM1t", OBJPROP_YDISTANCE, Shift_UP_DN + 43);
      ObjectCreate("SignalSTRM1", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("SignalSTRM1", text_496, 35, "Tahoma Narrow", color_548);
      ObjectSet("SignalSTRM1", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
      ObjectSet("SignalSTRM1", OBJPROP_XDISTANCE, Adjust_Side_to_side + 132);
      ObjectSet("SignalSTRM1", OBJPROP_YDISTANCE, Shift_UP_DN + 19);
      ObjectCreate("SignalSTRM5", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("SignalSTRM5", text_488, 35, "Tahoma Narrow", color_552);
      ObjectSet("SignalSTRM5", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
      ObjectSet("SignalSTRM5", OBJPROP_XDISTANCE, Adjust_Side_to_side + 117);
      ObjectSet("SignalSTRM5", OBJPROP_YDISTANCE, Shift_UP_DN + 19);
      ObjectCreate("SignalSTRM15", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("SignalSTRM15", text_480, 35, "Tahoma Narrow", color_556);
      ObjectSet("SignalSTRM15", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
      ObjectSet("SignalSTRM15", OBJPROP_XDISTANCE, Adjust_Side_to_side + 102);
      ObjectSet("SignalSTRM15", OBJPROP_YDISTANCE, Shift_UP_DN + 19);
      ObjectCreate("SignalSTRM30", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("SignalSTRM30", text_512, 35, "Tahoma Narrow", color_560);
      ObjectSet("SignalSTRM30", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
      ObjectSet("SignalSTRM30", OBJPROP_XDISTANCE, Adjust_Side_to_side + 87);
      ObjectSet("SignalSTRM30", OBJPROP_YDISTANCE, Shift_UP_DN + 19);
      ObjectCreate("SignalSTRM60", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("SignalSTRM60", text_472, 35, "Tahoma Narrow", color_564);
      ObjectSet("SignalSTRM60", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
      ObjectSet("SignalSTRM60", OBJPROP_XDISTANCE, Adjust_Side_to_side + 72);
      ObjectSet("SignalSTRM60", OBJPROP_YDISTANCE, Shift_UP_DN + 19);
      ObjectCreate("SignalSTRM240", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("SignalSTRM240", text_504, 35, "Tahoma Narrow", color_568);
      ObjectSet("SignalSTRM240", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
      ObjectSet("SignalSTRM240", OBJPROP_XDISTANCE, Adjust_Side_to_side + 57);
      ObjectSet("SignalSTRM240", OBJPROP_YDISTANCE, Shift_UP_DN + 19);
      ObjectCreate("SignalSTRM1440", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("SignalSTRM1440", text_520, 35, "Tahoma Narrow", color_572);
      ObjectSet("SignalSTRM1440", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
      ObjectSet("SignalSTRM1440", OBJPROP_XDISTANCE, Adjust_Side_to_side + 42);
      ObjectSet("SignalSTRM1440", OBJPROP_YDISTANCE, Shift_UP_DN + 19);
      ObjectCreate("SignalSTRM10080", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("SignalSTRM10080", text_528, 35, "Tahoma Narrow", color_576);
      ObjectSet("SignalSTRM10080", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
      ObjectSet("SignalSTRM10080", OBJPROP_XDISTANCE, Adjust_Side_to_side + 27);
      ObjectSet("SignalSTRM10080", OBJPROP_YDISTANCE, Shift_UP_DN + 19);
      ObjectCreate("SignalSTRM43200", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("SignalSTRM43200", text_536, 35, "Tahoma Narrow", color_580);
      ObjectSet("SignalSTRM43200", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
      ObjectSet("SignalSTRM43200", OBJPROP_XDISTANCE, Adjust_Side_to_side + 12);
      ObjectSet("SignalSTRM43200", OBJPROP_YDISTANCE, Shift_UP_DN + 19);
   }
   double ima_584 = iMA(Symbol(), PERIOD_M1, MA_Fast, 0, MA_MODE, MA_PRICE_TYPE, 0);
   double ima_592 = iMA(Symbol(), PERIOD_M1, MA_Slow, 0, MA_MODE, MA_PRICE_TYPE, 0);
   double ima_600 = iMA(Symbol(), PERIOD_M5, MA_Fast, 0, MA_MODE, MA_PRICE_TYPE, 0);
   double ima_608 = iMA(Symbol(), PERIOD_M5, MA_Slow, 0, MA_MODE, MA_PRICE_TYPE, 0);
   double ima_616 = iMA(Symbol(), PERIOD_M15, MA_Fast, 0, MA_MODE, MA_PRICE_TYPE, 0);
   double ima_624 = iMA(Symbol(), PERIOD_M15, MA_Slow, 0, MA_MODE, MA_PRICE_TYPE, 0);
   double ima_632 = iMA(Symbol(), PERIOD_M30, MA_Fast, 0, MA_MODE, MA_PRICE_TYPE, 0);
   double ima_640 = iMA(Symbol(), PERIOD_M30, MA_Slow, 0, MA_MODE, MA_PRICE_TYPE, 0);
   double ima_648 = iMA(Symbol(), PERIOD_H1, MA_Fast, 0, MA_MODE, MA_PRICE_TYPE, 0);
   double ima_656 = iMA(Symbol(), PERIOD_H1, MA_Slow, 0, MA_MODE, MA_PRICE_TYPE, 0);
   double ima_664 = iMA(Symbol(), PERIOD_H4, MA_Fast, 0, MA_MODE, MA_PRICE_TYPE, 0);
   double ima_672 = iMA(Symbol(), PERIOD_H4, MA_Slow, 0, MA_MODE, MA_PRICE_TYPE, 0);
   double ima_680 = iMA(Symbol(), PERIOD_D1, MA_Fast, 0, MA_MODE, MA_PRICE_TYPE, 0);
   double ima_688 = iMA(Symbol(), PERIOD_D1, MA_Slow, 0, MA_MODE, MA_PRICE_TYPE, 0);
   double ima_696 = iMA(Symbol(), PERIOD_W1, MA_Fast, 0, MA_MODE, MA_PRICE_TYPE, 0);
   double ima_704 = iMA(Symbol(), PERIOD_W1, MA_Slow, 0, MA_MODE, MA_PRICE_TYPE, 0);
   double ima_712 = iMA(Symbol(), PERIOD_MN1, MA_Fast, 0, MA_MODE, MA_PRICE_TYPE, 0);
   double ima_720 = iMA(Symbol(), PERIOD_MN1, MA_Slow, 0, MA_MODE, MA_PRICE_TYPE, 0);
   string text_728 = "";
   string text_736 = "";
   string text_744 = "";
   string text_752 = "";
   string text_760 = "";
   string text_768 = "";
   string text_776 = "";
   string text_784 = "";
   string text_792 = "";
   if (Show_intradayRange == TRUE) {
      if (ima_584 > ima_592) {
         text_728 = "-";
         color_808 = MA_UP;
      }
      if (ima_584 <= ima_592) {
         text_728 = "-";
         color_808 = MA_DN;
      }
      if (ima_600 > ima_608) {
         text_736 = "-";
         color_812 = MA_UP;
      }
      if (ima_600 <= ima_608) {
         text_736 = "-";
         color_812 = MA_DN;
      }
      if (ima_616 > ima_624) {
         text_744 = "-";
         color_816 = MA_UP;
      }
      if (ima_616 <= ima_624) {
         text_744 = "-";
         color_816 = MA_DN;
      }
      if (ima_632 > ima_640) {
         text_752 = "-";
         color_820 = MA_UP;
      }
      if (ima_632 <= ima_640) {
         text_752 = "-";
         color_820 = MA_DN;
      }
      if (ima_648 > ima_656) {
         text_760 = "-";
         color_824 = MA_UP;
      }
      if (ima_648 <= ima_656) {
         text_760 = "-";
         color_824 = MA_DN;
      }
      if (ima_664 > ima_672) {
         text_768 = "-";
         color_828 = MA_UP;
      }
      if (ima_664 <= ima_672) {
         text_768 = "-";
         color_828 = MA_DN;
      }
   }
   if (Show_intradayRange == FALSE) {
      if (ima_584 > ima_592) {
         text_728 = "-";
         color_808 = MA_UP;
      }
      if (ima_584 <= ima_592) {
         text_728 = "-";
         color_808 = MA_DN;
      }
      if (ima_600 > ima_608) {
         text_736 = "-";
         color_812 = MA_UP;
      }
      if (ima_600 <= ima_608) {
         text_736 = "-";
         color_812 = MA_DN;
      }
      if (ima_616 > ima_624) {
         text_744 = "-";
         color_816 = MA_UP;
      }
      if (ima_616 <= ima_624) {
         text_744 = "-";
         color_816 = MA_DN;
      }
      if (ima_632 > ima_640) {
         text_752 = "-";
         color_820 = MA_UP;
      }
      if (ima_632 <= ima_640) {
         text_752 = "-";
         color_820 = MA_DN;
      }
      if (ima_648 > ima_656) {
         text_760 = "-";
         color_824 = MA_UP;
      }
      if (ima_648 <= ima_656) {
         text_760 = "-";
         color_824 = MA_DN;
      }
      if (ima_664 > ima_672) {
         text_768 = "-";
         color_828 = MA_UP;
      }
      if (ima_664 <= ima_672) {
         text_768 = "-";
         color_828 = MA_DN;
      }
      if (ima_680 > ima_688) {
         text_776 = "-";
         color_832 = MA_UP;
      }
      if (ima_680 <= ima_688) {
         text_776 = "-";
         color_832 = MA_DN;
      }
      if (ima_696 > ima_704) {
         text_784 = "-";
         color_836 = MA_UP;
      }
      if (ima_696 <= ima_704) {
         text_784 = "-";
         color_836 = MA_DN;
      }
      if (ima_712 > ima_720) {
         text_792 = "-";
         color_840 = MA_UP;
      }
      if (ima_712 <= ima_720) {
         text_792 = "-";
         color_840 = MA_DN;
      }
   }
   if (Show_intradayRange == TRUE) {
      ObjectCreate("SignalEMAM1t", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("SignalEMAM1t", "EMA", 6, "Tahoma Narrow", BarLabel_color);
      ObjectSet("SignalEMAM1t", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
      ObjectSet("SignalEMAM1t", OBJPROP_XDISTANCE, Adjust_Side_to_side + 135);
      ObjectSet("SignalEMAM1t", OBJPROP_YDISTANCE, Shift_UP_DN + 51);
      ObjectCreate("SignalEMAM1", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("SignalEMAM1", text_728, 45, "Tahoma Narrow", color_808);
      ObjectSet("SignalEMAM1", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
      ObjectSet("SignalEMAM1", OBJPROP_XDISTANCE, Adjust_Side_to_side + 110);
      ObjectSet("SignalEMAM1", OBJPROP_YDISTANCE, Shift_UP_DN + 18);
      ObjectCreate("SignalEMAM5", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("SignalEMAM5", text_736, 45, "Tahoma Narrow", color_812);
      ObjectSet("SignalEMAM5", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
      ObjectSet("SignalEMAM5", OBJPROP_XDISTANCE, Adjust_Side_to_side + 90);
      ObjectSet("SignalEMAM5", OBJPROP_YDISTANCE, Shift_UP_DN + 18);
      ObjectCreate("SignalEMAM15", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("SignalEMAM15", text_744, 45, "Tahoma Narrow", color_816);
      ObjectSet("SignalEMAM15", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
      ObjectSet("SignalEMAM15", OBJPROP_XDISTANCE, Adjust_Side_to_side + 70);
      ObjectSet("SignalEMAM15", OBJPROP_YDISTANCE, Shift_UP_DN + 18);
      ObjectCreate("SignalEMAM30", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("SignalEMAM30", text_752, 45, "Tahoma Narrow", color_820);
      ObjectSet("SignalEMAM30", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
      ObjectSet("SignalEMAM30", OBJPROP_XDISTANCE, Adjust_Side_to_side + 50);
      ObjectSet("SignalEMAM30", OBJPROP_YDISTANCE, Shift_UP_DN + 18);
      ObjectCreate("SignalEMAM60", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("SignalEMAM60", text_760, 45, "Tahoma Narrow", color_824);
      ObjectSet("SignalEMAM60", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
      ObjectSet("SignalEMAM60", OBJPROP_XDISTANCE, Adjust_Side_to_side + 30);
      ObjectSet("SignalEMAM60", OBJPROP_YDISTANCE, Shift_UP_DN + 18);
      ObjectCreate("SignalEMAM240", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("SignalEMAM240", text_768, 45, "Tahoma Narrow", color_828);
      ObjectSet("SignalEMAM240", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
      ObjectSet("SignalEMAM240", OBJPROP_XDISTANCE, Adjust_Side_to_side + 10);
      ObjectSet("SignalEMAM240", OBJPROP_YDISTANCE, Shift_UP_DN + 18);
   }
   if (Show_intradayRange == FALSE) {
      ObjectCreate("SignalEMAM1t", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("SignalEMAM1t", "EMA", 6, "Tahoma Narrow", BarLabel_color);
      ObjectSet("SignalEMAM1t", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
      ObjectSet("SignalEMAM1t", OBJPROP_XDISTANCE, Adjust_Side_to_side + 152);
      ObjectSet("SignalEMAM1t", OBJPROP_YDISTANCE, Shift_UP_DN + 51);
      ObjectCreate("SignalEMAM1", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("SignalEMAM1", text_728, 35, "Tahoma Narrow", color_808);
      ObjectSet("SignalEMAM1", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
      ObjectSet("SignalEMAM1", OBJPROP_XDISTANCE, Adjust_Side_to_side + 132);
      ObjectSet("SignalEMAM1", OBJPROP_YDISTANCE, Shift_UP_DN + 27);
      ObjectCreate("SignalEMAM5", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("SignalEMAM5", text_736, 35, "Tahoma Narrow", color_812);
      ObjectSet("SignalEMAM5", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
      ObjectSet("SignalEMAM5", OBJPROP_XDISTANCE, Adjust_Side_to_side + 117);
      ObjectSet("SignalEMAM5", OBJPROP_YDISTANCE, Shift_UP_DN + 27);
      ObjectCreate("SignalEMAM15", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("SignalEMAM15", text_744, 35, "Tahoma Narrow", color_816);
      ObjectSet("SignalEMAM15", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
      ObjectSet("SignalEMAM15", OBJPROP_XDISTANCE, Adjust_Side_to_side + 102);
      ObjectSet("SignalEMAM15", OBJPROP_YDISTANCE, Shift_UP_DN + 27);
      ObjectCreate("SignalEMAM30", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("SignalEMAM30", text_752, 35, "Tahoma Narrow", color_820);
      ObjectSet("SignalEMAM30", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
      ObjectSet("SignalEMAM30", OBJPROP_XDISTANCE, Adjust_Side_to_side + 87);
      ObjectSet("SignalEMAM30", OBJPROP_YDISTANCE, Shift_UP_DN + 27);
      ObjectCreate("SignalEMAM60", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("SignalEMAM60", text_760, 35, "Tahoma Narrow", color_824);
      ObjectSet("SignalEMAM60", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
      ObjectSet("SignalEMAM60", OBJPROP_XDISTANCE, Adjust_Side_to_side + 72);
      ObjectSet("SignalEMAM60", OBJPROP_YDISTANCE, Shift_UP_DN + 27);
      ObjectCreate("SignalEMAM240", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("SignalEMAM240", text_768, 35, "Tahoma Narrow", color_828);
      ObjectSet("SignalEMAM240", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
      ObjectSet("SignalEMAM240", OBJPROP_XDISTANCE, Adjust_Side_to_side + 57);
      ObjectSet("SignalEMAM240", OBJPROP_YDISTANCE, Shift_UP_DN + 27);
      ObjectCreate("SignalEMAM1440", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("SignalEMAM1440", text_776, 35, "Tahoma Narrow", color_832);
      ObjectSet("SignalEMAM1440", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
      ObjectSet("SignalEMAM1440", OBJPROP_XDISTANCE, Adjust_Side_to_side + 42);
      ObjectSet("SignalEMAM1440", OBJPROP_YDISTANCE, Shift_UP_DN + 27);
      ObjectCreate("SignalEMAM10080", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("SignalEMAM10080", text_784, 35, "Tahoma Narrow", color_836);
      ObjectSet("SignalEMAM10080", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
      ObjectSet("SignalEMAM10080", OBJPROP_XDISTANCE, Adjust_Side_to_side + 27);
      ObjectSet("SignalEMAM10080", OBJPROP_YDISTANCE, Shift_UP_DN + 27);
      ObjectCreate("SignalEMAM43200", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("SignalEMAM43200", text_792, 35, "Tahoma Narrow", color_840);
      ObjectSet("SignalEMAM43200", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
      ObjectSet("SignalEMAM43200", OBJPROP_XDISTANCE, Adjust_Side_to_side + 12);
      ObjectSet("SignalEMAM43200", OBJPROP_YDISTANCE, Shift_UP_DN + 27);
   }
   double ima_844 = iMA(Symbol(), 0, 1, 0, MODE_EMA, PRICE_CLOSE, 0);
   string Ls_800 = DoubleToStr(ima_844, Digits);
   ObjectCreate("cja", OBJ_LABEL, 0, 0, 0);
   ObjectSetText("cja", "Signal Bars by cja", 8, "Tahoma Narrow", color_560);
   ObjectSet("cja", OBJPROP_CORNER, 2);
   ObjectSet("cja", OBJPROP_XDISTANCE, 5);
   ObjectSet("cja", OBJPROP_YDISTANCE, 10);
   if (Show_Smaller_Size == FALSE) {
      if (Show_Price == TRUE) {
         ObjectCreate("Signalprice", OBJ_LABEL, 0, 0, 0);
         ObjectSetText("Signalprice", "" + Ls_800 + "", 30, "Arial", color_560);
         ObjectSet("Signalprice", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
         ObjectSet("Signalprice", OBJPROP_XDISTANCE, Adjust_Side_to_side + 10);
         ObjectSet("Signalprice", OBJPROP_YDISTANCE, Shift_UP_DN + 58);
      }
   }
   if (Show_Smaller_Size == TRUE) {
      if (Show_Price == TRUE) {
         ObjectCreate("Signalprice", OBJ_LABEL, 0, 0, 0);
         ObjectSetText("Signalprice", "" + Ls_800 + "", 15, "Arial", color_560);
         ObjectSet("Signalprice", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
         ObjectSet("Signalprice", OBJPROP_XDISTANCE, Adjust_Side_to_side + 10);
         ObjectSet("Signalprice", OBJPROP_YDISTANCE, Shift_UP_DN + 60);
      }
   }
   if (Show_Smaller_Size == FALSE) {
      if (Show_Price == TRUE) {
         if (Show_intradayRange == FALSE) {
            ObjectCreate("Signalprice", OBJ_LABEL, 0, 0, 0);
            ObjectSetText("Signalprice", "" + Ls_800 + "", 35, "Arial", color_560);
            ObjectSet("Signalprice", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
            ObjectSet("Signalprice", OBJPROP_XDISTANCE, Adjust_Side_to_side + 9);
            ObjectSet("Signalprice", OBJPROP_YDISTANCE, Shift_UP_DN + 56);
         }
      }
   }
   int Li_852 = 0;
   int Li_856 = 0;
   int Li_860 = 0;
   int Li_864 = 0;
   int Li_868 = 0;
   int Li_872 = 0;
   Li_852 = (iHigh(NULL, PERIOD_D1, 1) - iLow(NULL, PERIOD_D1, 1)) / Point;
   for (Li_872 = 1; Li_872 <= 5; Li_872++) Li_856 = Li_856 + (iHigh(NULL, PERIOD_D1, Li_872) - iLow(NULL, PERIOD_D1, Li_872)) / Point;
   for (Li_872 = 1; Li_872 <= 10; Li_872++) Li_860 = Li_860 + (iHigh(NULL, PERIOD_D1, Li_872) - iLow(NULL, PERIOD_D1, Li_872)) / Point;
   for (Li_872 = 1; Li_872 <= 20; Li_872++) Li_864 = Li_864 + (iHigh(NULL, PERIOD_D1, Li_872) - iLow(NULL, PERIOD_D1, Li_872)) / Point;
   Li_856 /= 5;
   Li_860 /= 10;
   Li_864 /= 20;
   Li_868 = (Li_852 + Li_856 + Li_860 + Li_864) / 4;
   string Ls_unused_876 = "";
   string Ls_unused_884 = "";
   string Ls_892 = "";
   string Ls_900 = "";
   string Ls_908 = "";
   string Ls_916 = "";
   string Ls_unused_932 = "";
   string Ls_unused_940 = "";
   string Ls_948 = "";
   double iopen_964 = iOpen(NULL, PERIOD_D1, 0);
   double iclose_972 = iClose(NULL, PERIOD_D1, 0);
   double Ld_980 = (Ask - Bid) / Point;
   double ihigh_988 = iHigh(NULL, PERIOD_D1, 0);
   double ilow_996 = iLow(NULL, PERIOD_D1, 0);
   Ls_900 = DoubleToStr((iclose_972 - iopen_964) / Point, 0);
   Ls_892 = DoubleToStr(Ld_980, Digits - 4);
   Ls_908 = DoubleToStr(Li_868, Digits - 4);
   Ls_948 = (iHigh(NULL, PERIOD_D1, 1) - iLow(NULL, PERIOD_D1, 1)) / Point;
   Ls_916 = DoubleToStr((ihigh_988 - ilow_996) / Point, 0);
   if (iclose_972 >= iopen_964) {
      Ls_unused_932 = "-";
      color_956 = Pips_UP;
   }
   if (iclose_972 < iopen_964) {
      Ls_unused_932 = "-";
      color_956 = Pips_DN;
   }
   if (Ls_908 >= Ls_948) {
      Ls_unused_940 = "-";
      color_960 = Daily_AV_UP;
   }
   if (Ls_908 < Ls_948) {
      Ls_unused_940 = "-";
      color_960 = Daily_AV_DN;
   }
   if (Show_Smaller_Size == FALSE) {
      if (Show_Xtra_Details == TRUE) {
         if (Show_Price == TRUE) {
            ObjectCreate("LEVELS7", OBJ_LABEL, 0, 0, 0);
            ObjectSetText("LEVELS7", "Spread", 12, "Arial", CommentLabel_color);
            ObjectSet("LEVELS7", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
            ObjectSet("LEVELS7", OBJPROP_XDISTANCE, Adjust_Side_to_side + 45);
            ObjectSet("LEVELS7", OBJPROP_YDISTANCE, Shift_UP_DN + 100);
            ObjectCreate("LEVELS8", OBJ_LABEL, 0, 0, 0);
            ObjectSetText("LEVELS8", "" + Ls_892 + "", 12, "Arial Bold", Spread_color);
            ObjectSet("LEVELS8", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
            ObjectSet("LEVELS8", OBJPROP_XDISTANCE, Adjust_Side_to_side + 10);
            ObjectSet("LEVELS8", OBJPROP_YDISTANCE, Shift_UP_DN + 100);
            ObjectCreate("LEVELS9", OBJ_LABEL, 0, 0, 0);
            ObjectSetText("LEVELS9", "Pips to Open", 12, "Arial", CommentLabel_color);
            ObjectSet("LEVELS9", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
            ObjectSet("LEVELS9", OBJPROP_XDISTANCE, Adjust_Side_to_side + 45);
            ObjectSet("LEVELS9", OBJPROP_YDISTANCE, Shift_UP_DN + 115);
            ObjectCreate("LEVELS10", OBJ_LABEL, 0, 0, 0);
            ObjectSetText("LEVELS10", "" + Ls_900 + "", 12, "Arial Bold", color_956);
            ObjectSet("LEVELS10", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
            ObjectSet("LEVELS10", OBJPROP_XDISTANCE, Adjust_Side_to_side + 10);
            ObjectSet("LEVELS10", OBJPROP_YDISTANCE, Shift_UP_DN + 115);
            ObjectCreate("LEVELS11", OBJ_LABEL, 0, 0, 0);
            ObjectSetText("LEVELS11", "Hi to Low", 12, "Arial", CommentLabel_color);
            ObjectSet("LEVELS11", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
            ObjectSet("LEVELS11", OBJPROP_XDISTANCE, Adjust_Side_to_side + 45);
            ObjectSet("LEVELS11", OBJPROP_YDISTANCE, Shift_UP_DN + 130);
            ObjectCreate("LEVELS12", OBJ_LABEL, 0, 0, 0);
            ObjectSetText("LEVELS12", "" + Ls_916 + "", 12, "Arial Bold", HI_LO_color);
            ObjectSet("LEVELS12", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
            ObjectSet("LEVELS12", OBJPROP_XDISTANCE, Adjust_Side_to_side + 10);
            ObjectSet("LEVELS12", OBJPROP_YDISTANCE, Shift_UP_DN + 130);
            ObjectCreate("LEVELS13", OBJ_LABEL, 0, 0, 0);
            ObjectSetText("LEVELS13", "Daily Av", 12, "Arial", CommentLabel_color);
            ObjectSet("LEVELS13", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
            ObjectSet("LEVELS13", OBJPROP_XDISTANCE, Adjust_Side_to_side + 45);
            ObjectSet("LEVELS13", OBJPROP_YDISTANCE, Shift_UP_DN + 145);
            ObjectCreate("LEVELS14", OBJ_LABEL, 0, 0, 0);
            ObjectSetText("LEVELS14", "" + Ls_908 + "", 12, "Arial Bold", color_960);
            ObjectSet("LEVELS14", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
            ObjectSet("LEVELS14", OBJPROP_XDISTANCE, Adjust_Side_to_side + 10);
            ObjectSet("LEVELS14", OBJPROP_YDISTANCE, Shift_UP_DN + 145);
         }
      }
   }
   if (Show_Smaller_Size == FALSE) {
      if (Show_Xtra_Details == TRUE) {
         if (Show_Price == FALSE) {
            ObjectCreate("LEVELS7", OBJ_LABEL, 0, 0, 0);
            ObjectSetText("LEVELS7", "Spread", 12, "Arial", CommentLabel_color);
            ObjectSet("LEVELS7", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
            ObjectSet("LEVELS7", OBJPROP_XDISTANCE, Adjust_Side_to_side + 45);
            ObjectSet("LEVELS7", OBJPROP_YDISTANCE, Shift_UP_DN + 60);
            ObjectCreate("LEVELS8", OBJ_LABEL, 0, 0, 0);
            ObjectSetText("LEVELS8", "" + Ls_892 + "", 12, "Arial Bold", Spread_color);
            ObjectSet("LEVELS8", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
            ObjectSet("LEVELS8", OBJPROP_XDISTANCE, Adjust_Side_to_side + 10);
            ObjectSet("LEVELS8", OBJPROP_YDISTANCE, Shift_UP_DN + 60);
            ObjectCreate("LEVELS9", OBJ_LABEL, 0, 0, 0);
            ObjectSetText("LEVELS9", "Pips to Open", 12, "Arial", CommentLabel_color);
            ObjectSet("LEVELS9", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
            ObjectSet("LEVELS9", OBJPROP_XDISTANCE, Adjust_Side_to_side + 45);
            ObjectSet("LEVELS9", OBJPROP_YDISTANCE, Shift_UP_DN + 75);
            ObjectCreate("LEVELS10", OBJ_LABEL, 0, 0, 0);
            ObjectSetText("LEVELS10", "" + Ls_900 + "", 12, "Arial Bold", color_956);
            ObjectSet("LEVELS10", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
            ObjectSet("LEVELS10", OBJPROP_XDISTANCE, Adjust_Side_to_side + 10);
            ObjectSet("LEVELS10", OBJPROP_YDISTANCE, Shift_UP_DN + 75);
            ObjectCreate("LEVELS11", OBJ_LABEL, 0, 0, 0);
            ObjectSetText("LEVELS11", "Hi to Low", 12, "Arial", CommentLabel_color);
            ObjectSet("LEVELS11", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
            ObjectSet("LEVELS11", OBJPROP_XDISTANCE, Adjust_Side_to_side + 45);
            ObjectSet("LEVELS11", OBJPROP_YDISTANCE, Shift_UP_DN + 90);
            ObjectCreate("LEVELS12", OBJ_LABEL, 0, 0, 0);
            ObjectSetText("LEVELS12", "" + Ls_916 + "", 12, "Arial Bold", HI_LO_color);
            ObjectSet("LEVELS12", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
            ObjectSet("LEVELS12", OBJPROP_XDISTANCE, Adjust_Side_to_side + 10);
            ObjectSet("LEVELS12", OBJPROP_YDISTANCE, Shift_UP_DN + 90);
            ObjectCreate("LEVELS13", OBJ_LABEL, 0, 0, 0);
            ObjectSetText("LEVELS13", "Daily Av", 12, "Arial", CommentLabel_color);
            ObjectSet("LEVELS13", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
            ObjectSet("LEVELS13", OBJPROP_XDISTANCE, Adjust_Side_to_side + 45);
            ObjectSet("LEVELS13", OBJPROP_YDISTANCE, Shift_UP_DN + 105);
            ObjectCreate("LEVELS14", OBJ_LABEL, 0, 0, 0);
            ObjectSetText("LEVELS14", "" + Ls_908 + "", 12, "Arial Bold", color_960);
            ObjectSet("LEVELS14", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
            ObjectSet("LEVELS14", OBJPROP_XDISTANCE, Adjust_Side_to_side + 10);
            ObjectSet("LEVELS14", OBJPROP_YDISTANCE, Shift_UP_DN + 105);
         }
      }
   }
   if (Show_Smaller_Size == TRUE) {
      if (Show_Xtra_Details == TRUE) {
         if (Show_Price == TRUE) {
            ObjectCreate("LEVELS7", OBJ_LABEL, 0, 0, 0);
            ObjectSetText("LEVELS7", "Spread", 9, "Arial", CommentLabel_color);
            ObjectSet("LEVELS7", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
            ObjectSet("LEVELS7", OBJPROP_XDISTANCE, Adjust_Side_to_side + 40);
            ObjectSet("LEVELS7", OBJPROP_YDISTANCE, Shift_UP_DN + 80);
            ObjectCreate("LEVELS8", OBJ_LABEL, 0, 0, 0);
            ObjectSetText("LEVELS8", "" + Ls_892 + "", 9, "Arial Bold", Spread_color);
            ObjectSet("LEVELS8", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
            ObjectSet("LEVELS8", OBJPROP_XDISTANCE, Adjust_Side_to_side + 10);
            ObjectSet("LEVELS8", OBJPROP_YDISTANCE, Shift_UP_DN + 80);
            ObjectCreate("LEVELS9", OBJ_LABEL, 0, 0, 0);
            ObjectSetText("LEVELS9", "Pips to Open", 9, "Arial", CommentLabel_color);
            ObjectSet("LEVELS9", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
            ObjectSet("LEVELS9", OBJPROP_XDISTANCE, Adjust_Side_to_side + 40);
            ObjectSet("LEVELS9", OBJPROP_YDISTANCE, Shift_UP_DN + 95);
            ObjectCreate("LEVELS10", OBJ_LABEL, 0, 0, 0);
            ObjectSetText("LEVELS10", "" + Ls_900 + "", 9, "Arial Bold", color_956);
            ObjectSet("LEVELS10", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
            ObjectSet("LEVELS10", OBJPROP_XDISTANCE, Adjust_Side_to_side + 10);
            ObjectSet("LEVELS10", OBJPROP_YDISTANCE, Shift_UP_DN + 95);
            ObjectCreate("LEVELS11", OBJ_LABEL, 0, 0, 0);
            ObjectSetText("LEVELS11", "Hi to Low", 9, "Arial", CommentLabel_color);
            ObjectSet("LEVELS11", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
            ObjectSet("LEVELS11", OBJPROP_XDISTANCE, Adjust_Side_to_side + 40);
            ObjectSet("LEVELS11", OBJPROP_YDISTANCE, Shift_UP_DN + 110);
            ObjectCreate("LEVELS12", OBJ_LABEL, 0, 0, 0);
            ObjectSetText("LEVELS12", "" + Ls_916 + "", 9, "Arial Bold", HI_LO_color);
            ObjectSet("LEVELS12", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
            ObjectSet("LEVELS12", OBJPROP_XDISTANCE, Adjust_Side_to_side + 10);
            ObjectSet("LEVELS12", OBJPROP_YDISTANCE, Shift_UP_DN + 110);
            ObjectCreate("LEVELS13", OBJ_LABEL, 0, 0, 0);
            ObjectSetText("LEVELS13", "Daily Av", 9, "Arial", CommentLabel_color);
            ObjectSet("LEVELS13", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
            ObjectSet("LEVELS13", OBJPROP_XDISTANCE, Adjust_Side_to_side + 40);
            ObjectSet("LEVELS13", OBJPROP_YDISTANCE, Shift_UP_DN + 125);
            ObjectCreate("LEVELS14", OBJ_LABEL, 0, 0, 0);
            ObjectSetText("LEVELS14", "" + Ls_908 + "", 9, "Arial Bold", color_960);
            ObjectSet("LEVELS14", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
            ObjectSet("LEVELS14", OBJPROP_XDISTANCE, Adjust_Side_to_side + 10);
            ObjectSet("LEVELS14", OBJPROP_YDISTANCE, Shift_UP_DN + 125);
         }
      }
   }
   if (Show_Smaller_Size == TRUE) {
      if (Show_Xtra_Details == TRUE) {
         if (Show_Price == FALSE) {
            ObjectCreate("LEVELS7", OBJ_LABEL, 0, 0, 0);
            ObjectSetText("LEVELS7", "Spread", 9, "Arial", CommentLabel_color);
            ObjectSet("LEVELS7", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
            ObjectSet("LEVELS7", OBJPROP_XDISTANCE, Adjust_Side_to_side + 40);
            ObjectSet("LEVELS7", OBJPROP_YDISTANCE, Shift_UP_DN + 60);
            ObjectCreate("LEVELS8", OBJ_LABEL, 0, 0, 0);
            ObjectSetText("LEVELS8", "" + Ls_892 + "", 9, "Arial Bold", Gold);
            ObjectSet("LEVELS8", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
            ObjectSet("LEVELS8", OBJPROP_XDISTANCE, Adjust_Side_to_side + 10);
            ObjectSet("LEVELS8", OBJPROP_YDISTANCE, Shift_UP_DN + 60);
            ObjectCreate("LEVELS9", OBJ_LABEL, 0, 0, 0);
            ObjectSetText("LEVELS9", "Pips to Open", 9, "Arial", CommentLabel_color);
            ObjectSet("LEVELS9", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
            ObjectSet("LEVELS9", OBJPROP_XDISTANCE, Adjust_Side_to_side + 40);
            ObjectSet("LEVELS9", OBJPROP_YDISTANCE, Shift_UP_DN + 75);
            ObjectCreate("LEVELS10", OBJ_LABEL, 0, 0, 0);
            ObjectSetText("LEVELS10", "" + Ls_900 + "", 9, "Arial Bold", color_956);
            ObjectSet("LEVELS10", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
            ObjectSet("LEVELS10", OBJPROP_XDISTANCE, Adjust_Side_to_side + 10);
            ObjectSet("LEVELS10", OBJPROP_YDISTANCE, Shift_UP_DN + 75);
            ObjectCreate("LEVELS11", OBJ_LABEL, 0, 0, 0);
            ObjectSetText("LEVELS11", "Hi to Low", 9, "Arial", CommentLabel_color);
            ObjectSet("LEVELS11", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
            ObjectSet("LEVELS11", OBJPROP_XDISTANCE, Adjust_Side_to_side + 40);
            ObjectSet("LEVELS11", OBJPROP_YDISTANCE, Shift_UP_DN + 90);
            ObjectCreate("LEVELS12", OBJ_LABEL, 0, 0, 0);
            ObjectSetText("LEVELS12", "" + Ls_916 + "", 9, "Arial Bold", HI_LO_color);
            ObjectSet("LEVELS12", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
            ObjectSet("LEVELS12", OBJPROP_XDISTANCE, Adjust_Side_to_side + 10);
            ObjectSet("LEVELS12", OBJPROP_YDISTANCE, Shift_UP_DN + 90);
            ObjectCreate("LEVELS13", OBJ_LABEL, 0, 0, 0);
            ObjectSetText("LEVELS13", "Daily Av", 9, "Arial", CommentLabel_color);
            ObjectSet("LEVELS13", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
            ObjectSet("LEVELS13", OBJPROP_XDISTANCE, Adjust_Side_to_side + 40);
            ObjectSet("LEVELS13", OBJPROP_YDISTANCE, Shift_UP_DN + 105);
            ObjectCreate("LEVELS14", OBJ_LABEL, 0, 0, 0);
            ObjectSetText("LEVELS14", "" + Ls_908 + "", 9, "Arial Bold", color_960);
            ObjectSet("LEVELS14", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
            ObjectSet("LEVELS14", OBJPROP_XDISTANCE, Adjust_Side_to_side + 10);
            ObjectSet("LEVELS14", OBJPROP_YDISTANCE, Shift_UP_DN + 105);
         }
      }
   }
   return (0);
}
