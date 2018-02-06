function [ Ld2, Ld, Nd, Ld2Error, LdError, NdError ] = DefectDensity( PeakRatio, ExcitationWL )
%Defect Calculator 
%   From the Peak ratio calculate the defect density using the equations in
%   The "Quantifying defects in graphene..." Paper
%   Also calculate the error bounds
%   Ensure it works on a matrax of Peak ratios so it can be used to create
%   graphes of defect density with peakratios.

if nargin < 2
   ExcitationWL = 532; 
end

WL4 = ExcitationWL^4;


%Calculate Ld2 and Errors
Ld2 = (1.8E-9) * WL4 *(PeakRatio .^ -1);
Ld = Ld2 .^ 0.5;

Ld2Error = [(((1.8-0.5)*1E-9) * WL4 *(PeakRatio .^ -1))  (((1.8+0.5)*1E-9) * WL4 *(PeakRatio .^ -1))];
LdError = Ld2Error .^ 0.5;
%Calculate Nd and errors

Nd = (1.8e22) * PeakRatio /WL4;

NdError = [((1.8-0.5)* 1e22 * PeakRatio / WL4) ((1.8+0.5)* 1e22 * PeakRatio / WL4)];

end

