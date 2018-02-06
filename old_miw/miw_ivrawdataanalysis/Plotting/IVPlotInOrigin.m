% ***********************************
% IVPlotInOrigin
%   Plot IV Curves in Origin, based on either Date,No or Experiment ID
%
%   (C) Michael Walker 2016 - All Rights Reserved
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

function [ output_args ] = IVPlotInOrigin( A, B,C)
% IVPlotInOrigin Plot a set of IV curves in Origin
if nargin < 2 || ~isnumeric(B)
    % treat A as exp IDs and plot accordingly
    ExperimentNos = A;
    Date = 0;
    if nargin < 2
        Comments =[];
    else
        Comments = B;
    end
elseif nargin >= 2 && isnumeric(B)
    %Treat the first Argument as the Date and experiment nos
    Date = A;
    ExperimentNos = B;
    if nargin > 3
        Comments = C;
    else
        Comments = [];
    end
else
    error('input type is wrong');
end

% Could apply an offset

%Set up Origin Object
ORG = Matlab2OriginPlot();
ORG.HoldOff();
% Load the experiments  - If Date and No then only load to get Legend
% details, if ID then load from DB to get Date and No.
i = 1;
for e = ExperimentNos
    if nargin >= 2 && isnumeric(B)
        [info, E] = ReturnExperimentalDetails(Date, e);
        No = e;
        
        [ Voffset, ~ ] = VOffsetCorrection( E.getCapillary() );
    else
        [info, E] = ReturnExperimentalDetails(e);
        Date = GetNumericDate( E.getDate() );
        No = E.getNo();
        
        [ Voffset, ~ ] = VOffsetCorrection( E.getCapillary() );
        
    end
    
    [ FileName, PathName ] = GetDataByNo( Date, No );
    IV = LoadIV(FileName, PathName);
    IV = IVClean(IV);
    %Plot and set title by Date, Experiment No and maybe also the Capillary
    %info from the table  - note want to set title a this goes on Work
    %sheet
    
    IV(:,2) = IV(:,2) - Voffset;
    
    if iscell(Comments)
        Comment = Comments{i};
    else
        Comment = Comments;
    end
    
    title = [Comment 'IV' num2str(Date) 'i' num2str(No) 'i' num2str(E.getid()) ''];
    ORG.PlotScatter(IV(:,2)',IV(:,1)',title, ORG.ColourPicker());
    ORG.ylabel('Current','nA');
    ORG.xlabel('Voltage','mV');
    ORG.yComment([Comment 'id: ' num2str(E.getid()) 'C: ' num2str(E.getCapillary()) 'R: ' num2str(E.getResistance(),3) ' pH: ' num2str(info{3}) ' Conc: ' num2str(info{7})]); %Put details of reservoir Conc
    ORG.HideActiveWkBk()
    %ORG.xComment('');
    ORG.HoldOn();
    %Do line fit and add to the plot?
    %Could also add text?
    
    i = i+1;
end

%Can change the graph title to somethign sensible for all of them, rather
%than each individual graph.
%ORG.title('');
    ORG.Disconnect;
end

