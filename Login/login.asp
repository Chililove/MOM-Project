
<!--#include file="login.inc"-->
<%
'luk session
Session.Abandon 
Response.Buffer = True
Response.ExpiresAbsolute = Now() - 1
Response.Expires = 0
Response.CacheControl = "no-cache"

Session("s1")=""
Session("s2")=""
Session("s3")=""
Session("s4")=""
Session("s5")=""
Session("s6")=""
Session("s7")=""
Session("s8")=""
Session("user")=""

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>OneTimer</title>
<meta name="viewport" content="width=device-width, initial-scale=1"/>
<link rel="stylesheet" href="../jquery/jquery.mobile-1.4.5.css" />
<link rel="stylesheet" href="../shared/global.css" />
<script src="../jquery/jquery-1.8.2.min.js"></script>
<script src="../jquery/jquery.mobile-1.4.5.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.3/jquery.validate.min.js"></script>


</head>

  <div id='fpimg'>
        <img src="Game-On.png"/>
  </div>

<form id="loginform" method="POST" action="login.asp" target="_top">
  <div data-role="footer" data-id="footer" data-position="fixed">
    <h1>MoM Login</h1>  
  </div>

    
<table align="center" >
       <!-- <tr>
          <%' If LEN(strERR)<1 Then %>
            <td>
            <%'=strERR%>
          <%' Else %> 
            <td style="background-color: red; text-shadow:none;">
            <%'=strERR%>
          <%' End If %>
            </td>
        </tr>-->
	<tr>
			<td>
          <div class="input-wrapper">
            <input name="login"  type="text" value="" placeholder="Login">
          </div>
      </td>
	</tr>
	<tr>
			<td>
          <div class="input-wrapper">
            <input name="password"  type="password" value="" id="password" placeholder="Password">
          </div>

	<span onclick="togglePasswordVisibility()" style="cursor: pointer; padding: 5px 5px; color: grey; opacity: 60%; border: 1px solid #ccc; border-radius: 5px;" id="showHideButton" >Show password inputs</span>

	<script>
	  function togglePasswordVisibility() {
      var passwordInput = document.getElementById('password');
	    var showSpan = event.target;
    if (passwordInput.type === "password") {
        passwordInput.type = "text";
	      showSpan.textContent= "Hide";
	  
    } else {
        passwordInput.type = "password";
	      showSpan.textContent= "Show";
    }
  }
	</script>

	    </td>
	</tr>
	<tr>
			<td>
	      <input type="submit" value="Login" data-theme="a" data-icon="check" name="Action">
	    </td>
	</tr>
	<tr>
			<td >
		    <form method="POST" action="login_glemt.asp" target="_top">

<input type="submit" value="Lost Password" data-theme="a" data-icon="phone" name="Action" >
      </td>
				</tr>
</table>
</form>

</form>
<script>
$(document).ready(function() {
    $('form').validate({
        rules: {
            login: {
                required: true,
                minlength: 2
            },
            password: {
                required: true,
                minlength: 2
            }  
        },
        messages: {
            login: {
                required: "Login er påkrævet.",
                minlength: "Login skal have mindst 2 tegn"
            },
            password: {
                required: "Password er påkrævet.",
                minlength: "Password skal have mindst 2 tegn"
            }
        },
	 	
		errorElement: 'span',
errorPlacement: function (error, element) {
    var errorMessage = error.text();

    if (!$(element).next('.error-dot').length && !$(element).closest('td').find('.select-error-dot').length) {
        if (element.is('select')) {
            //create the red dot
            var errorDot = $('<span class="select-error-dot" title=""></span>').attr('data-error', errorMessage);
            errorDot.attr('title', errorMessage);
            // Insert the red dot after the select element for selection
            errorDot.appendTo(element.closest('td'));
        } else {
            // For non-select elements, create the normal red dot
            var errorDot = $('<span class="error-dot" title=""></span>').attr('data-error', errorMessage);
            errorDot.attr('title', errorMessage);
            // Insert the red dot after the form element
            errorDot.insertAfter(element);
        }
    }
},
highlight: function (element) {
        // Show the error dot when there's an error.
    },
    unhighlight: function (element) {
        // Hide the error dot when the error is corrected.
        if ($(element).is('select')) {
            $(element).closest('td').find('.select-error-dot').remove();
        } else {
            $(element).next('.error-dot').remove();
        }
    },
	onkeyup: function(element) {
        $(element).valid();
    }
});
    });
</script>
<!-- wrap inside DOMcontentloaded to ensure script runs after page has been fully loaded safe manipulation of DOM elements -->
<script> document.addEventListener('DOMContentLoaded', function() {
  var inputs = document.querySelectorAll('input[type="text"], input[type="password"]');

  inputs.forEach(function(input) {
    input.addEventListener('focus', function() {
      this.style.backgroundColor = '#e0f2f1';
      this.style.transition = 'background-color 0.5s ease';
    });

    input.addEventListener('blur', function() {
      this.style.backgroundColor = 'transparent';
    });
  });
});
</script>
</body>
<style>
body {
  background-color: #e0e0e0;
  font-family: 'Roboto', sans-serif;
  margin: 0;
}

form {
  max-width: 350px;
  margin: 50px auto;
  margin-top: 8%;
  padding: 30px;
  background-color: #ffffff;
  box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
  border-radius: 10px;
}

div[data-role="footer"] {
  text-align: center;
  padding: 10px;
  background-color: #4CAF50;
  color: #ffffff;
  font-size: 20px;
  border-radius: 10px 10px 0 0;
}

table {
  width: 100%;
  border-spacing: 0;
  padding: 20px;
}

td {
  padding: 10px 0;
}

label {
  display: block;
  font-weight: 600;
  margin-bottom: 5px;
}
label.error {
	color: red;
	font-size: 16px;
	font-weight: normal;
	line-height: 1.4;
	margin-top: 0.5em;
	width: 100%;
	float: none;
	display: none;
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
	}
	em {
	color: red;
	font-weight: bold;
	padding-right: .25em;
	}

input[type="text"],
input[type="password"] {
  width: 100%;
  padding: 12px;
  border: 2px solid rgba(255, 255, 255, 0.5);
  background: transparent;
  border-radius: 4px;
  font-size: 14px;
  transition: border-color 0.5s ease;
}

input[type="text"]:focus,
input[type="password"]:focus {
  border-color: #76d275;
}

input[type="submit"] {
  width: 100%;
  padding: 14px;
  border: none;
  background-color: #4CAF50;
  color: #ffffff;
  font-size: 16px;
  cursor: pointer;
  border-radius: 6px;
  transition: background-color 0.3s ease;
}

input[type="submit"]:hover {
  background-color: #45a049;
}

input[type="submit"][data-icon="phone"] {
  background-color: #f44336;
}

input[type="submit"][data-icon="phone"]:hover {
  background-color: #e43629;
}


 input::placeholder {
    font-size: 18px; /* Change this value to your desired size */
    color: #888; /* Optional: Change color of placeholder text */
  }

#logo{
	color: black;

}
span.error {
    color: red;
    font-size: 16px;
    font-weight: normal;
    line-height: 1.4;
    margin-top: 0.5em;
    display: block;
}
.error-dot {
    display: inline-block;
    width: 18px;
    height: 18px;
    background-color: red;
    border-radius: 50%;
    position: absolute;
    top: 14px;    /* half of its size to be outside of the input box */
    right: 10px;  /* half of its size to be outside of the input box */
    cursor: pointer;
    z-index: 10;
}


.error-dot:hover::before {
    content: attr(title);
    background-color: #333;
    color: #fff;
    padding: 5px 8px;
    border-radius: 4px;
    position: absolute;
    left: 50%;
    bottom: 0%;
    transform: translateX(0);
    white-space: nowrap;  /* keeps the tooltip text in one line */
    pointer-events: none; /* ensures the tooltip doesn't interfere with interactions */
    opacity: 0.8;
    z-index: 100;
}

.input-wrapper{
	position: relative;
}
</style>

</html>
