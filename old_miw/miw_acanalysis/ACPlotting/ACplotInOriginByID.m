function [ AC, ORG, Date, No, AC_raw, Fc, volts ] = ACplotInOriginByID( ExperiemntIDs, GraphPrefix, plotRaw)
%ACPLOTINORIGINBYID Summary of this function goes here
%   Detailed explanation goes here

ORG = Matlab2OriginPlot();

if nargin < 3
     plotRaw = 0;
if nargin < 2
    GraphPrefix = 'AC';
end
end
ORG.HoldOff;

for ExperimentID = ExperiemntIDs
    %[ AC, Date, No, E ] = ACLoadByID(  ExperimentID );
    [AC , AC_raw, Fc, volts,E] = ACLoadByIDandCorrect( ExperimentID);
    Date = E.getDate;
    No = E.getNo;
   
    
    %Consider if I want to plot them all into the same graph or not?
    if  plotRaw == 1
        LegendInfo = ['raw Eid: ' num2str(ExperimentID) ' ' GetDateString(Date) ' No:' num2str(No) ];
        ORG = ACplotInOrigin( AC_raw, ORG, GraphPrefix, LegendInfo ,1);
    else
         LegendInfo = ['corrected Eid: ' num2str(ExperimentID) ' ' GetDateString(Date) ' No:' num2str(No) ];
        ORG = ACplotInOrigin( AC, ORG, GraphPrefix, LegendInfo ,1);
    end
    
    ORG.HoldOn;  % Turn hold on so it will plot into the correct graph by name

end

end

