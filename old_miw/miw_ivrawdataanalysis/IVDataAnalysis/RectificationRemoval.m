% ***********************************
% RectificationRemoval
%   Not in use
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


%Note would be better to run over a capillary - and use all values in DB  -
% - only need to give a single value  - the capillary value!!


Date = 160115;
equalNo = 83;
%Note would be better to run over a capillary - and use all values in DB  -
%easier to get up
Experiments = [];

[ FileName, PathName ] = GetDataByNo( Date, equalNo );
IV_Equal = LoadIV( FileName, PathName  );
%Fit to the equal case
figure(1); hold on;
plot(IV_Equal(:,2), IV_Equal(:,1),'+b');
hold on;
Params0 = [1 1 1 1];
%Does the fitting with V and nA  - so need to correct later
P= fminsearch(@(Params0) RecCost( IV_Equal, Params0  ), Params0);
%I_fit = P(1) .* V - P(2).* exp(- P(3) .* V) + P(4);
I_fit = P(1) .* IV_Equal(:,2) - P(2).* exp(- P(3) .* IV_Equal(:,2)) +  P(4);
plot(IV_Equal(:,2), I_fit,'o');
%Now remove the fit from the equal case  - should give a line
I_Line = IV_Equal(:,1) - ( 0 * P(1) .* IV_Equal(:,2) - P(2).* exp(- P(3) .* IV_Equal(:,2)) + 0 * P(4));
plot(IV_Equal(:,2), I_Line,'-b');

%[ EqualP, EqualN, EqualO ] = GHK_FitPermeabilityMonoCharge( IV, ConcI, Conc0, Vm )

%Now remove the equal case from all of the Non equal cases  - us DB to
%look up value.
IVNo = 73;    % 73 87

[ FileName, PathName ] = GetDataByNo( Date, IVNo );
IV_data = LoadIV( FileName, PathName  );
[ ExptData ] = ReturnExperimentalDetails( Date, IVNo);
    if(ExptData{1} > 0)
        pHRes = ExptData{3};
        pHCap = ExptData{2};
        %size = GetCapSize(ExptData{4});
        figure(1);  
        hold on;
        plot(IV_data(:,2), IV_data(:,1),'+r');
        I_Line = IV_data(:,1) - ( 0 * P(1) .* IV_data(:,2) - P(2).* exp(- P(3) .* IV_data(:,2)) + 0 * P(4));
        plot(IV_ph3(:,2), I_Line,'-r');
        
        %now calc the permebaility value
        figure(2);        
        [ PPerm, NPerm, Offset] = GHK_FitPermeabilityMonoCharge( [I_Line IV_data(:,2)], pHtoConc( pHCap ), pHtoConc( pHRes ),0);
        
        %This entry has a DB entry - so could write back in additional info
        %InsertIVAnalysis( ExptData{1},VInt , I_Intercept , R , Rectification(1) , Rectification(2) ,N, P , O   )
       
        PPerm/NPerm
        
    end


% See what the resulting values are 