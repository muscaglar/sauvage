function [ Spectra, Details, FileName, PathName ] = GRamanSpectraLoad( FileName, PathName )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

%load a Raman spectra file and put into a matrix - nicly
%Also deal with all the other info which is in the file  - need to
%preserve this
if nargin < 2
    %Could just join but need to set the return values
end
FileRoots;
if nargin < 1
    %uigetfile({'*.txt','All Spectra Files';},'Choose Raman Spectra','C:\Users\miw24\Documents\PhD\Spectra')
    %if exist('D:\PhDData1\Data')
    %    [FileName, PathName] = uigetfile({'*.txt','All Spectra Files';},'Choose Raman Spectra', 'D:\PhDData1\Spectra');
    %else
    [FileName, PathName] = uigetfile({'*.txt','All Spectra Files';},'Choose AC Sweep Data', SpectraRoot);
    %end
end

Sp = importdata([PathName FileName]);
if ~isnumeric(Sp)
    Spectra = Sp.data;
    Details = Sp.textdata;
else
    Spectra = Sp;
    Details = {'None'};
end
%work around added for when the LV save routine creates a blank line at the
%top of spectra files
if(isnan(Spectra(1,1)))
    Spectra = Spectra(2:end,:);
end

end

