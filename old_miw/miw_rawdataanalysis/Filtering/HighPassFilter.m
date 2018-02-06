function [ SignalsOut ] = HighPassFilter( Signals,   frequency )
%HIGHPASSFILTER Summary of this function goes here
%   Detailed explanation goes here


b = [1 -1];
a = [1 -0.99];
n = 500;
%size(Signals)
if(n > size(Signals,1))
   n = size(Signals,1) - 1;
   if n < 1
       n = 1;
   end
end
%Copy the first n data points ahead
x = flipud(Signals(1:n,:));
data = [x; Signals];

SignalsOut = zeros(size(data));
cols = size(data,2);
for i = 1:cols
    SignalsOut(:,i) = filter(b,a,data); %filter(b,a,Signals(:,i));
end

SignalsOut = SignalsOut((n+1):end,:);

end

