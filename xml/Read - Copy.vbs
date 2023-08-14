' Connect to a SQL Server Database


Const adOpenStatic = 3
Const adLockOptimistic = 3

Set objConnection = CreateObject("ADODB.Connection")
Set objRecordSet = CreateObject("ADODB.Recordset")

objConnection.Open _
    "Provider=SQLOLEDB;Data Source=server01\sqlexpress;Trusted_Connection=Yes;Initial Catalog=siemens;User ID=rwsiemens;Password=2mat1;"

objRecordSet.Open "SELECT * FROM qryposition", objConnection, adOpenStatic, adLockOptimistic

objRecordSet.MoveFirst

Wscript.Echo objRecordSet.RecordCount

