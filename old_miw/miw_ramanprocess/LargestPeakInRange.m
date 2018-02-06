function [ index, maxPeakheight, locationMax, scaleMax, areaMax ] = LargestPeakInRange( location, scale, area, startR, endR )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
nPeaks = max(size(location));

maxPeakheight = 0;
index = 0;
for i = 1:nPeaks
   %Loop through each peak  - find the largest in the range  - or the heighest height
    if location(i) > startR && location(i) < endR
        ThisPeak = Lorentzian( location(i), location(i), scale(i), area(i) );
        if  ThisPeak > maxPeakheight && abs(scale(i)) >  5
           index = i;
           maxPeakheight = ThisPeak;
        end
    end
end
if index > 0
    locationMax = location(index);
    scaleMax = scale(index);
    areaMax = area(index);
else
    %If there are no peaks then set all the values to 0
    locationMax = 0;
    scaleMax = 0;
    areaMax = 0;
end
end

