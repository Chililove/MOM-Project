<!--#include file="../login/protect.inc"-->
<!--#include file="../opendb.asp"-->
<HTML>
<HEAD>
   <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" >
</HEAD>
	<BODY>
		<% 
		'Data modtaget fra form
			id_login = Trim(request("id_login"))
			fornavn = Trim(request("fornavn"))
			efternavn = Trim(request("efternavn"))
			login = Trim(request("login"))
            mailadresse = Trim(request("mailadresse"))
			password1 = Trim(request("password1"))
			logintype = Trim(request("logintype"))
			id_logintype = Trim(request("id_logintype"))

' Validation pattern init
	Function IsValidInput(str, pattern)
		Dim regEx
		Set regEx = New RegExp
		regEx.Pattern = pattern
		IsValidInput = regEx.Test(str)
		Set regEx = Nothing
	End Function

	' Validate inputs using IsValidInput function
	Dim pattern
	pattern = "^[a-zA-Z0-9åøæÅØÆ@]+$" ' pattern
    

    




	If Not IsValidInput(login, pattern) Or Not IsValidInput(password1, pattern) Or Not IsValidInput(mailadresse, patternEmail)Then
		Response.Write("Ugyldigt input fundet")
        Response.Write("Checking email: " & mailadresse & "<br>")
		Response.End
	End If

' Password hashing
'	Function HashPassword(password)
   ' Dim objCrypt
  '  Set objCrypt = Server.CreateObject("CAPICOM.HashedData")
  '  objCrypt.Algorithm = 4 ' SHA-256
   ' objCrypt.Data = password
  '  HashPassword = objCrypt.Value
  '  Set objCrypt = Nothing
'End Function


	'password1Hashed = HashPassword(password1)

' If creating a new user
If request("action")="opret" Then
    Dim cmdInsert
    Set cmdInsert = Server.CreateObject("ADODB.Command")
	cmdInsert.ActiveConnection = Conn
    cmdInsert.CommandType = 1  'adCmdText
    cmdInsert.CommandText = "INSERT INTO tbllogin (fornavn, efternavn, mailadresse, password1, login, id_logintype) VALUES (?, ?, ?, ?, ?, ?)"

    cmdInsert.Parameters.Append cmdInsert.CreateParameter("@fornavn", 202, 1, 50, fornavn)
    cmdInsert.Parameters.Append cmdInsert.CreateParameter("@efternavn", 202, 1, 50, efternavn)
    cmdInsert.Parameters.Append cmdInsert.CreateParameter("@mailadresse", 202, 1, 30, mailadresse)
    cmdInsert.Parameters.Append cmdInsert.CreateParameter("@password1", 202, 1, 50, password1) 'store hashed password here
    cmdInsert.Parameters.Append cmdInsert.CreateParameter("@login", 202, 1, 50, login)
    cmdInsert.Parameters.Append cmdInsert.CreateParameter("@id_logintype", 3, 1, , id_logintype)

    cmdInsert.Execute()
	response.write cmdInsert.CommandText
    Set cmdInsert = Nothing

    mobilnrcountry = "45" & login
    message = "Login til Onetimer med dit mobilnr. Link: http://mom.main-solution.dk - SMS kan ikke besvares!"
    Set objXMLHTTP = Server.CreateObject("Microsoft.XMLHTTP")
    objXMLHTTP.Open "Get", "http://46.32.62.21:8080/index.php/http_api/send_sms?login=DONGWFM&pass=Poli10et&to=" & mobilnrcountry & "&message=" & Server.URLEncode(message) & "&flash=1", False
    objXMLHTTP.Send

' If updating an existing user
elseif request("action")="ret" then
    Dim cmdUpdate
	Set cmdUpdate = Server.CreateObject("ADODB.Command")
	cmdUpdate.ActiveConnection = Conn
    cmdUpdate.CommandType = 1 'adCmdText
    cmdUpdate.CommandText = "UPDATE tbllogin SET id_logintype = ?, login = ?, fornavn = ?, efternavn = ?, mailadresse = ?, password1 = ? WHERE id_login = ?"

    cmdUpdate.Parameters.Append cmdUpdate.CreateParameter("@id_logintype", 3, 1, , id_logintype)
    cmdUpdate.Parameters.Append cmdUpdate.CreateParameter("@login", 202, 1, 50, login)
    cmdUpdate.Parameters.Append cmdUpdate.CreateParameter("@fornavn", 202, 1, 50, fornavn)
    cmdUpdate.Parameters.Append cmdUpdate.CreateParameter("@efternavn", 202, 1, 50, efternavn)
    cmdUpdate.Parameters.Append cmdUpdate.CreateParameter("@mailadresse", 202, 1, 30, mailadresse)
    cmdUpdate.Parameters.Append cmdUpdate.CreateParameter("@password1", 202, 1, 50, password1Hashed) 'store hashed password
    cmdUpdate.Parameters.Append cmdUpdate.CreateParameter("@id_login", 3, 1, , id_login)

    cmdUpdate.Execute()
    Set cmdUpdate = Nothing
End If
response.redirect "default.asp"
%>

	</BODY>
</HTML>
<!--#include file="../closedb.asp"-->
