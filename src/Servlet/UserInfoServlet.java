package Servlet;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

import DAO.MemberDAO;

import javax.servlet.annotation.*;

@WebServlet("/userInfo.do")
public class UserInfoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		RequestDispatcher dispatcher= request.getRequestDispatcher("userInfo.jsp");
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("utf-8");
		
		String name= request.getParameter("name");
		String email=request.getParameter("email");
		HttpSession session = request.getSession();
		
		String id = (String)session.getAttribute("loginUserId");
		
		MemberDAO mDAO = MemberDAO.getInstance();
		mDAO.MemberUpdate(name, email, id);
		
		response.sendRedirect("login.do");
		
		
		
		
	}

}





