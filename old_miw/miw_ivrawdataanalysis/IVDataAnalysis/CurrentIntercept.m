
function [ I_Intercept ] = CurrentIntercept( IV, varargin)
%FindCurrentIntercept Find the voltage for which current is 0
%   Pick points either side of zero Voltage - note will need to remove lost
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
%  Remove really bad points
IV_Edit = IVClean(IV);
if(verbose == 1)
plot(IV_Edit(:,2),IV_Edit(:,1),'.b');
end
%Check there is a crossing of 0V in the cleaned up data
if ((max(IV_Edit(:,2))>0) && (min(IV_Edit(:,2)) < 0))
    %   Select points nPoints either side of zero current
    %   Find 0 crossing index
    k = max(size(IV_Edit));
    Zero = 1;
    for i = 2:k
        if(( IV_Edit(i-1,2) < 0 && IV_Edit(i,2) > 0))
            %this is the zero crossing  - though could be more robust
            Zero = i;
        end
        if(( IV_Edit(i-1,2) > 0 && IV_Edit(i,2) < 0))
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
    p = polyfit(IV_Use(:,2),IV_Use(:,1),OrderFit);
    I_Fitted = polyval(p,IV(:,2));
    %plot(IV(:,2),I_Fitted,'-b');
    %   Find the Zero crossing value
    I_Intercept = p(OrderFit+1);
    
    % Display and Tidy
       if(verbose == 1)
    display(['Current Interecept is ' num2str(I_Intercept)]);
       
    x = zeros(n);
    y = 1.1*IV(:,1);
    plot(x,y,'-k');
    y =  I_Intercept * ones(n);
    x = 1.1*IV(:,2);
    plot(x,y,'-k');
    title({'Determining Current Intercept ',num2str(I_Intercept)});
       end
else
    I_Intercept =  0;
    display('There is no current Intercept')
    title('There is no current intercept in this graph');
end

if(verbose == 1)
    xlabel('Voltage (mV)')
    ylabel('Current (nA)')
    
    xlim([1.1*min(IV(:,2)) 1.1*max(IV(:,2))])
    ylim([1.1*min(IV(:,1)) 1.1*max(IV(:,1))])
end    
end

