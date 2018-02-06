function [ ShortSpectra ] = SpectraCrop( FullSpectra, StartValue, EndValue )
%UNTITLED14 Summary of this function goes here
%   Detailed explanation goes here

%Select the spectra based on the start and end values - where these
%correspond to the first column
l = max(size(FullSpectra));
if (FullSpectra(1,1) <= StartValue ) && (FullSpectra(l,1) >= EndValue)

    %Find the index locations (for nearest value)
    s=1;
    e=l;
    for i = 1:l
       if FullSpectra(i,1) > StartValue
           s = i - 1;
           break
       end
    end
    if nargin>2
    for i = l:-1:1
       if FullSpectra(i,1) < EndValue
           e = i+1;
           break
       end
    end
    end

    %Now just transfer this part of the spectra
    ShortSpectra = FullSpectra(s:e,:);
else
   warning('Could not crop spectra');
   ShortSpectra = FullSpectra;
end

end

