package Servlet;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

import DAO.MemberDAO;


@WebServlet("/ListLeaveldServlet.do")
public class ListLeaveldServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String getId = request.getParameter("getId");
		
		request.setAttribute("getId", getId);
		
		RequestDispatcher dispatcher= request.getRequestDispatcher("leaveId.jsp");
		dispatcher.forward(request, response);
		
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("utf-8");
		
		String getId = request.getParameter("getId");
		
		MemberDAO mDAO=MemberDAO.getInstance();
		mDAO.MemberDelete(getId);

		response.sendRedirect("memberList.do?startPage=1");
		
	}
}







