% ***********************************
% MembranePoreDiameter
%   Calculate the size of a pore from resistance values
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

function [ Diameter_nm, R_Pore, R_Access,R_Channel, G_ns, D_Golov ] = MembranePoreDiameterConductivityChange( AfterResistance,BeforeResistance, Soln_Conductivity_S_m, Thickness_nm )
% Calc the size of a pore in a membrane - taking into account the
% resistance of the capillary - but discounting its access resistance

% Using and http://jgp.rupress.org/content/66/4/531.full.pdf  - Access resistance
% of a small circular pore
% And simple Channel resistance

%All Values Passed in as SI, except thickness in nm
%Returns diameter in nm

if nargin < 4
    Thickness_nm = 0.6;
end
if nargin < 3
    Soln_Conductivity_S_m = 7.81;
end
S = Soln_Conductivity_S_m;

S_After = 1/AfterResistance;
S_Before = 1/BeforeResistance;
% Now use parallel nature of conductivity to try condutvity of pore.
S_Delta = S_After - S_Before ;

%assume the pore is all of the conductivity change
R_Pore = 1/ S_Delta;

L = Thickness_nm / 1e9;
%Now calc the resistance change due to the pore in graphene

G_ns = 1e9 /R_Pore ;

%Now solve the combined pore and access resistance for r
n = 2;  %No access resistances  - ie both sides n = 1 or 2  - should I do the inside of the capillary differntly
a = R_Pore * 4 * S;
b = -n;
c = - 4 * L/pi;
%I'm interested in the positive root.
PoreRadius = ( (-b) + ( (b^2) - 4*a*c )^0.5 ) / ( 2*a );

Diameter_nm = 2 * PoreRadius * 1e9;

R_Channel = L /(pi * S * PoreRadius^2 ) ;
R_Access = PoreAccessResistance( 2*PoreRadius , S );


%Golovchenko Method http://golovchenko.physics.harvard.edu/KuanEtAl2015.pdf
% Using: http://iopscience.iop.org/article/10.1088/0957-4484/22/31/315101/pdf
% and http://jgp.rupress.org/content/66/4/531.full.pdf  - Access resistance
% of a small circular pore
D_Golov = (1/(2*S*R_Pore)) * (1 + ( 1 + ((16*S*L*R_Pore)/(pi) )  )^0.5 );


end

