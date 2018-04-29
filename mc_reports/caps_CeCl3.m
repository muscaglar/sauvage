
cecl3_1mM = [699, 764]; % d: 751,752, 763

cecl3_10mM_cation = [680,741,757, 813, 808]; %  11.53
cecl3_10mM_anion = [756,696,759,762];        % -14.53 %A: 758, U:745,742,761, B:698, Rubbish: 697,812
cecl3_10mM_both = [761,746,760,810,805,806];

cecl3_10mM = [cecl3_10mM_cation,cecl3_10mM_anion,cecl3_10mM_both];  %Dubious 10mM: 805

cecl3_100mM = [570,571,743,744,749,750]; % -12, d: 567   -4, 569   4, 748   -4, 568   10, 740   9. 747 exhibits anion and cation
cecl3_1M = [765,768, 814, 815];   %-6         % d: 766, 767
cecl3_2M = [641, 642]; %-18
cecl3_3M = [678, 679]; %-12

cecl3_10mM_bare = [805, 809,811];

cecl3_combined = [cecl3_1mM,cecl3_10mM,cecl3_100mM,cecl3_1M,cecl3_2M,cecl3_3M];
