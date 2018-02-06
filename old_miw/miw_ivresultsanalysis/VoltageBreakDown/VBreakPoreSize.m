function [ Diameter_nm, R_NewPore, R_Membrane ] = VBreakPoreSize( BareID, BeforeID, AfterIDs, Thickness_nm , save)
%VBREAKPORESIZE Summary of this function goes here
if nargin < 5
    save = 0;
end
if nargin < 4 ;
    Thickness_nm = 0.6;
elseif isempty(Thickness_nm );
    Thickness_nm = 0.6;
end

[ E_Bare, no, id, date ] = GetExperimentDetails( BareID  );
[ E_Before, no, id, date ] = GetExperimentDetails( BeforeID  );


%Could verify they belong to the same capillary - otherwise error

[ Soln_Conductivity_S_m ] = ReturnSolutionConductivity( char(E_Bare.getCapillarySln),E_Bare.getCapillaryConc );
BeforeResistance = 1e6 * E_Before.getResistance;
BareResistance = 1e6 * E_Bare.getResistance;

i = 1;
for AfterID = AfterIDs
    [ E_After, no, id, date ] = GetExperimentDetails( AfterID  );
    AfterResistance = 1e6 * E_After.getResistance;
    [  D,Rn, Rm ] = MembraneNewPoreDiameter( AfterResistance, BeforeResistance, BareResistance, Soln_Conductivity_S_m, Thickness_nm );
    if save == 1
        [ rValue, rStringValue, rid ] = UpdateNameValueExperiment( AfterID , 'VBreakPoreDiameter',  D );
    end
    Diameter_nm(i) = D;
    R_NewPore(i) = Rn;
    R_Membrane(i) = Rm;
    i = i+1;
end
end

