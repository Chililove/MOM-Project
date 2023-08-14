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

<!--#include file="../opendb.asp"-->
<div data-role="header" data-id="header" data-position="fixed" data-ajax="false">
				<h1>Sidste 15 dage efter d. <%=date()-15%></h1>
				<a class="ui-btn-left" href="../default.asp" data-ajax="false" data-icon="home">
				Home</a> </div>
<%

sql="select * from qryregistrering_technical where oprettetdato >= '#" & date()-15 &"#'"
set rs=conn.execute(sql)
'response.write sql
%>
<ul data-role="listview" data-inset="true" data-filter="true">
				<%
do while not rs.eof
%>
				<li data-role="list-divider"><%=rs("installation_dk")%></li>
				<li><a data-ajax="false" href="Technical_view.asp?id_registrering=<%=rs("id_registrering")%>">
				<p><%=rs("funktion_dk")%><span style="visibility: hidden"><%=rs("installation_dk")%></span></p>
				<p><%=rs("system_nr")%>.<%=rs("system_dk")%></p>
				<p><%=rs("notat")%></p>
				<p class="ui-li-aside"><strong><%=rs("oprettetdato")%></strong></p>
				</a>

				
<%

rs.movenext
loop
%>
</ul>

</body>
<!--#include file="../closedb.asp"-->

</html>
