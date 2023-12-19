<!--#include file="../login/protect.inc"-->
<!--#include file="../opendb.asp"-->

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
        <h1 >List of meetings assigned</h1>
            <a class="ui-btn-left" href="../default.asp" data-ajax="false" data-icon="home">Home</a>
            <a class="ui-btn-right" href="http://mom.main-solution.dk/login/login.asp" data-ajax="false" data-icon="power">logoff</a>
    </div>
<body>

<div data-role="header" data-id="header" data-position="fixed">
		<h1>Assigned meetings</h1>
			<a class="ui-btn-left" href="../default.asp" data-ajax="false" data-icon="home">
				Home
			</a>
	</div>

<div id="savedmeeting-Container" data-filter="true">
<div id="logo">
        <img id="imglogo"src="../Login/Game-On.png" />
    </div>
   <h3 id="savedmeetingTitle" style="margin-left: .4%; animation: fadeIn 2s ease;">Assigned to these meetings<span id="selectedSavedmeeting" style="font-size: 16px !important;"></span></h3>
    <table class="savedmeeting-table" style="width: 100%; background-color: #E9E9E9; padding: .5%;" >
        <tr style="text-align: left;">
            <th style="width: 25%">Meeting name</th>
            <th style="width: 25%">Date</th>
            <th style="width: 25%">Time</th>
        </tr>
    </table>
    <ul id="savedmeetingList" data-role="listview" data-inset="false">
       
       <%
dim id_login, id_company
	id_login = session("id_login")
id_company = session("id_company")

If session("administrator") = True Then

    sql = "SELECT * FROM qrysaved_meetings WHERE id_company =  '" & session("id_company") & "'"
Else
    sql = "SELECT * FROM qrysaved_meetings WHERE id_company ='" & session("id_company") & "' AND id_agenda IN (SELECT id_agenda FROM tbl_agenda WHERE participants LIKE '%" & session("id_login") & "%')"
End If
        ' Create a Command object and set its properties
        Set cmd = Server.CreateObject("ADODB.Command")
        Set cmd.ActiveConnection = conn
        cmd.CommandText = SQL
        ' Creating a Recordset object and i open it using the Command object
        'response.write SQL
        Set rs = cmd.Execute

        ' Check if the recordset is not empty before entering the loop
        If Not rs.EOF Then
            ' if the Recordset is not empty, so enter the loop
            Do While Not rs.EOF
        %>
        <li style="animation: fadeIn 2s ease;" data-agenda-id="<%=rs("id_agenda")%>">
            <a data-ajax="false" href='../reg/list_my.asp?action=show&amp;id_agenda=<%=rs("id_agenda")%>&source=page1'>
                <table style="width: 100%">  
                    <tr>
                        <td style="width: 25%"><%=rs("moede_navn")%></td>
                        <td style="width: 25%"><%=FormatDateTime(rs("moede_dato"))%></td>
                        
                    </tr>
                      <!-- Delete button for each agenda -->
               <% If session("administrator") = True Then %>
            <button onclick='del("<%=rs("id_agenda")%>")' class="delete-button" >Delete</button>
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
    <!--<div id="delete-confirmation" title="Confirm Delete" style="background-color:#f9f9f9; color:#333;">
 
        Are you sure you want to delete this agenda?


</div>-->

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

<style>

          @keyframes fadeInLogo {
  0% {
    opacity: 0; /* Start with 0% opacity */
    transform: scale(1); /* Start slightly scaled down */
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
margin-right: 900px;

}

#imglogo{
  height: 500px;
  width: 500px;
  margin-right: 250px;
  margin-top: -150px;
  transform: scale(0.8);
  margin-bottom: -120px;
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

   .savedmeeting-table{
    animation: fadeIn 2s ease;
}
   /* Style for the smaller button */
  .small-button-container {
    display: flex;
    justify-content: flex-end;
    align-items: center;
    padding: 1% 1%;
    animation: fadeIn 2s ease;
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

  @keyframes fadeIn {
    0% {
        opacity: 0;
    }
    100% {
        opacity: 1;
    }
}
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