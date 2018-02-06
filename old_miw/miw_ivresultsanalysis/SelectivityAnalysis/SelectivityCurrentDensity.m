% ***********************************
% Selectivity
%   Calculate the selectivity from a set of Experiment objects or from a
%   capillary ID or from a vector of Capillary IDs.
%   Can also pass in maxand min concentrations to use. Note will load
%   KMNO4 etched but won't separate out.
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

function [ VoltageGradient, CurrentGradient, VOffset, IOffset, ResConcs,CapConcs, VoltageOffsets, CurrentOffsets, No ] = SelectivityCurrentDensity( Expts, minResConc, maxResConc, Xrange )
%Caculate the gradient of the voltage and current offsets
%   Note code currently assumes the capillary conc is fixed - and does all
%   measurements on the reservoir conc only - not the difference!
%   Expts can be either an array of experiments or the CapillaryID or a
%   vectors of IDs
%       In the event of a vector the array is stacked so that all get
%       raw data gets treated together (ie mean found of all ofsets (not mean of means).

AllowableSuppressionCodes = [0 16];

figure(24)
if nargin < 4
    Xrange = [0.00001 0.0001 0.001 0.01 0.1 0.25 0.5 1 2];
end
if nargin < 3
    maxResConc = 10000000;
end
if nargin < 2
    minResConc = 0.00000001;
end

VoltageOffsets = [];
CurrentOffsets = [];
ResConcs = [];
CapConcs = [];
i = 1;

if isnumeric(Expts)
    CapillaryIDs = Expts;
    Expts = [];
    Offsets = [];
    No = 0;
    for CapillaryID = CapillaryIDs
        %Load experiments with a vector of supresion codes which will be
        %OR'd
        [Expts_0, No_0] = LoadExperiments( CapillaryID, 1, AllowableSuppressionCodes );
        Expts = [Expts Expts_0];
        No = No + No_0 ;
        
        DB = DBConnection;
        C = Capillaries(DB,CapillaryID);
        
        [ ~, Area ] = GetCapSize( char(C.getType()) );
        scaling = ((1e-6)^2) / Area;
        
        Offset = VOffsetCorrection( CapillaryID );
        Offsets = [Offsets (Offset * ones(1,No_0))];
        
        n = length(Expts_0);
        for j = 1:n
            E = Expts_0(j);
            %Apply Limits
            if E.getReservoirConc() <=  maxResConc  && E.getReservoirConc() >=  minResConc
                if E.getVoffset ~= 0
                    VoltageOffsets(i) = E.getVoffset() - Offset;
                else
                    VoltageOffsets(i) = nan;
                end
                if E.getIoffset ~= 0
                    CurrentOffsets(i) = scaling * E.getIoffset();
                else
                    CurrentOffsets(i) = nan;
                end
                ResConcs(i) = E.getReservoirConc();
                CapConcs(i) = E.getCapillaryConc();
                i = i+1;
            else
                %Do not use this entry as outside the range for this analysis
            end
        end
        
        
    end
end

%Read out the values into Arrays here



ResConcs = round(ResConcs,6);
CapConcs = round(CapConcs,5);

if nargin < 4
    %Should add UNIQUE and SORT
    Xrange = unique(ResConcs);
end


if (max(size(unique(ResConcs))) >=2) ||(max(size(unique(CapConcs))) >= 2)
    
    [ VoltageGradient, CurrentGradient, VOffset, IOffset, XV, XI ] = SelectivityFromValues( ResConcs,CapConcs, VoltageOffsets, CurrentOffsets, Xrange, Expts(1).getCapillary() );
    hold on
    
    if isnumeric(Expts) && length(CapillaryIDs) == 1
        %This will remove the cancelling effect of Voffset  - ie if there already
        %is an offset then don't want to return 0 as this could then get written to
        %DB whn its wrong!!
        %But only do for cases where a single capillary ID was passed in!
        VOffset = VOffset + Offsets(1);
    end
    
else
    No = 0;
    disp('No different concentration Results - therefore cannot calc selectivity');
    VoltageGradient=[];
    CurrentGradient=[];
    VOffset=[];
    IOffset=[];
    %ResConcs,CapConcs
    %VoltageOffsets,
end

end

