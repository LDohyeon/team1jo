package Servlet;

import java.io.*;

import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

import DAO.MemberDAO;
import DAO.ParagraphDAO;
import DTO.ParagraphDTO;




@WebServlet("/paragraphDelete.do")
public class ParagraphDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		int num=Integer.parseInt(request.getParameter("num"));

		
		ParagraphDAO pDAO=ParagraphDAO.getInstance();
		pDAO.paragraphDelete(num);
		
		

		response.sendRedirect("paragraphList.do?startPage=1");
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}

}
