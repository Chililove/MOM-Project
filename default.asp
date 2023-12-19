<!--#include file="login/protect.inc"-->
<!--#include file="opendb.asp"-->
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>MoM</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="jquery/jquery.mobile-1.4.5.css">
<link rel="stylesheet" href="./shared/global.css">
<script src="jquery/jquery-1.8.2.min.js"></script>
<script src="jquery/jquery.mobile-1.4.5.min.js"></script>

</head>
<style>


.nav-tabs {
    list-style-type: none;
    padding: 0;
}

.nav-tabs li {
    display: inline;
    margin-right: 10px;
}

.nav-tabs li a {
    text-decoration: none;
    color: #007bff;
}

.nav-tabs li a:hover {
    text-decoration: underline;
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


<!--#include file="bruger/user-profile.asp"-->



<%
' Check if the "accessDenied" query parameter is present
If Request.QueryString("accessDenied") = "true" Then
%>
    <div class="error-message">
        Sorry, you are not an admin and do not have access.
    </div>
<%
End If
%>


<ul data-role="listview" >
				
<li ><a class="fade-in" style="animation-duration:100ms;" href="reg/start_timer.asp?action=newday" data-ajax="false">Start agenda registration</a></li>
<li ><a class="fade-in" style="animation-duration:500ms;" data-ajax="false" href="reg_list/my_meetings.asp">My meetings</a></li>
<li ><a class="fade-in" style="animation-duration:400ms;" data-ajax="false" href="reg_list/saved_meetings.asp">Assigned meetings</a></li>
<%if session("administrator")=true then%>
<li ><a class="fade-in" style="animation-duration:500ms;" data-ajax="false" href="reg_list/all_meetings.asp">All meetings in the company</a></li>
 <%end if %>
<li ><a class="fade-in" style="animation-duration:900ms;" data-ajax="false" href="reg/nextstep_agenda_dropdown_page.asp">Agenda points</a></li>

<%if session("administrator")=true then%>
<li ><a class="fade-in" style="animation-duration:600ms;" data-ajax="false" href="bruger/">User list</a></li>
<li ><a class="fade-in" style="animation-duration:700ms;" data-ajax="false" href="reg_list/meetingtype_list.asp">Meetingtypes</a></li>
<li ><a class="fade-in" style="animation-duration:800ms;" data-ajax="false" href="reg_list/afdeling_list.asp">Departments</a></li>

<!--<li><a data-ajax="false" href="reg_list/company_list.asp">Company list</a></li>
<li><a data-ajax="false" href="reg/company_page.asp?action=create">Add a company </a></li>-->


<%end if%>
				
</ul>
<!--#include file="shared/header_1.asp"-->
<!--#include file="shared/footer.asp"-->

</body>

</html>
<!--#include file="closedb.asp"-->
