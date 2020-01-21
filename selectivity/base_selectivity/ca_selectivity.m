function [ allResConcs,allCapConcs,total_aVoff,total_aIoff,std_total_aVoff, std_total_aIoff,VoltageGradient, CurrentGradient,std_mean_error_V,std_mean_error_I] = ca_selectivity(CapIDs,varargin)%plot,custom_min,custom_max)

cID = [];
cConc = [];
vOffset = [];
iOffset = [];
allCaps = [];
count = 1;

std_aVOffset = [];
std_aIOffset = [];
std_aVoltageOffsets = [];
std_aCurrentOffsets = [];

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

if(size(CapIDs,1) == 1)
    CapIDs = CapIDs';
end

%Averaging within a capillariy
for CapID = CapIDs'
    [VoltageGradient, CurrentGradient, VOffset, IOffset, ResConcs,CapConcs, VoltageOffsets, CurrentOffsets, No ] = c_selectivity(CapID,0,minResConc,maxResConc);
    a1ResConcs = unique(ResConcs);
    
    aVOffset = [];
    std_aVOffset = [];
    aIOffset = [];
    std_aIOffset = [];
    
    for z=1:length(a1ResConcs)
        aVOffset(z) = mean(VoltageOffsets(ResConcs==a1ResConcs(z)));
        std_aVOffset(z) = std(VoltageOffsets(ResConcs==a1ResConcs(z)),1);
        aIOffset(z) = mean(CurrentOffsets(ResConcs==a1ResConcs(z)));
        std_aIOffset(z) = std(CurrentOffsets(ResConcs==a1ResConcs(z)),1);
        
    end
    
    a1CapConcs = CapConcs(1) + zeros(1,size(a1ResConcs,2));
    
    aResConcs = [aResConcs, a1ResConcs];
    aCapConcs = [aCapConcs, a1CapConcs];
    aVoltageOffsets = [aVoltageOffsets, aVOffset];
    aCurrentOffsets = [aCurrentOffsets, aIOffset];
    std_aVoltageOffsets = [std_aVoltageOffsets, std_aVOffset];
    std_aCurrentOffsets = [std_aCurrentOffsets, std_aIOffset];
end

close all;
Xrange = [0.00001,1000];

allResConcs = unique(aResConcs);
total_aVoff=[];
std_total_aVoff=[];
total_aIoff=[];
std_total_aIoff=[];
allCapConcs = [];

for z=1:length(allResConcs)
    total_aVoff(z) = mean(aVoltageOffsets(aResConcs==allResConcs(z)));
    
    av_mean_error_V(z) = mean(std_aVoltageOffsets(aResConcs==allResConcs(z)))./sqrt(length(std_aVoltageOffsets(aResConcs==allResConcs(z))));
    
    %std_mean_error_V(z) = std(std_aVoltageOffsets(aResConcs==allResConcs(z)),1); %Not valid
    %std_mean_error_I(z) = std(std_aCurrentOffsets(aResConcs==allResConcs(z)),1); %Not valid
    
    %std_total_aVoff(z) = std(aVoltageOffsets(aResConcs==allResConcs(z))); %Not valid
    %std_total_aIoff(z) = std(aCurrentOffsets(aResConcs==allResConcs(z))); %Not valid

     std_total_aVoff(z) = mean(std_aVoltageOffsets(aResConcs==allResConcs(z)))%./sqrt(length(std_aVoltageOffsets(aResConcs==allResConcs(z))));
     std_total_aIoff(z)  = mean(std_aCurrentOffsets(aResConcs==allResConcs(z)))%./sqrt(length(std_aCurrentOffsets(aResConcs==allResConcs(z))));
     
    total_aIoff(z) = mean(aCurrentOffsets(aResConcs==allResConcs(z)));
    allCapConcs(z) =  mean(aCapConcs(aResConcs==allResConcs(z)));
end

%[overall_VOffset,overall_std_aVOffset,overall_aIOffset,overall_std_aIOffset,overall_aResConcs,overall_aCapConcs] = average_caps(allResConcs,allCapConcs, total_aVoff, total_aIoff,std_total_aVoff,std_total_aIoff);
%[VoltageGradient, CurrentGradient, VOffset, IOffset, XV, XI ] = o_selectivity_value(overall_aResConcs,overall_aCapConcs, overall_VOffset, overall_aIOffset, Xrange, CapID,plot,overall_std_aVOffset,overall_std_aIOffset);
[VoltageGradient, CurrentGradient, VOffset, IOffset, XV, XI ] = o_selectivity_value(allResConcs,allCapConcs, total_aVoff, total_aIoff, Xrange, CapID,plot,std_total_aVoff,std_total_aIoff);
 
%     function [overall_VOffset,overall_std_aVOffset,overall_aIOffset,overall_std_aIOffset,overall_aResConcs,overall_aCapConcs] = average_caps(aResConcs,aCapConcs, aVoltageOffsets, aCurrentOffsets,std_aVoltageOffsets,std_aCurrentOffsets)
%         overall_VOffset =[];
%         overall_std_aVOffset = [];
%         overall_aIOffset = [];
%         overall_std_aIOffset = [];
%         overall_aResConcs = [];
%         overall_aCapConcs = [];
%         all_ResConcs = unique(aResConcs);
%         k = 1;
%         for j = all_ResConcs
%             overall_VOffset(k) = mean(aVoltageOffsets(aResConcs==j));
%             overall_aIOffset(k) = mean(aCurrentOffsets(aResConcs==j));
%             if(j==aCapConcs(1))
%                 x = std_aVoltageOffsets(aResConcs == j);
%                 x = x.*x;
%                 x = sqrt(sum(x))/(length(x));
%                 overall_std_aVOffset(k) = x;
%                 
%                 x = std_aCurrentOffsets(aResConcs == j);
%                 x = x.*x;
%                 x = sqrt(sum(x))/(length(x));
%                 overall_std_aIOffset(k) = x;
%                 
%             else
%                 overall_std_aVOffset(k) = std(aVoltageOffsets(aResConcs==j),1);
%                 overall_std_aIOffset(k) = std(aCurrentOffsets(aResConcs==j),1);
%             end
%             
%             %overall_std_aIOffset(k) = std(aCurrentOffsets(aResConcs==j),1);
%             overall_aResConcs(k) = j;
%             overall_aCapConcs(k) = aCapConcs(k);
%             k=k+1;
%         end
%     end

end
