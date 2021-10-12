package Servlet;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

import DAO.MemberDAO;

@WebServlet("/UserInfo.do")
public class UserInfoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//setting
		request.setCharacterEncoding("utf-8");
		MemberDAO mDAO=MemberDAO.getInstance();
		
		//values for changing
		String name=request.getParameter("name");
		String email=request.getParameter("email");
		String id=request.getParameter("id");
		
		////////////////////
		System.out.println(name);
		System.out.println(email);
		System.out.println(id);
		////////////////////
		
		//update user's info
		//mDAO.MemberUpdate(name,email,id);
		
		//change page
		//RequestDispatcher dispatcher = request.getRequestDispatcher("userInfo.jsp");
		//dispatcher.forward(request, response);
	}

}
