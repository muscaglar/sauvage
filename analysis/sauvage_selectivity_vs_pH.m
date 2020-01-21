function [selectivities,res_pH] = sauvage_selectivity_vs_pH(cIDs)

ALaCl3 = [];
BKCl = [];
CeCl3 = [];
HfCl4 = [];
K3PO4 = [];
LaCl3 = [];
MgCl2 = [];
ZrCl4 = [];
KCl = [];

if(ispc)
    load('C:\Users\mc934\Dropbox (Team Caglar)\PhD\MATLAB\catalogue\salts\pH_salt.mat')
else
    load('/Volumes/MusDrive/Dropbox/PhD/MATLAB/sauvage/catalogue/salts/pH_salt.mat')
end

i = 1;
selectivities = zeros(4,length(cIDs));
Selectivities_sol = zeros(1,length(cIDs));
res_pH = [];
reservoir_pH_conc_sol = [];

for CapID = cIDs'
    [VoltageGradient, CurrentGradient, VOffset, IOffset, ResConcs,CapConcs, VoltageOffsets, CurrentOffsets, No,allCaps, capSol,resistances,supps ] = c_selectivity(CapID);
   close all;
    selectivities(i,1) = VoltageGradient(1);
    selectivities(i,2) = VoltageGradient(2);
    if(isempty(capSol))
        pH = [10000 100000];
    else
        capSol = correct_salt_name(capSol);
        cap_conc = num2str(CapConcs(1) * 1000);
        pH = eval([capSol '(' cap_conc ')']);
    end
    selectivities(i,3) = pH(1);
    selectivities(i,4) = pH(2);
    selectivities(i,5) = CapConcs(1);
    
    [temp_res_pH,reservoir_pH_conc_sol_temp] = populate_res_pHs(ResConcs,CapID,capSol,CapConcs(1),pH,VoltageOffsets,resistances,supps);
    res_pH = [res_pH; temp_res_pH];
    reservoir_pH_conc_sol = [ reservoir_pH_conc_sol, reservoir_pH_conc_sol_temp];
    capSol = char(capSol);
    capSol = string(capSol);
    Selectivities_Sol(1,i) = capSol;
    i=i+1;
end

    function [sln] = correct_salt_name(sln)
        if(strcmp(sln,'KCL'))
            sln = 'KCl';
        end
        if(strcmp(sln,'Cecl3'))
            sln = 'CeCl3';
        end
        if(strcmp(sln,'KCl_B'))
            sln = 'BKCl';
        end
        sln = char(sln);
    end

    function [reservoir_pH_conc,reservoir_sol] = populate_res_pHs(reservoir_conc,cID,cSol,cConc,cpH,vOffs,Res,suppsCodes)
        j = 1;
        for r = reservoir_conc
            r = r*1000;
            
            try
                r_pH = eval([cSol '(' num2str(r) ')']);
            catch
                warning('Problem using function. Assigning a value of 0.');
                cSol
                r
                r_pH = [0,0];
            end
            
            reservoir_pH_conc(1,j) = r;
            reservoir_pH_conc(2,j) = r_pH(1);
            reservoir_pH_conc(3,j) = cConc*1000;
            reservoir_pH_conc(4,j) = cpH(1);
            reservoir_pH_conc(5,j) = cpH(2);
            reservoir_pH_conc(6,j) = -1*vOffs(j);
            reservoir_pH_conc(7,j) = cID;
            reservoir_pH_conc(12,j) = r_pH(2);
            reservoir_pH_conc(13,j) = Res(j);
            reservoir_pH_conc(15,j) = suppsCodes(j);
            temp_name = char(cSol);
            temp_name = string(temp_name);
            reservoir_sol(1,j) = temp_name;
            switch cSol
                case 'ALaCl3'
                    reservoir_pH_conc(8,j) = 3;
                    reservoir_pH_conc(9,j) = -1;
                    reservoir_pH_conc(10,j) = 1.1; %VII
                    reservoir_pH_conc(11,j) = 1.81;
                case   'BKCl'
                    reservoir_pH_conc(8,j) = 1;
                    reservoir_pH_conc(9,j) = -1;
                    reservoir_pH_conc(10,j) = 1.51; %VIII
                    reservoir_pH_conc(11,j) = 1.81;
                case   'CeCl3'
                    reservoir_pH_conc(8,j) = 3;
                    reservoir_pH_conc(9,j) = -1;
                    reservoir_pH_conc(10,j) = 1.196; %ASSUMING, IX and 3 charge.
                    reservoir_pH_conc(11,j) = 1.81;
                case   'HfCl4'
                    reservoir_pH_conc(8,j) = 4;
                    reservoir_pH_conc(9,j) = -1;
                    reservoir_pH_conc(10,j) = 0.58;%IV
                    reservoir_pH_conc(11,j) = 1.81;
                case   'K3PO4'
                    reservoir_pH_conc(8,j) = 1;
                    reservoir_pH_conc(9,j) = -3;
                    reservoir_pH_conc(10,j) = 1.51; %VIII  ASSUMPTION
                    reservoir_pH_conc(11,j) = 2.38;
                case  'LaCl3'
                    reservoir_pH_conc(8,j) = 3;
                    reservoir_pH_conc(9,j) = -1;
                    reservoir_pH_conc(10,j) = 1.1; %VII
                    reservoir_pH_conc(11,j) = 1.81;
                case  'MgCl2'
                    reservoir_pH_conc(8,j) = 2;
                    reservoir_pH_conc(9,j) = -1;
                    reservoir_pH_conc(10,j) = 0.72; %VI
                    reservoir_pH_conc(11,j) = 1.81;
                case  'ZrCl4'
                    reservoir_pH_conc(8,j) = 4;
                    reservoir_pH_conc(9,j) = -1;
                    reservoir_pH_conc(10,j) = 0.84; %VIII
                    reservoir_pH_conc(11,j) = 1.81;
                case  'KCl'
                    reservoir_pH_conc(8,j) = 1;
                    reservoir_pH_conc(9,j) = -1;
                    reservoir_pH_conc(10,j) = 1.51; %VIII
                    reservoir_pH_conc(11,j) = 1.81;
            end
            j = j + 1;
        end
        reservoir_pH_conc = reservoir_pH_conc';
    end

capIDs = unique(res_pH(:,7));

for cID = capIDs'
    cIndex = find(res_pH(:,7)==cID);
    equalConc = find(res_pH(:,1)==res_pH(:,3));
    equals = intersect(cIndex,equalConc);
    bare_av = getCapRes(cID);
    sealed_av = mean(res_pH(equals,13));
    ratio = (bare_av/sealed_av);
        for cX = cIndex'
            res_pH(cX,14) = res_pH(cX,13) * ratio;
        end
end


end