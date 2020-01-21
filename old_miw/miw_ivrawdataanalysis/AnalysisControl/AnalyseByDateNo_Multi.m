
function [ Data ] = AnalyseByDateNo_Multi( Dates, Numbers, VoltageZeroOffset, save, z,CapNo )
%ANALYSEBYDATENO 

%Note could check Dates and Numbers are the same size, or if not then just
%use a single Date.

if nargin < 4
    save = 0;
    warning('Save not set');
end
if nargin < 3
    VoltageZeroOffset = 0;
end

        i = 1;
        for No = Numbers
            [ FileName, PathName ] = GetDataByNo( Dates(i), No );
            %Now determine the correct analysis to run - either from
            %filename or a type code in the pairr values table
            if(not(isempty(strfind(FileName, 'AC'))))
                warning('Not an IV Curve');
            else
                %Assume it is an IV Curve - unless other info
                [ Data ] = IVAnalyse_MultiIon(save, FileName, PathName, VoltageZeroOffset, 0,z,CapNo);
            end
            i = i+1;
        end


end

