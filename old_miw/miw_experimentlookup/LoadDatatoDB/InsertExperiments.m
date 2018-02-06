% ***********************************
% Insert Experiments
%   Legacy Code - do not use
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
function [ CapID ] = InsertExperiments( Date, CapType, CapNo, ExptNos, PhNos, ExptType,Membrane, SolutionInfo )
%UNTITLED3 Input from a set of columns eg from the existing origin Data
% Will want to upgrade and improve on this when adding new data.

warning('This code has not been fully updated to handle to solution info or suppression or seal info');

Da  = GetDBDate( Date );

DB = DBConnection;
%Construct Capillary entry
C = Capillaries(DB);
C.setDate(Da);
C.setCapNo(CapNo);
C.setType(CapType);
C.setExptType(ExptType);
C.INSERT;
%Get capillary id  - note haven't implemented this is code yet...
CapID  = GetCapID( Date, CapNo );

%Add all the experiments
E = Experiments(DB);
E.setDate(Da);
E.setCapillary(C.getid);
n = max(size(ExptNos));

for i = 1:n
   E.setNo(ExptNos(i));
   E.setCapPh(PhNos(i,1));
   E.setResPh(PhNos(i,2));
   
   %Will assume not suppressed  - but could pass in above.
    E.setSuppressed(0);
    E.setSealed(Membrane);             % THis is generic and should be updated to link to the membrane correctly
    E.setCapillarySln('HCl');
    E.setReservoirSln('HCl');
    E.setCapillaryConc(10^(-1*PhNos(i,1)));
    E.setReservoirConc(10^(-1*PhNos(i,2)));
   
   E.INSERT;
end

end

