<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Ny side1</title>
<script type="text/javascript">
    var macAddress = "";
    var ipAddress = "";
    var computerName = "";
    var wmi = GetObject("winmgmts:{impersonationLevel=impersonate}");
    e = new Enumerator(wmi.ExecQuery("SELECT * FROM Win32_NetworkAdapterConfiguration WHERE IPEnabled = True"));
    for(; !e.atEnd(); e.moveNext()) {
        var s = e.item(); 
        macAddress = s.MACAddress;
        ipAddress = s.IPAddress(0);
        computerName = s.DNSHostName;
        alert (macAddress)
    } 
</script>


</head>

<body>
<input type="text" id="txtMACAdress" />
<input type="text" id="txtIPAdress" />
<input type="text" id="txtComputerName" />

<script type="text/javascript">
    document.getElementById("txtMACAdress").value = unescape(macAddress);
    document.getElementById("txtIPAdress").value = unescape(ipAddress);
    document.getElementById("txtComputerName").value = unescape(computerName);
</script>

</body>

</html>
