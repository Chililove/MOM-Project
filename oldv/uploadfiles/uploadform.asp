<!--#include file="../sprog/standard.asp"-->

<%

Dim strMessage, strFolder
Dim httpref, lngFileSize
Dim strExcludes, strIncludes
	%>

<!--#include file="config.asp"-->
<HTML>
<head>

<link rel="stylesheet" type="text/css" href="../css/standard.css">
</head>
<%
'checker hvor klik kommer fra
if request.querystring("id") = "" then
	session("id")= session("id")
	session("placering")= session("placering")
else
	session("id")= request.querystring("id")
session("placering")= request.querystring("placering")
end if

id=session("id")
placering=session("placering")
%>
	
	<form action="uploadfile.asp" method="post" enctype="multipart/form-data">

		<table border="0" width="320" align="center"  cellspacing="0" cellpadding="2">
		<tr>
			<th class="text">Upload</th>		
		</tr>
		<tr>
			<td class="text">
				<b>&nbsp;</b><input type="file" name="file1" size="60" /><br/>	
			</td>
		</tr>
		
		
		<tr>
			<td align="center">
				<input type="submit" value="Upload" name="submit">
				<input type="hidden" name="id_ref" size="20" value='<%=session("id")%>' >
				 <input type="hidden" name="nr" size="1" value="<%=Response.Write(RandomNumber(10000000000))%>" style="width: 49px">
				 <input type="hidden" name="bruger" size="1" value="<%=user%>" style="width: 49px"><br>
				 <input type="hidden" name="dato" size="1" value="<%=date()%>" style="width: 49px"><br>
				 <input type="hidden" name="placering" size="1" value='<%=session("placering")%>' style="width: 49px; height: 16px"></td>
		</tr>		
		
		
		</table>
		
	</form>
<!--#include file="../uploadbilleder/oversigt_vis.asp"-->

	<html>
	<body>
	
	</body>
	</html>