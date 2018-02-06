 
hBN_pH8 = [232 233];
hBN_pH6 = [223 224];
 
hBN = [394,401,403,404]; %Suppress some points in 401?
 
hBN_Ozone = [405 406 408 409 712 713];
 
hBN_Al2O3 = [413 445 446 714];
 
hBN_as_grown = horzcat(hBN, hBN_pH6, hBN_pH8);

bare = [402];
 
G41 = [395,396];
 
mw_G41 = [206,207];
mw_G41_Al2O3 = [250,251];
mw_G41_Ozone = [240, 241];
 
G41_as_grown = horzcat(G41,mw_G41);