% ***********************************
% GetDataByNo
%   Return the file path to the Raw data for a given name and no
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
function [ FileName, PathName, Date, No, E, id ] = GetDataByID( ExperimentID , AllowDownload )
    if nargin < 3
        %Default to allow download
        AllowDownload = 1;
    end

[ E, No, id, Date ] = GetExperimentDetails( ExperimentID ) ;
[ FileName, PathName ] = GetDataByNo(Date, No, AllowDownload );

end

