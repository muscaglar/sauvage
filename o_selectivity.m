function [ VoltageGradient, CurrentGradient, VOffset, IOffset, ResConcs,CapConcs, VoltageOffsets, CurrentOffsets, No ] = o_selectivity( cIDs,varargin)
%Caculate the gradient of the voltage and current offsets
%   Note code currently assumes the capillary conc is fixed - and does all
%   measurements on the reservoir conc only - not the difference!
%   Expts can be either an array of experiments or the CapillaryID or a
%   vectors of IDs
%       In the event of a vector the array is stacked so that all get
%       raw data gets treated together (ie mean found of all ofsets (not mean of means).

AllowableSuppressionCodes = [0 16];


maxResConc = 10000000;
minResConc = 0.00000001;
plot = 1;

switch nargin
    case 2
        plot = varargin{1};
    case 4
        plot = varargin{1};
        maxResConc = varargin{3};
        minResConc = varargin{2};
        
end

if(plot)
    
    figure(24)
end

Xrange = [0.00001 0.0001 0.001 0.01 0.1 0.25 0.5 1 2];


Expts = [];
Offsets = [];
No = 0;
for cID = cIDs
    [Expts_0, No_0] = LoadExperiments( cID, 1, AllowableSuppressionCodes );
    Expts = [Expts Expts_0];
    
    No = No + No_0 ;
    
    Offsets = [Offsets (VOffsetCorrection( cID ) * ones(1,No_0))];  %What is this doing?
    
end

%Read out the values into Arrays here
VoltageOffsets = [];
CurrentOffsets = [];
ResConcs = [];
CapConcs = [];
i = 1;
n = length(Expts);
for j = 1:n
    E = Expts(j);
    %Apply Limits
    if E.getReservoirConc() <=  maxResConc  && E.getReservoirConc() >=  minResConc
        if E.getVoffset ~= 0
            VoltageOffsets(i) = E.getVoffset();% - Offsets(j);
        else
            VoltageOffsets(i) = nan;
        end
        if E.getIoffset ~= 0
            CurrentOffsets(i) = E.getIoffset();
        else
            CurrentOffsets(i) = nan;
        end
        ResConcs(i) = E.getReservoirConc();
        CapConcs(i) = E.getCapillaryConc();
        i = i+1;
    else
        %Do not use this entry as outside the range for this analysis
    end
end

ResConcs = round(ResConcs,6);
CapConcs = round(CapConcs,5);

Xrange = unique(ResConcs);



if (max(size(unique(ResConcs))) >=2) ||(max(size(unique(CapConcs))) >= 2)
    
    [ VoltageGradient, CurrentGradient, VOffset, IOffset, XV, XI ] = o_selectivity_value( ResConcs,CapConcs, VoltageOffsets, CurrentOffsets, Xrange, Expts(1).getCapillary(),plot );
    
    if(plot)
        hold on
    end
    
    if isnumeric(Expts) && length(cIDs) == 1
        %This will remove the cancelling effect of Voffset  - ie if there already
        %is an offset then don't want to return 0 as this could then get written to
        %DB whn its wrong!!
        %But only do for cases where a single capillary ID was passed in!
        %   VOffset = VOffset + Offsets(1);
    end
    
else
    No = 0;
    disp('No different concentration Results - therefore cannot calc selectivity');
    VoltageGradient=[];
    CurrentGradient=[];
    VOffset=[];
    IOffset=[];
    %ResConcs,CapConcs
    %VoltageOffsets,
end

end

