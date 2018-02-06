function [ d_nm, d_m ] = DebyeLength( Conc, z, T, epislon_r )
%DEBYELENGTH Summary of this function goes here
%   Detailed explanation goes here

PhysicalConsts;
if nargin < 4
    epislon_r = 80;
    if nargin < 3
        T = 293;
        if nargin < 2
            z = 1;
        end
    end
end
    numerator = 2 * (e_Const^2) * N_A_Const .* Conc .* (z.^2);
    denominator = epsilon_0_Const * epislon_r * Kb_Const * T;
    
    k = sqrt( (numerator ./ denominator) );
    
    d_m = 1 ./ k;
    
    d_nm = d_m * 1e9;
    
end

