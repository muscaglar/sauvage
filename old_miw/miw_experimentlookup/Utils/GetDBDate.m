% ***********************************
% GetDBDate
%   Return a Java Date object from a numeric date
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
function [ Da ] = GetDBDate( Date )
%Convert a Date in the form 110215 as a number into a DBDate object
%correctly
%  
DateStr  = GetDateString( Date );
Da = DBSupportCode.DBDate('2015-02-11'); %set with a random date as constructor is a mess.
Da.set(str2num(DateStr(1:2)),str2num(DateStr(3:4)),2000 + str2num(DateStr(5:6)));

end

