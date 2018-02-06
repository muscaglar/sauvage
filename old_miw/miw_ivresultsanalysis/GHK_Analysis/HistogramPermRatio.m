% ***********************************
% HistogramPermRatio
%   Plot ratio of postive to engative permisitvity for different material
%   This code needs re working to deal with a wider number of membranes
%   CURRENTLY NOT COMPLETE
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
function HistogramPermRatio(Caps)

error('Code not updated to support membranes correctly');

DB = DBConnection;
DBC = DBConnection;

C = Capillaries(DBC);
E = Experiments(DB);

C.SELECT;

BareRatio = [];
GrapheneRatio = [];
NafionRatio = [];
hBNRatio = [];

Caps = 1;
while Caps
    %Find the IV codes related to the 
    disp(['Capillary: ' num2str(C.getid) '. '])
    E.SELECT(['Capillary = ' num2str(C.getid) ' AND Suppressed = 0 AND Sealed > 0']);
    IVs = 1; 
    while IVs
        
        %Now add the data to the correct entry
        r = E.getResPh;
        c = E.getCapPh;
        N = E.getnPerm;
        P = E.getpPerm;
        Ratio = P/N;
        if r ~= c && E.getid~= 71
            if r > c
                Ratio = P/N;
            else
                Ratio = N/P;
                %Ratio = P/N;
            end
            disp(['   Experiment: ' num2str(E.getid) '.  use'])
            diameter = GetCapSize(char(C.getType));
            switch char(C.getExptType)
                case 'Bare'
                    BareRatio = [BareRatio ; Ratio r diameter];
                case 'G31'
                    GrapheneRatio = [GrapheneRatio ; Ratio r diameter];
                case 'Nafion'
                    NafionRatio = [NafionRatio ; Ratio r diameter];
                case 'hBN'
                    hBNRatio = [hBNRatio ; Ratio r diameter];
            end
        else
            disp(['   Experiment: ' num2str(E.getid) '.  DO NOT USE'])
        end
        IVs = E.NextResult;
    end
    
    Caps = C.NextResult;
end
C.CloseConnection();
E.CloseConnection();
%Now convert into histogram
Range = [-13 14];
edges = logspace(-13,14,100);
edgeLables = linspace(-13,14,100)';

n = histc(NafionRatio(:,1),edges);
g = histc(GrapheneRatio(:,1),edges);
b = histc(BareRatio(:,1),edges);
h = histc(hBNRatio(:,1),edges);

%Now need to normalise Results  - Make to sum to on
N = n/sum(n);
G = g/sum(g);
B = b/sum(b);
H = h/sum(h);

%Now plot Histograms of Ratios  - on the same scale and on ideal scales
figure(1);hold off;
Data = [N' G' B' H'];
%bar(Data);
subplot(4,2,1)
%bar(G,'r')
logXHistogram(GrapheneRatio(:,1),100,'r',Range);
subplot(4,2,3)
%bar(N,'b')
logXHistogram(NafionRatio(:,1),100,'r',Range);
subplot(4,2,5)
%bar(B,'k')
logXHistogram(BareRatio(:,1),100,'k',Range);
subplot(4,2,7)
%bar(H,'c')
logXHistogram(hBNRatio(:,1),100,'c',Range);

% Now plot 
subplot(4,2,2); hold off;
%bar(logspace(-2,2,40),histc(GrapheneRatio(:,1),logspace(-2,2,40) ),'r');
%set(gca, 'Xscale', 'log');
logXHistogram(GrapheneRatio(:,1),60,'r');
subplot(4,2,4)
logXHistogram(NafionRatio(:,1),100,'b');
subplot(4,2,6)
logXHistogram(BareRatio(:,1),50,'k');
subplot(4,2,8)
logXHistogram(hBNRatio(:,1),20,'c');

%PLot the cumulative gradients.
figure(2); hold off;
Nc = cumsum(N);
Gc = cumsum(G);
Bc = cumsum(B);
Hc = cumsum(H);
plot(edgeLables,Nc,'b')
hold all;
plot(edgeLables ,Gc,'r');
plot(edgeLables ,Bc,'k');
plot(edgeLables ,Hc,'c');

%Plot with pH
figure(3)
subplot(1,2,1); hold off;
semilogy(NafionRatio(:,2),NafionRatio(:,1),'.b'); hold on;
semilogy(GrapheneRatio(:,2),GrapheneRatio(:,1),'or'); hold on
semilogy(BareRatio(:,2),BareRatio(:,1),'+k');
semilogy(hBNRatio(:,2),hBNRatio(:,1),'.c');

%Plot with size
subplot(1,2,2); hold off;
loglog(NafionRatio(:,3),NafionRatio(:,1),'.b');hold on
loglog(GrapheneRatio(:,3),GrapheneRatio(:,1),'or');hold on
loglog(BareRatio(:,3),BareRatio(:,1),'+k');
loglog(hBNRatio(:,3),hBNRatio(:,1),'.c');

end