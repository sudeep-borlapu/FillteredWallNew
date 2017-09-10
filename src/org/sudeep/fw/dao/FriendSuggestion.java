package org.sudeep.fw.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.sudeep.fw.daofactory.DaoFactory;
import org.sudeep.fw.dto.PersonDto;

public class FriendSuggestion {
	public ArrayList<PersonDto> aList = new ArrayList<PersonDto>();
	public ArrayList<PersonDto> suggestFriendsTo(int loggedInid) {
		try {
		Connection con = DaoFactory.getConnection();
		PreparedStatement pst=con.prepareStatement("select sentto,sentfrom from friends where sentto=? or sentfrom=?");
		pst.setInt(1, loggedInid);
		pst.setInt(2, loggedInid);
		ResultSet rs = pst.executeQuery();
		ArrayList<Integer> al = new ArrayList<Integer>();
		String s2="";
		int resultSetSize = 0;
		System.out.println("The result set size is :"+resultSetSize);
		//this while loop will run when rs is not null
		while(rs.next()) {
			if(rs.getInt(1)==loggedInid) {
				System.out.println("got "+rs.getInt(2));
				al.add(rs.getInt(2));
				s2=s2+","+rs.getInt(2);
			}
			else if(rs.getInt(2)==loggedInid) {
				System.out.println("got"+rs.getInt(1));
				al.add(rs.getInt(1));
				s2=s2+","+rs.getInt(2);
			}
			resultSetSize++;
		}
		if(resultSetSize==0) {
			pst=con.prepareStatement("select * from person where id!=?");
			pst.setInt(1,loggedInid);
			rs=pst.executeQuery();
			while(rs.next()) {
				PersonDto dto =new PersonDto();
				dto.setPid(rs.getInt("id"));
				dto.setFirstname(rs.getString("fname"));
				dto.setLastname(rs.getString("lname"));
				dto.setGender(rs.getString("gender"));
				System.out.println("adding id :"+rs.getInt("id"));
				aList.add(dto);
			}
		}
		if(resultSetSize!=0) {
			System.out.println("The array list size is  :"+al.size());
			
			String query = createQuery(al.size());
			System.out.println("Th query is :"+query);
			
			pst=con.prepareStatement(query);
			
			Object[] a1=al.toArray();
			pst.setInt(1, loggedInid);
			for(int i=1;i<=a1.length;i++) {
				pst.setInt(i+1, (int) a1[i-1]);
				System.out.println("setting :"+i+"th parameter");
			}
			rs=pst.executeQuery();
			while(rs.next()) {
				PersonDto dto =new PersonDto();
				dto.setPid(rs.getInt("id"));
				dto.setFirstname(rs.getString("fname"));
				dto.setLastname(rs.getString("lname"));
				dto.setGender(rs.getString("gender"));
				aList.add(dto);
			}
		}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return aList;
	}
	private static String createQuery(int length) {
		String query = "select id,fname,lname,gender from person where id!=? and id not in (";
		StringBuilder queryBuilder = new StringBuilder(query);
		for( int i = 0; i< length; i++){
			queryBuilder.append("?");
			if(i != length -1) queryBuilder.append(",");
		}
		queryBuilder.append(")");
		return queryBuilder.toString();
	}
	
}
