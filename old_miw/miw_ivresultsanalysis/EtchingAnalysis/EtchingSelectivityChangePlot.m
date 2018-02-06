% ***********************************
% EtchingSelectivityPlot
%   Plot the change in selectivity with etch time and fit an exponential
%   function to it
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

function [Time, Selectivity,ISelectivity, TimeConst, ITimeConst] = EtchingSelectivityChangePlot(CapillaryIDs, OP, Name)

if nargin < 3
    Name = '';
end
if nargin < 2
    OP = 0;
end

Time = [];
Selectivity = [];
ISelectivity = [];
if length(CapillaryIDs) > 1
    for C = CapillaryIDs
        [ TrValue, ~, Trid ] = UpdateNameValueCapillary( C, 'EtchTime');
        
        [ VrValue, ~, Vrid ] = UpdateNameValueCapillary( C, 'SelectivityVoltage_<0.1');
        
        [ IrValue, ~, Irid ] = UpdateNameValueCapillary( C, 'SelectivityCurrent_<0.1');
        
        if Trid > 0 && Vrid > 0 && Irid > 0
            Time = [Time TrValue];
            Selectivity = [Selectivity VrValue];
            ISelectivity = [ISelectivity IrValue];
        end
    end
    subplot(1,2,1)
    plot(Time, Selectivity);
    xlabel('Time (S)');
    ylabel('Selectivity ( mV/log(M) )');
    [ Parameters, Selectivity_Fit, Time_Fit ] = ExponentialFit( Time,Selectivity );
    TimeConst = Parameters(3);
    UpdateNameValueCapillary( CapillaryIDs(1), 'EtchSelectivityTimeConst', TimeConst );
    hold on;
    plot(Time_Fit, Selectivity_Fit,'-');
    subplot(1,2,2);
    plot(Time, ISelectivity);
    xlabel('Time (S)');
    ylabel('Current Selectivity ( nA/log(M) )');
    [ Parameters, ISelectivity_Fit, Time_Fit ] = ExponentialFit( Time,ISelectivity );
    ITimeConst = Parameters(3);
    UpdateNameValueCapillary( CapillaryIDs(1), 'EtchCurrentSelectivityTimeConst', ITimeConst );
    hold on;
    plot(Time_Fit, ISelectivity_Fit,'-');
    
    if OP == 1
        ORG = Matlab2OriginPlot();
        ORG.PlotLine(Time, Selectivity,[Name '_Select'],'Red')
        ORG.xlabel('Time','s');
        ORG.ylabel('Selectivity','mV/Log(M)');
        ORG.yComment([Name '_Select']);
        ORG.title([Name '_Select']);
        ORG.HideActiveWkBk()
        ORG.HoldOn
        ORG.PlotLine(Time_Fit, Selectivity_Fit,[Name '_Select'],'LT Magenta')
        ORG.xlabel('Time','s');
        ORG.ylabel('Selectivity','mV/Log(M)');
        ORG.yComment([Name '_FitSelect']);
        ORG.title([Name '_FitSelect']);
        ORG.HideActiveWkBk()
        ORG.HoldOff;
        ORG = Matlab2OriginPlot();
        ORG.PlotLine(Time, ISelectivity,[Name '_ISelect'],'Blue')
        ORG.xlabel('Time','s');
        ORG.ylabel('Selective Current','nA/Log(M)');
        ORG.yComment([Name '_ISelect']);
        ORG.title([Name '_ISelect']);
        ORG.HideActiveWkBk()
        ORG.HoldOn
        ORG.PlotLine(Time_Fit, ISelectivity_Fit,[Name '_ISelect'],'Cyan')
        ORG.xlabel('Time','s');
        ORG.ylabel('Selective Current','nA/Log(M)');
        ORG.yComment([Name '_ISelectFit']);
        ORG.title([Name '_ISelectFit']);
        ORG.HideActiveWkBk()
        ORG.HoldOff;
        
        ORG.Disconnect();
    end
    
else
    Time = []; Selectivity = []; TimeConst = []; ITimeConst = [];
end
end