<% if(session.getAttribute("loggedInUser")!=null){
		request.getRequestDispatcher("../jsp/home.jsp").forward(request, response);
	}
%>

<%@include file="header.jsp" %>
<meta http-equiv="pragma" content="no-cache" />
<meta http-equiv="Cache-Control" content="no-cache" />
<title>Filtered Wall - Login || Register</title>
<%@ include file="header_after_title.jsp" %>
	<div id="container">
		<div id="globalerrmsgs">
			<% if(request.getParameter("id")!=null && request.getParameter("id").equals("logout")){%>
				Successfully Logged Out	
			<% }%>
			<% if(request.getParameter("id")!=null && request.getParameter("id").equals("needed")){%>
				Login required
			<% }%>
		</div>
		<div id="register">
		
		<h5 align="center" style="font-style: oblique;color: red;">For those who have not registered!</h5>
			<form action="<%=response.encodeURL("register") %>" method="post" autocomplete="off">
				<div id="errormsg">
				<%if(request.getParameter("id")!=null && request.getParameter("id").equals("mismatch")){%>
					<font style="color:red; font-size: 3em;">Passwords didn't match. Please make sure that passwords are same!</font>
				<%} %> 
				
				<% if(request.getParameter("id")!=null && request.getParameter("id").equals("success")){ %>
					<font style="color: green; font-size :1em;">Registration success! Please login with the email and passwords provided</font>
				<%} %>
				<% if(request.getParameter("id")!=null && request.getParameter("id").equals("efail")){ %>
					Registration is successfull but sending email has been failed. You can even login with the email and password provided
				<%} %>
				
				<% if(request.getParameter("id")!=null && request.getParameter("id").equals("failure")){ %>
					<font style="color: red; font-size :3em;">Registration failed! please try again.</font>
				<%} %>
				
				<%-- Fields mandatory error messages! --%>
				
				<% if(request.getParameter("id")!=null && request.getParameter("id").equals("fname")) {%>
					Firstname is mandatory!
				<%}%>
				<% if(request.getParameter("id")!=null && request.getParameter("id").equals("lname")) {%>
					Last Name is mandatory!
				<%} %>
				<% if(request.getParameter("id")!=null && request.getParameter("id").equals("email")) {%>
					E-Mail is mandatory!
				<%} %>
				<%--email already exist in database --%>
				<% if(request.getParameter("id")!=null && request.getParameter("id").equals("emailexists")) {%>
					E-Mail already registered. Please use another.
				<%}	%>
				
				<% if(request.getParameter("id")!=null && request.getParameter("id").equals("dob")) {%>
					Date of Birth is mandatory
				<%} %>
				
				<% if(request.getParameter("id")!=null && request.getParameter("id").equals("gender")) {%>
					Gender is mandatory
				<%} %>
				
				<% if(request.getParameter("id")!=null && request.getParameter("id").equals("password")) {%>
					Password is mandatory
				<%} %>
		
			</div>
			<table id="registertable">
			<tr>
				<td>
					<label for="firstname">
						First Name 
					</label>
				</td>
				<td><input type="text" name="firstname" id="firstname" size="20" required max="40"></td>
			</tr>
			<tr>
				<td>
					<label for="lastname">
						Last Name 
					</label>
				</td>
				<td>
					<input type="text" name="lastname" id="lastname" size="20" required max="40">
				</td>
			</tr>
			<tr>
				<td>
					<label for="gender">Gender</label>
				</td>
				<td>
					<input type="radio" name="gender" id="gender" value="m">Male &emsp;&emsp;<input type="radio" id="gender" name="gender" value="f">Female
			</tr>
			<tr>
				<td>
					<label for="email">
						E-Mail 
					</label>
				</td>
				<td>
					<input type="email" name="email" required id="email" size="20" max="40">
				</td>
			</tr>
			<tr>
				<td>
					<label for="pwd">Password</label>
				</td>
				<td>
					<input type="password" name="password" required id="password" size="20" max="40" placeholder="&bull;&bull;&bull;&bull;&bull;&bull;&bull;&bull;">
				</td>
			</tr>
			<tr>
				<td>
					<label for="repwd">Re-enter Password </label>
				</td>
				<td>
					<input type="password" name="repassword" required id="repassword" size="20" max="40" placeholder="&bull;&bull;&bull;&bull;&bull;&bull;&bull;&bull;">
			<tr>
				<td>
					<label for="dob">Date Of Birth</label>
				</td>
				<td>
					<input type="text" name="dob" id="dob" required>
			<tr> 
				<td colspan="2" align="center">
					<input type="submit" value="Register" name="register" onclick="return checkpwds();">
				</td>
			</tr>
			</table>
			</form>
		
		</div>
		<div id="login">
		<h5 align="center" style="font-style: oblique; color:red;">	For those who have already registered!</h5>
			<form action="login" method="post" autocomplete="off">
				<div id="errormsg">
					<% if(request.getParameter("id")!=null && request.getParameter("id").equals("lfailure")) {%>
						Invalid Credentials, Please try again!				
					<% } %>
				</div>
				<table id="logintable">
					<tr>
						<td>
							<label for="uname">
								Username :
							</label>
						</td>
						<td>
							<input type="text" name="username" required max="40" size="20" autofocus placeholder="Username or e-mail">
					</tr>
					<tr>
						<td>
							<label for="pass">
								Password :
							</label>
						</td>
						<td>
							<input type="password" name="pass" id="pass" required size="20" max="40" placeholder="&bull;&bull;&bull;&bull;&bull;&bull;&bull;&bull;">
						</td>
					</tr>
					<tr align="center">
						<td colspan="2">
							<input type="submit" value="Login"><a href="forgot" id="forpwd">Forgot Password?</a>
						</td>
					</tr>
				</table>
			
			</form>
		</div>
	</div>
	<script lang="text/javascript">
		function checkpwds(){
			var pwd=document.getElementById("password").value;
			var pwd1=document.getElementById("repassword").value;
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
	<%@ include file="footer.jsp" %>
	<!-- local address : <%= request.getLocalAddr() %><br>
	Port : <%=request.getLocalPort() %><br>
	remote address : <%= request.getRemoteAddr() %>
	Server info: <%= application.getServerInfo() %><br>  
Servlet version: <%= application.getMajorVersion() %>.<%= application.getMinorVersion() %><br> 
${application.getMajorVersion } -->
</body>
</html>


<input type="hidden" name="emailidpwd" value="noreply.filteredwall@gmail.com/filter1208">


<%--
	E-Mail Delivery Systems
	http://newsberry.com/
	https://postmarkapp.com/
	https://sendgrid.com/
 --%>