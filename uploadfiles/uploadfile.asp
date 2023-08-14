<!-- #include file="upload.asp" -->
<%

on error resume next

Dim strFolder, bolUpload, strMessage
Dim httpref, lngFileSize
Dim strIncludes, strExcludes
Dim newfilename, filnavn

%>
<!-- #include file = "config.asp" -->	
<%

	
	
	
' Create the FileUploader
Dim Uploader, File
Set Uploader = New FileUploader

' This starts the upload process
Uploader.Upload()



'******************************************
' Use [FileUploader object].Form to access 
' additional form variables submitted with
' the file upload(s). (used below)
'******************************************

' Check if any files were uploaded
If Uploader.Files.Count = 0 Then
	response.write "Fejl i upload"
Else


	' Loop through the uploaded files
	For Each File In Uploader.Files.Items		

		bolUpload = false		

		'Response.Write lngMaxSize
		'Response.End 

		if lngFileSize = 0 then
			bolUpload = true
		else		
			if File.FileSize > lngFileSize then
				bolUpload = false
				strMessage = "File too large"
			else
				bolUpload = true
			end if
		end if

		if bolUpload = true then				
		    'Check to see if file extensions are excluded
		    If strExcludes <> "" Then
				If ValidFileExtension(File.FileName, strExcludes) Then
		            strMessage = "It is not allowed to upload a file containing a [." & GetFileExtension(File.FileName) & "] extension"
					bolUpload = false
				End If
			End If
			'Check to see if file extensions are included
			If strIncludes <> "" Then
				If InValidFileExtension(File.FileName, strIncludes) Then
					strMessage = "It is not allowed to upload a file containing a [." & GetFileExtension(File.FileName) & "] extension"
					bolUpload = false
				End If
			End If			
		end if

		if bolUpload = true then
		
newfilename= Uploader.form("id_ref") & "-" & Uploader.form("nr") & "-" & file.filename
localfilename=file.filename

		  File.SaveToDisk strFolder,newfilename ' Save the file
           
  			strMessage =  "File Uploaded: " & File.FileName
			strMessage = strMessage & "Size: " & File.FileSize & " bytes<br>"
			strMessage = strMessage & "Type: " & File.ContentType & "<br><br>"			
	
'*******************skriv til databasen   hvis fil er ok  
 	
myConnString = Application("ncr_ConnectionString")
Set myConnection = Server.CreateObject("ADODB.Connection")
myConnection.Open myConnString

filnavn = localfilename
'response.write localfilename	
mySQL= "INSERT INTO tbluploadbilleder "
mySQL= mySQL & "(placering,id_ref, bruger,dato,nr,filnavn)"
mySQL= mySQL & "VALUES ('" & uploader.form("placering") & "','" & uploader.form("id_ref") & "','" & uploader.form("bruger") & "','"& uploader.form("dato") & "','" & uploader.form("nr") & "','" & filnavn & "')"


myConnection.Execute mySQL
response.write mySQL
myConnection.Close

Set myConnection = Nothing
'******************afslutning af database connection

	end if
	
	Next

End If

if err.number <> 0 then
response.write err.description
else
response.redirect "uploadform.asp"
end if

'--------------------------------------------
' ValidFileExtension()
' You give a list of file extensions that are allowed to be uploaded.
' Purpose:  Checks if the file extension is allowed
' Inputs:   strFileName -- the filename
'           strFileExtension -- the fileextensions not allowed
' Returns:  boolean
' Gives False if the file extension is NOT allowed
'--------------------------------------------
Function ValidFileExtension(strFileName, strFileExtensions)

    Dim arrExtension
    Dim strFileExtension
    Dim i
    
    strFileExtension = UCase(GetFileExtension(strFileName))
    
    arrExtension = Split(UCase(strFileExtensions), ";")
    
    For i = 0 To UBound(arrExtension)
        
        'Check to see if a "dot" exists
        If Left(arrExtension(i), 1) = "." Then
            arrExtension(i) = Replace(arrExtension(i), ".", vbNullString)
        End If
        
        'Check to see if FileExtension is allowed
        If arrExtension(i) = strFileExtension Then
            ValidFileExtension = True
            Exit Function
        End If
        
    Next
    
    ValidFileExtension = False

End Function

'--------------------------------------------
' InValidFileExtension()
' You give a list of file extensions that are not allowed.
' Purpose:  Checks if the file extension is not allowed
' Inputs:   strFileName -- the filename
'           strFileExtension -- the fileextensions that are allowed
' Returns:  boolean
' Gives False if the file extension is NOT allowed
'--------------------------------------------
Function InValidFileExtension(strFileName, strFileExtensions)

    Dim arrExtension
    Dim strFileExtension
    Dim i
        
    strFileExtension = UCase(GetFileExtension(strFileName))
    
    'Response.Write "filename : " & strFileName & "<br>"
    'Response.Write "file extension : " & strFileExtension & "<br>"    
    'Response.Write strFileExtensions & "<br>"
    'Response.End 
    
    arrExtension = Split(UCase(strFileExtensions), ";")
    
    For i = 0 To UBound(arrExtension)
        
        'Check to see if a "dot" exists
        If Left(arrExtension(i), 1) = "." Then
            arrExtension(i) = Replace(arrExtension(i), ".", vbNullString)
        End If
        
        'Check to see if FileExtension is not allowed
        If arrExtension(i) = strFileExtension Then
            InValidFileExtension = False
            Exit Function
        End If
        
    Next
    
    InValidFileExtension = True

End Function

'--------------------------------------------
' GetFileExtension()
' Purpose:  Returns the extension of a filename
' Inputs:   strFileName     -- string containing the filename
'           varContent      -- variant containing the filedata
' Outputs:  a string containing the fileextension
'--------------------------------------------
Function GetFileExtension(strFileName)
    GetFileExtension = Mid(strFileName, InStrRev(strFileName, ".") + 1)   
End Function



'response.write strMessage

if err.number <> 0 then
response.write err.description
end if
%>