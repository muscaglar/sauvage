
function [ PositiveIonPermeability, NegativeIonPermeability, Offset ] = GHK_FitPermeabilityMonoCharge( IV, ConcI, Conc0, Vm )
%Fit the permebaility to a curve assuming 2 ions one positive and
%one negative in equal concentration.
%
% NOTE THE Conc0 is the ground or reservoir. ConcI is the capillary

if nargin<4
   %A voltage to remove Vm - need to fix in the center..
    Vm = -1 *  mean(IV(:,2)) * 1e-3; 
else
    Vm = -1 * Vm * 1e-3;
end

%Can clean the IV curve to remove bad points.
IVc = IVClean(IV);

I = IVc(:,1) ;%* 1e-9;
V = IVc(:,2) * 1e-3 + Vm;

%Use a linear fit  - calculate x values using equation with P = 1
z = [1 -1];
n = max(size(V));
GHK = [GHK_CurrentByIon_S( z(1), V , 1, ConcI, Conc0 ) GHK_CurrentByIon_S( z(2), V , 1, ConcI, Conc0 ) ones(n,1)];

%plot(GHK(:,1), I );
%hold on
%plot( GHK(:,2), I);
%figure

Params0 = [1e-7 1e-7 0];
%Does the fitting with V and nA  - so need to correct later
P = fminsearch(@(Params0) Cost( I, GHK, Params0  ), Params0);
P(1)
P(2)
CostError = (Cost( I, GHK, P ));
m = mean(IVc(:,1));
sd = sqrt(sum((IVc(:,1) - m).^2 ));
%e = CostError/(sd)
%e = CostError/(max(IVc(:,1))- min(IVc(:,1)))
e = CostError


%Do any necessary Scaling to get into SI.
PositiveIonPermeability = abs(P(1)) * 1e-9;
NegativeIonPermeability = abs(P(2)) * 1e-9;
Offset = P(3)*1e-9;

%Plot the result against the raw data  - in SI Units
[It , Ic] = GHK_TotalCurrent(z,V, [PositiveIonPermeability NegativeIonPermeability] , ConcI, Conc0);

%Convert  - into nA and mV for plotting.
It = It * 1e9;
Ic = Ic * 1e9;
offsetnA = Offset * 1e9;

%Plot it in nA and mV
%figure(20);
hold off;
plot((V-Vm)*1000,Ic + offsetnA,' - ');
hold all
plot((V-Vm)*1000,It + offsetnA);
hold on
xlabel({['Voltage mV'],['ConcI: ' num2str(ConcI) ', Conc0: ' num2str(Conc0)]});
ylabel('Current nA')
title({['GHK Plot - Positive P: ' num2str(PositiveIonPermeability) ', Negative P: ' num2str(NegativeIonPermeability) ],[ ', Offset ' num2str(Offset*1e9) 'nA, error: ' num2str(e)],['Ratio: ' num2str(PositiveIonPermeability/NegativeIonPermeability)]});
%Plot the raw data - on top of the plot created by GHK_Total Current
plot(IV(:,2),IV(:,1),'o');
plot((V-Vm)*1e3,I(:,1),'+');
hold off

disp(['Positive P: ' num2str(PositiveIonPermeability) ', Negative P:' num2str(NegativeIonPermeability) ', Offset ' num2str(Offset*1e9) 'nA, Error: ' num2str(e)]);
disp(['Ratio ' num2str(PositiveIonPermeability/NegativeIonPermeability)]);
disp(['ConcI: ' num2str(ConcI) ', Conc0: ' num2str(Conc0)]);
end

