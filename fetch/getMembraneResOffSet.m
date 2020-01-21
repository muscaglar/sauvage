
function [conc_res] = getMembraneResOffSet(CapIDs)

FileTypes = [0 1];

%Load all the experiments with this capillary

DB = DBConnection;
E = Experiments(DB);

Suppressed = [0 16];

sealed_resistance = [];
sealed_conc =[];
v_offset = [];
i_offset = [];
c_ids = [];

for CapID = CapIDs
    
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
            
            v_offset = [v_offset, E.getVoffset()];
            i_offset = [i_offset, E.getIoffset()];
            
            c_ids = [c_ids, CapID];
            
            isNext = E.NextResult();
        end
    end
end

conc_res = [sealed_conc',sealed_resistance'];
conc_ratio = conc_res(:,2)/conc_res(1,2);
v_offset = v_offset';
i_offset = i_offset';

conc_res = [c_ids',conc_res,conc_ratio,v_offset,i_offset];

end
