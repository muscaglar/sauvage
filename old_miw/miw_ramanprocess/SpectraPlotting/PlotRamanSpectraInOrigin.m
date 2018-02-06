function [ORG] = PlotRamanSpectraInOrigin( Spectra, ORG , title, from, to)
%PLOTRAMANSPECTRA Plot Raman Spectra into Origin - note could add features
%like offsets and range or plot some elements of the processed spectra
% Could also add the fitted information - ie peak locations and Ratios

if nargin < 2
    ORG = Matlab2OriginPlot();
    ORG.HoldOff();
end
if nargin < 3
        title = 'spectra';
end

    ORG.PlotLine(Spectra(:,1)',Spectra(:,2)',title);
    ORG.HoldOn();
    ORG.ylabel('Raman Intensity','a.u.');
    ORG.xlabel('Raman Shift','cm^-1');
    ORG.HideActiveWkBk();
    
    ORG.title(title)
    
    if nargin > 4
        ORG.xaxis( from , to );
        ORG.yrescale();
    end
    
   
end

