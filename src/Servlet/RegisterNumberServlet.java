package Servlet;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.util.*;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import DAO.MemberDAO;
import DTO.MemberDTO;

@WebServlet("/registerNumberServlet.do")
public class RegisterNumberServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {	
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		DateFormat simpleDate = new SimpleDateFormat("yyyy-MM-dd");
		String[] ymdDate = new String[3];
		String[] countDate = new String[3];
		
		ymdDate[0]=simpleDate.format(cal.getTime());
		cal.add(Calendar.DATE, -1);
		ymdDate[1]=simpleDate.format(cal.getTime());
		cal.add(Calendar.DATE, -1);
		ymdDate[2]=simpleDate.format(cal.getTime());
		
		MemberDAO mDAO= MemberDAO.getInstance();
		
		for(int i=0; i<ymdDate.length; i++) {
			countDate[i] = mDAO.registerMemberDateCount(ymdDate[i]);
		}
		
		request.setAttribute("ymdDate", ymdDate);
		request.setAttribute("countDate", countDate);
	
		RequestDispatcher dispatcher= request.getRequestDispatcher("registerNumber.jsp");
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
	}
}