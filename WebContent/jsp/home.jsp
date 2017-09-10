<%@page import="org.sudeep.fw.dao.PostsDao"%>
<%@page import="org.sudeep.fw.daofactory.DaoFactory"%>
<% if(session.getAttribute("loggedInUser")==null){
	response.sendRedirect(request.getContextPath()+"/home");
	return;
	//request.getRequestDispatcher("../jsp/index.jsp").forward(request, response);
}
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ page import="java.sql.Connection,java.sql.ResultSet,java.sql.Statement,java.sql.PreparedStatement" %>
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
		&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
		&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
		&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
		<%=person.getFirstname() %>
		<a href="logout">
			<div id="logout">
				Logout
			</div>
		</a>
	</div>
	<div id="home_side">
		Welcome : <%=person.getFirstname()%>
		<div class="edit_profile" onclick="window.location='editprofile'">Edit Profile</div>
		<br><br>
		<a href="settings"><div>Settings</div></a>
		<a href="friends"><div>Friends</div></a>
		<a href="messages"><div>Messages</div></a>
	</div>
	<div id="home_status_update">
		<form action="statusupdate" method="post" onsubmit="return checkPostForEmpty();">
			<input type="hidden" name="loggedinuserid" id="loggedinuserid" value="<%=session.getAttribute("loggedInUser").toString() %>">
			<textarea rows="3" cols="100" placeholder="Say! What's in your mind!" id="status_update" name="status_update"></textarea><br>
			<input type="submit" value="Post">
		</form>
	</div>
	
	
	<div id="home_time_line">
	<%	
		try{
		Connection con = DaoFactory.getConnection();
		Statement st = con.createStatement();
		PostsDao pdao = new PostsDao();
		//System.out.println(pdao.getPostsQuery(Integer.parseInt(session.getAttribute("loggedInUser").toString())));
		ResultSet postsRS = st.executeQuery(pdao.getPostsQuery(Integer.parseInt(session.getAttribute("loggedInUser").toString()))); 
		while(postsRS.next()){%>
	<div id="posts">
	<%		Statement st1 = con.createStatement();
			//System.out.println("The posted persons id is :"+postsRS.getInt("id"));
			ResultSet personRS = st1.executeQuery("select dp,id,fname,lname,gender from person where id="+postsRS.getInt("id"));
			while(personRS.next()){%>
			<!-- display photo of the posted person -->
			<div id="disp_photo">	
	<%			if(personRS.getString("dp").equals("t")){	%>
				<img src='img/dp/<%=personRS.getString("id")%>.jpg' width="40px" height="55px">
		
	<%			}else {
					if(personRS.getString("gender").equals("m")){%>
						<img src=<c:url value="/img/male96x143.jpg"/> width="40px" height="55px">
	<%				}else if(personRS.getString("gender").equals("f")){%>
						<img src=<c:url value="/img/female93x143.jpg"/> width="40px" height="55px">
	<%				}%>
	<% 			}%>
			</div>
			<%
			
			if(postsRS.getString("onwall").equalsIgnoreCase(session.getAttribute("loggedInUser").toString())){%>
			You have updated ur status<%-- <font color="blue"><a style="text-decoration:none;" href="profile?id=<%=personRS.getInt("id") %>"><%=personRS.getString("fname")+" "+personRS.getString("lname") %></a></font> posted on your wall --%>
			<%} 
			
			else if(!postsRS.getString("onwall").equalsIgnoreCase(session.getAttribute("loggedInUser").toString())){%>
			<%-- I may post some one's wall and some one may post on my wall --%>
			<font color="blue"><a style="text-decoration:none;" href="profile?id=<%=personRS.getInt("id") %>"><%=personRS.getString("fname")+" "+personRS.getString("lname") %></a></font>
			<%} %>
			<%-- display the post content --%>	
			<div id="postcontent">
				<pre><%=postsRS.getString("body") %></pre>
				<%-- display like count and link to Like or Unlike --%>
				<div id="p<%=postsRS.getString("pid")%>">
					<%	boolean personLiked = false;
						st = con.createStatement();
						ResultSet likesRS = st.executeQuery("select pid from likes where pid="+postsRS.getInt("pid")+" and "+person.getPid());
						if(likesRS.next()){%>
							<a href="javascript:unlike(<%=postsRS.getInt("pid") %>);" style="font-size:10px;">Unlike</a>
					<%	}
						else{%>
							<a href="javascript:like(<%=postsRS.getInt("pid") %>)" style="font-size:10px;">Like</a>
					<%	}%>
					<% 
						ResultSet likeCount = st.executeQuery("select count(pid) from likes where pid="+postsRS.getInt("pid"));
						while(likeCount.next()){ if(likeCount.getInt(1) > 0){
					%>
							<font size="1px">(<%=likeCount.getInt(1) %>)</font>		
					<%	}}
					%>
				
				</div>
			</div>
			
			
	<%		}%>
	</div>
	<%
		}
	}catch(Exception e){
		e.printStackTrace();
	}
	%>
	</div>

<%--	
	<jsp:useBean id="ab" class="org.sudeep.fw.dao.PostsDao"></jsp:useBean>
		<sql:setDataSource var = "dbcon" driver="org.mariadb.jdbc.Driver" url="jdbc:mariadb://localhost:3306/fwdev" user="root" password="sriker51"></sql:setDataSource>
		<sql:query dataSource="${dbcon }" var="postsquery"><%=ab.getPostsQuery(person.getPid()) %></sql:query>
			<c:forEach var="post" items="${postsquery.rows }">
				<div id="posts">
					<sql:query dataSource="${dbcon }" var="postdetails">select dp,id,fname,lname,gender from person where id=${post.id }</sql:query>
					<c:forEach var="person" items="${postdetails.rows }">
					<div id="disp_photo">
						<c:choose>
								<c:when test="${person.dp eq 't' }">
									<img src=<c:url value="/img/dp/${person.id }.jpg"/> width="40px" height="55px">
								</c:when>
								<c:otherwise><!-- if profile pic is not set put default pictures -->
									<c:if test="${person.gender eq 'm' }">
										<img src=<c:url value="/img/male96x143.jpg"/> width="40px" height="55px">
									</c:if>
									<c:if test="${person.gender eq 'f' }">
										<img src=<c:url value="/img/female93x143.jpg"/> width="40px" height="55px">
									</c:if>
								</c:otherwise>
						</c:choose>
					</div>
						<c:choose>
							<c:when test="${post.onwall == null }">
								<font color="blue"><a style="text-decoration : none;" href="profile?id=${person.id}"><c:out value="${person.fname }"></c:out>&nbsp;<c:out value="${person.lname }"></c:out></a></font> 
								updated<c:if test="${person.gender eq 'm'}"> his </c:if><c:if test="${person.gender eq 'f'}"> her </c:if>status<br>
								at ${fn:substring(post.time,11,16)} on ${fn:substring(post.time,8,10)}${fn:substring(post.time,5,7)}${fn:substring(post.time,0,4)} as..<br>
							</c:when>
							<c:otherwise>
								<font color="blue"><a style="text-decoration : none;" href="profile?id=${person.id }">${person.fname }&nbsp;${person.lname }</a></font>
								<sql:query var="wallonquery" dataSource="${dbcon }">SELECT fname,lname FROM person WHERE id=${post.onwall}</sql:query>
								<c:forEach var="wallon" items="${wallonquery.rows }">
								<c:if test="${loggedInUser eq post.onwall}">
									posted on your wall<br>
									at ${fn:substring(post.time,11,16)} on ${fn:substring(post.time,8,10)}-${fn:substring(post.time,5,7)}
								</c:if>
								<c:if test="${loggedInUser != post.onwall }">
									> <font color="blue"><a style="text-decoration : none;" href="profile?id=${post.onwall }">${wallon.fname }&nbsp;${wallon.lname }</a></font><br>
									${fn:substring(post.time,11,16)} on ${fn:substring(post.time,8,10)}-${fn:substring(post.time,5,7)}
								</c:if>
								</c:forEach> 
								
							</c:otherwise>
						</c:choose>
					</c:forEach>
					<div id="postcontent">
					<pre><c:out value="${post.body}"></c:out></pre>
					<div id="p${post.pid }">
					<sql:query var="likesquery" dataSource="${dbcon}">select pid from likes where pid="${post.pid}" and id="${loggedInUser}"</sql:query>
					<c:forEach var="like" items="${likesquery.rows}">
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
	</div>
 --%>


	<%@ include file="footer.jsp" %>
	<script lang="text/javascript">
		function checkPostForEmpty(){
			if(document.getElementById("status_update").value==null || document.getElementById("status_update").value==""){
				alert("Post cannot be empty!");
				return false;
			}
			return true;
		}
		/* $(document).ready(function() {
			  $('textarea').keydown(function(event){
			    if (event.keyCode == 13) {
			      event.preventDefault();
			      var s = $(this).val();
			      $(this).val(s+"\n");
			    }
			});
		}); */
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
	</script>
	</body>
</html>