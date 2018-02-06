function [ ORG,Spectra, FitsSpectra ] = PlotProcessedRamanSpectraByID( SpectraIDs, prefix , from , to)
%PLOTPROCESSEDRAMANSPECTRABYID 
%Will use the existing code to load and plot the spectra but will then
%process that spectra and add more plots

%Note that Hold is turned off and then on by PlotRamanSpectraByID
if nargin > 3
    [ ORG, Spectra ] = PlotRamanSpectraByID( SpectraIDs, prefix , from , to);
else
    [ ORG, Spectra ] = PlotRamanSpectraByID( SpectraIDs, prefix);
end

for S = SpectraIDs
    Sprefix = [prefix num2str(S)];
    [ Spectra ] = SpectraLoadByID( S );         %Have to re load each spectra so I have each individually

    %Now get the Fits spectra and plot these  - either base on an
    %argument or otherwise
    [FitsSpectra, Nlayers, SpectraDetails , Peaks, SpectrumMatrix ] = GRamanSpectraProcess(Spectra);
    [ FitsSpectra(:,3), rawOffset] = SpectraOffsetCorrect( FitsSpectra(:,3) );
    %FitsSpectra(:,4) = SpectraOffsetCorrect( FitsSpectra(:,4), rawOffset);
    FitsSpectra(:,5) = SpectraOffsetCorrect( FitsSpectra(:,5), rawOffset);
    FitsSpectra(:,6) = SpectraOffsetCorrect( FitsSpectra(:,6), rawOffset);
    FitsSpectra(:,7) = SpectraOffsetCorrect( FitsSpectra(:,7), rawOffset);

%Note not need to set limits again as will have been done above - likewise
%for y comment
 ORG = PlotRamanSpectraInOrigin( [FitsSpectra(:,1) FitsSpectra(:,3)] , ORG , [Sprefix '_pro']);
 ORG.yComment(['S ' num2str(S) ' BaseLineRemoved']);
 ORG = PlotRamanSpectraInOrigin( [FitsSpectra(:,1) FitsSpectra(:,4)] , ORG , [Sprefix '_pro']);
 ORG.yComment(['S ' num2str(S) ' BaseLine']);
 ORG = PlotRamanSpectraInOrigin( [FitsSpectra(:,1) FitsSpectra(:,5)] , ORG , [Sprefix '_pro']);
 ORG.yComment(['S ' num2str(S) ' Smoothed']);
 %ORG = PlotRamanSpectraInOrigin( [FitsSpectra(:,1) FitsSpectra(:,6)] , ORG , [Sprefix '_pro']);
 %ORG.yComment(['S ' num2str(S) ' BaseLine']);
 ORG = PlotRamanSpectraInOrigin( [FitsSpectra(:,1) FitsSpectra(:,7)] , ORG , [Sprefix '_pro']);
 ORG.yComment(['S ' num2str(S) ' Fitted']);
end

if nargin > 3
       ORG.xaxis( from , to );
       ORG.yrescale();
else


end

