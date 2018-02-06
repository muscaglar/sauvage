% ***********************************
% getNameValueMatrix
%   Return all the NameValues with this name as a matrix
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

function [ Matrix ] = getNameValueMatrix( Name )
%GETNAMEVALUEMATRIX Summary of this function goes here
%   Detailed explanation goes here

DB = DBConnection();
NV = AnalysisValues(DB);
%Name = 'ResistanceAwayIncrease';
NV.SELECT(['Name LIKE ''' Name ''' ']);

Matrix = [];

isNext = 1;
i = 1;
if NV.getid > 0
    while isNext
        Matrix = [Matrix; NV.getValue NV.getnvCapillary];
        isNext = NV.NextResult();
        i = i+1;
    end
else
    %
    disp(['NO Results for this Analysis Value Name: ' Name]);
    Matrix = [];
end


end

