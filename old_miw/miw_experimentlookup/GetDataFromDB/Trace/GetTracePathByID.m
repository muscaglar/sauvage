% ***********************************
% GetTracePathByID
%   Get the path to a trace based on the ID
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
function [ FolderPath, TraceDate, TraceNo, TraceObj ] = GetTracePathByID( TraceID )
%GETTRACEPATHBYNO 
% Returns the file path to a trace from the trace ID
% Uses ID to get Data and No and then uses this to get the Details

[ TraceDate, TraceNo, TraceObj ] = GetTraceDetails( TraceID );
[ FolderPath ] = GetTracePathByDateNo( TraceDate, TraceNo );
disp(['TraceID ' num2str(TraceID) ' is No: ' num2str(TraceNo) ' from ' GetDateString(TraceDate)]);

end

