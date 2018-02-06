%Load Jar for DBExpts

%C:\Users\miw24\Documents\EclipseWorkspace\ExptsDB
%This will put the Jar on the dynamic path - but it may need to be on the
%static path - see info http://undocumentedmatlab.com/blog/static-java-classpath-hacks
% Also had to put the SQLite Jar
% C:\Users\miw24\Documents\EclipseWorkspace\Jars\sqlite-jdbc-3.8.7.jar
% nb use winopen(prefdir) to find the preference directory
%See notes from 6/10/15 for mor info

%To add to dynamic path
%javaaddpath(fullfile('C:\Users\miw24\Documents\EclipseWorkspace\ExptsDB','DBExptsJar.jar'))
javaaddpath(fullfile('/Users/Mus/Documents/MATLAB/miw_experimentlookup/DBExptsJar.jar'));
javaaddpath(fullfile('/Users/Mus/Documents/MATLAB/miw_experimentlookup/DBExptsJar.jar'));
javaaddpath(fullfile('/Users/Mus/Documents/MATLAB/miw_experimentlookup/DBExptsJar_lib/json-simple-1.1.1.jar'));
javaaddpath(fullfile('/Users/Mus/Documents/MATLAB/miw_experimentlookup/DBExptsJar_lib/slf4j-api-1.7.21.jar'));
javaaddpath(fullfile('/Users/Mus/Documents/MATLAB/miw_experimentlookup/DBExptsJar_lib/sqljdbc.jar'));
javaaddpath(fullfile('/Users/Mus/Documents/MATLAB/miw_experimentlookup/DBExptsJar_lib/sqljdbc4.jar'));