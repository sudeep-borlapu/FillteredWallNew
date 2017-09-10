package org.sudeep.fw.servlet;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.sudeep.fw.dao.LoginDao;
import org.sudeep.fw.dao.StatusUpdateDao;
import org.sudeep.fw.dto.StatusUpdateDto;

public class StatusUpdateServlet extends HttpServlet{
	
	private static final Logger logger = LoggerFactory.getLogger(StatusUpdateServlet.class);
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String statusUpdate = request.getParameter("status_update").trim();
		logger.info("Status Update: {}", statusUpdate);
		if(statusUpdate != null && statusUpdate!="") {
		StatusUpdateDao dao = new StatusUpdateDao();
		StatusUpdateDto dto = new StatusUpdateDto();
		
		dto.setBody(statusUpdate);
		dto.setId(request.getParameter("loggedinuserid").trim());
			try {
				String status = dao.addStatusUpdate(dto);
				logger.info("Status update status: {}"+status);
				if(status == "success") {
					/*RequestDispatcher rd = request.getRequestDispatcher("jsp/home.jsp");
					rd.forward(request, response);*/
					response.sendRedirect(request.getContextPath()+"/home");
				}
				else if(status == "failure") {
					RequestDispatcher rd = request.getRequestDispatcher("jsp/home.jsp?id=failure");
					rd.forward(request, response);
				}
			} catch (ServletException | IOException e) {
				logger.error("Exception : {}",e);
			}catch(Exception e){
				logger.error("Exception : {}",e);
			}
		}else {
		response.sendRedirect(request.getContextPath()+"/home");
		
	}
		
	}
}
