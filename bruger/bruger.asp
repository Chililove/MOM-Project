<!--#include file="../login/protect.inc"-->
<!--#include file="../opendb.asp"-->
<!--#include file="../shared/global.css"-->
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
		<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.3/jquery.validate.min.js"></script>


	</head>
	<style>
span.error {
    color: red;
    font-size: 16px;
    font-weight: normal;
    line-height: 1.4;
    margin-top: 0.5em;
    display: block;
}

	.error-tooltip {
    position: relative;
    display: inline-block;
}

.error-tooltip span.error {
    position: absolute;
    left: 100%;
    top: 0;
    white-space: nowrap;
    background-color: #f2dede;
    color: #a94442;
    padding: 5px;
    border-radius: 4px;
    border: 1px solid #ebccd1;
    z-index: 10;
    margin-left: 10px; /* Space between the input and tooltip */
}
	</style>
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
										<input name="login" type="text" size="25" style="min-width: 720px;"

										<%if request("action")="ret" then%>
										value="<%=login%>" 
										<%end if%>
										required></td>
									</tr>
								<!-- Fornavn -->
									<tr>
										<td style="text-align: center">
										Fornavn</td>
									</tr>
									<tr>
										<td style="text-align: center">
										<div class="input-wrapper">
										<input name="fornavn" type="text" size="25" style="min-width: 720px;" value="<%=fornavn%>" required ></td>
										</div>
									</tr>
								<!-- Efternavn -->
									<tr>
										<td style="text-align: center">
										Efternavn</td>
									</tr>
									<tr>
										<td style="text-align: center">
									<div class="input-wrapper">
										<input name="efternavn" type="text" size="25" style="min-width: 720px;" value="<%=efternavn%>" required ></td>
									</div>
									</tr>
									<!--Email-->
									<tr>
										<td style="text-align: center">
										Email</td>
									</tr>
									<tr>
										<td style="text-align: center">
									<div class="input-wrapper">
										<input name="mailadresse" type="text" size="25" style="min-width: 720px;" value="<%=mailadresse%>" required ></td>
									</div>
									</tr>
								<!-- Password -->

									<tr>
										<td style="text-align: center">
										Password:</td>
									</tr>
									<tr>
										<td style="text-align: center">
										<div class="input-wrapper">
										<input name="password1" type="text" size="25" style="min-width: 720px;" value="<%=password1%>" required ></td>
									</div>
									
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

								<script>
$(document).ready(function() {
	$.validator.addMethod("patternEmail", function(value, element) {
    return this.optional(element) || /^[a-zA-Z0-9._%+-]+@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,}$/.test(value);
}, "Dette er ikke en gyldig email.");

    $('form').validate({
        rules: {
            login: {
                required: true,
                minlength: 2
            },
            fornavn: {
                required: true,
                minlength: 2
            },
            efternavn: {
                required: true,
                minlength: 2
            },
			mailadresse: {
                required: true,
                minlength: 2,
				email: true,
				patternEmail: true

            },
            password1: {
                required: true,
                minlength: 2
            },
            id_logintype: {
                required: true
            }
        },
        messages: {
            login: {
                required: "Login navn er påkrævet.",
                minlength: "Login skal være mindst 2 tegn."
            },
            fornavn: {
                required: "Fornavn er påkrævet.",
                minlength: "Fornavn skal være mindst 2 tegn."
            },
            efternavn: {
                required: "Efternavn er påkrævet.",
                minlength: "Efternavn skal være mindst 2 tegn."
            },
			 mailadresse: {
                required: "Email er påkrævet.",
                minlength: "Email skal være mindst 2 tegn.",
				email: "Dette er ikke en gyldig email.",
				patternEmail: "Dette er ikke en gyldig email."
            },
            password1: {
                required: "Password er påkrævet.",
                minlength: "Password skal være mindst 2 tegn."
            },
            id_logintype: {
                required: "Type af login er påkrævet."
            }
        },
		 errorElement: 'span',  // Specify the element for the error text
        errorPlacement: function (error, element) {
             if (element.prop('tagName').toLowerCase() !== 'select') {
        var tooltipWrapper = $('<div class="error-tooltip"></div>');
        element.wrap(tooltipWrapper);
        error.insertAfter(element);
    } else {
        error.insertAfter(element); // Just place the error after the select without wrapping it.
    }
}

    });
});

</script>
							</form>
						
						<!--#include file="../shared/footer.asp"-->
		</div>
	</body>

</html>
<!--#include file="../closedb.asp"-->