<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>MoM</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.3/jquery.validate.min.js"></script>
<!--<link rel="stylesheet" href="jquery/jquery.mobile-1.4.5.css">
<link rel="stylesheet" href="../shared/global.css">
<script src="../jquery/jquery-1.8.2.min.js"></script>
<script src="../jquery/jquery.mobile-1.4.5.min.js"></script>-->
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
<!--onSubmit="return validateForm();" if the function can be used it needs to live here in the form post -->
<form data-ajax="false" method="post" action='save.asp?action=<%=request("action")%>'  style="position: relative;">
			<table align="center" style="width: 50%">
			<!-- Møde dato og tid-->
				<tr>
					<td style="text-align: center">
						<div style="display:flex;">
							<div style="width:50%">Start dato
						<!--	<input type="date" value="2023-09-01"> the datepicker works with this static data -->

								<input type="date" name="moede_dato"
								<% if  request("action")="show" AND NOT IsNull(rs("moede_dato")) then %>
								value="<%=rs("moede_dato")%>"
						<% else %>
								value=""
						<% end if %> >
							</div>
							<div style="width:50%">Start tid
								<input type="time" name="moede_tidspunkt" 
						<% if  request("action")="show" AND NOT IsNull(moede_tidspunkt) then  %>
								value="<%=rs("moede_tidspunkt")%>"
						<% else %>
								value=""
						<% end if %> >
							</div>
						</div>
					</td>
				</tr>
			<!-- Møde navn -->
				<tr>
					<th style="text-align: center">Name of meeting</th>

				<%
				Function ConvertDateFormat(inputDate)
					Dim dateParts
					dateParts = Split(inputDate, "-")
						If UBound(dateParts) = 2 Then
							ConvertDateFormat = dateParts(2) & "-" & dateParts(1) & "-" & dateParts(0)
						Else
							ConvertDateFormat = inputDate ' return original if format is unexpected
						End If
				End Function %>

				<%
				Function ExtractHoursMinutes(timeStamp)
				Dim timeParts, timeString
				timeParts = Split(timeStamp, " ") ' Split date from time

					If UBound(timeParts) >= 1 Then
						timeString = timeParts(1) ' This should be HH:mm:ss
						ExtractHoursMinutes = Left(timeString, 5) ' This will return HH:mm
					Else
						ExtractHoursMinutes = ""
					End If
				End Function
				%>


				<% if request("action")="show" then %>
					<% sql="Select * from qry_agenda where id_agenda = '"& request.QueryString("id_agenda") &"'"
						'response.write sql
						set rs = Conn.execute(sql)
						moede_dato=ConvertDateFormat(rs("moede_dato"))
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
						'For showing that I get the right converted data back from db
		response.write("Converted date: " & moede_dato & "<br>")
		response.write("Converted time: " & moede_tidspunkt & "<br>")
		%>
					<% end if %>
				</tr>

				<tr>			
					<td style="text-align: center">
						<input name="moede_navn" type="text"
					<% if  request("action")="show" AND NOT IsNull(moede_navn) then %>
							value="<%=moede_navn%>"
					<% else %>
							value=""
					<% end if %>
							style="width: 720px">
					</td>
				</tr>
			<!-- Møde subject meetingtype dropdown -->
				<tr>
					<td style="text-align: center">
						<select name="id_meetingtype" required >
										<% SQL3="Select * from tblmeeting_type order by id_meetingtype"
										set objRS3 = conn.Execute(SQL3)
									if NOT IsNull(id_meetingtype) then %>
										<option selected="" value=""><%=objRS3("meeting_type")%></option>
									<% else %>
										<option selected="" value="">Select type of meeting</option>
									<% end if 
										while not objRS3.EOF %>
											<option value='<%=objRS3("id_meetingtype")%>'>
													<% if objRS3("id_meetingtype") = id_meetingtype then %> selected <% end if %>
												<%=objRS3("meeting_type")%>
											</option>
										<% objRS3.MoveNext
										Wend %>
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
						<input name="emne" type="text" value="<%=emne%>" style="width: 720px">
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
						<textarea name="beskrivelse" id="expanding-textarea" rows="4" cols="50"><%=beskrivelse%></textarea>
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
						<textarea name="noter" id="expanding-textarea" rows="4" cols="50"><%=noter%></textarea>
					</td>
				</tr>
			<!-- Møde afdeling -->
				<tr>
					<td style="text-align: center">
						<select name="id_afdeling" required >
							
								<% SQL3="Select * from tbl_afdeling_2nd order by id_afdeling"
								set objRS3 = conn.Execute(SQL3)

								if NOT IsNull(id_afdeling) then %>
									<option selected="" value=""><%=objRS3("afdeling")%></option>
									<% else %>
									<option value="">Select Department</option>
									<% end if 

								while not objRS3.EOF %>
									<option value='<%=objRS3("id_afdeling")%>' style="text-align: center">

										<%=objRS3("afdeling")%>
									</option>
								<% objRS3.MoveNext
								Wend %>
						</select>
					</td>
				</tr>
			<!-- Møde deltagere -->
				<tr>
					<td style="text-align: center;">
						<div class="dropdown-wrapper">
							<div class="dropdown">
								<button type="button" class="toggle-button">Assign employees</button>
									<div class="dropdown-content">
										<%  SQL3="Select * from tbllogin order by id_login"
										set objRS3 = conn.Execute(SQL3)
										while not objRS3.EOF 
										%>
											<div class="label-container">
												<div class="user-list">
													<label class="user-item">
														<input type="checkbox" name="id_login" class="checkuser" value="<%=objRS3("id_login")%>"
														<%=checkboxState%>>
														<%=objRS3("login")%>
													</label>
												</div>
											</div>
										<% objRS3.MoveNext
										Wend %>
									</div>
								</div>
							</div>
						</td>
					<script>
						document.addEventListener("DOMContentLoaded", function() {
							const toggleButton = document.querySelector(".toggle-button");
							const dropdownContent = document.querySelector(".dropdown-content");
							console.log(toggleButton, dropdownContent); // Debug line

							toggleButton.addEventListener("click", function() {

								// Toggle visibility
								const isVisible = dropdownContent.style.visibility === 'visible';

								dropdownContent.style.visibility = isVisible ? 'hidden' : 'visible';
								if (!isVisible) {
									const rect = toggleButton.getBoundingClientRect();
								dropdownContent.classList.add("positioned-dropdown");
								dropdownContent.style.right = 0;
								dropdownContent.style.left = `${rect.left + window.scrollX + rect.width}px`;
								dropdownContent.style.top = `${rect.top + window.scrollY}px`;
								} else {
									dropdownContent.classList.remove("positioned-dropdown");
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
						<textarea name="additionalinfo" id="expanding-textarea" rows="4" cols="50"><%=additionalinfo%></textarea>
					</td>
				</tr>
			<!-- Møde submit btn -->
				<tr>
					<td style="text-align: center">
						<input name="existing_id_registrering" type="hidden" value="<%=existing_id_registrering%>">
						<input type="hidden" name="oprettetaf" value='<%=session("login_id")%>'>
						<input name="Submit1" type="submit" value="Start meeting" data-theme="a" data-icon="check">
						<!--This is how I can save multiple users to an agenda - There is for sure a better way to do this.. I just don't-->
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
End If
%>
					</td>
				</tr>

			</table>

			<script>

$(document).ready(function() {
    $('form').validate({
        rules: {
            moede_dato: {
                required: true,
                dateISO: true
				// Validating the date is in ISO format (YYYY-MM-DD)
            },
            moede_tidspunkt: {
                required: true
                // It is possible to validate the time format if needed
            },
            moede_navn: {
                required: true,
                minlength: 2
            },
            id_meetingtype: {
                required: false
            },
            emne: {
                required: true,
                minlength: 2
            },
            beskrivelse: {
                required: true,
                minlength: 5
            },
            noter: {
                required: false
            },
            id_afdeling: {
                required: false
            },
            additionalinfo: {
                required: false
            }
        },
        messages: {

        }
    });
});
/*
function validateForm() {
    var errorMsg = "";
    var moede_dato = document.querySelector("[name='moede_dato']").value;
    var moede_tidspunkt = document.querySelector("[name='moede_tidspunkt']").value;
    var moede_navn = document.querySelector("[name='moede_navn']").value;
	var moede_tidspunkt = document.querySelector("[name='moede_navn']").value;
    var meetingType = document.querySelector("[name='id_meetingtype']").value;
    var emne = document.querySelector("[name='emne']").value;
	var beskrivelse = document.querySelector("[name='beskrivelse']").value;
	var afdeling = document.querySelector("[name='id_afdeling']").value;


 	if (!startDate) {
       errorMsg += "Start date is required.<br>";
    }

    if (!startTime) {
       errorMsg += "Start time is required.<br>";
   }

	 if (!moede_dato) {
        errorMsg += "Dato for møde er påkrævet.<br>";
    }
	
	if (!moede_tidspunkt) {
        errorMsg += "Møde tidspunkt er påkrævet.<br>";
    }

    if (!moede_navn) {
        errorMsg += "Møde navn er påkrævet.<br>";
    }

    if (!meetingType) {
        errorMsg += "Type af møde er påkrævet.<br>";
    }

    if (!emne) {
        errorMsg += "Emne er påkrævet-<br>";
    }

 if (!beskrivelse) {
        errorMsg += "Beskrivelse er påkrævet.<br>";
    }

	if (!afdeling) {
        errorMsg += "Valg af afdeling er påkrævet.<br>";
    }

    if (errorMsg) {
        document.getElementById("errorMessages").innerHTML = errorMsg;
        return false; // preventing submit
    }
    return true; // allowing submit
}
*/
</script>

		</form>
		


