function [ Diameter_nm, R_NewPore, R_Membrane, BareID, BeforeID, BrokenIDs ] = VBreakPoreSizeByCapillary( CapillaryID, save )
%VBREAKPORESIZEBYCAPILLARY Calculate the pore size for a capillary after
%breaking

if nargin < 2
    save = 0;
end

%Will need to find the correect IDs....
DB = DBConnection;
E_Bare = Experiments(DB);
E_Sealed = Experiments(DB);
E_VBreak = Experiments(DB);

%Finding bare and sealed is easy - using suppression codes
%Need to re initialise for each loop  - ideally with inbuilt routine
E_Bare.setid(0);
E_Sealed.setid(0);
str = ['Capillary = ''' num2str(CapillaryID) ''' AND Suppressed = 0 AND Sealed = ''0'' ORDER BY No DESC'];
E_Bare.SELECT(str);
E_Bare.CloseConnection;
BareID = E_Bare.getid();
%Select sealed which is the LAST of either unsupressed or supressed = 20
%and sealed - this is the one before breaking
str = ['Capillary = ''' num2str(CapillaryID) ''' AND ' ConcatVectorToSQL( [0 20 21], 'Suppressed') ' AND Sealed > 0 ORDER BY No DESC'];
E_Sealed.SELECT(str);
E_Sealed.CloseConnection;
BeforeID = E_Sealed.getid();

%Need to find the correct one - use the last before taking translcoations
%- or after the last V break - this will mess up for occasiona where I have
%gone back - get the first trace with translocations
T = Traces(DB);
Tstr = ['tCapillary = ''' num2str(CapillaryID) ''' AND (tSuppressed = 0) AND tSealed > 0 AND TranslocationsYN > 0 ORDER BY No ASC'];
T.SELECT(Tstr)
T.CloseConnection;

if(T.getid > 0)
    str = ['Capillary = ''' num2str(CapillaryID) ''' AND (Suppressed = 18) AND Sealed > 0 AND No < ' num2str(T.getNo) ' ORDER BY No DESC'];
    E_VBreak.SELECT(str);
    if(E_VBreak.getid == 0)
        str = ['Capillary = ''' num2str(CapillaryID) ''' AND (Suppressed = 18) AND Sealed > 0 ORDER BY No DESC'];
        E_VBreak.SELECT(str);
    end
else
    str = ['Capillary = ''' num2str(CapillaryID) ''' AND (Suppressed = 18) AND Sealed > 0 ORDER BY No DESC'];
    E_VBreak.SELECT(str);
end
BrokenIDs = arrayfun(@(e)e,  E_VBreak.ResultSetIDs.toArray() );
E_VBreak.CloseConnection;

i = 0;
for AfterID = BrokenIDs'
    i = i+1;
    if (BareID > 0) && ( BeforeID > 0 ) && ( AfterID > 0 )
        [ D, Rn, Rm] = VBreakPoreSize( BareID, BeforeID, AfterID, [], save );
        Diameter_nm(i) = D;
        R_NewPore(i) = Rn;
        R_Membrane(i) = Rm;
    else
        Diameter_nm(i) = 0;
        R_NewPore(i) = 0;
        R_Membrane(i) = 0;
    end
end

if (BareID > 0) && ( BeforeID > 0 ) && ( BrokenIDs(1) > 0 )
    disp(['Cap ' num2str(CapillaryID) ' Pore d = ' num2str(Diameter_nm(1)) ' Broken ID ' num2str(BrokenIDs(1)) ' Before ID ' num2str(BeforeID) ' Bare ID ' num2str(BareID) ])
    if save == 1
        UpdateNameValueCapillary( CapillaryID, 'VBreakPoreDiameter', Diameter_nm(1) );
    end
else
    disp(['Cap ' num2str(CapillaryID) ' Not enough info to calc broken pore']);
end

end

