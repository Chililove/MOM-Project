<!--#include file="../login/protect.inc"-->
<!--#include file="../opendb.asp"-->
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
    padding: 1% 1%;
  }

  .small-button {
    padding: .6% 2%; /* Adjust padding to control button size */
    background-color: #E9E9E9; 
    border-radius: 5px; /* Rounded corners */
    text-decoration: none;
    margin-bottom: .5%;
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
</style>

<body>
<div data-role="header" data-id="header" data-position="fixed">
		<h1>Agenda points</h1>
			<a class="ui-btn-left" href="../default.asp" data-ajax="false" data-icon="home">
				Home
			</a>
	</div>

<div style="display:flex; justify-content:center; align-items: center; margin-top: 3.5%; margin-left: 1%; margin-right: 1%; ">
    <select id="id_agenda" required onchange="updateAgendaTitle(); filterAgendaPoints();">
        <option value="">Select a meeting</option>
        <% 
        SQL3 = "SELECT * FROM tbl_agenda WHERE id_company = '" & session("id_company") & "' ORDER BY moede_navn"
        Set objRS3 = conn.Execute(SQL3)

        Do While Not objRS3.EOF
            Dim id_agenda
            Dim moede_navn
            id_agenda = objRS3("id_agenda")
            moede_navn = objRS3("moede_navn")
        %>
        <option value="<%=id_agenda%>" data-agenda-name="<%=moede_navn%>"><%=moede_navn%></option>
        <% 
            objRS3.MoveNext
        Loop
        objRS3.Close
        Set objRS3 = Nothing
        %>
    </select>

</div>
<div id="agendaPointsContainer">
 <div class="small-button-container">
<!--<h2>Add your agendapoints here</h2>-->
    <a class="small-button" data-ajax="false" onclick="redirectToNextPage()">
      <span class="plus-sign"></span> Add an agenda point
    </a>
  </div>
    <h3 id="agendaTitle" style="margin-left: .4%;">Existing agendapoints<span id="selectedAgendaName" style="font-size: 16px !important;"></span></h3>
    <table class="agenda-table" style="width: 100%; background-color: #E9E9E9; padding: .5%;" >
        <tr style="text-align: left;">
            <th style="width: 25%">Point</th>
            <th style="width: 25%">Date</th>
            <th style="width: 25%">Assigned</th>
        </tr>
    </table>
    <ul id="agendaList" data-role="listview" data-inset="false">
        <% 
        ' Initialize your database query
        SQL = "SELECT * FROM tbl_agendapoints" ' Fetch all agenda points

        ' Create a Command object and set its properties
        Set cmd = Server.CreateObject("ADODB.Command")
        Set cmd.ActiveConnection = conn
        cmd.CommandText = SQL
        ' Create a Recordset object and open it using the Command object
        'response.write SQL
        Set rs = cmd.Execute

        ' Check if the recordset is not empty before entering the loop
        If Not rs.EOF Then
            ' if the Recordset is not empty, so enter the loop
            Do While Not rs.EOF
        %>
        <li data-agenda-id="<%=rs("id_agenda")%>">
            <a data-ajax="false" href='agendapoint_page.asp?action=show&amp;id_agendapoint=<%=rs("id_agendapoint")%>'>
                <table style="width: 100%">  
                    <tr>
                        <td style="width: 25%"><%=rs("point_name")%></td>
                        <td style="width: 25%"><%=rs("dato")%></td>
                    </tr>
                      <!-- Delete button for each agenda -->
               <% If session("administrator") = True Then %>
<button class="delete-button" data-id="<%=rs("id_agendapoint")%>">Delete</button>
<%end if%>
                </table>
            </a>
        </li>
        <%
                rs.MoveNext
            Loop
        Else
            ' Recordset is empty, display a message to the user
        %>
        <li>
            <span>No data</span>
        </li>
        <%
        End If

        ' Close the recordset
        rs.Close
        Set rs = Nothing
        %>
    </ul>
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
            $(".message-content").html("Are you sure you want to delete this agenda point?");
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
            url: '../reg/save_agendapoints.asp',
            method: 'POST',
            data: {
                'action': 'delete',
                'id_agendapoint': id_agendapoint
            },
            success: function(response) {
                if(response.trim() === "success") {
                    $("#delete-confirmation .message-content").html("Agenda point deleted successfully.");
                    $("#delete-confirmation").dialog("option", "buttons", {
                        "OK": function() {
                            $(this).dialog("close");
                            location.reload(true);
                        }
                    });
                } else {
                    $("#delete-confirmation .message-content").html("There was an error deleting the agenda point.");
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
</div>
<script>
function redirectToNextPage() {
    var selectedAgendaId = document.getElementById("id_agenda").value;
    if (selectedAgendaId) {
        // Redirect to the next page with the selected agenda ID
        window.location.href = "agendapoint_page.asp?id_agenda=" + selectedAgendaId + "&action=newpoint";
    } else {
        alert("Please select a meeting before proceeding.");
    }
}

function updateAgendaTitle() {
    var selectedAgendaName = document.getElementById("id_agenda").options[document.getElementById("id_agenda").selectedIndex].getAttribute("data-agenda-name");
    var selectedAgendaNameSpan = document.getElementById("selectedAgendaName");
    
    if (selectedAgendaNameSpan) {
        selectedAgendaNameSpan.innerText = selectedAgendaName;
    }
    
    var agendaTitle = document.getElementById("agendaTitle");
    if (agendaTitle) {
        agendaTitle.innerText = "Existing agenda Points for: " + selectedAgendaName;
    }
}

function filterAgendaPoints() {
    var selectedAgendaId = document.getElementById("id_agenda").value;
    var agendaPoints = document.querySelectorAll("#agendaList li");

    // Hide all agenda points initially
    for (var i = 0; i < agendaPoints.length; i++) {
        agendaPoints[i].style.display = "none";
    }

    // Show only agenda points for the selected agenda
    if (selectedAgendaId) {
        var selectedAgendaPoints = document.querySelectorAll("#agendaList li[data-agenda-id='" + selectedAgendaId + "']");
        for (var j = 0; j < selectedAgendaPoints.length; j++) {
            selectedAgendaPoints[j].style.display = "block";
        }
    }
}
</script>
</body>
<!--#include file="../closedb.asp"-->
