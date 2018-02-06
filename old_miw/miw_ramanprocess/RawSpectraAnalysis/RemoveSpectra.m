function [ Fit_Spectra ] = RemoveSpectra( X, Y )
%Remove Spectra Removes from the spectra features which are known and mess
%up the base line fit
%   Remove the peak due to water as this cannot be smoothed out so end up
%   fittting to it instead
if(max(size(X))) > 900
    %Copy the spectra into the output without the water peak region
    Fit_Spectra(:,1)=  X([1:550,800:end]);
    Fit_Spectra(:,2)=  Y([1:550, 800:end]);
else
    %the spectra isn't long enough to contain the water so return unedited
    %spectra
    Fit_Spectra(:,1)=  X();
    Fit_Spectra(:,2)=  Y();
end
end

