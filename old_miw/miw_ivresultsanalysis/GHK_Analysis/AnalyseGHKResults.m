function [data] = AnalyseGHKResults(Caps)

DB = DBConnection;
E = Experiments(DB);
str = '(Suppressed = 0 AND Sealed > 0) AND (';
n = 1;

for i = Caps
    if n > 1
        str = [str ' OR '];
    end
     n = n+1 ;
    str = [str 'Capillary = ''' num2str(i) ''''];
end
str = [str ')'];
E.SELECT(str);

clear Data
isNext = 1;
i = 1;
while isNext
   temp_data(i,:) = [E.getCapillaryConc() E.getReservoirConc() E.getCapillary() E.getpPerm() E.getnPerm E.getpPerm()/E.getnPerm E.getnPerm()/E.getpPerm];
   isNext = E.NextResult(); 
   i  = i+1;
end

z = 1;

for capConc = unique(temp_data(:,1))'
    capIndex = (temp_data(:,1)==capConc);
    for conc = unique(temp_data(:,2))'
        index = (temp_data(:,2)== conc);
        index = index & capIndex;
        data(z,:) = [mean(temp_data(index,1)) mean(temp_data(index,2)) mean(temp_data(index,4)) std(temp_data(index,4)) mean(temp_data(index,5)) std(temp_data(index,5)) mean(temp_data(index,6)) std(temp_data(index,6)) mean(temp_data(index,7)) std(temp_data(index,7)) ];
        z = z + 1;
    end
end

end
