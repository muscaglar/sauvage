% ***********************************
% getMembraneID
%   Search for a MembraneID using a given search number
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
function [ MembraneID ] = getMembraneID( Membrane )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

if ~isnan(Membrane)
    if Membrane > 0
        DB = DBConnection;
        M = Membranes(DB);
        search = [' Name LIKE ''G' num2str(Membrane) ''' '];
        M.SELECT(search);
        MembraneID = M.getid;
        M.CloseConnection();
        
        if MembraneID > 0
            
        else
            Message = ['Membrane not recognised. Enter ID for membrane "' num2str(Membrane) '"'];
            MembraneID = inputdlg(Message);
            MembraneID = str2double(MembraneID{1,1});
        end
    else
        % if the value in the excel file is 0 then set as the bare capillary
        % value which is 15.
        MembraneID = 15;
    end
else
    Message = ['Membrane Value NAN. Enter the correct ID for membrane "' num2str(Membrane) '"'];
    MembraneID = inputdlg(Message);
    MembraneID = str2double(MembraneID{1,1});
end

% Could add a readback check

end

