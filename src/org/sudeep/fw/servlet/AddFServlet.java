package org.sudeep.fw.servlet;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.sudeep.fw.dao.AcceptAddCanelDiscard_FriendRequest;

public class AddFServlet extends HttpServlet{
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
		HttpSession session = request.getSession();
		String status = null;
		if(session!=null) {
			AcceptAddCanelDiscard_FriendRequest dao = new AcceptAddCanelDiscard_FriendRequest();
			try {
				status = dao.addFriend(Integer.parseInt(session.getAttribute("loggedInUser").toString().trim()),Integer.parseInt(request.getParameter("fid").trim()));
				if(status.equals("sent")) {
					response.sendRedirect(request.getContextPath()+"/friendsuggessions?fstatus="+status);
				}
				else {
					response.sendRedirect(request.getContentType()+"?friendsuggessions?fstatus="+status);
				}
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		else {
			response.sendRedirect(request.getContextPath()+"/home");
		}
	}

}
