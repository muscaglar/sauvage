
function [ ResistanceMatrixRow , ResistanceAwayIncrease ] = SealAnalysis( caps)

SealedSuppression = [0 20];
%Use the standard away value - but allows you to change it to look at
%the effect of sealing on a different data set

ResistanceAwayIncrease = [];
ResistanceMatrixRow = [];

DB = DBConnection;
E_Bare = Experiments(DB);
E_Sealed = Experiments(DB);
E_Away = Experiments(DB);

for i = caps
    
    %Need to re initialise for each loop  - ideally with inbuilt routine
    E_Bare.setid(0);
    E_Sealed.setid(0);
    str = ['Capillary = ''' num2str(i) ''' AND Suppressed = 0 AND Sealed = ''0'' ORDER BY No ASC'];
    E_Bare.SELECT(str);
    E_Bare.CloseConnection;
    %Select sealed whcih is the first of either unsupressed or supressed = 20
    %but sealed - use sorting to get the lowest numbered
    str = ['Capillary = ''' num2str(i) ''' AND ' ConcatVectorToSQL( SealedSuppression, 'Suppressed') ' AND Sealed > 0 ORDER BY No ASC'];
    E_Sealed.SELECT(str);
    E_Sealed.CloseConnection;
    
    str = ['Capillary = ''' num2str(i) ''' AND (Suppressed = 21) AND Sealed > 0 ORDER BY No ASC'];
    E_Away.SELECT(str);
    E_Away.CloseConnection;
    
    
    if(E_Sealed.getid > 0  && E_Bare.getid > 0)
        if(E_Bare.getResistance > 0 && E_Sealed.getResistance >0)
            %Add a name value pair for resistance ratio - note could add
            %cde abaove to check if this is already calculated - but still
            %need membrane id.
            ResistanceRatio = E_Sealed.getResistance() / E_Bare.getResistance();
            if(nargin < 3)
                %Only update if using the normal resistance ratio
                UpdateNameValue(0, 0, i, 0,'ResistanceRatio', ResistanceRatio);
            end
            
            ResistanceMatrixRow = [ResistanceMatrixRow; E_Bare.getResistance() E_Sealed.getResistance() E_Sealed.getSealed() ];
        else
            warning(['No resistance values for Capillary ' num2str(i) ' - need to run IV Analyse']);
            
        end
    else
        warning(['No resistance Experiments for Capillary ' num2str(i) ' ']);
    end
    
    if(E_Sealed.getid > 0  && E_Away.getid > 0 && E_Sealed.getNo < E_Away.getNo)
        if(E_Away.getResistance > 0 && E_Sealed.getResistance >0)
            ResistanceAwayIncrease = [ResistanceAwayIncrease, E_Away.getResistance / E_Sealed.getResistance];
            if(nargin < 3)
                %Only store value if using default
                %UpdateNameValue(0, 0, i, 0,'ResistanceAwayIncrease', ResistanceAwayIncrease);
            end
        else
            warning(['No Away values for Capillary ' num2str(i) ' - need to run IV Analyse']);
            
        end
    else
        warning(['No Away Experiments for Capillary ' num2str(i) ' - need to add data']);
        
    end
    
end
end

