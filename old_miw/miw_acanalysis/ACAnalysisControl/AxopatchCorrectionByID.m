function [ AC_corrected, Fc ] = AxopatchCorrectionByID( AC, id )
%AXOPATCHCORRECTIONBYID Summary of this function goes here
%   Detailed explanation goes here


[ Fc, ~, rid ] = UpdateNameValueExperiment( id , 'AxonFilterFreq' );
if (rid >0 )
    [ AC_corrected, Fc ] = AxopatchFilterCorrection( AC,  Fc);
else
    [ AC_corrected, Fc ] = AxopatchFilterCorrection( AC );
end

end

