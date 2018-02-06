% ***********************************
% AnalyseByDateNo
%   Fine and analyse a file by its Date and File number. Will also run the
%   appropriate analysis based on the file name.
%
%   (C) Michael Walker 2015-6 - All Rights Reserved
%
% The above copyright notice and this permission notice shall be included in
% all copies or substantial portions of the Software.
%
% THE SOFTWARE IS PROVIDES IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
% AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
% LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
% OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
% SOFTWARE.
%%***********************************

function [ Data ] = AnalyseByDateNo( Dates, Numbers, VoltageZeroOffset, save )
%ANALYSEBYDATENO 

%Note could check Dates and Numbers are the same size, or if not then just
%use a single Date.

if nargin < 4
    save = 0;
    warning('Save not set');
end
if nargin < 3
    VoltageZeroOffset = 0;
end

        i = 1;
        for No = Numbers
            [ FileName, PathName ] = GetDataByNo( Dates(i), No );
            %Now determine the correct analysis to run - either from
            %filename or a type code in the pairr values table
            if(not(isempty(strfind(FileName, 'AC'))))
                warning('Not an IV Curve');
            else
                %Assume it is an IV Curve - unless other info
                [ Data ] = IVAnalyse(save, FileName, PathName, VoltageZeroOffset, 0);
            end
            i = i+1;
        end


end

