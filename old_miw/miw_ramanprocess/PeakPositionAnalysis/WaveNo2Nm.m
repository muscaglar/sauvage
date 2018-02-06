function [ Lambda_nm ] = WaveNo2Nm( WaveNo_cm, Excitation )
%WAVENO2NM Summary of this function goes here
%   Detailed explanation goes here

if nargin < 2
    Excitation = 352;
    
end

Lambda_nm = 1 ./ ( 1/Excitation -  WaveNo_cm/1e7);

end

