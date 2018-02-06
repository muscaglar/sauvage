function [ SignalsOut ] = BandPassFilter( Signals,   frequency )
%BandPass Filter

SignalsOut = zeros(size(Signals));

b = [1 -1];
a = [1 -0.99];

cols = max(size(Signals(1,:)));
for i = 1:cols
    SignalsOut(:,i) = filter(b,a,Signals(:,i));
end


end

