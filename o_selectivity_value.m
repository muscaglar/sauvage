function [ VoltageGradient, CurrentGradient, VOffset, IOffset, XV, XI ] = o_selectivity_value( aResConcs,aCapConcs, aVoltageOffsets, aCurrentOffsets, Xrange, CapID,plot )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

if(plot)
    figure;
    hold on
end

[ p, StdErrors, OffsetFitted, r2] = LineFit( log10(aResConcs), aVoltageOffsets, log10(Xrange));
VoltageGradient(1) = p(1);
VoltageGradient(2) = StdErrors(1);
%semilogx(Xrange,OffsetFitted,'-b');

%Now do current Gradients

%Now do the Current Offsets
%semilogx(ResConcs,CurrentOffsets,'or');
if(plot)
    hold on
end
[ q, StdErrors, IOffsetFitted, r2] = LineFit( log10(aResConcs) , aCurrentOffsets, log10(Xrange) );
CurrentGradient(1) = q(1);
CurrentGradient(2) = StdErrors(1);
%semilogx(Xrange,IOffsetFitted,'-r');

if(plot)
    %Do plotting
    hold off;
    semilogx(aResConcs,aVoltageOffsets,'or',aResConcs,aCurrentOffsets,'+b');
    hold on
    semilogx(Xrange,OffsetFitted,'-r',Xrange,IOffsetFitted,'-b');
    
    xlabel('Reservoir Concentration');
    %ylabel(ax(1),'Offset Voltage (mV)') % left y-axis
    %ylabel(ax(2),'Offset Current (nA)') % right y-axis
    
    
    %title({['Offset from: ' num2str(0)],[ ' Expts: ' num2str(min(Numbers)) '-' num2str(max(Numbers))]});
    title({['Offset from CapNo: ' num2str(CapID) ],[ ' Voltage Gradient = ' num2str(VoltageGradient(1)) '+/-' num2str(VoltageGradient(2)) ],[ ' Current Gradient = ' num2str(CurrentGradient(1)) '+/-' num2str(CurrentGradient(2))  ]});
    
    
    %calc offsets  - find the voltage and Current at the point when it should
    %be zero
    % use p(2) and q(2)
end

VOffset = VoltageGradient(1) * log10(aCapConcs(1)) + p(2);
IOffset = CurrentGradient(1) * log10(aCapConcs(1)) + q(2);


XV = YMeans_Error(Xrange, aResConcs, aVoltageOffsets );

XI = YMeans_Error(Xrange, aResConcs, aCurrentOffsets );

%savefig(['/Users/Mus/Dropbox (Team Caglar)/PhD/MATLAB/',num2str(CapillaryID),'.fig']);

end

