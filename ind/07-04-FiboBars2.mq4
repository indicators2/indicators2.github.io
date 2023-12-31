//+------------------------------------------------------------------+
//|                                   Copyright © 2010, Ivan Kornilov|
//|                                                     FiboBars2.mq4|
//+------------------------------------------------------------------+
#property copyright "Copyright © 2009, Ivan Kornilov. All rights reserved."
#property link "excelf@gmail.com"

#property indicator_chart_window
#property indicator_buffers 4
#property indicator_color1 Red
#property indicator_color2 Green
#property indicator_color3 Red
#property indicator_color4 Green


extern int period = 12;
extern int fiboLevel = 3;
extern bool fiboBuy = true;
extern bool fiboSell = true;

double ExtMapBuffer1[];
double ExtMapBuffer2[];
double ExtMapBuffer3[];
double ExtMapBuffer4[];
double trand[];

double prevTicTrend = 0;

bool oldIsTrandDown;
double level;
#define level1 0.236
#define level2 0.382
#define level3 0.5
#define level4 0.618
#define level5 0.762

extern bool alertMode = true;

datetime barTime = 0;

int init() {
    IndicatorBuffers(5);
 
    SetIndexBuffer(0, ExtMapBuffer1);
    SetIndexBuffer(1, ExtMapBuffer2);
    SetIndexBuffer(2, ExtMapBuffer3);
    SetIndexBuffer(3, ExtMapBuffer4);
    SetIndexBuffer(4, trand);
    
    
    SetIndexStyle(0, DRAW_HISTOGRAM, 0, 1);
    SetIndexStyle(1, DRAW_HISTOGRAM, 0, 1);
    SetIndexStyle(2, DRAW_HISTOGRAM, 0, 3);
    SetIndexStyle(3, DRAW_HISTOGRAM, 0, 3);
    
    
    SetIndexDrawBegin(0, period);
    SetIndexDrawBegin(1, period);
    SetIndexDrawBegin(2, period);
    SetIndexDrawBegin(3, period);
    SetIndexDrawBegin(4, period);
    

    
    switch(fiboLevel){
    case 1:
        level = level1;
        break;
    case 2:
        level = level2;   
        break;
    case 3:
        level = level3;
        break;
    case 4:
        level = level4;
        break;
    case 5:
        level = level5;
        break;
    default: 
        level = level1;
        break;
    }
    return(0);
}

int deinit(){
    return(0);
}

int start() {
    int indicatorCounted = IndicatorCounted();
    if (indicatorCounted < 0) { 
        return (-1);
    }
    if(indicatorCounted > 0) {
       indicatorCounted--;
    }
   
    int limit = Bars - indicatorCounted;
    for(int i = limit; i >= 0; i--) {
        double maxHigh = High[iHighest(NULL,0,MODE_HIGH, period, i)];
        double minLow = Low[iLowest(NULL,0,MODE_LOW, period, i)]; 
        if(Open[i] > Close[i]) {
           if(!(trand[i+1] < 0  && (maxHigh - minLow) * level < (Close[i] - minLow))) {
              trand[i] = 1;
           } else {
              trand[i] = -1;
           }
        } else {
            if(!(trand[i+1] > 0  && (maxHigh - minLow) * level < (maxHigh - Close[i]))) {
                trand[i] = -1;
            } else {
                trand[i] = 1;
            }
        }
        
        if(alertMode && i == 0 && trand[0] != trand[1]) {
            if(barTime != Time[0]) {
                if (trand[0] == 1) {
                    if(fiboBuy) Alert("FiboBars2: " + Symbol() + " M " + Period() + ": Signal: BUY");
                } else if(trand[0] == -1){
                    if(fiboSell) Alert("FiboBars2: " + Symbol() + " M " + Period() + ": Signal: SELL");
                }
            }
            barTime = Time[0];
            
            if(prevTicTrend != trand[0]) {
                PlaySound("event.wav");
            }
            prevTicTrend = trand[0];
            
        }
        
        if(trand[i] == 1) {//RED BAR 
            ExtMapBuffer1[i] = High[i];
            ExtMapBuffer2[i] = Low[i]; 
            ExtMapBuffer3[i] = MathMax(Open[i], Close[i]); 
            ExtMapBuffer4[i] = MathMin(Open[i], Close[i]);   
        } else if(trand[i] == -1) {//GREEN BAR
            ExtMapBuffer1[i] = Low[i];
            ExtMapBuffer2[i] = High[i]; 
            ExtMapBuffer3[i] = MathMin(Open[i], Close[i]);  
            ExtMapBuffer4[i] = MathMax(Open[i], Close[i]);    
        } else {
            ExtMapBuffer1[i] = EMPTY_VALUE;
            ExtMapBuffer2[i] = EMPTY_VALUE; 
            ExtMapBuffer3[i] = EMPTY_VALUE;  
            ExtMapBuffer4[i] = EMPTY_VALUE;  
        }
    }
    return(0);
}