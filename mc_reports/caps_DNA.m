%   Post FYR fix the way DNA data is handled. Currently, finidng the
%   correct traces is cumbersome.

%%
%%%%%%%%%%%%%%%%%%%%%%% DNA %%%%%%%%%%%%

DNA_bare = [681, 682]; 
DNA_graphene = [687, 688];

% ProcessTranslocations(GetTraceDetailsByDateNo(120517,24))
% PlotTranslocations
% ProcessTranslocations
%
% GetTraceDetailsByDateNo
% TranslocationsIdentifyPlot
% CapillaryTranslocationAnalysis %Upload code
% RunTranslocationAnalysis % Analysis code
%
% DepthVersusPoreSize %I'm not too sure about this code.
% 
%       TranslocationsIdentifyPlot(GetTraceDetailsByDateNo(120517,24),800,4)
% 
%   Mixed bare:
%       ProcessTranslocations(GetTraceDetailsByDateNo(120517,24))


% PlotTranslocations plots the individual translocation events.
%
% TranslocationsIdentifyPlot  and ProcessTranslocations behave in the same way. 
% The former allows for grouping identification
%
%
% DNA
% 
% 	Upload / Analysis code:
% 		CapillaryTranslocationAnalysis 
% 		RunTranslocationAnalysis
% 	
% 	Plot individual translocations:
% 		
% 		
% 	Plot Translocation summary:
% 		ProcessTranslocations 
% 		TranslocationsIdentifyPlot(trace, voltage, number of groups)
%           %TranslocationsIdentifyPlot(GetTraceDetailsByDateNo( , ), ,)
%
% 	Get Trace Details:
% 		GetTraceDetailsByDateNo(data, file number)
% 	
% 	Unknown:
% 		DepthVersusPoreSize
     
%   BARE:  681: 12 05 17

        % 6     LiCl	4	8.1					
        % 7     LiCl	4	8.1	2.00E+04	5	0		Noise
        % 8     LiCl	4	8.1	2.50E+05	30	0		
        % 9     LiCl	4	8.1	2.50E+05	30	0		600mV control
% Good 10	LiCl	4	8.1	1.50E+05	30	1		600mV
        % 11	LiCl	4	8.1	1.50E+05	30	1		400mV
% Good 12	LiCl	4	8.1	1.50E+05	30	1		200mV
        % 13	LiCl	4	8.1	1.50E+05	30	1		600mV

%   BARE:  682: 12 05 17

        % 15	LiCl	4	8.1	1.50E+05	30	1		
        % 16	LiCl	4	8.1	2.00E+04	5	1		3kbp added 10kbp added
% Not bad, too few events 17	LiCl	4	8.1	1.50E+05	30	1		600mV
        % 18	LiCl	4	8.1	1.50E+05	30	1		600mV
% Very good  19	LiCl	4	8.1	1.50E+05	30	1		600mV
% Weird, ask Micheal/Nik? 20	LiCl	4	8.1	2.00E+04	30	1		600mV
        % 21	LiCl	4	8.1	1.50E+05	30	1		400mV
        % 22	LiCl	4	8.1	1.50E+05	30	1		400mV
        % 23	LiCl	4	8.1	1.50E+05	30	1		200mV
% Best 24	LiCl	4	8.1	1.50E+05	30	1		800mV

%   687: 16 05 17

% 21	LiCl	2	8.1	Breakdown IV	18
% 22	LiCl	2	8.1	Breakdown IV	18
% 23	LiCl	2	8.1	Breakdown IV	18
% 24	LiCl	2	8.1	Breakdown IV	18
% 25	LiCl	2	8.1	Back to Axopatch Breakdown IV	18
% 26	LiCl	2	8.1	Post Boom/V cycle	18
% 29	LiCl	2	8.1		18
% 33	LiCl	2	8.1	0.1nM 3kbp, 0.1nM 10kbp, 400mV	18
% 34	LiCl	2	8.1	0.1nM 3kbp, 0.1nM 10kbp, 400mV	18
% 36	LiCl	2	8.1	0.1nM 3kbp, 0.1nM 10kbp, 400mV	18
% 41	LiCl	2	8.1	3kbp, 6kbp, 10kbp	18
% 42	LiCl	2	8.1	3kbp, 6kbp, 10kbp	18
% 44	LiCl	2	8.1	3kbp, 6kbp, 10kbp	18
% 3	LiCl	2	8.1	2.00E+04	5	0		Noise	
% 18	LiCl	2	8.1					AC	
% 20	LiCl	2	8.1	2.00E+04	1			Breakdown Trace	17
% 27	LiCl	2	8.1					AC	
% 28	LiCl	2	8.1					Noise	
% 30	LiCl	2	8.1	2.50E+05	30	1		0.1nM of 3kbp	
% 31	LiCl	2	8.1	2.50E+05	30	1		0.1nM of 3kbp, 400mV	
% 32	LiCl	2	8.1	2.50E+05	30	1		0.1nM 3kbp, 0.1nM 10kbp, 400mV	
% 35	LiCl	2	8.1	2.50E+05	30	1		0.1nM 3kbp, 0.1nM 10kbp, 400mV and 200mV	
% 37	LiCl	2	8.1	2.50E+05	30	1		0.1nM 3kbp, 0.1nM 10kbp,  200mV	
% 38	LiCl	2	8.1	2.50E+05	30	1		0.1nM 3kbp, 0.1nM 10kbp,  200mV	
% 39	LiCl	2	8.1	2.50E+05	30	1		0.1nM 3kbp, 0.1nM 10kbp,  200mV	
% 40	LiCl	2	8.1	2.50E+05	30	1		3kbp, 6kbp, 10kbp	
% 43	LiCl	2	8.1	2.50E+05	30	1		3kbp, 6kbp, 10kbp	

%   688: 17 05 17

% 73	LiCl	2	8.1	End IV	18
% 74	LiCl	2	8.1	End IV	18
% 37	LiCl	2	8.1	Breakdown IV	18
% 39	LiCl	2	8.1	Breakdown IV	18
% 41	LiCl	2	8.1	Breakdown IV	18
% 42	LiCl	2	8.1	Breakdown IV	18
% 43	LiCl	2	8.1	Breakdown IV	18
% 45	LiCl	2	8.1	Breakdown IV	18
% 46	LiCl	2	8.1	Breakdown IV	18
% 48	LiCl	2	8.1	Breakdown IV	18
% 50	LiCl	2	8.1	Breakdown IV	18
% 51	LiCl	2	8.1	Breakdown IV	18
% 53	LiCl	2	8.1	Breakdown IV	18
% 56	LiCl	2	8.1	Breakdown IV	18
% 57	LiCl	2	8.1	Breakdown IV	18
% 58	LiCl	2	8.1	Breakdown IV	18
% 28	LiCl	2	8.1	2.00E+04	5	0		AC
% 29	LiCl	2	8.1	2.00E+04	10	0		AC
% 30	LiCl	2	8.1	2.00E+04	30	0		AC
% 36	LiCl	2	8.1	2.50E+05	100	0		Breakdown
% 38	LiCl	2	8.1	2.50E+05	100	0		Breakdown
% 40	LiCl	2	8.1	2.50E+05	100	0		Breakdown
% 44	LiCl	2	8.1	2.50E+05	100	0		Breakdown
% 47	LiCl	2	8.1	2.50E+05	100	0		Breakdown
% 49	LiCl	2	8.1	2.50E+05	100	0		Breakdown
% 52	LiCl	2	8.1	2.50E+05	100	0		Breakdown
% 55	LiCl	2	8.1	2.50E+05	100	0		Breakdown
% 59	LiCl	2	8.1	1.50E+05	100	1		1nM of 3kbp, 400mV
% 60	LiCl	2	8.1	1.50E+05	100	1		1nM of 3kbp, 600mV
% 61	LiCl	2	8.1	1.50E+05	100	1		0.1nM of 3kbp, 600mV
% Lots of events 62	LiCl	2	8.1	1.50E+05	100	1		0.05nM of 3kbp, 6kbp, 10kbp
% 63	LiCl	2	8.1	2.50E+05	100	1		0.05nM of 3kbp, 6kbp, 10kbp at 800mV
% 64	LiCl	2	8.1	2.50E+05	100	1		0.05nM of 3kbp, 6kbp, 10kbp at 800mV
        % 65	LiCl	2	8.1	2.50E+05	100	1		0.05nM of 3kbp, 6kbp, 10kbp at 800mV
% 66	LiCl	2	8.1	2.50E+05	100	1		0.05nM of 3kbp, 6kbp, 10kbp at 800mV
% 67	LiCl	2	8.1	2.50E+05	100	1		0.05nM of 3kbp, 6kbp, 10kbp at 600mV
        % 68	LiCl	2	8.1	2.50E+05	100	1		0.05nM of 3kbp, 6kbp, 10kbp at 600mV
% 69	LiCl	2	8.1	2.50E+05	100	1		0.05nM of 3kbp, 6kbp, 10kbp at 600mV
        % 70	LiCl	2	8.1	2.50E+05	100	1		0.05nM of 3kbp, 6kbp, 10kbp at 600mV
        % 72	LiCl	2	8.1	2.50E+05	100	1		0.05nM of 3kbp, 6kbp, 10kbp at 600mV