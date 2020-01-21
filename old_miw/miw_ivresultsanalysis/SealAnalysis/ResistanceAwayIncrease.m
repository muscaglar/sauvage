function [ meanRaway, medianRaway  , bins , counts, stdRaway] = ResistanceAwayIncrease( CapillaryIDs )
%CH4_RESISTANCEAWAYINCREASE Summary of this function goes here
%   Detailed explanation goes here
if nargin < 1
[ ResistanceAwayIncrease ] = getNameValueMatrix( 'ResistanceAwayIncrease' );
[ ResistanceRatios ] = getNameValueMatrix('ResistanceRatio');
else
    ResistanceAwayIncrease = [];
    ResistanceRatios = [];
    for CapillaryID = CapillaryIDs
        rawayr = UpdateNameValueCapillary( CapillaryID , 'ResistanceAwayIncrease');
        if rawayr > 0.01
            ResistanceAwayIncrease = [ResistanceAwayIncrease; rawayr];
        end
        rr = UpdateNameValueCapillary( CapillaryID , 'ResistanceRatio');
        ResistanceRatios = [ResistanceRatios; rr];
    end
end
%To do comparison you need to match up the capillaries!!  - this is
%tricker as not every experiment has results
%Comparison = ResistanceRatios(:,1) .* ResistanceAwayIncrease(:,1);

%Matrix = ResistanceAwayIncrease(Comparison > 1.1,:);

%mean(Matrix(:,1))


[ bins, counts, MinRange, MaxRange, PlotData ] = SmartHistogramPlot( ResistanceAwayIncrease(:,1),0.1,90);
meanRaway = mean(PlotData)
medianRaway = median(PlotData)
stdRaway = std(PlotData)

% size(PlotData)
% sum(PlotData > 1)

end

