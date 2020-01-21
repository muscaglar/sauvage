function [aResConcs,aCapConcs, aVoltageOffsets, aCurrentOffsets, allCaps] = retired_Averaged_CorrectedSelectivity(CapID)
%[VoltageGradient, CurrentGradient, VOffset, IOffset, ResConcs,CapConcs, VoltageOffsets, CurrentOffsets, No, allCaps ] = Averaged_CorrectedSelectivity(CapID)

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

% for CapID = CapIDs
[VoltageGradient, CurrentGradient, VOffset, IOffset, ResConcs,CapConcs, VoltageOffsets, CurrentOffsets, No ] = Selectivity(CapID);

NaN_index = isnan(VoltageOffsets);

test = zeros(1,size(ResConcs,2));
test = test + CapID;
allCaps = [allCaps, test];

ResConcs(NaN_index) = [];
CapConcs(NaN_index) = [];
VoltageOffsets(NaN_index) = [];

% In the case where there is only two combinations of data, the output
% seems to be null.

vOffset = mean(VoltageOffsets(ResConcs==CapConcs));
iOffset = mean(CurrentOffsets(ResConcs==CapConcs));

VoltageOffsets = VoltageOffsets - vOffset;
CurrentOffsets = CurrentOffsets - iOffset;

unique_rConc = unique(ResConcs);
unique_cConc = unique(CapConcs);

for i = 1:size(unique_rConc,2)
    index_rConc = ResConcs == unique_rConc(i);  
    aVoltageOffsets(i) = mean(VoltageOffsets(index_rConc),2);
    aCurrentOffsets(i) = mean(CurrentOffsets(index_rConc),2);
    aCapConcs(i) = mean(CapConcs(index_rConc),2);
    aResConcs(i) = unique_rConc(i);
end


% aResConcs = [aResConcs, ResConcs];
% aCapConcs = [aCapConcs, CapConcs];
% aVoltageOffsets = [aVoltageOffsets, VoltageOffsets];
% aCurrentOffsets = [aCurrentOffsets, CurrentOffsets];
% end


close all;
Xrange = [0.00001,1000];
[VoltageGradient, CurrentGradient, VOffset, IOffset, XV, XI ] = SelectivityFromValues(aResConcs,aCapConcs, aVoltageOffsets, aCurrentOffsets, Xrange, CapID );



end
