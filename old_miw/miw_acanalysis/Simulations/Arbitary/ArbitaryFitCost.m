function [ cost ] = ArbitaryFitCost( numerator , denonminator, AC , Params, volts )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

if nargin < 5
    volts = 10e-3;
end

AC_Simulation =  ArbitarySimulate( numerator , denonminator , AC(:,1) , volts );

cost = ACCost(AC, AC_Simulation);

end

