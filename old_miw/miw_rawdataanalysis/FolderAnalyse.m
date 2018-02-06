function [ FittedPhase ] = FolderAnalyse( PathName )
%UNTITLED2 Summary of this function goes here
%   Run the designed phase analyis on a folder - with given path
%   NB could implement different analysis depending on whcih is
%   approportiate - including translocation analysis   - not sure how to
%   tell it what to do!

if nargin == 0
    e = ConcatentateRawData([3 4]);
else
    disp(['Current Data Folder: ' PathName]);
    e = ConcatentateRawData([3 4],'N', PathName);
end

%Filter Data
[ data ] = LowPassFilter( e,   100 );
%Find Phases
%Find phases for the data broken up
[FittedPhase, Phase , PhaseHistogram, TimePeriod ] = PhaseAnalysis( data, 2000, 20000 );



end

