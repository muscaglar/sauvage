function [newIV,P] = GHK_mono( IV, ConcI, Conc0 )

I = IV(:,1);
V = IV(:,2) * 1e-3;

PhysicalConsts

%Use a linear fit  - calculate x values using equation with P = 1
z = [1 -1];
n = max(size(V));

P = 1;
I_z1 = P .* z(1).^2 .* ( ( V .* F_Const.^2)  ./ (R_Const .* T_Const) ) .* ( ( ConcI - Conc0 .* exp(-1 .* GHK_Vs(z(1),V)) ) ./ ( 1 - exp(-1 .* GHK_Vs(z(1),V)) ) ); 
I_z2 = P .* z(2).^2 .* ( ( V .* F_Const.^2)  ./ (R_Const .* T_Const) ) .* ( ( ConcI - Conc0 .* exp(-1 .* GHK_Vs(z(2),V)) ) ./ ( 1 - exp(-1 .* GHK_Vs(z(2),V)) ) ); 

GHK = [I_z1 I_z2 ones(n,1)];
Params0 = [1e-7 1e-7 0];

P = fminsearchbnd(@(Params0) costFunc( I, GHK, Params0), Params0,[0 0 0],[inf inf inf]);
P1 = fminsearchbnd(@(Params0) costFunc( I+IV(:,3), GHK, Params0), Params0,[0 0 0],[inf inf inf]);
P2 = fminsearchbnd(@(Params0) costFunc( I-IV(:,3), GHK, Params0), Params0,[0 0 0],[inf inf inf]);

P = (P + P1 + P2 ) ./ 3;


CostError = (costFunc( I, GHK, P ));
m = mean(IV(:,1));
sd = sqrt(sum((IV(:,1) - m).^2 ));
e = CostError;

PositiveIonPermeability = abs(P(1));
NegativeIonPermeability = abs(P(2));
Offset = P(3);

%Plot the result against the raw data  - in SI Units
[It , Ic] = GHK_TotalCurrent(z,V, [PositiveIonPermeability NegativeIonPermeability] , ConcI, Conc0);

newIc  = Ic + Offset;
newIt = It + Offset;
newV = (V)*1e3;

newIV = [newV, newIc, newIt];
end

function [ CostFunc  ] = costFunc(I, GHK, P )

CostFunc  =  sum((I - GHK * [abs(P(1)) ; abs(P(2)); P(3)]  ).^2 );

CostFunc = sqrt(CostFunc) / (max(I)- min(I));

end


