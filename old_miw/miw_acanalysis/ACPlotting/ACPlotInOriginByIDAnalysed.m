function [ ORG ] = ACPlotInOriginByIDAnalysed( ExperiemntIDs, GraphPrefix)
%ACPLOTINORIGINBYIDPROCESSED Summary of this function goes here
%   Detailed explanation goes here
ORG = Matlab2OriginPlot();

if nargin < 2
    GraphPrefix = 'AC';
end
ORG.HoldOff;
for ExperimentID = ExperiemntIDs
    [ AC, ORG, Date, No, AC_raw, Fc, volts  ] = ACplotInOriginByID( ExperiemntIDs, GraphPrefix);
    
    %Could also now fit to data and plot to the - either load values and
    %just simulate or load and analyse and plot
    [ R_p, C_p, R_s, C_s, AC_Parallel, AC_Series  ] = ACExperimentAnalyse( AC , volts );

    LegendInfo_Parallel = ['Eid: ' num2str(ExperimentID) ' Par R:' num2str(R_p,3) ' C:' num2str(C_p,3) ];

    LegendInfo_Series = ['Eid: ' num2str(ExperimentID) ' Ser R:' num2str(R_s,3) ' C:' num2str(C_s,3)];

    ORG = ACplotInOrigin( AC_Parallel,ORG, GraphPrefix, LegendInfo_Parallel );
    ORG = ACplotInOrigin( AC_Series,ORG, GraphPrefix, LegendInfo_Series );
    
end
end

