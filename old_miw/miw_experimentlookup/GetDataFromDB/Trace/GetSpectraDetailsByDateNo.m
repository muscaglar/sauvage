% ***********************************
% GetSpectraDetailsByDateNo
%   For a given Trace Date, File No, return the experimental details
%   
%   (C) Michael Walker 2015 - All Rights Reserved
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
function [  SpectraID, SpectraObj ] = GetSpectraDetailsByDateNo( Date, No )
%GETTRACEDETAILSBYDATENO Summary of this function goes here
%   Detailed explanation goes here

DB = DBConnection;
S = Spectra(DB);

[ Da ] = GetDBDate( Date );
str = ['Date LIKE ''' char(Da.toString) ''' AND No = ''' num2str(No) ''' '];
S.SELECT(str);
S.CloseConnection;
if(S.getid() > 0)
    SpectraID = S.getid();
    SpectraObj = S;
else
    SpectraID = 0;
    SpectraObj = 0;
end
    

end

