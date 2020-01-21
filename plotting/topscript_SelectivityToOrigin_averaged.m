caps_ZrCl4;
membrane = 'gr';
salt = 'zr';

output = [];

conc = 1000;
[V1,V1er,I1,I1er] = SelectivityToOrigin_averaged(zrcl4_1M,membrane,[membrane,'_',salt,'_',num2str(conc)]);
output(1,:) = [conc,V1(1),V1er(1),I1(1),I1er(1)]; 
conc = 100;
[V1,V1er,I1,I1er] = SelectivityToOrigin_averaged(zrcl4_100mM,membrane,[membrane,'_',salt,'_',num2str(conc)]);
output(2,:) = [conc,V1(1),V1er(1),I1(1),I1er(1)]; 
conc = 10;
[V1,V1er,I1,I1er] = SelectivityToOrigin_averaged(zrcl4_10mM,membrane,[membrane,'_',salt,'_',num2str(conc)]);
output(3,:) = [conc,V1(1),V1er(1),I1(1),I1er(1)];
go_to_Origin(output,[membrane,'_',salt]); clear all;

disp('KCl');  pause;

caps_KCl;
membrane = 'gr';
salt = 'kcl';
output = [];

conc = 1000;
[V1,V1er,I1,I1er] = SelectivityToOrigin_averaged(kcl_1M,membrane,[membrane,'_',salt,'_',num2str(conc)]);
output(1,:) = [conc,V1(1),V1er(1),I1(1),I1er(1)]; conc = 100;
[V1,V1er,I1,I1er] = SelectivityToOrigin_averaged(kcl_100mM,membrane,[membrane,'_',salt,'_',num2str(conc)]);
output(2,:) = [conc,V1(1),V1er(1),I1(1),I1er(1)]; conc = 10;
[V1,V1er,I1,I1er] = SelectivityToOrigin_averaged(kcl_10mM,membrane,[membrane,'_',salt,'_',num2str(conc)]);
output(3,:) = [conc,V1(1),V1er(1),I1(1),I1er(1)]; conc = 1;
[V1,V1er,I1,I1er] = SelectivityToOrigin_averaged(kcl_1mM,membrane,[membrane,'_',salt,'_',num2str(conc)]);
output(4,:) = [conc,V1(1),V1er(1),I1(1),I1er(1)];
go_to_Origin(output,[membrane,'_',salt]); clear all;

disp('LiCl');  pause;

caps_LiCl;
membrane = 'gr';
salt = 'licl';
output = [];

conc = 100;
[V1,V1er,I1,I1er] = SelectivityToOrigin_averaged(licl_100mM,membrane,[membrane,'_',salt,'_',num2str(conc)]);
output(1,:) = [conc,V1(1),V1er(1),I1(1),I1er(1)]; 
go_to_Origin(output,[membrane,'_',salt]); clear all;

disp('BKCl');  pause;

caps_BKCl;
membrane = 'gr';
salt = 'bkcl';
output = [];

conc = 1000;
[V1,V1er,I1,I1er] = SelectivityToOrigin_averaged(KCl_B_1M,membrane,[membrane,'_',salt,'_',num2str(conc)]);
output(1,:) = [conc,V1(1),V1er(1),I1(1),I1er(1)]; conc = 100;
[V1,V1er,I1,I1er] = SelectivityToOrigin_averaged(KCl_B_100mM,membrane,[membrane,'_',salt,'_',num2str(conc)]);
output(2,:) = [conc,V1(1),V1er(1),I1(1),I1er(1)]; conc = 10;
[V1,V1er,I1,I1er] = SelectivityToOrigin_averaged(KCl_B_10mM,membrane,[membrane,'_',salt,'_',num2str(conc)]);
output(3,:) = [conc,V1(1),V1er(1),I1(1),I1er(1)]; 
go_to_Origin(output,[membrane,'_',salt]); clear all;

disp('Cecl3');  pause;

caps_CeCl3;
membrane = 'gr';
salt = 'cecl3';
output = [];

conc = 3000;
[V1,V1er,I1,I1er] = SelectivityToOrigin_averaged(cecl3_3M,membrane,[membrane,'_',salt,'_',num2str(conc)]);
output(1,:) = [conc,V1(1),V1er(1),I1(1),I1er(1)]; conc = 2000;
[V1,V1er,I1,I1er] = SelectivityToOrigin_averaged(cecl3_2M,membrane,[membrane,'_',salt,'_',num2str(conc)]);
output(2,:) = [conc,V1(1),V1er(1),I1(1),I1er(1)]; conc = 1000;
[V1,V1er,I1,I1er] = SelectivityToOrigin_averaged(cecl3_1M,membrane,[membrane,'_',salt,'_',num2str(conc)]);
output(3,:) = [conc,V1(1),V1er(1),I1(1),I1er(1)]; conc = 100;
[V1,V1er,I1,I1er] = SelectivityToOrigin_averaged(cecl3_100mM,membrane,[membrane,'_',salt,'_',num2str(conc)]);
output(4,:) = [conc,V1(1),V1er(1),I1(1),I1er(1)]; conc = 10;
[V1,V1er,I1,I1er] = SelectivityToOrigin_averaged(cecl3_10mM_cation,membrane,[membrane,'_cat_',salt,'_',num2str(conc)]);
output(5,:) = [conc,V1(1),V1er(1),I1(1),I1er(1)]; conc = 10;
[V1,V1er,I1,I1er] = SelectivityToOrigin_averaged(cecl3_10mM_anion,membrane,[membrane,'_an_',salt,'_',num2str(conc)]);
output(6,:) = [conc,V1(1),V1er(1),I1(1),I1er(1)]; conc = 1;
[V1,V1er,I1,I1er] = SelectivityToOrigin_averaged(cecl3_1mM,membrane,[membrane,'_',salt,'_',num2str(conc)]);
output(7,:) = [conc,V1(1),V1er(1),I1(1),I1er(1)]; 
go_to_Origin(output,[membrane,'_',salt]); clear all;

disp('Lacl3');  pause;

caps_LaCl3;
membrane = 'gr';
salt = 'lacl3';
output = [];

conc = 4000;
[V1,V1er,I1,I1er] = SelectivityToOrigin_averaged(lacl3_4M,membrane,[membrane,'_',salt,'_',num2str(conc)]);
output(1,:) = [conc,V1(1),V1er(1),I1(1),I1er(1)]; conc = 3000;
[V1,V1er,I1,I1er] = SelectivityToOrigin_averaged(lacl3_3M,membrane,[membrane,'_',salt,'_',num2str(conc)]);
output(2,:) = [conc,V1(1),V1er(1),I1(1),I1er(1)]; conc = 2000;
[V1,V1er,I1,I1er] = SelectivityToOrigin_averaged(lacl3_2M,membrane,[membrane,'_',salt,'_',num2str(conc)]);
output(3,:) = [conc,V1(1),V1er(1),I1(1),I1er(1)]; conc = 1000;
[V1,V1er,I1,I1er] = SelectivityToOrigin_averaged(lacl3_1M,membrane,[membrane,'_',salt,'_',num2str(conc)]);
output(4,:) = [conc,V1(1),V1er(1),I1(1),I1er(1)]; conc = 100;
[V1,V1er,I1,I1er] = SelectivityToOrigin_averaged(lacl3_100mM,membrane,[membrane,'_',salt,'_',num2str(conc)]);
output(5,:) = [conc,V1(1),V1er(1),I1(1),I1er(1)]; conc = 10;
[V1,V1er,I1,I1er] = SelectivityToOrigin_averaged(lacl3_10mM_cation,membrane,[membrane,'_cat_',salt,'_',num2str(conc)]);
output(6,:) = [conc,V1(1),V1er(1),I1(1),I1er(1)]; conc = 10;
[V1,V1er,I1,I1er] = SelectivityToOrigin_averaged(lacl3_10mM_anion,membrane,[membrane,'_an_',salt,'_',num2str(conc)]);
output(7,:) = [conc,V1(1),V1er(1),I1(1),I1er(1)]; conc = 1;
[V1,V1er,I1,I1er] = SelectivityToOrigin_averaged(lacl3_1mM,membrane,[membrane,'_',salt,'_',num2str(conc)]);
output(8,:) = [conc,V1(1),V1er(1),I1(1),I1er(1)]; 
go_to_Origin(output,[membrane,'_',salt]); clear all;

disp('alacl3');  pause;

caps_LaCl3;
membrane = 'gr';
salt = 'alacl3';
output = [];

conc = 1000;
[V1,V1er,I1,I1er] = SelectivityToOrigin_averaged(alacl3_1M,membrane,[membrane,'_',salt,'_',num2str(conc)]);
output(1,:) = [conc,V1(1),V1er(1),I1(1),I1er(1)]; conc = 100;
[V1,V1er,I1,I1er] = SelectivityToOrigin_averaged(alacl3_100mM,membrane,[membrane,'_',salt,'_',num2str(conc)]);
output(2,:) = [conc,V1(1),V1er(1),I1(1),I1er(1)]; conc = 10;
[V1,V1er,I1,I1er] = SelectivityToOrigin_averaged(alacl3_10mM,membrane,[membrane,'_cat_',salt,'_',num2str(conc)]);
output(3,:) = [conc,V1(1),V1er(1),I1(1),I1er(1)]; conc = 1;
[V1,V1er,I1,I1er] = SelectivityToOrigin_averaged(alacl3_1mM,membrane,[membrane,'_',salt,'_',num2str(conc)]);
output(4,:) = [conc,V1(1),V1er(1),I1(1),I1er(1)]; 
go_to_Origin(output,[membrane,'_',salt]); clear all;

disp('K3Po4');  pause;

caps_K3PO4;
membrane = 'gr';
salt = 'k3po4';
output = [];

conc = 1000;
[V1,V1er,I1,I1er] = SelectivityToOrigin_averaged(K3PO4_1M,membrane,[membrane,'_',salt,'_',num2str(conc)]);
output(1,:) = [conc,V1(1),V1er(1),I1(1),I1er(1)]; conc = 100;
[V1,V1er,I1,I1er] = SelectivityToOrigin_averaged(K3PO4_100mM,membrane,[membrane,'_',salt,'_',num2str(conc)]);
output(2,:) = [conc,V1(1),V1er(1),I1(1),I1er(1)]; conc = 10;
[V1,V1er,I1,I1er] = SelectivityToOrigin_averaged(K3PO4_10mM,membrane,[membrane,'_cat_',salt,'_',num2str(conc)]);
output(3,:) = [conc,V1(1),V1er(1),I1(1),I1er(1)]; 
go_to_Origin(output,[membrane,'_',salt]); clear all;

disp('HfCl4');  pause;

caps_HfCl4;
membrane = 'gr';
salt = 'hfcl4';
output = [];

conc = 1000;
[V1,V1er,I1,I1er] = SelectivityToOrigin_averaged(hfcl4_1M,membrane,[membrane,'_',salt,'_',num2str(conc)]);
output(1,:) = [conc,V1(1),V1er(1),I1(1),I1er(1)]; conc = 100;
[V1,V1er,I1,I1er] = SelectivityToOrigin_averaged(hfcl4_100mM,membrane,[membrane,'_',salt,'_',num2str(conc)]);
output(2,:) = [conc,V1(1),V1er(1),I1(1),I1er(1)]; conc = 10;
[V1,V1er,I1,I1er] = SelectivityToOrigin_averaged(hfcl4_10mM,membrane,[membrane,'_cat_',salt,'_',num2str(conc)]);
output(3,:) = [conc,V1(1),V1er(1),I1(1),I1er(1)]; conc = 1;
[V1,V1er,I1,I1er] = SelectivityToOrigin_averaged(hfcl4_1mM,membrane,[membrane,'_',salt,'_',num2str(conc)]);
output(4,:) = [conc,V1(1),V1er(1),I1(1),I1er(1)]; 
go_to_Origin(output,[membrane,'_',salt]); clear all;

