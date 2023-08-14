<!DOCTYPE>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="../jquery/jquery.mobile-1.4.5.css">
<script src="../jquery/jquery-1.8.2.min.js"></script>
<script src="../jquery/jquery.mobile-1.4.5.min.js"></script>
<link type="text/css" rel="stylesheet" href="../jquery/jquery-te-1.4.0.css">
<script type="text/javascript" src="../jquery/jquery-te-1.4.0.min.js" charset="utf-8"></script>
</head>

<body>

<!--#include file="../opendb.asp"--><%if request("action")="save" then
notat_opfolgning=request("Notat_opfolgning") &"<br>" & request("Notat_opfolgning_add") &"<br><b>" & request("opfolgningaf")&"/" &request("opfolgningdato_done") &"</b>"


	sql= "update tblregistrering set id_opfolgning_done= " & request("id_opfolgning_done") & " ,notat_opfolgning='" & notat_opfolgning & "' ,opfolgningaf='" & request("opfolgningaf") & "',opfolgningdato_done='" & request("opfolgningdato_done") & "' where id_registrering= " & request("id_registrering") &" "
'	sql= "update tblregistrering set opfolgningaf='" & request("opfolgningaf") & "',opfolgningdato_done='" & request("opfolgningdato_done") & "'  where id_registrering= " & request("id_registrering") &" "

'response.write sql
Conn.Execute(sql)

end if
%>
<div data-role="header" data-id="header" data-position="fixed" data-ajax="false">
				<h1>Detailed information</h1>
				<a class="ui-btn-left" href="../default.asp" data-ajax="false" data-icon="home">
				Home</a> </div>
<%

sql="select * from qryregistrering_technical where id_registrering=" & request("id_registrering") &" "
set rs=conn.execute(sql)
'response.write sql


%>
<ul data-role="listview" data-inset="true" data-filter="true">
				<%
do while not rs.eof
id_opfolgning=rs("id_opfolgning")
id_opfolgning_done=rs("id_opfolgning_done")
id_registrering=rs("id_registrering")
notat_opfolgning=rs("notat_opfolgning")

%>
				<li data-role="list-divider"><%=rs("installation_dk")%></li>
				<li>
				<p><%=rs("funktion_dk")%><span style="visibility: hidden"><%=rs("installation_dk")%></span></p>
				<p><%=rs("system_nr")%>.<%=rs("system_dk")%></p>
				<p><%=rs("notat")%></p>
				<p class="ui-li-aside"><strong><%=rs("oprettetdato")%></strong></p>
				<%if id_opfolgning=1 then%>
				<p><b>Opfølgning</b></p>
				<p><%=rs("notat_opfolgning")%></p>
				<%end if%> </li>
				<li data-role="list-divider">External documents</li> <%

rs.movenext
loop
%> <%
		sql1="select * from tblreg_upload where id_registrering = " &  request("id_registrering") & " "
		set rs1=conn.execute(sql1)
		do while not rs1.eof
	filsti="http://hdb.proces-manager.dk/files/"
	filsti=filsti &  request("id_registrering") &"-" & rs1("uniknumber") &"-" & rs1("filnavn")			
%>
				<li><a target="_blank" href="<%=filsti%>">
				<p><%=rs1("filnavn")%></p>
				</a></li>
				<%
			rs1.movenext
			loop
%> <%if id_opfolgning=1 and id_opfolgning_done=0 then %>
				<form data-ajax="false" method="post" action="technical_view.asp?action=save">
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
								<table style="width: 100%">
												<tr>
																<td>Opfølgning<br>
																<textarea class="notat" name="Notat_opfolgning_add" style="width: 100%;" rows="3"></textarea></td>
																<td></td>
												</tr>
												<tr>
																<td>
																<label for="flip-2">
																Opfølgning afsluttet</label>
																<select name="id_opfolgning_done" id="flip-2" data-role="slider">
																<option value="0">
																Nej</option>
																<option value="1">
																Ja</option>
																</select> </td>
																<td>&nbsp;</td>
												</tr>
								</table>
								<input name="Submit1" type="submit" value="Save" data-theme="a" data-icon="check">
								<input type="hidden" name="opfolgningaf" value='<%=session("login")%>'>
								<input type="hidden" name="opfolgningdato_done" value="<%=now()%>">
								<input type="hidden" name="id_registrering" value="<%=id_registrering%>">
								<input type="hidden" name="Notat_opfolgning" value="<%=Notat_opfolgning%>">
				</form>
				<%end if%> </li>
</ul>

</body>
<!--#include file="../closedb.asp"-->

</html>
