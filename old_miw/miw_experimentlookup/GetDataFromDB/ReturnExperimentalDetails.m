% ***********************************
% ReturnExperimentalDetails
%   For a given Date, No OR ExperimentID return the experimental detials
%   and the experiment object
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
function [ Data, E] = ReturnExperimentalDetails( Date, No )
%Load the Experimental detials for a capillary
%Note if only one argument is specified it is treated as the experiment id


%may need a file Root
DB = DBConnection;

if nargin == 2
    E = Experiments(DB);
    [ Da ] = GetDBDate( Date );
    %Note that a date and no combination should be unique so will not check
    %here but will need to be able to check.
    str = ['Date LIKE ''' char(Da.toString) ''' AND No = ''' num2str(No) ''' '];
    E.SELECT(str);
    E.CloseConnection();
else
    if nargin == 1
        id = Date;
        E = Experiments(DB,id);
    end
end
if(E.getid() > 0)
    %Could also get capillary size info - from the capillary entry
    C = Capillaries(DB);
    C.SELECT(E.getCapillary);
    if(C.getid() > 0)
        %Now read out of the Experiment Object all of the required info.
        Data = {E.getid double(E.getCapPh) double(E.getResPh) char(C.getType) C.getCapNo char(C.getExptType) double(E.getReservoirConc) double(E.getCapillaryConc) double(E.getSuppressed) double(E.getSealed)};
    else
        %Capillary doesn't exist but experiment does  - could transfer out
        %the Expt details only but this situation shouldn't occur
        error(['Cannot find capillary for expt: ' num2str(E.getid()) ' Cap: ' num2str(E.getCapillary)])
        %Data = 0;
        %E = 0;
    end
    
else
    Data = 0;
    %E = 0;
end

end

