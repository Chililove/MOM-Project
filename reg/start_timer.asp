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
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdf.js/2.10.377/pdf.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.4.0/jspdf.umd.min.js"></script>
</head>
<body>

	<div id="page1" data-role="page">
		<div data-role="header" data-id="header" data-position="fixed">
			<%if request("action")="newday" then%>
				<h1>Start setting up a meeting</h1>
			<%else%>
				<h1>Start setting up a meeting (End Previous)</h1>
			<%end if%>
				<a class="ui-btn-left" href="../default.asp" data-ajax="false" data-icon="home">Home</a>
		</div>
<!--#include file="../reg/reusableform.asp"-->
<!--#include file="../shared/footer.asp"-->
	</div>
</body>
</html>
<!--#include file="../closedb.asp"-->