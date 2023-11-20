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
</style>
<body>

<!--#include file="reg/check_sluttid.asp"-->

       <!-- <img src="login/orangedude.png" alt="User Avatar" class="user-avatar">  Replace with dynamic avatar if available -->

<!--#include file="bruger/user-profile.asp"-->


<ul data-role="listview">
				
<%if done=1 then%>
<li><a href="reg/start_timer.asp?action=newday" data-ajax="false">Start day registration</a></li>
<%end if%>
<%if done<> 1 then%>
<li><a href="reg/start_timer.asp?action=newjob" data-ajax="false">Start new job registration</a></li>

<li><a href="reg/slut_timer.asp" data-ajax="false">End day registration</a></li>
<%end if%>


<!--li><a data-ajax="false" href="reg_list/list_my_last20.asp">Last 20 registrations</a></li>
<li><a data-ajax="false" href="reg_list/list_my_last20X.asp">Last 20 reggistrations</a></li>-->

<!-- <li><a data-ajax="false" href="reg_list/list_my_sum.asp">Last 10 days</a></li> -->
<li><a data-ajax="false" href="reg_list/saved_meetings.asp">Saved meetings</a></li>
<li><a data-ajax="false" href="reg_list/my_meetings.asp">My meetings</a></li>


<%if session("administrator")=true then%>				
<li><a data-ajax="false" href="bruger/">User list</a></li>
<li><a data-ajax="false" href="bruger/bruger.asp?action=opret">New user</a></li>
<li><a data-ajax="false" href="reg_list/company_list.asp">Company list</a></li>
<li><a data-ajax="false" href="reg/company_page.asp?action=create">Add a company </a></li>
<li><a data-ajax="false" href="reg_list/meetingtype_list.asp">Meetingtypes</a></li>
<li><a data-ajax="false" href="reg/meetingtype_page.asp?action=create">Add a meetingtype </a></li>
<li><a data-ajax="false" href="reg_list/afdeling_list.asp">Departments</a></li>
<li><a data-ajax="false" href="reg/afdeling_page.asp?action=create">Add a department </a></li>


<%end if%>
				
</ul>
<!--#include file="shared/header_1.asp"-->
<!--#include file="shared/footer.asp"-->
<ul data-role="listview" data-inset="false" data-filter="false">

<%if done=0 then%>
<p>Ongoing job:</p>
<li>
<!--Customer:<b><%'=kundenavn%></b><br>-->
Job:<b><%=job_dk%></b><br>
Start date:<b><%=FormatDateTime(starttid,2)%></b><br>
Start time:<b><%=FormatDateTime(starttid,4)%></b><br>
</li>

</ul>
<%end if%>
</body>

</html>
<!--#include file="closedb.asp"-->
