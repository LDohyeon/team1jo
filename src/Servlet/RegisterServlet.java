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
		String au = (String)request.getParameter("au");
		if(au == null){
			RequestDispatcher dispatcher= request.getRequestDispatcher("register.jsp");
			dispatcher.forward(request, response);
		}else if(au.equals("1")){
			request.setAttribute("Authority", au);
			RequestDispatcher dispatcher= request.getRequestDispatcher("registerAdmin.jsp");
			dispatcher.forward(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String au = (String)request.getParameter("au");
		if(au == null){
			String id = request.getParameter("id");
			String pw = request.getParameter("pw");
			String name = request.getParameter("name");
			String email = request.getParameter("email");
			
			MemberDTO mDTO = new MemberDTO();
			mDTO.setId(id);
			mDTO.setPw(pw);
			mDTO.setName(name);
			mDTO.setEmail(email);
			mDTO.setAuthority("2");
			
			MemberDAO mDAO = MemberDAO.getInstance();
			
			mDAO.MemberInsert(mDTO);
			
			response.sendRedirect("login.do");
		}else if(au.equals("1")){
			String id = request.getParameter("id");
			String pw = request.getParameter("pw");
			String name = request.getParameter("name");
			String email = request.getParameter("email");
			String selAuValue = request.getParameter("selAuValue");
			
			MemberDTO mDTO = new MemberDTO();
			mDTO.setId(id);
			mDTO.setPw(pw);
			mDTO.setName(name);
			mDTO.setEmail(email);
			mDTO.setAuthority(selAuValue);
			
			MemberDAO mDAO = MemberDAO.getInstance();
			
			mDAO.MemberInsert(mDTO);
			
			response.sendRedirect("memberList.do?startPage=1");
		}
	}
}







