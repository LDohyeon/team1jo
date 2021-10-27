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
		
		int num = Integer.parseInt(request.getParameter("num"));
		
		ParagraphDAO pDAO =ParagraphDAO.getInstance();
		ParagraphDTO pDTO = pDAO.ParagraphContents(num);
		
		request.setAttribute("pDTO", pDTO);
		
		RequestDispatcher dispatcher=request.getRequestDispatcher("editor.jsp");
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String title=request.getParameter("title");
		String content=request.getParameter("content");
		int num = Integer.parseInt(request.getParameter("num"));
		
		ParagraphDTO pDTO=new ParagraphDTO();
		pDTO.setTitle(title);
		pDTO.setContents(content);
		pDTO.setNum(num);
		
		ParagraphDAO pDAO=ParagraphDAO.getInstance();
		
		pDAO.paragraphUpdate(pDTO);

		
		response.sendRedirect("paragraphEachSelect.do?num="+num);
		
		
	}

}
