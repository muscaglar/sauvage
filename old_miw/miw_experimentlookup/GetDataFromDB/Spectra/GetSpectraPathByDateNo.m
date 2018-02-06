% ***********************************
% GetSpectraPathByNo
%   Return the file path to the Raw spectra for a given name and no
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
function [ FileName, PathName ] = GetSpectraPathByDateNo( Date, No , AllowDownload )

    %set default values
    FileName = ' ';
    %PathName;
    if nargin < 3
        %Default to allow download
        FileRoots;
        AllowDownload = AllowCloudDownload;
    end

    FileRoots;
    DateStr = GetDateString( Date );
    Root = SpectraRoot;
    PathName = [SpectraRoot '/' DateStr '/'];
    if exist(PathName,'dir') == 0
        Root  = SpectraRootHDD;
    end
    [PathName, DateStr ] = ConstructDataPath( Date, Root);
    
    
    if exist(PathName,'dir') ~= 0
       files = dir(PathName);
        ApproxFileName = [DateStr '_' num2str(No) '_'];
        if No < 10;
            ApproxFileName2 = [DateStr '_0' num2str(No) '_'];
        else
            ApproxFileName2 = ApproxFileName;
        end
        
        for file = files' 
            
            %See if the file matches the date and no
            if (not(isempty(strfind(file.name, ApproxFileName))) || not(isempty(strfind(file.name, ApproxFileName2)))) && not(isempty(strfind(file.name, '.txt')))
                %[date2, no2] = FileNameInterpret( file.name );
                FileName = file.name;
            end
        end
    end
    
    if exist([PathName '/' FileName],'file') ~= 2 && AllowDownload == 1
       [ FileName, PathName ] = GetCloudSpectra( Date, No );
    end
end

