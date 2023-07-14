//+------------------------------------------------------------------+
//|                                                MurreyMath1.0.mq4 |
//|                                                      version 1.0 |
//|                            modified by banzai to add in an alert |
//|                           and you can change the color lines now |
//|                      Copyright © 2007, MetaQuotes Software Corp. |
//|                                        http://www.metaquotes.net |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//|                                              MM# LabelLevels.mq4 |
//|                      Copyright © 2006, MetaQuotes Software Corp. |
//+------------------------------------------------------------------+

#property copyright "Copyright © 2006, MetaQuotes Software Corp."
#property link      " Modified by cja " 
#property link      "http://www.metaquotes.net"

//+------------------------------------------------------------------+
//|                                            Murrey_Math_MT_VG.mq4 |
//|                      Copyright © 2004, MetaQuotes Software Corp. |
//+------------------------------------------------------------------+
#property copyright "Vladislav Goshkov (VG)."
#property link      "4vg@mail.ru"

#property indicator_chart_window

// ============================================================================================
// 8/8 c 0/8 
// ============================================================================================
// 7/8    Weak, Stall and Reverse

// ============================================================================================
// 1/8  Weak, Stall and Reverse

// ============================================================================================
// 6/8 c 2/8  Pivot, Reverse

// ============================================================================================
// 5/8  Top of Trading Range 40% of trading range between 5/8 & 3/8 
                                
// ============================================================================================
// 3/8  Bottom of Trading Range

// ============================================================================================
// 4/8  Major Support/Resistance

// ============================================================================================
extern string note1 ="P = 240 = H4 chart";
extern int P = 64;
extern int StepBack = 0;
extern string note2 = "display comment=true; turn off = false";
extern bool Comments = false;
extern string note3 = "turn on Alert = true; turn off = false";
extern bool AlertOn = true;
extern color levelminus2 = SteelBlue;
extern color levelminus1 = MediumVioletRed;
extern color level0 = Teal;
extern color level1 = Goldenrod;
extern color level2 = Crimson;
extern color level3 = Green;
extern color level4 = Blue;
extern color level5 = Green;
extern color level6 = Crimson;
extern color level7 = Goldenrod;
extern color level8 = Teal;
extern color levelplus1 = MediumVioletRed;
extern color levelplus2 = SteelBlue;

double  dmml = 0,
        dvtl = 0,
        sum  = 0,
        v1 = 0,
        v2 = 0,
        mn = 0,
        mx = 0,
        x1 = 0,
        x2 = 0,
        x3 = 0,
        x4 = 0,
        x5 = 0,
        x6 = 0,
        y1 = 0,
        y2 = 0,
        y3 = 0,
        y4 = 0,
        y5 = 0,
        y6 = 0,
        octave = 0,
        fractal = 0,
        range   = 0,
        finalH  = 0,
        finalL  = 0,
        mml[13];

string  ln_txt[13],        
        buff_str = "";
        
int     
        bn_v1   = 0,
        bn_v2   = 0,
        OctLinesCnt = 13,
        mml_thk = 8,
        mml_clr[13],
        mml_shft = 3,
        nTime = 0,
        CurPeriod = 0,
        nDigits = 0,
        i = 0;
// Show regular timeframe string (HCY)
string AlertPrefix;
string GetTimeFrameStr() {
   switch(Period())
   {
      case 1 : string TimeFrameStr="M1"; break;
      case 5 : TimeFrameStr="M5"; break;
      case 15 : TimeFrameStr="M15"; break;
      case 30 : TimeFrameStr="M30"; break;
      case 60 : TimeFrameStr="H1"; break;
      case 240 : TimeFrameStr="H4"; break;
      case 1440 : TimeFrameStr="D1"; break;
      case 10080 : TimeFrameStr="W1"; break;
      case 43200 : TimeFrameStr="MN1"; break;
      default : TimeFrameStr="CUR";
   } 
   return (TimeFrameStr);
   }

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int init() {
//---- indicators
   ln_txt[0]  = "В этой точке ставим стоп, если покупали [-2/8]";// "extremely overshoot [-2/8]";// [-2/8]
   ln_txt[1]  = "Идеальный момент для покупки [-1/8]";// "overshoot [-1/8]";// [-1/8]
   ln_txt[2]  = "Идеальное место для закрытия продаж [0/8]";// "Ultimate Support - extremely oversold [0/8]";// [0/8]
   ln_txt[3]  = "Остановка разворот [1/8]";// "Weak, Stall and Reverse - [1/8]";// [1/8]
   ln_txt[4]  = "Вращение разворот [2/8]";// "Pivot, Reverse - major [2/8]";// [2/8]
   ln_txt[5]  = "Дно канала [3/8]";// "Bottom of Trading Range - [3/8], if 10-12 bars then 40% Time. BUY Premium Zone";//[3/8]
   ln_txt[6]  = "Центр Вселенной";// "Major Support/Resistance Pivotal Point [4/8]- Best New BUY or SELL level";// [4/8]
   ln_txt[7]  = "Верх канала [5/8]";// "Top of Trading Range - [5/8], if 10-12 bars then 40% Time. SELL Premium Zone";//[5/8]
   ln_txt[8]  = "Вращение разворот [6/8]";// "Pivot, Reverse - major [6/8]";// [6/8]
   ln_txt[9]  = "Остановка разворот [7/8]";// "Weak, Stall and Reverse - [7/8]";// [7/8]
   ln_txt[10] = "Идеальное место для закрытия покупок [8/8]";// "Ultimate Resistance - extremely overbought [8/8]";// [8/8]
   ln_txt[11] = "Идеальный момент для продажи [+1/8]";// "overshoot [+1/8]";// [+1/8]
   ln_txt[12] = "В этой точке ставим стоп, если продали [+2/8]";// "extremely overshoot [+2/8]";// [+2/8]

   mml_shft = 35;//original was 3
   mml_thk  = 3;

   // Нrчrльнr? уnnrновer цвlnов уdовнlй оenrв 
   mml_clr[0]  = levelminus2;  // [-2]/8
   mml_clr[1]  = levelminus1;  // [-1]/8
   mml_clr[2]  = level0;       //  [0]/8
   mml_clr[3]  = level1;       //  [1]/8
   mml_clr[4]  = level2;       //  [2]/8
   mml_clr[5]  = level3;       //  [3]/8
   mml_clr[6]  = level4;       //  [4]/8
   mml_clr[7]  = level5;       //  [5]/8
   mml_clr[8]  = level6;       //  [6]/8
   mml_clr[9]  = level7;       //  [7]/8
   mml_clr[10] = level8;       //  [8]/8
   mml_clr[11] = levelplus1;   // [+1]/8
   mml_clr[12] = levelplus2;   // [+2]/8
   // Show regular timeframe string (HCY)
   AlertPrefix=Symbol()+" ("+GetTimeFrameStr()+"):  ";
   return(0);
  }

//+------------------------------------------------------------------+
//| Custor indicator deinitialization function                       |
//+------------------------------------------------------------------+
int deinit() {
//if (Comments) {Comment(" ");}
for(i=0;i<OctLinesCnt;i++) {
    buff_str = "mml"+i;
    ObjectDelete(buff_str);
    buff_str = "mml_txt"+i;
    ObjectDelete(buff_str);
    }
//----
   return(0);
  }
bool NewBar()
{
   static datetime lastbar;
   datetime curbar = Time[0];
   //Print("NewBar(). lastbar="+TimeToStr(lastbar,TIME_DATE|TIME_MINUTES)+"  curbar="+TimeToStr(curbar,TIME_DATE|TIME_MINUTES));
   if(lastbar!=curbar)
   {
      lastbar=curbar;
      return (true);
   }
   else
   {
      return(false);
   }
}   
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int start() {

if( (nTime != Time[0]) || (CurPeriod != Period()) ) {
   
  //price
   bn_v1 = Lowest(NULL,0,MODE_LOW,P+StepBack,0);
   bn_v2 = Highest(NULL,0,MODE_HIGH,P+StepBack,0); // changes when price exceeds hi/low

   v1 = Low[bn_v1];
   v2 = High[bn_v2];
   
   if (Comments) {Comment("\n","MURREYMATH ","\n","HighClose = ",v2,"\n","LowClose = ",v1,"\n");}


   
   //v1=(Close[Lowest(NULL,0,MODE_CLOSE,P+StepBack,0)]);
   //v2=(Close[Highest(NULL,0,MODE_CLOSE,P+StepBack,0)]);// Possibly a better hi/low code than above code changes on CLOSE
                                                         // Still does not update 
                         
//determine fractal.....
   if( v2<=250000 && v2>25000 )
   fractal=100000;
   else
     if( v2<=25000 && v2>2500 )
     fractal=10000;
     else
       if( v2<=2500 && v2>250 )
       fractal=1000;
       else
         if( v2<=250 && v2>25 )
         fractal=100;
         else
           if( v2<=25 && v2>12.5 )
           fractal=12.5;
           else
             if( v2<=12.5 && v2>6.25)
             fractal=12.5;
             else
               if( v2<=6.25 && v2>3.125 )
               fractal=6.25;
               else
                 if( v2<=3.125 && v2>1.5625 )
                 fractal=3.125;
                 else
                   if( v2<=1.5625 && v2>0.390625 )
                   fractal=1.5625;
                   else
                     if( v2<=0.390625 && v2>0)
                     fractal=0.1953125;
      
   range=(v2-v1);
   sum=MathFloor(MathLog(fractal/range)/MathLog(2));
   octave=fractal*(MathPow(0.5,sum));
   mn=MathFloor(v1/octave)*octave;
   if( (mn+octave)>v2 )
   mx=mn+octave; 
   else
     mx=mn+(2*octave);


// calculating xx
//x2
    if( (v1>=(3*(mx-mn)/16+mn)) && (v2<=(9*(mx-mn)/16+mn)) )
    x2=mn+(mx-mn)/2; 
    else x2=0;
//x1
    if( (v1>=(mn-(mx-mn)/8))&& (v2<=(5*(mx-mn)/8+mn)) && (x2==0) )
    x1=mn+(mx-mn)/2; 
    else x1=0;

//x4
    if( (v1>=(mn+7*(mx-mn)/16))&& (v2<=(13*(mx-mn)/16+mn)) )
    x4=mn+3*(mx-mn)/4; 
    else x4=0;

//x5
    if( (v1>=(mn+3*(mx-mn)/8))&& (v2<=(9*(mx-mn)/8+mn))&& (x4==0) )
    x5=mx; 
    else  x5=0;

//x3
    if( (v1>=(mn+(mx-mn)/8))&& (v2<=(7*(mx-mn)/8+mn))&& (x1==0) && (x2==0) && (x4==0) && (x5==0) )
    x3=mn+3*(mx-mn)/4; 
    else x3=0;

//x6
    if( (x1+x2+x3+x4+x5) ==0 )
    x6=mx; 
    else x6=0;

     finalH = x1+x2+x3+x4+x5+x6;
// calculating yy
//y1
    if( x1>0 )
    y1=mn; 
    else y1=0;

//y2
    if( x2>0 )
    y2=mn+(mx-mn)/4; 
    else y2=0;

//y3
    if( x3>0 )
    y3=mn+(mx-mn)/4; 
    else y3=0;

//y4
    if( x4>0 )
    y4=mn+(mx-mn)/2; 
    else y4=0;

//y5
    if( x5>0 )
    y5=mn+(mx-mn)/2; 
    else y5=0;

//y6
    if( (finalH>0) && ((y1+y2+y3+y4+y5)==0) )
    y6=mn; 
    else y6=0;

    finalL = y1+y2+y3+y4+y5+y6;

    for( i=0; i<OctLinesCnt; i++) {
         mml[i] = 0;
         }
         
   dmml = (finalH-finalL)/8;

   mml[0] =(finalL-dmml*2); //-2/8
   for( i=1; i<OctLinesCnt; i++) {
        mml[i] = mml[i-1] + dmml;
        }
   for( i=0; i<OctLinesCnt; i++ ){
        buff_str = "mml"+i;
        if(ObjectFind(buff_str) == -1) {
           ObjectCreate(buff_str, OBJ_HLINE, 0, Time[0], mml[i]);
           ObjectSet(buff_str, OBJPROP_STYLE, STYLE_DOT);
           ObjectSet(buff_str, OBJPROP_COLOR, mml_clr[i]);
           ObjectMove(buff_str, 0, Time[0],  mml[i]);
           }
        else {
           ObjectMove(buff_str, 0, Time[0],  mml[i]);
           }
             
        buff_str = "mml_txt"+i;
        if(ObjectFind(buff_str) == -1) {
           ObjectCreate(buff_str, OBJ_TEXT, 0, Time[mml_shft], mml_shft);
           ObjectSetText(buff_str, ln_txt[i], 8, "Arial", mml_clr[i]);
           ObjectMove(buff_str, 0, Time[mml_shft],  mml[i]);
           }
        else {
           ObjectMove(buff_str, 0, Time[mml_shft],  mml[i]);
           }
        } // for( i=1; i<=OctLinesCnt; i++ ){

   nTime    = Time[0];
   CurPeriod= Period();
   }
   // ======= Alert =========
//Alert("high0="+High[0]+"mml12="+mml[12]);
   if(AlertOn && NewBar()){
      if((High[0] >= mml[12]) || (Low[0] >= mml[12]))
         Alert(AlertPrefix+"MM[+2/8] SELL: TP1 @ 8/8, TP2 @ 7/8");
      else
      if((High[0] >= mml[11]) && (High[0] < mml[12]) || (Low[0] >= mml[11]) && (Low[0] < mml[12]))
         Alert(AlertPrefix+"MM[+1/8] SELL: TP1 @ 8/8th, TP2 @ 7/8");
      else
      if((High[0] >= mml[10]) && (High[0] < mml[11]) || (Low[0] >= mml[10]) && (Low[0] < mml[11]))
         Alert(AlertPrefix+"MM[8/8] If downtrend, SELL & Exit @ 6/8th");
      else
      if((High[0] >= mml[9]) && (High[0] < mml[10]) || (Low[0] >= mml[9]) && (Low[0] < mml[10]))
         Alert(AlertPrefix+"MM[7/8] If downtrend, SELL & Exit @ 4/8th");
      else
      if((High[0] <= mml[0]) || (Low[0] <= mml[0]))
         Alert(AlertPrefix+"MM[-2/8] BUY: TP1 @ 0/8, TP2 @ 2/8");
      else
      if((High[0] <= mml[1]) && (High[0] > mml[0]) || (Low[0] <= mml[1]) && (Low[0] > mml[0]))
         Alert(AlertPrefix+"MM[-1/8] BUY: TP1 @ 0/8th, TP2 @ 2/8");
      else
      if((High[0] <= mml[2]) && (High[0] > mml[1]) || (Low[0] <= mml[2]) && (Low[0] > mml[1]))
         Alert(AlertPrefix+"MM[0/8] If uptrend, BUY & Exit @ 2/8th");
      else
      if((High[0] <= mml[3]) && (High[0] > mml[2]) || (Low[0] <= mml[3]) && (Low[0] > mml[2]))
         Alert(AlertPrefix+"MM[1/8] If uptrend, BUY & Exit @ 4/8th");
      }
   // ======= Alert Ends =========
//   ln_txt[0]  = "             [-2/8] BUY: TP1 @ 0/8th, TP2 @ 2/8th";// "extremely overshoot [-2/8]";// [-2/8]
//   ln_txt[1]  = "             [-1/8] BUY: TP1 @ 0/8th, TP2 @ 2/8th";// "overshoot [-1/8]";// [-1/8]
//   ln_txt[2]  = "             [0/8] If uptrend, BUY & Exit @ 2/8th";// "Ultimate Support - extremely oversold [0/8]";// [0/8]
//   ln_txt[3]  = "             [1/8] If uptrend, BUY & Exit @ 4/8th";// "Weak, Stall and Reverse - [1/8]";// [1/8]
//   ln_txt[4]  = "             [2/8] Pivot";// "Pivot, Reverse - major [2/8]";// [2/8]
//   ln_txt[5]  = "             [3/8]";// "Bottom of Trading Range - [3/8], if 10-12 bars then 40% Time. BUY Premium Zone";//[3/8]
//   ln_txt[6]  = "             [4/8] Major Support/Resistance";// "Major Support/Resistance Pivotal Point [4/8]- Best New BUY or SELL level";// [4/8]
//   ln_txt[7]  = "             [5/8]";// "Top of Trading Range - [5/8], if 10-12 bars then 40% Time. SELL Premium Zone";//[5/8]
//   ln_txt[8]  = "             [6/8] Pivot";// "Pivot, Reverse - major [6/8]";// [6/8]
//   ln_txt[9]  = "             [7/8] If downtrend, SELL & Exit @ 4/8th";// "Weak, Stall and Reverse - [7/8]";// [7/8]
//   ln_txt[10] = "             [8/8] If downtrend, SELL & Exit @ 6/8th";// "Ultimate Resistance - extremely overbought [8/8]";// [8/8]
//   ln_txt[11] = "             [+1/8] SELL: TP1 @ 8/8th, TP2 @ 7/8th";// "overshoot [+1/8]";// [+1/8]
//   ln_txt[12] = "             [+2/8] SELL: TP1 @ 8/8th, TP2 @ 7/8th";// "extremely overshoot [+2/8]";// [+2/8]
//---- End Of Program
  return(0);
  }

