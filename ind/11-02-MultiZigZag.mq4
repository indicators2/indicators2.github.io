//+------------------------------------------------------------------+
//| MultiZigZag                                                      |
//+------------------------------------------------------------------+
/*

  31 ������� 2008 �.


������� ��������� - ��������� ����������. 
� ������ ���������� ������������ ��������� ��� ���� ��������. 
������ ����� - ��� ������� �������, ������ - ��� �������, ������ - ��� ��������. ����� �������.

� ��������� ��� �������. 

ExtDepth, ExtDeviation � ExtBackstep - ����������� ��������� ��� �������.
���� ������ ExtDepth=0, �� ��������������� ������ ���������� �� �����.
ExtMaxBar - ���������� �����, �� ������� �������������� ������.
GrossPeriod - ������� ��������, �� ������ � ������� �������� ������. ��� ������ 0 ������ ��������� �� ������� ����������.
ExtReCalculate - ���������� ����������� �������, ������� � 0, ��������������� � ������ ��������� �������. ����������� ��� �������� �� ������� �����������.

 */
#property link   "nen"
//  ��������� ���������� � �������� ����
#property indicator_chart_window
//  ���������� ������������ ��������
#property indicator_buffers  6
//  ���� ����������
#property indicator_color1 Aqua
//#property indicator_color2 Aqua
#property indicator_color3 Red
//#property indicator_color4 Aqua
#property indicator_color5 Yellow
//#property indicator_color6 Aqua
//  ������� ������������ �����
#property indicator_width1 0
#property indicator_width2 0
#property indicator_width3 0
#property indicator_width4 0
#property indicator_width5 0
#property indicator_width6 0
//  �����  ������������ �����
#property indicator_style1 0
#property indicator_style2 0
#property indicator_style3 0
#property indicator_style4 0
#property indicator_style5 0
#property indicator_style6 0
//  ������� ��������� ���������� 
/*
extern string ExtDepth     = "14,28,102";
extern string ExtDeviation = "1,8,21";
extern string ExtBackstep  = "3,5,12";
extern string ExtMaxBar    = "1000,1000,1000";    // ���������� ������������� ����� (0-���)
extern string GrossPeriod  = "0,0,0";     // ����������, �� ������� �������������� �������, 0 - ������� ���������
*/
extern string ExtDepth     = "12,12,12";
extern string ExtDeviation = "5,5,5";
extern string ExtBackstep  = "8,8,8";
extern string ExtMaxBar    = "1000,300,150";    // ���������� ������������� ����� (0-���)
extern string GrossPeriod  = "60,240,1440";     // ����������, �� ������� �������������� �������, 0 - ������� ���������
extern int    ExtReCalculate  = 3;              // ���������� ����������� ������� �������� ����������, ������� � 0, ���������������
                                                // � ������ ��������� �������

int ExtDepth_[]={0,0,0}, ExtDeviation_[]={0,0,0}, ExtBackstep_[]={0,0,0}, ExtMaxBar_[]={0,0,0}, GrossPeriod_[]={0,0,0};

//  ������������ ������
double LowestBuffer1[],HighestBuffer1[],LowestBuffer2[],HighestBuffer2[],LowestBuffer3[],HighestBuffer3[];
//  ��������������� ������
double LowestBufferGross1[],HighestBufferGross1[],LowestBufferGross2[],HighestBufferGross2[],LowestBufferGross3[],HighestBufferGross3[];
datetime time2[]={0,0,0};
//  �����, ������������, ��� �� �������� �� �������������� �������������� ������� �����������
bool Grosstf_DT[]={false, false, false};
//  �����, ������������, ��� �� ������� ������ ��������
bool ZZ_tf[]={false, false, false};
//  �������� ������� ������ � ����� ������� ����
datetime L2LTime[]={0,0,0},L2HTime[]={0,0,0};
//  ��� ������ �� �������� ���������� lBar, hBar � tiZZ ������������ ������ �������
//  �� ���� ������ ��� ������ �� ������� ��� ������������ ���� ������������ ������. 
//  ��� ��������� ������������ �� �� ������ ����.
double lBar[]={0,0,0}, hBar[]={0,0,0};
datetime tiZZ[]={0,0,0};
//  ���������� ��� �������� �������� Bars
int saveBars[]={0,0,0};
int currentBars;
//  ����������, �������� ���������� �����, �� ������� �������������� ������
int limit;

//+------------------------------------------------------------------+
//| Initialization function. ������.                                 |
//+------------------------------------------------------------------+
int init()
  {
   int i,j,m;

// �� ��� ������������ ������� ������������ ��� ����� ������� �������
   SetIndexBuffer(0,LowestBuffer1);
   SetIndexBuffer(1,HighestBuffer1);
   SetIndexBuffer(2,LowestBuffer2);
   SetIndexBuffer(3,HighestBuffer2);
   SetIndexBuffer(4,LowestBuffer3);
   SetIndexBuffer(5,HighestBuffer3);
// ����� ���������� ������� � ���� ������� ZigZag 
   SetIndexStyle(0,DRAW_ZIGZAG);
   SetIndexStyle(1,DRAW_ZIGZAG);
   SetIndexStyle(2,DRAW_ZIGZAG);
   SetIndexStyle(3,DRAW_ZIGZAG);
   SetIndexStyle(4,DRAW_ZIGZAG);
   SetIndexStyle(5,DRAW_ZIGZAG);
// ��������� �������� ����������, ������� �� ����� ������ �� �������
   SetIndexEmptyValue(0,0.0);
   SetIndexEmptyValue(1,0.0);
   SetIndexEmptyValue(2,0.0);
   SetIndexEmptyValue(3,0.0);
   SetIndexEmptyValue(4,0.0);
   SetIndexEmptyValue(5,0.0);
// ����� ��� ���� ������ � ����� ��� ��������
   SetIndexLabel(0,"Low1" );
   SetIndexLabel(1,"High1");
   SetIndexLabel(2,"Low2" );
   SetIndexLabel(3,"High2");
   SetIndexLabel(4,"Low3" );
   SetIndexLabel(5,"High3");

   _stringtoarray (ExtDepth, ExtDepth_, 3);
   _stringtoarray (ExtDeviation, ExtDeviation_, 3);
   _stringtoarray (ExtBackstep, ExtBackstep_, 3);
   _stringtoarray (ExtMaxBar, ExtMaxBar_, 3);
   _stringtoarray (GrossPeriod, GrossPeriod_, 3);

   for (i=0;i<3;i++)
     {
      Grosstf_DT[i]=false; ZZ_tf[i]=false;
      j=GrossPeriod_[i];
      GrossPeriod_[i]=_period(i,j);
      if (ExtDepth_[i]>=ExtBackstep_[i]) m=ExtDepth_[i]; else m=ExtBackstep_[i];
      if ((ExtMaxBar_[i]>iBars(NULL,GrossPeriod_[i])-m) || (ExtMaxBar_[i]==0)) limit=iBars(NULL,GrossPeriod_[i])- m; else limit=ExtMaxBar_[i];

      if (i==0)
        {
         arr_resize(LowestBufferGross1, HighestBufferGross1, limit+m, i);
        }
      else if (i==1)
        {
         arr_resize(LowestBufferGross2, HighestBufferGross2, limit+m, i);
        }
      else if (i==2)
        {
         arr_resize(LowestBufferGross3, HighestBufferGross3, limit+m, i);
        }
     }

   currentBars=0;
// ���������� �������������

   return(0);
  }
//+------------------------------------------------------------------+
//| Initialization function. �����.                                  |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//| ������ ����������. ������.                                       |
//+------------------------------------------------------------------+
int start()
  {
   int i, m;
   bool calculate;

   if (Bars-currentBars+1>2)
     {
      for (i=0;i<3;i++)
        {
         saveBars[i]=0;
        }
     }

   currentBars=Bars;

   for (i=0;i<3;i++)
     {
      // �������� ��� ����������� ������� ����������
      if ((iBars(NULL,GrossPeriod_[i])-1<ExtDepth_[i]) || (ExtDepth_[i]<=0)) continue;

      calculate=false;

      limit=iBars(NULL,GrossPeriod_[i])-saveBars[i]+1;

      if (limit>2)
        {
         calculate=true;
         Grosstf_DT[i]=false;
         ZZ_tf[i]=false;

         if (ExtDepth_[i]>=ExtBackstep_[i]) m=ExtDepth_[i]; else m=ExtBackstep_[i];
         if ((ExtMaxBar_[i]>iBars(NULL,GrossPeriod_[i])-m) || (ExtMaxBar_[i]==0)) limit=iBars(NULL,GrossPeriod_[i])- m; else limit=ExtMaxBar_[i];

         if (i==0)
           {
            arr_resize(LowestBufferGross1, HighestBufferGross1, limit+m, i);

            ArrayInitialize(LowestBuffer1,0); ArrayInitialize(HighestBuffer1,0);
           }
         else if (i==1)
           {
            arr_resize(LowestBufferGross2, HighestBufferGross2, limit+m, i);

            ArrayInitialize(LowestBuffer2,0); ArrayInitialize(HighestBuffer2,0); 
           }
         else if (i==2)
           {
            arr_resize(LowestBufferGross3, HighestBufferGross3, limit+m, i);

            ArrayInitialize(LowestBuffer3,0); ArrayInitialize(HighestBuffer3,0); 
          }

        }
      else
        {
         if (lBar[i]>iLow(NULL,GrossPeriod_[i],0) || hBar[i]<iHigh(NULL,GrossPeriod_[i],0) || tiZZ[i]!=iTime(NULL,GrossPeriod_[i],0))
           {
            calculate=true;
           }
        }

      if (calculate)
        {
         switch (i)
           {
            case 0:
              {
               if (GrossPeriod_[i]==0)
                 {
                  ZigZag_(LowestBuffer1, HighestBuffer1, i);
                 }
               else
                 {
                  if (limit==2) Shift_elements(LowestBufferGross1,HighestBufferGross1);

                  if (ZigZag_(LowestBufferGross1, HighestBufferGross1, i)==0)
                    {
                     ZigZagDT (LowestBuffer1, HighestBuffer1, LowestBufferGross1, HighestBufferGross1, i);
                    }
                 }

               break;
              }
            case 1:
              {
               if (GrossPeriod_[i]==0)
                 {
                  ZigZag_(LowestBuffer2, HighestBuffer2, i);
                 }
               else
                 {
                  if (limit==2) Shift_elements(LowestBufferGross2,HighestBufferGross2);

                  if (ZigZag_(LowestBufferGross2, HighestBufferGross2, i)==0)
                    {
                     ZigZagDT (LowestBuffer2, HighestBuffer2, LowestBufferGross2, HighestBufferGross2, i);
                    }
                 }

               break;
              }
            case 2:
              {
               if (GrossPeriod_[i]==0)
                 {
                  ZigZag_(LowestBuffer3, HighestBuffer3, i);
                 }
               else
                 {
                  if (limit==2) Shift_elements(LowestBufferGross3,HighestBufferGross3);

                  if (ZigZag_(LowestBufferGross3, HighestBufferGross3, i)==0)
                    {
                     ZigZagDT (LowestBuffer3, HighestBuffer3, LowestBufferGross3, HighestBufferGross3, i);
                    }
                 }

               break;
              }
           }

        }
     }

 // ���������� ���������� ����������
   return(0);
  }
//+------------------------------------------------------------------+
//| ������ ����������. �����.                                        |
//+------------------------------------------------------------------+


//+------------------------------------------------------------------+
// ������������ � �������
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|  �������� ZigZag. ������.                                        |
//+------------------------------------------------------------------+

int ZigZag_(double& LB[],double& HB[],int x)
  {
   int j,jl,jh,bar_l,bar_h, limit1;

   int    bar,back,lasthighpos=-1,lastlowpos=-1;
   double curlow,curhigh,lasthigh,lastlow,val;


   if (ZZ_tf[x]) // ����� ��������� �������.
     {
      // ����������� ����, � �������� ���������� ������
      bar_l=iBarShift(NULL,GrossPeriod_[x],L2LTime[x],true);
      bar_h=iBarShift(NULL,GrossPeriod_[x],L2HTime[x],true);
      if ((bar_l<0) || (bar_h<0)) return (-1);
      if (L2LTime[x]<=L2HTime[x]) limit=bar_l; else limit=bar_h;

      limit1=limit-1;

      // �������������� ����������
      lastlow=iLow(NULL,GrossPeriod_[x],bar_l);
      lasthigh=iHigh(NULL,GrossPeriod_[x],bar_h);

     }
   else // ���������� ������� �� �������.
     {
      ZZ_tf[x]=true;
      bar_l=limit;
      bar_h=limit;

      limit1=limit;
     }

   // ������ ������� �������� �����
   for(bar=limit1; bar>=0; bar--)
     {
      //--- low
      if (bar<bar_l)
        {
         j=iLowest(NULL,GrossPeriod_[x],MODE_LOW,ExtDepth_[x],bar);
         val=iLow(NULL,GrossPeriod_[x],j);
         if(val==lastlow) val=0.0;
         else 
           { 
            lastlow=val; 
            if((iLow(NULL,GrossPeriod_[x],bar)-val)>(ExtDeviation_[x]*Point))val=0.0;
            else
              {
               for(back=1; back<=ExtBackstep_[x]; back++)
                 {
                  if(val<LB[j+back])LB[j+back]=0.0; 
                 }
              }
           } 
         if (j==bar) LB[j]=val;
        }

      //--- high
      if (bar<bar_h)
        {
         j=iHighest(NULL,GrossPeriod_[x],MODE_HIGH,ExtDepth_[x],bar);
         val=iHigh(NULL,GrossPeriod_[x],j);
         if(val==lasthigh) val=0.0;
         else 
           {
            lasthigh=val;
            if((val-iHigh(NULL,GrossPeriod_[x],bar))>(ExtDeviation_[x]*Point))val=0.0;
            else
              {
               for(back=1; back<=ExtBackstep_[x]; back++)
                 {
                  if(val>HB[j+back])HB[j+back]=0.0; 
                 } 
              }
           }
         if (j==bar) HB[j]=val;
        }
     }
   // ����� ������� �������� �����

   // ������ ������� �������� �����
   lasthigh=-1;    lastlow=-1;

   for(bar=limit; bar>=0; bar--)
     {
      curlow=LB[bar];
      curhigh=HB[bar];

      if((curlow==0)&&(curhigh==0)) continue;

      if(curhigh!=0)
        {
         if(lasthigh>0) 
           {
            if(lasthigh<curhigh) HB[lasthighpos]=0;
            else HB[bar]=0;
           }

         if(lasthigh<curhigh || lasthigh<0)
           {
            lasthigh=curhigh;
            lasthighpos=bar;
           }
         lastlow=-1;
        }

      if(curlow!=0)
        {
         if(lastlow>0)
           {
            if(lastlow>curlow) LB[lastlowpos]=0;
            else LB[bar]=0;
           }

         if((curlow<lastlow)||(lastlow<0))
           {
            lastlow=curlow;
            lastlowpos=bar;
           } 
         lasthigh=-1;
        }
     } 
   // ����� ������� �������� �����

   // ���������� ����������
   if (GrossPeriod_[x]==0)
     {
      saveBars[x]=Bars;
      lBar[x]=Low[0]; hBar[x]=High[0]; tiZZ[x]=Time[0];
     }

   // ���������� ������� ������ � ��������� �������� ����
   jl=0;jh=0;
   for (bar=0;bar<saveBars[x];bar++)
     {
      if (LB[bar]>0) {if (jl==1) {L2LTime[x]=iTime(NULL,GrossPeriod_[x],bar);} jl++;}
      if (HB[bar]>0) {if (jh==1) {L2HTime[x]=iTime(NULL,GrossPeriod_[x],bar);} jh++;}
      if (jl>1 && jh>1) break;
     }
   return(0);
}
//+------------------------------------------------------------------+
//|  �������� ZigZag. �����.                                         |
//+------------------------------------------------------------------+

//--------------------------------------------------------
// �������������� ������� �� �������� ���������� �� �������.
// ������.
//--------------------------------------------------------
int ZigZagDT (double& LB[], double& HB[], double& LBG[], double& HBG[], int x)
  {
   int i=0, j, jl, jh, ext3=0, end;
   double el=-1, eh=-1;
   datetime t1;

   if (Grosstf_DT[x]) // ����� ��������� �������.
     {
      end=ExtReCalculate+1;

      t1=iTime(NULL, GrossPeriod_[x],i);
      for (j=0;ext3<end;j++)
        {
         if (Time[j]<t1) {i++; t1=iTime(NULL, GrossPeriod_[x],i);}

         LB[j]=0;
         HB[j]=0;
         if (LBG[i]>0)
           {
            if (el>=Low[j] || el<0) {el=Low[j]; jl=j;}
           }
         else
           {
            if (el>0) {LB[jl]=el; el=-1; ext3++;}
           }

         if  (HBG[i]>0)
           {
            if (eh<=High[j]) {eh=High[j]; jh=j;}
           }
         else
           {
            if (eh>0) {HB[jh]=eh; eh=-1; ext3++;}
           } 

        }
     }
   else // ���������� ������� �� �������.
     {
      if (limit<=ExtDepth_[x]) {saveBars[x]=0; return (-1);}
      end=iBarShift(NULL,Period(),iTime(NULL, GrossPeriod_[x],limit),false);
      if (end<=0) {saveBars[x]=0; return (-1);}

      Grosstf_DT[x]=true;

      t1=iTime(NULL, GrossPeriod_[x],i);
      for (j=0;j<end;j++)
        {
         if (Time[j]<t1) {i++; t1=iTime(NULL, GrossPeriod_[x],i);}

         if (LBG[i]>0)
           {
            if (el>=Low[j] || el<0) {el=Low[j]; jl=j;}
           }
         else
           {
            if (el>0) {LB[jl]=el; el=-1;}
           }

         if  (HBG[i]>0)
           {
            if (eh<=High[j]) {eh=High[j]; jh=j;}
           }
         else
           {
            if (eh>0) {HB[jh]=eh; eh=-1;}
           } 

        }
     }

   // ���������� ����������
   saveBars[x]=iBars(NULL,GrossPeriod_[x]);
   lBar[x]=iLow(NULL,GrossPeriod_[x],0); hBar[x]=iHigh(NULL,GrossPeriod_[x],0); tiZZ[x]=iTime(NULL,GrossPeriod_[x],0);

   return (0);
  }
//--------------------------------------------------------
// �������������� ������� �� �������� ���������� �� �������.
// �����.
//--------------------------------------------------------

//--------------------------------------------------------
// �������� ������������ ������� ����������. ������.
//--------------------------------------------------------
int _period(int x, int tf)
  {
   if (tf<Period()) {ExtDepth_[x]=0; return (tf);}
   if (tf==Period()) return (0);

   switch (tf)
     {
      case 0     : {return (0);}
      case 1     : {return (1);}
      case 5     : {return (5);}
      case 15    : {return (15);}
      case 30    : {return (30);}
      case 60    : {return (60);}
      case 240   : {return (240);}
      case 1440  : {return (1440);}
      case 10080 : {return (10080);}
      case 43200 : {return (43200);}
      default    : {ExtDepth_[x]=0; return (tf);}
     }
  }
//--------------------------------------------------------
// �������� ������������ ������� ����������. �����.
//--------------------------------------------------------

//--------------------------------------------------------
// ����� ��������� ������� �� 1 �� 0 �������� � ������� ���������� �������.
// ������.
//--------------------------------------------------------
void Shift_elements (double& arr[], double& arr1[])
  {
   int i,j;

   j=ArraySize(arr)-1;
   for (i=j;i>0;i--)
     {
      arr[i]=arr[i-1];
      arr1[i]=arr1[i-1];
     }
   arr[0]=0;
   arr1[0]=0;
  }
//--------------------------------------------------------
// ����� ��������� ������� �� 1 �� 0 �������� � ������� ���������� �������.
// �����.
//--------------------------------------------------------


//--------------------------------------------------------
// ��������� ������� �������� � ���������� ���� ��������� �������� 0
// ������.
//--------------------------------------------------------
void arr_resize (double& arr[], double& arr1[], int size, int x)
  {
   if (GrossPeriod_[x]>0)
     {
      ArrayResize(arr,size); ArrayResize(arr1,size);
      ArrayInitialize(arr,0); ArrayInitialize(arr1,0);
     }
  }
//--------------------------------------------------------
// ��������� ������� �������� � ���������� ���� ��������� �������� 0
// �����.
//--------------------------------------------------------


//--------------------------------------------------------
// ������� �������� ���������� �� ������ � ������
// ������.
//--------------------------------------------------------
void _stringtoarray (string str, int& arr[], int x)
  {
   int i,j,k=0;
   for (i=0;i<x;i++)
     {
      j=StringFind(str,",",k);
      if (j<0) {arr[i]=StrToInteger(StringSubstr(str,k)); break;}
      arr[i]=StrToInteger(StringSubstr(str,k,j-k));
      k=j+1;
     }
  }
//--------------------------------------------------------
// ������� �������� ���������� �� ������ � ������
// �����.
//--------------------------------------------------------

