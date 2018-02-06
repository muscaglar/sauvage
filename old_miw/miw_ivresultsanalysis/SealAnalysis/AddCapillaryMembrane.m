% ***********************************
% AddCapillaryMembrane
%   Add a Capillary name value with the membrane used for the experiments
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

function [ output_args ] = AddCapillaryMembrane( CapillaryIDs )
%ADDCAPILLARYMEMBRANE Summary of this function goes here

for C = CapillaryIDs
    
     [ Expts, No, ExptIDs ] = LoadExperiments( C, 1, [0 16 20 21] );
     if ExptIDs(1) > 0
          E = Expts(1);
         if E.getSealed > 0
            UpdateNameValueCapillary( C, 'SealMembrane', E.getSealed );
         end
     end

end

