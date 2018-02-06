function [ phase, frequency ] = CalcPhase( Signal1, Signal2, SampleFreq)
%CalcPhase Calculate the phase of the signal
%   Calculate the phase of the signal
%   Note could filter to remove the higher harmonics
%   Note could return phases for different frequency components or work out
%   the core frequency component itself

%Can work with just one wave form - need to build in support  - if working
%with both then need them to be the same size.
figure(1);
subplot(2,2,1);
hold off;
plot(Signal1,'b-');
hold on;
L = max(size(Signal1));
subplot(2,2,2);
hold off;
NFFT = 2^nextpow2(L); % Next power of 2 from length of y
Y1 = fft(Signal1,NFFT)/L;
Y1_norm = Y1 ./ norm(Y1);
f1 = SampleFreq/2*linspace(0,1,NFFT/2+1);
plot(f1,2*abs(Y1_norm(1:NFFT/2+1)),'b-');
hold on;
subplot(2,2,3);
hold off;
%p1 = unwrap(angle(Y(1:NFFT/2+1))); 
p1 = (angle(Y1(1:NFFT/2+1))); 
plot(f1,(180*p1 ./ pi),'c-');
hold on;
if size(Signal1) == size(Signal2)
%Only use the 2nd signal if they are both the same size
    subplot(2,2,1);
    plot(Signal2,'r-');
    
    subplot(2,2,2);
    %NFFT = 2^nextpow2(L); % Next power of 2 from length of y
    Y2 = fft(Signal2,NFFT)/L;
    Y2_norm = Y2 ./ norm(Y2);
    f2 = SampleFreq/2*linspace(0,1,NFFT/2+1);
    plot(f2,2*abs(Y2_norm(1:NFFT/2+1)),'r-');
    hold on;
    subplot(2,2,3);
    %p2 = unwrap(angle(Y(1:NFFT/2+1))); 
    p2 = (angle(Y2(1:NFFT/2+1))); 
    plot(f2,(180*p2 ./pi),'m-');
    hold off;
    
    %Could do a YYplot so they're scaled better
    
    subplot(2,2,4);
    p = p1 - p2;
    plot(f2,(180*p ./pi),'c-');

end

%Now need to find Phase at the desired Frequency  - the idea of the
%Just return 1 phase value - If I want to act on lots of sections will use
%a function above this one
%Could export all phases but really need to export the correct value!

[~, MaxI] = max(2*abs(Y1_norm(1:NFFT/2+1)));
i = 0;
while f1(MaxI) < 50
    i = i + 30;
    [~, MaxI] = max(2*abs(Y1_norm(i:NFFT/2+1)));
    MaxI = MaxI + i;
end
frequency = f1(MaxI);

%Now need to pull out the phase
phase = (180*p(MaxI) ./pi);

end

