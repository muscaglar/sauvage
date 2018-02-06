function [ R, C , R_intersect] = ParallelAnalysis( AC )
%Analyse as a parallel RC circuit by parallising and fit a line

Voltage = 10;
CurrentScale = 1e-9;
VoltageScale = 1e-3;

%%%%%%% PARALLEL Circuit Model

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
subplot (2,3,2)
hold off
I2 = (AC(:,2) .* CurrentScale) .^ 2;
W2 = W.^2;
plot(W2, I2, '+b');
hold on;
[p] = polyfit(W2,I2, 1);
f = polyval(p,W2);
plot(W2, f,'r');
title('Parallel Magnitude Processed')
%This is the gradient
x = p(1);
C2 = x / (Voltage.*VoltageScale)^2;
C = C2 .^ 0.5;

%This is the intersect - suggestion of R  - could be quite accurate!
R2 = ((Voltage.*VoltageScale)^2 / p(2));
R_intersect = R2 .^ 0.5;

%Now do a plot to fit to the phase data
subplot (2,3,5);
hold off;
plot(W, T,'+b');
hold on;
[m] = polyfit(W,T, 1);
f = polyval(m,W);
plot(W, f, 'r');
title('Parallel Phase Processed');
R = m(1) / C;

R = abs(R);

end

