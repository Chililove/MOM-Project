<!--#include file="../login/protect.inc"-->
<!--#include file="../opendb.asp"-->

<HTML>
<HEAD>
   <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" >
</HEAD>
<BODY>
    
<%
' Define variables for CRUD operations
Dim action, cmd, sql, company_id, meeting_type, id_meetingtype, ErrMsg

' Get the action parameter from the request
action = Trim(Request("action"))
company_id = Trim(Session("id_company"))
id_meetingtype = Trim(Request.QueryString("id_meetingtype"))
meeting_type = Trim(Request.Form("meeting_type"))

' Protect against SQL injection by validating all inputs
If meeting_type = "" Then
    ErrMsg = "Meeting type cannot be empty."
End If

If ErrMsg = "" Then
    ' CREATE a new meeting type
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
        
    ' UPDATE an existing meeting type
    ElseIf action = "update" Then
    Response.Write("Action1: " & action & "<br>")
Response.Write("Company1 ID: " & company_id & "<br>")
Response.Write("Meeting1 Type ID: " & id_meetingtype & "<br>")
Response.Write("Meeting1 Type: " & meeting_type & "<br>")

        ' Prepare the SQL statement for UPDATE
        sql = "UPDATE tblmeeting_type SET meeting_type = ? WHERE id_meetingtype = ?"
        Set cmd = Server.CreateObject("ADODB.Command")
        cmd.ActiveConnection = Conn
        cmd.CommandText = sql
        cmd.CommandType = 1 'adCmdText
        cmd.Parameters.Append cmd.CreateParameter("@meeting_type", 202, 1, 50, meeting_type)
        cmd.Parameters.Append cmd.CreateParameter("@id_meetingtype", 3, 1, , id_meetingtype)

Response.Write("Action: " & action & "<br>")
Response.Write("Comp2any ID: " & company_id & "<br>")
Response.Write("Meet2ing Type ID: " & id_meetingtype & "<br>")
Response.Write("Me4eting Type: " & meeting_type & "<br>")

        ' Execute the UPDATE command
        On Error Resume Next
        cmd.Execute
        If Err.Number <> 0 Then
            ErrMsg = "An error occurred during meeting type update: " & Err.Description
        Else
            ErrMsg = "Meeting type updated successfully."
        End If
        On Error GoTo 0
        Set cmd = Nothing

    ' DELETE an existing meeting type
    ElseIf action = "delete" Then
        ' Prepare the SQL statement for DELETE
        sql = "DELETE FROM tblmeeting_type WHERE id_meetingtype = ? AND id_company = ?"
        Set cmd = Server.CreateObject("ADODB.Command")
        cmd.ActiveConnection = Conn
        cmd.CommandText = sql
        cmd.CommandType = 1 'adCmdText
        cmd.Parameters.Append cmd.CreateParameter("@id_meetingtype", 3, 1, , id_meetingtype)
        cmd.Parameters.Append cmd.CreateParameter("@id_company", 3, 1, , company_id)

        ' Execute the DELETE command
        On Error Resume Next
        cmd.Execute
        If Err.Number <> 0 Then
            ErrMsg = "An error occurred during meeting type deletion: " & Err.Description
        Else
            ErrMsg = "Meeting type deleted successfully."
        End If
        On Error GoTo 0
        Set cmd = Nothing
    End If
End If

' Redirect or display a message based on the action result
If Len(ErrMsg) > 0 Then
    Response.Write("<script>alert('" & ErrMsg & "'); window.location.href='/reg_list/meetingtype_list.asp?id_company=" & company_id & "';</script>")
Else
    Response.Redirect "/reg_list/meetingtype_list.asp?id_company=" & company_id ' Redirect to the meeting type list or appropriate page
End If
%>
</BODY>
</HTML>
<!--#include file="../closedb.asp"-->
