<!--#include file="../login/protect.inc"-->
<!--#include file="../opendb.asp"-->

<HTML>
<HEAD>
   <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" >
</HEAD>
<BODY>
    
<%
' Defininng variables for CRUD operations
Dim action, cmd, sql, company_id, meetingtype, id_meetingtype, ErrMsg

' Get the action parameter from the request
action = Trim(Request("action"))
company_id = Trim(Request.QueryString("id_company"))
id_meetingtype = Trim(Request.QueryString("id_meetingtype"))
meetingtype = Request.Form("meeting_type")


' Protect against SQL injection by validating all inputs
If meetingtype = ""  Then
    ErrMsg = "Meetingtype cannot be empty."
End If

If ErrMsg = "" Then
    ' CREATE a new company
    If action = "create" Then
        ' Prepare the SQL statement for INSERT
        sql = "INSERT INTO tblmeeting_type (meeting_type, id_company) VALUES (?, ?)"
        Set cmd = Server.CreateObject("ADODB.Command")
        cmd.ActiveConnection = Conn
        cmd.CommandText = sql
        cmd.CommandType = 1 'adCmdText
        cmd.Parameters.Append cmd.CreateParameter("@meeting_type", 202, 1, 50, meetingtype)
        cmd.Parameters.Append cmd.CreateParameter("@id_company", 3, 1, , id_company)


        
        ' Execute the INSERT command
        On Error Resume Next
        cmd.Execute
        If Err.Number <> 0 Then
            ErrMsg = "An error occurred during meetingtype creation: " & Err.Description
        Else
            ErrMsg = "Meetingtype created successfully."
        End If
        On Error GoTo 0
        Set cmd = Nothing
        
    ' UPDATE an existing company
    ElseIf action = "update" Then
        ' Prepare the SQL statement for UPDATE
        Response.Write("company_id: " & company_id & "<br>")
Response.Write("Data Type: " & VarType(company_id) & "<br>")

        sql = "UPDATE tblmeeting_type SET meeting_type = ?, id_company = ? WHERE id_meetingtype = ?;"
        Set cmd = Server.CreateObject("ADODB.Command")
        cmd.ActiveConnection = Conn
        cmd.CommandText = sql
        cmd.CommandType = 1 'adCmdText
        cmd.Parameters.Append cmd.CreateParameter("@meeting_type", 202, 1, 50, meetingtype)
        cmd.Parameters.Append cmd.CreateParameter("@id_company", 3, 1, , company_id)
                cmd.Parameters.Append cmd.CreateParameter("@id_meetingtype", 3, 1, , id_meetingtype)


Response.Write("company_id after: " & company_id & "<br>")
Response.Write("Data Type after: " & VarType(company_id) & "<br>")


        
        ' Execute the UPDATE command
        On Error Resume Next
        cmd.Execute
        If Err.Number <> 0 Then
            ErrMsg = "An error occurred during meetingtype update: " & Err.Description
        Else
            ErrMsg = "Meetingtype updated successfully."
        End If
        On Error GoTo 0
        Set cmd = Nothing

    ' DELETE an existing company
    ElseIf action = "delete" Then
        ' Prepare the SQL statement for DELETE
        sql = "DELETE FROM tblmeeting_type WHERE id_meetingtype = ?"
        Set cmd = Server.CreateObject("ADODB.Command")
        cmd.ActiveConnection = Conn
        cmd.CommandText = sql
        cmd.CommandType = 1 'adCmdText
        cmd.Parameters.Append cmd.CreateParameter("@id_meetingtype", 3, 1, , id_meetingtype)
        
        ' Execute the DELETE command
        On Error Resume Next
        cmd.Execute
        If Err.Number <> 0 Then
            ErrMsg = "An error occurred during meetingtype deletion: " & Err.Description
        Else
            ErrMsg = "Meetingtype deleted successfully."
        End If
        On Error GoTo 0
        Set cmd = Nothing
    End If
End If

' Redirect or display a message based on the action result
If Len(ErrMsg) > 0 Then
    Response.Write("<script>alert('" & ErrMsg & "'); window.location.href='/reg_list/meetingtype_list.asp';</script>")
Else
    Response.Redirect "/reg_list/meetingtype_list.asp" ' Redirect to the company list or appropriate page
End If
%>
</BODY>
</HTML>
<!--#include file="../closedb.asp"-->
