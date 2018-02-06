% ***********************************
% AddCapillaries
%   Add Capillaries to the DB
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
function [ CapID ] = AddCapillaries( Date, CapType, CapNo ,ExperimentType, BareIVCurves,SealedIVCurves,AwayIVCurves, Membrane , User, SeiectivityExpts, CapSol, CapConc, CapPH, TracesMatrix )

CapID = GetCapID( Date, CapNo );
if(CapID == 0)
    DB = DBConnection;
    C = Capillaries(DB);
    
    %Create Capillary
    Da  = GetDBDate( Date );
    %if(BareExpts(1) < SealedExpts(1))
    C.setDate(Da);
    C.setCapNo(CapNo);
    C.setType(CapType);
    C.setExptType(char(ExperimentType));
    C.setinvestigator(User);
   C.INSERT;
else
    %Capillary allready exists
end

%Now need to get the Cap no which corresponds
CapID  = GetCapID( Date, CapNo );
if CapID > 0
    %Now add the experiments
    e = AddExperiments( CapID, Date, BareIVCurves,SealedIVCurves,AwayIVCurves, Membrane, SeiectivityExpts,  CapSol, CapConc, CapPH );
    
    %Now Add the TracesMatrix
    t = AddTraces( CapID, Date, Membrane,  CapSol, CapConc, CapPH, TracesMatrix );
    
    disp(['Added: ' num2str(e) ' list experiments and ' num2str(t) ' TracesMatrix']);
    
else
    error('Cannot add experiments as CapID = 0');
end
%end

end

