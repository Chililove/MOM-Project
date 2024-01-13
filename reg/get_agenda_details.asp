<!--#include file="../opendb.asp"-->
<!--#include file="../login/protect.inc"-->
<%
    selectedAgendaId = Request.QueryString("id_agenda")
    'Response.Write("Received Agenda ID: " & selectedAgendaId & "<br>")

    If IsNumeric(selectedAgendaId) Then
        SQL = "SELECT * FROM qry_agendashowing WHERE id_agenda = " & selectedAgendaId
        Set rs = conn.Execute(SQL)

        moede_navn = rs("moede_navn")
        emne = rs("emne")
        beskrivelse = rs("beskrivelse")
        noter = rs("noter")
        additionalinfo = rs("additionalinfo")
        oprettetaf = rs("oprettetaf")
        oprettetdato = rs("oprettetdato")
        starttid = rs("starttid")
        id_meetingtype = rs("id_meetingtype")
        id_afdeling = rs("id_afdeling")
        moede_dato = rs("moede_dato")
        moede_tidspunkt = rs("moede_tidspunkt")
        id_company = rs("id_company")
        participants = rs("participants")

        'Response.Write("Selected Agenda ID: " & selectedAgendaId & "<br>")
        'Response.Write("SQL Query: " & SQL & "<br>")

        %>
        <style>
            * {
                text-shadow:none !important;
            }
            .agenda-cont {
                background-color: lightgrey;
                border-radius: 0  7%  0  7% ;
                border-top:2px solid orange;
                box-shadow: 5px 6px 8px grey;
                padding: 25px;
            }
            .data-cont { 
                border-bottom:1px dashed grey;
                display: flex;
                justify-content:space-between;
            }
            .data-cont > div:last-child {
                text-align:right;
            }
            .agendapoints { 
                background-color: #b5b5b5;
                /* border-radius:  7%  0  7%  0; */
                border-radius:  15px;
                padding: 25px;
                margin: 10px 0;
            }
            .apflex-cont {
                display:flex;
                flex-wrap:wrap;
                justify-content:center;    
            }
            .ap-cont {
                width:200px;
                background-color: lightgrey;
                border-radius: 0  7%  0  7% ;
                border-top:2px solid orange;
                box-shadow: 5px 6px 8px grey;
                padding: 25px;
                margin: 30px;
            }
            .apdata-cont {
                display:flex;
                flex-direction:column;
            }
            ::marker {
                color:orange;
                font-size:20px;
            }

            #table1, #table2 { 
                /* visibility:hidden; */
                display:none;
            }
            #exportButton1 { 
                position:absolute;
                top:400px;
                left:50px;
                font-size:10px;
            }
            #exportButton2 { 
                position:absolute;
                top:400px;
                right:50px;
                font-size:10px;
            }
        </style>
        <div class="agenda-cont">
            <div class="agendadata">
                <div>
                    <b>
                    <h3> <%=moede_navn%></h3>
                    </b>
                </div>
                <div class="data-cont">
                    <div>
                        <b>Emne:</b>
                    </div>
                    <div>
                        <%=emne%>
                    </div>
                </div>
                <div class="data-cont">
                    <div>
                        <b>Beskrivelse:</b>
                    </div>
                    <div>
                        <%=beskrivelse%>
                    </div>
                </div>
                <div class="data-cont">
                    <div>
                        <b>Noter:</b>
                    </div>
                    <div>
                        <%=noter%>
                    </div>
                </div>
                <div class="data-cont">
                    <div>
                        <b>Yderligere Info:</b>
                    </div>
                    <div>
                        <%=additionalinfo%>
                    </div>
                </div>
                <div class="data-cont">
                    <div>
                        <b>Oprettet Af:</b>
                    </div>
                    <div>
                        <%=oprettetaf%>
                    </div>
                </div>
                <div class="data-cont">
                    <div>
                        <b>Oprettet Dato:</b>
                    </div>
                    <div>
                        <%=oprettetdato%>
                    </div>
                </div>
                <div class="data-cont">
                    <div>
                        <b>Møde Start Tid:</b>
                    </div>
                    <div>
                        <%=starttid%>
                    </div>
                </div>
                
                <div class="data-cont">
                    <div>
                        <b>Møde Type:</b>
                    </div>
                    <div>
                        <%=id_meetingtype%>
                    </div>
                </div>
                <div class="data-cont">
                    <div>
                        <b>Afdeling:</b>
                    </div>
                    <div>
                        <%=id_afdeling%>
                    </div>
                </div>
            
                <div class="data-cont">
                    <div>
                        <b>Møde Dato:</b>
                    </div>
                    <div>
                        <%=moede_dato%>
                    </div>
                </div>
                <div class="data-cont">
                    <div>
                        <b>Møde Tidspunkt:</b>
                    </div>
                    <div>
                        <%=FormatTime(moede_tidspunkt)%>
                    </div>
                </div>
                <div class="data-cont">
                    <div>
                        <b>Firma:</b>
                    </div>
                    <div>
                        <%=id_company%>
                    </div>
                </div>
                <div class="data-cont">
                    <div>
                        <b>Mødedeltagere:</b>
                    </div>
                    <div>
                        <% If Not IsNull(rs("participants"))=true And rs("participants") <> "" Then 
                            participants = Split(rs("participants"), ",")
                            For Each participant In participants
                                    SQL="SELECT * FROM tbllogin WHERE id_login = "& participant &" "
                                    'response.write SQL
                                    Set RSparticipants = Conn.Execute(SQL) %>
                                    <%=RSparticipants("fornavn")%>&nbsp;<%=RSparticipants("efternavn")%>,&nbsp;
                            <% Next
                        End If %>
                    </div>
                </div>
            </div>
            <br>
            <br>
            <details class="agendapoints">
                <summary>
                        <b>
                            Agendapoints
                        </b>
                </summary>
                <% sql_a="SELECT * FROM qry_agendapointshowing WHERE id_agenda = "& selectedAgendaId &"" 
                'response.write sql_a 
                set rs_a=conn.execute(sql_a) 
                    
                %>
                <div class="apflex-cont">
                    <% while not rs_a.eof %>
                        <%'id_agendapoint = rs_a("id_agendapoint")
                        ap_point_name = rs_a("point_name")
                        ap_short_desc = rs_a("short_desc")
                        ap_dato = rs_a("dato")
                        ap_long_desc = rs_a("long_desc")
                        ap_id_login = rs_a("id_login")
                        ap_id_agenda = rs_a("id_agenda")
                        ap_id_company = rs_a("id_company")%>
                        <div class="ap-cont">
                            <div>
                                <b>
                                <h3> <%=ap_point_name%></h3>
                                </b>
                            </div>
                            <div class="apdata-cont">
                                <div>
                                    <div>
                                        <b>Deadling:</b>
                                    </div>
                                    <div>
                                        <%=ap_dato%>
                                    </div>
                                </div>
                                <div>
                                    <div>
                                        <b>Short description:</b>
                                    </div>
                                    <div>
                                        <%=ap_short_desc%>
                                    </div>
                                </div>
                                 <div>
                                    <div>
                                        <b>Long description:</b>
                                    </div>
                                    <div>
                                        <%=ap_short_desc%>
                                    </div>
                                </div>
                                <div>
                                    <div>
                                        <b>Assigned users:</b>
                                    </div>
                                    <div>
                                        <% If Not IsNull(rs_a("id_login"))=true And rs_a("id_login") <> "" Then 
                                            participants = Split(rs_a("id_login"), ",")
                                            For Each participant In participants
                                                    SQL="SELECT * FROM tbllogin WHERE id_login = "& participant &" "
                                                    'response.write SQL
                                                    Set RSparticipants = Conn.Execute(SQL) %>
                                                    <%=RSparticipants("fornavn")%>&nbsp;<%=RSparticipants("efternavn")%>,&nbsp;
                                            <% Next
                                        End If %>
                                    </div>
                                </div>
                            </div>
                        </div>
                    <% rs_a.movenext()
                    Wend %>
                </div>
            </details>
        </div>
        <!-- excel export table: agenda info -->
        <div style="display:flex; justify-content:center; flex-wrap:wrap;">
            <% If not RS.EOF then %>
            <button id="exportButton1"  onclick="exportToExcel1()">Export Agenda Info to Excel</button>
            <table id="table1" style="font-size:13px;">
                <thead>
                    <tr>
                        <th>Mødenavn</th>
                        <th>Emne</th>
                        <th>Beskrivelse</th>
                        <th>Noter</th>
                        <th>Yderligere Info</th>
                        <th>Oprettet Af</th>
                        <th>Oprettet Dato</th>
                        <th>Møde Start Tid</th>
                        <th>Møde Type</th>
                        <th>Afdeling</th>
                        <th>Møde Dato</th>
                        <th>Møde Tidspunkt</th>
                        <th>Firma</th>
                        <th>Mødedeltagere</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td> <%=moede_navn%> </td>
                        <td> <%=emne%> </td>
                        <td> <%=beskrivelse%> </td>
                        <td> <%=noter%> </td>
                        <td> <%=additionalinfo%> </td>
                        <td> <%=oprettetaf%> </td>
                        <td> <%=oprettetdato%> </td>
                        <td> <%=starttid%> </td>
                        <td> <%=id_meetingtype%> </td>
                        <td> <%=id_afdeling%> </td>
                        <td> <%=moede_dato%> </td>
                        <td> <%=moede_tidspunkt%> </td>
                        <td> <%=id_company%> </td>
                        <td> <% If Not IsNull(rs("participants"))=true And rs("participants") <> "" Then 
                            participants = Split(rs("participants"), ",")
                            For Each participant In participants
                                    SQL="SELECT * FROM tbllogin WHERE id_login = "& participant &" "
                                    'response.write SQL
                                    Set RSparticipants = Conn.Execute(SQL) %>
                                    <%=RSparticipants("fornavn")%>&nbsp;<%=RSparticipants("efternavn")%>,&nbsp;
                            <% Next
                        End If %> </td>
                    </tr>
                </div>
                </tbody>
            </table>
            <% End if %>
        </div>
        <!-- excel export table: agendapoints info -->
        <div style="display:flex; justify-content:center; flex-wrap:wrap;">
            <% 'response.write sql_a
            If not RS.EOF then %>
            <button id="exportButton2"  onclick="exportToExcel2()">Export Agenda Points to Excel</button>
            <table id="table2" style="font-size:13px;">
                <thead>
                    <tr>
                        <th>Pointnavn</th>
                        <th>Beskrivelse</th>
                        <th>Dato</th>
                        <th>Yderligere Info</th>
                        <th>Agenda</th>
                        <th>Firma</th>
                        <th>Mødedeltagere</th>
                    </tr>
                </thead>
                <tbody>
                    <% sql_a="SELECT * FROM qry_agendapointshowing WHERE id_agenda = "& selectedAgendaId &"" 
                        'response.write sql_a 
                        set rs_a=conn.execute(sql_a) 
                        %>
                    <% while not rs_a.eof %>
                    <%'id_agendapoint = rs_a("id_agendapoint")
                        ap_point_name = rs_a("point_name")
                        ap_short_desc = rs_a("short_desc")
                        ap_dato = rs_a("dato")
                        ap_long_desc = rs_a("long_desc")
                        ap_id_login = rs_a("id_login")
                        ap_id_agenda = rs_a("id_agenda")
                        ap_id_company = rs_a("id_company")%>
                    <tr>
                        <td> <%=ap_point_name%> </td>
                        <td> <%=ap_short_desc%> </td>
                        <td> <%=ap_dato%> </td>
                        <td> <%=ap_long_desc%> </td>
                        <td> <%=ap_id_agenda%> </td>
                        <td> <%=ap_id_company%> </td>
                        <td> 
                            <% If Not IsNull(rs_a("id_login"))=true And rs_a("id_login") <> "" Then 
                                participants = Split(rs_a("id_login"), ",")
                                For Each participant In participants
                                        SQL="SELECT * FROM tbllogin WHERE id_login = "& participant &" "
                                        'response.write SQL
                                        Set RSparticipants = Conn.Execute(SQL) %>
                                        <%=RSparticipants("fornavn")%>&nbsp;<%=RSparticipants("efternavn")%>,&nbsp;
                                <% Next
                            End If %> 
                        </td>
                    </tr>
                    <% rs_a.movenext()
                    Wend %>
                </div>
                </tbody>
            </table>
            <% End if %>
        </div>

 <%
Function FormatTime(time)
    Dim timeString
    timeString = CStr(time)
    FormatTime = Left(timeString, 5)
End Function

%>
        <% 


    End If 
%>
    
<!--#include file="../closedb.asp"-->
