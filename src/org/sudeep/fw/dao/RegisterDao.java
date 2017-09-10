package org.sudeep.fw.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.sudeep.fw.daofactory.DaoFactory;
import org.sudeep.fw.dto.RegisterDto;
import org.sudeep.fw.email.RegistrationEmail;
import org.sudeep.fw.utils.SqlUtils;

import com.sendgrid.SendGridException;

public class RegisterDao {
	public String status=null;
	Connection con=null;
	public String newRegister(RegisterDto dto) throws SQLException, SendGridException {
		
		boolean result = RegisterDao.checkPwds(dto.getPassword(),dto.getRepassword());
		if(result) {
			con = DaoFactory.getConnection();
			System.out.println("Got Connection");
			PreparedStatement pst=con.prepareStatement(SqlUtils.REGISTER);
			pst.setString(1, dto.getFirstname());
			pst.setString(2,dto.getLastname());
			pst.setString(3, dto.getEmail());
			pst.setString(4, dto.getDob());
			pst.setString(5, dto.getGender());
			pst.setString(6, dto.getPassword());
			int x=pst.executeUpdate();
			if(x>0) {
				RegistrationEmail re = new RegistrationEmail();
				re.sendEmail(dto.getEmail());
				boolean emailstatus = true;
				if(emailstatus==true) {
					status = "success";
				}
				else if(emailstatus==false){
					status = "efail";
				}
			}
			else {
				status="failure";
			}
		}
		else {
			status="mismatch";
		}
		return status;
		
	}
	public static boolean checkPwds(String pwd, String pwd1) {
		boolean equal=false;
		if(pwd.equals(pwd1)){
			System.out.println("Checking pwds!");
			equal=true;
		}
		
		return equal;
	}
	public boolean checkDuplicateEmail(String email) throws SQLException{
		boolean result=false;
		Connection con = DaoFactory.getConnection();
		PreparedStatement pst=con.prepareStatement(SqlUtils.CHECK_DUPLICATE_EMAIL);
		pst.setString(1, email);
		ResultSet rs = pst.executeQuery();
		if(rs.next()) {
			result = true;
		}
		return result;
	}
}
