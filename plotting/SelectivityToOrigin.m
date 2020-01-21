% Altering Micheal Walker's code to take a vector of capillaries and plot
% them 

%Things to fix:

    % Plot names are all different (by exp.) thus doesnt plot to the same
    % two plots
    
    %The ResConcs doesnt work -> need num2str?
    
function [  ] = SelectivityToOrigin(Capillary, ResConcs, VoltageOffsets, CurrentOffsets, XValues)
%Plot Selecitivty Data into Origin.

for CapillaryIDs = Capillary(:).'
    
    MembraneName = '';
    PlotName = ['C' num2str(CapillaryIDs(1))];
    if(nargin > 3)
        PlotName = CurrentOffsets;
        if nargin > 4 && ischar(XValues)
            MembraneName = XValues;
            CalcXValues = 1;
        else
            CalcXValues = 0;
        end
    else
        %PlotName = '';
    end
    
   [ ResConcs,CapConcs,VoltageOffsets,CurrentOffsets,std_VoltageOffsets, std_CurrentOffsets,VoltageGradient, CurrentGradient] = ca_selectivity_alteredError(CapIDs,origin,varargin)%plot,custom_min,custom_max)

    %NB use the first 2 arguments as max and min
    if nargin == 5 && isnumeric(XValues); 
        [ ~, ~, ~, ~, ResConcs,CapConcs, VoltageOffsets, CurrentOffsets, No ] = Selectivity( CapillaryIDs, ResConcs, VoltageOffsets, XValues );
    elseif nargin >= 3
        [ ~, ~, ~, ~, ResConcs,CapConcs, VoltageOffsets, CurrentOffsets, No ] = Selectivity( CapillaryIDs, ResConcs, VoltageOffsets );
    elseif nargin == 1
        [ ~, ~, ~, ~, ResConcs,CapConcs, VoltageOffsets, CurrentOffsets, No ] = Selectivity( CapillaryIDs );
    end

if nargin < 5 || CalcXValues == 1;
    XValues = unique(ResConcs);
end
if No > 1
    % Can process the data again
    [ XV ] = YMeans_Error(XValues, ResConcs, VoltageOffsets);
    %Or for Currents
    [ XI ] = YMeans_Error(XValues, ResConcs, CurrentOffsets );
    
    % Redo the line fit for the data which has been passed in
    [ TotalVGrad, StdVErrors, VOffsetFitted, r2] = LineFit( log10(ResConcs), VoltageOffsets, log10(XValues));
    [ TotalIGrad, StdIErrors, IOffsetFitted, r2] = LineFit( log10(ResConcs), CurrentOffsets, log10(XValues));
    
    
    %--------------------------------------------------------------------------
    %Plot in Origin
    ORG = Matlab2OriginPlot();
    
    %Plot the points for offset
    ORG.Figure([PlotName 'VoltageOffsets']);
    ORG.HoldOn;
    ORG.PlotScatter(ResConcs, VoltageOffsets,[PlotName '_VPoints'],'LT Magenta');
    ORG.logXScale
    ORG.xlabel('Concentration','M');
    ORG.ylabel('Voltage Offset','mV');
    ORG.yComment(MembraneName);
    ORG.title([PlotName '_VoltageOffsets']);
    %ORG.AddText('Created using MikesOriginPlot library');
    ORG.HideActiveWkBk()
    
    %Plot the fit to the points
    ORG.HoldOn;
    ORG.PlotLine(XValues,VOffsetFitted,[PlotName '_VFit'],'red');
    ORG.xlabel('Concentration','M');
    ORG.ylabel('Voltage Offset','mV');
    ORG.AddText(['Gradient is ' num2str(TotalVGrad(1)) '+/- ' num2str(StdVErrors(1))]);
    ORG.yComment(['Fit to' MembraneName 'Grad:' num2str(TotalVGrad(1),3) '+/- ' num2str(StdVErrors(1),3)]);
    ORG.HideActiveWkBk()
    
    %Plot the Mean and Error at each pH - note might want to transfer all
    %values, as it also have info on distribution
    ORG.PlotScatterError(XV(:,1)',XV(:,2)',XV(:,3)', [PlotName '_VMeanStd'],'red');
    ORG.xlabel('Concentration','M');
    ORG.ylabel('Voltage Offset','mV');
    ORG.yComment(MembraneName);
    ORG.HideActiveWkBk()
    
    %ORG.HoldOff;
    %------------------------------------------
    %Now plot the current data
    
    %Plot the points for offset
    ORG.Figure([PlotName 'CurrentOffsets']);
    ORG.PlotScatter(ResConcs, CurrentOffsets,[PlotName '_IPoints'],'LT Cyan');
    ORG.logXScale
    ORG.xlabel('Concentration','M');
    ORG.ylabel('Current','nA');
    ORG.yComment(CapConcs);
    ORG.title([PlotName '_CurrentOffsets']);
    %ORG.AddText('Created using MikesOriginPlot library');
    ORG.HideActiveWkBk()
    
    %Plot the fit to the points
    ORG.HoldOn;
    ORG.PlotLine(XValues,IOffsetFitted,[PlotName '_IFit'],'blue');
    ORG.AddText(['Gradient is ' num2str(TotalIGrad(1)) '+/- ' num2str(StdIErrors(1))]);
    ORG.xlabel('Concentration','M');
    ORG.ylabel('Current','nA');
    ORG.yComment(['Fit to' CapConcs 'Grad:' num2str(TotalIGrad(1),3) '+/- ' num2str(StdIErrors(1),3)]);
    ORG.HideActiveWkBk()
    
    %Plot the Mean and Error at each pH - note might want to transfer all
    %values, as it also have info on distribution
    ORG.PlotScatterError(XI(:,1)',XI(:,2)',XI(:,3)', [PlotName '_IMeanStd'],'blue')
    ORG.xlabel('Concentration','M');
    ORG.ylabel('Current','nA');
    ORG.yComment(CapConcs);
    ORG.HideActiveWkBk()
    
    %ORG.HoldOff;
    ORG.Disconnect();
else
    disp('No Selectivity data for these capillaries so not plotted');
end
end
end

