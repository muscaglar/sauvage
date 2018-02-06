% ***********************************
% EtchingSelectivitiesPlot
%   Plot the selectivity at each time point
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

function [ output_args ] = EtchingSelectivitiesPlot( CapillaryIDs, Name )
%Plot all of the actuall selectivities for a range of capillaries  

if nargin < 2
    Name = '';
end

%Plot the selectvities of all the capillaries on the same graph - May be
%able to use code or use Selectity to Load all data and then just re plot

%Note need to run over capillaries as do no want to group togther
for C = CapillaryIDs
    [ EtchTime, rStringValue, rid ] = UpdateNameValueCapillary( C, 'EtchTime');
    Comment = [Name '_' num2str(EtchTime) 'Secs'];
    SelectivityPlotInOrigin( C ,0.0002,0.2,Name, Comment);
    
end

end

