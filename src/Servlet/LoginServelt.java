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
		
		request.setAttribute("loginMsg", "아이디 또는 비밀번호가 일치하지 않습니다");
		
		RequestDispatcher dispatcher= request.getRequestDispatcher("login.jsp");
		dispatcher.forward(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

<<<<<<< HEAD
		String url="index.jsp";
		
		
=======
		String url="index.jsp";//���� main.jsp ��� index.jsp�� ��ü 
			
>>>>>>> branch 'member' of https://github.com/LDohyeon/team1jo.git
		request.setCharacterEncoding("utf-8");
		
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		
		MemberDAO mDAO = MemberDAO.getInstance();
		
		MemberDTO mDTO = mDAO.loginMember(id, pw);
		
		if(mDTO == null)
		{
			// 로그인 실패시
			url="login.do";
		}
		else
		{	
			HttpSession session= request.getSession();
			session.setAttribute("loginUser", mDTO);//로그인 성공시
			session.setAttribute("loginUserId", mDTO.getId());
		}		
		response.sendRedirect(url);
	}
<<<<<<< HEAD
	
}






=======
}
>>>>>>> branch 'member' of https://github.com/LDohyeon/team1jo.git
