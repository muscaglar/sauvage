% ***********************************
% GHK_SumSquareResidsOfCurrent
%   Calculate Sum Sqaure resids
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

function [ Error] = GHK_SumSquareResidsOfCurrent( IV, z, ConcI, Conc0, Params0  )
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here

Params = (Params0(1:2) .^2);
[It ,~] = GHK_TotalCurrent( z, IV(:,2) , Params, ConcI, Conc0 );

It = It + Params0(3);

Error = sum( (IV(:,1) - It).^2 );

end

