function [VoltageGradient, CurrentGradient, VOffset, IOffset, ResConcs,CapConcs, VoltageOffsets, CurrentOffsets, No, allCaps ] = ca_selectivity(CapIDs,varargin)%plot,custom_min,custom_max)

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

maxResConc = 10000000;
minResConc = 0.00000001;

switch nargin
    case 1
        plot = 1;
    case 2
        plot = varargin{1};
    case 4
        plot = varargin{1};
        maxResConc = varargin{3};
        minResConc = varargin{2};
    otherwise
        
end


for CapID = CapIDs
    [VoltageGradient, CurrentGradient, VOffset, IOffset, ResConcs,CapConcs, VoltageOffsets, CurrentOffsets, No ] = o_selectivity(CapID,0,minResConc,maxResConc);
    
    NaN_index_V = isnan(VoltageOffsets);
    NaN_index_I = isnan(CurrentOffsets);
    
    test = zeros(1,size(ResConcs,2));
    test = test + CapID;
    allCaps = [allCaps, test];
    
    ResConcs(NaN_index_V) = [];
    CapConcs(NaN_index_V) = [];
    VoltageOffsets(NaN_index_V) = [];
    CurrentOffsets(NaN_index_V) = [];
    
    %     ResConcs(NaN_index_I) = [];
    %     CapConcs(NaN_index_I) = [];
    %     VoltageOffsets(NaN_index_I) = [];
    %     CurrentOffsets(NaN_index_I) = [];
    
    % In the case where there is only two combinations of data, the output
    % seems to be null.
    
    vOffset = mean(VoltageOffsets(ResConcs==CapConcs));
    iOffset = mean(CurrentOffsets(ResConcs==CapConcs));
    
    VoltageOffsets = VoltageOffsets - vOffset;
    CurrentOffsets = CurrentOffsets - iOffset;
    
    %%Averaging
    
    a1ResConcs = unique(ResConcs);
    z = 1;
    for i = a1ResConcs
        aVOffset(z) = mean(VoltageOffsets(ResConcs==i));
        aIOffset(z) = mean(CurrentOffsets(ResConcs==i));
        z=z+1;
    end
    
    a1CapConcs = CapConcs(1) + zeros(1,size(a1ResConcs,2));
    
    aResConcs = [aResConcs, a1ResConcs];
    aCapConcs = [aCapConcs, a1CapConcs];
    aVoltageOffsets = [aVoltageOffsets, aVOffset];
    aCurrentOffsets = [aCurrentOffsets, aIOffset];
end

close all;
Xrange = [0.00001,1000];
[VoltageGradient, CurrentGradient, VOffset, IOffset, XV, XI ] = o_selectivity_value(aResConcs,aCapConcs, aVoltageOffsets, aCurrentOffsets, Xrange, CapID,plot);

end
