function [ mu, std, scale ] = FitGaussain( Signals , NoGaussians )
%FitGaussian Fir a gaussian/s to the Data
%   Data in 2 columns 
%   Wrapped in my function so I can change its operation if using in a
%   sitatuion where the statistics tool box isn't included - in which case


f = fit(Signals(:,1),Signals(:,2),'gauss1');

mu = f.b1;
std = f.c1;
scale = f.a1;

plot(f,Signals(:,1),Signals(:,2));
end

