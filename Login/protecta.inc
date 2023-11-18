
<%
if session("id_login") <> true or session("administrator") <> true then
	Response.Redirect ("http://mom.main-solution.dk/login/login.asp")
End If
login = session("login")
admin = session("administrator")
id_company = session("id_company")
Response.Write("Session protecta company_id: " & Session("id_company"))


%>

