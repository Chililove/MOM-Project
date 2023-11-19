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
        // Example validation: check if companyName is not empty and cvr is numeric
        if(meetingtype.trim() === '' ) {
            alert('Please enter a valid meetingtype id.');
            e.preventDefault(); // Prevent form submission if validation fails
        }
        // Add more validation rules if needed
    });
});


</script>
</head>

<body>
<%
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
<%IF Request.QueryString("action") = "update" then%>
<form id="meetingtypeForm" method="post" action="save_meetingtype.asp?action=update&id_meetingtype=<%=id_meetingtype%>">
<%Else%>
<form id="meetingtypeForm" method="post" action="save_meetingtype.asp?action=create">
<%end if%>
    <label for="meeting_type">Meetingtype:</label>
    <input type="text" id="meeting_type" name="meeting_type" value="<%=meeting_type%>" required>

     <% If Request.QueryString("action") = "update" Then %>
        <input type="hidden" name="id_meetingtype" value="<%=id_meetingtype%>">
            <button type="submit">Update meetingtype</button>
<%Else%>
    <button type="submit">Add meetingtype</button>

    <% End If %>

</form>

<%
sql = "SELECT * FROM tblmeeting_type ORDER BY meeting_type DESC"
Set rs = Conn.Execute(sql)

If rs.EOF Then
    Response.Write("No meetingtypes found.")
End If
rs.Close()
%>

</body>
</html>
