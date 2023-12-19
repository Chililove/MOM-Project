<!--#include file="../login/protect.inc"-->
<%
SQL = "SELECT * FROM qrylogin WHERE (id_login = " & request("id_login") & ")"
set rs=conn.execute(sql)
do while not rs.eof
	id_login=rs("id_login")
	login=rs("login")
	fornavn=rs("fornavn")
	efternavn=rs("efternavn")
	password1=rs("password1")
	mailadresse=rs("mailadresse")
	id_logintype=rs("id_logintype")
	logintype=rs("logintype")
	id_company=rs("id_company")
	company_name=rs("company_name")
rs.movenext
loop
%>