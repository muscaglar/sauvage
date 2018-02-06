function [rValue, rStringValue, rid] = UpdateNameValue(Expt, Trace, Capillary, Spectra, Name, Value, StringValue )
% Get and/or Update a Name value pair - NB only one of Expt, Trace, Capillary, Spectra
%  can be non Zero
% Name must have a value
% Will only update if value arguments are present - otherwise will just
%  return the values - this means only one function is required for all
%  operations!

DB = DBConnection;
NV = AnalysisValues(DB);

SearchString = ['Name LIKE ''' Name ''' AND'];
if Expt ~= 0 && Trace == 0  && Capillary == 0 && Spectra == 0
    SearchString = [SearchString ' Expt = ''' num2str(Expt) ''' '];
elseif Expt == 0 && Trace ~= 0  && Capillary == 0 && Spectra == 0
    SearchString = [SearchString ' Trace = ''' num2str(Trace) ''' '];
elseif Expt == 0 && Trace == 0  && Capillary ~= 0 && Spectra == 0
    SearchString = [SearchString ' nvCapillary = ''' num2str(Capillary) ''' '];
elseif Expt == 0 && Trace == 0  && Capillary == 0 && Spectra ~= 0
    SearchString = [SearchString ' Spectra = ''' num2str(Spectra) ''' '];
else
    error('Need to define one of Expt, Trace, Capillary, spectra');
end


NV.SELECT(SearchString);
NV.CloseConnection();
if nargin > 5
    %If new values have been passed in then update
    if ~isnan(Value)
        NV.setValue(Value);
        if nargin > 6
            NV.setStringValue(StringValue);
        else
            NV.setStringValue(' ');
        end
        d = DBSupportCode.DBDateTime;
        d.now();
        NV.setUpdateDate(d);
        %Either update or add as new values
        if(NV.getid() > 0)
            NV.UPDATE();
        else
            NV.setName(Name)
            NV.setExpt(Expt);
            NV.setTrace(Trace);
            NV.setnvCapillary(Capillary);
            NV.setSpectra(Spectra)
            
            NV.INSERT;
        end
    else
        warning('Value is NAN');
    end
elseif (NV.getid() == 0)
    %warning('No Name Value pair or you have not added Data');
end

rValue = NV.getValue();
rStringValue = NV.getStringValue();
rid = NV.getid();

end
