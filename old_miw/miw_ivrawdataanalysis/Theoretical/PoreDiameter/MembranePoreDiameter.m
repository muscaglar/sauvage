function [ Diameter_nm, R_Pore, R_Access, R_Cone, R_Membrane, G_ns, D_Golov ] = MembranePoreDiameter( Resistance, Soln_Conductivity_S_m, BareResistance, Thickness_nm,taper )
% Calc the size of a pore in a membrane - taking into account the
% resistance of the capillary - but discounting its access resistance

% Using and http://jgp.rupress.org/content/66/4/531.full.pdf  - Access resistance
% of a small circular pore
% And simple Channel resistance

%All Values Passed in as SI, except thickness in nm
%Returns diameter in nm

if nargin < 4
    Thickness_nm = 0.6;
end
if nargin < 3
    %Calc diameter of bare capillary
    R_Cone = 0;
    warning('Not Taking into account the bare resistance');
else
    [d_nm_bare, R_Cone, R_CapAccess] = CapillaryDiameter( BareResistance, Soln_Conductivity_S_m,taper );
end
S = Soln_Conductivity_S_m;
L = Thickness_nm / 1e9;
%Now calc the resistance change due to the pore in graphene
R_Membrane = Resistance -  R_Cone ; %- R_CapAccess;
G_ns = 1e9 /R_Membrane ;

%Now solve the combined pore and access resistance for r
n = 2;  %No access resistances  - ie both sides n = 1 or 2  - should I do the inside of the capillary differntly
a = R_Membrane * 4 * S;
b = -n;
c = - 4 * L/pi;
%I'm interested in the positive root.
PoreRadius = ( (-b) + ( (b^2) - 4*a*c ).^0.5 ) / ( 2*a );

Diameter_nm = 2 * PoreRadius * 1e9;

R_Pore = L /(pi * S * PoreRadius.^2 ) ;
R_Access = PoreAccessResistance( 2*PoreRadius , S );


%Golovchenko Method http://golovchenko.physics.harvard.edu/KuanEtAl2015.pdf
% Using: http://iopscience.iop.org/article/10.1088/0957-4484/22/31/315101/pdf
% and http://jgp.rupress.org/content/66/4/531.full.pdf  - Access resistance
% of a small circular pore
D_Golov = (1/(2*S*R_Membrane)) * (1 + ( 1 + ((16*S*L*R_Membrane)/(pi) )  ).^0.5 );


end

