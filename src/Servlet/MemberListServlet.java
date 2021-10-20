package Servlet;

import java.io.*;
import java.util.*;

import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

import DAO.MemberDAO;
import DTO.MemberDTO;

@WebServlet("/memberList.do")
public class MemberListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");

		int startPage = Integer.parseInt(request.getParameter("startPage"));
		int lastPage = 5;
		
		MemberDAO mDAO= MemberDAO.getInstance();
		
		List<MemberDTO> list=mDAO.memberList(startPage, lastPage);
		
		int row = mDAO.memberListPageBtn(); 
		
		int totalPage = row/lastPage;
		if(row%lastPage > 0) {
			totalPage++;
		}
		
		request.setAttribute("startPage", startPage);
		request.setAttribute("lastPage", lastPage);
		request.setAttribute("totalPage", totalPage);
		request.setAttribute("memberList", list);
				
		RequestDispatcher dispatcher= request.getRequestDispatcher("memberList.jsp");
		dispatcher.forward(request, response);	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");
		
		String selSerch1 = request.getParameter("selSerch1"); 
		String selSerch2 = request.getParameter("selSerch2"); 
		String selValue = request.getParameter("selValue"); 
		int startPage = Integer.parseInt(request.getParameter("startPage"));
		int lastPage = 5;
		int row=0;
		
		List<MemberDTO> list1 = null;
		MemberDAO mDAO= MemberDAO.getInstance();
					
		if(selSerch1.equals("id") && selSerch2.equals("0")) {
			list1 = mDAO.memberIdSerachList(selValue, startPage, lastPage);
			row = mDAO.memberListIdPageBtn(selValue);
		} else if(selSerch1.equals("name") && selSerch2.equals("0")) {
			list1 = mDAO.memberNameSerachList(selValue, startPage, lastPage);
			row = mDAO.memberListNamePageBtn(selValue);
		
		} else if(selSerch1.equals("id") && selSerch2.equals("1")) {
			list1 = mDAO.memberIdSerachList(selValue, selSerch2, startPage, lastPage);
			row = mDAO.memberListIdPageBtn(selValue, selSerch2);
		} else if(selSerch1.equals("name") && selSerch2.equals("2")) {
			list1 = mDAO.memberNameSerachList(selValue, selSerch2, startPage, lastPage );
			row = mDAO.memberListNamePageBtn(selValue, selSerch2);	
		
		} else if(selSerch1.equals("id") && selSerch2.equals("2")) {
			list1 = mDAO.memberIdSerachList(selValue, selSerch2, startPage, lastPage);
			row = mDAO.memberListIdPageBtn(selValue, selSerch2);
		} else if(selSerch1.equals("name") && selSerch2.equals("2")) {
			list1 = mDAO.memberNameSerachList(selValue, selSerch2, startPage, lastPage );
			row = mDAO.memberListNamePageBtn(selValue, selSerch2);
		
		} else if(selSerch1.equals("id") && selSerch2.equals("3")) {
			list1 = mDAO.memberIdSerachList(selValue, selSerch2, startPage, lastPage);
			row = mDAO.memberListIdPageBtn(selValue, selSerch2);
		} else if(selSerch1.equals("name") && selSerch2.equals("3")) {
			list1 = mDAO.memberNameSerachList(selValue, selSerch2, startPage, lastPage );
			row = mDAO.memberListNamePageBtn(selValue, selSerch2);
		
		} else if(selSerch1.equals("id") && selSerch2.equals("4")) {
			list1 = mDAO.memberIdSerachList(selValue, selSerch2, startPage, lastPage);
			row = mDAO.memberListIdPageBtn(selValue, selSerch2);	
		} else if(selSerch1.equals("name") && selSerch2.equals("4")) {
			list1 = mDAO.memberNameSerachList(selValue, selSerch2, startPage, lastPage );
			row = mDAO.memberListNamePageBtn(selValue, selSerch2);
		}
		

		int totalPage = row/lastPage;
		if(row%lastPage > 0) {
			totalPage++;
		}

		request.setAttribute("startPage", startPage);
		request.setAttribute("lastPage", lastPage);
		request.setAttribute("totalPage", totalPage);
		request.setAttribute("list1", list1);
		
		RequestDispatcher dispatcher= request.getRequestDispatcher("memberList.jsp");
		dispatcher.forward(request, response);	
	}
}