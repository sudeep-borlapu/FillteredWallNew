package org.sudeep.fw.test;

import java.sql.SQLException;
import java.util.Scanner;

import org.sudeep.fw.dao.HelperDao;
import org.sudeep.fw.dao.PostsDao;

public class TestMainForMessagesFriendList {
	public static void main(String args[]) throws SQLException {
		PostsDao dao = new PostsDao();
		System.out.println(dao.getPostsQuery(14));
//		dao.getPosts(14);
	}
}
