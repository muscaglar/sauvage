function [ ] = SelectivityExtractToExcel(Capillary, ResConcs, VoltageOffsets, CurrentOffsets, XValues)
%Plot Selecitivty Data into Origin.
%Capillary can either be a capillary type or the name of the plot if
%passing in Agregate Data

if strcmp(class(Capillary), 'Capillaries')
    D = GetNumericDate(Capillary.getDate());
    DateStr = GetDateString(D);
    MembraneName = '';
    PlotName = [DateStr '_' num2str(Capillary.getCapNo())];  %What if its multiple capillaries
    CapillaryIDs = C.getid();
elseif (isnumeric(Capillary))
    CapillaryIDs = Capillary;
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
else
    PlotName = Capillary;
    MembraneName = Capillary;
    CapillaryIDs = 0;
end

%If args not present then run Selectivity analysis to load data - currently takes a given set
%of data points  - but could just take the Expts and then run the full
%selectivity analysis - or even be given a capillary! - then a single
%command would do analysis and plotting - hard to decide where to draw the
%line - for each type of analysis
% - yes want it to take a vector of points - then I can use it over a
% single or multiple capillaries!  - but could still have it load these!
if (isnumeric(Capillary))
    %NB use the first 2 arguments as max and min
    if nargin == 5 && isnumeric(XValues); 
        [ ~, ~, ~, ~, ResConcs,CapConcs, VoltageOffsets, CurrentOffsets, No ] = Selectivity( CapillaryIDs, ResConcs, VoltageOffsets, XValues );
    elseif nargin >= 3
        [ ~, ~, ~, ~, ResConcs,CapConcs, VoltageOffsets, CurrentOffsets, No ] = Selectivity( CapillaryIDs, ResConcs, VoltageOffsets );
    elseif nargin == 1
        [ ~, ~, ~, ~, ResConcs,CapConcs, VoltageOffsets, CurrentOffsets, No ] = Selectivity( CapillaryIDs );
    end
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
    %Construct Array
    
    X = {'Concentration','Voltage Offset','Current Offset'};
   % X = {'Concentration','Voltage Offset','Fit Voltage Offset','Mean STD Voltage Offset','Current Offset','Fit Current Offset','Mean STD Current Offset'};
   % Y = {ResConcs,VoltageOffsets,VOffsetFitted,CurrentOffsets,IOffsetFitted };
    Y = [ResConcs'  VoltageOffsets'  CurrentOffsets'];
   
    Z = [ X Y];
    
    xlwrite_mac('mat1_excel.xls',Y);
    
%     %Plot the points for offset
%     ORG.Figure([PlotName 'VoltageOffsets']);
%     ORG.HoldOn;
%     ORG.PlotScatter(ResConcs, VoltageOffsets,[PlotName '_VPoints'],'LT Magenta');
%     ORG.logXScale
%     ORG.xlabel('Concentration','M');
%     ORG.ylabel('Voltage Offset','mV');
%     ORG.yComment(MembraneName);
%     ORG.title([PlotName '_VoltageOffsets']);
%     %ORG.AddText('Created using MikesOriginPlot library');
%     ORG.HideActiveWkBk()
%     
%     %Plot the fit to the points
%     ORG.HoldOn;
%     ORG.PlotLine(XValues,VOffsetFitted,[PlotName '_VFit'],'red');
%     ORG.xlabel('Concentration','M');
%     ORG.ylabel('Voltage Offset','mV');
%     ORG.AddText(['Gradient is ' num2str(TotalVGrad(1)) '+/- ' num2str(StdVErrors(1))]);
%     ORG.yComment(['Fit to' MembraneName 'Grad:' num2str(TotalVGrad(1),3) '+/- ' num2str(StdVErrors(1),3)]);
%     ORG.HideActiveWkBk()
%     
%     %Plot the Mean and Error at each pH - note might want to transfer all
%     %values, as it also have info on distribution
%     ORG.PlotScatterError(XV(:,1)',XV(:,2)',XV(:,3)', [PlotName '_VMeanStd'],'red');
%     ORG.xlabel('Concentration','M');
%     ORG.ylabel('Voltage Offset','mV');
%     ORG.yComment(MembraneName);
%     ORG.HideActiveWkBk()
%     
%     %ORG.HoldOff;
%     %------------------------------------------
%     %Now plot the current data
%     
%     %Plot the points for offset
%     ORG.Figure([PlotName 'CurrentOffsets']);
%     ORG.PlotScatter(ResConcs, CurrentOffsets,[PlotName '_IPoints'],'LT Cyan');
%     ORG.logXScale
%     ORG.xlabel('Concentration','M');
%     ORG.ylabel('Current','nA');
%     ORG.yComment(MembraneName);
%     ORG.title([PlotName '_CurrentOffsets']);
%     %ORG.AddText('Created using MikesOriginPlot library');
%     ORG.HideActiveWkBk()
%     
%     %Plot the fit to the points
%     ORG.HoldOn;
%     ORG.PlotLine(XValues,IOffsetFitted,[PlotName '_IFit'],'blue');
%     ORG.AddText(['Gradient is ' num2str(TotalIGrad(1)) '+/- ' num2str(StdIErrors(1))]);
%     ORG.xlabel('Concentration','M');
%     ORG.ylabel('Current','nA');
%     ORG.yComment(['Fit to' MembraneName 'Grad:' num2str(TotalIGrad(1),3) '+/- ' num2str(StdIErrors(1),3)]);
%     ORG.HideActiveWkBk()
%     
%     %Plot the Mean and Error at each pH - note might want to transfer all
%     %values, as it also have info on distribution
%     ORG.PlotScatterError(XI(:,1)',XI(:,2)',XI(:,3)', [PlotName '_IMeanStd'],'blue')
%     ORG.xlabel('Concentration','M');
%     ORG.ylabel('Current','nA');
%     ORG.yComment(MembraneName);
%     ORG.HideActiveWkBk()
%     
%     %ORG.HoldOff;
%     ORG.Disconnect();
% else
%     disp('No Selectivity data for these capillaries so not plotted');
% end
end

