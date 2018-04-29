function [all_perm, all_cap, all_res ] = mc_GHK_Generate_I(z, CapillaryIDs)

all_perm = [];
all_cap = [];
all_res = [];

perm = [];
cap = [];
res = [];

F = 96485;
R = 8.314;
T = 300;

Expts = [];
Offsets = [];
No = 0;

for CapillaryID = CapillaryIDs
    
    VoltageOffsets = [];
    CurrentOffsets = [];
    ResConcs = [];
    CapConcs = [];
    perm = [];
    cap = [];
    res = [];
    
    [ ~, ~, ExptIDs  ] = LoadExperiments( CapillaryID, 1, [0 16] );
    
    for ExperimentID = ExptIDs
        [ IV, ~,~ ] = LoadIVByNo(  ExperimentID );
        IV = IVClean(IV);
        [ ~,~,~,~, E,~] = GetDataByID(ExperimentID);
        CapConcs = E.getCapillaryConc();
        ResConcs = E.getReservoirConc();
        
        V = IV(:,2) * 0.001;
        Ci = 1000 * CapConcs;
        Co = 1000 * ResConcs;
        I = IV(:,1) * 1e-9;
        run_length = size(V,1);
        
        phi = I / (pi * (90e-9)^2); % A/m2
        
        for i=1:run_length
            exponent =  exp( -z * V(i) * F / (R*T) );
            GHK_perm_bottom = z^2 * V(i) * F^2 * (Ci - Co * exponent);
            GHK_perm_top = phi(i) * R * T * (1 - exponent);
            GHK_perm = GHK_perm_top / GHK_perm_bottom ;
            perm = [perm, GHK_perm];
            cap = [cap, Ci];
            res = [res, Co];
        end
    end
    
    all_perm = catpad(2,all_perm, perm');
    all_cap = catpad(2,all_cap, cap');
    all_res = catpad(2,all_res, res');
    
end

%     i = 1;
%     n = length(Expts);
%     for j = 1:n
%         E = Expts(j);
%         %Apply Limits
%         if E.getReservoirConc() <=  10000000  && E.getReservoirConc() >=  0.00000001
%             if E.getVoffset ~= 0
%                 VoltageOffsets(i) = E.getVoffset();% - Offsets(j);
%             else
%                 VoltageOffsets(i) = nan;
%             end
%             if E.getIoffset ~= 0
%                 CurrentOffsets(i) = E.getIoffset();
%             else
%                 CurrentOffsets(i) = nan;
%             end
%             ResConcs(i) = E.getReservoirConc();
%             CapConcs(i) = E.getCapillaryConc();
%             i = i+1;
%         else
%             %Do not use this entry as outside the range for this analysis
%         end
%     end

% -1.8353e-04 for 0.001
% 6.2531e-05  for 0.01
% 6.2270e-04  for 0.1
% 1.9697e-06  for 2
% 5.3342e-06 for 3

%
% n=0.8034; %viscosity
% a=250e-12; %radius of ion
% f=6*pi*n*a;
% kb=1.38064852e-23; %boltman
% z=3; %valency
% F=9.64853399e4; %Farday
% R=8.3144621; %
% D=kb/f;
% ci=1;
% ce=0.001;
% %v=59e-3;
% L=0.34e-9;
% T=300;
% I=(D*z*z*F*F*v*(ci-(ce*exp(-z*v*F/R*T))))/(L*R*(1-exp(-z*v*F/R*T)));

end