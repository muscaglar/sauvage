% ***********************************
% InsertIVAnalysis
%   Insert the results of an IV data anlysis to the experiments table
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
function [ output_args ] = InsertIVAnalysis( id,Voffset , Ioffset , Resistance , LowRes , HighRes , nPerm , pPerm , PermOffset   )
%UNTITLED Updates the IV analyss for experiments already in the DB -
%doesn't insert if not already there - ie relys on an existing entry -
%analysis cannot run without an entry as need to have ph Values for
%analysis
DB = DBConnection;
E = Experiments(DB);
E.Initialise();
E.SELECT(id);
if(max(size(char(E.getComment()))) < 1)
    E.setComment(' ');
end
E.setVoffset( Voffset);
E.setIoffset(Ioffset);
E.setResistance(Resistance);
E.setLowRes(LowRes);
E.setHighRes(HighRes );
E.setnPerm(nPerm );
E.setpPerm(pPerm);
E.setPermOffset(PermOffset);
%E.setAnalysisDate(DBDate.now());

E.UPDATE();

 

end

