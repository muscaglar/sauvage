function [ Spectra, Details, FileName, PathName, SpectraDate, SpectraNo, TraceObj ] = SpectraLoadByID( S )
%SPECTRALOADBYID Summary of this function goes here
%   Detailed explanation goes here

[ FileName, PathName, SpectraDate, SpectraNo, TraceObj ] = GetSpectraPathByID( S );
[ Spectra, Details, ~,~ ] = GRamanSpectraLoad( FileName, PathName );

end

