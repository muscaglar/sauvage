function [newIV, P] = GHK_quad( IV, ConcI, Conc0 )

I = IV(:,1);
V = IV(:,2) * 1e-3;

Fc = 96485.3399; %C / mol

options = optimset('MaxFunEvals',100000,'MaxIter',100000);

n = max(size(V));
P = [1, 1];
iC = ( (16 .* Fc.* Fc .* P(1) .*V) ./ (8.3145.*300) )  .*  (  (ConcI - Conc0 .* exp(4.*Fc.*V ./8.3145.*300))  ./  ( 1 - exp(4.*Fc.*V ./8.3145.*300) ) );
iA = ( (Fc.^2 .* P(2) .*V) ./ (8.3145.*300) )  .*  (  (ConcI - Conc0 .* exp(-1.*Fc.*V ./8.3145.*300))  ./  ( 1 - exp(-1.*Fc.*V ./8.3145.*300) ) );
GHK = [iC iA ones(n,1)];

Params0 = [1e10 1e10 0];
P = fminsearchbnd(@(Params0) costFunc( I, GHK, Params0), Params0,[0 0 0],[inf inf inf],options);
P1 = fminsearchbnd(@(Params0) costFunc( I+IV(:,3), GHK, Params0), Params0,[0 0 0],[inf inf inf],options);
P2 = fminsearchbnd(@(Params0) costFunc( I-IV(:,3), GHK, Params0), Params0,[0 0 0],[inf inf inf],options);

P = (P + P1 + P2 ) ./ 3;

CostError = (costFunc( I, GHK, P ));
m = mean(IV(:,1));
sd = sqrt(sum((IV(:,1) - m).^2 ));
e = CostError;

PositiveIonPermeability = abs(P(1)) ;
NegativeIonPermeability = abs(P(2)) ;
Offset = P(3);

iC = @(PositiveIonPermeability,V) ( (9 .* Fc.* Fc .* PositiveIonPermeability .*V) ./ (8.3145.*300) )  .*  (  (ConcI - Conc0 .* exp(3.*Fc.*V ./8.3145.*300))  ./  ( 1 - exp(3.*Fc.*V ./8.3145.*300) ) );
iA = @(NegativeIonPermeability,V) ( (Fc.^2 .* NegativeIonPermeability .*V) ./ (8.3145.*300) )  .*  (  (ConcI - Conc0 .* exp(-1.*Fc.*V ./8.3145.*300))  ./  ( 1 - exp(-1.*Fc.*V ./8.3145.*300) ) );

disp(PositiveIonPermeability)
disp(NegativeIonPermeability)

%Making a better 'V' vector
V = transpose(linspace(min(V)*2,max(V)*2,200));

It = nansum([iC(PositiveIonPermeability,V) iA(NegativeIonPermeability,V)],2);
Ic = [iC(PositiveIonPermeability,V),iA(NegativeIonPermeability,V)];
offsetnA = Offset;

newIV = [(V).*1e3, Ic+offsetnA, It+offsetnA];

end


function [ CostFunc ] = costFunc(I, GHK, P)
GHK(isnan(GHK)) = 0;
CostFunc  =  nansum((I - GHK * [(P(1)) ; (P(2)); P(3)] ).^2 );
CostFunc = sqrt(CostFunc) / (max(I)- min(I));
end



