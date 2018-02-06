% ***********************************
% AddExperiment
%   Add a single expeeriment - currently doesn't check for duplicates
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

function [ output_args ] = AddExperiment( Date, No, CapID, Suppressed, Sealed, ResConc,ResSol, CapConc, CapSol, CapPH, ResPH )

if CapID > 0
    
    DB = DBConnection;
    E = Experiments(DB);
    E.Initialise();
    Da  = GetDBDate( Date );
    %Note could get date from the capillary  - must match.
    E.setDate(Da);
    E.setCapillary(CapID);
    
    if isnan(CapPH)
        CapPH = 0;
    end
    E.setCapillarySln(char(CapSol));
    E.setReservoirSln(char(ResSol));
    E.setCapillaryConc(CapConc);
    E.setReservoirConc(ResConc);
    E.setCapPh(CapPH);
    E.setResPh(ResPH);
    E.setSuppressed(0);
    
    
    E.setNo(No);
    E.setSealed(Sealed);
    E.setSuppressed(Suppressed);
    E.INSERT;
end
end

