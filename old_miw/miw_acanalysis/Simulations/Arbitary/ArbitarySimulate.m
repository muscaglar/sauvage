% ***********************************
% ArbitarySimulate
%   ArbitarySimulate calcs the AC response
%   for a given circuit
%   Note numerator and denominator are the numerator and demoninator of the
%   transfer function for I = G(s).V  Therefore G(s) = 1/Z(s) where Z is the
%   complex impedance.
%   Volts will default to 10mV and F can be a vector or Max freq - in Hz
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
function [ AC ] = ArbitarySimulate( numerator , denonminator , F , volts )

if nargin < 4
    volts = 10e-3;
end

if length(F) == 1
    freq = linspace(0,F,40);
else
    freq = F;
end

W = 2 * pi * freq;
g = tf(numerator,denonminator);
[mag,phase] = bode(g,W) ;


%Put into the output code
AC(:,1) = freq;
AC(:,2) = mag * volts * 1e9;
AC(:,3) = 1 * phase ;%.* 180 ./ pi;

end

