function [ output_spectra ] = BaseLineSubtract( input_spectra ,StartIndex, EndIndex )
%BaseLineSubtract Fit and subtract a baseline - also outputs a fine filter
%   Note the start and end index doesn't actually crop the spectra, it just
%   sets the region to which the baseline is fitted, allows you to miss out
%   sections as required  - could make more sophisticated so you can eb
%   more selective and is currently index based, rather than wave number
%   based

%index of the starting location
if nargin > 1
    SpecCrop = input_spectra;
    if nargin < 3
        ToFit_Spectra =  input_spectra(StartIndex:end,:);
    else
        ToFit_Spectra =  input_spectra(StartIndex:EndIndex,:);
    end
else
    ToFit_Spectra = input_spectra;
    SpecCrop = input_spectra;
end
%should low pass filter out the peaks
filteredSpectra = Smooth(ToFit_Spectra(:,2), 20);    %Originally 50 before peak removal


%Call function to try and remove all of the known peaks  - water....
Fit_Spectra = RemoveSpectra(ToFit_Spectra(:,1),filteredSpectra(:));

Fit_Spectra = SmartPeakRemoval(Fit_Spectra);

%try and fit a fucntion to it
p = polyfit(Fit_Spectra(:,1),Fit_Spectra(:,2),3);


%create the baseline values
baseline = polyval(p,SpecCrop(:,1));

%Subtract the function
%perhaps take off the ignored start location
output_spectra(:,1) = SpecCrop(:,1);
output_spectra(:,2) = SpecCrop(:,2);
output_spectra(:,3) = SpecCrop(:,2) - baseline;
output_spectra(:,4) = baseline;
%Create a finner filter which should remove noise without affecting the
%peaks too much
filter_spectra = Smooth(output_spectra(:,3), 5);
output_spectra(:,5) = filter_spectra;


%Nb may wish to ensure the spectra doesn't go below zero.  - DO NOT USE
%IT MESSES UP FITTING
%output_spectra(:,3) = SpectraOffsetCorrect( output_spectra(:,3));

%Nb could also add a normalised spectra - or just normalise the filter
%spectra!

%Plotting ***********************************************
hold on
%Plot the Raw Spectra
plot(input_spectra(:,1),input_spectra(:,2),'b');
%Plot the heavily filterd spectra for fitting
plot(ToFit_Spectra(:,1),filteredSpectra,'r');
%Plot the spectra as used to fit
plot(Fit_Spectra(:,1),Fit_Spectra(:,2),'c+');
%Plot the baseline
plot(SpecCrop(:,1),baseline,'k');

%Plot with base line removes and the fine filter with base line removed
plot(output_spectra(:,1),output_spectra(:,3),'g');
plot(output_spectra(:,1),filter_spectra,'r');
hold off


end

