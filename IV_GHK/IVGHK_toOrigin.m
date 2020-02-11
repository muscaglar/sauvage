function [] = IVGHK_toOrigin(input,name)

    ORG = Matlab2OriginPlot();
    ORG.MatrixToOrigin(input, name);
    
    %1 Y
    %2 Nothing
    %3 Yerr
    %4 X
    
    ORG.ExecuteLabTalk('wks.col1.lname$ = Current (nA);');
    ORG.ExecuteLabTalk('wks.col1.type = 1;');

    ORG.ExecuteLabTalk('wks.col2.lname$ = Voltage (mV);');
    ORG.ExecuteLabTalk('wks.col2.type = 4;');

    ORG.ExecuteLabTalk('wks.col3.lname$ = Current Error (nA);');
    ORG.ExecuteLabTalk('wks.col3.type = 3;');

    ORG.ExecuteLabTalk('wks.col4.lname$ = Voltage Fit (mV);');
    ORG.ExecuteLabTalk('wks.col4.type = 4;');

    ORG.ExecuteLabTalk('wks.col5.lname$ = Current Cation (nA);');
    ORG.ExecuteLabTalk('wks.col5.type = 1;');

    ORG.ExecuteLabTalk('wks.col6.lname$ = Current Anion (nA);');
    ORG.ExecuteLabTalk('wks.col6.type = 1;');

    ORG.ExecuteLabTalk('wks.col7.lname$ = Current Total (nA);');
    ORG.ExecuteLabTalk('wks.col7.type = 1;');
    
    ORG.Disconnect;
end