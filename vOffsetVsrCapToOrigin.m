function [z] = vOffsetVsrCapToOrigin(CapIDs, anion, cation) %z_cap_over_res, z_total_vOff, z_total_IOff, z_cap_ID, z_cap_Concs, z_res_Concs, 
%Plot VOffset against the cCap for ONE cReservoir

cap_over_res =  [];
total_vOff = [];
total_IOff = [];
cap_ID = [];
cap_Concs = [];
res_Concs = [];
% ORG = Matlab2OriginPlot();
% PlotName = '1' ;
% ORG.Figure([PlotName]);

for CapID = CapIDs
    
    aCaps = [];
    
    all_cap_div_res = [];
    all_vOff = [];
    all_IOff = [];
    
   % [VoltageGradient, CurrentGradient, VOffset, IOffset, ResConcs,CapConcs, VoltageOffsets, CurrentOffsets, No, allCaps ] = Averaged_CorrectedSelectivity(CapID);%SeeNonSelectivity(CapID);
    [ResConcs,CapConcs, VoltageOffsets, CurrentOffsets, allCaps] = Averaged_CorrectedSelectivity(CapID);
    rConc = [ResConcs];
    cConc = [CapConcs];
    vOff = [VoltageOffsets];
    IOff = [CurrentOffsets];
    aCaps = [allCaps];
    close all;
    
    cap_div_res = cConc ./ rConc; % This is the relative concentration
    cap_div_res = log10(cap_div_res);
    
    uRConcs = unique(rConc);
    
    for uRConc = uRConcs
        iuRConc = (uRConc == rConc);
        all_cap_div_res = [all_cap_div_res, cap_div_res(iuRConc)];
        all_vOff = [all_vOff, vOff(iuRConc)];
        all_IOff = [all_IOff, IOff(iuRConc)];
    end
    
    %     if first == 1
    %         plotHandle = ORG.PlotScatter(fuxy, fuz,'PlotName', ORG.ColourPicker());
    %         first = 0;
    %     else
    %         ORG.PlotScatter(fuxy, fuz, plotHandle, ORG.ColourPicker());
    %     end
    %
    %     ORG.Disconnect;
    
    cap_over_res =  [cap_over_res, all_cap_div_res];
    total_vOff = [total_vOff, all_vOff];
    total_IOff = [total_IOff, all_IOff];
    
    zallcaps = zeros(1,length(all_cap_div_res));
    zallcaps = zallcaps + allCaps(1);
    
    cap_ID = [cap_ID, zallcaps];
    
    zallcaps2 = zeros(1,length(all_cap_div_res));
    zallcaps2 = zallcaps2 + CapConcs(1);
    
    cap_Concs = [cap_Concs, zallcaps2];
    
    res_Concs = [res_Concs, rConc];
end

z_cap_over_res =  cap_over_res';
z_total_vOff = total_vOff';
z_total_IOff = total_IOff';
z_cap_ID = cap_ID';
z_cap_Concs = cap_Concs';
z_res_Concs = res_Concs';

[ an_max_Nernst ] = percent_Nernst(z_cap_over_res,anion);
[ cat_max_Nernst ] = percent_Nernst(z_cap_over_res,cation);

z=[z_cap_over_res, z_total_vOff, (-1*z_total_vOff), z_cap_Concs, z_cap_ID, an_max_Nernst, cat_max_Nernst];

end
