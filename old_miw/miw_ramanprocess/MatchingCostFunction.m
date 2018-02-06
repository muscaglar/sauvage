function [ cost ] = MatchingCostFunction(X, Spectra1, Spectra2, FitRange )
%UNTITLED Summary of this function goes here
%   Spectra1 and SPectra2 are columns of count values  
%   X is the waveform data
%   Fit Range is the wavenumbers to fit between


%Simple cost function is sum of the square errors
cost = sum(Spectra1 - Spectra2)^2;


end

