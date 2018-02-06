function [ Rm_vector, Cm_vector, Rc, Cc ,AC_Sealed, AC_Fitted_Sealed , r2_vector , E] = ACMembraneSubCircuit( SealedExperimentIDs, Rc, Cc )
%ACMEMBRANESUBCIRCUIT Fit to a sealed capillary using the values for the
%bare cpaillary resistance and capactiance

%Note if Rc and Cc are bare then will fit to them

Rm_vector =  [];
Cm_vector = [];
r2_vector = [];

for SealedExperimentID = SealedExperimentIDs
    [AC_Sealed  , ~, ~, volts, E] = ACLoadByIDandCorrect( SealedExperimentID);
    
   
    [ Rm, Cm, Rc, Cc, AC_Fitted_Sealed , r2] = MembraneAndCapillaryFit( AC_Sealed , Rc, Cc , volts );
    [ rValue, rStringValue, rid ] = UpdateNameValueExperiment( E.getid() , 'Rm', Rm);
    [ rValue, rStringValue, rid ] = UpdateNameValueExperiment( E.getid() , 'Cm', Cm);
    [ rValue, rStringValue, rid ] = UpdateNameValueExperiment( E.getid() , 'Rc', Cm);
    [ rValue, rStringValue, rid ] = UpdateNameValueExperiment( E.getid() , 'Cc', Cm);
    
    Rm_vector =  [Rm_vector Rm];
    Cm_vector = [Cm_vector Cm];
    r2_vector = [r2_vector r2];
    ACPlot(AC_Sealed, AC_Fitted_Sealed)
    %disp(['Rc = ' num2str(Rc,3) ' Cc = ' num2str(Cc,3) ' Rm = ' num2str(Rm,3) ' Cm = ' num2str(Cm,3) ' r2: ' num2str(r2,2)])
    disp(['Rc = ' num2str(Rc,3) ' Cc = ' num2str(Cc,3) ' Rm = ' num2str(Rm(1),3) ' Cm = ' num2str(Cm(1),3) ' r2: ' num2str(r2(1),2)])

end

end

