<!--#include file="../opendb.asp"-->
<%
If Request.Form("Action") = "Send SMS" Then

'*******************Write log to database*********************    

login=(request.form("login"))
password1="Request password"
ipadresse=Request.ServerVariables("REMOTE_ADDR")

SQL1= "INSERT INTO tblLogning (login,ipadresse) VALUES ('"&login&"','"&ipadresse&"')"
conn.Execute SQL1

'******************Close Write log to database


' Validate and replace word in string
login = (Trim(Replace(Request.Form("login"),"'","")))

	If Len(login) > 0  Then

	' Building SQL string
	SQL2 = "SELECT * FROM tbllogin WHERE (login = '" & login & "') and (id_logintype=1 or id_logintype=2)"

			Set rs = conn.Execute(SQL2)
			If Not (rs.BOF Or rs.EOF) Then
		
				' Hvis brugeren fandtes i databasen
				
				login = rs("login")
				password1 = rs("password1")
				
				mobilnrcountry="45"& login

				message=  "Password til Onetimer:"& password1 &" Link: http://mom.main-solution.dk - SMS kan ikke besvares!"

  	Set objXMLHTTP = Server.CreateObject("Microsoft.XMLHTTP")
  	objXMLHTTP.Open "Get", "http://46.32.62.21:8080/index.php/http_api/send_sms?login=DONGWFM&pass=Poli10et&to="& mobilnrcountry &"&message="& message &"&flash=1", False
  	objXMLHTTP.Send
 				Else
			' No user in the database
				strERR = "Wrong login!!"
			End If


			If Len(login) Then
							
				Response.Redirect "../default.asp"
			End If
	Else
			' No username or password
			strErr = "No user"
	End If

End If


%>
<!--#include file="../closedb.asp"-->