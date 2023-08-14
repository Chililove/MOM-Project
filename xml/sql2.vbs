Set XMLDoc = createObject("MSXML2.DOMDocument")

XMLDoc.async = False
'XMLDoc.setProperty "ServerHTTPRequest", true


myConnString = "DSN=siemens;UID=rwsiemens;PWD=2mat1;Database=siemens"

'myConnString = "Driver={SQL Server};Server=local;Database=Siemens;PWD=2mat1;Database=siemens"


Set myConnection = CreateObject("ADODB.Connection")
myConnection.Open myConnString

mySQL= "SELECT * FROM tblGPSguid where active=1"
set objRS = myConnection.Execute(mySQL)


while not objRS.EOF
		WScript.Echo objRS("description") 
		

'filname1="http://mom.main-solution.dk/xml/"& objRS("description")
'filname1="http://mom.main-solution.dk/xml/test.xml"

'filname1="https://api.findmespot.com/spot-main-web/consumer/rest-api/2.0/public/feed/" & objrs("guid")& "/latest.xml"
WScript.Echo filname1

filname1="http://api.findmespot.com/spot-main-web/consumer/rest-api/2.0/public/feed/0po6ZUYDLqV5GOLEp2RXQeVDfTyHyToa8/latest.xml"

				IF XMLDoc.Load(filname1) THEN
				  	Set node = xmlDoc.SelectNodes("/response/feedMessageResponse/messages/message/id")
				  	GPSid = node(0).Text   
					WScript.Echo GPSid
				  	Set node = xmlDoc.SelectNodes("/response/feedMessageResponse/messages/message/latitude")
				  	lat = node(0).Text   
					WScript.Echo lat 
				  	Set node = xmlDoc.SelectNodes("/response/feedMessageResponse/messages/message/longitude")
				  	lng = node(0).Text   
					

				mySQL1= "INSERT INTO tblposition (GPSid,lat,lng,typeid) values ("& GPSid &", '"& lat &"','"& lng &"',1) "
				myConnection.Execute(mySQL1)


				ELSE
				
				  Set XMLError = XMLDoc.ParseError
				  WScript.Echo "&#xa0;&#xa0;" & XMLError.ErrorCode & " - " & XMLError.Reason & "  URL=" & XMLError.URL
				
				END IF

objRS.movenext

Wend

set fs=nothing

objRS.Close
myConnection.Close
Set objRS= Nothing
Set myConnection = Nothing




