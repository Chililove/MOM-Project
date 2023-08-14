
<%
   Response.Buffer = True
   Dim xml
   Set xml = Server.CreateObject("Microsoft.XMLDOM")
   xml.async = False
   xml.setProperty "ServerHTTPRequest", True

'if  xml.Load ("http://mom.main-solution.dk/xml/test.xml") then
    xml.Load ("http://mom.main-solution.dk/xml/test.xml") 
  

For Each xmlProduct In XML.documentElement.selectNodes("Products")

	id = xml.documentElement.childNodes(1).text
	'txt2 = xml.documentElement.childNodes(1).text
	'id = xml.documentElement.selectSingleNode("Product").text

response.write id &"123<br>"
Next

'else
response.write err.description
'end if

   Set xml = Nothing
   
   
%>