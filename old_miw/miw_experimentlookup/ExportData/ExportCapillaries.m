% ***********************************
% Export Capillaries
%   Export many experiments to same file
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
function ExportCapillaries(Caps, FileName, PathName )
FileRoots

if nargin<3
    PathName = ExperimentOutputRoot;
end
if nargin < 2
    FileName = 'ExptOutput.xlsm';
end

if(exist('Caps','var'))
    for i = Caps
        i
        WriteCappillaryExcelSheet(i,FileName, PathName );
    end
else
    warning('You need to have defined the Caps variable')
end