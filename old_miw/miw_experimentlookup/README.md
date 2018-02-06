# README #

This code provides a MATLAB interface to the ExptsDB by invoking the Java library and parsing into MATLAB objects.

### What is this repository for? ###

Loading, Retrieving and Updating values in the experiments Database. It also handles type conversions between Java and MATLAB

### How do I get set up? ###

* Clone this repository
* You need the Jar for the ExptsDB from the downloads section of this repository

* You also need a number of other Jars which should be placed in a folder DBExpts_lib. These are:
    
    * The Jar for the SQLjdbc. Probably sqljdbc4.jar depending on the Java you are running. Goto [microsoft to download this](https://msdn.microsoft.com/en-us/library/mt683464.aspx).
    
    * It also requires the [simple JSON jar](https://code.google.com/archive/p/json-simple/downloads
)

* These Jars are required for the file download and upload - See instructions here : [Azure storage SDK](https://github.com/Azure/azure-storage-java)

    * Jackson Core - [Jackson Core](https://github.com/FasterXML/jackson-core)

    * Logging Facade - [SLF4J](http://www.slf4j.org/download.html)

* You then need some of the Jars on the MATLAB path - instructions below. Only the Mail DBExptsJar and jdbc jar must be on the classpath.


**Setting up the Classpath for the JDBC Driver and other Jars**

* You need the jar to access the data base to be availible to [MATLAB](http://uk.mathworks.com/help/matlab/matlab_external/bringing-java-classes-and-methods-into-matlab-workspace.html)

* There is a ["quirk" in MATLAB](http://uk.mathworks.com/help/database/ug/sqlite-jdbc-windows.html#bt8j_5c
) that means database access Jars must be on the Static path. They will not work if just loaded on to the dynamic path.

```
#!MATLAB

In brief:

1. Run the prefdir command in the Command Window. The output is a file path to a folder on your computer.

2. Close MATLAB if it is running.

3. Navigate to the folder and create a file called javaclasspath.txt in the folder.

4. Open javaclasspath.txt. Add the full path to the database driver JAR file in javaclasspath.txt. The full path includes the path to the folder where you downloaded the JAR file from the database provider and the JAR file name. For example, C:\DB_Drivers\sqlite-jdbc-3.7.2.jar. Save and close javaclasspath.txt.

```

The contents of the file will be something like this:

```
#!matlab
C:\<path>\DBExptsJar.jar
C:\<path\DBExptsJar_lib\json-simple-1.1.1.jar
C:\<path>\DBExptsJar_lib\sqljdbc4.jar
```


5. Restart MATLAB.

* Note the JDBC jar must be on the static path directly. If cannot be loaded from within another Jar.

* You must also add the Jar for the simple JSON library

* You can check the static path with

```
#!MATLAB

javaclasspath('-static')
```
* In theory you may be able to run the Expts DB file from the Dynamic Path providing the JDBC Jar is on the static path. In practise put all on the static path.

**Setting up the ExptsDB_settings.json file**

* The ExptsDB_settings.json file needs to completed with the correct username, password ( hostame and database may not be required). 

* Rename the file provided and edit the username and password fields. The other fields should be deleted. The file should look like this:

```
#!json
{
    "Username": "<YOUR USERNAME>",
    "Password": "<YOUR PASSWORD>",
}

```


* The file should be placed next to the JAR for use with the console interface.

* But for use in MATLAB the settings file must be placed on the MATLAB path

**Set up FileRoots**

* Rename the FileRoots_template.m file to FileRoots.m 

* Edit it so the paths point to the appropriate locations. Which should be separate to the code.

### Setting up file download ###

You need to add an extra parameter to the ExptsDB_settings.json file 

```
#!json
{
    "Username": "<YOUR USERNAME>",
    "Password": "<YOUR PASSWORD>",
    "CacheLocation": "C:/",
}

```
You also need to ensure the FileRoots.m file has a variable

```
#!MATLAB

AllowCloudDownload = 1;
```


### Contribution guidelines ###



### Who do I talk to? ###

* Repo owner or admin
* Other community or team contact