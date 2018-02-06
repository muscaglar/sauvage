% ***********************************
% GHK_CurrentByIon_S
%   Calculate the current due to one ion in GHK equation
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
function [ CurrentS ] = GHK_CurrentByIon_S( z, E , P, ConcI, Conc0 )
%GHK Summary of this function goes here
%   Detailed explanation goes here
PhysicalConsts

CurrentS = P .* z.^2 .* ( ( E .* F_Const.^2)  ./ (R_Const .* T_Const) ) .* ( ( ConcI - Conc0 .* exp(-1 .* GHK_Vs(z,E)) ) ./ ( 1 - exp(-1 .* GHK_Vs(z,E)) ) ); 

%CurrentS = ( ( ConcI - Conc0 .* exp(-1 .* GHK_Vs(z,E)) ) ./ ( 1 - exp(-1 .* GHK_Vs(z,E)) ) ); 

end

