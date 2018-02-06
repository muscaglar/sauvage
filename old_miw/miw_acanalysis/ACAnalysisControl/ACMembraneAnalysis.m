function [ Rm, Cm, Rc, Cc, r2, AC_Fitted_Sealed, AC_Fitted_bare ] = ACMembraneAnalysis( BareExperimentID, SealedExperimentIDs, GraphPrefix )
%ANALYSEMEMBRANECAPILLARY Summary of this function goes here
%   Detailed explanation goes here

if(~isempty(BareExperimentID))
    [AC_bare , ~, ~, volts, E_bare] = ACLoadByIDandCorrect( BareExperimentID );
    [ Rc_bare, Cc_bare, AC_Fitted_bare, r2_bare  ] = ParallelFit( AC_bare , volts );
    ACPlot(AC_bare, AC_Fitted_bare);
    if E_bare.getid > 0
        [ rValue, rStringValue, rid ] = UpdateNameValueExperiment( E_bare.getid , 'Rc', Rc_bare);
        [ rValue, rStringValue, rid ] = UpdateNameValueExperiment( E_bare.getid , 'Cc', Cc_bare);
    end
    disp(['Bare Rc = ' num2str(Rc_bare,3) ' Cc = ' num2str(Cc_bare,3) 'r2: ' num2str(r2_bare,2)])
end
if nargin > 1 && not(isempty(SealedExperimentIDs))
    %Change which of these two lines to use to choose whether to free fit
    %of use the values of Rc and Cc from bare.
    %[ Rm, Cm, Rc, Cc, AC_Sealed, AC_Fitted_Sealed , r2] = ACMembraneSubCircuit( SealedExperimentIDs, Rc_bare, Cc_bare );
    [ Rm, Cm, Rc, Cc, AC_Sealed, AC_Fitted_Sealed , r2, E_Sealed] = ACMembraneSubCircuit( SealedExperimentIDs, [], [] );
    
    ACPlot(AC_Sealed, AC_Fitted_Sealed);
end


%Now optiionally plot this information in Origin **************************
if nargin > 2
    GraphPrefix = [GraphPrefix num2str(E_Sealed.getCapillary)];
    
    ORG = Matlab2OriginPlot;
    if(~isempty(BareExperimentID))
        %Could re load the raw data dn use ACPlotInOriginByID
        LegendInfo = ['Bare E: ' num2str(BareExperimentID) ];
        ORG = ACplotInOrigin( AC_bare,ORG, GraphPrefix, LegendInfo,1 );
        ORG.HoldOn;
        
        LegendInfo_Bare = ['Bare Fit E: ' num2str(BareExperimentID) ' Par Rc:' num2str(Rc_bare,3) ' Cc:' num2str(Cc_bare,3) ' r2:' num2str(r2_bare,3)];
        ORG = ACplotInOrigin( AC_Fitted_bare,ORG, GraphPrefix, LegendInfo_Bare  );
    end
    
    %Could re load the raw data dn use ACPlotInOriginByID
    LegendInfo = ['Sealed E: ' num2str(SealedExperimentIDs) ];
    ORG = ACplotInOrigin( AC_Sealed,ORG, GraphPrefix, LegendInfo,1 );
    ORG.HoldOn;
    
    LegendInfo_Sealed = ['Sealed Fit E: ' num2str(SealedExperimentIDs) 'Rc:' num2str(Rc,3) ' Cc:' num2str(Cc,3) ' Rm:' num2str(Rm,3) ' Cm:' num2str(Cm,3) ' r2:' num2str(r2,3)];
    ORG = ACplotInOrigin( AC_Fitted_Sealed,ORG, GraphPrefix, LegendInfo_Sealed );
    ORG.Disconnect;
end
GraphPrefix

end

