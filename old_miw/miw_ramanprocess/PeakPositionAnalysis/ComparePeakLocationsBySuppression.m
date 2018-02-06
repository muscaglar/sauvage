%% Example ComparePeakLocationsBySuppression( 56, [0 7])
%% Or ComparePeakLocationsBySuppression( 56, [0 7], ' Date LIKE ''2016-10-13'' ')
function [ output_args ] = ComparePeakLocationsBySupression( MembraneID, SuppressionCodes , ExtraTerm)
%COMPARE Summary of this function goes here
%   Detailed explanation goes here

for i = 1:length(SuppressionCodes);
    s =  SuppressionCodes(i);
    if nargin > 2
        SearchStrings{i} = ['Membrane = ' num2str(MembraneID) ' AND ' ConcatVectorToSQL( s, 'sSuppressed') ' AND ' ExtraTerm];
    else
        SearchStrings{i} = ['Membrane = ' num2str(MembraneID) ' AND ' ConcatVectorToSQL( s, 'sSuppressed')];
    end
end

ComparePeakLocations( SearchStrings );


end

