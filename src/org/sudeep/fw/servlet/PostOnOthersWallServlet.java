package org.sudeep.fw.servlet;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.sudeep.fw.dao.PostOnOthersWallDao;

public class PostOnOthersWallServlet extends HttpServlet{
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException,IOException{
		HttpSession session = request.getSession();
		if(session.getAttribute("loggedInUser")!=null) {
			String post=request.getParameter("post_on_wall");
			String profileId = request.getParameter("profileid");
			String loggedInUser = request.getParameter("loggedinuserid");
			String status = null;
			PostOnOthersWallDao dao = new PostOnOthersWallDao();
			try {
				status = dao.addPostOnOthersWall(Integer.parseInt(loggedInUser), Integer.parseInt(profileId), post);
				if(status.equals("saved")) {
					response.sendRedirect(request.getContextPath()+"/profile?id="+profileId+"&responseid=2");
				}
				else {
					response.sendRedirect(request.getContextPath()+"/profile?id="+profileId+"responseid=1");
				}
			} catch (NumberFormatException | SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}
		else {
			response.sendRedirect("/index");
		}
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException,IOException{
		doGet(request,response);
	}
}
