<!--#include file="../login/protect.inc"-->
<!--#include file="../opendb.asp"-->
<HTML>
<HEAD>
   <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" >
    
</HEAD>
	<BODY>
        <script> 
        function confirmDelete(id_login) {
            var r = confirm("Are you sure you want to delete this user?");
            if (r == true) {
                var form = document.createElement("form");
                form.setAttribute("method", "post");
                form.setAttribute("action", "/bruger/save.asp");

                var hiddenIdField = document.createElement("input");
                hiddenIdField.setAttribute("type", "hidden");
                hiddenIdField.setAttribute("name", "id_login");
                hiddenIdField.setAttribute("value", id_login);
                form.appendChild(hiddenIdField);

                var hiddenActionField = document.createElement("input");
                hiddenActionField.setAttribute("type", "hidden");
                hiddenActionField.setAttribute("name", "action");
                hiddenActionField.setAttribute("value", "delete");
                form.appendChild(hiddenActionField);

                document.body.appendChild(form);
                form.submit();
            }
        }</script>
      <!--  this is what i am working on -->
    
    <% 

	id_login = Trim(request("id_login"))
		fornavn = Trim(request("fornavn"))
		efternavn = Trim(request("efternavn"))
		login = Trim(request("login"))
        mailadresse = Trim(request("mailadresse"))
		password1 = Trim(request("password1"))
		logintype = Trim(request("logintype"))
		id_logintype = Trim(request("id_logintype"))

 If request("action") = "delete" Then
    ' Get the id_user value from the request
    		'id_login = request("id_login")
    ' Use a transaction to ensure data integrity

    dim id_login
    
    Conn.BeginTrans

    On Error Resume Next
    
    ' Remove any associated user assignments from tblassign_users_to_agenda
    sql = "DELETE FROM tblassign_users_to_agenda WHERE id_login = ?"
    Set cmd = Server.CreateObject("ADODB.Command")
    cmd.ActiveConnection = Conn
    cmd.CommandText = sql
    cmd.Parameters.Append cmd.CreateParameter("@id_login", 3, 1, , id_login)
    cmd.Execute
    Set cmd = Nothing

    ' Now, delete the main record from tbllogin
    sql = "DELETE FROM tbllogin WHERE id_login = ?"
    Set cmd = Server.CreateObject("ADODB.Command")
    cmd.ActiveConnection = Conn
    cmd.CommandText = sql
    cmd.Parameters.Append cmd.CreateParameter("@id_login", 3, 1, , id_login)
    cmd.Execute
    Set cmd = Nothing

    ' Check for errors
    If Err.Number <> 0 Then
        Conn.RollbackTrans
        Response.write "error: " & Err.Description
    Else
        Conn.CommitTrans
       ' Response.write "success"

    End If

   ' Response.End

End If
   response.redirect "default.asp"

    ' Data modtaget fra form
	
'Response.Write("ID Login: " & id_login & "<br>")
'Response.Write("Login: " & login & "<br>")
'Response.Write("Password1: " & password1 & "<br>")
'Response.Write("Mailadresse: " & mailadresse & "<br>")

    ' Validation pattern init
	Function IsValidInput(str, pattern)
		Dim regEx
		Set regEx = New RegExp
		regEx.Pattern = pattern
		IsValidInput = regEx.Test(str)
		Set regEx = Nothing
	End Function

	' Validate inputs using IsValidInput function
	Dim pattern, patternEmail
	pattern = "^[a-zA-Z0-9åøæÅØÆ@]+$" ' pattern
    patternEmail = "^[a-zA-Z0-9._%+-]+@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,}$"

	If Not IsValidInput(login, pattern) Or Not IsValidInput(password1, pattern) Or Not IsValidInput(mailadresse, patternEmail)Then
    If Not IsValidInput(login, pattern) Then
    Response.Write("Invalid login")

ElseIf Not IsValidInput(password1, pattern) Then
    Response.Write("Invalid password")
 
ElseIf Not IsValidInput(mailadresse, patternEmail) Then
    Response.Write("Invalid email")

End If
		'Response.Write("Ugyldigt input fundet")
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
    cmdUpdate.Parameters.Append cmdUpdate.CreateParameter("@password1", 202, 1, 50, password1) 'store hashed password
    cmdUpdate.Parameters.Append cmdUpdate.CreateParameter("@id_login", 3, 1, , id_login)

    cmdUpdate.Execute()
    Set cmdUpdate = Nothing
End If
response.redirect "default.asp"

%>
<%
'DELETE'

'If request("action") = "delete" Then
    ' Get the id_user value from the request
    		'id_login = request("id_login")
    ' Use a transaction to ensure data integrity
 '   Conn.BeginTrans
    
    ' Remove any associated user assignments from tbl_assign_users_to_agenda
  '  sql = "DELETE FROM tbl_assign_users_to_agenda WHERE id_login = ?"
   ' Set cmd = Server.CreateObject("ADODB.Command")
    'cmd.ActiveConnection = Conn
    'cmd.CommandText = sql
    'cmd.Parameters.Append cmd.CreateParameter("@id_login", 3, 1, , id_login)
    'cmd.Execute
    'Set cmd = Nothing

    ' Now, delete the main record from tbllogin
    'sql = "DELETE FROM tbllogin WHERE id_login = ?"
    'Set cmd = Server.CreateObject("ADODB.Command")
    'cmd.ActiveConnection = Conn
    'cmd.CommandText = sql
    'cmd.Parameters.Append cmd.CreateParameter("@id_login", 3, 1, , id_login)
    'cmd.Execute
    'Set cmd = Nothing

    ' Check for errors
    'If Err.Number <> 0 Then
     '   Conn.RollbackTrans
      '  Response.write "error: " & Err.Description
    'Else
     '   Conn.CommitTrans
      '  Response.write "success"
    'End If

    'Response.End
'End If

%>


	</BODY>
</HTML>
<!--#include file="../closedb.asp"-->
