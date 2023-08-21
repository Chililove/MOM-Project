<!DOCTYPE html>
<html>
<body>

<p id="demo"></p>

<script>
var xhttp = new XMLHttpRequest();
xhttp.onreadystatechange = function() {
    if (xhttp.readyState == 4 && xhttp.status == 200) {
        myFunction(xhttp);
    }
};
xhttp.open("GET", "http://mom.main-solution.dk/xml/test.xml", true);
xhttp.send();

function myFunction(xml) {
    var xmlDoc = xml.responseXML;
    var x = xmlDoc.documentElement;
    document.getElementById("demo").innerHTML =
    "Nodename: " + x.nodeName + "<br>" +
    "Nodevalue: " + x.nodeValue + "<br>" +
    "Nodetype: " + x.nodeType;
}
</script>

</body>
</html>

