%Enter the Excel file or spectra that I have already created into the database.
%Note can run over multiple times as InsertChecks for already existing and
%will then just update

%load the Excel file
%num = xlsread(filename,sheet);
[num, text, alldata]  = xlsread('C:\Users\miw24\Documents\PhD\Temp\GRamaSummary230215.xlsm','All Spectra as Graphene');
n = max(size(num));
%Note need to have set up all the membranes prior to this with the correct
%names...

%for each Row - in the main worksheet
for x = 1:n
    date = num(x,3);
    No = num(x,4);
    MembraneName = text(x,2);
    PeakInfo = [num(x,5:16) num(x,25:28)];  %note the inset code will ensure no NANs
    Ratios = num(x, 17:20);
    %IF reading from Excel membrane number is unknown so insert 0.
    InsertSpectraToDB( date, No,0, MembraneName, PeakInfo, Ratios );
end