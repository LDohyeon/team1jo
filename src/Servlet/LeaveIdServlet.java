package Servlet;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

import DAO.MemberDAO;
import DTO.MemberDTO;


@WebServlet("/LeaveId.do")
public class LeaveIdServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//setting
		MemberDAO mDAO=MemberDAO.getInstance();
		
		//get session
		HttpSession session=request.getSession();
		Object obj=session.getAttribute("loginUser");
		MemberDTO member=(MemberDTO)obj;
		String id=member.getId();
		
		///////////////////////
		System.out.println(id);
		//////////////////////
		
		//delete member
		//mDAO.MemberDelete(member);
		
		//change page
		//RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
		//dispatcher.forward(request, response);
	}

}
