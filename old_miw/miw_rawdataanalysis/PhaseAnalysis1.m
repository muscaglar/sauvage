%Sample Analysis Script  - test full analysis code
%Just put the fns together and work out the best way to do this
%But might want to make it a function so it can be run over all the fodlers
%for a day's experiments and then give and output.

%Load Data   - %Note either of these can return all the path name etc -
%whcih may be required for future saving.
%d = LoadTDMSData([3 4])
e = ConcatentateRawData([3 4]);


%Filter Data
[ data ] = LowPassFilter( e,   100 );
%Find Phases
[ phase, frequency ] = CalcPhase( data(:,1), data(:,2), 20000);

%Find phases for the data broken up
[FittedPhase, Phase , PhaseHistogram, TimePeriod ] = PhaseAnalysis( data, 2000, 20000 );
%Fitted phase has the key phase value in.