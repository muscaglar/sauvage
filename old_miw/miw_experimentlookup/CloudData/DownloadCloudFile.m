% ***********************************
% DownloadCloudFile
%   Generic - not complete
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
function [  FileName, PathName, FilePath ] = DownloadCloudFile( Date, No, Container )
%DOWNLOADCLOUDFILE Summary of this function goes here
%   Detailed explanation goes here
error('Not finished');
FileRoots;
FileName = [];
PathName = [];
FilePath = [];
if(exist('AllowCloudDownload', 'var'))
    if AllowCloudDownload == 1
        DA = DataAccess;
        FilePath = char(DA.getTranslocationsFile(GetDBDate( Date ), No));
        [PathName,name,ext] = fileparts(FilePath);
        FileName = [name ext];
        PathName = [PathName '/']; 
    end
end

end

