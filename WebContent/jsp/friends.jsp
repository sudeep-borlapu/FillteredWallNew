<%@page import="org.sudeep.fw.utils.SqlUtils"%>
<% if(session.getAttribute("loggedInUser")==null){
	response.sendRedirect(request.getContextPath()+"/home");
	return;
	//request.getRequestDispatcher("../jsp/index.jsp").forward(request, response);
}
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
		<a href="friendsuggessions"><div>Friend Suggestions</div></a>
	</div>
	<div id="ff">
	<div id="errormsgs">
		<% if(request.getParameter("fstatus")!=null && request.getParameter("fstatus").equals("sent")) {%>
			Friend Request Sent
		<%} if(request.getParameter("fstatus")!=null && request.getParameter("fstatus").equals("notsent")){ %>
			Unable to send the friend request
		<%} if(request.getParameter("unfriend")!=null && request.getParameter("unfriend").equals("success")){%>
			Unfriending success
		<%} if(request.getParameter("unfriend")!=null && request.getParameter("unfriend").equals("fail")){%>
			Unfriending failed. Please try again later
		<%} %>
	</div>
	<sql:setDataSource var = "dbcon" driver="org.mariadb.jdbc.Driver" url="jdbc:mariadb://localhost:3306/fwdev" user="root" password="sriker51"></sql:setDataSource>
		<p><font color="blue"><b>Friends with you</b></font></p><br>
		<sql:query dataSource="${dbcon }" var="ff">select * from friends where (sentto=<%=person.getPid()%> or sentfrom=<%=person.getPid()%>) and status like 'accept'</sql:query>
		<%--the intension is to find the friends he is connected with, so first select the persons who has sent or recived requests from and with status as accept --%>

		<c:set var="personid" value="<%=person.getPid() %>"></c:set>
		<c:forEach var="f" items="${ff.rows }">
			<c:if test="${f.sentto eq personid }">
				<sql:query dataSource="${dbcon }" var="pdetails">select id,gender,fname,lname from person where id="${f.sentfrom}"</sql:query>
				<%-- grab the details of the person one by one and display the persons --%>
				
				<c:forEach var="pd" items="${pdetails.rows }">
					<div id="friendlist">
						<div id="disp_photo">
							<!-- check whether the person is male or female depending on that put the default empty picture -->
							<c:if test="${pd.gender eq 'm' }">
								<img src=<c:url value="/img/male96x143.jpg"/> width="40px" height="55px">
							</c:if>
							<c:if test="${pd.gender eq 'f' }">
								<img src=<c:url value="/img/female93x143.jpg"/> width="40px" height="55px">
							</c:if>
						</div>
						<div id="disp_details">
							<a href="profile?id=${pd.id }" style="text-decoration: none"><c:out value="${pd.fname }"></c:out>&nbsp;<c:out value="${pd.lname }"></c:out></a><br>
							<a href="unfriend?fid=${pd.id }">Unfriend</a>
						</div>
					</div>
				</c:forEach>
				
			</c:if>
			<c:if test="${f.sentfrom eq personid }">
				<sql:query dataSource="${dbcon }" var="pdetails">select id,gender,fname,lname from person where id="${f.sentto}"</sql:query>
				<%-- grab the details of the person one by one and display the persons --%>
				
				<c:forEach var="pd" items="${pdetails.rows }">
					<div id="friendlist">
						<div id="disp_photo">
							<!-- check whether the person is male or female depending on that put the default empty picture -->
							<c:if test="${pd.gender eq 'm' }">
								<img src=<c:url value="/img/male96x143.jpg"/> width="40px" height="55px">
							</c:if>
							<c:if test="${pd.gender eq 'f' }">
								<img src=<c:url value="/img/female93x143.jpg"/> width="40px" height="55px">
							</c:if>
						</div>
						<div id="disp_details">
							<c:out value="${pd.fname }"></c:out>&nbsp;<c:out value="${pd.lname }"></c:out><br>
							<a href="unfriend?fid=${pd.id }">Unfriend</a>
						</div>
					</div>
				</c:forEach>

			</c:if>
		</c:forEach>

	</div>
	<div id="misc">
		<a href="viewrecieved">View Recieved Requests</a>&emsp;&emsp;<a href="viewsent">View Sent requests</a>
	</div>
	<%@ include file="footer.jsp" %>
	</body>
</html>