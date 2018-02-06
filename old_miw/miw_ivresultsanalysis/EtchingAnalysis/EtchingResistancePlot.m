% ***********************************
% EtchingResistancePlot
%   Plot the change in resistance with etch time
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
function [ Time, Resistance, TimeConst ] = EtchingResistancePlot( CapillaryIDs , OP, Name)
%ETCHINGRESISTANCEPLOT Plot the change in resistance with etching - works
%either for within a single capillary or over several

if nargin < 3
    Name = '';
end
if nargin < 2
    OP = 0;
end

%Load all the experiments - also get the EtchTimes - then plot
Resistance = [];
Time = [];
if max(size(CapillaryIDs)) > 1
    for c = CapillaryIDs;
        [ rValue, rStringValue, rid ] = UpdateNameValueCapillary( c, 'EtchTime');
        Time = [Time rValue];
        [ Expts, No, ExptIDs ] = LoadExperiments( c, 1, [0 16] );
        %Should now check I have the correct experiment - but can usually
        %take the first
        E = Expts(1);
        Resistance = [Resistance E.getResistance()]; 
    end
else
    [ Expts, No, ExptIDs ] = LoadExperiments( CapillaryIDs, 1, [0 16] );
    
    Resistance = [];
    Time = [];
    for i = 1:No
        E = Expts(i);
        
        [ rValue, rStringValue, rid ] = UpdateNameValueExperiment( E.getid() , 'EtchTime');
        if (rid > 0)
            Resistance = [Resistance E.getResistance()];
            Time = [Time rValue];
        end
    end
end
hold off;
plot(Time, Resistance);
%Calc the time constant and fit to the data

[ Parameters, Resistance_Fit, Time_Fit ] = ExponentialFit( Time,Resistance );
TimeConst = Parameters(3);
UpdateNameValueCapillary( CapillaryIDs(1), 'EtchResistanceTimeConst', TimeConst )

hold on;
plot(Time_Fit, Resistance_Fit,'-');
Parameters;

if OP == 1
    ORG = Matlab2OriginPlot();
    ORG.PlotLine(Time, Resistance,[Name '_Resistance'],'Red')
    ORG.xlabel('Time','s');
    ORG.ylabel('Resistance','M Ohms');
    ORG.yComment([Name '_Resistance']);
    ORG.title([Name '_Resistance']);
    ORG.HideActiveWkBk()
    ORG.HoldOn;
    ORG.PlotLine(Time_Fit, Resistance_Fit,[Name '_Resistance'],'Blue')
    ORG.xlabel('Time','s');
    ORG.ylabel('ResistanceFit','M Ohms');
    ORG.yComment([Name '_FitResistance']);
    ORG.HideActiveWkBk()
    ORG.HoldOff;
    ORG.Disconnect();
end
end

