% ***********************************
% LoadIV
%   For a given file path return the IV data from the file as a matrix
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

function [ IV, FileName, PathName ] = LoadIV( FileName, PathName  )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
if nargin < 1
    if exist(DataRootHDD)
        [FileName, PathName] = uigetfile({'*.txt','All IV Files';},'Choose IV Data', DataRootHDD);
    else
         [FileName, PathName] = uigetfile({'*.txt','All IV Files';},'Choose IV Data', DataRoot);
    end
end

IVFile = importdata([PathName FileName]);
IV = IVFile.data;
IVDetails = IVFile.textdata;
    
%AC(:,3) = -1 *  AC(:,3);

end

