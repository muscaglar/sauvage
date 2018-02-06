function [ output_args ] = ComparePeakLocations( SearchStrings )
%COMPARE Summary of this function goes here
%   Pass in a cell array of search strings

%load 2 or multiple sets of peaks  - would be better as comparisons.
X = 1200:1:3000;

figure(30)
hold off;
figure(31)
hold off;
Set = 0;
for m = 1:length(SearchStrings);
    SearchString =SearchStrings{m}; % ['sSuppressed = 7 AND ' ConcatVectorToSQL( m, 'Membrane')];
    [ PeakStatsG, PeakStats2D, PeakStatsD, Ratio2DtoGStats, RatioDtoGStats, NoSpectra ] = RamanPeakLocations( SearchString );
    
    %Now plot  - NB - can either plot peak position as normal distribution
    %or plot the lorentizian of that peak, with ideally shading shwoing the
    %limits
    Set = Set + 1;
    Peaks = [];
    
    if(NoSpectra > 0)
        figure(30)
        Err = 7;% or 3
        if ~isempty(PeakStats2D)
            X2d = 2670:0.1:2730;
            Norm2DLoc = normpdf(X2d,PeakStats2D(1,2),PeakStats2D(1,Err));
            subplot(2,2,1)
            plot(X2d,Norm2DLoc ,ColourWheel(Set));
            title('2D Peak position')
            hold all;
            Norm2DScale = normpdf([10:0.1:30],PeakStats2D(2,2),PeakStats2D(2,Err));
            subplot(2,2,2)
            title('2D Peak width')
            plot([10:0.1:30],Norm2DScale ,ColourWheel(Set));
            hold all;
            
            Peaks = [Peaks; PeakStats2D(1,2) PeakStats2D(2,2) 1];
            
        end
        if ~isempty(PeakStatsG)
            Xg = 1559:0.1:1650;
            NormGLoc = normpdf(Xg,PeakStatsG(1,2),PeakStatsG(1,Err));
            
            subplot(2,2,3);
            plot(Xg,NormGLoc ,ColourWheel(Set));
            title('G Peak position')
            hold all;
            NormGScale = normpdf([10:0.1:30],PeakStatsG(2,2),PeakStatsG(2,Err));
            subplot(2,2,4)
            plot([10:0.1:30],NormGScale ,ColourWheel(Set));
            title('G peak width')
            hold all;
            
            Peaks = [Peaks; PeakStatsG(1,2) PeakStatsG(2,2) 1/(Ratio2DtoGStats(1,2))];
            
        end
        if ~isempty(PeakStatsD)
            NormDLoc = normpdf(1350:0.5:1450,PeakStatsD(1,2),PeakStatsD(1,Err)); 
            
            Peaks = [Peaks; PeakStatsD(1,2) PeakStatsD(2,2) 1*RatioDtoGStats(1,2)/(Ratio2DtoGStats(1,2))];
        end
        
        hold all;
        
        figure(31)
        
        
        %     %Peaks(:,3) = [1 (1/Ratio2DtoGStats(1,2)) 1*RatioDtoGStats(1,2)/Ratio2DtoGStats(1,2)];
        %     Peaks(:,3) = [1 1 1];

        [ SimulatedSpectra ] = GFittedSpectra( X', Peaks);
        plot(X,SimulatedSpectra(:,2),ColourWheel(Set));
         hold all;
        
        %Now group the data
        AvgPeaks2D = [AvgPeaks2D; ];
        AvgPeaksG = [AvgPeaksG; ];
        AvgPeaksD = [AvgPeaksD;];
        
        disp(['Membrane Set: ' num2str(m) ' 2D Peak: ' num2str(PeakStats2D(1,2)) ' +/- ' num2str(PeakStats2D(1,7),3) ' cm-1. Scale: ' num2str(PeakStats2D(2,2),3) ' +/- ' num2str(PeakStats2D(2,7),3) ' G Peak: ' num2str(PeakStatsG(1,2)) ' +/- ' num2str(PeakStatsG(1,7),3) ' cm-1. Scale: ' num2str(PeakStatsG(2,2),3) ' +/- ' num2str(PeakStatsG(2,7),3) ' 2DtoG: ' num2str(Ratio2DtoGStats(2),3) ' +/- ' num2str(Ratio2DtoGStats(7),3)  ' from ' num2str(PeakStatsG(1,4)) ' points'])
    end
end

end

