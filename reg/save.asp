<!--#include file="../login/protect.inc"-->
<!--#include file="../opendb.asp"-->
<HTML>
<HEAD>


<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">

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
additionalinfo=request("additionalInfo")
id_meetingtype=request("id_meetingtype")
id_afdeling=request("id_afdeling")
id_login=request("id_login")
moede_dato=request("moede_dato")
moede_tidspunkt=request("moede_tidspunkt")

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


if request("action")="newday" then

	sql1= "INSERT INTO tbl_agenda (moede_navn,emne,beskrivelse, noter, additionalinfo, oprettetaf,oprettetdato,starttid, id_meetingtype, id_afdeling, id_login, moede_dato, moede_tidspunkt) "
	sql2= "VALUES ('" & moede_navn &"','" & emne &"','" & beskrivelse &"','" & noter &"','" & additionalinfo &"','" & oprettetaf &"','" & oprettetdato &"','" & starttid &"', " & id_meetingtype &", " & id_afdeling &", " & id_login & ", '" & moede_dato & "', '" & moede_tidspunkt & "' )"
	
	sql= sql1 & sql2
	response.write sql
	Conn.Execute(sql)

 ' Getting id_agenda - still cannot save multiple users to a agenda, but now I can save one selected user.
    Set rs = Conn.Execute("SELECT @@IDENTITY AS new_id_agenda")
    new_id_agenda = rs(0).Value

    selectedLogins = Split(Request.Form("id_login"), ",")
    For Each id_login In selectedLogins
        sql = "INSERT INTO tblassign_users_to_agenda (id_agenda, id_login) VALUES (" & new_id_agenda & ", " & id_login & "); SELECT SCOPE_IDENTITY();"
        Conn.Execute(sql)
    Next

	'sql1= "INSERT INTO tblregistrering (id_agenda,oprettetaf,oprettetdato,starttid) "
	'sql1=sql1 + "VALUES (" & id_agenda & ",'" & oprettetaf &"','" & oprettetdato &"','" &starttid &"')"
	
	'response.write sql1
	'Conn.Execute(sql1)

 end if

'****Start new job existing day
if request("action")="newjob" then

	'Close last job
	sql1= "UPDATE tblregistrering SET sluttid = '"& sluttid &"' where id_registrering = " & existing_id_registrering &" "
	' response.write sql1
	Conn.Execute(sql1)
	
	'Open new job
	sql1= "INSERT INTO tblregistrering (id_agenda,oprettetaf,oprettetdato,starttid) "
	sql1=sql1 + "VALUES (" & id_agenda & ",'" & oprettetaf &"','" & oprettetdato &"','" &starttid &"')"

	response.write sql1
	Conn.Execute(sql1)
end if


'****Close existing day
if request("action")="slut" then
	sql="UPDATE tblregistrering SET sluttid = '"& sluttid &"' where id_registrering="& request("id_registrering")&"  "
	Conn.Execute(sql)
end if

response.redirect "../default.asp"


%>
</BODY>
</HTML>
<!--#include file="../closedb.asp"-->