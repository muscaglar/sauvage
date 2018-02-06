function [ PeakStatsG, PeakStats2D, PeakStatsD,  Ratio2DtoGStats, RatioDtoGStats,NoSpectra ] = RamanPeakLocations( SearchTerm )
%RAMANPEAKLOCATIONS 
%Return Vectors of the Mean, std, std err etc for each of the peaks
%the different peaks

%Either pass in spectra IDs or pass in a search term.
DB = DBConnection;
S = Spectra(DB);

S.SELECT(SearchTerm);
%SearchTerm
PeaksG = [];
Peaks2D = [];
PeaksD = [];
Ratio2DtoG = [];
RatioDtoG = [];

n = 0;
if S.getid() > 0
    isNext = 1;
    while isNext
        %Now read out all the membrane values
        %only accept if the two peaks are identified and no Layers = 1
        
        PeaksG = [PeaksG; S.getLocG S.getScaleG, S.getAreaG];
        Peaks2D = [Peaks2D;  S.getLoc2D S.getScale2D, S.getArea2D];
        PeaksD = [PeaksD; S.getLocD S.getScaleD, S.getAreaD];
        
        Ratio2DtoG = [Ratio2DtoG; S.getRatio2DG];
        RatioDtoG = [RatioDtoG; S.getRatioD2G];
        n = n + 1;
    
        isNext = S.NextResult;
    end
end
NoSpectra = n;
if n > 0
    %nb ideally exclude 0 points
    %Now calc the statitics values  - could exclude clear outliers

    [ PeakStatsG ] = PeakStatistics( PeaksG );
    [ PeakStats2D ] = PeakStatistics( Peaks2D );
    [ PeakStatsD ] = PeakStatistics( PeaksD );
    
    Ratio2DtoGStats = PeakStatistics(  Ratio2DtoG );
    RatioDtoGStats = PeakStatistics( RatioDtoG );
    
else
    %No good results found
    disp(['No Spectra for this search term:' SearchTerm])
    PeakStatsG = []; PeakStats2D = []; PeakStatsD= [];  Ratio2DtoGStats= []; RatioDtoGStats = [];
end
end

