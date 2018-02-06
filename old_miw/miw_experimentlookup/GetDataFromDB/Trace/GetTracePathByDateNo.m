% ***********************************
% GetTracePathByDateNo
%   Find the filepath for a Trace based on the date and No
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
function [ FolderPath ] = GetTracePathByDateNo( Date, No )
%GETTRACEBYDATENO Summary of this function goes here
%   Detailed explanation goes here

%Construct the path 
[PathName, DateStr] = ConstructDataPath( Date);

FolderName = [DateStr '_' num2str(No)];

FolderPath = [PathName FolderName];

if exist(FolderPath,'dir') == 0
    warning('Cannot find the folder of Trace data')
end

end

