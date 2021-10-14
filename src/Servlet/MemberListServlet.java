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

		//int pagebtn= mDAO.memberListPageBtn(); 이거 안 쓰죠?
		
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
		
		List<MemberDTO> list1 = null;
		int row=0;
	
		
		if(selSerch1.equals("id") && selSerch2.equals("0")) {
			list1 = mDAO.memberIdSerachList(selValue);
			row = mDAO.memberListIdPageBtn(selValue);

		} else if(selSerch1.equals("name") && selSerch2.equals("0")) {
			list1 = mDAO.memberNameSerachList(selValue);
			row = mDAO.memberListNamePageBtn(selValue);
			
		} else if(selSerch1.equals("id") && selSerch2.equals("3")) {
			list1 = mDAO.memberIdSerachList(selValue, selSerch2);
			row = mDAO.memberListIdPageBtn(selValue, selSerch2);
			
		}else if(selSerch1.equals("name") && selSerch2.equals("3")) {
			list1 = mDAO.memberNameSerachList(selValue, selSerch2);//이거 아이디라고 적혀있던데
			row = mDAO.memberListNamePageBtn(selValue, selSerch2);
		}
		
		
		System.out.println("row : "+row);
		request.setAttribute("list1", list1);
		
		
		
//		if(selSerch1.equals("id") && selSerch2.equals("0")) {
//			List<MemberDTO> list1 = mDAO.memberIdSerachList(selValue);
//			request.setAttribute("list1", list1);
//		} else if(selSerch1.equals("name") && selSerch2.equals("0")) {
//			List<MemberDTO> list1 = mDAO.memberNameSerachList(selValue);
//			request.setAttribute("list1", list1);
//		} else if(selSerch1.equals("id") && selSerch2.equals("3")) {
//			List<MemberDTO> list1 = mDAO.memberIdSerachList(selSerch1, selValue);
//			request.setAttribute("list1", list1);
//		}else if(selSerch1.equals("name") && selSerch2.equals("3")) {
//			List<MemberDTO> list1 = mDAO.memberIdSerachList(selSerch1, selValue);
//			request.setAttribute("list1", list1);
//		}
		

		RequestDispatcher dispatcher= request.getRequestDispatcher("memberList.jsp");
		dispatcher.forward(request, response);	
	}
	
}
