function [ output_args ] = ProcessedGRamanSpectraSave( Spectra, FileDetails, FileName, PathName, SpectraDetails, RawSpectra)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here

%Save the processed Graphene Raman Spectra - ideally into a format which
%matches a script in origin to plot it

%Either use "save" or use file handling and write to file directly
%need to put in all the spectrometer details and 

% Cannot just use save as want to export cell array of data points
% disp(FileDetails);
% //disp(class(FileDetails));
% save([PathName 'Process_' FileName],'FileDetails','Spectra','SpectraDetails','-ascii')

%Instead need to write to file manually - need to slightly altername  - or
%use the same name but a different path!

if exist([PathName '/Analysis']) == 0
   mkdir(PathName,'Analysis') 
end
fid = fopen([PathName '/Analysis/' FileName],'w');

n = max(size(Spectra));
n_raw = max(size(RawSpectra));
k = size(FileDetails,1);
[j nn] = (size(SpectraDetails));
%Write the column headings
fprintf(fid,'Wavenumber, Raw Data , Baseline Subtracted, Baseline , Fine Filter , Thresholded \r\n');
fprintf(fid,'cm-1, counts, counts, counts, counts, counts\r\n');
%Write the file details which go into the first column so they can be read
%by the origin script - keep in same format
for i = 1:k
fprintf(fid,'%s\r\n', FileDetails{i,:});
end

%Want to write the spectrum analysis in - some where!
% %fprintf(fid, ',');
%  for i = 1:j
%         fprintf(fid,'%s: %s\r\n', SpectraDetails{i,1}, SpectraDetails{i,2});
%  end

%Now write the spectra in  - note would like to write the Raw spectrum in
for i = 1:j
   fprintf(fid, '%d,%d,%d,%d,%d,%d,%d,%d,%d,%s,%d', Spectra(i,:), RawSpectra(i,:), SpectraDetails{i,1},SpectraDetails{i,2}); 
   fprintf(fid, '\r\n');
end
for i = j+1:n
   fprintf(fid, '%d,%d,%d,%d,%d,%d,%d,%d,%d', Spectra(i,:), RawSpectra(i,:)); 
   fprintf(fid, '\r\n');
end
for i = n+1:n_raw
    %Now write the remaining raw data values into the file.
   fprintf(fid, ' , , , , , , ,%d,%d', RawSpectra(i,:)); 
   fprintf(fid, '\r\n');
end
fclose(fid);


end

