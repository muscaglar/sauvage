function [ Data ] = AnalyseByCapillary( CapNo , VoltageZeroOffset, save)
%Analyse by capillary
%Analyse the IV curves for a capillary - this allows a voltage offset to be
%applied to all the curves to eliminate the electrode potential - this
%would essentially be taken from a run over all the data with no offset  -
%then select a zero point and use that value as the offset!!

%Note as it writes to the DB not too woried about returning data as well
if nargin < 3
    save = 0;
    warning('Save not set');
end
if nargin < 2
    VoltageZeroOffset = 0;
end

%Load the capillary info
DBc = DBConnection;
C = Capillaries(DBc, CapNo);  %Note might use this to get info about the capillary
%could store the voltage offset there.
if(C.getid > 0)
    %Load all the experiments with this capillary
    DB = DBConnection;
    E = Experiments(DB);
    str = ['Capillary = ''' num2str(CapNo) ''' AND Suppressed != 4']; % AND Suppressed = 0'] % AND Sealed > 0']
    E.SELECT(str);
    if(E.getid >0)
        isNext = 1;
        i = 1;
        clear Dates
        clear Numbers
        clear ids
        while isNext
            ids(i) = E.getid();
            Dates(i) = GetNumericDate(E.getDate());
            Numbers(i) = E.getNo();
            i = i+1;
            isNext = E.NextResult();
        end
        
        %Now use these Dates and numbers to get IVs to analyse - note can either
        %analyse directly or just pass the file and path name into IV analyse  -
        %but then harder to pass in the voltage to add/ remove
        
       [ Data ] = AnalyseByDateNo( Dates, Numbers, VoltageZeroOffset, save,CapNo );
    else
        warning('There are no experiments for this capillary');
    end
end

end

