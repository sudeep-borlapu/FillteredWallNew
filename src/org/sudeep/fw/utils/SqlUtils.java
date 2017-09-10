package org.sudeep.fw.utils;

public class SqlUtils {
	
	public static String REGISTER = "insert into person(fname,lname,email,dob,gender,password) values(?,?,?,?,?,?)";
	public static String LOGIN_EMAIL = "select id from person where email=? and password=?";
	public static String LOGIN_PHONE = "select id from person where phone=? and password=?";
	public static String LOGIN_USERNAME = "select id from person where uname=? and password=?";
	public static String FORGOT_PWD = "select id from person where email=?";
	public static String CHECK_DUPLICATE_EMAIL = "select email from person where email=?";
	public static String GET_PERSON_DETAILS = "select * from person where email=?";
	public static String ADD_POST = "insert into posts(body,id,postdate,posttime) values(?,?,?,?)";
	public static String ADD_STATUS_UPDATE = "insert into posts(body,id,onwall,time) values(?,?,?,now())";
	public static String GET_POSTS = "select * from posts where id=?";
	public static String GET_POST_DETAILS = "select * from persons,posts where posts.id=? and person.id=?";
	public static String CHANGE_PASSWORD = "update person set password=? where id=? and password=?";
	public static String SEND_FRIEND_REQUEST = "insert ignore into friends(sentfrom,sentto,status) values(?,?,'sent')";
	//public static String SUGGEST_FRIENDS = "select id,fname,lname from person where id!=? and id not in (select id from friends where friendwith=? or id=?)";
	public static String CANCEL_FRIEND_REQUEST = "delete from friends where sentfrom=? and sentto=?";
	public static String DISCARD_FRIEND_REQUEST = "delete from friends where sentto=? and sentfrom=?";
	public static String ACCEPT_FRIEND_REQUEST = "update friends set status='accept' where sentto=? and sentfrom=?";
	public static String UNFRIEND_FRIEND_REQUEST = "delete from friends where (sentto=? and sentfrom=?) or (sentto=? and sentfrom=?)";
	public static String LIKE_POST = "insert into likes(pid,id) values(?,?)";
	
	public static String POST_ON_OTHER_WALL = "insert into posts(id,onwall,body,time) values(?,?,?,now())";
	public static String CHECK_UNAME_AVAILABILITY = "select uname from person where uname like ?";
	public static String SAVE_USERNAME = "update person set uname=? where id=?";
	
	public static String EDUCATION_HS_DETAILS = "insert ignore into edu_details(id,edu_inst_name,edu_from,edu_to) values(?,?,date(?),date(?))";
	public static String EDUCATION_UG_DETAILS = "insert ignore into edu_details(id,edu_inst_name,edu_from,edu_to,course_interest) values(?,?,date(?),date(?),?)";
	public static String EDUCATION_GRADUATION_DETAILS = "insert ignore into edu_details(id,edu_inst_name,edu_from,edu_to,course_interest) values(?,?,date(?),date(?),?)";
	public static String EDUCATION_PG_DETAILS = "insert ignore into edu_details(id,edu_inst_name,edu_from,edu_to,course_interest) values(?,?,date(?),date(?),?)";

}
