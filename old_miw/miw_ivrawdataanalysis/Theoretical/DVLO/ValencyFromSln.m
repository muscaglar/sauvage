function [ Valency, No ] = ValencyFromSln( Solution )
%VALENCYFROMSLN Summary of this function goes here
%   Detailed explanation goes here

[ No ] = SolutionToNumber( Solution );


switch No
    case 1
        %LiCl
        Valency = 1;
    case 2
        %NaCl
        Valency = 1;
    case 3
        %KCl
        Valency = 1;
    case 4
        %MgCl2
        Valency = 2;
    case 5
        %LaCl3
        Valency = 3;
    otherwise
        Valency = 1;
end

%disp(['Solution ' Solution ' Valency: ' num2str(Valency)])

end

