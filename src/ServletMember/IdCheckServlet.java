package Servlet;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

import DAO.MemberDAO;


@WebServlet("/idCheck.do")
public class IdCheckServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		
		response.setContentType("text/xml");
		
		String idCheck= request.getParameter("idCheck");
		
		//System.out.println("idCheck = " + idCheck);
		
		MemberDAO mDAO = MemberDAO.getInstance();
		
		int result =mDAO.idCheck(idCheck);
		
		PrintWriter out = response.getWriter();
		out.println(result);
		
		out.close();
		
		
		
	}

}










