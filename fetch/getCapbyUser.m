function [c_ids] = getCapbyUser(investigator)

DB = DBConnection;
C = Capillaries(DB);

c_ids = [];

SearchPhrase = ['investigator = ' num2str(investigator)];
C.SELECT(SearchPhrase);

isNext = 1;
clear Cindex;
clear Cs;

if C.getid > 0
    while isNext       
        c_ids = [c_ids, C.getid()];
        isNext = C.NextResult();
    end  
end

c_ids = (sort(c_ids))';

end