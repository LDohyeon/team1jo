package Servlet;

import java.io.*;
import javax.servlet.*;
import java.time.LocalDate;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

import DAO.ParagraphDAO;

@WebServlet("/chart02Servlet.do")
public class Chart02Servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//날짜 가져오기
		LocalDate today=LocalDate.now();
		LocalDate yesterday=today.minusDays(1);
		LocalDate twoDaysAgo=today.minusDays(2);
		//날짜 array에 넣기
		String[] date= {today.toString(),yesterday.toString(),twoDaysAgo.toString()};
		request.setAttribute("date",date);
		
		ParagraphDAO pDAO=ParagraphDAO.getInstance();
		int countT=pDAO.countWritings(date[0]);
		int countY=pDAO.countWritings(date[1]);
		int countTwo=pDAO.countWritings(date[2]);
		//글자 개수 array에 넣기
		int[] count={countT,countY,countTwo};
		request.setAttribute("count",count);
		
		RequestDispatcher dispatcher=request.getRequestDispatcher("paragraphChart.jsp");
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
