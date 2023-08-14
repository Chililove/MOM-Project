<!--#include file="../login/protect.inc"-->

<!--#include file="../opendb.asp"-->
<!--#include file="check_sluttid.asp"-->
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

<script src="../jquery/jquery.validate.min.js"></script>

</head>

<body>

<div data-role="header" data-id="header" data-position="fixed">
				<h1>Start</h1>
				<a class="ui-btn-left" href="../default.asp" data-ajax="false" data-icon="home">
				Home</a> </div>
<form data-ajax="false" method="post" action="save.asp?action=<%=request("action")%>"  language="JavaScript" name="FrontPage_Form1" onsubmit="return FrontPage_Form1_Validator(this)">
		
	
			<table align="center" style="width: 50%">
								<tr>
												<th>Start date</th>
								</tr>
								<tr>
												<td style="text-align: center">
												
												
												<%=date()%></td>
								</tr>
								<tr>
												<th>Start time</th>
								</tr>
								<tr>
												<td style="text-align: center">
												
												  <%=FormatDateTime(starttid,4)%><br>
												</td>
								</tr>
								<tr>
												<th style="text-align: center">
												Customer name</th>
								</tr>
								<tr>
												<td style="text-align: center">
												
												<select name="id_kunde" required>
												<option selected="" value="">&lt;-- Select --&gt;</option>
												<%												
SQL3="Select * from tblkunde order by kundenavn asc "
set objRS3 = conn.Execute(SQL3)


while not objRS3.EOF
%>
												<option value='<%=objRS3("id_kunde")%>' style="text-align: center">
												<%=objRS3("kundenavn")%>
												</option>
												<%
objRS3.MoveNext
Wend
%></select></td>
								</tr>
								<tr>
												<th style="text-align: center">
												Job type</th>
								</tr>
								<tr>
												<th style="text-align: center">
												
												<select name="id_job" required>
												<option selected="" value="">&lt;-- Select --&gt;</option>
												<%												
SQL3="Select * from tbljob order by job_dk asc "
set objRS3 = conn.Execute(SQL3)


while not objRS3.EOF
%>
												<option value='<%=objRS3("id_job")%>' style="text-align: center">
												<%=objRS3("job_dk")%>
												</option>
												<%
objRS3.MoveNext
Wend
%></select></th>
								</tr>
								<tr>
												<th style="text-align: center">
												Job comments</th>
								</tr>
								<tr>
												<td style="text-align: center">
												<input name="jobbeskrivelse"  type="text" style="width: 269px" required></td>
								</tr>
								<tr>
												<td style="text-align: center">
												<input name="Submit1" type="submit" value="Start" data-theme="a" data-icon="check"></td>
								</tr>
				</table>
				<input name="existing_id_registrering" type="hidden" value="<%=existing_id_registrering%>" >
				<input type="hidden" name="oprettetaf" value='<%=session("login")%>'>
</form>
<script>

$("#timeform").validate();

</script>




  

<!--#include file="../shared/footer.asp"-->
  

</body>

</html>
<!--#include file="../closedb.asp"-->