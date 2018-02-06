function [  Diameter_nm,R_NewPore, R_Membrane ] = MembraneNewPoreDiameter( AfterResistance, BeforeResistance, BareResistance, Soln_Conductivity_S_m, Thickness_nm )
%MEMBRANENEWPOREDIAMETER Calc the resistance of a new pore in the membrane
% Taking into account the capillary and the existing defects

if nargin < 5
    Thickness_nm  = 0.6;
    if nargin < 4
        Soln_Conductivity_S_m = 7.81;
    end
end

%First find the membrane resistance and pore diamter
[ Diameter_nm, R_Pore, R_Access, R_Cone, R_Membrane, G_ns, D_Golov ] = MembranePoreDiameter( AfterResistance, Soln_Conductivity_S_m, BareResistance, Thickness_nm );

AfterResistanceMembrane = AfterResistance - R_Cone;
BeforeResistanceMembrane = BeforeResistance - R_Cone;
%Then use the change in pore to get the dimater
[ Diameter_nm, R_NewPore, R_Access,R_Channel, G_ns, D_Golov ] = MembranePoreDiameterConductivityChange( AfterResistanceMembrane,BeforeResistanceMembrane, Soln_Conductivity_S_m, Thickness_nm );


end

