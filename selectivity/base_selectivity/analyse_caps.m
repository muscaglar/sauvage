function [] = analyse_caps(cIDs)

for cID = cIDs
    DBc = DBConnection;
    C = Capillaries(DBc, cID);
    if(C.getid > 0)
        %Load all the experiments with this capillary
        DB = DBConnection;
        E = Experiments(DB);
        str = ['Capillary = ''' num2str(cID) ''' AND Suppressed != 4']; % AND Suppressed = 0'] % AND Sealed > 0']
        E.SELECT(str);
        if(E.getid >0)
            isNext = 1;
            i = 1;
            clear Dates
            clear Numbers
            clear ids
            while isNext
                ids(i) = E.getid();
                Dates(i) = GetNumericDate(E.getDate());
                Numbers(i) = E.getNo();
                i = i+1;
                isNext = E.NextResult();
            end
            
            i = 1;
            for No = Numbers
                [ FileName, PathName ]  = grab_data( Dates(i), No );
                %Now determine the correct analysis to run - either from
                %filename or a type code in the pairr values table
                if(not(isempty(strfind(FileName, 'AC'))))
                    warning('Not an IV Curve');
                else
                    %Assume it is an IV Curve - unless other info
                    [ Data ] = process_iv(FileName, PathName);
                end
                i = i+1;
            end
        else
            warning('There are no experiments for this capillary');
        end
    end
end

    function [ FileName, PathName ] = grab_data( Date, No , AllowDownload )
        FileName = ' ';
        %PathName;
        if nargin < 3
            %Default to allow download
            AllowDownload = 1;
        end
        %Should deal with if only one variable then treat as ID
        
        [PathName, DateStr ] = ConstructDataPath( Date);
        
        
        if exist(PathName,'dir') ~= 0
            files = dir(PathName);
            ApproxFileName = [DateStr '_' num2str(No) '_'];
            
            for file = files'
                %See if the file matches the date and no
                if not(isempty(strfind(file.name, ApproxFileName))) && not(isempty(strfind(file.name, '.txt')))
                    %[date2, no2] = FileNameInterpret( file.name );
                    FileName = file.name;
                end
            end
        end
        
        if exist([PathName '/' FileName],'file') ~= 2 && AllowDownload == 1
            [ FileName, PathName ] = GetCloudData( Date, No );
        end
    end

end

