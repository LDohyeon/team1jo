package Servlet;

import java.io.*;
import java.util.*;

import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.text.DateFormat;
import java.text.SimpleDateFormat;

import DAO.MemberDAO;
import DAO.ParagraphDAO;


@WebServlet("/chartTag.do")
public class ChartTagServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		DateFormat simpleDate = new SimpleDateFormat("yyyy-MM-dd");
		
		ParagraphDAO pDAO = ParagraphDAO.getInstance();
		
		String tagDate=simpleDate.format(cal.getTime());
		int htmlXml = pDAO.countTagParagraph("#html/xml",tagDate);
		int java = pDAO.countTagParagraph("#java",tagDate);
		int python = pDAO.countTagParagraph("#python",tagDate);
		int sql = pDAO.countTagParagraph("#sql",tagDate);
		int javascript = pDAO.countTagParagraph("#javascript",tagDate);
		
		List list = new ArrayList();
			
		list.add(0, htmlXml);
		list.add(1, java);
		list.add(2, python);
		list.add(3, sql);
		list.add(4, javascript);
				
		request.setAttribute("list",list);
		
		RequestDispatcher dispatcher= request.getRequestDispatcher("chartTag.jsp");
		dispatcher.forward(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}

}
