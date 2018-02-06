function [ No ] = SolutionToNumber( Solutions )
%SOLUTIONTONUMBER Pass in a cell array or single solution and return a
%number or vector. In this way the same solutions will always be
%represented in the same way.

Solution = char(Solutions);

if(strcmpi(Solution, 'LiCl'))
    No = 1;
elseif(strcmpi(Solution, 'NaCl'))
    No = 2;
elseif(strcmpi(Solution, 'KCl'))
    No = 3;
elseif(strcmpi(Solution, 'MgCl2'))
    No = 4;
elseif(strcmpi(Solution, 'LaCl3'))
    No = 5;
elseif(strcmpi(Solution, ' '))
    No = 6;
else
    warning(['Unidentified solution ' Solution]);
    No = 0;
end

end

