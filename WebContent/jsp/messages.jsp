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
	<div id="ajax_output">
	<div id="msg_side">
		<%-- this side is for displaying conversations --%>
		<font size="3px"><strong>Conversations</strong></font><br><br>
		<sql:setDataSource var = "dbcon" driver="org.mariadb.jdbc.Driver" url="jdbc:mariadb://localhost:3306/fwdev" user="root" password="sriker11"></sql:setDataSource>
		<jsp:useBean id="frndlist" class="org.sudeep.fw.dao.HelperDao"></jsp:useBean>
		<sql:query var="msgquery" dataSource="${dbcon }">select msgto,msgfrom,message,conv_id from messages where tym in (select max(tym) from messages where (msgfrom="${loggedInUser }" and msgto in (<%=frndlist.getFriendsList(person.getPid())%>)) or (msgto="${loggedInUser }" and msgfrom in (<%=frndlist.getFriendsList(person.getPid())%>)) group by conv_id);</sql:query>
		<c:if test = "${msgquery.rowCount eq 0}">
			<c:set var="conv_count" value="${msgquery.rowCount }"></c:set>
		</c:if>
		<c:forEach items="${msgquery.rows }" var="msg">
		<a href="javascript:getconv(${msg.conv_id });"><div id="frndlist_msg">
			<c:choose>
				<c:when test="${msg.msgfrom eq loggedInUser }">
					<sql:query var="pdetailsquery" dataSource="${dbcon }">select fname,lname from person where id=?;
						<sql:param value="${msg.msgto }"></sql:param>
					</sql:query>
					<c:forEach var="pdetails" items="${pdetailsquery.rows }">
						<b><c:out value="${pdetails.fname }"></c:out>&nbsp;<c:out value="${pdetails.lname }"></c:out></b><br>
					</c:forEach>
					<pre style="color : black;"><c:out value="${msg.message }"></c:out></pre>
				</c:when>
				<c:otherwise>
					<sql:query var="pdetailsquery" dataSource="${dbcon }">select fname,lname from person where id=?;
						<sql:param value="${msg.msgfrom }"></sql:param>
					</sql:query>
					<c:forEach var="pdetails" items="${pdetailsquery.rows }">
						<b><c:out value="${pdetails.fname }"></c:out>&nbsp;<c:out value="${pdetails.lname }"></c:out></b><br>
					</c:forEach>
					<pre style="color : black;"><c:out value="${msg.message }"></c:out></pre>
				</c:otherwise>
			</c:choose>
		</div></a>
		</c:forEach>
	</div>
	<div id="conversation">
	<%-- 	<sql:query var="conversationquery" dataSource="${dbcon }">select message,msgfrom,msgto,tym from messages where (msgfrom=${loggedInUser } and msgto=${opponent }) or (msgfrom=${opponent } and msgto=${loggedInUser })  order by tym</sql:query>
		<c:forEach var="conversation" items="${conversationquery.rows }">
			<c:choose>
				<c:when test="${conversation.msgfrom eq loggedInUser }">
					<div id="convleft"><c:out value="${conversation.message }"></c:out></div><br><br>
				</c:when>
				<c:otherwise>
					<div id="convright"><c:out value="${conversation.message }"></c:out></div><br><br>
				</c:otherwise>
			</c:choose>
		
		</c:forEach>
		
	 --%>
	 <%
	 	for(int i=0;i<100;i++){
	 		out.write("hi...<br>");
	 	}
	 
	 %>
	 <c:if test="${conv_count eq 0 }">
	 	No conversations yet! You can send messages to only your friends
	 </c:if>
	</div>
	</div>
	<%@ include file="footer.jsp" %>
	<script type="text/javascript">
	function sendMsg(msgto,msg,conv_id){
		var msgfrom=${loggedInUser};
		var request = $.ajax({
			url: "addmsg",
			type: "GET",
			data: "sendto="+msgto+"&sendfrom="+msgfrom+"&msg="+msg+"&conv_id="+conv_id
			});
			request.done(function( msg ) {
			$("#ajax_output").html( msg );
			});
			request.fail(function( jqXHR, textStatus ) {
			alert( "Request failed: " + textStatus );
			});
	}
	function getconv(convid){
		var request = $.ajax({
			url: "conversation",
			type: "GET",
			data: "convid="+convid
			});
			request.done(function( msg ) {
			$("#ajax_output").html( msg );
			});
			request.fail(function( jqXHR, textStatus ) {
			alert( "Request failed: " + textStatus );
			});
	}
	/* $(document).ready(function() {
		  // run the first time; all subsequent calls will take care of themselves
		  // setTimeout(getconv, 5000);

			var mydiv = $('#conversation');
			mydiv.scrollTop(mydiv.prop('1000'));
	}); */
	</script>
	</body>
</html>

tutorial on chat applications
http://www.hascode.com/2013/08/creating-a-chat-application-using-java-ee-7-websockets-and-glassfish-4/