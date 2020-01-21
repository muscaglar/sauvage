function [ freq , psdx, Fs] = AnalysePowerSpectrum(iv_data,Fs)
%ANALYSEFLUCTUATIONS Summary of this function goes here
%   Detailed explanation goes here

%Can either load all of trace and then analyse
%OR do analysis on each section and then combine the resutls.

%[ ChannelData, FolderPath, TraceDate, TraceNo, TraceObj, Fs, NoFiles ] = LoadTraceByID( TraceID);

%CLASSIFYVOLTAGE Return the applied voltage - ie 100, 150, 200 etc
ClassifiedVoltages = round(iv_data(:,2),2,'significant');

%Ideally select by voltage  - or run over all voltages
% if nargin < 2
%     voltage = mode(ClassifiedVoltages);
%     disp(['No voltage specified so using ' num2str(voltage )]);
% elseif isempty(voltage)

voltage = mode(ClassifiedVoltages);


%ChannelDataByV = iv_data(ClassifiedVoltages == voltage ,:);

%from http://uk.mathworks.com/help/signal/ug/psd-estimate-using-fft.html

rng default

t = 0:1/Fs:1-1/Fs;
%x = cos(2*pi*100*t) + randn(size(t));
%x = ChannelDataByV(:,3);
x = iv_data(:,1);

N = length(x);
xdft = fft(x);
xdft = xdft(1:N/2+1);
psdx = (1/(Fs*N)) * abs(xdft).^2;
psdx(2:end-1) = 2*psdx(2:end-1);
freq = 0:Fs/length(x):Fs/2;

%plot((freq),10*log10(psdx))
%plot((freq),10*log10(psdx))
semilogx((freq),10*log10(psdx))
grid on
title('Periodogram Using FFT')
xlabel('Frequency (Hz)')
ylabel('Power/Frequency (dB/Hz)')


end

