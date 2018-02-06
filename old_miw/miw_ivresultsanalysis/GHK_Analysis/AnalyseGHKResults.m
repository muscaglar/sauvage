% ***********************************
% AnalyseGHKResults
%   Coode to be completed
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


%Analyse All GHK results
% is this stand alone or with the other scripts - ie when should they be
% read  out!
% If done as part oc Analyse over Capillaries don't need to select Caps

CapillarySelect;

%Load all the experiments with this capillary
DB = DBConnection;
E = Experiments(DB);
str = ['(Suppressed = 0 AND Sealed > 0) AND ('];
n = 1;
for i = Caps
    if n > 1
        str = [str ' OR '];
    end
     n = n+1 ;
    str = [str 'Capillary = ''' num2str(i) ''''];
end
str = [str ')'];
str
E.SELECT(str);
%Read out the results again  - but a subset now  - though then cannot
%compare reistance with GHK  - can add
% But want to keep code simple

clear Data
isNext = 1;
i = 1;
while isNext
   Data(i,:) = [E.getid() E.getCapillary() E.getCapPh() E.getResPh() E.getpPerm() E.getnPerm];
   isNext = E.NextResult(); 
   i  = i+1;
end

Ratios = Data(:,5)./Data(:,6);
figure(3)
hold on
semilogy(Data(:,4), Ratios,'.b');
hold on;
figure(4)
[X,Y] = logXHistogram(Ratios,20);
Y = Y ./ sum(Y);
%ORG = Matlab2OriginPlot('C:\Users\miw24\Documents\PhD\Origin Projects\Project22_MatlabDev.OPJ',1)
ORG.HoldOn
ORG.PlotColumn(X',Y','Graphene Al2O3','Green');

[ XY ] = YMeans_Error(XValues, Data(:,4), Ratios )

