package org.sudeep.fw.servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.sudeep.fw.dao.LikeDao;

public class LikeServlet extends HttpServlet{
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException,IOException{
		LikeDao dao = new LikeDao();
		HttpSession session = request.getSession();
		if(session.getAttribute("loggedInUser")!=null)
			dao.likePost(Integer.parseInt(request.getParameter("postid")), Integer.parseInt(session.getAttribute("loggedInUser").toString()));
		RequestDispatcher rd = request.getRequestDispatcher("jsp/ajaxlikeresponse.jsp?pid="+Integer.parseInt(request.getParameter("postid")));
		rd.forward(request, response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		doGet(request, response);
	}

}
