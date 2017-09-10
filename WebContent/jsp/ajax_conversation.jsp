<% if(session.getAttribute("loggedInUser")==null){
	response.sendRedirect(request.getContextPath()+"/home");
	return;
	//request.getRequestDispatcher("../jsp/index.jsp").forward(request, response);
}
%>
<%@page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:useBean id="person" class="org.sudeep.fw.dto.PersonDto"></jsp:useBean>
<% person.getPersonDetails(session.getAttribute("loggedInUser").toString()); %>
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
<input type="hidden" name="conv_id" value="${conv_id }">	
<sql:setDataSource var = "dbcon" driver="org.mariadb.jdbc.Driver" url="jdbc:mariadb://localhost:3306/fwdev" user="root" password="sriker11"></sql:setDataSource>
	<sql:query var="conversationquery" dataSource="${dbcon }">select message,msgfrom,msgto from messages where conv_id="${conv_id }"  order by tym</sql:query>
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
	<sql:query var="fetchmsgtoquery" dataSource="${dbcon }">select p1,p2 from conversations where conv_id="${conv_id }"</sql:query>
	<c:forEach var="fetchmsgto" items="${fetchmsgtoquery.rows }">
		<c:choose>
		<c:when test = "${fetchmsgto.p1 eq loggedInUser }">
			<c:set var="msgto" value="${fetchmsgto.p2}"></c:set>
		</c:when>
		<c:otherwise>
			<c:set var="msgto" value="${fetchmsgto.p1}"></c:set>
		</c:otherwise>
		</c:choose>
		
	</c:forEach>
</div>
<div>
		<textarea rows="3" cols="100" name="msg" id="msg"></textarea>
		<input type="button" value="Send Message" id="sendmsg" onclick="javascript:sendMsg(${msgto},document.getElementById('msg').value,${conv_id});">
	</div>
	The msgto value is : "${msgto}"