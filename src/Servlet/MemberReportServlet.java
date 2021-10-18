package Servlet;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

import DAO.MemberDAO;

@WebServlet("/memberReport.do")
public class MemberReportServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String id = request.getParameter("id");
		int num = Integer.parseInt(request.getParameter("num"));
		
		MemberDAO mDAO= MemberDAO.getInstance();
		
		mDAO.memberReport(id);
		
		request.setAttribute("report", "1");
		
		RequestDispatcher dispatcher= request.getRequestDispatcher("paragraphEachSelect.do?num="+num);
		dispatcher.forward(request, response);
		
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}

}
