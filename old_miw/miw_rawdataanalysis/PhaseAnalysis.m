function [ FittedPhase, Phase , PhaseHistogram, TimePeriod ] = PhaseAnalysis( Signals, NoSamples, SampleFreq )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

L = max(size(Signals));
TimePeriod = NoSamples * 1/SampleFreq;
%Split Signals up and find phases;
t = 0;
N = floor(L/NoSamples);
n = 1;
for i = 1:1:N
   [ Phase(i,2), Phase(i,3) ] = CalcPhase( Signals(n:n+NoSamples,1), Signals(n:n+NoSamples,2), SampleFreq);
   Phase(i,1) = t;
   t = t + TimePeriod;
   n = n + NoSamples;
end    
%plot phase changes over time
figure(2)
subplot(2,2,1)
hold off
plotyy(Phase(:,1),Phase(:,2),Phase(:,1),Phase(:,3))

%Take a histogram of the phases
subplot(2,2,2)
hist(Phase(:,2));
%Create Phase Histogram  - one column is bins, the other is frequency
%Need to make adaptive so that 
bin_size = 2;
PhaseHistogram(:,1) = -180:bin_size:180;
PhaseHistogram(:,2) = histc(Phase(:,2),PhaseHistogram(:,1));
subplot(2,2,3) 
bar(PhaseHistogram(:,1),PhaseHistogram(:,2));
%Now need to ensure the bin sizes are small enough to give a historgram so
%limit the heighest bin to a fixed % of the total frequency count
%if not then redo with a smaller bin  - nb could also do the other way
%round
while max(PhaseHistogram(:,2)) > (sum(PhaseHistogram(:,2)) * 0.2)
    bin_size = bin_size * 0.75;
    clear PhaseHistogram;
    PhaseHistogram(:,1) = -180:bin_size:180;
    PhaseHistogram(:,2) = histc(Phase(:,2),PhaseHistogram(:,1));
    subplot(2,2,3) 
    bar(PhaseHistogram(:,1),PhaseHistogram(:,2));
end
%Now fit to the distribution 
subplot(2,2,4);
%don't want to fit to data which is in water or air
minPhase = -86; maxPhase = 10;
%indices = find((PhaseHistogram(:,1) > minPhase) && (PhaseHistogram(:,1) < maxPhase));
indices = (PhaseHistogram(:,1) > minPhase) & (PhaseHistogram(:,1) < maxPhase) ;%& (PhaseHistogram(:,2) > 0);
[ mu, std, scale ] = FitGaussain( PhaseHistogram(indices,:) , 1 );

%Check for good fit
if mu < maxPhase && mu > minPhase
FittedPhase = [mu, std, scale ];
else
    FittedPhase = [0, 0, 0 ];
end
%Note might want to do something about loosing contact

end

