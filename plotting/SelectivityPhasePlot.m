function [] = SelectivityPhasePlot(CapIDs)

y = [];
x = [];
z = [];
colInd = [];

for CapID = CapIDs
    [ allResConcs,allCapConcs,total_aVoff,total_aIoff,std_total_aVoff, std_total_aIoff,VoltageGradient, CurrentGradient,std_mean_error_V,std_mean_error_I] = ca_selectivity(CapID);   
    x = [x, allCapConcs./allResConcs];
    y = [y, total_aVoff];
    colInd = [colInd, allCapConcs];
end
close all;

x = log10(x);

figure;
pointsize = 40;
colInd = abs(log10(colInd));
scatter(x, y,pointsize,colInd)


end
