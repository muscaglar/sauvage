 function [VoltageGradient, CurrentGradient, VOffset, IOffset, ResConcs,CapConcs, VoltageOffsets, CurrentOffsets, No, allCaps ] = AdjustedSelectivity(CapIDs)

cID = [];
cConc = [];
vOffset = [];
iOffset = [];
allCaps = [];
count = 1;

for CapID = CapIDs
    [VoltageGradient, CurrentGradient, VOffset, IOffset, ResConcs,CapConcs, VoltageOffsets, CurrentOffsets, No ] = Selectivity(CapID);
    lCount = 0;
    index = size(ResConcs, 2);
    c_index = [];
    
    test = zeros(1,size(ResConcs,2));
    test = test + CapID;
    allCaps = [allCaps, test];
    
    NaN_index = isnan(VoltageOffsets);
    
    ResConcs(NaN_index) = [];
    CapConcs(NaN_index) = [];
    VoltageOffsets(NaN_index) = [];
    
    % In the case where there is only two combinations of data, the output
    % seems to be null. 
    
    for i = 1:index
        if ResConcs(i) == CapConcs(1) && ResConcs(i+1) == CapConcs(1)
            if ResConcs(i+2) == CapConcs(1)
                c_index = [i,i+2];
                if ResConcs(i+3) == CapConcs(1)
                c_index = [i,i+3];
                end
            else
                c_index = [i,i+1];
            end
            
            vOffset = 0;
            iOffset=0;
            for nIndex = c_index(1):c_index(2)
                %Do All average.
                vOffset = vOffset + VoltageOffsets(nIndex);
                iOffset = iOffset + CurrentOffsets(nIndex);
            end
            
            vOffset = vOffset /  ((c_index(2)-c_index(1))+1);
            iOffset = iOffset /  ((c_index(2)-c_index(1))+1);
            break
        end
    end

    VoltageOffsets = VoltageOffsets - vOffset;
    CurrentOffsets = CurrentOffsets - iOffset;
    
     for nIndex = c_index(1):c_index(2)
                ResConcs(c_index(1)) =  [];
                CapConcs(c_index(1)) =  []; 
                VoltageOffsets(c_index(1)) =  []; 
                CurrentOffsets(c_index(1)) =  [];
     end
    %close all;
    Xrange = [0.00001,1000];
    
    range_one = ResConcs>Xrange(1);
    range_two = ResConcs<Xrange(2);
    range = range_one & range_two; 
    
    ResConcs = ResConcs(range);
    CapConcs = CapConcs(range) ; 
    VoltageOffsets= VoltageOffsets(range) ; 
    CurrentOffsets = CurrentOffsets(range) ;
    
    % Now to correct for the ‘drift’
    % Count down to find the last time the ResConc = CapConc
    
    new_res = fliplr(ResConcs);
    size_new_res = size(new_res,2);
    new_count = 1;
    
    matched_index = [];
    matched_offset = [];
    
    for i = 1:size_new_res
        if new_res(i) == CapConcs(1)
            matched_index(new_count) = [i];
            matched_offset(new_count) = [VoltageOffsets(i)];
            new_count = new_count + 1;
        else
            if new_count > 1
                break
        
            end
            
        end
    end
    
    new_offset = mean(matched_offset);
    
     VoltageOffsets = VoltageOffsets - new_offset;
    
    figure; 
    
    [VoltageGradient, CurrentGradient, VOffset, IOffset, XV, XI ] = SelectivityFromValues( ResConcs,CapConcs, VoltageOffsets, CurrentOffsets, Xrange, CapID );
    
%     number = log10(CapConcs(1));
%     
%     if number < 1 && number > 0
%         number = num2str(number);
%         number(2)=[];
%     else
%         number = num2str(number);
%     end
%     
%     fName = strcat(num2str(count),'_',number,'_',num2str(CapID));
%     print(fig,fName,'-dpng');
    
    count = count +1 ;
end


end
