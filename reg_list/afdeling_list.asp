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
<style>
   /* Style for the smaller button */
  .small-button-container {
    display: flex;
    justify-content: flex-end;
    align-items: center;
    padding: 10px; 
  }

  .small-button {
    padding: 12px 16px; /* Adjust padding to control button size */
    color: grey; 
    border-radius: 5px; /* Rounded corners */
    text-decoration: none;
  }

  /* Hover effect for the smaller button */
  .small-button:hover {
    background-color: transparent;
    text-decoration: none;
	  box-shadow: 0px 4px 6px rgba(0, 0, 0.2, 0.2);

  }

  /* Style for the plus sign */
  .plus-sign::before {
    content: "+"; /* Content is a plus sign */
    font-weight: bold;
    margin-right: 5px; /* Add spacing between plus sign and text */
  }
</style>
<body>
	<div data-role="header" data-id="header" data-position="fixed">
		<h1>Departments</h1>
			<a class="ui-btn-left" href="../default.asp" data-ajax="false" data-icon="home">
				Home
			</a>
	</div>
<%
sql="select * from tbl_afdeling_2nd where id_company =  " & session("id_company") & "order by afdeling desc "
set rs=conn.execute(sql)
%>
	<ul data-role="listview" data-inset="false" data-filter="true">
		<h2 style="padding: 1%; height: .5px;">Existing departments</h2>

				<div class="small-button-container">
<!--<h2>Check out your meetingtypes here</h2>-->
    <a class="small-button" data-ajax="false" href="../reg/afdeling_page.asp?action=create">
      <span class="plus-sign"></span> Add a new department
    </a>
  </div>
				<li data-role="list-divider">
					<table style="width: 100%">
						<tr style="text-align: left">
							<th style="width: 25%">Department</th>
						</tr>
					</table>
				</li>
				<%
					do while not rs.eof
				%>
				<li>
					<a data-ajax="false" href='../reg/afdeling_page.asp?action=update&amp;id_afdeling=<%=rs("id_afdeling")%>'>

						<table style="width: 100%">		
								<tr>
									<td style="width: 25%"><%=rs("afdeling")%></td>
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
