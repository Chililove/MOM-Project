<!--#include file="../login/protect.inc"-->
<!--#include file="../opendb.asp"-->
<!DOCTYPE>
<%
' Check if the user is an administrator
If Not session("administrator") Then
    ' If not an administrator, redirect them to an error page or some other action
    Response.Redirect("../default.asp") ' Change "access_denied.asp" to the appropriate page
End If
%>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" >
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="../jquery/jquery.mobile-1.4.5.css">
<script src="../jquery/jquery-1.8.2.min.js"></script>
<script src="../jquery/jquery.mobile-1.4.5.min.js"></script>
</head>
<style>
   /* Style for the smaller button */
  .small-button-container {
    display: flex;
    justify-content: flex-end;
    align-items: center;
    padding: 10px; 
  }

  .small-button {
    padding: 12px 16px; /* Adjust padding to control button size */
    color: grey; 
    border-radius: 5px; /* Rounded corners */
    text-decoration: none;
  }

  /* Hover effect for the smaller button */
  .small-button:hover {
    background-color: transparent;
    text-decoration: none;
	  box-shadow: 0px 4px 6px rgba(0, 0, 0.2, 0.2);

  }

  /* Style for the plus sign */
  .plus-sign::before {
    content: "+"; /* Content is a plus sign */
    font-weight: bold;
    margin-right: 5px; /* Add spacing between plus sign and text */
  }

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
<body>
	<div data-role="header" data-id="header" data-position="fixed">
		<h1>Meetingtypes</h1>
			<a class="ui-btn-left" href="../default.asp" data-ajax="false" data-icon="home">
				Home
			</a>
	</div>
<%
sql="select * from tblmeeting_type where id_company =  " & session("id_company") & "order by meeting_type desc "
set rs=conn.execute(sql)
%>
	<ul data-role="listview" data-inset="false" data-filter="true">
<h2 style="padding: 1%; height: .5px;">Existing meetingtypes</h2>

<div class="small-button-container">
    <a class="small-button" data-ajax="false" href="../reg/meetingtype_page.asp?action=create">
      <span class="plus-sign"></span> Add a new meetingtype
    </a>
  </div>
				<li data-role="list-divider">
					<table style="width: 100%">
						<tr style="text-align: left">
							<th style="width: 25%">type</th>
						</tr>
					</table>
				</li>
				<%
					do while not rs.eof
				%>
				<li>
					<a data-ajax="false" href='../reg/meetingtype_page.asp?action=update&amp;id_meetingtype=<%=rs("id_meetingtype")%>'>

						<table style="width: 100%">		
								<tr>
									<td style="width: 25%"><%=rs("meeting_type")%></td>
								</tr>
                 <% If session("administrator") = True Then %>
<button class="delete-button" data-id="<%=rs("id_meetingtype")%>">Delete</button>
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
 
        Are you sure you want to delete this meeting type?


</div>

<script>
$(document).ready(function() {
    // Initialize the dialog
    $("#delete-confirmation").dialog({
        autoOpen: false,
        modal: true,
        close: function(event, ui) {
            $(".message-content").html("Are you sure you want to delete this meeting type?");
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
        var id_meetingtype = $(this).data('id');
        // Store the id in the dialog's data and open the dialog
        $("#delete-confirmation").data('id', id_meetingtype).dialog('open');
    });

    function deleteFunction() {
        var id_meetingtype = $(this).data('id');
        // Make AJAX request
        $.ajax({
            url: '../reg/save_meetingtype.asp',
            method: 'POST',
            data: {
                'action': 'delete',
                'id_meetingtype': id_meetingtype
            },
            success: function(response) {
                if(response.trim() === "success") {
                    $("#delete-confirmation .message-content").html("Meeting type deleted successfully.");
                    $("#delete-confirmation").dialog("option", "buttons", {
                        "OK": function() {
                            $(this).dialog("close");
                            location.reload(true);
                        }
                    });
                } else {
                    $("#delete-confirmation .message-content").html("There was an error deleting the meeting type.");
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
<!--#include file="../shared/footer.asp"-->
</body>
<!--#include file="../closedb.asp"-->
</html>
