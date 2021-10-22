package Servlet;

import java.io.*;

import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

import DAO.MemberDAO;
import DTO.MemberDTO;


@WebServlet("/login.do")
public class LoginServelt extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		RequestDispatcher dispatcher= request.getRequestDispatcher("login.jsp");
		dispatcher.forward(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String url="index.jsp";

		request.setCharacterEncoding("utf-8");
		
		String id = request.getParameter("id");
		
		String pw = request.getParameter("pw");
		
		MemberDAO mDAO = MemberDAO.getInstance();
		
		MemberDTO mDTO = mDAO.loginMember(id, pw);
		
		if(mDTO == null)

		{
			// 로그인 실패시			url="login.jsp"; 
			request.setAttribute("loginMsg", "아이디 또는 비밀번호가 일치하지 않습니다");
		}
		else
		{	
			// 로그인 성공시
			HttpSession session= request.getSession();
			session.setAttribute("loginUser", mDTO); 
			session.setAttribute("loginUserId", mDTO.getId());
			session.setAttribute("Authority", mDTO.getAuthority());
		}		

		RequestDispatcher dispatcher = request.getRequestDispatcher(url);

		dispatcher.forward(request, response);
	}

	
}







