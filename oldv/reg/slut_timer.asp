<!--#include file="../login/protect.inc"-->

<!--#include file="../opendb.asp"-->
<!--#include file="alle_felter.asp"-->
<!DOCTYPE>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>OneTimer</title>

<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="../jquery/jquery.mobile-1.4.5.css">
<script src="../jquery/jquery-1.8.2.min.js"></script>
<script src="../jquery/jquery.mobile-1.4.5.min.js"></script>
<link type="text/css" rel="stylesheet" href="../jquery/jquery-te-1.4.0.css">
<script type="text/javascript" src="../jquery/jquery-te-1.4.0.min.js" charset="utf-8"></script>
</head>

<body>

<div data-role="header" data-id="header" data-position="fixed">
				<h1>End</h1>
				<a class="ui-btn-left" href="../default.asp" data-ajax="false" data-icon="home">
				Home</a> </div>
<form data-ajax="false" method="post" action="save.asp?action=slut">
		
	
			<table align="center" style="width: 50%">
								<tr>
												<th>Start date</th>
								</tr>
								<tr>
												<td style="text-align: center">
												<%=FormatDateTime(starttid,2)%>
												
												</td>
								</tr>
								<tr>
												<th>End time</th>
								</tr>
								<tr>
												<td style="text-align: center">
												<%=FormatDateTime(starttid,4)%>
												 <br>
												</td>
								</tr>
								<tr>
												<th style="text-align: center">
												Customer name</th>
								</tr>
								<tr>
												<td style="text-align: center">
												<%=kundenavn%></td>
								</tr>
								<tr>
												<th style="text-align: center">
												Job type</th>
								</tr>
								<tr>
												<td style="text-align: center">
												<%=job_dk%></td>
								</tr>
								<tr>
												<th style="text-align: center">
												Job comments</th>
								</tr>
								<tr>
												<td style="text-align: center">
												<%=jobbeskrivelse%></td>
								</tr>
								<tr>
												<td style="text-align: center">
												<input name="Submit1" type="submit" value="End" data-theme="a" data-icon="check"></td>
								</tr>
				</table>
				<input type="hidden" name="oprettetaf" value='<%=session("login")%>'>
			<input type="hidden" name="id_registrering" value="<%=id_registrering%>">
</form>



  

<!--#include file="../shared/footer.asp"-->
  

</body>

</html>
<!--#include file="../closedb.asp"-->