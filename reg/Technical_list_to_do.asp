<!DOCTYPE>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="../jquery/jquery.mobile-1.4.5.css">
<script src="../jquery/jquery-1.8.2.min.js"></script>
<script src="../jquery/jquery.mobile-1.4.5.min.js"></script>
</head>

<body>

<!--#include file="../opendb.asp"-->
<div data-role="header" data-id="header" data-position="fixed">
				<h1>Kræver opfølgning</h1>
				<a class="ui-btn-left" href="../default.asp" data-ajax="false" data-icon="home">
				Home</a> </div>
<%

sql="select * from qryregistrering_technical where id_opfolgning=1 and id_opfolgning_done=0 order by oprettetdato desc "
set rs=conn.execute(sql)
%>
<ul data-role="listview" data-inset="true" data-filter="true">
				<%
do while not rs.eof
%>
				<li data-role="list-divider"><%=rs("installation_dk")%></li>
				<li>
				<a data-ajax="false" href='Technical_view.asp?id_registrering=<%=rs("id_registrering")%>'>
				<p><%=rs("funktion_dk")%><span style="visibility: hidden"><%=rs("installation_dk")%></span></p>
				<p><%=rs("system_nr")%>.<%=rs("system_dk")%></p>
				<p><%=rs("notat")%></p>
				<p class="ui-li-aside"><strong><%=rs("oprettetdato")%></strong></p>
				</a></li>
				<%
 rs.movenext
loop
%> </li>
</ul>
<!--#include file="../shared/footer.asp"-->

</body>
<!--#include file="../closedb.asp"-->

</html>
