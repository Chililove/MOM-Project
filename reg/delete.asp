<!--#include file="../login/protect.inc"-->
<!--#include file="../opendb.asp"-->

<%
if LEN(request.querystring("id"))>0 then 
    id = request.querystring("id")

    sql = "DELETE FROM tbl_agendapoints WHERE id_agendapoint = "& id &""
    response.write sql
    set rs = conn.execute(sql)
    response.redirect "../"

    
else
    response.redirect "../reg/nextstep_agenda_dropdown_page.asp"
end if

%>
<!--#include file="../closedb.asp"-->