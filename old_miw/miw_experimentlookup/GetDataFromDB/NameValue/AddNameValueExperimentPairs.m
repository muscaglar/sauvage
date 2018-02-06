% ***********************************
% AddNameValueExperimentPairs
%   Provide an interface to add name value pairs to Experiments
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
function AddNameValueExperimentPairs(Name ,  Value)

if nargin < 1
    Name = inputdlg('Enter the Name of this NameValuePair');
    Name  = Name {1,1}
end

Eid = 1;
while(Eid >0)
    Eid = inputdlg('Enter the Experiment ID (0 to quit)');
    Eid  = str2double(Eid {1,1});
    
    if(Eid > 0)
        if nargin < 2
            min = inputdlg(['Enter the value for EID: ' num2str(Eid)]);
            Value  = str2double(min {1,1});
        end
        disp(['Experiment: ' num2str(Eid) ' - ' num2str(Value) ' ']);
        [ rValue, rStringValue, rid ] = UpdateNameValueExperiment( Eid , Name, Value);
        
    end
end