package org.sudeep.fw.servlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.sudeep.fw.dao.PostsDao;
import org.sudeep.fw.dto.PostsDto;

public class HomeServlet extends HttpServlet{
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		if(session.getAttribute("loggedInUser")!=null) {
			//PostsDao dao = new PostsDao();
			//ArrayList<PostsDto>[] pdto = dao.getPosts(Integer.parseInt(session.getAttribute("loggedInUser").toString()));
			RequestDispatcher rd = request.getRequestDispatcher("jsp/home.jsp");
			//request.setAttribute("posts", pdto);
			rd.forward(request, response);
			
			//response.sendRedirect(request.getContextPath()+"/home");
		}
		else if(session.getAttribute("loggedInUser")==null) {
			RequestDispatcher rd = request.getRequestDispatcher("jsp/index.jsp");
			rd.forward(request, response);
			//response.sendRedirect(request.getContextPath()+"/login");
			
		}
	}
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException,IOException{
		doPost(request,response);
	}

}