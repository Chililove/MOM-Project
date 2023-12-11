
<%

Dim id_login, cmd, rs, sql
id_login = Session("id_login")
id_company = Session("id_company")


'Response.Write("Session id_login: " & Session("id_login"))
'Response.Write("Session id_company: " & Session("id_company"))



' Check if the user is logged in
If LEN(id_login)>0 Then
    ' Create the SQL command to retrieve user data
    Set cmd = Server.CreateObject("ADODB.Command")
    With cmd
        Set .ActiveConnection = Conn ' Conn is our ADODB.Connection object
      '  .CommandText = "SELECT fornavn, efternavn, login, mailadresse FROM tbllogin WHERE id_login = ?"

      ' Would be nice to add company name to this profile view, but i cannot extract company name from the qrylogin view for some reason i do not know
                .CommandText = "SELECT fornavn, efternavn, login, mailadresse, company_name FROM qrylogin WHERE id_login = ?"

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
            <h2><%= rs("company_name") %></h2>

        <h3><%= rs("login") %></h3>
        <p><%= rs("fornavn") & " " & rs("efternavn") %></p>
        <p>Email: <%= rs("mailadresse") %></p>
    </div>
              <button onclick="location.href='bruger/bruger.asp?action=ret&id_login=<%=id_login%>'" class="edit-profile-button">Edit</button>

</div>


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
    justify-content: space-between; /* This will space out the avatar/info and the edit button */
    background-color: #f9f9f9;
    border: 1px solid #ddd;
    padding: 20px;
    border-radius: 8px;
    margin: 15px;
    max-width: 600px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}

.user-avatar {
    flex-shrink: 0;
    width: 100px;
    height: 100px;
    border-radius: 50%;
    margin-right: 20px;
}

.user-info {
    flex-grow: 1;
}

.user-info h2, .user-info p {
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
    margin-top: -10%;
    background-color: transparent;
    color: white;
    text-decoration: none;
    border-radius: 5px;
    font-size: 14px;
    border: none; /* Remove any default border */
    cursor: pointer; /* Change cursor to pointer */
    width: 14% !important;
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