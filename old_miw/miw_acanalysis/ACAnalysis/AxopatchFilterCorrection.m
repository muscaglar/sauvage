function [ AC, Fc ] = AxopatchFilterCorrection( AC, Fc)
%AXOPATCHFILTERCORRECTION Remove the effect of the axopatch filter

if nargin < 2
   %default to 5kHz filter
   Fc = 5000;
end
%Remove the effect of the filter
[ AC ] = ACcrop( AC, 0.9 * Fc );

%Axopath usses 4 pole bessel filter - bessel filters a linear in phase in
%pass band - they add a lag.  see page 139 Axon guide
p = [7.5e-3 0];   %Set at 10 degrees at 5K
AC(:,3) = AC(:,3) + polyval(p, AC(:,1));

end

