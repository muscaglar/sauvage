% ***********************************
% FileNameInterpret
%   
%   
%   (C) Michael Walker 2015-16 - All Rights Reserved
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
function [ date, no, details, ext] = FileNameInterpret( FileName )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
F = strsplit(FileName, '.');
ext = F{2};
C = strsplit(F{1}, '_');

date = str2num(C{1});
%Check the 2nd entry is there
if(max(size(C)) > 1)
no = str2num(C{2});
else
    no = 0;
end
%Check the 3rd entry is there
if(max(size(C)) > 2)
    details = (C{3});
else
    details = 'unknown';
end
end

