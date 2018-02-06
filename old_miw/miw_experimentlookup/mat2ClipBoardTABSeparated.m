% ***********************************
% mat2ClipBoardTABSeparated
% Code to copy a matrix to the clipboard
%   The format is such that it can be pasted into an Origin Workbook or
%   Excel file directly
%   (C) Michael Walker 2015
%   Vers: 0.0.1
%%***********************************
function mat2ClipBoardTABSeparated( OutputMatrix )
%mat2ClipBoardTABSeparated Code to copy a matrix to the clipboard
%   The format is such that it can be pasted into an Origin Workbook or
%   Excel file directly

%Put the Matrix with all of the spectra information for each one on to the
%clip board  - note need to process it to add tabs and new lines in place
%of the spaces and ';' used by str2mat
OutputString = strrep(mat2str(OutputMatrix), ' ' , sprintf('\t'));
OutputString = strrep(OutputString, '[' , ' ');
OutputString = strrep(OutputString, ']' , ' ');
OutputString = strrep(OutputString, ';' , sprintf('\r\n'));
clipboard('copy', OutputString);

end

