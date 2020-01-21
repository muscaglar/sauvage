figure;

% [newCapConcsLaCl3,newSelectivitiesLaCl3] = SelectivityVCapConc(lacl3_all, 'all', 0);
% [newCapConcsCeCl3,newSelectivitiesCeCl3] = SelectivityVCapConc(CeCl3_all, 'all', 0);
% [newCapConcsBG,newSelectivitiesBG] = Temp_BG_SelectivityVCapConc(BG_KCL_all, 'all',0);

figure;
hold on;
bar(log10(newCapConcsLaCl3),newSelectivitiesLaCl3(1,:));
errorbar(log10(newCapConcsLaCl3),newSelectivitiesLaCl3(1,:),newSelectivitiesLaCl3(2,:),'.');
%set(gca, 'XTick', log10(sort(newCapConcs)))
%set(gca, 'XTickLabel', sort(newCapConcs))
ylabel('Selectivity mV/log(M)')
xlabel('Capillary Concentration (M)')
title('All');

bar(log10(newCapConcsCeCl3),newSelectivitiesCeCl3(1,:));
errorbar(log10(newCapConcsCeCl3),newSelectivitiesCeCl3(1,:),newSelectivitiesCeCl3(2,:),'.');

bar(log10(newCapConcsBG),newSelectivitiesBG(1,:));
errorbar(log10(newCapConcsBG),newSelectivitiesBG(1,:),newSelectivitiesBG(2,:),'.');