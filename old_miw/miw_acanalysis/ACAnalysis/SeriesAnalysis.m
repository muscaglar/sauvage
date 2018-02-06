function [ R, C, R_intersect ] = SeriesAnalysis( AC )
% Analyse as a series RC circuit by linearising and fitting a line

Voltage = 10;
CurrentScale = 1e-9;
VoltageScale = 1e-3;

%%%%%%% SERIAL Circuit Model

W = 2 .* pi .* AC(:,1);
theta = (AC(:,3) ./ 180) .* pi;
T = tan(theta);
%in the top two plot the actual AC outputs  - use the bottom two for the
%fits
subplot (2,3,1)
hold off
plot(AC(:,1),AC(:,2));
title('Current Magnitude (peak)')
subplot (2,3,4)
plot(AC(:,1),AC(:,3));
title('Phase')

%Now do a plot to fit to the magnitude data
subplot (2,3,3)
I2 = (AC(:,2) .* CurrentScale) .^ 2;
W2 = W.^2;
invI2 = 1 ./ I2;
invW2 = 1 ./ W2;
hold off
loglog(invW2,invI2, '+b');
%plot(invW2,invI2, '+b');
hold on;
[p] = polyfit(invW2,invI2, 1);
f = polyval(p,invW2);
loglog(invW2, f,'r');
%plot(invW2, f,'r');
title('Serial Magnitude Processed')

x= p(1);
C2 = 1 / (x * (Voltage * VoltageScale)^2);
C = C2 .^ 0.5;

    %Nb can get resistance from the intercept
    R2 = p(2) * (Voltage * VoltageScale)^2;
    R_intersect = R2 ^ 0.5;
    
%Now do a plot to fit to the phase data
subplot (2,3,6)
hold off
invW = 1 ./ W;
semilogx(invW, T, '+b');
hold on
title('Serial Phase Processed')
[m] = polyfit(invW,T, 1);
f = polyval(m,invW);
semilogx(invW, f, 'r');

R = -1 / (C * m(1)); 

end

