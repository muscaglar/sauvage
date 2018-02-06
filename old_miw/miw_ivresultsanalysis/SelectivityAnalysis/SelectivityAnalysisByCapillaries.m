function [ output_args ] = SelectivityAnalysisByCapillaries( CapillaryIDs )
%SELECTIVITYBYCAPILLARY Cacl selectivit for capillaries individually and
%save values to name value piars - nb pass indicvidually into selectivity
%as if passed together it will calc an average

for CapillaryID = CapillaryIDs
    [ C, ~,~ ] = GetCapillaryDetails( CapillaryID);
    
    [ VoltageGradient, CurrentGradient, VOffset, ~, ~,~, ~, ~, NoSelectivityResults ] = Selectivity( CapillaryID );
    [ VoltageGradient_Limited, CurrentGradient_Limited,VOffset_Limited, ~, ~,~, ~, ~, NoSelectivityResultsLimit] = Selectivity( CapillaryID, 0.0002, 0.2);
    if (NoSelectivityResults > 0)
        UpdateNameValue(0, 0, C.getid(), 0,'SelectivityVoltage_Full', VoltageGradient(1));
        UpdateNameValue(0, 0, C.getid(), 0,'SelectivityCurrent_Full', CurrentGradient(1) );
        UpdateNameValueCapillary(C.getid(),'VoltageOffsetFull', VOffset );
    else
        disp('Didn''t add data');
    end
    if (NoSelectivityResultsLimit > 0)
        UpdateNameValue(0, 0, C.getid(), 0,'SelectivityVoltage_<0.1', VoltageGradient_Limited(1) );
        UpdateNameValue(0, 0, C.getid(), 0,'SelectivityCurrent_<0.1', CurrentGradient_Limited(1) );
        UpdateNameValueCapillary(C.getid(),'VoltageOffset_<0.1', VOffset_Limited );
    end
    
    %also do a >=1mM equivalent for the HCl results
    [ VoltageGradient_Limited, CurrentGradient_Limited,VOffset_Limited, ~, ~,~, ~, ~, NoSelectivityResultsLimit] = Selectivity( CapillaryID, 0.0005, 5);
    if (NoSelectivityResultsLimit > 0)
        UpdateNameValue(0, 0, C.getid(), 0,'SelectivityVoltage_>1mM', VoltageGradient_Limited(1) );
        UpdateNameValue(0, 0, C.getid(), 0,'SelectivityCurrent_>1mM', CurrentGradient_Limited(1) );
        UpdateNameValueCapillary(C.getid(),'VoltageOffset_>1mM', VOffset_Limited );
    end
    
end


end

