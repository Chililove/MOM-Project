<!--#include file="../login/protect.inc"-->
<%
'check om der er logget ud
SQL2 = "SELECT * FROM qryregistrering_sluttid WHERE (oprettetaf = '" & session("login") & "' and sluttid is Null)"

			Set rs = conn.Execute(SQL2)
			If Not (rs.BOF Or rs.EOF) Then
		
				'ikke afsluttet
				done=0
				existing_id_registrering=rs("id_registrering")
				Starttid=rs("starttid")
				job_dk=rs("job_dk")
				kundenavn=rs("kundenavn")

			Else
				'afsluttet"
				done=1		
			End If

%>