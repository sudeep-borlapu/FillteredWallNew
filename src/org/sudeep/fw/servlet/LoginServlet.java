package org.sudeep.fw.servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.sudeep.fw.dao.LoginDao;
import org.sudeep.fw.dto.LoginDto;

public class LoginServlet extends HttpServlet{
	RequestDispatcher rd;
	private static final Logger logger = LoggerFactory.getLogger(LoginServlet.class);
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException,IOException{
		HttpSession session = request.getSession();
	
		LoginDto dto = new LoginDto();
		dto.setUname(request.getParameter("username").trim());
		dto.setPwd(request.getParameter("pass").trim());
		LoginDao dao = new LoginDao();
		try {
			String status = dao.loginValidate(dto);
			logger.info("returned to servlet with status :"+status);
			if(status.equals("lfailure")) {
				logger.info("Login failed :");
				rd = request.getRequestDispatcher("jsp/index.jsp?id=lfailure");
				rd.forward(request, response);
			}
			else {
				logger.info("Login success");
				//rd=request.getRequestDispatcher("jsp/home.jsp");
				session.setAttribute("loggedInUser", status);
				//rd.forward(request, response);
				response.sendRedirect(request.getContextPath()+"/home");
			}
		
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException,IOException{
		doPost(request,response);
	}
}
