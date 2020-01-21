function [] = sauvage_bigExport_toOrigin(input, name)

ORG = Matlab2OriginPlot();
ORG.MatrixToOrigin(input, name);

ORG.ExecuteLabTalk('wks.col1.lname$ = Conc Ratio;');
ORG.ExecuteLabTalk('wks.col1.type = 4;');

ORG.ExecuteLabTalk('wks.col2.lname$ = Cap Conc;');
ORG.ExecuteLabTalk('wks.col2.type = 4;');

ORG.ExecuteLabTalk('wks.col3.lname$ = Nernst;');
ORG.ExecuteLabTalk('wks.col3.type = 1;');

ORG.ExecuteLabTalk('wks.col4.lname$ = Cap pH;');
ORG.ExecuteLabTalk('wks.col4.type = 1;');

ORG.ExecuteLabTalk('wks.col5.lname$ = Cap Sigma;');
ORG.ExecuteLabTalk('wks.col5.type = 1;');

ORG.ExecuteLabTalk('wks.col6.lname$ = Res Conc;');
ORG.ExecuteLabTalk('wks.col6.type = 1;');

ORG.ExecuteLabTalk('wks.col7.lname$ = Res pH;');
ORG.ExecuteLabTalk('wks.col7.type = 1;');

ORG.ExecuteLabTalk('wks.col8.lname$ = Res Sigma;');
ORG.ExecuteLabTalk('wks.col8.type = 1;');

ORG.ExecuteLabTalk('wks.col9.lname$ = Cation Valency;');
ORG.ExecuteLabTalk('wks.col9.type = 2;');

ORG.ExecuteLabTalk('wks.col10.lname$ = Cation Radii;');
ORG.ExecuteLabTalk('wks.col10.type = 2;');

ORG.ExecuteLabTalk('wks.col11.lname$ = Anion Valency;');
ORG.ExecuteLabTalk('wks.col11.type = 2;');

ORG.ExecuteLabTalk('wks.col12.lname$ = Anion Radii;');
ORG.ExecuteLabTalk('wks.col12.type = 2;');

ORG.ExecuteLabTalk('wks.col13.lname$ = Bare Resistance;');
ORG.ExecuteLabTalk('wks.col13.type = 1;');

ORG.ExecuteLabTalk('wks.col14.lname$ = Sealed Resistance;');
ORG.ExecuteLabTalk('wks.col14.type = 1;');

ORG.ExecuteLabTalk('wks.col15.lname$ = S_GHK;');
ORG.ExecuteLabTalk('wks.col15.type = 1;');

ORG.ExecuteLabTalk('wks.col16.lname$ = Anion Permeability;');
ORG.ExecuteLabTalk('wks.col16.type = 1;');

ORG.ExecuteLabTalk('wks.col17.lname$ = Cation Permeability;');
ORG.ExecuteLabTalk('wks.col17.type = 1;');

ORG.ExecuteLabTalk('wks.col18.lname$ = Permeability Ratio;');
ORG.ExecuteLabTalk('wks.col18.type = 1;');

ORG.ExecuteLabTalk('wks.col19.lname$ = Cap ID 2;');
ORG.ExecuteLabTalk('wks.col19.type = 2;');

ORG.ExecuteLabTalk('wks.col20.lname$ = Cap Conc 2;');
ORG.ExecuteLabTalk('wks.col20.type = 4;');

ORG.ExecuteLabTalk('wks.col21.lname$ = Res Conc 2;');
ORG.ExecuteLabTalk('wks.col21.type = 2;');

ORG.ExecuteLabTalk('wks.col22.lname$ = Conc Ratio;');
ORG.ExecuteLabTalk('wks.col22.type = 4;');

ORG.ExecuteLabTalk('wks.col23.lname$ = Nernst Potential;');
ORG.ExecuteLabTalk('wks.col23.type = 1;');

ORG.ExecuteLabTalk('wks.col24.lname$ = Nernst Potential Error;');
ORG.ExecuteLabTalk('wks.col24.type = 3;');

ORG.ExecuteLabTalk('wks.col25.lname$ = Nernst Curent;');
ORG.ExecuteLabTalk('wks.col25.type = 1;');

ORG.ExecuteLabTalk('wks.col26.lname$ = Nernst Current Error;');
ORG.ExecuteLabTalk('wks.col26.type = 3;');

ORG.ExecuteLabTalk('wks.col27.lname$ = Anion Max Nernst;');
ORG.ExecuteLabTalk('wks.col27.type = 2;');

ORG.ExecuteLabTalk('wks.col28.lname$ = Cation Max Nernst;');
ORG.ExecuteLabTalk('wks.col28.type = 2;');

ORG.ExecuteLabTalk('wks.col29.lname$ = Cap Conc 3;');
ORG.ExecuteLabTalk('wks.col29.type = 4;');

ORG.ExecuteLabTalk('wks.col30.lname$ = Conc Ratio 3;');
ORG.ExecuteLabTalk('wks.col30.type = 4;');

ORG.ExecuteLabTalk('wks.col31.lname$ = Nernst Potential 3;');
ORG.ExecuteLabTalk('wks.col31.type = 1;');

ORG.ExecuteLabTalk('wks.col32.lname$ = Nernst Potential Error 3;');
ORG.ExecuteLabTalk('wks.col32.type = 3;');

ORG.ExecuteLabTalk('wks.col33.lname$ = Nernst Current 3;');
ORG.ExecuteLabTalk('wks.col33.type = 1;');

ORG.ExecuteLabTalk('wks.col34.lname$ = Nernst Current Error 3;');
ORG.ExecuteLabTalk('wks.col34.type = 3;');

ORG.ExecuteLabTalk('wks.col35.lname$ = Averaged GHK;');
ORG.ExecuteLabTalk('wks.col35.type = 1;');

ORG.ExecuteLabTalk('wks.col36.lname$ = Cap Conc 4;');
ORG.ExecuteLabTalk('wks.col36.type = 4;');

ORG.ExecuteLabTalk('wks.col37.lname$ = Cap pH 4;');
ORG.ExecuteLabTalk('wks.col37.type = 4;');

ORG.ExecuteLabTalk('wks.col38.lname$ = Cap Sigma 4;');
ORG.ExecuteLabTalk('wks.col38.type = 2;');

ORG.ExecuteLabTalk('wks.col39.lname$ = Selectivity 4;');
ORG.ExecuteLabTalk('wks.col39.type = 1;');

ORG.ExecuteLabTalk('wks.col40.lname$ = Selectivity Error 4;');
ORG.ExecuteLabTalk('wks.col40.type = 3;');

ORG.ExecuteLabTalk('wks.col41.lname$ = Cap Conc 5;');
ORG.ExecuteLabTalk('wks.col41.type = 4;');

ORG.ExecuteLabTalk('wks.col42.lname$ = Res Conc 5;');
ORG.ExecuteLabTalk('wks.col42.type = 4;');

ORG.ExecuteLabTalk('wks.col43.lname$ = Conc Ratio 5;');
ORG.ExecuteLabTalk('wks.col43.type = 4;');

ORG.ExecuteLabTalk('wks.col44.lname$ = S_GHK;');
ORG.ExecuteLabTalk('wks.col44.type = 2;');

ORG.ExecuteLabTalk('wks.col45.lname$ = S_GHK;');
ORG.ExecuteLabTalk('wks.col45.type = 1;');
ORG.ExecuteLabTalk('csetvalue formula:= "sign(col(A44))*(log(abs(col(A44))))" col:=45;');

ORG.ExecuteLabTalk('wks.col46.lname$ = Cap ID;');
ORG.ExecuteLabTalk('wks.col46.type = 2;');

ORG.Disconnect;

end
% [Cap]
% [Res]
% [Cap]/[Res]
% GHK