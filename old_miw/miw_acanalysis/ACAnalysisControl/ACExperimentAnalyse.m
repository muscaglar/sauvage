function [ R_p, C_p, R_s, C_s, AC_Fitted_p, AC_Fitted_s  ] = ACExperimentAnalyse( ExperimentID , volts )

if size( ExperimentID,2) == 3 && size( ExperimentID,1) > 3
    AC = ExperimentID;
    E = 0;
    ExperimentID = 0;
else
    [AC , ~, ~, volts, E] = ACLoadByIDandCorrect( ExperimentID);
end


[ R_p, C_p, AC_Fitted_p , r2_parallel ] = ParallelFit( AC , volts );
[ R_s, C_s, AC_Fitted_s , r2_series ] = SeriesFit( AC , volts );

if(ExperimentID > 0)
    %Only update if passed the experiment ID
    [ rValue, rStringValue, rid ] = UpdateNameValueExperiment( E.getid() , 'R_Parallel', R_p);
    [ rValue, rStringValue, rid ] = UpdateNameValueExperiment( E.getid() , 'R_Series', R_s);
    [ rValue, rStringValue, rid ] = UpdateNameValueExperiment( E.getid() , 'C_Parallel', C_p);
    [ rValue, rStringValue, rid ] = UpdateNameValueExperiment( E.getid() , 'C_Series', C_s);
    
    % Also record the r2 for each fit - so you can see if parallel or bare
    % fits best
    [ rValue, rStringValue, rid ] = UpdateNameValueExperiment( E.getid() , 'Series_r2', r2_series);
    [ rValue, rStringValue, rid ] = UpdateNameValueExperiment( E.getid() , 'Parallel_r2',r2_parallel);

end

disp(['Exp: ' num2str(ExperimentID) ' R_p = ' num2str(R_p,3) ' C_p = ' num2str(C_p,3) ' r2_p = ' num2str(r2_parallel,2) ' R_s = ' num2str(R_s,3) ' C_s = ' num2str(C_s,3) ' r2_s = ' num2str(r2_series,2) ''])
ACPlot(AC, AC_Fitted_p, AC_Fitted_s );

end