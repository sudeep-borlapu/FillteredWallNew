<% if(session.getAttribute("loggedInUser")==null){
	response.sendRedirect(request.getContextPath()+"/home");
	return;
	//request.getRequestDispatcher("../jsp/index.jsp").forward(request, response);
}
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:useBean id="person" class="org.sudeep.fw.dto.PersonDto"></jsp:useBean>
<% person.getPersonDetails(session.getAttribute("loggedInUser").toString()); %>
<sql:setDataSource var = "dbcon" driver="org.mariadb.jdbc.Driver" url="jdbc:mariadb://localhost:3306/fwdev" user="root" password="sriker51"/>
		<sql:query dataSource="${dbcon }" var="profilequery">select * from person where id=${param.id }</sql:query>
		<c:forEach var="profile" items="${profilequery.rows }">
			<c:set var="uname" value="${profile.uname }"/>
			<c:set var="fname" value="${profile.fname }"/>
			<c:set var="lname" value="${profile.lname }"/>
			<c:set var="phone" value="${profile.phone }"/>
			<c:set var="email" value="${profile.email }"/>
			<c:set var="gender" value="${profile.gender }"/>
			<c:set var="dob" value="${profile.dob }"/>
		</c:forEach>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title><%=person.getFirstname()%> - Filtered Wall</title>
		<script src="../js/jquery-2.1.3.min.js"></script>
		<link href="../css/style.css" rel="stylesheet">
	</head>
	<body>
	<div id="homehead">
		<a href="../home" style="clear:both; color:black; font-style: normal;text-decoration: none;">Filtered Wall</a>
		&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
		<%=person.getFirstname() %>
		<a href="../logout">
			<div id="logout">
				Logout
			</div>
		</a>
	</div>
	<div id="home_side">
		${fname }
		<br><br>
		<a href="../profile?id=${param.id }"><div>Time Line</div></a>
		<a href="../profile/friends?id=${param.id }"><div>Friends</div></a>
		<!-- <a href="settings"><div>Settings</div></a>
		<a href="friends"><div>Friends</div></a>
		<a href="messages"><div>Messages</div></a> -->
	</div>
	
	<sql:setDataSource var = "dbcon" driver="org.mariadb.jdbc.Driver" url="jdbc:mariadb://localhost:3306/fwdev" user="root" password="sriker11"/>
		<sql:query dataSource="${dbcon }" var="profilequery">select * from person where id=${param.id }</sql:query>
		<c:forEach var="profile" items="${profilequery.rows }">
			Name : <c:out value="${fname }"/>&nbsp;<c:out value="${lname }"/><br>
			<c:set value="${profile.fname }" var="profile.fname"/><c:set value="${profile.lname }" var="profile.lname"></c:set>
			E-Mail Address : <c:out value="${profile.email }"/><br>
			DOB : <c:out value="${profile.dob }"/><br>
			<c:if test="${profile.uname != null }">
				Username : ${profile.uname }
			</c:if>
			<c:if test="${profile.phone != null }">
				Phone : ${profile.phone }
			</c:if>
		</c:forEach><br>
		<% if(request.getParameter("responseid")!=null && request.getParameter("responseid").equals("2")) {%>
			<p style="color: green">Post saved successfully!</p>
		<%} else if(request.getParameter("responseid")!=null && request.getParameter("responseid").equals("1")) {%>
			<p style="color:red">Something went wrong!! Please try again.</p>
		<%} %>
		<h5>${fname }'s Friends</h5>
		<div id="ff">
		<sql:query dataSource="${dbcon }" var="friendsquery">SELECT * FROM friends WHERE (sentfrom=${param.id } OR sentto=${param.id}) AND status='accept'</sql:query>
		<c:forEach var="friends" items="${friendsquery.rows }">
			<c:choose>
				<c:when test="${param.id eq friends.sentto }">
					<sql:query dataSource="${dbcon }" var="personquery">SELECT dp,gender,fname,lname FROM person WHERE id="${friends.sentfrom}"</sql:query>
					<c:forEach var="person" items="${personquery.rows }">
						<div id="friendlist">
						<div id="disp_photo">
						<c:choose>
								<c:when test="${person.dp eq 't' }">
									<img src=<c:url value="../img/dp/${friends.sentfrom }.jpg"/> width="40px" height="55px">
								</c:when>
								<c:otherwise><!-- if profile pic is not set put default pictures -->
									<c:if test="${person.gender eq 'm' }">
										<img src=<c:url value="../img/male96x143.jpg"/> width="40px" height="55px">
									</c:if>
									<c:if test="${person.gender eq 'f' }">
										<img src=<c:url value="../img/female93x143.jpg"/> width="40px" height="55px">
									</c:if>
								</c:otherwise>
							</c:choose>
						</div>
						<div id="disp_details">
							<a href="profile?id=${param.id }" style="text-decoration: none"><c:out value="${person.fname }"></c:out>&nbsp;<c:out value="${person.lname }"></c:out></a><br>
							<a href="unfriend?fid=${param.id }">Unfriend</a>
						</div>
					</div>
					</c:forEach>
				</c:when>
				<c:when test="${param.id eq friends.sentfrom }">
					<sql:query dataSource="${dbcon }" var="personquery">SELECT dp,gender,fname,lname FROM person WHERE id="${friends.sentto}"</sql:query>
					<c:forEach var="person" items="${personquery.rows }">
						<div id="friendlist">
						<div id="disp_photo">
							<c:choose>
								<c:when test="${person.dp eq 't' }">
									<img src=<c:url value="../img/dp/${friends.sentto }.jpg"/> width="40px" height="55px">
								</c:when>
								<c:otherwise><!-- if profile pic is not set put default pictures -->
									<c:if test="${person.gender eq 'm' }">
										<img src=<c:url value="../img/male96x143.jpg"/> width="40px" height="55px">
									</c:if>
									<c:if test="${person.gender eq 'f' }">
										<img src=<c:url value="../img/female93x143.jpg"/> width="40px" height="55px">
									</c:if>
								</c:otherwise>
							</c:choose>
						</div>
						<div id="disp_details">
							<a href="profile?id=${param.id }" style="text-decoration: none"><c:out value="${person.fname }"></c:out>&nbsp;<c:out value="${person.lname }"></c:out></a><br>
							<a href="unfriend?fid=${param.id }" style="text-decoration: none">Unfriend</a>
						</div>
						</div>
					</c:forEach>
				</c:when>
			</c:choose>
		</c:forEach>
		</div>
	<jsp:include page="footer.jsp"></jsp:include>
	</body>
</html>