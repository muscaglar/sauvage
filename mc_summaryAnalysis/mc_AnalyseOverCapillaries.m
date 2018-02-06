% ***********************************
% AnalyseOverCapillaries
%   Run raw data Analysis over capillaries as in vector
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

function [ final_summary ] = mc_AnalyseOverCapillaries(Caps)
%Analyse Over Capillaries
%Problem Caps: 399
%FET Caps: ,545,546,552,553,560,561,562, 576, 577, 588, 589, 590,596, 597 
%
if(exist('Caps','var'))
    %*************************************************************************
    Offset = [];
   final_summary =[];
    % final_summary = ['Capillary ID','Date', 'Number','Voltage Intercept','Resistnace','Rectification 1','Rectification 2', 'Rectification 3','Current Intercept'];
    j = 1;
    for i = Caps
        disp(['Capillary: ' num2str(i)]);
        CapNo = i;
        my_data{j}(1) = i;
        [ ~, my_data{j} ] = mc_AnalyseByCapillary( CapNo, 0,1, my_data{j});
        final_summary = [final_summary; my_data{j}];
        j=j+1;
    end
    if exist('ACAnalysisByCapillary','file') > 0
        ACAnalysisByCapillary( Caps );
    end
    
else
    warning('You need to have defined the Caps variable')
end
end