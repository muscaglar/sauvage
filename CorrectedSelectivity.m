function [VoltageGradient, CurrentGradient, VOffset, IOffset, ResConcs,CapConcs, VoltageOffsets, CurrentOffsets, No, allCaps ] = CorrectedSelectivity(CapIDs)

cID = [];
cConc = [];
vOffset = [];
iOffset = [];
allCaps = [];
count = 1;


aResConcs = [];
aCapConcs = []; 
aVoltageOffsets = []; 
aCurrentOffsets = [];

for CapID = CapIDs
    [VoltageGradient, CurrentGradient, VOffset, IOffset, ResConcs,CapConcs, VoltageOffsets, CurrentOffsets, No ] = Selectivity(CapID);  
    
    NaN_index = isnan(VoltageOffsets);

   
    ResConcs(NaN_index) = [];
    CapConcs(NaN_index) = [];
    VoltageOffsets(NaN_index) = [];
    
    % In the case where there is only two combinations of data, the output
    % seems to be null. 
    
    vOffset = mean(VoltageOffsets(ResConcs==CapConcs));
    iOffset = mean(CurrentOffsets(ResConcs==CapConcs));
    
    VoltageOffsets = VoltageOffsets - vOffset;
    CurrentOffsets = CurrentOffsets - iOffset;
    
     aResConcs = [aResConcs, ResConcs];
     aCapConcs = [aCapConcs, CapConcs];
     aVoltageOffsets = [aVoltageOffsets, VoltageOffsets];
     aCurrentOffsets = [aCurrentOffsets, CurrentOffsets];
end


close all;
Xrange = [0.00001,1000];
[VoltageGradient, CurrentGradient, VOffset, IOffset, XV, XI ] = SelectivityFromValues(aResConcs,aCapConcs, aVoltageOffsets, aCurrentOffsets, Xrange, CapID );

    
    
end
