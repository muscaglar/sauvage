
function [TotalVGrad,StdVErrors,TotalIGrad,StdIErrors] = SelectivityToOrigin_averaged(Capillary,MembraneName,PlotName)
%Plot Selecitivty Data into Origin.

    [ResConcs,CapConcs,VoltageOffsets,CurrentOffsets,std_mean_error_V, std_mean_error_I,VoltageGradient, CurrentGradient] = ca_selectivity_alteredError(Capillary,1,1);

if nargin < 5 || CalcXValues == 1
    XValues = unique(ResConcs);
end

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
    ORG.PlotScatterError(ResConcs,VoltageOffsets,std_mean_error_V, [PlotName '_VMeanStd'],'red');
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
    ORG.PlotScatterError(ResConcs,CurrentOffsets,std_mean_error_I, [PlotName '_IMeanStd'],'blue')
    ORG.xlabel('Concentration','M');
    ORG.ylabel('Current','nA');
    ORG.yComment(CapConcs);
    ORG.HideActiveWkBk()
    
    %ORG.HoldOff;
    ORG.Disconnect();


end

