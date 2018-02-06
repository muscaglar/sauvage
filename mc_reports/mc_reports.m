
hBN_Al2O3 = [413, 714];
hBN_Ozone = [405, 406, 408, 409, 712, 713];
hBN_As_grown = [394, 401, 403, 404];
hBN_pH6 = [223, 224];
hBN_pH8 = [232, 233];

hBN_all = [hBN_As_grown, hBN_Al2O3, hBN_Ozone, hBN_pH6, hBN_pH8];
hBN_all_mus = [hBN_As_grown, hBN_Al2O3, hBN_Ozone];

lacl3_001 = [453];
lacl3_01 = [451, 452];
lacl3_1 = [454, 455];
lacl3_2 = [489, 629:632, 635, 636]; %removed 637, 633
lacl3_3 = [627, 628];
lacl3_4 = [613, 617, 618];
lacl3_bare = [475, 478, 479, 486, 487, 488,  476, 477];
lacl3_bare_good = [479, 480, 487, 477];

lacl3_all = [lacl3_001, lacl3_01, lacl3_1, lacl3_2, lacl3_3, lacl3_4];

lacl3_bg_001 = [514,516,517];
lacl3_bg_01 = [459,460,502,503];
lacl3_bg_1 = [458,498:501];
lacl3_bg_2 = [523];

lacl3_bg_all = [lacl3_bg_001,lacl3_bg_01,lacl3_bg_1,lacl3_bg_2];

cecl3_0001 = [699];   %1mM
cecl3_001 = [680,741];%698    %10mM
    cecl3_01 = [570,743,744,749:750];   %100mM 568  740  747       748 is weak.
cecl3_2 = [641,642]; %2M
cecl3_3 = [678,679]; %3M

%dump: cecl3 0.1M 569
%dump cecl3 0.1M 567 as I think this is 'bare'
%dump: cecl3 0.1 570 does not cofnirm. Need another cap to see if this is a
%dud.   Suppressing 749 ( 9734, 9735, 9736), 750(9760)

cecl3_all = [cecl3_0001, cecl3_001, cecl3_01, cecl3_2, cecl3_3];

cecl3_good_ish = [567,568,679,678,641,570];

spermadine = [580,581];

FET_all = [545,546,552,553,560,561,562,576,577,588,589,590,596,597];
FET_10NM = [545,546,552,553,560,561,562,576];
FET_NoAU = [577];
FET_5NM = [588,589,590];
FET_Bare = [596,597];  %These are freespace / Bare! 

FET_good =[590];

lipid_all = [461:474];
lipid_KCl = [461, 462];
lipid_bare = [464];
lipid_other = [465:474];

