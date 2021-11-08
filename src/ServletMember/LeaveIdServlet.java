package ServletMember;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

import DAO.MemberDAO;


@WebServlet("/leaveId.do")
public class LeaveIdServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		RequestDispatcher dispatcher= request.getRequestDispatcher("leaveId.jsp");
		dispatcher.forward(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//setting
		request.setCharacterEncoding("utf-8");
		MemberDAO mDAO=MemberDAO.getInstance();
		
		//get session, id
		HttpSession session=request.getSession();
		String id=(String)session.getAttribute("loginUserId");
		
		//delete member
		mDAO.MemberDelete(id);
		
		//change page
		response.sendRedirect("index.jsp");
	}

}







