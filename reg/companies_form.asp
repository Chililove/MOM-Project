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
    $('#companyForm').submit(function(e) {
        var companyName = $('#company_name').val();
        var cvr = $('#cvr').val();
        // Example validation: check if companyName is not empty and cvr is numeric
        if(companyName.trim() === '' || isNaN(cvr)) {
            alert('Please enter a valid company name and CVR number.');
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
    sql = "SELECT * FROM tbl_companies WHERE id_company = " & company_id
    Set rs = Conn.Execute(sql)
    If Not rs.EOF Then
        company_name = rs("company_name")
        cvr = rs("cvr")
    End If
    rs.Close
End If
%>

<div data-role="header" data-id="header" data-position="fixed">
    <h1>Companies</h1>
    <a class="ui-btn-left" href="../default.asp" data-ajax="false" data-icon="home">Home</a>
</div>
<%IF Request.QueryString("action") = "update" then%>
<form id="companyForm" method="post" action="save_company.asp?action=update&id_company=<%=company_id%>">
<%Else%>
<form id="companyForm" method="post" action="save_company.asp?action=create">
<%end if%>
    <label for="company_name">Company Name:</label>
    <input type="text" id="company_name" name="company_name" value="<%=company_name%>" required>

    <label for="cvr">CVR:</label>
    <input type="number" id="cvr" name="cvr" value="<%=cvr%>" required>

     <% If Request.QueryString("action") = "update" Then %>
        <input type="hidden" name="id_company" value="<%=company_id%>">
            <button type="submit">Update company</button>
<%Else%>
    <button type="submit">Add company</button>

    <% End If %>

</form>

<%
sql = "SELECT * FROM tbl_companies ORDER BY company_name DESC"
Set rs = Conn.Execute(sql)

If rs.EOF Then
    Response.Write("No companies found.")
End If
rs.Close()
%>

</body>
</html>
