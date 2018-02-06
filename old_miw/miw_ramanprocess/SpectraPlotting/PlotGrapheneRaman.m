function [ output_args ] = PlotGrapheneRaman( Spectra, FittedSpectra, Save,FileName,PathName)
%PlotRaman Plot the Raman spectra and if appropriate save to a subfolder
%   Plot a summary of the Graphene Raman and the fitted curve - to check
%   the perfomance of the code
%   No need to add any fit details but could
    if nargin < 3
       Save = 0; 
    end

    %Plot
    figure(2);
    hold off;
    %Plot the Raw data with baseline removed
    plot(Spectra(:,1),Spectra(:,2), 'k-');
    hold on;
    %Plot the fitted Spectra
    plot(FittedSpectra(:,1),FittedSpectra(:,2), 'r-');
    
    hold off;
    %Set Limits of x 12000-3000
    xlim([1000 3200]);
    %Add titles
    [ date, no, details] = FileNameInterpret( FileName );
    title(['Raman Spectra Processed: ' num2str(date) ' - ' num2str(no) ' ' details]);
    xlabel('Raman Shift cm^-1');
    ylabel('Baseline Removed');
    
    set(gca,'XTick',linspace(1000,3200,6))
    ylimits = ylim;
    set(gca,'YTick',linspace(ylimits(1),ylimits(2),6))
    switch(Save)
        case 0
            disp('Don''t save');
            
        case 1
            if exist([PathName '/Analysis']) == 0
                mkdir(PathName,'Analysis') 
            end
            if exist([PathName '/Analysis/Plots']) == 0
                mkdir([PathName '/Analysis'],'Plots') 
            end
            print([PathName '/Analysis/Plots/' num2str(date) '_' num2str(no) '_' details '.jpg'],'-djpeg') 
        otherwise 

    end
    %Set Focus back to the other figure
    figure(1);

end

