function [AC , AC_raw, Fc, volts, E] = ACLoadByIDandCorrect( ExperimentID , AllowDownload)
%ACLOADBYIDANDCORRECT Summary of this function goes here
%   Detailed explanation goes here
if nargin < 2
    AllowDownload  = 1;
end

[ AC_raw, Date, No, E ] = ACLoadByID(  ExperimentID, AllowDownload );
[ AC , Fc] = AxopatchCorrectionByID( AC_raw, E.getid);
[ AC ] = ACclean( AC );


[ volts, ~, rid ] = UpdateNameValueExperiment( E.getid , 'ACSweepPeakVoltage_mV' );

if (rid >0 )
    volts = volts * 1e-3;
    %Scale the AC?
else
    volts = 10e-3;
end

end

