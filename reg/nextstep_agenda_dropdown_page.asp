<!--#include file="../login/protect.inc"-->
<!--#include file="../opendb.asp"-->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" >
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="../jquery/jquery.mobile-1.4.5.css">
<link rel="stylesheet" href="../shared/global.css">
<script src="../jquery/jquery-1.8.2.min.js"></script>
<script src="../jquery/jquery.mobile-1.4.5.min.js"></script>
<script>
    function del(id) { 
        var idValue = id
        
        if (idValue !== null) {
            var firstConfirm = window.confirm("Are you sure you want to delete this agenda point?");
            
            if (firstConfirm) {
            var secondConfirm = window.confirm("This action is irreversible. Are you absolutely sure?");
            
            if (secondConfirm) {
                var deleteUrl = 'delete.asp?action=aptype&id=' + encodeURIComponent(id);
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
</head>

<style>
.agenda-table{
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
@keyframes fade-in {
    from {
        opacity: 0;
        transform: scale(0);
    }

    to {
        opacity: 1;
        transform: scale(1);
    }
}

.fade-in {
    animation: fade-in 1s;
}


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
  margin-top: -260px;
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
</style>
<body>
<div data-role="header" data-id="header" data-position="fixed">
		<h1>Agenda points</h1>
			<a class="ui-btn-left" href="../default.asp" data-ajax="false" data-icon="home">
				Home
			</a>
	</div>


<div id="agendaPointsContainer">
<div style="display:flex; justify-content:center; align-items: center; margin-top: 3.5%; margin-left: 1%; margin-right: 1%; animation: fadeIn 2s ease; ">
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
<div id="logo">
        <img id="imglogo"src="../Login/Game-On.png" />
    </div>
 <div class="small-button-container">
    <a class="small-button" data-ajax="false" onclick="redirectToNextPage()">
      <span class="plus-sign"></span> Add an agenda point
    </a>
  </div>

    <h3 id="agendaTitle" style="margin-left: .4%; animation: fadeIn 2s ease;">Existing agendapoints<span id="selectedAgendaName" style="font-size: 16px !important;"></span></h3>
    <table class="agenda-table" style="width: 100%; background-color: #E9E9E9; padding: .5%;">
        <tr class="fade-in" style="text-align: left; animation-duration: 200ms;">
            <th style="width: 25%">Point</th>
            <th style="width: 25%">Date</th>
            <th style="width: 25%">Assigned</th>
        </tr>
    </table>
    <ul id="agendaList" data-role="listview" data-inset="false" data-filter="true">
        <% 
        ' Initialize your database query
        SQL = "SELECT * FROM tbl_agendapoints" ' Fetch all agenda points

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
            <a data-ajax="false" href='agendapoint_page.asp?action=show&amp;id_agendapoint=<%=rs("id_agendapoint")%>&source=page1'>
                <table style="width: 100%">  
                    <tr class="fade-in" atyle="animation-duration: 300ms;">
                        <td style="width: 25%"><%=rs("point_name")%></td>
                        <td style="width: 25%"><%=FormatDateTime(rs("dato"))%></td>
                        <td style="width: 25%">
                        
                        <% 
                            If Not IsNull(rs("id_login"))=true And rs("id_login") <> "" Then 
                                participants = Split(rs("id_login"), ",")
                                For Each participant In participants
                                        SQL="SELECT * FROM tbllogin WHERE id_login = "& participant &" "
                                        'response.write SQL
                                        Set RSparticipants = Conn.Execute(SQL) %>
                                        <%=RSparticipants("fornavn")%>&nbsp;<%=RSparticipants("efternavn")%>,&nbsp;
                                <% Next
                            End If %>
                        </td>
                    </tr>
                      <!-- Delete button for each agenda -->
               <% If session("administrator") = True Then %>
            <button onclick='del("<%=rs("id_agendapoint")%>")' class="delete-button" style="animation: fade-in 2s; animation-duration: 400ms;" >Delete</button>
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
