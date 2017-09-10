package org.sudeep.fw.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.sudeep.fw.daofactory.DaoFactory;
import org.sudeep.fw.utils.SqlUtils;

public class PostOnOthersWallDao {
	
	public String addPostOnOthersWall(int from, int on, String body) throws SQLException{
		String status = null;
		Connection con = DaoFactory.getConnection();
		PreparedStatement pst = con.prepareStatement(SqlUtils.POST_ON_OTHER_WALL);
		pst.setInt(1,from);
		pst.setInt(2,on);
		pst.setString(3,body);
		int x = pst.executeUpdate();
		if(x>0) {
			status = "saved";
		}
		else {
			status = "fail";
		}
	return status;
	}
}
