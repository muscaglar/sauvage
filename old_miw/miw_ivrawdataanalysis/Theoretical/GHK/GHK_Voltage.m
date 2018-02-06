% ***********************************
% GHK_Voltage
%   Calculate the reversal potential for these permeabilities
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

function [ E ] = GHK_Voltage( z, P, ConcI, Conc0)
%Calculate the reversal potential
% Note only works where all ions are of the same valency - see Hille ch 14 pg 448
% Needs to be generalised for more complex concentration mixtures

PhysicalConsts

n = max(size(z));
numerator = 0;
denominator = 0;
for i = 1:n
    if z(i) > 0
        numerator = numerator + P(i) * Conc0 ;
        denominator = denominator + P(i) * ConcI ;
    else
        numerator = numerator + P(i) * ConcI ;
        denominator = denominator + P(i) * Conc0 ;
    end
end

E = ((R_Const .* T_Const) / F_Const) * log (numerator / denominator);



end

