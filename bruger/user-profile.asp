
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
                    <button onclick="location.href='bruger/bruger.asp?default=yes&action=ret&id_login=<%=id_login%>'" class="edit-profile-button">Edit</button>
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
    ' Create the SQL command to retrieve the upcoming meeting data
    Set cmd = Server.CreateObject("ADODB.Command")
    With cmd
        Set .ActiveConnection = Conn ' Conn is our ADODB.Connection object
.CommandText = "SELECT TOP 1 moede_navn, moede_tidspunkt, moede_dato FROM qry_agenda WHERE CAST(moede_dato AS DATE) > CAST(GETDATE() AS DATE) OR (CAST(moede_dato AS DATE) = CAST(GETDATE() AS DATE) AND CAST(moede_tidspunkt AS TIME(7)) >= CAST(GETDATE() AS TIME(7))) ORDER BY moede_dato, moede_tidspunkt ASC"
        Set rs = .Execute
    End With

    ' Check if data was found
    If Not rs.EOF Then
        ' Display upcoming meeting data
%>

 <div id='logo'>
        <img id="imglogo"src="../Login/Game-On.png" />
    </div>
    <div class="fade-in" style="animation-duration:800ms;">
        <div class="upcoming-meeting-container" style="animation-delay:800ms;">
            <div class="upcoming-meeting-box">
                <h2 style="font-size: 20px !important;">Upcoming Meeting</h2>
                <p><strong>Agenda:</strong> <%= rs("moede_navn") %></p>
                <p><strong>Deadline:</strong><%= FormatDateTime(rs("moede_dato")) %>&nbsp;|&nbsp;<%= FormatTime(rs("moede_tidspunkt")) %></p>
            </div>
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
.overall-container{
       display: flex;
       flex-wrap: wrap;
    justify-content: space-between;
    align-items: flex-start;
    max-width: 900px; /* Adjust the maximum width as needed */
    margin: 0 auto; /* Center the container horizontally */
}

 .user-upcoming-container {
    flex: 1;
    flex-grow: 1;
    padding: 8px;
    max-width: calc(50% - 80px); /* Adjust the maximum width for this container */
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

#logo{
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

#imglogo{
  height: 500px;
  width: 500px;
  margin-right: 155px;
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
    flex: 0.4;
    max-width: 250px;
    margin-left: 20px;

    

}

.upcoming-meeting-container{
    flex: 1;
    flex-grow: 1;
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