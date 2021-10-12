package Servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import DAO.MemberDAO;
import DTO.MemberDTO;

@WebServlet("/pwEncServlet.do")
public class PwEncServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//get session
		HttpSession session=request.getSession();
		Object obj=session.getAttribute("loginUser");
		MemberDTO member=(MemberDTO)obj;
		String pw=member.getPw();
		
		System.out.println(pw.length());
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
