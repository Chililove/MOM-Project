
<!--#include file="../login/protect.inc"-->
<!--#include file="../opendb.asp"-->
<!DOCTYPE>
<%
' Check if the user is an administrator
If Not session("administrator") Then
    ' If not an administrator, redirect them to an error page or some other action
    Response.Redirect("../default.asp") ' Change "access_denied.asp" to the appropriate page
End If
%>
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
			<h1>Saved department</h1>
			<%else%>
			<h1>No saved department</h1>
			<%end if%>
<a class="ui-btn-left" href="../default.asp" data-ajax="false" data-icon="home">Home</a>
	</div>
	<!--<div id='fpimg'>
        <img src="..\Login\Game-On.png"/>
</div>-->

<%
Dim sql, rs, id_afdeling

' Check if an id_company is provided in the query string
If Len(Request.QueryString("id_afdeling")) > 0 Then
    ' Get the company ID from the query string and validate it
    id_afdeling = Trim(Request.QueryString("id_afdeling"))


    If IsNumeric(id_afdeling) Then
        ' SQL to get company details by id_company
        sql = "SELECT * FROM tbl_afdeling_2nd WHERE id_afdeling = " & id_afdeling
        Set rs = Conn.Execute(sql)

        If Not rs.EOF Then
            id_afdeling = rs("id_afdeling")
			afdeling = rs("afdeling")
        End If

        rs.Close
        Set rs = Nothing
    Else
        Response.Write("Invalid  ID for departments.")
    End If
Else
    ' If there is no id in the query string, I'm creating a new one
    ' Initialize afdeling to an  empty string
    id_afdeling = ""
	afdeling = ""
End If
%>

<!--#include file="../reg/afdeling_form.asp"-->			
<!--#include file="../shared/footer.asp"--></div>

</body>
</html>


<!--#include file="../closedb.asp"-->