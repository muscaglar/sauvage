% ***********************************
% GetCapID
%   Get the ID of a Capillary using the Date and File no
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
function [ CapID ] = GetCapID( Date, CapNo )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here


DB = DBConnection;
C = Capillaries(DB);
Da  = GetDBDate( Date );
C.SELECT(['Date LIKE ''' char(Da.toString) ''' AND CapNo = '' ' num2str(CapNo) ' '' ']);
CapID = C.getid;
C.CloseConnection();

end

