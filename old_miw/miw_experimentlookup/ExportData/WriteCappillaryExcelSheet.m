% ***********************************
% WriteCapillaryExcelSheet
%   Write all the details for a capillary into a sheet in an excel file
%   
%   (C) Michael Walker 2015 - 2016 - All Rights Reserved
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
function [ output_args ] = WriteCappillaryExcelSheet(CapillaryID, FileName, PathName )
%Write an experiment to an excel sheet  - with analysis
%Either do analysis or have the analysis passed in

% See what arguments are present  - if not present then load and analyse
% In some ways prefer to re do analysis then not tained
% Will use a separate command to write the values for other

AllowableSuppressionCodes = [0 16];

if nargin < 3
    FileRoots;
    [PathName] = uigetdir(ExperimentOutputRoot,'Select Dir to save file to');    
    %[~,PathName,~] = uigetfile({'*.xlsm','Excel Files';},'Choose Excel File', ExperimentOutputRoot);
end
if nargin < 2
    %FileName = '/ExptOutput.xlsm';
    % Could use a dialog here.
    FileNameS  = inputdlg('Enter A file Name');
    FileName = ['/' FileNameS{1,1} '.xlsm'];
else
    FileName = ['/' FileName];
    %Could check if has correct file ending
end

%Test if file exists and if it doesn't copy
str = [PathName FileName]
if exist(str, 'file') ~= 2
    %The output file doesn't exist - so first copy the template
    [TemplateFileName,TemplatePathName,~] = uigetfile({'*.xlsm','Excel Files';},'Choose Excel Output Template File');
    copyfile([TemplatePathName TemplateFileName],[PathName FileName])
end

if nargin < 1
    % Select the correct page
    CapNo  = inputdlg('Enter The capillary ID');
    CapNo  = str2double(CapNo {1,1});
    CapillaryID = CapNo;
else
    CapNo = CapillaryID;
end

%Could run Analysis

%LoadCapillaryScript
%SelectivityAnalyseDB

%Note bare exeperiments will now load as sealed but with a membrane value of
%15
[Expts, No] = LoadExperiments( CapillaryID, 1, AllowableSuppressionCodes );
NoSelectivityResults = No;

[ C, ~,~ ] = GetCapillaryDetails( CapillaryID);

%Could load these valuues from name value pairs rather than re calculating
[ VoltageGradient, CurrentGradient ] = Selectivity( Expts );
%This is now carried out by the capillary analysis routine
% if (NoSelectivityResults > 0)
   [ VoltageGradient_Limited, CurrentGradient_Limited] = Selectivity( Expts, 0.0002, 0.2);
%     UpdateNameValue(0, 0, C.getid(), 0,'SelectivityVoltage_Full', VoltageGradient(1));
%     UpdateNameValue(0, 0, C.getid(), 0,'SelectivityCurrent_Full', CurrentGradient(1) );
%     UpdateNameValue(0, 0, C.getid(), 0,'SelectivityVoltage_<0.1', VoltageGradient_Limited(1) );
%     UpdateNameValue(0, 0, C.getid(), 0,'SelectivityCurrent_<0.1', CurrentGradient_Limited(1) );
% end


%Create Sheet Name
D = C.getDate();
sheet = [GetDateString(D) '_' num2str(C.getCapNo) '_' num2str(C.getid)];

if No > 0
    %-------------------------------------------------------------------------
    % Write to Excel file
    %xlswrite([PathName FileName],A,sheet)
    
    % Write Capillary ID
    A = {'Cap ID', C.getid();'Experiment Type', char(C.getExptType())};
    xlRange = 'G1:H2';
    xlswrite([PathName FileName],A,sheet,xlRange)
    
    %Write Date
    A = {'Day','Month', 'Year'; D.Day(), D.Month(), D.year()};
    xlRange = 'C1:E2';
    xlswrite([PathName FileName],A,sheet,xlRange)
    
    %Write Investigator
    DB = DBConnection;
    I = Investigators(DB, C.getinvestigator());
    char(I.toString())
    A = {'Investigator', char(I.toString)};
    xlRange = 'G3:H3';
    xlswrite([PathName FileName],A,sheet,xlRange)
    
    %Write Capillary Details
    [ BareExpts ,k] = LoadExperiments( CapNo, 0, 0 );
    k
    if k > 1
        E = BareExpts(1);
    else
        E = Expts(1);
    end
    A = {'Capillary No','',C.getCapNo; 'Capillary Type','', char(C.getType());'Capillary Solution','',char(E.getCapillarySln());'Capillary Conc','',E.getCapillaryConc;'Capillary pH','', E.getCapPh};
    xlRange = 'A4:C8';
    xlswrite([PathName FileName],A,sheet,xlRange)
    
    E2 = Expts(1);
    DB = DBConnection;
    M = Membranes(DB);
    M.SELECT(E2.getSealed())
    A = {'Membrane','',char(M.toString())};
    xlRange = 'A9:C9';
    xlswrite([PathName FileName],A,sheet,xlRange)
    
    %Write the Bare, Away, sealed results
    %Write the headings
    r = 11;
    A = {'Bare','','','Sealed','','','Away','','';'Expt No','Expt ID','Resistance','Expt No','Expt ID','Resistance','Expt No','Expt ID','Resistance'};
    xlRange = ['A' num2str(r) ':I' num2str(r+1)];
    xlswrite([PathName FileName],A,sheet,xlRange)
    r = 12;
    for j = 1:length(BareExpts)
        E = BareExpts(j);
        xlRange = ['A' num2str(r+j) ':C' num2str(r+j)];
        
        A = {E.getNo(),E.getid(),E.getResistance};
        xlswrite([PathName FileName],A,sheet,xlRange)
    end
    
    % Sealed
    [ SealedExpts ] = LoadExperiments( CapNo, 1, 20 );
    for j = 1:length(SealedExpts)
        E = SealedExpts(j);
        xlRange = ['D' num2str(r+j) ':F' num2str(r+j)];
        A = {E.getNo(),E.getid(),E.getResistance};
        xlswrite([PathName FileName],A,sheet,xlRange)
    end
    
    % Away
    [ AwayExpts ] = LoadExperiments( CapNo, 1, 21 );
    for j = 1:length(AwayExpts)
        E = AwayExpts(j);
        xlRange = ['G' num2str(r+j) ':I' num2str(r+j)];
        A = {E.getNo(),E.getid(),E.getResistance};
        xlswrite([PathName FileName],A,sheet,xlRange)
    end
    
    
    
    %Write the values for selectivity
    r = 12;
    A = {'Selectivity'};
    xlRange = ['K' num2str(r-1)];
    xlswrite([PathName FileName],A,sheet,xlRange)
    A = {'Expt No','Expt id','Reservoir Solution','Reservoir Concentration','Reservoir pH',' ',' ','Resistance','Voltage Offset','Current Offset','Corrected Voltage Offset','','','<0 Resistance','>0 Resistance','pPerm','nPerm','GHK Ratio'};
    xlRange = ['K' num2str(r) ':AB' num2str(r)];
    xlswrite([PathName FileName],A,sheet,xlRange)
    
    %Now work through experiments  - % note these are loaded by loadCapillary
    %script into an array  - though could push that into a function!
    if(No > 0)
        for j = 1:length(Expts)
            E = Expts(j);
            xlRange = ['K' num2str(r+j) ':AB' num2str(r+j)];
            
            %Remove 0 values as these are not real measurements - these are where
            %there was not enough data to get the offset value
            if E.getVoffset ~= 0
                %VoltageOffsets(i) = E.getVoffset();
            else
                E.setVoffset(nan);
            end
            if E.getIoffset ~= 0
                %CurrentOffsets(i) = E.getIoffset();
            else
                E.setIoffset( nan );
            end
            
            A = {E.getNo(),E.getid(),char(E.getReservoirSln()),E.getReservoirConc,E.getResPh,' ',' ',E.getResistance,E.getVoffset,E.getIoffset,'  ',char(E.getComment()),'',E.getLowRes,E.getHighRes,E.getpPerm,E.getnPerm,(E.getpPerm/E.getnPerm)};
            
            xlswrite([PathName FileName],A,sheet,xlRange)
        end
        if(No > 1 && NoSelectivityResults > 0)
            %Add the selectivity Value
            A = {'Voltage Selectivity',num2str(VoltageGradient(1)),'mV/decade' ;'Current Selectivity',num2str(CurrentGradient(1)),'nA/decade'};
            xlRange = 'G5:I6';
            xlswrite([PathName FileName],A,sheet,xlRange)
            %Add the limited ones
            A = {'Voltage Selectivity (<0.2)',num2str(VoltageGradient_Limited(1)),'mV/decade' ;'Current Selectivity (<0.2))',num2str(CurrentGradient_Limited(1)),'nA/decade'};
            xlRange = 'G7:I8';
            xlswrite([PathName FileName],A,sheet,xlRange)
        end
        %Write the number of selectivity plots
        A = {num2str(j)};
        xlRange = ['L' num2str(r-1)];
        xlswrite([PathName FileName],A,sheet,xlRange)
    end
    %Could now format and add a graph!
    % Might also move this code in to a sub function as could be useful - or
    % better still a class like Origin!
    % See http://www.codeproject.com/Tips/536603/Insert-a-Chart-in-Excel-through-Matlab
    % Or to insert as an image see here:
    % http://www.codeproject.com/Tips/536002/Read-an-Excel-File-through-Matlab
    try
        Excel = actxserver('Excel.Application');
    catch
        Excel = [];
        disp('Failed to connect');
    end
    ResultFile = [PathName FileName];
    Workbook = invoke(Excel.Workbooks,'Open', ResultFile);
    set(Excel, 'Visible', 1);
    if(No > 1)
        Excel.Run('ThisWorkBook.plotGraphs'); %if the macro is in the correct file
        %Excel.Run('C:\Users\miw24\Documents\PhD\ExptSummaries\GraphPlotMacro.xlsm!ThisWorkbook.plotGraphs');
    end
    %
    % Chart = Excel.ActiveSheet.Shapes.AddChart;
    % wkbk.ActiveSheet.Shapes.AddChart.Select;
    % %Let us Rename this chart to 'ExperimentChart'
    % Chart.Name = 'VoltageOffsets';
    %
    % %% Delete Default Entries
    % % Let us delete all the entries in the chart generated by defalut
    %
    % ExpChart = Excel.ActiveSheet.ChartObjects('ExperimentChart');
    % ExpChart.Activate;
    % try
    % 	Series = invoke(Excel.ActiveChart,'SeriesCollection',1);
    % 	invoke(Series,'Delete');
    % 	Series = invoke(Excel.ActiveChart,'SeriesCollection',1);
    % 	invoke(Series,'Delete');
    % 	Series = invoke(Excel.ActiveChart,'SeriesCollection',1);
    % 	invoke(Series,'Delete');
    % catch e
    % end
    %
    % %We are left with an empty chart now.
    % %Insert a Chart for Column B
    % NewSeries = invoke(Excel.ActiveChart.SeriesCollection,'NewSeries');
    % NewSeries.XValues = ['=' resultsheet '!N' int2str(r+1) ':N' int2str(r+j)];
    % NewSeries.Values  = ['=' resultsheet '!S' int2str(r+1) ':S' int2str(r+j)];
    % NewSeries.Name    = ['=' resultsheet '!B' int2str(1) ];
    %
    % Excel.ActiveChart.ChartType = 'xlXYScatterLinesNoMarkers';
    %
    % % Set the x-axis
    % Axes = invoke(Excel.ActiveChart,'Axes',1);
    % set(Axes,'HasTitle',1);
    % set(Axes.AxisTitle,'Caption','Experiment')
    %
    % % Set the y-axis
    % Axes = invoke(Excel.ActiveChart,'Axes',2);
    % set(Axes,'HasTitle',1);
    % set(Axes.AxisTitle,'Caption','Results')
    %
    % %Give the Chart a title
    % Excel.ActiveChart.HasTitle = 1;
    % Excel.ActiveChart.ChartTitle.Characters.Text = 'Result vs Experiment';
    %
    % %% Chart Placement
    % Location  =  [  xlcolumn(2) int2str(20)  ];
    % GetPlacement = get(Excel.ActiveSheet,'Range', Location);
    %
    % % Resize the Chart
    %
    % ExpChart.Width = 400;
    % ExpChart.Height= 250;
    % ExpChart.Left  = GetPlacement.Left;
    % ExpChart.Top   = GetPlacement.Top;
    %
    invoke(Excel.ActiveWorkbook,'Save');
    Excel.Quit;
    Excel.delete;
    clear Excel;
else
    %No results so don't even create the excel file
end

end
