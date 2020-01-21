function [ Voltage_mV ] = NernstPotential( Conc1, Conc2 )
%NERNSTPOTENTIAL Calculate the nernst potential
%   http://en.wikipedia.org/wiki/Nernst_equation
PhysicalConsts
z = 1;
Voltage = 2.3026 * R_Const * (T_Const / (z * F_Const)) .* log10((Conc1 ./ Conc2));

Voltage_mV = Voltage * 1000;

end