<!--#include file="../opendb.asp"-->

<%

If Request.Form("Action") = "Login" Then
' COmment: make a function for replace to call with all kinds of characters to move on submit to db.
	'login = replaceglyf(reques.form("login"))

	login=(request.form("login"))
	password1=(request.form("password"))
	login = (Trim(Replace(Request.Form("login"),"'","")))
	login = (Trim(Replace(Request.Form("login"),"<","")))
	login = (Trim(Replace(Request.Form("login"),"%","")))
	login = (Trim(Replace(Request.Form("login"),">","")))
	password1 = (Trim(Replace(Request.Form("password"),"'","")))
	

		If Len(login) > 0 And Len(password1) > 0 Then
			SQL2 = "SELECT * FROM tbllogin WHERE (login = '" & login & "') AND (password1 = '" & password1 & "') and (id_logintype=1 or id_logintype=2)"
			Set rs = conn.Execute(SQL2)
				
			If Not (rs.BOF Or rs.EOF) Then
				login_id = rs("id_login")
				login = rs("login")
				logintype_id =rs("id_logintype")
				company_id =rs("id_company")

Response.Write("Session company_id at login: " & Session("id_company"))


				if  logintype_id=1 then
					session("administrator")=true 'company logintype
				else
					session("administrator")=false
				end if

			Else
				s =1 
				strERR = "Forkert brugernavn eller password!!"
			End If

			If Len(login_id) Then
			'set session
				Session("id_login") = login_id
				Session("login") = login
				Session("id_logintype") = logintype_id
				Session("id_company") = company_id
				Response.Write("Session company_id 2: " & Session("id_company"))

				Response.Redirect "../default.asp"
				
			End If

		Else
				s =1 
				strErr = "Brugernavn og adgangskode skal begge angives!"
		End If
End If

If Request.Form("Action") = "Lost Password" Then
        Response.Redirect "login_glemt.asp"
		End If 


' if * then
' ---
' else
' ---
' end if



' if * then
' ---
' end if




' if * Then
' ---
' else if * then
' ---
' else if * then
' ---
' else if * then
' ---
' else 
' ---
' end if 
' end if 
' end if 
' end if

%>

<!--#include file="../closedb.asp"-->