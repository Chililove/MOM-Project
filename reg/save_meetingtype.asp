<!--#include file="../login/protect.inc"-->
<!--#include file="../opendb.asp"-->

<HTML>
<%
' Check if the user is an administrator
If Not session("administrator") Then
    ' If not an administrator, redirect them to an error page or some other action
    Response.Redirect("../default.asp") ' Change "access_denied.asp" to the appropriate page
End If
%>
<HEAD>
   <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" >
</HEAD>
<BODY>
       <%
Dim receivedIdMeetingType
receivedIdMeetingType = Request.QueryString("id_meetingtype")
Response.Write("Received id_meetingtype: " & receivedIdMeetingType & "<br>")
%>
<%
<%
' Define variables for CRUD operations
Dim action, cmd, sql, company_id, afdeling, id_afdeling, ErrMsg

' Get the action parameter from the request
action = Trim(Request("action"))
company_id = Trim(Session("id_company"))
id_meetingtype = Trim(Request("id_meetingtype"))   'NO request querystring, It gave me this value error for so long and this was the fix..
meeting_type = Trim(Request.Form("meeting_type"))

' Protect against SQL injection by validating all inputs
If id_meetingtype = "" Then
    ErrMsg = "This id cannot be empty."
ElseIf Not IsNumeric(id_meetingtype) Then
    ErrMsg = "Id must be numeric."
End If

ErrMsg = ""
If ErrMsg = "" Then
    ' CREATE a new type
    If action = "create" Then
        ' Prepare the SQL statement for INSERT
        sql = "INSERT INTO tblmeeting_type (meeting_type, id_company) VALUES (?, ?)"
        Set cmd = Server.CreateObject("ADODB.Command")
        cmd.ActiveConnection = Conn
        cmd.CommandText = sql
        cmd.CommandType = 1 'adCmdText
        cmd.Parameters.Append cmd.CreateParameter("@meeting_type", 202, 1, 50, meeting_type)
        cmd.Parameters.Append cmd.CreateParameter("@id_company", 3, 1, , company_id)

        ' Execute the INSERT command
        On Error Resume Next
        cmd.Execute
        If Err.Number <> 0 Then
            ErrMsg = "An error occurred during meeting type creation: " & Err.Description
        Else
            ErrMsg = "Meeting type created successfully."
        End If
        On Error GoTo 0
        Set cmd = Nothing
        
    ' UPDATE an existing type
    ElseIf action = "update" Then
    Response.Write("Action1: " & action & "<br>")
Response.Write("Company1 ID: " & company_id & "<br>")
Response.Write("meeting Type ID: " & id_meetingtype & "<br>")
Response.Write("meeting Type: " & meeting_type & "<br>")

        ' Prepare the SQL statement for UPDATE
            id_meetingtype = Request.QueryString("id_meetingtype")

        sql = "UPDATE tblmeeting_type SET meeting_type = ? WHERE id_meetingtype = ?"
        Set cmd = Server.CreateObject("ADODB.Command")
        cmd.ActiveConnection = Conn
        cmd.CommandText = sql
        cmd.CommandType = 1 'adCmdText
        cmd.Parameters.Append cmd.CreateParameter("@meeting_type", 202, 1, 50, meeting_type)
        cmd.Parameters.Append cmd.CreateParameter("@id_meetingtype", 3, 1, , id_meetingtype)

Response.Write("Action: " & action & "<br>")
Response.Write("Comp2any ID: " & company_id & "<br>")
Response.Write("meeting2 Type ID: " & id_meetingtype & "<br>")
Response.Write("meeting2 Type: " & meeting_type & "<br>")

        ' Execute the UPDATE command
        On Error Resume Next
        cmd.Execute
        If Err.Number <> 0 Then
            ErrMsg = "An error occurred during meeting typw update: " & Err.Description
        Else
            ErrMsg = "Meeting type updated successfully."
        End If
        On Error GoTo 0
        Set cmd = Nothing

    ' DELETE an existing meeting type
    ElseIf action = "delete" Then
response.Write("Delete action triggered<br>")
    Response.Write("id_meetingtype: " & id_meetingtype & "<br>")
    Response.Write("company_id: " & company_id & "<br>")
        ' Prepare the SQL statement for DELETE
        sql = "DELETE FROM tblmeeting_type WHERE id_meetingtype = ?"
        Response.Write("SQL Query for deletion: " & sql & "<br>")

        Set cmd = Server.CreateObject("ADODB.Command")
        cmd.ActiveConnection = Conn
        cmd.CommandText = sql
        cmd.CommandType = 1 'adCmdText
        cmd.Parameters.Append cmd.CreateParameter("@id_meetingtype", 3, 1, , id_meetingtype)
      '  cmd.Parameters.Append cmd.CreateParameter("@id_company", 3, 1, , company_id)

        ' Execute the DELETE command
        cmd.Execute
        If Err.Number <> 0 Then
            ErrMsg = "An error occurred during meeting type deletion: " & Err.Description
        Else
            ErrMsg = "Meeting type deleted successfully."
        End If
        Set cmd = Nothing
    End If
    ' Redirect or display a message based on the action result

End If
If Len(ErrMsg) > 0 Then
    Response.Write("<script>alert('" & ErrMsg & "');  window.location.href='/reg_list/meetingtype_list.asp' </script>")
Else
    Response.Redirect "/reg_list/afdeling_list.asp?" ' Redirect to afdeling list
End If

%>
</BODY>
</HTML>
<!--#include file="../closedb.asp"-->


