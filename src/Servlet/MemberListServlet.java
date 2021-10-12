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
		
		
		
		
		request.setAttribute("memberList", list);
		
		
		RequestDispatcher dispatcher= request.getRequestDispatcher("memberList.jsp");
		dispatcher.forward(request, response);	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");

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
		
		
	}
}











