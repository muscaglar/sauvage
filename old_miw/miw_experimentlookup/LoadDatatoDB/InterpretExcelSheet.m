% ***********************************
% IntepretExcelSheet
%   Interpret an experiment summary excel sheet
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
function [Date, CapNo, CapType, CapSol, CapConc, CapPH, Membrane, BareIVCurves,SealedIVCurves,AwayIVCurves, Expts , ExptType, Traces ] = InterpretExcelSheet( raw )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%/Users/Mus/Downloads/ExperimentSummaries.xlsm
%09112016_LaCl3_2M

day = raw{2,2}
month = raw{2,3}
year = raw{2,4}
if (year > 100)
    year = year -2000; 
end
Date = day*10000 + month * 100 + year;

ExptType = raw{2,8};

%Get details of the capillary
CapNo = (raw{4,2});
CapType = raw{5,2};
CapSol = raw{6,2};
CapConc = raw{7,2};
CapPH = (raw{8,2});
Membrane = (raw{9,2});

%Read experiment details
BareIVCurves = ReadExcelRow(raw, 11,2);
SealedIVCurves = ReadExcelRow(raw, 12,2);
AwayIVCurves = ReadExcelRow(raw, 13,2);

%Now look to see if there is selectivity info or (in later itearations) if
%there is trace info  - Either read as 3 cols or read a matrix - need to
%ensure all Cols are completes
%Need to ensure any NANs are dealt with appropriately
Expts = ReadExcelMatrix( raw , 18, 1, 0, 7);


%Also need to read out any translocation information.
Traces = ReadExcelMatrix( raw , 18, 12, 0, 10);

%Write data into arguments

end

