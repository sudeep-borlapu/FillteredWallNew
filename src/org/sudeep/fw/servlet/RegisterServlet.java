package org.sudeep.fw.servlet;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.sudeep.fw.dao.RegisterDao;
import org.sudeep.fw.dto.RegisterDto;

import com.sendgrid.SendGridException;
import com.sendgrid.SendGrid.Email;

/**
 * Servlet implementation class RegisterServlet
 */
@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegisterServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String status = null;
		RegisterDao dao = new RegisterDao();
		RegisterDto dto = new RegisterDto();
		RequestDispatcher rd=null;
		boolean emailExists=false;
		//validations
		try {//check wheter an email already exists in db
			emailExists = dao.checkDuplicateEmail(request.getParameter("email").trim());
			if(emailExists == true) {
				//rd = request.getRequestDispatcher("jsp/index.jsp?id=emailexists");
				//rd.forward(request, response);
				response.sendRedirect(request.getContextPath()+"jsp/index.jsp?id=emailexists");
			}
			else if(emailExists==false) {
				if(request.getParameter("firstname")!=null && !request.getParameter("firstname").equals(""))
					dto.setFirstname(request.getParameter("firstname").trim());
				
				else {
					rd = request.getRequestDispatcher("jsp/index.jsp?id=fname");
					rd.forward(request, response);
				}
				System.out.println("checked fname");
				
				
				if(request.getParameter("lastname")!=null && !request.getParameter("lastname").equals(""))
					dto.setLastname(request.getParameter("lastname").trim());
				else {
					rd = request.getRequestDispatcher("jsp/index.jsp?id=lname");
					rd.forward(request, response);
				}
				
				
				if(request.getParameter("gender")!=null && !request.getParameter("gender").equals(""))
					dto.setGender(request.getParameter("gender").trim());
				else {
					rd = request.getRequestDispatcher("jsp/index.jsp?id=gender");
					rd.forward(request, response);
				}
				System.out.println(dto.getGender());
				
				
				if(request.getParameter("email")!=null && !request.getParameter("email").equals(""))
					dto.setEmail(request.getParameter("email").trim());
				else {
					rd = request.getRequestDispatcher("jsp/index.jsp?id=email");
					rd.forward(request, response);
				}
				
				
				if(request.getParameter("dob")!=null && !request.getParameter("dob").equals(""))
					dto.setDob(request.getParameter("dob").trim());
				else {
					rd = request.getRequestDispatcher("jsp/index.jsp?id=dob");
					rd.forward(request, response);
				}
				
				
				if(request.getParameter("password")!=null && !request.getParameter("password").equals(""))
					if(request.getParameter("password").equals(request.getParameter("repassword"))) 
						dto.setPassword(request.getParameter("password").trim());
				else {
					rd = request.getRequestDispatcher("jsp/index.jsp?id=password");
					rd.forward(request, response);
				}
				dto.setRepassword(request.getParameter("repassword"));
				
			}
		} catch (SQLException e1) {	e1.printStackTrace();}
		
		
		try {
			//if(dto.getFirstname()!=null || dto.getLastname()!=null || dto.getGender()!=null)
			if(!emailExists)
				status = dao.newRegister(dto);
			if(status.equals("success")) {
				//rd = request.getRequestDispatcher("jsp/index.jsp?id=success");
				//rd.forward(request, response);
				response.sendRedirect(request.getContextPath()+"jsp/index.jsp?id=success");
			}else if(status.equals("failure")) {
				rd = request.getRequestDispatcher("jsp/index.jsp?id=failure");
			}else if(status.equals("mismatch")) {
				rd = request.getRequestDispatcher("jsp/index.jsp?id=mismatch");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SendGridException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request,response);
	}

}
