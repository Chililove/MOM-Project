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
		<h1>Companies</h1>
			<a class="ui-btn-left" href="../default.asp" data-ajax="false" data-icon="home">
				Home
			</a>
	</div>
<%
sql="select * from tbl_companies  where id_company =  " & session("id_company") & " order by company_name desc "
set rs=conn.execute(sql)
%>
	<h2 style="padding: 1%; height: .5px;">Check out your departments here</h2>

	<ul data-role="listview" data-inset="false" data-filter="true">
				<li data-role="list-divider">
					<table style="width: 100%">
						<tr style="text-align: left">
							<th style="width: 25%">name</th>

							<th style="width: 25%">cvr</th>

                            <th style="width: 25%">telefon</th>

							<th style="width: 25%">email</th>

								
							
						</tr>
					</table>
				</li>
				<%
					do while not rs.eof
				%>
				<li>
					<a data-ajax="false" href='../reg/company_page.asp?action=update&amp;id_company=<%=rs("id_company")%>'>

						<table style="width: 100%">		
								<tr>
									<td style="width: 25%"><%=rs("company_name")%></td>
				
									<td style="width: 25%"><%=rs("cvr")%></td>
				
                                    <td style="width: 25%"><%=rs("telefon")%></td>

									<td style="width: 25%"><%=rs("email")%></td>


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
