function [ IV ] = IVPlotByCapillary(Input, CapOrExp )
   SealedYN = 1; 
   Suppressed = [0 16];
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

for ExperimentID = ExptIDs
    [ IV, ~,~ ] = LoadIVByNo(  ExperimentID );
     IV = IVClean(IV);
     half = size(IV(:,2));
     half = half(1);
     half = round(half / 2);
     
    [ FileName, PathName, Date, No, E, id ] = GetDataByID(ExperimentID);
    CapConc = E.getCapillaryConc();
    ResConc = E.getReservoirConc();
    %go_to_Origin([IV(:,2),IV(:,1)],num2str(ResConc));
    
    figure;
hold on
    
    scatter(IV(:,2),IV(:,1)) 
    
    
        
        %GHK Fittting and plotting
        z = [1 -1];
        V = linspace(1.1*min(IV(:,2)),1.1*max(IV(:,2)),30);

       ConcI = ResConc
       Conc0 = CapConc

        [ Pp, Np, Offset ] = GHK_FitPermeabilityMonoCharge( IV, ConcI, Conc0 );  % Vm
        P = [Pp, Np];
        [ I_Total, I_Components ] = GHK_TotalCurrent( z, V*1e-3 , P, ConcI, Conc0 );


%         plot(IV(:,2),I_Total)
%         plot(IV(:,2),I_Components)
%         
%         Ratios(e,:) = [P Pp/Np Pp/(Np+Pp) GHK_Voltage(z, P, ConcI, Conc0)];
    
end
    xlabel('Voltage (mV)');
    ylabel('Current (nA)');
    title(['IVs ' ExptIDs]);
    hline = refline([0 0]);
    %disp(['No of file plotted = ' num2str(f)]);
hold off;

end

