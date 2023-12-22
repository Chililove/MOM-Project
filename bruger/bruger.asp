<!--#include file="../login/protect.inc"-->
<!--#include file="../opendb.asp"-->
<%
' Check if the user is an administrator
'If Not session("administrator") Then
    ' If not an administrator, redirect them to an error page or some other action
  '  Response.Redirect("../default.asp?accessDenied=true") 
'End If
%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; chaRset=UTF-8">
		<title>OneTimer</title>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="stylesheet" href="../jquery/jquery.mobile-1.4.5.css">
        <link rel="stylesheet" href="../shared/global.css">
    
		<script src="../jquery/jquery-1.8.2.min.js"></script>
		<script src="../jquery/jquery.mobile-1.4.5.min.js"></script>
		<link type="text/css" rel="stylesheet" href="../jquery/jquery-te-1.4.0.css">
		<script type="text/javascript" src="../jquery/jquery-te-1.4.0.min.js" chaRset="utf-8"></script>
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
@keyframes fadeIn {
    0% {
        opacity: 0;
    }
    100% {
        opacity: 1;
    }
}
 .fade-in{
    animation: fadeIn ease 2s;
 }
      @keyframes fadeInLogo {
  0% {
    opacity: 0; /* Start with 0% opacity */
    transform: scale(1); /* Start slightly scaled down */
  }
  100% {
    opacity: 1; /* End with 100% opacity */
    transform: scale(0.8); /* End with original scale (1) */
  }
}

#logo{
display: flex;
justify-content: center;
align-items: center;
perspective: 1000px;
margin-left: 240px;

}

#imglogo{
  height: 40%;
  width: 40%;
  margin-top: -13%;
  margin-right: 250px;
  margin-top: -130px;
  transform: scale(0.8);
  margin-bottom: -120px;
  animation: fadeInLogo 2s ease;
  
}
@media (max-width: 800px) {
  #imglogo img {
    left: 50%;
    top: 25%;
    transform: translate(-50%, -50%);
    height: 250px;
    width: 250px;
  }
}

/* applying  fadeIn animation to element */
.element {
    animation: fadeIn 2s ease-in-out;
}
	</style>
	<body>
		<div id="page1" data-role="page">
		<!-- header -->
			<div data-role="header" data-id="header" data-position="fixed">
					<%if request("action")="ret" then%>
					<!--#include file="alle_felter.asp"-->
					<h1>Update user</h1>
					<%else%>
					<h1>Create user</h1>
					<%end if%>
				<a class="ui-btn-left" href="../default.asp" data-ajax="false" data-icon="home">
					Home
				</a> 
			</div>
            <%if request("action")="opret" then%>
            <h2 class="fade-in" style="text-align: center; padding: 1%; animation-duration: 200ms;">Create user here </h2>
            <%else%>
            <h2 class="fade-in" style="text-align: center; padding: 1%; animation-duration: 200ms;">Update user here </h2>
            <%end if %>

		<!-- form -->
			<form id="userForm" data-ajax="false" method="post" 
            <% if request.querystring("default")="yes" then %>
            action='save.asp?default=yes&action=<%=request("action")%>'
            <% else %>
            action='save.asp?action=<%=request("action")%>'
            <% end if %> >
				<table align="center" style="width: 50%">
								<!-- Login -->
					<tr class="fade-in" style="animation-duration: 300ms;">
						<th style="text-align: center">
							Login
						</th>
					</tr>
					<tr class="fade-in" style="animation-duration: 400ms;">
						<td style="text-align: center">
							<input name="login" type="text" size="25" style="min-width: 720px;"
								<%if request("action")="ret" then%>
								value="<%=login%>" 
								<%end if%>
								required>
						</td>
					</tr>
								<!-- Fornavn -->
					<tr class="fade-in" style="animation-duration: 500ms;">
						<td style="text-align: center">
							Firstname
						</td>
					</tr>
					<tr class="fade-in" style="animation-duration: 600ms;">
						<td style="text-align: center">
							<div class="input-wrapper">
								<input name="fornavn" type="text" size="25" style="min-width: 720px;" value="<%=fornavn%>" required >
								</div>
								</td>
							
					</tr>
								<!-- Efternavn -->
					<tr class="fade-in" style="animation-duration: 700ms;">
						<td style="text-align: center">
							Lastname
						</td>
					</tr>
					<tr class="fade-in" style="animation-duration: 800ms;">
						<td style="text-align: center">
							<div class="input-wrapper">
								<input name="efternavn" type="text" size="25" style="min-width: 720px;" value="<%=efternavn%>" required >
						</div>
						</td>
							
					</tr>
									<!--Email-->
					<tr class="fade-in" style="animation-duration: 900ms">
						<td style="text-align: center">
										Email
						</td>
					</tr>
					<tr class="fade-in" style="animation-duration: 1000ms">
						<td style="text-align: center">
							<div class="input-wrapper">
								<input name="mailadresse" type="text" size="25" style="min-width: 720px;" value="<%=mailadresse%>" required >
						</div>
						</td>
							
					</tr>
								<!-- Password -->

					<tr class="fade-in" style="animation-duration: 1100ms;">
						<td style="text-align: center">
										Password
						</td>
					</tr>
					<tr class="fade-in" style="animation-duration: 1200ms;">
						<td style="text-align: center">
							<div class="input-wrapper">
								<input name="password1" type="password" size="25" style="min-width: 720px;" value="<%=password1%>" required >
						</div>
						</td>
							
									
					</tr>
								<!-- Profil -->
					<tr class="fade-in" style="animation-duration: 1300ms;">
						<td style="text-align: center">
										Profil
						</td>
					</tr>



<tr class="fade-in" style="animation-duration: 1400ms;">
    <td style="text-align: center">
        <% 
        ' Check if the user is an admin and if the action is to edit or create
        If Session("administrator") Then 
            ' Admins get a dropdown to change the company
            ' If the action is edit, show the selected option
            If Request("action") = "ret" Then
                SQL3 = "SELECT * FROM tbllogintype ORDER BY logintype ASC"
                Set objRS3 = conn.Execute(SQL3)
        %>
                <select name="id_logintype" required>
                    <% 
                    While Not objRS3.EOF
                        If objRS3("id_logintype") = id_logintype Then
                    %>
                            <option selected value='<%=objRS3("id_logintype")%>'><%=objRS3("logintype")%></option>
                    <%
                        Else
                    %>
                            <option value='<%=objRS3("id_logintype")%>'><%=objRS3("logintype")%></option>
                    <%
                        End If
                        objRS3.MoveNext
                    Wend
                    objRS3.Close()
                    Set objRS3 = Nothing
                    %>
                </select>
        <%
            Else 
        %>
                <select name="id_logintype" required>
                    <% 
                    SQL3 = "SELECT * FROM tbllogintype ORDER BY logintype ASC"
                    Set objRS3 = conn.Execute(SQL3)
                    While Not objRS3.EOF
                    %>
                        <option value='<%=objRS3("id_logintype")%>'><%=objRS3("logintype")%></option>
                    <%
                        objRS3.MoveNext
                    Wend
                    objRS3.Close()
                    Set objRS3 = Nothing
                    %>
                </select>
        <%
            End If
        Else ' For non-admins, show the company name in a disabled input field
            SQL3 = "SELECT logintype FROM tbllogintype WHERE id_logintype = '" & Session("id_logintype") & "'"
            Set objRS3 = conn.Execute(SQL3)
            If Not objRS3.EOF Then
        %>
                <input type="text" name="logintype" value="<%=objRS3("logintype")%>" disabled>
        <%
            End If
            objRS3.Close()
            Set objRS3 = Nothing
        End If
        %>
    </td>
</tr>

								<!-- save btn -->
						<tr class="fade-in" style="animation-duration: 1500ms;">
							<td style="text-align: center">
                                <%if request("action")="ret" then%>
								<input name="Submit1" type="submit" value="Update user" data-theme="a" data-icon="check">
                                <%else%>
								<input name="Submit1" type="submit" value="Create user" data-theme="a" data-icon="check">
                                <%end if%>
                                <%if request("action")="ret" and Session("administrator") then%>
                                    <input type="hidden" name="id_login" value="<%=id_login%>">
                                    <input type="hidden" name="action" value="delete">
                                    <input type="button" value="Delete user" onclick="confirmDelete('<%=id_login%>');" data-theme="a" data-icon="delete">
                                <%end if%>
							</td>
						</tr>
				</table>

<div id="logo">
                <img id="imglogo"src="../Login/Game-On.png" />
            </div>	
<script>
 
        function confirmDelete(id_login) {
            var r = confirm("Are you sure you want to delete this user?");
            if (r == true) {
                var form = document.createElement("form");
                form.setAttribute("method", "post");
                form.setAttribute("action", "/bruger/save.asp");

                var hiddenIdField = document.createElement("input");
                hiddenIdField.setAttribute("type", "hidden");
                hiddenIdField.setAttribute("name", "id_login");
                hiddenIdField.setAttribute("value", id_login);
                form.appendChild(hiddenIdField);

                var hiddenActionField = document.createElement("input");
                hiddenActionField.setAttribute("type", "hidden");
                hiddenActionField.setAttribute("name", "action");
                hiddenActionField.setAttribute("value", "delete");
                form.appendChild(hiddenActionField);

                document.body.appendChild(form);
                form.submit();
            }
        }
        
        

$(document).ready(function() {
	$.validator.addMethod("patternEmail", function(value, element) {
    return this.optional(element) || /^[a-zA-Z0-9._%+-]+@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,}$/.test(value);
}, "This is not a valid email");

  // Fading in the form after the document is ready
            $('#userForm').addClass('fade-in');

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
            },
			id_company: {
                required: true
            }
        },
        messages: {
            login: {
                required: "Login name required.",
                minlength: "Login must be atleast 2 characters."
            },
            fornavn: {
                required: "Firstname is required.",
                minlength: "Firstname must be atleast 2 characters."
            },
            efternavn: {
                required: "Lastname is required.",
                minlength: "Lastname must be atleast 2 characters"
            },
			 mailadresse: {
                required: "Email is required.",
                minlength: "Email must be atleast 2 characters.",
				email: "This is not a valid email.",
				patternEmail: "This is not a valid email format."
            },
            password1: {
                required: "Password is required.",
                minlength: "Password must be atleast 2 characters."
            },
            id_logintype: {
                required: "Type of login is required."
            },
			 id_company: {
                required: "Company id is required."
            }
        },
		 errorElement: 'span',  // Specify the element for the error text
        errorPlacement: function (error, element) {
             if (element.prop('tagName').toLowerCase() !== 'select') {
        var tooltipWrapper = $('<div class="error-tooltip"></div>');
        element.wrap(tooltipWrapper);
        error.insertAfter(element);
    } else {
        error.insertAfter(element); 
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