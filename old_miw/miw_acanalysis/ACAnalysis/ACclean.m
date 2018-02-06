function [ AC_Clean ] = ACclean( AC , TH )
%ACCLEAN Summary of this function goes here
%   Detailed explanation goes here

%remove clearly spurious points
if nargin < 2
    TH = 2.5;
end
p1 = polyfit(AC(:,1),AC(:,2),3);
AC_Fit = polyval(p1,AC(:,1));
Error = (AC(:,2) - AC_Fit).^2;
PercentError = Error ./ sum(Error);
MeanPercentError = mean(PercentError);
ToKeep = PercentError < (TH * (MeanPercentError));
AC_Clean = AC(ToKeep,:);
end

