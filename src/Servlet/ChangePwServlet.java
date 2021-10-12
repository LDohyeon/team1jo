package Servlet;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

import DAO.MemberDAO;
import DTO.MemberDTO;


@WebServlet("/changePw.do")
public class ChangePwServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		RequestDispatcher dispatcher= request.getRequestDispatcher("changePw.jsp");
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//setting
		MemberDAO mDAO=MemberDAO.getInstance();
		request.setCharacterEncoding("utf-8");
		HttpSession session=request.getSession();
		
		//passwords for changing
		String cpw=request.getParameter("cpw");
		String pw2=request.getParameter("pw2");
		
		//current session values
		Object obj=session.getAttribute("loginUser");
		MemberDTO member=(MemberDTO)obj;
		String pw=member.getPw();
		String id=member.getId();
		
		
		//update password
		if(cpw.equals(pw))
		{
			mDAO.MemberPwUpdate(pw2,id);
		}
		
		//update session
		MemberDTO mDTO = mDAO.loginMember(id, pw2);
		session.setAttribute("loginUser", mDTO);
		
		//change page
		response.sendRedirect("pwEnc.do");
	}

}











