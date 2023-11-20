<!--#include file="../login/protect.inc"-->
<!--#include file="../opendb.asp"-->

<HTML>
<HEAD>
   <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" >
</HEAD>
<BODY>
    
<%
' Define variables for CRUD operations
Dim action, cmd, sql, company_id, afdeling, id_afdeling, ErrMsg

' Get the action parameter from the request
action = Trim(Request("action"))
company_id = Trim(Session("id_company"))
id_afdeling = Trim(Request("id_afdeling"))   'NO request querystring, It gave me this value error for so long and this was the fix..
afdeling = Trim(Request.Form("afdeling"))

' Protect against SQL injection by validating all inputs
If id_afdeling = "" Then
    ErrMsg = "This id cannot be empty."
ElseIf Not IsNumeric(id_afdeling) Then
    ErrMsg = "Id must be numeric."
End If

ErrMsg = ""
If ErrMsg = "" Then
    ' CREATE a new afdeling
    If action = "create" Then
        ' Prepare the SQL statement for INSERT
        sql = "INSERT INTO tbl_afdeling_2nd (afdeling, id_company) VALUES (?, ?)"
        Set cmd = Server.CreateObject("ADODB.Command")
        cmd.ActiveConnection = Conn
        cmd.CommandText = sql
        cmd.CommandType = 1 'adCmdText
        cmd.Parameters.Append cmd.CreateParameter("@afdeling", 202, 1, 50, afdeling)
        cmd.Parameters.Append cmd.CreateParameter("@id_company", 3, 1, , company_id)

        ' Execute the INSERT command
        On Error Resume Next
        cmd.Execute
        If Err.Number <> 0 Then
            ErrMsg = "An error occurred during department creation: " & Err.Description
        Else
            ErrMsg = "Department created successfully."
        End If
        On Error GoTo 0
        Set cmd = Nothing
        
    ' UPDATE an existing afdeling
    ElseIf action = "update" Then
    Response.Write("Action1: " & action & "<br>")
Response.Write("Company1 ID: " & company_id & "<br>")
Response.Write("afdeli1ng Type ID: " & id_afdeling & "<br>")
Response.Write("afdelin1g Type: " & afdeling & "<br>")

        ' Prepare the SQL statement for UPDATE
            id_afdeling = Request.QueryString("id_afdeling")

        sql = "UPDATE tbl_afdeling_2nd SET afdeling = ? WHERE id_afdeling = ?"
        Set cmd = Server.CreateObject("ADODB.Command")
        cmd.ActiveConnection = Conn
        cmd.CommandText = sql
        cmd.CommandType = 1 'adCmdText
        cmd.Parameters.Append cmd.CreateParameter("@afdeling", 202, 1, 50, afdeling)
        cmd.Parameters.Append cmd.CreateParameter("@id_afdeling", 3, 1, , id_afdeling)

Response.Write("Action: " & action & "<br>")
Response.Write("Comp2any ID: " & company_id & "<br>")
Response.Write("afdeling2 Type ID: " & id_afdeling & "<br>")
Response.Write("afdeling2 Type: " & afdeli1ng & "<br>")

        ' Execute the UPDATE command
        On Error Resume Next
        cmd.Execute
        If Err.Number <> 0 Then
            ErrMsg = "An error occurred during department update: " & Err.Description
        Else
            ErrMsg = "Department updated successfully."
        End If
        On Error GoTo 0
        Set cmd = Nothing

    ' DELETE an existing afdeling type
    ElseIf action = "delete" Then
response.Write("Delete action triggered<br>")
    Response.Write("id_afdeling: " & id_afdeling & "<br>")
    Response.Write("company_id: " & company_id & "<br>")
        ' Prepare the SQL statement for DELETE
        sql = "DELETE FROM tbl_afdeling_2nd WHERE id_afdeling = ?"
        Response.Write("SQL Query for deletion: " & sql & "<br>")

        Set cmd = Server.CreateObject("ADODB.Command")
        cmd.ActiveConnection = Conn
        cmd.CommandText = sql
        cmd.CommandType = 1 'adCmdText
        cmd.Parameters.Append cmd.CreateParameter("@id_afdeling", 3, 1, , id_afdeling)
      '  cmd.Parameters.Append cmd.CreateParameter("@id_company", 3, 1, , company_id)

        ' Execute the DELETE command
        cmd.Execute
        If Err.Number <> 0 Then
            ErrMsg = "An error occurred during department deletion: " & Err.Description
        Else
            ErrMsg = "Department deleted successfully."
        End If
        Set cmd = Nothing
    End If
    ' Redirect or display a message based on the action result

End If
If Len(ErrMsg) > 0 Then
    Response.Write("<script>alert('" & ErrMsg & "'); window.location.href='/reg_list/afdeling_list.asp' </script>")
Else
    Response.Redirect "/reg_list/afdeling_list.asp?" ' Redirect to afdeling list
End If

%>
</BODY>
</HTML>
<!--#include file="../closedb.asp"-->
