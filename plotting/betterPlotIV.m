function [ output_args ] = betterPlotIV(Input,PlotName)

SealedYN = 1;
Suppressed = [0 16];

for input = Input
    [ ~, ~, ExptIDs  ] = LoadExperiments( input, SealedYN, Suppressed );
end
eID_rConc =[];

for ExperimentID = ExptIDs
    [ FileName, PathName, Date, No, E, id ] = GetDataByID(ExperimentID);
    ResConc = E.getReservoirConc();
    eID_rConc = [eID_rConc; [ExperimentID, ResConc]];
end
ORG = Matlab2OriginPlot();
ORG.HoldOff();
i = 1;
hold on
for u = unique(eID_rConc(:,2))'
    z = 0;
    tIV = [];
    for uE = eID_rConc(eID_rConc(:,2) == u,1)'
        [ IV, ~,~ ] = LoadIVByNo(  uE );
        IV = IVClean(IV);
        tIV = catpad(2,tIV,IV);
        z = z +1;
    end
    
    %Conditioning:
    [vSteps, startCol] = min(sum(~isnan(tIV),1));
    cutIV = [];
    for x = 1:z
        cutIV_temp = [];
        for v = 1:vSteps
            allmost = isalmost(tIV(:,x*2),tIV(v,startCol+1),5);
            [mID2,mID] = find(allmost,1);
            cutIV_temp = catpad(1,cutIV_temp, [tIV(mID2,(x*2)-1),tIV(mID2,x*2)]);
        end
        cutIV = catpad(2,cutIV,cutIV_temp);
    end
    
    if sum(isnan(cutIV(:))) ==0
    else
        tIV = [];
        tIV = cutIV;
        [vSteps, startCol] = min(sum(~isnan(tIV),1));
        cutIV = [];
        for x = 1:z
            cutIV_temp = [];
            for v = 1:vSteps
                allmost = isalmost(tIV(:,x*2),tIV(v,startCol+1),5);
                [mID2,mID] = find(allmost,1);
                cutIV_temp = catpad(1,cutIV_temp, [tIV(mID2,(x*2)-1),tIV(mID2,x*2)]);
            end
            cutIV = catpad(2,cutIV,cutIV_temp);
        end
    end
    
    iIV = mean(cutIV(:,1:2:(z*2)),2);
    ieIV = std(cutIV(:,1:2:(z*2)),0,2);
    vIV = mean(cutIV(:,2:2:(z*2)),2);
    ORG.Figure([PlotName 'CapIV']);
    ORG.HoldOn;
    ORG.PlotScatterError(vIV',iIV',ieIV','CapIV', ORG.ColourPicker());
    ORG.ExecuteLabTalk('layer.x.type = 1');
    ORG.ExecuteLabTalk('layer.x.rescale = 3');
    ORG.ExecuteLabTalk('layer.y.rescale = 3');
    ORG.ylabel('Current','nA');
    ORG.xlabel('Voltage','mV');
    ORG.yComment(['Conc: ' num2str(u)]); %Put details of reservoir Conc
    ORG.HideActiveWkBk()
    if(i==1)
        %ORG.ExecuteLabTalk('addline type:=1 value:=0 select:=1');
        ORG.ExecuteLabTalk('draw -w 2 -l -h 0');
    end
    
    ORG.HoldOn();
    i = i+1;
    
end

end