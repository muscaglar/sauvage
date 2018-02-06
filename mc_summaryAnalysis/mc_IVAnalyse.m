% ***********************************
% IVAnalyse
%   Run analysis on a Raw data file - pass in File path
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

%Do stuff to my_data

function [ Data, my_data ] = mc_IVAnalyse(Save, FileName, PathName, VoltageZeroOffset, id, my_data)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
    if nargin >= 4
        IV = LoadIV(FileName, PathName);
    else
        [IV, FileName, PathName] = LoadIV();
    end
    if nargin < 2
       Save = 0; 
    end
    if nargin < 5
        VoltageZeroOffset = 0;
    else
        %There is a Voltage Offset so apply it
        IV = [IV(:,1) IV(:,2)-VoltageZeroOffset];
    end
    
    [ date, no, details] = FileNameInterpret( FileName );
    
    VInt = VoltageIntercept(IV); %num2str(VInt)
    %num2str(date)
    
    [R, Rectification] = ResistanceAnalyse(IV);
    G = 1/R;
    title({['Resistance Calculation: R = ' num2str(R)], [', G = ' num2str(G) ', IV1 = ' num2str(Rectification(1)) ],[', IV2 = ' num2str(Rectification(2)) ', Ratio = ' num2str(Rectification(3)) ]});

    I_Intercept = CurrentIntercept(IV);
    title({['I Intercept: ' num2str(I_Intercept) 'nA']});
    

    %GHK Permeability Analysis
    %need the pH for this file.
    
    [ ExptData , E ] = ReturnExperimentalDetails( date, no );
%     if(E.getid() > 0)
%         pHRes = ExptData{3};
%         pHCap = ExptData{2};
%         size = GetCapSize(ExptData{4});
%         [ P, N, O ] = GHK_FitPermeabilityMonoCharge( IV, double(E.getCapillaryConc), double(E.getReservoirConc),VInt);
%         
%         %This entry has a DB entry - so could write back in additional info
%         InsertIVAnalysis( ExptData{1},VInt , I_Intercept , R , Rectification(1) , Rectification(2) ,N, P , O   )
%         
%     else
%         % Need to close subplot
        disp('No DB entry for this file so no Conc information');
        hold off;
        
        P = 0;
        N = 0 ;
        O = 0;
        pHRes = 0;
        size = 0;
        pHCap = 1;
%         
%         %Could create an entry here  - but suppress the analysis until I
%         %link it to a capillary
%         
%     end

    [ResistanceMatrix, ResistanceAwayIncreases] = SealAnalysisByCapillaries(my_data(1))
    if(isempty(ResistanceMatrix))
        my_data(4) = 0;
        my_data(5) = 0;
        my_data(6) = 0;
        my_data(7) = 0;
        my_data(8) = 0;
        my_data(9) = 0;
    else
    my_data(4) = ResistanceMatrix(1) ;
    my_data(5) =  ResistanceMatrix(2);
    my_data(6) =  ResistanceMatrix(3);
    my_data(7) = 0;
    my_data(8) = 0;
    my_data(9) = 0;
    end
    
    [ VoltageGradient, CurrentGradient, VOffset, IOffset, ResConcs,CapConcs, VoltageOffsets, CurrentOffsets, No ] = Selectivity(my_data(1));
    if(isempty(VoltageGradient))
            my_data(10) = 0;
            my_data(11) = 0;
            my_data(12) = 0;
            my_data(13) = 0;
            my_data(14) = 0;
    else
            my_data(10) = VoltageGradient(1);
            my_data(11) = VoltageGradient(2);
            my_data(12) = CurrentGradient(1);
            my_data(13) = CurrentGradient(2);
            my_data(14) = CapConcs(1);
    end  
    Data = [date no pHCap pHRes size VInt I_Intercept R Rectification P N O (P/N)];
    %Save the plot out.
end

