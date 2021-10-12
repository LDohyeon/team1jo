package Servlet;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

import DAO.MemberDAO;

import javax.servlet.annotation.*;

@WebServlet("/leaveId.do")
public class LeaveIdServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		RequestDispatcher dispatcher= request.getRequestDispatcher("leaveId.jsp");
		dispatcher.forward(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("utf-8");
		
		HttpSession session= request.getSession();
		
		String id = (String)session.getAttribute("loginUserId");
		
		MemberDAO mDAO= MemberDAO.getInstance();
		mDAO.MemberDelete(id);
		
		response.sendRedirect("index.jsp");
		
		
		
	}

}







