<!--#include file="../login/protect.inc"-->
<!--#include file="../opendb.asp"-->
<HTML>
<HEAD>
   <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" >

</HEAD>
<BODY>
<%
'save 
'*******************skriv til databasen     

id_login=request("id_login")
fornavn=request("fornavn")
efternavn=request("efternavn")
login=request("login")
password1=request("password1")
logintype=request("logintype")
id_logintype=request("id_logintype")



if request("action")="opret" then

	sql1= "INSERT INTO tbllogin (fornavn,efternavn,password1,login, id_logintype) "
	sql2= "VALUES ('" & fornavn & "','" & efternavn & "','" & password1 & "','" & login & "'," & id_logintype & ")"

	sql= sql1 & sql2
	'response.write sql
	Conn.Execute(sql)
	
	
	
	mobilnrcountry="45"& request("login")

	message=  "Login til Onetimer med dit mobilnr og password:"& password1 &" Link: http://mom.main-solution.dk - SMS kan ikke besvares!"

  	Set objXMLHTTP = Server.CreateObject("Microsoft.XMLHTTP")
  	objXMLHTTP.Open "Get", "http://46.32.62.21:8080/index.php/http_api/send_sms?login=DONGWFM&pass=Poli10et&to="& mobilnrcountry &"&message="& message &"&flash=0", False
  	objXMLHTTP.Send
 	'response.write "Sendt" 	

	
	
	
	
end if


if request("action")="ret" then

	sql1= "UPDATE tbllogin SET id_logintype = "& request("id_logintype") &", login = '"& request("login") &"', fornavn = '"& request("fornavn") &"', efternavn = '"& efternavn &"', password1 = '"& password1 &"' where id_login = " & id_login &" "
	'response.write sql 
	Conn.Execute(sql1)
	
end if



response.redirect "default.asp"


%>
</BODY>
</HTML>
<!--#include file="../closedb.asp"-->