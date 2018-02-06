function [ NLorentzians, Parameters, FittedPeaks] = BestNoLorentzians( PeakSpectra MaxFit)
%UNTITLED2 Summary of this function goes here
%   So pass in just the peak - nb could be as X and Y arguments
%   Then try to fit lorentzians up to a max number of peaks
%   Use some means to determine the best fitting number of lorentzians and
%   return the paramters for these, (could also return their spectra in
%   FitPeaks
%   Note - due to the time this will take it should only be called on the
%   peak which has already been identified as the peak of interest.

if nargin < 2
    MaxFit = 4;
end
ResidErrors = zeros(1,MaxFit);
for i = 1:MaxFit
% Fit with each of the different numbers of peaks    
% need to set intial parameters - for each of the peaks - can they be the
% same or is this bad.
    [ location, scale, area, ResidErrors(i) ] = LorentizianFit( X,Y, Params0, i )
% Calc and record some measure of error - should these be scaled against
% anything?
% need to store the fitted parameters for each so they can be used again.

end

%Now using the measure of error or fit decide which number of peaks gave
%the best fit.
NLorentzians = 
%Transfer the assocaited parameters into return argument
%Transfer the actual peaks into the output argument.
Parameters, FittedPeaks
end

