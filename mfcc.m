% Masukan untuk fungsi ini adalah :
% *input=masukan suara
% *samplingRate=sampling rate suara yang dimasukkan
% *timeFrame=waktu yang diinginkan untuk 1 frame(dalam ms)
% *lap=overlaping yang diinginkan (harus kurang dari 1)
% *cepstralCoefficient=jumlah cepstrum yang diinginkan sebagai output

function ceps=mfcc(input,samplingRate,timeFrame,lap,cepstralCoefficients)
%input=d_sekat;
%samplingRate=11000;
%timeFrame=23.27;
%lap=0.39;
%cepstralCoefficients=20;
[r c] = size(input);
if (r > c) 
	input=input';
end

frame=floor(timeFrame/1000*samplingRate)+1;
overlap=floor(lap*frame)+1;

% Fungsi hamming window
hamWindow = 0.54 - 0.46*cos(2*pi*(0:frame-1)/frame);

% Filter bank parameters
lowestFrequency = 133.3333;
linearFilters = 13;
linearSpacing = 66.66666666;
logFilters = 27;
logSpacing = 1.0711703;


totalFilters = linearFilters + logFilters;


freqs = lowestFrequency + (0:linearFilters-1)*linearSpacing;
freqs(linearFilters+1:totalFilters+2) = freqs(linearFilters) * logSpacing.^(1:logFilters+2);

lower = freqs(1:totalFilters);
center = freqs(2:totalFilters+1);
upper = freqs(3:totalFilters+2);

mfccFilterWeights = zeros(totalFilters,2*frame);
triangleHeight = 2./(upper-lower);
fftFreqs = (0:2*frame-1)/frame*samplingRate;

for chan=1:totalFilters
	mfccFilterWeights(chan,:) =(fftFreqs > lower(chan) & fftFreqs <= center(chan)).* ...
   triangleHeight(chan).*(fftFreqs-lower(chan))/(center(chan)-lower(chan)) + ...
  (fftFreqs > center(chan) & fftFreqs < upper(chan)).* ...
   triangleHeight(chan).*(upper(chan)-fftFreqs)/(upper(chan)-center(chan));
end


mfccDCTMatrix = 1/sqrt(totalFilters/2)*cos((0:(cepstralCoefficients-1))' *(2*(0:(totalFilters-1))+1) * pi/2/totalFilters);
mfccDCTMatrix(1,:) = mfccDCTMatrix(1,:) * sqrt(2)/2;

% Masukan di filter kemudian dilakukan proses frame blocking 
if 1
	preEmphasized = filter([1 -.97], 1, input);
else
	preEmphasized = input;
end

a=buffer(preEmphasized,frame,overlap,'nodelay');
cols=size(a,2);
ceps = zeros(cepstralCoefficients, cols);

% Setiap kolomnya kemudian dilakukan windowing, fft,mel-frequency wraping menggunakan filterbank 
for start=1:cols
    
    fftData = zeros(1,2*frame);
    fftData(1:frame) = a(:,start)'.*hamWindow;
    %fftData(1:frame) = input(:,start)'.*hamWindow;
    fftMag = abs(fft(fftData));
    earMag = log10(mfccFilterWeights * fftMag');
    ceps(:,start) = mfccDCTMatrix * earMag;
end



