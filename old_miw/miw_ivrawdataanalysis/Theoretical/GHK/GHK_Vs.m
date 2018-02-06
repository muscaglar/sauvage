% ***********************************
% GHK_Vs
%   Calculate useful constant
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

function [ Vs ] = GHK_Vs( z, E, F, T, R )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
PhysicalConsts
if nargin < 5
    %Gas constant.
    R = R_Const;
end
if nargin < 4
    %Set temperature as 300K
    T = T_Const;
end
if nargin < 3
    %Set Faraday http://en.wikipedia.org/wiki/Faraday_constant
    %Its the charge per Mol of electrodes
    F = F_Const ;
end
if nargin < 2
    %Set voltage to 1V if not defined
    E = 1;
end
if nargin < 1
    %Set z to 1 if not defined
    z = 1;
end
Vs = z .* ((E .* F) ./ ( R .* T ));

end

