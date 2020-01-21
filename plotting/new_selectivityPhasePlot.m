function [] = new_selectivityPhasePlot(CapIDs)

y = [];
x = [];
z = [];

selectivity_index = [];
count = 1;

for CapID = CapIDs
    [VoltageGradient, CurrentGradient, VOffset, IOffset, ResConcs,CapConcs, VoltageOffsets, CurrentOffsets, No ] = c_selectivity(CapID);
    
    y = [y, ResConcs];
    x = [x, CapConcs];
    
    index_size = size(ResConcs);
    index = index_size(2);
    selectivity = [];
    for i = 1:index
        
         if (1 > VoltageOffsets(i) && VoltageOffsets(i) > -1)
            selectivity(i) = 0;
         else
            selectivity(i) = sign(-1 * VoltageOffsets(i) * sign(log10(CapConcs(i)/ResConcs(i))));
        end
    end
    
    %selectivity_sign = -1 * VOffset(x) * sign(log10(CapConcs(x)/ResConcs(x)));
    
    
    z = [z, selectivity];
end
close all;

x = log10(x);
y = log10(y);

h = figure;
scatter(x(z == 1), y(z == 1), 'b', '+')
hold on;
scatter(x(z == -1), y(z == -1), 'r', 'x')
scatter(x(z == 0), y(z == 0), 'k', 'o')

% savefig(h,'MgCl2.fig')
% close(h)

end
