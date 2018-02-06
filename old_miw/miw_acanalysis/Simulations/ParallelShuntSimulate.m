function [ AC ] = ParallelShuntSimulate( R, C, Rs, F )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

volts = 10e-3;

freq = linspace(10,F,20);
W = 2 * pi * freq;

Xc = -1 ./ (C .* W);

%Do Current amplitude
r2 = R^2 + Xc.^2 + Rs.^2  + ( (2 .* R .* Xc.^2 .* Rs) / (R^2 + Xc.^2) ) ;
I2 = volts^2 ./ r2;
I = I2 .^ 0.5;

%Calc phases
theta = -1 * atan( (R^2 .* Xc) ./ ( Rs*(R^2 + Xc.^2) + (R .* Xc.^2) ) );

%Put into the output code
AC(:,1) = freq;
AC(:,2) = I * 1e9;
AC(:,3) =  theta .* 180 ./ pi;

end

