% ***********************************
% GetCapSize
%   Interpret size
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
function [ Diameter, Area ] = GetCapSize( Type )
%UNTITLED11 Summary of this function goes here
%   Detailed explanation goes here
Diameter = 1;
Area = 1;
switch(Type)
    case 'A'
        Diameter = 15e-9;
        Area = 1.767e-16;
    case 'C'
        %Diameter = 170e-9;
        %Area = 2.2698e-14;
        Diameter = 179e-9;
        Area = 2.51649e-14;
    case 'E'
        Diameter = 5000e-9;
        Area = 7.85398e-11;
    case 'F'
        Diameter = 3000e-9;
        Area = 2.82743e-11;
    case 'G'
        Diameter = 1;
        Area = 1;
    case 'H'
        Diameter = 400e-9;
        Area = 1;
    case 'I'
        Diameter = 2000e-9;
        Area = 3.1416e-12;
end

end

