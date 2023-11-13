
<%

Dim id_login, cmd, rs, sql
id_login = Session("id_login")
id_company = Session("id_company")


'Response.Write("Session id_login: " & Session("id_login"))
'Response.Write("Session id_company: " & Session("id_company"))



' Check if the user is logged in
If Not IsEmpty(id_login) Then
    ' Create the SQL command to retrieve user data
    Set cmd = Server.CreateObject("ADODB.Command")
    With cmd
        Set .ActiveConnection = Conn ' Conn is our ADODB.Connection object
      '  .CommandText = "SELECT fornavn, efternavn, login, mailadresse FROM tbllogin WHERE id_login = ?"

      ' Would be nice to add company name to this profile view, but i cannot extract company name from the qrylogin view for some reason i do not know
                .CommandText = "SELECT fornavn, efternavn, login, mailadresse FROM qrylogin WHERE id_login = ?"

        .CommandType = 1 'adCmdText
        .Parameters.Append .CreateParameter("@id_login", 3, 1, , id_login)
    
        Set rs = .Execute
    End With

    ' Check if data was found
    If Not rs.EOF Then
        ' Display data
        %>
        
      <div class="user-profile">
    <img src="login/orangedude.png" alt="User Avatar" class="user-avatar">
    <div class="user-info">
        <h2><%= rs("login") %></h2>
        <p><%= rs("fornavn") & " " & rs("efternavn") %></p>
        <p>Email: <%= rs("mailadresse") %></p>
    </div>
</div>
        <a href='bruger/bruger.asp?action=ret&id_login=<%=id_login%>' class="edit-button" data-ajax="false">Edit Profile</a>


        <%
    Else
        Response.Write("User data not found.")
    End If
    
    ' Clean up
    rs.Close
    Set rs = Nothing
    Set cmd = Nothing
Else
    Response.Redirect("login_page.asp") ' Redirect to login page if not logged in
End If
%>
<style>
 .user-profile {
        display: flex;
        align-items: center;
        background-color: #f9f9f9;
        border: 1px solid #ddd;
        padding: 20px;
        margin: 20px auto;
        margin-left: 1%;
        border-radius: 8px;
        max-width: 600px;
        box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    }

    .user-avatar {
        flex-shrink: 0;
        width: 100px;
        height: 100px;
        border-radius: 50%;
        margin-right: 20px;
        border: 3px solid #2c3e50;
        object-fit: cover;
    }

    .user-info {
        flex-grow: 1;
    }

    .user-info h2 {
        margin: 0;
        color: #333;
        font-size: 24px;
        font-weight: normal;
    }

    .user-info p {
        margin: 5px 0;
        color: #555;
    }

    .user-info p:first-of-type {
        font-size: 16px;
        font-weight: bold;
    }

    .user-info p:last-of-type {
        font-size: 14px;
        color: #888;
    }
</style>