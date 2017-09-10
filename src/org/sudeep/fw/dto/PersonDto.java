package org.sudeep.fw.dto;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import org.sudeep.fw.daofactory.DaoFactory;

public class PersonDto{
	
	private int pid;
	private String firstname;
	private String lastname;
	private String email;
	private String gender;
	private String dob;
	private String password;
	private String repassword;
		
	public int getPid() {
		return pid;
	}
	public void setPid(int id) {
		this.pid = id;
	}
	public String getFirstname() {
		return firstname;
	}
	public void setFirstname(String firstname) {
		this.firstname = firstname;
	}
	public String getLastname() {
		return lastname;
	}
	public void setLastname(String lastname) {
		this.lastname = lastname;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getDob() {
		return dob;
	}
	public void setDob(String dob) {
		this.dob = dob;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getRepassword() {
		return repassword;
	}
	public void setRepassword(String repassword) {
		this.repassword = repassword;
	}
	
	public void getPersonDetails(String id) {
		Connection con = DaoFactory.getConnection();
		try {
		PreparedStatement pst = con.prepareStatement("select * from person where id=?");
		pst.setInt(1, Integer.parseInt(id));
		ResultSet rs = pst.executeQuery();
		if(rs.next()) {
			setFirstname(rs.getString(3));
			lastname = rs.getString("lname");
			email = rs.getString("email");
			//phone = rs.getString("phone");
			password = rs.getString("password");
			dob = rs.getString("dob");
			pid = Integer.parseInt(rs.getString("id"));
		}
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
}
