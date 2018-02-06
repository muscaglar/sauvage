function [ AC ] = ACSpiceLoad(  )
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here

%read in data exported from 

[FileName, PathName] = uigetfile({'*.txt','All Spectra Files';},'Choose AC Sweep Data', 'C:\Users\miw24\Documents\PhD\Simulations\LTSPice\Results');

ACFile = importdata([PathName FileName]);

%Take off the top bar
data = ACFile(2:end,:);

n = max(size(data));
AC = zeros(n,3);
for i = 1:n
    F = strsplit(data{i});
    D = strsplit(F{2},',');
    %Need to process D into numbers, need to take the values off
    
    I = regexpi(D{1},'[+-]?\d*[.]\d*[e]?[+-]?\d*','match');
    P = regexpi(D{2},'[+-]?\d*[.]\d*[e]?[+-]?\d*','match');
    
    %Now put the values into the AC Matrix
    AC(i,1) = (str2num(F{1}));
    AC(i,2) = (str2num(I{1}));
    AC(i,3) = (str2num(P{1}));
    
end

%NB the amplitude is in DB  - might want to convert it back into raw values
%- with the approproate voltage  - this would be better

CurrentScale = 1e9;
VoltageScale = 1e3;
AC(:,2) = CurrentScale * (10 .^ (AC(:,2) ./ 20));



%Also check if phase is in degrees and if not then deal with it
%approporiately, also if it needs to be shifted to make it with the same
%basis as the analystical simulation

AC(:,3) = AC(:,3) + 180;


end


