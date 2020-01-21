% ***********************************
% SealAnalysisByCapillary
%   Plot the Bare versus sealed resistance for a number of Capillaries
%   passed in as a vector. The code will split this up between membranes so
%   they do not need to be separated.
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

function [ResistanceMatrix, ResistanceAwayIncreases] = SealAnalysisByCapillaries(Capillaries, DoIncrease, SealedSuppression)
% Script to complete Seal Analysis  - Take a vector of capillaries
% Note the script will separate by membrane - so can pass in full mix
if nargin < 2
    DoIncrease = 1;
end


ResistanceAwayIncreases = [];
ResistanceMatrix = [];

j = 1;
for i = Capillaries
    
    if nargin < 3
         [ ResistanceMatrixRow , ResistanceAwayIncrease ] = SealAnalysis( i);
    else
         [ ResistanceMatrixRow , ResistanceAwayIncrease ] = SealAnalysis( i);
    end
    
    if ResistanceAwayIncrease  ~= 0
        ResistanceAwayIncreases = [ ResistanceAwayIncreases  ResistanceAwayIncrease];
    else
        ResistanceAwayIncreases = [ ResistanceAwayIncreases  0];
    end
    if ResistanceMatrixRow ~= 0
        ResistanceMatrix = [ResistanceMatrix; ResistanceMatrixRow ];
        j = j + 1;
    end
end

%Calc the Resitance Ratio
%ResistanceRatios = (ResistanceMatrix(:,2) - ResistanceMatrix(:,1)) ./ ResistanceMatrix(:,1);

end