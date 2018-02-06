% ***********************************
% LoadExptFromExcelSummary_Simple
%   Load all the details for a complete experiment into the DB from an
%   Experiment summary sheet
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
function [ FileName, PathName , CapIDs] = LoadExptFromExcelSummary_Simple( FileName, PathName, page, User )
%Load experimental details from the Excel file summary
% Process the excel file  - nb need to select page correctly
% Then complete the Database entry
%nargin = 1;
FileRoots;
if nargin < 2
    [FileName, PathName] = uigetfile({'*.xlsx;*.xlsm','Excel Files';},'Choose Excel File',ExperimentOutputRoot);
end
if nargin < 3
    % Select the correct page
    sheet = inputdlg('Enter the page you want to load from');
else
    sheet{1,1} = page;
end
if nargin < 4
    User  = inputdlg('Enter ID of user');
    User = str2double(User{1,1});
end

disp(sheet)

% Load Excel File
[num,txt, raw] = xlsread([PathName '/' FileName],sheet{1,1});

% Check the data / load into variables
Expts = ReadExcelMatrix( raw , 3, 1, 0, 12);

CapIDs = [];
button = questdlg('Do you want to enter this data?');
if strcmp(button, 'Yes') == 1
    n = size(Expts,1);
    CapSol = raw{2,16};
    CapConc = raw{3,16};
    CapPH = raw{4,16};
    for i = 1:n
        data = Expts(i,:);
        day = data{4};
        month = data{5};
        year = data{6};
        if (year > 100)
            year = year -2000;
        end
        Date = day * 10000 + month * 100 + year;
        
        CapType = data{1};
        CapNo = data{2};
        ExperimentType = data{11};
        
        Membrane = data{12};
        if isnan(Membrane)
            Membrane = 1;
        end
        
        ResConc = CapConc;
        ResSol = CapSol;
        ResPH = CapPH;
        
        CapID = AddCapillaries( Date, CapType, CapNo ,ExperimentType,[],[],[], Membrane , User, [], CapSol, CapConc, CapPH, [] );
        %CapID = 500;
        CapIDs = [CapIDs CapID];
        if(CapID > 0)
            BareNo = data{8};
            if BareNo > 0
                AddExperiment( Date, BareNo, CapID, 0,0, ResConc,ResSol, CapConc, CapSol, CapPH, ResPH )
            end
            SealedNo = data{9};
            if SealedNo > 0
                AddExperiment( Date, SealedNo, CapID, 20,Membrane, CapConc, CapSol, CapConc, CapSol, CapPH, ResPH )
            end
            AwayNo = data{10};
            if AwayNo > 0
                AddExperiment( Date, AwayNo, CapID, 21,Membrane, ResConc,ResSol, CapConc, CapSol, CapPH, ResPH )
            end
        end
    end
else
    disp('You have chosen not to enter data');
end


end

