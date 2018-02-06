function [ FitsSpectra ] = GFittedSpectra( GPeakSpectra, Peaks, ToPlot )
%GFittedSpectra Plot the fitted spectra
%   From the fitted and then identified Peaks plot the equivlent
%   recontstruction of the graphene Raman spectra
%
%   Append to the exisiting matrix  - will use the X cooorindates in the
%   first column so points match up
%
%   Note need to be aware of the case where there are no peaks???

if nargin < 3
    ToPlot = 0;
end

location = Peaks(:,1);
scale = Peaks(:,2);
area = Peaks(:,3);
Y  = Lorentzian(GPeakSpectra(:,1),location, scale, area);

%Now add the fitted spectra - do I want to copy it in to the next avaliable
%space
n = min(size(GPeakSpectra)) + 1;
FitsSpectra = GPeakSpectra;
FitsSpectra(:,n) = Y;

if(ToPlot > 0);
    subplot(2,2,4)
    plot(GPeakSpectra(:,1),Y);
end
end

