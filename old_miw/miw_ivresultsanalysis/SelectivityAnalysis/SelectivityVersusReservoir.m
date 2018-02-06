%USE OP to choose which to plot
function [ output_args ] = SelectivityVersusReservoir( CapIDs , OP, PlotName)
%SELECTIVITYVERSUSRESERVOIR

if nargin < 3
    PlotName = [];
    if nargin < 2
        OP = 0;
    end
end

ResConcs = [];
CapConcs  = [];
Voffset_mV = [];
valency = [];

%Load all Selectivites
for CapillaryID = CapIDs
    [ Expts, No, ExptIDs ] = LoadExperiments( CapillaryID, 1 , [0 16]);
    [ CapillaryVoffset, ~ ] = VOffsetCorrection( CapillaryID , 0.1 );
    %CapillaryVoffset = 0;
    for i = 1:No
        E = Expts(i);
        res = E.getReservoirConc;
        cap = E.getCapillaryConc;
        %Only load where there is a difference
        v = ValencyFromSln( char(E.getCapillarySln) );
        if not((v == 2 && res==2 && cap == 1))
            if(res ~= cap && E.getVoffset ~= 0.00)
                ResConcs = [ResConcs res];
                CapConcs  = [CapConcs cap];
                Voffset_mV = [Voffset_mV (E.getVoffset - CapillaryVoffset)];
                valency = [valency v];
            end
        else
            warning(['not using exp:' num2str(E.getid) ' from capillary C ' num2str(CapillaryID) ' due to the error for 2M, 1M and valency 2']);
        end
    end
end
MaxConc = max([ResConcs;CapConcs]);
MinConc = min([ResConcs;CapConcs]);
MaxDebye = DebyeLength( MinConc, valency );
MinDebye =  DebyeLength( MaxConc, valency );
TotalDebye = MaxDebye + MinDebye;
PercentMaxSelectivity  = PcNernstSelectivity( Voffset_mV, ResConcs , CapConcs);

%Matlab plotting **********************************************************************
hold off;
semilogx(MinDebye,PercentMaxSelectivity , 'or');
hold on;
semilogx(MaxDebye,PercentMaxSelectivity , '+b');
semilogx(TotalDebye,PercentMaxSelectivity , '.g');

[ SelectivityMinDebye ] = YMeans_Error(unique(MinDebye), MinDebye, PercentMaxSelectivity );
[ SelectivityMaxDebye ] = YMeans_Error(unique(MaxDebye), MaxDebye, PercentMaxSelectivity );
[ SelectivityTotalDebye ] = YMeans_Error(unique(TotalDebye), TotalDebye, PercentMaxSelectivity );

errorbar(SelectivityMinDebye(:,1),SelectivityMinDebye(:,2),SelectivityMinDebye(:,3),'sr');
errorbar(SelectivityMaxDebye(:,1),SelectivityMaxDebye(:,2),SelectivityMaxDebye(:,3),'sb');
errorbar(SelectivityTotalDebye(:,1),SelectivityTotalDebye(:,2),SelectivityTotalDebye(:,3),'sg');

% Origin Plotting **********************************************************************
if OP > 0
    ORG = Matlab2OriginPlot();
    if nargin > 2
        %ORG.Figure(PlotName);
        ORG.HoldOff;
    else
        ORG.HoldOff;
    end
    if OP == 1
        ErrorCol = 7;  % 3 for StDev , 7 for std Mean
        %Plot Debye lengths
        ORG.PlotScatterError(SelectivityMinDebye(:,1)',SelectivityMinDebye(:,2)',SelectivityMinDebye(:,ErrorCol)', [PlotName 'MinDebey'],'red');
        ORG.xlabel('Debye Length','nm');
        ORG.ylabel('% Max Selectivity',' ');
        ORG.logXScale;
        ORG.yComment('Min Debeye');
        ORG.HideActiveWkBk()
        ORG.HoldOn;
        ORG.PlotScatterError(SelectivityMaxDebye(:,1)',SelectivityMaxDebye(:,2)',SelectivityMaxDebye(:,ErrorCol)', [PlotName 'MaxDebey'],'green');
        ORG.xlabel('Debye Length','nm');
        ORG.ylabel('% Max Selectivity',' ');
        ORG.yComment('Max Debye');
        ORG.HideActiveWkBk()
        ORG.PlotScatterError(SelectivityTotalDebye(:,1)',SelectivityTotalDebye(:,2)',SelectivityTotalDebye(:,ErrorCol)', [PlotName 'TotalDebeye'],'blue');
        ORG.xlabel('Debye Length','nm');
        ORG.ylabel('% Max Selectivity',' ');
        ORG.yComment('Total Debye');
        ORG.HideActiveWkBk()
        
        %Plot Line fits to all 3
        
        [ P ,Error, Y_Fit, r2] = LineFit( log10(MinDebye) , PercentMaxSelectivity, unique(log10(MinDebye)) );
        ORG.PlotLine(unique(MinDebye), Y_Fit,[PlotName 'FitMinDebye'],'red');
        ORG.xlabel('Debye Length','nm');
        ORG.ylabel('% Max Selectivity',' ');
        ORG.yComment(['Min Fit Grad ' num2str(P(1),3) ' +/-' num2str(Error(1),3) ' r2: ' num2str(r2) ]);
        ORG.HideActiveWkBk()
        
        [ P ,Error, Y_Fit, r2] = LineFit( log10(MaxDebye) , PercentMaxSelectivity, unique(log10(MaxDebye)) );
        ORG.PlotLine(unique(MaxDebye), Y_Fit,[PlotName 'FitMaxDebye'],'red');
        ORG.xlabel('Debye Length','nm');
        ORG.ylabel('% Max Selectivity',' ');
        ORG.yComment(['Max Fit Grad ' num2str(P(1),3) ' +/-' num2str(Error(1),3) ' r2: ' num2str(r2) ]);
        ORG.HideActiveWkBk()
        
        [ P ,Error, Y_Fit, r2] = LineFit( log10(TotalDebye) , PercentMaxSelectivity, unique(log10(TotalDebye)) );
        ORG.PlotLine(unique(TotalDebye), Y_Fit,[PlotName 'FitTotalDebye'],'red');
        ORG.xlabel('Debye Length','nm');
        ORG.ylabel('% Max Selectivity',' ');
        ORG.yComment(['Total Fit Grad ' num2str(P(1),3) ' +/-' num2str(Error(1),3) ' r2: ' num2str(r2) ]);
        ORG.HideActiveWkBk()
        
        ORG.HoldOff;
        
        
    elseif OP == 2
        %Plot against concentrations
        [ SelectivityMinConc ] = YMeans_Error(unique(MinConc), MinConc, PercentMaxSelectivity );
        [ SelectivityMaxConc ] = YMeans_Error(unique(MaxConc), MaxConc, PercentMaxSelectivity );
        %[ SelectivityTotalDebye ] = YMeans_Error(unique(TotalDebye), TotalDebye, PercentMaxSelectivity );
        
        ORG.PlotScatterError(SelectivityMinConc(:,1)',SelectivityMinConc(:,2)',SelectivityMinConc(:,3)', [PlotName 'MinConc'],'green');
        ORG.xlabel('Concentration','M');
        ORG.ylabel('% Max Selectivity',' ');
        ORG.logXScale;
        ORG.yComment('Min Conc');
        ORG.HideActiveWkBk()
        ORG.HoldOn;
        ORG.PlotScatterError(SelectivityMaxConc(:,1)',SelectivityMaxConc(:,2)',SelectivityMaxConc(:,3)', [PlotName 'MaxConc'],'red');
        ORG.xlabel('oncentration','M');
        ORG.ylabel('% Max Selectivity',' ');
        ORG.yComment('Max Conc');
        ORG.HideActiveWkBk()
        
        %No equivlanet to total debye - could plot average
        %         ORG.PlotScatterError(SelectivityTotalDebye(:,1)',SelectivityTotalDebye(:,2)',SelectivityTotalDebye(:,3)', [PlotName 'TotalDebeye'],'blue');
        %         ORG.xlabel('Concentration','M');
        %         ORG.ylabel('% Max Selectivity',' ');
        %         ORG.yComment('Total Debye');
        %         ORG.HideActiveWkBk()
        
        %Plot Line fits to all 3
        
        [ P ,Error, Y_Fit, r2] = LineFit( log10(MinConc) , PercentMaxSelectivity, unique(log10(MinConc)) );
        ORG.PlotLine(unique(MinConc), Y_Fit,[PlotName 'FitMinDebye'],'red');
        ORG.xlabel('Concentration','M');
        ORG.ylabel('% Max Selectivity',' ');
        ORG.yComment(['Min Fit Grad ' num2str(P(1),3) ' +/-' num2str(Error(1),3) ' r2: ' num2str(r2) ]);
        ORG.HideActiveWkBk()
        
        [ P ,Error, Y_Fit, r2] = LineFit( log10(MaxConc) , PercentMaxSelectivity, unique(log10(MaxConc)) );
        ORG.PlotLine(unique(MaxConc), Y_Fit,[PlotName 'FitMaxDebye'],'red');
        ORG.xlabel('Concentration','M');
        ORG.ylabel('% Max Selectivity',' ');
        ORG.yComment(['Max Fit Grad ' num2str(P(1),3) ' +/-' num2str(Error(1),3) ' r2: ' num2str(r2) ]);
        ORG.HideActiveWkBk()
        
        %         [ P ,Error, Y_Fit, r2] = LineFit( log10(TotalDebye) , PercentMaxSelectivity, unique(log10(TotalDebye)) );
        %         ORG.PlotLine(unique(TotalDebye), Y_Fit,[PlotName 'FitTotalDebye'],'red');
        %         ORG.xlabel('Debye Length','nm');
        %         ORG.ylabel('% Max Selectivity',' ');
        %         ORG.yComment(['Total Fit Grad ' num2str(P(1),3) ' +/-' num2str(Error(1),3) ' r2: ' num2str(r2) ]);
        %         ORG.HideActiveWkBk()
        
        ORG.HoldOff;
        
        
    elseif OP == 3
        %Plot against min pH
        MinPH = ConcToPh(MinConc)
        [ SelectivityMinPh ] = YMeans_Error(unique(MinCocc), MinDebye, PercentMaxSelectivity );
        ORG.PlotScatterError(SelectivityMinPh(:,1)',SelectivityMinPh(:,2)',SelectivityMinPh(:,3)', [PlotName 'MinpH'],'red');
        ORG.xlabel('pH',' ');
        ORG.ylabel('% Max Selectivity',' ');
        ORG.logXScale;
        ORG.yComment('Min pH');
        ORG.HideActiveWkBk()
        ORG.HoldOn;
        
    end
    ORG.Disconnect
end
unique(MinConc)
unique(MaxConc)
unique(MinDebye)
%Voffset_mV
unique(ResConcs)
length(Voffset_mV)
end

