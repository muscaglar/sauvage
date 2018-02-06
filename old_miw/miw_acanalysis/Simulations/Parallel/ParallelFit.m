function [ R, C, AC_Fitted , r2 ] = ParallelFit( AC , volts )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

if nargin < 4
    volts = 10e-3;
end

%%%%%%% PARALLEL Circuit Model
Params0 = [2e6 2e-12];
%Params0 = zeros(1,2);
ParamFinal = fminsearch(@(Params0) ParallelFitCost( AC , Params0 , volts), Params0);

%Take positive value - as the cost function does this as well
R = abs(ParamFinal(1));
C = abs(ParamFinal(2));
[ AC_Fitted ] = ParallelSimulate( R, C, AC(:,1), volts );

r2 = CalcR2( AC(:,2), AC_Fitted(:,2) );

end

