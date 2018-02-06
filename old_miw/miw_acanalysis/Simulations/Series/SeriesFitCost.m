function [ cost ] = SeriesFitCost( AC , Params, volts )
%SERIESFITCOST Summary of this function goes here
%   Detailed explanation goes here

if nargin < 3
    volts = 10e-3;
end

R = abs(Params(1));
C = abs(Params(2));

AC_Simulation = SeriesSimulate( R, C, AC(:,1) , volts);

MaxMag = max(AC(:,2));
MinMag = min(AC(:,2));
MagRange = MaxMag - MinMag;
MaxPhase = max(AC(:,3));
MinPhase = min(AC(:,3));
PhaseRange = MaxPhase - MinPhase;

Mag = (AC(:,2) - MinMag ) / MagRange ;
Phase = (AC(:,3) - MinPhase ) / PhaseRange;
Mag_Sim = (AC_Simulation(:,2) - MinMag) /  MagRange;
Phase_Sim = (AC_Simulation(:,3) - MinPhase) / PhaseRange;

MagError = ( Mag - Mag_Sim ) .^2 ;
PhaseError = ( Phase - Phase_Sim ) .^2;

MagCost = sqrt(sum( MagError ));
PhaseCost = sqrt(sum( PhaseError ));


cost = (MagCost + 1*  PhaseCost);
end

