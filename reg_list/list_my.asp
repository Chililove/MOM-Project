<!--#include file="../opendb.asp"-->
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
	<!-- header -->
		<div data-role="header" data-id="header" data-position="fixed">
			<h1>
				<%=response.Write(WeekdayName(weekday(request("oprettetdato"))))%> - <%=FormatDateTime(request("oprettetdato"),1)%> 
			</h1>
			<a class="ui-btn-left" href="../default.asp" data-ajax="false" data-icon="home">
				Home
			</a> 
		</div>
	<!-- møde loop -->
		<% sql="select * from qryregistrering_sluttid_minutes where oprettetdato='" &request("oprettetdato") &"' and oprettetaf='" &session("login") &"' order by id_registrering desc "
		'response.write sql
		set rs=conn.execute(sql) %>
		<ul data-role="listview" data-inset="false" data-filter="false">
			<% do while not rs.eof %>
				<li data-role="list-divider">
					<p class="ui-li-aside">
						<strong>
							<%=FormatDateTime(rs("starttid"),2)%>
						</strong>
					</p>
				</li>
				<li>
					<p>
						<%=rs("job_dk")%>
					</p>
					<p>
						<%=FormatDateTime(rs("starttid"),4)%>-<%=FormatDateTime(rs("sluttid"),4)%>
					</p>
					<p>
						<%=rs("jobbeskrivelse")%>
					</p>
				</li>
			<% rs.movenext
			loop %> 
		</ul>
		<!--#include file="../shared/footer.asp"-->
	</body>
</html>
<!--#include file="../closedb.asp"-->