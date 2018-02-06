function [ output_args ] = ComparePeakLocationsByMembrane( Membranes, Membranes2 )
%COMPARE Summary of this function goes here
%   Detailed explanation goes here

if nargin < 2
    for i = 1:length(Membranes);
        m = Membranes(i);
        SearchStrings{i} = ['sSuppressed = 0 AND ' ConcatVectorToSQL( m, 'Membrane')];
    end
else
    SearchStrings{1} = ['sSuppressed = 0 AND ' ConcatVectorToSQL( Membranes, 'Membrane')];
    SearchStrings{2} = ['sSuppressed = 0 AND ' ConcatVectorToSQL( Membranes2, 'Membrane')];
end

ComparePeakLocations( SearchStrings );


end

