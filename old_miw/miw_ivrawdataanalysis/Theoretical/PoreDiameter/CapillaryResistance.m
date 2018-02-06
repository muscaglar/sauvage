% ***********************************
% CapillaryResistance
%   Calculate capillary resistance and break down into Cone and Access resistance
%   Note taper angle in radians, all values in SI units
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

function [ Resistance, R_Cone, R_Access ] = CapillaryResistance( Diameter, SolutionConductivity, TaperAngle )
%Solve the resistance of a capillar from measurements
% ref

if nargin < 3
    TaperAngle = 5 * pi /180;
end

R_Cone = 2 / ( Diameter * pi*SolutionConductivity*tan(TaperAngle) );
R_Access = PoreAccessResistance(Diameter,SolutionConductivity );

Resistance = R_Cone + R_Access;

end
