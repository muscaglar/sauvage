function [ AC_Crop ] = ACcrop( AC, MaxFreq, MinFreq )
%ACCROP Summary of this function goes here
%   Detailed explanation goes here

if nargin < 3
    MinFreq = 0;
end


l = size(AC,1);
if (AC(1,1) <= MinFreq )
    %Find the index locations (for nearest value)
    s=1;
    e=l;
    for i = 2:l
        if AC(i,1) > MinFreq
            s = i - 1;
            break
        end
    end
else
    s = 1;
end

if(AC(l,1) >= MaxFreq)
    for i = l:-1:1
        if AC(i,1) < MaxFreq
            e = i+1;
            break
        end
    end
else
    e = l;
end
%Now just transfer this part of the AC data
AC_Crop = AC(s:e,:);

end

