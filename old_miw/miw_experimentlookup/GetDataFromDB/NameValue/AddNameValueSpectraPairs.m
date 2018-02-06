% ***********************************
% AddNameValueSpectaPairs
%   Provide an interface to add name value pairs to specta
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
function AddNameValueSpectraPairs(Name, ids, values)

if nargin < 1
    Name = inputdlg('Enter the Name');
    Name  = Name {1,1};
end

if nargin < 2
    Sid = 1;
    while(Sid >0)
        Sid = inputdlg('Enter the spectra ID (0 to quit)');
        Sid  = str2double(Sid {1,1});
        
        if(Sid > 0)
            
            min = inputdlg(['Enter the value for SID: ' num2str(Sid)]);
            Value  = str2double(min {1,1});
            disp(['Spectra: ' num2str(Sid) ' - ' num2str(Value) ' ']);
            [ rValue, rStringValue, rid ] = UpdateNameValueSpectra( Sid , Name, Value);
            
        end
    end
else
    i = 1;
    for id = ids
        if nargin < 3
        min = inputdlg(['Enter the value for SID: ' num2str(id)]);
            Value  = str2double(min {1,1});
            disp(['Spectra: ' num2str(id) ' - ' num2str(Value) ' ']);
        else
            Value = values(i);
            i = i+1;
        end
       [ rValue, rStringValue, rid ] = UpdateNameValueSpectra( id , Name, Value);
    end
end

end