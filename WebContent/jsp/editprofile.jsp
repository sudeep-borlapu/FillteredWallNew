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
		<script src="js/editprofile.js"></script>
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
	<div>
		<div id="change_pic" onclick="javascript:change_pic();">
			Change Profile Picture
		</div>
		<div id="upload_pic" hidden="hidden">
			<form id="form_upload_pic" name="form_upload_pic" enctype="multipart/form-data">
				<input type="file" name="pic">
				<%-- <button onclick="javascript:save_image(form_upload_pic.pic.value);">Save</button>--%>
				<input type="submit" value="Save">
			</form>
			<div id="loading" hidden="hidden">Uploading...</div>
			<div id="message"></div>
			<div id="image_preview" hidden="hidden"><img id="previewing" src="noimage.png" /></div>
		</div>
		
	</div><br><br>
	
	<div id="education_details">
		<div id="add_hsd" onclick="javascript:add_hsd();">
			Add High School Details
		</div>
		<div id="hsd_details" hidden="hidden">
		<div id="hsd_details1" hidden="hidden">
			<form name="form_hsd_details">
				School Name : <input type="text" id="school_name" name="school_name"><br>
				Year : from <input type="text" id="school_from" name="school_from"> to <input type="text" id="school_to" name="school_to">
				<input type="submit" value="Save">
			</form>
			<div id="hsd_details_saving" hidden="hidden">Saving...</div>
			<div id="hsd_output"></div>
		</div>
		</div><br><br>
		<div id="add_ud" onclick="javascript:add_ud();">
			Add Under Graduation Details
		</div>
		<div id="ud_details" hidden="hidden">
		<form name="form_ud_details">
			College Name : <input type="text" id="clg_name" name="clg_name"><br>
			Year : from <input type="text" id="clg_from" name="clg_from"> to <input type="text" id="clg_to" name="clg_to"><br>
			Course : <select name="clg_course">
						<option>--Select--</option>
						<option value="mpc">M.P.C</option>
						<option value="bpc">Bi.P.C</option>
						<option value="mec">M.E.C</option>
						<option value="hec">H.E.C</option>
						<option value="cec">C.E.C</option>
						<option value="diploma">Diploma</option>
					</select>
			<input type="submit" value="Save">
		</form>
			<div id="ud_details_saving" hidden="hidden">Saving...</div>
			<div id="ud_output"></div>
		</div>
	</div>
	
	<div id="">
	</div>
	
	<jsp:include page="footer.jsp"></jsp:include>
	<script src="js/editprofile.js"></script>
	</body>
</html>