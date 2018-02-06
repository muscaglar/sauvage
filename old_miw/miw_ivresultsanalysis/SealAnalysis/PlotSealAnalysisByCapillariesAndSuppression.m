function [ output_args ] = PlotSealAnalysisByCapillariesAndSuppression( Capillaries,SealedSuppression, OP, prefix  )
%PLOTSEALANALYSISBYCAPILLARIESANDSUPPRESSION Summary of this function goes here
%   Detailed explanation goes here

if nargin < 4
    prefix = [];
    if nargin < 3
        OP = 0;
        if nargin < 2
            SealedSuppression = [];
        end
    end
    
end

%Plot the default version - ie unsuppressed
PlotSealAnalysisByCapillaries(Capillaries, OP, prefix)
%Now loop through the suppression codes and plot them
for s = SealedSuppression
    PlotSealAnalysisByCapillaries(Capillaries, OP, prefix, s)
end

end

