% ***********************************
% AddTraces
%   Add Traces to the DB
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
function [ n ] = AddTraces( CapId, Date, Membrane,  CapSol, CapConc, CapPH, TracesMatrix )
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
if CapId > 0
    DB = DBConnection;
    T = Traces(DB);
    Da  = GetDBDate( Date );
    %Note could get date from the capillary  - must match.
    T.setDate(Da);
    T.settCapillary(CapId);
    
    if isnan(CapPH)
        CapPH = 0;
    end
    T.setCapillarySln(char(CapSol));
    T.setReservoirSln(char(CapSol));
    T.setCapillaryConc(CapConc);
    T.setReservoirConc(CapConc);
    T.setCapPh(CapPH);
    T.setResPh(CapPH);
    
    %Add the TracesMatrix - will need to change conc and pH
    %for each expt
    T.settSuppressed(0);
    
    %Check there are experiments to use.
    if max(size(TracesMatrix())) > 3
        n = max(size(TracesMatrix(:,1)));
        for i = 1:n
            if isnumeric(TracesMatrix{i,1})
                if TracesMatrix{i,1} > 0
                    if ischar(char(TracesMatrix{i,2}))
                        T.setReservoirSln(char(TracesMatrix{i,2}));
                    else
                        T.setReservoirSln('NA');
                    end
                    if isnan(TracesMatrix{i,3})
                        T.setReservoirConc(0);
                    else
                        T.setReservoirConc(TracesMatrix{i,3});
                    end
                    
                    if isnan(TracesMatrix{i,4})
                        T.setResPh(0);
                    else
                        T.setResPh(TracesMatrix{i,4});
                    end
                    %Read out the suppresion code if set - if not set then 0.
                    if isnan(TracesMatrix{i,10})
                        T.settSuppressed(0);
                    else
                        T.settSuppressed(TracesMatrix{i,10});
                    end
                    if isnan(TracesMatrix{i,5})
                        T.setSampleFreq(0);
                    else
                        T.setSampleFreq(TracesMatrix{i,5});
                    end
                    if isnan(TracesMatrix{i,6})
                        T.setFilterFreq(0);
                    else
                        T.setFilterFreq(TracesMatrix{i,6});
                    end
                    
                    if isnan(TracesMatrix{i,7})
                        T.setTranslocationsYN(TracesMatrix{i,7});
                    else
                        T.setTranslocationsYN(TracesMatrix{i,7});
                    end
                    
                    if ischar(TracesMatrix{i,9})
                        T.setDescription(TracesMatrix{i,9});
                    else
                        T.setDescription(' ');
                    end
                    
                    T.setNo(TracesMatrix{i,1});
                    T.settSealed(Membrane);
                    
                    T.INSERT;
                end
            end
        end
    else
        disp('No TracesMatrix to Add');
        n = 0;
    end
    
else
    error('Cannot add TracesMatrix without a CapId');
end
end

