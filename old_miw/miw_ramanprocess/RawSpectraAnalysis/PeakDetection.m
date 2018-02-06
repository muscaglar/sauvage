function [ PeakLocations, PeakWidths,nPeaks, ProcessedSpectra ] = PeakDetection( Spectra, StartWl, EndWl )
%UNTITLED13 Summary of this function goes here
%   Detailed explanation goes here

%Just look for a region of interest
if nargin < 3
    ROISpectra = Spectra;
else
    ROISpectra = SpectraCrop(Spectra,StartWl,EndWl);
end
%Note running on just the graphene part of the file now  - but re do the
%base line  - choose where to fit the baseline to  - can miss part of it
ROIProcSpec = BaseLineSubtract(ROISpectra);  %this did have arguments 1,430 to prevent fitting to the water peak, but this is verys epcific to the spectra and spectrometer - smart peak detection handles it better!
l = max(size(ROIProcSpec));
%Now find the Graphene Peaks
%Find the Max  - say thereshold is at least 10%
m = max(ROIProcSpec(1:400,5));
%Threshold the Spectra
TH = Threshold( ROIProcSpec(:,5) , m*0.1 );
hold on
plot(ROISpectra(:,1),TH,'k');

%Now find peaks in the thresholded signal
%Return this info to keep this code general and then use other code to work
%out what they are and in they are of any use.

%Look for threshold crossings, and then cross back - ideally check that
%within this there isn't a 2nd peak - ie 50% drop or something. ie is it
%too close peaks? - or apply this
p = 1;
pflag = 0;
%Need to first ensure the first point isn't above 0 - if it is move to
%the first point below zero.
if TH(1) > 0
 for i = 1:l
    if(TH(i) == 0)
        s = i;
        break;
    end
 end
else
    s = 1;
end    
for i = s:l
    if pflag == 0
        if TH(i) > 0
           pstart = ROISpectra(i-1,1);
           pSind = i-1;      
           pflag = 1 ;
        end
    else
        %in a peak so look for edge
           if TH(i) == 0
               pEind = i;
               pend = ROISpectra(i,1);
               
               %Find the maxima
               [PeakMax Peakloc] = max(TH(pSind:pEind));
               PeakLocations(p,:) = [ROIProcSpec((Peakloc+pSind-1),1) PeakMax, Peakloc+pSind-1];
               PeakWidths(p,:) = [pstart pend (pend-pstart) pSind pEind];
               p = p+1;
               pflag = 0;
           end    
    end
end
nPeaks = max(size(PeakLocations(:,1)));
%ensure the relevant graphs are all aded to the spectraoutput
ProcessedSpectra = ROIProcSpec;
k = min(size(ProcessedSpectra));
ProcessedSpectra(:,k+1) = TH;
%add threshold as wee


%Plot the peaks
hold on
plot(PeakLocations(:,1),PeakLocations(:,2),'o');
plot(PeakWidths(:,1),zeros(max(size(PeakWidths(:,1))),1),'r*');
plot(PeakWidths(:,2),zeros(max(size(PeakWidths(:,1))),1),'b*');
end

