% ***********************************
% LoadExperiments
%   Load experiment objects based for a capillary ID with certain
%   Supperssion and either sealed or unsealed
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
function [ Expts, No, ExptIDs ] = LoadExperiments( CapID, SealedYN, Suppressed, FileTypes )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

%Load the capillary info - this is not required so don't do, though could
%add it as a return - could also check if the capillary exists.
%DBc = DBConnection;
%C = Capillaries(DBc, CapID);

if nargin < 4
FileTypes = [0 1];
end

%Load all the experiments with this capillary
DB = DBConnection;
E = Experiments(DB);
if SealedYN > 0
    str = ['Capillary = ''' num2str(CapID) ''' AND ' ConcatVectorToSQL( Suppressed, 'Suppressed') ' AND ' ConcatVectorToSQL( FileTypes, 'FileType') ' AND Sealed > 0 ORDER BY No ASC'];
else
    str = ['Capillary = ''' num2str(CapID) ''' AND ' ConcatVectorToSQL( Suppressed, 'Suppressed') ' AND ' ConcatVectorToSQL( FileTypes, 'FileType') ' AND Sealed = 0 ORDER BY No ASC'];
end
E.SELECT(str);


isNext = 1;
i = 1;

clear Eindex;
clear Es;
if E.getid > 0
    while isNext
        
        Eindex(i) = E.getid();
        %Use copy constructor to create a copy - so no need to reload from
        %DB but forces a by value copy rather than a reference
        Expts(i) = Experiments(E, DB);
        %Expts(i) = E  % Fials as is a pass by Ref
        
        %Note could do some preocessing of NANs.
        
        i = i+1;
        isNext = E.NextResult();
    end
    
    No = length(Eindex);
    ExptIDs = Eindex;
    disp([num2str(No) ' results for this capillary (' num2str(CapID) ') that are sealedYN=' num2str(SealedYN) ' and suppresed = ' num2str(Suppressed) ]);
else
    %
    disp(['No results for this capillary (' num2str(CapID) ') that are sealedYN=' num2str(SealedYN) ' and suppresed = ' num2str(Suppressed) ]);
    Expts = [];
    No = 0;
    ExptIDs = 0;
end


end

