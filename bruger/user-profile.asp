<meta name="viewport" content="width=device-width, initial-scale=1">

<%
Dim id_login, cmd, rs, sql
id_login = Session("id_login")
id_company = Session("id_company")

' Check if the user is logged in
If LEN(id_login) > 0 Then
    ' Create the SQL command to retrieve user data
    Set cmd = Server.CreateObject("ADODB.Command")
    With cmd
        Set .ActiveConnection = Conn ' Conn is our ADODB.Connection object
        .CommandText = "SELECT fornavn, efternavn, login, mailadresse, company_name FROM qrylogin WHERE id_login = ?"
        .CommandType = 1 'adCmdText
        .Parameters.Append .CreateParameter("@id_login", 3, 1, , id_login)
    
        Set rs = .Execute
    End With

    ' Check if data was found
    If Not rs.EOF Then
        ' Display user data
        %>
        <div class="overall-container">
            <div class="user-upcoming-container fade-in" style="animation-duration:700ms;">
                    <div class="user-profile">
                        <div class="companyname">
                            <img src="login/orangedude.png" alt="User Avatar" class="user-avatar">
                            <h2><%= rs("company_name") %></h2>
                        </div>

                        <div class="user-info">
                            <h3 style="margin: 2;"><%= rs("fornavn") & " " & rs("efternavn") %></h3>
                            <p>Email: <%= rs("mailadresse") %></p>
                            <p><%= rs("login") %></p>
                            <button onclick="location.href='bruger/brugeruser.asp?action=ret'" class="edit-profile-button">Edit</button>
                        </div>
                    </div>        
            </div>
        <% 
    Else
        Response.Write("User data not found.")
    End If
    
    ' Clean up
    rs.Close
    Set rs = Nothing
    Set cmd = Nothing
%>
 
<%
    ' SQL command to retrieve the upcoming meeting data
    Set cmd = Server.CreateObject("ADODB.Command")
    With cmd
        Set .ActiveConnection = Conn ' Conn is our ADODB.Connection object
    .CommandText = "SELECT TOP 1 moede_deadline, id_agenda, moede_navn, moede_dato, moede_tidspunkt FROM qry_Agenda WHERE oprettetaf = "& session("id_login") &" OR participants LIKE '%" & session("id_login") & "%' ORDER BY moede_deadline ASC "
        'response.write .CommandText
        Set rs = .Execute
    'response.write rs("id_agenda") & "<br>"
    End With
    
    ' Check if data was found
    If Not rs.EOF Then
        %>

        <div id='logo1'>
                <img id="imglogo1"src="../Login/Game-On.png" />
            </div>

            <div class="fade-in" style="animation-duration:800ms;">
                <div class="upcoming-meeting-container" style="animation-delay:800ms;">
                    <a href="../reg/list_my.asp?action=show&id_agenda=<%=rs("id_agenda")%>" data-ajax="false" style="text-decoration:none; color:unset">
                        <div class="upcoming-meeting-box">
                            <h2 style="font-size: 20px !important; text-shadow:none;">Upcoming Meeting</h2>
                            <p style="text-shadow:none; margin-right: 1%;"><strong>Agenda:</strong> <%= rs("moede_navn") %></p>
                            <p style="text-shadow:none; margin-right: 1%;"><strong>Deadline:<br></strong><%= FormatDateTime(rs("moede_dato")) %>&nbsp;|&nbsp;<%= FormatTime(rs("moede_tidspunkt")) %></p>
                        </div>
                    </a>
                </div>
            </div>
        </div>
        <%
    Else
        Response.Write("No upcoming meetings found.")
    End If

    ' Clean up
    rs.Close
    Set rs = Nothing
    Set cmd = Nothing

Else
    Response.Redirect("login_page.asp") ' Redirect to login page if not logged in
End If
%>
<%
Function FormatTime(time)
    Dim timeString
    timeString = CStr(time)
    FormatTime = Left(timeString, 5)
End Function

%>
<style>
/* Tablet styles */
@media screen and (min-width: 768px) {
 .overall-container{
    flex-direction: column;
 }
 .user-upcoming-container {
        flex-direction: column;

        max-width: 100%; /* Full width on smaller screens */
    }
}

/* Desktop styles */
@media screen and (min-width: 1024px) {
  /* Add styles for desktop screens */
  
  }

.overall-container{
    display: flex;
    flex-wrap: wrap;
    justify-content: space-between;
    align-items: center;
    max-width: 900px; /* Adjust the maximum width as needed */
    margin: 0 auto; /* Center the container horizontally */
    
}

 .user-upcoming-container {
    flex: 1;
    padding: 8px;
    max-width: 100%;
    border-radius: 8px;
    background-color: #f9f9f9;
    margin-top: 25px;
    margin-bottom: 25px;
    margin-left: -240px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    border: 1px solid #ddd;
    max-height: 200px;

    /* animation: fadeIn 2s ease;  */

    
}

#logo1{
max-width: 100%;
display: flex;
justify-content: center;
align-items: center;
perspective: 1000px;

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

#imglogo1{
  height: 500px;
  width: 500px;
  margin-right: 155px;
  margin-top: -130px;
  transform: scale(0.8);
  margin-bottom: -120px;
  animation: fadeInLogo 2s ease;
  
}
@media (max-width: 800px) {
  #imglogo1 img {
    left: 50%;
    top: 25%;
    transform: translate(-50%, -50%);
    height: 250px;
    width: 250px;
  }
}

@keyframes fadeIn {
    0% {
        opacity: 0;
    }
    100% {
        opacity: 1;
    }
}

/* applying  fadeIn animation to element */
.element {
    animation: fadeIn 2s ease-in-out;
}



 @keyframes drop-in {
    from {
      transform:
        rotate(-30deg) translateY(-100%);
      opacity: 0;
    }
    to {
      transform:
        rotate(0deg) translateY(0%);
      opacity: 1;
    }
  }

  .box {
    animation: drop-in 1000ms;
  }

.user-profile {
    flex: 1;
    padding: 8px;
    max-width: 400px;
    border-radius: 8px;
    background-color: #f9f9f9;
    margin-top: 12px;
    margin-left: 12px;
  
   
}

.companyname{
    display: flex;
    align-items: center;
    margin-top: -20px;

}

.companyname h2{
    margin: 0;
}


.upcoming-meeting-box {
    flex: 1;
    max-width: 250px;
    margin-left: 20px;

    

}

.upcoming-meeting-container{
    flex: 1;
    padding: 8px;
    max-width: 250px;
    border-radius: 8px;
    background-color: #f9f9f9;
    margin-top: 25px;
    margin-right: -240px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    border: 1px solid #ddd; 
    animation: pulsate 2s ease 3, changeColor 4s ease 0s 1 normal forwards;
   

}

@media screen and (min-width: 768px) {
 .user-upcoming-container {
    max-width: 33%; /* Adjust the maximum width for the user container on tablets */
  }

  #logo1 {
    max-width: 33%; /* Adjust the maximum width for the logo container on tablets */
  }


  .upcoming-meeting-container{
        max-width: 33%; /* Adjust the maximum width for the user container on tablets */

  }
}

@keyframes changeColor {
    0% {
        background-color: transparent;
    }
    25% {
        background-color: orange;
    }
    50% {
        background-color: transparent;
    }
    75% {
        background-color: orange;
    }
    100% {
        background-color: transparent;
    }
}

@keyframes pulsate {
    0% {
        transform: scale(1);
    }
    50% {
        transform: scale(1.2);
    }
    100% {
        transform: scale(1);
    }
}

/* Usage: Apply pulsate animation to an element */
.element {
    animation: pulsate 2s ease-in-out infinite;
}
@keyframes slide-in {
  from {
    transform: translateX(-100%);
  }
  to {
    transform: translateX(0%);
  }
}


@keyframes wiggle {
  0%, 7% {
    transform: rotateZ(0);
  }
  15% {
    transform: rotateZ(-15deg);
  }
  20% {
    transform: rotateZ(10deg);
  }
  25% {
    transform: rotateZ(-10deg);
  }
  30% {
    transform: rotateZ(6deg);
  }
  35% {
    transform: rotateZ(-4deg);
  }
  40%, 100% {
    transform: rotateZ(0);
  }
}



.user-avatar {
    width: 100px;
    height: 100px;
    border-radius: 50%;
    margin-right: 20px;
}

.user-info {
    flex-grow: 0.6;
}

.user-info h2,
.user-info p {
    margin: 0;
    padding: 0;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
    
    
}

.user-info h2 {
    font-size: 24px;
    color: #333;
}

.user-info p {
    color: #555;
    font-size: 14px;
}

.edit-profile-button {
    padding: 10px 20px;
    max-width: 100px;
    background-color: transparent;
    color: white;
    text-decoration: none;
    border-radius: 5px;
    font-size: 14px;
    margin-left: 240px;
    border: none; 
    cursor: pointer; 
    width: auto; 
    margin-top: -7px;
    
}

.edit-profile-button:hover {
    background-color: #0056b3; /* Change the color on hover */
}

.edit-profile-button::before {
    content: '\270E'; /* Unicode pencil icon */
    margin-right: 5px;
    /* Adjust the size and alignment as needed */
    vertical-align: middle;
}
</style>