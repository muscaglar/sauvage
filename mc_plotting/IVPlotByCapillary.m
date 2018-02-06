function [ output_args ] = IVPlotByCapillary(Input, CapOrExp )
   SealedYN = 1; 
   Suppressed = 0;
   temp_ExptIDs = [];
   
   if (CapOrExp == 'Cap')
       for input = Input 
       [ ~, ~, ExptIDs  ] = LoadExperiments( input, SealedYN, Suppressed );
       temp_ExptIDs = [temp_ExptIDs ExptIDs];
       end
   else if CapOrExp == 'Exp'
       ExptIDs = Input;
       end
   end
 
   if CapOrExp ==1
      ExptIDs = temp_ExptIDs;
   end
close all;
figure;
hold on
for ExperimentID = ExptIDs
    [ IV, ~,~ ] = LoadIVByNo(  ExperimentID );
     IV = IVClean(IV);
     half = size(IV(:,2));
     half = half(1);
     half = round(half / 2);
    plot(IV(:,2),IV(:,1))
    [ FileName, PathName, Date, No, E, id ] = GetDataByID(ExperimentID);
    CapConc = E.getCapillaryConc();
    ResConc = E.getReservoirConc();
    txt1 = ['\leftarrow Res =', num2str(ResConc)]; %Cap =', num2str(CapConc),'
    text(IV(half,2),IV(half,1),txt1);
end
    xlabel('Voltage (mV)');
    ylabel('Current (nA)');
    title(['IVs ' ExptIDs]);
    hline = refline([0 0]);
    %disp(['No of file plotted = ' num2str(f)]);
hold off;

end

