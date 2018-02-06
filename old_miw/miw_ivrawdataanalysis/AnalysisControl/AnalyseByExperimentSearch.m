function [ Data ] = AnalyseByExperimentSearch( SearchStr , VoltageZeroOffset, save)
%Load all the experiments with this capillary

if nargin < 3
    save = 1;
    warning('Save not set');
end
if nargin < 2
    VoltageZeroOffset = 0;
end
    DB = DBConnection;
    E = Experiments(DB);
    E.SELECT(SearchStr);
    
    EIDs = arrayfun(@(e)e,  E.ResultSetIDs.toArray() );
    
   
    [ Data ] = AnalyseByExperimentIDs( EIDs' , VoltageZeroOffset, save);

end