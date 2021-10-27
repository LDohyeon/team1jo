package Servlet;

import java.util.*;
import javax.servlet.*;
import java.io.IOException;
import java.time.LocalDate;
import javax.servlet.http.*;
import java.text.DateFormat;
import javax.servlet.annotation.*;
import java.text.SimpleDateFormat;

import DAO.MemberDAO;
import DAO.ParagraphDAO;

import DTO.MemberDTO;

@WebServlet("/chartServlet.do")
public class ChartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		///////////////////////////////정현/////////////////////////////////
		
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		DateFormat simpleDate = new SimpleDateFormat("yyyy-MM-dd");
		String[] ymdDate = new String[3];
		String[] countDate = new String[3];
		
		ymdDate[0]=simpleDate.format(cal.getTime());
		cal.add(Calendar.DATE, -1);
		ymdDate[1]=simpleDate.format(cal.getTime());
		cal.add(Calendar.DATE, -1);
		ymdDate[2]=simpleDate.format(cal.getTime());
		
		MemberDAO mDAO= MemberDAO.getInstance();
		
		for(int i=0; i<ymdDate.length; i++) {
			countDate[i] = mDAO.registerMemberDateCount(ymdDate[i]);
		}
		
		request.setAttribute("ymdDate", ymdDate);
		request.setAttribute("countDate", countDate);
		
		///////////////////////////////지애////////////////////////////////////
		
		//날짜 가져오기
		LocalDate today=LocalDate.now();
		LocalDate yesterday=today.minusDays(1);
		LocalDate twoDaysAgo=today.minusDays(2);
		//날짜 array에 넣기
		String[] date= {today.toString(),yesterday.toString(),twoDaysAgo.toString()};
		request.setAttribute("date",date);
		//글 개수 가져오기
		ParagraphDAO pDAO=ParagraphDAO.getInstance();
		int countT=pDAO.countWritings(date[0]);
		int countY=pDAO.countWritings(date[1]);
		int countTwo=pDAO.countWritings(date[2]);
		//글 개수 array에 넣기
		int[] count={countT,countY,countTwo};
		request.setAttribute("count",count);
		
		///////////////////////////////정현/////////////////////////////////
		
		ParagraphDAO pDAO2 = ParagraphDAO.getInstance();
		int htmlXml = pDAO2.countTagParagraph("#html/xml");
		int java = pDAO2.countTagParagraph("#java");
		int python = pDAO2.countTagParagraph("#python");
		int sql = pDAO2.countTagParagraph("#sql");
		int javascript = pDAO2.countTagParagraph("#javascript");
		
		List list = new ArrayList();	
		list.add(0, htmlXml);
		list.add(1, java);
		list.add(2, python);
		list.add(3, sql);
		list.add(4, javascript);
		
		request.setAttribute("list",list);
	
		RequestDispatcher dispatcher= request.getRequestDispatcher("chart.jsp");
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
	}
}