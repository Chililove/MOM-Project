<!--#include file="../login/protect.inc"-->
<!--#include file="../opendb.asp"-->

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="../jquery/jquery.mobile-1.4.5.css">
    <link rel="stylesheet" href="../shared/global.css">
    <script src="../jquery/jquery-1.8.2.min.js"></script>
    <script src="../jquery/jquery.mobile-1.4.5.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.17.5/xlsx.full.min.js"></script>
</head>

<style>
    #agendaDetails {
        width:50%;
        position:relative;
    }
    @media (max-width: 800px){
        #agendaDetails {
            width:90%;
        }
    }
    .agenda-details {
        margin-top: 20px;
        padding: 10px;
        /* border: 1px solid #ccc; */
    }
</style>

<body>
    <div data-role="header" data-id="header" data-position="fixed">
        <h1>Agenda</h1>
        <a class="ui-btn-left" href="../default.asp" data-ajax="false" data-icon="home">
            Home
        </a>
    </div>

    <div id="agendaSelectionContainer" style="margin: 20px auto; width:50%;">
        <select id="id_agenda" required onchange="loadAgendaDetails()">
            <option style="display:none;" value="">Select a meeting</option>
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

    <div id="agendaDetails" class="agenda-details" style="display: none; margin: 0 auto;">
        <!-- The selected agenda details loaded here -->
    </div>

    
    <script>
    function loadAgendaDetails() {
        var selectedAgendaId = document.getElementById("id_agenda").value;
                console.log('Selected Agenda ID:', selectedAgendaId);


        // Check if a valid agenda is selected
        if (selectedAgendaId !== undefined && selectedAgendaId !== null) {
            // Make an AJAX request to fetch agenda details
            $.ajax({
                url: './get_agenda_details.asp',
                method: 'POST',
                data: {
                    'id_agenda': selectedAgendaId
                },
                success: function(response) {
                    // Display the agenda details on the page
                    document.getElementById("agendaDetails").innerHTML = response;
                    document.getElementById("agendaDetails").style.display = "block";
                },
                error: function(jqXHR, textStatus, errorThrown) {
                    console.log('Error with AJAX request:', textStatus, errorThrown);
                }
            });
        } else {
            // Hide agenda details if no agenda is selected
            document.getElementById("agendaDetails").style.display = "none";
        }
    } 
    </script>
   <script>
        function exportToExcel1() {
            var table = document.getElementById('table1');
            var filename = 'Meeting_data.xlsx';

            /* SheetJS library function to export table to Excel */
            var ws = XLSX.utils.table_to_sheet(table);
            var wb = XLSX.utils.book_new();
            XLSX.utils.book_append_sheet(wb, ws, 'Sheet 1');

            /* Save to file */
            XLSX.writeFile(wb, filename);
        }
        function exportToExcel2() {
            var table = document.getElementById('table2');
            var filename = 'Agendapoint_data.xlsx';

            /* SheetJS library function to export table to Excel */
            var ws = XLSX.utils.table_to_sheet(table);
            var wb = XLSX.utils.book_new();
            XLSX.utils.book_append_sheet(wb, ws, 'Sheet 1');

            /* Save to file */
            XLSX.writeFile(wb, filename);
        }
    </script>
</body>
<!--#include file="../closedb.asp"-->
