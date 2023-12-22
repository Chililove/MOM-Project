<!--#include file="../login/protect.inc"-->

<!DOCTYPE html>
<%
' Check if the user is an administrator
If Not session("administrator") Then
    ' If not an administrator, redirect them to an error page or some other action
    Response.Redirect("../default.asp?accessDenied=true") 
End If
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="../jquery/jquery.mobile-1.4.5.css">
<script src="../jquery/jquery-1.8.2.min.js"></script>
<script src="../jquery/jquery.mobile-1.4.5.min.js"></script>
<script>
$(document).ready(function() {
    // Client-side validation logic here
    $('#meetingtypeForm').submit(function(e) {
        var meetingtype = $('#meetingtype').val();
        // Example validation: check if name is not empty and cvr is numeric
        if(meetingtype.trim() === '' ) {
            alert('Please enter a valid meetingtype id.');
            e.preventDefault(); // Prevent form submission if validation fails
        }
        // Add more validation rules if needed
    });
});


</script>
<script>
    function del(id) { 
        var idValue = id
        
        if (idValue !== null) {
            var firstConfirm = window.confirm("Are you sure you want to delete this meeting type?");
            
            if (firstConfirm) {
            var secondConfirm = window.confirm("This action is irreversible. Are you absolutely sure?");
            
            if (secondConfirm) {
                var deleteUrl = 'delete.asp?action=mtype&id=' + encodeURIComponent(id);
                window.location.href = deleteUrl;
            } else {
            // Nothing
            }
            } else {
            // Nothing
            }
        } else {
            alert("No 'id' parameter found in the URL.");
        }
    }

</script>
</head>
<style>

html,body {
  height:100%;
  width:100%;
  margin:0;
}
body {
  display:flex;
}
form {
  margin:auto;
  width: 50%;
}

#meeting_type{
padding: 2%;
}


  @keyframes fadeIn {
    0% {
        opacity: 0;
    }
    100% {
        opacity: 1;
    }
}

.fade-in {
    animation: fadeIn 2s ease;
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

</style>
<body>
<%
    'Response.Write(id_meetingtype)

' Check if we are updating an existing company
If Request.QueryString("action") = "update" And Not IsEmpty(Request.QueryString("id_company")) Then
    company_id = Request.QueryString("id_company")
    sql = "SELECT * FROM tblmeeting_type WHERE id_company = " & company_id
    Set rs = Conn.Execute(sql)
    If Not rs.EOF Then
        meeting_type = rs("meeting_type")
        id_meetingtype = rs("id_meetingtype")
    End If
    rs.Close
End If
%>

<div data-role="header" data-id="header" data-position="fixed">
    <h1>Meetingtypes</h1>
    <a class="ui-btn-left" href="../default.asp" data-ajax="false" data-icon="home">Home</a>
</div>

<%if Request.QueryString("action") = "update" then%>
	<h2 style="padding: 3%; height: .5px; text-align: center; animation-duration: 1s;" class="fade-in">Edit meetingtype here</h2>
<%else%>
	<h2 style="padding: 3%; height: .5px; text-align: center; animation-duration: 1s;" class="fade-in">Add a new meetingtype here</h2>
<%end if%>

<%IF Request.QueryString("action") = "update" then%>

<form class="fade-in" style="animation-duration: 2s" id="meetingtypeForm" method="post" action="save_meetingtype.asp?action=update&id_meetingtype=<%=id_meetingtype%>">
<%Else%>
<form  class="fade-in" style="animation-duration: 2s" id="meetingtypeForm" method="post" action="save_meetingtype.asp?action=create">
<%end if%>

<%if Request.QueryString("action") = "update" then%>
    <label for="meeting_type">Please fill out this form to edit the meetingtype:</label>
<%else%>
    <label for="meeting_type">Please fill out this form to create a new meetingtype:</label>
<%end if%>
    <!-- Why do i get the name of the field back instead of the id?? -->
    <tr>
    <input type="text" id="meeting_type" name="meeting_type" value="<%=meeting_type%>" required>
    </tr>
     <% If Request.QueryString("action") = "update" Then %>
        <input type="hidden" name="id_meetingtype" value="<%=id_meetingtype%>">

     <button type="submit">Update meetingtype</button>
     <button type="button" onclick='del("<%=request.querystring("id_meetingtype")%>")' class="delete-button" >Delete</button>


<%Else%>
    <button type="submit">Add meetingtype</button>

    <% End If %>   
</form>
<div id="logo">
                <img id="imglogo"src="../Login/Game-On.png" />
            </div>	
<%
sql = "SELECT * FROM tblmeeting_type  where id_company =  " & session("id_company") & " ORDER BY meeting_type DESC"
Set rs = Conn.Execute(sql)

If rs.EOF Then
    Response.Write("No meetingtypes found.")
End If
rs.Close()
%>

</body>
</html>
