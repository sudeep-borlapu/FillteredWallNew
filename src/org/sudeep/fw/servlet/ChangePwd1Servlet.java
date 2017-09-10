package org.sudeep.fw.servlet;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.sudeep.fw.dao.ChangePwd1Dao;
import org.sudeep.fw.dto.ChangePwd1Dto;

public class ChangePwd1Servlet extends HttpServlet{
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException{
		HttpSession session = request.getSession();
		String userid=null;
		if(session!=null)
			userid = session.getAttribute("loggedInUser").toString();
		else {
			response.sendRedirect(request.getContextPath()+"/home");
			return;
		}
		ChangePwd1Dto dto = new ChangePwd1Dto();
		ChangePwd1Dao dao = new ChangePwd1Dao();
		dto.setCurentPassword(request.getParameter("cpwd").trim());
		dto.setNewPassword(request.getParameter("npwd").trim());
		dto.setConfirmPassword(request.getParameter("cnpwd").trim());
		dto.setId(userid);
		try {
		
			boolean res = false;
			res= dao.changePwd(dto);
			if(res) {
				response.sendRedirect(request.getContextPath()+"/changepwd?id=changed");
			}
			else{
				System.out.println("in servlet with result :"+res);
				response.sendRedirect(request.getContextPath()+"/changepwd?id=notchanged");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
}
