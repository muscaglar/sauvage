function [  ] = help_mc_plotting()

fprintf('For a log scale histogram of selectivity versus capillary concentration use SelectivityVCapConc \n');
fprintf('This function takes a vector of capillary IDs \n');
fprintf('It assumes that capillary concentrations will contan some/only 3, 2, 1, 0.1, 0.01, 0.001\n');
fprintf('');
fprintf('IVPlotByCapillary will plot IV curves by either capillary ID or experiment number');
fprintf('thus provide a second argument of 1 if providing a capillary ID and 0 for experiment numbers.\n');
end