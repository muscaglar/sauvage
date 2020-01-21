function [VoltageGradient, CurrentGradient, VOffset, IOffset, ResConcs,CapConcs, VoltageOffsets, CurrentOffsets, No, allCaps,capSol,resistances, supps] = c_selectivity(CapIDs,varargin)%plot,custom_min,custom_max)

cID = [];
cConc = [];
vOffset = [];
iOffset = [];
allCaps = [];
count = 1;

supps = [];
resistances = [];
aResConcs = [];
aCapConcs = [];
aVoltageOffsets = [];
aCurrentOffsets = [];

maxResConc = 100;
minResConc = 0.00000001;

Xrange = [0.00001,1000];

switch nargin
    case 1
        plot = 1;
    case 2
        plot = varargin{1};
    case 4
        plot = varargin{1};
        maxResConc = varargin{3};
        minResConc = varargin{2};
    case 6
        plot = varargin{1};
        maxResConc = varargin{3};
        minResConc = varargin{2};
        Xrange(1) = varargin{4};
        Xrange(2) = varargin{5};
    otherwise
        
end


for CapID = CapIDs
    [VoltageGradient, CurrentGradient, VOffset, IOffset, ResConcs,CapConcs, VoltageOffsets, CurrentOffsets, No,capSol,Resistance,Suppressed ] = o_selectivity(CapID,0,minResConc,maxResConc);
    
    NaN_index_V = isnan(VoltageOffsets);
    NaN_index_I = isnan(CurrentOffsets);
    NaN_index_R = isnan(Resistance);
    NaN_index_S = isnan(Suppressed);
    
    test = zeros(1,size(ResConcs,2));
    test = test + CapID;
    allCaps = [allCaps, test];
    
    ResConcs(NaN_index_V) = [];
    CapConcs(NaN_index_V) = [];
    VoltageOffsets(NaN_index_V) = [];
    CurrentOffsets(NaN_index_V) = [];
    Resistance(NaN_index_R) = [];
    Suppressed(NaN_index_S) = [];
    
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
    
    aResConcs = [aResConcs, ResConcs];
    aCapConcs = [aCapConcs, CapConcs];
    aVoltageOffsets = [aVoltageOffsets, VoltageOffsets];
    aCurrentOffsets = [aCurrentOffsets, CurrentOffsets];
    resistances = [resistances, Resistance];
    supps = [supps, Suppressed];
end

close all;

[VoltageGradient, CurrentGradient, VOffset, IOffset, XV, XI ] = o_selectivity_value(aResConcs,aCapConcs, aVoltageOffsets, aCurrentOffsets, Xrange, CapID,plot);

end
