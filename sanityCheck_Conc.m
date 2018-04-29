function [answer] = sanityCheck_Conc(CapIDs)

capConc = [];
capID = [];

for CapID = CapIDs
        [Expts_0, No_0] = LoadExperiments( CapID, 1, [0 16] );
        capConc = [ capConc, Expts_0(1).getCapillaryConc()];
        capID = [capID, CapID];
end

capID = capID';
capConc = capConc';

answer = [capID, capConc];

end


%cecl3_all = [571, 740, 567, 642, 679, 680, 696, 697, 741, 743, 746, 568, 570, 678, 569, 742, 744, 641, 698, 699, 745, 750, 758, 759, 760, 761, 762, 763, 764, 765, 749, 751, 752, 756, 757, 747, 748];