% ***********************************
% CalcOsmoticPower
%   Clculate the osmostic power that would be generated by a membrane based
%   on one or many capillaries
%   uses P = (I_offset)^2 * R
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
function [ RawAllPowers, OsmoticCurrentXY, OsmoticPowerXY ] = CalcOsmoticPower( CapillaryNos )
%PlotOsmoticPower 
%   Plot Osmotic POwer using I2R

RawAllPowers = [];

for c = CapillaryNos
    
    DBc = DBConnection;
    C = Capillaries(DBc, c); 
    [ Expts, n, ExptIDs ] = LoadExperiments( c, 1, 0 );
    
    %PowerRaw = zeros(n, 4);
    
    for i = 1:n
        E = Expts(i);
        Iosm = E.getIoffset();
        R = 1e6 * E.getResistance();   %Convert to Ohms
        if(Iosm ~= 0 && R ~= 0)
            P = (1e-9 * Iosm)^2 * R   ;    %Note that current is in nA
        
            [ Diameter, Area ] = GetCapSize(char(C.getType()));
            PperM2 = P / Area;
            PowerRaw(i,1) =  E.getCapillaryConc() / E.getReservoirConc();
            PowerRaw(i,2) = Iosm;
            PowerRaw(i,3) = P;
            PowerRaw(i,4) = PperM2;
        else
            warning(['Either no interpecetp or no resistance Experiment: ' num2str(E.getid())]);
        end
    end
    RawAllPowers = [RawAllPowers; PowerRaw];
    
end

Details = [num2str(C.getid()) ' ' GetDateString( C.getDate() ) ' ' char(C.getType) ' ' num2str(C.getCapNo) ' '];
subplot(1,2,1)
semilogx(RawAllPowers(:,1), RawAllPowers(:,2),'o');
xlabel('Concentration Ratio');
ylabel('Osmotic Current (nA)');
title(['Osmotic Current ' Details]);
subplot(1,2,2)
loglog(RawAllPowers(:,1), RawAllPowers(:,4),'o');
xlabel('Concentration Ratio');
ylabel('Osmotic Power Density W/m2');
title(['Osmotic Power Density ' Details]);

ConcRatios = [0.1 1 10 100];

%Add a round on the Concentrations so that the precision issue is resolved.
RawAllPowers(:,1) = round(RawAllPowers(:,1),5);

[ OsmoticCurrentXY ] = YMeans_Error(ConcRatios, RawAllPowers(:,1), RawAllPowers(:,2));
[ OsmoticPowerXY ] = YMeans_Error(ConcRatios, RawAllPowers(:,1), RawAllPowers(:,4));

end
