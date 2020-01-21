function [] = correctSolutions(cIDs, sol_name )

DB = DBConnection;
Ex = Experiments(DB);
FileTypes = [0 1];

for CapID = cIDs
    
    str = ['Capillary = ''' num2str(CapID) ''' AND ' ConcatVectorToSQL( FileTypes, 'FileType') ' ORDER BY No ASC'];
    Ex.SELECT(str);
    
    isNext = 1;
    
    clear Eindex;
    clear Es;
    if Ex.getid > 0
        while isNext
            
            Ex.setCapillarySln(sol_name);
            Ex.setReservoirSln(sol_name);
            d = DBSupportCode.DBDateTime;
            d.now();
            Ex.UPDATE();
            %Ex.INSERT;
            isNext = Ex.NextResult();
        end
        
    end
end

end
