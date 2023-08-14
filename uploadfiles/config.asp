	
	<%	
	'-----------------------------------------------
	'name of folder (note there is no / at end)
	strFolder = "d:\www4\uploadbilleder\filer" 
	
	'name of folder in http format (note there is no / at end)
	'httpRef = "http://10.0.0.10/uploadny/images" 
	
	'the max size of file which can be uploaded, 0 will give unlimited file size
	lngFileSize = 0
	
	'the files to be excluded (must be in format ".aaa;.bbb")
	'and must be set to blank ("") if none are to be excluded
	strExcludes = ""
	'the files to be included (must be in format ".aaa;.bbb")
	
	'and must be set to blank ("") if none are to be excluded
	'strIncludes = ".gif;.jpg;.jpeg;.doc;docx;.pdf;.txt;.xlsx;.xls"
	strIncludes = ""

	
	'-----------------------------------------------
	%>