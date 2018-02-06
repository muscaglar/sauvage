% ***********************************
% CapillaryAnalysis
%   Run analysis routines on the results data to create name value pairs,
%   ie resistance ratio and Selectivity - Carries out selectivity on each
%   capillary individually not by combining data.
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
function [ output_args ] = CapillaryAnalysis( CapillaryIDs )
%CAPILLA5RYANALYSIS Run the core analysis on a capillary so the values can be put into the DB

SealAnalysisByCapillaries(CapillaryIDs, 1);

SelectivityAnalysisByCapillaries( CapillaryIDs );

AddCapillaryMembrane( CapillaryIDs )

end

