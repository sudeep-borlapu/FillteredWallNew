package org.sudeep.fw.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import org.sudeep.fw.daofactory.DaoFactory;
import org.sudeep.fw.utils.SqlUtils;

public class AcceptAddCanelDiscard_FriendRequest {
	
	public String addFriend(int from, int to) throws SQLException { //from is loggedinuser and to is another user
		String status = "";
		Connection con = DaoFactory.getConnection();
		PreparedStatement pst = con.prepareStatement(SqlUtils.SEND_FRIEND_REQUEST);
		pst.setInt(1, from);
		pst.setInt(2, to);
		int x = pst.executeUpdate();
		if(x>0) {
			status = "sent";
		}
		else {
			status = "notsent";
		}
		return status;
	}
	
	public boolean cancelFriendRequest(int sentfrom, int sentto) throws SQLException {//sentfrom parameter is loggedin user and the sentto is the other user
		boolean status = false;
		Connection con = DaoFactory.getConnection();
		PreparedStatement pst = con.prepareStatement(SqlUtils.CANCEL_FRIEND_REQUEST);
		pst.setInt(1, sentto);
		pst.setInt(2, sentfrom);
		int x = pst.executeUpdate();
		if(x>0) {
			status = true;
		}
		else {
			status = false;
		}
		return status;
	}
	
	public boolean discardFriendRequest(int sentto, int sentfrom) throws SQLException {//sentto is loggedinuser and the sentfrom is the requsted user
		boolean status = false;
		Connection con = DaoFactory.getConnection();
		PreparedStatement pst = con.prepareStatement(SqlUtils.DISCARD_FRIEND_REQUEST);
		pst.setInt(1, sentto);
		pst.setInt(2, sentfrom);
		int x = pst.executeUpdate();
		if(x>0) {
			status = true;
		}
		else {
			status = false;
		}
		return status;
	}
	
	public boolean acceptFriendRequest(int sentto, int sentfrom) throws SQLException { //sentto is loggedinuser and sentfrom is requested user
		boolean status = false;
		Connection con = DaoFactory.getConnection();
		PreparedStatement pst = con.prepareStatement(SqlUtils.ACCEPT_FRIEND_REQUEST);
		pst.setInt(1, sentto);
		pst.setInt(2, sentfrom);
		int x = pst.executeUpdate();
		if(x>0) {
			status = true;
		}
		else {
			status = false;
		}
		return status;
	}
	
	public boolean unfriendFriendRequest(int unfriendid, int loggedinid) throws SQLException{
		boolean status = false;
		Connection con = DaoFactory.getConnection();
		PreparedStatement pst = con.prepareStatement(SqlUtils.UNFRIEND_FRIEND_REQUEST);
		pst.setInt(1, unfriendid);
		pst.setInt(2, loggedinid);
		pst.setInt(3, loggedinid);
		pst.setInt(4, unfriendid);
		int x = pst.executeUpdate();
		if(x>0) {
			status = true;
		}
		else {
			status = false;
		}
		return status;
	}

}
