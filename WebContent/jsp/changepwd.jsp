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
		<a href="home"><div>Home</div></a>
		<a href="settings"><div>Settings</div></a>
	</div>
	
	<div id="chpwd">
	<div id="#errormsg">
		<% if(request.getParameter("id")!=null && request.getParameter("id").equals("notchanged")) {%>
			Something went wrong! Please try again!
		<%} if(request.getParameter("id")!=null && request.getParameter("id").equals("changed")){%>
			Your password was successfully updated.
		<%}%>
	</div>
	<form action="changepwd1" method="post" onsubmit="return checkpwds();">
	<table>
		<tr>
			<td>
				<label for="cpwd">Current Password :</label>
			</td>
			<td>
				<input type="password" name="cpwd" id="cpwd" required>
			</td>
		</tr>
		<tr>
			<td>
				<label for="cpwd">Enter New Password :</label>
			</td>
			<td>
				<input type="password" name="npwd" id="npwd" required>
			</td>
		</tr>
		<tr>
			<td>
				<label for="cpwd">Confirm New Password :</label>
			</td>
			<td>
				<input type="password" name="cnpwd" id="cnpwd" required>
			</td>
		</tr>
		<tr>
			<td colspan="2" align="center"><input type="submit" value="Change Password"></td>
		
	</table>
	</form>
	</div>
	
	<%@ include file="footer.jsp" %>
	<script lang="text/javascript">
		function checkpwds(){
			var pwd=document.getElementById("npwd").value;
			var pwd1=document.getElementById("cnpwd").value;
			//alert("The passwords are :"+pwd+", "+pwd1);
			if(pwd!=pwd1){
				alert("Passwords didn't match");
				return false;
			}
			return true;
		}
		$(function() {
			$("#dob").datepick();
		});
	</script>
	
	</body>
</html>
