package Servlet;

import java.io.*;
import java.util.*;

import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

import DAO.ParagraphDAO;


@WebServlet("/chartTag.do")
public class ChartTagServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		ParagraphDAO pDAO = ParagraphDAO.getInstance();
		
		int htmlXml = pDAO.countTagParagraph("html/xml");
		int java = pDAO.countTagParagraph("java");
		int python = pDAO.countTagParagraph("python");
		int sql = pDAO.countTagParagraph("sql");
		int javascript = pDAO.countTagParagraph("javascript");
		
		List list = new ArrayList();
			
		list.add(0, htmlXml);
		list.add(1, java);
		list.add(2, python);
		list.add(3, sql);
		list.add(4, javascript);
		
		for(int i=0; i<list.size(); i++)
		{
			System.out.println(list.get(i));
		}
		
		
		
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}

}
