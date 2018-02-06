function [ AC ] = MembraneAndCapillaryAndReservoirSimulate(  Rm, Cm, Rc, Cc, Rr, Cr, F, volts  )
%MEMBRANEANDCAPILLARYSIMULATE Summary of this function goes here
%   Detailed explanation goes here

if nargin < 6
    volts = 10e-3;
end

num2 = Rm * Rr * Cr * Cm;
num1 = Rm * Cm + Rr * Cr;
num0 = 1;

den3 = Rm * Rr * Rc * Cc * Cr; 
den2 = Cc * Rm * Cm * (Rr + Rc) + Rr * Cr * Cc * (Rm + Rc);
den1 = Cc * (Rm + Rr + Rc);
den0 = 1;


numerator = [num2 num1 num0];
denonminator = [den3 den2 den1 den0];

% note pass in the wrong way round as need to pass in the transfer
% function for current from voltage
[ AC ] = ArbitarySimulate( denonminator,numerator,  F, volts );

end