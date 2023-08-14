<!DOCTYPE>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="../jquery/jquery.mobile-1.4.5.css">
<script src="../jquery/jquery-1.8.2.min.js"></script>
<script src="../jquery/jquery.mobile-1.4.5.min.js"></script>
<link rel="stylesheet" type="text/css" href="http://cdn.jtsage.com/datebox/latest/jqm-datebox.min.css">
<script type="text/javascript" src="http://cdn.jtsage.com/datebox/latest/jqm-datebox.core.min.js"></script>
<script type="text/javascript" src="http://dev.jtsage.com/cdn/datebox/latest/jqm-datebox.mode.calbox.min.js"></script>
<script type="text/javascript" src="http://dev.jtsage.com/cdn/datebox/latest/jqm-datebox.mode.datebox.min.js"></script>
<script type="text/javascript" src="http://cdn.jtsage.com/datebox/i18n/jquery.mobile.datebox.i18n.da.utf8.js"></script>
<script type="text/javascript" src="http://dev.jtsage.com/cdn/datebox/latest/jqm-datebox.mode.flipbox.min.js"></script>

<link type="text/css" rel="stylesheet" href="../jquery/jquery-te-1.4.0.css">
<script type="text/javascript" src="../jquery/jquery-te-1.4.0.min.js" charset="utf-8"></script>
</head>

<body>

<!--#include file="../opendb.asp"-->
<div data-role="header" data-id="header" data-position="fixed">
				<h1>Registrering</h1>
				<a class="ui-btn-left" href="../default.asp" data-ajax="false" data-icon="home">
				Home</a> </div>
<form data-ajax="false" method="post" action="save.asp" enctype="multipart/form-data">
				<script>
	$('.notat').jqte();
	
	// settings of status
	var jqteStatus = true;
	$(".status").click(function()
	{
		jqteStatus = jqteStatus ? false : true;
		$('.jqte-test').jqte({"status" : jqteStatus})
	});
</script>
				<table align="center" style="width: 50%">
								<tr>
												<td>Dato</td>
								</tr>
								<tr>
												<td>
												
												
												<input name="mode3" type="text" data-role="datebox" data-options='{"mode":"flipbox", "useLang":"da"}' /></td>
								</tr>
								<tr>
												<td>Tidspunkt</td>
								</tr>
								<tr>
												<td>
												
												  <input name="mode7" type="text" data-role="datebox" data-options='{"mode":"timeflipbox", "overrideDateFormat": "%H:%M"}' /><br>
												</td>
								</tr>
								<tr>
												<td>Sag</td>
								</tr>
								<tr>
												<td><select name="id_system">
												<option selected="" value="0">&lt;-- 
												Vælg --&gt;</option>
												<%												
SQL3="Select * from tblsystem order by system_dk asc "
set objRS3 = conn.Execute(SQL3)


while not objRS3.EOF
%>
												<option value='<%=objRS3("id_system")%>'>
												<%=objRS3("system_dk")%>
												</option>
												<%
objRS3.MoveNext
Wend
%></select></td>
								</tr>
								<tr>
												<td>
												<input name="Submit1" type="submit" value="Save" data-theme="a" data-icon="check"></td>
								</tr>
				</table>
				<input type="hidden" name="oprettetaf" value='<%=session("login")%>'>
</form>
<!--#include file="../shared/footer.asp"-->

</body>

</html>
<!--#include file="../closedb.asp"-->