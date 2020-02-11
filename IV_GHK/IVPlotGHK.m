function [ IVs ] = IVPlotGHK(Input,ionicKey,origin)
    IVs = containers.Map(double(1), zeros(19,2));
    remove(IVs,1);  
    ExptIDs = [];
    for input = Input 
        [ ~, ~, temp_ExptIDs  ] = LoadExperiments( input, 1, [0 16] );
        ExptIDs = [ExptIDs temp_ExptIDs];
    end

    rConcs = [];
    
for ExperimentID = ExptIDs
try
    [ IV, ~,~ ] = LoadIVByNo(  ExperimentID );
     IV = IVClean(IV);
     
    [ ~, ~, ~, ~, E, ~ ] = GetDataByID(ExperimentID);
    CapConc = E.getCapillaryConc();
    ResConc = E.getReservoirConc();
    key = CapConc*ResConc;
    
    
    if(isKey(IVs,key))
        currentIV = IV;
        oldIV = IVs(key);
        newIV = [];
        if(size(currentIV,1) > size(oldIV,1))
            for i = 1:size(currentIV,1)
                idx = isalmost(oldIV(:,2),currentIV(i,2),5);
                new1 = mean(catpad(1,oldIV(idx,1),currentIV(i,1)));
                new2 = mean(catpad(1,oldIV(idx,2),currentIV(i,2)));
                error = std(catpad(1,oldIV(idx,1),currentIV(i,1)))/sqrt(2);
                newIV = [newIV; [new1,new2,error] ];
            end
        else
            for i = 1:size(oldIV,1)
                idx = isalmost(currentIV(:,2),oldIV(i,2),5);
                new1 = mean(catpad(1,currentIV(idx,1),oldIV(i,1)));
                new2 = mean(catpad(1,currentIV(idx,2),oldIV(i,2)));
                error = std(catpad(1,currentIV(idx,1),oldIV(i,1)))/sqrt(2);
                newIV = [newIV; [new1,new2,error] ];
            end         
        end
        IVs(key) = newIV;
    
    else
        IVs(key) = IV;
        rConcs = [rConcs, ResConc];
    end
catch
    disp('Skipping, didnt find that file');
end
    
end

j = 1;
pTotal = [];
for x = IVs.keys
    ResConc = x{1}/CapConc;
   switch ionicKey
        case 'mono'
            [ghk_IV,P] = GHK_mono( IVs(x{1}), ResConc, CapConc );
        case 'duo'
            [ghk_IV,P] = GHK_duo( IVs(x{1}), ResConc, CapConc );
        case 'tri'
            [ghk_IV,P] = GHK_tri( IVs(x{1}), ResConc, CapConc );
        case 'quad'
            [ghk_IV,P] = GHK_quad( IVs(x{1}), ResConc, CapConc );
        case 'k3po4'
            [ghk_IV,P] = GHK_k3po4( IVs(x{1}),ResConc, CapConc );
        otherwise
            fprintf('Error! Try again!\n')
   end
    
    IVs(x{1}) = catpad(2,IVs(x{1}),ghk_IV);
    current = IVs(x{1});
%     figure;
%     hold on;
%     xlabel('Voltage (mV)');
%     ylabel('Current (nA)');
% 
%     scatter(current(:,2),current(:,1));
%     errorbar(current(:,2),current(:,1),current(:,3),'LineStyle','none');
%     plot(current(:,4),current(:,5))
%     plot(current(:,4),current(:,6)) 
%     plot(current(:,4),current(:,7))
%     hold off;
    if(origin)
        name = ['V',num2str(x{1}*1000/CapConc)];
        
        name3 = [num2str(x{1}*1000/CapConc)];
        
        pTotal(j,:) = [x{1}*1000/CapConc, P];
        j = j+1;
        IVGHK_toOriginPlot(current,P,name3);
        IVGHK_toOrigin(current,name);
       
        end
end
go_to_Origin(pTotal,'PSummary');
end
