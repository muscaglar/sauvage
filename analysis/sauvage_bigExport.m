function [export_data] = sauvage_bigExport(CapIDs, anion, cation,name) %z_cap_over_res, z_total_vOff, z_total_IOff, z_cap_ID, z_cap_Concs, z_res_Concs,

cap_over_res =  [];
total_vOff = [];
total_IOff = [];
cap_ID = [];
cap_Concs = [];
res_Concs = [];
total_vOff_err = [];
total_IOff_err = [];
z_GHK = [];

for aCaps = CapIDs
    
    all_cap_div_res = [];
    all_vOff = [];
    all_IOff = [];
    all_vOff_err = [];
    all_IOff_err = [];
    
    [rConc,cConc, vOff, IOff,vOff_err, IOff_err] = ca_selectivity(aCaps);
    close all;
    
    cap_div_res = log10(cConc ./ rConc); % This is the relative concentration
    
    uRConcs = unique(rConc);
    
    for uRConc = uRConcs
        iuRConc = (uRConc == rConc);
        all_cap_div_res = [all_cap_div_res, cap_div_res(iuRConc)];
        all_vOff = [all_vOff, vOff(iuRConc)];
        all_IOff = [all_IOff, IOff(iuRConc)];
        all_vOff_err = [all_vOff_err, vOff_err(iuRConc)];
        all_IOff_err = [all_IOff_err, IOff_err(iuRConc)];
    end
    
    cap_over_res =  [cap_over_res, all_cap_div_res];
    total_vOff = [total_vOff, all_vOff];
    total_IOff = [total_IOff, all_IOff];
    total_vOff_err = [total_vOff_err, all_vOff_err];
    total_IOff_err = [total_IOff_err, all_IOff_err];
    
    zallcaps = zeros(1,length(all_cap_div_res));
    zallcaps = zallcaps + aCaps;
    
    cap_ID = [cap_ID, zallcaps];
    
    zallcaps2 = zeros(1,length(all_cap_div_res));
    zallcaps2 = zallcaps2 + cConc(1);
    
    cap_Concs = [cap_Concs, zallcaps2];
    
    res_Concs = [res_Concs, rConc];
end

[ an_max_Nernst ] = percent_Nernst(cap_over_res',anion);
[ cat_max_Nernst ] = percent_Nernst(cap_over_res',cation);

z=[cap_over_res', (-1*total_vOff'),total_vOff_err',(-1*total_IOff'),total_IOff_err', cap_Concs',res_Concs', cap_ID', an_max_Nernst, cat_max_Nernst];
z_mean_byCapConc = average_vOffset_data(z);

z_GHK = sauvage_golov(cap_Concs',res_Concs',z(:,2),cation,anion);

if (size(CapIDs,2) == 1 )
    [selectivities,res_pH] = sauvage_selectivity_vs_pH(CapIDs);
else
    [selectivities,res_pH] = sauvage_selectivity_vs_pH(CapIDs');
end

res_pH(:,1)=res_pH(:,1)*0.001;
res_pH(:,3)=res_pH(:,3)*0.001;

[total_ratio,anion_cation] = sauvage_GHKpermeability(CapIDs);
perms = [total_ratio, anion_cation];
[res_pH(:,16)] = sauvage_golov(res_pH(:,3),res_pH(:,1),res_pH(:,6),res_pH(:,8),res_pH(:,9));

    function [total_mat] = average_vOffset_data(z_in)
        all_cap_concs = unique(z_in(:,6));
        total_mat = [];        
        for capID = all_cap_concs'
            index = find(z_in(:,6)==capID); %index for current cap
            [C,ia,idx] = unique(z_in(index,1));
            val = accumarray(idx,z_in(index,2),[],@mean);
            val2 = accumarray(idx,z_in(index,3),[],@mean);
            val3 = accumarray(idx,z_in(index,4),[],@mean);
            val4 = accumarray(idx,z_in(index,5),[],@mean);
            cap = ones(length(val),1);
            cap = cap*capID;
            this_mat = [C cap val val2 val3 val4];
            total_mat = [total_mat; this_mat];
        end        
    end
z_mean_res = z_mean_byCapConc(:,2)/(10.^z_mean_byCapConc(:,1));
averaged_GHK = sauvage_golov(z_mean_byCapConc(:,2),z_mean_res,z_mean_byCapConc(:,3),cation(1),anion(1));

export_data = catpad(2,log10(res_pH( :,3)./res_pH( :,1)),res_pH( :,3),res_pH( :,6),res_pH( :,4),res_pH( :,5),res_pH( :,1),res_pH( :,2),res_pH( :,12),res_pH( :,8),res_pH( :,10),res_pH( :,9),res_pH( :,11),res_pH( :,14),res_pH( :,13),res_pH( :,16),perms( :,2),perms( :,3),perms( :,1),z( :, 8),z( :, 6),z( :, 7),z( :, 1),z( :, 2),z( :, 3),z( :, 4),z( :, 5),z( :, 9),z( :, 10),z_mean_byCapConc( :,2),z_mean_byCapConc( :,1),z_mean_byCapConc( :,3),z_mean_byCapConc( :,4),z_mean_byCapConc( :,5),z_mean_byCapConc( :,6),averaged_GHK,selectivities( :, 5),selectivities( :, 3),selectivities( :, 4),selectivities( :, 1),selectivities( :, 2),z( :, 6),z( :, 7),z( :, 1),z_GHK,[0],res_pH( :,7),'padval',0);

sauvage_bigExport_toOrigin(export_data, name);

end

% z:
% 1:  [Cap]/[Res]
% 2:  Nernst Potential
% 3:  Nernst Potential Error
% 4:  Nernst Current
% 5:  Nernst Current Error
% 6:  [Cap]
% 7:  [Res]
% 8:  cID
% 9:  anion max Nernst
% 10: cation max Nernst

% z_mean_byCapConc:
% 1:  [Cap]/[Res]
% 2:  [Cap]
% 3:  selectivity
% 4:  selectivity error
% 5:  curent selectivity
% 6:  current selectivity error

%selectivities:
% 1:  selectivity
% 2:  selectivity error
% 3:  Cap pH
% 4:  Cap Conductivity
% 5:  [Cap]

%res_ph:
% 1:  [Res]
% 2:  pH_Res
% 3:  [Cap]
% 4:  pH_Cap
% 5:  sigma_Cap
% 6:  Nernst Potential
% 7:  cID
% 8:  Valencey_Cation
% 9:  Valencey_Anion
% 10: Radii_Cation
% 11: Radii_Anion
% 12: sigma_Res
% 13: Resistance
% 14: Bare Resistance
% 15: Suppression Codes
% 16: S_GHK

% cID
% [Cap]
% Nernst
% [Cap] ph
% [Cap] sigma
% [Res]
% [Res] ph
% [Res] sigma
% Cat Val
% Cat Rad
% Ani Val
% Ani Rad
% Bare Res
% Sealed Res
% GHK
% Perms: Anion
% Perms: Cation
% Perms: Ratio
% 000000
% cID
% [Cap]
% [Res]
% [Cap]/[Res]
% Nernst Potential
% Nernst Potential Error
% Nernst Current
% Nernst Current Error
% anion max Nernst
% cation max Nernst
% 0000000
% [Cap]
% [Cap]/[Res]
% selectivity
% selectivity error
% curent selectivity
% current selectivity error
% 0000000
% [Cap]
% Cap pH
% Cap Sigma
% Selectivity
% Selectivity Error
% [Cap]
% [Res]
% [Cap]/[Res]
% GHK