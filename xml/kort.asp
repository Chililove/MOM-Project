<!--#include file="../opendb.asp"-->
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Language" content="da">
<meta http-equiv="Refresh" content="60">
<link rel="stylesheet" type="text/css" href="../css/standard.css">
<script
src="js">
</script>
 <style type="text/css">
   .labels {
     color: blue;
     background-color: white;
     font-family: "Lucida Grande", "Arial", sans-serif;
     font-size: 10px;
     font-weight: bold;
     text-align: center;
     width: 40px;
     border: 2px solid black;
     white-space: nowrap;
   }
      html, body, #googleMap {
        height: 100%;
        margin: 0px;
        padding: 0px
      }
    </style>

<script type="text/javascript" src="markerwithlabel.js"></script>

<script>
function initialize() {


//find center point
<%
'if session("windparkid")=2 then
'set rs1=conn.execute("select * from srvturbinenummer where park=1 ;")
'else
'set rs1=conn.execute("select * from srvturbinenummer where  park=" & session("windparkid")&" and groupid=" & request("groupid")&" ;")
'end if

%>
    // initialize the map
    var latlng = new google.maps.LatLng(55.138, 7.188716667);

    
   
    
    var myOptions = {
      zoom: 12,
      center: latlng,
      mapTypeId: google.maps.MapTypeId.ROADMAP,
     
    };

    var map = new google.maps.Map(document.getElementById("googleMap"), myOptions);
	var image_marked = 'marker1.gif';

<%
set rs=conn.execute("select * from srvturbinenummer where park=1 and lat <> '' " )
while not rs.eof 

if rs.Fields("typeid")=1 then
%>
	var image_unmarked = 'windturbine.png';
<%else%>
	var image_unmarked = 'platform.png';
<%end if%>
    var currLatLng = new google.maps.LatLng(<%=rs.Fields("lat")%>, <%=rs.Fields("long")%>);
         
    var marker1 = new MarkerWithLabel({
    position: currLatLng,
    map: map,
    icon: image_unmarked,
    labelContent: "<%=rs.Fields("p1")%>",
    labelAnchor: new google.maps.Point(22, 0),
    labelClass: "labels", // the CSS class for the label
    labelStyle: {opacity: 0.75}
    });
<%  
rs.movenext()
wend
%>




   }    

google.maps.event.addDomListener(window, 'load', initialize);
</script>
</head>

<body>
<div id="googleMap" >

</div>

</body>
</html>
<!--#include file="../closedb.asp"-->