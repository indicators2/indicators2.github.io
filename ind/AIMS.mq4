
#property copyright "www.iTradeAIMS.com & Snorm"
#property link      "info@iTradeAims.com & www.for-exe.com"

#property indicator_separate_window
#property indicator_buffers 5
#property indicator_color1 LimeGreen
#property indicator_color2 DarkGreen
#property indicator_color3 Maroon
#property indicator_color4 Red
#property indicator_color5 Orange

double g_ibuf_76[];
double g_ibuf_80[];
double g_ibuf_84[];
double g_ibuf_88[];
double g_ibuf_92[];
double g_ibuf_96[];
extern bool VariableClosetoZL = TRUE;
extern bool AIMS_zero = TRUE;
extern bool AIMS_max_plus = FALSE;
extern bool AIMS_max_minus = FALSE;
extern bool AIMS_min_plus = TRUE;
extern bool AIMS_min_minus = TRUE;

extern double MaxClosetoZL = 0.0006;
extern double MinClosetoZL = 0.0002;
extern bool CrossVline = FALSE;

extern color VlineColor = Red;
extern color z1 = Blue;
extern color z2 = Green;
extern color z3 = Black;
extern color z4 = Yellow;




extern int VlineStyle = 1;
double gd_132;
double gd_140;
int g_bars_148;
int gi_152;
int gi_160;
int coun;
int bar1;
bool first=TRUE;
bool zero=FALSE;

int init() {
   IndicatorBuffers(7);
   SetIndexStyle(0, DRAW_HISTOGRAM, STYLE_SOLID);
   SetIndexStyle(1, DRAW_HISTOGRAM, STYLE_SOLID);
   SetIndexStyle(2, DRAW_HISTOGRAM, STYLE_SOLID);
   SetIndexStyle(3, DRAW_HISTOGRAM, STYLE_SOLID);
   SetIndexStyle(4, DRAW_HISTOGRAM, STYLE_SOLID);
   IndicatorDigits(Digits + 1);
   SetIndexBuffer(0, g_ibuf_80);
   SetIndexBuffer(1, g_ibuf_84);
   SetIndexBuffer(2, g_ibuf_88);
   SetIndexBuffer(3, g_ibuf_92);
   SetIndexBuffer(4, g_ibuf_96);
   SetIndexBuffer(5, g_ibuf_76);
   IndicatorShortName("AIMS Waves 5.2. CloseToZL: " + DoubleToStr(MaxClosetoZL, 5) + " " + DoubleToStr(MinClosetoZL, 5));
   SetIndexLabel(1, NULL);
   SetIndexLabel(2, NULL);
   SetIndexLabel(3, NULL);
   SetIndexLabel(0, NULL);
   SetIndexLabel(4, NULL);
   coun=1000000;
   return (0);
}

int deinit() {

// Missing Variables
   int ti_0 = 0;
   int ti_max = 0;
   int ti_156 = 0;
//

//   for (ti_156 = Bars; ti_0 >= 0; ti_0--) ObjectDelete("vcline" + ti_0);
   for (ti_0 = Bars; ti_0 >= 0; ti_0--) ObjectDelete("vcline" + ti_0);
   return (0);
}

int start() {

// Missing Variables
   int ti_0 = 0;
   int ti_max_plus = 0;
   int ti_min_plus = 0;
   int ti_max_minus = 0;
   int ti_min_minus = 0;
   int ti_zero = 0;         
   int ti_156 = 0;
   int t0=0; int t1=0;int t2=0;int t3=0;int t4=0;
//

   double iao_0;
   int count_12;
   int li_16;
   double ld_20;
   int li_8 = IndicatorCounted();
   if (li_8 > 0) li_8--;
   gi_160 = Bars - li_8;
   gd_132 = MaxClosetoZL;
   if (Bars != g_bars_148) { // Bars - номер свечки - выполняется при смене свечки
      g_bars_148 = Bars;
      count_12 = 0;
//      for (ti_156 = Bars; ti_0 >= 0; ti_0--) {

      for (ti_0 = Bars; ti_0 >= 0; ti_0--) {  
  
         if (VariableClosetoZL == TRUE && TimeMinute(Time[ti_0]) == 59) {
            li_16 = ti_0 + 120;
            gd_140 = 0;
            for (gi_152 = ti_0; gi_152 < li_16; gi_152++) {
               iao_0 = iAO(NULL, 0, gi_152);
               if (MathAbs(iao_0) > gd_140) gd_140 = MathAbs(iao_0);
            }
            gd_132 = gd_140 / 4.0;
            if (gd_132 > MaxClosetoZL) gd_132 = MaxClosetoZL;
            if (gd_132 < MinClosetoZL) gd_132 = MinClosetoZL;
         }
         ld_20 = 1 - gd_132;
         g_ibuf_76[ti_0] = iAO(NULL, 0, ti_0);
         iao_0 = g_ibuf_76[ti_0];
      
         //Проход через 0
          if (AIMS_zero && ((g_ibuf_76[ti_0 + 1] <= 0.0 && g_ibuf_76[ti_0] > 0.0) || (g_ibuf_76[ti_0 + 1] >= 0.0 && g_ibuf_76[ti_0] < 0.0))) {
           if(ti_0==0) { //Alert(Symbol()+" Проход 0"); 
           zero=true;
           //SendNotification(Symbol()+" Prohod 0 - "+TimeHour(CurTime())+":"+TimeMinute(CurTime())+" "+TimeToStr(CurTime(),TIME_DATE));
           }
           if(CrossVline && false){ 
           count_12++;
           ObjectCreate("vcline" + count_12, OBJ_VLINE, 0, Time[ti_0], 0, 0);
            ObjectSet("vcline" + count_12, OBJPROP_STYLE, VlineStyle);
            ObjectSet("vcline" + count_12, OBJPROP_BACK, TRUE);
            ObjectSet("vcline" + count_12, OBJPROP_COLOR, VlineColor);
           }
         }
        
     
        // + Пик 
          if (AIMS_max_plus && g_ibuf_76[ti_0 + 1] > g_ibuf_76[ti_0] && g_ibuf_76[ti_0 + 1] > g_ibuf_76[ti_0 + 2] && g_ibuf_76[ti_0 + 2] > g_ibuf_76[ti_0 + 3] && g_ibuf_76[ti_0]>0 && g_ibuf_76[ti_0 + 1]>0 && g_ibuf_76[ti_0 + 2]>0  ) 
          { 
          if(ti_0==0) { Alert(Symbol()+" + Пик");
          
          //SendNotification(Symbol()+" +Pik - "+TimeHour(CurTime())+":"+TimeMinute(CurTime())+" "+TimeToStr(CurTime(),TIME_DATE));
           }
           if(CrossVline){    
             count_12++;
             
            ObjectCreate("vcline" + count_12, OBJ_VLINE, 0, Time[ti_0], 0, 0);
            ObjectSet("vcline" + count_12, OBJPROP_STYLE, VlineStyle);
            ObjectSet("vcline" + count_12, OBJPROP_BACK, TRUE);
            ObjectSet("vcline" + count_12, OBJPROP_COLOR, z1);
            }
            
          }
         
          
          // + Впадина Плюс - зеленая
          if (AIMS_min_plus && g_ibuf_76[ti_0 + 1] < g_ibuf_76[ti_0] && g_ibuf_76[ti_0 + 1] < g_ibuf_76[ti_0 + 2] && g_ibuf_76[ti_0 + 2] < g_ibuf_76[ti_0 + 3] && g_ibuf_76[ti_0]>0 && g_ibuf_76[ti_0 + 1]>0 && g_ibuf_76[ti_0 + 2]>0  ) 
          { 
                       
           if(CrossVline && zero){     
           count_12++;       
            ObjectCreate("vcline" + count_12, OBJ_VLINE, 0, Time[ti_0], 0, 0);
            ObjectSet("vcline" + count_12, OBJPROP_STYLE, VlineStyle);
            ObjectSet("vcline" + count_12, OBJPROP_BACK, TRUE);
            ObjectSet("vcline" + count_12, OBJPROP_COLOR, z2);
            }
            if(ti_0==0 && zero) { Alert(Symbol()+" + Впадина");
          zero=false;
          //SendNotification(Symbol()+" +Vpadina - "+TimeHour(CurTime())+":"+TimeMinute(CurTime())+" "+TimeToStr(CurTime(),TIME_DATE));
          }
          }   
                
         
           // - Пик минус - желтая
          if (AIMS_max_minus && g_ibuf_76[ti_0 + 1] < g_ibuf_76[ti_0] && g_ibuf_76[ti_0 + 1] < g_ibuf_76[ti_0 + 2] && g_ibuf_76[ti_0 + 2] < g_ibuf_76[ti_0 + 3] && g_ibuf_76[ti_0]<0 && g_ibuf_76[ti_0 + 1]<0 && g_ibuf_76[ti_0 + 2]<0  ) 
          { if(ti_0==0) { Alert(Symbol()+" - Пик"); 
         
          //SendNotification(Symbol()+" -Pik - "+TimeHour(CurTime())+":"+TimeMinute(CurTime())+" "+TimeToStr(CurTime(),TIME_DATE));
          }
                       
                if(CrossVline){ 
                       count_12++;
            ObjectCreate("vcline" + count_12, OBJ_VLINE, 0, Time[ti_0], 0, 0);
            ObjectSet("vcline" + count_12, OBJPROP_STYLE, VlineStyle);
            ObjectSet("vcline" + count_12, OBJPROP_BACK, TRUE);
            ObjectSet("vcline" + count_12, OBJPROP_COLOR,z3);
            }
          }   
             
        // - Впадина минус - желтая область
          if (AIMS_min_minus && g_ibuf_76[ti_0 + 1] > g_ibuf_76[ti_0] && g_ibuf_76[ti_0 + 1] > g_ibuf_76[ti_0 + 2] && g_ibuf_76[ti_0 + 2] > g_ibuf_76[ti_0 + 3] && g_ibuf_76[ti_0]<0 && g_ibuf_76[ti_0 + 1]<0 && g_ibuf_76[ti_0 + 2]<0  ) 
          { 
                       
                          if(CrossVline && zero){ 
                       count_12++;
            ObjectCreate("vcline" + count_12, OBJ_VLINE, 0, Time[ti_0], 0, 0);
            ObjectSet("vcline" + count_12, OBJPROP_STYLE, VlineStyle);
            ObjectSet("vcline" + count_12, OBJPROP_BACK, TRUE);
            ObjectSet("vcline" + count_12, OBJPROP_COLOR, z4);
            }
            if(ti_0==0 && zero) { Alert(Symbol()+" - Впадина");
          zero=false;
          //SendNotification(Symbol()+" -Vpadina - "+TimeHour(CurTime())+":"+TimeMinute(CurTime())+" "+TimeToStr(CurTime(),TIME_DATE));
          }
          }
    
 
         g_ibuf_84[ti_0] = 0;
         g_ibuf_80[ti_0] = 0;
         g_ibuf_88[ti_0] = 0;
         g_ibuf_92[ti_0] = 0;
         g_ibuf_96[ti_0] = 0;
         if (iao_0 > gd_132 && iao_0 > gd_132 && iao_0 > g_ibuf_76[ti_0 + 1]) g_ibuf_80[ti_0] = iao_0;
         if (iao_0 > gd_132 && iao_0 > gd_132 && iao_0 <= g_ibuf_76[ti_0 + 1]) g_ibuf_84[ti_0] = iao_0;
         if (iao_0 < ld_20 && iao_0 < 0 - gd_132 && iao_0 < g_ibuf_76[ti_0 + 1]) g_ibuf_92[ti_0] = iao_0;
         if (iao_0 < ld_20 && iao_0 < 0 - gd_132 && iao_0 >= g_ibuf_76[ti_0 + 1]) g_ibuf_88[ti_0] = iao_0;
         if (MathAbs(0 - iao_0) < gd_132) g_ibuf_96[ti_0] = iao_0;
          
      }
 Comment("zero="+zero);
   }
   return (0);
}