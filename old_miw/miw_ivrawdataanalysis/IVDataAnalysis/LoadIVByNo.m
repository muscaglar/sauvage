% ***********************************
% LoadIVByNo
%   Load IV data as a matrix from Date and No
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

function [ IV, FileName, PathName ] = LoadIVByNo(  Date, No  )

if nargin < 2
    %if only one argument then treat Date as an experiment ID
   [ E, No, id, Date ] = GetExperimentDetails( Date ) ;
end

[ FileName, PathName ] = GetDataByNo( Date, No );
[ IV, FileName, PathName] = LoadIV( FileName, PathName  );

end

