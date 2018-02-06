function [ OuputSpectra , offsetOut] = SpectraOffsetCorrect( inputSpectra, offset )
%Shifts a spectra up or down  - if there is no input arguments then it
%ensures the spectra's minimum is at 0 or greater
%   

if nargin < 2
   if(min(inputSpectra) < 0)
      offset = -1 * min(inputSpectra);
   else
       offset = 0;
   end
end
offsetOut = offset;
OuputSpectra = inputSpectra + offset;

end

