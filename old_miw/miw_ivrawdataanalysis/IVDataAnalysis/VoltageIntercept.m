
function [ V_intercept, Zero ] = VoltageIntercept( IV,varargin)
%FindVoltageIntercept Find the voltage for which current is 0
%   Pick points either side of zero current - note will need to remove lost
%   contact points first
%   Fit a curve to it  - max 2 or 3 order  - or try different fits
%   Output the intercept found
%   Output a plot showing, the points used, the points not used and the
%   fitted line.

%Settings
verbose = 1;

if nargin >= 2
    verbose = varargin{1};
end
nPoints = 4; %No of points either side of 0 current
OrderFit = 3;
n = max(size(IV));
if(verbose == 1)
hold off;
plot(IV(:,2),IV(:,1),'ok');
hold on;
end
%   Fit a line - order 3
p1 = polyfit(IV(:,2),IV(:,1),3);
I_Fit = polyval(p1,IV(:,2));
%plot(IV(:,2),I_Fit,'k-');
Error = (IV(:,1) - I_Fit).^2;
PercentError = Error ./ sum(Error);
MeanPercentError = mean(PercentError);
ToKeep = PercentError < (2.5 * (MeanPercentError));

%  Remove really bad points
IV_Edit = IV(ToKeep,:);
if(verbose == 1)
plot(IV_Edit(:,2),IV_Edit(:,1),'.b');
end
%Check there is a crossing of 0 current in the cleaned up data
if ((max(IV_Edit(:,1))>0) && (min(IV_Edit(:,1)) < 0))
    %   Select points nPoints either side of zero current
    %   Find 0 crossing index
    k = max(size(IV_Edit));
    Zero = 1;
    for i = 2:k
        if(( IV_Edit(i-1,1) < 0 && IV_Edit(i,1) > 0))
            %this is the zero crossing  - though could be more robust
            Zero = i;
        end
        if(( IV_Edit(i-1,1) > 0 && IV_Edit(i,1) < 0))
            %This is the zero corssing if in the other direction.
            Zero = i;
        end
    end
    if(Zero > 1)
        index = 1:k;
        index_use = (index <= Zero+nPoints) & (index >= Zero-nPoints);
        IV_Use = IV_Edit(index_use,:);
        if(verbose == 1)
        plot(IV_Use(:,2),IV_Use(:,1),'+r');
        end
    else
        %Data doesn't cross zero - so just use all
        IV_Use = IV_Edit;
        OrderFit = 1;
        warning('Data doesn''t go through 0 current')
    end
    %   Fit a curve
    %Plot V = IR + C  - can just take C as intercept
    p = polyfit(IV_Use(:,1),IV_Use(:,2),OrderFit);
    V_Fitted = polyval(p,IV(:,1));
    %plot(V_Fitted,IV(:,1),'-b');
    %   Find the Zero crossing value
    V_intercept = p(OrderFit+1);
    
    % Display and Tidy
    
    if(verbose == 1)
    display(['Voltage Interecept is ' num2str(p(OrderFit+1))])
    x = 1.1*IV(:,2);
    y = zeros(n);
    plot(x,y,'-k');
    y = 1.1*IV(:,1);
    x = V_intercept * ones(n);
    plot(x,y,'-k');
    end
else
    V_intercept =  0;
    display('There is no voltage Intercept')
    title('There is no current intercept in this graph');
    Zero = 0;
end

if(verbose == 1)
xlabel('Voltage (mV)')
ylabel('Current (nA)')
title('Determining Voltage Intercept')

xlim([1.1*min(IV(:,2)) 1.1*max(IV(:,2))])
ylim([1.1*min(IV(:,1)) 1.1*max(IV(:,1))])
end
end

