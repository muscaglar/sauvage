% ***********************************
% ConstructDataPath
%   
%   
%   (C) Michael Walker 2015 - 2016 - All Rights Reserved
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
function [ PathName, DateStr ] = ConstructDataPath( Date, Root, AllowCreate )
%CONSTRUCTDATAPATH Construct the path to the Data folder using the correct
%HDD or computer version
% Also return the DateStr as this is quite useufl for subsequent code
DateStr = GetDateString( Date );
if nargin < 3
    AllowCreate = 0;
end
if nargin < 2
    FileRoots;
    %Need to work out whether to look on HDD or on internal HDD
    PathName = [DataRoot '/' DateStr '/'];
    if exist(PathName,'dir') == 0
        PathName = [DataRootHDD '/' DateStr '/'];
    end
else
    PathName = [Root '/' DateStr '/'];
    if AllowCreate == 1
        if exist(PathName,'dir') == 0
           mkdir(Root,DateStr);
        end
    end
end

if exist(PathName,'dir') == 0
    warning('Cannot find the folder of data for this date')
end

end

