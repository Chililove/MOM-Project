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
    $('#afdelingForm').submit(function(e) {
        var afdeling = $('#afdeling').val();
        // Example validation: check if name is not empty and cvr is numeric
        if(afdeling.trim() === '' ) {
            alert('Please enter a valid department id.');
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

#afdeling{
padding: 2%;
}

  
</style>

<body>
<%

' Check if we are updating an existing afdeling
If Request.QueryString("action") = "update" And Not IsEmpty(Request.QueryString("id_company")) Then
    company_id = Request.QueryString("id_company")
    sql = "SELECT * FROM tbl_afdeling_2nd WHERE id_company = " & company_id
    Set rs = Conn.Execute(sql)
    If Not rs.EOF Then
        afdeling = rs("afdeling")
        id_afdeling = rs("id_afdeling")
    End If
    rs.Close
End If
%>

<div data-role="header" data-id="header" data-position="fixed">
    <h1>Departments</h1>
    <a class="ui-btn-left" href="../default.asp" data-ajax="false" data-icon="home">Home</a>
</div>
<%IF Request.QueryString("action") = "update" then%>

<form id="afdelingForm" method="post" action="save_afdeling.asp?action=update&id_afdeling=<%=id_afdeling%>">
<%Else%>
<form id="afdelingForm" method="post" action="save_afdeling.asp?action=create">
<%end if%>
    <label for="afdeling">Department:</label>
    <!-- Why do i get the name of the field back instead of the id?? -->
    <input type="text" id="afdeling" name="afdeling" value="<%=afdeling%>" required>
        <input type="hidden" name="id_afdeling" value="<%=id_afdeling%>">

     <% If Request.QueryString("action") = "update" Then %>
        <input type="hidden" name="id_afdeling" value="<%=id_afdeling%>">

     <button type="submit">Update department</button>
     
<button type="button" id="deleteButton" value="Delete type" data-theme="a" data-icon="delete">Delete type</button>


<%Else%>
    <button type="submit">Add department</button>

    <% End If %>    <!-- External "Delete" button with event listener -->
</form>
<!-- The rest of your code remains the same -->

<script>
    document.getElementById("deleteButton").addEventListener("click", function() {
            console.log("Delete button clicked");

        var r = confirm("Are you sure you want to delete this type?");
        if (r == true) {
            var formData = new FormData();
            formData.append("action", "delete");

            fetch("/reg/save_afdeling.asp?id_afdeling=<%=id_afdeling%>", {
                method: "POST",
                body: formData
            })
            .then(function(response) {
                if (response.ok) {
                    alert("Department deleted successfully.");
                    // Redirecting to the list page or I could do another action?'
                    window.location.href = "/reg_list/afdeling_list.asp";
                } else {
                    alert("An error occurred during department deletion.");
                }
            })
            .catch(function(error) {
                console.error("Error:", error);
            });
        }
    });
</script>
<%
sql = "SELECT * FROM tbl_afdeling_2nd  where id_company =  " & session("id_company") & " ORDER BY afdeling DESC"
Set rs = Conn.Execute(sql)

If rs.EOF Then
    Response.Write("No departments found.")
End If
rs.Close()
%>

</body>
</html>
