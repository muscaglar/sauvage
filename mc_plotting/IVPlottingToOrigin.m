function [ output_args ] = IVPlottingToOrigin(Input, CapOrExp)

   SealedYN = 1; 
   Suppressed = 0;
   temp_ExptIDs = [];
   
   if (CapOrExp == 'Cap')
       for input = Input 
       [ ~, ~, ExptIDs  ] = LoadExperiments( input, SealedYN, Suppressed );
       temp_ExptIDs = [temp_ExptIDs ExptIDs];
       end
   else if CapOrExp == 'Exp'
       ExptIDs = Input;
       end
   end
 
   if CapOrExp ==1
      ExptIDs = temp_ExptIDs;
   end
   
   ORG = Matlab2OriginPlot();
ORG.HoldOff();
   i = 1;
hold on
for ExperimentID = ExptIDs
    [ IV, ~,~ ] = LoadIVByNo(  ExperimentID );
    [info, ~] = ReturnExperimentalDetails(ExperimentID);
     IV = IVClean(IV);
     half = size(IV(:,2));
     half = half(1);
     half = round(half / 2);
    plot(IV(:,2),IV(:,1))
    [ FileName, PathName, Date, No, E, id ] = GetDataByID(ExperimentID);
    CapConc = E.getCapillaryConc();
    ResConc = E.getReservoirConc();
    txt1 = ['\leftarrow Res =', num2str(ResConc)]; %Cap =', num2str(CapConc),'
    text(IV(half,2),IV(half,1),txt1);
    
    if(CapOrExp == 'Cap')
        title = num2str(Input);
    elseif (CapOrExp == 'Exp')
        title = [num2str(Date) 'i' num2str(No) 'i' num2str(E.getid()) ''];
    end

    ORG.PlotScatter(IV(:,2)',IV(:,1)',title, ORG.ColourPicker());
        ORG.ExecuteLabTalk('layer.x.type = 1');
        ORG.ExecuteLabTalk('layer.x.rescale = 3');
        ORG.ExecuteLabTalk('layer.y.rescale = 3');        
%         ORG.ExecuteLabTalk('layer.x.from = 1');
%         ORG.ExecuteLabTalk('layer.x.to = 1');
%         ORG.ExecuteLabTalk('layer.y.from = 1');
%         ORG.ExecuteLabTalk('layer.y.to = 1');
    ORG.ylabel('Current','nA');
    ORG.xlabel('Voltage','mV');
    ORG.yComment(['id: ' num2str(E.getid()) 'C: ' num2str(E.getCapillary()) 'R: ' num2str(E.getResistance(),3) ' Conc: ' num2str(info{7})]); %Put details of reservoir Conc
    ORG.HideActiveWkBk()
    if(i==1)
        %ORG.ExecuteLabTalk('addline type:=1 value:=0 select:=1');
        ORG.ExecuteLabTalk('draw -w 2 -l -h 0');
    end
   
    ORG.HoldOn();
       i = i+1;
end

    xlabel('Voltage (mV)');
    ylabel('Current (nA)');
    hline = refline([0 0]);
    %disp(['No of file plotted = ' num2str(f)]);
hold off;

end

