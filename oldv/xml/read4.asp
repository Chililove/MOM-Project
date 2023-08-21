<%
Set XMLDoc = Server.CreateObject("MSXML2.DOMDocument")
XMLDoc.async = False
XMLDoc.setProperty "ServerHTTPRequest", true

IF XMLDoc.Load("http://mom.main-solution.dk/xml/test.xml") THEN
  Set node = xmlDoc.SelectNodes("/response/feedMessageResponse/messages/message/id")
  id = node(0).Text   
  response.write("ID:" & id & "<br>")

  Set node = xmlDoc.SelectNodes("/response/feedMessageResponse/messages/message/latitude")
  latitude = node(0).Text   
  response.write("Latitude:" & latitude & "<br>")

  Set node = xmlDoc.SelectNodes("/response/feedMessageResponse/messages/message/longitude")
  longitude = node(0).Text   
  response.write("Longitude:" & longitude & "<br>")

 ' Set node = xmlDoc.SelectNodes("/response/feedMessageResponse/messages")
 ' longitude = node(0).Text   
 ' response.write("Longitude:" & longitude & "<br>")



ELSE

  Set XMLError = XMLDoc.ParseError
  Response.Write "&#xa0;&#xa0;" & XMLError.ErrorCode & " - " & XMLError.Reason & "  URL=" & XMLError.URL

END IF

 

 

%>