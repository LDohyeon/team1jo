package Servlet;

import java.io.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.*;

import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

import DAO.MemberDAO;
import DTO.MemberDTO;

@WebServlet("/AuthorityUpdate.do")
public class AuthorityUpdate extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		String selAuValue = request.getParameter("selAuValue");
		String selAuIdValue = request.getParameter("selAuIdValue");	
		String selAuDay = request.getParameter("selAuDay");
		
		MemberDAO mDAO= MemberDAO.getInstance();
		mDAO.memberListAuthorityUpdate(selAuIdValue,selAuValue);
		String val = "T";
		request.setAttribute("val", val);		
		RequestDispatcher dispatcher= request.getRequestDispatcher("auUpdatePopUp.jsp");
		dispatcher.forward(request, response);	
	}
}
