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

public class AjaxSaveUnderGraduationDetails extends HttpServlet{
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException,IOException{
		String clg_name = request.getParameter("clg_name");
		String clg_from = request.getParameter("clg_from");
		String clg_to = request.getParameter("clg_to");
		String clg_course = request.getParameter("clg_course");
		EducationDetailsDao dao = new EducationDetailsDao();
		HttpSession session = request.getSession();
		PrintWriter out = response.getWriter();
		boolean res = false;
		try {
			res = dao.saveUnderGraduationDetails(Long.parseLong(session.getAttribute("loggedInUser").toString()), clg_name, clg_from, clg_to, clg_course);
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
