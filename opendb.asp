<%
set conn=server.createobject("adodb.connection")
conn.open Application("timer_ConnectionString")

set conn1=server.createobject("adodb.connection")
conn1.open Application("timer_ConnectionString")

set conn2=server.createobject("adodb.connection")
conn2.open Application("timer_ConnectionString")



Function CalcHrsMins(TotalMinutes) 

'calculate the hours
varHours = Int(TotalMinutes / 60)
varHours = ZeroPadInteger(varHours ,2)

'calculate the remaining minutes
'varMinutes = Format(TotalMinutes - (varHours * 60), "00")
varMinutes = TotalMinutes - (varHours * 60)

varMinutes= ZeroPadInteger(varMinutes,2)


CalcHrsMins = (varHours & ":"& varMinutes)
End Function 


Const NUMBER_PADDING = "000000000000" ' a few zeroes more just to make sure

Function ZeroPadInteger(i, numberOfDigits)
  ZeroPadInteger = Right(NUMBER_PADDING & i, numberOfDigits)
End Function




%>

