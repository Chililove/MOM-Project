<!--#include file="../opendb.asp"-->

<HTML>
	<head>
	<script>
		function PopulateCombo2(id){
		
			if (window.XMLHttpRequest){
				xmlhttp=new XMLHttpRequest();
			}
			else{
				xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
			}
		    xmlhttp.open("POST","getcombo2.asp?id=" + id,false)
		    xmlhttp.send()
			combo2array=xmlhttp.responseText.split(",")
			combobox2=document.getElementById("combobox2")
			combobox2.options.length=1
			for (var i=0;i<combo2array.length;i++){
				var opt = document.createElement('option');
			    opt.value = combo2array[i]
			    opt.innerHTML = combo2array[i]
			    combobox2.appendChild(opt);
			}
			combobox2.selectedIndex=0
		}
		
	function showSelected(){
		combobox1=document.getElementById("combobox1")
		combobox2=document.getElementById("combobox2")
		combo1val=combobox1.options[combobox1.selectedIndex].text
		combo2val=combobox2.options[combobox2.selectedIndex].text
		
		alert ("you selected " + combo2val + " from the category " + combo1val)
	}	
	</script>
	</head>

	<body>
		<table width="50%">
			<tr>
				<td>combobox1:</td>
				<td>
					<select id="combobox1" name="combobox1" onchange="PopulateCombo2(this.value)">
						<option disabled selected value="-1">please select</option>	
<%
sql="select * from combo1 order by category asc"
set rs=conn.execute(sql)
do while not rs.eof
%>
							<option value="<%=rs("subcatgroup")%>"><%=rs("category")%></option>
<%
rs.movenext
loop
%>
					</select>
				</td>
				<td>combobox2:</td>
				<td>
					<select id="combobox2" name="combobox2" onchange="showSelected()">
						<option disabled selected value="-1">please select</option>	
						
					</select>
				</td>
			</tr>
		</table>
	</body>

</HTML>
<!--#include file="../closedb.asp"-->
