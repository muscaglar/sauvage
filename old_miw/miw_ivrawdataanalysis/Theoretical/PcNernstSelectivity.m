function [ PercentMaxSelectivity ] = PcNernstSelectivity( Voffset_mV, Conc1, Conc2 )
%PCNERNSTSELECTIVITY Summary of this function goes here
%   Detailed explanation goes here

PercentMaxSelectivity = Voffset_mV ./ NernstPotential( Conc1, Conc2 );

end

