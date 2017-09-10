package org.sudeep.fw.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.sudeep.fw.dao.AcceptAddCanelDiscard_FriendRequest;

public class CancelFriendServlet extends HttpServlet{
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException,IOException{
		AcceptAddCanelDiscard_FriendRequest dao = new AcceptAddCanelDiscard_FriendRequest();
		HttpSession session = request.getSession();
		boolean status=false;
		if(session.getAttribute("loggedInUser")!=null) {
			try{
				status = dao.cancelFriendRequest(Integer.parseInt(request.getParameter("fid").trim()), Integer.parseInt(session.getAttribute("loggedInUser").toString().trim()));
				if(status) {
					response.sendRedirect(request.getContextPath()+"/viewsent?status=success");
				}
				else {
					response.sendRedirect(request.getContextPath()+"/viewsent?status=fail");
				}
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
	}

}
