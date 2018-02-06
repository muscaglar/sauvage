
function [x,y] = VOffsetPhasePlot(CapIDs, titles, plot)

y = [];
x = [];
z = [];
z_new = [];
selectivity_index = [];
count = 1;

for CapID = CapIDs
    [VoltageGradient, CurrentGradient, VOffset, IOffset, ResConcs,CapConcs, VoltageOffsets, CurrentOffsets, No, allCaps ] = SeeNonSelectivity(CapID);
    
    y = [y, ResConcs];
    x = [x, CapConcs];
    z = [z, VoltageOffsets];
    z_new = [z_new, VoltageOffsets];
     for v = VoltageOffsets
          if (15 > round(v) && round(v) > -15)
              z_new(count) = 0;
          else
             z_new(count) = sign(round(v));
          end
         count = count + 1;
     end

end
close all;

x2 = x./y;

x = log10(x);
y = log10(y);

figure;
hold on;
 scatter(x(z_new == 1), y(z_new == 1), 'b', '+')
 hold on;
 scatter(x(z_new == -1), y(z_new == -1), 'r', 'x')
 hold on;
 scatter(x(z_new == 0), y(z_new == 0), 'k', 'o')

 figure;
 
dotsize=25;
scatter3(x(:), y(:), z(:), dotsize, z(:), 'filled')

figure;


x2 = log10(x2);

scatter(x2,z);




% pointsize = 50;
% scatter(x, y, pointsize, z);

end
