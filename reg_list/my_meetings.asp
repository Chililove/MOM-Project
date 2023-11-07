<!--#include file="../login/protect.inc"-->

<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="../jquery/jquery.mobile-1.4.5.css">
<link rel="stylesheet" href="../shared/global.css">
<script src="../jquery/jquery-1.8.2.min.js"></script>
<script src="../jquery/jquery.mobile-1.4.5.min.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>




<!--<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>-->

</head>

    <div data-role="header" data-id="header" data-position="fixed">
        <h1 >List of meetings</h1>
            <a class="ui-btn-left" href="../default.asp" data-ajax="false" data-icon="home">Home</a>
            <a class="ui-btn-right" href="http://mom.main-solution.dk/login/login.asp" data-ajax="false" data-icon="power">logoff</a>
    </div>
<body>
<!--#include file="../opendb.asp"-->
<%
dim id_login
	id_login = session("login_id")
sql ="SELECT * FROM qrysaved_meetings WHERE oprettetaf = '" &session("login_id") & "'"
set rs=conn.execute(sql)
%>

<ul data-role="listview" data-inset="false" data-filter="false">

<%
do while not rs.eof
%>
<li id="agenda-<%=rs("id_agenda")%>">
			<!--	<a data-ajax="false" href='../reg_list/list_my.asp?oprettetdato=<%'=rs(("oprettetdato_string"))%>'> -->
    <a data-ajax="false" href='../reg/list_my.asp?action=show&amp;id_agenda=<%=rs("id_agenda")%>'>	
        <table style="width: 100%;">
	        <tr>             
                <td style="width: 20%; padding-left: 10px;">  <%=rs("moede_dato")%> <br> <%= rs("moede_tidspunkt")%> <br> </td>
                <td style="width: 40%; font-weight: bold;"> <%=rs("moede_navn")%> </td>
		    </tr>
               <!-- Your delete button for each agenda -->
               <% If session("administrator") = True Then %>
<button class="delete-button" data-id="<%=rs("id_agenda")%>">Delete</button>
<%end if%>
        </table>

    </a>

</li>




<%
 rs.movenext
loop
%> 

</ul>

<!-- Delete confirmation dialog -->
<div id="delete-confirmation" title="Confirm Delete" style="background-color:#f9f9f9; color:#333;">

        Are you sure you want to delete this agenda?


</div>

<script>
$(document).ready(function() {
    // Initialize the dialog
    $("#delete-confirmation").dialog({
        autoOpen: false,
        modal: true,
        close: function(event, ui) {
            $(".message-content").html("Are you sure you want to delete this agenda?");
            $(this).dialog("option", "buttons", {
                "Delete": deleteFunction,
                "Cancel": function() {
                    $(this).dialog("close");
                }
            });
        },
        buttons: {
            "Delete": deleteFunction,
            "Cancel": function() {
                $(this).dialog("close");
            }
        }
    });
    // When a delete button is clicked using event delegation
    $('ul[data-role="listview"]').on('click', '.delete-button', function(e) {
        e.preventDefault();
        var id_agenda = $(this).data('id');
        // Store the id in the dialog's data and open the dialog
        $("#delete-confirmation").data('id', id_agenda).dialog('open');
    });
    function deleteFunction() {
        var id_agenda = $(this).data('id');
        // Make AJAX request
        $.ajax({
            url: '../reg/save.asp',
            method: 'POST',
            data: {
                'action': 'delete',
                'id_agenda': id_agenda
            },
            success: function(response) {
                if(response.trim() === "success") {
                    $("#delete-confirmation .message-content").html("Agenda deleted successfully.");
                    $("#delete-confirmation").dialog("option", "buttons", {
                        "OK": function() {
                            $(this).dialog("close");
                            location.reload(true);
                        }
                    });
                } else {
                    $("#delete-confirmation .message-content").html("There was an error deleting the agenda.");
                    $("#delete-confirmation").dialog("option", "buttons", {
                        "OK": function() {
                            $(this).dialog("close");
                            location.reload(true);
                        }
                    });
                }
            },
            error: function(jqXHR, textStatus, errorThrown) {
                console.log('Error with AJAX request:', textStatus, errorThrown);
                $("#delete-confirmation .message-content").html("An unexpected error occurred. Please try again.");
                $("#delete-confirmation").dialog("option", "buttons", {
                    "OK": function() {
                        $(this).dialog("close");
                        location.reload(true);
                    }
                });
            }
        });
    }
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
        .confirm-dialog{
            z-index: 1000;
        }
</style>
<!--#include file="../shared/footer.asp"-->
</body>
<!--#include file="../closedb.asp"-->
</html>