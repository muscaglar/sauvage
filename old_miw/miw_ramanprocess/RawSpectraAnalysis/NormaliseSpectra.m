function [ output_spectra ] = NormaliseSpectra( input_spectra, OutputRange )
%UNTITLED2 Summary of this function goes here
%   Normalise a spectra to fit between the values in the vector OutputRange

if nargin < 2 
    OutputRange = [0 1];
end

%Get the spectra between 0 and 1
a = input_spectra - min(input_spectra);
b = a /(max(a));

c = (OutputRange(2) - OutputRange(1) ) * b;

d = c + OutputRange(1);
output_spectra = d;

end

