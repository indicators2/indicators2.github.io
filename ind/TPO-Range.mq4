#property copyright "TPO: Time Price Opportunity (on time range), v2.5.7491. � 2009-2010 Plus."
#property link      "http://fxcoder.ru, plusfx@ya.ru, skype:plusfx"

#property indicator_chart_window

// ��������� ��������
extern int RangeMode = 0;						// ��������: 0 - ����� ������������ �����, 1 - ��������� RangeMinutes �����, 2 = RangeMinutes ����� ������
extern int RangeMinutes = 1440;					// ���������� ����� � ��������� (��� ��������� ����� �������� ������)
extern int ModeStep = 10;						// ��� ������ ���, ���������� � 2 ���� ������ + 1
int Smooth = 0;									// ������� �����������, ����������� �������� ����������������� ���������� ����� ��������� ����� ���
int PriceStep = 0;								// ��� ����, 0 - ���� (��. #1)
int DataPeriod = 1;								// ������ ��� ������, ������� - ����� ������
bool ShowHorizon = true;						// �������� �������� ������

// ����������� � ����
extern int HGPosition = 1;						// 0 - window left, 1 - window right, 2 - left side, 3 - right side, //TODO: 4 - ������
extern color HGColor = C'160,224,160';			// ���� �����������
extern int HGStyle = 1;							// ����� �����������: 0 - �����, 1 - ������ ��������������, 2 - ����������� ��������������
extern color ModeColor = Green;					// ���� ���
extern color MaxModeColor = CLR_NONE;			// �������� ��������

int HGLineWidth = 1;							// ������ ����� �����������

double Zoom = 0;								// ������� �����������, 0 - �����������
int ModeWidth = 1;								// ������� ���
int ModeStyle = STYLE_SOLID;					// ����� ���

// ������
extern color ModeLevelColor = Green;			// ���� �������
int ModeLevelWidth = 1;							// �������
extern int ModeLevelStyle = 2;					// �����

// ���������
extern string Id = "+tpor";						// ������� ���� �������� ����������

int WaitSeconds = 1;							// ����������� �����, � ��������, ����� ������������
int TickMethod = 1;								// ����� �������� �����: 0 - Low >> High, 1 - Open > Low(High) > High(Low) > Close, 2 - HLC, 3 - HL
												// +4 - ��� ����� ������, +8 - � ������ ������ � ����� ����
color TimeFromColor = Blue;						// ����� ������� ��������� - ����
int TimeFromStyle = STYLE_DASH;					// ����� ������� ��������� - �����

color TimeToColor = Red;						// ������ ������� ��������� - ����
int TimeToStyle = STYLE_DASH;					// ������ ������� ��������� - �����


string onp, tfn, ttn;
datetime lastTime = 0;	// ��������� ����� �������

double hgPoint;			// ����������� ��������� ����
int modeStep = 0;
int smooth = 0;

bool showHG, showModes, showMaxMode, showModeLevel;
bool hgBack = true;
bool hgUseRectangles = false;


#define ERR_HISTORY_WILL_UPDATED 4066


int init()
{
	onp = Id + " m" + RangeMode + " ";
	tfn = Id + "-from";
	ttn = Id + "-to";

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
	smooth = Smooth * Point / hgPoint;
	if (is5digits)
	{
		 modeStep *= 10;
		 smooth *= 10;
	}
	

	// ��������� �����������	
	showHG = (HGColor != CLR_NONE) && (HGColor != -16777216);
	showModes = (ModeColor != CLR_NONE) && (ModeColor != -16777216);
	showMaxMode = (MaxModeColor != CLR_NONE) && (MaxModeColor != -16777216);
	showModeLevel = (ModeLevelColor != CLR_NONE) && (ModeLevelColor != -16777216);

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
	
	return(0);
}

int start()
{
	if (GlobalVariableGet("+vl-freeze") == 1)
		return;

	datetime currentTime = TimeLocal();
	
	// ������ ����������� �� ����� ����...
	if (Volume[0] > 1)
	{
		// ...� �� ����, ��� ��� � ��������� ������
		if (currentTime - lastTime < WaitSeconds)
			return(0);
	}

	lastTime = currentTime;

	// ������� ������ �������
	clearChart(onp);

	// ���������� ������� ��������
	
	datetime timeFrom, timeTo;
	
	if (RangeMode == 0)	// ����� ���� �����
	{
		timeFrom = GetObjectTime1(tfn);
		timeTo = GetObjectTime1(ttn);

		if ((timeFrom == 0) || (timeTo == 0))
		{
			// ���� ������� ��������� �� ������, �� ������������� �� � ������� ����� ������
			datetime timeLeft = getBarTime(WindowFirstVisibleBar());
			datetime timeRight = getBarTime(WindowFirstVisibleBar() - WindowBarsPerChart());
			double r = timeRight - timeLeft;
			
			timeFrom = timeLeft + r / 3;
			timeTo = timeLeft + r * 2 / 3;

			drawVLine(tfn, timeFrom, TimeFromColor, 1, TimeFromStyle, false);
			drawVLine(ttn, timeTo, Crimson, 1, STYLE_DASH, false);
		}

		if (timeFrom > timeTo)
		{
			datetime dt = timeTo;
			timeTo = timeFrom;
			timeFrom = dt;
		}
	}
	else if (RangeMode == 2)	// �� ������ ����� RangeMinutes �����
	{
		timeTo = GetObjectTime1(ttn);

		if (timeTo == 0)
		{
			// ���� ������ ��������� �� �����, �� ������������� ��� � ������� ����� ������
			int bar = MathMax(0, WindowFirstVisibleBar() - WindowBarsPerChart() + 20);
			timeTo = getBarTime(bar);
		}
		else
			bar = iBarShift(NULL, 0, timeTo);

		bar += RangeMinutes/Period();
		timeFrom = Time[bar];// timeTo - RangeMinutes*60;

		drawVLine(tfn, timeFrom, TimeFromColor, 1, TimeFromStyle, false);
		if (ObjectFind(ttn) == -1)
			drawVLine(ttn, timeTo, TimeToColor, 1, TimeToStyle, false);
	}
	else if (RangeMode == 1)
	{
		timeFrom = iTime(Symbol(), PERIOD_M1, RangeMinutes);	// ���������
		timeTo = iTime(Symbol(), PERIOD_M1, 0);
	}
	else
	{
		return(0);
	}

	if (getTimeBar(timeTo) < 0)
		timeTo = iTime(Symbol(), PERIOD_M1, 0);
		
	if (getTimeBar(timeFrom) < 0)
		timeFrom = iTime(Symbol(), PERIOD_M1, 0);

	if (ShowHorizon)
	{
		
		datetime hz = iTime(NULL, DataPeriod, iBars(NULL, DataPeriod) - 1);
		drawVLine(onp + "hz", hz, Red, 1, STYLE_DOT, false);
	}

	int barFrom, barTo, m1BarFrom, m1BarTo;

	if (getRange(timeFrom, timeTo, barFrom, barTo, m1BarFrom, m1BarTo, DataPeriod))
	{
		// �������� �����������
		double vh[], hLow;

		int count = getHGByRates(m1BarFrom, m1BarTo, TickMethod, vh, hLow, hgPoint, DataPeriod);

		if (count == 0)
			return(0);
		
		if (smooth != 0)
		{	
			count = smoothHG(vh, smooth);
			hLow -= smooth * hgPoint;
		}
			
		int rp;
		datetime time0;

		double windowTimeRange = WindowBarsPerChart()*Period()*60;
		rp = windowTimeRange*0.1;	// �������� ������� ��� ��������� �����������


		// ����������� ��������
		double zoom = Zoom*0.000001;
		if (zoom <= 0)
		{
			double maxVolume = vh[ArrayMaximum(vh)];
			zoom = WindowBarsPerChart()*0.1 / maxVolume;
		}

		int bar0;	// ��� ������� ������� �����������
		
		if (HGPosition == 0)		// ����� ������� ����
		{
			bar0 = WindowFirstVisibleBar();
		}
		else if (HGPosition == 1)	// ������ ������� ����
		{
			bar0 = WindowFirstVisibleBar() - WindowBarsPerChart();
			zoom = -zoom; // ������ ��������������
		}
		else if (HGPosition == 2)	// ����� ������� ���������
		{
			bar0 = barFrom;
			zoom = -zoom; // ������ ��������������
		}
		else 						// 3 - ������ ������� ���������
		{
			bar0 = barTo;
		}

		// ������
		if (showHG)
			drawHG(onp + "hg ", vh, hLow, bar0, HGColor, HGColor, zoom, HGLineWidth, hgPoint);
	
		if (showModes || showMaxMode || showModeLevel)
			drawModes(vh, hLow, bar0, zoom, hgPoint);
	}
	
	return(0);
}

int deinit()
{
	// ������� ��� ����������� � �� �����������
	clearChart(onp);
	
	// ������ ����� ������ ��� ����� �������� ���������� � �������, ������ ��� ������� (������� �������� �� ��� �� �����)
	// ����������: ��-�� ������ ������� �� ��� ����� �� ��������, ��������������� ��� �������� ��������� ���������� � �������� 
	//		REASON_REMOVE, ��-�� ���� ����� �������� ��� �������� ���������, � ��� ����������� ��������������� ����-�� ������� 
	//		� �������, �.�. ����� ��� ���� ���� - ������������� ��� ������� ���������� �� ������� ������ �����.
	/*if (UninitializeReason() == REASON_REMOVE)
	{
		clearChart(tfn);
		clearChart(ttn);
	}*/
	
	return(0);
}

void DrawHLine(string name, double price, color lineColor = Gray, int width = 1, int style = STYLE_SOLID, bool back = true)
{
	if (ObjectFind(name) >= 0)
		ObjectDelete(name);

	if (price > 0 && ObjectCreate(name, OBJ_HLINE, 0, 0, price))
	{
		ObjectSet(name, OBJPROP_COLOR, lineColor);
		ObjectSet(name, OBJPROP_WIDTH, width);
		ObjectSet(name, OBJPROP_STYLE, style);
		ObjectSet(name, OBJPROP_BACK, back);
	}
}

datetime GetObjectTime1(string name)
{
	// ��������� ������� ObjectGet � ������ ���������� ������� �� �������������� �������������� �����, ������� �����������
 	if (ObjectFind(name) != -1)
		return(ObjectGet(name, OBJPROP_TIME1));
	else
		return(0);
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

	// ������� ������ ���� � �� ������, ��� ����� ����������������
	clearChart(onp + "mode ");
	clearChart(onp + "level ");

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
	
			on = onp + "mode " + DoubleToStr(price, Digits);
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

			// �������
			if (showModeLevel)
				DrawHLine(onp + "level " + DoubleToStr(price, Digits), price, ModeLevelColor, ModeLevelWidth, ModeLevelStyle, true);
		}
	}
}

// �������� ����� ���� �� ������� � ������ ���������� ������ �� �������� �������� ������
int getTimeBar(datetime time, int period = 0)
{
	if (period == 0)
		period = Period();

	int shift = iBarShift(Symbol(), period, time);
	int t = getBarTime(shift, period);
	
	if (t != time) // && shift == 0 ???
		shift = (iTime(Symbol(), period, 0) - time) / 60 / period;

	return(shift);	
}

// �������� ����� �� ������ ���� � ������ ���������� ������ �� �������� ����� (����� ���� ������ 0)
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

	// ���� �������� ����������������, �� ��� ��������� ��� �� �����������
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
///		dataPeriod - ��������� ������
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

/// �������� ����������� ������������� ��� ���������� MQL
int mql_GetHGByRates(double& rates[][6], int rcount, int icount, int ishift, int tickMethod, double point, 
	double hLow, int hCount, double& vh[])
{
	int pri;	// ������ ����
	double dv;	// ����� �� ���

	int hLowI = MathRound(hLow / point);

	//Print(rcount);

	for (int j = 0; j < icount; j++)
	{
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
	int vCount = ArraySize(vh);

	if (depth == 0)
		return(vCount);

	// ��������� ������ (���������� ��� ���������� ��������)
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


	return(newCount);
}