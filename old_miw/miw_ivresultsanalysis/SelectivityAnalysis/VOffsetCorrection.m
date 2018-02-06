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

function [ Voffset, rid ] = VOffsetCorrection( CapillaryID , MinOffset )
if nargin < 2
   %set to very conservative if not set lower
    MinOffset = 80;
end

[ rValue, ~, rid ] = UpdateNameValueCapillary(CapillaryID,'VoltageOffset_>1mM');
        if(rid > 1 && abs(rValue) > MinOffset)
            Voffset = rValue;
        else
            [ rValue, ~, rid ] = UpdateNameValueCapillary(CapillaryID,'VoltageOffsetFull');
            if(rid > 1 && abs(rValue) > MinOffset)
                Voffset = rValue;
            else
                Voffset = 0;
            end
        end
end

