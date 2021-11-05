package ServletCalendar;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DAO.GroupDAO;
import DTO.GroupMemberDTO;

@WebServlet("/groupMemberInviteDenied")
public class groupMemberInviteDenied extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String num = request.getParameter("num");
		GroupMemberDTO gmDTO = new GroupMemberDTO();
		gmDTO.setNum(num);	
		GroupDAO gDAO = GroupDAO.getInstance();
		gDAO.inviteDenied(gmDTO);
		response.sendRedirect("InviteList");
	}
}
/*
RequestDispatcher dispatcher = request.getRequestDispatcher("InviteList");
dispatcher.forward(request, response);*/