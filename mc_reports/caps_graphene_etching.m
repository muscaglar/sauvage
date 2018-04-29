% The graphene etching seems like a good idea. Read through E. Chalken's
% report.
% 
% damanged_graphene_0_etch = 340;
% damanged_graphene_30_etch = 341;
% damanged_graphene_60_etch = 342;
% damanged_graphene_120_etch = 343;
% damanged_graphene_240_etch = 344;
% damanged_graphene_360_etch = 345;
% damanged_graphene_480_etch = 346;
% damanged_graphene_720_etch = 347;
% damanged_graphene_1080_etch = 348;
% damanged_graphene_1320_etch = 349;
% damanged_graphene_1920_etch = 350;
% 
% selecs = [];
% j= 1;
% selecs_time = [0,30,60,120,240,360,480,720,1080,1320,1920];
% for i = 340:350
%     ans = Selectivity(i);
%     close all;
%     selecs(j) = ans(1);
%     j = j + 1;
% end
% 
% selec_normalised = selecs - selecs(1);
% selec_normalised = selecs ./ selecs(1);
% selec_normalised = selec_normalised - 1;
% scatter(selecs_time, selec_normalised);

% graphene_60_etch = 353;
% graphene_120_etch = 354;
% graphene_180_etch = 355;
% graphene_240_etch = 356;
% graphene_360_etch = 357;
% graphene_600_etch = 358;
% graphene_900_etch = 359;
% graphene_1800_etch = 360;
% 
% selecs = [];
% j= 1;
% selecs_time = [60,120,180,240,360,600,900,1800];
% for i = 353:360
%     ans = Selectivity(i);
%     close all;
%     selecs(j) = ans(1);
%     j = j + 1;
% end
% 
% selec_normalised = selecs - selecs(1);
% selec_normalised = selecs ./ selecs(1);
% selec_normalised = selec_normalised - 1;
% scatter(selecs_time, selec_normalised);


%  361, 2016-05-05, C, 30, C03  0 Minutes etching, 4, 0 
%  362, 2016-05-05, C, 31, C03a 30 sec etch, 4,  30
%  363, 2016-05-05, C, 32, C03b 1.5 min etch, 4,  90
%  364, 2016-05-05, C, 33, 2.5 min etch, 4,   150
%  365, 2016-05-05, C, 34, C03d 4.5 min etch, 4, 270  
%  366, 2016-05-05, C, 35, C03e 8.5 min etch, 4,  510
%  367, 2016-05-05, C, 36, C03f 14.5 min etch, 4,  870

% selecs = [];
% j= 1;
% selecs_time = [0,30,90,150,270,510,870];
% for i = 361:367
%     ans = Selectivity(i);
%     close all;
%     selecs(j) = ans(1);
%     j = j + 1;
% end
% 
% selec_normalised = selecs - selecs(1);
% selec_normalised = selecs ./ selecs(1);
% selec_normalised = selec_normalised - 1;
% scatter(selecs_time, selec_normalised);

%  368, 2016-05-06, C, 20, C02 0 min etching, 4,  
%  369, 2016-05-06, C, 21, C02a 30 sec etching, 4,  
%  370, 2016-05-06, C, 22, C02b 1.5 min etching, 4,
%  371, 2016-05-06, C, 3, C03 0 min etching, 4,  
%  372, 2016-05-06, C, 31, C03a 1 min etching, 4,  
%  373, 2016-05-06, C, 32, C03b 5 min total etching, 4,  
%  374, 2016-05-06, C, 33, C03c 10 min total etching, 4,  
%  375, 2016-05-06, C, 34, C03d 15 min total etching, 4,  
%  376, 2016-05-06, C, 35, C03e 20 min total etching, 4, 