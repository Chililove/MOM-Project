<meta name="viewport" content="width=device-width, initial-scale=1">

<%
Dim id_login, cmd, rs, sql
id_login = Session("id_login")
id_company = Session("id_company")

%>

<%' Check if the user is logged in
If LEN(id_login) > 0 Then %>
    
    <div id="dashboard" class="overall-container">
        <!-- User Profile -->
            <%' Create the SQL command to retrieve user data
                Set cmd = Server.CreateObject("ADODB.Command")
                With cmd
                    Set .ActiveConnection = Conn ' Conn is our ADODB.Connection object
                    .CommandText = "SELECT fornavn, efternavn, login, mailadresse, company_name FROM qrylogin WHERE id_login = ?"
                    .CommandType = 1 'adCmdText
                    .Parameters.Append .CreateParameter("@id_login", 3, 1, , id_login)
                
                    Set rs = .Execute
                End With %>

            <%' Check if data was found
            If Not rs.EOF Then %>
                <div id="profile" class="user-upcoming-container fade-in" style="animation-duration:700ms;">
                    <div class="user-profile">
                        <div class="companyname">
                        <div class="button-img-container">
                        <img src="login/orangedude.png" alt="User Avatar" class="user-avatar">
                        <button onclick="location.href='bruger/brugeruser.asp?action=ret'" class="edit-profile-button">Edit</button>
                        </div>
                            <h2 style="margin-left: 4%; font-size: 20px; margin-top: -2%;"><%= rs("company_name") %></h2>
                        </div>

                        <div class="user-info">
                            <h3 style="margin-left: 4%; margin-top: -2%; font-size: 18px;"><%= rs("fornavn") & " " & rs("efternavn") %></h3>
                            <p style="margin-left: 4%; margin-top: -2%;">Email: <%= rs("mailadresse") %></p>
                            <p style="margin-left: 4%; margin-top: -2%;"><%= rs("login") %></p>
                        </div>
                    </div>        
                </div>
            <% Else
                Response.Write("User data not found.")
            End If

            ' Clean up
            rs.Close
            Set rs = Nothing
            Set cmd = Nothing
            %>
        <!-- Logo -->
                <img id="imglogo1"src="../Login/mom.png" />
        <!-- Upcoming Meeting -->
            <% ' SQL command to retrieve the upcoming meeting data
                Set cmd = Server.CreateObject("ADODB.Command")
                With cmd
                    Set .ActiveConnection = Conn ' Conn is our ADODB.Connection object
                .CommandText = "SELECT TOP 1 moede_deadline, id_agenda, moede_navn, moede_dato, moede_tidspunkt FROM qry_Agenda WHERE oprettetaf = "& session("id_login") &" OR participants LIKE '%" & session("id_login") & "%' ORDER BY moede_deadline ASC "
                    'response.write .CommandText
                    Set rs = .Execute
                'response.write rs("id_agenda") & "<br>"
            End With %>
                    
            <% If Not rs.EOF Then %>
                <div id="upcoming" class="fade-in" style="animation-duration:800ms;">
                    <div class="upcoming-meeting-container" style="animation-delay:800ms;">
                        <a href="../reg/list_my.asp?action=show&id_agenda=<%=rs("id_agenda")%>" data-ajax="false" style="text-decoration:none; color:unset">
                            <div class="upcoming-meeting-box">
                                <h2 style="font-size: 18px !important; margin-left: 4%; text-shadow:none;">Upcoming Meeting</h2>
                                <p style="text-shadow:none; margin-left: 4%;"><strong>Agenda:</strong> <%= rs("moede_navn") %></p>
                                <p style="text-shadow:none; margin-left: 4%;"><strong>Deadline:<br></strong><%= FormatDateTime(rs("moede_dato")) %>&nbsp;|&nbsp;<%= FormatTime(rs("moede_tidspunkt")) %></p>
                            </div>
                        </a>
                    </div>
                </div>
            <% Else
                Response.Write("No upcoming meetings found.")
            End If
            ' Clean up
            rs.Close
            Set rs = Nothing
            Set cmd = Nothing %>

    </div>

<%Else
    Response.Redirect("login_page.asp") ' Redirect to login page if not logged in
End If %>


<% Function FormatTime(time)
    Dim timeString
    timeString = CStr(time)
    FormatTime = Left(timeString, 5)
End Function %>

<style>
   
    #Dashboard{
        display:flex;
        justify-content:space-between;
        min-height:280px;
        position:relative;
    }
    #profile {
        border:1px solid lightgrey;
        background-color:white;
        z-index:9999;
        margin-left: 10px;
        margin-top: 19px;

        width: 30%;
        border-radius: 10px;
        height: 20%;
    }
    #imglogo1 {
        position:absolute;
        top:0;
        margin-top: 1%;
        left:calc(50% - 190.2px);
        /* width:300px; */
    }
    #upcoming {
        border:1px solid lightgrey;
        background-color:white;
        z-index:9999;
        margin: 10px;
        margin-top: 4%;
        border-radius: 10px;
        height: 20%;


    }

    .user-avatar{
        height: 25%;
        width: 25%;
    }

.edit-profile-button{
    width: 25% !important;
    margin-right: 4%;
    margin-top: -3%;
}

.button-img-container{
    display: flex;
    justify-content: space-between;
    align-items: center;
}


   
</style>