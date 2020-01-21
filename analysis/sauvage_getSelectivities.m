function [x,y,err,y2,err2] = sauvage_getSelectivities(names,varargin)

voltages = [];
voltageserr = [];

currents = [];
currentserr = [];
index = nargin - 1;
for i = 1:index
    %[~,~,~,~,~,~,VoltageGradient, CurrentGradient] = ca_selectivity(varargin{i}');
    [VoltageGradient, CurrentGradient, ~, ~, ~,~, ~, ~, ~ ] = Selectivity(varargin{i});
    voltages = [voltages,VoltageGradient(1)];
    voltageserr = [voltageserr, VoltageGradient(2)];
    currents = [currents,CurrentGradient(1)];
    currentserr = [currentserr,CurrentGradient(2)];
end
close all;

y=voltages;
err = voltageserr;
x = 1:length(y);

y2 = currents;
err2 = currentserr;

figure;
bar(x,y)
hold on;
errorbar(x,y,err,'.')
%names = {'CRHS'; 'ELLY'; 'LGWD'; 'ECFS'; 'THMS'};
set(gca,'xtick',[x],'xticklabel',names)
hold off;

figure;
bar(x,y2)
hold on;
errorbar(x,y2,err2,'.')
%names = {'CRHS'; 'ELLY'; 'LGWD'; 'ECFS'; 'THMS'};
set(gca,'xtick',[x],'xticklabel',names)

end
%[x,y,err] = compareSelectivities(lacl3_100mM,alacl3_100mM,zrcl4_100mM,hfcl4_100mM);
%compareSelectivities(lacl3_100mM,lacl3_1M,alacl3_100mM,alacl3_1M,zrcl4_100mM,zrcl4_1M,hfcl4_100mM,hfcl4_1M)