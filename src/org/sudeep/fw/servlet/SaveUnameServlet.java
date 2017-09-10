package org.sudeep.fw.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.sudeep.fw.dao.UsernameDao;

public class SaveUnameServlet extends HttpServlet{
	
	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException,IOException {
		HttpSession session = req.getSession();
		if(session.getAttribute("loggedInUser")!=null) {
			UsernameDao dao = new UsernameDao();
			String status = "";
			try {
				status = dao.saveUsername(req.getParameter("uname"),Integer.parseInt(session.getAttribute("loggedInUser").toString()));
				if(status.equals("updated")) {
					PrintWriter out = res.getWriter();
					out.write("Username saved");
				}
				else {
					PrintWriter out = res.getWriter();
					out.write("Something went wrong please try again!");
				}
			} catch (NumberFormatException | SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}
	}

}
