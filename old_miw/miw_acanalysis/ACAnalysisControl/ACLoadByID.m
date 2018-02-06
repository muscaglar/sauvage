function [ AC, Date, No, E ] = ACLoadByID(  ExperimentID , AllowDownload)
%ACLOADBYID

if nargin < 2
    AllowDownload  = 1;
end

[ FileName, PathName, Date, No, E, id ] = GetDataByID( ExperimentID , AllowDownload );
[ AC ] = ACLoad(PathName, FileName  );


end

