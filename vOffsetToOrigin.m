function [aZVol,aYRes,aCaps,aXCap] = vOffsetToOrigin(CapIDs, correct)
%Plot VOffset against the cCap for ONE cReservoir

yRes = [];
xCap = [];
zVol = [];
Caps = [];
    aCaps = [];
    aYRes = [];
    aZVol = [];
    aXCap = [];
plot = 0;

ORG = Matlab2OriginPlot();

for CapID = CapIDs
    if(correct == 1)
    [VoltageGradient, CurrentGradient, VOffset, IOffset, ResConcs,CapConcs, VoltageOffsets, CurrentOffsets, No, allCaps ] = CorrectedSelectivity(CapID);    
        else
    [VoltageGradient, CurrentGradient, VOffset, IOffset, ResConcs,CapConcs, VoltageOffsets, CurrentOffsets, No] = Selectivity(CapID);
    %allCaps = CapID;
    end
    
    NaN_index = isnan(VoltageOffsets);
    
    ResConcs(NaN_index) = [];
    CapConcs(NaN_index) = [];
    VoltageOffsets(NaN_index) = [];
    
    yRes = [yRes, ResConcs];
    xCap = [xCap, CapConcs];
    zVol = [zVol, VoltageOffsets];
    %Caps = [Caps, allCaps];
    Caps = [Caps, CapID];
    close all;
    
    uRess = unique(ResConcs);
%     aY = [];
%     aZ = [];
    for uRes =  uRess
       uIndex =  find(ResConcs==uRes);
       aZVol = [aZVol, mean(zVol(uIndex))];
       aYRes = [aYRes, uRes];
       aCaps = [aCaps, CapID];
       aXCap = [aXCap, mean(CapConcs(uIndex))];
    end   
    % aX = (zeros(1,size(aZ,2)))+ x(1);
  
    % aXY = aY ./ aX; % This is the relative concentration

    if plot == 1
        ORG.PlotScatter(aXY,aZ,'Plot 2');
        ORG.yComment(num2str(CapID));
        ORG.HideActiveWkBk;
        ORG.HoldOn;
    
        %Create a new layer on the plot  - with x linked
        ORG.NewLayer(1,1);
    end
end
   
allData = [aCaps' aXCap' aYRes' aZVol'];
ORG.MatrixToOrigin(allData, 'Corrected, Averaged Data');
ORG.Disconnect;

end
