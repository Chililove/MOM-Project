
<!--#include file="../login/protect.inc"-->
<!--#include file="../opendb.asp"-->
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

<script src="https://cdnjs.cloudflare.com/ajax/libs/pdf.js/2.10.377/pdf.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.4.0/jspdf.umd.min.js"></script>

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

	}
	em {
					color: red;
					font-weight: bold;
					padding-right: .25em;
	}
	}

  .dropdown {
    display: inline-block;
    cursor: pointer;
	right:0;
    padding: 8px;
	margin-right: 80px;
  }
  .dropdown-content {
	visibility: hidden;
    display: flex;
    position: absolute;
    left: 0;
    width: 300px;
    box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
    background-color: #f9f9f9;
    overflow-y: auto;
	z-index: 1;
    max-height: 250px;
	margin-left: 300px;
	margin-top: -150px;
	flex-wrap: wrap;
	flex-direction: row;
	padding: 6px;
	
  }
 
  label {
    display: block;
    margin: 10px 0;
  }

  .label-container {
	width: 50%;
	box-sizing: border-box;
	text-align: center;
  }

  .dropdown-wrapper {
  display: inline-block;
  vertical-align: top;
  width: 200px; 
  }
.user-list {
  display: flex;
  flex-wrap: wrap;
}

.user-item{
	width: 80px;
}


.checkuser{
	width: 50%;
}


</style>
</head>

<body>

	<div id="page1" data-role="page">
		<div data-role="header" data-id="header" data-position="fixed">
			<%if request("action")="show" then%>
			<h1>Saved meeting</h1>
			<%else%>
			<h1>No saved meeting?</h1>
			<%end if%>
<a class="ui-btn-left" href="../default.asp" data-ajax="false" data-icon="home">Home</a>
	</div>

	<!--<div id='fpimg'>
        <img src="..\Login\Game-On.png"/>
</div>-->
<% sql="SELECT * FROM qry_agenda WHERE id_agenda = "& request.QueryString("id_agenda") &" "
	'response.write sql
	set rs = Conn.Execute(sql)
	moede_tidspunkt=rs("moede_tidspunkt")
	id_meetingtype=rs("id_meetingtype")
	' id_agenda= rs("id_agenda")
	id_agenda1= request.QueryString("id_agenda")
%>
<!--#include file="../reg/reusableform.asp"-->		
		
<!--#include file="../shared/footer.asp"--></div>

</body>

<script>
// $( "#page1" ).on( "pageinit", function() {
// 	$( "form" ).validate({
// 		rules: {
// 			meeting_name: {
// 				required: true
// 		/},
// 			id_meetingtype: {
// 				required: true
// 			}
// 		},
// 		errorPlacement: function( error, element ) {
// 		error.insertAfter( element.parent() );
// 		// error.appendTo('#errordiv');
		
// 		}
// 	});
// });
</script>
</html>


<!--#include file="../closedb.asp"-->