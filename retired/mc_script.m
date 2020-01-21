 G41 = [395,396];
 
 hBN_pH8 = [232 233];
 hBN_pH6 = [223 224];
 hBN = [394,401,403,404]; %Suppress some points in 401?
 
 hBN_Ozone = [405 406 408 409];
 hBN_Al2O3 = [413 445 446];
 
 hBN_as_grown = horzcat(hBN, hBN_pH6, hBN_pH8);
 
 bare = [402];
 
 mw_G41 = [206,207];
 mw_G41_Al2O3 = [250,251];
 mw_G41_Ozone = [240, 241];
 
 G41_as_grown = horzcat(G41,mw_G41);
 
 lacl3_bare = [475, 478, 479, 480, 486, 487, 488,  476, 477];
 lacl3_BG_0_01 = [514, 516:517];
 lacl3_BG_0_1 = [459:460, 502:504];
 lacl3_BG_1= [457:458,495:501];
 lacl3_BG_2 = 523;

 lacl3_4M = [612, 613, 616, 617, 618];
 lacl3_3M = [627, 628];
 lacl3_2M = [489, 490, 629, 630, 631 , 632, 633, 635, 636, 637];
 lacl3_1M = [454, 455, 456];
 lacl3_0_1M = [451, 452];
 lacl3_0_01M = 453;

 CeCl3_0_1M = [567:569];
 
 %PlotSealAnalysisByCapillaries(hBN)
 %PlotSealAnalysisByCapillaries(hBN_Ozone)
 %PlotSealAnalysisByCapillaries(hBN_Al2O3)
 
 
 
 
 
%DNA
%CapillaryTranslocationAnalysis([681:682]);   This analyses and uploades
%trace DNA data

