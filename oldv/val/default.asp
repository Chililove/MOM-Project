﻿<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>Test for jQuery validate() plugin</title>
<link rel="stylesheet" media="screen" href="css/screen.css">
<script src="../lib/jquery.js"></script>
<script src="../dist/jquery.validate.js"></script>
<style>.cmxform fieldset p label span.error{color:red;}form.cmxform{width:30em;}form.cmxform label{width:auto;display:block;float:none;}</style>
<script>
// only for demo purposes
$.validator.setDefaults({
	submitHandler: function() {
		alert("submitted!");
	}
});

$().ready(function() {
	// validate the form when it is submitted
	var validator = $("#form1").validate({
		errorPlacement: function(error, element) {
			// Append error within linked label
			$( element )
				.closest( "form" )
					.find( "label[for='" + element.attr( "id" ) + "']" )
						.append( error );
		},
		errorElement: "span",
		messages: {
			user: {
				required: " (required)",
				minlength: " (must be at least 3 characters)"
			},
			password: {
				required: " (required)",
				minlength: " (must be between 5 and 12 characters)",
				maxlength: " (must be between 5 and 12 characters)"
			}
		}
	});

	$(".cancel").click(function() {
		validator.resetForm();
	});
});
</script>
</head>
<body>
<h1 id="banner"><a href="http://jqueryvalidation.org/">jQuery Validation Plugin</a> Demo</h1>
<div id="main">
<p>Errors use spans placed within existing label element</p>
<form method="get" class="cmxform" id="form1" action="">
<fieldset>
<legend>Login Form</legend>
<p>
<label for="user">Username</label>
<input id="user" name="user" required minlength="3">
</p>
<p>
<label for="password">Password</label>
<input id="password" type="password" maxlength="12" name="password" required minlength="5">
</p>
<p>
<input class="submit" type="submit" value="Login">
</p>
</fieldset>
</form>
<a href="index.html">Back to main page</a>
</div>
</body>
</html>
