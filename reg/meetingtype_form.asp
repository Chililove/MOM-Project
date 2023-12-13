<!--#include file="../login/protect.inc"-->

<!DOCTYPE html>
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
        meetingtype = rs("meeting_type")
    End If
    rs.Close
End If
%>

<div data-role="header" data-id="header" data-position="fixed">
    <h1>Meetingtypes</h1>
    <a class="ui-btn-left" href="../default.asp" data-ajax="false" data-icon="home">Home</a>
</div>

<%if Request.QueryString("action") = "update" then%>
	<h2 style="padding: 1%; height: .5px;">Edit meetingtype here</h2>
<%else%>
	<h2 style="padding: 1%; height: .5px;">Add a new meetingtype here</h2>
<%end if%>

<%IF Request.QueryString("action") = "update" then%>

<form id="meetingtypeForm" method="post" action="save_meetingtype.asp?action=update&id_meetingtype=<%=id_meetingtype%>">
<%Else%>
<form id="meetingtypeForm" method="post" action="save_meetingtype.asp?action=create">
<%end if%>

<%if Request.QueryString("action") = "update" then%>
    <label for="meeting_type">Please fill out this form to edit the meetingtype:</label>
<%else%>
    <label for="meeting_type">Please fill out this form to create a new meetingtype:</label>
<%end if%>
    <!-- Why do i get the name of the field back instead of the id?? -->
    <input type="text" id="meeting_type" name="meeting_type" value="<%=meeting_type%>" required>

     <% If Request.QueryString("action") = "update" Then %>
        <input type="hidden" name="id_meetingtype" value="<%=id_meetingtype%>">

     <button type="submit">Update meetingtype</button>
<button type="button" id="deleteButton" value="Delete type" data-theme="a" data-icon="delete">Delete type</button>


<%Else%>
    <button type="submit">Add meetingtype</button>

    <% End If %>    <!-- External "Delete" button with event listener -->
</form>

<script>
    document.getElementById("deleteButton").addEventListener("click", function() {
            console.log("Delete button clicked");

        var r = confirm("Are you sure you want to delete this type?");
        if (r == true) {
            var formData = new FormData();
            formData.append("action", "delete");

            fetch("/reg/save_meetingtype.asp?id_meetingtype=<%=id_meetingtype%>", {
                method: "POST",
                body: formData
            })
            .then(function(response) {
                if (response.ok) {
                    alert("Meeting type deleted successfully.");
                    // Redirecting to the list page or I could do another action?'
                   ' window.location.href = "/reg_list/meetingtype_list.asp";
                } else {
                    alert("An error occurred during meeting type deletion.");
                }
            })
            .catch(function(error) {
                console.error("Error:", error);
            });
        }
    });
</script>
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
