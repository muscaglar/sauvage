% ***********************************
% ReadExcelMatrix
%   ReadExcel Matrix
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
function [ Matrix ] = ReadExcelMatrix( raw , startRow, startCol, noRows, noCols)
% Read Excel Matrix - if noRows = 0 of noCols = 0 then it reads as many of
% these cols are full

Matrix = [];
i = 0;
if noRows > 0 && noCols > 0
   Matrix = raw(startRow:startRow+noRows-1,starCol:startCol+noCols-1); 
elseif noRows == 0
    while raw{startRow + i, startCol } > 0  
        Matrix = [Matrix; raw(startRow + i, (startCol):(startCol + noCols-1) )] ;
    i = i+1;
    end

elseif noCols == 0
    while raw{startRow, startCol + i} > 0        
        Matrix = [Matrix raw(startRow:(startRow + noRows-1), (startCol+i) )] ;
    i = i+1;
    end
    
else
    %Read in an unlimited matrix in either Cols or Rows - but ensure
    %complete.
    
end


end

