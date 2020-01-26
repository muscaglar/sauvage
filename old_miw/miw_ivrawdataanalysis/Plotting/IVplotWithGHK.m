% ***********************************
% IVplotWithGHK
%   Plot IVs into Origin but also add a GHK fit
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

function IVplotWithGHK(Date, ExptNos,R, OR, cap)
%Plot the experiments and plot the GHK fits to them using the approriate
%solutions concs  - note no need to put them in here as they should all
%already be in the DB
if nargin < 4
    OR = 0
end

if OR > 0
    clear ORG;
    ORG = Matlab2OriginPlot();
end

   SealedYN = 1; 
   Suppressed = [0 16];

hold off;
Ratios = [];
e = 1;
for i = ExptNos
    IV = LoadIVByNo(  Date, i  );
    
    %Could IV clean
    IVc = IVClean(IV);
    figure(1);
    plot(IV(:,2), IV(:,1),'o');
    hold all;
    
    %Load Conc calues for this line
    [~, E] = ReturnExperimentalDetails( Date, i, cap );
    %[ ~, ~, E  ] = LoadExperiments( cap, SealedYN, Suppressed );
    
    %double(E.getReservoirConc) double(E.getCapillaryConc)
    ConcI = double(E.getCapillaryConc);
    Conc0 = double(E.getReservoirConc);
    
    %GHK Fittting and plotting
    z = [1 -1];
    V = linspace(1.1*min(IV(:,2)),1.1*max(IV(:,2)),30);
    
    IVc(:,2) = IVc(:,2) - ((IVc(:,1)) .* R(e))  
    plot(IVc(:,2), IVc(:,1),'+');
    
    [ Pp, Np, Offset ] = GHK_FitPermeabilityMonoCharge( IVc, ConcI, Conc0 );  % Vm
    P = [Pp, Np];
    [ I_Total, I_Components ] = GHK_TotalCurrent( z, V*1e-3 , P, ConcI, Conc0 );
    
    Ratios(e,:) = [P Pp/Np Pp/(Np+Pp) GHK_Voltage(z, P, ConcI, Conc0)];
    
    %figure(1);
    hold on;
    plot(V, (I_Total+Offset)*1e9, '-');
    
    %Origin Plotting if I want this.
    if OR > 0
        ORG.PlotScatter(IVc(:,2)',IVc(:,1)',[num2str(i) '_' num2str(Conc0)],'green');
        ORG.yComment(['pH ' num2str(E.getReservoirConc)]);
        ORG.xlabel('Voltage','mV');
        ORG.ylabel('Current','nA');
        ORG.HoldOn;
        ORG.PlotLine(V,((I_Total+Offset)*1e9)',['Fit_Date_' num2str(i) '_' num2str(Conc0)]);
        ORG.xlabel('Voltage','mV');
        ORG.ylabel('Current','nA');
        ORG.yComment(['pH ' num2str(E.getReservoirConc) ' R = ' num2str(Pp/Np)]);
    end
    e=e+1;
end

if OR > 0
    ORG.title([num2str(Date) '_' num2str(min(ExptNos)) '-' num2str(max(ExptNos)) '_GHK Fitted']);
end