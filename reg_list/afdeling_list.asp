<!--#include file="../login/protect.inc"-->
<!--#include file="../opendb.asp"-->
<!DOCTYPE>
<%
' Check if the user is an administrator
If Not session("administrator") Then
    ' If not an administrator, redirect them to an error page or some other action
    Response.Redirect("../default.asp?accessDenied=true") 
End If
%>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" >
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="../jquery/jquery.mobile-1.4.5.css">
<script src="../jquery/jquery-1.8.2.min.js"></script>
<link rel="stylesheet" href="../shared/global.css">
<script src="../jquery/jquery.mobile-1.4.5.min.js"></script>
</head>
<style>
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
    .delete-button{
      animation: fadeIn 2s ease;
    }
      /* Style for the plus sign */
      .plus-sign::before {
        content: "+"; /* Content is a plus sign */
        font-weight: bold;
        margin-right: 5px; /* Add spacing between plus sign and text */
      }
    a {
                text-decoration: none;
                color: blue;
            }

            a:hover {
                text-decoration: underline;
            }

            .delete-button {
              max-width: 100px;
              float: right;
            }

            .confirm-dialog{

                z-index: 1000;
            }
    @keyframes fadeIn {
        0% {
            opacity: 0;
        }
        100% {
            opacity: 1;
        }
    }

    
@keyframes fade-in {
    from {
        opacity: 0;
        transform: scale(0);
    }

    to {
        opacity: 1;
        transform: scale(1);
    }
}

.fade-in {
    animation: fade-in 1s;
}

</style>
<body>
 
	<div data-role="header" data-id="header" data-position="fixed">
		<h1>Departments</h1>
			<a class="ui-btn-left" href="../default.asp" data-ajax="false" data-icon="home">
				Home
			</a>
	</div>
<%
sql="select * from tbl_afdeling_2nd where id_company =  " & session("id_company") & "order by afdeling desc "
set rs=conn.execute(sql)
%>
  <div id="logo">
        <img id="imglogo"src="../Login/Game-On.png" />
    </div>
    <div class="small-button-container">
<!--<h2>Check out your meetingtypes here</h2>-->
    <a class="small-button" data-ajax="false" href="../reg/afdeling_page.asp?action=create">
      <span class="plus-sign"></span> Add a new department
    </a>
  </div>
    <h2 style="padding: 1%; height: .5px; animation: fade-in 400ms;">Existing departments</h2>
	<ul data-role="listview" data-inset="false">

				
				<li data-role="list-divider" >
					<table style="width: 100%;">
						<tr class="fade-in" style="text-align: left; animation-duration: 300ms;">
							<th style="width: 25%">Department</th>
						</tr>
					</table>
				</li>
				<%
					do while not rs.eof
				%>
				<li>
					<a  data-ajax="false" href='../reg/afdeling_page.asp?action=update&amp;id_afdeling=<%=rs("id_afdeling")%>'>

						<table style="width: 100%;">		
								<tr class="fade-in" style="animation-duration: 400ms;">
									<td style="width: 25%"><%=rs("afdeling")%></td>
								</tr>
								   <% If session("administrator") = True Then %>
<button class="delete-button" data-id="<%=rs("id_afdeling")%>" style="animation: fade-in; animation-duration: 500ms;">Delete</button>
<%end if%>
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
