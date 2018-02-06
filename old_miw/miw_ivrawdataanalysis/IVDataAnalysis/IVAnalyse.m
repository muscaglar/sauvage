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

function [ Data ] = IVAnalyse(Save, FileName, PathName, VoltageZeroOffset, id)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
    if nargin >= 3
        IV = LoadIV(FileName, PathName);
    else
        [IV, FileName, PathName] = LoadIV();
    end
    if nargin < 1
       Save = 0; 
    end
    if nargin < 4
        VoltageZeroOffset = 0;
    else
        %There is a Voltage Offset so apply it
        IV = [IV(:,1) IV(:,2)-VoltageZeroOffset];
    end
    
    [ date, no, details] = FileNameInterpret( FileName );
    figure(1);
    subplot(2,2,1)
    VInt = VoltageIntercept(IV);
    title({['V Intercept ' num2str(date) ],[', File: ' num2str(no) ' Intercept: ' num2str(VInt) 'mV']})

    subplot(2,2,2)
    [R, Rectification] = ResistanceAnalyse(IV);
    G = 1/R;
     title({['Resistance Calculation: R = ' num2str(R)], [', G = ' num2str(G) ', IV1 = ' num2str(Rectification(1)) ],[', IV2 = ' num2str(Rectification(2)) ', Ratio = ' num2str(Rectification(3)) ]});

    subplot(2,2,3) ;
    I_Intercept = CurrentIntercept(IV);
    title({['I Intercept: ' num2str(I_Intercept) 'nA']});
    

    %GHK Permeability Analysis
    %need the pH for this file.
    subplot(2,2,4) 
    [ ExptData , E ] = ReturnExperimentalDetails( date, no );
    if(E.getid() > 0)
        pHRes = ExptData{3};
        pHCap = ExptData{2};
        size = GetCapSize(ExptData{4});
        [ P, N, O ] = GHK_FitPermeabilityMonoCharge( IV, double(E.getCapillaryConc), double(E.getReservoirConc),VInt);
        
        %This entry has a DB entry - so could write back in additional info
        InsertIVAnalysis( ExptData{1},VInt , I_Intercept , R , Rectification(1) , Rectification(2) ,N, P , O   )
        
    else
        % Need to close subplot
        disp('No DB entry for this file so no Conc information');
        hold off;
        plot(0,0);
        P = 0;
        N = 0 ;
        O = 0;
        pHRes = 0;
        size = 0;
        pHCap = 1;
        
        %Could create an entry here  - but suppress the analysis until I
        %link it to a capillary
        
    end
    
    Data = [date no pHCap pHRes size VInt I_Intercept R Rectification P N O (P/N)];
    %Save the plot out.
    switch(Save)
        case 0
            disp('Don''t save');        
        case 1
            if exist([PathName '/Analysis'],'dir') == 0
                mkdir(PathName,'Analysis') 
            end
            if exist([PathName '/Analysis/Plots'],'dir') == 0
                mkdir([PathName '/Analysis'],'Plots') 
            end
            print([PathName '/Analysis/Plots/' num2str(date) '_' num2str(no) '_' details '.jpg'],'-djpeg');
        otherwise 
    end
end
