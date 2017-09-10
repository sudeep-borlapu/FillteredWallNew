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
		${fname }
		<br><br>
		<a href="profile?id=${param.id }"><div>TimeLine</div></a>
		<a href="profile/friends?id=${param.id }"><div>Friends</div></a>
		<!-- <a href="settings"><div>Settings</div></a>
		<a href="friends"><div>Friends</div></a>
		<a href="messages"><div>Messages</div></a> -->
	</div>
	
		<sql:query dataSource="${dbcon }" var="profilequery">select * from person where id=${param.id }</sql:query>
		<c:forEach var="profile" items="${profilequery.rows }">
			Name : <c:out value="${profile.fname }"/>&nbsp;<c:out value="${profile.lname }"/><br>
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
		<div id="home_status_update">
			<form action="postonother" method="post" onsubmit="return checkPostForEmpty();">
				<input type="hidden" name="loggedinuserid" id="loggedinuserid" value="<%=session.getAttribute("loggedInUser").toString() %>">
				<input type="hidden" name="profileid" id="profileid" value="${param.id}">
				<textarea rows="3" cols="100" placeholder="Say! What's in your mind!" id="status_update" name="post_on_wall"></textarea><br>
				<input type="submit" value="Post">
			</form>
		</div>
		<div id="home_time_line">
		<sql:query dataSource="${dbcon }" var="postsquery">SELECT pid,id,body,time,onwall FROM posts WHERE onwall=${param.id } OR id=${param.id } ORDER BY time DESC</sql:query>
			<c:forEach var="post" items="${postsquery.rows }">
				<div id="posts">
					<sql:query dataSource="${dbcon }" var="postdetails">select dp,id,fname,lname,gender from person where id=${post.id }</sql:query>
					<c:forEach var="person" items="${postdetails.rows }">
					<div id="disp_photo">
						<c:choose>
								<c:when test="${person.dp eq 't' }">
									<img src=<c:url value="img/dp/${person.id }.jpg"/> width="40px" height="55px">
								</c:when>
								<c:otherwise><!-- if profile pic is not set put default pictures -->
									<c:if test="${person.gender eq 'm' }">
										<img src=<c:url value="img/male96x143.jpg"/> width="40px" height="55px">
									</c:if>
									<c:if test="${person.gender eq 'f' }">
										<img src=<c:url value="img/female93x143.jpg"/> width="40px" height="55px">
									</c:if>
								</c:otherwise>
						</c:choose>
					</div>
					<c:choose>
						<c:when test="${post.onwall eq null}">
							<font color="blue"><a style="text-decoration : none;" href="profile?id=${person.id}">${person.fname}&nbsp;${person.lname}</a></font> 
							updated<c:if test="${person.gender eq 'm'}"> his </c:if><c:if test="${person.gender eq 'f'}"> her </c:if>status<br>
							at ${fn:substring(post.time,11,16)} on ${fn:substring(post.time,8,10)}-${fn:substring(post.time,5,7)}-${fn:substring(post.time,0,4)} as..<br>
						</c:when>
						<c:otherwise>
							<jsp:useBean id="person1" class="org.sudeep.fw.dto.PersonDto"></jsp:useBean>
							<c:if test="${loggedInUser != post.onwall }">
							<c:set var="onwallid" value="${post.onwall }" scope="session" />
							<% person1.getPersonDetails(session.getAttribute("onwallid").toString());%>
								<font color="blue"><a style="text-decoration : none;" href="profile?id=${person.id}">${person.fname}&nbsp;${person.lname}</a></font> > <a style="text-decoration : none;" href="profile?id=<%=person1.getPid() %>"><%=person1.getFirstname() %>&nbsp;<%=person1.getLastname() %></a><br>
								at ${fn:substring(post.time,11,16)} on ${fn:substring(post.time,8,10)}-${fn:substring(post.time,5,7)}-${fn:substring(post.time,0,4)}
							</c:if>
							<c:if test="${loggedInUser == post.onwall }">
								<c:set var="onwallid" value="${post.onwall}" scope="session" />
								<% person1.getPersonDetails(session.getAttribute("onwallid").toString());%>
								<font color="blue"><a style="text-decoration : none;" href="profile?id=${person.id}">${person.fname}&nbsp;${person.lname }</a></font> has posted on your wall<br>
								at ${fn:substring(post.time,11,16)} on ${fn:substring(post.time,8,10)}-${fn:substring(post.time,5,7)}-${fn:substring(post.time,0,4)}
							</c:if>
						</c:otherwise>
					</c:choose>
					</c:forEach>
					<div id="postcontent">
					<pre><c:out value="${post.body }"></c:out></pre>
					<div id="p${post.pid }">
					<sql:query var="likesquery" dataSource="${dbcon }">select pid from likes where pid="${post.pid }" and id="${loggedInUser}"</sql:query>
					<c:forEach var="like" items="${likesquery.rows }">
					<c:set var="liked" value="liked"></c:set>
					</c:forEach>
					<c:choose>
						<c:when test="${liked eq 'liked'}">
								<a href="javascript:unlike(${post.pid});" style="font-size:10px;">Unlike</a>
								<c:set var="liked" value="unliked"></c:set>
						</c:when>
						<c:otherwise>
							<a href="javascript:like(${post.pid });" style="font-size:10px;">Like</a>
						</c:otherwise>
					</c:choose>
					<%-- <sql:query var="likescount" dataSource="${dbcon }">select count(${col.pid }) from likes where pid=${col.pid }</sql:query>
					<c:forEach items="${likescount.rows }" var="count">
					<c:choose>
						<c:when test="${count == 0 }">
						
						</c:when>
						<c:otherwise>
							(${count })
						</c:otherwise>
					</c:choose>
					</c:forEach>
					 --%>
					<sql:query var="likescountquery" dataSource="${dbcon }">select count(pid) as count from likes where pid=?;
					<sql:param value="${post.pid }"></sql:param>
					</sql:query>
					<c:forEach var="likecount" items="${likescountquery.rows }">
						<c:choose>
							<c:when test="${likecount.count gt 0 }">
								<font size="1px">(${likecount.count })</font>
							</c:when>
						</c:choose>
					</c:forEach> 
					</div>
					</div>
				</div>
			<br>
			</c:forEach>
		
		<%--<jsp:useBean id="posts" class="org.sudeep.fw.dto.PostsDto" ></jsp:useBean>
		<% posts.getPost(session.getAttribute("loggedInUser").toString()); %>
		<% posts.getPostDetails(posts.getPid()); %>
		<%=posts.getBody() --%>
	</div>
		
	<jsp:include page="footer.jsp"></jsp:include>
	<script>
	function checkPostForEmpty(){
		if(document.getElementById("status_update").value==null || document.getElementById("status_update").value==""){
			alert("Post cannot be empty!");
			return false;
		}
		return true;
	}
	function like(postid){
		var id = document.getElementById("loggedinuserid").value;
		var divID = "#p"+postid;
		var request = $.ajax({
			url: "like",
			type: "GET",
			data: "postid="+postid
			});
			request.done(function( msg ) {
			$(divID).html( msg );
			});
			request.fail(function( jqXHR, textStatus ) {
			alert( "Request failed: " + textStatus );
			});
	}
	function unlike(postid){
		var id = document.getElementById("loggedinuserid").value;
		var divID = "#p"+postid;
		var request = $.ajax({
			url: "unlike",
			type: "GET",
			data: "postid="+postid
		});
		request.done(function(msg){
			$(divID).html(msg);
		});
		request.fail(function(jqXHR, textStatus){
			alert("Request failed: "+textStatus);
		});
	}
	function statusChange(){
		defaultStatus="";
	}
</script>
	</script>
	</body>
</html>