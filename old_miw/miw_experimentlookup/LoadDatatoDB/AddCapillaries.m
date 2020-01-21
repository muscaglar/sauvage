function [ CapID ] = AddCapillaries( Date, CapType, CapNo ,ExperimentType, BareIVCurves,SealedIVCurves,AwayIVCurves, Membrane , User, SeiectivityExpts, CapSol, CapConc, CapPH, TracesMatrix )

CapID = GetCapID( Date, CapNo );
if(CapID == 0)
    DB = DBConnection;
    C = Capillaries(DB);
    
    %Create Capillary
    Da  = GetDBDate( Date );
    %if(BareExpts(1) < SealedExpts(1))
    C.setDate(Da);
    C.setCapNo(CapNo);
    C.setType(CapType);
    C.setExptType(char(ExperimentType));
    C.setinvestigator(User);
   C.INSERT;
else
    %Capillary allready exists
end

%Now need to get the Cap no which corresponds
CapID  = GetCapID( Date, CapNo );
if CapID > 0
    %Now add the experiments
    e = AddExperiments( CapID, Date, BareIVCurves,SealedIVCurves,AwayIVCurves, Membrane, SeiectivityExpts,  CapSol, CapConc, CapPH );
    
    %Now Add the TracesMatrix
    t = AddTraces( CapID, Date, Membrane,  CapSol, CapConc, CapPH, TracesMatrix );
    
    disp(['Added: ' num2str(e) ' list experiments and ' num2str(t) ' TracesMatrix']);
    
else
    error('Cannot add experiments as CapID = 0');
end
%end

end

