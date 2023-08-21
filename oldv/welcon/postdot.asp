<!--#include file="../opendb.asp"-->
<%
id=request("id")
image=request("image")
rowid=left(id,instr(id,"_")-1)
column=replace(mid(id,instr(id,"_")+1),"col","field")
sql="update tblfinish set " & column &"='" & image & "' where id_finish=" & rowid
conn.execute(sql)
%><!--#include file="../closedb.asp"-->
