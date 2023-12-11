<!--#include file="../login/protect.inc"-->
<!--#include file="../opendb.asp"-->
<% if LEN(request.QueryString("id_agenda"))>0 then %>
<% id_agenda = request.QueryString("id_agenda")%>
<% else %>
<% id_agenda = session("id_agenda")%>
<% end if %>

<!DOCTYPE>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" >
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="../jquery/jquery.mobile-1.4.5.css">
<script src="../jquery/jquery-1.8.2.min.js"></script>
<script src="../jquery/jquery.mobile-1.4.5.min.js"></script>
</head>
<style>
a {
  text-decoration: none;
  margin-right: 1%;
  margin-bottom: 1%;
  margin-top: 2%;
}
</style>
<body>
    <div data-role="header" data-id="header" data-position="fixed">
        <h1>Do you want to add agenda points to this meeting?</h1>
        <a class="ui-btn-left" href="../default.asp" data-ajax="false" data-icon="home">
            Home
        </a>
    </div>
    
    <div style="display:flex; justify-content:center; align-items: center;">
        <a href="../default.asp"><button>Save agenda and go back to default homepage</button></a>
        <a href="../default.asp"><button>Go back to agenda?</button></a>
        <a href="agendapoint_page.asp?id=<%=id_agenda%>&action=newpoint" data-ajax="false"><button>Add agendapoints to this meeting</button></a>
    </div>

<ul data-role="listview" data-inset="false">
        <h3>Existing agenda points in this meeting agenda</h3>      

    <li data-role="list-divider">
        <table style="width: 100%">
            <tr style="text-align: left">
                <th style="width: 25%">Point</th>
                <th style="width: 25%">Date</th>
                <th style="width: 25%">Assigned</th>
            </tr>
        </table>
    </li>
    <%
    ' Initialize and execute your database query
    SQL = "SELECT * FROM tbl_agendapoints WHERE id_agenda = " & id_agenda & " "
    ' Set rs = Server.CreateObject("ADODB.Recordset")
    ' rs.Open SQL, conn
    'response.write sql
    Set rs = Conn.Execute(SQL)

    ' Check if the recordset is not empty before entering the loop
    If Not rs.EOF Then
        ' Recordset is not empty, enter the loop
        Do While Not rs.EOF
    %>
    <li>
        <a data-ajax="false" href='save_agendapoints.asp?action=edit&amp;id_agendapoint=<%=rs("id_agendapoint")%>'>

            <table style="width: 100%">  
                <tr>
                    <td style="width: 25%"><%=rs("point_name")%></td>
                    <td style="width: 25%"><%=rs("dato")%></td>
                </tr>
            </table>
        </a>
    </li>
    <%
            rs.MoveNext
        Loop
    Else
        ' Recordset is empty, display a message to the user
    %>
    <li>
        <span>No data</span>
    </li>
    <%
    End If

    ' Close the recordset
    rs.Close
    Set rs = Nothing
    %>
    <!--#include file="../shared/footer.asp"-->
</ul>

    <%
    'sql="SELECT participants FROM tbl_agenda WHERE id_agenda = "& id_agenda &""
    'response.write sql
    'set rs = conn.execute(sql)

    'logins = rs("participants")
   ' Dim selectedUsers
		'selectedUsers = Split(logins, ",")
		'Response.Write "Responsible Users: "
		'	For Each user In selectedUsers
		'		sql="SELECT * FROM tbllogin WHERE id_login = "& user &" "
		'		set rs = conn.execute(sql)
		'		Response.Write rs("login") & ", "
		'	Next
        '    Session("selectedUsers") = assignedUsers
				' Re
    %>
</body>

<!--#include file="../closedb.asp"-->
</html>