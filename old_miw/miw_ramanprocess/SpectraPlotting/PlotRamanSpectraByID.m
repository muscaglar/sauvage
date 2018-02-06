function [ ORG, Spectra ] = PlotRamanSpectraByID( SpectraIDs, prefix , from , to)
%PLOTRAMANSPECTRA Plot Raman Spectra into Origin - note could add features
%like offsets and range or plot some elements of the processed spectra
% Could also add the fitted information - ie peak locations and Ratios

if nargin < 2
    prefix = '';
end

ORG = Matlab2OriginPlot();
ORG.HoldOff();

DB = DBConnection;
M = Membranes(DB);

for S = SpectraIDs
    %Load Date No
    
%     [ FileName, PathName, SpectraDate, SpectraNo, TraceObj ] = GetSpectraPathByID( S );
%     [ Spectra, Details, ~,~ ] = GRamanSpectraLoad( FileName, PathName );
    [ Spectra, Details, FileName, PathName, SpectraDate, SpectraNo, TraceObj ] = SpectraLoadByID( S );
    
    title = [prefix 'ID_' num2str(S)];

    if nargin > 3
        ORG = PlotRamanSpectraInOrigin( Spectra, ORG , title, from, to);
    else
        ORG = PlotRamanSpectraInOrigin( Spectra, ORG , title);
    end
    M.SELECT(TraceObj.getMembrane());
    MembraneDetails = ['M: ' num2str(M.getid()) ' ' char(M.getName()) ' ' char(M.getDetails())];
    ORG.yComment(['S ' num2str(S) ' ' MembraneDetails]);
end

end

