% ***********************************
% SealAnalysisByCapillary
%   Plot the Bare versus sealed resistance for a number of Capillaries
%   passed in as a vector. The code will split this up between membranes so
%   they do not need to be separated.
%   
%   (C) Michael Walker 2015-6 - All Rights Reserved
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

function PlotSealAnalysisByCapillaries(Capillaries, OP, prefix, SealedSuppression)
% Script to complete Seal Analysis  - Take a vector of capillaries
% Note the script will separate by membrane - so can pass in full mix 
if nargin < 2
    OP = 0;
end
if nargin < 3
    prefix = '';
end
%Need resistance analysis of Capillaries to have been done.
DB = DBConnection;

clear ResistanceMatrix;
j = 1;
if nargin < 4
    [ResistanceMatrix, ResistanceRatios] = SealAnalysisByCapillaries(Capillaries, 1);
else
    [ResistanceMatrix, ResistanceRatios] = SealAnalysisByCapillaries(Capillaries, 0, SealedSuppression);
end
%Now Plot the Sealed Against the Bare resistance.  %Note need to sort by
%type - either select on Capillaries or here.
MaxMem = max(ResistanceMatrix(:,3));
MinMen = min(ResistanceMatrix(:,3));

% **************************************************************************
%Now do the plotting by membrane  - not capillary
 if OP == 1
   ORG = Matlab2OriginPlot();
   %ORG.HoldOff;
   RScatterPlot = [prefix 'RScatter'];
   CumulativePlot = [prefix 'Cumulative'];
 end
 figure(1);
 %hold off;  - leave hold off so you can run this code multiple times and
 %plot into it
X_Fit = linspace(min(ResistanceMatrix(:,1)),max(ResistanceMatrix(:,1)),5);    

for m = MinMen:1:MaxMem
    %Check if there is data for this membrane - as have cosntructed the for
    %loop from max and min.
    if(max(ResistanceMatrix(:,3) == m) > 0);
        if(m == 1)
            warning('Plotting for the generic membrane  -  a possible mix of different membranes in the same resilt set');
        end
        
        subplot(1,2,1);
        Rows = (ResistanceMatrix(:,3) == m);
        loglog (ResistanceMatrix(Rows,1), ResistanceMatrix(Rows,2),'.');
        hold all;
        title('Sealed Versus Bare Resistance');
        xlabel('Bare Resitance MOhms');
        ylabel('Sealed Resistance MOhms');
        %Add and plot fit lines
        [ Parameters, StdErrors, Y_Fit, r2] = LineFit( log10(ResistanceMatrix(Rows,1)) , log10(ResistanceMatrix(Rows,2)), log10(X_Fit) );
        plot(X_Fit,10.^Y_Fit)

        %Now Calc and plot the cumulative resitance Ratio plot
        subplot(1,2,2);
        
        RR = ResistanceRatios(Rows);
        X = sort(RR);
        n = max(size(X));
        Y = 1:n;
        Y = Y./n;
        X = [0 X];
        Y = [0 Y];
        plot(X,Y,'-');
        title('Resistance Ratio Cumulative Probability');
        xlabel('Resitance Ratio');
        ylabel('Cumulative Probability');
        hold all;
        %Get legend info for this membrane.
        
        
        
        
        %Plot to Origin here
        if OP == 1
            M = Membranes(DB,m);
            RScatterPlot = ORG.Figure(RScatterPlot);
            ORG.HoldOn
            ColourNo = ORG.NoPlots;
            ORG.PlotScatter(ResistanceMatrix(Rows,1)', ResistanceMatrix(Rows,2)',['Data' num2str(m)],ORG.ColourPicker(ColourNo));
            ORG.xlabel('Bare Resistance','M Ohms')
            ORG.ylabel('Sealed Resistance','M Ohms')
            %Note could use DB to get membrane details
            if nargin < 4
                ORG.yComment(['M: ' num2str(m) ' ' char(M.getName()) ' ' char(M.getDetails())]);
            else
                ORG.yComment(['M: ' num2str(m) ' ' char(M.getName()) ' ' ConcatVectorToSQL( SealedSuppression, 'S')]);
            end
            ORG.PlotLine(X_Fit,(10.^Y_Fit),['Fit' num2str(m)],ORG.ColourPicker(ColourNo));
            ORG.yComment(['Fit to Membrane No: ' num2str(m) ' ' num2str(Parameters(1),3) ' r2:' num2str(r2,3) ' err:' num2str(StdErrors(1),3)]);
            ORG.HideActiveWkBk()
            
            skip = 1;
            if(skip)
            else
            %Plot the Cumulative Values
            CumulativePlot = ORG.Figure(CumulativePlot);
            ORG.PlotLine(X', Y,['Data' num2str(m)],ORG.ColourPicker(ColourNo));
            ORG.HoldOn;
            ORG.xlabel('Resitance Ratio',' ')
            ORG.ylabel('Cumulative Probability',' ')     
            if nargin < 4
                ORG.yComment(['M: ' num2str(m) ' ' char(M.getName()) ' ' char(M.getDetails())]);
            else
                ORG.yComment(['M: ' num2str(m) ' ' char(M.getName()) ' ' ConcatVectorToSQL( SealedSuppression, 'S')]);
            end
            ORG.HideActiveWkBk()
            end
        end
    end
end
if OP == 1
    RScatterPlot = ORG.Figure(RScatterPlot);
    ORG.logXScale;
    ORG.logYScale;
    ORG.title('Sealed Versus Bare Resistances');
    CumulativePlot = ORG.Figure(CumulativePlot);
    %ORG.logXScale;
    %ORG.logYScale;
    ORG.title('Cumulative Resistance Ratio');
    ORG.Disconnect;
    ORG.HoldOff
end

end