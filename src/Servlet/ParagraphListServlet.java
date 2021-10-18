package Servlet;

import java.io.*;
import java.util.*;

import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

import DAO.ParagraphDAO;
import DTO.ParagraphDTO;


@WebServlet("/paragraphList.do")
public class ParagraphListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		int StartPage = Integer.parseInt(request.getParameter("startPage"));
		int lastPage = 10;
		

		ParagraphDAO pDAO = ParagraphDAO.getInstance();
		
		int page = pDAO.ParagraphPage();//이걸로 페이지 처리 해주시면 됩니다.
		
		System.out.println("paragraphList page : "+ page);
		
		List<ParagraphDTO> list = pDAO.paragraphList(StartPage, lastPage);
		
		request.setAttribute("list", list);
		
		RequestDispatcher dispatcher= request.getRequestDispatcher("paragraphList.jsp");
		dispatcher.forward(request, response);
		
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		
		
	}

}







