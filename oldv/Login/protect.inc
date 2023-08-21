<%
if len(session("login")) < 1  then
	Response.Redirect ("http://mom.main-solution.dk/login/login.asp")
End If
login = session("login")
%>

