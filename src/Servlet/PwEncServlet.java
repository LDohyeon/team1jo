package Servlet;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

import DTO.MemberDTO;

@WebServlet("/pwEnc.do")
public class PwEncServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//get session
		HttpSession session=request.getSession();
		Object obj=session.getAttribute("loginUser");
		MemberDTO member=(MemberDTO)obj;
		String pw=member.getPw();
		
		//pw Enc
		char c=pw.charAt(0);
		String str="";
		for(int i=1;i<=(pw.length()-1);i++)
		{
			str+="*";
		}
		String pwEnc=c+str;
		
		//send
		request.setAttribute("pwEnc",pwEnc);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("userInfo.jsp");
		dispatcher.forward(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
