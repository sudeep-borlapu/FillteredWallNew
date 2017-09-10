package org.sudeep.fw.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import org.sudeep.fw.daofactory.DaoFactory;
import org.sudeep.fw.utils.SqlUtils;

public class EducationDetailsDao {
	

	boolean status = false;
	Connection con = null;
	PreparedStatement pst = null;
	public boolean saveHighSchoolDetails(long id, String school_name, String from, String to) throws SQLException {
		con = DaoFactory.getConnection();
		pst = con.prepareStatement(SqlUtils.EDUCATION_HS_DETAILS);
		pst.setLong(1, id);
		pst.setString(2, school_name);
		pst.setString(3, from);
		pst.setString(4, to);
		int x = pst.executeUpdate();
		if(x>0) {
			status = true;
		}
		else {
			status = false;
		}
		return status;
	}
	
	public boolean saveUnderGraduationDetails(long id, String uni_name, String from, String to,String course_interest) throws SQLException {
		con = DaoFactory.getConnection();
		pst = con.prepareStatement(SqlUtils.EDUCATION_UG_DETAILS);
		pst.setLong(1,id);
		pst.setString(2, uni_name);
		pst.setString(3, from);
		pst.setString(4, to);
		pst.setString(5, course_interest);
		int x = pst.executeUpdate();
		if(x>0) {
			status = true;
		}
		else {
			status = false;
		}
		return status;
	}
	
	public boolean saveGraduationDetails(long id, String uni_name, String from, String to,String course_interest) throws SQLException {
		con = DaoFactory.getConnection();
		pst = con.prepareStatement(SqlUtils.EDUCATION_GRADUATION_DETAILS);
		pst.setLong(1,id);
		pst.setString(2, uni_name);
		pst.setString(3, from);
		pst.setString(4, to);
		pst.setString(5, course_interest);
		int x = pst.executeUpdate();
		if(x>0) {
			status = true;
		}
		else {
			status = false;
		}
		return status;
	}
	
	public boolean savePostGraduationDetails(long id, String uni_name, String from, String to,String course_interest) throws SQLException {
		con = DaoFactory.getConnection();
		pst = con.prepareStatement(SqlUtils.EDUCATION_PG_DETAILS);
		pst.setLong(1,id);
		pst.setString(2, uni_name);
		pst.setString(3, from);
		pst.setString(4, to);
		pst.setString(5, course_interest);
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
