% ***********************************
% ManuaBatchAdd
%   Legacy Code - do not use
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
Date = input('Enter the Date: ');
Membrane = 7;
Type = 'G33 - graphene with Al2O3';

while(input('Do you want to continue') == 1)
    CType = input('Enter Type: ','s');
    No = input('Enter No: ');
    
    BareExp = input('Bare Experiment: ');
    SealedExpt = input('Sealed Experiment: ');
    
    AddCapillaries(Date,CType,No,  Type, BareExp,SealedExpt, Membrane)
end