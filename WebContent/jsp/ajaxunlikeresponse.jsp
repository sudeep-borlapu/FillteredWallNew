<% if(session.getAttribute("loggedInUser")==null){
	response.sendRedirect(request.getContextPath()+"/home");
	return;
	//request.getRequestDispatcher("../jsp/index.jsp").forward(request, response);
}
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<sql:setDataSource var="dbcon" driver="org.mariadb.jdbc.Driver" url="jdbc:mariadb://localhost:3306/fwdev" user="root" password="sriker51"/>
<sql:update var="unlike" dataSource="${dbcon }">delete from likes where pid=? and id=?;
	<sql:param value="${param.postid}" ></sql:param>
	<sql:param value="${loggedInUser}"></sql:param>
</sql:update>
	<c:if test="${unlike eq 1}">
		<a href="javascript:like(${param.postid })" style="font-size:10px;">Like</a>
	</c:if>
	<c:if test="${unlike eq 0}">
		<a href="javascript:unlike(${param.postid })" style="font-size:10px;">Unlike</a>
	</c:if>
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