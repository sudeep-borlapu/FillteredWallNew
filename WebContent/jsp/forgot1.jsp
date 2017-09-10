<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="header.jsp" %>
<title>Forgot Password</title>
<%@ include file="header_after_title.jsp" %>
	<sql:setDataSource var = "dbcon" driver="org.mariadb.jdbc.Driver" url="jdbc:mariadb://localhost:3306/fwdev" user="root" password="sriker11"></sql:setDataSource>
	<sql:query dataSource="${dbcon }" var="result">select * from person where email='<%=request.getAttribute("email") %>'</sql:query>
	<center>
	<div id="forgot_box">
	<c:if test="${result.rows!=null }">
		
		<c:forEach var="col" items="${result.rows }">
			<c:if test="${col.length == 0 }">
				No records with that e-mail.
			</c:if>
			<%--<c:out value="${col.id }"></c:out> --%>
			<jsp:useBean id="email" class="org.sudeep.fw.email.ForgotPasswordEmail"></jsp:useBean>
			<% email.sendMail(request.getParameter("email"));%>
				<p>Password has been sent to your registered email.</p>
		</c:forEach>
	</c:if>
	
	</div>
	</center>
<%@ include file="footer.jsp" %>
</body>
</html>