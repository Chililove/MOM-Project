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
<style>

  @keyframes fadeIn {
    0% {
        opacity: 0;
    }
    100% {
        opacity: 1;
    }
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
  height: 20%;
  width: 20%;
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
' Check if we are updating an existing company
If Request.QueryString("action") = "update" And Not IsEmpty(Request.QueryString("id_company")) Then
    company_id = Request.QueryString("id_company")
    sql = "SELECT * FROM tbl_companies WHERE id_company = " & company_id
    Set rs = Conn.Execute(sql)
    If Not rs.EOF Then
        company_name = rs("company_name")
        cvr = rs("cvr")
        telefon = rs("telefon")
        email = rs("email")
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

     <label for="telefon">TLF:</label>
    <input type="number" id="telefon" name="telefon" value="<%=telefon%>" required>

    <label for="email">Email:</label>
    <input type="text" id="email" name="email" value="<%=email%>" required>


     <% If Request.QueryString("action") = "update" Then %>
        <input type="hidden" name="id_company" value="<%=company_id%>">
            <button type="submit">Update company</button>
<%Else%>
    <button type="submit">Add company</button>

    <% End If %>

</form>
<div id="logo">
                <img id="imglogo"src="../Login/Game-On.png" />
            </div>	
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
