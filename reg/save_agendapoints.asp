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


'oprettetaf=request("oprettetaf")
point_name=request("point_name")
short_desc=request("short_desc")
long_desc=request("long_desc")
id_agenda=request("id_agenda")
logins=request("id_login")
dato=request("date")
id_company = Session("id_company")
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

Set cmd = Server.CreateObject("ADODB.Command")
cmd.ActiveConnection = Conn

id_company = Session("id_company")

If request("action") = "newpoint" Then
id_agenda1=request.querystring("id_agenda")
     sql1 = "INSERT INTO tbl_agendapoints (point_name, short_desc, long_desc, id_agenda, dato, id_company, id_login)"
    sql2 = "VALUES (?, ?, ?, ?, ?, ?, ?)"
    sql = sql1 & sql2
        response.write sql
        cmd.CommandText = sql
         cmd.Parameters.Append cmd.CreateParameter("@point_name", 202, 1, 255, point_name)
         cmd.Parameters.Append cmd.CreateParameter("@short_desc", 202, 1, 255, short_desc)
    	 cmd.Parameters.Append cmd.CreateParameter("@long_desc", 202, 1, 255, long_desc)
     	 cmd.Parameters.Append cmd.CreateParameter("@id_agenda", 3, 1, , id_agenda1)
         cmd.Parameters.Append cmd.CreateParameter("@dato", 7, 1, , dato)
         cmd.Parameters.Append cmd.CreateParameter("@id_company", 3, 1, , id_company)
        cmd.Parameters.Append cmd.CreateParameter("@id_login", 202, 1, 255, logins)  
 
        
    cmd.Execute
 

    'Response.Write("Session savecompany_id: " & Session("id_company"))
    'response.redirect "reusableform.asp?id_agenda=" & id_agenda
    response.redirect "nextstep.asp?id_agenda=" & id_agenda1


        'response.redirect "../default.asp"
end if	

if request("action")="show" then

    Dim rs, cmd, id_agendapoint, checkboxState

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
        "id_company = ? " & _
        "WHERE id_agendapoint = ?"
    response.write sql
    response.write logins
    ' Create a command object and set its properties
    Set cmd = Server.CreateObject("ADODB.Command")
    Set cmd.ActiveConnection = Conn
    cmd.CommandText = sql
    cmd.CommandType = 1 ' adCmdText
    ' i'm adding parameters to the command object
    cmd.Parameters.Append cmd.CreateParameter("@point_name", 202, 1, 255, point_name)
    cmd.Parameters.Append cmd.CreateParameter("@short_desc", 202, 1, 255, short_desc)
	cmd.Parameters.Append cmd.CreateParameter("@long_desc", 202, 1, -1, long_desc)
    cmd.Parameters.Append cmd.CreateParameter("@dato", 7, 1, , dato)
	cmd.Parameters.Append cmd.CreateParameter("@id_login", 202, 1, 255, logins)
    cmd.Parameters.Append cmd.CreateParameter("@id_company", 3, 1, , id_company)
    cmd.Parameters.Append cmd.CreateParameter("@id_agendapoint", 3, 1, , id_agendapoint)
    
    ' Execute the command
    cmd.Execute




    ' Releasing command object
    Set cmd1 = Nothing

    ' Define the update statement with parameters
    sql = "SELECT id_agenda FROM tbl_agendapoints " & _
        "WHERE id_agendapoint = ?"
    response.write sql
    ' Create a command object and set its properties
    Set cmd1 = Server.CreateObject("ADODB.Command")
    Set cmd1.ActiveConnection = Conn
    cmd1.CommandText = sql
    cmd1.CommandType = 1 ' adCmd1Text
    ' i'm adding parameters to the command object
    cmd1.Parameters.Append cmd1.CreateParameter("@id_agendapoint", 3, 1, , id_agendapoint)
    
    ' Execute the command
    set rs = cmd1.Execute

    id_agenda = rs("id_agenda")


    ' Releasing command object
    Set cmd1 = Nothing
   
    response.redirect "../reg/nextstep.asp?id_agenda=" & id_agenda



End If

If request("action") = "delete" Then
    ' Get the id_agendapoint value from the request
    id_agendapoint = request("id_agendapoint")
    
    ' Use a transaction to ensure data integrity
    Conn.BeginTrans
    
    On Error Resume Next ' To handle any errors in execution
    
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
    'response.redirect "../default.asp"
   Response.End
End If



%>
</BODY>
</HTML>
<!--#include file="../closedb.asp"-->