
function [ Matrix ] = getNameValueMatrix( Name )
%GETNAMEVALUEMATRIX Summary of this function goes here
%   Detailed explanation goes here

DB = DBConnection();
NV = AnalysisValues(DB);
%Name = 'ResistanceAwayIncrease';
NV.SELECT(['Name LIKE ''' Name ''' ']);

Matrix = [];

isNext = 1;
i = 1;
if NV.getid > 0
    while isNext
        Matrix = [Matrix; NV.getValue NV.getnvCapillary];
        isNext = NV.NextResult();
        i = i+1;
    end
else
    %
    disp(['NO Results for this Analysis Value Name: ' Name]);
    Matrix = [];
end


end

