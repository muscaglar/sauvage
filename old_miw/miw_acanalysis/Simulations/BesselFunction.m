function [ AC ] = BesselFunction( Fc, F , n)
%BESSELFUNCTION Summary of this function goes here
%   Detailed explanation goes here

if length(F) == 1
    freq = logspace(0.01,F,40);
else
    freq = F;
end
Wc = 1/ (2 * pi * Fc);
num0 = 1;

den4 = 1 / Wc;
den3 = 10 / Wc;
den2 = 45 / Wc; 
den1 = 105 / Wc;
den0 = 105;

numerator = [num0];
denonminator = [den4 den3 den2 den1 den0];

[ AC ] = ArbitarySimulate(numerator, denonminator, F ,1 );

ACPlot(AC)

end

