package ServletCalendar;

import java.io.IOException;
import java.util.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DAO.GroupDAO;
import DTO.GroupMemberDTO;
import DTO.MemberDTO;

@WebServlet("/InviteList")
public class groupInviteList extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		request.setCharacterEncoding("utf-8");
		
		MemberDTO userKey;
		List<GroupMemberDTO> list;
		
		try {
			userKey = (MemberDTO) request.getSession().getAttribute("loginUser");
			GroupDAO gDAO = new GroupDAO();
			
			list = gDAO.selctInvite(userKey.getId());
			request.setAttribute("list", list);
		}
		catch(Exception e) {
			System.out.println("InviteList Servlet Error:: "+e);
		}
		
		RequestDispatcher dispatcher= request.getRequestDispatcher("CalendarInviteList.jsp");
		dispatcher.forward(request, response);	
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
