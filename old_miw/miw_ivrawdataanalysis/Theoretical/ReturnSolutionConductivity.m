function [ Soln_Conductivity_S_m ] = ReturnSolutionConductivity( Solution, Concentration )
%RETURNSOLUTIONCONDUCTIVITY Summary of this function goes here
%   Detailed explanation goes here

[ No ] = SolutionToNumber( Solution );

switch No
   case 1
        %LiCl
        switch Concentration
            case 1
                Soln_Conductivity_S_m = 7.81;
            %case 0.1
            
            otherwise
                Soln_Conductivity_S_m = 7.81;
        end
   case 2

    case 3
        
    case 4
        
    case 5
       %LaCl3

    otherwise
       %Treat as 1m liCl
       warning('Cannot identify solution - using 1M LiCl value');
      Soln_Conductivity_S_m = 7.81;
end



end

