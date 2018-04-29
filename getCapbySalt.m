
function [] = getCapbySalt()

FileTypes = [0 1];

%Load all the experiments with this capillary

DB = DBConnection;
E = Experiments(DB);

Suppressed = [0 16];
%salt = "MgCl2";

c_ids = [];
    
    %SearchPhrase = ['CapillarySln = ''' salt '']; 
    SearchPhrase = ['Sealed = ''' search '']; 
    str = ["Select * FROM Capillaries WHERE " + SearchPhrase];
        % AND ' ConcatVectorToSQL( Suppressed, 'Suppressed') ' AND ' ConcatVectorToSQL( FileTypes, 'FileType') ' AND Sealed > 0 ORDER BY No ASC'];
    C.SELECT(str);
    
    
id = C.getid();
date = C.getDate();

end
