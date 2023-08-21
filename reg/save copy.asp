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
' jobbeskrivelse=request("jobbeskrivelse")
oprettetaf=session("login")
oprettetdato=dateadd("d",1,date())


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

	sql1= "INSERT INTO tbl_agenda (oprettetaf,oprettetdato,starttid) "
	sql2= "VALUES ('" & oprettetaf &"','" & oprettetdato &"','" & starttid &"')"

	sql= sql1 & sql2
	response.write sql
	Conn.Execute(sql)
end if
' if request("action")="newday" then

' 	sql1= "INSERT INTO tblregistrering (id_agenda,oprettetaf,oprettetdato,starttid) "
' 	sql2= "VALUES (" & id_agenda & ",'" & oprettetaf &"','" & oprettetdato &"','" & starttid &"')"

' 	sql= sql1 & sql2
' 	response.write sql
' 	Conn.Execute(sql)
' end if

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