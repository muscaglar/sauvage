function [ output_spectra ] = SmartPeakRemoval( input_spectra )
%Smart Peak Removal   - mask out the peaks from a spectra
%   For a given spectra  - which may already be filtered  - though could
%   add into here find the peaks and mask them out  - remove them from the
%   output spectra to leave just regions with no peaks for fitting to
%   Input is a 2 column matrix. Fist column is wavelength second is counts

Ydiff = diff(input_spectra(:,2));
Ydiff2 = diff(Ydiff);

l = length(Ydiff);
hold on
%plot(input_spectra(1:length(Ydiff),1),Ydiff,'c');
%plot(input_spectra(1:length(Ydiff2),1),Ydiff2,'k');

Diff_mean = mean(Ydiff);
Diff_std = std(Ydiff);

%if the std is very small then it implies there are no peaks so don't try
%to do anything
if(Diff_std > 10)
    ThresholdedDiff = Threshold(Ydiff, Diff_mean+1.5*Diff_std, 2);
    %plot(input_spectra(1:length(Ydiff),1),ThresholdedDiff,'r');

    %%output_spectra = zeros(l,2); %Cannot preinitialise as you don't know
    %%what length it will be
    PeakFlag = 0;
    Output_i = 1;
    for i = 1:l
        %Now go though and decide what to do at each point
        %Simplest is after a positive section stop copying values until
        %your reach a negative region of the thresholded signal
        if PeakFlag == 0  && ThresholdedDiff(i) == 0
            output_spectra(Output_i,:) = input_spectra(i,:);
            Output_i = Output_i+1;
        elseif PeakFlag == 0 && ThresholdedDiff(i) > 0
            PeakFlag = 1;
        elseif PeakFlag == 1 && ThresholdedDiff(i) < 0
            PeakFlag = 0;
        end 
        
    end
    
else
    output_spectra = input_spectra;
end


end

