<!--#include file="../login/protect.inc"-->
<!--#include file="../opendb.asp"-->
On Error Resume Next
<HTML>
<HEAD>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</HEAD>
<BODY>

<%
'save to registration
'*******************skriv til databasen     
response.write "Action: " & request("action") & "<br/>"
response.write "ID Agenda: " & request("id_agenda") & "<br/>"
response.write "ID company: " & request("id_company") & "<br/>"


id_agenda=request("id_agenda")
existing_id_registrering=request("existing_id_registrering")
oprettetaf=request("oprettetaf")
oprettetdato=date()
moede_navn=request("moede_navn")
emne=request("emne")
beskrivelse=request("beskrivelse")
noter=request("noter")
additionalinfo=request("additionalinfo")
id_meetingtype=request("id_meetingtype")
id_afdeling=request("id_afdeling")
id_login=request("id_login")
moede_dato=request("moede_dato")
moede_tidspunkt= request("moede_tidspunkt")
id_company = Session("id_company")
Response.Write("Session savecompany_id: " & Session("id_company"))

 logins = Request.Form("id_login")

' moede_tidspunkt=LEFT(RIGHT(request("moede_tidspunkt"),12),5)

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

Set rs = Server.CreateObject("ADODB.Command")
rs.ActiveConnection = Conn
'id_company = Session("id_company")
'Response.Write("Session save2company_id: " & Session("id_company"))

If request("action") = "newday" Then
    sql1 = "INSERT INTO tbl_agenda (moede_navn, emne, beskrivelse, noter, additionalinfo, oprettetaf, oprettetdato, starttid, id_meetingtype, id_afdeling, moede_dato, moede_tidspunkt, id_company, participants) "
    sql2 = "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"
    
    rs.CommandText = sql1 & sql2
    rs.Parameters.Append rs.CreateParameter("@moede_navn", 202, 1, 255, moede_navn)
    rs.Parameters.Append rs.CreateParameter("@emne", 202, 1, 255, emne)
	rs.Parameters.Append rs.CreateParameter("@beskrivelse", 202, 1, -1, beskrivelse)
    rs.Parameters.Append rs.CreateParameter("@noter", 202, 1, -1, noter)
    rs.Parameters.Append rs.CreateParameter("@additionalinfo", 202, 1, -1, additionalinfo)
    rs.Parameters.Append rs.CreateParameter("@oprettetaf", 202, 1, 50, oprettetaf)
    rs.Parameters.Append rs.CreateParameter("@oprettetdato", 135, 1, , oprettetdato)
    rs.Parameters.Append rs.CreateParameter("@starttid", 135, 1, , starttid)
	rs.Parameters.Append rs.CreateParameter("@id_meetingtype", 3, 1, , id_meetingtype)
	rs.Parameters.Append rs.CreateParameter("@id_afdeling", 3, 1, , id_afdeling)
    rs.Parameters.Append rs.CreateParameter("@moede_dato", 7, 1, , moede_dato)
    rs.Parameters.Append rs.CreateParameter("@moede_tidspunkt", 135, 1, 50, moede_tidspunkt)
    rs.Parameters.Append rs.CreateParameter("@id_company", 3, 1, , id_company)
    rs.Parameters.Append rs.CreateParameter("@participants", 202, 1, 255, logins)

	sql = sql1 + sql2
	response.write "<br>" & sql & "<br>"
    rs.Execute(sql)

set rs = Conn.Execute("SELECT @@IDENTITY AS id_agenda1")
 id_agenda1 = rs(0).Value
 session("id_agenda") = id_agenda1
sql= "SELECT participants FROM tbl_agenda WHERE id_agenda = "& id_agenda1 &""
response.write sql & "<br>"
set RS = Conn.Execute(sql)

participants = Split(RS("participants"), ",")
For Each participant In participants
    response.write participant & "<br />"
Next

Response.Write "<script type='text/javascript'>"
Response.Write "setTimeout(function() { window.location.href = './nextstep.asp'; }, 3000);"
Response.Write "</script>"

' Response.redirect "./nextstep.asp"
end if

if request("action")="show" then

    Dim rs, cmd, assignedEmployees, id_agenda, checkboxState
    Set assignedEmployees = CreateObject("Scripting.Dictionary")

    ' Preparing the SQL command
    Set cmd = CreateObject("ADODB.Command")
    cmd.ActiveConnection = Conn
    cmd.CommandText = "SELECT * FROM tbl_agenda WHERE id_agenda=?"
    cmd.Parameters.Append cmd.CreateParameter("@id_agenda", 3, 1, , id_agenda) ' 3 is adInteger

    ' Execute the command
    Set rs = cmd.Execute

    If Not rs.EOF Then
        moede_dato = rs("moede_dato")
        moede_navn = rs("moede_navn")
        emne = rs("emne")
        beskrivelse = rs("beskrivelse")
        noter = rs("noter")
        additionalinfo = rs("additionalinfo")
        id_meetingtype = rs("id_meetingtype")
        id_afdeling = rs("id_afdeling")
        id_login = rs("id_login")
        moede_dato = rs("moede_dato")
        moede_tidspunkt = rs("moede_tidspunkt")
        id_company = rs("id_company")
        participants = rs("participants")

      set rs = Conn.Execute("SELECT @@IDENTITY AS id_agenda1")
 id_agenda1 = rs(0).Value
 session("id_agenda") = id_agenda1
sql= "SELECT participants FROM tbl_agenda WHERE id_agenda = "& id_agenda1 &""
response.write sql & "<br>"
set RS = Conn.Execute(sql)

participants = Split(RS("participants"), ",")
For Each participant In participants
    response.write participant & "<br />"
Next
    else
        response.write "no data"
        'response.redirect "../default.asp"
    end if
end if
	
If request("action") = "edit" Then
    ' Define the update statement with parameters
    sql = "UPDATE tbl_agenda SET " & _
        "moede_navn = ?, " & _
        "emne = ?, " & _
        "beskrivelse = ?, " & _
        "noter = ?, " & _
        "additionalinfo = ?, " & _
        "id_meetingtype = ?, " & _
        "id_afdeling = ?, " & _
        "moede_dato = ?, " & _
        "moede_tidspunkt = ?, " & _
        "id_company = ? " & _
        "WHERE id_agenda = ?"

    ' Create a command object and set its properties
    Set cmd = Server.CreateObject("ADODB.Command")
    Set cmd.ActiveConnection = Conn
    cmd.CommandText = sql
    cmd.CommandType = 1 ' adCmdText
    ' Add parameters to the command object
    cmd.Parameters.Append cmd.CreateParameter("@moede_navn", 202, 1, 255, moede_navn)
    cmd.Parameters.Append cmd.CreateParameter("@emne", 202, 1, 255, emne)
    cmd.Parameters.Append cmd.CreateParameter("@beskrivelse", 203, 1, -1, beskrivelse)
    cmd.Parameters.Append cmd.CreateParameter("@noter", 203, 1, -1, noter)
    cmd.Parameters.Append cmd.CreateParameter("@additionalinfo", 203, 1, -1, additionalinfo)
    cmd.Parameters.Append cmd.CreateParameter("@id_meetingtype", 3, 1, , id_meetingtype)
    cmd.Parameters.Append cmd.CreateParameter("@id_afdeling", 3, 1, , id_afdeling)
    cmd.Parameters.Append cmd.CreateParameter("@moede_dato", 7, 1, , moede_dato)
    cmd.Parameters.Append cmd.CreateParameter("@moede_tidspunkt", 135, 1, 255, moede_tidspunkt)
    cmd.Parameters.Append cmd.CreateParameter("@id_company", 3, 1, , id_company)
    cmd.Parameters.Append cmd.CreateParameter("@id_agenda", 3, 1, , id_agenda)
    
    ' Execute the command
    cmd.Execute

    ' Release the command object
    Set cmd = Nothing

    ' Dictionary for currently assigned users
    Set assignedEmployees = CreateObject("Scripting.Dictionary")
    sql = "SELECT id_login FROM tblassign_users_to_agenda WHERE id_agenda=" & id_agenda
    Set rs = Conn.Execute(sql)
    While Not rs.EOF
        assignedEmployees.Add CStr(rs("id_login")), True
        rs.MoveNext
    Wend

    ' Dictionary for submitted user assignments from the form
    Set submittedEmployees = CreateObject("Scripting.Dictionary")
    selectedLogins = Split(Request.Form("id_login"), ",")
    For Each id_login In selectedLogins
        submittedEmployees.Add CStr(id_login), True
    Next

    ' Determine which users to remove
    For Each id_login In assignedEmployees.Keys
        If Not submittedEmployees.Exists(id_login) Then
            sql = "DELETE FROM tblassign_users_to_agenda WHERE id_agenda = " & id_agenda & " AND id_login = " & id_login
            Conn.Execute(sql)
        End If
    Next

    ' Determine which users to add
    For Each id_login In submittedEmployees.Keys
        If Not assignedEmployees.Exists(id_login) Then
            sql = "INSERT INTO tblassign_users_to_agenda (id_agenda, id_login) VALUES (" & id_agenda & ", " & id_login & ")"
            Conn.Execute(sql)
        End If
    Next
	'this redirect to the default page -v-
    response.redirect "../default.asp"
	response.write "Edit action executed successfully."

End If

If request("action") = "delete" Then
    ' Get the id_agenda value from the request
    id_agenda = request("id_agenda")
    
    ' Use a transaction to ensure data integrity
    Conn.BeginTrans
    
    On Error Resume Next ' To handle any errors in execution
    
    ' Remove any associated user assignments from tblassign_users_to_agenda
    sql = "DELETE FROM tblassign_users_to_agenda WHERE id_agenda = ?"
    Set cmd = Server.CreateObject("ADODB.Command")
    cmd.ActiveConnection = Conn
    cmd.CommandText = sql
    cmd.Parameters.Append cmd.CreateParameter("@id_agenda", 3, 1, , id_agenda)
    cmd.Execute
    
    ' Now, delete the main record from tbl_agenda
    sql = "DELETE FROM tbl_agenda WHERE id_agenda = ?"
    Set cmd = Server.CreateObject("ADODB.Command")
    cmd.ActiveConnection = Conn
    cmd.CommandText = sql
    cmd.Parameters.Append cmd.CreateParameter("@id_agenda", 3, 1, , id_agenda)
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