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
		int lastPage = 20;

		ParagraphDAO pDAO = ParagraphDAO.getInstance();
		
		int page = pDAO.ParagraphPage();
		
		List<ParagraphDTO> list = pDAO.paragraphList(StartPage, lastPage);
		

		
		request.setAttribute("list", list);
		
		int nOfPages=page/lastPage;
		if(nOfPages%lastPage>0) {
			nOfPages++;
		}
		request.setAttribute("nOfPages",nOfPages);
		request.setAttribute("StartPage", StartPage);
		request.setAttribute("searchFlag", 0);
		
		RequestDispatcher dispatcher= request.getRequestDispatcher("paragraphList.jsp");
		dispatcher.forward(request, response);
		
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		
		
	}

}







