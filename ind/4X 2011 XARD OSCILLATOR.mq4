
#property indicator_separate_window
#property indicator_minimum 0.0
#property indicator_maximum 1.0
#property indicator_buffers 3
#property indicator_color1 Black
#property indicator_color2 Navy
#property indicator_color3 C'0x59,0x00,0x00'

double Gd_76;
double G_ibuf_84[];
double G_ibuf_88[];
double G_ibuf_92[];

int init() {
   SetIndexStyle(0, DRAW_NONE);
   SetIndexStyle(1, DRAW_HISTOGRAM);
   SetIndexStyle(2, DRAW_HISTOGRAM);
   IndicatorDigits(Digits + 1);
   SetIndexBuffer(0, G_ibuf_84);
   SetIndexBuffer(1, G_ibuf_88);
   SetIndexBuffer(2, G_ibuf_92);
   IndicatorShortName(" ");
   SetIndexLabel(0, NULL);
   SetIndexLabel(1, NULL);
   SetIndexLabel(2, NULL);
   switch (Period()) {
   case PERIOD_M5:
      Gd_76 = 252;
      break;
   case PERIOD_M15:
      Gd_76 = 84;
      break;
   case PERIOD_M30:
      Gd_76 = 42;
      break;
   default:
      Gd_76 = 21;
   }
   return (0);
}

int deinit() {
   Comment("");
   return (0);
}

int start() {
   double Ld_0;
   double Ld_8;
   double Ld_16;
   int Li_24 = IndicatorCounted();
   double Ld_28 = 0;
   double Ld_36 = 0;
   double Ld_unused_44 = 0;
   double Ld_unused_52 = 0;
   double Ld_60 = 0;
   double Ld_unused_68 = 0;
   double low_76 = 0;
   double high_84 = 0;
   if (Li_24 > 0) Li_24--;
   int Li_92 = Bars - Li_24;
   for (int Li_96 = 0; Li_96 < Bars; Li_96++) {
      high_84 = High[iHighest(NULL, 0, MODE_HIGH, Gd_76, Li_96)];
      low_76 = Low[iLowest(NULL, 0, MODE_LOW, Gd_76, Li_96)];
      Ld_16 = (High[Li_96] + Low[Li_96]) / 2.0;
      if (high_84 - low_76 == 0.0) Ld_28 = 0.6183399 * Ld_36 + (-0.3816601);
      else Ld_28 = 0.6183399 * ((Ld_16 - low_76) / (high_84 - low_76) - 0.5) + 0.6183399 * Ld_36;
      Ld_28 = MathMin(MathMax(Ld_28, -0.999), 0.999);
      if (1 - Ld_28 == 0.0) G_ibuf_84[Li_96] = Ld_60 / 2.0 + 0.5;
      else G_ibuf_84[Li_96] = MathLog((Ld_28 + 1.0) / (1 - Ld_28)) / 2.0 + Ld_60 / 2.0;
      Ld_36 = Ld_28;
      Ld_60 = G_ibuf_84[Li_96];
   }
   bool Li_100 = TRUE;
   for (Li_96 = Bars; Li_96 >= 0; Li_96--) {
      Ld_8 = G_ibuf_84[Li_96];
      Ld_0 = G_ibuf_84[Li_96 + 1];
      if ((Ld_8 < 0.0 && Ld_0 > 0.0) || Ld_8 < 0.0) Li_100 = FALSE;
      if ((Ld_8 > 0.0 && Ld_0 < 0.0) || Ld_8 > 0.0) Li_100 = TRUE;
      if (!Li_100) {
         G_ibuf_92[Li_96] = 1.0;
         G_ibuf_88[Li_96] = 0.0;
      } else {
         G_ibuf_88[Li_96] = 1.0;
         G_ibuf_92[Li_96] = 0.0;
      }
   }
   return (0);
}
