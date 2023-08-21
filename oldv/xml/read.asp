<%   

Set objXMLDoc = Server.CreateObject("MSXML2.DOMDocument.3.0")    
objXMLDoc.async = False    
objXMLDoc.load Server.MapPath("test2.xml")
'objXMLDoc.load ("http://mom.main-solution.dk/xml/test2.xml")

Dim xmlProduct    
For Each xmlProduct In objXMLDoc.documentElement.selectNodes("Products")
     productCode = xmlProduct.selectSingleNode("productCode").text   
    productName = xmlProduct.selectSingleNode("ProductName").text   
     Response.Write Server.HTMLEncode(productCode) & " "
     Response.Write Server.HTMLEncode(productName) & "<br>"   
Next   

%>
