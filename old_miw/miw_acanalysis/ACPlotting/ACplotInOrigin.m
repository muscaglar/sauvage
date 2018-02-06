function [ ORG ] = ACplotInOrigin( AC,ORG, GraphPrefix, LegendInfo , Scatter)
%UNTITLED Plot AC data into Oigin - will plot into two graphs
if nargin < 5
if nargin < 4
    if nargin < 3
        GraphPrefix = '';
        if nargin < 2
            ORG = Matlab2OriginPlot;
        end
    end
    LegendInfo = GraphPrefix;
end
    Scatter = 0;
end
%Plot Magnitude  - nb could scale by the applied voltage - as would be most
%correct!
if Scatter == 0
    ORG.PlotLine(AC(:,1)',AC(:,2)',['M_' GraphPrefix], ORG.ColourPicker());
else
    ORG.PlotScatter(AC(:,1)',AC(:,2)',['M_' GraphPrefix], ORG.ColourPicker());
end
    ORG.ylabel('Current Amplitude','nA');
    ORG.xlabel('Frequency','Hz');
    ORG.yComment([LegendInfo ' Magnitude']); %Put details of reservoir Conc
    ORG.logXScale();
    ORG.logYScale();   %Nb could change to actually plot decibles somehow
    ORG.HideActiveWkBk();

%plot Phase
if Scatter == 0
    ORG.PlotLine(AC(:,1)',AC(:,3)',['P_' GraphPrefix], ORG.ColourPicker());
else
    ORG.PlotScatter(AC(:,1)',AC(:,3)',['P_' GraphPrefix], ORG.ColourPicker());
end
    ORG.ylabel('Phase','Degrees');
    ORG.xlabel('Frequency','Hz');
    ORG.yComment([LegendInfo ' Phase']); %Put details of reservoir Conc
    ORG.logXScale;
    ORG.HideActiveWkBk();

end

