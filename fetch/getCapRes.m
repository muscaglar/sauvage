function [bare_resistance] = getCapRes(cID)
FileTypes = [0 1];
DB = DBConnection;
E = Experiments(DB);
Suppressed = [0 16];
str = ['Capillary = ''' num2str(cID) ''' AND ' ConcatVectorToSQL( Suppressed, 'Suppressed') ' AND ' ConcatVectorToSQL( FileTypes, 'FileType') ' AND Sealed = 0 ORDER BY No ASC'];
E.SELECT(str);
bare_resistance = E.getResistance();
end