function [ C , C_pf ] = ParallelPlatesCapacitance( Area, Thickness, RelativePermitivity )
%PARALLELPLATESCAPACITANCE Summary of this function goes here
%   Detailed explanation goes here

if nargin < 3
    RelativePermitivity = 1;
end

PhysicalConsts;

C = ( Area * epsilon_0_Const * RelativePermitivity ) / ( Thickness );

C_pf = C * 1e12;

end

