package org.sudeep.fw.dto;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.sudeep.fw.daofactory.DaoFactory;
import org.sudeep.fw.utils.SqlUtils;

public class PostsDto {
		private String pid;
		private String body;
		private String id;
		private String postdate;
		private String posttime;
		
		public String getPid() {
			return pid;
		}
		public void setPid(String pid) {
			this.pid = pid;
		}
		public String getBody() {
			return body;
		}
		public void setBody(String body) {
			this.body = body;
		}
		public String getId() {
			return id;
		}
		public void setId(String id) {
			this.id = id;
		}
		public String getPostdate() {
			return postdate;
		}
		public void setPostdate(String postdate) {
			this.postdate = postdate;
		}
		public String getPosttime() {
			return posttime;
		}
		public void setPosttime(String posttime) {
			this.posttime = posttime;
		}
		public void getPost(String personid){
			System.out.println("In getPost before connection");
			Connection con = DaoFactory.getConnection();
			System.out.println("in getPost()");
			PreparedStatement pst;
			try {
				pst = con.prepareStatement(SqlUtils.GET_POSTS);
				
				pst.setInt(1,Integer.parseInt(personid));
				ResultSet rs = pst.executeQuery();
				while(rs.next()) {
					
					body = rs.getString("body");
					id = rs.getString("id");
					System.out.println("The body of the post "+id+" is :"+body);
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}
		
		public void getPostDetails(String postid) {
			Connection con = DaoFactory.getConnection();
			PreparedStatement pst;
			try {
				pst = con.prepareStatement(SqlUtils.GET_POST_DETAILS);
				pst.setInt(1, Integer.parseInt(postid));
				ResultSet rs = pst.executeQuery();
				while(rs.next()) {
					
				}
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
}
