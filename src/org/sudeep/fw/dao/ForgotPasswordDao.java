package org.sudeep.fw.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.sudeep.fw.daofactory.DaoFactory;
import org.sudeep.fw.dto.RegisterDto;
import org.sudeep.fw.utils.SqlUtils;


public class ForgotPasswordDao {
	RegisterDto dto = new RegisterDto();
	public RegisterDto getDetails(String email) throws SQLException {

		Connection con = DaoFactory.getConnection();
		PreparedStatement pst = con.prepareStatement(SqlUtils.GET_PERSON_DETAILS);
		pst.setString(1, email);
		ResultSet rs= pst.executeQuery();
		while(rs.next()) {
			dto.setEmail(rs.getString("email"));
			dto.setFirstname(rs.getString("fname"));
			dto.setLastname(rs.getString("lname"));
			dto.setPassword(rs.getString("password"));
		}
		return dto;
	}

}
