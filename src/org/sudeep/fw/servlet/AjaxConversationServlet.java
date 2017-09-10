package org.sudeep.fw.servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class AjaxConversationServlet extends HttpServlet{
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		HttpSession session = request.getSession();
		if(session.getAttribute("loggedInUser")!=null) {
			session.setAttribute("conv_id", request.getParameter("convid"));
			RequestDispatcher rd = request.getRequestDispatcher("jsp/ajax_conversation.jsp");
			rd.forward(request, response);
			//response.sendRedirect(request.getContextPath()+"jsp/ajax_conversation.jsp");
			System.out.println("Redirecting to ajax_conversation.jsp");
		}
	}

}
