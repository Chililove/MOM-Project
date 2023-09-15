<!--#include file="../login/protect.inc"-->
<!--#include file="../opendb.asp"-->
<HTML>
<HEAD>
   <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" >
</HEAD>
	<BODY>
		<% 
		'Data modtaget fra form
			id_login = request("id_login")
fornavn = request("fornavn")
efternavn = request("efternavn")
login = request("login")
password1 = request("password1")
logintype = request("logintype")
id_logintype = request("id_logintype")

' If creating a new user
If request("action")="opret" Then
    Dim cmdInsert
    Set cmdInsert = Server.CreateObject("ADODB.Command")
	cmdInsert.ActiveConnection = Conn
    cmdInsert.CommandType = 1  'adCmdText
    cmdInsert.CommandText = "INSERT INTO tbllogin (fornavn, efternavn, password1, login, id_logintype) VALUES (?, ?, ?, ?, ?)"

    cmdInsert.Parameters.Append cmdInsert.CreateParameter("@fornavn", 202, 1, 50, fornavn)
    cmdInsert.Parameters.Append cmdInsert.CreateParameter("@efternavn", 202, 1, 50, efternavn)
    cmdInsert.Parameters.Append cmdInsert.CreateParameter("@password1", 202, 1, 50, password1)
    cmdInsert.Parameters.Append cmdInsert.CreateParameter("@login", 202, 1, 50, login)
    cmdInsert.Parameters.Append cmdInsert.CreateParameter("@id_logintype", 3, 1, , id_logintype)

    cmdInsert.Execute()
	response.write cmdInsert.CommandText
    Set cmdInsert = Nothing

    mobilnrcountry = "45" & login
    message = "Login til Onetimer med dit mobilnr og password:" & password1 & " Link: http://mom.main-solution.dk - SMS kan ikke besvares!"
    Set objXMLHTTP = Server.CreateObject("Microsoft.XMLHTTP")
    objXMLHTTP.Open "Get", "http://46.32.62.21:8080/index.php/http_api/send_sms?login=DONGWFM&pass=Poli10et&to=" & mobilnrcountry & "&message=" & message & "&flash=1", False
    objXMLHTTP.Send

' If updating an existing user
elseif request("action")="ret" then
    Dim cmdUpdate
	Set cmdUpdate = Server.CreateObject("ADODB.Command")
	cmdUpdate.ActiveConnection = Conn
    cmdUpdate.CommandType = 1 'adCmdText
    cmdUpdate.CommandText = "UPDATE tbllogin SET id_logintype = ?, login = ?, fornavn = ?, efternavn = ?, password1 = ? WHERE id_login = ?"

    cmdUpdate.Parameters.Append cmdUpdate.CreateParameter("@id_logintype", 3, 1, , id_logintype)
    cmdUpdate.Parameters.Append cmdUpdate.CreateParameter("@login", 202, 1, 50, login)
    cmdUpdate.Parameters.Append cmdUpdate.CreateParameter("@fornavn", 202, 1, 50, fornavn)
    cmdUpdate.Parameters.Append cmdUpdate.CreateParameter("@efternavn", 202, 1, 50, efternavn)
    cmdUpdate.Parameters.Append cmdUpdate.CreateParameter("@password1", 202, 1, 50, password1)
    cmdUpdate.Parameters.Append cmdUpdate.CreateParameter("@id_login", 3, 1, , id_login)

    cmdUpdate.Execute()
    Set cmdUpdate = Nothing
End If
response.redirect "default.asp"
%>
	</BODY>
</HTML>
<!--#include file="../closedb.asp"-->