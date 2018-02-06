function [ PeakLocations, PeakWidths,nPeaks, ProcessedSpectra ] = SmartPeakDetection( Spectra, StartWl, EndWl )
%SmartPeakDetection 
% Detect Peaks
% Be smarter then just thresholding  - use the 2nd derivative and lcoate
% its zero crossings to find sharp changes in gradient which indicate peaks

%Just look for a region of interest
if nargin < 3
    ROISpectra = Spectra;
else
    ROISpectra = SpectraCrop(Spectra,StartWl,EndWl);
end
%Redo Baseline
ROIProcSpec = BaseLineSubtract(ROISpectra); 

%Now find the Peaks

%Differentiate the spectra  - using the fine filter signal
SpectraDiff = diff(ROIProcSpec(:,5)); 
SpectraDiffSmoothed =  Smooth(SpectraDiff, 3);
SpectraDiff2 = diff(SpectraDiffSmoothed);
%This smoothing paramter has a critical effect of detecting zero crossings
%well!
SpectraDiff2Smoothed =  Smooth(SpectraDiff2, 6);

S = SpectraDiff2Smoothed;
hold on
plot(ROISpectra(1:length(S),1),10*S,'k');
l = max(size(S));

%Now find peaks from the 2nd Differential of the signal
%Look for the zero crossing point going up and then going down and use that
%point   - need to find pairs of peaks
% Actually may need to threshold this signal!!!  - need to see what it
% looks like

%Find Zero crossings  - work out direction, then work out which goe with
%which.
PeakFlag = 0;
Pks = 1;
for i = 4:l-3
   if (S(i-3) > 0 && S(i+3) < 0) && ( S(i-2) > 0  && S(i+2) < 0 )
  %if S(i-2) > S(i-1) && S(i-1) > 0 && S(i+1) <0  && S(i+2) < S(i+1)    %Original
  %if S(i-2) > 0 && S(i-1) > 0 && S(i+1) <0  && S(i+2) < 0
        % A zero crossing for the start of a peak  
        %Need to deal with if in a peak or not
        if PeakFlag == 0 
           %Start of new peak
            PkStart = ROISpectra(i-1,1);
            PkStartIndex = i-1;      
            PeakFlag = 1 ;
        else
            %Have found a 2nd peak start...  - depending on width use this
            %one?
            if(i > PkStartIndex+20)     %this is a critical Parameter
                PkStart = ROISpectra(i-1,1);
                PkStartIndex = i-1;      
                PeakFlag = 1 ;
            end
        end
   elseif (S(i-3) < 0 && S(i+3) > 0) && ( S(i-2) < 0  && S(i+2) > 0 )
       %S(i-2) < S(i-1) && S(i-1) < 0 && S(i+1) >0 && S(i+2) > S(i+1)  %Original
        %A zero crossing for the end of a peak
        if PeakFlag == 1
            %Have found the end of the peak  - record
            PkEndIndex = i+1;
            PkEnd = ROISpectra(i,1);
              
            %Find the maxima  - from the raw with baseline removed
            [PeakMax Peakloc] = max(ROIProcSpec(PkStartIndex:PkEndIndex,3));
            if PeakMax > 0
            PeakLocIndex = Peakloc+PkStartIndex-1;
            PeakLocations(Pks,:) = [ROIProcSpec(PeakLocIndex,1), PeakMax, PeakLocIndex];
            PeakWidths(Pks,:) = [PkStart PkEnd (PkEnd-PkStart) PkStartIndex PkEndIndex];
            Pks = Pks+1;
            end
            PeakFlag = 0;
        else
            %have found an end without an beginning - may have paired
            %wrongly
            
        end
   end
   
end

nPeaks = max(size(PeakLocations(:,1)));
%ensure the relevant graphs are all aded to the spectraoutput
ProcessedSpectra = ROIProcSpec;
k = min(size(ProcessedSpectra));
%Add the spectra used for Peak fitting  - this used to be threshold for
%simple peak detection    - However S is a different length...
%ProcessedSpectra(:,k+1) = S;
ProcessedSpectra(1:length(S),k+1) = S;

%Plot the peaks
hold on
plot(PeakLocations(:,1),PeakLocations(:,2),'o');
plot(PeakWidths(:,1),zeros(max(size(PeakWidths(:,1))),1),'r*');
plot(PeakWidths(:,2),zeros(max(size(PeakWidths(:,1))),1),'b*');
end

