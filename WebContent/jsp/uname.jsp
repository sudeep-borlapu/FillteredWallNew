<%@ page trimDirectiveWhitespaces="true" %>
<% if(session.getAttribute("loggedInUser")==null){
	response.sendRedirect(request.getContextPath()+"/home");
	return;
	//request.getRequestDispatcher("/home").forward(request, response);
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
		<a href="changepwd"><div>Change Password</div></a>
		<a href="uname"><div>Username</div></a>
	</div>
	<div class="uname">
	<sql:setDataSource var="dbcon" driver="org.mariadb.jdbc.Driver" user="root" password="sriker51" url="jdbc:mariadb://localhost:3306/fwdev"/>
	<sql:query var="liudetailsquery" dataSource="${dbcon}">select * from person where id=?;
		<sql:param>${loggedInUser }</sql:param>
	</sql:query>
		<c:forEach var="liudetails" items="${liudetailsquery.rows }">
			<c:choose>
				<c:when test="${liudetails.uname != null }">  <!-- if the usename is not set by the user! -->
					You have already set your username as : <u>${liudetails.uname }</u>.<br>You can set username only once!
				</c:when>
				<c:otherwise>
				
					Username : <input autocomplete="off" type="text" name="uname" id="uname" required autofocus onkeyup="javascript:uname_availability(this.value)"/><br>
					<button onclick="javascript:save_uname();" >Save</button>&emsp;&emsp;&emsp;<button onclick="javascript:uname_availability(document.getElementById('uname').value);">Check Availability</button>
				
				</c:otherwise>
			</c:choose>
		</c:forEach>
		<div id="ajax_result"></div>
	</div>
	<%@ include file="footer.jsp" %>
	<script>
		function uname_availability(uname){
			if(uname.length >= 3){
				var request = $.ajax({
					url : "checkavailability",
					type : "GET",
					data : "uname="+uname
				});
				request.done(function(msg){
					$("#ajax_result").html(msg);
				});
				request.fail(function(jqXHR, textStatus){
					alert("Request failed: "+textStatus);
				});
			}
		}
		function save_uname(){
			var uname=document.getElementById("uname").value;
			var request = $.ajax({
				url : "saveuname",
				type : "GET",
				data : "uname="+uname
			});
			request.done(function(msg){
				$("ajax_result").html(msg);
				if(msg == "Username saved"){
					document.getElementById("uname").setAttribute("readonly", true);
					document.getElementsByName("save").setAttribute("disabled", "disabled");
				}
			});
			request.fail(function(jqXHR,textStatus){
				alert("Request failed :"+textStatus);
			});
		}
	</script>
	</body>
</html>
