<!--#include file="../opendb.asp"-->
<%
sql="select * from tbllogin where  login='"&session("login")&"' "
set rs=conn.execute(sql)
do while not rs.eof
	session("id_stilling")=lcase(rs("id_stilling"))	
	rs.movenext
loop
%><!--#include file="../closedb.asp"-->
