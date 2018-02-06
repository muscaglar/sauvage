% ***********************************
% LoadAllData
%   Upload all IV files - and add their File Details to the DB so this isn't
%   lost  - can pass in a search string to control which data gets uploaded
%   - ie by capillary or experiment id.
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
function LoadAllData(str, Upload)

if nargin < 2
    Upload = 0;
end

DB = DBConnection;
E = Experiments(DB);
E.SELECT(str);
Es = E.LoadRsToMemory();
Ei = Es.iterator

isNext = 1;
while Ei.hasNext;
    En = Ei.next;
    if(En.getid >0)
        %Don't allow download  - that would make no sense here!
        [ FileName, PathName ] = GetDataByNo( En.getDate, En.getNo ,0);
        
        if exist([PathName '/' FileName],'file') == 2
            [ date, no, details] = FileNameInterpret( FileName );
            
            FileName
            %details
            [rValue, rStringValue, rid] = UpdateNameValue(En.getid(), 0, 0, 0, 'FileName', 0, FileName );
            
            if Upload > 0
                DA = DataAccess;
                DA.UploadDataFile([PathName '/' FileName]);
            end
            
        end
    end
end
end
