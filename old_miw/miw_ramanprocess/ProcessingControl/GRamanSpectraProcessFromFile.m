function [ SpectrumMatrix ] = GRamanSpectraProcessFromFile( FileName, PathName)
%GRamanSpectraProcessFromFile Load a spectra, process it and then save out
%the details


%If file Name is blank then show dialog  - load and import data
if nargin < 1
    [ Spectra, FileDetails, FileName, PathName  ] = GRamanSpectraLoad();
else
    [ Spectra, FileDetails, FileName, PathName  ] = GRamanSpectraLoad( FileName, PathName );
end

%Analyse the spectra and return the results
[FitsSpectra, Nlayers, SpectraDetails , Peaks, SpectrumMatrix ] = GRamanSpectraProcess(Spectra);

%Do i want to plot - in Matlab or origin, as an operation from here or
%later using saved file and origin plot?   - could also export  - eg eps
%etc  using Keyser code!

%Save processed file    -- Note ideally will same all the peaks info for
%the lorentzians
%Apply an offset so that none of the spectra are below 0
offset = 0;
if offset == 1
[ FitsSpectra(:,3), rawOffset] = SpectraOffsetCorrect( FitsSpectra(:,3) );
 FitsSpectra(:,4) = SpectraOffsetCorrect( FitsSpectra(:,4), rawOffset);
 FitsSpectra(:,5) = SpectraOffsetCorrect( FitsSpectra(:,5), rawOffset);
 FitsSpectra(:,6) = SpectraOffsetCorrect( FitsSpectra(:,6), rawOffset);
 FitsSpectra(:,7) = SpectraOffsetCorrect( FitsSpectra(:,7), rawOffset);
end
 ProcessedGRamanSpectraSave(FitsSpectra,FileDetails,FileName,PathName, SpectraDetails, Spectra);

disp(['This, ' FileName ', is ' num2str(Nlayers) ' layer graphene']);

%Set up the output args  -- This is the Spectrum Matrix and is created
%above

%Plot a graph and print out
PlotGrapheneRaman( [FitsSpectra(:,1) FitsSpectra(:,3)], [FitsSpectra(:,1) FitsSpectra(:,7)], 1,FileName,PathName);

end

