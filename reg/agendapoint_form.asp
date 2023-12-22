<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>MoM</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.3/jquery.validate.min.js"></script>
<link rel="stylesheet" href="jquery/jquery.mobile-1.4.5.css">
<link rel="stylesheet" href="../shared/global.css">

<!--
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<link rel="stylesheet" href="../shared/global.css">
<script src="../jquery/jquery-1.8.2.min.js"></script>
<script src="../jquery/jquery.mobile-1.4.5.min.js"></script>-->
<link href="https://cdn.quilljs.com/1.3.6/quill.snow.css" rel="stylesheet">
<script src="https://cdn.quilljs.com/1.3.6/quill.js"></script>

<style>
@keyframes fade-in {
    from {
        opacity: 0;
        transform: scale(0);
    }

    to {
        opacity: 1;
        transform: scale(1);
    }
}

.fade-in {
    animation: fade-in 1s;
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
	em {
	color: red;
	font-weight: bold;
	padding-right: .25em;
	}

 span.error {
    color: red;
    font-size: 16px;
    font-weight: normal;
    line-height: 1.4;
    margin-top: 0.5em;
    display: block;
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
            border: 1px solid #ccc;
            background-color: #f9f9f9;
            width: 400px; /* Set width of the dropdown */
            max-height: 400px; /* Maximum height */
            overflow-y: auto; /* Make it scrollable if content is too long */
            position: absolute;
            z-index: 10;
            box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2); /* Optional: Adds a shadow to make it look like a pop-up */
            padding: 15px; /* Optional: Adds some padding inside */
            }

        .positioned-dropdown {
            /* Adjusting the position if required */
            left: auto !important;
            right: 0 !important;
        }

            label {
            display: block;
            margin: 10px 0;
            }

            .label-container {
                flex: 0 0 50%;
                margin-bottom: 10px;
                
            /*flex: 1 1 50%;
            box-sizing: border-box;
            padding: 5px;*/
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
                display: flex;
                align-items: center;
            width: 60%;
            }

            .user-list-container{
                display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
            }
            .checkuser{
                align-items: center;
            }

            select + .error-dot {
            top: 10px;    /* adjust as needed */
            right: 10px; /* adjust as needed */
        }
        td{
            position: relative;
        }

        .assigned-users{
            position: static;
        }

        .input-wrapper{
            position: relative;
        }

        .overlay {
            position: fixed;
            top: 0;
            left: 0;
            height: 100%;
            width: 100%;
            background-color: rgba(0,0,0,0.5);
            display: none;
            z-index: 1000;
        }

        .modal {
        display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.5);
            z-index: 1000;

        }

        .modal-content {
            position: absolute;
            align-items: center;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            max-height: 400px;
            overflow-y: auto;
            width: 80%;
            max-width: 500px;	
        }

        .close-button {
            position: absolute;
            top: 10px;
            right: 20px;
            cursor: pointer;
        }

        body.modal-open .modal {
            display: block;
        }

        .close-modal {
            display: inline-block;
            padding: 0.5em 1em;
            background-color: #f44336;
            color: white;
            border: none;
            cursor: pointer;
            float: right; // Makes it appear at the top right corner of the modal.
        }

        .close-modal:hover {
            background-color: #d32f2f;
        }

        .error-dot {
            display: inline-block;
            width: 18px;
            height: 18px;
            background-color: red;
            border-radius: 50%;
            position: absolute;
            top: 10px;    /* half of its size to be outside of the input box */
            right: 34px;  /* half of its size to be outside of the input box */
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


        .select-error-dot {
            display: inline-block;
            width: 18px;
            height: 18px;
            background-color: red;
            border-radius: 50%;
            position: absolute;
            top: 22px;    
            right: 34px;
            cursor: pointer;
            z-index: 10;
        }

        .select-error-dot:hover::before {
            content: attr(title);
            background-color: #333;
            color: #fff;
            padding: 3px 6px;
            border-radius: 4px;
            position: absolute;
            left: 120%;
            bottom: 100%;
            transform: translateX(-50%);
            white-space: nowrap;
            pointer-events: none;
            z-index: 100;
        }

  @keyframes fadeIn {
    0% {
        opacity: 0;
    }
    100% {
        opacity: 1;
    }
}

          @keyframes fadeInLogo {
  0% {
    opacity: 1; /* Start with 0% opacity */
    transform: scale(1); 
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

}

#imglogo{
  height: 40%;
  width: 40%;
  margin-top: -13%;
  transform: scale(0.8);
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

/* Tablet styles */
@media screen and (min-width: 768px) {
  /* Add styles for tablets and larger screens */
  .container {
    width: 80%; /* Adjusted width for tablets */
  }


  /* Additional tablet-specific styles */
}

/* Desktop styles */
@media screen and (min-width: 1024px) {
  /* Add styles for desktop screens */
  .container {
    width: 70%; /* Adjusted width for desktops */
  }
  }

  button span {
    user-select: none;
    pointer-events: none;
}

</style>

</head>
<form data-ajax="false" method="post" 
	<% if request.QueryString("action")="show" then %>
	    action='save_agendapoints.asp?action=edit&id_agendapoint=<%=request.QueryString("id_agendapoint")%>'  
	<% else %>
        action='save_agendapoints.asp?action=<%=request.QueryString("action")%>&id_agenda=<%=request.QueryString("id_agenda")%>'  
	<% end if %>
    >
    
    <% if request("action")="show" then %>
        <% sql="Select * from tbl_agendapoints where id_agendapoint = '"& request.QueryString("id_agendapoint") &"'"
            'response.write sql
            set rs = Conn.execute(sql)
            datoOG=rs("dato")
            dato=ConvertDateFormat(rs("dato"))
            point_name=rs("point_name")
            short_desc=rs("short_desc")
            long_desc=rs("long_desc")
            id_login=rs("id_login")
            id_agenda=rs("id_agenda")
            id_company=rs("id_company")
        
            response.write("Companyid: " & id_company & "<br>")

        end if %>
         <h2 style="height: .5px; text-align: center; padding: 3%;">Submit agenda point</h2>

<table align="center" style="width: 50%">
    <!-- Møde dato og tid-->
        <tr class="fade-in" style="animation-duration: 200ms;">
            <td style="text-align: center">
                <div style="display:flex;">
                    <div style="width:50%">Deadline date
                        <div class="input-wrapper">
                        <input type="date" name="date"
                        <% if  request("action")="show" then %>
                            <% if  NOT IsNull(rs("dato"))=true then %>
                                    value="<%=rs("dato")%>"
                            <% else %>
                                value=""
                            <% end if %>
                            
                        <% else %>
                                value=""
                        <% end if %> style="min-width: 360px;" >
                    </div>
                </div>
            </td>
        </tr>
    <!-- Møde navn -->
        <tr class="fade-in" style="animation-duration: 300ms;">
            <th style="text-align: center">Name of agendapoint</th>

            <% Function ConvertDateFormat(inputDate)
                Dim dateParts
                dateParts = Split(inputDate, "-")
                    If UBound(dateParts) = 2 Then
                        ConvertDateFormat = dateParts(2) & "-" & dateParts(1) & "-" & dateParts(0)
                    Else
                        ConvertDateFormat = inputDate ' return original if format is unexpected
                    End If
            End Function %>

            <% Function ExtractHoursMinutes(timeStamp)
                Dim timeParts, timeString
                timeParts = Split(timeStamp, " ") ' Split date from time
                    If UBound(timeParts) >= 1 Then
                        timeString = timeParts(1) ' This should be HH:mm:ss
                        ExtractHoursMinutes = Left(timeString, 5) ' This will return HH:mm
                    Else
                        ExtractHoursMinutes = ""
                    End If
            End Function %>

            <td>
                <input type="hidden" name="id_agendapoint" value="<%=id_agendapoint1%>">
            </td>	
        </tr>

    <!-- Møde punkt -->
        <tr class="fade-in" style="animation-duration: 400ms;">			
            <td style="text-align: center">
                <div class="input-wrapper">
                    <input name="point_name" type="text"
                    <% if  request("action")="show" AND NOT IsNull(point_name) then %>
                        value="<%=point_name%>"
                    <% else %>
                        value=""
                    <% end if %>
                        style="width: 720px">
                </div>
            </td>
        </tr>

    <!-- Møde emne -->
        <tr class="fade-in" style="animation-duration: 500ms;">
            <th style="text-align: center">
                Short description
            </th>
        </tr>
        <tr class="fade-in" style="animation-duration: 600ms;">
            <td style="text-align: center">
                <div class="input-wrapper">
                <input name="short_desc" type="text" value="<%=short_desc%>" style="width: 720px">
                </div>
            </td>
        </tr>
    <!-- Møde beskrivelse -->
        <tr class="fade-in" style="animation-duration: 700ms;">
            <th style="text-align: center">
                Long description
            </th>
        </tr>
        <tr class="fade-in" style="animation-duration: 800ms;">
            <td style="text-align: center">
                <div class="input-wrapper">
                    <input type="text" name="long_desc" value="<%=long_desc%>">
                </div>
            </td>
        </tr>


    <!-- Assigned to agendapoint users -->
        <tr class="fade-in" style="animation-duration: 900ms;">
            <td class="assigned-users" style="text-align: center;">
                <!-- Button to open modal -->
                <button type="button" style="z-index: 1;" class="toggle-button">Assign employees</button>

                <!-- Modal -->
                <div class="modal">
                    <div class="modal-content">

                        <!-- Close button -->
                        <span class="close-button">&times;</span>

                        <!-- Populating user list -->
                        <div class="user-list-container">
                            <div class="user-list">
                                <% SQL3 = "SELECT * FROM tbllogin WHERE id_company = '" & session("id_company") & "' ORDER BY id_login"
                                    Set objRS3 = conn.Execute(SQL3)
                                    While Not objRS3.EOF
                                        If Request("action") = "show" Then
                                        participants = Split(rs("id_login"), ",")
                                        checked = "" 
                                    If Not IsNull(rs("id_login"))=true And rs("id_login") <> "" Then 
                                            For Each participant In participants
                                                If Trim(CStr(participant)) = Trim(CStr(objRS3("id_login"))) Then
                                                    checked = "checked"
                                                    Exit For ' exit the loop if a match is found
                                                End If
                                            Next
                                        End If
                                        End If %>
                                        <div class="label-container">
                                            <label class="user-item">
                                                <input type="checkbox" name="id_login" class="checkuser" value="<%=objRS3("id_login")%>" <%=checked%>>
                                                <%=objRS3("login")%><br>
                                                <%=objRS3("fornavn")%>&nbsp;<%=objRS3("efternavn")%>
                                            </label>
                                        </div>
                                    <% objRS3.MoveNext
                                    Wend
                                    objRS3.Close %>
                            </div>
                        </div>
                    </div>
                </div>
            </td>
        </tr>

    <!-- Agendapoint submit btn -->
        <tr class="fade-in" style="animation-duration: 1000ms;">
            <td style="text-align: center">
                <input type="hidden" name="id_company" value='<%=session("id_company")%>'>
                <input type="hidden" name="id_agenda" value='<% if LEN(request.QueryString("id_agenda"))>0 then %><%=request.QueryString("id_agenda")%><% else %><%=session("id_agenda")%><% end if %>'>
                <% If Request.QueryString("action") = "show" Then %>
                    <input name="Submit2" type="submit" value="Update agenda point" data-theme="a" data-icon="check">
                    <button type="button" id="deleteButton" value="Delete agenda point" data-theme="a" data-icon="delete">Delete agenda point</button>
                <% else %>
                    <input name="Submit2" type="submit" value="Create new agenda point" data-theme="a" data-icon="check">
                <%end if %>
                <!--This is how I can save multiple users to an agenda -->
                <%If Request.ServerVariables("REQUEST_METHOD") = "POST" Then
                        Dim selectedUsersPoints
                        selectedUsersPoints = Request.Form("id_login")
                        If IsArray(selectedUsersPoints) Then
                            ' Multiple checkboxes were selected
                            For Each user In selectedUsersPoints
                                Response.Write("Selected User ID: " & user & "<br />")
                            Next
                        Else
                            ' Just one checkbox was selected
                            Response.Write("Selected User ID: " & selectedUsersPoints & "<br />")
                        End If
                End If %>
            </td>
        </tr>
</table>
 <div id="logo">
                <img id="imglogo"src="../Login/Game-On.png" />
            </div>	
<script>
    document.addEventListener("DOMContentLoaded", function() {
        const modal = document.querySelector(".modal");
        const modalContent = document.querySelector(".modal-content");
        const toggleButton = document.querySelector(".toggle-button");
        const closeButton = document.querySelector(".close-button");

        // Function to show the modal
        function showModal() {
            modal.style.display = "block";
        }

        // Function to close the modal
        function closeModal() {
            modal.style.display = "none";
        }

        // Click event to show the modal
        toggleButton.addEventListener("click", showModal);

        // Click event to close the modal
        closeButton.addEventListener("click", closeModal);

        // Close the modal if clicked outside of it
        window.addEventListener("click", function(event) {
            if (event.target === modal) {
                closeModal();
            }
        });
    });

    document.getElementById("deleteButton").addEventListener("click", function() {
            console.log("Delete button clicked");

        var r = confirm("Are you sure you want to delete this agenda point?");
        if (r == true) {
            var formData = new FormData();
            formData.append("action", "delete");

            fetch("/reg/save_agendapoints.asp?action=delete&id_agendapoint=<%=id_agendapoint%>", {
                method: "POST",
                body: formData
            })
            .then(function(response) {
                if (response.ok) {
                    alert("Agenda point deleted successfully.");
                    // Redirecting to the list page or I could do another action?'
                    window.location.href = "/reg/nextstep_agenda_dropdown_page.asp";
                } else {
                    alert("An error occurred during agenda point deletion.");
                }
            })
            .catch(function(error) {
                console.error("Error:", error);
            });
        }
    });

    $(document).ready(function() {
        // Custom method for validating dates If they are in the past you cannot create an agenda in the past.
        $.validator.addMethod("dateGreaterThanOrEqualToday", function(value, element) {
            const currentDate = new Date();
            currentDate.setHours(0, 0, 0, 0);
            const inputDate = new Date(value);
            <%If request("action")="show" Then%>
            return inputDate;
            <%Else%>
            
            return inputDate >= currentDate;
            <%end if%>
            
        }, "Please choose a date in the future.");

        $('form').validate({
            rules: {
                dato: {
                    required: true,
                    dateISO: true,
                    dateGreaterThanOrEqualToday: true
                },
                point_name: {
                    required: true,
                    minlength: 2
                },
                id_login: {
                    required: true
                },
                short_desc: {
                    required: true,
                    minlength: 2
                },
                long_desc: {
                    required: true,
                    minlength: 5
                }
            },
            messages: {
                dato: {
                    required: "Date is required.",
                    dateISO: "This is not a valid date.",
                    dateGreaterThanOrEqualToday: "Choose todays date or a date in the future."
                },
                point_name: {
                    required: "Agendapoint title is required",
                    minlength: "Agendapoint title must be atleast 2 characters."
                },
                id_login: {
                    required: "Login is required."
                },
                short_desc: {
                    required: "Description is required.",
                    minlength: "Description must be atleast 2 characters."
                },
                long_desc: {
                    required: "Longer description is required.",
                    minlength: "Description must be atleast 5 characters."
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
		


