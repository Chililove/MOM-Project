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
    $('#afdelingForm').submit(function(e) {
        var afdeling = $('#afdeling').val();
        // Example validation: check if name is not empty
        if(afdeling.trim() === '' ) {
            alert('Please enter a valid department id.');
            e.preventDefault(); // Prevent form submission if validation fails
        }
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
<%if Request.QueryString("action") = "update" then%>
	<h2 style="padding: 1%; height: .5px;">Edit department here</h2>
<%else%>
	<h2 style="padding: 1%; height: .5px;">Add a new department here</h2>
<%end if%>


<%IF Request.QueryString("action") = "update" then%>

<form id="afdelingForm" method="post" action="save_afdeling.asp?action=update&id_afdeling=<%=id_afdeling%>">
<%Else%>
<form id="afdelingForm" method="post" action="save_afdeling.asp?action=create">
<%end if%>
<%if Request.QueryString("action") = "update" then%>
        <label for="afdeling">Please fill out this form to edit the department:</label>
<%else%>
    <label for="afdeling">Please fill out this form to create a new department:</label>
<%end if%>
    <input type="text" id="afdeling" name="afdeling" value="<%=afdeling%>" required>
        <input type="hidden" name="id_afdeling" value="<%=id_afdeling%>">

     <% If Request.QueryString("action") = "update" Then %>
        <input type="hidden" name="id_afdeling" value="<%=id_afdeling%>">

     <button type="submit">Update department</button>
     
<button type="button" onclick='del("<%=request.querystring("id_afdeling")%>")' id="deleteButton" value="Delete department" data-theme="a" data-icon="delete">Delete type</button>


<%Else%>
    <button type="submit">Add department</button>

    <% End If %>    <!-- External "Delete" button with event listener -->
</form>

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
<script>
    function del(id) { 
        var idValue = id
        
        if (idValue !== null) {
            var firstConfirm = window.confirm("Are you sure you want to delete this department?");
            
            if (firstConfirm) {
            var secondConfirm = window.confirm("This action is irreversible. Are you absolutely sure?");
            
            if (secondConfirm) {
                var deleteUrl = 'delete.asp?action=dtype&id=' + encodeURIComponent(id);
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
