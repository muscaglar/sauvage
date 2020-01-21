function [ ouput_arg ] = AnalyseOverCapillaries_Multi(Caps, z)
%Analyse Over Capillaries

if(exist('Caps','var'))
    %*************************************************************************
    Offset = [];
    for i = Caps
        disp(['Capillary: ' num2str(i)]);
        CapNo = i;
        %May need to load experiments and find selectivities to remove
        %offsets
        %Es = LoadExperiments(CapNo)
        %Selectivity(Es)
        
        %AnalyseByCapillary( CapNo, VOffset,1)
        AnalyseByCapillary_Multi( CapNo, 0,1,z);
        
        
    end
    if exist('ACAnalysisByCapillary','file') > 0
        ACAnalysisByCapillary( Caps );
    end
    
else
    warning('You need to have defined the Caps variable')
end
end