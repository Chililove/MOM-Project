'*********************************************
'DB rutine
'
'af Henrik Frølund, Main Solution ApS 2016
'
'*********************************************

myConnString2 = "DSN=siemens;UID=rwsiemens;PWD=2mat1;Database=siemens"

Set myConnection = CreateObject("ADODB.Connection")
myConnection.Open myConnString2

mySQL= "SELECT * FROM qryposition "

set objRS = myConnection.Execute(mySQL)


while not objRS.EOF
  WScript.Echo objRS("description") 
 objRS.movenext
Wend

set fs=nothing

objRS.Close
myConnection.Close
Set objRS= Nothing
Set myConnection = Nothing
'******************afslutning af database connection