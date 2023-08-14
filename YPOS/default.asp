<HTML>
<HEAD>
   <script>
<%
  if request("ypos") <> 0 then
%>
   var ypos=<%=request("ypos")%>
<%  
  else
%>
  var ypos=0
<%  
  end if
%>
 	 
 	 
     function getYpos(){
       alert("form was submitted with ypos=" + ypos)
       window.scrollTo(0,ypos)
     }	
     
     function setypos(){
		document.getElementById("ypos").value=window.scrollY	   	
		alert(document.getElementById("ypos").value)
		document.getElementById("form1").submit()
     }
   </script>
</HEAD>

<BODY onload="getYpos()">


<form  id="form1"  enctype="application/x-www-form-urlencoded" method="post">
<TABLE>
  <tr>
    <td><input type="button" onclick="setypos()" value=1></td>
  </tr>
  <tr>
    <td><input type="button" onclick="setypos()" value=2></td>
  </tr>
  <tr>
    <td><input type="button" onclick="setypos()" value=3></td>
  </tr>
  <tr>
    <td><input type="button" onclick="setypos()" value=4></td>
  </tr>
  <tr>
    <td><input type="button" onclick="setypos()" value=5></td>
  </tr>
  <tr>
    <td><input type="button" onclick="setypos()" value=6></td>
  </tr>
  <tr>
    <td><input type="button" onclick="setypos()" value=7></td>
  </tr>
  <tr>
    <td><input type="button" onclick="setypos()" value=8></td>
  </tr>
  <tr>
    <td><input type="button" onclick="setypos()" value=9></td>
  </tr>
  <tr>
    <td><input type="button" onclick="setypos()" value=10></td>
  </tr>

  <tr>
    <td><input type="button" onclick="setypos()" value=11></td>
  </tr>
  <tr>
    <td><input type="button" onclick="setypos()" value=12></td>
  </tr>
  <tr>
    <td><input type="button" onclick="setypos()" value=13></td>
  </tr>
  <tr>
    <td><input type="button" onclick="setypos()" value=14></td>
  </tr>
  <tr>
    <td><input type="button" onclick="setypos()" value=15></td>
  </tr>
  <tr>
    <td><input id="pos1" type="button" onclick="setypos()" value=16></td>
  </tr>
  <tr>
    <td><input type="button" onclick="setypos()" value=17></td>
  </tr>
  <tr>
    <td><input type="button" onclick="setypos()" value=18></td>
  </tr>
  <tr>
    <td><input type="button" onclick="setypos()" value=19></td>
  </tr>
  <tr>
    <td><input type="button" onclick="setypos()" value=20></td>
  </tr>
  <tr>
    <td><input type="button" onclick="setypos()" value=21></td>
  </tr>
  <tr>
    <td><input type="button" onclick="setypos()" value=22></td>
  </tr>
  <tr>
    <td><input type="button" onclick="setypos()" value=23></td>
  </tr>
  <tr>
    <td><input type="button" onclick="setypos()" value=24></td>
  </tr>
  <tr>
    <td><input type="button" onclick="setypos()" value=25></td>
  </tr>
  <tr>
    <td><input type="button" onclick="setypos()" value=26></td>
  </tr>
  <tr>
    <td><input type="button" onclick="setypos()" value=27></td>
  </tr>
  <tr>
    <td><input type="button" onclick="setypos()" value=28></td>
  </tr>
  <tr>
    <td><input type="button" onclick="setypos()" value=29></td>
  </tr>
  <tr>
    <td><input type="button" onclick="setypos()" value=30></td>
  </tr>

  <tr>
    <td><input type="button" onclick="setypos()" value=31></td>
  </tr>
  <tr>
    <td><input type="button" onclick="setypos()" value=32></td>
  </tr>
  <tr>
    <td><input type="button" onclick="setypos()" value=33></td>
  </tr>
  <tr>
    <td><input type="button" onclick="setypos()" value=34></td>
  </tr>
  <tr>
    <td><input type="button" onclick="setypos()" value=35></td>
  </tr>
  <tr>
    <td><input type="button" onclick="setypos()" value=36></td>
  </tr>
  <tr>
    <td><input type="button" onclick="setypos()" value=37></td>
  </tr>
  <tr>
    <td><input type="button" onclick="setypos()" value=38></td>
  </tr>
  <tr>
    <td><input type="button" onclick="setypos()" value=39></td>
  </tr>
  <tr>
    <td><input type="button" onclick="setypos()" value=40></td>
  </tr>
  <input type="hidden" id="ypos" name="ypos" value="0">
</TABLE>
</form>
</BODY>
</HTML>