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
				<h1>Daily registration</h1>
				<a class="ui-btn-left" href="../default.asp" data-ajax="false" data-icon="home">
				Home</a> </div>
<%

sql="select top 10 * from qryregistrering_sluttid_sum where oprettetaf='" &session("login") &"'  order by oprettetdato desc "
set rs=conn.execute(sql)
%>
<ul data-role="listview" data-inset="false" data-filter="false">
				<li data-role="list-divider">
				<table style="width: 100%">
				<tr>
								<td style="width: 50%">Created</td>
				</tr>
				</table>

				
				</li>
				<%
do while not rs.eof
%>
				<li>
				<a data-ajax="false" href='../reg_list/list_my.asp?oprettetdato=<%=rs("oprettetdato_string")%>'>
				<table style="width: 100%">
				
								
								<tr>
								<td style="width: 50%"><%=rs("oprettetdato")%></td>
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
