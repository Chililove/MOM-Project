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

id_agenda=request("id_agenda")
' id_kunde=request("id_kunde")
existing_id_registrering=request("existing_id_registrering")
' oprettetaf=session("login_id")
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
' response.write request("moede_tidspunkt")
' moede_tidspunkt=LEFT(RIGHT(request("moede_tidspunkt"),12),5)
' response.write "<br>" & moede_tidspunkt & "<br>"


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

	Dim rs, assignedEmployees, id_agenda, checkboxState
	Set assignedEmployees = CreateObject("Scripting.Dictionary")

	sql="SELECT * FROM tbl_agenda WHERE id_agenda=" & id_agenda 
	'response.write sql
	Set rs = Conn.Execute(sql)
	If Not rs.EOF Then
		moede_dato =rs("moede_dato")
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
	
		 sql = "SELECT id_login FROM tblassign_users_to_agenda WHERE id_agenda=" & id_agenda
		'response.write sql
        Set rs = Conn.Execute(sql)
 	While Not rs.EOF
            assignedEmployees.Add CStr(rs("id_login")), True
            rs.MoveNext
        Wend

	   end if
	else
			response.write "no data"
			'response.redirect "../default.asp"

	end if


If request("action")="edit" Then

id_agenda=request.QueryString("id_agenda")

    ' Update the main tbl_agenda based on provided details
    sql = "UPDATE tbl_agenda SET " & _
    "moede_navn = '" & Replace(moede_navn, "'", "''") & "', " & _
    "emne = '" & Replace(emne, "'", "''") & "', " & _
    "beskrivelse = '" & Replace(beskrivelse, "'", "''") & "', " & _
    "noter = '" & Replace(noter, "'", "''") & "', " & _
    "additionalinfo = '" & Replace(additionalinfo, "'", "''") & "', " & _
    "id_meetingtype = " & id_meetingtype & ", " & _
    "id_afdeling = " & id_afdeling & ", " & _
    "id_login = " & id_login & ", " & _
    "moede_dato = '" & moede_dato & "', " & _
    "moede_tidspunkt = '" & moede_tidspunkt & "' " & _
    "WHERE id_agenda = " & id_agenda

    response.write sql
    Conn.Execute(sql)

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

    'response.redirect "../default.asp"
End If



'sql="UPDATE tbl_agenda SET moede_navn='" & moede_navn & "', emne='" & emne & "', beskrivelse='" & beskrivelse & "',noter='" & noter & "', additionalinfo='" & additionalinfo & "', id_meetingtype='" & id_meetingtype & "', id_afdeling='" & id_afdeling & "',id_login='" & id_login & "', moede_dato='" & moede_dato & "', moede_tidspunkt='" & moede_tidspunkt & "', WHERE id=" & id_agenda"

'****Start new job existing day
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