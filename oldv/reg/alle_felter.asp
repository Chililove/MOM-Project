<!--#include file="../login/protect.inc"-->

<%

SQL = "SELECT * FROM qryregistrering_sluttid WHERE (oprettetaf = '" & session("login") & "' and sluttid is Null)"
set rs=conn.execute(sql)

do while not rs.eof
id_registrering=rs("id_registrering")
jobbeskrivelse=rs("jobbeskrivelse")
kundenavn=rs("kundenavn")
job_dk=rs("job_dk")
starttid=rs("starttid")
id_registrering=rs("id_registrering")
rs.movenext
loop
%>