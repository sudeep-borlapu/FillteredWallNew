package org.sudeep.fw.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.sudeep.fw.dao.EducationDetailsDao;

public class AjaxSaveHighSchoolDetails extends HttpServlet {
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		String school_name = request.getParameter("school_name");
		String school_from = request.getParameter("school_from");
		String school_to = request.getParameter("school_to");
		EducationDetailsDao dao = new EducationDetailsDao();
		HttpSession session = request.getSession();
		PrintWriter out = response.getWriter();
		boolean res = false;
		try {
			res = dao.saveHighSchoolDetails(Long.parseLong(session.getAttribute("loggedInUser").toString()), school_name, school_from, school_to);
			if(res == true) {
				out.write("High School Details Saved!");
			}
			else {
				out.write("Something went wrong... Please try again!");
			}
		} catch (NumberFormatException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
