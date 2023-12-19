<!--#include file="../login/protect.inc"-->
<!--#include file="../opendb.asp"-->
<!DOCTYPE>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" >
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="../jquery/jquery.mobile-1.4.5.css">
<link rel="stylesheet" href="../shared/global.css">
<script src="../jquery/jquery-1.8.2.min.js"></script>
<script src="../jquery/jquery.mobile-1.4.5.min.js"></script>
<style>
	 ul > li > a > table > tbody > tr > td {
	text-align:left;
	}
	 ul > li > table > tbody > tr > th {
	text-align:left;
	}
</style>
</head>
<style>
   /* Style for the smaller button */
  .small-button-container {
    display: flex;
    justify-content: flex-end;
    align-items: center;
    padding: 10px; 
  }

  .small-button {
    padding: 12px 16px; /* Adjust padding to control button size */
    color: grey; 
    border-radius: 5px; /* Rounded corners */
    text-decoration: none;
	animation: fadeIn 2s ease;
  }

  /* Hover effect for the smaller button */
  .small-button:hover {
    background-color: transparent;
    text-decoration: none;
	  box-shadow: 0px 4px 6px rgba(0, 0, 0.2, 0.2);

  }

  /* Style for the plus sign */
  .plus-sign::before {
    content: "+"; /* Content is a plus sign */
    font-weight: bold;
    margin-right: 5px; /* Add spacing between plus sign and text */
  }

    @keyframes fadeInLogo {
  0% {
    opacity: 0; /* Start with 0% opacity */
    transform: scale(1); /* Start slightly scaled down */
  }
  100% {
    opacity: 1; /* End with 100% opacity */
    transform: scale(0.8); /* End with original scale (1) */
  }
}

#logo{
display: flex;
justify-content: center;
align-items: center;
perspective: 1000px;
margin-right: 900px;

}

#imglogo{
  height: 500px;
  width: 500px;
  margin-right: 250px;
  margin-top: -150px;
  transform: scale(0.8);
  margin-bottom: -120px;
  animation: fadeInLogo 2s ease;
  
}
@media (max-width: 800px) {
  #imglogo img {
    left: 50%;
    top: 25%;
    transform: translate(-50%, -50%);
    height: 250px;
    width: 250px;
  }
}

/* applying  fadeIn animation to element */
.element {
    animation: fadeIn 2s ease-in-out;
}

  </style>
 
<body>
	<div data-role="header" data-id="header" data-position="fixed">
		<h1>Users</h1>
			<a class="ui-btn-left" href="../default.asp" data-ajax="false" data-icon="home">
				Home
			</a>
	</div>
<%
 If Session("administrator") Then

 'id_company = session("id_company")

sql="select * from qrylogin where id_company =  " & session("id_company") & " order by login desc "
set rs=conn.execute(sql)

%>
<%Else
response.redirect("/default.asp") %>
<%End if%>
	<ul data-role="listview" data-inset="false" data-filter="true">
		 <div id="logo">
        <img id="imglogo"src="../Login/Game-On.png" />
    </div>
	<div class="small-button-container">
<!--<h2>Check out your meetingtypes here</h2>-->
    <a class="small-button" data-ajax="false" href="../bruger/bruger.asp?action=opret">
      <span class="plus-sign"></span> Add a new user
    </a>
  </div>
				<li data-role="list-divider">
					<table style="width: 100%">
						<tr style="text-align: left;">
							<th style="width: 20%">Login</th>

							<th style="width: 20%">Fornavn</th>

							<th style="width: 20%">Efternavn</th>
								
							<th style="width: 20%">Email</th>

							<th style="width: 20%">Profil</th>

						</tr>
					</table>
				</li>
				<%
					do while not rs.eof
				%>
				<li>
					<a data-ajax="false" href='../bruger/bruger.asp?action=ret&amp;id_login=<%=rs("id_login")%>'>
						<table style="width: 100%">		
								<tr>
									<td style="width: 20%"><%=rs("login")%></td>
				
									<td style="width: 20%"><%=rs("fornavn")%></td>
				
									<td style="width: 20%"><%=rs("efternavn")%></td>

									<td style="width: 20%"><%=rs("mailadresse")%></td>
				
									<td style="width: 20%"><%=rs("logintype")%></td>
				
								</tr>
						</table>
					</a>
				</li>
<%
 rs.movenext
loop
%> 			
	</ul>
<!--#include file="../shared/footer.asp"-->
</body>
<!--#include file="../closedb.asp"-->
</html>
