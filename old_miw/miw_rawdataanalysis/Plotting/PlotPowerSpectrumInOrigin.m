function [ freq, psdx ] = PlotPowerSpectrumInOrigin(  TraceIDs , voltage , title  )
%PLOTPOWERSPECTRUMINORIGIN Summary of this function goes here
%   Detailed explanation goes here

if nargin < 3
    title = ['PSD_' num2str(TraceIDs(1))];
end

ORG = Matlab2OriginPlot;
ORG.HoldOff;

for TraceID = TraceIDs
    if nargin < 2
        [ freq , psdx,Fs] = AnalysePowerSpectrum( TraceID );
    else
        [ freq , psdx,Fs] = AnalysePowerSpectrum( TraceID , voltage );
    end
    
    %Now plot into Origin
    PlotName = ['PSD' num2str(TraceID) '_' title];
    ORG.PlotLine(freq,10*log10(psdx)',PlotName, ORG.ColourPicker() );
    ORG.yComment(['PSD' num2str(TraceID)]);
    ORG.ylabel('Power/Frequency','dB/Hz');
    ORG.xlabel('Frequency','Hz');
    ORG.logXScale();
    ORG.HideActiveWkBk;
    
    ORG.title(PlotName);
    
    ORG.xaxis(0.05, Fs/2);
    ORG.yrescale;
    
    ORG.HoldOn;
    
end
    ORG.xaxis(0.001, Fs/2);
    ORG.yrescale;
    
ORG.Disconnect;
end

