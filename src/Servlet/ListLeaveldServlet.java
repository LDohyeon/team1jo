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
		
		request.setCharacterEncoding("utf-8");
		String id=request.getParameter("getId");
		String startPage=request.getParameter("startPage");
		
		MemberDAO mDAO=MemberDAO.getInstance();
		mDAO.MemberDelete(id);
		
		response.sendRedirect("memberList.do?startPage="+startPage);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}
}







