package org.sudeep.fw.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import org.sudeep.fw.daofactory.DaoFactory;
import org.sudeep.fw.dto.ChangePwd1Dto;
import org.sudeep.fw.utils.SqlUtils;

public class ChangePwd1Dao {
	boolean  status=false;
	public boolean changePwd(ChangePwd1Dto dto) throws SQLException {
		Connection con = DaoFactory.getConnection();
		PreparedStatement pst = con.prepareStatement(SqlUtils.CHANGE_PASSWORD);
		pst.setString(1, dto.getNewPassword());
		pst.setInt(2, Integer.parseInt(dto.getId()));
		pst.setString(3, dto.getCurentPassword());
		int x = pst.executeUpdate();
		if(x>0) {
			status=true;
		}
		else {
			status = false;
		}
		return status;
	}
}
