function [x,y,z,aCaps] = vOffsetVsrCap(CapIDs, plot)

%Plot VOffset against the cCap for ONE cReservoir

y = [];
x = [];
z = [];
aCaps = [];

fuxy = [];
fxxx = []; 
fyyy = []; 
fuz = [];
fcColour = [];

r1 = rand(1000,1);
r2 = rand(1000,1);
r3 = rand(1000,1);

if plot == 1
ORG = Matlab2OriginPlot();
end

for CapID = CapIDs
    [VoltageGradient, CurrentGradient, VOffset, IOffset, ResConcs,CapConcs, VoltageOffsets, CurrentOffsets, No, allCaps ] = SeeNonSelectivity(CapID);    
    y = [y, ResConcs];
    x = [x, CapConcs];
    z = [z, VoltageOffsets];
    aCaps = [aCaps, allCaps];
    close all;
end
xy2 = x ./ y;
xy2 = log10(xy2);

xy = y ./ x; % This is the relative concentration
xy = log10(xy);

xx = log10(x); %if cap conc is 4M -> 0.6
yy = log10(y); %if conc is 0.001M -> -3

% cap: 0.001    res: 0.001, 4M
% xy  : 1, 4000        0 -> 3.69
% xy2 : 1, 0.00025     0 -> -3.69

% cap: 4M     res: 0.001, 4M
% xy  : 0.00025, 1
% xy2 : 4000, 1

uResConcs = unique(y);
figure(1);
figure(2);
figure(3);

for u = uResConcs
   
   iRes = (u == y);
   ux = x(iRes);
   xxx = xx(iRes);
   yyy = yy(iRes);
   uy = y(iRes);
   uz = z(iRes);
   uxy = xy(iRes);
   uxy2 = xy2(iRes);
   
   cColour = aCaps(iRes);
   colours = zeros(size(cColour,2),3);
   i=1;

   for col = cColour
       colours(i,1) = r1(col);
       colours(i,2) = r2(col);
       colours(i,3) = r3(col);
       i = i + 1;
   end
   
   pointsize = 40;
   
    figure(1);
    scatter(uxy,uz,pointsize,colours);
    hold on;

    figure(2);
    scatter(xxx,uz,pointsize,colours);
    hold on;
    
    figure(3);
    scatter(yyy, uz,pointsize,colours);
    hold on;
   %fName = strcat(num2str(u));
   %print(fig,fName,'-dpng');
if(plot == 1)   
   t = 0:0.1:2*pi;

    M2O.PlotLine(t,sin(t),'Plot 1', 'red' );
    M2O.HideActiveWkBk;

    M2O.HoldOn;

    %Create a new layer on the plot  - with x linked
    M2O.NewLayer(1,0);

    M2O.PlotLine(t,cos(t),'Plot 1' , 'blue' );
    M2O.HideActiveWkBk;
   
    fuxy = [fuxy, uxy];
    fxxx = [fxxx, xxx]; 
    fyyy = [fyyy, yyy]; 
    fuz = [fuz, uz];
    fcColour = [fcColour, cColour];
end
end

   if(plot == 1)
    %Plot in Origin
    
    PlotName = '1' ;
    %Plot the points for offset
    ORG.Figure([PlotName]);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ORG.Need to set scaling to 0
    ORG.HoldOn;
    %ORG.PlotColumn(newCapConcs,newSelectivities(1,:),PlotName,'Pink');
    %ORG.ExecuteLabTalk('set %C -vg 80' ); %Sets the gap between columns
        ORG.PlotScatter(fuxy, fuz,'None', ORG.ColourPicker());
        ORG.HideActiveWkBk()
        
%     ORG.Figure('2');    
%     ORG.PlotScatter(fxxx, fuz,'None', ORG.ColourPicker());
%     ORG.HideActiveWkBk()
%     ORG.Figure('3');
%         ORG.PlotScatter(fyyy, fuz,'None', ORG.ColourPicker());
%     ORG.HideActiveWkBk()

        ORG.Figure('4');
        ORG.PlotScatter(fcColour, fcColour,'None', ORG.ColourPicker());
    ORG.HideActiveWkBk() 
    ORG.Disconnect;
   else
   end
   
end
