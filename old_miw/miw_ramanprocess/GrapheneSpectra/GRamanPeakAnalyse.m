function [ Nlayers, SpectraDetails,  Peaks , SpectraMatrix] = GRamanPeakAnalyse( IdentGPeaks , Spectra )
%GRamanPeakAnalyse Summary of this function goes here
%   Process the peak values to process what the graphene is

%What about other peak identification???

%Translate out of the single matrix into vectors for locations scale and
%area
[location] = IdentGPeaks(:,1);
[scale] = IdentGPeaks(:,2);
[area] = IdentGPeaks(:,3);
nPeaks = max(size(location));
Peaks = [0 0 0];
%*************************************************************************
%Logic to identify peaks  - nb need to deal with them not being there!

%Find the 2D Peak  
%find the largest peak in the correct range
[Index2D, Height2D, location2D, scale2D, area2D] = LargestPeakInRange( location, scale, area, 2600, 2770 );
if Index2D > 0
    Found2D = 1;
    Peaks(1,:) = [location2D, scale2D, area2D];
else
    Found2D = 0;
end
%Find the G Peak
[IndexG, HeightG, locationG, scaleG, areaG] = LargestPeakInRange( location, scale, area, 1500, 1700 );
if IndexG > 0
    if scaleG < 100
        FoundG = 1;
        Peaks(2,:) = [locationG, scaleG, areaG];
    else
        FoundG = 0;
    end 
else
    FoundG = 0;
end

%D Peak Find the defect peak   - if it's there
[IndexD, HeightD, locationD, scaleD, areaD] = LargestPeakInRange( location, scale, area, 1320, 1390 );
if IndexD > 0
    if scaleD < 200
        %Only accept the D peak if the scale is small enough  note 50 is
        %quite high
        FoundD = 1;
        Peaks(3,:) = [locationD, scaleD, areaD];
    else
       %Found a peak in region but scale is too big for D peak  - fitted
       %wrong peak
       ScaleD
       FoundD = 0; 
    end
else
    FoundD = 0;
end

%Look for the D+D'' Peak  - it is often visible  2400ish
[IndexD_DPP, HeightD_DPP, locationD_DPP, scaleD_DPP, areaD_DPP] = LargestPeakInRange( location, scale, area, 2400, 2500 );
if IndexD_DPP > 0
    if scaleD_DPP < 200
        %Only accept the D peak if the scale is small enough  note 50 is
        %quite high
        FoundD_DPP = 1;
        Peaks(4,:) = [locationD_DPP, scaleD_DPP, areaD_DPP];
    else
       %Found a peak in region but scale is too big
       %wrong peak
       FoundD_DPP = 0; 
    end
else
    FoundD_DPP = 0;
end
%Also the D' peak and D+D' peak  - these are much less often observed in my
%samples - but ideally would deal with

%*************************************************************************
%Logic using the identified peaks to calculate no of layers etc
if(Found2D && FoundG)
    G2DRatio = Height2D /  HeightG;
    if(G2DRatio < 0.5)
        layers = 1;
    elseif (G2DRatio < 1.2)
        layers = 2;
    elseif (G2DRatio > 1.2)
        layers = 3;
    end
elseif(Found2D)
    %Have found 2D peak but not the GPeak  - so assume monolayer
    layers = 1;
    G2DRatio = 1 / Height2D;
else
    layers = 0;
    G2DRatio = 0;
end
%*************************************************************************
%Start to write out N layers and the identified peaks
%Set N layers
Nlayers = layers;

% Copy only the relevant fitted peaks into this variable  - note need to
% think about all the possible graphene and graphite peaks.
%Note could also re fit the peaks!!!!  - to make sure fitting the right
%area!
%Peaks = [location, scale, area];

%*************************************************************************
%Translate into the spectra details the details of the identified peaks
%2D Peak
SpectraDetails{1,1} = 'Location of 2D';  
SpectraDetails{1,2} = location2D;
SpectraDetails{2,1} = 'Scale of 2D';   %%  Note spectra details is things like the peak ratios and peak positions etc
SpectraDetails{2,2} = scale2D;
SpectraDetails{3,1} = 'Area of 2D';   
SpectraDetails{3,2} = area2D;
SpectraDetails{4,1} = 'Height of 2D';   
SpectraDetails{4,2} =  Height2D;
%G Peak
SpectraDetails{5,1} = 'Location of G';   
SpectraDetails{5,2} = locationG;
SpectraDetails{6,1} = 'Scale of G';   
SpectraDetails{6,2} = scaleG;
SpectraDetails{7,1} = 'Area of G';   
SpectraDetails{7,2} = areaG;
SpectraDetails{8,1} = 'Height of G';   
SpectraDetails{8,2} = HeightG;
%D Peak
SpectraDetails{9,1} = 'Location of D';  
SpectraDetails{9,2} = locationD;
SpectraDetails{10,1} = 'Scale of D';   
SpectraDetails{10,2} = scaleD;
SpectraDetails{11,1} = 'Area of D';   
SpectraDetails{11,2} = areaD;
SpectraDetails{12,1} = 'Height of D';   
SpectraDetails{12,2} = HeightD;
%D+D''
SpectraDetails{13,1} = 'Location of D+Dpp';   
SpectraDetails{13,2} = locationD_DPP;
SpectraDetails{14,1} = 'Scale of D+Dpp';  
SpectraDetails{14,2} = scaleD_DPP;
SpectraDetails{15,1} = 'Area of D+Dpp';   
SpectraDetails{15,2} = areaD_DPP;
SpectraDetails{16,1} = 'Height of D+Dpp';   
SpectraDetails{16,2} = HeightD_DPP;
%D'
SpectraDetails{17,1} = 'Location of Dp';   
SpectraDetails{17,2} = 0;
SpectraDetails{18,1} = 'Scale of Dp';  
SpectraDetails{18,2} = 0;
SpectraDetails{19,1} = 'Area of Dp';   
SpectraDetails{19,2} = 0;
SpectraDetails{20,1} = 'Height of Dp'; 
SpectraDetails{20,2} = 0;
%D+D'
SpectraDetails{21,1} = 'Location of D+Dp';   
SpectraDetails{21,2} = 0;
SpectraDetails{22,1} = 'Scale of D+Dp';   
SpectraDetails{22,2} = 0;
SpectraDetails{23,1} = 'Area of D+Dp';  
SpectraDetails{23,2} = 0;
SpectraDetails{24,1} = 'Height of D+Dp';
SpectraDetails{24,2} = 0;

% Now the ratios-------------------------------------------------
SpectraDetails{25,1} = 'Ratio of G to 2D'; 
SpectraDetails{25,2} = G2DRatio;

if FoundG && FoundD
    GtoDRatio = HeightD/HeightG;
else
    GtoDRatio = 0;
end
SpectraDetails{26,1} = 'Scale of D to G';
SpectraDetails{26,2} = GtoDRatio;
if Found2D && FoundD
    D2DRatio = Height2D/HeightD;
else
    D2DRatio = 0;
end
SpectraDetails{27,1} = 'Ratio of D to 2D';
SpectraDetails{27,2} = D2DRatio;
SpectraDetails{28,1} = 'No Layers';   
SpectraDetails{28,2} = Nlayers;

% Record the date of analysis as analysis changes-------------------------

[Y, M, D, ~, ~, ~] = datevec(floor(now));
SpectraDetails{29,1} = 'Date of Analysis';
FormatDate = M * 100 + (D * 10000) + (Y - 2000);
SpectraDetails{29,2} = FormatDate;

%Create in Matrix form also for the multi file system so it can run over
%many files!
%Note any extra added must be appended so as not to mess up exisiting data
%analysis eg in the excel file.
SpectraMatrix = [location2D scale2D area2D Height2D; locationG scaleG areaG HeightG; locationD scaleD areaD HeightD; G2DRatio GtoDRatio D2DRatio Nlayers; FormatDate 0 0 0; locationD_DPP scaleD_DPP areaD_DPP HeightD_DPP];


end

