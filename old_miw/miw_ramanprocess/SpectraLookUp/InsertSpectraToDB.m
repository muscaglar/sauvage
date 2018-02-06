function [ output_args ] = InsertSpectraToDB( Date, No,MembraneNo, MembraneName, PeakInfo, Ratios, Investigator )
%Insert or Update a spectra record  - will check if it already exists and
%if it does will enter into the DB and update

%Convert Date as no 020215 into a DBDate object coorectly
Da = GetDBDate( Date );

DB = DBConnection;
%DB2 = DBConnection;
%M = Membranes(DB2);
S = Spectra(DB);
str = ['Date LIKE ''' char(Da.toString) ''' AND No = ''' num2str(No) ''' '];
S.SELECT(str);
S.CloseConnection();
if S.getid() == 0
    %Now set up the object info
    S.setDate(Da);
    S.setNo(No)
    
    %Set up the membrane.
    %M.SELECT('Name',Membrane);
    %S.setMembrane(M.getid());
    S.setMembraneName(char(MembraneName));
    S.setMembrane(MembraneNo);
    S.setComment('');
    
    S.setSInvestigator(Investigator);
else
    % There is already an entry for this one 
    % so no need to create - just update
end
    if S.getMembrane == 0
       %Membrane not set so set  - note this relies on an accurate vlaue being passed into the function on reAnalysis...
       %Once this is set need to be sure it has been set correctly...
       % S.setMembraneName(char(MembraneName));
       % S.setMembrane(MembraneNo);
    end
    % Set up the Peak info - regardless off if their is an entry this will
    % be the new analysis
    PeakInfo(isnan(PeakInfo)) = 0;
    Ratios(isnan(Ratios)) = 0;
    
    S.setLoc2D(PeakInfo(1));
    S.setScale2D(PeakInfo(2))
    S.setArea2D(PeakInfo(3));
    S.setHeight2D(PeakInfo(4));

    %Corrected 121016
    S.setLocG(PeakInfo(5));
    S.setScaleG(PeakInfo(6))
    S.setAreaG(PeakInfo(7));
    S.setHeightG(PeakInfo(8));
    
    S.setLocD(PeakInfo(9));
    S.setScaleD(PeakInfo(10))
    S.setAreaD(PeakInfo(11));
    S.setHeightD(PeakInfo(12));
    
    S.setLocDDp(PeakInfo(13));
    S.setScaleDDp(PeakInfo(14))
    S.setAreaDDp(PeakInfo(15));
    S.setHeightDDp(PeakInfo(16));
    
    S.setAnalysisDate(DBSupportCode.DBDateTime());
    
    %set up the Ratio Values  - Can calc direclty here
    S.setRatioD2D(Ratios(3));
    S.setRatioD2G(Ratios(2));
    S.setRatio2DG(Ratios(1));
    S.setNoLayers(Ratios(4));
    
    
if S.getid() == 0
    S.INSERT();
else
    S.UPDATE();
end

end

