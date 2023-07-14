//+------------------------------------------------------------------+
//|                                                   FISHINGZZ_V1_1 |
//|              MAX888 && PavelG && Pavka69 && Barrel && UserUserov |
//|             http://forum.tradelikeapro.ru/index.php?topic=4731.0 |
//|                                                           v. 1.1 |
//+------------------------------------------------------------------+
#property copyright "MAX888 && PavelG && Pavka69 && Barrel && UserUserov"
#property link      "http://forum.tradelikeapro.ru/index.php?topic=4731.0"

#property indicator_chart_window
#property indicator_buffers 3
#property indicator_color1 Red
#property indicator_color2 Silver
#property indicator_color3 Silver
//---- indicator parameters
extern int     ExtDepth=12;
extern int     ExtDeviation=5;
extern int     ExtBackstep=3;
extern int     otstup = 50;//отступ от High Low в пунктах для рисования фрактала и линии
extern int     lineupw = 2;//ширина линии вверх
extern color   lineupc = Blue;//цвет линии вверх
extern int     linednw = 2;//ширина линии вниз
extern color   linednc = Red;//цвет линии вниз
extern bool    showrline = false;//показ линий неправильного направления

//---- indicator buffers
double ZigzagBuffer[];
double HighMapBuffer[];
double LowMapBuffer[];
double High_[];
double Low_[];
int level=3; // recounting's depth 
bool downloadhistory=false;
string tlu = "TrendlineUp";
string tld = "TrendlineDn";
string tlu1 = "1TrendlineUp";
string tld1 = "1TrendlineDn";
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int init()
  {
   IndicatorBuffers(5);
//---- drawing settings
   SetIndexStyle(0,DRAW_SECTION);
//---- indicator buffers mapping
   SetIndexBuffer(0,ZigzagBuffer);
   SetIndexBuffer(3,HighMapBuffer);
   SetIndexBuffer(4,LowMapBuffer);
   SetIndexEmptyValue(0,0.0);

   SetIndexStyle(1,DRAW_ARROW);
   SetIndexArrow(1,217);
   SetIndexBuffer(1,High_);
   SetIndexEmptyValue(1,0.0);
   SetIndexStyle(2,DRAW_ARROW);
   SetIndexArrow(2,218);
   SetIndexBuffer(2,Low_);
   SetIndexEmptyValue(2,0.0);


//---- indicator short name
   IndicatorShortName("ZigZag("+ExtDepth+","+ExtDeviation+","+ExtBackstep+")");
//---- initialization done
   return(0);
  }
//+------------------------------------------------------------------+
//| Custom indicator deinitialization function                       |
//+------------------------------------------------------------------+
int deinit()
  {
//----
   Comment("");
   if(ObjectFind(tld)!=-1) ObjectDelete(tld);
   if(ObjectFind(tlu)!=-1) ObjectDelete(tlu);
   if(ObjectFind(tld1)!=-1) ObjectDelete(tld1);
   if(ObjectFind(tlu1)!=-1) ObjectDelete(tlu1);
//   if(ObjectFind("FTLUp"+Symbol()+overtf)!=-1) ObjectDelete("FTLUp"+Symbol()+overtf);
//   if(ObjectFind("FTLDn"+Symbol()+overtf)!=-1) ObjectDelete("FTLDn"+Symbol()+overtf); 
//   if(setovertf)
//   {
//      GlobalVariablesDeleteAll("FTLUp"+Symbol()+Period());
//      GlobalVariablesDeleteAll("FTLDn"+Symbol()+Period());     
//   }
//----
   return(0);
  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int start()
  {
   int i, counted_bars = IndicatorCounted();
   int limit,counterZ,whatlookfor;
   int shift,back,lasthighpos,lastlowpos;
   double val,res;
   double curlow,curhigh,lasthigh,lastlow;

   if (counted_bars==0 && downloadhistory) // history was downloaded
     {
      ArrayInitialize(ZigzagBuffer,0.0);
      ArrayInitialize(HighMapBuffer,0.0);
      ArrayInitialize(LowMapBuffer,0.0);
      ArrayInitialize(High_,0.0);
      ArrayInitialize(Low_,0.0);
     }
   if (counted_bars==0) 
     {
      limit=Bars-ExtDepth;
      downloadhistory=true;
     }
   if (counted_bars>0) 
     {
      while (counterZ<level && i<100)
        {
         res=ZigzagBuffer[i];
         if (res!=0) counterZ++;
         i++;
        }
      i--;
      limit=i;
      if (LowMapBuffer[i]!=0) 
        {
         curlow=LowMapBuffer[i];
         whatlookfor=1;
        }
      else
        {
         curhigh=HighMapBuffer[i];
         whatlookfor=-1;
        }
      for (i=limit-1;i>=0;i--)  
        {
         ZigzagBuffer[i]=0.0;  
         LowMapBuffer[i]=0.0;
         HighMapBuffer[i]=0.0;
         Low_[i]=0.0;
         High_[i]=0.0;
        }
     }
      
   for(shift=limit; shift>=0; shift--)
     {
      val=Low[iLowest(NULL,0,MODE_LOW,ExtDepth,shift)];
      if(val==lastlow) val=0.0;
      else 
        { 
         lastlow=val; 
         if((Low[shift]-val)>(ExtDeviation*Point)) val=0.0;
         else
           {
            for(back=1; back<=ExtBackstep; back++)
              {
               res=LowMapBuffer[shift+back];
               if((res!=0)&&(res>val)) LowMapBuffer[shift+back]=0.0; 
              }
           }
        } 
      if (Low[shift]==val) LowMapBuffer[shift]=val; else LowMapBuffer[shift]=0.0;
      //--- high
      val=High[iHighest(NULL,0,MODE_HIGH,ExtDepth,shift)];
      if(val==lasthigh) val=0.0;
      else 
        {
         lasthigh=val;
         if((val-High[shift])>(ExtDeviation*Point)) val=0.0;
         else
           {
            for(back=1; back<=ExtBackstep; back++)
              {
               res=HighMapBuffer[shift+back];
               if((res!=0)&&(res<val)) HighMapBuffer[shift+back]=0.0; 
              } 
           }
        }
      if (High[shift]==val) HighMapBuffer[shift]=val; else HighMapBuffer[shift]=0.0;
     }

   // final cutting 
   if (whatlookfor==0)
     {
      lastlow=0;
      lasthigh=0;  
     }
   else
     {
      lastlow=curlow;
      lasthigh=curhigh;
     }
   for (shift=limit;shift>=0;shift--)
     {
      res=0.0;
      bool OutOfForLoop=False;
      switch(whatlookfor)
        {
         case 0: // look for peak or lawn 
            if (lastlow==0 && lasthigh==0)
              {
               if (HighMapBuffer[shift]!=0)
                 {
                  lasthigh=High[shift];
                  lasthighpos=shift;
                  whatlookfor=-1;
                  ZigzagBuffer[shift]=lasthigh;
                  High_[shift]=lasthigh+Point*otstup;
                  res=1;
                 }
               if (LowMapBuffer[shift]!=0)
                 {
                  lastlow=Low[shift];
                  lastlowpos=shift;
                  whatlookfor=1;
                  ZigzagBuffer[shift]=lastlow;
                  Low_[shift]=lastlow-Point*otstup;
                  res=1;
                 }
              }
             break;  
         case 1: // look for peak
            if (LowMapBuffer[shift]!=0.0 && LowMapBuffer[shift]<lastlow && HighMapBuffer[shift]==0.0)
              {
               ZigzagBuffer[lastlowpos]=0.0;
               Low_[lastlowpos]=0.0;
               lastlowpos=shift;
               lastlow=LowMapBuffer[shift];
               ZigzagBuffer[shift]=lastlow;
               Low_[shift]=lastlow-Point*otstup;
               res=1;
              }
            if (HighMapBuffer[shift]!=0.0 && LowMapBuffer[shift]==0.0)
              {
               lasthigh=HighMapBuffer[shift];
               lasthighpos=shift;
               ZigzagBuffer[shift]=lasthigh;
               High_[shift]=lasthigh+Point*otstup;
               whatlookfor=-1;
               res=1;
              }   
            break;               
         case -1: // look for lawn
            if (HighMapBuffer[shift]!=0.0 && HighMapBuffer[shift]>lasthigh && LowMapBuffer[shift]==0.0)
              {
               ZigzagBuffer[lasthighpos]=0.0;
               High_[lasthighpos]=0.0;
               lasthighpos=shift;
               lasthigh=HighMapBuffer[shift];
               ZigzagBuffer[shift]=lasthigh;
               High_[shift]=lasthigh+Point*otstup;
              }
            if (LowMapBuffer[shift]!=0.0 && HighMapBuffer[shift]==0.0)
              {
               lastlow=LowMapBuffer[shift];
               lastlowpos=shift;
               ZigzagBuffer[shift]=lastlow;
               Low_[shift]=lastlow-Point*otstup;
               whatlookfor=1;
              }   
            break;               
         default: OutOfForLoop=True; 
        }
        if(OutOfForLoop) break;
     }


//--------------------------

   double zzUp1=0,zzUp2=0;   
   double zzDn1=0,zzDn2=0;
   double zz1Up1=0,zz1Up2=0;   
   double zz1Dn1=0,zz1Dn2=0;
   datetime t1Up1, t1Up2, t1Dn1, t1Dn2;
   int iUp1,iUp2,iDn1,iDn2;
   double zzTmp;
   int j=0;
   int prnoedit=0;

   for(i=0;i<=1500;i++)
   {
      if(LowMapBuffer[i]>0.0 && HighMapBuffer[i]>0.0)
      {
         Low_[i]=0.0;
         High_[i]=0.0;
         if (ZigzagBuffer[i]>0.0)
            break;
      }
      if(LowMapBuffer[i]>0.0)
      {
         Low_[i]=0.0;
         if (ZigzagBuffer[i]>0.0)
            break;
      }
      if(HighMapBuffer[i]>0.0)
      {
         High_[i]=0.0;
         if (ZigzagBuffer[i]>0.0)
            break;
      }
   }
   
   for(i=0;i<=1500;i++)
   {
      zzTmp=0;//current
      if(Low_[i]>0) zzTmp=Low_[i];
   
      if(zzTmp>0.0 && j==0 && zzTmp==Low_[i] && zzDn1==0)  {zzDn1=zzTmp; iDn1=i; continue;}
      if(zzDn1!=0) j = 1;
      if(zzTmp>0.0 && zzTmp==Low_[i] && zzDn2==0)  {zzDn2=zzTmp; iDn2=i; continue;}

      if(zzDn1!=0 && zzDn2!=0) break;
   }

   j=0;
   for(i=0;i<=1500;i++)
   {
      zzTmp=0;//current
      if(High_[i]>0) zzTmp=High_[i];
   
      if(zzTmp>0.0 && j==0 && zzTmp==High_[i] && zzUp1==0) {zzUp1=zzTmp; iUp1=i; continue;}
      if(zzUp1!=0) j = 1;
      if(zzTmp>0.0 && zzTmp==High_[i] && zzUp2==0) {zzUp2=zzTmp; iUp2=i; continue;}
      if(zzUp1!=0 && zzUp2!=0) break;
   }

   bool showrline_ = false;
   if (showrline) showrline_ = true;
   else
   {
      if (zzUp1<=zzUp2) showrline_ = true;
   }
   if(zzUp1!=0.0 && zzUp2!=0.0 && showrline_==true)
   {// trend down
      if(ObjectFind(tld1)>-1)
      {
         t1Up1 = ObjectGet(tld1,OBJPROP_TIME2);
         zz1Up1 = ObjectGet(tld1,OBJPROP_PRICE2);
         t1Up2 = ObjectGet(tld1,OBJPROP_TIME1);
         zz1Up2 = ObjectGet(tld1,OBJPROP_PRICE1);
         if (zz1Up1==zzUp1 && zz1Up2==zzUp2 && t1Up1==iTime(NULL,0,iUp1) && t1Up2 == iTime(NULL,0,iUp2))
         {
            prnoedit = 1;
         }
         else
         {
            ObjectDelete(tld1);
         }
      
      }
   
      if (prnoedit == 0)
      {
         if(ObjectFind(tld)==-1)
          {
            if(ObjectCreate(tld,OBJ_TREND,0,iTime(NULL,0,iUp2),zzUp2,iTime(NULL,0,iUp1),zzUp1))
            {
                 ObjectSet(tld,OBJPROP_COLOR,linednc);                
                 ObjectSet(tld,OBJPROP_WIDTH,linednw);
                 ObjectSet(tld,OBJPROP_RAY,TRUE);
//                 alert2 = true;
            }
          }
         else 
         {
            t1Up1 = ObjectGet(tld,OBJPROP_TIME2);
            zz1Up1 = ObjectGet(tld,OBJPROP_PRICE2);
            t1Up2 = ObjectGet(tld,OBJPROP_TIME1);
            zz1Up2 = ObjectGet(tld,OBJPROP_PRICE1);
            if (zz1Up1!=zzUp1 || zz1Up2!=zzUp2 || t1Up1!=iTime(NULL,0,iUp1) || t1Up2 != iTime(NULL,0,iUp2))
            {
               ObjectSet(tld,OBJPROP_TIME1,iTime(NULL,0,iUp2));
               ObjectSet(tld,OBJPROP_PRICE1,zzUp2);
               ObjectSet(tld,OBJPROP_TIME2,iTime(NULL,0,iUp1));
               ObjectSet(tld,OBJPROP_PRICE2,zzUp1);
//               alert2 = true;
            }
         }
      }
   }// trend down
   else 
   {
//      if(zzUp1!=0.0)
//      {
//         if(ShowBadLine==false)
//         {
            if(ObjectFind(tld1)!=-1) ObjectDelete(tld1);
            if(ObjectFind(tld)!=-1) ObjectDelete(tld);
//         }
//      }
   }

   showrline_ = false;
   if (showrline) showrline_ = true;
   else
   {
      if (zzDn1>=zzDn2) showrline_ = true;
   }

   if(zzDn1!=0.0 && zzDn2!=0.0 && showrline_==true)
   {// trend up
      prnoedit = 0;

      if(ObjectFind(tlu1)>-1)
      {
         t1Dn1 = ObjectGet(tlu1,OBJPROP_TIME2);
         zz1Dn1 = ObjectGet(tlu1,OBJPROP_PRICE2);
         t1Dn2 = ObjectGet(tlu1,OBJPROP_TIME1);
         zz1Dn2 = ObjectGet(tlu1,OBJPROP_PRICE1);
         if (zz1Dn1==zzDn1 && zz1Dn2==zzDn2 && t1Dn1==iTime(NULL,0,iDn1) && t1Dn2 == iTime(NULL,0,iDn2))
         {
            prnoedit = 1;
         }
         else
         {
            ObjectDelete(tlu1);
         }
      
      }
   
      if (prnoedit == 0)
      {

         if(ObjectFind(tlu)==-1)
         {

            if(ObjectCreate(tlu,OBJ_TREND,0,iTime(NULL,0,iDn2),zzDn2,iTime(NULL,0,iDn1),zzDn1))
            {
                 ObjectSet(tlu,OBJPROP_COLOR,lineupc);                
                 ObjectSet(tlu,OBJPROP_WIDTH,lineupw);
                 ObjectSet(tlu,OBJPROP_RAY,TRUE);
//                 alert1 = true;
            }
      
         }
         else 
         {
            t1Dn1 = ObjectGet(tlu,OBJPROP_TIME2);
            zz1Dn1 = ObjectGet(tlu,OBJPROP_PRICE2);
            t1Dn2 = ObjectGet(tlu,OBJPROP_TIME1);
            zz1Dn2 = ObjectGet(tlu,OBJPROP_PRICE1);
            if (zz1Dn1!=zzDn1 || zz1Dn2!=zzDn2 || t1Dn1!=iTime(NULL,0,iDn1) || t1Dn2!=iTime(NULL,0,iDn2))
            {
               ObjectSet(tlu,OBJPROP_TIME1,iTime(NULL,0,iDn2));
               ObjectSet(tlu,OBJPROP_PRICE1,zzDn2);
               ObjectSet(tlu,OBJPROP_TIME2,iTime(NULL,0,iDn1));
               ObjectSet(tlu,OBJPROP_PRICE2,zzDn1);
//               alert1 = true;
            }
         }
      }
   }// trend up
   else
   {
//      if(zzDn1!=0.0)
//      {
//         if(ShowBadLine==false)
//         {
            if(ObjectFind(tlu1)!=-1) ObjectDelete(tlu1);
            if(ObjectFind(tlu)!=-1) ObjectDelete(tlu);
//         }
//      }
//   }
   }//----


//--------------------------

   return(0);
  }
//+------------------------------------------------------------------+