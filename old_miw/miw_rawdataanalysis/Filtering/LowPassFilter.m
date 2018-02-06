function [ SignalsOut ] = LowPassFilter( Signals, Frequency, SampleRate )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

% Apply to each column of Signals
SignalsOut = zeros(size(Signals));

lpFilt = designfilt('lowpassfir','PassbandFrequency',Frequency, ...
         'StopbandFrequency',1.1*Frequency,'PassbandRipple',0.5, ...
         'StopbandAttenuation',65,'DesignMethod','kaiserwin','SampleRate',SampleRate);

%fvtool(lpFilt)

cols = max(size(Signals(1,:)));
for i = 1:cols
    SignalsOut(:,i) = filter(lpFilt,Signals(:,i));
end

end

