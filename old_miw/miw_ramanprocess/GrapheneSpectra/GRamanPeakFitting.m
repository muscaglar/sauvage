function [ GPeakSpectra, IdentGPeaks ] = GRamanPeakFitting( RamanSpectra )
%UNTITLED3 Summary of this function goes here
%   GpeakSPectra is the spectra, processed, filtered and thresholded etc of
%   the spectra for graphene  - with the lorentizians overlaid

%Take a spectra and extract as much information as possible  - returning
%most of it in the function outputs

%baseline subtraction  - ie fit to the whole curve
subplot(2,2,1)
[ProcessedSpectra] = BaseLineSubtract( RamanSpectra, 50);

%Peak detection
% do as true peak detection or just look for the appropriate peaks
subplot(2,2,2)
%[ GPeakLocations, GPeakWidths, nPeaks, GPeakSpectra ] = PeakDetection(ProcessedSpectra, 1000, 3200);
[ GPeakLocations, GPeakWidths, nPeaks, GPeakSpectra ] = SmartPeakDetection(ProcessedSpectra, 1000, 3200);

%Graphene Peak analysis
    %Ratio - needs to good background removal  - could actually re do on
    %the central section!
    %Location
    %FWHM
    
%Peak Fitting
Width = 0;   % this is a parameter to increase the region used for fitting as the positions given can be some way into the peak
for p = 1:nPeaks
    subplot(2,2,3)
    %Set the width based on the inner peak width but scale to add a little
    %either side
    Width = floor((GPeakWidths(p,5) - GPeakWidths(p,4)) / 4);
    %Work out the start and end
    peakS = GPeakWidths(p,4) - Width;
    if peakS < 1; peakS = 1; end;
    peakE = GPeakWidths(p,5) + Width;
    if peakE > max(size(GPeakSpectra)); peakE = max(size(GPeakSpectra)); end; 
    
    %If the peak is bigger than a certain number of data points then use  -
    %but note need to account for "width" parameter 
    if (peakE - peakS) > (3 + 2* Width)
        %Fit a peak
        [ location(p), scale(p), area(p) ] = LorentizianFit( GPeakSpectra( peakS:peakE ,1 )  , GPeakSpectra(peakS:peakE,3), [GPeakLocations(p,1) (GPeakWidths(p,2)/2) (GPeakLocations(p,2)*(GPeakWidths(p,2)/2)/pi) ] ,1); 
        
        %Check fitted to a peak with the markers  - if not discard as
        %fitted a different peak
        if(location(p) >= GPeakSpectra( peakS, 1) && location(p) <= GPeakSpectra( peakE, 1))
            %Okay - keep
        else
            location(p)=0; scale(p)=0; area(p)=0;
        end
        
    end
   %Just fit single Lorentzians to each peak here to see what happens  -
    %but what about where multiple are needed - and why fit to the smallest
    % should really identify peaks and then choose what to do with them
end


%Graphene Understanding   - do in a different function  - it could be
%called from here but isn't - this function processes, a different function
%analyses

IdentGPeaks = [location' scale' area'];

end

