% ***********************************
% NernstPotential
%   Caculate the Nernst potential for a given 2 concentrations - assumes
%   perfectly selective.
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

function [ Voltage_mV ] = NernstPotential( Conc1, Conc2 )
%NERNSTPOTENTIAL Calculate the nernst potential
%   http://en.wikipedia.org/wiki/Nernst_equation
PhysicalConsts
z = 1;
Voltage = 2.3026 * R_Const * (T_Const / (z * F_Const)) .* log10((Conc1 ./ Conc2));

Voltage_mV = Voltage * 1000;

end

