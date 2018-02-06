function [ Rc, Cc, Rm, Cm ] = ACAnalysisByCapillary( CapillaryIDs )
%ACANALYSISBYCAPILLARY Summary of this function goes here
%   Detailed explanation goes here

for CapillaryID = CapillaryIDs
    %Load all experiments that are AC
    [ ~, No_Bare, ExptIDs_bare ] = LoadExperiments( CapillaryID, 0, 4 );
    [ ~, No_Sealed, ExptIDs_sealed ] = LoadExperiments( CapillaryID, 1, 4 );
    ExptIDs = [ExptIDs_bare ExptIDs_sealed];
    %Run AC Experiment Analysis  - to fit a series and parallel model to all
    for ExperimentID = ExptIDs
        if ExperimentID > 0
            ACExperimentAnalyse( ExperimentID );
        end
    end
    if(No_Bare > 0 && No_Sealed >0)
        %Idenitfy a bare experiment
        BareExperimentID = ExptIDs_bare(1);
        %Idenitfy sealed experiments
        %Use ExptIDs_sealed
        
        %Carryout the membrane analysis on these - nb can use all Sealed
        %Experiments
        [ Rm, Cm, Rc, Cc , r2] = ACMembraneAnalysis( BareExperimentID, ExptIDs_sealed );
        
        %Save a value to the DB for the Capillary Rc, Cc, Rm and Cm
        [ rValue, rStringValue, rid ] = UpdateNameValueCapillary( CapillaryID, 'Rc_Capillary', Rc );
        [ rValue, rStringValue, rid ] = UpdateNameValueCapillary( CapillaryID, 'Cc_Capillary', Cc );
        [ rValue, rStringValue, rid ] = UpdateNameValueCapillary( CapillaryID, 'Rm_Capillary', Rm(1) );
        [ rValue, rStringValue, rid ] = UpdateNameValueCapillary( CapillaryID, 'Cm_Capillary', Cm(1) );
        [ rValue, rStringValue, rid ] = UpdateNameValueCapillary( CapillaryID, 'CapMembrane_r2', r2(1) );
        
        [ rValue, rStringValue, rid ] = UpdateNameValueCapillary( CapillaryID, 'ACMemBareExp', BareExperimentID );
        [ rValue, rStringValue, rid ] = UpdateNameValueCapillary( CapillaryID, 'ACMemSealExp', ExptIDs_sealed(1) );
        %Could also save the number of the sealed and bare used for this
        %analysis so its easier to re trace
        
    else
        disp('Cannot find bare and sealed AC results to do anlysis from');
        Rc = 0;
        Rm = 0;
        Cc = 0;
        Cm = 0;
    end
end

end

