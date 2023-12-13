<!--#include file="../login/protect.inc"-->
<!--#include file="../opendb.asp"-->
<HTML>
<HEAD>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</HEAD>
<BODY>

<% If request("action") = "edit" Then %>
<% id_agendapoint=request.querystring("id_agendapoint") %>
<% else %>
<% id_agendapoint=request("id_agendapoint") %>
<% end if %>
<%
'save to registration
'*******************skriv til databasen     
'response.write "Action: " & request("action") & "<br/>"
'response.write "ID Agendapoint: " & request("id_agendapoint") & "<br/>"
'response.write "ID company: " & request("id_company") & "<br/>"


'existing_id_registrering=request("existing_id_registrering")
'oprettetaf=request("oprettetaf")
point_name=request("point_name")
short_desc=request("short_desc")
long_desc=request("long_desc")
id_agenda=request("id_agenda")
logins=request("id_login")
dato=request("date")
id_company = Session("id_company")
'id_agenda = request("id_agenda")
'Response.Write "agenda id =" & id_agenda
aar=datepart("yyyy",oprettetdato)
maaned=datepart("m",oprettetdato)
dag=datepart("d",oprettetdato)
oprettetdato=aar & "-" & maaned & "-" & dag

aar=datepart("yyyy",now())
maaned=datepart("m",now())
dag=datepart("d",now())
timer1=datepart("h",now())
minutter=datepart("n",now())

starttid=aar & "-" & maaned & "-" & dag &" "& timer1 &":"& minutter
sluttid=aar & "-" & maaned & "-" & dag &" "& timer1 &":"& minutter

'Set rs = Server.CreateObject("ADODB.Command")
'rs.ActiveConnection = Conn
'id_company = Session("id_company")
'Response.Write("Session save2company_id: " & Session("id_company"))

If request("action") = "newpoint" Then
    sql1 = "INSERT INTO tbl_agendapoints (point_name, short_desc, long_desc, id_agenda, id_login, dato, id_company) "
    sql2 = "VALUES ('"& point_name &"', '"& short_desc &"', '"& long_desc &"', "& id_agenda &", '"& logins &"', '"& dato & "', "& id_company &")"
    ' sql2 = "VALUES (?, ?, ?, ?, ?, ?, ?)"
    sql = sql1 & sql2
    
    '     rs.CommandText = sql
    '     rs.Parameters.Append rs.CreateParameter("@point_name", 202, 1, 255, point_name)
    '     rs.Parameters.Append rs.CreateParameter("@short_desc", 202, 1, 255, short_desc)
    ' 	rs.Parameters.Append rs.CreateParameter("@long_desc", 203, 1, -1, long_desc)
    ' 	rs.Parameters.Append rs.CreateParameter("@id_agenda", 3, 1, , id_agenda)
    ' 	rs.Parameters.Append rs.CreateParameter("@id_login", 3, 1, , id_login)
    '     rs.Parameters.Append rs.CreateParameter("@dato", 7, 1, , dato)
    '     rs.Parameters.Append rs.CreateParameter("@id_company", 3, 1, , id_company)

    ' ' Set the parameter values
    ' rs.Parameters("@point_name").Value = point_name
    ' rs.Parameters("@short_desc").Value = short_desc
    ' rs.Parameters("@long_desc").Value = long_desc
    ' rs.Parameters("@id_agenda").Value = id_agenda
    ' rs.Parameters("@id_login").Value = id_login
    ' rs.Parameters("@dato").Value = dato
    ' rs.Parameters("@id_company").Value = id_company

        sql = sql1 + sql2
        response.write sql
        set rs = Conn.Execute(sql)
        'Response.Write("Session savec33ompany_id: " & Session("id_company"))

        '  Set rs = Conn.Execute("SELECT @@IDENTITY AS new_id_agendapoint")
        ' new_id_agendapoint = rs(0).Value
        ' selectedLogins = Split(Request.Form("id_login"), ",")
        ' For Each id_login In selectedLogins
        '     sql = "INSERT INTO tblassign_agendapoints (id_agendapoint, id_login) VALUES (?, ?); SELECT SCOPE_IDENTITY();"

        '  Set rs = Server.CreateObject("ADODB.Command")
        ' rs.ActiveConnection = Conn
        ' 	rs.CommandText = sql
        ' 	rs.Parameters.Append rs.CreateParameter("@id_agendapoint", 3, 1, , new_id_agendapoint)
        ' 	rs.Parameters.Append rs.CreateParameter("@id_login", 3, 1, , CInt(id_login))
        '     rs.Parameters("@id_agendapoint").Value = id_agendapoint
        '     rs.Parameters("@id_login").Value = id_login

        ' 	rs.Execute
        ' Next
    'Response.Write("Session savecompany_id: " & Session("id_company"))
    'response.redirect "reusableform.asp?id_agenda=" & id_agenda
    response.redirect "nextstep.asp?id_agenda=" & id_agenda


        'response.redirect "../default.asp"
end if	

if request("action")="show" then

    Dim rs, cmd, assignedEmployees, id_agendapoint, checkboxState
    Set assignedEmployees = CreateObject("Scripting.Dictionary")

    ' Preparing the SQL command
    Set cmd = CreateObject("ADODB.Command")
    cmd.ActiveConnection = Conn
    cmd.CommandText = "SELECT * FROM tbl_agendapoints WHERE id_agendapoint=?"
    cmd.Parameters.Append cmd.CreateParameter("@id_agendapoint", 3, 1, , id_agendapoint) ' 3 is adInteger

    ' Execute the command
    Set rs = cmd.Execute

    If Not rs.EOF Then

        point_name = rs("point_name")
        short_desc = rs("short_desc")
        long_desc = rs("long_desc")
        id_agenda = rs("id_agenda")
        logins = rs("id_login")
        dato = rs("dato")
        id_company = rs("id_company")
        


    else
        response.write "no data"
        'response.redirect "../default.asp"
    end if
end if
	
If request("action") = "edit" Then
    ' Define the update statement with parameters
    sql = "UPDATE tbl_agendapoints SET " & _
        "point_name = ?, " & _
        "short_desc = ?, " & _
        "long_desc = ?, " & _
        "dato = ?, " & _
        "id_login = ?, " & _
        "id_agenda = ?, " & _
        "id_company = ? " & _
        "WHERE id_agendapoint = ?"
    
    ' Create a command object and set its properties
    Set cmd = Server.CreateObject("ADODB.Command")
    Set cmd.ActiveConnection = Conn
    cmd.CommandText = sql
    cmd.CommandType = 1 ' adCmdText
    ' i'm adding parameters to the command object
    cmd.Parameters.Append cmd.CreateParameter("@point_name", 202, 1, 255, point_name)
    cmd.Parameters.Append cmd.CreateParameter("@short_desc", 202, 1, 255, short_desc)
	cmd.Parameters.Append cmd.CreateParameter("@long_desc", 202, 1, -1, long_desc)
	cmd.Parameters.Append cmd.CreateParameter("@id_agenda", 3, 1, , id_agenda)
	cmd.Parameters.Append cmd.CreateParameter("@id_login", 3, 1, , id_login)
    cmd.Parameters.Append cmd.CreateParameter("@dato", 7, 1, , dato)
    cmd.Parameters.Append cmd.CreateParameter("@id_company", 3, 1, , id_company)
    cmd.Parameters.Append cmd.CreateParameter("@id_agendapoint", 3, 1, , id_agendapoint)
    
    ' Execute the command
    cmd.Execute

    ' Releasing command object
    Set cmd = Nothing

    
	'this redirect to the default page -v-
    response.redirect "../default.asp"
	response.write "Edit action executed successfully."

End If

If request("action") = "delete" Then
    ' Get the id_agendapoint value from the request
    id_agendapoint = request("id_agendapoint")
    
    ' Use a transaction to ensure data integrity
    Conn.BeginTrans
    
    On Error Resume Next ' To handle any errors in execution
    
    ' Remove any associated user assignments from tblassign_agendapoints
    sql = "DELETE FROM tblassign_agendapoints WHERE id_agendapoint = ?"
    Set cmd = Server.CreateObject("ADODB.Command")
    cmd.ActiveConnection = Conn
    cmd.CommandText = sql
    cmd.Parameters.Append cmd.CreateParameter("@id_agendapoint", 3, 1, , id_agendapoint)
    cmd.Execute
    
    ' deleting main record from tbl_agendapoints
    sql = "DELETE FROM tbl_agendapoints WHERE id_agendapoint = ?"
    Set cmd = Server.CreateObject("ADODB.Command")
    cmd.ActiveConnection = Conn
    cmd.CommandText = sql
    cmd.Parameters.Append cmd.CreateParameter("@id_agendapoint", 3, 1, , id_agendapoint)
    cmd.Execute
    
    ' Check for errors
    If Err.Number <> 0 Then
        Conn.RollbackTrans
       ' response.write "Error deleting record: " & Err.Description
        Response.write "error: " & Err.Description

    Else
        Conn.CommitTrans
        Response.write "success"

       ' response.write "Record deleted successfully."
    End If

    ' Redirect after successful deletion
   ' response.redirect "../default.asp"
   Response.End
End If



%>
</BODY>
</HTML>
<!--#include file="../closedb.asp"-->