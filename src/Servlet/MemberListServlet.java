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
		
<<<<<<< HEAD
		int startPage = Integer.parseInt(request.getParameter("startPage"));
		int lastPage = 5;
		
=======
		int startPage= Integer.parseInt(request.getParameter("startPage"));
		int lastPage=20;
		

>>>>>>> branch 'member' of https://github.com/LDohyeon/team1jo.git
		MemberDAO mDAO= MemberDAO.getInstance();
		
		List<MemberDTO> list=mDAO.memberList(startPage, lastPage);
<<<<<<< HEAD
=======
		
		
		int pagebtn= mDAO.memberListPageBtn();
		
		System.out.println("pagebtn : "+ pagebtn);
		
		
		
>>>>>>> branch 'member' of https://github.com/LDohyeon/team1jo.git
		
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
<<<<<<< HEAD
		
		String selSerch1 = request.getParameter("selSerch1"); // 아이디,네임
		String selSerch2 = request.getParameter("selSerch2"); // 권한
		String selValue = request.getParameter("selValue"); // 텍스트값
		
		MemberDAO mDAO= MemberDAO.getInstance();
		
		List<MemberDTO> list1 = mDAO.memberSerachList(selSerch1, selValue);
		List<MemberDTO> list2 = mDAO.memberSerachList(selSerch1, selSerch2, selValue);
		
		RequestDispatcher dispatcher= request.getRequestDispatcher("memberList.jsp");
		dispatcher.forward(request, response);	
=======

		MemberDAO mDAO= MemberDAO.getInstance();
		
		List<MemberDTO> list = mDAO.memberSerachList("ad", "dl");
		

		List<MemberDTO> list2= mDAO.memberSerachList("ad", "dl", "3");//관리자 번호 포함 오버로딩
		
		for(int i=0; i<list2.size(); i++)
		{
			System.out.println("list2 : "+ list2.get(i).getId());
		}
		
		System.out.println("---------------------------");
		
		List<MemberDTO> list3= mDAO.memberSerachList("ad", "dl", "2");
		
		for(int i=0; i<list3.size(); i++)
		{
			System.out.println("list2 : "+ list3.get(i).getId());
		}
		
		
>>>>>>> branch 'member' of https://github.com/LDohyeon/team1jo.git
	}
}