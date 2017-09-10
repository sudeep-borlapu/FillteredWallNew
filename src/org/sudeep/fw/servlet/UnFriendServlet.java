package org.sudeep.fw.servlet;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.sudeep.fw.dao.AcceptAddCanelDiscard_FriendRequest;

public class UnFriendServlet extends HttpServlet{
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException,IOException{
		AcceptAddCanelDiscard_FriendRequest dao = new AcceptAddCanelDiscard_FriendRequest();
		HttpSession session = request.getSession();
		if(session.getAttribute("loggedInUser")!=null)
			try {
				if(dao.unfriendFriendRequest(Integer.parseInt(request.getParameter("fid").trim()), Integer.parseInt(session.getAttribute("loggedInUser").toString().trim()))) {
					response.sendRedirect(request.getContextPath()+"/friends?unfriend=success");
				}else {
					response.sendRedirect(request.getContextPath()+"/friends?unfriend=fail");
				}
			} catch (NumberFormatException | SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	}

}
