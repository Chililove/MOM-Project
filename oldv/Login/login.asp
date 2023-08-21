
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
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252" />
<title>OneTimer</title>
<meta name="viewport" content="width=device-width, initial-scale=1"/>
<link rel="stylesheet" href="../jquery/jquery.mobile-1.4.5.css" />
<link rel="stylesheet" href="../shared/global.css" />
<script src="../jquery/jquery-1.8.2.min.js"></script>
<script src="../jquery/jquery.mobile-1.4.5.min.js"></script>
<script>
function openPopup() {
				document.getElementById('popup').style.display = 'block';
			}
function closePopup() {
    document.getElementById('popup').style.display = 'none';
}
</script>

</head>
<% if s=1 then %>
<body onload="openPopup()">         
<% else %>
<body>         
<% end if %>
<div id='fpimg'>
        <img src="Game-On.png"/>
</div>

    <div id="popup" class="popup">
        <div class="popup-content">
            <p>  <%=strERR%> </p>
            <button onclick="closePopup()">OK</button>
        </div>
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
<input name="login"  type="text" value="" placeholder="Login">
</td>
				</tr>
				<tr>
								<td>
<input name="password"  type="password" value="" id="password" placeholder="Password">
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
<script>

</script>

<input type="submit" value="Lost Password" data-theme="a" data-icon="phone" name="Action" >
<!--<button id="knap1" class="knap">Cancel</button>
<button id="knap2"  class="knap">Cancel</button>
<button id="knap3"  class="knap">Cancel</button>
<a href="hej" class="nodecor">HEj</a>-->
</td>
				</tr>
</table>
</form>
</form>
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
</style>

</html>
