package org.sudeep.fw.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.sudeep.fw.daofactory.DaoFactory;
import org.sudeep.fw.dto.PostsDto;
import org.sudeep.fw.utils.SqlUtils;

public class PostsDao {
	Connection con = null;
	PreparedStatement pst = null;
	ResultSet rs = null;
	public void addPost() throws SQLException {
		
		String status = null;
		PostsDto dto = new PostsDto();
		con = DaoFactory.getConnection();
		pst = con.prepareStatement(SqlUtils.ADD_POST);
		pst.setString(1, dto.getBody());
		pst.setString(2, dto.getId());
		pst.setString(3, dto.getPostdate());
		pst.setString(4, dto.getPosttime());
		int x = pst.executeUpdate();
		if(x>0) {
			status = "success";
		}
		else {
			status = "failure";
		}
	}
	
	public String getPostsQuery(int id) throws SQLException{
		String queryForFriends = "select * from posts where id in (";
		StringBuilder query = new StringBuilder(queryForFriends);
		con = DaoFactory.getConnection();
		pst = con.prepareStatement("select sentto,sentfrom from friends where (sentto=? or sentfrom=? and status='accept')");
		pst.setInt(1, id);
		pst.setInt(2,id);
		ResultSet rs = pst.executeQuery();
		int count = 0;
		while(rs.next()) {
			if(rs.getInt("sentto")==id) {
			if(count==0)	
			query.append(id+","+rs.getInt("sentfrom")+",");
			else
				query.append(rs.getInt("sentfrom")+",");
			}
			else if(rs.getInt("sentfrom")==id) {
				if(count==0)
					query.append(id+","+rs.getInt("sentto")+",");
				else
					query.append(rs.getInt("sentto")+",");
			}
			count++;
		}
		int ind=0;
		if(count>=1) {
			ind = query.lastIndexOf(",");
			query.deleteCharAt(ind);
		}
		if(count==0) {
			query.append(id);
		}
		query.append(") order by time desc");
		//pst = con.prepareStatement("select id from posts where id in () ");
		
		return query.toString();
	}
}
