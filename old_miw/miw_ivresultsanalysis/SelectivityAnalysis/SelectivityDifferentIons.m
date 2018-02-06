function [ VoltageMeanErrors, CurrentMeanErrors, i,VoltageOffsets, CurrentDensityOffsets,ResSln,CapSln  ] = SelectivityDifferentIons( CapillaryIDs , title )
%SELECTIVITYDIFFERENTIONS 

AllowableSuppressionCodes = [0 16];

%Solutions =

%load all the experiments  - % Can also do read outs here
Expts = [];
ResSln = [];
CapSln = [];
No = 0;
i = 1;
for CapillaryID = CapillaryIDs
    %Load experiments with a vector of supresion codes which will be
    %OR'd
    [Expts_0, No_0] = LoadExperiments( CapillaryID, 1, AllowableSuppressionCodes );
    Expts = [Expts Expts_0];
    
    DB = DBConnection;
    C = Capillaries(DB,CapillaryID );
    [ ~, Area ] = GetCapSize( char(C.getType) );
    Area = 1e12 * Area;  %Convert area to um2
    
    No = No + No_0 ;
    n = length(Expts);
    for j = 1:n
        E = Expts(j);
        %Apply Limits
        %should check that capillary and reservoir have the same
        %concentration
        if E.getVoffset ~= 0
            VoltageOffsets(i) = E.getVoffset();% - Offsets(j);
        else
            VoltageOffsets(i) = nan;
        end
        if E.getIoffset ~= 0
            %Use current density here to allow comparisons between Nafion
            %and graphene, also allows all bare to be used.
            CurrentDensityOffsets(i) = E.getIoffset() / Area;
        else
            CurrentDensityOffsets(i) = nan;
        end
        
        
        ResConcs(i) = E.getReservoirConc();
        CapConcs(i) = E.getCapillaryConc();
        
        ResSln(i) = SolutionToNumber( E.getReservoirSln );
        CapSln(i) = SolutionToNumber( E.getCapillarySln );
        
        i = i+1;
    end
end
ResConcs = round(ResConcs,6);
CapConcs = round(CapConcs,5);

%Now calc the mean voltage and current offset for each set
XValues = unique(ResSln);
[ VoltageMeanErrors ] = YMeans_Error(XValues, ResSln, VoltageOffsets );
[ CurrentMeanErrors ] = YMeans_Error(XValues, ResSln, CurrentDensityOffsets );

subplot(1,2,1)
hold off
bar(VoltageMeanErrors(:,1),VoltageMeanErrors(:,2))
hold on
errorbar(VoltageMeanErrors(:,1),VoltageMeanErrors(:,2),VoltageMeanErrors(:,3));
subplot(1,2,2)
hold off
bar(CurrentMeanErrors(:,1),CurrentMeanErrors(:,2))
hold on
errorbar(CurrentMeanErrors(:,1),CurrentMeanErrors(:,2),CurrentMeanErrors(:,3));

if nargin > 1
    %plot into Origin
    ORG = Matlab2OriginPlot;
    
    %Plot the voltage offsets
    ORG.PlotColumnError(VoltageMeanErrors(:,1)',VoltageMeanErrors(:,2)',VoltageMeanErrors(:,3)',['V_' title],'red');
    ORG.xAxisAtZero(1)
    ORG.xlabel('Reservoir Solution','');
    ORG.ylabel('Voltage Offset','mV');
    ORG.yComment(['V_' title '_' num2str(CapillaryIDs(1))]);
    ORG.yaxis(-50,50)
    ORG.xAxisPosition();
    ORG.xPosType();
    ORG.ylabelincrement(25);
    ORG.xlabelincrement(1);
    ORG.HideActiveWkBk;
    
    ORG.PlotColumnError(CurrentMeanErrors(:,1)',CurrentMeanErrors(:,2)',CurrentMeanErrors(:,3)',['I_' title],'blue');
    ORG.xAxisAtZero(1)
    ORG.xAxisPosition();
    ORG.xPosType();
    ORG.xlabel('Reservoir Solution','');
    ORG.ylabel('Current Density Offset','nA/um2');
    ORG.yComment(['I_' title '_' num2str(CapillaryIDs(1))]);
    ORG.xlabelincrement(1);
    %ORG.yaxis(start,to)
    ORG.HideActiveWkBk;
    
    
end

end

