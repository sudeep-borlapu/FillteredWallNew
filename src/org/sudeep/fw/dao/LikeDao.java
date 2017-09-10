package org.sudeep.fw.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import org.sudeep.fw.daofactory.DaoFactory;
import org.sudeep.fw.utils.SqlUtils;

public class LikeDao {
	public void likePost(int postId, int personId) {
		try {
		Connection con = DaoFactory.getConnection();
		PreparedStatement pst = con.prepareStatement(SqlUtils.LIKE_POST);
		pst.setInt(1, postId);
		pst.setInt(2, personId);
		int x = pst.executeUpdate();
		if(x>0) {
			
		}
		}catch(Exception e) {
			
		}
	}
}
