<!--#include file="../login/protect.inc"-->
<!--#include file="../opendb.asp"-->
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

If request("action") = "newday" Then
    sql1 = "INSERT INTO tbl_agenda (moede_navn, emne, beskrivelse, noter, additionalinfo, oprettetaf, oprettetdato, starttid, id_meetingtype, id_afdeling, moede_dato, moede_tidspunkt) "
    sql2 = "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, '" & moede_tidspunkt & "')"
    
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
    'rs.Parameters.Append rs.CreateParameter("@moede_tidspunkt", 135, 1, , moede_tidspunkt)

	sql = sql1 + sql2
	response.write sql
    rs.Execute(sql)

	 Set rs = Conn.Execute("SELECT @@IDENTITY AS new_id_agenda")
    new_id_agenda = rs(0).Value
' could be this i was missing for the display and update of the assigned users ---------------------------------
    selectedLogins = Split(Request.Form("id_login"), ",")
    For Each id_login In selectedLogins
        sql = "INSERT INTO tblassign_users_to_agenda (id_agenda, id_login) VALUES (?, ?); SELECT SCOPE_IDENTITY();"
     '   Conn.Execute(sql)

	 Set rs = Server.CreateObject("ADODB.Command")
	rs.ActiveConnection = Conn
		rs.CommandText = sql
		rs.Parameters.Append rs.CreateParameter("@id_agenda", 3, 1, , new_id_agenda)
    	rs.Parameters.Append rs.CreateParameter("@id_login", 3, 1, , CInt(id_login))
		rs.Execute
    Next
	'response.redirect "../default.asp"
end if
'if request("action")="newday" then

	'sql1= "INSERT INTO tbl_agenda (moede_navn,emne,beskrivelse, noter, additionalinfo, oprettetaf,oprettetdato,starttid, id_meetingtype, id_afdeling, moede_dato, moede_tidspunkt) "
	'sql2= "VALUES ('" & moede_navn &"','" & emne &"','" & beskrivelse &"','" & noter &"','" & additionalinfo &"','" & oprettetaf &"','" & oprettetdato &"','" & starttid &"', " & id_meetingtype &", " & id_afdeling &", '" & moede_dato & "', '" & moede_tidspunkt & "' )"
	
	'sql= sql1 & sql2
	'response.write sql
	'Conn.Execute(sql)

   ' Set rs = Conn.Execute("SELECT @@IDENTITY AS new_id_agenda")
   ' new_id_agenda = rs(0).Value

   ' selectedLogins = Split(Request.Form("id_login"), ",")
   ' For Each id_login In selectedLogins
    '    sql = "INSERT INTO tblassign_users_to_agenda (id_agenda, id_login) VALUES (" & new_id_agenda & ", " & id_login & "); SELECT SCOPE_IDENTITY();"
    '    Conn.Execute(sql)
   ' Next

	'sql1= "INSERT INTO tblregistrering (id_agenda,oprettetaf,oprettetdato,starttid) "
	'sql1=sql1 + "VALUES (" & id_agenda & ",'" & oprettetaf &"','" & oprettetdato &"','" &starttid &"')"
	
	'response.write sql1
	'Conn.Execute(sql1)

 'end if

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

        ' Preparing the SQL command for the next query
        Set cmd = CreateObject("ADODB.Command")
        cmd.ActiveConnection = Conn
        cmd.CommandText = "SELECT id_login FROM tblassign_users_to_agenda WHERE id_agenda=?"
        cmd.Parameters.Append cmd.CreateParameter("@id_agenda", 3, 1, , id_agenda) ' 3 is adInteger

        ' Execute the command
        Set rs = cmd.Execute

        While Not rs.EOF
            assignedEmployees.Add CStr(rs("id_login")), True
            rs.MoveNext
        Wend
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
        "moede_tidspunkt = ? " & _
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
    cmd.Parameters.Append cmd.CreateParameter("@moede_dato", 7, 1, 255, moede_dato)
    cmd.Parameters.Append cmd.CreateParameter("@moede_tidspunkt", 202, 1, 255, moede_tidspunkt)
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

'****Start new job existing day
'sql="UPDATE tbl_agenda SET moede_navn='" & moede_navn & "', emne='" & emne & "', beskrivelse='" & beskrivelse & "',noter='" & noter & "', additionalinfo='" & additionalinfo & "', id_meetingtype='" & id_meetingtype & "', id_afdeling='" & id_afdeling & "',id_login='" & id_login & "', moede_dato='" & moede_dato & "',
'moede_tidspunkt='" & moede_tidspunkt & "', WHERE id=" & id_agenda"
' if request("action")="newjob" then
' 	'Close last job
' 	sql1= "UPDATE tblregistrering SET sluttid = '"& sluttid &"' where id_registrering = " & existing_id_registrering &" "
' 	' response.write sql1
' 	Conn.Execute(sql1)
' 	'Open new job
' 	sql1= "INSERT INTO tblregistrering (id_agenda,oprettetaf,oprettetdato,starttid) "
' 	sql1=sql1 + "VALUES (" & id_agenda & ",'" & oprettetaf &"','" & oprettetdato &"','" &starttid &"')"
' 	response.write sql1
' 	Conn.Execute(sql1)
' end if
'****Close existing day

if request("action")="slut" then
	sql="UPDATE tblregistrering SET sluttid = '"& sluttid &"' where id_registrering="& request("id_registrering")&"  "
	Conn.Execute(sql)
end if
'response.redirect "../default.asp"
%>
</BODY>
</HTML>
<!--#include file="../closedb.asp"-->