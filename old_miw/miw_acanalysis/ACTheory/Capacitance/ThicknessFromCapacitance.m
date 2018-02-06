function [ Thickness, Thickness_nm ] = ThicknessFromCapacitance( C , Area, RelativePermitivity  )
%THICKNESSFROMCAPACITANCE Summary of this function goes here
%   Detailed explanation goes here

if nargin < 3
    RelativePermitivity = 1;
end

PhysicalConsts;

 Thickness = ( Area * epsilon_0_Const * RelativePermitivity ) / C;

Thickness_nm = Thickness * 1e9;

end

