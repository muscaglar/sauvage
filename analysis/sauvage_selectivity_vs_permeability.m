function [all_perm] = sauvage_selectivity_vs_permeability(z, CapillaryIDs)

all_perm = [];
all_cap = [];
all_res = [];

perm = [];
cap = [];
res = [];

F = 96485;
R = 8.314;
T = 295;

Expts = [];
Offsets = [];
No = 0;
perm = [];
cap = [];
res = [];

for CapillaryID = CapillaryIDs
    VoltageOffsets = [];
    CurrentOffsets = [];
    ResConcs = [];
    CapConcs = [];
    
    [ ~,aCapConcs, ~, ~, ~,  ~,VoltageGradient, CurrentGradient] = ca_selectivity(CapillaryID);%plot,custom_min,custom_max)
    CapConcs = aCapConcs(1);
    ResConcs = 1;
    V = VoltageGradient(1) * 0.001;
    Ci = 1000 * CapConcs;
    Co = 1000 * ResConcs;
    I = CurrentGradient(1) * 1e-9;
    phi = I / (pi * (90e-9)^2); % A/m2
    exponent =  exp( -z * V * F / (R*T) );
    GHK_perm_bottom = z^2 * V * F^2 * (Ci - Co * exponent);
    GHK_perm_top = phi * R * T * (1 - exponent);
    GHK_perm = GHK_perm_top / GHK_perm_bottom ;
    perm = [perm, GHK_perm];
    cap = [cap, Ci];
    res = [res, Co];
close all;
end

all_perm = catpad(2,all_perm, perm');
all_cap = catpad(2,all_cap, cap');
all_res = catpad(2,all_res, res');

end