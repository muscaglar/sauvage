function [ SpectraMatrix ] = GRamanEverySpectraInFolder(  MembraneNo, MembraneName, FolderPath )
%UNTITLED2 Run over a folder and analyse every Raman spectra in it.
%   Detailed explanation goes here
FileRoots;
if nargin < 3
  [Path] = uigetdir(SpectraRoot,'Select Dir to Process Raman Spectra');
  FolderPath = [Path '/'];
else
    %FolderPath is provided as an input argument  - but need to ensure its
    %in the correct format.
end
if nargin < 2
    %Need to set Membrane Name and membrane no
    %error('Need to set Membrane Name and no  - note can set as blank');
    Mem  = inputdlg('Enter Membrane No');
    MembraneNo = str2double(Mem{1,1});
    DB = DBConnection;
    M = Membranes(DB,MembraneNo);
    MembraneName = [char(M.getMaterial()) ' ' char(M.getName())]; 
    button = questdlg(['Do you want to use the membrane name: '  MembraneName]);
    if strcmp(button, 'No') == 1
        MembraneName = inputdlg('Enter Membrane Name');
    end
end
User  = inputdlg('Enter ID of investigator');
Investigator = str2double(User{1,1});

files = dir(FolderPath);
i = 0;
for file = files'
    %Need to check if a Raman Spectra
    if not(isempty(strfind(file.name, 'Raman'))) && not(isempty(strfind(file.name, '.txt')))
         i = i+1;
         %if it is Raman then open and process
        file.name
        %Need to get Name and Date out?
        [date, no] = FileNameInterpret( file.name );
        [ SpectrumMatrix ] = GRamanSpectraProcessFromFile( file.name, FolderPath );
        %Append to Spectra Matrix
        [n, m] = size(SpectrumMatrix);
        SpectrumVector = [date no reshape(SpectrumMatrix',1,n*m)];
        if i == 1
            SpectraMatrix = SpectrumVector;
        else
            SpectraMatrix = [SpectraMatrix ; SpectrumVector];
        end
        %Now insert into the DB. Need to get correct columsn from SpectrumMatrix
        %Note need to set Membrane Values manually - but also need to
        %decide if these get updated  - Need to be careful as want to run
        %over all Data without corrupting.
        InsertSpectraToDB( date, no,MembraneNo, MembraneName, [SpectrumVector(1,3:14) SpectrumVector(1,23:26)], SpectrumVector(1,15:18),Investigator )
    end
end
if ~exist('SpectraMatrix')
    SpectraMatrix = 0;
end

%Output the number of files and the data summary
disp([num2str(i) ' Files of Raman Spectra']);

save([FolderPath '/Analysis/' num2str(date) '_Summary_' num2str(i) '.txt'],'SpectraMatrix','-ascii')

%Put the Matrix with all of the spectra information for each one on to the
%clip board  - note need to process it to add tabs and new lines in place
%of the spaces and ';' used by str2mat
OutputString = strrep(mat2str(SpectraMatrix), ' ' , sprintf('\t'));
OutputString = strrep(OutputString, '[' , ' ');
OutputString = strrep(OutputString, ']' , ' ');
OutputString = strrep(OutputString, ';' , sprintf('\r\n'));
clipboard('copy', OutputString)
%mat2ClipBoardTABSeparated( SpectraMatrix )

end

