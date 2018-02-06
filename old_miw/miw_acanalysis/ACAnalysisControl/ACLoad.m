function [ AC ] = ACLoad(PathName, FileName  )
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here
FileRoots;
if nargin < 2
    if exist(DataRootHDD)
        [FileName, PathName] = uigetfile({'*.txt','All Spectra Files';},'Choose AC Sweep Data', 'D:\PhDData1\Data');
    else
        [FileName, PathName] = uigetfile({'*.txt','All Spectra Files';},'Choose AC Sweep Data', 'C:\Users\miw24\Documents\PhDData\Data');
    end
end
ACFile = importdata([PathName FileName]);
AC = ACFile.data;
ACDetails = ACFile.textdata;

AC(:,3) = abs(-1 *  AC(:,3));


end

