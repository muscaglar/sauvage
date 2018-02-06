% ***********************************
% PoreSizesPlotScript
%   Plot the effect of different paremeters on pore resistance as a
%   sensitivty analysis
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


%Membrane senssitivity Analysis for Real Values - show what works and how
%well
%Also create Origin plots

if ~exist('OR','var')
   OR = 0; 
end

%Setting
S = 8.4;
B = 7e6;
L = 0.6;

%Resistance Against Diameter
d = linspace(1,30,20);
[ R_Total, R_Membrane, R_Pore, R_Access ] = MembranePoreResistance( d, S, B, L);

hold off;
plot(d,R_Total/1e6,'-r')
ylabel('Resistance (MOhms)')
xlabel('Graphene Pore Diameter (nM)')
hold on;
plot(d,R_Pore/1e6,'-g')
plot(d,2*R_Access/1e6,'-b')
plot(d,R_Membrane/1e6,'--b')
title('Resistance To Pore Diameter with 7M Capillary')

%Look Closer At R
figure 
d = linspace(2.5,10,20);
[ R_Total, R_Membrane, R_Pore, R_Access ] = MembranePoreResistance( d, S, B, L);

hold off;
plot(d,R_Total/1e6,'-r')
ylabel('Resistance (MOhms)')
xlabel('Graphene Pore Diameter (nM)')
hold on;
plot(d,R_Pore/1e6,'-g')
plot(d,2*R_Access/1e6,'-b')
plot(d,R_Membrane/1e6,'--b')
title('Resistance To Pore Diameter with 7M Capillary')

%Look at affect of thickness for 5nm Pore
L = linspace(0.2,0.8,10);
d = 5;
[ R_Total, R_Membrane, R_Pore, R_Access ] = MembranePoreResistance( d, S, B, L);
figure
plot(L,R_Total/1e6,'-r')
title('Thickness Affect on Resistance with 10nm Pore and 7M bare')
ylabel('Resistance (MOhms)')
xlabel('Graphene Thickness (nM)')