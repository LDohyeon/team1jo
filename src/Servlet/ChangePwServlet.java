package Servlet;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

import DAO.MemberDAO;
import DTO.MemberDTO;

import javax.servlet.annotation.*;

@WebServlet("/changePw.do")
public class ChangePwServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		RequestDispatcher dispatcher= request.getRequestDispatcher("changePw.jsp");
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("utf-8");
		String pw=request.getParameter("pw1");
		
		HttpSession session = request.getSession();
		
		String id = (String)session.getAttribute("loginUserId");
		
		
		MemberDAO mDAO=MemberDAO.getInstance();
		mDAO.MemberPwUpdate(pw, id);
		
		response.sendRedirect("login.do");
		
		
	}

}











