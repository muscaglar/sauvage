% ***********************************
% AnalyseByExperimentIDs
%   Run the IV analyse code on all a set of data files defined by
%   ExperimentIDs
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

function [ Data ] = AnalyseByExperimentIDs( EIDs , VoltageZeroOffset, save)
%Load all the experiments with this capillary

if nargin < 3
    save = 1;
    warning('Save not set');
end
if nargin < 2
    VoltageZeroOffset = 0;
end

for e = EIDs
    DB = DBConnection;
    E = Experiments(DB,e);
    if(E.getid >0)
        
        id = E.getid();
        Date = GetNumericDate(E.getDate());
        Number = E.getNo();
        
        [ Data ] = AnalyseByDateNo( Date, Number, VoltageZeroOffset, save  );
        
    else
        warning(['This experiment ID doesn''t exist: ' num2str(e)]);
    end
end
end