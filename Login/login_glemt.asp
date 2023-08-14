
<!--#include file="sendpw.inc"-->
<%
'luk session
Session.Abandon 
Response.Buffer = True
Response.ExpiresAbsolute = Now() - 1
Response.Expires = 0
Response.CacheControl = "no-cache"

Session("s1")=""
Session("s2")=""
Session("s3")=""
Session("s4")=""
Session("s5")=""
Session("s6")=""
Session("s7")=""
Session("s8")=""
Session("user")=""

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252" />
<title>OneTimer</title>
<meta name="viewport" content="width=device-width, initial-scale=1"/>
<link rel="stylesheet" href="../jquery/jquery.mobile-1.4.5.css" />
<script src="../jquery/jquery-1.8.2.min.js"></script>
<script src="../jquery/jquery.mobile-1.4.5.min.js"></script>


</head>

<body>
<form method="POST" action="login_glemt.asp" target="_top">
<div data-role="footer" data-id="footer" data-position="fixed">
<h1>New password</h1>  
</div>

<table align="center" >
				<tr>
								<td><label for="text-basic">Login:</label></td>
				</tr>
				<tr>
								<td>
<input name="login"  type="text" value="">
</td>
				</tr>
				<tr>
								<td>
<input type="submit" value="Send SMS" data-theme="a" data-icon="check" name="Action">
</td>
				</tr>
</table>
</form>
</body>

</html>
