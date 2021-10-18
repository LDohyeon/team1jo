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

/*
public void memberListAuthorityUpdate(String authority,int selAuDay,String selAuIdValue) {
    
    String sql="update member set authority=?, set authorityDay=? where id=?";
    
    Connection conn=null;
    PreparedStatement pstmt = null;
    
    try
    {
       conn=getConnection();
       pstmt=conn.prepareStatement(sql);
       
       pstmt.setString(1, authority);
       pstmt.setInt(2, selAuDay);
       pstmt.setString(3, selAuIdValue);
       pstmt.executeUpdate();   
    }
    catch(Exception e)
    {
       System.out.println("회원 권한 수정 실패"+e);
    }
    finally
    {
       close(conn, pstmt);
    }
 }
*/
/*
 public String getAuthorityDay() {
		return authorityDay;
	}
public void setAuthorityDay(String authorityDay) {
	this.authorityDay = authorityDay;
}
int selAuDay = Integer.parseInt(request.getParameter("selAuDay"));
mDAO.memberListAuthorityUpdate(selAuIdValue,selAuDay,selAuValue);
 */
@WebServlet("/AuthorityUpdate.do")
public class AuthorityUpdate extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		String selAuValue = request.getParameter("selAuValue");
		String selAuIdValue = request.getParameter("selAuIdValue");	
		MemberDAO mDAO= MemberDAO.getInstance();
		mDAO.memberListAuthorityUpdate(selAuIdValue,selAuValue);
		String val = "T";
		request.setAttribute("val", val);		
		RequestDispatcher dispatcher= request.getRequestDispatcher("auUpdatePopUp.jsp");
		dispatcher.forward(request, response);	
	}
}
