
#property copyright "й 2008 Kedr-Mts systems"
#property link      ""

#property indicator_chart_window
#property indicator_buffers 4
#property indicator_color1 Gold
#property indicator_color2 Red
#property indicator_color3 Blue
#property indicator_color4 Yellow

extern string BigEye_Alert_turning_point = "Do you want alert for turning points?";
extern bool ShowAlerts = FALSE;
extern bool SendEmails = FALSE;
extern string BigEye_Display = "Do you want to display the Glaz?";
extern bool Display_Eye = TRUE;
int gi_104 = 21;
int gi_108 = 13;
int gi_112 = 34;
int gi_116 = 1500;
int gi_120 = 0;
double g_ibuf_124[];
double g_ibuf_128[];
extern string HiLo_Dots = "=== Alert at the color dot change? ===";
extern bool SignalAlert = FALSE;
extern bool SendAlertEmail = FALSE;
extern string HiLoDots_Display = "Do you want to display the HiLo Dots?";
extern bool Display_HiLoDots = TRUE;
int gi_160 = 0;
int gi_164 = 0;
int gi_168 = 12;
double g_ibuf_172[];
double g_ibuf_176[];
double g_ibuf_180[];
extern string Lines = "=== Display the lines? ===";
extern bool Eyes_junction_lines = TRUE;
double g_ibuf_196[];
double g_ibuf_200[];
double g_ibuf_204[];
int gi_208 = 3;
bool gi_212 = FALSE;
extern string Zones = "=== Zones lines ===";
extern bool Display_Zones_lines = TRUE;
extern int CommentsZonesLinesFontSize = 7;
int gi_232 = 3;
extern color zone_31 = Olive;
int gi_240 = 3;
extern color zone_32 = Brown;
int gi_248 = 3;
extern color zone_33 = Purple;
extern string Daily_Support_and_Resistance = "=== Daily Support and resistance lines ===";
extern bool Display_DSRS_lines = TRUE;
extern int CommentsDSRLinesFontSize = 7;
extern color ResistanceColor = Red;
extern color SupportColor = Blue;
extern string Lines_Comments_Box = "=== Display the Lines Comments Box? ===";
extern bool DisplayZonesLinesBox = FALSE;
extern string Timer = "=== Display Dynamic Timer or fixed box? ===";
extern bool DisplayDynamicTimer = FALSE;
extern int DynamicTimerFontSize = 7;
extern color TimerColor = Yellow;
extern string HighLow_boxes = "=== High/Low boxes settings ===";
extern bool Display_HiLo_Boxes = FALSE;
extern bool Show_Values = FALSE;
extern int NumberOfDays = 50;
extern bool Background = FALSE;
extern color HL_Boxes_Color = DarkGreen;
string gs_unused_340 = "=== Display the Trade Info box? ===";
bool gi_348 = FALSE;
extern string TFS_indicator_box = "=== Trend Factor Scoreboard ===";
extern bool UseTFS = TRUE;
extern bool GlobalBox = FALSE;
extern int X_box = 0;
extern int Y_box = 0;
int gi_376 = 3;
int gi_380 = 3;
int gi_384 = 3;
int g_period_388 = 20;
int g_period_392 = 5;
int g_color_396 = CadetBlue;
int g_color_400 = Silver;
int g_color_404 = DimGray;
string gs_408;
string gs_416;
string gs_424;
string gs_432;
string gs_440;
string gs_dummy_448;
string gs_456;
string gs_464;
string gs_472;
string gs_480;
string gs_488;
string gs_496;
int g_day_504;
string gs_508;
int g_day_516;
int g_day_520;
string gs_524;
string gs_532;
string gs_540;
string gs_548;
string gs_556;
string gs_564;
string gs_572;
string gs_unused_580 = "=== Daily Pivots points ===";
bool gi_588 = FALSE;
bool g_bool_592 = FALSE;
double gda_596[][6];
double gd_600;
double gd_608;
double gd_616;
double g_price_624;
double g_price_632;
double g_price_640;
double g_price_648;
double g_price_656;
double g_price_664;
double g_price_672;
double g_price_680;
double g_price_688;
double g_price_696;
double g_price_704;
double g_price_712;
double g_price_720;
extern string Pivots_Dots = "=== Pivots Dots ===";
extern bool PivotsDots = FALSE;
extern int GMTshift = 0;
extern bool Plot_PIVOTS = TRUE;
extern bool Plot_M_Levels = TRUE;
extern int DOT_Type = 174;
extern color Central_PIVOT = Lime;
extern int PIVOT_Size = 2;
extern color R1_R2_R3 = Blue;
extern color S1_S2_S3 = Red;
extern int S_R_Levels_Size = 1;
extern color M0_M1_M2 = Red;
extern color M3_M4_M5 = Blue;
extern int MLevelS_Size = 0;
extern bool Show_StartTime = TRUE;
extern color REC_color = Blue;
double g_high_796;
double g_low_804;
double gd_unused_812;
double gd_unused_820;
double g_day_828;
double g_day_836;
double g_high_844 = 0.0;
double g_low_852 = 0.0;
double g_close_860 = 0.0;
int g_datetime_868;
int gi_872;
int gi_876;
int g_count_880;
int gi_884 = 0;

int init() {
   IndicatorBuffers(8);
   if (Display_Eye) {
      SetIndexStyle(0, DRAW_ARROW, STYLE_DASHDOT, 3);
      SetIndexArrow(0, 108);
      SetIndexBuffer(0, g_ibuf_124);
      SetIndexBuffer(4, g_ibuf_128);
      SetIndexEmptyValue(0, 0.0);
      ArraySetAsSeries(g_ibuf_124, TRUE);
      ArraySetAsSeries(g_ibuf_128, TRUE);
   }
   if (Display_HiLoDots) {
      SetIndexStyle(1, DRAW_ARROW, STYLE_SOLID, 1);
      SetIndexStyle(2, DRAW_ARROW, STYLE_SOLID, 1);
      SetIndexStyle(5, DRAW_NONE);
      SetIndexArrow(2, 159);
      SetIndexArrow(1, 159);
      SetIndexBuffer(5, g_ibuf_180);
      SetIndexBuffer(2, g_ibuf_176);
      SetIndexBuffer(1, g_ibuf_172);
      SetIndexEmptyValue(1, 0.0);
      SetIndexEmptyValue(2, 0.0);
      SetIndexEmptyValue(5, 0.0);
      GlobalVariableSet("Glaz Private AlertTime" + Symbol() + Period(), TimeCurrent());
      GlobalVariableSet("Glaz Private SignalType" + Symbol() + Period(), 5);
   }
   SetIndexStyle(3, DRAW_SECTION);
   SetIndexBuffer(3, g_ibuf_196);
   SetIndexBuffer(6, g_ibuf_200);
   SetIndexBuffer(7, g_ibuf_204);
   SetIndexEmptyValue(3, 0.0);
   IndicatorShortName("Glaz");
   watermark();
   DelObjs();
   return (0);
}

int deinit() {
   CleanUp();
   ObjectDelete("box_title");
   ObjectDelete("box_trade");
   ObjectDelete("timertitle");
   ObjectDelete("й 2008 Kedr-Mts");
   ObjectDelete("Glaz");
   ObjectDelete("logo_1");
   ObjectDelete("logo_2");
   GlobalVariableDel("Glaz Private AlertTime" + Symbol() + Period());
   GlobalVariableDel("Glaz Private SignalType" + Symbol() + Period());
   DelObjs();
   DelHiLoBox();
   ObjectsDeleteAll(0, OBJ_VLINE);
   ObjectsDeleteAll(0, OBJ_ARROW);
   ObjDel();
   Comment("");
   return (0);
}

int start() {
   int li_0;
   int li_4;
   int li_8;
   int li_12;
   int li_16;
   int li_20;
   int l_highest_24;
   int l_datetime_28;
   int l_shift_32;
   int l_highest_36;
   double l_ihigh_40;
   int l_datetime_48;
   int l_day_of_week_52;
   int l_day_56;
   int l_lowest_60;
   int l_datetime_64;
   int l_shift_68;
   int l_lowest_72;
   double l_ilow_76;
   int l_datetime_84;
   int l_day_of_week_88;
   int l_day_92;
   int l_highest_96;
   int l_datetime_100;
   int l_shift_104;
   int l_highest_108;
   double l_ihigh_112;
   int l_datetime_120;
   int l_month_124;
   int l_day_128;
   int l_lowest_132;
   int l_datetime_136;
   int l_shift_140;
   int l_lowest_144;
   double l_ilow_148;
   int l_datetime_156;
   int l_month_160;
   int l_day_164;
   int l_highest_168;
   int l_datetime_172;
   int l_shift_176;
   int l_highest_180;
   double l_ihigh_184;
   int l_datetime_192;
   int l_month_196;
   int l_day_200;
   int l_lowest_204;
   int l_datetime_208;
   int l_shift_212;
   int l_lowest_216;
   double l_ilow_220;
   int l_datetime_228;
   int l_month_232;
   int l_day_236;
   double l_ima_240;
   double l_ima_248;
   double l_iclose_256;
   int li_264;
   int li_268;
   int li_272;
   int li_276;
   int li_280;
   double ld_284;
   double ld_292;
   double ld_300;
   string ls_308;
   string ls_316;
   int li_324;
   int li_328;
   int li_332;
   string ls_336;
   double ld_360;
   double ld_368;
   double ld_376;
   double ld_384;
   double ld_392;
   double ld_400;
   int lia_408[2];
   double ld_416;
   string ls_424;
   int li_440;
   int l_highest_452;
   int l_lowest_456;
   double ld_460;
   double ld_468;
   double ld_492;
   double ld_500;
   int li_532;
   int l_ind_counted_536;
   int li_540;
   int li_544;
   int li_548;
   int li_560;
   int li_564;
   double ld_568;
   double ld_576;
   double ld_584;
   double ld_592;
   double ld_600;
   double ld_608;
   int li_620;
   int l_highest_624;
   double l_ihigh_628;
   int l_lowest_636;
   double l_ilow_640;
   int l_highest_648;
   double l_ihigh_652;
   int l_lowest_660;
   double l_ilow_664;
   int l_highest_672;
   double l_ihigh_676;
   int l_lowest_684;
   double l_ilow_688;
   double l_iclose_696;
   double l_iopen_704;
   double l_ihigh_712;
   double l_ilow_720;
   double ld_728;
   double ld_736;
   int l_day_of_week_748;
   string ls_752;
   string l_dbl2str_760;
   string l_dbl2str_768;
   double l_price_776;
   double ld_784;
   int l_count_792;
   int l_ord_total_800;
   double l_ord_open_price_804;
   double l_ord_lots_812;
   double l_ord_stoploss_820;
   double l_ord_takeprofit_828;
   CleanUp();
   if (gi_588) {
      ArrayInitialize(gda_596, 0);
      ArrayCopyRates(gda_596, Symbol(), PERIOD_D1);
      gd_608 = gda_596[1][3];
      gd_616 = gda_596[1][2];
      gd_600 = gda_596[1][4];
      g_price_624 = (gd_608 + gd_616 + gd_600) / 3.0;
      g_price_632 = 2.0 * g_price_624 - gd_616;
      g_price_640 = g_price_624 + (gd_608 - gd_616);
      g_price_648 = 2.0 * g_price_624 + (gd_608 - 2.0 * gd_616);
      g_price_656 = 2.0 * g_price_624 - gd_608;
      g_price_664 = g_price_624 - (gd_608 - gd_616);
      g_price_672 = 2.0 * g_price_624 - (2.0 * gd_608 - gd_616);
      g_price_680 = (g_price_624 + g_price_632) / 2.0;
      g_price_688 = (g_price_632 + g_price_640) / 2.0;
      g_price_696 = (g_price_640 + g_price_648) / 2.0;
      g_price_704 = (g_price_624 + g_price_656) / 2.0;
      g_price_712 = (g_price_656 + g_price_664) / 2.0;
      g_price_720 = (g_price_664 + g_price_672) / 2.0;
      ObjectCreate("Pivot1", OBJ_ARROW, 0, Time[0], g_price_624);
      ObjectSet("Pivot1", OBJPROP_ARROWCODE, 3);
      ObjectSet("Pivot1", OBJPROP_COLOR, Black);
      ObjectSet("Pivot1", OBJPROP_BACK, g_bool_592);
      ObjectCreate("Pivot2", OBJ_ARROW, 0, Time[0], g_price_624);
      ObjectSet("Pivot2", OBJPROP_ARROWCODE, 4);
      ObjectSet("Pivot2", OBJPROP_COLOR, Black);
      ObjectSet("Pivot2", OBJPROP_BACK, g_bool_592);
      ObjectCreate("PivR1", OBJ_ARROW, 0, Time[0], g_price_632);
      ObjectSet("PivR1", OBJPROP_ARROWCODE, 3);
      ObjectSet("PivR1", OBJPROP_COLOR, Blue);
      ObjectSet("PivR1", OBJPROP_BACK, g_bool_592);
      ObjectCreate("PivRMid1", OBJ_ARROW, 0, Time[0], g_price_680);
      ObjectSet("PivRMid1", OBJPROP_ARROWCODE, 4);
      ObjectSet("PivRMid1", OBJPROP_COLOR, Blue);
      ObjectSet("PivRMid1", OBJPROP_BACK, g_bool_592);
      ObjectCreate("PivR2", OBJ_ARROW, 0, Time[0], g_price_640);
      ObjectSet("PivR2", OBJPROP_ARROWCODE, 3);
      ObjectSet("PivR2", OBJPROP_COLOR, Blue);
      ObjectSet("PivR2", OBJPROP_BACK, g_bool_592);
      ObjectCreate("PivRMid2", OBJ_ARROW, 0, Time[0], g_price_688);
      ObjectSet("PivRMid2", OBJPROP_ARROWCODE, 4);
      ObjectSet("PivRMid2", OBJPROP_COLOR, Blue);
      ObjectSet("PivRMid2", OBJPROP_BACK, g_bool_592);
      ObjectCreate("PivR3", OBJ_ARROW, 0, Time[0], g_price_648);
      ObjectSet("PivR3", OBJPROP_ARROWCODE, 3);
      ObjectSet("PivR3", OBJPROP_COLOR, Blue);
      ObjectSet("PivR3", OBJPROP_BACK, g_bool_592);
      ObjectCreate("PivRMid3", OBJ_ARROW, 0, Time[0], g_price_696);
      ObjectSet("PivRMid3", OBJPROP_ARROWCODE, 4);
      ObjectSet("PivRMid3", OBJPROP_COLOR, Blue);
      ObjectSet("PivRMid3", OBJPROP_BACK, g_bool_592);
      ObjectCreate("PivS1", OBJ_ARROW, 0, Time[0], g_price_656);
      ObjectSet("PivS1", OBJPROP_ARROWCODE, 3);
      ObjectSet("PivS1", OBJPROP_COLOR, Red);
      ObjectSet("PivS1", OBJPROP_BACK, g_bool_592);
      ObjectCreate("PivSMid1", OBJ_ARROW, 0, Time[0], g_price_704);
      ObjectSet("PivSMid1", OBJPROP_ARROWCODE, 4);
      ObjectSet("PivSMid1", OBJPROP_COLOR, Red);
      ObjectSet("PivSMid1", OBJPROP_BACK, g_bool_592);
      ObjectCreate("PivS2", OBJ_ARROW, 0, Time[0], g_price_664);
      ObjectSet("PivS2", OBJPROP_ARROWCODE, 3);
      ObjectSet("PivS2", OBJPROP_COLOR, Red);
      ObjectSet("PivS2", OBJPROP_BACK, g_bool_592);
      ObjectCreate("PivSMid2", OBJ_ARROW, 0, Time[0], g_price_712);
      ObjectSet("PivSMid2", OBJPROP_ARROWCODE, 4);
      ObjectSet("PivSMid2", OBJPROP_COLOR, Red);
      ObjectSet("PivSMid2", OBJPROP_BACK, g_bool_592);
      ObjectCreate("PivS3", OBJ_ARROW, 0, Time[0], g_price_672);
      ObjectSet("PivS3", OBJPROP_ARROWCODE, 3);
      ObjectSet("PivS3", OBJPROP_COLOR, Red);
      ObjectSet("PivS3", OBJPROP_BACK, g_bool_592);
      ObjectCreate("PivSMid3", OBJ_ARROW, 0, Time[0], g_price_720);
      ObjectSet("PivSMid3", OBJPROP_ARROWCODE, 4);
      ObjectSet("PivSMid3", OBJPROP_COLOR, Red);
      ObjectSet("PivSMid3", OBJPROP_BACK, g_bool_592);
   }
   ObjectsRedraw();
   if (UseTFS) {
      li_0 = 0;
      li_4 = 0;
      li_8 = 0;
      li_12 = 0;
      li_16 = 0;
      RefreshRates();
      li_20 = 0;
      if (DayOfWeek() == 1) li_20 = 1;
      l_highest_24 = iHighest(NULL, PERIOD_D1, MODE_HIGH, gi_376 + li_20 + 1, 0);
      l_datetime_28 = iTime(NULL, PERIOD_D1, l_highest_24);
      l_shift_32 = iBarShift(NULL, PERIOD_M5, l_datetime_28);
      l_highest_36 = iHighest(NULL, PERIOD_M5, MODE_HIGH, l_shift_32, 0);
      l_ihigh_40 = iHigh(NULL, PERIOD_M5, l_highest_36);
      l_datetime_48 = iTime(NULL, PERIOD_M5, l_highest_36);
      l_day_of_week_52 = TimeDayOfWeek(l_datetime_48);
      l_day_56 = TimeDay(l_datetime_48);
      l_lowest_60 = iLowest(NULL, PERIOD_D1, MODE_LOW, gi_376 + li_20 + 1, 0);
      l_datetime_64 = iTime(NULL, PERIOD_D1, l_lowest_60);
      l_shift_68 = iBarShift(NULL, PERIOD_M5, l_datetime_64);
      l_lowest_72 = iLowest(NULL, PERIOD_M5, MODE_LOW, l_shift_68, 0);
      l_ilow_76 = iLow(NULL, PERIOD_M5, l_lowest_72);
      l_datetime_84 = iTime(NULL, PERIOD_M5, l_lowest_72);
      l_day_of_week_88 = TimeDayOfWeek(l_datetime_84);
      l_day_92 = TimeDay(l_datetime_84);
      if (l_datetime_48 > l_datetime_84) {
         gs_408 = "high";
         gs_416 = WeekDay(l_day_of_week_52);
         g_day_516 = l_day_56;
         gs_432 = TermDate(l_day_56);
         li_0 = 15;
         gs_524 = "+";
      }
      if (l_datetime_48 < l_datetime_84) {
         gs_408 = "low";
         gs_416 = WeekDay(l_day_of_week_88);
         g_day_516 = l_day_92;
         gs_432 = TermDate(l_day_92);
         li_0 = -15;
         gs_524 = "";
      }
      if (gi_376 == 1) gs_424 = "Day";
      else gs_424 = "Days";
      l_highest_96 = iHighest(NULL, PERIOD_W1, MODE_HIGH, gi_380 + 1, 0);
      l_datetime_100 = iTime(NULL, PERIOD_W1, l_highest_96);
      l_shift_104 = iBarShift(NULL, PERIOD_H1, l_datetime_100);
      l_highest_108 = iHighest(NULL, PERIOD_H1, MODE_HIGH, l_shift_104, 0);
      l_ihigh_112 = iHigh(NULL, PERIOD_H1, l_highest_108);
      l_datetime_120 = iTime(NULL, PERIOD_H1, l_highest_108);
      l_month_124 = TimeMonth(l_datetime_120);
      l_day_128 = TimeDay(l_datetime_120);
      l_lowest_132 = iLowest(NULL, PERIOD_W1, MODE_LOW, gi_380 + 1, 0);
      l_datetime_136 = iTime(NULL, PERIOD_W1, l_lowest_132);
      l_shift_140 = iBarShift(NULL, PERIOD_H1, l_datetime_136);
      l_lowest_144 = iLowest(NULL, PERIOD_H1, MODE_LOW, l_shift_140, 0);
      l_ilow_148 = iLow(NULL, PERIOD_H1, l_lowest_144);
      l_datetime_156 = iTime(NULL, PERIOD_H1, l_lowest_144);
      l_month_160 = TimeMonth(l_datetime_156);
      l_day_164 = TimeDay(l_datetime_156);
      if (l_datetime_120 > l_datetime_156) {
         gs_440 = "high";
         gs_508 = month(l_month_124);
         g_day_520 = l_day_128;
         gs_464 = TermDate(l_day_128);
         li_4 = 25;
         gs_532 = "+";
      }
      if (l_datetime_120 < l_datetime_156) {
         gs_440 = "low";
         gs_508 = month(l_month_160);
         g_day_520 = l_day_164;
         gs_464 = TermDate(l_day_164);
         li_4 = -25;
         gs_532 = "";
      }
      if (gi_380 == 1) gs_456 = "Week";
      else gs_456 = "Weeks";
      l_highest_168 = iHighest(NULL, PERIOD_MN1, MODE_HIGH, gi_384 + 1, 0);
      l_datetime_172 = iTime(NULL, PERIOD_MN1, l_highest_168);
      l_shift_176 = iBarShift(NULL, PERIOD_H1, l_datetime_172);
      l_highest_180 = iHighest(NULL, PERIOD_H1, MODE_HIGH, l_shift_176, 0);
      l_ihigh_184 = iHigh(NULL, PERIOD_H1, l_highest_180);
      l_datetime_192 = iTime(NULL, PERIOD_H1, l_highest_180);
      l_month_196 = TimeMonth(l_datetime_192);
      l_day_200 = TimeDay(l_datetime_192);
      l_lowest_204 = iLowest(NULL, PERIOD_MN1, MODE_LOW, gi_384 + 1, 0);
      l_datetime_208 = iTime(NULL, PERIOD_MN1, l_lowest_204);
      l_shift_212 = iBarShift(NULL, PERIOD_H1, l_datetime_208);
      l_lowest_216 = iLowest(NULL, PERIOD_H1, MODE_LOW, l_shift_212, 0);
      l_ilow_220 = iLow(NULL, PERIOD_H1, l_lowest_216);
      l_datetime_228 = iTime(NULL, PERIOD_H1, l_lowest_216);
      l_month_232 = TimeMonth(l_datetime_228);
      l_day_236 = TimeDay(l_datetime_228);
      if (l_datetime_192 > l_datetime_228) {
         gs_472 = "high";
         gs_480 = month(l_month_196);
         g_day_504 = l_day_200;
         gs_488 = TermDate(l_day_200);
         li_8 = 30;
         gs_540 = "+";
      }
      if (l_datetime_192 < l_datetime_228) {
         gs_472 = "low";
         gs_480 = month(l_month_232);
         g_day_504 = l_day_236;
         gs_488 = TermDate(l_day_236);
         li_8 = -30;
         gs_540 = "";
      }
      if (gi_384 == 1) gs_496 = "Month";
      else gs_496 = "Months";
      l_ima_240 = iMA(NULL, PERIOD_H1, g_period_392, 0, MODE_EMA, PRICE_CLOSE, 1);
      l_ima_248 = iMA(NULL, PERIOD_D1, g_period_388, 0, MODE_EMA, PRICE_CLOSE, 0);
      l_iclose_256 = iClose(NULL, PERIOD_H1, 1);
      if (l_iclose_256 > l_ima_240) {
         li_12 = 10;
         gs_548 = "+";
         gs_564 = ">";
      }
      if (l_iclose_256 < l_ima_240) {
         li_12 = -10;
         gs_548 = "";
         gs_564 = "<";
      }
      if (Bid > l_ima_248) {
         li_16 = 20;
         gs_556 = "+";
         gs_572 = ">";
      }
      if (Bid < l_ima_248) {
         li_16 = -20;
         gs_556 = "";
         gs_572 = "<";
      }
      if (li_0 > 0) {
         ld_292 += li_0;
         li_264 = 65280;
      } else {
         ld_300 += li_0;
         li_264 = 255;
      }
      if (li_4 > 0) {
         ld_292 += li_4;
         li_268 = 65280;
      } else {
         ld_300 += li_4;
         li_268 = 255;
      }
      if (li_8 > 0) {
         ld_292 += li_8;
         li_272 = 65280;
      } else {
         ld_300 += li_8;
         li_272 = 255;
      }
      if (li_12 > 0) {
         ld_292 += li_12;
         li_276 = 65280;
      } else {
         ld_300 += li_12;
         li_276 = 255;
      }
      if (li_16 > 0) {
         ld_292 += li_16;
         li_280 = 65280;
      } else {
         ld_300 += li_16;
         li_280 = 255;
      }
      if (MathAbs(ld_292) > MathAbs(ld_300)) {
         ld_284 = ld_292;
         ls_308 = "+";
      } else {
         ld_284 = ld_300;
         ls_308 = "";
      }
      ls_336 = StringSubstr(Symbol(), 0, 6);
      if (ld_284 == 55.0 || ld_284 == 60.0) {
         ls_316 = "Sideway trend";
         li_328 = 128;
         li_332 = 32768;
         li_324 = 32768;
      }
      if (ld_284 == 65.0 || ld_284 == 70.0) {
         ls_316 = "Weak UP trend";
         li_328 = 32768;
         li_332 = 65280;
         li_324 = 32768;
      }
      if (ld_284 == 75.0 || ld_284 == 80.0 || ld_284 == 85.0) {
         ls_316 = "UP trend";
         li_328 = 7451452;
         li_332 = 65280;
         li_324 = 7451452;
      }
      if (ld_284 == 90.0 || ld_284 == 100.0) {
         ls_316 = "Strong UP trend";
         li_328 = 65280;
         li_332 = 65280;
         li_324 = 65280;
      }
      if (ld_284 == -55.0 || ld_284 == -60.0) {
         ls_316 = "Sideway trend";
         li_328 = 32768;
         li_332 = 128;
         li_324 = 128;
      }
      if (ld_284 == -65.0 || ld_284 == -70.0) {
         ls_316 = "Weak DOWN trend";
         li_328 = 128;
         li_332 = 255;
         li_324 = 128;
      }
      if (ld_284 == -75.0 || ld_284 == -80.0 || ld_284 == -85.0) {
         ls_316 = "DOWN trend";
         li_328 = 1993170;
         li_332 = 255;
         li_324 = 1993170;
      }
      if (ld_284 == -90.0 || ld_284 == -100.0) {
         ls_316 = "Strong DOWN trend";
         li_328 = 255;
         li_332 = 255;
         li_324 = 255;
      }
      if (GlobalBox) TFS_display_global(ls_336, ls_308, ld_284, ls_316, li_328, li_332, li_324, li_276, li_12, li_264, li_0, li_280, li_16, li_272, li_8, li_268, li_4);
      if (!GlobalBox) TFS_display_small(ls_336, ls_308, ld_284, ls_316, li_328, li_332, li_324);
   }
   int li_344 = gi_116;
   for (li_344 = gi_116 - gi_104; li_344 > gi_120; li_344--) {
      ld_360 = Low[iLowest(NULL, 0, MODE_LOW, gi_104, li_344)];
      if (ld_360 == ld_400) ld_360 = 0.0;
      else {
         ld_400 = ld_360;
         if (Low[li_344] - ld_360 > gi_108 * Point) ld_360 = 0.0;
         else {
            for (int li_348 = 1; li_348 <= gi_112; li_348++) {
               ld_368 = g_ibuf_124[li_344 + li_348];
               if (ld_368 != 0.0 && ld_368 > ld_360) g_ibuf_124[li_344 + li_348] = 0.0;
            }
         }
      }
      g_ibuf_124[li_344] = ld_360;
      ld_360 = High[iHighest(NULL, 0, MODE_HIGH, gi_104, li_344)];
      if (ld_360 == ld_392) ld_360 = 0.0;
      else {
         ld_392 = ld_360;
         if (ld_360 - High[li_344] > gi_108 * Point) ld_360 = 0.0;
         else {
            for (li_348 = 1; li_348 <= gi_112; li_348++) {
               ld_368 = g_ibuf_128[li_344 + li_348];
               if (ld_368 != 0.0 && ld_368 < ld_360) g_ibuf_128[li_344 + li_348] = 0.0;
            }
         }
      }
      g_ibuf_128[li_344] = ld_360;
   }
   ld_392 = -1;
   int li_352 = -1;
   ld_400 = -1;
   int li_356 = -1;
   for (li_344 = gi_116 - gi_104; li_344 > gi_120; li_344--) {
      ld_376 = g_ibuf_124[li_344];
      ld_384 = g_ibuf_128[li_344];
      if (ld_376 == 0.0 && ld_384 == 0.0) continue;
      if (ld_384 != 0.0) {
         if (ld_392 > 0.0) {
            if (ld_392 < ld_384) g_ibuf_128[li_352] = 0;
            else g_ibuf_128[li_344] = 0;
         }
         if (ld_392 < ld_384 || ld_392 < 0.0) {
            ld_392 = ld_384;
            li_352 = li_344;
         }
         ld_400 = -1;
      }
      if (ld_376 != 0.0) {
         if (ld_400 > 0.0) {
            if (ld_400 > ld_376) g_ibuf_124[li_356] = 0;
            else g_ibuf_124[li_344] = 0;
         }
         if (ld_376 < ld_400 || ld_400 < 0.0) {
            ld_400 = ld_376;
            li_356 = li_344;
         }
         ld_392 = -1;
      }
   }
   for (li_344 = gi_116 - 1; li_344 > gi_120; li_344--) {
      if (li_344 >= gi_116 - gi_104) g_ibuf_124[li_344] = 0.0;
      else {
         ld_368 = g_ibuf_128[li_344];
         if (ld_368 != 0.0) g_ibuf_124[li_344] = ld_368;
      }
   }
   int l_index_412 = 0;
   for (li_344 = gi_120 + 1; l_index_412 < 2 && li_344 < gi_116; li_344++) {
      if (g_ibuf_124[li_344] != 0.0) {
         lia_408[l_index_412] = li_344;
         l_index_412++;
      }
   }
   if (l_index_412 > 0) {
      if (gi_884 != Time[lia_408[0]]) {
         gi_884 = Time[lia_408[0]];
         ld_416 = g_ibuf_124[lia_408[0]] - g_ibuf_124[lia_408[1]];
         if (ld_416 > 0.0) ls_424 = "Potential Turning Point SHORT [" + Period() + "] at " + Symbol() + ",bar = " + lia_408[0];
         else {
            if (ld_416 < 0.0) ls_424 = "Potential Turning Point LONG [" + Period() + "] at " + Symbol() + ",bar = " + lia_408[0];
            else
               if (l_index_412 == 1) ls_424 = "Antipate Turning Point[" + Period() + "] at " + Symbol() + ",bar = " + lia_408[0];
         }
         if (ShowAlerts) Alert(ls_424);
         if (SendEmails) SendMail("Message from: Z3 Turn Signals\n\n", ls_424);
      }
   }
   double ld_508 = 0;
   ArrayInitialize(g_ibuf_180, 0.0);
   ArrayInitialize(g_ibuf_172, 0.0);
   ArrayInitialize(g_ibuf_176, 0.0);
   int li_444 = Bars;
   int li_448 = Bars;
   double ld_484 = Low[Bars];
   double ld_476 = High[Bars];
   for (int li_436 = Bars - gi_168; li_436 >= 0; li_436--) {
      l_lowest_456 = iLowest(NULL, 0, MODE_LOW, gi_168, li_436);
      ld_460 = Low[l_lowest_456];
      l_highest_452 = iHighest(NULL, 0, MODE_HIGH, gi_168, li_436);
      ld_468 = High[l_highest_452];
      if (ld_460 >= ld_484) ld_484 = ld_460;
      else {
         if (li_444 > l_lowest_456) {
            g_ibuf_172[l_lowest_456] = ld_460;
            gi_160 = FALSE;
            gi_164 = TRUE;
            ld_492 = 100000;
            li_440 = li_444;
            for (int li_432 = li_444; li_432 >= l_lowest_456; li_432--) {
               if (g_ibuf_172[li_432] != 0.0) {
                  if (g_ibuf_172[li_432] < ld_492) {
                     ld_492 = g_ibuf_172[li_432];
                     li_440 = li_432;
                  }
                  g_ibuf_180[li_432] = 0.0;
               }
            }
            g_ibuf_180[li_440] = ld_492;
         }
         li_448 = l_lowest_456;
         ld_484 = ld_460;
      }
      if (ld_468 <= ld_476) ld_476 = ld_468;
      else {
         if (li_448 > l_highest_452) {
            g_ibuf_176[l_highest_452] = ld_468;
            gi_160 = TRUE;
            gi_164 = FALSE;
            ld_500 = -100000;
            li_440 = li_448;
            for (li_432 = li_448; li_432 >= l_highest_452; li_432--) {
               if (g_ibuf_176[li_432] != 0.0) {
                  if (g_ibuf_176[li_432] > ld_500) {
                     ld_500 = g_ibuf_176[li_432];
                     li_440 = li_432;
                  }
                  g_ibuf_180[li_432] = 0.0;
               }
            }
            g_ibuf_180[li_440] = ld_500;
         }
         li_444 = l_highest_452;
         ld_476 = ld_468;
      }
   }
   string ls_516 = "";
   double ld_524 = Period();
   if (ld_524 == 1.0) ls_516 = "M1";
   if (ld_524 == 5.0) ls_516 = "M5";
   if (ld_524 == 15.0) ls_516 = "M15";
   if (ld_524 == 30.0) ls_516 = "M30";
   if (ld_524 == 60.0) ls_516 = "H1";
   if (ld_524 == 240.0) ls_516 = "H4";
   if (ld_524 == 1440.0) ls_516 = "D1";
   if (ld_524 == 10080.0) ls_516 = "W1";
   if (ld_524 == 43200.0) ls_516 = "MN";
   if (gi_160 == TRUE && TimeCurrent() > GlobalVariableGet("Glaz Private AlertTime" + Symbol() + Period()) && GlobalVariableGet("Glaz Private SignalType" + Symbol() +
      Period()) != 0.0) {
      if (SignalAlert == TRUE) Alert("Signal BUY - ", Symbol(), " ", ls_516, " at ", TimeToStr(TimeCurrent(), TIME_SECONDS));
      if (SendAlertEmail) SendMail("Glaz signal", "Glaz BUY - " + Symbol() + " " + ls_516 + " at " + TimeToStr(TimeCurrent(), TIME_SECONDS) + " (server time)");
      ld_508 = TimeCurrent() + 60.0 * (Period() - MathMod(Minute(), Period()));
      GlobalVariableSet("Glaz Private AlertTime" + Symbol() + Period(), ld_508);
      GlobalVariableSet("Glaz Private SignalType" + Symbol() + Period(), 0);
   }
   if (gi_164 == TRUE && TimeCurrent() > GlobalVariableGet("Glaz Private AlertTime" + Symbol() + Period()) && GlobalVariableGet("Glaz Private SignalType" + Symbol() +
      Period()) != 1.0) {
      if (SignalAlert == TRUE) Alert("Signal SELL - ", Symbol(), " ", ls_516, " at ", TimeToStr(TimeCurrent(), TIME_SECONDS));
      if (SendAlertEmail) SendMail("Glaz signal", "Glaz SELL - " + Symbol() + " " + ls_516 + " at " + TimeToStr(TimeCurrent(), TIME_SECONDS) + " (server time)");
      ld_508 = TimeCurrent() + 60.0 * (Period() - MathMod(Minute(), Period()));
      GlobalVariableSet("Glaz Private AlertTime" + Symbol() + Period(), ld_508);
      GlobalVariableSet("Glaz Private SignalType" + Symbol() + Period(), 1);
   }
   if (Eyes_junction_lines) {
      l_ind_counted_536 = IndicatorCounted();
      if (l_ind_counted_536 == 0 && gi_212) {
         ArrayInitialize(g_ibuf_196, 0.0);
         ArrayInitialize(g_ibuf_200, 0.0);
         ArrayInitialize(g_ibuf_204, 0.0);
      }
      if (l_ind_counted_536 == 0) {
         li_540 = Bars - gi_104;
         gi_212 = TRUE;
      }
      if (l_ind_counted_536 > 0) {
         while (li_544 < gi_208 && li_532 < 100) {
            ld_576 = g_ibuf_196[li_532];
            if (ld_576 != 0.0) li_544++;
            li_532++;
         }
         li_532--;
         li_540 = li_532;
         if (g_ibuf_204[li_532] != 0.0) {
            ld_584 = g_ibuf_204[li_532];
            li_548 = 1;
         } else {
            ld_592 = g_ibuf_200[li_532];
            li_548 = -1;
         }
         for (li_532 = li_540 - 1; li_532 >= 0; li_532--) {
            g_ibuf_196[li_532] = 0.0;
            g_ibuf_204[li_532] = 0.0;
            g_ibuf_200[li_532] = 0.0;
         }
      }
      for (int li_552 = li_540; li_552 >= 0; li_552--) {
         ld_568 = Low[iLowest(NULL, 0, MODE_LOW, gi_104, li_552)];
         if (ld_568 == ld_608) ld_568 = 0.0;
         else {
            ld_608 = ld_568;
            if (Low[li_552] - ld_568 > gi_108 * Point) ld_568 = 0.0;
            else {
               for (int li_556 = 1; li_556 <= gi_112; li_556++) {
                  ld_576 = g_ibuf_204[li_552 + li_556];
                  if (ld_576 != 0.0 && ld_576 > ld_568) g_ibuf_204[li_552 + li_556] = 0.0;
               }
            }
         }
         if (Low[li_552] == ld_568) g_ibuf_204[li_552] = ld_568;
         else g_ibuf_204[li_552] = 0.0;
         ld_568 = High[iHighest(NULL, 0, MODE_HIGH, gi_104, li_552)];
         if (ld_568 == ld_600) ld_568 = 0.0;
         else {
            ld_600 = ld_568;
            if (ld_568 - High[li_552] > gi_108 * Point) ld_568 = 0.0;
            else {
               for (li_556 = 1; li_556 <= gi_112; li_556++) {
                  ld_576 = g_ibuf_200[li_552 + li_556];
                  if (ld_576 != 0.0 && ld_576 < ld_568) g_ibuf_200[li_552 + li_556] = 0.0;
               }
            }
         }
         if (High[li_552] == ld_568) g_ibuf_200[li_552] = ld_568;
         else g_ibuf_200[li_552] = 0.0;
      }
      if (li_548 == 0) {
         ld_608 = 0;
         ld_600 = 0;
      } else {
         ld_608 = ld_584;
         ld_600 = ld_592;
      }
      for (li_552 = li_540; li_552 >= 0; li_552--) {
         ld_576 = 0.0;
         switch (li_548) {
         case 0:
            if (ld_608 == 0.0 && ld_600 == 0.0) {
               if (g_ibuf_200[li_552] != 0.0) {
                  ld_600 = High[li_552];
                  li_560 = li_552;
                  li_548 = -1;
                  g_ibuf_196[li_552] = ld_600;
                  ld_576 = 1;
               }
               if (g_ibuf_204[li_552] != 0.0) {
                  ld_608 = Low[li_552];
                  li_564 = li_552;
                  li_548 = 1;
                  g_ibuf_196[li_552] = ld_608;
                  ld_576 = 1;
               }
            }
            break;
         case 1:
            if (g_ibuf_204[li_552] != 0.0 && g_ibuf_204[li_552] < ld_608 && g_ibuf_200[li_552] == 0.0) {
               g_ibuf_196[li_564] = 0.0;
               li_564 = li_552;
               ld_608 = g_ibuf_204[li_552];
               g_ibuf_196[li_552] = ld_608;
               ld_576 = 1;
            }
            if (g_ibuf_200[li_552] != 0.0 && g_ibuf_204[li_552] == 0.0) {
               ld_600 = g_ibuf_200[li_552];
               li_560 = li_552;
               g_ibuf_196[li_552] = ld_600;
               li_548 = -1;
               ld_576 = 1;
            }
            break;
         case -1:
            if (g_ibuf_200[li_552] != 0.0 && g_ibuf_200[li_552] > ld_600 && g_ibuf_204[li_552] == 0.0) {
               g_ibuf_196[li_560] = 0.0;
               li_560 = li_552;
               ld_600 = g_ibuf_200[li_552];
               g_ibuf_196[li_552] = ld_600;
            }
            if (g_ibuf_204[li_552] != 0.0 && g_ibuf_200[li_552] == 0.0) {
               ld_608 = g_ibuf_204[li_552];
               li_564 = li_552;
               g_ibuf_196[li_552] = ld_608;
               li_548 = 1;
            }
            break;
         default:
            return/*(WARN)*/;
         }
      }
   }
   if (Display_Zones_lines == TRUE) {
      RefreshRates();
      li_620 = 0;
      if (DayOfWeek() == 1) li_620 = 1;
      l_highest_624 = iHighest(NULL, PERIOD_D1, MODE_HIGH, gi_232 + li_620, 1);
      l_ihigh_628 = iHigh(NULL, PERIOD_D1, l_highest_624);
      l_lowest_636 = iLowest(NULL, PERIOD_D1, MODE_LOW, gi_232 + li_620, 1);
      l_ilow_640 = iLow(NULL, PERIOD_D1, l_lowest_636);
      ObjectCreate("zone_312", OBJ_TREND, 0, iTime(NULL, PERIOD_D1, gi_232 + li_620), l_ihigh_628, iTime(NULL, 0, 0), l_ihigh_628);
      ObjectSet("zone_312", OBJPROP_WIDTH, 1);
      ObjectSet("zone_312", OBJPROP_STYLE, STYLE_DASHDOT);
      ObjectSet("zone_312", OBJPROP_RAY, TRUE);
      ObjectSet("zone_312", OBJPROP_BACK, TRUE);
      ObjectSet("zone_312", OBJPROP_COLOR, zone_31);
      ObjectCreate("zone_312_value", OBJ_TEXT, 0, Time[0], l_ihigh_628);
      ObjectSetText("zone_312_value", "Zone 312 - " + DoubleToStr(l_ihigh_628, Digits), CommentsZonesLinesFontSize, "Verdana", zone_31);
      ObjectCreate("zone_311", OBJ_TREND, 0, iTime(NULL, PERIOD_D1, gi_232 + li_620), l_ilow_640, iTime(NULL, 0, 0), l_ilow_640);
      ObjectSet("zone_311", OBJPROP_WIDTH, 1);
      ObjectSet("zone_311", OBJPROP_STYLE, STYLE_DASHDOT);
      ObjectSet("zone_311", OBJPROP_RAY, TRUE);
      ObjectSet("zone_311", OBJPROP_BACK, TRUE);
      ObjectSet("zone_311", OBJPROP_COLOR, zone_31);
      ObjectCreate("zone_311_value", OBJ_TEXT, 0, Time[0], l_ilow_640);
      ObjectSetText("zone_311_value", "Zone 311 - " + DoubleToStr(l_ilow_640, Digits), CommentsZonesLinesFontSize, "Verdana", zone_31);
      l_highest_648 = iHighest(NULL, PERIOD_W1, MODE_HIGH, gi_240, 1);
      l_ihigh_652 = iHigh(NULL, PERIOD_W1, l_highest_648);
      l_lowest_660 = iLowest(NULL, PERIOD_W1, MODE_LOW, gi_240, 1);
      l_ilow_664 = iLow(NULL, PERIOD_W1, l_lowest_660);
      ObjectCreate("zone_322", OBJ_TREND, 0, iTime(NULL, PERIOD_W1, gi_240), l_ihigh_652, iTime(NULL, 0, 0), l_ihigh_652);
      ObjectSet("zone_322", OBJPROP_WIDTH, 1);
      ObjectSet("zone_322", OBJPROP_STYLE, STYLE_DASHDOT);
      ObjectSet("zone_322", OBJPROP_RAY, TRUE);
      ObjectSet("zone_322", OBJPROP_BACK, TRUE);
      ObjectSet("zone_322", OBJPROP_COLOR, zone_32);
      ObjectCreate("zone_322_value", OBJ_TEXT, 0, Time[24], l_ihigh_652);
      ObjectSetText("zone_322_value", "Zone 322 - " + DoubleToStr(l_ihigh_652, Digits), CommentsZonesLinesFontSize, "Verdana", zone_32);
      ObjectCreate("zone_321", OBJ_TREND, 0, iTime(NULL, PERIOD_W1, gi_240), l_ilow_664, iTime(NULL, 0, 0), l_ilow_664);
      ObjectSet("zone_321", OBJPROP_WIDTH, 1);
      ObjectSet("zone_321", OBJPROP_STYLE, STYLE_DASHDOT);
      ObjectSet("zone_321", OBJPROP_RAY, TRUE);
      ObjectSet("zone_321", OBJPROP_BACK, TRUE);
      ObjectSet("zone_321", OBJPROP_COLOR, zone_32);
      ObjectCreate("zone_321_value", OBJ_TEXT, 0, Time[24], l_ilow_664);
      ObjectSetText("zone_321_value", "Zone 321 - " + DoubleToStr(l_ilow_664, Digits), CommentsZonesLinesFontSize, "Verdana", zone_32);
      l_highest_672 = iHighest(NULL, PERIOD_MN1, MODE_HIGH, gi_248, 1);
      l_ihigh_676 = iHigh(NULL, PERIOD_MN1, l_highest_672);
      l_lowest_684 = iLowest(NULL, PERIOD_MN1, MODE_LOW, gi_248, 1);
      l_ilow_688 = iLow(NULL, PERIOD_MN1, l_lowest_684);
      ObjectCreate("zone_332", OBJ_TREND, 0, iTime(NULL, PERIOD_MN1, gi_248), l_ihigh_676, iTime(NULL, 0, 0), l_ihigh_676);
      ObjectSet("zone_332", OBJPROP_WIDTH, 1);
      ObjectSet("zone_332", OBJPROP_STYLE, STYLE_DASHDOT);
      ObjectSet("zone_332", OBJPROP_RAY, TRUE);
      ObjectSet("zone_332", OBJPROP_BACK, TRUE);
      ObjectSet("zone_332", OBJPROP_COLOR, zone_33);
      ObjectCreate("zone_332_value", OBJ_TEXT, 0, Time[48], l_ihigh_676);
      ObjectSetText("zone_332_value", "Zone 332 - " + DoubleToStr(l_ihigh_676, Digits), CommentsZonesLinesFontSize, "Verdana", zone_33);
      ObjectCreate("zone_331", OBJ_TREND, 0, iTime(NULL, PERIOD_MN1, gi_248), l_ilow_688, iTime(NULL, 0, 0), l_ilow_688);
      ObjectSet("zone_331", OBJPROP_WIDTH, 1);
      ObjectSet("zone_331", OBJPROP_STYLE, STYLE_DASHDOT);
      ObjectSet("zone_331", OBJPROP_RAY, TRUE);
      ObjectSet("zone_331", OBJPROP_BACK, TRUE);
      ObjectSet("zone_331", OBJPROP_COLOR, zone_33);
      ObjectCreate("zone_331_value", OBJ_TEXT, 0, Time[48], l_ilow_688);
      ObjectSetText("zone_331_value", "Zone 331 - " + DoubleToStr(l_ilow_688, Digits), CommentsZonesLinesFontSize, "Verdana", zone_33);
   }
   if (Display_DSRS_lines == TRUE) {
      DelObjs();
      l_iclose_696 = iClose(NULL, PERIOD_D1, 1);
      l_iopen_704 = iOpen(NULL, PERIOD_D1, 1);
      l_ihigh_712 = iHigh(NULL, PERIOD_D1, 1);
      l_ilow_720 = iLow(NULL, PERIOD_D1, 1);
      if (l_iclose_696 >= l_iopen_704) {
         DrawLine(l_ihigh_712, "zone_2", ResistanceColor);
         DrawLine(l_iopen_704, "zone_1", SupportColor);
         DrawText(l_iopen_704, "zone_1_text", "Zone 1", SupportColor);
         DrawText(l_ihigh_712, "zone_2_text", "Zone 2", ResistanceColor);
         ld_728 = l_ihigh_712;
         ld_736 = l_iopen_704;
      } else {
         DrawLine(l_iopen_704, "zone_2", ResistanceColor);
         DrawLine(l_ilow_720, "zone_1", SupportColor);
         DrawText(l_iopen_704, "zone_2_text", "Zone 2", ResistanceColor);
         DrawText(l_ilow_720, "zone_1_text", "Zone 1", SupportColor);
         ld_728 = l_iopen_704;
         ld_736 = l_ilow_720;
      }
   }
   if (DisplayZonesLinesBox) DrawCommentsLinesBox(l_ihigh_628, l_ilow_640, l_ihigh_652, l_ilow_664, l_ihigh_676, l_ilow_688, ld_728, ld_736);
   if (DisplayDynamicTimer) DrawDynamicTimer();
   else DrawTimerBox();
   if (Display_HiLo_Boxes) {
      for (int li_744 = 0; li_744 < NumberOfDays; li_744++) {
         l_day_of_week_748 = TimeDayOfWeek(iTime(NULL, PERIOD_D1, li_744));
         if (l_day_of_week_748 != 0 && l_day_of_week_748 != 6) DrawHiLoBoxes(li_744);
      }
   }
   if (gi_348) {
      l_count_792 = 0;
      l_ord_total_800 = OrdersTotal();
      for (int l_pos_796 = 0; l_pos_796 < l_ord_total_800; l_pos_796++) {
         OrderSelect(l_pos_796, SELECT_BY_POS, MODE_TRADES);
         if (OrderSymbol() == Symbol())
            if (OrderType() == OP_BUY || OrderType() == OP_SELL) l_count_792++;
      }
      if (l_count_792 == 1) {
         l_ord_open_price_804 = OrderOpenPrice();
         l_ord_lots_812 = OrderLots();
         if (OrderType() == OP_BUY) {
            ls_752 = "BUY:           ";
            l_price_776 = Bid;
            ld_784 = (l_price_776 - l_ord_open_price_804) / Point;
         }
         if (OrderType() == OP_SELL) {
            ls_752 = "SELL:           ";
            l_price_776 = Ask;
            ld_784 = (l_ord_open_price_804 - l_price_776) / Point;
         }
         l_ord_stoploss_820 = OrderStopLoss();
         if (l_ord_stoploss_820 == 0.0 || l_count_792 == 0) l_dbl2str_760 = "0";
         else l_dbl2str_760 = DoubleToStr((l_ord_stoploss_820 - l_price_776) / Point, 0);
         l_ord_takeprofit_828 = OrderTakeProfit();
         if (l_ord_takeprofit_828 == 0.0 || l_count_792 == 0) l_dbl2str_768 = "0";
         else l_dbl2str_768 = DoubleToStr((l_ord_takeprofit_828 - l_price_776) / Point, 0);
      } else {
         ls_752 = "No order:      ";
         l_dbl2str_760 = "0";
         l_dbl2str_768 = "0";
      }
      DrawTradeInfoBox(l_ord_open_price_804, l_ord_lots_812, ls_752, l_price_776, ld_784, l_dbl2str_760, l_dbl2str_768);
   }
   if (PivotsDots) CreateHL();
   return (0);
}

void watermark() {
   ObjectCreate("logo_1", OBJ_LABEL, 0, 0, 0);
   ObjectSetText("logo_1", ".:", 14, "Arial Black", Maroon);
   ObjectSet("logo_1", OBJPROP_CORNER, 2);
   ObjectSet("logo_1", OBJPROP_XDISTANCE, 5);
   ObjectSet("logo_1", OBJPROP_YDISTANCE, 1);
   ObjectCreate("logo_2", OBJ_LABEL, 0, 0, 0);
   ObjectSetText("logo_2", ":.", 14, "Arial Black", Green);
   ObjectSet("logo_2", OBJPROP_CORNER, 2);
   ObjectSet("logo_2", OBJPROP_XDISTANCE, 16);
   ObjectSet("logo_2", OBJPROP_YDISTANCE, 1);
   ObjectCreate("й 2008 Kedr-Mts", OBJ_LABEL, 0, 0, 0);
   ObjectSetText("й 2008 Kedr-Mts", "й 2008 Kedr-Mts", 7, "Arial Narrow", DimGray);
   ObjectSet("й 2008 Kedr-Mts", OBJPROP_CORNER, 2);
   ObjectSet("й 2008 Kedr-Mts", OBJPROP_XDISTANCE, 35);
   ObjectSet("й 2008 Kedr-Mts", OBJPROP_YDISTANCE, 12);
   ObjectCreate("Glaz", OBJ_LABEL, 0, 0, 0);
   ObjectSetText("Glaz", "Kedr", 7, "Arial Narrow", DimGray);
   ObjectSet("Glaz", OBJPROP_CORNER, 2);
   ObjectSet("Glaz", OBJPROP_XDISTANCE, 35);
   ObjectSet("Glaz", OBJPROP_YDISTANCE, 2);
}

void CleanUp() {
   ObjectDelete("zone_312");
   ObjectDelete("zone_312_value");
   ObjectDelete("zone_311");
   ObjectDelete("zone_311_value");
   ObjectDelete("zone_322");
   ObjectDelete("zone_322_value");
   ObjectDelete("zone_321");
   ObjectDelete("zone_321_value");
   ObjectDelete("zone_332");
   ObjectDelete("zone_332_value");
   ObjectDelete("zone_331");
   ObjectDelete("zone_331_value");
   ObjectDelete("lin1");
   ObjectDelete("zone2");
   ObjectDelete("zone312");
   ObjectDelete("zone322");
   ObjectDelete("zone332");
   ObjectDelete("lin2");
   ObjectDelete("zone1");
   ObjectDelete("zone311");
   ObjectDelete("zone321");
   ObjectDelete("zone331");
   ObjectDelete("lin3");
   ObjectDelete("timer");
   ObjectDelete("lin01");
   ObjectDelete("type_lot");
   ObjectDelete("entry");
   ObjectDelete("current");
   ObjectDelete("profit");
   ObjectDelete("lin02");
   ObjectDelete("take");
   ObjectDelete("stop");
   ObjectDelete("lin03");
   ObjectDelete("spread_");
   ObjectDelete("pipvalue_");
   ObjectDelete("lin04");
   ObjectDelete("_symbol_");
   ObjectDelete("_line1");
   ObjectDelete("trend_logo_1");
   ObjectDelete("trend_logo_2");
   ObjectDelete("trend_comment");
   ObjectDelete("trend_value");
   ObjectDelete("_line2");
   ObjectDelete("maf_logo");
   ObjectDelete("maf_logo2");
   ObjectDelete("maf_score");
   ObjectDelete("maf_comment");
   ObjectDelete("day_logo");
   ObjectDelete("day_logo2");
   ObjectDelete("day_score");
   ObjectDelete("day_comment");
   ObjectDelete("mas_logo");
   ObjectDelete("mas_logo2");
   ObjectDelete("mas_score");
   ObjectDelete("mas_comment");
   ObjectDelete("week_logo");
   ObjectDelete("week_logo2");
   ObjectDelete("week_score");
   ObjectDelete("week_comment");
   ObjectDelete("month_logo");
   ObjectDelete("month_logo2");
   ObjectDelete("month_score");
   ObjectDelete("month_comment");
   ObjectDelete("_line3");
   ObjectDelete("copyright");
   ObjectDelete("Pivot1");
   ObjectDelete("Pivot2");
   ObjectDelete("PivR1");
   ObjectDelete("PivRMid1");
   ObjectDelete("PivR2");
   ObjectDelete("PivRMid2");
   ObjectDelete("PivR3");
   ObjectDelete("PivRMid3");
   ObjectDelete("PivS1");
   ObjectDelete("PivSMid1");
   ObjectDelete("PivS2");
   ObjectDelete("PivSMid2");
   ObjectDelete("PivS3");
   ObjectDelete("PivSMid3");
}

int DrawLine(double a_price_0, string a_name_8, color a_color_16) {
   if (ObjectFind(a_name_8) != 0) {
      ObjectCreate(a_name_8, OBJ_TREND, 0, 0, a_price_0, Time[0], a_price_0);
      ObjectSet(a_name_8, OBJPROP_RAY, TRUE);
      ObjectSet(a_name_8, OBJPROP_BACK, TRUE);
      ObjectSet(a_name_8, OBJPROP_COLOR, a_color_16);
   } else {
      ObjectSet(a_name_8, OBJPROP_TIME1, 0);
      ObjectSet(a_name_8, OBJPROP_PRICE1, a_price_0);
      ObjectSet(a_name_8, OBJPROP_TIME2, Time[0]);
      ObjectSet(a_name_8, OBJPROP_PRICE2, a_price_0);
   }
   ObjectsRedraw();
   return (0);
}

int DrawText(double ad_0, string as_8, string as_16, color a_color_24) {
   string l_name_32;
   int l_objs_total_28 = ObjectsTotal();
   for (int li_40 = ObjectsTotal() - 1; li_40 >= 0; li_40--) {
      l_name_32 = ObjectName(li_40);
      if (StringFind(l_name_32, as_8, 0) > -1) {
         ObjectMove(as_8, 0, iTime(NULL, 0, 0) + 1440 * Period(), ad_0);
         ObjectsRedraw();
         return (1);
      }
   }
   ObjectCreate(as_8, OBJ_TEXT, 0, iTime(NULL, 0, 0) + 1440 * Period(), ad_0);
   ObjectSetText(as_8, as_16 + " - " + DoubleToStr(ad_0, Digits), CommentsDSRLinesFontSize, "Verdana", a_color_24);
   ObjectsRedraw();
   return (0);
}

void DelObjs() {
   string l_name_4;
   int l_objs_total_0 = ObjectsTotal();
   for (int li_12 = ObjectsTotal() - 1; li_12 >= 0; li_12--) {
      l_name_4 = ObjectName(li_12);
      if (StringFind(l_name_4, "zone_2", 0) > -1) ObjectDelete(l_name_4);
      if (StringFind(l_name_4, "zone_1", 0) > -1) ObjectDelete(l_name_4);
      ObjectsRedraw();
   }
}

int DrawCommentsLinesBox(double ad_0, double ad_8, double ad_16, double ad_24, double ad_32, double ad_40, double ad_48, double ad_56) {
   double l_x_64 = ObjectGet("box_title", OBJPROP_XDISTANCE);
   double l_y_72 = ObjectGet("box_title", OBJPROP_YDISTANCE);
   if (ObjectFind("box_title") != 0) {
      ObjectCreate("box_title", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("box_title", "Zones Values", 7, "Arial Black", CadetBlue);
      ObjectSet("box_title", OBJPROP_CORNER, 0);
      ObjectSet("box_title", OBJPROP_XDISTANCE, 5);
      ObjectSet("box_title", OBJPROP_YDISTANCE, 22);
   } else {
      ObjectSet("box_title", OBJPROP_XDISTANCE, l_x_64);
      ObjectSet("box_title", OBJPROP_YDISTANCE, l_y_72);
   }
   l_x_64 = ObjectGet("box_title", OBJPROP_XDISTANCE);
   l_y_72 = ObjectGet("box_title", OBJPROP_YDISTANCE);
   if (ObjectFind("lin1") != 0) {
      ObjectCreate("lin1", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("lin1", "-------------------------", 9, "Arial", DimGray);
      ObjectSet("lin1", OBJPROP_CORNER, 0);
      ObjectSet("lin1", OBJPROP_XDISTANCE, l_x_64);
      ObjectSet("lin1", OBJPROP_YDISTANCE, l_y_72 + 7.0);
   } else {
      ObjectSet("lin1", OBJPROP_XDISTANCE, l_x_64);
      ObjectSet("lin1", OBJPROP_YDISTANCE, l_y_72 + 7.0);
   }
   if (ObjectFind("zone2") != 0) {
      ObjectCreate("zone2", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("zone2", "Zone 2      - " + DoubleToStr(ad_48, Digits), 7, "Verdana", ResistanceColor);
      ObjectSet("zone2", OBJPROP_CORNER, 0);
      ObjectSet("zone2", OBJPROP_XDISTANCE, l_x_64);
      ObjectSet("zone2", OBJPROP_YDISTANCE, l_y_72 + 20.0);
   } else {
      ObjectSet("zone2", OBJPROP_XDISTANCE, l_x_64);
      ObjectSet("zone2", OBJPROP_YDISTANCE, l_y_72 + 20.0);
   }
   if (ObjectFind("zone312") != 0) {
      ObjectCreate("zone312", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("zone312", "Zone 312 - " + DoubleToStr(ad_0, Digits), 7, "Verdana", zone_31);
      ObjectSet("zone312", OBJPROP_CORNER, 0);
      ObjectSet("zone312", OBJPROP_XDISTANCE, l_x_64);
      ObjectSet("zone312", OBJPROP_YDISTANCE, l_y_72 + 35.0);
   } else {
      ObjectSet("zone312", OBJPROP_XDISTANCE, l_x_64);
      ObjectSet("zone312", OBJPROP_YDISTANCE, l_y_72 + 35.0);
   }
   if (ObjectFind("zone322") != 0) {
      ObjectCreate("zone322", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("zone322", "Zone 322 - " + DoubleToStr(ad_16, Digits), 7, "Verdana", zone_32);
      ObjectSet("zone322", OBJPROP_CORNER, 0);
      ObjectSet("zone322", OBJPROP_XDISTANCE, l_x_64);
      ObjectSet("zone322", OBJPROP_YDISTANCE, l_y_72 + 50.0);
   } else {
      ObjectSet("zone322", OBJPROP_XDISTANCE, l_x_64);
      ObjectSet("zone322", OBJPROP_YDISTANCE, l_y_72 + 50.0);
   }
   if (ObjectFind("zone332") != 0) {
      ObjectCreate("zone332", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("zone332", "Zone 332 - " + DoubleToStr(ad_32, Digits), 7, "Verdana", zone_33);
      ObjectSet("zone332", OBJPROP_CORNER, 0);
      ObjectSet("zone332", OBJPROP_XDISTANCE, l_x_64);
      ObjectSet("zone332", OBJPROP_YDISTANCE, l_y_72 + 65.0);
   } else {
      ObjectSet("zone332", OBJPROP_XDISTANCE, l_x_64);
      ObjectSet("zone332", OBJPROP_YDISTANCE, l_y_72 + 65.0);
   }
   if (ObjectFind("lin2") != 0) {
      ObjectCreate("lin2", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("lin2", "-------------------------", 9, "Arial", DimGray);
      ObjectSet("lin2", OBJPROP_CORNER, 0);
      ObjectSet("lin2", OBJPROP_XDISTANCE, l_x_64);
      ObjectSet("lin2", OBJPROP_YDISTANCE, l_y_72 + 75.0);
   } else {
      ObjectSet("lin2", OBJPROP_XDISTANCE, l_x_64);
      ObjectSet("lin2", OBJPROP_YDISTANCE, l_y_72 + 75.0);
   }
   if (ObjectFind("zone1") != 0) {
      ObjectCreate("zone1", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("zone1", "Zone 1     - " + DoubleToStr(ad_56, Digits), 7, "Verdana", SupportColor);
      ObjectSet("zone1", OBJPROP_CORNER, 0);
      ObjectSet("zone1", OBJPROP_XDISTANCE, l_x_64);
      ObjectSet("zone1", OBJPROP_YDISTANCE, l_y_72 + 88.0);
   } else {
      ObjectSet("zone1", OBJPROP_XDISTANCE, l_x_64);
      ObjectSet("zone1", OBJPROP_YDISTANCE, l_y_72 + 88.0);
   }
   if (ObjectFind("zone311") != 0) {
      ObjectCreate("zone311", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("zone311", "Zone 311 - " + DoubleToStr(ad_8, Digits), 7, "Verdana", zone_31);
      ObjectSet("zone311", OBJPROP_CORNER, 0);
      ObjectSet("zone311", OBJPROP_XDISTANCE, l_x_64);
      ObjectSet("zone311", OBJPROP_YDISTANCE, l_y_72 + 103.0);
   } else {
      ObjectSet("zone311", OBJPROP_XDISTANCE, l_x_64);
      ObjectSet("zone311", OBJPROP_YDISTANCE, l_y_72 + 103.0);
   }
   if (ObjectFind("zone321") != 0) {
      ObjectCreate("zone321", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("zone321", "Zone 321 - " + DoubleToStr(ad_24, Digits), 7, "Verdana", zone_32);
      ObjectSet("zone321", OBJPROP_CORNER, 0);
      ObjectSet("zone321", OBJPROP_XDISTANCE, l_x_64);
      ObjectSet("zone321", OBJPROP_YDISTANCE, l_y_72 + 118.0);
   } else {
      ObjectSet("zone321", OBJPROP_XDISTANCE, l_x_64);
      ObjectSet("zone321", OBJPROP_YDISTANCE, l_y_72 + 118.0);
   }
   if (ObjectFind("zone331") != 0) {
      ObjectCreate("zone331", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("zone331", "Zone 331 - " + DoubleToStr(ad_40, Digits), 7, "Verdana", zone_33);
      ObjectSet("zone331", OBJPROP_CORNER, 0);
      ObjectSet("zone331", OBJPROP_XDISTANCE, l_x_64);
      ObjectSet("zone331", OBJPROP_YDISTANCE, l_y_72 + 133.0);
   } else {
      ObjectSet("zone331", OBJPROP_XDISTANCE, l_x_64);
      ObjectSet("zone331", OBJPROP_YDISTANCE, l_y_72 + 133.0);
   }
   if (ObjectFind("lin3") != 0) {
      ObjectCreate("lin3", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("lin3", "-------------------------", 9, "Arial", DimGray);
      ObjectSet("lin3", OBJPROP_CORNER, 0);
      ObjectSet("lin3", OBJPROP_XDISTANCE, l_x_64);
      ObjectSet("lin3", OBJPROP_YDISTANCE, l_y_72 + 143.0);
   } else {
      ObjectSet("lin3", OBJPROP_XDISTANCE, l_x_64);
      ObjectSet("lin3", OBJPROP_YDISTANCE, l_y_72 + 143.0);
   }
   return (0);
}

void DrawDynamicTimer() {
   int li_0 = Time[0] + 60 * Period() - TimeCurrent();
   ObjectCreate("timer", OBJ_TEXT, 0, 0, 0);
   ObjectSetText("timer", "<--- " + TimeToStr(li_0, TIME_SECONDS), DynamicTimerFontSize, "Verdana", TimerColor);
   if (DynamicTimerFontSize > 8) ObjectMove("timer", 0, iTime(NULL, 0, 0) + 1200 * Period(), Bid);
   if (DynamicTimerFontSize <= 8) ObjectMove("timer", 0, iTime(NULL, 0, 0) + 660 * Period(), Bid);
}

void DrawTimerBox() {
   int li_0 = Time[0] + 60 * Period() - TimeCurrent();
   double l_x_4 = ObjectGet("timertitle", OBJPROP_XDISTANCE);
   double l_y_12 = ObjectGet("timertitle", OBJPROP_YDISTANCE);
   if (ObjectFind("timertitle") != 0) {
      ObjectCreate("timertitle", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("timertitle", "Time Left", 12, "Arial Black", CadetBlue);
      ObjectSet("timertitle", OBJPROP_CORNER, 3);
      ObjectSet("timertitle", OBJPROP_XDISTANCE, 8);
      ObjectSet("timertitle", OBJPROP_YDISTANCE, 160);
   } else {
      ObjectSet("timertitle", OBJPROP_XDISTANCE, l_x_4);
      ObjectSet("timertitle", OBJPROP_YDISTANCE, l_y_12);
   }
   l_x_4 = ObjectGet("timertitle", OBJPROP_XDISTANCE);
   l_y_12 = ObjectGet("timertitle", OBJPROP_YDISTANCE);
   if (ObjectFind("timer") != 0) {
      ObjectCreate("timer", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("timer", TimeToStr(li_0, TIME_SECONDS), 12, "Arial Black", TimerColor);
      ObjectSet("timer", OBJPROP_CORNER, 3);
      ObjectSet("timer", OBJPROP_XDISTANCE, l_x_4 + 2.0);
      ObjectSet("timer", OBJPROP_YDISTANCE, l_y_12 - 15.0);
      return;
   }
   ObjectSet("timer", OBJPROP_XDISTANCE, l_x_4 + 2.0);
   ObjectSet("timer", OBJPROP_YDISTANCE, l_y_12 - 15.0);
}

void DrawHiLoBoxes(int ai_0) {
   double ld_4;
   if (ai_0 > 0) {
      ObjectCreate("hilo_box" + ai_0, OBJ_RECTANGLE, 0, 0, 0, 0, 0);
      ObjectSet("hilo_box" + ai_0, OBJPROP_TIME1, iTime(NULL, PERIOD_D1, ai_0));
      ObjectSet("hilo_box" + ai_0, OBJPROP_PRICE1, iHigh(NULL, PERIOD_D1, ai_0));
      ObjectSet("hilo_box" + ai_0, OBJPROP_TIME2, iTime(NULL, PERIOD_D1, ai_0) + 86400);
      ObjectSet("hilo_box" + ai_0, OBJPROP_PRICE2, iLow(NULL, PERIOD_D1, ai_0));
      ObjectSet("hilo_box" + ai_0, OBJPROP_STYLE, STYLE_DOT);
      ObjectSet("hilo_box" + ai_0, OBJPROP_COLOR, HL_Boxes_Color);
      ObjectSet("hilo_box" + ai_0, OBJPROP_BACK, Background);
      if (Show_Values) {
         ld_4 = (iHigh(NULL, PERIOD_D1, ai_0) - iLow(NULL, PERIOD_D1, ai_0)) / Point;
         ObjectCreate("hilo_box_value" + ai_0, OBJ_TEXT, 0, 0, 0);
         ObjectSetText("hilo_box_value" + ai_0, "Day Range - " + DoubleToStr(ld_4, 0), 7, "Verdana", Silver);
         ObjectMove("hilo_box_value" + ai_0, 0, iTime(NULL, PERIOD_D1, ai_0) + 60 * (10 * Period()), iHigh(NULL, PERIOD_D1, ai_0) + 15.0 * Point);
      }
   } else {
      ObjectCreate("hilo_box" + 0, OBJ_RECTANGLE, 0, 0, 0, 0, 0);
      ObjectSet("hilo_box" + 0, OBJPROP_TIME1, iTime(NULL, PERIOD_D1, 0));
      ObjectSet("hilo_box" + 0, OBJPROP_PRICE1, iHigh(NULL, PERIOD_D1, 0));
      ObjectSet("hilo_box" + 0, OBJPROP_TIME2, iTime(NULL, 0, 0));
      ObjectSet("hilo_box" + 0, OBJPROP_PRICE2, iLow(NULL, PERIOD_D1, 0));
      ObjectSet("hilo_box" + 0, OBJPROP_STYLE, STYLE_DOT);
      ObjectSet("hilo_box" + 0, OBJPROP_COLOR, HL_Boxes_Color);
      ObjectSet("hilo_box" + 0, OBJPROP_BACK, Background);
      if (Show_Values) {
         ld_4 = (iHigh(NULL, PERIOD_D1, 0) - iLow(NULL, PERIOD_D1, 0)) / Point;
         ObjectCreate("hilo_box_value" + 0, OBJ_TEXT, 0, 0, 0);
         ObjectSetText("hilo_box_value" + 0, "Day Range - " + DoubleToStr(ld_4, 0), 7, "Verdana", Silver);
         ObjectMove("hilo_box_value" + 0, 0, iTime(NULL, PERIOD_D1, 0) + 60 * (10 * Period()), iHigh(NULL, PERIOD_D1, 0) + 15.0 * Point);
      }
   }
}

void DelHiLoBox() {
   string l_name_4;
   int l_objs_total_0 = ObjectsTotal();
   for (int li_12 = ObjectsTotal() - 1; li_12 >= 0; li_12--) {
      l_name_4 = ObjectName(li_12);
      if (StringFind(l_name_4, "hilo_box", 0) > -1) ObjectDelete(l_name_4);
      ObjectsRedraw();
   }
}

void DrawTradeInfoBox(double ad_0, double ad_8, string as_16, double ad_24, double ad_32, string as_40, string as_48) {
   string ls_56 = StringSubstr(Symbol(), 0, 6);
   string ls_64 = "";
   double l_timeframe_72 = Period();
   if (l_timeframe_72 == 1.0) ls_64 = "M1";
   if (l_timeframe_72 == 5.0) ls_64 = "M5";
   if (l_timeframe_72 == 15.0) ls_64 = "M15";
   if (l_timeframe_72 == 30.0) ls_64 = "M30";
   if (l_timeframe_72 == 60.0) ls_64 = "H1";
   if (l_timeframe_72 == 240.0) ls_64 = "H4";
   if (l_timeframe_72 == 1440.0) ls_64 = "D1";
   if (l_timeframe_72 == 10080.0) ls_64 = "W1";
   if (l_timeframe_72 == 43200.0) ls_64 = "MN";
   double l_x_80 = ObjectGet("box_trade", OBJPROP_XDISTANCE);
   double l_y_88 = ObjectGet("box_trade", OBJPROP_YDISTANCE);
   if (ObjectFind("box_trade") != 0) {
      ObjectCreate("box_trade", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("box_trade", ls_56 + " " + ls_64 + " - Trade Info", 7, "Arial Black", CadetBlue);
      ObjectSet("box_trade", OBJPROP_CORNER, 0);
      ObjectSet("box_trade", OBJPROP_XDISTANCE, 135);
      ObjectSet("box_trade", OBJPROP_YDISTANCE, 22);
   } else {
      ObjectSet("box_trade", OBJPROP_XDISTANCE, l_x_80);
      ObjectSet("box_trade", OBJPROP_YDISTANCE, l_y_88);
   }
   l_x_80 = ObjectGet("box_trade", OBJPROP_XDISTANCE);
   l_y_88 = ObjectGet("box_trade", OBJPROP_YDISTANCE);
   if (ObjectFind("lin01") != 0) {
      ObjectCreate("lin01", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("lin01", "-----------------------------", 9, "Arial", DimGray);
      ObjectSet("lin01", OBJPROP_CORNER, 0);
      ObjectSet("lin01", OBJPROP_XDISTANCE, l_x_80);
      ObjectSet("lin01", OBJPROP_YDISTANCE, l_y_88 + 7.0);
   } else {
      ObjectSet("lin01", OBJPROP_XDISTANCE, l_x_80);
      ObjectSet("lin01", OBJPROP_YDISTANCE, l_y_88 + 7.0);
   }
   if (ObjectFind("type_lot") != 0) {
      ObjectCreate("type_lot", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("type_lot", as_16 + DoubleToStr(ad_8, 2) + " lot", 7, "Verdana", Silver);
      ObjectSet("type_lot", OBJPROP_CORNER, 0);
      ObjectSet("type_lot", OBJPROP_XDISTANCE, l_x_80);
      ObjectSet("type_lot", OBJPROP_YDISTANCE, l_y_88 + 20.0);
   } else {
      ObjectSet("type_lot", OBJPROP_XDISTANCE, l_x_80);
      ObjectSet("type_lot", OBJPROP_YDISTANCE, l_y_88 + 20.0);
   }
   if (ObjectFind("entry") != 0) {
      ObjectCreate("entry", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("entry", "Entry:           " + DoubleToStr(ad_0, Digits), 7, "Verdana", Silver);
      ObjectSet("entry", OBJPROP_CORNER, 0);
      ObjectSet("entry", OBJPROP_XDISTANCE, l_x_80);
      ObjectSet("entry", OBJPROP_YDISTANCE, l_y_88 + 35.0);
   } else {
      ObjectSet("entry", OBJPROP_XDISTANCE, l_x_80);
      ObjectSet("entry", OBJPROP_YDISTANCE, l_y_88 + 35.0);
   }
   if (ObjectFind("current") != 0) {
      ObjectCreate("current", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("current", "Price:           " + DoubleToStr(ad_24, Digits), 7, "Verdana", Silver);
      ObjectSet("current", OBJPROP_CORNER, 0);
      ObjectSet("current", OBJPROP_XDISTANCE, l_x_80);
      ObjectSet("current", OBJPROP_YDISTANCE, l_y_88 + 50.0);
   } else {
      ObjectSet("current", OBJPROP_XDISTANCE, l_x_80);
      ObjectSet("current", OBJPROP_YDISTANCE, l_y_88 + 50.0);
   }
   if (ObjectFind("profit") != 0) {
      ObjectCreate("profit", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("profit", "Profit:           " + DoubleToStr(ad_32, 0) + " pips", 7, "Verdana", Silver);
      ObjectSet("profit", OBJPROP_CORNER, 0);
      ObjectSet("profit", OBJPROP_XDISTANCE, l_x_80);
      ObjectSet("profit", OBJPROP_YDISTANCE, l_y_88 + 65.0);
   } else {
      ObjectSet("profit", OBJPROP_XDISTANCE, l_x_80);
      ObjectSet("profit", OBJPROP_YDISTANCE, l_y_88 + 65.0);
   }
   if (ObjectFind("lin02") != 0) {
      ObjectCreate("lin02", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("lin02", "-----------------------------", 9, "Arial", DimGray);
      ObjectSet("lin02", OBJPROP_CORNER, 0);
      ObjectSet("lin02", OBJPROP_XDISTANCE, l_x_80);
      ObjectSet("lin02", OBJPROP_YDISTANCE, l_y_88 + 75.0);
   } else {
      ObjectSet("lin02", OBJPROP_XDISTANCE, l_x_80);
      ObjectSet("lin02", OBJPROP_YDISTANCE, l_y_88 + 75.0);
   }
   if (ObjectFind("take") != 0) {
      ObjectCreate("take", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("take", "Pips to TP:   " + as_48 + " pips", 7, "Verdana", Silver);
      ObjectSet("take", OBJPROP_CORNER, 0);
      ObjectSet("take", OBJPROP_XDISTANCE, l_x_80);
      ObjectSet("take", OBJPROP_YDISTANCE, l_y_88 + 88.0);
   } else {
      ObjectSet("take", OBJPROP_XDISTANCE, l_x_80);
      ObjectSet("take", OBJPROP_YDISTANCE, l_y_88 + 88.0);
   }
   if (ObjectFind("stop") != 0) {
      ObjectCreate("stop", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("stop", "Pips to SL:   " + as_40 + " pips", 7, "Verdana", Silver);
      ObjectSet("stop", OBJPROP_CORNER, 0);
      ObjectSet("stop", OBJPROP_XDISTANCE, l_x_80);
      ObjectSet("stop", OBJPROP_YDISTANCE, l_y_88 + 103.0);
   } else {
      ObjectSet("stop", OBJPROP_XDISTANCE, l_x_80);
      ObjectSet("stop", OBJPROP_YDISTANCE, l_y_88 + 103.0);
   }
   if (ObjectFind("lin03") != 0) {
      ObjectCreate("lin03", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("lin03", "-----------------------------", 9, "Arial", DimGray);
      ObjectSet("lin03", OBJPROP_CORNER, 0);
      ObjectSet("lin03", OBJPROP_XDISTANCE, l_x_80);
      ObjectSet("lin03", OBJPROP_YDISTANCE, l_y_88 + 113.0);
   } else {
      ObjectSet("lin03", OBJPROP_XDISTANCE, l_x_80);
      ObjectSet("lin03", OBJPROP_YDISTANCE, l_y_88 + 113.0);
   }
   if (ObjectFind("spread_") != 0) {
      ObjectCreate("spread_", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("spread_", "Spread:               " + DoubleToStr(MarketInfo(Symbol(), MODE_SPREAD), 0), 7, "Verdana", Silver);
      ObjectSet("spread_", OBJPROP_CORNER, 0);
      ObjectSet("spread_", OBJPROP_XDISTANCE, l_x_80);
      ObjectSet("spread_", OBJPROP_YDISTANCE, l_y_88 + 126.0);
   } else {
      ObjectSet("spread_", OBJPROP_XDISTANCE, l_x_80);
      ObjectSet("spread_", OBJPROP_YDISTANCE, l_y_88 + 126.0);
   }
   if (ObjectFind("pipvalue_") != 0) {
      ObjectCreate("pipvalue_", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("pipvalue_", "Pip Value:      $" + DoubleToStr(MarketInfo(Symbol(), MODE_TICKVALUE), 2), 7, "Verdana", Silver);
      ObjectSet("pipvalue_", OBJPROP_CORNER, 0);
      ObjectSet("pipvalue_", OBJPROP_XDISTANCE, l_x_80);
      ObjectSet("pipvalue_", OBJPROP_YDISTANCE, l_y_88 + 141.0);
   } else {
      ObjectSet("pipvalue_", OBJPROP_XDISTANCE, l_x_80);
      ObjectSet("pipvalue_", OBJPROP_YDISTANCE, l_y_88 + 141.0);
   }
   if (ObjectFind("lin04") != 0) {
      ObjectCreate("lin04", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("lin04", "-----------------------------", 9, "Arial", DimGray);
      ObjectSet("lin04", OBJPROP_CORNER, 0);
      ObjectSet("lin04", OBJPROP_XDISTANCE, l_x_80);
      ObjectSet("lin04", OBJPROP_YDISTANCE, l_y_88 + 151.0);
      return;
   }
   ObjectSet("lin04", OBJPROP_XDISTANCE, l_x_80);
   ObjectSet("lin04", OBJPROP_YDISTANCE, l_y_88 + 151.0);
}

string WeekDay(int ai_0) {
   string ls_ret_4;
   if (ai_0 == 0) ls_ret_4 = "Sunday";
   if (ai_0 == 1) ls_ret_4 = "Monday";
   if (ai_0 == 2) ls_ret_4 = "Tuesday";
   if (ai_0 == 3) ls_ret_4 = "Wednesday";
   if (ai_0 == 4) ls_ret_4 = "Thursday";
   if (ai_0 == 5) ls_ret_4 = "Friday";
   if (ai_0 == 6) ls_ret_4 = "Saturday";
   return (ls_ret_4);
}

string month(int ai_0) {
   string ls_ret_4;
   if (ai_0 == 1) ls_ret_4 = "January";
   if (ai_0 == 2) ls_ret_4 = "February";
   if (ai_0 == 3) ls_ret_4 = "March";
   if (ai_0 == 4) ls_ret_4 = "April";
   if (ai_0 == 5) ls_ret_4 = "May";
   if (ai_0 == 6) ls_ret_4 = "June";
   if (ai_0 == 7) ls_ret_4 = "July";
   if (ai_0 == 8) ls_ret_4 = "August";
   if (ai_0 == 9) ls_ret_4 = "September";
   if (ai_0 == 10) ls_ret_4 = "October";
   if (ai_0 == 11) ls_ret_4 = "November";
   if (ai_0 == 12) ls_ret_4 = "December";
   return (ls_ret_4);
}

string TermDate(int ai_0) {
   string ls_ret_4;
   if (ai_0 == 1 || ai_0 == 21 || ai_0 == 31) ls_ret_4 = "st";
   else {
      if (ai_0 == 2 || ai_0 == 22) ls_ret_4 = "nd";
      else {
         if (ai_0 == 3 || ai_0 == 23) ls_ret_4 = "rd";
         else ls_ret_4 = "th";
      }
   }
   return (ls_ret_4);
}

void TFS_display_small(string a_text_0, string as_8, double ad_16, string a_text_24, color a_color_32, color a_color_36, color a_color_40) {
   ObjectCreate("_symbol_", OBJ_LABEL, 0, 0, 0);
   ObjectSetText("_symbol_", a_text_0, 7, "Arial Black", g_color_396);
   ObjectSet("_symbol_", OBJPROP_CORNER, 3);
   ObjectSet("_symbol_", OBJPROP_XDISTANCE, X_box + 8);
   ObjectSet("_symbol_", OBJPROP_YDISTANCE, Y_box + 36);
   ObjectCreate("_line1", OBJ_LABEL, 0, 0, 0);
   ObjectSetText("_line1", "----------------------------------------------", 9, "Arial", g_color_404);
   ObjectSet("_line1", OBJPROP_CORNER, 3);
   ObjectSet("_line1", OBJPROP_XDISTANCE, X_box + 5);
   ObjectSet("_line1", OBJPROP_YDISTANCE, Y_box + 29);
   ObjectCreate("trend_logo_1", OBJ_LABEL, 0, 0, 0);
   ObjectSetText("trend_logo_1", ".:", 14, "Arial Black", a_color_32);
   ObjectSet("trend_logo_1", OBJPROP_CORNER, 3);
   ObjectSet("trend_logo_1", OBJPROP_XDISTANCE, X_box + 172);
   ObjectSet("trend_logo_1", OBJPROP_YDISTANCE, Y_box + 14);
   ObjectCreate("trend_logo_2", OBJ_LABEL, 0, 0, 0);
   ObjectSetText("trend_logo_2", ":.", 14, "Arial Black", a_color_36);
   ObjectSet("trend_logo_2", OBJPROP_CORNER, 3);
   ObjectSet("trend_logo_2", OBJPROP_XDISTANCE, X_box + 161);
   ObjectSet("trend_logo_2", OBJPROP_YDISTANCE, Y_box + 14);
   ObjectCreate("trend_comment", OBJ_LABEL, 0, 0, 0);
   ObjectSetText("trend_comment", a_text_24, 7, "Verdana", g_color_400);
   ObjectSet("trend_comment", OBJPROP_CORNER, 3);
   ObjectSet("trend_comment", OBJPROP_XDISTANCE, X_box + 45);
   ObjectSet("trend_comment", OBJPROP_YDISTANCE, Y_box + 19);
   ObjectCreate("trend_value", OBJ_LABEL, 0, 0, 0);
   ObjectSetText("trend_value", as_8 + DoubleToStr(ad_16, 0), 9, "Arial Black", a_color_40);
   ObjectSet("trend_value", OBJPROP_CORNER, 3);
   ObjectSet("trend_value", OBJPROP_XDISTANCE, X_box + 8);
   ObjectSet("trend_value", OBJPROP_YDISTANCE, Y_box + 16);
   ObjectCreate("_line3", OBJ_LABEL, 0, 0, 0);
   ObjectSetText("_line3", "----------------------------------------------", 9, "Arial", g_color_404);
   ObjectSet("_line3", OBJPROP_CORNER, 3);
   ObjectSet("_line3", OBJPROP_XDISTANCE, X_box + 5);
   ObjectSet("_line3", OBJPROP_YDISTANCE, Y_box + 8);
   ObjectCreate("copyright", OBJ_LABEL, 0, 0, 0);
   ObjectSetText("copyright", "╗╗╗   2007 й Forexinn Anatoliy Unlimited   ллл", 8, "Arial Narrow", g_color_404);
   ObjectSet("copyright", OBJPROP_CORNER, 3);
   ObjectSet("copyright", OBJPROP_XDISTANCE, X_box + 8);
   ObjectSet("copyright", OBJPROP_YDISTANCE, Y_box + 2);
}

void TFS_display_global(string a_text_0, string as_8, int ai_16, string a_text_20, color a_color_28, color a_color_32, color a_color_36, color a_color_40, int ai_44, color a_color_48, int ai_52, color a_color_56, int ai_60, color a_color_64, int ai_68, color a_color_72, int ai_76) {
   ObjectCreate("_symbol_", OBJ_LABEL, 0, 0, 0);
   ObjectSetText("_symbol_", a_text_0, 7, "Arial Black", g_color_396);
   ObjectSet("_symbol_", OBJPROP_CORNER, 3);
   ObjectSet("_symbol_", OBJPROP_XDISTANCE, X_box + 13);
   ObjectSet("_symbol_", OBJPROP_YDISTANCE, Y_box + 124);
   ObjectCreate("_line1", OBJ_LABEL, 0, 0, 0);
   ObjectSetText("_line1", "----------------------------------------------", 9, "Arial", g_color_404);
   ObjectSet("_line1", OBJPROP_CORNER, 3);
   ObjectSet("_line1", OBJPROP_XDISTANCE, X_box + 10);
   ObjectSet("_line1", OBJPROP_YDISTANCE, Y_box + 117);
   ObjectCreate("trend_logo_1", OBJ_LABEL, 0, 0, 0);
   ObjectSetText("trend_logo_1", ".:", 14, "Arial Black", a_color_28);
   ObjectSet("trend_logo_1", OBJPROP_CORNER, 3);
   ObjectSet("trend_logo_1", OBJPROP_XDISTANCE, X_box + 177);
   ObjectSet("trend_logo_1", OBJPROP_YDISTANCE, Y_box + 102);
   ObjectCreate("trend_logo_2", OBJ_LABEL, 0, 0, 0);
   ObjectSetText("trend_logo_2", ":.", 14, "Arial Black", a_color_32);
   ObjectSet("trend_logo_2", OBJPROP_CORNER, 3);
   ObjectSet("trend_logo_2", OBJPROP_XDISTANCE, X_box + 166);
   ObjectSet("trend_logo_2", OBJPROP_YDISTANCE, Y_box + 102);
   ObjectCreate("trend_comment", OBJ_LABEL, 0, 0, 0);
   ObjectSetText("trend_comment", a_text_20, 7, "Verdana", g_color_400);
   ObjectSet("trend_comment", OBJPROP_CORNER, 3);
   ObjectSet("trend_comment", OBJPROP_XDISTANCE, X_box + 50);
   ObjectSet("trend_comment", OBJPROP_YDISTANCE, Y_box + 107);
   ObjectCreate("trend_value", OBJ_LABEL, 0, 0, 0);
   ObjectSetText("trend_value", as_8 + DoubleToStr(ai_16, 0), 9, "Arial Black", a_color_36);
   ObjectSet("trend_value", OBJPROP_CORNER, 3);
   ObjectSet("trend_value", OBJPROP_XDISTANCE, X_box + 13);
   ObjectSet("trend_value", OBJPROP_YDISTANCE, Y_box + 104);
   ObjectCreate("_line2", OBJ_LABEL, 0, 0, 0);
   ObjectSetText("_line2", "----------------------------------------------", 9, "Arial", g_color_404);
   ObjectSet("_line2", OBJPROP_CORNER, 3);
   ObjectSet("_line2", OBJPROP_XDISTANCE, X_box + 10);
   ObjectSet("_line2", OBJPROP_YDISTANCE, Y_box + 96);
   ObjectCreate("maf_logo", OBJ_LABEL, 0, 0, 0);
   ObjectSetText("maf_logo", "-", 42, "Arial Black", a_color_40);
   ObjectSet("maf_logo", OBJPROP_CORNER, 3);
   ObjectSet("maf_logo", OBJPROP_XDISTANCE, X_box + 163);
   ObjectSet("maf_logo", OBJPROP_YDISTANCE, Y_box + 61);
   ObjectCreate("maf_logo2", OBJ_LABEL, 0, 0, 0);
   ObjectSetText("maf_logo2", "-", 42, "Arial Black", a_color_40);
   ObjectSet("maf_logo2", OBJPROP_CORNER, 3);
   ObjectSet("maf_logo2", OBJPROP_XDISTANCE, X_box + 173);
   ObjectSet("maf_logo2", OBJPROP_YDISTANCE, Y_box + 61);
   ObjectCreate("maf_score", OBJ_LABEL, 0, 0, 0);
   ObjectSetText("maf_score", gs_548 + ai_44, 7, "Verdana", g_color_400);
   ObjectSet("maf_score", OBJPROP_CORNER, 3);
   ObjectSet("maf_score", OBJPROP_XDISTANCE, X_box + 168);
   ObjectSet("maf_score", OBJPROP_YDISTANCE, Y_box + 87);
   ObjectCreate("maf_comment", OBJ_LABEL, 0, 0, 0);
   ObjectSetText("maf_comment", "Last hour " + gs_564 + " MA" + g_period_392, 7, "Verdana", g_color_400);
   ObjectSet("maf_comment", OBJPROP_CORNER, 3);
   ObjectSet("maf_comment", OBJPROP_XDISTANCE, X_box + 13);
   ObjectSet("maf_comment", OBJPROP_YDISTANCE, Y_box + 87);
   ObjectCreate("day_logo", OBJ_LABEL, 0, 0, 0);
   ObjectSetText("day_logo", "-", 42, "Arial Black", a_color_48);
   ObjectSet("day_logo", OBJPROP_CORNER, 3);
   ObjectSet("day_logo", OBJPROP_XDISTANCE, X_box + 163);
   ObjectSet("day_logo", OBJPROP_YDISTANCE, Y_box + 46);
   ObjectCreate("day_logo2", OBJ_LABEL, 0, 0, 0);
   ObjectSetText("day_logo2", "-", 42, "Arial Black", a_color_48);
   ObjectSet("day_logo2", OBJPROP_CORNER, 3);
   ObjectSet("day_logo2", OBJPROP_XDISTANCE, X_box + 173);
   ObjectSet("day_logo2", OBJPROP_YDISTANCE, Y_box + 46);
   ObjectCreate("day_score", OBJ_LABEL, 0, 0, 0);
   ObjectSetText("day_score", gs_524 + ai_52, 7, "Verdana", g_color_400);
   ObjectSet("day_score", OBJPROP_CORNER, 3);
   ObjectSet("day_score", OBJPROP_XDISTANCE, X_box + 168);
   ObjectSet("day_score", OBJPROP_YDISTANCE, Y_box + 72);
   ObjectCreate("day_comment", OBJ_LABEL, 0, 0, 0);
   ObjectSetText("day_comment", gi_232 + " " + gs_424 + " " + gs_408 + " on " + gs_416 + " " + g_day_516 + gs_432, 7, "Verdana", g_color_400);
   ObjectSet("day_comment", OBJPROP_CORNER, 3);
   ObjectSet("day_comment", OBJPROP_XDISTANCE, X_box + 13);
   ObjectSet("day_comment", OBJPROP_YDISTANCE, Y_box + 72);
   ObjectCreate("mas_logo", OBJ_LABEL, 0, 0, 0);
   ObjectSetText("mas_logo", "-", 42, "Arial Black", a_color_56);
   ObjectSet("mas_logo", OBJPROP_CORNER, 3);
   ObjectSet("mas_logo", OBJPROP_XDISTANCE, X_box + 163);
   ObjectSet("mas_logo", OBJPROP_YDISTANCE, Y_box + 31);
   ObjectCreate("mas_logo2", OBJ_LABEL, 0, 0, 0);
   ObjectSetText("mas_logo2", "-", 42, "Arial Black", a_color_56);
   ObjectSet("mas_logo2", OBJPROP_CORNER, 3);
   ObjectSet("mas_logo2", OBJPROP_XDISTANCE, X_box + 173);
   ObjectSet("mas_logo2", OBJPROP_YDISTANCE, Y_box + 31);
   ObjectCreate("mas_score", OBJ_LABEL, 0, 0, 0);
   ObjectSetText("mas_score", gs_556 + ai_60, 7, "Verdana", g_color_400);
   ObjectSet("mas_score", OBJPROP_CORNER, 3);
   ObjectSet("mas_score", OBJPROP_XDISTANCE, X_box + 168);
   ObjectSet("mas_score", OBJPROP_YDISTANCE, Y_box + 57);
   ObjectCreate("mas_comment", OBJ_LABEL, 0, 0, 0);
   ObjectSetText("mas_comment", "Last price " + gs_572 + " MA" + g_period_388, 7, "Verdana", g_color_400);
   ObjectSet("mas_comment", OBJPROP_CORNER, 3);
   ObjectSet("mas_comment", OBJPROP_XDISTANCE, X_box + 13);
   ObjectSet("mas_comment", OBJPROP_YDISTANCE, Y_box + 57);
   ObjectCreate("week_logo", OBJ_LABEL, 0, 0, 0);
   ObjectSetText("week_logo", "-", 42, "Arial Black", a_color_72);
   ObjectSet("week_logo", OBJPROP_CORNER, 3);
   ObjectSet("week_logo", OBJPROP_XDISTANCE, X_box + 163);
   ObjectSet("week_logo", OBJPROP_YDISTANCE, Y_box + 16);
   ObjectCreate("week_logo2", OBJ_LABEL, 0, 0, 0);
   ObjectSetText("week_logo2", "-", 42, "Arial Black", a_color_72);
   ObjectSet("week_logo2", OBJPROP_CORNER, 3);
   ObjectSet("week_logo2", OBJPROP_XDISTANCE, X_box + 173);
   ObjectSet("week_logo2", OBJPROP_YDISTANCE, Y_box + 16);
   ObjectCreate("week_score", OBJ_LABEL, 0, 0, 0);
   ObjectSetText("week_score", gs_532 + ai_76, 7, "Verdana", g_color_400);
   ObjectSet("week_score", OBJPROP_CORNER, 3);
   ObjectSet("week_score", OBJPROP_XDISTANCE, X_box + 168);
   ObjectSet("week_score", OBJPROP_YDISTANCE, Y_box + 42);
   ObjectCreate("week_comment", OBJ_LABEL, 0, 0, 0);
   ObjectSetText("week_comment", gi_240 + " " + gs_456 + " " + gs_440 + " on " + gs_508 + " " + g_day_520 + gs_464, 7, "Verdana", g_color_400);
   ObjectSet("week_comment", OBJPROP_CORNER, 3);
   ObjectSet("week_comment", OBJPROP_XDISTANCE, X_box + 13);
   ObjectSet("week_comment", OBJPROP_YDISTANCE, Y_box + 42);
   ObjectCreate("month_logo", OBJ_LABEL, 0, 0, 0);
   ObjectSetText("month_logo", "-", 42, "Arial Black", a_color_64);
   ObjectSet("month_logo", OBJPROP_CORNER, 3);
   ObjectSet("month_logo", OBJPROP_XDISTANCE, X_box + 163);
   ObjectSet("month_logo", OBJPROP_YDISTANCE, Y_box + 1);
   ObjectCreate("month_logo2", OBJ_LABEL, 0, 0, 0);
   ObjectSetText("month_logo2", "-", 42, "Arial Black", a_color_64);
   ObjectSet("month_logo2", OBJPROP_CORNER, 3);
   ObjectSet("month_logo2", OBJPROP_XDISTANCE, X_box + 173);
   ObjectSet("month_logo2", OBJPROP_YDISTANCE, Y_box + 1);
   ObjectCreate("month_score", OBJ_LABEL, 0, 0, 0);
   ObjectSetText("month_score", gs_540 + ai_68, 7, "Verdana", g_color_400);
   ObjectSet("month_score", OBJPROP_CORNER, 3);
   ObjectSet("month_score", OBJPROP_XDISTANCE, X_box + 168);
   ObjectSet("month_score", OBJPROP_YDISTANCE, Y_box + 27);
   ObjectCreate("month_comment", OBJ_LABEL, 0, 0, 0);
   ObjectSetText("month_comment", gi_248 + " " + gs_496 + " " + gs_472 + " on " + gs_480 + " " + g_day_504 + gs_488, 7, "Verdana", g_color_400);
   ObjectSet("month_comment", OBJPROP_CORNER, 3);
   ObjectSet("month_comment", OBJPROP_XDISTANCE, X_box + 13);
   ObjectSet("month_comment", OBJPROP_YDISTANCE, Y_box + 27);
   ObjectCreate("_line3", OBJ_LABEL, 0, 0, 0);
   ObjectSetText("_line3", "----------------------------------------------", 9, "Arial", g_color_404);
   ObjectSet("_line3", OBJPROP_CORNER, 3);
   ObjectSet("_line3", OBJPROP_XDISTANCE, X_box + 10);
   ObjectSet("_line3", OBJPROP_YDISTANCE, Y_box + 17);
   ObjectCreate("copyright", OBJ_LABEL, 0, 0, 0);
   ObjectSetText("copyright", "╗╗╗    2007 й Forexinn Anatoliy Unlimited   ллл", 8, "Arial Narrow", g_color_404);
   ObjectSet("copyright", OBJPROP_CORNER, 3);
   ObjectSet("copyright", OBJPROP_XDISTANCE, X_box + 13);
   ObjectSet("copyright", OBJPROP_YDISTANCE, Y_box + 11);
}

void ObjDel() {
   while (g_count_880 <= 0) {
      ObjectDelete("PP[" + g_count_880 + "]");
      ObjectDelete("R1[" + g_count_880 + "]");
      ObjectDelete("R2[" + g_count_880 + "]");
      ObjectDelete("R3[" + g_count_880 + "]");
      ObjectDelete("S1[" + g_count_880 + "]");
      ObjectDelete("S2[" + g_count_880 + "]");
      ObjectDelete("S3[" + g_count_880 + "]");
      ObjectDelete("M0[" + g_count_880 + "]");
      ObjectDelete("M1[" + g_count_880 + "]");
      ObjectDelete("M2[" + g_count_880 + "]");
      ObjectDelete("M3[" + g_count_880 + "]");
      ObjectDelete("M4[" + g_count_880 + "]");
      ObjectDelete("M5[" + g_count_880 + "]");
      g_count_880++;
   }
   g_high_796 = 0;
   g_low_804 = 0;
   gd_unused_812 = 0;
   gd_unused_820 = 0;
   g_day_828 = 0;
   g_day_836 = 0;
   for (int li_0 = 720; li_0 != 0; li_0--) {
      if (TimeDayOfWeek(Time[li_0]) == 0) g_day_828 = g_day_836;
      else g_day_828 = TimeDay(Time[li_0] - 3600 * GMTshift);
      if (g_day_836 != g_day_828) {
         g_close_860 = Close[li_0 + 1];
         gd_unused_820 = Open[li_0];
         g_high_844 = g_high_796;
         g_low_852 = g_low_804;
         g_high_796 = High[li_0];
         g_low_804 = Low[li_0];
         g_day_836 = g_day_828;
      }
      if (High[li_0] > g_high_796) g_high_796 = High[li_0];
      if (Low[li_0] < g_low_804) g_low_804 = Low[li_0];
   }
}

void PlotLine(string a_name_0, double a_price_8, double a_color_16, double a_style_24) {
   ObjectCreate(a_name_0, OBJ_ARROW, 0, Time[0], a_price_8, Time[0], a_price_8);
   ObjectSet(a_name_0, OBJPROP_ARROWCODE, DOT_Type);
   ObjectSet(a_name_0, OBJPROP_WIDTH, S_R_Levels_Size);
   ObjectSet(a_name_0, OBJPROP_STYLE, a_style_24);
   ObjectSet(a_name_0, OBJPROP_COLOR, a_color_16);
}

void PlotLinemm(string a_name_0, double a_price_8, double a_color_16, double a_style_24) {
   ObjectCreate(a_name_0, OBJ_ARROW, 0, Time[0], a_price_8, Time[0], a_price_8);
   ObjectSet(a_name_0, OBJPROP_ARROWCODE, DOT_Type);
   ObjectSet(a_name_0, OBJPROP_WIDTH, MLevelS_Size);
   ObjectSet(a_name_0, OBJPROP_STYLE, a_style_24);
   ObjectSet(a_name_0, OBJPROP_COLOR, a_color_16);
}

void PlotLinep(string a_name_0, double a_price_8, double a_color_16, double a_style_24) {
   ObjectCreate(a_name_0, OBJ_ARROW, 0, Time[0], a_price_8, Time[0], a_price_8);
   ObjectSet(a_name_0, OBJPROP_ARROWCODE, DOT_Type);
   ObjectSet(a_name_0, OBJPROP_WIDTH, PIVOT_Size);
   ObjectSet(a_name_0, OBJPROP_STYLE, a_style_24);
   ObjectSet(a_name_0, OBJPROP_COLOR, a_color_16);
}

void CreateObj(string a_name_0, double a_price_8, double a_price_16, color a_color_24) {
   ObjectCreate(a_name_0, OBJ_VLINE, 0, iTime(NULL, PERIOD_D1, 0) + 3600 * GMTshift, a_price_8, Time[0], a_price_16);
   ObjectSet(a_name_0, OBJPROP_COLOR, a_color_24);
}

void DeleteCreateObj() {
   ObjectDelete("DailyHILO");
}

void CreateHL() {
   DeleteCreateObj();
   ObjectsDeleteAll(0, OBJ_VLINE);
   double l_ihigh_0 = iHigh(NULL, PERIOD_D1, 0);
   double l_ilow_8 = iLow(NULL, PERIOD_D1, 0);
   if (Show_StartTime == TRUE) CreateObj("DailyHILO", 0, 0, REC_color);
   ObjDel();
   g_count_880 = 0;
   g_datetime_868 = iTime(NULL, PERIOD_D1, gi_876);
   int li_16 = gi_876 - 1;
   if (li_16 < 0) gi_872 = Time[0];
   else gi_872 = iTime(NULL, PERIOD_D1, li_16) - 60 * Period();
   double ld_20 = (g_high_844 + g_low_852 + g_close_860) / 3.0;
   double ld_28 = 2.0 * ld_20 + (g_high_844 - 2.0 * g_low_852);
   double ld_36 = ld_20 + (g_high_844 - g_low_852);
   double ld_44 = 2.0 * ld_20 - g_low_852;
   double ld_52 = 2.0 * ld_20 - g_high_844;
   double ld_60 = ld_20 - (g_high_844 - g_low_852);
   double ld_68 = 2.0 * ld_20 - (2.0 * g_high_844 - g_low_852);
   double ld_76 = (ld_60 + ld_68) / 2.0;
   double ld_84 = (ld_52 + ld_60) / 2.0;
   double ld_92 = (ld_20 + ld_52) / 2.0;
   double ld_100 = (ld_20 + ld_44) / 2.0;
   double ld_108 = (ld_44 + ld_36) / 2.0;
   double ld_116 = (ld_36 + ld_28) / 2.0;
   gi_872 = g_datetime_868 + 11520;
   g_count_880 = gi_876;
   PlotLinep("PP[" + g_count_880 + "]", ld_20, Central_PIVOT, STYLE_SOLID);
   if (Plot_PIVOTS) {
      PlotLine("R1[" + g_count_880 + "]", ld_44, R1_R2_R3, STYLE_SOLID);
      PlotLine("R2[" + g_count_880 + "]", ld_36, R1_R2_R3, STYLE_SOLID);
      PlotLine("R3[" + g_count_880 + "]", ld_28, R1_R2_R3, STYLE_SOLID);
      PlotLine("S1[" + g_count_880 + "]", ld_52, S1_S2_S3, STYLE_SOLID);
      PlotLine("S2[" + g_count_880 + "]", ld_60, S1_S2_S3, STYLE_SOLID);
      PlotLine("S3[" + g_count_880 + "]", ld_68, S1_S2_S3, STYLE_SOLID);
   }
   if (Plot_M_Levels) {
      PlotLinemm("M0[" + g_count_880 + "]", ld_76, M0_M1_M2, STYLE_SOLID);
      PlotLinemm("M1[" + g_count_880 + "]", ld_84, M0_M1_M2, STYLE_SOLID);
      PlotLinemm("M2[" + g_count_880 + "]", ld_92, M0_M1_M2, STYLE_SOLID);
      PlotLinemm("M3[" + g_count_880 + "]", ld_100, M3_M4_M5, STYLE_SOLID);
      PlotLinemm("M4[" + g_count_880 + "]", ld_108, M3_M4_M5, STYLE_SOLID);
      PlotLinemm("M5[" + g_count_880 + "]", ld_116, M3_M4_M5, STYLE_SOLID);
   }
}