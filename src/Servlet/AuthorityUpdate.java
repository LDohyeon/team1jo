package Servlet;

import java.io.*;
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
		request.setCharacterEncoding("utf-8");
		
		String selAuValue = request.getParameter("selAuValue");
		String selAuIdValue = request.getParameter("selAuIdValue");
		
		MemberDAO mDAO= MemberDAO.getInstance();
		mDAO.memberListAuthorityUpdate(selAuIdValue, selAuValue);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}
}
