% ***********************************
% PlotOsmoticCurrentInOrigin
%   PLot the current that would be equivalent to osmotic power in origin
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
function [ output_args ] = PlotOsmoticPowerInOrigin( CapillaryNos, Name , ORG)
%PlotOsmoticPowerInOrigin Plot the osmotic power
% in origina for a capillary or a set of capillaries

%May want to call this on mutile different sets of data - ie may call from
%cahrge selective data sets - but to begin with this caode will juat take
%sets of capillry nos

[ PowerRaw, OsmosticCurrentXY, OsmosticPowerXY ] = CalcOsmoticPower( CapillaryNos );



if(nargin < 3)
    ORG = Matlab2OriginPlot();
end
%ORG.HoldOn;

    ORG.PlotScatterError(OsmosticCurrentXY(:,1)',OsmosticCurrentXY(:,2)',OsmosticCurrentXY(:,3)', [Name ' Mean_error']);
    ORG.xlabel('Concentration Ratio',' ');
    ORG.ylabel('Osmotic Current','nA');
    ORG.yComment([Name ' Mean_error']);
    ORG.logXScale
    ORG.HideActiveWkBk;
    %Could add trend line
  

end

