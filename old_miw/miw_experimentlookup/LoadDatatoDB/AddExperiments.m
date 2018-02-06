% ***********************************
% AddExperiments
%   Add experiments to the DB
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
function [ n ] = AddExperiments( CapId, Date, BareIVCurves,SealedIVCurves,AwayIVCurves, Membrane, SelectiveExpts,  CapSol, CapConc, CapPH )
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
if CapId > 0
    DB = DBConnection;
    E = Experiments(DB);
    E.Initialise();
    Da  = GetDBDate( Date );
    %Note could get date from the capillary  - must match.
    E.setDate(Da);
    E.setCapillary(CapId);
    
    if isnan(CapPH)
        CapPH = 0;
    end
    E.setCapillarySln(char(CapSol));
    E.setReservoirSln(char(CapSol));
    E.setCapillaryConc(CapConc);
    E.setReservoirConc(CapConc);
    E.setCapPh(CapPH);
    E.setResPh(CapPH);
    E.setSuppressed(0);
    
    for i = BareIVCurves
        E.setNo(i);
        E.setSealed(0);
        E.INSERT;
    end
    for i = SealedIVCurves
        E.setNo(i);
        E.setSealed(Membrane);
        E.setSuppressed(20);
        E.INSERT;
    end
    for i = AwayIVCurves
        E.setNo(i);
        E.setSealed(Membrane);
        E.setSuppressed(21);
        E.INSERT;
    end
    
    %Now add the selectivity Experiments  - will need to change conc and pH
    %for each expt
    E.setSuppressed(0);
    
    %Check there are experiments to use.
    if max(size(SelectiveExpts())) > 3
        n = max(size(SelectiveExpts(:,1)));
        for i = 1:n
            if isnumeric(SelectiveExpts{i,1})
                if SelectiveExpts{i,1} > 0
                    
                    E.setReservoirSln(char(SelectiveExpts{i,2}));
                    E.setReservoirConc(SelectiveExpts{i,3});
                    if isnan(SelectiveExpts{i,4})
                        E.setResPh(0);
                    else
                        E.setResPh(SelectiveExpts{i,4});
                    end
                    
                    if ischar(SelectiveExpts{i,5})
                        E.setComment(char(SelectiveExpts{i,5}));
                    else
                        E.setComment(' ');
                    end
                    
                    if isnan(SelectiveExpts{i,7});
                    else
                        E.setFileType(SelectiveExpts{i,7});
                    end
                    
                    %Read out the suppresion code if set - if not set then 0.
                    if isnan(SelectiveExpts{i,6})
                        E.setSuppressed(0);
                    else
                        E.setSuppressed(SelectiveExpts{i,6});
                    end
                    
                    E.setNo(SelectiveExpts{i,1});
                    E.setSealed(Membrane);
                    E.INSERT;
                end
            end
        end
    else
        disp('No List of Experiments to Add - there could Bare, Sealed and Away');
        n = 0;
    end
else
    error('Cannot add without a CapId');
end
end

