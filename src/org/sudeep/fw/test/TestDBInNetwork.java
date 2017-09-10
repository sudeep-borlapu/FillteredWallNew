package org.sudeep.fw.test;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class TestDBInNetwork {
	public void getData() {
	try {
	Class.forName("com.mysql.jdbc.Driver");
	System.out.println("driver loaded");
	Connection con = DriverManager.getConnection("jdbc:mysql://192.168.0.129:3306/vmsdev","root","root");
	System.out.println("got connection");
	PreparedStatement pst= con.prepareStatement("select * From login");
	
	ResultSet rs = pst.executeQuery();
	while(rs.next()) {
		System.out.println(rs.getString(1)+" "+rs.getString(2));
	}
	}catch(Exception e) {
		e.printStackTrace();
		
	}
	}
}
