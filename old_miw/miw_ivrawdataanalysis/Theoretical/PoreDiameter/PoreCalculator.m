% ***********************************
% PoreCalculator
%   Interface to aid Pore resistance caluclations - in development
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


% Interface to allow you to calculate the Pore size or Resistance
No  = inputdlg('Enter Solution Conductivity - 1M NaCl is 8.4');
S = str2double(No{1,1});
No  = inputdlg('Enter Bare Resistance in MOhms');
Rb = str2double(No{1,1}) * 1e6;

L = 0.6

choice = 1;
while(choice ~= 3)
    choice = menu('Choose Method','Enter Diameter','Enter Resistance','Exit');
    
    if choice == 1
        No  = inputdlg('Enter Diameter in nm');
        d = str2double(No{1,1});
        [ R_Total, R_Membrane, R_Pore, R_Access ] = MembranePoreResistance( d, S, Rb, L);
        disp(['The resistance would be expected to be: ' num2str(R_Total / 1e6) 'MOhms'])
    
    elseif choice == 2
        No  = inputdlg('Enter Resistance in MOhms');
        R = str2double(No{1,1}) * 1e6;
        [ Diameter_nm, R_Pore, R_Access, R_Cone, R_Membrane, G_ns, D_Golov ] = MembranePoreDiameter( R, S, Rb, L );
        disp(['The diameter of the pore is calculated as: ' num2str(Diameter_nm) 'nm']);
        
    end
    
end

