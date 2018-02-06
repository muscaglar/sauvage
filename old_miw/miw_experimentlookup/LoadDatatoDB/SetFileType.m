function [ IDs ] = SetFileType( FileType, Date, No )
%SETFILETYPE Set the file type for different experiments.
% Pass in a single date and a vector of File No's

IDs = [];

for n = No
    [ ~, E] = ReturnExperimentalDetails( Date, n );
    if(E.getid() > 0)
        E.setFileType(FileType);
        E.UPDATE;
        IDs = [IDs E.getid()];
    end
end

end

