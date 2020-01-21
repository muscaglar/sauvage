
function [ Data, E] = ReturnExperimentalDetails( Date, No,CapNo )

%Load the Experimental detials for a capillary
%Note if only one argument is specified it is treated as the experiment id

%may need a file Root
DB = DBConnection;

if nargin == 3
    E = Experiments(DB);
    [ Da ] = GetDBDate( Date );
    %Note that a date and no combination should be unique so will not check
    %here but will need to be able to check.
    str = ['Date LIKE ''' char(Da.toString) ''' AND No = ''' num2str(No) ''' AND Capillary = ''' num2str(CapNo) ''' '];
    E.SELECT(str);
    E.CloseConnection();
else
    if nargin == 1
        id = Date;
        E = Experiments(DB,id);
    end
end
if(E.getid() > 0)
    %Could also get capillary size info - from the capillary entry
    C = Capillaries(DB);
    C.SELECT(E.getCapillary);
    if(C.getid() > 0)
        %Now read out of the Experiment Object all of the required info.
        Data = {E.getid double(E.getCapPh) double(E.getResPh) char(C.getType) C.getCapNo char(C.getExptType) double(E.getReservoirConc) double(E.getCapillaryConc) double(E.getSuppressed) double(E.getSealed)};
    else
        %Capillary doesn't exist but experiment does  - could transfer out
        %the Expt details only but this situation shouldn't occur
        error(['Cannot find capillary for expt: ' num2str(E.getid()) ' Cap: ' num2str(E.getCapillary)])
        %Data = 0;
        %E = 0;
    end
    
else
    Data = 0;
    %E = 0;
end

end

