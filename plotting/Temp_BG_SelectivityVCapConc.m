
function [newCapConcs,newSelectivities] = Temp_BG_SelectivityVCapConc(CapIDs, titles, plot)

Selectivities = zeros(2,3);
CapillaryConcs = zeros(1,3);

newCapConcs = zeros(1,3);
newSelectivities = zeros(2,3);

i = 1;

% BG_KCL_0_01M = [514, 516, 517];
% 
% BG_KCL_0_1M = [459, 460, 502:503]; %504 is bad
% 
% BG_KCL_1M = [457,458, 497:501]; %495, 496 are bad
% 
% BG_KCL_2M = [523, 539, 540, 543, 544];

for CapID = CapIDs
    [VoltageGradient, CurrentGradient, VOffset, IOffset, ResConcs,CapConcs, VoltageOffsets, CurrentOffsets, No ] = Selectivity(CapID);
    
    if CapID == 514 || CapID == 516 || CapID == 517
        CapConcs(1) = 0.01;
    elseif CapID == 459 || CapID == 460 || CapID == 502 || CapID == 503
        CapConcs(1) = 0.1;
    elseif CapID == 457 || CapID == 458 || CapID == 498 || CapID == 499 || CapID == 500 || CapID == 501
        CapConcs(1) = 1;
    elseif CapID == 523 ||CapID ==  539 || CapID == 540 || CapID == 543 || CapID == 544
        CapConcs(1) = 2;
    end
    
    Selectivities(1,i) = VoltageGradient(1);
    Selectivities(2,i) = VoltageGradient(2);
    CapillaryConcs(i) = CapConcs(1);
    i=i+1;
end

u=1; a=1; b=1; c=1; d=1; e=1; f=1;

for CapConc = CapillaryConcs
    if(CapConc == 3)
        Cap3(a) = u;
        a=a+1;
    end
    if(CapConc == 2)
        Cap2(b) = u;
        b=b+1;
    end
    if(CapConc == 1)
        Cap1(c) = u;
        c=c+1;
    end
    if(CapConc == 0.1)
        Cap01(d) = u;
        d=d+1;
    end
    if(CapConc == 0.01)
        Cap001(e) = u;
        e=e+1;
    end
    if(CapConc == 0.001)
        Cap0001(f) = u;
        f=f+1;
    end
    u = u+1;
end

h=1;

if ( exist('Cap3'))
    newSelectivities(1,h) = mean(Selectivities(1,Cap3));
    newSelectivities(2,h) = mean(Selectivities(2,Cap3));
    newCapConcs(h) = 3; 
    h=h+1;
end
if ( exist('Cap2'))
    newSelectivities(1,h) = mean(Selectivities(1,Cap2));
    newSelectivities(2,h) = mean(Selectivities(2,Cap2));
    newCapConcs(h) = 2; 
    h=h+1;
end
if ( exist('Cap1'))
    newSelectivities(1,h) = mean(Selectivities(1,Cap1));
    newSelectivities(2,h) = mean(Selectivities(2,Cap1));
    newCapConcs(h) = 1; 
    h=h+1;
end
if ( exist('Cap01'))
    newSelectivities(1,h) = mean(Selectivities(1,Cap01));
    newSelectivities(2,h) = mean(Selectivities(2,Cap01));
    newCapConcs(h) = 0.1; 
    h=h+1;
end
if ( exist('Cap001'))
    newSelectivities(1,h) = mean(Selectivities(1,Cap001));
    newSelectivities(2,h) = mean(Selectivities(2,Cap001));
    newCapConcs(h) = 0.01; 
    h=h+1;
end
if ( exist('Cap0001'))
    newSelectivities(1,h) = mean(Selectivities(1,Cap0001));
    newSelectivities(2,h) = mean(Selectivities(2,Cap0001));
    newCapConcs(h) = 0.001; 
    h=h+1;
end

close all;

if (plot =='Matlab')
figure
hold on
bar(log10(newCapConcs),newSelectivities(1,:))
errorbar(log10(newCapConcs),newSelectivities(1,:),newSelectivities(2,:),'.')
set(gca, 'XTick', log10(sort(newCapConcs)))
set(gca, 'XTickLabel', sort(newCapConcs))
ylabel('Selectivity mV/log(M)')
xlabel('Capillary Concentration (M)')
title(titles);
end

if(plot == 'Origin')
    %Plot in Origin
    ORG = Matlab2OriginPlot();
    PlotName = 'Selctivity Versus Reservoir Concentration' ;
    %Plot the points for offset
    ORG.Figure([PlotName]);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ORG.Need to set scaling to 0
    ORG.HoldOn;
    %ORG.PlotColumn(newCapConcs,newSelectivities(1,:),PlotName,'Pink');
    %ORG.ExecuteLabTalk('set %C -vg 80' ); %Sets the gap between columns
    ORG.PlotColumnError(newCapConcs,newSelectivities(1,:),newSelectivities(2,:),PlotName,'Purple');
    ORG.logXScale
    ORG.xlabel('Reservoir Concentration','M');
    ORG.ylabel('Selectivity','mV/log(M)');
%    ORG.yComment(MembraneName);
    ORG.title([PlotName]);
    ORG.HideActiveWkBk()
    ORG.Disconnect;
end

end
