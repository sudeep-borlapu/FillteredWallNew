<% if(session.getAttribute("loggedInUser")==null){
	response.sendRedirect(request.getContextPath()+"/home");
	return;
	//request.getRequestDispatcher("../jsp/index.jsp").forward(request, response);
}
%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:useBean id="person" class="org.sudeep.fw.dto.PersonDto"></jsp:useBean>
<% person.getPersonDetails(session.getAttribute("loggedInUser").toString()); %>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title><%=person.getFirstname() %> - Filtered Wall</title>
		<script src="js/jquery-2.1.3.min.js"></script>
		<link href="css/style.css" rel="stylesheet">
	</head>
	<body>
	<div id="homehead">
		<a href="home" style="clear:both; color:black; font-style: normal;text-decoration: none;">Filtered Wall</a>
		&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
		<%=person.getFirstname() %>
		<a href="logout">
			<div id="logout">
				Logout
			</div>
		</a>
	</div>
	<div id="home_side">
		Welcome : <%=person.getFirstname()%>
		<br><br>
		<a href="settings"><div>Settings</div></a>
		<a href="friends"><div>Friends</div></a>
	</div>
	<div>
		<div id="ff">
			<div id="errormsgs">
				<% if(request.getParameter("fstatus")!=null && request.getParameter("fstatus").equals("sent")) {%>
					Friend Request Sent
				<%} if(request.getParameter("fstatus")!=null && request.getParameter("fstatus").equals("notsent")){ %>
					Unable to send the friend request
				<%} %>
				<%--if(request.getParameter("unfriend")!=null && request.getParameter("unfriend").equals("success")){--/%>
					Unfriending success
				<%} if(request.getParameter("unfriend")!=null && request.getParameter("unfriend").equals("fail")){%>
					Unfriending failed. Please try again later
				<%} --%>
			</div>
			<p><font color="blue"><b>Friends You might Know</b></font></p><br>
			<c:forEach items="${sugg_friends }"  var="a">
			<div id="friendlist">
				<div id="disp_photo">
					<!-- check whether the person is male or female depending on that put the default empty picture -->
					<c:if test="${a.gender eq 'm' }">
						<img src=<c:url value="/img/male96x143.jpg"/> width="40px" height="55px">
					</c:if>
					<c:if test="${a.gender eq 'f' }">
						<img src=<c:url value="/img/female93x143.jpg"/> width="40px" height="55px">
					</c:if>
				</div>
				<div id="disp_details">
					<c:out value="${a.firstname }"></c:out>&nbsp;<c:out value="${a.lastname }"></c:out><br>
					<a href="addfriend?fid=${a.pid }">Add Friend</a>
				</div>
			</div>
			</c:forEach>
		</div>
		<div id="misc">
		<a href="viewrecieved">View Recieved Requests</a>&emsp;&emsp;<a href="viewsent">View Sent requests</a>&emsp;&emsp;<a href="friends">Friends</a>
		</div>
	</div>
	
	
	<%@include file="footer.jsp" %> %>
	</body>
</html>