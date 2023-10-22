function createImageGallery() {
    const galleryContainer = document.getElementById("imageGallery");
    

    for (const imageName of imageNames) {
        const img = document.createElement("div");
        img.innerHTML = '<div class="post"><div class="post_title"><h2><a href="ind/'+imageName+'.ex4"> <span class="numbered-element"></span>'+imageName+'</a></h2></div>	<div class="image-frame"><img src="ind/'+imageName+'.png" width="420px" height="215px" alt="'+imageName+'" onclick="enlargeImage(this)"></div><img id="enlarged-image" class="enlarged-image" onclick="closeEnlargedImage()"><div class="post_meta"><a href="ind/'+imageName+'.ex4">'+imageName+'.ex4</a> |  <a href="ind/'+imageName+'.mq4">'+imageName+'.mq4</a></div></div>';
        galleryContainer.appendChild(img);
    }
    const elementsToNumber = document.querySelectorAll('.numbered-element');
    elementsToNumber.forEach((element, index) => {
        const number = index + 1;
        element.textContent = number+". ";
      });
}

// Викликаємо функцію для створення галереї після завантаження сторінки
window.addEventListener("load", createImageGallery);

// Масив з назвами файлів зображень 1622x827
const imageNames = [
    "!_EA_Vegas_1hr",
    "(Shu)-AccInfo",
    "02-06-BBands_Stop",
    "04-05-CandleStick_Pattern",
    "04-08-CCI_Woodies_Paterns",
    "05-02-Color Stochastic",
    "07-04-FiboBars2",
    "07-05-FiboCalc",
    "07-10-FOREX INVINCIBLE SIGNAL",
    "1 arrows & curves",
    "1-2-3fpatternemtffv3.1",
    "10.2 TMA slope v.1.4B 4.30",
    "11-02-MultiZigZag",
    "16-07-Waddah_Attar_Explosion",
    "190_CCI_stochasticf",
    "2 Moving Average Signal",
    "21-10-ZZm-fx-txt",
    "22-01-GannZigZag",
    "22-03-ICWR",
    "4X 2011 XARD OSCILLATOR",
    "AIMS",
    "AltrTrend",
    "arrow",
    "Average Daily Range",
    "B3",
    "BetterVolume 1.4",
    "Binlex",
    "BrainTrend2SigALERT",
    "buyers-vs-sellers",
    "camarilla",
    "Candlestick_alerts_Set_3",
    "ClusterTrend Indicator",
    "Digital Candlestick",
    "Dynamic_Zone_RSI2",
    "Dyn_AllLevels",
    "EntropyMathMCD",
    "FFx_Universal_Strength_Meter",
    "FIB - MomentumModulator",
    "FiboPiv_v3New",
    "fishingind_v2_04_light",
    "FishingZZ_v1_1",
    "FL01",
    "forex_glaz",
    "FS30_4",
    "FS30_5",
    "FXSSI.Sentiment.Lite",
    "HeikenAshi",
    "HullMA",
    "i-FractalsEx",
    "i-Sessions",
    "ISHA INDICATOR V5.0",
    "i_Alex_Activity_v02_light",
    "JBR channel",
    "JBR LEVELS",
    "kaufman-adaptive-moving-average",
    "Laser Reversal",
    "MarketProfile_VirginpPOC",
    "MTF Forex freedom Bar v2",
    "MTF Forex freedom Bar",
    "MTF Stochastic v2.0 Alert",
    "MTF Stochastic v2.0",
    "MTF_CCI",
    "MurreyMath2(рус)",
    "PVSRA Volumes Set v1 (White)",
    "RD-Сombo",
    "Show Money v.2",
    "Signal_Bars_v6",
    "sliding-channels",
    "SoeHoeCom_Peak",
    "Spread",
    "SS_SupportResistance",
    "Stochastics_MTF",
    "Super trend",
    "TLaP Crowd Stop Loss v.1.19",
    "TPO-Range",
    "TPO",
    "trend-focus-indicator",
    "Trendline",
    "TRIX.Crossover",
    "vertical_time_lines",
    "VP-Range-v6",
    "VQ",
    "VSA Better&TickSeparateVolumeHistogram",
    "VSA-Coloured Volume v2.03 - Copy",
    "3DStochastic",
    "Crater"
];
