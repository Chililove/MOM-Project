<!--#include file="../opendb.asp"-->

<%
sql="select * from tblfinishsetup where active=1 order by id_finishsetup asc"
setup=""
set rs=conn.execute(sql)
	do while not rs.eof
		setup=setup & rs("fieldno") & ","
		rs.movenext
	loop
setup=left(setup,len(setup)-1)
setuparray=split(setup,",")
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252" />
<title>FINISH</title>
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
 
 
 th.rotate {
  height: 200px;
  white-space: nowrap;
 }

 th.rotate > div {
  transform: 
    translate(0px,0px) rotate(-90deg);
  	width: 14px;
 }

body{
  font-family:calibri;
  font-size:14px;
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
	
	function ScrollIt(id){
		if (id=="div1") {
 			document.getElementById("div2").scrollLeft=document.getElementById(id).scrollLeft
		}
		else{
		 	document.getElementById("div1").scrollLeft=document.getElementById(id).scrollLeft
		}
	} 

</script>

</head>

<body>

<div id="infobox" style="z-index:1;display:none;position:absolute;width:350px;top:100px;left:200px;border:solid 1px #808080;">
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
					 	<td style="border-top:solid 1px #ffffff"align="right" ><button onclick="commitInfo()">
						OK</button><button onclick="infoHide()">Cancel</button></td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
</div>

<div id="comments" style="z-index:1;display:none;position:absolute;width:200px;top:100px;left:200px;border:solid 1px #808080;">
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

<div id="colSel" style="z-index:1;position:absolute;display:none;width:150px;top:100px;left:750px;border:none">
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

<%
sql="select count (*) from tblfinishsetup where active=1"
set rs=conn.execute(sql)
width=rs(0)*16
width=width+448
%>
<div id="div1" style="border:solid 1px #808080;border-bottom:none;overflow:scroll" onscroll="ScrollIt(this.id)">
<table width="100%" border="0" cellpadding="2" cellspacing="0" style="table-layout:fixed;border:solid 1px #000000">
	<tr>
		<th style="width:65px;border-bottom:solid 1px #000000;border-right:solid 1px #ffffff">&nbsp;</th>
		<th style="width:20px;border-bottom:solid 1px #000000;border-right:solid 1px #ffffff">&nbsp;</th>
		<th style="width:20px;border-bottom:solid 1px #000000;border-right:solid 1px #ffffff">&nbsp;</th>
		<th style="width:40px;border-bottom:solid 1px #000000;border-right:solid 1px #ffffff">&nbsp;</th>
		<th style="width:303px;border-bottom:solid 1px #000000;border-right:solid 1px #000000">&nbsp;</th>
		
<%
sql="select * from tblfinishsetup where active=1 order by id_finishsetup asc"
set rs=conn.execute(sql)
do while not rs.eof
%>	

		<th style="width:16px;border-bottom:solid 1px #000000;border-right:solid 1px #000000" class="rotate" bgcolor="#<%=hex(rs("color"))%>" valign="bottom"><div><span><%=rs("title")%></span></div></th>
<%
rs.movenext
loop
%>		
	</tr>
	<tr>
		<td style="border-bottom:solid 1px #000000;border-right:solid 1px #000000;width:65px" bgcolor="#eeeeee"><b>SECTION</b></td>
		<td style="border-bottom:solid 1px #000000;border-right:solid 1px #000000;width:20px" bgcolor="#eeeeee"><b>WK</b></td>
		<td style="border-bottom:solid 1px #000000;border-right:solid 1px #000000;width:20px" bgcolor="#eeeeee"><b>YR</b></td>
		<td style="border-bottom:solid 1px #000000;border-right:solid 1px #000000;width:40px" bgcolor="#eeeeee"><b>DL</b></td>
		<td style="border-bottom:solid 1px #000000;border-right:solid 1px #000000;width:303px"  bgcolor="#eeeeee"><b>INFO</b></td>
		<td style="border-bottom:solid 1px #000000;border-right:solid 1px #000000" bgcolor="#eeeeee" colspan="32">&nbsp;</td>
	</tr>


<%
sql="select * from tblfinish "
set rs=conn.execute(sql)
%>

</table>	
</div>
<div id="div2" style="height:300px;border:solid 1px #808080;border-top:none;overflow:scroll" onscroll="ScrollIt(this.id)">
<table width="100%" border="0" cellpadding="2" cellspacing="0" style="table-layout:fixed;border:solid 1px #000000" >

<%
do while not rs.eof
%>
<tr>
  <td style="border-right:solid 1px #000000;border-bottom:solid 1px #000000;width:65px" align="center"><%=rs("sektion")%></td>	
  <td style="border-right:solid 1px #000000;border-bottom:solid 1px #000000;width:20px" align="center"><%=rs("week")%></td>
  <td style="border-right:solid 1px #000000;border-bottom:solid 1px #000000;width:20px" align="center"><%=rs("year")%></td>
<%
if isdate(rs("deadline")) then
%>
  <td style="border-right:solid 1px #000000;border-bottom:solid 1px #000000;width:40px" align="center"><%=datepart("d",rs("deadline")) & "-" & monthname(datepart("m",rs("deadline")),true)%></td>
<%
else
%>
  <td style="border-right:solid 1px #000000;border-bottom:solid 1px #000000;width:40px" align="center">&nbsp;</td>
<%
end if
%>  
  <td onclick="editInfo(this.id)" id="<%=rs("id_finish")%>_info" style="border-right:solid 1px #000000;border-bottom:solid 1px #000000;width:303px;height:40px" class="info" valign="top"><%=rs("info")%></td>
<%
	for i=0 to ubound(setuparray)
		myfield="field" & setuparray(i) & "_active"
		if (rs(myfield)) then
%>
			<td title="<%=replace(rs("field" & setuparray(i) & "_note"),"<br>",vbcrlf)%>" onclick="selectColor(this.id)" id="<%=rs("id_finish")%>_col<%=setuparray(i)%>" style="border-right:solid 1px #000000;border-bottom:solid 1px #000000;width:16px" valign="middle" align="center"><img src="<%="images/" & rs("field" & setuparray(i)) & ".jpg"%>"></td>
	
<%
		else
%>	
			<td bgcolor="#aaaaaa" id="<%=rs("id_finish")%>_col<%=setuparray(i)%>" style="border-right:solid 1px #000000;border-bottom:solid 1px #000000;width:16px" valign="middle" align="center">
<%	
		end if
	next
%>
</tr>
<%
rs.movenext
loop
%>	

</table>
</div>

</body>

</html>
<!--#include file="../closedb.asp"-->
