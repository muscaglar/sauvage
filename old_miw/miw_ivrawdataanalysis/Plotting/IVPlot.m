function [  ] = IVPlot( ExperimentIDs )
%IVPLOT Summary of this function goes here
%   Detailed explanation goes here

hold on
for ExperimentID = ExperimentIDs
    [ IV, ~,~ ] = LoadIVByNo(  ExperimentID );
     IV = IVClean(IV);
    plot(IV(:,2),IV(:,1))
end
    xlabel('Voltage (mV)');
    ylabel('Current (nA)');
    title(['IVs ' ExperimentIDs]);
    %disp(['No of file plotted = ' num2str(f)]);
    hold off;

end

