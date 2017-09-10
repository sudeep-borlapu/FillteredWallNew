package org.sudeep.fw.test;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Scanner;

import org.sudeep.fw.dao.FriendSuggestion;
import org.sudeep.fw.dto.PersonDto;

public class TestForSuggestFriends {
	public static void main(String args[]) throws SQLException {
		FriendSuggestion fs = new FriendSuggestion();
		Scanner s = new Scanner(System.in);
		System.out.println("Enter the id :");
		int loggedInid = s.nextInt();
		fs.suggestFriendsTo(loggedInid);
		//String q=fs.createQueryForFriendsList(loggedInid);
		//System.out.println("Result in main :"+q);
		
	}
}