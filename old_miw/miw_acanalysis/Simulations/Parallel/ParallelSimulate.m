function [ AC ] = ParallelSimulate( R, C, F, volts )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
if nargin < 4
    volts = 10e-3;
end
if length(F) == 1
    freq = linspace(0,F,40);
else
    freq = F;
end
W = 2 * pi * freq;

Xc = -1 ./ (C .* W);

%Do Current amplitude
%I2 = volts^2 .* ( (R^2 + Xc.^2) ./ ((R^2) * (Xc.^2) ) );
I2 = volts^2 .* ( (1/R) ^2 + (C .* W).^2 );
I = I2 .^ 0.5;

%Calc phases
theta = atan(R ./ Xc);

%Put into the output code
AC(:,1) = freq;
AC(:,2) = I * 1e9;
AC(:,3) = -1 * theta .* 180 ./ pi;

end

