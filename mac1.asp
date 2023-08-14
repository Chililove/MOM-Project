<html>
	<head>
		<script>
			function doInsert(inp) {
				var v = inp.value;
				var l = v.length;
				var maxLen = 17 // Length of mac string including ':'
				if(l >= 2 && l < maxLen) { 
					var v1;
					v1 = v;					
					/* Removing all ':' to calculate get actaul text */
					while(!(v1.indexOf(":") < 0)) { // Better use RegEx
						v1 = v1.replace(":", "")
					}					
					/* Insert ':' after ever 2 chars */
					if(v1.length%2 == 0) {
						inp.value = v + ":";
					}
				}
			}
		</script>
	</head>
	
	<body onload="doInsert(this);">
		<input type="text" maxlength="17" onkeydown="doInsert(this);"/>
	</body>
</html>