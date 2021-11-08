package Servlet;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

import DAO.MemberDAO;
import DTO.MemberDTO;


@WebServlet("/userInfo.do")
public class UserInfoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		RequestDispatcher dispatcher= request.getRequestDispatcher("pwEnc.do?");
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//setting
		request.setCharacterEncoding("utf-8");
		MemberDAO mDAO=MemberDAO.getInstance();
		HttpSession session = request.getSession();

		//values for changing
		String name=request.getParameter("name");
		String email=request.getParameter("email");
		String id=(String)session.getAttribute("loginUserId");
		Object obj=session.getAttribute("loginUser");
		MemberDTO member=(MemberDTO)obj;
		String pw=member.getPw();
		
		//update user's info
		mDAO.MemberUpdate(name,email,id);
		
		//update session
		MemberDTO mDTO = mDAO.loginMember(id, pw);
		session.setAttribute("loginUser", mDTO);
		
		//change page
		response.sendRedirect("pwEnc.do");
		
	}

}





