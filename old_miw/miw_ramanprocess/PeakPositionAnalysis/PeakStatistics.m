function [ PeakStats ] = PeakStatistics( Peaks )
%PEAKSTATISTICS Pass in Peaks as a matrix where columns [loc, scale, area]

 Peaks = Peaks(Peaks(:,1) ~= 0,:);
 [n,p] = size(Peaks);
 
 X_Values = 1:1:p;
 X = [];
 for i = 1:p
    X = [X; i*ones(n,1)];
 end

 [ PeakStats ] = YMeans_Error(X_Values, X, reshape(Peaks,[n*p,1]) );
PeakStats(PeakStats(:,3) == 0,3) = 0.1;
PeakStats(PeakStats(:,7) == 0,7) = 0.1;
 
end

