function [ output_args ] = InsertIVAnalysis( id,Voffset , Ioffset , Resistance , LowRes , HighRes , nPerm , pPerm , PermOffset   )
%UNTITLED Updates the IV analyss for experiments already in the DB -
%doesn't insert if not already there - ie relys on an existing entry -
%analysis cannot run without an entry as need to have ph Values for
%analysis
DB = DBConnection;
E = Experiments(DB);
E.Initialise();
E.SELECT(id);
if(max(size(char(E.getComment()))) < 1)
    E.setComment(' ');
end
E.setVoffset( Voffset);
E.setIoffset(Ioffset);
E.setResistance(Resistance);
E.setLowRes(LowRes);
E.setHighRes(HighRes );
E.setnPerm(nPerm );
E.setpPerm(pPerm);
E.setPermOffset(PermOffset);
%E.setAnalysisDate(DBDate.now());

E.UPDATE();

 

end

