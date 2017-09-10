package org.sudeep.fw.servlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.sudeep.fw.dao.FriendSuggestion;
import org.sudeep.fw.dto.PersonDto;

public class FriendSuggestionsServlet extends HttpServlet{
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		FriendSuggestion fs = new FriendSuggestion();
		HttpSession session = request.getSession();
		ArrayList<PersonDto> aList = new ArrayList<PersonDto>();
		if(session.getAttribute("loggedInUser")!=null){
			aList = fs.suggestFriendsTo(Integer.parseInt(session.getAttribute("loggedInUser").toString()));
		}
		request.setAttribute("sugg_friends", aList);
		RequestDispatcher rd = request.getRequestDispatcher("jsp/friendsuggessions.jsp");
		rd.forward(request, response);
	}

}
