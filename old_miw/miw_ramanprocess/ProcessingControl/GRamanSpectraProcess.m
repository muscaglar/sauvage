function [OutputSpectra, Nlayers, SpectraDetails , Peaks, SpectrumMatrix  ] = GRamanSpectraProcess( Spectra )
%A function which takes a spectra and reutrns all the information about the
%spectra
%No File IO at all in this function

%Process File
[GPeakSpectra, IdentGPeaks ] = GRamanPeakFitting( Spectra );
IdentGPeaks
% Now Analyse the identified peaks
[ Nlayers, SpectraDetails , Peaks, SpectrumMatrix ] = GRamanPeakAnalyse( IdentGPeaks , GPeakSpectra );

%Finally need to create the fitted spectra/all fits and add these to the
%GpeakSpectra
[ OutputSpectra ] = GFittedSpectra( GPeakSpectra, Peaks);

end

