% ***********************************
% PlotIVs
%   Plot all IVs for Date and vector of Experiment Nos
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

function [ IVMatrix] = PlotIVs( Date,ExptNos,KeyInfo)
%PlotIVs Plot all the IV curves listed on one graph and add the inforation
%in key along side them.
%   Detailed explanation goes here

%Needs to use the info to get to the files so will auto construct the path
%name
%May also search for it/allow different endings  - will then use load IV
%and plot.
%Note will need to search - as don't konw the capillary  - so instead
%search and then identify - and plot!!!
  
    n = max(size(ExptNos));
    hold off;

    f = 0;
    IVMatrix = [];
    for i = 1:n
        %Load IV Curve and plot IV curve
                f = f +1;
                [ IV, FileName,~ ] = LoadIVByNo(  Date, ExptNos(i)  );
                %[date2, no2] = FileNameInterpret( FileName );
                IV = IVClean(IV);
                plot(IV(:,2), IV(:,1));
                hold on;
                hold all;
                
                %add date to IV matrix so it can be plotted out into Origin
                %also
                if isempty(IVMatrix)
                   IVMatrix = IV; 
                else
                   IVMatrix = {IVMatrix IV};
                end
    end
   
    xlabel('Voltage (mV)');
    ylabel('Current (nA)');
    title({['IV Curves for ' num2str(Date) ],[' Expts:' num2str(min(ExptNos)) ' to ' num2str(max(ExptNos))]});
    disp(['No of file plotted = ' num2str(f)]);
    hold off;
end

