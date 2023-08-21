<!--#include file="../opendb.asp"-->
<%
id=request("id")
sql="select * from combo2 where subcatgroup='" & id & "'"

set rs=conn.execute(sql)
output=""
do while not rs.eof
	output=output & rs("text") & ","
	rs.movenext
loop
if len(output) > 0 then
	output=left(output,len(output)-1)
end if
response.write(output)
%><!--#include file="../closedb.asp"-->
