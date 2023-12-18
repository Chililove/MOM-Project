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
</style>
<body>

<!--#include file="reg/check_sluttid.asp"-->

       <!-- <img src="login/orangedude.png" alt="User Avatar" class="user-avatar">  Replace with dynamic avatar if available -->

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


<ul data-role="listview" style="animation: fadeIn 2s ease;">
				
<%if done=1 then%>
<li><a href="reg/start_timer.asp?action=newday" data-ajax="false">Start day registration</a></li>
<%end if%>
<%if done<> 1 then%>
<li><a href="reg/start_timer.asp?action=newjob" data-ajax="false">Start new job registration</a></li>

<li><a href="reg/slut_timer.asp" data-ajax="false">End day registration</a></li>
<%end if%>


<li><a data-ajax="false" href="reg_list/saved_meetings.asp">Saved meetings</a></li>
<li><a data-ajax="false" href="reg_list/my_meetings.asp">My meetings</a></li>


<%if session("administrator")=true then%>				
<li><a data-ajax="false" href="bruger/">User list</a></li>
<li><a data-ajax="false" href="reg_list/meetingtype_list.asp">Meetingtypes</a></li>
<li><a data-ajax="false" href="reg_list/afdeling_list.asp">Departments</a></li>
<li><a data-ajax="false" href="reg/nextstep_agenda_dropdown_page.asp">Agenda points</a></li>

<!--<li><a data-ajax="false" href="reg_list/company_list.asp">Company list</a></li>
<li><a data-ajax="false" href="reg/company_page.asp?action=create">Add a company </a></li>-->


<%end if%>
				
</ul>
<!--#include file="shared/header_1.asp"-->
<!--#include file="shared/footer.asp"-->

</body>

</html>
<!--#include file="closedb.asp"-->
