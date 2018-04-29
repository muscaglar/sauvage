function [ FileName, PathName ] = GetDataByNo( Date, No , AllowDownload )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    %set default values
    FileName = ' ';
    %PathName;
    if nargin < 3
        %Default to allow download
        AllowDownload = 1;
    end
    %Should deal with if only one variable then treat as ID
    
    [PathName, DateStr ] = ConstructDataPath( Date);
    
    
    if exist(PathName,'dir') ~= 0
       files = dir(PathName);
        ApproxFileName = [DateStr '_' num2str(No) '_'];
        
        for file = files'
            %See if the file matches the date and no
            if not(isempty(strfind(file.name, ApproxFileName))) && not(isempty(strfind(file.name, '.txt')))
               %[date2, no2] = FileNameInterpret( file.name );
                FileName = file.name;
            end
        end
    end
    
    if exist([PathName '/' FileName],'file') ~= 2 && AllowDownload == 1
       [ FileName, PathName ] = GetCloudData( Date, No );
    end
end

