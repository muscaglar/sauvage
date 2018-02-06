function [ MatchedSpectra1, MatchedSpectra2 ] = MatchScale(X, Spectra1, Spectra2, FitRange , OutRange )
%MatchScale For the two spectra match the scale so that they overlap  - eg
%so wateror glass slide is the same  - this will then allow one to be
%subtracted to the other - or added
%   FitRange will specify the range over which the fit is made.
%   Note it should be a matrix, so there can be multiple fit positions.
%   
%   Note does it take X and Y data or just Y, X needs to be the same for
%   all of them
%   Note just normalising won't work as peaks would mess this up. - some
%   scope for just using average or sum value though - but ideal some form
%   of convolution and search.
%   Spectra1 and SPectra2 are columns of count values  
%   X is the waveform data
%   Fit Range is the wavenumbers to fit between


MatchedSpectra1 = NormaliseSpectra(Spectra1, OutRange); 
MatchedSpectra2 = NormaliseSpectra(Spectra2, OutRange);

figure(3)
hold off
subplot(1,2,1)
plot(X, Spectra1,'r-');
hold on;
plot(X, Spectra2,'b-');
subplot(1,2,2)
hold off
plot(X, MatchedSpectra1,'r-');
hold on
plot(X, MatchedSpectra2,'b-');

end

