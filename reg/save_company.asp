<!--#include file="../login/protect.inc"-->
<!--#include file="../opendb.asp"-->

<HTML>
<HEAD>
   <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" >
</HEAD>
<BODY>
    
<!-- This is what you are working on -->
<%
' Define variables for CRUD operations
Dim action, cmd, sql, company_id, company_name, company_cvr, ErrMsg

' Get the action parameter from the request
action = Trim(Request("action"))
company_id = Trim(Request.QueryString("id_company"))
company_name = Trim(Request.Form("company_name"))
company_cvr = Trim(Request.Form("cvr"))

' Protect against SQL injection by validating all inputs
If company_name = "" Or company_cvr = "" Then
    ErrMsg = "Company name and CVR cannot be empty."
ElseIf Not IsNumeric(company_cvr) Then
    ErrMsg = "CVR must be numeric."
End If

If ErrMsg = "" Then
    ' CREATE a new company
    If action = "create" Then
        ' Prepare the SQL statement for INSERT
        sql = "INSERT INTO tbl_companies (company_name, cvr) VALUES (?, ?)"
        Set cmd = Server.CreateObject("ADODB.Command")
        cmd.ActiveConnection = Conn
        cmd.CommandText = sql
        cmd.CommandType = 1 'adCmdText
        cmd.Parameters.Append cmd.CreateParameter("@company_name", 202, 1, 50, company_name)
        cmd.Parameters.Append cmd.CreateParameter("@cvr", 202, 1, 50, company_cvr)
        
        ' Execute the INSERT command
        On Error Resume Next
        cmd.Execute
        If Err.Number <> 0 Then
            ErrMsg = "An error occurred during company creation: " & Err.Description
        Else
            ErrMsg = "Company created successfully."
        End If
        On Error GoTo 0
        Set cmd = Nothing
        
    ' UPDATE an existing company
    ElseIf action = "update" Then
        ' Prepare the SQL statement for UPDATE
        sql = "UPDATE tbl_companies SET company_name = ?, cvr = ? WHERE id_company = ?"
        Set cmd = Server.CreateObject("ADODB.Command")
        cmd.ActiveConnection = Conn
        cmd.CommandText = sql
        cmd.CommandType = 1 'adCmdText
        cmd.Parameters.Append cmd.CreateParameter("@company_name", 202, 1, 50, company_name)
        cmd.Parameters.Append cmd.CreateParameter("@cvr", 202, 1, 50, company_cvr)
        cmd.Parameters.Append cmd.CreateParameter("@id_company", 3, 1, , company_id)
        
        ' Execute the UPDATE command
        On Error Resume Next
        cmd.Execute
        If Err.Number <> 0 Then
            ErrMsg = "An error occurred during company update: " & Err.Description
        Else
            ErrMsg = "Company updated successfully."
        End If
        On Error GoTo 0
        Set cmd = Nothing

    ' DELETE an existing company
    ElseIf action = "delete" Then
        ' Prepare the SQL statement for DELETE
        sql = "DELETE FROM tbl_companies WHERE id_company = ?"
        Set cmd = Server.CreateObject("ADODB.Command")
        cmd.ActiveConnection = Conn
        cmd.CommandText = sql
        cmd.CommandType = 1 'adCmdText
        cmd.Parameters.Append cmd.CreateParameter("@id_company", 3, 1, , company_id)
        
        ' Execute the DELETE command
        On Error Resume Next
        cmd.Execute
        If Err.Number <> 0 Then
            ErrMsg = "An error occurred during company deletion: " & Err.Description
        Else
            ErrMsg = "Company deleted successfully."
        End If
        On Error GoTo 0
        Set cmd = Nothing
    End If
End If

' Redirect or display a message based on the action result
If Len(ErrMsg) > 0 Then
    Response.Write("<script>alert('" & ErrMsg & "'); window.location.href='/reg_list/company_list.asp';</script>")
Else
    Response.Redirect "/reg_list/company_list.asp" ' Redirect to the company list or appropriate page
End If
%>
</BODY>
</HTML>
<!--#include file="../closedb.asp"-->
