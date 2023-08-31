<form data-ajax="false" method="post" action='save.asp?action=<%=request("action")%>' style="position: relative;">
			<table align="center" style="width: 50%">
				<tr>
					<td style="text-align: center">
						<div style="display:flex;">
							<div style="width:50%">Start date
								<input type="date" name="moede_dato" required>
							</div>
							<div style="width:50%">Start time
								<input type="time" name="moede_tidspunkt" required>
							</div>
						</div>
					</td>
				</tr>
			<tr>
				<th style="text-align: center">Name of meeting</th>
			</tr>
		<tr>			
			<td style="text-align: center">
			<input name="moede_navn" type="text" style="width: 720px">
			</td>
		</tr>
	<tr>
		<td style="text-align: center">
			<select name="id_meetingtype" required >
				<option selected="" value="">Select subject</option>

							<% SQL3="Select * from tblmeeting_type order by id_meetingtype"
							set objRS3 = conn.Execute(SQL3)
							while not objRS3.EOF %>

								<option value='<%=objRS3("id_meetingtype")%>' style="text-align: center">
									<%=objRS3("meeting_type")%>
								</option>

							<% objRS3.MoveNext
							Wend %>
				</select>
		</td>
	</tr>
		<tr>
			<th style="text-align: center">
			Subject
			</th>
		</tr>
		<tr>
		<td style="text-align: center">
		<input name="emne" type="text" style="width: 720px"></td>
		</tr>

		<tr>
			<th style="text-align: center">
				Description
			</th>
		</tr>
		<tr>
			<td style="text-align: center">
				<textarea name="beskrivelse" id="expanding-textarea" rows="4" cols="50"></textarea>
			</td>
		</tr>
		<tr>
			<th style="text-align: center">
				Notes
			</th>
		</tr>
		<tr>
			<td style="text-align: center">
				<textarea name="noter" id="expanding-textarea" rows="4" cols="50"></textarea>
			</td>
		</tr>
	<tr>
		<td style="text-align: center">
			<select name="id_afdeling" required >
				<option selected="" value="">
					Select department
				</option>
					<% SQL3="Select * from tbl_afdeling_2nd order by id_afdeling"
					set objRS3 = conn.Execute(SQL3)
					while not objRS3.EOF %>
						<option value='<%=objRS3("id_afdeling")%>' style="text-align: center">
							<%=objRS3("afdeling")%>
						</option>

							<% objRS3.MoveNext
							Wend %>
			</select>
		</td>
	</tr>

	<tr>
		<td>			
  	<tr>
  		<td style="text-align: center;">
  			<div class="dropdown-wrapper">
    		<div class="dropdown">
     			 <button type="button" class="toggle-button">Assign employees</button>
      		<div class="dropdown-content">
        <% 
          SQL3="Select * from tbllogin order by id_login"
          set objRS3 = conn.Execute(SQL3)
          while not objRS3.EOF 
        %>
<div class="label-container">
<div class="user-list">
          <label class="user-item">
            <input type="checkbox" name="id_login" class="checkuser" value="<%=objRS3("id_login")%>"> <%=objRS3("login")%>
          </label>
</div>
</div>
        <% 
          objRS3.MoveNext
          Wend 
        %>

      </div>
    </div>
	</div>
  </td>
</tr>

  <script>
document.addEventListener("DOMContentLoaded", function() {
  const toggleButton = document.querySelector(".toggle-button");
  const dropdownContent = document.querySelector(".dropdown-content");
  console.log(toggleButton, dropdownContent); // Debug line

  toggleButton.addEventListener("click", function() {
    console.log("Button clicked!"); // Debug line

    // Toggle visibility
    const isVisible = dropdownContent.style.visibility === 'visible';
    console.log("Is visible:", isVisible); // Debug line

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
				</td></tr>



		<tr>
			<th style="text-align: center">
				Additional information
			</th>
		</tr>

		<tr>
			<td style="text-align: center">
				<textarea name="additionalInfo" id="expanding-textarea" rows="4" cols="50"></textarea>
			</td>
		</tr>

		<tr>
		<td style="text-align: center">
		<input name="Submit1" type="submit" value="Start meeting" data-theme="a" data-icon="check"></td>
		</tr>

		</table>
		<input name="existing_id_registrering" type="hidden" value="<%=existing_id_registrering%>">
		<input type="hidden" name="oprettetaf" value='<%=session("login_id")%>'>
		</form>
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