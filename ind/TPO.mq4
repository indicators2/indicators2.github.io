#property copyright "TPO: Time Price Opportunity, v2.5.7491. � 2009-2010 Plus."
#property link      "http://fxcoder.ru, plusfx@ya.ru, skype:plusfx"

#property indicator_chart_window

// ��������� ��������
extern int RangePeriod = PERIOD_D1;				// �� ���������, ������ ���� ����� �� �����������
extern int RangeCount = 20;						// ���������� ����������/����������

//tf#extern string TimeFrom = "00:00";			// ������ ��������� (������ �����)
//tf#extern string TimeTo = "00:00";			// ����� ��������� (������ �����) + 1 ������

extern int ModeStep = 10;						// ��� ������ ���, ���������� � 2 ���� ������ + 1
int Smooth = 0;									// ������� �����������, ����������� �������� ����������������� ���������� ����� ��������� ����� ���
extern int PriceStep = 0;						// ��� ����, 0 - ���� (��. #1)
extern int DataPeriod = 1;						// ������ ��� ������, ������� - ����� ������
bool ShowHorizon = true;						// �������� �������� ������

// �����������
extern color HGColor = C'160,192,224';			// ���� �����������
extern int HGStyle = 1;							// ����� �����������: 0 - �����, 1 - ������ ��������������, 2 - ����������� ��������������
extern color ModeColor = Blue;					// ���� ���
extern color MaxModeColor = CLR_NONE;			// �������� ��������

int HGLineWidth = 1;							// ������ ����� �����������
double Zoom = 0;								// ������� �����������, 0 - �����������

int ModeWidth = 1;								// ������� ���
int ModeStyle = STYLE_SOLID;					// ����� ���

// ���������
extern string Id = "+tpo";						// ������� ���� �����

int WaitSeconds = 1;							// ����������� �����, � ��������, ����� ������������
int TickMethod = 1;								// ����� �������� �����: 0 - Low >> High, 1 - Open > Low(High) > High(Low) > Close, 2 - HLC, 3 - HL, 4 - ������������� ������-�����
												// +4 - ��� ����� ������, +8 - � ������ ������ � ����� ����.

string onp;

datetime drawHistory[];		// ������� ���������
datetime lastTime = 0;		// ��������� ������ �������
bool lastOK = false;

double hgPoint;				// ����������� ��������� ����
int modeStep = 0;
int smooth = 0;

bool showHG, showModes, showMaxMode;
bool hgBack = true;
bool hgUseRectangles = false;

// ������������� ���������������� ������ �� �������
//tf#string timeFrom = "00:00";
//tf#string timeTo = "23:59";
//tf#bool filterTime = false;


#define ERR_HISTORY_WILL_UPDATED 4066


int init()
{
	onp = Id + " " + RangePeriod + " ";

	hgPoint = Point;
	
	bool is5digits = ((Digits == 3) || (Digits == 5)) && (MarketInfo(Symbol(), MODE_PROFITCALCMODE) == 0);
	
	//#1
	if (PriceStep == 0)
	{
		if (is5digits)
			hgPoint = Point * 10.0;
	}
	else
	{
		hgPoint = Point * PriceStep;
	}


	modeStep = ModeStep * Point / hgPoint;
	smooth = Smooth;
	if (is5digits)
	{
		 modeStep *= 10;
	}
	

	ArrayResize(drawHistory, 0);
	
	// ��������� �����������	
	showHG = (HGColor != CLR_NONE) && (HGColor != -16777216);
	showModes = (ModeColor != CLR_NONE) && (ModeColor != -16777216);
	showMaxMode = (MaxModeColor != CLR_NONE) && (MaxModeColor != -16777216);
	
	// ������������ ��������� �����
	if (HGStyle == 1)
	{
		hgBack = false;
		hgUseRectangles = true;
	}
	else if (HGStyle == 2)
	{
		hgBack = true;
		hgUseRectangles = true;
	}
	
	// ��������� ������� ������ �� �������
	//tf#datetime tf = StrToTime("2000.01.01 " + TimeFrom);
	//tf#datetime tt = StrToTime("2000.01.01 " + TimeTo) - 1; // �� �������� ������ ������� (1 ������, �.�. ���. �� �1)

	//tf#filterTime = tt >= tf;
	
	//tf#if (filterTime)
	//tf#{
	//tf#	timeFrom = TimeToStr(tf, TIME_MINUTES);
	//tf#	timeTo = TimeToStr(tt, TIME_MINUTES);	
	//tf#}
	
	//tf#Comment("Filter time: " + filterTime + "\n" +
	//tf#	"From: " + timeFrom + "\n" +
	//tf#	"To: " + timeTo + "\n");
}

int start()
{
	datetime currentTime = TimeLocal();

	// ������ ����������� �� ����� ����...
	if ((Volume[0] > 1) && lastOK)
	{
		// ...� �� ����, ��� ��� � ��������� ������
		if (currentTime - lastTime < WaitSeconds)
			return(0);
	}

	lastTime = currentTime;

	if (ShowHorizon)
	{
		datetime hz = iTime(NULL, DataPeriod, iBars(NULL, DataPeriod) - 1);
		drawVLine(onp + "hz", hz, Red, 1, STYLE_DOT, false);
	}

	double vh[], hLow;
	
	lastOK = true;
	for (int i = 0; i < RangeCount; i++)//1 - ShowLast
	{
		int barFrom, barTo, m1BarFrom, m1BarTo;

		datetime timeFrom = iTime(NULL, RangePeriod, i);

		datetime timeTo = Time[0];
		if (i != 0)
			timeTo = iTime(NULL, RangePeriod, i - 1);


		if (getRange(timeFrom, timeTo, barFrom, barTo, m1BarFrom, m1BarTo, DataPeriod))
		{
			if (!checkDrawHistory(timeFrom) || (i == 0))
			{
				int count = getHGByRates(m1BarFrom, m1BarTo, TickMethod, vh, hLow, hgPoint, DataPeriod);
				
				if (count > 0)
				{
					if (smooth > 0)
					{
						count = smoothHG(vh, smooth);
						//hLow -= smooth * hgPoint;
					}

					if (i != 0)
						addDrawHistory(timeFrom);

					// ����������� ��������
					double zoom = Zoom*0.000001;
					if (zoom <= 0)
					{
						double maxVolume = vh[ArrayMaximum(vh)];
						zoom = (barFrom - barTo) / maxVolume;
					}

					// ������
					if (showHG)
					{
						string prefix = onp + "hg " + TimeToStr(timeFrom) + " ";
						drawHG(prefix, vh, hLow, barFrom, HGColor, HGColor, zoom, HGLineWidth, hgPoint);
					}
					
					if (showModes || showMaxMode)
						drawModes(vh, hLow, barFrom, zoom, hgPoint);
				}
			}
		}
		else
		{
			lastOK = false;
		}
	}

	return(0);
}

int deinit()
{
	clearChart(onp);
	return(0);
}

// ���������, ���������� �� ��� ������ ���� ������
bool checkDrawHistory(datetime time)
{
	int count = ArraySize(drawHistory);
	bool r = false;
	for (int i = 0; i < count; i++)
	{
		if (drawHistory[i] == time)
		{
			r = true;
			break;
		}
	}
	return(r);
}

// �������� ������������ ������� � �������
void addDrawHistory(datetime time)
{
	if (!checkDrawHistory(time))
	{
		int count = ArraySize(drawHistory);
		ArrayResize(drawHistory, count + 1);
		drawHistory[count] = time;
	}
}

// ���������� ���� �����������
void drawModes(double& vh[], double hLow, int barFrom, double zoom, double point)
{
	int modes[], modeCount, j;
	double price;

	// ����� ���
	modeCount = getModesIndexes(vh, modeStep, modes);

	// ����. ����
	double max = 0;
	if (showMaxMode)
	{
		for (j = 0; j < modeCount; j++)
			if (vh[modes[j]] > max)
				max = vh[modes[j]];
	}

	datetime timeFrom = getBarTime(barFrom);

	clearChart(onp + "mode " + TimeToStr(timeFrom) + " ");

	// ������ �������� ���� � ������� ��������� ����������������
	bool back = false;
	if (hgUseRectangles)
		back = true;
	
	string on;
	
	for (j = 0; j < modeCount; j++)
	{
		double v = zoom * vh[modes[j]];

		// �� �������� �������� ����� (������ ���� ��), ������ ��� ��������� ������
		if (MathAbs(v) > 0)
		{
			price = hLow + modes[j]*point;
			datetime timeTo = getBarTime(barFrom - v);

			on = onp + "mode " + TimeToStr(timeFrom) + " " + DoubleToStr(price, Digits);
			if (showMaxMode && (MathAbs(vh[modes[j]] - max) < point))	// ������������ ����
			{
				drawTrend(on, timeFrom, price, timeTo, price, MaxModeColor, ModeWidth, ModeStyle, back, false, 0, hgUseRectangles);

				// � ������ ��������� ���������������� ���� ������ �������, ����� ��� ����������
				if (hgUseRectangles && back)
					drawTrend(on + "+", timeFrom, price, timeTo, price, MaxModeColor, ModeWidth, ModeStyle, false, false, 0, false);
			}
			else if (showModes)	// ������� ����
			{
				drawTrend(on, timeFrom, price, timeTo, price, ModeColor, ModeWidth, ModeStyle, back, false, 0, hgUseRectangles);
				
				// � ������ ��������� ���������������� ���� ������ �������, ����� ��� ����������
				if (hgUseRectangles && back)
					drawTrend(on + "+", timeFrom, price, timeTo, price, ModeColor, ModeWidth, ModeStyle, false, false, 0, false);
			}
		}
	}
}

datetime getBarTime(int shift, int period = 0)
{
	if (period == 0)
		period = Period();

	if (shift >= 0)
		return(iTime(Symbol(), period, shift));
	else
		return(iTime(Symbol(), period, 0) - shift*period*60);
}

/// �������� ������ �� ����� ��������
int clearChart(string prefix)
{
	int obj_total = ObjectsTotal();
	string name;
	
	int count = 0;
	for (int i = obj_total - 1; i >= 0; i--)
	{
		name = ObjectName(i);
		if (StringFind(name, prefix) == 0)
		{
			ObjectDelete(name);
			count++;
		}			
	}
	return(count);
}

void drawVLine(string name, datetime time1, color lineColor = Gray, int width = 1, int style = STYLE_SOLID, bool back = true)
{
	if (ObjectFind(name) >= 0)
		ObjectDelete(name);
		
	ObjectCreate(name, OBJ_VLINE, 0, time1, 0);
	ObjectSet(name, OBJPROP_COLOR, lineColor);
	ObjectSet(name, OBJPROP_BACK, back);
	ObjectSet(name, OBJPROP_STYLE, style);
	ObjectSet(name, OBJPROP_WIDTH, width);
}

void drawTrend(string name, datetime time1, double price1, datetime timeTo, double price2, 
	color lineColor, int width, int style, bool back, bool ray, int window, bool useRectangle)
{
	if (ObjectFind(name) >= 0)
		ObjectDelete(name);

	if (useRectangle)
		ObjectCreate(name, OBJ_RECTANGLE, window, time1, price1 - hgPoint / 2.0, timeTo, price2 + hgPoint / 2.0);
	else
		ObjectCreate(name, OBJ_TREND, window, time1, price1, timeTo, price2);
		
	ObjectSet(name, OBJPROP_BACK, back);
	ObjectSet(name, OBJPROP_COLOR, lineColor);
	ObjectSet(name, OBJPROP_STYLE, style);
	ObjectSet(name, OBJPROP_WIDTH, width);
	ObjectSet(name, OBJPROP_RAY, ray);
}

// ���������� ����������� (+���� +point)
void drawHG(string prefix, double& h[], double low, int barFrom, color bgColor, color lineColor, double zoom, int width, double point)
{
	double max = h[ArrayMaximum(h)];
	if (max == 0)
		return(0);

	int bgR = (bgColor & 0xFF0000) >> 16;
	int bgG = (bgColor & 0x00FF00) >> 8;
	int bgB = (bgColor & 0x0000FF);

	int lineR = (lineColor & 0xFF0000) >> 16;
	int lineG = (lineColor & 0x00FF00) >> 8;
	int lineB = (lineColor & 0x0000FF);
	
	int dR = lineR - bgR;
	int dG = lineG - bgG;
	int dB = lineB - bgB;

	int hc = ArraySize(h);
	for (int i = 0; i < hc; i++)
	{
		double price = NormalizeDouble(low + i*point, Digits);
		
		int barTo = barFrom - h[i]*zoom;
		
		// ��������� ����������
		double fade = h[i] / max;
		int r = MathMax(MathMin(bgR + fade * dR, 255), 0);
		int g = MathMax(MathMin(bgG + fade * dG, 255), 0);
		int b = MathMax(MathMin(bgB + fade * dB, 255), 0);
		color cl = (r << 16) + (g << 8) + b;
		
		datetime timeFrom = getBarTime(barFrom);
		datetime timeTo = getBarTime(barTo);

		if (barFrom != barTo)
			drawTrend(prefix + DoubleToStr(price, Digits), timeFrom, price, timeTo, price, cl, width, STYLE_SOLID, hgBack, false, 0, hgUseRectangles);
	}
}

// �������� ��������� ���������
bool getRange(datetime timeFrom, datetime timeTo, int& barFrom, int& barTo, 
	int& p1BarFrom, int& p1BarTo, int period)
{
	// �������� ����� � ������� �� (��� ���������)

	barFrom = iBarShift(NULL, 0, timeFrom);
	datetime time = Time[barFrom];
	int bar = iBarShift(NULL, 0, time);
	time = Time[bar];
	if (time != timeFrom)
		barFrom--;
											
	barTo = iBarShift(NULL, 0, timeTo);
	time = Time[barTo];
	bar = iBarShift(NULL, 0, time);
	time = Time[bar];
	if (time == timeFrom)
		barTo++;

	if (barFrom < barTo)
		return(false);


	// �������� ����� �� period (��� ��������� ������)

	p1BarFrom = iBarShift(NULL, period, timeFrom);
	time = iTime(NULL, period, p1BarFrom);
	if (time != timeFrom)
		p1BarFrom--;
		
	p1BarTo = iBarShift(NULL, period, timeTo);
	time = iTime(NULL, period, p1BarTo);
	if (timeTo == time)
		p1BarTo++;
		
	if (p1BarFrom < p1BarTo)
		return(false);

	return(true);
}

/// �������� ����������� ������������� ���
///		m1BarFrom, m1BarTo - ������� ���������, �������� �������� ����� �������
/// ����������:
///		��������� - ���������� ��� � �����������, 0 - ������
///		vh - �����������
///		hLow - ������ ������� �����������
///		point - ��� ����
///		dataPeriod - ��������� ������int
int getHGByRates(int m1BarFrom, int m1BarTo, int tickMethod, double& vh[], double& hLow, double point, int dataPeriod)
{
	double rates[][6];
	double hHigh;

	// ����������������� (� ������������) ���������� �������
	int rCount = getRates(m1BarFrom, m1BarTo, rates, hLow, hHigh, dataPeriod);
	//Print("rCount: " + rCount);
	
	if (rCount != 0)
	{
		hLow = NormalizeDouble(MathRound(hLow / point) * point, Digits);
		hHigh = NormalizeDouble(MathRound(hHigh / point) * point, Digits);
		
		//Print("hLow: " + hLow);
		//Print("hHigh: " + hHigh);

		// �������������� ������ �����������
		int hCount = hHigh/point - hLow/point + 1;
		//Print("hCount: " + hCount);
		ArrayResize(vh, hCount);
		ArrayInitialize(vh, 0);

		int iCount = m1BarFrom - m1BarTo + 1;
		int hc = mql_GetHGByRates(rates, rCount, iCount, m1BarTo, tickMethod, point, hLow, hCount, vh);
		//Print("hc: " + hc);

		if (hc == hCount)
			return(hc);
		else
			return(0);
	}
	else
	{
		//Print("Error: no rates");
		return(0);
	}
}

/// �������� ����������� ������������� ��� ���������� MQL (������ vlib_GetHGByRates
int mql_GetHGByRates(double& rates[][6], int rcount, int icount, int ishift, int tickMethod, double point, 
	double hLow, int hCount, double& vh[])
{
	int pri;	// ������ ����
	double dv;	// ����� �� ���

	int hLowI = MathRound(hLow / point);
	//Print(rcount);

	for (int j = 0; j < icount; j++)
	{
		// ������ �� �������
		
	
		//int i = rcount - 1 - j - ishift;
		int i = j + ishift;

		double o = rates[i][1];
		int oi = MathRound(o/point);

		double h = rates[i][3];
		int hi = MathRound(h/point);

		double l = rates[i][2];
		int li = MathRound(l/point);

		double c = rates[i][4];
		int ci = MathRound(c/point);

		double v = rates[i][5];

		//Print("oi: " + oi);
		//Print("hLowI: " + hLowI);
		//Print("oi-hLowI: " + (oi-hLowI));
		//Print("rate: " + v);

		int rangeMin = hLowI;
		int rangeMax = hLowI + hCount - 1;

		if (tickMethod == 0)						// ������ ����������� ���� ��� ����
		{
			dv = v / (hi - li + 1.0);
			for (pri = li; pri <= hi; pri++)
				vh[pri - hLowI] += dv;
		}
		else if (tickMethod == 1)					// �������� �����
		{
			if (c >= o)		// ����� �����
			{
				dv = v / (oi - li + hi - li + hi - ci + 1.0);

				for (pri = oi; pri >= li; pri--)		// open --> low
					vh[pri - hLowI] += dv;

				for (pri = li + 1; pri <= hi; pri++)	// low+1 ++> high
					vh[pri - hLowI] += dv;
				
				for (pri = hi - 1; pri >= ci; pri--)	// high-1 --> close
					vh[pri - hLowI] += dv;
			}
			else			// �������� �����
			{
				dv = v / (hi - oi + hi - li + ci - li + 1.0);

				for (pri = oi; pri <= hi; pri++)		// open ++> high
					vh[pri - hLowI] += dv;
				
				for (pri = hi - 1; pri >= li; pri--)	// high-1 --> low
					vh[pri - hLowI] += dv;
				
				for (pri = li + 1; pri <= ci; pri++)	// low+1 ++> close
					vh[pri - hLowI] += dv;
			}
		}
		else if (tickMethod == 2)					// ������ ���� ����
		{
			dv = v / 4.0;
			vh[oi - hLowI] += dv;
			vh[hi - hLowI] += dv;
			vh[li - hLowI] += dv;
			vh[ci - hLowI] += dv;
		}
		else if (tickMethod == 3)					// ������ ��� � ���
		{
			dv = v / 2.0;
			vh[hi - hLowI] += dv;
			vh[li - hLowI] += dv;
		}
		else if (tickMethod == 4)					// ����
		{
			dv = 1.0 / v;
			if (c >= o)		// ����� �����
			{

				for (pri = oi; pri >= li; pri--)		// open --> low
					vh[pri - hLowI] += dv;

				for (pri = li + 1; pri <= hi; pri++)	// low+1 ++> high
					vh[pri - hLowI] += dv;
				
				for (pri = hi - 1; pri >= ci; pri--)	// high-1 --> close
					vh[pri - hLowI] += dv;
			}
			else			// �������� �����
			{
				for (pri = oi; pri <= hi; pri++)		// open ++> high
					vh[pri - hLowI] += dv;
				
				for (pri = hi - 1; pri >= li; pri--)	// high-1 --> low
					vh[pri - hLowI] += dv;
				
				for (pri = li + 1; pri <= ci; pri++)	// low+1 ++> close
					vh[pri - hLowI] += dv;
			}
		}		
		
	}
	
	return(hCount);
}

/// �������� ���� �� ������ ����������� � ���������� ����������� (������� �����, ��� �����������)
int getModesIndexes(double& vh[], int modeStep, int& modes[]) //, int& maxModeIndex
{
	int modeCount = 0;
	ArrayResize(modes, modeCount);

	int count = ArraySize(vh);
	
	// ���� ��������� �� ��������
	for (int i = modeStep; i < count - modeStep; i++)
	{
		int maxFrom = i-modeStep;
		int maxRange = 2*modeStep + 1;
		int maxTo = maxFrom + maxRange - 1;

		int k = ArrayMaximum(vh, maxRange, maxFrom);
		
		if (k == i)
		{
			for (int j = i - modeStep; j <= i + modeStep; j++)
			{
				if (vh[j] == vh[k])
				{
					modeCount++;
					ArrayResize(modes, modeCount);
					modes[modeCount-1] = j;
				}
			}
		}
		
	}

	return(modeCount);
}


/// �������� ������� ��� ��������� ��������� (����������� � ������� ����� �������)
int getRates(int barFrom, int barTo, double& rates[][6], double& ilowest, double& ihighest, int period)
{
	// ����������������� (� ������������) ���������� �������
	int iCount = barFrom - barTo + 1;
	
	int count = ArrayCopyRates(rates, NULL, period);
	if (GetLastError() == ERR_HISTORY_WILL_UPDATED)
	{
		return(0);
	}
	else
	{
		if (count >= barFrom - 1)
		{
			ilowest = iLow(NULL, period, iLowest(NULL, period, MODE_LOW, iCount, barTo));
			ihighest = iHigh(NULL, period, iHighest(NULL, period, MODE_HIGH, iCount, barTo));
			//Print("ilowest:" + ilowest);
			//Print("ihighest:" + ihighest);
			return(count);
		}
		else
		{
			return(0);
		}
	}
}


int smoothHG(double& vh[], int depth)
{
	// ��������� ������ (���������� ��� ���������� ��������)
	
	int vCount = ArraySize(vh);

	if (depth == 0)
		return(vCount);

	int newCount = vCount + 2 * depth;
	
	// �������� �������� � �������� ������
	double th[];
	ArrayResize(th, newCount);
	ArrayInitialize(th, 0);

	ArrayCopy(th, vh, depth, 0);

	ArrayResize(vh, newCount);
	ArrayInitialize(vh, 0);

	// ���������������� ����������
	for (int d = 0; d < depth; d++)
	{
		for (int i = -d; i < vCount + d; i++)
		{
			vh[i+depth] = (th[i+depth-1] + th[i+depth] + th[i+depth+1]) / 3.0;
		}
		
		ArrayCopy(th, vh);
	}

	ArrayResize(vh, vCount);
	ArrayCopy(vh, th, 0, depth, vCount);


	return(newCount);
}