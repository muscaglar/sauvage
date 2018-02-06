function [ output_args ] = AddElectrodeValues( )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

Cid = 1;
while(Cid >0)
    Cid = inputdlg('Enter the Capillary ID ID (0 to quit)');
    Cid  = str2double(Cid {1,1});

    if(Cid > 0)
        ElectrodeSolution = inputdlg(['Enter the value for Solution: ' num2str(Cid)]);
        Concentration = inputdlg(['Enter the value for Concentration: ' num2str(Cid)]);
        ElectrodeConc  = str2double(Concentration {1,1});
        [ rValue, rStringValue, rid ] = UpdateNameValueCapillary( Cid, 'ElectrodeSolution', ElectrodeConc, ElectrodeSolution );
        
    end
end


end

