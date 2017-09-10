<% if(session.getAttribute("loggedInUser")==null){
	response.sendRedirect(request.getContextPath()+"/home");
	return;
	//request.getRequestDispatcher("../jsp/index.jsp").forward(request, response);
}
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<sql:setDataSource var="dbcon" driver="org.mariadb.jdbc.Driver" url="jdbc:mariadb://localhost:3306/fwdev" user="root" password="sriker51"/>
<sql:query var="likesquery" dataSource="${dbcon }">select pid from likes where pid="${param.postid }" and id="${loggedInUser}"</sql:query>
	<c:forEach var="likes" items="${likesquery.rows }">
		<a href="javascript:unlike(${param.postid})" style="font-size:10px;">Unlike</a>
			<sql:query var="likescountquery" dataSource="${dbcon }">select count(pid) as count from likes where pid=?;
			<sql:param value="${param.postid }"></sql:param>
		</sql:query>
		<c:forEach var="likecount" items="${likescountquery.rows }">
			<c:choose>
				<c:when test="${likecount.count gt 0 }">
					<font size="1px">(${likecount.count })</font>
				</c:when>
			</c:choose>
		</c:forEach>
	</c:forEach>