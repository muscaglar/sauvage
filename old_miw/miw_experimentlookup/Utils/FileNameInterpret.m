
function [ date, no, details, ext] = FileNameInterpret( FileName )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
F = strsplit(FileName, '.');
ext = F{2};
C = strsplit(F{1}, '_');

date = str2num(C{1});
%Check the 2nd entry is there
if(max(size(C)) > 1)
no = str2num(C{2});
else
    no = 0;
end
%Check the 3rd entry is there
if(max(size(C)) > 2)
    details = (C{3});
else
    details = 'unknown';
end
end

