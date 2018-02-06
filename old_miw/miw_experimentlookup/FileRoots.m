AllowCloudDownload = 1;
AllowCloudUpload = 1; %Translocations are uploade

if ispc
    SpectraRoot = 'C:\Users\mc934\Dropbox\PhD\Experimental\Raman';
    DataRoot = 'C:\Users\mc934\Desktop';
    DataRootHDD = 'E:\PhDData1\Data';
    ExperimentOutputRoot = 'C:\Users\mc934\Dropbox\PhD\Experimental';
    TranslocationRoot = 'C:\Users\mc934\Dropbox\PhD\MATLAB\translocation_data';
else
	SpectraRoot = '/Users/Mus/Dropbox/PhD/MATLAB/cache/spectra';%'C:\Users\miw24\Documents\PhDData\Spectra';
    DataRoot = '/Users/Mus/Dropbox/PhD/MATLAB/cache/spectra';%C:\Users\miw24\Documents\PhDData\Data';
    DataRootHDD = '/Users/Mus/Dropbox/PhD/MATLAB/cache/spectra';
    ExperimentOutputRoot = '/Users/Mus/Dropbox';
    TranslocationRoot = '/Users/Mus/Dropbox/PhD/MATLAB/translocation_data';
end