<!--#include file="../opendb.asp"-->
<%
id=request("id")
info=request("info")

sql="update tblfinish set info='" & info & "' where id_finish=" & id

conn.execute(sql)
%><!--#include file="../closedb.asp"-->
