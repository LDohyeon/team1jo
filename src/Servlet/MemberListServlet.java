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
		

		int startPage= Integer.parseInt(request.getParameter("startPage"));
		int lastPage=20;
		

		MemberDAO mDAO= MemberDAO.getInstance();
		
		List<MemberDTO> list=mDAO.memberList(startPage, lastPage);

		
		int pagebtn= mDAO.memberListPageBtn();
		
		System.out.println("pagebtn : "+ pagebtn);
		
		
		
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

		
		String selSerch1 = request.getParameter("selSerch1"); // 아이디,네임
		String selSerch2 = request.getParameter("selSerch2"); // 권한
		String selValue = request.getParameter("selValue"); // 텍스트값
		
		MemberDAO mDAO= MemberDAO.getInstance();
		
		List<MemberDTO> list1 = mDAO.memberSerachList(selSerch1, selValue);
		List<MemberDTO> list2 = mDAO.memberSerachList(selSerch1, selSerch2, selValue);
		
		RequestDispatcher dispatcher= request.getRequestDispatcher("memberList.jsp");
		dispatcher.forward(request, response);	


		for(int i=0; i<list2.size(); i++)
		{
			System.out.println("list2 : "+ list2.get(i).getId());
		}

		
		

	}
}