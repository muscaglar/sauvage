function [ ] = GrapheneRamanToOrigin() %Capillary, bias )
    
    FileRoots;
    [FileName, PathName] = uigetfile({'*.txt;*.csv','Spectral Files';},'Choose Spectra File',SpectraRoot);

    data = dlmread([PathName '/' FileName]);

    RamanShift = data(:,1);%data(1:2:end,:);
    count = data(:,2); %data(2:2:end,:);

    smoothY = sgolayfilt(count, 2, 27);
    P = polyfit(RamanShift(1:2315),smoothY(1:2315),1);
    yfit = P(1)*RamanShift + P(2); 
    count = smoothY - yfit;
    
    %%%
    %Expected Peaks -> Find maxima in these regions
    % 2D: 2600-2750
    % G: 1500-1750 (neglecting D' just after)
    % D: 1250-1500
    % D+G: 2750 - 3000
    %%%
    
    DDlow = 2400;   DDhigh = 2900;
    Glow = 1500;    Ghigh = 1750;
    Dlow = 1250;    Dhigh = 1500;
    DGlow = 2800;   DGhigh = 3500;
 
    % Find the closest wavelength index, perfom a maxima search
    
    DD = find(count == max(count(RamanShift>DDlow & RamanShift < DDhigh)));
    G = find(count == max(count(RamanShift>Glow & RamanShift < Ghigh)));
    D = find(count == max(count(RamanShift>Dlow & RamanShift < Dhigh)));
    DG = find(count == max(count(RamanShift>DGlow & RamanShift < DGhigh)));
    
    %% Lorentzian  
    
    size_count = size(count);
    lorenz_count = zeros(size_count(1),1);
    
    Params(:,1) = RamanShift(DD);
    scale_DD = 10; %FWHM
    Params(:,2) = scale_DD; %scale;
    area_DD = scale_DD * max(count(RamanShift>DDlow & RamanShift < DDhigh)); %area;
    Params(:,3) = area_DD;
    [location_DD, scale_DD, area_DD, FinalResids, Y_fit_DD]  = LorentizianFit(RamanShift(RamanShift>DDlow & RamanShift < DDhigh), count(RamanShift>DDlow & RamanShift < DDhigh), Params);
    lorenz_count(RamanShift>DDlow & RamanShift < DDhigh) = lorenz_count(RamanShift>DDlow & RamanShift < DDhigh) + Y_fit_DD;
    
    Params(:,1) = RamanShift(DG);
    scale_DG =100 ;
    Params(:,2) = scale_DG; %scale;
    area_DG = scale_DG * max(count(RamanShift>DGlow & RamanShift < DGhigh)); %area;
    Params(:,3) = area_DG;
    [location_DG, scale_DG, area_DG, FinalResids, Y_fit_DG]  = LorentizianFit(RamanShift(RamanShift>DGlow & RamanShift < DGhigh), count(RamanShift>DGlow & RamanShift < DGhigh), Params);
    lorenz_count(RamanShift>DGlow & RamanShift < DGhigh) =   lorenz_count(RamanShift>DGlow & RamanShift < DGhigh)  + Y_fit_DG;
    
    Params(:,1) = RamanShift(G);
    scale_G = 10;
    Params(:,2) = scale_G; %scale;
    area_G = scale_G * max(count(RamanShift>Glow & RamanShift < Ghigh)); %area;
    Params(:,3) = area_G;
    [location_G, scale_G, area_G, FinalResids, Y_fit_G]  = LorentizianFit(RamanShift(RamanShift>Glow & RamanShift < Ghigh), count(RamanShift>Glow & RamanShift < Ghigh), Params);
    lorenz_count(RamanShift>Glow & RamanShift < Ghigh) = lorenz_count(RamanShift>Glow & RamanShift < Ghigh) + Y_fit_G;
    
    Params(:,1) = RamanShift(D);
    scale_D =10;
    Params(:,2) = scale_D; %scale;
    area_D = scale_D * max(count(RamanShift>Dlow & RamanShift < Dhigh)); %area;
    Params(:,3) = area_D;
    x = RamanShift(RamanShift>DDlow & RamanShift < Dhigh);
    if(x)
    [location_D, scale_D, area_D, FinalResids, Y_fit_D]  = LorentizianFit(RamanShift(RamanShift>DDlow & RamanShift < Dhigh), count(RamanShift>Dlow & RamanShift < Dhigh), Params);
       lorenz_Y = Lorentzian(RamanShift, [location_DD, location_DG, location_G,location_D],[scale_DD,scale_DG,scale_G,scale_D],[area_DD,area_DG,area_G,area_D]);
    else
            lorenz_Y = Lorentzian(RamanShift, [location_DD, location_DG, location_G],[scale_DD,scale_DG,scale_G],[area_DD,area_DG,area_G]);
    
%    [ Y ] = Lorentzian( RamanShift,location_DD, scale_DD, area_DD);
%    [ Y ] = Y +  Lorentzian( RamanShift,location_DG, scale_DG, area_DG);
%    [ Y ] = Y +  Lorentzian( RamanShift,location_D, scale_D, area_D);
%    [ Y ] = Y +  Lorentzian( RamanShift,location_G, scale_G, area_G);

%plot(RamanShift,lorenz_count)
%plot(RamanShift,lorenz_Y)
  
%Plot in Origin
    ORG = Matlab2OriginPlot();
    
    %Plot the points for offset
    ORG.Figure(['Raman']);
    ORG.HoldOn;
    %ORG.PlotScatter(RamanShift', count',['Count'],'LT Magenta');
    ORG.PlotLine(RamanShift', count',['Count'],'LT Magenta');
    ORG.xlabel('Raman Shift','cm^-1');
    ORG.ylabel('Counts','arb units');
    ORG.yComment('Counts');
        ORG.AddDataAnnotation(['2D Peak -' num2str(RamanShift(DD))],RamanShift(DD)-200,count(DD)+200);
        ORG.AddDataAnnotation(['D Peak -' num2str(RamanShift(D))],RamanShift(D)-200,count(D)+200);
        ORG.AddDataAnnotation(['G Peak -' num2str(RamanShift(G))],RamanShift(G)-200,count(G)+200);
        ORG.AddDataAnnotation(['D-G Peak -' num2str(RamanShift(DG))],RamanShift(DG)-200,count(DG)+200);
    ORG.title(['Raman']);
    ORG.HideActiveWkBk()
            ORG.ExecuteLabTalk('layer.x.from = 1250');
            ORG.ExecuteLabTalk('layer.x.to = 3250'); %xaxisTo function in M2O
    ORG.HoldOff;
    
    %Plot the points for offset
    ORG.Figure(['Raman_Lorentzian']);
    ORG.HoldOn;
    %ORG.PlotScatter(RamanShift', count',['Count'],'LT Magenta');
    ORG.PlotLine(RamanShift', lorenz_Y',['Count'],'LT Magenta');
    ORG.xlabel('Raman Shift','cm^-1');
    ORG.ylabel('Counts','arb units');
    ORG.yComment('Counts');
        ORG.AddDataAnnotation(['2D Peak -' num2str(location_DD)],location_DD -200,lorenz_Y(DD));
                if(x)
        ORG.AddDataAnnotation(['D Peak -' num2str(location_D)],location_D-200,lorenz_Y(D));
                end
        ORG.AddDataAnnotation(['G Peak -' num2str(location_G)],location_G-200,lorenz_Y(G));
        ORG.AddDataAnnotation(['D-G Peak -' num2str(location_DG)],location_DG -200,lorenz_Y(DG));
    ORG.title(['Raman_Lorentzian']);
    ORG.HideActiveWkBk()
            ORG.ExecuteLabTalk('layer.x.from = 1250');
            ORG.ExecuteLabTalk('layer.x.to = 3250'); %xaxisTo function in M2O
            ORG.ExecuteLabTalk('layer.y.from = -100');
            ORG.ExecuteLabTalk('layer.y.to = 3400'); 
    ORG.HoldOff;    
    
    ORG.Disconnect();
    
    %% To do - 

end