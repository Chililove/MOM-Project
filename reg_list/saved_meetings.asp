<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="../jquery/jquery.mobile-1.4.5.css">
<script src="../jquery/jquery-1.8.2.min.js"></script>
<script src="../jquery/jquery.mobile-1.4.5.min.js"></script>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

</head>

    <div data-role="header" data-id="header" data-position="fixed">
        <h1 >List of meetings</h1>
            <a class="ui-btn-left" href="../default.asp" data-ajax="false" data-icon="home">Home</a>
            <a class="ui-btn-right" href="http://mom.main-solution.dk/login/login.asp" data-ajax="false" data-icon="power">logoff</a>
    </div>
<body>
<!--#include file="../opendb.asp"-->
<%
sql="select * from qrysaved_meetings"
'where oprettetaf=" &session("id_login")"
set rs=conn.execute(sql)
%>
<ul data-role="listview" data-inset="false" data-filter="false">
				
<%
do while not rs.eof
%>
<li>
			<!--	<a data-ajax="false" href='../reg_list/list_my.asp?oprettetdato=<%'=rs(("oprettetdato_string"))%>'> -->
    <a data-ajax="false" href='../reg/list_my.asp?action=show&amp;id_agenda=<%=rs("id_agenda")%>'>	
        <table style="width: 100%;">
	        <tr>             
                <td style="width: 20%; padding-left: 10px;">  <%=rs("moede_dato")%> <br> <%= rs("moede_tidspunkt")%> <br> </td>
                <td style="width: 40%; font-weight: bold;"> <%=rs("moede_navn")%> </td>
      <!-- Delete Button for AJAX -->
<button class="delete-button" data-id="<%=rs("id_agenda")%>">Delete</button>
		
		    </tr>
        </table>
    </a>
</li>
<%
 rs.movenext
loop
%> 

</ul>

<script>
$(document).ready(function() {
    $('.delete-button').on('click', function(e) {

        e.stopPropagation();
        e.preventDefault();

        var id_agenda = $(this).data('id');
        
        if(!confirm('Are you sure you want to delete this agenda?')) {
            return;
        }

        $.ajax({
            url: 'save.asp',
            method: 'POST',
            data: { 
                'action': 'delete', 
                'id_agenda': id_agenda 
            },
            success: function(response) {
                if(response.trim() === "success") {
                    alert("Agenda deleted successfully.");
                   location.reload(); // Refreshing the page.
                } else {
                    alert("There was an error deleting the agenda.");
                }
            }
        });
    });
});
</script>

<style>
  /* Styles for the list view */
        ul[data-role="listview"] {
            list-style-type: none;
            border: 1px solid #ccc;
        }

        /* Styles for each list item */
        li {
            border-bottom: 1px solid #ccc;
            padding: 5px;
        }

        /* Styles for the list divider */
        li[data-role="list-divider"] {
            background-color: #f2f2f2;
            font-weight: bold;
        }

        /* Styles for tables */
        table {
            width: 100%;
        }

        td {
            padding: 3px;
            text-align: left;
            font-size: 18px;
        }

        /* Styles for anchor tags */
        a {
            text-decoration: none;
            color: blue;
        }

        a:hover {
            text-decoration: underline;
        }

        .delete-button {
           max-width: 100px;
           float: right;
        }
</style>
<!--#include file="../shared/footer.asp"-->
</body>
<!--#include file="../closedb.asp"-->
</html>