function [ max_Nernst ] = percent_Nernst( log_Conc_Ratios, z )

PhysicalConsts;
max_Nernst = [];

for log_ConcRatio = log_Conc_Ratios

Voltage = 2.3026 * R_Const * (T_Const / (z * F_Const)) .* log_ConcRatio;
Voltage_mV = Voltage * 1000;
max_Nernst = [max_Nernst, Voltage_mV];

end

end