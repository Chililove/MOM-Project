<!--#include file="../login/protect.inc"-->
<!--#include file="../opendb.asp"-->
<%
id_agenda = session("id_agenda")
%>
<body>
    <div style="display:flex; justify-content:center; align-items: center;">
        <a href="../default.asp"><button>Tilbage til forsiden?</button></a>
        <a href="agendapoint_form.asp?id=<%=id_agenda%>"><button>Tilføj Agenda Punkter</button></a>
    </div>


    <%
    sql="SELECT participants FROM tbl_agenda WHERE id_agenda = "& id_agenda &""
    'response.write sql
    set rs = conn.execute(sql)

    logins = rs("participants")
    Dim selectedUsers
		selectedUsers = Split(logins, ",")
		Response.Write "Responsible Users: "
			For Each user In selectedUsers
				sql="SELECT * FROM tbllogin WHERE id_login = "& user &" "
				set rs = conn.execute(sql)
				Response.Write rs("login") & ", "
			Next
				' Re
    %>
</body>
<!--#include file="../closedb.asp"-->