
function [conc_res] = getMembraneRes(CapID)

FileTypes = [0 1];

%Load all the experiments with this capillary

DB = DBConnection;
E = Experiments(DB);

Suppressed = [0 16];
bare_resistance = 0;


str = ['Capillary = ''' num2str(CapID) ''' AND ' ConcatVectorToSQL( Suppressed, 'Suppressed') ' AND ' ConcatVectorToSQL( FileTypes, 'FileType') ' AND Sealed = 0 ORDER BY No ASC'];
E.SELECT(str);


isNext = 1;
i = 1;

clear Eindex;
clear Es;

if E.getid > 0
    while isNext
        Eindex(i) = E.getid();
        Expts(i) = Experiments(E, DB);
        i = i+1;
        
        bare_conc = E.getReservoirConc();
        bare_resistance = E.getResistance() + bare_resistance;
        
        isNext = E.NextResult();
    end
    
    No = length(Eindex);
    bare_resistance = bare_resistance/No;  
end

sealed_resistance = [];
sealed_conc =[];
v_offset = [];
i_offset = [];

DB = DBConnection;
E = Experiments(DB);
str = ['Capillary = ''' num2str(CapID) ''' AND ' ConcatVectorToSQL( Suppressed, 'Suppressed') ' AND ' ConcatVectorToSQL( FileTypes, 'FileType') ' AND Sealed > 0 ORDER BY No ASC'];
E.SELECT(str);

isNext = 1;
i = 1;

clear Eindex;
clear Es;

if E.getid > 0
    while isNext
        Eindex(i) = E.getid();
        Expts(i) = Experiments(E, DB);
        i = i+1;
        %E.get
        sealed_resistance = [sealed_resistance, E.getResistance()];
        sealed_conc = [sealed_conc, E.getReservoirConc()];
        
        isNext = E.NextResult();
    end
end

conc_res = [sealed_conc',sealed_resistance'];
conc_res = [[bare_conc,bare_resistance];conc_res];
conc_ratio = conc_res(:,2)/conc_res(1,2);

conc_res = [conc_res,conc_ratio];

end
