% ***********************************
%Average Resistance
%   Calcualte the average bare sealed and away resistances for a batch of
%   capillary IDs
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

function [ MeanSealResistance, MeanAwayResistance, MeanBareResistance,SealResistance, AwayResistance, BareResistance ] = AverageResistance( CapillaryIDs)
%AVERAGERESISTANCE Summary of this function goes here
%   Detailed explanation goes here

DB = DBConnection;
SealResistance =[];
AwayResistance = [];
BareResistance =[];

for C =  CapillaryIDs

[ Expts, No, ExptIDs ] = LoadExperiments( C, 0, [0] );
if No >= 1
    E = Expts(1);
    BareResistance = [BareResistance  E.getResistance()];
end
[ Expts, No, ExptIDs ] = LoadExperiments( C, 1, [0 20] );
if No >= 1
    E = Expts(1);
    SealResistance = [SealResistance  E.getResistance()];
end
[ Expts, No, ExptIDs ] = LoadExperiments( C, 1, [21] );
if No >= 1
    E = Expts(1);
    AwayResistance = [AwayResistance  E.getResistance()];
end

end

MeanSealResistance = mean(SealResistance);
MeanAwayResistance = mean(AwayResistance);
MeanBareResistance = mean(BareResistance);

end

