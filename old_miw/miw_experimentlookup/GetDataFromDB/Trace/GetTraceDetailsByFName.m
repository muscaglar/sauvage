% ***********************************
% GetDetailsByFName
%   For a given FileName find the Trace object and details
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
function [ TraceDate, TraceNo, TraceObj, TraceID ] = GetTraceDetailsByFName( FileName )
%GETTRACEDETAILSBYFNAME Interpret the filename into a Date and number and
%then use this to find the Data from the DB for this trace

[ TraceDate, TraceNo, ~] = FileNameInterpret( FileName );
[ TraceID, TraceObj  ] = GetTraceDetailsByDateNo( TraceDate, TraceNo );

end

