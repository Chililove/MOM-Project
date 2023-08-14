<!--#include file="../opendb.asp"-->
<%
id=request("id")
comment=request("comment")
rowid=left(id,instr(id,"_")-1)
column=replace(mid(id,instr(id,"_")+1),"col","field")
column=column & "_note"
sql="update tblfinish set " & column &"='" & comment & "' where id_finish=" & rowid
conn.execute(sql)
%><!--#include file="../closedb.asp"-->
