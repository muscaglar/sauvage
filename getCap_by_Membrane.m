
function [c_ids] = getSolConcs()

FileTypes = [0 1];

CapIDs = [1:1:500];

%Load all the experiments with this capillary

DB = DBConnection;
E = Experiments(DB);

Suppressed = [0 16];

c_ids = [];

for CapID = CapIDs
    
    str = ['Capillary = ''' num2str(CapID) ''' AND ' ConcatVectorToSQL( Suppressed, 'Suppressed') ' AND ' ConcatVectorToSQL( FileTypes, 'FileType') ' AND Sealed > 0 ORDER BY No ASC'];
    E.SELECT(str);
    
%     isNext = 1;
%     i = 1;
    
    clear Eindex;
    clear Es;
    
%     if E.getid > 0
%         while isNext
%             Eindex(i) = E.getid();
%             Expts(i) = Experiments(E, DB);
%             i = i+1;
            
            c_sln = E.getCapillarySln();
            c_sln = cellstr((c_sln.toCharArray)');
            
            if ( contains(c_sln{1},'Na','IgnoreCase',true) )
                c_ids = [CapID, c_ids];
            end
            
%            isNext = E.NextResult();
%         end
%     end
end

end
