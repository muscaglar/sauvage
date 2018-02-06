function [ AC ] = MembraneAndCapillarySimulate(  Rm, Cm, Rc, Cc, F, volts  )
%MEMBRANEANDCAPILLARYSIMULATE Summary of this function goes here
%   Detailed explanation goes here

if nargin < 6
    volts = 10e-3;
end

num1 = Cm * Rm * Rc;
num0 = Rc + Rm;

den2 = Cc * Cm * Rm * Rc; 
den1 = Rc * Cc + Cc*Rm + Cm * Rm;
den0 = 1;


numerator = [num1 num0];
denonminator = [den2 den1 den0];

% note pass in the wrong way round as need to pass in the transfer
% function for current from voltage
[ AC ] = ArbitarySimulate( denonminator,numerator,  F, volts );

end