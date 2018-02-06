%Defect Analysis Script
%A script to run a vector of defect densities

%set up Peak ratio vector is Id/IG    so 1/100 = 0.1...
%2/1 = 2   - this is very high defects and is probably outside the limits
%of this method
%PeakRatio = 0.0001:0.001:2;
PeakRatio = logspace(log(0.0001),0,30);

%calculate the defect densities
[a b c d e f] = DefectDensity(PeakRatio');

% Columns are
% PeakRatio Ld2 ld nd (ld2max ld2min) (ldmax ldmin) (NdMin NdMax) (ld2+-) (ld+-) (nd+-)
matrix = [PeakRatio' a b c d e f (d(:,2)- d(:,1)) (e(:,2)- e(:,1)) (f(:,2)- f(:,1))]
save('Defects');