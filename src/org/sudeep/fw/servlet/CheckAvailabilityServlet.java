package org.sudeep.fw.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.Serializable;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.sudeep.fw.dao.UsernameDao;

public class CheckAvailabilityServlet extends HttpServlet{
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException,IOException{
		HttpSession session = request.getSession();
		UsernameDao dao = new UsernameDao();
		if(session.getAttribute("loggedInUser")!=null) {
			try {
				String status = dao.checkUsernameAvailability(request.getParameter("uname"));
				if(status.equals("exist")) {
					PrintWriter out = response.getWriter();
					out.write("<font color='red'>Username "+request.getParameter("uname")+" is already taken! Please try another one</font>");
				}
				else if(status.equals("NIL")){
					PrintWriter out = response.getWriter();
					out.write("<font color='white'>Username "+request.getParameter("uname")+" is available</font>");
				}
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

}
