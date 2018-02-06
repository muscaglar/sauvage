function [ cost, MagCost, PhaseCost ] = ACCost( AC, AC_Simulation )
%ACCOST geric method of calcualting the cost

% MaxMag = max(AC(:,2));
% MinMag = min(AC(:,2));
% MagRange = MaxMag - MinMag;
% MaxPhase = max(AC(:,3));
% MinPhase = min(AC(:,3));
% PhaseRange = MaxPhase - MinPhase;
% 
% Mag = (AC(:,2) - MinMag ) / MagRange ;
% Phase = (AC(:,3) - MinPhase ) / PhaseRange;
% Mag_Sim = (AC_Simulation(:,2) - MinMag) /  MagRange;
% Phase_Sim = (AC_Simulation(:,3) - MinPhase) / PhaseRange;
% 
% MagError = ( Mag - Mag_Sim ) .^2 ;
% PhaseError = ( Phase - Phase_Sim ) .^2;
% 
% MagCost = sqrt(sum( MagError ));
% PhaseCost = sqrt(sum( PhaseError ));
% 
% cost = (MagCost + 1 * PhaseCost);

%Could calc r2 and use that
%[ r2, SStot, SSres , u ] = CalcR2( Data, Model )

[  MagCost] = CalcR2( AC(:,2), AC_Simulation(:,2) );
[ PhaseCost] = CalcR2( AC(:,3), AC_Simulation(:,3) );
  
cost = 1- ( (0.99 * MagCost + 0.01 * PhaseCost));

end

