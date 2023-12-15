<!--#include file="../login/protect.inc"-->
<!--#include file="../opendb.asp"-->



<% if request.querystring("action")="mtype" then %>
   <div style="display:flex; justify-content:center; align-items:center;">
   <h2>FEJL på sletning af meeting type
   </h2>
   </div>

<%  Response.Write "<script type='text/javascript'>"
    Response.Write "setTimeout(function() { window.location.href = '../reg_list/meetingtype_list.asp'; }, 3000);"
    Response.Write "</script>" %>
<% else if request.querystring("action")="aptype" then %>
   <div style="display:flex; justify-content:center; align-items:center;">
   <h2>FEJL på sletning af agendapoint 
   </h2>
   </div>
<% else if request.querystring("action")="dtype" then %>
    <div style="display:flex; justify-content:center; align-items:center;">
    <h2>FEJL på sletning af department
    </h2>
    </div>
<% end if
end if
end if
%>

<!--#include file="../closedb.asp"-->