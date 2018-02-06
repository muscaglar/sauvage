function [ PhaseInfo ] = ProcessAllData( Path )
%ProcessAllData Appropriately process all of the results from a day
%   Will run over all the files and folders and will process them
%   accordingly
%   This means for the Subfolders - deciding how to process the data -
%   phase or translocations!
%   Then for the various text files, IV, AC just analysing and recoding the
%   necessary information
%
%   Ideal output would be a tabulated form put into the clip board which
%   can then be sent to Excel

%Deal with folders separately
FileRoots;
if nargin < 1
    if exist('D:\PhDData1\Data','dir')
       [Path] = uigetdir(DataRootHDD,'Select Day');
    else
       [Path] = uigetdir(DataRoot,'Select Day');
    end
  FolderPath = [Path '\'];
else
    %FolderPath is provided as an input argument  - but need to ensure its
    %in the correct format.
    FolderPath = [Path '\'];
end

files = dir(FolderPath);
i = 0;
for file = files'
    %First of all determine if file or folder
    if file.isdir == 1
        %Is folder 
        %May also want to look to see if there is frame data inside this
        %folder!
        %Can apply test on name etc
        %ideally just a function here!
        if isempty(strfind(file.name, '.'))
            i = i+1;
            %Ideal
            disp(['File Name (folder): ' file.name]);
            [ date, no, details] = FileNameInterpret( file.name );
            if no ~= 46 && no ~= 66
            [ FittedPhase ] = FolderAnalyse( [FolderPath file.name] );
            else
               FittedPhase = [0 0 0]; 
            end
            
            
            if i == 1
                PhaseInfo = [date no FittedPhase];
            else
                PhaseInfo = [PhaseInfo ; date no FittedPhase] ;
            end
        end
    else
    %Deal with Files  - AC, IV etc    
        %i = i+1;
    end
end
%record no of files or folders recorded
NoFiles = i;


mat2ClipBoardTABSeparated( PhaseInfo )

end

