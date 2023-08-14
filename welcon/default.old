<!--#include file="../opendb.asp"-->

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252" />
<title>Ny side1</title>
<style>

 .seperator{
 	font-family:calibri;
 	font-weight:normal;
 	font-size:10px;
 	text-align:center;
 }

 .info{
 	font-family:calibri;
 	font-weight:bold;
 	font-size:10px;
 	text-align:left;
 }
 
</style>

<script>
//******************************************
// GLOBAL VARS
//******************************************

	var selectedID
	var selectedINFO
//******************************************
// POSITION COLOR MENU AND PLOT IT
//******************************************
	function selectColor(id){
		selectedID=id
		menudiv=document.getElementById("colSel")
		xpos=event.clientX 
		ypos=event.clientY
		menudiv.style.left=xpos+"px"
		menudiv.style.top=ypos+"px"
		menudiv.style.display="block"
		
		comments=document.getElementById("comments")
		comments.style.left=xpos+"px"
		comments.style.top=ypos+"px"
	}

//******************************************
// SAVE SELECTED COLOR TO TABLE & DATABASE
//******************************************
	function saveDot(id){
		if(id!=4){
			if (window.XMLHttpRequest){
				xmlhttp=new XMLHttpRequest();
			}
			else{
				xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
			}
		    xmlhttp.open("POST","postdot.asp?id=" + selectedID + "&image=" + id,false)
		    xmlhttp.send()
		}
	}

//******************************************
// HANDLE MENU SELECTIONS
//******************************************
	function menuClick(id){
		var	whatToShow=""
		var myElement=document.getElementById(selectedID)
		saveDot(id)
		
		switch (id){
			case 0:
				whatToShow="&nbsp;"
				break;			
			case 1:
				whatToShow="red.jpg"
				break;
			case 2:
				whatToShow="yellow.jpg"
				break;
			case 3:
				whatToShow="green.jpg"
				break;
			case 4:
				whatToShow=""
		}

		
		if (whatToShow != "&nbsp;"){
			currentHTML=myElement.innerHTML

			if (currentHTML=='<img src="images/0.jpg">'){
				currentHTML="&nbsp;"
				myElement.innerHTML="&nbsp;"
				document.getElementById(selectedID).title=""
			}
			
			if (currentHTML=="&nbsp;"){
				myElement.innerHTML="<img src='images/" + whatToShow + "'>"
				if (id!=4){
					document.getElementById("theComment").value=document.getElementById(selectedID).title
					doComments()
				}	
				else{
					myElement.innerHTML="&nbsp;"
				}
			}
			else{
				if (whatToShow==""){
					document.getElementById("theComment").value=document.getElementById(selectedID).title
					editComments()
				}
				else{
					myElement.innerHTML="<img src='images/" + whatToShow + "'>"
				}
			}	
		}
		else{
			myElement.innerHTML="&nbsp;"
			document.getElementById(selectedID).title=""
		}
		menuHide()
	}

//******************************************
// DISPLAY COMMENT DIV FOR NEW COMMENT
//******************************************
	function doComments(){
		document.getElementById("comments").style.display="block"
		document.getElementById("theComment").value=""
		document.getElementById("theComment").focus()
	}

//******************************************
// DISPLAY COMMENT DIV FOR EDITING COMMENT
//******************************************
	function editComments(){
		document.getElementById("comments").style.display="block"
		document.getElementById("theComment").focus()
	}

//******************************************
// HIDE MENU 
//******************************************
	function menuHide(){
		document.getElementById("colSel").style.display="none" 
	}

//******************************************
// HIDE COMMENTS
//******************************************
	function commentsHide(){
		document.getElementById("comments").style.display="none" 
	}	

//******************************************
// COMMIT COMMENTS TO TABLE AND DATABASE
//******************************************
	function commitComments(){
		commentsHide()
		comment=document.getElementById("theComment").value
		
		document.getElementById(selectedID).title=comment
		comment = comment.split("\n").join("<br>")			

		if (window.XMLHttpRequest){
			xmlhttp=new XMLHttpRequest();
		}
		else{
			xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
		}
	    xmlhttp.open("POST","postcomment.asp?id=" + selectedID + "&comment=" + comment,false)
	    xmlhttp.send()
	}

//******************************************
// POSITION INFO BOX AND DISPLAY
//******************************************
	function editInfo(id){
		selectedINFO=id
		infodiv=document.getElementById("infobox")
		xpos=event.clientX 
		ypos=event.clientY
		infodiv.style.left=xpos+"px"
		infodiv.style.top=ypos+"px"
		infodiv.style.display="block"
		document.getElementById("theInfo").value=document.getElementById(selectedINFO).innerHTML
		document.getElementById("theInfo").focus()
	}

//******************************************
// HIDE INFOBOX
//******************************************
	function infoHide(){
		document.getElementById("infobox").style.display="none" 
	}	

//******************************************
// SAVE INFO TO SCREEN AND DATABASE
//******************************************
	function commitInfo(){
		infoToSave=document.getElementById("theInfo").value
		document.getElementById(selectedINFO).innerHTML=infoToSave
		infoHide()

		if (window.XMLHttpRequest){
			xmlhttp=new XMLHttpRequest();
		}
		else{
			xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
		}
		
		id=selectedINFO.replace("_info","")
	    xmlhttp.open("POST","postinfo.asp?id=" + id + "&info=" + infoToSave,false)
	    xmlhttp.send()
	}
	

//******************************************
// NEEDS WORK TO ADD NEW SPANS AND COLOR
//******************************************
	function setFont(id){
		return true
		switch (id){
			case 0:
				document.getElementById("editfield").style='color:#000000'
				document.getElementById("blackFont").style='border: solid 2px #cccccc'
				document.getElementById("redFont").style=''
				break;			
			case 1:
				document.getElementById("editfield").style='color:#ff0000'
				document.getElementById("redFont").style='border: solid 2px #cccccc'
				document.getElementById("blackFont").style=''

				break;			
		}
		document.getElementById("editfield").focus()
	}
</script>

</head>

<body>

<div id="infobox" style="display:none;position:absolute;width:350px;top:100px;left:200px;border:solid 1px #808080;">
	<table bgcolor="#ffffff" border="1" style="border-collapse:collapse;border-color:#000000" width="100%">
		<tr>
			<td bgcolor="navy" width="95%">
				<font color="#ffffff" family="calibri" size="2">&nbsp;<b>INFO</b></font>
			</td>
			<td style="cursor:pointer" bgcolor="navy" align="center" width="5%" onclick="infoHide()">
				<font color="#ffffff" family="calibri" size="2"><b>X</b></font>
			</td>
		</tr>	
		<tr>
			<td colspan="2">
				<textarea id="theInfo" rows="4" style="width:98%">&nbsp;</textarea>
			</td>
		</tr>
		<tr>
			<td colspan=2>
				<table width="100%" bordrer="0">
					<tr>
						<td id="blackFont" onclick="setFont(0)" style="border:solid 2px #cccccc" width="15px" bgcolor="#000000"></td>
						<td id="redFont" onclick="setFont(1)" width="15px" bgcolor="#ff0000"></td>
					 	<td style="border-top:solid 1px #ffffff"align="right" ><button onclick="commitInfo()">
						OK</button><button onclick="infoHide()">Cancel</button></td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
</div>

<div id="comments" style="display:none;position:absolute;width:200px;top:100px;left:200px;border:solid 1px #808080;">
	<table bgcolor="#ffffff" border="1" style="border-collapse:collapse;border-color:#000000" width="100%">
		<tr>
			<td bgcolor="navy" width="95%">
				<font color="#ffffff" family="calibri" size="2">&nbsp;<b>COMMENTS</b></font>
			</td>
			<td style="cursor:pointer" bgcolor="navy" align="center" width="5%" onclick="commentsHide()">
				<font color="#ffffff" family="calibri" size="2"><b>X</b></font>
			</td>
		</tr>	
		<tr>
			<td colspan="2"><textarea id="theComment" rows="4" style="width:98%"></textarea></td>
		</tr>
		<tr>
			<td style="border-top:solid 1px #ffffff"align="right" colspan="2"><button onclick="commitComments()">
			OK</button><button onclick="commentsHide()">Cancel</button></td>
		</tr>
	</table>
</div>

<div id="colSel" style="position:absolute;display:none;width:150px;top:100px;left:750px;border:none">
	<table bgcolor="#ffffff" border="1" cellpadding="2" style="border-collapse:collapse;border-color:#000000" width="100%">
		<tr>
			<td bgcolor="navy" width="95%">
				<font color="#ffffff" family="calibri" size="2">&nbsp;<b>SELECTION</b></font>
			</td>
			<td style="cursor:pointer" bgcolor="navy" align="center" width="5%" onclick="menuHide()">
				<font color="#ffffff" family="calibri" size="2"><b>X</b></font>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<table cellpadding="2" border="0" width="100%">
					<tr>
						<td onclick="menuClick(1)" style="cursor:pointer;border-bottom:solid 1px #808080">
						&nbsp;<img src="images/red.jpg">&nbsp;<font color="#000000" family="calibri" size="1">RED</font></td>
					</tr>
					<tr>
						<td onclick="menuClick(2)" style="cursor:pointer;border-bottom:solid 1px #808080">
						&nbsp;<img src="images/yellow.jpg">&nbsp;<font color="#000000" family="calibri" size="1">YELLOW</font></td>
					</tr>
					<tr>
						<td onclick="menuClick(3)" style="cursor:pointer;border-bottom:solid 1px #808080">
						&nbsp;<img src="images/green.jpg">&nbsp;<font color="#000000" family="calibri" size="1">GREEN</font></td>
					</tr>
					<tr>
						<td onclick="menuClick(4)" style="cursor:pointer;border-bottom:solid 1px #808080">
						&nbsp;<img src="images/comment.jpg">&nbsp;<font color="#000000" family="calibri" size="1">EDIT 
						COMMENTS</font></td>
					</tr>
					<tr>
						<td onclick="menuClick(0)" style="cursor:pointer;">&nbsp;<img src="images/none.jpg">&nbsp;<font color="#000000" family="calibri" size="1">NONE</font></td>
					</tr>
				</table>
			</td>
		</tr>

	</table>	
</div>

<table border="1" cellpadding="2" style="border-collapse:collapse;border-color:#000000">
	<tr>
		<td width="250px" bgcolor="#aaaaaa"></td>
		<td colspan=2 align="center" bgcolor="#f4b084">1</td>
		<td width="32px" colspan=2 align="center" bgcolor="#00b0f0">2</td>
		<td width="32px" colspan=2 align="center" bgcolor="#ffff00">3</td>
		<td width="16px" align="center" bgcolor="#ff99ff">4</td>
		<td width="16px" align="center" bgcolor="#ff99ff">5</td>
		<td width="16px" align="center" bgcolor="#ffff00">6</td>
		<td width="48px" colspan="3" align="center" bgcolor="#f4feda">7</td>
		<td width="16px" align="center" bgcolor="#b4c6e7">8</td>
		<td width="16px" align="center" bgcolor="#b4c6e7">9</td>
		<td width="16px" align="center" bgcolor="#b4c6e7">10</td>
		<td width="16px" align="center" bgcolor="#d6dce4">11</td>
		<td width="16px" align="center" bgcolor="#ffff00">12</td>
		<td width="16px" align="center" bgcolor="#7030a0"><font color="#FFFFFF">
		13</font></td>
		<td width="16px" align="center" bgcolor="#66ffff">14</td>

		<td width="16px" align="center" bgcolor="#f4feda">15</td>
		<td width="16px" align="center" bgcolor="#f4feda">16</td>
		<td width="16px" align="center" bgcolor="#f4feda">17</td>
		<td width="16px" align="center" bgcolor="#d9e1f2">18</td>
		<td width="16px" align="center" bgcolor="#d9e1f2">19</td>
		<td width="16px" align="center" bgcolor="#d9e1f2">20</td>
		<td width="16px" align="center" bgcolor="#ffff00">21</td>
		<td width="16px" align="center" bgcolor="#bdd7ee">22</td>
		<td width="16px" align="center" bgcolor="#00ff00">23</td>

		<td width="32px" colspan="2" align="center" bgcolor="#00b050">24</td>

		<td width="16px" align="center" bgcolor="#99ff66">25</td>

		<td width="16px" align="center" bgcolor="#ff0000">26</td>
		
		<td width="16px" bgcolor="#eeeeee">&nbsp;</td>

	</tr>
	<tr>
		<td></td>
		<td bgcolor="#f4b084" valign="bottom" style="height: 113px"><img border="0" src="images/text1.gif"></td>
		<td bgcolor="#f4b084" valign="bottom" style="height: 113px; width: 16px;"><img border="0" src="images/text2.gif"></td>
		<td bgcolor="#00b0f0" valign="bottom" style="height: 113px"><img border="0" src="images/text3.gif"></td>
		<td bgcolor="#00b0f0" valign="bottom" style="height: 113px"><img border="0" src="images/text4.gif"></td>
		<td bgcolor="#ffff00" valign="bottom" style="height: 113px"><img border="0" src="images/text5.gif"></td>
		<td bgcolor="#ffff00" valign="bottom" style="height: 113px"><img border="0" src="images/text6.gif"></td>
		<td bgcolor="#ff99ff" valign="bottom" style="height: 113px"><img border="0" src="images/text7.gif"></td>
		<td bgcolor="#ff99ff" valign="bottom" style="height: 113px"><img border="0" src="images/text8.gif"></td>
		<td bgcolor="#ffff00" valign="bottom" style="height: 113px"><img border="0" src="images/text9.gif"></td>
		<td bgcolor="#f4feda" valign="bottom" style="height: 113px"><img border="0" src="images/text10.gif"></td>
		<td bgcolor="#f4feda" valign="bottom" style="height: 113px"><img border="0" src="images/text11.gif"></td>
		<td bgcolor="#f4feda" valign="bottom" style="height: 113px"><img border="0" src="images/text12.gif"></td>
		<td bgcolor="#b4c6e7" valign="bottom" style="height: 113px"><img border="0" src="images/text13.gif"></td>
		<td bgcolor="#b4c6e7" valign="bottom" style="height: 113px"><img border="0" src="images/text14.gif"></td>
		<td bgcolor="#b4c6e7" valign="bottom" style="height: 113px"><img border="0" src="images/text15.gif"></td>
		<td bgcolor="#d6dce4" valign="bottom" style="height: 113px"><img border="0" src="images/text16.gif"></td>
		<td bgcolor="#ffff00" valign="bottom" style="height: 113px"><img border="0" src="images/text17.gif"></td>
		<td bgcolor="#7030a0" valign="bottom" style="height: 113px"><img border="0" src="images/text18.gif"></td>
		<td bgcolor="#66ffff" valign="bottom" style="height: 113px"><img border="0" src="images/text19.gif"></td>

		<td bgcolor="#f4feda" valign="bottom" style="height: 113px"><img border="0" src="images/text20.gif"></td>
		<td bgcolor="#f4feda" valign="bottom" style="height: 113px"><img border="0" src="images/text21.gif"></td>
		<td bgcolor="#f4feda" valign="bottom" style="height: 113px"><img border="0" src="images/text22.gif"></td>

		<td bgcolor="#d9e1f2" valign="bottom" style="height: 113px"><img border="0" src="images/text23.gif"></td>
		<td bgcolor="#d9e1f2" valign="bottom" style="height: 113px"><img border="0" src="images/text24.gif"></td>
		<td bgcolor="#d9e1f2" valign="bottom" style="height: 113px"><img border="0" src="images/text25.gif"></td>

		<td bgcolor="#ffff00" valign="bottom" style="height: 113px"><img border="0" src="images/text26.gif"></td>

		<td bgcolor="#bdd7ee" valign="bottom" style="height: 113px"><img border="0" src="images/text27.gif"></td>

		<td bgcolor="#00ff00" valign="bottom" style="height: 113px"><img border="0" src="images/text28.gif"></td>

		<td bgcolor="#99ff66" valign="bottom" style="height: 113px"><img border="0" src="images/text29.gif"></td>
		<td bgcolor="#00b050" valign="bottom" style="height: 113px"><img border="0" src="images/text30.gif"></td>

		<td bgcolor="#99ff66" valign="bottom" style="height: 113px"><img border="0" src="images/text31.gif"></td>

		<td bgcolor="#ff0000" valign="bottom" style="height: 113px"><img border="0" src="images/text32.gif"></td>
		<td bgcolor="#eeeeee" width="16px" style="height: 113px"></td>
	</tr>

<%
sql="select * from tblfinish"
set rs=conn.execute(sql)
%>
	<tr>
		<td colspan="34" style="padding: 0 0 0 0">
			<div style="overflow-y:auto;height :240px;">
			<table width="100%" cellpadding="0" cellspacing="0">

<%
do while not rs.eof
%>	
				<tr>
					<td width="197px" onclick="editInfo(this.id)" id="<%=rs("id_finish")%>_info" style="border-right:solid 1px #000000;border-bottom:solid 1px #000000" height="40px" class="info" valign="top"><%=rs("info")%></td>
<%if rs("field1_active") then%>
					<td width="16px" title="<%=replace(rs("field1_note"),"<br>",vbcrlf)%>" onclick="selectColor(this.id)" id="<%=rs("id_finish")%>_col1" style="border-right:solid 1px #000000;border-bottom:solid 1px #000000" valign="middle" align="center"><img src="<%="images/" & rs("field1") & ".jpg"%>"></td>
<%else%>
					<td width="16px" bgcolor="#aaaaaa" id="<%=rs("id_finish")%>_col1" style="border-right:solid 1px #000000;border-bottom:solid 1px #000000" valign="middle" align="center">
					&nbsp;</td>
<%end if%>
<%if rs("field2_active") then%>
					<td width="16px" title="<%=replace(rs("field2_note"),"<br>",vbcrlf)%>" onclick="selectColor(this.id)" id="<%=rs("id_finish")%>_col2" style="border-right:solid 1px #000000;border-bottom:solid 1px #000000" valign="middle" align="center"><img src="<%="images/" & rs("field2") & ".jpg"%>"></td>
<%else%>
					<td width="16px" bgcolor="#aaaaaa" id="<%=rs("id_finish")%>_col2" style="border-right:solid 1px #000000;border-bottom:solid 1px #000000" valign="middle" align="center">
					&nbsp;</td>
<%end if%>
<%if rs("field3_active") then%>
					<td width="16px" title="<%=replace(rs("field3_note"),"<br>",vbcrlf)%>" onclick="selectColor(this.id)" id="<%=rs("id_finish")%>_col3" style="border-right:solid 1px #000000;border-bottom:solid 1px #000000" valign="middle" align="center"><img src="<%="images/" & rs("field3") & ".jpg"%>"></td>
<%else%>
					<td width="16px" bgcolor="#aaaaaa" id="<%=rs("id_finish")%>_col3" style="border-right:solid 1px #000000;border-bottom:solid 1px #000000" valign="middle" align="center">
					&nbsp;</td>
<%end if%>
<%if rs("field4_active") then%>
					<td width="16px" title="<%=replace(rs("field4_note"),"<br>",vbcrlf)%>" onclick="selectColor(this.id)" id="<%=rs("id_finish")%>_col4" style="border-right:solid 1px #000000;border-bottom:solid 1px #000000" valign="middle" align="center"><img src="<%="images/" & rs("field4") & ".jpg"%>"></td>
<%else%>
					<td width="16px" bgcolor="#aaaaaa" id="<%=rs("id_finish")%>_col4" style="border-right:solid 1px #000000;border-bottom:solid 1px #000000" valign="middle" align="center">
					&nbsp;</td>
<%end if%>
<%if rs("field5_active") then%>
					<td width="16px" title="<%=replace(rs("field5_note"),"<br>",vbcrlf)%>" onclick="selectColor(this.id)" id="<%=rs("id_finish")%>_col5" style="border-right:solid 1px #000000;border-bottom:solid 1px #000000" valign="middle" align="center"><img src="<%="images/" & rs("field5") & ".jpg"%>"></td>
<%else%>
					<td width="16px" bgcolor="#aaaaaa" id="<%=rs("id_finish")%>_col5" style="border-right:solid 1px #000000;border-bottom:solid 1px #000000" valign="middle" align="center">
					&nbsp;</td>
<%end if%>
<%if rs("field6_active") then%>
					<td width="16px" title="<%=replace(rs("field6_note"),"<br>",vbcrlf)%>" onclick="selectColor(this.id)" id="<%=rs("id_finish")%>_col6" style="border-right:solid 1px #000000;border-bottom:solid 1px #000000" valign="middle" align="center"><img src="<%="images/" & rs("field6") & ".jpg"%>"></td>
<%else%>
					<td width="16px" bgcolor="#aaaaaa" id="<%=rs("id_finish")%>_col6" style="border-right:solid 1px #000000;border-bottom:solid 1px #000000" valign="middle" align="center">
					&nbsp;</td>
<%end if%>
<%if rs("field7_active") then%>
					<td width="16px" title="<%=replace(rs("field7_note"),"<br>",vbcrlf)%>" onclick="selectColor(this.id)" id="<%=rs("id_finish")%>_col7" style="border-right:solid 1px #000000;border-bottom:solid 1px #000000" valign="middle" align="center"><img src="<%="images/" & rs("field7") & ".jpg"%>"></td>
<%else%>
					<td width="16px" bgcolor="#aaaaaa" id="<%=rs("id_finish")%>_col7" style="border-right:solid 1px #000000;border-bottom:solid 1px #000000" valign="middle" align="center">
					&nbsp;</td>
<%end if%>
<%if rs("field8_active") then%>
					<td width="16px" title="<%=replace(rs("field8_note"),"<br>",vbcrlf)%>" onclick="selectColor(this.id)" id="<%=rs("id_finish")%>_col8" style="border-right:solid 1px #000000;border-bottom:solid 1px #000000" valign="middle" align="center"><img src="<%="images/" & rs("field8") & ".jpg"%>"></td>
<%else%>
					<td width="16px" bgcolor="#aaaaaa" id="<%=rs("id_finish")%>_col8" style="border-right:solid 1px #000000;border-bottom:solid 1px #000000" valign="middle" align="center">
					&nbsp;</td>
<%end if%>
<%if rs("field9_active") then%>
					<td width="23px" title="<%=replace(rs("field9_note"),"<br>",vbcrlf)%>" onclick="selectColor(this.id)" id="<%=rs("id_finish")%>_col9" style="border-right:solid 1px #000000;border-bottom:solid 1px #000000" valign="middle" align="center"><img src="<%="images/" & rs("field9") & ".jpg"%>"></td>
<%else%>
					<td width="23px" bgcolor="#aaaaaa" id="<%=rs("id_finish")%>_col9" style="border-right:solid 1px #000000;border-bottom:solid 1px #000000" valign="middle" align="center">
					&nbsp;</td>
<%end if%>
<%if rs("field10_active") then%>
					<td width="16px" title="<%=replace(rs("field10_note"),"<br>",vbcrlf)%>" onclick="selectColor(this.id)" id="<%=rs("id_finish")%>_col10" style="border-right:solid 1px #000000;border-bottom:solid 1px #000000" valign="middle" align="center"><img src="<%="images/" & rs("field10") & ".jpg"%>"></td>
<%else%>
					<td width="16px" bgcolor="#aaaaaa" id="<%=rs("id_finish")%>_col10" style="border-right:solid 1px #000000;border-bottom:solid 1px #000000" valign="middle" align="center">
					&nbsp;</td>
<%end if%>
<%if rs("field11_active") then%>
					<td width="16px" title="<%=replace(rs("field11_note"),"<br>",vbcrlf)%>" onclick="selectColor(this.id)" id="<%=rs("id_finish")%>_col11" style="border-right:solid 1px #000000;border-bottom:solid 1px #000000" valign="middle" align="center"><img src="<%="images/" & rs("field11") & ".jpg"%>"></td>
<%else%>
					<td width="16px" bgcolor="#aaaaaa" id="<%=rs("id_finish")%>_col11" style="border-right:solid 1px #000000;border-bottom:solid 1px #000000" valign="middle" align="center">
					&nbsp;</td>
<%end if%>
<%if rs("field12_active") then%>
					<td width="16px" title="<%=replace(rs("field12_note"),"<br>",vbcrlf)%>" onclick="selectColor(this.id)" id="<%=rs("id_finish")%>_col12" style="border-right:solid 1px #000000;border-bottom:solid 1px #000000" valign="middle" align="center"><img src="<%="images/" & rs("field12") & ".jpg"%>"></td>
<%else%>
					<td width="16px" bgcolor="#aaaaaa" id="<%=rs("id_finish")%>_col12" style="border-right:solid 1px #000000;border-bottom:solid 1px #000000" valign="middle" align="center">
					&nbsp;</td>
<%end if%>
<%if rs("field13_active") then%>
					<td width="16px" title="<%=replace(rs("field13_note"),"<br>",vbcrlf)%>" onclick="selectColor(this.id)" id="<%=rs("id_finish")%>_col13" style="border-right:solid 1px #000000;border-bottom:solid 1px #000000" valign="middle" align="center"><img src="<%="images/" & rs("field13") & ".jpg"%>"></td>
<%else%>
					<td width="16px" bgcolor="#aaaaaa" id="<%=rs("id_finish")%>_col13" style="border-right:solid 1px #000000;border-bottom:solid 1px #000000" valign="middle" align="center">
					&nbsp;</td>
<%end if%>
<%if rs("field14_active") then%>
					<td width="16px" title="<%=replace(rs("field14_note"),"<br>",vbcrlf)%>" onclick="selectColor(this.id)" id="<%=rs("id_finish")%>_col14" style="border-right:solid 1px #000000;border-bottom:solid 1px #000000" valign="middle" align="center"><img src="<%="images/" & rs("field14") & ".jpg"%>"></td>
<%else%>
					<td width="16px" bgcolor="#aaaaaa" id="<%=rs("id_finish")%>_col14" style="border-right:solid 1px #000000;border-bottom:solid 1px #000000" valign="middle" align="center">
					&nbsp;</td>
<%end if%>
<%if rs("field15_active") then%>
					<td width="16px" title="<%=replace(rs("field15_note"),"<br>",vbcrlf)%>" onclick="selectColor(this.id)" id="<%=rs("id_finish")%>_col15" style="border-right:solid 1px #000000;border-bottom:solid 1px #000000" valign="middle" align="center"><img src="<%="images/" & rs("field15") & ".jpg"%>"></td>
<%else%>
					<td width="16px" bgcolor="#aaaaaa" id="<%=rs("id_finish")%>_col15" style="border-right:solid 1px #000000;border-bottom:solid 1px #000000" valign="middle" align="center">
					&nbsp;</td>
<%end if%>
<%if rs("field16_active") then%>
					<td width="16px" title="<%=replace(rs("field16_note"),"<br>",vbcrlf)%>" onclick="selectColor(this.id)" id="<%=rs("id_finish")%>_col16" style="border-right:solid 1px #000000;border-bottom:solid 1px #000000" valign="middle" align="center"><img src="<%="images/" & rs("field16") & ".jpg"%>"></td>
<%else%>
					<td width="16px" bgcolor="#aaaaaa" id="<%=rs("id_finish")%>_col16" style="border-right:solid 1px #000000;border-bottom:solid 1px #000000" valign="middle" align="center">
					&nbsp;</td>
<%end if%>
<%if rs("field17_active") then%>
					<td width="17px" title="<%=replace(rs("field17_note"),"<br>",vbcrlf)%>" onclick="selectColor(this.id)" id="<%=rs("id_finish")%>_col17" style="border-right:solid 1px #000000;border-bottom:solid 1px #000000" valign="middle" align="center"><img src="<%="images/" & rs("field17") & ".jpg"%>"></td>
<%else%>
					<td width="17px" bgcolor="#aaaaaa" id="<%=rs("id_finish")%>_col17" style="border-right:solid 1px #000000;border-bottom:solid 1px #000000" valign="middle" align="center">
					&nbsp;</td>
<%end if%>
<%if rs("field18_active") then%>
					<td width="16px" title="<%=replace(rs("field18_note"),"<br>",vbcrlf)%>" onclick="selectColor(this.id)" id="<%=rs("id_finish")%>_co118" style="border-right:solid 1px #000000;border-bottom:solid 1px #000000" valign="middle" align="center"><img src="<%="images/" & rs("field18") & ".jpg"%>"></td>
<%else%>
					<td width="16px" bgcolor="#aaaaaa" id="<%=rs("id_finish")%>_co118" style="border-right:solid 1px #000000;border-bottom:solid 1px #000000" valign="middle" align="center">
					&nbsp;</td>
<%end if%>
<%if rs("field19_active") then%>
					<td width="16px" title="<%=replace(rs("field19_note"),"<br>",vbcrlf)%>" onclick="selectColor(this.id)" id="<%=rs("id_finish")%>_col19" style="border-right:solid 1px #000000;border-bottom:solid 1px #000000" valign="middle" align="center"><img src="<%="images/" & rs("field19") & ".jpg"%>"></td>
<%else%>
					<td width="16px" bgcolor="#aaaaaa" id="<%=rs("id_finish")%>_col19" style="border-right:solid 1px #000000;border-bottom:solid 1px #000000" valign="middle" align="center">
					&nbsp;</td>
<%end if%>
<%if rs("field20_active") then%>
					<td width="16px" title="<%=replace(rs("field20_note"),"<br>",vbcrlf)%>" onclick="selectColor(this.id)" id="<%=rs("id_finish")%>_col20" style="border-right:solid 1px #000000;border-bottom:solid 1px #000000" valign="middle" align="center"><img src="<%="images/" & rs("field20") & ".jpg"%>"></td>
<%else%>
					<td width="16px" bgcolor="#aaaaaa" id="<%=rs("id_finish")%>_col20" style="border-right:solid 1px #000000;border-bottom:solid 1px #000000" valign="middle" align="center">
					&nbsp;</td>
<%end if%>
<%if rs("field21_active") then%>
					<td width="16px" title="<%=replace(rs("field21_note"),"<br>",vbcrlf)%>" onclick="selectColor(this.id)" id="<%=rs("id_finish")%>_col21" style="border-right:solid 1px #000000;border-bottom:solid 1px #000000" valign="middle" align="center"><img src="<%="images/" & rs("field21") & ".jpg"%>"></td>
<%else%>
					<td width="16px" bgcolor="#aaaaaa" id="<%=rs("id_finish")%>_col21" style="border-right:solid 1px #000000;border-bottom:solid 1px #000000" valign="middle" align="center">
					&nbsp;</td>
<%end if%>
<%if rs("field22_active") then%>
					<td width="16px" title="<%=replace(rs("field22_note"),"<br>",vbcrlf)%>" onclick="selectColor(this.id)" id="<%=rs("id_finish")%>_col22" style="border-right:solid 1px #000000;border-bottom:solid 1px #000000" valign="middle" align="center"><img src="<%="images/" & rs("field22") & ".jpg"%>"></td>
<%else%>
					<td width="16px" bgcolor="#aaaaaa" id="<%=rs("id_finish")%>_col22" style="border-right:solid 1px #000000;border-bottom:solid 1px #000000" valign="middle" align="center">
					&nbsp;</td>
<%end if%>
<%if rs("field23_active") then%>
					<td width="16px" title="<%=replace(rs("field23_note"),"<br>",vbcrlf)%>" onclick="selectColor(this.id)" id="<%=rs("id_finish")%>_col23" style="border-right:solid 1px #000000;border-bottom:solid 1px #000000" valign="middle" align="center"><img src="<%="images/" & rs("field23") & ".jpg"%>"></td>
<%else%>
					<td width="16px" bgcolor="#aaaaaa" id="<%=rs("id_finish")%>_col23" style="border-right:solid 1px #000000;border-bottom:solid 1px #000000" valign="middle" align="center">
					&nbsp;</td>
<%end if%>
<%if rs("field24_active") then%>
					<td width="16px" title="<%=replace(rs("field24_note"),"<br>",vbcrlf)%>" onclick="selectColor(this.id)" id="<%=rs("id_finish")%>_col24" style="border-right:solid 1px #000000;border-bottom:solid 1px #000000" valign="middle" align="center"><img src="<%="images/" & rs("field24") & ".jpg"%>"></td>
<%else%>
					<td width="16px" bgcolor="#aaaaaa" id="<%=rs("id_finish")%>_col24" style="border-right:solid 1px #000000;border-bottom:solid 1px #000000" valign="middle" align="center">
					&nbsp;</td>
<%end if%>
<%if rs("field25_active") then%>
					<td width="16px" title="<%=replace(rs("field25_note"),"<br>",vbcrlf)%>" onclick="selectColor(this.id)" id="<%=rs("id_finish")%>_col25" style="border-right:solid 1px #000000;border-bottom:solid 1px #000000" valign="middle" align="center"><img src="<%="images/" & rs("field25") & ".jpg"%>"></td>
<%else%>
					<td width="16px" bgcolor="#aaaaaa" id="<%=rs("id_finish")%>_col25" style="border-right:solid 1px #000000;border-bottom:solid 1px #000000" valign="middle" align="center">
					&nbsp;</td>
<%end if%>
<%if rs("field26_active") then%>
					<td width="19px" title="<%=replace(rs("field26_note"),"<br>",vbcrlf)%>" onclick="selectColor(this.id)" id="<%=rs("id_finish")%>_col26" style="border-right:solid 1px #000000;border-bottom:solid 1px #000000" valign="middle" align="center"><img src="<%="images/" & rs("field26") & ".jpg"%>"></td>
<%else%>
					<td width="19px" bgcolor="#aaaaaa" id="<%=rs("id_finish")%>_col26" style="border-right:solid 1px #000000;border-bottom:solid 1px #000000" valign="middle" align="center">
					&nbsp;</td>
<%end if%>
<%if rs("field27_active") then%>
					<td width="16px" title="<%=replace(rs("field27_note"),"<br>",vbcrlf)%>" onclick="selectColor(this.id)" id="<%=rs("id_finish")%>_col27" style="border-right:solid 1px #000000;border-bottom:solid 1px #000000" valign="middle" align="center"><img src="<%="images/" & rs("field27") & ".jpg"%>"></td>
<%else%>
					<td width="16px" bgcolor="#aaaaaa" id="<%=rs("id_finish")%>_col27" style="border-right:solid 1px #000000;border-bottom:solid 1px #000000" valign="middle" align="center">
					&nbsp;</td>
<%end if%>
<%if rs("field28_active") then%>
					<td width="19px" title="<%=replace(rs("field28_note"),"<br>",vbcrlf)%>" onclick="selectColor(this.id)" id="<%=rs("id_finish")%>_col28" style="border-right:solid 1px #000000;border-bottom:solid 1px #000000" valign="middle" align="center"><img src="<%="images/" & rs("field28") & ".jpg"%>"></td>
<%else%>
					<td width="19px" bgcolor="#aaaaaa" id="<%=rs("id_finish")%>_col28" style="border-right:solid 1px #000000;border-bottom:solid 1px #000000" valign="middle" align="center">
					&nbsp;</td>
<%end if%>
<%if rs("field29_active") then%>
					<td width="16px" title="<%=replace(rs("field29_note"),"<br>",vbcrlf)%>" onclick="selectColor(this.id)" id="<%=rs("id_finish")%>_col29" style="border-right:solid 1px #000000;border-bottom:solid 1px #000000" valign="middle" align="center"><img src="<%="images/" & rs("field29") & ".jpg"%>"></td>
<%else%>
					<td width="16px" bgcolor="#aaaaaa" id="<%=rs("id_finish")%>_col29" style="border-right:solid 1px #000000;border-bottom:solid 1px #000000" valign="middle" align="center">
					&nbsp;</td>
<%end if%>
<%if rs("field30_active") then%>
					<td width="16px" title="<%=replace(rs("field30_note"),"<br>",vbcrlf)%>" onclick="selectColor(this.id)" id="<%=rs("id_finish")%>_col30" style="border-right:solid 1px #000000;border-bottom:solid 1px #000000" valign="middle" align="center"><img src="<%="images/" & rs("field30") & ".jpg"%>"></td>
<%else%>
					<td width="16px" bgcolor="#aaaaaa" id="<%=rs("id_finish")%>_col30" style="border-right:solid 1px #000000;border-bottom:solid 1px #000000" valign="middle" align="center">
					&nbsp;</td>
<%end if%>
<%if rs("field31_active") then%>
					<td width="22px" title="<%=replace(rs("field31_note"),"<br>",vbcrlf)%>" onclick="selectColor(this.id)" id="<%=rs("id_finish")%>_col31" style="border-right:solid 1px #000000;border-bottom:solid 1px #000000" valign="middle" align="center"><img src="<%="images/" & rs("field31") & ".jpg"%>"></td>
<%else%>
					<td width="22px" bgcolor="#aaaaaa" id="<%=rs("id_finish")%>_col31" style="border-right:solid 1px #000000;border-bottom:solid 1px #000000" valign="middle" align="center">
					&nbsp;</td>
<%end if%>
<%if rs("field32_active") then%>
					<td width="16px" title="<%=replace(rs("field32_note"),"<br>",vbcrlf)%>" onclick="selectColor(this.id)" id="<%=rs("id_finish")%>_col32" style="border-right:solid 1px #000000;border-bottom:solid 1px #000000" valign="middle" align="center"><img src="<%="images/" & rs("field32") & ".jpg"%>"></td>
<%else%>
					<td width="16px" bgcolor="#aaaaaa" id="<%=rs("id_finish")%>_col32" style="border-right:solid 1px #000000;border-bottom:solid 1px #000000" valign="middle" align="center">
					&nbsp;</td>
<%end if%>
					<td width="15px" bgcolor="#eeeeee">&nbsp;</td>
				</tr>

<%
rs.movenext
loop
%>

			</table>
			</div>
		</td>
		
	</tr>

	<tr>
		<td class="seperator" bgcolor="#aaaaaa"><font color="#ffffff">INFO</font></td>
		<td class="seperator" bgcolor="#f4b084" width="16px">TF</td>
		<td class="seperator" bgcolor="#f4b084" style="width: 16px">BF</td>
		<td class="seperator" bgcolor="#00b0f0" width="16px">TF</td>
		<td class="seperator" bgcolor="#00b0f0" width="16px">BF</td>
		<td class="seperator" bgcolor="#ffff00" width="16px">TF</td>
		<td class="seperator" bgcolor="#ffff00" width="16px">BF</td>
		<td class="seperator" bgcolor="#ff99ff" width="16px">OP</td>
		<td class="seperator" bgcolor="#ff99ff" width="16px">S/S</td>
		<td class="seperator" bgcolor="#ffff00" width="24px">VT-MT</td>
		<td class="seperator" bgcolor="#f4feda" width="16px">TF</td>
		<td class="seperator" bgcolor="#f4feda" width="16px">BF</td>
		<td class="seperator" bgcolor="#f4feda" width="16px">X</td>
		<td class="seperator" bgcolor="#b4c6e7" width="48px" colspan="3">INDV 
		BØS</td>
		<td class="seperator" bgcolor="#d6dce4" width="16px">HI</td>
		<td class="seperator" bgcolor="#ffff00" width="16px">TIG</td>
		<td class="seperator" bgcolor="#7030a0" width="16px"><font color="#ffffff">
		KB</font></td>
		<td class="seperator" bgcolor="#66ffff" width="16px">KA</td>
		<td class="seperator" bgcolor="#f4feda" width="16px">SL</td>
		<td class="seperator" bgcolor="#f4feda" width="16px">B</td>
		<td class="seperator" bgcolor="#f4feda" width="16px">KA</td>
		<td class="seperator" bgcolor="#d9e1f2" width="48px"colspan="3">UDV BØS</td>
		<td class="seperator" bgcolor="#ffff00" width="20px">TIG</td>
		<td class="seperator" bgcolor="#bdd7ee" width="16px">HU</td>
		<td class="seperator" bgcolor="#00ff00" width="20px">VT/<br>MT</td>
		<td class="seperator" bgcolor="#99ff66" width="16px">QA</td>
		<td class="seperator" bgcolor="#00b050" width="16px">QA</td>
		<td class="seperator" bgcolor="#99ff66" width="24px">MDT</td>
		<td class="seperator" bgcolor="#ff0000" width="16px"><font color="#ffffff">
		FAI</font></td>
		<td width="16px" bgcolor="#eeeeee">&nbsp;</td>
	</tr>

</table>


</body>

</html>
<!--#include file="../closedb.asp"-->
