% ***********************************
% LoadExptFromExcelSummary
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
function [ FileName, PathName , CapID] = LoadExptFromExcelSummary( FileName, PathName, page, User )
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
[Date, CapNo, CapType, CapSol, CapConc, CapPH, Membrane, BareIVCurves,SealedIVCurves,AwayIVCurves, Expts, ExptType, Traces  ] = InterpretExcelSheet( raw );

%Display Data and offer option to conutinue
Message = [(['Date ' num2str(Date)]),([ ' Cappillary:' CapType num2str(CapNo)])];
%h = msgbox(Message,'Data');

%Match Membrane to Membrane No
[ MembraneID ] = getMembraneID( Membrane );

button = questdlg(['Do you want to use this experiment Type: ' ExptType]);
if strcmp(button, 'Yes') == 1
    ExperimentType = ExptType;
else
    ExperimentType  = inputdlg(['Enter Experiment Type NB Membrane is ' num2str(Membrane) ' identified as ' num2str(MembraneID)]);
end


button = questdlg('Do you want to enter this data?');
if strcmp(button, 'Yes') == 1
    if GetCapID( Date, CapNo ) == 0
        %Enter Data into DB
        %Create Capillary and get No  - NB might use existing function for this!
        % Use AddCapillaries to create experiments
        % This will add the bare and sealed values as well using AddExperiments
        [ CapID ] = AddCapillaries( Date, CapType, CapNo ,ExperimentType, BareIVCurves,SealedIVCurves,AwayIVCurves, MembraneID , User, Expts, CapSol, CapConc, CapPH, Traces );
        
        %Ouput the capillary No and expeirment No range.
        disp(['Data Entered as Capillary ' num2str(CapID)]);
        
        if (CapID > 0)
            ElectrodeSolution = raw{15,7};
            ElectrodeConc = raw{15,9};
            if ~isnan(ElectrodeConc)
                [ rValue, rStringValue, rid ] = UpdateNameValueCapillary( CapID, 'ElectrodeSolution', ElectrodeConc, ElectrodeSolution );
            else
                warning('Didn''t add electrode as no conc value')
            end
        end
        %should write the capillay no back to the excel file - though 
        
    else
        disp('THIS CAPILLARY ALREADY EXISTS');
        CapID = GetCapID( Date, CapNo )
    end
else
    disp('You have chosen not to enter data');
end


end

