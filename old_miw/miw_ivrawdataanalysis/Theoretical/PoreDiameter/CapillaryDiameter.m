% ***********************************
% CapillaryDiameter
%   Solve the capillary size and break down into Cone and Access resistance
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

function [ Diameter_nm, R_Cone, R_Access, Diameter ] = CapillaryDiameter( Resistance, SolutionConductivity, TaperAngle )
%Solve the size of a capillary - using both access resistance and pore
%resistance

if nargin < 3
    TaperAngle = 5 * pi /180;
end
if nargin < 2
    SolutionConductivity = 8.6;
end

Diameter = (4*cot(TaperAngle)+pi) / (2*pi*Resistance*SolutionConductivity);

R_Cone = 2 / ( Diameter * pi*SolutionConductivity*tan(TaperAngle) );
R_Access = 1 ./ ( 2 .* SolutionConductivity .* Diameter );

Diameter_nm = 1e9 * Diameter;

disp(['Capillary Resistance: ' num2str(Resistance,3) ', Diameter: ' num2str(Diameter_nm,3) 'nm, Rcone: ' num2str(R_Cone,3) ' R_access: ' num2str(R_Access,3) ]);

end

