% ***********************************
% PlotOsmoticPowerInOrigin
%   Plot the osmotic power in origin for a capillary or set of capillaries
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
function [ output_args ] = PlotOsmoticPowerInOrigin( CapillaryNos, Name , ORG)
%PlotOsmoticPowerInOrigin Plot the osmotic power
% in origina for a capillary or a set of capillaries


[ PowerRaw, OsmosticCurrentXY, OsmosticPowerXY ] = CalcOsmoticPower( CapillaryNos );

% Will use existing Origin connection if passed in allowing you to hold the graph 
if(nargin < 3)
    ORG = Matlab2OriginPlot();
end
%ORG.HoldOn;

%     ORG.PlotScatterError(OsmosticCurrentXY(:,1)',OsmosticCurrentXY(:,2)',OsmosticCurrentXY(:,3)', [Name ' Mean_error']);
%     ORG.xlabel('Concentration Ratio',' ');
%     ORG.ylabel('Osmotic Current','nA');
%     ORG.yComment([Name ' Mean_error']);
%     ORG.logXScale
    
    %Could add trend line
    
    %ORG.HoldOff;
    ORG.PlotScatterError(OsmosticPowerXY(:,1)',OsmosticPowerXY(:,2)',OsmosticPowerXY (:,3)', [Name ' Mean_error']);
    ORG.xlabel('Concentration Ratio',' ');
    ORG.ylabel('Osmotic Power Density','W/m2');
    ORG.yComment([Name ' Mean_error']);
    ORG.logXScale
    ORG.HideActiveWkBk;
    
end

