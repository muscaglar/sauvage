function [ output_args ] = PlotRamanByID( SpectraIDs )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

%this produces a Matlab plot - eg for checking!

%Plot the Raman Spectra - in a number of nice ways - with additional
%information - can you plot to Origin from Matlab??
%Note would prefer if there is also a plotting script in origin, ie that
%plots from the saved values - or push stright into a notebook
hold off;
Set = 0;
for Sid = SpectraIDs
    Set = Set +1;
   [ Spectra, Details, FileName, PathName, SpectraDate, SpectraNo, TraceObj ] = SpectraLoadByID( Sid );
   
   plot(Spectra(:,1),Spectra(:,2), ColourWheel(Set));
   hold on;
end


end


