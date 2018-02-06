function [ Rm, Cm, Rc, Cc, AC_Fitted , r2 ] = MembraneAndCapillaryFit( AC , Rc, Cc , volts)
%MEMBRANEANDCAPILLARYFIT Summary of this function goes here
%   Detailed explanation goes here
%Set Rc and Cc as empty to fit all

%Fit to the membrane anc capillary model  - can I set up an arbitary
%version where you pass in a wsimulation model - which could then be passed
%to the cost function  - or could do it by passing Den and Num to this and
%via into the final = but tricky to set up then

if nargin < 4
    volts = 10e-3;
end

%Params0 = [1e9 1e-12 0 1e-12];
if not(isempty(Rc)) && not(isempty(Cc))
   Params0 = [10*Rc 10*Cc];
   FitRc = 0;
   FitCc = 0;
elseif(isempty(Rc))
   Params0 = [1e9 1e-12 1e6];
   FitRc = 1;
if(isempty(Cc))
    Params0 = [1e9 1e-12 1e6 1e-12];
    FitCc = 1;
end
end

Params0
% if isempty(Rc)
%     Rc = abs(Params0(3));
% end
% if isempty(Cc)
%     Cc = abs(Params0(4));
% end

    %Params0 = [1e9 1e-12 1e6 1e-12];
    %Params0 = [10*Rc 10*Cc];
    %Params0 = zeros(1,2);

    ParamFinal = fminsearch(@(Params0) MembraneAndCapillaryCost( AC , Params0 , Rc, Cc , volts), Params0);

if FitRc == 1
    Rc = abs(ParamFinal(3));
end
if FitCc == 1
    Cc = abs(ParamFinal(4));
end


%Take positive value - as the cost function does this as well
Rm = abs(ParamFinal(1));
Cm = abs(ParamFinal(2));

[ AC_Fitted ] = MembraneAndCapillarySimulate(  Rm, Cm, Rc, Cc, AC(:,1) , volts);

r2 = CalcR2( AC(:,2), AC_Fitted(:,2) );

end

