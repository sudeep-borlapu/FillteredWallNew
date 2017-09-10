package org.sudeep.fw.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.sudeep.fw.daofactory.DaoFactory;
import org.sudeep.fw.dto.StatusUpdateDto;
import org.sudeep.fw.utils.SqlUtils;

public class StatusUpdateDao {
	
	private static final Logger logger = LoggerFactory.getLogger(StatusUpdateDao.class);
	
	public String addStatusUpdate(StatusUpdateDto dto){
		String status = "";
		try{
		Connection con = DaoFactory.getConnection();
		logger.info("Connection con = {}",con);
		PreparedStatement pst = con.prepareStatement(SqlUtils.ADD_STATUS_UPDATE);
		pst.setString(1,dto.getBody());
		pst.setString(2, dto.getId());
		pst.setString(3, dto.getId());
		int x = pst.executeUpdate();
		if(x>0) {
			status = "success";
		}
		else {
			status = "failure";
		}
		}
		catch(SQLException e){
			logger.error("SQLException : {}",e);
		}
		catch(Exception e){
			logger.error("Error : {}",e);
		}
		return status;
	}
}