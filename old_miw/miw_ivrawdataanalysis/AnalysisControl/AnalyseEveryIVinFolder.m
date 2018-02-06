% ***********************************
% AnalyseEveryIVinFolder
%   Run raw data analysis on all the IV data files in a folder
%   
%   (C) Michael Walker 2015 - All Rights Reserved
%
% The above copyright notice and this permission notice shall be included in
% all copies or substantial portions of the Software.
%
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
% AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
% LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
% OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
% SOFTWARE.
%%***********************************

function [ IVMatrix ] = AnalyseEveryIVinFolder( FolderPath )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
FileRoots;
if nargin < 1
  [Path] = uigetdir(DataRoot,'Select Dir to Process IV Curves');
  FolderPath = [Path '/'];
else
    %FolderPath is provided as an input argument  - but need to ensure its
    %in the correct format.
end

files = dir(FolderPath);
i = 0;
for file = files'
    %Need to check if a Raman Spectra
    if not(isempty(strfind(file.name, 'IV'))) && not(isempty(strfind(file.name, '.txt')))
         i = i+1;
         %if it is Raman then open and process
        file.name
        %Need to get Name and Date out?
       % [date, no] = FileNameInterpret( file.name );
        [ IVData ] = IVAnalyse(1, file.name, FolderPath );
        %Append to Spectra Matrix
        [n, m] = size(IVData);
        IVVector = [reshape(IVData',1,n*m)];
        if i == 1
            IVMatrix = IVVector;
        else
            IVMatrix = [IVMatrix ; IVVector];
        end
    end
end
if ~exist('IVMatrix')
    IVMatrix = 0;
end

%Output the number of files and the data summary
disp([num2str(i) ' IV Files Analysed']);

%save([FolderPath '/Analysis/' num2str(date) '_Summary_' num2str(i) '.txt'],'IVMatrix','-ascii')

%Put the Matrix with all of the spectra information for each one on to the
%clip board  - note need to process it to add tabs and new lines in place
%of the spaces and ';' used by str2mat
mat2ClipBoardTABSeparated( IVMatrix )

end

