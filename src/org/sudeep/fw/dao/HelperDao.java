package org.sudeep.fw.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.sudeep.fw.daofactory.DaoFactory;

public class HelperDao {
	public String getFriendsList(int id) throws SQLException{
		String queryForFriends = "select * from messages where (msgfrom="+id+" and msgto in (";
		//StringBuilder query = new StringBuilder(queryForFriends);
		StringBuilder subQuery = new StringBuilder();
		Connection con = DaoFactory.getConnection();
		PreparedStatement pst = con.prepareStatement("select sentto,sentfrom from friends where (sentto=? or sentfrom=? and status='accept')");
		pst.setInt(1, id);
		pst.setInt(2,id);
		ResultSet rs = pst.executeQuery();
		int count = 0;
		while(rs.next()) {
			if(rs.getInt("sentto")==id) {
				if(count==0) {	
					//query.append(rs.getInt("sentfrom")+",");
					subQuery.append(rs.getInt("sentfrom")+",");
				}
				else {
					//query.append(rs.getInt("sentfrom")+",");
					subQuery.append(rs.getInt("sentfrom")+",");					
				}
			}
			else if(rs.getInt("sentfrom")==id) {
				if(count==0) {
					//query.append(rs.getInt("sentto")+",");
					subQuery.append(rs.getInt("sentto")+",");
				}
				else {
					//query.append(rs.getInt("sentto")+",");
					subQuery.append(rs.getInt("sentto")+",");
				}
			}
			count++;
		}
		int ind=0;
		if(count>=1) {
			//ind = query.lastIndexOf(",");
			//query.deleteCharAt(ind);
			ind = subQuery.lastIndexOf(",");
			subQuery.deleteCharAt(ind);
		}
		if(count==0) {
			//query.append(id);
			subQuery.append(id);
		}
		//query.append(")) or (msgto="+id+" and msgfrom in ("+subQuery+")) order by tym desc");
		//pst = con.prepareStatement("select id from posts where id in () ");
		//System.out.println("Query is :"+query);
		
		return subQuery.toString();
	}
	
	public void getResult(String query) throws SQLException{
		Connection con = DaoFactory.getConnection();
		PreparedStatement pst = con.prepareStatement(query);
		ResultSet rs =  pst.executeQuery();
		while(rs.next()) {
			
		}
		System.out.println();
	}

}
