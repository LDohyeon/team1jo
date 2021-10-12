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
		

		//검수는 해봤습니다. 자유롭게 써주세요 저 ad 11 는 getParameter로 받은 id name 넣어주시면 됩니다.
		
		//아 그리고 검색창 비어있으면 검색 안 되는 js 안 만드셨더라고요
		//그리고 select option 에서 ==선택== 이어도 안 넘어가게도 해주셔야 돼요 선택하라는 알림창 띄우면 좋을 듯
		
		

		
		
	}
}











