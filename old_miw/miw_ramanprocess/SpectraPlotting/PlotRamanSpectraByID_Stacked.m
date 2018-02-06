function [ ORG, Spectra ] = PlotRamanSpectraByID_Stacked( SpectraIDs, prefix , from , to, Offset)
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
CurrentOffset = 0;
for S = SpectraIDs
    %Load Date No
    
    [ FileName, PathName, SpectraDate, SpectraNo, TraceObj ] = GetSpectraPathByID( S );
    [ Spectra, Details, ~,~ ] = GRamanSpectraLoad( FileName, PathName );
    
    title = [prefix 'ID_' num2str(S)];
    
    %Now load the base line removed version
    [FitsSpectra, Nlayers, SpectraDetails , Peaks, SpectrumMatrix ] = GRamanSpectraProcess(Spectra);
    [ ShiftedSpectra, rawOffset] = SpectraOffsetCorrect( FitsSpectra(:,3) );
    OffsetSpectra = ShiftedSpectra + CurrentOffset;
    
    if nargin > 3
        ORG = PlotRamanSpectraInOrigin( [FitsSpectra(:,1) OffsetSpectra], ORG , title, from, to);
    else
        ORG = PlotRamanSpectraInOrigin( [FitsSpectra(:,1) OffsetSpectra], ORG , title);
    end
    
    %Now Add legend info - membrane and relevant NV pair details
    
    M.SELECT(TraceObj.getMembrane());
    MembraneDetails = ['M: ' num2str(M.getid()) ' ' char(M.getName()) ' ' char(M.getDetails())];
    ORG.yComment(['S ' num2str(S) ' ' MembraneDetails 'Offset:' num2str(CurrentOffset,3)]);
    ORG.HoldOn();

    %Now sort the offset for the next spectra to be plotted
    if nargin < 5
        %No offset provided
        if nargin > 3
            %Get the max spectra in the range of interest - ie the region
            %whcih will be plotted!
            [ ShortSpectra ] = SpectraCrop( [FitsSpectra(:,1) ShiftedSpectra], from, to);
            MaxSpectra = max(ShortSpectra(:,2));
        else
            MaxSpectra = max(FitsSpectra(:,3));
        end
        if  MaxSpectra > CurrentOffset
            Offset =  MaxSpectra;
        end
    end
    CurrentOffset = CurrentOffset + Offset;
    
end

end

