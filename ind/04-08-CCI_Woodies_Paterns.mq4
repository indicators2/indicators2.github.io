#property copyright "Copyright � 2008, Vico"

#property indicator_chart_window
#property indicator_buffers 8
#property indicator_color1 DarkGreen
#property indicator_color2 Red
#property indicator_color3 DodgerBlue
#property indicator_color4 FireBrick
#property indicator_color5 OrangeRed
#property indicator_color6 LimeGreen
#property indicator_color7 DarkOrange
#property indicator_color8 MidnightBlue

//////////////////////////////////////////////////////////////////////
// ���������                                                        //
//////////////////////////////////////////////////////////////////////

extern int fastPeriod  = 6;
extern int slowPeriod  = 14;
extern int histLength  = 300;
extern string step_info = "���������� ����� ��������� �� ���������";
extern int step = 50;

//////////////////////////////////////////////////////////////////////
// ������ ������                                                    //
//////////////////////////////////////////////////////////////////////
 
double ZlrBuffer[];     // 1. Zero-line Reject (ZLR)       -- trend 
double ShamuBuffer[];   // 2. Shamu Trade                  -- counter
double TlbBuffer[];     // 3. Trend Line Break (TLB)       -- both
double VegasBuffer[];   // 4. Vegas Trade (VT)			     -- counter
double GhostBuffer[];   // 5. Ghost Trade                  -- counter
double RevdevBuffer[];  // 6. Reverse Divergence           -- trend
double HooksBuffer[];   // 7. Hook from Extremes (HFE)     -- counter
double HtlbBuffer[];    // 8. Hor. Trend Line Break (HTLB) -- both

//////////////////////////////////////////////////////////////////////
// �������������                                                    //
//////////////////////////////////////////////////////////////////////

int init()
{
   string short_name;
   IndicatorBuffers(8);
   IndicatorDigits(MarketInfo(Symbol(),MODE_DIGITS));
   //////////////////////////////////////////////////////////////////
   // ������� ������������� ������� �� 1 �� 8. ��� ��������        //
   // � �������� �� ������ ������������ ������� �����,             //
   // ������ ������ ������-���������, ����� - ��� TLB � HTLB       //
   //////////////////////////////////////////////////////////////////
   short_name="Woodies CCI Paterns ("+fastPeriod+","+slowPeriod+")";
   IndicatorShortName(short_name);
   // Zero-line Reject (ZLR), trend
   SetIndexStyle(0, DRAW_ARROW, EMPTY, 1, DarkGreen);
   SetIndexBuffer(0, ZlrBuffer);    
   SetIndexArrow(0, 140);
   SetIndexLabel(0,"Zero-line Reject (ZLR), trend");
   SetIndexEmptyValue(0, EMPTY_VALUE);      
   SetIndexDrawBegin(0, slowPeriod);
   // Shamu Trade, counter-trend
   SetIndexStyle(1, DRAW_ARROW, EMPTY, 1, Red);
   SetIndexBuffer(1, ShamuBuffer);    
   SetIndexArrow(1, 141);
   SetIndexLabel(1,"Shamu Trade, counter-trend");
   SetIndexEmptyValue(1, EMPTY_VALUE);      
   SetIndexDrawBegin(1, slowPeriod);
   // Trend Line Break (TLB), both
   SetIndexStyle(2, DRAW_ARROW, EMPTY, 1, DodgerBlue);
   SetIndexBuffer(2, TlbBuffer);    
   SetIndexArrow(2, 142);
   SetIndexLabel(2,"Trend Line Break (TLB), both");
   SetIndexEmptyValue(2, EMPTY_VALUE);      
   SetIndexDrawBegin(2, slowPeriod);
   // Vegas Trade (VT), counter-trend
   SetIndexStyle(3, DRAW_ARROW, EMPTY, 1, FireBrick);
   SetIndexBuffer(3, VegasBuffer);    
   SetIndexArrow(3, 143);
   SetIndexLabel(3,"Vegas Trade (VT), counter-trend");
   SetIndexEmptyValue(3, EMPTY_VALUE);      
   SetIndexDrawBegin(3, slowPeriod);
   // Ghost Trade, counter-trend
   SetIndexStyle(4, DRAW_ARROW, EMPTY, 1, OrangeRed);
   SetIndexBuffer(4, GhostBuffer);    
   SetIndexArrow(4, 144);
   SetIndexLabel(4,"Ghost Trade, counter-trend");
   SetIndexEmptyValue(4, EMPTY_VALUE);      
   SetIndexDrawBegin(4, slowPeriod);
   // Reverse Divergence, trend
   SetIndexStyle(5, DRAW_ARROW, EMPTY, 1, LimeGreen);
   SetIndexBuffer(5, RevdevBuffer);    
   SetIndexArrow(5, 145);
   SetIndexLabel(5,"Reverse Divergence, trend");
   SetIndexEmptyValue(5, EMPTY_VALUE);      
   SetIndexDrawBegin(5, slowPeriod);
   // Hook from Extremes (HFE), counter-trend
   SetIndexStyle(6, DRAW_ARROW, EMPTY, 1, DarkOrange);
   SetIndexBuffer(6, HooksBuffer);    
   SetIndexArrow(6, 146);
   SetIndexLabel(6,"Hook from Extremes (HFE), counter-trend");
   SetIndexEmptyValue(6, EMPTY_VALUE);      
   SetIndexDrawBegin(6, slowPeriod);
   // Horizontal Trend Line Break (HTLB), both
   SetIndexStyle(7, DRAW_ARROW, EMPTY, 1, MidnightBlue);
   SetIndexBuffer(7, HtlbBuffer);    
   SetIndexArrow(7, 147);
   SetIndexLabel(7,"Horizontal Trend Line Break (HTLB), both");
   SetIndexEmptyValue(7, EMPTY_VALUE);      
   SetIndexDrawBegin(7, slowPeriod);
   //----
   return(0);
}
  
//////////////////////////////////////////////////////////////////////
// ���������������                                                  //                       
//////////////////////////////////////////////////////////////////////

int deinit()
{
   // TODO: add your code here
   return(0);
}

//////////////////////////////////////////////////////////////////////
// ����������� ���������                                            //
//////////////////////////////////////////////////////////////////////

int start()
{
   string symbolName;
   int i, shift, checksum, counted_bars=IndicatorCounted();
   if (Bars<slowPeriod) return(0); 
   // check for possible errors
   if (counted_bars<0) return(-1);
   // last counted bar will be recounted
   if (counted_bars>0) counted_bars++;
   int limit=Bars-slowPeriod-counted_bars;
   if (counted_bars<1 || checksum!=(histLength+fastPeriod+slowPeriod+Period()) || symbolName!=Symbol())
   {
      // ��������� ��������, �������� ��������������� 
      for(i=Bars-1;i<=Bars-histLength;i++) 
      {
          ZlrBuffer[Bars-i]=EMPTY_VALUE;
          ShamuBuffer[Bars-i]=EMPTY_VALUE;
          TlbBuffer[Bars-i]=EMPTY_VALUE;  
          VegasBuffer[Bars-i]=EMPTY_VALUE;
          GhostBuffer[Bars-i]=EMPTY_VALUE;
          RevdevBuffer[Bars-i]=EMPTY_VALUE;
          HooksBuffer[Bars-i]=EMPTY_VALUE;
          HtlbBuffer[Bars-i]=EMPTY_VALUE;      
       }
      checksum = histLength+fastPeriod+slowPeriod+Period(); 
      symbolName=Symbol();
      limit=histLength; 
   }
   for (shift=limit; shift>=0; shift--)
   {
      ///////////////////////////////////////////////////////////////
      //	���������� ������� ����� � ����������� ������             //
      ///////////////////////////////////////////////////////////////

      int delta=25, delta1=5, level=100;
      double slowCCI[100], fastCCI[100];        
      int a, up=0, dn=0, upnt=step,dpnt=step;
      for (a=100;a>=0;a--)
      {  
         fastCCI[a]=iCCI(NULL,0,fastPeriod,PRICE_TYPICAL,shift+a);       
         slowCCI[a]=iCCI(NULL,0,slowPeriod,PRICE_TYPICAL,shift+a);      
         if (slowCCI[a]>0) 
         {
            if(up>=2) dn=0;
            up++;
         }
         if (slowCCI[a]<0) 
         {
            if(dn>=2) up=0;
            dn++;
         }
		}
	   
      ///////////////////////////////////////////////////////////////
      // ������� � 1 - ������ �� ������� ����� (ZLR)               //
      // --------------------------------------------------------- //
      ///////////////////////////////////////////////////////////////

      delta=20; delta1=5; // ������� ������
      level=50; // �������, � �������� �������� �������� ������
      ZlrBuffer[shift]=EMPTY_VALUE;

      // ZLR � ���������� ������
      if ( MathAbs(slowCCI[2]-slowCCI[1])>delta1 )
      {
         if ( dn>=6 && up<3 &&
         slowCCI[0]<slowCCI[1]-delta && slowCCI[2]<slowCCI[1]-delta &&
         MathAbs(slowCCI[1])<=level )
         {
            ZlrBuffer[shift]=High[shift]+upnt*Point; 
            upnt=upnt+step;
         }
      }
      if ( MathAbs(slowCCI[2]-slowCCI[1])<=delta1 )
      {
         if ( dn>=6 && up<3 &&
         slowCCI[0]<slowCCI[1]-delta && slowCCI[3]<slowCCI[1]-delta && 
         MathAbs(slowCCI[1])<=level )
         {
            ZlrBuffer[shift]=High[shift]+upnt*Point; 
            upnt=upnt+step;
         }
      }

      // ZLR � ���������� ������
      if ( MathAbs(slowCCI[2]-slowCCI[1])>delta1 )
      {
         if ( up>=6 && dn<3 &&
         slowCCI[0]>slowCCI[1]+delta && slowCCI[2]>slowCCI[1]+delta && 
         MathAbs(slowCCI[1])<=level )
         {
            ZlrBuffer[shift]=Low[shift]-dpnt*Point;
            dpnt=dpnt+step;
         }	   
      }
      if ( MathAbs(slowCCI[2]-slowCCI[1])<=delta1 )
      {
         if ( up>=6 && dn<3 &&	   
         slowCCI[0]>slowCCI[1]+delta && slowCCI[3]>slowCCI[1]+delta && 
         MathAbs(slowCCI[1])<=level )
         {
            ZlrBuffer[shift]=Low[shift]-dpnt*Point;
            dpnt=dpnt+step;
         }	   
      }

      ///////////////////////////////////////////////////////////////
      // ������� � 2 - ���� (shamu trade)                          //
      // --------------------------------------------------------- //
      ///////////////////////////////////////////////////////////////

      delta=20; delta1=5; // ������� ������
      level=50; // ������� (+/-), � �������� ������� ������ �������������� �������
      ShamuBuffer[shift]=EMPTY_VALUE;

      // ���� � ���������� ������
      if ( MathAbs(slowCCI[3]-slowCCI[2])>delta1 )
      {
         if (dn>=6 && up<3 &&
         slowCCI[0]>slowCCI[1]+delta &&
         slowCCI[1]<slowCCI[2]-delta && slowCCI[2]>slowCCI[3]+delta && 
         slowCCI[1]<=level && slowCCI[1]>=-level && 
         slowCCI[2]<=level && slowCCI[2]>=-level) 
         {
            ShamuBuffer[shift]=Low[shift]-dpnt*Point;
            dpnt=dpnt+step;
         }
      }
      if ( MathAbs(slowCCI[3]-slowCCI[2])<=delta1 )
      {
         if (dn>=6 && up<3 &&
         slowCCI[0]>slowCCI[1]+delta &&
         slowCCI[1]<slowCCI[2]-delta && slowCCI[2]>slowCCI[4]+delta && 
         slowCCI[1]<=level && slowCCI[1]>=-level && 
         slowCCI[2]<=level && slowCCI[2]>=-level) 
         {
            ShamuBuffer[shift]=Low[shift]-dpnt*Point;
            dpnt=dpnt+step;
         }
      }

      // ���� � ���������� ������
      if ( MathAbs(slowCCI[3]-slowCCI[2])>delta1 )
      {
         if (up>=6 && dn<3 &&
         slowCCI[0]<slowCCI[1]-delta &&
         slowCCI[1]>slowCCI[2]+delta && slowCCI[2]<slowCCI[3]-delta && 
         slowCCI[1]<=level && slowCCI[1]>=-level && 
         slowCCI[2]<=level && slowCCI[2]>=-level) 
         {
            ShamuBuffer[shift]=Low[shift]-dpnt*Point;
            dpnt=dpnt+step;
         }
      }
      if ( MathAbs(slowCCI[3]-slowCCI[2])<=delta1 )
      {
         if (up>=6 && dn<3 &&
         slowCCI[0]<slowCCI[1]-delta &&
         slowCCI[1]>slowCCI[2]+delta && slowCCI[2]<slowCCI[4]-delta && 
         slowCCI[1]<=level && slowCCI[1]>=-level && 
         slowCCI[2]<=level && slowCCI[2]>=-level) 
         {
            ShamuBuffer[shift]=Low[shift]-dpnt*Point;
            dpnt=dpnt+step;
         }
      }

      ///////////////////////////////////////////////////////////////
      // ������� � 3 - ������ ����� ������ (TLB)                   //
      // --------------------------------------------------------- //        
      ///////////////////////////////////////////////////////////////

      int min1=0,min2=0,min3=0,max1=0,max2=0,max3=0;        // �������� ���/��� 
      int tmin1=0,tmin2=0,tmin3=0,tmax1=0,tmax2=0,tmax3=0;  // ����� ���/���
      double line;      
      double line1;      

      delta=25; delta1=5; 
      level=50;
      TlbBuffer[shift]=EMPTY_VALUE;      
 
      //	����������� ���/���� � ���������� ����� ����������� ������
      if (up>=6 && dn<3)
      {
         min1=0; min2=0; max1=0; max2=0;
         tmin1=0; tmin2=0; tmax1=0; tmax2=0;
         for (a=0;a<up+dn-1;a++)
         { 
            // ����������� ����������
            if (slowCCI[a]<=slowCCI[a+1]-delta1 && slowCCI[a+1]>=slowCCI[a+2]+delta1)
			   {
               if (max1!=0 && max2==0)
               {
                  max2=slowCCI[a+1];
                  tmax2=a+1;
               }
               if (max1==0)
               {
                  max1=slowCCI[a+1];
                  tmax1=a+1;
               }
            }
            // ����������� ���������
            if (slowCCI[a]>=slowCCI[a+1]+delta1 && slowCCI[a+1]<=slowCCI[a+2]-delta1)
			   {
               if (min1!=0 && min2==0)
               {
                  min2=slowCCI[a+1];
                  tmin2=a+1;
               }
               if (min1==0)
               {
                  min1=slowCCI[a+1];
                  tmin1=a+1;
               }
            }
         }

         // ����������� ����� ������
         if (tmax1!=0 && tmax2!=0)
         {
            line=max1-tmax1*(max1-max2)/(tmax1-tmax2);
            line1=max1+(1-tmax1)*(max1-max2)/(tmax1-tmax2);
            if (slowCCI[0]>line && slowCCI[1]<line1)
            {
               TlbBuffer[shift]=Low[shift]-dpnt*Point;
               dpnt=dpnt+step;
            }
         }
         //  ������ ����� ������
         if (tmin1!=0 && tmin2!=0)
         {
            line=min1-tmin1*(min1-min2)/(tmin1-tmin2);
            line1=min1+(1-tmin1)*(min1-min2)/(tmin1-tmin2);
            if (slowCCI[0]<line && slowCCI[1]>line1)
            {
               TlbBuffer[shift]=High[shift]+upnt*Point;
               upnt=upnt+step;
            }
         }
      }

      //	����������� ���/���� � ���������� ����� ����������� ������
      if (dn>=6 && up<3)
      {
         min1=0; min2=0; max1=0; max2=0;
         tmin1=0; tmin2=0; tmax1=0; tmax2=0;
         for (a=0;a<dn+up-1;a++)
         { 
            // ����������� ����������
            if (slowCCI[a]>=slowCCI[a+1]+delta1 && slowCCI[a+1]<=slowCCI[a+2]-delta1)
			   {
               if (max1!=0 && max2==0)
               {
                  max2=slowCCI[a+1];
                  tmax2=a+1;
               }
               if (max1==0)
               {
                  max1=slowCCI[a+1];
                  tmax1=a+1;
               }
            }
            // ����������� ���������
            if (slowCCI[a]<=slowCCI[a+1]-delta1 && slowCCI[a+1]>=slowCCI[a+2]+delta1)
			   {
               if (min1!=0 && min2==0)
               {
                  min2=slowCCI[a+1];
                  tmin2=a+1;
               }
               if (min1==0)
               {
                  min1=slowCCI[a+1];
                  tmin1=a+1;
               }
            }
         }

         // ����������� ����� ������
         if (tmax1!=0 && tmax2!=0)
         {
            line=max1-tmax1*(max1-max2)/(tmax1-tmax2);
            line1=max1+(1-tmax1)*(max1-max2)/(tmax1-tmax2);
            if (slowCCI[0]<line && slowCCI[1]>line1)
            {
               TlbBuffer[shift]=Low[shift]-dpnt*Point;
               dpnt=dpnt+step;
            }
         }
         //  ������ ����� ������
         if (tmin1!=0 && tmin2!=0)
         {
            line=min1-tmin1*(min1-min2)/(tmin1-tmin2);
            line1=min1+(1-tmin1)*(min1-min2)/(tmin1-tmin2);
            if (slowCCI[0]>line && slowCCI[1]<line1)
            {
               TlbBuffer[shift]=High[shift]+upnt*Point;
               upnt=upnt+step;
            }
         }
      }

      ///////////////////////////////////////////////////////////////
      // ������� � 4 - ����� (VT)                                  //
      // --------------------------------------------------------- //  
      ///////////////////////////////////////////////////////////////

      delta=30; delta1=5; // ������� ������
      level=200; 
      VegasBuffer[shift]=EMPTY_VALUE;        

      // ����� � ���������� ������
      if  (dn>=6 && up<3)
      {
         max1=0; max2=0; tmax1=0; tmax2=0;
         min1=0; tmin1=0;
         for (a=0;a<dn+up-1;a++)
         {
            // ����������� ����� � ���������� ������
            if (slowCCI[a]<slowCCI[a+1] && slowCCI[a+1]>slowCCI[a+2] && min1==0)
            {
               min1=slowCCI[a+1];
               tmin1=a+1;
			   }
            if (slowCCI[a]>slowCCI[a+1] && slowCCI[a+1]<slowCCI[a+2])
            {				
					if (max1!=0 && max2==0)
					{
                  max2=slowCCI[a+1];
                  tmax2=a+1;
               }
               if (max1==0)
               {
                  max1=slowCCI[a+1];
                  tmax1=a+1;
               }
            }
         }
         if (max1!=0 && max2!=0 && min1!=0 && max1<0 && max2<0 && min1<0 && 
         min1>max1+delta1 && max2<=-level && max1>-level+delta && slowCCI[0]>min1 && slowCCI[1]<min1 && 
         MathAbs(tmax2-tmin1)>=3 && MathAbs(tmax2-tmax1)>=6 && MathAbs(tmax2-tmax1)<13)
         {
            VegasBuffer[shift]=Low[shift]-dpnt*Point;
            dpnt=dpnt+step;	
         }
	   }
      //  ����� � ���������� ������
      if (up>=6 && dn<3) 
      {
         max1=0; max2=0; tmax1=0; tmax2=0;
         min1=0; tmin1=0;
         for (a=0;a<up+dn-1;a++)
         {
            // ����������� ����� � ���������� ������
            if (slowCCI[a]>slowCCI[a+1] && slowCCI[a+1]<slowCCI[a+2] && min1==0)
            {
               min1=slowCCI[a+1];
               tmin1=a+1;
			   }
            if (slowCCI[a]<slowCCI[a+1] && slowCCI[a+1]>slowCCI[a+2])
            {				
					if (max1!=0 && max2==0)
					{
                  max2=slowCCI[a+1];
                  tmax2=a+1;
               }
               if (max1==0)
               {
                  max1=slowCCI[a+1];
                  tmax1=a+1;
               }
            }
         }
         // -----
         if (max1!=0 && max2!=0 && min1!=0 && max1>0 && max2>0 && min1>0 && 
         min1<max1-delta1 && max2>=level && max1<level-delta && slowCCI[0]<min1 && slowCCI[1]>min1 && 
         MathAbs(tmax2-tmin1)>=3 && MathAbs(tmax2-tmax1)>=6 && MathAbs(tmax2-tmax1)<13)
         {
			   VegasBuffer[shift]=High[shift]+upnt*Point;
            upnt=upnt+step;			
         }
      }      
      
      ///////////////////////////////////////////////////////////////
      // ������� � 5 - ������� (Ghost)                             //
      // --------------------------------------------------------- //  
      ///////////////////////////////////////////////////////////////

      delta=15; delta1=5;  // ������� ������
      GhostBuffer[shift]=EMPTY_VALUE;        

      // ������� � ���������� ������
      if (up>=6 && dn<3)
      {  
         max1=0; max2=0; max3=0; tmax1=0; tmax2=0; tmax3=0;
         min1=0; min2=0; tmin1=0; tmin2=0;
         for (a=0;a<up+dn-1;a++)
         {
            // ����������� ���������� � ���������
            if (slowCCI[a]<=slowCCI[a+1]-delta1 && slowCCI[a+1]>=slowCCI[a+2]+delta1)
			   {
				  if (max2!=0 && max3==0) 
				  {
				     max3=slowCCI[a+1];
				     tmax3=a+1;
				  }
				  if (max1!=0 && max2==0) 
				  {
				     max2=slowCCI[a+1];
				     tmax2=a+1;
				  }
				  if (max1==0) 
				  {
				     max1=slowCCI[a+1];
				     tmax1=a+1;
				  }
			   }
            if (slowCCI[a]>=slowCCI[a+1]+delta1 && slowCCI[a+1]<=slowCCI[a+2]-delta1)
			   {
				  if (min1!=0 && min2==0)
				  { 
                 min2=slowCCI[a+1];
                 tmin2=a+1;
				  }
				  if (min1==0) 
				  {
                 min1=slowCCI[a+1];
                 tmin1=a+1;
              }
			   }
         }
         if (tmin1!=0 && tmin2!=0)
         {
            line=min1-tmin1*(min1-min2)/(tmin1-tmin2);
            line1=min1+(1-tmin1)*(min1-min2)/(tmin1-tmin2);
            if (max1>0 && max2>0 && max3>0 && max2>max1+delta && max2>max3+delta &&
            tmax1<tmin1 && tmin1<tmax2 && tmax2<tmin2 && tmin2<tmax3 &&
            slowCCI[0]<line && slowCCI[1]>line1)
            {
               GhostBuffer[shift]=High[shift]+upnt*Point;
               upnt=upnt+step;			
            }
         }
      }

      // ������� � ���������� ������
      if (dn>=6 && up<3)
      {  
         max1=0; max2=0; max3=0; tmax1=0; tmax2=0; tmax3=0;
         min1=0; min2=0; tmin1=0; tmin2=0;
         for (a=0;a<dn+up-1;a++)
         {
            // ����������� ���������� � ���������
            if (slowCCI[a]>=slowCCI[a+1]+delta1 && slowCCI[a+1]<=slowCCI[a+2]-delta1)
			   {
				  if (max2!=0 && max3==0) 
				  {
				     max3=slowCCI[a+1];
				     tmax3=a+1;
				  }
				  if (max1!=0 && max2==0) 
				  {
				     max2=slowCCI[a+1];
				     tmax2=a+1;
				  }
				  if (max1==0) 
				  {
				     max1=slowCCI[a+1];
				     tmax1=a+1;
				  }
			   }
            if (slowCCI[a]<=slowCCI[a+1]-delta1 && slowCCI[a+1]>=slowCCI[a+2]+delta1)
			   {
				  if (min1!=0 && min2==0)
				  { 
                 min2=slowCCI[a+1];
                 tmin2=a+1;
				  }
				  if (min1==0) 
				  {
                 min1=slowCCI[a+1];
                 tmin1=a+1;
              }
			   }
         }
         if (tmin1!=0 && tmin2!=0)
         {
            line=min1-tmin1*(min1-min2)/(tmin1-tmin2);
            line1=min1+(1-tmin1)*(min1-min2)/(tmin1-tmin2);
            if (max1<0 && max2<0 && max3<0 && max2<max1-delta && max2<max3-delta &&
            tmax1<tmin1 && tmin1<tmax2 && tmax2<tmin2 && tmin2<tmax3 &&
            slowCCI[0]>line && slowCCI[1]<line1)
            {
               GhostBuffer[shift]=High[shift]+upnt*Point;
               upnt=upnt+step;			
            }
         }
      }

      ///////////////////////////////////////////////////////////////
      // ������� � 6 - ����������� ����������� (Rev Diver)         //
      // --------------------------------------------------------- //  
      ///////////////////////////////////////////////////////////////

      delta=50; delta1=5;  // ������� ������
      level=100;
      RevdevBuffer[shift]=EMPTY_VALUE;        

      // ����������� ����������� � ���������� ������
      if (up>=6 && dn<3)
      {
         min1=0; min2=0; max1=0; max2=0;
         tmin1=0; tmin2=0; tmax1=0; tmax2=0;
         for (a=0;a<up+dn-1;a++)
         { 
            // ����������� ����������
            if (slowCCI[a]<=slowCCI[a+1]-delta1 && slowCCI[a+1]>=slowCCI[a+2]+delta1)
			   {
               if (max1!=0 && max2==0)
               {
                  max2=slowCCI[a+1];
                  tmax2=a+1;
               }
               if (max1==0)
               {
                  max1=slowCCI[a+1];
                  tmax1=a+1;
               }
            }
            // ����������� ���������
            if (slowCCI[a]>=slowCCI[a+1]+delta1 && slowCCI[a+1]<=slowCCI[a+2]-delta1)
			   {
               if (min1!=0 && min2==0)
               {
                  min2=slowCCI[a+1];
                  tmin2=a+1;
               }
               if (min1==0)
               {
                  min1=slowCCI[a+1];
                  tmin1=a+1;
               }
            }
         }
         if (tmax1!=0 && tmax2!=0)
         {
            line=max1-tmax1*(max1-max2)/(tmax1-tmax2);
            line1=max1+(1-tmax1)*(max1-max2)/(tmax1-tmax2);
            if (min1<min2-delta1 && tmin1<tmax1 && tmax1<tmin2 && tmin2<tmax2 && 
            min1<level && min2<level && slowCCI[0]>line && slowCCI[1]<line1)
            {
               RevdevBuffer[shift]=High[shift]+upnt*Point;
               upnt=upnt+step;
            }
         }
      }

      //	����������� ����������� � ���������� ������
      if (dn>=6 && up<3)
      {
         min1=0; min2=0; max1=0; max2=0;
         tmin1=0; tmin2=0; tmax1=0; tmax2=0;
         for (a=0;a<dn+up-1;a++)
         { 
            // ����������� ����������
            if (slowCCI[a]>=slowCCI[a+1]+delta1 && slowCCI[a+1]<=slowCCI[a+2]-delta1)
			   {
               if (max1!=0 && max2==0)
               {
                  max2=slowCCI[a+1];
                  tmax2=a+1;
               }
               if (max1==0)
               {
                  max1=slowCCI[a+1];
                  tmax1=a+1;
               }
            }
            // ����������� ���������
            if (slowCCI[a]<=slowCCI[a+1]-delta1 && slowCCI[a+1]>=slowCCI[a+2]+delta1)
			   {
               if (min1!=0 && min2==0)
               {
                  min2=slowCCI[a+1];
                  tmin2=a+1;
               }
               if (min1==0)
               {
                  min1=slowCCI[a+1];
                  tmin1=a+1;
               }
            }
         }
         if (tmax1!=0 && tmax2!=0)
         {
            line=max1-tmax1*(max1-max2)/(tmax1-tmax2);
            line1=max1+(1-tmax1)*(max1-max2)/(tmax1-tmax2);
            if (min1>min2+delta1 && tmin1<tmax1 && tmax1<tmin2 && tmin2<tmax2 && 
            min1>-level && min2>-level && slowCCI[0]<line && slowCCI[1]>line1)
            {
               RevdevBuffer[shift]=High[shift]+upnt*Point;
               upnt=upnt+step;
            }
         }
      }

      ///////////////////////////////////////////////////////////////
      // ������� � 7 - ������������� ���� (HFE)                    //
      // --------------------------------------------------------- //        
      ///////////////////////////////////////////////////////////////

      delta=20; level=200;
      HooksBuffer[shift]=EMPTY_VALUE;        
      // HFE � ���������� ������
      if (slowCCI[1]<-level && slowCCI[0]>-level && slowCCI[1]<slowCCI[0]-delta)
      {
         HooksBuffer[shift]=Low[shift]-dpnt*Point;
         dpnt=dpnt+step;
      }
      // HFE ���������� ������
      if (slowCCI[1]>level && slowCCI[0]<level && slowCCI[1]>slowCCI[0]+delta)
      {
         HooksBuffer[shift]=High[shift]+upnt*Point;
         upnt=upnt+step;
      } 
     
      ///////////////////////////////////////////////////////////////
      // ������� � 3 - ������ �������������� ����� ������ (HTLB)   //
      // --------------------------------------------------------- //        
      ///////////////////////////////////////////////////////////////

      delta=25; delta1=5; 
      level=50;
      HtlbBuffer[shift]=EMPTY_VALUE;
 
      //	����������� ���/���� � ���������� �������������� ����� ����������� ������
      if (up>=6 && dn<3)
      {            
         min1=0; min2=0; min3=0; max1=0; max2=0; max3=0;
         for (a=0;a<up+dn-1;a++)
         { 
            // ����������� ����������
            if (slowCCI[a]<=slowCCI[a+1]-delta1 && slowCCI[a+1]>=slowCCI[a+2]+delta1)
			   {
               if (max2!=0 && max3==0) max3=slowCCI[a+1];
               if (max1!=0 && max2==0) max2=slowCCI[a+1];
               if (max1==0) max1=slowCCI[a+1];
            }
            // ����������� ���������
            if (slowCCI[a]>=slowCCI[a+1]+delta1 && slowCCI[a+1]<=slowCCI[a+2]-delta1)
			   {
               if (min2!=0 && min3==0) min3=slowCCI[a+1];
               if (min1!=0 && min2==0) min2=slowCCI[a+1];
               if (min1==0) min1=slowCCI[a+1];
            }
         }

         // ����������� �������������� ����� ������
         if (MathAbs(max1-max2)<10 && MathAbs(max2-max3)<10 && MathAbs(max1-max3)<10 &&
         slowCCI[0]>max1+delta && slowCCI[0]>max2+delta && slowCCI[0]>max3+delta && max1>0 && max2>0 &&max3>0)
         {
            HtlbBuffer[shift]=Low[shift]-dpnt*Point;
            dpnt=dpnt+step;
         }
         //  ������ �������������� ����� ������
         if (MathAbs(min1-min2)<10 && MathAbs(min2-min3)<10 && MathAbs(min1-min3)<10 &&
         slowCCI[0]<min1-delta && slowCCI[0]<min2-delta && slowCCI[0]<min3-delta &&
         slowCCI[1]>min1-delta && slowCCI[1]>min2-delta && slowCCI[1]>min3-delta &&
         min1<=level && min2<=level && min3<=level && min1>0 && min2>0 && min3>0)	
         {
            HtlbBuffer[shift]=High[shift]+upnt*Point;
            upnt=upnt+step;
         }
      }

      //	����������� ���/���� � ���������� �������������� ����� ����������� ������
      if (dn>=6 && up<3)
      {            
         min1=0; min2=0; min3=0; max1=0; max2=0; max3=0;
         for (a=0;a<dn+up-1;a++)
         { 
            // ����������� ����������
            if (slowCCI[a]>=slowCCI[a+1]+delta1 && slowCCI[a+1]<=slowCCI[a+2]-delta1)
			   {
               if (max2!=0 && max3==0) max3=slowCCI[a+1];
               if (max1!=0 && max2==0) max2=slowCCI[a+1];
               if (max1==0) max1=slowCCI[a+1];
            }
            // ����������� ���������
            if (slowCCI[a]<=slowCCI[a+1]-delta1 && slowCCI[a+1]>=slowCCI[a+2]+delta1)
			   {
               if (min2!=0 && min3==0) min3=slowCCI[a+1];
               if (min1!=0 && min2==0) min2=slowCCI[a+1];
               if (min1==0) min1=slowCCI[a+1];
            }
         }

         // ����������� �������������� ����� ������
         if (MathAbs(max1-max2)<10 && MathAbs(max2-max3)<10 && MathAbs(max1-max3)<10 &&
         slowCCI[0]<max1-delta && slowCCI[0]<max2-delta && slowCCI[0]<max3-delta
         && max1<0 && max2<0 && max3<0)
         {
            HtlbBuffer[shift]=Low[shift]-dpnt*Point;
            dpnt=dpnt+step;
         }
         //  ������ �������������� ����� ������
         if (MathAbs(min1-min2)<10 && MathAbs(min2-min3)<10 && MathAbs(min1-min3)<10 &&
         slowCCI[0]>min1+delta && slowCCI[0]>min2+delta && slowCCI[0]>min3+delta &&
         slowCCI[1]<min1+delta && slowCCI[1]<min2+delta && slowCCI[1]<min3+delta &&
         min1>=-level && min2>=-level && min3>=-level && min1<0 && min2<0 && min3<0)	
         {
            HtlbBuffer[shift]=High[shift]+upnt*Point;
            upnt=upnt+step;
         }
      }

      ///////////////////////////////////////////////////////////////
      // ������ �� �����
      // -----------------------------------------------------------
      // 1. �������� (CCI(14) �������� ���� ��� ������� ��������	
      // 2. ������ CCI ����� ������ (TLB)		
      // 3. CCI(6) ���������� CCI(14) ��������		
      // 4. CCI ���������� ������� ����� (ZLC).
      // 5. ����� CCI 14 �������� ���� ����� ������ +/-200 ��� �� ���
      // 6. CCI (��� �������� ��� ������)
      // -----------------------------------------------------------


   }    
   return(0);
}


