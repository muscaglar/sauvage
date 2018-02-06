% ***********************************
% SelectivityFromValues
%   Calcualte the selectivty ( Voltage offset as gradient mV/log(M) ) from
%   a vector of values of voltage offsets and reservoir concentrations.
%   Will also calculate the current selectivity and return fitted data
%   
%   (C) Michael Walker 2015-6 - All Rights Reserved
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

function [ VoltageGradient, CurrentGradient, VOffset, IOffset, XV, XI ] = SelectivityFromValues( ResConcs,CapConcs, VoltageOffsets, CurrentOffsets, Xrange, CapillaryID )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

figure;

hold on

[ p, StdErrors, OffsetFitted, r2] = LineFit( log10(ResConcs), VoltageOffsets, log10(Xrange));
VoltageGradient(1) = p(1);
VoltageGradient(2) = StdErrors(1);
%semilogx(Xrange,OffsetFitted,'-b');

%Now do current Gradients

%Now do the Current Offsets
%semilogx(ResConcs,CurrentOffsets,'or');
hold on
[ q, StdErrors, IOffsetFitted, r2] = LineFit( log10(ResConcs) , CurrentOffsets, log10(Xrange) );
CurrentGradient(1) = q(1);
CurrentGradient(2) = StdErrors(1);
%semilogx(Xrange,IOffsetFitted,'-r');

%Do plotting
hold off;
semilogx(ResConcs,VoltageOffsets,'or',ResConcs,CurrentOffsets,'+b');
hold on
semilogx(Xrange,OffsetFitted,'-r',Xrange,IOffsetFitted,'-b');


xlabel('Reservoir Concentration');
%ylabel(ax(1),'Offset Voltage (mV)') % left y-axis
%ylabel(ax(2),'Offset Current (nA)') % right y-axis


%title({['Offset from: ' num2str(0)],[ ' Expts: ' num2str(min(Numbers)) '-' num2str(max(Numbers))]});
title({['Offset from CapNo: ' num2str(CapillaryID) ],[ ' Voltage Gradient = ' num2str(VoltageGradient(1)) '+/-' num2str(VoltageGradient(2)) ],[ ' Current Gradient = ' num2str(CurrentGradient(1)) '+/-' num2str(CurrentGradient(2))  ]});


%calc offsets  - find the voltage and Current at the point when it should
%be zero
% use p(2) and q(2)

VOffset = VoltageGradient(1) * log10(CapConcs(1)) + p(2);
IOffset = CurrentGradient(1) * log10(CapConcs(1)) + q(2);


XV = YMeans_Error(Xrange, ResConcs, VoltageOffsets );

XI = YMeans_Error(Xrange, ResConcs, CurrentOffsets );

%savefig(['/Users/Mus/Dropbox (Team Caglar)/PhD/MATLAB/',num2str(CapillaryID),'.fig']);

end

