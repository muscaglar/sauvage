
function [c_ids] = getCap_by_Membrane()

FileTypes = [0 1];

CapIDs = [300:1:700];

%Load all the experiments with this capillary

DB = DBConnection;
E = Experiments(DB);

Suppressed = [0 16];

c_ids = [];

searchTerm = 83;

for CapID = CapIDs
    
    str = ['Capillary = ''' num2str(CapID) ''' AND ' ConcatVectorToSQL( Suppressed, 'Suppressed') ' AND ' ConcatVectorToSQL( FileTypes, 'FileType') ' AND Sealed = ' num2str(searchTerm)];
    E.SELECT(str);
    
    if E.getid > 0
        c_ids = [CapID, c_ids];
        break;
    end
    
end

end

%24 = P1
