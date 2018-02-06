% ***********************************
% Concat Vector to SQL
%   Concat the elements of a vector into a SQL query as ORs or ANDs
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
function [ output ] = ConcatVectorToSQL( Vector, ColumnName, AndOr, Operator )
%CONCATVECTORTOSQL Summary of this function goes here
%   Detailed explanation goes here

n = max(size(Vector));

if nargin < 3
    AndOr = 'OR';
end
if nargin < 4
    Operator = '=';
end

output = '(';
for i = 1:n
    if(i > 1)
      output = [output ' ' AndOr];  
    end
    output = [output ' ' ColumnName ' ' Operator ' ' num2str(Vector(i)) ];
end
output = [output ' )'];
end

