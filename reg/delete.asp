<!--#include file="../login/protect.inc"-->
<!--#include file="../opendb.asp"-->

<%

if request.querystring("action")="mtype" then

    if LEN(request.querystring("id"))>0 then 
        id = request.querystring("id")

        sql = "DELETE FROM tblmeeting_type WHERE id_meetingtype = "& id &""
        response.write sql
        set rs = conn.execute(sql)
        response.redirect "../reg_list/meetingtype_list.asp"

        
    else
        response.redirect "./error.asp?action=mtype"
    end if


else if request.querystring("action")="aptype" then


    if LEN(request.querystring("id"))>0 then 
        id = request.querystring("id")

        sql = "DELETE FROM tbl_agendapoints WHERE id_agendapoint = "& id &""
        response.write sql
        set rs = conn.execute(sql)
        response.redirect "./nextstep_agenda_dropdown_page.asp"

        
    else
        response.redirect "./error.asp?action=aptype"
    end if


else if request.querystring("action")="dtype" then
    if LEN(request.querystring("id"))>0 then 
        id = request.querystring("id")

        sql = "DELETE FROM tbl_afdeling_2nd WHERE id_afdeling = "& id &""
        response.write sql
        set rs = conn.execute(sql)
        response.redirect "../reg_list/afdeling_list.asp"

        
    else
        response.redirect "./error.asp?action=dtype"
    end if
    else if request.querystring("action")="metype" then
    if LEN(request.querystring("id"))>0 then 
        id = request.querystring("id")

        sql = "DELETE FROM tbl_agenda WHERE id_agenda = "& id &""
        response.write sql
        set rs = conn.execute(sql)
        response.redirect "../reg_list/my_meetings.asp"

        
    else
        response.redirect "./error.asp?action=astype"
    end if
     else if request.querystring("action")="astype" then
    if LEN(request.querystring("id"))>0 then 
        id = request.querystring("id")

        sql = "DELETE FROM tbl_agenda WHERE id_agenda = "& id &""
        response.write sql
        set rs = conn.execute(sql)
        response.redirect "../reg_list/saved_meetings.asp"

        
    else
        response.redirect "./error.asp?action=astype"
    end if
    end if
    end if
end if
end if
end if


%>
<!--#include file="../closedb.asp"-->