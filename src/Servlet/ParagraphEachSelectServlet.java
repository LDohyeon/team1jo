package Servlet;

import java.io.*;

import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

import DAO.ParagraphDAO;
import DTO.ParagraphDTO;

@WebServlet("/paragraphEachSelect.do")
public class ParagraphEachSelectServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		int num = Integer.parseInt(request.getParameter("num"));
				
		ParagraphDAO pDAO = ParagraphDAO.getInstance();
		
		ParagraphDTO pDTO = pDAO.ParagraphContents(num);
		
		request.setAttribute("pDTO", pDTO);
		
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("paragraphEachSelect.jsp");
		dispatcher.forward(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}

}
