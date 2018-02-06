function [ WaveNo_cm ] = CalcWaveNo( Lambda_nm, Excitation )
%WAVENO2NM Summary of this function goes here
%   Detailed explanation goes here

if nargin < 2
    Excitation = 352;
end

 WaveNo_cm  = (1/Excitation - 1/Lambda_nm) * 1e7;

end
