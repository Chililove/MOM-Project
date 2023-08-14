<!--#include file="../opendb.asp"-->
<%
'on error resume next
' User clicked "Login"
If Request.Form("Action") = "Login" Then

'*******************Write log to database*********************    

login=(request.form("login"))
password1=(request.form("password"))
ipadresse=Request.ServerVariables("REMOTE_ADDR")

SQL1= "INSERT INTO tblLogning (login,ipadresse) VALUES ('"&login&"','"&ipadresse&"')"
conn.Execute SQL1

'******************Close Write log to database


' Validate and replace word in string
login = (Trim(Replace(Request.Form("login"),"'","")))
password1 = (Trim(Replace(Request.Form("password"),"'","")))

	If Len(login) > 0 And Len(password1) > 0 Then

	' Building SQL string
	SQL2 = "SELECT * FROM tbllogin WHERE (login = '" & login & "') AND (password1 = '" & password1 & "') and (id_logintype=1 or id_logintype=2)"

			Set rs = conn.Execute(SQL2)
			If Not (rs.BOF Or rs.EOF) Then
		
				' Hvis brugeren fandtes i databasen
				login_id = rs("id_login")
				login = rs("login")
				if  rs("id_logintype")=1 then
					session("administrator")=true
				else
					session("administrator")=false
				end if
			Else
			' No user in the database
			
			s =1 
			strERR = "Forkert brugernavn eller password!!"
			End If


			If Len(login_id) Then
			'set session
				Session("login_id") = login_id'
				Session("login") = login
							
				Response.Redirect "../default.asp"
			End If
	Else
			' No username or password
			s =1 
			strErr = "B�de brugernavn og adgangskode skal angives!"
	End If

End If




%>
<!--#include file="../closedb.asp"-->