function [GrapheneRatio,g_np] = HistogramPermRatio(Caps)

DB = DBConnection;
DBC = DBConnection;

C = Capillaries(DBC);
E = Experiments(DB);

C.SELECT;

BareRatio = [];
GrapheneRatio = [];
NafionRatio = [];
hBNRatio = [];
AllowableSuppressionCodes = [0 16];

g_np = [];

%Caps = 1;
%while Caps
for i = 1:length(Caps)
    cID = Caps(i);
    %%[Expts_0] = LoadExperiments( cID, 1, AllowableSuppressionCodes );
    %Find the IV codes related to the 
    disp(['Capillary: ' num2str(cID) '. '])
    E.SELECT(['Capillary = ' num2str(cID) ' AND Suppressed = 0 AND Sealed > 0']);
    IVs = 1; 
    while IVs  
        %Now add the data to the correct entry
        r = E.getResPh;
        c = E.getCapPh;
        N = E.getnPerm;
        P = E.getpPerm;
        Ratio = P/N;
       % if r ~= c && E.getid~= 71
%             if r > c
%                 Ratio = P/N;
%             else
%                 Ratio = N/P;
%                 %Ratio = P/N;
%             end
            disp(['   Experiment: ' num2str(E.getid) '.  use'])
            diameter = GetCapSize('C');%char(C.getType));
            switch char(C.getExptType)
                case 'Bare'
                    BareRatio = [BareRatio ; Ratio r diameter];
                case 'G31'
                    GrapheneRatio = [GrapheneRatio ; Ratio r diameter];
                case 'Nafion'
                    NafionRatio = [NafionRatio ; Ratio r diameter];
                case 'hBN'
                    hBNRatio = [hBNRatio ; Ratio r diameter];
                otherwise
                    GrapheneRatio = [GrapheneRatio ; Ratio r diameter];
            end
            g_np = [g_np; N,P];
      %  else
       %     disp(['   Experiment: ' num2str(E.getid) '.  DO NOT USE'])
      %  end
        IVs = E.NextResult;
    end
    
   % Caps = C.NextResult;
end
C.CloseConnection();
E.CloseConnection();
%Now convert into histogram
Range = [-13 14];
edges = logspace(-13,14,100);
edgeLables = linspace(-13,14,100)';

%n = histc(NafionRatio(:,1),edges);
g = histc(GrapheneRatio(:,1),edges);
%b = histc(BareRatio(:,1),edges);
%h = histc(hBNRatio(:,1),edges);

%Now need to normalise Results  - Make to sum to on
%N = n/sum(n);
G = g/sum(g);
%B = b/sum(b);
%H = h/sum(h);

%Now plot Histograms of Ratios  - on the same scale and on ideal scales
figure(1);hold off;
Data = G';
%Data = [N' G' B' H'];
%bar(Data);
subplot(1,2,1)
%bar(G,'r')
logXHistogram(GrapheneRatio(:,1),100,'r',Range);
%subplot(4,2,3)
%bar(N,'b')
% logXHistogram(NafionRatio(:,1),100,'r',Range);
% subplot(4,2,5)
% %bar(B,'k')
% logXHistogram(BareRatio(:,1),100,'k',Range);
% subplot(4,2,7)
% %bar(H,'c')
% logXHistogram(hBNRatio(:,1),100,'c',Range);

% Now plot 
subplot(1,2,2); hold off;
%bar(logspace(-2,2,40),histc(GrapheneRatio(:,1),logspace(-2,2,40) ),'r');
%set(gca, 'Xscale', 'log');
logXHistogram(GrapheneRatio(:,1),60,'r');
% subplot(4,2,4)
% logXHistogram(NafionRatio(:,1),100,'b');
% subplot(4,2,6)
% logXHistogram(BareRatio(:,1),50,'k');
% subplot(4,2,8)
% logXHistogram(hBNRatio(:,1),20,'c');

%PLot the cumulative gradients.
figure(2); hold off;
%Nc = cumsum(N);
Gc = cumsum(G);
%Bc = cumsum(B);
%Hc = cumsum(H);
%plot(edgeLables,Nc,'b')
hold all;
plot(edgeLables ,Gc,'r');
%plot(edgeLables ,Bc,'k');
%plot(edgeLables ,Hc,'c');

%Plot with pH
 figure(3)
 subplot(1,2,1); hold off;
logXHistogram(g_np(:,1),50,'r');
% loglog(g_np(:,1),g_np(:,2),'.b'); hold on;
% semilogy(GrapheneRatio(:,2),GrapheneRatio(:,1),'or'); hold on
% semilogy(BareRatio(:,2),BareRatio(:,1),'+k');
% semilogy(hBNRatio(:,2),hBNRatio(:,1),'.c');

%Plot with size
subplot(1,2,2); hold off;
logXHistogram(g_np(:,2),50,'r');
%loglog(g_np(:,2),g_np(:,1),'.b');hold on
%loglog(GrapheneRatio(:,3),GrapheneRatio(:,1),'or');hold on
%loglog(BareRatio(:,3),BareRatio(:,1),'+k');
%loglog(hBNRatio(:,3),hBNRatio(:,1),'.c');

end