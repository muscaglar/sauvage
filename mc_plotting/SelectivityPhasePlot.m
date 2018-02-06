function [newCapConcs,newSelectivities] = SelectivityPhasePlot(CapIDs, titles, plot)

y = [];
x = [];
z = [];

selectivity_index = [];
count = 1;

for CapID = CapIDs
    [VoltageGradient, CurrentGradient, VOffset, IOffset, ResConcs,CapConcs, VoltageOffsets, CurrentOffsets, No ] = Selectivity(CapID);
    
    y = [y, ResConcs];
    x = [x, CapConcs];
    
    index_size = size(ResConcs);
    index = index_size(2);
    
    if (3 > VoltageGradient(1) && VoltageGradient(1) > -3)
        selectivity = 0;
    else if ( VoltageGradient(1) < 0)
        selectivity = -1;
        else if ( VoltageGradient(1) > 0)
                selectivity = 1;
            end
        end
    end
    new_count = count + index-1;
    z(count:new_count) = selectivity; 
    count = new_count+1;

end
close all;

x = log10(x);
y = log10(y);

figure;
scatter(x(z == 1), y(z == 1), 'b', '+')
hold on;
scatter(x(z == -1), y(z == -1), 'r', 'x')
scatter(x(z == 0), y(z == 0), 'k', 'o')


end
