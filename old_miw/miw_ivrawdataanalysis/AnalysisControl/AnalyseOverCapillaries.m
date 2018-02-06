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

function [ ouput_arg ] = AnalyseOverCapillaries(Caps)
%Analyse Over Capillaries

if(exist('Caps','var'))
    %*************************************************************************
    Offset = [];
    for i = Caps
        disp(['Capillary: ' num2str(i)]);
        CapNo = i;
        %May need to load experiments and find selectivities to remove
        %offsets
        %Es = LoadExperiments(CapNo)
        %Selectivity(Es)
        
        %AnalyseByCapillary( CapNo, VOffset,1)
        AnalyseByCapillary( CapNo, 0,1);
        
        
    end
    if exist('ACAnalysisByCapillary','file') > 0
        ACAnalysisByCapillary( Caps );
    end
    
else
    warning('You need to have defined the Caps variable')
end
end