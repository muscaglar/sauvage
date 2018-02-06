






%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% NOT FINISHED
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function [  ] = mc_plot(PlotName,x,y,xfit,yfit, grad,graderror,grad2,graderror2, xlabel, xunit, ylabel, yunit)

%Plot in Origin
    ORG = Matlab2OriginPlot();
    
    %Plot the points for offset
    ORG.Figure([PlotName]);
    ORG.HoldOn;
    ORG.PlotScatter(x, y,[PlotName],'LT Magenta');
    ORG.logXScale
    ORG.xlabel(xlabel,xunit);
    ORG.ylabel(ylabel,yunit);
    %ORG.yComment(MembraneName);
    ORG.title([PlotName]);
    %ORG.AddText('Created using MikesOriginPlot library');
    ORG.HideActiveWkBk()
    
    %Plot the fit to the points
    ORG.HoldOn;
    ORG.PlotLine(xfit,yfit,[PlotName 'Fit'],'red');
    ORG.xlabel(xlabel,xunit);
    ORG.ylabel(ylabel,yunit);
    ORG.AddText(['Gradient is ' num2str(grad) '+/- ' num2str(graderror)]);
    ORG.yComment(['Fit to' MembraneName 'Grad:' num2str(grad2) '+/- ' num2str(graderror2)]);
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

end