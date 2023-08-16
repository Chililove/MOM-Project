<!--#include file="../login/protect.inc"-->
<!--#include file="../opendb.asp"-->
<!--#include file="check_sluttid.asp"-->
<!DOCTYPE>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>OneTimer</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="../jquery/jquery.mobile-1.4.5.css">
<script src="../jquery/jquery-1.8.2.min.js"></script>
<script src="../jquery/jquery.mobile-1.4.5.min.js"></script>
<link rel="stylesheet" href="../shared/global.css" />
<link type="text/css" rel="stylesheet" href="../jquery/jquery-te-1.4.0.css">
<script type="text/javascript" src="../jquery/jquery-te-1.4.0.min.js" charset="utf-8"></script>
<script src="../jquery/jquery.validate.min.js"></script>
<style>
label.error {
				color: red;
				font-size: 16px;
				font-weight: normal;
				line-height: 1.4;
				margin-top: 0.5em;
				width: 100%;
				float: none;
}
@media 
{
label.error {
				margin-left: 0;
				display: block;
}
}
@media 
{
label.error {
				display: inline-block;
				margin-left: 22%;
q
}
em {
				color: red;
				font-weight: bold;
				padding-right: .25em;
}

#expanding-textarea {
  width: 720px;  /* Initial width */
  height: 50px; /* Initial height */
  transition: all 0.5s; /* Optional: smooth transition */
}

#expanding-textarea:focus {
  width: 720px;  /* Width when focused */
  height: 200px; /* Height when focused */
}

</style>
</head>

<body>

	<div id="page1" data-role="page">
	<div data-role="header" data-id="header" data-position="fixed">
	<h1>Start setting up a meeting</h1>
	<a class="ui-btn-left" href="../default.asp" data-ajax="false" data-icon="home">
	Home</a> </div>
	<!--<div id='fpimg'>
        <img src="..\Login\Game-On.png"/>
</div>-->
		<form data-ajax="false" method="post" action='save.asp?action=<%=request("action")%>' id="meeting_form">
		<table align="center" style="width: 50%">
		<tr>
			<th>Start date</th>
		</tr>
		<tr>
			<td style="text-align: center">
			<%=FormatDateTime(now(),2)%></td>
		</tr>
		<tr>
			<th>Start time</th>
		</tr>
		<tr>
			<td style="text-align: center">
			<%=FormatDateTime(now(),4)%><br>
			</td>
		</tr>
		<tr>
			<th style="text-align: center">
			
			
			Name of meeting
			
			</th>
		</tr>
		<tr>
		<td style="text-align: center">
		<input name="nameOfMeeting" type="text" style="width: 269px"></td>
		</tr>
		
		<tr>
			<th style="text-align: center">
			
			
			Type of meeting
			
			
			</th>
		</tr>
				<tr>
					<td style="text-align: center">
						<select name="id_meetingtype" required >
							<option selected="" value="">
							Select
							</option>
							
							<% SQL3="Select * from tblmeeting_type order by id_meetingtype"
							set objRS3 = conn.Execute(SQL3)
							while not objRS3.EOF %>

							<option value='<%=objRS3("id_meetingtype")%>' style="text-align: center">
							<%=objRS3("meeting_type")%>
							</option>

							<% objRS3.MoveNext
							Wend %>
						</select>
					</td>
				</tr>
		<tr>
			<th style="text-align: center">
			Agenda</th>
		</tr>
		<tr>
		<td>
		<textarea id="expanding-textarea" name="agenda" rows="4" cols="50"></textarea>

		<!--<input name="agenda" type="text" id="expanding-textarea"></td>-->
		</tr>
		

		<!--
		<tr>
			<th style="text-align: center">
			<select name="id_job" required >
			<option selected="" value="">
			Select
			</option>
			<%												
		SQL3="Select * from tbljob order by job_dk asc "
		set objRS3 = conn.Execute(SQL3)


		while not objRS3.EOF
		%>
			<option value='<%=objRS3("id_job")%>' style="text-align: center">
			<%=objRS3("job_dk")%>
			</option>
			<%
		objRS3.MoveNext
		Wend
		%></select></th>
		</tr>
		<tr>
		-->

		<th style="text-align: center">
		Additional information</th>
		</tr>
		<tr>
		<td style="text-align: center">
		<textarea name="additionalInfo" id="expanding-textarea" rows="4" cols="50"></textarea>

		<!--<input name="additionalInfo" type="text" style="width: 269px"></td>-->
		</tr>

		<!--
		<tr>
		<th style="text-align: center">
		Assign employees</th>
		</tr>
		-->

		<tr>
		<td style="text-align: center">
		<input name="Submit2" type="submit" value="Save meeting" data-theme="a" data-icon="check"></td>
		</tr>

		<tr>
		<td style="text-align: center">
		<input name="Submit1" type="submit" value="Start meeting" data-theme="a" data-icon="check"></td>
		</tr>

		</table>
		<input name="existing_id_registrering" type="hidden" value="<%=existing_id_registrering%>">
		<input type="hidden" name="oprettetaf" value='<%=session("login")%>'>
		</form>

	<!--#include file="../shared/footer.asp"--></div>

</body>
<script>
$( "#page1" ).on( "pageinit", function() {
	$( "form" ).validate({
		rules: {
			//meeting_name: {
			//	required: true
			//},
			//id_job: {
			//	required: true
			//}
		},
		errorPlacement: function( error, element ) {
		error.insertAfter( element.parent() );
		// error.appendTo('#errordiv');
		
		
		}
	});
});
</script>
</html>
<!--#include file="../closedb.asp"-->