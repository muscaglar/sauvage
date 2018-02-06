% ***********************************
% IVClean
%   Remove bad data from an IV matrix 
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

function [ IV_Clean ] = IVClean( IV, TH )
%IVClean  - will take an IV curve and remove clearly rubbish points  - ie
%those where it was lost contact.
%   Fit a pretty flexible model and look for the points which acount for a
%   lot of the error.
%   Note need to not remove points which are noise  - only want to remove
%   points which are clearly in error.

if nargin < 2
    TH = 2.5;
end
p1 = polyfit(IV(:,2),IV(:,1),3);
I_Fit = polyval(p1,IV(:,2));
Error = (IV(:,1) - I_Fit).^2;
PercentError = Error ./ sum(Error);
MeanPercentError = mean(PercentError);
ToKeep = PercentError < (TH * (MeanPercentError));
IV_Clean = IV(ToKeep,:);


%Strip out where value is at saturation limit
MaxLimit = 18.5;
MinLimit = -19.4;
if(or((max(IV_Clean(:,1)) > 22),(min(IV_Clean(:,1)) < -22)) )
    MaxLimit = 190;
    MinLimit = -190;
end
if (or((max(IV_Clean(:,1)) > 500),(min(IV_Clean(:,1)) < -500)) )
    MaxLimit = 50000;
    MinLimit = -50000;
end
IV_Clean = IV_Clean((IV_Clean(:,1)<MaxLimit)&(IV_Clean(:,1)>MinLimit),:);

end

