package Servlet;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

import DTO.MemberDTO;
import DAO.MemberDAO;

@WebServlet("/ChangePw.do")
public class ChangePwServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//setting
		request.setCharacterEncoding("utf-8");
		MemberDAO mDAO=MemberDAO.getInstance();
		
		//passwords for changing
		String cpw=request.getParameter("cpw");
		String pw2=request.getParameter("pw2");
		
		////////////////////////
		System.out.println(cpw);
		System.out.println(pw2);
		////////////////////////
		
		//current session values
		HttpSession session=request.getSession();
		Object obj=session.getAttribute("loginUser");
		MemberDTO member=(MemberDTO)obj;
		String pw=member.getPw();
		String id=member.getId();
		
		////////////////////////
		System.out.println(pw);
		System.out.println(id);
		////////////////////////
		
		//update password
		if(cpw.equals(pw))
		{
			//mDAO.MemberPwUpdate(pw2,id);
		}
		
		//change page
		//RequestDispatcher dispatcher = request.getRequestDispatcher("changePw.jsp");
		//dispatcher.forward(request, response);
	}

}
