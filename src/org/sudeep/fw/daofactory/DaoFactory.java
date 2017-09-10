package org.sudeep.fw.daofactory;

import java.sql.Connection;
import java.sql.DriverManager;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.sudeep.fw.servlet.LoginServlet;

public class DaoFactory {
	private static final Logger logger = LoggerFactory.getLogger(DaoFactory.class);
	public static Connection getConnection() {
		
		
		logger.info("in DaoFactory getConnection");
		Connection con=null;
		try {
			Class.forName("org.mariadb.jdbc.Driver");
			con=DriverManager.getConnection("jdbc:mariadb://localhost:3306/fwdev","root","sriker51");
		
			if(con != null)
				logger.info("Connected to DB");
			else
				logger.error("Connection to database failed. Please check whether the database is up.");
		}catch(Exception e) {
			e.printStackTrace();
		}
		return con;
	}
}
