function [ Output_S ] = Smooth( input_S , e , start)
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here
if nargin < 3
   start = 1; 
end
l = max(size(input_S));
Output_S = zeros(l-start+1,1);
k = 1;


%e needs to be odd  - or interpret at this many either side?
if mod(e,2)== 0
   r = e/2 ;
else
   r = ((e+1)/2);
end

%Deal with early values  - could do better
for i = start:(start + r - 1)
   tot = input_S(i);
    for j = (start - i):(start - i + r - 1)
    tot = tot + input_S(i+j);
   end
   Output_S(k) = (tot / r);
   k = k+1;
end
for i = (start + r):1:l - r;
    tot = input_S(i);
    for j = 1:r
    tot = tot + input_S(i-j);
    tot = tot + input_S(i+j);
   end
   Output_S(k) = tot / (2*r +1);
   k = k+1;
end
%For final 4 values
for i = (l - r+1):l
    tot = input_S(i);
    for j = 1:r
    tot = tot + input_S(i-j);
    end
    for j = 1:l-i
    tot = tot + input_S(i+j);
    end
   Output_S(k) = (tot / (r+l-i));
   k = k+1;
end
end


% %Deal with early values
% for i = start:(start + e - 1)
%    tot = 0;
%     for j = (start - i):(start - i + e - 1)
%     tot = tot + input_S(i+j);
%    end
%    Output_S(k) = (tot / e);
%    k = k+1;
% end
% for i = (start + e):1:l;
%    tot = 0;
%     for j = 0:(e-1)
%     tot = tot + input_S(i-j);
%    end
%    Output_S(k) = tot / e;
%    k = k+1;
% end
