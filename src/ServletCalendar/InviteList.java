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

@WebServlet("/InviteList")
public class InviteList extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");
		
		String userKey = request.getParameter("userKey");
		GroupDAO gDAO = new GroupDAO();
		List<GroupMemberDTO> list = gDAO.selctInvite(userKey);
		
		request.setAttribute("list", list);
		
		RequestDispatcher dispatcher= request.getRequestDispatcher("CalendarInviteList.jsp");
		dispatcher.forward(request, response);	
	}
}
