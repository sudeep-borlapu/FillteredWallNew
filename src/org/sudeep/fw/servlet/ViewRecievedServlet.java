package org.sudeep.fw.servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ViewRecievedServlet extends HttpServlet{
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		
		HttpSession session = request.getSession();
		if(session.getAttribute("loggedInUser")!=null) {
			RequestDispatcher rd = request.getRequestDispatcher("jsp/viewrecievedrequests.jsp");
			rd.forward(request, response);
			//response.sendRedirect(request.getContextPath()+"jsp/recievedrequests.jsp");
		}
	}
}
