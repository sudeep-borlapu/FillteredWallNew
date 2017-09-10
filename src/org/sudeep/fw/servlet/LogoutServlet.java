package org.sudeep.fw.servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LogoutServlet extends HttpServlet{
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException,IOException{
		HttpSession session = request.getSession(false);
		RequestDispatcher rd;
		if(session!=null) {
			session.invalidate();
			rd= request.getRequestDispatcher("jsp/index.jsp?id=logout");
			rd.forward(request, response);
		}
		else {
			rd=request.getRequestDispatcher("jsp/index.jsp");
			rd.forward(request, response);
		}
		
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) {
		
	}
}
