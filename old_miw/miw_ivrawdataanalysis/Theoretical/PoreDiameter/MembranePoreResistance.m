% ***********************************
% MembranePoreResistance
%   Calculate the resitance expected when a pore of a given size is in a
%   membrane taking into account access resistance and capillary
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

function [ R_Total, R_Membrane, R_Pore, R_Access ] = MembranePoreResistance( Diameter_nm, Soln_Conductivity_S_m, BareResistance, Thickness_nm)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

if nargin < 4
    Thickness_nm = 0.6;
end
if nargin < 3
    BareResistance = 0;
end
L = Thickness_nm / 1e9;
S = Soln_Conductivity_S_m;
r = Diameter_nm / 2e9;

R_Pore = L ./ (pi *S * r.^2);
R_Access = PoreAccessResistance( 2.*r,S );

%Note there is an access resistance on each side of the pore
R_Membrane = R_Pore + 2 * R_Access;

R_Total = R_Membrane + BareResistance;

end

