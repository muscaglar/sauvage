function [] = IVGHK_toOriginPlot(current,P,PlotName)

    ORG = Matlab2OriginPlot();

    ORG.Figure(PlotName);
    ORG.HoldOn;
    ORG.PlotScatterError(current(:,2)', current(:,1)',current(:,3)', PlotName,'black');
    ORG.xlabel('Voltage','mV');
    ORG.ylabel('Current','nA');
    ORG.title(PlotName);
    ORG.HideActiveWkBk()
    
    ORG.PlotLine(current(:,4)',current(:,7)','total','green');
    ORG.ylabel('Total','nA');
    ORG.AddText(['P is ' num2str(P(1)) ', ' num2str(P(2)) ', '  num2str(P(3))]);
    ORG.HideActiveWkBk()
    
    ORG.PlotLine(current(:,4)',current(:,5)','cation','blue');
    ORG.ylabel('cation','nA');
    ORG.HideActiveWkBk()
    
    ORG.PlotLine(current(:,4)',current(:,6)','anion','red');
    ORG.ylabel('anion','nA');
    ORG.HideActiveWkBk()
    
    ORG.HoldOff;
    
    ORG.Disconnect;
end