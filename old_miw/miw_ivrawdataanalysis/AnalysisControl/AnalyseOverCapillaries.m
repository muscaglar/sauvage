function [ ouput_arg ] = AnalyseOverCapillaries(Caps)
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
        AnalyseByCapillary( CapNo, 0,1);
        
        
    end
    if exist('ACAnalysisByCapillary','file') > 0
        ACAnalysisByCapillary( Caps );
    end
    
else
    warning('You need to have defined the Caps variable')
end
end