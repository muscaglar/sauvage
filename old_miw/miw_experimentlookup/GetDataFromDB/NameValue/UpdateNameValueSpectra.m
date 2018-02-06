% ***********************************
% UpdateNameValueSpectra
%   Update the NameValue pair in the Analysis results. If no new values
%   passed in then the code will just return the current value
%   You need to provide an ID for either a spectra, expt, Capillary or
%   Trace ID and the key for the key value pair. The value can be a string
%   or numeric
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

function [ rValue, rStringValue, rid ] = UpdateNameValueSpectra( Spectra, Name, Value, StringValue )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

if nargin < 4
    if nargin < 3
        %less than 4 and less than 3
        [rValue, rStringValue, rid] = UpdateNameValue(0, 0, 0, Spectra, Name );
    elseif nargin < 2
        error('You must sepcify a name currently');
    else
        %3 arguments
        [rValue, rStringValue, rid] = UpdateNameValue(0, 0, 0, Spectra, Name, Value);
    end
else
    %has all 4 arguments
    [rValue, rStringValue, rid] = UpdateNameValue(0, 0, 0, Spectra, Name, Value, StringValue );
end
end

