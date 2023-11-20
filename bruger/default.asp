<!--#include file="../login/protect.inc"-->
<!--#include file="../opendb.asp"-->
<!DOCTYPE>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" >
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="../jquery/jquery.mobile-1.4.5.css">
<script src="../jquery/jquery-1.8.2.min.js"></script>
<script src="../jquery/jquery.mobile-1.4.5.min.js"></script>
</head>

<body>
	<div data-role="header" data-id="header" data-position="fixed">
		<h1>Brugere</h1>
			<a class="ui-btn-left" href="../default.asp" data-ajax="false" data-icon="home">
				Home
			</a>
	</div>
<%
 If Session("administrator") Then

 'id_company = session("id_company")

sql="select * from qrylogin where id_company =  " & session("id_company") & " order by login desc "
set rs=conn.execute(sql)

%>
<%Else
response.redirect("/default.asp") %>
<%End if%>
	<ul data-role="listview" data-inset="false" data-filter="true">
				<li data-role="list-divider">
					<table style="width: 100%">
						<tr style="text-align: left">
							<th style="width: 25%">Login</th>

							<th style="width: 25%">Fornavn</th>

							<th style="width: 25%">Efternavn</th>
								
							<th style="width: 25%">Email</th>

							<th style="width: 25%">Profil</th>

						</tr>
					</table>
				</li>
				<%
					do while not rs.eof
				%>
				<li>
					<a data-ajax="false" href='../bruger/bruger.asp?action=ret&amp;id_login=<%=rs("id_login")%>'>
						<table style="width: 100%">		
								<tr>
									<td style="width: 25%"><%=rs("login")%></td>
				
									<td style="width: 25%"><%=rs("fornavn")%></td>
				
									<td style="width: 25%"><%=rs("efternavn")%></td>

									<td style="width: 25%"><%=rs("mailadresse")%></td>
				
									<td style="width: 25%"><%=rs("logintype")%></td>
				
								</tr>
						</table>
					</a>
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
