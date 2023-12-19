<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>MoM</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.3/jquery.validate.min.js"></script>
<link rel="stylesheet" href="jquery/jquery.mobile-1.4.5.css">


<style>
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

</style>

</head>

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
	
	<% beskrivelse=NULL %>
	<% if request("action")="show" then %>
		<% sql="Select * from qry_agenda where id_agenda = '"& request.QueryString("id_agenda") &"'"
			'response.write sql
			set rs = Conn.execute(sql)
			moede_datoOG=rs("moede_dato")
			moede_dato=ConvertDateFormat(rs("moede_dato"))
			moede_tidspunktOG=rs("moede_tidspunkt")
			moede_tidspunkt=LEFT(rs("moede_tidspunkt"),5)
			moede_navn=rs("moede_navn")
			id_agenda=rs("id_agenda")
			oprettetaf=rs("oprettetaf")
			oprettetdato=date()
			emne=rs("emne")
			beskrivelse=rs("beskrivelse")
			noter=rs("noter")
			additionalinfo=rs("additionalinfo")
			id_meetingtype=rs("id_meetingtype")
			id_afdeling=rs("id_afdeling")
			id_login=rs("id_login")
			id_company=rs("id_company")
			'For showing that I get the right converted data back from db
			response.write("Converted date: " & moede_dato & "<br>")
			response.write("Converted time: " & moede_tidspunkt & "<br>")
			response.write("Companyid: " & id_company & "<br>")
			response.write("id_meetingtype: " & id_meetingtype & "<br>")

			
		%>
	<%else%>
			<%= "no data" %>
	<% end if%>

<form id="myForm"data-ajax="false" method="post"
	<% if request("action")="show" AND NOT request.QueryString("id1")="1"  then %>
	action='save.asp?action=edit&id_agenda=<%=request.QueryString("id_agenda")%>'  
	<% else if request.QueryString("id1")="1" then %>
	action='save.asp?action=edit&id1=1&id_agenda=<%=request.QueryString("id_agenda")%>'  
	<% else %>
	action='save.asp?action=<%=request("action")%>'  
	<% end if %>
	<% end if %>
	style="position: relative;">
			<table align="center" style="width: 50%">
			<!-- Møde dato og tid-->
				<tr>
					<td style="text-align: center">
									<%=moede_dato%>

						<div style="display:flex;">
							<div style="width:50%">Start dato
								<div class="input-wrapper">
								<input type="date" name="moede_dato"
						<% if  request("action")="show" then %>
							<% if NOT IsNull(moede_datoOG)=true then %>
									value="<%=moede_datoOG%>"
							<% else %>
								value=""
							<% end if %>
							readonly
						<% else %>
								value=""
						<% end if %> style="min-width: 360px;" >
							</div>
							</div>
							<div style="width:50%">Start tid
								<div class="input-wrapper">
								<input type="time" name="moede_tidspunkt" 
						<% if  request("action")="show" AND NOT IsNull(moede_tidspunktOG)=true then  %>
								value="<%=moede_tidspunkt%>"

								readonly
						<% else %>
								value=""
						<% end if %> style="min-width: 360px;">
							</div>
							</div>
						</div>
					</td>
				</tr>
			<!-- Møde navn -->
				<tr>
					<th style="text-align: center">Name of meeting</th>
					<td>
						<input type="hidden" name="id_agenda" value="<%=id_agenda1%>">
					</td>	
				</tr>

				<tr>			
					<td style="text-align: center">
						<div class="input-wrapper">
						<input name="moede_navn" type="text"
							<% if  request("action")="show" AND NOT IsNull(moede_navn) then %>
								value="<%=moede_navn%>"
							<% else %>
								value=""
							<% end if %>
								style="width: 720px">
						</div>
					</td>
				</tr>
			<!-- Møde subject meetingtype dropdown -->
				<tr>
					<td style="text-align: center">
						<select name="id_meetingtype" required >

						<% SQL3 = "Select * from tblmeeting_type where id_company = "&session("id_company")&" order by id_meetingtype"
						set objRS3 = conn.Execute(SQL3)

						if request("action")="show" then
							if NOT IsNull(id_meetingtype) then 
								SQL4 = "Select * from tblmeeting_type WHERE id_company = "&session("id_company")&" order by id_meetingtype"
								set objRS4 = conn.Execute(SQL4) 
								meeting_type = objRS4("meeting_type") %>
							<option selected="" value=""><%=meeting_type%></option>
						<% else %>
							<option selected="" value="">Select meeting type</option>
						<% end if %>
						<%  while not objRS3.EOF %>
								<option value='<%=objRS3("id_meetingtype")%>' 
									<% if objRS3("id_meetingtype") = id_meetingtype then %>selected
									<% end if %>>
									<%=objRS3("meeting_type")%>
								</option>
						<% objRS3.MoveNext
								Wend 
						else %>
								<option selected="" value="">Select meeting type</option>
							<% while not objRS3.EOF %>
								<option value='<%=objRS3("id_meetingtype")%>'>
									<%=objRS3("meeting_type")%>
								</option>
							<% objRS3.MoveNext %>
						<%  Wend %>
					<% end if %>
					</select>
	
					</td>
				</tr>
			<!-- Møde emne -->
				<tr>
					<th style="text-align: center">
						Subject
					</th>
				</tr>
				<tr>
					<td style="text-align: center">
						<div class="input-wrapper">
						<input name="emne" type="text" value="<%=emne%>" style="width: 720px">
						</div>
					</td>
				</tr>
			<!-- Møde beskrivelse -->
					<tr>
					<th style="text-align: center">
						Description
					</th>
				</tr>
				<tr>
					<td style="text-align: center">
						<div class="input-wrapper">
						<input name="beskrivelse" id="beskrivelseInput" value="<%=beskrivelse%>">
						</div>
					</td>
				</tr>

			<!-- Møde note -->
				<tr>
					<th style="text-align: center">
						Notes
					</th>
				</tr>
				<tr>
					<td style="text-align: center">
						<div class="input-wrapper">
						<textarea name="noter" rows="4" cols="50" style="min-width: 720px;"><%=noter%></textarea>
						</div>
					</td>
				</tr>
			<!-- Møde afdeling -->
				<tr>
					<td style="text-align: center">
						<select name="id_afdeling" required >

						<% SQL3 = "Select * from tbl_afdeling_2nd where id_company = "&session("id_company")&" order by id_afdeling"
						set objRS3 = conn.Execute(SQL3)

						if request("action")="show" then
							if NOT IsNull(id_afdeling) then 
								SQL4 = "Select * from tbl_afdeling_2nd WHERE id_company = "&session("id_company")&" order by id_afdeling"
								set objRS4 = conn.Execute(SQL4) 
								afdeling = objRS4("afdeling") %>
							<option selected="" value=""><%=afdeling%></option>
						<% else %>
							<option selected="" value="">Select Department</option>
						<% end if %>
						<%  while not objRS3.EOF %>
								<option value='<%=objRS3("id_afdeling")%>' 
									<% if objRS3("id_afdeling") = id_afdeling then %>selected
									<% end if %>>
									<%=objRS3("afdeling")%>
								</option>
						<% objRS3.MoveNext
								Wend 
						else %>
								<option selected="" value="">Select Department</option>
							<% while not objRS3.EOF %>
								<option value='<%=objRS3("id_afdeling")%>'>
									<%=objRS3("afdeling")%>
								</option>
							<% objRS3.MoveNext %>
						<%  Wend %>
					<% end if %>
					</select>
	
					</td>
				</tr>
			<!-- Møde deltagere -->
				<tr>
					<td class="assigned-users" style="text-align: center;">

						<!-- Button to open modal -->
						<button type="button" class="toggle-button">Assign employees</button>

						<!-- Modal -->
						<div class="modal">
							<div class="modal-content">

								<!-- Close button -->
								<span class="close-button">&times;</span>

								<!-- Populating user list -->
							<div class="user-list-container">
								<div class="user-list">
									<%
										SQL3 = "SELECT * FROM tbllogin WHERE id_company = '" & session("id_company") & "' ORDER BY id_login"
										'response.write sql3
										Set objRS3 = conn.Execute(SQL3)

										While Not objRS3.EOF

											If Request("action") = "show" Then
											participants = Split(rs("participants"), ",")
											checked = ""
											If Not IsNull(rs("participants"))=true And rs("participants") <> "" Then 
												For Each participant In participants
													If Trim(CStr(participant)) = Trim(CStr(objRS3("id_login"))) Then
														checked = "checked"
														Exit For ' exit the loop if a match is found
													End If
												Next
											End If
										End If
										%>
											<div class="label-container">
												<label class="user-item">
													<input type="checkbox" name="id_login" class="checkuser" value="<%=objRS3("id_login")%>" <%=checked%>>
													<%=objRS3("login")%><br>
													<%=objRS3("fornavn")%>&nbsp;<%=objRS3("efternavn")%>
												</label>
											</div>
										<%
											objRS3.MoveNext
										Wend
										objRS3.Close
										%>
								</div>
							</div>
							</div>
						</div>
					</td>
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

					</script>
				</tr>
			<!-- Møde info -->
				<tr>
					<th style="text-align: center">
						Additional information
					</th>
				</tr>
				<tr>
					<td style="text-align: center">
						<div class="input-wrapper">
						<textarea name="additionalinfo" rows="4" cols="50"><%=additionalinfo%></textarea>
						</div>
					</td>
				</tr>
	<script>
// 		document.querySelector('form').addEventListener('submit', function() {
//     // Get the Summernote editor content
//     var summernoteContent = $('#summernote').summernote('code');
    
//     // Set the hidden field value with the HTML content
//     document.querySelector('#beskrivelseInput').value = summernoteContent;

// });

				</script>
			<!-- Møde submit btn -->
				<tr>
					<td style="text-align: center">
						<input name="existing_id_registrering" type="hidden" value="<%=existing_id_registrering%>">
						<input type="hidden" name="oprettetaf" value='<%=session("id_login")%>'>
						<input type="hidden" name="id_company" value='<%=session("id_company")%>'>
						<% if request("action")="newday" then%>
						<input name="Submit1" type="submit" value="Start meeting" data-theme="a" data-icon="check">
						<%else%>
						<input name="Submit1" type="submit" value="Update meeting" data-theme="a" data-icon="check">
						<%end if%>
						
			<!--This is how I can save multiple users to an agenda-->
						<%If Request.ServerVariables("REQUEST_METHOD") = "POST" Then
							Dim selectedUsers
							selectedUsers = Request.Form("id_login")
							If IsArray(selectedUsers) Then
								' Multiple checkboxes were selected
								For Each user In selectedUsers
									Response.Write("Selected User ID: " & user & "<br />")
								Next
							Else
								' Just one checkbox was selected
								Response.Write("Selected User ID: " & selectedUsers & "<br />")
							End If
							Session("selectedUsers") = selectedUsers
					End If %>
					</td>
				</tr>
			</table>


<script>
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
            moede_dato: {
                required: true,
                dateISO: true,
                dateGreaterThanOrEqualToday: true
            },
            moede_tidspunkt: {
                required: true
            },
            moede_navn: {
                required: true,
                minlength: 2
            },
            id_meetingtype: {
                required: true
            },
            emne: {
                required: true,
                minlength: 2
            },
            beskrivelseInput: {
                required: true
            },
            id_afdeling: {
                required: true
            }
        },
        messages: {
            moede_dato: {
                required: "Date is required.",
                dateISO: "This is not a valid date",
                dateGreaterThanOrEqualToday: "Choose todays date or a date in the future."
            },
			
			moede_tidspunkt: {
                required: "Meeting time is requiered."
            },

            moede_navn: {
                required: "Meeting name is required.",
                minlength: "Meeting name must be more than 2 characters."
            },

			id_meetingtype: {
                required: "Meeting type is required."
            },
           
            emne: {
                required: "Subject is required.",
                minlength: "Subject must be more than 2 characters."
            },
            beskrivelseInput: {
                required: "Description is required.",
            },

			 id_afdeling: {
                required: "Department is required.",
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



</form>
	
  <script>
	// document.getElementById('show-agendapoint-form').addEventListener('click', function () {
	// 	var agendapointsForm = document.getElementById('agendapoint-form');
	// 	agendapointsForm.style.display = 'block'; // Show the overlay
	// });

	// // Add logic to close the overlay when needed, e.g., by clicking a close button
	// document.getElementById('close-agendapoint-form').addEventListener('click', function () {
	// 	var agendapointsForm = document.getElementById('agendapoint-form');
	// 	agendapointsForm.style.display = 'none'; // Hide the overlay
	// });
</script>
		

</html>

