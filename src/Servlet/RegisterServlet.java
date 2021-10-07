package Servlet;

import java.io.*;

import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

import DAO.MemberDAO;
import DTO.MemberDTO;

@WebServlet("/register.do")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		RequestDispatcher dispatcher= request.getRequestDispatcher("register.jsp");
		dispatcher.forward(request, response);
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("utf-8");
		String id =request.getParameter("id");
		String pw = request.getParameter("pw");
		String name = request.getParameter("name");
		String email=request.getParameter("email");
		
		MemberDTO mDTO = new MemberDTO();
		mDTO.setId(id);
		mDTO.setPw(pw);
		mDTO.setName(name);
		mDTO.setEmail(email);
		
		MemberDAO mDAO = MemberDAO.getInstance();
		
		mDAO.MemberInsert(mDTO);
		
		response.sendRedirect("login.do");

		
		
	}

}







