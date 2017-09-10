package org.sudeep.fw.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.sudeep.fw.daofactory.DaoFactory;
import org.sudeep.fw.dto.LoginDto;
import org.sudeep.fw.utils.SqlUtils;

public class LoginDao {
	
	String status=null;
	
	private static final Logger logger = LoggerFactory.getLogger(LoginDao.class);
	
	public String loginValidate(LoginDto dto) throws Exception{
		Connection con = DaoFactory.getConnection();
		
		if(dto.getUname().contains("@")) {
			//user logged in using email address
			PreparedStatement pst = con.prepareStatement(SqlUtils.LOGIN_EMAIL);
			pst.setString(1, dto.getUname());
			pst.setString(2, dto.getPwd());
			ResultSet rs = pst.executeQuery();
			if(rs.next()) {
				status = rs.getString(1);
			}
			else{
				status = "lfailure";
			}
			
		}
		//if uname is not an email
		else {
			//it may be a phone number or a username
			logger.info("User entered number or username");
			//check for phone number if not a phone no then its  a username
			int res = checkForNumber(dto.getUname());
			logger.info("cheked for number");
			//if res is 0 then it is a username if 1 then it's a phone number 
			if(res==1) {
				logger.info("user logged in using username");
				PreparedStatement pst = con.prepareStatement(SqlUtils.LOGIN_USERNAME);
				pst.setString(1, dto.getUname());
				pst.setString(2, dto.getPwd());
				ResultSet rs = pst.executeQuery();
				if(rs.next()) {
					status = rs.getString(1);
				}
				else{
					status = "lfailure";
				}
					
			}
			else {
				logger.info("user logged in using phone number");
				PreparedStatement pst = con.prepareStatement(SqlUtils.LOGIN_PHONE);
				pst.setString(1, dto.getUname());
				pst.setString(2, dto.getPwd());
				ResultSet rs = pst.executeQuery();
				if(rs.next()) {
					status = rs.getString(1);
				}
				else{
					status = "lfailure";
				}
				
			}
		}logger.info("returning status!");
		return status;
	}
	
	static int checkForNumber(String uname) {
		int flag1=0;
		char[] c = uname.toCharArray();
		for(int i=0;i<c.length;i++) {
			if(Character.isDigit(c[i])) {
				flag1 = 0;
				if(flag1!=0)break;
			}
			else flag1 = 1;
		}
		return flag1;
	}
}
