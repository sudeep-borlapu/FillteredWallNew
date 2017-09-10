package org.sudeep.fw.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import org.sudeep.fw.daofactory.DaoFactory;

public class AddMsgDao {
	
	public String addMsg(int msgto, int msgfrom, int conv_id, String msg) throws SQLException {
		
		String status = null;
		Connection con = DaoFactory.getConnection();
		PreparedStatement pst = con.prepareStatement("insert into messages(msgto,msgfrom,conv_id,message) values(?,?,?,?)");
		pst.setInt(1, msgto);
		pst.setInt(2, msgfrom);
		pst.setInt(3, conv_id);
		pst.setString(4, msg);
		
		int x = pst.executeUpdate();
		if(x>0) {
			status = "added";
		}
		else {
			status = "fail";
		}
		return status;
	}

}
