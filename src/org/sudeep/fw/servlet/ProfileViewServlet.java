package org.sudeep.fw.servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ProfileViewServlet extends HttpServlet{
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response)throws ServletException,IOException{
		HttpSession hs = request.getSession();
		if(hs.getAttribute("loggedInUser")!=null) {
			RequestDispatcher rd = request.getRequestDispatcher("jsp/profile_view.jsp?id="+request.getParameter("id"));
			rd.forward(request, response);
		}
		else {
			response.sendRedirect(request.getContextPath()+"/index");
		}
	}

}
