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
				<h1>Last 20 registrations</h1>
				<a class="ui-btn-left" href="../default.asp" data-ajax="false" data-icon="home">
				Home</a> </div>
<%

sql="select top 20 * from qryregistrering_sluttid_minutes where oprettetaf='" &session("login") &"' order by id_registrering desc "
set rs=conn.execute(sql)
%>
<ul data-role="listview" data-inset="false" data-filter="false">
				<%
do while not rs.eof
%>
				<li data-role="list-divider">
				<p class="ui-li-aside"><strong><%=FormatDateTime(rs("starttid"),2)%></strong></p>
				</li>
				<li>
				
				<p></p>
				<p><%=rs("job_dk")%></p>
								
				<p><%=rs("starttid")%> --> <%=rs("sluttid")%>=<%=rs("difftime")%></p>
				<p><%=rs("jobbeskrivelse")%></p>
				</li>
				<%
 rs.movenext
loop
%> 
</ul>
<!--#include file="../shared/footer.asp"-->

</body>
<!--#include file="../closedb.asp"-->

</html>
