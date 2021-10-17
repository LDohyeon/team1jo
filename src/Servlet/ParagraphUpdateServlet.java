package Servlet;

import java.io.*;


import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

import DAO.ParagraphDAO;
import DTO.ParagraphDTO;



@WebServlet("/paragraphUpdate.do")
public class ParagraphUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher dispatcher=request.getRequestDispatcher("paragraphUpdate.jsp");
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String title=request.getParameter("title");
		String content=request.getParameter("content");
		
		System.out.println("update title: "+title);
		System.out.println("update content: "+content);
		
		ParagraphDTO pDTO=new ParagraphDTO();
		pDTO.setTitle(title);
		pDTO.setContents(content);
		
		ParagraphDAO pDAO=ParagraphDAO.getInstance();
		
		pDAO.paragraphUpdate(pDTO);

	}

}
