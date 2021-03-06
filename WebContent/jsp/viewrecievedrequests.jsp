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
	</div>
	<div id="errormsgs">
	<%if(session.getAttribute("confirmfriend")!=null &&  session.getAttribute("confirmfriend").equals("success")){ %>
		Friend Added!
	<% session.removeAttribute("confirmfriend"); } %> 
	</div>
	<pre>Recieved Requests</pre>
	<sql:setDataSource var = "dbcon" driver="org.mariadb.jdbc.Driver" url="jdbc:mariadb://localhost:3306/fwdev" user="root" password="sriker51"></sql:setDataSource>
		<sql:query dataSource="${dbcon }" var="ff">select id,fname,lname,gender from person where id in (select sentfrom from friends where sentto="${loggedInUser }" and status like 'sent')</sql:query>
				<c:forEach var="f" items="${ff.rows }">
				<div id="friendlist">
					<div id="disp_photo">
						<!-- check whether the person is male or female depending on that put the default empty picture -->
						<c:if test="${f.gender eq 'm' }">
							<img src=<c:url value="/img/male96x143.jpg"/> width="40px" height="55px">
						</c:if>
						<c:if test="${f.gender eq 'f' }">
							<img src=<c:url value="/img/female93x143.jpg"/> width="40px" height="55px">
						</c:if>
					</div>
					<div id="disp_details">		
						<c:out value="${f.fname }"></c:out> <c:out value="${f.lname }"></c:out><br>
						<a href="confirmfriend?fid=${f.id }">Confirm</a>&emsp;&emsp;<a href="discardfriend?fid=${f.id }">Discard</a>
					</div>
				</div>
				</c:forEach>
			
	</div>
	<div id="misc">
		<a href="friends">Friends</a>&emsp;&emsp;<a href="viewsent">View Sent requests</a>
	</div>
	<%@ include file="footer.jsp" %>
	</body>
</html>