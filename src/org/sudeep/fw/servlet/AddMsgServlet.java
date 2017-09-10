package org.sudeep.fw.servlet;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.sudeep.fw.dao.AddMsgDao;

public class AddMsgServlet extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		
		HttpSession session = request.getSession();
		int sentto=Integer.parseInt(request.getParameter("sendto"));
		int sentfrom=Integer.parseInt(session.getAttribute("loggedInUser").toString());
		int conv_id = Integer.parseInt(request.getParameter("conv_id"));
		String msg = request.getParameter("msg");
		String status = null;
		AddMsgDao dao = new AddMsgDao();
		try {
			status = dao.addMsg(sentto, sentfrom, conv_id, msg);
			if(status.equals("added")) {
				RequestDispatcher rd = request.getRequestDispatcher("jsp/ajax_conversation.jsp");
				rd.forward(request, response);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		RequestDispatcher rd = request.getRequestDispatcher("jsp/addmsg.jsp");
	}
}
