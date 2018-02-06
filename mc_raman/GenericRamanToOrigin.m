function [ ] = GenericRamanToOrigin() %Capillary, bias )
    
    FileRoots;
    d = uigetdir(SpectraRoot, 'Select a folder');
    files = dir(fullfile(d, '*.txt'));
    
    % Display the names

    file_nos = size(files);
    file_nos = file_nos(1);
    PathName = [files(1).folder '/'];
     
    %Plot in Origin
            ORG = Matlab2OriginPlot();

    for i = 1:1:file_nos
            
        FileName = files(i).name;
            
            data = dlmread([PathName FileName]);

            RamanShift = data(:,1);%data(1:2:end,:);
            count = data(:,2); %data(2:2:end,:);

       
            %Plot the points for offset
            ORG.Figure([FileName]);
            ORG.HoldOn;
            %ORG.PlotScatter(RamanShift', count',['Count'],'LT Magenta');
            ORG.PlotLine(RamanShift', count',['Count'],'LT Magenta');
            ORG.xlabel('Raman Shift','cm^-1');
            ORG.ylabel('Counts','arb units');
            ORG.yComment('Counts');
            ORG.title([FileName]);
            ORG.HideActiveWkBk()
                  ORG.ExecuteLabTalk('layer.x.from = 1250');
                  ORG.ExecuteLabTalk('layer.x.to = 3250'); %xaxisTo function in M2O
            ORG.HoldOff;
    end
    
   
    
    %Plot the points for offset
    
    ORG.Disconnect();
    
    %% To do - 

end