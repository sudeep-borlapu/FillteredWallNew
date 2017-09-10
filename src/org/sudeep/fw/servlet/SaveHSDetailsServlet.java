package org.sudeep.fw.servlet;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.sudeep.fw.dao.EducationDetailsDao;

public class SaveHSDetailsServlet extends HttpServlet{
	
	boolean result = false;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException,IOException{
		HttpSession session = request.getSession();
		if(session.getAttribute("loggedInUser")!=null) {
			EducationDetailsDao dao = new EducationDetailsDao();
			try {
				result = dao.saveHighSchoolDetails(Long.parseLong(session.getAttribute("loggedInUser").toString()), request.getParameter("sname"), request.getParameter("from"),request.getParameter("to"));
			} catch (NumberFormatException | SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

}
