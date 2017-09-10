package org.sudeep.fw.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.sudeep.fw.daofactory.DaoFactory;
import org.sudeep.fw.utils.SqlUtils;

public class UsernameDao {
	
	public String checkUsernameAvailability(String username) throws SQLException {
		String status = "NIL";
		Connection con = DaoFactory.getConnection();
		PreparedStatement pst = con.prepareStatement(SqlUtils.CHECK_UNAME_AVAILABILITY);
		pst.setString(1, username);
		ResultSet rs = pst.executeQuery();
		System.out.println("The ResultSet size is :"+rs.getFetchSize());
		while(rs.next()) {
			status = "exist";
		}
		return status;
	}
	
	public String saveUsername(String username, int userid) throws SQLException {
		String status = "";
		Connection con = DaoFactory.getConnection();
		PreparedStatement pst = con.prepareStatement(SqlUtils.SAVE_USERNAME);
		pst.setString(1, username);
		pst.setInt(2, userid);
		int x = pst.executeUpdate();
		if(x > 0) {
			status = "updated";
		}
		else {
			status = "notupdated";
		}
		return status;
	}

}
