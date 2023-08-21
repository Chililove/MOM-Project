<!--#include file="../login/protect.inc"-->
<!--#include file="../opendb.asp"-->
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>OneTimer</title>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="stylesheet" href="../jquery/jquery.mobile-1.4.5.css">
		<script src="../jquery/jquery-1.8.2.min.js"></script>
		<script src="../jquery/jquery.mobile-1.4.5.min.js"></script>
		<link type="text/css" rel="stylesheet" href="../jquery/jquery-te-1.4.0.css">
		<script type="text/javascript" src="../jquery/jquery-te-1.4.0.min.js" charset="utf-8"></script>
		<script src="../jquery/jquery.validate.min.js"></script>
	</head>
	<body>
		<div id="page1" data-role="page">
		<!-- header -->
			<div data-role="header" data-id="header" data-position="fixed">
				<%if request("action")="ret" then%>
				<!--#include file="alle_felter.asp"-->
				<h1>Ret bruger</h1>
				<%else%>
				<h1>Opret bruger</h1>
				<%end if%>
				<a class="ui-btn-left" href="../default.asp" data-ajax="false" data-icon="home">
					Home
				</a> 
			</div>
		<!-- form -->
			<form data-ajax="false" method="post" action='save.asp?action=<%=request("action")%>'>
								<table align="center" style="width: 50%">
								<!-- Login -->
									<tr>
										<th style="text-align: center">
											Login
										</th>
									</tr>
									<tr>
										<td style="text-align: center">
										<input name="login" type="text" size="25" 

										<%if request("action")="ret" then%>
										value="<%=login%>" 
										<%end if%>
										required ></td>
									</tr>
								<!-- Fornavn -->
									<tr>
										<td style="text-align: center">
										Fornavn</td>
									</tr>
									<tr>
										<td style="text-align: center">
										<input name="fornavn" type="text" size="25" value="<%=fornavn%>" required ></td>
									</tr>
								<!-- Efternavn -->
									<tr>
										<td style="text-align: center">
										Efternavn</td>
									</tr>
									<tr>
										<td style="text-align: center">
										<input name="efternavn" type="text" size="25" value="<%=efternavn%>" required ></td>
									</tr>
								<!-- Password -->
									<tr>
										<td style="text-align: center">
										Password:</td>
									</tr>
									<tr>
										<td style="text-align: center">
										<input name="password1" type="text" size="25" value="<%=password1%>" required ></td>
									</tr>
								<!-- Profil -->
									<tr>
										<td style="text-align: center">
										Profil</td>
									</tr>
									<tr>
										<td style="text-align: center">
										<select name="id_logintype" required >
										<%if request("action")="ret" then%><option selected="" value="<%=id_logintype%>"><%=logintype%>
										</option>
										<%end if%>
										<%												
										SQL3="Select * from tbllogintype order by logintype asc "
										set objRS3 = conn.Execute(SQL3)
										while not objRS3.EOF
										%>
										<option value='<%=objRS3("id_logintype")%>' style="text-align: center">
										<%=objRS3("logintype")%>
										</option>
										<%
										objRS3.MoveNext
										Wend
										%></select></td>
									</tr>
								<!-- save btn -->
									<tr>
										<td style="text-align: center">
										<input name="Submit1" type="submit" value="Gem" data-theme="a" data-icon="check"></td>
									</tr>
								</table>
								<input type="hidden" name="id_login" value="<%=id_login%>">
							</form>
						
						<!--#include file="../shared/footer.asp"-->
		</div>
	</body>
</html>
<!--#include file="../closedb.asp"-->