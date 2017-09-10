package org.sudeep.fw.servlet;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.sudeep.fw.dao.AcceptAddCanelDiscard_FriendRequest;

public class ConfirmFriendServlet extends HttpServlet{
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		AcceptAddCanelDiscard_FriendRequest dao = new AcceptAddCanelDiscard_FriendRequest();
		boolean status = false;
		HttpSession session = request.getSession();
		if(session.getAttribute("loggedInUser")!=null) {
			try {
				status = dao.acceptFriendRequest(Integer.parseInt(session.getAttribute("loggedInUser").toString().trim()), Integer.parseInt(request.getParameter("fid").trim()));
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			if(status) {
				session.setAttribute("confirmfriend","success");
				response.sendRedirect(request.getContextPath()+"/viewrecieved?acceptedid=success");
			}
		}
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		doGet(request, response);
	}

}
